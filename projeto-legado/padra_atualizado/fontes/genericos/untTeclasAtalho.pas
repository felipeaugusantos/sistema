unit untTeclasAtalho;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo, ExtCtrls;

type
  TfrmTeclasAtalho = class(TForm)
    Panel1: TPanel;
    cxMemo: TcxMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTeclasAtalho: TfrmTeclasAtalho;

implementation

{$R *.dfm}

procedure TfrmTeclasAtalho.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_Escape Then
    Close;

end;

end.
