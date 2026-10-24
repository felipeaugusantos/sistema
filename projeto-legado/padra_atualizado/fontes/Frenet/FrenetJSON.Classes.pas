unit FrenetJSON.Classes;

interface

uses
  System.Generics.Collections, REST.Json, UniClientDataSet, Uni, Data.DB,
  System.SysUtils, untFuncFat;

{$M+}

type

  TShippingItem = class
  private
    FQuantity : string;
    FWeight   : string;
    FLength   : string;
    FHeight   : string;
    FWidth    : string;
    FSKU      : String;
  public
    property Quantity: string read FQuantity write FQuantity;
    property Weight  : string read FWeight   write FWeight;
    property Length  : string read FLength   write FLength;
    property Height  : string read FHeight   write FHeight;
    property Width   : string read FWidth    write FWidth ;
    property SKU     : string read FSKU      write FSKU;

    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
  end;

  TRoot = class
  private
    FShippingItemArray    : TArray<TShippingItem>;
    FRecipientCEP         : string;
    FSellerCEP            : string;
    FShipmentInvoiceValue : string;
  public
    property ShippingItemArray    : TArray<TShippingItem> read FShippingItemArray    write FShippingItemArray;
    property RecipientCEP         : string                read FRecipientCEP         write FRecipientCEP;
    property SellerCEP            : string                read FSellerCEP            write FSellerCEP;
    property ShipmentInvoiceValue : string                read FShipmentInvoiceValue write FShipmentInvoiceValue;

    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
  end;

  TShippingSevices = class
  private
    FCarrier            : string;
    FCarrierCode        : string;
    FDeliveryTime       : string;
    FServiceDescription : string;
    FShippingPrice      : string;
    FMsg                : string;
    FError              : Boolean;
    FServiceCode        : string;
  published
    property Carrier            : string  read FCarrier            write FCarrier;
    property CarrierCode        : string  read FCarrierCode        write FCarrierCode;
    property ServiceCode        : string  read FServiceCode        write FServiceCode;
    property DeliveryTime       : string  read FDeliveryTime       write FDeliveryTime;
    property ServiceDescription : string  read FServiceDescription write FServiceDescription;
    property ShippingPrice      : string  read FShippingPrice      write FShippingPrice;
    property Msg                : string  read FMsg                write FMsg;
    property Error              : Boolean read FError              write FError;

    class function FromJsonString(AJsonString: string): TShippingSevices;
  end;

  TRootServices = class
  private
    FShippingSevicesArray   : TArray<TShippingSevices>;
  public
    property ShippingSevicesArray  : TArray<TShippingSevices> read FShippingSevicesArray    write FShippingSevicesArray;

    class function FromJsonString(AJsonString: string): TRootServices;
  end;

  TFrenetJSONBuilder = class
  private
    FQuery               : TUniQuery;
    FCEPOrigem           : String;
    FCEPDestino          : String;
    FValorDaVenda        : String;
    FcdsItens            : TUniClientDataSet;

    function fValidarDimensoes(var AstrMensagemValidacao : String) : Boolean;
    procedure pInstanciarArrayDosItens(var AobjRoot : TRoot);
  public
    fatVenda : TFatVenda;

    constructor Create;
    destructor Destroy; override;
    function fGerarJSONParaEnvioPedidoFrete(var AstrJSON : String; var AstrMensagemValidacao : String) : Boolean;

    property CEPOrigem    : String             read FCEPOrigem    write FCEPOrigem;
    property CEPDestino   : String             read FCEPDestino   write FCEPDestino;
    property cdsItens     : TUniClientDataSet  read FcdsItens     write FcdsItens;
    property ValorDaVenda : String             read FValorDaVenda write FValorDaVenda;
  end;

implementation

uses untFuncoesSimples;

{ TRoot }

constructor TRoot.Create;
begin
  inherited;
end;

destructor TRoot.Destroy;
begin
  inherited;
end;

function TRoot.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ ShippingItem }

constructor TShippingItem.Create;
begin
  inherited;
end;

destructor TShippingItem.Destroy;
begin
  inherited;
end;

function TShippingItem.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

{ TFrenetJSONBuilder }

constructor TFrenetJSONBuilder.Create;
begin
  FQuery := fCriaQuery(nil);

  FcdsItens := TUniClientDataSet.Create(nil);

  FcdsItens.FieldDefs.Add('ITE_CODIGO', ftString, 8);
  FcdsItens.FieldDefs.Add('ITE_PESO__', ftString, 12);
  FcdsItens.FieldDefs.Add('ITE_LARGUR', ftString, 12);
  FcdsItens.FieldDefs.Add('ITE_ALTURA', ftString, 12);
  FcdsItens.FieldDefs.Add('ITE_COMPRI', ftString, 12);
  FcdsItens.FieldDefs.Add('ITE_QUANTI', ftString, 12);

  FcdsItens.CreateDataSet;
  FcdsItens.Open;
end;

destructor TFrenetJSONBuilder.Destroy;
begin
  FreeAndNil(FQuery);
  FreeAndNil(FcdsItens);
  inherited;
end;

function TFrenetJSONBuilder.fGerarJSONParaEnvioPedidoFrete(var AstrJSON : String; var AstrMensagemValidacao : String) : Boolean;
  var
    LObjRoot : TRoot;
begin
  Result := True;

  if not fValidarDimensoes(AstrMensagemValidacao) then
    Exit(False);

  LObjRoot                      := TRoot.Create;
  LObjRoot.RecipientCEP         := FCEPDestino;
  LObjRoot.SellerCEP            := FCEPOrigem;
  LObjRoot.ShipmentInvoiceValue := FValorDaVenda;

  pInstanciarArrayDosItens(LObjRoot);

  AstrJSON := LObjRoot.ToJsonString;
end;

function TFrenetJSONBuilder.fValidarDimensoes(var AstrMensagemValidacao : String) : Boolean;
begin
  Result := True;

  FcdsItens.First;
  while not FcdsItens.Eof do
  Begin
    if StrToFloat(StringReplace(FcdsItens.FieldByName('ITE_PESO__').AsString, '.', ',', [rfReplaceAll])) <= 0 then
    Begin
      AstrMensagemValidacao := 'Produto "'+ FcdsItens.FieldByName('ITE_CODIGO').AsString +'" com peso bruto zerado. '+
      'Favor revisar este e os demais na aba E-COMMERCE do Cadastro de Produtos.';
      Exit(False);
    End;

    if StrToFloat(StringReplace(FcdsItens.FieldByName('ITE_LARGUR').AsString, '.', ',', [rfReplaceAll])) <= 0 then
    Begin
      AstrMensagemValidacao := 'Produto "'+ FcdsItens.FieldByName('ITE_CODIGO').AsString +'" com largura zerada. '+
      'Favor revisar este e os demais na aba E-COMMERCE do Cadastro de Produtos.';
      Exit(False);
    End;

    if StrToFloat(StringReplace(FcdsItens.FieldByName('ITE_ALTURA').AsString, '.', ',', [rfReplaceAll])) <= 0 then
    Begin
      AstrMensagemValidacao := 'Produto "'+ FcdsItens.FieldByName('ITE_CODIGO').AsString +'" com altura zerada. '+
      'Favor revisar este e os demais na aba E-COMMERCE do Cadastro de Produtos.';
      Exit(False);
    End;

    if StrToFloat(StringReplace(FcdsItens.FieldByName('ITE_COMPRI').AsString, '.', ',', [rfReplaceAll])) <= 0 then
    Begin
      AstrMensagemValidacao := 'Produto "'+ FcdsItens.FieldByName('ITE_CODIGO').AsString +'" com profundidade zerada. '+
      'Favor revisar este e os demais na aba E-COMMERCE do Cadastro de Produtos.';
      Exit(False);
    End;

    FcdsItens.Next;
  End;

end;

procedure TFrenetJSONBuilder.pInstanciarArrayDosItens(var AobjRoot: TRoot);
  var
    LObjItem : TShippingItem;
begin

  FcdsItens.First;
  while not FcdsItens.Eof do
  Begin
    LObjItem          := TShippingItem.Create;
    LObjItem.Quantity := FcdsItens.FieldByName('ITE_QUANTI').AsString;
    LObjItem.Weight   := FcdsItens.FieldByName('ITE_PESO__').AsString;
    LObjItem.Length   := FcdsItens.FieldByName('ITE_COMPRI').AsString;
    LObjItem.Height   := FcdsItens.FieldByName('ITE_ALTURA').AsString;
    LObjItem.Width    := FcdsItens.FieldByName('ITE_LARGUR').AsString;
    LObjItem.SKU      := FcdsItens.FieldByName('ITE_CODIGO').AsString;

    SetLength(AobjRoot.FShippingItemArray, Length(AobjRoot.FShippingItemArray) + 1);
    AobjRoot.FShippingItemArray[High(AobjRoot.FShippingItemArray)] := LObjItem;

    FcdsItens.next;
  End;

end;

{ TShippingSevices }

class function TShippingSevices.FromJsonString(AJsonString: string): TShippingSevices;
begin
  result := TJson.JsonToObject<TShippingSevices>(AJsonString)
end;

{ TRootServices }

class function TRootServices.FromJsonString(AJsonString: string): TRootServices;
begin
  result := TJson.JsonToObject<TRootServices>(AJsonString)
end;

end.
