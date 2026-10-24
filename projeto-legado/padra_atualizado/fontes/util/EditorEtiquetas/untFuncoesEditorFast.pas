unit untFuncoesEditorFast;

interface

Uses Math, SysUtils, UniClientDataSet, Graphics, frxClass, untFuncoesSimples,
  Uni, untTypesSistema, TypesRel, untConstantes, untFuncoesRel, untModulo,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles, // to gain access to TSysPopupStyleHook
  System.Classes, Data.DB, untZClient, frxDBSet, untLogForm;

Type
  TRegClient = Record
    cdsDados: TZClient;
    frxDados: TfrxDBDataset;
  End;

  TArrClients = Array Of TRegClient;

  procedure pInicializaFonteMatrcial(Var recCfgFon: TRecFonteMatricial);

  Procedure pCriaModulosFast(varRecVariaveis: TRecVariaveis);
  Procedure pLiberaModulos;
  Procedure pSetaModulos(recModModulos: TRecModulos);

  function fCmColunaToPixel(fltValCm: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;
  function fPixelToCmColuna(fltValPix: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;

  Function fCmToPixelFloor(fltValCm: Double): Integer;

  function fLarguraColuna(colFonPag, colFonMat: TcolMatricial; strTipImp: String): Double;

  function fMargemFastToColunasMatricial(fltValCm: Double; blnAltura: Boolean): Double;
  function fMargemmFastMatricialToPixels(fltValCm: Double; blnAltura: Boolean): Double;

  function fTemParametro(frxReport: TfrxReport; strNomPar: WideString): Boolean;

  function fEspecieToTipoDocumeto(strNumDoc,
                                  strEspDoc,
                                  strCodEmp,
                                  strTip_FC: String;
                                  blnDocSep,
                                  blnRequisicao,
                                  blnImpSepRomaneio,
                                  blnVidro: Boolean;
                                  tpeTipEtq: TTipoEtiqueta = tpeNenhum): TTipoDocumento;

  function fEspecieEtqToTipoDocumentos(strNumDoc,
                                       strEspDoc,
                                       strCodEmp,
                                       strTip_FC: String;
                                       blnDocSep,
                                       blnRequisicao,
                                       blnVidro: Boolean;
                                       blnImpSepRomaneio: Boolean;
                            Var tpeTipEtq: TTipoEtiqueta): Boolean;

  function fRetNomCampoLayout(strCodigo: String; intCodEti: Integer; intPosCam: Integer = -1): String;

  function fTextoToColMat(strTexto: String): TcolMatricial;
  function fColMatToTexto(colFonte: TcolMatricial): String;
  function fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String; blnDocSep, blnPDF: Boolean):Boolean;

  function fCodigoToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
  function fCodLayToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
  function fTipoEtiquetaToTipoLayout(tipoEtiq: TTipoEtiqueta): Integer;
  function fSQLFiltroCamposDocumento(intCodEti: Integer): String;

  function fInjetaReformaPedidoCompra(const AarrFr3: TBytes): TBytes;
  function fLayoutComReformaPedidoCompra(dtsLayout: TDataSet): Boolean;

implementation

Uses
  frxDMPClass, untCfgRel, untGravando;

Procedure pSetaVariaveisFast(varRecVariaveis: TRecVariaveis);
Begin
  pSetaEmpresaLogada(varRecVariaveis.VS_strCodEmp);
  VS_Date                   := varRecVariaveis.VS_Date;
  strLoginUsuarioLogado     := varRecVariaveis.strLoginUsuarioLogado;
  blnUsuarioLogadoUtilizaModoClassico := varRecVariaveis.blnUsuarioLogadoUtilizaModoClassico;
  strDescriUsuarioLogado    := varRecVariaveis.strDescriUsuarioLogado;
  strEmpAcessoUsuarioLogado := varRecVariaveis.strEmpAcessoUsuarioLogado;
  VS_strUsaTmq              := varRecVariaveis.VS_strUsaTmq;
  VS_strTitLot              := varRecVariaveis.VS_strTitLot;
  VS_strTitLts              := varRecVariaveis.VS_strTitLts;
  VS_objTraceViewer         := varRecVariaveis.objTraceViewer;
  strPortadoresOperador     := varRecVariaveis.strPortadoresOperador;
  arrProCod                 := varRecVariaveis.arrProCod;
End;

Procedure pCriaModulosFast(varRecVariaveis: TRecVariaveis);
Begin
  pSetaVariaveisFast(varRecVariaveis);

  VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);
  VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
  VS_strCla_UC := fCfgSis('CLA_UC');
  VS_strTabPrc := fCfgSis('TABPRC');
  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));
  VS_strCliFil := fRetClientesFilial;

  pAtuVarGlobaisSimples;

  TLogForm.strCodEmp := VS_strCodEmp;
  TLogForm.strCodOpe := strLoginUsuarioLogado;
  TLogForm.dtaDtaLog := VS_Date;
  TLogForm.fncCriaQuery := fCriaQuery;
  TLogForm.fncTime := fTime;
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

  {$WARNINGS OFF}
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, untFuncoesSimples.strLoginUsuarioLogado, untFuncoesSimples.VS_strCodEmp, DebugHook, TCfgSis.Create(),
                    untFuncoesSimples.VS_objTraceViewer,
                    untFuncoesSimples.VS_Date, untFuncoesSimples.VS_ComputerNetName, untFuncoesSimples.VS_UserFromWindows,
           					untFuncoesSimples.VS_IPAddressAsString, untFuncoesSimples.VS_MacAddress);
  {$WARNINGS ON}

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
End;

Procedure pSetaModulos(recModModulos: TRecModulos);
Begin
  With recModModulos Do
  Begin
    frmModulo := TfrmModulo.Create(Nil);
    frmModulo.Database.AssignConnect(Banco);
  End;
End;

Procedure pSetaConnection(Modulo: TDataModule);
  Var
    intIndex: Integer;
Begin
  With Modulo Do
  For intIndex := 0 To ComponentCount - 1 Do
    If Components[intIndex] Is TUniQuery Then
      (Components[intIndex] As TUniQuery).Connection := frmModulo.GetCurrentConnection;
End;

Procedure pLiberaModulos;
Begin
  pDestroiModulo(frmModulo);
End;

Function fLayoutAtivo(strNumDoc, strEspDoc, strCodEmp, strTip_FC: String; blnDocSep, blnPDF: Boolean):Boolean;
  Var
    tpeTipEtq: TTipoEtiqueta;
    intCodLay: Integer;
    qryLayEti: TUniQuery;
Begin
  Result := False;
  If fEspecieEtqToTipoDocumentos(strNumDoc, strEspDoc, strCodEmp, strTip_FC, blnDocSep, False, IIf(tpeTipEtq = tpeReqMaterialConsumoVidro, True, False), False, tpeTipEtq) Then
  Begin
    intCodLay := ARR_TIPO_LAYOUT[tpeTipEtq];

    qryLayEti := fCriaQuery(Nil);
    With qryLayEti, SQL Do
    Begin
      Add('SELECT LAY_PADRAO, LAY_GERPDF FROM LAYETI');
      Add('WHERE LAY_TIPLAY = :TIPLAY ');

      If blnPDF Then
        Add('AND LAY_GERPDF = "S" ')
      Else
        Add('AND LAY_PADRAO = "S" ');

     Add('AND LAY_CODEMP = :CODEMP ');

     ParamByName('TIPLAY').AsInteger := intCodLay;
     ParamByName('CODEMP').AsString  := VS_strCodEmp;

     Open;

     Result := Not IsEmpty;
    End;

    FreeAndNil(qryLayEti);
  End;
End;

Function fEspecieEtqToTipoDocumentos(strNumDoc,
                                     strEspDoc,
                                     strCodEmp,
                                     strTip_FC: String;
                                     blnDocSep,
                                     blnRequisicao,
                                     blnVidro,
                                     blnImpSepRomaneio: Boolean;
                                     Var tpeTipEtq: TTipoEtiqueta): Boolean;
Begin
  Result := True;

  Case fEspecieToTipoDocumeto(strNumDoc, strEspDoc, strCodEmp, strTip_FC, blnDocSep, blnRequisicao, blnImpSepRomaneio, blnVidro, tpeTipEtq) Of
    docNF         : tpeTipEtq := tpeNF;
    docNS         : tpeTipEtq := tpeNS;
    docSF         : tpeTipEtq := tpeSF;
    docSepSF      : tpeTipEtq := tpeSepSF;
    docMI         : tpeTipEtq := tpeMI;
    docFF         : tpeTipEtq := tpeFF;
    docIF         : tpeTipEtq := tpeIF;
    docTicketNF   : tpeTipEtq := tpeTicketNF;
    docTicketDV   : tpeTipEtq := tpeTicketDV;
    docD1         : tpeTipEtq := tpeD1;
    docPD         : tpeTipEtq := tpePD;
    docPA         : tpeTipEtq := tpePA;
    docROTin      : tpeTipEtq := tpeROTin;
    docOR         : tpeTipEtq := tpeOR;
    docPR         : tpeTipEtq := tpePR;
    docBR         : tpeTipEtq := tpeBR;
    docTR         : tpeTipEtq := tpeTR;
    docDV         : tpeTipEtq := tpeDV;
    docAJ         : tpeTipEtq := tpeAJ;
    docTA         : tpeTipEtq := tpeTA;
    docEP         : tpeTipEtq := tpeEP;
    docBE         : tpeTipEtq := tpeBE;
    docUS         : tpeTipEtq := tpeUS;
    docCS         : tpeTipEtq := tpeCS;
    docCR         : tpeTipEtq := tpeCR;
    docTE         : tpeTipEtq := tpeTE;
    docPI         : tpeTipEtq := tpePI;
    docSeparacaoGondola: tpeTipEtq := tpeSeparacaoGondola;
    docGA         : tpeTipEtq := tpeGA;
    docContGF     : tpeTipEtq := tpeContGF;
    docContGC     : tpeTipEtq := tpeContGC;

    docGF         : tpeTipEtq := tpeGF;
    docContGR     : tpeTipEtq := tpeContGR;
    docContGRBaixa: tpeTipEtq := tpeContGRBaixa;
    docSolicitacaoManutencaoEquipamentos : tpeTipEtq := tpeSolicitacaoManutencaoEquipamentos;
    docPedidoCompra: tpeTipEtq := tpePedidoCompra;

    docOrdPro     : tpeTipEtq := tpeOrdPro;

    docSepNota        : tpeTipEtq := tpeSepNota;
    docSepNotaObs  : tpeTipEtq := tpeSepNotaObs;

    docSepPedido  : tpeTipEtq := tpeSepPedido;

    docCupomServico  : tpeTipEtq := tpeCupomServico;


    docSepRomaneio: tpeTipEtq := tpeSepRomaneio;
    docSepItem    : tpeTipEtq := tpeSepItem;
    docRequisicao : tpeTipEtq := tpeRequisicao;
    docOrdemServico: tpeTipEtq := tpeOrdemServico;
    docOrdemServicoTermoResp: tpeTipEtq := tpeOrdemServicoTermoResp;
    docOrdemServicoTermoDev : tpeTipEtq := tpeOrdemServicoTermoDev;
    docOrdemServicoOrdExecucao: tpeTipEtq := tpeOrdemServicoOrdExecucao;
    docOrdemServicoImagem: tpeTipEtq := tpeOrdemServicoImagem;
    docReqMaterialConsumo : tpeTipEtq := tpeReqMaterialConsumo;
    docReqMaterialConsumoVidro : tpeTipEtq := tpeReqMaterialConsumoVidro;
    docCarnePagamento: tpeTipEtq := tpeCarnePagamento;
    docDuplicata: tpeTipEtq := tpeDuplicata;

    docComprovanteGeracaoCredito: tpeTipEtq := tpeComprovanteGeracaoCredito;

    docProcessoDeExtrusao: tpeTipEtq := tpeProcessoDeExtrusao;

    docInspecaoEnt:  tpeTipEtq := tpeInspecaoEnt;
    docInspecaoSai:  tpeTipEtq := tpeInspecaoSai;

    docLiberacaoArmazenagem: tpeTipEtq := tpeLiberacaoArmazenagem;
    docRecAmostra: tpeTipEtq := tpeAmostraProdutoAuto;
    docOrdProImobiliaria: tpeTipEtq := tpeOrdProImobiliaria;
    docOrdProAutomotiva: tpeTipEtq := tpeOrdProAutomotiva;

    docLocacaoEquipamento: tpeTipEtq := tpeLocacaoEquipamento;
    docRL                : tpeTipEtq := tpeRL;
    docDevolucaoLocacao  : tpeTipEtq := tpeDevolucaoLocacao;
    docFaturaLocacao     : tpeTipEtq := tpeFaturaLocacao;

    docEnderecamentoDeProduto : tpeTipEtq := tpeEnderecamentoDeProduto;

    docPDExterior : tpeTipEtq := tpePDExterior;
    docORExterior : tpeTipEtq := tpeORExterior;

    docCupomPromocao : tpeTipEtq := tpeCupomPromocao;
    docRemessaDevolucao : tpeTipEtq := tpeRemessaDevolucao;
    docRB               : tpeTipEtq := tpeRB;
    docFFDocumentosCR   : tpeTipEtq := tpeFFDocumentosCR;
    docCupomProxDesc    : tpeTipEtq := tpeCupomProxDesc;
    Else          Result := False;
  End;

End;

Function fEspecieToTipoDocumeto(strNumDoc,
                                strEspDoc,
                                strCodEmp,
                                strTip_FC: String;
                                blnDocSep,
                                blnRequisicao,
                                blnImpSepRomaneio,
                                blnVidro: Boolean;
                                tpeTipEtq: TTipoEtiqueta = tpeNenhum): TTipoDocumento;
Begin

  if tpeTipEtq = tpeFFDocumentosCR then
    Result := docFFDocumentosCR

  else if tpeTipEtq = tpeRemessaDevolucao then
    Result := docRemessaDevolucao

  Else if tpeTipEtq = tpeCupomPromocao Then
    Result := docCupomPromocao

  Else If tpeTipEtq = tpeLiberacaoArmazenagem Then
    Result := docLiberacaoArmazenagem

  Else If tpeTipEtq = tpeCarnePagamento Then
    Result := docCarnePagamento

  Else If tpeTipEtq = tpeDuplicata Then
    Result := docDuplicata


  Else If tpeTipEtq = tpeComprovanteGeracaoCredito Then
    Result := docComprovanteGeracaoCredito

  Else If tpeTipEtq = tpeProcessoDeExtrusao Then
    Result := docProcessoDeExtrusao

  Else If tpeTipEtq = tpeEnderecamentoDeProduto Then
    Result := docEnderecamentoDeProduto

  Else If tpeTipEtq = tpePDExterior Then
    Result := docPDExterior

  Else If tpeTipEtq = tpeORExterior Then
    Result := docORExterior

  Else If tpeTipEtq = tpeInspecaoEnt Then
    Result := docInspecaoEnt

  Else If tpeTipEtq = tpeInspecaoSai Then
    Result := docInspecaoSai

  Else If tpeTipEtq = tpeSepNotaObs Then
    Result := docSepNotaObs

  Else If tpeTipEtq = tpeCupomProxDesc Then
    Result := docCupomProxDesc

  Else If ((strEspDoc = 'PD') Or (strEspDoc = 'OR')) And  (tpeTipEtq = tpePedidoCompra) Then
    result := docPedidoCompra

  Else If ((strEspDoc = 'SME')) And  (tpeTipEtq = tpeSolicitacaoManutencaoEquipamentos) Then
    result := docSolicitacaoManutencaoEquipamentos

  Else If tpeTipEtq = tpeDevolucaoLocacao Then
    Result := docDevolucaoLocacao

  Else If tpeTipEtq = tpeCupomProxDesc Then
    Result := docCupomProxDesc

  Else If strEspDoc = 'MI' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docMI

  End
  Else If strEspDoc = 'FF' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
    begin
      if (tpeTipEtq = tpeOrdProImobiliaria) Then
        Result := docOrdProImobiliaria
      else if (tpeTipEtq = tpeOrdProAutomotiva) Then
        Result := docOrdProAutomotiva
      else
        Result := docFF
    end;
  End

  Else If (tpeTipEtq = tpeOrdProImobiliaria) Then
    Result := docOrdProImobiliaria

  Else If (tpeTipEtq = tpeOrdProAutomotiva) Then
    Result := docOrdProAutomotiva

  Else If strEspDoc = 'BR' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docBR

  End

  Else If strEspDoc = 'TR' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docTR

  End

  Else If (tpeTipEtq = tpeTicketDV) And (strEspDoc =  'DV') Then
     Result := docTicketDV
  Else If strEspDoc = 'DV' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docDV

  End

  Else If (strEspDoc = 'AJ') Or
          ((strEspDoc = 'ML') And (fCampoTabela('GER_TIPFAT', 'MOVGER', ['GER_NUMFAT', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodEmp] ) = 'AJ')) Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docAJ

  End

  Else If (strEspDoc = 'TA') Or (strEspDoc = 'TL') Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docTA

  End

  Else If strEspDoc = 'EP' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docEP

  End

  Else If strEspDoc = 'BE' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docBE

  End

  Else If strEspDoc = 'UC' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docUS

  End

  Else If strEspDoc = 'CS' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docCS

  End

  Else If strEspDoc = 'CR' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docCR

  End

  Else If strEspDoc = 'TE' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docTE

  End

  Else If strEspDoc = 'PI' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docPI

  End

  Else If (strEspDoc = 'PD') And (Not blnRequisicao) Then
  Begin
    If tpeTipEtq = tpeAmostraProdutoAuto Then
      Result := docRecAmostra
    Else
    Begin

      If (blnImpSepRomaneio) Then
        Result := docSepRomaneio

      ELse If blnDocSep Then
        Result := docSepPedido

      Else
        Result := docPD

    End;

  End
  Else If strEspDoc = 'OR' Then
  Begin

    If blnDocSep Then
      Result := docSepPedido
    Else
      Result := docOR

  End
  Else If strEspDoc = 'PR' Then
  Begin

    If blnDocSep Then
      Result := docSepPedido
    Else
      Result := docPR

  End

  Else If (strEspDoc = 'RO') Then
  Begin
    if  blnDocSep then
      Result := docSepRomaneio
    Else
      Result := docROTin
  End
  Else If (tpeTipEtq = tpeOrdPro) Then
     Result := docOrdPro
  Else If (tpeTipEtq = tpeTicketNF) And (strEspDoc =  'NF') Then
     Result := docTicketNF
  Else If (strEspDoc =  'NF') And (Not blnRequisicao) and (tpeTipEtq <> tpeContGR) Then
  Begin

    If strTip_FC = 'F' Then
    Begin

      If blnDocSep Then
        Result := docSepSF
      Else
        Result := docSF

    End Else
    Begin

      If blnDocSep Then
        Result := docSepNota
      Else
        Result := docNF

    End;

  End

  Else If (strEspDoc =  'IF') Or (strEspDoc =  'IV') Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docIF

  End

  Else If strEspDoc =  'D1' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docD1

  End

  Else If strEspDoc =  'NS' Then
  Begin
    If (tpeTipEtq = tpeCupomServico) Then
      Result := docCupomServico
    Else If blnDocSep Then
      Result := docSepNota
    Else
      Result := docNS

  End

  Else If strEspDoc = 'GA' Then
  Begin

    If blnDocSep Then
      Result := docSepNota
    Else
      Result := docGA

  End

  Else If (tpeTipEtq = tpeSeparacaoGondola) Then
  Begin
    Result := docSeparacaoGondola
  End


  Else If strEspDoc = 'PA' Then
  Begin
    Result := docPA
  End


  Else If strEspDoc = 'GF' Then
  Begin
    If tpeTipEtq = tpeContGF then
       result := docContGF
    else If blnDocSep Then
      Result := docSepNota
    Else
      Result := docGF;
  End

  { Quando for retorno do fornecedor porem gerado no uma NF e não uma GR }
  Else If (strEspDoc = 'GR') or ((tpeTipEtq = tpeContGR) and (strEspDoc = 'NF')) Then
  Begin
    if tpeTipEtq = tpeContGRBaixa then
      result := docContGRBaixa
    else
      result := docContGR
  End

  Else If strEspDoc = 'GC' Then
    result := docContGC

  Else if strEspDoc = 'OS' Then
    Result := docOrdemServico
  Else if strEspDoc = 'OSTR' Then
    Result := docOrdemServicoTermoResp
  Else if strEspDoc = 'OSTD' Then
    Result := docOrdemServicoTermoDev
  Else if strEspDoc = 'OSOE' Then
    Result := docOrdemServicoOrdExecucao
  Else if strEspDoc = 'OSIM' Then
    Result := docOrdemServicoImagem
  Else if (strEspDoc = 'RQ') And blnVidro Then
    Result := docReqMaterialConsumoVidro
  Else if strEspDoc = 'RQ' Then
    Result := docReqMaterialConsumo
  Else if strEspDoc = 'IT' Then
    Result := docSepItem

  Else If blnRequisicao Then
     Result := docRequisicao

  Else if strEspDoc = 'CPS' Then
    Result := docCarnePagamento
  Else if strEspDoc = 'DPS' Then
    Result := docDuplicata

  Else if strEspDoc = 'CGC' Then
    Result := docComprovanteGeracaoCredito

  Else if strEspDoc = 'PEX' Then
    Result := docProcessoDeExtrusao

  Else if strEspDoc = 'IPE' Then
    Result := docInspecaoEnt
  Else if strEspDoc = 'IPS' Then
    Result := docInspecaoSai

  Else if strEspDoc = 'LAR' Then
    Result := docLiberacaoArmazenagem
  Else if strEspDoc = 'LE' Then
    Result := docLocacaoEquipamento

  Else if strEspDoc = 'RL' Then
  Begin
    If (tpeTipEtq = tpeFaturaLocacao) Then
      Result := docFaturaLocacao
    Else
      Result := docRL
  End

  Else if strEspDoc = 'RB' Then
  Begin
    Result := docRB
  End

  Else Result := docVazio;
End;

Function fMargemFastToColunasMatricial(fltValCm: Double; blnAltura: Boolean): Double;
Begin
  If blnAltura Then
    Result := Trunc( fltValCm / FATOR_MARGEM_VERTICAL)
  Else
    Result := Trunc( fltValCm / FATOR_MARGEM_HORIZONTAL);
End;

Function fMargemmFastMatricialToPixels(fltValCm: Double; blnAltura: Boolean): Double;
Begin
  Result := fMargemFastToColunasMatricial(fltValCm, blnAltura);

  Result := fCmColunaToPixel(Result, blnAltura, 'M', False);
End;

Function fCmToPixel(fltValCm: Double; blnRound: Boolean = True): Double;
Begin
  If blnRound Then
    Result := RoundTo(fltValCm * CMPIXEL, -2)
  Else
    Result := fltValCm * CMPIXEL;
End;

Function fCmToPixelFloor(fltValCm: Double): Integer;
Begin
  Result := Floor(fltValCm * CMPIXEL);
End;

Function fPixelToCm(fltValPix: Double; blnRound: Boolean = True): Double;
Begin
  If blnRound Then
    Result := RoundTo(fltValPix / CMPIXEL, -2)
  Else
    Result := fltValPix / CMPIXEL;
End;

Function fColunaToPixel(fltValCol: Double; blnAltura: Boolean; blnRound: Boolean = True): Double;
Begin
  If blnAltura Then
    Result := fltValCol * ALTURA_FONTE_MATRICIAL_PIXEL
  Else
    Result := fltValCol * LARGURA_FONTE_MATRICIAL_PIXEL;

  If blnRound Then
    Result := RoundTo(Result, -2);
End;

Function fPixelToColuna(fltValPix: Double; blnAltura: Boolean; blnRound: Boolean = True): Double;
Begin
  If blnAltura Then
    Result := fltValPix / ALTURA_FONTE_MATRICIAL_PIXEL
  Else
    Result := fltValPix / LARGURA_FONTE_MATRICIAL_PIXEL;

  If blnRound Then
    Result := RoundTo(Result, -2);
End;

Function fCmColunaToPixel(fltValCm: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;
Begin
  If strTipImp = 'J' Then
    Result := fCmToPixel(fltValCm, blnRound)
  Else
    Result := fColunaToPixel(fltValCm, blnAltura, blnRound);
End;

Function fPixelToCmColuna(fltValPix: Double; blnAltura: Boolean; strTipImp: String; blnRound: Boolean = True): Double;
Begin
  If strTipImp = 'J' Then
    Result := fPixelToCm(fltValPix, blnRound)
  Else
    Result := fPixelToColuna(fltValPix, blnAltura, blnRound);
End;

Procedure pInicializaFonteMatrcial(Var recCfgFon: TRecFonteMatricial);
Begin
  With recCfgFon Do
  Begin
    blnWide        := False;
    blnNegrito     := False;
    blnItalico     := False;
    blnSublinhado  := False;
    blnSuperScript := False;
    blnSubScript   := False;
    blnCondensado  := False;
    blnExpandido   := False;
    bln12cpi       := False;
    bln15cpi       := False;
  End;
End;

Function fTemParametro(frxReport: TfrxReport; strNomPar: WideString): Boolean;
  Var
    intIndice: Integer;
Begin
  Result := False;

  With frxReport Do
    For intIndice := 0 To ComponentCount - 1 Do
    If ((Components[intIndice].ClassNameIs('TfrxMemoView')) And (Pos(strNomPar, TfrxMemoView(Components[intIndice]).Text) > 0)) Or
       ((Components[intIndice].ClassNameIs('TfrxDMPMemoView')) And (Pos(strNomPar, TfrxDMPMemoView(Components[intIndice]).Text) > 0)) Then
    Begin
      Result := True;
      Break;
    End;
End;

function fRetNomCampoLayout(strCodigo: String; intCodEti: Integer; intPosCam: Integer = -1): String;
  Var
    qryCamEti: TUniQuery;
Begin
  Result := '';
  
  qryCamEti := fCriaQuery(Nil);

  With qryCamEti, SQL Do
  Begin
    Clear;

    Add('SELECT');
    Add('  CAM_DESCAM');
    Add('FROM');
    Add('  CAMETI');
    Add('WHERE');

    Add('  CAM_CODCAM = :CODCAM AND ');
    Add(fSQLFiltroCamposDocumento(intCodEti));

    If intPosCam <> - 1 Then
      Add(' AND CAM_POSCAM = :POSCAM');

    Add('LIMIT 1');

    ParamByName('CODCAM').AsString := strCodigo;

    If intPosCam <> - 1 Then
      ParamByName('POSCAM').AsInteger := intPosCam;

    If Assigned(FindParam('CODETI')) Then
      ParamByName('CODETI').AsInteger := intCodEti;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('CAM_DESCAM').AsString;

    Close;
  End;

  FreeAndNil(qryCamEti);
End;

Function fTextoToColMat(strTexto: String): TcolMatricial;
Begin
  If SameText(strTexto, STR_040COL) Then
    Result := col40

  Else If SameText(strTexto, STR_080COL) Then
    Result := col80

  Else If SameText(strTexto, STR_096COL) Then
    Result := col96

  Else If SameText(strTexto, STR_137COL) Then
    Result := col137

  Else If SameText(strTexto, STR_160COL) Then
    Result := col160

  Else Result := colVazio;
End;

 Function fColMatToTexto(colFonte: TcolMatricial): String;
 Begin
   Case colFonte Of
     col40 :  Result := STR_040COL;
     col80 :  Result := STR_080COL;
     col96 :  Result := STR_096COL;
     col137:  Result := STR_137COL;
     col160:  Result := STR_160COL;
     else     Result := STR_137COL;
   End;
 End;

Function fLarguraColuna(colFonPag, colFonMat: TcolMatricial; strTipImp: String): Double;
  Var
    fltLarPag: Double;
Begin
  Result := fCmColunaToPixel(1, False, strTipImp, False);

  Case colFonPag Of
    col40 : fltLarPag := 39  * Result;
    col80 : fltLarPag := 79  * Result;
    col96 : fltLarPag := 95  * Result;
    col137: fltLarPag := 136 * Result;
    Else    fltLarPag := 159 * Result;
  End;

  Case colFonMat Of
    col40 : If Result < fltLarPag / 39 Then
              Result := fltLarPag / 39;

    col80 : If Result < fltLarPag / 79 Then
              Result := fltLarPag / 79;

    col96 : If Result < fltLarPag / 95 Then
              Result := fltLarPag / 95;

    col137: If Result < fltLarPag / 136 Then
              Result := fltLarPag / 136;

    Else    If Result < fltLarPag / 159 Then
              Result := fltLarPag / 159;
  End;
End;

function fCodigoToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
Begin
  For Result := Low(ARR_CODIGO_ETIQUETA) To High(ARR_CODIGO_ETIQUETA) Do
    If intCodLay = ARR_CODIGO_ETIQUETA[Result] Then
      Break;
End;

function fCodLayToTipoEtiqueta(intCodLay: Integer): TTipoEtiqueta;
Begin
  For Result := Low(ARR_TIPO_LAYOUT) To High(ARR_TIPO_LAYOUT) Do
    If intCodLay = ARR_TIPO_LAYOUT[Result] Then
      Break;
End;

function fTipoEtiquetaToTipoLayout(tipoEtiq: TTipoEtiqueta): Integer;
begin
  Result := ARR_TIPO_LAYOUT[tipoEtiq];
end;

function fSQLFiltroCamposDocumento(intCodEti: Integer): String;
Begin

  If fCodigoToTipoEtiqueta(intCodEti) In CONJ_DOCUMENTOS Then
  Begin
    Result := '  ((CAM_CODETI = :CODETI) OR ';

    Case fCodigoToTipoEtiqueta(intCodEti) of
      tpeMI         :  Result := Result + '  (CAM_DOC_MI = "S") ';
      tpeBR,
      tpeTR,
      tpeDV,
      tpeAJ,
      tpeTA,
      tpeEP,
      tpeBE,
      tpeUS,
      tpeCS,
      tpeCR,
      tpeTE,
      tpePI,
      tpeTicketDV,
      tpeFF         :  Result := Result + '  (CAM_DOC_FF = "S") ';
      tpeFFDocumentosCR : Result := Result + '  (CAM_DOC_CRFF = "S") ';
      tpePD,
      tpePR         :  Result := Result + '  (CAM_DOC_PD = "S") ';
      tpePA         :  Result := Result + '  (CAM_DOC_PA = "S") ';
      tpeROTin      :  Result := Result + '  (CAM_DOC_RO = "S") ';
      tpeOR         :  Result := Result + '  (CAM_DOC_OR = "S") ';

      tpeGA         :  Result := Result + '  (CAM_DOC_GA = "S") ';
      tpeGF,
      tpeContGF     :  Result := Result + '  (CAM_DOC_GF = "S") ';
      tpeContGR     :  Result := Result + '  (CAM_DOC_GR = "S") ';
      tpeContGRBaixa:  Result := Result + '  (CAM_DOC_GR_B = "S") ';
      tpeSolicitacaoManutencaoEquipamentos: Result := Result + '  (CAM_MANEIN = "S") ';
      tpePedidoCompra: Result := Result + '  (CAM_DOCPDC = "S") ';
      tpeContGC     :  Result := Result + '  (CAM_DOC_GC = "S") ';

      tpeNF,
      tpeNS,
      tpeIF,
      tpeTicketNF,
      tpeD1         :  Result := Result + '  (CAM_DOC_NF = "S") ';

      tpeCarnePagamento :  Result := Result + '  (CAM_DOC_CP = "S") ';

      tpeDuplicata :  Result := Result + '  (CAM_DOC_DP = "S") ';


      tpeComprovanteGeracaoCredito :  Result := Result + '  (CAM_DOC_CC = "S") ';

      tpeProcessoDeExtrusao : Result := Result + '  (CAM_DOC_PE = "S") ';

      tpeInspecaoEnt :  Result := Result + '  (CAM_DOC_IE = "S") ';

      tpeInspecaoSai :  Result := Result + '  (CAM_DOC_IS = "S") ';

      tpeLiberacaoArmazenagem :  Result := Result + '  (CAM_DOC_LA = "S") ';

      tpeSF,
      tpeSepSF      :  Result := Result + '  (CAM_DOC_SF = "S") ';

      tpeSepNota,tpeSepNotaObs    :  Result := Result + '  (CAM_SEP_MI = "S") ';
      tpeSepPedido  :  Result := Result + '  (CAM_SEP_PD = "S") ';
      tpeSepRomaneio:  Result := Result + '  (CAM_SEP_RO = "S") ';
      tpeSepItem    :  Result := Result + '  (CAM_SEP_IT = "S") ';
      tpeRequisicao :  Result := Result + '  (CAM_REQUIS = "S") ';
      tpeCupomServico: Result := Result + '  (CAM_CUPSER = "S") ';
      tpeOrdemServico,
      tpeOrdemServicoTermoResp,
      tpeOrdemServicoTermoDev,
      tpeOrdemServicoOrdExecucao,
      tpeOrdemServicoImagem: Result := Result + '  (CAM_DOC_EQU = "S") ';
      tpeReqMaterialConsumo: Result := Result + '  (CAM_DOC_RQ = "S") ';
      tpeReqMaterialConsumoVidro: Result := Result + '  (CAM_DOC_RV = "S") ';
      tpeAmostraProdutoAuto: Result := Result + ' (CAM_DOC_PD = "S") ';
      tpeOrdProImobiliaria: Result := '   (CAM_ORDIMO = "S") AND (CAM_CODETI = :CODETI';
      tpeOrdProAutomotiva: Result := ' (CAM_ORDAUT = "S")  AND (CAM_CODETI = :CODETI';
      tpeRL, tpeFaturaLocacao:  Result := Result + '  (CAM_DOC_RL = "S") ';
      tpeDevolucaoLocacao       :  Result := Result + '  (CAM_DOC_DL = "S") ';
      tpeEnderecamentoDeProduto : Result := Result + '  (CAM_DOC_EN = "S") ';
      tpePDExterior : Result := Result + '  (CAM_DOC_PX = "S") ';
      tpeORExterior : Result := Result + '  (CAM_DOC_OX = "S") ';
      tpeCupomPromocao : Result := Result + ' (CAM_CUPPRO = "S") ';
      tpeRemessaDevolucao : Result := Result + ' (CAM_DOC_RD = "S") ';
      tpeRB:  Result := Result + '  (CAM_DOC_RB = "S") ';
      Else
        Result := Result + '  FALSE              ';
    End;

    Result := Result + ' ) ';

  End
  Else
    Result := '  CAM_CODETI = :CODETI ';

End;

{****************************************************************************}
{* REFORMA TRIBUTARIA NO LAYOUT DO PEDIDO DE COMPRA (TIPO 214)               *}
{* Injeta CBS / IBS / IS no fr3 ja gravado do cliente, achando os pontos     *}
{* pelo conteudo (nao pelo nome dos objetos, que muda de layout a layout):   *}
{*  - linha nova no item e no cabecalho: %CBS, VR. CBS, %IBS, VR. IBS, ...   *}
{*  - total do pedido (TOTGER) somando CBS + IBS + IS dos itens              *}
{*  - bloco PIS/COFINS do rodape (paisagem) vira CBS / IBS / IS no lugar      *}
{* Tudo condicionado a <frxMovger."SOMREF"> = 'S'. Layout com LAY_REFTRI    *}
{* = 'S' (salvo no editor depois da reforma) ou que ja usa DVLCBS: intacto. *}
{* Trabalha byte a byte e so grava ASCII: nao depende do encoding do blob.   *}
{****************************************************************************}
type
  TBandaFr3 = Record
    intIni: Integer;
    intFim: Integer;
  End;

const
  STR_FR3_SOMREF  = '&#60;frxMovger.&#34;SOMREF&#34;&#62;  = ''S''';
  STR_FR3_TOTGER  = '&#60;frxMovger.&#34;TOTGER&#34;&#62;';
  // mesmo campo escrito sem os sinais de menor / maior (formato do campo arrastado no designer)
  STR_FR3_TOTGER_CAMPO = '[frxMovger.&#34;TOTGER&#34;]';
  FLT_FR3_ALT_LIN = 13.986;
  FLT_FR3_LAR_ALQ = 45.36;
  FLT_FR3_LAR_VAL = 64.26;
  ARR_FR3_IMPOSTO : Array[0..2] Of String = ('CBS', 'IBS', 'IS');
  ARR_FR3_ALIQUOTA: Array[0..2] Of String = ('DALCBS', 'DALQIB', 'DALQIS');
  ARR_FR3_VALOR   : Array[0..2] Of String = ('DVLCBS', 'DVLIBS', 'DVL_IS');
  // totais do pedido no cabecalho (frxMovger): sem agregado no layout, o editor reescreve SUM( como SUM ( e o Fast nao o reconhece
  // Verificar Nota 1 - Req. 462714
  ARR_FR3_BASE_PED : Array[0..2] Of String = ('TBSCBS', 'TBSIBS', 'TBS_IS');
  ARR_FR3_VALOR_PED: Array[0..2] Of String = ('VALCBS', 'VALIBS', 'VAL_IS');
  // bloco PIS/COFINS do rodape (layout paisagem padrao), trocado no lugar por CBS/IBS/IS
  ARR_FR3_PISCOFINS: Array[0..1, 0..2] Of String = (('BASPIS', 'ALIPIS', 'VALPIS'), ('BASCOF', 'ALICOF', 'VALCOF'));
  ARR_FR3_NOME_PISCOFINS: Array[0..1] Of String = ('PIS', 'COFINS');
  ARR_FR3_TITULO_PISCOFINS: Array[0..2] Of String = ('BASE C&#193;LC. ', 'AL&#205;QUOTA ', 'VALOR DO ');
  ARR_FR3_BANDA_TOTAL: Array[0..4] Of String = ('TfrxFooter', 'TfrxReportSummary', 'TfrxPageFooter', 'TfrxGroupFooter',
                                                 'TfrxChild');

function fBytesParaTextoFr3(const AarrBytes: TBytes): String;
Var
  intIndice: Integer;
Begin
  SetLength(Result, Length(AarrBytes));
  For intIndice := 0 To High(AarrBytes) Do
    Result[Low(Result) + intIndice] := Char(AarrBytes[intIndice]);
End;

function fTextoParaBytesFr3(const AstrTexto: String): TBytes;
Var
  intIndice: Integer;
Begin
  SetLength(Result, Length(AstrTexto));
  For intIndice := 0 To Length(AstrTexto) - 1 Do
    Result[intIndice] := Byte(Ord(AstrTexto[Low(AstrTexto) + intIndice]));
End;

function fAtributoFr3(const AstrLinha, AstrNome: String): String;
Var
  intPos,
  intFim: Integer;
Begin
  Result := '';

  // o espaco antes do nome evita casar Font.Height quando se procura Height
  intPos := Pos(' ' + AstrNome + '="', AstrLinha);
  If intPos = 0 Then
    Exit;

  intPos := intPos + Length(AstrNome) + 3;
  intFim := Pos('"', AstrLinha, intPos);
  Result := Copy(AstrLinha, intPos, intFim - intPos);
End;

function fTrocaAtributoFr3(const AstrLinha, AstrNome, AstrValor: String): String;
Var
  intPos,
  intFim: Integer;
Begin
  Result := AstrLinha;

  intPos := Pos(' ' + AstrNome + '="', AstrLinha);
  If intPos = 0 Then
    Exit;

  intPos := intPos + Length(AstrNome) + 3;
  intFim := Pos('"', AstrLinha, intPos);
  Result := Copy(AstrLinha, 1, intPos - 1) + AstrValor + Copy(AstrLinha, intFim, MaxInt);
End;

function fRemoveAtributoFr3(const AstrLinha, AstrNome: String): String;
Var
  intPos,
  intFim: Integer;
Begin
  Result := AstrLinha;

  intPos := Pos(' ' + AstrNome + '="', AstrLinha);
  If intPos = 0 Then
    Exit;

  intFim := Pos('"', AstrLinha, intPos + Length(AstrNome) + 3);
  Result := Copy(AstrLinha, 1, intPos - 1) + Copy(AstrLinha, intFim + 1, MaxInt);
End;

function fDesligaCampoFr3(const AstrLinha: String): String;
Begin
  // memo ligado a campo (arrastado no designer) imprime o DataField e ignora o Text reescrito
  Result := fRemoveAtributoFr3(AstrLinha, 'DataField');
  Result := fRemoveAtributoFr3(Result, 'DataSet');
  Result := fRemoveAtributoFr3(Result, 'DataSetName');
End;

function fNumeroFr3(const AstrValor: String): Double;
Var
  intErro: Integer;
Begin
  Val(StringReplace(AstrValor, ',', '.', []), Result, intErro);
  If intErro <> 0 Then
    Result := 0;
End;

function fTextoNumeroFr3(AfltValor: Double): String;
Var
  fmtVirgula: TFormatSettings;
Begin
  fmtVirgula := TFormatSettings.Create;
  fmtVirgula.DecimalSeparator  := ',';
  fmtVirgula.ThousandSeparator := '.';
  Result := FormatFloat('0.###', AfltValor, fmtVirgula);
End;

function fCampoItemFr3(const AstrCampo: String): String;
Begin
  Result := '&#60;frxDBImpEti.&#34;' + AstrCampo + '&#34;&#62;';
End;

function fCampoPedidoFr3(const AstrCampo: String): String;
Begin
  Result := '&#60;frxMovger.&#34;' + AstrCampo + '&#34;&#62;';
End;

function fEhObjetoFr3(const AstrLinha: String): Boolean;
Begin
  Result := Pos('<Tfrx', TrimLeft(AstrLinha)) = 1;
End;

function fBandasFr3(lstLinhas: TStringList; const AstrTipo: String): TArray<TBandaFr3>;
Var
  intIndice,
  intFim: Integer;
  strLinha: String;
  recBanda: TBandaFr3;
Begin
  SetLength(Result, 0);
  intIndice := 0;

  While intIndice < lstLinhas.Count Do
  Begin
    strLinha := Trim(lstLinhas[intIndice]);

    If (Pos('<' + AstrTipo + ' ', strLinha) = 1) And (Copy(strLinha, Length(strLinha) - 1, 2) <> '/>') Then
    Begin
      intFim := intIndice + 1;
      While (intFim < lstLinhas.Count) And (Pos('</' + AstrTipo + '>', Trim(lstLinhas[intFim])) <> 1) Do
        Inc(intFim);

      If intFim >= lstLinhas.Count Then
        Break;

      recBanda.intIni := intIndice;
      recBanda.intFim := intFim;
      SetLength(Result, Length(Result) + 1);
      Result[High(Result)] := recBanda;

      intIndice := intFim;
    End;

    Inc(intIndice);
  End;
End;

function fBaseBandaFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3): Double;
Var
  intIndice: Integer;
Begin
  Result := 0;
  For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    If fEhObjetoFr3(lstLinhas[intIndice]) And (fAtributoFr3(lstLinhas[intIndice], 'Align') <> 'baClient') Then
      Result := Max(Result, fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Top')) +
                            fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Height')));
End;

function fLarguraBandaFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3): Double;
Var
  intIndice: Integer;
Begin
  Result := 0;
  For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    If fEhObjetoFr3(lstLinhas[intIndice]) Then
      Result := Max(Result, fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Left')) +
                            fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Width')));
End;

function fRecuoBandaFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3): String;
Var
  strLinha: String;
Begin
  strLinha := lstLinhas[ArecBanda.intIni];
  Result   := Copy(strLinha, 1, Length(strLinha) - Length(TrimLeft(strLinha))) + '  ';
End;

procedure pCresceBandaFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3; AfltDelta: Double);
Var
  intIndice: Integer;
  fltAltura,
  fltLargura,
  fltTop,
  fltObjeto: Double;
Begin
  fltAltura  := fNumeroFr3(fAtributoFr3(lstLinhas[ArecBanda.intIni], 'Height'));
  fltLargura := fLarguraBandaFr3(lstLinhas, ArecBanda);

  lstLinhas[ArecBanda.intIni] := fTrocaAtributoFr3(lstLinhas[ArecBanda.intIni], 'Height',
    fTextoNumeroFr3(fltAltura + AfltDelta));

  // acompanham a altura da banda: fundo e zebra (Align = baClient) e a caixa que cobre a banda
  // inteira (ex.: caixa cinza do cabecalho, memo fixo de largura total)
  For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
  Begin
    If Not fEhObjetoFr3(lstLinhas[intIndice]) Then
      Continue;

    fltTop    := fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Top'));
    fltObjeto := fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Height'));

    If (fAtributoFr3(lstLinhas[intIndice], 'Align') = 'baClient') Or
       ((fltTop <= 0.5) And (fltTop + fltObjeto >= fltAltura - 0.5) And
        (fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Width')) >= 0.9 * fltLargura)) Then
      lstLinhas[intIndice] := fTrocaAtributoFr3(lstLinhas[intIndice], 'Height', fTextoNumeroFr3(fltObjeto + AfltDelta));
  End;
End;

function fProximoMemoFr3(lstLinhas: TStringList): Integer;
Var
  intIndice,
  intNumero: Integer;
  strNome: String;
Begin
  Result := 1;
  For intIndice := 0 To lstLinhas.Count - 1 Do
  Begin
    strNome := fAtributoFr3(lstLinhas[intIndice], 'Name');
    // SameText: o designer nomeia MemoN e o Fast compara nomes sem diferenciar maiusculas
    If SameText(Copy(strNome, 1, 4), 'memo') And TryStrToInt(Copy(strNome, 5, MaxInt), intNumero) Then
      Result := Max(Result, intNumero + 1);
  End;
End;

function fMemoFr3(const AstrRecuo: String; Var AintProxMemo: Integer;
  AfltLeft, AfltTop, AfltWidth, AfltHeight: Double; const AstrTexto: String;
  AblnNegrito, AblnNumerico: Boolean): String;
Begin
  Result := AstrRecuo + '<TfrxMemoView Name="memo' + IntToStr(AintProxMemo) + '" Description="#18#27#80#27#87#49"' +
            ' Left="' + fTextoNumeroFr3(AfltLeft) + '" Top="' + fTextoNumeroFr3(AfltTop) + '"' +
            ' Width="' + fTextoNumeroFr3(AfltWidth) + '" Height="' + fTextoNumeroFr3(AfltHeight) + '"';
  Inc(AintProxMemo);

  If AblnNumerico Then
    Result := Result + ' DisplayFormat.DecimalSeparator="," DisplayFormat.FormatStr="%2.2n" DisplayFormat.Kind="fkNumeric"';

  Result := Result + ' Font.Charset="1" Font.Color="-16777208" Font.Height="-11" Font.Name="Arial"';

  If AblnNegrito Then
    Result := Result + ' Font.Style="1"'
  Else
    Result := Result + ' Font.Style="0"';

  Result := Result + ' Frame.Width="0" HAlign="haRight" ParentFont="False" WordWrap="False" Text="' + AstrTexto + '"/>';
End;

procedure pLinhaColunasFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3; AblnTitulo: Boolean;
  Var AintProxMemo: Integer; lstBloco: TStringList);
Var
  intImposto: Integer;
  fltTop,
  fltLeft,
  fltDelta: Double;
  strRecuo,
  strAliquota,
  strValor: String;
Begin
  // linha nova embaixo da ultima linha da banda, colunas encostadas a direita
  fltTop   := fBaseBandaFr3(lstLinhas, ArecBanda);
  fltLeft  := fLarguraBandaFr3(lstLinhas, ArecBanda) - 3 * (FLT_FR3_LAR_ALQ + FLT_FR3_LAR_VAL);
  strRecuo := fRecuoBandaFr3(lstLinhas, ArecBanda);

  For intImposto := 0 To 2 Do
  Begin
    If AblnTitulo Then
    Begin
      strAliquota := '''%' + ARR_FR3_IMPOSTO[intImposto] + '''';
      strValor    := '''VR. ' + ARR_FR3_IMPOSTO[intImposto] + '''';
    End Else
    Begin
      strAliquota := 'FormatFloat ( ''0.00'' , ' + fCampoItemFr3(ARR_FR3_ALIQUOTA[intImposto]) + '  )';
      strValor    := 'FormatFloat ( ''0.00'' , ' + fCampoItemFr3(ARR_FR3_VALOR[intImposto]) + '  )';
    End;

    lstBloco.Add(fMemoFr3(strRecuo, AintProxMemo, fltLeft, fltTop, FLT_FR3_LAR_ALQ, FLT_FR3_ALT_LIN,
      '[IIF ( ' + STR_FR3_SOMREF + ' , ' + strAliquota + ' , '''' )]', AblnTitulo, False));
    fltLeft := fltLeft + FLT_FR3_LAR_ALQ;

    lstBloco.Add(fMemoFr3(strRecuo, AintProxMemo, fltLeft, fltTop, FLT_FR3_LAR_VAL, FLT_FR3_ALT_LIN,
      '[IIF ( ' + STR_FR3_SOMREF + ' , ' + strValor + ' , '''' )]', AblnTitulo, False));
    fltLeft := fltLeft + FLT_FR3_LAR_VAL;
  End;

  fltDelta := fltTop + FLT_FR3_ALT_LIN + 1 - fNumeroFr3(fAtributoFr3(lstLinhas[ArecBanda.intIni], 'Height'));
  If fltDelta > 0 Then
    pCresceBandaFr3(lstLinhas, ArecBanda, fltDelta);
End;

function fLinhaCampoPedidoFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3; const AstrCampo: String): Integer;
Var
  intIndice: Integer;
Begin
  Result := -1;
  For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    If Pos(fCampoPedidoFr3(AstrCampo), fAtributoFr3(lstLinhas[intIndice], 'Text')) > 0 Then
      Exit(intIndice);
End;

function fLinhaRotuloFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3; AintValor: Integer): Integer;
Var
  intIndice: Integer;
  fltLeft,
  fltTop: Double;
Begin
  // titulo e o memo sem campo que fica logo acima do valor, na mesma coluna
  Result  := -1;
  fltLeft := fNumeroFr3(fAtributoFr3(lstLinhas[AintValor], 'Left'));
  fltTop  := fNumeroFr3(fAtributoFr3(lstLinhas[AintValor], 'Top'));

  For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    If (intIndice <> AintValor) And fEhObjetoFr3(lstLinhas[intIndice]) And
       (fAtributoFr3(lstLinhas[intIndice], 'Align') <> 'baClient') And
       (Pos('&#60;', fAtributoFr3(lstLinhas[intIndice], 'Text')) = 0) And
       (Abs(fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Left')) - fltLeft) <= 1) And
       (Abs(fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Top')) +
            fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Height')) - fltTop) <= 1.5) Then
      Exit(intIndice);
End;

function fTrocaPisCofinsFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3;
  Var AintProxMemo: Integer; lstBloco: TStringList): Boolean;
Var
  arrValor,
  arrRotulo: Array[0..1, 0..2] Of Integer;
  intLinha,
  intColuna,
  intIndice: Integer;
  fltTopo,
  fltFundo,
  fltDelta,
  fltObjeto,
  fltAltura,
  fltDireita,
  fltFator: Double;
  strLinha: String;

  function fNoBloco(AintIndice: Integer): Boolean;
  Var
    intL,
    intC: Integer;
  Begin
    Result := False;
    For intL := 0 To 1 Do
      For intC := 0 To 2 Do
        If (arrValor[intL, intC] = AintIndice) Or (arrRotulo[intL, intC] = AintIndice) Then
          Exit(True);
  End;

  function fTitulo(AintImposto, AintColuna: Integer): String;
  Var
    strAnterior: String;
  Begin
    // linhas de CBS e IBS voltam a PIS e COFINS com a configuracao desligada; a do IS fica vazia
    If AintImposto < 2 Then
      strAnterior := ARR_FR3_TITULO_PISCOFINS[AintColuna] + ARR_FR3_NOME_PISCOFINS[AintImposto]
    Else
      strAnterior := '';

    Result := '[IIF ( ' + STR_FR3_SOMREF + ' , ''' + ARR_FR3_TITULO_PISCOFINS[AintColuna] +
              ARR_FR3_IMPOSTO[AintImposto] + ''' , ''' + strAnterior + ''' )]';
  End;

  function fValor(AintImposto, AintColuna: Integer): String;
  Var
    strBase,
    strValor,
    strExpressao,
    strAnterior: String;
  Begin
    strBase  := fCampoPedidoFr3(ARR_FR3_BASE_PED[AintImposto]);
    strValor := fCampoPedidoFr3(ARR_FR3_VALOR_PED[AintImposto]);

    Case AintColuna Of
      0: strExpressao := strBase;
      // divisor nunca zero: com a base zerada o valor tambem e zero
      1: strExpressao := strValor + '  * 100 / ( ' + strBase + '  + IIF ( ' + strBase + '  = 0 , 1 , 0 ) )';
    Else
      strExpressao := strValor;
    End;

    If AintImposto < 2 Then
      strAnterior := fCampoPedidoFr3(ARR_FR3_PISCOFINS[AintImposto, AintColuna])
    Else
      strAnterior := '0';

    Result := '[IIF ( ' + STR_FR3_SOMREF + ' , ' + strExpressao + '  , ' + strAnterior + ' )]';
  End;

  function fPosiciona(const AstrLinha: String; AfltTop: Double; const AstrTexto: String): String;
  Begin
    Result := fTrocaAtributoFr3(AstrLinha, 'Top', fTextoNumeroFr3(AfltTop));
    Result := fTrocaAtributoFr3(Result, 'Height', fTextoNumeroFr3(FLT_FR3_ALT_LIN));
    Result := fTrocaAtributoFr3(Result, 'Text', AstrTexto);
    Result := fDesligaCampoFr3(Result);
  End;

Begin
  Result := False;

  For intLinha := 0 To 1 Do
    For intColuna := 0 To 2 Do
    Begin
      arrValor[intLinha, intColuna]  := -1;
      arrRotulo[intLinha, intColuna] := -1;
    End;

  // bloco PIS/COFINS do rodape: os seis valores e o titulo acima de cada um
  For intLinha := 0 To 1 Do
    For intColuna := 0 To 2 Do
    Begin
      arrValor[intLinha, intColuna] := fLinhaCampoPedidoFr3(lstLinhas, ArecBanda, ARR_FR3_PISCOFINS[intLinha, intColuna]);
      If arrValor[intLinha, intColuna] < 0 Then
        Exit;

      arrRotulo[intLinha, intColuna] := fLinhaRotuloFr3(lstLinhas, ArecBanda, arrValor[intLinha, intColuna]);
      If arrRotulo[intLinha, intColuna] < 0 Then
        Exit;
    End;

  fltTopo  := MaxDouble;
  fltFundo := 0;
  For intLinha := 0 To 1 Do
    For intColuna := 0 To 2 Do
    Begin
      fltTopo  := Min(fltTopo, fNumeroFr3(fAtributoFr3(lstLinhas[arrRotulo[intLinha, intColuna]], 'Top')));
      fltFundo := Max(fltFundo, fNumeroFr3(fAtributoFr3(lstLinhas[arrValor[intLinha, intColuna]], 'Top')) +
                                fNumeroFr3(fAtributoFr3(lstLinhas[arrValor[intLinha, intColuna]], 'Height')));
    End;

  // CBS e IBS no lugar de PIS e COFINS (titulo + valor por imposto)
  For intLinha := 0 To 1 Do
    For intColuna := 0 To 2 Do
    Begin
      lstLinhas[arrRotulo[intLinha, intColuna]] := fPosiciona(lstLinhas[arrRotulo[intLinha, intColuna]],
        fltTopo + 2 * intLinha * FLT_FR3_ALT_LIN, fTitulo(intLinha, intColuna));
      lstLinhas[arrValor[intLinha, intColuna]] := fPosiciona(lstLinhas[arrValor[intLinha, intColuna]],
        fltTopo + (2 * intLinha + 1) * FLT_FR3_ALT_LIN, fValor(intLinha, intColuna));
    End;

  // IS: terceira linha copiando o estilo da linha do IBS
  For intColuna := 0 To 2 Do
  Begin
    strLinha := fTrocaAtributoFr3(lstLinhas[arrRotulo[1, intColuna]], 'Name', 'memo' + IntToStr(AintProxMemo));
    Inc(AintProxMemo);
    lstBloco.Add(fPosiciona(strLinha, fltTopo + 4 * FLT_FR3_ALT_LIN, fTitulo(2, intColuna)));

    strLinha := fTrocaAtributoFr3(lstLinhas[arrValor[1, intColuna]], 'Name', 'memo' + IntToStr(AintProxMemo));
    Inc(AintProxMemo);
    lstBloco.Add(fPosiciona(strLinha, fltTopo + 5 * FLT_FR3_ALT_LIN, fValor(2, intColuna)));
  End;

  // o que estava abaixo do bloco desce o quanto ele cresceu
  fltDelta := fltTopo + 6 * FLT_FR3_ALT_LIN - fltFundo;
  If fltDelta > 0 Then
  Begin
    For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    Begin
      If fNoBloco(intIndice) Or (Not fEhObjetoFr3(lstLinhas[intIndice])) Or
         (fAtributoFr3(lstLinhas[intIndice], 'Align') = 'baClient') Then
        Continue;

      fltObjeto := fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Top'));
      If fltObjeto >= fltFundo - 0.5 Then
        lstLinhas[intIndice] := fTrocaAtributoFr3(lstLinhas[intIndice], 'Top', fTextoNumeroFr3(fltObjeto + fltDelta));
    End;

    // o bloco da direita (ICMS, frete, totais) estica na proporcao, terminando junto com o CBS/IBS/IS
    fltDireita := 0;
    For intLinha := 0 To 1 Do
      For intColuna := 0 To 2 Do
        fltDireita := Max(fltDireita, fNumeroFr3(fAtributoFr3(lstLinhas[arrValor[intLinha, intColuna]], 'Left')) +
                                      fNumeroFr3(fAtributoFr3(lstLinhas[arrValor[intLinha, intColuna]], 'Width')));

    fltFator := (6 * FLT_FR3_ALT_LIN) / (fltFundo - fltTopo);

    For intIndice := ArecBanda.intIni + 1 To ArecBanda.intFim - 1 Do
    Begin
      If fNoBloco(intIndice) Or (Not fEhObjetoFr3(lstLinhas[intIndice])) Or
         (fAtributoFr3(lstLinhas[intIndice], 'Align') = 'baClient') Then
        Continue;

      fltObjeto := fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Top'));
      fltAltura := fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Height'));

      If (fNumeroFr3(fAtributoFr3(lstLinhas[intIndice], 'Left')) >= fltDireita - 1) And
         (fltObjeto >= fltTopo - 0.5) And (fltObjeto + fltAltura <= fltFundo + 0.5) Then
      Begin
        lstLinhas[intIndice] := fTrocaAtributoFr3(lstLinhas[intIndice], 'Top',
          fTextoNumeroFr3(fltTopo + (fltObjeto - fltTopo) * fltFator));
        lstLinhas[intIndice] := fTrocaAtributoFr3(lstLinhas[intIndice], 'Height', fTextoNumeroFr3(fltAltura * fltFator));
      End;
    End;

    pCresceBandaFr3(lstLinhas, ArecBanda, fltDelta);
  End;

  Result := True;
End;

procedure pRodapeFr3(lstLinhas: TStringList; const ArecBanda: TBandaFr3; AintLinTotal: Integer;
  Var AintProxMemo: Integer; lstBloco: TStringList);
Var
  strTexto: String;
Begin
  // total do pedido passa a somar CBS + IBS + IS
  strTexto := StringReplace(fAtributoFr3(lstLinhas[AintLinTotal], 'Text'), STR_FR3_TOTGER_CAMPO,
    '[' + STR_FR3_TOTGER + ']', [rfReplaceAll]);
  strTexto := StringReplace(strTexto, STR_FR3_TOTGER,
    '( ' + STR_FR3_TOTGER + '  + IIF ( ' + STR_FR3_SOMREF + ' , ' + fCampoPedidoFr3('VALCBS') + '  + ' +
    fCampoPedidoFr3('VALIBS') + '  + ' + fCampoPedidoFr3('VAL_IS') + '  , 0 ) )', [rfReplaceAll]);
  lstLinhas[AintLinTotal] := fDesligaCampoFr3(fTrocaAtributoFr3(lstLinhas[AintLinTotal], 'Text', strTexto));

  // rodape com o bloco PIS/COFINS (paisagem): vira CBS / IBS / IS no lugar; sem ele so o total muda
  fTrocaPisCofinsFr3(lstLinhas, ArecBanda, AintProxMemo, lstBloco);
End;

procedure pInsereBlocoFr3(lstLinhas: TStringList; AintPosicao: Integer; lstBloco: TStringList);
Var
  intIndice: Integer;
Begin
  For intIndice := lstBloco.Count - 1 DownTo 0 Do
    lstLinhas.Insert(AintPosicao, lstBloco[intIndice]);
End;

function fLayoutComReformaPedidoCompra(dtsLayout: TDataSet): Boolean;
Begin
  // LAY_REFTRI = 'S': layout salvo no editor depois da reforma, vale o que foi salvo
  // (sem a coluna, base ainda sem o script do requisito: segue injetando so na memoria)
  // Verificar Nota 2 - Req. 462714
  Result := Assigned(dtsLayout.FindField('LAY_REFTRI')) And
            (dtsLayout.FieldByName('LAY_REFTRI').AsString = 'S');
End;

function fInjetaReformaPedidoCompra(const AarrFr3: TBytes): TBytes;
Var
  strFr3: String;
  lstLinhas,
  lstItem,
  lstCabecalho,
  lstRodape: TStringList;
  arrBandas: TArray<TBandaFr3>;
  recBanda,
  recMaster,
  recRodape: TBandaFr3;
  intIndice,
  intBanda,
  intVez,
  intMaior,
  intProxMemo,
  intLinTotal,
  intQtdMaster: Integer;
  arrPosicao: Array[0..2] Of Integer;
  arrBloco: Array[0..2] Of TStringList;
Begin
  Result := AarrFr3;
  strFr3 := fBytesParaTextoFr3(AarrFr3);

  // layout que ja usa CBS do item (colocado a mao): nao duplica
  If Pos(fCampoItemFr3('DVLCBS'), strFr3) > 0 Then
    Exit;

  lstLinhas    := TStringList.Create;
  lstItem      := TStringList.Create;
  lstCabecalho := TStringList.Create;
  lstRodape    := TStringList.Create;
  Try
    If Pos(#13#10, strFr3) > 0 Then
      lstLinhas.LineBreak := #13#10
    Else
      lstLinhas.LineBreak := #10;

    lstLinhas.Text := strFr3;

    // banda dos itens: unica MasterData do frxDBImpEti
    intQtdMaster := 0;
    arrBandas    := fBandasFr3(lstLinhas, 'TfrxMasterData');
    For recBanda In arrBandas Do
      If fAtributoFr3(lstLinhas[recBanda.intIni], 'DataSetName') = 'frxDBImpEti' Then
      Begin
        recMaster := recBanda;
        Inc(intQtdMaster);
      End;

    If intQtdMaster <> 1 Then
      Exit;

    intProxMemo := fProximoMemoFr3(lstLinhas);

    arrPosicao[0] := recMaster.intFim;
    arrBloco[0]   := lstItem;
    pLinhaColunasFr3(lstLinhas, recMaster, False, intProxMemo, lstItem);

    arrPosicao[1] := -1;
    arrBloco[1]   := lstCabecalho;
    arrBandas     := fBandasFr3(lstLinhas, 'TfrxHeader');
    If Length(arrBandas) = 1 Then
    Begin
      arrPosicao[1] := arrBandas[0].intFim;
      pLinhaColunasFr3(lstLinhas, arrBandas[0], True, intProxMemo, lstCabecalho);
    End;

    // rodape: memo do total do pedido no Footer, Summary, PageFooter, GroupFooter ou Child
    arrPosicao[2] := -1;
    arrBloco[2]   := lstRodape;
    intLinTotal   := -1;
    For intBanda := Low(ARR_FR3_BANDA_TOTAL) To High(ARR_FR3_BANDA_TOTAL) Do
    Begin
      arrBandas := fBandasFr3(lstLinhas, ARR_FR3_BANDA_TOTAL[intBanda]);
      For recBanda In arrBandas Do
        For intIndice := recBanda.intIni + 1 To recBanda.intFim - 1 Do
          If (intLinTotal < 0) And ((Pos(STR_FR3_TOTGER, fAtributoFr3(lstLinhas[intIndice], 'Text')) > 0) Or
             (Pos(STR_FR3_TOTGER_CAMPO, fAtributoFr3(lstLinhas[intIndice], 'Text')) > 0)) Then
          Begin
            intLinTotal := intIndice;
            recRodape   := recBanda;
          End;

      If intLinTotal >= 0 Then
        Break;
    End;

    // mostra o total onde a injecao nao alcanca: nao injeta nada (itens com CBS / IBS / IS e total sem eles)
    If (intLinTotal < 0) And (Pos('TOTGER', strFr3) > 0) Then
      Exit;

    If intLinTotal >= 0 Then
    Begin
      arrPosicao[2] := recRodape.intFim;
      pRodapeFr3(lstLinhas, recRodape, intLinTotal, intProxMemo, lstRodape);
    End;

    // insere de baixo para cima para nao deslocar as posicoes ainda nao usadas
    For intVez := 0 To 2 Do
    Begin
      intMaior := -1;
      For intIndice := 0 To 2 Do
        If (arrPosicao[intIndice] >= 0) And ((intMaior < 0) Or (arrPosicao[intIndice] > arrPosicao[intMaior])) Then
          intMaior := intIndice;

      If intMaior < 0 Then
        Break;

      pInsereBlocoFr3(lstLinhas, arrPosicao[intMaior], arrBloco[intMaior]);
      arrPosicao[intMaior] := -1;
    End;

    Result := fTextoParaBytesFr3(lstLinhas.Text);
  Finally
    FreeAndNil(lstLinhas);
    FreeAndNil(lstItem);
    FreeAndNil(lstCabecalho);
    FreeAndNil(lstRodape);
  End;
End;

end.


