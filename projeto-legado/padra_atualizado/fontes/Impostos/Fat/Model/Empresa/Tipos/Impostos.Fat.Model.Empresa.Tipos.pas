unit Impostos.Fat.Model.Empresa.Tipos;

interface

uses Impostos.Fat.Model.Empresa.Interfaces;

type
  TResultadoImpostosFatModelEmpresa = class(TInterfacedObject, IResultadoImpostosFatModelEmpresa)
  private
    FEmpresaEstado: String;
  public
    function EmpresaEstado: String; overload;
    function EmpresaEstado(AValue: String): IResultadoImpostosFatModelEmpresa; overload;

    class function New(): IResultadoImpostosFatModelEmpresa;
  end;

implementation

{ TResultadoImpostosFatModelEmpresa }

function TResultadoImpostosFatModelEmpresa.EmpresaEstado: String;
begin
  Result := FEmpresaEstado;
end;

function TResultadoImpostosFatModelEmpresa.EmpresaEstado(
  AValue: String): IResultadoImpostosFatModelEmpresa;
begin
  Result := Self;
  FEmpresaEstado := AValue;
end;

class function TResultadoImpostosFatModelEmpresa.New: IResultadoImpostosFatModelEmpresa;
begin
  Result := Self.Create;
end;

end.
