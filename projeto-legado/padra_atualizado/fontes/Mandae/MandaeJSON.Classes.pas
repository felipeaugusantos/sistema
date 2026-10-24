unit MandaeJSON.Classes;

interface

uses Generics.Collections, Rest.Json, Uni, SysUtils, DB, StrUtils, UniClientDataSet;

  type

  TValueAddedServicesClass = class
  private
    FName: String;
    FValue: Extended;
  public
    property name: String read FName write FName;
    property value: Extended read FValue write FValue;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TValueAddedServicesClass;
  end;

  TAddressClass = class
  private
    FAddressLine2: String;
    FCity: String;
    FCountry: String;
    FNeighborhood: String;
    FNumber: String;
    FPostalCode: String;
    FReference: String;
    FState: String;
    FStreet: String;
  public
    property addressLine2: String read FAddressLine2 write FAddressLine2;
    property city: String read FCity write FCity;
    property country: String read FCountry write FCountry;
    property neighborhood: String read FNeighborhood write FNeighborhood;
    property number: String read FNumber write FNumber;
    property postalCode: String read FPostalCode write FPostalCode;
    property reference: String read FReference write FReference;
    property state: String read FState write FState;
    property street: String read FStreet write FStreet;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TAddressClass;
  end;

  TRecipientClass = class
  private
    FAddress: TAddressClass;
    FDocument: String;
    FEmail: String;
    FFullName: String;
    FPhone: String;
  public
    property address: TAddressClass read FAddress write FAddress;
    property document: String read FDocument write FDocument;
    property email: String read FEmail write FEmail;
    property fullName: String read FFullName write FFullName;
    property phone: String read FPhone write FPhone;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRecipientClass;
  end;

  TInvoiceClass = class
  private
    FId: String;
    FKey: String;
    FType: String;
  public
    property id: String read FId write FId;
    property key: String read FKey write FKey;
    property &type: String read FType write FType;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TInvoiceClass;
  end;

  TSkusClass = class
  private
    FDescription: String;
    FEan: String;
    FPrice: Extended;
    FQuantity: Extended;
    FSkuId: String;
  public
    property description: String read FDescription write FDescription;
    property ean: String read FEan write FEan;
    property price: Extended read FPrice write FPrice;
    property quantity: Extended read FQuantity write FQuantity;
    property skuId: String read FSkuId write FSkuId;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TSkusClass;
  end;

  TDimensionsClass = class
  private
    FHeight: String;
    FLength: String;
    FWeight: String;
    FWidth: String;
  public
    property height: String read FHeight write FHeight;
    property length: String read FLength write FLength;
    property weight: String read FWeight write FWeight;
    property width: String read FWidth write FWidth;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TDimensionsClass;
  end;

  TVolumesClass = class
  private
    FDeclaredValue: Extended;
    FDimensions: TDimensionsClass;
  public
    property declaredValue: Extended read FDeclaredValue write FDeclaredValue;
    property dimensions: TDimensionsClass read FDimensions write FDimensions;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TVolumesClass;
  end;

  TItemsClass = class
  private
    FChannel: String;
    FInvoice: TInvoiceClass;
    FObservation: String;
    FPartnerItemId: String;
    FRecipient: TRecipientClass;
    FShippingService: String;
    FSkus: TArray<TSkusClass>;
    FStore: String;
    FTotalFreight: Extended;
    FTotalValue: Extended;
    FTrackingId: String;
    FValueAddedServices: TArray<TValueAddedServicesClass>;
    FVolumes: TArray<TVolumesClass>;
  public
    property channel: String read FChannel write FChannel;
    property invoice: TInvoiceClass read FInvoice write FInvoice;
    property observation: String read FObservation write FObservation;
    property partnerItemId: String read FPartnerItemId write FPartnerItemId;
    property recipient: TRecipientClass read FRecipient write FRecipient;
    property shippingService: String read FShippingService write FShippingService;
    property skus: TArray<TSkusClass> read FSkus write FSkus;
    property store: String read FStore write FStore;
    property totalFreight: Extended read FTotalFreight write FTotalFreight;
    property totalValue: Extended read FTotalValue write FTotalValue;
    property trackingId: String read FTrackingId write FTrackingId;
    property valueAddedServices: TArray<TValueAddedServicesClass> read FValueAddedServices write FValueAddedServices;
    property volumes: TArray<TVolumesClass> read FVolumes write FVolumes;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TItemsClass;
  end;

  TRootClass = class
  private
    FCustomerId: String;
    FItems: TArray<TItemsClass>;
    FSellerId: String;
  public
    property customerId: String read FCustomerId write FCustomerId;
    property items: TArray<TItemsClass> read FItems write FItems;
    property sellerId: String read FSellerId write FSellerId;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRootClass;
  end;

  TEventsClass = class
  private
    FDate: String;
    FDescription: String;
    FId: String;
    FName: String;
    FTimestamp: TDateTime;
  public
    property date: String read FDate write FDate;
    property description: String read FDescription write FDescription;
    property id: String read FId write FId;
    property name: String read FName write FName;
    property timestamp: TDateTime read FTimestamp write FTimestamp;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEventsClass;
  end;

  TTrackingRootClass = class
  private
    FCarrierName: String;
    FEvents: TArray<TEventsClass>;
    FIdItemParceiro: String;
    FPartnerItemId: String;
    FTrackingCode: String;
  public
    property carrierName: String read FCarrierName write FCarrierName;
    property events: TArray<TEventsClass> read FEvents write FEvents;
    property idItemParceiro: String read FIdItemParceiro write FIdItemParceiro;
    property partnerItemId: String read FPartnerItemId write FPartnerItemId;
    property trackingCode: String read FTrackingCode write FTrackingCode;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TTrackingRootClass;
  end;

  TMandaeJSONBuilder = class
  private
    FQuery               : TUniQuery;
    FstrDocumento        : String;
    FstrEspecieDocumento : String;
    FstrCodigoEmpresa    : String;
    FstrCodigoRastreio   : String;
    procedure pInstanciarObjetoItem(var AobjRootClass : TRootClass);
//    procedure pInstanciarObjetoDeVolume(var AObjItemsClass : TItemsClass);
//    procedure pInstanciarObjetoDeIdentificacaoDoItem(var AObjItemsClass : TItemsClass);
    procedure pInstanciarObjetoDeIdentificacaoDaNota(var AObjItemsClass : TItemsClass);
    procedure pInstanciarObjetoDoDestinatario(var AObjItemsClass : TItemsClass);
    procedure pInstanciarObjetoDoEnderecoDoDestinatario(var AobjRecipientClass : TRecipientClass);
    procedure pInstanciarObjetoDosServicos(var AObjItemsClass : TItemsClass);
    procedure pCarregarDados;
  public
    constructor Create;
    destructor Destroy; override;
    function fGerarJSONParaEnvioEncomendas : String;
    property strDocumento        : String read FstrDocumento        write FstrDocumento;
    property strEspecieDocumento : String read FstrEspecieDocumento write FstrEspecieDocumento;
    property strCodigoEmpresa    : String read FstrCodigoEmpresa    write FstrCodigoEmpresa;
    property strCodigoRastreio   : String read FstrCodigoRastreio   write FstrCodigoRastreio;
    function fGerarClientDaConsultaTracking(AstrJSONTracking : String) : TUniClientDataSet;
  end;

implementation

uses untFuncoesSimples, System.Classes;

{TValueAddedServicesClass}

function TValueAddedServicesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TValueAddedServicesClass.FromJsonString(AJsonString: string): TValueAddedServicesClass;
begin
  result := TJson.JsonToObject<TValueAddedServicesClass>(AJsonString)
end;

{TAddressClass}

function TAddressClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TAddressClass.FromJsonString(AJsonString: string): TAddressClass;
begin
  result := TJson.JsonToObject<TAddressClass>(AJsonString)
end;

{TRecipientClass}

constructor TRecipientClass.Create;
begin
  inherited;
  FAddress := TAddressClass.Create();
end;

destructor TRecipientClass.Destroy;
begin
  FAddress.Free;
  inherited;
end;

function TRecipientClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRecipientClass.FromJsonString(AJsonString: string): TRecipientClass;
begin
  result := TJson.JsonToObject<TRecipientClass>(AJsonString)
end;

{TInvoiceClass}


function TInvoiceClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TInvoiceClass.FromJsonString(AJsonString: string): TInvoiceClass;
begin
  result := TJson.JsonToObject<TInvoiceClass>(AJsonString)
end;

{TSkusClass}


function TSkusClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TSkusClass.FromJsonString(AJsonString: string): TSkusClass;
begin
  result := TJson.JsonToObject<TSkusClass>(AJsonString)
end;

{TDimensionsClass}


function TDimensionsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TDimensionsClass.FromJsonString(AJsonString: string): TDimensionsClass;
begin
  result := TJson.JsonToObject<TDimensionsClass>(AJsonString)
end;

{TVolumesClass}

constructor TVolumesClass.Create;
begin
  inherited;
  FDimensions := TDimensionsClass.Create();
end;

destructor TVolumesClass.Destroy;
begin
  FDimensions.Free;
  inherited;
end;

function TVolumesClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TVolumesClass.FromJsonString(AJsonString: string): TVolumesClass;
begin
  result := TJson.JsonToObject<TVolumesClass>(AJsonString)
end;

{TItemsClass}

constructor TItemsClass.Create;
begin
  inherited;
  FInvoice := TInvoiceClass.Create();
  FRecipient := TRecipientClass.Create();
end;

destructor TItemsClass.Destroy;
  var
    LvolumesItem: TVolumesClass;
    LskusItem: TSkusClass;
    LvalueAddedServicesItem: TValueAddedServicesClass;
begin

 for LvolumesItem in FVolumes do
   LvolumesItem.Free;

 for LskusItem in FSkus do
   LskusItem.Free;

 for LvalueAddedServicesItem in FValueAddedServices do
   LvalueAddedServicesItem.Free;

  FInvoice.Free;
  FRecipient.Free;
  inherited;
end;

function TItemsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TItemsClass.FromJsonString(AJsonString: string): TItemsClass;
begin
  result := TJson.JsonToObject<TItemsClass>(AJsonString)
end;

{TRootClass}

destructor TRootClass.Destroy;
  var
    LitemsItem: TItemsClass;
begin

 for LitemsItem in FItems do
   LitemsItem.Free;

  inherited;
end;

function TRootClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRootClass.FromJsonString(AJsonString: string): TRootClass;
begin
  result := TJson.JsonToObject<TRootClass>(AJsonString)
end;

{ TMandaeJSONBuilder }

procedure TMandaeJSONBuilder.pCarregarDados;
  var
    LstrSQL : String;
begin
  If Pos(FstrEspecieDocumento, 'PD_OR_') > 0 Then
    LstrSQL := ' SELECT FATGOR.FGO_NUMDOC NUMERO_NOTA,         '+
               '        FATDOR.FDO_CODITE CODIGO_ITEM,         '+
               '        FATGOR.FGO_TOTPRO VALOR_NOTA,          '+
               '        FATGOR.FGO_TOTFRE TOTAL_FRETE,         '+
               '        FATDOR.FDO_UNITAR ITEM_PRECO_UNITARIO, '+
               '        FATDOR.FDO_QTDITE ITEM_QUANTIDADE,     '+
               '        CADFIS.FIS_ACESSO CHAVE_ACESSO,        '
  Else
    LstrSQL := ' SELECT MOVGER.GER_NUMDOC NUMERO_NOTA,         '+
               '        MOVDET.DET_CODITE CODIGO_ITEM,         '+
               '        MOVGER.GER_TOTPRO VALOR_NOTA,          '+
               '        MOVGER.GER_TOTFRE TOTAL_FRETE,         '+
               '        MOVDET.DET_UNITAR ITEM_PRECO_UNITARIO, '+
               '        MOVDET.DET_QTDITE ITEM_QUANTIDADE,     '+
               '        CADFIS.FIS_ACESSO CHAVE_ACESSO,        ';

  LstrSQL := LstrSQL + ' MANDOC.MAN_CODRAS CODIGO_RASTREIO,                                                       '+
                       '  CASE CADTRA.TRA_MANTEN WHEN ''R'' THEN ''Rápido'' ELSE ''Econômico'' END SERVICO_ENVIO, '+
                       '  CADITE.ITE_DESITE DESCRICAO_TEIM,                                                       '+
                       '  CADCLI.CLI_NOMCLI DESTINATARIO,                                                         '+
                       '  CADCLI.CLI_EMAIL3 EMAIL_DESTINATARIO,                                                   '+
                       '  CADCLI.CLI_C_G_C_ DOCUMENTO_DESTINATARIO,                                               '+
                       '  CADCLI.CLI_C_E_P_ CEP_DESTINATARIO,                                                     '+
                       '  CADCLI.CLI_ENDERE RUA_DESTINATARIO,                                                     '+
                       '  CADCLI.CLI_ENDNUM NUMERO_END_DESTINATARIO,                                              '+
                       '  CADCLI.CLI_BAIRRO BAIRRO_DESTINATARIO,                                                  '+
                       '  CADCLI.CLI_ENDCOM COMPLEMENTO_END_DESTINATARIO,                                         '+
                       '  CADCID.CID_NOMCID CIDADE_DESTINATARIO,                                                  '+
                       '  CADCID.CID_ESTADO ESTADO_DESTINATARIO,                                                  '+
                       '  ''BR'' PAIS_DESTINATARIO,                                                               '+
                       '  '''' REFERENCIA_DESTINATARIO                                                            ';

  If Pos(FstrEspecieDocumento, 'PD_OR_') > 0 Then
    LstrSQL := LstrSQL + ' FROM FATGOR                                                '+
                         ' JOIN FATDOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER       '+
                         ' JOIN MANDOC ON FATGOR.FGO_NUMDOC = MANDOC.MAN_NUMDOC       '+
                         '            AND FATGOR.FGO_ESPDOC = MANDOC.MAN_ESPDOC       '+
                         '            AND FATGOR.FGO_CODEMP = MANDOC.MAN_CODEMP       '+
                         ' JOIN CADTRA ON FATGOR.FGO_CODTRA = CADTRA.TRA_CODTRA       '+
                         ' JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE       '+
                         ' LEFT JOIN CADFIS ON FATGOR.FGO_NUMDOC = CADFIS.FIS_NUMDOC  '+
                         '                 AND FATGOR.FGO_ESPDOC = CADFIS.FIS_ESPDOC  '+
                         '                 AND FATGOR.FGO_CODEMP = CADFIS.FIS_CODEMP  '+
                         ' JOIN CADCLI ON FATGOR.FGO_CODCLI = CADCLI.CLI_CODCLI       '+
                         ' JOIN CADCID ON CADCLI.CLI_CODCID = CADCID.CID_CODCID       '+
                         'WHERE FATGOR.FGO_NUMDOC = :NUMDOC                           '+
                         '  AND FATGOR.FGO_ESPDOC = :ESPDOC                           '+
                         '  AND FATGOR.FGO_CODEMP = :CODEMP                           '+
                         '  AND MANDOC.MAN_CODRAS = :CODRAS                           '
  Else
    LstrSQL := LstrSQL + '  FROM MOVGER                                                '+
                         '  JOIN MOVDET ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER       '+
                         '  JOIN MANDOC ON MOVGER.GER_NUMDOC = MANDOC.MAN_NUMDOC       '+
                         '             AND MOVGER.GER_ESPDOC = MANDOC.MAN_ESPDOC       '+
                         '             AND MOVGER.GER_CODEMP = MANDOC.MAN_CODEMP       '+
                         '  JOIN CADTRA ON MOVGER.GER_CODTRA = CADTRA.TRA_CODTRA       '+
                         '  JOIN CADITE ON MOVDET.DET_CODITE = CADITE.ITE_CODITE       '+
                         '  LEFT JOIN CADFIS ON MOVGER.GER_NUMDOC = CADFIS.FIS_NUMDOC  '+
                         '                  AND MOVGER.GER_ESPDOC = CADFIS.FIS_ESPDOC  '+
                         '                  AND MOVGER.GER_CODEMP = CADFIS.FIS_CODEMP  '+
                         '  JOIN CADCLI ON MOVGER.GER_CODCLI = CADCLI.CLI_CODCLI       '+
                         '  JOIN CADCID ON CADCLI.CLI_CODCID = CADCID.CID_CODCID       '+
                         ' WHERE MOVGER.GER_NUMDOC = :NUMDOC                           '+
                         '   AND MOVGER.GER_ESPDOC = :ESPDOC                           '+
                         '   AND MOVGER.GER_CODEMP = :CODEMP                           '+
                         '   AND MANDOC.MAN_CODRAS = :CODRAS                           ';

  FQuery.Close;
  FQuery.Sql.Clear;
  FQuery.Sql.Add(LstrSQL);
  FQuery.ParamByName('NUMDOC').AsString := FstrDocumento;
  FQuery.ParamByName('ESPDOC').AsString := FstrEspecieDocumento;
  FQuery.ParamByName('CODEMP').AsString := FstrCodigoEmpresa;
  FQuery.ParamByName('CODRAS').AsString := FstrCodigoRastreio;
  FQuery.Open;
end;

procedure TMandaeJSONBuilder.pInstanciarObjetoDeIdentificacaoDaNota(var AObjItemsClass: TItemsClass);
begin
  AObjItemsClass.invoice.id  := FQuery.FieldByName('NUMERO_NOTA').AsString;  //Número da nota fiscal
  AObjItemsClass.invoice.key := FQuery.FieldByName('CHAVE_ACESSO').AsString; //Chave de acesso da nota fiscal
end;

//procedure TMandaeJSONBuilder.pInstanciarObjetoDeIdentificacaoDoItem(var AObjItemsClass: TItemsClass);
//  var
//    LObjSkusClass : TSkusClass;
//begin
//  FQuery.First;
//  While not FQuery.Eof do
//  Begin
//    LObjSkusClass             := TSkusClass.Create;
//    LObjSkusClass.description := FQuery.FieldByName('DESCRICAO_TEIM').AsString;     //Descrição do item
//    LObjSkusClass.price       := FQuery.FieldByName('ITEM_PRECO_UNITARIO').AsFloat; //Preço unitário
//    LObjSkusClass.quantity    := FQuery.FieldByName('ITEM_QUANTIDADE').AsFloat;     //Quantidade
//    SetLength(AObjItemsClass.Fskus, Length(AObjItemsClass.Fskus) + 1);
//    AObjItemsClass.Fskus[High(AObjItemsClass.Fskus)] := LObjSkusClass;
//
//    FQuery.next;
//  End;
//  FQuery.First;
//end;

//procedure TMandaeJSONBuilder.pInstanciarObjetoDeVolume(var AObjItemsClass: TItemsClass);
//  var
//    LObjVolumesClass : TVolumesClass;
//begin
//  LObjVolumesClass                   := TVolumesClass.Create;
//  LObjVolumesClass.declaredValue     := 1.00;  //Valor declarado do volume
//  LObjVolumesClass.dimensions.height := '0';    //Altura (cm)
//  LObjVolumesClass.dimensions.width  := '0';    //Largura (cm)
//  LObjVolumesClass.dimensions.length := '0';    //Comprimento (cm)
//  LObjVolumesClass.dimensions.weight := '0';    //Peso bruto (kg)
//  SetLength(AObjItemsClass.FVolumes, Length(AObjItemsClass.FVolumes) + 1);
//  AObjItemsClass.FVolumes[High(AObjItemsClass.FVolumes)] := LObjVolumesClass;
//
//  LObjVolumesClass                   := TVolumesClass.Create;
//  LObjVolumesClass.declaredValue     := 1.00;  //Valor declarado do volume
//  LObjVolumesClass.dimensions.height := '0';    //Altura (cm)
//  LObjVolumesClass.dimensions.width  := '0';    //Largura (cm)
//  LObjVolumesClass.dimensions.length := '0';    //Comprimento (cm)
//  LObjVolumesClass.dimensions.weight := '0';    //Peso bruto (kg)
//  SetLength(AObjItemsClass.FVolumes, Length(AObjItemsClass.FVolumes) + 1);
//  AObjItemsClass.FVolumes[High(AObjItemsClass.FVolumes)] := LObjVolumesClass;
//end;

procedure TMandaeJSONBuilder.pInstanciarObjetoDoDestinatario(var AObjItemsClass: TItemsClass);
begin
  AObjItemsClass.recipient.fullName := FQuery.FieldByName('DESTINATARIO').AsString;            //Nome completo Destinatario
  AObjItemsClass.recipient.email    := FQuery.FieldByName('EMAIL_DESTINATARIO').AsString;      //E-mail Destinatario
  AObjItemsClass.recipient.document := FQuery.FieldByName('DOCUMENTO_DESTINATARIO').AsString;  //CPF ou CNPJ  Destinario
end;

procedure TMandaeJSONBuilder.pInstanciarObjetoDoEnderecoDoDestinatario(var AobjRecipientClass : TRecipientClass);
begin
  AobjRecipientClass.address.postalCode    := FQuery.FieldByName('CEP_DESTINATARIO').AsString;              //CEP
  AobjRecipientClass.address.street        := FQuery.FieldByName('RUA_DESTINATARIO').AsString;              //Logradouro
  AobjRecipientClass.address.number        := FQuery.FieldByName('NUMERO_END_DESTINATARIO').AsString;       //Número
  AobjRecipientClass.address.neighborhood  := FQuery.FieldByName('BAIRRO_DESTINATARIO').AsString;           //Bairro
  AobjRecipientClass.address.addressLine2  := FQuery.FieldByName('COMPLEMENTO_END_DESTINATARIO').AsString;  //Complemento
  AobjRecipientClass.address.city          := FQuery.FieldByName('CIDADE_DESTINATARIO').AsString;           //Cidade
  AobjRecipientClass.address.state         := FQuery.FieldByName('ESTADO_DESTINATARIO').AsString;           //Estado
  AobjRecipientClass.address.country       := FQuery.FieldByName('PAIS_DESTINATARIO').AsString;             //Código de 2 caracteres do país
  AobjRecipientClass.address.reference     := FQuery.FieldByName('REFERENCIA_DESTINATARIO').AsString;       //Referência
end;

procedure TMandaeJSONBuilder.pInstanciarObjetoDosServicos(var AObjItemsClass : TItemsClass);
  var
    LObjValueAddedServicesClass : TValueAddedServicesClass;
begin
  LObjValueAddedServicesClass       := TValueAddedServicesClass.Create;
  LObjValueAddedServicesClass.name  := 'ValorDeclarado';                           //Nome do serviço de envio
  LObjValueAddedServicesClass.value := FQuery.FieldByName('VALOR_NOTA').AsFloat;   //Valor do serviço de envio
  SetLength(AObjItemsClass.FvalueAddedServices, Length(AObjItemsClass.FvalueAddedServices) + 1);
  AObjItemsClass.FvalueAddedServices[High(AObjItemsClass.FvalueAddedServices)] := LObjValueAddedServicesClass;
end;

procedure TMandaeJSONBuilder.pInstanciarObjetoItem(var AobjRootClass : TRootClass);
  var
    LObjItemsClass : TItemsClass;
begin
  LObjItemsClass                 := TItemsClass.Create;
  LObjItemsClass.trackingId      := FstrCodigoRastreio;                            //Código de rastreio gerado
  LObjItemsClass.partnerItemId   := FstrCodigoRastreio;                            //Seu identificador do item
  LObjItemsClass.shippingService := FQuery.FieldByName('SERVICO_ENVIO').AsString;  //Serviço de envio
  LObjItemsClass.totalValue      := FQuery.FieldByName('VALOR_NOTA').AsFloat;      //Valor total da Nota Fiscal
  LObjItemsClass.totalFreight    := FQuery.FieldByName('TOTAL_FRETE').AsFloat;     //Valor total do frete

  //pInstanciarObjetoDeVolume(LObjItemsClass);
  //pInstanciarObjetoDeIdentificacaoDoItem(LObjItemsClass);
  pInstanciarObjetoDeIdentificacaoDaNota(LObjItemsClass);
  pInstanciarObjetoDoDestinatario(LObjItemsClass);
  pInstanciarObjetoDoEnderecoDoDestinatario(LObjItemsClass.Frecipient);
  pInstanciarObjetoDosServicos(LObjItemsClass);

  SetLength(AobjRootClass.Fitems, Length(AobjRootClass.Fitems) + 1);
  AobjRootClass.Fitems[High(AobjRootClass.Fitems)] := LObjItemsClass;
end;

constructor TMandaeJSONBuilder.Create;
begin
  FQuery := fCriaQuery(nil);
end;

destructor TMandaeJSONBuilder.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TMandaeJSONBuilder.fGerarClientDaConsultaTracking(AstrJSONTracking: String): TUniClientDataSet;
  var
    LObjTrackingRootClass : TTrackingRootClass;
    LObjEventsClass       : TEventsClass;
begin
  Result := TUniClientDataSet.Create(nil);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TRC_DTATRC';
    DataType := ftString;
    Size     := 20;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'TRC_DESCRI';
    DataType := ftString;
    Size     := 100;
  End;

  Result.CreateDataSet;
  Result.Open;

  LObjTrackingRootClass := TTrackingRootClass.FromJsonString(AstrJSONTracking);

  for LObjEventsClass in LObjTrackingRootClass.events do
  begin
    Result.Append;
    Result.FieldByname('TRC_DTATRC').AsString := Copy(LObjEventsClass.Date,9,2)+'/'+
                                                 Copy(LObjEventsClass.Date,6,2)+'/'+
                                                 Copy(LObjEventsClass.Date,1,4)+' '+
                                                 Copy(LObjEventsClass.Date,12,5);
    Result.FieldByname('TRC_DESCRI').AsString := LObjEventsClass.name;
    Result.Post;
  end;

  Result.FieldByName('TRC_DTATRC').Alignment := taCenter;
  Result.FieldByName('TRC_DESCRI').Alignment := taCenter;
end;

function TMandaeJSONBuilder.fGerarJSONParaEnvioEncomendas : String;
  var
    LObjRootClass : TRootClass;
begin
  pCarregarDados;

  if FQuery.IsEmpty then
    Exit('');

  LObjRootClass            := TRootClass.Create;
  LObjRootClass.customerId := fCfgSis('MANCID', varString);

  pInstanciarObjetoItem(LObjRootClass);

  Result := LObjRootClass.ToJsonString;

  Result := AnsiReplaceStr(Result, 'R\u00E1pido','Rápido');
  Result := AnsiReplaceStr(Result, 'Econ\u00F4mico','Econômico');
end;

{TEventsClass}


function TEventsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEventsClass.FromJsonString(AJsonString: string): TEventsClass;
begin
  result := TJson.JsonToObject<TEventsClass>(AJsonString)
end;

{TTrackingRootClass}

destructor TTrackingRootClass.Destroy;
var
  LeventsItem: TEventsClass;
begin

 for LeventsItem in FEvents do
   LeventsItem.Free;

  inherited;
end;

function TTrackingRootClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TTrackingRootClass.FromJsonString(AJsonString: string): TTrackingRootClass;
begin
  result := TJson.JsonToObject<TTrackingRootClass>(AJsonString)
end;

end.
