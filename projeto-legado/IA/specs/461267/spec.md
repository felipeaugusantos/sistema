# Especificação — Req. 461267

**Título:** Exclusão de item único no Pedido de Compra apaga todo o grupo de "Nível de Giro" quando o grid está agrupado
**Objetivo:** Corrigir a exclusão de item avulso (via TAB + botão "Excluir" dentro de `frmPedidoCompraItem`) para que, com o grid agrupado por Nível de Giro, apague somente o item focado — e não todo o grupo — além de corrigir dois defeitos correlatos identificados na mesma investigação.
**Zona:** Legado
**Data:** 2026-09-14
**Solicitante/contato:** Rodolfo (Diretor) — KUSMA

## 1. Contexto / problema atual

No módulo de Pedido de Compra, tela de digitação (`untPedidoCompra.pas`), ao pesquisar um produto, pressionar **TAB** para marcá-lo/abrir o popup "Complete as informações do item" (`frmPedidoCompraItem`) e clicar em **"Excluir"** (exclusão de **um único item**, não exclusão múltipla por marcação), o comportamento relatado pelo cliente foi:

1. Ao excluir um produto (ex.: 04025 no relato original, 05949 na reprodução), **todos os itens do grupo "Nível de Giro: B"** somem da tela/pesquisa — não só o item excluído.
2. Ao pesquisar (TAB) outro item, o botão **"Excluir"** deixa de aparecer dentro de `frmPedidoCompraItem`.
3. Produtos específicos (05609, 05384, 04888) deixam de ser marcados como "já incluídos no pedido" ao serem pesquisados novamente.

**Reprodução confirmada** (vídeo/print do usuário, 2026-09-14): com o grid `cxvItens` agrupado pela coluna de Nível de Giro (`cxvItensNVLGIR`), excluir o item **05949** (pertencente ao grupo B, que continha 20 itens) removeu **os 20 itens do grupo B** de `cdsItensPedido` — não apenas o item focado. Ao pesquisar em seguida o item **05609** (que também pertencia ao grupo B recém-apagado), o botão "Excluir" não aparece — **efeito colateral esperado**, pois o item de fato não está mais em `cdsItensPedido` (foi excluído junto com o grupo). Testando um item de outro nível (não afetado pela exclusão em massa), o botão "Excluir" aparece normalmente — confirmando que a causa é a exclusão indevida em massa, e não uma falha isolada na lógica do botão/Locate.

**Causa raiz confirmada:** em `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, existem dois caminhos de exclusão:

- **Exclusão múltipla** (`stlProdutosMarcados.Count > 0`): já trata corretamente o agrupamento — desagrupa (`cxvItensNVLGIR.GroupIndex := -1`) **antes** de excluir os itens marcados, e reagrupa (`GroupIndex := 0` + `Groups.FullExpand`) **depois**.
- **Exclusão de item único** (ramo `Else`, usado pelo fluxo TAB → Excluir): chamava `pApagaItem` **diretamente**, sem nenhum tratamento de `GroupIndex`. Com o grid agrupado, `cxvItens.DataController.DeleteFocused` (chamado dentro de `pApagaItem`) acaba apagando todos os registros do grupo focado em vez de somente o registro focado.

Ou seja: a proteção contra esse problema já existia no código (caminho de exclusão múltipla), mas nunca foi replicada para o caminho de exclusão de item único — que é exatamente o fluxo usado pela tela "Complete as informações do item".

Durante a investigação, foram identificados e aprovados **dois defeitos correlatos adicionais**, cobertos pelo mesmo escopo de correção (ver seção 3):

- **Bug independente de comparação por substring** na tela de consulta por Giro (`untConsultaItensGiro.pas`, `dbgConsultaDrawColumnCell`): o marcador visual de "item já no pedido" (coluna `TAB`) usa `Pos(codigo, sltItems.CommaText) > 0` — uma busca por substring dentro do texto da lista, em vez de uma busca exata (`Find`/`IndexOf`). Isso pode gerar falso positivo/negativo quando um código de produto é substring de outro (ex.: "025" dentro de "10025").
- **Falta de garantia de estado limpo do dataset antes do delete**: `pApagaItem` chama `cxvItens.DataController.DeleteFocused` sem garantir explicitamente que `cdsItensPedido` esteja em `dsBrowse` — o fluxo de cancelamento de item (`btnCancelaItemClick`/`pLimpaDadosItem`) nunca chama `cdsItensPedido.Cancel`/`.Post`, deixando uma janela teórica para o dataset ficar em `dsEdit`/`dsInsert` no momento do delete. Instrumentação de log (temporária) rodada em 2026-09-14 não reproduziu esse estado sujo no cenário testado (`State=1`/`dsBrowse` no momento do delete), mas o ajuste defensivo permanece no escopo aprovado, por segurança.

**Ambiente:**
- Cliente: KUSMA
- Fluxo de consulta: **por Giro** (`TfrmConsultaItensGiro`/`untConsultaItensGiro.pas`) — confirmado pelo usuário como o fluxo usado por este cliente.

## 2. Módulos e entidades envolvidos

- Módulo: `movimentacaoitens/PedidoDeCompra`
- Unit principal: `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas`
  - `TfrmPedidoDeCompra.btnApagaClick` — controlador de exclusão (múltipla e única)
  - `TfrmPedidoDeCompra.pApagaItem` — exclusão efetiva do item focado em `cdsItensPedido`/`cxvItens`
  - `TfrmPedidoDeCompra.fCompraItem` — controla exibição do botão "Excluir" em `frmPedidoCompraItem`, via `cdsItensPedido.Locate`
  - `TfrmPedidoDeCompra.pRetiraDaListaConsulta` — remove código da `sltItems` (lista de itens já no pedido) após exclusão
- Unit correlata: `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untConsultaItensGiro.pas`
  - `TfrmConsultaItensGiro.dbgConsultaDrawColumnCell` — desenha o marcador "já no pedido" (coluna `TAB`)
- Tela modal: `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompraItem.pas` (`TfrmPedidoCompraItem`, "Complete as informações do item") — sem alteração, apenas hospeda `btnExcluir`/`pnlItens` reparentado de `untPedidoCompra.pas`
- Componente de grid: `cxvItens` (`TcxGridDBTableView`), coluna de agrupamento `cxvItensNVLGIR` (Nível de Giro)
- Datasets: `cdsItensPedido` (`TUniClientDataSet`, itens do pedido), `sltItems` (`TStringList` ordenada, compartilhada entre `TfrmPedidoDeCompra` e `TfrmConsultaItensGiro`, controla o marcador "já no pedido")

## 3. Requisitos funcionais

- RF01 — Ao excluir um único item (via TAB → botão "Excluir" em `frmPedidoCompraItem`) com o grid `cxvItens` agrupado por Nível de Giro, **somente o item focado** deve ser removido de `cdsItensPedido`; os demais itens do mesmo grupo devem permanecer intactos.
- RF02 — Após a exclusão de um item único, o agrupamento por Nível de Giro deve ser restaurado (grid continua agrupado e expandido, como estava antes da exclusão).
- RF03 — Ao pesquisar (TAB) um item que efetivamente já está no pedido, o botão "Excluir" deve aparecer dentro de `frmPedidoCompraItem` e o item deve ser corretamente marcado como "já no pedido" na tela de consulta por Giro.
- RF04 — O marcador "já no pedido" (coluna `TAB` na consulta por Giro) deve usar comparação exata de código de produto, nunca correspondência parcial/substring.

## 4. Regras de negócio

- RN01 — O comportamento de agrupar/desagrupar ao redor da exclusão (já existente no caminho de exclusão múltipla) deve ser replicado, de forma equivalente, no caminho de exclusão de item único — sem alterar o comportamento já correto da exclusão múltipla.
- RN02 — A comparação de "produto já está no pedido" (tanto para exibir o botão Excluir quanto para o marcador visual da consulta por Giro) deve sempre ser por igualdade exata de código de produto, nunca por substring.
- RN03 — O ajuste defensivo no estado do dataset antes do delete não deve alterar o comportamento funcional existente de `pApagaItem` em nenhum outro cenário (grid agrupado ou não) — é puramente uma garantia de estado limpo (`Post`/`Cancel` condicional se `cdsItensPedido.State In [dsEdit, dsInsert]`), sem novo diálogo ou bloqueio ao usuário.

## 5. Requisitos técnicos / não-funcionais

- Arquivos `untPedidoCompra.pas` e `untConsultaItensGiro.pas` estão em encoding `cp1252` (Windows-1252) — toda edição via script Python com `encoding='cp1252'`, `newline=''`, nunca via ferramenta de edição genérica que resalva o arquivo inteiro.
- Instrumentação temporária de diagnóstico (`pLogReq461267`/`pLogReq461267Giro`, grava em `<pasta do exe>\temp\logerr\req461267.log`) foi adicionada durante a investigação e **deve ser removida** antes do fechamento definitivo do requisito, após validação final do fix.
- Sem impacto em transação, auditoria ou permissão — a correção não altera a semântica de gravação do pedido, apenas a mecânica de exclusão de item em tela e a comparação de string na consulta por Giro.

## 6. Critérios de aceitação

- [x] Causa raiz confirmada por reprodução direta (print/vídeo do usuário, 2026-09-14): exclusão de item único com grid agrupado por Giro apaga o grupo inteiro.
- [x] Fix aplicado: `btnApagaClick`, ramo de exclusão de item único, desagrupa antes e reagrupa depois do delete (mesma proteção do ramo de exclusão múltipla).
- [x] Validação funcional pelo usuário (log `req461267.log`, 2026-09-14): três exclusões de item único consecutivas, grid agrupado por Giro, cada uma reduzindo `RecordCount` em exatamente 1 (antes do fix, uma única exclusão reduzia em 20 — tamanho do grupo).
- [x] Fix aplicado: comparação exata (`sltItems.Find(QuotedStr(...))`, não mais `Pos()`/substring) em `dbgConsultaDrawColumnCell` (`untConsultaItensGiro.pas`).
- [x] Fix aplicado: garantia de estado limpo de `cdsItensPedido` (`Post` se `dsEdit`/`dsInsert`) antes do `DeleteFocused` em `pApagaItem`.
- [x] Instrumentação temporária de log removida por completo de `untPedidoCompra.pas` e `untConsultaItensGiro.pas` (helpers `pLogReq461267`/`pLogReq461267Giro` e todas as chamadas).
- [x] Arquivos alterados permanecem decodificáveis em `cp1252` sem erro e sem a sequência de bytes `\xef\xbf\xbd` após todas as alterações.
- [x] Revisão de código (2026-09-14): guarda defensiva de estado do dataset corrigida de `Post` para `Cancel` (Nota 3 revisada) — `Post` podia lançar exceção e abortar a exclusão.
- [x] Revisão de código (2026-09-14): adicionado `Try/Finally` no ramo de exclusão de item único para restaurar `AfterScroll`/`GroupIndex` mesmo em caso de exceção (Nota 4).
- [x] Revisão de código (2026-09-14): replicado o mesmo `Try/Finally` no ramo de exclusão múltipla, que tinha o mesmo defeito pré-existente (Nota 4 revisada).
- [x] Revisão de código (2026-09-14): adicionado log de exceção (`pMensagensErro`) no `Except` externo de `btnApagaClick`, que antes silenciava qualquer falha sem registro (Nota 5, nova).
- [ ] Validação funcional pelo usuário dos fixes correlatos (comparação exata na consulta por Giro e estado defensivo do dataset) — ainda pendente de teste manual dedicado.
- [ ] Repetir o cenário completo do chamado original (produto 04025, itens de Giro B, produtos 05609/05384/04888) como validação final.

## 7. Fora de escopo

- Qualquer refatoração do mecanismo de agrupamento/exclusão do `TcxGridDBTableView` além do necessário para corrigir a assimetria identificada.
- Qualquer alteração no caminho de exclusão múltipla (`stlProdutosMarcados.Count > 0`) — já está correto.
- Migração de `sltItems`/marcação de "já no pedido" para outro mecanismo de armazenamento — mantido o padrão existente (`TStringList` ordenada), apenas corrigida a comparação.
- Verificação/replicação em outras cópias irmãs do projeto (`.150`, `.150.100`, `.111`, etc.) — não solicitada neste requisito; pode ser avaliada separadamente se o mesmo padrão de código existir lá.

## 8. Dependências e riscos

- **Dependência:** nenhuma — correção isolada às units `untPedidoCompra.pas` e `untConsultaItensGiro.pas`.
- **Risco (baixo):** ao desagrupar/reagrupar no caminho de item único, garantir que `cxvItens.DataController.Groups.FullExpand` não gere efeito colateral visual (ex.: perda de posição de scroll) perceptível ao usuário — mitigado por ser o mesmo padrão já em uso e validado no caminho de exclusão múltipla.
- **Risco (baixo):** a correção do `Pos()` para comparação exata pode, em tese, deixar de marcar como "já no pedido" um item que dependia do comportamento de substring por engano — avaliado como improvável e desejável (o comportamento correto é comparação exata).

## Notas Referenciadas no Código-Fonte

### Nota 1

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, ramo de exclusão de item único (comentário: "Verificar Nota 1 - Req. 461267").

**Explicação completa:** o `TcxGridDBTableView` (`cxvItens`) pode estar agrupado pela coluna de Nível de Giro (`cxvItensNVLGIR.GroupIndex >= 0`). Quando agrupado, chamar `cxvItens.DataController.DeleteFocused` (indiretamente, via `pApagaItem`) sobre um único registro focado resulta, na prática, na exclusão de **todos os registros do grupo atualmente focado/selecionado**, não apenas do registro focado — comportamento do `TcxGridDBDataController` da DevExpress quando o agrupamento está ativo no momento da chamada de exclusão.

O caminho de exclusão múltipla desta mesma função (`btnApagaClick`, ramo `stlProdutosMarcados.Count > 0`) já continha a proteção correta para esse cenário: desagrupar (`cxvItensNVLGIR.GroupIndex := -1`) antes do laço de exclusão, e reagrupar (`GroupIndex := 0` + `cxvItens.DataController.Groups.FullExpand`) depois. Essa proteção nunca foi replicada para o ramo de exclusão de item único (usado pelo fluxo padrão de pesquisa: TAB → botão "Excluir" dentro de `frmPedidoCompraItem`), o que permitiu que uma exclusão aparentemente trivial de um único produto apagasse, por efeito colateral, todo o grupo de Giro ao qual ele pertencia.

Se esse desagrupar/reagrupar for removido futuramente por parecer "redundante" ou "só uma chamada a mais sem efeito visível em teste com grid não agrupado", o bug volta a se manifestar sempre que o usuário estiver com o grid agrupado por Giro — que é o modo de operação padrão do cliente KUSMA (e potencialmente de outros clientes que usam a consulta por Giro). Por isso a chamada deve ser mantida mesmo que pareça não fazer diferença em testes com o grid desagrupado.

### Nota 2

**Local:** `untConsultaItensGiro.pas`, `TfrmConsultaItensGiro.dbgConsultaDrawColumnCell` (comentário: "Verificar Nota 2 - Req. 461267").

**Explicação completa:** o marcador visual "já incluído no pedido" (coluna `TAB` da grid de consulta por Giro) originalmente usava `Pos(codigo, sltItems.CommaText) > 0` para verificar se o código do produto em exibição estava na lista `sltItems` (uma `TStringList` **Sorted**, cujos itens são armazenados como `QuotedStr(codigo)`, ex.: `'04025'`). `Pos()` faz busca de **substring dentro do texto inteiro** retornado por `sltItems.CommaText` (todos os códigos concatenados por vírgula), e não uma busca de item exato na lista.

Isso é estruturalmente frágil: um código de produto que seja substring de outro código presente na lista (ex.: "025" aparecendo dentro de "10025", ou qualquer padrão de dígitos coincidente entre dois códigos vizinhos na string concatenada) pode gerar falso positivo — o produto é marcado como "já no pedido" mesmo sem estar lá. Da mesma forma, colisões improváveis mas possíveis podem mascarar itens realmente presentes.

A correção usa `sltItems.Find(QuotedStr(codigo), intIndice461267)`, que faz busca binária exata (a lista é `Sorted`) pelo item literal `'codigo'` — o mesmo padrão de comparação já usado corretamente em `pRetiraDaListaConsulta` (`untPedidoCompra.pas`), garantindo consistência entre os dois pontos do código que consultam `sltItems`.

Se esta comparação for revertida para `Pos()` no futuro (por exemplo, ao copiar o padrão de outro trecho de código legado que ainda usa substring), o defeito de falso positivo/negativo no marcador "já no pedido" volta a existir, de forma silenciosa e difícil de perceber em teste manual casual (só aparece com combinações específicas de códigos).

### Nota 3

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.pApagaItem` (comentário: "Verificar Nota 3 - Req. 461267").

**Explicação completa:** antes de chamar `cxvItens.DataController.DeleteFocused`, foi adicionada uma guarda defensiva. A versão inicial usava `If cdsItensPedido.State In [dsEdit, dsInsert] Then cdsItensPedido.Post;`, mas essa versão foi **revisada em revisão de código** (2026-09-14): `Post` é semanticamente o oposto do que a rotina de exclusão pretende fazer — se o registro em `dsInsert`/`dsEdit` tiver campo obrigatório vazio ou uma regra de negócio em `OnBeforePost` que reprove o estado atual, `Post` lançaria uma exceção *antes* de chegar ao `DeleteFocused`, abortando a exclusão e deixando o registro com edição/inserção pendente na base — exatamente o cenário que a guarda deveria evitar. A versão final usa `cdsItensPedido.Cancel`, que descarta a edição pendente sem executar validação alguma, garantindo que o dataset chegue a `dsBrowse` antes do `DeleteFocused` independentemente do conteúdo da edição pendente.

O fluxo de cancelamento de item em edição (`btnCancelaItemClick`/`pLimpaDadosItem`) nunca chama `cdsItensPedido.Cancel`/`.Post` explicitamente — ele apenas limpa os campos de UI (`Edit`/`Clear` dos componentes visuais), deixando uma janela teórica em que `cdsItensPedido` poderia permanecer em `dsEdit`/`dsInsert` no momento em que o usuário aciona a exclusão de um item.

Chamar `DeleteFocused`/`Delete` sobre um dataset em `dsEdit`/`dsInsert` tem semântica ambígua dependendo do driver/provider (pode descartar a edição pendente de forma implícita, gerar exceção, ou em casos raros corromper o registro focado) — por isso a garantia de estado limpo antes do delete é uma prática defensiva padrão ao lidar com `TDataSet`/`TUniClientDataSet`. Como a rotina está prestes a excluir o registro de qualquer forma, `Cancel` é a operação correta (descartar), não `Post` (persistir).

**Importante:** a instrumentação de log rodada em 2026-09-14, em múltiplas exclusões de item único reproduzindo o cenário do chamado, sempre capturou `State=1` (`dsBrowse`, estado limpo) no momento do delete — ou seja, **este ajuste não foi o causador do bug relatado** (a causa raiz real foi a Nota 1, `GroupIndex`). Este ajuste é mantido como camada de segurança adicional (defesa em profundidade), aprovada explicitamente pelo usuário como parte do escopo de correção, e não deve ser removido por parecer "código morto" ou "nunca executa" — ele existe para cobrir um cenário que a investigação não conseguiu reproduzir, mas que continua teoricamente possível dado que `pLimpaDadosItem` nunca sincroniza o estado do dataset.

### Nota 4

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, ramo de exclusão de item único (comentário: "Verificar Nota 4 - Req. 461267").

**Explicação completa:** identificado em revisão de código (2026-09-14) que o desagrupar (`cxvItensNVLGIR.GroupIndex := -1`) e a suspensão do `AfterScroll` (`cdsItensPedido.AfterScroll := Nil`) introduzidos pelo Fix principal (Nota 1) não tinham proteção contra exceção: se `pApagaItem` ou `pFechaCompraItem` lançassem uma exceção, o `Try/Except` externo de `btnApagaClick` apenas decrementa `intConfirma` — nunca restaura `AfterScroll` nem reagrupa o grid. O resultado seria um grid permanentemente desagrupado e sem o handler `AfterScroll` original até uma próxima ação do usuário que os redefinisse (efeito colateral silencioso na interface, sem mensagem de erro visível além da exceção original).

A correção envolve `pApagaItem`/`pFechaCompraItem` em um bloco `Try/Finally` dedicado, restaurando `cdsItensPedido.AfterScroll := pAferScroll` e reagrupando (`GroupIndex := 0` + `Groups.FullExpand`, se `blnAgrupado`) no `Finally` — garantindo que o grid volte ao estado consistente mesmo que a exclusão falhe no meio do caminho. As chamadas `pAferScroll(cdsItensPedido)` e `pAtualizaGridRodape(...)` permanecem fora do `Finally` (só executam em caso de sucesso), preservando o comportamento original para o caminho feliz.

**Atualização (2026-09-14):** por decisão do usuário, o mesmo padrão `Try/Finally` foi posteriormente replicado também no ramo de exclusão múltipla (`stlProdutosMarcados.Count > 0`), que tinha exatamente o mesmo defeito pré-existente (não introduzido por este requisito). Ver Nota 4 revisada abaixo — a nota passou a cobrir os dois ramos.

### Nota 4 (revisada — cobre ambos os ramos)

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, ramos de exclusão de item único **e** de exclusão múltipla (comentário: "Verificar Nota 4 - Req. 461267").

**Explicação completa:** a proteção por `Try/Finally` descrita acima foi inicialmente aplicada apenas ao ramo de exclusão de item único (Fix de revisão). Em nova rodada de revisão de código, foi apontado que o ramo de exclusão múltipla (`stlProdutosMarcados.Count > 0`) tinha exatamente o mesmo problema: `cxvItensNVLGIR.GroupIndex := -1` e `cdsItensPedido.AfterScroll := Nil` eram atribuídos sem proteção, e uma exceção dentro do laço `For` (em qualquer chamada a `pApagaItem`) ou em `pFechaCompraItem` pulava direto para o `Except` externo, sem restaurar `AfterScroll` nem reagrupar o grid.

A estrutura desse ramo é mais aninhada que a do ramo único, pois `AfterScroll := Nil` só ocorre dentro do bloco condicional `If fPerguntaExclusaoColetaMarcados Then`, enquanto o desagrupamento (`GroupIndex := -1`) ocorre antes desse condicional. Por isso foram usados **dois níveis de `Try/Finally`** aninhados: um interno, ao redor do laço de exclusão e de `pFechaCompraItem`, restaurando apenas `AfterScroll` no `Finally`; e um externo, ao redor de todo o bloco (incluindo `fPerguntaExclusaoColetaMarcados`, `stlProdutosMarcados.Clear` e `cxvItens.DataController.Refresh`), restaurando o `GroupIndex`/`FullExpand` no `Finally`. O reposicionamento do cursor (`cdsItensPedido.Locate('ITE_CODITE', strCodIte, [])`) foi mantido fora do `Finally`, pois só faz sentido executar após o regroup ter ocorrido com sucesso (mesmo comportamento do caminho feliz original).

Com essa mudança, os dois ramos de `btnApagaClick` ficam simétricos: qualquer exceção durante a exclusão (única ou múltipla) restaura corretamente o `AfterScroll` e o agrupamento do grid antes de propagar a exceção para o `Except` externo.

### Nota 5

**Local:** `untPedidoCompra.pas`, `TfrmPedidoDeCompra.btnApagaClick`, bloco `Except` externo (comentário: "Verificar Nota 5 - Req. 461267").

**Explicação completa:** o bloco `Except InterlockedDecrement(intConfirma); End;` que envolve todo o corpo de `btnApagaClick` engolia qualquer exceção silenciosamente, sem log nem mensagem ao usuário — comportamento pré-existente. Apontado em revisão de código que esta correção adiciona novos caminhos de exceção possíveis dentro desse escopo (`Cancel`/`Post` em `pApagaItem`, troca de `GroupIndex`, `FullExpand`), de modo que falhas nessas operações específicas também ficavam completamente invisíveis, dificultando diagnóstico futuro.

Corrigido adicionando `On E: Exception Do pMensagensErro(E.Message, '[TfrmPedidoDeCompra.btnApagaClick]');` antes do `InterlockedDecrement(intConfirma)`, reutilizando o padrão já amplamente usado em outros pontos desta mesma unit (mais de 30 ocorrências de `pMensagensErro(E.Message, '[...]')` em blocos `Except` de `untPedidoCompra.pas`). `pMensagensErro` é a rotina central do projeto para tratamento/exibição de erro (`untFuncoesSimples.pas`), então esta mudança alinha `btnApagaClick` ao padrão já estabelecido no restante da unit, em vez de inventar um mecanismo de log novo.

**Mudança de comportamento observável:** antes, uma falha durante a exclusão era completamente silenciosa para o usuário; após esta correção, o usuário passa a ver uma mensagem de erro (via `pErro`/`fMensagem`, conforme o tipo de erro) quando uma exceção ocorrer durante `btnApagaClick`. Essa mudança foi avaliada como desejável (evita que o usuário ache que a exclusão funcionou quando na verdade falhou) e consistente com o padrão já usado no restante da tela.

**Correção de ordem (2026-09-14):** revisão de código adicional apontou que a primeira versão desta nota colocava `InterlockedDecrement(intConfirma)` **depois** de `pMensagensErro`. Isso é incorreto: `pMensagensErro` (a versão de `untFuncoesSimples.pas`, resolvida pelo `uses` desta unit) pode ela mesma lançar exceção — incondicionalmente se `VS_TentativaFaturamentoAutomatico` estiver `True` (`Raise Exception.Create(...)` explícito), e potencialmente em qualquer outro caso, já que o corpo da função só tem `Try/Finally` (não `Try/Except`), então uma falha em `pErro`/`fMensagem`/`fRollBack` chamados internamente também propagaria. Se `pMensagensErro` lançasse, o `InterlockedDecrement` nunca executaria, e `intConfirma` ficaria travado permanentemente acima de zero — todo clique futuro em `btnApagaClick` cairia no ramo `Else InterlockedDecrement(intConfirma)` sem nunca ter incrementado com sucesso, desabilitando a exclusão até o form ser recriado. Corrigido invertendo a ordem (`InterlockedDecrement` primeiro, `pMensagensErro` depois) — exatamente o padrão já usado em `TfrmPedidoDeCompra.btnConfirmaClick` na mesma unit.

**Incidente de corrupção durante a correção (2026-09-14) e recuperação:** ao aplicar uma correção de ordem em `pAferScroll`/`pAtualizaGridRodape` dentro do `Finally` do ramo único, a ferramenta `Edit` foi usada por engano diretamente em `untPedidoCompra.pas` (cópia `74.150.45`) — violação da regra do projeto de nunca usar `Edit` em arquivos `.pas`/`.dfm` (encoding `cp1252`), pois ela resalva o arquivo inteiro e pode corromper acentuação em qualquer ponto do arquivo, mesmo sem relação com o texto editado. Isso corrompeu silenciosamente um acento não relacionado (`Carência` → `Car\xef\xbf\xbdncia`) em uma região do código muito distante de qualquer alteração deste requisito. Detectado pela validação padrão pós-edição (checagem de `\xef\xbf\xbd`). Recuperado via `svn cat -r BASE` (revisão limpa, anterior a toda a investigação do Req. 461267): as procedures `pApagaItem` e `btnApagaClick` foram reconstruídas a partir do BASE, usando como referência as versões corretas já validadas na cópia irmã `74.150.100` (nunca tocada pela ferramenta `Edit` nesta sessão), e o fix de ordem foi reaplicado por cima via Python. Validado via `svn diff` que **apenas as 3 regiões pretendidas** (Nota 3, ramo múltiplo, ramo único+Except) aparecem como alteradas — nenhum resquício da corrupção. Confirmado que as 3 working copies têm `pApagaItem`/`btnApagaClick` byte-a-byte idênticos após a recuperação.
