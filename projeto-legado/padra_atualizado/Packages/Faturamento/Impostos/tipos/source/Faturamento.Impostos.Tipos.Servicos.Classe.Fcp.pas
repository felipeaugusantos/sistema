unit Faturamento.Impostos.Tipos.Servicos.Classe.Fcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Fcp, Faturamento.Impostos.Interfaces.Fcp;

type
  TParametrosClasseFcp = class(TInterfacedObject, IParametrosClasseFcp)
  private
    FParametrosCalculoFcp: IParametrosCalculoFcp;
  public
    function ParametrosCalculoFcp: IParametrosCalculoFcp; overload;
    function ParametrosCalculoFcp(AValue: IParametrosCalculoFcp): IParametrosClasseFcp; overload;

    class function New(): IParametrosClasseFcp;
  end;

type
  TResultadoClasseFcp = class(TInterfacedObject, IResultadoClasseFcp)
  private
    FResultadoCalculoFcp: IResultadoCalculoFcp;
    FParametrosCalculoFcp: IParametrosCalculoFcp;
    FCalculouOValorDoFcp: Boolean;
  public
    function ResultadoCalculoFcp: IResultadoCalculoFcp; overload;
    function ResultadoCalculoFcp(AValue: IResultadoCalculoFcp): IResultadoClasseFcp; overload;

    function ParametrosCalculoFcp: IParametrosCalculoFcp; overload;
    function ParametrosCalculoFcp(AValue: IParametrosCalculoFcp): IResultadoClasseFcp; overload;

    function CalculouOValorDoFcp: Boolean; overload;
    function CalculouOValorDoFcp(AValue: Boolean): IResultadoClasseFcp; overload;

    class function New(): IResultadoClasseFcp;
  end;

implementation

{ TParametrosClasseFcp }

class function TParametrosClasseFcp.New: IParametrosClasseFcp;
begin
  Result := Self.Create;
end;

function TParametrosClasseFcp.ParametrosCalculoFcp: IParametrosCalculoFcp;
begin
  Result := FParametrosCalculoFcp;
end;

function TParametrosClasseFcp.ParametrosCalculoFcp(
  AValue: IParametrosCalculoFcp): IParametrosClasseFcp;
begin
  Result := Self;
  FParametrosCalculoFcp := AValue;
end;

{ TResultadoClasseFcp }

function TResultadoClasseFcp.CalculouOValorDoFcp: Boolean;
begin
  Result := FCalculouOValorDoFcp;
end;

function TResultadoClasseFcp.CalculouOValorDoFcp(
  AValue: Boolean): IResultadoClasseFcp;
begin
  Result := Self;
  FCalculouOValorDoFcp := AValue;
end;

class function TResultadoClasseFcp.New: IResultadoClasseFcp;
begin
  Result := Self.Create;
end;

function TResultadoClasseFcp.ParametrosCalculoFcp(
  AValue: IParametrosCalculoFcp): IResultadoClasseFcp;
begin
  Result := Self;
  FParametrosCalculoFcp := AValue;
end;

function TResultadoClasseFcp.ParametrosCalculoFcp: IParametrosCalculoFcp;
begin
  Result := FParametrosCalculoFcp;
end;

function TResultadoClasseFcp.ResultadoCalculoFcp(
  AValue: IResultadoCalculoFcp): IResultadoClasseFcp;
begin
  Result := Self;
  FResultadoCalculoFcp := AValue;
end;

function TResultadoClasseFcp.ResultadoCalculoFcp: IResultadoCalculoFcp;
begin
  Result := FResultadoCalculoFcp;
end;

end.
