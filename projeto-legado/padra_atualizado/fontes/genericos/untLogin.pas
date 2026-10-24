unit untLogin;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untPai, Buttons, ExtCtrls, EditFocus, Menus, Uni, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, Login.View.Interfaces;

type
  TfrmLogin = class(TfrmPai)
    pnlDados: TPanel;
    Label1: TLabel;
    edtLogin: TEditFocus;
    edtSenha: TEditFocus;
    Label2: TLabel;
    edtNomOpe: TEditFocus;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    edtDesEmpresa: TEditFocus;
    btnLogin: TBitBtnLocked;
    procedure btnLoginClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pMensagemErroUsuario(AMsg: String);
    procedure pMensagemErroEmpresa(AMsg: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    objLogin: ILogin;
  end;


implementation

uses  untfuncoesSimples, untConstantes, DB, StrUtils, untTHorOpe, untTLogin;

{$R *.dfm}

procedure TfrmLogin.pMensagemErroEmpresa(AMsg: String);
begin
  blnMudarFoco := False;
  pSetFocus(edtCodEmpresa);
  pMensagemOk(AMsg);
end;

procedure TfrmLogin.pMensagemErroUsuario(AMsg: String);
begin
  edtSenha.Clear;
  pSetFocus(edtLogin);
  pMensagemOk(AMsg);
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos() Then
    Exit;

  Try
    edtLogin.Text := Trim(edtLogin.Text);
    edtCodEmpresa.Text := Trim(edtCodEmpresa.Text);

    objLogin.SetUsuario(edtLogin.Text);
    objLogin.SetPassword(edtSenha.Text);
    objLogin.SetEmpresa(edtCodEmpresa.Text);

    blnConfirma := objLogin.ExecutarLogin();

    objLogin.SetUtilizaModoClassico(edtLogin.Text, True);

    If blnConfirma Then
      Self.Close;
  Except
    On E: ELoginEmpresaException Do
      pMensagemErroEmpresa(E.Message);

    On E: ELoginUsuarioException Do
      pMensagemErroUsuario(E.Message);

    On E: Exception Do
      Raise;
  End;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;

  If Not fEmptyStr(objLogin.EmpresaDefault) Then
  Begin
    edtCodEmpresa.Enabled := False;
    edtCodEmpresa.Text    := objLogin.EmpresaDefault;
    edtDesEmpresa.Text    := fRetNomeEmpresa(edtCodEmpresa.Text);
  End;

  pSetFocus(edtLogin);
end;

function TfrmLogin.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If Sender = edtLogin Then
    Begin
      objLogin.SetUsuario(edtLogin.Text);
      edtNomOpe.Text := objLogin.NomeUsuario;

      objLogin.ValidarUsuario();

      If (Length(objLogin.EmpresasLoginUsuario) = 4) And edtCodEmpresa.Enabled Then
      Begin
        pSetaEmpresaLogada(LeftStr(objLogin.EmpresasLoginUsuario,3));
        edtCodEmpresa.Enabled := False;
        edtCodEmpresa.Text    := VS_strCodEmp;
        edtDesEmpresa.Text    := fRetNomeEmpresa(edtCodEmpresa.Text);
      End;
    End;

    If Sender = edtSenha Then
    Begin
      objLogin.SetPassword(edtSenha.Text);
    End;

    If Sender = edtCodEmpresa Then
    Begin
      edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
      objLogin.SetEmpresa(edtCodEmpresa.Text);
      objLogin.ValidarEmpresa();
    End;

  Except
    On E: ELoginUsuarioException Do
    Begin
      Result := False;
      pMensagemErroUsuario(E.Message);
    End;

    On E: ELoginEmpresaException Do
    Begin
      Result := False;
      pMensagemErroEmpresa(E.Message);
    End;

    On E: Exception Do
      Raise;
  End;

  If Not Result Then
    psetFocus(Sender);
end;

procedure TfrmLogin.edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fEntraCons(Key) And objLogin.SelecionarEmpresa(edtLogin.Text) Then
  Begin
    edtCodEmpresa.Text := objLogin.Empresa;
    edtDesEmpresa.Text := fRetNomeEmpresa(edtCodEmpresa.Text);
  End;
end;

end.


