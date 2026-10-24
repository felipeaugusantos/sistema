# untTypesSistema

> Unit genérica compartilhada. Documenta apenas o que já foi tocado por alguma rotina.

## Responsabilidade

Tipos e records compartilhados pelo ERP desktop — entre eles `TMovDetParams`, o record de
parâmetros de `fGravaMovDet`.

## Caminho

`padra_atualizado/fontes/genericos/untTypesSistema.pas`

## Rotinas que consomem

| Rotina | O que usa daqui |
|--------|-----------------|
| [balanço de estoque](balanco_de_estoque/balanco_de_estoque.md) | `TMovDetParams`, com o campo `ABatch` para acumular o `MOVDET` em lote |

## Tipos (recorte tocado)

### `TMovDetParams`

Record com os parâmetros de [`fGravaMovDet`](untMovGer.md). Campos acrescentados: `ABatch:
TBatchSQL`, `fltSiscomex: Double`, `strChvRef: String`, `strIteRef: String`.

O `Init` do record zera tudo: `ABatch := nil`, `fltSiscomex := 0`, `strChvRef := ''`,
`strIteRef := ''`.

## Pontos de atenção

- **Chamar `Init` antes de usar o record não é opcional.** Ao passar `TMovDetParams` no lugar dos
  parâmetros posicionais, os defaults deixam de vir da declaração da função e passam a vir do
  record — e record de campo nasce zerado, com string `''` e Boolean `False`. Sem `Init`, valores
  como `strGnrOri = 'P'`, `strEntTri = 'N'`, `strPegou_ = 'N'` e `blnFilFul = True` se perdem, e o
  efeito é gravar coluna errada em `MOVTRI` e `MOVAUX`. **Não há erro de compilação nem de
  execução.**
- A unit passou a depender de `untTBatchSQL` e `untTBatchSQL.Helper` por causa do campo `ABatch`.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-08-20 | Req. 456948 (Parte A) — alterações locais | `TMovDetParams` ganhou `ABatch: TBatchSQL = Nil` (mais `fltSiscomex`, `strChvRef`, `strIteRef`) e o `Init` correspondente; `uses` de `untTBatchSQL` e `untTBatchSQL.Helper` |
