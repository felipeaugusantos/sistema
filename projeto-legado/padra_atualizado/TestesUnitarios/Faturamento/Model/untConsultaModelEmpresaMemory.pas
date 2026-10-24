unit untConsultaModelEmpresaMemory;

interface

uses Faturamento.Impostos.Interfaces.Model;

type
  TConsultaModelEmpresaMemory = class(TInterfacedObject, IResultadoFaturamentoImpostosModelEmpresa)
  private
    FEmpresaEstado: String;
    FEmpresaIbge: String;
  public
    function EmpresaEstado: String; overload;
    function EmpresaEstado(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;
    function EmpresaIbge: String; overload;
    function EmpresaIbge(AValue: String): IResultadoFaturamentoImpostosModelEmpresa; overload;
    class function New: IResultadoFaturamentoImpostosModelEmpresa;
  end;

implementation

{ TConsultaModelEmpresaMemory }

function TConsultaModelEmpresaMemory.EmpresaEstado: String;
begin
  Result := FEmpresaEstado;
end;

function TConsultaModelEmpresaMemory.EmpresaEstado(
  AValue: String): IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self;
  FEmpresaEstado := AValue;
end;

class function TConsultaModelEmpresaMemory.New: IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self.Create;
end;

function TConsultaModelEmpresaMemory.EmpresaIbge: String;
begin
  Result := FEmpresaIbge;
end;

function TConsultaModelEmpresaMemory.EmpresaIbge(
  AValue: String): IResultadoFaturamentoImpostosModelEmpresa;
begin
  Result := Self;
  FEmpresaIbge := AValue;
end;

end.
