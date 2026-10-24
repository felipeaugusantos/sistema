unit untSelIcon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, Vcl.ExtCtrls, Vcl.StdCtrls, clipbrd, Vcl.Buttons,
  BitBtnLockedIncrem, untTypesSistema;

type
  TfrmSelIcon = class(TForm)
    webBrowser: TTMSFNCWebBrowser;
    Panel1: TPanel;
    Label1: TLabel;
    Timer1: TTimer;
    Edit1: TEdit;
    btnConfirma: TBitBtnLocked;
    procedure Timer1Timer(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strPaste : String;

    class function Execute(const AUrl: string): string;
  end;

var
  frmSelIcon: TfrmSelIcon;

implementation

{$R *.dfm}

procedure TfrmSelIcon.btnConfirmaClick(Sender: TObject);
begin
  close;
  modalResult := mrOk;
end;

class function TfrmSelIcon.Execute(const AUrl: string): string;
var
  frmSelecionar: TfrmSelIcon;
begin
  Result := EmptyStr;
  Application.CreateForm(TfrmSelIcon, frmSelecionar);
  try
    frmSelecionar.webBrowser.URL := AUrl;

    if frmSelecionar.ShowModal = mrOK then
      Result := frmSelecionar.edit1.Text;
  finally
    FreeAndNil(frmSelecionar);
  end;
end;

procedure TfrmSelIcon.Timer1Timer(Sender: TObject);
begin
  If clipboard.AsText.StartsWith('.bi-') Then
  Begin
    Edit1.Text := clipboard.AsText;
    btnConfirma.Enabled := True;
  End;
end;

end.
