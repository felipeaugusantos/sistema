unit untIntelipost.QuoteByProduct;

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

  TVolumesClass = class
  private
    FCost_of_goods: Extended;
    FDescription: String;
    FHeight: Extended;
    FLength: Extended;
    FProduct_category: String;
    FQuantity_of_items: Extended;
    FVolume_type: String;
    FWeight: Extended;
    FWidth: Extended;
  public
    property cost_of_goods: Extended read FCost_of_goods write FCost_of_goods;
    property description: String read FDescription write FDescription;
    property height: Extended read FHeight write FHeight;
    property length: Extended read FLength write FLength;
    property product_category: String read FProduct_category write FProduct_category;
    property quantity_of_items: Extended read FQuantity_of_items write FQuantity_of_items;
    property volume_type: String read FVolume_type write FVolume_type;
    property weight: Extended read FWeight write FWeight;
    property width: Extended read FWidth write FWidth;
  end;

  TDelivery_optionsClass = class
  private
    FCubic_weight: Extended;
    FDelivery_additional_transit_time_business_days: Extended;
    FDelivery_estimate_business_days: Extended;
    FDelivery_estimate_transit_time_business_days: Extended;
    FDelivery_method_id: Integer;
    FDelivery_method_name: String;
    FDelivery_method_type: String;
    FDelivery_processing_time_business_days: Extended;
    FDescription: String;
    FFinal_shipping_cost: Extended;
    FLogistic_provider_name: String;
    FPickup_enabled: Boolean;
    FProvider_shipping_cost: Extended;
    FRemoved_by_quote_rules: Boolean;
    FRemoved_by_return_modes: Boolean;
    FScheduling_enabled: Boolean;
    FShown_to_client: Boolean;
  public
    property cubic_weight: Extended read FCubic_weight write FCubic_weight;
    property delivery_additional_transit_time_business_days: Extended read FDelivery_additional_transit_time_business_days write FDelivery_additional_transit_time_business_days;
    property delivery_estimate_business_days: Extended read FDelivery_estimate_business_days write FDelivery_estimate_business_days;
    property delivery_estimate_transit_time_business_days: Extended read FDelivery_estimate_transit_time_business_days write FDelivery_estimate_transit_time_business_days;
    property delivery_method_id: Integer read FDelivery_method_id write FDelivery_method_id;
    property delivery_method_name: String read FDelivery_method_name write FDelivery_method_name;
    property delivery_method_type: String read FDelivery_method_type write FDelivery_method_type;
    property delivery_processing_time_business_days: Extended read FDelivery_processing_time_business_days write FDelivery_processing_time_business_days;
    property description: String read FDescription write FDescription;
    property final_shipping_cost: Extended read FFinal_shipping_cost write FFinal_shipping_cost;
    property logistic_provider_name: String read FLogistic_provider_name write FLogistic_provider_name;
    property pickup_enabled: Boolean read FPickup_enabled write FPickup_enabled;
    property provider_shipping_cost: Extended read FProvider_shipping_cost write FProvider_shipping_cost;
    property removed_by_quote_rules: Boolean read FRemoved_by_quote_rules write FRemoved_by_quote_rules;
    property removed_by_return_modes: Boolean read FRemoved_by_return_modes write FRemoved_by_return_modes;
    property scheduling_enabled: Boolean read FScheduling_enabled write FScheduling_enabled;
    property shown_to_client: Boolean read FShown_to_client write FShown_to_client;
  end;

  TContentClass = class
  private
    FCached: Boolean;
    FClient_id: Extended;
    FClient_name: String;
    FCreated: Extended;
    FCreated_iso: String;
    FDelivery_options: TArray<TDelivery_optionsClass>;
    FDestination_zip_code: String;
    FId: Extended;
    FOrigin_zip_code: String;
    FPlatform: String;
    FQuoting_mode: String;
    FSkip_quote_rules: Boolean;
    FSkip_return_modes: Boolean;
    FVolumes: TArray<TVolumesClass>;
  public
    property cached: Boolean read FCached write FCached;
    property client_id: Extended read FClient_id write FClient_id;
    property client_name: String read FClient_name write FClient_name;
    property created: Extended read FCreated write FCreated;
    property created_iso: String read FCreated_iso write FCreated_iso;
    property delivery_options: TArray<TDelivery_optionsClass> read FDelivery_options write FDelivery_options;
    property destination_zip_code: String read FDestination_zip_code write FDestination_zip_code;
    property id: Extended read FId write FId;
    property origin_zip_code: String read FOrigin_zip_code write FOrigin_zip_code;
    property platform: String read FPlatform write FPlatform;
    property quoting_mode: String read FQuoting_mode write FQuoting_mode;
    property skip_quote_rules: Boolean read FSkip_quote_rules write FSkip_quote_rules;
    property skip_return_modes: Boolean read FSkip_return_modes write FSkip_return_modes;
    property volumes: TArray<TVolumesClass> read FVolumes write FVolumes;
    destructor Destroy; override;
  end;

  TRetornoQuoteByProduct = class
  private
    FContent: TContentClass;
    FLocale: String;
    FStatus: String;
    FTime: String;
    FTimezone: String;
  public
    property content: TContentClass read FContent write FContent;
    property locale: String read FLocale write FLocale;
    property status: String read FStatus write FStatus;
    property time: String read FTime write FTime;
    property timezone: String read FTimezone write FTimezone;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoQuoteByProduct;
  end;

  TProductsClass = class
  private
    FCost_of_goods: Extended;
    FHeight: Extended;
    FLength: Extended;
    FQuantity: Extended;
    FSku_id: String;
    FWeight: Extended;
    FWidth: Extended;
  public
    property cost_of_goods: Extended read FCost_of_goods write FCost_of_goods;
    property height: Extended read FHeight write FHeight;
    property length: Extended read FLength write FLength;
    property quantity: Extended read FQuantity write FQuantity;
    property sku_id: String read FSku_id write FSku_id;
    property weight: Extended read FWeight write FWeight;
    property width: Extended read FWidth write FWidth;
  end;

  TQuoteByProduct = class
  private
    FDestination_zip_code: String;
    FOrigin_zip_code: String;
    FProducts: TArray<TProductsClass>;
    FQuoting_mode: String;

    procedure pAddProduto(Produto: TProductsClass);
  public
    property destination_zip_code: String read FDestination_zip_code write FDestination_zip_code;
    property origin_zip_code: String read FOrigin_zip_code write FOrigin_zip_code;
    property products: TArray<TProductsClass> read FProducts write FProducts;
    property quoting_mode: String read FQuoting_mode write FQuoting_mode;
    destructor Destroy; override;

    class function fNew: TQuoteByProduct;
    function fNewProduto: TProductsClass;

    function ToJsonString: string;

    function fCalcularFrete: TRetornoQuoteByProduct;
  end;

const
  MODO_COTACAO = 'DYNAMIC_BOX_ALL_ITEMS';

implementation

{TQuoteByProduct}

uses untIntelipostRestApi, untRestApi;

{TContentClass}

destructor TContentClass.Destroy;
var
  Ldelivery_optionsItem: TDelivery_optionsClass;
  LvolumesItem: TVolumesClass;
begin

 for Ldelivery_optionsItem in FDelivery_options do
   Ldelivery_optionsItem.free;
 for LvolumesItem in FVolumes do
   LvolumesItem.free;

  inherited;
end;

{TRetornoQuoteByProduct}

constructor TRetornoQuoteByProduct.Create;
begin
  inherited;
  FContent := TContentClass.Create();
end;

destructor TRetornoQuoteByProduct.Destroy;
begin
  FContent.free;
  inherited;
end;

class function TRetornoQuoteByProduct.FromJsonString(AJsonString: string): TRetornoQuoteByProduct;
begin
  result := TJson.JsonToObject<TRetornoQuoteByProduct>(AJsonString)
end;

class function TQuoteByProduct.fNew: TQuoteByProduct;
begin
  Result := TQuoteByProduct.Create;
end;

function TQuoteByProduct.fNewProduto: TProductsClass;
begin
  Result := TProductsClass.Create;
  pAddProduto(Result);
end;

destructor TQuoteByProduct.Destroy;
var
  LproductsItem: TProductsClass;
begin

 for LproductsItem in FProducts do
   LproductsItem.free;

  inherited;
end;

function TQuoteByProduct.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

procedure TQuoteByProduct.pAddProduto(Produto: TProductsClass);
begin
  SetLength(FProducts, Length(FProducts)+1);
  FProducts[Length(FProducts)-1] := Produto;
end;

function TQuoteByProduct.fCalcularFrete: TRetornoQuoteByProduct;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('INTELIPOST', TControllerConfigurarIntelipost.fConfigurarIntelipost);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'quote_by_product';
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('api-key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_ITPKEY', VS_strCodEmp], True, EmptyStr), pkHTTPHEADER);

    RESTRequest
    .Params
    .AddItem(  '',
               ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TRetornoQuoteByProduct.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
