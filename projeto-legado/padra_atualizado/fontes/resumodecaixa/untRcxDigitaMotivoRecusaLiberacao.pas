unit untRcxDigitaMotivoRecusaLiberacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus;

type
  TfrmRcxDigitaMotivoRecusaLiberacao = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblPortador: TLabel;
    edtMotivoRecusa: TEditFocus;
    lblDescricao: TLabel;
    lblValor: TLabel;
    lblModalidade: TLabel;
    lblModalidadeDescricao: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    FModalidade: String;

    FValor: Double;
    { Private declarations }
  public
    property Modalidade: String read FModalidade write FModalidade;
    property Valor: Double read FValor write FValor;
    { Public declarations }
  end;

var
  frmRcxDigitaMotivoRecusaLiberacao: TfrmRcxDigitaMotivoRecusaLiberacao;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmRcxDigitaMotivoRecusaLiberacao.btnConfirmaClick(Sender: TObject);
begin
  If Trim(edtMotivoRecusa.Text).IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário digitar o Motivo da Recusa.', ['&Ok']);
    pSetFocus(edtMotivoRecusa);
    Exit;
  End;

  inherited;
  Self.Close;

  ModalResult := mrOk;
end;

procedure TfrmRcxDigitaMotivoRecusaLiberacao.btnSairClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TfrmRcxDigitaMotivoRecusaLiberacao.FormShow(Sender: TObject);
begin
  inherited;
  lblModalidadeDescricao.Caption := FModalidade;
  lblValor.Caption := FormatFloat(',0.00', FValor);

  pSetFocus(edtMotivoRecusa);
end;

end.
