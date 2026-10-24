unit untPai;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, StdCtrls, Buttons, Controls,
  ExtCtrls, Graphics, Forms, Dialogs, ComCtrls, DBCtrls, DBEditFocus, TypInfo,
  EditFocus, DBGridCitel, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus,
  Uni, DB, Mask, FilenameEditFocus, DirectoryEditFocus, AppEvnts, cxGridCitel,
  cxControls, cxContainer, cxLookAndFeels,
  Messages, CurrencyEditFocus, untFuncoesGenerica, untLabelRg, untLabelCgcCpf,
  untMskC_G_C_, untMskTelefone, untLabelCgc, untLabelCpf, untDBECgcCpf,
  untDBETipoCgcCpf, untEditTipoCgcCpf, BitBtnLockedIncrem, DBLookupComboBoxFocus,
  ShellAPI, frxClass, frxExportCSVTestabilidade, DateUtils, cxCheckBox, untTypesSistema,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, frxExportPDF, untFrameDirectoryEditFocus;

type
  TfrmPai = class(TForm)
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
    procedure btnIniciarTraceClick(Sender: TObject);
    procedure btnPausarTraceClick(Sender: TObject);
    procedure btnSalvarTraceClick(Sender: TObject);
    procedure btnViewerTraceClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FPais: TPais;
    FOriginalCaption: String;
    FPrimeiraVez: Boolean;
    procedure pSetarQueryTraceViewerEvents;
    procedure pSetCxControlsScrollbarModeClassic(AWinControl: TWinControl);
    function fDataMuitoAntiga(Sender: TObject): Boolean;
    procedure pIniTraceForms;
    procedure pAtualizaControlsTrace;
    procedure pFinalizarSQLTrace;
  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryTabela: TUniQuery;
    qryCfgRel: TUniQuery;
    blnLibCnf: Boolean;
    strSenha : String;
    blnValidaDataMuitoAntiga: Boolean;
    blnValidarComTAB: Boolean;

    intSemaforoKeyDown: Integer;

    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;

    procedure pProximoControle(Sender: TObject); virtual;
    procedure pEscapePressed; virtual;

    //*************************************************//
    // FUNCOES ESPECIFICAS PARA O AUTBAN               //
    //**********************************************ED*//
    procedure pCarKeyAutBan;
    procedure pOnKeyDownAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEditsAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pCriaFormCfgAtb(strNomCam: String);

    procedure pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
      E: Exception);

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False; blnStopOnError : Boolean = True): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fVerificaSubControl(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

    function HandleCreateException: Boolean; override;

    procedure pSelNext;

    procedure pSetaEventos(SelfWin: TWinControl);

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

    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus; blnHabilitar: Boolean); overload;
    procedure pHabilitaCodigo(dbeCampoEnable: TDBEdit; dbeCampoFocus: TWinControl; blnHabilitar: Boolean); overload;
    procedure pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);

  published
    property OriginalCaption: String Read FOriginalCaption;

  end;

var
  frmPai: TfrmPai;

implementation

uses untConstantes, untfuncoesSimples, {untCfgAtb, {untCadConfRelatorios,} cxCalendar,
  cxDbEdit, untTSQLTrace;

{$R *.dfm}

procedure TfrmPai.FormActivate(Sender: TObject);
begin
  If (Assigned(VS_Trace)) and (VS_Trace.GetAutenticado()) And (Assigned(VS_objTraceViewer)) Then
    pIniTraceForms;

  If FPrimeiraVez Then
  Begin
    If Assigned(untFuncoesSimples.VS_objTraceViewer) And untFuncoesSimples.VS_objTraceViewer.Visible Then
    Begin
      untFuncoesSimples.VS_objTraceViewer.Show;
      SetForegroundWindow(Self.Handle);
    End;
  End;

  FPrimeiraVez := False;
end;

procedure TfrmPai.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//
end;

procedure TfrmPai.FormCreate(Sender: TObject);
begin
  FPrimeiraVez := True;

  pSetarQueryTraceViewerEvents;

  pSetCxControlsScrollbarModeClassic(Self);

  blnValidaDataMuitoAntiga := True;
  blnValidarComTAB := False;

  strFilRel := '';

  If (Not fEmptyStr(VS_strCodEmp)) Then
    FPais := fSetaPais;

  {For intContador := 0 To Self.ComponentCount -1 Do
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
    End;

  End;}

  intSemaforoKeyDown := -1;

  blnFecharComEscape := True;

  blnFecharFormPai := False;

  qryCfgRel := fCriaQuery(Self);

  If Not Assigned(utcRegistros) Then
    utcRegistros := TUltConsultas.Create;

  {*****************************************}
  {* PARA NAO DEIXAR O FORM AUMENTAR       *}
  {**************************************MV*}

  pnlNomeForm.Caption := Self.Name;
  blnMudarFoco := True;

  pSetaEventos(Self);

  FOriginalCaption := Self.Caption;

End;

procedure TfrmPai.pSetaEventos(SelfWin: TWinControl);
  Var
    intContador: Integer;
Begin

  {*****************************************}
  {* ATRIBUI OS METODOS REFERENTES AO      *}
  {* EVENTO 'OnKeyDown' DOS COMPONENTES    *}
  {**************************************MV*}
  For intContador := 0 To SelfWin.ComponentCount -1 Do
  Begin

    If (SelfWin.Components[intContador] Is TLabelRg) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelRg(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelRg(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCgcCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgcCpf(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgcCpf(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCgc) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCgc(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCgc(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TLabelCpf) Then
    Begin
      If (FPais = opcBrasil) Then
        TLabelCpf(SelfWin.Components[intContador]).pSetaPais(opcBrasil)
      Else
        TLabelCpf(SelfWin.Components[intContador]).pSetaPais(opcParaguai);
    End

    Else If (SelfWin.Components[intContador] Is TDBEditCgcCpf) And (Not fPodeValidarCgcCpf(FPais)) Then
    Begin
      TDBEditCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditCgcCpf(SelfWin.Components[intContador]).Tag := 0
    End

    Else If (SelfWin.Components[intContador] Is TDBEditTipoCgcCpf) Then
    Begin
      TDBEditTipoCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Visible) Then
        TDBEditTipoCgcCpf(SelfWin.Components[intContador]).Tag := 0;
    End

    Else If (SelfWin.Components[intContador] Is TEditTipoCgcCpf) Then
    Begin
      TEditTipoCgcCpf(SelfWin.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
      TEditTipoCgcCpf(SelfWin.Components[intContador]).Visible   := fMostraTipoCgcCpf(FPais);

      If (Not TEditTipoCgcCpf(SelfWin.Components[intContador]).Visible) Then
        TEditTipoCgcCpf(SelfWin.Components[intContador]).Tag := 0;
    End

    Else If (SelfWin.Components[intContador] Is TDBEditFocus) Then
    Begin
      (SelfWin.Components[intContador] As TDBEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TDBCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TDBCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TcxCheckBox) Then
    Begin
      (SelfWin.Components[intContador] As TcxCheckBox).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TRadioButton) Then
    Begin
      (SelfWin.Components[intContador] As TRadioButton).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TDBComboBoxFocus) Then
    Begin
      (SelfWin.Components[intContador] As TDBComboBox).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TDBLookupComboBox) Then
      TDBLookupComboBox(SelfWin.Components[intContador]).OnKeyDOwn := pOnKeyDownEdits

    Else If (SelfWin.Components[intContador] Is TEditFocus) Then
    Begin
      (SelfWin.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
    End

    Else If (SelfWin.Components[intContador] Is TMaskEditTelefone) Then
    Begin
      TMaskEditTelefone(SelfWin.Components[intContador]).pSetTelefo(FPais);

      If (SelfWin.Components[intContador] As TMaskEditTelefone).Tag = 99 Then
        (SelfWin.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TMaskEditTelefone).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TMaskEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TMaskEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TMaskEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TFilenameEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TFilenameEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TfraDirectoryEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TfraDirectoryEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TComboBoxFocus) Then
    Begin

      If (SelfWin.Components[intContador] As TComboBoxFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TComboBoxFocus).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxDateEdit) Then
    Begin
      (SelfWin.Components[intContador] As TcxDateEdit).ParentFont := False;
      If (SelfWin.Components[intContador] As TcxDateEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDateEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxDBMaskEdit) Then
    Begin

      If (SelfWin.Components[intContador] As TcxDBMaskEdit).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxDBMaskEdit).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TcxComboBox) Then
    Begin

      If (SelfWin.Components[intContador] As TcxComboBox).Tag = 99 Then
        (SelfWin.Components[intContador] As TcxComboBox).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TcxComboBox).OnKeyDown := pOnKeyDown;

    End

    Else If (SelfWin.Components[intContador] Is TCurrencyEditFocus) Then
    Begin
      If (SelfWin.Components[intContador] As TCurrencyEditFocus).Tag = 99 Then
        (SelfWin.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (SelfWin.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
    End

    Else If (SelfWin.Components[intContador] Is TDBGridCitel) Then
    Begin
      TDBGridCitel(SelfWin.Components[intContador]).DrawingStyle := gdsClassic;
    End

    Else If (SelfWin.Components[intContador] Is TcxGridDBTableViewCitel) Then
    Begin
      TcxGridDBTableViewCitel(SelfWin.Components[intContador]).CorZebra := fCfgSis('CORZEB', varInteger);
    End

    Else If (SelfWin.Components[intContador] Is TcxGridDBBandedTableViewCitel) Then
    Begin
      TcxGridDBTableViewCitel(SelfWin.Components[intContador]).CorZebra := fCfgSis('CORZEB', varInteger);
    End

    Else If (SelfWin.Components[intContador] Is TfrxReport) Then
    Begin
      TfrxReport(SelfWin.Components[intContador]).PreviewOptions.Buttons :=
      TfrxReport(SelfWin.Components[intContador]).PreviewOptions.Buttons - [pbSave, pbLoad, pbEdit];
    End

    Else If (SelfWin.Components[intContador] Is TfrxPDFExport) Then
    Begin
      TfrxPDFExport(SelfWin.Components[intContador]).EmbeddedFonts         := True;
      TfrxPDFExport(SelfWin.Components[intContador]).EmbedFontsIfProtected := True;
      TfrxPDFExport(SelfWin.Components[intContador]).ExportNotPrintable    := True;
    End

    Else If (SelfWin.Components[intContador] Is TBitBtnLocked) Then
    Begin
      If Not Assigned(TBitBtnLocked(SelfWin.Components[intContador]).OnErro) Then
        TBitBtnLocked(SelfWin.Components[intContador]).OnErro := pOnBitBtnErro;
    End

    Else If (SelfWin.Components[intContador] Is TFrame) Then
      pSetaEventos(TFrame(SelfWin.Components[intContador]));
  End;

end;

procedure TfrmPai.pSetarQueryTraceViewerEvents;
Var
  I: Integer;
begin
  If Assigned(untFuncoesSimples.VS_objTraceViewer) Then
    For I := 0 To Self.ComponentCount -1 Do
      If Self.Components[I] Is TUniQuery Then
        untFuncoesSimples.VS_objTraceViewer.SetQueryEvents(TUniQuery(Self.Components[I]));
end;

type
  TcxControlHack = class(TcxControl);
  TcxContainerHack = class(TcxContainer);
procedure TfrmPai.pSetCxControlsScrollbarModeClassic(AWinControl: TWinControl);
Var
  I: Integer;
begin
  For I := 0 To AWinControl.ControlCount -1 Do
  Begin
    If AWinControl.Controls[I] Is TcxControl Then
      TcxControlHack(AWinControl.Controls[I]).LookAndFeel.ScrollbarMode := sbmClassic;
    If AWinControl.Controls[I] Is TcxContainer Then
      TcxContainerHack(AWinControl.Controls[I]).Style.LookAndFeel.ScrollbarMode := sbmClassic;
    If AWinControl.Controls[I] Is TWinControl Then
      pSetCxControlsScrollbarModeClassic(TWinControl(AWinControl.Controls[I]));
  End;
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

procedure TfrmPai.pOnBitBtnErro(Sender: TWinControl; strMsgErro: string;
  E: Exception);
begin
  inherited;
  Raise Exception.Create(E.Message);
end;

function TfrmPai.fDataMuitoAntiga(Sender: TObject): Boolean;
  Var
    mskData: TMaskEditFocus;
begin
  Result := False;
  Try
    If Sender.ClassNameIs('TMaskEditFocus') And blnValidaDataMuitoAntiga Then
    Begin
      mskData := TMaskEditFocus(Sender);
      If (mskData.ValidaData) And
         (StrToDate(mskData.Text) < IncYear(VS_Date, -1)) Then
      Begin
        Result := fMensagem('', 'Data inferior a ' + DateToStr(IncYear(VS_Date, -1)) + ' (1 ano). Deseja continuar?',
          ['&Sim', '&Não']) = 2;
      End;
    End;
  Except
    //
  End;
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
    Close;
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

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TEditFocus;
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

procedure TfrmPai.pHabilitaCodigo(dbeCampoEnable:TDBEdit;
  dbeCampoFocus: TWinControl; blnHabilitar: Boolean);
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
{  Try
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
  pFreeAndNil(frmCadConfRelatorios);    }
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
  blnBuscaPorChave: Boolean; blnStopOnError : Boolean): Boolean;
  Var
    intContador: Integer;
    blnResult  : Boolean;
begin
  blnResult := True;
  Result    := True;

  For intContador := 0 To pnlPanel.ControlCount -1 Do
  Begin

    If pnlPanel.Controls[intContador].Tag = 99 Then
      Result := fValidaCampos(TWinControl(pnlPanel.Controls[intContador]), blnBuscaPorChave);

    If blnStopOnError Then
    Begin
      If Not Result Then
        Break;
    End
    Else
      If Not Result Then
        blnResult := False;
  End;

  If not blnStopOnError Then
    Result := blnResult;

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
       (objObjeto.Components[intContador] Is TFrame)     Or
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
        //(objObjeto.Components[intContador] As TTabSheet).PageControl.ActivePage := (objObjeto.Components[intContador] As TTabSheet);
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
       (objObjeto.Controls[intContador] Is TFrame)     Or
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

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If InterlockedIncrement(intSemaforoKeyDown) = 0 Then
  Begin
    Try
      If (Key = VK_Return) Then
      Begin
        If Not fDataMuitoAntiga(Sender) Then
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
        If Not fDataMuitoAntiga(Sender) Then
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

procedure TfrmPai.pCarKeyAutBan;
  Var
    intContador : Integer;

Begin

  For intContador := 0 To Self.ComponentCount -1 Do
  Begin

    If (Self.Components[intContador] Is TEditFocus) Then
    Begin
      (Self.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEditsAutBan;
    End

    Else If (Self.Components[intContador] Is TFilenameEditFocus) Then
    Begin
      If (Self.Components[intContador] As TFilenameEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownEditsAutBan
      Else
        (Self.Components[intContador] As TFilenameEditFocus).OnKeyDown := pOnKeyDownAutBan;
    End

    Else If (Self.Components[intContador] Is TfraDirectoryEditFocus) Then
    Begin
      If (Self.Components[intContador] As TfraDirectoryEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDownEditsAutBan
      Else
        (Self.Components[intContador] As TfraDirectoryEditFocus).edtDirectory.OnKeyDown := pOnKeyDownAutBan;
    End;

  End;


End;



procedure TfrmPai.pOnKeyDownAutBan(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End
  Else If (Key = VK_F1) Then
  Begin
    pCriaFormCfgAtb(ActiveControl.Name);
  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf       := False;
      pnlBotoes.Color := clGray;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf       := True;
          pnlBotoes.Color := clNavy;
        End;
      End;
    End;
  End;

end;

procedure TfrmPai.pOnKeyDownEditsAutBan(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End
  Else If (Key = VK_F1) Then
  Begin
    pCriaFormCfgAtb(ActiveControl.Name);
  End
  Else If (Shift = [ssShift]) And (Key = VK_F7) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf       := False;
      pnlBotoes.Color := clGray;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf       := True;
          pnlBotoes.Color := clNavy;
        End;
      End;
    End;
  End;

end;

procedure TfrmPai.pCriaFormCfgAtb(strNomCam: String);
begin
{
  Try
    pCriarFormularios(tfrmCfgAtb, frmCfgAtb);
    frmCfgAtb.strNomCam := strNomCam;
    frmCfgAtb.strNomFor := Self.Name;
    frmCfgAtb.blnCfgAtb := blnLibCnf;
    frmCfgAtb.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmPai.pCriaFormCfgAtb]');
    End;
  End;
  pFreeAndNil(frmCfgAtb);
    }
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

procedure TfrmPai.pSQLTrace(Sender: TObject; blnAuth: Boolean = False; blnCabecalho: Boolean = False);
  Var
    strSenha: String;
begin
  If (Assigned(VS_Trace)) And (VS_Trace.GetAutenticado()) Then
  Begin
    btnPausarTrace.Click();
    pFinalizarSQLTrace;
  End
  // Não está efetuando trace, então começa efetuar
  Else
  Begin
    VS_Trace := TSQLTrace.Create();
    VS_Trace.Autenticado := blnAuth;
    VS_Trace.Cabecalho := blnCabecalho;

    if (not VS_Trace.GetAutenticado()) then
    begin
      ffrmSenha(strSenha, 'Início de SQL Trace');

      If strSenha <> SEN_CNF Then
      begin
      ///  FreeAndNil(VS_Trace);
        Exit;
      end;
    end;

    If (blnAuth) Then
    Begin
      objTracePai := VS_Trace;
      objTracePai.pIniciaTrace();
    End
    Else
    Begin
      pIniTraceForms();
      btnIniciarTrace.Click();
    End;
  End;

  VS_objTraceViewer.SetSQLTrace(VS_Trace);
end;

procedure TfrmPai.pAtualizaControlsTrace;
begin
  btnIniciarTrace.Width  := IIF(objTracePai.Status = stPausado , 23, 0);
  btnPausarTrace.Width   := IIF(objTracePai.Status = stIniciado, 23, 0);
  btnViewerTrace.Width   := IIF(Assigned(VS_objTraceViewer)    , 23, 0);
  btnSalvarTrace.Enabled := True;
end;

procedure TfrmPai.pFinalizarSQLTrace;
begin
  pnlBotoesTrace.Visible := False;
  pnlBotoesTrace.Width   := 0;
  objTracePai.SetAutenticado(False);
end;

procedure TfrmPai.pIniTraceForms;
begin
  pnlBotoesTrace.Visible := True;
  pnlBotoesTrace.Width   := 70;
  objTracePai            := VS_Trace;
  pAtualizaControlsTrace();
  VS_objTraceViewer.SetSQLTrace(VS_Trace);
end;

end.

