unit Faturamento.Precos.Servicos.Disponiveis.PrecoCusto;

interface

uses Faturamento.Precos.Interfaces.Servicos.Disponiveis.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto, Faturamento.Precos.Servicos.Classe.PrecoCusto;

type
  TFaturamentoPrecosServicosDisponiveisPrecoCusto = class(TInterfacedObject, IFaturamentoPrecosServicosDisponiveisPrecoCusto)
  public
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;

    class function New(): IFaturamentoPrecosServicosDisponiveisPrecoCusto;
  end;

implementation

{ TFaturamentoPrecosServicosPrecoCusto }

function TFaturamentoPrecosServicosDisponiveisPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TFaturamentoPrecosServicosClassePrecoCusto.New()
      .CalculaPrecoCusto(AParametros);
end;

function TFaturamentoPrecosServicosDisponiveisPrecoCusto.CalculaCustoReal(
  const AParametros: IParametrosCalculoCustoReal): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TFaturamentoPrecosServicosClassePrecoCusto.New()
      .CalculaCustoReal(AParametros);
end;

function TFaturamentoPrecosServicosDisponiveisPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCustoMargemMarkup): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TFaturamentoPrecosServicosClassePrecoCusto.New()
      .CalculaPrecoCusto(AParametros);
end;

function TFaturamentoPrecosServicosDisponiveisPrecoCusto.CalculaPrecoCustoConversorMoeda(
  const AParametros: IParametrosServicoPrecoCusto): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TFaturamentoPrecosServicosClassePrecoCusto.New()
      .CalculaPrecoCustoConversorMoeda(AParametros);

end;

function TFaturamentoPrecosServicosDisponiveisPrecoCusto.CalculaPrecoCustoRealVenda(
  const AParametros: IParametrosCalculoPrecoCustoRealVenda): IResultadoServicosClassePrecoCusto;
begin
  Result :=
    TFaturamentoPrecosServicosClassePrecoCusto.New()
      .CalculaPrecoCustoRealVenda(AParametros);
end;

class function TFaturamentoPrecosServicosDisponiveisPrecoCusto.New: IFaturamentoPrecosServicosDisponiveisPrecoCusto;
begin
  Result := Self.Create;
end;

end.
