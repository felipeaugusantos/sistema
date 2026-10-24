unit Controller.Faturamento.Interfaces.Impostos.IcmsEfetivo;

interface

uses Faturamento.Impostos.Interfaces.IcmsEfetivo,
     Shared.Functions.Types;

type
  IParametrosCalculoValorIcmsEfetivo = interface
  ['{C55458F0-ECF9-4355-9BBF-466DAD4E3E0A}']
    function CodigoDaEmpresa : String; Overload;
    function CodigoDaEmpresa(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function CodigoDoCliente: String; Overload;
    function CodigoDoCliente(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function CodigoDoFornecedor : String; Overload;
    function CodigoDoFornecedor(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function ClienteConsumidorFinal : String; Overload;
    function ClienteConsumidorFinal(AValue : String) : IParametrosCalculoValorIcmsEfetivo; Overload;

    function ClienteIndustria: Boolean; overload;
    function ClienteIndustria(AValue: Boolean): IParametrosCalculoValorIcmsEfetivo; overload;

    function ClienteComercializacao: Boolean; overload;
    function ClienteComercializacao(AValue: Boolean): IParametrosCalculoValorIcmsEfetivo; overload;

  end;

  IImpostosFatControllerIcmsEfetivo = interface
    ['{5189A12A-2CA0-49D0-A787-0CCEB646BC71}']
    function CalcularValorIcmsEfetivo: TMatrizFechamentoIcmsEfetivo;Overload;

//    function CalcularValorIcmsEfetivo(const AParametrosCalculoValorIcmsEfetivo: IParametrosCalculoValorIcmsEfetivo): TMatrizFechamentoIcmsEfetivo; Overload;
  end;

implementation

end.
