unit Faturamento.Impostos.Tipos.Servicos.Classe.DifalFcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp, Faturamento.Impostos.Interfaces.Fcp;

type
  TParametrosClasseDifalFcp = class(TInterfacedObject, IParametrosClasseDifalFcp)
  private
    FParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
  public
    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp; overload;
    function ParametrosCalculoDifalFcp(AValue: IParametrosCalculoDifalFcp): IParametrosClasseDifalFcp; overload;

    class function New(): IParametrosClasseDifalFcp;
  end;

type
  TResultadoClasseDifalFcp = class(TInterfacedObject, IResultadoClasseDifalFcp)
  private
    FResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
    FParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
  public
    function ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp; overload;
    function ResultadoCalculoDifalFcp(AValue: IResultadoCalculoDifalFcp): IResultadoClasseDifalFcp; overload;

    function ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp; overload;
    function ParametrosCalculoDifalFcp(AValue: IParametrosCalculoDifalFcp): IResultadoClasseDifalFcp; overload;

    class function New(): IResultadoClasseDifalFcp;
  end;

implementation

{ TParametrosClasseFcp }

class function TParametrosClasseDifalFcp.New: IParametrosClasseDifalFcp;
begin
  Result := Self.Create;
end;

function TParametrosClasseDifalFcp.ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
begin
  Result := FParametrosCalculoDifalFcp;
end;

function TParametrosClasseDifalFcp.ParametrosCalculoDifalFcp(
  AValue: IParametrosCalculoDifalFcp): IParametrosClasseDifalFcp;
begin
  Result := Self;
  FParametrosCalculoDifalFcp := AValue;
end;

{ TResultadoClasseFcp }


class function TResultadoClasseDifalFcp.New: IResultadoClasseDifalFcp;
begin
  Result := Self.Create;
end;

function TResultadoClasseDifalFcp.ParametrosCalculoDifalFcp(
  AValue: IParametrosCalculoDifalFcp): IResultadoClasseDifalFcp;
begin
  Result := Self;
  FParametrosCalculoDifalFcp := AValue;
end;

function TResultadoClasseDifalFcp.ParametrosCalculoDifalFcp: IParametrosCalculoDifalFcp;
begin
  Result := FParametrosCalculoDifalFcp;
end;

function TResultadoClasseDifalFcp.ResultadoCalculoDifalFcp(
  AValue: IResultadoCalculoDifalFcp): IResultadoClasseDifalFcp;
begin
  Result := Self;
  FResultadoCalculoDifalFcp := AValue;
end;

function TResultadoClasseDifalFcp.ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
begin
  Result := FResultadoCalculoDifalFcp;
end;

end.
