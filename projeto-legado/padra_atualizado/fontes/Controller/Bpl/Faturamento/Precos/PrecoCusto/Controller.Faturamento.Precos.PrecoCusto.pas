unit Controller.Faturamento.Precos.PrecoCusto;

interface

uses
  Controller.Faturamento.Interfaces.Precos.PrecoCusto,
  Faturamento.Precos.Interfaces.PrecoCusto,
  untFatCalcularPrecosService,
  System.SysUtils;


type
  TControllerFaturamentoPrecoCusto = class(TInterfacedObject, IControllerFaturamentoPrecoCusto)
  private
    FPath : String;
  public
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCusto): Double; overload;
    function CalculaPrecoCustoConversorMoeda(const AParametros: IParametrosServicoPrecoCusto): Double;
    function CalculaPrecoCusto(const AParametros: IParametrosServicoPrecoCustoMargemMarkup): Double; overload;
    function CalculaPrecoCustoRealVenda(const AParametros: IParametrosCalculoPrecoCustoRealVenda): Double;
    function CalculaCustoReal(const AParametros: IParametrosCalculoCustoReal): Double;

    Constructor Create;
    destructor Destroy; override;

    class function New(): IControllerFaturamentoPrecoCusto;
  end;

implementation

{ TControllerFaturamentoPrecoCusto }

uses
{$IFDEF LINUX}
  Services.Core.Types,
{$ENDIF}
  Controller.Faturamento.Interfaces.Cache;

function TControllerFaturamentoPrecoCusto.CalculaCustoReal(
  const AParametros: IParametrosCalculoCustoReal): Double;
var
  LResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
begin
  LResultadoServicosClassePrecoCusto :=
    GetFaturamentoPrecosService(FPath).PrecoCusto.CalculaCustoReal(AParametros);

  Result :=
    LResultadoServicosClassePrecoCusto
      .ResultadoCalculoPrecoCusto
        .ValorCalculadoPrecoCusto;
end;

function TControllerFaturamentoPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCustoMargemMarkup): Double;
var
  LResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoServicosClassePrecoCusto) then
  begin
    LResultadoServicosClassePrecoCusto :=
      GetFaturamentoPrecosService(FPath).PrecoCusto.CalculaPrecoCusto(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoServicosClassePrecoCusto);
  end;

  Result :=
    LResultadoServicosClassePrecoCusto
      .ResultadoCalculoPrecoCusto
      .ValorCalculadoPrecoCusto;

end;

function TControllerFaturamentoPrecoCusto.CalculaPrecoCustoConversorMoeda(
  const AParametros: IParametrosServicoPrecoCusto): Double;
Var
  LResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoServicosClassePrecoCusto) then
  begin
    LResultadoServicosClassePrecoCusto :=
      GetFaturamentoPrecosService(FPath).PrecoCusto.CalculaPrecoCustoConversorMoeda(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoServicosClassePrecoCusto);
  end;

  Result :=
    LResultadoServicosClassePrecoCusto
      .ResultadoCalculoPrecoCusto
      .ValorCalculadoPrecoCusto;
end;

function TControllerFaturamentoPrecoCusto.CalculaPrecoCusto(
  const AParametros: IParametrosServicoPrecoCusto): Double;
var
  LResultadoServicosClassePrecoCusto: IResultadoServicosClassePrecoCusto;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoServicosClassePrecoCusto) then
  begin
    LResultadoServicosClassePrecoCusto :=
      GetFaturamentoPrecosService(FPath).PrecoCusto.CalculaPrecoCusto(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoServicosClassePrecoCusto);
  end;

  Result :=
    LResultadoServicosClassePrecoCusto
      .ResultadoCalculoPrecoCusto
      .ValorCalculadoPrecoCusto;

end;

function TControllerFaturamentoPrecoCusto.CalculaPrecoCustoRealVenda(
  const AParametros: IParametrosCalculoPrecoCustoRealVenda): Double;
var
  LResultadoServicosClassePrecoCustoRealVenda: IResultadoServicosClassePrecoCusto;
begin
  if not TControllerFaturamentoInterfacesCache.TryGetCache(AParametros, LResultadoServicosClassePrecoCustoRealVenda) then
  begin
    LResultadoServicosClassePrecoCustoRealVenda :=
      GetFaturamentoPrecosService(FPath).PrecoCusto.CalculaPrecoCustoRealVenda(AParametros);
    TControllerFaturamentoInterfacesCache.AddOrSetCache(AParametros, LResultadoServicosClassePrecoCustoRealVenda);
  end;

  Result :=
    LResultadoServicosClassePrecoCustoRealVenda
      .ResultadoCalculoPrecoCusto
      .ValorCalculadoPrecoCusto;
end;

constructor TControllerFaturamentoPrecoCusto.Create;
begin
  inherited;
 {$IFDEF LINUX}
  FPath := ExtractFilePath(Application.ExeName);
 {$ELSE}
  FPath := ExtractFilePath(ParamStr(0));
 {$ENDIF}
end;

destructor TControllerFaturamentoPrecoCusto.Destroy;
begin

  inherited;
end;

class function TControllerFaturamentoPrecoCusto.New: IControllerFaturamentoPrecoCusto;
begin
  Result := Self.Create;
end;

end.
