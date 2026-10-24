unit untCadSfz;

interface

uses
  Uni;

function fRetProximoCodigo(strCodSfz: String): String;

implementation

uses SysUtils, untFuncoesSimples, Data.DB;

function fRetProximoCodigo(strCodSfz: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);

  qryAux.SQL.Add('SELECT SQL_NO_CACHE                ');
  qryAux.SQL.Add('  IFNULL(SFZ_PROCOD, 1) AS PROCOD  ');
  qryAux.SQL.Add('FROM                               ');
  qryAux.SQL.Add('  CADSFZ                           ');
  qryAux.SQL.Add('WHERE                              ');
  qryAux.SQL.Add('  SFZ_CODSFZ = :CODSFZ             ');

  qryAux.ParamByName('CODSFZ').AsString := strCodSfz;
  qryAux.Open;

  If (qryAux.IsEmpty) Then
  Begin
    qryAux.Close;
    FreeAndNil(qryAux);

    Raise Exception.Create('Não consegui pegar o próximo sequencial para a Filizola');
  End;

  Result := qryAux.FieldByName('PROCOD').AsString;
  Result := fStrZero(Result, 3);

  qryAux.SQL.Clear;
  qryAux.SQL.Add('UPDATE                 ');
  qryAux.SQL.Add('  CADSFZ               ');
  qryAux.SQL.Add('SET                    ');
  qryAux.SQL.Add('  SFZ_PROCOD = :NOVCOD ');
  qryAux.SQL.Add('WHERE                  ');
  qryAux.SQL.Add('  SFZ_CODSFZ = :CODSFZ ');

  qryAux.ParamByName('NOVCOD').AsString := fStrZero(StrToInt(Result)+1, 3);
  qryAux.ParamByName('CODSFZ').AsString := strCodSfz;
  qryAux.ExecSQL;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

end.
