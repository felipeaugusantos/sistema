unit untCatalagoFraga.ProductID;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type
  TVehiclesClass = class
  private
    FBrand: String;
    FEndYear: Integer;
    FEngineConfiguration: String;
    FEngineName: String;
    FFuel: String;
    FInjectionSystem: String;
    FModel: String;
    FName: String;
    FStartYear: Integer;
    FTransmissionType: String;
  public
    property brand: String read FBrand write FBrand;
    property endYear: Integer read FEndYear write FEndYear;
    property engineConfiguration: String read FEngineConfiguration write FEngineConfiguration;
    property engineName: String read FEngineName write FEngineName;
    property fuel: String read FFuel write FFuel;
    property injectionSystem: String read FInjectionSystem write FInjectionSystem;
    property model: String read FModel write FModel;
    property name: String read FName write FName;
    property startYear: Integer read FStartYear write FStartYear;
    property transmissionType: String read FTransmissionType write FTransmissionType;
  end;

  TProduct1Class = class
  private
    FCreatedDate: String;
    FId: String;
    FPartNumber: String;
    FVehicles: TArray<TVehiclesClass>;
  public
    property createdDate: String read FCreatedDate write FCreatedDate;
    property id: String read FId write FId;
    property partNumber: String read FPartNumber write FPartNumber;
    property vehicles: TArray<TVehiclesClass> read FVehicles write FVehicles;
    constructor Create;
    destructor Destroy; override;
  end;

  TDataClass = class
  private
    FProduct1: TProduct1Class;
  public
    property product1: TProduct1Class read FProduct1 write FProduct1;
    constructor Create;
    destructor Destroy; override;
  end;

  TFragaProductId = class
  private
    FData: TDataClass;

    class function FromJsonString(AJsonString: string): TFragaProductId;
    class function fRetQueryGraphQL(const AstrId: String): String;
  public
    property data: TDataClass read FData write FData;

    constructor Create;
    destructor Destroy; override;

    class function fProductId(const AstrIdProdutoFraga: String): TFragaProductId;
  end;

implementation

uses untCatalogoFragaRestApi, untRestApi, untTokenCatalogoFraga;

{TProduct1Class}

constructor TProduct1Class.Create;
begin
  inherited;
end;

destructor TProduct1Class.Destroy;
var
  LvehiclesItem: TVehiclesClass;
begin

 for LvehiclesItem in FVehicles do
   LvehiclesItem.free;

  inherited;
end;

{TDataClass}

constructor TDataClass.Create;
begin
  inherited;
  FProduct1 := TProduct1Class.Create();
end;

destructor TDataClass.Destroy;
begin
  FProduct1.free;
  inherited;
end;

{TRootClass}

constructor TFragaProductId.Create;
begin
  inherited;
  FData := TDataClass.Create();
end;

destructor TFragaProductId.Destroy;
begin
  FData.free;
  inherited;
end;

class function TFragaProductId.FromJsonString(AJsonString: string): TFragaProductId;
begin
  Result := TJson.JsonToObject<TFragaProductId>(AJsonString);
end;

class function TFragaProductId.fProductId(
  const AstrIdProdutoFraga: String): TFragaProductId;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('FRAGA_CATALOGO', TCatalogoFragaRestApi.fConfigurarCatalogoFraga);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method := rmPOST;

    TTokenCatalogoFraga.pRefreshTokenFraga;

    if fEmptyStr(VS_strToken) then
      Exit;

    RestRequest.Params.AddItem('Authorization', 'Bearer '+VS_strToken, pkHTTPHEADER);

    RESTRequest
    .Params
    .AddItem(  '',
               fRetQueryGraphQL(AstrIdProdutoFraga),
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TFragaProductId.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TFragaProductId.fRetQueryGraphQL(const AstrId: String): String;
begin
   Result :=
   ' { '+
   '   "query": '+
   '     "query { '+
   '       product1: product(id: \"'+AstrId+'\") '+
   '       { '+
   '         id '+
   '         createdDate '+
   '         partNumber '+
   '         vehicles { '+
   '           brand '+
   '           name '+
   '           startYear '+
   '           endYear '+
   '           engineConfiguration '+
   '           fuel '+
   '           engineName '+
   '           injectionSystem '+
   '           model '+
   '           transmissionType '+
   '         } '+
   '       } '+
   '     }" '+
   ' } ';
end;

end.
