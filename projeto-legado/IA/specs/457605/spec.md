# Especificação — Req. 457605

**Título:** Cancelamento de Nota de Entrada estorna Contas a Pagar sem checar acesso e sem gravar MOVBAN
**Objetivo:** Corrigir o cancelamento de Nota de Entrada (NE) para que, quando existir Contas a Pagar (CTP) baixado vinculado à nota, o operador seja obrigado a estornar o CTP pela tela própria (com todas as proteções existentes) antes de conseguir cancelar a NE — em vez de o sistema estornar automaticamente sem checar direito de acesso e sem gravar o lançamento de estorno na MOVBAN.
**Zona:** Legado
**Data:** 2026-08-26

## 1. Contexto / problema atual

### 1.1 Sintoma relatado (cliente Ponto Final Revestimento, LJ001, executável 379.48.02.30, base AUTCOM)

Caminho: `PRINCIPAL > MOVIMENTAÇÃO DE ITENS > FLUXO DE PROCESSO DE COMPRAS > botão [F6-Cancelar Entrada de Mercadoria]`.

Um operador **sem** o direito de acesso `frmEstornoCtaPagar` (Estorno de Contas a Pagar) conseguiu cancelar uma Nota de Entrada (NE) cujo Contas a Pagar já estava **baixado**, sem que a tela de estorno fosse exibida e sem nenhuma trava ou aviso. Caso simulado: NF de fornecedor 374522-NF-001, título baixado; operador de estoque (código 004, sem direito a estorno) cancelou a entrada — vídeo de reprodução confirma que a tela de estorno nunca aparece.

O histórico do título (`LOGCTP`) mostra uma linha de estorno gravada automaticamente (diferença de apenas 0:01s entre "estorno" e "exclusão", evidenciando processo automático em sequência), mas o lançamento de estorno **não foi gravado na MOVBAN** — o portador ficou com a baixa original sem o estorno correspondente, gerando divergência de saldo bancário. O financeiro precisou baixar manualmente o título em um portador provisório (`99999`) para contornar o problema.

### 1.2 Causa raiz identificada

O ponto de entrada real é `TProcessoEntradaMercadoria.pOnCancelar` ([untProcessoCompras.pas:1151](../../../padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas)), que já valida `fVerificaAcessoSistema('frmCancelamentoDocumentos')` (direito genérico de cancelamento) mas **nunca** valida `frmEstornoCtaPagar` (direito específico de estorno de contas a pagar) — daí o operador com o primeiro direito, mas não o segundo, conseguir concluir a operação sem nenhum aviso.

Rastreamento via `svn diff -c 425895` confirmou a origem exata da regressão:

- **Antes da revisão 425895** (Req. 384736, autor `renan`, 25/06/2025), `pOnCancelar` chamava `TfrmCancelamentoDocumentos.pCancelaNotaEntrada(strAutoincrem)` — método que abria a tela `TfrmCancelamentoDocumentos` (modal, campos travados, só o botão "Cancelar" habilitado). Esse botão cria `TCancelaDocumentos.Create(False)` **sem nunca setar `blnEstornoAutomatico`** — comportamento que continua sendo o padrão hoje em [untCancelamentoDocumentos.pas:1383](../../../padra_atualizado/fontes/cancelamento/untCancelamentoDocumentos.pas) para o fluxo normal de cancelamento interativo.
- **Na revisão 425895**, o método `TfrmCancelamentoDocumentos.pCancelaNotaEntrada` foi **removido** e substituído por uma nova procedure própria e headless (`TProcessoEntradaMercadoria.pCancelaNotaEntrada`, direto em `untProcessoCompras.pas`), que passou a setar `objCancelaDocumentos.blnEstornoAutomatico := True`. O objetivo declarado do Req. 384736 era desacoplar `TCancelaDocumentos` de UI para viabilizar o cancelamento automático no serviço Fulfillment (Linux) — mas essa mudança foi aplicada também a este ponto de entrada, que é **100% desktop/interativo** (botão F6 do Fluxo de Processo de Compras), sem necessidade de operar em modo headless. Trata-se de uma regressão colateral do refactor, não de uma decisão de negócio deliberada.

Com `blnEstornoAutomatico = True`, quando o documento é `NE` e existe resumo de CTP a gerar (`fVaiGerarResumoCtp`), `TCancelaDocumentos` ([untCancelaDocumentos.pas:2269](../../../padra_atualizado/fontes/cancelamento/untCancelaDocumentos.pas)) chama diretamente `FPrcEstornoPagarAutomatico` (injetado como `pEstornoPagarAutomatico`, [untTEstornoPagar.pas:158](../../../padra_atualizado/fontes/financeiro/contasapagar/untTEstornoPagar.pas)), que por sua vez chama diretamente `pEstornaDuplicataSimples`/`pEstornaDuplicataParcial` — **sem** passar pela tela `TfrmEstornoPagar` nem pelo método de orquestração `TEstornoPagar.fEstornaDuplicataConjugadas`, que é onde vivem:
- a checagem `fVerificaAcessoSistema('frmEstornoCtaPagar')` (hoje só existe como `Enabled` de botão de UI em `untCadCtaPagar.pas:6404`, nunca a nível de negócio);
- as checagens de acesso granular `DTAOEP`/`DTESTP`;
- `pValidationBeforeConfirm` (duplicata já estornada, duplicata principal baixada);
- confirmação do usuário e motivo de estorno obrigatório (`PMOTES`);
- a gravação do lançamento reverso na MOVBAN (`pGravaMovBan`), que só é chamada dentro de `fEstornaDuplicataConjugadas`, nunca dentro dos métodos "worker" `pEstornaDuplicataSimples`/`pEstornaDuplicataParcial`.

### 1.3 Por que reverter em vez de adicionar novas checagens

Uma primeira proposta de correção cogitou adicionar checagens de acesso em dois pontos (`pOnCancelar` e `untCancelaDocumentos.pas`) e replicar a gravação de MOVBAN dentro do fluxo automático. Essa abordagem foi descartada em favor de simplesmente **reverter a regressão**: desligar `blnEstornoAutomatico` neste único ponto de entrada restaura o comportamento already comprovado (o mesmo usado hoje pelo fluxo padrão interativo de `TfrmCancelamentoDocumentos`), sem duplicar lógica de negócio nem introduzir código novo em `untCancelaDocumentos.pas`/`untTEstornoPagar.pas`.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (Fluxo de Processo de Compras)
- Unit impactada: `padra_atualizado/fontes/movimentacaoitens/untProcessoCompras.pas` — classe `TProcessoEntradaMercadoria`, método `pCancelaNotaEntrada`
- Entidades envolvidas (não alteradas, apenas o caminho de acesso muda): `CADPAG` (contas a pagar), `MOVBAN` (movimentação bancária), `LOGCTP` (log de auditoria de contas a pagar), `GERELE` (gerenciador de entrada eletrônica/NF-e)
- Direito de acesso envolvido: `frmEstornoCtaPagar` (Estorno de Contas a Pagar), já existente em `DIROPE`/`DIRGPO` — não é criado nenhum direito novo

## 3. Requisitos funcionais

- RF01 — Ao cancelar uma Nota de Entrada (NE) pelo botão [F6-Cancelar Entrada de Mercadoria] do Fluxo de Processo de Compras, se existir Contas a Pagar baixado vinculado a essa NE, o cancelamento **não** deve estornar o CTP automaticamente.
- RF02 — Nesse cenário (CTP baixado), o cancelamento deve ser bloqueado com mensagem informando que é necessário estornar o Contas a Pagar antes de cancelar o documento (comportamento já existente em `TCancelaDocumentos.pGeraResumo`, que passa a ser exercitado novamente por este ponto de entrada).
- RF03 — O operador deve então estornar o CTP pela rotina própria de Estorno de Contas a Pagar (`TfrmEstornoPagar`), que já valida o direito `frmEstornoCtaPagar` e grava corretamente o lançamento na MOVBAN. Só depois disso o cancelamento da NE deve ser possível.
- RF04 — Notas de Entrada sem CTP baixado vinculado devem continuar sendo canceladas normalmente, sem nenhuma mudança de comportamento.

## 4. Regras de negócio

- RN01 — `blnEstornoAutomatico` deve ser `False` na criação de `TCancelaDocumentos` dentro de `TProcessoEntradaMercadoria.pCancelaNotaEntrada`, restaurando o valor padrão do construtor (`FEstornoAutomatico := False`, [untCancelaDocumentos.pas:433](../../../padra_atualizado/fontes/cancelamento/untCancelaDocumentos.pas)) para este ponto de entrada.
- RN02 — Com `blnEstornoAutomatico = False`, ao detectar CTP baixado vinculado à NE (`fVaiGerarResumoCtp` = True), o fluxo deve seguir para `pGeraResumo(ExceptionPrecisaEstornarCTP)` ([untCancelaDocumentos.pas:2290](../../../padra_atualizado/fontes/cancelamento/untCancelaDocumentos.pas)), que já apresenta a mensagem "Duplicatas que já foram baixadas e portanto não será permitido cancelar o documento! Será necessário realizar o estorno para cancelar este documento." e interrompe o cancelamento — comportamento pré-existente que não precisa de nenhuma alteração de código.
- RN03 — Nenhuma outra chamada de `blnEstornoAutomatico := True` no restante do sistema (Contas a Receber, faturamento, locação de equipamentos, importação de NF-e/Fulfillment) é alterada por este requisito.

## 5. Requisitos técnicos / não-funcionais

- Alteração restrita a um único arquivo/método (`untProcessoCompras.pas`, `TProcessoEntradaMercadoria.pCancelaNotaEntrada`) — confirmado que essa procedure tem uma única chamada em todo o código-fonte (`pOnCancelar`, mesmo arquivo), acionada exclusivamente pelo botão F6 do Fluxo de Processo de Compras (desktop, via `TProcessoComum.pCancelar` ← `untFluxoCompras.pas:1861`). Nenhum fluxo Linux/Fulfillment/Serviço é afetado.
- Comentário curto no fonte referenciando a Nota técnica da análise (padrão do projeto), explicando o motivo não óbvio da reversão para quem ler o código depois.
- Sem impacto em SQL, componentes de UI, ou estrutura de tabelas.

## 6. Critérios de aceitação

- [ ] Cancelar uma NE **sem** CTP baixado vinculado continua funcionando normalmente (sem mudança de comportamento).
- [ ] Cancelar uma NE **com** CTP baixado vinculado, por um operador **sem** direito `frmEstornoCtaPagar`, é bloqueado com mensagem clara informando a necessidade de estornar o CTP antes.
- [ ] Cancelar uma NE **com** CTP baixado vinculado, por um operador **com** direito `frmEstornoCtaPagar`, também é bloqueado da mesma forma (não há mais atalho automático) — o operador precisa estornar manualmente pela tela de Estorno de Contas a Pagar antes de cancelar a NE.
- [ ] Após estornar manualmente o CTP pela tela `TfrmEstornoPagar` e depois cancelar a NE, o lançamento de estorno aparece corretamente gravado na MOVBAN (validação via `citel-conectarBanco`).
- [ ] Reprodução do cenário do relato original (NF 374522-NF-001 ou equivalente em ambiente de teste) confirma que a nota não é mais cancelada silenciosamente sem o devido estorno.

## 7. Fora de escopo

- Contas a Receber (`frmEstornoReceber.blnEstornoAutomatico` / `FPrcEstornoReceberAutomatico`), que apresenta o mesmo padrão de bypass, mas não foi relatado neste requisito — fica registrado como risco conhecido para requisito futuro.
- Qualquer alteração em `untCancelaDocumentos.pas` ou `untTEstornoPagar.pas` (checagens centrais de acesso, gravação de MOVBAN no fluxo automático) — não são necessárias com a abordagem de reversão adotada.
- Outros ~26 pontos de chamada de `blnEstornoAutomatico := True` espalhados por `faturamento/`, `movimentacaoitens/` e `util/Fulfillment/` — nenhum deles é alterado.
- Investigação do Req. 449101 (citado no relato como ocorrência anterior semelhante) — não foi encontrada nenhuma menção a esse requisito no histórico SVN completo das units envolvidas nesta cópia (`379.48.2.30.74.150.100`); não bloqueia esta correção.

## 8. Dependências e riscos

- **Risco baixo:** a reversão restaura um comportamento que já é o padrão hoje em outro ponto do sistema (`TfrmCancelamentoDocumentos`, fluxo normal de cancelamento interativo, [untCancelamentoDocumentos.pas:1383](../../../padra_atualizado/fontes/cancelamento/untCancelamentoDocumentos.pas)) — não é um comportamento novo/não testado.
- **Mudança de UX esperada:** operadores que hoje conseguem cancelar NE com CTP baixado "no susto" (um passo só) passarão a precisar de dois passos (estornar CTP pela tela própria, depois cancelar a NE) — este é o comportamento correto e intencional, pré-existente antes da regressão do Req. 384736.
- **Dependência:** nenhuma dependência de outros módulos/serviços além do já existente fluxo de Estorno de Contas a Pagar (`TfrmEstornoPagar`).
