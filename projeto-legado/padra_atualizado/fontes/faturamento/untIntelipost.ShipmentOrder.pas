unit untIntelipost.ShipmentOrder;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils, untIntelipost.Retorno.ShipmentOrder,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;
  {$ENDIF LINUX}

type
  TExternal_order_numbersClass = class
  private
    FErp: String;
    FMarketplace: String;
    FPlataforma: String;
    FSales: String;
  public
    property erp: String read FErp write FErp;
    property marketplace: String read FMarketplace write FMarketplace;
    property plataforma: String read FPlataforma write FPlataforma;
    property sales: String read FSales write FSales;
  end;

  TAdditional_informationClass = class
  private
    FKey: String;
    FKey2: String;
  public
    property key: String read FKey write FKey;
    property key2: String read FKey2 write FKey2;
  end;

  TContent_declarationClass = class
  private
    FContent_declaration_date: TDate;
    FContent_declaration_number: String;
    FContent_declaration_total_value: String;
  public
    property content_declaration_date: TDate read FContent_declaration_date write FContent_declaration_date;
    property content_declaration_number: String read FContent_declaration_number write FContent_declaration_number;
    property content_declaration_total_value: String read FContent_declaration_total_value write FContent_declaration_total_value;
  end;

  TShipment_order_volume_invoiceClass = class
  private
    FInvoice_cfop: String;
    FInvoice_date: String;
    FInvoice_key: String;
    FInvoice_number: String;
    FInvoice_products_value: Extended;
    FInvoice_series: String;
    FInvoice_total_value: Extended;
  public
    property invoice_cfop: String read FInvoice_cfop write FInvoice_cfop;
    property invoice_date: String read FInvoice_date write FInvoice_date;
    property invoice_key: String read FInvoice_key write FInvoice_key;
    property invoice_number: String read FInvoice_number write FInvoice_number;
    property invoice_products_value: Extended read FInvoice_products_value write FInvoice_products_value;
    property invoice_series: String read FInvoice_series write FInvoice_series;
    property invoice_total_value: Extended read FInvoice_total_value write FInvoice_total_value;
  end;

  TProductsClass = class
  private
    FCategory: String;
    FDescription: String;
    FHeight: Extended;
    FImage_url: String;
    FLength: Extended;
    FPrice: Extended;
    FQuantity: Extended;
    FSku: String;
    FWeight: Extended;
    FWidth: Extended;
  public
    property category: String read FCategory write FCategory;
    property description: String read FDescription write FDescription;
    property height: Extended read FHeight write FHeight;
    property image_url: String read FImage_url write FImage_url;
    property length: Extended read FLength write FLength;
    property price: Extended read FPrice write FPrice;
    property quantity: Extended read FQuantity write FQuantity;
    property sku: String read FSku write FSku;
    property weight: Extended read FWeight write FWeight;
    property width: Extended read FWidth write FWidth;
  end;

  TShipment_order_volume_arrayClass = class
  private
    FClient_pre_shipment_list: String;
    FContent_declaration: TContent_declarationClass;
    FHeight: Extended;
    FLength: Extended;
    FName: String;
    FProducts: TArray<TProductsClass>;
    FProducts_nature: String;
    FProducts_quantity: Extended;
    FShipment_order_volume_invoice: TShipment_order_volume_invoiceClass;
    FShipment_order_volume_number: Extended;
    FTracking_code: String;
    FVolume_type_code: String;
    FWeight: Extended;
    FWidth: Extended;

    function fNewProduct: TProductsClass;
    procedure pAddProduct(Product: TProductsClass);
  public
    property client_pre_shipment_list: String read FClient_pre_shipment_list write FClient_pre_shipment_list;
    property content_declaration: TContent_declarationClass read FContent_declaration write FContent_declaration;
    property height: Extended read FHeight write FHeight;
    property length: Extended read FLength write FLength;
    property name: String read FName write FName;
    property products: TArray<TProductsClass> read FProducts write FProducts;
    property products_nature: String read FProducts_nature write FProducts_nature;
    property products_quantity: Extended read FProducts_quantity write FProducts_quantity;
    property shipment_order_volume_invoice: TShipment_order_volume_invoiceClass read FShipment_order_volume_invoice write FShipment_order_volume_invoice;
    property shipment_order_volume_number: Extended read FShipment_order_volume_number write FShipment_order_volume_number;
    property tracking_code: String read FTracking_code write FTracking_code;
    property volume_type_code: String read FVolume_type_code write FVolume_type_code;
    property weight: Extended read FWeight write FWeight;
    property width: Extended read FWidth write FWidth;
    constructor Create;
    destructor Destroy; override;
  end;

  TNotifyClass_001 = class
  private
    FWhatsapp: Boolean;
  public
    property whatsapp: Boolean read FWhatsapp write FWhatsapp;
  end;

  TEnd_customerClass = class
  private
    FCellphone: String;
    FEmail: String;
    FFederal_tax_payer_id: String;
    FFirst_name: String;
    FIs_company: Boolean;
    FLast_name: String;
    FNotify: TNotifyClass_001;
    FOpt_in: Boolean;
    FPhone: String;
    FShipping_additional: String;
    FShipping_address: String;
    FShipping_city: String;
    FShipping_country: String;
    FShipping_number: String;
    FShipping_quarter: String;
    FShipping_reference: String;
    FShipping_state: String;
    FShipping_zip_code: String;
  public
    property cellphone: String read FCellphone write FCellphone;
    property email: String read FEmail write FEmail;
    property federal_tax_payer_id: String read FFederal_tax_payer_id write FFederal_tax_payer_id;
    property first_name: String read FFirst_name write FFirst_name;
    property is_company: Boolean read FIs_company write FIs_company;
    property last_name: String read FLast_name write FLast_name;
    property notify: TNotifyClass_001 read FNotify write FNotify;
    property opt_in: Boolean read FOpt_in write FOpt_in;
    property phone: String read FPhone write FPhone;
    property shipping_additional: String read FShipping_additional write FShipping_additional;
    property shipping_address: String read FShipping_address write FShipping_address;
    property shipping_city: String read FShipping_city write FShipping_city;
    property shipping_country: String read FShipping_country write FShipping_country;
    property shipping_number: String read FShipping_number write FShipping_number;
    property shipping_quarter: String read FShipping_quarter write FShipping_quarter;
    property shipping_reference: String read FShipping_reference write FShipping_reference;
    property shipping_state: String read FShipping_state write FShipping_state;
    property shipping_zip_code: String read FShipping_zip_code write FShipping_zip_code;
    constructor Create;
    destructor Destroy; override;
  end;

  TNotifyClass = class
  private
    FWhatsapp: Boolean;
  public
    property whatsapp: Boolean read FWhatsapp write FWhatsapp;
  end;

  TSellerClass = class
  private
    FAdditional: String;
    FAddress: String;
    FCellphone: String;
    FCity: String;
    FCountry: String;
    FEmail: String;
    FFederal_tax_payer_id: String;
    FFirst_name: String;
    FIs_company: Boolean;
    FLast_name: String;
    FNotify: TNotifyClass;
    FNumber: String;
    FOpt_in: Boolean;
    FPhone: String;
    FQuarter: String;
    FReference: String;
    FState: String;
    FState_tax_payer_id: String;
    FZip_code: String;
  public
    property additional: String read FAdditional write FAdditional;
    property address: String read FAddress write FAddress;
    property cellphone: String read FCellphone write FCellphone;
    property city: String read FCity write FCity;
    property country: String read FCountry write FCountry;
    property email: String read FEmail write FEmail;
    property federal_tax_payer_id: String read FFederal_tax_payer_id write FFederal_tax_payer_id;
    property first_name: String read FFirst_name write FFirst_name;
    property is_company: Boolean read FIs_company write FIs_company;
    property last_name: String read FLast_name write FLast_name;
    property notify: TNotifyClass read FNotify write FNotify;
    property number: String read FNumber write FNumber;
    property opt_in: Boolean read FOpt_in write FOpt_in;
    property phone: String read FPhone write FPhone;
    property quarter: String read FQuarter write FQuarter;
    property reference: String read FReference write FReference;
    property state: String read FState write FState;
    property state_tax_payer_id: String read FState_tax_payer_id write FState_tax_payer_id;
    property zip_code: String read FZip_code write FZip_code;
    constructor Create;
    destructor Destroy; override;

    function ToJsonString: string;
  end;

  TVehicleClass = class
  private
    FLicence_plate: String;
  public
    property licence_plate: String read FLicence_plate write FLicence_plate;
  end;

  TDriverClass = class
  private
    FFederal_tax_id: String;
  public
    property federal_tax_id: String read FFederal_tax_id write FFederal_tax_id;
  end;

  TCarrierClass = class
  private
    FDriver: TDriverClass;
    FVehicle: TVehicleClass;
  public
    property driver: TDriverClass read FDriver write FDriver;
    property vehicle: TVehicleClass read FVehicle write FVehicle;
    constructor Create;
    destructor Destroy; override;
  end;

  TIntelipostShipmentOrder = class
  private
    FAdditional_information: TAdditional_informationClass;
    FCarrier: TCarrierClass;
    FCreated: String;
    FCustomer_shipping_costs: Extended;
    FDelivery_method_external_id: String;
    FDelivery_method_id: Extended;
    FEnd_customer: TEnd_customerClass;
    FEstimated_delivery_date: String;
    FExternal_order_numbers: TExternal_order_numbersClass;
    FOrder_number: String;
    FOrigin_warehouse_code: String;
    FOrigin_zip_code: String;
    FParent_shipment_order_number: String;
    FProvider_shipping_costs: Extended;
    FQuote_id: String;
    FSales_channel: String;
    FSales_order_number: String;
    FScheduled: Boolean;
    FSeller: TSellerClass;
    FShipment_order_type: String;
    FShipment_order_volume_array: TArray<TShipment_order_volume_arrayClass>;
    FShipped_date: String;

    function fEnviar: TIntelipostRetornoShipmentOrder;
    function fTratarJsonPadroesIntelipost(const AstrJson: String): String;
    function fNewShipment_order_volume_array: TShipment_order_volume_arrayClass;
    procedure pAddShipment_order_volume_array(Shipment_order_volume_arrayClass: TShipment_order_volume_arrayClass);

    class function fDocumentoFiscalAutorizado(const blnDocAutorizado: Boolean; var intTentativas: Integer; const blnExibeMensagem: Boolean): Boolean;
    {$IFNDEF LINUX}
    class function fAguardarEnvioDoPedidoParaIntelipost(const strAutoIncrem: String; const blnExibeMensagem: Boolean; var intTentativas: Integer; var blnEnviado: Boolean): Boolean;
    class function fPedidoEnviadoParaIntelipost(const strAutoIncrem: String): Boolean;
    {$ENDIF LINUX}
    class function fRetornaPrevisaoEntregaDiasUteis(const intQtdDiasEntrega: Integer; const dtaPedido: TDateTime): TDateTime;
    class procedure pMarcaPedidoEnviado(const strAutIncItp: String);
    class function fPedidoLiberadoNaLCKATC(const strAutoIncrem: String; const blnExibeMensagem: Boolean; var intTentativas: Integer; var blnEnviado: Boolean; var strMsgRetorno: String): Boolean;
  public
    property additional_information: TAdditional_informationClass read FAdditional_information write FAdditional_information;
    property carrier: TCarrierClass read FCarrier write FCarrier;
    property created: String read FCreated write FCreated;
    property customer_shipping_costs: Extended read FCustomer_shipping_costs write FCustomer_shipping_costs;
    property delivery_method_external_id: String read FDelivery_method_external_id write FDelivery_method_external_id;
    property delivery_method_id: Extended read FDelivery_method_id write FDelivery_method_id;
    property end_customer: TEnd_customerClass read FEnd_customer write FEnd_customer;
    property estimated_delivery_date: String read FEstimated_delivery_date write FEstimated_delivery_date;
    property external_order_numbers: TExternal_order_numbersClass read FExternal_order_numbers write FExternal_order_numbers;
    property order_number: String read FOrder_number write FOrder_number;
    property origin_warehouse_code: String read FOrigin_warehouse_code write FOrigin_warehouse_code;
    property origin_zip_code: String read FOrigin_zip_code write FOrigin_zip_code;
    property parent_shipment_order_number: String read FParent_shipment_order_number write FParent_shipment_order_number;
    property provider_shipping_costs: Extended read FProvider_shipping_costs write FProvider_shipping_costs;
    property quote_id: String read FQuote_id write FQuote_id;
    property sales_channel: String read FSales_channel write FSales_channel;
    property sales_order_number: String read FSales_order_number write FSales_order_number;
    property scheduled: Boolean read FScheduled write FScheduled;
    property seller: TSellerClass read FSeller write FSeller;
    property shipment_order_type: String read FShipment_order_type write FShipment_order_type;
    property shipment_order_volume_array: TArray<TShipment_order_volume_arrayClass> read FShipment_order_volume_array write FShipment_order_volume_array;
    property shipped_date: String read FShipped_date write FShipped_date;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;

    class function fPedidoTemProcessamentoIntelipost(const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
    class function fEnviarPedidoIntelipost(const strAutoIncrem: String; var strMsgRetorno: String; const blnExibeMensagem: Boolean): Boolean; //autoincrem da fatgor
  end;

implementation

{TShipment_order_volume_arrayClass}

uses untIntelipostRestApi, untRestApi;

constructor TShipment_order_volume_arrayClass.Create;
begin
  inherited;
  FShipment_order_volume_invoice := TShipment_order_volume_invoiceClass.Create();
  FContent_declaration := TContent_declarationClass.Create();
end;

destructor TShipment_order_volume_arrayClass.Destroy;
var
  LproductsItem: TProductsClass;
begin

 for LproductsItem in FProducts do
   LproductsItem.free;

  FShipment_order_volume_invoice.free;
  FContent_declaration.free;
  inherited;
end;

function TShipment_order_volume_arrayClass.fNewProduct: TProductsClass;
begin
  Result := TProductsClass.Create;
  pAddProduct(Result);
end;

procedure TShipment_order_volume_arrayClass.pAddProduct(
  Product: TProductsClass);
begin
  SetLength(FProducts, System.Length(FProducts)+1);
  FProducts[System.Length(FProducts)-1] := Product;
end;

{TEnd_customerClass}

constructor TEnd_customerClass.Create;
begin
  inherited;
  FNotify := TNotifyClass_001.Create();
end;

destructor TEnd_customerClass.Destroy;
begin
  FNotify.free;
  inherited;
end;

{TSellerClass}

constructor TSellerClass.Create;
begin
  inherited;
  FNotify := TNotifyClass.Create();
end;

destructor TSellerClass.Destroy;
begin
  FNotify.free;
  inherited;
end;

function TSellerClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{TCarrierClass}

constructor TCarrierClass.Create;
begin
  inherited;
  FDriver := TDriverClass.Create();
  FVehicle := TVehicleClass.Create();
end;

destructor TCarrierClass.Destroy;
begin
  FDriver.free;
  FVehicle.free;
  inherited;
end;

{ TIntelipostShipmentOrder }

constructor TIntelipostShipmentOrder.Create;
begin
  inherited;
  //FCarrier := TCarrierClass.Create();
  FSeller := TSellerClass.Create();
  FEnd_customer := TEnd_customerClass.Create();
  FAdditional_information := TAdditional_informationClass.Create();
  FExternal_order_numbers := TExternal_order_numbersClass.Create();
end;

destructor TIntelipostShipmentOrder.Destroy;
var
  Lshipment_order_volume_arrayItem: TShipment_order_volume_arrayClass;
begin

 for Lshipment_order_volume_arrayItem in FShipment_order_volume_array do
   Lshipment_order_volume_arrayItem.free;

  //FCarrier.free;
  FSeller.free;
  FEnd_customer.free;
  FAdditional_information.free;
  FExternal_order_numbers.free;
  inherited;
end;

function TIntelipostShipmentOrder.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TIntelipostShipmentOrder.fPedidoLiberadoNaLCKATC(
  const strAutoIncrem: String; const blnExibeMensagem: Boolean;
  var intTentativas: Integer; var blnEnviado: Boolean; var strMsgRetorno: String): Boolean;
begin
  Result := fLock_Unlock('INTPOS_'+strAutoIncrem, True, False);
  if not Result then
  begin
    if fGetTentativasLock('INTPOS_'+strAutoIncrem) > 10 then
    begin
      pDestravaLockForcado('INTPOS_'+strAutoIncrem, 0);
      Exit(True);
    end;

    {$IFNDEF LINUX}
    while True do
    begin
      Inc(intTentativas);
      if not fAguardarEnvioDoPedidoParaIntelipost(strAutoIncrem, blnExibeMensagem, intTentativas, blnEnviado) then
      begin
        if not blnEnviado then
          strMsgRetorno := 'Você poderá emitir a etiqueta pela tela "Despacho de Mercadorias"!';

        Break;
      end;
    end;
    {$ENDIF LINUX}
  end;
end;

{$IFNDEF LINUX}
class function TIntelipostShipmentOrder.fPedidoEnviadoParaIntelipost(
  const strAutoIncrem: String): Boolean;
begin
  Result := (fCampoTabela('ITP_PEDENV', 'INTPOS', ['ITP_SEQFGO'], [strAutoIncrem]) = 'S');
end;
{$ENDIF LINUX}

class function TIntelipostShipmentOrder.fPedidoTemProcessamentoIntelipost(const strNumDoc,
  strEspDoc, strCodEmp: String): Boolean;
var
  qtyIntPos: {$IFNDEF LINUX} TUniQuery {$ELSE} IQuery {$ENDIF LINUX};
begin
  qtyIntPos := fCriaQuery;
  try
    qtyIntPos.Close;
    qtyIntPos.SQL.Text :=
    ' SELECT '+
    '   FATGOR.AUTOINCREM '+
    ' FROM '+
    '   FATGOR '+
    ' INNER JOIN INTPOS ON '+
    '   FATGOR.AUTOINCREM = INTPOS.ITP_SEQFGO '+
    ' WHERE '+
    '   FATGOR.FGO_NUMDOC = :NUMDOC AND '+
    '   FATGOR.FGO_ESPDOC = :ESPDOC AND '+
    '   FATGOR.FGO_CODEMP = :CODEMP ';

    qtyIntPos.ParamByName('NUMDOC').AsString := strNumDoc;
    qtyIntPos.ParamByName('ESPDOC').AsString := strEspDoc;
    qtyIntPos.ParamByName('CODEMP').AsString := strCodEmp;
    qtyIntPos.Open;

    Result := not qtyIntPos.IsEmpty;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qtyIntPos);
    {$ENDIF LINUX}
  end;
end;

class function TIntelipostShipmentOrder.fRetornaPrevisaoEntregaDiasUteis(
  const intQtdDiasEntrega: Integer; const dtaPedido: TDateTime): TDateTime;
var
  intCount: Integer;
  dtaPrevisao: TDateTime;
begin
  dtaPrevisao := dtaPedido;
  for intCount:=1 to intQtdDiasEntrega do
  begin
    dtaPrevisao := IncDay(dtaPrevisao);
    while DayOfWeek(dtaPrevisao) in [1,7] do
      dtaPrevisao := IncDay(dtaPrevisao);
  end;

  Result := dtaPrevisao;
end;

function TIntelipostShipmentOrder.fNewShipment_order_volume_array: TShipment_order_volume_arrayClass;
begin
  Result := TShipment_order_volume_arrayClass.Create;
  pAddShipment_order_volume_array(Result);
end;

procedure TIntelipostShipmentOrder.pAddShipment_order_volume_array(
  Shipment_order_volume_arrayClass: TShipment_order_volume_arrayClass);
begin
  SetLength(FShipment_order_volume_array, Length(FShipment_order_volume_array)+1);
  FShipment_order_volume_array[Length(FShipment_order_volume_array)-1] := Shipment_order_volume_arrayClass;
end;

class procedure TIntelipostShipmentOrder.pMarcaPedidoEnviado(
  const strAutIncItp: String);
var
  qryIntPos: {$IFNDEF LINUX} TUniQuery {$ELSE} IQuery {$ENDIF LINUX};
begin
  qryIntPos := fCriaQuery;
  try
    qryIntPos.Close;
    qryIntPos.SQL.Text :=
    ' UPDATE '+
    '   INTPOS '+
    ' SET '+
    '   ITP_PEDENV = "S" '+
    ' WHERE '+
    '   AUTOINCREM = :ITP_AUTINC ';

    qryIntPos.ParamByName('ITP_AUTINC').AsString := strAutIncItp;
    qryIntPos.ExecSQL;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryIntPos);
    {$ENDIF LINUX}
  end;
end;

class function TIntelipostShipmentOrder.fEnviarPedidoIntelipost(
  const strAutoIncrem: String; var strMsgRetorno: String; const blnExibeMensagem: Boolean): Boolean;
const
  SQL_INTELIPOST =
    ' SELECT '+
    '   CADEMP.EMP_C_E_P_, '+
    '   FATGOR.FGO_NUMPOK, '+
    '   FATGOR.FGO_DTAENT, '+
    '   FATGOR.FGO_HORENT, '+
    '   FATDOR.FDO_SEQGER, '+
    '   FATDOR.FDO_NUMDOC, '+
    '   FATDOR.FDO_ESPDOC, '+
    '   FATDOR.FDO_CODEMP, '+
    '   FATDOR.FDO_DESCRI, '+
    '   FATDOR.FDO_UNITAR, '+
    '   FATDOR.FDO_QTDITE, '+
    '   FATDOR.FDO_CODITE, '+
    '   INTPOS.AUTOINCREM AS ITP_AUTINC, '+
    '   INTPOS.ITP_METHID, '+
    '   INTPOS.ITP_QUOTID, '+
    '   INTPOS.ITP_DIAENT, '+
    '   INTPOS.ITP_PEDENV, '+
    '   MOVGER.GER_NUMDOC, '+
    '   MOVGER.GER_ESPDOC, '+
    '   MOVGER.GER_CODEMP, '+
    '   MOVGER.GER_DTAENT, '+
    '   MOVGER.GER_HORENT, '+
    '   MOVGER.GER_TOTFRE, '+
    '   IF(COALESCE(MOVGER.GER_VOLUME, 0) < 1, 1, MOVGER.GER_VOLUME) AS GER_VOLUME, '+
    '   MOVGER.GER_PESBRU, '+
    '   MOVGER.GER_SERIE_, '+
    '   MOVGER.GER_VLRCON, '+
    '   MOVGER.GER_TOTPRO, '+
    '   MOVGER.GER_CLAFIS, '+
    '   MOVGER.GER_CODVEN, '+
    '   CADFIS.FIS_ACESSO, '+
    '   CADOPE.OPE_NOMOPE, '+
    '   CADOPE.OPE_E_MAIL, '+
    '   CADOPE.OPE_FONE01, '+
    '   CADOPE.OPE_NUMWPP, '+
    '   CADOPE.OPE_NUMCPF, '+
    '   CADCLI.CLI_NOMCLI, '+
    '   CADCLI.CLI_EMAIL_, '+
    '   CADCLI.CLI_FONE01, '+
    '   CADCLI.CLI_CELULA, '+
    '   CADCLI.CLI_CGCCPF, '+
    '   CADCLI.CLI_C_G_C_, '+
    '   IBG_CADPAI.IBG_NOMPAI, '+
    '   CADCID.CID_ESTADO, '+
    '   CADCID.CID_NOMCID, '+
    '   ENTCLI.ETC_ENDENT, '+
    '   ENTCLI.ETC_BAIENT, '+
    '   ENTCLI.ETC_CEPENT, '+
    '   ENTCLI.ETC_REFENT, '+
    '   CADITE.ITE_PESOIT, '+
    '   DESSIT.ITE_EXPALT, '+
    '   DESSIT.ITE_EXPPRO, '+
    '   DESSIT.ITE_EXPLAR  '+
    ' FROM '+
    '   FATDOR '+
    ' INNER JOIN FATGOR ON '+
    '   FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '+
    ' INNER JOIN CADEMP ON '+
    '   FATGOR.FGO_EMPFAT = CADEMP.EMP_CODEMP '+
    ' INNER JOIN INTPOS ON '+
    '   FATDOR.FDO_SEQGER = INTPOS.ITP_SEQFGO '+
    ' INNER JOIN MOVGER ON '+
    '   FATDOR.FDO_NUMFAT = MOVGER.GER_NUMDOC AND '+
    '   FATDOR.FDO_TIPFAT = MOVGER.GER_ESPDOC AND '+
    '   FATDOR.FDO_EMPFAT = MOVGER.GER_CODEMP     '+
    ' INNER JOIN CADFIS ON '+
    '   CADFIS.FIS_NUMDOC = MOVGER.GER_NUMDOC AND '+
    '   CADFIS.FIS_ESPDOC = MOVGER.GER_ESPDOC AND '+
    '   CADFIS.FIS_CODEMP = MOVGER.GER_CODEMP AND '+
    '   CADFIS.FIS_SERIE_ = MOVGER.GER_SERIE_ AND '+
    '   CADFIS.FIS_TIP_FC = MOVGER.GER_TIP_FC AND '+
    '   CADFIS.FIS_FORCLI = MOVGER.GER_CODCLI '+
    ' INNER JOIN AUXMOV ON '+
    '   MOVGER.AUTOINCREM = AUXMOV.AUX_SEQGER '+
    ' INNER JOIN CADCLI ON '+
    '   MOVGER.GER_CODCLI = CADCLI.CLI_CODCLI '+
    ' INNER JOIN ENTCLI ON '+
    '   AUXMOV.AUX_ENTGER = ENTCLI.AUTOINCREM '+
    ' INNER JOIN CADCID ON '+
    '   ENTCLI.ETC_CIDENT = CADCID.CID_CODCID '+
    ' INNER JOIN IBG_CADPAI ON '+
    '   CADCID.CID_CODPAI = IBG_CADPAI.IBG_CODPAI '+
    ' INNER JOIN CADOPE ON '+
    '   MOVGER.GER_CODVEN = CADOPE.OPE_CODOPE '+
    ' INNER JOIN CADITE ON '+
    '   FATDOR.FDO_CODITE = CADITE.ITE_CODITE '+
    ' INNER JOIN DESSIT ON '+
    '   FATDOR.FDO_CODITE = DESSIT.ITE_CODITE '+
    ' WHERE '+
    '   FATDOR.FDO_SEQGER = :AUTINC '+
    ' GROUP BY FATDOR.AUTOINCREM ';
var
  IntelipostShipmentOrder: TIntelipostShipmentOrder;
  IntelipostRetornoShipmentOrder: TIntelipostRetornoShipmentOrder;
  Shipment_order_volume: TShipment_order_volume_arrayClass;
  Product: TProductsClass;

  qryPedido: {$IFNDEF LINUX} TUniQuery {$ELSE} IQuery {$ENDIF LINUX};
  intCount: Integer;

  intTentativas: Integer;
  blnEnviado: Boolean;
  blnDestravaLock: Boolean;

  intQtdItens: Integer;
  intQtdVolumes: Integer;
  intQtdPrimeiroVolume: Integer;
  intQtdDemaisVolumes: Integer;
  intQtdAdd: Integer;
  intCountProduto: Integer;

  arrNomCli: TArray<String>;
begin
  Result := False;
  IntelipostRetornoShipmentOrder := nil;
  blnDestravaLock := True;
  intTentativas := 0;
  intQtdItens := 0;
  intQtdAdd := 0;

  IntelipostShipmentOrder := TIntelipostShipmentOrder.Create;
  qryPedido := fCriaQuery;
  try
    if not fPedidoLiberadoNaLCKATC(strAutoIncrem, blnExibeMensagem, intTentativas, blnEnviado, strMsgRetorno) then
    begin
      blnDestravaLock := False;
      Exit(blnEnviado);
    end;

    intTentativas := 0;

    try
      repeat
        qryPedido.Close;
        qryPedido.SQL.Text := SQL_INTELIPOST;
        qryPedido.ParamByName('AUTINC').AsString := strAutoIncrem;
        qryPedido.Open;

        if qryPedido.IsEmpty then
          Exit;

        Inc(intTentativas);

      until fDocumentoFiscalAutorizado(not fEmptyStr(qryPedido.FieldByName('FIS_ACESSO').AsString), intTentativas, blnExibeMensagem);

      if qryPedido.FieldByName('ITP_PEDENV').AsString = 'S' then
        Exit(True);

      if fEmptyStr(qryPedido.FieldByName('FIS_ACESSO').AsString) then
      begin
        strMsgRetorno := 'O documento ainda não foi autorizado pela sefaz.'+sLineBreak+
                           'Apenas após a autorização será possível emitir a etiqueta!';
        Exit;
      end;

      IntelipostShipmentOrder.sales_channel := qryPedido.FieldByName('GER_CODVEN').AsString + '-' + qryPedido.FieldByName('OPE_NOMOPE').AsString;
      IntelipostShipmentOrder.origin_zip_code := qryPedido.FieldByName('EMP_C_E_P_').AsString;
      IntelipostShipmentOrder.order_number := fRetiraZerosEsquerda(qryPedido.FieldByName('FDO_NUMDOC').AsString)+qryPedido.FieldByName('FDO_ESPDOC').AsString+qryPedido.FieldByName('FDO_CODEMP').AsString;
      IntelipostShipmentOrder.sales_order_number := fRetiraZerosEsquerda(qryPedido.FieldByName('GER_NUMDOC').AsString);
      
      if fCfgSis('ITPEFC', varBoolean) then
        IntelipostShipmentOrder.provider_shipping_costs := qryPedido.FieldByName('GER_TOTFRE').AsFloat
      else
        IntelipostShipmentOrder.customer_shipping_costs := qryPedido.FieldByName('GER_TOTFRE').AsFloat;

      IntelipostShipmentOrder.delivery_method_id := qryPedido.FieldByName('ITP_METHID').AsFloat;
      IntelipostShipmentOrder.quote_id := qryPedido.FieldByName('ITP_QUOTID').AsString;
      IntelipostShipmentOrder.created := FormatDateTime('yyyy-MM-dd', qryPedido.FieldByName('GER_DTAENT').AsDateTime)+'T'+qryPedido.FieldByName('GER_HORENT').AsString+'-03:00';

      if fCfgSis('ITPPLP', varBoolean) then
        IntelipostShipmentOrder.shipped_date := FormatDateTime('yyyy-MM-dd', Date)+'T'+TimeToStr(Time)+'-03:00';

      if fEmptyStr(qryPedido.FieldByName('FGO_NUMPOK').AsString) then
        IntelipostShipmentOrder.estimated_delivery_date := FormatDateTime('yyyy-MM-dd', fRetornaPrevisaoEntregaDiasUteis(qryPedido.FieldByName('ITP_DIAENT').AsInteger, qryPedido.FieldByName('FGO_DTAENT').AsDateTime)
                                                                          )+'T'+qryPedido.FieldByName('FGO_HORENT').AsString+'-03:00'
      else
        IntelipostShipmentOrder.estimated_delivery_date := FormatDateTime('yyyy-MM-dd', IncDay(qryPedido.FieldByName('FGO_DTAENT').AsDateTime, qryPedido.FieldByName('ITP_DIAENT').AsInteger))+'T'+qryPedido.FieldByName('FGO_HORENT').AsString+'-03:00';

      IntelipostShipmentOrder.scheduled := False;

      if fCfgSis('ITPSEL', varBoolean) then
      begin
        IntelipostShipmentOrder.seller.first_name := qryPedido.FieldByName('OPE_NOMOPE').AsString;
        IntelipostShipmentOrder.seller.email := qryPedido.FieldByName('OPE_E_MAIL').AsString.Replace(';', '');;
        IntelipostShipmentOrder.seller.phone := qryPedido.FieldByName('OPE_FONE01').AsString;
        IntelipostShipmentOrder.seller.cellphone := qryPedido.FieldByName('OPE_NUMWPP').AsString;
        IntelipostShipmentOrder.seller.is_company := False;
        IntelipostShipmentOrder.seller.federal_tax_payer_id := qryPedido.FieldByName('OPE_NUMCPF').AsString;
      end
      else
        IntelipostShipmentOrder.origin_warehouse_code := '01';

      arrNomCli := qryPedido.FieldByName('CLI_NOMCLI').AsString.Split([' ']);
      IntelipostShipmentOrder.end_customer.first_name := arrNomCli[0];

      for intCount := 1 to High(arrNomCli) do
        IntelipostShipmentOrder.end_customer.last_name := arrNomCli[intCount]+' ';

      IntelipostShipmentOrder.end_customer.email := qryPedido.FieldByName('CLI_EMAIL_').AsString.Replace(';', '');
      IntelipostShipmentOrder.end_customer.phone := qryPedido.FieldByName('CLI_FONE01').AsString;
      IntelipostShipmentOrder.end_customer.cellphone := qryPedido.FieldByName('CLI_CELULA').AsString;
      IntelipostShipmentOrder.end_customer.is_company := (qryPedido.FieldByName('CLI_CGCCPF').AsInteger = 1);
      IntelipostShipmentOrder.end_customer.federal_tax_payer_id := qryPedido.FieldByName('CLI_C_G_C_').AsString;

      IntelipostShipmentOrder.end_customer.shipping_country := qryPedido.FieldByName('IBG_NOMPAI').AsString;
      IntelipostShipmentOrder.end_customer.shipping_state := qryPedido.FieldByName('CID_ESTADO').AsString;
      IntelipostShipmentOrder.end_customer.shipping_city := qryPedido.FieldByName('CID_NOMCID').AsString;
      IntelipostShipmentOrder.end_customer.shipping_number := IntToStr(fRetNumeroEndereco(qryPedido.FieldByName('ETC_ENDENT').AsString));
      IntelipostShipmentOrder.end_customer.shipping_address := fTiraCaracEspeciais(fRemoveAcento(qryPedido.FieldByName('ETC_ENDENT').AsString)).Replace(IntelipostShipmentOrder.end_customer.shipping_number, '');
      IntelipostShipmentOrder.end_customer.shipping_quarter := qryPedido.FieldByName('ETC_BAIENT').AsString;
      IntelipostShipmentOrder.end_customer.shipping_zip_code := qryPedido.FieldByName('ETC_CEPENT').AsString;
      IntelipostShipmentOrder.end_customer.shipping_reference := qryPedido.FieldByName('ETC_REFENT').AsString;

      IntelipostShipmentOrder.external_order_numbers.erp := qryPedido.FieldByName('FDO_SEQGER').AsString;

      qryPedido.First;
      while not qryPedido.Eof do
      begin
        intQtdItens := intQtdItens + qryPedido.FieldByName('FDO_QTDITE').AsInteger;
        qryPedido.Next;
      end;

      intQtdVolumes := qryPedido.FieldByName('GER_VOLUME').AsInteger;
      intQtdPrimeiroVolume := Ceil(intQtdItens / intQtdVolumes);

      intQtdDemaisVolumes := 0;
      if intQtdVolumes > 1 then
      begin
        intQtdDemaisVolumes := ((intQtdItens - intQtdPrimeiroVolume) div (intQtdVolumes-1));
        if intQtdDemaisVolumes <= 0 then
        begin
          intQtdPrimeiroVolume := intQtdItens;
          intQtdVolumes := 1;
        end;
      end;

      qryPedido.First;
      for intCount:=1 to intQtdVolumes do
      begin
        Shipment_order_volume := IntelipostShipmentOrder.fNewShipment_order_volume_array;
        Shipment_order_volume.name := 'Volume-'+IntToStr(intCount);
        Shipment_order_volume.shipment_order_volume_number := intCount;
        Shipment_order_volume.products_quantity := IIF(intCount=1, intQtdPrimeiroVolume, intQtdDemaisVolumes);
        Shipment_order_volume.volume_type_code := 'BOX';
        Shipment_order_volume.weight := (qryPedido.FieldByName('GER_PESBRU').AsFloat / intQtdVolumes);
        Shipment_order_volume.shipment_order_volume_invoice.invoice_key := qryPedido.FieldByName('FIS_ACESSO').AsString;
        Shipment_order_volume.shipment_order_volume_invoice.invoice_series := qryPedido.FieldByName('GER_SERIE_').AsString;
        Shipment_order_volume.shipment_order_volume_invoice.invoice_number := fRetiraZerosEsquerda(qryPedido.FieldByName('GER_NUMDOC').AsString);
        Shipment_order_volume.shipment_order_volume_invoice.invoice_date := FormatDateTime('yyyy-MM-dd', qryPedido.FieldByName('GER_DTAENT').AsDateTime)+'T'+qryPedido.FieldByName('GER_HORENT').AsString+'-03:00';
        Shipment_order_volume.shipment_order_volume_invoice.invoice_cfop := qryPedido.FieldByName('GER_CLAFIS').AsString;
        Shipment_order_volume.shipment_order_volume_invoice.invoice_total_value := qryPedido.FieldByName('GER_VLRCON').AsFloat;
        Shipment_order_volume.shipment_order_volume_invoice.invoice_products_value := qryPedido.FieldByName('GER_TOTPRO').AsFloat;
        Shipment_order_volume.products_nature := 'products';

        for intCountProduto:=1 to IIF(intCount=1, intQtdPrimeiroVolume, intQtdDemaisVolumes) do
        begin
          Product := Shipment_order_volume.fNewProduct;
          Product.description := qryPedido.FieldByName('FDO_DESCRI').AsString;
          Product.price := qryPedido.FieldByName('FDO_UNITAR').AsFloat;
          Product.quantity := 1;
          Product.sku := qryPedido.FieldByName('FDO_CODITE').AsString;
          Product.weight := qryPedido.FieldByName('ITE_PESOIT').AsFloat;
          Product.width := qryPedido.FieldByName('ITE_EXPLAR').AsFloat;
          Product.height := qryPedido.FieldByName('ITE_EXPALT').AsFloat;
          Product.length := qryPedido.FieldByName('ITE_EXPPRO').AsFloat;

          Shipment_order_volume.height := Shipment_order_volume.height + qryPedido.FieldByName('ITE_EXPALT').AsFloat;
          Shipment_order_volume.length := Shipment_order_volume.length + qryPedido.FieldByName('ITE_EXPPRO').AsFloat;
          Shipment_order_volume.width := Shipment_order_volume.width + qryPedido.FieldByName('ITE_EXPLAR').AsFloat;

          Inc(intQtdAdd);
          if intQtdAdd = qryPedido.FieldByName('FDO_QTDITE').AsInteger then
          begin
            intQtdAdd := 0;
            qryPedido.Next;
          end;
        end;
      end;

      IntelipostRetornoShipmentOrder := IntelipostShipmentOrder.fEnviar;
      Result := ((Assigned(IntelipostRetornoShipmentOrder)) and (IntelipostRetornoShipmentOrder.status = 'OK'));
      if Result then
        pMarcaPedidoEnviado(qryPedido.FieldByName('ITP_AUTINC').AsString)
      else
        strMsgRetorno := 'Não foi possível comunicar com a Intelipost! Por favor, tente novamente.'+sLineBreak+
                         'Retorno: ' + IntelipostRetornoShipmentOrder.messages[0].text;
    except
      Result := False;
    end;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(qryPedido);
    {$ENDIF LINUX}

    FreeAndNil(IntelipostShipmentOrder);

    if Assigned(IntelipostRetornoShipmentOrder) then
      FreeAndNil(IntelipostRetornoShipmentOrder);

    if blnDestravaLock then
      fLock_Unlock('INTPOS_'+strAutoIncrem, False, False);
  end;
end;

class function TIntelipostShipmentOrder.fDocumentoFiscalAutorizado(
  const blnDocAutorizado: Boolean; var intTentativas: Integer; const blnExibeMensagem: Boolean): Boolean;
begin
  Result := False;

  if blnDocAutorizado then
    Exit(True);

  if intTentativas = 5 then
  begin
    {$IFNDEF LINUX}
    if (blnExibeMensagem) and (fPergunta('O documento fiscal ainda não foi autorizado pela sefaz, deseja aguardar mais um pouco?')) then
    begin
      intTentativas := 0;
      Result := False;
    end
    else
    {$ENDIF LINUX}
      Result := True;
  end;

  Sleep(2000);
end;

{$IFNDEF LINUX}
class function TIntelipostShipmentOrder.fAguardarEnvioDoPedidoParaIntelipost(const strAutoIncrem: String; const blnExibeMensagem: Boolean; var intTentativas: Integer; var blnEnviado: Boolean): Boolean;
begin
  blnEnviado := fPedidoEnviadoParaIntelipost(strAutoIncrem);

  Result := not blnEnviado;

  if (Result) and (intTentativas = 5) then
  begin
    if (blnExibeMensagem) and (fPergunta('O pedido está sendo enviado para a intelipost em segundo plano. Deseja aguardar mais um pouco?')) then
      intTentativas := 0
    else
      Result := False;
  end;

  if Result then
    Sleep(2000);
end;
{$ENDIF LINUX}

function TIntelipostShipmentOrder.fEnviar: TIntelipostRetornoShipmentOrder;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('INTELIPOST', TControllerConfigurarIntelipost.fConfigurarIntelipost);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'shipment_order';
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('api-key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_ITPKEY', VS_strCodEmp], True, EmptyStr), pkHTTPHEADER);

    RESTRequest
    .Params
    .AddItem(  '',
               fTratarJsonPadroesIntelipost(ToJsonString),
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200', '400'], EmptyStr) then
      Result := TIntelipostRetornoShipmentOrder.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;


function TIntelipostShipmentOrder.fTratarJsonPadroesIntelipost(const AstrJson: String): String;
begin
  Result := AstrJson;
  if not fCfgSis('ITPSEL', varBoolean) then
    Result := fRemoverAtributoDoJson(Result, 'seller');

  if not fCfgSis('ITPPLP', varBoolean) then
    Result := fRemoverAtributoDoJson(Result, 'shipped_date');
end;

end.
