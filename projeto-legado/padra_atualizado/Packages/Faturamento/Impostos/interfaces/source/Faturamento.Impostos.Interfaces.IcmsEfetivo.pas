unit Faturamento.Impostos.Interfaces.IcmsEfetivo;

interface

uses
  Shared.Functions.Types,
  Faturamento.Impostos.Interfaces.Model;

type
  IParametrosCalculoIcmsEfetivo = interface
    ['{0E29DCD2-0E7A-46B9-8834-04E62212BD0B}']
    function EncontrouDocumento : Boolean ; overload;
    function EncontrouDocumento(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function Quantidade : Double; overload;
    function Quantidade(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function QuantidadeItem: Double; overload;
    function QuantidadeItem(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ClienteConsumidorFinal: Boolean ; overload;
    function ClienteConsumidorFinal(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function PercentualReducaoBaseCalcEfetiva: Double; overload;
    function PercentualReducaoBaseCalcEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetiva: Double; overload;
    function ValorBaseCalculoEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function AliquotaIcmsEfetiva: Double; overload;
    function AliquotaIcmsEfetiva(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseRetida: Double; overload;
    function ValorBaseRetida(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorRetido: Double; overload;
    function ValorRetido(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorIcmsSubstitutoItem : Double; overload;
    function ValorIcmsSubstitutoItem (AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function IcmsEfetivoSemUltimaNota : Boolean; overload;
    function IcmsEfetivoSemUltimaNota (AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function ValorBaseOperacaoPropriaICMSEntrada: Double; overload;
    function ValorBaseOperacaoPropriaICMSEntrada(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function AliquotaOperacaoPropriaICMSEntrada : Double; overload;
    function AliquotaOperacaoPropriaICMSEntrada (AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSEntrada: Double; overload;
    function ValorOperacaoPropriaICMSEntrada(AValue : Double): IParametrosCalculoIcmsEfetivo; overload;

    function EncontrouDocumentoOperacaoPropriaICMSEntrada : Boolean; overload;
    function EncontrouDocumentoOperacaoPropriaICMSEntrada(AValue : Boolean): IParametrosCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSSaida : Double; overload;
    function ValorOperacaoPropriaICMSSaida(const AValue : Double) : IParametrosCalculoIcmsEfetivo; overload;
  end;

  IResultadoCalculoIcmsEfetivo = interface
    ['{1A5FB75C-2B27-42FD-AA65-96CA22B4BC3C}']
    function PercentualReducaoBaseCalcEfetivaItem: Double; overload;
    function PercentualReducaoBaseCalcEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoEfetivaItem: Double; overload;
    function ValorBaseCalculoEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsEfetivaItem: Double; overload;
    function ValorIcmsEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function AliquotaIcmsEfetivaItem: Double; overload;
    function AliquotaIcmsEfetivaItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseCalculoIcmsStRetidoItem: Double; overload;
    function ValorBaseCalculoIcmsStRetidoItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsStRetidoItem: Double; overload;
    function ValorIcmsStRetidoItem(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorIcmsSubstitutoItem : Double; overload;
    function ValorIcmsSubstitutoItem (AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorBaseOperacaoPropriaICMSEntrada: Double; overload;
    function ValorBaseOperacaoPropriaICMSEntrada(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function AliquotaOperacaoPropriaICMSEntrada : Double; overload;
    function AliquotaOperacaoPropriaICMSEntrada (AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

    function ValorOperacaoPropriaICMSEntrada: Double; overload;
    function ValorOperacaoPropriaICMSEntrada(AValue : Double): IResultadoCalculoIcmsEfetivo; overload;

  end;

  ICalculoImpostosIcmsEfetivo = interface
    ['{BB65AB87-2D9D-40F8-BB19-9010E3A9A08C}']
    function CalcularValorIcmsEfetivo(AParametros: IParametrosCalculoIcmsEfetivo): IResultadoCalculoIcmsEfetivo; overload;
  end;


  IParametrosServicoIcmsEfetivo = interface
    ['{CEED2657-C3A9-46C1-BD97-01CB9B5266D7}']
    function MatItensIcmsEfetivo : TMatrizFechamentoIcmsEfetivo; Overload;
    function MatItensIcmsEfetivo(AValue : TMatrizFechamentoIcmsEfetivo) : IParametrosServicoIcmsEfetivo; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function OpcaoDoDocumento : String; Overload;
    function OpcaoDoDocumento(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaEmpresa : String; Overload;
    function CodigoDaEmpresa(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaEmpresaTE : String; Overload;
    function CodigoDaEmpresaTE(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDoFornecedor : String; Overload;
    function CodigoDoFornecedor(AValue : String) : IParametrosServicoIcmsEfetivo; overload;

    function ClienteConsumidorFinal : Boolean; Overload;
    function ClienteConsumidorFinal(AValue : Boolean) : IParametrosServicoIcmsEfetivo; overload;

    function SequencialEnderecoEntrega: String; overload;
    function SequencialEnderecoEntrega(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function NotaComplementoFornecedor : Boolean; overload;
    function NotaComplementoFornecedor(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function EspecieDocumento: String; overload;
    function EspecieDocumento(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function TipoOperacaoPedidoVenda: String; overload;
    function TipoOperacaoPedidoVenda(AValue: String): IParametrosServicoIcmsEfetivo; overload;

    function CalcularSatEcf: Boolean; overload;
    function CalcularSatEcf(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function UtilizaSat: Boolean; overload;
    function UtilizaSat(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function NotaEspecialFornecedor : Boolean; overload;
    function NotaEspecialFornecedor(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function BaixaDeEntregaFutura : Boolean; overload;
    function BaixaDeEntregaFutura(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function GerandoCasosTestes: Boolean; overload;
    function GerandoCasosTestes(AValue: boolean): IParametrosServicoIcmsEfetivo; overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue : Boolean): IParametrosServicoIcmsEfetivo; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue: Boolean): IParametrosServicoIcmsEfetivo; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosServicoIcmsEfetivo; overload;

    function CodigoDaFazenda: String; overload;
    function CodigoDaFazenda(AValue: String): IParametrosServicoIcmsEfetivo; overload;

  end;

  IResultadoServicosClasseIcmsEfetivo = interface
    ['{F869EF88-3418-4501-B686-9E370712FA95}']

    function ResultadoCalculoIcmsEfetivo: TMatrizFechamentoIcmsEfetivo; overload;
    function ResultadoCalculoIcmsEfetivo(AValue: TMatrizFechamentoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo; overload;

    function ParametrosCalculoIcmsEfetivo: IParametrosCalculoIcmsEfetivo; overload;
    function ParametrosCalculoIcmsEfetivo(AValue: IParametrosCalculoIcmsEfetivo): IResultadoServicosClasseIcmsEfetivo; overload;
  end;





implementation

end.
