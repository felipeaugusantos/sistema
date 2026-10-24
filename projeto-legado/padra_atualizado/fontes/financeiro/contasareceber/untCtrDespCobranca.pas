unit untCtrDespCobranca;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCtrDespCobranca = class(TfrmPai)
    pnlDados: TPanel;
    Label6: TLabel;
    edtDespCob: TEditFocus;
    Label1: TLabel;
    edtAplDesp: TEditFocus;
    ColorLabel1: TColorLabel;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmCtrDespCobranca }

function TfrmCtrDespCobranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtDespCob) Then
  Begin
    If fStrToFloat(edtDespCob.Text) < 0 Then
    Begin
      pMensagemOk('O Valor das despesas de cobrança não pode ser negativo!');
      Result := False;
    End;
  End

  Else If (Sender = edtAplDesp) Then
  Begin
    If (Pos(edtAplDesp.Text, 'TD') <= 0) Then
    Begin
      pMensagemOk('Informe um valor válido (T ou D)!');
      Result := False;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCtrDespCobranca.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmCtrDespCobranca.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  pSetFocus(edtDespCob);
end;

end.

