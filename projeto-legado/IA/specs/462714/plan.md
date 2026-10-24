# Plano de Execução — Req. 462714

**Referência:** spec.md
**Zona:** Legado
**Versões:** 150 (base, já implementada e em refatoração), 150.100, 150.45, 74.111, 72

## 1. Abordagem técnica

Seguir a cadeia do IPI ponto a ponto. O operador informa a **alíquota** e o sistema calcula o valor sobre a base da NT (spec RN05/RN06).

O cálculo fica num **núcleo OO** sem dependências (`untImpostosReformaCompra.pas`), igual nas 5 versões. Cada tela tem um **adapter** fino que lê os campos do seu dado (dataset do pedido, record `TPcmDet`, dataset da cotação ou colunas pivô `nn`), monta a base e as alíquotas, chama o núcleo e grava o resultado. O que muda entre versões são só os adapters e as assinaturas de gravação.

### Padrões aplicados

| Padrão | Onde | Por quê |
|--------|------|---------|
| Value Object (record com método) | `TAliquotasReforma`, `TBaseReforma`, `TValoresReforma` | Campos nomeados no lugar de 7 Doubles posicionais; validação 0–100 e piso da base num lugar só |
| Calculadora sem estado (`class function`) | `TCalculoReformaCompra` | Regra RN06 única para pedido, cotação e cotação→pedido; testável no DUnit sem banco |
| Adapter | `pCalculaImpostosReformaItem`, `pCalculaImpostosReformaPcmDet`, BeforePost da cotação | Isola o formato de cada dado; o núcleo não conhece dataset |
| Builder de SQL | `TCalculoReformaCompra.fSQLValores(base, alíquotas)` | A fórmula da cotação em SQL era montada duas vezes |

**Não aplicados, por decisão:** Strategy por tipo de documento (a diferença é só quais campos entram, e o record resolve); interfaces com GUID (zona legado); record nas assinaturas de `untGravacaoPedido` (sem default possível em record, quebraria chamadores).

### Núcleo — esboço

```pascal
unit untImpostosReformaCompra;

interface

type
  TAliquotasReforma = record
    fltCbs, fltIbs, fltIs: Double;
    class function fCriar(const AfltCbs, AfltIbs, AfltIs: Double): TAliquotasReforma; static;
    class function fAliquotaValida(const AfltAliquota: Double): Boolean; static;
  end;

  TBaseReforma = record
    fltTotIte, fltValFre, fltDesAce, fltValIcm, fltValImp, fltValPis, fltValCof: Double;
    function fValor: Double;
  end;

  TValoresReforma = record
    fltCbs, fltIbs, fltIs: Double;
    function fTotal: Double;
  end;

  TCalculoReformaCompra = class
  public
    class function fCalcular(const ABase: TBaseReforma; const AAliquotas: TAliquotasReforma;
                             const AblnArredonda: Boolean): TValoresReforma;
    class function fSQLValores(const AstrBase, AstrAlqCbs, AstrAlqIbs, AstrAlqIs: String): TSQLValoresReforma;
  end;
```

`fSQLValores` recebe a expressão SQL da base (que depende das fórmulas `sql*_COT_COM` de cada versão) e devolve as expressões de `TOTAL_IS/CBS/IBS` e da soma no `VALTOT`. Assinatura final definida na implementação; o contrato é: uma única montagem da fórmula RN06 em SQL.

### Regra ligada / desligada

- Condição: `fSomarNovosImpostosDaReformaAoValorContabil`, avaliada uma vez por abertura e guardada em campo (`FblnSomaReforma`).
- O cálculo dos valores roda sempre. Exibição e soma no total dependem só desse campo, nunca da visibilidade de controle.
- 7x: a função foi criada direto em `untFuncoesSimples`, com o corpo da 150. A `CFG_SIMHIB` é criada no
  `untCfgRepositorio`.

### DDL

[script_462714.sql](script_462714.sql). Alíquota `DECIMAL(12,2)` (igual `COT_IPIENT`), valor `DECIMAL(12,4)`. Nos 7x conferir antes se `COTFOR_RES` / `PCMDET_RES` / `PCMGER_RES` existem; retirar do script o `ALTER` de tabela inexistente.

## 2. Refatoração da 150 (antes do porte)

Caminhos relativos a `padra_atualizado/fontes/movimentacaoitens/`.

| Item | Unit | Ação |
|------|------|------|
| Núcleo | `PedidoDeCompra\untImpostosReformaCompra.pas` | **criar**; incluir em todo `.dpr` que compila `untFuncoesPedidoSimples` — na 150: `autcom.dpr`, `libPedidoDeCompra.dpr` e 15 Services Linux (nenhum tem a pasta no search path) |
| Adapter do item | `PedidoDeCompra\untFuncoesPedidoSimples.pas` | `pCalculaImpostosReformaItem` passa a montar `TBaseReforma` e chamar o núcleo; remover `fBaseImpostosReforma` e `pCalcularImpostosReforma`; nova rotina única `pCopiaAliquotasReforma(AOrigem, ADestino: TDataSet; AblnImportacao: Boolean)` (copia e recalcula) |
| Cópias repetidas | `untAjustaMultiLoja`, `untPedidoCompra` (3 pontos de rateio), `untFuncoesPedido` (2 pontos) | trocar as 4 linhas por `pCopiaAliquotasReforma` |
| Prévia / ICMS desonerado | `untPedidoCompra.pas` `pCalculaReformaTela` e adapter do item | base via `TBaseReforma`; o ICMS só deixa de sair da base com Zona Franca **e** `ITE_CICMDE = 'S'` (como `fCalcularSubstituicaoProduto` e `TOT_TOTGER`) |
| Validação | `untPedidoCompra.fValidaAlqReforma`, `Cotacao\untAlteraValorUnitario` | as duas usam `TAliquotasReforma.fAliquotaValida` (0–100) |
| Flag por visibilidade | `untPedidoCompraImportacao` (`grbReforma.Visible`), `untPedidoCompraResumoLojas` (`cxvPedidosTOTREF.Visible`), `untPedidoCompraResumoLojasItem` (`cxvItensTOTREF.Visible`) | campo `FblnSomaReforma` avaliado no FormCreate/FormShow |
| Cotação | `Cotacao\untCotacao.pas` | BeforePost via núcleo (`AblnArredonda = False`); `fSQLPrecosItemFornecedor` e `fSQLUpdateVlrTot` via `fSQLValores` |
| Cotação→pedido | `Cotacao\untTPreparaPedidosCotacao.pas` | `pCalculaImpostosReformaPcmDet` via núcleo |
| Comentários | todas as units do diff | remover os que repetem o código ou citam RN; manter só os do núcleo |
| Build | `PedidoDeCompra\rev.inc` | não commitar (artefato) |

## 3. Arquivos impactados na 150 (referência para o porte)

Todos com ação **alterar**, exceto a unit nova.

| Unit | O quê |
|------|-------|
| `PedidoDeCompra\untFuncoesPedidoSimples.pas` | campos `ITE_ALQ*` / `ITE_VAL*`, aggregates `TOT_VAL*`, `TOT_TOTGER` condicional, adapter do item, `fTotalImpostosReformaItem`, `fSQLSomaImpostosReforma`, `pAtualizaTotaisPedido` (param `AblnGravaReforma`), `fBaixaPcmGer` / `fDesfaturaPedidoCompra` (saldo proporcional) |
| `PedidoDeCompra\untGravacaoPedido.pas` | params finais com default 0; grava `PCD_ALQ*`, `PCD_VAL*`, `PCG_VAL*` |
| `PedidoDeCompra\untPedidoCompra.pas/.dfm` | rodapé 2ª linha, colunas do grid, `pnlReforma`, visibilidade, recálculos, digitação, carga, gravação simples e multi-loja; `TRodapeFormatado.Create(Self, Panel4, lblTotGer)` no `FormCreate` |
| `PedidoDeCompra\untRodapeFormatado.pas` | **criar** (RF03a): rodapé em linha corrida desenhado por `TPaintBox`, campos antigos num painel oculto como fonte, gancho `WindowProc`, último rótulo fixo, altura mínima. Idêntica nas 5 versões; entra só no `libPedidoDeCompra.dpr` (o form fica na DLL) |
| `configuracoes\untCfgRepositorio.pas` (só 74.111 e 72) | `CFG_SIMHIB`: `pAdicionarConfiguracao` no fim do grupo DADOS FISCAIS e a linha do editor `rdgSimNao_S_N` na mesma posição (a tela liga o editor pela ordem) |
| `PedidoDeCompra\untFuncoesPedido.pas` | giro, cotação no giro, multi-loja, centralizada, síntese |
| `PedidoDeCompra\untCdsDigMultLoja.pas`, `untAjustaMultiLoja.pas` | totais por empresa e rateio |
| `PedidoDeCompra\untPedidoCompraResumoLojas(Item).pas/.dfm` | coluna CBS+IBS+IS e soma no total |
| `PedidoDeCompra\untPedidoCompraImportacao.pas/.dfm` | recálculo no BeforePost, grupo no resumo, soma |
| `PedidoDeCompra\untUnificacaoPedidos.pas`, `untRecuperaPedido.pas`, `untTDistribuiPedidoCompraDataEntrega.pas`, `untPastaCompra.pas`, `untTValidaValorPedidoCompra.pas` | fluxos secundários |
| `PedidoDeCompra\untQckHTMLPedidoCompra.pas/.dfm`, `untOpcoesExcelPedCompra.pas`, `untPnlDadosPedCompra.pas` | campos de impressão/exportação |
| `Cotacao\untCotacao.pas`, `untCotacaoTypesAndConst.pas`, `untCadCotacaoGeralCX.pas/.dfm`, `untAlteraValorUnitario.pas/.dfm`, `untTPreparaPedidosCotacao.pas` | cotação, exportar/importar, cotação→pedido |

## 4. Porte por versão

Ordem: 150.100 → 150.45 → 74.111 → 72 (da mais próxima para a mais distante). Em todas: copiar a unit núcleo sem alteração, incluir nos dois `.dpr`, aplicar o DDL no banco da versão. Linhas abaixo são da versão alvo, levantadas em 09/10/2026; reconferir antes de editar.

### 4.1 150.100 (o patch da 150 aplica quase todo)

- **Sem antidumping:** `fGravaPcmDet` termina em `strDiaUte, intImppla` (`untGravacaoPedido.pas:332-333`, impl. `:1774-1775`). Params novos depois de `intImppla`. Nas chamadas posicionais, **retirar** `fltValAdp`/`strTipAdp`: `untTPreparaPedidosCotacao` (gravação do item), `untUnificacaoPedidos` (gravação do item), `untTDistribuiPedidoCompraDataEntrega`, `untRecuperaPedido` (2ª chamada, `:1162`), `untPedidoCompra` (`:16278`, `:16709`).
- **Sem `fAplicarLinhaImportada` / Services:** os pontos ligados a ela ficam de fora. `pAtualizaUnitarioItemfornecedor` existe (`untCotacao:584` / `:5519`) e recebe os params `-1`.
- **`TIT_*`** em `untCotacao.pas:1145` (bloco `const` da implementation); `TIT_CBS/IBS/IS` após `TIT_CREICM` (`:1150`). `TAtualizaUnitarioItemfornecedor` em `untCotacaoTypesAndConst.pas:63`.
- `untFuncoesPedido` `pZeraQuantidadeDoItemAtualCasoNecessario` (`:8030`): sem o bloco `blnMedAju`; zerar após `ITE_TOTIPI := 0` (`:8050`).
- `untPedidoCompra.dfm`: `pnlReforma` antes de `pnlAdicionar` (`:3659`); não há `rdgTipAdp`.
- `untPedidoCompra.pas` `fValidaCampos`: ramo após `edtPerIpiImp` (`:2414-2417`), sem `edtValAdp`.
- `untPedidoCompraImportacao.pas`: sem colunas/rotina de antidumping.

### 4.2 150.45

- **Cotação sem `COT_QTDATE` e sem multi-cotação (`blnMulCot`)**; `untCotacao.pas` passou por formatador (quebras diferentes). Reescrever à mão:
  - `fSqlUpdateItemFornecedor` (decl. `:482`), inserts/updates de `COTFOR` (`:2010`, `:2026`, `:2820`, `:2843`, `:8754`, `:8773`, `:9222`, `:9257`, `:9282`, `:9313`, `:9349`, `:16498`, `:16593`);
  - `fSQLPrecosItemFornecedor` (`:4072`, `:4150`), `pFormataDecimal` (`:4310`), BeforePost (após `:5956`), `fAlteraValorUnitario` (após `:6989`);
  - `fSQLUpdateVlrTot` (`:7706`, **sem parâmetro**): usar só o ramo `COT_QTDITE + COT_QTDEME`;
  - `pCriarNovaCotacaoComItensSemCotacao` não existe.
- `pAtualizaUnitarioItemfornecedor` em `:5559`; chamada na importação `:13440`. `TIT_*` em `:1132` (`TIT_CBS/IBS/IS` após `:1137`).
- **`TPreparaPedidosCotacao.Create`** (`:320`) não recebe `AcdsPrecosFornecedores`: adicionar o parâmetro e passar `cdsPrecosItemfornecedor` no chamador (`untCotacao.pas:7520`); sem `FMulCot` no Destroy (`:388`).
- **Rateio multi-loja:** não há `untAjustaMultiLoja`; usar `pAjustaMultiLoja` em `untFuncoesPedidoSimples.pas:2870`, antes de `TCalculaCamposPedido.pCalcFields` (`:2984`).
- `untFuncoesPedidoSimples`: usa `fCadEmp(` em vez de `fCadEmpresa(` (`:1417`, `:4028`); sem `pCampo('IMPPLA')` (`:1404`).
- `untGravacaoPedido`: `fGravaPcmDet` termina em `fltUniLiq` (`:324`, `:1760`). Sem `strDiaUte`, `intImppla`, antidumping.
- `untPedidoCompra.pas`: sem `intImppla` (`:832`); gravação termina em `ITE_UNILIQ` (`:16100`) e `PCD_FATEMB` (`:16507`); **não existe** o `UPDATE PCMGER` multi-loja por subselect.
- `untTDistribuiPedidoCompraDataEntrega`: chamada de gravação (`:640-717`) termina em `fltDesPis`; passar os defaults intermediários (`False, '', True, '', False, -1, 0, 1, 0`).
- `untRecuperaPedido`: chamadas terminam em `ITE_UNILIQ` (`:874`, `:1150`).
- `untAlteraValorUnitario.dfm`: layout plano (painéis de topo); montar `pnlReforma` à mão. `untCadCotacaoGeralCX.dfm`: footer sem `TOTAL_CREICM` (`:2361`).
- `untPedidoCompraImportacao.pas`: `uses untFuncoesSimples;` só (`:103`).

### 4.3 74.111

**Pedido: quase 1:1 com a 150.**
- `untFuncoesPedidoSimples`: campos antes de `:990`, aggregates `:994` / `:1001` (usa `fCadEmp`), `pZeraMultiLojas` `:1083`, `pAcertaCorPedido` `:2780`, `pAtualizaTotaisPedido` `:3462`, rateio em `pAjustaMultiLoja` (`:2357`, inserir antes de `:2467`). `ITE_CICMDE` existe (`:723`).
- `fBaixaPcmGer` e `fDesfaturaPedidoCompra` ficam em `movimentacaoitens\untPcmGer.pas` (`:1607`, `:10209`).
- `untGravacaoPedido`: `pGravaPcmGer` / `pAtualizaPcmGer` terminam em `blnPagamentoCartaoCredito, strObs006` (sem `blnGerarAutInc`); `fGravaPcmDet` termina em `dtaDatEdt, fltUniLiq`.
- `untPedidoCompra.pas`: mesmas funções da 150 (`pCalculaTotalItemQtdGrid` `:2879`, `fAdicionaItem` `:6523`, `fConfirmaPedido` `:13251`, `fCalculaTotalEmpresas` `:17498`). Sem `fLiberaAlterarValorUnitario` (a digitação da alíquota não pede liberação) e sem o `UPDATE PCMGER` por subselect.
- Units sem `untFuncoesPedidoSimples` no `uses` que precisam da regra: `untPedidoCompraResumoLojas(Item)`, `untTValidaValorPedidoCompra`, `untOpcoesExcelPedCompra`, `untPedidoCompraImportacao`.
- Não existem `untAjustaMultiLoja` e `untTDistribuiPedidoCompraDataEntrega`.

**Cotação: desenho pivô, reescrita.**
- `cdsItens` com colunas `VALUNInn`, `IPIENTnn`, `VALTOTnn` (nn = 01..50, `INT_MAX_FORNECEDOR`). Sem `COT_CREICM` e sem `COT_DIVISO`: a base é `preço + frete`.
- Criar `ALQCBSnn/ALQIBSnn/ALQ_ISnn` (subselect por fornecedor em `fSQLItens` `:2379-2387`, slots vazios `:2394-2405`) e os totais por fornecedor, no mesmo laço do `IPIENTnn`.
- BeforePost `pBeforePostItens` (`:3237`, `VALTOTnn` `:3284`): calcular por fornecedor via núcleo e somar no `VALTOTnn` (regra ligada). `fAlterouItem` `:3437`.
- `COT_VLRTOT` em `fSQLCotacoes` (`:1038-1046`, SELECT, não UPDATE).
- Grid `cxbItensFornec` (`untCadCotacaoGeralCX.dfm:2240`): colunas religadas em `pAfterScrollFornecedores` (`.pas:1988-2002`).
- Diálogo `untAlteraValorUnitario` (layout plano, form 296 px): `DataField := 'ALQCBS' + fIndice(idx)` em `fAlteraValorUnitario` (`:3986-3991`).
- Gravação `COTFOR`: `fSqlInsertItemFornecedor` `:6145`, `fSqlUpdateItemFornecedor` `:6161` (assinatura própria), `pGravaItemFornecedor` `:6538` (ON DUPLICATE `:6524`), `COTFOR_RES` `:1576`, herança `:12383`, cópia de segurança `:12432`.
- Exportar/importar: `pExportarExcelNovo` `:10135`; `pImportaArquivos` `:9318` (grava direto no pivô `:9478`). `TIT_*` em `untCotacao.pas:670`.
- Cotação→pedido: `untTPreparaPedidosCotacao` com o mesmo esqueleto da 150, mas a alíquota vem de `FcdsItens.FieldByName('ALQCBS' + fIndice(indexFornecedor))` (como o IPI em `:687`), sem `CloneCursor`. Gravação: `pGravaPcmGer` termina em `strUsaGir` (`:917`); `fGravaPcmDet` em `fltDesPis` (`:1006`).
- Multi-loja do fornecedor escolhido: `pAtualizaCDSItensMultiLojaFornecedorEscolhido` (`:2790`).
- **Fora de escopo:** caminho `COTACAO_MODO_GRAVACAO_ANTIGA` (`untCotacao` `:4150` / `:4437`, desvio em `:5211`).
- A regra: hoje só `libNfe\untUtil.pas:4433` tem uma `fSomarNovosImpostos...` (com `IFonteDados`, inacessível ao ERP). Criar a do genericos.

### 4.4 72

**Pedido: próximo da 150, sem FCP e sem ICMS desonerado.**
- Não há `ITE_SUBFCP` / `PCG_SUBFCP` / `TOT_SUBFCP` nem `ITE_CICMDE`: o adapter não lê o desonerado; o ICMS sempre sai da base.
- `untFuncoesPedidoSimples`: campos após `:856`, aggregates `:859-866`, `pZeraMultiLojas` `:946`, `pAcertaCorPedido` `:2740`, `pAtualizaTotaisPedido` `:3449` (sem `fltSubFCP`), rateio em `pAjustaMultiLoja` (`:2334`, inserir entre `:2427` e `:2429`).
- `fBaixaPcmGer` / `fDesfaturaPedidoCompra` em `untPcmGer.pas` (`:1423`, `:8608`).
- `untGravacaoPedido`: as três rotinas terminam em `strIpiFre` (cabeçalho) e `dtaDatEdt` (item). Chamadas existentes que param antes da cauda (`untRecuperaPedido` `:482`, `:577`, `:689`, `:949`; `untUnificacaoPedidos` `:1001`, `:1119`; `untPedidoCompra` multi-loja `:12574`) passam os defaults intermediários explícitos.
- `untPedidoCompra.pas`: `pCalculaTotalItemQtdGrid` `:2628`, `fAdicionaItem` `:6137`, `fCarregaItensPedidoAux` `:7895`, `fConfirmaPedido` `:12110-12793`, `fCalculaTotalEmpresas` `:15215`. Sem `edtPerIpiEnter/Exit` e sem `fLiberaAlterarValorUnitario`. `pAtualizaTotaisPedido` só roda com frete + despesas > 0 (`:12786`): conferir se a gravação de `PCG_VAL*` / `PCG_TOTGER` fica coberta pelo `pGravaPcmGer`.
- `untPastaCompra.pas:894` também gera pedido (`pGravaMestrePedido`): recebe os defaults 0.
- Não existem `untAjustaMultiLoja`, `untTDistribuiPedidoCompraDataEntrega`, `untTPreparaPedidosCotacao`, `untCotacaoTypesAndConst`.

**Cotação: desenho pivô, reescrita (como o 74.111, com crédito de ICMS).**
- Colunas `VALUNInn`, `IPIENTnn`, `CREICMnn`, `VALIPInn`, `VALTOTnn`. Base `preço + frete − crédito de ICMS`.
- `fSQLItens` `:1602` (subselects `:1657-1661`, slots vazios `:1676-1689`), `fAbreItens` `:1805`, `pBeforePostItens` `:2415` (laço `:2443-2459`), `fAlteraValorUnitario` `:3065`, `COT_VLRTOT` em `fSQLCotacoes` `:730-807`.
- Grid `cxbItensFornec` (`.dfm:1481`), binding em `pAfterScrollFornecedores` (`.pas:1298-1313`), visibilidade junto do `CREICM` (`.pas:1260`).
- Gravação `COTFOR`: `fSqlInsertItemFornecedor` `:4723`, `fSqlUpdateItemFornecedor` `:4739`, `pGravaItemFornecedor` `:5050-5085`, herança `:9528`.
- Exportar/importar: `pExportarExcelNovo` `:7604` (AddCampo `:7693`); `pImportaArquivos` `:7099` (grava no pivô `:7251`). `TIT_*` em `untCotacao.pas:558`.
- **Cotação→pedido dentro do `TCotacao`:** `fIniciaPedidoCompra` `:3245` (totais `:3333-3395`, `pGravaPcmGer` `:3414`), `fGravaItemPedido` `:3509` (`fGravaPcmDet` `:3607`), `fGravaPedidoCompra` `:3705` (IPI por `fIndice` `:3813`, `pAtualizaTotaisPedido` `:3825`), `fGravaPedidoCompraDesmembrado` `:3836`, multi-loja `:1970` / `:2014`.
- Diálogo `untAlteraValorUnitario` (form 306 px, sem crédito/divisor): campos ligados por `nn` (`untCotacao:3085-3089`); o recálculo `dbeUniTot/dbeValTot` (`.pas:111-121`) passa a somar CBS/IBS/IS no total.

## 5. Sequência de implementação

1. Núcleo `untImpostosReformaCompra.pas` + teste DUnit em `TestesUnitarios/` (massa do CA01 e bordas).
2. 150: refatoração do §2 (adapters, rotina de cópia, correções, comentários). Compilar `autcom.groupproj` e `Services.groupproj`.
3. 150.100: aplicar o diff da 150 refatorada + ajustes do §4.1. DDL. Compilar.
4. 150.45: §4.2. DDL. Compilar.
5. 74.111: função da regra no genericos; pedido; cotação pivô; cotação→pedido. DDL. Compilar.
6. 72: idem, §4.4. DDL. Compilar.
7. Testes manuais CA01–CA15 por versão; CA16 (hash da unit) e CA17 (build).
8. Verificação de encoding e EOL em todos os arquivos alterados das 5 versões.

## 6. Conformidade com padrões do projeto

- Zona Legado: Hungarian (`FblnSomaReforma`, `fltCbs`, `AfltAliquota`), prefixos `p` / `f`, `unt` no nome da unit, sem refatorar além do necessário.
- Componentes: `TEditFocus` (digitação), `TDBEdit` + `TLabel` (rodapé), `TcxGridDBColumn` / `TcxGridDBBandedColumn`. Nada de `TButton`, `TBitBtn`, `TDBGrid` ou `dxSkin*`.
- Chamadas: `fStrToFloat` / `fStrToFloatDef` (não copiar o `StrToFloatDef` de handlers antigos), `pSetFocus`, `fMensagem`, `fNow`, `ParamByName` em SQL novo com valor.
- Units novas entram só pelo `.dpr` (a IDE sincroniza o `.dproj`).
- Pre-commit: sem `FillType = ftBrush` ou `Outline =` em `.dfm`. Primeira linha `Req. 462714` + token DelphAI.
- Encoding: bytes cp1252 preservando o EOL de cada arquivo. Nunca Edit/Write em `.pas` / `.dfm` / `.dpr`.

## 7. Estratégia de testes

- **DUnit** (`padra_atualizado/TestesUnitarios/AutcomTestes.dpr`; a pasta `TestCase/` não existe na 150 — nos 7x conferir a suíte disponível): `TCalculoReformaCompra.fCalcular` com a massa do CA01 (940,00 → IS 9,40, CBS 8,54, IBS 0,95), base negativa, alíquota zero, sem arredondamento (cotação), `TAliquotasReforma.fAliquotaValida` nas bordas 0 / 100 / −0,01 / 100,01. A mesma suíte roda nas 5 versões.
- **Manual por versão:** CA01–CA15 da spec. Massa: a do CA01; ICMS desonerado (150.x e 74.111); pedido de importação; cotação com e sem crédito de ICMS; nos 7x, fornecedor no slot 01 e num slot alto; combinações `REFCIS` / `SIMPAU` / `SIMHIB`.
- **SQL de conferência:** `PCD_ALQ*` / `PCD_VAL*`, `PCG_VAL*`, `PCG_TOTGER` = Σ itens, parcelas.

## 8. Riscos e mitigação

- **Divergência de `PCG_TOTGER` entre fluxos.** Mitigação: núcleo único, rotina única de cópia, checklist por versão e CA12.
- **Ponto de recálculo esquecido.** Mitigação: chamar o adapter em todo ponto que atribui `ITE_TOTIPI` (mapeado por versão no §4) e testar o CA05.
- **Defaults posicionais divergentes.** Mitigação: conferir cada chamada contra a assinatura da versão antes de gravar.
- **Cotação pivô (7x).** Mitigação: gerar as colunas no laço do `IPIENTnn`; testar slots 01 e alto.
- **`CFG_SIMHIB` ausente nos 7x.** Simples soma até a config existir (dependência externa).
- **Parcelas mudam com a regra ligada** (RN09). Mitigação: comunicar no texto de entrega.
- **`Now` pré-existente em `pAtualizaUnitarioItemfornecedor`** (`COT_IMPPLA := Now`, gravado em banco). Se a trava do pre-commit acusar, trocar por `fNow` e registrar.
- **Bancos dos outros projetos sem DDL.** Mitigação: aplicar e conferir antes de testar cada versão.
- **Corrupção de encoding.** Mitigação: fluxo cp1252 em bytes e checagem "não é UTF-8 válido" (CA15).
