unit untGoogleGeocoding;

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
  EGoogleGeocodingError = Class(Exception);

  TPlus_codeClass = class
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
    FPlus_code: TPlus_codeClass;
    FTypes: TArray<String>;
  public
    property address_components: TArray<TAddress_componentsClass> read FAddress_components write FAddress_components;
    property formatted_address: String read FFormatted_address write FFormatted_address;
    property geometry: TGeometryClass read FGeometry write FGeometry;
    property place_id: String read FPlace_id write FPlace_id;
    property plus_code: TPlus_codeClass read FPlus_code write FPlus_code;
    property types: TArray<String> read FTypes write FTypes;
    constructor Create;
    destructor Destroy; override;
  end;

  TGoogleGeocoding = class
  private
    FResults: TArray<TResultsClass>;
    FStatus: String;
    Ferror_message: String;
    class function FromJsonString(AJsonString: string): TGoogleGeocoding;
  public
    property results: TArray<TResultsClass> read FResults write FResults;
    property status: String read FStatus write FStatus;
    property error_message: string read Ferror_message write Ferror_message;
    destructor Destroy; override;

    class function fProcessaGeocode(const AstrEndereco, AstrBairro, AstrCidade, AstrEstado, AstrCep: String; const ARaiseError : Boolean = False): IEnderecoGeocode;
    class function fProcessa(const AstrEndereco, AstrBairro, AstrCidade, AstrEstado, AstrCep: String): TGoogleGeocoding;
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
  FPlus_code := TPlus_codeClass.Create();
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

{TGoogleGeocoding}

destructor TGoogleGeocoding.Destroy;
var
  LresultsItem: TResultsClass;
begin

 for LresultsItem in FResults do
   LresultsItem.free;

  inherited;
end;

class function TGoogleGeocoding.FromJsonString(AJsonString: string): TGoogleGeocoding;
begin
  result := TJson.JsonToObject<TGoogleGeocoding>(AJsonString)
end;

class function TGoogleGeocoding.fProcessa(const AstrEndereco, AstrBairro,
  AstrCidade, AstrEstado, AstrCep: String): TGoogleGeocoding;
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

    RestRequest.Params.AddItem('address', AstrEndereco+' '+AstrBairro+ ' '+AstrCidade+'-'+AstrEstado+' '+AstrCep, pkGETorPOST);
    RestRequest.Params.AddItem('key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_KEYMDP']), pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TGoogleGeocoding.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TGoogleGeocoding.fProcessaGeocode(const AstrEndereco, AstrBairro,
  AstrCidade, AstrEstado, AstrCep: String; const ARaiseError : Boolean = False): IEnderecoGeocode;
var
  GoogleGeocoding: TGoogleGeocoding;
  Results: TResultsClass;
  blnEncontrouCep: Boolean;
begin
  Result := nil;
  blnEncontrouCep := False;

  GoogleGeocoding := fProcessa(AstrEndereco, AstrBairro, AstrCidade, AstrEstado, AstrCep);
  try
    if (Assigned(GoogleGeocoding)) and (GoogleGeocoding.status = 'OK') then
    begin
      for Results in GoogleGeocoding.results do
      begin
        if not Assigned(Results.geometry.location) then
          Continue;

        if (Results.geometry.location.lat = 0) and (Results.geometry.location.lng = 0) then
          Continue;

        if Pos(fFormataCEP(AstrCep), Results.formatted_address) <= 0 then
          Continue;

        Result := TEnderecoGeocode.fNew
                    .fSetEndereco(Results.formatted_address)
                    .fSetLatitude(Results.geometry.location.lat)
                    .fSetLongitude(Results.geometry.location.lng);

        blnEncontrouCep := True;
        Break;
      end;

      if (not blnEncontrouCep) and
         (Length(GoogleGeocoding.results) > 0) and
         Assigned(GoogleGeocoding.results[0].geometry.location) then
        Result := TEnderecoGeocode.fNew
                   .fSetEndereco(GoogleGeocoding.results[0].formatted_address)
                   .fSetLatitude(GoogleGeocoding.results[0].geometry.location.lat)
                   .fSetLongitude(GoogleGeocoding.results[0].geometry.location.lng);
    end;

    If (Assigned(GoogleGeocoding)) and (not fEmptyStr(GoogleGeocoding.error_message)) and (not assigned(result)) and ARaiseError then
      raise EGoogleGeocodingError.Create(GoogleGeocoding.error_message);
  finally
    if Assigned(GoogleGeocoding) then
      FreeAndNil(GoogleGeocoding);
  end;
end;

end.
