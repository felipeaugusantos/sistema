unit untCatalagoFraga.CatalogSearch;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types, System.Classes,
  System.JSON, strUtils, Math, System.DateUtils, REST.Authenticator.OAuth,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni, untUtilMonitor, untFuncFatTypes;
  {$ENDIF LINUX}

type
  TSpecificationsClass = class
  private
    FCategory: String;
    FDescription: String;
    FId: String;
    FImportant: Boolean;
    FValue: String;
  public
    property category: String read FCategory write FCategory;
    property description: String read FDescription write FDescription;
    property id: String read FId write FId;
    property important: Boolean read FImportant write FImportant;
    property value: String read FValue write FValue;
  end;

  TProductClass = class
  private
    FId: String;
    FPartNumber: String;
    FSpecifications: TArray<TSpecificationsClass>;
  public
    property id: String read FId write FId;
    property partNumber: String read FPartNumber write FPartNumber;
    property specifications: TArray<TSpecificationsClass> read FSpecifications write FSpecifications;
    destructor Destroy; override;
  end;

  TNodesClass = class
  private
    FProduct: TProductClass;
  public
    property product: TProductClass read FProduct write FProduct;
    constructor Create;
    destructor Destroy; override;

    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TNodesClass;
  end;

  TCatalogSearchClass = class
  private
    FNodes: TArray<TNodesClass>;

  public
    property nodes: TArray<TNodesClass> read FNodes write FNodes;
    destructor Destroy; override;
  end;

  TDataClass = class
  private
    FCatalogSearch: TCatalogSearchClass;
  public
    property catalogSearch: TCatalogSearchClass read FCatalogSearch write FCatalogSearch;
    constructor Create;
    destructor Destroy; override;
  end;

  TLocationsClass = class
  private
    FColumn: Extended;
    FLine: Extended;
  public
    property column: Extended read FColumn write FColumn;
    property line: Extended read FLine write FLine;
  end;

  TErrorsClass = class
  private
    FLocations: TArray<TLocationsClass>;
    FMessage: String;
    FPath: TArray<String>;
  public
    property locations: TArray<TLocationsClass> read FLocations write FLocations;
    property message: String read FMessage write FMessage;
    property path: TArray<String> read FPath write FPath;
    destructor Destroy; override;
  end;

  TRetornoCatalogSearch = class
  private
    FData: TDataClass;
    FErrors: TArray<TErrorsClass>;
  public
    property data: TDataClass read FData write FData;
    property errors: TArray<TErrorsClass> read FErrors write FErrors;

    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoCatalogSearch;
  end;

  TFragaCatalogSearch = class
  private
    FNodes: TArray<TNodesClass>;

    procedure pAddNode(Node: TNodesClass);

    function fRetornouErro(RetornoCatalogSearch: TRetornoCatalogSearch): Boolean;
    function fRetornouDados(RetornoCatalogSearch: TRetornoCatalogSearch): Boolean;
    function fRetQueryGraphQL(const AstrSkip: String): String;
    function fRetCatalogo(const AintSkip: Integer): TRetornoCatalogSearch;
  public
    property nodes: TArray<TNodesClass> read FNodes write FNodes;

    destructor Destroy; override;

    procedure pCarregaCatalogoSearch;
    procedure pCarregaCatalogoSearchBanco;
  end;

implementation

uses untCatalogoFragaRestApi, untRestApi, untTokenCatalogoFraga;

{TProductClass}

destructor TProductClass.Destroy;
var
  LspecificationsItem: TSpecificationsClass;
begin

 for LspecificationsItem in FSpecifications do
   LspecificationsItem.free;

  inherited;
end;

{TNodesClass}

constructor TNodesClass.Create;
begin
  inherited;
  FProduct := TProductClass.Create();
end;

destructor TNodesClass.Destroy;
begin
  FProduct.free;
  inherited;
end;

function TNodesClass.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

class function TNodesClass.FromJsonString(AJsonString: string): TNodesClass;
begin
  result := TJson.JsonToObject<TNodesClass>(AJsonString)
end;

{TCatalogSearchClass}

destructor TCatalogSearchClass.Destroy;
var
  LnodesItem: TNodesClass;
begin

 for LnodesItem in FNodes do
   LnodesItem.free;

  inherited;
end;

{TDataClass}

constructor TDataClass.Create;
begin
  inherited;
  FCatalogSearch := TCatalogSearchClass.Create();
end;

destructor TDataClass.Destroy;
begin
  FCatalogSearch.free;
  inherited;
end;

{TErrorsClass}

destructor TErrorsClass.Destroy;
var
  LlocationsItem: TLocationsClass;
begin

 for LlocationsItem in FLocations do
   LlocationsItem.free;

  inherited;
end;

{ TFragaCatalogSearch }

destructor TFragaCatalogSearch.Destroy;
var
  LnodesItem: TNodesClass;
begin

 for LnodesItem in FNodes do
   LnodesItem.free;

  inherited;
end;

procedure TFragaCatalogSearch.pAddNode(Node: TNodesClass);
begin
  SetLength(FNodes, Length(FNodes)+1);
  FNodes[Length(FNodes)-1] := TNodesClass.FromJsonString(Node.ToJsonString);
end;

procedure TFragaCatalogSearch.pCarregaCatalogoSearchBanco;
var
  RetornoCatalogSearch: TRetornoCatalogSearch;
  Node: TNodesClass;
  qry: IQuery;
begin
  qry := fcriaQuery;
  qry.Close;
  qry.SQL.Text := ' SELECT LOG_RESULT FROM LOGAPI WHERE LOG_DTAENT = CURRENT_DATE AND LOG_LOGAPI = "FRAGA_CATALOGO" AND LOG_PARAME LIKE "%catalogSearch%" AND LOG_STATUS = "200"';
  qry.Open;
  while not qry.Eof do
  begin
    Writeln(DateTimeToStr(fNow) + ' - ' +
            'Consultando produtos do catálogo através da LOGAPI ... ');
    try
      RetornoCatalogSearch := TRetornoCatalogSearch.FromJsonString(qry.FieldByName('LOG_RESULT').AsString);
      try
        if fRetornouErro(RetornoCatalogSearch) then
        begin
          qry.Next;
          Continue;
        end;

        if not fRetornouDados(RetornoCatalogSearch) then
          Exit;

        for Node in RetornoCatalogSearch.data.catalogSearch.nodes do
          Self.pAddNode(Node);
      finally
        if Assigned(RetornoCatalogSearch) then
          FreeAndNil(RetornoCatalogSearch);
      end;
      qry.Next;
    except
      qry.Next;
    end;
  end;
end;

procedure TFragaCatalogSearch.pCarregaCatalogoSearch;
var
  RetornoCatalogSearch: TRetornoCatalogSearch;
  Node: TNodesClass;
  intSkip: Integer;
  intMaxSkip: Integer;
begin
  intSkip := StrToIntDef(GetParamValue('-qtdi'), 0);
  intMaxSkip := StrToIntDef(GetParamValue('-qtdf'), 0);
  repeat
    TTasklock.pZerarTentativasLock(Format(spIdCatalogoFraga, [VS_strCodEmp]));

    if (intMaxSkip > 0) and (intSkip >= intMaxSkip) then
      Break;

    Writeln(DateTimeToStr(fNow) + ' - ' +
            'Baixando catálogo(Skip '+intSkip.ToString+') ... ');

    RetornoCatalogSearch := fRetCatalogo(intSkip);
    try
      if fRetornouErro(RetornoCatalogSearch) then
        Continue;

      if not fRetornouDados(RetornoCatalogSearch) then
        Exit;

      for Node in RetornoCatalogSearch.data.catalogSearch.nodes do
        Self.pAddNode(Node);
    finally
      if Assigned(RetornoCatalogSearch) then
      begin
        if not fRetornouErro(RetornoCatalogSearch) then
          intSkip := intSkip + 50;

        FreeAndNil(RetornoCatalogSearch);
      end;
      Sleep(500);
    end;
  until False;
end;

function TFragaCatalogSearch.fRetornouErro(RetornoCatalogSearch: TRetornoCatalogSearch): Boolean;
begin
  Result := False;

  if not Assigned(RetornoCatalogSearch) then
    Exit(True);

  if Assigned(RetornoCatalogSearch.data) then
    Result := (Length(RetornoCatalogSearch.errors) > 0);
end;

function TFragaCatalogSearch.fRetornouDados(RetornoCatalogSearch: TRetornoCatalogSearch): Boolean;
begin
  Result := True;

  if not Assigned(RetornoCatalogSearch) then
    Exit(False);

  if not Assigned(RetornoCatalogSearch.data) then
    Exit(False);

  if not Assigned(RetornoCatalogSearch.data.catalogSearch) then
    Exit(False);

  if not Assigned(RetornoCatalogSearch.data.catalogSearch.nodes) then
    Exit(False);

  if not Assigned(RetornoCatalogSearch.data.catalogSearch.nodes[0].product) then
    Exit(False);
end;

function TFragaCatalogSearch.fRetCatalogo(
  const AintSkip: Integer): TRetornoCatalogSearch;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('FRAGA_CATALOGO', TCatalogoFragaRestApi.fConfigurarCatalogoFraga);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    try
      RestRequest.Method := rmPOST;

      TTokenCatalogoFraga.pRefreshTokenFraga;

      if fEmptyStr(VS_strToken) then
        Exit;

      RestRequest.Params.AddItem('Authorization', 'Bearer '+VS_strToken, pkHTTPHEADER);

      RESTRequest
      .Params
      .AddItem(  '',
                 fRetQueryGraphQL(AintSkip.ToString),
                 TRestRequestParameterKind.pkREQUESTBODY,
                 [],
                 TRESTContentType.ctAPPLICATION_JSON
               );

      if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
        Result := TRetornoCatalogSearch.FromJsonString(JSONRetorno);
    except
      Result := nil;
    end;
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

function TFragaCatalogSearch.fRetQueryGraphQL(const AstrSkip: String): String;
begin
   Result :=
    ' { '+
    '   "query": '+
    '     "query { '+
    '        catalogSearch(query: \"\", skip: '+AstrSkip+', take: 50) '+
    '        { '+
    '           nodes { '+
    '             product { '+
    '               id '+
    '               partNumber '+
    '               specifications { '+
    '                 id '+
    '                 category '+
    '                 description '+
    '                 value '+
    '                 important '+
    '               } '+
    '             } '+
    '           } '+
    '        } '+
    '     }" '+
    ' } ';
end;

{ TRetornoCatalogSearch }

constructor TRetornoCatalogSearch.Create;
begin
  inherited;
  FData := TDataClass.Create();
end;

destructor TRetornoCatalogSearch.Destroy;
var
  Error: TErrorsClass;
begin
  FData.free;

  for Error in FErrors do
    Error.Free;

  SetLength(FErrors, 0);

  inherited;
end;

class function TRetornoCatalogSearch.FromJsonString(
  AJsonString: string): TRetornoCatalogSearch;
begin
  Result := TJson.JsonToObject<TRetornoCatalogSearch>(AJsonString);
end;



end.
