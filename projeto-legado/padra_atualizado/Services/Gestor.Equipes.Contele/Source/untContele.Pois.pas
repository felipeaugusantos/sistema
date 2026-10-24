unit untContele.Pois;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client;
  {$ENDIF LINUX}

type
  THistoryClass = class
  private
    FDate: String;
    FName: String;
    FStatus: String;
    FUserId: String;
  public
    property date: String read FDate write FDate;
    property name: String read FName write FName;
    property status: String read FStatus write FStatus;
    property userId: String read FUserId write FUserId;
  end;

  TContactsClass = class
  private
    FEmail: String;
    FName: String;
    FPhone: String;
  public
    property email: String read FEmail write FEmail;
    property name: String read FName write FName;
    property phone: String read FPhone write FPhone;

    class function fNew: TContactsClass;

    function f_email(AValue: String): TContactsClass;
    function f_name(AValue: String): TContactsClass;
    function f_phone(AValue: String): TContactsClass;
  end;

  TAddressClass = class
  private
    FCity: String;
    FComplement: String;
    FNeighborhood: String;
    FNumber: String;
    FState: String;
    FStreet: String;
    FZipcode: String;
  public
    property city: String read FCity write FCity;
    property complement: String read FComplement write FComplement;
    property neighborhood: String read FNeighborhood write FNeighborhood;
    property number: String read FNumber write FNumber;
    property state: String read FState write FState;
    property street: String read FStreet write FStreet;
    property zipcode: String read FZipcode write FZipcode;
  end;

  TPoi = class
  private
    FAddress: TAddressClass;
    FAddressHasUpdated: Boolean;
    FCategoryId: String;
    FCategoryName: String;
    FClientId: String;
    FCnpj_cpf: String;
    FContacts: TArray<TContactsClass>;
    FCorporateName: String;
    FCreatorId: String;
    FObs: String;
    FCreatorName: String;
    FCustomId: String;
    FEditFromWeb: Boolean;
    FHistory: TArray<THistoryClass>;
    FId: String;
    FLat: Extended;
    FLng: Extended;
    FName: String;
    FOrigin: String;
    FPortfolios: TArray<String>;
    FStatus: String;

    procedure pAddContact(contact: TContactsClass);
  public
    property address: TAddressClass read FAddress write FAddress;
    property addressHasUpdated: Boolean read FAddressHasUpdated write FAddressHasUpdated;
    property categoryId: String read FCategoryId write FCategoryId;
    property categoryName: String read FCategoryName write FCategoryName;
    property clientId: String read FClientId write FClientId;
    property cnpj_cpf: String read FCnpj_cpf write FCnpj_cpf;
    property contacts: TArray<TContactsClass> read FContacts write FContacts;
    property corporateName: String read FCorporateName write FCorporateName;
    property creatorId: String read FCreatorId write FCreatorId;
    property obs: String read FObs write FObs;
    property creatorName: String read FCreatorName write FCreatorName;
    property customId: String read FCustomId write FCustomId;
    property editFromWeb: Boolean read FEditFromWeb write FEditFromWeb;
    property history: TArray<THistoryClass> read FHistory write FHistory;
    property id: String read FId write FId;
    property lat: Extended read FLat write FLat;
    property lng: Extended read FLng write FLng;
    property name: String read FName write FName;
    property origin: String read FOrigin write FOrigin;
    property portfolios: TArray<String> read FPortfolios write FPortfolios;
    property status: String read FStatus write FStatus;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPoi;
  end;

  TLocationClass = class
  private
    FLatitude: Extended;
    FLongitude: Extended;
  public
    property latitude: Extended read FLatitude write FLatitude;
    property longitude: Extended read FLongitude write FLongitude;
  end;

  TRetornoAddressClass = class
  private
    FCity: String;
    FComplement: String;
    FLocation: TLocationClass;
    FNeighborhood: String;
    FNumber: String;
    FState: String;
    FStreet: String;
    FZipcode: String;
  public
    property city: String read FCity write FCity;
    property complement: String read FComplement write FComplement;
    property location: TLocationClass read FLocation write FLocation;
    property neighborhood: String read FNeighborhood write FNeighborhood;
    property number: String read FNumber write FNumber;
    property state: String read FState write FState;
    property street: String read FStreet write FStreet;
    property zipcode: String read FZipcode write FZipcode;
    constructor Create;
    destructor Destroy; override;
  end;

  TRetornoUpdatePoi = class
  private
    FAddress: TRetornoAddressClass;
    FCategoryId: String;
    FClientId: String;
    FCnpj_cpf: String;
    FContacts: TArray<TContactsClass>;
    FCorporateName: String;
    FCreatedAt: String;
    FCreatorId: String;
    FCreatorName: String;
    FCustomId: String;
    FFullTextSearchTerm: String;
    FId: String;
    FLat: Extended;
    FLng: Extended;
    FName: String;
    FObs: String;
    FOrigin: String;
    FParseId: String;
    FSearchTerm: String;
    FSearch_term: String;
    FStatus: String;
    FUpdatedAt: String;
  public
    property address: TRetornoAddressClass read FAddress write FAddress;
    property categoryId: String read FCategoryId write FCategoryId;
    property clientId: String read FClientId write FClientId;
    property cnpj_cpf: String read FCnpj_cpf write FCnpj_cpf;
    property contacts: TArray<TContactsClass> read FContacts write FContacts;
    property corporateName: String read FCorporateName write FCorporateName;
    property createdAt: String read FCreatedAt write FCreatedAt;
    property creatorId: String read FCreatorId write FCreatorId;
    property creatorName: String read FCreatorName write FCreatorName;
    property customId: String read FCustomId write FCustomId;
    property fullTextSearchTerm: String read FFullTextSearchTerm write FFullTextSearchTerm;
    property id: String read FId write FId;
    property lat: Extended read FLat write FLat;
    property lng: Extended read FLng write FLng;
    property name: String read FName write FName;
    property obs: String read FObs write FObs;
    property origin: String read FOrigin write FOrigin;
    property parseId: String read FParseId write FParseId;
    property searchTerm: String read FSearchTerm write FSearchTerm;
    property search_term: String read FSearch_term write FSearch_term;
    property status: String read FStatus write FStatus;
    property updatedAt: String read FUpdatedAt write FUpdatedAt;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoUpdatePoi;
  end;

  TPortifolios = class
  private
    FPoisIds: TArray<String>;
    FPortifoliosIds: String;
  public
    property poisIds: TArray<String> read FPoisIds write FPoisIds;
    property portifoliosIds: String read FPortifoliosIds write FPortifoliosIds;
    function ToJsonString: string;
  end;

  TPortifoliosClass = class
  private
    FId: String;
    FName: String;
  public
    property id: String read FId write FId;
    property name: String read FName write FName;
  end;

  TPortifoliosPoi = class
  private
    FPortifolios: TArray<TPortifoliosClass>;
  public
    property portifolios: TArray<TPortifoliosClass> read FPortifolios write FPortifolios;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TPortifoliosPoi;
  end;

  TControllerGestorDeEquipesContele = class
  private
    function fGetApiKey: String;

    function fPoisPost(Poi: TPoi; strSeqAut: String): TPoi;
    function fPoisPut(Poi: TPoi; strSeqAut: String): TRetornoUpdatePoi;
    function fPortifoliosPutOrDelete(Portifolios: TPortifolios; strSeqAut: String; blnDelete: Boolean = False): Boolean;
    function fPortifoliosDelete(strIdPoi: String; strSeqAut: String): Boolean;
    function fPoisPoiIdPortifoliosGet(strIdPoi: String; strSeqAut: String): TPortifoliosPoi;
  public
    procedure pSincronizarClientes;
  end;

implementation

uses untConteleRestApi, untRestApi;

{ TContactsClass }

class function TContactsClass.fNew: TContactsClass;
begin
  Result := TContactsClass.Create;
end;

function TContactsClass.f_email(AValue: String): TContactsClass;
begin
  FEmail := AValue;
  Result := Self;
end;

function TContactsClass.f_name(AValue: String): TContactsClass;
begin
  FName := AValue;
  Result := Self;
end;

function TContactsClass.f_phone(AValue: String): TContactsClass;
begin
  FPhone := AValue;
  Result := Self;
end;

{ TPoi }

constructor TPoi.Create;
begin
  inherited;
  FAddress := TAddressClass.Create();
end;

destructor TPoi.Destroy;
var
  LcontactsItem: TContactsClass;
  LhistoryItem: THistoryClass;
begin

 for LcontactsItem in FContacts do
   LcontactsItem.free;
 for LhistoryItem in FHistory do
   LhistoryItem.free;

  FAddress.free;
  inherited;
end;

function TPoi.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TPoi.FromJsonString(AJsonString: string): TPoi;
begin
  Result := TJson.JsonToObject<TPoi>(AJsonString)
end;

procedure TPoi.pAddContact(contact: TContactsClass);
begin
  SetLength(FContacts, Length(FContacts)+1);;
  FContacts[Length(FContacts)-1] := contact;
end;

{TRetornoAddressClass}

constructor TRetornoAddressClass.Create;
begin
  inherited;
  FLocation := TLocationClass.Create();
end;

destructor TRetornoAddressClass.Destroy;
begin
  FLocation.free;
  inherited;
end;

{TRetornoUpdatePoi}

constructor TRetornoUpdatePoi.Create;
begin
  inherited;
  FAddress := TRetornoAddressClass.Create();
end;

destructor TRetornoUpdatePoi.Destroy;
var
  LcontactsItem: TContactsClass;
begin

 for LcontactsItem in FContacts do
   LcontactsItem.free;

  FAddress.free;
  inherited;
end;

class function TRetornoUpdatePoi.FromJsonString(AJsonString: string): TRetornoUpdatePoi;
begin
  Result := TJson.JsonToObject<TRetornoUpdatePoi>(AJsonString)
end;

{ TPortifolios }

function TPortifolios.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{ TPortifoliosPoi }

destructor TPortifoliosPoi.Destroy;
var
  LportifoliosItem: TPortifoliosClass;
begin
  for LportifoliosItem in FPortifolios do
    LportifoliosItem.free;

  inherited;
end;

class function TPortifoliosPoi.FromJsonString(
  AJsonString: string): TPortifoliosPoi;
begin
  Result := TJson.JsonToObject<TPortifoliosPoi>(AJsonString)
end;

{ TControllerGestorDeEquipesContele }

function TControllerGestorDeEquipesContele.fGetApiKey: String;
begin
  Result := fCampoTabela('CON_KEYCON', 'APICON', ['CON_CODEMP'], [VS_strCodEmp]);
end;

procedure TControllerGestorDeEquipesContele.pSincronizarClientes;
const
  SQL_CADCLI =
  ' SELECT '+
  '   CLI_DTINCO, '+
  '   CLI_HRINCO, '+
  '   CADCLI.AUTOINCREM, '+
  '   CLI_CODCLI, '+
  '   CLI_NOMCLI, '+
  '   CLI_EMAIL_, '+
  '   CLI_C_G_C_, '+
  '   CLI_ENDERE,'+
  '   CLI_ENDNUM, '+
  '   CLI_C_E_P_, '+
  '   CLI_BAIRRO, '+
  '   CID_NOMCID, '+
  '   CID_ESTADO, '+
  '   CLI_FONE01, '+
  '   CLI_EMAIL_, '+
  '   CLI_CONTAT, '+
  '   CAC_IDCONT, '+
  '   ATI_IDCONT, '+
  '   CADOPE.AUTOINCREM AS AUTOINCREM_VENDEDOR, '+
  '   OPE_IDCONT  '+
  ' FROM '+
  '   CADCLI '+
  ' LEFT JOIN CADCID ON '+
  '   CLI_CODCID = CID_CODCID '+
  ' LEFT JOIN CADCAC ON '+
  '   CLI_CODCAC = CAC_CODCAC '+
  ' LEFT JOIN CADATI ON '+
  '   CLI_CODATI = ATI_CODATI '+
  ' LEFT JOIN CADOPE ON '+
  '   CLI_CODVEN = OPE_CODOPE '+
  ' WHERE '+
  '   CLI_INTCON = "S" ';

  SQL_UPDATE_CADCLI =
  ' UPDATE '+
  '   CADCLI '+
  ' SET '+
  '   CLI_INTCON = "N" '+
  '  ,CLI_DTINCO = :DTINCO '+
  '  ,CLI_HRINCO = :HRINCO '+
  ' WHERE '+
  '   AUTOINCREM = :AUTINC ';

  SQL_CLIVEN =
  ' SELECT '+
  '   CLIVEN.AUTOINCREM, '+
  '   OPE_IDCONT '+
  ' FROM '+
  '   CLIVEN '+
  ' INNER JOIN CADOPE ON '+
  '   CVE_CODVEN = OPE_CODOPE '+
  ' WHERE '+
  '   CVE_CODCLI = :CODCLI '+
  ' GROUP BY '+
  '   AUTOINCREM, '+
  '   OPE_IDCONT  ';
var
  qryAux,
  qryCadCli,
  qryCliven: IQuery;

  Poi: TPoi;
  PoiPost: TPoi;
  PoiPut: TRetornoUpdatePoi;
  Portifolios: TPortifolios;
begin
  PoiPost := nil;
  PoiPut := nil;

  if not fCfgSis('APICON', varBoolean) then
    Exit;  

  qryAux := fCriaQuery;  

  qryCadCli := fCriaQuery;
  qryCadCli.Close;
  qryCadCli.SQL.Text := SQL_CADCLI;
  qryCadCli.Open;

  if qryCadCli.IsEmpty then
    Exit;

  if fCfgSis('MLTOPE', varBoolean) then
  begin
    qryCliven := fCriaQuery;
    qryCliven.Close;
    qryCliven.SQL.Text := SQL_CLIVEN;
    qryCliven.ParamByname('CODCLI').AsString := qryCadCli.FieldByName('CLI_CODCLI').AsString;
    qryCliven.Open;
  end;

  qryCadCli.First;
  while not qryCadCli.Eof do
  begin
    Poi := TPoi.Create;
    Portifolios := TPortifolios.Create;
    try
      Poi.id := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      Poi.creatorId := strLoginUsuarioLogado;
      Poi.creatorName := 'GestorEquipeContele';
      Poi.customId := qryCadCli.FieldByName('CLI_CODCLI').AsString;
      Poi.name := qryCadCli.FieldByName('CLI_CODCLI').AsString + ' - ' + qryCadCli.FieldByName('CLI_NOMCLI').AsString;
      Poi.corporateName := qryCadCli.FieldByName('CLI_CODCLI').AsString + ' - ' +  qryCadCli.FieldByName('CLI_NOMCLI').AsString;
      Poi.cnpj_cpf := qryCadCli.FieldByName('CLI_C_G_C_').AsString;
      Poi.address.neighborhood := qryCadCli.FieldByName('CLI_BAIRRO').AsString;
      Poi.address.street := qryCadCli.FieldByName('CLI_ENDERE').AsString;
      Poi.address.state := qryCadCli.FieldByName('CID_ESTADO').AsString;
      Poi.address.zipcode := qryCadCli.FieldByName('CLI_C_E_P_').AsString;
      Poi.address.number := qryCadCli.FieldByName('CLI_ENDNUM').AsString;
      Poi.address.city := qryCadCli.FieldByName('CID_NOMCID').AsString;

      Poi.pAddContact(TContactsClass.fNew
                        .f_name(qryCadCli.FieldByName('CLI_CONTAT').AsString)
                        .f_email(qryCadCli.FieldByName('CLI_EMAIL_').AsString)
                        .f_phone(qryCadCli.FieldByName('CLI_FONE01').AsString));

      Poi.categoryId := IIF(fCfgSis('CATCON') = '1', qryCadCli.FieldByName('CAC_IDCONT').AsString, qryCadCli.FieldByName('ATI_IDCONT').AsString);
      Poi.origin := 'GestorEquipeContele.AutCom.Linux';
      Poi.addressHasUpdated := (not qryCadCli.FieldByName('CLI_DTINCO').IsNull);
      Poi.editFromWeb := False;

      if qryCadCli.FieldByName('CLI_DTINCO').IsNull then
        PoiPost := fPoisPost(Poi, qryCadCli.FieldByName('AUTOINCREM').AsString)
      else
        PoiPut := fPoisPut(Poi, qryCadCli.FieldByName('AUTOINCREM').AsString);

      if ((Assigned(PoiPost)) and (not fEmptyStr(PoiPost.clientId))) or
         ((Assigned(PoiPut)) and (not fEmptyStr(PoiPut.clientId))) then
      begin        
        qryAux.Close;
        qryAux.SQL.Text := SQL_UPDATE_CADCLI;
        qryAux.ParamByName('DTINCO').AsDate := fRetDataServidor;
        qryAux.ParamByName('HRINCO').AsTime := fRetHoraServidor;
        qryAux.ParamByName('AUTINC').AsString := qryCadCli.FieldByName('AUTOINCREM').AsString;
        qryAux.ExecSQL;

        Sleep(500);

        if fPortifoliosDelete(qryCadCli.FieldByName('CLI_CODCLI').AsString, qryCadCli.FieldByName('AUTOINCREM').AsString) then
        begin
          if fCfgSis('MLTOPE', varBoolean) then
          begin
            qryCliven.First;
            while not qryCliven.Eof do
            begin
              if not fEmptyStr(qryCliven.FieldByName('OPE_IDCONT').AsString) then
              begin
                Sleep(500);

                Portifolios.portifoliosIds := qryCliven.FieldByName('OPE_IDCONT').AsString;

                SetLength(Portifolios.FPoisIds, 1);
                Portifolios.FPoisIds[0] := qryCadCli.FieldByName('CLI_CODCLI').AsString;

                fPortifoliosPutOrDelete(Portifolios, qryCliven.FieldByName('AUTOINCREM').AsString);
              end;

              qryCliven.Next;
            end;            
          end
          else if not fEmptyStr(qryCadCli.FieldByName('OPE_IDCONT').AsString) then
          begin
            Portifolios.portifoliosIds := qryCadCli.FieldByName('OPE_IDCONT').AsString;

            SetLength(Portifolios.FPoisIds, 1);
            Portifolios.FPoisIds[0] := qryCadCli.FieldByName('CLI_CODCLI').AsString;

            fPortifoliosPutOrDelete(Portifolios, qryCadCli.FieldByName('AUTOINCREM_VENDEDOR').AsString);            
          end;
        end;
      end;

    finally
      FreeAndNil(Poi);

      if Assigned(PoiPost) then
        FreeAndNil(PoiPost);

      if Assigned(PoiPut) then
        FreeAndNil(PoiPut);

      FreeAndNil(Portifolios);

      qryCadCli.Next;
    end;    
  end;
end;

function TControllerGestorDeEquipesContele.fPoisPost(Poi: TPoi; strSeqAut: String): TPoi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/pois';
    RestRequest.Method := rmPOST;

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    RESTRequest.Params.AddItem('',
                                 Poi.ToJsonString,
                                 TREstRequestParameterKind.pkREQUESTBODY,
                                 [],
                                 TRESTContentType.ctAPPLICATION_JSON
                               );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqAut) then
      Result := TPoi.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

function TControllerGestorDeEquipesContele.fPoisPut(Poi: TPoi; strSeqAut: String): TRetornoUpdatePoi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/pois/'+Poi.id;
    RestRequest.Method := rmPUT;

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    RESTRequest.Params.AddItem('',
                                 Poi.ToJsonString,
                                 TREstRequestParameterKind.pkREQUESTBODY,
                                 [],
                                 TRESTContentType.ctAPPLICATION_JSON
                               );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqAut) then
        Result := TRetornoUpdatePoi.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

function TControllerGestorDeEquipesContele.fPortifoliosPutOrDelete(Portifolios: TPortifolios; strSeqAut: String; blnDelete: Boolean = False): Boolean;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/portifolios';
    RestRequest.Method := IIF(not blnDelete, rmPut, rmDELETE);

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    RESTRequest.Params.AddItem('',
                                 Portifolios.ToJsonString,
                                 TREstRequestParameterKind.pkREQUESTBODY,
                                 [],
                                 TRESTContentType.ctAPPLICATION_JSON
                               );

    Result := ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqAut);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

function TControllerGestorDeEquipesContele.fPortifoliosDelete(strIdPoi: String; strSeqAut: String): Boolean;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  PortifoliosPoi: TPortifoliosPoi;
  Portifolio: TPortifoliosClass;
  Portifolios: TPortifolios;
begin
  Result := True;

  Portifolios := TPortifolios.Create;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    PortifoliosPoi := fPoisPoiIdPortifoliosGet(strIdPoi, strSeqAut);

    if not Assigned(PortifoliosPoi) then
      Exit;

    for Portifolio in PortifoliosPoi.portifolios do
    begin
      Portifolios.portifoliosIds := Portifolio.id;

      SetLength(Portifolios.FPoisIds, 1);
      Portifolios.FPoisIds[0] := strIdPoi;

      Result := fPortifoliosPutOrDelete(Portifolios, strSeqAut, True);

      if not Result then
        Break;

      Sleep(500);
    end;
  finally
    if Assigned(PortifoliosPoi) then
      FreeAndNil(PortifoliosPoi);

    FreeAndNil(Portifolios);
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

function TControllerGestorDeEquipesContele.fPoisPoiIdPortifoliosGet(strIdPoi: String; strSeqAut: String): TPortifoliosPoi;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('CONTELE', TControllerContele.fConfigurarContele);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'v2/pois/'+strIdPoi+'/portifolios';
    RestRequest.Method := rmGet;

    RESTRequest.Params.AddItem('x-api-key', fGetApiKey, TREstRequestParameterKind.pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqAut) then
      Result := TPortifoliosPoi.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
  end;
end;

end.
