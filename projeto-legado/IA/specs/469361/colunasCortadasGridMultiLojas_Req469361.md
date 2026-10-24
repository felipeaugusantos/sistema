# REQ 469361 — Colunas cortadas no grid da tela de digitação multi-lojas (EntDigMultiLojasNovo)

> Escopo ampliado durante a sessão com dois ajustes correlatos na mesma tela (seções 4.1 e 4.2).

## 1. Contexto do problema

Na tela **frmEntDigMultiLojasNovo** (unit `untEntDigMultiLojasNovo.pas`, digitação de pedido de compra/giro multi-lojas),
o grid `cxgItensView` (`TcxGridDBBandedTableView`) possui duas bandas e cerca de 130 colunas (52 a 82 visíveis, conforme
configuração/cotação/giro):

| Banda | Caption | FixedKind | Conteúdo |
|-------|---------|-----------|----------|
| 0 | Empresa | `fkLeft` (fixa à esquerda) | Código, Nome, Nome Fantasia, C/I, Sigla Emp. |
| 1 | Informações do Item | — | Meses de giro, médias, sugestão, saldos, datas, etc. (todas em uma única linha, RowIndex 0) |

Relato do usuário: mesmo com barra de rolagem horizontal, ao rolar até o fim **as últimas colunas não eram exibidas**
(na captura, a última coluna visível era "01/2026", com a seguinte cortada na borda). O usuário apontou que o limite
parecia ser o tamanho da tela, não a quantidade de colunas.

## 2. Jornada de investigação

### 2.1 Leitura estática (sem resultado conclusivo)

- O `.dfm` não limita largura: `OptionsView.ColumnAutoWidth` é `False` (padrão) e as colunas têm
  `Options.AutoWidthSizable = False`. Nenhuma banda tem `Width` definido no `.dfm`.
- `cxgItensViewColumnSizeChanged` tem o ajuste de largura de banda **comentado** (`fGetWidthBand`), e `fGetWidthBand` não
  é chamada em nenhum lugar.
- `FormShow` e `pAjustaConfigs` (unit `untCdsDigMultLoja.pas`) alternam a visibilidade de dezenas de colunas e da banda 0
  depois que o grid já calculou o layout. Hipótese inicial: rolagem horizontal com alcance desatualizado. Não foi possível
  confirmar sem executar.
- Foi considerado chamar `LayoutChanged` no fim do `FormShow`; **descartado** porque o método não é usado em nenhum outro
  ponto do projeto e não havia como compilar para validar a existência na versão do DevExpress em uso.

### 2.2 Log de diagnóstico local

Foi criado temporariamente `pGravaLogColunas` (gravando em `C:\Users\danilo.stefaneli\Desktop\temp\
LogColunas_EntDigMultiLojasNovo.txt`), chamado no fim do `FormShow` e no `FormResize`, registrando: dimensões do form,
`Parent`, largura do grid/`Site`, `LeftPos`, e por banda a `Width` e a soma das larguras das colunas visíveis, além da
versão/data do executável (necessário para saber que log pertencia a qual build; o `ProductVersion` do exe de
desenvolvimento é sempre `999.999.999.999`, então a "Data exe" é que distingue os builds).

Resultado do log com a tela **ancorada no painel** (cenário do problema):

| Banda | `Width` gravado | Soma das colunas visíveis |
|-------|-----------------|---------------------------|
| 0 — Empresa | 408 | 453 (falta a coluna `ViewSIGEMP`, 60 px) |
| 1 — Informações do Item | 3187 | 4221 |

Largura de tela/grid não era o limite (tela 1920, grid 1918). A banda 1 tinha 1034 px a menos que suas colunas, o que
corresponde a ~8-9 colunas finais inacessíveis. O valor 408 = 393 (43+140+140+70) + 15, ou seja, foi calculado numa
situação em que a coluna `ViewSIGEMP` ainda não estava visível.

Na primeira abertura (sem configuração salva restaurada) as bandas apareciam com `Width = 0` (automática) e a rolagem
alcançava o fim.

## 3. Causa raiz

A configuração do grid é salva por operador na tabela `CFGPDC` (`StoreToIniFile`, `untCdsDigMultLoja.pas`) e restaurada
com `cxgItensView.RestoreFromIniFile` ao abrir a tela. O ini armazena a **largura de cada banda**. Ao restaurar, a banda
deixa de ser automática (`Width = 0`) e passa a ter largura fixa igual à do momento em que foi salva.

Depois da restauração, o próprio `FormShow` (`fGetVisibleArrCamposCfg`, Visible das colunas de giro/orçamento/compra,
`ViewSIGEMP`, etc.) e o `TCdsDigMultLoja.pAjustaConfigs` (visibilidade da banda 0 e de colunas conforme `strPedMlj`,
cotação, embalagem, entrega futura...) mudam quais colunas estão visíveis. A largura fixa da banda não acompanha essa
mudança; o alcance da barra de rolagem horizontal é calculado a partir da largura da banda, então as colunas além dela
ficam inacessíveis.

Observação: `TGridConfigManagerDB.ApplyConfigSmart` (`untTGridConfigManagerDB.pas`) também aplica `Band.Width`, mas **não é
usado por esta tela**; a origem aqui é o `RestoreFromIniFile`.

## 4. Correção aplicada

Novo método `TfrmEntDigMultiLojasNovo.pAutoLarguraBandas` (público), que percorre `cxgItensView.Bands` e atribui
`Width := 0` (largura automática, convenção já usada em outros pontos do projeto, ex.: `untAltGlobCadClientes`).

Chamadas:

1. No fim de `TfrmEntDigMultiLojasNovo.FormShow`, depois de todas as alterações de visibilidade de colunas.
2. No fim de `TCdsDigMultLoja.pAjustaConfigs` (`untCdsDigMultLoja.pas`), que também é executado após a restauração
   (inclusive em `pRestauraPadrao`).

As duas chamadas são necessárias porque os dois pontos alteram colunas visíveis depois da restauração do ini e a ordem
entre eles varia conforme o fluxo (tela ancorada x janela, restaurar padrão).

Comentário no fonte (curto) + referência: `Verificar Nota 1 - Req. 469361` (ver seção 6).

## 4.1 Restaurar padrão do grid (btnFuncoes)

Fora do escopo original, pedido durante a sessão. A revisão **r376938** (Req. 337789, laercio, 04/07/2024) trocou os labels
do painel inferior (`lblResPad`, `lblSalbas`, `lblConfiguraColunas`, `lblListaMesesGiro`) por um popup no botão `btnFuncoes`
(`popFuncoes`). Os itens Análise de promoção, Configura Colunas, Demonstrativo Saldo Base Compra e Giro de Estoque
Analítico ganharam menu; o `lblResPadClick` foi convertido em `pRestaurarPadrao` e **comentado**, sem item de menu. Com isso
a funcionalidade "Restaurar padrão" deixou de existir na tela. Os métodos de apoio continuaram intactos:
`TCfgGrid.pResetaConfiguracao` (apaga `CFGGRI` do operador) e `TCdsDigMultLoja.pRestauraPadrao` (apaga `CFGPDC` do
operador, fecha/recria e ancora o form, executa `pAjustaConfigs`).

Alterações em `untEntDigMultiLojasNovo.pas` e `.dfm`:

- `pRestaurarPadrao` descomentada (declaração privada e implementação, com o mesmo corpo original).
- Novo item `mnuRestaurarPadrao` ("Restaurar Padrão") no `popFuncoes`, handler `mnuRestaurarPadraoClick`.
- Confirmação antes de executar (`fMensagem('Atenção', 'Deseja restaurar o padrão do grid? ...', ['&Sim', '&Não']) = 1`),
  porque a ação apaga o layout salvo do operador e o label original não perguntava.
- Visibilidade: o item fica sempre visível, no pedido de compra e na cotação. A tela é compartilhada pelas duas rotinas
  (`blnCotacao` é atribuído por `TCdsDigMultLoja.pCriaDigMultiLojas` a partir de `FCotacao`) e a opção vale para as duas.
  Decisão: inicialmente o item era ocultado na cotação (`mnuRestaurarPadrao.Visible := Not blnCotacao` no `FormShow`); essa
  restrição foi descartada a pedido do usuário e a linha foi removida.

Empresas de cálculo após restaurar (achado de revisão): `strEmpCalc` só era atribuído no construtor; o form recriado ficava
sem ele e o rodapé/destaque por empresa de cálculo deixava de valer (Nota 3). A atribuição foi para `pCriaDigMultiLojas`.
O `OnValidate` de `cxgItensQTDITE` não foi alterado: o `.dfm` já liga o handler do form.

Limites conhecidos (aceitos, risco baixo): (a) `TCfgGrid.pResetaConfiguracao` apaga `CFGGRI` pela chave única
`'Digitação de quantidade multiloja'`, compartilhada pelos dois modos; o "Configura Colunas" do outro modo também é
restaurado, enquanto `CFGPDC` é preservado por modo. (b) o filtro de coluna sem título (4.2), junto com `fSalva`, apaga os
registros dessas colunas em `CFGGRI` (`EXISTE = 0`); nada muda no que aparece no grid, pois `pTiraBandaSemColunas` já as
escondia. Sugestão: confirmar que nenhuma tela depende da visibilidade salva de uma coluna sem título.

Layout do outro modo (achado de revisão): `pApagaConfiguracoes` fazia `DELETE FROM CFGPDC WHERE CFG_CODOPE = :CODOPE`, sem
filtrar `CFG_NOMGRI`, enquanto salvar e carregar separam a linha `TELMUL` da linha vazia. Restaurar o padrão num modo
apagava também o layout do outro. O DELETE passa a usar o mesmo filtro (`IFNULL(CFG_NOMGRI, "")` = `"TELMUL"` ou `""`,
conforme `fCfgSis('TELMUL')` e `FOpcGir.strPedMlj <> 'S'`) e a query ganhou `try/finally`.

Vazamento do form anterior (achado de revisão): com a tela ancorada, `pRestauraPadrao` recriava o form sem liberar o antigo.
Corrigido com `Release` adiado em `TCdsDigMultLoja.pRestauraPadrao` (ver Nota 2, seção 6). Alternativa descartada:
`pFreeAndNil` antes de `pCriaDigMultiLojas`, pois a chamada vem do clique do próprio form e o `pFreeAndNil` ainda processa
mensagens; liberar na hora destruiria o objeto durante o seu evento.

## 4.2 Colunas sem título na janela "Configura Colunas"

Achado colateral: ao abrir "Configura Colunas" (`mnuConfiguraColunasClick`, `TCfgGrid.pConfiguraColunas`) apareciam linhas
em branco na lista, entre as colunas de meses e "Total Vendas". A lista é montada em `TCfgGrid.pAjustaColunas`
(`untCfgGrid.pas`). No ramo de operação nova (`FOperacaoNova = True`) já havia o filtro `Caption <> ''`; no ramo de
configuração existente (`FOperacaoNova = False`) não havia, e colunas com `Caption` e `AlternateCaption` vazios eram
listadas.

Correção: nesse ramo a coluna só é incluída se `Caption` ou `AlternateCaption` não for vazio (`fEmptyStr`). Impacto além
desta tela: o `TCfgGrid` é usado por várias units (26 com `TCfgGrid.Create`); a mudança vale para todo grid em banda que
passe por esse ramo. Coluna sem título não é identificável pelo operador na lista, e `pTiraBandaSemColunas` já trata esse
caso como "sem coluna".

## 5. Validação

- Log gerado pelo build com a correção (identificado pela linha `Versao do log: v2` e pela data do exe): bandas passaram a
  ficar com `Width = 0` em todos os registros e a rolagem horizontal passou a exibir todas as colunas — confirmado pelo
  usuário ("agora ficou visível todas").
- O log de diagnóstico (`pGravaLogColunas`) foi removido das units após a validação; permaneceu apenas a correção.
- Restaurar padrão (4.1) e lista de Configura Colunas sem linhas em branco (4.2): testados e validados pelo usuário na
  74.150.45.

## 6. Notas referenciadas no código-fonte

### Nota 1

Unit `untEntDigMultiLojasNovo.pas`, procedure `TfrmEntDigMultiLojasNovo.pAutoLarguraBandas`.

O grid `cxgItensView` tem o layout salvo por operador em `CFGPDC` (`StoreToIniFile`) e restaurado em
`RestoreFromIniFile`. O ini guarda `Band.Width`; ao restaurar, uma banda que estava automática (`Width = 0`) passa a ter
largura fixa igual à largura calculada no momento do salvamento. Após a restauração, `FormShow` e `pAjustaConfigs`
mostram/escondem colunas (e a banda 0 inteira) conforme configuração do sistema, giro, cotação, embalagem, entrega futura
e opções do operador. Como a largura da banda ficou fixa, a soma das colunas visíveis passa a ser maior que a banda
(medido: banda 1 = 3187 contra 4221 de colunas; banda 0 = 408 contra 453) e a barra de rolagem horizontal, que usa a
largura da banda, não alcança as últimas colunas. Atribuir `Width := 0` devolve às bandas a largura automática, que
acompanha as colunas visíveis. A chamada é feita nos dois pontos que alteram a visibilidade após a restauração
(`FormShow` e `pAjustaConfigs`); remover uma delas reintroduz o problema conforme o fluxo de abertura. A atribuição é
idempotente (banda já automática permanece em 0). Esta procedure parece redundante/"limpável" mas não é.

### Nota 2

Unit `untCdsDigMultLoja.pas`, procedure `TCdsDigMultLoja.pRestauraPadrao` (ramo `blnAncorado`).

Com a tela ancorada, `pRestauraPadrao` chamava `Close` (que apenas esconde o form) e depois `pCriaDigMultiLojas`, que
executa `Application.CreateForm` de novo sobre a variável global `frmEntDigMultiLojasNovo`. A instância anterior nunca era
liberada: o conflito de nome era tratado em `pCriarFormularios` (Req. 455181, `fLiberaNomeComponenteDuplicado`), que apenas
renomeia o componente antigo (por isso aparecia um `frmEntDigMultiLojasNovo_1`). O form antigo ficava vivo e escondido,
pertencendo ao `Application`, com o grid ainda ligado ao dataset compartilhado. A cada "Restaurar Padrão" mais um form
completo (grid DevExpress e componentes) ficava preso na memória; ao encerrar, esse form era destruído depois do
`TCdsDigMultLoja`, com risco de Access Violation se algum evento tocasse em `cdsDigMultLoja`. Esse caminho estava
inacessível desde a r376938 e voltou a ser acessível com o menu "Restaurar Padrão" (item 4.1).

A referência da instância anterior é guardada em `frmAnterior` antes de recriar, e `frmAnterior.Release` é chamado depois de
a nova instância estar criada e ancorada. `Release` (e não `Free`/`pFreeAndNil`) é obrigatório: a chamada vem do clique do
menu do próprio form, e liberar na hora destruiria o objeto durante o seu próprio evento (o `pFreeAndNil` ainda processa
mensagens). `Release` posta `CM_RELEASE`, e a destruição ocorre depois que o handler terminou. No ramo em janela
(`FRestaurando`) nada muda: o form já é liberado por `pFreeAndNil` em `fDigQuantidadeMultilojaAux` depois do `ShowModal`.

### Nota 3

Unit `untCdsDigMultLoja.pas`, procedure `TCdsDigMultLoja.pCriaDigMultiLojas`.

NOTA 3 - strEmpCalc (empresas de cálculo, de recOpcGirP.strEmpCal) era atribuído ao form somente no construtor de
TCdsDigMultLoja, depois de pCriaDigMultiLojas. Quando o form é recriado (Restaurar Padrão ancorado, Restaurar Padrão em
janela via fDigQuantidadeMultilojaAux, ou criação tardia), a nova instância ficava com strEmpCalc vazio. Com strEmpCalc
vazio, os testes If (strEmpCalc <> '') do form (rodapé do grid em cxgItensViewDataControllerSummaryFooterSummaryItemsSummary
e os CustomDraw de cxgItensCODEMP, cxgItensNOMEMP e cxgItensFANEMP) deixam de excluir/destacar as empresas fora do cálculo:
o rodapé somava todas as lojas e o total mudava sem aviso. A atribuição foi movida para pCriaDigMultiLojas (a partir de
FOpcGir.strEmpCal, que já guarda recOpcGirP desde o construtor), único ponto comum aos três caminhos de criação do form. A
linha equivalente do construtor foi removida por ficar redundante.

## 7. Cópias alteradas

| Working copy | Arquivos |
|--------------|----------|
| 74.150.45 | `untEntDigMultiLojasNovo.pas`, `untEntDigMultiLojasNovo.dfm`, `untCdsDigMultLoja.pas`, `untCfgGrid.pas` |
| 74.150 | `untEntDigMultiLojasNovo.pas`, `untEntDigMultiLojasNovo.dfm`, `untCdsDigMultLoja.pas`, `untCfgGrid.pas` |
| 74.150.100 | `untEntDigMultiLojasNovo.pas`, `untEntDigMultiLojasNovo.dfm`, `untCdsDigMultLoja.pas`, `untCfgGrid.pas` |

Caminhos: `padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/` (form e `untCdsDigMultLoja.pas`) e
`padra_atualizado/fontes/genericos/` (`untCfgGrid.pas`). As três cópias receberam o mesmo conjunto de alterações (conferido
por `svn diff`: hash idêntico das linhas alteradas no `.pas`, `.dfm` e `untCfgGrid.pas`, sem ruído de EOL/encoding). A
correção das bandas (seção 4) e os itens 4.1 e 4.2 foram validados na 74.150.45; compilação e teste nas cópias 74.150 e
74.150.100 ficam a cargo do usuário.

## 8. Ressalvas e lições de processo

- Os fontes são cp1252/CRLF; todas as edições foram feitas via Python com o encoding explícito (nunca com `Edit`) e
  verificadas contra a sequência `\xef\xbf\xbd`. Texto inserido por string Python precisa usar `\r\n` explícito: um
  bloco inserido com `\n` gerou fim de linha LF dentro de arquivo CRLF e foi corrigido.
- O `ProductVersion` do `autcom.exe` de desenvolvimento é `999.999.999.999`: para saber se um log pertence ao build
  corrigido, usar a data do executável ou uma linha fixa de versão no próprio log. Um primeiro log analisado era do build
  antigo (exe de 10:15, sem a correção) e não teve valor para validar.
- Operadores que já tinham configuração salva em `CFGPDC` com banda fixa continuam com o valor gravado no banco, mas a
  correção reseta a largura em runtime a cada abertura; não é necessário apagar `CFGPDC`.

## 9. Texto de análise de requisito (registro formal)

```text
Foi corrigida a exibição das colunas na tela de digitação de pedidos de compra multi-lojas (EntDigMultiLojasNovo). Em algumas
situações, mesmo com a barra de rolagem horizontal, as últimas colunas do grid não podiam ser acessadas.

O problema ocorria quando o operador já possuía um layout do grid salvo. Ao abrir a tela, o layout salvo era restaurado e as
bandas do grid passavam a ter largura fixa. Em seguida, o sistema mostrava ou escondia colunas conforme as configurações da
tela, e a largura fixa da banda não acompanhava essa mudança. A rolagem horizontal considerava a largura antiga e deixava
de alcançar parte das colunas.

Foi ajustado o tratamento da largura das bandas: após as alterações de visibilidade das colunas, a largura das bandas volta
a ser automática, acompanhando as colunas visíveis.

Com a alteração, a barra de rolagem horizontal passa a exibir todas as colunas da tela, sem perder o layout de colunas
salvo pelo operador.

Na mesma tela, a opção "Restaurar Padrão" do grid voltou a ficar disponível, agora no menu do botão de funções, tanto na
digitação de pedido de compra quanto na cotação (a tela é compartilhada). A opção solicita confirmação antes de apagar o
layout salvo pelo operador.

Na restauração do padrão com a tela ancorada, o formulário anterior passa a ser liberado da memória ao recriar a tela, em
vez de permanecer escondido a cada restauração.

A restauração do padrão passa a apagar somente o layout da tela (CFGPDC) do modo em uso (pedido multiloja ou tela multi-lojas
da cotação), preservando o layout da tela do outro modo. A configuração do "Configura Colunas" é única para os dois modos e é
restaurada para ambos.

Após restaurar o padrão, a tela recriada mantém as empresas de cálculo (rodapé e destaque das empresas fora do cálculo).

Também foi ajustada a janela "Configura Colunas": colunas sem título deixam de ser listadas, eliminando as linhas em branco
que apareciam na relação.

NOTAS NO FONTE:
  NOTA 1 - O grid cxgItensView tem o layout salvo por operador na tabela CFGPDC (StoreToIniFile, em untCdsDigMultLoja.pas)
  e restaurado por RestoreFromIniFile. O ini guarda a largura de cada banda (Band.Width). Ao restaurar, uma banda que estava
  automática (Width = 0) passa a ter largura fixa, igual à calculada no momento em que o layout foi salvo. Depois da
  restauração, FormShow (untEntDigMultiLojasNovo.pas) e TCdsDigMultLoja.pAjustaConfigs (untCdsDigMultLoja.pas) mostram ou
  escondem colunas, e até a banda 0 inteira, conforme configuração do sistema, giro, cotação, embalagem, entrega futura e
  opções do operador. Como a largura da banda ficou fixa, a soma das colunas visíveis passa a ser maior que a banda
  (medido em log: banda 1 = 3187 contra 4221 de colunas; banda 0 = 408 contra 453) e a barra de rolagem horizontal, que usa
  a largura da banda, não alcança as últimas colunas. Atribuir Width := 0 devolve às bandas a largura automática, que
  acompanha as colunas visíveis. A chamada é feita nos dois pontos que alteram a visibilidade depois da restauração
  (FormShow e pAjustaConfigs); remover uma delas reintroduz o problema conforme o fluxo de abertura da tela. A atribuição é
  idempotente (banda já automática permanece em 0). O método parece redundante, mas não é: não deve ser removido.

  NOTA 2 - TCdsDigMultLoja.pRestauraPadrao, com a tela ancorada, chamava Close (que apenas esconde o form) e depois
  pCriaDigMultiLojas, que executa Application.CreateForm de novo sobre a variável global frmEntDigMultiLojasNovo. A instância
  anterior nunca era liberada: o conflito de nome era tratado em pCriarFormularios (Req. 455181), que apenas renomeia o
  componente antigo. O form antigo ficava vivo e escondido, pertencendo ao Application, com o grid ainda ligado ao dataset
  compartilhado, e a cada "Restaurar Padrão" mais um form completo (grid DevExpress e componentes) ficava preso na memória. Ao
  encerrar, esse form era destruído depois do TCdsDigMultLoja, com risco de Access Violation se algum evento tocasse em
  cdsDigMultLoja. A referência da instância anterior é guardada em frmAnterior antes de recriar, e frmAnterior.Release é
  chamado depois de a nova instância estar criada e ancorada. Release (e não Free/pFreeAndNil) é obrigatório: a chamada vem do
  clique do menu do próprio form, e liberar na hora destruiria o objeto durante o seu próprio evento (o pFreeAndNil ainda
  processa mensagens). Release posta CM_RELEASE e a destruição ocorre depois que o handler terminou. No ramo em janela
  (FRestaurando) nada muda: o form já é liberado por pFreeAndNil em fDigQuantidadeMultilojaAux depois do ShowModal.

  NOTA 3 - strEmpCalc (empresas de cálculo, de recOpcGirP.strEmpCal) era atribuído ao form somente no construtor de
  TCdsDigMultLoja, depois de pCriaDigMultiLojas. Quando o form é recriado (Restaurar Padrão ancorado, Restaurar Padrão em
  janela via fDigQuantidadeMultilojaAux, ou criação tardia), a nova instância ficava com strEmpCalc vazio. Com strEmpCalc
  vazio, os testes If (strEmpCalc <> '') do form (rodapé do grid em cxgItensViewDataControllerSummaryFooterSummaryItemsSummary
  e os CustomDraw de cxgItensCODEMP, cxgItensNOMEMP e cxgItensFANEMP) deixam de excluir/destacar as empresas fora do cálculo:
  o rodapé somava todas as lojas e o total mudava sem aviso. A atribuição foi movida para pCriaDigMultiLojas (a partir de
  FOpcGir.strEmpCal, que já guarda recOpcGirP desde o construtor), único ponto comum aos três caminhos de criação do form. A
  linha equivalente do construtor foi removida por ficar redundante.

CONTEXTO TÉCNICO (IA):
- ARQUIVOS: padra_atualizado/fontes/movimentacaoitens/PedidoDeCompra/untEntDigMultiLojasNovo.pas (.pas e .dfm),
  untCdsDigMultLoja.pas e padra_atualizado/fontes/genericos/untCfgGrid.pas.
- ALTERAÇÃO 1: novo método público TfrmEntDigMultiLojasNovo.pAutoLarguraBandas, declarado após fGetWidthBand e implementado
  antes de fLocalizaPosArray. Percorre cxgItensView.Bands e faz Bands[i].Width := 0.
- ALTERAÇÃO 2: chamada pAutoLarguraBandas no fim de TfrmEntDigMultiLojasNovo.FormShow, após o último Visible := ... de
  coluna (cxgItensQtdCross) e antes do inherited.
- ALTERAÇÃO 3: chamada frmEntDigMultiLojasNovo.pAutoLarguraBandas no fim de TCdsDigMultLoja.pAjustaConfigs, após o bloco
  With frmEntDigMultiLojasNovo.
- ALTERAÇÃO 4: reativada TfrmEntDigMultiLojasNovo.pRestaurarPadrao (declaração privada e implementação estavam comentadas
  pela r376938, Req. 337789, que moveu os labels do painel para o popFuncoes e não criou item para restaurar o padrão).
  Corpo original: TCfgGrid.pResetaConfiguracao(strLoginUsuarioLogado, 'Digitação de quantidade multiloja'), que apaga o
  registro do operador em CFGGRI, e TCdsDigMultLoja.pRestauraPadrao, que apaga CFGPDC do operador, recria/ancora o form e
  executa pAjustaConfigs. Ambos já existiam; os ajustes feitos em
  TCdsDigMultLoja estão nas ALTERAÇÕES 7 e 8.
- ALTERAÇÃO 5: novo item mnuRestaurarPadrao no popFuncoes (.dfm, acionado por btnFuncoes), com handler
  mnuRestaurarPadraoClick: fMensagem de confirmação (Sim/Não) e, só se Sim, pRestaurarPadrao. O item fica sempre visível (sem
  teste de blnCotacao): a tela é compartilhada com a rotina de cotação e a opção vale para pedido de compra e cotação.
- ALTERAÇÃO 6: TCfgGrid.pAjustaColunas (untCfgGrid.pas), ramo FcxbItens com FOperacaoNova = False: a coluna só é listada
  se Caption ou AlternateCaption não for vazio. O ramo FOperacaoNova = True já filtrava Caption <> ''; o filtro passa a ser
  consistente nos dois. As linhas em branco da janela de Configura Colunas eram colunas sem título. O TCfgGrid é usado por
  várias telas: a mudança vale para todo grid em banda que passe por esse ramo.
- ALTERAÇÃO 7: TCdsDigMultLoja.pRestauraPadrao (untCdsDigMultLoja.pas), ramo blnAncorado: variável local frmAnterior guarda a
  instância atual de frmEntDigMultiLojasNovo antes de pCriaDigMultiLojas e, depois de pAncora, chama frmAnterior.Release.
  Antes a instância antiga ficava viva e escondida (pCriarFormularios só renomeia o componente duplicado, Req. 455181).
  Release adia a destruição porque a chamada nasce de evento do próprio form (menu do btnFuncoes).
- ALTERAÇÃO 8: TCdsDigMultLoja.pApagaConfiguracoes (untCdsDigMultLoja.pas): o DELETE em CFGPDC passa a filtrar
  IFNULL(CFG_NOMGRI, "") = "TELMUL" ou = "" com a mesma condição de pSalvaConfiguracoes/pCarregaConfiguracoes
  (fCfgSis('TELMUL') e FOpcGir.strPedMlj <> 'S'); antes apagava todas as linhas do operador. A query agora é liberada em
  try/finally.
- ALTERAÇÃO 9: TCdsDigMultLoja.pCriaDigMultiLojas passa a fazer frmEntDigMultiLojasNovo.strEmpCalc := FOpcGir.strEmpCal
  (antes só o construtor atribuía recOpcGirP.strEmpCal, logo após pCriaDigMultiLojas, e essa linha foi removida). Efeito
  colateral: o caminho de criação tardia de fDigQuantidadeMultilojaAux (form ainda não criado) também passa a receber
  strEmpCalc. OnValidate de cxgItensQTDITE não precisou de ajuste: o .dfm já liga o handler do próprio form
  (cxgItensQTDITEPropertiesValidate), então todo form novo já nasce com a validação.
- Banda 0 = "Empresa" (FixedKind = fkLeft); banda 1 = "Informações do Item", com quase todas as colunas em uma linha.
- Width = 0 em TcxGridBand significa largura automática (convenção já usada em outras telas, ex.: untAltGlobCadClientes).
- O layout é restaurado por RestoreFromIniFile (untCdsDigMultLoja.pas), não por TGridConfigManagerDB (não usado nesta tela).
- cxgItensViewColumnSizeChanged tem o ajuste de largura de banda comentado e fGetWidthBand não é chamada em lugar nenhum:
  não foi reativado, pois a solução correta é a largura automática, não um cálculo manual.
- LayoutChanged foi descartado: não é usado no projeto e não havia como validar a API na versão do DevExpress.
- Identificadores sem número de requisito, no padrão da unit (p para procedure, int para variável local).
```
