# untMovGer

> Unit genérica compartilhada — serve **todo o ERP** (venda, devolução, compra, transferência,
> ajuste). Este documento cobre apenas o que já foi tocado ou consumido por alguma rotina.

## Responsabilidade

Geração dos documentos de movimentação: cabeçalho (`MOVGER`) e itens (`MOVDET`) com suas filhas
(`MOVTRI`, `MOVAUX`, `MOVREF`, `BRIDET`), incluindo toda a lógica fiscal.

## Caminho

`padra_atualizado/fontes/faturamento/untMovGer.pas`

Usada por: Garantia, cadastros, cancelamento, crm, faturamento, genericos, movimentacaoitens,
resumodecaixa, util.

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `fGravaMovGer` (cabeçalho do documento de ajuste) e `fGravaMovDet` (itens), este último com `ABatch` atribuído |

## Regra de adesão — leia antes de mexer

Toda mudança de comportamento aqui entra **por parâmetro com default igual ao de hoje**. Com o
default, venda, devolução, compra e transferência seguem byte a byte no caminho antigo; só quem
passa o parâmetro novo muda.

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `fGravaMovGer` | function | Grava o cabeçalho `MOVGER` e as filhas do cabeçalho (`MOVOBS`, `AUXMOV`, `MOVINF`) | Grava. **Fica fora do lote** — é o pai, tem que existir antes dos filhos |
| `fGravaMovDet` | function | Grava o item `MOVDET` e todas as filhas dele (`MOVTRI`, `MOVAUX`, `MOVREF`, `BRIDET`), com toda a derivação fiscal | Grava, ou acumula no lote quando `ABatch <> Nil` |

### Parâmetro `ABatch: TBatchSQL = Nil` em `fGravaMovDet`

Acrescentado ao fim da lista de parâmetros (e no record `TMovDetParams`). O chamador é dono do ciclo
de vida da instância e do momento do flush; `Nil` significa "não existe acumulador".

Todos os `Post` da função passam por `TBatchHelper.PostOuAcumula(<dataset>, '<TABELA>', ABatch)`:
`MOVDET`, `MOVTRI`, `MOVAUX`, `MOVREF` e `BRIDET`.

**Invariante:** com o lote ativo, **nenhuma** escrita dentro de `fGravaMovDet` pode ficar fora dele.
As filhas têm FK para `MOVDET`; se o pai for adiado e uma filha continuar em `Post` imediato, o
insert da filha falha. Conversão parcial é incorreta, não apenas subótima.

`qryTblMovRef` deixou de ser query anônima (`With fCriaQuery Do`) e passou a ter nome, porque
`PostOuAcumula` precisa da referência do dataset.

### Guardas de chave vazia

Duas consultas rodavam com chave vazia e tinham o resultado descartado logo em seguida — 280
execuções numa rodada de 280 linhas do balanço:

- `strEmpOriLoc := fCampoTabela('IFNULL(MOVTRI.DET_EMPORI,"")', ...)` só roda com `strIncFut`
  preenchido. O `If` seguinte já exigia isso; a variável é reatribuída mais adiante antes de
  qualquer outro uso.
- O teste que dependia de `fRetornaInc_PD` ganhou `(Not fEmptyStr(fRetornaInc_PD)) And` antes de ir
  ao banco: vazio, o teste daria `False` de qualquer forma.

## Pontos de atenção

- **`TMovDetParams` sem `Init`.** Ao passar o record no lugar dos parâmetros posicionais, os defaults
  deixam de vir da declaração da função e passam a vir do record — e record de campo nasce zerado,
  com string `''` e Boolean `False`. Já custou `strGnrOri = 'P'`, `strEntTri = 'N'`,
  `strPegou_ = 'N'` e `blnFilFul = True`, em 8 colunas da `MOVTRI` e 1 da `MOVAUX`. **Não há erro de
  compilação nem de execução** — a rotina roda até o fim e grava valores errados. Qualquer chamada
  que migre para o record corre o mesmo risco.
- A função abre datasets como **molde** (`SELECT * FROM <tabela> WHERE FALSE`) para obter a estrutura
  de campos. Com o lote ativo o `Post` é cancelado, então o dataset serve só de molde — abrir uma vez
  por rodada em vez de por linha é ganho direto de round-trip.
- Nenhuma regra que decide valor de coluna foi alterada pelos requisitos até aqui — só o **momento** e
  a **forma** de envio ao banco.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | Parâmetro `ABatch: TBatchSQL = Nil` em `fGravaMovDet`; todos os `Post` da função passaram a `TBatchHelper.PostOuAcumula`; `qryTblMovRef` deixou de ser query anônima; `uses` de `untTBatchSQL` e `untTBatchSQL.Helper` |
| 2026-08-20 | Req. 456948-B (Parte B) — alterações locais | Guardas de chave vazia antes de `fCampoTabela` (`strIncFut`) e do teste com `fRetornaInc_PD` |
