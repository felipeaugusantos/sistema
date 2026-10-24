# Req. 466702 — Nível de Giro por Fornecedor: tabelas marcadas no Markup, DETCUS com ATUPRO = 0 e progresso em Marca/Desmarca

**Data:** 2026-10-06
**Unit:** `padra_atualizado/fontes/movimentacaoitens/untCalNivGirEstFornecGrid.pas` (form `TfrmCalNivGirEstFornecGrid`)
**Rotina:** Principal > Fechamentos Mensais > Cálculo do Nível de Giro de Estoque por Fornecedor
(`untCalNivGirEstFornecedor` → `frmCalNivGirEstFornecGrid` → `frmCalNivGirEstFornecMarkup` → `btnGraMkp`)
**Documentos relacionados:** `spec.md`, `plan.md`, `tasks.md` nesta pasta.

## 1. Contexto de negócio

Depois de calcular o nível de giro (A/B/C), o usuário informa uma margem por nível e uma "Tabela de Preço" do fornecedor
(ex.: 005861). O botão "Gravar Markup" (`btnGraMkp` → `fGravaMarkup`) leva a margem para a tabela de preço do fornecedor
(`TABDET.ITE_MARBRU`/`ITE_PREVEN`) e para a composição de custo por tabela de preço de venda (`DETCUS`, uma linha por
`DET_SEQDET` = `TABDET.AUTOINCREM` e `DET_TABELA` 1 a 7, criada no Req. 251513, r291539). A rotina de ativação de custos
(`untAtivarTabelaPreco`/`untAtivaTabelaPreco`) lê a margem nova de `DETCUS.DET_MARBRU` (`DET_TABELA = 1`, ver SQL de
`fSQLDados`: `CE.DET_MARBRU` com `LEFT JOIN DETCUS CE ... AND CE.DET_TABELA = 1`).

O painel de rodapé `chkTabelasAtivas` (TCheckListBox, só tabelas de venda com `VS_strTabPrc[i] = 'S'`) nasce todo
desmarcado e é exibido depois do "Gravar Nível de Giro" (`fPedeDadosMarkup`). A coluna "Atu. Cad. Prod." da grade é o
campo `ATUPRO` (1 = atualizar cadastro de produto/`ITEGER`; 0 = não atualizar).

## 2. Problema e causa raiz

Caso reportado: ao rodar o nível de giro e gravar o Markup com margem 33,70, a ativação de custos exibia margem nova 32
(item 90013, tabela 005861, fornecedor 00001756). Causa: `TABDET` estava com 33,70/128,82, mas `DETCUS` tabela 1 ficou
com 32,00, e a ativação lê `DETCUS`.

Em `fGravaMarkup`, para cada tabela de venda `i` de 1 a 7 (código original):

* **Ramo A** (`ITE_TABPRi = tabela escolhida`): só gravava `ITEGER` e `DETCUS` se `ATUPRO = 1` **e** a tabela `i`
  estivesse marcada em `chkTabelasAtivas` (`fCheckedLista(i)`).
* **Ramo B** (`ITE_TABPRi <> tabela escolhida`, inclusive nulo): gravava `DETCUS` sempre, sem condição.

Sem marcar nenhuma tabela, ou com `ATUPRO = 0`, o ramo A não gravava nada e o processo terminava "com sucesso" gravando
apenas o `TABDET` e o `DETCUS` das tabelas do ramo B (2, 4 e 6 no item 90013). `ITEGER.ITE_TABPR1/3/5/7 = 005861` (ramo A),
`ITE_TABPR2` nulo e `ITE_TABPR4/6` outras tabelas (ramo B).

## 3. Investigação (evidências)

| Evidência | Resultado |
|-----------|-----------|
| Consulta `TABDET` x `DETCUS` do item 90013 | `TABDET.ITE_MARBRU = 33,70`, `DETCUS` tab. 1 = 32; tab. 2, 4, 6 = 33,70; tab. 3 = 13; tab. 5 = 8; tab. 7 = 32 |
| Conferência aritmética | 62,22 / (1 − 0,18 − 0,32) = 124,44 (margem 32); 62,22 / 0,483 = 128,82 (margem 33,70 = preço da `TABDET`) |
| `LOGREP` op. 997 da gravação | 1 `UPDATE TABDET` + `UPDATE DETCUS` só para `DET_TABELA` 2, 4 e 6 por item; nunca 1, 3, 5, 7 |
| `svn blame`/`svn log` | Ramo A: r278357/r279258 (abr/2022, `ATUPRO`+`fCheckedLista`), r291539 (ago/2022, `DETCUS` dentro do ramo A, Req. 251513). Ramo B: r363284 (mar/2024), criado para corrigir "Margem Nova" divergente na ativação de custos |
| Teste 10:59 (tabela marcada, `ATUPRO = 0`) | Log sem `ITEGER` e sem `DET_TABELA` 1/3/5/7: ramo A exige `ATUPRO = 1` |

Conclusão: o ramo B foi um conserto de caso intencional (r363284); o caso "tabela igual à escolhida e não marcada / sem
`ATUPRO`" nunca foi tratado, pois o `DETCUS` entrou em 2022 aproveitando o filtro de marcação que já existia para o `ITEGER`.

## 4. Solução aplicada

1. **Validação em `btnGraMkpClick`:** nova função `fExisteTabelaMarcada` (lista vazia ou algum item marcado → `True`).
   Depois do `Post` pendente e **antes** do `fPergunta` de confirmação, se não houver tabela marcada: `pMensagemOk`
   ("Selecione ao menos uma Tabela de Preço para gravar o Markup!"), `pSetFocus(chkTabelasAtivas)` e `Exit`.
2. **`pMarcaDesmarca` (F5/F6):** `DisableControls`/`EnableControls`, `prgProgresso` (Max/Position/Visible/`StepBy`),
   `Application.ProcessMessages` por registro, e proteção de reentrada com o flag `FblnProcessando` (também ligado em `fGravaMarkup`). Antes, o laço fazia
   `Edit`/`Post` de todos os registros sem atualizar a barra nem processar mensagens (tela "travada"/"não respondendo").
   Regra de `ATUPRO` (marca/desmarca; zera quando nenhuma `ITE_TABPR1..7` é a tabela escolhida) inalterada.
3. **`fGravaMarkup`, `ATUPRO = 0`:** `Else If fCheckedLista(i) And (ITE_TABPRi = strCodTab)` ligado ao `If ATUPRO = 1`,
   chamando `fAtualizaDetCus` com a margem `MARBRU` e o preço `ITE_PREVEi × CNVCUS` (mesmos argumentos do ramo A), sem
   tocar `ITEGER`, `blnPrealt` nem `pGravaPreAlt`.

4. **Proteção de reentrada ampliada (revisões):** par `pIniciaProcessamento`/`pFinalizaProcessamento` (flag `FblnProcessando`,
   trava de `cxgItens` e `chkTabelasAtivas`, foco devolvido ao grid) usado em `pMarcaDesmarca`, `fGravaMarkup`, `btnGravarClick`,
   `btnInfMkpClick` e `pGeraExcel`; guards `If FblnProcessando Then Exit;` em `btnGraMkpClick`, `btnGravarClick`, `btnExcelClick`
   e `btnInfMkpClick`; `CloseQuery` (override) retorna `False` durante o processamento. Detalhes na Nota 1.
5. **Try/Finally nas rotinas de gravação (revisões):** `fGravaMarkup`, `fGravaNivelGiro` e `fCompletaMarkup` passaram a ter
   `Try/Finally` externo ao `Try/Except` do laço, restaurando barra (`prgProgresso.Visible := False`) e `EnableControls` mesmo
   quando o `pMensagensErro` relança a exceção. Em `fGravaMarkup`, `Result := Result And fAtualizaIteger(...)` (antes o
   retorno de cada item sobrescrevia o anterior e uma falha era mascarada). Em `fCompletaMarkup` o rótulo do `pMensagensErro`
   foi corrigido de `fGravaNivelGiro` para `fCompletaMarkup`. Em `pGeraExcel`, `objGeraExcel := nil` no início e limpeza
   garantida em `Finally` (ver Nota 1, itens h e j).

Versões alteradas (mesmo patch, +44/45 linhas): 74.111, 74.111.184, 74.150, 74.150.45, 74.150.100. Nas 74.111,
74.111.184 e 74.150.45 foi incluída a unit `System.UITypes` no `uses` da implementação (hint H2443 do compilador por
`MessageDlg` pré-existente, r493994; as 74.150 e 74.150.100 já tinham).

## 5. Decisões de escopo

* **Ramo B mantido** (grava `DETCUS` das tabelas "diferentes" sem condição): é ajuste deliberado de r363284.
* **`ITEGER` mantido** só com `ATUPRO = 1` + tabela marcada.
* **`ATUPRO = 0` grava preço e margem** no `DETCUS` (decisão do solicitante, opção "margem e preço calculado"); consequência
  aceita: o `DETCUS` fica com o preço novo e o `ITEGER` com o antigo.
* **Reentrada:** `ProcessMessages` permite novo F5/F6 durante o laço; a proteção (flag `FblnProcessando`) foi incluída por decisão do
  analista e aceita pelo solicitante. Após revisão, o flag passou a cobrir também `fGravaMarkup`, `btnGraMkpClick`,
  `btnGravarClick` e `CloseQuery`.
* Lista de tabelas vazia (nenhuma tabela de venda ativa) não bloqueia, pois não há o que marcar.

## 6. NOTAS REFERENCIADAS NO CÓDIGO-FONTE

### Nota 1
`untCalNivGirEstFornecGrid.pas`: `pMarcaDesmarca`, `fGravaMarkup`, `btnGraMkpClick`, `btnGravarClick`, `btnExcelClick`, `btnInfMkpClick` e `CloseQuery` (override).
O `Application.ProcessMessages` dentro dos laços mantém a janela responsiva, mas devolve o controle ao usuário. Sem proteção:
(a) um novo F5/F6 (tratado em `FormKeyDown`) iniciaria um segundo laço de `pMarcaDesmarca` sobre o mesmo dataset, com
`BeforePost` já desligado e controles desabilitados; (b) F5/F6 durante `fGravaMarkup` alteraria `ATUPRO` e levaria o cursor
a `Eof`, interrompendo a gravação pela metade com mensagem de sucesso; (c) F10/cliques em Gravar ou Gravar Markup durante o
Marca/Desmarca gravariam sobre `ATUPRO` parcialmente marcado; (e) btnExcel (`pGeraExcel` troca `IndexFieldNames` e percorre até `Eof`) e btnInfMkp (`fPedeDadosMarkup` faz `Locate` e liga/desliga
`Filter`) reposicionariam o cursor no meio do laço, deixando `ATUPRO` marcado só em parte, sem erro visível; (f) marcar/desmarcar uma tabela em `chkTabelasAtivas` durante `fGravaMarkup` (`fCheckedLista` é relido a cada item) gravaria
parte dos itens com um conjunto de tabelas e parte com outro; por isso o `fGravaMarkup` desabilita `chkTabelasAtivas` e
restaura o estado anterior no `Finally`; (g) `btnGravarClick` e `btnInfMkpClick` ligam o mesmo flag (com `Finally`) em volta de
`fGravaNivelGiro`, `fPedeDadosMarkup` e `fCompletaMarkup`, que também usam `ProcessMessages` (F5/F6 levariam o cursor a `Eof`
e fechar a tela liberaria `qryTabelaPreco` em uso); (h) `pGeraExcel` (chamado por `btnExcelClick` e pela exportação oferecida após "Markup gravado com sucesso") também percorre o
mesmo dataset com `ProcessMessages` pelo `TGeraExcel`; por isso liga o flag em `Try/Finally`, dentro da própria rotina, para
cobrir os dois chamadores (F5/F6, F10 e fechar a tela levariam o cursor a `Eof`, truncariam a planilha ou liberariam o dataset em
uso). Como o corpo do `pGeraExcel` passou a ser reindentado para receber o flag, foram corrigidos junto dois defeitos
pré-existentes da rotina: o `Exit` de "arquivo em uso" pulava `prgProgresso.Visible := False` e `EnableControls` (grid
congelado até fechar a tela) e `objGeraExcel` não era inicializado (exceção antes do `Create`, p.ex. em `IndexFieldNames`,
gerava Access Violation no `Except` e no `FreeAndNil`). Agora `objGeraExcel := nil` no início, `Try/Finally` interno com
`FreeAndNil`, barra e `EnableControls`, e `Assigned(objGeraExcel)` no `Except`; (i) com o grid `cxgItens` habilitado, teclas, cliques e rolagem do usuário durante o laço (F5/F6 é acionado com o foco no
grid) reposicionariam o cursor (registros pulados ou repetidos) ou abririam edição, e o `Edit/Post` seguinte gravaria a edição
sem passar por `pBeforePost2` (`BeforePost := nil` no laço), deixando `MARBRU`/`PREVEN` sem recálculo. Por isso o flag foi
centralizado no par `pIniciaProcessamento`/`pFinalizaProcessamento`, que além do flag desabilita `cxgItens` e
`chkTabelasAtivas` (guardando o estado anterior em `FblnGridHabilitado`/`FblnTabelasHabilitado`) e, ao final, restaura
esse estado e devolve o foco ao grid via `pSetFocus`; é usado em `pMarcaDesmarca`, `fGravaMarkup`, `btnGravarClick`,
`btnInfMkpClick` e `pGeraExcel`; (d) fechar a tela durante o laço liberaria o dataset em uso
(Access Violation). Solução: um flag único `FblnProcessando`, ligado em `pMarcaDesmarca` (limpo no `finally`) e em
`fGravaMarkup` (limpo em `Finally` externo ao `Try/Except` do laço, junto com a barra e o `EnableControls`, para que um
`pMensagensErro` que relance a exceção, como no modo de faturamento automático, nunca deixe o flag preso em `True`, o que
bloquearia `CloseQuery`, F5/F6 e os botões de gravar). `pMarcaDesmarca`,
`btnGraMkpClick`, `btnGravarClick`, `btnExcelClick` e `btnInfMkpClick` saem imediatamente se o flag estiver ligado, e
`CloseQuery` retorna `False`. Remover qualquer um desses guards reintroduz a reentrada correspondente.
(j) `fGravaNivelGiro` e `fCompletaMarkup` (chamadas por `btnGravarClick`/`btnInfMkpClick`, já cobertas pelo flag) tinham
`prgProgresso.Visible := False` e `EnableControls` fora de `Finally`: se o `pMensagensErro` relançasse a exceção (modo de
faturamento automático), a barra ficava visível e o dataset com os controles desabilitados (grid congelado). Agora o `Try/Except`
do laço fica dentro de um `Try/Finally` que restaura os dois, mesmo padrão de `fGravaMarkup`. O corpo foi reindentado (diff
maior nessas funções, sem mudança de lógica). O rótulo do `pMensagensErro` de `fCompletaMarkup` dizia `fGravaNivelGiro` (log
apontaria a rotina errada) e foi corrigido.

### Nota 2
`untCalNivGirEstFornecGrid.pas`, `TfrmCalNivGirEstFornecGrid.btnGraMkpClick`. Sem nenhuma tabela marcada em
`chkTabelasAtivas`, o ramo A de `fGravaMarkup` não grava `ITEGER` nem `DETCUS` das tabelas que usam a tabela escolhida,
mas o ramo B grava `DETCUS` das demais e o processo termina com mensagem de sucesso (falso sucesso). A validação roda antes
do `fPergunta` para o usuário não confirmar uma gravação que não fará o que ele espera. Lista vazia
(`VS_strTabPrc` sem 'S') retorna `True` em `fExisteTabelaMarcada`, porque não há o que marcar.

### Nota 3
`untCalNivGirEstFornecGrid.pas`, `TfrmCalNivGirEstFornecGrid.fGravaMarkup`. Item com `ATUPRO = 0` (coluna "Atu. Cad.
Prod." desmarcada) não passa pelo ramo A, que exige `ATUPRO = 1`. O `Else If` grava apenas o `DETCUS` das tabelas marcadas
cujo `ITE_TABPRi` é a tabela escolhida, com os mesmos argumentos do ramo A (margem `MARBRU` e `ITE_PREVEi × CNVCUS`), e não
toca `ITEGER`, `blnPrealt` nem `pGravaPreAlt`. A ativação de custos lê `DETCUS.DET_MARBRU`; sem este ramo, a margem da tabela
marcada ficava desatualizada mesmo com a tabela marcada. Não fundir com o ramo B, que não depende de marcação.

## 7. Achados colaterais não corrigidos

* O ramo B grava `DET_PREVEN = 0` nas tabelas 2, 4 e 6 (`ITE_PREVEi` desses itens é 0).
* O ramo A multiplica o preço por `CNVCUS` ao gravar `DETCUS`; o ramo B não (diferença de r356860 x r363284, sem
  justificativa nas mensagens de commit).
* `fCheckedLista` busca o índice por `Pos(IntToStr(intTabela), Items[i])` e depois lê `Checked[i]` mesmo quando o laço não
  encontra; protegido hoje por `VS_strTabPrc[i] <> 'S'` retornar `False` antes, mas é frágil.
* `fGravaMarkup` grava `ITEFOR`, `ITEGER` e `DETCUS` item a item **sem transação** (nenhum `fStartTransactionGen`/`fCommitGen`/
  `fRollBackGen`; anterior a este requisito). Erro no meio do laço deixa gravados os itens já processados, sem desfazer, e o
  ramo novo (`ATUPRO = 0`) soma mais um `DETCUS` por item a esse fluxo. Decisão do solicitante: apenas registrar. Ao tratar,
  avaliar o bloqueio de linhas durante o laço (com `ProcessMessages`) e se `pGravaPreAlt`/`pSQUpdatePrecoRevistaFilias`
  entram na mesma transação.
* `fGravaNivelGiro` e `fCompletaMarkup` não ligam `FblnProcessando` por conta própria; a proteção vem dos chamadores
  (`btnGravarClick`/`btnInfMkpClick` usam `pIniciaProcessamento`). Chamada nova dessas rotinas fora desses botões precisa
  ligar o flag.
* `fCompletaMarkup` troca `BeforePost := pBeforePost2` e não restaura o evento original ao final (pré-existente; não alterado).
* Dados já divergentes (ex.: item 90013 antes do reprocessamento) não foram corrigidos por script.
* Com `ATUPRO = 0` o `DETCUS` fica com preço diferente do `ITEGER` (consequência aceita).

## 8. Testes realizados (74.111, base AUTCOM em 10.0.1.85:54010, conferidos por `LOGREP`)

| Teste | Resultado |
|-------|-----------|
| Gravar Markup sem tabela marcada | Aviso, foco no painel, nada gravado |
| Tabela 1 marcada, `ATUPRO = 1` (11:03) | 82 `DETCUS` tab. 1, 2, 4, 6; 121 `ITEGER`; 0 `DETCUS` 3/5/7 |
| Tabela 1 marcada, `ATUPRO = 0` (11:12) | 82 `DETCUS` tab. 1, 2, 4, 6; 0 `ITEGER`; item 90013 tab. 1 com margem 32 e preço 124,44 |
| F5/F6 com carga grande | Barra avança e janela responde (confirmado pelo solicitante) |
| Lista de tabelas vazia, F5 repetido, mais de uma tabela marcada | Confirmados pelo solicitante |

Pendentes: exceção durante o laço, regressão do `ATUPRO` por item, validação final dos critérios de aceitação e testes
manuais nas demais versões (74.111.184, 74.150, 74.150.45, 74.150.100).

## 9. Lições de ferramenta/processo

* Os fontes são cp1252 + CRLF: toda edição foi por script Python com encoding explícito; conferir ausência de `\xef\xbf\xbd`
  e de LF solto.
* O patch foi aplicado igual nas cinco versões porque `btnGraMkpClick`, `pMarcaDesmarca` e o trecho do ramo A são idênticos
  entre elas; as 74.150.x diferem só na API de pré-alteração de preços (`pGravaMestreProAlt`/`TPrecoProduto.pSetaGravacaoIteger`
  no lugar de `pPreAltDefineVariaveisAltPre`/`pGravaPreAlt`/`blnPrealt`/`pIniciaMatriz`) e na assinatura de
  `TParCalculaPrecoCusto.Create`. Não copiar a unit inteira entre versões.
* Consultas ao banco: o `autcom_db.py` precisa ser chamado a partir da raiz do projeto (caminho relativo `.claude\scripts`);
  credenciais passadas por variável de ambiente do processo, nunca por `--password` (bloqueado pelo classificador de permissões).
* O `LOGREP` (op. 997, `LOG_CON_ID` da sessão) é a forma mais confiável de ver quais `UPDATE`s `fGravaMarkup` executou.
