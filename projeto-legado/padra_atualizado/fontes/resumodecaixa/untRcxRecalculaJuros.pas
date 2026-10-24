unit untRcxRecalculaJuros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade,
  dxScreenTip, cxClasses, dxCustomHint, cxHint;

type
  TfrmRcxRecalculaJuros = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label6: TLabel;
    edtPerJur: TEditFocus;
    btnConfirma: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    Label1: TLabel;
    edtPerMul: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtPerJurEnter(Sender: TObject);
    procedure edtPerJurExit(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strTitJuros: String;
    blnConfirma: Boolean;
  end;


implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmRcxRecalculaJuros.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxRecalculaJuros.edtPerJurEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtPerJur.Left + edtPerJur.Width,
                         15 + Self.Top + edtPerJur.Top + edtPerJur.Height, strTitJuros, edtPerJur.Hint);
end;

procedure TfrmRcxRecalculaJuros.edtPerJurExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmRcxRecalculaJuros.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Then
    Exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmRcxRecalculaJuros.FormActivate(Sender: TObject);
begin
  inherited;
   pSetFocus(edtPerJur);
end;

procedure TfrmRcxRecalculaJuros.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma    := False;
  edtPerJur.Text := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  edtPerMul.Text := FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 2);
end;

function TfrmRcxRecalculaJuros.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtPerJur) Then
  Begin
    If (Not fEmptyStr(edtPerJur.Text)) Then
    Begin
      Result := fValidaEscala(edtPerJur.Text, 0, 99);
    End;

  End
  Else
  If (Sender = edtPerMul) Then
  Begin
    If (Not fEmptyStr(edtPerMul.Text)) Then
    Begin
      Result := fValidaEscala(edtPerJur.Text, 0, 99);
    End;
  End;

end;

end.

