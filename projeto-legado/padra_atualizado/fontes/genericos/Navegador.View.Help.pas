unit Navegador.View.Help;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  dxGDIPlusClasses, Winapi.ShellAPI, untFuncoesSimples;

type
  TfrmNavegadorViewHelp = class(TForm)
    imgHelp: TImage;
    lblMicrosoftEdgeWebView2: TLabel;
    procedure lblMicrosoftEdgeWebView2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNavegadorViewHelp: TfrmNavegadorViewHelp;

implementation

{$R *.dfm}

procedure TfrmNavegadorViewHelp.lblMicrosoftEdgeWebView2Click(Sender: TObject);
begin
  pBrowserNavigate(PWideChar('https://developer.microsoft.com/pt-br/microsoft-edge/webview2/'));
end;

end.
