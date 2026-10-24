unit untFuncoesDllPedido;

interface

uses SysUtils, Forms, Dialogs, Windows, UniClientDataSet,
     Variants, untFuncoesRel, dxCore, Uni, DB,
     Vcl.Themes,
     Vcl.Styles,
     Vcl.SysStyles, // to gain access to TSysPopupStyleHook
     untFuncoesPedidoSimples, untSalvaDadosGiro, untIFuncIns,
     untILiberacao, untFuncoesPedido, untManutencaoEmpresasDestinoMultiLojas,
     untIFatGor, untFatGorFactory, untTypesSistema;

Var
  fGravaFatGor: TfGravaFatGor;
  fGravaFatDor: TfGravaFatDor;
  prcAbreTelaPrecos: TProcedureAbreTelaPrecos;

//procedure dxInitializePedCom; StdCall;
//procedure dxFinalizePedCom; StdCall;

Procedure pGeraSpool; stdcall;

Procedure pSetLiberacaoPedidoCompra(objLibera : ILiberacao); stdcall;

procedure pInicializaDllPedidoCompra(frmModuloPar: TUniConnection;
                                     Handle: HWND; intDebugH: Byte;
                                     funcGravaFatGor: TfGravaFatGor;
                                     funcGravaFatDor: TfGravaFatDor;
                                     procExecutaRelatorio: TExecutaRelatorio;
                                     funcExecutaRelatorioCodigo: TfExecutaRelatorioCodigo;
                                     objIFuncIns : IFuncIns;
                                     procImprimeDocumento: TImprimeDocumento;
                                     procCadProdutos: TAbreCadastroProcedure;
                                     procAbreTelaPrecos: TProcedureAbreTelaPrecos;
                                     objFatGor: IFatGor;
                                     procExibeRequisicaoCompra: TExibeRequisicaoCompra;
                                     funcGerarEmail: TGerarEmail;
                                     procChamaAtualizaProdReqOS: TProcChamaAtualizaProdReqOrdemServico;
                                     fncDisparaSMSWhatsappPedidoCompra: TfunDisparaSMSWhatsappPedidoCompra); stdcall;

procedure pSetObjTraceViewerLibPedidoDeCompra(AViewer: ITraceViewer; ASQLTrace: ISQLTrace); stdcall;

procedure pCarregaDLL(frmModuloPar: TUniConnection; Handle: HWND; intDebugH: Byte); stdCall;

procedure pAtualizaVarGlobalPedidoCompra(strCodEmp, strUsuLogado, strEmpAceUsuLogado,
  strEmpEstUsuarioLogadoP, strEmpConsVendFaturP: String; blnHabilitarCRM: Boolean;
  blnUtilizaModoClassico: Boolean; AVS_PermitidoEnviarEmail: Boolean); stdcall;

Procedure pLiberaInterfacePedidoCompra; stdcall;

procedure pPedidoDeCompra(CallPedidoCompraAlt: TCallPedidoCompraAlt); stdcall;
procedure pManutencaoEmpresasDestinoMultiLojas; stdCall;

procedure pPastaCompra; stdcall;

function fRetVersionSVNPedidoCompra: String; stdcall;

function fRetornaProdutosGiroCotacao(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;stdcall;
function fCarregaCotacaoMultiLojas(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;stdcall;
Function fSalvaInterfaceCotacao(strSeqGer, strNomFrm, strCodEmp: String): Boolean; stdcall;

function fRetornaProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;

function funcProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
  blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant;

function fProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
  blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant; stdcall;

(*
function fCalcularSubstituicaoProduto(strCodFor, strCodAbf: String; fltTotIte, fltValIpi: Double;
                                      strFrmPcm: String;
                                      blnZonaFranca: Boolean;
                                      Var fltBasIcm, fltAlqIcm, fltValIcm, fltBaseST: Double;
                                      Var strCodSit: String;
                                      var fltAliquotaSub: Double;
                                      strTipAbfFor: String = '';
                                      strRedPis: String = '';
                                      qryDadosAbf: TUniQuery = Nil): Double; stdcall; *)


implementation

uses untmodulo, untMenuPedCom, untFuncoesSimples,
     untModuloSPR, untGeraSpoolTransferencia, untLiberacaoFactory,
     untRecalculaSados, untModuloReplicacao, untFuncInsFactory,
     untPastaCompraConsulta, untConstantes, untGravando;

procedure pAtualizaVarGlobalPedidoCompra(strCodEmp, strUsuLogado, strEmpAceUsuLogado,
  strEmpEstUsuarioLogadoP, strEmpConsVendFaturP: String; blnHabilitarCRM: Boolean;
  blnUtilizaModoClassico: Boolean; AVS_PermitidoEnviarEmail: Boolean); stdcall;
begin
  pSetaEmpresaLogada(strCodEmp);
  strLoginUsuarioLogado := strUsuLogado;
  strEmpAcessoUsuarioLogado := strEmpAceUsuLogado;
  strEmpEstUsuarioLogado := strEmpEstUsuarioLogadoP;
  strEmpConsVendFatur := strEmpConsVendFaturP;
  VS_PermitidoEnviarEmail := AVS_PermitidoEnviarEmail;
  VS_strHabilitarCRM  := blnHabilitarCRM;
  blnUsuarioLogadoUtilizaModoClassico := blnUtilizaModoClassico;
end;

procedure pInicializaDllPedidoCompra(frmModuloPar: TUniConnection; Handle: HWND; intDebugH: Byte;
                         funcGravaFatGor: TfGravaFatGor;
                         funcGravaFatDor: TfGravaFatDor;
                         procExecutaRelatorio: TExecutaRelatorio;
                         funcExecutaRelatorioCodigo: TfExecutaRelatorioCodigo;
                         objIFuncIns : IFuncIns;
                         procImprimeDocumento: TImprimeDocumento;
                         procCadProdutos: TAbreCadastroProcedure;
                         procAbreTelaPrecos: TProcedureAbreTelaPrecos;
                         objFatGor : IFatGor;
                         procExibeRequisicaoCompra: TExibeRequisicaoCompra;
                         funcGerarEmail: TGerarEmail;
                         procChamaAtualizaProdReqOS: TProcChamaAtualizaProdReqOrdemServico;
                         fncDisparaSMSWhatsappPedidoCompra: TfunDisparaSMSWhatsappPedidoCompra);
begin
  pIniciaLogLeak(intDebugH, 'libPedidoDeCompra');
  VS_APPLICATION_HANDLE := Handle;
  untFuncInsFactory.objIFuncIns := objIFuncIns;
  If not Assigned(frmModulo) Then
  Begin
    frmModulo := TfrmModulo.CreateInstance(Nil, False);
    frmModulo.Database.AssignConnect(frmModuloPar);
  End;

  If not Assigned(frmModuloSPR) Then
  Begin
    frmModuloSPR        := TfrmModuloSPR.Create(Nil);
    frmModuloSPR.qryRelatorio.Connection := frmModulo.GetCurrentConnection;
  end;

  If not Assigned(frmModuloReplicacao) Then
    frmModuloReplicacao := TfrmModuloReplicacao.Create(Nil);

  fAjustaDataSistema;
  pCarregaVsTemFil;
  pAtuVarGlobaisSimples;

  funDisparaSMSWhatsappPedidoCompra := fncDisparaSMSWhatsappPedidoCompra;
  fGravaFatGor := funcGravaFatGor;
  fGravaFatDor := funcGravaFatDor;

  prcAbreTelaPrecos := procAbreTelaPrecos;

  TFatGorFactory.pSetFatGor(objFatGor);

  prcExecutaRelatorio := procExecutaRelatorio;
  fncExecutaRelatorioCodigo := funcExecutaRelatorioCodigo;

  prcImprimeDocumento := procImprimeDocumento;
  prcCadProdutos      := procCadProdutos;
  prcExibeRequisicaoCompra := procExibeRequisicaoCompra;
  funGerarEmail := funcGerarEmail;
  procChamaAtualizaProdReqOrdemServico := procChamaAtualizaProdReqOS;
  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);
      TfrmGravando.CorPadraoTema := AUTCOM_COR_TELA_AGUARDE_TEMA;

      TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('#32770', TSysDialogStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ScrollBar', TSysScrollBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Button', TSysButtonStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Edit', TSysEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboBox', TSysComboBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ListBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('ComboLBox', TSysListBoxStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('Static', TSysStaticStyleHook);

      TCustomStyleEngine.UnRegisterSysStyleHook('ToolbarWindow32', TSysToolbarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysListView32', TSysListViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTabControl32', TSysTabControlStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('SysTreeView32', TSysTreeViewStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_progress32', TSysProgressBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit20W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit30W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit41W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50A', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RichEdit50W', TSysRichEditStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('RebarWindow32', TSysReBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_statusbar32', TSysStatusBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_trackbar32', TSysTrackBarStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('msctls_updown32', TSysUpDownStyleHook);
      TCustomStyleEngine.UnRegisterSysStyleHook('tooltips_class32', TSysTooltipsStyleHook);
    Except
      blnUsuarioLogadoUtilizaModoClassico := True;
    End;
  End;

  pIniciaDllFuncoes(frmModulo.GetCurrentConnection,
                    untFuncoesSimples.strLoginUsuarioLogado,
                    untFuncoesSimples.VS_strCodEmp,
                    DebugHook,
                    TCfgSis.Create(),
                    untFuncoesSimples.VS_objTraceViewer,
                    untFuncoesSimples.VS_Date,
                    untFuncoesSimples.VS_ComputerNetName,
                    untFuncoesSimples.VS_UserFromWindows,
                    untFuncoesSimples.VS_IPAddressAsString,
                    untFuncoesSimples.VS_MacAddress);
end;

procedure pCarregaDLL(frmModuloPar: TUniConnection; Handle: HWND; intDebugH: Byte);
begin
  pIniciaLogLeak(intDebugH, 'libPedidoDeCompra');
  VS_APPLICATION_HANDLE := Handle;

  frmModulo := TfrmModulo.CreateInstance(Nil, False);
  frmModulo.Database.AssignConnect(frmModuloPar);

  frmModuloSPR        := TfrmModuloSPR.Create(Nil);
  frmModuloReplicacao := TfrmModuloReplicacao.Create(Nil);

  frmModuloSPR.qryRelatorio.Connection := frmModulo.GetCurrentConnection;

  //Apenas para dar o load da dll;
  {}
end;

procedure pSetObjTraceViewerLibPedidoDeCompra(AViewer: ITraceViewer; ASQLTrace: ISQLTrace); stdcall;
begin
  untFuncoesSimples.VS_objTraceViewer := AViewer;
  untFuncoesSimples.VS_Trace := ASQLTrace;
end;

procedure pPedidoDeCompra(CallPedidoCompraAlt: TCallPedidoCompraAlt);
begin
  Try
    If Not Assigned(funProdutosGiro) Then
      funProdutosGiro := funcProdutosGiro;
    pVerificaProCod;
    pCriarFormularios(TfrmMenuPedCom, frmMenuPedCom, CallPedidoCompraAlt.appHandle);
    frmMenuPedCom.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pPedidoDeCompra]');
    End;
  End;
  pFreeAndNil(frmMenuPedCom);
end;

procedure pPastaCompra;
Begin
  Try
    pVerificaProCod;
    pCriarFormularios(TfrmPastaCompraConsulta, frmPastaCompraConsulta);
    frmPastaCompraConsulta.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pPastaCompra]');
    End;
  End;
  pFreeAndNil(frmPastaCompraConsulta);
End;

function fRetVersionSVNPedidoCompra: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

function fRetornaProdutosGiroCotacao(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;stdcall;
Begin
  recOpcoesGiro.blnCotacao := True;

  Result := fRetornaProdutosGiro(recOpcoesGiro, oleItensMultiLojas);
End;

function fRetornaProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant): OleVariant;
  var
    strEmpUsadaGiro   : String;
    cdsItensGiro      : TUniClientDataSet;
    cdsItensPedido    : TUniClientDataSet;
    cdsItensMultiLojas: TUniClientDataSet;
    objSalRes         : TRecSadoReservado;
    blnProssegueProcesso: Boolean;
begin

  Try
    Result := Null;
    oleItensMultiLojas := Null;

    recOpcoesGiro.cdsEmpSel          := Null;
    recOpcoesGiro.blnCarregItensGrid := True;

    If recOpcoesGiro.blnAlterandoCotacaoComGiroNaoMultiloja Then
      blnProssegueProcesso := fChamaCalculoGiro(recOpcoesGiro, False, False)
    Else
      blnProssegueProcesso := fChamaCalculoGiro(recOpcoesGiro, False);


    If blnProssegueProcesso Then
    Begin
      cdsItensGiro       := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
      cdsItensPedido     := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
      cdsItensMultiLojas := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);

      {*****************************************}
      {* CALCULA O GIRO DE ESTOQUE             *}
      {**************************************MV*}
      With recOpcoesGiro Do
        fCalculaGiroEstoque(recOpcoesGiro, opcChamada, dtaDataBaseGir, cdsItensGiro, cdsItensMultiLojas, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade,
          strCodDep, intDiaVen, strAcoObj, strRefere, strDesIte, strLocIni, strLocFin,
          intOpcGir, strFilGir, intMesGir, intMesMos, blnAnalisaITEFOR,
          blnMedAju, blnAllIte, blnArredSug, blnConsMCom, blnEmbala, blnConsTLoj, blnConsEMin, blnConsEMax, blnConsRequisicao,
          blnConsPedPen, blnConsPedPenTransferencia, blnDesconsPedGar, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot,
          blnVenPer, blnVenPerMed, blnConsEndere, blnPonPed, blnAteMax, blnAgrSim,
          blnEntFutPrevisao,
          blnEntFutFalta,
          blnEntFutAguarda,
          intDiaPedVen, intOrdem, strPedMlj, '', '', '', VS_strCodEmp, strEmpUsadaGiro,  strEmpSubtraiPedTransf,
          arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep, strEmpAgr, blnSugInd, cdsEmpSel, recNivEst,
          slfLocFis, strCodTab, slsSaldos, slsSaldosDestino, strCodCmp, '', strMeses, '' {strSeqCot},  '' {strNumPedUmaLj},
          '' {strCodEmpUmaLj}, Nil, SameText(strNomFrm, 'frmGerarOrcamentoCompraAuto'));

      pCopiaClientDataSet(cdsItensGiro, cdsItensPedido);

      objSalRes := TRecSadoReservado.Create;
      objSalRes.cdsItens := cdsItensPedido;
      objSalRes.pAtualizaReservados(recOpcoesGiro.blnEmbala);
      FreeAndNil(objSalRes);

      oleItensMultiLojas := cdsItensMultiLojas.Data;

      Result := cdsItensPedido.Data;

      FreeAndNil(cdsItensGiro);
      FreeAndNil(cdsItensPedido);
      FreeAndNil(cdsItensMultiLojas);

      SetLength(arrCampos, 0);
      SetLength(arrCamposAgg, 0);
    End;


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fRetornaProdutosGiro');
    End;
  End;

end;

function fCarregaCotacaoMultiLojas(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensGiro: OleVariant): OleVariant;stdcall;
  Var
    strEmpUsadaGiro: String;
    cdsItensGiro,
    cdsItensPed,
    cdsItensMultLojas,
    cdsEmpMlj: TUniClientDataSet;
Begin
  Try
    oleItensGiro := Null;
    Result := Null;

    cdsEmpMlj := TUniClientDataSet.Create(Nil);

    With cdsEmpMlj.FieldDefs.AddFieldDef Do
    Begin
      Name        := 'CODEMP';
      DataType    := ftString;
      Size        := 3;
    End;

    With cdsEmpMlj.FieldDefs.AddFieldDef Do
    Begin
      Name        := 'DESCRI';
      DataType    := ftString;
      Size        := 70;
    End;

    With cdsEmpMlj.FieldDefs.AddFieldDef Do
    Begin
      Name        := 'MARDES';
      DataType    := ftString;
      Size        := 1;
    End;

    With cdsEmpMlj.FieldDefs.AddFieldDef Do
    Begin
      Name        := 'EMPVIS';
      DataType    := ftString;
      Size        := 1;
    End;

    pCarregaEmpresasMlj(cdsEmpMlj);

    recOpcoesGiro.cdsEmpSel := Null;
    recOpcoesGiro.blnCarregItensGrid := True;

    fChamaCalculoGiro(recOpcoesGiro, True, False);

    If Assigned(recOpcoesGiro.objSalInt) And (Not recOpcoesGiro.objSalInt.blnEncontrouGiro) Then
    Begin
      recOpcoesGiro.blnDescSalExt := True;
      recOpcoesGiro.blnConsPedVen := True;
      recOpcoesGiro.blnConsGarPen := True;
      recOpcoesGiro.blnConsOrdPro := True;
    End;

    recOpcoesGiro.blnUsaGiro := False;

    cdsItensGiro      := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
    cdsItensPed       := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
    cdsItensMultLojas := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);

    With recOpcoesGiro Do
    Begin
      If cdsItensMultLojas.Active Then
        cdsItensMultLojas.EmptyDataSet;

      If cdsItensPed.Active Then
        cdsItensPed.EmptyDataSet;

      If fCarregaPedidoDeCompraMultiLojas(recOpcoesGiro,
                                          cdsItensPed,
                                          cdsItensMultLojas,
                                          '',
                                          '',
                                          '',
                                          strEmpUsadaGiro,
                                          recOpcoesGiro.cdsEmpSel,
                                          strSeqCot) Then
        Result := cdsItensMultLojas.Data
      Else
        Result := Null;

      FreeAndNil(cdsItensGiro);
      FreeAndNil(cdsItensMultLojas);
      FreeAndNil(cdsItensPed);
    End;

    FreeAndNil(cdsEmpMlj);

    SetLength(arrCampos, 0);
    SetLength(arrCamposAgg, 0);

  Except
    On E: Exception Do
    Begin
      Result := Null;
      pMensagensErro(E.Message, 'fCarregaCotacaoMultiLojas');
    End;
  End;
End;

Function fSalvaInterfaceCotacao(strSeqGer, strNomFrm, strCodEmp: String): Boolean; stdcall;
Begin
  If Assigned(objSalvaInterface) Then
  Begin

    If fEmptyStr(strCodEmp) Then
      Result := objSalvaInterface.fSalvaDados(strSeqGer, strNomFrm)
    Else
      Result := objSalvaInterface.fSalvaDadosDesmembrado(strSeqGer, strNomFrm, strCodEmp);

  End Else
    Result := True;
End;



Procedure pLiberaInterfacePedidoCompra; stdcall;
Begin
  If Assigned(objSalvaInterface) Then
  Begin
    FreeAndNil(objSalvaInterface);
    objSalvaInterface := Nil;
  End;
End;

(*
procedure dxInitializePedCom;
Begin
  dxInitialize;
End;

procedure dxFinalizePedCom;
Begin
  dxFinalize;
End;
*)

Procedure pSetLiberacaoPedidoCompra(objLibera : ILiberacao);
Begin
  pSetLiberacao(objLibera);
End;

Procedure pGeraSpool; stdcall;
Begin
  TGeraSpoolTransferencia.pGeraSpool;
End;

procedure pManutencaoEmpresasDestinoMultiLojas;
begin
  Try
    pVerificaProCod;
    pCriarFormularios(TfrmManutencaoEmpresasDestinoMultiLojas, frmManutencaoEmpresasDestinoMultiLojas);
    frmManutencaoEmpresasDestinoMultiLojas.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmManutencaoEmpresasDestinoMultiLojas]');
    End;
  End;
  pFreeAndNil(frmManutencaoEmpresasDestinoMultiLojas);
end;

function funcProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
  blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant;
Begin
  Result := fProdutosGiro(recOpcoesGiro,oleItensMultiLojas, blnCarregandoPedido, blnShow , blnConsulta);
End;


function fProdutosGiro(Var recOpcoesGiro: TRecOpcoesGiro; Var oleItensMultiLojas: OleVariant;
  blnCarregandoPedido: Boolean; blnShow: Boolean = True; blnConsulta: Boolean = False): OleVariant; stdcall;
  var
    strEmpUsadaGiro   : String;
    cdsItensPedido    : TUniClientDataSet;
    cdsItensGiro      : TUniClientDataSet;
    cdsItensMultiLojas: TUniClientDataSet;
    objSalRes         : TRecSadoReservado;
begin

  Try
    Result := Null;
    oleItensMultiLojas := Null;



    If fChamaCalculoGiro(recOpcoesGiro, blnCarregandoPedido, blnShow, blnConsulta) Then
    Begin
      cdsItensGiro       := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
      cdsItensPedido     := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);
      cdsItensMultiLojas := fCriaDatasetPedido(recOpcoesGiro.intMesMos, arrCampos, arrCamposAgg);

      {*****************************************}
      {* CALCULA O GIRO DE ESTOQUE             *}
      {**************************************MV*}
      With recOpcoesGiro Do
        fCalculaGiroEstoque(recOpcoesGiro, opcChamada, dtaDataBaseGir, cdsItensGiro, cdsItensMultiLojas, strCodGru, strCodFor, strCodMar, strPrdGru, strGruCmp, strSitPro, strUnidade,
          strCodDep, intDiaVen, strAcoObj, strRefere, strDesIte, strLocIni, strLocFin,
          intOpcGir, strFilGir, intMesGir, intMesMos, blnAnalisaITEFOR,
          blnMedAju, blnAllIte, blnArredSug, blnConsMCom, blnEmbala, blnConsTLoj, blnConsEMin, blnConsEMax, blnConsRequisicao,
          blnConsPedPen, blnConsPedPenTransferencia, blnDesconsPedGar, blnConsPedVen, blnDescSalExt, blnConsMesAtu, blnConsOrdPro, blnConsGarPen, blnConsTransf, blnConsCot,
          blnVenPer, blnVenPerMed,blnConsEndere, blnPonPed, blnAteMax, blnAgrSim,
          blnEntFutPrevisao,
          blnEntFutFalta,
          blnEntFutAguarda,
          intDiaPedVen, intOrdem, strPedMlj, '', '', '', VS_strCodEmp, strEmpUsadaGiro,  strEmpSubtraiPedTransf,
          arrCodFor, arrLinhaGrupo, arrMarca, arrPrdGru, arrGruCmp, arrSitPro, arrUnidade, arrCodDep, strEmpAgr, blnSugInd, cdsEmpSel, recNivEst,
          slfLocFis, strCodTab, slsSaldos, slsSaldosDestino, strCodCmp, '', strMeses, '' {strSeqCot},  '' {strNumPedUmaLj},
          '' {strCodEmpUmaLj}, Nil {objRecupera});

      pCopiaClientDataSet(cdsItensGiro, cdsItensPedido);

      objSalRes := TRecSadoReservado.Create;
      objSalRes.cdsItens := cdsItensPedido;
      objSalRes.pAtualizaReservados(recOpcoesGiro.blnEmbala);
      FreeAndNil(objSalRes);

      oleItensMultiLojas := cdsItensMultiLojas.Data;

      Result := cdsItensPedido.Data;

      FreeAndNil(cdsItensGiro);
      FreeAndNil(cdsItensPedido);
      FreeAndNil(cdsItensMultiLojas);

      SetLength(arrCampos, 0);
      SetLength(arrCamposAgg, 0);
    End;


  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fRetornaProdutosGiro');
    End;
  End;

end;



end.
