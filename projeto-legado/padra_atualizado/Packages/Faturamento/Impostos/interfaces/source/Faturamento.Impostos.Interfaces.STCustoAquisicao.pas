unit Faturamento.Impostos.Interfaces.STCustoAquisicao;

interface

type
  IParametrosCalculoSTCustoAquisicao = interface
    ['{77CA7707-CA61-41BA-86E9-8710AB8F2CAA}']

    function VendaDentroDoEstado: Boolean; overload;
    function VendaDentroDoEstado(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function SubstituicaoTributaria: Boolean; overload;
    function SubstituicaoTributaria(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;

    function PrecoDeCompraComDescontos: Double; overload;
    function PrecoDeCompraComDescontos(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function ModeloCalculoSubstituicaoDeOperacoesProprias: String; overload;
    function ModeloCalculoSubstituicaoDeOperacoesProprias(AValue: String): IParametrosCalculoSTCustoAquisicao; overload;

    function PercetualBaseIcmsDoFornecedor: Double; overload;
    function PercetualBaseIcmsDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function IvaDoFornecedor: Double; overload;
    function IvaDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function PercetualBaseSTDoFornecedor: Double; overload;
    function PercetualBaseSTDoFornecedor(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeSubstituicaoTributaria: Double; overload;
    function AliquotaDeSubstituicaoTributaria(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeIcms: Double; overload;
    function AliquotaDeIcms(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function AliquotaDeOperacoesProprias: Double; overload;
    function AliquotaDeOperacoesProprias(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function IpiDeEntrada: Double; overload;
    function IpiDeEntrada(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function FreteDeEntrada: Double; overload;
    function FreteDeEntrada(AValue: Double): IParametrosCalculoSTCustoAquisicao; overload;

    function CalculaSTClienteConsumidorFinalNotaEspiritoSanto: Boolean; overload;
    function CalculaSTClienteConsumidorFinalNotaEspiritoSanto(AValue: Boolean): IParametrosCalculoSTCustoAquisicao; overload;
  end;

  IResultadoCalculoSTCustoAquisicao = interface
    ['{F205FDDA-E5BF-459A-A8A7-E20197763482}']

    function BaseDaSTCustoAquisicao: Double; overload;
    function BaseDaSTCustoAquisicao(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function ValorDaSTCustoAquisicao: Double; overload;
    function ValorDaSTCustoAquisicao(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function ValorDoIcmsOperacoesProprias: Double; overload;
    function ValorDoIcmsOperacoesProprias(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function FatorPositivo: Double; overload;
    function FatorPositivo(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;

    function FatorNegativo: Double; overload;
    function FatorNegativo(AValue: Double): IResultadoCalculoSTCustoAquisicao; overload;
  end;

  ICalculoImpostosSTCustoAquisicao = interface
    ['{BB65AB87-2D9D-40F8-BB19-9010E3A9A08C}']
    function CalcularValorSTCustoAquisicao(AParametros: IParametrosCalculoSTCustoAquisicao): IResultadoCalculoSTCustoAquisicao; overload;
  end;

implementation

end.
