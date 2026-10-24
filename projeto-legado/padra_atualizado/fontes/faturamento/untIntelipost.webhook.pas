unit untIntelipost.webhook;

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

  TLogistic_providerClass = class
  private
    FCurrent: Extended;
    FCurrent_iso: String;
    FOriginal: Extended;
    FOriginal_iso: String;
  public
    property current: Extended read FCurrent write FCurrent;
    property current_iso: String read FCurrent_iso write FCurrent_iso;
    property original: Extended read FOriginal write FOriginal;
    property original_iso: String read FOriginal_iso write FOriginal_iso;
  end;

  TClientClass = class
  private
    FCurrent: Extended;
    FCurrent_iso: String;
    FOriginal: Extended;
    FOriginal_iso: String;
  public
    property current: Extended read FCurrent write FCurrent;
    property current_iso: String read FCurrent_iso write FCurrent_iso;
    property original: Extended read FOriginal write FOriginal;
    property original_iso: String read FOriginal_iso write FOriginal_iso;
  end;

  TEstimated_delivery_dateClass = class
  private
    FClient: TClientClass;
    FLogistic_provider: TLogistic_providerClass;
  public
    property client: TClientClass read FClient write FClient;
    property logistic_provider: TLogistic_providerClass read FLogistic_provider write FLogistic_provider;
    constructor Create;
    destructor Destroy; override;
  end;

  TInvoiceClass = class
  private
    FInvoice_key: String;
    FInvoice_number: String;
    FInvoice_series: String;
  public
    property invoice_key: String read FInvoice_key write FInvoice_key;
    property invoice_number: String read FInvoice_number write FInvoice_number;
    property invoice_series: String read FInvoice_series write FInvoice_series;
  end;

  TAdditional_informationClass = class
  private
    FKey1: String;
    FKey2: String;
  public
    property key1: String read FKey1 write FKey1;
    property key2: String read FKey2 write FKey2;
  end;

  TAttachmentsClass = class
  private
    FAdditional_information: TAdditional_informationClass;
    FCreated: Extended;
    FCreated_iso: String;
    FFile_name: String;
    FMime_type: String;
    FModified: Extended;
    FModified_iso: String;
    FProcessing_status: String;
    FType: String;
  public
    property additional_information: TAdditional_informationClass read FAdditional_information write FAdditional_information;
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property file_name: String read FFile_name write FFile_name;
    property mime_type: String read FMime_type write FMime_type;
    property modified: Extended read FModified write FModified;
    property modified_iso: String read FModified_iso write FModified_iso;
    property processing_status: String read FProcessing_status write FProcessing_status;
    property &type: String read FType write FType;
    constructor Create;
    destructor Destroy; override;
  end;

  TLocationClass = class
  private
    FAdditional: String;
    FAddress: String;
    FCity: String;
    FDescription: String;
    FLatitude: String;
    FLongitude: String;
    FNumber: String;
    FQuarter: String;
    FReference: String;
    FState_code: String;
    FZip_code: String;
  public
    property additional: String read FAdditional write FAdditional;
    property address: String read FAddress write FAddress;
    property city: String read FCity write FCity;
    property description: String read FDescription write FDescription;
    property latitude: String read FLatitude write FLatitude;
    property longitude: String read FLongitude write FLongitude;
    property number: String read FNumber write FNumber;
    property quarter: String read FQuarter write FQuarter;
    property reference: String read FReference write FReference;
    property state_code: String read FState_code write FState_code;
    property zip_code: String read FZip_code write FZip_code;
  end;

  TShipment_volume_micro_stateClass = class
  private
    FCode: String;
    FDefault_name: String;
    FDescription: String;
    FI18n_name: String;
    FId: Extended;
    FName: String;
    FShipment_order_volume_state_id: Extended;
    FShipment_volume_state: String;
    FShipment_volume_state_localized: String;
    FShipment_volume_state_source_id: Extended;
  public
    property code: String read FCode write FCode;
    property default_name: String read FDefault_name write FDefault_name;
    property description: String read FDescription write FDescription;
    property i18n_name: String read FI18n_name write FI18n_name;
    property id: Extended read FId write FId;
    property name: String read FName write FName;
    property shipment_order_volume_state_id: Extended read FShipment_order_volume_state_id write FShipment_order_volume_state_id;
    property shipment_volume_state: String read FShipment_volume_state write FShipment_volume_state;
    property shipment_volume_state_localized: String read FShipment_volume_state_localized write FShipment_volume_state_localized;
    property shipment_volume_state_source_id: Extended read FShipment_volume_state_source_id write FShipment_volume_state_source_id;
  end;

  THistoryClass = class
  private
    FAttachments: TArray<TAttachmentsClass>;
    FCreated: Extended;
    FCreated_iso: String;
    FEsprinter_message: String;
    FEvent_date: Extended;
    FEvent_date_iso: String;
    FLocation: TLocationClass;
    FProvider_message: String;
    FProvider_state: String;
    FRequest_hash: String;
    FRequest_origin: String;
    FShipment_order_volume_id: Extended;
    FShipment_order_volume_state: String;
    FShipment_order_volume_state_history: Extended;
    FShipment_order_volume_state_localized: String;
    FShipment_volume_micro_state: TShipment_volume_micro_stateClass;
    FShipper_provider_state: String;
  public
    property attachments: TArray<TAttachmentsClass> read FAttachments write FAttachments;
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property esprinter_message: String read FEsprinter_message write FEsprinter_message;
    property event_date: Extended read FEvent_date write FEvent_date;
    property event_date_iso: String read FEvent_date_iso write FEvent_date_iso;
    property location: TLocationClass read FLocation write FLocation;
    property provider_message: String read FProvider_message write FProvider_message;
    property provider_state: String read FProvider_state write FProvider_state;
    property request_hash: String read FRequest_hash write FRequest_hash;
    property request_origin: String read FRequest_origin write FRequest_origin;
    property shipment_order_volume_id: Extended read FShipment_order_volume_id write FShipment_order_volume_id;
    property shipment_order_volume_state: String read FShipment_order_volume_state write FShipment_order_volume_state;
    property shipment_order_volume_state_history: Extended read FShipment_order_volume_state_history write FShipment_order_volume_state_history;
    property shipment_order_volume_state_localized: String read FShipment_order_volume_state_localized write FShipment_order_volume_state_localized;
    property shipment_volume_micro_state: TShipment_volume_micro_stateClass read FShipment_volume_micro_state write FShipment_volume_micro_state;
    property shipper_provider_state: String read FShipper_provider_state write FShipper_provider_state;
    constructor Create;
    destructor Destroy; override;
  end;

  TIntelipostWebhook = class
  private
    FEstimated_delivery_date: TEstimated_delivery_dateClass;
    FHistory: THistoryClass;
    FInvoice: TInvoiceClass;
    FOrder_number: String;
    FSales_order_number: String;
    FTracking_code: String;
    FTracking_url: String;
    FVolume_number: String;
  public
    property estimated_delivery_date: TEstimated_delivery_dateClass read FEstimated_delivery_date write FEstimated_delivery_date;
    property history: THistoryClass read FHistory write FHistory;
    property invoice: TInvoiceClass read FInvoice write FInvoice;
    property order_number: String read FOrder_number write FOrder_number;
    property sales_order_number: String read FSales_order_number write FSales_order_number;
    property tracking_code: String read FTracking_code write FTracking_code;
    property tracking_url: String read FTracking_url write FTracking_url;
    property volume_number: String read FVolume_number write FVolume_number;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TIntelipostWebhook;
  end;

implementation

{TEstimated_delivery_dateClass}

constructor TEstimated_delivery_dateClass.Create;
begin
  inherited;
  FClient := TClientClass.Create();
  FLogistic_provider := TLogistic_providerClass.Create();
end;

destructor TEstimated_delivery_dateClass.Destroy;
begin
  FClient.free;
  FLogistic_provider.free;
  inherited;
end;

{TAttachmentsClass}

constructor TAttachmentsClass.Create;
begin
  inherited;
  FAdditional_information := TAdditional_informationClass.Create();
end;

destructor TAttachmentsClass.Destroy;
begin
  FAdditional_information.free;
  inherited;
end;

{THistoryClass}

constructor THistoryClass.Create;
begin
  inherited;
  FShipment_volume_micro_state := TShipment_volume_micro_stateClass.Create();
  FLocation := TLocationClass.Create();
end;

destructor THistoryClass.Destroy;
var
  LattachmentsItem: TAttachmentsClass;
begin

 for LattachmentsItem in FAttachments do
   LattachmentsItem.free;

  FShipment_volume_micro_state.free;
  FLocation.free;
  inherited;
end;

{TIntelipostWebhook}

constructor TIntelipostWebhook.Create;
begin
  inherited;
  FHistory := THistoryClass.Create();
  FInvoice := TInvoiceClass.Create();
  FEstimated_delivery_date := TEstimated_delivery_dateClass.Create();
end;

destructor TIntelipostWebhook.Destroy;
begin
  FHistory.free;
  FInvoice.free;
  FEstimated_delivery_date.free;
  inherited;
end;

class function TIntelipostWebhook.FromJsonString(AJsonString: string): TIntelipostWebhook;
begin
  result := TJson.JsonToObject<TIntelipostWebhook>(AJsonString)
end;

end.
