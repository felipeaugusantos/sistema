# Plano de Execução — Req. 466694

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica
Em `TNFeXml.fGetIde`, ler `idDest`, `indPres` e `indFinal` somente quando a tag existir (`fExistNode`). Se ausente, decidir pela versão do XML (`fltVersaoXml`, Double): versão que exige a tag → `pIncluiErro` + `Exit(False)`; versão anterior → valor 0. A versão passa a ser lida com `fStrToFloat(AnsiReplaceStr(VarToStr(versao), '.', ','))`.

## 2. Arquivos impactados
| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| untEntNfeXml | `padra_atualizado/fontes/movimentacaoitens/untEntNfeXml.pas` | alterar |

Alterações na unit: campo `fltVersaoXml: Double` (declaração); atribuição da versão após `blnVersao4`; tratamento das três tags em `fGetIde`.

## 3. Sequência de implementação
1. Declarar `fltVersaoXml: Double` junto de `blnVersao4`.
2. Atribuir `fltVersaoXml` com `fStrToFloat` logo após ler `infNFe`, antes de `fGetIde`.
3. `fGetIde`: `idDest` (obrigatória ≥ 4.00); `indPres` e `indFinal` (obrigatórias ≥ 3.10).
4. Validar encoding (sem U+FFFD) e `svn diff` somente com as mudanças pretendidas.

## 4. Conformidade com padrões do projeto
- Legado: Hungarian style (`fltVersaoXml`), nomes sem número de requisito.
- Chamadas: `fStrToFloat`, `pIncluiErro`, `fExistNode`; sem `StrToFloat`/`StrToFloatDef`.
- Encoding cp1252 + CRLF; edição apenas via Python.
- Pre-commit: sem componentes/chamadas/SQL proibidos.

## 5. Estratégia de testes
- Teste manual de importação (Movimentação de Itens > Importação de NF-e) com o XML 2.00 anexado.
- Casos: XML 2.00; XML 3.10 sem `indPres`/`indFinal`; XML 4.00 sem `idDest`; XML 4.00 completo (regressão).

## 6. Riscos e mitigação
- Outras tags ausentes na 2.00 → validar o fluxo completo de importação com o XML anexado.
- `Except` de `fGetIde` silencioso para outros erros → decidir incluir `pIncluiErro` com `E.Message`.
- Replicar a correção nas demais working copies, se aplicável.
- Vazamento de `TXMLDocument` nos `Exit` antecipados da rotina de leitura (agravado pelos novos `Exit(False)` de `fGetIde`) → `Try/Finally` em volta do corpo, e `pMarcaMostrar`/`cdsDiverg` executados no `finally` externo quando a saída ocorre por `Exit` (flag `blnSaiuPorExit`).
