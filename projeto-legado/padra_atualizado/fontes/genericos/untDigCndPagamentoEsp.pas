unit untDigCndPagamentoEsp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Data.DB, untDigCndPagamentoFrame;

type
  TfrmDigCndPagamentoEsp = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    fraDigCndPagamento: TfraDigCndPagamento;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    class procedure pExibe(Var strCodCnd: String; Var strCndPag: String; Var strForPag: String; Var strForPagDes: String; Var blnConfirmaCndPag: Boolean);
  end;

var
  frmDigCndPagamentoEsp: TfrmDigCndPagamentoEsp;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmDigCndPagamentoEsp.btnCancelaDadosClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmDigCndPagamentoEsp.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fraDigCndPagamento.fConfirmaDados And fVerificaCampos Then
  Begin
    fraDigCndPagamento.blnConfirma := True;
    Close;
  End
  Else
    fraDigCndPagamento.blnConfirma := False;
end;

procedure TfrmDigCndPagamentoEsp.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  fraDigCndPagamento.OnFormClose(Sender, Action);
end;

procedure TfrmDigCndPagamentoEsp.FormCreate(Sender: TObject);
begin
  inherited;
  fraDigCndPagamento.OnFormCreate(Sender);
end;

procedure TfrmDigCndPagamentoEsp.FormShow(Sender: TObject);
begin
  inherited;
  fraDigCndPagamento.OnFormShow(Sender);
end;

function TfrmDigCndPagamentoEsp.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Result := fraDigCndPagamento.fValidaCampos(Sender, blnBuscaPorChave);
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

class procedure TfrmDigCndPagamentoEsp.pExibe(Var strCodCnd, strCndPag, strForPag,
  strForPagDes: String; Var blnConfirmaCndPag: Boolean);
  Var
    frmDigCndPagamentoEsp : TfrmDigCndPagamentoEsp;
begin
  pCriarFormularios(TfrmDigCndPagamentoEsp, frmDigCndPagamentoEsp);
  Try
    frmDigCndPagamentoEsp.fraDigCndPagamento.edtCodCnd.Text    := strCodCnd;
    frmDigCndPagamentoEsp.fraDigCndPagamento.mskCndPag.Text    := strCndPag;
    frmDigCndPagamentoEsp.fraDigCndPagamento.edtForPag.Text    := strForPag;
    frmDigCndPagamentoEsp.fraDigCndPagamento.edtDesForPag.Text := strForPagDes;

    frmDigCndPagamentoEsp.ShowModal;

    if frmDigCndPagamentoEsp.fraDigCndPagamento.blnConfirma then
    Begin
      strCodCnd    := frmDigCndPagamentoEsp.fraDigCndPagamento.edtCodCnd.Text;
      strCndPag    := frmDigCndPagamentoEsp.fraDigCndPagamento.mskCndPag.Text;
      strForPag    := frmDigCndPagamentoEsp.fraDigCndPagamento.edtForPag.Text;
      strForPagDes := frmDigCndPagamentoEsp.fraDigCndPagamento.edtDesForPag.Text;
      blnConfirmaCndPag := True;
    End
    Else
      blnConfirmaCndPag := False;

  Finally
    FreeAndNil(frmDigCndPagamentoEsp);
  End;
end;

end.


