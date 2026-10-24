unit untImplementationLinkPagamentoCitelSiTef;

interface

uses untInterfaceLinkPagamentoCitel, untClassesComumLinkPagamentoCitel,
     {$IFDEF LINUX}
     {$I '..\..\..\core\services.core.uses.inc'},
     {$ELSE}
       REST.Client,
     {$ENDIF}
     System.JSON;

type
  TPaymentClass = class
  private
    FAcquirer_id: String;
    FAcquirer_name: String;
    FAmount: String;
    FAuthorization_number: String;
    FAuthorizer_code: String;
    FAuthorizer_date: String;
    FAuthorizer_id: String;
    FAuthorizer_merchant_id: String;
    FAuthorizer_message: String;
    FCustomer_receipt: String;
    FEsitef_usn: String;
    FHost_usn: String;
    FIssuer: String;
    FMerchant_receipt: String;
    FMerchant_usn: String;
    FNit: String;
    FOrder_id: String;
    FPayment_date: String;
    FPayment_type: String;
    FSitef_usn: String;
    FStatus: String;
    FInstallments : String;
  public
    property acquirer_id: String read FAcquirer_id write FAcquirer_id;
    property acquirer_name: String read FAcquirer_name write FAcquirer_name;
    property amount: String read FAmount write FAmount;
    property authorization_number: String read FAuthorization_number write FAuthorization_number;
    property authorizer_code: String read FAuthorizer_code write FAuthorizer_code;
    property authorizer_date: String read FAuthorizer_date write FAuthorizer_date;
    property authorizer_id: String read FAuthorizer_id write FAuthorizer_id;
    property authorizer_merchant_id: String read FAuthorizer_merchant_id write FAuthorizer_merchant_id;
    property authorizer_message: String read FAuthorizer_message write FAuthorizer_message;
    property customer_receipt: String read FCustomer_receipt write FCustomer_receipt;
    property esitef_usn: String read FEsitef_usn write FEsitef_usn;
    property host_usn: String read FHost_usn write FHost_usn;
    property issuer: String read FIssuer write FIssuer;
    property merchant_receipt: String read FMerchant_receipt write FMerchant_receipt;
    property merchant_usn: String read FMerchant_usn write FMerchant_usn;
    property nit: String read FNit write FNit;
    property order_id: String read FOrder_id write FOrder_id;
    property payment_date: String read FPayment_date write FPayment_date;
    property payment_type: String read FPayment_type write FPayment_type;
    property sitef_usn: String read FSitef_usn write FSitef_usn;
    property status: String read FStatus write FStatus;
    property installments: String read FInstallments write FInstallments;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPaymentClass;
  end;

  TRootClass = class
  private
    FCode: String;
    FMessage: String;
    FPayment: TPaymentClass;
  public
    property code: String read FCode write FCode;
    property message: String read FMessage write FMessage;
    property payment: TPaymentClass read FPayment write FPayment;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TRootClass;
  end;

  TPgtOnESiTefResposta = class
  private
    FDescription: String;
    FNit: String;
    FNsuesitef: String;
    FResponseCode: Extended;
    FUrl: String;
  public
    property description: String read FDescription write FDescription;
    property nit: String read FNit write FNit;
    property nsuesitef: String read FNsuesitef write FNsuesitef;
    property responseCode: Extended read FResponseCode write FResponseCode;
    property url: String read FUrl write FUrl;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TPgtOnESiTefResposta;
  end;

  TAllowed_payment_methodsClass = class
  private
    FId: String;
  public
    property id: String read FId write FId;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TAllowed_payment_methodsClass;
  end;

  TAdditional_dataClass = class
  private
    FCurrency: String;
    FPostpone_confirmation: String;
    FAllowed_payment_methods: TArray<TAllowed_payment_methodsClass>;
  public
    property currency: String read FCurrency write FCurrency;
    property postpone_confirmation: String read FPostpone_confirmation write FPostpone_confirmation;
    property allowed_payment_methods: TArray<TAllowed_payment_methodsClass> read FAllowed_payment_methods write FAllowed_payment_methods;

    constructor Create(length: Integer); reintroduce;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TAdditional_dataClass;
  end;

  TEnvio = class
  private
    FMerchant_id: String;
    FMerchant_key: String;
    FRedirect: String;
    FInstallments: String;
    FInstallment_type: String;
    FMax_installments : String;
    FAmount : String;
    FTransaction_type: String;
    FAdditional_data: TAdditional_dataClass;
  public
    property merchant_id: String read FMerchant_id write FMerchant_id;
    property merchant_key: String read FMerchant_key write FMerchant_key;
    property redirect: String read FRedirect write FRedirect;
    property installments: String read FInstallments write FInstallments;
    property installment_type: String read FInstallment_type write FInstallment_type;
    property max_installments: String read FMax_installments write FMax_installments;
    property amount: String read FAmount write FAmount;
    property transaction_type: String read FTransaction_type write FTransaction_type;
    property additional_data: TAdditional_dataClass read FAdditional_data write FAdditional_data;
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
    class function FromJsonString(AJsonString: string): TEnvio;
  end;

  TLinkPagamentoCitelRepositorioSitef = class(TInterfacedObject, ILinkPagamentoCitelRepositorio)
  public
    function fGetMerchantId : String;
    function fGetMerchantKey : String;
    function fGetURL : String;
    function fGetChavePrivada : String ;
    function fGetChavePublica : String ;
    function fGetComprovanteCancLoja(const AstrNsu, AstrNit: String): String ;
    function fGetComprovanteCancCliente(const AstrNsu, AstrNit: String): String ;
    function fCondicaoPagamentoComLinkPagamento(const AstrCodCnd: String): Boolean ;
    class function New: ILinkPagamentoCitelRepositorio ;
  end ;

  TLinkPagamentoCitelFornecedorSitef = class(TInterfacedObject, ILinkPagamentoCitelFornecedor)
  public
    function fGetTipRec: String ;
    class function New: ILinkPagamentoCitelFornecedor ;
  end ;

  TLinkPagamentoSitef = class(TInterfacedObject, ILinkPagamentoCitel)
  private
    FstrNumDoc: String;
    FstrCodEmp: String;
    FstrCodCli: String;
    FstrEspDoc: String;
    FstrCodOpe: String;
    FstrSeqFgo: String;
    FstrJSONRequest: String;
    FstrJSONResponse: String;
    FstrResource: String;
    function fCreateEnvio(objEnvio: TEnvio): TJSONObject ;
    {$IFNDEF LINUX}
    function fGerarTokenCancelamento(const AstrNit,
                                           AstrMerchantId,
                                           AstrMerchantKey : String): String ;
    function fRetornaAgoraEmMilisegundos(): Int64 ;
    {$ENDIF}
  public
    class function New: ILinkPagamentoCitel ;

    function fGerarLinkPagamento(const AstrOperacao : String;
                                 const AintQtdParcelas : Integer;
                                 const AtpParcLoja : String;
                                 const AfltValPed : Double;
                                 var   AstrRetornoMsgErro: string;
                                 const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                 const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta ;

    function fExpirarLinkPagamento(const AstrId_link: String): Boolean ;

    function fConsultarTransacao(const AstrId_link: String; const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta ;

    function fCriarCancelamento(const AstrNsu, AstrId_link: String;
                                var   AstrJSONRet : String;
                                var AstrJSONReq : String): TJSONObject ;

    function fEfetuarCancelamento(const AstrId_linkCanc,
                                        AstrNumeroCartao,
                                        AstrVencCartao: String;
                                  var AstrJSONRet: String;
                                  var AstrJSONReq : String): TJSONObject ;

    function NumDoc: String ; overload ;
    function NumDoc(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function EspDoc: String ; overload ;
    function EspDoc(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodEmp: String ; overload ;
    function CodEmp(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodCli: String ; overload ;
    function CodCli(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function CodOpe: String ; overload ;
    function CodOpe(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function SeqFgo: String ; overload ;
    function SeqFgo(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function JSONRequest: String ; overload ;
    function JSONRequest(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function JSONResponse: String ; overload ;
    function JSONResponse(const AstrValue: String): ILinkPagamentoCitel ; overload ;
    function RequestResource: String ;
    function NomeFornecedorServico: String ;

    constructor Create;
  end ;

implementation

uses SysUtils, untRestApi, untLinkPagamentoCitelRestApi, REST.Types,
     untLinkPagamentoCitelRepositorio, DateUtils, Rest.Json,
     untFactoryLinkPagamentoCitel
     {$IFNDEF LINUX}
      ,untFuncoesSimples, untLibJWTUtil, Winapi.Windows
     {$ENDIF}
      ;

{TPgtOnESiTefResposta}

function TPgtOnESiTefResposta.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPgtOnESiTefResposta.FromJsonString(AJsonString: string): TPgtOnESiTefResposta;
begin
  result := TJson.JsonToObject<TPgtOnESiTefResposta>(AJsonString)
end;

{TEnvio}

constructor TEnvio.Create;
begin
  inherited;
  FAdditional_data := TAdditional_dataClass.Create(1);
end;

destructor TEnvio.Destroy;
begin
  FAdditional_data.free;
  inherited;
end;

function TEnvio.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TEnvio.FromJsonString(AJsonString: string): TEnvio;
begin
  result := TJson.JsonToObject<TEnvio>(AJsonString)
end;

{TAllowed_payment_methodsClass}

function TAllowed_payment_methodsClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TAllowed_payment_methodsClass.FromJsonString(AJsonString: string): TAllowed_payment_methodsClass;
begin
  result := TJson.JsonToObject<TAllowed_payment_methodsClass>(AJsonString)
end;

{TAdditional_dataClass}

constructor TAdditional_dataClass.Create(length: Integer);
  var
    i : Integer;
begin
  SetLength(FAllowed_payment_methods, length);

  for i := 0 to length -1 do
    allowed_payment_methods[i] := TAllowed_payment_methodsClass.Create();
end;

destructor TAdditional_dataClass.Destroy;
var
  Lallowed_payment_methodsItem: TAllowed_payment_methodsClass;
begin

 for Lallowed_payment_methodsItem in FAllowed_payment_methods do
   Lallowed_payment_methodsItem.free;

  inherited;
end;

function TAdditional_dataClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TAdditional_dataClass.FromJsonString(AJsonString: string): TAdditional_dataClass;
begin
  result := TJson.JsonToObject<TAdditional_dataClass>(AJsonString)
end;


{TPaymentClass}

function TPaymentClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPaymentClass.FromJsonString(AJsonString: string): TPaymentClass;
begin
  result := TJson.JsonToObject<TPaymentClass>(AJsonString)
end;

{TRootClass}

constructor TRootClass.Create;
begin
  inherited;
  FPayment := TPaymentClass.Create();
end;

destructor TRootClass.Destroy;
begin
  FPayment.free;
  inherited;
end;

function TRootClass.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TRootClass.FromJsonString(AJsonString: string): TRootClass;
begin
  result := TJson.JsonToObject<TRootClass>(AJsonString);
end;

{ TLinkPagamentoSitef }

function TLinkPagamentoSitef.CodCli(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrCodCli := AstrValue ;
end;

function TLinkPagamentoSitef.CodCli: String;
begin
  Result := FstrCodCli ;
end;

function TLinkPagamentoSitef.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TLinkPagamentoSitef.CodEmp(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrCodEmp := AstrValue ;
end;

function TLinkPagamentoSitef.CodOpe(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrCodOpe := AstrValue ;
end;

function TLinkPagamentoSitef.CodOpe: String;
begin
  Result := FstrCodOpe ;
end;

constructor TLinkPagamentoSitef.Create;
begin
  FstrNumDoc := '' ;
  FstrEspDoc := '' ;
  FstrCodEmp := '' ;
  FstrCodCli := '' ;
  FstrCodOpe := '' ;
  FstrSeqFgo := '' ;
  FstrJSONRequest := '' ;
  FstrJSONResponse := '' ;
  FstrResource := '';
end;

function TLinkPagamentoSitef.EspDoc: String;
begin
  Result := FstrEspDoc ;
end;

function TLinkPagamentoSitef.EspDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrEspDoc := AstrValue ;
end;

function TLinkPagamentoSitef.fConsultarTransacao(
  const AstrId_link: String;
  const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LobjRetornoConsulta: TRootClass ;
begin
  Result := Nil ;
  FstrJSONResponse := '';
  FstrJSONRequest := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  TControllerLinkPagamentoCitel.strNumNit := AstrId_link;
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'api/v1/transactions/'+AstrId_link;
    FstrResource := RestRequest.Resource;

    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    RestRequest.Params.AddItem('merchant_id', TLinkPagamentoCitelRepositorio.fGetMerchantId, pkHTTPHEADER);
    RestRequest.Params.AddItem('merchant_key', TLinkPagamentoCitelRepositorio.fGetMerchantKey, pkHTTPHEADER);

    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200']) then
    begin
      LobjRetornoConsulta := TRootClass.FromJsonString(FstrJSONResponse) ;
      try
        Result := TConsultaLinkPagamentoResposta.Create;
        Result.acquirer_id := LobjRetornoConsulta.payment.Acquirer_id ;
        Result.acquirer_name := LobjRetornoConsulta.payment.Acquirer_name;
        Result.amount := LobjRetornoConsulta.payment.Amount;
        Result.authorization_number := LobjRetornoConsulta.payment.Authorization_number;
        Result.authorizer_code := LobjRetornoConsulta.payment.Authorizer_code;
        Result.authorizer_date := LobjRetornoConsulta.payment.Authorizer_date;
        Result.authorizer_id := LobjRetornoConsulta.payment.Authorizer_id;
        Result.authorizer_merchant_id := LobjRetornoConsulta.payment.Authorizer_merchant_id;
        Result.authorizer_message := LobjRetornoConsulta.payment.Authorizer_message;
        Result.customer_receipt := LobjRetornoConsulta.payment.Customer_receipt;
        Result.esitef_usn := LobjRetornoConsulta.payment.Esitef_usn;
        Result.host_usn := LobjRetornoConsulta.payment.Host_usn;
        Result.issuer := LobjRetornoConsulta.payment.Issuer;
        Result.merchant_receipt := LobjRetornoConsulta.payment.Merchant_receipt;
        Result.merchant_usn := LobjRetornoConsulta.payment.Merchant_usn;
        Result.id_link := LobjRetornoConsulta.payment.nit;
        Result.order_id := LobjRetornoConsulta.payment.Order_id;
        Result.payment_date := LobjRetornoConsulta.payment.Payment_date;
        Result.payment_type := LobjRetornoConsulta.payment.Payment_type;
        Result.sitef_usn := LobjRetornoConsulta.payment.Sitef_usn;
        Result.status := LobjRetornoConsulta.payment.Status;
        Result.installments := LobjRetornoConsulta.payment.Installments;
      finally
        FreeAndNil(LobjRetornoConsulta) ;
      end ;
    end ;

  finally
    {$IFNDEF LINUX}
    RestRequest.Free;
    ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoSitef.fCreateEnvio(objEnvio: TEnvio): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
begin
  Result := nil;
  FstrJSONResponse := '';
  FstrJSONRequest := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'init/json.se';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    FstrJSONRequest := objEnvio.ToJsonString;

    RESTRequest.Params.AddItem('request', FstrJSONRequest, pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200','201']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

function TLinkPagamentoSitef.fCriarCancelamento(const AstrNsu, AstrId_link: String;
  var AstrJSONRet, AstrJSONReq: String): TJSONObject;
{$IFNDEF LINUX}
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LjsonBody: TJSONObject ;
  LstrToken: String ;
  LstrMerchantId: String ;
  LstrMerchantKey: String ;
{$ENDIF}
begin
  result := nil ;
  FstrJSONResponse := '';
  FstrJSONRequest := '';
  {$IFNDEF LINUX}
  LstrMerchantId := TLinkPagamentoCitelRepositorio.fGetMerchantId ;
  LstrMerchantKey := TLinkPagamentoCitelRepositorio.fGetMerchantKey ;
  LstrToken := fGerarTokenCancelamento(AstrId_link, LstrMerchantId, LstrMerchantKey) ;

  LControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  LjsonBody := TJSONObject.Create ;
  try
    LRestRequest.Resource := 'api/v1/cancellations';
    FstrResource := LRestRequest.Resource;
    LRestRequest.Method := rmPOST;

    LjsonBody.AddPair('esitef_usn', TJSONString.Create(AstrNsu)) ;
    FstrJSONRequest := LjsonBody.ToString ;

    LRestRequest.Params.Clear;
    LRestRequest.AddAuthParameter('Authorization','Bearer ' + LstrToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    LRestRequest.Params.AddHeader('merchant_id', LstrMerchantId);
    LRestRequest.Params.AddHeader('merchant_key', LstrMerchantKey);
    LRestRequest.ClearBody ;
    LRestRequest.AddBody(LjsonBody);

    if LControllerRest.fExecute(LRestRequest, FstrJSONResponse, ['200','201', '400']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;

  finally
    AstrJSONRet := FstrJSONResponse;
    AstrJSONReq := FstrJSONRequest;

    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
    FreeAndNil(LjsonBody) ;
  end;
  {$ENDIF}
end;

function TLinkPagamentoSitef.fEfetuarCancelamento(const AstrId_linkCanc,
  AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet,
  AstrJSONReq: String): TJSONObject;
{$IFNDEF LINUX}
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LjsonBody: TJSONObject ;
  LjsonCartao: TJSONObject ;
  LstrToken: String ;
  LstrMerchantId: String ;
  LstrMerchantKey: String ;
{$ENDIF}
begin
  result := nil ;
  FstrJSONResponse := '';
  FstrJSONRequest := '';
{$IFNDEF LINUX}
  LstrMerchantId := TLinkPagamentoCitelRepositorio.fGetMerchantId ;
  LstrMerchantKey := TLinkPagamentoCitelRepositorio.fGetMerchantKey ;
  LstrToken := fGerarTokenCancelamento(AstrId_linkCanc, LstrMerchantId, LstrMerchantKey) ;

  LControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  LjsonBody := TJSONObject.Create ;
  LjsonCartao := TJSONObject.Create ;
  try
    LRestRequest.Resource := 'api/v1/cancellations/'+AstrId_linkCanc;
    FstrResource := LRestRequest.Resource;
    LRestRequest.Method := rmPut;

    LjsonCartao.AddPair('number', TJSONString.Create(AstrNumeroCartao)) ;
    LjsonCartao.AddPair('expiry_date', TJSONString.Create(AstrVencCartao)) ;

    LjsonBody.AddPair('card', LjsonCartao) ;
    FstrJSONRequest := LjsonBody.ToString ;

    LRestRequest.Params.Clear;
    LRestRequest.AddAuthParameter('Authorization','Bearer ' + LstrToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    LRestRequest.Params.AddHeader('merchant_id', LstrMerchantId);
    LRestRequest.Params.AddHeader('merchant_key', LstrMerchantKey);
    LRestRequest.ClearBody ;
    LRestRequest.AddBody(LjsonBody);

    if LControllerRest.fExecute(LRestRequest, FstrJSONResponse, ['200','201', '400']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;

  finally
    AstrJSONRet := FstrJSONResponse;
    AstrJSONReq := FstrJSONRequest;

    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
    FreeAndNil(LjsonBody) ;
  end;
{$ENDIF}
end;

function TLinkPagamentoSitef.fExpirarLinkPagamento(
  const AstrId_link: String): Boolean;
begin
  Result := True ;
end;

function TLinkPagamentoSitef.fGerarLinkPagamento(const AstrOperacao: String;
  const AintQtdParcelas: Integer; const AtpParcLoja: String;
  const AfltValPed: Double;
  var AstrRetornoMsgErro: string;
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta;
var
  objEnvio : TEnvio;
  LjsonResposta: TJSONObject;
  LobjSitef: TPgtOnESiTefResposta;
begin
  Result := nil;
  try
    objEnvio := TEnvio.Create;

    objEnvio.Merchant_id := TLinkPagamentoCitelRepositorio.fGetMerchantId;
    objEnvio.Merchant_key := TLinkPagamentoCitelRepositorio.fGetMerchantKey;
    objEnvio.Redirect := 'M';
    objEnvio.Amount := FloatToStr(AfltValPed * 100);
    objEnvio.Installment_type := AtpParcLoja;
    objEnvio.Installments := IntToStr(AintQtdParcelas);
    objEnvio.Max_installments := IntToStr(AintQtdParcelas);
    objEnvio.Transaction_type := 'payment';
    objEnvio.Additional_data.Currency := 'BRL';
    // link de pagamento será sempre crédito
    objEnvio.Additional_data.Allowed_payment_methods[0].Id := 'CRD' ;

    if fCfgSis('TIPCON', varString) = 'T' then
      objEnvio.Additional_data.postpone_confirmation := 'true'
    else
      objEnvio.Additional_data.postpone_confirmation := 'false';

    LjsonResposta := fCreateEnvio(objEnvio) ;

    if Assigned(LjsonResposta) then
    begin
      try
        LobjSitef := TPgtOnESiTefResposta.FromJsonString(LjsonResposta.ToString) ;
        try
          Result := TGerarLinkPagamentoResposta.Create;
          Result.Descricao := LobjSitef.description ;
          Result.IdLink := LobjSitef.nit ;
          Result.Nsu := LobjSitef.nsuesitef ;
          Result.Url := LobjSitef.url ;
          Result.CodigoRetorno := LobjSitef.responseCode ;
        finally
          FreeAndNil(LobjSitef) ;
        end ;
      finally
        FreeAndNil(LjsonResposta) ;
      end ;
    end ;

    AstrRetornoMsgErro := FstrJSONResponse ;
  finally
    FreeAndNil(objEnvio);
  end;
end;

{$IFNDEF LINUX}
function TLinkPagamentoSitef.fGerarTokenCancelamento(const AstrNit,
  AstrMerchantId, AstrMerchantKey: String): String;
var
  LstrTimesTamp: String ;
  LjsonPayLoad: TJsonObject ;
  LstrChavePrivada, LstrChavePublica: String ;
begin
  LstrTimesTamp := IntToStr(fRetornaAgoraEmMilisegundos) ;
  LstrChavePrivada := fDescriptografarAes256(TLinkPagamentoCitelRepositorio.fGetChavePrivada) ;
  LstrChavePublica := TLinkPagamentoCitelRepositorio.fGetChavePublica ;

  LjsonPayLoad := TJsonObject.Create ;
  try
    LjsonPayLoad.AddPair('timestamp', TJSONString.Create(LstrTimesTamp)) ;
    LjsonPayLoad.AddPair('merchant_id', TJSONString.Create(AstrMerchantId)) ;
    LjsonPayLoad.AddPair('merchant_key', TJSONString.Create(AstrMerchantKey)) ;
    LjsonPayLoad.AddPair('nit', TJSONString.Create(AstrNit)) ;

    Result := fGerarTokenRS256(LjsonPayLoad, LstrChavePrivada, LstrChavePublica) ;

  finally
    FreeAndNil(LjsonPayLoad) ;
  end ;
end;

function TLinkPagamentoSitef.fRetornaAgoraEmMilisegundos: Int64;
var
  LSistemaTempo: SystemTime;
  LdtaData: TDateTime;
begin
  GetSystemTime(LSistemaTempo);
  LdtaData := EncodeDate(LSistemaTempo.wYear, LSistemaTempo.wMonth, LSistemaTempo.wDay) +
              EncodeTime(LSistemaTempo.wHour, LSistemaTempo.wMinute, LSistemaTempo.wSecond, LSistemaTempo.wMilliseconds);
  Result := MilliSecondsBetween(LdtaData, UnixDateDelta);
end;
{$ENDIF}

function TLinkPagamentoSitef.JSONRequest: String;
begin
  Result := FstrJSONRequest ;
end;

function TLinkPagamentoSitef.JSONRequest(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrJSONRequest := AstrValue ;
end;

function TLinkPagamentoSitef.JSONResponse: String;
begin
  Result := FstrJSONResponse ;
end;

function TLinkPagamentoSitef.JSONResponse(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrJSONResponse := AstrValue ;
end;

function TLinkPagamentoSitef.NomeFornecedorServico: String;
begin
  Result := 'SiTef';
end;

class function TLinkPagamentoSitef.New: ILinkPagamentoCitel;
begin
  Result := Self.Create ;
end;

function TLinkPagamentoSitef.NumDoc: String;
begin
  Result := FstrNumDoc ;
end;

function TLinkPagamentoSitef.NumDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrNumDoc := AstrValue ;
end;

function TLinkPagamentoSitef.RequestResource: String;
begin
  Result := FstrResource;
end;

function TLinkPagamentoSitef.SeqFgo(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  Result := Self ;
  FstrSeqFgo := AstrValue ;
end;

function TLinkPagamentoSitef.SeqFgo: String;
begin
  Result := FstrSeqFgo ;
end;

{ TLinkPagamentoCitelRepositorioSitef }

function TLinkPagamentoCitelRepositorioSitef.fCondicaoPagamentoComLinkPagamento(
  const AstrCodCnd: String): Boolean;
begin
  Result := fCampoTabela('CND_GERLNK', 'CADCND', ['CND_CODIGO'], [AstrCodCnd], True) = 'S' ;
end;

function TLinkPagamentoCitelRepositorioSitef.fGetChavePrivada: String;
begin
  Result := fCampoTabela('RSA_CHVPRV', 'LNKRSA', ['RSA_CODEMP'], [VS_strCodEmp]);
end;

function TLinkPagamentoCitelRepositorioSitef.fGetChavePublica: String;
begin
  Result := fCampoTabela('RSA_CHVPUB', 'LNKRSA', ['RSA_CODEMP'], [VS_strCodEmp]);
end;

function TLinkPagamentoCitelRepositorioSitef.fGetComprovanteCancCliente(
  const AstrNsu, AstrNit: String): String;
begin
  Result := fCampoTabela('SIT_CPCEST', 'SITCOB', ['SIT_NUMNSU', 'SIT_NUMNIT'], [AstrNsu, AstrNit]) ;
end;

function TLinkPagamentoCitelRepositorioSitef.fGetComprovanteCancLoja(
  const AstrNsu, AstrNit: String): String;
begin
  Result := fCampoTabela('SIT_CPLEST', 'SITCOB', ['SIT_NUMNSU', 'SIT_NUMNIT'], [AstrNsu, AstrNit]) ;
end;

function TLinkPagamentoCitelRepositorioSitef.fGetMerchantId: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_MIPSIT']);
end;

function TLinkPagamentoCitelRepositorioSitef.fGetMerchantKey: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_MKPSIT']);
end;

function TLinkPagamentoCitelRepositorioSitef.fGetURL: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLSIT']);
end;

class function TLinkPagamentoCitelRepositorioSitef.New: ILinkPagamentoCitelRepositorio;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCitelFornecedorSitef }

function TLinkPagamentoCitelFornecedorSitef.fGetTipRec: String;
begin
  Result := LinkPagamentoCitelFornecedores[pcSitef] ;
end;

class function TLinkPagamentoCitelFornecedorSitef.New: ILinkPagamentoCitelFornecedor;
begin
  Result := Self.Create ;
end;

end.
