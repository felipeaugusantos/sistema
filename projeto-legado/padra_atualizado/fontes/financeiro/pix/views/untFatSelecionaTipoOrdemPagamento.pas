unit untFatSelecionaTipoOrdemPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons;

Type
  TTipoOrdemPagamento = (tpoPix, tpoTransferencia, tpoNenhum);

type
  TfrmFatSelecionaTipoOrdemPagamento = class(TfrmPai)
    pnlFundo: TPanel;
    btnQRCodePix: TcxButton;
    btnDeposito: TcxButton;
    chkPixAvulso: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnQRCodePixClick(Sender: TObject);
    procedure btnDepositoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    TipoPagamento: TTipoOrdemPagamento;
    { Public declarations }
  end;

var
  frmFatSelecionaTipoOrdemPagamento: TfrmFatSelecionaTipoOrdemPagamento;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmFatSelecionaTipoOrdemPagamento.btnDepositoClick(Sender: TObject);
begin
  inherited;
  TipoPagamento := tpoTransferencia;
  Self.Close;
end;

procedure TfrmFatSelecionaTipoOrdemPagamento.btnQRCodePixClick(Sender: TObject);
begin
  inherited;
  TipoPagamento := tpoPix;
  chkPixAvulso.Checked := False;
  Self.Close;
end;

procedure TfrmFatSelecionaTipoOrdemPagamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if TipoPagamento = tpoNenhum then
    Action := caNone;
end;

procedure TfrmFatSelecionaTipoOrdemPagamento.FormCreate(Sender: TObject);
begin
  inherited;
  TipoPagamento := tpoNenhum;
end;

procedure TfrmFatSelecionaTipoOrdemPagamento.FormShow(Sender: TObject);
begin
  inherited;
  Self.Height := Self.Height - pnlBotoes.Height - pnlStatus.Height;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
  Begin
    Self.Height := Self.Height + 5;
    Self.Width := Self.Width + 7;
  End;

  pSetFocus(btnQRCodePix);
end;

end.
