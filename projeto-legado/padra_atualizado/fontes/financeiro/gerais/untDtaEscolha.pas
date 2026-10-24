unit untDtaEscolha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons;

type
  TOpcValor = (opData1, opData2, opNone);

  TfrmDtaEscolha = class(TfrmPai)
    pnlFundo: TPanel;
    btnData1: TcxButton;
    btnData2: TcxButton;
    procedure btnData1Click(Sender: TObject);
    procedure btnData2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    opcValor: TOpcValor;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDtaEscolha.btnData2Click(Sender: TObject);
begin
  inherited;
  opcValor := opData2;
  Close;
end;

procedure TfrmDtaEscolha.btnData1Click(Sender: TObject);
begin
  inherited;
  opcValor := opData1;
  Close;
end;

procedure TfrmDtaEscolha.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnData1);

end;

procedure TfrmDtaEscolha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  if opcValor = opNone then
    Action := caNone;

end;

procedure TfrmDtaEscolha.FormCreate(Sender: TObject);
begin
  inherited;
  opcValor := opNone;
end;

end.
