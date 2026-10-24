unit untCfgSenhasSistema;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus;

type
  TfrmCfgSenhasSistema = class(TfrmPai)
    pnlCentral: TPanel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label130: TLabel;
    Label139: TLabel;
    Label142: TLabel;
    edtSenha1: TEditFocus;
    edtSenha2: TEditFocus;
    edtSenha3: TEditFocus;
    edtExcCx2: TEditFocus;
    edtSenGlo: TEditFocus;
    edtSenRip: TEditFocus;
    btnGravar: TBitBtn;
    Label1: TLabel;
    edtSeRiNF: TEditFocus;
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pGravaArqIni;
    procedure pCarregaArqIni;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCfgSenhasSistema: TfrmCfgSenhasSistema;

implementation

uses untFuncoes, untfuncoesSimples, untModulo;

{$R *.dfm}

{ TfrmCfgSenhasSistema }

function TfrmCfgSenhasSistema.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtSenha1) Or
     (Sender = edtSenha2) Or
     (Sender = edtSenha3) Or
     (Sender = edtExcCx2) Or
     (Sender = edtSenGlo) Or
     (Sender = edtSenRip) Then
  Begin

    If fEmptyStr((Sender As TEditFocus).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Todas as senhas devem ser preenchidas!', ['&Ok']);
      Result := False;
    End
    Else If (edtSenha1.Text = edtSenha2.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'A Senha 1 deve ser diferente da Senha 2!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    Sender.SetFocus;

end;

procedure TfrmCfgSenhasSistema.pCarregaArqIni;
begin
  {*****************************************}
  {* SENHAS DO SISTEMA                     *}
  {**************************************MV*}
  edtSenha1.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENHA1').AsString;
  edtSenha2.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENHA2').AsString;
  edtSenha3.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENHA3').AsString;
  edtExcCx2.Text := frmModulo.qryCadCfg.FieldByName('CFG_EXCCX2').AsString;
  edtSenGlo.Text := frmModulo.qryCadCfg.FieldByName('CFG_SEND02').AsString;
  edtSenRip.Text := frmModulo.qryCadCfg.FieldByName('CFG_SENRIP').AsString;
  edtSeRiNF.Text := frmModulo.qryCadCfg.FieldByName('CFG_SERINF').AsString;
end;

procedure TfrmCfgSenhasSistema.pGravaArqIni;
begin
  {*****************************************}
  {* SENHAS DO SISTEMA                     *}
  {**************************************MV*}
  frmModulo.qryCadCfg.FieldByName('CFG_SENHA1').AsString := edtSenha1.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENHA2').AsString := edtSenha2.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENHA3').AsString := edtSenha3.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_EXCCX2').AsString := edtExcCx2.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SEND02').AsString := edtSenGlo.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SENRIP').AsString := edtSenRip.Text;
  frmModulo.qryCadCfg.FieldByName('CFG_SERINF').AsString := edtSeRiNF.Text;
end;

procedure TfrmCfgSenhasSistema.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravaArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmCfgSenhasSistema.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaArqIni;
end;

initialization
  RegisterClass(TfrmCfgSenhasSistema);
finalization
  UnRegisterClass(TfrmCfgSenhasSistema);

end.

