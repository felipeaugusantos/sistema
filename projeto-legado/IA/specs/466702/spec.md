# Especificação — Req. 466702

**Título:** Cálculo do Nível de Giro por Fornecedor — validar tabelas marcadas ao gravar Markup e exibir progresso em Marca/Desmarca
**Objetivo:** (1) impedir a gravação do Markup (`btnGraMkp`) sem ao menos uma "Tabela de Preço" marcada em `chkTabelasAtivas`; (2) fazer o `prgProgresso` funcionar em `pMarcaDesmarca`, evitando tela "travada"/"não respondendo".
**Zona:** Legado
**Data:** 2026-10-06

## 1. Contexto / problema atual

Rotina: Principal > Fechamentos Mensais > Cálculo do Nível de Giro de Estoque por Fornecedor (`untCalNivGirEstFornecedor` → `frmCalNivGirEstFornecGrid` → `frmCalNivGirEstFornecMarkup` → `btnGraMkp`).

**Problema 1 — margem não chega ao `DETCUS` da tabela 1.** Em `fGravaMarkup` (`untCalNivGirEstFornecGrid.pas`), para cada tabela de venda `i` de 1 a 7:

- **Ramo A** (`ITE_TABPRi = tabela escolhida`): só grava `ITEGER` e `DETCUS` se `ATUPRO = 1` **e** a tabela `i` estiver marcada em `chkTabelasAtivas`. A lista nasce toda desmarcada (`FormCreate`) e é exibida só após o "Gravar Nível de Giro" (`fPedeDadosMarkup`, painel `pnlTabelasAtivas` com 35 px de altura — fácil de passar despercebido).
- **Ramo B** (`ITE_TABPRi <> tabela escolhida`, inclusive nulo): grava `DETCUS` **sempre**, sem olhar `ATUPRO` nem marcação.

Se o usuário não marca nenhuma tabela, o fluxo conclui "com sucesso" gravando `TABDET` e `DETCUS` apenas das tabelas do ramo B. Evidência (item 90013, tabela 005861, fornecedor 00001756, base AUTCOM): `ITEGER.ITE_TABPR1/3/5/7 = 005861` (ramo A, desmarcadas) e `ITE_TABPR2` nulo, `ITE_TABPR4/6` outras tabelas (ramo B). O `LOGREP` (op. 997) mostra `UPDATE DETCUS` somente para `DET_TABELA` 2, 4 e 6. Resultado: `TABDET.ITE_MARBRU = 33,70` e `DETCUS` tabela 1 = 32,00. A ativação de custos (`untAtivaTabelaPreco`) lê `DETCUS.DET_MARBRU` (`DET_TABELA = 1`) e por isso exibe margem nova 32, não 33,70.

**Histórico SVN do trecho (por que está assim):**
- r253016 — criação da rotina.
- r278357/r279258 (abr/2022) — `ATUPRO`, `fCheckedLista` e `ITE_TABPR = strCodTab` introduzidos para gravar o `ITEGER`.
- r291539 (ago/2022, Req. 251513) — criação do `DETCUS`; `fAtualizaDetCus` entrou **dentro do ramo A**, reaproveitando o filtro de marcação.
- r363284 (mar/2024) — criado o ramo B (grava `DETCUS` das tabelas "diferentes") para corrigir "Margem Nova" divergente na ativação de custos. É ajuste de caso intencional; o caso "tabela igual e desmarcada" nunca foi tratado.

**Problema 2 — `pMarcaDesmarca`** (acionada por F5/F6 em `FormKeyDown`): percorre todos os registros do dataset com `Edit`/`Post` sem `DisableControls`, sem atualizar `prgProgresso` e sem `Application.ProcessMessages`. Com muitos registros a tela fica congelada e o Windows pode marcá-la como "não respondendo". As demais rotinas da unit (`fGravaNivelGiro`, `fGravaMarkup`) já usam `prgProgresso` + `ProcessMessages`.

## 2. Módulos e entidades envolvidos
- Módulo: movimentação de itens / fechamentos mensais.
- Unit: `padra_atualizado/fontes/movimentacaoitens/untCalNivGirEstFornecGrid.pas` (e `.dfm`, sem alteração prevista).
- Tabelas lidas/gravadas pela rotina: `TABDET` (PK `AUTOINCREM`), `DETCUS` (`DET_SEQDET` + `DET_TABELA`), `ITEGER` (`ITE_CODEMP` + `ITE_CODITE`), `LOGREP`.

## 3. Requisitos funcionais
- RF01 — Ao clicar em `btnGraMkp`, se houver itens em `chkTabelasAtivas` e nenhum estiver marcado, exibir mensagem orientando a marcar ao menos uma Tabela de Preço, levar o foco ao `chkTabelasAtivas` e **não prosseguir** (sem pergunta de confirmação, sem gravação, sem fechar a tela).
- RF02 — A validação do RF01 ocorre **antes** do `fPergunta('Confirma a gravação do Markup?')`.
- RF03 — Se `chkTabelasAtivas` não tiver itens (nenhuma tabela de venda ativa em `VS_strTabPrc`), a validação não bloqueia.
- RF04 — Em `pMarcaDesmarca`, exibir `prgProgresso` (Max = total de registros, Position avançando a cada registro) durante todo o processamento e ocultá-lo ao final, inclusive em caso de exceção.
- RF05 — Em `pMarcaDesmarca`, chamar `Application.ProcessMessages` durante o laço para a janela permanecer responsiva.
- RF06 — Em `pMarcaDesmarca`, desabilitar os controles do dataset durante o laço (`DisableControls`/`EnableControls`) para reduzir repintura.
- RF07 — Em `fGravaMarkup`, para item com `ATUPRO = 0`, gravar no `DETCUS` (margem `DET_MARBRU` e preço `DET_PREVEN`, este como no ramo A: preço novo × `CNVCUS`) das tabelas de venda **marcadas** com `ITE_TABPRi = tabela escolhida`, **sem** gravar `ITEGER` (nem `blnPrealt`/`pGravaPreAlt`).

## 4. Regras de negócio
- RN01 — A marcação exigida em RF01 é a de `chkTabelasAtivas` (tabelas de venda 1 a 7 ativas). Não exige `ATUPRO = 1` em nenhum item.
- RN02 — Em `fGravaMarkup`: ramo A com `ATUPRO = 1` + tabela marcada continua gravando `ITEGER` e `DETCUS`; **novo (RF07):** com `ATUPRO = 0` e tabela marcada, grava só o `DETCUS`; ramo B continua gravando `DETCUS` sem condição.
- RN03 — A regra de `pMarcaDesmarca` (`ATUPRO` := 1/0, zerando quando nenhuma `ITE_TABPR1..7` é a tabela escolhida) **não muda**; só a apresentação/responsividade.
- RN04 — O `BeforePost` desligado durante `pMarcaDesmarca` deve ser sempre restaurado (já ocorre em `finally`).
- RN05 — Reentrada: como `ProcessMessages` permite novo F5/F6, cliques e fechar a tela durante os laços, nenhuma rotina que percorre o dataset com `ProcessMessages` (`pMarcaDesmarca`, `fGravaMarkup`, `fGravaNivelGiro`, `fCompletaMarkup`, `pGeraExcel`) pode ser reentrada: um único flag (`FblnProcessando`) bloqueia F5/F6, os botões Gravar, Gravar Markup, Excel e Informar Markup e o fechamento da tela; o grid de itens e `chkTabelasAtivas` ficam desabilitados e são restaurados ao final.
- RN06 — Barra, `EnableControls` e flag de processamento são sempre restaurados em `Finally`, inclusive quando o tratamento de erro relança a exceção (`fGravaMarkup`, `fGravaNivelGiro`, `fCompletaMarkup`, `pGeraExcel`).

## 5. Requisitos técnicos / não-funcionais
- Foco por `pSetFocus`, nunca `.SetFocus`; mensagens pelo helper já usado na unit.
- Lógica de validação em método próprio (função), `OnClick` apenas delega.
- Identificadores no padrão da unit (Hungarian, prefixos `p`/`f`/`F`), **sem** número do requisito no nome.
- Arquivo em cp1252/CRLF: edição somente via Python com encoding explícito, nunca `Edit`.
- Sem impacto fiscal/financeiro direto; sem alteração de transação, auditoria ou permissão.

## 6. Critérios de aceitação
- [ ] Com nenhuma tabela marcada, clicar em "Gravar Markup" exibe a mensagem, foca o `chkTabelasAtivas` e não grava nada (nenhum `UPDATE` em `LOGREP` para `TABDET`/`DETCUS`/`ITEGER`).
- [ ] Com ao menos uma tabela marcada, o fluxo segue como hoje (pergunta de confirmação, gravação, exportação Excel).
- [ ] Com `chkTabelasAtivas` vazio, o botão não é bloqueado pela validação.
- [ ] Marcando a tabela 1 (com `ATUPRO = 1` e `ITE_TABPR1 = tabela escolhida`), o `DETCUS` tabela 1 recebe a margem informada.
- [ ] F5/F6 exibem a barra de progresso avançando do início ao fim e a janela responde durante o processamento (sem "não respondendo") numa carga grande.
- [ ] Ao final de F5/F6 a barra é ocultada, os controles do grid são reabilitados e o `BeforePost` original é restaurado, também quando ocorre exceção.
- [ ] Pressionar F5/F6 durante um processamento em andamento não dispara um segundo laço.
- [ ] Durante Marca/Desmarca, gravação do Nível de Giro, gravação do Markup e exportação para Excel, os botões, F5/F6, o grid, `chkTabelasAtivas` e o fechamento da tela não interferem no processo; ao final, estado anterior restaurado e foco no grid.
- [ ] Exceção relançada no meio de `fGravaMarkup`, `fGravaNivelGiro` ou `fCompletaMarkup` não deixa a barra visível, os controles desabilitados nem o flag preso.
- [ ] Com `ATUPRO = 0` (coluna "Atu. Cad. Prod." desmarcada) e a Tabela 1 marcada, o `DETCUS` tabela 1 recebe margem e preço (`LOGREP` mostra `UPDATE DETCUS ... DET_TABELA = 1`) e o `ITEGER` do item permanece inalterado (sem `UPDATE ITEGER` no log).
- [ ] Resultado final de `ATUPRO` por item idêntico ao comportamento anterior.

## 7. Fora de escopo
- Alterar o ramo B de `fGravaMarkup` ou restringir a gravação do `DETCUS` somente às tabelas marcadas.
- Alterar a gravação do `ITEGER` (continua só com `ATUPRO = 1` + tabela marcada).
- `DET_PREVEN = 0` gravado nas tabelas do ramo B e a diferença de `CNVCUS` entre os ramos A e B.
- Corrigir dados já divergentes (ex.: item 90013) por script.
- Marcar tabelas por padrão ou mudar o layout do painel `pnlTabelasAtivas`.
- Alterações em `untAtivaTabelaPreco`/`untAtivarTabelaPreco` (ativação de custos).

## 8. Dependências e riscos
- Usuários que hoje gravam sem marcar nada (só ramo B) passarão a ser bloqueados quando houver tabela ativa na lista — mudança de fluxo intencional.
- Com `ATUPRO = 0` o `DETCUS` da tabela marcada passa a ter o preço novo enquanto o `ITEGER` mantém o antigo (decisão do solicitante, RF07).
- `ProcessMessages` abre reentrada (F5/F6, cliques, fechar a tela) — mitigar com proteção de reentrada.
- `fGravaMarkup` grava `ITEFOR`/`ITEGER`/`DETCUS` sem transação (pré-existente); registrado como achado colateral, decisão do solicitante de não tratar neste requisito.
