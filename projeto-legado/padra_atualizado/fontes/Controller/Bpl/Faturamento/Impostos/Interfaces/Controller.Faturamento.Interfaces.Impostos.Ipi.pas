unit Controller.Faturamento.Interfaces.Impostos.Ipi;

interface

uses Faturamento.Impostos.Interfaces.Ipi;

type
  IParametrosCalculoValorIpi = interface
  ['{C55458F0-ECF9-4355-9BBF-466DAD4E3E0A}']
    function CodigoDoCliente: String; overload;
    function CodigoDoCliente(AValue: String): IParametrosCalculoValorIpi; overload;

    function CodigoDoProduto: String; overload;
    function CodigoDoProduto(AValue: String): IParametrosCalculoValorIpi; overload;

    function CodigoDaEmpresa: String; overload;
    function CodigoDaEmpresa(AValue: String): IParametrosCalculoValorIpi; overload;

    function TotalGeralDoItem: Double; overload;
    function TotalGeralDoItem(AValue: Double): IParametrosCalculoValorIpi; overload;

    function BaixaDeEntregaFutura: Boolean; overload;
    function BaixaDeEntregaFutura(AValue: Boolean): IParametrosCalculoValorIpi; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosCalculoValorIpi; overload;

    function TipoDeBaixaEntregaFutura: String; overload;
    function TipoDeBaixaEntregaFutura(AValue: String): IParametrosCalculoValorIpi; overload;
  end;

  IImpostosFatControllerIpi = interface
    ['{5189A12A-2CA0-49D0-A787-0CCEB646BC71}']

    function CalcularValorIpi: IResultadoCalculoIPI;Overload;

    function CalcularValorIpi(const AParametrosCalculoValorIpi: IParametrosCalculoValorIpi): IResultadoCalculoIPI; Overload;

    function CalcularValorIpiFinal: Boolean;

    procedure ZerarDadosIpi(const AZerarAliquota: boolean);
  end;

implementation

end.
