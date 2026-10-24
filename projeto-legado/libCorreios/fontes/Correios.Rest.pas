unit Correios.Rest;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.NetEncoding,
  IPPeerClient,
  REST.Types,
  REST.Client,
  REST.HttpClient,
  Winapi.Windows,
  Correios.Controller;
  
type
  THttpMethod = function (const AUrl, AMetodo, ABody, ABodyType: WideString;
                          const AHeaders: Array of WideString; out AStatusCode: Integer;
                          out AStatusText: WideString; const ATimeout: Integer): WideString; stdcall;

  ICorreiosREST = interface
    ['{26FAFA85-7D5A-4E4E-A306-EAA008BB15EE}']
    procedure SetBasicAuth;
    procedure SetBearerAuth;
    function Execute(const AUrl, AMetodo, ABody: String): THttpResponse;
  end;

  TCorreiosREST_def = class(TInterfacedObject, ICorreiosREST)
  private
    FClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
  public
    procedure SetBasicAuth;
    procedure SetBearerAuth;
    function Execute(const AUrl, AMetodo, ABody: String): THttpResponse;

    constructor Create;
    destructor Destroy; override;
  end;

  TCorreiosREST_dll = class(TInterfacedObject, ICorreiosREST)
  private
    FHandleDll: THandle;
    FHeaders: TArray<WideString>;
    procedure AddHeader(const AValue: String);
    procedure ClearHeader;
  public
    procedure SetBasicAuth;
    procedure SetBearerAuth;
    function Execute(const AUrl, AMetodo, ABody: String): THttpResponse;

    constructor Create(const APathDll: String);
    destructor Destroy; override;
  end;

implementation

uses
  Correios.Funcoes,
  Correios.Constantes;

{ TCorreiosREST_def }

constructor TCorreiosREST_def.Create;
begin
  try
    FClient   := TRESTClient.Create(nil);
    FRequest  := TRESTRequest.Create(nil);
    FResponse := TRESTResponse.Create(nil);

    FClient.Accept              := 'application/json,text/plain;q=0.9,text/html;q=0.8';
    FClient.AcceptCharset       := 'UTF-8, *;q=0.8';
    FClient.ContentType         := APP_JSON;
    FClient.HandleRedirects     := True;
    FClient.RaiseExceptionOn500 := False;
    FClient.Params.Clear;

    FRequest.Timeout            := API_TIMEOUT;
    FRequest.SynchronizedEvents := False;
    FRequest.Client             := FClient;
    FRequest.Response           := FResponse;
  except
    raise;
  end;
end;

destructor TCorreiosREST_def.Destroy;
begin
  if Assigned(FClient) then
    FreeAndNil(FClient);

  if Assigned(FRequest) then
    FreeAndNil(FRequest);

  if Assigned(FResponse) then
    FreeAndNil(FResponse);
  inherited;
end;

function TCorreiosREST_def.Execute(const AUrl, AMetodo, ABody: String): THttpResponse;
  const
    MAX_TENTAT = 3;
  var
    LCont: Integer;
begin
  FillChar(Result, SizeOf(Result), #0);

  FClient.BaseURL := AUrl;

  case AnsiIndexText(AMetodo, ['GET','POST','PUT','DELETE','PATCH']) of
    0: FRequest.Method := rmGET;
    1: FRequest.Method := rmPOST;
    2: FRequest.Method := rmPUT;
    3: FRequest.Method := rmDELETE;
    4: FRequest.Method := rmPATCH;
  end;

  if not ABody.IsEmpty then
    FRequest.AddBody(ABody, ctAPPLICATION_JSON);

  for LCont := 1 to MAX_TENTAT do
  begin
    try
      FRequest.Execute;

      Result.Code    := FResponse.StatusCode;
      Result.Status  := FResponse.StatusText;
      Result.Content := FResponse.Content;

      Break;
    except on E: Exception do
      if E is EHTTPProtocolException then
      begin
        if LCont = MAX_TENTAT then
          raise
        else
          Sleep(200);
      end;
    end;
  end;
end;

procedure TCorreiosREST_def.SetBasicAuth;
  var
    LobjBase64: TBase64Encoding;
    LAuth: String;
begin
  LobjBase64 := TBase64Encoding.Create(0);

  try
    LAuth := LobjBase64.Encode(VS_strNomUsu +':'+ VS_strCodAce);

    try
      FRequest.Params.Clear;
      FRequest.AddParameter('Authorization', 'Basic '+ LAuth, pkHTTPHEADER, [poDoNotEncode]);
    except
    end;
  finally
    LobjBase64.Free;
  end;
end;

procedure TCorreiosREST_def.SetBearerAuth;
  var
    LobjToken: TTokenCorreios;
    LToken: String;
begin
  LobjToken := TTokenCorreios.Create;

  try
    LToken := LobjToken.GetToken;

    try
      FRequest.Params.Clear;

      if not LToken.IsEmpty then
        FRequest.AddParameter('Authorization', 'Bearer '+ LToken, pkHTTPHEADER, [poDoNotEncode]);
    except
    end;
  finally
    FreeAndNil(LobjToken);
  end;
end;

{ TCorreiosREST_dll }

procedure TCorreiosREST_dll.AddHeader(const AValue: String);
begin
  SetLength(FHeaders, Length(FHeaders) +1);
  FHeaders[High(FHeaders)] := AValue;
end;

procedure TCorreiosREST_dll.ClearHeader;
begin
  SetLength(FHeaders, 0);
end;

constructor TCorreiosREST_dll.Create(const APathDll: String);
begin
  FHandleDll := LoadLibrary(PChar(APathDll));

  ClearHeader;
  AddHeader('Accept: '+ APP_JSON);
  AddHeader('Content-Type: '+ APP_JSON);
end;

destructor TCorreiosREST_dll.Destroy;
begin
  if FHandleDll <> 0 then
    FreeLibrary(FHandleDll);
  inherited;
end;

function TCorreiosREST_dll.Execute(const AUrl, AMetodo, ABody: String): THttpResponse;
  var
    LContent: String;
    LCode: Integer;
    LStatus: WideString;
    LHttpMethod: THttpMethod;
begin
  FillChar(Result, SizeOf(Result), #0);

  try
    @LHttpMethod := GetProcAddress(FHandleDll, 'HttpMethod');

    LContent := LHttpMethod(AUrl, AMetodo, ABody, APP_JSON, FHeaders, LCode, LStatus, API_TIMEOUT);

    Result.Code    := LCode;
    Result.Status  := LStatus;
    Result.Content := LContent;
  except
    raise;
  end;
end;

procedure TCorreiosREST_dll.SetBasicAuth;
  var
    LobjBase64: TBase64Encoding;
    LAuth: String;
begin
  LobjBase64 := TBase64Encoding.Create(0);

  try
    LAuth := LobjBase64.Encode(VS_strNomUsu +':'+ VS_strCodAce);

    AddHeader('Authorization: Basic '+ LAuth);
  finally
    LobjBase64.Free;
  end;
end;

procedure TCorreiosREST_dll.SetBearerAuth;
  var
    LobjToken: TTokenCorreios;
    LToken: String;
begin
  LobjToken := TTokenCorreios.Create;

  try
    LToken := LobjToken.GetToken;

    if not LToken.IsEmpty then
      AddHeader('Authorization: Bearer '+ LToken);
  finally
    FreeAndNil(LobjToken);
  end;
end;

end.
