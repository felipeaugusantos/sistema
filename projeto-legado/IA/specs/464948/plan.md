# Plano de Execução — Req. 464948

**Referência:** spec.md
**Zona:** Legado (`libCartoes/`)

## 1. Abordagem técnica

Porte do r496063 (Req. 449872, Cielo) para PagSeguro e RedeCard, a partir do diff da Cielo com os nomes trocados (`TCieloFuncoes` → `T<Op>Funcoes`). Os trechos que casaram exatamente foram aplicados com conferência de contexto (`fonte_delphi.py aplicar`); os demais foram adaptados pontualmente, com contagem de ocorrências.

| Ponto | Antes | Depois |
|---|---|---|
| `fBaixaDuplicatas` | `Try ... Finally Commit/Rollback` em volta de tudo | `LiberaBatchSQL` + `BatchSQL := TBatchHelper.CreateBatchSQL()`; `Finally` só libera o lote (RedeCard: fecha a transação do `fSetaDupBaixadasRede`) |
| `fGravaCartoes` / `fGravaCartoesSin` | `fIStartTransaction` antes dos ajustes | sem transação no processamento; chamadas de gravação com `..., TBaixaCartoes.BatchSQL` |
| Fim da baixa | `GravaMovBanDeTransferencias` + `MarcarComoConciliado` na transação longa | transação 1: `BatchSQL.Execute` + transferências + commit; transação 2: marcação + commit |
| `pAtualizaDataMovimentobancarioMovCar` | `ExecSQL` | `TBatchHelper.AddQueryToBatch` |
| `untT<Op>BaixaCartoes` | — | `class var FBatchSQL`, `property BatchSQL`, `LiberaBatchSQL`, lote em `GravaMovBanAjustes`/`GravaCadPagAjustes`/`GravaCadPagTaxasNegociacao`, `Initialization`/`Finalization` |

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|---|---|---|
| untTPagSeguroBaixaCartoes | `libCartoes/libCartoesPagSeguro/conciliacao/untTPagSeguroBaixaCartoes.pas` | alterar — porte 449872 + RN05 |
| untPagSeguroBaixaCartoes | `libCartoes/libCartoesPagSeguro/conciliacao/views/untPagSeguroBaixaCartoes.pas` | alterar — porte 449872 + RN01 + RN06 |
| untTRedeCardBaixaCartoes | `libCartoes/libCartoesRedeCard/conciliacao/untTRedeCardBaixaCartoes.pas` | alterar — porte 449872 + RN05 |
| untRedeCardBaixaCartoes | `libCartoes/libCartoesRedeCard/conciliacao/views/untRedeCardBaixaCartoes.pas` | alterar — porte 449872 + RN01/RN02/RN03 + RN06 |
| untTCieloBaixaCartoes | `libCartoes/libCartoesCielo/concilicacao/untTCieloBaixaCartoes.pas` | alterar — RN05 |
| untCieloBaixaCartoes | `libCartoes/libCartoesCielo/concilicacao/views/untCieloBaixaCartoes.pas` | alterar — RN06 |

## 3. Sequência de implementação

1. Aplicar o r496063 adaptado em `untTPagSeguroBaixaCartoes` e `untTRedeCardBaixaCartoes`.
2. Aplicar o r496063 adaptado nas telas de baixa; adaptar à mão:
   - `uses`;
   - variáveis `LExecutaScripts`;
   - blocos finais com transferências (RN01) e marcação por origem (RN02);
   - `fBaixaDuplicatas` (RedeCard: RN03).
3. Conferir contra a Cielo pós-449872: transações (7 abertura / 7 commit / 5 rollback), gravações com lote (14), `LiberaBatchSQL` (3), `AddQueryToBatch` (1).
4. RN05: completar a chamada do `GravaCadPag` em `GravaCadPagTaxasNegociacao` até `ABatchSQL` (3 conciliações).
5. RN06: `FreeAndNilDatasets(LExecutaScripts)` no `finally` de `fGravaCartoesSin` (3 conciliações).

## 4. Conformidade com padrões do projeto

- Zona Legado; segue o padrão já aprovado no 449872 (Cielo).
- Transação via `VS_FuncoesExternas.fIStartTransaction/fICommit/fIRollBack`; rollback condicionado a `EstaEmTransacao`.
- Sem componentes, chamadas ou SQL proibidos pelo pre-commit.
- Fontes em cp1252 / CRLF, conferidos com `fonte_delphi.py conferir --base`.

## 5. Estratégia de testes

- Sem suíte DUnit na `libCartoes`: validação manual, comparando com a versão anterior.
- Casos:
  - baixa analítica e sintética, PagSeguro e RedeCard, arquivo e API;
  - período com transferências;
  - RedeCard `RED_EFIR34` (débito/crédito) e negociação;
  - negociação de recebíveis com taxa (RN05);
  - duração da transação, observada no monitoramento de lock.
- Massa e estorno: ver `IA\specs\445076\plan.md`, seção 5.

## 6. Riscos e mitigação

- Falha depois da transação 1 deixa a baixa gravada sem a marcação → mesmo desenho do 449872; a marcação é reprocessável e não tem FK com outras tabelas.
- Diferenças da PagSeguro/RedeCard em relação à Cielo → comparação rotina a rotina antes do porte; trechos sem equivalente mantidos (RN07).
