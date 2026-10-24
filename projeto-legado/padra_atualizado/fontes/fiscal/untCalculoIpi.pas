unit untCalculoIpi;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  Uni, Shared.Functions.Funcoes.Faturamento, Shared.Functions.DataSet,
  Shared.Functions.Utils, Shared.Functions.Interfaces, Shared.Functions.Types,
  Faturamento.Connections.Functions;

  procedure pRetornaDadosAbreviacaoIpi(strCodIte, strClaFis: String;
    Var strCstIpi, strEnqIpi: String);

implementation

uses SysUtils, Data.DB;

procedure pRetornaDadosAbreviacaoIpi(strCodIte, strClaFis: String;
  Var strCstIpi, strEnqIpi: String);
  Var
    strSQL    : String;
    blnAbfEmp : Boolean;
    objAbf: IMyCampoTabela;
    arrChave: ArrOfVariant;
    objSelectParaCampoTabela: IResultadoDesmembrarSelectParaCampoTabela;
begin
  blnAbfEmp := fCfgSis('TPABPC', varString) = '2';

  strSQL :=
    TFunctionFuncoesFaturamento.
      GetSelectAbreviacaoIpi(strClaFis);

  objSelectParaCampoTabela := TFunctionsUtils.DesmembrarSelectParaCampoTabela(strSQL);

  SetLength(arrChave, 0);

  SetLength(arrChave, Length(arrChave) + 1);
  arrChave[Length(arrChave) - 1] := strCodIte;

  If blnAbfEmp Then
  Begin
    SetLength(arrChave, Length(arrChave) + 1);
    arrChave[Length(arrChave) - 1] := VS_strCodEmp;
  End;

  SetLength(arrChave, Length(arrChave) + 1);
  arrChave[Length(arrChave) - 1] := strClaFis;

  objAbf := fCampoTabelaArray(objSelectParaCampoTabela.CamposSelect,
                              objSelectParaCampoTabela.NomeTabela,
                              objSelectParaCampoTabela.CampoChave, arrChave, False);

  If fEmptyStr(objAbf.FieldByName('CST').AsString) Then
  Begin
    fMensagem('', 'Produto ' + strCodIte + ' não está associado a nenhuma abreviação de IPI ou a CFOP ' + strClaFis + ' não está ' +
      'associada no cadastro de abreviação de IPI. Favor verificar os cadastros.', ['&Ok']);
    Abort;
  End;

  strCstIpi := objAbf.FieldByName('CST').AsString;
  strEnqIpi := objAbf.FieldByName('ENQIPI').AsString;
  //fltPerBas := qryAbf.FieldByName('BASE').AsFloat;
  //fltAlqIpi := qryAbf.FieldByName('ALQ').AsFloat;
end;

end.
