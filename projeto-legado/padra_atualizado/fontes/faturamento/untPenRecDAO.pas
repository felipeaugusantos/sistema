unit untPenRecDAO;

interface

uses
  System.SysUtils, Uni, untPenRec, Data.DB, UniClientDataSet;

Type
  TPenRecDAO = class
  private
    qryTabela: TUniQuery;

    function fRetornaSQLInsert: String;
    function fRetornaSQLUpdate: String;
    function fRetornaSQLSelect(strCondicao: String): String;
    function fExecutaConsulta(strCondicao: String): TPenRec;
    function fMontaObjModel(objDados: TDataSet): TPenRec;
    procedure pPreencheParametrosQuery(objDados: TPenRec);
    function fExecutaDelete(strCondicao: String): Boolean;
    function fRetornaSQLDelete(strCondicao: String): String;
  public
    constructor Create;
    destructor Destroy; override;
    function fGravar(objDados: TPenRec): Boolean;
    function fBuscaPorPedido(strNumDoc, strEspDoc, strCodEmp: String): TPenRec;
    function fDeletar(strAutInc: String): Boolean;
    function fBuscaPorItemPedido(strCodIte, strNumDoc, strEspDoc, strCodEmp: String): TPenRec;
    procedure pCarregaLista(strNumDoc, strEspDoc, strCodEmp: String; var cdsBusca: TUniClientDataSet);
  end;

implementation

uses
  untFuncoesSimples;

constructor TPenRecDAO.Create;
begin
  qryTabela := fCriaQuery;
end;

destructor TPenRecDAO.Destroy;
begin
  inherited;
  FreeAndNil(qryTabela);
end;

function TPenRecDAO.fRetornaSQLInsert: String;
begin
  Result := '  INSERT INTO PENREC (   '+
            '    AUTOINCREM,          '+
            '    PEN_DTAENT,          '+
            '    PEN_HORENT,          '+
            '    PEN_NUMDOC,          '+
            '    PEN_ESPDOC,          '+
            '    PEN_CODEMP,          '+
            '    PEN_CODCLI,          '+
            '    PEN_CODITE,          '+
            '    PEN_TOTITE,          '+
            '    PEN_STATUS,          '+
            '    PEN_DOCREC,          '+
            '    PEN_ESPREC,          '+
            '    PEN_QTDITE,          '+
            '    PEN_EMPREC           '+
            '  )                      '+
            '  VALUES                 '+
            '    (                    '+
            '      :AUTINC,           '+
            '      :DTAENT,           '+
            '      :HORENT,           '+
            '      :NUMDOC,           '+
            '      :ESPDOC,           '+
            '      :CODEMP,           '+
            '      :CODCLI,           '+
            '      :CODITE,           '+
            '      :TOTITE,           '+
            '      :STATUS,           '+
            '      :DOCREC,           '+
            '      :ESPREC,           '+
            '      :QTDITE,           '+
            '      :EMPREC            '+
            '    )                    ';
end;

function TPenRecDAO.fRetornaSQLUpdate: String;
begin
  Result := '  UPDATE                    '+
            '    PENREC                  '+
            '  SET                       '+
            '    PEN_DTAENT = :DTAENT,   '+
            '    PEN_HORENT = :HORENT,   '+
            '    PEN_NUMDOC = :NUMDOC,   '+
            '    PEN_ESPDOC = :ESPDOC,   '+
            '    PEN_CODEMP = :CODEMP,   '+
            '    PEN_CODCLI = :CODCLI,   '+
            '    PEN_CODITE = :CODITE,   '+
            '    PEN_TOTITE = :TOTITE,   '+
            '    PEN_STATUS = :STATUS,   '+
            '    PEN_DOCREC = :DOCREC,   '+
            '    PEN_ESPREC = :ESPREC,   '+
            '    PEN_QTDITE = :QTDITE,   '+
            '    PEN_EMPREC = :EMPREC    '+
            '  WHERE                     '+
            '    AUTOINCREM = :AUTINC    ';
end;

function TPenRecDAO.fRetornaSQLSelect(strCondicao: String): String;
begin
  Result := '  SELECT * FROM PENREC      '+
            #13 + strCondicao;
end;

function TPenRecDAO.fRetornaSQLDelete(strCondicao: String): String;
begin
  Result := '  DELETE FROM PENREC        '+
            #13 + strCondicao;
end;

function TPenRecDAO.fBuscaPorPedido(strNumDoc, strEspDoc, strCodEmp: String): TPenRec;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PEN_NUMDOC  = '+ QuotedStr(strNumDoc) +
                 '   AND PEN_ESPDOC  = '+ QuotedStr(strEspDoc) +
                 '   AND PEN_CODEMP  = '+ QuotedStr(strCodEmp);

  Result := fExecutaConsulta(strCondicao);
end;

function TPenRecDAO.fBuscaPorItemPedido(strCodIte, strNumDoc, strEspDoc, strCodEmp: String): TPenRec;
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PEN_NUMDOC  = '+ QuotedStr(strNumDoc) +
                 '   AND PEN_ESPDOC  = '+ QuotedStr(strEspDoc) +
                 '   AND PEN_CODEMP  = '+ QuotedStr(strCodEmp) +
                 '   AND PEN_CODITE  = '+ QuotedStr(strCodIte);

  Result := fExecutaConsulta(strCondicao);
end;

function TPenRecDAO.fGravar(objDados: TPenRec): Boolean;
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

procedure TPenRecDAO.pCarregaLista(strNumDoc, strEspDoc, strCodEmp: String; Var cdsBusca: TUniClientDataSet);
  Var
    strCondicao: String;
begin
  strCondicao := ' WHERE PEN_NUMDOC  = '+ QuotedStr(strNumDoc) +
                 '   AND PEN_ESPDOC  = '+ QuotedStr(strEspDoc) +
                 '   AND PEN_CODEMP  = '+ QuotedStr(strCodEmp);

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);

  If (cdsBusca.Active) Then
  Begin
    cdsBusca.EmptyDataSet;
    cdsBusca.Fields.Clear;
    cdsBusca.FieldDefs.Clear;
    cdsBusca.Close;
  End;

  cdsBusca.SetProvider(qryTabela);
  cdsBusca.Open;
  cdsBusca.SetProvider(Nil);
end;

function TPenRecDAO.fDeletar(strAutInc: String): Boolean;
begin
  Result := fExecutaDelete(' WHERE AUTOINCREM = ' + QuotedStr(strAutInc));
end;

function TPenRecDAO.fExecutaDelete(strCondicao: String): Boolean;
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

procedure TPenRecDAO.pPreencheParametrosQuery(objDados: TPenRec);
begin
  If (qryTabela.ParamByName('AUTINC') <> Nil) Then
  Begin
    If (fEmptyStr(objDados.getAutInc)) Then
      qryTabela.ParamByName('AUTINC').AsString := fRetAutoIncrem('PENREC', VS_strCodEmp)
    Else
      qryTabela.ParamByName('AUTINC').AsString := objDados.getAutInc;
  End;

  qryTabela.ParamByName('NUMDOC').AsString   := objDados.getNumDoc;
  qryTabela.ParamByName('ESPDOC').AsString   := objDados.getEspDoc;
  qryTabela.ParamByName('CODEMP').AsString   := objDados.getCodEmp;
  qryTabela.ParamByName('CODCLI').AsString   := objDados.getCodCli;
  qryTabela.ParamByName('CODITE').AsString   := objDados.getCodIte;
  qryTabela.ParamByName('STATUS').AsString   := objDados.getStatus;
  qryTabela.ParamByName('DOCREC').AsString   := objDados.getDocRec;
  qryTabela.ParamByName('ESPREC').AsString   := objDados.getEspRec;
  qryTabela.ParamByName('EMPREC').AsString   := objDados.getEmpRec;
  qryTabela.ParamByName('TOTITE').AsFloat    := objDados.getTotIte;
  qryTabela.ParamByName('DTAENT').AsDateTime := objDados.getDtaEnt;
  qryTabela.ParamByName('HORENT').AsDateTime := objDados.getHorEnt;
  qryTabela.ParamByName('QTDITE').AsFloat    := objDados.getQtdIte;
end;

function TPenRecDAO.fExecutaConsulta(strCondicao: String): TPenRec;
begin
  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Text := fRetornaSQLSelect(strCondicao);
  qryTabela.Open;

  Result := fMontaObjModel(qryTabela);
end;

function TPenRecDAO.fMontaObjModel(objDados: TDataSet): TPenRec;
begin
  Result := Nil;

  If (objDados.IsEmpty) Then
    Exit;

  Result := TPenRec.Create(objDados.FieldByName('AUTOINCREM').AsString,
                           objDados.FieldByName('PEN_NUMDOC').AsString,
                           objDados.FieldByName('PEN_ESPDOC').AsString,
                           objDados.FieldByName('PEN_CODEMP').AsString,
                           objDados.FieldByName('PEN_CODCLI').AsString,
                           objDados.FieldByName('PEN_CODITE').AsString,
                           objDados.FieldByName('PEN_STATUS').AsString,
                           objDados.FieldByName('PEN_DOCREC').AsString,
                           objDados.FieldByName('PEN_ESPREC').AsString,
                           objDados.FieldByName('PEN_EMPREC').AsString,
                           objDados.FieldByName('PEN_TOTITE').AsFloat,
                           objDados.FieldByName('PEN_DTAENT').AsDateTime,
                           objDados.FieldByName('PEN_HORENT').AsDateTime,
                           objDados.FieldByName('PEN_QTDITE').AsFloat);
end;

end.

