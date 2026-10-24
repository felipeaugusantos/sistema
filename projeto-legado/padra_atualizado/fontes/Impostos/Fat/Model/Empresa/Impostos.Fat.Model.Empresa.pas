unit Impostos.Fat.Model.Empresa;

interface

uses Impostos.Fat.Model.Empresa.Interfaces, Impostos.Fat.Model.Empresa.Tipos,
  Impostos.Fat.Connections.Functions, Uni, Impostos.Fat.Conexao.Interfaces;

type
  TImpostosFatModelEmpresa = class(TInterfacedObject, IImpostosFatModelEmpresa)
  private
    FConexao: TUniConnection;
  public
    function Consultar(const ACodigoDaEmpresa: String): IResultadoImpostosFatModelEmpresa;

    constructor Create;
    class function New(): IImpostosFatModelEmpresa;
  end;

implementation

{ TImpostosFatModelEmpresa }

function TImpostosFatModelEmpresa.Consultar(
  const ACodigoDaEmpresa: String): IResultadoImpostosFatModelEmpresa;
var
  LEmpresaEstado: String;
begin
  LEmpresaEstado := fCampoTabelaFat('CID_ESTADO', 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [ACodigoDaEmpresa], False, '', FConexao);

  Result :=
    TResultadoImpostosFatModelEmpresa.New
      .EmpresaEstado(LEmpresaEstado);
end;

constructor TImpostosFatModelEmpresa.Create;
begin
  FConexao := objConexao.Conexao;
end;

class function TImpostosFatModelEmpresa.New: IImpostosFatModelEmpresa;
begin
  Result := Self.Create;
end;

end.
