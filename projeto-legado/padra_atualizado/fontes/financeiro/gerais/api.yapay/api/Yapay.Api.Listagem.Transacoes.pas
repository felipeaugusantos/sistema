unit Yapay.Api.Listagem.Transacoes;

interface

uses
  RTTI,
  System.Variants,
  System.SysUtils,
  System.JSON,
  System.DateUtils,
  System.Generics.Collections,
  Yapay.Api.Helpers,
  Yapay.Api.Core,
  Yapay.Api.Conexao,
  Yapay.Api.Ambiente,
  Yapay.Api.Resources,
  Yapay.Api.ErrorResponse,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento,
  Yapay.Api.Cobranca.Base;

type
{$M+}
  TYapayApiTabelaParametrosListagemTransacoes = class
  strict private
    Fid: int64;
  private
    FAccess_token: string;
  published
    property Access_token: string read FAccess_token;
    property Id: int64 read Fid write Fid;
  end;

  TYapayApiRespostaListagemTransacoesComSucesso = class
  private
    type
      TPagination = class
      private
        FCurrent_page: int64;
        FPer_page: int64;
        FPage_amount: int64;
        FCount: int64;
      public
        property Current_page: int64 read FCurrent_page;
        property Per_page: int64 read FPer_page;
        property Page_amount: int64 read FPage_amount;
        property Count: int64 read FCount;
      end;

      TDataItem = class
      private
        type
          TStatus = class
          private
            FName: string;
            FResource: string;
            FId: int64;
          public
            property Resource: string read FResource;
            property Name: string read FName;
            property Id: int64 read FId;
          end;

          TPayment = class
          private
            FPayment_method_id: int64;
            FTid: int64;
            FResource: string;
            FPayment_method_name: string;
            FInstallments: int64;
          public
            property Resource: string read FResource;
            property Tid: int64 read FTid;
            property Payment_method_id: int64 read FPayment_method_id;
            property Payment_method_name: string read FPayment_method_name;
            property Installments: int64 read FInstallments;
          end;

          TCustomer = class
          private
            FName: string;
            FCnpj: string;
            FEmail: string;
            FCpf: string;
            FResource: string;
            FBusiness_name: string;
          public
            property Resource: string read FResource;
            property Name: string read FName;
            property Business_name: string read FBusiness_name;
            property Email: string read FEmail;
            property Cpf: string read FCpf;
            property Cnpj: string read FCnpj;
          end;

          TSeller = class
          private
            FName: string;
            FCnpj: string;
            FEmail: string;
            FCpf: string;
            FResource: string;
          public
            property Resource: string read FResource;
            property Name: string read FName;
            property Email: string read FEmail;
            property Cpf: string read FCpf;
            property Cnpj: string read FCnpj;
          end;

          TTransaction_product = class
          private
            FImg_url: string;
            FCode: string;
            FResource: string;
            FSku_code: string;
            FQuantity: double;
            FDescription: string;
            FUnit_price: double;
            FExtra: string;
          public
            property Resource: string read FResource;
            property Code: string read FCode;
            property Description: string read FDescription;
            property Extra: string read FExtra;
            property Unit_price: double read FUnit_price;
            property Quantity: double read FQuantity;
            property Sku_code: string read FSku_code;
            property Img_url: string read FImg_url;
          end;

          TTransaction_products = TObjectList<TTransaction_product>;

          TShipping = class
          private
            type
              TAddress = class
              private
                FStreet: string;
                FState: string;
                FPrimary: Boolean;
                FResource: string;
                FId: int64;
                FComplement: string;
                FNumber: string;
                FNeighborhood: string;
                FCity: string;
                FActive: Boolean;
                FPostal_code: string;
                FType: string;
              public
                property Resource: string read FResource;
                property Id: int64 read FId;
                property Active: Boolean read FActive;
                property Primary: Boolean read FPrimary;
                property Postal_code: string read FPostal_code;
                property Street: string read FStreet;
                property Complement: string read FComplement;
                property Number: string read FNumber;
                property Neighborhood: string read FNeighborhood;
                property City: string read FCity;
                property State: string read FState;
                property _Type: string read FType;
              end;

            var
              FPosted_date: TDateTime;
              FTracking_url: string;
              FShipping_type: string;
              FResource: string;
              FTracking_code: string;
              FShipping_price: double;
              FAddress: TAddress;
          public
            property Resource: string read FResource;
            property Shipping_price: double read FShipping_price;
            property Shipping_type: string read FShipping_type;
            property Tracking_code: string read FTracking_code;
            property Tracking_url: string read FTracking_url;
            property Posted_date: TDateTime read FPosted_date;
            property Address: TAddress read FAddress;

            constructor Create; reintroduce;
            destructor Destroy; override;
          end;

        var
          FPayment_price: Double;
          FRemaining_time_to_open_dispute: int64;
          FUpdated: TDateTime;
          FResource: string;
          FDiscount_price: Double;
          FCreated: TDateTime;
          FSub_store: string;
          FId: int64;
          FSeller_price: Double;
          FOrder_number: string;
          FAdditional_price: Double;
          FTax: Double;
          FOriginal_price: Double;
          FStatus: TStatus;
          FContestation_id: int64;
          FTransaction_token: string;
          FCanceled_by: string;
          FUrl_notification: string;
          FStatus_changed_at: TDateTime;
          FFraud_confirmated: Boolean;
          FPayment: TPayment;
          FCustomer: TCustomer;
          FSeller: TSeller;
          FTransaction_products: TTransaction_products;
          FShipping: TShipping;
      public
        property Resource: string read FResource;
        property Id: int64 read FId;
        property Order_number: string read FOrder_number;
        property Original_price: Double read FOriginal_price;
        property Tax: Double read FTax;
        property Seller_price: Double read FSeller_price;
        property Payment_price: Double read FPayment_price;
        property Discount_price: Double read FDiscount_price;
        property Additional_price: Double read FAdditional_price;
        property Sub_store: string read FSub_store;
        property Created: TDateTime read FCreated;
        property Updated: TDateTime read FUpdated;
        property Remaining_time_to_open_dispute: int64 read FRemaining_time_to_open_dispute;
        property Status: TStatus read FStatus;
        property Status_changed_at: TDateTime read FStatus_changed_at;
        property Url_notification: string read FUrl_notification;
        property Transaction_token: string read FTransaction_token;
        property Contestation_id: int64 read FContestation_id;
        property Canceled_by: string read FCanceled_by;
        property Fraud_confirmated: Boolean read FFraud_confirmated;
        property Payment: TPayment read FPayment;
        property Customer: TCustomer read FCustomer;
        property Seller: TSeller read FSeller;
        property Transaction_products: TTransaction_products read FTransaction_products;
        property Shipping: TShipping read FShipping;

        constructor Create; reintroduce;
        destructor Destroy; override;
      end;

      TData = TObjectList<TDataItem>;

      TOptions = class
      private
        type
          TColumns = class
          private
            FPayment_method: boolean;
            FPrice_payment: boolean;
            FBuyer_seller: boolean;
            FPrice_seller: boolean;
            FTracking: boolean;
            FTax: boolean;
          public
            property Buyer_seller: boolean read FBuyer_seller;
            property Tracking: boolean read FTracking;
            property Payment_method: boolean read FPayment_method;
            property Tax: boolean read FTax;
            property Price_seller: boolean read FPrice_seller;
            property Price_payment: boolean read FPrice_payment;
          end;

        var
          FSum_price_seller: double;
          FSum_tax: double;
          FSum_price_original: double;
          FSum_price_payment: double;
          FColumns: TColumns;
      public
        property Sum_price_original: double read FSum_price_original;
        property Sum_price_seller: double read FSum_price_seller;
        property Sum_tax: double read FSum_tax;
        property Sum_price_payment: double read FSum_price_payment;
        property Columns: TColumns read FColumns;

        constructor Create; reintroduce;
        destructor Destroy; override;
      end;

    var
      FResource: string;
      FPagination: TPagination;
      FData: TData;
      FOptions: TOptions;
  published
    property Resource: string read FResource;
    property Pagination: TPagination read FPagination;
    property Data: TData read FData;
    property Options: TOptions read FOptions;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
  end;

  TYapayApiListagemTransacoes = class
  strict private
    FConexao: TYapayApiConexao;
    FMetodo: TYapayApiCoreMetodo;
    FTabelaParametros: TYapayApiTabelaParametrosListagemTransacoes;
    FJSONEnvio: string;
    FJSONRetorno: string;
    FResposta: TYapayApiRespostaListagemTransacoesComSucesso;
    function ProcessaRetorno: Boolean;
  strict protected
    FCore: TYapayApiCore;
    FJSONRequest: TJSONObject;
    function GetEndereco: string;
    procedure ProcessaSucesso; virtual;

    procedure NodeResource(var oJSONObj: TJSONObject);
    procedure NodePagination(var oJSONObj: TJSONObject);
    procedure NodeData(var oJSONObj: TJSONObject);
    procedure NodeStatus(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodePayment(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodeCustomer(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodeSeller(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodeTransaction_Products(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodeShipping(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);
    procedure NodeAddress(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem; var oJSONSubObj: TJSONObject);

    procedure NodeOptions(var oJSONObj: TJSONObject);
    procedure NodeColumns(var oJSONSubObj: TJSONObject);

    function TryGetValue(const oJSONObj: TJSONObject; const sPatch: string; var Value: string): boolean; overload;
    function TryGetValue(const oJSONObj: TJSONObject; const sPatch: string; var Value: int64): boolean; overload;
    function TryGetValue(const oJSONObj: TJSONObject; const sPatch: string; var Value: Double): boolean; overload;
    function TryGetValue(const oJSONObj: TJSONObject; const sPatch: string; var Value: TDateTime): boolean; overload;
    function TryGetValue(const oJSONObj: TJSONObject; const sPatch: string; var Value: Boolean): boolean; overload;
  published
    property Conexao: TYapayApiConexao read FConexao write FConexao;
    property Metodo: TYapayApiCoreMetodo read FMetodo;
    property TabelaParametros: TYapayApiTabelaParametrosListagemTransacoes read FTabelaParametros;
    property Resposta: TYapayApiRespostaListagemTransacoesComSucesso read FResposta;
    property JSONEnvio: string read FJSONEnvio;
    property JSONRetorno: string read FJSONRetorno;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    function Enviar: Boolean; virtual;
  end;
{$M-}

implementation

{ TYapayApiListagemTransacoes }

constructor TYapayApiListagemTransacoes.Create;
begin
  inherited Create;
  FMetodo := TYapayApiCoreMetodo.Get;
  FTabelaParametros := TYapayApiTabelaParametrosListagemTransacoes.Create;
  FResposta := TYapayApiRespostaListagemTransacoesComSucesso.Create;
end;

destructor TYapayApiListagemTransacoes.Destroy;
begin
  FResposta.Free;
  FTabelaParametros.Free;
  inherited Destroy;
end;

function TYapayApiListagemTransacoes.Enviar: Boolean;
begin
  TabelaParametros.FAccess_token := Self.Conexao.Token.Data_Response.Authorization.Access_Token;
  FCore := TYapayApiCore.Create;
  try
    FCore.Metodo := FMetodo;
    FCore.Debug := Self.Conexao.Debug;
    FCore.Log := Self.Conexao.Log;
    FCore.BaseURL := GetEndereco;
    FCore.Access_Token := TabelaParametros.FAccess_token;

    if Assigned(FJSONRequest) then
      FCore.JSONEnvio := FJSONRequest.ToJSON;

    FCore.Execute;
    FJSONEnvio := FCore.JSONEnvio;
    FJSONRetorno := FCore.JSONRetorno;
    Result := ProcessaRetorno;
  finally
    if Assigned(FCore) then
      FreeAndNil(FCore);
  end;
end;

function TYapayApiListagemTransacoes.GetEndereco: string;
begin
  case Conexao.Ambiente of
    Sandbox: result := rsYAPAY_API_LISTAGEM_TRANSACOES_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_LISTAGEM_TRANSACOES_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;

  if TabelaParametros.Id <> 0 then
    result := result + '?id=' + TabelaParametros.Id.ToString;
end;

function TYapayApiListagemTransacoes.ProcessaRetorno: Boolean;
var
  oJSONObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  Result := False;
  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;
    if oJSONObj.TryGetValue<TJSONValue>('resource', oJSONValue) then
    begin
      ProcessaSucesso;
      Result := True;
    end;
  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

function TYapayApiListagemTransacoes.TryGetValue(const oJSONObj: TJSONObject;
  const sPatch: string; var Value: string): boolean;
var
  oJSONValue: TJSONValue;
begin
  result := oJSONObj.TryGetValue(sPatch, oJSONValue);
  Value := String.Empty;
  if result then
    Value := oJSONValue.Value;
end;

function TYapayApiListagemTransacoes.TryGetValue(const oJSONObj: TJSONObject;
  const sPatch: string; var Value: int64): boolean;
var
  oJSONValue: TJSONValue;
begin
  result := oJSONObj.TryGetValue(sPatch, oJSONValue);
  Value := Default(int64);
  if result then
    Value := StrToInt64Def(oJSONValue.Value, Default(int64));
end;

function TYapayApiListagemTransacoes.TryGetValue(const oJSONObj: TJSONObject;
  const sPatch: string; var Value: Double): boolean;
var
  oJSONValue: TJSONValue;
begin
  result := oJSONObj.TryGetValue(sPatch, oJSONValue);
  Value := Default(Double);
  if result then
    Value := StrToFloatDef(oJSONValue.Value, Default(Double));
end;

function TYapayApiListagemTransacoes.TryGetValue(const oJSONObj: TJSONObject;
  const sPatch: string; var Value: TDateTime): boolean;
var
  oJSONValue: TJSONValue;
begin
  result := oJSONObj.TryGetValue(sPatch, oJSONValue);
  Value := Default(TDateTime);

  if StrToInt64Def(oJSONValue.Value,0) = 0 then
    Exit;

  if result then
    Value := UnixToDateTime(StrToInt64Def(oJSONValue.Value,0), False);
end;

function TYapayApiListagemTransacoes.TryGetValue(const oJSONObj: TJSONObject;
  const sPatch: string; var Value: Boolean): boolean;
var
  oJSONValue: TJSONValue;
begin
  result := oJSONObj.TryGetValue(sPatch, oJSONValue);
  Value := False;
  if result then
    Value := CompareText(oJSONValue.Value, 'true') = 0;
end;

procedure TYapayApiListagemTransacoes.NodeResource(var oJSONObj: TJSONObject);
begin
  TryGetValue(oJSONObj, 'resource', FResposta.FResource);
end;

procedure TYapayApiListagemTransacoes.NodePagination(var oJSONObj: TJSONObject);
var
  oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  if not oJSONObj.TryGetValue('pagination', oJSONValue) then
    exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'current_page', FResposta.FPagination.FCurrent_page);
  TryGetValue(oJSONSubObj, 'per_page', FResposta.FPagination.FPer_page);
  TryGetValue(oJSONSubObj, 'page_amount', FResposta.FPagination.Fpage_amount);
  TryGetValue(oJSONSubObj, 'count', FResposta.FPagination.FCount);
end;

procedure TYapayApiListagemTransacoes.NodeStatus(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('status', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FStatus.FResource);
  TryGetValue(oJSONSubObj, 'name', objDataItem.FStatus.FName);
  TryGetValue(oJSONSubObj, 'id', objDataItem.FStatus.FId);
end;

procedure TYapayApiListagemTransacoes.NodePayment(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('payment', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FPayment.FResource);
  TryGetValue(oJSONSubObj, 'tid', objDataItem.FPayment.FTid);
  TryGetValue(oJSONSubObj, 'payment_method_id', objDataItem.FPayment.FPayment_method_id);
  TryGetValue(oJSONSubObj, 'payment_method_name', objDataItem.FPayment.FPayment_method_name);
  TryGetValue(oJSONSubObj, 'installments', objDataItem.FPayment.FInstallments);
end;

procedure TYapayApiListagemTransacoes.NodeCustomer(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('customer', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FCustomer.FResource);
  TryGetValue(oJSONSubObj, 'name', objDataItem.FCustomer.FName);
  TryGetValue(oJSONSubObj, 'business_name', objDataItem.FCustomer.FBusiness_name);
  TryGetValue(oJSONSubObj, 'email', objDataItem.FCustomer.FEmail);
  TryGetValue(oJSONSubObj, 'cpf', objDataItem.FCustomer.FCpf);
  TryGetValue(oJSONSubObj, 'cnpj', objDataItem.FCustomer.FCnpj);
end;

procedure TYapayApiListagemTransacoes.NodeSeller(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('seller', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FSeller.FResource);
  TryGetValue(oJSONSubObj, 'name', objDataItem.FSeller.FName);
  TryGetValue(oJSONSubObj, 'email', objDataItem.FSeller.FEmail);
  TryGetValue(oJSONSubObj, 'cpf', objDataItem.FSeller.FCpf);
  TryGetValue(oJSONSubObj, 'cnpj', objDataItem.FSeller.FCnpj);
end;

procedure TYapayApiListagemTransacoes.NodeTransaction_Products(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
  oJSONSubArray: TJSONArray;
  i: integer;
  objTransaction_products: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem.TTransaction_product;
begin
  if not oJSONSubObj.TryGetValue('transaction_products', oJSONValue) then
    Exit;

  oJSONSubArray := oJSONValue as TJSONArray;

  for i := 0 to oJSONSubArray.Count - 1 do
  begin
    objTransaction_products := TYapayApiRespostaListagemTransacoesComSucesso.TDataitem.TTransaction_product.Create;
    oJSONValue := oJSONSubArray.Items[i];

    oJSONSubObj := oJSONValue as TJSONObject;

    TryGetValue(oJSONSubObj, 'resource', objTransaction_products.FResource);
    TryGetValue(oJSONSubObj, 'code', objTransaction_products.FCode);
    TryGetValue(oJSONSubObj, 'description', objTransaction_products.FDescription);
    TryGetValue(oJSONSubObj, 'extra', objTransaction_products.FExtra);
    TryGetValue(oJSONSubObj, 'unit_price', objTransaction_products.FUnit_price);
    TryGetValue(oJSONSubObj, 'quantity', objTransaction_products.FQuantity);
    TryGetValue(oJSONSubObj, 'sku_code', objTransaction_products.FSku_code);
    TryGetValue(oJSONSubObj, 'img_url', objTransaction_products.FImg_url);

    objDataItem.FTransaction_products.Add(objTransaction_products);
  end;
end;

procedure TYapayApiListagemTransacoes.NodeAddress(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('address', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FShipping.FAddress.FResource);
  TryGetValue(oJSONSubObj, 'id', objDataItem.FShipping.FAddress.FId);
  TryGetValue(oJSONSubObj, 'active', objDataItem.FShipping.FAddress.FActive);
  TryGetValue(oJSONSubObj, 'primary', objDataItem.FShipping.FAddress.FPrimary);
  TryGetValue(oJSONSubObj, 'postal_code', objDataItem.FShipping.FAddress.FPostal_code);
  TryGetValue(oJSONSubObj, 'street', objDataItem.FShipping.FAddress.FStreet);
  TryGetValue(oJSONSubObj, 'complement', objDataItem.FShipping.FAddress.FComplement);
  TryGetValue(oJSONSubObj, 'number', objDataItem.FShipping.FAddress.FNumber);
  TryGetValue(oJSONSubObj, 'neighborhood', objDataItem.FShipping.FAddress.FNeighborhood);
  TryGetValue(oJSONSubObj, 'city', objDataItem.FShipping.FAddress.FCity);
  TryGetValue(oJSONSubObj, 'state', objDataItem.FShipping.FAddress.FState);
  TryGetValue(oJSONSubObj, 'type', objDataItem.FShipping.FAddress.FType);
end;

procedure TYapayApiListagemTransacoes.NodeShipping(objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
  var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('shipping', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'resource', objDataItem.FShipping.FResource);
  TryGetValue(oJSONSubObj, 'shipping_price', objDataItem.FShipping.FShipping_price);
  TryGetValue(oJSONSubObj, 'shipping_type', objDataItem.FShipping.FShipping_type);
  TryGetValue(oJSONSubObj, 'tracking_code', objDataItem.FShipping.FTracking_code);
  TryGetValue(oJSONSubObj, 'tracking_url', objDataItem.FShipping.Ftracking_url);
  TryGetValue(oJSONSubObj, 'posted_date', objDataItem.FShipping.FPosted_date);

  NodeAddress(objDataItem, oJSONSubObj);
end;

procedure TYapayApiListagemTransacoes.NodeData(var oJSONObj: TJSONObject);
var
  oJSONArray: TJSONArray;
  oJSONValue: TJSONValue;
  oJSONSubObj: TJSONObject;
  I: integer;
  objDataItem: TYapayApiRespostaListagemTransacoesComSucesso.TDataitem;
begin
  if not oJSONObj.TryGetValue('data', oJSONValue) then
    Exit;

  oJSONArray := oJSONValue as TJSONArray;
  FResposta.FData.Clear;
  for I := 0 to oJSONArray.Count - 1 do
  begin
    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    objDataItem := TYapayApiRespostaListagemTransacoesComSucesso.TDataitem.Create;

    TryGetValue(oJSONSubObj, 'resource', objDataItem.FResource);
    TryGetValue(oJSONSubObj, 'id', objDataItem.FId);
    TryGetValue(oJSONSubObj, 'order_number', objDataItem.FOrder_number);
    TryGetValue(oJSONSubObj, 'original_price', objDataItem.FOriginal_price);
    TryGetValue(oJSONSubObj, 'tax', objDataItem.FTax);
    TryGetValue(oJSONSubObj, 'seller_price', objDataItem.FSeller_price);
    TryGetValue(oJSONSubObj, 'payment_price', objDataItem.FPayment_price);
    TryGetValue(oJSONSubObj, 'discount_price', objDataItem.FDiscount_price);
    TryGetValue(oJSONSubObj, 'additional_price', objDataItem.FAdditional_price);
    TryGetValue(oJSONSubObj, 'sub_store', objDataItem.FSub_store);
    TryGetValue(oJSONSubObj, 'created', objDataItem.FCreated);
    TryGetValue(oJSONSubObj, 'updated', objDataItem.FUpdated);
    TryGetValue(oJSONSubObj, 'remaining_time_to_open_dispute', objDataItem.FRemaining_time_to_open_dispute);

    NodeStatus(objDataItem, oJSONSubObj);

    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    TryGetValue(oJSONSubObj, 'status_changed_at', objDataItem.FStatus_changed_at);
    TryGetValue(oJSONSubObj, 'url_notification', objDataItem.FUrl_notification);
    TryGetValue(oJSONSubObj, 'transaction_token', objDataItem.FTransaction_token);
    TryGetValue(oJSONSubObj, 'contestation_id', objDataItem.FContestation_id);
    TryGetValue(oJSONSubObj, 'canceled_by', objDataItem.FCanceled_by);
    TryGetValue(oJSONSubObj, 'fraud_confirmated', objDataItem.FFraud_confirmated);

    NodePayment(objDataItem, oJSONSubObj);

    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    NodeCustomer(objDataItem, oJSONSubObj);

    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    NodeSeller(objDataItem, oJSONSubObj);

    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    NodeTransaction_Products(objDataItem, oJSONSubObj);

    oJSONValue := oJSONArray.Items[i];
    oJSONSubObj := oJSONValue as TJSONObject;

    NodeShipping(objDataItem, oJSONSubObj);

    FResposta.FData.Add(objDataItem);
  end;
end;

procedure TYapayApiListagemTransacoes.ProcessaSucesso;
var
  oJSONObj: TJSONObject;
begin
  if Assigned(FResposta) then
    FreeAndNil(FResposta);

  FResposta := TYapayApiRespostaListagemTransacoesComSucesso.Create;

  oJSONObj := nil;
  try
    oJSONObj := TJSONObject.ParseJSONValue(FCore.JSONRetorno) as TJSONObject;

    NodeResource(oJSONObj);

    if CompareText(FResposta.FResource, 'list') <> 0 then
      exit;

    NodePagination(oJSONObj);
    NodeData(oJSONObj);
    NodeOptions(oJSONObj);

  finally
    if Assigned(oJSONObj) then
      FreeAndNil(oJSONObj);
  end;
end;

procedure TYapayApiListagemTransacoes.NodeOptions(var oJSONObj: TJSONObject);
var
  oJSONSubObj: TJSONObject;
  oJSONValue: TJSONValue;
begin
  if not oJSONObj.TryGetValue('options', oJSONValue) then
    exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'sum_price_original', FResposta.FOptions.FSum_price_original);
  TryGetValue(oJSONSubObj, 'sum_price_seller', FResposta.FOptions.FSum_price_seller);
  TryGetValue(oJSONSubObj, 'sum_tax', FResposta.FOptions.FSum_tax);
  TryGetValue(oJSONSubObj, 'sum_price_payment', FResposta.FOptions.FSum_price_payment);

  NodeColumns(oJSONSubObj);
end;

procedure TYapayApiListagemTransacoes.NodeColumns(var oJSONSubObj: TJSONObject);
var
  oJSONValue: TJSONValue;
begin
  if not oJSONSubObj.TryGetValue('columns', oJSONValue) then
    Exit;

  oJSONSubObj := oJSONValue as TJSONObject;

  TryGetValue(oJSONSubObj, 'buyer_seller', FResposta.FOptions.FColumns.FBuyer_seller);
  TryGetValue(oJSONSubObj, 'tracking', FResposta.FOptions.FColumns.FTracking);
  TryGetValue(oJSONSubObj, 'payment_method', FResposta.FOptions.FColumns.FPayment_method);
  TryGetValue(oJSONSubObj, 'tax', FResposta.FOptions.FColumns.FTax);
  TryGetValue(oJSONSubObj, 'price_seller', FResposta.FOptions.FColumns.FPrice_seller);
  TryGetValue(oJSONSubObj, 'price_payment', FResposta.FOptions.FColumns.FPrice_payment);
end;

constructor TYapayApiRespostaListagemTransacoesComSucesso.Create;
begin
  inherited Create;
  FPagination := TPagination.Create;
  FData := TData.Create;
  FOptions := TOptions.Create;
end;

destructor TYapayApiRespostaListagemTransacoesComSucesso.Destroy;
begin
  FPagination.Free;
  FData.Free;
  FOptions.Free;
  inherited Destroy;
end;

constructor TYapayApiRespostaListagemTransacoesComSucesso.TDataItem.Create;
begin
  inherited Create;
  FStatus := TStatus.Create;
  FPayment := TPayment.Create;
  FCustomer := TCustomer.Create;
  FSeller := TSeller.Create;
  FTransaction_products := TTransaction_products.Create;
  FShipping := TShipping.Create;
end;

destructor TYapayApiRespostaListagemTransacoesComSucesso.TDataItem.Destroy;
begin
  FStatus.Free;
  FPayment.Free;
  FCustomer.Free;
  FSeller.Free;
  FTransaction_products.Free;
  FShipping.Free;
  inherited Destroy;
end;

constructor TYapayApiRespostaListagemTransacoesComSucesso.TDataItem.TShipping.Create;
begin
  inherited Create;
  FAddress := TAddress.Create;
end;

destructor TYapayApiRespostaListagemTransacoesComSucesso.TDataItem.TShipping.Destroy;
begin
  FAddress.Free;
  inherited Destroy;
end;

constructor TYapayApiRespostaListagemTransacoesComSucesso.TOptions.Create;
begin
  inherited Create;
  FColumns := TColumns.Create;
end;

destructor TYapayApiRespostaListagemTransacoesComSucesso.TOptions.Destroy;
begin
  FColumns.free;
  inherited Destroy;
end;

end.
