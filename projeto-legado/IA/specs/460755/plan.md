# Plano de Execução — Req. 460755

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Trocar o `INNER JOIN DETLOC` por `LEFT JOIN` em `TfrmEntSelItensDevolucao.fGetSQLJoins`, e envolver com `IFNULL`/`COALESCE` toda coluna de `fGetSQLCampos` que hoje depende de `AConsiderarDETLOC` (unitário líquido, `DET_QTDITE`, `QTDORI`, `DET_NUMLOT`, campos fiscais rateados via `fRetCampo`), caindo para o valor original do `MOVDET`/`MOVTRI` quando não houver `DETLOC` correspondente. Isso preserva o comportamento atual para documentos com `DETLOC` e permite que documentos sem `DETLOC` (anteriores à ativação de `UM1LFL`) apareçam na seleção com os valores cheios do documento original.

**Escopo revisado (`TfrmEntMercadorias.pAdicionaItem` fora do escopo):** cogitou-se inicialmente um fallback equivalente para `LOCFIS` em `pAdicionaItem` (cair para `CADLOT.LOT_LOCFIS` quando `LOTLOC` não retornasse valor). Descartado após verificação: no caso real (NF 000000207774), `DET_NUMLOT` vem `NULL` do `MOVDET`, então `strNumLot` chega vazio em `pAdicionaItem` e o fluxo já usa `ITE_LOCFIS` (ramo `fEmptyStr(strNumLot)`) — o ramo `LOTLOC`/`CADLOT` nunca é exercitado por este caso. Além disso, sob `UM1LFL` ativo não há garantia de que `CADLOT.LOT_LOCFIS` (esquema de localização única) reflita corretamente um lote gerido por `LOTLOC` (esquema multi-localização) — o fallback seria especulativo, não verificado. `untEntMercadorias.pas` não é alterado nesta correção.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `TfrmEntSelItensDevolucao.fGetSQLJoins` | `padra_atualizado/fontes/movimentacaoitens/untEntSelItensDevolucao.pas` | alterar |
| `TfrmEntSelItensDevolucao.fGetSQLCampos` | `padra_atualizado/fontes/movimentacaoitens/untEntSelItensDevolucao.pas` | alterar |
| `TfrmEntMercadorias.pAdicionaItem` | `padra_atualizado/fontes/movimentacaoitens/untEntMercadorias.pas` | ~~alterar~~ descartado (ver seção 1) |

## 3. Sequência de implementação

1. Em `fGetSQLJoins` (linha ~632-633): trocar `JOIN DETLOC ON D.AUTOINCREM = DTL_INCDET` por `LEFT JOIN DETLOC ON D.AUTOINCREM = DTL_INCDET`.
2. Em `fGetSQLCampos`:
   - `DET_NUMLOT` (linha ~606): `IIF(AConsiderarDETLOC, 'DTL_NUMLOT', 'D.DET_NUMLOT')` → `IIF(AConsiderarDETLOC, 'IFNULL(DTL_NUMLOT, D.DET_NUMLOT)', 'D.DET_NUMLOT')`.
   - `DET_QTDITE` / `QTDORI` (linhas ~436, ~464): `IIF(AConsiderarDETLOC, 'SUM(DTL_QTDITE)', 'D.DET_QTDITE')` → `IIF(AConsiderarDETLOC, 'IFNULL(SUM(DTL_QTDITE), D.DET_QTDITE)', 'D.DET_QTDITE')`.
   - `UNITARIO_LIQUIDO_DETLOC` (constante, linha ~384): envolver o resultado com `IFNULL(..., UNITARIO_LIQUIDO)` para cair no cálculo padrão quando `SUM(DTL_QTDITE)` for nulo.
   - `fRetCampo` (função interna, linhas ~388-403): quando `AConsiderarDETLOC`, envolver a expressão rateada com `IFNULL(..., <expressão sem DETLOC>)` — mesma lógica do `UNITARIO_LIQUIDO_DETLOC`.
3. `untEntMercadorias.pas` (`pAdicionaItem`): **sem alteração** — investigado e descartado (ver seção 1).
4. Validar manualmente os casos de teste da seção 5 abaixo antes de considerar concluído.

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style, prefixos `unt`/`f`/`p` já usados nas units.
- SQL por concatenação de string com `ParamByName()`/`QuotedStr()` — sem alteração no padrão de construção já existente.
- Sem introdução de `TBitBtn`, `TDBGrid`, `Now()`, `StrToFloat`, `.SetFocus` diretos ou qualquer padrão vetado pelo pre-commit.
- Pre-commit: sem `FOREIGN_KEY_CHECKS`, sem componentes/chamadas proibidos.

## 5. Estratégia de testes

Zona Legado sem infraestrutura de teste automatizado (DUnit) — validação manual roteirizada:

- **Caso 1 — documento sem DETLOC (regressão do bug):** NF 000000207774, empresa 001, cliente 10034715 (Intercores). Esperado: item aparece na seleção com quantidade/lote da venda original; devolução conclui com sucesso.
- **Caso 2 — documento com DETLOC (não regressão):** documento de empresa com `UM1LFL` ativo desde a origem, com registro em `DETLOC`. Esperado: comportamento idêntico ao atual — quantidade, lote e valores fiscais rateados por localização inalterados.
- **Caso 3 — devolução parcial:** documento com alguns itens já devolvidos (`DET_DOCDEV` gravado). Esperado: apenas os itens já devolvidos ficam de fora da lista; os demais aparecem normalmente.
- **Caso 4 — validação fiscal:** conferir que os totais de ICMS/IPI/PIS/COFINS/frete gerados na entrada de devolução do Caso 1 batem com os valores da NF de venda original (proporcionais à quantidade devolvida).

## 6. Riscos e mitigação

- Fallback incorreto em campo fiscal rateado gerando valor fiscal divergente → mitigado pelo Caso 4 de teste.
- Rotinas de relatório/espelho de devolução dependentes de `DETLOC` não mapeadas nesta análise → se identificado durante a implementação, revisitar escopo com o analista.
