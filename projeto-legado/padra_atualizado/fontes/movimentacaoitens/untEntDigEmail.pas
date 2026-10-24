unit untEntDigEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, EditFocus;

type
  TfrmEntDigEmail = class(TfrmPai)
    btnConfirma: TBitBtn;
    pnlCentral: TPanel;
    Label1: TLabel;
    edtEmail: TEditFocus;
    Label2: TLabel;
    edtContato: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmEntDigEmail: TfrmEntDigEmail;

implementation

uses untFuncoes, untfuncoesSimples;

{$R *.dfm}

{ TfrmEntDigEmail }

function TfrmEntDigEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtEmail) Then
  Begin
    If (Not fEmptyStr(edtEmail.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O email deve ser preenchido!', ['mbOk']);
      Result := False;
    End
    Else If (Pos('@', edtEmail.Text) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', edtEmail.Text + ' não é um email válido!', ['mbOk']);
      Result := False;
    End;
  End

  Else If (Sender = edtContato) Then
  Begin
    If (Not fEmptyStr(edtContato.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O contato deve ser preenchido!', ['mbOk']);
      Result := False;
    End
  End;

end;

procedure TfrmEntDigEmail.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

end.

