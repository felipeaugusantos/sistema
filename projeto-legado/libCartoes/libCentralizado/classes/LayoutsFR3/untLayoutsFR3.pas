unit untLayoutsFR3;

interface

Uses
  Forms,
  Classes,
  Uni,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles, // to gain access to TSysPopupStyleHook
  untCfgRel,
  SysUtils,
  untDllLayoutsFR3,
  dxCore,
  untLogForm,
  untTelasAbertas,
  untRelAjudaMod,
  untQckOrdProIndustrial,
  OrdemProducaoIndustrial.Tipos;

function fVerificaHelpExiste(strNomFor, strNomRel: String):Boolean; stdcall;
procedure pAjudaGmail; stdcall;
procedure pAjudaOutlook; stdcall;
procedure pAjudaRegistroCSGetnet; stdcall;
procedure pAbreAjuda(strNomFor, strNomRel: String); stdcall;
procedure pExibirModeloLayoutCfgSis(strCodCfg: String; strValCfg: String = ''); stdcall;
procedure pCarregarQckOrdProIndustrialLayouts(AQckOrdProIndustrial: TfrmQckOrdProIndustrial); stdcall;
procedure pLayoutsFR3Init(AParams: Pointer); stdcall;

implementation

uses
  untModulo, untFuncoesSimples, untModuloSPR, untModuloReplicacao,
  untConstantes, untGravando, untTypesSistema, untModelosLayout,
  untQckOrdProIndustrialLayouts;

Procedure pSetaVariaveis(varRecVariaveis: TLayoutsFR3Variaveis);
Begin
  With varRecVariaveis Do
  Begin
    pSetaEmpresaLogada(String(strEmpCod));
    VS_Date := dtaVSDate;
    strLoginUsuarioLogado := String(strLogUsu);
    strDescriUsuarioLogado := String(strDesUsu);
    strEmpAcessoUsuarioLogado := String(strEmpUsu);
    strEmpEstUsuarioLogado := String(strEmpEst);
    utcRegistros := utcRegist;
    VS_objTraceViewer := objTraceViewer;
    blnUsuarioLogadoUtilizaModoClassico := blnModoClassico;
    untTelasAbertas.objTelasAbertas := objTelasAbertas;
  End
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

Procedure pCriaModulos(AParams: TParamLayoutsFR3);
Begin
  if Assigned(frmModulo) then
    Exit;

  frmModulo := TfrmModulo.CreateInstance(Nil, False);
  frmModulo.Database.AssignConnect(AParams.modRecMod.Banco);
  frmModulo.pCriaEAtribuiMadException;

  pCriarModulo(TfrmModuloSPR,        TDataModule(frmModuloSPR));
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

  pSetaConnection(frmModuloSPR);

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

procedure pLayoutsFR3Init(AParams: Pointer);
  Var
    objParams : TParamLayoutsFR3;
Begin
  objParams := AParams;
  pSetaVariaveis(objParams.varRecVar);
  pCriaModulos(objParams);

  VS_SpoolImpressaoCitel := False;
  Try
    If fArqIni(0, 'GERAL', 'SPOOL_IMPRESSAO_CITEL', 'S') <> 'N' Then
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
  TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM');

  pIniciaLogLeak(objParams.intDebugH, 'libLayoutsFR3');

  pVerificaProCod;
End;

Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

procedure pExibirModeloLayoutCfgSis(strCodCfg: String; strValCfg: String = '');
Var
  frmModelosLayout: TfrmModelosLayout;
Begin
  try
    pCriarFormularios(TfrmModelosLayout, frmModelosLayout);
    try
      frmModelosLayout.pExibeLayout(strCodCfg, strValCfg);
    finally
      pFreeAndNil(frmModelosLayout);
    End;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[pExibirModeloLayoutCfgSis]');
  end;
End;

procedure pCarregarQckOrdProIndustrialLayouts(AQckOrdProIndustrial: TfrmQckOrdProIndustrial);
Begin
  try
    pCriarFormularios(TfrmQckOrdProIndustrialLayouts, frmQckOrdProIndustrialLayouts);
    try
      frmQckOrdProIndustrialLayouts.pCarregarLayouts(AQckOrdProIndustrial);
    finally
      pFreeAndNil(frmQckOrdProIndustrialLayouts);
    end;
  except
    on E: Exception do
      pMensagensErro(E.Message, '[pCarregarQckOrdProIndustrialLayouts]');
  end;
end;

procedure pAjudaGmail;
begin
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  try
    frmRelAjudaMod.pAjudaGmail;
  finally
    pFreeAndNil(frmRelAjudaMod);
  end;
end;

procedure pAjudaOutlook;
begin
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  try
    frmRelAjudaMod.pAjudaOutlook;
  finally
    pFreeAndNil(frmRelAjudaMod);
  end;
end;

procedure pAjudaRegistroCSGetnet; stdcall;
begin
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  try
    frmRelAjudaMod.pAjudaRegistroCSGetnet;
  finally
    pFreeAndNil(frmRelAjudaMod);
  end;
end;

procedure pAbreAjuda(strNomFor, strNomRel: String);
begin
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  try
    frmRelAjudaMod.pAbreAjuda(strNomFor, strNomRel);
  finally
    pFreeAndNil(frmRelAjudaMod);
  end;
end;

function fVerificaHelpExiste(strNomFor, strNomRel: String):Boolean;
begin
  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  try
    Result := frmRelAjudaMod.fVerificaHelpExiste(strNomFor, strNomRel);
  finally
    pFreeAndNil(frmRelAjudaMod);
  end;
end;

Initialization
  dxInitialize;

Finalization
  frmModulo.pLiberaMadException;
  pLiberaModulos;
  dxFinalize;

end.
