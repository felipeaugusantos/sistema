unit Navegador.Classes.TNavegador;

interface

uses
  Navegador.Interfaces, VCL.TMSFNCWebBrowser, Winapi.Windows, Vcl.ExtCtrls, System.Classes, Vcl.Controls,
  System.SysUtils, FMX.TMSFNCWebBrowser.Win, VCL.Forms, untFuncoesSimples;

type
  TNavegador = class(TInterfacedObject, INavegador)

  Const
    {$IFDEF WIN64}
    CoreWebView2DLL = 'WebView2Loader_x64.dll';
    {$ELSE}
    CoreWebView2DLL = 'WebView2Loader_x86.dll';
    {$ENDIF}

  Private
    FNavegador      : TTMSFNCWebBrowser;
    FNavegadorAtivo : Boolean;
  Strict Private
    function CheckEdgeBrowser: Boolean;
  Public

    constructor New; Reintroduce;
    destructor Destroy; Override;

    procedure Navigate(const URL: WideString);
    procedure Reload;
    procedure setParent(APanel : TPanel);

    property NavegadorAtivo : Boolean Read FNavegadorAtivo;

  End;

implementation


{ TNavegador }

function TNavegador.CheckEdgeBrowser: Boolean;
begin
  Result := untFuncoesSimples.CheckEdgeBrowser;
end;

destructor TNavegador.Destroy;
begin
  inherited;

  If Assigned(FNavegador) Then
    FreeAndNil(FNavegador);

end;

procedure TNavegador.Navigate(const URL: WideString);
begin

  If Not FNavegadorAtivo Then
    Exit;


  FNavegador.BeginUpdate;

  Try
    FNavegador.URL := URL;
    FNavegador.Navigate;
  Finally
    FNavegador.EndUpdate;
  End;

end;

procedure TNavegador.Reload;
begin
  If not Assigned(FNavegador) Then
    Exit;

  FNavegador.Reload;
end;

constructor TNavegador.New;
begin

  inherited Create;

  FNavegador := Nil;

  Try

    FNavegadorAtivo := CheckEdgeBrowser;

    If FNavegadorAtivo Then
    Begin
      FNavegador     := TTMSFNCWebBrowser.Create(Nil);
      FNavegador.URL := 'about:blank';
    End;

  Except
    FNavegador      := Nil;
    FNavegadorAtivo := False;
  End;

end;

procedure TNavegador.setParent(APanel: TPanel);
begin

  If Not FNavegadorAtivo Then
    Exit;

  FNavegador.Parent := APanel;
  FNavegador.Align  := alClient;
end;

initialization
begin
  EdgeDLLPath := ExtractFilePath(Application.ExeName);
end;

end.
