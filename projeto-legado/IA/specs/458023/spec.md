# Especificação — Req. 458023

**Título:** Consulta de Produtos (Descrição Livre) exige "/" no final do termo para trazer todos os resultados esperados
**Objetivo:** Fazer a busca por "Descrição Livre" na Consulta de Produtos retornar, sem necessidade de truques de digitação, o mesmo conjunto de resultados que hoje só é obtido incluindo uma barra ("/") no final do termo pesquisado.
**Zona:** Legado
**Data:** 2026-08-25

## 1. Contexto / problema atual

Tela: **PRINCIPAL > FATURAMENTO > CONSULTA DE PREÇOS > CONSULTA DE PRODUTOS** (`untConsultaPreco.pas`, que abre a rotina compartilhada `fPesqItem` em `untPesqItem.pas`).

No campo "Descrição Livre", pesquisar um termo terminado em `/` (ex.: `//FCI1660/`) retorna **mais resultados** do que pesquisar o mesmo termo sem a barra final (ex.: `//FCI1660`). Segundo o cliente (Dênis, ticket Zendesk 1641522), essa necessidade de incluir `/` no final nunca existiu antes e passou a ser necessária recentemente para obter os resultados corretos.

### Causa raiz identificada (análise técnica)

O campo "Descrição Livre" filtra pelo campo `ITEPESQUI` (alias de `CADITE.ITE_PESQUI`). Em produção, `CFG_ITPMOD = '3'` (confirmado em `CFGSIS`), o que direciona a busca para `TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken` (`untFuncoesGenCompartilhada.pas`, linhas 101-191).

Essa função usa o caractere `/` **como marcador de controle da própria lógica de busca**, não como dado a ser pesquisado:

- Termo **sem** `/` no final → a função monta `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+| _TERMO_ |*' IN BOOLEAN MODE)` — busca por **token exato delimitado** (o termo precisa aparecer isolado por delimitadores no texto indexado).
- Termo **com** `/` no final → o `/` é convertido internamente em curinga (`AFilter.Replace('/', '* ')`), e a função monta `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+TERMO*' IN BOOLEAN MODE)` — busca por **prefixo solto**, bem mais permissiva.

Essa diferença foi validada diretamente no banco de produção (schema `AUTCOM`, tabela `CADITE`, índice FULLTEXT `IDX_CADITE_39` sobre `ITE_DESITE, ITE_PESQUI`): para o produto do chamado (`ITE_CODFAB = 'FCI1660'`, item `0040880`), a busca por token exato retornou **7 produtos**, e a busca por prefixo retornou **9 produtos** — reproduzindo exatamente o comportamento relatado.

### Causa raiz de fundo (fora do escopo deste requisito)

`CADITE.ITE_PESQUI` é do tipo `TEXT` (limite de 65.535 bytes), populado pela function MySQL `fRetornaDescricaoLivrePesquisa` (também `RETURNS text`, mesmo limite) via a procedure `esp_Atualiza_CADITE_Pesquisa` — reescrita em 17/08/2026 (Req. 456080). A function concatena `PESQUI (texto livre) + '<========>' + PESQUI_EXATA (tokens exatos)`; quando o total ultrapassa 65.535 bytes, o MySQL trunca silenciosamente o final da string — justamente a seção de tokens exatos usada pela busca "sem `/`". Isso foi confirmado empiricamente: itens com catálogo de aplicação/veículos extenso batem exatamente em 65.535 bytes e têm a seção de tokens desproporcionalmente pequena.

**Decisão de escopo (confirmada com o usuário):** este requisito trata **apenas a camada de busca (Delphi)**. O truncamento em 65.535 bytes na coluna `CADITE.ITE_PESQUI` / function `fRetornaDescricaoLivrePesquisa` / procedure `esp_Atualiza_CADITE_Pesquisa` é uma causa raiz de banco de dados, fora do SVN Delphi, e fica registrado aqui como achado técnico e risco conhecido — não será alterado neste requisito, ficando a critério da DBA/outro requisito.

## 2. Módulos e entidades envolvidos

- Módulo: Faturamento (Consulta de Preço) — mas a rotina alterada é compartilhada por toda a família "Consulta de Produtos" (`fPesqItem`), usada também em cadastro e movimentação de itens.
- Units:
  - `padra_atualizado/fontes/genericos/untFuncoesGenCompartilhada.pas` (alteração)
  - `padra_atualizado/fontes/genericos/untPesqItem.pas` (referência — não alterada; é quem configura `strCampoBuscaComplementarPorToken := 'ITE_PESQUI'`)
  - `padra_atualizado/fontes/faturamento/untConsultaPreco.pas` (referência — ponto de entrada da tela; não alterada)
  - `padra_atualizado/fontes/libFuncoes/untConfiguraConsulta.pas` (referência — motor que decide FULLTEXT vs LIKE e chama `fSQLBuscaComplementarPorToken`; não alterada)
- Tabelas/entidades: `CADITE` (chave primária `ITE_CODITE`), campo `ITE_PESQUI` (texto de pesquisa pré-calculado), índice FULLTEXT `IDX_CADITE_39` (`ITE_DESITE`, `ITE_PESQUI`).
- Configuração de sistema: `CFGSIS.CFG_ITPMOD` (valor `'3'` em produção — "Consulta Produtos Busca Complementar com \"*\" E/OU \"/\" por Token").

## 3. Requisitos funcionais

- RF01 — A busca por "Descrição Livre" (e demais telas que usam `fPesqItem`/`ITE_PESQUI` com `CFG_ITPMOD='3'`) deve retornar, para um termo digitado sem `/`, o mesmo conjunto de resultados que hoje só é obtido incluindo `/` no final do termo.
- RF02 — Não deve haver regressão: nenhum resultado hoje encontrado com `/` no final pode deixar de ser encontrado após o ajuste.
- RF03 — O comportamento de múltiplos campos separados por `//` (busca por campo do índice FULLTEXT, ex.: descrição `//` código de fábrica) deve continuar funcionando.

## 4. Regras de negócio

- RN01 — Ao montar o filtro de busca complementar por token (`fSQLBuscaComplementarPorToken`), cada token do termo digitado deve sempre ser tratado no modo "prefixo solto" (`+TOKEN*`), independentemente de o usuário ter digitado `/` no final ou não. O modo "token exato delimitado" (`'| _TOKEN_ |'`) deixa de ser usado nesta função.
- RN02 — Tokens com tamanho menor ou igual a `innodb_ft_min_token_size` continuam caindo no fallback `LIKE "%TOKEN%"` (comportamento já existente, não alterado).
- RN03 — Tokens compostos por curinga puro (`*`/`%`) continuam sendo ignorados (comportamento já existente).

## 5. Requisitos técnicos / não-funcionais

- Sem impacto em transação/auditoria (rotina de consulta, não grava dados).
- Sem impacto em permissão de tela.
- Função alterada é compartilhada — impacto se propaga a todas as telas que usam `fPesqItem` com `ITPMOD='3'` (hoje, a única configuração ativa que usa `strCampoBuscaComplementarPorToken`).

## 6. Critérios de aceitação

- [ ] Buscar "FCI1660" (sem `/`) em Consulta de Produtos (Faturamento > Consulta de Preços) retorna os mesmos 9 produtos que hoje só aparecem buscando "//FCI1660/".
- [ ] Buscar "//FCI1660/" continua retornando os mesmos 9 produtos (sem regressão).
- [ ] Busca por múltiplos campos via `//` (ex.: descrição `//` código de fábrica) continua funcionando normalmente.
- [ ] Nenhuma busca existente (validada com termos de teste variados na base de simulação) perde resultados após o ajuste.

## 7. Fora de escopo

- Ampliação do tipo de coluna `CADITE.ITE_PESQUI` (TEXT → MEDIUMTEXT) e das rotinas MySQL `fRetornaDescricaoLivrePesquisa` / `esp_Atualiza_CADITE_Pesquisa` — fica para a DBA/outro requisito.
- Qualquer alteração no modo `CFG_ITPMOD='2'` (busca exata por token, usada por `fConverteFullText`/`untPesqAux.pas`) — não está em uso em produção e não é acionada por este chamado.
- Alteração do trigger `T_CADITE_BU_PESQUI` referenciado em comentário na procedure `esp_Atualiza_CADITE_Pesquisa`, mas não encontrado como objeto existente no banco (achado técnico registrado, sem ação neste requisito).

## 8. Dependências e riscos

- **Risco:** a função `fSQLBuscaComplementarPorToken` é compartilhada por todas as telas de Consulta de Produtos que usam `ITE_PESQUI` como campo de busca complementar — o ajuste amplia o comportamento de busca (mais permissivo) nessas telas de forma uniforme. Mitigação: validar em mais de uma tela/fluxo antes de considerar concluído.
- **Risco conhecido, fora de escopo:** o truncamento em 65.535 bytes em `ITE_PESQUI` continua existindo após este ajuste — produtos com catálogo de aplicação/cross-reference muito extenso podem ainda ter a seção de tokens exatos truncada no banco, mas como este requisito elimina a dependência da seção de tokens exatos (RN01), esse truncamento deixa de afetar a busca por "Descrição Livre" na prática (a busca por prefixo usa a parte de texto livre, que é escrita primeiro e raramente truncada).
- **Dependência:** validação depende da base de simulação anexada ao chamado (`\\CITEL-FILESERVE\AUTDBF\VALPEMEC\24-08-2026`).
