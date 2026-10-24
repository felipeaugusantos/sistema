unit untCtrSelecionaOpcaoDuplicataComPix;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons;

Type
  TOpcaoDuplicataPix = (tpoReceberPix, tpoEmail, tpoNenhuma);

type
  TfrmCtrSelecionaOpcaoDuplicataComPix = class(TfrmPai)
    pnlFundo: TPanel;
    btnQRCodePix: TcxButton;
    btnReenviarEmail: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnQRCodePixClick(Sender: TObject);
    procedure btnReenviarEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    OpcaoSelecionada: TOpcaoDuplicataPix;
    { Public declarations }
  end;

var
  frmCtrSelecionaOpcaoDuplicataComPix: TfrmCtrSelecionaOpcaoDuplicataComPix;

implementation
Uses untFuncoesSimples;
{$R *.dfm}

procedure TfrmCtrSelecionaOpcaoDuplicataComPix.btnQRCodePixClick(
  Sender: TObject);
begin
  inherited;
  OpcaoSelecionada := tpoReceberPix;
  Self.Close;
end;

procedure TfrmCtrSelecionaOpcaoDuplicataComPix.btnReenviarEmailClick(
  Sender: TObject);
begin
  inherited;
  OpcaoSelecionada := tpoEmail;
  Self.Close;
end;

procedure TfrmCtrSelecionaOpcaoDuplicataComPix.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if OpcaoSelecionada = tpoNenhuma then
    Action := caNone;
end;

procedure TfrmCtrSelecionaOpcaoDuplicataComPix.FormCreate(Sender: TObject);
begin
  inherited;
  OpcaoSelecionada := tpoNenhuma;
end;

procedure TfrmCtrSelecionaOpcaoDuplicataComPix.FormShow(Sender: TObject);
begin
  inherited;
  Self.Height := Self.Height - pnlBotoes.Height - pnlStatus.Height;

  pSetFocus(btnQRCodePix);
end;

end.
