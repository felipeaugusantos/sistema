unit untQualiZapSearchContact;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, untFuncoesSimples, REST.Client,
  Data.DB, MemDS, DBAccess, Uni, untTypesSistema,
  UniClientDataSet;

type
  TReturnSearchContact = class
  private
    FAddress: String;
    FAddressComp: String;
    FBlockmarketingcampaigns: Extended;
    FBlockutilitiescampaigns: Extended;
    FCity: String;
    FComments: String;
    FCountry: String;
    FDocument: String;
    FEmail: String;
    FFacebook: String;
    FFk_company: Extended;
    FFree1: String;
    FFree2: String;
    FGroups: TArray<String>;
    FHouseNumber: String;
    FId: Extended;
    FInstagram: String;
    FName: String;
    FNeighborhood: String;
    FNumber: String;
    FPostalCode: String;
    FPreferredAgent: Extended;
    FPreferredAgents: TArray<Extended>;
    FState: String;
    FTags: TArray<String>;
  public
    property address: String read FAddress write FAddress;
    property addressComp: String read FAddressComp write FAddressComp;
    property blockmarketingcampaigns: Extended read FBlockmarketingcampaigns write FBlockmarketingcampaigns;
    property blockutilitiescampaigns: Extended read FBlockutilitiescampaigns write FBlockutilitiescampaigns;
    property city: String read FCity write FCity;
    property comments: String read FComments write FComments;
    property country: String read FCountry write FCountry;
    property document: String read FDocument write FDocument;
    property email: String read FEmail write FEmail;
    property facebook: String read FFacebook write FFacebook;
    property fk_company: Extended read FFk_company write FFk_company;
    property free1: String read FFree1 write FFree1;
    property free2: String read FFree2 write FFree2;
    property groups: TArray<String> read FGroups write FGroups;
    property houseNumber: String read FHouseNumber write FHouseNumber;
    property id: Extended read FId write FId;
    property instagram: String read FInstagram write FInstagram;
    property name: String read FName write FName;
    property neighborhood: String read FNeighborhood write FNeighborhood;
    property number: String read FNumber write FNumber;
    property postalCode: String read FPostalCode write FPostalCode;
    property preferredAgent: Extended read FPreferredAgent write FPreferredAgent;
    property preferredAgents: TArray<Extended> read FPreferredAgents write FPreferredAgents;
    property state: String read FState write FState;
    property tags: TArray<String> read FTags write FTags;

    class function FromJsonString(AJsonString: string): TReturnSearchContact;
  end;

  TSearchContact = class
  private
    FApiKey: String;
    FQueueId: Extended;
    FSearchField: String;
    FSearchValue: String;

    class function fRetFilaEApiKey(var extIdFila: Extended; var strApiKey: String): Boolean;
    function fSearch: TReturnSearchContact;
  public
    property apiKey: String read FApiKey write FApiKey;
    property queueId: Extended read FQueueId write FQueueId;
    property searchField: String read FSearchField write FSearchField;
    property searchValue: String read FSearchValue write FSearchValue;
    function ToJsonString: string;

    class function fSearchContact(const AstrFiled, AstrValue: String): TReturnSearchContact;
  end;

  const
    FIELD_NUMBER = 'number';

implementation

uses untQualiZapRestApi, untRestApi, untConstantes, untFuncoesGenerica;

{ TReturnSearchContact }

class function TReturnSearchContact.FromJsonString(
  AJsonString: string): TReturnSearchContact;
begin
  Result := TJson.JsonToObject<TReturnSearchContact>(AJsonString);
end;

{ TSearchContact }

function TSearchContact.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TSearchContact.fRetFilaEApiKey(var extIdFila: Extended; var strApiKey: String): Boolean;
begin
  Result := fRetFilaEApiKeyPrincipalWhatsapp(extIdFila, strApiKey);
  if not Result then
    fMensagem('ATENÇÃO!', 'Para sincronizar contatos com o CitelDesk é necessário que alguma fila seja definada como Fila Principal.', ['&Ok']);
end;

class function TSearchContact.fSearchContact(
  const AstrFiled, AstrValue: String): TReturnSearchContact;
var
  SearchContact: TSearchContact;
  extIdFila: Extended;
  strApiKey: String;
begin
  Result := nil;

  if not fRetFilaEApiKey(extIdFila, strApiKey) then
    Exit;

  SearchContact := TSearchContact.Create;
  try
    SearchContact.queueId := extIdFila;
    SearchContact.apiKey := strApiKey;
    SearchContact.searchField := AstrFiled;
    SearchContact.searchValue := AstrValue;

    Result := SearchContact.fSearch;
  finally
    FreeAndNil(SearchContact);
  end;
end;

function TSearchContact.fSearch: TReturnSearchContact;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QUALIZAP', TControllerQualiZap.fConfigurarQualiZap);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'int/searchContact';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               Self.ToJsonString,
               TREstRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TReturnSearchContact.FromJsonString(JSONRetorno)

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
