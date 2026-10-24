unit untFatRomaneioBuscaChaveDeAcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatRomaneioBuscaChaveDeAcesso = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lblInfo: TLabel;
    edtCodReg: TEdit;
    btnFinalizar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodRegKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strChaveAcessoDig :String;
  end;

var
  frmFatRomaneioBuscaChaveDeAcesso: TfrmFatRomaneioBuscaChaveDeAcesso;

implementation

{$R *.dfm}

procedure TfrmFatRomaneioBuscaChaveDeAcesso.btnFinalizarClick(Sender: TObject);
begin
  strChaveAcessoDig := '#27';
  Close;
end;

procedure TfrmFatRomaneioBuscaChaveDeAcesso.edtCodRegKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = VK_RETURN Then
  Begin
    If edtCodReg.Text = '' Then
      strChaveAcessoDig := '#'

    Else
      strChaveAcessoDig := edtCodReg.Text;

    Close;
  End;
end;

procedure TfrmFatRomaneioBuscaChaveDeAcesso.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If strChaveAcessoDig = '' Then
    strChaveAcessoDig := '#27';

  edtCodReg.Clear;
end;

procedure TfrmFatRomaneioBuscaChaveDeAcesso.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) Or (Key = VK_F10) Then
    btnFinalizar.Click
end;

procedure TfrmFatRomaneioBuscaChaveDeAcesso.FormShow(Sender: TObject);
begin
  strChaveAcessoDig := '';
end;

end.
