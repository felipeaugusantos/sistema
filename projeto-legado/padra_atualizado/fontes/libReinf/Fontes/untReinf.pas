unit untReinf;

interface

Uses Forms, Controls,
     Vcl.Themes,
     Vcl.Styles,
     Vcl.SysStyles, untDLLReinf,
     Classes, Uni, SysUtils,  dxCore, untLogForm, Winapi.Windows;

  function fSVN_RevisionReinf: String; stdcall;
  procedure pReinf(prmDllReinf: Pointer); stdcall;

  procedure pChamaForms(prmDllReinf: Pointer);
  Procedure pSetaModulos(recModModulos: TReinfModulos);
  Procedure pSetaVariaveis(varRecVariaveis: TReinfVariaveis);
  Procedure pCriaModulos(varRecVariaveis: TReinfVariaveis);
  Procedure pLiberaModulos;

implementation

uses untModulo, untFuncoesSimples, untModuloSPR, untModuloReplicacao,
  untConstantes, untGravando, untFuncoesRel, untLiberacaoFactory,
  untIntegracaoReinf;

function fSVN_RevisionReinf: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

procedure pReinf(prmDllReinf: Pointer);
  Var
    objDllReinf : TparamReinf;
Begin
  Try
    objDllReinf := prmDllReinf;

    With objDllReinf Do
    Begin
      pSetaModulos(ModRecMod);

      pCriaModulos(VarRecVar);
      pVerificaProCod;

      pAtuVarGlobaisSimples;

      prcExecutaRelatorio := objDllReinf.varParam.prcExecutaRelatorio;

      pIniciaLogLeak(intDebugH, 'libReinf');

      TLogForm.strCodEmp := VS_strCodEmp;
      TLogForm.strCodOpe := strLoginUsuarioLogado;
      TLogForm.dtaDtaLog := VS_Date;
      TLogForm.fncCriaQuery := fCriaQuery;
      TLogForm.fncTime := fTime;
      TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

      pChamaForms(objDllReinf);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pGNRE]');
    End;
  End;

End;

Procedure pSetaModulos(recModModulos: TReinfModulos);
Begin
  With recModModulos Do
  Begin
    frmModulo := TfrmModulo.CreateInstance(Nil, False);
    frmModulo.Database.AssignConnect(Banco);
  End;
End;

Procedure pSetaVariaveis(varRecVariaveis: TReinfVariaveis);
Begin
   VS_Date                   := varRecVariaveis.dtaVSDate;
   strLoginUsuarioLogado     := String(varRecVariaveis.strLogUsu);
   blnUsuarioLogadoUtilizaModoClassico := varRecVariaveis.blnModoClassico;
   strDescriUsuarioLogado    := String(varRecVariaveis.strDesUsu);
   strEmpAcessoUsuarioLogado := String(varRecVariaveis.strEmpUsu);
   strEmpEstUsuarioLogado    := String(varRecVariaveis.strEmpEst);
   pSetaEmpresaLogada(String(varRecVariaveis.strEmpCod));
   utcRegistros              := varRecVariaveis.utcRegist;
   VS_objTraceViewer         := varRecVariaveis.objTraceViewer;
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

Procedure pCriaModulos(varRecVariaveis: TReinfVariaveis);
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

Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

procedure pChamaForms(prmDllReinf: Pointer);
Var
  objDllReinf : TparamReinf;

  frmIntegracaoReinf: TfrmIntegracaoReinf;
Begin
  objDllReinf := prmDllReinf;
  pSetLiberacao(objDllReinf.objLibera);

  case objDllReinf.frmTipRei of
    IntegracaoReinf: begin
                        pCriarFormularios(TfrmIntegracaoReinf, frmIntegracaoReinf);
                        Try
                          frmIntegracaoReinf.ShowModal;
                        Finally
                          pFreeAndNil(frmIntegracaoReinf);
                        end;
                     end;
  end;

End;

procedure dxFinalizeOrp;
Begin
  pLiberaModulos;
  dxFinalize;
End;

Initialization

  dxInitialize;

Finalization

  dxFinalizeOrp;


end.
