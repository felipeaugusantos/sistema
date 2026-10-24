unit BrasilApi.ApiClient;

interface

uses BrasilApi.WebService, BrasilApi.Cnpj, BrasilApi.Errors, System.SysUtils;

type
  ExceptionBrasilApiClientError = Class(Exception)
  private
    FCnpjError : TBrasilApiCnpjError;
    FStatusCode : Integer;
  public
    constructor Create(const AMessage : String; ACnpjError : TBrasilApiCnpjError; const AStatusCode : Integer);
    property CnpjError : TBrasilApiCnpjError read FCnpjError;
    property StatusCode : Integer read FStatusCode;
  End;

  TBrasilApiClient = class
  private
    FWebService : TBrasilApiWS;
    function TryError(const ABody : String) : TBrasilApiCnpjError;
  public
    function getCnpj(const ACnpj: String) : TBrasilApiEmpresa;
    constructor Create;
    destructor Destroy; override;
  End;

implementation

uses REST.Json;

{ TBrasilApiClient }

constructor TBrasilApiClient.Create;
begin
  FWebService := TBrasilApiWS.Create;
end;

destructor TBrasilApiClient.Destroy;
begin
  FreeAndNil(FWebService);
  inherited;
end;

function TBrasilApiClient.getCnpj(const ACnpj: String): TBrasilApiEmpresa;
  Const
    RESOURCE : String = '/cnpj/v1/%s';
  Var
    LResponse : TBrasilApiResponse;
begin
  LResponse := FWebService.Request(Format(RESOURCE, [ACnpj]), lmGet);
  If (LResponse.statusCode = 200) Then
    Result := TJson.JsonToObject<TBrasilApiEmpresa>(LResponse.content)
  Else
    raise ExceptionBrasilApiClientError.Create(LResponse.statusCode.toString + ' - ' + LResponse.content, TryError(LResponse.content), LResponse.statusCode);
end;

function TBrasilApiClient.TryError(const ABody: String): TBrasilApiCnpjError;
begin
  Try
    Result := TJson.JsonToObject<TBrasilApiCnpjError>(ABody);
  Except
    Result := TBrasilApiCnpjError.Create;
  End;
end;

{ ExceptionBrasilApiClientError }

constructor ExceptionBrasilApiClientError.Create(const AMessage: String;
  ACnpjError: TBrasilApiCnpjError; const AStatusCode: Integer);
begin
  inherited Create(AMessage);
  FCnpjError := ACnpjError;
  FStatusCode := AStatusCode;
end;

end.
