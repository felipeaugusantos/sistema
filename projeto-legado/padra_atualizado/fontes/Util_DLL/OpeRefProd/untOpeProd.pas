unit untOpeProd;

interface

Uses Forms, Controls, untDllOpeProd,
     Vcl.Themes,
     Vcl.Styles,
     Vcl.SysStyles, // to gain access to TSysPopupStyleHook
     Classes, Uni, SysUtils,  dxCore, untAltPrecoMedio, untLogForm, Winapi.Windows;

procedure pOpeProdutos(prmDllOpe: Pointer); stdcall;
procedure pOpeProdutosCarreg(prmDllOpe: Pointer); stdcall;
function fSVN_RevisionOpeRefProd: String; stdcall;
function fCallConfirmaEfetivacaoPreco(prmDllOpe: Pointer; dtaDtaPre: TDate): Boolean; stdcall;

procedure pChamaForms(prmDllOpe: Pointer);
Procedure pSetaModulos(recModModulos: TOpeProdModulos);
Procedure pSetaVariaveis(varRecVariaveis: TOpeProdVariaveis);
Procedure pCriaModulos(varRecVariaveis: TOpeProdVariaveis);
Procedure pLiberaModulos;
Procedure pManutInventario;
Procedure pManutInventarioBroker;
Procedure pAltPrecoGlobalCatalogo;
Function fRetOpcaoAltGlobal: Integer;
//Procedure pBalancoEstGravar(objDllOpeProd : TparamOpeProd);

//procedure dxInitializeOrp; StdCall;
//procedure dxFinalizeOrp; StdCall;

implementation

uses untModulo, untCadSalBalanco, untAltPrecoProduto, untRelacSemelhanca,
     untRelacSimilaridade, untAltEfetivacaoPrecos, untAltPrecoIndividual,
     untSelListPreco, untGerInventario, untManutancaoDescontoEmbalagem,
     untAltPrecoGlobalCatalogo, untDigCodBarLocFis, untManECommerce,
     untAltPrecoGlobal, untAltPrecoFornecedor, untAltPrecoFornecedorTabPrd, untCadManutInvSel, untCadManutInventario, untProdutosAgrupados,
     untGeracaoCodBarras, untImportCatalogoPreco, untAltNumLote,
     untTransfLinGru, untTransfCodProduto, untRelBalancoEstoqueDiferenca,
     untBalancoEstoqueDigManual, untBalancoEstoqueImportar, untBalancoEstoqueZera,
     untCadBocaCaixaAlt, untExpFunBosh, untAltPrecoGlobalTPO, untImpEtiqNotaEntrada,
     untBalancoEstoqueDigMotorola,untOpcAltGlobFornecedor,  untModuloSPR, untAltEfetivacaoPrecosTab,
     untAlteraEstMinMax, untFuncoesSimples, untFuncoesRel, untFuncoesRel2, untBalancoEstoqueDigColetivo,
     untManDesIte, untOpcAltGlobPre, untModuloReplicacao, untManutCustoProdutos, untAltGlobalPromocoes,
     untBalancoEstoqueDigCompex260, untImportComisVendTabPreco, untImportTabPrecosIteger,
     untImportMargemLucroTabPreco, untGeracaoFichaControleImportacao,
     untImportaProdFranq, untReplicacaoLotes, untImportCadProduto,
     untCadManutInventarioLote, untLiberacaoFactory, untCadLote, untBalancoIniciaArmazem, untManutencaoEmpresaCentralizadora,
     untFuncInsFactory, untAtualizacaoCotacaoDolarNosCatalogos, untConstantes, untGravando, untAltGlobalProdutosAcabados,
     untAlteracaoGeraldePrecosdeProdutos, untRelMapaDeContagem, untRelacionamentoClienteProdutoGarantia, untImportCadEstrutura,
     untAtivarTabelaPreco, untControleContagemBalancoEstoque, untMapaDeContagem, untImportCadNOP, untImportCadNCE,
     untAtualizacaoMargemParaFranquias, untMapaDeInventarioParaColetores, untAltGlobalServico, untConsultoriaFiscalSaneamento, untImportCadNCM,
     untImportaPROSER, untDivergenciasSeparacaoColetor;

function fSVN_RevisionOpeRefProd: String;
{$I rev.inc}
Begin
  Result := SVN_REVISION;
End;

Procedure pSetaModulos(recModModulos: TOpeProdModulos);
Begin
  With recModModulos Do
  Begin
    frmModulo := TfrmModulo.CreateInstance(Nil, False);
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

Procedure pCriaModulos(varRecVariaveis: TOpeProdVariaveis);
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

Procedure pSetaVariaveis(varRecVariaveis: TOpeProdVariaveis);
Begin
  With varRecVariaveis Do
  Begin
    VS_Date                   := dtaVSDate;
    strLoginUsuarioLogado     := String(strLogUsu);
    blnUsuarioLogadoUtilizaModoClassico := blnModoClassico;
    strDescriUsuarioLogado    := String(strDesUsu);
    strEmpAcessoUsuarioLogado := String(strEmpUsu);
    strEmpEstUsuarioLogado    := String(strEmpEst);
    pSetaEmpresaLogada(String(strEmpCod));
    utcRegistros              := utcRegist;
    VS_objTraceViewer         := objTraceViewer;
    VS_intConEst              := intConEst;
    VS_intConAcu              := intConAcu;
  End
End;

Procedure pLiberaModulos;
Begin
  FreeAndNil(frmModuloSPR);
  FreeAndNil(frmModuloReplicacao);
  FreeAndNil(frmModulo);
End;

Procedure pManutInventario;
Begin
  Try
    pCriarFormularios(TfrmCadManutInvSel, frmCadManutInvSel);

    If frmCadManutInvSel.ShowModal = mrok Then
    Begin

      Try
        pCriarFormularios(TfrmCadManutInventario, frmCadManutInventario);
        frmCadManutInventario.strNomTab := frmCadManutInvSel.strNomTab;
        frmCadManutInventario.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[mnuManutInventarioClick]');
        End;
      End;

      pFreeAndNil(frmCadManutInventario);

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuManutInventarioClick_1]');
    End;
  End;

  pFreeAndNil(frmCadManutInvSel);

End;

Procedure pManutInventarioBroker;
Begin
  Try
    pCriarFormularios(TfrmCadManutInvSel, frmCadManutInvSel);

    frmCadManutInvSel.pnlTipInv.Visible := False;
    frmCadManutInvSel.strPrefixoTab := 'L';

    If frmCadManutInvSel.ShowModal = mrok Then
    Begin

      Try
        pCriarFormularios(TfrmCadManutInventarioLote, frmCadManutInventarioLote);
        frmCadManutInventarioLote.strNomTab := frmCadManutInvSel.strNomTab;
        frmCadManutInventarioLote.strAnoTab := frmCadManutInvSel.strAnoTab;
        frmCadManutInventarioLote.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[pManutInventarioBroker;]');
        End;
      End;

      pFreeAndNil(frmCadManutInventarioLote);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pManutInventarioBroker;]');
    End;
  End;

  pFreeAndNil(frmCadManutInvSel);

End;


Procedure pAltPrecoGlobalCatalogo;
  Var
    blnAltPorFator: Boolean;
begin

  blnAltPorFator := (fMensagem('', 'Alteração por:', ['&Valor', '&Fator']) = 2);

  Try
    pCriarFormularios(TfrmAltPrecoGlobalCatalogo, frmAltPrecoGlobalCatalogo);
    frmAltPrecoGlobalCatalogo.blnAltPorFator := blnAltPorFator;
    frmAltPrecoGlobalCatalogo.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuAltPrecoGlobalCatalogoClick]');
    End;
  End;

  pFreeAndNil(frmAltPrecoGlobalCatalogo);

end;

Function fRetOpcaoAltGlobal: Integer;
begin

  Try

    pCriarFormularios(TfrmOpcAltGlobPre, frmOpcAltGlobPre);
    frmOpcAltGlobPre.ShowModal;
    Result := frmOpcAltGlobPre.intRetorno;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[frmOpcAltGlobPre]');
    End;
  End;

  pFreeAndNil(frmOpcAltGlobPre);

end;

Procedure pAltPrecoGlobal(oppTipOpe: TOpeProd);
  Var
    IntOpcaoAltera: Integer;
begin

  If oppTipOpe = EfetivacaoPrecosFornecedor Then
    IntOpcaoAltera := 1
  Else
    IntOpcaoAltera := fRetOpcaoAltGlobal;

  Try

    If IntOpcaoAltera <> 3 Then
    Begin
      pCriarFormularios(TfrmAltPrecoGlobal, frmAltPrecoGlobal);
      case IntOpcaoAltera of
        2: frmAltPrecoGlobal.enuCalculo := TTipoCalculo.tcFator;
        4: frmAltPrecoGlobal.enuCalculo := TTipoCalculo.tcSomar;
      end;
      frmAltPrecoGlobal.blnAltPorFator   := (IntOpcaoAltera In [2,4]);
      frmAltPrecoGlobal.blnAltFornecedor := (oppTipOpe = EfetivacaoPrecosFornecedor);
      frmAltPrecoGlobal.ShowModal;
    End
    Else
    Begin
      pCriarFormularios(TfrmAltPrecoGlobalTPO, frmAltPrecoGlobalTPO);
      frmAltPrecoGlobalTPO.blnAltPorFator := True;
      frmAltPrecoGlobalTPO.ShowModal
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[mnuAltPrecoGlobalClick]');
    End;
  End;

  If IntOpcaoAltera <> 3 Then
    pFreeAndNil(frmAltPrecoGlobal)
  Else
    pFreeAndNil(frmAltPrecoGlobalTPO);

end;

Function fRetOpcaoAltGlobalFornecedor: Integer;
begin

  Try

    pCriarFormularios(TfrmOpcAltGlobFornecedor, frmOpcAltGlobFornecedor);
    frmOpcAltGlobFornecedor.ShowModal;
    Result := frmOpcAltGlobFornecedor.intRetorno;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fRetOpcaoAltGlobalFornecedor]');
    End;
  End;

  pFreeAndNil(frmOpcAltGlobFornecedor);
end;

Procedure pAltPrecoGlobalFornecedor(strTabPre: String = '');
  Var
    IntOpcaoAltera: Integer;
begin

  IntOpcaoAltera := fRetOpcaoAltGlobalFornecedor;

  Try
    If fCfgSis('TABPRD') = 'S' Then
    Begin
      pCriarFormularios(TfrmAltPrecoFornecedorTabPrd, frmAltPrecoFornecedorTabPrd);
      frmAltPrecoFornecedorTabPrd.blnAltPorFator := (IntOpcaoAltera = 2);

      If Not fEmptyStr(strTabPre) Then
      Begin
        frmAltPrecoFornecedorTabPrd.strTabFix          := strTabPre;
        frmAltPrecoFornecedorTabPrd.edtTabPre.Text     := strTabPre;
        frmAltPrecoFornecedorTabPrd.fValidaCampos(frmAltPrecoFornecedorTabPrd.edtTabPre, True);

        frmAltPrecoFornecedorTabPrd.edtTabPre.ReadOnly := True;
        frmAltPrecoFornecedorTabPrd.edtTabPre.TabStop  := False;

      End;

      If fCfgSis('FORCAL', VarString) = 'P' Then
        frmAltPrecoFornecedorTabPrd.rdgTipAltFor.ItemIndex := 0
      Else
        frmAltPrecoFornecedorTabPrd.rdgTipAltFor.ItemIndex := 1;

      frmAltPrecoFornecedorTabPrd.ShowModal;
    End
    Else
    Begin
      pCriarFormularios(TfrmAltPrecoFornecedor, frmAltPrecoFornecedor);
      frmAltPrecoFornecedor.blnAltPorFator := (IntOpcaoAltera = 2);

      If Not fEmptyStr(strTabPre) Then
      Begin
        frmAltPrecoFornecedor.strTabFix          := strTabPre;
        frmAltPrecoFornecedor.edtTabPre.Text     := strTabPre;
        frmAltPrecoFornecedor.fValidaCampos(frmAltPrecoFornecedor.edtTabPre, True);

        frmAltPrecoFornecedor.edtTabPre.ReadOnly := True;
        frmAltPrecoFornecedor.edtTabPre.TabStop  := False;

      End;

      // Não está preparado para atualizar preço de venda
      (*  If fCfgSis('FORCAL', VarString) = 'P' Then
            frmAltPrecoFornecedor.rdgTipAltFor.ItemIndex := 0
          Else *)
      frmAltPrecoFornecedor.rdgTipAltFor.ItemIndex := 1;

      frmAltPrecoFornecedor.rdgTipAltFor.Enabled := False;

      frmAltPrecoFornecedor.ShowModal;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAltPrecoGlobalFornecedor]');
    End;
  End;

  If fCfgSis('TABPRD') = 'S' Then
    pFreeAndNil(frmAltPrecoFornecedorTabPrd)
  Else
    pFreeAndNil(frmAltPrecoFornecedor)
end;

Procedure pAtivacaoPrecos(strTabPre: String = '';  HandleOrigin: HWND = 0);
begin

  Try
    pCriarFormularios(TfrmAtivarTabelaPreco, frmAtivarTabelaPreco);

    frmAtivarTabelaPreco.edtTabPre.Text := strTabPre;
    frmAtivarTabelaPreco.HandleOrigin   := HandleOrigin;
    frmAtivarTabelaPreco.edtNomTab.Text := fRetNomeTabelaPreco(frmAtivarTabelaPreco.edtTabPre.Text);

    If Not fEmptyStr(strTabPre) Then
    Begin
      frmAtivarTabelaPreco.edtTabPre.ReadOnly := True;
      frmAtivarTabelaPreco.edtTabPre.TabStop  := False;
    End;

    frmAtivarTabelaPreco.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAltPrecoGlobalFornecedor]');
    End;
  End;

  pFreeAndNil(frmAtivarTabelaPreco)
end;

(*
Procedure pBalancoEstGravar(objDllOpeProd : TparamOpeProd);
  Var
    strCliAju : String;
begin

  strCliAju := fRetNomCliente(fCfgSis('CLIAJU'));

  If fEmptyStr(strCliAju) Then
  Begin
    fMensagem('', 'O cliente configurado para ajuste de estoque não está cadastrado no sistema.' +
                  'Por favor verifique.', ['&O k']);
  End
  Else

  Begin
    Try
      pCriarFormularios(TfrmBalancoEstoqueGravar, frmBalancoEstoqueGravar);
      frmBalancoEstoqueGravar.fGravaMovGer :=  objDllOpeProd.varParam.fGMovGer;
      frmBalancoEstoqueGravar.fGravaMovDet :=  objDllOpeProd.varParam.fGMovDet;
      frmBalancoEstoqueGravar.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[pBalancoEstGravar]');
    End;
    pFreeAndNil(frmBalancoEstoqueGravar);
  End;

end;
*)

Procedure pAltPrecoGlobalNota;
begin

  Try

    pCriarFormularios(TfrmAltPrecoGlobal, frmAltPrecoGlobal);
    frmAltPrecoGlobal.blnAltPorFator := True;
    frmAltPrecoGlobal.blnAltPorNota  := True;
    frmAltPrecoGlobal.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAltPrecoGlobalNota]');
    End;
  End;

  pFreeAndNil(frmAltPrecoGlobal)

end;

procedure pOpeProdutos(prmDllOpe: Pointer);
  Var
    objDllOpeProd : TparamOpeProd;
Begin
  objDllOpeProd := prmDllOpe;

  With objDllOpeProd Do
  Begin
    untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa :=  PrcIniciaProcessoDivisaoDeChapa;
    pSetaModulos(ModRecMod);

    pCriaModulos(VarRecVar);

    pAtuVarGlobaisSimples;

    prcExecutaRelatorio := objDllOpeProd.varParam.prcExecutaRelatorio;
    ProcRetCfgRelacionadaArquivo := FuncExternaprcRetCfgRelacionadaArquivo;

    pVerificaProCod;

    pIniciaLogLeak(intDebugH, 'libOpeRefProd');

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);

    pChamaForms(objDllOpeProd);
  End;

//  pLiberaModulos;

End;

procedure pOpeProdutosCarreg(prmDllOpe: Pointer);
  Var
    objDllOpeProd : TparamOpeProd;
Begin
  objDllOpeProd := prmDllOpe;

  With objDllOpeProd Do
  Begin
    untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa :=  PrcIniciaProcessoDivisaoDeChapa;
    untFuncoesSimples.PrcSuspenteTimerPrincipal :=  PrcSuspenteTimerPrincipal;

    pSetaVariaveis(VarRecVar);
    pAtuVarGlobaisSimples;

    pChamaForms(objDllOpeProd);
  End;

End;

procedure pChamaForms(prmDllOpe: Pointer);
const
  MSG_TRANSFPRECOMED = 'Para empresas que controlam preço médio, se houve movimento '+
                       'no produto que terá seu código transferido, esta rotina não '+
                       'deve ser usada, pois o preço médio não será recalculado. Confirma?';
Var
    objDllOpeProd : TparamOpeProd;
    strAmzIni: String;
    intNumAmz: Integer;
    frmImportCadNOP : TfrmImportCadNOP;
    frmImportCadNCE : TfrmImportCadNCE;
Begin
  objDllOpeProd := prmDllOpe;
  frmImportCadNOP := nil;
  frmImportCadNCE := nil;

  VS_intConEst := fCfgSis('CONEST', varInteger);
  VS_intConAcu := fCfgSis('CONACU', varInteger);

  With objDllOpeProd Do
  Begin
    pSetLiberacao(objLibera);
    untFuncInsFactory.objIFuncIns := objFuncIns;
    untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa :=  PrcIniciaProcessoDivisaoDeChapa;
    untFuncoesSimples.PrcSuspenteTimerPrincipal :=  PrcSuspenteTimerPrincipal;

    untFuncoesSimples.pnlPanelItemPrecoProduto :=  objDllOpeProd.Form;
    Case frmTipOpe of
      CadSalBalanco               : pCriarForm(TfrmCadSalBalanco, frmCadSalBalanco);
      AltPrecoProduto             : pCriarForm(TfrmAltPrecoProduto, frmCadSalBalanco);
      MapaDeInventarioParaColetores : pCriarForm(TfrmMapaDeInventarioParaColetores, frmMapaDeInventarioParaColetores);

      DigCodBarLocFis             : If objDllOpeProd.varParam.blnTraBar Then
                                    Begin
                                      Try
                                        pCriarFormularios(TfrmDigCodBarLocFis, frmDigCodBarLocFis);
                                        frmDigCodBarLocFis.btnTransCod.Visible := True;
                                        frmDigCodBarLocFis.ShowModal;

                                        objDllOpeProd.varParam.strCodBar := frmDigCodBarLocFis.strCodBar;
                                      Except
                                        On E: Exception Do
                                        Begin
                                          pMensagensErro(E.Message, '[pOpeProdLocFisTransf]');
                                        End;
                                      End;

                                      pFreeAndNil(frmDigCodBarLocFis);

                                    End Else
                                    Begin
                                      Try
                                        pCriarFormularios(TfrmDigCodBarLocFis, frmDigCodBarLocFis);
                                        frmDigCodBarLocFis.edtCodIte.Text := objDllOpeProd.varParam.strCodIte;
                                        frmDigCodBarLocFis.blnCarregandoDoMapeamento := True;
                                        frmDigCodBarLocFis.ShowModal;

                                      Except
                                        On E: Exception Do
                                        Begin
                                          pMensagensErro(E.Message, '[pOpeProdLocFisMapeamento]');
                                        End;
                                      End;

                                      pFreeAndNil(frmDigCodBarLocFis);
                                    End;

      ManECommerce                : pCriarForm(TfrmManECommerce, frmManECommerce);
      AltPrecoIndividual          : pCriarForm(TfrmAltPrecoIndividual,frmAltPrecoIndividual);
      AltEfetivacaoPrecos         : pCriarForm(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
      RelacSimilaridade           : pCriarForm(TfrmRelacSimilaridade, frmRelacSimilaridade);
      RelacSemelhanca             : pCriarForm(TfrmRelacSemelhanca, frmRelacSemelhanca);
      ProdutosAgrupados           : pCriarForm(TfrmProdutosAgrupados, frmProdutosAgrupados);
      TransfLinGru                : pCriarForm(TfrmTransfLinGru, frmTransfLinGru);
      ImportComisVendTabPreco     : pCriarForm(TfrmImportComisVendTabPreco, frmImportComisVendTabPreco);
      ImportTabPreIteger          : pCriarForm(TfrmImportTabPrecosIteger, frmImportTabPrecosIteger);
      ImportCadProduto            : pCriarForm(TfrmImportCadProduto, frmImportCadProduto);
      ImportCadEstrutura          : pCriarForm(TfrmImportCadEstrutura, frmImportCadEstrutura);
      ImportCadNCM                : pCriarForm(TfrmImportCadNCM, frmImportCadNCM);
      ImportCadNOP                : pCriarForm(TfrmImportCadNOP, frmImportCadNOP);
      ImportCadNCE                : pCriarForm(TfrmImportCadNCE, frmImportCadNCE);
      ImportMarBruTabPreco,
      ImportPreVenTabPreco        : Begin
                                      pCriarFormularios(TfrmImportMargemLucroTabPreco, frmImportMargemLucroTabPreco);
                                      frmImportMargemLucroTabPreco.blnRecalcMargem := frmTipOpe = ImportPreVenTabPreco;
                                      Try
                                        frmImportMargemLucroTabPreco.Showmodal;
                                      Finally
                                        FreeAndNil(frmImportMargemLucroTabPreco);
                                      End;
                                    End;

      TransfCodProduto            : Try
                                      If fMensagem('AVISO',MSG_TRANSFPRECOMED, ['', '']) = 1 Then
                                      begin
                                        if fConfirmaTransfCodigo then
                                        begin
                                          blnTransferindoCodigo := True;
                                          pCriarForm(TfrmTransfCodProduto, frmTransfCodProduto);
                                        end;
                                      end;
                                    Finally
                                      blnTransferindoCodigo := False;
                                    End;

      GeracaoCodBarras            : pCriarForm(TfrmGeracaoCodBarras, frmGeracaoCodBarras);
      ImportCatalogoPreco         : pCriarForm(TfrmImportCatalogoPreco, frmImportCatalogoPreco);
      SelListPreco                : pCriarForm(TfrmSelListPreco, frmSelListPreco);
      CadManutInvSel              : pCriarFormularios(TfrmCadManutInvSel, frmCadManutInvSel);
      ManutInventario             : pManutInventario;
      ManutInventarioLote         : pManutInventarioBroker;
      GerInventario               : pCriarForm(TfrmGerInventario, frmGerInventario);
      AltPrecoGlobalCatalogo      : pAltPrecoGlobalCatalogo;
      AltPrecoGlobal,
      EfetivacaoPrecosFornecedor  : pAltPrecoGlobal(frmTipOpe);
      AltGlobalServico            : pCriarForm(TfrmAltGlobalServico);
      AltPrecoGlobalNota          : pAltPrecoGlobalNota;
      AltPrecoGlobalFornecedor    : pAltPrecoGlobalFornecedor(varParam.strCodTab);
      AtivacaoTabelaPreco         : pAtivacaoPrecos(varParam.strCodTab,  varParam.HandleOrigin);
//      BalancoEstoqueGravar      : pBalancoEstGravar(objDllOpeProd);
      RelBalancoEstoqueDiferenca  : pCriarForm(TfrmRelBalancoEstoqueDiferenca, frmRelBalancoEstoqueDiferenca);
      BalancoEstoqueDigManual     : pCriarForm(TfrmBalancoEstoqueDigManual, frmBalancoEstoqueDigManual);
      BalancoEstoqueDigColetivo   : pCriarForm(TfrmBalancoEstoqueDigColetivo, frmBalancoEstoqueDigColetivo);
      BalancoEstoqueImportar      : pCriarForm(TfrmBalancoEstoqueImportar, frmBalancoEstoqueImportar);
      BalancoEstoqueZera          : pCriarForm(TfrmBalancoEstoqueZera, frmBalancoEstoqueZera);
      CadBocaCaixaAlt             : pCriarForm(TfrmCadBocaCaixaAlt, frmCadBocaCaixaAlt);
      ExpFunBosh                  : pCriarForm(TfrmExpFunBosh, frmExpFunBosh);
      EtiquetasNotaEntrada        : pCriarForm(TfrmImpEtiqNotaEntrada, frmImpEtiqNotaEntrada);
      AltNumLote                  : pCriarForm(TfrmAltNumLote, frmAltNumLote);
      BalancoEstoqueDigMotorola   : pCriarForm(TfrmBalancoEstoqueDigMotorola, frmBalancoEstoqueDigMotorola);
      BalancoEstoqueDigCompex260  : pCriarForm(TfrmBalancoEstoqueDigCompex260, frmBalancoEstoqueDigCompex260);
      AltEfetivacaoPrecosTab      : pCriarForm(TfrmAltEfetivacaoPrecosTab, frmAltEfetivacaoPrecosTab);
      AlteraEstMinMax             : pCriarForm(TfrmAlteraEstMinMax, frmAlteraEstMinMax);
      ManDesIte                   : pCriarForm(TfrmManDesIte, frmManDesIte);
      ManutCustoProdutos          : pCriarForm(TfrmManutCustoProdutos, frmManutCustoProdutos);
      AltPrecoMedio               : pCriarForm(TfrmAltPrecoMedio, frmAltPrecoMedio);
      AltGlobalPromocoes          : pCriarForm(TfrmAltGlobalPromocoes, frmAltGlobalPromocoes);
      ManutancaoDescontoEmbalagem : pCriarForm(TfrmManutancaoDescontoEmbalagem, frmManutancaoDescontoEmbalagem);
      ManutancaoDescontoEmbalagemExcluir:
      Begin
        pCriarFormularios(TfrmManutancaoDescontoEmbalagem, frmManutancaoDescontoEmbalagem);
        frmManutancaoDescontoEmbalagem.TipoEmbalagem(teExcluir);
        Try
          frmManutancaoDescontoEmbalagem.Showmodal;
        Finally
          FreeAndNil(frmManutancaoDescontoEmbalagem);
        End;
      End;
      ManutencaoEmpresaCentraliza : pCriarForm(TfrmManutencaoEmpresaCentralizadora, frmManutencaoEmpresaCentralizadora);
      ExpBuscaPreco               : Begin

                                      If Assigned(prcExecutaRelatorio) Then
                                      begin
                                        prcExecutaRelatorio(242, 8220, [],
                                                              ['TABPRE','ITEATI'],
                                                              [objDllOpeProd.varParam.strTabPre,
                                                              IIF(objDllOpeProd.varParam.strStatus='A','Ativos',IIF(objDllOpeProd.varParam.strStatus='I','Inativos','Todos'))],
                                                              nil,
                                                              nil,
                                                              (Not fEmptyStr(objDllOpeProd.varParam.strTabPre)));
                                      End;

                                    End;

      ExpBuscaPrecoGertec         : Begin

                                      If Assigned(prcExecutaRelatorio) Then
                                      begin
                                        prcExecutaRelatorio(240, 8173, [],
                                                              ['TABPRE','ITEATI'],
                                                              [objDllOpeProd.varParam.strTabPre,
                                                              IIF(objDllOpeProd.varParam.strStatus='A','Ativos',IIF(objDllOpeProd.varParam.strStatus='I','Inativos','Todos'))],
                                                              nil,
                                                              nil,
                                                              (Not fEmptyStr(objDllOpeProd.varParam.strTabPre)));
                                      End;

                                    End;
      GeracaoFCI_Exportacao,
      GeracaoFCI_Importacao       : Begin
                                      pCriarFormularios(TfrmGeracaoFichaControleImportacao, frmGeracaoFichaControleImportacao);
                                      frmGeracaoFichaControleImportacao.blnExportacao := (objDllOpeProd.frmTipOpe = GeracaoFCI_Exportacao);
                                      frmGeracaoFichaControleImportacao.ShowModal();
                                      FreeAndNil(frmGeracaoFichaControleImportacao);
                                    End;
      ImportaProdFranq            : pCriarForm(TfrmImportaProdFranq, frmImportaProdFranq);
      ExpPricer                   : Begin

                                      If Assigned(prcExecutaRelatorio) Then
                                      begin
                                        prcExecutaRelatorio(255, 8663, [8664],
                                                              ['TABPRE','ITEATI'],
                                                              [objDllOpeProd.varParam.strTabPre,
                                                              IIF(objDllOpeProd.varParam.strStatus='A','Ativos',IIF(objDllOpeProd.varParam.strStatus='I','Inativos','Todos'))],
                                                              nil,
                                                              nil,
                                                              True);
                                      End;

                                    End;
      ReplicacaoLotes             : pCriarForm(TfrmReplicacaoLotes, frmReplicacaoLotes);
      BalancoIniciaArmazem        : Begin

                                      If TCadLot.fTemContagemArmazem(strAmzIni, intNumAmz) Then
                                      Begin
                                        pMensagemOk('O balanço do(s) armazém(s) ' + strAmzIni + ' já está iniciado!');
                                        Exit;
                                      End;

                                      pCriarForm(TfrmBalancoIniciaArmazem, frmBalancoIniciaArmazem);
                                    End;

      BalancoFinalizaArmazem      : Begin

                                      If Not TCadLot.fTemContagemArmazem(strAmzIni, intNumAmz) Then
                                      Begin
                                        pMensagemOk('Não há balanço de armazém iniciado!');
                                        Exit;
                                      End;

                                      pCriarFormularios(TfrmBalancoIniciaArmazem, frmBalancoIniciaArmazem);
                                      frmBalancoIniciaArmazem.blnFinaliza := True;
                                      frmBalancoIniciaArmazem.Showmodal;
                                      FreeAndNil(frmBalancoIniciaArmazem);
                                    End;
      AtualizaDolarCatalogos       : pCriarForm(TfrmAtualizacaoCotacaoDolarNosCatalogos, frmAtualizacaoCotacaoDolarNosCatalogos);

      AtualizacaoMargemParaFranquia: pCriarForm(TfrmAtualizacaoMargemParaFranquias, frmAtualizacaoMargemParaFranquias);
      AltGlobalProdutosAcabados    : pCriarForm(TfrmAltGlobalProdutosAcabados, frmAltGlobalProdutosAcabados);
      AltGeralProdutos             : pCriarForm(TfrmAlteracaoGeraldePrecosdeProdutos, frmAlteracaoGeraldePrecosdeProdutos);
      RelMapaDeContagem            : If TControleContagemBalancoEstoque.fUtilizaContagemControladaBalanco Then
                                       pCriarForm(TfrmMapaDeContagens, frmMapaDeContagens)
                                     Else
                                       pCriarForm(TfrmRelMapaDeCaontagem, frmRelMapaDeCaontagem);
      RelClienteProdutoGarantia    : pCriarForm(TfrmRelacionamentoClienteProdutoGarantia, frmRelacionamentoClienteProdutoGarantia);
      ApiSaneamento                : Begin
                                        pCriarFormularios(TfrmConsultoriaFiscalSaneamento, frmConsultoriaFiscalSaneamento);
                                        Try
                                          frmConsultoriaFiscalSaneamento.objDllOpeProd :=  objDllOpeProd;
                                          frmConsultoriaFiscalSaneamento.ShowModal;
                                        Finally
                                          FreeAndNil(frmConsultoriaFiscalSaneamento);
                                        End;

                                     End;
      ImportaPROSER                : pCriarForm(TfrmImportaPROSER, frmImportaPROSER);
      DivergenciasSeparacao        : Begin
                                       pCriarFormularios(TfrmDivergenciasSeparacaoColetor, frmDivergenciasSeparacaoColetor);
                                       Try
                                         frmDivergenciasSeparacaoColetor.objDllOpeProd := prmDllOpe;
                                         frmDivergenciasSeparacaoColetor.ShowModal;
                                       finally
                                         FreeAndNil(frmDivergenciasSeparacaoColetor);
                                       End;
                                     End;
    End;
  End;

End;

function fCallConfirmaEfetivacaoPreco(prmDllOpe: Pointer; dtaDtaPre: TDate): Boolean;
  Var
    objDllOpeProd : TparamOpeProd;
Begin
  objDllOpeProd := prmDllOpe;

  With objDllOpeProd Do
  Begin
    pSetaModulos(ModRecMod);

    pCriaModulos(VarRecVar);

    pAtuVarGlobaisSimples;

    pVerificaProCod;

    pIniciaLogLeak(intDebugH, 'libOpeRefProd');

    TLogForm.strCodEmp := VS_strCodEmp;
    TLogForm.strCodOpe := strLoginUsuarioLogado;
    TLogForm.dtaDtaLog := VS_Date;
    TLogForm.fncCriaQuery := fCriaQuery;
    TLogForm.fncTime := fTime;
    TLogForm.blnLogFrm := fCfgSis('LOGFRM', varBoolean) And fTabelaExiste('LOGFRM', True);
    untFuncoesSimples.PrcIniciaProcessoDivisaoDeChapa :=  PrcIniciaProcessoDivisaoDeChapa;
    untFuncoesSimples.PrcSuspenteTimerPrincipal :=  PrcSuspenteTimerPrincipal;


    pSetLiberacao(objLibera);
  End;

  pCriarFormularios(TfrmAltEfetivacaoPrecos, frmAltEfetivacaoPrecos);
  Try
    Result := frmAltEfetivacaoPrecos.fConfirmaEfetivacaoPreco(dtaDtaPre);
  Finally
    FreeAndNil(frmAltEfetivacaoPrecos);
  End;
end;



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
