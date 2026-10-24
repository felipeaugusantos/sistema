# Análise Técnica — Req. 463909

## 1. Contexto de negócio

O ERP permite transferência de mercadorias entre empresas/lojas do mesmo grupo através de um documento
do tipo **TE** (Transferência entre Empresas). Uma TE pode ser **confirmada** posteriormente em uma
**NF** (nota fiscal) — no caso relatado, o cliente importou o XML da NF de confirmação para poder
vincular a entrada a um pagamento antecipado, recurso que a rotina de "Entrada de Mercadorias
Simplificada - Entre Lojas" não oferece isoladamente para a TE.

O fornecedor de uma entrada por TE é identificado como **fornecedor filial** — um fornecedor que, na
prática, representa outra empresa do mesmo grupo econômico (não um fornecedor externo real). Essa
condição é testada no código através de `Pos(strCodFor, strForFil) > 0`, onde `strForFil` é a lista de
códigos de fornecedores cadastrados como filial, obtida pela função `fRetForFilialTodos()`. Esse mesmo
idioma já é usado em dezenas de pontos de `untPcmGer.pas` para diferenciar o tratamento fiscal/de
estoque de entradas de fornecedor filial (ex.: comentários `// Fornecedor Filial` nas linhas 7000,
11570 e 15051 da cópia `379.48.2.30.74.150.45`).

## 2. Problema relatado (Ticket Zendesk #1681623 / Req. 463909)

Solicitante: Lucas (11) 3887-4131. Cliente: Montanna Distribuidora.

Cenário reproduzido pelo cliente:

1. Emitida a TE 000001006444, saindo da empresa 001 para a empresa 201.
2. A TE foi confirmada em NF (NF 000000241325).
3. Na "Entrada de Mercadorias Simplificada - Entre Lojas", apareceu apenas a TE, mostrando o vínculo
   entre o documento 000001006444-TE e o documento 000000241325-NF.
4. O cliente importou o XML da NF 000000241325 e, no mesmo momento, também foi possível dar entrada na
   TE pela Entrada Simplificada.
5. Na rotina de **Efetivação do Movimento Fiscal**, os dois documentos (TE e NF) ficaram disponíveis
   para efetivação e **ambos foram efetivados**.
6. Resultado: os produtos entraram em **duplicidade no estoque**.

Resultado esperado pelo solicitante: que o Autcom impeça a entrada de um dos dois documentos quando o
outro já tiver sido processado, identificando a correlação TE↔NF e recusando a tentativa por
duplicidade.

## 3. Investigação — causa raiz

A investigação (via exploração de código, `padra_atualizado/fontes/movimentacaoitens/`) identificou que
o vínculo entre TE e sua NF de confirmação **não é uma FK explícita em banco** — não existe tabela tipo
`CADTE`/`MOVTE`/`DOCTOTE`. O vínculo é **inferido por casamento** de campos em `MOVGER` (documento
geral): `GER_NUMDOC` + `GER_SERIE_` + `GER_CODFOR`/`GER_CODEMP`, conforme visto em
`untEntradaSimplificada.pas::fGetSQLField_TEM_EFEITVACAO` (linhas 100-126):

```sql
WHERE MG.GER_NUMDOC = G.GER_NUMDOC
AND MG.GER_ESPDOC = IF(G.GER_ESPDOC="TE", "PD", "NF")
AND MG.GER_SERIE_ = G.GER_SERIE_
AND MG.GER_CODFOR = (SELECT EMP_FORFIL FROM CADEMP WHERE EMP_CODEMP = G.GER_CODEMP)
AND MG.GER_CODEMP = PCG_EMPDES
AND A.AUX_ENTSIM = "S"
AND MG.GER_DTAENT IS NULL
```

Esse casamento (`TEM_EFETIVACAO_FISCAL`) já é usado na tela de Entrada Simplificada para sinalizar
visualmente que um documento já tem seu par pendente de efetivação, mas **não é usado como bloqueio**.

Na tela de **Efetivação do Movimento Fiscal** (`untEntMercadoriasEfetivaMovFiscal.pas::fGetSql`, linhas
156-239) — que foi exatamente onde, no relato do ticket, os dois documentos apareceram disponíveis e
puderam ser efetivados — **não existe nenhum filtro/EXISTS equivalente**. A listagem de pendentes é
simplesmente:

```sql
FROM MOVGER G
...
WHERE G.GER_CODEMP = :CODEMP
  AND G.GER_DTAENT IS NULL
```

Sem checagem de que o "par" TE/NF já esteja igualmente pendente ou já efetivado. Essa é a causa direta
de os dois documentos poderem ser efetivados juntos.

Um padrão real de checagem de duplicidade equivalente já existe em outro fluxo do sistema —
`untEntConferPreNotaWMSDevolucao.pas` (linhas 584, 668, 696, 706, 908, 916, 981, 985) — usando
`AND (AUXMOV.AUX_ENTSIM = "S" OR GER.GER_DTACON IS NOT NULL)` como filtro.

### Causa raiz secundária (a efetivamente corrigida nesta sessão)

Investigando por que a baixa do pedido de compra vinculado à TE/NF podia ficar pendente até a
Efetivação do Movimento Fiscal, foi localizada a function `fConfirmaEntradaMercadorias`, sub-rotina
nested `fBaixaPedidosEntrada` (`untPcmGer.pas`). Essa rotina decide, através da condição:

```pascal
If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) Then
```

se a baixa do pedido de compra (`PD`) vinculado ocorre **imediatamente** na confirmação da entrada, ou
fica **pendente** para `TEfetivaMovimentoFiscal.pEfetiva` executar depois (comentário original já
existente no código, linhas 4681-4682):

```
{FZERADATAENTRADA(VALIDACAOZERADATA): SE TRUE, O DOCUMENTO SERÁ EFETIVADO POSTERIORMENTE E O PEDIDO
 SERÁ BAIXADO NA EFETIVAÇÃO; SE FALSE, É NECESSÁRIO BAIXAR O PEDIDO DE COMPRA, POIS O DOCUMENTO JÁ
 ENTRARÁ EFETIVADO}
```

Para fornecedor filial (caso típico de TE), essa baixa podia ficar pendente, sustentando exatamente a
janela em que TE e NF apareciam simultaneamente passíveis de efetivação — a raiz prática do bug
relatado no ticket, independentemente da ausência de trava na tela de Efetivação (item 3 abaixo, fora
de escopo).

## 4. Abordagens avaliadas

1. **Adicionar `OR (Pos(strCodFor, strForFil) > 0)` solto à condição** — primeira tentativa. Descartada
   porque forçaria baixa imediata para **qualquer** fornecedor filial, inclusive em ramos que já têm
   lógica própria e correta para decidir o momento da baixa (ex.: o ramo
   `blnConferenciaDepoisDaEntrada and blnUtilizarCFG_CLARET`, que tem sua própria condição logo abaixo
   na mesma function). Um `OR` solto alteraria esse comportamento sem necessidade, fora do escopo do
   requisito.
2. **Condicionar a nova cláusula ao próprio indicador de baixa pendente** — abordagem adotada:
   `OR ( fZeraDataEntrada(ValidacaoZeraData) and (Pos(strCodFor, strForFil) > 0) )`. Restringe o efeito
   exclusivamente ao cenário em que a baixa ficaria pendente E o fornecedor é filial, sem tocar nos
   demais ramos.
3. **Corrigir a listagem/trava na tela de Efetivação do Movimento Fiscal**
   (`untEntMercadoriasEfetivaMovFiscal.pas`/`untEfetivaMovimentoFiscal.pas`) — identificada como
   correção complementar válida (replicando o padrão já usado em
   `untEntConferPreNotaWMSDevolucao.pas`), mas **deliberadamente excluída do escopo** deste requisito
   após confirmação com o usuário. Ver seção 6.

## 5. Solução aplicada

Arquivo: `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`
Função: `fConfirmaEntradaMercadorias` → nested function `fBaixaPedidosEntrada`

**Nas cópias com `fZeraDataEntrada`** (`379.48.2.30.74.150.45`, `379.48.2.30.74.150`,
`379.48.2.30.74.150.100`, `74.Fechadas/74.150.100.Fechadas/379.48.2.30.74.150.100.12`):

```pascal
// Antes
If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) Then

// Depois
{ FZERADATAENTRADA(VALIDACAOZERADATA) for vdd e fornecedor filial, será feito a baixa do pedido de
  compra no ato da entrada, Nota 1 - req 463909}
If (Not fZeraDataEntrada(ValidacaoZeraData)) or (blnGarantia) or
   ( fZeraDataEntrada(ValidacaoZeraData) and (Pos(strCodFor, strForFil) > 0) ) Then
```

**Na cópia `74.Fechadas/74.150.Fechadas/379.48.2.30.74.150.48`** (versão anterior à refatoração que
introduziu `fZeraDataEntrada` nas demais cópias — aqui a mesma decisão é tomada por
`blnConferenciaDepoisDaEntrada`, atribuída em `blnConferenciaDepoisDaEntrada :=
fConferenciaDepoisDaEntrada And (Not fEmptyStr(strAutEle)) And fEmptyStr(strEmpresaDeposito);`):

```pascal
// Antes
If (Not blnConferenciaDepoisDaEntrada) or (blnGarantia) Then

// Depois
{ BLNCONFERENCIADEPOISDAENTRADA for vdd e fornecedor filial, será feito a baixa do pedido de compra
  no ato da entrada, Nota 1 - req 463909}
If (Not blnConferenciaDepoisDaEntrada) or (blnGarantia) or
   (blnConferenciaDepoisDaEntrada and (Pos(strCodFor, strForFil) > 0)) Then
```

`strForFil` e `strCodFor` já estavam no escopo da nested function em todas as cópias (variável local e
parâmetro, respectivamente, da function externa `fConfirmaEntradaMercadorias`), não foi necessário
alterar assinatura de nenhuma function.

### Detalhe de implementação — encoding do arquivo

Uma tentativa inicial de ler o arquivo inteiro como `cp1252` (regra padrão do projeto para fontes
Delphi) falhou com `UnicodeDecodeError` (byte `0x81`, indefinido em cp1252, encontrado em outro ponto do
arquivo). Investigando os comentários acentuados já existentes na mesma function (`"SERÁ EFETIVADO"`,
`"NECESSÁRIO"`), foi constatado que os acentos ali estão codificados em **UTF-8** (`Á` = bytes `0xC3
0x81`), não em cp1252 — ou seja, este arquivo específico **não é cp1252 puro**, apesar do
`.editorconfig` do projeto declarar `latin1` para fontes `.pas`. Por esse motivo, toda edição foi feita
por **substituição binária direta** (bytes ASCII/UTF-8 exatos, sem decodificar/recodificar o arquivo
inteiro), preservando 100% dos bytes fora da região alterada. O comentário inserido nesta correção foi
ajustado para usar a mesma codificação UTF-8 do restante da function (`á` = `0xC3 0xA1`) — uma primeira
tentativa com byte cp1252 (`0xE1`) havia deixado o comentário ilegível no editor do usuário
("ser<?> f" em vez de "será f").

## 6. Decisões de escopo

- **Incluído:** ajuste em `fBaixaPedidosEntrada` (`untPcmGer.pas`) para antecipar a baixa do pedido de
  compra de fornecedor filial quando ela ficaria pendente para a efetivação.
- **Excluído deliberadamente:** trava/filtro em `untEntMercadoriasEfetivaMovFiscal.pas::fGetSql` e/ou
  `untEfetivaMovimentoFiscal.pas::pEfetiva` para impedir listar/efetivar o par TE/NF simultaneamente.
  Discutido explicitamente com o usuário, que confirmou manter o escopo apenas na baixa antecipada do
  pedido de compra por ora.
- **Excluído:** qualquer alteração na rotina de Entrada Simplificada (`untEntradaSimplificada.pas`) e
  criação de vínculo explícito (FK) entre TE e NF de confirmação em banco de dados.

## 7. Achados colaterais (não corrigidos nesta sessão)

- A tela de Efetivação do Movimento Fiscal não tem nenhuma proteção contra listar/efetivar
  simultaneamente o par TE/NF de confirmação (ver seção 3). Continua sendo uma exposição residual a
  duplicidade em cenários que não envolvam fornecedor filial com baixa pendente de pedido de compra
  (ex.: entradas sem pedido de compra vinculado, ou onde a baixa já ocorreu por outro motivo antes da
  efetivação). Recomenda-se avaliar como requisito futuro, usando como modelo o filtro já existente em
  `untEntConferPreNotaWMSDevolucao.pas`.
- `untFluxoCompras.pas` e `untProcessoCompras.pas` também usam o mesmo padrão de casamento
  TE↔NF/PD via `AUXMOV`/`PCMGER` (`PCG_EMPDES`, `PCG_ORIGND`/`PCG_ORIGES`/`PCG_ORIGEP`) e podem conter a
  lógica "canônica" de vínculo entre pedido/TE/NF — não investigado em profundidade nesta sessão, pode
  ser referência útil caso a correção da seção 3 seja implementada futuramente.

## 8. Escopo de aplicação (working copies)

| Working copy | Linha da condição alterada | Variante |
|---|---|---|
| `379.48.2.30.74.150.45` | ~4683 (antes do comentário) | `fZeraDataEntrada` |
| `379.48.2.30.74.150` | ~4725 | `fZeraDataEntrada` |
| `379.48.2.30.74.150.100` | ~4724 | `fZeraDataEntrada` |
| `74.Fechadas/74.150.100.Fechadas/379.48.2.30.74.150.100.12` | ~4694 | `fZeraDataEntrada` |
| `74.Fechadas/74.150.Fechadas/379.48.2.30.74.150.48` | ~4457 | `blnConferenciaDepoisDaEntrada` (versão anterior) |

## 9. Estratégia de testes

Não há suite DUnit automatizada cobrindo este fluxo (baixa de pedido de compra na confirmação de
entrada). Validação prevista é funcional/manual:

1. Emitir TE de empresa origem para empresa destino com fornecedor configurado como filial.
2. Confirmar a TE em NF (importação de XML) na empresa destino.
3. Dar entrada em um dos documentos (TE ou NF) via Entrada Simplificada.
4. Verificar que o pedido de compra vinculado já foi baixado no momento da entrada (não aparece mais
   pendente de baixa na Efetivação do Movimento Fiscal).
5. Verificar que a entrada do documento remanescente não gera duplicidade de estoque.
6. Validar adicionalmente outros fluxos de entrada de fornecedor filial (não relacionados a TE/NF) para
   confirmar ausência de regressão, especialmente cenários com `blnConferenciaDepoisDaEntrada`/CFG_CLARET.

## Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`
**Função/Procedure:** `fConfirmaEntradaMercadorias` → nested function `fBaixaPedidosEntrada`

A condição que decide se a baixa do pedido de compra vinculado ao documento de entrada ocorre
imediatamente ou fica pendente para a rotina de Efetivação do Movimento Fiscal foi estendida com uma
cláusula adicional. Essa cláusula é condicionada ao próprio indicador que sinaliza que a baixa ficaria
pendente (`fZeraDataEntrada(ValidacaoZeraData) = True` nas cópias mais novas; `blnConferenciaDepoisDaEntrada
= True` na cópia `379.48.2.30.74.150.48`, anterior à refatoração que introduziu `fZeraDataEntrada`) **e**
ao fornecedor da entrada ser do tipo filial (`Pos(strCodFor, strForFil) > 0`).

A cláusula foi deliberadamente escrita como `(indicador de baixa pendente) AND (fornecedor filial)` — e
não como um `OR (fornecedor filial)` solto anexado à condição existente — para restringir o efeito
exclusivamente ao cenário em que a baixa ficaria pendente pela regra padrão. Um `OR` solto forçaria
baixa imediata do pedido de compra para **todo** fornecedor filial, inclusive em ramos da mesma function
que já têm lógica própria e correta para decidir o momento da baixa (por exemplo, o ramo seguinte,
`If (blnConferenciaDepoisDaEntrada and blnUtilizarCFG_CLARET) and (Not blnGarantia) Then`, que trata
especificamente o cenário de conferência pós-entrada com CFG_CLARET). Alterar esse ramo também não fazia
parte do escopo do requisito 463909, e o `OR` solto teria esse efeito colateral não desejado.

Sem essa condição, a baixa do pedido de compra vinculado a uma entrada de fornecedor filial (típico de
TE) podia ficar pendente para ser realizada posteriormente por `TEfetivaMovimentoFiscal.pEfetiva`. Essa
janela — pedido de compra ainda não baixado, documento ainda não efetivado — é justamente o que permitia
que a TE e sua NF de confirmação ficassem simultaneamente disponíveis para efetivação na tela de
Efetivação do Movimento Fiscal e fossem efetivadas juntas, causando a duplicidade de estoque relatada no
ticket. Ao forçar a baixa já no momento da confirmação da entrada nesse cenário específico, essa janela
deixa de existir para o caso relatado.

Se este comentário/condição for removido ou "limpo" em uma revisão futura sem entender esse raciocínio,
o bug de duplicidade de estoque relatado no Req. 463909 (TE 000001006444 / NF 000000241325, cliente
Montanna Distribuidora) volta a ser reproduzível para entradas de fornecedor filial cuja baixa de pedido
de compra seria normalmente deferida para a efetivação.
