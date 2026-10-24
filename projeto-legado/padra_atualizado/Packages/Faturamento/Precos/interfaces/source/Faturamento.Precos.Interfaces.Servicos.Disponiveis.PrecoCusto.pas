unit Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.PrecoCusto;

type
  IFaturamentoPrecosServicosDisponiveisPrecoCusto = interface
    ['{11A21E05-8322-469D-B1C8-0F4BEDDC5902}']
   	
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;
  end;

implementation

end.
