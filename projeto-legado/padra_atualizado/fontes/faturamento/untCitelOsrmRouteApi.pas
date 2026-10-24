unit untCitelOsrmRouteApi;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, DateUtils, System.Variants,
  System.JSON, strUtils, System.Classes, Math,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.Forms, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

  TWaypointsClass = class
  private
    FDistance: Extended;
    FHint: String;
    FLocation: TArray<Extended>;
    FName: String;
  public
    property distance: Extended read FDistance write FDistance;
    property hint: String read FHint write FHint;
    property location: TArray<Extended> read FLocation write FLocation;
    property name: String read FName write FName;
  end;

  TIntersectionsClass = class
  private
    FBearings: TArray<Extended>;
    FEntry: TArray<Boolean>;
    FLocation: TArray<Extended>;
    FOut: Extended;
  public
    property bearings: TArray<Extended> read FBearings write FBearings;
    property entry: TArray<Boolean> read FEntry write FEntry;
    property location: TArray<Extended> read FLocation write FLocation;
    property &out: Extended read FOut write FOut;
  end;

  TManeuverClass = class
  private
    FBearing_after: Extended;
    FBearing_before: Extended;
    FLocation: TArray<Extended>;
    FType: String;
  public
    property bearing_after: Extended read FBearing_after write FBearing_after;
    property bearing_before: Extended read FBearing_before write FBearing_before;
    property location: TArray<Extended> read FLocation write FLocation;
    property &type: String read FType write FType;
  end;

  TStepsClass = class
  private
    FDistance: Extended;
    FDriving_side: String;
    FDuration: Extended;
    FGeometry: String;
    FIntersections: TArray<TIntersectionsClass>;
    FManeuver: TManeuverClass;
    FMode: String;
    FName: String;
    FWeight: Extended;
  public
    property distance: Extended read FDistance write FDistance;
    property driving_side: String read FDriving_side write FDriving_side;
    property duration: Extended read FDuration write FDuration;
    property geometry: String read FGeometry write FGeometry;
    property intersections: TArray<TIntersectionsClass> read FIntersections write FIntersections;
    property maneuver: TManeuverClass read FManeuver write FManeuver;
    property mode: String read FMode write FMode;
    property name: String read FName write FName;
    property weight: Extended read FWeight write FWeight;
    constructor Create;
    destructor Destroy; override;
  end;

  TLegsClass = class
  private
    FDistance: Extended;
    FDuration: Extended;
    FSteps: TArray<TStepsClass>;
    FSummary: String;
    FWeight: Extended;
  public
    property distance: Extended read FDistance write FDistance;
    property duration: Extended read FDuration write FDuration;
    property steps: TArray<TStepsClass> read FSteps write FSteps;
    property summary: String read FSummary write FSummary;
    property weight: Extended read FWeight write FWeight;
    destructor Destroy; override;
  end;

  TRoutesClass = class
  private
    FDistance: Extended;
    FDuration: Extended;
    FGeometry: String;
    FLegs: TArray<TLegsClass>;
    FWeight: Extended;
    FWeight_name: String;
  public
    property distance: Extended read FDistance write FDistance;
    property duration: Extended read FDuration write FDuration;
    property geometry: String read FGeometry write FGeometry;
    property legs: TArray<TLegsClass> read FLegs write FLegs;
    property weight: Extended read FWeight write FWeight;
    property weight_name: String read FWeight_name write FWeight_name;
    destructor Destroy; override;
  end;

  TCitelOsrmRouteApi = class
  private
    FCode: String;
    FRoutes: TArray<TRoutesClass>;
    FWaypoints: TArray<TWaypointsClass>;

    class function FromJsonString(const AJsonString: string): TCitelOsrmRouteApi;
    class function fGetRoute(const ACoordenadas: String): TCitelOsrmRouteApi;
  public
    property code: String read FCode write FCode;
    property routes: TArray<TRoutesClass> read FRoutes write FRoutes;
    property waypoints: TArray<TWaypointsClass> read FWaypoints write FWaypoints;
    destructor Destroy; override;

    class function fRetIntersectionsArray(arrWayPoints: TArray<String>): TArray<TArray<String>>;
  end;

implementation

{TStepsClass}

uses untCitelOsrmRestApi, untRestApi;

constructor TStepsClass.Create;
begin
  inherited;
  FManeuver := TManeuverClass.Create();
end;

destructor TStepsClass.Destroy;
var
  LintersectionsItem: TIntersectionsClass;
begin

 for LintersectionsItem in FIntersections do
   LintersectionsItem.free;

  FManeuver.free;
  inherited;
end;


{TLegsClass}

destructor TLegsClass.Destroy;
var
  LstepsItem: TStepsClass;
begin

 for LstepsItem in FSteps do
   LstepsItem.free;

  inherited;
end;


{TRoutesClass}

destructor TRoutesClass.Destroy;
var
  LlegsItem: TLegsClass;
begin

 for LlegsItem in FLegs do
   LlegsItem.free;

  inherited;
end;


{TCitelOsrmRouteApi}

destructor TCitelOsrmRouteApi.Destroy;
var
  LroutesItem: TRoutesClass;
  LwaypointsItem: TWaypointsClass;
begin

 for LroutesItem in FRoutes do
   LroutesItem.free;
 for LwaypointsItem in FWaypoints do
   LwaypointsItem.free;

  inherited;
end;

class function TCitelOsrmRouteApi.FromJsonString(const AJsonString: string): TCitelOsrmRouteApi;
begin
  result := TJson.JsonToObject<TCitelOsrmRouteApi>(AJsonString);
end;

class function TCitelOsrmRouteApi.fGetRoute(const ACoordenadas: String): TCitelOsrmRouteApi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CITEL_OSRM', TControllerCitelOsrmRestApi.fConfigurarCitelOsrm);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'route/v1/driving/'+ACoordenadas;
    RestRequest.Params.AddItem('steps', 'true', pkGETorPOST);
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TCitelOsrmRouteApi.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TCitelOsrmRouteApi.fRetIntersectionsArray(arrWayPoints: TArray<String>): TArray<TArray<String>>;
var
  LIntCount: Integer;
  LStrCoordenada: String;

  CitelOsrmRouteApi: TCitelOsrmRouteApi;
  Leg: TLegsClass;
  Step: TStepsClass;
  Intersection: TIntersectionsClass;
begin
  SetLength(Result, 0);

  LStrCoordenada := EmptyStr;
  for LIntCount := 0 to high(arrWayPoints) do
  begin
    LStrCoordenada := IIF(not fEmptyStr(LStrCoordenada), LStrCoordenada+';', '') + arrWayPoints[LIntCount];

    if ((LIntCount > 0) and (LIntCount mod 300 = 0)) or (LIntCount = high(arrWayPoints)) then
    begin
      CitelOsrmRouteApi := TCitelOsrmRouteApi.fGetRoute(LStrCoordenada);
      if not Assigned(CitelOsrmRouteApi) then
        Exit;
      try
        for Leg in CitelOsrmRouteApi.routes[0].legs do
        begin
          for Step in Leg.steps do
          begin
            for Intersection in Step.intersections do
            begin
              SetLength(Result, Length(Result)+1);
              SetLength(Result[Length(Result)-1], 2);

              Result[Length(Result)-1][0] := FloatToStr(Intersection.location[1]);
              Result[Length(Result)-1][1] := FloatToStr(Intersection.location[0]);
            end;
          end;
        end;
      finally
        FreeAndNil(CitelOsrmRouteApi);
      end;
      LStrCoordenada := EmptyStr;
    end;
  end;
end;

end.
