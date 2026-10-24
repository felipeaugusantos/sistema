unit untDocCGC;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untLeDocumento, untFuncoesSimples, untZClient, untFuncoesEditorFast;

Type

  TLeDocumentoCGC = Class(TLeDocumento)
  Private

    cdsMovCGC: TZClient;

    Function fSQLMovCGC: String;
    Function fInsereClientMovCGC: Boolean;
    procedure pImportarMovCGCSExterno(cdsExterno: TZClient);

  Public
    Function fMontaClients(cdsDadosExternosMovCGC: TZClient = nil; cdsDadosExternosMovCGCD: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses DB, untTypesSistema;

Function TLeDocumentoCGC.fSQLMovCGC: String;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE DISTINCT ';

  strSQL := strSQL + '  E.EMP_CODEMP AS CODEMP, ';
  strSQL := strSQL + '  E.EMP_NOMEMP AS NOMEMP, ';

  strSQL := strSQL + '  M.GER_CODCLI AS CODCLI, ';
  strSQL := strSQL + '  C.CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '  C.CLI_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '  C.CLI_C_G_C_ AS DOCCLI, ';
  strSQL := strSQL + '  CC.CON_NOMCON AS NOMCON,';
  strSQL := strSQL + '  CC.CON_C_P_F_ AS CPFCON,';

  strSQL := strSQL + '  M.GER_NUMDOC AS DOCDEV, ';
  strSQL := strSQL + '  M.GER_ESPDOC AS ESPDEV, ';
  strSQL := strSQL + '  M.GER_CODEMP AS EMPDEV, ';

  strSQL := strSQL + '  D.DET_DOCDEV AS DOCVEN, ';
  strSQL := strSQL + '  D.DET_ESPDEV AS ESPVEN, ';
  strSQL := strSQL + '  D.DET_EMPDEV AS EMPVEN, ';

  strSQL := strSQL + '  M.GER_DTADOC AS DTAGER, ';
  strSQL := strSQL + '  M.GER_VLRCON AS VLRCRE  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVGER M ';
  strSQL := strSQL + 'LEFT JOIN MOVDET D ON D.DET_SEQGER = M.AUTOINCREM ';
  strSQL := strSQL + 'LEFT JOIN CADCLI C ON C.CLI_CODCLI = M.GER_CODCLI ';
  strSQL := strSQL + 'LEFT JOIN CLICON CC ON CC.CON_C_P_F_ = M.GER_CGCCON ';
  strSQL := strSQL + 'LEFT JOIN CADEMP E ON E.EMP_CODEMP = M.GER_CODEMP ';
  strSQL := strSQL + 'WHERE M.GER_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND M.GER_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND M.GER_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND M.GER_TIP_FC = "C"     ';

  Result := strSQL;
End;

Function TLeDocumentoCGC.fInsereClientMovCGC: Boolean;
Begin
  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLMovCGC);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('NUMDOC').AsString := recDocume.strNumDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('ESPDOC').AsString := recDocume.strEspDoc;
  arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('CODEMP').AsString := recDocume.strCodEmp;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientMovCGC');

End;

Function TLeDocumentoCGC.fMontaClients(cdsDadosExternosMovCGC: TZClient = nil; cdsDadosExternosMovCGCD: TZClient = nil): Boolean;
Begin
  Try
    Result := True;

    Result    := Result And fInsereClientMovCGC;
    cdsMovCGC  := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    If Assigned(cdsDadosExternosMovCGC) Then
      pImportarMovCGCSExterno(cdsDadosExternosMovCGC);

    Result := Result And fPreparaImpressaoDocumentos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;
End;

procedure TLeDocumentoCGC.pImportarMovCGCSExterno(cdsExterno: TZClient);
begin
  cdsExterno.First;

  if Not cdsMovCGC.IsEmpty Then
  Begin
    cdsMovCGC.First;
    While not cdsMovCGC.IsEmpty do
    Begin
      cdsMovCGC.Delete;
    End;
  End;

  cdsExterno.First;
  while not(cdsExterno.Eof) do
  Begin
    cdsMovCGC.Insert;
    cdsMovCGC.FieldByName('SEQDET').Value := cdsExterno.FieldByName('SEQDET').Value;
    cdsMovCGC.FieldByName('DTAVEN').Value := cdsExterno.FieldByName('DTAVEN').Value;
    cdsMovCGC.FieldByName('VALDUP').Value := cdsExterno.FieldByName('VALDUP').Value;
    cdsMovCGC.FieldByName('DTAREC').Value := cdsExterno.FieldByName('DTAREC').Value;
    cdsMovCGC.FieldByName('VALREC').Value := cdsExterno.FieldByName('VALREC').Value;
    cdsMovCGC.Post;
    cdsExterno.Next;
  End;

end;

end.
