unit untCtrSelecionaTipoEstornoPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons;

Type
  TTipoEstornoPix = (tpeCredito, tpeDevolucao, tpeNenhum);

type
  TfrmCtrSelecionaTipoEstornoPix = class(TfrmPai)
    pnlFundo: TPanel;
    btnDevolucao: TcxButton;
    btnCredito: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDevolucaoClick(Sender: TObject);
    procedure btnCreditoClick(Sender: TObject);
  private
    { Private declarations }
  public
    TipoEstorno: TTipoEstornoPix;
    { Public declarations }
  end;

var
  frmCtrSelecionaTipoEstornoPix: TfrmCtrSelecionaTipoEstornoPix;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmCtrSelecionaTipoEstornoPix.btnCreditoClick(Sender: TObject);
begin
  inherited;
  TipoEstorno := tpeCredito;
  Self.Close;
end;

procedure TfrmCtrSelecionaTipoEstornoPix.btnDevolucaoClick(Sender: TObject);
begin
  inherited;
  TipoEstorno := tpeDevolucao;
  Self.Close;
end;

procedure TfrmCtrSelecionaTipoEstornoPix.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if TipoEstorno = tpeNenhum then
    Action := caNone;
end;

procedure TfrmCtrSelecionaTipoEstornoPix.FormCreate(Sender: TObject);
begin
  inherited;
  TipoEstorno := tpeNenhum;
end;

procedure TfrmCtrSelecionaTipoEstornoPix.FormShow(Sender: TObject);
begin
  inherited;
  Self.Height := Self.Height - pnlBotoes.Height - pnlStatus.Height;

  pSetFocus(btnDevolucao);
end;

end.
