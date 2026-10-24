unit untTParametrosMonitorContabil;

interface

uses untIContabilidade;

type
  TParametrosMonitorContabil = Class(TInterfacedObject, IParametrosMonitorContabil)
  private
    FEmpresaLancamento: string;
    FIdLancamento: int64;
  public
    function EmpresaLancamento(const AValue: String): IParametrosMonitorContabil; overload;
    function EmpresaLancamento: String; overload;
    function IdLancamento: int64; overload;
    function IdLancamento(AValue: int64): IParametrosMonitorContabil; overload;
    class function New: IParametrosMonitorContabil;
  end;

implementation

{ TParametrosMonitorContabil }

function TParametrosMonitorContabil.EmpresaLancamento(
  const AValue: String): IParametrosMonitorContabil;
begin
  Result := Self;
  FEmpresaLancamento := AValue;
end;

function TParametrosMonitorContabil.EmpresaLancamento: String;
begin
  Result := FEmpresaLancamento;
end;

function TParametrosMonitorContabil.IdLancamento: int64;
begin
  Result := FIdLancamento;
end;

function TParametrosMonitorContabil.IdLancamento(
  AValue: int64): IParametrosMonitorContabil;
begin
  Result := Self;
  FIdLancamento := AValue;
end;

class function TParametrosMonitorContabil.New: IParametrosMonitorContabil;
begin
  Result := Self.Create;
end;

end.
