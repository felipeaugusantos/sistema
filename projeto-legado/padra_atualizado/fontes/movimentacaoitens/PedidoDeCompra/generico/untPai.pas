unit untPai;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Menus, StdCtrls, Buttons, Controls,
  ExtCtrls, {QTypes,} Graphics, Forms, Dialogs, ComCtrls, DBCtrls, DBEditFocus,
  {Qt,} EditFocus, DBGridCitel, DBGrids, Grids, DBComboBoxFocus, ComboBoxFocus, MaskEditFocus, Uni, DB,
  Mask, ToolEdit, FilenameEditFocus, DirectoryEditFocus, AppEvnts, Messages,
  CurrencyEditFocus, 
  untFrameDirectoryEditFocus;

type
  TfrmPai = class(TForm)
    pnlBotoes: TPanel;
    btnSair: TBitBtn;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    mnuAuxiliar: TPopupMenu;
    mnuConfigurarRel: TMenuItem;
    ApplicationEvents: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuConfigurarRelClick(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    stlCampos: TStringList;
    stlCamInd: TStringList;
    stlDesInd: TStringList;
    qryTabela: TUniQuery;
    blnLibCnf: Boolean;
    strSenha : String;

    procedure pOnKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;
    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word;
      Shift: TShiftState); virtual;

    procedure pProximoControle(Sender: TObject);
    procedure pEscapePressed; virtual;


    //*************************************************//
    // FUNCOES ESPECIFICAS PARA O AUTBAN               //
    //**********************************************ED*//
    procedure pCarKeyAutBan;
    procedure pOnKeyDownAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pOnKeyDownEditsAutBan(Sender: TObject; var Key: Word; Shift: TShiftState); virtual;
    procedure pCriaFormCfgAtb(strNomCam: String);

    {*******************************************}
    {* FUNÇÕES DE VALIDAÇÃO!                   *}
    {****************************************MV*}
    function fVerificaCampos: Boolean;
    function fValidaPanel(pnlPanel: TPanel; blnBuscaPorChave: Boolean = False): Boolean;
    function fVerificaSubObjeto(objObjeto: TWinControl): Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; virtual;

  public
    { Public declarations }
    blnMudarFoco: Boolean;
    procedure pHabilitaCodigo(dbeCampoEnable, dbeCampoFocus: TDBEdit;
      blnHabilitar: Boolean);
  end;

var
  frmPai: TfrmPai;

implementation

uses untfuncoesSimples, untCadConfRelatorios, untModuloCfgRel;

{$R *.dfm}

procedure TfrmPai.FormCreate(Sender: TObject);
  Var
    intContador: Integer;
begin

  If Not Assigned(utcRegistros) Then
    utcRegistros := TUltConsultas.Create;

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
    If (Self.Components[intContador] Is TDBEditFocus) Then
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

    Else If (Self.Components[intContador] Is TEditFocus) Then
    Begin
      (Self.Components[intContador] As TEditFocus).OnKeyDown := pOnKeyDownEdits;
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

    Else If (Self.Components[intContador] Is TCurrencyEditFocus) Then
    Begin
      If (Self.Components[intContador] As TCurrencyEditFocus).Tag = 99 Then
        (Self.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDownEdits
      Else
        (Self.Components[intContador] As TCurrencyEditFocus).OnKeyDown := pOnKeyDown;
    End;

  End;

end;

procedure TfrmPai.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPai.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) Then
  Begin
    If (ActiveControl Is TBitBtn) Then
    Begin
      pEscapePressed;
    End;
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
    dbeCampoFocus.SetFocus;
end;

procedure TfrmPai.mnuConfigurarRelClick(Sender: TObject);
begin
  Try
    Application.CreateForm(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.blnConfigurar := True;
    frmCadConfRelatorios.strNomeForm   := Self.Name;
    frmCadConfRelatorios.showModal;
  Finally
    pFreeAndNil(frmCadConfRelatorios);
  End;
  frmModuloCfgRel.pCarregaConfImpr(Self.Name);
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
              fMensagem('Aviso', E.Message, ['&Ok']);
              pGravarErro(True, E.Message + ' - ' + (objObjeto.Components[intContador] As TWinControl).Name);
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
  Close;
end;

procedure TfrmPai.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;

{*****************************************}
{* FUNÇÃO QUE É ATRIBUIDA NO EVENTO      *}
{* 'OnKeyDown' DOS Edits. (continua...)  *}
{**************************************MV*}
procedure TfrmPai.pOnKeyDownEdits(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If (Key = VK_Return) Then
  Begin
    pProximoControle(Sender);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
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

procedure TfrmPai.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
  var i: SmallInt;
begin

  if (ActiveControl is TDBGridCitel) then
  begin
    with TDBGridCitel(ActiveControl) do
    begin
      if Msg.message = WM_MOUSEWHEEL then
      begin
        Msg.message := WM_KEYDOWN;
        Msg.lParam := 0;
        i := HiWord(Msg.wParam);
        if i > 0 then
          Msg.wParam := VK_UP
        else
          Msg.wParam := VK_DOWN;
        Handled := False;
      end;
    end;
  end;

end;

procedure TfrmPai.FormShow(Sender: TObject);
begin

  SetForegroundWindow(Self.Handle);

end;

end.

