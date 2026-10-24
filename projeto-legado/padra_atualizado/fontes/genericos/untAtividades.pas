unit untAtividades;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus;

type
  TfrmAtividades = class(TfrmPaiSimples)
    pnlGeral: TPanel;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    edtCodAti: TEditFocus;
    lblAtividade: TLabel;
    edtDesAti: TEditFocus;
    procedure edtCodAtiKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAtiExit(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

uses
  untTypesSistema, untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmAtividades.btnCancelaDadosClick(Sender: TObject);
begin
  edtCodAti.Clear;
  edtDesAti.Clear;
  inherited;
  Close;
end;

procedure TfrmAtividades.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  if (fEmptyStr(edtDesAti.Text)) then
  begin
    edtCodAti.Clear;
  end;
  Close;
end;

procedure TfrmAtividades.edtCodAtiExit(Sender: TObject);
begin
  inherited;
  if (not fEmptyStr(edtCodAti.Text)) then
  begin
    edtDesAti.Text := fRetNomAtividade(edtCodAti.Text);
  end;
end;

procedure TfrmAtividades.edtCodAtiKeyPress(Sender: TObject; var Key: Char);
Var
  arrAtiv: TConsultasArray;
begin
  inherited;
  If fPesqAtividade(Self, edtCodAti, edtDesAti, Nil, Key, arrAtiv) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;
end;

end.
