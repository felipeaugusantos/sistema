unit untEntradaAutomatizada;

interface

Uses
  Classes, SysUtils, Controls, ComCtrls, DB, UniClientDataSet, Forms, Uni,
  untZClient, StrUtils, Math, Variants, untConsultas, cxProgressBar,
  untFuncoesSimples, untFuncoesGenerica, untTypesSistema, untCfgCfopCst,
  UniDataSetProvider, untTLock, untEntPagtoAntecipado,System.MaskUtils, untFuncFat,
  untAuditoriaGravacaoSaldo, untMensagemExplicativa;

Type
  TUniClientDataSetHelper = class helper for TUniClientDataSet
  public
    function fRetSomaCampo(strNomCam: String): Double;
  end;

Type
   TRecDadosFornecedor = Record
      blnSimPau,
      blnZonFra,
      blnForSta,
      blnForFil,
      blnPeIcms: Boolean;

      strCgcCpfFormat,
      strCgcCpfLablel,

      strCodFor,
      strNomFor,
      strEstFor,
      strCgcCpf,
      strTipCgcCpf,
      strIesFor,
      strTipFor,
     // strCtaFor,
      strTipAbf: String;
      strPlnCta: String;
      function fFornecedorMaterialConsumo: Boolean;
   End;

   TRecDadosNota = Record
     // DADOS FINANCEIRO
     strCodPor,  //
     strCodCta,  //
     strDeposi,  //
     strCodEve,  //
     strModelo: String;
     strHisCtp: String;  //
     strBcoFor: String;
     blnGravaCtaPag,
     blnGraFin, // TAMBEM VAI NO MOVGER
     blnImprCp: Boolean;

     intCtpCon: Integer;

     dtaIcmAnt: TDateTime;  // DATA DE VENCIMENTO DO ICMS ANTECIPADO
     // DADOS FINANCEIRO - FIM


     // DADOS PARA DEVOLUÇÃO
     strCodFaz,
     strCodRep,
     strMotDev,
     strAutDev: String;

     blnDevolu,        // SE É DEVOLUÇÃO
     blnPrecoPraticado: Boolean;

     fltAlqFor: Double;
     // DADOS PARA DEVOLUÇÃO - FIM


     // DADOS PREENCHIDOS NA TELA DE RESUMO DE DADOS FISCAIS
     strVeioBoleto,
     strCodCon: String; // CÓDIGO DA CONTA CONTÁBIL // DADOS DO CADFIS

     blnDescontoIncondicional: Boolean;
     // DADOS PREENCHIDOS NA TELA DE RESUMO DE DADOS FISCAIS - FIM


     strOrdIte, // ORDEM DOS ITENS PARA GARREGAR O PEDIDO

     strAutIncCadFis, // FALTA SALVAR O CADFIS

     strDocFre, // CONHECIMENTO DE FRETE - NÃO GRAVA MAIS ESSE CAMPO

     strSeqGer,
     strDocCon,
     strCodOpe,
     strCndPag,
     strCodDig,
     strNaoAtualizaPreco,
     strOutIncMovGer: String;  // AUTO INCREMENTO DO MOVGER

     blnCarPro: Boolean; // Se carregou itens do pedido de compra

     // CONFIGURAÇÕES
     strIOE915,
     strLVPENT,
     strLVPISE,
     strLVPI30,
     strLVPI41,
     strLVPI50,
     strLVPI51,
     strLVPE70: String;

     blnFreIpi,
     blnEmpSimPau,
     blnCreIpi: Boolean;
     // CONFIGURAÇÕES - FIM

     dtaDtaEnt: TDateTime; // DATA DA ENTRADA

     // TIPOS DE ENTADA
     blnGarantia,
     blnRecCliGarantia,
     blnPedFilialGarantia,
     blnConEqu: Boolean;
     // TIPOS DE ENTADA - FIM

     // PIS / COFINS
     fltTotPis,
     fltTotCof,
     fltBasPis,
     fltBasCof,
     fltAlqPis,
     fltAlqCof: Double;
     // PIS / COFINS - FIM

     fltConFre: Double; // VALOR DO CONHECIMENTO DE FRETE - NAO É MAIS USADO

     // ANTECIPACAO CONHECIMENTO DE FRETE - NAO É MAIS USADO
     fltAntIcF,
     fltBasAnF: Double;
   End;

   TEntradaAutomatizada = Class
   Private
     FPais: TPais;

     FAutGerEle: String;

     FDescontoIncondicional: Boolean;

     FEspDoc,
     FEmpEst,
     strCFOPermitido,
     FCtaAnt: String;
     cdsTotCta: TZClient;

     objExcecaoCfopCst: TCfgCfopCst;

     FReplicarPlanoContas: boolean;
     FPriorizarPlanoContasFornecedor: Boolean;
     FLiberadoAlteracaoPlanoConta: boolean;
     FExecReplicarPlanoConta: Boolean;

     objAuditoriaSaldo: IAuditoriaGravacaoSaldo;

     Function fSQLNotas: String;

     Function fCriaClientGruposFiscal: Boolean;

     Function fAbreConsultaPrg(prgProgresso: TcxProgressBar): Boolean;

     Procedure pCarregaCabecalho;
     procedure pFormataCGCFor;

     Function fCarregaItensNotaElet: Boolean;
     Function fCarregaItensNotaEletPrg(cxProgresso: TcxProgressBar): Boolean;
     function fValidaAbreviacaoItens: Boolean;

     Procedure pCriaTotaisItens;
     procedure pDefineCodCta(var AStrCodCta: String);

     Function fLckNota: String;

     Function fAbreConsulta(strAutGerEle: String = ''): Boolean;

     Function fTravaNota: Boolean;

     Procedure pBeforeEditItens(dtsItens: TDataSet);
     Procedure pBeforePostItens(dtsItens: TDataSet);
     Procedure pAfterPostItens(dtsItens: TDataSet);

     Procedure pBeforePostEventos(dtsEventos: TDataSet);

     Function fLiberaAlteracao(strCTA1, strCTA2, strCTANova, strCodbar, strDesite: string): Boolean;

     Function fRetClaFisConsumoTributado: String;
     Function fRetClaFisConsumoSubstiuido: String;

     Procedure pInicializaDadosNota;
     procedure pMontaCdsDuplic;

     Function fMontaGrupoLivro(cxProgresso: TcxProgressBar): Boolean;

     Procedure pAjustaDadosFiscaisItem(const AblnSomaReforma: Boolean);

     Procedure pCriaCdsCodFis;

     Procedure pAbreEventos;

     Procedure pDesmenbraValoresCadPag(cxProgresso: TcxProgressBar);

     Procedure pCriaCdsTotCta;
     Procedure pCriaCdsDuplic;

     Function fGravaNotaPrg(cxProgresso: TcxProgressBar): Boolean;
     function fPedidosPreNota: String;
     procedure cdsItensCODCTUValidate(Sender: TField);

    function fTemItemSemPlanoConta: Boolean;
    procedure pReplicarPlanoConta(const strCodConta, strDesCta: String;  blnAplicarSomenteVazio: Boolean = True);overload;
    procedure pReplicarPlanoConta;overload;
    procedure pAplicarPlanoContaFornecedor;
   Public
     objPgoAnt: TEntPagtoAntecipado;
     arrLinDigCodbar: TarrLinDigCodbar;
     intQtdPar: integer;
     arrDuplicata: TarrDuplicata;

     cxProgressoAuto: TcxProgressBar;
//     fltBonificacao : Double;
     fltValorDocumento : Double;

     blnGravaLog : Boolean;

     recNotEle: TRecInfoNotaEletronica;
     qryGerEle: TUniQuery;

     stlPedidos: TStringList;

     recDadNot: TRecDadosNota;

     FCodEveCTP: String;

     recDadFor: TRecDadosFornecedor;
     qryForCli: TUniQuery;
     objLock: TLock;

     cdsTemp,
     cdsCtpDet: TUniClientDataSet;

     cdsCadFis: TUniClientDataSet;

     FAtualizaLivroFiscal: Boolean;

     cdsDuplic,
     cdsCadEve,
     cdsMovEve,
     cdsCodFis,
     cdsGruLiv,
     cdsMovGad,
     cdsNotas,
     cdsItens: TZClient;

     intDecUni,
     intDecQtd: Integer;
     blnPgoAnt: Boolean;
     ParcelasArray: TParcelasArray;
     lstEmpRateioDespesa : TStringList;
     blnVeioBoleto: Boolean;
     blnValoresDesmembradosRotina: Boolean;
     blnNotaImp: Boolean;

     Constructor Create;

     Destructor Destroi;

     Class Procedure pCarregaNotas;

     Class procedure pCarregaFornecedor(qryConCli: TUniQuery; Var recDadFor: TRecDadosFornecedor);

     Class procedure pCriaClientLivro(Var cdsCadFis: TUniClientDataSet; objSelf: TComponent);

     Class Function fValidaDataEntrada(strDtaEnt: String; blnDevolu: Boolean; dtaDtaVen: TDateTime; strEspDoc: String): Boolean;

     Class Function fRetKeyLckNota(strNumDoc, strEspDoc, strCodFor, strSerie: String): String;

     Class Function fRetDocCon(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;

     Class Function fGravaContasPagar(strClaFis, strCodFor: String; blnGerarContasAPagarx117: Boolean = false; finalidadeXml: tpeFinalidadeXML = xmlEntradaMercadoria): Boolean;

     Function fValidaEventos: Boolean;

     function fValidaValorTotalEventos: Boolean;

     Function fCarregaNota: Boolean;

     procedure pSalvaCtaConsumo;

     Function fValidaCodCtas(blnMsgErro: Boolean): Boolean;

     Function fGravaNota: Boolean;

     Procedure pRetTotaisNota(Var fltBasIpi, fltTotIpi, fltBaEIpi, fltToEIpi, fltBasIcm,
                  fltTotIcm, fltValRet, fltBasRet, fltVaeRet, fltBaeRet, fltValAnt, fltBasAnt, fltDesEsp,
                  fltTotIte, fltValFre, fltVlrCon, fltDesAce, fltBFCPST, fltVFCPST: Double);

     Procedure pSetaAutoincremMovDet;

     Function fGeraLivroFiscal(cxProgresso: TcxProgressBar): Boolean;

     Class Function fRefazCondPagamento(var arrDuplicata: TarrDuplicata; dtaDtaDoc: TDateTime): String;
     Class Function fMontaDuplicatasDupEle(var arrDuplicata: TarrDuplicata; strAutInc: String; dtaDtaDoc: TDateTime): String;

     procedure pIncluiEvento(strCodEve, strDesEve: String; fltValEve: Double);

     procedure pExcluiEvento;

     Class Function fVerificaDocumentoExiste(blnDevolu,
                                             blnRecCliGarantia,
                                             blnConEqu: Boolean;
                                             strNumDoc,
                                             strEspDoc,
                                             strSerie,
                                             strCodFor: String;
                                             intTamCam: Integer;
                                             Var blnNotaImp: Boolean): Boolean;

      Class Function fVerificaDocumentoExisteCtp(strNumDoc, strSerie, strCodFor: String; intTamCam: Integer): Boolean;

      Class Function fValidaConfiguracoesEntrada: Boolean;

      Class Procedure pCarregaNota(strAutGerEle: String);

      Function fPedeDuplicatas(blnManterValorOriginal: Boolean = True): Boolean;
      function  fRelacionaCodBar_LinhaDigitavel: Boolean;

      Function fTemAntecipadoValorMenor: Boolean;
      Procedure pCalculaValorDocumento;
      procedure pLimpaCDSDuplicata;
      procedure pRecriaObjPgoAnt;

      procedure pDefineSeGravaCTP(strClaFis: String; frmEntMercadoriasAutomatizada: TForm);
      function fCFOPPodeSerUtilizada(strClaFis: String): Boolean;
      function fDocumentoHistoricoContasPagar: String;
      procedure pDesmembrarValoresCadPag(cxProgresso: TcxProgressBar; blnAbrirFrmDesmembramento: boolean);
      function fTotalDuplicatas: Currency;
      Function fGetCodFisItem(strCodAbf, strCodIte, strCodEmp : String): String;
   End;

implementation

Uses
  untFuncoes, untGravando, untEntradaAutomatizadaNotas,
  untEntVendor,
  untEntEmbalagens,
  untEntOutrasDespesas,
  untAlteraFornecedorEntrada,
  untConstantes,
  untPcmger,
  untEntMercadoriasAutomatizada,
  untCadPag,
  untDuplicatas,
  untFechamentoEstoque,
  untFechamentoFiscal, untLiberacao, untDigCodBarBoleto,
  untDesmembrValores;

procedure TEntradaAutomatizada.cdsItensCODCTUValidate(Sender: TField);
begin
  FReplicarPlanoContas := True;
end;

Constructor TEntradaAutomatizada.Create;
Begin
  pZeraDigDuplic(arrDuplicata);
  FDescontoIncondicional := False;
  blnVeioBoleto := False;
  objPgoAnt :=  TEntPagtoAntecipado.Create;
  blnPgoAnt := False;
  blnGravaLog := False;
  strCFOPermitido := fCfgSis('CFEAAL');
  FAutGerEle := '';
  FAtualizaLivroFiscal := False;

  FillChar(recDadNot, Sizeof(recDadNot), #0);
  With recDadNot Do
  Begin
    FillChar(arrLinDigCodbar, sizeOf(arrLinDigCodbar), #0);
    blnCreIPI    := fCfgSis('CREIPI', varBoolean);
    blnEmpSimPau := fCfgSis('SIMPAU', varBoolean);

    strLVPENT    := fCfgSis('LVPENT', varString);
    strLVPISE    := fCfgSis('LVPISE', varString);

    strLVPI30    := fCfgSis('LVPI30', varString);
    strLVPI41    := fCfgSis('LVPI41', varString);
    strLVPI50    := fCfgSis('LVPI51', varString);
    strLVPI51    := fCfgSis('LVPI51', varString);
    strLVPE70    := fCfgSis('LVPE70', varString);
    strIOE915    := fCfgSis('IOE915', varString);

    blnFreIpi := fRateioFreteValorContabil(trfIndefinido);

    strCodCta := fCfgSis('CTAPRI'); // SOMENTE QUANDO TEM DESMEMBRAMENTO

    strCodEve := fCfgSis('EVEPRI'); // SOMENTE QUANDO TEM DESMEMBRAMENTO

    FCodEveCTP := '';

    If (fCfgSis('UEVPRI', varBoolean)) Then
      FCodEveCTP := fCfgSis('EVEPRI');
  End;

  FEspDoc   := 'NF';
  FPais     := fSetaPais;
  FEmpEst   := fCadEmp('ESTADO');
  cdsNotas := TZClient.Create(Nil, fSQLNotas);
  intDecQtd := fCfgSis('DEQTEM', varInteger);
  intDecUni := 4;

  qryGerEle := fCriaQuery;
//  qryGerEle.SQL.Text := 'SELECT G.*, ' + fSQLDescontoNotaXML + ' AS DESCONTO FROM GERELE G WHERE AUTOINCREM = :AUTINC';
  qryGerEle.SQL.Text := 'SELECT G.*, ' + fSQLDescontoNotaXML + ' AS DESCONTO, ' +
                        fSQLICMSDesoneradoEstaNoDescontoComercial + ' AS ICMSDesoneradoEstaNoDescontoComercial ' +
                        ' FROM GERELE G WHERE AUTOINCREM = :AUTINC';

  qryForCli := fCriaQuery;

  cdsItens := Nil;

  stlPedidos := TStringList.Create;

  fCriaClientGruposFiscal;
  pCriaClientLivro(cdsCadFis, Nil);
  pCriaCdsCodFis;
  pAbreEventos;
  pCriaCdsTotCta;
  objLock := TLock.Create;
  lstEmpRateioDespesa:= TStringList.Create;

  cdsTemp := Nil;
  pCriaClientTemporariaCtpDet('', '', '', '', '', cdsTemp, cdsCtpDet);
  pCriaCdsDuplic;

  objExcecaoCfopCst := TCfgCfopCst.Create(Nil, True);
  objExcecaoCfopCst.fCarregaDados;

  FLiberadoAlteracaoPlanoConta := False;
  FReplicarPlanoContas := False;
  FPriorizarPlanoContasFornecedor := fCfgSis('PPCFEA', varString) = 'S';
  FExecReplicarPlanoConta := False;

  objAuditoriaSaldo := TAuditoriaGravacaoSaldo.New;
End;

Destructor TEntradaAutomatizada.Destroi;
Begin
  FreeAndNil(cdsNotas);
  FreeAndNil(qryGerEle);
  FreeAndNil(qryForCli);
  FreeAndNil(cdsCadFis);
  FreeAndNil(cdsCodFis);
  FreeAndNil(cdsGruLiv);
  FreeAndNil(cdsCadEve);
  FreeAndNil(cdsMovEve);
  FreeAndNil(cdsCtpDet);
  FreeAndNil(cdsTotCta);
  FreeAndNil(cdsDuplic);
  FreeAndNil(lstEmpRateioDespesa);
  FreeAndNil(objLock);
  FreeAndNil(objExcecaoCfopCst);
End;

Procedure TEntradaAutomatizada.pAbreEventos;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EVE_CODEVE AS CODEVE, ';
  strSQL := strSQL + '   CONCAT(EVE_CODEVE, " - ", EVE_DESEVE) AS DESEVE  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEVE ';

  cdsCadEve := TZClient.Create(Nil, strSQL);
  cdsCadEve.fAbreClient(True, ' TEntradaAutomatizada.pAbreEventos');
  cdsCadEve.IndexFieldNames := 'DESEVE';
  cdsCadEve.First;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   EVE_CODEVE AS CODEVE, ';
  strSQL := strSQL + '   EVE_DESEVE AS DESEVE, ';
  strSQL := strSQL + '   0.00       AS VALEVE  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADEVE ';
  strSQL := strSQL + ' WHERE FALSE ';

  cdsMovEve := TZClient.Create(Nil, strSQL);
  cdsMovEve.pCriaSoma('VALEVE');
  cdsMovEve.fAbreClient(True, ' TEntradaAutomatizada.pAbreEventos');
  cdsMovEve.IndexFieldNames := 'CODEVE';
  cdsMovEve.BeforePost := pBeforePostEventos;
End;

Procedure TEntradaAutomatizada.pCriaCdsTotCta;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTA_CODCTA AS CODCTA, ';
  strSQL := strSQL + '   0.0000     AS TOTCTA  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCTA ';
  strSQL := strSQL + ' WHERE FALSE ';

  cdsTotCta := TZClient.Create(Nil, strSQL);
  cdsTotCta.fAbreClient(True, ' TEntradaAutomatizada.pCriaCdsTotCta');
  cdsTotCta.IndexFieldNames := 'CODCTA';
End;

Procedure TEntradaAutomatizada.pCriaCdsDuplic;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST(NULL AS DATE) AS DTAVEN, ';
  strSQL := strSQL + '   0.0000             AS VALDUP  ';

  cdsDuplic := TZClient.Create(Nil, strSQL);
  cdsDuplic.pCriaSoma('VALDUP');
  cdsDuplic.fAbreClient(True, 'TEntradaAutomatizada.pCriaCdsDuplic');
  cdsDuplic.IndexFieldNames := 'DTAVEN';
  cdsDuplic.EmptyDataSet;
  cdsDuplic.pAlinhaCampoCentro('DTAVEN');
End;

Class Function TEntradaAutomatizada.fRetKeyLckNota(strNumDoc, strEspDoc, strCodFor, strSerie: String): String;
Begin
  Result := 'ENTRADA_MERC_' + strNumDoc + strEspDoc + strCodFor + VS_strCodEmp + strSerie;
End;

Function TEntradaAutomatizada.fLckNota: String;
Begin
  With cdsNotas Do
  Result := fRetKeyLckNota(FieldByName('B08_NNF').AsString,
                           FEspDoc,
                           FieldByName('GER_CODFOR').AsString,
                           FieldByName('B07_SERIE').AsString);
End;

Function TEntradaAutomatizada.fTravaNota: Boolean;

Begin
  Result := True;

  objLock.fLock_Unlock(fLckNota, False);

  If Not objLock.fLock_Unlock(fLckNota, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Essa nota está sendo utilizada em outra estação: ' + fGetHostLock(fLckNota + '%'), ['&Ok']);
    Result := False;
  End
End;

Function TEntradaAutomatizada.fSQLNotas: String;
  Var
    strWhere: String;
Begin
  Result := fSQLNotasEntrada(xmlEntradaMercadoria, strWhere, True, False, '',True) + strWhere+ ' AND IFNULL(GER_MATREV, FOR_MATREV) = "M" ' +
                             IIF(FAutGerEle.IsEmpty, '', ' AND GERELE.AUTOINCREM = ' + QuotedStr(FAutGerEle));
End;

Function TEntradaAutomatizada.fAbreConsulta(strAutGerEle: String = ''): Boolean;
Begin
  Try
    FAutGerEle := strAutGerEle;

    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Carregando notas, aguarde...';
      fExecutarAcao := fAbreConsultaPrg;

      ShowModal;

      Result := blnConfirma;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntradaAutomatizada.fAbreConsulta]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

Function TEntradaAutomatizada.fAbreConsultaPrg(prgProgresso: TcxProgressBar): Boolean;
Begin
  With cdsNotas Do
  Begin
    If Not FAutGerEle.IsEmpty Then
      cdsNotas.qryQuery.SQL.Text := fSQLNotas;

    Result := fAbreClient(True);

    If Result Then
    Begin
      pAlinhaCampoCentro('B08_NNF');
      pAlinhaCampoCentro('B07_SERIE');
      pAlinhaCampoCentro('B09_DEMI');
      pAlinhaCampoCentro('GER_CODFOR');
    End

    Else Raise Exception.Create('TEntradaAutomatizada.fAbreConsultaPrg - ' + strMsgErr);
  End;
End;

Class Function TEntradaAutomatizada.fValidaConfiguracoesEntrada: Boolean;
Begin
  Result := False;

  If fEmptyStr(fCfgSis('CONCLA')) Then
  Begin
    pMensagemOk('Configure a [CFG_CONCLA] "Classificação para entrada de material de consumo tributado"');
    Exit;
  End;

  If fEmptyStr(fCfgSis('CONSUB')) Then
  Begin
    pMensagemOk('Configure a [CFG_CONSUB] "Classificação para entrada de material de consumo substituído"');
    Exit;
  End;

  If fEmptyStr(fRetNomEvento(fCfgSis('EVEPRI'))) Then
  Begin
    pMensagemOk('Configure a [CFG_EVEPRI] "Centro de Custos principal para rateio de duplicatas"');
    Exit;
  End;

  Result := True;
End;

Class Procedure TEntradaAutomatizada.pCarregaNotas;
  Var
    objNotas: TEntradaAutomatizada;
    frmEntradaAutomatizadaNotas: TfrmEntradaAutomatizadaNotas;
Begin
  Try
    If Not fValidaConfiguracoesEntrada Then
      Exit;

    If fEmptyStr(fRetNomeConta(fCfgSis('CTAPRI'))) Then
    Begin
      pMensagemOk('Configure a [CFG_CTAPRI] "Plano de contas para rateio de duplicatas"');
      Exit;
    End;

    objNotas := TEntradaAutomatizada.Create;

    If objNotas.fAbreConsulta Then
    Begin
      pCriarFormularios(TfrmEntradaAutomatizadaNotas, frmEntradaAutomatizadaNotas);

      With frmEntradaAutomatizadaNotas Do
      Begin
        cxvNotas.DataController.DataSource   := objNotas.cdsNotas.dtsSource;

        objEntrada := objNotas;

        ShowModal;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntradaAutomatizada.pCarregaNotas]');
    End;
  End;

  pFreeAndNil(frmEntradaAutomatizadaNotas);
  FreeAndNil(objNotas);
End;


Class Procedure TEntradaAutomatizada.pCarregaNota(strAutGerEle: String);
  Var
    objNotas: TEntradaAutomatizada;
    frmEntradaAutomatizadaNotas: TfrmEntradaAutomatizadaNotas;
Begin
  Try
    If Not fValidaConfiguracoesEntrada Then
      Exit;

    objNotas := TEntradaAutomatizada.Create;

    If objNotas.fAbreConsulta(strAutGerEle) Then
    Begin
      objNotas.fCarregaNota;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TEntradaAutomatizada.pCarregaNotas]');
    End;
  End;

  pFreeAndNil(frmEntradaAutomatizadaNotas);
  FreeAndNil(objNotas);
End;


Class Function TEntradaAutomatizada.fGravaContasPagar(strClaFis, strCodFor: String; blnGerarContasAPagarx117: Boolean = false; finalidadeXml: tpeFinalidadeXML = xmlEntradaMercadoria): Boolean;
Begin
  If finalidadeXml = xmlDevolucaoEntradaEmitidaFornecedor Then
    Result := (fCfgSis('ENTCTP', varBoolean))
  Else
    Result := (fCfgSis('ENTCTP', varBoolean)) And
            ((Pos(strClaFis, VS_strClaCom + '_1933_2933')  > 0) Or (blnGerarContasAPagarx117)) And
            (fFornecedorGravaCtp(strCodFor));
End;

Function TEntradaAutomatizada.fCarregaNota: Boolean;
  Var
    strDocume: String;
    frmEntMercadoriasAutomatizada: TfrmEntMercadoriasAutomatizada;
Begin
  Result := False;

  Try
    Try
      If cdsNotas.IsEmpty Then
        Exit;

      pCarregaCabecalho;

      With cdsNotas, recDadNot Do
      If fVerificaDocumentoExiste(blnDevolu,
                                  blnRecCliGarantia,
                                  blnConEqu,
                                  FieldByName('B08_NNF').AsString,
                                  FEspDoc,
                                  FieldByName('B07_SERIE').AsString,
                                  FieldByName('GER_CODFOR').AsString,
                                  12,
                                  blnNotaImp) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um documento com esses dados!', ['&O k']);
        Exit;
      End;

      If Not fFornecedorAtivo(cdsNotas.FieldByName('GER_CODFOR').AsString) Then
      begin
        fMensagem('ATENÇÃO!', 'Este fornecedor esta inativo!', ['&O k']);
        Exit;
      End;


      With cdsNotas, recDadNot Do
      If fVerificaDocumentoExisteCtp(FieldByName('B08_NNF').AsString,
                                     FieldByName('B07_SERIE').AsString,
                                     FieldByName('GER_CODFOR').AsString,
                                     12) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe uma duplicata com esses dados!', ['&O k']);
        Exit;
      End;

      With recNotEle Do
      If (Not fEmptyStr(str_Chave)) And fExisteNotaEntradaChaveNFE(str_Chave, strDocume) Then
      Begin
        fMensagem('ATENÇÃO!', 'Já existe um documento com a chave ' + str_Chave + ' no Livro Fiscal: ' + strDocume, ['&O k']);
        Exit;
      End;

      If Not fTravaNota Then
        Exit;

      With recDadNot, recNotEle, recDadFor Do
      Begin
        strNaoAtualizaPreco := 'N';
        strVeioBoleto       := 'N';
        strDeposi           := 'N';
        blnGraFin           := True;

        dtaDtaEnt := VS_Date;

        strModFre := qryGerEle.FieldByName('X33_MODFRETE').AsString;
      End;

      cdsCodFis.EmptyDataSet;
      cdsMovEve.EmptyDataSet;
      cdsCtpDet.EmptyDataSet;
      If Not fCarregaItensNotaElet Then
        Exit;

      if FPriorizarPlanoContasFornecedor then
        pAplicarPlanoContaFornecedor;

      pCriarFormularios(TfrmEntMercadoriasAutomatizada, frmEntMercadoriasAutomatizada);

      // NESSA ORDEM - NÃO MUDAR
      With recDadNot, recNotEle, recDadFor Do
      Begin
        pDefineSeGravaCTP(cdsItens.FieldByName('ENT_CLAFIS').AsString, frmEntMercadoriasAutomatizada);

      End;

      With frmEntMercadoriasAutomatizada Do
      Begin
        objEntrada := Self;

        cxvItens.DataController.DataSource    := cdsItens.dtsSource;
        cxvEventos.DataController.DataSource  := cdsMovEve.dtsSource;
        cxvParcelas.DataController.DataSource := cdsDuplic.dtsSource;

        frmEntMercadoriasAutomatizada.tbsCtaPag.TabVisible := recDadNot.blnGravaCtaPag;
        frmEntMercadoriasAutomatizada.pSetaModelo;

        dtsCadFis.DataSet := cdsCadFis;

        Result := ShowModal = mrOk;

      End;


    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TEntradaAutomatizada.fCarregaNota]');
      End;
    End;

  Finally
    objLock.pDestravarTodos;

    pFreeAndNil(frmEntMercadoriasAutomatizada);
    FreeAndNil(cdsItens);
  End;
End;

Procedure TEntradaAutomatizada.pCarregaCabecalho;
Begin
  With qryGerEle Do
  Begin
    Close;
    ParamByName('AUTINC').AsString := cdsNotas.FieldByName('AUTOINCREM').AsString;
    Open;
  End;

  pCarregaCabecalhoNota(qryGerEle, recNotEle);
  recDadFor.strCodFor := recNotEle.strCodFor;
  recDadFor.strTipFor := qryGerEle.FieldByName('GER_MATREV').AsString;

  pCarregaFornecedor(qryForCli, recDadFor);
  pFormataCGCFor;
End;

Class procedure TEntradaAutomatizada.pCarregaFornecedor(qryConCli: TUniQuery;
                                 Var recDadFor: TRecDadosFornecedor);
  Var
    strSQL: String;
    strSavFor: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADFOR.*, ';
  strSQL := strSQL + '  IF(FOR_CGCCPF = 1, "J", "F") AS FISJUR, ';
  strSQL := strSQL + '  CID_ESTADO AS FOR_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFOR, ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FOR_CODCID = CID_CODCID AND ';
  strSQL := strSQL + '  FOR_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  FOR_STATUS = "A" ';

  With qryConCli, recDadFor Do
  Begin
    strSavFor := strCodFor;

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := strCodFor;
    Open;

    If IsEmpty Then
    Begin
      Fillchar(recDadFor, SizeOf(recDadFor), #0);
    End Else
    Begin
      blnSimPau       := FieldByName('FOR_SIMPAU').AsString = 'S';
      blnPeIcms       := FieldByName('FOR_PEICMS').AsString = 'S';
      strNomFor       := FieldByName('FOR_NOMFOR').AsString;
      strEstFor       := FieldByName('FOR_ESTADO').AsString;
      {strCgcCpf       := FieldByName('FOR_CGCCPF').AsString;}
      strIesFor       := FieldByName('FOR_I_E_S_').AsString;
      If (fEmptyStr(strTipFor)) Then
        strTipFor       := FieldByName('FOR_MATREV').AsString;
      blnZonFra       := FieldByName('FOR_ZONFRA').AsString = 'S';
      blnForSta       := IIF(Not fEmptyStr(FieldByName('FOR_STATUS').AsString), True, False);
      blnForFil       := fFornecedorFilial(strCodFor);
//      strCtaFor       := FieldByName('FOR_CODCTE').AsString;
      strCgcCpf       := FieldByName('FOR_C_G_C_').AsString;
      strCgcCpfLablel := IIF(FieldByName('FOR_CGCCPF').AsString = '2', 'CPF:', 'CNPJ:');

      strTipAbf       := fGetTipoAbf('F', FieldByName('FISJUR').AsString,
                               FieldByName('FOR_I_E_S_').AsString,
                               '', '', '', '',
                               FieldByName('FOR_SIMPAU').AsString,
                               strTipFor,
                               '',
                               '');
      strPlnCta       := FieldByName('FOR_CODCTA').AsString;
      strTipCgcCpf := FieldByName('FOR_CGCCPF').AsString;
    End;

  End;
end;

procedure TEntradaAutomatizada.pFormataCGCFor;
Begin
  With recDadFor Do
  strCgcCpfFormat := fFormataCpfCgc(strCgcCpf, FPais);
End;

Class Function TEntradaAutomatizada.fValidaDataEntrada(strDtaEnt: String; blnDevolu: Boolean; dtaDtaVen: TDateTime; strEspDoc: String): Boolean;
  Var
    dtaDtaLim: TDateTime;
Begin
  Result := True;

  If StrToDateDef(strDtaEnt, -1) = -1 Then
  Begin
    fMensagem('ATENÇÃO!', 'Data de Entrada inválida!', ['&O k']);
    Result := False;
  End

  Else If fEmptyStr(fTiraCaracEspeciais(strDtaEnt)) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data de Entrada deve ser preenchida!', ['&O k']);
    Result := False;
  End

  Else If (StrToDate(strDtaEnt) > VS_Date) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data de Entrada não pode ser maior que a Data Atual!', ['&O k']);
    Result := False;
  End

  Else If (StrToDate(strDtaEnt) < StrToDate('01/01/2000')) Then
  Begin
    fMensagem('ATENÇÃO!', 'A Data de Entrada não pode ser menor que 01/01/2000!', ['&O k']);
    Result := False;
  End

  Else If (fCfgSis('DIEMRT', varInteger) >= 0) Then
  Begin

    dtaDtaLim := VS_Date - fCfgSis('DIEMRT', varInteger);
    If (StrToDate(strDtaEnt) < (dtaDtaLim)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Data de Entrada máxima permitida é ' + DateToStr(dtaDtaLim) + '!', ['&O k']);
      Result := False;
    End;

  End

  Else If blnDevolu And (StrToDate(strDtaEnt) < dtaDtaVen) Then
  Begin
    pMensagemOk('A Data de Entrada do Documento não pode ser menor que a data da venda (' + FormatDateTime('DD/MM/YY', dtaDtaVen)  + ')');
    Result := False;
  End

  Else If Not TFechamentoEstoque.fDataDeEntradaPermitida(StrToDate(strDtaEnt)) Then
  Begin
    Result := False;
  End

  Else If SameText(strEspDoc, 'NF') And (Not TFechamentoFiscal.fDataFiscalPermitida(StrToDate(strDtaEnt))) Then
  Begin
    Result := False;
  End;

End;

Function TEntradaAutomatizada.fRetClaFisConsumoTributado: String;
Begin
  If (recDadFor.strEstFor = FEmpEst) Then
    Result := '1' + fCfgSis('CONCLA')
  Else
    Result := '2' + fCfgSis('CONCLA');
End;

Function TEntradaAutomatizada.fRetClaFisConsumoSubstiuido: String;
Begin
  If (recDadFor.strEstFor = FEmpEst) Then
    Result := '1' + fCfgSis('CONSUB')
  Else
    Result := '2' + fCfgSis('CONSUB');
End;

procedure TEntradaAutomatizada.pRecriaObjPgoAnt;
begin
  If Assigned(objPgoAnt) Then
    FreeAndNil(objPgoAnt);
  objPgoAnt :=  TEntPagtoAntecipado.Create;
end;

procedure TEntradaAutomatizada.pReplicarPlanoConta;
  const
    NAO: Integer = 2;
  Var
    fldCODCTU, fldDesCta: TField;
    strCodCtu: String;
    Evento: TFieldNotifyEvent;
begin
  FReplicarPlanoContas := False;
  fldCodCtu := cdsItens.FieldByName('ENT_CODCTU');
  fldDesCta := cdsItens.FieldByName('ENT_DESCTA');
  strCodCtu := fTiraCaracter(fldCODCTU.AsString);
  if fEmptyStr(strCodCtu) then
    Exit;

  if Not fTemItemSemPlanoConta then
    Exit;

  if fMensagem('Pergunta', 'Deseja replicar o plano de contas para todos os itens que estão em branco?',['&Sim','&Não']) = NAO then
    Exit;

  fldCODCTU.OldValue;
  Evento := fldCODCTU.OnValidate;
  Try
    fldCODCTU.OnValidate := nil;
    pReplicarPlanoConta(strCodCtu, fldDesCta.AsString);
  Finally
    fldCODCTU.OnValidate :=  Evento;
  End;
end;

procedure TEntradaAutomatizada.pReplicarPlanoConta(const strCodConta, strDesCta: String; blnAplicarSomenteVazio: Boolean = True);
  Var
    Reg: TBookmark;
    fldCODCTU, fldDesCta: TField;
    blnAplicar: Boolean;
begin
  Reg := Nil;
  Try
    FExecReplicarPlanoConta := True;
    fldCODCTU := cdsItens.FieldByName('ENT_CODCTU');
    fldDesCta := cdsItens.FieldByName('ENT_DESCTA');
    Reg := cdsItens.GetBookmark;
    cdsItens.DisableControls;
    cdsItens.First;
    While Not cdsItens.Eof do
    begin
      blnAplicar := (Not blnAplicarSomenteVazio) or (blnAplicarSomenteVazio and fEmptyStr(fTiraCaracEspeciaisPonto(fldCODCTU.AsString)));
      if blnAplicar then
      begin
        cdsItens.Edit;
        fldCODCTU.AsString := strCodConta;
        fldDesCta.AsString := strDesCta;
        cdsItens.Post;
      end;

      If Not FExecReplicarPlanoConta then
        Break;

      cdsItens.Next;
    end;
  Finally
    FExecReplicarPlanoConta := False;
    FLiberadoAlteracaoPlanoConta := False;
    if Assigned(Reg) then
    begin
      if cdsItens.BookmarkValid(Reg) then
        cdsItens.GotoBookmark(Reg);
      cdsItens.FreeBookmark(Reg);
    end;
    cdsItens.EnableControls;
  End;

end;

Procedure TEntradaAutomatizada.pRetTotaisNota(Var fltBasIpi, fltTotIpi, fltBaEIpi, fltToEIpi, fltBasIcm,
  fltTotIcm, fltValRet, fltBasRet, fltVaeRet, fltBaeRet, fltValAnt, fltBasAnt, fltDesEsp,
  fltTotIte, fltValFre, fltVlrCon, fltDesAce, fltBFCPST, fltVFCPST: Double);
Begin
  fltBasIpi := cdsItens.fRetSomaCampo('ENT_BASIPI');
  fltTotIpi := cdsItens.fRetSomaCampo('ENT_VALIPI');
  fltBFCPST := cdsItens.fRetSomaCampo('ENT_BFCPST');
  fltVFCPST := cdsItens.fRetSomaCampo('ENT_VFCPST');
  fltBaEIpi := cdsItens.fRetSomaCampo('ENT_BAEIPI');
  fltToEIpi := cdsItens.fRetSomaCampo('ENT_VAEIPI');
  fltBasIcm := cdsItens.fRetSomaCampo('ENT_BASICM');
  fltTotIcm := cdsItens.fRetSomaCampo('ENT_VALICM');
  fltValRet := cdsItens.fRetSomaCampo('ENT_VALRET');
  fltBasRet := cdsItens.fRetSomaCampo('ENT_BASRET');
  fltVaeRet := cdsItens.fRetSomaCampo('ENT_VAERET');
  fltBaeRet := cdsItens.fRetSomaCampo('ENT_BAERET');
  fltValAnt := cdsItens.fRetSomaCampo('ENT_VALANT');
  fltBasAnt := cdsItens.fRetSomaCampo('ENT_BASANT');
  fltDesEsp := cdsItens.fRetSomaCampo('ENT_DESESP');
  fltTotIte := cdsItens.fRetSomaCampo('ENT_TOTITE');
  fltValFre := cdsItens.fRetSomaCampo('ENT_VALFRE');
  fltVlrCon := cdsItens.fRetSomaCampo('ENT_VLRCON');
  fltDesAce := cdsItens.fRetSomaCampo('ENT_DESACE');
End;

Procedure TEntradaAutomatizada.pCriaTotaisItens;
Begin
  With cdsItens Do
  Begin
    pCriaSoma('ENT_BASIPI');
    pCriaSoma('ENT_VALIPI');
    pCriaSoma('ENT_BFCPST');
    pCriaSoma('ENT_VFCPST');
    pCriaSoma('ENT_BAEIPI');
    pCriaSoma('ENT_VAEIPI');
    pCriaSoma('ENT_BASICM');
    pCriaSoma('ENT_VALICM');
    pCriaSoma('ENT_VALRET');
    pCriaSoma('ENT_BASRET');
    pCriaSoma('ENT_BAERET');
    pCriaSoma('ENT_VAERET');
    pCriaSoma('ENT_VALANT');
    pCriaSoma('ENT_BASANT');
    pCriaSoma('ENT_DESESP');
    pCriaSoma('ENT_TOTITE');

//   SUM(IF(ENT_VALANT > 0, ENT_TOTITE, 0)) AS ENT_TOTDAR, ;

    pCriaSoma('ENT_VALFRE');

    If FDescontoIncondicional Then
      pCriaSoma('ENT_VLRCON', '', 'SUM(ENT_VLRCON - ENT_DESESP)')
    Else
      pCriaSoma('ENT_VLRCON');

    pCriaSoma('ENT_DESACE');
  End;
End;

Procedure TEntradaAutomatizada.pSetaAutoincremMovDet;
  Var
    strAutDet: String;
Begin
  With cdsItens Do
  Begin
    First;

    If fEmptyStr(FieldByName('AUTOINCREMENTO_GRAVACAO').AsString) Then
    Begin
      strAutDet := fRetAutoIncrem('MOVDET', VS_strCodEmp, RecordCount);

      While Not Eof Do
      Begin
        Edit;

        FieldByName('AUTOINCREMENTO_GRAVACAO').AsString := strAutDet;

        Post;
        Next;

        strAutDet := fNextAutoIncrem(strAutDet);
      End;

    End;

    //Ordena os itens por codigo para evitar deadlock com gravacoes do faturamento
    IndexFieldNames := 'ENT_CODITE';
    First;
  End;
End;


Function TEntradaAutomatizada.fCarregaItensNotaEletPrg(cxProgresso: TcxProgressBar): Boolean;
Begin

  With recNotEle Do
  cdsItens := TZClient.Create(Nil, 'SET @N_ITEM_TELA = 0;' + fSQLItensNotaEletronica(strAutInc,
                                                                                     VS_strCodEmp,
                                                                                     recNotEle.finalidadeXML,
                                                                                     True,
                                                                                     FDescontoIncondicional,
                                                                                     fRetClaFisConsumoTributado,
                                                                                     fRetClaFisConsumoSubstiuido,
                                                                                     True));

  pCriaTotaisItens;

  Result := cdsItens.fAbreClient(True, 'TEntradaAutomatizada.fCarregaItensNotaElet');

  cdsItens.BeforeEdit := pBeforeEditItens;
  cdsItens.BeforePost := pBeforePostItens;
  cdsItens.AfterPost  := pAfterPostItens;
  cdsItens.FieldByName('ENT_CODCTU').OnValidate := cdsItensCODCTUValidate;

  If Not Result Then
    Exit;

  cdsItens.pAlinhaCampoCentro('ENT_CODBAR');

  Result := fValidaAbreviacaoItens And fGeraLivroFiscal(cxProgresso);
End;


Function TEntradaAutomatizada.fCarregaItensNotaElet: Boolean;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      lblGravando.Caption := 'Carregando itens, aguarde...';
      fExecutarAcao := fCarregaItensNotaEletPrg;

      ShowModal;

      Result := blnConfirma;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntradaAutomatizada.fCarregaItensNotaElet]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

procedure TEntradaAutomatizada.pSalvaCtaConsumo;
  Var
    qryCadMco: TUniQuery;
Begin
  qryCadMco := fCriaQuery;
  With qryCadMco Do
  Begin
    If blnGravaLog Then
    Begin
      SQL.Add('INSERT LOGMCO(AUTOINCREM,');
      SQL.Add('              LOG_CODOPE,');
      SQL.Add('              LOG_CTPANT,');
      SQL.Add('              LOG_CTPNOV,');
      SQL.Add('              LOG_DTACAD,');
      SQL.Add('              LOG_CODMCO) VALUES');
      SQL.Add('             (:AUTINC,');
      SQL.Add('              :CODOPE,');
      SQL.Add('              (SELECT MCO_CODCT2 FROM CADMCO WHERE MCO_CODMCO = :CODMCO),');
      SQL.Add('              :CTPNOV,');
      SQL.Add('              :DTACAD,');
      SQL.Add('              :CODMCO);');

      qryCadMco.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGMCO', VS_strCodEmp);
      qryCadMco.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryCadMco.ParamByName('DTACAD').AsDateTime := fNow;
      If fEmptyStr(cdsItens.FieldByName('ENT_CODMCO').AsString) Then
        qryCadMco.ParamByName('CODMCO').Value := Null
      Else
        qryCadMco.ParamByName('CODMCO').AsString :=  cdsItens.FieldByName('ENT_CODMCO').AsString;

      If fEmptyStr(cdsItens.FieldByName('ENT_CODCTU').AsString) Then
        qryCadMco.ParamByName('CTPNOV').Value := Null
      Else
        qryCadMco.ParamByName('CTPNOV').AsString :=  cdsItens.FieldByName('ENT_CODCTU').AsString;

      qryCadMco.ExecSQL;
    End;


    qryCadMco.SQL.Clear;

    SQL.Add('UPDATE CADMCO SET MCO_CODCT2 = :CTPNOV WHERE MCO_CODMCO = :CODMCO;');

    If fEmptyStr(cdsItens.FieldByName('ENT_CODMCO').AsString) Then
      ParamByName('CODMCO').Value := Null
    Else
      ParamByName('CODMCO').AsString :=  cdsItens.FieldByName('ENT_CODMCO').AsString;

    If fEmptyStr(cdsItens.FieldByName('ENT_CODCTU').AsString) Then
      ParamByName('CTPNOV').Value := Null
    Else
      ParamByName('CTPNOV').AsString :=  cdsItens.FieldByName('ENT_CODCTU').AsString;

    ExecSQL;
  End;
  FreeAndNil(qryCadMco);
End;

Procedure TEntradaAutomatizada.pBeforeEditItens(dtsItens: TDataSet);
Begin
  With dtsItens Do
  Begin
    FCtaAnt := FieldByName('ENT_CODCTU').AsString;
  End;
End;

procedure TEntradaAutomatizada.pBeforePostEventos(dtsEventos: TDataSet);
var
  fltTotalDupl,
  ftlTotalEventos,
  fltValor,
  fltSomaValores: Double;

begin
  if dtsEventos.State = dsEdit then
    Exit;

  // Obtenção dos valores
  fltTotalDupl := cdsDuplic.fRetSomaCampo('VALDUP');
  If fltTotalDupl <= 0 Then
    Exit;

  ftlTotalEventos := cdsMovEve.fRetSomaCampo('VALEVE');
  fltValor := dtsEventos.FieldByName('VALEVE').AsFloat;
  fltSomaValores := fFormataFloat((ftlTotalEventos + fltValor),02);

  // Verifica se a soma dos centro de custo ultrapassa o valor das duplicatas
  if fFormataFloat((fltTotalDupl - fltSomaValores), 02) < 0 then
  begin
    fMensagem('ATENÇÃO!', 'A soma dos centro de custo não pode ultrapassar o valor total das duplicatas!', ['&O k']);
    dtsEventos.Cancel;  // Cancela a operação
    Abort;           // Interrompe o fluxo do código
  end;
end;

Procedure TEntradaAutomatizada.pBeforePostItens(dtsItens: TDataSet);
var
  blnCtaPreDef: Boolean;
  blnLiberado: Boolean;
  strCodCta, strDesCta: String;
Begin
  blnLiberado := False;
  strCodCta := '';
  strDesCta := '';
  With dtsItens Do
  Begin
    blnGravaLog := False;
    blnCtaPreDef := (dtsItens.FieldByName('ENT_CODCTU').AsString = FieldByName('ENT_CODCTA').AsString) Or
                    (FieldByName('ENT_CODCTU').AsString = FieldByName('ENT_CODCT2').AsString);
    If (Not blnCtaPreDef) And
       (Not SameText(FCtaAnt, FieldByName('ENT_CODCTU').AsString)) Then
    Begin
      if FLiberadoAlteracaoPlanoConta then
        blnLiberado := True;

      if Not blnLiberado then
      begin
        blnLiberado := fLiberaAlteracao(FieldByName('ENT_CODCTA').AsString, FieldByName('ENT_CODCT2').AsString,
                                        FieldByName('ENT_CODCTU').AsString, FieldByName('ENT_CODBAR').AsString,
                                        FieldByName('ENT_DESITE').AsString);
      end;

      if blnLiberado then
      Begin
        if FExecReplicarPlanoConta then
          FLiberadoAlteracaoPlanoConta := True;
        dtsItens.FieldByName('ENT_CODCT2').AsString := FieldByName('ENT_CODCTU').AsString;
        blnGravaLog := True;
      End
      Else
      begin
        dtsItens.FieldByName('ENT_CODCTU').AsString := FCtaAnt;

        strCodCta := fTiraCaracEspeciaisPonto(FCtaAnt);
        If (Not fEmptyStr(strCodCta)) Then
        Begin
          strDesCta := fRetDescCentroCusto(strCodCta);
          dtsItens.FieldByName('ENT_DESCTA').AsString := strDesCta;
        End
        Else
          dtsItens.FieldByName('ENT_DESCTA').AsString := '';

        If FExecReplicarPlanoConta then
          FExecReplicarPlanoConta := False;
      end;
    End;
  End;
End;

Function TEntradaAutomatizada.fLiberaAlteracao(strCTA1, strCTA2, strCTANova, strCodbar, strDesite: string): Boolean;
  Var
    objLiberacao: TLiberacao;
begin

  objLiberacao := TLiberacao.Create;


  objLiberacao.objMsgLibera.pAddTexto('O Plano de Contas ' + strCTANova + ' não esta definido no Cadastro de Material de Consumo.');

  objLiberacao.objMsgLibera.pAddTexto('Produto : ' + strCodbar + ' - ' + strDesite);
  objLiberacao.objMsgLibera.pAddTexto('Plano de Contas permitidos ');
  objLiberacao.objMsgLibera.pAddTexto('Primário  : ' + FormatMaskText(MASC_CODCTA, strCTA1) );
  objLiberacao.objMsgLibera.pAddTexto('Secundário: ' + FormatMaskText(MASC_CODCTA, strCTA2) );
  objLiberacao.objMsgLibera.pAddTexto('Digite a senha para permitir a atualização.');

  objLiberacao.strDirAce := 'EUTRCT';
  objLiberacao.strMsgSen := 'Alterar Plano de Contas';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;

  FreeAndNil(objLiberacao);
End;


Procedure TEntradaAutomatizada.pAfterPostItens(dtsItens: TDataSet);
Var
  pgbProgresso : TcxProgressBar;
Begin
  With dtsItens Do
  Begin
    If blnGravaLog And
       (Not fEmptyStr(FieldByName('ENT_CODMCO').AsString)) And
       (Not SameText(FCtaAnt, FieldByName('ENT_CODCTU').AsString)) Then
      pSalvaCtaConsumo;
  End;
  If FReplicarPlanoContas Then
    pReplicarPlanoConta;

  If (FAtualizaLivroFiscal) Then
  Begin
    pgbProgresso := TcxProgressBar.Create(nil);
    Try
      fGeraLivroFiscal(pgbProgresso);
    Finally
      FreeAndNil(pgbProgresso);
	  End;
  End;
End;

function TEntradaAutomatizada.fValidaAbreviacaoItens: Boolean;
var
  stlErro: TStringList;
  strErro: String;
  frmMensagemExplicativa: TfrmMensagemExplicativa;
begin
  Result := True;
  stlErro := TStringList.Create;
  cdsItens.DisableControls;
  try
    cdsItens.First;
    while not cdsItens.eof do
    begin
      strErro := '';

      // Verifica se a abreviação fiscal está informada
      if fEmptyStr(cdsItens.FieldByName('ENT_CODABF').AsString) then
      begin
        strErro := Format('O item %s - %s está sem abreviação fiscal informada. Por favor, verificar.',
                          [cdsItens.FieldByName('ENT_CODITE').AsString,
                           cdsItens.FieldByName('ENT_DESITE').AsString]);
      end

      // Verifica se o estado do fornecedor está informado
      else if fEmptyStr(recDadFor.strEstFor) then
      begin
        strErro := Format('O Fornecedor %s - %s está sem estado informado. Por favor, verificar.',
                          [recDadFor.strCodFor, recDadFor.strNomFor]);
      end

      // Verifica o código de situação tributária
      else if fEmptyStr(fCampoTabela('ABF_CODSIT' + recDadFor.strTipAbf, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'],
                                      [cdsItens.FieldByName('ENT_CODABF').AsString, recDadFor.strEstFor], True)) then
      begin
        strErro := Format('Não foi possível determinar o Código de Situação Tributária (CST).' + sLineBreak +
                          'Por favor, verifique o cadastro da abreviação fiscal: %s para o perfil e estado: %s - %s.',
                          [cdsItens.FieldByName('ENT_CODABF').AsString, recDadFor.strTipAbf, recDadFor.strEstFor]);
      end;

      // Se houver erro, adiciona à lista de erros
      if not fEmptyStr(strErro) then
        stlErro.Add(strErro);

      cdsItens.Next;
    end;

    // Exibe os erros, se houver
    if stlErro.Count > 0 then
    begin
      Result := False;
      strErro := 'Não foi possível carregar o documento. Verifique a(s) pendência(s) abaixo:' + sLineBreak +
                 '-------------------------------------------------------------------------' + sLineBreak + sLineBreak;
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      try
        frmMensagemExplicativa.Caption := 'Erro';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 550;
        frmMensagemExplicativa.RitchObservacao.Visible := True;
        frmMensagemExplicativa.RitchObservacao.BringToFront;
        frmMensagemExplicativa.RitchObservacao.Lines.Text := strErro + stlErro.Text;
        frmMensagemExplicativa.ShowModal;
      finally
        pFreeAndNil(frmMensagemExplicativa);
      end;
    end;
  finally
    cdsItens.First;
    cdsItens.EnableControls;
    FreeAndNil(stlErro);
  end;
end;

Function TEntradaAutomatizada.fValidaCodCtas(blnMsgErro: Boolean): Boolean;
Begin
  With cdsItens Do
  Begin
    Try
      DisableControls;

      Filtered := False;
      Filter :=  'ENT_CODCTU = NULL OR ENT_CODCTU = ' + QuotedStr('');
      Filtered := True;

      Result := Not (recordcount > 0);

      If (Not Result) And blnMsgErro Then
        pMensagemOk('Informe o Plano de Contas para os produtos!');

    Except
      On E: Exception Do
      Begin
        Result := False;
        Filtered := False;
        pMensagensErro(E.Message, '[TEntradaAutomatizada.fValidaCodCtas]');
      End;
    End;

    Filtered := False;
    EnableControls;
  End;
End;

Class Function TEntradaAutomatizada.fRetDocCon(strNumDoc, strEspDoc, strSerie, strCodFor: String): String;
Begin
  Result := strNumDoc + strEspDoc + VS_strCodEmp + strSerie + strCodFor;
End;

Procedure TEntradaAutomatizada.pInicializaDadosNota;
Begin
  With recDadNot Do
  Begin
    intCtpCon := fRetCtpCon;

    strCodOpe := strLoginUsuarioLogado;
    strCodDig := strLoginUsuarioLogado;

  End;
End;

procedure TEntradaAutomatizada.pLimpaCDSDuplicata;
begin
  cdsDuplic.EmptyDataSet;
end;

Function TEntradaAutomatizada.fGravaNota: Boolean;
Begin

  Try
    pCriarFormularios(TfrmGravando, frmGravando);

    With frmGravando Do
    Begin
      cxProgressoAuto := pgbStatus;

      lblGravando.Caption := 'Aguarde...';
      fExecutarAcao := fGravaNotaPrg;

      ShowModal;

      Result := blnConfirma;

    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[EntradaAutomatizada.fGravaNota]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

function TEntradaAutomatizada.fPedidosPreNota: String;
begin
  Result := AnsiReplaceStr(
    fCampoTabela('GROUP_CONCAT(CONCAT(PEL_NUMDOC, PEL_CODEMP))', 'PEDELE', ['PEL_SEQELE'], [recNotEle.strAutInc]), ',', #13#10);
end;

Function TEntradaAutomatizada.fGravaNotaPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    objAtuFor: TAlteraFornecedorEntrada;
    oleItensPedidos: OleVariant;
    objVendor: TEntVendor;
    objOutDes: TEntOutrasDespesas;
    objEmbala: TEntEmbalagens;
    arrDocOri: TStringArrayArray; //ClientDataSet que contens os itens do recebimento de cliente (garantia)
    blnGerouLotDePreco: Boolean;
    strListaItens: String;
    blnGravouMovDet: Boolean;
    blnBaiPed,
    blnUsaConfPreNot: Boolean;
    lStrHisCtp: String;
    ArrCteMov: TArrCteMov;
    strCodErrosAuditoria,
    strMatRevAux: String;
Begin
  With recNotEle, recDadFor, recDadNot Do
  Try

   //// SE NÃO FOR ENTRADA USO CONSUMO - PRECISA TRATAR
    objAtuFor := Nil;


    blnUsaConfPreNot := fCfgSis('USACON', varBoolean) And
                        (Pos(fCfgSis('CONFME'), '1_3_') > 0) And (Not fEmptyStr(recNotEle.strAutInc));

    If blnUsaConfPreNot Then
      stlPedidos.Text := fPedidosPreNota;

    If fCfgSis('FLUPDC', varBoolean) Then
      oleItensPedidos := fDefinePedidosABaixar(blnBaiPed, cdsItens.qryQuery, stlPedidos, recNotEle.strAutInc, False, False, Nil, 'ENT_AUTELE')
    Else
      oleItensPedidos := Null;

    objVendor := Nil;
    objOutDes := Nil;
    objEmbala := Nil;
    arrDocOri := Nil; //ClientDataSet que contens os itens do recebimento de cliente (garantia)

    pInicializaDadosNota;

    if Not Self.blnValoresDesmembradosRotina then
      pDesmenbraValoresCadPag(cxProgresso);

    frmGravando.lblGravando.Caption := 'Gravando dados, aguarde...';
    Application.ProcessMessages;

    objAuditoriaSaldo.Limpar;

    fStartTransaction;

    strDocCon := fRetDocCon(strNumDoc, FEspDoc, strSerDoc, strCodFor);

    Begin
      strDocFre := '';
      fltConFre := 0;
    End;

    If Assigned(cdsCtpDet) And cdsCtpDet.Active And (cdsCtpDet.RecordCount = 1) Then
    Begin
      strCodEve := cdsCtpDet.FieldByName('CTP_CODEVE').AsString;
      FCodEveCTP := strCodEve;
    End;

    pDefineCodCta(recDadNot.strCodCta);

    If cdsMovEve.RecordCount = 1 Then
      If recDadNot.strCodCta <> fCfgSis('CTAPRI') Then
      Begin
        strCodEve := cdsMovEve.FieldByName('CODEVE').AsString;
        FCodEveCTP := strCodEve;
      End;

    If (fCfgSis('HISCTP', varBoolean)) Then
    begin
       lStrHisCtp := Self.fDocumentoHistoricoContasPagar;
       if Pos(lstrHisCtp, strHisCtp) = 0 then
       strHisCtp  := lStrHisCtp + #$A#$D + strHisCtp;
    end;

    strMatRevAux := recNotEle.strMatRev;
    If fEmptyStr(strMatRevAux) Then
      strMatRevAux := recDadFor.strTipFor;
    If fEmptyStr(strMatRevAux) Then
      strMatRevAux := fCampoTabela('FOR_MATREV', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);

    If Not blnVeioBoleto Then
      FillChar(arrLinDigCodbar, sizeOf(arrLinDigCodbar), #0);
    Result :=  fConfirmaEntradaMercadorias(strSeqGer,
                                           strListaItens,
                                           ArrCteMov,
                                           blnGravouMovDet,
                                           blnGerouLotDePreco,
                                           strMatRevAux,
                                           blnNotaImp,
                                           objAtuFor,
                                           Nil,
                                           arrLinDigCodbar,
                                           1,
                                           0,
                                           strCodOpe,
                                           strCndPag,
                                           strCodPor,
                                           strCodCta,
                                           strCodFor,
                                           strCodFaz,
                                           strNumDoc,
                                           FEspDoc,
                                           dtaDtaEnt,
                                           dtaDtaDoc,
                                           dtaIcmAnt,
                                           strSerDoc,
                                           strEstFor,
                                           IIF(blnVeioBoleto, 'S', 'N'),
                                           strDeposi,
                                           strEspVol,
                                           fltQtdVol,
                                           fltAlqFor,
                                           Nil,
                                           strCodEve,
                                           blnDevolu,
                                           strCodDig,
                                           strCodRep,
                                           blnGraFin,
                                           blnImprCP,
                                           strHisCtp,
                                           fltTotPis,
                                           fltTotCof,
                                           fltBasPis,
                                           fltBasCof,
                                           fltAlqPis,
                                           fltAlqCof,
                                           strCodCon,
                                           oleItensPedidos,
                                           strOrdIte,
                                           'frmEntMercadoriasAutomatizada', // Self.Name,
                                           blnCarPro,                       // Se carregou itens do pedido de compra
                                           recNotEle.strAutInc,             // AUTOINCREM DA NOTA FISCAL ELETRONICA
                                           strModFre,                       // Mod. Frete
                                           str_Chave,                       // Chave NFE
                                           strMotDev,                       // Motivo da Devolução
                                           cdsItens,                        // Query com os Itens da Entrada de Mercadoria
                                           objVendor,
                                           objOutDes,
                                           cdsCtpDet,
                                           strAutIncCadFis,
                                           arrDuplicata,
                                           objEmbala,
                                           cdsCadFis,
                                           strDocFre,                 // Conhecimento de frete
                                           fltConFre,                 // Conhecimento de frete
                                           strAutDev,                 // Número do AD
                                           intCtpCon,
                                           strOutIncMovGer,
                                           fltPesBru,
                                           fltPesLiq,
                                           strNaoAtualizaPreco,
                                           fltAntIcF,                 // Valor de Antecipação do Conhecimento
                                           fltBasAnF,                 // Base de Antecipação do Conhecimento
                                           blnGarantia,
                                           blnRecCliGarantia,
                                           cdsMovGad,
                                           arrDocOri,                 //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                           blnPedFilialGarantia,
                                           blnConEqu,                 //ClientDataSet que contens os itens do recebimento de cliente (garantia)
                                           blnDescontoIncondicional,  //Desconto Incondicional
                                           blnFreIpi,
                                           blnPrecoPraticado,
                                           Nil,    // frmVinculoBaixaEntregaFuturaEdocVenda: TfrmVinculoBaixaEntregaFuturaEdocVenda}
                                           False, //  blnUtilizarCFG_CLARET: boolean = False;
                                           strBcoFor, //  strBcoFor: String = '';
                                           recDadNot.strModelo, //  strCodMod: String = '';
                                           Self) And
                                           objPgoAnt.fGravaPgtosAntecipados(strSeqGer, strNumDoc, strSerDoc, fltValorDocumento);

    If Result Then
    Begin
      objAuditoriaSaldo.Adicionar(strOutIncMovGer, 'MOVGER');

      If (Not objAuditoriaSaldo.fValidouTodas(strCodErrosAuditoria)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strCodErrosAuditoria);
      End;
    End;

    if Result Then
    Begin
      fCommit;
      pImprimeCPs;
    End
    Else
      fRollBack;
      If Not blnGravouMovDet Then
        pMensagemOk('Houve falhas ao gravar os itens, se o erro persistir entre em contato com a Citel');
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TEntradaAutomatizada.fGravaNota]');
    End;
  End;

  cdsItens.IndexFieldNames := '';
End;

Function TEntradaAutomatizada.fCriaClientGruposFiscal: Boolean;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '  CAST("" AS CHAR(5)) AS ENT_CLAFIS, ';
  strSQL := strSQL + '  CAST("" AS CHAR(130)) AS ENT_NATOPE, ';
  strSQL := strSQL + '  0.00 AS ENT_ALQICM, ';
  strSQL := strSQL + '  0.00 AS ENT_VLRCON, ';
  strSQL := strSQL + '  0.00 AS ENT_BASICM, ';
  strSQL := strSQL + '  0.00 AS ENT_VALICM, ';
  strSQL := strSQL + '  0.00 AS ENT_ISENTO, ';
  strSQL := strSQL + '  0.00 AS ENT_BASRET, ';
  strSQL := strSQL + '  0.00 AS ENT_VALRET, ';
  strSQL := strSQL + '  0.00 AS ENT_BASANT, ';
  strSQL := strSQL + '  0.00 AS ENT_VALANT, ';
  strSQL := strSQL + '  0.00 AS ENT_DESACE, ';
  strSQL := strSQL + '  0.00 AS ENT_BASIPI, ';
  strSQL := strSQL + '  0.00 AS ENT_VALIPI, ';
  strSQL := strSQL + '  0.00 AS ENT_BFCPST, ';
  strSQL := strSQL + '  0.00 AS ENT_VFCPST, ';
  strSQL := strSQL + '  0.00 AS ENT_OUTRAS, ';
  strSQL := strSQL + '  0.00 AS ENT_BAERET, ';
  strSQL := strSQL + '  0.00 AS ENT_BAEIPI, ';
  strSQL := strSQL + '  0.00 AS ENT_VAERET, ';
  strSQL := strSQL + '  0.00 AS ENT_VAEIPI, ';
  strSQL := strSQL + '  0.00 AS ENT_VALFRE, ';
  strSQL := strSQL + '  0.00 AS ENT_VLRCBS, ';
  strSQL := strSQL + '  0.00 AS ENT_VLRIBS, ';
  strSQL := strSQL + '  0.00 AS ENT_VLR_IS, ';
  strSQL := strSQL + '  0.00 AS ENT_BASRT,  ';
  strSQL := strSQL + '  0.00 AS ENT_BAS_IS  ';

  cdsGruLiv := TZClient.Create(Nil, strSQL);

  Result := cdsGruLiv.fAbreClient(True, 'TEntradaAutomatizada.fCriaClientGruposFiscal');

  If Result Then
  Begin
    cdsGruLiv.EmptyDataSet;
    cdsGruLiv.IndexFieldNames := 'ENT_CLAFIS;ENT_ALQICM';
  End;
End;

function TEntradaAutomatizada.fDocumentoHistoricoContasPagar: String;
begin
    Result := Format('REF. AO DOCUMENTO No %0:s%1:s%2:s EMITIDO EM %3:s FORNECEDOR: %4:s-%5:s',
                      [fStrZero(recNotEle.strNumDoc,12), //0
                       FEspDoc, //2
                       recNotEle.strSerDoc, //2
                       FormatDateTime('DD/MM/YYYY',recNotEle.dtaDtaDoc), //3
                       recDadFor.strCodFor,    //4
                       recDadFor.strNomFor]); //5
end;

Procedure TEntradaAutomatizada.pCriaCdsCodFis;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CAST("" AS CHAR('+IIf(fCfgSis('USASAN') = 'S', '7', '3')+')) AS CODABF, ';
  strSQL := strSQL + '   CAST("" AS CHAR(3)) AS CODFIS  ';

  cdsCodFis := TZClient.Create(Nil, strSQL);

  With cdsCodFis Do
  If fAbreClient(True, 'TEntradaAutomatizada.pCriaCdsCodFis') Then
  Begin
    EmptyDataSet;

    IndexFieldNames := 'CODABF';
  End;

End;

Function TEntradaAutomatizada.fGetCodFisItem(strCodAbf, strCodIte, strCodEmp: String): String;
var
  blnSubstituido: Boolean;
Begin
  With recDadFor, cdsCodFis Do
  Begin
    If Not FindKey([strCodAbf]) Then
    Begin
      Insert;
      FieldByName('CODABF').AsString := strCodAbf;

      FieldByName('CODFIS').AsString := fCampoTabela('ABF_CODSIT' + strTipAbf, 'ABFICM', ['ABF_CODABF', 'ABF_ESTADO'],
                                                                                         [strCodAbf, strEstFor], False);
      blnSubstituido := Pos(FieldByName('CODFIS').AsString, CST_SUBSTITUICAO) > 0;

      If (strTipFor = 'M') And (Not fEmptyStr(FieldByName('CODFIS').AsString)) Then
      Begin
        If fCfgSis('CSTEUC', varInteger) = 0 Then
          cdsCodFis.FieldByName('CODFIS').AsString := cdsCodFis.FieldByName('CODFIS').AsString[1] + '90'
        Else
        Begin
          If (Pos(cdsItens.FieldByName('ENT_CLAFIS').Value, '1407_2407') > 0) And blnSubstituido Then
            cdsCodFis.FieldByName('CODFIS').AsString := cdsCodFis.FieldByName('CODFIS').AsString[1] + '60'
          Else
            cdsCodFis.FieldByName('CODFIS').AsString := cdsCodFis.FieldByName('CODFIS').AsString[1] + '90';
        End;
      End;

      Post;
    End
    Else
      blnSubstituido := Pos(FieldByName('CODFIS').AsString, CST_SUBSTITUICAO) > 0;


    If ((Pos(cdsItens.FieldByName('ENT_CLAFIS').Value, '1407_2407') > 0) And (fCfgSis('CSTEUC', varInteger) = 1) And (blnSubstituido)) Then
      Result := FieldByName('CODFIS').AsString[1] + '60'
    Else
      Result := cdsCodFis.FieldByName('CODFIS').AsString[1] + '90';

  End;
End;

Procedure TEntradaAutomatizada.pAjustaDadosFiscaisItem(const AblnSomaReforma: Boolean);
  Var
    fltClcAux: Double;
    blnSubstituido, blnAntecipado, blnIsentas: Boolean;
Begin
  With cdsItens, recDadNot, recDadFor Do
  Begin
    Edit;

    If strTipFor = 'M' Then
      FieldByName('ENT_DESITE').AsString := UpperCase(fRemoveAcento(FieldByName('ENT_DESITE').AsString));

    If blnCreIpi and (Not recDadFor.fFornecedorMaterialConsumo)  Then
    Begin
      FieldByName('ENT_BAEIPI').AsFloat  := 0;
      FieldByName('ENT_VAEIPI').AsFloat  := 0;
      FieldByName('ENT_ALEIPI').AsFloat  := 0;
    End
    Else
    Begin
      FieldByName('ENT_BASIPI').AsFloat  := 0;
      FieldByName('ENT_VALIPI').AsFloat  := 0;
      FieldByName('ENT_ALQIPI').AsFloat  := 0;
    End;

    if recDadFor.fFornecedorMaterialConsumo then
    begin
      If (FieldByName('ENT_VAEIPI').AsFloat = 0)
         And (FieldByName('ENT_BAEIPI').AsFloat > 0)Then
      Begin
        FieldByName('ENT_BAEIPI').AsFloat := 0;
      End;

    end;

    blnAntecipado := False; // Alterado depois na entrada de mercadorias

    // VERIFICAR QUANDO NÃO FOR USO / CONSUMO
    FieldByName('ENT_CODFIS').AsString := fGetCodFisItem(FieldByName('ENT_CODABF').AsString,
                                          FieldByName('ENT_CODITE').AsString,
                                          FieldByName('ENT_CODEMP').AsString);

    // ALTERAR PARA QUANDO NÃO FOR USO / CONSUMO
    blnSubstituido := Pos(FieldByName('ENT_CODFIS').AsString, CST_SUBSTITUICAO) > 0;

    If (LeftStr(FieldByName('ENT_CLAFIS').AsString, 1) = '3') Then
      FieldByName('ENT_VLRCON').AsFloat := FieldByName('ENT_BASICM').AsFloat;

    If blnSubstituido Or blnAntecipado Or blnEmpSimPau Or (strTipFor = 'M') Then
    Begin
      FieldByName('ENT_PERBAS').AsFloat  := 0;
      FieldByName('ENT_BASICM').AsFloat  := 0;
      FieldByName('ENT_ALQICM').AsFloat  := 0;
      FieldByName('ENT_VALICM').AsFloat  := 0;
    End;

    If (Not blnSubstituido) Then
    begin
      FieldByName('ENT_BASRET').AsFloat := 0;
      FieldByName('ENT_BAERET').AsFloat := 0;
    End;

    If (LeftStr(FieldByName('ENT_CLAFIS').AsString, 1) <> '3') Then
      FieldByName('ENT_VLRCON').AsFloat := FieldByName('ENT_TOTITE').AsFloat +
                                           FieldByName('ENT_VALIPI').AsFloat +
                                           FieldByName('ENT_VAEIPI').AsFloat +
                                           FieldByName('ENT_VALFRE').AsFloat +
                                           FieldByName('ENT_DESACE').AsFloat +
                                           FieldByName('ENT_VALRET').AsFloat +
                                           FieldByName('ENT_VAERET').AsFloat -
                                           IIf(blnDescontoIncondicional, 0, FieldByName('ENT_DESESP').AsFloat) +
                                           FieldByName('ENT_VFCPST').AsFloat;

    fltClcAux := fRetornaValorOutras(FieldByName('ENT_VLRCON').AsFloat,
                                     FieldByName('ENT_BASICM').AsFloat,
                                     FieldByName('ENT_VALIPI').AsFloat + FieldByName('ENT_VAEIPI').AsFloat,
                                     FieldByName('ENT_VALRET').AsFloat + FieldByName('ENT_VAERET').AsFloat, 0, 0,
                                     FieldByName('ENT_VFCPST').AsFloat);

    If objExcecaoCfopCst.fExcecaoDefinida(FieldByName('ENT_CLAFIS').AsString, FieldByName('ENT_CODFIS').AsString) Then
      blnIsentas := objExcecaoCfopCst.blnIsentas
    Else
      blnIsentas := fCodFisGravaIsentoDocEnt(FieldByName('ENT_CLAFIS').AsString, FieldByName('ENT_CODFIS').AsString, strLVPENT, strLVPISE, strLVPE70, strLVPI30, strLVPI41, strLVPI50, strLVPI51, strIOE915);

    If blnIsentas Then
    Begin
      FieldByName('ENT_ISENTO').AsFloat := fltClcAux;
      FieldByName('ENT_OUTRAS').AsFloat := 0;
    End Else
    Begin
      FieldByName('ENT_ISENTO').AsFloat := 0;
      FieldByName('ENT_OUTRAS').AsFloat := fltClcAux;
    End;

    {Req. 468382 - CBS + IBS + IS compõem o valor contábil, como no livro fiscal; Outras/Isentas acima já foram apuradas
     sem eles. O ENT_VLRCON é recalculado do zero acima, então somar aqui não acumula quando o livro é refeito}
    If AblnSomaReforma Then
      FieldByName('ENT_VLRCON').AsFloat := FieldByName('ENT_VLRCON').AsFloat +
                                           FieldByName('ENT_RFCVAL').AsFloat +
                                           FieldByName('ENT_RFIVAL').AsFloat +
                                           FieldByName('ENT_RFSVLR').AsFloat;

    Post;
  End;
End;

procedure TEntradaAutomatizada.pAplicarPlanoContaFornecedor;
  resourcestring
    STRSQL = 'SELECT CTA_DESCTA FROM CADCTA WHERE CTA_CODCTA = :CODCTA';
  Var
    Qry: TUniquery;
    strDesCta: String;
    OnValidateCodCtu: TFieldNotifyEvent;
begin
  if fEmptyStr(fTiraCaracEspeciaisPonto(Self.recDadFor.strPlnCta)) then
    Exit;

  Qry := Nil;
  strDesCta := EmptyStr;
  OnValidateCodCtu := cdsItens.FieldByName('ENT_CODCTU').OnValidate;

  Try
    Qry := fCriaQuery;
    Qry.Sql.Clear;
    Qry.Sql.Add(STRSQL);
    Qry.ParamByName('CODCTA').AsString := Self.recDadFor.strPlnCta;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
      Qry.First;
      strDesCta := Qry.FieldByName('CTA_DESCTA').AsString;
    end;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  End;

  Try
    cdsItens.FieldByName('ENT_CODCTU').OnValidate := Nil;
    pReplicarPlanoConta(Self.recDadFor.strPlnCta,strDesCta, False);
  Finally
    cdsItens.FieldByName('ENT_CODCTU').OnValidate := OnValidateCodCtu;
  End;
end;

Function TEntradaAutomatizada.fMontaGrupoLivro(cxProgresso: TcxProgressBar): Boolean;
  Var
    blnReforma: Boolean;
    blnSomaReforma: Boolean;
Begin
  Result := True;

  {Campos ENT_RF*/ENT_REFVBC vêm da DETERT (fSQLItensNotaEletronica)}
  blnReforma     := Assigned(cdsItens.FindField('ENT_RFCVAL'));
  blnSomaReforma := blnReforma And fSomarNovosImpostosDaReformaAoValorContabil;

  With cdsItens, recDadNot Do
  Begin
    DisableControls;

    If (frmGravando = Nil) Then
      pCriarFormularios(TfrmGravando, frmGravando);

    cxProgresso.Position := 0;
    cxProgresso.Properties.Max := RecordCount;
    frmGravando.lblGravando.Caption := 'Agrupando dados por alíquota, aguarde...';
    Application.ProcessMessages;

    Try
      cdsGruLiv.EmptyDataSet;

      IndexFieldNames := 'ENT_CLAFIS;ENT_ALQICM';

      First;

      While Not Eof Do
      Begin
        pAjustaDadosFiscaisItem(blnSomaReforma);

        If cdsGruLiv.FindKey([FieldByName('ENT_CLAFIS').AsString,
                              FieldByName('ENT_ALQICM').AsFloat]) Then
        Begin
          cdsGruLiv.Edit;

          cdsGruLiv.FieldByName('ENT_VLRCON').AsFloat  := cdsGruLiv.FieldByName('ENT_VLRCON').AsFloat + FieldByName('ENT_VLRCON').AsFloat - IIf(blnDescontoIncondicional, FieldByName('ENT_DESESP').AsFloat, 0);
          cdsGruLiv.FieldByName('ENT_BASICM').AsFloat  := cdsGruLiv.FieldByName('ENT_BASICM').AsFloat + FieldByName('ENT_BASICM').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALICM').AsFloat  := cdsGruLiv.FieldByName('ENT_VALICM').AsFloat + FieldByName('ENT_VALICM').AsFloat;
          cdsGruLiv.FieldByName('ENT_ISENTO').AsFloat  := cdsGruLiv.FieldByName('ENT_ISENTO').AsFloat + FieldByName('ENT_ISENTO').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASRET').AsFloat  := cdsGruLiv.FieldByName('ENT_BASRET').AsFloat + FieldByName('ENT_BASRET').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALRET').AsFloat  := cdsGruLiv.FieldByName('ENT_VALRET').AsFloat + FieldByName('ENT_VALRET').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASANT').AsFloat  := cdsGruLiv.FieldByName('ENT_BASANT').AsFloat + FieldByName('ENT_BASANT').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALANT').AsFloat  := cdsGruLiv.FieldByName('ENT_VALANT').AsFloat + FieldByName('ENT_VALANT').AsFloat;
          cdsGruLiv.FieldByName('ENT_DESACE').AsFloat  := cdsGruLiv.FieldByName('ENT_DESACE').AsFloat + FieldByName('ENT_DESACE').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASIPI').AsFloat  := cdsGruLiv.FieldByName('ENT_BASIPI').AsFloat + FieldByName('ENT_BASIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALIPI').AsFloat  := cdsGruLiv.FieldByName('ENT_VALIPI').AsFloat + FieldByName('ENT_VALIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_BFCPST').AsFloat  := cdsGruLiv.FieldByName('ENT_BFCPST').AsFloat + FieldByName('ENT_BFCPST').AsFloat;
          cdsGruLiv.FieldByName('ENT_VFCPST').AsFloat  := cdsGruLiv.FieldByName('ENT_VFCPST').AsFloat + FieldByName('ENT_VFCPST').AsFloat;
          cdsGruLiv.FieldByName('ENT_OUTRAS').AsFloat  := cdsGruLiv.FieldByName('ENT_OUTRAS').AsFloat + FieldByName('ENT_OUTRAS').AsFloat;
          cdsGruLiv.FieldByName('ENT_BAERET').AsFloat  := cdsGruLiv.FieldByName('ENT_BAERET').AsFloat + FieldByName('ENT_BAERET').AsFloat;
          cdsGruLiv.FieldByName('ENT_BAEIPI').AsFloat  := cdsGruLiv.FieldByName('ENT_BAEIPI').AsFloat + FieldByName('ENT_BAEIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VAERET').AsFloat  := cdsGruLiv.FieldByName('ENT_VAERET').AsFloat + FieldByName('ENT_VAERET').AsFloat;
          cdsGruLiv.FieldByName('ENT_VAEIPI').AsFloat  := cdsGruLiv.FieldByName('ENT_VAEIPI').AsFloat + FieldByName('ENT_VAEIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALFRE').AsFloat  := cdsGruLiv.FieldByName('ENT_VALFRE').AsFloat + FieldByName('ENT_VALFRE').AsFloat;

          If blnReforma Then
          Begin
            cdsGruLiv.FieldByName('ENT_VLRCBS').AsFloat := cdsGruLiv.FieldByName('ENT_VLRCBS').AsFloat + FieldByName('ENT_RFCVAL').AsFloat;
            cdsGruLiv.FieldByName('ENT_VLRIBS').AsFloat := cdsGruLiv.FieldByName('ENT_VLRIBS').AsFloat + FieldByName('ENT_RFIVAL').AsFloat;
            cdsGruLiv.FieldByName('ENT_VLR_IS').AsFloat := cdsGruLiv.FieldByName('ENT_VLR_IS').AsFloat + FieldByName('ENT_RFSVLR').AsFloat;
            cdsGruLiv.FieldByName('ENT_BASRT').AsFloat  := cdsGruLiv.FieldByName('ENT_BASRT').AsFloat + FieldByName('ENT_REFVBC').AsFloat;
            cdsGruLiv.FieldByName('ENT_BAS_IS').AsFloat := cdsGruLiv.FieldByName('ENT_BAS_IS').AsFloat + FieldByName('ENT_RFSBAS').AsFloat;
          End;

        End Else
        Begin
          cdsGruLiv.Append;

          cdsGruLiv.FieldByName('ENT_CLAFIS').AsString := FieldByName('ENT_CLAFIS').AsString;
          cdsGruLiv.FieldByName('ENT_NATOPE').AsString := FieldByName('ENT_NATOPE').AsString;
          cdsGruLiv.FieldByName('ENT_ALQICM').AsFloat  := FieldByName('ENT_ALQICM').AsFloat;

          cdsGruLiv.FieldByName('ENT_VLRCON').AsFloat  := FieldByName('ENT_VLRCON').AsFloat - IIf(blnDescontoIncondicional, FieldByName('ENT_DESESP').AsFloat, 0);
          cdsGruLiv.FieldByName('ENT_BASICM').AsFloat  := FieldByName('ENT_BASICM').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALICM').AsFloat  := FieldByName('ENT_VALICM').AsFloat;
          cdsGruLiv.FieldByName('ENT_ISENTO').AsFloat  := FieldByName('ENT_ISENTO').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASRET').AsFloat  := FieldByName('ENT_BASRET').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALRET').AsFloat  := FieldByName('ENT_VALRET').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASANT').AsFloat  := FieldByName('ENT_BASANT').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALANT').AsFloat  := FieldByName('ENT_VALANT').AsFloat;
          cdsGruLiv.FieldByName('ENT_DESACE').AsFloat  := FieldByName('ENT_DESACE').AsFloat;
          cdsGruLiv.FieldByName('ENT_BASIPI').AsFloat  := FieldByName('ENT_BASIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALIPI').AsFloat  := FieldByName('ENT_VALIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_BFCPST').AsFloat  := FieldByName('ENT_BFCPST').AsFloat;
          cdsGruLiv.FieldByName('ENT_VFCPST').AsFloat  := FieldByName('ENT_VFCPST').AsFloat;
          cdsGruLiv.FieldByName('ENT_OUTRAS').AsFloat  := FieldByName('ENT_OUTRAS').AsFloat;
          cdsGruLiv.FieldByName('ENT_BAERET').AsFloat  := FieldByName('ENT_BAERET').AsFloat;
          cdsGruLiv.FieldByName('ENT_BAEIPI').AsFloat  := FieldByName('ENT_BAEIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VAERET').AsFloat  := FieldByName('ENT_VAERET').AsFloat;
          cdsGruLiv.FieldByName('ENT_VAEIPI').AsFloat  := FieldByName('ENT_VAEIPI').AsFloat;
          cdsGruLiv.FieldByName('ENT_VALFRE').AsFloat  := FieldByName('ENT_VALFRE').AsFloat;

          If blnReforma Then
          Begin
            cdsGruLiv.FieldByName('ENT_VLRCBS').AsFloat := FieldByName('ENT_RFCVAL').AsFloat;
            cdsGruLiv.FieldByName('ENT_VLRIBS').AsFloat := FieldByName('ENT_RFIVAL').AsFloat;
            cdsGruLiv.FieldByName('ENT_VLR_IS').AsFloat := FieldByName('ENT_RFSVLR').AsFloat;
            cdsGruLiv.FieldByName('ENT_BASRT').AsFloat  := FieldByName('ENT_REFVBC').AsFloat;
            cdsGruLiv.FieldByName('ENT_BAS_IS').AsFloat := FieldByName('ENT_RFSBAS').AsFloat;
          End;
        End;

        cdsGruLiv.Post;

        Next;

        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TEntradaAutomatizada.fMontaGrupoLivro]');
      End;
    End;

    IndexFieldNames := '';
    EnableControls;
  End;

End;

Function TEntradaAutomatizada.fGeraLivroFiscal(cxProgresso: TcxProgressBar): Boolean;
  Var
    intContador: Integer;
    strContador: String;

    strCampos: String;
    strValores: String;

    //Dados referentes ao total
    fltValFre: Double;
    fltVlrCon: Double;
    fltBasIcm: Double;
    fltValIcm: Double;
    fltIsento: Double;
    fltBasRet: Double;
    fltValRet: Double;
    fltBasAnt: Double;
    fltValAnt: Double;
    fltDesAce: Double;
    fltBasIpi: Double;
    fltValIpi: Double;
    fltOutras: Double;

    fltBaeRet: Double;
    fltBaeIPI: Double;
    fltVaeRet: Double;
    fltVaeIPI: Double;
    fltBFCPST: Double;
    fltVFCPST: Double;


    fltVlrConCol: Double;
    fltBasIcmCol: Double;
    fltValIcmCol: Double;

    {Req. 468382 - Reforma: totais e posição para zerar as 5 classificações}
    fltVlrCbs: Double;
    fltVlrIbs: Double;
    fltVlr_Is: Double;
    fltBasRT: Double;
    fltBas_Is: Double;
    intPosRT: Integer;

  procedure pAddValueByField(strField: String; varValue: Variant);
  Begin
    With cdsCadFis Do
    Begin
      FieldByName(strField).Value := varValue;
    End;
  End;

begin
  FAtualizaLivroFiscal := False;
  cdsCadFis.EmptyDataSet;

  Result := fMontaGrupoLivro(cxProgresso);

  Try

    fltVlrCon := 0.0;
    fltBasIcm := 0.0;
    fltValIcm := 0.0;
    fltIsento := 0.0;
    fltBasRet := 0.0;
    fltValRet := 0.0;
    fltBasAnt := 0.0;
    fltValAnt := 0.0;
    fltDesAce := 0.0;
    fltValFre := 0.0;
    fltBasIpi := 0.0;
    fltValIpi := 0.0;
    fltBFCPST := 0.0;
    fltvFCPST := 0.0;
    fltOutras := 0.0;
    fltVaeRet := 0.0;
    fltVaeIpi := 0.0;
    fltBaeRet := 0.0;
    fltBaeIpi := 0.0;
    fltVlrCbs := 0.0;
    fltVlrIbs := 0.0;
    fltVlr_Is := 0.0;
    fltBasRT  := 0.0;
    fltBas_Is := 0.0;

    intContador := 1;

    strCampos  := '';
    strValores := '';

    cdsCadFis.Append;

    {Classificações sem uso ficam com 0 nos campos da Reforma, como em untEntDadosFiscais}
    For intPosRT := 1 To 5 Do
    Begin
      pAddValueByField('FIS_VLCBS' + IntToStr(intPosRT), 0);
      pAddValueByField('FIS_VLIBS' + IntToStr(intPosRT), 0);
      pAddValueByField('FIS_VL_IS' + IntToStr(intPosRT), 0);
      pAddValueByField('FIS_BCCBS' + IntToStr(intPosRT), 0);
      pAddValueByField('FIS_BCIBS' + IntToStr(intPosRT), 0);
      pAddValueByField('FIS_BC_IS' + IntToStr(intPosRT), 0);
    End;

    With cdsGruLiv Do
    Begin
      cxProgresso.Position := 0;
      cxProgresso.Properties.Max := 5;
      frmGravando.lblGravando.Caption := 'Gerando livro fiscal, aguarde...';
      Application.ProcessMessages;

      First;

      pAddValueByField('FIS_NATOPE', FieldByName('ENT_NATOPE').AsString);

      While (Not Eof) And (intContador <= 5) Do
      Begin

        strContador := IntToStr(intContador);

        fltVlrCon := fltVlrCon + FieldByName('ENT_VLRCON').AsFloat;
        fltBasIcm := fltBasIcm + FieldByName('ENT_BASICM').AsFloat;
        fltValIcm := fltValIcm + FieldByName('ENT_VALICM').AsFloat;
        fltIsento := fltIsento + FieldByName('ENT_ISENTO').AsFloat;
        fltBasRet := fltBasRet + FieldByName('ENT_BASRET').AsFloat;
        fltValRet := fltValRet + FieldByName('ENT_VALRET').AsFloat;
        fltBasAnt := fltBasAnt + FieldByName('ENT_BASANT').AsFloat;
        fltValAnt := fltValAnt + FieldByName('ENT_VALANT').AsFloat;
        fltDesAce := fltDesAce + FieldByName('ENT_DESACE').AsFloat;
        fltBasIpi := fltBasIpi + FieldByName('ENT_BASIPI').AsFloat;
        fltValIpi := fltValIpi + FieldByName('ENT_VALIPI').AsFloat;
        fltBFCPST:=  fltBFCPST + FieldByName('ENT_BFCPST').AsFloat;
        fltVFCPST:=  fltVFCPST + FieldByName('ENT_VFCPST').AsFloat;
        fltValFre := fltValFre + FieldByName('ENT_VALFRE').AsFloat;
        fltOutras := fltOutras + FieldByName('ENT_OUTRAS').AsFloat;
        fltVaeRet := fltVaeRet + FieldByName('ENT_VAERET').AsFloat;
        fltVaeIPI := fltVaeIPI + FieldByName('ENT_VAEIPI').AsFloat;
        fltBaeRet := fltBaeRet + FieldByName('ENT_BAERET').AsFloat;
        fltBaeIPI := fltBaeIPI + FieldByName('ENT_BAEIPI').AsFloat;

        fltVlrConCol := FieldByName('ENT_VLRCON').AsFloat;
        fltBasIcmCol := FieldByName('ENT_BASICM').AsFloat;
        fltValIcmCol := FieldByName('ENT_VALICM').AsFloat;

        pAddValueByField('FIS_CLFSC' + strContador, FieldByName('ENT_CLAFIS').AsString);
        pAddValueByField('FIS_VLCON' + strContador, fltVlrConCol);
        pAddValueByField('FIS_BASIC' + strContador, fltBasIcmCol);
        pAddValueByField('FIS_ALQIC' + strContador, FieldByName('ENT_ALQICM').AsFloat);
        pAddValueByField('FIS_VLRIC' + strContador, fltValIcmCol);

        pAddValueByField('FIS_OUTRA' + strContador, FieldByName('ENT_OUTRAS').AsFloat);

        pAddValueByField('FIS_ISENT' + strContador, FieldByName('ENT_ISENTO').AsFloat);
        pAddValueByField('FIS_BCRET' + strContador, FieldByName('ENT_BASRET').AsFloat);
        pAddValueByField('FIS_RETID' + strContador, FieldByName('ENT_VALRET').AsFloat);
        pAddValueByField('FIS_BASAN' + strContador, FieldByName('ENT_BASANT').AsFloat);
        pAddValueByField('FIS_ANTIC' + strContador, FieldByName('ENT_VALANT').AsFloat);
        pAddValueByField('FIS_BASIP' + strContador, FieldByName('ENT_BASIPI').AsFloat);
        pAddValueByField('FIS_VLRIP' + strContador, FieldByName('ENT_VALIPI').AsFloat);
        pAddValueByField('FIS_BFCPS' + strContador, FieldByName('ENT_BFCPST').AsFloat);
        pAddValueByField('FIS_VFCPS' + strContador, FieldByName('ENT_VFCPST').AsFloat);
        pAddValueByField('FIS_DACES' + strContador, FieldByName('ENT_DESACE').AsFloat);
        pAddValueByField('FIS_VLFRE' + strContador, FieldByName('ENT_VALFRE').AsFloat);

        pAddValueByField('FIS_BAEIP' + strContador, FieldByName('ENT_BAEIPI').AsFloat);
        pAddValueByField('FIS_BAERE' + strContador, FieldByName('ENT_BAERET').AsFloat);
        pAddValueByField('FIS_VAEIP' + strContador, FieldByName('ENT_VAEIPI').AsFloat);
        pAddValueByField('FIS_VAERE' + strContador, FieldByName('ENT_VAERET').AsFloat);

        fltVlrCbs := fltVlrCbs + FieldByName('ENT_VLRCBS').AsFloat;
        fltVlrIbs := fltVlrIbs + FieldByName('ENT_VLRIBS').AsFloat;
        fltVlr_Is := fltVlr_Is + FieldByName('ENT_VLR_IS').AsFloat;
        fltBasRT  := fltBasRT  + FieldByName('ENT_BASRT').AsFloat;
        fltBas_Is := fltBas_Is + FieldByName('ENT_BAS_IS').AsFloat;

        pAddValueByField('FIS_VLCBS' + strContador, FieldByName('ENT_VLRCBS').AsFloat);
        pAddValueByField('FIS_VLIBS' + strContador, FieldByName('ENT_VLRIBS').AsFloat);
        pAddValueByField('FIS_VL_IS' + strContador, FieldByName('ENT_VLR_IS').AsFloat);
        pAddValueByField('FIS_BCCBS' + strContador, FieldByName('ENT_BASRT').AsFloat);
        pAddValueByField('FIS_BCIBS' + strContador, FieldByName('ENT_BASRT').AsFloat);
        pAddValueByField('FIS_BC_IS' + strContador, FieldByName('ENT_BAS_IS').AsFloat);

        Next;
        Inc(intContador);

        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      End;

    End;

    {*****************************************}
    {* CAMPOS REFERENTES AOS TOTAIS          *}
    {**************************************MV*}
    pAddValueByField('FIS_CLFSCT', null);
    pAddValueByField('FIS_VLCONT', fltVlrCon);
    pAddValueByField('FIS_BASICT', fltBasIcm);
    pAddValueByField('FIS_ALQICT', null);
    pAddValueByField('FIS_VLRICT', fltValIcm);
    pAddValueByField('FIS_OUTRAT', fltOutras);
    pAddValueByField('FIS_ISENTT', fltIsento);
    pAddValueByField('FIS_BCRETT', fltBasRet);
    pAddValueByField('FIS_RETIDT', fltValRet);
    pAddValueByField('FIS_BASANT', fltBasAnt);
    pAddValueByField('FIS_ANTICT', fltValAnt);
    pAddValueByField('FIS_BASIPT', fltBasIpi);
    pAddValueByField('FIS_VLRIPT', fltValIpi);
    pAddValueByField('FIS_BFCPST', fltBFCPST);
    pAddValueByField('FIS_VFCPST', fltVFCPST);
    pAddValueByField('FIS_DACEST', fltDesAce);
    pAddValueByField('FIS_VLFRET', fltValFre);
    pAddValueByField('FIS_VAERET', fltVaeRet);
    pAddValueByField('FIS_VAEIPI', fltVaeIpi);
    pAddValueByField('FIS_BAERET', fltBaeRet);
    pAddValueByField('FIS_BAEIPI', fltBaeIpi);
    {Req. 468382 - com os totais da Reforma preenchidos, fConfirmaEntradaMercadorias grava FIS_TOT*, AUXFIS e AUXMOV}
    pAddValueByField('FIS_VLCBST', fltVlrCbs);
    pAddValueByField('FIS_VLIBST', fltVlrIbs);
    pAddValueByField('FIS_VL_IST', fltVlr_Is);
    pAddValueByField('FIS_BCCBST', fltBasRT);
    pAddValueByField('FIS_BCIBST', fltBasRT);
    pAddValueByField('FIS_BC_IST', fltBas_Is);

    {*****************************************}
    {* CAMPOS ESPECIFICOS DO LIVRO FISCAL    *}
    {**************************************MV*}
    pAddValueByField('FIS_NUMDOC', recNotEle.strNumDoc);
    pAddValueByField('FIS_SERIE_', recNotEle.strSerDoc);
    pAddValueByField('FIS_ESPDOC', FEspDoc);
    pAddValueByField('FIS_FORCLI', recNotEle.strCodFor);
    pAddValueByField('FIS_DTADOC', recNotEle.dtaDtaDoc);
    pAddValueByField('FIS_DTAENT', recDadNot.dtaDtaEnt);
    pAddValueByField('FIS_ESTADO', recDadFor.strEstFor);

    pAddValueByField('FIS_ENTSAI', 'E');
    pAddValueByField('FIS_TIP_FC', 'F');
    pAddValueByField('FIS_HISTOR', null);
    pAddValueByField('AUTOINCREM', Succ(cdsCadFis.RecordCount));

    cdsCadFis.Post;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TEntradaAutomatizada.fGeraLivroFiscal]');
    End;
  End;

end;

Class procedure TEntradaAutomatizada.pCriaClientLivro(Var cdsCadFis: TUniClientDataSet; objSelf: TComponent);
  Var
    strSQL: String;
    qryGen: TUniQuery;
    dspGen: TUniDataSetProvider;

  procedure pSetaClientCadFis;
    Var
      intCont: Integer;
  begin

    for intCont := 0 To cdsCadFis.Fields.Count-1 Do
    Begin
      If cdsCadFis.Fields[intCont].DataType In [ftFloat, ftBCD, ftCurrency] Then
        TFloatField(cdsCadFis.Fields[intCont]).DisplayFormat := '##0.00';
      Application.ProcessMessages;
    End;

  end;

begin
  If Not Assigned(cdsCadFis) Then
    cdsCadFis := TUniClientDataSet.Create(objSelf);

  cdsCadFis.Close;

  qryGen := fCriaQuery(objSelf);
  dspGen := TUniDataSetProvider.Create(objSelf);
  Try
    qryGen.Connection.ExecSQL('SET SESSION sql_mode = ""');
    dspGen.DataSet := qryGen;
    cdsCadFis.SetProvider(dspGen);

    strSQL := '';
    strSQL := strSQL + 'SELECT';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS FIS_DTAENT,';
    strSQL := strSQL + '  ''            '' AS FIS_NUMDOC,';
    strSQL := strSQL + '  ''            '' AS FIS_NUMDO2,';
    strSQL := strSQL + '  ''  '' AS FIS_ESPDOC,';
    strSQL := strSQL + '  '' '' AS FIS_ENTSAI,';
    strSQL := strSQL + '  CONVERT(NULL, DATE) AS FIS_DTADOC,';
    strSQL := strSQL + '  '' '' AS FIS_TIP_FC,';
    strSQL := strSQL + '  ''        '' AS FIS_FORCLI,';
    strSQL := strSQL + '  CAST('''' AS CHAR(60)) AS FIS_HISTOR,';
    strSQL := strSQL + '  '' '' AS FIS_NFCOMP,';
    strSQL := strSQL + '  '' '' AS FIS_NOTESP,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSC1,';
    strSQL := strSQL + '  0.00 AS FIS_VLCON1,';
    strSQL := strSQL + '  0.00 AS FIS_BASIC1,';
    strSQL := strSQL + '  0.00 AS FIS_ALQIC1,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIC1,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRA1,';
    strSQL := strSQL + '  0.00 AS FIS_ISENT1,';
    strSQL := strSQL + '  0.00 AS FIS_RETID1,';
    strSQL := strSQL + '  0.00 AS FIS_BASIP1,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIP1,';
    strSQL := strSQL + '  0.00 AS FIS_BCRET1,';
    strSQL := strSQL + '  0.00 AS FIS_DACES1,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRE1,';
    strSQL := strSQL + '  0.00 AS FIS_VLCON2,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSC2,';
    strSQL := strSQL + '  0.00 AS FIS_BASIC2,';
    strSQL := strSQL + '  0.00 AS FIS_ALQIC2,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIC2,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRA2,';
    strSQL := strSQL + '  0.00 AS FIS_ISENT2,';
    strSQL := strSQL + '  0.00 AS FIS_RETID2,';
    strSQL := strSQL + '  0.00 AS FIS_BASIP2,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIP2,';
    strSQL := strSQL + '  0.00 AS FIS_BCRET2,';
    strSQL := strSQL + '  0.00 AS FIS_DACES2,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRE2,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSC3,';
    strSQL := strSQL + '  0.00 AS FIS_VLCON3,';
    strSQL := strSQL + '  0.00 AS FIS_BASIC3,';
    strSQL := strSQL + '  0.00 AS FIS_ALQIC3,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIC3,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRA3,';
    strSQL := strSQL + '  0.00 AS FIS_ISENT3,';
    strSQL := strSQL + '  0.00 AS FIS_RETID3,';
    strSQL := strSQL + '  0.00 AS FIS_BASIP3,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIP3,';
    strSQL := strSQL + '  0.00 AS FIS_BCRET3,';
    strSQL := strSQL + '  0.00 AS FIS_DACES3,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRE3,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSC4,';
    strSQL := strSQL + '  0.00 AS FIS_VLCON4,';
    strSQL := strSQL + '  0.00 AS FIS_BASIC4,';
    strSQL := strSQL + '  0.00 AS FIS_ALQIC4,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIC4,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRA4,';
    strSQL := strSQL + '  0.00 AS FIS_ISENT4,';
    strSQL := strSQL + '  0.00 AS FIS_RETID4,';
    strSQL := strSQL + '  0.00 AS FIS_BASIP4,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIP4,';
    strSQL := strSQL + '  0.00 AS FIS_BCRET4,';
    strSQL := strSQL + '  0.00 AS FIS_DACES4,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRE4,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSC5,';
    strSQL := strSQL + '  0.00 AS FIS_VLCON5,';
    strSQL := strSQL + '  0.00 AS FIS_BASIC5,';
    strSQL := strSQL + '  0.00 AS FIS_ALQIC5,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIC5,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRA5,';
    strSQL := strSQL + '  0.00 AS FIS_ISENT5,';
    strSQL := strSQL + '  0.00 AS FIS_RETID5,';
    strSQL := strSQL + '  0.00 AS FIS_BASIP5,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIP5,';
    strSQL := strSQL + '  0.00 AS FIS_BCRET5,';
    strSQL := strSQL + '  0.00 AS FIS_DACES5,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRE5,';
    strSQL := strSQL + '  ''    '' AS FIS_CLFSCT,';
    strSQL := strSQL + '  0.00 AS FIS_VLCONT,';
    strSQL := strSQL + '  0.00 AS FIS_BASICT,';
    strSQL := strSQL + '  0.00 AS FIS_ALQICT,';
    strSQL := strSQL + '  0.00 AS FIS_VLRICT,';
    strSQL := strSQL + '  0.00 AS FIS_OUTRAT,';
    strSQL := strSQL + '  0.00 AS FIS_ISENTT,';
    strSQL := strSQL + '  0.00 AS FIS_RETIDT,';
    strSQL := strSQL + '  0.00 AS FIS_BASANT,';
    strSQL := strSQL + '  0.00 AS FIS_ANTICT,';
    strSQL := strSQL + '  0.00 AS FIS_BASIPT,';
    strSQL := strSQL + '  0.00 AS FIS_VLRIPT,';
    strSQL := strSQL + '  0.00 AS FIS_BCRETT,';
    strSQL := strSQL + '  0.00 AS FIS_DACEST,';
    strSQL := strSQL + '  0.00 AS FIS_VLFRET,';

    strSQL := strSQL + '  0.00 AS FIS_BASAN1,';
    strSQL := strSQL + '  0.00 AS FIS_ANTIC1,';
    strSQL := strSQL + '  0.00 AS FIS_BASAN2,';
    strSQL := strSQL + '  0.00 AS FIS_ANTIC2,';
    strSQL := strSQL + '  0.00 AS FIS_BASAN3,';
    strSQL := strSQL + '  0.00 AS FIS_ANTIC3,';
    strSQL := strSQL + '  0.00 AS FIS_BASAN4,';
    strSQL := strSQL + '  0.00 AS FIS_ANTIC4,';
    strSQL := strSQL + '  0.00 AS FIS_BASAN5,';
    strSQL := strSQL + '  0.00 AS FIS_ANTIC5,';

    strSQL := strSQL + '  ''   '' AS FIS_CODEMP,';
    strSQL := strSQL + '  ''   '' AS FIS_SERIE_,';
    strSQL := strSQL + '  ''   '' AS FIS_ESTADO,';
    strSQL := strSQL + '  0.00 AS FIS_BAERET,';
    strSQL := strSQL + '  0.00 AS FIS_VAERET,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIPI,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIPI,';

    strSQL := strSQL + '  0.00 AS FIS_BAERE1,';
    strSQL := strSQL + '  0.00 AS FIS_VAERE1,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIP1,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIP1,';

    strSQL := strSQL + '  0.00 AS FIS_BAERE2,';
    strSQL := strSQL + '  0.00 AS FIS_VAERE2,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIP2,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIP2,';

    strSQL := strSQL + '  0.00 AS FIS_BAERE3,';
    strSQL := strSQL + '  0.00 AS FIS_VAERE3,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIP3,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIP3,';

    strSQL := strSQL + '  0.00 AS FIS_BAERE4,';
    strSQL := strSQL + '  0.00 AS FIS_VAERE4,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIP4,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIP4,';
    strSQL := strSQL + '  0.00 AS FIS_ALQFCP,';

    strSQL := strSQL + '  0.00 AS FIS_BAERE5,';
    strSQL := strSQL + '  0.00 AS FIS_VAERE5,';
    strSQL := strSQL + '  0.00 AS FIS_BAEIP5,';
    strSQL := strSQL + '  0.00 AS FIS_VAEIP5,';

    strSQL := strSQL + '  0.00 AS FIS_BFCPS1, ';
    strSQL := strSQL + '  0.00 AS FIS_BFCPS2, ';
    strSQL := strSQL + '  0.00 AS FIS_BFCPS3, ';
    strSQL := strSQL + '  0.00 AS FIS_BFCPS4, ';
    strSQL := strSQL + '  0.00 AS FIS_BFCPS5, ';

    strSQL := strSQL + '  0.00 AS FIS_VFCPS1, ';
    strSQL := strSQL + '  0.00 AS FIS_VFCPS2, ';
    strSQL := strSQL + '  0.00 AS FIS_VFCPS3, ';
    strSQL := strSQL + '  0.00 AS FIS_VFCPS4, ';
    strSQL := strSQL + '  0.00 AS FIS_VFCPS5, ';

    strSQL := strSQL + '  0.00 AS FIS_PFCPS1, ';
    strSQL := strSQL + '  0.00 AS FIS_PFCPS2, ';
    strSQL := strSQL + '  0.00 AS FIS_PFCPS3, ';
    strSQL := strSQL + '  0.00 AS FIS_PFCPS4, ';
    strSQL := strSQL + '  0.00 AS FIS_PFCPS5, ';

    strSQL := strSQL + '  0.00 AS FIS_BFCPST, ';
    strSQL := strSQL + '  0.00 AS FIS_PFCPST, ';
    strSQL := strSQL + '  0.00 AS FIS_VFCPST, ';
    strSQL := strSQL + '  0.00 AS FIS_VALISS, ';
    strSQL := strSQL + '  0.00 AS FIS_ALQISS, ';
    strSQL := strSQL + '  0.00 AS FIS_BASISS, ';

    strSQL := strSQL + '  CAST('''' AS CHAR(4)) AS FIS_CDSERV, ';
    strSQL := strSQL + '  CAST('''' AS CHAR(10)) AS FIS_CODVER, ';
    strSQL := strSQL + '  0.00 AS FIS_VREPIS, ';
    strSQL := strSQL + '  0.00 AS FIS_VRECOF, ';
    strSQL := strSQL + '  0.00 AS FIS_RECSSL, ';
    strSQL := strSQL + '  0.00 AS FIS_RETISS, ';
    strSQL := strSQL + '  0.00 AS FIS_REIRRF, ';
    strSQL := strSQL + '  0.00 AS FIS_REINSS, ';
    strSQL := strSQL + '  0.00 AS FIS_RINSSP, ';

    strSQL := strSQL + '  0.00 AS FIS_AQLFCP, ';

    strSQL := strSQL + '  0.00 AS FIS_BAFCP1, ';
    strSQL := strSQL + '  0.00 AS FIS_BAFCP2, ';
    strSQL := strSQL + '  0.00 AS FIS_BAFCP3, ';
    strSQL := strSQL + '  0.00 AS FIS_BAFCP4, ';
    strSQL := strSQL + '  0.00 AS FIS_BAFCP5, ';

    strSQL := strSQL + '  0.00 AS FIS_VLFCP1, ';
    strSQL := strSQL + '  0.00 AS FIS_VLFCP2, ';
    strSQL := strSQL + '  0.00 AS FIS_VLFCP3, ';
    strSQL := strSQL + '  0.00 AS FIS_VLFCP4, ';
    strSQL := strSQL + '  0.00 AS FIS_VLFCP5,';



    If (fSetaPais = opcParaguai) Then
    Begin
      strSQL := strSQL + '  0.00 AS FIS_VLIVA0, ';
      strSQL := strSQL + '  0.00 AS FIS_VLIVA5, ';
      strSQL := strSQL + '  0.00 AS FIS_VIVA10, ';
    End;

    strSQL := strSQL + '  '''' AS FIS_TB06RE, ';
    strSQL := strSQL + '  '''' AS FIS_TB01RE, ';

    strSQL := strSQL + '  CAST('''' AS CHAR(130)) AS FIS_NATOPE,';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO1, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO2, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO3, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO4, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO5, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO6, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO7, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMO8, ';
    strSQL := strSQL + '  0.00 AS FIS_QBCMOT, ';

    strSQL := strSQL + '  0.00 AS FIS_ADREM1, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM2, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM3, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM4, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM5, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM6, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM7, ';
    strSQL := strSQL + '  0.00 AS FIS_ADREM8, ';

    strSQL := strSQL + '  0.00 AS FIS_VALMO1, ';
    strSQL := strSQL + '  0.00 AS FIS_VALMO2, ';
    strSQL := strSQL + '  0.00 AS FIS_VALMO3, ';
    strSQL := strSQL + '  0.00 AS FIS_VALMO4, ';
    strSQL := strSQL + '  0.00 AS FIS_VALMO5,';
    strSQL := strSQL + '  0.00 AS FIS_VALMO6,';
    strSQL := strSQL + '  0.00 AS FIS_VALMO7,';
    strSQL := strSQL + '  0.00 AS FIS_VALMO8,';
    strSQL := strSQL + '  0.00 AS FIS_VALMOT,';
    strSQL := strSQL + '  0.00 AS FIS_VLCBS1, ';
    strSQL := strSQL + '  0.00 AS FIS_VLCBS2, ';
    strSQL := strSQL + '  0.00 AS FIS_VLCBS3, ';
    strSQL := strSQL + '  0.00 AS FIS_VLCBS4, ';
    strSQL := strSQL + '  0.00 AS FIS_VLCBS5, ';
    strSQL := strSQL + '  0.00 AS FIS_VLCBST, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBS1, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBS2, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBS3, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBS4, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBS5, ';
    strSQL := strSQL + '  0.00 AS FIS_VLIBST, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IS1, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IS2, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IS3, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IS4, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IS5, ';
    strSQL := strSQL + '  0.00 AS FIS_VL_IST, ';
    strSQL := strSQL + '  0.00 AS FIS_TPROIS, ';
    strSQL := strSQL + '  0.00 AS FIS_BCCBS1, ';
    strSQL := strSQL + '  0.00 AS FIS_BCCBS2, ';
    strSQL := strSQL + '  0.00 AS FIS_BCCBS3, ';
    strSQL := strSQL + '  0.00 AS FIS_BCCBS4, ';
    strSQL := strSQL + '  0.00 AS FIS_BCCBS5, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBS1, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBS2, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBS3, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBS4, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBS5, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IS1, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IS2, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IS3, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IS4, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IS5, ';
      { Req. 468382 - totais das bases para a coluna Total do resumo da entrada }
    strSQL := strSQL + '  0.00 AS FIS_BCCBST, ';
    strSQL := strSQL + '  0.00 AS FIS_BCIBST, ';
    strSQL := strSQL + '  0.00 AS FIS_BC_IST, ';
    strSQL := strSQL + '  0 AS AUTOINCREM LIMIT 0';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      pSetaClient(qryGen);
      cdsCadFis.Open;
      pSetaClientCadFis;

      Close;
    End;

  Finally
    cdsCadFis.SetProvider(nil);
    FreeAndNil(dspGen);
    FreeAndNil(qryGen);
  End;
end;

Class Function TEntradaAutomatizada.fRefazCondPagamento(var arrDuplicata: TarrDuplicata; dtaDtaDoc: TDateTime): String;
  Var
    intContador : Integer;
    arrDatas    : TDateArray;
begin
  intContador := 0;

  While (intContador <= 23)                         And
        (ArrDuplicata[intContador].dtaDtaVen <> '') Do
  Begin

    SetLength(arrDatas, intContador+1);
    arrDatas[intContador] := StrToDate(ArrDuplicata[intContador].dtaDtaVen);
    Inc(intContador);

  End;

  Result := fRetornaCndPag(arrDatas, dtaDtaDoc);
end;

Class Function TEntradaAutomatizada.fMontaDuplicatasDupEle(var arrDuplicata: TarrDuplicata; strAutInc: String; dtaDtaDoc: TDateTime): String;
   Var
     intNumDupEle: Integer;
     qryDupEle: TUniQuery;
Begin
  Result := '';

  pZeraDigDuplic(arrDuplicata);

  intNumDupEle := 0;
  qryDupEle := fCriarQuery('SELECT * FROM DUPELE WHERE DUP_SEQELE = ' + QuotedStr(strAutInc) + 'ORDER BY AUTOINCREM', Nil);

  With qryDupEle Do
  Begin
    Open;

    if (RecordCount > 0) And (RecordCount <= 24) Then
    Begin
      First;

      While Not Eof Do
      Begin
        Inc(intNumDupEle);
        With ArrDuplicata[RecNo - 1] Do
        Begin
          intNumDup       := intNumDupEle;
          strSequen       := Chr(64 + intNumDupEle);
          curValor        := FieldByName('DUP_VALDUP').AsFloat;
          dtaDtaVen       := DateToStr(FieldByName('DUP_DTAVEN').AsDateTime);
          strUsaChq       := 'N';
          strHist02       := '';
        End;

        Next;
      End;

      Result := fRefazCondPagamento(arrDuplicata, dtaDtaDoc);
    End;

  End;

  FreeAndNil(qryDupEle);
End;

procedure TEntradaAutomatizada.pMontaCdsDuplic;
  Var
    intContador: Integer;
Begin
  cdsDuplic.EmptyDataSet;

  If Not recDadNot.blnGravaCtaPag Then
    Exit;

  For intContador := Low(ArrDuplicata) To High(ArrDuplicata) Do
  With cdsDuplic, ArrDuplicata[intContador] Do
  If Not fEmptyStr(dtaDtaVen) Then
  Begin
    Append;

    FieldByName('DTAVEN').AsDateTime := StrToDate(dtaDtaVen);
    FieldByName('VALDUP').AsFloat    := curValor;

    Post;
  End;

End;

procedure TEntradaAutomatizada.pIncluiEvento(strCodEve, strDesEve: String; fltValEve: Double);
Begin
  With cdsMovEve Do
  Begin
    cdsMovEve.DisableControls;
    try
      If FindKey([strCodEve]) Then
        Edit
      Else
        Insert;

      FieldByName('CODEVE').AsString := strCodEve;
      FieldByName('DESEVE').AsString := strDesEve;
      FieldByName('VALEVE').AsFloat  := fltValEve;

      Post;
    finally
      cdsMovEve.EnableControls;
    end;
  End;
End;

procedure TEntradaAutomatizada.pExcluiEvento;
Begin
  With cdsMovEve Do
  Begin
    If IsEmpty Then
      Exit;

    Delete;
  End;
End;

Function TEntradaAutomatizada.fValidaEventos: Boolean;
Begin
  Result := True;

  If Not recDadNot.blnGravaCtaPag Then
  Begin
    Result := True;
    Exit;
  End;

  if (fCfgSis('CTPOBE', varBoolean)) and (cdsMovEve.recordCount < 1) Then
  Begin
    Result := False;
    fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
    Exit;
  End;

  if Self.blnValoresDesmembradosRotina then
    Result := RoundTo(cdsItens.fRetSomaCampo('ENT_VLRCON') - cdsCtpDet.fRetSomaCampo('CTP_VALDUP'), -2) = 0
  else
    if (fCfgSis('CTPOBE', varBoolean)) Then
      Result := RoundTo(cdsItens.fRetSomaCampo('ENT_VLRCON') - cdsMovEve.fRetSomaCampo('VALEVE'), -2) = 0;

  If Not Result Then
    pMensagemOk('O Total destinado aos Centro de Custos deve ser igual ao total da nota!')
End;

function TEntradaAutomatizada.fValidaValorTotalEventos: Boolean;
var
  fltTotalDupl,
  ftlTotalEventos: Double;
begin
  Result := True;
  // Obtenção dos valores
  fltTotalDupl := cdsDuplic.fRetSomaCampo('VALDUP');
  if fltTotalDupl <= 0 Then
    Exit;

  ftlTotalEventos := cdsMovEve.fRetSomaCampo('VALEVE');
  if ftlTotalEventos <= 0 Then
    exit;

  // Verifica se a soma dos centro de custo ultrapassa o valor das duplicatas
  if fFormataFloat((fltTotalDupl - ftlTotalEventos), 02) <> 0 then
  begin
    fMensagem('ATENÇÃO!', 'A soma dos valores dos centro de custo precisa ser igual ao total das duplicatas!', ['&O k']);
    Result := False;
  end;
end;

procedure TEntradaAutomatizada.pDefineCodCta(var AStrCodCta: String);
var strAntCodCta: String;
begin
  AStrCodCta := fCfgSis('CTAPRI'); // SOMENTE QUANDO TEM DESMENBRAMENTO
  cdsItens.First;
  strAntCodCta := cdsItens.FieldByName('ENT_CODCTU').AsString;
  While Not cdsItens.Eof Do
  Begin
    If strAntCodCta <> cdsItens.FieldByName('ENT_CODCTU').AsString Then
      Exit;
    cdsItens.Next;
  End;
  AStrCodCta := strAntCodCta;
end;

procedure TEntradaAutomatizada.pDesmembrarValoresCadPag(cxProgresso: TcxProgressBar; blnAbrirFrmDesmembramento: boolean);
  Var
    fltVlrCon,
    fltFatRes,
    fltTotRes: Double;
    intContador,
    intConTot,
    intQtdEve,
    intQtdTot,
    I: Integer;
  frmDesmembrValores: TfrmDesmembrValores;
Begin


  fltVlrCon := cdsItens.fRetSomaCampo('ENT_VLRCON');

  // AGRUPA PLANO DE CONTAS
  With cdsItens Do
  Try
    cdsTotCta.EmptyDataSet;
    cdsCtpDet.EmptyDataSet;

    DisableControls;
    First;

    While Not Eof Do
    Begin

      If cdsTotCta.FindKey([FieldByName('ENT_CODCTU').AsString]) Then
      Begin
        cdsTotCta.Edit;
        cdsTotCta.FieldByName('TOTCTA').AsFloat := cdsTotCta.FieldByName('TOTCTA').AsFloat + FieldByName('ENT_VLRCON').AsFloat;
      End Else
      Begin
        cdsTotCta.Append;
        cdsTotCta.FieldByName('CODCTA').AsString := FieldByName('ENT_CODCTU').AsString;
        cdsTotCta.FieldByName('TOTCTA').AsFloat  := FieldByName('ENT_VLRCON').AsFloat;
      End;

      cdsTotCta.Post;
      if Assigned(cxProgresso) then
      begin
        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      end;

      Next;
    End;

  Finally
    EnableControls;
  End;

  Try
    cdsMovEve.DisableControls;
    cdsMovEve.IndexFieldNames := 'VALEVE';

    intQtdEve := cdsMovEve.RecordCount;
    intQtdTot := intQtdEve * cdsTotCta.RecordCount;
    intConTot := 0;
    cdsTotCta.First;


    fltFatRes := 1;
    cdsTotCta.First;

    While Not cdsTotCta.Eof Do
    Begin
      fltTotRes   := cdsTotCta.FieldByName('TOTCTA').AsFloat;

      intContador := 0;

      cdsMovEve.First;
      While Not cdsMovEve.Eof Do
      Begin
        Inc(intContador);
        Inc(intConTot);

        For I:= 0 to lstEmpRateioDespesa.Count - 1 Do
        Begin


          cdsCtpDet.Append;
          If Not(fEmptyStr(lstEmpRateioDespesa[I])) Then
            cdsCtpDet.FieldByName('CTP_CODEMP').AsString := lstEmpRateioDespesa[I]
          Else
            cdsCtpDet.FieldByName('CTP_CODEMP').AsString := VS_strCodEmp;
          cdsCtpDet.FieldByName('CTP_CODCTA').AsString := cdsTotCta.FieldByName('CODCTA').AsString;
          cdsCtpDet.FieldByName('CTP_CODEVE').AsString := cdsMovEve.FieldByName('CODEVE').AsString;

          If intContador = intQtdEve Then
            cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat := fltTotRes /  lstEmpRateioDespesa.Count

          Else If RoundTo(cdsTotCta.FieldByName('TOTCTA').AsFloat * (cdsMovEve.FieldByName('VALEVE').AsFloat / fltVlrCon) , -2) < fltTotRes Then
             cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat := RoundTo(cdsTotCta.FieldByName('TOTCTA').AsFloat * (cdsMovEve.FieldByName('VALEVE').AsFloat / fltVlrCon) , -2) /  lstEmpRateioDespesa.Count
          Else
             cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat := fltTotRes /  lstEmpRateioDespesa.Count;;

          If intConTot = intQtdTot Then
            cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat := fltFatRes /  lstEmpRateioDespesa.Count

          Else If RoundTo(cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat / fltVlrCon, -15) < fltFatRes Then
            cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat := RoundTo(cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat / fltVlrCon, -15)
          Else
            cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat := fltFatRes /  lstEmpRateioDespesa.Count; ;

          cdsCtpDet.FieldByName('TIPOACAO').AsString := '1';

          cdsCtpDet.Post;

          if i = lstEmpRateioDespesa.Count -1 then
          Begin

            If fltFatRes - cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat > 0 Then
              fltFatRes := fltFatRes - (cdsCtpDet.FieldByName('CTP_FATCAL').AsFloat * lstEmpRateioDespesa.Count)
            Else
              fltFatRes := 0;

            If fltTotRes - cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat > 0 Then
              fltTotRes := fltTotRes - (cdsCtpDet.FieldByName('CTP_VALDUP').AsFloat * lstEmpRateioDespesa.Count)
            Else
              fltTotRes := 0;
          End;
        End;

        cdsMovEve.Next;
      End;
      if Assigned(cxProgresso) then
      begin
        cxProgresso.Position := cxProgresso.Position + 1;
        Application.ProcessMessages;
      end;
      cdsTotCta.Next;

    End;

  Finally
    cdsMovEve.EnableControls;
    cdsMovEve.IndexFieldNames := 'CODEVE';
  End;

  if Not blnAbrirFrmDesmembramento then
    exit;


  Try
    Try

      pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
      frmDesmembrValores.DatasetCtpDet       := Self.cdsCtpDet;
      frmDesmembrValores.strNumDup       := '';
      frmDesmembrValores.strParcel       := '0';
      frmDesmembrValores.strSerie        := '';
      frmDesmembrValores.strCodEmp       := VS_strCodEmp;
      frmDesmembrValores.strCodFor       := recDadFor.strCodFor;
      frmDesmembrValores.blnBaixada := False;
      frmDesmembrValores.blnEntMerAut := True;
      frmDesmembrValores.fltValTot := RoundTo(cdsItens.fRetSomaCampo('ENT_VLRCON'),-2);
      frmDesmembrValores.showModal;
      Self.blnValoresDesmembradosRotina := Not cdsCtpDet.isEmpty;
    Except
      On E: Exception do
      begin
        pMensagensErro(E.Message, '[TEntradaAutomatizada.pDesmembrarValoresCadPag]');
      end;
    end;
  Finally
    pFreeAndNil(frmDesmembrValores);
  end;
end;

Procedure TEntradaAutomatizada.pDesmenbraValoresCadPag(cxProgresso: TcxProgressBar);
Begin
  frmGravando.lblGravando.Caption := 'Desmembrando plano de contas, aguarde...';
  cxProgresso.Position := 0;
  cxProgresso.Properties.Max := cdsItens.RecordCount +  cdsTotCta.RecordCount;
  Application.ProcessMessages;

  pDesmembrarValoresCadPag(cxProgresso, False);

  cxProgresso.Position := 0;
  Application.ProcessMessages;
End;

Class Function TEntradaAutomatizada.fVerificaDocumentoExiste(blnDevolu,
                                                       blnRecCliGarantia,
                                                       blnConEqu: Boolean;
                                                       strNumDoc,
                                                       strEspDoc,
                                                       strSerie,
                                                       strCodFor: String;
                                                       intTamCam: Integer;
                                                       Var blnNotaImp: Boolean): Boolean;
  Var
    strSQL   : String;
    qryGenGer: TUniQuery;
begin
  Try

    Result := False;

    qryGenGer := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  GER_NUMDOC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';

    If (blnDevolu) Or (blnRecCliGarantia) Or (blnConEqu) Then
      strSQL := strSQL + '  GER_CODCLI = :CODFOR '
    Else
      strSQL := strSQL + '  GER_CODFOR = :CODFOR ';

    With qryGenGer Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;
      Open;

      If Not IsEmpty Then
        Result := True;

      Close;

      If (not Result) and (not blnDevolu) And (Not blnConEqu) Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'SELECT ';
        strSQL := strSQL + '  GER_CLAFIS ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  NOTGER ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '  GER_CODFOR = :CODFOR ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := RightStr(strNumDoc, intTamCam);
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('SERIE_').AsString := strSerie;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODFOR').AsString := strCodFor;
        Open;

        If IsEmpty Then
        Begin
          Close;
          ParamByName('SERIE_').AsString := RightStr('000' + strSerie, 3);
          Open;
        End;

        blnNotaImp := Not IsEmpty and (LeftStr(FieldByName('GER_CLAFIS').AsString, 1) = '3');

      End;


    End;

  Finally
    FreeAndNil(qryGenGer);
  End;
end;

Class Function TEntradaAutomatizada.fVerificaDocumentoExisteCtp(strNumDoc, strSerie, strCodFor: String; intTamCam: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenPag: TUniQuery;
begin
  Try
    qryGenPag := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';

    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := fStrZero(strNumDoc, intTamCam);
      ParamByName('CODFOR').AsString := strCodFor;
      If (Not fEmptyStr(strSerie)) Then
      Begin
        ParamByName('SERIE').AsString := strSerie;
      End;
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;
end;

Function TEntradaAutomatizada.fTemAntecipadoValorMenor: Boolean;
Begin
  Result := (RoundTo(objPgoAnt.fltTotSel, -2) < RoundTo(cdsItens.fRetSomaCampo('ENT_VLRCON'), -2)) And blnPgoAnt;
End;


function TEntradaAutomatizada.fTemItemSemPlanoConta: Boolean;
  Var
    Reg: TBookmark;
    intContador: Integer;
begin
  Result := False;
  intContador := 0;

  if cdsItens.IsEmpty then
    Exit;

  Reg := Nil;
  Try
    Reg := cdsItens.GetBookmark;
    cdsItens.DisableControls;
    cdsItens.First;
    While Not cdsItens.Eof do
    begin
      if fEmptyStr(fTiraCaracEspeciaisPonto(cdsItens.FieldByName('ENT_CODCTU').AsString)) then
      begin
        inc(intContador);
        Break;
      end;
      cdsItens.Next;
    end;
  Finally
    Result := intContador > 0;
    if Assigned(Reg) then
    begin
      if cdsItens.BookmarkValid(Reg) then
        cdsItens.GotoBookmark(Reg);
      cdsItens.FreeBookmark(Reg);
    end;
    cdsItens.EnableControls;
  End;
end;

Function TEntradaAutomatizada.fPedeDuplicatas(blnManterValorOriginal: Boolean = True): Boolean;
  Var
    arrDuplicataSav: TarrDuplicata;
    intContador: Integer;
    fltValorRestante: Double;
    curTotDup: Currency;
Begin
  Result := False;
  With recDadNot, recNotEle, recDadFor Do
  Begin
    For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
      arrDuplicataSav[intContador] := arrDuplicata[intContador];

    pCalculaValorDocumento;


    fltValorRestante  := fltValorDocumento;
    curTotDup := fTotalDuplicatas;
    if curTotDup > 0 Then
      fltValorRestante := curTotDup;

    If fTemAntecipadoValorMenor Then
      fltValorRestante := fFormataFloat(fltValorRestante - objPgoAnt.fltTotSel, 2);

    If fltValorRestante < 0 Then
    Begin
      pMensagemOk('O (Total da Nota) - (Pagamento Antecipado) - (Total da Bonificação) está resultando em um valor menor que zero!');
      Result := False;
    End;

    If fltValorRestante > 0 Then
    Begin
      Result := fDigDuplic(arrDuplicata,
                    strCndPag,
                    0,
                    fltValorRestante,
                    True,
                    True,
                    False,
                    dtaDtaDoc,
                    False,
                    cdsItens.fRetSomaCampo('ENT_VLRCON') - cdsItens.fRetSomaCampo('ENT_TOTITE'),
                    'S',
                    fRetArred2ParcFornec(strCodFor),
                    False,
                    0,
                    True,
                    Nil,
                    '',
                    True,
                    True,
                    Nil,    // pMostraContaCorrente
                    '',     // strCodCli
                    True,   // blnPerRep
                    False,  // blnValoresPadrao
                    '',     // strCodCnd
                    '',     // strCodVen
                    Nil,    //  fSenVar: TGenericFunctionWithArrayParam = Nil;
                    False,  //  blnFatPed: Boolean = False;
                    blnManterValorOriginal);  // blnManterValoesOriginais:

       If blnPgoAnt Then
          Result := Result And objPgoAnt.fRecalculaPagamentosAntecipados(strNumDoc, strSerDoc, fltValorDocumento, ParcelasArray, arrDuplicata);

       If Result Then
       Begin

         pMontaCdsDuplic;
         strCndPag := fRefazCondPagamento(arrDuplicata, dtaDtaDoc);
       End Else
       Begin

         For intContador := Low(arrDuplicata) To High(arrDuplicata) Do
           arrDuplicata[intContador] := arrDuplicataSav[intContador];

       End;

    End;
  End;

End;


function  TEntradaAutomatizada.fRelacionaCodBar_LinhaDigitavel: Boolean;
begin
  Result := True;
  If (fCfgSis('CTPBOL', varBoolean)) And (blnVeioBoleto) And (recDadNot.strCndPag <> '01000') And
     Not fEmptyStr(recDadNot.strCndPag) And (ArrDuplicata[0].strSequen <> '') Then
  Begin
    pCriarFormularios(TfrmDigCodBarBoleto, frmDigCodBarBoleto);
    frmDigCodBarBoleto.arrLinDigCodbar := arrLinDigCodbar;
    frmDigCodBarBoleto.arrDuplicata := @arrDuplicata;
    Try
      Try
        frmDigCodBarBoleto.ShowModal;
        Result :=   frmDigCodBarBoleto.blnConfirma;
      Except
      On E: Exception Do
         Result := False;
      End;
      Finally
      Begin
        If Result Then
        begin
          arrLinDigCodbar      := frmDigCodBarBoleto.arrLinDigCodbar;
          intQtdPar            := frmDigCodBarBoleto.intQtdPar;
        End;
        FreeAndNil(frmDigCodBarBoleto);
      End;
    End;
  End;
end;


Procedure TEntradaAutomatizada.pCalculaValorDocumento;
Begin
//  fltBonificacao    := fRetTotalBonificacaoEntMer;
  fltValorDocumento := fFormataFloat(cdsItens.fRetSomaCampo('ENT_VLRCON') , 2);
End;


procedure TEntradaAutomatizada.pDefineSeGravaCTP(strClaFis: String; frmEntMercadoriasAutomatizada: TForm);
Begin
  With recDadNot, recNotEle, recDadFor Do
  Begin
    blnGravaCtaPag := fGravaContasPagar(strClaFis, strCodFor);

    If blnGravaCtaPag Then
    Begin
      strCndPag := fMontaDuplicatasDupEle(arrDuplicata, strAutInc, dtaDtaDoc);
    End Else
    Begin
      pZeraDigDuplic(arrDuplicata);
      strCndPag := '01000';
    End;

    pMontaCdsDuplic;
    TfrmEntMercadoriasAutomatizada(frmEntMercadoriasAutomatizada).tbsCtaPag.TabVisible := recDadNot.blnGravaCtaPag;
  End;
End;

function TEntradaAutomatizada.fCFOPPodeSerUtilizada(strClaFis: String): Boolean;
Begin
  Result := (Pos(strClaFis, strCFOPermitido)  > 0);
End;
{ TUniClientDataSetHelper }

function TUniClientDataSetHelper.fRetSomaCampo(strNomCam: String): Double;

begin
  Result := 0;
  if Self.IsEmpty then
    Exit;

  if Not (Self.FieldByName(strNomCam).DataType in [ftInteger,ftFloat]) then
    Exit;

  Self.first;
  While Not Self.Eof do
  begin
    if self.FieldByName(strNomCam).Value = Null then
      Result := Result + 0
    else
      Result := Result + self.FieldByName(strNomCam).Value;
    self.Next;
  end;

end;

function TEntradaAutomatizada.fTotalDuplicatas: Currency;
Var
   qryDupEle: TUniQuery;
Begin
  qryDupEle := fCriarQuery('SELECT SUM(DUP_VALDUP) AS VALDUP FROM DUPELE WHERE DUP_SEQELE = ' +
    qryGerEle.FieldByName('AUTOINCREM').AsString.QuotedString + ' ORDER BY AUTOINCREM', Nil);
  Try
    qryDupEle.Open;
    Result := qryDupEle.FieldByName('VALDUP').AsCurrency;
  Finally
    FreeAndNil(qryDupEle);
  End;
End;


{ TRecDadosFornecedor }

function TRecDadosFornecedor.fFornecedorMaterialConsumo: Boolean;
begin
 Result := Self.strTipFor = 'M';
end;

end.

