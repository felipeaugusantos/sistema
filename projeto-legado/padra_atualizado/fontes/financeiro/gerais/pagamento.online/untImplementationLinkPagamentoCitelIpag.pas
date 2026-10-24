unit untImplementationLinkPagamentoCitelIpag;

interface

uses untInterfaceLinkPagamentoCitel, untClassesComumLinkPagamentoCitel,
     {$IFDEF LINUX}
     {$I '..\..\..\core\services.core.uses.inc'},
     {$ELSE}
       REST.Client,
     {$ENDIF}
     System.JSON, System.Classes, System.Generics.Collections;

const
  STATUS_ATIVO = 'CREATED' ;
  STATUS_EXPIRADO = 'EXPIRED' ;
  STATUS_CANCELADO = 'CANCELED' ;
  STATUS_PAGO = 'CAPTURED' ;
  STATUS_ESTORNADO = 'REVERSED' ;
  STATUS_NEGADO = 'DECLINED' ;

type
  TLinkPagamentoCitelBandeirasIpag = class(TInterfacedObject, ILinkPagamentoCitelBandeiras)
  public
    procedure pPreencheCombo(const AComboItens: TStrings) ;
    class function New: ILinkPagamentoCitelBandeiras ;
  end ;

  TLinkPagamentoCitelNormalizaTipoIpag = class(TInterfacedObject, ILinkPagamentoCitelNormalizaTipo)
  public
    function fTipo(const AstrTipo: String): String ;
    function fTipoAbreviado(const AstrTipo: String): String ;
    class function New: ILinkPagamentoCitelNormalizaTipo ;
  end;

  TLinkPagamentoCitelRepositorioIpag = class(TInterfacedObject, ILinkPagamentoCitelRepositorio)
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
    function fGetColunaAtivaLinkCadCnd: String ;
    function fGetURLToken: String ;
    function fGetInfoAdicional(const AChave: String): String ;
  end ;

  TLinkPagamentoCitelFornecedorIpag = class(TInterfacedObject, ILinkPagamentoCitelFornecedor)
  public
    function fGetTipRec: String ;
    class function New: ILinkPagamentoCitelFornecedor ;
  end ;

  TLinkPagamentoIpag = class(TInterfacedObject, ILinkPagamentoCitel)
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
    function fGetToken: String;
    function fAjustaDataHora(const AdtaDataHora: TDateTime): String ;
    function fCreateEnvio(AobjEnvio: TJSONObject; const AUpdateID: Integer = 0): TJSONObject ;
    function fGetCancelamentoTransacao(const AstrAccessToken, AstrOrdem: String): TJSONObject ;
    function fConsultaLink(const AstrAccessToken, AstrId_link: String): TJSONObject ;
    function fExpiraLinkInterno(const AstrAccessToken, AstrId_link: String): Boolean ;
    function fConverterParaDateTime(const AIsoDateStr: string): String;
    function fDefineTipoComBaseNoMetodo(const AStrmetodo: String): String;
  public
    class function New: ILinkPagamentoCitel ;

    function fGerarLinkPagamento(const AstrOperacao : String;
                                 const AintQtdParcelas : Integer;
                                 const AtpParcLoja : String;
                                 const AfltValPed : Double;
                                 var   AstrRetornoMsgErro: string;
                                 const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                 const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta ;

    function fConsultarTransacao(const AstrId_link: String;
                                 const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta ;

    function fExpirarLinkPagamento(const AstrId_link: String): Boolean ;

    function fCriarCancelamento(const AstrNsu, AstrId_link: String;
                                var   AstrJSONRet : String;
                                var AstrJSONReq : String): TJSONObject ;

    function fEfetuarCancelamento(const AstrId_linkCanc,
                                        AstrNumeroCartao,
                                        AstrVencCartao: String;
                                  var AstrJSONRet: String;
                                  var AstrJSONReq : String): TJSONObject ;

    function fPodeGerarNovoLinkComEmpresaLogada(const ACodEmpLink: String): Boolean ;
    function fGetUrlPagamento(const Ajson: TJSONObject): string;

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

uses SysUtils, DateUtils, untRestApi, REST.Types, untLinkPagamentoCitelRestApi,
     untLinkPagamentoCitelRepositorio, untFactoryLinkPagamentoCitel,
     System.NetEncoding, untFuncoesComumLinkPagamentoCitel
     {$IFNDEF LINUX}
     ,untFuncoesSimples
     {$ENDIF} ;

{ TLinkPagamentoCitelBandeirasIpag }

class function TLinkPagamentoCitelBandeirasIpag.New: ILinkPagamentoCitelBandeiras;
begin
  Result := Self.Create ;
end;

procedure TLinkPagamentoCitelBandeirasIpag.pPreencheCombo(
  const AComboItens: TStrings);
begin
  AComboItens.Clear;
  AComboItens.Add('VISA') ;
  AComboItens.Add('MASTERCARD') ;
  AComboItens.Add('AMEX') ;
  AComboItens.Add('ELO') ;
  AComboItens.Add('HIPERCARD') ;
  AComboItens.Add('DINERS') ;
  AComboItens.Add('VISAELECTRON') ;
  AComboItens.Add('MAESTRO') ;
  AComboItens.Add('ELO_DEBIT') ;
end;

{ TLinkPagamentoCitelNormalizaTipoIpag }

function TLinkPagamentoCitelNormalizaTipoIpag.fTipo(const AstrTipo: String): String;
const
  arrCredito: array[0..5] of String = (
    'visa',
    'mastercard',
    'amex',
    'elo',
    'hipercard',
    'diners');

  arrDebito: array[0..2] of String = (
    'visaelectron',
    'maestro',
    'elo_debit');
var
  lstrMetodo: String;
  i: Integer;
begin
  lstrMetodo := Trim(LowerCase(AstrTipo));

  for i := Low(arrCredito) to High(arrCredito) do
  begin
    if lstrMetodo = arrCredito[i] then
    begin
      Result := 'CARTÃO DE CRÉDITO';
      exit;
    end;
  end;

  for i := Low(arrDebito) to High(arrDebito) do
  begin
    if lstrMetodo = arrDebito[i] then
    begin
      Result := 'CARTÃO DE DÉBITO';
      exit;
    end;
  end;

  if lstrMetodo = 'pix' then
  begin
    Result := 'PIX';
    exit;
  end;

  if lstrMetodo = 'boleto' then
  begin
    Result := 'BOLETO';
    exit;
  end;

  Result := UpperCase(lstrMetodo);
end;

function TLinkPagamentoCitelNormalizaTipoIpag.fTipoAbreviado(
  const AstrTipo: String): String;
var
  LstrTipo: String ;
begin
  LstrTipo := trim(LowerCase(AstrTipo)) ;
  if LstrTipo = 'credit' then
    Result := 'C'
  else if LstrTipo = 'debit' then
    Result := 'D'
  else if LstrTipo = 'pix' then
    Result := 'P'
  else
    Result := 'C' ;
end;

class function TLinkPagamentoCitelNormalizaTipoIpag.New: ILinkPagamentoCitelNormalizaTipo;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCitelRepositorioIpag }

function TLinkPagamentoCitelRepositorioIpag.fCondicaoPagamentoComLinkPagamento(
  const AstrCodCnd: String): Boolean;
begin
  Result := fCampoTabela('CND_IPAGLK', 'CADCND', ['CND_CODIGO'], [AstrCodCnd], True) = 'S' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetChavePrivada: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetChavePublica: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetColunaAtivaLinkCadCnd: String;
begin
  Result := 'CND_IPAGLK' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetComprovanteCancCliente(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetComprovanteCancLoja(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioIpag.fGetInfoAdicional(
  const AChave: String): String;
begin
  {}
end;

function TLinkPagamentoCitelRepositorioIpag.fGetMerchantId: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_ID_IPG']);
end;

function TLinkPagamentoCitelRepositorioIpag.fGetMerchantKey: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SECIPG']);
end;

function TLinkPagamentoCitelRepositorioIpag.fGetURL: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLIPG']);
end;

function TLinkPagamentoCitelRepositorioIpag.fGetURLToken: String;
begin
{}
end;

class function TLinkPagamentoCitelRepositorioIpag.New: ILinkPagamentoCitelRepositorio;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCitelFornecedorIpag }

function TLinkPagamentoCitelFornecedorIpag.fGetTipRec: String;
begin
  Result := LinkPagamentoCitelFornecedores[pcIpag] ;
end;

class function TLinkPagamentoCitelFornecedorIpag.New: ILinkPagamentoCitelFornecedor;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoIpag }

function TLinkPagamentoIpag.CodCli(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodCli := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.CodCli: String;
begin
  Result := FstrCodCli ;
end;

function TLinkPagamentoIpag.CodEmp(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodEmp := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TLinkPagamentoIpag.CodOpe(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodOpe := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.CodOpe: String;
begin
  Result := FstrCodOpe ;
end;

constructor TLinkPagamentoIpag.Create;
begin
  FstrNumDoc := '';
  FstrCodEmp := '';
  FstrCodCli := '';
  FstrEspDoc := '';
  FstrCodOpe := '';
  FstrSeqFgo := '';
  FstrJSONRequest := '';
  FstrJSONResponse := '';
  FstrResource := '';
end;

function TLinkPagamentoIpag.EspDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrEspDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.EspDoc: String;
begin
  Result := FstrEspDoc ;
end;

function TLinkPagamentoIpag.fAjustaDataHora(
  const AdtaDataHora: TDateTime): String;
begin
  Result:= FormatDateTime('yyyy-mm-dd hh:nn:ss', AdtaDataHora);
end;

function TLinkPagamentoIpag.fConsultaLink(const AstrAccessToken,
  AstrId_link: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
begin
  Result := nil;
  FstrJSONRequest := '';
  FstrJSONResponse := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/service/v2/payment_links/'+AstrId_link;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Basic ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Basic ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}
    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200']) then
    begin
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject
    end
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          401: raise ExceptionLinkPgCredencialNaoAutorizada.Create('As credenciais configuradas no Autcom não tem permissão de acesso.');
          404: raise ExceptionLinkPgTransacaoNaoEncontrada.Create('Link de pagamento não encontrado.');
          else
            raise ExceptionLinkPg.Create('Erro ao consultar link de pagamento.');
        end;
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requsição para consultar link de pagamento.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoIpag.fConverterParaDateTime(
  const AIsoDateStr: String): String;
var
  lstrDataNormalizada: String;
  lformatSettings: TFormatSettings;
  lDataConvertida: TDateTime;

  function dataVazia: Boolean;
  begin
    Result := False;

    if Trim(AIsoDateStr) = '' then
      Result := True;
  end;
begin
  if dataVazia then
    raise Exception.Create('Data inválida.');

  lstrDataNormalizada := StringReplace(AIsoDateStr, 'T', ' ', []);
  lformatSettings := TFormatSettings.Create;
  lformatSettings.DateSeparator := '-';
  lformatSettings.TimeSeparator := ':';
  lformatSettings.ShortDateFormat := 'yyyy-MM-dd';
  lformatSettings.LongTimeFormat := 'hh:mm:ss';

  if not TryStrToDateTime(lstrDataNormalizada, lDataConvertida, lformatSettings) then
    raise Exception.Create('Formato de data inválido: ' + AIsoDateStr);

  Result:= FormatDateTime('dd"/"mm"/"yyyy hh":"nn":"ss', lDataConvertida);
end;

function TLinkPagamentoIpag.fConsultarTransacao(const AstrId_link: String;
  const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
var
  LstrAccessToken: String ;
  LjsonLink: TJSONObject ;
  LstrStatusTransacao: String;
  objJsonAttributes: TJSONObject ;
  LStrAditionalInfo: String;
  LjsonLinkAttributes: TJSONObject;
  LblnAtivo: Boolean;

  function tryObterStatusTransacao(const aJsonLink: TJSONObject; out aStatus: String; out aAttributes: TJSONObject): Boolean;
  var
    LTransactions: TJSONArray ;
    LjsonDadosTransacao, LjsonStatus, LjsonAttributes: TJSONObject;
    intItemTransaction: integer;
  begin
    Result := False;
    aStatus := '';

    if not(aJsonLink.TryGetValue<TJSONArray>('transactions', LTransactions)) then
      exit;

    intItemTransaction:= LTransactions.Count -1;

    if (intItemTransaction < 0) then
      exit;

    if not(LTransactions.Items[intItemTransaction] is TJSONObject) then
      Exit;

    LjsonDadosTransacao:= LTransactions.Items[intItemTransaction] as TJSONObject;

    if not(LjsonDadosTransacao.TryGetValue<TJsonObject>('attributes', LjsonAttributes)) then
      exit;

    if not(LjsonAttributes.TryGetValue<TJsonObject>('status', LjsonStatus)) then
      exit;

    aStatus := Trim(UpperCase(LjsonStatus.GetValue<String>('message')));
    aAttributes:= LjsonAttributes;

    Result := True;
  end;

  function tryGetAditionalInfo(const aJsonLink: TJSONObject): String;
  var
    LAtributes: TJSONObject ;
  begin
    Result := EmptyStr;

    if not(aJsonLink.TryGetValue<TJSONObject>('attributes', LAtributes)) then
      exit;

    if not(LAtributes.TryGetValue<string>('additional_info', Result)) then
      Result:= EmptyStr;
  end;


  function tryGetAmountValue(const AJsonAttributes: TJSONObject): String;
  var
    LdblAmount: Double;
  begin
    Result := '0';

    try
      LdblAmount := AJsonAttributes.GetValue<Double>('amount');
    except
      LdblAmount := 0;
    end;

    if LdblAmount <> 0 then
      Result := FloatToStr(LdblAmount*100) ;
  end;
begin
  Result:= Nil;

  try
    LstrAccessToken := fGetToken ;

    LjsonLink:= fConsultaLink(LstrAccessToken, AstrId_link);

    if not Assigned(LjsonLink) then
    begin
      Result := TConsultaLinkPagamentoResposta.Create;
      Result.status := 'NEN' ;
      Exit;
    end;

    try
      if not(tryObterStatusTransacao(LjsonLink, LstrStatusTransacao, objJsonAttributes)) then
        exit;

      Result := TConsultaLinkPagamentoResposta.Create;
      try
        if LstrStatusTransacao = STATUS_PAGO then
        begin
          Result.amount := tryGetAmountValue(objJsonAttributes);
          Result.customer_receipt := '' ; // via loja
          Result.esitef_usn := objJsonAttributes.GetValue<String>('authorization_id');
          Result.merchant_receipt :='' ; // via cliente
          Result.id_link := AstrId_link;
          Result.payment_date := fConverterParaDateTime(objJsonAttributes.GetValue<String>('captured_at')) ;
          Result.installments := objJsonAttributes.GetValue<String>('installments') ;

          Result.brand := objJsonAttributes.GetValue<String>('method') ;
          Result.payment_type := fDefineTipoComBaseNoMetodo(Result.brand);

          Result.authorization_number := objJsonAttributes.GetValue<String>('authorization_id');
          Result.order_id:= objJsonAttributes.GetValue<String>('order_id');

          LStrAditionalInfo:= tryGetAditionalInfo(LjsonLink);

          Result.infoAdicional := LStrAditionalInfo;
          Result.status := 'CON' ;
        end
        else if LstrStatusTransacao = STATUS_NEGADO then
        begin
          Result.status := 'NEG' ;
          exit ;
        end
        else if LstrStatusTransacao = STATUS_CANCELADO then
        begin
          Result.status := 'CAN' ;
          exit ;
        end
        else
        begin
          if LjsonLink.TryGetValue<TJSONObject>('attributes', LjsonLinkAttributes) and
             LjsonLinkAttributes.TryGetValue<Boolean>('is_active', LblnAtivo) and
             (not LblnAtivo) then
          begin
            Result.status := 'EXP' ;
            exit ;
          end;
          FreeAndNil(Result);
          exit;
        end;
      except
        FreeAndNil(Result);
        raise;
      end;
    finally
      FreeAndNil(LjsonLink) ;
    end;
  except
    on ETrnNotFound: ExceptionLinkPgTransacaoNaoEncontrada do
      raise;

    on E: Exception do
      raise;
  end;

end;

function TLinkPagamentoIpag.fCreateEnvio(AobjEnvio: TJSONObject; const AUpdateID: Integer = 0): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrTokenAcesso: String;
begin
  Result := nil;
  FstrJSONResponse := '';
  FstrJSONRequest := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/service/v2/payment_links';
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    if AUpdateID > 0 then
    begin
      RestRequest.Resource := RestRequest.Resource + '/' + IntToStr(AUpdateID);
      RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPUT {$ELSE} rmPUT {$ENDIF} ;
    end;

    FstrResource := RestRequest.Resource;
    LstrTokenAcesso:= fGetToken;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Basic ' + LstrTokenAcesso, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization', 'Basic ' + LstrTokenAcesso, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    FstrJSONRequest := AobjEnvio.ToString;
    RestRequest.Params.AddItem('',
                               FstrJSONRequest,
                               TREstRequestParameterKind.pkREQUESTBODY,
                               [],
                               TRESTContentType.ctAPPLICATION_JSON);

    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200','201']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          401: raise ExceptionLinkPgCredencialInvalida.Create('Não autenticado. Verifique se foi informado corretamente as chaves de API no Basic Authentication.');
          403: raise ExceptionLinkPgCredencialNaoAutorizada.Create('Não Autorizado. Sua conta não tem permissão para realizar essa ação.');
          406: raise ExceptionLinkPgParametrosInvalidos.Create('Não aceito. Algum dado pode ser inválido verifique os dados enviados no body.')
          else
            raise ExceptionLinkPg.Create('Erro na requisição para obter link de pagamento.');
        end;
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requsição para obter link de pagamento.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoIpag.fCriarCancelamento(const AstrNsu,
  AstrId_link: String; var AstrJSONRet, AstrJSONReq: String): TJSONObject;
begin
  Result := nil ;
end;

function TLinkPagamentoIpag.fDefineTipoComBaseNoMetodo(
  const AStrmetodo: String): String;
const
  arrCredito: array[0..5] of String = (
    'visa',
    'mastercard',
    'amex',
    'elo',
    'hipercard',
    'diners');

  arrDebito: array[0..2] of String = (
    'visaelectron',
    'maestro',
    'elo_debit');
var
  lstrMetodo: String;
  i: Integer;
begin
  lstrMetodo := Trim(LowerCase(AStrmetodo));

  for i := Low(arrCredito) to High(arrCredito) do
  begin
    if lstrMetodo = arrCredito[i] then
    begin
      Result := 'CARTÃO DE CRÉDITO';
      exit;
    end;
  end;

  for i := Low(arrDebito) to High(arrDebito) do
  begin
    if lstrMetodo = arrDebito[i] then
    begin
      Result := 'CARTÃO DE DÉBITO';
      exit;
    end;
  end;

  if lstrMetodo = 'pix' then
  begin
    Result := 'PIX';
    exit;
  end;

  if lstrMetodo = 'boleto' then
  begin
    Result := 'BOLETO';
    exit;
  end;

  Result := UpperCase(lstrMetodo);
end;

function TLinkPagamentoIpag.fEfetuarCancelamento(const AstrId_linkCanc,
  AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet,
  AstrJSONReq: String): TJSONObject;
var
  LstrAccessToken: String ;
  LjsonCanc, LjsonCancRetorno: TJSONObject ;

  LObjLinkPagamento: ILinkPagamentoCitel;
  LRespostaLinkPagamento: TConsultaLinkPagamentoResposta;
begin
  Result:= Nil;

  LObjLinkPagamento := fCriarLinkPagamentoCitel ;
  LRespostaLinkPagamento := LObjLinkPagamento.fConsultarTransacao(AstrId_linkCanc, Now);

  if not Assigned(LRespostaLinkPagamento) then
    exit;

  if (LRespostaLinkPagamento.status = 'EXP') then
  begin
    FreeAndNil(LRespostaLinkPagamento);
    exit;
  end;

  LjsonCanc := nil;
  Result := TJSONObject.Create;
  try
    try
      if (LRespostaLinkPagamento.status = 'NEN') then
        raise ExceptionLinkPgPagamentoNaoEncontrado.Create('Pagamento não encontrado.');

      if (LRespostaLinkPagamento.status = 'CAN') then
        raise ExceptionLinkPgJaCancelado.Create('Link de pagamento já está cancelado.');

      LstrAccessToken := fGetToken ;
      LjsonCanc := fGetCancelamentoTransacao(LstrAccessToken, LRespostaLinkPagamento.order_id) ;

      if not Assigned(LjsonCanc) then
        raise Exception.Create('Problemas ao efetuar cancelamento.');

      if not(LjsonCanc.TryGetValue<TJsonObject>('retorno', LjsonCancRetorno)) then
      begin
        FreeAndNil(LjsonCanc);
        exit;
      end;

      try
        if not(LjsonCancRetorno.GetValue<String>('mensagem_transacao') = 'CANCELED') then
        begin
          Result.AddPair('code', TJSONNumber.Create(LjsonCancRetorno.GetValue<String>('status_pagamento'))) ;
          Result.AddPair('message', TJSONString.Create(LjsonCancRetorno.GetValue<String>('mensagem_transacao'))) ;
          Exit ;
        end ;
      finally
        FreeAndNil(LjsonCanc);
      end;

      Result.AddPair('code', TJSONNumber.Create(0)) ;
      Result.AddPair('message', TJSONString.Create('')) ;
      Result.AddPair('amount', TJSONString.Create(LRespostaLinkPagamento.amount)) ;

    except
      on EJaCanc: ExceptionLinkPgJaCancelado do
      begin
        Result.AddPair('code', TJSONNumber.Create(3)) ;
        Result.AddPair('message', TJSONString.Create('Transação já cancelada anteriormente!')) ;
        Result.AddPair('amount', TJSONString.Create(LRespostaLinkPagamento.amount)) ;
      end;

      on ETrnNotFound: ExceptionLinkPgTransacaoNaoEncontrada do
      begin
        Result.AddPair('code', TJSONNumber.Create(1)) ;
        Result.AddPair('message', TJSONString.Create(ETrnNotFound.Message)) ;
      end;

      on ELPg: ExceptionLinkPg do
      begin
        Result.AddPair('code', TJSONNumber.Create(2)) ;
        Result.AddPair('message', TJSONString.Create(ELPg.Message)) ;
      end;

      on E: Exception do
      begin
        Result.AddPair('code', TJSONNumber.Create(2)) ;
        Result.AddPair('message', TJSONString.Create('Erro desconhecido.')) ;
      end;
    end;
  finally
    FreeAndNil(LRespostaLinkPagamento);
    AstrJSONRet := FstrJSONResponse;
    AstrJSONReq := FstrJSONRequest;
  end;
end;

function TLinkPagamentoIpag.fExpiraLinkInterno(const AstrAccessToken,
  AstrId_link: String): Boolean;
var
  LjsonLink, LjsonEnvio, LjsonResposta, LjsonAttributes: TJSONObject ;
  LDataExpira: TDateTime;
begin
  Result := False ;
  LjsonLink := fConsultaLink(AstrAccessToken, AstrId_link) ;
  if not Assigned(LjsonLink) then
    Exit ;

  if not(LjsonLink.TryGetValue<TJsonObject>('attributes', LjsonAttributes)) then
    exit;

  LDataExpira:= Now -1;

  LjsonEnvio := TJSONObject.Create ;
  try
    LjsonEnvio.AddPair('external_code', TJSONString.Create(LjsonAttributes.GetValue<String>('external_code') )) ;
    LjsonEnvio.AddPair('amount', TJSONNumber.Create(LjsonAttributes.GetValue<String>('amount'))) ;
    LjsonEnvio.AddPair('description', TJSONString.Create(LjsonAttributes.GetValue<String>('description'))) ;
    LjsonEnvio.AddPair('additional_info', TJSONString.Create(LjsonAttributes.GetValue<String>('additional_info'))) ;
    LjsonEnvio.AddPair('expires_at', TJSONString.Create(fAjustaDataHora(LDataExpira)));
    LjsonEnvio.AddPair('stock_limit', TJSONString.Create(LjsonAttributes.GetValue<String>('stock_limit'))) ;

    LjsonResposta := fCreateEnvio(LjsonEnvio, StrToIntDef(AstrId_link, 0));

    if not(Assigned(LjsonResposta)) then
      Exit;

    Result := True;
  finally
    FreeAndNil(LjsonEnvio) ;
    FreeAndNil(LjsonLink) ;
    FreeAndNil(LjsonResposta) ;
  end;
end;

function TLinkPagamentoIpag.fExpirarLinkPagamento(const AstrId_link: String): Boolean;
var
  LstrTokenAcesso: String ;
begin
  LstrTokenAcesso := fGetToken ;
  Result := fExpiraLinkInterno(LstrTokenAcesso, AstrId_link) ;
end;

function TLinkPagamentoIpag.fGerarLinkPagamento(const AstrOperacao: String;
  const AintQtdParcelas: Integer; const AtpParcLoja: String;
  const AfltValPed: Double; var AstrRetornoMsgErro: string;
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta;
var
  LjsonEnvio, LcheckoutSettings: TJSONObject ;
  LjsonResposta: TJSONObject;
  LstrDescricao: String;
  LstrPrimeiroDoc, LstrTipLan, LStrExternalCode: String ;
begin
  Result := nil;
  LjsonResposta := nil;
  AstrRetornoMsgErro := '';

  LstrDescricao := fRetornaDocumentosByAutoInc(ArecInfoDoc,
                                               LstrPrimeiroDoc,
                                               LstrTipLan) ;

  LjsonEnvio := TJSONObject.Create ;
  LStrExternalCode:= 'LINK' + FormatDateTime('yyyymmddhhnnss', AdtaExpiracao);

  try
    LjsonEnvio.AddPair('external_code', TJSONString.Create(LStrExternalCode)) ;
    LjsonEnvio.AddPair('amount', TJSONNumber.Create(AfltValPed)) ;
    LjsonEnvio.AddPair('description', TJSONString.Create('LINK DE PAGAMENTO('+copy(LstrDescricao,1,50)+')')) ;
    LjsonEnvio.AddPair('additional_info', TJSONString.Create(copy(LstrDescricao,1,255))) ;
    LjsonEnvio.AddPair('expires_at', TJSONString.Create(fAjustaDataHora(AdtaExpiracao))) ;
    LjsonEnvio.AddPair('stock_limit', TJSONString.Create('1')) ;

    LcheckoutSettings:= TJSONObject.Create ;
    LcheckoutSettings.AddPair('max_installments', TJSONNumber.Create(AintQtdParcelas)) ;
    LcheckoutSettings.AddPair('payment_method', 'all') ;

    LjsonEnvio.AddPair('checkout_settings', LcheckoutSettings) ;

    try
      LjsonResposta := fCreateEnvio(LjsonEnvio) ;
    except
      AstrRetornoMsgErro := FstrJSONResponse;
      raise;
    end;

    if Assigned(LjsonResposta) then
    begin
      Result := TGerarLinkPagamentoResposta.Create;
      Result.Descricao := LstrDescricao ;
      Result.IdLink := LjsonResposta.GetValue<String>('id') ;
      Result.Nsu := '' ;
      Result.Url := fGetUrlPagamento(LjsonResposta);
      Result.CodigoRetorno := 201 ;
    end ;
  finally
    if Assigned(LjsonResposta) then
      FreeAndNil(LjsonResposta) ;

    FreeAndNil(LjsonEnvio) ;
  end ;

end;

function TLinkPagamentoIpag.fGetCancelamentoTransacao(const AstrAccessToken,
  AstrOrdem: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LjsonPagamento: TJSONObject ;
  LMessage: String ;
  Ljson400: TJSONObject ;
begin
  Result := nil;
  FstrJSONRequest := '';
  FstrJSONResponse := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/service/cancel' ;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Basic ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Basic ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    RESTRequest.Params.AddItem('order_id', AstrOrdem, pkGETorPOST);



    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200']) then
    begin
      LjsonPagamento := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;
      Result := LjsonPagamento ;
    end
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          400:
             begin
               LMessage := RestRequest.Response.Content ;
               Ljson400 := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LMessage), 0) as TJSONObject ;
               try
                 LMessage := Ljson400.GetValue<String>('message') ;
                 if pos('309', LMessage) > 0 then
                   raise ExceptionLinkPg.Create('Erro ao cancelar transação. '+ LMessage );
               finally
                 FreeAndNil(Ljson400) ;
               end ;
               raise ExceptionLinkPgJaCancelado.Create('Link de pagamento já está cancelado.');
             end ;
          401: raise ExceptionLinkPgCredencialNaoAutorizada.Create('As credenciais configuradas no Autcom não tem permissão de acesso.');
          404: raise ExceptionLinkPgTransacaoNaoEncontrada.Create('Transação não encontrada.');
          else
            raise ExceptionLinkPg.Create('Erro ao cancelar transação.');
        end
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requisição de cancelamento.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoIpag.fGetToken: String;
var
  LstrToken: String ;
  LBase64: TBase64Encoding;
begin
  Result := '';
  LstrToken := Format('%s:%s', [TLinkPagamentoCitelRepositorio.fGetMerchantId, TLinkPagamentoCitelRepositorio.fGetMerchantKey]);
  LBase64 := TBase64Encoding.Create(0);
  try
    LstrToken := LBase64.Encode(LstrToken) ;
    Result := LstrToken;
  finally
    FreeAndNil(LBase64);
  end ;
end;

function TLinkPagamentoIpag.fPodeGerarNovoLinkComEmpresaLogada(
  const ACodEmpLink: String): Boolean;
var
  LstrClientIdLink: String ;
  LstrClientIdEmpLog: String ;
begin
  LstrClientIdLink := fCfgSis('SECRED', varString, ACodEmpLink) ;
  LstrClientIdEmpLog := fCfgSis('SECRED', varString) ;
  Result := LstrClientIdLink = LstrClientIdEmpLog ;
end;

function TLinkPagamentoIpag.JSONRequest: String;
begin
  Result := FstrJSONRequest ;
end;

function TLinkPagamentoIpag.JSONRequest(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONRequest := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.JSONResponse: String;
begin
  Result := FstrJSONResponse ;
end;

function TLinkPagamentoIpag.JSONResponse(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONResponse := AstrValue ;
  Result := Self ;
end;

class function TLinkPagamentoIpag.New: ILinkPagamentoCitel;
begin
  Result := Self.Create;
end;

function TLinkPagamentoIpag.NomeFornecedorServico: String;
begin
  Result := 'Ipag';
end;

function TLinkPagamentoIpag.NumDoc: String;
begin
  Result := FstrNumDoc ;
end;

function TLinkPagamentoIpag.fGetUrlPagamento(const Ajson: TJSONObject): string;
var
  Llinks: TJSONObject;
  Lvalue: TJSONValue;
begin
  Result := '';

  if Ajson = nil then
    exit;

  Lvalue := Ajson.GetValue('links');

  if Lvalue = nil then
    exit;

  if not (Lvalue is TJSONObject) then
    exit;

  Llinks := Lvalue as TJSONObject;
  Lvalue := Llinks.GetValue('payment');

  if Lvalue = nil then
    exit;

  Result := Lvalue.Value;
end;

function TLinkPagamentoIpag.NumDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrNumDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.RequestResource: String;
begin
  Result := FstrResource ;
end;

function TLinkPagamentoIpag.SeqFgo(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrSeqFgo := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoIpag.SeqFgo: String;
begin
  Result := FstrSeqFgo ;
end;

end.
