unit untOpcPoupupRadio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untPai;

type
  TfrmOpcPoupupRadio = class(TfrmPai)
    rdgOpc: TRadioGroup;
    BitBtnLocked1: TBitBtnLocked;
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
  public
    blnConfirma : Boolean;
    { Public declarations }
    class function fRetOpcPopup(AOpcoes: Array of String; ADefaultIndex: Integer = 0; ACaption: String = ''): integer;
  end;

var
  frmOpcPoupupRadio: TfrmOpcPoupupRadio;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmOpcPoupupRadio }

procedure TfrmOpcPoupupRadio.BitBtnLocked1Click(Sender: TObject);
begin
  blnConfirma := True;
  inherited;

end;

class function TfrmOpcPoupupRadio.fRetOpcPopup(
  AOpcoes: array of String; ADefaultIndex: Integer = 0; ACaption: String = ''): integer;
var i: integer;
    maxWidth: integer;
begin
  pCriarFormularios(TfrmOpcPoupupRadio, frmOpcPoupupRadio);
  maxWidth := 250;
  Try
    for i := 0 To High(AOpcoes) do
    Begin
      frmOpcPoupupRadio.rdgOpc.Items.Add(AOpcoes[i]);
      If maxWidth <  frmOpcPoupupRadio.Canvas.TextWidth(AOpcoes[i]) Then
        maxWidth := frmOpcPoupupRadio.Canvas.TextWidth(AOpcoes[i]);
    End;
    If Not fEmptyStr(ACaption) Then
      If maxWidth < frmOpcPoupupRadio.Canvas.TextWidth(ACaption) Then
        maxWidth := frmOpcPoupupRadio.Canvas.TextWidth(ACaption) + 20;
    frmOpcPoupupRadio.Width := maxWidth;
    frmOpcPoupupRadio.rdgOpc.ItemIndex :=  ADefaultIndex;
    If Not fEmptyStr(ACaption) Then
      frmOpcPoupupRadio.rdgOpc.Caption := ACaption;
    frmOpcPoupupRadio.Height := 80 + (frmOpcPoupupRadio.rdgOpc.Items.Count * 22);
    Result := -1;
    frmOpcPoupupRadio.blnConfirma := False;
    frmOpcPoupupRadio.Showmodal;
    If frmOpcPoupupRadio.blnConfirma Then
      Result := frmOpcPoupupRadio.rdgOpc.ItemIndex;
  Finally
    FreeAndNil(frmOpcPoupupRadio);
  End;

end;

end.

