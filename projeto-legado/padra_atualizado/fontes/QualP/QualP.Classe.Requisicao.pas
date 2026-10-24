unit QualP.Classe.Requisicao;

interface

uses
  QualP.Base.JSON, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TFreightTable = class;
  TFuelConsumption = class;
  TPrivatePlaces = class;
  TRoute = class;
  TTolls = class;
  TVehicle = class;

  TShow = class
  strict private
    [JSONName('freight_table')]
    FFreightTable: Boolean;
    [JSONName('fuel_consumption')]
    FFuelConsumption: Boolean;
    [JSONName('link_to_qualp')]
    FLinkToQualp: Boolean;
    [JSONName('link_to_qualp_report')]
    FLinkToQualpReport: Boolean;
    FManeuvers: string;
    FPolyline: Boolean;
    [JSONName('private_places')]
    FPrivatePlaces: Boolean;
    [JSONName('simplified_polyline')]
    FSimplifiedPolyline: Boolean;
    [JSONName('static_image')]
    FStaticImage: Boolean;
    FTolls: Boolean;
    [JSONName('truck_scales')]
    FTruckScales: Boolean;
    FUfs: Boolean;
  published
    property FreightTable: Boolean read FFreightTable write FFreightTable;
    property FuelConsumption: Boolean read FFuelConsumption write FFuelConsumption;
    property LinkToQualp: Boolean read FLinkToQualp write FLinkToQualp;
    property LinkToQualpReport: Boolean read FLinkToQualpReport write FLinkToQualpReport;
    property Maneuvers: string read FManeuvers write FManeuvers;
    property Polyline: Boolean read FPolyline write FPolyline;
    property PrivatePlaces: Boolean read FPrivatePlaces write FPrivatePlaces;
    property SimplifiedPolyline: Boolean read FSimplifiedPolyline write FSimplifiedPolyline;
    property StaticImage: Boolean read FStaticImage write FStaticImage;
    property Tolls: Boolean read FTolls write FTolls;
    property TruckScales: Boolean read FTruckScales write FTruckScales;
    property Ufs: Boolean read FUfs write FUfs;
  end;

  TPrivatePlaces = class
  strict private
    FAreas: Boolean;
    FCategories: Boolean;
    FContacts: Boolean;
    [JSONName('max_distance_from_location_to_route')]
    FMaxDistanceFromLocationToRoute: string;
    FProducts: Boolean;
    FServices: Boolean;
  published
    property Areas: Boolean read FAreas write FAreas;
    property Categories: Boolean read FCategories write FCategories;
    property Contacts: Boolean read FContacts write FContacts;
    property MaxDistanceFromLocationToRoute: string read FMaxDistanceFromLocationToRoute write FMaxDistanceFromLocationToRoute;
    property Products: Boolean read FProducts write FProducts;
    property Services: Boolean read FServices write FServices;
  end;

  TFuelConsumption = class
  strict private
    [JSONName('fuel_price')]
    FFuelPrice: string;
    [JSONName('km_fuel')]
    FKmFuel: string;
  published
    property FuelPrice: string read FFuelPrice write FFuelPrice;
    property KmFuel: string read FKmFuel write FKmFuel;
  end;

  TFreightTable = class
  strict private
    FAxis: string;
    FCategory: string;
    [JSONName('freight_load')]
    FFreightLoad: string;
  published
    property Axis: string read FAxis write FAxis;
    property Category: string read FCategory write FCategory;
    property FreightLoad: string read FFreightLoad write FFreightLoad;
  end;

  TTolls = class
  strict private
    [JSONName('retroactive_date')]
    FRetroactiveDate: string;
  published
    property RetroactiveDate: string read FRetroactiveDate write FRetroactiveDate;
  end;

  TVehicle = class
  strict private
    FAxis: string;
    FType: string;
  published
    property Axis: string read FAxis write FAxis;
    property &Type: string read FType write FType;
  end;

  TRoute = class
  strict private
    [JSONName('alternative_routes')]
    FAlternativeRoutes: string;
    [JSONName('calculate_return')]
    FCalculateReturn: Boolean;
    [JSONName('optimized_route')]
    FOptimizedRoute: Boolean;
    [JSONName('optimized_route_destination')]
    FOptimizedRouteDestination: string;
  published
    property AlternativeRoutes: string read FAlternativeRoutes write FAlternativeRoutes;
    property CalculateReturn: Boolean read FCalculateReturn write FCalculateReturn;
    property OptimizedRoute: Boolean read FOptimizedRoute write FOptimizedRoute;
    property OptimizedRouteDestination: string read FOptimizedRouteDestination write FOptimizedRouteDestination;
  end;

  TConfig = class
  strict private
    [JSONName('freight_table')]
    FFreightTable: TFreightTable;
    [JSONName('fuel_consumption')]
    FFuelConsumption: TFuelConsumption;
    [JSONName('private_places')]
    FPrivatePlaces: TPrivatePlaces;
    FRoute: TRoute;
    FTolls: TTolls;
    FVehicle: TVehicle;
  published
    property FreightTable: TFreightTable read FFreightTable;
    property FuelConsumption: TFuelConsumption read FFuelConsumption;
    property PrivatePlaces: TPrivatePlaces read FPrivatePlaces;
    property Route: TRoute read FRoute;
    property Tolls: TTolls read FTolls;
    property Vehicle: TVehicle read FVehicle;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TRequisicaoQualP = class(TBaseJSONQualP)
  strict private
    FConfig: TConfig;
    [JSONName('exception_key')]
    FExceptionKey: string;
    FFormat: string;
    [JSONName('locations')]
    FLocationsArray: TArray<string>;
    [JSONMarshalled(False)]
    FLocations: TList<string>;
    FShow: TShow;
    function GetLocations: TList<string>;
  strict protected
    function GetAsJson: string; override;
  published
    property Config: TConfig read FConfig;
    property ExceptionKey: string read FExceptionKey write FExceptionKey;
    property Format: string read FFormat write FFormat;
    property Locations: TList<string> read GetLocations;
    property Show: TShow read FShow;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TConfig }

constructor TConfig.Create;
begin
  inherited;
  FRoute := TRoute.Create;
  FVehicle := TVehicle.Create;
  FTolls := TTolls.Create;
  FFreightTable := TFreightTable.Create;
  FFuelConsumption := TFuelConsumption.Create;
  FPrivatePlaces := TPrivatePlaces.Create;
end;

destructor TConfig.Destroy;
begin
  FRoute.Free;
  FVehicle.Free;
  FTolls.Free;
  FFreightTable.Free;
  FFuelConsumption.Free;
  FPrivatePlaces.Free;
  inherited;
end;

{ TRequisicaoQualP }

constructor TRequisicaoQualP.Create;
begin
  inherited;
  FConfig := TConfig.Create;
  FShow := TShow.Create;
end;

destructor TRequisicaoQualP.Destroy;
begin
  FConfig.Free;
  FShow.Free;
  GetLocations.Free;
  inherited;
end;

function TRequisicaoQualP.GetLocations: TList<string>;
begin
  Result := List<string>(FLocations, FLocationsArray);
end;

function TRequisicaoQualP.GetAsJson: string;
begin
  RefreshArray<string>(FLocations, FLocationsArray);
  Result := inherited;
end;

end.
