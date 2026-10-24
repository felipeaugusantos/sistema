unit untIndyHttpConnect;

interface

uses IdHTTP, IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdCTypes, untHttpTypes;

type
  TIndyHttpConnect = class
  private
    FUrl: String;
    FResponse: WideString;
    FStatusCode: Integer;
    FIdHTTP: TIdHTTP;
    FIdSSLIOHandlerSocketOpenSSL : TIdSSLIOHandlerSocketOpenSSL;
    function fExisteLibsOpenSSL: Boolean;
    {$IF CompilerVersion <= 30.0}
    procedure OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
    {$IFEND}
  public
    constructor Create(const AUrl: String; const ordHTTPSecureProtocol: TordHTTPSecureProtocol);
    destructor Destroy; override;
    procedure Execute(const ARequest: WideString);
    property Response: WideString read FResponse;
    property StatusCode: Integer read FStatusCode;
  end;

implementation

uses SysUtils,Classes, untDicSis;

{ TIndyHttpConnect }

constructor TIndyHttpConnect.Create(const AUrl: String; const ordHTTPSecureProtocol: TordHTTPSecureProtocol);
begin
  FUrl := AUrl;

 {$IFDEF LINUX}
  IdOpenSSLSetLibPath(GetCurrentDir);//Forçar libcrypto.so e libssl.so da pasta do programa.
 {$ENDIF}

  If (Not fExisteLibsOpenSSL) Then
    IdOpenSSLSetLibPath(PChar(ExtractFilePath(ParamStr(0))+'LibRest'));

  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

  FIdHTTP := TIdHTTP.Create;
  FIdHTTP.Request.ContentType := 'text/xml;charset=UTF-8';
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdHTTP.ReadTimeout    := 75000;
  FIdHTTP.ConnectTimeout :=  5000;
  FIdHTTP.Request.UserAgent := 'PainelNFE';

  case ordHTTPSecureProtocol of
    SSL2:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvSSLv2];
    SSL3:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvSSLv3];
    TLS1:  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1];
    TLS11: FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_1];
    TLS12: FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1_2];
  end;

  If Pos('citel.com.br', AnsiLowerCase(Self.FUrl)) > 0 Then
  Begin
   {$IF CompilerVersion <= 30.0}
    FIdSSLIOHandlerSocketOpenSSL.OnStatusInfoEx := OnStatusInfoEx; //DELPHI SEATTLE E ANTERIORES NÃO CONFIGURAM SNI AUTOMATICAMENTE (NECESSÁRIO CONFIGURAR O HOSTNAME MANUALMENTE PARA ALGUNS SERVIDORES HTTPS)
   {$IFEND}
  End;
end;

destructor TIndyHttpConnect.Destroy;
begin
  FreeAndNil(FIdHTTP);
  FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);
  inherited;
end;

procedure TIndyHttpConnect.Execute(const ARequest: WideString);
  Var
    LStringStream : TStringStream;
begin
  LStringStream := TStringStream.Create(ARequest, TUTF8Encoding.Create);
  Try
    FResponse := FIdHTTP.Post(FUrl, LStringStream);
    FStatusCode := FIdHTTP.ResponseCode;
  Finally
    LStringStream.Free;
  End;
end;

function TIndyHttpConnect.fExisteLibsOpenSSL: Boolean;
begin
  Result := False;

 {$IFDEF LINUX}
  If (Not FileExists(PChar(ExtractFilePath(ParamStr(0))+'libssl.so'))) Then
    Exit;

  If (Not FileExists(PChar(ExtractFilePath(ParamStr(0))+'libcrypto.so'))) Then
    Exit;
 {$ELSE}
  If (Not FileExists(PChar(ExtractFilePath(ParamStr(0))+'libeay32.dll'))) Then
    Exit;

  If (Not FileExists(PChar(ExtractFilePath(ParamStr(0))+'ssleay32.dll'))) Then
    Exit;
 {$ENDIF}

  Result := True;
end;

{$IF CompilerVersion <= 30.0}
procedure TIndyHttpConnect.OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL;
  const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
var
  LErro,
  LHost: String;
  LRet: TIdC_LONG;
begin
  if ((AWhere and SSL_CB_HANDSHAKE_START) = 0) then
    Exit;

  LHost := Trim(FIdSSLIOHandlerSocketOpenSSL.Host);

  if (LHost = '') then
    LHost := Trim(fExtraiHostDaUrl(FUrl));

  if (LHost = '') then
    LErro := 'Falha ao configurar SNI: hostname vazio. URL=' + FUrl
  else
  begin
    LRet := SSL_set_tlsext_host_name(AsslSocket, LHost);
    if LRet <= 0 then
      LErro := 'Falha ao configurar SNI para: ' + LHost;
  end;

  if (LErro <> '') then
    pLogImp('TIndyHttpConnect.OnStatusInfoEx <' + LErro + '>');
end;
{$IFEND}

end.
