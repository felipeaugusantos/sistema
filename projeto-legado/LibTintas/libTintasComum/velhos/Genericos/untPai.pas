unit untPai;

interface

uses
  Forms, AppEvnts, StdCtrls, BitBtnLockedIncrem, Classes, Controls, ExtCtrls,
  Windows, ComCtrls, SysUtils ,Buttons, Grids, DBGridCitel, DBGrids;

type
  TfrmPai = class(TForm)
    pnlBotoes: TPanel;
    pnlStatus: TPanel;
    pnlNomeForm: TPanel;
    pnlInfo: TPanel;
    ApplicationEvents: TApplicationEvents;
    btnSair: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    intSemaforoKeyDown: Integer;    
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



{$R *.dfm}

procedure TfrmPai.FormCreate(Sender: TObject);
var
  intContador: Integer;
begin
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
    End;
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


