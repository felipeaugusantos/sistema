unit untTBoaVista;

interface

Uses Classes, untFuncoesSimples, Uni, System.SysUtils, StrUtils, Windows, Forms,
     untFuncAutban, untFuncoesBoleto, untFuncoes, Variants, UniClientDataSet,
     DateUtils, untCfgRel, Data.DB, untConstantes, untLogCtr;

Type
  TConfBoaVista = Record
    strPathRemessa,
    strPathRetorno,
    strPeriodicidade,
    strUltPeriodo   : String;
End;

type
  TBoaVista = Class

  private
    qryConsultaGen: TUniQuery;
  public
    procedure pSalvaConfiguracao(objConf: TConfBoaVista);
    function fRetConfiguracao: TConfBoaVista;
    function fExportaRemessa(strArquivo: String; strCodPor: String = ''; strPeriod: String = 'D'; strFilReg: String = ''): Boolean;
  End;

implementation

{ TBoaVista }

function TBoaVista.fExportaRemessa(strArquivo: String; strCodPor: String = ''; strPeriod: String = 'D'; strFilReg: String = ''): Boolean;
  Var
    strSQL,
    strCodBco,
    strNomEmp,
    strDtaVen,
    strDtaEmi,
    strKeyDup,
    strCgcEmp,
    strCgcCli,
    strTipReg,
    strCliDes,
    strDtaIni,
    strDtaFin,
    strDtaRec,
    strTipDoc,
    strHeader,
    strTransacao,
    strTrailler,
    strNovCodEmp: String;

    intCodSeq   : Integer;
    txtTexto    : TextFile;
    qryRemessa,
    qryGen      : TUniQuery;

    strFilePath : String;
    strCodRem: String;

begin
  inherited;

  Result := False;

  If fMensagem('','Confirma geração do arquivo de remessa?',['&Sim','&Não']) = 2 Then
    Exit;

  strCodBco  := 'BOA';

  strCodRem    := FormatDateTime('yyyy', VS_Date) + FormatDateTime('mm', VS_Date) + FormatDateTime('dd', VS_Date);
  strNovCodEmp := VS_strCodEmp;
  strNomEmp    := fRetNomeEmpresa(strNovCodEmp);

  If fEmptyStr( strNomEmp ) Then
  Begin
    fMensagem('','Erro ao localizar o nome da empresa responsável pela remessa!',['&Sim','&Não']);
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CBI_DTAINI, ';
    strSQL := strSQL + '   CBI_DTAFIN, ';
    strSQL := strSQL + '   CBI_CODCLI, ';
    strSQL := strSQL + '   CLI_STATUS, ';
    strSQL := strSQL + '   CLI_DTACAD, ';
    strSQL := strSQL + '   REPLACE(REPLACE(REPLACE(CLI_C_G_C_, ".", ""), "/", ""), "-", "") AS CLI_C_G_C_ ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADCLI ';
    strSQL := strSQL + '   LEFT JOIN CADCBI ON CLI_CODCLI = CBI_CODCLI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CBI_CODBCO = "BOA" ';
    If Not fEmptyStr(strFilReg) Then
      strSQL := strSQL + ' AND CBI_STSSER=:STSSER ';
    strSQL := strSQL + ' GROUP BY CBI_CODCLI  ';
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   CBI_DTAINI, CBI_DTAFIN ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    If (Not fEmptyStr(strFilReg)) Then
      qryGen.ParamByName('STSSER').AsString := strFilReg;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
      FreeAndNil(qryGen);
      Exit;
    End;

    qryGen.First;
    strDtaIni := fRetSomenteNumeros(qryGen.FieldByName('CBI_DTAINI').AsString);
    qryGen.Last;
    strDtaFin := fRetSomenteNumeros(qryGen.FieldByName('CBI_DTAFIN').AsString);

    fStartTransaction;

    qryConsultaGen := fCriaQuery(qryConsultaGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  *  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryConsultaGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      strCgcEmp := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

    qryRemessa := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  B.*, ';
    strSQL := strSQL + '  C.CLI_NOMCLI, ';
    strSQL := strSQL + '  C.CLI_FANSOB, ';
    strSQL := strSQL + '  C.CLI_DTACAD, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_EMAIL_, C.CLI_EMCOB1) AS CLI_EMAIL_, ';
    strSQL := strSQL + '  R.AUTOINCREM AS AUTOINCREM, ';
    strSQL := strSQL + '  R.CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  COALESCE(R.CTR_VALREC, 0) AS CTR_VALREC, ';
    strSQL := strSQL + '  R.CTR_SEQBAI, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", "D", "C") AS TIPEND, ';
    strSQL := strSQL + '  IF(IFNULL(C.CLI_ENDCOB, "") = "", CONCAT(C.CLI_ENDERE, ", ", IFNULL(C.CLI_ENDNUM, ""), IF(IFNULL(C.CLI_ENDCOM, "") = "", "", CONCAT("  ", C.CLI_ENDCOM))), C.CLI_ENDCOB) AS ENDERE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_BAIRRO, C.CLI_BAICOB) AS BAIRRO, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", C.CLI_C_E_P_, C.CLI_CEPCOB) AS C_E_P_, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_NOMCID FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS CIDADE, ';
    strSQL := strSQL + '  IF(C.CLI_ENDCOB IS NULL OR C.CLI_ENDCOB="", (SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CODCID), ' +
                                                                     '(SELECT CID_ESTADO FROM CADCID WHERE CID_CODCID = C.CLI_CIDCOB)) AS ESTADO, ';
    strSQL := strSQL + '  (SELECT MIN(CTR_DTACAD) FROM CADREC WHERE CTR_CODCLI=B.CBI_CODCLI) AS CLIDES                                            ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCBI B  ';
    strSQL := strSQL + '  JOIN CADCLI C ON C.CLI_CODCLI = B.CBI_CODCLI ';
    strSQL := strSQL + '  JOIN CADREC R ON ';
    strSQL := strSQL + '    R.CTR_NUMDUP = B.CBI_NUMDUP AND ';
    strSQL := strSQL + '    R.CTR_PARCEL = B.CBI_PARCEL AND ';
    strSQL := strSQL + '    R.CTR_ESPDOC = B.CBI_ESPDOC AND ';
    strSQL := strSQL + '    R.CTR_CODEMP = B.CBI_CODEMP AND ';
    strSQL := strSQL + '    R.CTR_CODCLI = B.CBI_CODCLI AND ';
    strSQL := strSQL + '    R.CTR_SEQBAI = 0                ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CBI_CODBCO = :CODBCO ';

    If (Not fEmptyStr(strCodPor)) Then
      strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR '
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + ' AND ((CBI_CODPOR = "") OR (CBI_CODPOR IS NULL) ';
      strSQL := strSQL + ' OR CBI_CODPOR IN (' + fRetStrToSQLIn(strPortadoresOperador) + ')) ';
    End;

    If Not fEmptyStr(strFilReg) Then
      strSQL := strSQL + ' AND CBI_STSSER=:STSSER ';

    If strFilReg <> 'I' Then
      strSQL := strSQL + ' UNION ALL ' + StringReplace(strSQL, 'CADREC', 'DEL_CADREC', [rfReplaceAll]);

    With qryRemessa Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;

      If (Not fEmptyStr(strCodPor)) Then
        ParamByName('CODPOR').AsString := strCodPor;

      If (Not fEmptyStr(strFilReg)) Then
        ParamByName('STSSER').AsString := strFilReg;
      Open;
    End;

    If Not qryRemessa.IsEmpty Then
    Begin
      AssignFile(txtTexto, strArquivo);
      strFilePath := strArquivo;
      Rewrite(txtTexto);

      {*********************}
      {* HEADER DO ARQUIVO *}
      {******************AJ*}
      intCodSeq := 0;
      strHeader := '';
      strHeader := fPadR   ('0'                                    , 001)      + //001 - 001
                   fPadR   ('COMPORTAMENTAL_3_0_7'                 , 030)      + //002 - 031
                   fPadR   ('COMPORTAMENTAL'                       , 014)      + //032 - 045
                   fPadR   (strCgcEmp                              , 014)      + //046 - 059
                   fPadR   (strDtaIni                              , 008)      + //060 - 067
                   fPadR   (strDtaFin                              , 008)      + //068 - 075
                   fPadR   (strPeriod                              , 001)      + //076 - 076
                   fPadR   (' '                                    , 364, ' ');  //077 - 440


      {***************************}
      {* ESCREVE O HEADER NO TXT *}
      {************************AJ*}
      Writeln(txtTexto, strHeader);

      {************************}
      {* TRANSAÇÃO DO ARQUIVO *}
      {*********************AJ*}
      With qryRemessa Do
      Begin
        strTransacao := '';

        While Not Eof Do
        Begin

          Inc(intCodSeq);
          Application.ProcessMessages;

          strDtaVen := FormatDateTime('ddmmyyyy',FieldByName('CBI_DTAVEN').AsDateTime);

          strDtaEmi := FormatDateTime('ddmmyyyy',FieldByName('CBI_DTACAD').AsDateTime);

          strDtaRec := IIF(Not fEmptyStr(FieldByName('CTR_DTAREC').AsString),
                               FormatDateTime('ddmmyyyy',FieldByName('CTR_DTAREC').AsDateTime)
                           ,
                               '0');

          strCliDes := IIF(FieldByName('CLIDES').IsNull,
                           FormatDateTime('mmyyyy',FieldByName('CLI_DTACAD').AsDateTime)
                       ,
                           FormatDateTime('mmyyyy',FieldByName('CLIDES').AsDateTime));

          if not TEspecieParaArquivoRemessa.New.fValidaEspecie(FieldByName('CBI_ESPDOC').AsString) then
          begin
            CloseFile(txtTexto);
            Exit;
          end;

          strKeyDup := fPadR(FieldByName('CBI_NUMDUP').AsString, 12) +
                       fPadR(FieldByName('CBI_PARCEL').AsString, 03) +
                       fPadR(FieldByName('CBI_ESPDOC').AsString, 02) +
                       fPadR(FieldByName('CBI_CODEMP').AsString, 03) ;

          strCgcEmp := fTiraCaracEspeciaisPonto(strCgcEmp);
          strCgcCli := fTiraCaracEspeciaisPonto(FieldByName('CBI_C_G_C_').AsString);

          strTipReg := IIF(FieldByName('CBI_STSSER').AsString = 'I', 'J', 'B');

          strTipDoc := IIF(Not fEmptyStr(FieldByName('CBI_NOSNUM').AsString), 'B',
                           IIF(FieldByName('CBI_ESPDOC').AsString = 'NF', 'N', 'F'));

          strTransacao := fPadR      (strTipReg                                         , 001)      + //001 - 001
                          fPadR      (strCgcCli                                         , 014, '0') + //002 - 015
                          fPadR      (Copy(FieldByName('CLI_NOMCLI').AsString, 1, 55)   , 055, ' ') + //016 - 070
                          fPadR      (Copy(FieldByName('CLI_FANSOB').AsString, 1, 55)   , 055, ' ') + //071 - 125
                          fPadR      (FieldByName('TIPEND').AsString                    , 001)      + //126 - 126
                          fPadR      (Copy(FieldByName('ENDERE').AsString + '-' +
                                           FieldByName('BAIRRO').AsString, 1, 70)       , 070, ' ') + //127 - 196
                          fPadR      (Copy(FieldByName('CIDADE').AsString, 1, 30)       , 030, ' ') + //197 - 226
                          fPadR      (FieldByName('ESTADO').AsString                    , 002, ' ') + //227 - 228
                          fPadL      (FieldByName('C_E_P_').AsString                    , 008, '0') + //229 - 236
                          fPadL      (' '                                               , 028, ' ') + //237 - 264
                          fPadR      (FieldByName('CLI_EMAIL_').AsString                , 050, ' ') + //265 - 314
                          fPadR      (strCliDes                                         , 006)      + //315 - 320
                          fPadR      (strKeyDup                                         , 040, ' ') + //321 - 360
                          fPadL      (strTipDoc                                         , 001)      + //361 - 361
                          fPadR      ('R$  '                                            , 004)      + //362 - 365
                          fValNumForm(FieldByName('CBI_VALDUP').AsFloat                 , 013)      + //366 - 378
                          fValNumForm(FieldByName('CTR_VALREC').AsFloat                 , 013)      + //379 - 391
                          fPadR      (strDtaEmi                                         , 008)      + //392 - 399
                          fPadR      (strDtaVen                                         , 008)      + //400 - 407
                          fPadL      (strDtaRec                                         , 008, '0') + //408 - 415
                          fPadL      (' '                                               , 025, ' ');  //416 - 440

          {******************************}
          {* ESCREVE A TRANSACAO NO TXT *}
          {***************************AJ*}
          Writeln(txtTexto,strTransacao);

          {*******************************}
          {* ATUALIZAR AS DATAS DE ENVIO *}
          {****************************AJ*}
          strSQL  := '';
          If FieldByName('CBI_STSSER').AsString = 'I' Then
          Begin
            strSQL := strSQL + ' UPDATE ';
            strSQL := strSQL + '   CADREC ';
            strSQL := strSQL + ' SET ';
            strSQL := strSQL + '   CTR_DTABOA = IF(CTR_DTAREC IS NULL,    :DTASER,CTR_DTABOA), ';
            strSQL := strSQL + '   CTR_DTABO2 = IF(CTR_DTAREC IS NOT NULL,:DTASER,CTR_DTABO2)  ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
            strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
            strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
            strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
            strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
            strSQL := strSQL + '   CTR_CODEMP = :CODEMP ';

            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add(strSQL);
            qryGen.ParamByName('DTASER').AsDate   := VS_Date;
            qryGen.ParamByName('NUMDUP').AsString := FieldByName('CBI_NUMDUP').AsString;
            qryGen.ParamByName('PARCEL').AsString := FieldByName('CBI_PARCEL').AsString;
            qryGen.ParamByName('SEQBAI').AsInteger:= FieldByName('CTR_SEQBAI').AsInteger;
            qryGen.ParamByName('ESPDOC').AsString := FieldByName('CBI_ESPDOC').AsString;
            qryGen.ParamByName('CODCLI').AsString := FieldByName('CBI_CODCLI').AsString;
            qryGen.ParamByName('CODEMP').AsString := FieldByName('CBI_CODEMP').AsString;
            qryGen.ExecSQL;
          End
          Else
          Begin
            strSQL := strSQL + ' UPDATE                     ';
            strSQL := strSQL + '   DEL_CADREC               ';
            strSQL := strSQL + ' SET                        ';
            strSQL := strSQL + '   CTR_BOAEXC = :DTASER     ';
            strSQL := strSQL + 'WHERE                       ';
            strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
            strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
            strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
            strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
            strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
            strSQL := strSQL + '   CTR_CODEMP = :CODEMP     ';

            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add(strSQL);
            qryGen.ParamByName('DTASER').AsDate    := VS_Date;
            qryGen.ParamByName('NUMDUP').AsString  := FieldByName('CBI_NUMDUP').AsString;
            qryGen.ParamByName('PARCEL').AsString  := FieldByName('CBI_PARCEL').AsString;
            qryGen.ParamByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
            qryGen.ParamByName('ESPDOC').AsString  := FieldByName('CBI_ESPDOC').AsString;
            qryGen.ParamByName('CODCLI').AsString  := FieldByName('CBI_CODCLI').AsString;
            qryGen.ParamByName('CODEMP').AsString  := FieldByName('CBI_CODEMP').AsString;
            qryGen.ExecSQL;

            // Atualiza a CADREC no caso das devoluções que foram enviadas como exclusão
            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add(AnsiReplaceStr(strSQL, 'DEL_CADREC', 'CADREC'));
            qryGen.ParamByName('DTASER').AsDate    := VS_Date;
            qryGen.ParamByName('NUMDUP').AsString  := FieldByName('CBI_NUMDUP').AsString;
            qryGen.ParamByName('PARCEL').AsString  := FieldByName('CBI_PARCEL').AsString;
            qryGen.ParamByName('SEQBAI').AsInteger := FieldByName('CTR_SEQBAI').AsInteger;
            qryGen.ParamByName('ESPDOC').AsString  := FieldByName('CBI_ESPDOC').AsString;
            qryGen.ParamByName('CODCLI').AsString  := FieldByName('CBI_CODCLI').AsString;
            qryGen.ParamByName('CODEMP').AsString  := FieldByName('CBI_CODEMP').AsString;
            qryGen.ExecSQL;
          End;

          {****************}
          {* GRAVA LOGCTR *}
          {*************AJ*}
          untLogCtr.GravaLogCtr(FieldByName('AUTOINCREM').AsString, 'EXPORTAÇÃO DE ARQUIVO DE REMESSA - ' + strCodBco, 'untTBoaVista');

          Next;
        End;

      End;

      {************}
      {* TRAILLER *}
      {*********AJ*}
      strTrailler := '9'                                            + //001 - 001
                     fPadR('COMPORTAMENTAL_3_0_7'        , 030)     + //002 - 031
                     fPadR('COMPORTAMENTAL'              , 014)     + //032 - 045
                     fPadR(strCgcEmp                     , 014)     + //046 - 059
                     fPadL(IntToStr(intCodSeq)           , 010, '0')+ //060 - 069
                     fPadR(' '                           , 371);      //070 - 440

      {*****************************}
      {* ESCREVE O TRAILLER NO TXT *}
      {**************************AJ*}
      Writeln(txtTexto,strTrailler);

      CloseFile(txtTexto);

      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + '  CADCBI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + 'CBI_CODBCO = :CODBCO ';

      If (Not fEmptyStr(strCodPor)) Then
        strSQL := strSQL + '  AND CBI_CODPOR = :CODPOR ';

      With qryRemessa Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := strCodBco;

        If (Not fEmptyStr(strCodPor)) Then
          ParamByName('CODPOR').AsString := strCodPor;

        ExecSQL;
        Close;
      End;

      pBackupCnfBco;

      If fCommit then
			  fMensagem('','O arquivo de remessa foi gerado com sucesso!' + #13 +
					        'Arquivo Gerado: ' + strArquivo, ['&O K']);

    End
    Else
    Begin
      fRollBack;
      fMensagem('','Nenhum registro foi encontrado para gerar o arquivo!',['&O K']);
    End;

		FreeAndNil(qryRemessa);
		FreeAndNil(qryConsultaGen);
    FreeAndNil(qryGen);

    Result := True;
	Except
		On E: Exception Do
		Begin

		  fRollBack;
      CloseFile(txtTexto);
      DeleteFile(PWideChar(strFilePath));

      FreeAndNil(qryRemessa);
      FreeAndNil(qryConsultaGen);
      FreeAndNil(qryGen);
      fMensagem('','Ocorreu um erro ao gerar o arquivo. Erro gerado: ' + E.Message, ['&O K']);
		End;
  End;
end;

function TBoaVista.fRetConfiguracao: TConfBoaVista;
begin
  Result.strPathRemessa   := fGetBancoConfig(0, 'CONFIGBOA-1', 'PATHREM', '');
  Result.strPathRetorno   := fGetBancoConfig(0, 'CONFIGBOA-1', 'PATHRET', '');
  Result.strPeriodicidade := fGetBancoConfig(0, 'CONFIGBOA-1', 'PERIODI', '');
  Result.strUltPeriodo    := fGetBancoConfig(0, 'CONFIGBOA-1', 'ULTPERI', '');
end;

procedure TBoaVista.pSalvaConfiguracao(objConf: TConfBoaVista);
begin
  fGetBancoConfig(1, 'CONFIGBOA-1', 'PATHREM', objConf.strPathRemessa);
  fGetBancoConfig(1, 'CONFIGBOA-1', 'PATHRET', objConf.strPathRetorno);
  fGetBancoConfig(1, 'CONFIGBOA-1', 'PERIODI', objConf.strPeriodicidade);
  fGetBancoConfig(1, 'CONFIGBOA-1', 'ULTPERI', objConf.strUltPeriodo);
end;

end.
