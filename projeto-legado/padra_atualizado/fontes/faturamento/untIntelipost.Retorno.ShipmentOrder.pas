unit untIntelipost.Retorno.ShipmentOrder;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;
  {$ENDIF LINUX}

type
  TDelivery_addressClass = class
  private
    FAdditional: String;
    FCity: String;
    FCountry: String;
    FLatitude: String;
    FLongitude: String;
    FName: String;
    FNumber: String;
    FQuarter: String;
    FReference: String;
    FState_code: String;
    FStreet: String;
    FZip_code: String;
  public
    property additional: String read FAdditional write FAdditional;
    property city: String read FCity write FCity;
    property country: String read FCountry write FCountry;
    property latitude: String read FLatitude write FLatitude;
    property longitude: String read FLongitude write FLongitude;
    property name: String read FName write FName;
    property number: String read FNumber write FNumber;
    property quarter: String read FQuarter write FQuarter;
    property reference: String read FReference write FReference;
    property state_code: String read FState_code write FState_code;
    property street: String read FStreet write FStreet;
    property zip_code: String read FZip_code write FZip_code;
  end;

  TAdditional_informationClass = class
  private
    FKey: String;
    FKey2: String;
  public
    property key: String read FKey write FKey;
    property key2: String read FKey2 write FKey2;
  end;

  TShipment_order_volume_state_history_arrayClass = class
  private
    FCreated: Extended;
    FCreated_iso: String;
    FEvent_date: Extended;
    FEvent_date_iso: String;
    FShipment_order_volume_id: Extended;
    FShipment_order_volume_state: String;
    FShipment_order_volume_state_history: Extended;
    FShipment_order_volume_state_localized: String;
  public
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property event_date: Extended read FEvent_date write FEvent_date;
    property event_date_iso: String read FEvent_date_iso write FEvent_date_iso;
    property shipment_order_volume_id: Extended read FShipment_order_volume_id write FShipment_order_volume_id;
    property shipment_order_volume_state: String read FShipment_order_volume_state write FShipment_order_volume_state;
    property shipment_order_volume_state_history: Extended read FShipment_order_volume_state_history write FShipment_order_volume_state_history;
    property shipment_order_volume_state_localized: String read FShipment_order_volume_state_localized write FShipment_order_volume_state_localized;
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

  TShipment_order_volume_invoiceClass = class
  private
    FInvoice_cfop: String;
    FInvoice_date: Extended;
    FInvoice_date_iso: String;
    FInvoice_key: String;
    FInvoice_number: String;
    FInvoice_products_value: Extended;
    FInvoice_series: String;
    FInvoice_total_value: Extended;
    FShipment_order_volume_id: Extended;
    FShipment_order_volume_number: String;
  public
    property invoice_cfop: String read FInvoice_cfop write FInvoice_cfop;
    property invoice_date: Extended read FInvoice_date write FInvoice_date;
    property invoice_date_iso: String read FInvoice_date_iso write FInvoice_date_iso;
    property invoice_key: String read FInvoice_key write FInvoice_key;
    property invoice_number: String read FInvoice_number write FInvoice_number;
    property invoice_products_value: Extended read FInvoice_products_value write FInvoice_products_value;
    property invoice_series: String read FInvoice_series write FInvoice_series;
    property invoice_total_value: Extended read FInvoice_total_value write FInvoice_total_value;
    property shipment_order_volume_id: Extended read FShipment_order_volume_id write FShipment_order_volume_id;
    property shipment_order_volume_number: String read FShipment_order_volume_number write FShipment_order_volume_number;
  end;

  TShipment_order_volume_arrayClass = class
  private
    FCreated: Extended;
    FCreated_iso: String;
    FDelivered: Boolean;
    FDelivered_late: Boolean;
    FDelivered_late_lp: Boolean;
    FEstimated_delivery_date: Extended;
    FEstimated_delivery_date_iso: String;
    FEstimated_delivery_date_lp: Extended;
    FEstimated_delivery_date_lp_iso: String;
    FHas_clarify_delivery_fail: Boolean;
    FHeight: Extended;
    FIs_icms_exempt: Boolean;
    FLength: Extended;
    FLogistic_provider_tracking_code: String;
    FModified: Extended;
    FModified_iso: String;
    FName: String;
    FOriginal_estimated_delivery_date: Extended;
    FOriginal_estimated_delivery_date_iso: String;
    FOriginal_estimated_delivery_date_lp: Extended;
    FOriginal_estimated_delivery_date_lp_iso: String;
    FPre_shipment_list_state: String;
    FProducts: TArray<TProductsClass>;
    FProducts_nature: String;
    FProducts_quantity: Extended;
    FShipment_order_id: Extended;
    FShipment_order_volume_id: Extended;
    FShipment_order_volume_invoice: TShipment_order_volume_invoiceClass;
    FShipment_order_volume_number: String;
    FShipment_order_volume_state: String;
    FShipment_order_volume_state_history_array: TArray<TShipment_order_volume_state_history_arrayClass>;
    FShipment_order_volume_state_localized: String;
    FShipped_date: Extended;
    FShipped_date_iso: String;
    FTracking_code: String;
    FVolume_type_code: String;
    FWeight: Extended;
    FWidth: Extended;
  public
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property delivered: Boolean read FDelivered write FDelivered;
    property delivered_late: Boolean read FDelivered_late write FDelivered_late;
    property delivered_late_lp: Boolean read FDelivered_late_lp write FDelivered_late_lp;
    property estimated_delivery_date: Extended read FEstimated_delivery_date write FEstimated_delivery_date;
    property estimated_delivery_date_iso: String read FEstimated_delivery_date_iso write FEstimated_delivery_date_iso;
    property estimated_delivery_date_lp: Extended read FEstimated_delivery_date_lp write FEstimated_delivery_date_lp;
    property estimated_delivery_date_lp_iso: String read FEstimated_delivery_date_lp_iso write FEstimated_delivery_date_lp_iso;
    property has_clarify_delivery_fail: Boolean read FHas_clarify_delivery_fail write FHas_clarify_delivery_fail;
    property height: Extended read FHeight write FHeight;
    property is_icms_exempt: Boolean read FIs_icms_exempt write FIs_icms_exempt;
    property length: Extended read FLength write FLength;
    property logistic_provider_tracking_code: String read FLogistic_provider_tracking_code write FLogistic_provider_tracking_code;
    property modified: Extended read FModified write FModified;
    property modified_iso: String read FModified_iso write FModified_iso;
    property name: String read FName write FName;
    property original_estimated_delivery_date: Extended read FOriginal_estimated_delivery_date write FOriginal_estimated_delivery_date;
    property original_estimated_delivery_date_iso: String read FOriginal_estimated_delivery_date_iso write FOriginal_estimated_delivery_date_iso;
    property original_estimated_delivery_date_lp: Extended read FOriginal_estimated_delivery_date_lp write FOriginal_estimated_delivery_date_lp;
    property original_estimated_delivery_date_lp_iso: String read FOriginal_estimated_delivery_date_lp_iso write FOriginal_estimated_delivery_date_lp_iso;
    property pre_shipment_list_state: String read FPre_shipment_list_state write FPre_shipment_list_state;
    property products: TArray<TProductsClass> read FProducts write FProducts;
    property products_nature: String read FProducts_nature write FProducts_nature;
    property products_quantity: Extended read FProducts_quantity write FProducts_quantity;
    property shipment_order_id: Extended read FShipment_order_id write FShipment_order_id;
    property shipment_order_volume_id: Extended read FShipment_order_volume_id write FShipment_order_volume_id;
    property shipment_order_volume_invoice: TShipment_order_volume_invoiceClass read FShipment_order_volume_invoice write FShipment_order_volume_invoice;
    property shipment_order_volume_number: String read FShipment_order_volume_number write FShipment_order_volume_number;
    property shipment_order_volume_state: String read FShipment_order_volume_state write FShipment_order_volume_state;
    property shipment_order_volume_state_history_array: TArray<TShipment_order_volume_state_history_arrayClass> read FShipment_order_volume_state_history_array write FShipment_order_volume_state_history_array;
    property shipment_order_volume_state_localized: String read FShipment_order_volume_state_localized write FShipment_order_volume_state_localized;
    property shipped_date: Extended read FShipped_date write FShipped_date;
    property shipped_date_iso: String read FShipped_date_iso write FShipped_date_iso;
    property tracking_code: String read FTracking_code write FTracking_code;
    property volume_type_code: String read FVolume_type_code write FVolume_type_code;
    property weight: Extended read FWeight write FWeight;
    property width: Extended read FWidth write FWidth;
    constructor Create;
    destructor Destroy; override;
  end;

  TEnd_customerClass = class
  private
    FCellphone: String;
    FEmail: String;
    FFederal_tax_payer_id: String;
    FFirst_name: String;
    FIs_company: Boolean;
    FLast_name: String;
    FPhone: String;
    FShipping_additional: String;
    FShipping_address: String;
    FShipping_city: String;
    FShipping_country: String;
    FShipping_number: String;
    FShipping_quarter: String;
    FShipping_reference: String;
    FShipping_state: String;
    FShipping_state_code: String;
    FShipping_zip_code: String;
    FState_tax_payer_id: String;
  public
    property cellphone: String read FCellphone write FCellphone;
    property email: String read FEmail write FEmail;
    property federal_tax_payer_id: String read FFederal_tax_payer_id write FFederal_tax_payer_id;
    property first_name: String read FFirst_name write FFirst_name;
    property is_company: Boolean read FIs_company write FIs_company;
    property last_name: String read FLast_name write FLast_name;
    property phone: String read FPhone write FPhone;
    property shipping_additional: String read FShipping_additional write FShipping_additional;
    property shipping_address: String read FShipping_address write FShipping_address;
    property shipping_city: String read FShipping_city write FShipping_city;
    property shipping_country: String read FShipping_country write FShipping_country;
    property shipping_number: String read FShipping_number write FShipping_number;
    property shipping_quarter: String read FShipping_quarter write FShipping_quarter;
    property shipping_reference: String read FShipping_reference write FShipping_reference;
    property shipping_state: String read FShipping_state write FShipping_state;
    property shipping_state_code: String read FShipping_state_code write FShipping_state_code;
    property shipping_zip_code: String read FShipping_zip_code write FShipping_zip_code;
    property state_tax_payer_id: String read FState_tax_payer_id write FState_tax_payer_id;
  end;

  TVehicleClass = class
  private
    FCategory: String;
    FColor: String;
    FLicence_plate: String;
    FManufacturer: String;
    FModel: String;
  public
    property category: String read FCategory write FCategory;
    property color: String read FColor write FColor;
    property licence_plate: String read FLicence_plate write FLicence_plate;
    property manufacturer: String read FManufacturer write FManufacturer;
    property model: String read FModel write FModel;
  end;

  TDriverClass = class
  private
    FCell_phone: String;
    FEmail: String;
    FFederal_tax_id: String;
    FFirst_name: String;
    FLast_name: String;
    FLicense: Extended;
  public
    property cell_phone: String read FCell_phone write FCell_phone;
    property email: String read FEmail write FEmail;
    property federal_tax_id: String read FFederal_tax_id write FFederal_tax_id;
    property first_name: String read FFirst_name write FFirst_name;
    property last_name: String read FLast_name write FLast_name;
    property license: Extended read FLicense write FLicense;
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

  TContentClass = class
  private
    FAdditional_information: TAdditional_informationClass;
    FCarrier: TCarrierClass;
    FClient_id: Extended;
    FCreated: Extended;
    FCreated_iso: String;
    FCustomer_shipping_costs: Extended;
    FDelivery_address: TDelivery_addressClass;
    FDelivery_method_id: Extended;
    FEnd_customer: TEnd_customerClass;
    FEstimated_delivery_date: Extended;
    FEstimated_delivery_date_iso: String;
    FEstimated_delivery_date_lp: Extended;
    FEstimated_delivery_date_lp_iso: String;
    FId: Extended;
    FModified: Extended;
    FModified_iso: String;
    FOrder_number: String;
    FOrigin_additional: String;
    FOrigin_city: String;
    FOrigin_customer_email: String;
    FOrigin_customer_phone: String;
    FOrigin_federal_tax_payer_id: String;
    FOrigin_name: String;
    FOrigin_number: String;
    FOrigin_quarter: String;
    FOrigin_reference: String;
    FOrigin_state_code: String;
    FOrigin_street: String;
    FOrigin_warehouse_code: String;
    FOrigin_zip_code: String;
    FSales_channel: String;
    FSales_order_number: String;
    FScheduled: Boolean;
    FShipment_order_type: String;
    FShipment_order_volume_array: TArray<TShipment_order_volume_arrayClass>;
    FShipment_order_volume_state: String;
    FShipped_date: Extended;
    FShipped_date_iso: String;
  public
    property additional_information: TAdditional_informationClass read FAdditional_information write FAdditional_information;
    property carrier: TCarrierClass read FCarrier write FCarrier;
    property client_id: Extended read FClient_id write FClient_id;
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property customer_shipping_costs: Extended read FCustomer_shipping_costs write FCustomer_shipping_costs;
    property delivery_address: TDelivery_addressClass read FDelivery_address write FDelivery_address;
    property delivery_method_id: Extended read FDelivery_method_id write FDelivery_method_id;
    property end_customer: TEnd_customerClass read FEnd_customer write FEnd_customer;
    property estimated_delivery_date: Extended read FEstimated_delivery_date write FEstimated_delivery_date;
    property estimated_delivery_date_iso: String read FEstimated_delivery_date_iso write FEstimated_delivery_date_iso;
    property estimated_delivery_date_lp: Extended read FEstimated_delivery_date_lp write FEstimated_delivery_date_lp;
    property estimated_delivery_date_lp_iso: String read FEstimated_delivery_date_lp_iso write FEstimated_delivery_date_lp_iso;
    property id: Extended read FId write FId;
    property modified: Extended read FModified write FModified;
    property modified_iso: String read FModified_iso write FModified_iso;
    property order_number: String read FOrder_number write FOrder_number;
    property origin_additional: String read FOrigin_additional write FOrigin_additional;
    property origin_city: String read FOrigin_city write FOrigin_city;
    property origin_customer_email: String read FOrigin_customer_email write FOrigin_customer_email;
    property origin_customer_phone: String read FOrigin_customer_phone write FOrigin_customer_phone;
    property origin_federal_tax_payer_id: String read FOrigin_federal_tax_payer_id write FOrigin_federal_tax_payer_id;
    property origin_name: String read FOrigin_name write FOrigin_name;
    property origin_number: String read FOrigin_number write FOrigin_number;
    property origin_quarter: String read FOrigin_quarter write FOrigin_quarter;
    property origin_reference: String read FOrigin_reference write FOrigin_reference;
    property origin_state_code: String read FOrigin_state_code write FOrigin_state_code;
    property origin_street: String read FOrigin_street write FOrigin_street;
    property origin_warehouse_code: String read FOrigin_warehouse_code write FOrigin_warehouse_code;
    property origin_zip_code: String read FOrigin_zip_code write FOrigin_zip_code;
    property sales_channel: String read FSales_channel write FSales_channel;
    property sales_order_number: String read FSales_order_number write FSales_order_number;
    property scheduled: Boolean read FScheduled write FScheduled;
    property shipment_order_type: String read FShipment_order_type write FShipment_order_type;
    property shipment_order_volume_array: TArray<TShipment_order_volume_arrayClass> read FShipment_order_volume_array write FShipment_order_volume_array;
    property shipment_order_volume_state: String read FShipment_order_volume_state write FShipment_order_volume_state;
    property shipped_date: Extended read FShipped_date write FShipped_date;
    property shipped_date_iso: String read FShipped_date_iso write FShipped_date_iso;
    constructor Create;
    destructor Destroy; override;
  end;

  TMessagesClass = class
  private
    FKey: String;
    FText: String;
    FType: String;
  public
    property key: String read FKey write FKey;
    property text: String read FText write FText;
    property &type: String read FType write FType;
  end;

  TIntelipostRetornoShipmentOrder = class
  private
    FContent: TContentClass;
    FLocale: String;
    FMessages: TArray<TMessagesClass>;
    FStatus: String;
    FTime: String;
    FTimezone: String;
  public
    property content: TContentClass read FContent write FContent;
    property locale: String read FLocale write FLocale;
    property messages: TArray<TMessagesClass> read FMessages write FMessages;
    property status: String read FStatus write FStatus;
    property time: String read FTime write FTime;
    property timezone: String read FTimezone write FTimezone;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TIntelipostRetornoShipmentOrder;
  end;

implementation

{TShipment_order_volume_arrayClass}

constructor TShipment_order_volume_arrayClass.Create;
begin
  inherited;
  FShipment_order_volume_invoice := TShipment_order_volume_invoiceClass.Create();
end;

destructor TShipment_order_volume_arrayClass.Destroy;
var
  LproductsItem: TProductsClass;
  Lshipment_order_volume_state_history_arrayItem: TShipment_order_volume_state_history_arrayClass;
begin

 for LproductsItem in FProducts do
   LproductsItem.free;
 for Lshipment_order_volume_state_history_arrayItem in FShipment_order_volume_state_history_array do
   Lshipment_order_volume_state_history_arrayItem.free;

  FShipment_order_volume_invoice.free;
  inherited;
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

{TContentClass}

constructor TContentClass.Create;
begin
  inherited;
  FCarrier := TCarrierClass.Create();
  FEnd_customer := TEnd_customerClass.Create();
  FAdditional_information := TAdditional_informationClass.Create();
  FDelivery_address := TDelivery_addressClass.Create();
end;

destructor TContentClass.Destroy;
var
  Lshipment_order_volume_arrayItem: TShipment_order_volume_arrayClass;
begin

 for Lshipment_order_volume_arrayItem in FShipment_order_volume_array do
   Lshipment_order_volume_arrayItem.free;

  FCarrier.free;
  FEnd_customer.free;
  FAdditional_information.free;
  FDelivery_address.free;
  inherited;
end;

{TIntelipostRetornoShipmentOrder}

constructor TIntelipostRetornoShipmentOrder.Create;
begin
  inherited;
  FContent := TContentClass.Create();
end;

destructor TIntelipostRetornoShipmentOrder.Destroy;
var
  LmessagesItem: TMessagesClass;
begin

 for LmessagesItem in FMessages do
   LmessagesItem.free;

  FContent.free;
  inherited;
end;

class function TIntelipostRetornoShipmentOrder.FromJsonString(AJsonString: string): TIntelipostRetornoShipmentOrder;
begin
  result := TJson.JsonToObject<TIntelipostRetornoShipmentOrder>(AJsonString)
end;

end.
