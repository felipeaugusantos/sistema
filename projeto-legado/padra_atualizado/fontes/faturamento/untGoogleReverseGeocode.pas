unit untGoogleReverseGeocode;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.StrUtils,
  System.JSON, System.Classes, untGeocode,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.StdCtrls, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  TPlus_codeClass_001 = class
  private
    FCompound_code: String;
    FGlobal_code: String;
  public
    property compound_code: String read FCompound_code write FCompound_code;
    property global_code: String read FGlobal_code write FGlobal_code;
  end;

  TSouthwestClass = class
  private
    FLat: Extended;
    FLng: Extended;
  public
    property lat: Extended read FLat write FLat;
    property lng: Extended read FLng write FLng;
  end;

  TNortheastClass = class
  private
    FLat: Extended;
    FLng: Extended;
  public
    property lat: Extended read FLat write FLat;
    property lng: Extended read FLng write FLng;
  end;

  TViewportClass = class
  private
    FNortheast: TNortheastClass;
    FSouthwest: TSouthwestClass;
  public
    property northeast: TNortheastClass read FNortheast write FNortheast;
    property southwest: TSouthwestClass read FSouthwest write FSouthwest;
    constructor Create;
    destructor Destroy; override;
  end;

  TLocationClass = class
  private
    FLat: Extended;
    FLng: Extended;
  public
    property lat: Extended read FLat write FLat;
    property lng: Extended read FLng write FLng;
  end;

  TGeometryClass = class
  private
    FLocation: TLocationClass;
    FLocation_type: String;
    FViewport: TViewportClass;
  public
    property location: TLocationClass read FLocation write FLocation;
    property location_type: String read FLocation_type write FLocation_type;
    property viewport: TViewportClass read FViewport write FViewport;
    constructor Create;
    destructor Destroy; override;
  end;

  TAddress_componentsClass = class
  private
    FLong_name: String;
    FShort_name: String;
    FTypes: TArray<String>;
  public
    property long_name: String read FLong_name write FLong_name;
    property short_name: String read FShort_name write FShort_name;
    property types: TArray<String> read FTypes write FTypes;
  end;

  TResultsClass = class
  private
    FAddress_components: TArray<TAddress_componentsClass>;
    FFormatted_address: String;
    FGeometry: TGeometryClass;
    FPlace_id: String;
    FPlus_code: TPlus_codeClass_001;
    FTypes: TArray<String>;
  public
    property address_components: TArray<TAddress_componentsClass> read FAddress_components write FAddress_components;
    property formatted_address: String read FFormatted_address write FFormatted_address;
    property geometry: TGeometryClass read FGeometry write FGeometry;
    property place_id: String read FPlace_id write FPlace_id;
    property plus_code: TPlus_codeClass_001 read FPlus_code write FPlus_code;
    property types: TArray<String> read FTypes write FTypes;
    constructor Create;
    destructor Destroy; override;
  end;

  TPlus_codeClass = class
  private
    FCompound_code: String;
    FGlobal_code: String;
  public
    property compound_code: String read FCompound_code write FCompound_code;
    property global_code: String read FGlobal_code write FGlobal_code;
  end;

  TGoogleReverseGeocode = class
  private
    FPlus_code: TPlus_codeClass;
    FResults: TArray<TResultsClass>;
    FStatus: String;

    class function FromJsonString(AJsonString: string): TGoogleReverseGeocode;
  public
    property plus_code: TPlus_codeClass read FPlus_code write FPlus_code;
    property results: TArray<TResultsClass> read FResults write FResults;
    property status: String read FStatus write FStatus;
    constructor Create;
    destructor Destroy; override;

    class function fProcessaReverseGeocode(const ALatitude, ALongitude: String; AId: String = ''): IEnderecosGeocode;
    class function fProcessa(const ALatitude, ALongitude: String): TGoogleReverseGeocode;
  end;

implementation

{TViewportClass}

uses untRestApi, untMapsRestApi;

constructor TViewportClass.Create;
begin
  inherited;
  FNortheast := TNortheastClass.Create();
  FSouthwest := TSouthwestClass.Create();
end;

destructor TViewportClass.Destroy;
begin
  FNortheast.free;
  FSouthwest.free;
  inherited;
end;

{TGeometryClass}

constructor TGeometryClass.Create;
begin
  inherited;
  FLocation := TLocationClass.Create();
  FViewport := TViewportClass.Create();
end;

destructor TGeometryClass.Destroy;
begin
  FLocation.free;
  FViewport.free;
  inherited;
end;

{TResultsClass}

constructor TResultsClass.Create;
begin
  inherited;
  FGeometry := TGeometryClass.Create();
  FPlus_code := TPlus_codeClass_001.Create();
end;

destructor TResultsClass.Destroy;
var
  Laddress_componentsItem: TAddress_componentsClass;
begin

 for Laddress_componentsItem in FAddress_components do
   Laddress_componentsItem.free;

  FGeometry.free;
  FPlus_code.free;
  inherited;
end;

{TGoogleReverseGeocode}

constructor TGoogleReverseGeocode.Create;
begin
  inherited;
  FPlus_code := TPlus_codeClass.Create();
end;

destructor TGoogleReverseGeocode.Destroy;
var
  LresultsItem: TResultsClass;
begin

 for LresultsItem in FResults do
   LresultsItem.free;

  FPlus_code.free;
  inherited;
end;

class function TGoogleReverseGeocode.FromJsonString(AJsonString: string): TGoogleReverseGeocode;
begin
  result := TJson.JsonToObject<TGoogleReverseGeocode>(AJsonString)
end;

class function TGoogleReverseGeocode.fProcessaReverseGeocode(const ALatitude,
  ALongitude: String; AId: String = ''): IEnderecosGeocode;
var
  GoogleReverseGeocode: TGoogleReverseGeocode;
  Results: TResultsClass;
begin
  Result := nil;

  GoogleReverseGeocode := fProcessa(ALatitude, ALongitude);
  try
    if (Assigned(GoogleReverseGeocode)) and (GoogleReverseGeocode.status = 'OK') then
    begin
      Result := TEnderecosGeocode.Create;

      for Results in GoogleReverseGeocode.results do
      begin
        Result.pAddEnderecoGeocode(Results.geometry.location.lat,
                                   Results.geometry.location.lng,
                                   Results.formatted_address,
                                   AId);
      end;
    end;
  finally
    if Assigned(GoogleReverseGeocode) then
      FreeAndNil(GoogleReverseGeocode);
  end;

end;

class function TGoogleReverseGeocode.fProcessa(const ALatitude,
  ALongitude: String): TGoogleReverseGeocode;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('GOOGLEMAPS', TControllerMaps.fConfigurarMaps);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'maps/api/geocode/json';
    RestRequest.Method   := rmGET;

    RestRequest.Params.AddItem('latlng', AnsiReplaceStr(ALatitude, ',', '.')+','+AnsiReplaceStr(ALongitude, ',', '.'), pkGETorPOST);
    RestRequest.Params.AddItem('key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP']), pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TGoogleReverseGeocode.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

end.
