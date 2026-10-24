unit untBaixaDigTelecheque;

interface

uses
  Windows, Classes, Controls, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, EditFocus, Mask, MaskEditFocus, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmBaixaDigTelecheque = class(TfrmPaiSimples)
    pnlFundo: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    mskDtaEnv: TMaskEditFocus;
    edtCodTel: TEditFocus;
    pnlConfirma: TPanel;
    btnConfirmaDados: TBitBtnLocked;
    btnCancelaDados: TBitBtnLocked;
    procedure btnCancelaDadosClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma : Boolean;
    strCodTel   : String;
    dtaDtaEnv   : TDateTime;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses SysUtils, Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmBaixaDigTelecheque }

procedure TfrmBaixaDigTelecheque.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaDigTelecheque.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    strCodTel   := edtCodTel.Text;
    dtaDtaEnv   := StrToDate(mskDtaEnv.Text);
    Close;
  End;
end;

function TfrmBaixaDigTelecheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = mskDtaEnv) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(mskDtaEnv.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Envio deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodTel) Then
    Begin

      If fEmptyStr(edtCodTel.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End;

  End;
  If Not Result Then
    pSetFocus(Sender);
end;

end.
