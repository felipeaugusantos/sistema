unit untPai;

interface

uses
  Forms, AppEvnts, StdCtrls, BitBtnLockedIncrem, Classes, Controls, ExtCtrls,
  Windows, ComCtrls, SysUtils ,Buttons, Grids, DBGridCitel, DBGrids, frxClass,
  cxControls, cxGroupBox, cxCustomListBox, cxCheckListBox, Uni,
  TypInfo, Graphics, cxContainer, cxLookAndFeels,
  Vcl.Themes,
  Vcl.Styles,
  Vcl.SysStyles, // to gain access to TSysPopupStyleHook
  frxExportCSVTestabilidade, Vcl.Menus;

type
  TfrmPai = class(TForm)
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    ApplicationEvents: TApplicationEvents;
    btnSair: TBitBtnLocked;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    frxCSVExportTestabilidade: TfrxCSVExportTestabilidade;
    FlwBotoes: TFlowPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    intSemaforoKeyDown: Integer;
    FPrimeiraVez: Boolean;
    procedure pSetarTema();
    procedure pDesligarTemaBotoes;
    procedure pAjustarTema(AParent: TWinControl);
    function fVersaoSistema(): String;
    procedure pSetarQueryTraceViewerEvents;
    procedure pSetCxControlsScrollbarModeClassic(AWinControl: TWinControl);

  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    blnLibCnf: Boolean;
    strSenha : String;

    procedure pOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;

    procedure pOnBitBtnErro(Sender: TWinControl; strMsgErro: string; E: Exception);

    procedure pProximoControle(Sender: TObject);
    procedure pEscapePressed; virtual;

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

    function HandleCreateException: Boolean; override;

  public
    { Public declarations }
    blnMudarFoco: Boolean;
    blnFecharComEscape: Boolean;
  end;

  TWinControlHelper = class(TWinControl);

var
  frmPai: TfrmPai;

implementation

uses
  untAutcomTintaFactory;

Const
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

{$R *.dfm}

procedure TfrmPai.FormActivate(Sender: TObject);
begin
  If Not TAutcomTintaFactory.Get.GetUsuarioUtilizaTemaClassico Then
    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      pAjustarTema(Self);

  If Not TAutcomTintaFactory.Get.GetUsuarioUtilizaTemaClassico Then
    Self.Repaint;

  If Not String(Caption).Contains(fVersaoSistema()) Then
    Caption := Caption + '   -   ' + fVersaoSistema();

  If FPrimeiraVez Then
  Begin
    If Assigned(TAutcomTintaFactory.Get.GetObjTraceViewer) And TAutcomTintaFactory.Get.GetObjTraceViewer.Visible Then
    Begin
      TAutcomTintaFactory.Get.GetObjTraceViewer.Show;
      SetForegroundWindow(Self.Handle);
    End;
  End;

  FPrimeiraVez := False;
end;

function TfrmPai.fVersaoSistema: String;
begin
  Result := TAutcomTintaFactory.Get.GetTituloVersao + ' - Emp: ' + TAutcomTintaFactory.Get.GetCodEmp;
end;

procedure TfrmPai.pSetarTema;
begin
  If Not TAutcomTintaFactory.Get.GetUsuarioUtilizaTemaClassico Then
  Begin
    Try
      TStyleManager.TrySetStyle(AUTCOM_STYLE_NAME);

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

procedure TfrmPai.pSetarQueryTraceViewerEvents;
Var
  I: Integer;
begin
  If Assigned(TAutcomTintaFactory.Get.GetObjTraceViewer) Then
    For I := 0 To Self.ComponentCount -1 Do
      If Self.Components[I] Is TUniQuery Then
        TAutcomTintaFactory.Get.GetObjTraceViewer.SetQueryEvents(TUniQuery(Self.Components[I]));
end;

procedure TfrmPai.pDesligarTemaBotoes;
Var
  I: Integer;
begin
  For I := 0 To Self.ComponentCount -1 Do
    If Self.Components[I] Is TBitBtn Then
      TBitBtn(Self.Components[I]).StyleElements := [];
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

procedure TfrmPai.FormCreate(Sender: TObject);
var
  intContador: Integer;
begin
  FPrimeiraVez := True;

  pDesligarTemaBotoes;

  pSetarQueryTraceViewerEvents;

  pSetCxControlsScrollbarModeClassic(Self);

  If Not TAutcomTintaFactory.Get.GetUsuarioUtilizaTemaClassico Then
  Begin
    If TStyleManager.ActiveStyle.Name <> AUTCOM_STYLE_NAME Then
      pSetarTema();

    If TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME Then
      If Self.Position = poMainFormCenter Then
        Self.Position := poDesktopCenter;
  End;

  intSemaforoKeyDown := -1;        

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
    If (Self.Components[intContador] Is TWinControl) Then
    Begin
      TWinControlHelper(Self.Components[intContador]).OnKeyDown := pOnKeyDownEdits;
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
  End;

  blnFecharComEscape := True;
end;

procedure TfrmPai.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPai.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_Escape: Begin
                 If (ActiveControl Is TBitBtnLocked) Then
                 Begin
                   pEscapePressed;
                 End;
               End;
    VK_F1    : Begin
                 If Assigned(ActiveControl) Then
                  TAutcomTintaFactory.Get.pAjudaAutcom(Handle, ActiveControl.HelpContext);
               End;
  End;
end;

function TfrmPai.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
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
							TAutcomTintaFactory.Get.pMensagensErro(E.Message,'[TfrmPai.fVerificaSubObjeto]');
              TAutcomTintaFactory.Get.pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Components[intContador] As TWinControl).Name);
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
  Raise E;
end;

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
procedure TfrmPai.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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

procedure TfrmPai.FormShow(Sender: TObject);
begin
  SetForegroundWindow(Self.Handle);
end;

function TfrmPai.HandleCreateException: Boolean;
begin
  Result := False;
end;

end.


