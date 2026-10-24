# Especificação — Req. 460063

**Título:** Lentidão ao arredondar preço de venda para itens marcados no lote de efetivação de preços
**Objetivo:** Eliminar a lentidão (trava de vários segundos) que ocorre ao usar a opção "Sim, para itens marcados no grid" no arredondamento de preço de venda, na tela de efetivação de preços em lote.
**Zona:** Legado
**Data:** 2026-09-04

## 1. Contexto / problema atual

Na tela `TfrmLotePrecosEfetivacaoCx` (`untLotePrecosEfetivacaoCx.pas`), ao digitar as casas decimais em `edtDecUni` e pressionar Enter com `chkArrMai.Checked = True`, o usuário escolhe (via `fMensagemEx`) se o arredondamento deve valer apenas para o item detalhado ou para todos os itens marcados no grid (`cxbItens`).

Quando a opção "itens marcados" é escolhida, `pAtualizarValorDoPrecoDeVenda(2)` chama `pAtualizarValorDoPrecoDeVendaDosItensSelecionados`, que:

1. Percorre **todo** o dataset de itens (`cxbItens.DataController.DataSource.DataSet`) do primeiro ao último registro (`First`/`Next` até `Eof`).
2. Para **cada** registro percorrido, verifica se ele está marcado consultando `objPreLotes.stlListSelecao.IndexOf(QuotedStr(AUTOINCREM))`.

`stlListSelecao` é uma `TStringList` criada sem `Sorted := True` (`untLotePrecos.pas`, criação em `pOpcaoConexaoAoConectar`/construção do objeto). Em uma lista não ordenada, `IndexOf` faz busca linear O(n). Como essa busca é repetida para cada uma das N linhas do dataset, o custo total da etapa de localizar os itens marcados já é O(n²) — mesmo antes de qualquer cálculo de preço.

Além disso, o laço navega pelo dataset inteiro mesmo quando apenas uma fração dos itens está marcada, em vez de ir diretamente aos itens de interesse.

Com poucas centenas de itens no lote (200-500) e uma parte deles marcada, essa combinação já é suficiente para causar uma trava perceptível de vários segundos na interface.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens` (lote de preços / efetivação de preços em caixa)
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecosEfetivacaoCx.pas` (form, evento e laço de aplicação)
  - `padra_atualizado/fontes/movimentacaoitens/untLotePrecos.pas` (classe `TLotePrecos`, objeto `objPreLotes`, propriedade `stlListSelecao`)
- Entidades: nenhuma tabela de banco é criada/alterada; a alteração é 100% em memória (grid/dataset em uso na tela), sobre o campo `AUTOINCREM` já existente no dataset de itens do lote.

## 3. Requisitos funcionais

- RF01 — Ao confirmar o arredondamento para "itens marcados no grid", o sistema deve aplicar o recálculo de preço/margem exatamente aos mesmos itens que seriam alterados hoje (os presentes em `stlListSelecao`), sem alterar itens não marcados.
- RF02 — O tempo de resposta da operação deve ser sensivelmente menor que o comportamento atual para lotes de poucas centenas de itens (efeito perceptível ao usuário — de "trava por vários segundos" para resposta rápida).
- RF03 — Nenhuma outra funcionalidade da tela (marcar/desmarcar item, arredondar item único, demais operações que usam `stlListSelecao`) pode ter seu comportamento alterado.
- RF04 — Durante o processamento em lote, um item cujo Preço de Venda resulte inválido (`LTP_PREVEn <= 0`, mensagem "Item: `<código>` - O Preço de Venda `<n>` deve ser maior (ou igual) a zero!") **não deve interromper** o processamento dos demais itens com um popup bloqueante por item. As mensagens de todos os itens com problema devem ser acumuladas e exibidas **uma única vez**, ao final do processamento do lote.
- RF05 — Todo item que resultar em mensagem de Preço de Venda inválido durante o processamento em lote deve ser **automaticamente desmarcado** (removido de `stlListSelecao`) ao final, e o contador de itens selecionados (`edtQtdSel`) deve refletir essa remoção.

## 4. Regras de negócio

- RN01 — A identificação de "item marcado" continua sendo feita pelo campo `AUTOINCREM` do item, comparado (hoje via `QuotedStr` + `IndexOf`) contra o conteúdo de `stlListSelecao`.
- RN02 — O cálculo de preço/margem em si (`pPercorreGridDePreco` → `objPreLotes.pAlterarPrecoMargem` → `TLotePrecos.pBeforePost`) **não deve ser alterado** neste requisito — apenas a forma como os itens marcados são localizados e percorridos.
- RN03 — A ordenação dos itens dentro de `stlListSelecao` pode ser mudada (ex.: lista ordenada) desde que nenhum outro ponto do código que já usa essa lista dependa da ordem de inserção original. Isso deve ser confirmado por revisão de código antes de aplicar (ver plan.md).
- RN04 — A acumulação de mensagens de Preço de Venda inválido (RF04/RF05) é restrita a esse bloco de validação específico dentro de `TLotePrecos.pBeforePost`. As demais validações do mesmo método (margem entre 0 e 100, margem ≥ 100, etc.) **continuam** com o comportamento atual (popup + `Abort` imediato) — não fazem parte deste requisito.

## 5. Requisitos técnicos / não-funcionais

- Sem impacto em transação/auditoria — a operação já ocorre dentro do fluxo existente de post no `cdsConsulta` (`TLotePrecos.pBeforePost`), que não é alterado.
- Sem impacto em permissões.
- Sem impacto fiscal/financeiro direto (não é módulo fiscal/financeiro), mas o resultado numérico de preço/margem gravado deve ser idêntico ao atual — apenas a performance de acesso muda.
- Encoding dos arquivos `.pas` alterados: Windows-1252 (cp1252) + CRLF — preservar.

## 6. Critérios de aceitação

- [ ] Com um lote de ~200-300 itens e um subconjunto marcado (ex.: 50 itens), a operação de arredondamento para itens marcados deve concluir sem trava perceptível (melhora significativa de tempo em relação ao comportamento anterior à alteração).
- [ ] Os valores finais de `PREVE`/`MARBR` (e demais campos recalculados) dos itens marcados válidos, após a operação, devem ser idênticos aos obtidos antes da alteração, para o mesmo conjunto de entrada.
- [ ] Itens não marcados não sofrem nenhuma alteração.
- [ ] Com um ou mais itens marcados cujo Preço de Venda resulte em erro (`<= 0`), nenhum popup aparece durante o processamento; ao final, uma única mensagem lista todos os itens com problema (`Item: <código> - ...`).
- [ ] Após a operação, os itens que geraram mensagem de Preço de Venda inválido não aparecem mais marcados no grid, e `edtQtdSel` reflete a contagem correta (marcados originais menos os desmarcados).
- [ ] As demais funcionalidades que usam `objPreLotes.stlListSelecao` (marcar/desmarcar item, filtro por seleção, etc. em `untLotePrecos.pas`) continuam funcionando sem regressão.

## 7. Fora de escopo

- Qualquer alteração na lógica de cálculo de preço/margem (`pAlterarPrecoMargem`, `pBeforePost`, `pAjustaPrecos`, `pCalculaPrecoIdeal`).
- Otimização de outras telas/fluxos que também usam o padrão `stlListSelecao` + `IndexOf` (ex.: `untEntConfPedidos.pas`, `untCadCotFornecedor.pas`) — fora do escopo deste requisito.
- Revisão da opção "Sim, apenas para item detalhado" (`intOpcao = 1`), que já opera sobre o item corrente, sem o laço problemático.

## 8. Dependências e riscos

- Depende de `Locate` funcionar corretamente sobre o dataset de `cxbItens` pelo campo `AUTOINCREM` com o mesmo comportamento de comparação usado hoje (comparação de string exata via `AsString`).
- Risco: `stlListSelecao.Sorted := True` pode expor dependência de ordem de inserção não identificada em algum dos demais pontos de `untLotePrecos.pas` que usam essa lista (linhas ~4040-4046, ~5345-5681). Mitigação: revisão desses pontos antes de aplicar a mudança (ver plan.md, passo 1).
