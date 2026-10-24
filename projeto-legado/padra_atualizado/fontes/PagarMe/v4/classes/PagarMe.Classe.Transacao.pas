unit PagarMe.Classe.Transacao;

interface

uses
  PagarMe.Base.JSON, System.Generics.Collections, REST.Json.Types,
  untBaseIntegracaoJSON;

{$M+}

type
  TAddress = class;
  TDocuments = class;

  TMetadata = class
  end;

  TAntifraudMetadata = class
  end;

  TSplitRules = class
  private
    [JSONName('charge_processing_fee')]
    FChargeProcessingFee: Boolean;
    [JSONName('charge_remainder')]
    FChargeRemainder: Boolean;
    [JSONName('date_created')]
    FDateCreated: String;
    [JSONName('date_updated')]
    FDateUpdated: String;
    FId: string;
    FLiable: Boolean;
    FObject: string;
    FPercentage: Integer;
    [JSONName('recipient_id')]
    FRecipientId: string;
  published
    property ChargeProcessingFee: Boolean read FChargeProcessingFee write FChargeProcessingFee;
    property ChargeRemainder: Boolean read FChargeRemainder write FChargeRemainder;
    property DateCreated: String read FDateCreated write FDateCreated;
    property DateUpdated: String read FDateUpdated write FDateUpdated;
    property Id: string read FId write FId;
    property Liable: Boolean read FLiable write FLiable;
    property &Object: string read FObject write FObject;
    property Percentage: Integer read FPercentage write FPercentage;
    property RecipientId: string read FRecipientId write FRecipientId;
  end;

  TCard = class
  private
    FBrand: string;
    FCountry: string;
    [JSONName('date_created')]
    FDateCreated: String;
    [JSONName('date_updated')]
    FDateUpdated: String;
    [JSONName('expiration_date')]
    FExpirationDate: string;
    FFingerprint: string;
    [JSONName('first_digits')]
    FFirstDigits: string;
    [JSONName('holder_name')]
    FHolderName: string;
    FId: string;
    [JSONName('last_digits')]
    FLastDigits: string;
    FObject: string;
  published
    property Brand: string read FBrand write FBrand;
    property Country: string read FCountry write FCountry;
    property DateCreated: String read FDateCreated write FDateCreated;
    property DateUpdated: String read FDateUpdated write FDateUpdated;
    property ExpirationDate: string read FExpirationDate write FExpirationDate;
    property Fingerprint: string read FFingerprint write FFingerprint;
    property FirstDigits: string read FFirstDigits write FFirstDigits;
    property HolderName: string read FHolderName write FHolderName;
    property Id: string read FId write FId;
    property LastDigits: string read FLastDigits write FLastDigits;
    property &Object: string read FObject write FObject;
  end;

  TItems = class
  private
    FId: string;
    FObject: string;
    FQuantity: Integer;
    FTangible: Boolean;
    FTitle: string;
    [JSONName('unit_price')]
    FUnitPrice: Integer;
  published
    property Id: string read FId write FId;
    property &Object: string read FObject write FObject;
    property Quantity: Integer read FQuantity write FQuantity;
    property Tangible: Boolean read FTangible write FTangible;
    property Title: string read FTitle write FTitle;
    property UnitPrice: Integer read FUnitPrice write FUnitPrice;
  end;

  TAddress = class
  private
    FCity: string;
    FCountry: string;
    FId: Integer;
    FNeighborhood: string;
    FObject: string;
    FState: string;
    FStreet: string;
    [JSONName('street_number')]
    FStreetNumber: string;
    FZipcode: string;
  published
    property City: string read FCity write FCity;
    property Country: string read FCountry write FCountry;
    property Id: Integer read FId write FId;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property &Object: string read FObject write FObject;
    property State: string read FState write FState;
    property Street: string read FStreet write FStreet;
    property StreetNumber: string read FStreetNumber write FStreetNumber;
    property Zipcode: string read FZipcode write FZipcode;
  end;

  TShipping = class
  private
    FAddress: TAddress;
    [JSONName('delivery_date')]
    FDeliveryDate: String;
    FExpedited: Boolean;
    FFee: Integer;
    FId: Integer;
    FName: string;
    FObject: string;
  published
    property Address: TAddress read FAddress;
    property DeliveryDate: String read FDeliveryDate write FDeliveryDate;
    property Expedited: Boolean read FExpedited write FExpedited;
    property Fee: Integer read FFee write FFee;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property &Object: string read FObject write FObject;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TBilling = class
  private
    FAddress: TAddress;
    FId: Integer;
    FName: string;
    FObject: string;
  published
    property Address: TAddress read FAddress;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property &Object: string read FObject write FObject;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDocuments = class
  private
    FId: string;
    FNumber: string;
    FObject: string;
    FType: string;
  published
    property Id: string read FId write FId;
    property Number: string read FNumber write FNumber;
    property &Object: string read FObject write FObject;
    property &Type: string read FType write FType;
  end;

  TCustomer = class(TBaseJSONPagarMe)
  private
    FBirthday: String;
    FCountry: string;
    [JSONName('date_created')]
    FDateCreated: String;
    [JSONName('document_type')]
    FDocumentType: string;
    [JSONName('documents'), JSONMarshalled(False)]
    FDocumentsArray: TArray<TDocuments>;
    [GenericListReflect]
    FDocuments: TObjectList<TDocuments>;
    FEmail: string;
    [JSONName('external_id')]
    FExternalId: string;
    FId: Integer;
    FName: string;
    FObject: string;
    [JSONName('phone_numbers')]
    FPhoneNumbersArray: TArray<string>;
    [JSONMarshalled(False)]
    FPhoneNumbers: TList<string>;
    FType: string;
    function GetDocuments: TObjectList<TDocuments>;
    function GetPhoneNumbers: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Birthday: String read FBirthday write FBirthday;
    property Country: string read FCountry write FCountry;
    property DateCreated: String read FDateCreated write FDateCreated;
    property DocumentType: string read FDocumentType write FDocumentType;
    property Documents: TObjectList<TDocuments> read GetDocuments;
    property Email: string read FEmail write FEmail;
    property ExternalId: string read FExternalId write FExternalId;
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property &Object: string read FObject write FObject;
    property PhoneNumbers: TList<string> read GetPhoneNumbers;
    property &Type: string read FType write FType;
  public
    destructor Destroy; override;
  end;

  TTransacaoPagarMe = class(TBaseJSONPagarMe)
  private
    [JSONName('acquirer_id')]
    FAcquirerId: string;
    [JSONName('acquirer_name')]
    FAcquirerName: string;
    [JSONName('acquirer_response_code')]
    FAcquirerResponseCode: string;
    FAmount: Double;
    [JSONName('antifraud_metadata')]
    FAntifraudMetadata: TAntifraudMetadata;
    [JSONName('authorization_code')]
    FAuthorizationCode: string;
    [JSONName('authorized_amount')]
    FAuthorizedAmount: Double;
    FBilling: TBilling;
    [JSONName('capture_method')]
    FCaptureMethod: string;
    FCard: TCard;
    [JSONName('card_brand')]
    FCardBrand: string;
    [JSONName('card_first_digits')]
    FCardFirstDigits: string;
    [JSONName('card_holder_name')]
    FCardHolderName: string;
    [JSONName('card_last_digits')]
    FCardLastDigits: string;
    FCost: Integer;
    FCustomer: TCustomer;
    [JSONName('date_created')]
    FDateCreated: String;
    [JSONName('date_updated')]
    FDateUpdated: String;
    FId: String;
    FInstallments: Integer;
    FIp: string;
    [JSONName('items'), JSONMarshalled(False)]
    FItemsArray: TArray<TItems>;
    [GenericListReflect]
    FItems: TObjectList<TItems>;
    FMetadata: TMetadata;
    FNsu: String;
    FObject: string;
    [JSONName('paid_amount')]
    FPaidAmount: Double;
    [JSONName('payment_method')]
    FPaymentMethod: string;
    FReferer: string;
    [JSONName('refunded_amount')]
    FRefundedAmount: Double;
    FShipping: TShipping;
    [JSONName('split_rules'), JSONMarshalled(False)]
    FSplitRulesArray: TArray<TSplitRules>;
    [GenericListReflect]
    FSplitRules: TObjectList<TSplitRules>;
    FStatus: string;
    [JSONName('status_reason')]
    FStatusReason: string;
    FTId: String;
    function GetItems: TObjectList<TItems>;
    function GetSplitRules: TObjectList<TSplitRules>;
  protected
    function GetAsJson: string; override;
  published
    property AcquirerId: string read FAcquirerId write FAcquirerId;
    property AcquirerName: string read FAcquirerName write FAcquirerName;
    property AcquirerResponseCode: string read FAcquirerResponseCode write FAcquirerResponseCode;
    property Amount: Double read FAmount write FAmount;
    property AntifraudMetadata: TAntifraudMetadata read FAntifraudMetadata;
    property AuthorizationCode: string read FAuthorizationCode write FAuthorizationCode;
    property AuthorizedAmount: Double read FAuthorizedAmount write FAuthorizedAmount;
    property Billing: TBilling read FBilling;
    property CaptureMethod: string read FCaptureMethod write FCaptureMethod;
    property Card: TCard read FCard;
    property CardBrand: string read FCardBrand write FCardBrand;
    property CardFirstDigits: string read FCardFirstDigits write FCardFirstDigits;
    property CardHolderName: string read FCardHolderName write FCardHolderName;
    property CardLastDigits: string read FCardLastDigits write FCardLastDigits;
    property Cost: Integer read FCost write FCost;
    property Customer: TCustomer read FCustomer;
    property DateCreated: String read FDateCreated write FDateCreated;
    property DateUpdated: String read FDateUpdated write FDateUpdated;
    property Id: String read FId write FId;
    property Installments: Integer read FInstallments write FInstallments;
    property Ip: string read FIp write FIp;
    property Items: TObjectList<TItems> read GetItems;
    property Metadata: TMetadata read FMetadata;
    property Nsu: String read FNsu write FNsu;
    property &Object: string read FObject write FObject;
    property PaidAmount: Double read FPaidAmount write FPaidAmount;
    property PaymentMethod: string read FPaymentMethod write FPaymentMethod;
    property Referer: string read FReferer write FReferer;
    property RefundedAmount: Double read FRefundedAmount write FRefundedAmount;
    property Shipping: TShipping read FShipping;
    property SplitRules: TObjectList<TSplitRules> read GetSplitRules;
    property Status: string read FStatus write FStatus;
    property StatusReason: string read FStatusReason write FStatusReason;
    property TId: String read FTId write FTId;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TShipping }

constructor TShipping.Create;
begin
  inherited;
  FAddress := TAddress.Create;
end;

destructor TShipping.Destroy;
begin
  FAddress.Free;
  inherited;
end;

{ TBilling }

constructor TBilling.Create;
begin
  inherited;
  FAddress := TAddress.Create;
end;

destructor TBilling.Destroy;
begin
  FAddress.Free;
  inherited;
end;

{ TCustomer }

destructor TCustomer.Destroy;
begin
  GetPhoneNumbers.Free;
  GetDocuments.Free;
  inherited;
end;

function TCustomer.GetDocuments: TObjectList<TDocuments>;
begin
  Result := ObjectList<TDocuments>(FDocuments, FDocumentsArray);
end;

function TCustomer.GetPhoneNumbers: TList<string>;
begin
  Result := List<string>(FPhoneNumbers, FPhoneNumbersArray);
end;

function TCustomer.GetAsJson: string;
begin
  RefreshArray<TDocuments>(FDocuments, FDocumentsArray);
  RefreshArray<string>(FPhoneNumbers, FPhoneNumbersArray);
  Result := inherited;
end;

{ TTransacaoPagarMe }

constructor TTransacaoPagarMe.Create;
begin
  inherited;
  FCustomer := TCustomer.Create;
  FBilling := TBilling.Create;
  FShipping := TShipping.Create;
  FCard := TCard.Create;
  FAntifraudMetadata := TAntifraudMetadata.Create;
  FMetadata := TMetadata.Create;
end;

destructor TTransacaoPagarMe.Destroy;
begin
  FCustomer.Free;
  FBilling.Free;
  FShipping.Free;
  FCard.Free;
  FAntifraudMetadata.Free;
  FMetadata.Free;
  GetItems.Free;
  GetSplitRules.Free;
  inherited;
end;

function TTransacaoPagarMe.GetItems: TObjectList<TItems>;
begin
  Result := ObjectList<TItems>(FItems, FItemsArray);
end;

function TTransacaoPagarMe.GetSplitRules: TObjectList<TSplitRules>;
begin
  Result := ObjectList<TSplitRules>(FSplitRules, FSplitRulesArray);
end;

function TTransacaoPagarMe.GetAsJson: string;
begin
  FCustomer.AsJson;
  RefreshArray<TItems>(FItems, FItemsArray);
  RefreshArray<TSplitRules>(FSplitRules, FSplitRulesArray);
  Result := inherited;
end;

end.
