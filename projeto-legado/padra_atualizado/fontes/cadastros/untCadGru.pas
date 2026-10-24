unit untCadGru;

interface

uses Uni;

function fVerificaLinhaCadGrupo(strLinha: String): Boolean;

function fValidaLinhaGrupoCadGru(strLinGru: String): Boolean;

implementation

uses SysUtils, StrUtils, untFuncoesSimples, Data.DB;

{*****************************************}
{* VERIFICA A LINHA DO => CAD. GRUPO <=  *}
{* RETORNA 'TRUE' CASO EXISTA A LINHA    *}
{**************************************MV*}
function fVerificaLinhaCadGrupo(strLinha: String): Boolean;
  Var
    strSQL   : String;
    strTemp  : String;
    qryGenGru: TUniQuery;

begin
  Try

    qryGenGru := fCriaQuery(nil);

    If (LeftStr(strLinha, 3) = '000') Then
    Begin
      Result := False;
      Exit;
    End;

    If RightStr(strLinha, 3) = '000' Then
    Begin
      Result := True;
      Exit;
    End;

    strTemp := LeftStr(strLinha, 3);
    strTemp := strTemp + '000';

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  GRU_CODGRU ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADGRU ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GRU_CODGRU = :CODGRU ';

    With qryGenGru Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODGRU').AsString := strTemp;
      Open;
      If IsEmpty Then
        Result := False
      Else
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenGru);
  End;

  FreeAndNil(qryGenGru);
end;

function fValidaLinhaGrupoCadGru(strLinGru: String): Boolean;
begin
  Result := True;

  If RightStr(strLinGru, 3) = '000' Then
    Result := False;
end;

end.
