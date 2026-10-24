unit untConteleCategoriesGet;

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
  TCategoriesClass = class
  private
    FColor: String;
    FCreatedAt: String;
    FId: String;
    FName: String;
    FUpdatedAt: String;
  public
    property color: String read FColor write FColor;
    property createdAt: String read FCreatedAt write FCreatedAt;
    property id: String read FId write FId;
    property name: String read FName write FName;
    property updatedAt: String read FUpdatedAt write FUpdatedAt;
  end;

  TCategories = class
  private
    FCategories: TArray<TCategoriesClass>;
  public
    property categories: TArray<TCategoriesClass> read FCategories write FCategories;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TCategories;
  end;

  TControlerConteleCategoriesGet = class
  private
    class function fGetApiKey: String;
  public
    class function fCategoriesGet: TCategories;
  end;

implementation

{ TPortifolios }

uses untConteleRestApi, untRestApi;

class function TControlerConteleCategoriesGet.fGetApiKey: String;
begin
  Result := fCampoTabela('CON_KEYCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]);
end;

{ TCategories }

destructor TCategories.Destroy;
var
  LcategoriesItem: TCategoriesClass;
begin

 for LcategoriesItem in FCategories do
   LcategoriesItem.free;

  inherited
end;

class function TCategories.FromJsonString(AJsonString: string): TCategories;
begin
  Result := TJson.JsonToObject<TCategories>(AJsonString)
end;

class function TControlerConteleCategoriesGet.fCategoriesGet: TCategories;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/categories';
    RestRequest.Method := rmGet;

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TCategories.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

end.

