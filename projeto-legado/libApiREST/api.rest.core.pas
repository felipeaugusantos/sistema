unit api.rest.core;

interface

uses
  System.Classes,
  System.SysUtils
  ,IdSSLOpenSSL
  ,IdHTTP
  ,IdSSLOpenSSLHeaders
  {$IF Defined(VER330)}
  ,REST.Types
  ,Data.Bind.Components
  ,Data.Bind.ObjectScope
  ,REST.Client
  ,System.Net.HttpClient
  ,System.Net.URLClient
  ,System.NetConsts
  {$ELSE}
  ,IPPeerClient
  ,REST.Client
  ,REST.Types
  {$IFEND}
  ;

type
  TordHTTPSecureProtocol = (SPDefault, SSL2, SSL3, TLS1, TLS11, TLS12);                       //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll
  TmodeEnvSoap = (modeOpen, modeHttp, modeOpAp, modeNull{deixar modeNull por último sempre}); //Manter igual em libNefe.dll, NFeImpressao.exe, api.rest.dll

type
  {$M+}
  TApiRestCore = class
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FIdHTTP: TIdHTTP;
    {$IF Defined(VER330)}
    FHTTPClient: THTTPClient;
    {$IFEND}
    FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    FmodeEnvSoap: TmodeEnvSoap;
    FUrl: String;
    FMetodo: TRESTRequestMethod;
    FToken: String;
    FJsonRetorno: String;
    FJsonEnvio: String;
    FStatusCode: Integer;
  published
    property Url: String read FUrl write FUrl;
    property Metodo: TRESTRequestMethod read FMetodo write FMetodo;
    property Token: String read FToken write FToken;
    property JsonEnvio: String read FJsonEnvio write FJsonEnvio;
    property JsonRetorno: String read FJsonRetorno;
    property StatusCode: Integer read FStatusCode;
  public
    constructor Create(AmodeEnvSoap: TmodeEnvSoap = modeOpen; ordHTTPSecureProtocol: TordHTTPSecureProtocol = SPDefault);
    destructor Destroy; override;
    procedure Execute;
  end;

implementation

{ TApiRestCore }

constructor TApiRestCore.Create(AmodeEnvSoap: TmodeEnvSoap = modeOpen; ordHTTPSecureProtocol: TordHTTPSecureProtocol = SPDefault);
begin
  FmodeEnvSoap := AmodeEnvSoap;

  If (FmodeEnvSoap In [modeOpen, modeHttp]) Then
  Begin
    If (FmodeEnvSoap = modeOpen)  Then
    Begin
      IdOpenSSLSetLibPath(PChar(ExtractFilePath(ParamStr(0))+'LibRest'));

      FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

      FIdHTTP := TIdHTTP.Create;
      FIdHTTP.Request.ContentType := 'text/xml;charset=UTF-8';
      FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
      FIdHTTP.ReadTimeout    := 5000;
      FIdHTTP.ConnectTimeout := 5000;

      case ordHTTPSecureProtocol of
        SSL2:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvSSLv2];
        SSL3:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvSSLv3];
        TLS1:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1];
        TLS11: FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_1];
        TLS12: FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
      end;
    End
    {$IF Defined(VER330)}
    Else
    Begin
      FHTTPClient := THTTPClient.Create;
      FHTTPClient.ContentType := 'text/xml;charset=UTF-8';

      case ordHTTPSecureProtocol of
        SSL2:  FHTTPClient.SecureProtocols := [THTTPSecureProtocol.SSL2];
        SSL3:  FHTTPClient.SecureProtocols := [THTTPSecureProtocol.SSL3];
        TLS1:  FHTTPClient.SecureProtocols := [THTTPSecureProtocol.TLS1];
        TLS11: FHTTPClient.SecureProtocols := [THTTPSecureProtocol.TLS11];
        TLS12: FHTTPClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
      end;
    End;
    {$IFEND}
  End
  Else
  Begin
    FRESTResponse := TRESTResponse.Create(Nil);

    FRESTClient := TRESTClient.Create(Nil);
    FRESTClient.Accept              := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    FRESTClient.AcceptCharset       := 'UTF-8, *;q=0.8';
    FRESTClient.ContentType         := 'application/json';
    FRESTClient.HandleRedirects     := True;
    FRESTClient.RaiseExceptionOn500 := False;
    FRESTClient.Params.Clear;

    {$IF Defined(VER330)}
    case ordHTTPSecureProtocol of
      SSL2:  FRESTClient.SecureProtocols := [THTTPSecureProtocol.SSL2];
      SSL3:  FRESTClient.SecureProtocols := [THTTPSecureProtocol.SSL3];
      TLS1:  FRESTClient.SecureProtocols := [THTTPSecureProtocol.TLS1];
      TLS11: FRESTClient.SecureProtocols := [THTTPSecureProtocol.TLS11];
      TLS12: FRESTClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
    end;
    {$IFEND}

    FRESTRequest := TRESTRequest.Create(Nil);
    FRESTRequest.Timeout            := 3600000;
    FRESTRequest.Method             := rmPOST;
    FRESTRequest.SynchronizedEvents := False;
    FRESTRequest.Client             := FRESTClient;
    FRESTRequest.Response           := FRESTResponse;
  End;
end;

destructor TApiRestCore.Destroy;
begin
  If Assigned(FRESTClient) Then
    FreeAndNil(FRESTClient);

  If Assigned(FRESTResponse) Then
    FreeAndNil(FRESTResponse);

  If Assigned(FRESTRequest) Then
    FreeAndNil(FRESTRequest);

  {$IF Defined(VER330)}
  If Assigned(FHTTPClient) Then
    FreeAndNil(FHTTPClient);
  {$IFEND}

  If Assigned(FIdHTTP) Then
    FreeAndNil(FIdHTTP);

  If Assigned(FIdSSLIOHandlerSocketOpenSSL) Then
    FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);

  inherited;
end;

procedure TApiRestCore.Execute;
var
  LStringStream: TStringStream;
  {$IF Defined(VER330)}
  LResponse: IHTTPResponse;
  {$IFEND}
begin
  If (FmodeEnvSoap In [modeOpen, modeHttp]) Then
  Begin
    If (FmodeEnvSoap = modeOpen)  Then
    Begin
      LStringStream := TStringStream.Create(FJsonEnvio, TUTF8Encoding.Create);
      Try
        FJsonRetorno := FIdHTTP.Post(FUrl, LStringStream);
        FStatusCode  := FIdHTTP.ResponseCode;
      Finally
        LStringStream.Free;
      End;
    End
    {$IF Defined(VER330)}
    Else
    Begin
      LStringStream := TStringStream.Create(FJsonEnvio, TUTF8Encoding.Create);
      Try
        LResponse := FHTTPClient.Post(FUrl, LStringStream);
        FJsonRetorno := LResponse.ContentAsString;
        FStatusCode  := LResponse.StatusCode;
      Finally
        LStringStream.Free;
      End;
    End;
    {$IFEND}
  End
  Else
  Begin
    FRESTClient.BaseURL := FUrl;
    FRESTRequest.Method := FMetodo;

    If FMetodo In [rmPOST, rmPUT, rmPATCH] Then
      FRESTRequest.AddBody(FJsonEnvio, ctAPPLICATION_JSON);

    If Not FToken.IsEmpty Then
      FRESTRequest.AddAuthParameter('Authorization', FToken, pkHTTPHEADER, [poDoNotEncode]);

    FRESTRequest.Execute;

    FJsonRetorno := FRESTResponse.Content;
    FStatusCode  := FRESTResponse.StatusCode;

    If Pos('pdf', FRESTResponse.ContentType) > 0 Then
    Begin
      LStringStream := TStringStream.Create(FRESTResponse.RawBytes);

      Try
        FJsonRetorno := LStringStream.DataString;
      Finally
        FreeAndNil(LStringStream);
      End;
    End;
  End;
end;

end.
