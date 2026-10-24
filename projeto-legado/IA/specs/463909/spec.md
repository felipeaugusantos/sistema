# Especificação — Req. 463909

**Título:** Duplicidade de estoque na entrada de TE + NF de confirmação (fornecedor filial)
**Objetivo:** Impedir que a entrada de mercadorias gere duplicidade de estoque quando uma TE (transferência entre empresas/lojas) e sua respectiva NF de confirmação ficam ambas pendentes de baixa de pedido de compra, permitindo que a rotina de Efetivação do Movimento Fiscal efetive as duas e duplique a entrada em estoque.
**Zona:** Legado
**Data:** 28/09/2026

## 1. Contexto / problema atual

Cenário relatado (cliente Montanna Distribuidora):

1. Foi emitida a TE 000001006444 saindo da empresa 001 para a empresa 201.
2. A TE foi confirmada em NF (NF 000000241325).
3. Na "Entrada de Mercadorias Simplificada - Entre Lojas", apareceu apenas a TE, exibindo o vínculo entre o documento 000001006444-TE e o documento 000000241325-NF.
4. O cliente importou o XML da NF 000000241325 e, no mesmo momento, também foi possível dar entrada na TE pela Entrada Simplificada.
5. Na rotina de Efetivação do Movimento Fiscal, os dois documentos (TE e NF) ficaram disponíveis para efetivação e ambos foram efetivados.
6. Resultado: os produtos entraram em duplicidade no estoque.

O motivo de o cliente ter importado o XML da NF (em vez de seguir só pela Entrada Simplificada) é viabilizar o vínculo da entrada a um pagamento antecipado, recurso que a rotina de Entrada Simplificada não oferece.

Investigação técnica (ver `plan.md`) identificou que, para fornecedor do tipo filial (`Pos(strCodFor, strForFil) > 0`), a baixa do pedido de compra vinculado ao documento de entrada (`fBaixaPedidosEntrada`, em `untPcmGer.pas`) pode ficar pendente para ser realizada posteriormente pela rotina de Efetivação do Movimento Fiscal (`TEfetivaMovimentoFiscal.pEfetiva`), em vez de ocorrer já no momento da confirmação da entrada. Essa baixa pendente é o que sustenta a janela em que TE e NF aparecem simultaneamente passíveis de efetivação.

## 2. Módulos e entidades envolvidos

- Módulo: movimentacaoitens (Entrada de Mercadorias / Confirmação de Entrada)
- Unit: `padra_atualizado/fontes/movimentacaoitens/untPcmGer.pas`
  - Function: `fConfirmaEntradaMercadorias` → nested function `fBaixaPedidosEntrada`
- Rotinas relacionadas (contexto, fora do escopo de alteração deste requisito):
  - `padra_atualizado/fontes/movimentacaoitens/untEntradaSimplificada.pas` (listagem de documentos pendentes, TE/NF)
  - `padra_atualizado/fontes/movimentacaoitens/untEntMercadoriasEfetivaMovFiscal.pas` (listagem de pendentes de efetivação fiscal)
  - `padra_atualizado/fontes/movimentacaoitens/untEfetivaMovimentoFiscal.pas` (`TEfetivaMovimentoFiscal.pEfetiva` — efetivação do documento)
- Tabelas envolvidas: `MOVGER` (documento geral — TE/NF), `PCMGER`/`PCMDET` (pedido de compra), `CADFOR` (cadastro de fornecedor), `AUXMOV` (marcação de fluxo de Entrada Simplificada)

## 3. Requisitos funcionais

- RF01 — Quando o fornecedor da entrada for do tipo filial (`Pos(strCodFor, strForFil) > 0`), a baixa do pedido de compra vinculado ao documento de entrada deve ocorrer imediatamente durante a confirmação da entrada de mercadorias, e não ficar pendente para a rotina de Efetivação do Movimento Fiscal.

## 4. Regras de negócio

- RN01 — A condição de baixa imediata do pedido de compra em `fBaixaPedidosEntrada` deve passar a considerar também o caso em que a baixa ficaria pendente (`fZeraDataEntrada(ValidacaoZeraData) = True`) e o fornecedor for filial (`Pos(strCodFor, strForFil) > 0`): `Or ( fZeraDataEntrada(ValidacaoZeraData) and (Pos(strCodFor, strForFil) > 0) )`, além das condições já existentes (`Not fZeraDataEntrada(ValidacaoZeraData)` e `blnGarantia`). A nova cláusula é condicionada ao próprio `fZeraDataEntrada` para não alterar o comportamento dos demais ramos da function.
- RN02 — As demais condições e ramos da function (`blnConferenciaDepoisDaEntrada and blnUtilizarCFG_CLARET`, tratamento de `oleItensPedidos`, laço sobre `stlPedidosCompra`) permanecem inalterados — a mudança afeta apenas qual ramo é acionado, não a lógica interna de cada ramo.

## 5. Requisitos técnicos / não-funcionais

- Alteração cirúrgica, sem refatoração do restante da function (zona Legado).
- Arquivo `.pas` em encoding cp1252 (Windows-1252) — edição deve preservar encoding e não corromper acentuação.

## 6. Critérios de aceitação

- [ ] Ao confirmar uma entrada de mercadorias (TE ou NF) cujo fornecedor seja filial (`Pos(strCodFor, strForFil) > 0`), o pedido de compra vinculado é baixado imediatamente, não ficando mais pendente para a Efetivação do Movimento Fiscal.
- [ ] Reproduzindo o cenário do ticket (TE de fornecedor filial + NF de confirmação com XML importado), após a entrada de um dos documentos o outro deixa de permitir entrada/efetivação em duplicidade.
- [ ] Nenhuma regressão nos demais fluxos de entrada de fornecedor filial que hoje dependem de `blnConferenciaDepoisDaEntrada`/CFG_CLARET ou `blnGarantia`.

## 7. Fora de escopo

- Alteração da listagem/filtro de documentos pendentes em `untEntMercadoriasEfetivaMovFiscal.pas` (tela de Efetivação do Movimento Fiscal).
- Alteração da trava de efetivação em `untEfetivaMovimentoFiscal.pas::pEfetiva`.
- Qualquer alteração na rotina de Entrada Simplificada (`untEntradaSimplificada.pas`).
- Criação de vínculo explícito (FK) entre TE e NF de confirmação em banco de dados.

## 8. Dependências e riscos

- Risco: antecipar a baixa do pedido de compra para fornecedor filial pode impactar outros fluxos de entrada que hoje dependem da baixa deferida (ex.: conferência pós-entrada com CFG_CLARET). Mitigação: validar com o solicitante outros cenários de entrada de fornecedor filial, além do caso TE/NF relatado.
- Dependência: comportamento correto depende de `strForFil` estar corretamente populado (`fRetForFilialTodos`) no momento da chamada de `fBaixaPedidosEntrada`.
