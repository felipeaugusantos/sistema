# Finalização de NF-e (GER_FNLZDA) em Entrada com Depósito Fechado (Req. 462421)

**Tela(s):** Principal > Movimentação de Itens > Entrada de Mercadorias
**Unit alterada:** `untPcmGer.pas`
**Tabela/Campo:** `GERELE.GER_FNLZDA`
**Cliente/evidência do ticket:** RIOCOLOR GRUPO ITAIPAVA TINTAS — LJ008 PROD CLOUD, contato Daniel, executável
379.48.02.30 (02/06/2026)
**Working copies alteradas:** `379.48.2.30.74.150.45`, `379.48.2.30.74.150`, `379.48.2.30.74.150.100`

## 1. Contexto do problema (requisito)

Requisito 462421: ao realizar uma Entrada de Mercadorias configurada para entrar em outro depósito
(`CFG_ETRAUT = 'S'`, campo `edtCodEmpresa` preenchido no form de dados fiscais/resumo da entrada), a mercadoria não
chega fisicamente na empresa que recebeu a NF-e — ela é transferida para a empresa depósito por meio de uma Nota
Especial de Transferência, gerada automaticamente pelo próprio sistema.

Apesar disso, no fluxo de compras as colunas **"Agendamento de Recebimento"**, **"Recebimento de Agendamento"** e
**"Plano Recebimento"** permaneciam indefinidamente como **"A Realizar"** para essa NF-e, mesmo após a entrada já ter
sido processada e a transferência gerada com sucesso.

Evidência do cliente (empresa logada 015, `CFG_UTIWMS=S`, `CFG_TIPPNT=D`, `CFG_ETRAUT=S`):

| Documento | Papel |
|---|---|
| 000000343947-NF-015-00004450 | NF de Entrada original (depósito fechado) |
| 000000000161-NF-015 | Transferência gerada automaticamente |

## 2. Causa raiz

Essas colunas do fluxo de compras refletem o campo `GERELE.GER_FNLZDA` — quando `'S'`, a NF-e é considerada
finalizada e deixa de aparecer como pendente de agendamento/recebimento.

Existe um único ponto de gravação desse campo no sistema, a função `fBaixaNotaEletronica`
(`padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`), chamada uma única vez no projeto, dentro de
`fConfirmaEntradaMercadorias`, sempre que a entrada possui NF-e vinculada (`strAutEle` preenchido):

```pascal
// untPcmGer.pas — dentro de fConfirmaEntradaMercadorias, bloco "CASO FOR NFE EFETUA A BAIXA"
If Not fEmptyStr(strAutEle) Then
Begin
  If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp, fTemItemX922) Then
  ...
```

Dentro de `fBaixaNotaEletronica`, o campo só era gravado como `'S'` quando o parâmetro booleano recebido era
verdadeiro:

```pascal
If blnX922 Then
  Add('  ,GER_FNLZDA = ' + QuotedStr('S'));
```

Esse parâmetro vinha exclusivamente de `fTemItemX922`, função que identifica itens de **retorno de terceiros**
(CFOP `1922`/`2922`) na entrada. Ou seja, `GER_FNLZDA` só era finalizado nesse único cenário — o cenário de
**Depósito Fechado** (`strEmpresaDeposito` preenchido) nunca disparava a finalização, mesmo a NF-e original já
estando efetivamente encerrada (um novo documento, a nota de transferência, passa a representar a mercadoria).

O parâmetro `strEmpresaDeposito` já trafegava corretamente até esse ponto do código antes desta correção — é o
mesmo valor usado, poucas linhas antes/depois, para suprimir endereçamento, desligar a conferência pós-entrada,
ignorar o agendamento de recebimento e disparar a emissão da Nota Especial de Transferência via
`TEmissaoNotaEspecial.pSetaTransferenciaDepositoFechado`.

## 3. Investigação realizada

1. Levantamento conduzido via `citel-IAArquitectDesenv` a partir de um handoff técnico já detalhado, trazido pelo
   usuário com as dúvidas de análise já resolvidas (fluxo, causa raiz, ponto único de gravação, ausência de outros
   chamadores de `fBaixaNotaEletronica`).
2. Confirmado em código, antes de gerar os artefatos de análise, que o handoff batia com o estado atual do fonte:
   `fBaixaNotaEletronica` é chamada uma única vez no projeto (linha 4979 em `74.150.45`), sua assinatura corresponde
   à declarada, e `strEmpresaDeposito` está em escopo no ponto da chamada.
3. Avaliado (e descartado) renomear `blnX922` no mesmo momento da correção — decisão inicial foi manter o nome
   original para minimizar o diff. Posteriormente, a pedido do usuário, a renomeação foi aplicada mesmo assim (ver
   seção 4).
4. Gerados e aprovados os artefatos de análise (`spec.md`, `plan.md`, `tasks.md`) em `IA\specs\462421\` (cópia
   `74.150.45`) antes de qualquer alteração de código.
5. Após aplicar e validar a correção na cópia `74.150.45`, o usuário solicitou replicar a mesma alteração nas
   working copies irmãs `379.48.2.30.74.150` e `379.48.2.30.74.150.100`. O padrão de código já era idêntico nas
   três cópias (mesma assinatura, mesmo corpo de função), variando apenas o número de linha.
6. Verificado que não existe suite DUnit cobrindo `fBaixaNotaEletronica`/`GER_FNLZDA` — validação funcional é
   manual, replicando o cenário do chamado.

### Abordagens consideradas e descartadas

- **Alterar o comportamento de finalização para entradas sem NF-e vinculada (`strAutEle` vazio):** fora de escopo —
  a chamada a `fBaixaNotaEletronica` só ocorre dentro do bloco que já exige `strAutEle` preenchido; nenhuma mudança
  necessária ali.
- **Criar uma nova função de baixa dedicada ao cenário de depósito fechado:** descartada — a função existente
  `fBaixaNotaEletronica` já cobre exatamente a necessidade (gravação condicional de `GER_FNLZDA`), bastando somar a
  nova condição ao parâmetro já existente.
- **Alterar o form `untEntDadosFiscaisResumo.pas`:** descartada — o campo `edtCodEmpresa` já é validado e propagado
  corretamente até `fConfirmaEntradaMercadorias` como `strEmpresaDeposito`; não havia necessidade de tocar no form.

## 4. Correção aplicada

Na única chamada de `fBaixaNotaEletronica`, o parâmetro que controla a finalização passou a considerar também o
depósito fechado, somado via `Or` à condição já existente de CFOP 1922/2922:

```diff
- If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp, fTemItemX922) Then
+ If Not fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, VS_strCodEmp, fTemItemX922 Or (Not fEmptyStr(strEmpresaDeposito))) Then
```

Em um segundo momento, a pedido do usuário, o parâmetro booleano da função foi renomeado de `blnX922` para
`blnFinalizaGerele`, nas 3 ocorrências (declaração forward, assinatura da função e uso interno), refletindo que ele
agora representa dois cenários de finalização (retorno de terceiros **e** depósito fechado), não apenas o CFOP
1922/2922 original:

```diff
- function fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, strCodEmp: String; blnX922: Boolean = False): Boolean;
+ function fBaixaNotaEletronica(strAutEle, strNumDoc, strEspDoc, strCodEmp: String; blnFinalizaGerele: Boolean = False): Boolean;
  ...
- If blnX922 Then
+ If blnFinalizaGerele Then
    Add('  ,GER_FNLZDA = ' + QuotedStr('S'));
```

A renomeação não altera tipo, valor default nem comportamento do parâmetro — apenas seu nome, nos 3 pontos onde
ele aparece dentro da mesma unit.

### Pontos corrigidos por working copy

| Alteração | 74.150.45 | 74.150 | 74.150.100 |
|---|---|---|---|
| Chamada de `fBaixaNotaEletronica` (soma da condição `Or`) | linha 4979 | linha 5033 | linha 5032 |
| Declaração forward do parâmetro renomeado | linha 601 | linha 612 | linha 612 |
| Assinatura da função (parâmetro renomeado) | linha 10809 | linha 11372 | linha 11316 |
| Uso interno do parâmetro renomeado (`If ... Then`) | linha 10828 | linha 11391 | linha 11335 |

### Método de edição

O arquivo `untPcmGer.pas` usa encoding legado (conforme `.editorconfig` do projeto). A tentativa inicial de
decodificação com `cp1252` falhou (`UnicodeDecodeError` no byte `0x81`, posição fora do mapeamento válido de
cp1252) — o arquivo foi então lido/gravado com `encoding='latin1'` (ISO-8859-1, que aceita todos os 256 valores de
byte sem erro), preservando o byte original sem tentar reinterpretá-lo. A edição foi feita via **Python** em todos
os casos, nunca com a ferramenta de edição direta de texto, para não corromper acentuação do restante do arquivo.

Validação pós-edição em cada uma das 3 working copies:
- Decodifica sem erro em `latin1`.
- Não contém a sequência de bytes `\xef\xbf\xbd` (indício de corrupção UTF-8 gravada por engano dentro de um
  arquivo cp1252/latin1).
- `svn diff` confirmando que apenas as linhas pretendidas (chamada + declaração forward + assinatura + uso
  interno) mudaram em cada cópia — nenhum outro conteúdo dos arquivos foi tocado.

## 5. Escopo e decisões

- **Ponto único de alteração:** confirmado via grep, em cada uma das 3 working copies, que `fBaixaNotaEletronica`
  é chamada uma única vez no projeto — a correção não tem efeito colateral em outros chamadores.
- **Renomeação de `blnX922` para `blnFinalizaGerele`:** inicialmente avaliada e descartada durante o levantamento
  (para minimizar o diff), foi solicitada e aplicada posteriormente pelo usuário, já com a correção funcional em
  produção nas 3 cópias.
- **Aplicação retroativa em 2 working copies irmãs**, além da original `74.150.45`, a pedido do usuário:
  `379.48.2.30.74.150` e `379.48.2.30.74.150.100`.
- **Não alterado** o form `untEntDadosFiscaisResumo.pas` — a propagação de `strEmpresaDeposito` já funcionava
  corretamente.
- **Fora de escopo:** qualquer ajuste nas regras de emissão da Nota Especial de Transferência
  (`TEmissaoNotaEspecial`), que já funcionavam corretamente antes desta correção.

## 6. Ressalvas e achados colaterais

- **Sem suite automatizada** (DUnit) cobrindo `fBaixaNotaEletronica`/`GER_FNLZDA` — validação funcional é manual,
  replicando o cenário do chamado (entrada com NF-e vinculada e depósito fechado informado, empresa 015,
  `CFG_ETRAUT=S`) e consultando `GERELE.GER_FNLZDA` após a confirmação da entrada. Ver `IA\specs\462421\tasks.md`
  (cópia `74.150.45`), Fase 3.
- **Byte fora do mapeamento cp1252** encontrado em `untPcmGer.pas` (byte `0x81`) — não é uma corrupção introduzida
  nesta sessão (o arquivo já continha esse byte antes de qualquer edição), mas é um ponto de atenção para futuras
  edições desse arquivo especificamente: usar `latin1` em vez de `cp1252` ao ler/gravar, já que `cp1252` rejeita
  esse byte com erro de decodificação.
- Nenhum outro achado colateral identificado durante a investigação — chamada única, sem efeitos em outros pontos
  do fluxo de entrada.

## 7. Texto de análise de requisito (registro formal — baixa)

```text
FOI AJUSTADA A ROTINA DE CONFIRMAÇÃO DE ENTRADA DE MERCADORIAS PARA QUE A NF-E VINCULADA SEJA MARCADA COMO
FINALIZADA TAMBÉM QUANDO A ENTRADA FOR DESTINADA A UM DEPÓSITO FECHADO (TRANSFERÊNCIA AUTOMÁTICA ENTRE EMPRESAS), E
NÃO APENAS NO CENÁRIO JÁ TRATADO DE ITENS COM CFOP DE RETORNO DE TERCEIROS (1922/2922).

NO CENÁRIO DE DEPÓSITO FECHADO, A MERCADORIA NÃO PERMANECE FISICAMENTE NA EMPRESA QUE RECEBEU A NF-E ORIGINAL —
ELA É TRANSFERIDA PARA OUTRA EMPRESA/DEPÓSITO POR MEIO DE UMA NOTA ESPECIAL DE TRANSFERÊNCIA, GERADA
AUTOMATICAMENTE PELO PRÓPRIO SISTEMA. COMO A NF-E NÃO ERA MARCADA COMO FINALIZADA NESSE CASO, O FLUXO DE COMPRAS
CONTINUAVA EXIBINDO AS COLUNAS "AGENDAMENTO DE RECEBIMENTO", "RECEBIMENTO DE AGENDAMENTO" E "PLANO RECEBIMENTO"
COMO "A REALIZAR" INDEFINIDAMENTE, MESMO A ENTRADA JÁ TENDO SIDO PROCESSADA E A TRANSFERÊNCIA GERADA.

COM O AJUSTE, AO CONFIRMAR UMA ENTRADA DE MERCADORIAS COM NF-E VINCULADA E DESTINO A DEPÓSITO FECHADO INFORMADO, O
SISTEMA PASSA A MARCAR A NF-E COMO FINALIZADA DA MESMA FORMA QUE JÁ FAZIA PARA OS ITENS DE RETORNO DE TERCEIROS. O
COMPORTAMENTO EXISTENTE PARA ESSE ÚLTIMO CENÁRIO PERMANECE INALTERADO, ASSIM COMO O COMPORTAMENTO DE ENTRADAS SEM
NF-E VINCULADA, QUE NÃO SÃO AFETADAS POR ESTA REGRA.

A GRAVAÇÃO OCORRE NA FUNÇÃO FBAIXANOTAELETRONICA (UNIT UNTPCMGER.PAS), QUE ATUALIZA O CAMPO GERELE.GER_FNLZDA PARA
"S" (NF-E FINALIZADA). O PARÂMETRO QUE CONTROLA ESSA GRAVAÇÃO FOI RENOMEADO DE BLNX922 PARA BLNFINALIZAGERELE, POR
MELHOR REFLETIR SEU PROPÓSITO ATUAL — JÁ QUE PASSOU A REPRESENTAR DOIS CENÁRIOS DE FINALIZAÇÃO (RETORNO DE
TERCEIROS E DEPÓSITO FECHADO), E NÃO APENAS O CFOP 1922/2922.

COM A ALTERAÇÃO, AS COLUNAS DE AGENDAMENTO/RECEBIMENTO DO FLUXO DE COMPRAS DEIXAM DE FICAR PRESAS EM "A REALIZAR"
PARA ENTRADAS COM DESTINO A DEPÓSITO FECHADO, REFLETINDO CORRETAMENTE QUE A NF-E JÁ FOI PROCESSADA E NÃO HÁ MAIS
RECEBIMENTO PENDENTE NA EMPRESA QUE A RECEBEU.

CONTEXTO TÉCNICO (IA):
- Arquivo/unit: padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas. Função chamadora:
  fConfirmaEntradaMercadorias (bloco "CASO FOR NFE EFETUA A BAIXA"). Função alterada: fBaixaNotaEletronica.
- Tabela/campo: GERELE.GER_FNLZDA. Valor 'S' = NF-e finalizada. Chave da UPDATE: GERELE.AUTOINCREM (parâmetro
  strAutEle).
- Mecanismo aplicado: soma via Or, no argumento posicional já existente da chamada de fBaixaNotaEletronica, da
  condição Not fEmptyStr(strEmpresaDeposito) à condição pré-existente fTemItemX922 (itens CFOP 1922/2922). Sem
  alteração de assinatura de função nem introdução de novo parâmetro.
- strEmpresaDeposito é o mesmo parâmetro já usado, no mesmo trecho de fConfirmaEntradaMercadorias, para: suprimir
  endereçamento (fDocumentoGeraEnderecamento retorna False), desligar conferência pós-entrada
  (blnConferenciaDepoisDaEntrada := False), ignorar agendamento de recebimento (fGravaAgendamentoDeRecebimento
  retorna True), forçar Kardex de filial (blnFilKar := True) e disparar
  TEmissaoNotaEspecial.pSetaTransferenciaDepositoFechado — ou seja, já era o sinal usado pelo sistema para
  reconhecer o cenário de depósito fechado; a correção apenas passou a usá-lo também para finalizar GER_FNLZDA.
- edtCodEmpresa (form untEntDadosFiscaisResumo.pas) só fica visível com CFG_ETRAUT='S' e só é editável com
  chkTransfAut marcado; a validação de que a empresa depósito difere da empresa logada já existia antes desta
  correção e não foi tocada.
- Chamada de fBaixaNotaEletronica confirmada única no projeto (grep) nas 3 working copies — sem risco de efeito
  colateral em outros chamadores.
- Renomeação de parâmetro (segunda etapa, a pedido do usuário, após a correção funcional já validada): blnX922 ->
  blnFinalizaGerele, em 3 pontos por working copy (declaração forward, assinatura da função, uso interno "If
  blnFinalizaGerele Then"). Puramente semântica — mesmo tipo (Boolean), mesmo default (False), mesmo
  comportamento.
- Encoding: untPcmGer.pas não decodifica em cp1252 puro — contém um byte 0x81 fora do mapeamento válido de
  cp1252 (UnicodeDecodeError confirmado ao tentar). Usado encoding='latin1' (ISO-8859-1) em leitura e gravação em
  todas as edições desta sessão, que aceita todos os 256 valores de byte sem reinterpretação, preservando o byte
  original intacto. Ponto de atenção para futuras edições deste arquivo específico.
- Validação pós-edição em cada uma das 3 working copies: decodifica sem erro em latin1; sem sequência de bytes
  \xef\xbf\xbd (indício de corrupção UTF-8 dentro de arquivo latin1/cp1252); svn diff conferido linha a linha,
  confirmando que só as linhas pretendidas mudaram.
- Sem suite DUnit cobrindo fBaixaNotaEletronica/GER_FNLZDA — validação funcional pendente é manual, replicando o
  cenário do chamado (NF Entrada 000000343947-NF-015-00004450 -> Transferência 000000000161-NF-015, empresa 015,
  CFG_UTIWMS=S, CFG_TIPPNT=D, CFG_ETRAUT=S). Ver IA\specs\462421\tasks.md (cópia 74.150.45), Fase 3, ainda não
  executada.
- Working copies alteradas (linhas variam por histórico de desenvolvimento diferente entre cópias):
  * 379.48.2.30.74.150.45: chamada linha 4979; declaração forward linha 601; assinatura linha 10809; uso interno
    linha 10828.
  * 379.48.2.30.74.150: chamada linha 5033; declaração forward linha 612; assinatura linha 11372; uso interno
    linha 11391.
  * 379.48.2.30.74.150.100: chamada linha 5032; declaração forward linha 612; assinatura linha 11316; uso interno
    linha 11335.
- Artefatos de análise aprovados antes da implementação: IA\specs\462421\spec.md, plan.md, tasks.md (cópia
  74.150.45) — gerados via skill citel-IAArquitectDesenv a partir de um handoff técnico já detalhado trazido pelo
  usuário, com as dúvidas de análise já resolvidas previamente; a skill não reconduziu uma nova entrevista, apenas
  validou o handoff contra o código atual e apresentou o plano de execução para aprovação.
```

## Referências

- Requisito: 462421
- Artefatos de análise (spec/plan/tasks aprovados antes da implementação):
  `379.48.2.30.74.150.45\IA\specs\462421\spec.md`, `plan.md`, `tasks.md`
- Tabela/campo: `GERELE.GER_FNLZDA`
- Unit alterada: `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`
- Working copies alteradas: `379.48.2.30.74.150.45`, `379.48.2.30.74.150`, `379.48.2.30.74.150.100`
