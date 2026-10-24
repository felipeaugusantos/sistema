unit untRcxCancFechamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, Menus, AppEvnts, BitBtnLockedIncrem,
  untRcxTResumoDeCaixa, frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxCancFechamento = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    Label1: TLabel;
    edtSenRes: TEditFocus;
    Label2: TLabel;
    mskDtaFec: TMaskEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    dtaDtaFec: TDateTime;
    blnConfirma: Boolean;
end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmRcxCancFechamento }

function TfrmRcxCancFechamento.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = edtSenRes) Then
  Begin

    If (edtSenRes.Text <> fCfgSis('SENRES')) Then
    Begin
      fMensagem('', 'Senha incorreta!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      mskDtaFec.Text := DateToStr(dtaDtaFec);
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmRcxCancFechamento.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmRcxCancFechamento.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxCancFechamento.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

end.

