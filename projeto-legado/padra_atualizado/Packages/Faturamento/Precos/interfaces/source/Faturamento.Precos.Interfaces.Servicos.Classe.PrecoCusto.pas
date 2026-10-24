unit Faturamento.Precos.Interfaces.Servicos.Classe.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.PrecoCusto;

type
  IFaturamentoPrecosServicosClassePrecoCusto = interface
    ['{93B3E040-0141-46AF-91B7-C61822F469E7}']

    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;
  end;

implementation

end.
