# Req. 470504 — Erro de acesso ao passar o mouse na Geração de Movimentação Programada

Protocolo de origem: 498246 (cliente Bela Tintas). Versão do cliente: 48.2.30.74.150.100.

## 1. Contexto de negócio
A tela "Geração de Movimentação Programada" (`TfrmMovimentacaoProgramadaManual`, unit
`padra_atualizado\fontes\movimentacaoitens\untMovimentacaoProgramadaManual.pas`) sugere transferências de lotes para
abastecer o picking. Cada item (pai, `ITE_SELECE` = 'S' marcado / 'N' desmarcado) tem lotes (filhos,
`LOT_SELECE_DETAIL` = 'S' / 'N'). O pai fica marcado enquanto houver ao menos um lote marcado.
O Pesquisar carrega os itens e, para cada um, calcula o saldo a transferir (`ITE_SALDTRANS`).

## 2. Problema relatado
`EAccessViolation` "Read of address 00000000" em `TcxCustomGridRecordsViewInfo.GetHitTest` ao mover o mouse sobre a grade.
Roteiro: Pesquisar, "Desmarcar Todos", filtrar "Localização de Destino" com "começar com" + "D", expandir o item 19932,
marcar e desmarcar um lote. Durante os testes surgiram sintomas ligados: foco sempre na primeira linha, clique no checkbox
do pai desmarcando a primeira linha, pais ainda marcados na tela após "Desmarcar Todos".

## 3. Causa raiz
1. `pCalculaSaldoSugestao` gravava `ITE_SALDTRANS` com `AsString := FormatFloat('#,##0.00', ...)`. O campo é numérico e o
   texto com ponto de milhar (ex.: `'1.968,00'`) não é aceito: `EDatabaseError` para qualquer saldo >= 1.000.
2. A rotina chama `DisableControls` do dataset do mestre sem `try/finally`. A exceção pulava o `EnableControls`, a pesquisa
   parava no 3º de 669 itens (log: `RecNo=3`) e a mensagem não aparecia ao usuário.
3. Com as notificações do dataset desligadas, a grade não repinta nem acompanha o cursor: foco preso na linha 0, pais
   desatualizados, clique no pai caindo em outra linha. Com filtro, o foco ficava em `-1`; `UpdateMasterCheckbox` consultava a
   relação/detalhe com índice `-1`, deixava os registros do viewinfo nulos (`nils=29` no log) e o mouse-over seguinte gerava o AV.
   `pAjustaDetalhe` roda em `TGridSafetyManager.SafeMouseUp`, que engole exceções; por isso o AV só aparecia depois.

## 4. Jornada de investigação
- Log diagnóstico temporário (cópia de testes `.12`) mostrou `FocusedRecordIndex = -1` com filtro e `nils=29`.
- Primeira tentativa: guarda `FocusedRecordIndex < 0 -> Exit` em `UpdateMasterCheckbox`. Eliminou o AV, mas não os sintomas do pai.
- Segunda: usar o mestre do lote clicado (`FindRecordIndexByKey`), e bookmark com `GotoBookmark`. Dados corretos em log, tela
  continuou travada. Descartadas.
- Log `ctrlDesab` (`DataSet.ControlsDisabled`) mostrou `True` logo após o Pesquisar, antes de qualquer clique. Log da rotina de
  pesquisa revelou o `EDatabaseError` no 3º item.
- Regra 7: o histórico SVN mostrou que o mesmo problema (mesmo cliente, mesma pilha) já foi corrigido no Req. 443841:
  r478361 na 74.150 e r478360 na 74.150.45; a 74.111 também tem `fExecutaPesquisa`. Só a 74.150.100 não tinha.
  Correção própria descartada em favor do porte, para não existirem duas correções divergentes.
- Teste do porte na `.12` (ver 3.0, sem as notas 1/3/4): sem AV, pai atualizando, filtro e foco corretos; log com
  `ctrlDesab=False` após o Pesquisar e `nils=29` nunca mais. Validado também na versão limpa.

## 5. Solução aplicada (porte da r478361, Req. 443841)
Unit `untMovimentacaoProgramadaManual.pas`:
- `pCalculaSaldoSugestao`: `AsString := FormatFloat(...)` -> `AsFloat := ...` (sem texto formatado, sem exceção).
- `btnPesquisarClick`: passa a abrir a tela `TfrmGravando` ("Carregando produtos") e executar a nova `fExecutaPesquisa`
  (corpo antigo da pesquisa, com `try/except` e `pMensagensErro`). No `finally` do botão, laço `while ControlsDisabled do
  EnableControls` (limite de 10, com `pMensagemOk`), seguido de `ApplyBestFit` se houver registros e `pCalculaTotaisMovProg`.
- `pCalculaTotaisMovProg`: zera os rótulos e sai se não houver dataset de detalhe ou se ele estiver vazio; agregados criados depois
  dessa checagem.
- `uses`: `CxProgressBar`, `untGravando`; declaração de `fExecutaPesquisa` na seção private.
Resultado: o `svn diff` da 74.150.100 tem as mesmas linhas +/- da r478361.

## 6. Decisões de escopo
- Guarda `FocusedRecordIndex < 0` (antiga Nota 1), mestre do lote clicado e bookmark (antigas Notas 3 e 4) NÃO foram incluídos:
  com o porte o foco da grade passa por `-1` apenas por um instante após o filtro e volta sozinho a um registro válido (log ver 3.0),
  e os testes passaram sem elas. A 74.150 também não tem a guarda.
- Aplicado no projeto aberto 74.150.100 e na cópia `.12`. A 74.150 e a 74.150.45 já tinham a correção; nada alterado.
- Sem comentário "Nota" no fonte: o código é idêntico ao da r478361.

## 7. Achados colaterais (não corrigidos)
- `pSelecionar` leva 16 a 25 s para 669 itens (Post linha a linha), problema de desempenho preexistente.
- `UpdateMasterCheckbox` atualiza o pai do registro focado na grade, não o do lote clicado; hoje não causa erro porque o foco
  acompanha o dataset.
- `cxgDadosITE_SELECEPropertiesChange` chama `pSelecionar(False)`, que alterna o registro do cursor do dataset.
- `ProcessMessages` em `pAjustaDetalhe` (r424284, Req. 388116) mantido.
- Arquivos `opcoes.ini` e `rev.inc` modificados na `.12` por ambiente/build, sem relação com o requisito.

## 8. Lições de processo
- Fonte Delphi em cp1252 + CRLF: editar só via Python e validar com `fonte_delphi.py conferir`.
- `svn log --search` não achou o 443841 na 74.150.45 e na 74.111; conferir também por `svn blame`/`grep` na unit.
- Antes de escrever correção própria, comparar a rotina nas demais versões: a correção já existia.

## 9. Notas referenciadas no código-fonte
Nenhuma. O porte é idêntico ao código da r478361 e não recebeu comentários adicionais.
