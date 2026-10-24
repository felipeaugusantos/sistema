unit untTransfCod;

interface

Uses Forms, Classes, Uni,
     Vcl.Themes,
     Vcl.Styles,
     Vcl.SysStyles, // to gain access to TSysPopupStyleHook
     untCfgRel,
     SysUtils, untDllTransfCod, dxCore, untLogForm;

function fSVN_RevisionTransfCod: String; stdcall;
procedure pTransCodigo(prmDllTra: Pointer); stdcall;
procedure pTransCodigoCarreg(prmDllTra: Pointer); stdcall;

procedure pChamaForms(prmDllOpe: Pointer);
Procedure pSetaModulos(recModModulos: TTransfModulos);
Procedure pSetaVariaveis(varRecVariaveis: TTransfVariaveis);
Procedure pCriaModulos(varRecVariaveis: TTransfVariaveis);
Procedure pLiberaModulos;

//procedure dxInitializeTra; StdCall;
//procedure dxFinalizeTra; StdCall;

var
  ParamTransfCodPortador: TparamTransfCod;
  strCfgsPortadorDll: string;

implementation

uses untModulo, untFuncoesSimples, untTransfCodVendedor,
     untTransfCodCta, untTransfCodFornecedor,untModuloSPR,
     untTransfCodCliente, untTransfCodCidade, untTransfCodUnidade,
     untTransfCodAtividade,untTransfCodDiversos, untModuloReplicacao,
     untTransfCodPortador, untTransfCodTransportadora, untTransfCodCorIndustrial,
     untConstantes, untGravando, untTransfCodPlacaVeiculo, untTransfCodAcessorio,
     untTransfCodMotorista, untTransfCodEvento, untTypesSistema;

function fSVN_RevisionTransfCod: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure pTransCodigo(prmDllTra: Pointer);
  Var
    objDllTransf : TparamTransfCod;
Begin
  Try
    objDllTransf := prmDllTra;

    With objDllTransf Do
    Begin
      pSetaModulos(ModRecMod);

      pCriaModulos(VarRecVar);
      pVerificaProCod;

      pIniciaLogLeak(intDebugH, 'libTransfCodigo');
      ProcRetCfgRelacionadaArquivo := FuncExternaprcRetCfgRelacionadaArquivo;
      blnTransferindoCodigo := True;

      TLogForm.strCodEmp := VS_strCodEmp;
      TLogForm.strCodOpe := strLoginUsuarioLogado;
      TLogForm.dtaDtaLog := VS_Date;
      TLogForm.fncCriaQuery := fCriaQuery;
      TLogForm.fncTime := fTime;
      TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

      pChamaForms(objDllTransf);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pTransCodigo]');
    End;
  End;

  blnTransferindoCodigo := False;

End;

procedure pTransCodigoCarreg(prmDllTra: Pointer);
  Var
    objDllTransf : TparamTransfCod;
Begin
  objDllTransf := prmDllTra;

  With objDllTransf Do
  Begin
    pSetaVariaveis(VarRecVar);
    blnTransferindoCodigo := True;

    ProcRetCfgRelacionadaArquivo := FuncExternaprcRetCfgRelacionadaArquivo;
    VS_SpoolImpressaoCitel := False;
    If fArqIni(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S') <> 'N' Then
      Try
        VS_SpoolImpressaoCitel := fCfgSis('SPOIMP', varBoolean);
      Except
        //do nothing
      End;

    TCfgRel.VS_SpoolImpressaoCitel := VS_SpoolImpressaoCitel;

    TDefaultPoolingOptions.Pooling := fCfgSis('POOUTI', VarBoolean);
    TDefaultPoolingOptions.Validate := fCfgSis('POOVAL', VarBoolean);
    TDefaultPoolingOptions.MaxPoolSize := fCfgSis('POOMAX', varInteger);
    TDefaultPoolingOptions.MinPoolSize := fCfgSis('POOMIN', varInteger);
    TDefaultPoolingOptions.ConnectionLifetime := fCfgSis('POOTIM', varInteger);

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

    pChamaForms(objDllTransf);
  End;

  blnTransferindoCodigo := False;
End;

procedure pChamaForms(prmDllOpe: Pointer);
  Var
    objDllTransf : TparamTransfCod;
Begin
  objDllTransf := TparamTransfCod(prmDllOpe);

  With objDllTransf Do
  Begin
     Case frmTipTra of
       TransfCodVendedor      : pCriarForm(TfrmTransfCodVendedor, frmTransfCodVendedor);
       TransfCodFornecedor    : pCriarForm(TfrmTransfCodFornecedor, frmTransfCodFornecedor);
       TransfCodCliente       : pCriarForm(TfrmTransfCodCliente, frmTransfCodCliente);
       TransfCodCidade        : pCriarForm(TfrmTransfCodCidade, frmTransfCodCidade);
       TransfCodCta           : pCriarForm(TfrmTransfCodCta, frmTransfCodCta);
       TransfCodUnidade       : pCriarForm(TfrmTransfCodUnidade, frmTransfCodUnidade);
       TransfCodAtividade     : pCriarForm(TfrmTransfCodAtividade, frmTransfCodAtividade);
       TransfCodDiverso       : pCriarForm(TfrmTransfCodDiversos, frmTransfCodDiversos);
       TransfCodPortador:
       begin
         ParamTransfCodPortador := objDllTransf;

         if Assigned(objDllTransf.arrCfgsPortadorIn) then
           strCfgsPortadorDll := string(objDllTransf.arrCfgsPortadorIn)
         else
           strCfgsPortadorDll := '';

         pCriarForm(TfrmTransfCodPortador, frmTransfCodPortador);
       end;
       TransfCodTransportadora: pCriarForm(TfrmTransfCodTransportadora, frmTransfCodTransportadora);
       TransfCodCorIndustrial : pCriarForm(TfrmTransfCodCorIndustrial, frmTransfCodCorIndustrial);
       TransfCodPlacaVeiculo  : pCriarForm(TfrmTransfCodPlacaVeiculo, frmTransfCodPlacaVeiculo);
       TransfCodAcessorio     : pCriarForm(TfrmTransfCodAcessorio, frmTransfCodAcessorio);
       TransfCodMotorista     : pCriarForm(TfrmTransfCodMotorista, frmTransfCodMotorista);
       TransfCodEvento        : pCriarForm(TfrmTransfCodEvento, frmTransfCodEvento);
      End;
   End;

 End;

Procedure pSetaModulos(recModModulos: TTransfModulos);
Begin
  With recModModulos Do
  Begin
    frmModulo := TfrmModulo.CreateInstance(Nil, False);
    frmModulo.Database.AssignConnect(Banco);
    frmModulo.pCriaEAtribuiMadException;
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

Procedure pCriaModulos(varRecVariaveis: TTransfVariaveis);
Begin
  pSetaVariaveis(varRecVariaveis);

  pCriarModulo(TfrmModuloSPR,        TDataModule(frmModuloSPR));
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

  pSetaConnection(frmModuloSPR);

  {$WARNINGS OFF}
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, untFuncoesSimples.strLoginUsuarioLogado, untFuncoesSimples.VS_strCodEmp, DebugHook, TCfgSis.Create(), untFuncoesSimples.VS_objTraceViewer,
                    untFuncoesSimples.VS_Date, untFuncoesSimples.VS_ComputerNetName, untFuncoesSimples.VS_UserFromWindows, untFuncoesSimples.VS_IPAddressAsString,
                    untFuncoesSimples.VS_MacAddress);
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

Procedure pSetaVariaveis(varRecVariaveis: TTransfVariaveis);
Begin
  With varRecVariaveis Do
  Begin
    pSetaEmpresaLogada(String(strEmpCod));
    VS_Date                   := dtaVSDate;
    strLoginUsuarioLogado     := String(strLogUsu);
    strDescriUsuarioLogado    := String(strDesUsu);
    strEmpAcessoUsuarioLogado := String(strEmpUsu);
    strEmpEstUsuarioLogado    := String(strEmpEst);
    blnUsuarioLogadoUtilizaModoClassico := blnModoClassico;
    utcRegistros              := utcRegist;
    VS_objTraceViewer         := objTraceViewer;
  End
End;

Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

procedure dxInitializeTra;
Begin
  dxInitialize;
End;

procedure dxFinalizeTra;
Begin
  frmModulo.pLiberaMadException;
  pLiberaModulos;
  dxFinalize;
End;

Initialization
  dxInitializeTra;

Finalization
  dxFinalizeTra;

end.
