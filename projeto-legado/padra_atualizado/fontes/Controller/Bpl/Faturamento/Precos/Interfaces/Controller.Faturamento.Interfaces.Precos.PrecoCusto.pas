unit Controller.Faturamento.Interfaces.Precos.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.PrecoCusto;

type
  IControllerFaturamentoPrecoCusto = interface
    ['{77A76C3B-D550-4038-B190-646A6AB355A7}']

    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): Double; overload;
    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): Double;
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): Double; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): Double;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): Double;
  end;

implementation

end.
