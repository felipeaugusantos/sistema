unit untDigEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigEmail = class(TfrmPai)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtEmail: TEditFocus;
    Label2: TLabel;
    edtContato: TEditFocus;
    btnConfirma: TBitBtnLocked;
    chkAnexar: TCheckBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmDigEmail: TfrmDigEmail;

implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmEntDigEmail }

procedure TfrmDigEmail.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtEmail);

end;

function TfrmDigEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) Then
  Begin
    If (fEmptyStr(edtEmail.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (Pos('@', edtEmail.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = edtContato) And edtContato.Visible  Then
  Begin
    If (fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
  End;

end;

procedure TfrmDigEmail.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos)                                       And
     (fMensagem('', 'Enviar e-mail?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

