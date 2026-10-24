# Plano de Execução — Req. 461662

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Diagnóstico orientado por instrumentação temporária (`TStopwatch`, log local `temp\log_lotepreco_diag.txt`), em rodadas sucessivas: cada rodada isolou um bloco de código mais estreito que o anterior, guiada pelos resultados da rodada prévia, até localizar a causa raiz do crescimento progressivo. As correções foram aplicadas incrementalmente, cada uma validada por uma nova rodada de log antes de avançar para a próxima hipótese.

Fluxo VCL legado (Delphi Seattle), sem mudança de arquitetura — apenas ajuste pontual de comportamento de datasets (`TUniClientDataSet`) já existentes.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `TLotePrecos` | `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` | alterar (já feito) |

Nenhum outro arquivo/unit foi alterado. `untLotePrecosEfetivacaoCx.pas` foi apenas lido, para confirmar o vínculo `TDataSource` → grid dos datasets `FCdsPrecos1/2/3`.

## 3. Sequência de implementação

1. Instrumentar `pAlterarPrecoMargem` com `TStopwatch` separando `pAtualizaCdsPrecos` do `pSetCDSGrids` explícito no `Finally` → log revelou ~47% do tempo na chamada explícita redundante.
2. Investigar via SVN (`svn blame`/`svn log`/`svn diff -c`) se a chamada redundante tinha origem em correção deliberada de outro bug → confirmado que não (Nota 1, spec.md); remover a chamada explícita de `pSetCDSGrids` em `pAlterarPrecoMargem` (o `pAtualizaCdsPrecos` já a invoca internamente).
3. Dividir `pAtualizaCdsPrecos` em blocos cronometrados (loop de campos vs. `pSetCDSGrids` interno) → confirmou que o crescimento estava dentro de `pSetCDSGrids`, não no tamanho do dataset (`FCdsPrecos.RecordCount` constante em 36).
4. Dividir `pSetCDSGrids` em 4 blocos cronometrados (loop `USGRID`/`SEQUEN`, e os 3 blocos de reatribuição `FCdsPrecos1/2/3`) → crescimento distribuído igualmente entre os 4 blocos, inclusive o loop que não toca em grid.
5. Aplicar `DisableControls`/`EnableControls` ao redor de cada bloco `FCdsPrecos1/2/3` (Nota 2, spec.md) → melhora de ~11-22% no tempo total, mas o loop `USGRID`/`SEQUEN` (não tocado por essa correção) continuou crescendo igual — descartando repaint de grid como causa raiz do crescimento.
6. Investigar `FCdsPrecos.LogChanges` e confirmar (grep) que não há `ApplyUpdates`/`CancelUpdates`/`Delta` em toda a unit para esse dataset → aplicar `FCdsPrecos.LogChanges := False` em `pCriaCdsPrecos` (Nota 3, spec.md).
7. Validar com nova rodada de log: todos os blocos (`ms_loop_usgrid`, `ms_cdsprecos1/2/3`, `ms_loop`, `ms_pSetCDSGrids_interno`) permaneceram estáveis do primeiro ao último item, sem crescimento residual.

## 4. Conformidade com padrões do projeto

- Zona Legado: Hungarian style mantido (`swDiag*`, `strPastaLog`, `intDiv`), prefixos `p`/`f` preservados, sem introdução de interfaces/refatoração de arquitetura.
- `TStopwatch` (`System.Diagnostics`): uso permitido pelo CLAUDE.md do projeto como exceção para medição de duração de operações — mas aqui é **temporário**, deve ser integralmente removido antes do commit final (ver Fase 3 de tasks.md).
- Nenhum componente/chamada proibido introduzido (sem `TDBGrid`/`TClientDataSet`/`TDataSetProvider` novos, sem `Now()`/`StrToFloat` diretos, sem SQL).
- Pre-commit: nenhuma trava do hook SVN é afetada por estas alterações.
- Comentários no fonte seguem o padrão de referência cruzada (comentário curto + `Verificar Nota N - Req. 461662`), com a explicação completa registrada em spec.md, seção "Notas Referenciadas no Código-Fonte".

## 5. Estratégia de testes

- Sem suite DUnit dedicada a este fluxo (`TLotePrecos`/ativação de lote de preços) hoje.
- Validação realizada via log de diagnóstico temporário, comparando tempo por item/bloco em rodadas sucessivas (antes/depois de cada correção), com o mesmo lote de 269 itens em 2 tabelas de preço (MARBR1, MARBR4).
- Validação funcional pendente: reproduzir o cenário original do cliente (Moto Mais, NF com alteração nas 4 tabelas de preço, Zendesk 1655410) em ambiente de homologação/produção, confirmando ausência de travamento e resultado numérico idêntico ao anterior.
- Após remoção da instrumentação de diagnóstico (Fase 3 de tasks.md), repetir uma rodada de teste manual para confirmar que o comportamento (tempo e resultado) não foi afetado pela remoção.

## 6. Riscos e mitigação

- **`LogChanges := False` afetar algum uso não identificado do changelog de `FCdsPrecos`** → mitigado por busca (`Grep`) em toda a unit `untLotePrecos.pas` confirmando ausência de `ApplyUpdates`/`CancelUpdates`/`Delta`/`RevertRecord` para esse dataset. Risco residual: uso fora desta unit não descartado sem busca mais ampla no projeto.
- **Remoção da instrumentação de diagnóstico quebrar a estrutura `Try/Finally`** → mitigado ao remover, revisar cada bloco removido isoladamente e validar por `svn diff` que sobra apenas a lógica de negócio original + as 3 correções permanentes.
- **Correções não testadas ainda no volume real do cliente** → mitigado por acompanhamento do próprio requisito até confirmação do solicitante (Sebastião/Zendesk 1655410).
