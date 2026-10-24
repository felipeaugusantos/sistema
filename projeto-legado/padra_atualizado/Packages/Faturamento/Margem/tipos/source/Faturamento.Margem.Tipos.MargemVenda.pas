unit Faturamento.Margem.Tipos.MargemVenda;

interface

uses Faturamento.Margem.Interfaces.MargemVenda,
     Shared.Functions.Types;

type
  TParametrosServicoMargemVenda = class(TInterfacedObject, IParametrosServicoMargemVenda)
  strict private
    FClassificacaoFiscal                                              : String;
    FCarregarPedidoOrcamentoEntradaFutura                             : Boolean;
    FImpostosFederais                                                 : Double;
    FPrecoMedio                                                       : Double;
    FCalcularST                                                       : Boolean;
    FPrecoUltimaCompra                                                : Double;
    FValorUnitarioOriginal                                            : Double;
    FValorUnitario                                                    : Double;
    FValorDoIcms                                                      : Double;
    FValorBaseDoIcms                                                  : Double;
    FValorDoDifal                                                     : Double;
    FValorDoFCP                                                       : Double;
    FDespesasOperacionais                                             : Double;
    FDespesaOperacionalCliente                                        : Double;
    FValorComissaoTabelaDeitens                                       : Double;
    FValorDoCustoPraticado                                            : Double;
    FValorCustoDoItem                                                 : Double;
    FOutrosValores                                                    : Double;
    FConsiderarMargemDePrecoUltimaCompraNoCalculo                     : Boolean;
    FValorUltimaCompraImpostos                                        : Double;
    FValorDaSubstituicao                                              : Double;
    FValorDoIcmsStParteDaVenda                                        : Double;
    FConfiguracaoMargemMarkup                                         : String;
    FValorDaAliquotaDiferencaPrecoDinamicoIcms                        : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargem                      : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida               : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargemMedia                 : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos              : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargemItem                  : Double;
    FValorDaAliquotaDiferencaPrecoDinamicoMargemLucro                 : Double;
    FValorUnitarioMargemMinima                                        : Double;
    FValorUnitarioMargemPraticadaCustoReal                            : Double;
    FValorUnitarioMargemPropostaCustoReal                             : Double;
    FValorUnitarioMargemPropostaCusto                                 : Double;
    FValorUnitarioMargemPraticadaCusto                                : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoMedio                      : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedio                    : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra               : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra             : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos    : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos  : Double;
    FValorUnitarioItemMargemPrecoMedio                                : Double;
    FValorUnitarioItemMargemPrecoUltimaCompraComImpostos              : Double;
    FValorUnitarioItemMargemProposta                                  : Double;
    FValorUnitarioItemMargemPraticadaLucro                            : Double;
    FValorMargemIdeal                                                 : Double;
    FCalcularPrecoIdeal                                               : Boolean;
    FValorPrecoIdeal                                                  : Double;
    FAliquotaIcmsPrecoIdeal                                           : Double;
    FValorCalculoImpostosAliquota                                     : Double;
    FValorCat17                                                       : Double;
    FValorMargemCat17                                                 : Double;
    FPrecoMedioPraticado                                              : Double;
    FValorUltimaCompraImpostosPraticado                               : Double;
    FValorUnitarioMargemPraticadaCustoRealBruta                       : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta               : Double;
    FValorMargemPraticadaCustoReal                                    : Double;
    FValorMargemPropostaCustoReal                                     : Double;
    FValorCustoRealPraticado                                          : Double;
    FMargemMinimaLiquidaPorPrecoMedio : Boolean;
    FOutrosValoresValOri : Double;
  public
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

    function ValorCalculoImpostosAliquota: Double; overload;
    function ValorCalculoImpostosAliquota(AValue : Double) : IParametrosServicoMargemVenda; overload;

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

    function ConfiguracaoMargemMarkup : String;overload;
    function ConfiguracaoMargemMarkup(AValue : String): IParametrosServicoMargemVenda ;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoIcms : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoIcms( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargem : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicomargem( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicomargemLiquida( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemItem : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemItem( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro : Double; overload;
    function ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro( AValue : Double) : IParametrosServicoMargemVenda;overload;

    function ValorCat17: Double; overload;
    function ValorCat17(AValue : Double) : IParametrosServicoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IParametrosServicoMargemVenda; overload;

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

    class function New(): IParametrosServicoMargemVenda;
  end;

type
  TParametrosCalculoMargemVenda = class(TInterfacedObject, IParametrosCalculoMargemVenda)
  strict private
    FImpostosFederais                                                : Double;
    FPrecoMedio                                                      : Double;
    FValorCalculoImpostosAliquota                                    : Double;
    FCalcularST                                                      : Boolean;
    FValorUnitarioOriginal                                           : Double;
    FValorUnitario                                                   : Double;
    FValorDoIcms                                                     : Double;
    FValorDoDifal                                                    : Double;
    FValorDoFCP                                                      : Double;
    FDespesasOperacionais                                            : Double;
    FDespesaOperacionalCliente                                       : Double;
    FValorComissaoTabelaDeitens                                      : Double;
    FValorDoCustoPraticado                                           : Double;
    FValorCustoDoItem                                                : Double;
    FOutrosValores                                                   : Double;
    FValorUltimaCompraImpostos                                       : Double;
    FConsiderarMargemDePrecoUltimaCompraNoCalculo                    : Boolean;
    FValorDoIcmsStParteDaVenda                                       : Double;
    FConfiguracaoMargemMarkup                                        : String;
    FValorDaAliquotaDiferencaPrecoDinamicoIcms                       : Double;
    FValorUnitarioMargemMinima                                       : Double;
    FValorUnitarioCustoRealComMargemZero                             : Double;
    FValorUnitarioMargemPraticadaCustoReal                           : Double;
    FValorUnitarioMargemPropostaCustoReal                            : Double;
    FValorUnitarioMargemPropostaCusto                                : Double;
    FValorUnitarioMargemPraticadaCusto                               : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoMedio                     : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedio                   : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra              : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra            : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos   : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos : Double;
    FValorUnitarioItemMargemPrecoMedio                               : Double;
    FValorUnitarioItemMargemPrecoUltimaCompraComImpostos             : Double;
    FValorUnitarioItemMargemProposta                                 : Double;
    FValorUnitarioItemMargemPraticadaLucro                           : Double;
    FValorMargemIdeal                                                : Double;
    FCalcularPrecoIdeal                                              : Boolean;
    FValorPrecoIdeal                                                 : Double;
    FAliquotaIcmsPrecoIdeal                                          : Double;
    FValorMargemCat17                                                : Double;
    FPrecoMedioPraticado                                             : Double;
    FValorUltimaCompraImpostosPraticado                              : Double;
    FValorUnitarioMargemPraticadaCustoRealBruta                      : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta              : Double;
    FValorMargemPraticadaCustoReal                                   : Double;
    FValorMargemPropostaCustoReal                                    : Double;
    FValorCustoRealFrete                                             : Double;
    FMargemMinimaLiquidaPorPrecoMedio : Boolean;
    FOutrosValoresValOri : Double;
  public
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

    function ValorDoIcmsStParteDaVenda : Double;overload;
    function ValorDoIcmsStParteDaVenda(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ConfiguracaoMargemMarkup : String;overload;
    function ConfiguracaoMargemMarkup(AValue : String): IParametrosCalculoMargemVenda ;overload;

    function ValorCalculoImpostosAliquota: Double; overload;
    function ValorCalculoImpostosAliquota(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function ValorDaAliquotaDiferencaPrecoDinamicoIcms : Double;overload;
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

    function ValorCustoRealFrete: Double; overload;
    function ValorCustoRealFrete(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    function MargemMinimaLiquidaPorPrecoMedio : Boolean; overload;
    function MargemMinimaLiquidaPorPrecoMedio(const AValue : Boolean) : IParametrosCalculoMargemVenda; overload;

    function OutrosValoresValOri : Double; overload;
    function OutrosValoresValOri(AValue : Double) : IParametrosCalculoMargemVenda; overload;

    class function New(): IParametrosCalculoMargemVenda;
  end;

type
  TResultadoCalculoMargemVenda = class(TInterfacedObject, IResultadoCalculoMargemVenda)
  strict private
    FValorUnitarioMargemMinima                                : Double;
    FValorUnitarioCustoRealComMargemZero                                 : Double;
    FValorUnitarioMargemPraticadaCustoReal                   : Double;
    FValorUnitarioMargemPropostaCustoReal                : Double;
    FValorUnitarioMargemPropostaCusto                     : Double;
    FValorUnitarioMargemPraticadaCusto                    : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoMedio                       : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedio                     : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra              : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra            : Double;
    FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos   : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos : Double;
    FValorUnitarioMargemPraticada                             : Double;
    FValorUnitarioMargemPraticadaSemDespesasOperacionais               : Double;
    FValorUnitarioMargemPrecoMedio                                 : Double;
    FValorUnitarioMargemPrecoUltimaCompraComImpostos                     : Double;
    FValorUnitarioMargemProposta                                : Double;
    FValorUnitarioMarkupProposto                                   : Double;
    FValorUnitarioMarkupPraticado                                   : Double;
    FValorUnitarioMarkupPraticadoSemDespesasOperacionais                                : Double;
    FValorUnitarioMarkupPrecoMedio                                   : Double;
    FValorUnitarioItemMargemPrecoMedio                           : Double;
    FValorUnitarioItemMargemPrecoUltimaCompraComImpostos                         : Double;
    FValorUnitarioItemMargemProposta                                : Double;
    FValorUnitarioItemMargemPraticadaLucro                           : Double;
    FValorMargemIdeal                                 : Double;
    FValorUnitarioMargemPrecoIdeal                    : Double;
    FValorMargemCat17                                 : Double;
    FValorUnitarioMarkupPrecoUltimaCompraComImpostos                                : Double;
    FValorUnitarioMargemPraticadaCustoRealBruta                      : Double;
    FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta              : Double;
    FValorMargemPraticadaCustoReal                                    : Double;
    FValorMargemPropostaCustoReal                                     : Double;
    FValorUnitarioMargemPraticadaCustoRealFrete                       : Double;
    FValorUnitarioMargemPropostaCustoRealFrete                        : Double;
  public
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

    function ValorUnitarioMargemPraticada: Double; overload;
    function ValorUnitarioMargemPraticada(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double; overload;
    function ValorUnitarioMargemPraticadaSemDespesasOperacionais(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPrecoMedio: Double; overload;
    function ValorUnitarioMargemPrecoMedio(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double; overload;
    function ValorUnitarioMargemPrecoUltimaCompraComImpostos(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorUnitarioMargemProposta: Double; overload;
    function ValorUnitarioMargemProposta(AValue: Double) : IResultadoCalculoMargemVenda; overload;

    function ValorMargemCat17: Double; overload;
    function ValorMargemCat17(AValue: Double) : IResultadoCalculoMargemVenda; overload;

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
    function ValorUnitarioMargemPraticadaCustoRealBruta( AValue : Double) : IResultadoCalculoMargemVenda; overload;

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

    class function New(): IResultadoCalculoMargemVenda;
  end;

type
  TResultadoServicosClasseMargemVenda = class(TInterfacedObject, IResultadoServicosClasseMargemVenda)
  strict private
    FParametrosCalculoMargemVenda     : IParametrosCalculoMargemVenda;
    FResultadoCalculoMargemVenda      : IResultadoCalculoMargemVenda;
  public
    function ParametrosCalculoMargemVenda  : IParametrosCalculoMargemVenda; overload;
    function ParametrosCalculoMargemVenda(AValue : IParametrosCalculoMargemVenda) : IResultadoServicosClasseMargemVenda; overload;

    function ResultadoCalculoMargemVenda : IResultadoCalculoMargemVenda; overload;
    function ResultadoCalculoMargemVenda(AValue : IResultadoCalculoMargemVenda) :IResultadoServicosClasseMargemVenda; overload;

    class function New(): IResultadoServicosClasseMargemVenda;
  end;

implementation

function TParametrosCalculoMargemVenda.CalcularST: Boolean;
begin
  result := FCalcularST;
end;

function TParametrosCalculoMargemVenda.AliquotaIcmsPrecoIdeal: Double;
begin
  result := FAliquotaIcmsPrecoIdeal;
end;

function TParametrosCalculoMargemVenda.AliquotaIcmsPrecoIdeal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FAliquotaIcmsPrecoIdeal := AValue;
end;

function TParametrosCalculoMargemVenda.CalcularPrecoIdeal: Boolean;
begin
  result := FCalcularPrecoIdeal;
end;

function TParametrosCalculoMargemVenda.CalcularPrecoIdeal(
  AValue: Boolean): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FCalcularPrecoIdeal := AValue;
end;

function TParametrosCalculoMargemVenda.CalcularST(
  AValue: Boolean): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FCalcularST := AValue;
end;

function TParametrosCalculoMargemVenda.ConfiguracaoMargemMarkup: String;
begin
  Result := FConfiguracaoMargemMarkup;
end;

function TParametrosCalculoMargemVenda.ConfiguracaoMargemMarkup(
  AValue: String): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FConfiguracaoMargemMarkup := AValue;
end;

function TParametrosCalculoMargemVenda.ConsiderarMargemDePrecoUltimaCompraNoCalculo(
  AValue: Boolean): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FConsiderarMargemDePrecoUltimaCompraNoCalculo := AValue;
end;

function TParametrosCalculoMargemVenda.ConsiderarMargemDePrecoUltimaCompraNoCalculo: Boolean;
begin
  result := FConsiderarMargemDePrecoUltimaCompraNoCalculo;
end;

function TParametrosCalculoMargemVenda.DespesaOperacionalCliente(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FDespesaOperacionalCliente := AValue;
end;

function TParametrosCalculoMargemVenda.DespesaOperacionalCliente: Double;
begin
  result := FDespesaOperacionalCliente;
end;

function TParametrosCalculoMargemVenda.DespesasOperacionais: Double;
begin
  result := FDespesasOperacionais;
end;

function TParametrosCalculoMargemVenda.DespesasOperacionais(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FDespesasOperacionais := AValue;
end;


function TParametrosCalculoMargemVenda.ImpostosFederais: Double;
begin
  result := FImpostosFederais;
end;

function TParametrosCalculoMargemVenda.ImpostosFederais(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FImpostosFederais := AValue;
end;


function TParametrosCalculoMargemVenda.MargemMinimaLiquidaPorPrecoMedio: Boolean;
begin
  Result := FMargemMinimaLiquidaPorPrecoMedio;
end;

function TParametrosCalculoMargemVenda.MargemMinimaLiquidaPorPrecoMedio(
  const AValue: Boolean): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FMargemMinimaLiquidaPorPrecoMedio := AValue;
end;

class function TParametrosCalculoMargemVenda.New: IParametrosCalculoMargemVenda;
begin
  Result := Self.Create;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos: Double;
begin
  Result := FValorUnitarioMarkupPrecoUltimaCompraComImpostos;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoUltimaCompraComImpostos(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPrecoUltimaCompraComImpostos := AValue;
end;

class function TResultadoCalculoMargemVenda.New: IResultadoCalculoMargemVenda;
begin
  Result := Self.Create;
end;

class function TResultadoServicosClasseMargemVenda.New: IResultadoServicosClasseMargemVenda;
begin
  Result := Self.Create;
end;

function TParametrosServicoMargemVenda.AliquotaIcmsPrecoIdeal: Double;
begin
  result := FAliquotaIcmsPrecoIdeal;
end;

function TParametrosServicoMargemVenda.AliquotaIcmsPrecoIdeal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FAliquotaIcmsPrecoIdeal := AValue;
end;

function TParametrosServicoMargemVenda.CalcularPrecoIdeal: Boolean;
begin
  result := FCalcularPrecoIdeal;
end;

function TParametrosServicoMargemVenda.CalcularPrecoIdeal(
  AValue: Boolean): IParametrosServicoMargemVenda;
begin
  result := Self;
  FCalcularPrecoIdeal := AValue;
end;

function TParametrosServicoMargemVenda.CalcularST(
  AValue: Boolean): IParametrosServicoMargemVenda;
begin
  result := Self;
  FCalcularST := AValue;
end;

function TParametrosServicoMargemVenda.CalcularST: Boolean;
begin
  result := FCalcularST;
end;

function TParametrosServicoMargemVenda.CarregarPedidoOrcamentoEntradaFutura: Boolean;
begin
  result := FCarregarPedidoOrcamentoEntradaFutura;
end;

function TParametrosServicoMargemVenda.CarregarPedidoOrcamentoEntradaFutura(
  AValue: Boolean): IParametrosServicoMargemVenda;
begin
  result := Self;
  FCarregarPedidoOrcamentoEntradaFutura := AValue;
end;

function TParametrosServicoMargemVenda.ClassificacaoFiscal(
  AValue: String): IParametrosServicoMargemVenda;
begin
  result := Self;
  FClassificacaoFiscal := AValue;
end;

function TParametrosServicoMargemVenda.ClassificacaoFiscal: String;
begin
  result := FClassificacaoFiscal;
end;

function TParametrosServicoMargemVenda.ConfiguracaoMargemMarkup(
  AValue: String): IParametrosServicoMargemVenda;
begin
  result := Self;
  FConfiguracaoMargemMarkup := AValue;
end;

function TParametrosServicoMargemVenda.ConfiguracaoMargemMarkup: String;
begin
  result := FConfiguracaoMargemMarkup;
end;

function TParametrosServicoMargemVenda.ConsiderarMargemDePrecoUltimaCompraNoCalculo(
  AValue: Boolean): IParametrosServicoMargemVenda;
begin
  result := Self;
  FConsiderarMargemDePrecoUltimaCompraNoCalculo := AValue;
end;

function TParametrosServicoMargemVenda.ConsiderarMargemDePrecoUltimaCompraNoCalculo: Boolean;
begin
  result := FConsiderarMargemDePrecoUltimaCompraNoCalculo;
end;

function TParametrosServicoMargemVenda.DespesaOperacionalCliente(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FDespesaOperacionalCliente := AValue;
end;

function TParametrosServicoMargemVenda.DespesaOperacionalCliente: Double;
begin
  result := FDespesaOperacionalCliente;
end;

function TParametrosServicoMargemVenda.DespesasOperacionais(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FDespesasOperacionais := AValue;
end;

function TParametrosServicoMargemVenda.DespesasOperacionais: Double;
begin
  result := FDespesasOperacionais;
end;

function TParametrosServicoMargemVenda.ImpostosFederais(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FImpostosFederais := AValue;
end;

function TParametrosServicoMargemVenda.MargemMinimaLiquidaPorPrecoMedio: Boolean;
begin
  Result := FMargemMinimaLiquidaPorPrecoMedio;
end;

function TParametrosServicoMargemVenda.MargemMinimaLiquidaPorPrecoMedio(
  const AValue: Boolean): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FMargemMinimaLiquidaPorPrecoMedio := AValue;
end;

function TParametrosServicoMargemVenda.ImpostosFederais: Double;
begin
  result := FImpostosFederais;
end;

class function TParametrosServicoMargemVenda.New: IParametrosServicoMargemVenda;
begin
  Result := Self.Create;
end;

function TResultadoServicosClasseMargemVenda.ParametrosCalculoMargemVenda(
  AValue: IParametrosCalculoMargemVenda): IResultadoServicosClasseMargemVenda;
begin
  result := Self;
  FParametrosCalculoMargemVenda := Avalue;
end;

function TResultadoServicosClasseMargemVenda.ParametrosCalculoMargemVenda: IParametrosCalculoMargemVenda;
begin
  Result := FParametrosCalculoMargemVenda;
end;

function TResultadoServicosClasseMargemVenda.ResultadoCalculoMargemVenda(
  AValue: IResultadoCalculoMargemVenda): IResultadoServicosClasseMargemVenda;
begin
  result := Self;
  FResultadoCalculoMargemVenda := AValue;
end;

function TResultadoServicosClasseMargemVenda.ResultadoCalculoMargemVenda: IResultadoCalculoMargemVenda;
begin
  result := FResultadoCalculoMargemVenda;
end;

function TParametrosCalculoMargemVenda.OutrosValores: Double;
begin
  result := FOutrosValores;
end;

function TParametrosCalculoMargemVenda.OutrosValores(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FOutrosValores := Avalue;
end;

function TParametrosCalculoMargemVenda.OutrosValoresValOri: Double;
begin
  Result := FOutrosValoresValOri;
end;

function TParametrosCalculoMargemVenda.OutrosValoresValOri(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FOutrosValoresValOri := AValue;
end;

function TParametrosCalculoMargemVenda.PrecoMedio: Double;
begin
  result := FPrecoMedio;
end;

function TParametrosCalculoMargemVenda.PrecoMedio(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FPrecoMedio := AValue;
end;

function TParametrosCalculoMargemVenda.ValorComissaoTabelaDeitens: Double;
begin
  result := FValorComissaoTabelaDeitens;
end;

function TParametrosCalculoMargemVenda.ValorComissaoTabelaDeitens(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorComissaoTabelaDeitens := AValue;
end;

function TParametrosCalculoMargemVenda.ValorCustoDoItem: Double;
begin
  result := FValorCustoDoItem;
end;

function TParametrosCalculoMargemVenda.ValorCustoDoItem(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorCustoDoItem := AValue;
end;

function TParametrosCalculoMargemVenda.ValorCustoRealFrete: Double;
begin
  Result := FValorCustoRealFrete;
end;

function TParametrosCalculoMargemVenda.ValorCustoRealFrete(AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorCustoRealFrete := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero: Double;
begin
  result := FValorUnitarioCustoRealComMargemZero;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioCustoRealComMargemZero := AValue;
end;

function TParametrosCalculoMargemVenda.ValorCalculoImpostosAliquota: Double;
begin
  result := FValorCalculoImpostosAliquota;
end;

function TParametrosCalculoMargemVenda.ValorCalculoImpostosAliquota(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorCalculoImpostosAliquota:= AValue;
end;

function TParametrosCalculoMargemVenda.ValorMargemCat17(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorMargemCat17 := AValue;
end;

function TParametrosCalculoMargemVenda.ValorMargemCat17: Double;
begin
  result := FValorMargemCat17;
end;

function TParametrosCalculoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoIcms: Double;
begin
  Result := FValorDaAliquotaDiferencaPrecoDinamicoIcms;
end;

function TParametrosCalculoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoIcms(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoIcms := AValue;
end;

function TParametrosCalculoMargemVenda.ValorDoCustoPraticado(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorDoCustoPraticado := AValue;
end;

function TParametrosCalculoMargemVenda.ValorDoCustoPraticado: Double;
begin
  result := FValorDoCustoPraticado;
end;

function TParametrosCalculoMargemVenda.ValorDoDifal: Double;
begin
  result := FValorDoDifal;
end;

function TParametrosCalculoMargemVenda.ValorDoDifal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorDoDifal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorDoFCP(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorDoFCP := AValue;
end;

function TParametrosCalculoMargemVenda.ValorDoFCP: Double;
begin
  result := FValorDoFCP;
end;

function TParametrosCalculoMargemVenda.ValorDoIcms(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorDoIcms := AValue;
end;



function TParametrosCalculoMargemVenda.ValorDoIcmsStParteDaVenda: Double;
begin
  result := FValorDoIcmsStParteDaVenda;
end;

function TParametrosCalculoMargemVenda.ValorDoIcmsStParteDaVenda(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorDoIcmsStParteDaVenda := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  Result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoMedio;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoMedio := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemProposta(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemProposta := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemProposta: Double;
begin
  result := FValorUnitarioItemMargemProposta;
end;

function TParametrosCalculoMargemVenda.ValorMargemIdeal: Double;
begin
  result := FValorMargemIdeal;
end;

function TParametrosCalculoMargemVenda.ValorMargemIdeal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorMargemIdeal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorMargemPraticadaCustoReal: Double;
begin
  Result := FValorMargemPraticadaCustoReal;
end;

function TParametrosCalculoMargemVenda.ValorMargemPraticadaCustoReal(AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorMargemPraticadaCustoReal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorMargemPropostaCustoReal: Double;
begin
  Result := FValorMargemPropostaCustoReal;
end;

function TParametrosCalculoMargemVenda.ValorMargemPropostaCustoReal(AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorMargemPropostaCustoReal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra := Avalue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoMedio;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedio := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta: Double;
begin
  Result := FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta := Avalue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro: Double;
begin
  result := FValorUnitarioItemMargemPraticadaLucro;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPraticadaLucro := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemMinima: Double;
begin
  result := FValorUnitarioMargemMinima;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio: Double;
begin
  result := FValorUnitarioItemMargemPrecoMedio;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioItemMargemPrecoMedio := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemMinima(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemMinima := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto: Double;
begin
  result := FValorUnitarioMargemPraticadaCusto;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPraticadaCusto := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal: Double;
begin
  result := FValorUnitarioMargemPraticadaCustoReal;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCustoReal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta: Double;
begin
  Result := FValorUnitarioMargemPraticadaCustoRealBruta;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPraticadaCustoRealBruta := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPropostaCusto(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCusto := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPropostaCusto: Double;
begin
  result := FValorUnitarioMargemPropostaCusto;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal: Double;
begin
  result := FValorUnitarioMargemPropostaCustoReal;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCustoReal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorPrecoIdeal: Double;
begin
  result := FValorPrecoIdeal;
end;

function TParametrosCalculoMargemVenda.ValorPrecoIdeal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := Self;
  FValorPrecoIdeal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorDoIcms: Double;
begin
  result := FValorDoIcms;
end;

function TParametrosCalculoMargemVenda.ValorUltimaCompraImpostos: Double;
begin
  result := FValorUltimaCompraImpostos;
end;

function TParametrosCalculoMargemVenda.ValorUltimaCompraImpostos(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUltimaCompraImpostos := AValue;
end;

function TParametrosCalculoMargemVenda.PrecoMedioPraticado: Double;
begin
  Result := FPrecoMedioPraticado;
end;

function TParametrosCalculoMargemVenda.PrecoMedioPraticado(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FPrecoMedioPraticado := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUltimaCompraImpostosPraticado: Double;
begin
  Result := FValorUltimaCompraImpostosPraticado;
end;

function TParametrosCalculoMargemVenda.ValorUltimaCompraImpostosPraticado(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorUltimaCompraImpostosPraticado := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitario(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  result := self;
  FValorUnitario := Avalue;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioOriginal: Double;
begin
  Result := FValorUnitarioOriginal;
end;

function TParametrosCalculoMargemVenda.ValorUnitarioOriginal(
  AValue: Double): IParametrosCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioOriginal := AValue;
end;

function TParametrosCalculoMargemVenda.ValorUnitario: Double;
begin
  result := FValorUnitario;
end;


function TResultadoCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioCustoRealComMargemZero := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioCustoRealComMargemZero: Double;
begin
  Result := FValorUnitarioCustoRealComMargemZero;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoIdeal: Double;
begin
  Result := FValorUnitarioMargemPrecoIdeal;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoIdeal(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPrecoIdeal := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemProposta(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemProposta := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemProposta: Double;
begin
  result := FValorUnitarioMargemProposta;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoMedio := AValue;
end;

function TResultadoCalculoMargemVenda.ValorMargemCat17: Double;
begin
  result := FValorMargemCat17;
end;

function TResultadoCalculoMargemVenda.ValorMargemCat17(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorMargemCat17 := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoMedio;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemProposta: Double;
begin
  result := FValorUnitarioItemMargemProposta;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemProposta(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemProposta := AValue;
end;

function TResultadoCalculoMargemVenda.ValorMargemIdeal: Double;
begin
  result := FValorMargemIdeal;
end;

function TResultadoCalculoMargemVenda.ValorMargemIdeal(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorMargemIdeal := AValue;

end;

function TResultadoCalculoMargemVenda.ValorMargemPraticadaCustoReal: Double;
begin
  Result := FValorMargemPraticadaCustoReal;
end;

function TResultadoCalculoMargemVenda.ValorMargemPraticadaCustoReal(AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorMargemPraticadaCustoReal := AValue;
end;

function TResultadoCalculoMargemVenda.ValorMargemPropostaCustoReal: Double;
begin
  Result := FValorMargemPropostaCustoReal;
end;

function TResultadoCalculoMargemVenda.ValorMargemPropostaCustoReal(AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorMargemPropostaCustoReal := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoUltimaCompraComImpostos := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double;
begin
  Result := FValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedio := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta: Double;
begin
  Result := FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta := Avalue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoMedio;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro: Double;
begin
  result := FValorUnitarioItemMargemPraticadaLucro;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPraticadaLucro(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPraticadaLucro := Avalue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoMedio: Double;
begin
  result := FValorUnitarioMargemPrecoMedio;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoMedio(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPrecoMedio := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio: Double;
begin
  result := FValorUnitarioItemMargemPrecoMedio;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioItemMargemPrecoMedio(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoMedio := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemMinima(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemMinima := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemMinima: Double;
begin
  result := FValorUnitarioMargemMinima;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticada: Double;
begin
  Result := FValorUnitarioMargemPraticada;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticada(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPraticada := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto: Double;
begin
  result := FValorUnitarioMargemPraticadaCusto;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCusto(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCusto := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCustoReal := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta: Double;
begin
  Result := FValorUnitarioMargemPraticadaCustoRealBruta;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPraticadaCustoRealBruta := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealFrete: Double;
begin
  Result := FValorUnitarioMargemPraticadaCustoRealFrete;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoRealFrete(AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPraticadaCustoRealFrete := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaCustoReal: Double;
begin
  result := FValorUnitarioMargemPraticadaCustoReal;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemPrecoUltimaCompraComImpostos;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPrecoUltimaCompraComImpostos := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCusto(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCusto := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCusto: Double;
begin
  result := FValorUnitarioMargemPropostaCusto;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCustoReal := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoRealFrete: Double;
begin
  Result := FValorUnitarioMargemPropostaCustoRealFrete;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoRealFrete(AValue: Double): IResultadoCalculoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPropostaCustoRealFrete := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPropostaCustoReal: Double;
begin
  result := FValorUnitarioMargemPropostaCustoReal;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := self;
  FValorUnitarioMargemPraticadaSemDespesasOperacionais := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMargemPraticadaSemDespesasOperacionais: Double;
begin
  result := FValorUnitarioMargemPraticadaSemDespesasOperacionais;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoMedio: Double;
begin
  result := FValorUnitarioMarkupPrecoMedio;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPrecoMedio(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPrecoMedio := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticado: Double;
begin
  result := FValorUnitarioMarkupPraticado;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticado(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPraticado := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais: Double;
begin
  result := FValorUnitarioMarkupPraticadoSemDespesasOperacionais;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupPraticadoSemDespesasOperacionais(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupPraticadoSemDespesasOperacionais := AValue;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupProposto: Double;
begin
  result := FValorUnitarioMarkupProposto;
end;

function TResultadoCalculoMargemVenda.ValorUnitarioMarkupProposto(
  AValue: Double): IResultadoCalculoMargemVenda;
begin
  result := Self;
  FValorUnitarioMarkupProposto := AValue;
end;

function TParametrosServicoMargemVenda.OutrosValores(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FOutrosValores := AValue;
end;

function TParametrosServicoMargemVenda.OutrosValoresValOri: Double;
begin
  Result := FOutrosValoresValOri;
end;

function TParametrosServicoMargemVenda.OutrosValoresValOri(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FOutrosValoresValOri := AValue;
end;

function TParametrosServicoMargemVenda.OutrosValores: Double;
begin
  result := FOutrosValores;
end;

function TParametrosServicoMargemVenda.PrecoMedio(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FPrecoMedio := AValue;
end;


function TParametrosServicoMargemVenda.PrecoUltimaCompra: Double;
begin
  Result := FPrecoUltimaCompra;
end;

function TParametrosServicoMargemVenda.PrecoUltimaCompra(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FPrecoUltimaCompra := AValue;
end;

function TParametrosServicoMargemVenda.PrecoMedio: Double;
begin
  result := FPrecoMedio;
end;

function TParametrosServicoMargemVenda.ValorComissaoTabelaDeitens: Double;
begin
  result := FValorComissaoTabelaDeitens;
end;

function TParametrosServicoMargemVenda.ValorCalculoImpostosAliquota: Double;
begin
  result := FValorCalculoImpostosAliquota;
end;

function TParametrosServicoMargemVenda.ValorCalculoImpostosAliquota(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorCalculoImpostosAliquota := AValue;
end;

function TParametrosServicoMargemVenda.ValorCat17(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := self;
  FValorCat17 := AValue;
end;

function TParametrosServicoMargemVenda.ValorCat17: Double;
begin
  result := FValorCat17;
end;

function TParametrosServicoMargemVenda.ValorComissaoTabelaDeitens(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorComissaoTabelaDeitens := AValue;
end;

function TParametrosServicoMargemVenda.ValorCustoDoItem: Double;
begin
  result := FValorCustoDoItem;
end;

function TParametrosServicoMargemVenda.ValorCustoDoItem(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorCustoDoItem := AValue;
end;

function TParametrosServicoMargemVenda.ValorCustoRealPraticado: Double;
begin
  Result := FValorCustoRealPraticado;
end;

function TParametrosServicoMargemVenda.ValorCustoRealPraticado(AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorCustoRealPraticado := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoIcms: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoIcms;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoIcms(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoIcms := AValue;
end;


function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargem: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoMargem;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargem(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargem := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos: Double;
begin
  Result := FValorDaAliquotaDiferencaPrecoDinamicoMargemImpostos;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemItem(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargemItem := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemItem: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoMargemItem;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargemLiquida := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargemLucro := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemLucro: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoMargemLucro;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia: Double;
begin
  result := FValorDaAliquotaDiferencaPrecoDinamicoMargemMedia;
end;

function TParametrosServicoMargemVenda.ValorDaAliquotaDiferencaPrecoDinamicoMargemMedia(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaAliquotaDiferencaPrecoDinamicoMargemMedia := AValue;
end;

function TParametrosServicoMargemVenda.ValorDaSubstituicao: Double;
begin
  result := FValorDaSubstituicao;
end;

function TParametrosServicoMargemVenda.ValorDaSubstituicao(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDaSubstituicao := Avalue;
end;

function TParametrosServicoMargemVenda.ValorDoCustoPraticado(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDoCustoPraticado := AValue;
end;

function TParametrosServicoMargemVenda.ValorDoCustoPraticado: Double;
begin
  result := FValorDoCustoPraticado;
end;

function TParametrosServicoMargemVenda.ValorDoDifal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDoDifal := AValue;
end;

function TParametrosServicoMargemVenda.ValorDoDifal: Double;
begin
  result := FValorDoDifal;
end;

function TParametrosServicoMargemVenda.ValorDoFCP: Double;
begin
  result := FValorDoFCP;
end;

function TParametrosServicoMargemVenda.ValorDoFCP(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDoFCP := AValue;
end;

function TParametrosServicoMargemVenda.ValorDoIcms(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDoIcms := AValue;
end;

function TParametrosServicoMargemVenda.ValorDoIcms: Double;
begin
  result := FValorDoIcms;
end;

function TParametrosServicoMargemVenda.ValorBaseDoIcms(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorBaseDoIcms := AValue;
end;

function TParametrosServicoMargemVenda.ValorBaseDoIcms: Double;
begin
  result := FValorBaseDoIcms;
end;


function TParametrosServicoMargemVenda.ValorDoIcmsStParteDaVenda: Double;
begin
  result := FValorDoIcmsStParteDaVenda;
end;

function TParametrosServicoMargemVenda.ValorDoIcmsStParteDaVenda(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorDoIcmsStParteDaVenda := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompra := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos := Avalue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemBrutaPraticadaPrecoMedio;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemBrutaPraticadaPrecoMedio(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemBrutaPraticadaPrecoMedio := AValue;
end;

function TParametrosServicoMargemVenda.ValorMargemCat17: Double;
begin
  result := FValorMargemCat17;
end;

function TParametrosServicoMargemVenda.ValorMargemCat17(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorMargemCat17 := Avalue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemProposta(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemProposta := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemProposta: Double;
begin
  result := FValorUnitarioItemMargemProposta;
end;

function TParametrosServicoMargemVenda.ValorMargemIdeal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorMargemIdeal := AValue;
end;

function TParametrosServicoMargemVenda.ValorMargemPraticadaCustoReal: Double;
begin
  Result := FValorMargemPraticadaCustoReal;
end;

function TParametrosServicoMargemVenda.ValorMargemPraticadaCustoReal(AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorMargemPraticadaCustoReal := AValue;
end;

function TParametrosServicoMargemVenda.ValorMargemPropostaCustoReal: Double;
begin
  Result := FValorMargemPropostaCustoReal;
end;

function TParametrosServicoMargemVenda.ValorMargemPropostaCustoReal(AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorMargemPropostaCustoReal := AValue;
end;

function TParametrosServicoMargemVenda.ValorMargemIdeal: Double;
begin
  result := FValorMargemIdeal;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoUltimaCompraComImpostos := Avalue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioItemMargemPrecoUltimaCompraComImpostos;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompra := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoUltimaCompraComImpostos := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio: Double;
begin
  result := FValorUnitarioMargemLiquidaPraticadaPrecoMedio;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedio(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedio := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta: Double;
begin
  Result := FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemLiquidaPraticadaPrecoMedioBruta := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPraticadaLucro: Double;
begin
  result := FValorUnitarioItemMargemPraticadaLucro;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPraticadaLucro(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPraticadaLucro := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPrecoMedio(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioItemMargemPrecoMedio := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioItemMargemPrecoMedio: Double;
begin
  result := FValorUnitarioItemMargemPrecoMedio;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemMinima(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemMinima := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemMinima: Double;
begin
  result := FValorUnitarioMargemMinima;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCusto: Double;
begin
  result := FValorUnitarioMargemPraticadaCusto;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCusto(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCusto := Avalue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCustoReal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPraticadaCustoReal := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta: Double;
begin
  Result := FValorUnitarioMargemPraticadaCustoRealBruta;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCustoRealBruta(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorUnitarioMargemPraticadaCustoRealBruta := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPraticadaCustoReal: Double;
begin
  result := FValorUnitarioMargemPraticadaCustoReal;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPropostaCusto(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCusto := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPropostaCusto: Double;
begin
  result := FValorUnitarioMargemPropostaCusto;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPropostaCustoReal: Double;
begin
  result := FValorUnitarioMargemPropostaCustoReal;
end;

function TParametrosServicoMargemVenda.ValorUnitarioMargemPropostaCustoReal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioMargemPropostaCustoReal := AValue;
end;

function TParametrosServicoMargemVenda.ValorPrecoIdeal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorPrecoIdeal:= Avalue;
end;

function TParametrosServicoMargemVenda.ValorPrecoIdeal: Double;
begin
  result := FValorPrecoIdeal;
end;

function TParametrosServicoMargemVenda.ValorUltimaCompraImpostos(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUltimaCompraImpostos := AValue;
end;

function TParametrosServicoMargemVenda.PrecoMedioPraticado: Double;
begin
  Result := FPrecoMedioPraticado;
end;

function TParametrosServicoMargemVenda.PrecoMedioPraticado(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FPrecoMedioPraticado := AValue;
end;

function TParametrosServicoMargemVenda.ValorUltimaCompraImpostosPraticado: Double;
begin
  Result := FValorUltimaCompraImpostosPraticado;
end;

function TParametrosServicoMargemVenda.ValorUltimaCompraImpostosPraticado(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  Result := Self;
  FValorUltimaCompraImpostosPraticado := AValue;
end;

function TParametrosServicoMargemVenda.ValorUltimaCompraImpostos: Double;
begin
  result := FValorUltimaCompraImpostos;
end;

function TParametrosServicoMargemVenda.ValorUnitario: Double;
begin
  result := FValorUnitario;
end;

function TParametrosServicoMargemVenda.ValorUnitario(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitario := AValue;
end;

function TParametrosServicoMargemVenda.ValorUnitarioOriginal: Double;
begin
  result := FValorUnitarioOriginal;
end;

function TParametrosServicoMargemVenda.ValorUnitarioOriginal(
  AValue: Double): IParametrosServicoMargemVenda;
begin
  result := Self;
  FValorUnitarioOriginal := AValue;
end;

end.
