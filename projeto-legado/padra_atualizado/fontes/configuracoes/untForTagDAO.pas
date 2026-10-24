unit untForTagDAO;

interface

uses Uni, SqlExpr, SimpleDS, Db, Classes, SysUtils, DateUtils,
     untForTagModel, UniClientDataSet;

type
  TForTagDAO = Class
    private
      function fRetornaSQLDelete(strCondicao: String): String;
      function fRetornaSQLSelect(strCondicao: String): String;
      function fPreencheSQLWhere(strCondicao: String): String;
      function fRetornaSQLInsert: String;
    public
      function fGravar(objForTagModel: TForTagModel): Boolean;
      function fInserirColecao(objColForTag: TColForTagModel): Boolean;
      function fExisteRegistro(strCondicao: String): Boolean;
      procedure pDeletar(strCondicao: String);
      procedure pCarregarCDS(Var cdsForTag: TUniClientDataSet; strCondicao: String);
    end;

implementation

uses untFuncoesSimples;

{ TForTagDAO }

function TForTagDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := 'DELETE FROM FORTAG ' + fPreencheSQLWhere(strCondicao);
end;

function TForTagDAO.fRetornaSQLInsert: String;
begin
  Result := 'INSERT INTO FORTAG (           '+
            '  FTG_CODFOR,                  '+
            '  FTG_CODEMP,                  '+
            '  AUTOINCREM                   '+
            ')                              '+
            'VALUES                         '+
            '  (:CODFOR, :CODEMP, :AUTINC)  ';
end;

function TForTagDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := 'SELECT                      '+
            '  FTG_CODFOR AS CODFOR,     '+
            '  FOR_NOMFOR AS NOMFOR,     '+
            '  FTG_CODEMP AS CODEMP      '+
            'FROM                        '+
            '  FORTAG                    '+
            'INNER JOIN CADFOR ON        '+
            '  FOR_CODFOR = FTG_CODFOR   '+
            fPreencheSQLWhere(strCondicao);
end;

function TForTagDAO.fPreencheSQLWhere(strCondicao: String): String;
begin
  if pos('WHERE', UpperCase(strCondicao)) > 0 then
    Result := UpperCase(strCondicao)
  else if strCondicao <> '' then
    Result := ' WHERE ' + UpperCase(strCondicao);
end;

procedure TForTagDAO.pCarregarCDS(Var cdsForTag: TUniClientDataSet; strCondicao: String);
  Var
    qryForTag: TUniQuery;
begin
  qryForTag := fCriaQuery;

  Try
    Try
      qryForTag.Close;
      qryForTag.SQL.Clear;
      qryForTag.SQL.Text := fRetornaSQLSelect(strCondicao);
      qryForTag.Open;

      If (qryForTag.IsEmpty) Then
        Exit;

      While(Not qryForTag.Eof) Do
      Begin
        cdsForTag.Append;
        cdsForTag.FieldByName('CODFOR').AsString := qryForTag.FieldByName('CODFOR').AsString;
        cdsForTag.FieldByName('NOMFOR').AsString := qryForTag.FieldByName('NOMFOR').AsString;
        cdsForTag.FieldByName('CODEMP').AsString := qryForTag.FieldByName('CODEMP').AsString;
        cdsForTag.Post;
        qryForTag.Next;
      End;
    Except
      On E: Exception Do
        Raise Exception.Create('Falha ao carregar fornecedores.' + E.Message);
    End;
  Finally
    FreeAndNil(qryForTag);
  End;
end;

procedure TForTagDAO.pDeletar(strCondicao: String);
  Var
    qryForTag: TUniQuery;
begin
  qryForTag := fCriaQuery;

  Try
    Try
      fStartTransaction;

      qryForTag.Close;
      qryForTag.SQL.Clear;
      qryForTag.SQL.Text := fRetornaSQLDelete(strCondicao);
      qryForTag.ExecSQL;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise Exception.Create('Falha ao deletar fornecedores.' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryForTag);
  End;
end;

function TForTagDAO.fGravar(objForTagModel: TForTagModel): Boolean;
  Var
    qryForTag: TUniQuery;
begin
  Result := False;
  qryForTag := fCriaQuery;

  Try
    Try
      fStartTransaction;

      qryForTag.Close;
      qryForTag.SQL.Clear;
      qryForTag.SQL.Text := fRetornaSQLInsert;
      qryForTag.ParamByName('CODFOR').AsString := objForTagModel.strCodFor;
      qryForTag.ParamByName('CODEMP').AsString := objForTagModel.strCodEmp;
      qryForTag.ParamByName('AUTINC').AsString := fRetAutoIncrem('FORTAG', objForTagModel.strCodEmp);
      qryForTag.ExecSQL;

      fCommit;
      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        Raise Exception.Create('Falha ao gravar fornecedores.' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryForTag);
  End;
end;

function TForTagDAO.fInserirColecao(objColForTag: TColForTagModel): Boolean;
  Var
    intCont: Integer;
begin
  Result := False;

  For intCont := 0 To Pred(objColForTag.Count) Do
  Begin
    If (Not fGravar(objColForTag[intCont])) Then
      Exit;
  End;

  Result := True;
end;

function TForTagDAO.fExisteRegistro(strCondicao: String): Boolean;
  Var
    qryForTag: TUniQuery;
begin
  Result := False;
  qryForTag := fCriaQuery;

  Try
    Try
      qryForTag.Close;
      qryForTag.SQL.Clear;
      qryForTag.SQL.Text := fRetornaSQLSelect(strCondicao);
      qryForTag.Open;

      If (qryForTag.IsEmpty) Then
        Exit;

      Result := qryForTag.RecordCount > 0;
    Except
      On E: Exception Do
        Raise Exception.Create('Falha ao carregar fornecedores.' + E.Message);
    End;
  Finally
    FreeAndNil(qryForTag);
  End;
end;

end.
