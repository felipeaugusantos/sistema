# Especificação — Req. 462266

**Título:** Cancelamento de NE (Entrada de Mercadoria) do sistema anterior bloqueado indevidamente pela validação de data de balanço
**Objetivo:** permitir o cancelamento de uma Nota de Entrada (NE) cuja finalidade XML seja "Entrada Mercadorias sistema anterior p/ emissão de devolução" (GERELE.GER_TIPXML = 4) sem executar a validação de data de venda x data de balanço.
**Zona:** Legado (`padra_atualizado/fontes/cancelamento`)
**Data:** 17/09/2026

## 1. Contexto / problema atual

No cliente COMAX (LJ001), o usuário PERCEU não conseguiu cancelar a NF de entrada nº 883370 (NE), recebendo a mensagem:

> "Cancelamento não permitido pois documento possui itens em que a data de venda é menor que o balanço!"

Essa mensagem é emitida por `TfrmCancelamentoDocumentos.fVerificaSalBal` (unit `untCancelamentoDocumentos.pas`), que compara `MOVDET.DET_DTAENT` com a data de balanço do item (`fRetDataSalBal`) para qualquer espécie de documento na lista `NE_OF_TE_BR_AJ_RQ_TR_DV_NF_EL_NS_IF_IV_D1_MI_FF_PI_UC_TA_TL_CS_CR_GF_GR_GC_GA_NG_NR_EF_RL_`.

O documento em questão foi importado do sistema anterior apenas para viabilizar a emissão de uma devolução — não gera movimentação de estoque real. Esse cenário já é tratado na tela de **Entrada de Mercadorias**: `TfrmEntMercadorias.fVerificaDataBalanco` (`untEntMercadorias.pas:10590`) já dá `Exit` imediatamente quando `recNotEle.finalidadeXML = xmlEntradaMercadoriasSistemaAnteriorDevolucao` (equivalente a `GERELE.GER_TIPXML = 4`), pois documentos com essa finalidade não devem ser validados contra o balanço.

O cancelamento (`fVerificaSalBal`) não tem essa mesma checagem porque não recebe `recNotEle` — só recebe `strEspSel`, `strNumDoc` e `strCodCli`. É necessário consultar a tabela `GERELE` para obter o `GER_TIPXML` do documento, quando `strEspSel = 'NE'`.

Causa raiz correlata (contexto, não é objeto desta correção): a quantidade incorreta cadastrada na aba "Embalagens" do produto gerou precificação incorreta na devolução — motivo pelo qual o cliente precisa cancelar e reimportar o documento. Fora de escopo aqui.

## 2. Módulos e entidades envolvidos

- Módulo: Cancelamento de Documentos
- Unit principal (74.150.45): `padra_atualizado/fontes/cancelamento/untCancelamentoDocumentos.pas` — função `TfrmCancelamentoDocumentos.fVerificaSalBal`
- Unit equivalente em `379.48.2.30.74.150` e `379.48.2.30.74.150.100`: `untCancelaDocumentosValidacoes.pas` — função `fVerificaSalBal`
- Referência de comportamento já existente: `padra_atualizado/fontes/movimentacaoitens/untEntMercadorias.pas` — `TfrmEntMercadorias.fVerificaDataBalanco`
- Tabelas: `MOVDET` (chave: `DET_NUMDOC` + `DET_ESPDOC` + `DET_CODEMP` + `DET_CODFOR`/`DET_CODCLI`), `GERELE` (chave: `AUTOINCREM`; colunas usadas: `GER_ESPENT`, `GER_DOCENT`, `GER_EMPENT`, `GER_CODFOR`, `GER_TIPXML`)
- Enum: `tpeFinalidadeXML` em `untTypesSistema.pas` — `xmlEntradaMercadoriasSistemaAnteriorDevolucao = 4`

## 3. Requisitos funcionais

- RF01 — Ao cancelar um documento de espécie `NE` (Entrada de Mercadoria), antes de aplicar a validação de data de venda x balanço, o sistema deve consultar `GERELE` para obter `GER_TIPXML` do documento.
- RF02 — Se `GER_TIPXML` corresponder a "Entrada Mercadorias sistema anterior p/ emissão de devolução" (valor 4 / `xmlEntradaMercadoriasSistemaAnteriorDevolucao`), a validação de data de balanço deve ser ignorada (sair da função permitindo o cancelamento, sem exibir a mensagem de bloqueio).
- RF03 — Para qualquer outra espécie de documento (`OF_TE_BR_AJ_RQ_TR_DV_NF_EL_NS_IF_IV_D1_MI_FF_PI_UC_TA_TL_CS_CR_GF_GR_GC_GA_NG_NR_EF_RL_`) ou para `NE` sem essa finalidade, o comportamento atual deve ser mantido inalterado.

## 4. Regras de negócio

- RN01 — A consulta a `GERELE` só é executada quando `strEspSel = 'NE'`.
- RN02 — O join com `GERELE` segue o padrão já usado no restante do projeto (ex.: `fRetAutoIncremGerEle`, `untConsultas.pas:16148`): `GER_ESPENT` = espécie de cancelamento resolvida (`fRetornaEspecieCancelamento(strEspSel)`, tipicamente `'NF'`), `GER_DOCENT` = `strNumDoc`, `GER_EMPENT` = `VS_strCodEmp`, `GER_CODFOR` = `strCodCli` (para `NE`, `strCodCli` já representa o fornecedor — ver `fRetSQLCodCli`).
- RN03 — Se não houver registro em `GERELE` para os parâmetros informados, a validação de balanço segue normalmente (sem alterar o comportamento atual) — a nova checagem só interrompe o fluxo quando encontra `GER_TIPXML = 4`.

## 5. Requisitos técnicos / não-funcionais

- Reutilizar as variáveis já existentes na função: `strSQL` para montar o SELECT e `qryGenDet` para executar a consulta (sem criar uma segunda `TUniQuery`).
- Não usar `Now`/`NOW()` — não se aplica aqui (não há gravação).
- Manter `ParamByName()` — sem concatenação de valores no SQL.

## 6. Critérios de aceitação

- [ ] Cancelamento de um documento `NE` com `GERELE.GER_TIPXML = 4` não exibe mais a mensagem de bloqueio por data de balanço, mesmo com itens cuja `DET_DTAENT` seja anterior à data de balanço.
- [ ] Cancelamento de um documento `NE` "normal" (`GER_TIPXML <> 4`) continua bloqueando quando há item com `DET_DTAENT` anterior ao balanço (comportamento atual preservado).
- [ ] Cancelamento de documentos de outras espécies (`OF`, `TE`, `NF`, etc.) não sofre nenhuma alteração de comportamento.
- [ ] Reprodução do caso relatado: NF 883370 (COMAX, LJ001) pode ser cancelada sem a mensagem de erro.

## 7. Fora de escopo

- Correção da quantidade cadastrada na aba "Embalagens" do produto (causa da precificação incorreta na devolução).
- Qualquer ajuste na tela de Entrada de Mercadorias (`untEntMercadorias.pas`) — a validação lá já está correta e serve apenas de referência.
- Execução de `/citel-aprovaRequisito`, gate DelphAI ou commit — ficam para quando o usuário solicitar.

## 8. Dependências e riscos

- Dependência: `GERELE` deve conter o registro correspondente ao documento de entrada original para que a nova checagem funcione; se o documento não tiver `GERELE` correspondente (ex.: fluxo divergente), o comportamento cai no caminho já existente (validação de balanço normal).
- Risco: join incorreto (`GER_CODFOR` vs `GER_CODCLI`) permitiria cancelar documentos que não deveriam, ou continuaria bloqueando indevidamente — mitigado seguindo exatamente o padrão de join já usado em outras units do projeto (`untConsultas.pas`, `fRetAutoIncremGerEle`).
- Réplica necessária em `379.48.2.30.74.150` e `379.48.2.30.74.150.100` (unit `untCancelaDocumentosValidacoes.pas`, função `fVerificaSalBal`, assinatura diferente da usada em 74.150.45).
