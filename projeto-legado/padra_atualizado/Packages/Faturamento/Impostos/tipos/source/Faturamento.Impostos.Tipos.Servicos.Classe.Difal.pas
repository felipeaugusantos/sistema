unit Faturamento.Impostos.Tipos.Servicos.Classe.Difal;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Difal, Faturamento.Impostos.Interfaces.Difal;

type
  TParametrosClasseDifal = class(TInterfacedObject, IParametrosClasseDifal)
  private
    FParametrosCalculoDifal: IParametrosCalculoDifal;
  public
    function ParametrosCalculoDifal: IParametrosCalculoDifal; overload;
    function ParametrosCalculoDifal(AValue: IParametrosCalculoDifal): IParametrosClasseDifal; overload;

    class function New(): IParametrosClasseDifal;
  end;

type
  TResultadoClasseDifal = class(TInterfacedObject, IResultadoClasseDifal)
  private
    FResultadoCalculoDifal: IResultadoCalculoDifal;
    FParametrosCalculoDifal: IParametrosCalculoDifal;
  public
    function ResultadoCalculoDifal: IResultadoCalculoDifal; overload;
    function ResultadoCalculoDifal(AValue: IResultadoCalculoDifal): IResultadoClasseDifal; overload;

    function ParametrosCalculoDifal: IParametrosCalculoDifal; overload;
    function ParametrosCalculoDifal(AValue: IParametrosCalculoDifal): IResultadoClasseDifal; overload;

    class function New(): IResultadoClasseDifal;
  end;


implementation

{ TParametrosClasseDifal }

class function TParametrosClasseDifal.New: IParametrosClasseDifal;
begin
  Result := Self.Create;
end;

function TParametrosClasseDifal.ParametrosCalculoDifal: IParametrosCalculoDifal;
begin
  Result := FParametrosCalculoDifal;
end;

function TParametrosClasseDifal.ParametrosCalculoDifal(
  AValue: IParametrosCalculoDifal): IParametrosClasseDifal;
begin
  Result := Self;
  FParametrosCalculoDifal := AValue;
end;

{ TResultadoClasseDifal }

class function TResultadoClasseDifal.New: IResultadoClasseDifal;
begin
  Result := Self.Create;
end;

function TResultadoClasseDifal.ParametrosCalculoDifal(
  AValue: IParametrosCalculoDifal): IResultadoClasseDifal;
begin
  Result := Self;
  FParametrosCalculoDifal := AValue;
end;

function TResultadoClasseDifal.ParametrosCalculoDifal: IParametrosCalculoDifal;
begin
  Result := FParametrosCalculoDifal;
end;

function TResultadoClasseDifal.ResultadoCalculoDifal: IResultadoCalculoDifal;
begin
  Result := FResultadoCalculoDifal;
end;

function TResultadoClasseDifal.ResultadoCalculoDifal(
  AValue: IResultadoCalculoDifal): IResultadoClasseDifal;
begin
  Result := Self;
  FResultadoCalculoDifal := AValue;
end;

end.
