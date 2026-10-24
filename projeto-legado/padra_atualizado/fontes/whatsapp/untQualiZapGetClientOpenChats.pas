unit untQualiZapGetClientOpenChats;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, untFuncoesSimples, REST.Client,
  Uni;

type

  TGetClientOpenChats = class
  private
    FApiKey: String;
    FClientId: String;
    FCountry: String;
    FNumber: String;
    FQueueId: Extended;
  public
    property apiKey: String read FApiKey write FApiKey;
    property clientId: String read FClientId write FClientId;
    property country: String read FCountry write FCountry;
    property number: String read FNumber write FNumber;
    property queueId: Extended read FQueueId write FQueueId;
    class function ToJsonString(GetClientOpenChats: TGetClientOpenChats): string;
  end;

  TChatsClass = class
  private
    FChatId: Extended;
    FQueueId: Extended;
  public
    property chatId: Extended read FChatId write FChatId;
    property queueId: Extended read FQueueId write FQueueId;
  end;

  TReturnGetClientOpenChats = class
  private
    FChats: TArray<TChatsClass>;
    FOpenChats: Extended;
  public
    property chats: TArray<TChatsClass> read FChats write FChats;
    property openChats: Extended read FOpenChats write FOpenChats;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TReturnGetClientOpenChats;
  end;

  TControllerGetClientOpenChats = class
  private
    class function fGet(GetClientOpenChats: TGetClientOpenChats): TReturnGetClientOpenChats;
  public
    class function fGetClientOpenChats(strNumber: String): TReturnGetClientOpenChats;
  end;

implementation

{TGetClientOpenChats}

uses untRestApi, untQualiZapRestApi;

class function TGetClientOpenChats.ToJsonString(GetClientOpenChats: TGetClientOpenChats): string;
begin
  Result := TJson.ObjectToJsonString(GetClientOpenChats);
end;

{TReturnGetClientOpenChats}

destructor TReturnGetClientOpenChats.Destroy;
var
  LchatsItem: TChatsClass;
begin

 for LchatsItem in FChats do
   LchatsItem.free;

  inherited;
end;

class function TReturnGetClientOpenChats.FromJsonString(AJsonString: string): TReturnGetClientOpenChats;
begin
  Result := TJson.JsonToObject<TReturnGetClientOpenChats>(AJsonString)
end;

{ TControllerGetClientOpenChats }

class function TControllerGetClientOpenChats.fGetClientOpenChats(
  strNumber: String): TReturnGetClientOpenChats;
var
  GetClientOpenChats: TGetClientOpenChats;

  extIdFila: Extended;
  strApiKey: String;
begin
  Result := nil;
  if fRetFilaEApiKeyPrincipalWhatsapp(extIdFila, strApiKey) then
  begin
    GetClientOpenChats := TGetClientOpenChats.Create;
    GetClientOpenChats.queueId := extIdFila;
    GetClientOpenChats.apiKey := strApiKey;
    GetClientOpenChats.number := strNumber;

    Result := fGet(GetClientOpenChats);
  end;
end;

class function TControllerGetClientOpenChats.fGet(GetClientOpenChats: TGetClientOpenChats): TReturnGetClientOpenChats;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/getClientOpenChats';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               TGetClientOpenChats.ToJsonString(GetClientOpenChats),
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TReturnGetClientOpenChats.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

end.

