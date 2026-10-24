unit untGeralPisCofins;

interface

uses SysUtils, Classes, Uni, StdCtrls, Forms;

type
  TImpostoPisCofins = (ipcPis, ipcCofins);

  function fCstPisCofins(strCst: String; ipcImposto: TImpostoPisCofins): Boolean;
  function fCstPisValida(strCst: String): Boolean;
  function fCstCofValida(strCst: String): Boolean;

implementation

uses untFuncoesSimples;

function fCstPisCofins(strCst: String; ipcImposto: TImpostoPisCofins): Boolean;
begin
  If (ipcImposto = ipcPis) Then
    Result := fCstPisValida(strCst)
  Else
    Result := fCstCofValida(strCst);
end;

function fCstPisValida(strCst: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CSTPIS WHERE CST_CODCST = :CODCST');
  qryAux.ParamByName('CODCST').AsString := strCst;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

function fCstCofValida(strCst: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CSTCOF WHERE CST_CODCST = :CODCST');
  qryAux.ParamByName('CODCST').AsString := strCst;
  qryAux.Open;

  Result := qryAux.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryAux);
end;

end.
