unit untFuncoes;

interface

Uses
  Classes, Uni, Controls, SysUtils, StrUtils, Variants, untFuncoesSimples,
  untFuncAutban, Forms, untFuncoesBoleto, untBancos, untTypesSistema,
  untDisparaEmailAut, untDisparaSMSAut, Data.DB, untTBoletoCarne, XMLIntf, untTBoleto1Via_Comprovante;

  function fRetNossoNumeroDisponivel(strBcoBol, strNosNum, strBcoIni: String;
    intCodCar: Integer; strCodEmp: String): String;

  function fGeraBoletoLaser(strNumBco: String;
                            cpuCampos: TCamposUso;
                            fltPerMor: Double;
                            strNosNum,
                            strNumDig: String;
                            strNomEmp,
                            strCgcEmp,
                            strBcoIni: String;
                            intCodCar: Integer;
                            var strArqBoletos: String;
                            var ABoletoCarneBuilder : TBoletoCarneBuilder;
                            var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
                            strMens01: String = '';
                            strMens02: String = '';
                            strReimpr: String = 'N';
                            strOpcFil: String = '';
                            blnBolPdf: Boolean = False;
                            strBraCrr: String = '';
                            strBB_Crr: String = '';
                            strConCrr: String = '';
                            strNomeForm: String = '';
                            strNomeFila: String = '';
                            fltMulta: Double = 0;
                            blnForcarImp: Boolean = False;
                            blnEnvioDeEMailAutomatico: Boolean = False;
                            strChaveCarteira: String = '';
                            strSelObs: String = '';
                            blnConsulta: Boolean = False;
                            strMsgProrrogacao : String ='';
                            AReimprimirBoletoOriginal : Boolean = False): Boolean;

  Function fRetEspDocBoleto(sCodEsp : String) : String;

  procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
  procedure pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed: String);
  function fSeqLaser: String;

  procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);
  function fDisparaEmailBoletoAutomatico(objDados : TDadosDisparaEmail;
                                         strOpcDoc: String = 'BO';
                                         objStatus: TStatusDisparaEmail = untTypesSistema.staNenhumaAcao;
                                         blnEnvioAutomaticoCobranca: Boolean = False): Boolean;

  function fRetCodCidByCliente(strCodCli: String): String;
  function fDisparaSMSBoletoAutomatico(objDados: TDadosDisparaSMS;
                                       strOpcDoc: String = 'BO';
                                       objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                       blnEnviaWhatsapp: Boolean = False): Boolean;

  function fDisparaWhatsappBoletoAutomatico(objDados: TDadosDisparaSMS;
                                            strOpcDoc: String = 'BO';
                                            objStatus: TStatusDisparaEmail = staNenhumaAcao): Boolean;

  function RetornaValorSemZerosEsquerdaSMS(AValor: String): String;

  function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
    strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;

  function RetornaLinkImagemPixCitel(ATextoQRCode: String; ATamanho: Integer = 150): String;

implementation

function fRetNossoNumeroDisponivel(strBcoBol, strNosNum, strBcoIni: String;
  intCodCar: Integer; strCodEmp: String): String;
  Var
    qryCadRec: TUniQuery;
    blnFim: Boolean;
    intTmpNum: Int64;

    strNosNumFmt: String;
begin
  Try
    qryCadRec := fCriaQuery;
    blnFim    := False;
    strNosNum := IntToStr(StrToInt64(strNosNum));

    qryCadRec.SQL.Clear;
    qryCadRec.SQL.Add(' SELECT SUM(QTD) AS QTD FROM (         ');
    qryCadRec.SQL.Add(' SELECT                                ');
    qryCadRec.SQL.Add('   COUNT(*) AS QTD                     ');
    qryCadRec.SQL.Add(' FROM                                  ');
    qryCadRec.SQL.Add('   CADREC                              ');
    qryCadRec.SQL.Add(' WHERE                                 ');
    qryCadRec.SQL.Add('   CTR_BCOBOL = :BCOBOL AND            ');
    qryCadRec.SQL.Add('   CTR_NOSNUM = :NOSNUM                ');
    qryCadRec.SQL.Add('                                       ');
    qryCadRec.SQL.Add(' UNION ALL                             ');
    qryCadRec.SQL.Add('                                       ');
    qryCadRec.SQL.Add(' SELECT                                ');
    qryCadRec.SQL.Add('   COUNT(*) AS QTD                     ');
    qryCadRec.SQL.Add(' FROM                                  ');
    qryCadRec.SQL.Add('   DEL_CADREC                          ');
    qryCadRec.SQL.Add(' WHERE                                 ');
    qryCadRec.SQL.Add('   CTR_BCOBOL = :BCOBOL AND            ');
    qryCadRec.SQL.Add('   CTR_NOSNUM = :NOSNUM                ');
    qryCadRec.SQL.Add('   )   AS TMP                          ');

    Repeat

      strNosNumFmt := fCalcNossoNumero(strBcoBol, strNosNum, strBcoIni, intCodCar, strCodEmp);
      strNosNumFmt := strNosNumFmt + fCalcDigito(strBcoBol, strNosNum, strBcoIni, intCodCar, strCodEmp);

      If Not fEmptyStr(strNosNumFmt) Then
      Begin
        qryCadRec.Close;
        qryCadRec.ParamByName('BCOBOL').AsString := strBcoBol;
        qryCadRec.ParamByName('NOSNUM').AsString := strNosNumFmt;
        qryCadRec.Open;

        If qryCadRec.FieldByName('QTD').AsInteger <= 0 Then
          blnFim := True
        Else
        Begin
          intTmpNum := StrToInt64(strNosNum)+1;
          strNosNum := IntToStr(intTmpNum);
        End;

        qryCadRec.Close;
      End
      Else
      Begin
        Result := '';
        Exit;
      End;

    Until (blnFim);

    Result := strNosNum;

  Finally
    FreeAndNil(qryCadRec);
  End;

end;

function fGeraBoletoLaser(strNumBco: String;
                          cpuCampos: TCamposUso;
                          fltPerMor: Double;
                          strNosNum,
                          strNumDig: String;
                          strNomEmp,
                          strCgcEmp,
                          strBcoIni: String;
                          intCodCar: Integer;
                          var strArqBoletos: String;
                          var ABoletoCarneBuilder : TBoletoCarneBuilder;
                          var ABoleto1ViaBuilder : TBoleto1Via_ComprovanteBuilder;
                          strMens01: String = '';
                          strMens02: String = '';
                          strReimpr: String = 'N';
                          strOpcFil: String = '';
                          blnBolPdf: Boolean = False;
                          strBraCrr: String = '';
                          strBB_Crr: String = '';
                          strConCrr: String = '';
                          strNomeForm: String = '';
                          strNomeFila: String = '';
                          fltMulta: Double = 0;
                          blnForcarImp: Boolean = False;
                          blnEnvioDeEMailAutomatico: Boolean = False;
                          strChaveCarteira: String = '';
                          strSelObs: String = '';
                          blnConsulta: Boolean = False;
                          strMsgProrrogacao : String = '';
                          AReimprimirBoletoOriginal : Boolean = False): Boolean;
  Var
    strTipEmp  : String;
    strTipSac  : String;
    strValTit  : String;
    fltValTit  : Double;
    strJurSuj  : String;
    fltJurSuj  : Double;
    strDesCob  : String;
    fltDesCob  : Double;
    strValMor  : String;
    strPerMor  : String; //percentual de juros de mora
    LJurosMora : String;
    strValMul  : String; //Valor da Multa
    fltDescon  : Double; //Desconto (Banco do Brasil 7 digitos)
    strDescon  : String; //Desconto (Banco do Brasil 7 digitos)
    strDtaVen  : String;
    strDtaCad,
    strChaveBRB  : String;
    strConRem  : String;
    strNumDup  : String;
    strEspDoc  : String;
    strCliCgc  : String;
    strNomCli  : String;
    strCodCli  : String;
    strEndere  : String;
    strBaiCli  : String;
    strNumCep  : String;
    strNomCid  : String;
    strEstado  : String;
    strCodCed  : String;
    strLinha   : String;
    txtArqTxt  : TextFile;
    strCodCar  : String;
    strDiaProt : String;
    strCodConv : String;
    strDigAgen : String;
    strCodAgen : String;
    strVariacao: String;
    strInstr1  : String;
    strInstr2  : String;
    strInstr3  : String;
    strInstr4  : String;
    strInstr5  : String;
    strObsAgr  : String;
    strObsAg1  : String;
    strObsAg2  : String;
    strObsAg3  : String;
    strUsoBan  : String;
    strProAce  : String; // IMPRIME PROTOCOLO DE ACEITE
    strParNum  : String; // UTILIZAR PARCELA NUMERAL? (A = 001) REQ:158267 --> MT
    strExpBol  : String; // TIPO DE EXPORTADOR PARA BOLETO
    strCntCor  : String; // CONTA CORRENTE
    strDigCnt  : String; // DIGITO DA CONTA CORRENTE
    strPathBol : String;
    strModali  : String; //Modalidade
    strDigCed  : String; //DIGITO DO CEDENTE
    strEndEmp,
    strCodEmp  : String;
    strObsAgrup1,
    strObsAgrup2,
    strObsAgrup3 : String;
    qryCadEmp  : TUniQuery;

    strIdeCed  : String;
    strUsoCli  : String;
    strTipDia  : String;
    strCarCrr  : String;
    str7DgCrr  : String;
    strCobReg  : String;
    strParcel  : String;
    fltPerMul  : Double; //Percentual da Multa
    strDesSuj  : String;
    fltDesSuj  : Double; //Desconto informado no título
    LValorDoTituloComDescontoSugerido : Boolean;
    strOutAcr  : String; //Outros acrescimos
    strSisCob  : String; //COBRANÇA CEF (SICOB, SIGCB OU SINCO)
    strSacAva	 : String;
    strTpIden  : String; //TIPO IDENTIFICADOR //HSBC 399 //COBRANÇA SEM REGISTRO *BB*
    strDesCed  : String;
    strEndCed  : String;
    strCompCed : String;
    strBaiCed  : String;
    LCarteira  : String;
    strCidCed  : String;
    strEstCed  : String;
    strCepCed  : String;
    strCgcCed  : String;
    intIndCar  : Integer;//Índice da carteira do Bradesco para correspondente
    strUsoBco  : String;
    strCodInstr1,
    strCodInstr2: String;
    strMailCli : String;
    strBenefi,
    strEndBen  : String;
    strPerMul  : String;
    strExibMsg : String;
    strImpAgBenef: String;
    strCedenteBRB: String;
    ADiasCartorio: String;

    strRazaoSocialCooperativa,
    strIncrisaoCooperativa,
    strEnderecoCoopetativa,
    strBairroCooperativa,
    strCidadeCooperativa,
    strEstadoCooperativa,
    strCEPCooperativa: String;

    strInstrucaoBancoInter1,
    strInstrucaoBancoInter2,
    strInstrucaoBancoInter3,
    strInstrucaoBancoInter4,
    strInstrucaoBancoInter5: String;
    strEspDocBol : String;
    strEmpresaCarteira: String;
    LObsCompletaAG: String;
    strNroOpe: String;
    strDiaMora: String;
    strNumOperacao: String;

    strCedenteInter: String;

    strImprimeParcelaA: String;
    qryQtdeParcelas   : TUniQUery;
    FObsDupAgr : Boolean;
    LDuplicataBoleto: TDuplicataCtr;
    LQRCode : String;

    strInTr5D  : String;
    strInfAdi  : String;

    LParcelasNegritoCarne: String;
    strCodCartBoleto : String;

    procedure pPreencherInstrucaoVazia(strTexto : String);
    Begin
      If fEmptyStr(strInstr1) Then
        strInstr1 := strTexto
      Else If fEmptyStr(strInstr2) Then
        strInstr2 := strTexto
      Else If fEmptyStr(strInstr3) Then
        strInstr3 := strTexto
      Else If fEmptyStr(strInstr4) Then
        strInstr4 := strTexto
      Else If fEmptyStr(strInstr5) Then
        strInstr5 := strTexto;
    End;

    procedure CarregaDadosProtestoBancoDoBrasil7D;
      Var
        LDiasProtesto: String;
        LInstrucao: String;
    Begin
      If AnsiReplaceStr(cpuCampos['CADCLI->CLI_PROPER'], #39, '') = 'S' Then
      Begin
        LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPERS', '');
        LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTPER', '');
      End;

      If fEmptyStr(LDiasProtesto) Then
      Begin
        If (AnsiReplaceStr(cpuCampos['CADCLI->CLI_CGCCPF'], #39, '') = '2') Then
        Begin
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PF', '');
          LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PF', '');
        End
        Else
        Begin
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PJ', '');
          LInstrucao    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PJ', '');
        End;
      End;

      If Not fEmptyStr(LDiasProtesto) Then
      Begin
        strDiaProt := LDiasProtesto;
        strTipDia  := IIF(MatchStr(LInstrucao,['03','04','05']),'1','2');
      End;
    End;

    procedure CarregaDadosProtestoBancoItau;
      Var
        LDiasProtesto: String;
        LCodProtesto: String;
        LTipDiaProtesto: String;
    Begin
        If AnsiReplaceStr(cpuCampos['CADCLI->CLI_PROPER'], #39, '') = 'S' Then
        Begin
          LCodProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTPER', '');

          If Not LCodProtesto.IsEmpty Then
          Begin
            strCodInstr2 :=  LCodProtesto;
            Exit;
          End;
        End;

        If (AnsiReplaceStr(cpuCampos['CADCLI->CLI_CGCCPF'], #39, '') = '2') Then
        Begin
          LCodProtesto  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PF', '');
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PF', '');
          LTipDiaProtesto :=  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA_PF', '');
        End
        Else
        Begin
          LCodProtesto  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRUCAO_PJ', '');
          LDiasProtesto := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAS_PROTESTO_PJ', '');
          LTipDiaProtesto :=  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA_PJ', '');
        End;

       If (Not fEmptyStr(LCodProtesto)) And (Not fEmptyStr(LDiasProtesto)) Then
       Begin
         strCodInstr2 := LCodProtesto;
         strDiaProt := LDiasProtesto;
         strTipDia  := LTipDiaProtesto;
       End;
    End;


    procedure pImprimirNroDocHistConfig;
    begin
      If (fCfgSis('IPNDBL', varBoolean, strEmpresaCarteira)) Then
      Begin
        if (not fEmptyStr(strInstr3)) And (Not fEmptyStr(strInstr4)) And (Not fEmptyStr(strInstr5)) Then
          Exit;

        strObsAg1 := fPadR(AnsiReplaceStr('REF. DOC.: ' + strNumDup + IIF(fEmptyStr(strEspDoc), '', '-' + strEspDoc), #39, ''), 60);

        if fEmptyStr(strInstr3) then
        begin
          strInstr3 := strInstr4;
          strInstr4 := strInstr5;
          strInstr5 := '';
        End;

        if fEmptyStr(strInstr4) then
        begin
          strInstr4 := strInstr5;
          strInstr5 := '';
        End;

        if fEmptyStr(strInstr3) then
          strInstr3 := strObsAg1
        else if fEmptyStr(strInstr4) then
          strInstr4 := strObsAg1
        else if fEmptyStr(strInstr5) then
          strInstr5 := strObsAg1;

      End;
    end;

    Function fImprimeObs(intObs: Integer; strObservacao: String): String;
    Begin

      If Not fCfgSis('SELOBS', varBoolean) Then
      Begin
        Result := strObservacao;
        Exit;
      End;

      Case intObs Of
        1: Result := IIF(Pos('1_', strSelObs) > 0, strObservacao, '');
        2: Result := IIF(Pos('2_', strSelObs) > 0, strObservacao, '');
        3: Result := IIF(Pos('3_', strSelObs) > 0, strObservacao, '');
        4: Result := IIF(Pos('4_', strSelObs) > 0, strObservacao, '');
        5: Result := IIF(Pos('5_', strSelObs) > 0, strObservacao, '');
      End;
    End;

    {**************************************************************************************}
    {*QUANDO ESTIVER CONFIGURADO PARA PRIORIZAR A IMPRESSÃO DAS OBSERVAÇÕES DA CARTEIRA   *}
    {*AO INVEZ DAS OBSERVAÇÕES DO AG, O SISTEMA IRA GERAR AS OBSERVAÇÕES DO AG            *}
    {*COM 120 CARACTER AO INVES DE 58, PARA CABER MAIS INFORMAÇÕES NA LINHAS DE OBSERVAÇÃO*}
    {*JÁ QUE ELA TERÁ MENOS LINHAS RESERVADAS PARA IMPRESSÃO NO BOLETO                    *}
    {***********************************************************REQ: 199996**************MT}
    function ImprimirObservacaoCompletaAG : Boolean;
    Begin
      Result := False;

      if strExibMsg <> 'N' then
      begin
        If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
        Begin
          LObsCompletaAG := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSIMPAG', 'N', strEmpresaCarteira, @LDuplicataBoleto);

          If Not LObsCompletaAG.Equals('S') Then Exit;

          Result := True;

          strInstr1 := fImprimeObs(1,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr2 := fImprimeObs(2,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

          strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
          strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
          strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

          If Length(strObsAgr) <= 120 Then
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := '';
            strObsAg3 := '';
          End
          Else If Length(strObsAgr) <= 240 Then
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := Copy(strObsAgr, 121, 120);
            strObsAg3 := '';
          End
          Else
          Begin
            strObsAg1 := LeftStr(strObsAgr, 120);
            strObsAg2 := Copy(strObsAgr, 121, 120);
            strObsAg3 := Copy(strObsAgr, 241, 120);
          End;
        End;
      end;

    End;

begin
  If Not DirectoryExists(VS_PathAutCom + '\LogoBoletos') Then
  Begin
    Result := False;
    pMensagemOk('A pasta ' + VS_PathAutCom + 'LogoBoletos não existe!' + #10#13 + 'O diretório deve existir com o logo no formato: LogoBanco.bmp!');
    Exit;
  End;
  strNosNum := StringReplace(strNosNum,' ','',[rfreplaceAll]);
  blnPreview := blnConsulta;
  {*****************************************}
  {* TIPO DE DIAS PARA PROTESTO.           *}
  {**************************************MV*}
  strTipDia := '1';

  strVariacao := '';
  strDescon   := '';
  strIdeCed   := '';
  strUsoCli   := '';
  strOutAcr   := '';
  strSisCob   := ' ';
  strCobReg   := ' ';

  strDesCed  := '';
  strEndCed  := '';
  strCompCed := '';
  strBaiCed  := '';
  strCidCed  := '';
  strEstCed  := '';
  strCepCed  := '';
  strCgcCed  := '';
  strParcel  := '';
  strChaveBRB := '';
  strConRem  := '';
  LQRCode := '';

  strCedenteInter := '';

  FApresentarEspDocumento := 'N';

  If AReimprimirBoletoOriginal Then
  Begin
    LDuplicataBoleto.strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '');
    LDuplicataBoleto.strParcel := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    LDuplicataBoleto.strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
    LDuplicataBoleto.strCodEmp := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, '');
    LDuplicataBoleto.strCodCli := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODCLI'], #39, '');
  End;

  LJurosMora := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CFG_TAXDIA', '0', strEmpresaCarteira, @LDuplicataBoleto);
  If AReimprimirBoletoOriginal and Not FEmptyStr(LJurosMora) Then
  Begin
    fltPerMor :=  strToFloat(LJurosMora);
  End;

  {************************************}
  {* DETERMINANDO EMPRESA DA CARTEIRA *}
  {*********************************AJ*}
  strEmpresaCarteira := VS_strCodEmp;
  If (Not fEmptyStr(strChaveCarteira)) Then
  Begin
    strEmpresaCarteira := RightStr(strChaveCarteira, 3);

    //Verifica se possui configuração da carteira no CNFBCO
    If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
    Begin
      If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'RESPONS', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      strEmpresaCarteira := VS_strCodEmp;
  End;
  End;

  Try
    qryCadEmp := fCriaQuery;
    pPesquisaCadEmp(Nil,qryCadEmp,strEmpresaCarteira);

    strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
    strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
    strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
    strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
    strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
    strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
    strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;
  Finally
    FreeAndNil(qryCadEmp);
  End;

  //*************************************************//
  // SE O NOME DO CEDENTE CADASTRADO NO CONFIGURACOES//
  // ESTIVER EM BRANCO ENTAO USA O NOME QUE VEM DO   //
  // CADASTRO DE EMPRESAS                            //
  //**********************************************ED*//
  If Not( fEmptyStr( fCfgSis('NOMCED', varString, strEmpresaCarteira) ) ) Then
    strNomEmp := fCfgSis('NOMCED', varString, strEmpresaCarteira);

  {*********************************************}
  {* MODALIDADE DE COBRANÇA INICIADA COM VAZIO *}
  {* DEPOIS CARREGADA                          *}
  {******************************************AF*}
  strModali := '';

  //*************************************************//
  // CARREGA AS CONFIGURACOES DO AUTBAN (CNFBCO.INI) //
  // FAVOR, ASSIM QUE CRIAR UMA NOVA CONFIGURACAO,   //
  // CARREGAR O CAMPO AQUI E NAO DENTRO DOS IF'S     //
  // DOS BANCOS                                      //
  //**********************************************ED*//
  strInTr5D     := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSV5DE', '',strEmpresaCarteira, @LDuplicataBoleto);
  strProAce     := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PROACEI', '', strEmpresaCarteira, @LDuplicataBoleto), 01);
  strParNum     := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PARCNUM', '', strEmpresaCarteira, @LDuplicataBoleto), 01);
  LParcelasNegritoCarne := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PARCELASNEGRITOCARNE', '', strEmpresaCarteira, @LDuplicataBoleto);

  {EXIBIR NO BOLETO DUPLICATAS AGRUPADAS, REQ: 190934 MT}
  FObsDupAgr := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSDUPAGR', 'S', strEmpresaCarteira, @LDuplicataBoleto).Equals('S');
  LCarteira := 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar) + '-' + strEmpresaCarteira;

  strImpAgBenef := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IMPAGBENEF', '', strEmpresaCarteira, @LDuplicataBoleto), 01);

  If fEmptyStr(strImpAgBenef) Then
    strImpAgBenef := 'S';

  {*******************************************}
  {* PEGA A MENSAGEM QUE FOI DIGITADA PELO   *}
  {* USUÁRIO, SENÃO, PEGA A QUE ESTIVER      *}
  {* CADASTRADA NO ARQUIVO (CNFBCO.INI)      *}
  {****************************************AC*}
  If (Not fEmptyStr(strMens01)) Then
    strInstr1  := fPadR(strMens01, 60)
  Else
    strInstr1  := fImprimeObs(1,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

  If (Not fEmptyStr(strMens02)) Then
    strInstr2  := fPadR(strMens02, 60)
  Else
    strInstr2  := fImprimeObs(2,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

  If Pos(strNumBco, '237') > 0 Then
  Begin
    strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60));
    strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60));
    strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', ''), 60));
  End;

  strUsoBan  := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'USOBANC', '', strEmpresaCarteira, @LDuplicataBoleto), 10);
  strCntCor  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDigCnt  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodConv :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDigAgen :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodAgen :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodCar  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
  strDiaProt :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodCed  :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
  strExibMsg :=       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXIBMSG', '', strEmpresaCarteira, @LDuplicataBoleto);
  ADiasCartorio :=    fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIACART', '', strEmpresaCarteira, @LDuplicataBoleto);

  if fEmptyStr(strDiaProt) Then
    strDiaProt := '0';

  strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

  strValTit := AnsiReplaceStr(cpuCampos['CADREC->CTR_VALDUP'], '.', ',');
  fltValTit := fStrToFloat(strValTit);

  strDesCob := AnsiReplaceStr(cpuCampos['CADREC->CTR_DESCOB'], '.', ',');
  If (fEmptyStr(strDesCob)) Then
    strDesCob := '0';
  fltDesCob := fStrToFloat(strDesCob);

  if fCfgSis('VALIMP', varBoolean, strEmpresaCarteira) then
  Begin
    strJurSuj := AnsiReplaceStr(cpuCampos['CADREC->CTR_JURSUJ'], '.', ',');
    fltJurSuj := fStrToFloat(strJurSuj);

    fltValTit := fltValTit + fltJurSuj + fltDesCob;
  End;

  LValorDoTituloComDescontoSugerido := (MatchStr(strNumBco,['237']) Or
                                       (MatchStr(strNumBco,['033']) And (strBcoIni= '033B')) Or
                                       (MatchStr(strNumBco,['756']) And (strBcoIni= '756_240p')) OR
                                        MatchStr(strNumBco,['001']) Or MatchStr(strNumBco,['341']) Or MatchStr(strNumBco,['748']) ) And
                                        fCfgSis('DESBOL', varBoolean) ;

  If LValorDoTituloComDescontoSugerido Then
  Begin
    fltValTit := (fltValTit - fStrToFloat(AnsiReplaceStr(cpuCampos['CADREC->CTR_DESSUJ'], '.', ',')));
  End;

  strValTit := fPadL(FloatToStr(fFormataFloat(fltValTit, 02) * 100), 14, '0');
  strDesCob := fPadL(FloatToStr(fFormataFloat(fltDesCob, 02) * 100), 14, '0');

  strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
  strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
  strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
  strParcel := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');
  strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strEspeci := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strCodEmp := AnsiReplaceStr(cpuCampos['CADREC->CTR_CODEMP'], #39, '');

  strEspDocOriginal         := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
  strNumDocumentoSemParcela := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '');
  strParcelaDoDocumento     := AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '');

  //*************************************************//
  // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
  // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
  //**********************************************ED*//
  strObsAgr := '';
  strObsAg1 := '';
  strObsAg2 := '';
  strObsAg3 := '';

  {**************************************************}
  {* VARIÁVEIS USADAS PARA INSTRUÇÃO DE AGRUPAMENTO *}
  {* COM 120 POSIÇÕES EM CADA LINHA NO BOLETO       *}
  {***********************************************JS*}
  strObsAgrup1 := '';
  strObsAgrup2 := '';
  strObsAgrup3 := '';

  if strExibMsg <> 'N' then
  begin
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin
      strObsAgr :=             AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 58 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
      End
      Else If Length(strObsAgr) <= 116 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
      End
      Else
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := Copy(strObsAgr, 115, 58);
      End;

    End;
  end;

  strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
  strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
  strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
  strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');
  strMailCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_EMAIL_'], #39, '');

  {**************************************}
  {* VERIFICA SE PEGA ENDERECO DE COB   *}
  {***********************************AF*}
  If fEmptyStr(strEndere) Or (strBcoIni = '077') Then
  Begin
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');
    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
  End
  Else
  Begin
    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
  End;


  strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
  strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
  strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

  strCodInstr1 := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRU1', '', strEmpresaCarteira, @LDuplicataBoleto);
  strCodInstr2 := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INSTRU2', '', strEmpresaCarteira, @LDuplicataBoleto);

  if strExibMsg <> 'N' then
  begin
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
    Begin

      If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := strObsAg1;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := strObsAg1;
        strInstr5 := strObsAg2;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
      Begin
        strInstr3 := strObsAg1;
        strInstr4 := strObsAg2;
        strInstr5 := strObsAg3;
      End;
    end
    Else
    Begin
      strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

      pImprimirNroDocHistConfig();
    End;
  end;

  //*************************************************//
  // DAQUI PARA BAIXO SAO OS TRATAMENTOS ESPECIFICOS //
  // PARA CADA BANCO.                                //
  //**********************************************ED*//

  {*************************************************}
  { BANCO BANCOOB                                   }
  {**********************************************JB*}
  If (strNumBco = '756') Or (strNumBco = '089') Then
  Begin
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'MODALID', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCONV', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strBB_Crr <> 'S' Then
    Begin
      strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEspDoc  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESPDOC_', '02 - DM  Duplicata Mercantil', strEmpresaCarteira, @LDuplicataBoleto);

      If strReimpr = 'N' Then
        strNosNum  := fStrZero(strNosNum, 07) + strNumDig
      Else
        strNosNum  := fStrZero(strNosNum, 08);
    End
    Else
    Begin
      str7DgCrr := IIF(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CRRBB7D', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S', 'D7', '');
      strCarCrr := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CRRCART', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCed := fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                   fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigCed := '';
      strCodAgen:= fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen:= fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strTipDia := fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'TIPDIA' , '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCar := fStrZero(fGetBancoConfig(0, 'CONFIG001' + str7DgCrr + '-' +  strCarCrr, 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

      If strReimpr <> 'N' Then
        strNosNum  := LeftStr(strNosNum, 07);
    End;


    strCodCed := strCodCed + strDigCed;

    strCodProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
  End;

  //*************************************************//
  // BANCO BMP MONEYPLUS                             //
  //**********************************************ED*//
  If (strNumBco = '274') And (strBcoIni = '274LP400p') Then
  Begin

    //strCodCed  := fArqIniAutban(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '');
    strCodCartBoleto := fGetBancoConfig(0, 'CONFIG' + strBcoIni +  '-' +  IntToStr(intCodCar), 'CARTBCO', '');

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 11) + strNumDig
    Else
      strNosNum  := fStrZero(strNosNum, 12);

    //*************************************************//
    // FOI CRIADO UM CAMPO NA CONFIGURACAO DO BRADESCO //
    // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
    // PARA A GERACAO DE REMESSA BANCARIA              //
    //**********************************************ED*//
    strExpBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPOBOL', '');
    If fEmptyStr( strExpBol ) Then
      strExpBol := '1';

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + '   ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

    strCodCar := fPadL(strCodCar, 2, '0');
    strCodCartBoleto := fPadL(strCodCartBoleto, 3, '0');
    If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '')) Then
      fltPerMul := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', ''));
    If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni, 'JUROSDI', '')) Then
    Begin
      fltPerMor := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni, 'JUROSDI', ''));
      strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
      fltPerMor := fFormataFloat((fltPerMor / 100.0)  / 30, 04);
      strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor, 02) * 100), 14, '0');
    End;
    strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '') +
                       fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', ''), 8, '0');

  End
  Else

  //*************************************************//
  // BANCO BRADESCO                                  //
  //**********************************************ED*//
  If Pos(strNumBco, '237_099_993_994_992_996_997_998_991_989_987_274_982_984_084_983_990_970_979_906_978_977_976_975_974_973_962_') > 0 Then //MF: 300148 - 31/08/23
  Begin

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '', strEmpresaCarteira, @LDuplicataBoleto);
    strOutAcr  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OUTACRE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);

    FApresentarEspDocumento := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESPDOCBOL', '', strEmpresaCarteira, @LDuplicataBoleto);

    If Not fEmptyStr(strOutAcr) Then
      strOutAcr  := FloatToStrF(fStrToFloat(strOutAcr), ffFixed, 12, 2);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 11) + strNumDig
    Else
      strNosNum  := fStrZero(strNosNum, 12);

    //*************************************************//
    // FOI CRIADO UM CAMPO NA CONFIGURACAO DO BRADESCO //
    // POIS SEGUNDO OS ATENDENTES EXISTEM 2 SITUACOES  //
    // PARA A GERACAO DE REMESSA BANCARIA              //
    //**********************************************ED*//
    strExpBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPOBOL', '', strEmpresaCarteira, @LDuplicataBoleto);
    If fEmptyStr( strExpBol ) Then
      strExpBol := '1';

    If strExpBol = '2' Then
      strCodCed := strCntCor + strDigCnt;

    If  (strNumBco = '993') Or (strNumBco = '992') Or (strNumBco = '274') Then //MF: 300148 - 31/08/23
    begin
      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strNumBco, 'JUROSDI', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      Begin
        fltPerMor := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strNumBco, 'JUROSDI', '', strEmpresaCarteira, @LDuplicataBoleto));
        strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
        strValMor := fPadL(FloatToStr(fFormataFloat((fltValTit * fltPerMor / 100.0) / 30, 02) * 100), 14, '0');
      End;
      strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                         fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto), 8, '0');
    end;

    If  (strNumBco = '987') or (strNumBco = '986') or (strNumBco = '985') Then
    begin
        strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                           fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto), 8, '0');
    End;

    If (strNumBco = '984') Then
    begin
        strCodCed := fPadL(fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '') +
                           fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', ''), 8, '0');
    End;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S') And (Pos(strNumBco, '237_099_994_987_986_985_978_977_976_975_974_973_962_') > 0) Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    If Pos(strNumBco, '099_084_') > 0 Then
    Begin
      strRazaoSocialCooperativa := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMECOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strIncrisaoCooperativa    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CGCCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEnderecoCoopetativa    := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDERECOCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strBairroCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRROCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCidadeCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDADECOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEstadoCooperativa      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTADOCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCEPCooperativa         := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEPCOOP', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    If (strNumBco = '237') And (strExibMsg <> 'N') then
    Begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr :=             AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60);
          strInstr4 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60);
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60);
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;
      end
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', ''), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', ''), 60));

        pImprimirNroDocHistConfig();
      End;
    End;

  End
  Else If (strNumBco = '741') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');

    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    //*************************************************//
    // DEPOIS DE MUITA LUTA, O BANCO RIBEIRAO INFORMOU //
    // QUE O NOSSO NUMERO CORRETO TEM A SEGUINTE MASK  //
    //  19/10000571603-4                               //
    //                                                 //
    // COMO A CARTEIRA E EXPORTADA EM OUTRO CAMPO,     //
    // ENTAO DEVEMOS EXPORTA SOMENTE O NN + DIG        //
    //                                 11 + 1          //
    //**********************************************ED*//
    strNosNum := strNosNum + strNumDig;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;
      end
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;


  End

  Else If (strNumBco = '104') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If ((strEspDoc = 'AG') And FObsDupAgr) And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fPadL(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);

    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
    Begin
      If strCodCar = '01' Then
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
      ELse
        strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig;
    End
    Else
    Begin
      If strCodCar = '01' Then
        strNosNum  := fStrZero(RightStr(strNosNum, 12), 12)
      Else
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11);
    End;

    if strExibMsg <> 'N' then
    begin
      If ((strEspDoc = 'AG') And FObsDupAgr) And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SISCOB', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      strSisCob := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SISCOB', '', strEmpresaCarteira, @LDuplicataBoleto);

  End
  Else If (strNumBco = '341') or (strNumBco = '995') Or (strNumBco = '981') Or (strNumBco = '707') Or (strNumBco = '988') Or (strNumBco = '964') Then
  Begin

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;


    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');
    LQRCode   := AnsiReplaceStr(cpuCampos['CADREC->CTR_QRCODE'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strNumBco = '707' then
    Begin
      strCodCed  := fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'NUMCTAC', '',strEmpresaCarteira, @LDuplicataBoleto) +
                    fGetBancoConfig(0, 'CONFIG' + strNumBco + '-' +  IntToStr(intCodCar), 'DIGCTAC', '',strEmpresaCarteira, @LDuplicataBoleto);
      strDigAgen := Copy(strCodAgen, Length(strCodAgen),1);
      strCodAgen := Copy(strCodAgen, 0, Length(strCodAgen)-1);
    End
    Else
      strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '',strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);
    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum  := fStrZero(RightStr(strNosNum, 09), 09);

    If strBcoIni = '341' Then
      CarregaDadosProtestoBancoItau;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    //*************************************************//
    // TRAVA QUE FOI CRIADA PARA NAO EXPORTAR O CNPJ   //
    // DO CEDENTE.                                     //
    // HOUVE CASOS DE CLIENTES QUE A IMPRESSAO DOS     //
    // BOLETOS ERA FEITA SOMENTE NA MATRIZ, DAI ENTAO  //
    // ERA IMPRESSO O CNPJ DA MATRIZ, MESMO SE O CLIEN.//
    // HAVIA REALIZADO A COMPRA EM UMA FILIAL          //
    //**********************************************ED*//
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPCNPJ', '', strEmpresaCarteira, @LDuplicataBoleto) = 'N' Then
      strCgcEmp := '';

    strEspDoc := 'DM';

   if (strNumBco = '995') Or (strNumBco = '981') then
   begin
     strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto)+
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
   end;

    if strNumBco = '341' then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', ''))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '')));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;
    end;

  End

  //****************************************************
  //*   BANCO ABC BRASIL                               *
  //****************************************************
  Else If (strNumBco = '246') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODBENE', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);
    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig
    Else
      strNosNum  := fStrZero(RightStr(strNosNum, 11), 11);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    //*************************************************//
    // TRAVA QUE FOI CRIADA PARA NAO EXPORTAR O CNPJ   //
    // DO CEDENTE.                                     //
    // HOUVE CASOS DE CLIENTES QUE A IMPRESSAO DOS     //
    // BOLETOS ERA FEITA SOMENTE NA MATRIZ, DAI ENTAO  //
    // ERA IMPRESSO O CNPJ DA MATRIZ, MESMO SE O CLIEN.//
    // HAVIA REALIZADO A COMPRA EM UMA FILIAL          //
    //**********************************************ED*//
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EXPCNPJ', '', strEmpresaCarteira, @LDuplicataBoleto) = 'N' Then
      strCgcEmp := '';

    strEspDoc := 'DM';

  End

  //****************************************************
  //*   BANCO BTG PACTUAL                              *
  //****************************************************
  Else If (strNumBco = '208') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    Else
       strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

  //****************************************************
  //*   BANCO GERENCIANET
  //    MF: 284963 - 13/07/23                               *
  //****************************************************
  Else If (strNumBco = '364') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMAGEC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    //If strReimpr = 'N' Then
    //   strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    //Else
    //   strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

  //****************************************************
  //*   BANCO CRESOL
  //    MF: 287323 - 14/07/23                               *
  //****************************************************
  Else If (strNumBco = '133') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strTipDia := '0';
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['1','5']) Then // CORRIDOS
       strTipDia := '2'
    Else
    If MatchStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODPROT', '0', strEmpresaCarteira, @LDuplicataBoleto),['2','4']) Then // UTEIS
       strTipDia := '1';

    strInfAdi  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INFADIC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    //strNroOpe  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig
    Else
       strNosNum  := fStrZero(RightStr(strNosNum, 12), 12);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO BANCO BANRISUL          //
  //**********************************************ED*//
  Else If (strNumBco = '041') Then
  Begin

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum  := strNosNum;

  End

  {***************************************}
  {* EXPORTADOR REFERENTE AO BANCO INTER *}
  {************************************AJ*}
  Else If (strNumBco = '077') Then
  Begin
    strCedenteInter := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strInstr1 := '';
    strInstr2 := '';
    strInstr3 := '';
    strInstr4 := '';
    strInstr5 := '';

    If (Not fEmptyStr(strMens01)) Then
      strInstr1  := fPadR(strMens01, 60);

    strInstrucaoBancoInter1 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV1', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter2 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV2', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter3 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter4 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
    strInstrucaoBancoInter5 := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 78);
  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO SICREDI                 //
  //**********************************************ED*//
  Else If ((strNumBco = '748') and (strBcoIni <> '748API'))Then
  Begin
    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S' Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
    Begin
      strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 120 Then
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := '';
        strObsAgrup3 := '';
      End
      Else If Length(strObsAgr) <= 240 Then
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := Copy(strObsAgr, 121, 120);
        strObsAgrup3 := '';
      End
      Else
      Begin
        strObsAgrup1 := LeftStr(strObsAgr, 120);
        strObsAgrup2 := Copy(strObsAgr, 121, 120);
        strObsAgrup3 := Copy(strObsAgr, 241, 120);
      End;
    End;

    if strReimpr = 'N' then
    begin
      strConRem := fAtualizaProCod('CONREM');
      fExecutaSQL(' UPDATE   ' +
                  '   CADREC ' +
                  ' SET      ' +
                  '   CTR_CONREM = "'+strConRem+'" ' +
                  ' WHERE    ' +
                  '    CTR_NUMDUP = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '')+'" AND ' +
                  '    CTR_PARCEL = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '')+'" AND ' +
                  '    CTR_SEQBAI = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_SEQBAI'], #39, '')+'" AND ' +
                  '    CTR_ESPDOC = "'+strEspDoc+'" AND ' +
                  '    CTR_CODCLI = "'+strCodCli+'" AND ' +
                  '    CTR_CODEMP = "'+strCodEmp+'" ');
    end
    else strConRem := AnsiReplaceStr(cpuCampos['CADREC->CTR_CONREM'], #39, '');

    If strReimpr = 'N' Then
      strNosNum := fStrZero(RightStr(strNosNum, 08), 08) + strNumDig
    Else
      strNosNum := strNosNum;

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'POSTOCO', '', strEmpresaCarteira, @LDuplicataBoleto) +
                 fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCobReg := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'COBREGI', '', strEmpresaCarteira, @LDuplicataBoleto);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        {****************************************}
        {* PRIORIZA AS OBS DA CARTEIRA E TRUNCA *}
        {* AS OBS DO AGRUPAMENTO SE FOR O CASO  *}
        {*************************************JS*}
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        If fEmptyStr(strInstr3) And fEmptyStr(strInstr4) And fEmptyStr(strInstr5) Then
        Begin
          strInstr3 := strObsAgrup1;
          strInstr4 := strObsAgrup2;
          strInstr5 := strObsAgrup3;
        End
        Else If (Not fEmptyStr(strInstr3)) And fEmptyStr(strInstr4) And fEmptyStr(strInstr5) Then
        Begin
          strInstr4 := strObsAgrup1;
          strInstr5 := strObsAgrup2;
        End
        Else If (Not fEmptyStr(strInstr3)) And (Not fEmptyStr(strInstr4)) And fEmptyStr(strInstr5) Then
        Begin
          strInstr5 := strObsAgrup1;
        End;
      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  //*************************************************//
  // EXPORTADOR REFERENTE AO BANESPA                 //
  //**********************************************ED*//
  Else If (strNumBco = '033') And (Pos(strBcoIni,'033B_033B240p_') <= 0) Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  {***********************************}
  {* SANTANDER 033                   *}
  {********************************AF*}
  Else If (strNumBco = '033') And (Pos(strBcoIni,'033B_033B240p_') > 0) Then
  Begin
    strNumBco := '33B';
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);

    If Length(strCodAgen) > 4 Then
      strDigAgen := RightStr(strCodAgen,1)
    Else
      strDigAgen := ' ';

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 7) + strNumDig
    Else
      strNosNum := strNosNum;

    If strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 120 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 240 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 120);
          strObsAg2 := Copy(strObsAgr, 121, 120);
          strObsAg3 := Copy(strObsAgr, 241, 120);
        End;

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
          strInstr4 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
        strInstr4 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60);
        strInstr5 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60);

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

    if (strBcoIni = '033B240p') then
    Begin
      strNumBco := '3B2';
      strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEDENTE', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCodCar  := LeftStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPOCOB', ''),1);
    End;


  End

  {***********************************}
  {* BANESTES 021                    *}
  {********************************AF*}
  Else If (strNumBco = '021') Then
  Begin
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    If Length(strCodAgen) > 4 Then
      strDigAgen := RightStr(strCodAgen,1)
    Else
      strDigAgen := ' ';

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 8) + strNumDig
    Else
      strNosNum := strNosNum;
  End

  Else If ((strNumBco = '422') and (strBcoIni = '422API')) Then
  Begin
    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  {*****************************************}
  {* BANCO SAFRA 422                       *}
  {**************************************AF*}
  Else If ((strNumBco = '422') and (strBcoIni <> '422API')) Then
  Begin
    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strIdeCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENCED', '', strEmpresaCarteira, @LDuplicataBoleto);
    strUsoCli := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'USOCLIE', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDigAgen := RightStr(strCodAgen,1);

    If SameText(strReimpr,'N') Then
      strNosNum := fStrZero(RightStr(strNosNum, 8), 8) + strNumDig
    Else
      strNosNum := strNosNum;

    If strBraCrr = 'S' Then
    Begin
      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDBRAD', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
        intIndCar := StrToIntDef(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDBRAD', '', strEmpresaCarteira, @LDuplicataBoleto), 0)
      Else
      Begin
        fMensagem('','Informe o índice da carteira correspondente Bradesco nas configurações do Safra (Autban)!', ['&OK']);
        Result := False;
        Exit;
      End;

      strCodCed := fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);            //
      strCodCed := strCodCed + fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);//
      strCodAgen:= fPadL(fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto), 4);  //HOMOLOGAÇÃO IMPERIO
      strDigAgen:= fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);            //
      strCodCar := fGetBancoConfig(0, 'CONFIG237-' +  IntToStr(intIndCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);            //

      strDesCed  := 'BANCO SAFRA S/A';
      strEndCed  := '';
      strCompCed := '';
      strBaiCed  := '';
      strCidCed  := '';
      strEstCed  := '';
      strCepCed  := '';
      strCgcCed  := '';
      strUsoBco  := 'CIP130';

      If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG237-' + IntToStr(intIndCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto)) Then
      Begin
        strNosNum := fCalcNossoNumero('237', FormatDateTime('yy', VS_Date) + strNosNum, '237', intIndCar, VS_strCodEmp);
        strNumDig := fCalcDigito('237', strNosNum, '237', intIndCar, VS_strCodEmp);
        strNosNum := strNosNum + strNumDig;
        strCodCed := RightStr(strCodCed, 8);
      End
      Else
      Begin
        fMensagem('','Configure a carteira ' + IntToStr(intIndCar) + ' do Bradesco para a loja ' + VS_strCodEmp + ' para utilizar o Safra com correspondente (Autban)!', ['&OK']);
        Result := False;
        Exit;
      End;
    End;

    fltDescon := fStrToFloat(fGetBancoConfig(0, 'CONFIG422', 'DESCONT', '', strEmpresaCarteira, @LDuplicataBoleto));
    strDescon := fPadL(FloatToStr(fFormataFloat(fltDescon, 02) * 100), 14, '0');

    strEspDoc := 'DM';

    If strNumBco = '422' then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', ''))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '')));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;
    end;

  End


  //*************************************************//
  // EXPORTADOR REFERENTE AO SANTANDER               //
  //**********************************************LU*//
  Else If (strNumBco = '353') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', ''), 60);
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

  End

  //*************************************************//
  // BANCO SOFISA 637 LP - LAYOUT PROPRIO            //
  //*************************************************//
  Else If (strNumBco = '637') And (strBcoIni = '637LP444p') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar      := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CARTBCO', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaMora     := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAMORA', '0', strEmpresaCarteira, @LDuplicataBoleto);
    strNumOperacao := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMOPER', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 10) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  //*************************************************//
  // BANCO SOFISA REFERENTE AO SANTANDER             //
  //*************************************************//
  Else If (strNumBco = '637') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strDiaProt:= fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := RightStr(strNosNum, 12) + strNumDig
    Else
      strNosNum := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '') = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '');
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '') + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '');
    End;

  End

  Else If (strNumBco = '001') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;


    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');

    If Trim(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + intToStr(intCodCar), 'TIPCOBR', '', strEmpresaCarteira, @LDuplicataBoleto)) = 'D' Then
    Begin
      strPerMor := fPadL('0', 14, '0');
      strValMor := fPadL('0', 14, '0');
    End
    Else
    Begin
      strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
      strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');
    End;

    {EDUARDO }
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strTipDia  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPDIA', '1', strEmpresaCarteira, @LDuplicataBoleto);

    strVariacao := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'VARCART', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    strSacAva := fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto), 21);
    if Not fEmptyStr(strSacAva) Then
  	  strSacAva := strSacAva + ' ' + fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJSAC', '', strEmpresaCarteira, @LDuplicataBoleto), 18);


    If strReimpr = 'N' Then
    Begin
      If Pos('D7', strBcoIni) > 0 Then
        strNosNum  := fStrZero(RightStr(strNosNum, 10), 10) + strNumDig
      Else
        strNosNum  := fStrZero(RightStr(strNosNum, 11), 11) + strNumDig;
    End
    Else
      strNosNum  := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := '';
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := '';
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    If strBcoIni = '001D7' Then
    Begin
      fltDescon := fStrToFloat(fGetBancoConfig(0, 'CONFIG001D7', 'DESCONT', ''));
      strDescon := fPadL(FloatToStr(fFormataFloat(fltDescon, 02) * 100), 14, '0');

      CarregaDadosProtestoBancoDoBrasil7D;
    End;

    If (strBcoIni = '001') Or (strBcoIni = '001D7') Then
    begin
      if not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', ''))  then
      Begin
        qryCadEmp := fCriaQuery;
        Try
          pPesquisaCadEmp(Nil,qryCadEmp, (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'EMPRBOL', '', strEmpresaCarteira, @LDuplicataBoleto)));

          strEndEmp := qryCadEmp.FieldByName('EMP_ENDERE').AsString;
          strEndEmp := strEndEmp + IIF(fEmptyStr(qryCadEmp.FieldByName('EMP_ENDNUM').AsString),'',', ' + qryCadEmp.FieldByName('EMP_ENDNUM').AsString);
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_ENDCMP').AsString;
          strEndEmp := strEndEmp + ' ' + qryCadEmp.FieldByName('EMP_BAIRRO').AsString;
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString);
          strEndEmp := strEndEmp + ' - ' + fRetNomCidade(qryCadEmp.FieldByName('EMP_CODCID').AsString, 1);
          strEndEmp := strEndEmp + ' - ' + qryCadEmp.FieldByName('EMP_C_E_P_').AsString;

          strCgcEmp  := qryCadEmp.FieldByName('EMP_C_G_C_').AsString;
          strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

          if fEmptyStr(fCfgSis('NOMCED')) then
            strNomEmp := qryCadEmp.FieldByName('EMP_NOMEMP').AsString;
        Finally
          FreeAndNil(qryCadEmp);
        End;
      End;

    end;

    If fCfgSis('BENBOL', varBoolean) And (Not fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CPFBENE', '')))  Then
    Begin
      strNomEmp := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '');
      strCgcEmp := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'CPFBENE', '');
      strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');
    End;

    strEspDoc := 'DM';

  End

  {*************************************************}
  { BANCO CREDISIS                                  }
  {**********************************************JB*}
  Else If (strNumBco = '097') Then
  Begin

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCART', '', strEmpresaCarteira, @LDuplicataBoleto),2);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    //strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);

    strEspDocBol := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPTITULO', '03', strEmpresaCarteira, @LDuplicataBoleto);
    strEspDoc := fRetEspDocBoleto( leftStr(strEspDocBol,2) );

    If strReimpr = 'N' Then
       strNosNum  := fStrZero(strNosNum, 20) //+ strNumDig
    Else
       strNosNum  := fStrZero(strNosNum, 20);

    strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

    pImprimirNroDocHistConfig();

    {**************************************}
    {* VERIFICA SE ENVIA SACADOR/AVALISTA *}
    {***********************************AJ*}
    If (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'SACAVAL', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S') Then
    Begin
      strBenefi := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NOMEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CNPJBEN', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndBen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDEBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMPBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAIRBEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTABEN', '', strEmpresaCarteira, @LDuplicataBoleto) + ' - ' +
                   fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEP_BEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    End;

  End

  Else If (strNumBco = '409') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');

    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDCOB'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    {**************************************}
    {* VERIFICA SE PEGA ENDERECO DE COB   *}
    {***********************************AF*}
    If fEmptyStr(strEndere) Then
    Begin
      strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
      IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                                cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    End
    Else
    Begin
      strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAICOB'], #39, '');
      strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CEPCOB'], #39, '');
      strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_CIDCOB'], #39, '');
      strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTCOB'], #39, '');
    End;

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar  := fStrZero(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto),3);

    If strReimpr = 'N' Then
      strNosNum  := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum  := strNosNum;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;

    strEspDoc := 'DM';

    If StrToIntDef(strCodCar, 0) = 20 Then
      strUsoCli  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

  End

  Else If (strNumBco = '356') Then
  Begin

    strCodCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODEMPR', '', strEmpresaCarteira, @LDuplicataBoleto);
    strNosNum := strNosNum;

  End

  Else If (strNumBco = '399') Then
  Begin

    strTipEmp := IIF(Length(strCgcEmp) > 11, '01', '02');

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    //*************************************************//
    // SE A DUPLICATA FOR UM AGRUPAMENTO ENTAO CARREG. //
    // AS DUPLICATAS PROVENIENTES DO AGRUPAMENTO       //
    //**********************************************ED*//
    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCDEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strModali = 'N' Then
    Begin
      strTpIden := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPIDENT', '', strEmpresaCarteira, @LDuplicataBoleto);

    End;
    If strReimpr = 'N' Then
    Begin

      If strModali = 'S' Then
        strNosNum := fStrZero( RightStr(strNosNum, 10) + strNumDig , 11)
      Else
        strNosNum := fStrZero( strNosNum + strNumDig, 13);

    End
    Else
    Begin

      If strModali = 'S' Then
        strNosNum := fStrZero( RightStr(strNosNum, 11), 11)
      Else
        strNosNum := fStrZero( RightStr(strNosNum, 13), 13);

    End;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*****************************************}
  {* NOSSA CAIXA NOSSO BANCO               *}
  {**************************************AF*}
  Else If (strNumBco = '151') Then
  Begin
    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := IIf(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TIPCOBR', '', strEmpresaCarteira, @LDuplicataBoleto) = 'S', '8', '9');
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'MODALID', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(RightStr(strNosNum, 9), 9) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 10);
  End

  {*******************}
  {* BANCO MERCANTIL *}
  {****************JU*}
  Else If (strNumBco = '389') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodConv := '';
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'IDENTBC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);

    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 11);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* B. DO NORDESTE  *}
  {*REQ-95543******MO*}
  Else If (strNumBco = '004') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin
      strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
      strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

      If Length(strObsAgr) <= 58 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := '';
        strObsAg3 := '';
      End
      Else If Length(strObsAgr) <= 116 Then
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := '';
      End
      Else
      Begin
        strObsAg1 := LeftStr(strObsAgr, 58);
        strObsAg2 := Copy(strObsAgr, 59, 56);
        strObsAg3 := Copy(strObsAgr, 115, 58);
      End;
    End;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto);
    strNosNum := fStrZero(strNosNum, 7);

    If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
    Begin

      If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := strObsAg1;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := strObsAg1;
        strInstr5 := strObsAg2;
      End
      Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr3 := strObsAg1;
        strInstr4 := strObsAg2;
        strInstr5 := strObsAg3;
      End;

    End
    Else
    Begin
      strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
    End;
  End

  {*******************}
  {* BANCO CECRED    *}
  {*REQ-29077******JU*}
  Else If (strNumBco = '085') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCOPE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strModali  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CBRAREG', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDiaProt := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIAPROT', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* BANCO BRB       *}
  {*******************}
  Else If (strNumBco = '070') Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strReimpr = 'N' then
    begin
      strConRem := fAtualizaProCod('CONREM');
      fExecutaSQL(' UPDATE   ' +
                  '   CADREC ' +
                  ' SET      ' +
                  '   CTR_CONREM = "'+strConRem+'" ' +
                  ' WHERE    ' +
                  '    CTR_NUMDUP = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'], #39, '')+'" AND ' +
                  '    CTR_PARCEL = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_PARCEL'], #39, '')+'" AND ' +
                  '    CTR_SEQBAI = "'+AnsiReplaceStr(cpuCampos['CADREC->CTR_SEQBAI'], #39, '')+'" AND ' +
                  '    CTR_ESPDOC = "'+strEspDoc+'" AND ' +
                  '    CTR_CODCLI = "'+strCodCli+'" AND ' +
                  '    CTR_CODEMP = "'+strCodEmp+'" ');
    end
    else strConRem := AnsiReplaceStr(cpuCampos['CADREC->CTR_CONREM'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar  := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    strDigit1  := '';
    strDigit2  := '';

    strChaveBRB := strNosNum;
    strCedenteBRB := IntToStr(StrToInt64(strCodCed));

    If Length(strCedenteBRB) < 7 Then
      strCedenteBRB := fStrZero(strCedenteBRB, 7);

    strChaveBRB := Copy(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODMOD_', '', strEmpresaCarteira, @LDuplicataBoleto), 1 , 1) + strChaveBRB + '070';
    strChaveBRB := '000' + RightStr(strCodAgen, 3)+ strCedenteBRB + strChaveBRB;
    strDigit1   := fCalcDigitoModulo10(strChaveBRB);
    strDigit2   := fCalcDigitoModulo11(strChaveBRB, strDigit1);
    strChaveBRB := strChaveBRB + strDigit1 + strDigit2;

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
  End

  {*******************}
  {* BANCO UNICRED   *}
  {*REQ-30140******JU*}
  Else If Pos(strNumBco, '090_136_') > 0 Then
  Begin

    strDtaVen := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTAVEN'], #39, '');
    strDtaCad := AnsiReplaceStr(cpuCampos['CADREC->CTR_DTACAD'], #39, '');
    strNumDup := AnsiReplaceStr(cpuCampos['CADREC->CTR_NUMDUP'] + cpuCampos['CADREC->CTR_PARCEL'], #39, '');
    strEspDoc := AnsiReplaceStr(cpuCampos['CADREC->CTR_ESPDOC'], #39, '');

    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger, strEmpresaCarteira) = 1) Then
      Begin
        strObsAgr := AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG1'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG2'], #39, '');
        strObsAgr := strObsAgr + AnsiReplaceStr(cpuCampos['CADREC->CTR_OBSAG3'], #39, '');

        If Length(strObsAgr) <= 58 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := '';
          strObsAg3 := '';
        End
        Else If Length(strObsAgr) <= 116 Then
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := '';
        End
        Else
        Begin
          strObsAg1 := LeftStr(strObsAgr, 58);
          strObsAg2 := Copy(strObsAgr, 59, 56);
          strObsAg3 := Copy(strObsAgr, 115, 58);
        End;
      End;
    end;

    strCliCgc := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_G_C_'], #39, '');
    strNomCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_NOMCLI'], #39, '');
    strEndere := AnsiReplaceStr(cpuCampos['CADCLI->CLI_ENDERE'] +
    IIF(fEmptyStr(cpuCampos['CADCLI->CLI_ENDNUM']),'', ', ' + cpuCampos['CADCLI->CLI_ENDNUM']) + ' ' +
                                                              cpuCampos['CADCLI->CLI_ENDCOM'], #39, '');

    strBaiCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_BAIRRO'], #39, '');
    strNumCep := AnsiReplaceStr(cpuCampos['CADCLI->CLI_C_E_P_'], #39, '');
    strNomCid := AnsiReplaceStr(cpuCampos['CADCLI->CID_NOMCID'], #39, '');
    strEstado := AnsiReplaceStr(cpuCampos['CADCLI->CID_ESTADO'], #39, '');
    strCodCli := AnsiReplaceStr(cpuCampos['CADCLI->CLI_CODCLI'], #39, '');

    strTipSac := IIF(Length(strCliCgc) > 11, '01', '02');
    strPerMor := fPadL(FloatToStr(fFormataFloat(fltPerMor, 02) * 100), 14, '0');
    strValMor := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMor / 100.0, 02) * 100), 14, '0');

    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strDigCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCEDE', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCar := fStrZero( fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCART', '', strEmpresaCarteira, @LDuplicataBoleto), 2);

    If strReimpr = 'N' Then
      strNosNum := fStrZero(strNosNum, 10) + strNumDig
    Else
      strNosNum := fStrZero(strNosNum, 11);

    If strBraCrr = 'S' Then
    Begin
      strDesCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DESCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEndCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ENDCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCompCed := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'COMCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strBaiCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'BAICORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strCidCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CIDCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      strEstCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'ESTCORR', '', strEmpresaCarteira, @LDuplicataBoleto);
      intIndCar  := StrToInt(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'INDCART', '', strEmpresaCarteira, @LDuplicataBoleto));
      strCepCed  := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CEPCORR', '', strEmpresaCarteira, @LDuplicataBoleto));
      strCgcCed  := fTiraCaracEspeciais(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CGCCORR', '', strEmpresaCarteira, @LDuplicataBoleto), True, True, True);
      strUsoBco  := '';

      strNosNum := fCalcNossoNumero('237', LeftStr(strNosNum,11), '237', intIndCar, VS_strCodEmp);
      strNumDig := fCalcDigito('237', strNosNum, '237', intIndCar, VS_strCodEmp);
      strNosNum := strNosNum + strNumDig;
      strCodCed := RightStr(strCodCed, 8);
    End;


    if strExibMsg <> 'N' then
    begin
      If (strEspDoc = 'AG') And (fCfgSis('MDBLAG', varInteger) = 1) Then
      Begin

        If fEmptyStr(strObsAg2) And fEmptyStr(strObsAg3) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr5 := strObsAg1;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And fEmptyStr(strObsAg3) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr4 := strObsAg1;
          strInstr5 := strObsAg2;
        End
        Else If ( Not( fEmptyStr(strObsAg2) ) And Not( fEmptyStr(strObsAg3) ) ) Then
        Begin
          strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
          strInstr3 := strObsAg1;
          strInstr4 := strObsAg2;
          strInstr5 := strObsAg3;
        End;

      End
      Else
      Begin
        strInstr3 := fImprimeObs(3,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV3', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr4 := fImprimeObs(4,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV4', '', strEmpresaCarteira, @LDuplicataBoleto), 60));
        strInstr5 := fImprimeObs(5,fPadR(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'OBSERV5', '', strEmpresaCarteira, @LDuplicataBoleto), 60));

        pImprimirNroDocHistConfig();
      End;
    end;
    If strNumBco = '136' Then
    Begin
      strNomEmp := IIF(fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '', strEmpresaCarteira, @LDuplicataBoleto)),strNomEmp,
                                 fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NOMBENE', '', strEmpresaCarteira, @LDuplicataBoleto));
    End;
    ImprimirObservacaoCompletaAG;
  End
  {*********************}
  {* BANCO DA AMAZONIA *}
  {******************JU*}
  Else If (strNumBco = '003') Then
  Begin
    strDigAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodAgen := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODAGEN', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodCed  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto) +
                  fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'DIGCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCodConv := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'CODCONV', '', strEmpresaCarteira, @LDuplicataBoleto);
    strCntCor  := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'NUMCTAC', '', strEmpresaCarteira, @LDuplicataBoleto);

    strNosNum  := fPadL(strNosNum, 12, '0');
  End;

  {****************************************************}
  {* PEGA O PERCENTUAL DE MULTA CONFIGURADO NO AUTBAN *}
  {*************************************************JC*}
  fltPerMul := IIF(fltMulta>0,fltMulta,fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '0', strEmpresaCarteira, @LDuplicataBoleto)));

  If AReimprimirBoletoOriginal Then
  Begin
    fltPerMul := fStrToFloat(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'PERMULT', '0', strEmpresaCarteira, @LDuplicataBoleto));
  End;

  {********************************************************}
  {* CALCULA O VALOR DA MULTA QUE SERA IMPRESSO NO BOLETO *}
  {*****************************************************JC*}
  strValMul := fPadL(FloatToStr(fFormataFloat(fltValTit * fltPerMul / 100.0, 02) * 100), 14, '0');

  strPerMul := fPadL(FloatToStr(fFormataFloat(fltPerMul, 02) * 100), 14, '0');

  {**********************************************************}
  {* PREENCHE INSTR05 COM MSG DE DESCONTO SE CTR_DESSUJ > 0 *}
  {*******************************************************IV*}
  strDesSuj := AnsiReplaceStr(cpuCampos['CADREC->CTR_DESSUJ'], '.', ',');
  If (fEmptyStr(strDesSuj)) Then
    strDesSuj := '0';
  fltDesSuj := fFormataFloat(fStrToFloat(strDesSuj), 02);

  If LValorDoTituloComDescontoSugerido Then
    fltDesSuj := 0.00;

  If fltDesSuj > 0 Then
  Begin
    strDesSuj := 'CONCEDER DESCONTO DE R$' + FloatToStrF(fltDesSuj, ffFixed, 12, 2) + ' SE PAGO ATE O VENCIMENTO.';

    If fEmptyStr(strInstr5) Then
      strInstr5 := strDesSuj
    Else If fEmptyStr(strInstr4) Then
      strInstr4 := strDesSuj
    Else If fEmptyStr(strInstr3) Then
      strInstr3 := strDesSuj
    Else
    Begin
      strInstr5 := strInstr4;
      strInstr4 := strInstr3;
      strInstr3 := strDesSuj;
    End;

  End;
  {**********************************************************}

  strCliCgc := fTiraCaracEspeciais(strCliCgc);
  strCgcEmp := fTiraCaracEspeciais(strCgcEmp);

  {********************************************}
  {* IMPRIMIR PARCELA "A" PARA VENDAS A VISTA *}
  {****************************REQ. 133539**AJ*}
  strImprimeParcelaA := 'S';
  If (cpuCampos['CADCLI->CLI_BOLPAR'] = QuotedStr('N')) And
     ((cpuCampos['CADREC->CTR_PARCEL'] = QuotedStr('A')) Or
      (cpuCampos['CADREC->CTR_PARCEL'] = QuotedStr('001'))) Then
  Begin
    qryQtdeParcelas := fCriarQuery('SELECT COUNT(CTR_PARCEL) AS PARCELAS FROM ( ' +
                                   ' SELECT CTR_PARCEL FROM CADREC              ' +
                                   ' WHERE CTR_NUMDUP=' + cpuCampos['CADREC->CTR_NUMDUP'] +
                                   '   AND CTR_ESPDOC=' + cpuCampos['CADREC->CTR_ESPDOC'] +
                                   '   AND CTR_CODEMP=' + cpuCampos['CADREC->CTR_CODEMP'] +
                                   '   AND CTR_CODCLI=' + cpuCampos['CADREC->CTR_CODCLI'] +
                                   '   AND CTR_SEQBAI=0                         ' +
                                   'UNION ALL                                   ' +
                                   ' SELECT CTR_PARCEL FROM DUPAGR              ' +
                                   ' WHERE CTR_NUMDUP=' + cpuCampos['CADREC->CTR_NUMDUP'] +
                                   '   AND CTR_ESPDOC=' + cpuCampos['CADREC->CTR_ESPDOC'] +
                                   '   AND CTR_CODEMP=' + cpuCampos['CADREC->CTR_CODEMP'] +
                                   '   AND CTR_CODCLI=' + cpuCampos['CADREC->CTR_CODCLI'] +
                                   '   AND CTR_SEQBAI=0                         ' +
                                   ' ) AS TMP                                   ');

    qryQtdeParcelas.Open;
    If qryQtdeParcelas.FieldByName('PARCELAS').AsInteger = 1 Then
      strImprimeParcelaA := 'N';

    FreeAndNil(qryQtdeParcelas);
  End;

  If Not fEmptyStr(strMsgProrrogacao) And (fCfgSis('SELOBS', varBoolean, VS_strCodEmp)) Then
    pPreencherInstrucaoVazia(strMsgProrrogacao);

  strLinha := fPadR(strNumBco,    003, '0')                     + // (01) Identificação do Banco
              strTipEmp                                         + // (02) Tipo de Inscrição da empresa(01 - CGC / 02 - CNPJ)
              fPadR(strCgcEmp,    014)                          + // (03) Numero de inscrição da empresa
              fPadR(strNomEmp,    060)                          + // (04) Nome do cedente
              fPadR(strCodAgen,   004)                          + // (05) Numero da Agencia
              fPadR(strCodCed,    020)                          + // (06) Codigo do cedente
              fPadR(strNosNum,    015)                          + // (07) Nosso numero
              fPadR(strNumDup,    015)                          + // (08) Numero do documento
              fPadR(strEspDoc,    007)                          + // (09) Espécie do documento
              FormatDateTime('ddmmyyyy', StrToDate(strDtaVen))  + // (10) Data de vencimento
              strValTit                                         + // (11) Valor nominal do título
              strDesCob                                         + // (12) Valor desconto
              fPadR(strCodCar,    003)                          + // (13) código da carteira
              fPadR('R$',         004)                          + // (14) espécie do título
         {'N'}fPadR(strProAce,    001)                          + // (15) Identificação de aceite (A)ceito (N)ão aceito
              FormatDateTime('ddmmyyyy', StrToDate(strDtaCad))  + // (16) Data de emissao
              FormatDateTime('ddmmyyyy', VS_Date)               + // (17) Data processamento
              strValMor                                         + // (18) Mora diaria
              strTipSac                                         + // (19) Tipo de Inscrição do sacado (01 - CGC / 02 - CPF)
              fPadR(strCliCgc,    014)                          + // (20) Numero de inscrição do sacado
              fPadR(strNomCli,    040)                          + // (21) Nome do sacado
              fPadR(strEndere,    140)                          + // (22) Endereço do sacado
              fPadR(strBaiCli,    060)                          + // (23) Bairro do sacado
              fPadR(strNumCep,    008)                          + // (24) CEP do sacado
              fPadR(strNomCid,    040)                          + // (25) Cidade do Sacado
              fPadR(strEstado,    002)                          + // (26) UF do sacado
              fPadR(VS_strRazSoc, 040)                          + // (27) Nome do sacador avalista
              fPadR(strDiaProt,   002)                          + // (28) Prazo para protesto
              fPadL('',           060)                          + // (29) Local de pagamento
              fPadL(strUsoBan,    010)                          + // (30) Uso do banco
              fPadL(strInstr1,    060)                          + // (31) Instrução 1
              fPadL(strInstr2,    060)                          + // (32) Instrução 2
              fPadL(strInstr3,    060)                          + // (33) Instrução 3
              fPadL(strInstr4,    060)                          + // (34) Instrução 4
              fPadL(strInstr5,    060)                          + // (35) Instrução 5
              fPadL(strCodConv,   007)                          + // (36) Código Convenio (Banco Brasil)
              fPadR(strDigAgen,   001)                          + // (37) Digito agencia
              fPadR(strCodCli,    008)                          + // (38) Código do cliente no CADREC
              fPadR(strModali,    004)                          + // (39) Modalidade de cobrança
              fPadR(strPerMor,    014)                          + // (40) Percentual de Mora Diaria
              fPadR(strProAce,    001)                          + // (41) Imprime protocolo de aceite
              fPadR(strDigAgen,   002)                          + // (42) Digito agencia (2 CARACTERES)
              fPadR(strCodCar,    004)                          + // (43) Carteira (4 CARACTERES)
              fPadR(strVariacao,  003)                          + // (44) Variacao
              fPadR(strDescon,    014)                          + // (45) Desconto (Banco do Brasil 7 digitos)
              fPadR(strEndEmp,    160)                          + // (46) Endereço completo do cedente
              fPadR(strIdeCed,    006)                          + // (47) Identificação do cedente
              fPadR(strUsoCli,    017)                          + // (48) Uso do cliente
              fPadR(strDigCed,    002)                          + // (49) Digito do Cedente
              fPadR(strTipDia,    001)                          + // (50) Tipo de dias para protesto
              fPadR(strValMul,    014)                          + // (51) Valor da multa
              fPadL(strOutAcr,    014)                          + // (52) Outros Acrescimos
              fPadR(strSisCob,    005)                          + // (53) COBRANÇA CEF (SICOB, SIGCB OU SINCO)
              fPadR(strBB_Crr,    001)                          + // (54) Para Bancoob - se usa Banco do Brasil como correspondente
              fPadR(strConCrr,    010)                          + // (55) Convênio Correspondente - Para Bancoob 240 com Banco do Brasil como correspondente
              fPadR(strCobReg,    001)                          + // (56) Cobrança Registrada S/N
              fPadR(strSacAva,	  040)						              + //(57) Sacador / Avalista
              strTpIden                                         + //(58) TIPO IDENTIFICADOR, COBRANÇA SEM REGISTRO, HSBC;
              fPadR(IIF(Not fEmptyStr(strBraCrr),strBraCrr,' '),001)+ // (59) Para Bancos Safra/Unicred - se usa Bradesco como correspondente
              fPadR(strDesCed,   040)                           + //(60) Nome da agência do Unicred correspondente
              fPadR(strEndCed,   040)                           + //(61) Endereço da agência do Unicred correspondente
              fPadR(strCompCed,  040)                           + //(62) Complemento da agência do Unicred correspondente
              fPadR(strBaiCed,   040)                           + //(63) Bairro da agência do Unicred correspondente
              fPadR(strCidCed,   040)                           + //(64) Cidade da agência do Unicred correspondente
              fPadR(strEstCed,   002)                           + //(65) Estado da agência do Unicred correspondente
              fPadR(strCepCed,   008)                           + //(66) CEP da agência do Unicred correspondente
              fPadR(strCgcCed,   014)                           + //(67) CNPJ da agência do Unicred correspondente
              fPadR(strUsoBco,   006)                           + //(68) SE FOR SAFRA CORRESPONDENTE DEVE IR "CIP130", DEMAIS BANCOS DEVE IR EM BRANCO
              fPadL(strCodInstr1, 002, '0')                     + //(68) Código da primeira instrução
              fPadL(strCodInstr2, 002, '0')                     + //(69) Código da segunda instrução
              fPadL(strCodEmp,   003, '0')                      + //(70) Código da empresa na CADREC
              fPadR(strMailCli,  255)                           + //(71) Email do cliente
              fPadR(strBcoIni,   003)                           + //(72) Banco Inicial
              fPadR(strBenefi,   080)                           + //(73) Sacador/Avalista
              fPadR(strEndBen,   180)                           + //(74) Endereço Sacador/Avalista
              fPadR(strChaveBRB, 040)                           + //(75) Chave Banco BRB
              fPadR(strConRem,   020)                           + //(76) Sequencial que substitui a nossa chave para o banco BRB
              fPadR(strPerMul,   014)                           + //(77) Percentual da Multa
              fPadR(strInstr3,   120)                           + //(78) Instrução 3 Extendida
              fPadR(strInstr4,   120)                           + //(79) Instrução 4 Extendida
              fPadR(strInstr5,   120)                           + //(80) Instrução 5 Extendida
              fPadR(strImpAgBenef, 001)                         + //(81) Imprime Agência com Beneficiário
              fPadR(strRazaoSocialCooperativa, 060)             + //(82) Razão Social da Cooperativa
              fPadR(strIncrisaoCooperativa, 019)                + //(83) Inscrição da Cooperativa
              fPadR(strEnderecoCoopetativa, 060)                + //(84) Endereço da Cooperativa
              fPadR(strBairroCooperativa, 040)                  + //(85) Bairro da Cooperativa
              fPadR(strCidadeCooperativa, 040)                  + //(86) Cidade da Cooperativa
              fPadR(strEstadoCooperativa, 002)                  + //(87) Estavo da Cooperativa
              fPadR(strCEPCooperativa, 009)                     + //(88) CEP da Cooperativa
              fPadR(strCodProt, 001)                            + //(89) Código de Protesto (Apenas para Sicoob por enquanto)
              fPadR(strImprimeParcelaA, 001)                    + //(90) Imprimir parcela A
              fPadR(strEspDocOriginal,    005)                  + //(91) Especie Documento Padrao pelo AutCom
              fPadR(strNumDocumentoSemParcela, 012)             + //(92) Numero do documento sem parcela
              fPadR(strParcelaDoDocumento, 003)                 + //(93) Numero do documento sem parcela
              fPadR(ADiasCartorio,   002)                       + //(94) Prazo para Cartório
              fPadR(strParNum,    001)                          + //(95) Utilizar Parcela Numeral? (A = 001) REQ:158267 --> MT
              fPadR(strInTr5D,001)                              + //(96) Destaca em negrito a observacao 5 req: 159365
              fPadL(strInfAdi,   007,'0')                       + //(97) Informação Adicional (Carteira)
              fPadL(strCedenteInter,   009,'0')                 + //(98) Código do Cedente do banco Inter
              fPadR(strInstrucaoBancoInter1,   078)             + //(99) Linha1 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter2,   078)             + //(100) Linha2 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter3,   078)             + //(101) Linha3 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter4,   078)             + //(102) Linha4 da mensagem do banco Inter
              fPadR(strInstrucaoBancoInter5,   078)             + //(103) Linha5 da mensagem do banco Inter
              fPadL(strNroOpe,   007,'0')                       + //(104) Numero da operacao banco 246;
              fPadR(strObsAg1,                 120)             + //(105) Duplicatas Agrupadas Parte 1
              fPadR(strObsAg2,                 120)             + //(106) Duplicatas Agrupadas Parte 2
              fPadR(strObsAg3,                 120)             + //(107) Duplicatas Agrupadas Parte 3
              fPadR(LObsCompletaAG,            001)             + //(108) Observacao Completa AG
              fPadR(LCarteira,                 020)             + //(109) Identificação Banco
              fPadL(FApresentarEspDocumento,   001, 'N')        + //(110) Apresentar Esp. Documento no Boleto
              fPadL(strDiaMora,                010)             + //(111) a partir de qtos dias cobrar mora
              fPadL(strNumOperacao,            020)             + //(112) Numero de operação
              fPadL(strBcoIni,                 020)             + //(113) banco inicial completo
              fPadL(LQRCode,                   390)             + //(111) QRCODE
              fPadR(LParcelasNegritoCarne,     001)             + //(112) Destaca as parcelas em negrito em boletos com layout carnê
              fPadR(strCodCartBoleto,           03);              //(116) codigo da carteira do boleto no banco);


  pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed);

  If Not fCfgSis('IMPBOD', varBoolean) Then
  Begin
    If fEmptyStr(strOpcFil) Then
      strPathBol := fCfgSis('PATLAS')
    Else
      strPathBol := strOpcFil;

    AssignFile(txtArqTxt, strPathBol + '\' + strNumBco + fSeqLaser + '.txt');
    Rewrite(txtArqTxt);
    WriteLn(txtArqTxt, strLinha);
    Flush(txtArqTxt);
    CloseFile(txtArqTxt);

    Result := True;
  End
  Else
  Begin
    Result := fProcessarArquivo(strLinha,
                                blnBolPdf,
                                ABoletoCarneBuilder,
                                ABoleto1ViaBuilder,
                                strNomeForm,
                                strNomeFila,
                                blnForcarImp,
                                blnEnvioDeEMailAutomatico);

    strArqBoletos := strArqBoletos + ExtractFilePath(Application.ExeName) + 'Boletos\' + strNumDup + '.pdf,';
  End;

end;

procedure pPesquisaCadEmp(qryTabOri, qryTabela: TUniQuery; strCodEmp: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

  With qryTabela Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
  End;
  If Assigned(qryTabOri) Then
    pAtribuiDisplayLabels(qryTabOri, qryTabela);
end;

procedure pAtualizaDuplicataCodCedente(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodCed: String);
Var
 qryUpdate : TUniQuery;
begin
  qryUpdate := fCriaQuery;

  with qryUpdate do
  begin
    Sql.Clear;

    Sql.Text := ' UPDATE   ' +
                '   CADREC ' +
                ' SET      ' +
                '   CTR_CODCED = :CODCED ' +
                ' WHERE    ' +
                '   CTR_NUMDUP = :NUMDUP AND ' +
                '   CTR_PARCEL = :PARCEL AND ' +
                '   CTR_ESPDOC = :ESPDOC AND ' +
                '   CTR_CODEMP = :CODEMP AND ' +
                '   CTR_CODCLI = :CODCLI ';

    ParamByName('NUMDUP').AsString := Copy(strNumDup, 1, Length(Trim(strNumDup))-1);
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;


    ParamByName('CODCED').AsString := strCodCed;

    ExecSQL;

  end;

  qryUpdate.Free;


end;

function fSeqLaser: String;
  Var
    strSequen: String;
Begin

  fStartTransaction;

  Try

    If fEmptyStr( fCfgSisL('SEQLAS') ) Then
      strSequen := '000001'
    Else
      strSequen := fStrZero(VarToStr(fCfgSisL('SEQLAS')), 6);

    Result := strSequen;

    fAtuCfgSis('SEQLAS', fStrZero(IntToStr(StrToIntDef(strSequen, 0) + 1),6));
    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise;
    End;
  End;

end;

procedure pAtribuiDisplayLabels(qryTabOri, qryTabDest: TUniQuery);
  Var
    intContador: Integer;
    strNomeCampo: String;
begin

  If (Not Assigned(qryTabOri)) Or (Not Assigned(qryTabDest)) Then
    Exit;

  For intContador := 0 To qryTabDest.FieldCount -1 Do
  Begin
    strNomeCampo := qryTabDest.Fields[intContador].FieldName;

    If (qryTabOri.FindField(strNomeCampo) <> Nil) Then
    Begin
      qryTabDest.FieldByName(strNomeCampo).Visible := qryTabOri.FieldByName(strNomeCampo).Visible;
      qryTabDest.FieldByName(strNomeCampo).DisplayLabel := qryTabOri.FieldByName(strNomeCampo).DisplayLabel;
    End;

  End;
end;

function fDisparaEmailBoletoAutomatico(objDados : TDadosDisparaEmail;
                                       strOpcDoc: String = 'BO';
                                       objStatus: TStatusDisparaEmail = untTypesSistema.staNenhumaAcao;
                                       blnEnvioAutomaticoCobranca: Boolean = False): Boolean;
Var
  objEmaAut : TEmaAut;
Begin

  Result := False;

  Try
    objEmaAut := TEmaAut.Create(Nil);
    objEmaAut.FOpcDoc := strOpcDoc;
    objEmaAut.FStatus := objStatus;

    If (objEmaAut.fTemEmailAtivo) Then
    Begin
      objEmaAut.FNomCli := fRetNomCliente(objDados.strCodCli);
      objEmaAut.FCodCli := objDados.strCodCli;
      objEmaAut.FPriCli := fRetPrimeiraPalavra(objEmaAut.FNomCli);
      objEmaAut.FCidCli := fRetNomCidade(fRetCodCidByCliente(objDados.strCodCli));
      objEmaAut.FTransp := '';
      objEmaAut.FCodOpe := strLoginUsuarioLogado;
      objEmaAut.FNumDoc := objDados.strNumDoc;
      objEmaAut.FEspDoc := objDados.strEspDoc;
      objEmaAut.FEmpDoc := objDados.strCodEmp;
      objEmaAut.FNumOrc := objDados.strNumOrc;
      objEmaAut.FEspOrc := objDados.strEspOrc;
      objEmaAut.FEmpOri := objDados.strEmpOri;
      objEmaAut.FEmaCli := objDados.strEmailCli;
      objEmaAut.FArquiv := objDados.RecArquivos;
      objEmaAut.strLinDig := objDados.strLinhaDigitavel;
      objEmaAut.strDtaEmi := objDados.strDtaEmi;
      objEmaAut.strValDup := objDados.strValDup;
      objEmaAut.strParcel := objDados.strParcel;
      objEmaAut.strDtaVen := objDados.strDtaVen;
      objEmaAut.strLnkPag := objDados.strLnkPag;
      objEmaAut.strCorpoAdicional := objDados.strCorpoAdicional;
      objEmaAut.CorpoEmailFixo :=  objDados.CorpoEmailFixo;
      objEmaAut.FEnvAutCob:= blnEnvioAutomaticoCobranca;
      objEmaAut.FArrDup   := objDados.arrDupTabela;

      objEmaAut.DiasVencimento := objDados.DiasVencimento;

      If Not objDados.QRCodePix.Trim.IsEmpty Then
      Begin
        objEmaAut.QrCodePix := 'Pagamento por Pix:<br>' +
                               '<img src="' + RetornaLinkImagemPixCitel(objDados.QRCodePix) + '"><br>';

        If Not objDados.LinkCitelPix.IsEmpty Then
        Begin
          objDados.LinkCitelPix := 'https://pix.citelsoftware.com.br/' + objDados.LinkCitelPix;
          objEmaAut.QrCodePix := objEmaAut.QrCodePix + '<p>Link para Pix Copia e Cola: <a href="' + objDados.LinkCitelPix + '">' + objDados.LinkCitelPix + '</a></p>';
        End;

        objEmaAut.QrCodePix := objEmaAut.QrCodePix +  '<p>Para pagamento através do código (Pix Copia e Cola): <br>' +
                                                      '<textarea readonly style="text-decoration: underline; resize: none;" rows="4" cols="' + Trunc((objDados.QRCodePix.Length + 3) / 3).ToString + '">' + objDados.QRCodePix + '</textarea></p>';
      End;

      If strOpcDoc = 'AC' Then
        Result := objEmaAut.fEnviaEmailAutomatico
      Else
      Begin
        objEmaAut.fEnviaEmailAutomatico;
        Result := True;
      End;
    End;
  Finally
    FreeAndNil(objEmaAut);
  End;
End;

function fRetCodCidByCliente(strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
End;

function fDisparaWhatsappBoletoAutomatico(objDados: TDadosDisparaSMS;
                                          strOpcDoc: String = 'BO';
                                          objStatus: TStatusDisparaEmail = staNenhumaAcao): Boolean;
begin
  Result := False;

  if fCfgSis('UTIWPP', varBoolean) then
    Result := fDisparaSMSBoletoAutomatico(objDados,
                                          strOpcDoc,
                                          objStatus,
                                          True);
end;

function fDisparaSMSBoletoAutomatico(objDados: TDadosDisparaSMS;
                                     strOpcDoc: String = 'BO';
                                     objStatus: TStatusDisparaEmail = staNenhumaAcao;
                                     blnEnviaWhatsapp: Boolean = False): Boolean;
Var
  objSmsAut : TSMSAut;
Begin
  Result := False;

  Try
    objSmsAut := TSMSAut.Create(Nil);
    objSmsAut.FOpcDoc := strOpcDoc;
    objSmsAut.FStatus := objStatus;
    objSmsAut.FWhatsapp := blnEnviaWhatsapp;

    If (objSmsAut.fTemModeloAtivo) Then
    Begin
      objSmsAut.FNomCli := fRetNomCliente(objDados.strCodCli);
      objSmsAut.FPriCli := fRetPrimeiraPalavra(objSmsAut.FNomCli);
      objSmsAut.FCidCli := fRetNomCidade(fRetCodCidByCliente(objDados.strCodCli));
      objSmsAut.FTransp := '';
      objSmsAut.FNumDoc := RetornaValorSemZerosEsquerdaSMS(objDados.strNumDoc);
      objSmsAut.FEspDoc := objDados.strEspDoc;
      objSmsAut.FEmpDoc := objDados.strCodEmp;
      objSmsAut.FNumOrc := RetornaValorSemZerosEsquerdaSMS(objDados.strNumOrc);
      objSmsAut.FEspOrc := objDados.strEspOrc;
      objSmsAut.FEmpOri := objDados.strEmpOri;
      objSmsAut.FTo     := objDados.strCelula;
      objSmsAut.FLinDig := objDados.strLinhaDigitavel;
      objSmsAut.FEmaCob := objDados.strEmaCob;
      objSmsAut.FDtaEmi := objDados.strDtaEmi;
      objSmsAut.FValDup := objDados.strValDup;
      objSmsAut.FParcel := objDados.strParcel;
      objSmsAut.FDtaVen := objDados.strDtaVen;
      objSmsAut.FQrCodePix := Trim(objDados.QRCodePix);
      objSmsAut.FLnkPag := objDados.strLnkPag;
      objSmsAut.DiasVencimento := objDados.DiasVencimento;

      If Not objSmsAut.FQrCodePix.IsEmpty Then
        objSmsAut.FQrCodePix := 'https://pix.citelsoftware.com.br/' + objSmsAut.FQrCodePix;

      objSmsAut.FLinkDoBoleto := objDados.strLinkDoBoleto;
      objSmsAut.FArquiv := objDados.RecArquivos;

      Result := objSmsAut.fEnviaSMSAutomatico
    End;
  Finally
    FreeAndNil(objSmsAut);
  End;
End;

function RetornaValorSemZerosEsquerdaSMS(AValor: String): String;
  Var
    LInteiro: Int64;
Begin
  Result := AValor;

  If TryStrToInt64(Result, LInteiro) Then
    Result := IntToStr(LInteiro);
End;

function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
  strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;
  Var
    nodRec: IXMLNode;
    forSet: TFormatSettings;
    strData: String;
Begin
  With nodNo Do
  Begin
    forSet.ShortDateFormat := strDateFormat;
    forSet.DateSeparator   := chrDateSeparator;

    nodRec := ChildNodes.FindNode(strNome);

    If Assigned(nodRec) Then
    Begin

      Try
        Case varTipVar Of

          varDate  :  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0

                        Else If blnDateTime Then
                        Begin
                          strData := LeftStr(nodRec.NodeValue, 10);
                          Result  := StrToDate(strData, forSet);
                        End Else
                        Begin
                          Try
                            Result  := StrToDate(nodRec.NodeValue, forSet);
                          Except
                            Result  := 0;
                          End;
                        End;

                      End;

          varString:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := ''
                        Else
                          Result := nodRec.NodeValue;
                      End;

          varDouble:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(nodRec.NodeValue,'.',','));
                      End;

          varInteger: Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := nodRec.NodeValue;
                      End;

        End;
      Except
        Raise Exception.Create('Erro ao ler valor ' + strNome);
      End;

    End Else
    Begin
      Case varTipVar Of
        varDate:     Result := 0;
        varString:   Result := '';
        varDouble:   Result := 0;
        varInteger:  Result := 0;
      End;
    End;

  End;
End;

function RetornaLinkImagemPixCitel(ATextoQRCode: String; ATamanho: Integer = 150): String;
Begin
  Result := EmptyStr;

  If ATamanho <= 0 Then
    ATamanho := 150;

  If Not ATextoQRCode.IsEmpty Then
    Result := 'https://pix.citelsoftware.com.br/qrcode?size=' + ATamanho.ToString +
              '&text=' + ATextoQRCode;
End;

Function fRetEspDocBoleto(sCodEsp : String): String;
begin

  Try

    Result := 'DMI';

    If sCodEsp = '03' Then result := 'DMI'
    else
    If sCodEsp = '05' Then result := 'DSI'
    else
    If sCodEsp = '12' Then result := 'NP'
    else
    If sCodEsp = '17' Then result := 'RC'
    else
    If sCodEsp = '20' Then result := 'AP'
    else
    If sCodEsp = '05' Then result := 'DSI'

  Except

  End;

end;

end.
