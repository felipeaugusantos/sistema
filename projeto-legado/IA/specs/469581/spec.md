# Especificação — Req. 469581

**Título:** NF duplicada em dois agendamentos de recebimento (AGEDOC)
**Objetivo:** Impedir que a mesma NF fique vinculada a mais de um agendamento e que seja recebida em duas estações ao mesmo tempo.
**Zona:** Legado
**Data:** 2026-10-13

## 1. Contexto / problema atual
Em 2026-10-09 a NF 000000080187 (série 3, fornecedor 00005593, espécie NF, empresa 003) ficou em dois agendamentos:

| Agendamento | Origem | Gravação | Transportadora |
|---|---|---|---|
| 311563 | Menu "Agendamento de Recebimento de Mercadorias" (operador 687) | 08:53:25 | 00041 |
| 311562 | Fluxo de Processo de Compras (operador 641) | 08:55:19 | 00040 |

- O operador do fluxo estava com a tela aberta desde 08:34:43. O grid do fluxo é uma foto do banco no momento da carga (coluna "Agendamento" calculada por JOIN AGEREC/AGEDOC), então continuava mostrando `REALIZAR`.
- `pOnRealizar` (untProcessoCompras) só valida direito de acesso e abre `TfrmCadAgendamentodeEntrega`; não trava nem rechecka.
- O form de agendamento tem checagem (`fVerificaDocumentoOutosAgendamentos`, na inclusão e em `fVerificaDocumentos` ao gravar), mas é um SELECT não atômico: não há índice único em AGEDOC (existe só o `IDX_AGEDOC_05`, comum). Por que a checagem não barrou o segundo agendamento não foi esclarecido; a hipótese é versão de executável ou caminho não mapeado.
- A única trava existente (`untRecebimentoEntregaAgendada`, chave `frmRecebimentoEntregaAgendada_<emp>_<ARC_CODIGO>`) é por **agendamento**, não por documento: dois agendamentos com a mesma NF têm chaves diferentes e podem ser recebidos em paralelo.
- Estado atual: AGEDOC tem 2 grupos duplicados (NF 000000080187 e NF 000000680767).

## 2. Módulos e entidades envolvidos
- Módulo: movimentacaoitens (Recebimento de Entrega Agendada), cadastros (Agendamento de Entrega).
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untRecebimentoEntregaAgendada.pas`
  - `padra_atualizado/fontes/cadastros/untCadAgendamentodeEntrega.pas`
- Tabelas: AGEDOC (PK `AUTOINCREM`; vínculo `ADC_SEQGER` → AGEREC.AUTOINCREM), AGEREC (PK `AUTOINCREM`, código `ARC_CODIGO`), GERELE.
- Colunas da chave de negócio em AGEDOC: `ADC_NUMDOC`, `ADC_ESPDOC`, `ADC_SERIE_`, `ADC_CODFOR`, `ADC_CODEMP` (todas aceitam NULL).

## 3. Requisitos funcionais
- RF01 — AGEDOC não pode ter duas linhas com a mesma combinação `ADC_NUMDOC + ADC_ESPDOC + ADC_SERIE_ + ADC_CODFOR + ADC_CODEMP` (UK no banco).
- RF02 — No Recebimento de Entrega Agendada, ao carregar o agendamento (`fCarregaDocumentos`), cada NF do agendamento deve ser travada por NF, tanto na entrada pelo fluxo (`pCarregaDocumentoExterno`) quanto pelo menu.
- RF03 — Se alguma NF já estiver travada por outra estação, o agendamento não é carregado, as travas já obtidas são liberadas e o operador é informado de quem está com o documento.
- RF04 — As travas por NF são liberadas: (a) após o `COMMIT` da confirmação; (b) em caso de erro/exceção em `btnConfirmaClick` ou rollback por falha do plano de recebimento — nesse caso o recebimento também é limpo (`pLimpaDocumento` e `pLimpaAgendamento`), obrigando o operador a recarregar o agendamento e refazer as travas; (c) ao fechar o form (`FormClose` quando o fechamento é efetivado, e `FormDestroy` como garantia); (d) no cancelamento do recebimento carregado. O grid do Recebimento é somente leitura (`OptionsData.Deleting = False`, sem tratamento de tecla Delete), então não há exclusão de documento do grid a tratar nessa tela.
- RF05 — Em `btnGravarClick` do agendamento, o erro de chave duplicada (1062) da UK deve resultar em mensagem clara ao operador.

## 4. Regras de negócio
- RN01 — Chave da trava por NF: `AGEDOC_<ADC_NUMDOC>_<ADC_ESPDOC>_<ADC_SERIE_>_<ADC_CODFOR>_<ADC_CODEMP>`, montada igual nas duas entradas.
- RN02 — A trava por NF convive com a trava existente por agendamento; esta não é removida.
- RN03 — Falha ao travar a N-ésima NF desfaz as N-1 anteriores (tudo ou nada).
- RN04 — Antes de abrir a transação em `btnConfirmaClick`, confirmar que as travas por NF ainda pertencem à conexão atual; se não, abortar com mensagem e sem gravar.
- RN05 — A UK não cobre linhas com campo NULL; os `INSERT` atuais do form preenchem as cinco colunas.
- RN06 — O índice `IDX_AGEDOC_05` permanece (o `untFluxoCompras` o verifica por nome e usa `FORCE INDEX`).

## 5. Requisitos técnicos / não-funcionais
- Encoding: units em cp1252/CRLF; edição somente via Python com encoding explícito.
- Nomes de identificadores novos sem o número do requisito, no padrão Hungarian da unit.
- Transação: nenhuma mudança no fluxo de `fStartTransaction`/`fCommit`/`fRollback` existente.
- Script da UK entregue apenas em tela/chat (sem arquivo `.sql`).

## 6. Critérios de aceitação
- [ ] `ALTER TABLE AGEDOC ADD UNIQUE KEY UK_AGEDOC_01 (...)` executa sem erro em base sem duplicados.
- [ ] Com a UK, gravar a mesma NF em dois agendamentos resulta em mensagem clara (sem texto cru do banco).
- [ ] Duas estações, agendamentos distintos com a mesma NF: a segunda a carregar no Recebimento é bloqueada com a mensagem de quem está com o documento, tanto pelo fluxo quanto pelo menu.
- [ ] Após confirmar o recebimento (COMMIT), a NF fica livre para consulta por outra estação.
- [ ] Cancelar o recebimento carregado e fechar o form liberam as travas.
- [ ] Erro/exceção na confirmação do recebimento libera as travas das NFs.
- [ ] Após erro na confirmação, o recebimento fica limpo e as travas liberadas; recarregar o agendamento refaz as travas.
- [ ] Falha na trava da 2ª NF de um agendamento libera a trava da 1ª.
- [ ] Mesmo comportamento replicado em 74.150 e 74.150.100.

## 7. Fora de escopo
- Trava por NF no form de agendamento (`untCadAgendamentodeEntrega`), exceto o tratamento do erro 1062.
- Correção dos duplicados existentes em AGEDOC (feita manualmente no cliente).
- Alteração do fluxo de compras (`untFluxoCompras`/`untProcessoCompras`) ou do `IDX_AGEDOC_05`.
- Descobrir por que a checagem existente não barrou o segundo agendamento.

## 8. Dependências e riscos
- A UK só pode ser criada com AGEDOC sem duplicados (ajuste manual prévio).
- Trava presa por queda de estação com a tela aberta (mesmo risco das travas existentes).
- Agendamentos com muitas NFs geram várias chamadas de trava na carga.
- Bases com NULL em colunas da chave escapam da UK.
