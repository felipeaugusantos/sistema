# Análise de Requisito — Req. 462720

**Título:** Giro de estoque não carrega ao alterar pedido de compra existente
**Zona:** Legado (`padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra`)
**Data:** 2026-09-21
**Working copies afetadas:** `379.48.2.30.74.150.45` (implementação e validação funcional completa),
`379.48.2.30.74.150` e `379.48.2.30.74.150.100` (mesma correção replicada, validada por leitura de
código e `svn diff`)

## 1. Contexto de negócio

O módulo de Pedido de Compra exibe, para cada item lançado, o "giro de estoque" — a quantidade
vendida/saída nos últimos 12 meses (campos `ITE_Q_V_01` a `ITE_Q_V_12` da tabela `GIRITE`, um por
mês, numerados de forma relativa ao mês atual e não ao mês calendário: `ITE_Q_V_01` é sempre o mês
anterior ao atual). Esse dado ajuda o comprador a decidir a quantidade a comprar.

O sistema permite agrupar o giro de itens "similares" — itens diferentes que, para fins de compra,
são tratados como equivalentes (ex.: mesma tinta em cores diferentes). O agrupamento é controlado
pela opção "Agrupar por similares" (internamente `chkAgrSim`/`blnAgrSim`) e pela relação de
similaridade cadastrada em `CADITE.ITE_CODSIM` (código do grupo) e `CADITE.ITE_PRISIM` (indica se
aquele item específico é o "principal" do grupo, valor `'S'`/`'N'`). Quando agrupado, o giro exibido
para qualquer item do grupo é a soma do giro de todos os itens do grupo, não apenas do item isolado.

Existe uma particularidade de negócio já conhecida do projeto (documentada em memória interna,
`project_cfg_remsim_historico`): a configuração/trigger `CFG_REMSIM`, usada ao remover um item de um
grupo de similares, pode **zerar `ITE_PRISIM` de todos os itens do grupo** em determinados cenários,
deixando o grupo sem nenhum item marcado como principal. Essa situação é válida e acontece na base
real (confirmado durante esta análise: o grupo `ITE_CODSIM = '031272'`, com 17 itens, tem todos com
`ITE_PRISIM = 'N'`). Qualquer regra de agrupamento de similares precisa funcionar mesmo quando isso
ocorre — não pode depender de existir um item marcado como principal para agrupar corretamente.

O cálculo de giro de estoque é implementado três vezes de forma independente no sistema (débito
técnico conhecido, não tratado nesta correção):

1. `TGiroPedido.fExecutaSQLGiroEstoque` + tabela em memória `FILTRO_ITEM`/`pIncluiSimilares` —
   usada tanto pela tela de "cálculo de giro do zero" (relatório) quanto, reaproveitada, pelo cálculo
   de giro ao abrir um pedido em alteração (`untMenuPedCom.pas`).
2. `pRetCamposGiro` (`untFuncoesPedidoSimples.pas`) — usada ao adicionar um item novo ao pedido
   (`fAdicionaItem`).
3. `pCarrregaDadosGiro`/`fSQLGiro` (`untFuncoesPedidoSimples.pas`) — usada ao recarregar os itens de
   um pedido já existente (`fCarregaItensPedidoAux`).

## 2. Problema relatado

Ao reabrir um pedido de compra já existente (caso de teste: pedido `000000000111`, empresa `004`,
item `03699`) para alteração, com a opção **Giro = Sim**, os campos de giro apareciam **zerados** na
tela — tanto na grade principal de itens quanto no painel "Meses de Giro" — mesmo havendo movimento
real na `GIRITE` para o grupo de similares ao qual o item pertence (soma do grupo = 16 em 2026/08).

O mesmo cálculo, quando executado "do zero" (fora do fluxo de alteração de pedido, ex.: tela de
giro/relatório), retornava o valor correto. Isso indicava que o problema estava especificamente no
caminho de código usado apenas durante a alteração de um pedido já existente.

## 3. Investigação — dois bugs distintos, ambos necessários para o sintoma completo

A investigação (com apoio de instrumentação de log temporária em runtime, ver seção 6) revelou que
o sintoma tinha **duas causas independentes**, sendo a segunda a causa raiz visível na tela.

### 3.1. Bug 1 — grade principal não recebia o giro ao recarregar itens do pedido

A função `TfrmPedidoDeCompra.fCarregaItensPedidoAux` (`untPedidoCompra.pas`) é responsável por
recarregar os itens de um pedido já existente ao abri-lo para alteração. Ela continha o seguinte
guard antes de chamar a rotina que carrega o giro:

```pascal
If (recOpcGir.strPedMlj <> 'S') And (Not blnUsarGiro) And (Not blnAltPedGir) Then
  pCarrregaDadosGiro(cdsItensPedido, strEmpSaldos, IIF(recOpcGir.blnAgrSim, qryPcmDet.FieldByName('ITE_CODSIM').AsString, ''));
```

Quando `blnAltPedGir = True` — exatamente o cenário de reabrir um pedido já existente com Giro=Sim —
a chamada a `pCarrregaDadosGiro` era **pulada**. Diferente da função irmã `fAdicionaItem` (usada ao
adicionar um item novo via busca), `fCarregaItensPedidoAux` **não possuía nenhum caminho alternativo**
que preenchesse os campos de giro nesse cenário. Resultado: para os itens já existentes no pedido, ao
reabri-lo para alteração com Giro=Sim, nenhuma das rotinas de cálculo de giro era chamada — os campos
permaneciam no valor padrão (zero).

**Origem histórica do guard (via `svn blame`/`svn log`):** o guard foi introduzido em 2016
(revisão r142365, Req. 65181) para resolver um problema diferente — na época o giro só aparecia na
tela quando **Giro = Sim** estava marcado, e o objetivo era fazer o giro aparecer também quando
**Giro = Não**. A exclusão `(Not blnUsarGiro) And (Not blnAltPedGir)` presumia, implicitamente, que
quando o pedido já estivesse usando giro (`blnUsarGiro`/`blnAltPedGir = True`) o carregamento já
estaria coberto por outro trecho de código — suposição nunca verdadeira para esta função específica
(era verdadeira apenas para `fAdicionaItem`, que tem seu próprio caminho alternativo). Em 2019
(revisão r187518), quando o suporte a agrupamento por similares foi adicionado à assinatura de
`pCarrregaDadosGiro`, o guard problemático não foi corrigido em `fCarregaItensPedidoAux` — apesar de
o mesmo problema já ter sido corrigido informalmente em `fAdicionaItem` (lá, a condição equivalente
está comentada/desativada no código-fonte).

**Correção:** removida a exclusão `(Not blnUsarGiro) And (Not blnAltPedGir)`, mantendo apenas a
checagem de Multi-loja (`strPedMlj <> 'S'`), alinhando ao comportamento já em vigor (informalmente)
em `fAdicionaItem`.

Após essa correção, o log confirmou que o valor passou a ser carregado corretamente em
`cdsItensPedido` (`ITE_Q_V_01 = 16`) — mas **o valor ainda não aparecia na tela** (grade e painel
"Meses de Giro" continuavam em `0,00`), levando à investigação do segundo bug.

### 3.2. Bug 2 — critério de agrupamento por similares incorreto no cálculo usado pela tela (causa raiz do sintoma visível)

O painel "Meses de Giro" não é alimentado pela mesma rotina do Bug 1 — ele é alimentado por
`cdsItensGiroExt`, atribuído em `untMenuPedCom.pas` a partir do resultado da **mesma rotina usada no
"cálculo do zero"** (`TGiroPedido.fExecutaSQLGiroEstoque`), só que reaproveitada também durante a
alteração de um pedido (chamada com o número do pedido preenchido internamente). Instrumentação de
log direto nessa chamada mostrou que o próprio resultado do cálculo já vinha zerado para o item
`03699` — ou seja, o problema não estava na propagação do dado para a tela, e sim dentro do próprio
cálculo, especificamente no cenário de alteração de pedido.

Dentro dessa rotina de cálculo (`TGiroPedido.pCriaTabelaFiltroItem`, `untFuncoesPedido.pas`), a
tabela auxiliar em memória que determina como os itens são agrupados para a soma do giro é montada de
duas formas diferentes conforme o cenário:

- No cenário de **alteração de pedido** (itens já lançados no pedido), o agrupamento só considerava o
  item pertencente a um grupo de similares quando esse item específico estava marcado como
  **principal do grupo** (`CADITE.ITE_PRISIM = 'S'`).
- No cenário **padrão** (usado tanto para os demais itens durante a alteração quanto no "cálculo do
  zero"), o agrupamento já considerava o item como pertencente ao grupo de similares sempre que ele
  tivesse um código de grupo preenchido (`ITE_CODSIM`), **independentemente** de haver ou não um item
  marcado como principal.

Como explicado na seção 1, um grupo de similares pode legitimamente não ter nenhum item marcado como
principal (situação real confirmada para o grupo do item testado). Nesse caso, o critério usado no
cenário de alteração de pedido nunca reconhecia o agrupamento, tratando cada item do grupo como se
estivesse sozinho — e o item testado, isoladamente, não tem giro próprio registrado (só o grupo,
somado, tem giro). Por isso o valor exibido era sempre zero, mesmo com o Bug 1 já corrigido.

Esse bug só se manifestava no cenário de alteração de pedido — o cálculo "do zero" nunca passava por
esse trecho de código, e por isso continuava correto, o que inicialmente direcionou a investigação
para o lugar errado (o Bug 1, que era necessário, mas não suficiente, para resolver o sintoma).

**Correção:** o critério de agrupamento do cenário de alteração de pedido foi alinhado ao mesmo já
usado no cenário padrão — passa a agrupar pelo código do grupo de similares sempre que ele existir,
sem depender de haver um item marcado como principal. Foi corrigido, com o mesmo raciocínio, o cálculo
do item "representante" do grupo (usado internamente para outras informações do giro), que também
dependia do mesmo flag de item principal e passou a usar a função já existente no projeto para
resolver esse representante de forma robusta a grupos sem item principal marcado.

Após essa correção, validado que o painel "Meses de Giro" passou a exibir corretamente o giro somado
do grupo (`16,00` em 2026/08 para o item testado).

## 4. Alteração realizada

Foram aplicadas duas correções pontuais e independentes, replicadas nas três working copies do
projeto em manutenção:

1. Removida do carregamento de itens de um pedido já existente (`fCarregaItensPedidoAux`,
   `untPedidoCompra.pas`) a condição que impedia o cálculo de giro justamente no cenário de alteração
   de pedido com Giro=Sim — cenário mais comum de uso da tela.
2. Corrigido, no cálculo de giro reaproveitado durante a alteração de pedido (`pCriaTabelaFiltroItem`,
   `untFuncoesPedido.pas`), o critério de agrupamento por similares para não depender de um item
   estar marcado como "principal" do grupo — alinhando-o ao mesmo critério já usado e validado no
   cálculo "do zero".

Nenhuma alteração de schema de banco de dados, nenhuma alteração em transação, permissão ou
auditoria — ambas as correções são restritas à leitura/carregamento de dados de giro já existentes.

## 5. Novo funcionamento e impacto para o usuário

Ao reabrir um pedido de compra existente para alteração com Giro = Sim, os campos de giro de estoque
passam a ser carregados corretamente para os itens já lançados no pedido, tanto na grade principal
quanto no painel "Meses de Giro" — igual ao que já ocorria no cálculo "do zero". Quando a opção
"Agrupar por similares" está marcada, o valor exibido passa a ser corretamente a soma do giro de todo
o grupo de itens similares, mesmo em grupos onde nenhum item esteja cadastralmente marcado como
"principal" do grupo (situação comum após remoção de itens do grupo). Isso dá ao comprador uma
informação de giro confiável no momento de revisar/ajustar um pedido já lançado, evitando decisões de
compra baseadas em um valor zerado incorreto.

O comportamento do cálculo de giro "do zero" (fora do fluxo de alteração de pedido), o fluxo de
Multi-loja e o fluxo de adicionar um item novo ao pedido não foram alterados por esta correção — as
duas mudanças atuam exclusivamente no caminho de código específico de recarregar/agrupar itens já
existentes durante a alteração de um pedido.

## 6. Metodologia de investigação e validação

A investigação seguiu depuração sistemática com evidência em cada etapa, por se tratar de um sintoma
onde a mesma regra de negócio (giro por similares) já funcionava corretamente em outro fluxo do
mesmo módulo (o "cálculo do zero"), exigindo isolar exatamente em qual dos três caminhos paralelos de
cálculo de giro (ver seção 1) o comportamento divergia.

- **Instrumentação de log temporária** (`pLogGiroDebug`, gravando em arquivo local) foi inserida em
  pontos-chave das três rotinas de cálculo de giro (`pRetCamposGiro`, `pCarrregaDadosGiro`,
  `TfrmMenuPedCom.fCalculoGiro`) para confirmar, em runtime, em qual etapa exata o valor de giro se
  perdia — abordagem necessária porque o dado passa por múltiplas camadas de `TClientDataSet`
  intermediárias entre o cálculo e a exibição na tela, sem visibilidade direta via debugger em cada
  ponto.
- **Consulta direta ao banco de dados** (somente leitura) confirmou o estado real do flag
  `CADITE.ITE_PRISIM` para o grupo de similares do item testado, comprovando que a suposição
  implícita no código (sempre existe um item principal por grupo) era falsa na base real.
- **`svn blame`/`svn log`** foram usados para entender a origem histórica e a motivação original do
  guard do Bug 1, confirmando que a exclusão da alteração de pedido nunca teve justificativa válida
  para a função onde estava aplicada.
- A instrumentação de log foi mantida temporariamente apenas na working copy `74.150.45` (onde havia
  ambiente de aplicação rodando para validação funcional) e **removida ao final**, após confirmação
  do usuário de que a correção estava validada e correta. Nas working copies `74.150` e `74.150.100`
  a correção foi aplicada sem instrumentação, validada por leitura de código e conferência de
  `svn diff` (garantindo que apenas as linhas pretendidas foram alteradas).

## 7. Decisões de escopo

- **Não foi feita** a unificação das três implementações paralelas de cálculo de giro em uma única
  rotina — ficaria fora do escopo pontual desta correção e representa um risco de regressão maior;
  registrado como débito técnico para tratamento futuro, se decidido pela equipe.
- **Não foi alterado** o branch padrão de `pCriaTabelaFiltroItem`/`pIncluiSimilares` (usado no
  "cálculo do zero") — já validado como correto pelo usuário antes mesmo de a causa raiz ser
  encontrada; qualquer alteração ali seria fora do escopo do bug relatado.
- **Não foi feita** nenhuma alteração em `ITE_PRISIM` ou no trigger `CFG_REMSIM` — a correção
  deliberadamente deixa de depender desse flag para decidir o agrupamento, em vez de tentar corrigir
  o cadastro/trigger que o zera.

## 8. Achados colaterais (não corrigidos nesta sessão)

- As três implementações paralelas de cálculo de giro de estoque continuam existindo de forma
  independente no código (ver seção 1) — qualquer novo bug de giro precisa ser investigado
  considerando qual das três rotinas está envolvida no fluxo relatado.
- O comportamento do trigger `CFG_REMSIM` (zerar `ITE_PRISIM` de todos os itens de um grupo ao
  remover um similar) já era conhecido e está documentado separadamente em memória do projeto
  (`project_cfg_remsim_historico`); esta correção não altera esse comportamento, apenas deixa de
  depender dele incorretamente em um ponto específico do cálculo de giro.

## 9. Notas Referenciadas no Código-Fonte

### Nota 1

**Arquivo/Unit:** `untPedidoCompra.pas`
**Função:** `TfrmPedidoDeCompra.fCarregaItensPedidoAux`

No guard alterado, a condição original era:

```pascal
If (recOpcGir.strPedMlj <> 'S') And (Not blnUsarGiro) And (Not blnAltPedGir) Then
  pCarrregaDadosGiro(...);
```

A exclusão `(Not blnUsarGiro) And (Not blnAltPedGir)` foi introduzida na revisão r142365
(2016-11-11, Req. 65181) para resolver um problema diferente do que está sendo corrigido agora: na
época, o giro só aparecia na tela do pedido quando a opção **Giro = Sim** estava marcada; o pedido
original era para fazer o giro aparecer **também** quando **Giro = Não**. Para isso, a chamada a
`pCarrregaDadosGiro` foi condicionada a `Not blnUsarGiro` — ou seja, "só rode esta chamada específica
quando o usuário NÃO estiver no modo Giro=Sim", presumindo implicitamente que, quando
`blnUsarGiro = True` (ou, por extensão, quando `blnAltPedGir = True` — alteração de pedido já usando
giro), o carregamento do giro já estaria coberto por **outro** trecho de código.

Essa suposição nunca foi verdadeira para `fCarregaItensPedidoAux`. O único lugar do código que de
fato cobre esse caso é a função irmã `fAdicionaItem` (usada para adicionar item novo ao pedido via
busca), que tem um bloco próprio (cópia de `cdsItensGiro` — populado por `pRetCamposGiro` — para
`cdsItensPedido`, incluindo `ITE_Q_V_01..12`) condicionado apenas a
`(blnUsarGiro Or blnAltPedGir) And (Not (blnItemCadastrado Or blnAlterando))`. Esse bloco não existe,
e nunca existiu, em `fCarregaItensPedidoAux` — confirmado por busca em todo o corpo da função (não há
nenhuma outra referência a `cdsItensGiro` ou `pRetCamposGiro` nela).

Prova disso: em 2019 (r187518), quando o suporte a agrupamento de similares (`strCodSim`/`blnAgrSim`)
foi adicionado à assinatura de `pCarrregaDadosGiro`, o autor ajustou a chamada nas duas funções
(`fAdicionaItem` e `fCarregaItensPedidoAux`) — mas **não removeu** a exclusão de `blnAltPedGir` em
`fCarregaItensPedidoAux`, apesar de já ter percebido e corrigido informalmente o problema análogo em
`fAdicionaItem` (lá, a condição `(Not blnUsarGiro) And (Not blnAltPedGir)` está comentada/desativada
no código, restando apenas `cdsItensPedido.State = dsInsert`).

Ou seja: o bug de "giro não carrega ao alterar pedido existente com Giro=Sim" existe desde a criação
do guard em 2016, mascarado porque a combinação exata (alteração de pedido já existente + Giro=Sim +
necessidade de ver o valor de giro) raramente foi conferida a fundo — e passou a ser percebido agora
ao testar especificamente o agrupamento por similares (`chkAgrSim`), que tornou a ausência do valor
mais visível (grupo com movimento real vs. item isolado sem movimento).

**Por que manter o comentário curto no fonte:** sem essa nota, um desenvolvedor futuro pode olhar
para `If (recOpcGir.strPedMlj <> 'S') Then` e achar estranho não haver mais a checagem de
`blnUsarGiro`/`blnAltPedGir` (que existe em vários outros pontos da mesma unit) e "corrigir"
reintroduzindo a exclusão — reintroduzindo este mesmo bug.

### Nota 2

**Arquivo/Unit:** `untFuncoesPedido.pas`
**Procedure:** `TGiroPedido.pCriaTabelaFiltroItem`

No branch que semeia `FILTRO_ITEM` a partir de `PCMDET` (ativo apenas quando o pedido está em
alteração), a expressão original de `FIL_AGRUPA` era:

```sql
IF(ITE_PRISIM = "S", ITE_CODSIM, PCD_CODITE) AS FIL_AGRUPA
```

(equivalente com `ITE_SIMPRI`/`ITE_SIMCOD` na variante `SIMEMP = '2'` de `74.150`/`74.150.100`.)

Essa expressão só agrupa o item pelo código do grupo de similares (`ITE_CODSIM`) quando o próprio
item está marcado como o principal do grupo (`ITE_PRISIM = 'S'`). Isso contrasta com o branch padrão
da mesma procedure (usado tanto no cenário de alteração para os demais itens quanto no cálculo "do
zero"), que sempre usa:

```sql
IF(IFNULL(ITE_CODSIM, "") = "", C.ITE_CODITE, C.ITE_CODSIM) AS FIL_AGRUPA
```

— ou seja, agrupa por `ITE_CODSIM` sempre que o item pertence a um grupo de similares,
**independentemente** de haver ou não algum item marcado como principal.

A suposição implícita na expressão original — de que sempre existiria exatamente um item com
`ITE_PRISIM = 'S'` em cada grupo de similares — não é verdadeira neste banco. O trigger associado à
configuração `CFG_REMSIM` (ver `project_cfg_remsim_historico` na memória do projeto) pode zerar
`ITE_PRISIM` de **todos** os itens de um grupo em determinados cenários (ex.: remoção de um item do
grupo de similares). Quando isso ocorre — como no grupo `ITE_CODSIM = '031272'`, onde todos os 17
itens têm `ITE_PRISIM = 'N'` — a expressão original sempre caía no `Else` (`PCD_CODITE`), isolando
cada item do pedido em seu próprio "agrupamento" de uma única linha em `FILTRO_ITEM`, em vez de
agrupá-lo com os demais itens do grupo de similares. Como consequência, o `GROUP BY FIL_AGRUPA` da
query de agregação de giro (`fExecutaSQLGiroEstoque`) somava o giro de cada item **isoladamente**,
ignorando o giro dos demais similares — e itens sem saída própria na `GIRITE` (mas com saída via
outros itens do mesmo grupo) apareciam com giro zero, mesmo quando o giro do grupo, corretamente
somado, não era zero.

Este bug só se manifesta no branch de alteração (semeadura via `PCMDET`), porque é o único ponto do
código que usava esse critério diferente do padrão. O cálculo "giro do zero" (sem número de pedido em
alteração) nunca passa por este branch — daí ter sido validado como correto pelo usuário antes de a
causa real ser encontrada, o que inicialmente direcionou a investigação para o lugar errado (o guard
do Bug 1, que era necessário mas não suficiente).

A correção alinha o critério ao mesmo já usado no branch padrão, e também corrige `FIL_CODPRI` (que
tinha o mesmo problema de raiz — usava `PCD_CODITE` diretamente em vez de `fSQLCodItemPrincipal`, a
função já estabelecida no projeto para resolver o item principal de um grupo de similares de forma
robusta a essa mesma situação de "grupo sem item marcado como principal").

**Por que manter o comentário curto no fonte:** a expressão condicionada a `ITE_PRISIM = 'S'` parece,
à primeira vista, mais "correta" ou mais específica que o critério padrão
(`IFNULL(ITE_CODSIM, "") = ""`) — um desenvolvedor futuro que não conheça o comportamento do trigger
`CFG_REMSIM` pode achar que a versão nova está "simplificando demais" e reintroduzir a checagem de
`ITE_PRISIM`, reintroduzindo este mesmo bug para qualquer grupo de similares sem item principal
marcado.

## 10. Arquivos alterados (referência rápida)

| Working copy | Arquivo | Alteração |
|---|---|---|
| `74.150.45` | `untPedidoCompra.pas` | Bug 1 — guard em `fCarregaItensPedidoAux` |
| `74.150.45` | `untFuncoesPedido.pas` | Bug 2 — `FIL_AGRUPA`/`FIL_CODPRI` em `pCriaTabelaFiltroItem` (sem `SIMEMP`) |
| `74.150` | `untPedidoCompra.pas` | Bug 1 — mesmo ajuste |
| `74.150` | `untFuncoesPedido.pas` | Bug 2 — mesmo ajuste, variante `SIMEMP` (dois sub-branches) |
| `74.150.100` | `untPedidoCompra.pas` | Bug 1 — mesmo ajuste |
| `74.150.100` | `untFuncoesPedido.pas` | Bug 2 — mesmo ajuste, variante `SIMEMP` (dois sub-branches) |

Instrumentação de log temporária (`pLogGiroDebug`), inserida apenas em `74.150.45` durante a
investigação (`untFuncoesPedidoSimples.pas`, `untMenuPedCom.pas`, `untPedidoCompra.pas`), foi
integralmente removida ao final da sessão, após validação funcional confirmada pelo usuário. As
working copies `74.150` e `74.150.100` nunca receberam essa instrumentação.

## 11. Referências

- `IA\specs\462720\spec.md`, `plan.md`, `tasks.md` — artefatos de especificação e plano de execução
  gerados durante a implementação (skill `citel-IAArquitectDesenv`).
- Memória do projeto: `project_cfg_remsim_historico.md` — histórico do trigger `CFG_REMSIM` e seu
  efeito sobre `ITE_PRISIM`.
