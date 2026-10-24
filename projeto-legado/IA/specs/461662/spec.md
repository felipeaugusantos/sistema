# Especificação — Req. 461662

**Título:** Lentidão e travamento do AutCom ao ativar lote de preços da entrada de mercadorias
**Objetivo:** Eliminar a demora de 3 a 4 minutos por tabela de preço (das 4 tabelas de preço) durante a alteração/replicação de preço em lote, que em determinado momento faz o AutCom parar de responder e fechar sozinho.
**Zona:** Legado
**Data:** 2026-09-11

Continuação do Req. 460063 (mesma tela/fluxo, cliente Moto Mais, Zendesk 1655410).

## 1. Contexto / problema atual

Na tela de ativação de lote de preços da entrada de mercadorias, ao alterar o valor de uma das quatro tabelas de preço para um item, `TLotePrecos.pAlterarPrecoMargem` recalcula o item e, quando marcado para replicar, dispara `pReplicaPrecoParaItens` para todos os demais itens do grupo — via `TfrmGravando`/`Application.ProcessMessages` (correção já aplicada no Req. 460063 para evitar a tela "não responde" durante o loop).

Mesmo com essa mitigação, o cliente relatou que cada tabela de preço levava 3-4 minutos para processar em lotes com muitos itens, e que em determinado momento o AutCom travava com tela branca e fechava sozinho — sugerindo que, além da UI travar, havia um problema de performance real crescendo ao longo do processamento, não só falta de `ProcessMessages`.

Diagnóstico via log temporário (`TStopwatch`, arquivo local `temp\log_lotepreco_diag.txt`, nunca commitado) instrumentando `pAlterarPrecoMargem`, `pAtualizaCdsPrecos` e `pSetCDSGrids` revelou três causas sobrepostas, medidas em rodadas sucessivas com um lote real de 269 itens em duas tabelas (MARBR1, MARBR4):

1. **Chamada redundante de `pSetCDSGrids`** — `pAlterarPrecoMargem` chamava `pSetCDSGrids` explicitamente no `Finally`, mas `pAtualizaCdsPrecos` (chamado imediatamente antes) já invoca `pSetCDSGrids` internamente. Essa segunda chamada consumia ~47% do tempo total por item.
2. **Repaint de grid a cada reatribuição de dataset** — `pSetCDSGrids` reatribui `FCdsPrecos1/2/3.Data`/`.Filter`/`.Filtered`/`.IndexFieldNames` (os `TUniClientDataSet` ligados aos grids visíveis `dbgPrecos`/`dbgPrecos2`/`dbgPrecos3` em `untLotePrecosEfetivacaoCx.pas`, via `TDataSource`) sem suspender os controles antes, ao contrário do que já era feito para `FCdsPrecos` em `pAtualizaCdsPrecos`.
3. **Causa raiz do crescimento progressivo ao longo da sessão** — `FCdsPrecos` (`TUniClientDataSet`, 100% em memória, criado via `CreateDataSet`, nunca gravado via `ApplyUpdates`/`CancelUpdates`) mantinha o changelog interno (`LogChanges`) ligado por padrão. Cada `Edit`/`Post` (executado repetidamente a cada item processado, inclusive dentro do loop de `USGRID`/`SEQUEN` em `pSetCDSGrids`) acumulava esse changelog indefinidamente ao longo da sessão, tornando cada novo `Post` progressivamente mais lento — mesmo com `FCdsPrecos.RecordCount` permanecendo constante em 36 linhas durante todo o processamento (confirmado nos 543 registros de log). Esse foi o mecanismo que explicava por que a demora crescia de tabela para tabela dentro da mesma sessão de uso, até o ponto relatado pelo cliente de travamento.

O item que dispara a replicação (chamada "original") também gerava um pico isolado de 19-42 segundos no log — investigado e confirmado como **artefato da própria instrumentação de diagnóstico**, não uma quarta causa: o `ShowModal` do `TfrmGravando` é síncrono, então o tempo total medido da chamada original inclui, dentro de si, a soma do tempo de todas as chamadas recursivas feitas pelo loop de replicação. Não requer correção — só não deve ser interpretado como uma trava adicional.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (lote de preços / ativação de lote de preços da entrada de mercadorias)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` (classe `TLotePrecos` — `pAlterarPrecoMargem`, `pAtualizaCdsPrecos`, `pSetCDSGrids`, `pCriaCdsPrecos`)
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecosEfetivacaoCx.pas` (tela — apenas consultada, para confirmar o vínculo `TDataSource`/grid de `FCdsPrecos1/2/3`; não alterada)
- Entidades: `FCdsPrecos`/`FCdsPrecos1/2/3` são datasets 100% em memória (metadados de exibição de preço, 36 linhas fixas — não é uma tabela de banco por item). Nenhuma tabela de banco é criada/alterada.

## 3. Requisitos funcionais

- RF01 — A alteração de preço/margem em uma tabela e sua replicação para os demais itens do grupo deve concluir sem crescimento progressivo de tempo por item ao longo da sessão (tempo por item deve permanecer estável do primeiro ao último item processado).
- RF02 — O AutCom não deve travar ("não responde") nem fechar sozinho durante o processamento de lotes com grande quantidade de itens, em nenhuma das quatro tabelas de preço.
- RF03 — Os valores finais calculados (preço, margem, campos derivados) devem permanecer idênticos aos do comportamento atual — a mudança é de performance, não de regra de cálculo.

## 4. Regras de negócio

- RN01 — Nenhuma regra de cálculo de preço/margem é alterada (`pAlteraPreco`, `pAjustaPrecos`, `pRecalculaDados` permanecem inalterados).
- RN02 — `FCdsPrecos`/`FCdsPrecos1/2/3` continuam sendo datasets de exibição em memória; a mudança de `LogChanges` não afeta o conteúdo que é exibido/filtrado por `USGRID`/`SEQUEN`.

## 5. Requisitos técnicos / não-funcionais

- Performance: eliminar crescimento O(sessão) no custo de `pSetCDSGrids`/`pAtualizaCdsPrecos` por chamada.
- Sem impacto em transação/auditoria — `FCdsPrecos` nunca é persistido via `ApplyUpdates`/`CancelUpdates`, então desligar `LogChanges` não afeta nenhuma gravação em banco.
- Sem impacto em permissões.
- Sem impacto fiscal/financeiro direto — valores calculados permanecem os mesmos.
- Encoding do arquivo `.pas` alterado: Windows-1252 (cp1252) + CRLF — preservado (todas as edições feitas via Python com encoding explícito, validadas sem corrupção a cada etapa).
- `TStopwatch` (`System.Diagnostics`) usado apenas como instrumentação temporária de diagnóstico — deve ser integralmente removido antes do commit final (ver tasks.md, Fase 3).

## 6. Critérios de aceitação

- [x] Com um lote de 269 itens em uma tabela de preço, o tempo de processamento não cresce progressivamente do primeiro ao último item (validado por log: blocos que antes cresciam de 0ms a 25-49ms permaneceram estáveis em 0-6ms após a correção).
- [x] Tempo total do lote de 269 itens caiu de ~77s (pior tabela, antes de qualquer correção) para ~19s (mesma tabela, após as 3 correções) — sem sinal de crescimento residual.
- [x] Validado em ambiente do cliente (Moto Mais) com o volume real de itens da nota fiscal relatada — testado OK.
- [x] Após remoção da instrumentação de diagnóstico, reexecutado o mesmo cenário e confirmado que o comportamento (tempo e resultado) se mantém.

## 7. Fora de escopo

- Qualquer alteração na lógica de cálculo de preço/margem (`pAlteraPreco`, `pAjustaPrecos`, `pRecalculaDados`, `fValidaMargemDataSet`).
- Otimização de outros pontos do sistema que também usem `TUniClientDataSet`/`TClientDataSet` com `LogChanges` ligado sem necessidade — fora do escopo deste requisito (poderia ser um requisito técnico à parte).
- A mitigação de UI já aplicada no Req. 460063 (`TfrmGravando` + `Application.ProcessMessages` em `pReplicaPrecoParaItens`) não é alterada aqui, apenas se beneficia da redução de tempo por chamada.

## 8. Dependências e riscos

- Depende de `FCdsPrecos`/`cdsPrecos1/2/3` realmente nunca serem gravados via `ApplyUpdates`/`CancelUpdates`/`Delta`/`RevertRecord` em nenhum ponto do sistema — confirmado por busca em **todo** `padra_atualizado/fontes/` (não só na unit alterada): zero ocorrências desses métodos sobre esses datasets, zero ocorrências de `Modified`/`ChangeCount`/`UpdateStatus` (que dependeriam do changelog ativo para funcionar), e apenas 2 arquivos em todo o projeto referenciam esses datasets — `untLotePrecos.pas` (onde são criados/populados) e `untLotePrecosEfetivacaoCx.pas` (onde o único uso é vínculo a `TDataSource` para exibição em grid e comparação de identidade num handler de desenho de célula). Risco descartado.
- Risco: instrumentação de diagnóstico (`pLogDiag*`, `swDiag*`) ainda presente no fonte — precisa ser removida por completo antes do commit, sem quebrar a estrutura `Try/Finally` das rotinas envolvidas.

## Notas Referenciadas no Código-Fonte

### Nota 1 — `untLotePrecos.pas`, `pAlterarPrecoMargem` (Finally)

A chamada explícita de `pSetCDSGrids` dentro do `Finally` de `pAlterarPrecoMargem` foi removida por ser redundante: `pAtualizaCdsPrecos` (chamado na linha imediatamente anterior, dentro do mesmo `Finally`) já invoca `pSetCDSGrids` internamente, ao final de seu próprio corpo (`With FCdsPrecos Do Begin ... pSetCDSGrids; EnableControls; ... End`). Isso foi confirmado via investigação histórica no SVN: `svn blame -r489810` mostrou que as duas chamadas (a interna, dentro de `pAtualizaCdsPrecos`, e a explícita/redundante, em `pAlterarPrecoMargem`) apontam para a mesma revisão de origem, `r207442` (william.gama, 16/01/2020, Req. 141958). O `svn diff -c 207442` confirmou que esse único commit criou a própria procedure `pSetCDSGrids`, adicionou sua chamada interna dentro de `pAtualizaCdsPrecos` **e** adicionou a chamada explícita (redundante) em `pAlterarPrecoMargem` — tudo como parte da introdução da funcionalidade de exibição em 2-3 grids de preço. A revisão seguinte que tocou o bloco (`r489811`, Req. 455251) apenas reindentou o código, sem relação com a duplicação. Ou seja: a chamada redundante foi uma duplicação por descuido no momento de criação da funcionalidade, não uma correção deliberada posterior para outro problema — seguro remover.

Diagnóstico via log mostrou essa segunda chamada consumindo ~47% do tempo total de `pAlterarPrecoMargem` por item antes da remoção.

### Nota 2 — `untLotePrecos.pas`, `pSetCDSGrids`

Os três blocos de reatribuição (`FCdsPrecos1.Data := FCdsPrecos.Data`, `.Filtered`, `.Filter`, `.IndexFieldNames`, e o mesmo para `FCdsPrecos2`/`FCdsPrecos3`) foram envolvidos em `DisableControls`/`EnableControls` (com `Try/Finally`) porque `FCdsPrecos1/2/3` são os datasets diretamente ligados, via `TDataSource` (`dtsPrecos`, `dtsPrecos2`, `dtsPrecos3` em `untLotePrecosEfetivacaoCx.pas`), aos grids visíveis `dbgPrecos`/`dbgPrecos2`/`dbgPrecos3` (`TDBGridCitel`) na tela de ativação de lote de preços. Sem suspender os controles, cada reatribuição de `.Data`/`.Filter`/`.IndexFieldNames` disparava um repaint completo dos 3 grids a cada chamada de `pSetCDSGrids` (chamada uma vez por item processado). Essa correção reduziu o tempo médio desses blocos em ~30-40%, mas não eliminou o crescimento progressivo ao longo da sessão — esse crescimento tinha uma causa diferente e mais relevante, documentada na Nota 3.

### Nota 3 — `untLotePrecos.pas`, `pCriaCdsPrecos` (`FCdsPrecos.LogChanges := False`)

Esta é a causa raiz do crescimento progressivo de tempo observado ao longo da sessão (tabelas processadas depois demorando mais que as processadas antes, mesmo com o mesmo número de itens e `FCdsPrecos.RecordCount` constante em 36 linhas). `FCdsPrecos` é um `TUniClientDataSet` 100% em memória, criado via `CreateDataSet` (sem `TUniQuery`/`TUniDataSetProvider` por trás) e nunca gravado via `ApplyUpdates`/`CancelUpdates` em nenhum ponto de `untLotePrecos.pas` (confirmado por busca em toda a unit). Por padrão, um `TClientDataSet`/`TUniClientDataSet` mantém `LogChanges := True`, registrando cada `Edit`/`Post` em um changelog interno (usado para suportar `ApplyUpdates`/`CancelUpdates`/`RevertRecord`). Como esse dataset nunca usa esses recursos, o changelog só crescia indefinidamente a cada `Post` — e cada `Post` subsequente ficava progressivamente mais lento por ter que manter um changelog cada vez maior, mesmo sem nenhum uso real dele. Desligar `LogChanges` eliminou por completo o crescimento: nas medições de diagnóstico, blocos que cresciam de 0ms para 25-49ms ao longo de 543 chamadas passaram a ficar estáveis em 0-6ms do início ao fim. Esta é a explicação do "gargalo que cresce de tabela para tabela dentro da mesma sessão de uso" relatado pelo cliente, e a correção mais relevante das três aplicadas neste requisito.
