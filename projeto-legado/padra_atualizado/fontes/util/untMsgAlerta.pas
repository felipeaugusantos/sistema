unit untMsgAlerta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmMsgAlerta = class(TForm)
    pnlMsgAlerta: TPanel;
    lblMsgAlerta: TLabel;
    tmrWait: TTimer;
    procedure lblMsgAlertaClick(Sender: TObject);
    procedure tmrWaitTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intPos: Integer;
  end;

var
  frmMsgAlerta: TfrmMsgAlerta;

implementation

uses untCadMsg, untFuncoesSimples, untPrincipal;

{$R *.dfm}

procedure TfrmMsgAlerta.FormCreate(Sender: TObject);
begin
  If (intPos = 1) Then
  Begin
    Left := Screen.Width - Width - 1;
    Top  := 0;
  End;
end;

procedure TfrmMsgAlerta.lblMsgAlertaClick(Sender: TObject);
  Var
    frmMsg: TfrmCadMsg;
begin
  Self.Close;
  frmPrincipal.tmrTemMsg.Enabled   := False;
  Try
    pCriarFormularios(TfrmCadMsg, frmMsg);
    frmMsg.tmrTemMsg   := frmPrincipal.tmrTemMsg;
    frmMsg.Tag         := 1;
    frmMsg.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Criar Formulário de Mensagens]');
      Exit;
    End;
  End;
  pFreeAndNil(frmMsg);
  frmPrincipal.tmrTemMsg.Enabled   := True;
end;

procedure TfrmMsgAlerta.tmrWaitTimer(Sender: TObject);
begin
  Close;
end;

end.
