# Análise Técnica — Req. 463387

**Título:** Replicação de Comissão Tabela (LTP_COMTB) não propaga para as demais tabelas de preço
**Loja/Empresa:** MRA Auto Peças — LJ 001 — Ribeirão Preto
**Solicitante:** Bruno / Murilo
**Versão do executável na ocorrência:** 379.48.02.30 (13/05/2026)
**Banco de dados:** AUTCOM
**Data da análise:** 2026-09-22

## 1. Contexto de negócio

A tela **Principal > Movimentação de Itens > Ativar Lote de Preços da Entrada de Mercadorias**
permite ajustar, item a item, os valores calculados de um lote de preços gerado a partir de uma
entrada de mercadoria (pedido de compra ou documento fiscal já lançado). Cada item pode ter até 7
tabelas de preço ativas simultaneamente (`VS_strTabPrc`, configurado por empresa), cada uma com seu
próprio conjunto de campos: preço de venda (`LTP_PREVEn`), margem bruta (`LTP_MARBRn`) e comissão de
tabela (`LTP_COMTBn`), todos armazenados na tabela `LOTPRE` (uma linha por item do documento,
`AUTOINCREM` como chave).

O campo de comissão de tabela é rotulado dinamicamente conforme a configuração
`CFGSIS.SIS_CODCFG = 'CFG_PCMPRO'` (Utilização do campo de percentual de acréscimo na composição da
tabela de preço do produto). No banco da MRA Auto Peças, essa configuração está com
`SIS_VALCFG = '3'` para a empresa 001, o que faz o sistema usar o rótulo definido em
`CFGSIS.SIS_CODCFG = 'TCOMTB'` para esse campo (por isso o usuário se refere a ele como "Comissão
Tabela").

Para evitar que o operador precise editar manualmente cada uma das 7 tabelas quando o valor deve
ser igual em todas, a tela de dígito de valor (`frmDigValorLote`, unit `untDigValorLote.pas`)
oferece o checkbox **"Replicar para todas as tabelas"** (`chkReplica`). Esse mecanismo já era usado
sem problemas para os campos de preço de venda e margem bruta.

## 2. Problema relatado

Ao clicar no campo "Comissão Tabela 1" no grid de itens do lote e pressionar `Enter`, abre-se a
tela `frmDigValorLote`. O usuário digita o novo valor e marca "Replicar para todas as tabelas".
Ao confirmar, o sistema não acusa erro, mas **apenas a Tabela 1 recebe o novo valor** — as demais
tabelas ativas do item (no ambiente da MRA, tabelas 2, 3 e 7) permanecem com o valor de comissão
anterior.

O comportamento esperado é que, com a opção marcada, o valor digitado seja gravado em todas as
tabelas de preço ativas do item, exatamente como já ocorre para preço de venda e margem bruta.

## 3. Investigação

### 3.1 Levantamento de dados no ambiente do cliente

Antes de investigar o código, foi consultado o banco AUTCOM do cliente (conexão somente leitura)
para confirmar dois pontos:

- Existência de registros reais de `LOTPRE` no cenário relatado (documento `000000308328`,
  espécie `PD`), confirmando a estrutura de campos por tabela (`LTP_COMTB1`...`LTP_COMTB7`,
  `LTP_PREVE1`...`LTP_PREVE7`, `LTP_MARBR1`...`LTP_MARBR7`, todas com variantes `_ANT`/`_ALT`).
- Valor da configuração `CFGSIS` para `CFG_PCMPRO` na empresa 001:

  ```sql
  SELECT * FROM CFGSIS WHERE SIS_CODCFG = 'CFG_PCMPRO' AND SIS_CODEMP = '001'
  ```

  Resultado: `SIS_VALCFG = '3'` — confirma que o campo em questão é de fato o de comissão de
  tabela (rótulo `TCOMTB`), não o de percentual de acréscimo genérico (que seria `SIS_VALCFG = '2'`
  na mesma rotina).

### 3.2 Localização do mecanismo de replicação no código

A investigação partiu da tela `untDigValorLote.pas` (`frmDigValorLote`), que apenas expõe o
checkbox `chkReplica` — a lógica de replicação em si não está nessa unit, apenas o valor do
checkbox é lido por quem chama a tela.

A busca por `chkReplica` no restante do módulo `movimentacaoitens` levou à unit
`untLotePrecos.pas`, classe `TLotePrecos`, onde `frmDigValor.chkReplica.Checked` é lido em dois
pontos (linhas 5980 e 6044 da versão analisada) e repassado como parâmetro `blnReplicaTabela` para
`pAlterarPrecoMargem` — o método central que aplica a alteração de um campo digitado ao dataset de
itens do lote.

### 3.3 Causa raiz

Dentro de `pAlterarPrecoMargem`, a sub-rotina interna `pRecalculaDados` decide, a cada chamada, se
o valor deve ser propagado para todas as tabelas ativas do item ou gravado apenas na tabela do
campo que originou a edição. Essa decisão era tomada por:

```pascal
blnEPrecoDeVendaOuMargemBruta := (AnsiStartsStr('PREVE', strCamAlt)) Or (AnsiStartsStr('MARBR', strCamAlt));
If blnReplicaTabela And blnEPrecoDeVendaOuMargemBruta Then
Begin
  intCont:= Length(VS_strTabPrc) + 1;   // percorre todas as tabelas ativas
End
Else
  intCont:= 2;                           // só a tabela de origem

for intCont:= 1 to intCont-1 do
Begin
  ...
End;
```

`strCamAlt` contém o nome do campo editado sem o prefixo `LTP_` (ex.: `'COMTB1'`, `'PREVE1'`,
`'MARBR1'`). A variável `blnEPrecoDeVendaOuMargemBruta` só reconhecia como "elegível à replicação
entre tabelas" os campos que começam com `PREVE` ou `MARBR`. O campo de comissão (`COMTB`), embora
também exista uma instância por tabela de preço (`LTP_COMTB1` a `LTP_COMTB7`), **não estava incluído
nessa checagem**.

Consequência: mesmo com `blnReplicaTabela = True` (checkbox marcado), como
`blnEPrecoDeVendaOuMargemBruta` avaliava `False` para `strCamAlt = 'COMTB1'`, `intCont` ficava fixo
em `2`, e o laço `for intCont := 1 to intCont-1` executava uma única iteração — gravando apenas a
tabela de origem (Tabela 1). As tabelas ativas 2, 3 e 7 nunca eram alcançadas, **independentemente**
do estado do checkbox.

Há um segundo ponto, dentro do próprio laço, que seria necessário mesmo que o problema acima fosse
corrigido isoladamente: o remapeamento do nome do campo a cada iteração do laço (para que a
segunda iteração grave em `PREVE2`/`MARBR2`, a terceira em `PREVE3`/`MARBR3`, etc.) também só
existia para `PREVE` e `MARBR`:

```pascal
If blnReplicaTabela And (AnsiStartsStr('PREVE', strCamAlt)) Then
  strCamAlt:= 'PREVE'+IntToStr(intCont);

If blnReplicaTabela And (AnsiStartsStr('MARBR', strCamAlt)) Then
  strCamAlt:= 'MARBR'+IntToStr(intCont);
```

Sem um bloco equivalente para `COMTB`, mesmo que o laço passasse a iterar sobre todas as tabelas
ativas, `strCamAlt` permaneceria fixo em `'COMTB1'` durante todas as iterações — gravando o valor
repetidamente no mesmo campo da Tabela 1, em vez de propagar para `COMTB2`, `COMTB3` etc.

### 3.4 Por que o problema não afetava PREVE/MARBR

A checagem de consistência confirmou que `blnRecCus` (variável que decide se o custo deve ser
recalculado), poucas linhas abaixo, já tratava os três campos de forma simétrica:

```pascal
blnRecCus :=  Not (AnsiStartsStr('PREVE', strCamAlt) Or
                   AnsiStartsStr('MARBR', strCamAlt) Or
                   AnsiStartsStr('COMTB', strCamAlt));
```

Isso reforça que a ausência de `COMTB` no mecanismo de replicação foi uma lacuna de simetria (o
campo foi tratado como "campo de tabela de preço" em outros pontos da mesma rotina, mas ficou de
fora especificamente do gatilho de replicação), e não uma exclusão intencional.

### 3.5 Abordagens consideradas

Não houve abordagem alternativa descartada — a causa raiz era objetiva e a solução natural (tornar
o tratamento de `COMTB` simétrico ao de `PREVE`/`MARBR`, nos dois pontos identificados) foi aplicada
diretamente, sem necessidade de instrumentar log temporário para diagnóstico: a leitura do código já
foi suficiente para confirmar a causa raiz de forma determinística, antes de qualquer alteração.

## 4. Solução aplicada

Na unit `untLotePrecos.pas`, método `TLotePrecos.pAlterarPrecoMargem`, sub-rotina
`pRecalculaDados`:

1. A variável `blnEPrecoDeVendaOuMargemBruta` foi renomeada para
   `blnEPrecoDeVendaOuMargemBrutaOuComissao` (para refletir seu novo escopo) e sua atribuição
   passou a incluir `AnsiStartsStr('COMTB', strCamAlt)`:

   ```pascal
   blnEPrecoDeVendaOuMargemBrutaOuComissao := (AnsiStartsStr('PREVE', strCamAlt))
     Or (AnsiStartsStr('MARBR', strCamAlt))
     Or (AnsiStartsStr('COMTB', strCamAlt));
   ```

2. Foi adicionado o bloco de remapeamento de campo para `COMTB`, logo após o bloco equivalente de
   `MARBR`, dentro do laço `for intCont := 1 to intCont-1`:

   ```pascal
   If blnReplicaTabela And (AnsiStartsStr('COMTB', strCamAlt)) Then
     strCamAlt:= 'COMTB'+IntToStr(intCont);
   ```

Nenhuma outra alteração foi necessária: os blocos de gravação (`fCampo(strCamAlt + '_UTI')...`,
`pAlteraPreco`, `Dataset.Post`) já operam de forma genérica sobre `strCamAlt`, e passaram a
funcionar corretamente para `COMTB` assim que o campo passou a ser corretamente reconhecido e
remapeado a cada iteração.

## 5. Decisões de escopo

- **Incluído:** apenas o campo `LTP_COMTB` (comissão de tabela), que foi o campo efetivamente
  relatado com problema.
- **Excluído deliberadamente:** não foi feita uma varredura em busca de outros campos de `LOTPRE`
  que porventura tenham a mesma limitação de replicação (ex.: campos de desconto financeiro
  `DESF01`..`DESF06`, que também existem apenas na Tabela 1 e não são replicáveis por tabela — mas
  esses não seguem o padrão "um valor por tabela de preço", então não se aplicam a este mecanismo).
  Caso surjam relatos semelhantes para outros campos, a mesma investigação deve ser refeita para
  aquele campo específico.
- **Excluído deliberadamente:** não foi alterada a tela `frmDigValorLote` (`.dfm`) nem sua lógica de
  validação (`untDigValorLote.pas`) — o problema estava inteiramente na camada de aplicação do
  valor (`untLotePrecos.pas`), não na captura do valor digitado pelo usuário.
- Não foi necessário instrumentar log de diagnóstico na rotina: a causa raiz foi confirmada de
  forma determinística por leitura de código antes de qualquer alteração, então a opção de logging
  (cogitada inicialmente como alternativa caso a leitura de código não fosse suficiente) não chegou
  a ser necessária.

## 6. Validação

- Arquivo `untLotePrecos.pas` reaberto e revalidado linha a linha após a edição: decodifica sem
  erro em `cp1252` (Windows-1252) e não contém a sequência de bytes `\xef\xbf\xbd` (indicador de
  corrupção por resave em encoding incorreto).
- Edição realizada exclusivamente via script Python com encoding explícito
  (`io.open(path, encoding='cp1252', newline='')`), nunca por ferramenta de edição de texto
  genérica, conforme padrão do projeto para arquivos `.pas` em encoding legado.
- Estrutura `Begin`/`End` do trecho alterado conferida — nenhum bloco foi adicionado ou removido
  além do necessário; apenas 3 ocorrências da variável renomeada e 2 novas linhas de remapeamento.
- Validação funcional em ambiente de teste ainda **pendente** (ver `tasks.md`, Fase 3): reproduzir
  o cenário exato do cliente (editar Comissão Tabela 1 com replicação marcada, conferir tabelas 2,
  3 e 7) e confirmar que `PREVE`/`MARBR` não sofreram regressão.

## 7. Pontos de atenção para revisão futura

- A condição `strTabPrc := RightStr(strCamAlt, 1)` / `FstrTabPrc := strTabPrc` (usada por
  `FTravarApenasNaTabelaDePrecoAlterada`, mecanismo que restringe efeito a uma única tabela em
  outros fluxos) continua sendo atribuída somente para `PREVE`/`MARBR`, não para `COMTB`. Isso não
  afeta o bug relatado (o comportamento de "travar apenas na tabela alterada" não é acionado neste
  fluxo de replicação — `FTravarApenasNaTabelaDePrecoAlterada` só é setado como `True` a partir de
  um parâmetro explícito de outra chamada, não usada neste caminho), mas fica registrado como
  assimetria remanescente caso um problema semelhante surja envolvendo essa trava especificamente
  para `COMTB`.

## Notas Referenciadas no Código-Fonte

Nenhum comentário explicativo foi adicionado ao código-fonte nesta correção — a alteração é
autoexplicativa por simetria direta com o tratamento já existente para `PREVE`/`MARBR` (mesmo
padrão, mesmo local, mesma estrutura), não havendo necessidade de nota cruzada.
