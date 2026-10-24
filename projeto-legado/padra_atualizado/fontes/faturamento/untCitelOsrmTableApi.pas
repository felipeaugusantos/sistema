unit untCitelOsrmTableApi;

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
  TLocation = class
  private
    FLatitude: Double;
    FLongitude: Double;
  public
    property Latitude: Double read FLatitude write FLatitude;
    property Longitude: Double read FLongitude write FLongitude;
  end;

  TDestination = class
  private
    FHint: string;
    FDistance: Double;
    FName: string;
    FLocation: TLocation;
  public
    destructor Destroy; override;
    property Hint: string read FHint write FHint;
    property Distance: Double read FDistance write FDistance;
    property Name: string read FName write FName;
    property Location: TLocation read FLocation write FLocation;
  end;

  TSource = class(TDestination);

  TMatrixArray = TArray<TArray<Double>>;

  TCitelOsrmTableApi = class
  private
    FCode: string;
    FDistances: TMatrixArray;
    FDurations: TMatrixArray;
    FDestinations: TArray<TDestination>;
    FSources: TArray<TSource>;

    class function ParseLocation(const AJsonArray: TJSONArray): TLocation;
    class function ParseDestination(const AJsonObject: TJSONObject): TDestination;
    class function ParseSource(const AJsonObject: TJSONObject): TSource;
    class function ParceCitelOsrmTableApi(const AJsonString: string): TCitelOsrmTableApi;
    class function JsonArrayToDoubleArray(const AJsonArray: TJSONArray): TArray<Double>;
  public
    constructor Create;
    destructor Destroy; override;
    property Code: string read FCode write FCode;
    property Distances: TMatrixArray read FDistances write FDistances;
    property Durations: TMatrixArray read FDurations write FDurations;
    property Destinations: TArray<TDestination> read FDestinations write FDestinations;
    property Sources: TArray<TSource> read FSources write FSources;

    class function fGetDistanceMatrix(const ACoordenadas: String): TCitelOsrmTableApi;
  end;

implementation

{ TDestination }

uses untRestApi, untCitelOsrmRestApi;

destructor TDestination.Destroy;
begin
  FLocation.Free;
  inherited;
end;

{ TCitelOsrmTableApi }

constructor TCitelOsrmTableApi.Create;
begin
  inherited;
end;

destructor TCitelOsrmTableApi.Destroy;
begin
  Finalize(FDestinations);
  Finalize(FSources);

  inherited;
end;

class function TCitelOsrmTableApi.ParseLocation(const AJsonArray: TJSONArray): TLocation;
begin
  Result := TLocation.Create;
  Result.Latitude := StrToFloatDef(AJsonArray.Get(1).Value, 0.0);
  Result.Longitude := StrToFloatDef(AJsonArray.Get(0).Value, 0.0);
end;

class function TCitelOsrmTableApi.ParseDestination(const AJsonObject: TJSONObject): TDestination;
begin
  Result := TDestination.Create;
  Result.Hint := AJsonObject.GetValue<string>('hint');
  Result.Distance := AJsonObject.GetValue<Double>('distance');
  Result.Name := AJsonObject.GetValue<string>('name');
  Result.Location := ParseLocation(AJsonObject.GetValue<TJSONArray>('location'));
end;

 class function TCitelOsrmTableApi.ParseSource(const AJsonObject: TJSONObject): TSource;
begin
  Result := TSource.Create;
  Result.Hint := AJsonObject.GetValue<string>('hint');
  Result.Distance := AJsonObject.GetValue<Double>('distance');
  Result.Name := AJsonObject.GetValue<string>('name');
  Result.Location := ParseLocation(AJsonObject.GetValue<TJSONArray>('location'));
end;

class function TCitelOsrmTableApi.ParceCitelOsrmTableApi(const AJsonString: string): TCitelOsrmTableApi;
var
  LJsonObject: TJSONObject;
  LJsonArray: TJSONArray;
  I: Integer;
  DestList: TArray<TDestination>;
  SrcList: TArray<TSource>;
begin
  Result := TCitelOsrmTableApi.Create;
  LJsonObject := TJSONObject.ParseJSONValue(AJsonString) as TJSONObject;
  try
    Result.Code := LJsonObject.GetValue<string>('code');

    // Parse Distances
    LJsonArray := LJsonObject.GetValue<TJSONArray>('distances');
    SetLength(Result.FDistances, LJsonArray.Count);
    for I := 0 to LJsonArray.Count - 1 do
    begin
      Result.Distances[I] := JsonArrayToDoubleArray(LJsonArray.Items[I] as TJSONArray);
    end;

    // Parse Durations
    LJsonArray := LJsonObject.GetValue<TJSONArray>('durations');
    SetLength(Result.FDurations, LJsonArray.Count);
    for I := 0 to LJsonArray.Count - 1 do
    begin
      Result.Durations[I] := JsonArrayToDoubleArray(LJsonArray.Items[I] as TJSONArray);
    end;

    // Parse Destinations
    LJsonArray := LJsonObject.GetValue<TJSONArray>('destinations');
    SetLength(DestList, LJsonArray.Count);
    for I := 0 to LJsonArray.Count - 1 do
    begin
      DestList[I] := ParseDestination(LJsonArray.Items[I] as TJSONObject);
    end;
    Result.Destinations := DestList;

    // Parse Sources
    LJsonArray := LJsonObject.GetValue<TJSONArray>('sources');
    SetLength(SrcList, LJsonArray.Count);
    for I := 0 to LJsonArray.Count - 1 do
    begin
      SrcList[I] := ParseSource(LJsonArray.Items[I] as TJSONObject);
    end;
    Result.Sources := SrcList;
  finally
    LJsonObject.Free;
  end;
end;

class function TCitelOsrmTableApi.JsonArrayToDoubleArray(const AJsonArray: TJSONArray): TArray<Double>;
var
  I: Integer;
  LValue: string;
begin
  SetLength(Result, AJsonArray.Count);
  for I := 0 to AJsonArray.Count - 1 do
  begin
    LValue := AJsonArray.Items[I].Value;
    Result[I] := StrToFloatDef(LValue, 0.0);
  end;
end;

class function TCitelOsrmTableApi.fGetDistanceMatrix(const ACoordenadas: String): TCitelOsrmTableApi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CITEL_OSRM', TControllerCitelOsrmRestApi.fConfigurarCitelOsrm);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'table/v1/driving/'+ACoordenadas;
    RestRequest.Params.AddItem('annotations', 'distance,duration', pkGETorPOST);
    RestRequest.Method := rmGET;

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TCitelOsrmTableApi.ParceCitelOsrmTableApi(JSONRetorno)
    else
    begin
      {$IFNDEF LINUX}
      fMensagem('', 'Ocorreu uma falha na comunicação com a API Matriz de distância!',['&OK']);
      {$ENDIF LINUX}
    end;
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
