unit untDepTabDAO;

interface

uses
  untDepTab, System.SysUtils, Uni, UniClientDataSet, Data.DB;

type
  TDepTabDAO = class
  private
    qryDepTab: TUniQuery;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
    procedure pPreencheParametrosQryDepTab(objDepTab: TDepTab);
    procedure pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
    function fMontaObjDepTab(objDados: TDataSet): TDepTab;
    function fExecutaDelete(strCondicao: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDepTab: TDepTab): Boolean;
    function fGravarColecao(cdsDepTab: TUniClientDataSet): Boolean;
    function fDeletar(strAutInc: String): Boolean;
    function fDeletarColecao(strCodCom: String): Boolean;
    procedure pCarregaLista(strCodCom: String; Var cdsBusca: TUniClientDataSet);
  end;

implementation

uses
  untFuncoesSimples;

{ TDepTabDAO }

constructor TDepTabDAO.Create;
begin
  qryDepTab := fCriaQuery;
end;

destructor TDepTabDAO.Destroy;
begin
  FreeAndNil(qryDepTab);
end;

function TDepTabDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO DEPTAB (  '+
            '    AUTOINCREM,         '+
            '    DTB_CODCOM,         '+
            '    DTB_CODTAB,         '+
            '    DTB_PERCOM          '+
            '  )                     '+
            '  VALUES                '+
            '    (                   '+
            '     :AUTINC,           '+
            '     :CODCOM,           '+
            '     :CODTAB,           '+
            '     :PERCOM            '+
            '    )                   ';
end;

function TDepTabDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    DEPTAB                  '+
            '  SET                       '+
            '    DTB_CODCOM = :CODCOM,   '+
            '    DTB_CODTAB = :CODTAB,   '+
            '    DTB_PERCOM = :PERCOM    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TDepTabDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM DEPTAB      '+
            #13 + strCondicao;
end;

function TDepTabDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM DEPTAB        '+
            #13 + strCondicao;
end;

function TDepTabDAO.fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
  Var
    strSQLWhere: String;
    strCondicao: String;
    intIndex: Integer;
begin
  For intIndex := 0 To Length(arrCampos) - 1 Do
  Begin
    strCondicao := arrCampos[intIndex] + ' = ' + QuotedStr(arrValores[intIndex]);
    pIncluiCondicaoSQLWhere(strSQLWhere, strCondicao);
  End;

  strSQLWhere := #13 + ' WHERE ' + #13 + strSQLWhere;

  Result := strSQLWhere;
end;

procedure TDepTabDAO.pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
begin
  If (Not fEmptyStr(strSQLWhere)) Then
    strSQLWhere := strSQLWhere + #13 + ' AND ';

  strSQLWhere := strSQLWhere + strCondicao;
end;

procedure TDepTabDAO.pCarregaLista(strCodCom: String; Var cdsBusca: TUniClientDataSet);
begin
  qryDepTab.Close;
  qryDepTab.SQL.Clear;
  qryDepTab.SQL.Text := fRetornaSQLSelect(fMontaSQLCondicao(['DTB_CODCOM'], [strCodCom]));

  If (cdsBusca.Active) Then
  Begin
    cdsBusca.EmptyDataSet;
    cdsBusca.Fields.Clear;
    cdsBusca.FieldDefs.Clear;
    cdsBusca.Close;
  End;

  cdsBusca.SetProvider(qryDepTab);
  cdsBusca.Open;
  cdsBusca.SetProvider(Nil);
end;

function TDepTabDAO.fDeletar(strAutInc: String): Boolean;
begin
  Result := fExecutaDelete(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
end;

function TDepTabDAO.fDeletarColecao(strCodCom: String): Boolean;
begin
  Result := fExecutaDelete(fMontaSQLCondicao(['DTB_CODCOM'], [strCodCom]));
end;

function TDepTabDAO.fExecutaDelete(strCondicao: String): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryDepTab.Close;
    qryDepTab.SQL.Clear;
    qryDepTab.SQL.Text := fRetornaSQLDelete(strCondicao);
    qryDepTab.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TDepTabDAO.fGravar(objDepTab: TDepTab): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryDepTab.Close;
    qryDepTab.SQL.Clear;
    qryDepTab.SQL.Text := IIF(fEmptyStr(objDepTab.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);

    pPreencheParametrosQryDepTab(objDepTab);
    qryDepTab.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TDepTabDAO.fGravarColecao(cdsDepTab: TUniClientDataSet): Boolean;
begin
  Result := False;
  cdsDepTab.First;

  While (Not cdsDepTab.Eof) Do
  Begin
    If (Not fGravar(fMontaObjDepTab(cdsDepTab))) Then
      Exit;
    cdsDepTab.Next;
  End;

   Result := True;
end;

procedure TDepTabDAO.pPreencheParametrosQryDepTab(objDepTab: TDepTab);
begin
  If (qryDepTab.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDepTab.getAutInc)) Then
      qryDepTab.ParamByName('AUTINC').AsString := fRetAutoIncrem('DEPTAB', VS_strCodEmp)
    Else
      qryDepTab.ParamByName('AUTINC').AsString := objDepTab.getAutInc;
  End;

  qryDepTab.ParamByName('CODCOM').AsString := objDepTab.getCodCom();
  qryDepTab.ParamByName('CODTAB').AsString := objDepTab.getCodTab();
  qryDepTab.ParamByName('PERCOM').AsFloat  := objDepTab.getPerCom();
end;

function TDepTabDAO.fMontaObjDepTab(objDados: TDataSet): TDepTab;
begin
  Result := TDepTab.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('DTB_CODCOM').AsString,
                           objDados.FieldByName('DTB_CODTAB').AsString,
                           objDados.FieldByName('DTB_PERCOM').AsFloat);
end;

end.
