unit Controller.Faturamento.Margem.MargemVenda;

interface

uses Controller.Faturamento.Interfaces.Margem.MargemVenda,
  Faturamento.Margem.Interfaces.MargemVenda, untFatCalcularMargemService,
  System.Generics.Collections, System.SysUtils;

type
  TControllerFaturamentoMargemVenda = class(TInterfacedObject, IControllerFaturamentoMargemVenda)
  private
    FResultadoCalculoMargemVenda: TList<IResultadoCalculoMargemVenda>;
  public
    function CalculaMargemVenda(const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoCalculoMargemVenda>;

    destructor Destroy; override;

    class function New(): IControllerFaturamentoMargemVenda;
  end;

implementation

{ TControllerFaturamentoMargemVenda }

function TControllerFaturamentoMargemVenda.CalculaMargemVenda(
  const AParametros: TList<IParametrosServicoMargemVenda>; AstrConfiguracaoMargemMarkup: String=''): TList<IResultadoCalculoMargemVenda>;
var
  LResultadoServicosClasseMargemVenda: TList<IResultadoServicosClasseMargemVenda>;
  Contador: Integer;
begin
  LResultadoServicosClasseMargemVenda :=
    GetFaturamentoMargemService.MargemVenda.CalculaMargemVenda(AParametros, AstrConfiguracaoMargemMarkup);

//  Result :=
//    LResultadoServicosClasseMargemVenda
//      .ResultadoCalculoMargemVenda;
//      .ValorMargemVenda;

  FResultadoCalculoMargemVenda := TList<IResultadoCalculoMargemVenda>.Create;

  for Contador := 0 to Pred(LResultadoServicosClasseMargemVenda.Count) do
    FResultadoCalculoMargemVenda.Add(LResultadoServicosClasseMargemVenda[Contador].ResultadoCalculoMargemVenda);

  FreeAndNil(LResultadoServicosClasseMargemVenda);

  Result := FResultadoCalculoMargemVenda;
end;


destructor TControllerFaturamentoMargemVenda.Destroy;
begin
//  If Assigned(FResultadoCalculoMargemVenda) Then FResultadoCalculoMargemVenda.Free;

  inherited;
end;

class function TControllerFaturamentoMargemVenda.New: IControllerFaturamentoMargemVenda;
begin
  Result := Self.Create;
end;

end.
