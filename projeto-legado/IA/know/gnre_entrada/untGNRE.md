# untGNRE

## Responsabilidade

Modelo e gravação das guias de uma nota de entrada: `TGNRE` representa uma guia (GNRE/GARE, TCIF ou
TS) com os itens que ela cobre; `TListGNRE` gerencia as guias de uma nota **já gravada** e recalcula
custo e preço dos itens depois que elas mudam.

## Caminho

`padra_atualizado/fontes/movimentacaoitens/untGNRE.pas` — encoding cp1252 (latin-1), 4.844 linhas.

Existe outra unit com o mesmo nome em `padra_atualizado/fontes/Util_DLL/Gnre/untGNRE.pas` (DLL
`libGNRE`). São códigos diferentes; conferir o caminho antes de editar.

## Comportamento

**`TGNRE` (uma guia)** é um `TComponent`. O tipo (`TipoChamada`) define a tabela e o campo de valor
do item:

| Tipo | `FTabela` | `FCampoValor` | `GNR_ORIGEM` |
|------|-----------|---------------|--------------|
| `tcGnreST` | `CADGNR` | `ENT_VALGNR` | `S` |
| `tcGnreTributado` | `CADGNR` | `ENT_VALGNR` | `T` |
| `tcGnrePadrao` | `CADGNR` | `ENT_VALGNR` | `P` |
| `tcTCIF` | `GNRTCI` | `ENT_VLTCIF` (calculado: `ENT_CLTCIF`) | — |
| `tcTS` | `GNR_TS` | `ENT_VAL_TS` | — |

Usada de dois jeitos:

- **Durante a entrada** (resumo): os itens vêm de `TMP_ENTMER` (`fVerificaItens`/`fSQLItens`). A tela
  grava o valor por item em `TMP_ENTMER` (`fAtualizaValorGnre`) e, na confirmação da entrada,
  `fGravaGnre` grava a guia, ajustes e contas a pagar. Não abre transação própria — roda dentro da
  cadeia de gravação do resumo. A confirmar: a transação que envolve essa cadeia.
- **Após a entrada**: criada por `TListGNRE`, que lhe entrega os itens de `MOVDET`/`MOVTRI`.

Os *setters* das propriedades validam e **lançam exceção** (`setValGnr` ≤ 0, `setEstFav` vazio,
`setCodFor` inexistente, `setCodCta` inativo/linha-grupo, `setBasCal` ≤ 0, IE inválida, datas
inválidas). `setCodFor` também carrega nome, UF e IE do fornecedor e o portador do fornecedor.

**`TListGNRE`** (`TObjectList` de `TGNRE`) abre as guias gravadas da nota (`GNR_AUTFIS`) num
`TZClient` (`FqryDados`/`dtsDados`), carrega os itens gravados da nota, abre `TfrmEntGNRE` para
incluir/alterar, e grava tudo **numa transação** (`fGravaGnreInterna`).

### Conjuntos de itens ST × Tributada (`CFG_GNRTEM`)

`TListGNRE` mantém dois `TZClient` de itens: `FItensLisST` e `FItensLisTri`. `FItensLis` aponta para o
conjunto ativo (`fItensDoTipo`): com `CFG_GNRTEM` e tipo `tcGnreTributado`, o tributado; em todos os
outros casos, o ST. Sem `CFG_GNRTEM` só existe o conjunto ST, como antes da separação.

Os dois conjuntos são diferentes porque `fSQLCarregaItens` filtra `ABFICM` por `:SUBSTI` (ST/Padrão)
ou `:TRIBUT2` (Tributada).

Guia **nova** de GNRE recebe **cópia própria** dos itens (`pCopiaItensNovaGnre`). Se o conjunto já
tem guia gravada, a cópia nasce com `ENT_VALGNR = 0` e `ENT_CALGNR` vazio. Motivo: a tela valida a
soma dos itens contra o valor de **uma** guia; com itens compartilhados, a guia nova sobrescrevia o
valor das gravadas. Guia **gravada** usa o conjunto compartilhado, filtrado por `ORIGEM`.

Na gravação, `fGravaValoresItens` passa por cada conjunto que teve movimento (`fTemMovimentoItens`:
guia nova ou guia gravada editada) e, para cada um, `fConsolidaValorNovasGnre` remonta o valor do item
= base + parcela de cada guia nova; depois `fAtualizaValorTodosGNRE` regrava `MOVTRI` e o custo.

| Situação do conjunto | Base do item |
|----------------------|--------------|
| Guia gravada editada nesta tela | `ENT_VALGNR` do conjunto (valor deixado pela edição) |
| Guia gravada sem edição | `DET_VLGNRE` (gravado em `MOVTRI`) — não `ENT_VALGNR`, que com NF-e traz a prévia do XML |
| Sem guia gravada | `0` |

A memória de cálculo (`ENT_CALGNR`) só é mantida quando **uma única guia nova** compõe o valor e não
há guia gravada; nos outros casos, fica a do conjunto.

## Configurações que impactam esta unit

| Código CFGSIS | Efeito |
|---------------|--------|
| `GNRTEM` | Separa os conjuntos de itens ST/Tributada em `TListGNRE` |
| `IFCPST` | Soma diferença de FCP-ST no valor da GNRE; `fCampoFCPST` traz `N23D_FCPST` do XML |
| `TIPABF` | Tributação de `CADITE` (1) ou `ITEGER` |
| `CONIPI` | Contribuinte de IPI no recálculo e no preço médio |
| `IGNSIM`, `VAPICO` | Lidas no `Create` de `TGNRE`, sem uso no restante da unit |
| `AJUGIA`, `GIAINT`, `GIAPRO` | Ajustes `FISAJD` (CAT 54/2020) em `fGravaCadAjustes` |
| `HISCTP` | Histórico no contas a pagar e na baixa |
| `CTPAVI` | Vencimento vazio ou hoje: grava movimento bancário e baixa |
| `URSTCL` | Recálculo por CT-e; redução de carga média da empresa |
| `FRETRI`, `FRETIP` | Frete na base de ICMS/ST e de IPI no recálculo |
| `GNRX90` | Inclui CST de antecipação (x90) nos itens |
| `GNRPLC`, `GNRCRF`, `GNREVE`, `FORGNE` | Sugestões de plano de contas, tributo, centro de custo e fornecedor em `fTelaGnre`/`pVerificaPrevia` |
| `MEDEMP` | Preço médio em várias empresas |
| `FRMCUS` | Fórmula do percentual de substituição no custo (`1` inclui IPI no divisor). `4` + `SUFRAM` usa TCIF/TS no custo |
| `REDTAR` | Redução TARE no ICMS de entrada/saída no custo e venda |
| `ATPVMB`, `ATPVM2`..`ATPVM7` | Por tabela de preço: `P` recalcula preço de venda, senão recalcula margem |
| `BASMED` | `S` desliga o recálculo de preço médio |
| `ULTPIS` | Deduz PIS/COFINS (e, por engano aparente, também ICMS — `blnDedIcm` lê `ULTPIS`) na última compra |
| `TRDPCI` | Fornecedor filial com ICMS no preço médio |
| `COFENT` | `2` = alíquota de PIS/COFINS informada |
| `ATUNMD` | `M` atualiza preço a partir do preço médio (`pAtualizaPreco`) |
| `INFMAT`, `INFFED`, `INFSAI`, `INFOPE`, `DECUNI`, `ATUPIS`, `ATUDIC`, `EFEIMP` | Parâmetros do recálculo de preços em `pAtualizaPreco` |

## Tabelas

| Tabela | L/G | Onde |
|--------|-----|------|
| `CADGNR` / `GNRTCI` / `GNR_TS` | L/G | `fGravaCadGnr`, `pCarregaGnre`, `pDeletaGnre`, `fAtualizaAutBancaria`, `TListGNRE.Create` |
| `FISAJD` | G | `fGravaCadAjustes` |
| `TMP_ENTMER` | L/G | `fSQLItens` (L), `fAtualizaValorGnre` (G), `fRetTotalBasSTCalculado` (L, `ENT_GNRTSU`) |
| `MOVDET`, `MOVTRI`, `MOVICD`, `CALGNR` | L | `fSQLCarregaItens` |
| `MOVTRI` | G | `pUpdateMovTri` (`DET_VLGNRE`/`DET_VALTCI`/`DET_VAL_TS`, `DET_IMPULT`) |
| `CALGNR` | G | `pGravaMemoriaDeCalculo` (insert ou update por `DET_SEQDET`) |
| `ITEGER` | G | `pUpdateCadIte` (`ITE_FORULT`, `ITE_IMPULT`, `ITE_PREMED`) — só se `ITE_NOTULT` é esta nota |
| `LOTPRE` | L/G | `fUpdateLotePrecos` (`LTP_ATUALI = 'N'`) |
| Lote preços pré-pro | L/G | `AtualizarLotePrecosPrePro` via `TLotePrecoPrePro` |
| `GERELE`, `DETELE` | L | `fCarregaGerEle`, `fCarregaDetEle`, `fTemNotaElet`, `fSQLCarregaItens`, `pUpdateMovTri` |
| `CADFIS`, `MOVGER`, `CONFRE` | L | `fCarregaItensConFre` |
| `ABFICM`, `CADITE`, `ITEGER`, `CADTRI`, `CADUNI`, `CADNCM`, `CADFOR`, `CADCID`, `PREPRO` | L | Montagem de itens e recálculo |
| `CADPAG`, movimento bancário | G | `fGravaGnre` via `fGravaCadPag` / `fGravaMovBan` |

## Métodos — `TGNRE`

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `Create` | constructor | Lê configurações, cria `FItens`, portador do fornecedor e pagamento antecipado. Tipo inicial `tcGnrePadrao` | — |
| `setTipoChamada` | setter | Define `FTabela`, `FCampoValor`, `FCampoCalculado` | — |
| `fGetNomeProcesso` | function | `'GNRE'`, `'TCIF'` ou `'TS'` para mensagens | — |
| `pTelaGnre` | procedure | Carrega itens (`fVerificaItens`) e abre a tela (`fTelaGnre`). Sem itens, zera o valor | Abre tela |
| `fTelaGnre` | function | Recalcula por CT-e na edição, aplica sugestões de configuração, abre `TfrmEntGNRE`; no cancelamento desfaz o recálculo | Abre tela modal; altera `FItens` |
| `pVerificaPrevia` | procedure | Com NF-e, pergunta se informa a guia da prévia e abre a tela | Abre tela; grava `TMP_ENTMER` |
| `fVerificaItens` | function | Recria `FItens` com `fSQLItens` e parâmetros de CST; pergunta sobre recálculo por CT-e | Lê `TMP_ENTMER` |
| `fSQLItens` | function | SQL dos itens em `TMP_ENTMER` conforme tipo e NF-e: valor (gravado ou prévia `ENT_VLRGNR`/`ENT_VALADB`), marcação e trava (`ENT_COMGNR`/`ENT_GNRFIX`), filtro por CST/ABF; TS só NCM com IPI | — |
| `fVErificaSeTemCTE_E_Pergunta_Se_DesejaRecalcularValorGNRE` | function | Há item com `ENT_FRECON > 0`? Opcionalmente pergunta | Mensagem |
| `pRecalculaGNRE` | procedure | Recalcula ICMS-ST do item a partir do XML, tributação e frete, conforme `ENT_CALSTU` (`tcsgiPadrao`, `Produto`, `Produto_ComDesconto`, `Produto_ComIPI`, `IPIComDesconto`); grava valor e memória de cálculo no item | Edita `FItens` |
| `fCarregaGerEle` / `fCarregaDetEle` | function | Lê capa/item do XML para records | Lê banco |
| `fCarregaTributacao` / `fSQLTributacao` | function | Lê `ABFICM` do item para a UF | Lê banco |
| `fCarregaDadosFornecedor` | function | Dados do fornecedor (`TNFeXml.fSQLDadosFornec`) e perfil ABF | Lê banco; devolve query (quem chama libera) |
| `fTipoCalculoBaseST` | function | `FOR_BSTXML = 1` → base sem IPI | Lê banco |
| `fDescontoXML` | function | Desconto do item, somando ICMS desonerado quando a nota fecha com diferença > 0,50 e a UF considera | — |
| `fRetTotalBasSTCalculado` | function | Base ST recalculada ou `SUM(ENT_GNRTSU)` | Lê banco |
| `fTemItensSelecionados` | function | Exige ao menos um item marcado | Mensagem |
| `fAtualizaValorGnre` | function | Grava valor, origem e memória de cálculo dos itens marcados em `TMP_ENTMER`; TCIF/TS gravam também a alíquota sobre `ENT_VLRCON`. Item com valor 0 recebe origem `P` | Grava `TMP_ENTMER` |
| `fRateiaGnre` | function | Distribui o valor recolhido pelos itens marcados, proporcional a `ENT_TOTITE` | Edita `FItens` |
| `fRateiaTS` | function | Idem para TS em todos os itens (6 casas) | Edita `FItens` |
| `fGravaGnre` | function | Ver subseção | Grava guia, ajustes, contas a pagar, baixa |
| `fGravaCadGnr` | function (privada) | Insere (ou edita, se `FAutoin`) a linha da guia; ajustes `FISAJD` só na inclusão e fora de `PD` | Grava `CADGNR`/`GNRTCI`/`GNR_TS` |
| `fGravaCadAjustes` | function (privada) | Três ajustes por item marcado: `GIAINT`, `GIAPRO` e `SP41090203` | Grava `FISAJD` |
| `fAtualizaAutBancaria` | function | Atualiza `GNR_AUTBAN`; opcionalmente agenda impressão do CP | Grava guia |
| `pCarregaGnre` | procedure | Carrega guia gravada; tipo vem de `GNR_ORIGEM` | Lê banco |
| `pDeletaGnre` | procedure | Apaga a guia do documento (mesmo fornecedor/doc/origem) | Apaga guia; erro só exibido |
| `pLimparTudo` | procedure | Zera os campos | — |
| `fRetTipoChamatoToChar` | function | `S`, `T` ou `P` | — |
| `fExtrairValorMemCalcGNRE` | function | Valor após o último `=` da memória de cálculo | — |

### `fGravaGnre`

1. Valor ≤ 0 ou fornecedor vazio: sai com `True` sem gravar.
2. `blnDelCadGnre` (padrão `True`): `pDeletaGnre` remove a guia anterior do mesmo documento/origem.
3. `fGravaCadGnr` grava a guia.
4. Com `blnGraFin`: monta a chave `GNRE`/`GARE`/`TCIF`/`TS00` + número com 8 dígitos; com `CTPAVI`
   e vencimento vazio ou hoje, grava movimento bancário (débito) e prepara a baixa; define o código de
   guia (GNRE 7, GARE ICMS 4, GARE DR 5, GARE ITCMD 6, TCIF/TS 11).
5. Pagamento antecipado selecionado: grava um contas a pagar do valor antecipado e consome as
   duplicatas (`fGravaPgtosAntecipados`); se o antecipado cobre tudo, não grava o contas a pagar normal.
6. Grava o contas a pagar (`fGravaCadPag`) com baixa, se houve, e agenda a impressão do CP.

## Métodos — `TListGNRE`

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `Create` | constructor | Lê configurações, abre as guias por `GNR_AUTFIS`, cria os dois conjuntos de itens | `blnDeuErro` se falhar |
| `fValidaDocumento` | function | Guarda a chave do documento, ativa o conjunto do tipo e carrega os itens (`fCarregaItens`, ou `fCarregaItensConFre`) | Lê banco; mensagem |
| `fTemNotaElet` | function | Existe `GERELE` para a nota? | Lê banco |
| `fSQLCarregaItens` | function | SQL dos itens gravados (`MOVDET`+`MOVTRI`+tributação+XML+`CALGNR`) | — |
| `fSQLCadTriConcat` | function | CSTs de `CADTRI` com `TRI_GERGNR = 'S'` | Lê banco |
| `fCarregaItens` | function | Abre o conjunto ativo **só se estiver vazio** | Lê banco |
| `fCarregaItensConFre` | function | Itens das notas ligadas a um conhecimento de frete (`UNION ALL`) | Lê banco |
| `fItensDoTipo` | function | Conjunto de itens de um tipo | — |
| `fAtivaItensDoTipo` | function | Aponta `FItensLis` para o conjunto do tipo e o carrega se vazio | Lê banco |
| `fTemGnreGravada` | function | Conjunto tem guia gravada não excluída? | — |
| `fTemMovimentoItens` | function | Conjunto tem guia nova ou guia gravada editada? | — |
| `pCopiaItensNovaGnre` | procedure | Cópia própria dos itens para guia nova; zera valor se já há gravada | — |
| `pCarregaListaGnre` | procedure | Recria os `TGNRE` a partir de `FqryDados` | Lê banco |
| `pAdiciona` | procedure | Cria guia nova, abre a tela, insere na lista se OK | Abre tela |
| `pEdita` | procedure | Localiza a guia da linha e abre a tela em edição | Abre tela |
| `fEncontraGNRE` | function | Localiza a guia por `AUTOINCREM`+origem ou `GNR_SEQREG`; guia gravada recebe o conjunto filtrado por `ORIGEM` | — |
| `fExclui` | function | Marca `FExcluida` | — |
| `pInserir` | procedure | Espelha a guia em `FqryDados` (nova = `GNR_INSERT 'S'` + `GNR_SEQREG`) | — |
| `pLimpaLista` / `pSetQtdIns` | procedure | Esvazia a lista; notifica `OnChangeQtdIns` | — |
| `fGravaGnre` | function | Guarda os parâmetros e roda `fGravaGnreInterna` dentro de `TfrmGravando` | Abre tela de progresso |
| `fGravaGnreInterna` | function | Transação: grava cada guia, `fGravaValoresItens`, imprime CPs, commit/rollback | Grava tudo |
| `fGravaValoresItens` | function | Por conjunto com movimento: consolida e atualiza. TCIF/TS: direto `fAtualizaValorTodosGNRE` | Grava |
| `fConsolidaValorNovasGnre` | function | Valor do item = base + parcelas das guias novas (ver tabela acima) | Edita `FItensLis` |
| `fAtualizaValorTodosGNRE` | function | Por item: custo de última compra, preço médio, `MOVTRI`, `LOTPRE`, `ITEGER`, `CALGNR`, última compra do lote. Itens com CFOP 1922/2922 não atualizam item/lote | Grava |
| `pUpdateMovTri` | procedure | Grava valor da guia e `DET_IMPULT`; marca memória manual se o valor diverge do gravado e do XML | Grava `MOVTRI`/`CALGNR` |
| `pUpdateCadIte` | procedure | Atualiza última compra e preço médio; com `ATUNMD = M`, preço | Grava `ITEGER` |
| `pAtualizaPreco` | procedure | Recalcula preços do item a partir do preço médio | Grava preços |
| `fUpdateLotePrecos` | function | Recalcula `LTP_SUBSTI`/`LTP_TCIFCU`, custo e venda do lote pendente | Grava `LOTPRE` |
| `AtualizarLotePrecosPrePro` | function | Idem para o lote de preços pré-pro | Grava |
| `pGravaMemoriaDeCalculo` | procedure | Insert/update em `CALGNR` | Grava |
| `fCampoFCPST` | function | Coluna `VFCPST` (XML com `IFCPST`, senão 0) | — |
| `pCarregaAtpVmb` | procedure | Lê `ATPVMB`..`ATPVM7` | — |

## Pontos de atenção

- `fGravaGnreInterna` abre a transação global (`fStartTransaction`). Chamar `TListGNRE.fGravaGnre`
  dentro de outra transação aberta é decisão de quem chama — não há proteção.
- `fCarregaItens` só recarrega se o conjunto estiver **vazio**: trocar de documento exige limpar o
  conjunto antes.
- `FItensLis` é ponteiro, não dono: o destrutor zera e libera só `FItensLisST`/`FItensLisTri`.
  Guia gravada aponta `cdsItens` para o conjunto compartilhado; guia nova tem o seu.
- `fEncontraGNRE` mexe em `Filter`/`Filtered` do conjunto compartilhado; `fConsolidaValorNovasGnre`
  salva e restaura o filtro.
- Ramo TS inalcançável em `fUpdateLotePrecos` e `AtualizarLotePrecosPrePro` (`tcTCIF` testado duas
  vezes): TS vai para o cálculo de `LTP_SUBSTI`.
- `fCarregaGerEle`, `fCarregaDetEle`, `fSQLCarregaItens` (com `fCarregaItensConFre`) e o `SELECT` de
  edição em `fGravaCadGnr` concatenam valores no SQL. Os valores vêm do próprio banco ou de
  `QuotedStr`/`fQuotedStr`, mas fogem do padrão `ParamByName`.
- `blnDedIcm` em `fAtualizaValorTodosGNRE` lê `ULTPIS`, igual a `blnUltPis` — para fornecedor não
  filial, deduzir ICMS segue a configuração de PIS. A confirmar se é intencional.
- `fGravaCadGnr` gera novo `GNR_NUMGNR` também na edição. A confirmar o efeito na chave do contas a
  pagar já gravado.
- Regra do projeto: código editado não pode usar `With...Do`; a unit tem vários, pré-existentes.

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-10-16 | Alteração local sobre r500183 — requisito ainda sem número | `TListGNRE` passou a ter dois conjuntos de itens (`FItensLisST`/`FItensLisTri`, `CFG_GNRTEM`) com `fItensDoTipo`/`fAtivaItensDoTipo`; guia nova recebe cópia própria dos itens (`pCopiaItensNovaGnre`); a gravação consolida o valor por conjunto (`fGravaValoresItens`, `fConsolidaValorNovasGnre`, `fTemGnreGravada`, `fTemMovimentoItens`) antes de `fAtualizaValorTodosGNRE`; `fEncontraGNRE` só reatribui os itens de guia gravada; `fGravaCadGnr` grava ajustes `FISAJD` só na inclusão |
