unit untCitelOsrmTripApi;

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
  TLegsClass = class
  private
    FDistance: Extended;
    FDuration: Extended;
    FSummary: String;
    FWeight: Extended;
  public
    property distance: Extended read FDistance write FDistance;
    property duration: Extended read FDuration write FDuration;
    property summary: String read FSummary write FSummary;
    property weight: Extended read FWeight write FWeight;
  end;

  TTripsClass = class
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

  TLocation = class
  private
    FLatitude: Double;
    FLongitude: Double;
  public
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
  end;

  TWaypointsClass = class
  private
    FDistance: Extended;
    FHint: String;
    FName: String;
    FTrips_index: Integer;
    FWaypoint_index: Integer;
    FLocation: TLocation;
  public
    property distance: Extended read FDistance write FDistance;
    property hint: String read FHint write FHint;
    property name: String read FName write FName;
    property trips_index: Integer read FTrips_index write FTrips_index;
    property waypoint_index: Integer read FWaypoint_index write FWaypoint_index;
    property Location: TLocation read FLocation write FLocation;
  end;

  TCitelOsrmTripApi = class
  private
    FCode: String;
    FTrips: TArray<TTripsClass>;
    FWaypoints: TArray<TWaypointsClass>;

    class function ParseLegs(const AJsonObject: TJSONObject): TLegsClass;
    class function ParseTrips(const AJsonObject: TJSONObject): TTripsClass;
    class function ParseWaypoints(const AJsonObject: TJSONObject): TWaypointsClass;
    class function ParseLocation(const AJsonArray: TJSONArray): TLocation;
    class function ParceCitelOsrmTripApi(const AJsonString: string): TCitelOsrmTripApi;
    class function fGetTrip(const ACoordenadas: String; const blnRoundtrip: Boolean): TCitelOsrmTripApi;
  public
    property code: String read FCode write FCode;
    property trips: TArray<TTripsClass> read FTrips write FTrips;
    property waypoints: TArray<TWaypointsClass> read FWaypoints write FWaypoints;
    destructor Destroy; override;

    class function fPlanejarRota(cdsMaps: TUniClientDataSet;
                                 cdsRomRet: TUniClientDataSet;
                                 var strMsgRetorno: String;
                                 strCoordenadaInicial: String = ''): Boolean;
  end;

implementation

{ TTripsClass }

uses untRestApi, untCitelOsrmRestApi, untMapsDistanceMatrix, untTypesSistema;

destructor TTripsClass.Destroy;
begin
  Finalize(FLegs);

  inherited;
end;

{ TCitelOsrmTripApi }

destructor TCitelOsrmTripApi.Destroy;
begin
  Finalize(FTrips);
  Finalize(FWaypoints);

  inherited;
end;

class function TCitelOsrmTripApi.ParseLegs(const AJsonObject: TJSONObject): TLegsClass;
begin
  Result := TLegsClass.Create;
  Result.summary := AJsonObject.GetValue<string>('summary');
  Result.weight := AJsonObject.GetValue<Double>('weight');
  Result.duration := AJsonObject.GetValue<Double>('duration');
  Result.distance := AJsonObject.GetValue<Double>('distance');
end;

class function TCitelOsrmTripApi.ParseTrips(const AJsonObject: TJSONObject): TTripsClass;
var
  LJsonArray: TJSONArray;
  LegsList: TArray<TLegsClass>;

  I: Integer;
begin
  Result := TTripsClass.Create;
  Result.geometry := AJsonObject.GetValue<string>('geometry');
  Result.weight_name := AJsonObject.GetValue<string>('weight_name');
  Result.weight := AJsonObject.GetValue<Double>('weight');
  Result.duration := AJsonObject.GetValue<Double>('duration');
  Result.distance := AJsonObject.GetValue<Double>('distance');

  // Parse Legs
  LJsonArray := AJsonObject.GetValue<TJSONArray>('legs');
  SetLength(LegsList, LJsonArray.Count);
  for I := 0 to LJsonArray.Count - 1 do
  begin
    LegsList[I] := ParseLegs(LJsonArray.Items[I] as TJSONObject);
  end;
  Result.legs := LegsList;
end;

class function TCitelOsrmTripApi.ParseLocation(const AJsonArray: TJSONArray): TLocation;
begin
  Result := TLocation.Create;
  Result.Latitude := StrToFloatDef(AJsonArray.Get(1).Value, 0.0);
  Result.Longitude := StrToFloatDef(AJsonArray.Get(0).Value, 0.0);
end;

class function TCitelOsrmTripApi.ParseWaypoints(const AJsonObject: TJSONObject): TWaypointsClass;
begin
  Result := TWaypointsClass.Create;
  Result.waypoint_index := AJsonObject.GetValue<Integer>('waypoint_index');
  Result.trips_index := AJsonObject.GetValue<Integer>('trips_index');
  Result.hint := AJsonObject.GetValue<string>('hint');
  Result.distance := AJsonObject.GetValue<Extended>('distance');
  Result.name := AJsonObject.GetValue<string>('name');
  Result.Location := ParseLocation(AJsonObject.GetValue<TJSONArray>('location'));
end;

class function TCitelOsrmTripApi.ParceCitelOsrmTripApi(
  const AJsonString: string): TCitelOsrmTripApi;
var
  LJsonObject: TJSONObject;
  LJsonArray: TJSONArray;

  TripsList: TArray<TTripsClass>;
  WaypointsList: TArray<TWaypointsClass>;

  I: Integer;
begin
  Result := TCitelOsrmTripApi.Create;
  LJsonObject := TJSONObject.ParseJSONValue(AJsonString) as TJSONObject;
  try
    Result.Code := LJsonObject.GetValue<string>('code');

    // Parse Trips
    LJsonArray := LJsonObject.GetValue<TJSONArray>('trips');
    SetLength(TripsList, LJsonArray.Count);
    for I := 0 to LJsonArray.Count - 1 do
    begin
      TripsList[I] := ParseTrips(LJsonArray.Items[I] as TJSONObject);
    end;
    Result.trips := TripsList;

    //Parse Waypoints
    LJsonArray := LJsonObJect.GetValue<TJSONArray>('waypoints');
    SetLength(WaypointsList, LJsonArray.Count);
    for I := 0  to LJsonArray.Count - 1 do
    begin
      WaypointsList[I] := ParseWaypoints(LJsonArray.Items[I] as TJSONObject);
    end;
    Result.waypoints := WaypointsList;

  finally
    LJsonObject.Free;
  end;
end;

class function TCitelOsrmTripApi.fGetTrip(
  const ACoordenadas: String; const blnRoundtrip: Boolean): TCitelOsrmTripApi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CITEL_OSRM', TControllerCitelOsrmRestApi.fConfigurarCitelOsrm);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'trip/v1/driving/'+ACoordenadas;
    RestRequest.Params.AddItem('roundtrip', IIF(blnRoundtrip, 'true', 'false'), pkGETorPOST);
    RestRequest.Params.AddItem('source', 'first', pkGETorPOST);
    RestRequest.Params.AddItem('destination', IIF(blnRoundtrip, 'last', 'any'), pkGETorPOST);
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TCitelOsrmTripApi.ParceCitelOsrmTripApi(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TCitelOsrmTripApi.fPlanejarRota(cdsMaps,
  cdsRomRet: TUniClientDataSet; var strMsgRetorno: String; strCoordenadaInicial: String = ''): Boolean;
var
  CitelOsrmTripApi : TCitelOsrmTripApi;
  LStrCoordenadas: String;
  LBlnRoundtrip: Boolean;
  LBlnRetornandoParaPontoInicial: Boolean;

  Waypoints: TWaypointsClass;
begin
  Result := False;

  LBlnRetornandoParaPontoInicial := False;

  cdsMaps.IndexFieldNames := EmptyStr;

  cdsRomRet.EmptyDataSet;

  LStrCoordenadas :=
    TControllerMapsDistanceMatrix.fRetCoordenadaString(IIF(fEmptyStr(strCoordenadaInicial), cdsMaps.FieldByName('GER_INIPAR').AsString, strCoordenadaInicial), coorLon)+','+TControllerMapsDistanceMatrix.fRetCoordenadaString(IIF(fEmptyStr(strCoordenadaInicial), cdsMaps.FieldByName('GER_INIPAR').AsString, strCoordenadaInicial), coorLat)+';'+
    TControllerMapsDistanceMatrix.fRetornaCoordenadas(cdsMaps)[0]+
    IIF(not fEmptyStr(cdsMaps.FieldByName('GER_FINROT').AsString), ';'+TControllerMapsDistanceMatrix.fRetCoordenadaString(cdsMaps.FieldByName('GER_FINROT').AsString, coorLon)+','+TControllerMapsDistanceMatrix.fRetCoordenadaString(cdsMaps.FieldByName('GER_FINROT').AsString, coorLat), EmptyStr);

  LBlnRoundtrip := (not fEmptyStr(cdsMaps.FieldByName('GER_FINROT').AsString));

  CitelOsrmTripApi := fGetTrip(LStrCoordenadas, LBlnRoundtrip);
  try
    try
      Result := Assigned(CitelOsrmTripApi);
      if Result then
      begin
        cdsMaps.First;
        for Waypoints in CitelOsrmTripApi.waypoints do
        begin
          if Waypoints.waypoint_index = 0 then
            Continue;

          if not LBlnRetornandoParaPontoInicial then
          begin
            cdsMaps.Edit;
            cdsMaps.FieldByName('GER_LOCALI').AsString := 'OK';
            cdsMaps.FieldByName('GER_DISTAN').AsFloat := RoundTo(CitelOsrmTripApi.trips[Waypoints.trips_index].legs[Waypoints.waypoint_index-1].distance / 1000, -2);
            cdsMaps.FieldByName('GER_TMPENT').AsFloat := CitelOsrmTripApi.trips[Waypoints.trips_index].legs[Waypoints.waypoint_index-1].duration;
            cdsMaps.FieldByName('GER_ORDIMP').AsString := FloatToStr(Waypoints.waypoint_index);
            cdsMaps.Post;
          end
          else if LBlnRoundtrip then
          begin
            cdsRomRet.Append;
            cdsRomRet.FieldByName('RET_DISTAN').AsFloat := RoundTo(CitelOsrmTripApi.trips[Waypoints.trips_index].legs[Waypoints.waypoint_index-1].distance / 1000, -2);
            cdsRomRet.FieldByName('RET_TMPRET').AsFloat := CitelOsrmTripApi.trips[Waypoints.trips_index].legs[Waypoints.waypoint_index-1].duration;
            cdsRomRet.Post;

            Break;
          end;

          cdsMaps.Next;

          LBlnRetornandoParaPontoInicial := ((LBlnRoundtrip) and (cdsMaps.Eof));
          if (cdsMaps.Eof) and (not LBlnRetornandoParaPontoInicial) then
            Break;
        end;
      end
      else
        strMsgRetorno := 'Ocorreu uma falha na comunicação com a API!';
    except
      on E: Exception do
        strMsgRetorno := 'Ocorreram erros ao planejar a rota!';
    end;

  finally
    cdsMaps.IndexFieldNames := 'GER_ORDIMP';
    FreeAndNil(CitelOsrmTripApi);
  end;
end;

end.
