unit untDocFaturaContrato;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni, System.Variants, untValorPorExtenso;

type
  TLeDocumentoFaturaLoc = class(TLeDocumento)
  private
    cdsMovGer,
    cdsDupCont,
    cdsNumParc: TZClient;

    Function fInsereClientContrato: Boolean;
    Function fInsereClientDupCont: Boolean;
    Function fInsereClientNumParcel: Boolean;
    function fSQLContrato: String;
    function fSQLDupCont: String;
    function fSQLNumParcel: String;
    procedure pSetaTotais;
    function fRetornaMesReferencia(intMes: integer): String;
    function fNumeroParcela(strParc: String): String;
    procedure pRetMesParc;

  protected
    Procedure pSetaParametrosCadcli; Override;

  public
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
    Constructor Create(Owner: TComponent); Override;
    Destructor  Destroy; Override;
  end;

implementation

uses
  untObservacao;

{ TLeDocumentoFaturaLoc }

function TLeDocumentoFaturaLoc.fSQLContrato: String;
  Var
    strSQL: String;
begin
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '       GER_CIDCON, ';
  strSQL := strSQL + '       GER_ENDCON, ';
  strSQL := strSQL + '       GER_BAICON, ';
  strSQL := strSQL + '       GER_CEPCON, ';
  strSQL := strSQL + '       GER_TELCON, ';
  strSQL := strSQL + '       GER_R_GCON, ';
  strSQL := strSQL + '       GER_CGCCPF, ';
  strSQL := strSQL + '       GER_CGCCON, ';
  strSQL := strSQL + '       GER_IESCON, ';
  strSQL := strSQL + '       GER_NOMCON, ';
  strSQL := strSQL + '       MOVGER.AUTOINCREM AS AUTGER, ';
  strSQL := strSQL + '       "MOVGER"   AS TABELA, ';
  strSQL := strSQL + '       CLI_CONTAT AS CONCTT, ';
  strSQL := strSQL + '       EMP_HOMEPA AS HOMPAG, ';
  strSQL := strSQL + '       EQL_NROCON AS NROCON, ';
  strSQL := strSQL + '       EQL_CODCLI AS CODCLI, ';
  strSQL := strSQL + '       CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '       EQL_CODVEN AS CODVEN, ';
  strSQL := strSQL + '       OPE_NOMOPE AS NOMVEN, ';
  strSQL := strSQL + '       EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '       CID_NOMCID AS NOMCID, ';
  strSQL := strSQL + '       EQL_TOTHOR AS TOTHOR, ';
  strSQL := strSQL + '       EQL_QTDEQU AS QTDEQU, ';
  strSQL := strSQL + '       EQL_TOTCON AS TOTCON, ';
  strSQL := strSQL + '       ETC_ENDENT AS ENDENT, ';
  strSQL := strSQL + '       EQL_DTAINI AS DTAINI, ';
  strSQL := strSQL + '       EQL_HORINI AS HORINI, ';
  strSQL := strSQL + '       EQL_DTAFIN AS DTAFIN, ';
  strSQL := strSQL + '       EQL_HORFIN AS HORFIN, ';
  strSQL := strSQL + '       EQL_CODIGO AS CODEQP, ';
  strSQL := strSQL + '       EQL_DESCRI AS DESEQP, ';
  strSQL := strSQL + '       EQL_NSERIE AS NSERIE, ';
  strSQL := strSQL + '       EQL_DECLAR AS DECLAR, ';
  strSQL := strSQL + '       EQD_VALHOR AS VALHOR, ';
  strSQL := strSQL + '       EQD_TOTEQL AS TOTEQL, ';
  strSQL := strSQL + '       EQF_CONPAG AS CONPAG, ';
  strSQL := strSQL + '       EQD_QTDEQU AS QTDEQD, ';
  strSQL := strSQL + '       EQF_QTDHOR AS QTDDIA, ';
  strSQL := strSQL + '       CND_DESCRI AS CNDPAG, ';
  strSQL := strSQL + '       (EQF_VALFAT / EQF_QTDHOR) AS LOCUNT, ';
  strSQL := strSQL + '       EQF_VALFAT AS VLOTOT, ';
  strSQL := strSQL + '       GER_TOTFRE AS CONFRE, ';
  strSQL := strSQL + '       GER_DESESP AS CONDES, ';
  strSQL := strSQL + '       ITE_PREVE3 AS PREVE3  ';
  strSQL := strSQL + '  FROM CONEQL ';
  strSQL := strSQL + '  LEFT JOIN EQLFAT ON EQLFAT.EQF_SEQCON = CONEQL.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN MOVGER ON (GER_CODEMP = EQF_EMPDOC AND GER_ESPDOC = EQF_ESPDOC AND GER_NUMDOC = EQF_NUMDOC) ';
  strSQL := strSQL + '  LEFT JOIN CADCLI ON CLI_CODCLI = EQL_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = EQL_ENTCLI ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ON EMP_CODEMP = EQL_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = EQL_CODVEN ';
  strSQL := strSQL + '  LEFT JOIN CADEQL ON EQL_CODIGO = EQF_SEQEQL ';
  strSQL := strSQL + '  LEFT JOIN CADCND CN ON CN.CND_CODIGO = EQL_CODCND ';
  strSQL := strSQL + '  LEFT JOIN EQLDET ON EQD_SEQEQL = EQF_SEQEQL AND EQD_SEQCON = CONEQL.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN ITEGER ON ITE_CODITE = EQL_CODITE AND ITE_CODEMP = EQL_CODEMP ';
  strSQL := strSQL + ' WHERE GER_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '   AND GER_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND GER_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND GER_CODCLI = :CODCLI ';

  Result := strSQL;
end;

function TLeDocumentoFaturaLoc.fSQLDupCont: String;
  Var
    strSQL: String;
begin
  strSQL := strSQL + '  SELECT CTR_NUMDUP, ';
  strSQL := strSQL + '         CTR_PARCEL AS NUMPRC, ';
  strSQL := strSQL + '         CTR_DTACAD AS DUPEMI, ';
  strSQL := strSQL + '         CTR_DTAVEN AS DUPVNC, ';
  strSQL := strSQL + '         CTR_VALDUP AS DUPVLR, ';
  strSQL := strSQL + '         0.00       AS VTOTEQ, ';
  strSQL := strSQL + '         0.00       AS TOTLCC, ';
  strSQL := strSQL + '         0.00       AS TOTPV3, ';
  strSQL := strSQL + '         MONTH(CTR_DTAVEN) AS MESVEN, ';
  strSQL := strSQL + '         ""         AS MESREF, ';
  strSQL := strSQL + '         ""         AS PARFAT ';
  strSQL := strSQL + '  FROM CADREC ';
  strSQL := strSQL + '  WHERE CTR_NUMDUP = :NUMDOC ';
  strSQL := strSQL + '    AND CTR_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '    AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + '    AND CTR_PARCEL = :PARCEL ';
  Result := strSQL;
end;

function TLeDocumentoFaturaLoc.fSQLNumParcel: String;
  Var
    strSQL: String;
Begin
  strSQL := strSQL + '  SELECT COUNT(CTR_PARCEL) AS MAXPAR';
  strSQL := strSQL + '  FROM CADREC ';
  strSQL := strSQL + '  WHERE CTR_NUMDUP = :NUMDOC ';
  strSQL := strSQL + '    AND CTR_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '    AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + '    AND CTR_CODCLI = :CODCLI ';
  Result := strSQL;
end;

procedure TLeDocumentoFaturaLoc.pRetMesParc;
begin
  cdsDupCont.Edit;
  cdsDupCont.FieldByName('MESREF').AsString := fRetornaMesReferencia(cdsDupCont.FieldByName('MESVEN').AsInteger);
  cdsDupCont.FieldByName('PARFAT').AsString := fNumeroParcela(cdsDupCont.FieldByName('NUMPRC').AsString);
  cdsDupCont.Post;
end;

procedure TLeDocumentoFaturaLoc.pSetaParametrosCadcli;
begin
  inherited;
  With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('CIDCON').AsString := cdsMovGer.FieldByName('GER_CIDCON').AsString;
    ParamByName('ENDCON').AsString := cdsMovGer.FieldByName('GER_ENDCON').AsString;
    ParamByName('BAICON').AsString := cdsMovGer.FieldByName('GER_BAICON').AsString;
    ParamByName('CEPCON').AsString := cdsMovGer.FieldByName('GER_CEPCON').AsString;
    ParamByName('TELCON').AsString := cdsMovGer.FieldByName('GER_TELCON').AsString;
    ParamByName('R_GCON').AsString := cdsMovGer.FieldByName('GER_R_GCON').AsString;
    ParamByName('CGCCPF').AsString := cdsMovGer.FieldByName('GER_CGCCPF').AsString;
    ParamByName('CGCCON').AsString := cdsMovGer.FieldByName('GER_CGCCON').AsString;
    ParamByName('IESCON').AsString := cdsMovGer.FieldByName('GER_IESCON').AsString;
    ParamByName('NOMCON').AsString := cdsMovGer.FieldByName('GER_NOMCON').AsString;
    ParamByName('CODFAZ').AsString := '';
  End;
end;

procedure TLeDocumentoFaturaLoc.pSetaTotais;
begin
  cdsDupCont.Edit;
  cdsDupCont.FieldByName('VTOTEQ').AsFloat := cdsMovGer.fRetSoma('VTOTEQ');
  cdsDupCont.FieldByName('TOTLCC').AsFloat := cdsMovGer.fRetSoma('TOTLCC');
  cdsDupCont.FieldByName('TOTPV3').AsFloat := cdsMovGer.fRetSoma('TOTPV3');
  cdsDupCont.Post;
end;

constructor TLeDocumentoFaturaLoc.Create(Owner: TComponent);
begin
  inherited;

end;

destructor TLeDocumentoFaturaLoc.Destroy;
begin
  {}
  inherited;
end;

function TLeDocumentoFaturaLoc.fInsereClientContrato: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLContrato);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxFatCont';
    frxDados.UserName := 'frxFatCont';
  End;

 With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    pCriaSoma('', 'VTOTEQ', 'SUM(TOTEQL)');
    pCriaSoma('', 'TOTLCC', 'SUM(VLOTOT)');
    pCriaSoma('', 'TOTPV3', 'SUM(PREVE3)');

    Result := fAbreClient(True, 'fInsereClientContrato');
  End;
end;

function TLeDocumentoFaturaLoc.fInsereClientDupCont: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLDupCont);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxDupCont';
    frxDados.UserName := 'frxDupCont';
  End;

 With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('PARCEL').AsString := strParcel;

    Result := fAbreClient(True, 'fInsereClientDupCont');
  End;
end;

function TLeDocumentoFaturaLoc.fInsereClientNumParcel: Boolean;
begin
  SetLength(arrClients, Succ(Length(arrClients)));
  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLNumParcel);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxNumParc';
    frxDados.UserName := 'frxNumParc';
  End;

 With arrClients[High(arrClients)], cdsDados, qryQuery, recDocume Do
  Begin
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;

    Result := fAbreClient(True, 'fInsereClientNumParcel');
  End;
end;

function TLeDocumentoFaturaLoc.fMontaClients(cdsDadosExternosMovGer, cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Result := True;

  Try
    Result := Result And fInsereClientContrato;
    cdsMovGer  := arrClients[0].cdsDados;

    Result := Result And fInsereClientDupCont;
    cdsDupCont := arrClients[1].cdsDados;

    Result := Result And fInsereClientNumParcel;
    cdsNumParc := arrClients[2].cdsDados;

    pSetaTotais;
    pRetMesParc;

    Result := Result And fInsereClientCliente;

    Result := Result And fInsereClientEmpresa;

    Result := Result And fInsereClientEnderecoEntrega(cdsMovGer.FieldByName('AUTGER').AsString,
                                                      cdsMovGer.FieldByName('TABELA').AsString,
                                                      '');

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then
      pSetaOrdenacao;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;


function TLeDocumentoFaturaLoc.fNumeroParcela(strParc: String): String;
begin
  Case AnsiIndexStr(strParc,
    ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L']) Of
    0:  Result := '1';
    1:  Result := '2';
    2:  Result := '3';
    3:  Result := '4';
    4:  Result := '5';
    5:  Result := '6';
    6:  Result := '7';
    7:  Result := '8';
    8:  Result := '9';
    9:  Result := '10';
    10: Result := '11';
    11: Result := '12';
  End;
end;

function TLeDocumentoFaturaLoc.fRetornaMesReferencia(intMes: integer): String;
begin
  Case intMes of
    1:  Result := 'DEZEMBRO';
    2:  Result := 'JANEIRO';
    3:  Result := 'FEVEREIRO';
    4:  Result := 'MARÇO';
    5:  Result := 'ABRIL';
    6:  Result := 'MAIO';
    7:  Result := 'JUNHO';
    8:  Result := 'JULHO';
    9:  Result := 'AGOSTO';
    10: Result := 'SETEMBRO';
    11: Result := 'OUTUBRO';
    12: Result := 'NOVEMBRO';
  End;
end;

end.
