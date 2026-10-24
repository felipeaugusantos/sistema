unit untWebBrowser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, VCL.TMSFNCTypes, VCL.TMSFNCUtils,
  VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes, VCL.TMSFNCCustomControl,
  VCL.TMSFNCWebBrowser, Vcl.OleCtrls, SHDocVw, untFuncoesSimples;

type
  TfrmWebBrowser = class(TfrmPai)
    Timer: TTimer;
    webBrowser: TTMSFNCWebBrowser;
    procedure FormActivate(Sender: TObject);
    procedure webBrowserBeforeNavigate(Sender: TObject;
      var Params: TTMSFNCCustomWebBrowserBeforeNavigateParams);
    procedure webBrowserNavigateComplete(Sender: TObject;
      var Params: TTMSFNCCustomWebBrowserNavigateCompleteParams);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure WebBrowserNavigate(url: String);
    procedure LimparCacheWebView;
  public
    { Public declarations }
    Url: String;
  end;

var
  frmWebBrowser: TfrmWebBrowser;

implementation

{$R *.dfm}

{ TfrmWebBrowser }

procedure TfrmWebBrowser.FormActivate(Sender: TObject);
begin
  inherited;

  If Not blnUsuarioLogadoUtilizaModoClassico Then
    Self.FormStyle := TFormStyle.fsStayOnTop;

  WebBrowserNavigate(Url);
end;

procedure TfrmWebBrowser.FormCreate(Sender: TObject);
begin
  inherited;

  LimparCacheWebView;
end;

procedure TfrmWebBrowser.LimparCacheWebView;
var
  TempPath: string;
begin
  TempPath := ExtractFilePath(Application.ExeName)+ 'temp\maps';

  RemoveDir(TempPath);
  CreateDir(TempPath);

  webBrowser.CacheFolder := TempPath;
  webBrowser.ClearCache;

  Application.ProcessMessages;
end;

procedure TfrmWebBrowser.webBrowserBeforeNavigate(Sender: TObject;
  var Params: TTMSFNCCustomWebBrowserBeforeNavigateParams);
begin
  inherited;
  Self.Caption := 'Carregando...';
  Application.ProcessMessages;
end;

procedure TfrmWebBrowser.WebBrowserNavigate(url: String);
begin
  webBrowser.Navigate(url);
end;

procedure TfrmWebBrowser.webBrowserNavigateComplete(Sender: TObject;
  var Params: TTMSFNCCustomWebBrowserNavigateCompleteParams);
begin
  inherited;
  If url.Contains('maps') Then
    Self.Caption := 'Visualizador de Mapas'
  else
    Self.Caption := url;

  Application.ProcessMessages;
end;

end.

