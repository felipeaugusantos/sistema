unit untGNRE;

interface

Uses Forms, Classes, Uni,
     Vcl.Themes,
     Vcl.Styles,
     Vcl.SysStyles, // to gain access to TSysPopupStyleHook
     SysUtils, untDllGNRE, dxCore, untLogForm, untGNREPrincipal;

function fSVN_RevisionGNRE: String; stdcall;
procedure pGNRE(prmDllGnre: Pointer); stdcall;
procedure pGNRECarreg(prmDllGnre: Pointer); stdcall;

procedure pChamaForms(prmDllOpe: Pointer);
Procedure pSetaModulos(recModModulos: TGnreModulos);
Procedure pSetaVariaveis(varRecVariaveis: TGnreVariaveis);
Procedure pCriaModulos(varRecVariaveis: TGnreVariaveis);
Procedure pLiberaModulos;

implementation

uses untModulo, untFuncoesSimples, untModuloSPR, untModuloReplicacao, untConstantes, untGravando,
     untFuncoesRel;

function fSVN_RevisionGNRE: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure pGNRE(prmDllGnre: Pointer);
  Var
    objDllGnre : TparamGnre;
Begin
  Try
    objDllGnre := prmDllGnre;

    With objDllGnre Do
    Begin
      pSetaModulos(ModRecMod);

      pCriaModulos(VarRecVar);
      pVerificaProCod;

      pAtuVarGlobaisSimples;

      prcExecutaRelatorio := objDllGnre.varParam.prcExecutaRelatorio;

      pIniciaLogLeak(intDebugH, 'libGNRE');

      TLogForm.strCodEmp := VS_strCodEmp;
      TLogForm.strCodOpe := strLoginUsuarioLogado;
      TLogForm.dtaDtaLog := VS_Date;
      TLogForm.fncCriaQuery := fCriaQuery;
      TLogForm.fncTime := fTime;
      TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM');

      pChamaForms(objDllGnre);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGNRE]');
    End;
  End;

End;

procedure pGNRECarreg(prmDllGnre: Pointer);
  Var
    objDllGnre : TparamGnre;
Begin
  objDllGnre := prmDllGnre;

  With objDllGnre Do
  Begin
    pSetaVariaveis(VarRecVar);

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM');

    pChamaForms(objDllGnre);
  End;

End;

procedure pChamaForms(prmDllOpe: Pointer);
Var
  objDllGnre : TparamGnre;
Begin
  objDllGnre := prmDllOpe;

  Application.Handle := objDllGnre.AppHandle;

  If Assigned(frmGNREPrincipal) Then
    FreeAndNil(frmGNREPrincipal);

  Try

    try
      frmGNREPrincipal := TfrmGNREPrincipal.Create(Application);
      frmGNREPrincipal.ShowModal;
    finally
      FreeAndNil(frmGNREPrincipal);
    end;

  Except
    On E: Exception do
      pErro(E.Message);
  End;
End;

Procedure pSetaModulos(recModModulos: TGnreModulos);
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

Procedure pCriaModulos(varRecVariaveis: TGnreVariaveis);
Begin
  pSetaVariaveis(varRecVariaveis);

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

Procedure pSetaVariaveis(varRecVariaveis: TGnreVariaveis);
Begin
  With varRecVariaveis Do
  Begin
    pSetaEmpresaLogada(String(strEmpCod));
    VS_Date                   := dtaVSDate;
    strLoginUsuarioLogado     := String(strLogUsu);
    strDescriUsuarioLogado    := String(strDesUsu);
    strEmpAcessoUsuarioLogado := String(strEmpUsu);
    strEmpEstUsuarioLogado    := String(strEmpEst);
    VS_strClaVen              := String(strClaVen);
    VS_strClaDev              := String(strClaDev);
    blnUsuarioLogadoUtilizaModoClassico := blnModoClassico;
    utcRegistros              := utcRegist;
  End
End;

Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

procedure dxInitializeGnre;
Begin
  dxInitialize;
End;

procedure dxFinalizeGnre;
Begin
  frmModulo.pLiberaMadException;
  pLiberaModulos;
  dxFinalize;
End;

Initialization
  dxInitializeGnre;

Finalization
  dxFinalizeGnre;

end.
