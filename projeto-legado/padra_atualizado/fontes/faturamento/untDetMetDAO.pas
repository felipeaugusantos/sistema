unit untDetMetDAO;

interface

uses
  System.SysUtils, Uni, untDetMet, Data.DB, UniClientDataSet;

Type
  TObjDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fMontaObjModel(objDados: TDataSet): TDetMet;
    function fExecutaTransacao(strSQL: String; objDados: TDetMet = Nil): Boolean;
    procedure pPreencheParametrosQuery(objDados: TDetMet);
  public
    constructor Create;
    destructor Destroy; override;
    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fGravar(objDados: TDetMet): Boolean;
    function fDeletarPorPeriodo(strCodVen, strMesAno: String): Boolean;
  end;

implementation

uses
  untFuncoesSimples;

constructor TObjDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TObjDAO.Destroy;
begin
  inherited;
  FreeAndNil(qryTabela);
end;

function TObjDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO DETMET (   '+
            '    AUTOINCREM,          '+
            '    MET_CODEMP,          '+
            '    MET_CODVEN,          '+
            '    MET_MESANO,          '+
            '    MET_CODGRU,          '+
            '    MET_DEFTIP,          '+
            '    MET_PERGRU,          '+
            '    MET_MARGRU           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODEMP,           '+
            '      :CODVEN,           '+
            '      :MESANO,           '+
            '      :CODGRU,           '+
            '      :DEFTIP,           '+
            '      :PERGRU,           '+
            '      :MARGRU            '+
            '    )                    ';
end;

function TObjDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    DETMET                  '+
            '  SET                       '+
            '    MET_CODEMP = :CODEMP,   '+
            '    MET_CODVEN = :CODVEN,   '+
            '    MET_MESANO = :MESANO,   '+
            '    MET_CODGRU = :CODFRU,   '+
            '    MET_DEFTIP = :DEFTIP,   '+
            '    MET_PERGRU = :PERGRU    '+
            '    MET_MARGRU = :MARGRU    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TObjDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := ' DELETE FROM DETMET '+
            #13 + strCondicao;
end;

function TObjDAO.fGravar(objDados: TDetMet): Boolean;
  Var
    strSQL: String;
begin
  strSQL := IIF(fEmptyStr(objDados.getAutInc), fRetornaSQLInsert, fRetornaSQLUpdate);
  Result := fExecutaTransacao(strSQL, objDados);
end;

function TObjDAO.fDeletarPorPeriodo(strCodVen, strMesAno: String): Boolean;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE MET_CODVEN  = '+ QuotedStr(strCodVen)+
                 '   AND MET_MESANO  = '+ QuotedStr(strMesAno);

  Result := fExecutaTransacao(fRetornaSQLDelete(strCondicao));
end;

function TObjDAO.fExecutaTransacao(strSQL: String; objDados: TDetMet = Nil): Boolean;
begin
  Result := False;

  Try
    fStartTransaction;

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Text := strSQL;

    If (Assigned(objDados)) Then
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

function TObjDAO.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
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

procedure TObjDAO.pPreencheParametrosQuery(objDados: TDetMet);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('DETMET', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('CODVEN').AsString := objDados.getCodVen();
  qryTabela.ParamByName('MESANO').AsString := objDados.getMesAno();
  qryTabela.ParamByName('CODGRU').AsString := objDados.getCodGru();
  qryTabela.ParamByName('DEFTIP').AsString := objDados.getDefTip();
  qryTabela.ParamByName('PERGRU').AsFloat  := objDados.getPerGru();
  qryTabela.ParamByName('MARGRU').AsFloat  := objDados.getMarGru();
end;

function TObjDAO.fMontaObjModel(objDados: TDataSet): TDetMet;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TDetMet.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('MET_CODEMP').AsString,
                           objDados.FieldByName('MET_MESANO').AsString,
                           objDados.FieldByName('MET_CODVEN').AsString,
                           objDados.FieldByName('MET_CODGRU').AsString,
                           objDados.FieldByName('MET_DEFTIP').AsString,
                           objDados.FieldByName('MET_PERGRU').AsFloat,
                           objDados.FieldByName('MET_MARGRU').AsFloat);
end;

end.
