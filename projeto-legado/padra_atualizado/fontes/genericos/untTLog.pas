unit untTLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untFuncoesSimples, System.UItypes;

type
  TfrmLog = class(TForm)
    memLog: TMemo;
    procedure memLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    procedure pAddLinha(strLinha: string);

    class procedure pShowLog(strCaption: String; strConteudo: TStringList; AWidth: integer = 1024; AHeight: integer = 768; AScrollBars: TScrollStyle =ssBoth);
    { Public declarations }

  end;

var
  frmLog: TfrmLog;

implementation

{$R *.dfm}

{ TForm2 }

procedure TfrmLog.memLogKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (ssCtrl in Shift) and (Key = 65) Then
    memLog.SelectAll;
  If Key = VK_ESCAPE Then
    Close;

end;

procedure TfrmLog.pAddLinha(strLinha: string);
begin
  If strLinha <> ''  Then
    memLog.Lines.Add(strLinha)
end;

class procedure TfrmLog.pShowLog(strCaption: String; strConteudo: TStringList; AWidth: integer = 1024; AHeight: integer = 768; AScrollBars: TScrollStyle =ssBoth);
begin
  pCriarFormularios(TfrmLog, frmLog);
  Try
    frmlog.Width := AWidth;
    frmlog.Height:= AHeight;
    frmlog.memLog.ScrollBars := AScrollBars;
    frmLog.Caption := strCaption;
    frmLog.memLog.Text := strConteudo.Text;
    frmLog.Showmodal;
  Finally
    FreeAndNil(frmLog);
  End;


end;

end.
