unit untDocCPDP;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient, untFuncoesEditorFast;

Type

  TLeDocumentoCPDP = Class(TLeDocumento)
  Private

    cdsMovCP,
    cdsMovDP: TZClient;

    Function fSQLMovCP: String;
    Function fSQLMovDP: String;

    Function fInsereClientMovCP: Boolean;
    Function fInsereClientMovDP: Boolean;
    procedure pImportarMovCPCDSExterno(cdsExterno: TZClient);
    procedure pImportarMovDPCDSExterno(cdsExterno: TZClient);

  Public
    Function fMontaClients(cdsDadosExternosMovCP: TZClient = nil; cdsDadosExternosMovDP: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses DB, untTypesSistema;

Function TLeDocumentoCPDP.fSQLMovCP: String;
  Var
    strSQL: String;
Begin

  strSQL := '';

  if not ( recDocume.strEspDoc = 'AG' ) then
  begin
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SQL_NO_CACHE DISTINCT M.GER_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  M.GER_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  M.GER_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '  M.GER_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  E.EMP_NOMEMP AS EMPNOM, ';
    strSQL := strSQL + '  M.GER_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  IF( ';
    strSQL := strSQL + '    (C.CLI_LIMCRE - M.GER_VLRCON) < 0, ';
    strSQL := strSQL + '    0, ';
    strSQL := strSQL + '    (C.CLI_LIMCRE - M.GER_VLRCON) ';
    strSQL := strSQL + '  ) AS SLDCOM, ';
    strSQL := strSQL + '  M.GER_CODVEN AS CODVEN, ';
    strSQL := strSQL + '  O.OPE_NOMOPE AS NOMVEN, ';
    strSQL := strSQL + '  M.GER_VLRCON AS TOTVEN, ';
    strSQL := strSQL + '  M.GER_DTADOC AS DTACOM, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    R.CTR_BARCON ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = M.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = M.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_PARCEL = "A" ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = M.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = M.GER_CODEMP) AS NUMCON, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    R.CTR_BARCON ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = M.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = M.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_PARCEL = "A" ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = M.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = M.GER_CODEMP) AS CODBAR, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    SUM(R.CTR_VALREC) ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = M.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = M.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = M.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = M.GER_CODEMP) AS TOTPGO, ';
    strSQL := strSQL + '  CURRENT_DATE AS DTAATU ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER M ';
    strSQL := strSQL + '  LEFT JOIN CADCLI C ';
    strSQL := strSQL + '    ON C.CLI_CODCLI = M.GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ';
    strSQL := strSQL + '    ON O.OPE_CODOPE = M.GER_CODVEN ';
    strSQL := strSQL + '  LEFT JOIN CADEMP E ';
    strSQL := strSQL + '    ON E.EMP_CODEMP = M.GER_CODEMP ';
    strSQL := strSQL + 'WHERE M.GER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND M.GER_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND M.GER_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND M.GER_CODCLI = :CODCLI ';
    strSQL := strSQL + 'UNION ALL ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  N.GER_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  N.GER_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  N.GER_SERIE_ AS SERIE_, ';
    strSQL := strSQL + '  N.GER_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  E.EMP_NOMEMP AS EMPNOM, ';
    strSQL := strSQL + '  N.GER_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  IF( ';
    strSQL := strSQL + '    (C.CLI_LIMCRE - N.GER_VLRCON) < 0, ';
    strSQL := strSQL + '    0, ';
    strSQL := strSQL + '    (C.CLI_LIMCRE - N.GER_VLRCON) ';
    strSQL := strSQL + '  ) AS SLDCOM, ';
    strSQL := strSQL + '  N.GER_CODVEN AS CODVEN, ';
    strSQL := strSQL + '  O.OPE_NOMOPE AS NOMVEN, ';
    strSQL := strSQL + '  N.GER_VLRCON AS TOTVEN, ';
    strSQL := strSQL + '  N.GER_DTAENT AS DTACOM, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    R.CTR_BARCON ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = N.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = N.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_PARCEL = "A" ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = N.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = N.GER_CODEMP) AS NUMCON, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    R.CTR_BARCON ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = N.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = N.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_PARCEL = "A" ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = N.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = N.GER_CODEMP) AS CODBAR, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    SUM(R.CTR_VALREC) ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = N.GER_NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = N.GER_ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = N.GER_CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = N.GER_CODEMP) AS TOTPGO, ';
    strSQL := strSQL + '  CURRENT_DATE AS DTAATU ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  NOTGER N ';
    strSQL := strSQL + '  LEFT JOIN CADCLI C ';
    strSQL := strSQL + '    ON C.CLI_CODCLI = N.GER_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ';
    strSQL := strSQL + '    ON O.OPE_CODOPE = N.GER_CODVEN ';
    strSQL := strSQL + '  LEFT JOIN CADEMP E ';
    strSQL := strSQL + '    ON E.EMP_CODEMP = N.GER_CODEMP ';
    strSQL := strSQL + 'WHERE N.GER_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '  AND N.GER_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '  AND N.GER_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND N.GER_CODCLI = :CODCLI ';
  end
  else
  begin
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_BARCON AS NUMCON, ';
    strSQL := strSQL + '  CTR_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CLI_NOMCLI AS NOMCLI, ';
    strSQL := strSQL + '  CADOPE.OPE_NOMOPE AS NOMVEN, ';
    strSQL := strSQL + '  CTR_DTACAD AS DTACOM, ';
    strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_DUPPAR, ';
    strSQL := strSQL + '  CTR_NUMDUP AS NUMDOC, ';
    strSQL := strSQL + '  CTR_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  CTR_PARCEL, ';
    strSQL := strSQL + '  CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_SEQBAI, ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  IF( ';
    strSQL := strSQL + '    CTR_DTAREC IS NULL, ';
    strSQL := strSQL + '    CTR_VALDUP, ';
    strSQL := strSQL + '    CTR_VALORI ';
    strSQL := strSQL + '  ) AS CTR_VALDUP, ';
    strSQL := strSQL + '  CTR_DTAREC, ';
    strSQL := strSQL + '  CTR_VALREC, ';
    strSQL := strSQL + '  "CADREC" AS CTR_NOMTAB, ';
    strSQL := strSQL + '  CADREC.AUTOINCREM, ';
    strSQL := strSQL + '  0.00 AS TOTVEN, ';
    strSQL := strSQL + '  (SELECT ';
    strSQL := strSQL + '    SUM(R.CTR_VALREC) ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '    CADREC R ';
    strSQL := strSQL + '  WHERE R.CTR_NUMDUP = :NUMDOC ';
    strSQL := strSQL + '    AND R.CTR_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '    AND R.CTR_CODCLI = :CODCLI ';
    strSQL := strSQL + '    AND R.CTR_CODEMP = :CODEMP) AS TOTPGO ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  LEFT JOIN CADCLI ';
    strSQL := strSQL + '    ON CTR_CODCLI = CLI_CODCLI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE ';
    strSQL := strSQL + '    ON CTR_CODVEN = OPE_CODOPE ';
    strSQL := strSQL + 'WHERE CLI_CODCLI = :CODCLI ';
    strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';
    strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDOC ';
    strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

  end;

  Result := strSQL;
End;

Function TLeDocumentoCPDP.fSQLMovDP: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  (@ROW := @ROW + 1) AS NUMPAR, ';
  strSQL := strSQL + '  CTR_DTAVEN AS DTAVEN, ';
  strSQL := strSQL + '  IF( ';
  strSQL := strSQL + '    CTR_DTAREC IS NULL, ';
  strSQL := strSQL + '    CTR_VALDUP, ';
  strSQL := strSQL + '    CTR_VALORI ';
  strSQL := strSQL + '  ) AS VLRPAR, ';
  strSQL := strSQL + '  IF(CTR_DTAREC IS NULL, "", DATE_FORMAT(CTR_DTAREC,''%d/%m/%Y'')) AS DTAPGO, ';
  strSQL := strSQL + '  IF(CTR_VALREC = 0, "", FORMAT( CTR_VALREC,2,''de_DE'')) AS VLRPGO, ';
  strSQL := strSQL + '  CTR_BARCON AS CODBAR  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDOC ';
  strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';
  strSQL := strSQL + 'ORDER BY CTR_DTAVEN ; ';

  Result := strSQL;
End;

Function TLeDocumentoCPDP.fInsereClientMovCP: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)] Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLMovCP);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovger';
    frxDados.UserName := 'frxMovger';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery Do
  Begin

    ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    ParamByName('CODEMP').AsString := recDocume.strCodEmp;
    ParamByName('CODCLI').AsString := recDocume.strCodCli;

    Result := fAbreClient(True, 'fInsereClientMovCP');
  End;

End;

Function TLeDocumentoCPDP.fInsereClientMovDP: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  With arrClients[High(arrClients)], recDocume Do
  Begin
    cdsDados := TZClient.Create(Nil, fSQLMovDP);
    frxDados := TfrxDBDataset.Create(Nil);
    frxDados.DataSet := cdsDados;
    frxDados.Name     := 'frxMovdet';
    frxDados.UserName := 'frxMovdet';
  End;

  With arrClients[High(arrClients)], cdsDados, qryQuery Do
  Begin

    ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
    ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
    ParamByName('CODCLI').AsString := recDocume.strCodCli;
    ParamByName('CODEMP').AsString := recDocume.strCodEmp;

    Result := fAbreClient(True, 'fInsereClientMovDP');
  End;
end;

Function TLeDocumentoCPDP.fMontaClients(cdsDadosExternosMovCP: TZClient = nil; cdsDadosExternosMovDP: TZClient = nil): Boolean;
Begin
  Try
    Result := True;

    Result    := Result And fInsereClientMovDP;
    cdsMovDP  := arrClients[0].cdsDados;

    Result    := Result And fInsereClientMovCP;
    cdsMovCP := arrClients[1].cdsDados;

    If Not Result Then
      Exit;

    If Assigned(cdsDadosExternosMovCP) Then
      pImportarMovCPCDSExterno(cdsDadosExternosMovCP);

    If Assigned(cdsDadosExternosMovDP) Then
      pImportarMovDPCDSExterno(cdsDadosExternosMovDP);

    Result := Result And fPreparaImpressaoDocumentos;

    If Result Then pSetaOrdenacao;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

procedure TLeDocumentoCPDP.pImportarMovDPCDSExterno(cdsExterno: TZClient);
begin
  cdsExterno.First;
  with cdsMovDP do
  begin

    if Not cdsMovDP.IsEmpty Then
    Begin
      cdsMovDP.First;
      While not cdsMovDP.IsEmpty do
      Begin
        cdsMovDP.Delete;
      End;
    End;

    cdsExterno.First;
    while not(cdsExterno.Eof) do
    Begin
      Insert;
      FieldByName('SEQDET').Value := cdsExterno.FieldByName('SEQDET').Value;
      FieldByName('DTAVEN').Value := cdsExterno.FieldByName('DTAVEN').Value;
      FieldByName('VALDUP').Value := cdsExterno.FieldByName('VALDUP').Value;
      FieldByName('DTAREC').Value := cdsExterno.FieldByName('DTAREC').Value;
      FieldByName('VALREC').Value := cdsExterno.FieldByName('VALREC').Value;
      Post;
      cdsExterno.Next;
    End;
  End;
end;

procedure TLeDocumentoCPDP.pImportarMovCPCDSExterno(cdsExterno: TZClient);
begin
  cdsExterno.First;
  with cdsMovCP do
  begin

    if Not cdsMovCP.IsEmpty Then
    Begin
      While not cdsMovCP.IsEmpty do
      Begin
        cdsMovCP.Delete;
      End;
    End;

    Insert;
    FieldByName('NUMDOC').Value := cdsExterno.FieldByName('NUMDOC').Value;
    FieldByName('ESPDOC').Value := cdsExterno.FieldByName('ESPDOC').Value;
    FieldByName('CODEMP').Value := cdsExterno.FieldByName('CODEMP').Value;
    FieldByName('SERIE_').Value := cdsExterno.FieldByName('SERIE_').Value;
    FieldByName('CODCLI').Value := cdsExterno.FieldByName('CODCLI').Value;
    FieldByName('NOMCLI').Value := cdsExterno.FieldByName('NOMCLI').Value;
    FieldByName('LIMCRE').Value := cdsExterno.FieldByName('LIMCRE').Value;
    FieldByName('CODVEN').Value := cdsExterno.FieldByName('CODVEN').Value;
    FieldByName('NOMOPE').Value := cdsExterno.FieldByName('NOMOPE').Value;
    FieldByName('VLRCON').Value := cdsExterno.FieldByName('VLRCON').Value;
    FieldByName('DTADOC').Value := cdsExterno.FieldByName('DTADOC').Value;
    FieldByName('BARCON').Value := cdsExterno.FieldByName('BARCON').Value;
    FieldByName('VALREC').Value := cdsExterno.FieldByName('VALREC').Value;
    Post;
  end;
end;

end.
