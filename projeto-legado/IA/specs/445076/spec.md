# Especificação — Req. 445076

**Título:** Desempenho da conciliação de cartões (Cielo, PagSeguro e RedeCard)
**Objetivo:** reduzir o consumo de CPU e o tempo da conciliação sem alterar o resultado conciliado
**Zona:** Legado (`libCartoes/`)
**Cliente de origem:** BELA TINTAS — LOJA 033/013/006 (MATRIZ)
**Versões (`vepeal`):** 02.30.74.150, 02.74.150.100, 02.74.150.45, 02.74.150.95
**Data:** 06/10/2026
**Situação:** implementado e testado pelo desenvolvedor; documentação retroativa. Pendente de DelphAI e commit.

## 1. Contexto / problema atual

Menu: `PRINCIPAL > CONTROLE FINANCEIRO > CONTROLE DE CARTÕES > CONCILIAÇÃO > CONCILIAÇÃO CIELO` (e equivalentes de PagSeguro e RedeCard).

A conciliação consumia CPU por longos períodos na estação do usuário. As causas encontradas:

- **Busca por `Locate`**: para cada registro do arquivo da operadora, `fBuscaCartao` / `fBuscaCartaoBaixado` faziam até 6 `Locate` sequenciais em `cdsBaiCar` (cartões em aberto) e `cdsBaixad` (cartões já baixados). Os campos de busca não batem com o índice do dataset, então cada `Locate` percorre o dataset inteiro — custo quadrático em clientes com muitos cartões.
- **Consultas repetidas ao banco** para nome de fornecedor, portador, centro de custos, empresa e operador (uma por cartão) e para a lista de campos do `LOGMCA` (uma por gravação de log).
- **`Application.ProcessMessages`** em laços longos, e `AfterScroll` da grade de baixa disparando durante a configuração do grid e antes da tela estar pronta.
- Lista de datas do período (`lstDtaCad`) montada com `IndexOf` linear.

## 2. Módulos e entidades envolvidos

- Módulo: `libCartoes` (DLLs de conciliação por operadora + `libCentralizado`, compartilhado)
- Units principais:
  - `libCentralizado/classes/untTIndiceBuscaCartao.pas` (nova)
  - `libCentralizado/genericos/untTLibCartoesFuncoes.pas`, `untLibCartoesLogMca.pas`
  - `libCartoesCielo/concilicacao/untCieloConciliacaoCartoes.pas`, `untConciliacaoCielo.pas`
  - `libCartoesPagSeguro/conciliacao/untPagSeguroConciliacaoCartoes.pas`, `untConciliacaoPagSeguro.pas`, `untConciliacaoPagSeguroApi.pas`
  - `libCartoesRedeCard/conciliacao/untRedeCardConciliacaoCartoes.pas`, `untConciliacaoRedeCard.pas`, `untConciliacaoRedeCardAPI.pas`
  - Telas de baixa (`views/unt*BaixaCartoes.pas`) de 14 conciliações
- Tabelas (somente leitura nesta parte):
  - `MOVCAR` — PK `AUTOINCREM` (exposto nos datasets como `AUTOINC`)
  - `LOGMCA` — PK `AUTOINCREM`
  - `CADFOR`, `CADPOR`, `CADEVE`, `CADEMP`, `CADOPE` — consultadas para os caches de nomes

## 3. Requisitos funcionais

- RF01 — As buscas de cartão em aberto (`fBuscaCartao`) e de cartão já baixado (`fBuscaCartaoBaixado`), e as buscas por ID de transação da PagSeguro, deixam de usar `Locate` e passam a usar índices em memória (`TIndiceBuscaCartao`), com as mesmas chaves e a mesma ordem de tentativas de antes.
- RF02 — O registro devolvido por cada busca é o mesmo que o `Locate` original devolveria: o primeiro, na ordem do índice corrente do dataset, que satisfaz a chave.
- RF03 — Os índices são criados (`CarregaIndicesBusca`) logo após a montagem dos datasets, em todos os fluxos que buscam: Cielo; PagSeguro arquivo e API; RedeCard arquivo (débito, crédito e negociação) e API.
- RF04 — Nomes de fornecedor, portador, centro de custos, empresa e operador são lidos uma vez por conciliação e mantidos em cache (`TLibCartoesFuncoes.RetornaNome*`). O cache é descartado ao fechar a conciliação (`DestroiDicionariosCache` nas exports).
- RF05 — A lista de campos do `LOGMCA` é montada uma vez por execução (`GeraListaDeCamposLOGMCA`), em vez de a cada gravação de log.
- RF06 — Nas telas de baixa, o `AfterScroll` da grade e o foco em Confirmar só são ligados depois da criação da configuração do grid (`pAbreConciliacao`). Na configuração do grid (`btnConfigurarGridClick`), o `AfterScroll` é desligado enquanto a configuração está aberta, religado ao fechar e os dados da linha corrente são atualizados.
- RF07 — `Application.ProcessMessages` em laços da conciliação passa para `T*Funcoes.pProcessMessages`.

## 4. Regras de negócio

- RN01 — **Resultado da conciliação inalterado.** As chaves de cada índice são exatamente os campos dos `Locate` originais:
  - `cdsBaiCar`: `MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES` e as variações sem empresa, só autorização e só NSU, sempre com `MCA_MARDES = 'D'`.
  - `cdsBaixad`: `MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX` e as mesmas variações. `VALIDADO` **não** faz parte da chave, porque o `Locate` original não o considerava.
- RN02 — **Conferência obrigatória.** Ao posicionar pelo `RecNo` guardado, o índice confere:
  - (1) Se o `AUTOINCREM` do registro é o mesmo da carga. Se não for, as posições mudaram; o índice recarrega e busca de novo, uma vez.
  - (2) Se o registro ainda tem a chave procurada. Se não tiver (ex.: `MCA_MARDES` virou `'M'`), segue para o próximo registro da mesma chave.

  Nunca devolve registro errado: o pior caso é recarregar.
- RN03 — **Recarga automática.** Se `IndexFieldNames`, `Filter`, `Filtered` ou a quantidade de registros do dataset mudarem (ex.: `Append` de ajuste de parcela no meio da conciliação), o índice se recarrega antes da próxima busca.
- RN04 — Sem achar, o cursor volta para onde estava, como no `Locate`.
- RN05 — Os índices dos datasets (`IndexFieldNames` em `pFiltraCartoes` / `pFiltraCartoesBaixados`) permanecem como no SVN. A ordem da grade da tela de baixa e o laço de "outras liberações com a mesma autorização" não mudam.
- RN06 — **PagSeguro, última busca sem empresa:** repete a busca por autorização em vez de buscar por NSU. Isso é intencional (Req. 427076, r458814) e foi **preservado**.
- RN07 — Comparação de texto como no `Locate` original: autorização e NSU buscados em maiúsculas; o valor gravado não é convertido. Datas comparadas por dia (`yyyymmdd`).

## 5. Requisitos técnicos / não-funcionais

- Desempenho: busca O(1) amortizada por chave; carga do índice O(n), preguiçosa (só na primeira busca que usa aquele índice).
- `cdsBaixad` passa a trazer `MOVCAR.AUTOINCREM AS AUTOINC`, para a conferência da RN02. A consulta não tem agrupamento, então a coluna não altera as linhas.
- Encoding: fontes em cp1252 com CRLF, sem caracteres corrompidos.
- Sem alteração de permissão, auditoria ou impacto fiscal. O impacto financeiro é nulo pela RN01.

## 6. Critérios de aceitação

- [x] Conciliação Cielo da BELA TINTAS com o mesmo resultado da versão anterior (cartões conciliados, inconsistências, relatório) e tempo/CPU menores.
- [x] Conciliação PagSeguro (arquivo e API) e RedeCard (arquivo e API) com o mesmo resultado da versão anterior.
- [x] Conciliação com "AJUSTE DE PARCELA" e `BAIDEB` ligado concilia os cartões corretos (cenário que motivou a RN02/RN03).
- [x] Na tela de baixa, abrir e fechar a configuração do grid mantém a linha selecionada e atualiza os dados dela.
- [ ] Parecer APROVADO do DelphAI.

## 7. Fora de escopo

- Os `Locate` das telas de baixa (`fVerificaPorCta`, transferências): não fazem parte do laço de conciliação.
- As buscas por ID de transação da `TConcilPagSeguroApi`, que tem implementação própria com `Locate` e não foi alterada.
- `libCartoesMobbuy/conciliacao/views/untRedeCardBaixaCartoes.pas`: não está no `.dpr` da Mobbuy, não é compilada.
- Transações da baixa: tratadas no Req. 464948 / 449872.

## 8. Dependências e riscos

- `libCentralizado` é compartilhado: `untTLibCartoesFuncoes`, `untLibCartoesLogMca` e `untLibCartoesInterfacesTipos` entram no build de todas as DLLs de cartões.
- Commit conjunto com o Req. 464948: a tela de baixa da RedeCard e as `untT*BaixaCartoes` de PagSeguro e RedeCard têm alterações dos dois requisitos.
- Edição que faça um registro **passar** a ter uma chave depois da carga só é vista após recarga (documentado na classe). Nenhum fluxo atual faz isso.
- **Recarga após `Append`** (ajuste de parcela com `BAIDEB` ligado, em `GravarRegistroDeAjusteParaConciliacao`): cada `Append` faz recarregar, uma vez, os índices usados depois dele. O custo é A × k × n (A = Appends ≤ linhas de ajuste; k ≤ 6 índices), contra R × 6 × n do `Locate` original. Nunca é maior; só empata se todas as linhas forem ajustes incluídos. Trocar `RecNo` por *bookmark* para evitar a recarga fica como melhoria futura, fora deste requisito (decisão na revisão do DelphAI, 08/10/2026).
