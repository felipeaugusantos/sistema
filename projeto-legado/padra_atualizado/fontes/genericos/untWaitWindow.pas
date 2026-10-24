unit untWaitWindow;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmWaitWindow = class(TForm)
    pnlWait: TPanel;
    lblTexto: TLabel;
    tmrWait: TTimer;
    procedure tmrWaitTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    intPosicao: Integer;
  end;

var
  frmWaitWindow: TfrmWaitWindow;

implementation

{$R *.dfm}

procedure TfrmWaitWindow.tmrWaitTimer(Sender: TObject);
begin
  Close;
end;

procedure TfrmWaitWindow.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrmWaitWindow.FormCreate(Sender: TObject);
begin
  If intPosicao = 1 Then
  Begin
    Left := Screen.Width - Width - 1;
    Top  := 0;
  End;
end;

end.
