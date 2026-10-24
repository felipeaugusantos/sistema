unit untDocEnderecamentoProduto;

interface

uses Classes, StrUtils, Forms, SysUtils, frxClass, frxDBSet, UniClientDataSet,
  Controls, untTypesSistema, untLeDocumento, untFuncoesSimples, TypesRel, untFuncoesEditorFast,
  untZClient, Uni;

Type

  TLeDocEnderecamentoProduto = Class(TLeDocumento)
  Private
    cdsMovGer: TZClient;

    function fInsereClientMovger: Boolean;
    function fSQLMovGer: String;

  Public
    function fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean; override;

  protected

  End;

implementation

uses untConstantes, Data.DB;

Function TLeDocEnderecamentoProduto.fInsereClientMovger: Boolean;
Begin

  SetLength(arrClients, Succ(Length(arrClients)));

  arrClients[High(arrClients)].cdsDados := TZClient.Create(Nil, fSQLMovGer);
  arrClients[High(arrClients)].frxDados := TfrxDBDataset.Create(Nil);
  arrClients[High(arrClients)].frxDados.DataSet := arrClients[High(arrClients)].cdsDados;
  arrClients[High(arrClients)].frxDados.Name := 'frxMovger';
  arrClients[High(arrClients)].frxDados.UserName := 'frxMovger';

  if not fEmptyStr(recDocume.strIncPed) then
    arrClients[High(arrClients)].cdsDados.qryQuery.ParamByName('INCPED').AsString := recDocume.strIncPed;

  Result := arrClients[High(arrClients)].cdsDados.fAbreClient(True, 'fInsereClientMovger');

End;

Function TLeDocEnderecamentoProduto.fMontaClients(cdsDadosExternosMovGer: TZClient = nil; cdsDadosExternosMovDet: TZClient = nil): Boolean;
Begin
  Try

    Result := True;

    Result    := Result And fInsereClientMovger;
    cdsMovGer := arrClients[0].cdsDados;

    If Not Result Then
      Exit;

    Result := Result And fPreparaImpressaoDocumentos;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMontaClients]');
    End;
  End;

End;

Function TLeDocEnderecamentoProduto.fSQLMovger: String;
  Var
    strSQL,
    strItens: String;
    intLaco: integer;
Begin

  strItens := '""';

  if Assigned(recDocume.stlListaItens) then
  begin
    For intLaco := 0 to recDocume.stlListaItens.Count-1 do
      strItens := strItens + ', "'+ recDocume.stlListaItens[intLaco] + '"';
  end;

  strSQL := '';
  strSQL := strSQL + ' SELECT DISTINCT ';
  strSQL := strSQL + '   CAST(IFNULL(GER_ORDPRO, TRIM(MID(FGO_DOCEND, 01, ' + IntToStr(fTamNumDoc) + '))) AS CHAR(12)) AS NUMDOC, ';
  strSQL := strSQL + '   CAST(MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 1) + ', 2) AS CHAR(12)) AS ESPDOC, ';
  strSQL := strSQL + '   CAST(MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3) AS CHAR(12)) AS CODEMP, ';
  strSQL := strSQL + '   CAST(MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 9) + ', 8) AS CHAR(12)) AS CODFOR, ';
  strSQL := strSQL + '   CAST(IF( CAST(MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 17) + ', 1) AS CHAR(12)) = "C", CLI_NOMCLI, FOR_NOMFOR) AS CHAR(255)) AS NOMFOR, ';
  strSQL := strSQL + '   CADEMP.EMP_NOMEMP AS NOMEMP, ';
  strSQL := strSQL + '   CADITE.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   CADITE.ITE_CODBAR AS CODBAR, ';
  strSQL := strSQL + '   CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '   CADITE.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '   CADITE.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   CADITE.ITE_CODUNI AS CODUNI, ';
  strSQL := strSQL + '   MOVDET.DET_QTDITE AS QTDITE, ';
  strSQL := strSQL + '   ITEGER.ITE_SALDOS AS SLDGER, ';
  strSQL := strSQL + '   ITEGER.ITE_LOCSUP AS LOCSUP, ';
  strSQL := strSQL + '   ITEGER.ITE_LOCFIS AS LOCFIS ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   EXTGOR ';
  strSQL := strSQL + '   INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO ';
  strSQL := strSQL + '   INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
  strSQL := strSQL + '    LEFT JOIN CADCLI ON CLI_CODCLI = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 9) + ', 8)';
  strSQL := strSQL + '    LEFT JOIN CADFOR ON FOR_CODFOR = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 9) + ', 8)';
  strSQL := strSQL + '    LEFT JOIN MOVGER ON GER_NUMDOC =   TRIM(MID(FGO_DOCEND, 01, ' + IntToStr(fTamNumDoc) + '))';
  strSQL := strSQL + '                    AND GER_ESPDOC =   MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 1) + ', 2)';
  strSQL := strSQL + '                    AND GER_CODEMP =   MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3)';
  strSQL := strSQL + '                    AND ((GER_CODFOR = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 9) + ', 8)' + ' AND GER_TIP_FC = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 17) + ', 1))';
  strSQL := strSQL + '                     OR (GER_CODCLI =  MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 17) + ', 1)' + ' AND GER_TIP_FC = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 17) + ', 1)))';
  strSQL := strSQL + '                    AND GER_SERIE_  =  MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 3) + ', 3)' ;

  strSQL := strSQL + '    LEFT JOIN MOVDET ON MOVDET.DET_NUMDOC = MOVGER.GER_NUMDOC ';
  strSQL := strSQL + '                    AND MOVDET.DET_ESPDOC = MOVGER.GER_ESPDOC ';
  strSQL := strSQL + '                    AND MOVDET.DET_SERIE_ = MOVGER.GER_SERIE_ ';
  strSQL := strSQL + '                    AND MOVDET.DET_CODEMP = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3)';

  strSQL := strSQL + '    LEFT JOIN CADITE ON CADITE.ITE_CODITE = MOVDET.DET_CODITE ';
  strSQL := strSQL + '    LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '                    AND ITEGER.ITE_CODEMP = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3)';
  strSQL := strSQL + '    LEFT JOIN CADEMP ON CADEMP.EMP_CODEMP = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3)';

  If fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
  Begin
    strSQL := strSQL + ' LEFT JOIN AGEDOC ON ADC_CODEMP = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3)';
    strSQL := strSQL + '                 AND ADC_CODFOR = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 9) + ', 8)';
    strSQL := strSQL + '                 AND ADC_ESPDOC = MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 1) + ', 2)';
    strSQL := strSQL + '                 AND ADC_NUMDOC = TRIM(MID(FGO_DOCEND, 01, ' + IntToStr(fTamNumDoc) + '))';
  End;

  strSQL := strSQL + ' WHERE FGO_DOCEND IS NOT NULL AND IFNULL(FGO_BKPEND, "") = "" ';
  strSQL := strSQL + ' AND MID(FGO_DOCEND, ' + IntToStr(fTamNumDoc + 6) + ', 3) = ' + QuotedStr(VS_strCodEmp);
  If fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
    strSQL := strSQL + ' AND (GER_DTAENT IS NOT NULL OR FGO_MEN001 LIKE "%CANCELAM%") AND ADC_SEQGER IS NULL ';

  if not fEmptyStr(recDocume.strNumDoc) then
  begin
    strSQL := strSQL + ' AND GER_NUMDOC = ' + QuotedStr(recDocume.strNumDoc);
    strSQL := strSQL + ' AND GER_ESPDOC = ' + QuotedStr(recDocume.strEspDoc);
    strSQL := strSQL + ' AND GER_CODEMP = ' + QuotedStr(recDocume.strCodEmp);
  end;

  if not fEmptyStr(recDocume.strIncPed) then
  begin
    strSQL := strSQL + ' AND FATDOR.FDO_SEQGER IN ( :INCPED ) ';
    strSQL := strSQL + ' AND CADITE.ITE_CODITE IN ( '+ strItens + ' )';
  end;

  result := strSQL;

end;

end.


