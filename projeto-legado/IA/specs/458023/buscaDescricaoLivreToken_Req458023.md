# Análise de Requisito — Req. 458023

**Título:** Busca por "Descrição Livre" na Consulta de Produtos exigia "/" no final do termo para trazer todos os resultados
**Solicitante:** Dênis (ticket Zendesk 1641522)
**Data da análise/implementação:** 2026-08-25

## 1. Contexto de negócio

A tela **PRINCIPAL > FATURAMENTO > CONSULTA DE PREÇOS > CONSULTA DE PRODUTOS** (unit `untConsultaPreco.pas`,
que abre o componente compartilhado `fPesqItem` em `untPesqItem.pas`) permite ao operador localizar um
produto digitando um termo livre no campo "Descrição Livre". Esse campo filtra pelo campo pré-calculado
`CADITE.ITE_PESQUI` — uma coluna de texto que concatena, para cada item, sua descrição, código de fábrica,
código de barras, referências cruzadas de outros fornecedores/marcas para o mesmo item, aplicações
veiculares (marca/modelo/ano) e sinônimos de pesquisa, de forma a permitir que o operador encontre um
produto por qualquer um desses dados sem precisar saber exatamente qual campo consultar.

O cliente relatou que pesquisar `//FC1660/` (com barra no final) trazia mais resultados do que pesquisar
`//FCI1660` (sem barra no final), e que essa necessidade de incluir a barra nunca existiu antes — passou a
ser necessária recentemente.

## 2. Problema e causa raiz

### 2.1 Mecanismo de busca em uso em produção

A configuração de sistema `CFGSIS.CFG_ITPMOD` (por empresa) controla qual mecanismo de busca é usado
quando o campo `ITE_PESQUI` está habilitado como campo de pesquisa genérico. Consultado diretamente no
banco (schema `AUTCOM`, tabela `CFGSIS`): **`CFG_ITPMOD = '3'` para todas as empresas em produção**
(001, 002, 003, 004; só a empresa 100 estava em `'1'`). O valor `'3'` corresponde a "Consulta Produtos
Busca Complementar com \"\*\" E/OU \"/\" por Token", que direciona a busca para
`TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken`
(`padra_atualizado/fontes/genericos/untFuncoesGenCompartilhada.pas`).

Essa função usava o caractere `/` **como marcador de controle da própria lógica de busca**, não como
dado a ser pesquisado. Antes do ajuste, o comportamento era:

- Termo **sem** `/` no final → a função montava
  `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+| _TERMO_ |*' IN BOOLEAN MODE)` — busca por **token exato
  delimitado**: exigia que o termo aparecesse isolado por delimitadores (`| _..._ |`) no texto de pesquisa
  do produto.
- Termo **com** `/` no final → o `/` era convertido internamente em curinga
  (`AFilter.Replace('/', '* ')`, linha 115), e a função montava
  `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+TERMO*' IN BOOLEAN MODE)` — busca por **prefixo solto**, bem
  mais permissiva (casa qualquer palavra do texto que comece com o termo digitado).

### 2.2 Validação empírica

Consultando diretamente o banco de produção (conexão somente-leitura, schema `AUTCOM`, tabela `CADITE`,
índice FULLTEXT `IDX_CADITE_39` sobre `ITE_DESITE, ITE_PESQUI`), para o produto do chamado (item
`0040880`, "FILTRO COMBUSTIVEL", `ITE_CODFAB = 'FCI1660'`):

| Consulta | Resultado |
|---|---|
| `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+\| _FCI1660_ \|*' IN BOOLEAN MODE)` (modo exato, sem `/`) | **7 produtos** |
| `MATCH(ITE_DESITE, ITE_PESQUI) AGAINST('+FCI1660*' IN BOOLEAN MODE)` (modo prefixo, com `/`) | **9 produtos** |

Reproduz exatamente o comportamento relatado pelo cliente.

### 2.3 Causa raiz de fundo (por que passou a ser necessário "recentemente")

`CADITE.ITE_PESQUI` é do tipo `TEXT` no MySQL — **limite de 65.535 bytes**. O campo é populado pela
function MySQL `fRetornaDescricaoLivrePesquisa(vCODITE)` (também `RETURNS text`, mesmo limite de 65.535
bytes), chamada em lote pela procedure `esp_Atualiza_CADITE_Pesquisa` (percorre a fila de pendências em
`CONTROL_ITE` e grava o resultado em `CADITE.ITE_PESQUI`). Essa procedure **foi reescrita em 17/08/2026,
Req. 456080** ("Padronização da rotina e correção de erros relacionados a PREPARE STATEMENT") — cerca de
uma semana antes deste chamado (24/08/2026).

A function `fRetornaDescricaoLivrePesquisa` monta o valor como:
`CONCAT(texto_livre, ' <========> ', texto_tokenizado)` — nessa ordem, com o texto livre (descrição,
código de fábrica, referências cruzadas, aplicações veiculares) primeiro, e a seção "tokenizada" (cada
palavra do texto livre reformatada como `| _PALAVRA_ | _PALAVRA_ | ...`, usada exclusivamente pelo modo de
busca exata) depois, concatenada ao final.

Quando o total (`texto_livre + delimitador + texto_tokenizado`) ultrapassa 65.535 bytes, **o MySQL trunca
silenciosamente o final da string** — exatamente a seção tokenizada, por ser a última a ser concatenada.
Isso foi confirmado com evidência direta no banco:

| Item | `LENGTH(ITE_PESQUI)` total | Tamanho da parte de texto livre | Tamanho da parte tokenizada |
|---|---|---|---|
| `0040880` (não truncado) | 13.080 | 4.797 | 8.273 (~1,7x o texto livre — proporção esperada) |
| `0035134` (truncado) | **65.535** (teto exato da coluna `TEXT`) | 62.727 | **2.798** (deveria ser ~106.000 pela proporção acima) |
| `0071433` (truncado) | **65.535** | 64.393 | **1.132** (deveria ser ~109.000) |
| `0102589` (truncado) | **65.535** | 62.417 | **3.108** (deveria ser ~106.000) |

Para os itens truncados, o código `FCI1660` aparece normalmente na parte de texto livre (confirmado por
busca textual direta), mas **não aparece mais como token isolado** (`_FCI1660_`) na parte tokenizada —
porque essa parte foi cortada antes de chegar até lá. É por isso que o modo de busca exata (sem `/`)
"perde" esses itens, enquanto o modo prefixo (com `/`), que também considera a parte de texto livre (não
truncada), continua encontrando-os.

Como a procedure `esp_Atualiza_CADITE_Pesquisa` foi reescrita e presumivelmente reprocessou em lote um
volume grande de itens pendentes na fila `CONTROL_ITE` a partir de 17/08/2026, é plausível que mais itens
tenham cruzado o limite de 65.535 bytes nesse reprocessamento — o que é coerente com o relato do cliente
de que o problema "começou a acontecer recentemente".

## 3. Investigação realizada

1. Localizado o fluxo de tela: `untConsultaPreco.pas` → `fPesqItem` (`untPesqItem.pas`) → campo de filtro
   `ITEPESQUI` (alias de `CADITE.ITE_PESQUI`).
2. Identificado, por leitura de código, que o motor de busca real depende de `CFG_ITPMOD`
   (`untPesqItem.pas`, linhas 877-881): `'2'` usa `strCampoBuscaPalavraExataPorToken`, `'3'` usa
   `strCampoBuscaComplementarPorToken` — ambos apontando para `ITE_PESQUI`.
3. Confirmado no banco (`CFGSIS`) que produção usa `CFG_ITPMOD = '3'` em todas as empresas relevantes —
   ou seja, o mecanismo realmente exercitado é `fSQLBuscaComplementarPorToken`
   (`untFuncoesGenCompartilhada.pas`), não o `fConverteFullText` de `untConfiguraConsulta.pas`
   (mecanismo do modo `'2'`, não usado em produção).
4. Lida a função `fSQLBuscaComplementarPorToken` linha a linha; identificado o mecanismo de conversão
   `/` → `* ` → `%` que decide entre modo exato e modo prefixo.
5. Validado empiricamente no banco de produção (leitura direta, sem alterar dados) que os dois modos
   realmente produzem 7 vs. 9 resultados para o caso do chamado.
6. Investigada a origem de `CADITE.ITE_PESQUI`: nenhuma rotina Delphi grava esse campo em uso normal de
   cadastro (só um caso isolado de reprocessamento industrial, não relacionado). Localizadas no banco a
   function `fRetornaDescricaoLivrePesquisa` e a procedure `esp_Atualiza_CADITE_Pesquisa`
   (`information_schema.ROUTINES`), lidas por completo (`SHOW CREATE FUNCTION`/`SHOW CREATE PROCEDURE`).
7. Confirmado, por medição direta (`LENGTH()`, `SUBSTRING_INDEX()`), que itens com `ITE_PESQUI` de
   exatamente 65.535 bytes têm a seção tokenizada desproporcionalmente pequena — evidência direta do
   truncamento.
8. Verificado que o trigger `T_CADITE_BU_PESQUI`, mencionado em comentário dentro da procedure
   `esp_Atualiza_CADITE_Pesquisa` ("Necessário para TRIGGER..."), **não existe atualmente no banco**
   (`information_schema.TRIGGERS` não retorna nenhum registro) — achado registrado como ponto de atenção,
   não investigado a fundo (fora do escopo deste requisito).

## 4. Abordagens consideradas e descartadas

- **Corrigir a causa raiz no banco** (ampliar `CADITE.ITE_PESQUI` e as rotinas MySQL para `MEDIUMTEXT`,
  até 16 MB) — **descartado para este requisito**, por decisão explícita do usuário: fica para a DBA ou
  outro requisito. Registrado como achado técnico (seção 2.3 acima e seção 6 abaixo).
- **Fallback automático** (manter o modo exato como principal; se retornar zero linhas, reexecutar
  automaticamente em modo prefixo) — avaliado e **descartado** em favor da opção mais simples abaixo, por
  decisão do usuário: menos código, uma única consulta por token (sem custo de reexecução), e o modo
  prefixo já demonstrou ser superconjunto do modo exato no caso validado.
- **Sempre usar o modo prefixo** (opção escolhida) — mais simples, resultado sempre ≥ ao do modo exato
  para o caso validado, elimina a dependência da seção tokenizada de `ITE_PESQUI` (que é justamente a
  parte sujeita a truncamento no banco) — como efeito colateral positivo, esta escolha também neutraliza
  o impacto prático do truncamento em 65.535 bytes na busca por Descrição Livre, mesmo sem corrigi-lo na
  origem.

## 5. Solução aplicada

Em `TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken` (overload de 1 campo,
`untFuncoesGenCompartilhada.pas`), os dois trechos que decidiam entre modo exato (`'| _TOKEN_ |'`) e modo
prefixo (`TOKEN` puro) com base em o token terminar ou não com `%` (originado de um `/` digitado no final)
foram unificados para **sempre seguir o caminho de prefixo solto** — o wrap `'| _..._ |'` foi removido, e
a lógica de `AHavingFilters` que dependia de `AFilter.StartsWith(...)`/`Contains('/'+...)` foi simplificada
para o padrão único já usado como fallback (`LIKE "%TOKEN%"`).

O overload multi-campo da mesma função (linhas 50-99), que usa `//` como separador entre filtros de
campos diferentes do índice FULLTEXT (ex.: descrição `//` código de fábrica), **não foi alterado** — essa
separação continua necessária e é independente do ajuste feito.

### Arquivos alterados (mesmo diff aplicado em todas as cópias)

| Working copy | Revisão SVN base | Status |
|---|---|---|
| `379.48.2.30.74.150.100` (origem da correção) | 491162 | Alterado |
| `74.Fechadas\74.111.Fechadas\379.48.2.30.74.111_VALPEMEC` | 491175 | Alterado (patch aplicado) |
| `74.Fechadas\74.111.Fechadas\379.48.2.30.74.111_VALPEMEC_COTACAO` | 491175 | Alterado (patch aplicado) |
| `379.48.2.30.74.150` | 491076 | Alterado (patch aplicado) |
| `379.48.2.30.74.150.45` | 491162 | Alterado (patch aplicado) |

Em todas: `padra_atualizado/fontes/genericos/untFuncoesGenCompartilhada.pas`, função
`fSQLBuscaComplementarPorToken` (overload de 1 campo). O mesmo diff (`svn diff`) foi conferido idêntico
em todas as cópias, e o encoding cp1252/CRLF de cada arquivo foi validado após a gravação (decodifica sem
erro, sem marcador de corrupção UTF-8/`\xef\xbf\xbd`).

### Validação pós-implementação

Um teste manual reportado pelo usuário, buscando `FC1660` (sem o "I"), não retornou nenhum resultado após
a alteração. Investigado: **`FC1660` (sem "I") não existe em nenhum lugar do campo de pesquisa de nenhum
produto** — nem como código próprio, nem como referência cruzada — confirmado tanto por
`MATCH(...) AGAINST('+FC1660*'...)` quanto por `LIKE '%FC1660%'` direto (ambos 0 resultados). Só existe
`FCI1660` (com "I"), que é o código de fábrica real do item `0040880`. `MATCH(...) AGAINST('+FCI1660*'...)`
(código correto) retorna os 9 resultados esperados. Concluído que o teste do usuário usou um termo
incompleto (a mesma inconsistência já presente no texto original do chamado, que usa "FC1660" numa frase e
"FCI1660" noutra) — **não é regressão da alteração**.

## 6. Decisões de escopo

**Incluído:** ajuste da lógica de busca em `fSQLBuscaComplementarPorToken` (camada Delphi), aplicado nas 5
working copies acima.

**Excluído deliberadamente** (decisão explícita do usuário, registrada no `spec.md` do requisito):

- Ampliação de `CADITE.ITE_PESQUI` de `TEXT` para `MEDIUMTEXT` e das rotinas MySQL
  `fRetornaDescricaoLivrePesquisa` / `esp_Atualiza_CADITE_Pesquisa` — fica para a DBA ou outro requisito.
- Investigação do trigger `T_CADITE_BU_PESQUI` referenciado em comentário na procedure, mas ausente do
  banco atualmente.
- Qualquer alteração no modo `CFG_ITPMOD = '2'` (busca exata por token via `fConverteFullText`,
  `untConfiguraConsulta.pas`, e `pPesquisaExataITE_PESQUI` em `untPesqAux.pas`) — não está em uso em
  produção (só a empresa 100 usa `CFG_ITPMOD='1'`; nenhuma usa `'2'`) e não foi acionado por este chamado.

## 7. Achados colaterais (fora de escopo, registrados para não serem esquecidos)

1. **Truncamento em `CADITE.ITE_PESQUI` (65.535 bytes)** — causa raiz de fundo descrita na seção 2.3.
   Continua existindo após este ajuste; deixa de afetar a busca por Descrição Livre como efeito colateral
   da solução escolhida (que não depende mais da seção tokenizada truncada), mas pode afetar outras
   rotinas que dependam do texto completo de `ITE_PESQUI` (não investigado).
2. **Trigger `T_CADITE_BU_PESQUI` ausente** — referenciado em comentário dentro de
   `esp_Atualiza_CADITE_Pesquisa` ("Necessário para TRIGGER..."), mas não existe hoje no banco
   (`information_schema.TRIGGERS` vazio para `CADITE`). Não investigado se foi removido intencionalmente,
   nunca existiu de fato, ou se há algum efeito colateral de sua ausência.
3. **Procedure `esp_Atualiza_CADITE_Pesquisa` reescrita em 17/08/2026 (Req. 456080)** — candidata mais
   provável a ter disparado reprocessamento em massa de `ITE_PESQUI`, expondo o truncamento em mais itens
   de uma vez. Não investigado o diff/motivo exato da reescrita além do que consta no cabeçalho da própria
   procedure.

## 8. Ressalvas e lições

- **Cuidado ao interpretar termos de busca em tickets de suporte**: o ticket original usava "FC1660" e
  "FCI1660" de forma inconsistente na mesma descrição do problema. Presumir que eram o mesmo código (erro
  de digitação) foi a hipótese correta neste caso (confirmado por não haver nenhum produto/código real
  "FC1660" na base), mas gerou uma falsa alarme de regressão durante o teste manual — vale sempre validar
  o termo exato contra o banco antes de assumir regressão quando um teste "não funciona".
- **Validação direta no banco (leitura) foi decisiva** para diferenciar hipóteses de causa (lógica de
  busca vs. dado truncado) sem precisar reproduzir a tela na aplicação Delphi — a skill `citel-conectarBanco`
  (modo leitura) permitiu confirmar cada hipótese com uma consulta `MATCH ... AGAINST` real, incluindo o
  comportamento antes e depois da alteração.
- **Correção replicada em 5 working copies** via `citel-applyPatch`, com validação de contexto único por
  arquivo (nenhum conflito) e verificação de encoding cp1252 pós-gravação em cada uma — nenhuma reintroduziu
  corrupção de caracteres.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `padra_atualizado/fontes/genericos/untFuncoesGenCompartilhada.pas`
**Função:** `TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken` (overload de 1 campo)
**Local no fonte:** dois comentários, um no bloco de montagem de `AHavingFilters` (logo após
`if AHavingFilters <> '' then AHavingFilters := AHavingFilters + ' AND ';`) e outro no bloco de definição
final de `LFilter`/`LTokenSize` (logo após a normalização de caracteres especiais).

**Explicação completa:** antes deste ajuste, a função decidia entre dois modos de busca mutuamente
exclusivos observando se o token, após a conversão `AFilter.Replace('/', '* ')` (linha 115) seguida de
`LFilter.Replace('*', '%')` (linha 123), terminava com `%` — o que só acontecia quando o usuário digitava
`/` logo após aquele trecho do termo pesquisado. Sem `/` no final, o token virava `'| _TOKEN_ |'` e a
busca (`MATCH ... AGAINST`) exigia que esse padrão exato aparecesse na seção "tokenizada" do campo
`CADITE.ITE_PESQUI` — a parte do texto que fica depois do delimitador `<========>`, montada pela function
MySQL `fRetornaDescricaoLivrePesquisa`.

O problema é que `CADITE.ITE_PESQUI` é uma coluna `TEXT` (limite de 65.535 bytes) e a function que a
popula também é `RETURNS text` (mesmo limite). Ela concatena `texto_livre + '<========>' +
texto_tokenizado`, nessa ordem — quando o total ultrapassa 65.535 bytes, o MySQL trunca silenciosamente o
final da string, que é exatamente a seção tokenizada. Isso foi validado no banco de produção: itens com
catálogo de aplicação/cross-reference extenso batem exatamente em 65.535 bytes de `ITE_PESQUI` e têm a
seção tokenizada desproporcionalmente pequena ou sem o token do código buscado — mesmo esse código
aparecendo normalmente na seção de texto livre (não truncada). Isso fazia a busca em "modo exato" (sem
`/`) perder resultados que deveriam aparecer, e por isso os usuários vinham "descobrindo", por tentativa e
erro, que adicionar `/` no final do termo (que forçava o modo prefixo, que busca na seção de texto livre e
não depende do trecho tokenizado) trazia mais resultados corretos.

**Por que isso não é óbvio e por que uma revisão futura não deve simplesmente reverter para o código
antigo (reintroduzindo o `if LFilter.EndsWith('%') then ... else ...`):** reintroduzir o modo "token exato
delimitado" sem antes resolver o truncamento em `ITE_PESQUI`/`fRetornaDescricaoLivrePesquisa` (ver seção 6
— Decisões de Escopo, e seção 2.3/7 deste documento) reintroduziria o bug original: buscas sem `/`
voltariam a perder resultados para produtos cuja seção tokenizada foi truncada no banco. Validado
empiricamente (leitura direta do banco de produção, comando `MATCH ... AGAINST`) que o modo prefixo é
superconjunto do modo exato para o caso do chamado (9 resultados vs. 7) — ou seja, a simplificação não
perde nenhum resultado que o modo exato já encontrava, e ainda corrige os que ele perdia por causa do
truncamento.
