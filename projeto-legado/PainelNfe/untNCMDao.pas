unit untNCMDao;

interface

uses
  {$IF Defined(UNIDAC)}
    Uni, DBAccess,
  {$ELSE}
    ZDataset,
  {$IFEND}
  SqlExpr, SimpleDS, Db, Classes, SysUtils, DateUtils, untNCMModel;

type
  TNCMDao = Class
    private
      function fPreencheSQLWhere(strCondicao: String): String;
      function fRetonaSQLSelect(strCondicao: String): String;
      function fRetornaSQLUpdateItemEspecial(strCondicao, strCodNCM: String): String;
    public
      function fRetornaNCM(strCondicao: String): TNCMModel;
      function fAtualizaNCMItemEspecial(strCondicao, strCodNCM: String): Boolean;
    end;

implementation

uses
  untUtil;

function TNCMDao.fRetornaNCM(strCondicao: String): TNCMModel;
var
  qryConsulta: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  Result := nil;
  qryConsulta := fCriaQuery(nil);
  try
    try
      qryConsulta.Close;
      qryConsulta.SQL. Clear;
      qryConsulta.SQL.Text := fRetonaSQLSelect(strCondicao);
      qryConsulta.Open;

      if not qryConsulta.IsEmpty then
      begin
        Result := TNCMModel.Create;
        Result.strAutInc := qryConsulta.FieldByName('AUTOINCREM').AsString;
        Result.strCodNCM := qryConsulta.FieldByName('NCM_CODNCM').AsString;
        Result.strDescri := qryConsulta.FieldByName('NCM_DESCRI').AsString;
      end;

    finally
      FreeAndNil(qryConsulta);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create('Não foi possível retornar os registros da '+
        'tabela CADNCM.'+#13+ 'Motivo: '+e.Message);
    end;
  end;
end;

function TNCMDao.fRetonaSQLSelect(strCondicao: String): String;
begin
  Result := 'SELECT * FROM CADNCM ' + fPreencheSQLWhere(strCondicao) +
     ' ORDER BY NCM_CODNCM';
end;

function TNCMDao.fAtualizaNCMItemEspecial(strCondicao, strCodNCM: String): Boolean;
var
  qryMovTri: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryMovTri := fCriaQuery(nil);
  try
    try
      qryMovTri.Connection.StartTransaction;
      qryMovTri.Close;
      qryMovTri.SQL. Clear;
      qryMovTri.SQL.Text := fRetornaSQLUpdateItemEspecial(strCondicao, strCodNCM);
      qryMovTri.ExecSQL;
      qryMovTri.Connection.Commit;
      Result := True;
    finally
      FreeAndNil(qryMovTri);
    end;
  except
    on E: Exception do
    begin
      qryMovTri.Connection.Rollback;
      raise Exception.Create('Não foi possível alterar o registro da '+
        'tabela MOVTRI.'+#13+ 'Motivo: '+e.Message);
    end;
  end;
end;

function TNCMDao.fRetornaSQLUpdateItemEspecial(strCondicao, strCodNCM: String): String;
begin
  Result := 'UPDATE MOVTRI SET DET_NCMITE = ' + QuotedStr(strCodNCM) + ' ' +
    fPreencheSQLWhere(strCondicao);
end;

function TNCMDao.fPreencheSQLWhere(strCondicao: String): String;
begin
  if pos('WHERE', UpperCase(strCondicao)) > 0 then
    Result := UpperCase(strCondicao)
  else if strCondicao <> '' then
    Result := ' WHERE ' + UpperCase(strCondicao);
end;

end.
