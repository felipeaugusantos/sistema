unit untLinMetDAO;

interface

uses
  untLinMet, System.SysUtils, Uni, UniClientDataSet, Data.DB;

type
  TLinMetDAO = class
  private
    qryTabela: TUniQuery;
    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
    procedure pPreencheParametrosQuery(objDados: TLinMet);
    procedure pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
    function fMontaObjModel(objDados: TDataSet): TLinMet;
    function fExecutaDelete(strCondicao: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TLinMet): Boolean;
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fDeletar(strAutInc: String): Boolean;
    function fDeletarColecao(strComLin: String): Boolean;
    procedure pCarregaLista(strComLin: String; Var cdsBusca: TUniClientDataSet);
  end;

implementation

uses
  untFuncoesSimples;

{ TLinMetDAO }

constructor TLinMetDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TLinMetDAO.Destroy;
begin
  FreeAndNil(qryTabela);
end;

function TLinMetDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO LINMET (  '+
            '    AUTOINCREM,         '+
            '    LMT_CODLIN,         '+
            '    LMT_VLRMET,         '+
            '    LMT_PERFAT,         '+
            '    LMT_PERMIX,         '+
            '    LMT_PERMAR,         '+
            '    LMT_COMLIN          '+
            '  )                     '+
            '  VALUES                '+
            '    (                   '+
            '     :AUTINC,           '+
            '     :CODLIN,           '+
            '     :VLRMET,           '+
            '     :PERFAT,           '+
            '     :PERMIX,           '+
            '     :PERMAR,           '+
            '     :COMLIN            '+
            '    )                   ';
end;

function TLinMetDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    LINMET                  '+
            '  SET                       '+
            '    LMT_CODLIN = :CODLIN,   '+
            '    LMT_VLRMET = :VLRMET,   '+
            '    LMT_PERFAT = :PERFAT,   '+
            '    LMT_PERMIX = :PERMIX,   '+
            '    LMT_PERMAR = :PERMAR,   '+
            '    LMT_COMLIN = :COMLIN    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TLinMetDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT                       '+
            '    LINMET.AUTOINCREM,         '+
            '    LMT_CODLIN,                '+
            '    LMT_VLRMET,                '+
            '    LMT_PERFAT,                '+
            '    LMT_PERMIX,                '+
            '    LMT_PERMAR,                '+
            '    LMT_COMLIN                 '+
            '  FROM                         '+
            '    LINMET                     '+
            #13 + strCondicao;
end;

function TLinMetDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM LINMET        '+
            #13 + strCondicao;
end;

function TLinMetDAO.fMontaSQLCondicao(arrCampos, arrValores: Array Of String): String;
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

procedure TLinMetDAO.pIncluiCondicaoSQLWhere(Var strSQLWhere: String; strCondicao: String);
begin
  If (Not fEmptyStr(strSQLWhere)) Then
    strSQLWhere := strSQLWhere + #13 + ' AND ';

  strSQLWhere := strSQLWhere + strCondicao;
end;

procedure TLinMetDAO.pCarregaLista(strComLin: String; Var cdsBusca: TUniClientDataSet);
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(fMontaSQLCondicao(['LMT_COMLIN'], [strComLin]));

  If (cdsBusca.Active) Then
  Begin
    cdsBusca.EmptyDataSet;
    cdsBusca.Close;
  End;

  cdsBusca.SetProvider(qryTabela);
  cdsBusca.Open;
  cdsBusca.SetProvider(Nil);
end;

function TLinMetDAO.fDeletar(strAutInc: String): Boolean;
begin
  Result := fExecutaDelete(fMontaSQLCondicao(['AUTOINCREM'], [strAutInc]));
end;

function TLinMetDAO.fDeletarColecao(strComLin: String): Boolean;
begin
  Result := fExecutaDelete(fMontaSQLCondicao(['LMT_COMLIN'], [strComLin]));
end;

function TLinMetDAO.fExecutaDelete(strCondicao: String): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := fRetornaSQLDelete(strCondicao);
    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TLinMetDAO.fGravar(objDados: TlinMet): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := IIF(fEmptyStr(objDados.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);

    pPreencheParametrosQuery(objDados);
    qryTabela.ExecSQL;

    Result := fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TLinMetDAO.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
begin
  Result := False;
  cdsDados.First;

  While (Not cdsDados.Eof) Do
  Begin
    If (Not fGravar(fMontaObjModel(cdsDados))) Then
      Exit;
    cdsDados.Next;
  End;

   Result := True;
end;

procedure TLinMetDAO.pPreencheParametrosQuery(objDados: TLinMet);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('LINMET', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODLIN').AsString := objDados.getCodLin();
  qryTabela.ParamByName('COMLIN').AsString := objDados.getComLin();
  qryTabela.ParamByName('VLRMET').AsFloat  := objDados.getVlrMet();
  qryTabela.ParamByName('PERFAT').AsFloat  := objDados.getPerFat();
  qryTabela.ParamByName('PERMIX').AsFloat  := objDados.getPerMix();
  qryTabela.ParamByName('PERMAR').AsFloat  := objDados.getPerMar();
end;

function TLinMetDAO.fMontaObjModel(objDados: TDataSet): TLinMet;
begin
  Result := TLinMet.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('LMT_CODLIN').AsString,
                           objDados.FieldByName('LMT_COMLIN').AsString,
                           objDados.FieldByName('LMT_VLRMET').AsFloat,
                           objDados.FieldByName('LMT_PERFAT').AsFloat,
                           objDados.FieldByName('LMT_PERMIX').AsFloat,
                           objDados.FieldByName('LMT_PERMAR').AsFloat);
end;

end.
