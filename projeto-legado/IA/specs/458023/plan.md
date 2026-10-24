# Plano de Execução — Req. 458023

**Referência:** spec.md
**Zona:** Legado

## 1. Abordagem técnica

Em `TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken` (overload de 1 campo, `untFuncoesGenCompartilhada.pas`, linhas ~101-191), remover a bifurcação que hoje decide entre "token exato delimitado" (`'| _TOKEN_ |'`) e "prefixo solto" (`TOKEN` puro) com base em o token do usuário terminar ou não com `%` (originado de um `/` digitado no final). Unificar para que **todo token sempre siga o caminho de prefixo solto**, eliminando o wrap `'| _..._ |'` e a lógica de `AHavingFilters` que hoje depende de `AFilter.StartsWith(...)`/`Contains('/'+...)`.

Fluxo de dados não muda: `untPesqItem.pas` continua configurando `strCampoBuscaComplementarPorToken := 'ITE_PESQUI'` quando `CFG_ITPMOD = '3'`; `untConfiguraConsulta.pas` continua chamando `fSQLBuscaComplementarPorToken` sem alteração de assinatura. A mudança fica isolada dentro da função.

## 2. Arquivos impactados

| Arquivo / Unit | Caminho | Ação |
|----------------|---------|------|
| `untFuncoesGenCompartilhada.pas` | `padra_atualizado/fontes/genericos/untFuncoesGenCompartilhada.pas` | alterar (`fSQLBuscaComplementarPorToken`, overload de 1 campo) |

Nenhum outro arquivo precisa ser tocado — `untPesqItem.pas`, `untConfiguraConsulta.pas` e `untConsultaPreco.pas` permanecem como estão (usados apenas como referência de fluxo).

## 3. Sequência de implementação

1. Em `fSQLBuscaComplementarPorToken` (overload de 1 campo), localizar o bloco `if LFilter.EndsWith('%') then ... else ... ('| _' + LFilter... + '_ |')` (linhas ~164-173) e unificar em um único caminho: sempre remover eventual `%` residual do fim do token (`LFilter := LFilter.Replace('%', '').Trim`) e calcular `LTokenSize` sobre esse valor, **sem** aplicar o wrap `'| _..._ |'`.
2. Ajustar o bloco de montagem de `AHavingFilters` (linhas ~139-149) que hoje ramifica em `AFilter.StartsWith(LFilter.Replace('%','') + '/')` / `AFilter.Contains('/' + LFilter.Replace('%',''))` / fallback — simplificar para o padrão único `AFieldAlias + ' LIKE "%' + LFilter + '%" '` (equivalente ao fallback já existente), já que o `/` deixa de ter significado funcional na entrada do usuário.
3. Manter inalterado: o tratamento de tokens vazios/curinga puro (linhas 116-126), o `Replace('*', '%')` inicial, a normalização de caracteres especiais (linhas 151-162), o fallback `LIKE` para tokens curtos (`LTokenSize <= innodb_ft_min_token_size`, linhas 178-180) e o `AGAINST('+' + LFilter + '*' ...)` para tokens longos (linhas 182-186).
4. Não alterar o overload multi-campo (linhas 50-99, que trata o `//` como separador entre campos do índice) — seu comportamento de separar filtros por campo continua necessário e não depende da mudança acima.
5. Revisar visualmente `Uses`/dependências da unit para garantir que nenhuma referência a `innodb_ft_min_token_size` ou a outras variáveis globais foi afetada (não deve haver, já que a mudança é local à função).

## 4. Conformidade com padrões do projeto

- Zona Legado: manter Hungarian style já usado na unit (`LFilter`, `LSL`, `LTokenSize` já seguem o padrão local da unit — não introduzir prefixo novo divergente).
- Não introduzir SQL por concatenação de entrada não sanitizada — a função já usa `AnsiReplaceStr`/normalização de caracteres especiais antes de montar a string do `MATCH ... AGAINST`; manter esse tratamento.
- Nenhum componente proibido, `Now()`, `StrToFloat`, `.SetFocus`, `Application.CreateForm` ou `ActiveControl` envolvidos — mudança é puramente de montagem de string SQL.
- Sem alteração de `.dpr`/`.dproj` (nenhuma unit nova).

## 5. Estratégia de testes

- Não há suite DUnit cobrindo este fluxo (`fSQLBuscaComplementarPorToken` não possui teste automatizado localizado).
- Teste manual na base de simulação anexada ao chamado (`\\CITEL-FILESERVE\AUTDBF\VALPEMEC\24-08-2026`), tela Faturamento > Consulta de Preços > Consulta de Produtos:
  - Buscar "FCI1660" (Descrição Livre, sem `/`) e conferir que retorna os mesmos itens que "//FCI1660/" retornava antes do ajuste (comparar contagem e códigos de item).
  - Repetir o teste com pelo menos 2-3 outros termos de código de fábrica/descrição já usados no dia a dia, para checar ausência de regressão (nenhum resultado antes encontrado pode sumir).
  - Testar busca com `//` separando dois campos (ex.: descrição `//` código de fábrica) para confirmar que o overload multi-campo continua funcionando.
- Validação opcional direto no banco (leitura, via skill `citel-conectarBanco`): comparar `MATCH(...) AGAINST('+FCI1660*' ...)` (comportamento alvo) com o resultado da tela após o ajuste.

## Notas Referenciadas no Código-Fonte

### Nota 1

Em `untFuncoesGenCompartilhada.pas`, função `fSQLBuscaComplementarPorToken` (overload de 1 campo), dois blocos foram simplificados para sempre tratar o token de busca no modo "prefixo solto" (`MATCH (...) AGAINST('+TOKEN*' IN BOOLEAN MODE)`), removendo o antigo modo "token exato delimitado" (`'| _TOKEN_ |'`).

**Por que isso não é óbvio / por que não "limpar" de volta para o código antigo:** antes do ajuste, a função decidia entre os dois modos observando se o token, após a conversão `AFilter.Replace('/', '* ')` (linha 115) seguida de `LFilter.Replace('*', '%')` (linha 123), terminava com `%` — o que só acontecia quando o usuário digitava `/` logo após aquele trecho do termo. Sem `/` no final, o token virava `'| _TOKEN_ |'` e a busca exigia que esse padrão exato aparecesse na seção "tokenizada" do campo `CADITE.ITE_PESQUI` (a parte após o delimitador `<========>`, montada pela function MySQL `fRetornaDescricaoLivrePesquisa`).

O problema é que `CADITE.ITE_PESQUI` é uma coluna `TEXT` (limite de 65.535 bytes) e a function que a popula também é `RETURNS text` (mesmo limite). Ela concatena `texto_livre + '<========>' + texto_tokenizado`, nessa ordem — quando o total ultrapassa 65.535 bytes, o MySQL trunca silenciosamente o final da string, que é exatamente a seção tokenizada. Validado no banco de produção (schema `AUTCOM`): itens com catálogo de aplicação/cross-reference extenso batem exatamente em 65.535 bytes de `ITE_PESQUI` e têm a seção tokenizada desproporcionalmente pequena ou sem o token do código buscado — mesmo esse código aparecendo normalmente na seção de texto livre (não truncada). Isso faz a busca "modo exato" (sem `/`) perder resultados que deveriam aparecer, e por isso os usuários vinham "descobrindo" que adicionar `/` no final do termo (que força o modo prefixo, que busca na seção de texto livre e não depende do trecho tokenizado) trazia mais resultados corretos.

Reintroduzir o modo "token exato delimitado" sem antes resolver o truncamento em `ITE_PESQUI`/`fRetornaDescricaoLivrePesquisa` (ver spec.md, seção 7 — Fora de Escopo, e seção 8 — Riscos) reintroduziria o bug original: buscas sem `/` voltariam a perder resultados para produtos cuja seção tokenizada foi truncada no banco. Validado empiricamente (leitura direta do banco de produção, comando `MATCH ... AGAINST`) que o modo prefixo é superconjunto do modo exato para o caso do chamado (9 resultados vs 7).

## 6. Riscos e mitigação

- **Risco:** função compartilhada por todas as telas de Consulta de Produtos com `ITPMOD='3'` — mudança amplia permissividade da busca de forma uniforme. Mitigação: validar em mais de uma tela antes de considerar concluído (Consulta de Preço no mínimo; idealmente também cadastro/movimentação de itens que usam `fPesqItem`).
- **Risco:** truncamento em `CADITE.ITE_PESQUI` (65.535 bytes) continua existindo no banco (fora de escopo) — mas como a busca deixa de depender da seção de tokens exatos truncada, o impacto prático deste truncamento na busca por Descrição Livre é eliminado como efeito colateral positivo deste ajuste.
- **Dependência:** nenhuma além do ambiente de simulação já disponibilizado no chamado.
