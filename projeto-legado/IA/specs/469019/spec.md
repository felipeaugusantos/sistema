# Especificação — Req. 469019

**Título:** Chave duplicada na FORGEF ao transferir código de fornecedor
**Objetivo:** Permitir a transferência de 00005920 (XYZ COM DE PROD AUTOMOTIVOS) para 00005989 (GWT GLOBAL IMPORTACAO EXPORT. LTDA) sem o erro `#23000 Duplicate entry '00005989-00001' for key 'FORGEF.PRIMARY'`.
**Zona:** Legado
**Data:** 2026-10-09

## 1. Contexto / problema atual
- A rotina `TfrmTransfCodFornecedor.fTransfereCodFornecedor` (`padra_atualizado/fontes/util/untTransfCodFornecedor.pas`) troca o código do fornecedor em todas as tabelas filhas via `fAtualizaCodFornecedor` (`UPDATE <tabela> SET <campo> = :FORDES WHERE <campo> = :FORORI`).
- A FORGEF (grupos do fornecedor) tem PK `(FGE_CODFOR, FGE_CODGEF)`. Origem e destino possuem o mesmo grupo `00001`: `('00005920','00001')` e `('00005989','00001')`. O UPDATE tenta gerar `('00005989','00001')` e viola a PK.
- A limpeza de duplicados existente (`TIntegridadeTransferenciaCodigo.pAjustaRegistrosDuplicados`) considera só chaves únicas diferentes de PRIMARY. A FORGEF (`TCA_DELDUP=1` no TCOARR) só tem a PK, então nada é apagado.
- O `Except` silencioso dessa classe é intencional e esconde o problema.

## 2. Módulos e entidades envolvidos
- Módulo: utilitários — transferência de código de fornecedor (DLL `libTransfCodigo.dll`).
- Unit: `padra_atualizado/fontes/util/untTransfCodFornecedor.pas`.
- Tabela: `FORGEF` — PK `(FGE_CODFOR, FGE_CODGEF)`; FK `FK_FORGEF_03` para `CADFOR`, `FK_FORGEF_02` para `GRECFR`. Sem triggers.
- Tabela relacionada: `DEL_FORGEF` (histórico de exclusões, mesma PK; ver Riscos).

## 3. Requisitos funcionais
- RF01 — Antes dos UPDATEs, remover da FORGEF os grupos do fornecedor de origem que o destino já possui.
- RF02 — Grupos que só existem na origem devem migrar para o destino pelo fluxo normal.
- RF03 — A transferência deve concluir sem erro para 00005920 → 00005989.

## 4. Regras de negócio
- RN01 — Em duplicidade, prevalece o registro do destino; o da origem é descartado (mesma semântica do `TCA_DELDUP`).
- RN02 — O DELETE atua apenas na FORGEF e apenas sobre o fornecedor de origem.
- RN03 — A limpeza ocorre dentro da transação de `fTransfereCodFornecedor`; falha posterior desfaz o DELETE (`fRollBack`).
- RN04 — Origem sem grupos, ou sem grupos em comum com o destino, não gera efeito nem erro.

## 5. Requisitos técnicos / não-funcionais
- A classe `TIntegridadeTransferenciaCodigo` NÃO deve ser alterada (decisão do usuário).
- SQL com `ParamByName()`, sem concatenação de valores.
- O `DELETE ... IN (SELECT ...)` sobre a mesma tabela usa subselect aninhado (derived table) por causa do erro 1093 do MySQL.
- Arquivo em cp1252: edição somente via Python com encoding explícito.
- Sem número de requisito em identificadores.

## 6. Critérios de aceitação
- [ ] 00005920 → 00005989 conclui sem erro e a FORGEF fica só com `('00005989','00001')` para esse par.
- [ ] Origem com grupos diferentes do destino: os grupos migram para o destino.
- [ ] Origem sem grupos: transferência normal, sem erro.
- [ ] Falha após o DELETE: rollback restaura a FORGEF.
- [ ] Transferência via importação Excel (`objExcelTrans`) também funciona.
- [ ] Transferência de produto, cidade, conta etc. não é afetada.

## 7. Fora de escopo
- Alterar `untTIntegridadeTransferenciaCodigo.pas` ou o cadastro do TCOARR.
- Outras tabelas filhas de CADFOR (só FORGEF falha com este cenário).
- Outras versões além das listadas em "Working copies contempladas".

## 7.1 Working copies contempladas
- `379.48.2.30.74.150.100` (principal)
- `379.48.2.30.74.150`
- `379.48.2.30.74.150.45`

A mesma correção é aplicada nas três, em `padra_atualizado/fontes/util/untTransfCodFornecedor.pas`.

## 8. Dependências e riscos
- `DEL_FORGEF` tem a mesma PK; o UPDATE com prefixo `DEL_` pode colidir se houver histórico de ambos os fornecedores. Nesta base não há linhas para esses dois fornecedores. Não tratado neste escopo.
- Outras bases de clientes podem ter dados diferentes; a correção é local à FORGEF e de baixo impacto.
