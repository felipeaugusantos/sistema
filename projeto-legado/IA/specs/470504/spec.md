# Especificação — Req. 470504

**Título:** Erro de acesso (EAccessViolation) ao passar o mouse na grade da Geração de Movimentação Programada
**Objetivo:** Eliminar o crash em `TcxCustomGridRecordsViewInfo.GetHitTest` quando a grade de itens tem filtro, e corrigir o checkbox do pai (item) que atualiza o registro errado.
**Zona:** Legado
**Data:** 2026-10-16
**Protocolo de origem:** 498246 (cliente Bela Tintas)

## 1. Contexto / problema atual
Na tela "Geração de Movimentação Programada" (`TfrmMovimentacaoProgramadaManual`), após carregar os itens, usar "[F3] Desmarcar Todos", filtrar a coluna "Localização de Destino" com "começar com" + "D", expandir um item (ex.: 19932), marcar e desmarcar um lote, o Autcom passa a gerar `EAccessViolation` "Read of address 00000000" ao mover o mouse sobre a grade (WM_SETCURSOR -> GetHitTest, cxGridCustomTableView linha 13644).

**Causa raiz (confirmada por log e por teste):** com o filtro, a grade mestre não tem registro focado (`FocusedRecordIndex = -1`). `UpdateMasterCheckbox`, chamada por `pAjustaDetalhe`, consultava `GetDetailActiveRelationIndex(-1)` / `GetDetailLinkObject(-1, ...)`, o que deixava todos os registros do viewinfo da grade nulos (log: `nils=29`). O próximo mouse-over lia um item nulo e gerava o AV. `pAjustaDetalhe` roda em `TGridSafetyManager.SafeMouseUp`, que engole exceções, por isso o erro só aparecia no mouse-over seguinte.

**Defeito paralelo (já existia):** `UpdateMasterCheckbox` atualizava o mestre **focado na grade**, não o mestre do lote clicado, e o `Locate`/`Post` movia o cursor do dataset sem a grade acompanhar.

## 2. Módulos e entidades envolvidos
- Módulo: movimentação de itens.
- Unit: `padra_atualizado\fontes\movimentacaoitens\untMovimentacaoProgramadaManual.pas` (rotinas `UpdateMasterCheckbox`, `pAjustaDetalhe`, `pSelecionar`).
- Leitura: `padra_atualizado\fontes\genericos\untGridSafety.pas` (`SafeMouseUp`).
- Datasets: `dtsDados` (mestre, chave `CHAVE_MASTER`, campo `ITE_SELECE` 'S'/'N'), `dtsDetalhes` (lotes, `CHAVE_MASTER`/`CHAVE_FILHO`, `LOT_SELECE_DETAIL` 'S'/'N').

## 3. Requisitos funcionais
- RF01 — Com filtro na grade, mover o mouse, marcar e desmarcar lotes não pode gerar erro.
- RF02 — Marcar/desmarcar um lote deve refletir no checkbox do **pai daquele lote** (marcado se algum lote 'S', desmarcado se todos 'N').
- RF03 — O foco da grade não deve pular para outro registro ao atualizar o pai.
- RF04 — Clicar no checkbox do pai deve alterar a linha clicada; "Marcar/Desmarcar Todos" deve refletir na tela em todos os pais.

## 4. Regras de negócio
- RN01 — `ITE_SELECE` do pai = 'S' enquanto houver ao menos um lote com `LOT_SELECE_DETAIL` = 'S'; 'N' quando todos 'N'.
- RN02 — Sem registro de mestre na grade (índice < 0), não há detalhe a consultar: a rotina sai sem tocar na grade.

## 5. Requisitos técnicos / não-funcionais
- Fonte cp1252 + CRLF; edição somente via Python; validar com `fonte_delphi.py conferir`.
- Sem número do requisito em identificadores; comentários curtos + "Verificar Nota N - Req. 470504".
- Sem log de diagnóstico e sem caminho fixo no Desktop na versão final.

## 6. Critérios de aceitação
- [ ] Com o filtro "começa com D", expandir 19932, marcar e desmarcar o lote e mover o mouse: sem erro (validado nas ver. 1.7 a 2.0 da cópia de teste).
- [ ] Marcar/desmarcar lote atualiza o pai correto, com e sem filtro (dados validados em log; falta validar a tela).
- [ ] Clicar no checkbox do pai altera a linha clicada e o foco não pula para a primeira linha (**PENDENTE**).
- [ ] "Marcar Todos" / "Desmarcar Todos" refletem no checkbox dos pais na tela (**PENDENTE**).

## 7. Fora de escopo
- `BeginUpdate` em volta do `Post` do pai (decisão em aberto; não incluído no projeto aberto).
- `Application.ProcessMessages` em `pAjustaDetalhe` (mantido; introduzido na r424284, Req. 388116).
- Arquivos `untPcmGer.pas` e `opcoes.ini` modificados na cópia de teste, sem relação com o requisito.

## 8. Dependências e riscos
- Foco preso na primeira linha, clique no pai caindo em outra linha e pai marcado após "Desmarcar Todos": causa confirmada por log (ver 2.3). `pCalculaSaldoSugestao` grava texto com ponto de milhar (`'1.968,00'`) em campo numérico; o `EDatabaseError` interrompe o Pesquisar no 3º item e deixa o `DisableControls` do mestre sem `EnableControls`, com a grade travada.
- Correção já existente: r478361 na 74.150 e r478360 na `.150.45` (Req. 443841, mesmo cliente e mesma pilha de erro); a `.111` também tem `fExecutaPesquisa`. Só a `.100` não tinha. Pela regra 7, o porte substitui correção própria. A `.150.45` e a `.111` nem têm `ITE_SALDTRANS`/`pCalculaSaldoSugestao`. Com o porte o foco da grade volta sozinho a um registro válido após o filtro (log ver 3.0), então a guarda do índice -1 não foi incluída.
