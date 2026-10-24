unit untPai;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, StdCtrls, Buttons, Controls,
  ExtCtrls, Graphics, Forms, Dialogs, ComCtrls, DBCtrls, DBEditFocus, TypInfo,
  EditFocus, DBGridCitel, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus,
  Uni, DB, Mask, FilenameEditFocus, DirectoryEditFocus, AppEvnts, Messages,
  CurrencyEditFocus, untFuncoesGenerica, untLabelRg, untLabelCgcCpf, untMskC_G_C_,
  untMskTelefone, untLabelCgc, untLabelCpf, untDBECgcCpf, untDBETipoCgcCpf,
  untEditTipoCgcCpf, BitBtnLockedIncrem, DBLookupComboBoxFocus, ShellAPI,
  System.UITypes, frxClass, frxExportCSVTestabilidade, frxExportPDF, cxCheckBox,
  cxDropDownEdit, cxDBEdit, cxMaskEdit, untPaiSQLTrace,
  cxControls, cxGroupBox, cxCustomListBox, cxCheckListBox,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles, // to gain access to TSysPopupStyleHook
  untFrameDirectoryEditFocus;

type
  TfrmPai = class(TfrmPaiSQLTrace)
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    btnSair: TBitBtnLocked;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    FlwBotoes: TFlowPanel;
    pnlBotoesTrace: TPanel;
    btnIniciarTrace: TSpeedButton;
    btnPausarTrace: TSpeedButton;
    btnSalvarTrace: TSpeedButton;
    btnViewerTrace: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnShowTraceClick(Sender: TObject);
    procedure btnHideTraceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    intSemaforoKeyDown: Integer;
    FPais: TPais;
    FOriginalCaption: String;
    FPrimeiraVez: Boolean;
    procedure pSetarQueryLogTraceEvents;
    procedure pIniTraceForms;
    procedure pFinalizar;
    function fVersaoSistema: String;
    procedure pAjustarTema(AParent: TWinControl);
    procedure pSetarTema;
  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryTabela: TUniQuery;
    qryCfgRel: TUniQuery;
    blnLibCnf: Boolean;
    strSenha : String;
    blnValidarComTAB: Boolean;

    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnBitBtnErro(Sender: TWinControl; strMsgErro: string; E: Exception);

    procedure pProximoControle(Sender: TObject); virtual;
    procedure pEscapePressed; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fVerificaSubControl(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

    function HandleCreateException: Boolean; override;

    procedure pSelNext;
  public
    { Public declarations }
    {*****************************************}
    {* REPRESENTA O ÚLIMO REGISTRO INSERIDO  *}
    {* OU ALTERADO NA SESSÃO                 *}
    {**************************************MV*}
    {*****************************************}
    {* ESTA VARIAVEL VEIO PARA O PAI DEVIDO  *}
    {* AO CADASTRO DE ABREVIAÇÃO DO PIS/CONF.*}
    {*************************************GB**}
    strUltimoCodigo: String;

    strFilRel: String;
    blnFecharComEscape: Boolean;
    blnFecharFormPai: Boolean;
    blnMudarFoco: Boolean;

    objTracePai: ISQLTrace;

    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit; blnHabilitar: Boolean);
    procedure pSQLTrace(Sender: TObject);

  published
    property OriginalCaption: String Read FOriginalCaption;

  end;

var
  frmPai: TfrmPai;

implementation

uses untConstantes, untFuncoesFactory, untIFuncoes, cxCalendar, untCadConfRelatorios,
  untITSQLTrace, untGravando;

{$R *.dfm}

procedure TfrmPai.FormActivate(Sender: TObject);
begin
  If Not objFuncoes.fGetUsuarioUtilizaTemaClassico Then
    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      pAjustarTema(Self);

  If Not objFuncoes.fGetUsuarioUtilizaTemaClassico Then
    Self.Repaint;

  If Not String(Caption).Contains(fVersaoSistema()) Then
    Caption := Caption + '   -   ' + fVersaoSistema();

  If (objTrace.GetAutenticado()) Then
  Begin
    pIniTraceForms();
  End;

  If FPrimeiraVez And Assigned(untFuncoesFactory.VS_objLogTrace) Then
  Begin
    untFuncoesFactory.VS_objLogTrace.IniciarLogTrace;
    SetForegroundWindow(Self.Handle);
  End;

  FPrimeiraVez := False;
end;

function TfrmPai.fVersaoSistema: String;
begin
  Result := objFuncoes.fGetTituloVersao + ' - Emp: ' + VS_strCodEmp;
end;

procedure TfrmPai.pSetarTema;
begin
  If Not objFuncoes.fGetUsuarioUtilizaTemaClassico Then
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

    End;
  End;
end;

procedure TfrmPai.pAjustarTema(AParent: TWinControl);
Var
  I: Integer;

  procedure pAjustaControl(AControl: TControl);
  begin
    If IsPublishedProp(AControl, 'ParentBackground') Then
      SetPropValue(AControl, 'ParentBackground', False);

    If IsPublishedProp(AControl, 'Color') Then
      If GetPropValue(AControl, 'Color') = $00FFE4D5 Then
        SetPropValue(AControl, 'Color', TStyleManager.ActiveStyle.GetStyleColor(scPanel));

    If AControl Is TPanel Then
      If TPanel(AControl).Color = clGray Then
         TPanel(AControl).Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

    If AControl Is TLabel Then
      If TLabel(AControl).Font.Color <> clBlack Then
        If TLabel(AControl).Font.Color <> clWhite Then
          TLabel(AControl).StyleElements :=
            TLabel(AControl).StyleElements - [seFont];

    If AControl Is TEdit Then
      If TEdit(AControl).Font.Color <> clBlack Then
        If TEdit(AControl).Font.Color <> clWhite Then
          TEdit(AControl).StyleElements :=
            TEdit(AControl).StyleElements - [seFont];

    If AControl Is TBitBtn Then
      TBitBtn(AControl).StyleElements := [];
  end;

  procedure pAjustaCxControl(AControl: TcxControl);
  begin
    If IsPublishedProp(AControl, 'ParentBackground') Then
      SetPropValue(AControl, 'ParentBackground', False);

    If (AControl Is TcxGroupBox) Then
    Begin
      TcxGroupBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
      TcxGroupBox(AControl).Transparent := True;
    End;

    If (AControl Is TcxCheckListBox) Then
      TcxCheckListBox(AControl).Style.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);
  end;

begin
  If Self.Color = $00FFE4D5 Then
    Self.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  pnlBotoes.Color := TStyleManager.ActiveStyle.GetStyleColor(scPanel);

  For I := 0 To AParent.ComponentCount -1 Do
  Begin
    If (AParent.Components[I] Is TControl) Then
      pAjustaControl(TControl(AParent.Components[I]));

    If (AParent.Components[I] Is TFrame) Then
      pAjustarTema(TWinControl(AParent.Components[I]));
  End;

  For I := 0 To AParent.ControlCount -1 Do
  Begin
    pAjustaControl(AParent.Controls[I]);

    If (AParent.Controls[I] Is TWinControl) Then
      pAjustarTema(TWinControl(AParent.Controls[I]));
  End;

  For I := 0 To AParent.ControlCount -1 Do
  Begin
    If (AParent.Controls[I] Is TcxControl) Then
      pAjustaCxControl(TcxControl(AParent.Controls[I]));
  End;

end;

procedure TfrmPai.pSetarQueryLogTraceEvents;
Var
  I: Integer;
begin
  If Assigned(untFuncoesFactory.VS_objLogTrace) Then
    For I := 0 To Self.ComponentCount -1 Do
      If Self.Components[I] Is TUniQuery Then
        untFuncoesFactory.VS_objLogTrace.RegistrarQueryEvents(TUniQuery(Self.Components[I]));
end;

procedure TfrmPai.FormCreate(Sender: TObject);
  Var
    intContador: Integer;
begin
  FPrimeiraVez := True;

  pSetarQueryTraceViewerEvents;

  If Not objFuncoes.fGetUsuarioUtilizaTemaClassico Then
  Begin
    If TStyleManager.ActiveStyle.Name <> AUTCOM_STYLE_NAME Then
      pSetarTema();

    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      If Self.Position = poMainFormCenter Then
        Self.Position := poDesktopCenter;
  End;

  blnValidarComTAB := False;
  strFilRel := '';

  If (Not fEmptyStr(VS_strCodEmp)) Then
    FPais := fSetaPais;

  intSemaforoKeyDown := -1;    

  blnFecharComEscape := True;

  blnFecharFormPai := False;
  
  qryCfgRel := fCriaQuery(Self);

  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;

  {*****************************************}
  {* ATRIBUI OS METODOS REFERENTES AO      *}
  {* EVENTO 'OnKeyDown' DOS COMPONENTES    *}
  {**************************************MV*}
  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TLabelRg) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelRg(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelRg(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCgcCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgcCpf(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgcCpf(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCgc) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgc(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgc(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TLabelCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCpf(Self.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCpf(Self.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (Self.Components[intContador] Is TDBEditCgcCpf) And (Not fPodeValidarCgcCpf(FPais)) Then
    Begin
      TDBEditCgcCpf(Self.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditCgcCpf(Self.Components[intContador]).Tag := 0
    End

    Else If (Self.Components[intContador] Is TDBEditTipoCgcCpf) Then
    Begin
      TDBEditTipoCgcCpf(Self.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditTipoCgcCpf(Self.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TDBEditTipoCgcCpf(Self.Components[intContador]).Visible) Then
        TDBEditTipoCgcCpf(Self.Components[intContador]).Tag := 0;
    End

    Else If (Self.Components[intContador] Is TEditTipoCgcCpf) Then
    Begin
      TEditTipoCgcCpf(Self.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TEditTipoCgcCpf(Self.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TEditTipoCgcCpf(Self.Components[intContador]).Visible) Then
        TEditTipoCgcCpf(Self.Components[intContador]).Tag := 0;
    End

    Else If (Self.Components[intContador] Is TDBEditFocus) Then
    Begin
      (Self.Components[intContador] As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (Self.Components[intContador] Is TDBCheckBox) Then
    Begin
      (Self.Components[intContador] As TDBCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TCheckBox) Then
    Begin
      (Self.Components[intContador] As TCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TRadioButton) Then
    Begin
      (Self.Components[intContador] As TRadioButton).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TDBComboBoxFocus) Then
    Begin
      (Self.Components[intContador] As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (Self.Components[intContador] Is TDBLookupComboBox) Then
      TDBLookupComboBox(Self.Components[intContador]).OnKeyDOwn := pOnKeyDownEdits

    Else If (Self.Components[intContador] Is TEditFocus) Then
    Begin
      (Self.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (Self.Components[intContador] Is TMaskEditTelefone) Then
    Begin
      TMaskEditTelefone(Self.Components[intContador]).pSetTelefo(FPais);

      If (Self.Components[intContador] As TMaskEditTelefone).Tag = 99 Then
        (Self.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TMaskEditFocus) Then
    Begin
      If (Self.Components[intContador] As TMaskEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TFilenameEditFocus) Then
    Begin
      If (Self.Components[intContador] As TFilenameEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TfraDirectoryEditFocus) Then
    Begin
      If (Self.Components[intContador] As TfraDirectoryEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TComboBoxFocus) Then
    Begin

      If (Self.Components[intContador] As TComboBoxFocus).Tag = 99 Then
        (Self.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDown;

    End

    Else If (Self.Components[intContador] Is TcxDateEdit) Then
    Begin
      (Self.Components[intContador] As TcxDateEdit).ParentFont := False;
      If (Self.Components[intContador] As TcxDateEdit).Tag = 99 Then
        (Self.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (Self.Components[intContador] Is TCurrencyEditFocus) Then
    Begin
      If (Self.Components[intContador] As TCurrencyEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (Self.Components[intContador] Is TDBGridCitel) Then
    Begin
      TDBGridCitel(Self.Components[intContador]).DrawingStyle := gdsClassic;
    End

    Else If (Self.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(Self.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End

    Else If (Self.Components[intContador] Is TBitBtnLocked) Then
    Begin
      If Not Assigned(TBitBtnLocked(Self.Components[intContador]).OnErro) Then
        TBitBtnLocked(Self.Components[intContador]).OnErro := pOnBitBtnErro;
    End

    Else If (Self.Components[intContador] Is TfrxPDFExport) Then
    Begin
      TfrxPDFExport(Self.Components[intContador]).EmbeddedFonts         := True;
      TfrxPDFExport(Self.Components[intContador]).EmbedFontsIfProtected := True;
      TfrxPDFExport(Self.Components[intContador]).ExportNotPrintable    := True;
    End;

  End;

  FOriginalCaption := Self.Caption;

  If Assigned(objFuncoes.fGetRegistrarFormPermissaoAcesso) Then
    objFuncoes.fGetRegistrarFormPermissaoAcesso.AddForm(Self);

end;

procedure TfrmPai.FormDestroy(Sender: TObject);
begin
  If Assigned(objFuncoes.fGetRegistrarFormPermissaoAcesso) Then
    objFuncoes.fGetRegistrarFormPermissaoAcesso.RemoveForm(Self);

  inherited;
end;

procedure TfrmPai.pAtualizaControlsTrace;
begin
  btnIniciarTrace.Width  := IIF(objTracePai.Status = stPausado , 23, 0);
  btnPausarTrace.Width   := IIF(objTracePai.Status = stIniciado, 23, 0);
  btnViewerTrace.Width   := IIF(Assigned(VS_objTraceViewer)    , 23, 0);
  btnSalvarTrace.Enabled := True;
end;

procedure TfrmPai.btnIniciarTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pIniciaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPai.btnPausarTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pPausaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPai.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPai.btnSalvarTraceClick(Sender: TObject);
begin
  if (Assigned(objTracePai)) then
  begin
    objTracePai.pSalvaTrace();
    pAtualizaControlsTrace();
  end;
end;

procedure TfrmPai.btnViewerTraceClick(Sender: TObject);
begin
  If Not Assigned(objTracePai) Then
    Exit;

  If Not Assigned(VS_objTraceViewer) Then
    Exit;

  If VS_objTraceViewer.Visible Then
    Exit;

  VS_objTraceViewer.Show;
end;

procedure TfrmPai.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_Escape: If (ActiveControl Is TBitBtnLocked) Then
               Begin
                pEscapePressed;
               End;

    VK_F1    : Begin
                 If ActiveControl <> nil Then
                   pAjudaAutcom(Handle, ActiveControl.HelpContext);
               End;

    VK_F2    : If (Shift = [ssShift, ssAlt, ssCtrl]) And (Assigned(VS_objTraceViewer)) Then
                 pSQLTrace(Sender);

    VK_Return: If (ActiveControl Is TRadioButton) And (ActiveControl.Parent <> Nil) And (ActiveControl.Parent Is TRadioGroup) Then
                 SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmPai.FormPaint(Sender: TObject);
begin
  If blnFecharFormPai Then
  Begin
    blnFecharFormPai := False;
    Close;
  End;
end;

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit;
  blnHabilitar: Boolean);
begin
  If (Not blnHabilitar) Then
  Begin
    dbeCampoEnable.Enabled := blnHabilitar;
    dbeCampoEnable.Color := $00FFDFB8;
  End;
  If dbeCampoFocus.Enabled Then
    pSetFocus(dbeCampoFocus);
end;

procedure TfrmPai.mnuConfigurarRelClick(Sender: TObject);
begin
  Try
    if (Not fVerificaAcessoSistema('FrmCadConfRelatorios', strLoginUsuarioLogado)) then
    begin
      pMensagemOk('Usuário sem direito de acesso a esta opção!');
      Exit;
    end;

    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    If fEmptyStr(strFilRel) Then
      frmCadConfRelatorios.strNomeForm   := Self.Name
    Else
      frmCadConfRelatorios.strNomeForm   := strFilRel;

    frmCadConfRelatorios.showModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPai.mnuConfigurarRelClick]');
    End;
  End;
  pFreeAndNil(frmCadConfRelatorios);
end;

function TfrmPai.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  //#Asimov# inherited fValidaCampos
  function fValidaCamposFrameDirectoryEditFocus: Boolean;
  begin
    if (not Assigned(Sender.Owner)) or
       (not (Sender.Owner is TfraDirectoryEditFocus)) or
       ((TfraDirectoryEditFocus(Sender.Owner).Tag <> 99) and (TfraDirectoryEditFocus(Sender.Owner).edtDirectory.Tag <> 99)) then
    begin
      exit(True);
    end;
    result := fValidaCampos((Sender.Owner as TfraDirectoryEditFocus), blnBuscaPorChave)
  end;

begin
  Result := fValidaCamposFrameDirectoryEditFocus;
end;


function TfrmPai.fValidaPanel(pnlPanel: TPanel;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intContador: Integer;
begin

  Result := True;
  
  For intContador := 0 To pnlPanel.ControlCount -1 Do
  Begin

    If pnlPanel.Controls[intContador].Tag = 99 Then
      Result := fValidaCampos(TWinControl(pnlPanel.Controls[intContador]), blnBuscaPorChave);

    If Not Result Then
      Break;

  End;

end;

{******************************************}
{* FUNÇÃO QUE REVALIDA TODOS OS CAMPOS    *}
{* VERIFICA TODOS OS CAMPOS E CASO OCORRA *}
{* ALGUMA FALHA NA VERIFICAÇÃO, FOCA TAL  *}
{* CAMPO.                                 *}
{***************************************MV*}
function TfrmPai.fVerificaCampos: Boolean;
begin
  Result := fVerificaSubObjeto(Self);
end;

{*********************************}
{* VERIFICA TODOS OS COMPONENTES *}
{* DENTRO DE PANEL OU SCROLLBOX  *}
{* (RECURSIVO)                   *}
{******************************AF*}
function TfrmPai.fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ComponentCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Components[intContador] Is TPanel)     Or
       (objObjeto.Components[intContador] Is TScrollBox) Or
       (objObjeto.Components[intContador] Is TGroupBox)  Or
       (objObjeto.Components[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Components[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If ((objObjeto.Components[intContador] As TTabSheet).Tag = -1) Then
        Begin
          Exit
        End;
        (objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
      End;

      Result := fVerificaSubObjeto((objObjeto.Components[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Components[intcontador].Tag = 99 Then
        If (objObjeto.Components[intContador] Is TWinControl) Then
        Begin
          Try
            Result := fValidaCampos((objObjeto.Components[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message,'[TfrmPai.fVerificaSubObjeto]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

function TfrmPai.fVerificaSubControl(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ControlCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Controls[intContador] Is TPanel)     Or
       (objObjeto.Controls[intContador] Is TScrollBox) Or
       (objObjeto.Controls[intContador] Is TGroupBox)  Or
       (objObjeto.Controls[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Controls[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If ((objObjeto.Controls[intContador] As TTabSheet).Tag = -1) Then
        Begin
          Exit
        End;
        (objObjeto.Controls[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Controls[intContador] As TTabSheet);
      End;

      Result := fVerificaSubControl((objObjeto.Controls[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Controls[intcontador].Tag = 99 Then
        If (objObjeto.Controls[intContador] Is TWinControl) Then
        Begin
          Try
            Result := fValidaCampos((objObjeto.Controls[intContador] As TWinControl), False);
          Except
            On E: Exception Do
            Begin
							pMensagensErro(E.Message,'[TfrmPai.fVerificaSubControl]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Controls[intContador] As TWinControl).Name);
              Result := False;
            End;
          End;
        End;

        If Not Result Then
          Exit;
    End;

  End;

end;

procedure TfrmPai.pProximoControle(Sender: TObject);
begin
  If (Sender As TWinControl).Tag = 99 Then
  Begin
    If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
      SelectNext(ActiveControl, True, True);
  End
  Else
    SelectNext(ActiveControl, True, True);
  blnMudarFoco := True;
end;

procedure TfrmPai.pEscapePressed;
begin
  If blnFecharComEscape Then
    Close;
end;

procedure TfrmPai.pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  Raise Exception.Create(E.Message);
end;

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If InterlockedIncrement(intSemaforoKeyDown) = 0 Then
  Begin
    Try
      If (Key = VK_Return) Then
      Begin
        pProximoControle(Sender);
      End
      Else If (Key = VK_Escape) Then
      Begin
        pEscapePressed;
      End;
    Finally
      InterlockedDecrement(intSemaforoKeyDown);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoKeyDown);
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
procedure TfrmPai.pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If InterlockedIncrement(intSemaforoKeyDown) = 0 Then
  Begin
    Try
      If (Key = VK_Return) Then
      Begin
        pProximoControle(Sender);
      End
      Else If (Key = VK_Escape) Then
      Begin
        pEscapePressed;
      End;
    Finally
      InterlockedDecrement(intSemaforoKeyDown);
    End;
  End
  Else
    InterlockedDecrement(intSemaforoKeyDown);
end;

procedure TfrmPai.ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
  var i: SmallInt;
begin

  Try
    If (ActiveControl is TDBGridCitel) Then
    begin
      With TDBGridCitel(ActiveControl) do
      Begin
        If Msg.message = WM_MOUSEWHEEL Then
        Begin
          Msg.message := WM_KEYDOWN;
          Msg.lParam := 0;
          i := HiWord(Msg.wParam);
          If i > 0 Then
            Msg.wParam := VK_UP
          Else
            Msg.wParam := VK_DOWN;
          Handled := False;
        End;
      End;
    End;
  Except
    //Ocorre de disparar "mensagens de eventos" quando
    //esta destruindo o formulario e seus componentes. Isto provoca
    //access violation quando tenta verificar o controle ativo (ActiveControl)
  End;

end;

procedure TfrmPai.FormShortCut(var Msg: TWMKey; var Handled: Boolean);

  function fKeyIsDown(const Key: integer): boolean;
  begin
    Result := GetKeyState(Key) and 128 > 0;
  end;

begin
  inherited;
  If Not blnValidarComTAB Then
    Exit;

  If (Not Assigned(ActiveControl)) Then
    Exit;

  If Not ( (ActiveControl Is TDBEditCgcCpf) Or
           (ActiveControl Is TDBEditTipoCgcCpf) Or
           (ActiveControl Is TEditTipoCgcCpf) Or
           (ActiveControl Is TDBEditFocus) Or
           (ActiveControl Is TDBCheckBox) Or
           (ActiveControl Is TCheckBox) Or
           (ActiveControl Is TcxCheckBox) Or
           (ActiveControl Is TRadioButton) Or
           (ActiveControl Is TDBComboBoxFocus) Or
           (ActiveControl Is TDBLookupComboBox) Or
           (ActiveControl Is TEditFocus) Or
           (ActiveControl Is TMaskEditTelefone) Or
           (ActiveControl Is TMaskEditFocus) Or
           (ActiveControl Is TFilenameEditFocus) Or
           (ActiveControl Is TfraDirectoryEditFocus) Or
           (ActiveControl Is TComboBoxFocus) Or
           (ActiveControl Is TcxDateEdit) Or
           (ActiveControl Is TcxDBMaskEdit) Or
           (ActiveControl Is TcxComboBox) Or
           (ActiveControl Is TCurrencyEditFocus) ) Then
  Begin
    Exit;
  End;

  If (Msg.CharCode <> VK_TAB) Then
    Exit;

  {Caso ALT pressionado}
  If fKeyIsDown(VK_MENU) Then
    Exit;

  If fKeyIsDown(VK_SHIFT) Then
    Exit;

  If fKeyIsDown(VK_CONTROL) Then
    Exit;

  Msg.CharCode := 0;

  {Ao pressionar o TAB estava limpando o valor do campo de Data TMaskEditFocus}
  If ActiveControl Is TCustomEdit Then
    If TCustomEdit(ActiveControl).Text <> '' Then
    Begin
      TCustomEdit(ActiveControl).SelStart  := 1;
      TCustomEdit(ActiveControl).SelLength := 1;
    End;

  ActiveControl.Perform(WM_KEYDOWN, VK_RETURN, 0);
end;

procedure TfrmPai.FormShow(Sender: TObject);
begin

  SetForegroundWindow(Self.Handle);

end;

function TfrmPai.HandleCreateException: Boolean;
begin
  Result := False;
end;

procedure TfrmPai.pSelNext;
begin
  SelectNext(ActiveControl, True, True);
end;

procedure TfrmPai.pSQLTrace(Sender: TObject);
  Var
    strSenha: String;
begin
  If (objTrace.GetAutenticado()) Then
  Begin
    btnPausarTrace.Click();
    pFinalizarSQLTrace();
  End
  // Não está efetuando trace, então começa efetuar
  Else
  Begin
    if (not objTrace.GetAutenticado()) then
    begin
      ffrmSenha(strSenha, 'Início de SQL Trace');

      If strSenha <> SEN_CNF Then
        Exit;
    end;

    pIniTraceForms();
    btnIniciarSQLTrace.Click();
  End;
end;

procedure TfrmPai.pFinalizar;
begin
  btnHideTrace.Click;
  btnHideTrace.Visible := False;

  btnShowTrace.Visible := False;

  tmrSQLTrace.Enabled := (False);

  objTracePai.SetAutenticado(False);
end;

procedure TfrmPai.pIniTraceForms;
begin
  btnShowTrace.Width := 16;
  btnShowTrace.BringToFront;
  btnShowTrace.Click;

  btnHideTrace.Width := 16;
  btnHideTrace.BringToFront;

  tmrSQLTrace.OnTimer := tmrSQLTraceOnTimer;
  tmrSQLTrace.Enabled := (True);

  objTracePai := objTrace;
  pAtualizaControls();
end;

end.
