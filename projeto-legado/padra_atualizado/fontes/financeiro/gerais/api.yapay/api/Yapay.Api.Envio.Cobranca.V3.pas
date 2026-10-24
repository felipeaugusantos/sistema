unit Yapay.Api.Envio.Cobranca.V3;

interface

uses
  System.Variants,
  System.SysUtils,
  System.JSON,
  Yapay.Api.Resources,
  Yapay.Api.Core,
  Yapay.Api.Cobranca.Base,
  Yapay.Api.Ambiente,
  Yapay.Api.Tabela.Tabela3.FormasDePagamento;

type
{$M+}
  TYapayApiTabelaParametrosEnvioCobrancaV3 = class(TYapayApiTabelaParametrosBase)
  strict private
    FCustomer_email: string;
    FOrder_number: string;
    FCode: string;
    FValue: double;
    FDescription: string;
    FMax_split_transaction: int64;
    FAvailable_payment_methods: TListFormasDePagamento;
    FNew_checkout: Boolean;
    FUse_cards: Boolean;
  published
    property Customer_email: string read FCustomer_email write FCustomer_email;
    property Order_number: string read FOrder_number write FOrder_number;
    property Code: string read FCode write FCode;
    property Value: Double read FValue write FValue;
    property Description: string read FDescription write FDescription;
    property Max_split_transaction: int64 read FMax_split_transaction write FMax_split_transaction;
    property Available_payment_methods: TListFormasDePagamento read FAvailable_payment_methods write FAvailable_payment_methods;
    property New_checkout: Boolean read FNew_checkout write FNew_checkout;
    property Use_cards: Boolean read FUse_cards write FUse_cards;
  end;

  TYapayApiRespostaEnvioCobrancaV3ComSucesso = class(TYapayApiRespostaBaseComSucesso);

  TYapayApiEnvioCobrancaV3 = class(TYapayApiCobrancaBase<TYapayApiTabelaParametrosEnvioCobrancaV3,TYapayApiRespostaEnvioCobrancaV3ComSucesso>)
  strict protected
    function GetEndereco: string; override;
  public
    function Enviar: Boolean; override;
    constructor Create; override;
  end;
{$M-}

implementation

{ TYapayApiEnvioCobrancaV3 }

constructor TYapayApiEnvioCobrancaV3.Create;
begin
  inherited;
  FMetodo := TYapayApiCoreMetodo.Post;
end;

function TYapayApiEnvioCobrancaV3.Enviar: Boolean;
var
  sDecimalSeparator: Char;
begin
  FJSONRequest := TJSONObject.Create;
  try
    if TabelaParametros.Customer_email <> NullAsStringValue then
      FJSONRequest.AddPair('customer_email', TabelaParametros.Customer_email);

    if TabelaParametros.Order_number <> NullAsStringValue then
      FJSONRequest.AddPair('order_number', TabelaParametros.Order_number);

    if TabelaParametros.Code <> NullAsStringValue then
      FJSONRequest.AddPair('code', TabelaParametros.Code);

    if TabelaParametros.Value <> 0 then
    begin
      sDecimalSeparator := FormatSettings.DecimalSeparator;
      FormatSettings.DecimalSeparator := '.';
      FJSONRequest.AddPair('value', TabelaParametros.Value.ToString);
      FormatSettings.DecimalSeparator := sDecimalSeparator;
    end;

    if TabelaParametros.Description <> NullAsStringValue then
      FJSONRequest.AddPair('description', TabelaParametros.Description);

    if TabelaParametros.Max_split_transaction <> 0 then
      FJSONRequest.AddPair('max_split_transaction', TabelaParametros.Max_split_transaction.ToString);

    FJSONRequest.AddPair('available_payment_methods', TabelaParametros.Available_payment_methods.ToString);

    FJSONRequest.AddPair('new_checkout', BoolToStr(TabelaParametros.New_checkout, true).ToLower);

    FJSONRequest.AddPair('use_cards', BoolToStr(TabelaParametros.Use_cards, true).ToLower);

    Result := inherited;
  finally
    if Assigned(FJSONRequest) then
      FreeAndNil(FJSONRequest);
  end;
end;

function TYapayApiEnvioCobrancaV3.GetEndereco: string;
begin
  case Conexao.Ambiente of
    Sandbox: result := rsYAPAY_API_ENVIO_COBRANCA_V3_ENDERECO_SANDBOX;
    Producao: result := rsYAPAY_API_ENVIO_COBRANCA_V3_ENDERECO_PRODUCAO;
    else
    begin
      result := NullAsStringValue;
    end;
  end;
end;

end.
