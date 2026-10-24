# Especificação — Req. 464948

**Título:** Transação longa na baixa da conciliação RedeCard (e PagSeguro)
**Objetivo:** encurtar o tempo em que a baixa da conciliação mantém transação aberta e registros travados
**Zona:** Legado (`libCartoes/`)
**Cliente de origem:** PALÁCIO FERRAMENTAS — LOJA 001 (MATRIZ)
**Versões (`vepeal`):** 02.30.74.150, 02.74.150.100, 02.74.150.45
**Data:** 06/10/2026
**Situação:** implementado e testado pelo desenvolvedor; documentação retroativa. Pendente de DelphAI e commit.
**Relacionados:** Req. 449872 (mesma correção na Cielo, r496063); Req. 445076 (desempenho, commit conjunto)

## 1. Contexto / problema atual

Monitoramento de lock: transação aberta das 17:09:03 às 17:11:17 (2m14s), originada em `PRINCIPAL > CONTROLE FINANCEIRO > CONTROLE DE CARTÕES > CONCILIAÇÃO > CONCILIAÇÃO REDECARD ONLINE`. Dados da análise: `DBA_ANALISE_73108952`.

Na baixa da conciliação (analítica `fGravaCartoes` e sintética `fGravaCartoesSin`), uma única transação ficava aberta durante todo o processamento: montagem e gravação, registro a registro, de `MOVBAN`, `CADPAG`, `LOGCTP`, `LOGMCA`, `MOVCAR`, depois a marcação das tabelas de importação. Nesse tempo, registros de `CADCLI`, `MOVCAR` e outros ficavam travados para os demais usuários. O Req. 449872 resolveu isso na Cielo; PagSeguro e RedeCard continuavam no modelo antigo.

## 2. Módulos e entidades envolvidos

- Módulo: `libCartoes` (PagSeguro, RedeCard; Cielo só nos ajustes da seção 4, RN05/RN06)
- Units:
  - `libCartoesPagSeguro/conciliacao/untTPagSeguroBaixaCartoes.pas`, `views/untPagSeguroBaixaCartoes.pas`
  - `libCartoesRedeCard/conciliacao/untTRedeCardBaixaCartoes.pas`, `views/untRedeCardBaixaCartoes.pas`
  - `libCartoesCielo/concilicacao/untTCieloBaixaCartoes.pas`, `views/untCieloBaixaCartoes.pas`
  - `libCentralizado/genericos/BatchSQL/untTBatchSQL.pas`, `untTBatchSQL.Helper.pas` (existentes, do 449872)
- Tabelas gravadas na baixa: `MOVBAN`, `CADPAG`, `LOGCTP`, `MOVCAR`, `LOGMCA` (PK `AUTOINCREM`); tabelas de importação da operadora (`RED_EVDR05`, `RED_EFIR34`, `RED_APPGTO`, `PAG_*`), marcadas como conciliadas.

## 3. Requisitos funcionais

- RF01 — As gravações da baixa (`MOVBAN`, `CADPAG`, `LOGCTP`, `LOGMCA`, atualização da data bancária na `MOVCAR`) são acumuladas num lote (`TBaixaCartoes.BatchSQL`) durante o processamento, sem transação aberta.
- RF02 — No fim, o lote é executado numa transação curta (transação 1), com barra de progresso por lote ("Aguarde... Gravando baixa.").
- RF03 — A marcação de conciliado nas tabelas de importação roda numa segunda transação (transação 2), depois da confirmação da baixa.
- RF04 — Mensagens de processamento: "Aguarde... Processando registros conciliados." enquanto monta o lote; "Aguarde... Finalizando baixa." na marcação.

## 4. Regras de negócio

- RN01 — **Transferências** (`GravaMovBanDeTransferencias`, só PagSeguro e RedeCard) gravam direto, fora do lote, **dentro da transação 1**, logo após a execução do lote e antes do commit. Se falharem, a baixa inteira é desfeita, como antes. Na RedeCard, mantida a condição `blnConcil`.
- RN02 — **Marcação (transação 2):** PagSeguro usa `MarcarComoConciliado`. RedeCard usa `MarcarComoConciliado` para `RED_EFIR34` e `MarcarComoConciliadoRedeCardAPI` para as demais; na sintética, só com `blnConcil`, como antes.
- RN03 — **RedeCard, `fSetaDupBaixadasRede`** (marca `RED_EVDR05` e demais tabelas de importação): roda em `fBaixaDuplicatas`, depois da baixa confirmada, numa **transação própria** (transação 3).
  - Se só ela falhar, a baixa e a marcação da transação 2 permanecem gravadas, e a marcação da transação 3 é desfeita.
  - Antes, tudo era desfeito junto. É a mesma decisão do 449872 para a marcação.
- RN04 — Em erro, o rollback só é feito se houver transação aberta (`EstaEmTransacao`).
- RN05 — **Contas a pagar da taxa de negociação** (`GravaCadPagTaxasNegociacao`, chamado pelo `GravaCadPagAjustes` quando o ajuste tem taxa > 0) também vai para o lote. Os parâmetros 60 a 89 de `TLibCartoesCadPag.GravaCadPag` recebem os padrões da assinatura, conferidos um a um, e o 90º recebe `FBatchSQL`. Corrige o comportamento herdado do 449872, em que essa conta a pagar e o seu `LOGCTP` eram gravados na hora, sem transação. Aplicado em Cielo, PagSeguro e RedeCard.
- RN06 — A query que executa o lote (`LExecutaScripts`, criada sem dono) é liberada no `finally` da baixa analítica **e da sintética**. A sintética não liberava, nas três conciliações (herdado do 449872). Aplicado em Cielo, PagSeguro e RedeCard.
- RN07 — Rotinas da PagSeguro e da RedeCard sem equivalente na Cielo foram mantidas: vendas canceladas só existem na Cielo e não foram portadas; `arrNumNsu` e o fluxo `RED_EFIR34` permanecem como estavam.

## 5. Requisitos técnicos / não-funcionais

- Transação: substitui uma transação longa por até três curtas (baixa; marcação; na RedeCard, `fSetaDupBaixadasRede`).
- Ordem de gravação preservada: lote na ordem de montagem; transferências depois do lote.
- Sem alteração fiscal. No financeiro, os mesmos lançamentos de antes; muda só o momento e a transação em que são gravados.
- Encoding: fontes em cp1252 com CRLF, sem caracteres corrompidos.

## 6. Critérios de aceitação

- [x] Baixa analítica e sintética da RedeCard (arquivo e API) e da PagSeguro (arquivo e API) gravam os mesmos lançamentos da versão anterior.
- [x] A transação da baixa fica aberta só durante a execução do lote, e não durante todo o processamento.
- [x] Transferências gravadas junto com a baixa.
- [x] Registros de importação marcados como conciliados após a baixa.
- [ ] Baixa com negociação de recebíveis com taxa: conta a pagar da taxa e `LOGCTP` gravados no lote (RN05).
- [ ] Parecer APROVADO do DelphAI.

## 7. Fora de escopo

- Demais conciliações (Getnet, Stone, Sipag etc.): continuam com a transação longa.
- `GravaMovBanDeTransferencias` continua gravando direto, sem lote, mas dentro da transação 1 (RN01).
- O fluxo de baixa só de transferências (`ApenasBaixaDeTransferencias`), que tem transação própria: não alterado.

## 8. Dependências e riscos

- Depende de `untTBatchSQL` / `untTBatchSQL.Helper` (Req. 449872), já presentes nos `.dpr` de PagSeguro e RedeCard.
- Commit conjunto com o Req. 445076 (mesmos arquivos de tela de baixa).
- RN03 muda a consequência de falha do `fSetaDupBaixadasRede` (baixa já confirmada).
- RN05 e RN06 alteram também a Cielo, cujo 449872 já está no SVN: a `untTCieloBaixaCartoes.pas` entra no commit.
