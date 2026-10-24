# Especificação — Req. 462720

**Título:** Giro de estoque não carrega ao alterar pedido de compra existente
**Objetivo:** Fazer o giro de estoque (incluindo agregação de itens similares) carregar corretamente ao reabrir um pedido de compra já existente para alteração, quando a opção Giro = Sim está habilitada.
**Zona:** Legado
**Data:** 2026-09-21

## 1. Contexto / problema atual

Ao abrir um pedido de compra já existente (ex.: pedido `000000000111`, empresa `004`) para alteração, com a opção **Giro = Sim**, os campos de giro do item (`ITE_Q_V_01` a `ITE_Q_V_12` e demais campos de saldo/giro) apareciam zerados na tela — tanto na grade principal quanto no painel "Meses de Giro" — mesmo quando existe movimento real na `GIRITE` para o grupo de itens similares (`chkAgrSim = 'S'`).

Comparando com o cálculo "do zero" (via tela de giro/relatório), que usa a mesma implementação de fundo (`TGiroPedido.fExecutaSQLGiroEstoque` + `FILTRO_ITEM`/`pIncluiSimilares`) e mostra os valores corretos, a investigação revelou **dois bugs distintos e independentes**, ambos necessários para o sintoma completo: o primeiro impedia o carregamento do giro na grade principal de um item já existente no pedido; o segundo — descoberto só depois de corrigir o primeiro, quando o sintoma persistiu no painel "Meses de Giro" — fazia o próprio cálculo de giro (usado tanto pela grade quanto pelo painel) retornar zero para o cenário de alteração, mesmo reaproveitando a rotina já validada como correta para "giro do zero".

### Bug 1 — guard pulava o carregamento de giro em `fCarregaItensPedidoAux`

Instrumentação de log em runtime (`pLogGiroDebug`) confirmou:

- A função `TfrmPedidoDeCompra.fCarregaItensPedidoAux` (`untPedidoCompra.pas`) é a responsável por recarregar os itens de um pedido já existente ao abri-lo para alteração (usa `qryPcmDet`, com barra de progresso proporcional a `qryPcmDet.RecordCount`).
- Nela existia o guard:
  ```pascal
  If (recOpcGir.strPedMlj <> 'S') And (Not blnUsarGiro) And (Not blnAltPedGir) Then
    pCarrregaDadosGiro(cdsItensPedido, strEmpSaldos, IIF(recOpcGir.blnAgrSim, qryPcmDet.FieldByName('ITE_CODSIM').AsString, ''));
  ```
  Quando `blnAltPedGir = True` (alteração de pedido com giro — o cenário normal ao reabrir um pedido com Giro=Sim), a chamada a `pCarrregaDadosGiro` era **pulada**.
- Diferente da função irmã `TfrmPedidoDeCompra.fAdicionaItem` (usada para adicionar item novo via busca), `fCarregaItensPedidoAux` **não tinha nenhum caminho alternativo** que populasse `ITE_Q_V_xx` para o caso `blnAltPedGir = True`.
- Resultado: para itens já existentes no pedido, ao reabrir para alteração com Giro=Sim, nenhuma das duas rotinas de cálculo de giro (`pRetCamposGiro` ou `pCarrregaDadosGiro`) era chamada. O campo ficava no valor padrão (zero/vazio) em `cdsItensPedido`.

#### Origem histórica (SVN blame/log)

- **r142365** (laercio, 2016-11-11, Req. 65181): introduziu o guard `(Not blnUsarGiro) And (Not blnAltPedGir)`. Objetivo original: mostrar giro também quando **Giro = Não** (antes só aparecia com Giro = Sim). A exclusão de `blnAltPedGir` presumia que, nesse caso, o giro já seria carregado por outro caminho — suposição que nunca foi verdadeira para esta função.
- **r187518** (laercio, 2019-04-09): adicionou suporte a `strCodSim`/`blnAgrSim` na chamada de `pCarrregaDadosGiro` (antes recebia só `strEmpDes`), tanto em `fAdicionaItem` quanto em `fCarregaItensPedidoAux` — sem alterar o guard problemático.
- Em `fAdicionaItem`, o guard equivalente já havia sido corrigido informalmente: `{(Not blnUsarGiro) And (Not blnAltPedGir)}` está **comentado** (desativado), deixando só a checagem de `State = dsInsert`. `fCarregaItensPedidoAux` nunca recebeu a correção análoga.

#### Correção aplicada

Guard simplificado para manter apenas a checagem de Multi-loja:
```pascal
If (recOpcGir.strPedMlj <> 'S') Then
  pCarrregaDadosGiro(cdsItensPedido, strEmpSaldos, IIF(recOpcGir.blnAgrSim, qryPcmDet.FieldByName('ITE_CODSIM').AsString, ''));
```

**Resultado parcial:** log confirmou `cdsItensPedido.ITE_Q_V_01 = 16` após a correção — mas o valor **ainda não aparecia na tela** (grade e painel "Meses de Giro" continuavam em `0,00`). Isso levou à investigação do Bug 2.

### Bug 2 — `FIL_AGRUPA` incorreto no branch de alteração de `pCriaTabelaFiltroItem` (causa raiz do sintoma visível)

Rastreamento da cadeia de binding da tela (painel "Meses de Giro", form `frmTelaGiroUma`) mostrou que ela é alimentada por `cdsItensGiroExt`, atribuído em `untMenuPedCom.pas` (`TfrmMenuPedCom.fCalculoGiro`) a partir de `cdsItensGiro`, **populado pela mesma rotina "giro do zero"** (`fCalculaGiroEstoque` → `TGiroPedido.fExecutaSQLGiroEstoque`), só que chamada com `strNumPedAlt`/`strEmpPedAlt`/`strEspPedAlt` preenchidos (cenário de alteração).

Instrumentação de log direto nessa chamada (`PONTO7`) revelou que **o próprio `cdsItensGiro` já vinha com `ITE_Q_V_01 = 0`** para o item `03699`, mesmo com `blnAgrSim = True` — ou seja, o bug não estava na propagação para a tela, e sim dentro da rotina de cálculo em si, especificamente no cenário de alteração (`strNumPedAlt` preenchido).

Dentro de `TGiroPedido.pCriaTabelaFiltroItem` (`untFuncoesPedido.pas`), a tabela em memória `FILTRO_ITEM` é semeada por dois `SELECT`s diferentes quando `strNumPedAlt` está preenchido:

1. **Branch específico de alteração** (a partir de `PCMDET`, os itens já lançados no pedido):
   ```sql
   IF(ITE_PRISIM = "S", ITE_CODSIM, PCD_CODITE) AS FIL_AGRUPA
   ```
2. **Branch padrão** (a partir de `CADITE`, usado tanto em alteração quanto em "giro do zero" para os demais itens):
   ```sql
   IF(IFNULL(ITE_CODSIM, "") = "", C.ITE_CODITE, C.ITE_CODSIM) AS FIL_AGRUPA
   ```

Os dois critérios são **diferentes**: o branch de alteração só agrupa pelo código do grupo de similares (`ITE_CODSIM`) quando o item é explicitamente marcado como principal (`ITE_PRISIM = 'S'`). O branch padrão agrupa por `ITE_CODSIM` sempre que o item pertence a um grupo, independentemente de haver ou não um item marcado como principal.

Consulta direta ao banco confirmou que, no grupo de similares `ITE_CODSIM = '031272'` (que inclui o item `03699`), **nenhum item tem `ITE_PRISIM = 'S'`** (todos `'N'`) — situação já conhecida e documentada (ver memória do projeto sobre `CFG_REMSIM`: o trigger de remoção de similares zera `ITE_PRISIM` de todos os itens do grupo em certos cenários). Como consequência, no branch de alteração, `FIL_AGRUPA` caía sempre para `PCD_CODITE` (o código do próprio item), isolando cada item do grupo em seu próprio "agrupamento" de uma linha só, em vez de agrupá-los sob o código do grupo (`031272`). O `GROUP BY FIL_AGRUPA` na query principal de agregação (`fExecutaSQLGiroEstoque`) então somava o giro de cada item isoladamente — e o item `03699`, sozinho, não tem saída própria registrada na `GIRITE` (só o grupo, somado, tem `16`).

Esse bug **só se manifesta no fluxo de alteração** (branch alimentado por `PCMDET`, ativo apenas quando `strNumPedAlt` está preenchido) — por isso o cálculo "do zero" (sem `strNumPedAlt`, que usa exclusivamente o branch padrão a partir de `CADITE`) sempre funcionou corretamente, confundindo a investigação inicial.

#### Correção aplicada

Alinhado o critério do branch de alteração ao mesmo já usado no branch padrão, tanto para `FIL_AGRUPA` quanto para `FIL_CODPRI` (que tinha o mesmo problema de raiz: usava `PCD_CODITE` diretamente em vez de resolver o item principal do grupo via `fSQLCodItemPrincipal`):

```sql
IF(IFNULL(ITE_CODSIM, "") = "", PCD_CODITE, ITE_CODSIM) AS FIL_AGRUPA
```

(versão de `74.150.45`, sem `SIMEMP`.) Nas working copies `379.48.2.30.74.150` e `379.48.2.30.74.150.100`, que possuem uma variante mais nova do código com suporte a `CFG_SIMEMP = '2'` (agrupamento de similares por empresa, campos `ITE_SIMCOD`/`ITE_SIMPRI` em `ITEGER`), a mesma correção foi replicada nos dois sub-branches (`SIMEMP = '2'` e padrão).

**Validação:** após a correção, log confirmou `cdsItensGiro.ITE_Q_V_01 = 16` direto após `fCalculaGiroEstoque` (`PONTO7`), propagando corretamente até `cdsItensPedido` (`PONTO5`). Confirmado visualmente na tela: painel "Meses de Giro" exibindo `2026/08 = 16,00` para o item `03699` no pedido `000000000111`.

### Escopo multi-working-copy

Os dois bugs (guard em `fCarregaItensPedidoAux` e `FIL_AGRUPA` em `pCriaTabelaFiltroItem`) foram confirmados e corrigidos nas três working copies:
- `379.48.2.30.74.150.45` (validado funcionalmente, com instrumentação de log temporária)
- `379.48.2.30.74.150` (corrigido por leitura de código — variante `SIMEMP`)
- `379.48.2.30.74.150.100` (corrigido por leitura de código — variante `SIMEMP`)

## 2. Módulos e entidades envolvidos

- Módulo: Movimentação de Itens > Pedido de Compra
- Units:
  - `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untPedidoCompra.pas` — função `TfrmPedidoDeCompra.fCarregaItensPedidoAux` (Bug 1)
  - `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untFuncoesPedido.pas` — procedure `TGiroPedido.pCriaTabelaFiltroItem` (Bug 2)
- Units correlatas (não alteradas, apenas usadas): `untFuncoesPedidoSimples.pas` (`pCarrregaDadosGiro`, `fSQLGiro`), `untMenuPedCom.pas` (`TfrmMenuPedCom.fCalculoGiro`), `untCdsDigMultLoja.pas`, `untTelaGiroUma.pas`
- Tabelas: `PCMDET` (itens do pedido), `GIRITE` (giro de estoque por item/empresa/mês), `CADITE` (cadastro de item, campos `ITE_CODSIM`/`ITE_PRISIM` para agrupamento de similares; `ITE_SIMCOD`/`ITE_SIMPRI` em `ITEGER` na variante `SIMEMP='2'`)

## 3. Requisitos funcionais

- RF01 — Ao reabrir um pedido de compra existente para alteração com Giro = Sim, os campos de giro (`ITE_Q_V_01..12`, `ITE_Q_C_xx`, `ITE_Q_VP_xx`, `ITE_QORC_xx`, saldos, médias) devem ser carregados para cada item recarregado, tanto na grade principal quanto no painel "Meses de Giro", exatamente como já ocorre no cálculo "do zero".
- RF02 — Quando `chkAgrSim = 'S'` (agrupar por similares), o giro carregado deve ser a soma de todos os itens do grupo (`ITE_CODSIM`), independentemente de algum item do grupo estar ou não marcado como principal (`ITE_PRISIM = 'S'`).
- RF03 — O comportamento para Multi-loja (`strPedMlj = 'S'`) não deve ser alterado.

## 4. Regras de negócio

- RN01 — `ITE_Q_V_01` corresponde ao giro do mês anterior ao atual (não ao mês calendário "01"); a numeração é relativa (`IncMonth(VS_Date, -1)` e retrocede), inalterado por esta correção.
- RN02 — A agregação por similares soma `GIR_QSAIxx` de todos os itens com o mesmo `ITE_CODSIM`/`FIL_AGRUPA`, independentemente de haver ou não um item marcado como principal (`ITE_PRISIM = 'S'`) no grupo — situação real e recorrente neste banco, onde o trigger `CFG_REMSIM` pode zerar `ITE_PRISIM` de todos os itens de um grupo.

## 5. Requisitos técnicos / não-funcionais

- Nenhum impacto em transação, permissão ou auditoria — as duas correções são restritas ao carregamento (leitura) de dados de giro em memória, sem gravação em banco.
- Manter a proteção existente em `pCarrregaDadosGiro` (`If Not (State In dsEditModes) Then Exit`).
- **Instrumentação de log temporária:** para validar as correções em ambiente real, foi mantida em `379.48.2.30.74.150.45` a rotina `pLogGiroDebug` e os pontos de log inseridos (`untFuncoesPedidoSimples.pas`, `untMenuPedCom.pas`, `untPedidoCompra.pas`), gravando em `C:\Users\danilo.stefaneli\Desktop\temp\giro_debug.log`. Essa instrumentação é temporária, não foi replicada nas demais working copies, e será removida a critério do usuário após validação final.

## 6. Critérios de aceitação

- [x] Reabrindo o pedido `000000000111` (empresa `004`) em alteração com Giro=Sim e `chkAgrSim` marcado, o campo `ITE_Q_V_01` (mês 2026/08) do item `03699` exibe `16,00` no painel "Meses de Giro" — validado visualmente na tela.
- [ ] Com `chkAgrSim` desmarcado, o mesmo campo exibe o giro do item isolado (`0,00` para o item `03699`, conforme dado real da `GIRITE`).
- [ ] O fluxo de Multi-loja (`strPedMlj = 'S'`) permanece funcionando sem alteração de comportamento.
- [ ] O fluxo de adicionar item novo (`fAdicionaItem`) permanece funcionando sem alteração de comportamento.
- [x] As duas correções aplicadas e validadas (por leitura de código + conferência de `svn diff`) nas working copies `379.48.2.30.74.150` e `379.48.2.30.74.150.100`.

## 7. Fora de escopo

- Refatoração das três implementações paralelas de cálculo de giro (`fExecutaSQLGiroEstoque`/`FILTRO_ITEM`, `pRetCamposGiro`/`cdsItensGiro`, `pCarrregaDadosGiro`/`fSQLGiro`) em uma única rotina — fica registrado como débito técnico, não tratado neste requisito.
- Remoção da instrumentação de log (`pLogGiroDebug`) — feita à parte, após validação do usuário.
- Qualquer ajuste no branch **padrão** de `pCriaTabelaFiltroItem`/`pIncluiSimilares` (fluxo "giro do zero", sem `strNumPedAlt`) — já validado como correto pelo usuário, não foi tocado.
- Qualquer alteração em `ITE_PRISIM`/trigger `CFG_REMSIM` — fora de escopo; a correção apenas deixa de depender desse flag para decidir o agrupamento.

## 8. Dependências e riscos

- **Risco (Bug 1):** remover a exclusão de `blnAltPedGir` no guard pode introduzir uma chamada extra a `pCarrregaDadosGiro` (uma query por item recarregado) em cenários onde antes não rodava. Mitigação: `pCarrregaDadosGiro`/`fSQLGiro` são somente leitura, idempotentes, e já são chamadas normalmente no fluxo de item novo sem impacto perceptível.
- **Risco (Bug 2):** alterar `FIL_AGRUPA`/`FIL_CODPRI` no branch de alteração de `pCriaTabelaFiltroItem` afeta apenas a semeadura inicial de `FILTRO_ITEM` a partir de `PCMDET` (itens já lançados no pedido) — os demais itens do grupo continuam sendo agregados via `pIncluiSimilares`, já validado como correto. Mitigação: validado end-to-end via log e visualmente na tela em `74.150.45`; nas demais working copies, validado por leitura de código e `svn diff` restrito.
- **Dependência:** nenhuma alteração de schema; alterações restritas a `untPedidoCompra.pas` e `untFuncoesPedido.pas`.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

No guard alterado em `fCarregaItensPedidoAux` (`untPedidoCompra.pas`), a condição original era:

```pascal
If (recOpcGir.strPedMlj <> 'S') And (Not blnUsarGiro) And (Not blnAltPedGir) Then
  pCarrregaDadosGiro(...);
```

A exclusão `(Not blnUsarGiro) And (Not blnAltPedGir)` foi introduzida na r142365 (2016-11-11, Req. 65181) para resolver um problema diferente do que está sendo corrigido agora: na época, o giro só aparecia na tela do pedido quando a opção **Giro = Sim** estava marcada; o pedido era para fazer o giro aparecer **também** quando **Giro = Não**. Para isso, a chamada a `pCarrregaDadosGiro` foi condicionada a `Not blnUsarGiro` — ou seja, "só rode esta chamada específica quando o usuário NÃO estiver no modo Giro=Sim", presumindo implicitamente que, quando `blnUsarGiro = True` (ou, por extensão, quando `blnAltPedGir = True` — alteração de pedido já usando giro), o carregamento do giro já estaria coberto por **outro** trecho de código.

Essa suposição nunca foi verdadeira para `fCarregaItensPedidoAux`. O único lugar do código que de fato cobre esse caso é a função irmã `fAdicionaItem` (usada para adicionar item novo ao pedido via busca), que tem um bloco próprio (cópia de `cdsItensGiro` — populado por `pRetCamposGiro` — para `cdsItensPedido`, incluindo `ITE_Q_V_01..12`) condicionado apenas a `(blnUsarGiro Or blnAltPedGir) And (Not (blnItemCadastrado Or blnAlterando))`. Esse bloco não existe, e nunca existiu, em `fCarregaItensPedidoAux` — confirmado por busca em todo o corpo da função (não há nenhuma outra referência a `cdsItensGiro` ou `pRetCamposGiro` nela).

Prova disso: em 2019 (r187518), quando o suporte a agrupamento de similares (`strCodSim`/`blnAgrSim`) foi adicionado à assinatura de `pCarrregaDadosGiro`, o autor ajustou a chamada nas duas funções (`fAdicionaItem` e `fCarregaItensPedidoAux`) — mas **não removeu** a exclusão de `blnAltPedGir` em `fCarregaItensPedidoAux`, apesar de já ter percebido e corrigido informalmente o problema análogo em `fAdicionaItem` (lá, a condição `(Not blnUsarGiro) And (Not blnAltPedGir)` está comentada/desativada no código, restando apenas `cdsItensPedido.State = dsInsert`).

Ou seja: o bug de "giro não carrega ao alterar pedido existente com Giro=Sim" existe desde a criação do guard em 2016, mascarado porque a combinação exata (alteração de pedido já existente + Giro=Sim + necessidade de ver o valor de giro) raramente foi conferida a fundo — e passou a ser percebido agora ao testar especificamente o agrupamento por similares (`chkAgrSim`), que tornou a ausência do valor mais visível (grupo com movimento real vs. item isolado sem movimento).

**Por que manter o comentário curto no fonte:** sem essa nota, um desenvolvedor futuro pode olhar para `If (recOpcGir.strPedMlj <> 'S') Then` e achar estranho não haver mais a checagem de `blnUsarGiro`/`blnAltPedGir` (que existe em vários outros pontos da mesma unit) e "corrigir" reintroduzindo a exclusão — reintroduzindo este mesmo bug.

### Nota 2

No branch de `pCriaTabelaFiltroItem` (`untFuncoesPedido.pas`) que semeia `FILTRO_ITEM` a partir de `PCMDET` (ativo apenas quando `strNumPedAlt` está preenchido — ou seja, exclusivamente no cenário de alteração de pedido existente), a expressão original de `FIL_AGRUPA` era:

```sql
IF(ITE_PRISIM = "S", ITE_CODSIM, PCD_CODITE) AS FIL_AGRUPA
```

(equivalente com `ITE_SIMPRI`/`ITE_SIMCOD` na variante `SIMEMP = '2'` de `74.150`/`74.150.100`.)

Essa expressão só agrupa o item pelo código do grupo de similares (`ITE_CODSIM`) quando o próprio item está marcado como o principal do grupo (`ITE_PRISIM = 'S'`). Isso contrasta com o branch padrão da mesma procedure (usado tanto no cenário de alteração para os demais itens quanto no cálculo "do zero"), que sempre usa:

```sql
IF(IFNULL(ITE_CODSIM, "") = "", C.ITE_CODITE, C.ITE_CODSIM) AS FIL_AGRUPA
```

— ou seja, agrupa por `ITE_CODSIM` sempre que o item pertence a um grupo de similares, **independentemente** de haver ou não algum item marcado como principal.

A suposição implícita na expressão original — de que sempre existiria exatamente um item com `ITE_PRISIM = 'S'` em cada grupo de similares — não é verdadeira neste banco. O trigger associado à configuração `CFG_REMSIM` (ver `project_cfg_remsim_historico` na memória do projeto) pode zerar `ITE_PRISIM` de **todos** os itens de um grupo em determinados cenários (ex.: remoção de um item do grupo de similares). Quando isso ocorre — como no grupo `ITE_CODSIM = '031272'`, onde todos os 17 itens têm `ITE_PRISIM = 'N'` — a expressão original sempre caía no `Else` (`PCD_CODITE`), isolando cada item do pedido em seu próprio "agrupamento" de uma única linha em `FILTRO_ITEM`, em vez de agrupá-lo com os demais itens do grupo de similares. Como consequência, o `GROUP BY FIL_AGRUPA` da query de agregação de giro (`fExecutaSQLGiroEstoque`) somava o giro de cada item **isoladamente**, ignorando o giro dos demais similares — e itens sem saída própria na `GIRITE` (mas com saída via outros itens do mesmo grupo) apareciam com giro zero, mesmo quando o giro do grupo, corretamente somado, não era zero.

Este bug só se manifesta no branch de alteração (semeadura via `PCMDET`), porque é o único ponto do código que usava esse critério diferente do padrão. O cálculo "giro do zero" (sem `strNumPedAlt`) nunca passa por este branch — daí ter sido validado como correto pelo usuário antes de a causa real ser encontrada, o que inicialmente direcionou a investigação para o lugar errado (o guard do Bug 1, que era necessário mas não suficiente).

A correção alinha o critério ao mesmo já usado no branch padrão, e também corrige `FIL_CODPRI` (que tinha o mesmo problema de raiz — usava `PCD_CODITE` diretamente em vez de `fSQLCodItemPrincipal`, a função já estabelecida no projeto para resolver o item principal de um grupo de similares de forma robusta a essa mesma situação de "grupo sem item marcado como principal").

**Por que manter o comentário curto no fonte:** a expressão condicionada a `ITE_PRISIM = 'S'` parece, à primeira vista, mais "correta" ou mais específica que o critério padrão (`IFNULL(ITE_CODSIM, "") = ""`) — um desenvolvedor futuro que não conheça o comportamento do trigger `CFG_REMSIM` pode achar que a versão nova está "simplificando demais" e reintroduzir a checagem de `ITE_PRISIM`, reintroduzindo este mesmo bug para qualquer grupo de similares sem item principal marcado.
