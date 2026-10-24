unit untMemo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmMemo = class(TForm)
    cxMemo: TcxMemo;
    procedure cxMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    class procedure pShowMessage(strMensag: String; intTamFonte: Integer = 11; blnNegrito: Boolean = True; intWidth: Integer = 0; intHeight: Integer = 0; AblnScrollBar: Boolean = False); Overload;
    class procedure pShowMessage(stlMensag: TStrings; intTamFonte: Integer = 11; blnNegrito: Boolean = True; intWidth: Integer = 0; intHeight: Integer = 0; AblnScrollBar: Boolean = False); Overload;
  end;

var
  frmMemo: TfrmMemo;

implementation

{$R *.dfm}

procedure TfrmMemo.cxMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_Escape Then
    Close;

end;

class procedure TfrmMemo.pShowMessage(strMensag: String; intTamFonte: Integer = 11; blnNegrito: Boolean = True; intWidth: Integer = 0; intHeight: Integer = 0; AblnScrollBar: Boolean = False);
  Var
    frmMemoUnique: TfrmMemo;
begin
  frmMemoUnique := TfrmMemo.Create(Application);
  Try
    frmMemoUnique.cxMemo.Style.Font.Size := intTamFonte;

    If blnNegrito Then
      frmMemoUnique.cxMemo.Style.Font.Style := [fsBold]
    Else
      frmMemoUnique.cxMemo.Style.Font.Style := [];

    If intWidth > 0 Then
      frmMemoUnique.Width := intWidth;

    If intHeight > 0 Then
      frmMemoUnique.Height := intHeight;

    if AblnScrollBar then
      frmMemoUnique.cxMemo.Properties.ScrollBars := ssVertical ;

    frmMemoUnique.cxMemo.Lines.Add(strMensag);
    frmMemoUnique.ShowModal;
  Finally
    FreeAndNil(frmMemoUnique);
  End;
end;

class procedure TfrmMemo.pShowMessage(stlMensag: TStrings; intTamFonte: Integer = 11; blnNegrito: Boolean = True; intWidth: Integer = 0; intHeight: Integer = 0; AblnScrollBar: Boolean = False);
  Var
    strMensag: PChar;
begin
  strMensag := stlMensag.GetText;
  Try
    pShowMessage(strMensag, intTamFonte, blnNegrito, intWidth, intHeight, AblnScrollBar);
  Finally
    StrDispose(strMensag);
  End;
end;

end.

