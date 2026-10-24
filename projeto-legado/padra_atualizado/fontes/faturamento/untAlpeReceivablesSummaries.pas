unit untAlpeReceivablesSummaries;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type
//BEGIN - OBJETOS DE RETORNO
  TProductClass = class
  private
    FCode: String;
  public
    property code: String read FCode write FCode;
  end;

  TItemsClass = class
  private
    FAmount: Extended;
    FProduct: TProductClass;
    FTotalAmount: Extended;
  public
    property amount: Extended read FAmount write FAmount;
    property product: TProductClass read FProduct write FProduct;
    property totalAmount: Extended read FTotalAmount write FTotalAmount;
    constructor Create;
    destructor Destroy; override;
  end;

  TPropertiesClass = class
  private
    FCode: String;
    FValue: TArray<Extended>;
  public
    property code: String read FCode write FCode;
    property value: TArray<Extended> read FValue write FValue;
  end;

  TRelationshipClass = class
  private
    FProperties: TArray<TPropertiesClass>;
  public
    property properties: TArray<TPropertiesClass> read FProperties write FProperties;
    destructor Destroy; override;
  end;

  TPartyClass = class
  private
    FName: String;
    FUrn: String;
  public
    property name: String read FName write FName;
    property urn: String read FUrn write FUrn;
  end;

  TBuyerClass = class
  private
    FParty: TPartyClass;
  public
    property party: TPartyClass read FParty write FParty;
    constructor Create;
    destructor Destroy; override;
  end;

  TSupplierClass = class
  private
    FParty: TPartyClass;
  public
    property party: TPartyClass read FParty write FParty;
    constructor Create;
    destructor Destroy; override;
  end;

  TContentClass = class
  private
    FBuyer: TBuyerClass;
    FItems: TArray<TItemsClass>;
    FRelationship: TRelationshipClass;
    FSupplier: TSupplierClass;
  public
    property buyer: TBuyerClass read FBuyer write FBuyer;
    property items: TArray<TItemsClass> read FItems write FItems;
    property relationship: TRelationshipClass read FRelationship write FRelationship;
    property supplier: TSupplierClass read FSupplier write FSupplier;
    constructor Create;
    destructor Destroy; override;
  end;

  TReceivablesSummaries = class
  private
    FContent: TArray<TContentClass>;
    FDuration: Extended;
    FId: String;
    FInstant: String;
    FResource: String;
    FStatus: Extended;
  public
    property content: TArray<TContentClass> read FContent write FContent;
    property duration: Extended read FDuration write FDuration;
    property id: String read FId write FId;
    property instant: String read FInstant write FInstant;
    property resource: String read FResource write FResource;
    property status: Extended read FStatus write FStatus;
    destructor Destroy; override;
    class function ToJsonString(ReceivablesSummaries: TReceivablesSummaries): string;
    class function FromJsonString(AJsonString: string): TReceivablesSummaries;
  end;
//END - OBJETOS DE RETORNO

//BEGIN - OBJETOS DE ERRO RETORNO
  TContentClassError = class
  private
    FCode: String;
    FTitle: String;
  public
    property code: String read FCode write FCode;
    property title: String read FTitle write FTitle;
  end;

  TReceivablesSummariesError = class
  private
    FContent: TArray<TContentClassError>;
    FDuration: Extended;
    FId: String;
    FInstant: String;
    FResource: String;
    FStatus: Extended;
  public
     property content: TArray<TContentClassError> read FContent write FContent;
    property duration: Extended read FDuration write FDuration;
    property id: String read FId write FId;
    property instant: String read FInstant write FInstant;
    property resource: String read FResource write FResource;
    property status: Extended read FStatus write FStatus;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TReceivablesSummariesError;
  end;
//END - OBJETOS DE ERRO RETORNO

//BEGIN - CONTROLLER
  TControllerReceivablesSummaries = class
  private
  public
    class function fGet(buyerUrn: String; strSeqFgo: String = ''): TReceivablesSummaries;
    class procedure pProcessarReceivablesSummaries;
  end;
//END - CONTROLLER

implementation

uses
  untRestApi, untAlpeRestApi;

//BEGIN - MÉTODOS DE RETORNO
{TItemsClass}

constructor TItemsClass.Create;
begin
  inherited;
  FProduct := TProductClass.Create();
end;

destructor TItemsClass.Destroy;
begin
  FProduct.free;
  inherited;
end;

{TRelationshipClass}

destructor TRelationshipClass.Destroy;
var
  LpropertiesItem: TPropertiesClass;
begin

 for LpropertiesItem in FProperties do
   LpropertiesItem.free;

  inherited;
end;

{TBuyerClass}

constructor TBuyerClass.Create;
begin
  inherited;
  FParty := TPartyClass.Create();
end;

destructor TBuyerClass.Destroy;
begin
  FParty.free;
  inherited;
end;

{TSupplierClass}

constructor TSupplierClass.Create;
begin
  inherited;
  FParty := TPartyClass.Create();
end;

destructor TSupplierClass.Destroy;
begin
  FParty.free;
  inherited;
end;

{TContentClass}

constructor TContentClass.Create;
begin
  inherited;
  FSupplier := TSupplierClass.Create();
  FBuyer := TBuyerClass.Create();
  FRelationship := TRelationshipClass.Create();
end;

destructor TContentClass.Destroy;
var
  LitemsItem: TItemsClass;
begin

 for LitemsItem in FItems do
   LitemsItem.free;

  FSupplier.free;
  FBuyer.free;
  FRelationship.free;
  inherited;
end;

{TReceivablesSummaries}

destructor TReceivablesSummaries.Destroy;
var
  LcontentItem: TContentClass;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TReceivablesSummaries.ToJsonString(ReceivablesSummaries: TReceivablesSummaries): string;
begin
  result := TJson.ObjectToJsonString(ReceivablesSummaries);
end;
//END - MÉTODOS DE RETORNO

class function TReceivablesSummaries.FromJsonString(AJsonString: string): TReceivablesSummaries;
begin
  result := TJson.JsonToObject<TReceivablesSummaries>(AJsonString)
end;

// BEGIN - MÉTODOS DE RETORNO COM ERRO
{TReceivablesSummariesError}

destructor TReceivablesSummariesError.Destroy;
var
  LcontentItem: TContentClassError;
begin

 for LcontentItem in FContent do
   LcontentItem.free;

  inherited;
end;

class function TReceivablesSummariesError.FromJsonString(AJsonString: string): TReceivablesSummariesError;
begin
  result := TJson.JsonToObject<TReceivablesSummariesError>(AJsonString)
end;
// END - MÉTODOS DE RETORNO COM ERRO


//BEGIN - MÉTODOS DO CONTROLLER
{ TControllerReceivablesSummaries }

class procedure TControllerReceivablesSummaries.pProcessarReceivablesSummaries;
var
  qrySummaries,
  qryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  ReceivablesSummaries: TReceivablesSummaries;

  i, p: Integer;
  strCodCnd: String;
begin

  try
    qrySummaries          := fCriaQuery;
    qryUpdate             := fCriaQuery;
    ReceivablesSummaries  := nil;
    try
      qrySummaries.Close;
      qrySummaries.SQL.Clear;
      qrySummaries.SQL.Text :=
      ' SELECT '+
      '   F.AUTOINCREM, '+
      '   F.FGO_VLRCON, '+
      '   C.CLI_C_G_C_ '+
      ' FROM '+
      '   FATGOR F '+
      '   INNER JOIN EXTGOR E ON F.AUTOINCREM = E.FGO_SEQFGO '+
      '   INNER JOIN CADCLI C ON F.FGO_CODCLI = C.CLI_CODCLI '+
      ' WHERE '+
      '   F.FGO_ESPDOC    = "PD"    AND '+
      '   F.FGO_LIBERA    = 0       AND '+
      '   E.FGO_TIPREC    = "ALPES" AND '+
      '   F.FGO_CODEMP    = :CODEMP AND '+
      '   E.FGO_OCOLIB IS NULL ';

      qrySummaries.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qrySummaries.Open;

      if not qrySummaries.IsEmpty then
      begin

        while not qrySummaries.Eof do
        begin

          ReceivablesSummaries := fGet(qrySummaries.FieldByName('CLI_C_G_C_').AsString,
                                       qrySummaries.FieldByName('AUTOINCREM').AsString);

          if ReceivablesSummaries <> nil then
          begin
            if ReceivablesSummaries.content[0].items[0].amount >= qrySummaries.FieldByName('FGO_VLRCON').AsFloat then
            begin
              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   FATGOR '+
              ' INNER JOIN EXTGOR '+
              '   ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO '+
              ' SET '+
              '   FATGOR.FGO_CONPAG = :CONPAG'+
              '  ,EXTGOR.FGO_TIPREC = "ALPE"'+
              ' WHERE '+
              '   FATGOR.AUTOINCREM = :AUTOIN';

              for p := 0 to Length(ReceivablesSummaries.content[0].relationship.properties)-1 do
              begin
                if ReceivablesSummaries.content[0].relationship.properties[p].code = 'supplier-parcels' then
                  strCodCnd := fStrZero(ReceivablesSummaries.content[0].relationship.properties[p].value[0].ToString,2);

                if ReceivablesSummaries.content[0].relationship.properties[p].code = 'supplier-paymentTerm' then
                  for i := 0 to Length(ReceivablesSummaries.content[0].relationship.properties[p].value)-1 do
                  begin
                    strCodCnd := strCodCnd + fStrZero(ReceivablesSummaries.content[0].relationship.properties[1].value[i].ToString,3);
                  end;
              end;

              qryUpdate.ParamByName('CONPAG').AsString := strCodCnd;
              qryUpdate.ParamByName('AUTOIN').AsString := qrySummaries.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ExecSQL;
            end
            else
            begin
              qryUpdate.Close;
              qryUpdate.SQL.Clear;
              qryUpdate.SQL.Text :=
              ' UPDATE '+
              '   EXTGOR '+
              ' SET '+
              '   FGO_OCOLIB = :OCOLIB'+
              ' WHERE '+
              '   FGO_SEQFGO = :AUTOIN';

              qryUpdate.ParamByName('OCOLIB').AsString := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_OCOLIB']);
              qryUpdate.ParamByName('AUTOIN').AsString := qrySummaries.FieldByName('AUTOINCREM').AsString;
              qryUpdate.ExecSQL;
            end;
          end;

          {$IFDEF LINUX}
          TTasklock.pZerarTentativasLock(Format(spIdRecebiveisAlpe, [VS_strCodEmp]));
          {$ENDIF LINUX}

          qrySummaries.Next;
          Sleep(1000);
        end;
      end;

    finally
     {$IFNDEF LINUX}
      qrySummaries.Free;
      qryUpdate.Free;
     {$ENDIF LINUX}
     if Assigned(ReceivablesSummaries) then
       ReceivablesSummaries.Free;
    end;
  except
    on E: Exception do
      pGravarErro(True, E.Message);
  end;
end;

class function TControllerReceivablesSummaries.fGet(buyerUrn: String; strSeqFgo: String = ''): TReceivablesSummaries;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;

  {$IFDEF LINUX} {$ELSE }ReceivablesSummariesError: TReceivablesSummariesError;{$ENDIF LINUX}
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ALPE', TControllerAlpe.fConfigurarAlpe);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'accounting/api/v1/receivables-summaries';
    RestRequest.Method   := rmGET;
    RestRequest.Params.AddItem('buyerUrn', 'urn:party:cnpj:'+buyerUrn, pkGETorPOST);
    RestRequest.Params.AddItem('productCode', 'RECEIVABLES_CESSION', pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '201'], strSeqFgo) then
      Result := TReceivablesSummaries.FromJsonString(JSONRetorno)
    {$IFDEF LINUX}
    {$ELSE }
    else
    begin
      try
        ReceivablesSummariesError := TReceivablesSummariesError.FromJsonString(JSONRetorno);
        fMensagem('ALPE', 'Resposta: '+ReceivablesSummariesError.content[0].title,['&OK']);
      except
        fMensagem('ALPE', 'Serviço Alpe indisponível',['&OK']);
      end;
    end;
    {$ENDIF LINUX}

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;
//END - MÉTODOS DO CONTROLLER

end.

