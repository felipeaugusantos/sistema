unit untFonteDados;

interface

uses untInterfaces, SysUtils, StrUtils, classes, DB, DateUtils;

Type
  TSituacaoIPI = (sitTributado, sitIsento, sitNaoTributado, sitImune, sitSuspenso);

Type
  IFonteDadosFormatador = Interface(IInterface)
    procedure pSetaFonteDados(fonte: IFonteDados);
    function fTemDados: Boolean;
    function fFormataDadosEmitente: TDadosEmitente;
    function fFormataDadosGerais: TDadosGerais;
    function fFormataDadosItem: TDadosItem;
  End;

Type
  TFonteDadosFormatadorImpl = class(TInterfacedObject, IFonteDadosFormatador)
    procedure pSetaFonteDados(fonte: IFonteDados);
    function fTemDados: Boolean;
    function fFormataDadosEmitente: TDadosEmitente;
    function fFormataDadosGerais: TDadosGerais;
    function fFormataDadosItem: TDadosItem;
    function fTagDadosAdicionaisItem(const strTag : String; strConteudo : String) : String;
    function fRetornaMensagemAdicionalFiscal: String;
  private
    fonteDados: IFonteDados;
    function fImprimeSubTributariaDadosProprios(strForcaSubTributariaEmDadosProprios: String=''): Boolean;
    function fImprimeIPIDadosProprios: Boolean;
    function fNotaImportacao: Boolean;
    procedure pFormataDadosDestinatario;
    procedure pRetInformacoesAdicionaisNotImp;
    procedure pRetInformacoesAdicionais;
    procedure pRetInformacoesAdicionaisNotComp;
    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fStrToFloat(strValor: String): Double;
    function fItemCalculaReducaoBaseConfRICMPR(dadosItem: TDadosItem): Boolean;
    function fItemCalculaReducaoBaseConfRICMPRMsg(dadosItem: TDadosItem): Boolean;
    function fGeraCodBarraEAN13(strCodigo: String): String;
    function fValidaCodBar(strCodBar: String): Boolean;
    function fInformacoesMadeira(dadosItem: TDadosItem): String;
    procedure pCarregaChaveReferenciadaNotaComplemento(dadosGerais: TDadosGerais);
    procedure pCarregaChaveReferenciadaParaNotaExportacao(dadosGerais: TDadosGerais);
    procedure pPreencheTipoIntegracaoTEF;
    procedure pRecalculaIcmsParaEstadoDestino(dadosItem: TDadosItem);
    {$HINTS OFF} procedure pCarregaBaseReduzidaDestinoAbfIcm(dadosItem: TDadosItem); {$HINTS ON} //SEM FUNÇÃO, ENTRETANTO, MANTER POR QUESTÃO DE COMPATIBILIDADE REQ.: 74126
    function fFornecedoresTigre: String;
    procedure pSetarAnotacoesDadosItem(AValue: string; dadosItem: TDadosItem);
    procedure pAtualizaDescricaoDoItemNotComp;
    function fMostrarCondicaoPagamentoEmDadosAdicionais(const ADadosGerais : TDadosGerais; AblnCdpNfe, AblnInconsistenciaEFD_Gravar: Boolean; AstrCondPagamento, AstrClaFis: String): Boolean;
    function fDeveLimparEmailClienteConsumidor(const ADadosGerais : TDadosGerais): Boolean;
    function fClienteComIdentificacaoValida(const ADadosGerais : TDadosGerais): Boolean;
  End;

implementation

uses untUtil, untFuncoesLibNfe, untConstantesNFe, untValorPorExtenso, untDicSis;

{ TFonteDadosFormatadorImpl }

function TFonteDadosFormatadorImpl.fFormataDadosEmitente: TDadosEmitente;
begin
  Result := fonteDados.fDadosEmitente;

  Result.strCnpj := fLimpaCaracteres(Result.strCnpj);

  If fEmptyStr(Result.strFantasia) Then
    Result.strFantasia := Result.strRazao;

  Result.strCep := fLimpaCaracteres(Result.strCep);
  Result.strTelefone := fLimpaCaracteresTelefone(Result.strTelefone);
  Result.strIES := fLimpaCaracteres(Result.strIES);
  Result.strIESST := fLimpaCaracteres(Result.strIESST);

  If (Result.strEstado = 'EX') Then
  Begin
    Result.strCnpj := '';
    Result.strIES := '';
    Result.strIESST := '';
  End;

  If Assigned(fonteDados.fDadosGerais) Then
  Begin
    If fonteDados.fDadosGerais.fltTotSer <= 0 Then
    Begin
      Result.strInscricaoMunicipal := '';
      Result.strCNAEFiscal := '';
    End;
  End;
end;

function TFonteDadosFormatadorImpl.fFormataDadosGerais: TDadosGerais;
  Var
    intContador: Integer;
    fltDiferimentoProdST: Double;
    dataSet: TDataSet;
    strForcaSubTributariaEmDadosPropriosLocal: String;

  function fPossuiItensComReducaoBaseRICMPR: Boolean;
  begin
    Result := False;
    fonteDados.pInicio;

    While fonteDados.fTemDados Do
    Begin
      Result := fItemCalculaReducaoBaseConfRICMPR(fonteDados.fProximoItem);
      If Result Then
        Break;
    End;
  end;

  procedure pCalculaBaseIcmConfRICMPR;
    var
      dadosItem: TDadosItem;
  begin
    Result.fltBasIcm := 0.00;

    fonteDados.pInicio;

    While fonteDados.fTemDados Do
    Begin
      dadosItem := fonteDados.fProximoItem;

      If Not fItemCalculaReducaoBaseConfRICMPR(dadosItem) Then
        Result.fltBasIcm := Result.fltBasIcm + dadosItem.fltBasIcm
      Else
        Result.fltBasIcm := Result.fltBasIcm + (dadosItem.fltTotIte - dadosItem.fltDesEsp);
    End;

  end;

  function fCalculaDiferimentoProdST: Double;
    Var
      dadosItem: TDadosItem;

      function fPercentualDeReducaoDaBaseDeCalculoDoIcms: Double;
         Var 
           fltAlqRed: Double ;
      begin  
        fltAlqRed := CONST_PERCENTUAL_DIFERIMENTO_RICMS;
        If dadosItem.fltPerRed > 0 Then
          fltAlqRed := dadosItem.fltPerRed;
        
        Result := ((100 - fltAlqRed) / 100);
      end;
      
  begin
    Result := 0;
    fonteDados.pInicio;

    While (fonteDados.fTemDados) Do
    Begin
      dadosItem := fonteDados.fProximoItem;

      If fItemCalculaReducaoBaseConfRICMPRMsg(dadosItem) Then
      Begin
        Result := Result + (fFormataFloat(dadosItem.fltValIcm / fPercentualDeReducaoDaBaseDeCalculoDoIcms, 2) - dadosItem.fltValIcm);
      End;
    End;
  end;

  procedure pTentaCarregarIesUniCasoNecessario;
  begin
    If Not fSuportaOperacaoBanco(fonteDados) Then
    Begin
      Exit;
    End;

    Try
      If (Not fEmptyStr(Result.strCodCli)) And (fEmptyStr(Result.strIesUni)) And (fonteDados.fCampoExiste('CADCLI', 'CLI_IESUNI')) Then
      Begin
        If (fEmptyStr(Result.strNomCli + Result.strClaFis + Result.strLogradouro)) Then
        Begin
          //ESTÁ PROCESSANDO RETORNO DO ENVIO, ENTÃO, NÃO PRECISA DA INFORMAÇÃO ABAIXO
          Exit;
        End;

        dataSet := fonteDados.fExecutaQuery('SELECT CLI_IESUNI FROM CADCLI WHERE CLI_CODCLI = :CODCLI', ['CODCLI'], [Result.strCodCli]);
        Try
          Result.strIesUni := dataSet.FieldByName('CLI_IESUNI').AsString;
        Finally
          FreeAndNil(dataSet);
        End;
      End;
    Except
      //
    End;
  end;

  function fTemItemTigre: Boolean;
    Var
      strFornecedores: String;
  begin
    Result := False;

    strFornecedores := fFornecedoresTigre;

    fonteDados.pInicio;
    While fonteDados.fTemDados Do
    Begin
      If Pos(fonteDados.fProximoItem.strForIte, strFornecedores) > 0 Then
      Begin
        Result := True;
        Break;
      End;
    End;
  end;

  function fExisteRegistroTabela(arrNomeTabela: Array Of String;
    arrParametros: Array Of String; arrValores: Array Of Variant): Boolean;
    Var
      intIndTab,
      intIndPar: Integer;
      strSQL  : String;
      qryAux  : TDataSet;
  begin
    Result := False;

    intIndTab := 0;

    While (intIndTab <= High(arrNomeTabela)) Do
    Begin
      If fonteDados.fTabelaExiste(arrNomeTabela[intIndTab]) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + arrNomeTabela[intIndTab];
        strSQL := strSQL + ' WHERE ';

        intIndPar := 0;

        While (intIndPar <= High(arrParametros)) Do
        Begin
          strSQL := strSQL + arrParametros[intIndPar] + ' = :' + arrParametros[intIndPar] + IIF(intIndPar = High(arrParametros), ' ', ' AND ');
          Inc(intIndPar);
        End;

        qryAux := fonteDados.fExecutaQuery(strSQL, arrParametros, arrValores);

        With qryAux Do
        Begin
          If Not IsEmpty Then
            Result := FieldByName('QTD').AsInteger > 0;
        End;

        FreeAndNil(qryAux);
      End;

      If Result Then
        Break;

      Inc(intIndTab);
    End;
  end;

  function fCalculaTotalFCPST: Double;
    Var
      dadosItem: TDadosItem;
      blnExisteMovIcd: Boolean;
      blnTemRegistroNaMovIcd : Boolean;
      blnForcaSubTributariaEmDadosPropriosLocal: Boolean;
  begin
    Result := 0;
    fonteDados.pInicio;

    blnExisteMovIcd := fonteDados.fTabelaExiste('MOVICD');
    blnForcaSubTributariaEmDadosPropriosLocal := False;

    While (fonteDados.fTemDados) Do
    Begin
      dadosItem := fonteDados.fProximoItem;

      strForcaSubTributariaEmDadosPropriosLocal := '';

      If fForcaSubTributariaEmDadosProprios(fonteDados.fDadosGerais.strOpcDoc, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST,
                                            fonteDados.fDadosGerais.blnInconsistenciaEFD_Gravar) Then
      Begin
        strForcaSubTributariaEmDadosPropriosLocal := 'S';
        blnForcaSubTributariaEmDadosPropriosLocal := True;
      End;

      If (Not blnForcaSubTributariaEmDadosPropriosLocal) And
         fForcaSubTributariaEmDadosPropriosRegraEspecial(fonteDados.fDadosGerais.strOpcDoc, fonteDados.fDadosGerais.strTip_FC, fonteDados.fDadosGerais.strClaFis,
                                                         dadosItem.strCodSit, objConfig.blnSimPau, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST) Then
      Begin
        strForcaSubTributariaEmDadosPropriosLocal := 'S';
        blnForcaSubTributariaEmDadosPropriosLocal := True;
      End;

      If (Not blnForcaSubTributariaEmDadosPropriosLocal) And
         fForcaSubTributariaEmDadosPropriosRegraBrinde(fonteDados.fDadosGerais.strClaFis, dadosItem.fltValRet, (fCfgSisFonte(fonteDados, 'BRI_ST') = 'S')) Then
      Begin
        strForcaSubTributariaEmDadosPropriosLocal := 'S';
        blnForcaSubTributariaEmDadosPropriosLocal := True;
      End;

      If Not fImprimeSubTributariaDadosProprios(strForcaSubTributariaEmDadosPropriosLocal) Then
      Begin
        blnTemRegistroNaMovIcd := False;
        If (blnExisteMovIcd) Then
          blnTemRegistroNaMovIcd := fExisteRegistroTabela(['MOVICD', 'NOTICD'], ['ICD_SEQGER'], [dadosItem.strAutInc]);

        If (blnTemRegistroNaMovIcd) And (Pos(fonteDados.fDadosGerais.strOpcDoc,'OF_NG_FE_') > 0) Then
          blnTemRegistroNaMovIcd := (dadosItem.fltValorFCP > 0) And (dadosItem.fltValorFCPST = 0);

        If (dadosItem.fltValRet > 0) And (IIF(blnTemRegistroNaMovIcd, dadosItem.fltValorFCP, dadosItem.fltValorFCPST) > 0) Then
          fonteDados.fDadosGerais.fltTotFcpST := fonteDados.fDadosGerais.fltTotFcpST + IIF(blnTemRegistroNaMovIcd, dadosItem.fltValorFCP, dadosItem.fltValorFCPST);
      End;
    End;

    If blnForcaSubTributariaEmDadosPropriosLocal Then
      strForcaSubTributariaEmDadosPropriosLocal := 'S';
  end;

  function fImprimeMensagemDadosIPI(DadosGerais : TDadosGerais) : Boolean;
  begin

    Result := True;

    If (Not DadosGerais.blnEstornoDeCredito) Then
      Exit;

    If (fCfgSisFonte(fonteDados, 'MENEST') <> 'N') Then
      Exit;

    Result := False;

  end;

begin
  Result := fonteDados.fDadosGerais;
  Result.strMsgAdicionalCom := '';
  Result.strMsgAdicionalFis := '';
  Result.strMsgAdicional    := '';
  pTentaCarregarIesUniCasoNecessario;
  strForcaSubTributariaEmDadosPropriosLocal := '';

  {*************************************}
  {* DADOS DO DESTINATARIO.            *}
  {**********************************MV*}
  pFormataDadosDestinatario;

  fonteDados.fDadosGerais.strCgcTra := fLimpaCaracteres(fonteDados.fDadosGerais.strCgcTra);
  fonteDados.fDadosGerais.strIesTra := fLimpaCaracteres(fonteDados.fDadosGerais.strIesTra);

  If (fNotaImportacao)                                   Or
     (RightStr(Result.strClaFis, 3) = '910')             Or
     (Pos(RightStr(Result.strClaFis, 3), CLAFIS_ENTFUT_VEN_ABR) > 0) Or
     (RightStr(Result.strClaFis, 3) = '923')             Or
     (RightStr(Result.strClaFis, 3) = '917')             Or
     (Not fonteDados.fDadosGerais.blnImprimirDuplicatas) Then
  Begin
    SetLength(Result.arrDuplicatas, 0);
  End;

  If Result.blnNfComp Then
  Begin
    pRetInformacoesAdicionaisNotComp;
    pAtualizaDescricaoDoItemNotComp;
  End
  Else
  Begin
    If fNotaImportacao Then
      pRetInformacoesAdicionaisNotImp
    Else
      pRetInformacoesAdicionais;
  End;

  {*************************************}
  {* VERIFICA QUAIS DUPLICATAS DEVEM   *}
  {* SER IMPRESSAS NA NOTA.            *}
  {**********************************MV*}
  For intContador := Low(fonteDados.fDadosGerais.arrDuplicatas) To High(fonteDados.fDadosGerais.arrDuplicatas) Do
  If Assigned(fonteDados.fDadosGerais.arrDuplicatas[intContador]) Then
  Begin
    If fonteDados.fDadosGerais.arrDuplicatas[intContador].fltValDup <= 0 Then
    Begin
      fonteDados.fDadosGerais.arrDuplicatas[intContador].dtaDtaVen := 0;
      fonteDados.fDadosGerais.arrDuplicatas[intContador].strNumDup := '';
      fonteDados.fDadosGerais.arrDuplicatas[intContador].fltValDup := 0;
    End;
  End;

  {*************************************}
  {* NOTA DE IMPORTAÇÃO.               *}
  {**********************************MV*}
  If (Result.fltImpPro > 0) Then
  Begin
    Result.fltTotPro := Result.fltImpPro;
  End;

  If objConfig.blnNfeDse Then
  Begin
    If Result.dtaDtaDoc = 0 Then
    Begin
      Result.dtaDtaDoc := Result.dtaDtaEnt;
      Result.dtaHorDoc := Result.dtaHorEnt;
    End;
  End
  Else
  Begin
    Result.dtaDtaDoc := 0.0;
    Result.dtaHorDoc := 0.0;
  End;

  fCalculaTotalFCPST;

  If Not fImprimeSubTributariaDadosProprios(strForcaSubTributariaEmDadosPropriosLocal) Then
  Begin
    If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + ' / ';

    If (Result.fltTotRet > 0) Or (Pos(Result.strClaFis, '5905_5906_5929_5409_5152_5209_6209_') <= 0) Then
    Begin
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis +
                                   'Bc.ST: '      + FloatToStrF(Result.fltBasRet, ffNumber, 12, 2) +
                                   ' / Vl. ST: '  + FloatToStrF(Result.fltTotRet, ffNumber, 12, 2);
    End;

    If (Result.fltTotRet > 0) And (Result.fltTotFcpST > 0) Then
    Begin
      If Not fEmptyStr(Result.strMsgAdicionalFis) Then
        Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + ' / ';

      Result.fltDesAce := Result.fltDesAce + Result.fltTotFcpST;
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis +
                                   'BC.FCP ST: '     + FloatToStrF(Result.fltBasRet, ffNumber, 12, 2) +
                                   ' / ALQ.FCP ST: ' + FloatToStrF(Result.fltAlqFcpST, ffNumber, 12, 2) +
                                   ' / VL.FCP ST: '  + FloatToStrF(Result.fltTotFcpST, ffNumber, 12, 2);
    End;

    Result.fltDesAce := Result.fltDesAce + Result.fltTotRet;
    Result.fltBasRet := 0.0;
    Result.fltTotRet := 0.0;
  End;

  If (fImprimeMensagemDadosIPI(Result)) And (Not fImprimeIPIDadosProprios) Then
  Begin
    If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + ' / ';

    If (Result.fltTotIpi > 0) Or (Pos(Result.strClaFis, '5905_5906_5929_5409_5152_') <= 0) Then
    Begin
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Vl. IPI: ' + FloatToStrF(Result.fltTotIpi, ffNumber, 12, 2);
    End;

    Result.fltDesAce := Result.fltDesAce + Result.fltTotIpi;
    Result.fltTotIpi := 0.0;
  End;

  If (fonteDados.fDadosGerais.blnEst_DV) And (not fEmptyStr(fonteDados.fDadosGerais.strMotivoEstorno)) Then
  Begin
    If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + '#';

    Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Justificativa do Estorno: ' + fonteDados.fDadosGerais.strMotivoEstorno;
  End;

  If fonteDados.fDadosGerais.blnOrgPub And (fCfgSisFonte(fonteDados, 'MPERIR') <> 'S') Then
  begin
    If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + '#';

    If (fonteDados.fDadosGerais.fltIrfRet > 0) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Retenção IRPJ: ' + FloatToStrF(fonteDados.fDadosGerais.fltIrfRet, ffNumber, 12, 2)+ '#';

    If (fonteDados.fDadosGerais.fltCslRet > 0) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Retenção CSLL: ' + FloatToStrF(fonteDados.fDadosGerais.fltCslRet, ffNumber, 12, 2)+ '#';

    If (fonteDados.fDadosGerais.fltPisRet > 0) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Retenção PIS: ' + FloatToStrF(fonteDados.fDadosGerais.fltPisRet, ffNumber, 12, 2)+ '#';

    If (fonteDados.fDadosGerais.fltCofRet > 0) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'Retenção COFINS: ' + FloatToStrF(fonteDados.fDadosGerais.fltCofRet, ffNumber, 12, 2)+ '#';
  end;

  If not fEmptyStr(fonteDados.fDadosGerais.strNotasDeCupomComIPI) Then
  Begin
    If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + '#';

    Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'NFs que destacaram o IPI do cupom: ' + fonteDados.fDadosGerais.strNotasDeCupomComIPI;
  End;

  If Result.strEstado = 'EX' Then
    Result.strCodIbge := '9999999';

  If Result.strEstado = 'EX' Then
    Result.strCEP := '00000000'
  Else
    Result.strCEP := fLimpaCaracteres(Result.strCEP);

  If (not fonteDados.GetTemPerfilAduaneiro) and   (fCfgSisFonte(fonteDados, 'HODIMP') <> 'S') Then
  begin
    if Result.strEstado = 'EX' then
      Result.fltDesAce := Result.fltDesAce + Result.fltImpTax;
  end;

  If (Result.blnNfComp) And
     ((Result.fltTotRet > 0) Or (Result.fltTotIcm > 0)) And
     (fEmptyStr(Result.strCodSit)) Then
  Begin
    Result.strCodSit := '090';
  End;

  If (fSimplesPaulista(Result, fonteDados.fDadosEmitente, (fonteDados.fDadosGerais.strTip_FC = 'F'))) And
     (LeftStr(fonteDados.fDadosGerais.strClaFis, 1) <> '3')  Then
  Begin
    If Not Result.blnNfComp Then
    Begin
      Result.fltBasIcm := 0;
      Result.fltTotIcm := 0;
    End;
  End;

  If (Result.fltTotSer > 0) And (Result.fltBasIss = 0) Then
    Result.fltBasIss := Result.fltTotSer;

  Result.fltPesBru := fFormataFloat(Result.fltPesBru, 3);
  Result.fltPesLiq := fFormataFloat(Result.fltPesLiq, 3);

  If fPossuiItensComReducaoBaseRICMPR Then
    pCalculaBaseIcmConfRICMPR;

  If (fCfgSisFonte(fonteDados, 'AUTDOW') <> 'S') Or (fEmptyStr(fCfgSisFonte(fonteDados, 'AUTCGC'))) Then
    Result.blnTemItemTigre := False
  Else
    Result.blnTemItemTigre := fTemItemTigre;

  If (fCfgSisFonte(fonteDados, 'ESCDOW') = 'S') And (Not(fEmptyStr(fCfgSisFonte(fonteDados, 'ESCCGC')))) Then
    Result.blnTemEscritorioCredenciado := True
  Else
    Result.blnTemEscritorioCredenciado := False;

  fltDiferimentoProdST := fCalculaDiferimentoProdST;
  If (fltDiferimentoProdST > 0) Then
  Begin
    If (fonteDados.fDadosEmitente.strEstado = 'PR') Then
    Begin
      If Not fEmptyStr(Result.strMsgAdicionalFis) Then
      Begin
        Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + '#';
      End;
      Result.strMsgAdicionalFis := Result.strMsgAdicionalFis + 'ICMS PARCIALMENTE DIFERIDO NO MONTANTE DE R$ ' +
        FloatToStrF(fltDiferimentoProdST, ffNumber, 12, 2) + ', CONFORME ART. 28 INCISO I DO ANEXO VIII DO RICMS/PR.' + '#';
    End;
  End;

  If fEmptyStr(Result.strIES) And (Result.strIESUni <> 'S') Then
    Result.strIES := 'ISENTO';

  pCarregaChaveReferenciadaNotaComplemento(Result);
  pCarregaChaveReferenciadaParaNotaExportacao(Result);

  If Result.blnNfComp Then
  Begin
    Result.fltTotPro := Result.fltTotGer -
                        Result.fltTotRet -
                        Result.fltTotFcpST -
                        Result.fltTotIpi -
                        Result.fltDesAce +
                        Result.fltDesEsp ;
  End;

  If fDeveLimparEmailClienteConsumidor(Result) Then
    Result.strEmail := '';

  If pos(fonteDados.fDadosGerais.strFinalidade, '5_6_') > 0 Then
    Result.strMsgAdicionalFis := '';

  {******************************************************************}
  {* TRATAMENTO PARA SE CASO O CLIENTE NÃO ESTIVER COM A VERSÃO     *}
  {* QUE ENVIA AS MENSAGENS ADICIONAIS COMERCIAL E FISCAL SEPARADA, *}
  {* ENTÃO CONSIDERA TODAS AS MENSAGENS COMO COMERCIAL              *}
  {***************************************************************FC*}
   If (Not fonteDados.fCampoExiste('MOVOBS', 'MOV_CNFFIS')) Or
      (Not fonteDados.fCampoExiste('MOVOBS', 'MOV_OBSFIS')) Then
   Begin
     Result.strMsgAdicional    := Result.strMsgAdicionalCom + Result.strMsgAdicionalFis;
     Result.strMsgAdicionalCom := '';
     Result.strMsgAdicionalFis := '';
   End;

   pPreencheTipoIntegracaoTEF;
end;

procedure TFonteDadosFormatadorImpl.pPreencheTipoIntegracaoTEF;
  Var
    intContador: Integer;
    dataSet: TDataSet;
    strSQL: String;
    strPatNfce: String;
    strUsaTef: String;
    strCampo: String;
    intCampoNroAutoriza: Integer;
    blnExisteBan : Boolean;
    blnTemFormaCartao: Boolean;

  function fBandeira: String;
  begin
    If (blnExisteBan) And (Assigned(dataSet)) And (Not dataSet.IsEmpty) And (Assigned(dataSet.FindField('BAN_NOMBAN'))) Then
    Begin
      If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Visa_')) > 0) Then
        Result := '01'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Mastercard_')) > 0) Then
        Result := '02'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('American Express_')) > 0) Then
        Result := '03'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Sorocred_')) > 0) Then
        Result := '04'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Diners Club_')) > 0) Then
        Result := '05'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Elo_')) > 0) Then
        Result := '06'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Hipercard_')) > 0) Then
        Result := '07'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Aura_')) > 0) Then
        Result := '08'
      Else If (Pos(UpperCase(dataSet.FieldByName('BAN_NOMBAN').AsString), UpperCase('Cabal_')) > 0) Then
        Result := '09'
      Else
        Result := '99';
    End
    Else
      Result := '99';
  end;

  function fUsaTef: String;
  begin
    Result := fCfgSisFonte(fonteDados, 'TEFCIT') ;

    If (Result = 'T') Then
      Result := 'S';
  end;

begin
  dataSet := nil;

  If Not fSuportaOperacaoBanco(fonteDados) Then
  Begin
    Exit;
  End;

  If Not fonteDados.fTabelaExiste('MOVMOD') Then
  Begin
    Exit;
  End;

  If pos(fonteDados.fDadosGerais.strFinalidade, '5_6_') > 0 Then
    Exit;

  blnTemFormaCartao := False;
  For intContador := Low(fonteDados.fDadosGerais.arrFormasPagamento) To High(fonteDados.fDadosGerais.arrFormasPagamento) Do
  Begin
    If Pos(fonteDados.fDadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_') > 0 Then
    Begin
      blnTemFormaCartao := True;
      Break;
    End;
  End;

  If blnTemFormaCartao Then
  Begin
    blnExisteBan := fonteDados.fCampoExiste('CADBAN', 'BAN_NOMBAN');
    strPatNfce := fCfgSisFonte(fonteDados, 'PTNFCE');

    if fonteDados.fConfiguracaoExiste('TEFCIT') then
    begin
      strUsaTef := fUsaTef;
      if strUsaTef = 'N' then
      begin
        strUsaTef  := fArqIniLocal(0, 'NFCE', 'TEF', 'N', strPatNfce + PATH_SEPARATOR + 'opcoes_nfce.ini');
      end ;
    end
    else
    begin
      strUsaTef  := fArqIniLocal(0, 'NFCE', 'TEF', 'N', strPatNfce + PATH_SEPARATOR + 'opcoes_nfce.ini');
    end ;

    {* 1 = MCA_NUMCCD *}
    {* 2 = MCA_NUMNSU *}
    intCampoNroAutoriza := StrToInt(IIF(fEmptyStr(fCfgSisFonte(fonteDados, 'TPNUAU')), 1, fCfgSisFonte(fonteDados, 'TPNUAU')));

    If fonteDados.fCampoExiste('MOVCAR', 'MCA_TIPCAR') Then
      strCampo := 'MCA_TIPCAR'
    Else
    Begin
      If SameText(strUsaTef, 'S') Then
        strCampo := '"TEF" AS MCA_TIPCAR'
      Else
        strCampo := '"POS" AS MCA_TIPCAR';
    End;

    strSQL := 'SELECT ' + strCampo ;

    strSQL := strSQL + ' , EMP_C_G_C_ ' ;

    If fonteDados.fCampoExiste('CADCAR', 'CAR_C_G_C_') Then
      strSQL := strSQL + ' , CAR_C_G_C_ ' ;

    If (blnExisteBan) Then
      strSQL := strSQL + ' , BAN_NOMBAN ' ;

    Case intCampoNroAutoriza Of
      1:
      Begin
        If fonteDados.fCampoExiste('MOVCAR', 'MCA_NUMCCD') Then
          strSQL := strSQL + ' , MCA_NUMCCD AS NUMAUT '

        Else If fonteDados.fCampoExiste('MOVCAR', 'MCA_NUMNSU') Then
          strSQL := strSQL + ' , MCA_NUMNSU AS NUMAUT '

        Else
          strSQL := strSQL + ' , "" AS NUMAUT ';
      End;

      2:
      Begin
        If fonteDados.fCampoExiste('MOVCAR', 'MCA_NUMNSU') Then
          strSQL := strSQL + ' , MCA_NUMNSU AS NUMAUT  '

        Else If fonteDados.fCampoExiste('MOVCAR', 'MCA_NUMCCD') Then
          strSQL := strSQL + ' , MCA_NUMCCD AS NUMAUT '

        Else
          strSQL := strSQL + ' , "" AS NUMAUT ';
      End;
    End;

    strSQL := strSQL + '  FROM MOVMOD ';
    strSQL := strSQL + '  JOIN MOVCAR ON MOD_DOCUME = MCA_DOCUME AND MCA_PARCEL = "A" AND MCA_CODCLI = :CODCLI ';
    strSQL := strSQL + '  JOIN CADCAR ON CAR_CODCAR = MCA_CODCAR ';
    strSQL := strSQL + '  JOIN CADEMP ON EMP_CODEMP = MCA_CODEMP ';

    If (blnExisteBan) Then
      strSQL := strSQL + ' LEFT JOIN CADBAN ON BAN_CODBAN = CAR_CODBAN ';

    strSQL := strSQL + ' WHERE MOD_NUMDOC = :NUMDOC ';
    strSQL := strSQL + '   AND MOD_ESPDOC = :ESPDOC ';
    strSQL := strSQL + '   AND MOD_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND MOD_CODCLI = :CODCLI ';
    strSQL := strSQL + '   AND MOD_SERIE_ = :SERIE_ ';
    strSQL := strSQL + '   AND IFNULL(MCA_DOCUME,"") <> "" ';

    dataSet := fonteDados.fExecutaQuery(strSQL, ['NUMDOC', 'ESPDOC', 'CODEMP', 'CODCLI', 'SERIE_'],
                                                [fonteDados.fDadosGerais.strNumDoc,
                                                 fonteDados.fDadosGerais.strEspDoc,
                                                 fonteDados.fDadosGerais.strCodEmp,
                                                 fonteDados.fDadosGerais.strCodCli,
                                                 fonteDados.fDadosGerais.strSerie]);
  End;

  For intContador := Low(arrFormasPagamentoInterna) To High(arrFormasPagamentoInterna) Do
  Begin
    If Assigned(arrFormasPagamentoInterna[intContador]) Then
      FreeAndNil(arrFormasPagamentoInterna[intContador]);
  End;

  SetLength(arrFormasPagamentoInterna, Length(fonteDados.fDadosGerais.arrFormasPagamento));

  For intContador := Low(fonteDados.fDadosGerais.arrFormasPagamento) To High(fonteDados.fDadosGerais.arrFormasPagamento) Do
  Begin
    arrFormasPagamentoInterna[intContador] := TFormaPagamentoInterna.Create;

    If Pos(fonteDados.fDadosGerais.arrFormasPagamento[intContador].strCodigo, '03_04_') > 0 Then
    Begin
      If dataSet.FindField('CAR_C_G_C_') <> Nil Then
        arrFormasPagamentoInterna[intContador].strCnpjOperadora := dataSet.FieldByName('CAR_C_G_C_').AsString
      Else
        arrFormasPagamentoInterna[intContador].strCnpjOperadora := '';

      arrFormasPagamentoInterna[intContador].strCnpjBeneficiario := fTiraCaracEspeciaisPonto(dataSet.FieldByName('EMP_C_G_C_').AsString);
      arrFormasPagamentoInterna[intContador].strNumAutorizacao := dataSet.FieldByName('NUMAUT').AsString;
      arrFormasPagamentoInterna[intContador].strBandeira := fBandeira;

      If strUsaTef = 'N' Then
      Begin
        arrFormasPagamentoInterna[intContador].strTipCar := '2'; // POS
      End
      Else
      Begin
        If (dataSet.FieldByName('MCA_TIPCAR').AsString = 'TEF') Then
        Begin
          arrFormasPagamentoInterna[intContador].strTipCar := '1'; // TEF
        End
        Else
        Begin
          arrFormasPagamentoInterna[intContador].strTipCar := '2'; // POS
        End;
      End;
    End;
  End;

  If Assigned(dataSet) Then
    FreeAndNil(dataSet);
end;

procedure TFonteDadosFormatadorImpl.pCarregaBaseReduzidaDestinoAbfIcm(
  dadosItem: TDadosItem);
  Var
    dataSet: TDataSet;
begin
  Exit; //REQUISITO 74126

  dataSet := fonteDados.fExecutaQuery('SELECT ABF_BASICM_SAI_NCO FROM ABFICM ' +
    'WHERE ABF_CODABF = :CODABF AND ABF_ESTADO = :ESTADO ',
    ['CODABF', 'ESTADO'], [dadosItem.strCodAbf, fonteDados.fDadosEmitente.strEstado]);

  dadosItem.fltBaseCalculoReduzidaDestino := dataSet.FieldByName('ABF_BASICM_SAI_NCO').AsFloat;

  FreeAndNil(dataSet);

end;

//Necessario para manter compatibilidade com as libNfeBD.dll (Clientes Especificos ex: andorinha)
procedure TFonteDadosFormatadorImpl.pCarregaChaveReferenciadaNotaComplemento(dadosGerais: TDadosGerais);
begin
  If Length(dadosGerais.arrChavesReferenciadas) > 0 Then
    Exit;

  SetLength(dadosGerais.arrChavesReferenciadas, 0);

  If (dadosGerais.blnNfComp) And
     ((dadosGerais.blnComplementoIcms) Or (dadosGerais.blnComplementoValor) Or (dadosGerais.blnCreditoIcms) Or
      (dadosGerais.blnComplementoDifal) Or (dadosGerais.blnComplementoStPerfilCnc) Or (dadosGerais.blnComplementoStPerfilTrs) Or
      (dadosGerais.blnTransfIcms) Or (dadosGerais.blnNFAjusteICMSaMaior) Or (dadosGerais.blnComplementoFrete) Or
      (pos(dadosGerais.strFinalidade, '5_6_') > 0) ) Then
  Begin
    SetLength(dadosGerais.arrChavesReferenciadas, Length(dadosGerais.arrChavesReferenciadas) + 1);
    dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] := TChaveReferenciada.Create;

    With dadosGerais.arrChavesReferenciadas[Length(dadosGerais.arrChavesReferenciadas) - 1] Do
    Begin
      strTipoChave         := dadosGerais.fTipoChaveReferenciada('NF', dadosGerais.strAceOriNC);
      strChaveAcessoNfe    := dadosGerais.strAceOriNC;
      strModeloDocFiscalNF := '01';
      strCnpjEmitente      := fonteDados.fDadosEmitente.strCnpj;
      strUfIbgeEmitente    := fonteDados.fDadosEmitente.strUfIbge;
      strSerieFiscal       := dadosGerais.strSerOriNC;
      strDocumentoFiscal   := dadosGerais.strDocOriNC;
      strAnoMesEmissao     := FormatDateTime('YYMM', dadosGerais.dtaDtaOriNC);
    End;

    Exit;
  End;
end;  

procedure TFonteDadosFormatadorImpl.pCarregaChaveReferenciadaParaNotaExportacao(
  dadosGerais: TDadosGerais);
var
  strSQL: String;
  dtsChaves: TDataSet;
begin
  SetLength(dadosGerais.arrChaveNFRefExportacao, 0);

  If (IfEmptyStr(dadosGerais.strTemRefFis, 'S') = 'S') Then
  Begin
    If fonteDados.fTabelaExiste('REFFIS') Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT R.FIS_ACESSO ';
      strSQL := strSQL + '  FROM REFFIS R     ';
      strSQL := strSQL + '       INNER JOIN CADFIS C ON R.FIS_SEQFIS = C.AUTOINCREM ';
      strSQL := strSQL + ' WHERE C.FIS_NUMDOC = :NUMDOC ';
      strSQL := strSQL + '   AND C.FIS_ESPDOC = :ESPDOC ';
      strSQL := strSQL + '   AND C.FIS_CODEMP = :CODEMP ';
      strSQL := strSQL + '   AND C.FIS_FORCLI = :FORCLI ';
      strSQL := strSQL + '   AND C.FIS_SERIE_ = :SERIE_ ';
      strSQL := strSQL + '   AND C.FIS_TIP_FC = :TIP_FC ';
      strSQL := strSQL + '   AND C.FIS_ORIDOC = "V"     ';

      dtsChaves := fonteDados.fExecutaQuery(strSQL, ['NUMDOC','ESPDOC','CODEMP','FORCLI', 'SERIE_', 'TIP_FC'], [dadosGerais.strNumDoc,
                                                                                                                dadosGerais.strEspDoc,
                                                                                                                dadosGerais.strCodEmp,
                                                                                                                dadosGerais.strCodCli,
                                                                                                                dadosGerais.strSerie,
                                                                                                                dadosGerais.strTip_FC]);
      Try
        dtsChaves.First;
        While Not dtsChaves.Eof Do
        Begin
          SetLength(dadosGerais.arrChaveNFRefExportacao, Length(dadosGerais.arrChaveNFRefExportacao) + 1);
          dadosGerais.arrChaveNFRefExportacao[Length(dadosGerais.arrChaveNFRefExportacao) - 1] := dtsChaves.FieldByName('FIS_ACESSO').AsString;
          dtsChaves.Next;
        End;
      Finally
        FreeAndNil(dtsChaves);
      End;
    End;
  End;
end;

function TFonteDadosFormatadorImpl.fFormataDadosItem: TDadosItem;
  Const
    ENVIA_CEST_PARA_SUBSTITUIDOS : String = '1';

  Var
    dadosItem: TDadosItem;
    strDescricaoAnp: String;
    strAux: String;
    dataSet: TDataSet;
    fltPerImpPag: Double;
    strFORSCH : String;
    strCLISCH : String;
    strCESTST : String;
    strTpAbre : String;
    strCodCST : String;
    blnDeduziuFCP_ST : boolean;
    strForcaSubTributariaEmDadosPropriosLocal: String;

    strVALX90 : String;
    blnVALX90 : Boolean;
    blnCdGTinIgualCodBar: Boolean;

    function fStrCfoIPI: String;
    begin
      {***********************************************************************}
      {* Força utilização do cadastro de abreviação de IPI para alguns CFOPs *}
      {********************************************************************BZ*}

      Result := fTransform(fCfgSisFonte(fonteDados, 'CFOIPI'), 4);
    end;

   function fTemIESUni: Boolean;
   Begin
     Result:= (fonteDados.fCampoExiste('CADCLI', 'CLI_IESUNI'));
   End;

  function fExisteRegistroTabela(arrNomeTabela: Array Of String;
    arrParametros: Array Of String; arrValores: Array Of Variant): Boolean;
    Var
      intIndTab,
      intIndPar: Integer;
      strSQL  : String;
      qryAux  : TDataSet;
  begin
    Result := False;

    intIndTab := 0;

    While (intIndTab <= High(arrNomeTabela)) Do
    Begin
      If fonteDados.fTabelaExiste(arrNomeTabela[intIndTab]) Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + arrNomeTabela[intIndTab];
        strSQL := strSQL + ' WHERE ';

        intIndPar := 0;

        While (intIndPar <= High(arrParametros)) Do
        Begin
          strSQL := strSQL + arrParametros[intIndPar] + ' = :' + arrParametros[intIndPar] + IIF(intIndPar = High(arrParametros), ' ', ' AND ');
          Inc(intIndPar);
        End;

        qryAux := fonteDados.fExecutaQuery(strSQL, arrParametros, arrValores);

        With qryAux Do
        Begin
          If Not IsEmpty Then
            Result := FieldByName('QTD').AsInteger > 0;
        End;

        FreeAndNil(qryAux);
      End;

      If Result Then
        Break;

      Inc(intIndTab);
    End;
  end;

  procedure pZerarValoresIPI;
  begin
    dadosItem.fltBasIpi := 0;
    dadosItem.fltAlqIpi := 0;
    dadosItem.fltValIpi := 0;
  end;

  function fIgnoraConfiguracaoCestST: Boolean;
  Begin
    Result := (fCfgSisFonte(fonteDados, 'EVCEST') = 'S') And (Pos(dadosItem.strClaFis, '5905_6905_') > 0);
  End;

  function fInsereMsgICMSDesoneradoZonaFranca: Boolean;
  Begin
    Result := False;

    If not (fonteDados.fDadosGerais.strZonFra = 'S') Then
      Exit;

    If not (dadosItem.fltIcmOrg > 0) Then
      Exit;

    If not (fCfgSisFonte(fonteDados, 'MSIDES') = 'S') Then
      Exit;

    Result := True;
  End;

  function fInsereMsgDesoneradoNfeExportacao: Boolean;
  var
    strMseDes: String;
  begin
    Result := True;

    If not (LeftStr(dadosItem.strClaFis, 1) = '7') Then
      Exit;

    strMseDes := fCfgSisFonte(fonteDados, 'MSEDES');

    strMseDes := IIF(fEmptyStr(strMseDes), 'S', strMseDes);

    If not (strMseDes = 'N') Then
      Exit;

    Result := False;
  end;

  function fEquiparaCamposGTIN: Boolean;
  begin
    Result := False;

    If fEmptyStr(dadosItem.strCodBar) Then
      Exit;

    If (dadosItem.strCodBar = 'SEM GTIN') Then
      Exit;

    If (dadosItem.strCdGTin = 'SEM GTIN') Then
      Result := True;

  end;

  function fRetornaValidadeLote: String;
  begin
    Result := dadosItem.strValLot;

    If (fCfgSisFonte(fonteDados, 'VALLOI') = 'S') And fEmptyStr(dadosItem.strValLot) Then
    Begin
      Result := 'INDETERMINADO';
    end;
  end;

begin
  dadosItem := fonteDados.fProximoItem;
  dadosItem.strAnotacoes := '';

  dadosItem.strCodIteOriginal := dadosItem.strCodIte;
  If (objConfig.strNfeIte <> '1') And (Not fEmptyStr(dadosItem.strCodFab)) Then
    dadosItem.strCodIte := dadosItem.strCodFab;

  If (objConfig.strCliPro = 'S') And (Not fEmptyStr(dadosItem.strCod_Nf)) Then
    dadosItem.strCodIte := dadosItem.strCod_Nf;

  If (objConfig.strCliPro = 'S') And (Not fEmptyStr(dadosItem.strDes_Nf)) Then
    dadosItem.strDesIte := dadosItem.strDes_Nf;

  If (objConfig.strCliPro = 'S') And (Not fEmptyStr(dadosItem.strUni_Nf)) Then
  begin
    dadosItem.strUnidad := dadosItem.strUni_Nf;
    if not fUsaUniTri(dadosItem.strClaFis) then
      dadosItem.strUnTrib := dadosItem.strUnidad;
  end;

  If Not fEmptyStr(dadosItem.strCodigoTinta) Then
    dadosItem.strCodIte := dadosItem.strCodigoTinta;

  dadosItem.strClaIpi:= LeftStr(fLimpaCaracteres(dadosItem.strClaIpi), 8);

  If fonteDados.fDadosGerais.strEspDoc = 'IF' Then
  Begin
    If (Pos(RightStr(dadosItem.strCodSit, 2), '10') > 0) And (dadosItem.fltBasRet = 0) Then
    begin
      dadosItem.strCodSit := AnsiReplaceStr(dadosItem.strCodSit, '10', '60');
      {******************************************************************************************}
      {* Pode ter definido o código de benefício na abreviação, por isso a verificação do vazio *}
      {***************************************************************************************RN*}
      if (fEmptyStr(dadosItem.strCdbFis)) and (fCfgSisFonte(fonteDados, 'OBRBEN') = 'S') then
        dadosItem.strCdbFis := fBuscaBeneficioFiscalDaTabelaDefault(fonteDados, dadosItem.strCodSit, fonteDados.fDadosEmitente.strEstado);
    end;
  End;

  If (Not fonteDados.fNotaServicoEletronica) Then
  Begin
    If (Not objConfig.blnDesFab) And (Not fEmptyStr(dadosItem.strDesFab)) Then
      dadosItem.strDesIte := dadosItem.strDesFab;

    If (fCfgSisFonte(fonteDados, 'FABNFE') = 'S') Then
      dadosItem.strDesIte := dadosItem.strCodFab + ' - ' + dadosItem.strDesIte;

    If objConfig.blnClaOnu And (Not fEmptyStr(dadosItem.strCodOnu)) And (pos(objConfigInterna.strImpOnu, 'A_T_') > 0) And (Not fEmptyStr(dadosItem.strCodigo)) Then
      dadosItem.strDesIte := dadosItem.strDesIte + ' - ONU : (' + dadosItem.strCodigo + ')';
  End;

  If fonteDados.fNotaServicoEletronicaConcreto Then
  Begin
    //Prestcon
    If ((objConfigInterna.strTpNfCr = PRESTCON) Or (objConfigInterna.strTpNfCr = SECOL)) Then
    Begin
      If objConfigInterna.strIteTax = dadosItem.strCodIte Then
      Begin
        dadosItem.strDesIte :=  Trim(dadosItem.strDocRemessaConcreto + '     ' +
                                     dadosItem.strDesIte             + '     ' +
              FormatFloat('#,##0.00',dadosItem.fltTotIte)            + '     ') ;

      End
      Else
      Begin
        dadosItem.strDesIte :=  Trim( dadosItem.strDocRemessaConcreto + '     ' +
                                      dadosItem.strDesIte             + '     ' +
              FormatFloat('#,##0.00', dadosItem.fltQtdIte)            + ' ' +
                                      dadosItem.strUnidad             + '  X  ' +
              FormatFloat('#,##0.00', dadosItem.fltUnitar)            + '  =  ' +
              FormatFloat('#,##0.00', dadosItem.fltTotIte)            + '     ' ) ;
      End;
    End
    Else
    Begin
      dadosItem.strDesIte := FloatToStrF(dadosItem.fltQtdIte, ffNUmber, 12, 2) + ' ' +
                             dadosItem.strUnidad + ' de ' + dadosItem.strDesIte;
    End;
  End;

  If (Not fEmptyStr(dadosItem.strNum_DI)) Then
    pSetarAnotacoesDadosItem('DI: ' + dadosItem.strNum_DI, dadosItem);

  If objConfigInterna.blnComplInfAd And (Not fEmptyStr(dadosItem.strComple)) Then
    pSetarAnotacoesDadosItem(dadosItem.strComple, dadosItem);

  if (fCfgSisFonte(fonteDados, 'NFEPRO') = 'S') and (dadosItem.blnPromocao) then
    pSetarAnotacoesDadosItem('***PRODUTO EM PROMOCAO***', dadosItem);

  if (fCfgSisFonte(fonteDados, 'NFDESC') = 'S') and (dadosItem.fltDesEsp > 0 ) then
    pSetarAnotacoesDadosItem('DESCONTO ESPECIAL: ' + FloatToStrF(dadosItem.fltDesEsp, ffNUmber, 12, 2), dadosItem);

  If objConfig.blnClaOnu And
     (pos(objConfigInterna.strImpOnu, 'I_T_') > 0) And
     (Not fEmptyStr(dadosItem.strCodOnu)) Then
  Begin
    pSetarAnotacoesDadosItem('ONU ' + dadosItem.strCodigo + ', ' +
                             dadosItem.strDesOnu + ', ' +
                             '(CLASSE ' + dadosItem.strClaRis + '), ' +
                             'GE ' + dadosItem.strGruEmb + ' ' +
                             FormatFloat('#,##0.000', dadosItem.fltTotPes) + 'KG.', dadosItem);
  End;

  If objConfig.blnNFEFab Then
  Begin
    If Not fEmptyStr(dadosItem.strCodFab) Then
      pSetarAnotacoesDadosItem(IIF(objConfig.blnPRFCFB, ' COD.FABRICA: ', '') +  dadosItem.strCodFab, dadosItem);
  End;

  If objConfigInterna.blnPDCNFE Then
  Begin
    If Not fEmptyStr(dadosItem.strPedCom) Then
      pSetarAnotacoesDadosItem('PEDIDO: ' + dadosItem.strPedCom + IIF(fEmptyStr(dadosItem.strNItemPed), '', ' ITEM: ' + dadosItem.strNItemPed), dadosItem);
  End;

  If objConfig.blnNFEMar Then
  Begin
    If Not fEmptyStr(dadosItem.strDesMar) Then
      pSetarAnotacoesDadosItem('MARCA: ' + dadosItem.strDesMar, dadosItem);
  End;

  If objConfigInterna.blnNFeBar Then
  Begin
    If Not fEmptyStr(dadosItem.strCodBar) Then
      pSetarAnotacoesDadosItem('COD. BARRAS: ' + dadosItem.strCodBar, dadosItem);
  End;

  If objConfig.blnNFELoc Then
  Begin
    If Not fEmptyStr(dadosItem.strLocFis) Then
      pSetarAnotacoesDadosItem('LOC.FISICA: ' + dadosItem.strLocFis, dadosItem);
  End;

  If objConfig.blnNfeMFi Then
  Begin
    If Not fEmptyStr(dadosItem.strMenFis) Then
      pSetarAnotacoesDadosItem(' ' + dadosItem.strMenFis, dadosItem);
  End;

  If (dadosItem.fltBARTSP > 0) And (dadosItem.strDiferi = 'S') And (objConfigInterna.strImpIcmsOpeProprias <> 'N') Then
    pSetarAnotacoesDadosItem(' ' + 'Base ST.: ' + FloatToStrF(dadosItem.fltBARTSP, ffNumber, 12, 2) + ' / ' +
                             'Valor ST.: ' + FloatToStrF(dadosItem.fltVLRTSP, ffNumber, 12, 2) + ' / ' +
                             'ICMS Oper. Prop.: ' + FloatToStrF(dadosItem.fltICOPPR, ffNumber, 12, 2), dadosItem);

  strTpAbre := fGetTipoAbreviacao(fonteDados.fDadosGerais);
  strCodCST := RightStr(dadosItem.strCodSit, 2);

  {******************************************************************************************************************************************}
  { CFG_FCPZER - Quando utilizar [CFG_BEN_ST], onde o Sistema imprime informações do FCP abaixo de cada produto, proceder da seguinte forma: }
  { 1: Listar somente valor de FCP maior que zero.                                                                                           }
  { 2: Listar FCP mesmo zerado, para identificar os produtos enquadrados no Decreto 44498/2013.                                              }
  {***************************************************************************************************************************************LD*}
  If fCalcBeneficioReducaoBase(fonteDados, fonteDados.fDadosGerais, fonteDados.fDadosEmitente) And
     (Pos(strTpAbre, 'CCO_CNC_') > 0) And (Pos(strCodCST, '20_70_') > 0)  Then
  Begin

    case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
      1:
        begin
          If (dadosItem.fltValorFCP > 0) Then
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2) + '  ')+
                                           fTagDadosAdicionaisItem('pRedBC', 'pRedBC: ' + FloatToStrF(dadosItem.fltPerRed, ffNumber, 12, 2) + '%  '), dadosItem);
        end;
      2:
        begin
          pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                         fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                         fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2) + '  ')+
                                         fTagDadosAdicionaisItem('pRedBC', 'pRedBC: ' + FloatToStrF(dadosItem.fltPerRed, ffNumber, 12, 2) + '%  '), dadosItem);
        end;
    end;

    If (strCodCST = '70') Then
    Begin
      case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
        1:
          begin
            If (dadosItem.fltValorFCPST > 0) Then
            begin
              pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                             fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pRedBCST', 'pRedBCST: ' + FloatToStrF(dadosItem.fltPRedST, ffNumber, 12, 2) + '%  '), dadosItem);

              pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('pMVAST' , 'pMVAST: ' + FloatToStrF(dadosItem.fltValIva, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pICMSST', 'pICMSST: ' + FloatToStrF(dadosItem.fltAlqRet, ffNumber, 12, 2) + '%  ') +
                                             fTagDadosAdicionaisItem('vBCST'  , 'vBCST: ' + FloatToStrF(dadosItem.fltBasRet, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('vICMSST', 'vICMSST: ' + FloatToStrF(dadosItem.fltValRet, ffNumber, 12, 2)), dadosItem);
            End;
          end;
        2:
          begin
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pRedBCST', 'pRedBCST: ' + FloatToStrF(dadosItem.fltPRedST, ffNumber, 12, 2) + '%  '), dadosItem);

            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('pMVAST' , 'pMVAST: ' + FloatToStrF(dadosItem.fltValIva, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pICMSST', 'pICMSST: ' + FloatToStrF(dadosItem.fltAlqRet, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vBCST'  , 'vBCST: ' + FloatToStrF(dadosItem.fltBasRet, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('vICMSST', 'vICMSST: ' + FloatToStrF(dadosItem.fltValRet, ffNumber, 12, 2)), dadosItem);
          end;
      end;
    End;

  End
  Else If fProdutoIndustrializadoDentroDoEstado(fonteDados, fonteDados.fDadosGerais, fonteDados.fDadosEmitente, dadosItem) Or
          fProdutoRevendaDentroDoEstado(fonteDados, fonteDados.fDadosGerais, fonteDados.fDadosEmitente, dadosItem) Then
  Begin
    case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
      1:
        begin
          If (dadosItem.fltValorFCP > 0) Then
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2)), dadosItem);

          If (dadosItem.fltValorFCPST > 0) Then
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  '), dadosItem);
        end;
      2:
        begin
          If (fCfgSisFonte(fonteDados, 'BEN_ST') = 'S') Then
          begin
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2)), dadosItem);

            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  '), dadosItem);
          End;
        end;
    end;
  End
  Else If fCalculaFCPComReducaoBaseIcmsST(fonteDados, fonteDados.fDadosGerais, fonteDados.fDadosEmitente) And
          (Pos(strTpAbre, 'CCO_CNC_') > 0) And (Pos(strCodCST, '20_70_') > 0)  Then
  Begin
    If (objConfigInterna.blnFcpAni) Then
    Begin
      case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
        1:
          begin
            If (dadosItem.fltValorFCP > 0) Then
              pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                             fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2) + '  ')+
                                             fTagDadosAdicionaisItem('pRedBC', 'pRedBC: ' + FloatToStrF(dadosItem.fltPerRed, ffNumber, 12, 2) + '%  '), dadosItem);
          end;
        2:
          begin
            pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCP', 'vBCFCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ') +
                                           fTagDadosAdicionaisItem('pFCP'  , 'pFCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ') +
                                           fTagDadosAdicionaisItem('vFCP'  , 'vFCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2) + '  ')+
                                           fTagDadosAdicionaisItem('pRedBC', 'pRedBC: ' + FloatToStrF(dadosItem.fltPerRed, ffNumber, 12, 2) + '%  '), dadosItem);
          end;
      end;

      If (strCodCST = '70') Then
      Begin
        case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
          1:
            begin
              If (dadosItem.fltValorFCPST > 0) Then
              begin
                pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                               fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                               fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  ') +
                                               fTagDadosAdicionaisItem('pRedBCST', 'pRedBCST: ' + FloatToStrF(dadosItem.fltPRedST, ffNumber, 12, 2) + '%  '), dadosItem);
              End;
            end;
          2:
            begin
              pSetarAnotacoesDadosItem(' ' + fTagDadosAdicionaisItem('vBCFCPST', 'vBCFCPST: ' + FloatToStrF(dadosItem.fltBaseFCPST, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pFCPST'  , 'pFCPST: ' + FloatToStrF(dadosItem.fltPercentualFCPST, ffNumber, 12, 2) + '%  ') +
                                             fTagDadosAdicionaisItem('vFCPST'  , 'vFCPST: ' + FloatToStrF(dadosItem.fltValorFCPST, ffNumber, 12, 2) + '  ') +
                                             fTagDadosAdicionaisItem('pRedBCST', 'pRedBCST: ' + FloatToStrF(dadosItem.fltPRedST, ffNumber, 12, 2) + '%  '), dadosItem);
            end;
        end;
      End;
    End;

  End
  Else If (objConfigInterna.blnFcpAni) Then
  Begin
    case StrToIntDef(fCfgSisFonte(fonteDados, 'FCPZER'), 1) of
      1:
        begin
          if (dadosItem.fltValorFCP > 0) then
            pSetarAnotacoesDadosItem(' ' + 'BC.FCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ' +
                                           'Aliq.FCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ' +
                                           'Vr.FCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2), dadosItem);
        end;
      2:
        begin
          if (fCfgSisFonte(fonteDados, 'BEN_ST') = 'S') then
            pSetarAnotacoesDadosItem(' ' + 'BC.FCP: ' + FloatToStrF(dadosItem.fltBaseFCP, ffNumber, 12, 2) + '  ' +
                                           'Aliq.FCP: ' + FloatToStrF(dadosItem.fltPercentualFCP, ffNumber, 12, 2) + '%  ' +
                                           'Vr.FCP: ' + FloatToStrF(dadosItem.fltValorFCP, ffNumber, 12, 2), dadosItem);
        end;
    end;
  End
  Else If (objConfigInterna.blnImprimeAnotacoesItem) Then
  Begin

    //sugestão do FISCAL => BC ICMS-ST: 500,00  VICMS-ST= 36,00 IVA: 41,00
    If (dadosItem.fltBasRet > 0) Then
      pSetarAnotacoesDadosItem('BC ICMS-ST: ' + FloatToStrF(dadosItem.fltBasRet, ffNumber, 12, 2) + ' ', dadosItem);
    If (dadosItem.fltValRet > 0) Then
      pSetarAnotacoesDadosItem('VICMS-ST: ' + FloatToStrF(dadosItem.fltValRet, ffNumber, 12, 2)+ ' ', dadosItem);
    If (dadosItem.fltValIva > 0) Then
      pSetarAnotacoesDadosItem('IVA: ' + FloatToStrF(dadosItem.fltValIva, ffNumber, 12, 2) + '% ', dadosItem);

  End;

  if (not fEmptyStr(dadosItem.strMtdIcm)) And fInsereMsgDesoneradoNfeExportacao then
  begin
    pSetarAnotacoesDadosItem('MOT.DESONER.: ' + dadosItem.strMtdIcm + ' ', dadosItem);
    pSetarAnotacoesDadosItem('VLR.DESONER.: ' + FloatToStrF(dadosItem.fltVrdIcm, ffNumber, 12, 2) + ' ', dadosItem);
  end;

  If fInsereMsgICMSDesoneradoZonaFranca Then
  Begin
    pSetarAnotacoesDadosItem('Valor do ICMS desonerado ZFM: R$ ' + FloatToStrF(dadosItem.fltIcmOrg, ffNumber, 12, 2) + ' ', dadosItem);
  End;

  If (objConfigInterna.blnImpLot) And (Not fEmptyStr(dadosItem.strNumLot)) then
  Begin
    If (Not fEmptyStr(dadosItem.strNumLotDtaVal)) Then
      pSetarAnotacoesDadosItem(dadosItem.strNumLotDtaVal, dadosItem)
    Else If (fCfgSisFonte(fonteDados, 'VALLOT') = 'S') Then
      pSetarAnotacoesDadosItem('LOTE: ' + dadosItem.strNumLot + ' VALIDADE: ' + fRetornaValidadeLote, dadosItem)
    Else
      pSetarAnotacoesDadosItem('LOTE: ' + dadosItem.strNumLot, dadosItem);
  End;

  If (fCfgSisFonte(fonteDados, 'INF_ST') = 'S') Then
  Begin
    If (dadosItem.fltBasRet > 0) Then
      pSetarAnotacoesDadosItem('BC.ICMS-ST: ' + FloatToStrF(dadosItem.fltBasRet, ffNumber, 12, 2) + ' ', dadosItem);
    If (dadosItem.fltValRet > 0) Then
      pSetarAnotacoesDadosItem('Vr.ICMS-ST: ' + FloatToStrF(dadosItem.fltValRet, ffNumber, 12, 2)+ ' ', dadosItem);
  End;

  If Not fEmptyStr(fInformacoesMadeira(dadosItem)) Then
    pSetarAnotacoesDadosItem(fInformacoesMadeira(dadosItem), dadosItem);

  //Caso possua o nº do FCI preenchido e o mesmo ainda nao esteja inserido nas anotacoes do item
  If objConfig.blnNfeFCI And Not fEmptyStr(dadosItem.strNumFCI) And (Pos(dadosItem.strNumFCI, dadosItem.strAnotacoes) <= 0) Then
    pSetarAnotacoesDadosItem('"Resolução do Senado Federal nº 13/12, Número da FCI ' + dadosItem.strNumFCI + '"', dadosItem);

  If objConfig.blnInfGar Then
  Begin
    If Not fEmptyStr(dadosItem.strInfGar) Then
      pSetarAnotacoesDadosItem(' ' + dadosItem.strInfGar, dadosItem);
  End;

  {*****************************************}
  {* ANOTAÇÕES POR ITEM.                   *}
  {**************************************MV*}
  If Not fEmptyStr(dadosItem.strDesNes) Then
    pSetarAnotacoesDadosItem(AnsiReplaceText(dadosItem.strDesNes, #13#10, ' '), dadosItem);

  {**********************************************************}
  {* TROCA DESCRIÇÃO DO PRODUTO CASO SEJA COMB/LUBRIFICANTE *}
  {*******************************************************MV*}
  If fSuportaOperacaoBanco(fonteDados) Then
  Begin
    If (Not fEmptyStr(dadosItem.strCodLub)) And (fonteDados.fTabelaExiste('CADANP')) Then
    Begin
      dataSet := fonteDados.fExecutaQuery('SELECT ANP_DESCRI FROM CADANP WHERE ANP_CODANP = :CODANP', ['CODANP'], [dadosItem.strCodLub]);
      If Not dataSet.IsEmpty Then
      Begin
        strDescricaoAnp := dataSet.FieldByName('ANP_DESCRI').AsString;
        dadosItem.strAnotacoes := dadosItem.strDesIte + ' ' + dadosItem.strAnotacoes;
        dadosItem.strDesIte := strDescricaoAnp;

        If fEmptyStr(dadosItem.strDesANP) Then
          dadosItem.strDesANP := strDescricaoAnp;
      End;
      FreeAndNil(dataSet);
    End;
  End;

  If (objConfigInterna.blnMsgIaI) And (fonteDados.fDadosGerais.strEspDoc <> 'NS') And
     (not objConfigInterna.blnZeraIBPT) And (not objConfigInterna.blnImpIBP) Then
  Begin
    If (dadosItem.fltImpPag <> 0) Then
    Begin
      fltPerImpPag := 0.00;
      If ((dadosItem.fltTotIte - dadosItem.fltDesEsp) <> 0.00) Then
        fltPerImpPag := dadosItem.fltImpPag / (dadosItem.fltTotIte - dadosItem.fltDesEsp) * 100.00;

      If (fltPerImpPag <> 0.00) Then
        pSetarAnotacoesDadosItem('Vlr Aprox do Tributo "R$ ' + FormatFloat('#,##0.00', dadosItem.fltImpPag) +
                                  '(' + FormatFloat('#,##0.00', fltPerImpPag) + IIF(objConfigInterna.strImpPag = '2','%) Fonte: IBPT"','%)"'), dadosItem);
    End
    Else
    Begin
      strAux := '';
      strAux := strAux + IIF(dadosItem.fltFedImp <> 0.00, IIF(fEmptyStr(strAux),'',' / ')+'R$ '+FormatFloat('#,##0.00', dadosItem.fltFedImp)+' Federal', '');
      strAux := strAux + IIF(dadosItem.fltEstImp <> 0.00, IIF(fEmptyStr(strAux),'',' / ')+'R$ '+FormatFloat('#,##0.00', dadosItem.fltEstImp)+' Estadual', '');
      strAux := strAux + IIF(dadosItem.fltMunImp <> 0.00, IIF(fEmptyStr(strAux),'',' / ')+'R$ '+FormatFloat('#,##0.00', dadosItem.fltMunImp)+' Municipal', '');

      If Not fEmptyStr(strAux) Then
        pSetarAnotacoesDadosItem('Vlr Aprox dos Tributos: ' + strAux + ' - Fonte: IBPT', dadosItem);

    End;
  End;

  {********************************************************************}
  {* AJUSTES PARA O DIFERENCIAL DE ALIQUOTA PARA CONSUMIDOR FINAL     *}
  {* AJUSTES PARA OS CASOS ONDE O CLIENTE SEJA CONSUMIDOR FINAL E NÃO *}
  {* CONTRIBUINTE DE ICMS, PARA VENDAS FORA DO ESTADO, E NÃO ESTEJA   *}
  {* USANDO A NOVA ABREVIAÇÃO E PRODUTOS TRIBUTADOS.                  *}
  {*****************************************************************MV*}
  If fSuportaOperacaoBanco(fonteDados) Then
  Begin
    If (Not fonteDados.fTabelaExiste('ABFICM')) Then
    Begin
      If ((Not fonteDados.fTabelaExiste('MOVICD')) Or (Not fExisteRegistroTabela(['MOVICD', 'NOTICD'], ['ICD_SEQGER'], [dadosItem.strAutInc]))) Then
      Begin
        If (Pos(RightStr(dadosItem.strCodSit, 2), '00,20,10,30,60,70') > 0) And
           (fonteDados.fDadosGerais.strEstado <> fonteDados.fDadosEmitente.strEstado) And
           (LeftStr(fonteDados.fDadosGerais.strClaFis, 1) <> '3') Then
        Begin
          If (fEmptyStr(fonteDados.fDadosGerais.strIES)) And
             (fonteDados.fDadosGerais.strIESUni = 'S') And
             (fonteDados.fDadosGerais.strCliCon = 'S') Then
          Begin
            pRecalculaIcmsParaEstadoDestino(dadosItem);
          End
          Else If (Pos(fonteDados.fDadosGerais.strCodAti, objConfig.strVS_CliAti) > 0) Then
          Begin
            pRecalculaIcmsParaEstadoDestino(dadosItem);
          End;
        End;
      End;
    End;
  End;

  {****************************************************************************************}
  {* QUANDO UTILIZA O PROCESSO ABAIXO, SÓ DEVE IMPRIMIR NA TAG "InfAdProd" AS INFORMAÇÕES *}
  {* QUE JÁ VEM GRAVADA NO CAMPO "DET_DESNES"                                             *}
  {*************************************************************************************RN*}
  strFORSCH := fCfgSisFonte(fonteDados, 'FORSCH');
  strCLISCH := fCfgSisFonte(fonteDados, 'CLISCH');

  If (Not fEmptyStr(dadosItem.strDesNes)) And
     (((Not fEmptyStr(strFORSCH)) And (strFORSCH = fonteDados.fDadosGerais.strCodCli)) Or
      ((Not fEmptyStr(strCLISCH)) And (strCLISCH = fonteDados.fDadosGerais.strCodCli))) Then
    dadosItem.strAnotacoes := dadosItem.strDesNes;

  dadosItem.strAnotacoes := LeftStr(dadosItem.strAnotacoes, 500);

  If fSimplesPaulista(fonteDados.fDadosGerais, fonteDados.fDadosEmitente, (fonteDados.fDadosGerais.strTip_FC = 'F')) And
     (LeftStr(fonteDados.fDadosGerais.strClaFis, 1) <> '3') Then
  Begin
    dadosItem.fltBasIcm := 0.0;
    dadosItem.fltAlqIcm := 0.0;
    dadosItem.fltValIcm := 0.0;
    dadosItem.fltPerRed := 0.0;
  End;

  If dadosItem.fltBasRet <= 0.0 Then
  Begin
    dadosItem.fltBasRet := 0.0;
    dadosItem.fltAlqRet := 0.0;
    dadosItem.fltValRet := 0.0;
    dadosItem.fltPRedST := 0.0;
    dadosItem.fltValIva := 0.0;
  End;

  {********************************************************************}
  {* CASO O CLIENTE SEJA NÃO CONTRIBUINTE DE ICMS, NÃO PODE ENVIAR    *}
  {* CST X90. PARA ESSES CASOS, ENVIAR CST 041.                       *}
  {*****************************************************************MV*}

  strVALX90 := fCfgSisFonte(fonteDados, 'VALX90');
  blnVALX90 := (fEmptyStr(strVALX90) Or (strVALX90 = 'S'));

  If (((Not fTemIESUni) And fEmptyStr(fonteDados.fDadosGerais.strIES)) Or (fTemIESUni And fEmptyStr(fonteDados.fDadosGerais.strIES) And (fonteDados.fDadosGerais.strIESUni = 'S'))) Or
     (Pos(fonteDados.fDadosGerais.strCodAti, objConfig.strVS_CliAti) > 0) Then
  Begin
    If (Pos(RightStr(dadosItem.strClaFis, 3), '922_929') > 0) And
       (RightStr(dadosItem.strCodSit, 2) = '90') Then
    Begin

      If (blnVALX90) Then
        dadosItem.strCodSit := LeftStr(dadosItem.strCodSit, 1) + '41';

      {******************************************************************************************}
      {* Pode ter definido o código de benefício na abreviação, por isso a verificação do vazio *}
      {***************************************************************************************RN*}
      if (fEmptyStr(dadosItem.strCdbFis)) and (fCfgSisFonte(fonteDados, 'OBRBEN') = 'S') then
        dadosItem.strCdbFis := fBuscaBeneficioFiscalDaTabelaDefault(fonteDados, dadosItem.strCodSit, fonteDados.fDadosEmitente.strEstado);
    End;
  End;

  {********************************************************************}
  {* "CASO AINDA NAO TENHA SIDO DEFINIDA AS CST DO PIS OU DO COFINS." *}
  {* EXEMPLO: SE NA LIBNFEBD.DLL JA ESTIVER INFORMANDO ESTES VALORES, *}
  {*          OS MESMOS NAO DEVEM SER ALTERADOS...                    *}
  {*****************************************************************JC*}
  If fEmptyStr(dadosItem.strCstPis) Or
     fEmptyStr(dadosItem.strCstCof) Then
  Begin
    {*****************************************}
    {* REGRAS DE PIS E COFINS.               *}
    {**************************************MV*}
    If fSimplesPaulista(fonteDados.fDadosGerais, fonteDados.fDadosEmitente, (fonteDados.fDadosGerais.strTip_FC = 'F')) Then
    Begin
      dadosItem.strCstPis := '99';
      dadosItem.strCstCof := '99';

      dadosItem.fltBasPis := 0.0;
      dadosItem.fltBasCof := 0.0;

      dadosItem.fltAlqPis := 0.0;
      dadosItem.fltAlqCof := 0.0;

      dadosItem.fltValPis := 0.0;
      dadosItem.fltValCof := 0.0;
    End
    Else
    Begin

      If (Pos(dadosItem.strClaFis, objConfig.strClaVen) <= 0) Then
      Begin
        dadosItem.strCstPis := '08';
        dadosItem.strCstCof := '08';

        dadosItem.fltBasPis := 0.0;
        dadosItem.fltBasCof := 0.0;

        dadosItem.fltAlqPis := 0.0;
        dadosItem.fltAlqCof := 0.0;

        dadosItem.fltValPis := 0.0;
        dadosItem.fltValCof := 0.0;
      End
      Else If (dadosItem.blnIncPis) Then
      Begin
        dadosItem.strCstPis :=  '01';
        dadosItem.strCstCof :=  '01';
      End
      Else
      Begin
        dadosItem.strCstPis := '07';
        dadosItem.strCstCof := '07';

        dadosItem.fltBasPis := 0.0;
        dadosItem.fltBasCof := 0.0;

        dadosItem.fltAlqPis := 0.0;
        dadosItem.fltAlqCof := 0.0;

        dadosItem.fltValPis := 0.0;
        dadosItem.fltValCof := 0.0;
      End;
    End;
  End;

  If fEmptyStr(fonteDados.fDadosGerais.strSitIPI) Then
  Begin
    If fonteDados.fDadosGerais.blnIseIpi Then
    Begin
      dadosItem.strCSTIpi := '55';
      pZerarValoresIPI;
    End
  End
  Else
  Begin
    {***********************************************************************}
    {* Força utilização do cadastro de abreviação de IPI para alguns CFOPs *}
    {* Nesse cenário a CST de IPI segue as regras das abreviações de IPI   *}
    {********************************************************************BZ*}
    If (Pos(dadosItem.strClaFis, fStrCfoIPI) <= 0) Then
    Begin
      Case AnsiIndexStr(UpperCase(fonteDados.fDadosGerais.strSitIPI), ['T','I','N','M','S']) of
           integer(sitTributado) : Begin
                                     //---> SEGUE REGRAS DAS ABREVIAÇÕES DE IPI
                                   End;
              integer(sitIsento) : Begin
                                     dadosItem.strCSTIpi := '52';
                                     dadosItem.strEnqIpi := fonteDados.fDadosGerais.strEnqIPI;
                                     pZerarValoresIPI;
                                   End;
        integer(sitNaoTributado) : Begin
                                     dadosItem.strCSTIpi := '53';
                                     dadosItem.strEnqIpi := fonteDados.fDadosGerais.strEnqIPI;
                                     pZerarValoresIPI;
                                   End;
               integer(sitImune) : Begin
                                     dadosItem.strCSTIpi := '54';
                                     dadosItem.strEnqIpi := fonteDados.fDadosGerais.strEnqIPI;
                                     pZerarValoresIPI;
                                   End;
            integer(sitSuspenso) : Begin
                                     dadosItem.strCSTIpi := '55';
                                     dadosItem.strEnqIpi := fonteDados.fDadosGerais.strEnqIPI;
                                     pZerarValoresIPI;
                                   End;
      End;
    End;

  End;


  If fonteDados.fDadosGerais.blnIsPiCo Then
  Begin
    dadosItem.strCstPis := '09';
    dadosItem.strCstCof := '09';

    dadosItem.fltBasPis := 0.0;
    dadosItem.fltBasCof := 0.0;

    dadosItem.fltAlqPis := 0.0;
    dadosItem.fltAlqCof := 0.0;

    dadosItem.fltValPis := 0.0;
    dadosItem.fltValCof := 0.0;
  End;

  If (dadosItem.fltDesEsp < 0) Then
  Begin
    dadosItem.fltDesEsp := Abs(dadosItem.fltDesEsp);
  End;

  strCESTST := fCfgSisFonte(fonteDados, 'CESTST');

  If fEmptyStr(strCESTST) Then
    strCESTST := ENVIA_CEST_PARA_SUBSTITUIDOS;

  If (not fIgnoraConfiguracaoCestST) And (Not fEmptyStr(dadosItem.strCodSit)) And (Not (Pos(dadosItem.strCodSit, CST_SUBSTITUICAO) > 0)) And (strCESTST = ENVIA_CEST_PARA_SUBSTITUIDOS) Then
      dadosItem.strCodigoCEST := '';

  If (fCfgSisFonte(fonteDados, 'VERNFE') = '4.00') And (fonteDados.fDadosGerais.strEspDoc = 'NF') Then
  Begin
    blnCdGTinIgualCodBar := (dadosItem.strCdGTin = dadosItem.strCodBar);

    If (Not fValidaCodBar(dadosItem.strCdGTin)) Then
      dadosItem.strCdGTin := 'SEM GTIN';

    If (blnCdGTinIgualCodBar) Then
      dadosItem.strCodBar := dadosItem.strCdGTin
    Else If (Not fValidaCodBar(dadosItem.strCodBar)) Then
      dadosItem.strCodBar := 'SEM GTIN';
  End
  Else
  Begin
    If Not fValidaCodBar(dadosItem.strCodBar) Then
      dadosItem.strCodBar := '';
  End;

  If ((dadosItem.strCodBar = 'SEM GTIN') Or fEmptyStr(dadosItem.strCodBar)) Then
    dadosItem.strCdGTin := dadosItem.strCodBar;

  If not fUsaUniTri(dadosItem.strClaFis) Then
    dadosItem.strCdGTin := dadosItem.strCodBar;

  If fEquiparaCamposGTIN Then
    dadosItem.strCdGTin := dadosItem.strCodBar;

  strForcaSubTributariaEmDadosPropriosLocal := '';
  If fForcaSubTributariaEmDadosProprios(fonteDados.fDadosGerais.strOpcDoc, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST,
                                        fonteDados.fDadosGerais.blnInconsistenciaEFD_Gravar) Then
    strForcaSubTributariaEmDadosPropriosLocal := 'S';

  If (strForcaSubTributariaEmDadosPropriosLocal <> 'S') And
     fForcaSubTributariaEmDadosPropriosRegraEspecial(fonteDados.fDadosGerais.strOpcDoc, fonteDados.fDadosGerais.strTip_FC, fonteDados.fDadosGerais.strClaFis,
                                                     dadosItem.strCodSit, objConfig.blnSimPau, dadosItem.fltValRet, dadosItem.fltValorFCP, dadosItem.fltValorFCPST) Then
    strForcaSubTributariaEmDadosPropriosLocal := 'S';

  If (strForcaSubTributariaEmDadosPropriosLocal <> 'S') And
     fForcaSubTributariaEmDadosPropriosRegraBrinde(fonteDados.fDadosGerais.strClaFis, dadosItem.fltValRet, (fCfgSisFonte(fonteDados, 'BRI_ST') = 'S')) Then
    strForcaSubTributariaEmDadosPropriosLocal := 'S';

  If Not fImprimeSubTributariaDadosProprios(strForcaSubTributariaEmDadosPropriosLocal) Then
  Begin
    blnDeduziuFCP_ST := False;

    If (dadosItem.fltValRet > 0) And (dadosItem.fltValorFCPST > 0) Then
    Begin
      blnDeduziuFCP_ST := True;
      dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValorFCPST;
      dadosItem.fltBaseFCPST := 0.0;
      dadosItem.fltValorFCPST := 0.0;
      dadosItem.fltPercentualFCPST := 0.0;
    End;

    If fonteDados.fTabelaExiste('MOVICD') Then
    Begin
      If (not blnDeduziuFCP_ST) And (dadosItem.fltValRet > 0) And (dadosItem.fltValorFCP > 0) Then
      Begin
        dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValorFCP;
        dadosItem.fltBaseFCP := 0.0;
        dadosItem.fltValorFCP := 0.0;
        dadosItem.fltPercentualFCP := 0.0;
      End;
    End;

    dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValRet;
    dadosItem.fltBasRet := 0.0;
    dadosItem.fltValRet := 0.0;
  End;

  dadosItem.fltValIpiDadosAdicionais := 0.0;

  If Not fImprimeIPIDadosProprios Then
  Begin
    dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.fltValIpi;
    dadosItem.fltValIpiDadosAdicionais := dadosItem.fltValIpi;
    dadosItem.fltBasIpi := 0.0;
    dadosItem.fltValIpi := 0.0;
  End;

  if (LeftStr(fonteDados.fDadosGerais.strClaFis, 1) = '3') and (Assigned(dadosItem.documentoImportacao)) then
  begin
    If (not fonteDados.GetTemPerfilAduaneiro) and (fCfgSisFonte(fonteDados, 'HODIMP') <> 'S') Then
    begin
      dadosItem.fltDesAce := dadosItem.fltDesAce + dadosItem.documentoImportacao.fltSiscomex;
    end;
  end;

  If fItemCalculaReducaoBaseConfRICMPR(dadosItem) Then
  Begin
    dadosItem.fltBasIcm := (dadosItem.fltTotIte - dadosItem.fltDesEsp);
  End;

  If (fCfgSisFonte(fonteDados, 'USA_RS') = 'S') Then
  Begin
    If (RightStr(dadosItem.strClaFis, 3) = fCfgSisFonte(fonteDados, 'RSICFO')) Or
       (RightStr(dadosItem.strClaFis, 3) = fCfgSisFonte(fonteDados, 'RSRCFO')) Then
    Begin
      dadosItem.strAnotacoes := dadosItem.strDesNes;
    End;
  End;

  Result := dadosItem;

end;

{**************************************************************************************}
{* - QUANDO FOR CFOP DE VENDA, CONTINUAR COMO E´ HOJE, INFORMANDO ESTES VALORES       *}
{*   NOS CAMPOS PROPRIOS, INDEPENDENTE SE A EMPRESA FOR SUBSTITUIDO OU SUBSTITUTO     *}
{*   E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                                        *}
{*   - QUANDO NAO FOR CFOP DE VENDA, PROCEDER DA SEGUINTE FORMA:                      *}
{*     - SE A EMPRESA FOR 1-SUBSTITUÍDO TRIBUTARIO, IMPRIMIR ZERO NOS CAMPOS PROPRIOS *}
{*       PARA ESTES VALORES e INFORMAR NOS DADOS ADICIONAIS OS MESMOS.                *}
{*     - SE A EMPRESA FOR 2-SUBSTITUTO TRIBUTARIO, IMPRIMIR OS VALORES NOS CAMPOS     *}
{*       PROPRIOS E NAO INFORMAR NADA NOS DADOS ADICIONAIS.                           *}
{***********************************************************************************MV*}
function TFonteDadosFormatadorImpl.fImprimeSubTributariaDadosProprios(strForcaSubTributariaEmDadosProprios: String=''): Boolean;
  Var
    strCfgRegSt : String;
    strClaSub : String;
begin
  strCfgRegSt := fCfgRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc);

  If (strCfgRegSt <> 'CLASUB') Then
    strClaSub := fRegimeSubstituicaoTributaria(fonteDados, fonteDados.fDadosGerais.strOpcDoc)
  Else
    strClaSub := objConfig.strClaSub;

  Result := untFuncoesLibNfe.fImprimeSubTributariaDadosProprios(fonteDados.fDadosGerais.strClaFis,
    objConfig.strClaVen, strClaSub, objConfig.blnSimPau, strForcaSubTributariaEmDadosProprios);

  {****************************************************************************************}
  {* BAIXA DE ENTREGA FUTURA: IMPRIME OS VALORES NOS CAMPOS PRÓPRIOS, QUANDO CFG_ENFUOP=2 *}
  {*REQ.144458**************************************************************************RP*}
  If (fonteDados.fDadosGerais.strEntFutOpc = '2') And
     ((RightStr(fonteDados.fDadosGerais.strClaFis,3) = '117') Or (RightStr(fonteDados.fDadosGerais.strClaFis,3) = '116')) Then
    Result := True;
end;

function TFonteDadosFormatadorImpl.fInformacoesMadeira(
  dadosItem: TDadosItem): String;
  Var
    strApaBen: String;
    strCasaDecimalVidro: String;
    strInfMed : String;
begin
  Result := '';
  strCasaDecimalVidro := fCfgSisFonte(fonteDados, 'DECVID');
  strInfMed           := fCfgSisFonte(fonteDados, 'INFMED');

  If ((fEmptyStr(strCasaDecimalVidro)) And (fEmptyStr(strInfMed))) Then
  begin
    strCasaDecimalVidro := 'S';
    strInfMed           := '1';
  end;

  If Assigned(dadosItem.dadosMadeira) And (dadosItem.dadosMadeira.fltQtdPec > 0) Then
  Begin
    With dadosItem.dadosMadeira Do
    Begin
      strApaBen := '';

      If objConfig.blnVenMad Then
      Begin
        If strAparel = 'S' Then strApaBen := strApaBen + '/APARELHADA';
        If strBenefi = 'S' Then strApaBen := strApaBen + '/BENEFICIADA';

        If Not fEmptyStr(strApaBen) Then
          System.Delete(strApaBen, 1, 1);

        Result := 'QTD.: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 00 ) + ' ' +
                  'COMP.: '  + FloatToStrF( fltComPec, ffFixed, 12, 05 ) + ' ' +
                  'LARG.: '  + FloatToStrF( fltLarPec, ffFixed, 12, 05 ) + ' ' +
                  'ESPES.: ' + FloatToStrF( fltEspPec, ffFixed, 12, 05 ) + ' ' + strApaBen;
      End
      Else If objConfig.blnVenMtl Then
      Begin
        Result := FloatToStrF( fltQtdPec, ffFixed, 12, 5 ) + ' PECAS DE ' +
                  FloatToStrF( fltComPec, ffFixed, 12, 5 ) + ' MTS = ' +
                  FloatToStrF( fltQtdPec * fltComPec, ffFixed, 12, 5 );
      End
      Else
      Begin
        Result := 'QTD: '   + FloatToStrF( fltQtdPec, ffFixed, 12, 00 ) + ' ' +
                  'L: '  + FloatToStrF( fltLarPec, ffFixed, 12, IIF(strCasaDecimalVidro = 'S',05,00)) + ' ' +
                  IIF(strInfMed = '1','A: ','C: ') + FloatToStrF( fltComPec, ffFixed, 12, IIF(strCasaDecimalVidro = 'S', 05, 00)) + ' '+
                  'Qtd.Peç: ' + FloatToStrF( fltQtdPec, ffFixed, 12, 5 ) + ' '+
                  'Vr.Unt.Peç: ' + FloatToStrF( iif((dadosItem.fltTotIte > 0) and (fltQtdPec > 0), dadosItem.fltTotIte / fltQtdPec, 0), ffFixed, 12, 5 ) + ' ';
      End;
    End;
  End;

End;

function TFonteDadosFormatadorImpl.fItemCalculaReducaoBaseConfRICMPR(
  dadosItem: TDadosItem): Boolean;
begin
  Result := (objConfig.blnRIcmPr) And
            (dadosItem.fltValIcm > 0) And
            (dadosItem.strCodSit = '090') And
            (fonteDados.fDadosGerais.strCliCon = 'N') And
            (Not fEmptyStr(fonteDados.fDadosGerais.strIES)) And
            (fEmptyStr(dadosItem.strRICMPR));
end;

function TFonteDadosFormatadorImpl.fItemCalculaReducaoBaseConfRICMPRMsg(dadosItem: TDadosItem): Boolean;
begin
  Result := (objConfig.blnRIcmPr) And
            (dadosItem.fltValIcm > 0) And
            (fonteDados.fDadosGerais.strCliCon = 'N') And
            (fonteDados.fDadosGerais.strEstado = fonteDados.fDadosEmitente.strEstado) And
            (Not fEmptyStr(fonteDados.fDadosGerais.strIES));
  If Result Then
  Begin
    Result := ( (Pos(RightStr(dadosItem.strCodSit, 2), '10_60_70_30_90_') > 0) And (dadosItem.strRIcmPRAbf = 'S') ) Or
              (RightStr(dadosItem.strCodSit, 2) = '51');
  End;
end;

function TFonteDadosFormatadorImpl.fClienteComIdentificacaoValida(
  const ADadosGerais: TDadosGerais): Boolean;
begin
  Result := False;
  If (fEmptyStr(ADadosGerais.strCnpj)) Then
    Exit;
  If fStringRepetida(ADadosGerais.strCnpj) Then
    Exit;
  If (Not fValidaCnpjCpf(ADadosGerais.strCnpj, fonteDados)) Then
    Exit;
  If (fCfgSisFonte(fonteDados, 'NFPCLI') = 'S') And ((ADadosGerais.strOpcDoc = 'CF') Or (ADadosGerais.strOpcDoc = '11')) And (Not fEmptyStr(ADadosGerais.strNotPau)) And (ADadosGerais.strNotPau = 'N') Then
    Exit;
  Result := True;
end;

function TFonteDadosFormatadorImpl.fDeveLimparEmailClienteConsumidor(const ADadosGerais : TDadosGerais): Boolean;
  Var
    strENVSCE : String;
begin
  Result := False;

  If (ADadosGerais.strEspDoc <> 'IF') Then
    Exit;

  If (Not Assigned(fonteDados)) Then
    Exit;

  strENVSCE := fCfgSisFonte(fonteDados, 'ENVSCE');

  If (fEmptyStr(strENVSCE)) Or (strENVSCE = 'S') Then
    Exit;

  If fClienteComIdentificacaoValida(ADadosGerais) Then
    Exit;

  Result := True;
end;

function TFonteDadosFormatadorImpl.fMostrarCondicaoPagamentoEmDadosAdicionais(const ADadosGerais : TDadosGerais; AblnCdpNfe, AblnInconsistenciaEFD_Gravar: Boolean; AstrCondPagamento, AstrClaFis: String): Boolean;
begin
  Result := False;

  If (ADadosGerais.strOpcDoc = 'CA') Then
    Exit;

  If (Not AblnCdpNfe) Then
    Exit;

  If (fEmptyStr(AstrCondPagamento)) Then
    Exit;

  If (AblnInconsistenciaEFD_Gravar) Then
    Exit;

  If (Pos(RightStr(AstrClaFis,3), '116_117_') > 0) Then
    Exit;

  Result := True;
end;

function TFonteDadosFormatadorImpl.fImprimeIPIDadosProprios: Boolean;
begin
  Result := untFuncoesLibNfe.fImprimeIPIDadosProprios(fonteDados.fDadosGerais.strClaFis,
    objConfig.strClaVen, objConfig.strOpcImpValIpi, objConfig.blnConIpi,
    fonteDados.fDadosGerais.blnInconsistenciaEFD_Gravar);

  {****************************************************************************************}
  {* BAIXA DE ENTREGA FUTURA: IMPRIME OS VALORES NOS CAMPOS PRÓPRIOS, QUANDO CFG_ENFUOP=2 *}
  {*REQ.144458**************************************************************************RP*}
  If (fonteDados.fDadosGerais.strEntFutOpc = '2') And
     ((RightStr(fonteDados.fDadosGerais.strClaFis,3) = '117') Or (RightStr(fonteDados.fDadosGerais.strClaFis,3) = '116')) Then
    Result := True;
end;

function TFonteDadosFormatadorImpl.fNotaImportacao: Boolean;
begin
  Result := (LeftStr(fonteDados.fDadosGerais.strClaFis, 1)='3');
end;

function TFonteDadosFormatadorImpl.fTemDados: Boolean;
begin
  Result := fonteDados.fTemDados;
end;

procedure TFonteDadosFormatadorImpl.pRetInformacoesAdicionaisNotImp;
  Var
    strMsg: String;
    dadosGerais: TDadosGerais;
Begin
  dadosGerais := fonteDados.fDadosGerais;
  strMsg := '';
  strMsg := strMsg + 'Mercadorias....................' + fPadL(FloatToStrF(dadosGerais.fltImpMer, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Frete e seguro internacional...' + fPadL(FloatToStrF(dadosGerais.fltImpSeg, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Base Imposto de Importação.....' + fPadL(FloatToStrF(dadosGerais.fltBaseII, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Imposto de Importação..........' + fPadL(FloatToStrF(dadosGerais.fltImpImp, ffNumber, 15, 2), 15) + '#';

  If fonteDados.fCampoExiste('CADFIS', 'FIS_VAFRMM') Then
    strMsg := strMsg + 'Marinha Mercante (AFRMM).......' + fPadL(FloatToStrF(dadosGerais.fltVaFRMM, ffNumber, 15, 2), 15) + '#';

  strMsg := strMsg + 'Despesas Aduaneiras............' + fPadL(FloatToStrF(dadosGerais.fltDesAdu, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Valor do IOF...................' + fPadL(FloatToStrF(dadosGerais.fltValIOF, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Valor dos Produtos.............' + fPadL(FloatToStrF(dadosGerais.fltImpPro, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'Taxa do SISCOMEX...............' + fPadL(FloatToStrF(dadosGerais.fltImpTax, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'PIS/PASEP......................' + fPadL(FloatToStrF(dadosGerais.fltImpPis, ffNumber, 15, 2), 15) + '#';
  strMsg := strMsg + 'COFINS.........................' + fPadL(FloatToStrF(dadosGerais.fltImpCof, ffNumber, 15, 2), 15) + '#';

  If (dadosGerais.fltValAdp > 0) Then
    strMsg := strMsg + 'Taxa Antidumping...............' + fPadL(FloatToStrF(dadosGerais.fltValAdp, ffNumber, 15, 2), 15) + '#';

  If Not fEmptyStr(dadosGerais.strImpIC1) Then
    strMsg := strMsg + 'ICMS:' + dadosGerais.strImpIC1 + '#';
  If Not fEmptyStr(dadosGerais.strImpIC2) Then
    strMsg := strMsg + dadosGerais.strImpIC2 + '#';

  dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + strMsg;

  If Not fEmptyStr(dadosGerais.strMen001) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen001 + '#';

  If Not fEmptyStr(dadosGerais.strMen002) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen002 + '#';

  If Not fEmptyStr(dadosGerais.strMen003) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen003 + '#';

  If Not fEmptyStr(dadosGerais.strMen004) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen004 + '#';

  If Not fEmptyStr(dadosGerais.strMen005) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen005 + '#';

End;

procedure TFonteDadosFormatadorImpl.pSetaFonteDados(fonte: IFonteDados);
begin
  fonteDados := fonte;
end;

procedure TFonteDadosFormatadorImpl.pSetarAnotacoesDadosItem(AValue: string; dadosItem: TDadosItem);
begin
  if fEmptyStr(AValue) then
    exit;

  if not fEmptyStr(dadosItem.strAnotacoes) Then
    dadosItem.strAnotacoes := dadosItem.strAnotacoes + ' - ' + AValue
  else
    dadosItem.strAnotacoes := AValue;
end;

procedure TFonteDadosFormatadorImpl.pFormataDadosDestinatario;
  Var
    strCliEnd: String;
    posNum: Integer;
    posCom: Integer;
    recCliEnd: TRecCliEnd;
begin
  fonteDados.fDadosGerais.strCnpj := fLimpaCaracteres(fonteDados.fDadosGerais.strCnpj);

  If (objConfigInterna.strNFSeSemCpf = 'S') And
     (fonteDados.fDadosGerais.strEspDoc = 'NS') And
     (fStringRepetida(fonteDados.fDadosGerais.strCnpj)) Then
  Begin
    fonteDados.fDadosGerais.strCnpj := '';
  End;

  With fonteDados.fDadosGerais Do
  Begin
    If objConfig.blnCclNfe And (Pos(strCodCli, strNomCli) <= 0)  Then
      strNomCli := Copy(strNomCli,1,51) + IIF(fEmptyStr(strNomCli), '', ' ') + strCodCli
    Else if Not objConfig.blnCclNfe Then
      strNomCli := Copy(strNomCli,1,60);
  End;

  {*****************************************}
  {* ENDEREÇO. TIRA O NÚMERO E O COMPLEMEN-*}
  {* QUE POR ACASO ESTEJA CONCATENADO NO   *}
  {* NOME DA RUA.                          *}
  {**************************************MV*}

  If Trim(UpperCase(fonteDados.fDadosGerais.strLogradouro)) = Trim(UpperCase(fonteDados.fDadosGerais.strComplementoEnd)) Then
    fonteDados.fDadosGerais.strComplementoEnd := '';

  strCliEnd := fonteDados.fDadosGerais.strLogradouro;

  posNum := Pos(fonteDados.fDadosGerais.strNumeroEnd, strCliEnd);
  If (posNum > 0) And (fonteDados.fDadosGerais.strNumeroEnd <> '0') Then
  Begin
    If (Trim(Copy(strCliEnd, posNum, Length(Trim(fonteDados.fDadosGerais.strNumeroEnd)) + 1)) = fonteDados.fDadosGerais.strNumeroEnd) Then
      Delete(strCliEnd, posNum, Length(fonteDados.fDadosGerais.strNumeroEnd));
  End;

  posCom := Pos(fonteDados.fDadosGerais.strComplementoEnd, strCliEnd);
  If (posCom > 0) Then
    Delete(strCliEnd, posCom, Length(fonteDados.fDadosGerais.strComplementoEnd));

  If fEmptyStr(fonteDados.fDadosGerais.strNumeroEnd) Then
  Begin
    recCliEnd := fGetParteEndereco(fonteDados.fDadosGerais.strLogradouro);

    If (Not fEmptyStr(recCliEnd.strNumero)) And (fonteDados.fDadosGerais.strConsum = 'S') Then
    Begin
      strCliEnd                                 := recCliEnd.strLograd;
      fonteDados.fDadosGerais.strNumeroEnd      := recCliEnd.strNumero;
      fonteDados.fDadosGerais.strComplementoEnd := recCliEnd.strComple;
    End
    Else
    Begin
      fonteDados.fDadosGerais.strNumeroEnd := '0';
    End;
  End;

  If fEmptyStr(fonteDados.fDadosGerais.strIDEstrangeiro) Then
    fonteDados.fDadosGerais.strIDEstrangeiro := '00000';

  strCliEnd := Trim(strCliEnd);
  While (Not fEmptyStr(strCliEnd)) And {$IF CompilerVersion >= 20.0}CharInSet(RightStr(strCliEnd,1)[1], ['-',',']){$ELSE}(RightStr(strCliEnd,1)[1] in ['-',',']){$IFEND} Do
  Begin
    Delete(strCliEnd, Length(strCliEnd), 1);
    strCliEnd := Trim(strCliEnd);
  End;
  fonteDados.fDadosGerais.strLogradouro := strCliEnd;

  fonteDados.fDadosGerais.strCEP      := fLimpaCaracteres(fonteDados.fDadosGerais.strCEP);
  fonteDados.fDadosGerais.strTelefone := fLimpaCaracteresTelefone(fonteDados.fDadosGerais.strTelefone);
  fonteDados.fDadosGerais.strIES      := fLimpaCaracteres(fonteDados.fDadosGerais.strIES);

  If (Length(fonteDados.fDadosGerais.strTelefone) < 6) Then
    fonteDados.fDadosGerais.strTelefone := '';

  If ((fEmptyStr(fonteDados.fDadosGerais.strIES)) Or (fonteDados.fDadosGerais.strIES = '0')) And (Length(fonteDados.fDadosGerais.strCnpj) >= 12) Then
  Begin
    fonteDados.fDadosGerais.strIES := 'ISENTO';

    If (fonteDados.fDadosGerais.strIESUni = 'S') Then
      fonteDados.fDadosGerais.strIES := '';
  End;

  If (Not fEmptyStr(fonteDados.fDadosGerais.strEmail2)) Then
  Begin
    If (fEmptyStr(fonteDados.fDadosGerais.strEmail)) Then
      fonteDados.fDadosGerais.strEmail := fonteDados.fDadosGerais.strEmail2
    Else
    Begin
      fonteDados.fDadosGerais.strEmail := fonteDados.fDadosGerais.strEmail + ';' + fonteDados.fDadosGerais.strEmail2;
    End;

    fonteDados.fDadosGerais.strEmail2 := '';
  End;

  if (fCfgSisFonte(fonteDados, 'EMATRA') <> 'S') And (Not fEmptyStr(fonteDados.fDadosGerais.strEmaTra)) Then
    fonteDados.fDadosGerais.strEmaTra := '';

  if (fCfgSisFonte(fonteDados, 'EMATRR') <> 'S') And (Not fEmptyStr(fonteDados.fDadosGerais.strEmaTrr)) Then
    fonteDados.fDadosGerais.strEmaTrr := '';
end;

procedure TFonteDadosFormatadorImpl.pRecalculaIcmsParaEstadoDestino(
  dadosItem: TDadosItem);
  Var
    strSQL: String;
    dataSetAbf: TDataSet;
    dataCadIte: TDataSet;
    fltFatorBaseTotIte: Double;
    fltBaseIcmsDiretaOriginal: Double;

    strCstOriginal: String;
begin
  If fonteDados.fCampoExiste('CADABF', 'ABF_SITDIF') Then
  Begin
    Exit;
  End;

  If (objConfig.blnSimPau) And (Pos(RightStr(dadosItem.strCodSit, 2), '10,30,60,70') > 0) Then
  Begin
    dadosItem.strCodSit := LeftStr(dadosItem.strCodSit, 1) + '00';
    Exit;
  End;

  If (objConfig.blnSimPau) Then
  Begin
    Exit;
  End;

  strCstOriginal := dadosItem.strCodSit;

  If fCfgSisFonte(fonteDados, 'TIPABF') = '1' Then
  Begin
    dataCadIte := fonteDados.fExecutaQuery('SELECT ITE_CODABF FROM CADITE WHERE ITE_CODITE = :CODITE',
      ['CODITE'], [dadosItem.strCodIteOriginal]);
  End
  Else
  Begin
    dataCadIte := fonteDados.fExecutaQuery('SELECT ITE_CODABF FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP',
      ['CODITE', 'CODEMP'], [dadosItem.strCodIteOriginal, fonteDados.fDadosGerais.strCodEmp]);
  End;

  strSQL := 'SELECT * FROM CADABF WHERE ABF_CODABF = :CODABF AND ABF_ESTADO IN(:ESTORI, :ESTDES)';
  dataSetAbf := fonteDados.fExecutaQuery(strSQL,
    ['CODABF', 'ESTORI', 'ESTDES'],
    [dataCadIte.FieldByName('ITE_CODABF').AsString, fonteDados.fDadosEmitente.strEstado, fonteDados.fDadosGerais.strEstado]);

  {**************************************************************}
  {* CALCULA A BASE DE ICMS CONSIDERANDO APENAS O TOTITE-DESESP *}
  {***********************************************************MV*}
  dataSetAbf.Locate('ABF_ESTADO', fonteDados.fDadosEmitente.strEstado, []);
  fltBaseIcmsDiretaOriginal := fFormataFloat((dadosItem.fltTotIte-dadosItem.fltDesEsp) * dataSetAbf.FieldByName('ABF_BASE_S').AsFloat / 100, 2);

  {***************************************************************}
  {* CALCULA UM FATOR ENTRE A BASE GRAVADA E A BASE SIMPLIFICADA *}
  {* É NECESSÁRIO POIS A BASE DE ICMS PODE VIR ADICIONADA DE AL- *}
  {* GUM VALOR COMO O IPI POR EXEMPLO.                           *}
  {************************************************************MV*}
  fltFatorBaseTotIte := 1;
  If (dadosItem.fltBasIcm > (fltBaseIcmsDiretaOriginal)) And (fltBaseIcmsDiretaOriginal > 0) Then
  Begin
    fltFatorBaseTotIte := (dadosItem.fltBasIcm / fltBaseIcmsDiretaOriginal);
  End;

  fonteDados.fDadosGerais.fltBasIcm := fonteDados.fDadosGerais.fltBasIcm - dadosItem.fltBasIcm;
  fonteDados.fDadosGerais.fltTotIcm := fonteDados.fDadosGerais.fltTotIcm - dadosItem.fltValIcm;

  {*************************************************************}
  {* RECALCULA O ICMS COM BASE NOS DADOS DO ESTADO DE DESTINO. *}
  {**********************************************************MV*}
  dataSetAbf.Locate('ABF_ESTADO', fonteDados.fDadosGerais.strEstado, []);

//  dadosItem.fltBaseCalculoReduzidaDestino := dataSetAbf.FieldByName('ABF_BASESF').AsFloat;
//
//  {**********************************************************}
//  {* CALCULA A BASE DE ICMS REDUZIDA NO ESTADO DE DESTINO,  *}
//  {* CONSIDERANDO A BASE PARA CONSUMIDOR FINAL (FRANKSON DA *}
//  {* GURGEL QUE FALOU).                                     *}
//  {*******************************************************MV*}
//  dadosItem.fltBaseCalculoReduzidaDestino := (dadosItem.fltTotIte-dadosItem.fltDesEsp) *
//                                             dadosItem.fltBaseCalculoReduzidaDestino / 100 *
//                                             fltFatorBaseTotIte;
//  dadosItem.fltBaseCalculoReduzidaDestino := fFormataFloat(dadosItem.fltBaseCalculoReduzidaDestino, 2);

  dadosItem.fltBasIcm := (dadosItem.fltTotIte-dadosItem.fltDesEsp);
  If Pos(RightStr(strCstOriginal, 2), '10,30,60,70') > 0 Then
  Begin
    dadosItem.fltBasIcm := dadosItem.fltBasIcm + dadosItem.fltTotFre + dadosItem.fltDesAce;
  End;
  dadosItem.fltBasIcm := dadosItem.fltBasIcm * dataSetAbf.FieldByName('ABF_BASE_S').AsFloat / 100;

  dadosItem.fltBasIcm := fFormataFloat(dadosItem.fltBasIcm * fltFatorBaseTotIte, 2);
  dadosItem.fltPerRed := 100 - dataSetAbf.FieldByName('ABF_BASE_S').AsFloat;

  dadosItem.fltAlqIcm := dataSetAbf.FieldByName('ABF_ALQ__S').AsFloat;
  dadosItem.fltValIcm := fFormataFloat(dadosItem.fltBasIcm * dadosItem.fltAlqIcm / 100, 2);

  If dataSetAbf.FindField('ABF_SITCON') <> Nil Then
  Begin
    dadosItem.strCodSit := dataSetAbf.FieldByName('ABF_SITCON').AsString;
  End
  Else
  Begin
    dadosItem.strCodSit := dataSetAbf.FieldByName('ABF_CODSIT').AsString;
  End;

  fonteDados.fDadosGerais.fltBasIcm := fonteDados.fDadosGerais.fltBasIcm + dadosItem.fltBasIcm;
  fonteDados.fDadosGerais.fltTotIcm := fonteDados.fDadosGerais.fltTotIcm + dadosItem.fltValIcm;
end;

procedure TFonteDadosFormatadorImpl.pRetInformacoesAdicionais;

  Type
    TDadosONU = record
      strCodOnu: String;
      strDesOnu: String;
      strCodigo: String;
      strClaRis: String;
      strGruEmb: String;
      fltPesTot: Double;
    end;

  Var
    intCont: Integer;
    arrAbf: Array Of Array [1..2] Of String;
    dadosItem: TDadosItem;
    dadosGerais: TDadosGerais;
    arrLegendONU: Array Of TDadosONU;
    fltPerImpPag: Double;
    intQtdNps : Integer;
    strMsgAdicionalFiscal: String;
    intQtdeSelos: Integer;

  Const
    strOutrasClaFisMsg: String = '_1926_1904_';

  function procuraAbd(strMenAbf: String): Boolean;
    Var
      i: Integer;
  Begin

    For i := Low(arrAbf) To High(arrAbf) Do
    Begin
      If (arrAbf[i][2] = strMenAbf) Then
      Begin
        Result := True;
        Exit;
      End;
    End;

    Result := False;
  End;

  function fGetIndexONU(strCodOnu: String): Integer;
    Var
      intIndex: Integer;
  begin
    Result := -1;
    For intIndex := 0 To Length(arrLegendONU) -1 Do
    Begin
      If arrLegendONU[intIndex].strCodOnu = strCodOnu Then
      Begin
        Result := intIndex;
        Break;
      End;
    End;
  end;

  procedure pAddLegendONU(strCodOnu, strDesOnu, strCodigo, strClaRis, strGruEmb: String; fltPesTot: Double);
  begin
    If fGetIndexONU(strCodOnu) = -1 Then
    Begin
      SetLength(arrLegendONU, Length(arrLegendONU) + 1);
      arrLegendONU[Length(arrLegendONU) -1].strCodOnu := strCodOnu;
      arrLegendONU[Length(arrLegendONU) -1].strDesOnu := strDesOnu;
      arrLegendONU[Length(arrLegendONU) -1].strCodigo := strCodigo;
      arrLegendONU[Length(arrLegendONU) -1].strClaRis := strClaRis;
      arrLegendONU[Length(arrLegendONU) -1].strGruEmb := strGruEmb;
      arrLegendONU[Length(arrLegendONU) -1].fltPesTot := fltPesTot;
    End
    Else
      arrLegendONU[fGetIndexONU(strCodOnu)].fltPesTot :=
        arrLegendONU[fGetIndexONU(strCodOnu)].fltPesTot + fltPesTot;
  end;

  function fMsgImpostoNaNota(strClaFis: String): Boolean;
  begin
    Result := Pos(strClaFis, objConfig.strClaVen) > 0;

    If (Not Result) And (objConfig.blnImpCif) Then
      Result := Pos(RightStr(strClaFis, 3), objConfig.strClaCif) > 0;

  end;

  function fInsereMsgDescICMSOrgaoPublico: Boolean;
  begin
    Result := (dadosGerais.blnOrgPub)                          And  // ORGÃO PÚBLICO
              (dadosGerais.blnCalIcm)                          And  // CALCULA DESCONTO DE ICMS
              (SameText(dadosGerais.strOrPuRD, 'D'))           And  // DESCONTO ESPECIAL.
              (dadosGerais.fltIcmOrg > 0)                      And  // ICMS DE ORGÃO PÚBLICO
              (dadosGerais.fltDesEsp >= dadosGerais.fltIcmOrg);     // VERIFICA SE FOI DADO DESCONTO ESPECIAL NO VALOR DO ICMS.
  end;

  function fInsereMsgDescICMSDesonerado: Boolean;
  Begin
    Result := False;

    If (dadosGerais.strZonFra = 'S') And (dadosGerais.strDesZon = 'S') Then
      Exit;

    Result := dadosGerais.fltVrdIcm > 0;
  End;

  procedure pSetaChaveRefMsgAdicionais;
    Var
      intIndice: Integer;
      docRef: TChaveReferenciada;
  Begin
    If (Length(dadosGerais.arrChavesReferenciadas) > 0) Then
    Begin
      If (Not fEmptyStr(dadosGerais.arrChavesReferenciadas[0].strChaveAcessoNfe)) Then
        dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + 'Chave de Acesso da(s) NF-e estornada(s): ';

      For intIndice := Low(dadosGerais.arrChavesReferenciadas) To High(dadosGerais.arrChavesReferenciadas) Do
      Begin
        docRef := dadosGerais.arrChavesReferenciadas[intIndice];
        dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
                                          docRef.strChaveAcessoNfe + '#';
      End;
    End;
  End;

  procedure pMensagemCBS_IBS;
  begin

    If not Assigned(dadosGerais.ReformaTributariaTotal) Then
      Exit;

    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + ' Vlr.CBS R$ '     + FloatToStrF(dadosGerais.ReformaTributariaTotal.fltValorTotalCBS,     ffNumber, 12, 2)+
                                                                       ' Vlr.IBS UF R$ '  + FloatToStrF(dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_UF,  ffNumber, 12, 2)+
                                                                       ' Vlr.IBS MUN R$ ' + FloatToStrF(dadosGerais.ReformaTributariaTotal.fltValorTotalIBS_MUN, ffNumber, 12, 2)+ '#' ;
  end;

begin
  SetLength(arrAbf, 0);
  SetLength(arrLegendONU, 0);
  fonteDados.pInicio;
  strMsgAdicionalFiscal := '';

  dadosGerais := fonteDados.fDadosGerais;

  While (fonteDados.fTemDados) Do
  Begin
    dadosItem := fonteDados.fProximoItem;
    If (Not procuraAbd(dadosItem.strMen__S) And (Not fEmptyStr(dadosItem.strMen__S))) Then
    Begin
      SetLength(arrAbf, Length(arrAbf) + 1);
      arrAbf[Length(arrAbf) - 1][1] := dadosItem.strCodAbf;
      arrAbf[Length(arrAbf) - 1][2] := dadosItem.strMen__S;
    End;

    If objConfig.blnClaOnu And (Not fEmptyStr(dadosItem.strCodOnu)) Then
    Begin
      pAddLegendONU(dadosItem.strCodOnu, dadosItem.strDesOnu, dadosItem.strCodigo, dadosItem.strClaRis,
        dadosItem.strGruEmb, dadosItem.fltTotPes);
    End;
  End;

  If (dadosGerais.strEspDoc <> 'NS') And (not objConfigInterna.blnZeraIBPT) And (not objConfigInterna.blnImpIBP) Then
  Begin
    If ((dadosGerais.fltFedImp <> 0.00) Or
        (dadosGerais.fltEstImp <> 0.00) Or
        (dadosGerais.fltMunImp <> 0.00))                         And
       ((dadosGerais.fltTotPro - dadosGerais.fltDesEsp) <> 0.00) And
        (dadosGerais.fNotaSaida)                                 And
        (objConfigInterna.strImpPag = '2')                       And
        (fMsgImpostoNaNota(dadosGerais.strClaFis))               Then
    Begin
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + 'Vlr Aprox dos Tributos: ' +
        IIF(dadosGerais.fltFedImp <> 0.00, 'R$ ' + FormatFloat('#,##0.00', dadosGerais.fltFedImp) + ' Federal ', '') +
        IIF(dadosGerais.fltEstImp <> 0.00, ' / R$ ' + FormatFloat('#,##0.00', dadosGerais.fltEstImp) + ' Estadual ', '') +
        IIF(dadosGerais.fltMunImp <> 0.00, ' / R$ ' + FormatFloat('#,##0.00', dadosGerais.fltMunImp) + ' Municipal ', '') +
        '- Fonte: IBPT' + '#';
    End
    Else
    Begin
      fltPerImpPag := 0.00;

      If (dadosGerais.fltImpPag <> 0.00) And ((dadosGerais.fltTotPro - dadosGerais.fltDesEsp) <> 0.00) Then
        fltPerImpPag := dadosGerais.fltImpPag / (dadosGerais.fltTotPro - dadosGerais.fltDesEsp) * 100.00;

      If (fltPerImpPag <> 0.00) And (dadosGerais.fNotaSaida) And (fMsgImpostoNaNota(dadosGerais.strClaFis)) Then
        dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
          'Vlr Aprox do Tributo "R$ ' + FormatFloat('#,##0.00', dadosGerais.fltImpPag) +
          '(' + FormatFloat('#,##0.00', fltPerImpPag) +
          IIF(objConfigInterna.strImpPag = '2','%) Fonte: IBPT"','%)"') + '#';
    End;
  End;

  If dadosGerais.blnEst_Dv Then
    pSetaChaveRefMsgAdicionais;

  If objConfig.blnVendad And (Not dadosGerais.blnNfComp) And (Not dadosGerais.blnInconsistenciaEFD_Gravar) And (dadosGerais.strOpcDoc <> 'CA') Then
  Begin
    If objConfig.blnAutCen Then
    Begin
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Vendedor: ' + dadosGerais.strNomVen + '#'; // JÁ CONCATENADO COM CODVEN
    End
    Else
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Vendedor: ' + dadosGerais.strCodVen + ' - ' + dadosGerais.strNomVen + '#';

    If objConfig.blnAgrDoc Then
    Begin
      If Not fEmptyStr(dadosGerais.strVendedorOriginalPedido) Then
        dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strVendedorOriginalPedido + '#';

      If Not fEmptyStr(dadosGerais.strVendedorOriginalDocumentos) Then
        dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strVendedorOriginalDocumentos + '#';
    End;

  End;

  If (dadosGerais.fNotaSaida) And (fGanhouNetpoints(fonteDados, intQtdNps)) Then
  Begin
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        //'Parabéns! Você ganhou ' + IntToStr(intQtdNps) + ' NETPOINTS nesta compra.' + '#';
        Format(MSG_NETPOINTS, [IntToStr(intQtdNps)]) + '#';
  End;

  If (fCfgSisFonte(fonteDados, 'CPPMSG')='S') then
  begin
    If (dadosGerais.fNotaSaida) And (fNfeInfAdicQtdeSelos(fonteDados, intQtdeSelos)) Then
    Begin
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Quantidade de selos = ' + IntToStr(intQtdeSelos) + '#';
    End;
  end;

  If objConfigInterna.blnNFeDig And (Not fEmptyStr(dadosGerais.strCodDig)) And (Not dadosGerais.blnNfComp) And (dadosGerais.strOpcDoc <> 'CA') Then
  Begin
    If objConfig.blnAutCen Then
    Begin
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Digitador: ' + dadosGerais.strNomDig + '#'; // JÁ CONCATENADO COM CODDIG
    End
    Else
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Digitador: ' + dadosGerais.strCodDig + ' - ' + dadosGerais.strNomDig + '#';
  End;

  If (dadosGerais.strSitP_C <> 'T') And (Not fEmptyStr(dadosGerais.strMenP_C)) Then
  Begin
    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + dadosGerais.strMenP_C + '#';
  End
  Else
  Begin
    If dadosGerais.blnIsPiCo Then
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
        'SUSPENSÃO DE COFINS E PIS CONFORME ARTIGO 40 DA LEI 10865 DE 30/04/2004, ARTIGO 6° DA LEI 10925 DE 23/07/2004 E IN SRF N° 595 DE 27/12/2005.' + '#';
  End;

  If (dadosGerais.strSitIPI <> 'T') And (Not fEmptyStr(dadosGerais.strMenIPI)) Then
  Begin
    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + dadosGerais.strMenIPI + '#';
  End
  Else
  Begin
    If dadosGerais.blnIseIpi Then
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
        'SUSPENSÃO DE IPI CONFORME ARTIGO 29 LEI 10637 DE 30/12/2002, ARTIGO 21 E PARÁGRAFOS 1° A 3° I.N. N° 948 DE 15/06/2009 E ARTIGO 46 DO DECRETO 7212 DE 15/06/2010.' + '#';
  End;

  If fMostrarCondicaoPagamentoEmDadosAdicionais(dadosGerais, objConfig.blnCdpNfe, dadosGerais.blnInconsistenciaEFD_Gravar, dadosGerais.strCondPagamento, dadosGerais.strClaFis) Then
    dadosGerais.strMsgAdicionalCom :=  dadosGerais.strMsgAdicionalCom + 'Cond.Pag: ' + dadosGerais.strCondPagamento + ' - ' + dadosGerais.strDesCondPagamento + '#';

  If (dadosGerais.strStReEs = 'S') Then
  Begin
    If Pos(dadosGerais.strClaFis, fTransform(fCfgSisFonte(fonteDados, 'CLAVEN'), 4)) > 0 Then
      dadosGerais.strMsgAdicionalFis :=  dadosGerais.strMsgAdicionalFis + fRetornaMensagemAdicionalFiscal + '#';

    If Not fEmptyStr(dadosGerais.strPrStRe) Then
      dadosGerais.strMsgAdicionalFis :=  dadosGerais.strMsgAdicionalFis + 'PROCESSO: ' + dadosGerais.strPrStRe + '#';
  End;

  If Not fEmptyStr(dadosGerais.strInfAdEnt) Then
    dadosGerais.strMsgAdicionalCom :=  dadosGerais.strMsgAdicionalCom + dadosGerais.strInfAdEnt;

  If fInsereMsgDescICMSOrgaoPublico Then
  Begin
    If dadosGerais.strEstado = 'RJ' Then
    Begin
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + 'OPERAÇÃO BENEFICIADA COM ISENÇÃO DO ICMS NOS TERMOS DO CONVÊNIO ICMS 26/03. ' +
        'VALOR DISPENSADO DE R$ ' + FormatFloat('#,##0.00', dadosGerais.fltIcmOrg) + ' (' + fRetExtensoNumero(floatToStr(dadosGerais.fltIcmOrg)) + ').' + '#'
    End
    Else
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + 'OPERAÇÃO BENEFICIADA COM A ISENÇÃO DO ICMS NOS TERMOS DO ARTIGO 55,  ANEXO I DO RICMS.' + '#';
  End;

  If (dadosGerais.strBeneficioREIDI = 'S') And (dadosGerais.fltDesEsp > 0) Then
  Begin
    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
      'Venda efetuada com suspensão da exigibilidade da contribuição para o PIS/PASEP e da COFINS, conforme Art 3º ' +
      'da Lei 11.488 de 15/06/2007 e Art. 2º da IN 758 de 25/07/2007. Desconto concedido de R$ ' +
      FormatFloat('#,##0.00', dadosGerais.fltDesEsp) + '.' + '#';
  End;

  If (dadosGerais.strDevSim = 'S') Then
  Begin
    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + 'Procedimento autorizado pelo Ajuste SINIEF 13/24.' + '#';
  End;

  If dadosGerais.blnAtoDeclaratorioDF Then
  Begin
    If Not fEmptyStr(dadosGerais.strMsgAtoDeclaratorioDF) Then
      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + dadosGerais.strMsgAtoDeclaratorioDF + '#';
  End;

  If fInsereMsgDescICMSDesonerado Then
    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + 'ICMS DESONERADO DE R$ ' + FormatFloat('#,##0.00', dadosGerais.fltVrdIcm) + ', CONCEDIDO COMO DESCONTO.' + '#';

  If dadosGerais.blnComVal Then
    dadosGerais.strMsgAdicionalCom :=  dadosGerais.strMsgAdicionalCom + 'DOCUMENTO FISCAL COMPLEMENTAR REFERENTE AO DOCUMENTO FISCAL ORIGINÁRIO.' + '#';

  If (dadosGerais.strClaFis >= '5000') Or (Pos(dadosGerais.strClaFis, objConfig.strClaDev + strOutrasClaFisMsg) > 0) Or dadosGerais.blnNfComp Or
     (dadosGerais.strOpcDoc = 'NW') Or (dadosGerais.strOpcDoc = 'NG') Or (dadosGerais.strOpcDoc = 'CA') Then
  Begin
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
      AnsiReplaceStr(fonteDados.fDadosGerais.strMensagemAplicacao, #13#10, '#');

    dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
      AnsiReplaceStr(fonteDados.fDadosGerais.strMensagemFiscalCNf, #13#10, '#');

    If (Pos(dadosGerais.strClaFis, '5905_5906_') <= 0) Then
    Begin
      If Not fEmptyStr(dadosGerais.strMsgAdicionalCom) And
         Not AnsiEndsStr(dadosGerais.strMsgAdicionalCom, '#') Then
      Begin
        dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + '#';
      End;
    End;

    if (Length(arrAbf) > 0) then
    begin
      For intCont := Low(arrAbf) To High(arrAbf) Do
      Begin
        strMsgAdicionalFiscal := strMsgAdicionalFiscal + Trim(arrAbf[intCont][2]) + '#';
      End;
    end;
  End;

  If (dadosGerais.blnVenPre) And (Not dadosGerais.blnEntFat) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + 'Mercadoria retirada no estabelecimento' + '#';

  If Not fEmptyStr(dadosGerais.strMen001) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen001 + '#';

  If Not fEmptyStr(dadosGerais.strMen002) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen002 + '#';

  If Not fEmptyStr(dadosGerais.strMen003) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen003 + '#';

  If Not fEmptyStr(dadosGerais.strMen004) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen004 + '#';

  If Not fEmptyStr(dadosGerais.strMen005) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen005 + '#';

  If objConfig.blnOrgDfi Then
  Begin
    If Not fEmptyStr(objConfig.strEndPrc) Then
    Begin
      dadosGerais.strEndTelPrc := 'PROCON-'  + fonteDados.fDadosEmitente.strEstado+': ' + objConfig.strEndPrc  +
                                   ' / TEL: '+ objConfig.strTelPrc;
    End
    Else
    Begin
      dadosGerais.strEndTelPrc := '';
    End;

    If Not fEmptyStr(objConfig.strEndAle) Then
    Begin
      dadosGerais.strEndTelAle := 'ALERJ: '   + objConfig.strEndAle +
                                  ' / TEL: '  + objConfig.strTelAle;
    End
    Else
    Begin
      dadosGerais.strEndTelAle := '';
    End;
  End
  Else
  Begin
    dadosGerais.strEndTelPrc := '';
    dadosGerais.strEndTelAle := '';
  End;

  If objConfig.blnOrgDfi Then
  Begin
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strEndTelPrc + '#';
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strEndTelAle + '#';
  End;

  If objConfig.blnClaOnu And
    (Length(arrLegendONU) > 0) And
    (pos(objConfigInterna.strImpOnu, 'A_T_') > 0) Then
  Begin
    With TStringList.Create Do
    Begin
      Sorted := True;

      dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis +
        'CONFORME DEC.96044/88 - ART.22, ITEM II DO RTTPP: ' + '#';

      For intCont := 0 To Length(arrLegendONU) -1 Do
        Add('ONU ' + arrLegendONU[intCont].strCodigo + ', ' +
            Copy(arrLegendONU[intCont].strDesOnu, 1, 165) + ', ' +
            '(CLASSE ' + arrLegendONU[intCont].strClaRis + '), ' +
            'GE ' + arrLegendONU[intCont].strGruEmb + ' ' +
            FormatFloat('#,##0.000', arrLegendONU[intCont].fltPesTot) + ' KG. / ');

      For intCont := 0 To Count -1 Do
        dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + Strings[intCont];

      dadosGerais.strMsgAdicionalFis := Copy(dadosGerais.strMsgAdicionalFis,1,(Length(dadosGerais.strMsgAdicionalFis )-4));
      
      Destroy;
    End;
  End;

  {*REQ.144458**********RP*}
  If dadosGerais.strEntFutOpc = '2' Then
  Begin
    If dadosGerais.fltTotRetEntFut > 0 Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Vr.ST destacado na nota de entrega futura: R$ '+ FloatToStrF(dadosGerais.fltTotRetEntFut, ffNumber, 12,2) + '#';

    If dadosGerais.fltTotFcpSTEntFut > 0 Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Vr.FCP ST destacado na nota de entrega futura: R$ '+ FloatToStrF(dadosGerais.fltTotFcpSTEntFut, ffNumber, 12,2) + '#';

    If dadosGerais.fltTotIpiEntFut > 0 Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom +
        'Vr.IPI destacado na nota de entrega futura: R$ '+ FloatToStrF(dadosGerais.fltTotIpiEntFut, ffNumber, 12,2) + '#';
  End;

  If (not dadosGerais.blnNfComp) And (pos(fonteDados.fDadosGerais.strFinalidade, '5_6_') > 0) Then
  Begin
    strMsgAdicionalFiscal := '';
    dadosGerais.strMsgAdicionalCom := '';
    dadosGerais.strMsgAdicionalFis := '';

    If Not fEmptyStr(dadosGerais.strMen001) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen001 + '#';

    If Not fEmptyStr(dadosGerais.strMen002) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen002 + '#';

    If Not fEmptyStr(dadosGerais.strMen003) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen003 + '#';

    If Not fEmptyStr(dadosGerais.strMen004) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen004 + '#';

    If Not fEmptyStr(dadosGerais.strMen005) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMen005 + '#';
  End;

  pMensagemCBS_IBS;

  dadosGerais.strMsgAdicionalFis := dadosGerais.strMsgAdicionalFis + strMsgAdicionalFiscal;

  dadosGerais.strMsgAdicionalFis := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalFis, #13#10, ' ')), 4000);
  dadosGerais.strMsgAdicionalFis := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalFis, #13, ' ')), 4000);
  dadosGerais.strMsgAdicionalFis := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalFis, #10, ' ')), 4000);

  dadosGerais.strMsgAdicionalCom := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalCom, #13#10, ' ')), 4000);
  dadosGerais.strMsgAdicionalCom := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalCom, #13, ' ')), 4000);
  dadosGerais.strMsgAdicionalCom := LeftStr(Trim(AnsiReplaceStr(dadosGerais.strMsgAdicionalCom, #10, ' ')), 4000);
end;

procedure TFonteDadosFormatadorImpl.pRetInformacoesAdicionaisNotComp;
  Var
    dadosGerais: TDadosGerais;
begin
  dadosGerais := fonteDados.fDadosGerais;
  dadosGerais.strMsgAdicionalCom := '';
  dadosGerais.strMsgAdicionalFis := '';
  dadosGerais.strMsgAdicional    := '';

  If Not fEmptyStr(dadosGerais.strMenNc01) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc01 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc02) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc02 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc03) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc03 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc04) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc04 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc05) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc05 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc06) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc06 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc07) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc07 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc08) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc08 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc09) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc09 + '#';

  If Not fEmptyStr(dadosGerais.strMenNc10) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + dadosGerais.strMenNc10 + '#';

  If Not fEmptyStr(dadosGerais.strDocOriNC) Then
  Begin
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + IIF(dadosGerais.strEspDoc = 'IF', 'NFCe.Ref: ', 'NF.Ref: ') + dadosGerais.strDocOriNC;

    If Not fEmptyStr(dadosGerais.strEspOriNC) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + '-' + dadosGerais.strEspOriNC;

    If Not fEmptyStr(dadosGerais.strEmpOriNC) Then
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + '-' + dadosGerais.strEmpOriNC;

    If (dadosGerais.strEspDoc = 'IF') And (Not fEmptyStr(dadosGerais.strAceOriNC)) Then
    Begin
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + ' Chave: ' + dadosGerais.strAceOriNC;
    End;

    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + '#';
  End;

  If (dadosGerais.blnComplementoValor) And (fonteDados.fDadosEmitente.strEstado = 'SP') Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + 'NF EMITIDA CONFORME ARTIGO 182 INCISO I DO RICMS/SP.' + '#';

  If (dadosGerais.blnRestituicaoIcms) And fEmptyStr(dadosGerais.strMenNc01) Then
    dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + 'RESTITUIÇÃO DE ICMS/ST/ESTOQUE - APROPRIAÇÃO DO CRÉDITO REFERENTE À EXCLUSÃO DE MERCADORIAS DO REGIME DA SUBSTITUIÇÃO TRIBUTÁRIA - ART. 26, INCISO IV DA RESOLUÇÃO Nº 4.855/2015' + '#';

  If dadosGerais.blnEstornoDeCredito Then
  Begin
    If (fCfgSisFonte(fonteDados, 'MENEST') <> 'N') Then
    Begin
      dadosGerais.strMsgAdicionalCom := dadosGerais.strMsgAdicionalCom + 'Estorno de crédito - Estoque - Crédito Presumido, nos termos do art. XX do regime especial e-PTA n. 45.xxx-xx - art. 6º da '+
                                                                         'Resolução nº 5029/2017”, se o crédito presumido for concedido através de e-PTA, ou “Estorno de crédito - Estoque - Crédito '+
                                                                         'Presumido - art. 6º da Resolução nº 5029/2017”, nos demais casos' + '#';
    End;
  End;

  pRetInformacoesAdicionais;
end;

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function TFonteDadosFormatadorImpl.fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

function TFonteDadosFormatadorImpl.fFornecedoresTigre: String;
Var
  dataCadFor: TDataSet;
begin
  Result := '';
  dataCadFor := fonteDados.fExecutaQuery('SELECT FOR_CODFOR FROM CADFOR WHERE FOR_ENVTIG = "S"', [], []);

  dataCadFor.First;
  While not dataCadFor.Eof Do
  Begin
    Result := Result + dataCadFor.FieldByName('FOR_CODFOR').AsString + '_';
    dataCadFor.Next;
  End;
  FreeAndNil(dataCadFor);
end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA fStrToFloat EM UM    *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function TFonteDadosFormatadorImpl.fStrToFloat(strValor: String): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValor,'.',''),0);
End;

function TFonteDadosFormatadorImpl.fValidaCodBar(strCodBar: String): Boolean;
  var
    strPrefixo : string;
begin
  If (fCfgSisFonte(fonteDados, 'VERNFE') = '4.00') Then
  Begin
    If (fEmptyStr(strCodBar)) Or (Length(strCodBar) < 3) Then
      Result := False
    Else
    Begin
      if Length(strCodBar) = 14 then
        strPrefixo := Copy(strCodBar, 2, 3)
      else
        strPrefixo := LeftStr(strCodBar, 3);
      Result := fPrefixoValido(fonteDados, strPrefixo);
      If (Result) Then
        Result := fValidaGTIN(strCodBar);
    End;
  End
  Else
  Begin
    If Length(strCodBar) = 13 Then
      Result := fGeraCodBarraEAN13(LeftStr(strCodBar, 12)) = strCodBar
    Else
      Result := False;
  End;
end;

function TFonteDadosFormatadorImpl.fGeraCodBarraEAN13(strCodigo: String): String;
  Var
    intContador: Integer;
    intSomaPar: Integer;
    intSomaImp: Integer;
    intTotal: Integer;
    intMultiplo: Integer;
    intResto: Integer;
begin

  Result := '';
  If (Length(strCodigo) <> 12) Then
  Begin
    Exit;
  End;

  intSomaPar := 0;
  intSomaImp := 0;

  For intContador := 1 To Length(strCodigo) Do
  Begin
    If intContador Mod 2 = 0 Then
      intSomaPar := intSomaPar + StrToIntDef(strCodigo[intContador], 0)
    Else
      intSomaImp := intSomaImp + StrToIntDef(strCodigo[intContador], 0);
  End;
  intSomaPar := intSomaPar * 3;
  intTotal   := intSomaPar + intSomaImp;
  intResto   := intTotal Mod 10;

  If intResto =  0 Then
    intMultiplo := intTotal
  Else
    intMultiplo := intTotal + (10 - (intResto));

  Result := strCodigo + IntToStr(intMultiplo - intTotal);

end;

procedure TFonteDadosFormatadorImpl.pAtualizaDescricaoDoItemNotComp;
Var
  dadosGerais: TDadosGerais;
begin
  dadosGerais := fonteDados.fDadosGerais;

  If (fonteDados.fDadosGerais.blnEstornoDeCredito) Then
    dadosGerais.strDesIteNC := dadosGerais.strDesIteNC + ' - ' + fRetExtensoNumero(floatToStr(dadosGerais.fltTotGer));
end;

function TFonteDadosFormatadorImpl.fTagDadosAdicionaisItem(const strTag: String; strConteudo: String): String;
  Const
    SEPARADOR : String = '_';
    TAGS : String = 'vBCFCP_pFCP_vFCP_pRedBC_vBCFCPST_pFCPST_vFCPST_pRedBCST_pMVAST_pICMSST_vBCST_vICMSST_';
  Var
    strCodEmp,
    strTAGITE,
    strCodCfg,
    strValCfg: String;
    blnAchou: Boolean;
    dataSet: TDataSet;
    {$IF Defined(UNIDAC)}
    strKey: String;
    {$IFEND}
begin
  Result := strConteudo;

  strCodCfg := 'TAGITE';
  strValCfg := '';

  If (fonteDados.fConfiguracaoExiste(strCodCfg)) Then
  Begin
    strCodEmp := fonteDados.fDadosGerais.strCodEmp;
    If fEmptyStr(strCodEmp) Then
      strCodEmp := objConfig.strCodEmp;

    blnAchou := False;

    {$IF Defined(UNIDAC)}
    strKey := fFormataKeyValCfgParaDicSis(strCodCfg, strCodEmp);
    If fAchouDicSisStr(fonteDados.fRetDataBase, strKey, strValCfg) Then
      blnAchou := True;
    {$IFEND}

    If (Not blnAchou) Then
    Begin
      Try
        dataSet := fonteDados.fExecutaQuery('SELECT SIS_VALCFG FROM CFGSIS WHERE SIS_CODCFG = :CODCFG AND SIS_CODEMP = :CODEMP',
                   ['CODCFG', 'CODEMP'], ['CFG_'+strCodCfg, strCodEmp]);

        strValCfg := dataSet.FieldByName('SIS_VALCFG').AsString;
      Finally
        FreeAndNil(dataSet);
      End;

      {$IF Defined(UNIDAC)}
      pInsereDicSis(fonteDados.fRetDataBase, strKey, strValCfg);
      {$IFEND}
    End;

    strTAGITE := strValCfg;

    If (Pos(strTag+SEPARADOR, TAGS) > 0) And (Pos(strTag+SEPARADOR, strTAGITE) <= 0) Then
      Result := '';
  End;
end;

function TFonteDadosFormatadorImpl.fRetornaMensagemAdicionalFiscal: String;
var
  LMensagem: String;
begin
  Result := 'SUJEITO PASSIVO POR SUBSTITUIÇÃO TRIBUTÁRIA DA INTERESSADA ATRIBUIDA POR REGIME ESPECIAL.';

  LMensagem := fCfgSisFonte(fonteDados, 'MSGFIS');

  If fEmptyStr(LMensagem) Then
    Exit;

  Result := LMensagem;
end;

end.
