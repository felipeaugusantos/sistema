unit untMaplinkMultiGeocode;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.StrUtils,
  System.JSON, System.Classes,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, Vcl.StdCtrls, UniClientDataSet,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
  {**************BEGIN OBJETO ENVIO****************}
  TEnderecos = class
  private
    FCity: String;
    FDistrict: String;
    FId: String;
    FNumber: Integer;
    FRoad: String;
    FState: String;
    FZipcode: String;
  public
    property city: String read FCity write FCity;
    property district: String read FDistrict write FDistrict;
    property id: String read FId write FId;
    property number: Integer read FNumber write FNumber;
    property road: String read FRoad write FRoad;
    property state: String read FState write FState;
    property zipcode: String read FZipcode write FZipcode;

    function f_city(const AValue: String): TEnderecos;
    function f_district(const AValue: String): TEnderecos;
    function f_id(const AValue: String): TEnderecos;
    function f_number(const AValue: Integer): TEnderecos;
    function f_road(const AValue: String): TEnderecos;
    function f_state(const AValue: String): TEnderecos;
    function f_zipcode(const AValue: String): TEnderecos;

    class function fNew: TEnderecos;
  end;

  TMultiGeocode = class
  private
    FEnderecos: TArray<TEnderecos>;
  public
    property Enderecos: TArray<TEnderecos> read FEnderecos write FEnderecos;
    destructor Destroy; override;
    procedure pAddEndereco(Endereco: TEnderecos);
    function ToJsonString: string;
  end;
  {***************END OBJETO ENVIO*****************}


  {*************BEGIN OBJETO RETORNO***************}
  TMainLocationClass = class
  private
    FLat: Extended;
    FLon: Extended;
  public
    property lat: Extended read FLat write FLat;
    property lon: Extended read FLon write FLon;
  end;

  TStateClass = class
  private
    FCode: String;
    FName: String;
  public
    property code: String read FCode write FCode;
    property name: String read FName write FName;
  end;

  TAddressClass = class
  private
    FCity: String;
    FDistrict: String;
    FMainLocation: TMainLocationClass;
    FNumber: String;
    FRoad: String;
    FState: TStateClass;
    FZipCode: String;
  public
    property city: String read FCity write FCity;
    property district: String read FDistrict write FDistrict;
    property mainLocation: TMainLocationClass read FMainLocation write FMainLocation;
    property number: String read FNumber write FNumber;
    property road: String read FRoad write FRoad;
    property state: TStateClass read FState write FState;
    property zipCode: String read FZipCode write FZipCode;
    constructor Create;
    destructor Destroy; override;
  end;

  TResultsClass = class
  private
    FAddress: TAddressClass;
    FId: String;
    FLabel: String;
    FScore: Extended;
    FType: String;
  public
    property address: TAddressClass read FAddress write FAddress;
    property id: String read FId write FId;
    property strLabel: String read FLabel write FLabel;
    property score: Extended read FScore write FScore;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TRetornoMultiGeocode = class
  private
    FFound: Extended;
    FResults: TArray<TResultsClass>;
  public
    property found: Extended read FFound write FFound;
    property results: TArray<TResultsClass> read FResults write FResults;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoMultiGeocode;
  end;
  {**************END OBJETO RETORNO****************}

  TControllerMaplinkMultiGeocode = class
  public
    class function fRetCoordenadas(MultiGeocode: TMultiGeocode): TRetornoMultiGeocode;
  end;

implementation

uses untMaplinkRestApi, untRestApi;

{ TEnderecos }

class function TEnderecos.fNew: TEnderecos;
begin
  Result := TEnderecos.Create;
end;

function TEnderecos.f_city(const AValue: String): TEnderecos;
begin
  FCity := AValue;
  Result := Self;
end;

function TEnderecos.f_district(const AValue: String): TEnderecos;
begin
  FDistrict := AValue;
  Result := Self;
end;

function TEnderecos.f_id(const AValue: String): TEnderecos;
begin
  FId := AValue;
  Result := Self;
end;

function TEnderecos.f_number(const AValue: Integer): TEnderecos;
begin
  FNumber := AValue;
  Result := Self;
end;

function TEnderecos.f_road(const AValue: String): TEnderecos;
begin
  FRoad := AValue;
  Result := Self;
end;

function TEnderecos.f_state(const AValue: String): TEnderecos;
begin
  FState := AValue;
  Result := Self;
end;

function TEnderecos.f_zipcode(const AValue: String): TEnderecos;
begin
  FZipcode := AValue;
  Result := Self;
end;

{ TMultiGeocode }

destructor TMultiGeocode.Destroy;
var
  LEnderecos: TEnderecos;
begin

  for LEnderecos in FEnderecos do
    LEnderecos.free;

  inherited;
end;

procedure TMultiGeocode.pAddEndereco(Endereco: TEnderecos);
begin
  SetLength(FEnderecos, Length(FEnderecos)+1);
  FEnderecos[Length(FEnderecos)-1] := Endereco;
end;

function TMultiGeocode.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
  Result := Copy(Result, Pos(':', Result)+1, (Length(Result)-(Pos(':', Result)+1)));
end;

{ TAddressClass }

constructor TAddressClass.Create;
begin
  FState := TStateClass.Create();
  FMainLocation := TMainLocationClass.Create();
end;

destructor TAddressClass.Destroy;
begin
  FState.free;
  FMainLocation.free;
  inherited;
end;

{ TResultsClass }

constructor TResultsClass.Create;
begin
  FAddress := TAddressClass.Create();
end;

destructor TResultsClass.Destroy;
begin
  FAddress.free;
  inherited;
end;

{ TRetornoMultiGeocode }

destructor TRetornoMultiGeocode.Destroy;
var
  LresultsItem: TResultsClass;
begin

 for LresultsItem in FResults do
   LresultsItem.free;

  inherited;
end;

class function TRetornoMultiGeocode.FromJsonString(
  AJsonString: string): TRetornoMultiGeocode;
begin
  Result := TJson.JsonToObject<TRetornoMultiGeocode>(AJsonString)
end;

{ TControllerMaplinkMultiGeocode }

class function TControllerMaplinkMultiGeocode.fRetCoordenadas(
  MultiGeocode: TMultiGeocode): TRetornoMultiGeocode;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MAPLINK', TControllerMaplink.fConfigurarMaplink);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'geocode/v1/multi-geocode';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               MultiGeocode.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TRetornoMultiGeocode.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
