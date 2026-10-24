unit api.rest.core;

interface

uses
  System.Classes,
  System.SysUtils,
  REST.Client,
  REST.Types,
  Vcl.Forms;

type
  {$M+}
  TApiRestCore = class
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;

    FUrl: String;
    FMetodo: TRESTRequestMethod;
    FToken: String;
    FJsonRetorno: String;
    FJsonEnvio: String;
    FStatusCode: Integer;
    FKeyUser: String;
    FCooperativa: String;
    FPosto: String;
    FCodigoBeneficiario: String;
    procedure OnAfterExecute(Sender: TCustomRESTRequest);
  published
    property Url: String read FUrl write FUrl;
    property Metodo: TRESTRequestMethod read FMetodo write FMetodo;
    property Token: String read FToken write FToken;
    property JsonEnvio: String read FJsonEnvio write FJsonEnvio;
    property JsonRetorno: String read FJsonRetorno;
    property StatusCode: Integer read FStatusCode;
    property KeyUser: String read FKeyUser write FKeyUser;
    property Cooperativa: String read FCooperativa write FCooperativa;
    property Posto: String read FPosto write FPosto;
    property CodigoBeneficiario: String read FCodigoBeneficiario write FCodigoBeneficiario;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    procedure Execute_;
  end;

implementation

{ TApiRestCore }

constructor TApiRestCore.Create;
begin
  FRESTClient := TRESTClient.Create(Nil);
  FRESTClient.Accept              := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRESTClient.AcceptCharset       := 'UTF-8, *;q=0.8';
  FRESTClient.ContentType         := 'application/json';
  FRESTClient.HandleRedirects     := True;
  FRESTClient.RaiseExceptionOn500 := False;
  FRESTClient.Params.Clear;

  FRESTResponse := TRESTResponse.Create(Nil);

  FRESTRequest := TRESTRequest.Create(Nil);
  FRESTRequest.Timeout            := 3600000;
  FRESTRequest.Method             := rmPOST;
  FRESTRequest.SynchronizedEvents := False;
  FRESTRequest.Client             := FRESTClient;
  FRESTRequest.OnAfterExecute     := OnAfterExecute;
  FRESTRequest.Response           := FRESTResponse;
end;

procedure TApiRestCore.OnAfterExecute(Sender: TCustomRESTRequest);
begin
  Application.ProcessMessages;
end;

destructor TApiRestCore.Destroy;
begin
  If Assigned(FRESTClient) Then
    FreeAndNil(FRESTClient);

  If Assigned(FRESTResponse) Then
    FreeAndNil(FRESTResponse);

  If Assigned(FRESTRequest) Then
    FreeAndNil(FRESTRequest);

  inherited;
end;

procedure TApiRestCore.Execute;

begin
  FRESTClient.BaseURL := FUrl;
  FRESTRequest.Method := FMetodo;

  If FMetodo In [rmPOST, rmPUT, rmPATCH] Then
    FRESTRequest.AddBody(FJsonEnvio, ctAPPLICATION_JSON);

  If Not FToken.IsEmpty Then
    FRESTRequest.AddAuthParameter('Authorization', FToken, pkHTTPHEADER, [poDoNotEncode]);

  FRESTRequest.Execute;

  FJsonRetorno := FRESTResponse.Content;
  FStatusCode  := FRESTResponse.StatusCode;

end;

procedure TApiRestCore.Execute_;

begin
  FRESTClient.BaseURL := FUrl;
  FRESTRequest.Method := FMetodo;

  If FMetodo In [rmPOST, rmPUT, rmPATCH] Then
    FRESTRequest.AddBody(FJsonEnvio, ctAPPLICATION_JSON);

  If Not FToken.IsEmpty Then
    FRESTRequest.AddAuthParameter('Authorization', FToken, pkHTTPHEADER, [poDoNotEncode]);

  If Not KeyUser.IsEmpty Then
  Begin
     FRESTRequest.Params.AddItem('x-api-key', KeyUser, TRESTRequestParameterKind.pkHTTPHEADER,[poDoNotEncode]);

     If Not Cooperativa.IsEmpty Then
        FRESTRequest.Params.AddItem('cooperativa', cooperativa, TRESTRequestParameterKind.pkHTTPHEADER,[poDoNotEncode]);

     If Not Posto.IsEmpty Then
        FRESTRequest.Params.AddItem('posto', Posto, TRESTRequestParameterKind.pkHTTPHEADER,[poDoNotEncode]);

     If Not CodigoBeneficiario.IsEmpty Then
        FRESTRequest.Params.AddItem('codigoBeneficiario', CodigoBeneficiario, TRESTRequestParameterKind.pkHTTPHEADER,[poDoNotEncode]);
  End;

  FRESTRequest.Execute;

  FJsonRetorno := FRESTResponse.Content;
  FStatusCode  := FRESTResponse.StatusCode;

end;

end.
