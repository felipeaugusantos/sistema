unit untDigTicketEstacionamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, untFuncoes, untFuncoesSimples;

type
  TfrmDigTicketEstacionamento = class(TForm)
    pnlFundo: TPanel;
    pnlBottom: TPanel;
    lblCodTicket: TLabel;
    edtCodTicket: TEditFocus;
    btnCancelar: TBitBtnLocked;
    btnConfirmar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodTicketChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmDigTicketEstacionamento.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigTicketEstacionamento.btnConfirmarClick(Sender: TObject);
begin
  If (fMensagem('', 'Confirma digitação de ticket ' + edtCodTicket.Text + '?', ['&Sim', '&Não'], 1) = 1) Then
    ModalResult := mrOk;
end;

procedure TfrmDigTicketEstacionamento.edtCodTicketChange(Sender: TObject);
begin
  btnConfirmar.Enabled := (Not fEmptyStr(Trim(edtCodTicket.Text)));
end;

procedure TfrmDigTicketEstacionamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If (ModalResult = mrOk) Then
    Exit;

  If (fMensagem('', 'Cancelar digitação de ticket?', ['&Sim', '&Não'], 1) = 2) Then
  Begin
    Action := CaNone;
    ModalResult := mrNone;
    Exit;
  End;

  edtCodTicket.Text := '';
  ModalResult := mrCancel;
end;

procedure TfrmDigTicketEstacionamento.FormCreate(Sender: TObject);
begin
  btnConfirmar.Enabled := False;
  pSetFocus(edtCodTicket);
end;

procedure TfrmDigTicketEstacionamento.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: Close;
    VK_RETURN: SelectNext(ActiveControl, True, True);
  End;
end;

end.
