unit untDocLE;

interface

uses
  SysUtils, frxDBSet, untZClient, untLeDocumento, untFuncoesSimples,
  untFuncoesEditorFast, Uni;

type
  TLeDocumentoLE = class(TLeDocumento)
  private
    { private declarations }
    function fInsereClients: Boolean;
    function fGeraSqlContrato: String;
    function fSolicitaDeclaracao(var strDeclara: String): Boolean;
    procedure pAtualizaDeclaracao(ANroCon, ACodEmp, ATexto: String);
  protected
    { protected declarations }
  public
    { public declarations }
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;
  end;

implementation

uses
  untObservacao;

{ TLeDocumentoLE }

function TLeDocumentoLE.fGeraSqlContrato: String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT EQL_NROCON AS NROCON, ';
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
  strSQL := strSQL + '       DATEDIFF(EQL_DTAFIN, EQL_DTAINI) AS DIARIA, ';
  strSQL := strSQL + '       EQL_CODIGO AS CODEQP, ';
  strSQL := strSQL + '       EQL_DESCRI AS DESEQP, ';
  strSQL := strSQL + '       EQL_NSERIE AS NSERIE, ';
  strSQL := strSQL + '       EQL_DECLAR AS DECLAR, ';
  strSQL := strSQL + '       EQD_VALHOR AS VALHOR, ';
  strSQL := strSQL + '       EQD_TOTEQL AS TOTEQL, ';
  strSQL := strSQL + '       EQF_CONPAG AS CONPAG, ';
  strSQL := strSQL + '       CTR_NUMDUP AS NUMDUP, ';
  strSQL := strSQL + '       CTR_DTACAD AS DTADUP, ';
  strSQL := strSQL + '       CTR_DTAVEN AS VENDUP, ';
  strSQL := strSQL + '       CTR_VALDUP AS VALDUP, ';
  strSQL := strSQL + '       EQD_QTDEQU AS QTDEQD, ';
  strSQL := strSQL + '       EQF_DTAREF AS DTAREF, ';
  strSQL := strSQL + '       EQF_HORREF AS HORREF, ';
  strSQL := strSQL + '       EQF_FATOBS AS FATOBS, ';
  strSQL := strSQL + '       EQF_MESREF AS MESREF  ';
  strSQL := strSQL + 'FROM CONEQL ';
  strSQL := strSQL + 'LEFT JOIN CADCLI ON CLI_CODCLI = EQL_CODCLI ';
  strSQL := strSQL + 'LEFT JOIN ENTCLI ON ENTCLI.AUTOINCREM = EQL_ENTCLI ';
  strSQL := strSQL + 'LEFT JOIN CADEMP ON EMP_CODEMP = EQL_CODEMP ';
  strSQL := strSQL + 'LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID ';
  strSQL := strSQL + 'LEFT JOIN CADOPE ON OPE_CODOPE = EQL_CODVEN ';
  strSQL := strSQL + 'LEFT JOIN EQLDET ON EQD_SEQCON = CONEQL.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN CADEQL ON EQL_CODIGO = EQD_SEQEQL ';
  strSQL := strSQL + 'LEFT JOIN( ';
  strSQL := strSQL + '  SELECT GROUP_CONCAT(CTR_NUMDUP,"-",CTR_ESPDOC,"-",CTR_CODEMP ORDER BY CADREC.AUTOINCREM SEPARATOR "<<csq>>") AS CTR_NUMDUP, ';
  strSQL := strSQL + '         GROUP_CONCAT(DATE_FORMAT(CTR_DTACAD, "%d/%m/%Y") ORDER BY CADREC.AUTOINCREM SEPARATOR "<<csq>>") AS CTR_DTACAD, ';
  strSQL := strSQL + '         GROUP_CONCAT(DATE_FORMAT(CTR_DTAVEN, "%d/%m/%Y") ORDER BY CADREC.AUTOINCREM SEPARATOR "<<csq>>") AS CTR_DTAVEN, ';
  strSQL := strSQL + '         GROUP_CONCAT(FORMAT(CTR_VALDUP, 2, "de_DE") ORDER BY CADREC.AUTOINCREM SEPARATOR "<<csq>>") AS CTR_VALDUP, ';
  strSQL := strSQL + '         GROUP_CONCAT(EQF_CONPAG ORDER BY CADREC.AUTOINCREM SEPARATOR "<<csq>>") AS EQF_CONPAG , ';
  strSQL := strSQL + '         EQF_DTAREF, EQF_HORREF, EQF_FATOBS,  ';
  strSQL := strSQL + '         (DATE_FORMAT(EQF_DTAREF, "%m/%Y")) AS EQF_MESREF  ';
  strSQL := strSQL + '  FROM EQLFAT ';
  strSQL := strSQL + '  INNER JOIN CONEQL ON CONEQL.AUTOINCREM = EQF_SEQCON ';
  strSQL := strSQL + '  INNER JOIN CADREC ON CTR_NUMDUP = EQF_NUMDOC ';
  strSQL := strSQL + '                   AND CTR_ESPDOC = EQF_ESPDOC ';
  strSQL := strSQL + '                   AND CTR_CODEMP = EQF_EMPDOC ';
  strSQL := strSQL + '                   AND CTR_CODCLI = EQL_CODCLI ';
  strSQL := strSQL + '  WHERE EQL_NROCON = :NROCON ';
  strSQL := strSQL + '    AND EQL_CODEMP = :CODEMP ';
  strSQL := strSQL + ')FAT ON TRUE ';
  strSQL := strSQL + 'WHERE EQL_NROCON = :NROCON ';
  strSQL := strSQL + '  AND EQL_CODEMP = :CODEMP ';

  If (recDocume.strEspSel = 'DL') Then
  Begin
    strSQL := strSQL + '  AND EQD_ESPRET = :ESPRET ';
    strSQL := strSQL + '  AND EQD_EMPRET = :EMPRET ';
    strSQL := strSQL + '  AND EQD_NUMRET = :NUMRET ';
  End;

  Result := strSQL;
end;

function TLeDocumentoLE.fInsereClients: Boolean;
  Var
    LDeclaracao: String;
begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fGeraSqlContrato);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet  := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name     := 'frxConEql';
  arrClients[High(arrClients)].frxDados.UserName := 'frxConEql';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NROCON').AsString := recDocume.strNroCon;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  If (recDocume.strEspSel = 'DL') Then
  Begin
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPRET').AsString := recDocume.strEspDoc;
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('EMPRET').AsString := recDocume.strCodEmp;
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMRET').AsString := recDocume.strNumDoc;
  End;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClients');

  If Result Then
  Begin
    LDeclaracao := arrClients[High(arrClients)].cdsDados.FieldByName('DECLAR').AsString;

    If Not fSolicitaDeclaracao(LDeclaracao) Then
      Exit;

    pAtualizaDeclaracao(recDocume.strNroCon, recDocume.strCodEmp, LDeclaracao);
    arrClients[High(arrClients)].cdsDados.Refresh;
  End;
end;

function TLeDocumentoLE.fMontaClients(cdsDadosExternosMovGer, cdsDadosExternosMovDet: TZClient): Boolean;
begin
  Try
    Result := fInsereClients;

    If Not Result Then
      Exit;

    Result := fPreparaImpressaoDocumentos;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
end;

function TLeDocumentoLE.fSolicitaDeclaracao(var strDeclara: String): Boolean;
begin
  If (Not recDocume.blnVisPdf) And (recDocume.blnGerPdf) Then
    Exit(True);

  If (recDocume.strEspSel <> 'LE') Then
    Exit(True);

  strDeclara := TfrmObservacao.fObservacao('Texto para Declaração', strDeclara, 500, tpiInputQuery, 0, True);

  Result := Not fEmptyStr(strDeclara);
end;

procedure TLeDocumentoLE.pAtualizaDeclaracao(ANroCon, ACodEmp, ATexto: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Add('UPDATE CONEQL');
    qryAux.SQL.Add('   SET EQL_DECLAR = :DECLAR');
    qryAux.SQL.Add(' WHERE EQL_NROCON = :NROCON');
    qryAux.SQL.Add('   AND EQL_CODEMP = :CODEMP');
    qryAux.ParamByName('NROCON').AsString := ANroCon;
    qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    qryAux.ParamByName('DECLAR').AsString := ATexto;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
