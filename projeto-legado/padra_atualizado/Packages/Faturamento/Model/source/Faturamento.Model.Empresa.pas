unit Faturamento.Model.Empresa;

interface

uses Faturamento.Impostos.Interfaces.Model, Faturamento.Impostos.Tipos.Model, Shared.Functions.Core,
  Shared.Functions.DataSet;

type
  TFaturamentoImpostosModelEmpresa = class(TInterfacedObject, IFaturamentoImpostosModelEmpresa)
  private
  public
    function Consultar(const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;

    class function New(): IFaturamentoImpostosModelEmpresa;
  end;

implementation

{ TFaturamentoImpostosModelEmpresa }

function TFaturamentoImpostosModelEmpresa.Consultar(
  const ACodigoDaEmpresa: String): IResultadoFaturamentoImpostosModelEmpresa;
var
  LEmpresaEstado: String;
  LEmpresaIbge: String;
  LRetornoCampoTabela: IMyCampoTabela;
begin
  LRetornoCampoTabela := objCore.fCampoTabela(['CID_ESTADO AS EMP_ESTADO','CID_COIBGE AS EMP_COIBGE'], 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [ACodigoDaEmpresa], False);

  LEmpresaEstado := LRetornoCampoTabela.FieldByName('EMP_ESTADO');
  LEmpresaIbge   := LRetornoCampoTabela.FieldByName('EMP_COIBGE');

  Result :=
    TResultadoFaturamentoImpostosModelEmpresa.New
      .EmpresaEstado(LEmpresaEstado)
      .EmpresaIbge(LEmpresaIbge);
end;

class function TFaturamentoImpostosModelEmpresa.New: IFaturamentoImpostosModelEmpresa;
begin
  Result := Self.Create;
end;

end.
