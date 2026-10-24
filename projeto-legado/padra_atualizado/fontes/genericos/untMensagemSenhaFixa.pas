unit untMensagemSenhaFixa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, StdCtrls,
  Buttons, BitBtnLockedIncrem, ExtCtrls;

type
  TfrmMensagemSenhaFixa = class(TForm)
    cxMemo: TcxMemo;
    pnlRodape: TPanel;
    btnSair: TBitBtnLocked;
    procedure cxMemoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure pCloseOnEscape(Key: Word);
  public
    class procedure pShowMessage(strMensag: String; intTamFonte: Integer = 11); Overload;
    class procedure pShowMessage(stlMensag: TStrings; intTamFonte: Integer = 11); Overload;
    class procedure pShowMessage(strMensag, strCaption: String; intTamFonte: Integer = 11; strFonte: String = 'Courier New'; blnBordaSimples: Boolean = False); Overload;
  end;

var
  frmMensagemSenhaFixa: TfrmMensagemSenhaFixa;

implementation

{$R *.dfm}

procedure TfrmMensagemSenhaFixa.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMensagemSenhaFixa.cxMemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  pCloseOnEscape(Key);
end;

procedure TfrmMensagemSenhaFixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  pCloseOnEscape(Key);
end;

class procedure TfrmMensagemSenhaFixa.pShowMessage(strMensag: String; intTamFonte: Integer = 11);
  Var
    frmMemoUnique: TfrmMensagemSenhaFixa;
begin
  frmMemoUnique := TfrmMensagemSenhaFixa.Create(Application);
  Try
    frmMemoUnique.cxMemo.Style.Font.Size := intTamFonte;
    frmMemoUnique.cxMemo.Lines.Add(strMensag);
    frmMemoUnique.ShowModal;
  Finally
    FreeAndNil(frmMemoUnique);
  End;
end;

procedure TfrmMensagemSenhaFixa.pCloseOnEscape(Key: Word);
begin
  If Key = VK_Escape Then
    Close;
end;

class procedure TfrmMensagemSenhaFixa.pShowMessage(strMensag, strCaption: String;
  intTamFonte: Integer; strFonte: String; blnBordaSimples: Boolean);
  Var
    frmMemoUnique: TfrmMensagemSenhaFixa;
begin
  frmMemoUnique := TfrmMensagemSenhaFixa.Create(Application);
  Try
    If (blnBordaSimples) Then Begin
      frmMemoUnique.Caption     := strCaption;
      frmMemoUnique.BorderStyle := bsSingle;
    End;

    frmMemoUnique.cxMemo.Style.Font.Size := intTamFonte;
    frmMemoUnique.cxMemo.Style.Font.Name := strFonte;
    frmMemoUnique.cxMemo.Lines.Add(strMensag);
    frmMemoUnique.ShowModal;
  Finally
    FreeAndNil(frmMemoUnique);
  End;
end;

class procedure TfrmMensagemSenhaFixa.pShowMessage(stlMensag: TStrings; intTamFonte: Integer = 11);
  Var
    strMensag: PChar;
begin
  strMensag := stlMensag.GetText;
  Try
    pShowMessage(strMensag, intTamFonte);
  Finally
    StrDispose(strMensag);
  End;
end;

end.
