unit untRcxTravas;

interface

uses untFuncFat, untTypesSistema, untFuncoesSimples, Uni, SysUtils, Data.DB,
     untLiberacao, untMsgLiberacao;

function fTravarBaixaDuplicataComBoletoEnviado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcel, strOpeRcx: String; var blnRecAut: Boolean): Boolean;
function fTravarCreditoDireto(strCodCli: String; fltValCre: Double;
                              strOpeRcx: String; blnCaixa: Boolean;
                              arrModalidades: TArrModalidade; blnTravar : Boolean = False;
                              arrDupSel : TArrDupSel = Nil): Boolean;
function fTravarCreditoPorRecebimentoAMaior(strOpeRcx: String; ArrDupSel: TArrDupSel; blnCaixa: Boolean; fltValCre: Double; arrModalidades: TArrModalidade): Boolean;

function fTravarTrocoUtlCartaoOuCheque(strOpeRcx: String; ArrDupSel: TArrDupSel;
                                       blnCaixa: Boolean; fltValTro: Double;
                                       arrModalidades: TArrModalidade): Boolean;
function fUtilizarTrava(blnTravar:Boolean = False): Boolean;

implementation

function fTravarBaixaDuplicataComBoletoEnviado(strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcel, strOpeRcx: String; var blnRecAut: Boolean): Boolean;

  function fGetSQL: String;
  begin
    Result := '';
    Result := Result + ' SELECT CTR_NUMDUP, CTR_PARCEL, CTR_ESPDOC, CTR_CODEMP, ';
    Result := Result + '        CONCAT(CTR_CODCLI, "-", CLI_NOMCLI) AS CTR_CLIENT, ';
    Result := Result + '        CTR_DTACAD, CTR_DTAVEN, CTR_BCOBOL, CTR_NOSNUM, CTR_VALDUP ';
    Result := Result + '   FROM CADREC ';
    Result := Result + '  INNER JOIN CADCLI ON CLI_CODCLI = CTR_CODCLI ';
    Result := Result + '  WHERE CTR_NUMDUP = :NUMDUP ';
    Result := Result + '    AND CTR_ESPDOC = :ESPDOC ';
    Result := Result + '    AND CTR_CODEMP = :CODEMP ';
    Result := Result + '    AND CTR_CODCLI = :CODCLI ';
    Result := Result + '    AND CTR_PARCEL = :PARCEL ';
    Result := Result + '    AND CTR_DTAREC IS NULL   ';
    Result := Result + '    AND CTR_SEQBAI = 0 ';
  end;

  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
  	objLinha  : TLinhaMsgLibera;
    qryCadRec : TUniQuery;
    fltTotGer : Double;
    fltTotCor : Double;
    fltPerJur : Double;
    fltValCor : Double;
begin
  fltTotGer := 0;
  fltTotCor := 0;
  fltPerJur := fCfgSis('JURATR', varDouble);
  qryCadRec := fCriaQuery(Nil);
  objLiberacao := TLiberacao.Create;

  With qryCadRec Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSQL);
    ParamByName('NUMDUP').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    ParamByName('PARCEL').AsString := strParcel;
    Open;
  End;

  Result := False;
  blnRecAut := False;

  If (Not qryCadRec.IsEmpty) Then
  Begin
    objLiberacao.objMsgLibera.pAddSeparador(132);
    objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE RECEBIMENTO DE DUPLICATA COM BOLETO IMPRESSO', alCentro, teAmbos, '', 132);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA'    , 15 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'ESP'          , 3  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'          , 3  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'      , 20 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'      , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENCTO'    , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'BANCO'        , 5  , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'NOSSO NUMERO' , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLIC.'   , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.CORRIGIDO' , 12 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    qryCadRec.First;
    While Not qryCadRec.Eof Do
    Begin
      fltValCor := fCalculaJurosCadCtr(qryCadRec.FieldByName('CTR_DTAVEN').AsDateTime,
                                       qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                       fltPerJur);

      fltTotGer := fltTotGer + qryCadRec.FieldByName('CTR_VALDUP').AsFloat;
      fltTotCor := fltTotCor + (qryCadRec.FieldByName('CTR_VALDUP').AsFloat + fltValCor);


      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'    , qryCadRec.FieldByName('CTR_NUMDUP').AsString + '-' + qryCadRec.FieldByName('CTR_PARCEL').AsString , 15 , alEsquerda );
      objLinha.pAddColuna('ESP'          , qryCadRec.FieldByName('CTR_ESPDOC').AsString                                                      , 3  , alCentro   );
      objLinha.pAddColuna('EMP'          , qryCadRec.FieldByName('CTR_CODEMP').AsString                                                      , 3  , alCentro   );
      objLinha.pAddColuna('CLIENTE'      , qryCadRec.FieldByName('CTR_CLIENT').AsString                                                      , 20 , alEsquerda );
      objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/mm/yyyy', qryCadRec.FieldByName('CTR_DTACAD').AsDateTime)                      , 10 , alCentro   );
      objLinha.pAddColuna('DT.VENCTO'    , FormatDateTime('dd/mm/yyyy', qryCadRec.FieldByName('CTR_DTAVEN').AsDateTime)                      , 10 , alCentro   );
      objLinha.pAddColuna('BANCO'        , qryCadRec.FieldByName('CTR_BCOBOL').AsString                                                      , 5  , alDireita  );
      objLinha.pAddColuna('NOSSO NUMERO' , qryCadRec.FieldByName('CTR_NOSNUM').AsString                                                      , 12 , alDireita  );
      objLinha.pAddColuna('VR.DUPLIC.'   , FloatToStrF(qryCadRec.FieldByName('CTR_VALDUP').AsFloat, ffFixed, 11, 2)                          , 12 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO' , FloatToStrF(qryCadRec.FieldByName('CTR_VALDUP').AsFloat + fltValCor, ffFixed, 11, 2)              , 12 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);

      qryCadRec.Next;
    End;


    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlTotal;
    objLinha.pAddColuna(''             , 'TOTAL'                                , 92 , alEsquerda );
    objLinha.pAddColuna('VR.DUPLIC.'   , FloatToStrF(fltTotGer, ffFixed, 11, 2) , 12 , alDireita  );
    objLinha.pAddColuna('VR.CORRIGIDO' , FloatToStrF(fltTotCor, ffFixed, 11, 2) , 12 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'RCXLIBRECBOL';
    objLiberacao.strMsgSen := 'Liberação de Recebimento';
    objLiberacao.strCodOpe := strOpeRcx;

    Result := (Not objLiberacao.fLibera);

    blnRecAut := Not Result;
  End;

  FreeAndNil(qryCadRec);
  FreeAndNil(objLiberacao);
end;

function fUtilizarTrava(blnTravar:Boolean = False): Boolean;
Begin
  Result := False;
  If fCfgSis('CRELIB', varBoolean) Then
    Result := True;
  If blnTravar Then
    Result := True;
End;

function fTravarCreditoDireto(strCodCli: String; fltValCre: Double;
                              strOpeRcx: String; blnCaixa: Boolean;
                              arrModalidades: TArrModalidade;
                              blnTravar : Boolean; arrDupSel : TArrDupSel): Boolean;
  Var
    objLiberacao : TLiberacao;
    intCnt : Integer;
    objTabela : TRegistroMsgLiberaTabela;
	objLinha  : TLinhaMsgLibera;
begin
  Result := False;

  If fUtilizarTrava(blnTravar) Then
  Begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto('LANÇAMENTO DE CRÉDITO DIRETO '+
                                           IIF(blnCaixa, 'PELO CAIXA', 'PELA MANUTENÇÃO DO CONTAS A RECEBER') , alCentro, teAmbos, '', 70);

      objLiberacao.objMsgLibera.pAddSeparador(70);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'          , strCodCli + '-' + fRetNomCliente(strCodCli), 16);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor do Crédito' , FloatToStrF(fltValCre, ffFixed, 11, 2)     , 16);
      For intCnt := Low(arrModalidades) To High(arrModalidades) Do
      Begin
        If intCnt = Low(arrModalidades) Then
        Begin
          objLiberacao.objMsgLibera.pAddSeparador(70);
          objLiberacao.objMsgLibera.pAddTextoCaption('Mod.de Pagamento',  fPadR(arrModalidades[intCnt].strDesmod + ':', 20) + FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2), 16);
        End
        Else
          objLiberacao.objMsgLibera.pAddTextoCaption('                ', fPadR(arrModalidades[intCnt].strDesmod + ':', 20) + FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2), 16);
      End;

      If Assigned(arrDupSel) Then
      Begin
        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DUPLICATA'    , 21 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'      , 12 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'     , 12 , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'      , 38 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA' , 23 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA'    , arrDupSel[0].strNumDoc  + '-' + arrDupSel[0].strParcel + '-' + arrDupSel[0].strEspDoc + '-' + arrDupSel[0].strCodEmp , 21 , alEsquerda );
        objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/MM/yyyy',arrDupSel[0].dtaDtaCad)                                                          , 12 , alCentro   );
        objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/MM/yyyy',arrDupSel[0].dtaDtaVen)                                                          , 12 , alCentro   );
        objLinha.pAddColuna('CLIENTE'      , arrDupSel[0].strCodCli + '-' + fRetNomCliente(arrDupSel[0].strCodCli)                                         , 38 , alEsquerda );
        objLinha.pAddColuna('VR.DUPLICATA' , FormatFloat('#,##0.00', arrDupSel[0].fltVlrRec)                                                               , 23 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
      End
      Else
        objLiberacao.objMsgLibera.pAddSeparador(70);
      objLiberacao.strDirAce := 'LIBCREDIRETO';
      objLiberacao.strMsgSen := 'Liberação de Crédito Direto ' + IIF(blnCaixa, 'pelo Caixa', 'pela Manutenção do Contas a Receber');
      objLiberacao.strCodOpe := strOpeRcx;

      Result := (Not objLiberacao.fLibera);
    finally
      FreeAndNil(objLiberacao);
    end;
  End;
end;

function fTravarCreditoPorRecebimentoAMaior(strOpeRcx: String; ArrDupSel: TArrDupSel; blnCaixa: Boolean; fltValCre: Double; arrModalidades: TArrModalidade): Boolean;
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
   	objLinha  : TLinhaMsgLibera;
    intCnt : Integer;
    fltTotal : Double;
begin
  Result := False;

  If fCfgSis('CRELIB', varBoolean) Then
  Begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto('LANÇAMENTO DE CRÉDITO POR RECEBIMENTO A MAIOR ' +
                                          IIF(blnCaixa, 'PELO CAIXA', 'PELA BAIXA DO CONTAS A RECEBER'), alCentro, teAmbos, '', 107);

      objLiberacao.objMsgLibera.pAddSeparador(107);

      objTabela := TRegistroMsgLiberaTabela.Create;

      fltTotal := 0;

      For intCnt := Low(ArrDupSel) To High(ArrDupSel) Do
      Begin
        If intCnt = Low(ArrDupSel) Then
        Begin

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DOCUMENTO'   , 24 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'CLIENTE'     , 30 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DT.CADASTRO' , 11 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'DT.VENCTO'   , 11 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

        End;

        fltTotal := fltTotal + ArrDupSel[intCnt].fltVlrRec;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'   , ArrDupSel[intCnt].strNumDoc +
                                            ArrDupSel[intCnt].strParcel + '-' +
                                            ArrDupSel[intCnt].strSeqBai + '-' +
                                            ArrDupSel[intCnt].strEspDoc + '-' +
                                            ArrDupSel[intCnt].strCodEmp                               , 24 , alEsquerda);
        objLinha.pAddColuna('CLIENTE'     , ArrDupSel[intCnt].strCodCli + '-' +
                                            fRetNomCliente(ArrDupSel[intCnt].strCodCli)               , 30 , alEsquerda);
        objLinha.pAddColuna('DT.CADASTRO' , FormatDateTime('dd/mm/yyyy', ArrDupSel[intCnt].dtaDtaCad) , 11 , alCentro  );
        objLinha.pAddColuna('DT.VENCTO'   , FormatDateTime('dd/mm/yyyy', ArrDupSel[intCnt].dtaDtaVen) , 11 , alCentro  );
        objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(ArrDupSel[intCnt].fltVlrRec, ffFixed, 11, 2)  , 20 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

        If intCnt = High(ArrDupSel) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''            , 'TOTAL'                               , 82 , alDireita , teAutcom);
          objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(fltTotal, ffFixed, 11, 2) , 20 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        End;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      fltTotal := 0;

      objTabela := TRegistroMsgLiberaTabela.Create;

      For intCnt := Low(arrModalidades) To High(arrModalidades) Do
      Begin
        fltTotal := fltTotal + arrModalidades[intCnt].fltValMod;

        If intCnt = Low(arrModalidades) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'MODALIDADE'  , 82 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        End;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('MODALIDADE'  , arrModalidades[intCnt].strDesmod                              , 82 , alEsquerda );
        objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2) , 20 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        If intCnt = High(arrModalidades) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''            , 'TOTAL'                               , 82 , alDireita, teAutcom);
          objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(fltTotal, ffFixed, 11, 2) , 20 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        End;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      //objLinha.pAddColuna(''                , ''                                    , 82 , alDireita, teAutcom);
      //objLinha.pAddColuna('VALOR DO CRÉDITO', FloatToStrF(fltValCre, ffFixed, 11, 2), 20 , alDireita, teAmbos, True);

      objLinha.pAddColuna(''                , 'VALOR DO CRÉDITO'                    , 82 , alDireita, teAutcom);
      objLinha.pAddColuna('', FloatToStrF(fltValCre, ffFixed, 11, 2), 20 , alDireita);

      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'LIBCREAMAIOR';
      objLiberacao.strMsgSen := 'Liberação de Crédito A Maior ' + IIF(blnCaixa, 'pelo Caixa', 'pela Baixa do Contas a Receber');
      objLiberacao.strCodOpe := strOpeRcx;

      Result := (Not objLiberacao.fLibera);
    finally
      FreeAndNil(objLiberacao);
    end;
  End;
end;

function fTravarTrocoUtlCartaoOuCheque(strOpeRcx: String; ArrDupSel: TArrDupSel;
                                       blnCaixa: Boolean; fltValTro: Double;
                                       arrModalidades: TArrModalidade): Boolean;
  Var
    objLiberacao : TLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
   	objLinha  : TLinhaMsgLibera;
    intCnt : Integer;
    fltTotal : Double;
begin
  Result := False;

  If fCfgSis('TRORCX', varBoolean) Then
  Begin
    objLiberacao := TLiberacao.Create;
    try
      objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE RECEBIMENTO COM TROCO DE CHEQUE E/OU CARTÃO ' +
                                          IIF(blnCaixa, 'PELO CAIXA', 'PELA BAIXA DO CONTAS A RECEBER'), alCentro, teAmbos, '', 107);

      objLiberacao.objMsgLibera.pAddSeparador(107);

      objTabela := TRegistroMsgLiberaTabela.Create;

      fltTotal := 0;

      For intCnt := Low(ArrDupSel) To High(ArrDupSel) Do
      Begin
        If intCnt = Low(ArrDupSel) Then
        Begin

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'DOCUMENTO'   , 24 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'CLIENTE'     , 30 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'DT.CADASTRO' , 11 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'DT.VENCTO'   , 11 , alCentro   , teAutcom);
          objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);

        End;

        fltTotal := fltTotal + ArrDupSel[intCnt].fltVlrRec;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'   , ArrDupSel[intCnt].strNumDoc +
                                            ArrDupSel[intCnt].strParcel + '-' +
                                            ArrDupSel[intCnt].strSeqBai + '-' +
                                            ArrDupSel[intCnt].strEspDoc + '-' +
                                            ArrDupSel[intCnt].strCodEmp                               , 24 , alEsquerda);
        objLinha.pAddColuna('CLIENTE'     , ArrDupSel[intCnt].strCodCli + '-' +
                                            fRetNomCliente(ArrDupSel[intCnt].strCodCli)               , 30 , alEsquerda);
        objLinha.pAddColuna('DT.CADASTRO' , FormatDateTime('dd/mm/yyyy', ArrDupSel[intCnt].dtaDtaCad) , 11 , alCentro  );
        objLinha.pAddColuna('DT.VENCTO'   , FormatDateTime('dd/mm/yyyy', ArrDupSel[intCnt].dtaDtaVen) , 11 , alCentro  );
        objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(ArrDupSel[intCnt].fltVlrRec, ffFixed, 11, 2)  , 20 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

        If intCnt = High(ArrDupSel) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''            , 'TOTAL'                               , 82 , alDireita , teAutcom);
          objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(fltTotal, ffFixed, 11, 2) , 20 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        End;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      fltTotal := 0;

      objTabela := TRegistroMsgLiberaTabela.Create;

      For intCnt := Low(arrModalidades) To High(arrModalidades) Do
      Begin
        fltTotal := fltTotal + arrModalidades[intCnt].fltValMod;

        If intCnt = Low(arrModalidades) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlCabecalho;
          objLinha.pAddColuna(''  , 'MODALIDADE'  , 82 , alEsquerda , teAutcom);
          objLinha.pAddColuna(''  , 'VR.RECEBIDO' , 20 , alDireita  , teAutcom);
          objTabela.lstLinhas.Add(objLinha);
        End;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('MODALIDADE'  , arrModalidades[intCnt].strDesmod                              , 82 , alEsquerda );
        objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(arrModalidades[intCnt].fltValMod, ffFixed, 11, 2) , 20 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        If intCnt = High(arrModalidades) Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''            , 'TOTAL'                               , 82 , alDireita, teAutcom);
          objLinha.pAddColuna('VR.RECEBIDO' , FloatToStrF(fltTotal, ffFixed, 11, 2) , 20 , alDireita );
          objTabela.lstLinhas.Add(objLinha);
        End;
      End;

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objTabela := TRegistroMsgLiberaTabela.Create;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna(''                , 'VALOR DO TROCO'                    , 82 , alDireita, teAutcom);
      objLinha.pAddColuna('', FloatToStrF(fltValTro, ffFixed, 11, 2), 20 , alDireita);

      objTabela.lstLinhas.Add(objLinha);

      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'DIRRCXTROCO';
      objLiberacao.strMsgSen := 'Liberação de troco utilizando cartão/cheque ' + IIF(blnCaixa, 'pelo Caixa', 'pela Baixa do Contas a Receber');
      objLiberacao.strCodOpe := strOpeRcx;

      Result := (Not objLiberacao.fLibera);
    finally
      FreeAndNil(objLiberacao);
    end;
  End;
end;


end.
