# Especificação — Req. 464216

**Título:** Reposicionamento automático no item com erro de validação — Lote de Preços da Entrada de Mercadorias
**Objetivo:** quando a validação de preço/margem em `TLotePrecos.pBeforePost` falhar (ex.: "O Preço de Venda X deve ser maior que zero!"), reposicionar automaticamente o grid de itens no registro que causou o erro e focar a coluna correspondente, eliminando a necessidade do operador pesquisar manualmente o item.
**Zona:** Legado
**Data:** 2026-09-28

## 1. Contexto / problema atual

Na tela "Ativar Lote de Preços da Entrada de Mercadorias" (`untLotePrecosEfetivacaoCx.pas`), o método `TLotePrecos.pBeforePost` (`untLotePrecos.pas`) valida os campos de preço/margem do item antes de gravar. Quando uma validação falha (ex.: preço de venda zerado após arredondamento), o método exibe a mensagem de erro e cancela a gravação (`DataSet.Cancel; Abort;`), mas **nunca teve lógica de reposicionamento visual** — o grid de itens não é focado nem rolado até a linha/coluna problemática, obrigando o operador a pesquisar manualmente o item para corrigir.

O dataset validado (`cdsConsulta`) já fica posicionado no registro correto no momento do erro (o `Post` ocorre sobre o registro atual; `Cancel` não move o cursor), e o grid de itens (`cxgItens`/`cxbItens`) está ligado a `cdsConsulta` via `DataSource` e não é desabilitado (`DisableControls`) durante este fluxo — ou seja, o dado já está correto, falta apenas o foco/scroll visual da grade.

Esse comportamento foi relatado no chamado 464216 (Zendesk 1655410, cliente Moto Mais) e é anterior e independente da correção do Req. 463151 (rev. SVN 496243), que alterou a navegação interna de `pReplicaPrecoParaItens` mas não tocou em `pBeforePost`.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (Movimentação de Itens > Ativar Lote de Preços da Entrada de Mercadorias)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` — classe `TLotePrecos`, método `pBeforePost`
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecosEfetivacaoCx.pas` — form da tela, componentes `cxgItens`/`cxbItens`
- Tabelas/entidades: `LOTPRE` (chave `AUTOINCREM`), campos `LTP_PRECOM_ATU`, `LTP_MARBRn`, `LTP_MARIDn`, `LTP_PREVEn` (n = 1 a 7, uma tabela de preço)

## 3. Requisitos funcionais

- RF01 — Ao falhar qualquer validação de `pBeforePost` fora do fluxo de validação em lote (`blnValidandoPrecoEmLote = False`), o grid de itens (`cxgItens`) deve receber foco de teclado e a linha do item que falhou deve ficar visível/selecionada.
- RF02 — A coluna do grid correspondente ao campo que causou o erro deve ficar focada (`Controller.FocusedColumn`), permitindo o operador corrigir o valor imediatamente.
- RF03 — Quando `blnValidandoPrecoEmLote = True` (validação em lote/pré-checagem, Req. 460063), o comportamento atual deve ser mantido — nenhum reposicionamento deve ocorrer, apenas o acúmulo de mensagens já existente.
- RF04 — Além do grid principal (`cxgItens`), o campo que causou o erro também deve ser localizado e focado no grid de detalhamento correspondente (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`, conforme "Qtd. Grid" configurada pelo usuário) — é nesse painel, não no grid principal, que o operador efetivamente vê e corrige o valor. **Descoberto durante os testes da Fase 3**: sem esse reposicionamento, o operador via a mensagem de erro correta mas o grid de detalhamento permanecia parado no campo anterior, exigindo busca manual mesmo com RF01/RF02 implementados.
- RF05 — Durante a replicação de valor para todos os itens (`pReplicaPrecoParaItens`, checkbox "Replicar para todos os itens"), se a validação falhar em um item diferente daquele onde o usuário iniciou a edição, o grid principal e o grid de detalhamento devem focar o item que **realmente falhou** (não o item onde a edição começou). **Descoberto durante os testes da Fase 3**: o `Finally` de `dbgPrecosKeyDown` sempre revertia `cdsConsulta` para o item original antes do reposicionamento poder agir.

## 4. Regras de negócio

- RN01 — O reposicionamento se aplica aos 5 pontos de `Abort` existentes em `pBeforePost`:
  1. Preço de Compra ≤ 0 → campo/coluna `LTP_PRECOM_ATU`
  2. Margem bruta fora de 0-100 → campo/coluna `LTP_MARBRn`
  3. Margem bruta ≥ 100 → campo/coluna `LTP_MARBRn`
  4. `fValidaMargemDataSet` falhou → campo/coluna `LTP_MARBRn`
  5. Margem ideal ≥ 100 / `fValidaMargemIdealDataSet` falhou → campo/coluna `LTP_MARIDn`
  6. Preço de Venda ≤ 0 (caso do ticket original) → campo/coluna `LTP_PREVEn`
- RN02 — O campo `n` (número da tabela de preço, 1 a 7) usado na busca da coluna deve ser o mesmo `intContador` do laço de validação em `pBeforePost` no momento do erro.
- RN03 — Se a coluna não for encontrada no grid (`GetColumnByFieldName` retorna `nil`), o reposicionamento deve ser ignorado silenciosamente (sem gerar exceção adicional) — a mensagem de erro e o `Cancel`/`Abort` já ocorreram normalmente.
- RN04 — O grid de detalhamento correto (RF04) é determinado pelo campo `USGRID` (1, 2 ou 3) do registro de `FCdsPrecos` localizado via `Locate('NOMCAM', <campo com erro>, [])` — `USGRID` indica em qual dos 3 grids físicos (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`) aquele campo é exibido. No modo "Qtd. Grid = 1", `dbgPrecos2`/`dbgPrecos3` ficam sempre `Visible = False` e `dbgPrecos` exibe `cdsPrecos` sem filtro (todos os `USGRID` juntos) — nesse modo o reposicionamento sempre cai em `dbgPrecos`, independente do `USGRID` do campo.
- RN05 — `dbgPrecos` tem a opção `dgAlwaysShowSelection` (os outros dois grids não têm), então continua mostrando a linha selecionada mesmo sem foco real — isso gera um destaque residual confuso quando o reposicionamento move o foco para `dbgPrecos2`/`dbgPrecos3`. A opção deve ser suprimida em `dbgPrecos` **apenas enquanto o foco do erro estiver em outro grid**, e restaurada assim que o usuário retornar manualmente (Tab/clique) a `dbgPrecos`. Fora do fluxo de reposicionamento automático por erro, o comportamento visual de `dbgPrecos` não deve mudar.
- RN06 — No fluxo de "Replicar para todos os itens" (RF05), se ocorrer erro em um item diferente do item onde a edição começou, o código que reverte a posição do dataset/grid para o item original (no `Finally` de `dbgPrecosKeyDown`) deve ser suprimido — o dataset e o grid de detalhamento devem permanecer no item que efetivamente falhou.

## 5. Requisitos técnicos / não-funcionais

- `TLotePrecos` é um `TComponent` de lógica de negócio sem acesso à UI — a comunicação com o grid deve ser feita via um evento/callback exposto pela classe, atribuído pela tela no momento da criação de `objPreLotes`.
- Não deve haver alteração em `cdsConsulta` (nenhum `Locate` adicional é necessário — o dataset já está posicionado corretamente).
- Sem impacto em transação, auditoria ou permissões.

## 6. Critérios de aceitação

- [x] Ao editar o Preço de Venda de um item de forma que o arredondamento zere o valor (cenário do ticket), ao confirmar (Enter) o grid principal e o grid de detalhamento (`dbgPrecos`, "Qtd. Grid = 1") focam automaticamente no item e na coluna/campo do preço de venda da tabela correspondente.
- [x] O mesmo comportamento ocorre com "Qtd. Grid = 2" (`dbgPrecos`/`dbgPrecos2`) e "Qtd. Grid = 3" (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`), focando o grid correto conforme o `USGRID` do campo com erro.
- [x] Durante a replicação de valor para todos os itens (`pReplicaPrecoParaItens`, checkbox "Replicar para todos os itens"), se um item **anterior** ao item onde a edição começou falhar a validação (a replicação percorre a partir de `Dataset.First`), o grid principal e o grid de detalhamento focam no item que **realmente falhou** — validado em "Qtd. Grid = 3".
- [ ] O mesmo comportamento de RF01/RF02/RF04 ocorre para os outros pontos de validação isolados (fora do fluxo de replicação): margem bruta 0-100, margem bruta ≥100, margem ideal, preço de compra.
- [ ] Durante a validação em lote/pré-checagem de itens marcados (Req. 460063, `blnValidandoPrecoEmLote = True`), nenhum reposicionamento ocorre — comportamento de acumular mensagens permanece inalterado.

## 7. Fora de escopo

- Qualquer alteração no texto ou na lógica das mensagens de validação existentes.
- Alteração no comportamento de `blnValidandoPrecoEmLote = True`.

> **Nota:** a versão original desta especificação listava o painel de detalhamento (`dbgPrecos`/`dbgPrecos2`/`dbgPrecos3`) como fora de escopo, tratando-o como um histórico de campos alterados. Os testes da Fase 3 mostraram que esse painel é o local onde o operador efetivamente vê e corrige o valor — RF01/RF02 isolados (só `cxgItens`) não eram suficientes para resolver o problema relatado no ticket. O escopo foi ajustado (RF04/RF05, RN04-RN06) para cobrir também esse painel.

## 8. Dependências e riscos

- Dependência: nenhuma de outro módulo.
- Risco: baixo — mudança aditiva (novo evento opcional) e isolada a `pBeforePost` e à criação de `objPreLotes`; não altera fluxo de gravação nem regras de validação existentes.
