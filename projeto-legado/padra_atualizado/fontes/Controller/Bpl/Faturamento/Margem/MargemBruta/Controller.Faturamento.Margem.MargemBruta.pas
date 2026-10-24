unit Controller.Faturamento.Margem.MargemBruta;

interface

uses Controller.Faturamento.Interfaces.Margem.MargemBruta,
  Faturamento.Margem.Interfaces.MargemBruta, untFatCalcularMargemService;

type
  TControllerFaturamentoMargemBruta = class(TInterfacedObject, IControllerFaturamentoMargemBruta)
  private

  public
    function CalculaMargemBruta(const AParametros: IParametrosServicoMargemBruta): Double;

    function CalculaMargemParaMarkup(const AParametros: IParametrosServicoMargemParaMarkup): Double;

    destructor Destroy; override;

    class function New(): IControllerFaturamentoMargemBruta;
  end;

implementation

{ TControllerFaturamentoMargemBruta }

function TControllerFaturamentoMargemBruta.CalculaMargemBruta(
  const AParametros: IParametrosServicoMargemBruta): Double;
var
  LResultadoServicosClasseMargemBruta: IResultadoServicosClasseMargemBruta;
begin
  LResultadoServicosClasseMargemBruta :=
    GetFaturamentoMargemService.MargemBruta.CalculaMargemBruta(AParametros);

  Result :=
    LResultadoServicosClasseMargemBruta
      .ResultadoCalculoMargemBruta
      .ValorMargemBruta;

end;

function TControllerFaturamentoMargemBruta.CalculaMargemParaMarkup(
  const AParametros: IParametrosServicoMargemParaMarkup): Double;
var
  LResultadoServicosClasseMargemParaMarkup: IResultadoServicosClasseMargemBruta;
begin
  LResultadoServicosClasseMargemParaMarkup:=
    GetFaturamentoMargemService.MargemBruta.CalculaMargemParaMarkup(AParametros);

  Result :=
    LResultadoServicosClasseMargemParaMarkup
      .ResultadoCalculoMargemParaMarkup
      .ValorMarkup;
end;

destructor TControllerFaturamentoMargemBruta.Destroy;
begin

  inherited;
end;

class function TControllerFaturamentoMargemBruta.New: IControllerFaturamentoMargemBruta;
begin
  Result := Self.Create;
end;

end.
