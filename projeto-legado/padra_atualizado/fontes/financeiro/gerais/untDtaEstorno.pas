unit untDtaEstorno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons;

type
  TOpcValor = (opDtaEstorno, opDtaBaixa, opNone);

  TfrmDtaEstorno = class(TfrmPai)
    pnlFundo: TPanel;
    btnDtaEst: TcxButton;
    btnDtaBai: TcxButton;
    procedure btnDtaEstClick(Sender: TObject);
    procedure btnDtaBaiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    opcValor: TOpcValor;
  end;

var
  frmDtaEstorno: TfrmDtaEstorno;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDtaEstorno.btnDtaBaiClick(Sender: TObject);
begin
  inherited;
  opcValor := opDtaBaixa;
  Close;
end;

procedure TfrmDtaEstorno.btnDtaEstClick(Sender: TObject);
begin
  inherited;
  opcValor := opDtaEstorno;
  Close;
end;

procedure TfrmDtaEstorno.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnDtaEst);

end;

procedure TfrmDtaEstorno.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if opcValor = opNone then
    Action := caNone;

end;

procedure TfrmDtaEstorno.FormCreate(Sender: TObject);
begin
  inherited;
  opcValor := opNone;
end;

end.
