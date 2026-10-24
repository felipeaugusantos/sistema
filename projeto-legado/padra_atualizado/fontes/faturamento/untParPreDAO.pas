unit untParPreDAO;

interface

uses
  System.SysUtils, Uni, untParPre, Data.DB, UniClientDataSet;

Type
  TObjDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLDelete(strCondicao: String): String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fMontaObjModel(objDados: TDataSet): TParPre;
    function fExecutaTransacao(strSQL: String; objDados: TParPre = Nil): Boolean;
    procedure pPreencheParametrosQuery(objDados: TParPre);
  public
    constructor Create;
    destructor Destroy; override;

    function fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
    function fGravar(objDados: TParPre): Boolean;
    function fDeletarPorEmpresa(strCodEmp: String): Boolean;
    function fDeletarPorAutInc(strAutInc: String): Boolean;
    function fBuscaPorValor(fltVlrFat: Double; strCodEmp: String): TParPre;
    procedure pCarregaLista(strCodEmp: String; Var cdsBusca: TUniClientDataSet);
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
  Result := '  INSERT INTO PARPRE (   '+
            '    AUTOINCREM,          '+
            '    PRE_CODEMP,          '+
            '    PRE_VLRFAT,          '+
            '    PRE_METATI,          '+
            '    PRE_1CSABA,          '+
            '    PRE_1CSACI,          '+
            '    PRE_2CSACI           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :CODEMP,           '+
            '      :VLRFAT,           '+
            '      :METATI,           '+
            '      :1CSABA,           '+
            '      :1CSACI,           '+
            '      :2CSACI            '+
            '    )                    ';
end;

function TObjDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := ' DELETE FROM PARPRE '+
            #13 + strCondicao;
end;

function TObjDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := ' SELECT * FROM PARPRE '+
            #13 + strCondicao;
end;

function TObjDAO.fGravar(objDados: TParPre): Boolean;
  Var
    strSQL: String;
begin
  strSQL := fRetornaSQLInsert;
  Result := fExecutaTransacao(strSQL, objDados);
end;

function TObjDAO.fDeletarPorEmpresa(strCodEmp: String): Boolean;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PRE_CODEMP = '+ QuotedStr(strCodEmp);

  Result := fExecutaTransacao(fRetornaSQLDelete(strCondicao));
end;

function TObjDAO.fDeletarPorAutInc(strAutInc: String): Boolean;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE AUTOINCREM = '+ QuotedStr(strAutInc);

  Result := fExecutaTransacao(fRetornaSQLDelete(strCondicao));
end;

function TObjDAO.fBuscaPorValor(fltVlrFat: Double; strCodEmp: String): TParPre;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PRE_VLRFAT = :VLRFAT AND PRE_CODEMP = :CODEMP';

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryTabela.ParamByName('VLRFAT').AsFloat := fltVlrFat;
  qryTabela.ParamByName('CODEMP').AsString := strCodEmp;
  qryTabela.Open;

  Result := fMontaObjModel(qryTabela);
end;

function TObjDAO.fExecutaTransacao(strSQL: String; objDados: TParPre = Nil): Boolean;
begin
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
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TObjDAO.fGravarColecao(cdsDados: TUniClientDataSet): Boolean;
  Var
    objModel: TParPre;
begin
  Result := False;
  cdsDados.First;

  While (Not cdsDados.Eof) Do
  Begin
    objModel := fMontaObjModel(cdsDados);

    Try
      If (Not fGravar(objModel)) Then
        Exit;

      cdsDados.Next;
    Finally
      FreeAndNil(objModel);
    End;
  End;

  Result := True;
end;

procedure TObjDAO.pCarregaLista(strCodEmp: String; Var cdsBusca: TUniClientDataSet);
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PRE_CODEMP = '+ QuotedStr(strCodEmp);

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);

  If (cdsBusca.Active) Then
  Begin
    cdsBusca.EmptyDataSet;
    cdsBusca.Close;
  End;

  cdsBusca.SetProvider(qryTabela);
  cdsBusca.Open;
  cdsBusca.SetProvider(Nil);
end;

procedure TObjDAO.pPreencheParametrosQuery(objDados: TParPre);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('PARPRE', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('CODEMP').AsString := objDados.getCodEmp();
  qryTabela.ParamByName('VLRFAT').AsFloat  := objDados.getVlrFat();
  qryTabela.ParamByName('METATI').AsFloat  := objDados.getMetAti();
  qryTabela.ParamByName('1CSABA').AsFloat  := objDados.get1CsAba();
  qryTabela.ParamByName('1CSACI').AsFloat  := objDados.get1CsAci();
  qryTabela.ParamByName('2CSACI').AsFloat  := objDados.get2CsAci();
end;

function TObjDAO.fMontaObjModel(objDados: TDataSet): TParPre;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TParPre.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('PRE_CODEMP').AsString,
                           objDados.FieldByName('PRE_VLRFAT').AsFloat,
                           objDados.FieldByName('PRE_METATI').AsFloat,
                           objDados.FieldByName('PRE_1CSABA').AsFloat,
                           objDados.FieldByName('PRE_1CSACI').AsFloat,
                           objDados.FieldByName('PRE_2CSACI').AsFloat);
end;

end.
