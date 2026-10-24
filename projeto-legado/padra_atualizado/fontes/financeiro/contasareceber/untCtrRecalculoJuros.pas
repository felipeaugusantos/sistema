unit untCtrRecalculoJuros;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, Menus, Buttons, ExtCtrls,
  QColorLabel, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCtrRecalculoJuros = class(TfrmPai)
    pnlDados: TPanel;
    Label6: TLabel;
    edtPerJur: TEditFocus;
    lblAplicar: TLabel;
    edtAplJur: TEditFocus;
    ColorLabel1: TColorLabel;
    btnConfirma: TBitBtnLocked;
    edtPerMul: TEditFocus;
    lblPerMul: TLabel;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    blnPerMulta: Boolean;
  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

{ TfrmCtrRecalculoJuros }

function TfrmCtrRecalculoJuros.fValidaCampos(Sender: TWinControl;
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

  Else If (Sender = edtPerMul) And edtPerMul.Visible Then
  Begin
    If (Not fEmptyStr(edtPerMul.Text)) Then
    Begin
      Result := fValidaEscala(edtPerMul.Text, 0, 99);
    End;
  End

  Else If (Sender = edtAplJur) Then
  Begin

    If (Pos(edtAplJur.Text, 'TD') <= 0) Then
      Result := False;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCtrRecalculoJuros.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  Close;
end;

procedure TfrmCtrRecalculoJuros.FormCreate(Sender: TObject);
begin
  inherited;
  edtPerJur.Text := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  edtPerMul.Text := FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 2);
  blnConfirma := False;
  blnPerMulta := False;
  pSetFocus(edtPerJur);
end;

procedure TfrmCtrRecalculoJuros.FormShow(Sender: TObject);
begin
  inherited;
  If Not blnPerMulta Then
  Begin
    lblAplicar.Caption := 'Aplicar Juros:';
    edtPerMul.Text     := '0,00';
    edtPerMul.Visible  := False;
    lblPerMul.Visible  := False;
    Self.ClientHeight  := Self.ClientHeight - edtPerMul.Height;
  End
  Else
    lblAplicar.Caption := 'Aplicar Juros/Multa:';
end;

end.

