unit untMaplinkPlanning;

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
  TTipoDepot = (depotPTCarga, depotPTIniciar, depotSite, depotPTFinalizar);

  {*************************** BEGIN OBJETO ENVIO *************************}
  TCustomerTimeWindowsClass = class
  private
    FEnd: Extended;
    FStart: Extended;
  public
    property &end: Extended read FEnd write FEnd;
    property start: Extended read FStart write FStart;
  end;

  TOperationsClass = class
  private
    FCustomerSite: String;
    FCustomerTimeWindows: TArray<TCustomerTimeWindowsClass>;
    FDepotSite: String;
    FId: String;
    FProduct: String;
    FType: String;
    FVolume: Extended;
    FWeight: Extended;

    procedure pAddCustomerTimeWindows(CustomerTimeWindowsClass: TCustomerTimeWindowsClass);
  public
    property customerSite: String read FCustomerSite write FCustomerSite;
    property customerTimeWindows: TArray<TCustomerTimeWindowsClass> read FCustomerTimeWindows write FCustomerTimeWindows;
    property depotSite: String read FDepotSite write FDepotSite;
    property id: String read FId write FId;
    property product: String read FProduct write FProduct;
    property &type: String read FType write FType;
    property volume: Extended read FVolume write FVolume;
    property weight: Extended read FWeight write FWeight;
    destructor Destroy; override;
  end;

  TTripClass = class
  private
    FAvoidanceTypes: TArray<String>;
    FCalculationMode: String;
  public
    property avoidanceTypes: TArray<String> read FAvoidanceTypes write FAvoidanceTypes;
    property calculationMode: String read FCalculationMode write FCalculationMode;
  end;

  TTimeWindowClass = class
  private
    FEnd: Extended;
    FStart: Extended;
  public
    property &end: Extended read FEnd write FEnd;
    property start: Extended read FStart write FStart;
  end;

  TAvailablePeriodsClass = class
  private
    FArrivalSite: String;
    FDepartureSite: String;
    FTimeWindow: TTimeWindowClass;
  public
    property arrivalSite: String read FArrivalSite write FArrivalSite;
    property departureSite: String read FDepartureSite write FDepartureSite;
    property timeWindow: TTimeWindowClass read FTimeWindow write FTimeWindow;
    constructor Create;
    destructor Destroy; override;
  end;

  TVehiclesClass = class
  private
    FAvailablePeriods: TArray<TAvailablePeriodsClass>;
    FLegislationProfile: String;
    FName: String;
    FVehicleType: String;

    procedure pAddAvailablePeriods(AvailablePeriodsClass: TAvailablePeriodsClass);
  public
    property availablePeriods: TArray<TAvailablePeriodsClass> read FAvailablePeriods write FAvailablePeriods;
    property legislationProfile: String read FLegislationProfile write FLegislationProfile;
    property name: String read FName write FName;
    property vehicleType: String read FVehicleType write FVehicleType;
    destructor Destroy; override;
  end;

  TVehicleTypesClass = class
  private
    FMaxVolume: Extended;
    FMaxWeight: Extended;
    FName: String;
    FSize: Extended;
    FTrip: TTripClass;
  public
    property maxVolume: Extended read FMaxVolume write FMaxVolume;
    property maxWeight: Extended read FMaxWeight write FMaxWeight;
    property name: String read FName write FName;
    property size: Extended read FSize write FSize;
    property trip: TTripClass read FTrip write FTrip;
    constructor Create;
    destructor Destroy; override;
  end;

  TCoordinatesClass = class
  private
    FLatitude: Extended;
    FLongitude: Extended;
  public
    property latitude: Extended read FLatitude write FLatitude;
    property longitude: Extended read FLongitude write FLongitude;
  end;

  TDepotsClass = class
  private
    FCoordinates: TCoordinatesClass;
    FLogisticConstraints: String;
    FName: String;
  public
    property coordinates: TCoordinatesClass read FCoordinates write FCoordinates;
    property logisticConstraints: String read FLogisticConstraints write FLogisticConstraints;
    property name: String read FName write FName;
    constructor Create;
    destructor Destroy; override;
  end;

  TSitesClass = class
  private
    FCoordinates: TCoordinatesClass;
    FLogisticConstraints: String;
    FName: String;
  public
    property coordinates: TCoordinatesClass read FCoordinates write FCoordinates;
    property logisticConstraints: String read FLogisticConstraints write FLogisticConstraints;
    property name: String read FName write FName;
    constructor Create;
    destructor Destroy; override;
  end;

  TProductsClass = class
  private
    FName: String;
  public
    property name: String read FName write FName;
  end;

  TLogisticConstraintsClass = class
  private
    FName: String;
    FUnloadingPositionInRoute: String;
  public
    property name: String read FName write FName;
    property unloadingPositionInRoute: String read FUnloadingPositionInRoute write FUnloadingPositionInRoute;
  end;

  TLegislationProfilesClass = class
  private
    FName: String;
  public
    property name: String read FName write FName;
  end;

  TMaplinkPlanning = class
  private
    FDepots: TArray<TDepotsClass>;
    FLegislationProfiles: TArray<TLegislationProfilesClass>;
    FLogisticConstraints: TArray<TLogisticConstraintsClass>;
    FOperations: TArray<TOperationsClass>;
    FOptimizationProfile: String;
    FProducts: TArray<TProductsClass>;
    FSites: TArray<TSitesClass>;
    FStartDate: Extended;
    FTripsProfile: String;
    FVehicleTypes: TArray<TVehicleTypesClass>;
    FVehicles: TArray<TVehiclesClass>;

    procedure pAddDepots(DepotsClass: TDepotsClass);
    procedure pAddLegislationProfiles(LegislationProfilesClass: TLegislationProfilesClass);
    procedure pAddLogisticConstraints(LogisticConstraintsClass: TLogisticConstraintsClass);
    procedure pAddOperations(OperationsClass: TOperationsClass);
    procedure pAddProducts(ProductsClass: TProductsClass);
    procedure pAddSites(SitesClass: TSitesClass);
    procedure pAddVehicleTypes(VehicleTypesClass: TVehicleTypesClass);
    procedure pAddVehicles(VehiclesClass: TVehiclesClass);
  public
    property depots: TArray<TDepotsClass> read FDepots write FDepots;
    property legislationProfiles: TArray<TLegislationProfilesClass> read FLegislationProfiles write FLegislationProfiles;
    property logisticConstraints: TArray<TLogisticConstraintsClass> read FLogisticConstraints write FLogisticConstraints;
    property operations: TArray<TOperationsClass> read FOperations write FOperations;
    property optimizationProfile: String read FOptimizationProfile write FOptimizationProfile;
    property products: TArray<TProductsClass> read FProducts write FProducts;
    property sites: TArray<TSitesClass> read FSites write FSites;
    property startDate: Extended read FStartDate write FStartDate;
    property tripsProfile: String read FTripsProfile write FTripsProfile;
    property vehicleTypes: TArray<TVehicleTypesClass> read FVehicleTypes write FVehicleTypes;
    property vehicles: TArray<TVehiclesClass> read FVehicles write FVehicles;
    destructor Destroy; override;
    function ToJsonString: string;
  end;
  {***************************  END OBJETO ENVIO  *************************}

  {************************** BEGIN OBJETO RETORNO ************************}
  TIndicatorsClass = class
  private
    FAverageOccupancyRateVolume: Extended;
    FAverageOccupancyRateWeight: Extended;
    FDayWorkingTotalTime: Extended;
    FNightWorkingTotalTime: Extended;
    FRejectOperationsNumber: Extended;
    FRoutesNumber: Extended;
    FTimeWindowNumber: Extended;
    FTotalCollectingTime: Extended;
    FTotalDeliveringTime: Extended;
    FTotalDistance: Extended;
    FTotalDrivingTime: Extended;
    FTotalLoadingTime: Extended;
    FTotalRestTime: Extended;
    FTotalServiceTime: Extended;
    FTotalTime: Integer;
    FTotalUnloadingTime: Extended;
    FTotalWaitingTime: Extended;
    FTotalWorkingTime: Extended;
  public
    property averageOccupancyRateVolume: Extended read FAverageOccupancyRateVolume write FAverageOccupancyRateVolume;
    property averageOccupancyRateWeight: Extended read FAverageOccupancyRateWeight write FAverageOccupancyRateWeight;
    property dayWorkingTotalTime: Extended read FDayWorkingTotalTime write FDayWorkingTotalTime;
    property nightWorkingTotalTime: Extended read FNightWorkingTotalTime write FNightWorkingTotalTime;
    property rejectOperationsNumber: Extended read FRejectOperationsNumber write FRejectOperationsNumber;
    property routesNumber: Extended read FRoutesNumber write FRoutesNumber;
    property timeWindowNumber: Extended read FTimeWindowNumber write FTimeWindowNumber;
    property totalCollectingTime: Extended read FTotalCollectingTime write FTotalCollectingTime;
    property totalDeliveringTime: Extended read FTotalDeliveringTime write FTotalDeliveringTime;
    property totalDistance: Extended read FTotalDistance write FTotalDistance;
    property totalDrivingTime: Extended read FTotalDrivingTime write FTotalDrivingTime;
    property totalLoadingTime: Extended read FTotalLoadingTime write FTotalLoadingTime;
    property totalRestTime: Extended read FTotalRestTime write FTotalRestTime;
    property totalServiceTime: Extended read FTotalServiceTime write FTotalServiceTime;
    property totalTime: Integer read FTotalTime write FTotalTime;
    property totalUnloadingTime: Extended read FTotalUnloadingTime write FTotalUnloadingTime;
    property totalWaitingTime: Extended read FTotalWaitingTime write FTotalWaitingTime;
    property totalWorkingTime: Extended read FTotalWorkingTime write FTotalWorkingTime;
  end;

  TPeriodClass = class
  private
    FArrivalSite: String;
    FDepartureSite: String;
    FTimeWindow: TTimeWindowClass;
  public
    property arrivalSite: String read FArrivalSite write FArrivalSite;
    property departureSite: String read FDepartureSite write FDepartureSite;
    property timeWindow: TTimeWindowClass read FTimeWindow write FTimeWindow;
    constructor Create;
    destructor Destroy; override;
  end;

  TActivitiesClass = class
  private
    FActivity: String;
    FArrivalSite: String;
    FDepartureSite: String;
    FDistance: Extended;
    FFixedTimeSite: Extended;
    FNominalDuration: Extended;
    FOperations: TArray<String>;
    FSite: String;
    FTimeWindow: TTimeWindowClass;
    FType: String;
  public
    property activity: String read FActivity write FActivity;
    property arrivalSite: String read FArrivalSite write FArrivalSite;
    property departureSite: String read FDepartureSite write FDepartureSite;
    property distance: Extended read FDistance write FDistance;
    property fixedTimeSite: Extended read FFixedTimeSite write FFixedTimeSite;
    property nominalDuration: Extended read FNominalDuration write FNominalDuration;
    property operations: TArray<String> read FOperations write FOperations;
    property site: String read FSite write FSite;
    property timeWindow: TTimeWindowClass read FTimeWindow write FTimeWindow;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TRoutesClass = class
  private
    FActivities: TArray<TActivitiesClass>;
    FId: String;
    FTripId: String;
  public
    property activities: TArray<TActivitiesClass> read FActivities write FActivities;
    property id: String read FId write FId;
    property tripId: String read FTripId write FTripId;
    destructor Destroy; override;
  end;

  TVehicleRoutesClass = class
  private
    FPeriod: TPeriodClass;
    FRoutes: TArray<TRoutesClass>;
    FVehicle: String;
  public
    property period: TPeriodClass read FPeriod write FPeriod;
    property routes: TArray<TRoutesClass> read FRoutes write FRoutes;
    property vehicle: String read FVehicle write FVehicle;
    constructor Create;
    destructor Destroy; override;
  end;

  TRetornoMaplinkPlanning = class
  private
    FClientId: String;
    FId: String;
    FIndicators: TIndicatorsClass;
    FVehicleRoutes: TArray<TVehicleRoutesClass>;
  public
    property clientId: String read FClientId write FClientId;
    property id: String read FId write FId;
    property indicators: TIndicatorsClass read FIndicators write FIndicators;
    property vehicleRoutes: TArray<TVehicleRoutesClass> read FVehicleRoutes write FVehicleRoutes;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoMaplinkPlanning;
  end;
  {**************************  END OBJETO RETORNO  ************************}

  TControllerMaplinkPlanning = class
  private
    class function fProblem(MaplinkPlanning: TMaplinkPlanning; var strMsgRetorno: String): TRetornoMaplinkPlanning;
    class function fSolutions(strId: String; var strMsgRetorno: String): TRetornoMaplinkPlanning;
    class function fJobs(strId: String): TMaplinkJobs;

    class function fProblemEstaSendoSolucionado(strId: String; var strMsgRetorno: String): Boolean;

    class function fAvailablePeriods: TAvailablePeriodsClass;
    class function fVehicles: TVehiclesClass;
    class function fVehicleTypes(calculationMode: String; avoidanceTypes: TArray<String>): TVehicleTypesClass;
    class function fOperations(cdsMaps: TUniClientDataSet; blnCalcularConformeOrdemDefinida: Boolean = False): TOperationsClass;
    class function fCustomerTimeWindows: TCustomerTimeWindowsClass;
    class function fSites(cdsMaps: TUniClientDataSet): TSitesClass;
    class function fDepots(cdsMaps: TUniClientDataSet; TipoDepot: TTipoDepot; strCoordenada: String = ''): TDepotsClass;
    class function fProducts: TProductsClass;
    class function fLogisticConstraintsDefault: TLogisticConstraintsClass;
    class function fLogisticConstraintsFirst: TLogisticConstraintsClass;
    class function fLogisticConstraintsLast: TLogisticConstraintsClass;
    class function fLegislationProfiles: TLegislationProfilesClass;
    class procedure pProcessaRota(RetornoMaplinkPlanning: TRetornoMaplinkPlanning;
      cdsMaps, cdsRomRet: TUniClientDataSet);
  public
    class function fPlanejarRota(cdsMaps,
                                 cdsRomRet: TUniClientDataSet;
                                 calculationMode: String;
                                 avoidanceTypes: TArray<String>;
                                 blnCalcularConformeOrdemDefinida: Boolean;
                                 var strMsgRetorno: String;
                                 strCoordenadaInicial: String = ''): Boolean;
  end;

  const
    //calculationMode
    THE_FASTEST = 'THE_FASTEST';
    THE_SHORTEST = 'THE_SHORTEST';

    //avoidanceTypes
    AVOID_TUNNELS = 'TUNNELS';
    AVOID_BRIDGES = 'BRIDGES';
    AVOID_FERRIES = 'FERRIES';
    AVOID_TOLL_ROADS = 'TOLL_ROADS';
    AVOID_TOLL_GATES = 'TOLL_GATES';

    DEFAULT = 'DEFAULT';
    PONTO_DE_CARREGAMENTO = 'PTC_';
    PONTO_DE_INICIO = 'PTI';
    PONTO_FINAL = 'PTF';
    TYPE_DELIVERY = 'DELIVERY';
    DEPOT_SITE = 'SITE_';

    POS_FIRST = 'FIRST';
    POS_LAST = 'LAST';
    POS_INDIFFERENT = 'INDIFFERENT';

implementation

uses untMaplinkRestApi, untRestApi, untTypesSistema, untMapsDistanceMatrix;

{TOperationsClass}

destructor TOperationsClass.Destroy;
var
  LcustomerTimeWindowsItem: TCustomerTimeWindowsClass;
begin

 for LcustomerTimeWindowsItem in FCustomerTimeWindows do
   LcustomerTimeWindowsItem.free;

  inherited;
end;

procedure TOperationsClass.pAddCustomerTimeWindows(
  CustomerTimeWindowsClass: TCustomerTimeWindowsClass);
begin
  SetLength(FCustomerTimeWindows, Length(FCustomerTimeWindows)+1);
  FCustomerTimeWindows[Length(FCustomerTimeWindows)-1] := CustomerTimeWindowsClass;
end;

{TAvailablePeriodsClass}

constructor TAvailablePeriodsClass.Create;
begin
  inherited;
  FTimeWindow := TTimeWindowClass.Create();
end;

destructor TAvailablePeriodsClass.Destroy;
begin
  FTimeWindow.free;
  inherited;
end;

{TVehiclesClass}

destructor TVehiclesClass.Destroy;
var
  LavailablePeriodsItem: TAvailablePeriodsClass;
begin

  for LavailablePeriodsItem in FAvailablePeriods do
    LavailablePeriodsItem.free;

  inherited;
end;

procedure TVehiclesClass.pAddAvailablePeriods(
  AvailablePeriodsClass: TAvailablePeriodsClass);
begin
  SetLength(FAvailablePeriods, Length(FAvailablePeriods)+1);
  FAvailablePeriods[Length(FAvailablePeriods)-1] := AvailablePeriodsClass;
end;

{ TVehicleTypesClass }

constructor TVehicleTypesClass.Create;
begin
  FTrip := TTripClass.Create();
end;

destructor TVehicleTypesClass.Destroy;
begin
  FTrip.free;
  inherited;
end;

{TDepotsClass}

constructor TDepotsClass.Create;
begin
  inherited;
  FCoordinates := TCoordinatesClass.Create();
end;

destructor TDepotsClass.Destroy;
begin
  FCoordinates.free;
  inherited;
end;

{TSitesClass}

constructor TSitesClass.Create;
begin
  inherited;
  FCoordinates := TCoordinatesClass.Create();
end;

destructor TSitesClass.Destroy;
begin
  FCoordinates.free;
  inherited;
end;

{TMaplinkPlanning}

destructor TMaplinkPlanning.Destroy;
var
  LlegislationProfilesItem: TLegislationProfilesClass;
  LlogisticConstraintsItem: TLogisticConstraintsClass;
  LproductsItem: TProductsClass;
  LsitesItem: TSitesClass;
  LdepotsItem: TDepotsClass;
  LvehicleTypesItem: TVehicleTypesClass;
  LvehiclesItem: TVehiclesClass;
  LoperationsItem: TOperationsClass;
begin

 for LlegislationProfilesItem in FLegislationProfiles do
   LlegislationProfilesItem.free;

 for LlogisticConstraintsItem in FLogisticConstraints do
   LlogisticConstraintsItem.free;

 for LproductsItem in FProducts do
   LproductsItem.free;

 for LsitesItem in FSites do
   LsitesItem.free;

 for LdepotsItem in FDepots do
   LdepotsItem.free;

 for LvehicleTypesItem in FVehicleTypes do
   LvehicleTypesItem.free;

 for LvehiclesItem in FVehicles do
   LvehiclesItem.free;

 for LoperationsItem in FOperations do
   LoperationsItem.free;

  inherited;
end;

procedure TMaplinkPlanning.pAddDepots(DepotsClass: TDepotsClass);
begin
  SetLength(FDepots, Length(FDepots)+1);
  FDepots[Length(FDepots)-1] := DepotsClass;
end;

procedure TMaplinkPlanning.pAddLegislationProfiles(
  LegislationProfilesClass: TLegislationProfilesClass);
begin
  SetLength(FLegislationProfiles, Length(FLegislationProfiles)+1);
  FLegislationProfiles[Length(FLegislationProfiles)-1] := LegislationProfilesClass;
end;

procedure TMaplinkPlanning.pAddLogisticConstraints(
  LogisticConstraintsClass: TLogisticConstraintsClass);
begin
  SetLength(FLogisticConstraints, Length(FLogisticConstraints)+1);
  FLogisticConstraints[Length(FLogisticConstraints)-1] := LogisticConstraintsClass;
end;

procedure TMaplinkPlanning.pAddOperations(OperationsClass: TOperationsClass);
begin
  SetLength(FOperations, Length(FOperations)+1);
  FOperations[Length(FOperations)-1] := OperationsClass;
end;

procedure TMaplinkPlanning.pAddProducts(ProductsClass: TProductsClass);
begin
  SetLength(FProducts, Length(FProducts)+1);
  FProducts[Length(FProducts)-1] := ProductsClass;
end;

procedure TMaplinkPlanning.pAddSites(SitesClass: TSitesClass);
begin
  SetLength(FSites, Length(FSites)+1);
  FSites[Length(FSites)-1] := SitesClass;
end;

procedure TMaplinkPlanning.pAddVehicles(VehiclesClass: TVehiclesClass);
begin
  SetLength(FVehicles, Length(FVehicles)+1);
  FVehicles[Length(FVehicles)-1] := VehiclesClass;
end;

procedure TMaplinkPlanning.pAddVehicleTypes(
  VehicleTypesClass: TVehicleTypesClass);
begin
  SetLength(FVehicleTypes, Length(FVehicleTypes)+1);
  FVehicleTypes[Length(FVehicleTypes)-1] := VehicleTypesClass;
end;

function TMaplinkPlanning.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{TPeriodClass}

constructor TPeriodClass.Create;
begin
  inherited;
  FTimeWindow := TTimeWindowClass.Create();
end;

destructor TPeriodClass.Destroy;
begin
  FTimeWindow.free;
  inherited;
end;

{TActivitiesClass}

constructor TActivitiesClass.Create;
begin
  inherited;
  FTimeWindow := TTimeWindowClass.Create();
end;

destructor TActivitiesClass.Destroy;
begin
  FTimeWindow.free;
  inherited;
end;

{TRoutesClass}

destructor TRoutesClass.Destroy;
var
  LactivitiesItem: TActivitiesClass;
begin

 for LactivitiesItem in FActivities do
   LactivitiesItem.free;

  inherited;
end;

{TVehicleRoutesClass}

constructor TVehicleRoutesClass.Create;
begin
  inherited;
  FPeriod := TPeriodClass.Create();
end;

destructor TVehicleRoutesClass.Destroy;
var
  LroutesItem: TRoutesClass;
begin

 for LroutesItem in FRoutes do
   LroutesItem.free;

  FPeriod.free;
  inherited;
end;

{TRetornoMaplinkPlanning}

constructor TRetornoMaplinkPlanning.Create;
begin
  inherited;
  FIndicators := TIndicatorsClass.Create();
end;

destructor TRetornoMaplinkPlanning.Destroy;
var
  LvehicleRoutesItem: TVehicleRoutesClass;
begin

 for LvehicleRoutesItem in FVehicleRoutes do
   LvehicleRoutesItem.free;

  FIndicators.free;
  inherited;
end;

class function TRetornoMaplinkPlanning.FromJsonString(AJsonString: string): TRetornoMaplinkPlanning;
begin
  result := TJson.JsonToObject<TRetornoMaplinkPlanning>(AJsonString);
end;


{ TControllerMaplinkPlanning }

class function TControllerMaplinkPlanning.fLegislationProfiles: TLegislationProfilesClass;
begin
  Result := TLegislationProfilesClass.Create;
  Result.name := DEFAULT;
end;

class function TControllerMaplinkPlanning.fLogisticConstraintsDefault: TLogisticConstraintsClass;
begin
  Result := TLogisticConstraintsClass.Create;
  Result.unloadingPositionInRoute := POS_INDIFFERENT;
  Result.name := POS_INDIFFERENT;
end;

class function TControllerMaplinkPlanning.fLogisticConstraintsFirst: TLogisticConstraintsClass;
begin
  Result := TLogisticConstraintsClass.Create;
  Result.unloadingPositionInRoute := POS_FIRST;
  Result.name := POS_FIRST;
end;

class function TControllerMaplinkPlanning.fLogisticConstraintsLast: TLogisticConstraintsClass;
begin
  Result := TLogisticConstraintsClass.Create;
  Result.unloadingPositionInRoute := POS_LAST;
  Result.name := POS_LAST;
end;

class function TControllerMaplinkPlanning.fProducts: TProductsClass;
begin
  Result := TProductsClass.Create;
  Result.name := DEFAULT;
end;

class function TControllerMaplinkPlanning.fDepots(cdsMaps: TUniClientDataSet; TipoDepot: TTipoDepot; strCoordenada: String = ''): TDepotsClass;
begin
  Result := TDepotsClass.Create;

  if TipoDepot = depotPTCarga then
  begin
    Result.name := PONTO_DE_CARREGAMENTO + cdsMaps.FieldByName('GER_CODEMP').AsString;
    Result.coordinates.latitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat);
    Result.coordinates.longitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon);
    Result.logisticConstraints := POS_INDIFFERENT;
  end

  else if TipoDepot = depotPTIniciar then
  begin
    Result.name := PONTO_DE_INICIO;
    Result.coordinates.latitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(strCoordenada, coorLat);
    Result.coordinates.longitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(strCoordenada, coorLon);
    Result.logisticConstraints := POS_INDIFFERENT;
  end

  else if TipoDepot = depotPTFinalizar then
  begin
    Result.name := PONTO_FINAL;
    Result.coordinates.latitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(strCoordenada, coorLat);
    Result.coordinates.longitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(strCoordenada, coorLon);
    Result.logisticConstraints := POS_INDIFFERENT;
  end

  else if TipoDepot = depotSite then
  begin
    Result.name := DEPOT_SITE+IntToStr(cdsMaps.RecNo);
    Result.coordinates.latitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat);
    Result.coordinates.longitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon);
    Result.logisticConstraints := POS_INDIFFERENT;
  end;
end;

class function TControllerMaplinkPlanning.fSites(cdsMaps: TUniClientDataSet): TSitesClass;
begin
  Result := TSitesClass.Create;
  Result.name := IntToStr(cdsMaps.RecNo);
  Result.coordinates.latitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLat);
  Result.coordinates.longitude := TControllerMapsDistanceMatrix.fRetCoordenadaExtended(cdsMaps.FieldByName('GER_LATLON').AsString, coorLon);

  case cdsMaps.FieldByName('PRIORIDADE').AsInteger of
    0: Result.logisticConstraints := POS_INDIFFERENT;
    1: Result.logisticConstraints := POS_FIRST;
    2: Result.logisticConstraints := POS_LAST;
  end;
end;

class function TControllerMaplinkPlanning.fCustomerTimeWindows: TCustomerTimeWindowsClass;
begin
  Result := TCustomerTimeWindowsClass.Create;
  Result.start := fDateTimeToUnix(fNow);
  Result.&end := fDateTimeToUnix(IncMonth(fNow));
end;

class function TControllerMaplinkPlanning.fOperations(cdsMaps: TUniClientDataSet; blnCalcularConformeOrdemDefinida: Boolean = False): TOperationsClass;
begin
  Result := TOperationsClass.Create;
  Result.id := IntToStr(cdsMaps.RecNo);
  Result.weight := cdsMaps.FieldByName('GER_PESBRU').AsFloat;
  Result.volume := cdsMaps.FieldByName('GER_VOLUME').AsFloat;
  Result.product := DEFAULT;
  Result.&type := TYPE_DELIVERY;

  if blnCalcularConformeOrdemDefinida then
    Result.depotSite := IIF(cdsMaps.RecNo > 1,
                            DEPOT_SITE+IntToStr(cdsMaps.RecNo-1),
                            PONTO_DE_INICIO)
  else
    Result.depotSite := IIF(fEmptyStr(cdsMaps.FieldByName('CARGANAFILIAL').AsString),
                            PONTO_DE_INICIO,
                            PONTO_DE_CARREGAMENTO + Trim(cdsMaps.FieldByName('CARGANAFILIAL').AsString));

  Result.customerSite := IntToStr(cdsMaps.RecNo);
  Result.pAddCustomerTimeWindows(fCustomerTimeWindows);
end;

class function TControllerMaplinkPlanning.fVehicleTypes(calculationMode: String; avoidanceTypes: TArray<String>): TVehicleTypesClass;
begin
  Result := TVehicleTypesClass.Create;
  Result.name := DEFAULT;
  Result.maxVolume := 99999999;
  Result.maxWeight := 99999999;
  Result.size := 1;
  Result.trip.calculationMode := calculationMode;
  if Length(avoidanceTypes) > 0 then
    Result.trip.avoidanceTypes := avoidanceTypes;
end;

class function TControllerMaplinkPlanning.fVehicles: TVehiclesClass;
begin
  Result := TVehiclesClass.Create;
  Result.name := DEFAULT;
  Result.vehicleType := DEFAULT;
  Result.legislationProfile := DEFAULT;
  Result.pAddAvailablePeriods(fAvailablePeriods);
end;

class function TControllerMaplinkPlanning.fAvailablePeriods: TAvailablePeriodsClass;
begin
  Result := TAvailablePeriodsClass.Create;
  Result.departureSite := PONTO_DE_INICIO;
  Result.arrivalSite := PONTO_FINAL;
  Result.timeWindow.start := fDateTimeToUnix(fNow);
  Result.timeWindow.&end := fDateTimeToUnix(IncMonth(fNow));
end;

class function TControllerMaplinkPlanning.fPlanejarRota(cdsMaps,
                                                        cdsRomRet: TUniClientDataSet;
                                                        calculationMode: String;
                                                        avoidanceTypes: TArray<String>;
                                                        blnCalcularConformeOrdemDefinida: Boolean;
                                                        var strMsgRetorno: String;
                                                        strCoordenadaInicial: String = ''): Boolean;
const
  OPTIMIZATIONPROFILE = 'BRAZIL_VRP_PICKUP';
  OPTIMIZATIONPROFILE_ROTA_DEFINIDA = 'CITELDEV';
  TRIPSPROFILE = 'MAPLINK';
var
  MaplinkPlanning: TMaplinkPlanning;
  RetornoMaplinkPlanning: TRetornoMaplinkPlanning;

  strBkpIndexCds: String;
begin
  Result := True;

  cdsMaps.DisableControls;

  if not blnCalcularConformeOrdemDefinida then
  begin
    strBkpIndexCds := cdsMaps.IndexFieldNames;
    cdsMaps.IndexFieldNames := EmptyStr;
  end;

  MaplinkPlanning := TMaplinkPlanning.Create;
  try
    try
      MaplinkPlanning.optimizationProfile := IIF(blnCalcularConformeOrdemDefinida, OPTIMIZATIONPROFILE_ROTA_DEFINIDA, OPTIMIZATIONPROFILE);
      MaplinkPlanning.tripsProfile := TRIPSPROFILE;
      MaplinkPlanning.startDate := fDateTimeToUnix(fNow);

      MaplinkPlanning.pAddLegislationProfiles(fLegislationProfiles);

      MaplinkPlanning.pAddLogisticConstraints(fLogisticConstraintsDefault);

      MaplinkPlanning.pAddLogisticConstraints(fLogisticConstraintsFirst);

      MaplinkPlanning.pAddLogisticConstraints(fLogisticConstraintsLast);

      MaplinkPlanning.pAddProducts(fProducts);

      MaplinkPlanning.pAddVehicleTypes(fVehicleTypes(calculationMode, avoidanceTypes));

      MaplinkPlanning.pAddDepots(fDepots(nil, depotPTIniciar, IIF(fEmptyStr(strCoordenadaInicial),
                                                                  cdsMaps.FieldByName('GER_INIPAR').AsString,
                                                                  strCoordenadaInicial)));

      MaplinkPlanning.pAddDepots(fDepots(nil, depotPTFinalizar, IIF(fEmptyStr(cdsMaps.FieldByName('GER_FINROT').AsString),
                                                                    cdsMaps.FieldByName('GER_INIPAR').AsString,
                                                                    cdsMaps.FieldByName('GER_FINROT').AsString)));

      MaplinkPlanning.pAddVehicles(fVehicles);

      cdsMaps.First;
      while not cdsMaps.Eof do
      begin
        if (not blnCalcularConformeOrdemDefinida) and
           (cdsMaps.FieldByName('GER_FILIAL').AsString = 'S') then
          MaplinkPlanning.pAddDepots(fDepots(cdsMaps, depotPTCarga))
        else
        begin
          if blnCalcularConformeOrdemDefinida then
            MaplinkPlanning.pAddDepots(fDepots(cdsMaps, depotSite));

          MaplinkPlanning.pAddSites(fSites(cdsMaps));
          MaplinkPlanning.pAddOperations(fOperations(cdsMaps, blnCalcularConformeOrdemDefinida));
        end;

        cdsMaps.Edit;
        cdsMaps.FieldByName('GER_LOCALI').AsString := IIF(fEmptyStr(cdsMaps.FieldByName('GER_LOCALI').AsString),
                                                          'ERRO',
                                                          cdsMaps.FieldByName('GER_LOCALI').AsString);
        cdsMaps.FieldByName('GER_DISTAN').AsFloat  := 0;
        cdsMaps.FieldByName('GER_TMPENT').AsFloat  := 0;

        if not blnCalcularConformeOrdemDefinida then
          cdsMaps.FieldByName('GER_ORDIMP').AsInteger := 999;

        cdsMaps.Post;

        cdsMaps.Next;
      end;

      RetornoMaplinkPlanning := fProblem(MaplinkPlanning, strMsgRetorno);
      if (Assigned(RetornoMaplinkPlanning)) and (Assigned(RetornoMaplinkPlanning.vehicleRoutes[0].routes)) then
        pProcessaRota(RetornoMaplinkPlanning, cdsMaps, cdsRomRet)
      else
      begin
        if fEmptyStr(strMsgRetorno) then
          strMsgRetorno := 'Ocorreu uma falha na comunicação com a PLANNING API!';

        Result := False;
      end;

    except
      on E: Exception do
      begin
        if fEmptyStr(strMsgRetorno) then
          strMsgRetorno := 'Ocorreram erros ao planejar a rota!';

        Result := False;

        {$IFNDEF LINUX}
        pMensagensErro(E.Message, 'TControllerMaplinkPlanning.fPlanejarRota');
        {$ENDIF LINUX}
      end;
    end;
  finally
    FreeAndNil(MaplinkPlanning);

    if Assigned(RetornoMaplinkPlanning) then
      FreeAndNil(RetornoMaplinkPlanning);

    if not blnCalcularConformeOrdemDefinida then
      cdsMaps.IndexFieldNames := strBkpIndexCds;

    cdsMaps.EnableControls;
  end;

end;

class procedure TControllerMaplinkPlanning.pProcessaRota(RetornoMaplinkPlanning: TRetornoMaplinkPlanning;
  cdsMaps, cdsRomRet: TUniClientDataSet);
const
  ACT_DRIVING = 'DRIVING';
  ACT_LOADING = 'LOADING';
  ACT_DELIVERY = 'DELIVERY';
  ACT_ROUTE_END = 'ROUTE_END';
var
  Route: TRoutesClass;
  Activities: TActivitiesClass;
  fltDistancia,
  fltTempo: Double;

  intOrdem: Integer;

  blnEstaNoLocalDeEntrega: Boolean;
begin
  fltDistancia := 0;
  fltTempo := 0;
  intOrdem := 0;
  blnEstaNoLocalDeEntrega := False;

  for Route in RetornoMaplinkPlanning.vehicleRoutes[0].routes do
  begin
    for Activities in Route.activities do
    begin
      if Activities.activity = ACT_DRIVING then
      begin
        blnEstaNoLocalDeEntrega := False;

        fltDistancia := RoundTo(Activities.distance / 1000, -2);
        fltTempo := Activities.nominalDuration;
      end;

      if Activities.activity = ACT_LOADING then
      begin
        if cdsMaps.Locate('GER_FILIAL;GER_CODEMP', VarArrayOf(['S', Copy(Activities.site, Pos('_', Activities.site)+1)]),[]) then
        begin
          Inc(intOrdem);

          cdsMaps.Edit;
          cdsMaps.FieldByName('GER_LOCALI').AsString := IIF(cdsMaps.FieldByName('GER_LOCALI').AsString = 'ERRO', 'OK', cdsMaps.FieldByName('GER_LOCALI').AsString);
          cdsMaps.FieldByName('GER_DISTAN').AsFloat  := fltDistancia;
          cdsMaps.FieldByName('GER_TMPENT').AsFloat  := fltTempo;
          cdsMaps.FieldByName('GER_ORDIMP').AsInteger := intOrdem;
          cdsMaps.Post;
        end;

        Continue;
      end;

      if Activities.activity = ACT_DELIVERY then
      begin
        cdsMaps.RecNo := StrToInt(Activities.site);

        Inc(intOrdem);

        cdsMaps.Edit;
        cdsMaps.FieldByName('GER_LOCALI').AsString := IIF(cdsMaps.FieldByName('GER_LOCALI').AsString = 'ERRO', 'OK', cdsMaps.FieldByName('GER_LOCALI').AsString);
        cdsMaps.FieldByName('GER_DISTAN').AsFloat  := IIF(blnEstaNoLocalDeEntrega, 0, fltDistancia);
        cdsMaps.FieldByName('GER_TMPENT').AsFloat  := IIF(blnEstaNoLocalDeEntrega, 0, fltTempo);
        cdsMaps.FieldByName('GER_ORDIMP').AsInteger := intOrdem;
        cdsMaps.Post;

        blnEstaNoLocalDeEntrega := True;

        Continue;
      end;

      if Activities.activity = ACT_ROUTE_END then
      begin
        cdsRomRet.EmptyDataSet;
        if not fEmptyStr(cdsMaps.FieldByName('GER_FINROT').AsString) then
        begin
          cdsRomRet.Append;
          cdsRomRet.FieldByName('RET_DISTAN').AsFloat := fltDistancia;
          cdsRomRet.FieldByName('RET_TMPRET').AsFloat := fltTempo;
          cdsRomRet.Post;
        end;

        Continue;
      end;

    end;
  end;
end;

class function TControllerMaplinkPlanning.fProblem(MaplinkPlanning: TMaplinkPlanning;
                                                   var strMsgRetorno: String): TRetornoMaplinkPlanning;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  IdRetornoMaplinkPlanning: TMaplinkIDRetorno;

  JSONRetorno: String;
begin
  Result := nil;
  IdRetornoMaplinkPlanning := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'planning/v1/problems';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               MaplinkPlanning.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '201'], '') then
    begin
      IdRetornoMaplinkPlanning := TMaplinkIDRetorno.FromJsonString(JSONRetorno);
      Result := TControllerMaplinkPlanning.fSolutions(IdRetornoMaplinkPlanning.id, strMsgRetorno);
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;

    if Assigned(IdRetornoMaplinkPlanning) then
      IdRetornoMaplinkPlanning.Free;
  end;
end;

class function TControllerMaplinkPlanning.fSolutions(strId: String; var strMsgRetorno: String): TRetornoMaplinkPlanning;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'planning/v1/solutions/'+strId;
    RestRequest.Method := rmGET;

    repeat

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      begin
        Result := TRetornoMaplinkPlanning.FromJsonString(JSONRetorno);
        Break;
      end;

      Sleep(5000);
      {$IFNDEF LINUX}
      Application.ProcessMessages;
      {$ENDIF LINUX}

      if not fProblemEstaSendoSolucionado(strId, strMsgRetorno) then
        Break;

    until RestRequest.Response.StatusCode <> 404;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TControllerMaplinkPlanning.fProblemEstaSendoSolucionado(strId: String; var strMsgRetorno: String): Boolean;
var
  RetornoMaplinkPlanningJobs: TMaplinkJobs;
begin
  Result := True;

  RetornoMaplinkPlanningJobs := fJobs(strId);
  if Assigned(RetornoMaplinkPlanningJobs) then
  begin
    Result := not (RetornoMaplinkPlanningJobs.&type = 'ERROR');
    if not Result then
      strMsgRetorno := 'Não encontramos uma rota com as opções selecionadas. Por favor, tente novamente com outras opções de planejamento!';
  end;
end;

class function TControllerMaplinkPlanning.fJobs(strId: String): TMaplinkJobs;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'planning/v1/jobs/'+strId;
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TMaplinkJobs.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
