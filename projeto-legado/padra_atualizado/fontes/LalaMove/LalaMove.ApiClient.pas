unit LalaMove.ApiClient;

interface

uses LalaMove.Cities, LalaMove.Authentication, LalaMove.WebService,
  LalaMove.Quotation, System.SysUtils, LalaMove.Errors;

type
  ExceptionLalaMovApiClientError = Class(Exception)
  private
    FErrors : TLalamoveErrorResponse;
    FStatusCode : Integer;
  public
    constructor Create(const AMessage : String; AErrors : TLalamoveErrorResponse; const AStatusCode : Integer);
    property Errors : TLalamoveErrorResponse read FErrors;
    property StatusCode : Integer read FStatusCode;
  End;


  TLalaMoveApiClient = class
  private
    FAuth : TLalaMoveAuthentication;
    FWebService : TLalaMoveWS;
    function getAuthInput(const AMethod, ABody, APath: string) : TLalaMoveAuthentication.TInput;
    function TryError(const ABody : String) : TLalamoveErrorResponse;
  public
    function getCities : TLalaMoveCities;
    function getQuotation(const AGetQuotation : TLalaMoveGetQuotation) : TLalaMoveGetQuotationCreated;
    function deleteOrder(const AOrderId : String) : Boolean;
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses REST.Json, untFuncoesSimples;

{ TLalaMoveApiClient }

constructor TLalaMoveApiClient.Create;
begin
  FAuth := TLalaMoveAuthentication.Create;
  FWebService := TLalaMoveWS.Create;
end;

destructor TLalaMoveApiClient.Destroy;
begin
  FreeAndNil(FAuth);
  FreeAndNil(FWebService);
  inherited;
end;

function TLalaMoveApiClient.getAuthInput(const AMethod, ABody, APath: string): TLalaMoveAuthentication.TInput;
begin
  FillChar(Result, SizeOf(Result), #0);
  Result.secretKey := fCfgSis('LASKEY', varString);
  Result.method := AMethod;
  Result.path := APath;
  Result.body := ABody;
  Result.apiKey := fCfgSis('LAAPKE', varString);
end;

function TLalaMoveApiClient.getCities: TLalaMoveCities;
  Const
    RESOURCE : String = '/v3/cities';
  Var
    LInputAuth : TLalaMoveAuthentication.TInput;
    LToken : String;
    LResponse : TLalaMoveResponse;
begin
  LInputAuth := getAuthInput('GET', '', RESOURCE);
  LToken := FAuth.getToken(LInputAuth);
  LResponse := FWebService.Request(RESOURCE, '', lmGet, LToken);
  If (LResponse.statusCode = 200) Then
    Result := TJson.JsonToObject<TLalaMoveCities>(LResponse.content)
  Else
    raise ExceptionLalaMovApiClientError.Create(LResponse.statusCode.toString + ' - ' + LResponse.content, TryError(LResponse.content), LResponse.statusCode);
end;

function TLalaMoveApiClient.getQuotation(const AGetQuotation : TLalaMoveGetQuotation): TLalaMoveGetQuotationCreated;
  Const
    RESOURCE : String = '/v3/quotations';
  Var
    LInputAuth : TLalaMoveAuthentication.TInput;
    LToken : String;
    LResponse : TLalaMoveResponse;
    LBodyData : string;
begin
  LBodyData := TJson.ObjectToJsonString(AGetQuotation);
  LInputAuth := getAuthInput('POST', LBodyData, RESOURCE);
  LToken := FAuth.getToken(LInputAuth);
  LResponse := FWebService.Request(RESOURCE, LBodyData, lmPost, LToken);
  If (LResponse.statusCode = 201) Then
    Result := TJson.JsonToObject<TLalaMoveGetQuotationCreated>(LResponse.content)
  Else
  begin
    raise ExceptionLalaMovApiClientError.Create(LResponse.statusCode.toString + ' - ' + LResponse.content, TryError(LResponse.content), LResponse.statusCode);
  end;
end;

function TLalaMoveApiClient.TryError(const ABody: String): TLalamoveErrorResponse;
begin
  Try
    Result := TJson.JsonToObject<TLalamoveErrorResponse>(ABody);
  Except
    Result := TLalamoveErrorResponse.Create;
  End;
end;

function TLalaMoveApiClient.deleteOrder(const AOrderId: String): Boolean;
  Const
    RESOURCE : String = '/v3/orders/%s';
  Var
    LInputAuth : TLalaMoveAuthentication.TInput;
    LToken : String;
    LResponse : TLalaMoveResponse;
    LResource : String;
begin
  LResource := Format(RESOURCE, [AOrderId]);
  LInputAuth := getAuthInput('DELETE', '', LResource);
  LToken := FAuth.getToken(LInputAuth);
  LResponse := FWebService.Request(LResource, '', lmDelete, LToken);
  If (LResponse.statusCode = 204) Then
    Result := True
  Else
    raise ExceptionLalaMovApiClientError.Create(LResponse.statusCode.toString + ' - ' + LResponse.content, TryError(LResponse.content), LResponse.statusCode);
end;

{ ExceptionLalaMovApiClientError }

constructor ExceptionLalaMovApiClientError.Create(const AMessage: String;
  AErrors: TLalamoveErrorResponse; const AStatusCode : Integer);
begin
  inherited Create(AMessage);
  FErrors := AErrors;
  FStatusCode := AStatusCode;
end;

end.
