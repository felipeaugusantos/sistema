unit untQualizapGenerateDownloadUrl;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  REST.Client, untFuncoesSimples,
{$ENDIF}
  Generics.Collections, Rest.Json, SysUtils, REST.Types,
  System.JSON, StrUtils, Data.DB, MemDS, untTypesSistema;

type
  IGenerateDownloadUrl = interface
    ['{3FDF6CF0-8E3E-4B13-99E9-95893093C38D}']
    function fGenerateUrl(const AapiKey: String;
                          const AqueueId,
                                AfileId: Extended): String;
  end;

  TResultGenerateUrl = class
  private
    FPath: String;
  public
    property path: String read FPath write FPath;
    class function FromJsonString(AJsonString: string): TResultGenerateUrl;
  end;

  TGenerateDownloadUrl = class(TInterfacedObject, IGenerateDownloadUrl)
  private
    FApiKey: String;
    FQueueId: Extended;
    FFileId: Extended;

    function fGenerateDownloadUrl: TResultGenerateUrl;
  public
    property apiKey: String read FApiKey write FApiKey;
    property queueId: Extended read FQueueId write FQueueId;
    property fileId: Extended read FFileId write FFileId;

    function ToJsonString: String;

    function fGenerateUrl(const AapiKey: String;
                          const AqueueId,
                                AfileId: Extended): String;

    class function fNew: IGenerateDownloadUrl;
  end;



implementation

uses
  untQualiZapRestApi, untRestApi;

{ TResultGenerateUrl }

class function TResultGenerateUrl.FromJsonString(
  AJsonString: string): TResultGenerateUrl;
begin
  Result := TJson.JsonToObject<TResultGenerateUrl>(AJsonString);
end;


{ TGenerateDownloadUrl }

class function TGenerateDownloadUrl.fNew: IGenerateDownloadUrl;
begin
  Result := TGenerateDownloadUrl.Create;
end;

function TGenerateDownloadUrl.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

function TGenerateDownloadUrl.fGenerateUrl(const AapiKey: String;
                                           const AqueueId,
                                                 AfileId: Extended): String;
var
  ResultGenerateUrl: TResultGenerateUrl;
  LBaseUrl : String;
begin
  Self.FApiKey := AapiKey;
  Self.FQueueId := AqueueId;
  Self.FFileId := AfileId;

  ResultGenerateUrl := fGenerateDownloadUrl;
  try
    if Assigned(ResultGenerateUrl) then
    begin
      LBaseUrl := fCfgSis('URLWPP');
      if EndsText('/', LBaseUrl) then
        Delete(LBaseUrl, Length(LBaseUrl), 1);

      Result := LBaseUrl + ResultGenerateUrl.path;
    end;
  finally
    FreeAndNil(ResultGenerateUrl);
  end;
end;

function TGenerateDownloadUrl.fGenerateDownloadUrl: TResultGenerateUrl;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/generateDownloadUrl';
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF};

    RESTRequest
    .Params
    .AddItem(  '',
               Self.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TResultGenerateUrl.FromJsonString(JSONRetorno);

  finally
   {$IFNDEF LINUX}
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
   {$ENDIF LINUX}
  end;
end;

end.
