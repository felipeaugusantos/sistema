unit untContelePortifoliosGet;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client;
  {$ENDIF LINUX}

type
  TPortifoliosClass = class
  private
    FId: String;
    FName: String;
  public
    property id: String read FId write FId;
    property name: String read FName write FName;
  end;

  TPortifolios = class
  private
    FPortifolios: TArray<TPortifoliosClass>;
  public
    property portifolios: TArray<TPortifoliosClass> read FPortifolios write FPortifolios;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TPortifolios;
  end;

  TControlerContelePortifoliosGet = class
  private
    class function fGetApiKey: String;
  public
    class function fPortifoliosGet: TPortifolios;
  end;

implementation

{ TPortifolios }

uses untConteleRestApi, untRestApi;

destructor TPortifolios.Destroy;
var
  LportifoliosItem: TPortifoliosClass;
begin
  for LportifoliosItem in FPortifolios do
    LportifoliosItem.free;

  inherited;
end;

class function TPortifolios.FromJsonString(
  AJsonString: string): TPortifolios;
begin
  Result := TJson.JsonToObject<TPortifolios>(AJsonString)
end;

class function TControlerContelePortifoliosGet.fGetApiKey: String;
begin
  Result := fCampoTabela('CON_KEYCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]);
end;

class function TControlerContelePortifoliosGet.fPortifoliosGet: TPortifolios;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/portifolios';
    RestRequest.Method := rmGet;

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TPortifolios.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

end.
