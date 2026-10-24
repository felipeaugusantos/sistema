unit untPgtOnlineESiTefEnvio;

interface

uses Generics.Collections, Rest.Json, sysUtils, System.JSON, strUtils,
     REST.Types, REST.Client, Data.DB, MemDS, DBAccess, Uni, Forms,
     untPaiSimples, System.Classes;

type
  //======================= OBJETOS DE ENVIO =======================//
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

  //======================= OBJETOS DE RETORNO =======================//

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

  //======================= OBJETOS DE CONTROLE =======================//
  TPgtOnESiTefEnvio = class
    private
      FNumDoc : String;
      FEspDoc : String;
      FCodCli : String;
      FCodOpe : String;
      FCodEmp : String;
      FSeqFgo : String;
      FJSONRequest : String;
      FJSONResponse : String;
      FFormMsg : TfrmPaiSimples;

      function fCreateEnvio(objEnvio: TEnvio; var strJSONRet : String;
        var strJSONReq : String): TPgtOnESiTefResposta;
      function fGerarTokenCancelamento(const AstrNit, AstrMerchantId, AstrMerchantKey : String): String ;
      procedure pMostraErrorGettingServerCertificate;
      procedure pClickBotao(Sender: TObject);
      procedure pClickLabel(Sender: TObject);
      function fRetornaAgoraEmMilisegundos(): Int64 ;
    public
      function fGerarLinkPagamento(strOperacao : String; intQtdParcelas : Integer;
        tpParcLoja : String; fltValPed : Double; var AstrRetornoMsgErro: string) : TPgtOnESiTefResposta;

      function fCriarNovaTransacao(strCodEmp, strUrlPgt, strNumNit, strNumNsu,
        strCodOpe : String; dtaDtaCad : TDate; hraHraCad : TTime; fltValTra : Double;
        strSeqFgo : String; intQtdParcelas : Integer; strTipLan, strAutoIncs: String) : Boolean;

      function fCriarCancelamento(const AstrNsu, AstrNit: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject ;
      function fEfetuarCancelamento(const AstrNitCanc, AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject ;

      property strNumDoc : String read FNumDoc write FNumDoc;
      property strEspDoc : String read FEspDoc write FEspDoc;
      property strCodCli : String read FCodCli write FCodCli;
      property strCodOpe : String read FCodOpe write FCodOpe;
      property strCodEmp : String read FCodEmp write FCodEmp;
      property strSeqFgo : String read FSeqFgo write FSeqFgo;
      property strJSONRequest : String read FJSONRequest write FJSONRequest;
      property strJSONResponse : String read FJSONResponse write FJSONResponse;
  end;

implementation

uses
  untRestApi, untPgtOnlineESiTefRestApi, untPgtOnlineESiTefRepositorio,
  untFuncoesSimples, untPgtOnlineESiTefModel, untPgtOnlineESiTefStatus,
  BitBtnLockedIncrem, Vcl.Controls, ShellApi, Vcl.StdCtrls, Vcl.Graphics,
  DateUtils, Winapi.Windows, untLibJWTUtil;

const
  msgErrorGettingServerCertificate = 'REST request failed: Error getting Server Certificate';

{TPgtOnESiTefResposta}

function TPgtOnESiTefResposta.ToJsonString: string;
begin
  result := TJson.ObjectToJsonString(self);
end;

class function TPgtOnESiTefResposta.FromJsonString(AJsonString: string): TPgtOnESiTefResposta;
begin
  result := TJson.JsonToObject<TPgtOnESiTefResposta>(AJsonString)
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

{ TPgtOnESiTefEnvio }

function TPgtOnESiTefEnvio.fGerarLinkPagamento(strOperacao : String; intQtdParcelas : Integer;
  tpParcLoja : String; fltValPed : Double; var AstrRetornoMsgErro: string) : TPgtOnESiTefResposta;
var
  objEnvio : TEnvio;
begin

  try
    objEnvio := TEnvio.Create;
    Result := TPgtOnESiTefResposta.Create;

    objEnvio.FMerchant_id := TPgtOnlineESiTefRepositorio.fGetMerchantId;
    objEnvio.FMerchant_key := TPgtOnlineESiTefRepositorio.fGetMerchantKey;
    objEnvio.FRedirect := 'M';
    objEnvio.FAmount := FloatToStr(fltValPed * 100);
    objEnvio.FInstallment_type := tpParcLoja;
    objEnvio.FInstallments := IntToStr(intQtdParcelas);
    objEnvio.FMax_installments := IntToStr(intQtdParcelas);
    objEnvio.FTransaction_type := 'payment';
    objEnvio.FAdditional_data.FCurrency := 'BRL';
    // link de pagamento será sempre crédito
    objEnvio.FAdditional_data.FAllowed_payment_methods[0].FId := 'CRD' ;

    if fCfgSis('TIPCON', varString) = 'T' then
      objEnvio.FAdditional_data.postpone_confirmation := 'true'
    else
      objEnvio.FAdditional_data.postpone_confirmation := 'false';

    Result := fCreateEnvio(objEnvio,  FJSONResponse, FJSONRequest);
    AstrRetornoMsgErro := FJSONResponse ;
  finally
    FreeAndNil(objEnvio);
  end;
end;

function TPgtOnESiTefEnvio.fGerarTokenCancelamento(
  const AstrNit, AstrMerchantId, AstrMerchantKey: String): String;
var
  LstrTimesTamp: String ;
  LjsonPayLoad: TJsonObject ;
  LstrChavePrivada, LstrChavePublica: String ;
begin
  LstrTimesTamp := IntToStr(fRetornaAgoraEmMilisegundos) ;
  LstrChavePrivada := fDescriptografarAes256(TPgtOnlineESiTefRepositorio.fGetChavePrivada) ;
  LstrChavePublica := TPgtOnlineESiTefRepositorio.fGetChavePublica ;

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

function TPgtOnESiTefEnvio.fRetornaAgoraEmMilisegundos: Int64;
var
  LSistemaTempo: SystemTime;
  LdtaData: TDateTime;
begin
  GetSystemTime(LSistemaTempo);
  LdtaData := EncodeDate(LSistemaTempo.wYear, LSistemaTempo.wMonth, LSistemaTempo.wDay) +
              EncodeTime(LSistemaTempo.wHour, LSistemaTempo.wMinute, LSistemaTempo.wSecond, LSistemaTempo.wMilliseconds);
  Result := MilliSecondsBetween(LdtaData, UnixDateDelta);
end;

function TPgtOnESiTefEnvio.fCreateEnvio(objEnvio: TEnvio;
  var strJSONRet : String; var strJSONReq : String): TPgtOnESiTefResposta;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('ESIT', TControllerESiTef.fConfigurarESiTef);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'init/json.se';
    RestRequest.Method := rmPOST;

    strJSONReq := objEnvio.ToJsonString;

    RESTRequest.Params.AddItem('request', strJSONReq, pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, strJSONRet, ['200','201']) then
      Result := TPgtOnESiTefResposta.FromJsonString(strJSONRet)
    else
    begin
      if strJSONRet = msgErrorGettingServerCertificate then
        pMostraErrorGettingServerCertificate;
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

function TPgtOnESiTefEnvio.fCriarCancelamento(const AstrNsu,
  AstrNit: String; var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LjsonBody: TJSONObject ;
  LstrToken: String ;
  LstrMerchantId: String ;
  LstrMerchantKey: String ;
begin
  result := nil ;
  LstrMerchantId := TPgtOnlineESiTefRepositorio.fGetMerchantId ;
  LstrMerchantKey := TPgtOnlineESiTefRepositorio.fGetMerchantKey ;
  LstrToken := fGerarTokenCancelamento(AstrNit, LstrMerchantId, LstrMerchantKey) ;

  LControllerRest := TControllerRest.Create('ESIT', TControllerESiTef.fConfigurarESiTef);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  LjsonBody := TJSONObject.Create ;
  try
    LRestRequest.Resource := 'api/v1/cancellations';
    LRestRequest.Method := rmPOST;

    LjsonBody.AddPair('esitef_usn', TJSONString.Create(AstrNsu)) ;
    AstrJSONReq := LjsonBody.ToString ;

    LRestRequest.Params.Clear;
    LRestRequest.AddAuthParameter('Authorization','Bearer ' + LstrToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    LRestRequest.Params.AddHeader('merchant_id', LstrMerchantId);
    LRestRequest.Params.AddHeader('merchant_key', LstrMerchantKey);
    LRestRequest.ClearBody ;
    LRestRequest.AddBody(LjsonBody);

    if LControllerRest.fExecute(LRestRequest, AstrJSONRet, ['200','201', '400']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AstrJSONRet), 0) as TJSONObject
    else
    begin
      if AstrJSONRet = msgErrorGettingServerCertificate then
        pMostraErrorGettingServerCertificate;
    end;

  finally
    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
    FreeAndNil(LjsonBody) ;
  end;
end;

function TPgtOnESiTefEnvio.fCriarNovaTransacao(strCodEmp, strUrlPgt, strNumNit,
                                               strNumNsu, strCodOpe : String;
                                               dtaDtaCad : TDate; hraHraCad : TTime;
                                               fltValTra : Double; strSeqFgo : String;
                                               intQtdParcelas : Integer;
                                               strTipLan, strAutoIncs: String) : Boolean;
begin
  Result := TPgtOnESiTefModel.fNovaTransacao(strCodEmp, strUrlPgt, strNumNit,
                                             strNumNsu, strCodOpe, dtaDtaCad,
                                             hraHraCad, stTransacaoRecente,
                                             TPgtOnlineESiTefRepositorio.fGetMerchantId,
                                             fltValTra, strSeqFgo, FJSONRequest,
                                             FJSONResponse, intQtdParcelas, strTipLan,
                                             strAutoIncs);
end;

function TPgtOnESiTefEnvio.fEfetuarCancelamento(const AstrNitCanc, AstrNumeroCartao, AstrVencCartao: String;
                                                var AstrJSONRet : String; var AstrJSONReq : String): TJSONObject;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LjsonBody: TJSONObject ;
  LjsonCartao: TJSONObject ;
  LstrToken: String ;
  LstrMerchantId: String ;
  LstrMerchantKey: String ;
begin
  result := nil ;
  LstrMerchantId := TPgtOnlineESiTefRepositorio.fGetMerchantId ;
  LstrMerchantKey := TPgtOnlineESiTefRepositorio.fGetMerchantKey ;
  LstrToken := fGerarTokenCancelamento(AstrNitCanc, LstrMerchantId, LstrMerchantKey) ;

  LControllerRest := TControllerRest.Create('ESIT', TControllerESiTef.fConfigurarESiTef);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  LjsonBody := TJSONObject.Create ;
  LjsonCartao := TJSONObject.Create ;
  try
    LRestRequest.Resource := 'api/v1/cancellations/'+AstrNitCanc;
    LRestRequest.Method := rmPut;

    LjsonCartao.AddPair('number', TJSONString.Create(AstrNumeroCartao)) ;
    LjsonCartao.AddPair('expiry_date', TJSONString.Create(AstrVencCartao)) ;

    LjsonBody.AddPair('card', LjsonCartao) ;
    AstrJSONReq := LjsonBody.ToString ;

    LRestRequest.Params.Clear;
    LRestRequest.AddAuthParameter('Authorization','Bearer ' + LstrToken, TRESTRequestParameterKind.pkHTTPHEADER, [poDoNotEncode]);
    LRestRequest.Params.AddHeader('merchant_id', LstrMerchantId);
    LRestRequest.Params.AddHeader('merchant_key', LstrMerchantKey);
    LRestRequest.ClearBody ;
    LRestRequest.AddBody(LjsonBody);

    if LControllerRest.fExecute(LRestRequest, AstrJSONRet, ['200','201', '400']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AstrJSONRet), 0) as TJSONObject
    else
    begin
      if AstrJSONRet = msgErrorGettingServerCertificate then
        pMostraErrorGettingServerCertificate;
    end;

  finally
    FreeAndNil(LRestRequest);
    FreeAndNil(LControllerRest);
    FreeAndNil(LjsonBody) ;
  end;
end;

procedure TPgtOnESiTefEnvio.pClickBotao(Sender: TObject);
begin
  FFormMsg.Close;
end;

procedure TPgtOnESiTefEnvio.pClickLabel(Sender: TObject);
begin
  pBrowserNavigate(PChar(TLabel(Sender).Caption));
end;

procedure TPgtOnESiTefEnvio.pMostraErrorGettingServerCertificate;
  const
    urlEasyFix = 'https://download.microsoft.com/download/0/6/5/0658B1A7-6D2E-474F-BC2C-D69E5B9E9A68/MicrosoftEasyFix51044.msi';
    msgInfo = 'Ocorreu um problema no envio do link de pagamento. '+
              'Uma possível solução para o problema pode '+
              'ser encontrada na seção de downloads, no endereço mencionado abaixo. '+
              'Após download e instalação, reiniciar o AUTCOM!';
  var
    btnOk : TBitBtnLocked;
    lblMsgInfo, lblMsgLink : TLabel;
begin
  pCriarFormularios(TfrmPaiSimples, FFormMsg);
  try
    FFormMsg.pgcDados.Visible := False;
    FFormMsg.Width := 800;
    FFormMsg.Height := 160;
    FFormMsg.Position := TPosition.poDesktopCenter;
    FFormMsg.Caption := 'Aviso';

    lblMsgInfo                  := TLabel.Create(FFormMsg);
    lblMsgInfo.Parent           := FFormMsg;
    lblMsgInfo.AlignWithMargins := True;
    lblMsgInfo.AutoSize         := True;
    lblMsgInfo.Font.Size        := 12;
    lblMsgInfo.Align            := TAlign.alTop;
    lblMsgInfo.Alignment        := TAlignment.taCenter;
    lblMsgInfo.WordWrap         := True;
    lblMsgInfo.Caption          := msgInfo;

    lblMsgLink                  := TLabel.Create(FFormMsg);
    lblMsgLink.Parent           := FFormMsg;
    lblMsgLink.AlignWithMargins := True;
    lblMsgLink.AutoSize         := True;
    lblMsgLink.Font.Size        := 10;
    lblMsgLink.Align            := TAlign.alBottom;
    lblMsgLink.Alignment        := TAlignment.taCenter;
    lblMsgLink.WordWrap         := True;
    lblMsgLink.Caption          := urlEasyFix;
    lblMsgLink.OnClick          := pClickLabel;
    lblMsgLink.Font.Color       := clBlue;
    lblMsgLink.Font.Style       := [fsUnderline];
    lblMsgLink.Cursor           := crHandPoint;

    btnOk                       := TBitBtnLocked.Create(FFormMsg);
    btnOk.Parent                := FFormMsg;
    btnOk.Align                 := TAlign.alBottom;
    btnOk.AlignWithMargins      := True;
    btnOk.Margins.Top           := 15;
    btnOk.Margins.Right         := 250;
    btnOk.Margins.Left          := 250;
    btnOk.Caption               := 'OK';
    btnOk.Cursor                := crHandPoint;
    btnOk.OnClick               := pClickBotao;

    FFormMsg.ShowModal;
  finally
    pFreeAndNil(FFormMsg);
  end;
end;

end.

