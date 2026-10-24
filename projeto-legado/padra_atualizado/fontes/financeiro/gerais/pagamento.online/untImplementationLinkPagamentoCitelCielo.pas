unit untImplementationLinkPagamentoCitelCielo;

interface

uses untInterfaceLinkPagamentoCitel, untClassesComumLinkPagamentoCitel,
     {$IFDEF LINUX}
     {$I '..\..\..\core\services.core.uses.inc'},
     {$ELSE}
       REST.Client,
     {$ENDIF}
     System.JSON, System.Classes;

type

  TLinkPagamentoCitelBandeirasCielo = class(TInterfacedObject, ILinkPagamentoCitelBandeiras)
  public
    procedure pPreencheCombo(const AComboItens: TStrings) ;
    class function New: ILinkPagamentoCitelBandeiras ;
  end ;

  TLinkPagamentoCitelNormalizaTipoCielo = class(TInterfacedObject, ILinkPagamentoCitelNormalizaTipo)
  public
    function fTipo(const AstrTipo: String): String ;
    function fTipoAbreviado(const AstrTipo: String): String ;
    class function New: ILinkPagamentoCitelNormalizaTipo ;
  end;

  TLinkPagamentoCitelRepositorioCielo = class(TInterfacedObject, ILinkPagamentoCitelRepositorio)
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

  TLinkPagamentoCitelFornecedorCielo = class(TInterfacedObject, ILinkPagamentoCitelFornecedor)
  public
    function fGetTipRec: String ;
    class function New: ILinkPagamentoCitelFornecedor ;
  end ;

  TLinkPagamentoCielo = class(TInterfacedObject, ILinkPagamentoCitel)
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
    function fCreateEnvio(AobjEnvio: TJSONObject): TJSONObject ;
    function fConsultaPagamento(const AstrAccessToken, AstrId_link: String;
                                var AstrValor, AstrParcelas: String): String ;
    function fGetDadosTransacao(const AstrAccessToken, AstrOrdem: String): TJSONObject ;
    function fGetCancelamentoTransacao(const AstrAccessToken, AstrOrdem: String): TJSONObject ;
    function fRetornaDocumentosByAutoInc(const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                         var AstrPrimeiroDocumento, AstrTipLan: String): String ;
    function fRetornaTagName(const AstrPrimeiroDocumento, AstrTipLan: String): String ;
    function fAtualizaLink(const AstrAccessToken, AstrId_link: String; AjsonDados: TJSONObject): TJSONObject ;
    function fExpiraLinkInterno(const AstrAccessToken, AstrId_link: String): Boolean ;
    procedure pExpiraLinkInternoSeguro(const AstrAccessToken, AstrId_link: String) ;
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

uses SysUtils, untRestApi, REST.Types, untLinkPagamentoCitelRestApi,
     untLinkPagamentoCitelRepositorio, DateUtils, Rest.Json,
     untFactoryLinkPagamentoCitel, System.NetEncoding,
     Data.DB, MemDS, DBAccess, Uni, System.Types, System.StrUtils
     {$IFNDEF LINUX}
      ,untFuncoesSimples, untLibJWTUtil, Winapi.Windows
     {$ENDIF}
      ;

{ TLinkPagamentoCitelRepositorioCielo }

function TLinkPagamentoCitelRepositorioCielo.fCondicaoPagamentoComLinkPagamento(
  const AstrCodCnd: String): Boolean;
begin
  Result := fCampoTabela('CND_CIELNK', 'CADCND', ['CND_CODIGO'], [AstrCodCnd], True) = 'S' ;
end;

function TLinkPagamentoCitelRepositorioCielo.fGetChavePrivada: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCielo.fGetChavePublica: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCielo.fGetComprovanteCancCliente(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCielo.fGetComprovanteCancLoja(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCielo.fGetMerchantId: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_ID_CIE']);
end;

function TLinkPagamentoCitelRepositorioCielo.fGetMerchantKey: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SECCIE']);
end;

function TLinkPagamentoCitelRepositorioCielo.fGetURL: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URLCIE']);
end;

class function TLinkPagamentoCitelRepositorioCielo.New: ILinkPagamentoCitelRepositorio;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCitelFornecedorCielo }

function TLinkPagamentoCitelFornecedorCielo.fGetTipRec: String;
begin
  Result := LinkPagamentoCitelFornecedores[pcCielo] ;
end;

class function TLinkPagamentoCitelFornecedorCielo.New: ILinkPagamentoCitelFornecedor;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCielo }

function TLinkPagamentoCielo.CodCli(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodCli := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.CodCli: String;
begin
  Result := FstrCodCli ;
end;

function TLinkPagamentoCielo.CodEmp(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodEmp := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TLinkPagamentoCielo.CodOpe(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodOpe := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.CodOpe: String;
begin
  Result := FstrCodOpe ;
end;

constructor TLinkPagamentoCielo.Create;
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

function TLinkPagamentoCielo.EspDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrEspDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.EspDoc: String;
begin
  Result := FstrEspDoc ;
end;

function TLinkPagamentoCielo.fAjustaDataHora(
  const AdtaDataHora: TDateTime): String;
var
  LintDia, LintMes, LintAno, LintHora, LintMinuto, LintSegundo: Integer ;
begin
  LintDia     := DayOf(AdtaDataHora) ;
  LintMes     := MonthOf(AdtaDataHora) ;
  LintAno     := YearOf(AdtaDataHora) ;
  LintHora    := HourOf(AdtaDataHora) ;
  LintMinuto  := MinuteOf(AdtaDataHora) ;
  LintSegundo := SecondOf(AdtaDataHora) ;
  Result := format('%.*d-%.*d-%.*d %.*d:%.*d:%.*d', [4,LintAno,
                                                     2,LintMes,
                                                     2,LintDia,
                                                     2,LintHora,
                                                     2,LintMinuto,
                                                     2,LintSegundo]) ;
end;

function TLinkPagamentoCielo.fAtualizaLink(const AstrAccessToken,
  AstrId_link: String; AjsonDados: TJSONObject): TJSONObject;
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
    RestRequest.Resource := '/v1/products/'+AstrId_link;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPUT {$ELSE} rmPUT {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    FstrJSONRequest := AjsonDados.ToString;
    RestRequest.Params.AddItem('',
                               FstrJSONRequest,
                               TREstRequestParameterKind.pkREQUESTBODY,
                               [],
                               TRESTContentType.ctAPPLICATION_JSON);

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
          404: raise ExceptionLinkPgTransacaoNaoEncontrada.Create('Link de pagamento não encontrada.');
          else
            raise ExceptionLinkPg.Create('Erro ao atualizar link de pagamento.');
        end;
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requsição para atualizar link de pagamento.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCielo.fConsultaPagamento(const AstrAccessToken,
  AstrId_link: String; var AstrValor, AstrParcelas: String): String;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LjsonPagamento: TJSONObject ;
  LarrOrdens: TJSONArray ;
  LjsonOrdem: TJSONValue ;
  LstrDataCriacao: String ;
  LdtaDataCriacao: TDateTime ;
  LdtaDataRecente: TDateTime ;
  Ljsonpayment: TJSONObject ;
begin
  Result := '';
  FstrJSONRequest := '';
  FstrJSONResponse := '';
  AstrValor := '';
  AstrParcelas := '';
  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/v1/products/'+AstrId_link+'/payments';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}
    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200']) then
    begin
      LjsonPagamento := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;
      try
        try
          LarrOrdens := LjsonPagamento.GetValue<TJSONArray>('orders') ;
          if LarrOrdens.Count > 0 then
          begin
            LdtaDataRecente := EncodeDate(2000,1,1) ;
            for LjsonOrdem in LarrOrdens do
            begin
              LstrDataCriacao := (LjsonOrdem as TJSONObject).GetValue<String>('createdDate') ;
              LdtaDataCriacao := ISO8601ToDate(LstrDataCriacao) ;
              if LdtaDataCriacao > LdtaDataRecente then
              begin
                Ljsonpayment := (LjsonOrdem as TJSONObject).GetValue<TJSONObject>('payment') ;
                AstrValor := (Ljsonpayment as TJSONObject).GetValue<String>('price');
                AstrParcelas := (Ljsonpayment as TJSONObject).GetValue<String>('numberOfPayments');

                Result := (LjsonOrdem as TJSONObject).GetValue<String>('orderNumber') ;
                LdtaDataRecente := LdtaDataCriacao ;
              end;
            end;
          end;
        except
          Result := '';
        end;
      finally
        FreeAndNil(LjsonPagamento) ;
      end;
    end
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          401: raise ExceptionLinkPgCredencialNaoAutorizada.Create('As credenciais configuradas no Autcom não tem permissão de acesso.');
          404: raise ExceptionLinkPgTransacaoNaoEncontrada.Create('Transação não encontrada.');
          else
            raise ExceptionLinkPg.Create('Erro ao consultar transação.');
        end;
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requsição para consultar transação.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCielo.fConsultarTransacao(
  const AstrId_link: String;
  const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
var
  LstrAccessToken: String ;
  LstrOrdemPagamento: String ;
  LjsonDadosTransacao: TJSONObject ;
  LjsonPagamento: TJSONObject ;
  LstrValor, LstrParcelas: String ;
  LstrDataPgt: String ;
  LdtaDataPgt: TDateTime ;
  LintDia, LintMes, LintAno, LintHora, LintMinuto, LintSegundo, LintMili: word ;
  LstrStatusTransacao: String ;
  LjsonCartao: TJSONObject ;
  LjsonArrItensCartao: TJSONArray ;
  LjsonItemCartao: TJSONValue ;
  LstrValorAdicional: String ;
begin
  Result := Nil ;

  if AdtaExpericao < fNow then
  begin
    Result := TConsultaLinkPagamentoResposta.Create;
    Result.status := 'EXP' ;
    exit ;
  end;

  try
    LstrAccessToken := fGetToken ;
    LstrOrdemPagamento := fConsultaPagamento(LstrAccessToken, AstrId_link, LstrValor, LstrParcelas) ;

    if trim(LstrOrdemPagamento) <> '' then
    begin
      try
        LjsonDadosTransacao := fGetDadosTransacao(LstrAccessToken, LstrOrdemPagamento);
      except
        on ExceptionLinkPgTransacaoNaoEncontrada do
          raise Exception.Create('Ordem de pagamento nao encontrada! ' + AstrId_link);
      end;

      if Assigned(LjsonDadosTransacao) then
      begin
        try
          LjsonPagamento := LjsonDadosTransacao.GetValue<TJSONObject>('payment') ;
          LjsonCartao := LjsonDadosTransacao.GetValue<TJSONObject>('cart') ;
          LstrValorAdicional := '' ;
          if Assigned(LjsonCartao) then
          begin
            LjsonArrItensCartao := LjsonCartao.GetValue<TJSONArray>('items') ;
            if Assigned(LjsonArrItensCartao) then
            begin
              for LjsonItemCartao in LjsonArrItensCartao do
              begin
                LstrValorAdicional := LjsonItemCartao.GetValue<string>('description'); ;
                break ;
              end;
            end;
          end;

          LstrStatusTransacao := Trim(lowercase(LjsonPagamento.GetValue<String>('status'))) ;
          if LstrStatusTransacao = 'paid' then
          begin
            Result := TConsultaLinkPagamentoResposta.Create;

            try
              Result.amount := LstrValor;
              Result.customer_receipt := '' ; // via loja
              Result.esitef_usn := LjsonPagamento.GetValue<String>('nsu');
              Result.merchant_receipt :='' ; // via cliente
              Result.id_link := AstrId_link;

              LstrDataPgt := LjsonPagamento.GetValue<String>('finishedDate') ;
              LdtaDataPgt := ISO8601ToDate(LstrDataPgt) ;
              DecodeDateTime(LdtaDataPgt, LintAno, LintMes, LintDia, LintHora, LintMinuto, LintSegundo, LintMili);
              LstrDataPgt := format('%.*d/%.*d/%.*d %.*d:%.*d:%.*d', [2,LintDia,
                                                                      2,LintMes,
                                                                      4,LintAno,
                                                                      2,LintHora,
                                                                      2,LintMinuto,
                                                                      2,LintSegundo]) ;

              Result.payment_date := LstrDataPgt;
              Result.payment_type := string(LjsonPagamento.GetValue<String>('type')).ToUpper.Trim;
              Result.infoAdicional := LstrValorAdicional ;

              if Result.payment_type = 'PIX' then
              begin
                Result.authorization_number := LjsonPagamento.GetValue<String>('nsu');
                Result.brand := Result.payment_type;
              end
              else
              begin
                Result.authorization_number := LjsonPagamento.GetValue<String>('authorizationCode');
                Result.brand := LjsonPagamento.GetValue<String>('brand');
              end;

              Result.status := 'CON' ;
              Result.installments := LstrParcelas;
            except
              FreeAndNil(Result);
              raise;
            end;
          end
          else
          begin
            if LstrStatusTransacao = 'denied' then
            begin
              pExpiraLinkInternoSeguro(LstrAccessToken, AstrId_link);

              Result := TConsultaLinkPagamentoResposta.Create;
              Result.status := 'NEG' ;
              exit ;
            end
            else if LstrStatusTransacao = 'voided' then
            begin
              pExpiraLinkInternoSeguro(LstrAccessToken, AstrId_link);

              Result := TConsultaLinkPagamentoResposta.Create;
              Result.status := 'CAN' ;
              exit ;
            end
            else if LstrStatusTransacao = 'pending' then
            begin
              Result := TConsultaLinkPagamentoResposta.Create;
              Result.status := 'PEN' ;
              exit ;
            end;
          end;
        finally
          FreeAndNil(LjsonDadosTransacao) ;
        end;
      end;
    end;

  except
    on ETrnNotFound: ExceptionLinkPgTransacaoNaoEncontrada do
      raise;

    on E: Exception do
      raise;
  end;

end;

function TLinkPagamentoCielo.fCreateEnvio(AobjEnvio: TJSONObject): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrTokenAcesso: String ;
begin
  Result := nil;
  FstrJSONResponse := '';
  FstrJSONRequest := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/v1/products';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    LstrTokenAcesso := fGetToken ;
    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + LstrTokenAcesso, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + LstrTokenAcesso, pkHTTPHEADER, [poDoNotEncode]);
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
          401: raise ExceptionLinkPgCredencialNaoAutorizada.Create('As credenciais configuradas no Autcom não tem permissão de acesso.');
          404: raise ExceptionLinkPgUrlInvalida.Create('URL inválida.');
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

function TLinkPagamentoCielo.fCriarCancelamento(const AstrNsu,
  AstrId_link: String; var AstrJSONRet, AstrJSONReq: String): TJSONObject;
begin
  Result := Nil ;
end;

function TLinkPagamentoCielo.fEfetuarCancelamento(const AstrId_linkCanc,
  AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet,
  AstrJSONReq: String): TJSONObject;
var
  LstrAccessToken: String ;
  LstrNumeroOrdemPagamento: String ;
  LstrValor, LstrParcelas: String ;
  LjsonCanc: TJSONObject ;
begin
  LjsonCanc := nil;
  Result := TJSONObject.Create;
  try
    try
      LstrAccessToken := fGetToken ;
      LstrNumeroOrdemPagamento := fConsultaPagamento(LstrAccessToken, AstrId_linkCanc, LstrValor, LstrParcelas);

      if (LstrNumeroOrdemPagamento = '') then
        raise ExceptionLinkPgPagamentoNaoEncontrado.Create('Pagamento não encontrado.');

      LjsonCanc := fGetCancelamentoTransacao(LstrAccessToken, LstrNumeroOrdemPagamento) ;

      if not Assigned(LjsonCanc) then
        raise Exception.Create('Problemas ao efetuar cancelamento.');

      try
        if not LjsonCanc.GetValue<Boolean>('success') then
        begin
          Result.AddPair('code', TJSONNumber.Create(LjsonCanc.GetValue<String>('returnCode'))) ;
          Result.AddPair('message', TJSONString.Create(LjsonCanc.GetValue<String>('returnMessage'))) ;
          Exit ;
        end ;
      finally
        FreeAndNil(LjsonCanc);
      end;

      Result.AddPair('code', TJSONNumber.Create(0)) ;
      Result.AddPair('message', TJSONString.Create('')) ;
      Result.AddPair('amount', TJSONString.Create(LstrValor)) ;

    except
      on EJaCanc: ExceptionLinkPgJaCancelado do
      begin
        Result.AddPair('code', TJSONNumber.Create(3)) ;
        Result.AddPair('message', TJSONString.Create('Transação já cancelada anteriormente!')) ;
        Result.AddPair('amount', TJSONString.Create(LstrValor)) ;
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
    AstrJSONRet := FstrJSONResponse;
    AstrJSONReq := FstrJSONRequest;
  end;
end;

function TLinkPagamentoCielo.fExpiraLinkInterno(const AstrAccessToken,
  AstrId_link: String): Boolean;
var
  LjsonEnvio: TJSONObject ;
  LjsonRetorno: TJSONObject ;
begin
  // A Cielo exige data de expiracao maior que a data atual e so aceita no PUT
  // os campos mutaveis do link - devolver o corpo do GET faz a API recusar com
  // 400 (campos somente-leitura, ex.: productId). Envia-se apenas expirationDate.
  LjsonEnvio := TJSONObject.Create ;
  try
    LjsonEnvio.AddPair('expirationDate',
                       TJSONString.Create(fAjustaDataHora(IncMinute(fNow, 5)))) ;

    LjsonRetorno := fAtualizaLink(AstrAccessToken, AstrId_link, LjsonEnvio) ;
    try
      Result := Assigned(LjsonRetorno) ;
    finally
      FreeAndNil(LjsonRetorno) ;
    end ;
  finally
    FreeAndNil(LjsonEnvio) ;
  end ;
end;

procedure TLinkPagamentoCielo.pExpiraLinkInternoSeguro(const AstrAccessToken,
  AstrId_link: String);
begin
  // Expirar o link e efeito colateral da consulta: se falhar, a transacao ainda
  // precisa ser devolvida como NEG/CAN e persistida, senao o registro continua
  // sendo reprocessado indefinidamente pelo robo a cada ciclo.
  try
    fExpiraLinkInterno(AstrAccessToken, AstrId_link) ;
  except
    // Silenciado de proposito: o erro HTTP ja fica registrado em LOGAPI por
    // TControllerRest.pGravaLog, com o corpo da requisicao e o status retornado.
  end ;
end;

function TLinkPagamentoCielo.fExpirarLinkPagamento(
  const AstrId_link: String): Boolean;
var
  LstrTokenAcesso: String ;
begin
  LstrTokenAcesso := fGetToken ;
  Result := fExpiraLinkInterno(LstrTokenAcesso, AstrId_link) ;
end;

function TLinkPagamentoCielo.fGerarLinkPagamento(const AstrOperacao: String;
  const AintQtdParcelas: Integer; const AtpParcLoja: String;
  const AfltValPed: Double;
  var   AstrRetornoMsgErro: string;
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta;
var
  LjsonEnvio: TJSONObject ;
  LjsonShipping: TJSONObject ;
  LjsonResposta: TJSONObject;
  LstrDescricao: String;
  LstrPrimeiroDoc, LstrTipLan: String ;
begin
  Result := nil;
  AstrRetornoMsgErro := '';

  LstrDescricao := fRetornaDocumentosByAutoInc(ArecInfoDoc,
                                               LstrPrimeiroDoc,
                                               LstrTipLan) ;
  LjsonEnvio := TJSONObject.Create ;
  try
    LjsonEnvio.AddPair('OrderNumber', TJSONString.Create(LstrPrimeiroDoc+LstrTipLan)) ;
    LjsonEnvio.AddPair('type', TJSONString.Create('Digital')) ;
    LjsonEnvio.AddPair('name', TJSONString.Create(fRetornaTagName(LstrPrimeiroDoc, LstrTipLan))) ;
    LjsonEnvio.AddPair('price', TJSONString.Create( FloatToStr(AfltValPed * 100))) ;
    LjsonEnvio.AddPair('expirationDate', TJSONString.Create(fAjustaDataHora(AdtaExpiracao))) ;
    LjsonEnvio.AddPair('maxNumberOfInstallments', TJSONString.Create(IntToStr(AintQtdParcelas))) ;
    LjsonEnvio.AddPair('quantity', TJSONString.Create('1')) ;
    LjsonEnvio.AddPair('showDescription', TJSONBool.Create(True)) ;
    LjsonEnvio.AddPair('description', TJSONString.Create(copy(LstrDescricao,1,256))) ;

    LjsonShipping := TJSONObject.Create ;
    LjsonShipping.AddPair('type', TJSONString.Create('WithoutShipping')) ;
    LjsonShipping.AddPair('name', TJSONString.Create('shipping_' + LstrPrimeiroDoc)) ;
    LjsonShipping.AddPair('price', TJSONString.Create('0000000000')) ;

    LjsonEnvio.AddPair('shipping', LjsonShipping) ;

    try
      try
        LjsonResposta := fCreateEnvio(LjsonEnvio) ;

        if Assigned(LjsonResposta) then
        begin
          Result := TGerarLinkPagamentoResposta.Create;
          Result.Descricao := LjsonResposta.GetValue<String>('name') ;
          Result.IdLink := LjsonResposta.GetValue<String>('id') ;
          Result.Nsu := '' ;
          Result.Url := LjsonResposta.GetValue<String>('shortUrl') ;
          Result.CodigoRetorno := 201 ;
        end ;

      except
        AstrRetornoMsgErro := FstrJSONResponse;

        raise;
      end;
    finally
      if Assigned(LjsonResposta) then
        FreeAndNil(LjsonResposta) ;
    end ;
  finally
    FreeAndNil(LjsonEnvio) ;
  end ;

end;

function TLinkPagamentoCielo.fGetCancelamentoTransacao(const AstrAccessToken, AstrOrdem: String): TJSONObject;
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
    RestRequest.Resource := '/v2/orders/'+AstrOrdem+'/void' ;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPUT {$ELSE} rmPUT {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

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

function TLinkPagamentoCielo.fGetDadosTransacao(const AstrAccessToken,
  AstrOrdem: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrJSONRet: String ;
  LjsonPagamento: TJSONObject ;
  LjsonDadosTransacao: TJSONObject ;
begin
  Result := Nil;

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/v2/orders/'+AstrOrdem ;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + AstrAccessToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + AstrAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}
    if ControllerRest.fExecute(RestRequest, LstrJSONRet, ['200']) then
    begin
      LjsonPagamento := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LstrJSONRet), 0) as TJSONObject ;
      LjsonDadosTransacao := LjsonPagamento.GetValue<TJSONObject>('payment') ;
      if Assigned(LjsonDadosTransacao) then
        Result := LjsonPagamento ;
    end
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          401: raise ExceptionLinkPgCredencialNaoAutorizada.Create('As credenciais configuradas no Autcom não tem permissão de acesso.');
          404: raise ExceptionLinkPgTransacaoNaoEncontrada.Create('Transação não encontrada.');
          else
            raise ExceptionLinkPg.Create('Erro ao obter dados da transação.');
        end
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requisição para obter dados da transação.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCielo.fGetToken: String;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrToken: String ;
  LBase64: TBase64Encoding;
  LjsonRetorno: TJSONObject ;
begin
  Result := '';
  FstrJSONResponse := '';
  FstrJSONRequest := '';

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/v2/token';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    LstrToken := Format('%s:%s', [TLinkPagamentoCitelRepositorio.fGetMerchantId, TLinkPagamentoCitelRepositorio.fGetMerchantKey]);

    LBase64 := TBase64Encoding.Create(0);
    try
      LstrToken := LBase64.Encode(LstrToken) ;
    finally
      FreeAndNil(LBase64);
    end ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Basic ' + LstrToken, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Basic ' + LstrToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200', '201']) then
    begin
      LjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;
      try
        Result := LjsonRetorno.GetValue<String>('access_token') ;
      finally
        FreeAndNil(LjsonRetorno) ;
      end ;
    end
    else
    begin
      if Assigned(RestRequest.Response) then
      begin
        case RestRequest.Response.StatusCode of
          400:
          begin
            try
              LjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject ;
              if LjsonRetorno.GetValue<String>('error') = 'invalid_client' then
                raise ExceptionLinkPgCredencialInvalida.Create('Credencial inválida.')
              else
                raise ExceptionLinkPg.Create('Erro ao obter token de acesso.');
            except
              on ExceptionLinkPgCredencial do
                raise;

              on Exception do
                raise ExceptionLinkPg.Create('Erro ao obter token de acesso.');
            end;

          end;
          401: raise ExceptionLinkPgCredencialInvalida.Create('Credencial inválida.');
          404: raise ExceptionLinkPgUrlInvalida.Create('URL inválida.');
          else
            raise ExceptionLinkPg.Create('Erro ao obter token de acesso.');
        end;
      end
      else
        raise ExceptionLinkPg.Create('Falha ao enviar requsição para obter token de acesso.');
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCielo.fRetornaDocumentosByAutoInc(
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  var AstrPrimeiroDocumento, AstrTipLan: String): String;
var
  LqryConsulta: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} ;
  LarrDocs: TStringDynArray ;
  LstrDocs: String ;
  LintCnt: Integer ;
  LstrRetorno: String ;
  LstrPrefixo: String ;
begin
  AstrPrimeiroDocumento := '' ;
  AstrTipLan := '' ;
  LstrDocs := '' ;
  LarrDocs := SplitString(ArecInfoDoc.Documentos, ',') ;
  for LintCnt := Low(LarrDocs) to High(LarrDocs) do
  begin
    LstrDocs := LstrDocs + IfThen(trim(LstrDocs) = '', '', ',') + quotedstr(Trim(LarrDocs[LintCnt])) ;
  end ;

  if trim(LstrDocs) = '' then
    Exit ;

  LqryConsulta := fCriaQuery ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    if ArecInfoDoc.Tipo = 'PD' then
    begin
      LstrPrefixo := 'Pedido(s): ' ;
      LqryConsulta.SQL.Add(' SELECT FGO_NUMDOC AS NUMDOC, FGO_ESPDOC AS ESPDOC, FGO_CODEMP AS CODEMP ') ;
      LqryConsulta.SQL.Add(' FROM FATGOR ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end
    else //agr
    begin
      LstrPrefixo := 'Agrupamento(s): ' ;
      LqryConsulta.SQL.Add(' SELECT CTR_NUMDUP AS NUMDOC, CTR_ESPDOC AS ESPDOC, CTR_CODEMP AS CODEMP ') ;
      LqryConsulta.SQL.Add(' FROM CADREC ') ;
      LqryConsulta.SQL.Add(' WHERE AUTOINCREM IN (' + LstrDocs + ') ') ;
    end ;
    LqryConsulta.Open ;

    LstrRetorno := '' ;
    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      if trim(AstrPrimeiroDocumento) = '' then
      begin
        AstrPrimeiroDocumento := LqryConsulta.FieldByName('NUMDOC').AsString ;
        AstrTipLan := ArecInfoDoc.Tipo ;
      end ;

      LstrRetorno := LstrRetorno + IfThen(trim(LstrRetorno) = '', '', ', ') + Format('%s-%s-%s', [LqryConsulta.FieldByName('NUMDOC').AsString,
                                                                                                  LqryConsulta.FieldByName('ESPDOC').AsString,
                                                                                                  LqryConsulta.FieldByName('CODEMP').AsString]) ;

      LqryConsulta.Next ;
    end ;
    Result := LstrPrefixo + LstrRetorno ;
  finally
    {$IFNDEF LINUX} FreeAndNil(LqryConsulta) {$ENDIF LINUX}
  end ;
end;

function TLinkPagamentoCielo.fRetornaTagName(const AstrPrimeiroDocumento,
  AstrTipLan: String): String;
begin
  Result := 'Pedido_'+AstrPrimeiroDocumento ;
  if AstrTipLan = 'AGR' then
    Result := 'Agrupamento_'+AstrPrimeiroDocumento ;
end;

function TLinkPagamentoCielo.JSONRequest(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONRequest := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.JSONRequest: String;
begin
  Result := FstrJSONRequest ;
end;

function TLinkPagamentoCielo.JSONResponse: String;
begin
  Result := FstrJSONResponse ;
end;

function TLinkPagamentoCielo.JSONResponse(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONResponse := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.NomeFornecedorServico: String ;
begin
  Result := 'Cielo';
end;

class function TLinkPagamentoCielo.New: ILinkPagamentoCitel;
begin
  Result := Self.Create;
end;

function TLinkPagamentoCielo.NumDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrNumDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCielo.RequestResource: String;
begin
  Result := FstrResource ;
end;

function TLinkPagamentoCielo.NumDoc: String;
begin
  Result := FstrNumDoc ;
end;

function TLinkPagamentoCielo.SeqFgo: String;
begin
  Result := FstrSeqFgo ;
end;

function TLinkPagamentoCielo.SeqFgo(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrSeqFgo := AstrValue ;
  Result := Self ;
end;

{ TLinkPagamentoCitelBandeirasCielo }

class function TLinkPagamentoCitelBandeirasCielo.New: ILinkPagamentoCitelBandeiras;
begin
  Result := Self.Create ;
end;

procedure TLinkPagamentoCitelBandeirasCielo.pPreencheCombo(
  const AComboItens: TStrings);
begin
  AComboItens.Clear ;
  AComboItens.Add('VISA') ;
  AComboItens.Add('MASTER') ;
  AComboItens.Add('AMEX') ;
  AComboItens.Add('DINERS') ;
  AComboItens.Add('ELO') ;
  AComboItens.Add('AURA') ;
  AComboItens.Add('JCB') ;
  AComboItens.Add('DISCOVER') ;
  AComboItens.Add('HIPERCARD') ;
  AComboItens.Add('PIX') ;
end;

{ TLinkPagamentoCitelNormalizaTipoCielo }

function TLinkPagamentoCitelNormalizaTipoCielo.fTipo(
  const AstrTipo: String): String;
var
  LstrTipo: String ;
begin
  LstrTipo := trim(LowerCase(AstrTipo)) ;
  if LstrTipo = 'creditcard' then
    Result := 'CARTÃO DE CRÉDITO'
  else if LstrTipo = 'boleto' then
    Result := 'BOLETO BANCÁRIO'
  else if LstrTipo = 'debitcard' then
    Result := 'CARTÃO DE DÉBITO'
  else if LstrTipo = 'qrcode' then
    Result := 'QR CODE CRÉDITO'
  else if LstrTipo = 'pix' then
    Result := 'PIX'
  else if LstrTipo = 'qrcodedebit' then
    Result := 'QR CODE DÉBITO'
  else
    Result := LstrTipo ;
end;

function TLinkPagamentoCitelNormalizaTipoCielo.fTipoAbreviado(
  const AstrTipo: String): String;
var
  LstrTipo: String ;
begin
  LstrTipo := trim(LowerCase(AstrTipo)) ;
  if LstrTipo = 'creditcard' then
    Result := 'C'
  else if LstrTipo = 'boleto' then
    Result := 'B'
  else if LstrTipo = 'debitcard' then
    Result := 'D'
  else if LstrTipo = 'qrcode' then
    Result := 'C'
  else if LstrTipo = 'pix' then
    Result := 'P'
  else if LstrTipo = 'qrcodedebit' then
    Result := 'D'
  else
    Result := 'C' ;
end;

class function TLinkPagamentoCitelNormalizaTipoCielo.New: ILinkPagamentoCitelNormalizaTipo;
begin
  Result := Self.Create ;
end;

end.
