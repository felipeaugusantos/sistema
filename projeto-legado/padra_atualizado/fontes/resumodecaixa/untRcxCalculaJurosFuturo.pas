unit untRcxCalculaJurosFuturo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, AppEvnts, BitBtnLockedIncrem, Mask, MaskEditFocus, dxScreenTip,
  cxClasses, dxCustomHint, cxHint, frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxCalculaJurosFuturo = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label6: TLabel;
    edtPerJur: TEditFocus;
    btnConfirma: TBitBtnLocked;
    lblJuroam: TLabel;
    mskDtaFin: TMaskEditFocus;
    lbl1: TLabel;
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

var
  frmRcxCalculaJurosFuturo: TfrmRcxCalculaJurosFuturo;

implementation

uses  untFuncoesSimples;

{$R *.dfm}

procedure TfrmRcxCalculaJurosFuturo.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxCalculaJurosFuturo.edtPerJurEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + edtPerJur.Left + edtPerJur.Width,
                         15 + Self.Top + edtPerJur.Top + edtPerJur.Height, strTitJuros, edtPerJur.Hint);

end;

procedure TfrmRcxCalculaJurosFuturo.edtPerJurExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmRcxCalculaJurosFuturo.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (Not fVerificaCampos) Then
    Exit;

  blnConfirma := True;
  Close;
end;

procedure TfrmRcxCalculaJurosFuturo.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskDtaFin);
end;

procedure TfrmRcxCalculaJurosFuturo.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma    := False;
  edtPerJur.Text := FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 2);
  edtPerMul.Text := FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 2);
end;

function TfrmRcxCalculaJurosFuturo.fValidaCampos(Sender: TWinControl;
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
  Else If (Sender = mskDtaFin) Then
  begin

    If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Or (Not fValidaDataStr(mskDtaFin.Text)) Then
    Begin
      fMensagem('', 'Data Final não é válida!', ['&O k']);
      pSetFocus(mskDtaFin);
      Result := False;
    end
    Else If StrToDate(mskDtaFin.Text) < VS_Date Then
    Begin
      pMensagemOk('A Data Final deve ser maior ou igual a data atual!');
      pSetFocus(mskDtaFin);
      Result := False;
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

