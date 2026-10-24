unit untMaplinkMatrixDistance;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, DateUtils, System.Variants,
  System.JSON, strUtils, System.Classes, Math,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.Forms, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni, untMaplinkIDRetorno, untMaplinkJobs;

type

  TOriginsClass = class
  private
    FLatitude: Extended;
    FLongitude: Extended;
    FSiteId: String;
  public
    property latitude: Extended read FLatitude write FLatitude;
    property longitude: Extended read FLongitude write FLongitude;
    property siteId: String read FSiteId write FSiteId;

    class function fNew: TOriginsClass;

    function f_latitude(AValue: Extended): TOriginsClass;
    function f_longitude(AValue: Extended): TOriginsClass;
    function f_siteId(AValue: String): TOriginsClass;
  end;

  TDestinationsClass = class
  private
    FLatitude: Extended;
    FLongitude: Extended;
    FSiteId: String;
  public
    property latitude: Extended read FLatitude write FLatitude;
    property longitude: Extended read FLongitude write FLongitude;
    property siteId: String read FSiteId write FSiteId;

    class function fNew: TDestinationsClass;

    function f_latitude(AValue: Extended): TDestinationsClass;
    function f_longitude(AValue: Extended): TDestinationsClass;
    function f_siteId(AValue: String): TDestinationsClass;
  end;

  TMaplinkMatrixDistance = class
  private
    FAvoidanceTypes: TArray<String>;
    FCalculationMode: String;
    FDestinations: TArray<TDestinationsClass>;
    FOrigins: TArray<TOriginsClass>;
    FTripProfile: String;
  public
    property avoidanceTypes: TArray<String> read FAvoidanceTypes write FAvoidanceTypes;
    property calculationMode: String read FCalculationMode write FCalculationMode;
    property destinations: TArray<TDestinationsClass> read FDestinations write FDestinations;
    property origins: TArray<TOriginsClass> read FOrigins write FOrigins;
    property tripProfile: String read FTripProfile write FTripProfile;
    procedure pDestroyOrigins;
    procedure pDestroyDestinations;
    destructor Destroy; override;
    function ToJsonString: string;
  end;

  TElementsClassMaplink = class
  private
    FAverageSpeed: Extended;
    FDestination: String;
    FDistance: Extended;
    FNominalDuration: Extended;
    FOrigin: String;
  public
    property averageSpeed: Extended read FAverageSpeed write FAverageSpeed;
    property destination: String read FDestination write FDestination;
    property distance: Extended read FDistance write FDistance;
    property nominalDuration: Extended read FNominalDuration write FNominalDuration;
    property origin: String read FOrigin write FOrigin;
  end;

  TRetornoMaplinkMatrixDistance = class
  private
    FClientId: String;
    FCreatedAt: Extended;
    FElements: TArray<TElementsClassMaplink>;
    FId: String;
  public
    property clientId: String read FClientId write FClientId;
    property createdAt: Extended read FCreatedAt write FCreatedAt;
    property elements: TArray<TElementsClassMaplink> read FElements write FElements;
    property id: String read FId write FId;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoMaplinkMatrixDistance;
  end;

  TControllerMaplinkMatrixDistance = class
  private
    class function fSolutions(strId: String): TRetornoMaplinkMatrixDistance;
    class function fProblemEstaSendoSolucionado(strId: String): Boolean;
    class function fJobs(strId: String): TMaplinkJobs;
  public
    class function fGetDistanceMatrix(MaplinkMatrixDistance: TMaplinkMatrixDistance): TRetornoMaplinkMatrixDistance;
  end;

implementation

{ TOriginsClass }

uses untRestApi, untMaplinkRestApi;

class function TOriginsClass.fNew: TOriginsClass;
begin
  Result := TOriginsClass.Create;
end;

function TOriginsClass.f_latitude(AValue: Extended): TOriginsClass;
begin
  FLatitude := AValue;
  Result := Self;
end;

function TOriginsClass.f_longitude(AValue: Extended): TOriginsClass;
begin
  FLongitude := AValue;
  Result := Self;
end;

function TOriginsClass.f_siteId(AValue: String): TOriginsClass;
begin
  FSiteId := AValue;
  Result := Self;
end;

{ TDestinationsClass }

class function TDestinationsClass.fNew: TDestinationsClass;
begin
  Result := TDestinationsClass.Create;
end;

function TDestinationsClass.f_latitude(
  AValue: Extended): TDestinationsClass;
begin
  FLatitude := AValue;
  Result := Self;
end;

function TDestinationsClass.f_longitude(
  AValue: Extended): TDestinationsClass;
begin
  FLongitude := AValue;
  Result := Self;
end;

function TDestinationsClass.f_siteId(AValue: String): TDestinationsClass;
begin
  FSiteId := AValue;
  Result := Self;
end;

{TMaplinkMatrixDistance}

destructor TMaplinkMatrixDistance.Destroy;
begin

 pDestroyDestinations;
 pDestroyOrigins;

  inherited;
end;

procedure TMaplinkMatrixDistance.pDestroyDestinations;
var
  LdestinationsItem: TDestinationsClass;
begin
 for LdestinationsItem in FDestinations do
   LdestinationsItem.free;
end;

procedure TMaplinkMatrixDistance.pDestroyOrigins;
var
  LoriginsItem: TOriginsClass;
begin
 for LoriginsItem in FOrigins do
   LoriginsItem.free;
end;

function TMaplinkMatrixDistance.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{TRetornoMaplinkMatrixDistance}

destructor TRetornoMaplinkMatrixDistance.Destroy;
var
  LelementsItem: TElementsClassMaplink;
begin

 for LelementsItem in FElements do
   LelementsItem.free;

  inherited;
end;

class function TRetornoMaplinkMatrixDistance.FromJsonString(AJsonString: string): TRetornoMaplinkMatrixDistance;
begin
  result := TJson.JsonToObject<TRetornoMaplinkMatrixDistance>(AJsonString)
end;

{ TControllerMaplinkMatrixDistance }

class function TControllerMaplinkMatrixDistance.fGetDistanceMatrix(MaplinkMatrixDistance: TMaplinkMatrixDistance): TRetornoMaplinkMatrixDistance;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  IdRetornoMaplinkMatrixDistance: TMaplinkIDRetorno;

  JSONRetorno: String;
begin
  Result := nil;
  IdRetornoMaplinkMatrixDistance := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'matrix/v1/problems';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               MaplinkMatrixDistance.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '201']) then
    begin
      IdRetornoMaplinkMatrixDistance := TMaplinkIDRetorno.FromJsonString(JSONRetorno);

      Sleep(1000);
      Result := TControllerMaplinkMatrixDistance.fSolutions(IdRetornoMaplinkMatrixDistance.id);
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;

    if Assigned(IdRetornoMaplinkMatrixDistance) then
      IdRetornoMaplinkMatrixDistance.Free;
  end;
end;

class function TControllerMaplinkMatrixDistance.fSolutions(strId: String): TRetornoMaplinkMatrixDistance;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'matrix/v1/solutions/'+strId;
    RestRequest.Method := rmGET;

    repeat

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      begin
        Result := TRetornoMaplinkMatrixDistance.FromJsonString(JSONRetorno);
        Break;
      end;

      if not fProblemEstaSendoSolucionado(strId) then
        Break;

      Sleep(500);
      {$IFNDEF LINUX}
      Application.ProcessMessages;
      {$ENDIF LINUX}

    until RestRequest.Response.StatusCode <> 404;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TControllerMaplinkMatrixDistance.fProblemEstaSendoSolucionado(strId: String): Boolean;
var
  RetornoMaplinkMatrixDistanceJobs: TMaplinkJobs;
begin
  Result := True;

  RetornoMaplinkMatrixDistanceJobs := fJobs(strId);
  if Assigned(RetornoMaplinkMatrixDistanceJobs) then
  begin
    Result := not (RetornoMaplinkMatrixDistanceJobs.&type = 'ERROR');
  end;
end;

class function TControllerMaplinkMatrixDistance.fJobs(strId: String): TMaplinkJobs;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'matrix/v1/jobs/'+strId;
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TMaplinkJobs.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
