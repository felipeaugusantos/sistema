unit untMaplinkTripClasses;

interface

uses
  Rest.Json;

type
  TPoints = class
  private
    FLatitude: Extended;
    FLongitude: Extended;
  public
    property latitude: Extended read FLatitude write FLatitude;
    property longitude: Extended read FLongitude write FLongitude;
  end;

  TPointsSend = class(TPoints)
  private
    FSiteId: String;
  public
    property siteId: String read FSiteId write FSiteId;

    class function fNew: TPointsSend;

    function f_siteId(AValue: String): TPointsSend;
    function f_latitude(AValue: Extended): TPointsSend;
    function f_longitude(AValue: Extended): TPointsSend;
  end;

  TMaplinkTrip = class
  private
    FCalculationMode: String;
    FAvoidanceTypes: TArray<String>;
    FPoints: TArray<TPointsSend>;
  public
    property calculationMode: String read FCalculationMode write FCalculationMode;
    property avoidanceTypes: TArray<String> read FAvoidanceTypes write FAvoidanceTypes;
    property points: TArray<TPointsSend> read FPoints write FPoints;
    destructor Destroy; override;
    function ToJsonString: string;

    procedure pAddPoint(PointsSend: TPointsSend);
  end;

  TLegsClass = class
  private
    FAverageSpeed: Extended;
    FDistance: Extended;
    FNominalDuration: Extended;
    FPoints: TArray<TPoints>;
  public
    property averageSpeed: Extended read FAverageSpeed write FAverageSpeed;
    property distance: Extended read FDistance write FDistance;
    property nominalDuration: Extended read FNominalDuration write FNominalDuration;
    property points: TArray<TPoints> read FPoints write FPoints;
    destructor Destroy; override;
  end;

  TRetornoMaplinkTrip = class
  private
    FAverageSpeed: Extended;
    FClientId: String;
    FCreatedAt: Extended;
    FId: String;
    FLegs: TArray<TLegsClass>;
    FSource: String;
    FTotalDistance: Extended;
    FTotalNominalDuration: Extended;
  public
    property averageSpeed: Extended read FAverageSpeed write FAverageSpeed;
    property clientId: String read FClientId write FClientId;
    property createdAt: Extended read FCreatedAt write FCreatedAt;
    property id: String read FId write FId;
    property legs: TArray<TLegsClass> read FLegs write FLegs;
    property source: String read FSource write FSource;
    property totalDistance: Extended read FTotalDistance write FTotalDistance;
    property totalNominalDuration: Extended read FTotalNominalDuration write FTotalNominalDuration;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoMaplinkTrip;
  end;

implementation

{ TPointsSend }

class function TPointsSend.fNew: TPointsSend;
begin
  Result := TPointsSend.Create;
end;

function TPointsSend.f_latitude(AValue: Extended): TPointsSend;
begin
  FLatitude := AValue;
  Result := Self;
end;

function TPointsSend.f_longitude(AValue: Extended): TPointsSend;
begin
  FLongitude := AValue;
  Result := Self;
end;

function TPointsSend.f_siteId(AValue: String): TPointsSend;
begin
  FSiteId := AValue;
  Result := Self;
end;

{TMaplinkTrip}

destructor TMaplinkTrip.Destroy;
var
  LpointsItem: TPointsSend;
begin

 for LpointsItem in FPoints do
   LpointsItem.free;

  inherited;
end;

procedure TMaplinkTrip.pAddPoint(PointsSend: TPointsSend);
begin
  SetLength(FPoints, Length(FPoints)+1);
  FPoints[High(FPoints)] := PointsSend;
end;

function TMaplinkTrip.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{ TLegsClass }

destructor TLegsClass.Destroy;
var
  LpointsItem: TPoints;
begin

 for LpointsItem in FPoints do
   LpointsItem.free;

  inherited;
end;

{ TRetornoMaplinkTrip }

destructor TRetornoMaplinkTrip.Destroy;
var
  LlegsItem: TLegsClass;
begin

 for LlegsItem in FLegs do
   LlegsItem.free;

  inherited;
end;

class function TRetornoMaplinkTrip.FromJsonString(
  AJsonString: string): TRetornoMaplinkTrip;
begin
  Result := TJson.JsonToObject<TRetornoMaplinkTrip>(AJsonString)
end;

end.
