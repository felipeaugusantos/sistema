unit Faturamento.Impostos.Servicos.Classe.Difal;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Difal,
  Faturamento.Impostos.Tipos.Servicos.Classe.Difal,
  Faturamento.Impostos.Calculos.Difal,
  Faturamento.Impostos.Tipos.Difal,
  Faturamento.Impostos.Interfaces.Difal,
  Shared.Functions.Types;

type
  TServicosClasseDifal = class(TInterfacedObject, IServicosClasseDifal)
  private
    FParametros: IParametrosClasseDifal;

    function ResultadoCalculoDifalFinal: IResultadoCalculoDifal;
  public
//    function CalcularDifal: IResultadoClasseDifal;
    function CalcularDifalFinal: IResultadoClasseDifal;

    constructor Create(AParametros: IParametrosClasseDifal); overload;

    class function New(AParametros: IParametrosClasseDifal): IServicosClasseDifal;
  end;

implementation

{ TServicosClasseDifal }

function TServicosClasseDifal.CalcularDifalFinal: IResultadoClasseDifal;
var
  LResultadoCalculoDifal: IResultadoCalculoDifal;
begin
  LResultadoCalculoDifal := ResultadoCalculoDifalFinal;

  Result :=
    TResultadoClasseDifal.New
      .ResultadoCalculoDifal(LResultadoCalculoDifal)
      .ParametrosCalculoDifal(FParametros.ParametrosCalculoDifal);
end;

constructor TServicosClasseDifal.Create(AParametros: IParametrosClasseDifal);
begin
  FParametros := AParametros;
end;

class function TServicosClasseDifal.New(AParametros: IParametrosClasseDifal): IServicosClasseDifal;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseDifal.ResultadoCalculoDifalFinal: IResultadoCalculoDifal;
begin
  Result :=
    TCalculoImpostosDifal.New
      .CalcularValorDifal(FParametros.ParametrosCalculoDifal);
end;

end.
