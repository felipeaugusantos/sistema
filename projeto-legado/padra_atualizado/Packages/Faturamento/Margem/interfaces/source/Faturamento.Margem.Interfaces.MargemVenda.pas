unit Faturamento.Margem.Interfaces.MargemVenda;

interface

Uses
  Shared.Functions.Types;

type
  IParametrosServicoMargemVenda = interface
    ['{F8437793-0AEB-44F7-999B-4014DBB09CD4}']
    function ClassificacaoFiscal : String; overload;
    function ClassificacaoFiscal(AValue : String) : IParametrosServicoMargemVenda; overload;

    function CarregarPedidoOrcamentoEntradaFutura : Boolean; overload;
    function CarregarPedidoOrcamentoEntradaFutura(AValue : Boolean) : IParametrosServicoMargemVenda; overload;

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function PrecoMedio : Double; overload;
    function PrecoMedio(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function CalcularST : Boolean;overload;
    function CalcularST(AValue : Boolean) : IParametrosServicoMargemVenda; overload;

    function PrecoUltimaCompra: Double; overload;
    function PrecoUltimaCompra(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorUnitarioOriginal : Double; overload;
    function ValorUnitarioOriginal(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorUnitario : Double; overload;
    function ValorUnitario(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDoIcms : Double; overload;
    function ValorDoIcms(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorBaseDoIcms : Double; overload;
    function ValorBaseDoIcms(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDoDifal : Double; overload;
    function ValorDoDifal(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDoFCP : Double; overload;
    function ValorDoFCP(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function DespesaOperacionalCliente : Double; overload;
    function DespesaOperacionalCliente(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorComissaoTabelaDeitens : Double; overload;
    function ValorComissaoTabelaDeitens(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDoCustoPraticado : Double; overload;
    function ValorDoCustoPraticado(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorCustoDoItem : Double; overload;
    function ValorCustoDoItem(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function OutrosValores : Double; overload;
    function OutrosValores(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ConsiderarMargemDePrecoUltimaCompraNoCalculo : Boolean;overload;
    function ConsiderarMargemDePrecoUltimaCompraNoCalculo(AValue : Boolean ): IParametrosServicoMargemVenda;overload;

    function ValorUltimaCompraImpostos : Double; overload;
    function ValorUltimaCompraImpostos(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDaSubstituicao : Double; overload;
    function ValorDaSubstituicao(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorDoIcmsStParteDaVenda : Double;overload;
    function ValorDoIcmsStParteDaVenda(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorCalculoImpostosAliquota: Double; overload;
    function ValorCalculoImpostosAliquota(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorCat17: Double; overload;
    function ValorCat17(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IParametrosServicoMargemVenda; overload;

    function ConfiguracaoMargemMarkup : String;overload;
    function ConfiguracaoMargemMarkup(AValue : String): IParametrosServicoMargemVenda ;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoIcms : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoIcms( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargem : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargem( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemItem : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemItem( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemMinima : Double; overload;
    function ValorUnitarioMargemMinima( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemPraticadaCustoReal : Double; overload;
    function ValorUnitarioMargemPraticadaCustoReal( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemPropostaCustoReal : Double; overload;
    function ValorUnitarioMargemPropostaCustoReal( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemPropostaCusto : Double; overload;
    function ValorUnitarioMargemPropostaCusto( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemPraticadaCusto : Double; overload;
    function ValorUnitarioMargemPraticadaCusto( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoMedio : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoMedio( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioItemMargemPrecoMedio : Double; overload;
    function ValorUnitarioItemMargemPrecoMedio(AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioItemMargemProposta : Double; overload;
    function ValorUnitarioItemMargemProposta(AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioItemMargemPraticadaLucro : Double; overload;
    function ValorUnitarioItemMargemPraticadaLucro(AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorMargemIdeal : Double; overload;
    function ValorMargemIdeal(AValue : Double) : IParametrosServicoMargemVenda;overload;

    function CalcularPrecoIdeal : Boolean; overload;
    function CalcularPrecoIdeal(AValue : Boolean) : IParametrosServicoMargemVenda; overload;

    function ValorPrecoIdeal : Double; overload;
    function ValorPrecoIdeal(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function AliquotaIcmsPrecoIdeal : Double; overload;
    function AliquotaIcmsPrecoIdeal(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function PrecoMedioPraticado : Double; overload;
    function PrecoMedioPraticado(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorUltimaCompraImpostosPraticado : Double; overload;
    function ValorUltimaCompraImpostosPraticado(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoRealBruta : Double; overload;
    function ValorUnitarioMargemPraticadaCustoRealBruta( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorMargemPraticadaCustoReal : Double; overload;
    function ValorMargemPraticadaCustoReal( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorMargemPropostaCustoReal : Double; overload;
    function ValorMargemPropostaCustoReal( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorCustoRealPraticado : Double; overload;
    function ValorCustoRealPraticado( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function MargemMinimaLiquidaPorPrecoMedio : Boolean overload;
    function MargemMinimaLiquidaPorPrecoMedio(const AValue : Boolean) : IParametrosServicoMargemVenda; overload;

    function OutrosValoresValOri : Double; overload;
    function OutrosValoresValOri(AValue : Double) : IParametrosServicoMargemVenda; overload;
  end;

  IParametrosCalculoMargemVenda = interface
    ['{CA03C395-6080-42C9-9E41-F6DA3D077823}']

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function PrecoMedio : Double; overload;
    function PrecoMedio(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function CalcularST : Boolean;overload;
    function CalcularST(AValue : Boolean) : IParametrosCalculoMargemVenda; overload;

    function ValorUnitarioOriginal : Double; overload;
    function ValorUnitarioOriginal(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorUnitario : Double; overload;
    function ValorUnitario(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDoIcms : Double; overload;
    function ValorDoIcms(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDoDifal : Double; overload;
    function ValorDoDifal(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDoFCP : Double; overload;
    function ValorDoFCP(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function DespesaOperacionalCliente : Double; overload;
    function DespesaOperacionalCliente(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorComissaoTabelaDeitens : Double; overload;
    function ValorComissaoTabelaDeitens(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDoCustoPraticado : Double; overload;
    function ValorDoCustoPraticado(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorCustoDoItem : Double; overload;
    function ValorCustoDoItem(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function OutrosValores : Double; overload;
    function OutrosValores(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ConsiderarMargemDePrecoUltimaCompraNoCalculo : Boolean;overload;
    function ConsiderarMargemDePrecoUltimaCompraNoCalculo(AValue : Boolean ): IParametrosCalculoMargemVenda;overload;

    function ValorUltimaCompraImpostos : Double; overload;
    function ValorUltimaCompraImpostos(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorCalculoImpostosAliquota: Double; overload;
    function ValorCalculoImpostosAliquota(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDoIcmsStParteDaVenda : Double;overload;
    function ValorDoIcmsStParteDaVenda(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorCustoRealFrete: Double; overload;
    function ValorCustoRealFrete(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ConfiguracaoMargemMarkup : String;overload;
    function ConfiguracaoMargemMarkup(AValue : String): IParametrosCalculoMargemVenda ;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoIcms : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoIcms( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemMinima : Double; overload;
    function ValorUnitarioMargemMinima( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioCustoRealComMargemZero : Double; overload;
    function ValorUnitarioCustoRealComMargemZero( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemPraticadaCustoReal : Double; overload;
    function ValorUnitarioMargemPraticadaCustoReal( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemPropostaCustoReal : Double; overload;
    function ValorUnitarioMargemPropostaCustoReal( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemPropostaCusto : Double; overload;
    function ValorUnitarioMargemPropostaCusto( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemPraticadaCusto : Double; overload;
    function ValorUnitarioMargemPraticadaCusto( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoMedio : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoMedio( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioItemMargemPrecoMedio : Double; overload;
    function ValorUnitarioItemMargemPrecoMedio(AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos : Double; overload;
    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioItemMargemProposta : Double; overload;
    function ValorUnitarioItemMargemProposta(AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioItemMargemPraticadaLucro : Double; overload;
    function ValorUnitarioItemMargemPraticadaLucro(AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorMargemIdeal : Double; overload;
    function ValorMargemIdeal(AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function CalcularPrecoIdeal : Boolean; overload;
    function CalcularPrecoIdeal(AValue : Boolean) : IParametrosCalculoMargemVenda; overload;

    function ValorPrecoIdeal : Double; overload;
    function ValorPrecoIdeal(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function AliquotaIcmsPrecoIdeal : Double; overload;
    function AliquotaIcmsPrecoIdeal(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function PrecoMedioPraticado : Double; overload;
    function PrecoMedioPraticado(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorUltimaCompraImpostosPraticado : Double; overload;
    function ValorUltimaCompraImpostosPraticado(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoRealBruta : Double; overload;
    function ValorUnitarioMargemPraticadaCustoRealBruta( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorMargemPraticadaCustoReal : Double; overload;
    function ValorMargemPraticadaCustoReal( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function ValorMargemPropostaCustoReal : Double; overload;
    function ValorMargemPropostaCustoReal( AValue : Double) : IParametrosCalculoMargemVenda;overload;

    function MargemMinimaLiquidaPorPrecoMedio : Boolean; overload;
    function MargemMinimaLiquidaPorPrecoMedio(const AValue : Boolean) : IParametrosCalculoMargemVenda; overload;

    function OutrosValoresValOri : Double; overload;
    function OutrosValoresValOri(AValue : Double) : IParametrosCalculoMargemVenda; overload;
  end;

  IResultadoCalculoMargemVenda = interface
    ['{AD6758BC-368B-4236-A95E-228A94BC1367}']
    function ValorUnitarioMargemMinima: Double; overload;
    function ValorUnitarioMargemMinima(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioCustoRealComMargemZero: Double; overload;
    function ValorUnitarioCustoRealComMargemZero(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoReal: Double; overload;
    function ValorUnitarioMargemPraticadaCustoReal(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCustoReal: Double; overload;
    function ValorUnitarioMargemPropostaCustoReal(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCusto: Double; overload;
    function ValorUnitarioMargemPropostaCusto(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCusto: Double; overload;
    function ValorUnitarioMargemPraticadaCusto(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

//    function ValorImpostosMargemMarkup: Double; overload;
//    function ValorImpostosMargemMarkup(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticada: Double; overload;
    function ValorUnitarioMargemPraticada(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMargemPraticadaSemDespesasOperacionais(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPrecoMedio: Double; overload;
    function ValorUnitarioMargemPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemProposta: Double; overload;
    function ValorUnitarioMargemProposta(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMarkupProposto: Double; overload;
    function ValorUnitarioMarkupProposto(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMarkupPraticado: Double; overload;
    function ValorUnitarioMarkupPraticado(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMarkupPraticadoSemDespesasOperacionais(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoMedio: Double; overload;
    function ValorUnitarioMarkupPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoMedio: Double; overload;
    function ValorUnitarioItemMargemPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioItemMargemProposta: Double; overload;
    function ValorUnitarioItemMargemProposta(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioItemMargemPraticadaLucro: Double; overload;
    function ValorUnitarioItemMargemPraticadaLucro(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorMargemIdeal: Double; overload;
    function ValorMargemIdeal(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPrecoIdeal: Double; overload;
    function ValorUnitarioMargemPrecoIdeal(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMarkupPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaCustoRealBruta : Double; overload;
    function ValorUnitarioMargemPraticadaCustoRealBruta( AValue : Double) : IResultadoCalculoMargemVenda;overload;

    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta : Double; overload;
    function ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta( AValue : Double) : IResultadoCalculoMargemVenda;overload;

    function ValorMargemPraticadaCustoReal : Double; overload;
    function ValorMargemPraticadaCustoReal( AValue : Double) : IResultadoCalculoMargemVenda;overload;

    function ValorMargemPropostaCustoReal : Double; overload;
    function ValorMargemPropostaCustoReal( AValue : Double) : IResultadoCalculoMargemVenda;overload;

    function ValorUnitarioMargemPraticadaCustoRealFrete: Double; overload;
    function ValorUnitarioMargemPraticadaCustoRealFrete(AValue : Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPropostaCustoRealFrete: Double; overload;
    function ValorUnitarioMargemPropostaCustoRealFrete(AValue : Double) : IResultadoCalculoMargemVenda; overload;
  end;

  ICalculoMargemMargemVenda = interface
    ['{255E30DF-302C-4235-91E8-164C9E25365F}']
    function CalculaMargemVenda(const AParametros: IParametrosCalculoMargemVenda): IResultadoCalculoMargemVenda; overload;
  end;

  IResultadoServicosClasseMargemVenda = interface
    ['{D39072BC-78D8-4044-BF0A-1585B5310AF1}']
    function ParametrosCalculoMargemVenda: IParametrosCalculoMargemVenda; overload;
    function ParametrosCalculoMargemVenda(AValue : IParametrosCalculoMargemVenda) : IResultadoServicosClasseMargemVenda; overload;

    function ResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda; overload;
    function ResultadoCalculoMargemVenda(AValue: IResultadoCalculoMargemVenda): IResultadoServicosClasseMargemVenda; overload;
  end;

implementation

end.
