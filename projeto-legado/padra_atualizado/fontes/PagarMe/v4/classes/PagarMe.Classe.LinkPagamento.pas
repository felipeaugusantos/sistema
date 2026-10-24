unit PagarMe.Classe.LinkPagamento;

interface

uses
  PagarMe.Base.JSON, System.Generics.Collections, REST.Json.Types,
  untBaseIntegracaoJSON;

{$M+}
type
  TDocuments = class;

  TCustomer = class(TBaseJSONPagarMe)
  private
    FBirthday: String;
    FCountry: string;
    [JSONName('documents'), JSONMarshalled(False)]
    FDocumentsArray: TArray<TDocuments>;
    [GenericListReflect]
    FDocuments: TObjectList<TDocuments>;
    FEmail: string;
    [JSONName('external_id')]
    FExternalId: string;
    FName: string;
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
    property Documents: TObjectList<TDocuments> read GetDocuments;
    property Email: string read FEmail write FEmail;
    property ExternalId: string read FExternalId write FExternalId;
    property Name: string read FName write FName;
    property PhoneNumbers: TList<string> read GetPhoneNumbers;
    property &Type: string read FType write FType;
  public
    destructor Destroy; override;
  end;

  TDocuments = class
  private
    FNumber: string;
    FType: string;
  published
    property Number: string read FNumber write FNumber;
    property &Type: string read FType write FType;
  end;

  TAddress = class
  private
    FCity: string;
    FCountry: string;
    FNeighborhood: string;
    FState: string;
    FStreet: string;
    [JSONName('street_number')]
    FStreetNumber: string;
    FZipcode: string;
  published
    property City: string read FCity write FCity;
    property Country: string read FCountry write FCountry;
    property Neighborhood: string read FNeighborhood write FNeighborhood;
    property State: string read FState write FState;
    property Street: string read FStreet write FStreet;
    property StreetNumber: string read FStreetNumber write FStreetNumber;
    property Zipcode: string read FZipcode write FZipcode;
  end;

  TBilling = class
  private
    FAddress: TAddress;
    FName: string;
  published
    property Address: TAddress read FAddress;
    property Name: string read FName write FName;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TCustomerConfig = class
  private
    FCustomer: TCustomer;
    FBilling: TBilling;
  published
    property Customer: TCustomer read FCustomer;
    property Billing: TBilling read FBilling;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TCreditCard = class
  private
    FEnabled: Boolean;
    [JSONName('free_installments')]
    FFreeInstallments: Integer;
    [JSONName('interest_rate')]
    FInterestRate: Double;
    [JSONName('max_installments')]
    FMaxInstallments: Integer;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property FreeInstallments: Integer read FFreeInstallments write FFreeInstallments;
    property InterestRate: Double read FInterestRate write FInterestRate;
    property MaxInstallments: Integer read FMaxInstallments write FMaxInstallments;
  end;

  TBoleto = class
  private
    FEnabled: Boolean;
    [JSONName('expires_in')]
    FExpiresIn: Integer;
  published
    property Enabled: Boolean read FEnabled write FEnabled;
    property ExpiresIn: Integer read FExpiresIn write FExpiresIn;
  end;

  TPaymentConfig = class
  private
    FBoleto: TBoleto;
    [JSONName('credit_card')]
    FCreditCard: TCreditCard;
    [JSONName('default_payment_method')]
    FDefaultPaymentMethod: string;
  published
    property Boleto: TBoleto read FBoleto;
    property CreditCard: TCreditCard read FCreditCard;
    property DefaultPaymentMethod: string read FDefaultPaymentMethod write FDefaultPaymentMethod;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TItems = class
  private
    FId: string;
    FQuantity: Integer;
    FTangible: Boolean;
    FTitle: string;
    [JSONName('unit_price')]
    FUnitPrice: Integer;
  published
    property Id: string read FId write FId;
    property Quantity: Integer read FQuantity write FQuantity;
    property Tangible: Boolean read FTangible write FTangible;
    property Title: string read FTitle write FTitle;
    property UnitPrice: Integer read FUnitPrice write FUnitPrice;
  end;

  TLinkPagamentoPagarMe = class(TBaseJSONPagarMe)
  private
    FAmount: Integer;
    [JSONName('expires_in')]
    FExpiresIn: Integer;
    [JSONName('items'), JSONMarshalled(False)]
    FItemsArray: TArray<TItems>;
    [GenericListReflect]
    FItems: TObjectList<TItems>;
    [JSONName('max_orders')]
    FMaxOrders: Integer;
    [JSONName('payment_config')]
    FPaymentConfig: TPaymentConfig;
    FCustomerConfig: TCustomerConfig;
    function GetItems: TObjectList<TItems>;
  protected
    function GetAsJson: string; override;
  published
    property Amount: Integer read FAmount write FAmount;
    property ExpiresIn: Integer read FExpiresIn write FExpiresIn;
    property Items: TObjectList<TItems> read GetItems;
    property MaxOrders: Integer read FMaxOrders write FMaxOrders;
    property PaymentConfig: TPaymentConfig read FPaymentConfig;
    property CustomerConfig: TCustomerConfig read FCustomerConfig;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TPaymentConfig }

constructor TPaymentConfig.Create;
begin
  inherited;
  FBoleto := TBoleto.Create;
  FCreditCard := TCreditCard.Create;
end;

destructor TPaymentConfig.Destroy;
begin
  FBoleto.Free;
  FCreditCard.Free;
  inherited;
end;

{ TLinkPagamentoPagarMe }

constructor TLinkPagamentoPagarMe.Create;
begin
  inherited;
  FPaymentConfig := TPaymentConfig.Create;
  FCustomerConfig := TCustomerConfig.Create;
end;

destructor TLinkPagamentoPagarMe.Destroy;
begin
  FPaymentConfig.Free;
  FCustomerConfig.Free;
  GetItems.Free;
  inherited;
end;

function TLinkPagamentoPagarMe.GetItems: TObjectList<TItems>;
begin
  Result := ObjectList<TItems>(FItems, FItemsArray);
end;

function TLinkPagamentoPagarMe.GetAsJson: string;
begin
  FCustomerConfig.Customer.AsJson;
  RefreshArray<TItems>(FItems, FItemsArray);
  Result := inherited;
end;

{ TCustomer }

destructor TCustomer.Destroy;
begin
  GetDocuments.Free;
  GetPhoneNumbers.Free;
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

{ TCustomerConfig }

constructor TCustomerConfig.Create;
begin
  inherited;
  FCustomer := TCustomer.Create;
  FBilling := TBilling.Create;
end;

destructor TCustomerConfig.Destroy;
begin
  FCustomer.Free;
  FBilling.Free;
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

end.
