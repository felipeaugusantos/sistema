unit untImplementationLinkPagamentoCitelCredPay;

interface

uses untInterfaceLinkPagamentoCitel, untClassesComumLinkPagamentoCitel,
     {$IFDEF LINUX}
     {$I '..\..\..\core\services.core.uses.inc'},
     {$ELSE}
       REST.Client,
     {$ENDIF}
     System.JSON, System.Classes;

type

  TLinkPagamentoCitelBandeirasCredPay = class(TInterfacedObject, ILinkPagamentoCitelBandeiras)
  public
    procedure pPreencheCombo(const AComboItens: TStrings) ;
    class function New: ILinkPagamentoCitelBandeiras ;
  end ;

  TLinkPagamentoCitelNormalizaTipoCredPay = class(TInterfacedObject, ILinkPagamentoCitelNormalizaTipo)
  private
    function RemoverAcentos(const ATexto: string): string;
  public
    function fTipo(const AstrTipo: String): String ;
    function fTipoAbreviado(const AstrTipo: String): String ;
    class function New: ILinkPagamentoCitelNormalizaTipo ;
  end;

  TLinkPagamentoCitelRepositorioCredPay = class(TInterfacedObject, ILinkPagamentoCitelRepositorio)
  private
    class procedure pCorrigeDadosCliente(const ADadosCli: TinfoCadCliLinkPagamentoCitel) ;
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
    class function fDadosCliente(const AstrCodCli: String; const ADadosCli: TinfoCadCliLinkPagamentoCitel): Boolean ;
    function fGetColunaAtivaLinkCadCnd: String ;
  end ;

  TLinkPagamentoCitelFornecedorCredPay = class(TInterfacedObject, ILinkPagamentoCitelFornecedor)
  public
    function fGetTipRec: String ;
    class function New: ILinkPagamentoCitelFornecedor ;
  end ;

  TLinkPagamentoCredPay = class(TInterfacedObject, ILinkPagamentoCitel)
  private
    FstrTokenGerado: String;
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
    function fCreateEnvio(const AobjEnvio: TJSONObject;
                          var   AstrJSONRet : String;
                          var   AstrJSONReq : String): TJSONObject ;
    function fMensagemGenerica(const AstrApi: String; const AstrMsgRetornoApi: String): String ;
    function ValidateEmail(const AstrEmail: string): Boolean;
    function fTrataEmail(const AstrEmail: String): String ;
    function fExpiraLinkInterno(const AstrId_link: String; var AstrMsgErro: String): Boolean ;
    function fConsultaLink(const AstrId_link: String; var AstrMsgErro: String): TJSONObject ;
    function fPostCancelamentoTransacao(const AstrReferenceId: String;
                                        const AstrTransactionId: String;
                                        var AstrMsgErro: String): TJSONObject ;
    function fConsultaInfoLink(const AstrId_link: String;
                               var AstrMsgErro: String;
                               var AfltValorTransacao: Double;
                               var AstrTransactionId: String): Integer ;
    function ExtrairErrosJson(const AJson: TJSONObject; const AKey: string = 'erros'): string;
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
                                var   AstrJSONReq : String): TJSONObject ;
    function fEfetuarCancelamento(const AstrId_linkCanc,
                                        AstrNumeroCartao,
                                        AstrVencCartao: String;
                                  var AstrJSONRet: String;
                                  var AstrJSONReq : String): TJSONObject ;

    function fPodeGerarNovoLinkComEmpresaLogada(const ACodEmpLink: String): Boolean ;

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

    constructor Create;
    function RequestResource: String ;
    function NomeFornecedorServico: String ;
  end ;

implementation

uses SysUtils, untRestApi, REST.Types, untLinkPagamentoCitelRestApi,
     untLinkPagamentoCitelRepositorio, DateUtils, Rest.Json,
     untFactoryLinkPagamentoCitel, System.NetEncoding, untLinkPagamentoCitelStatus ,
     Data.DB, MemDS, DBAccess, Uni, System.Types, System.StrUtils,
     untFuncoesComumLinkPagamentoCitel, RegularExpressions, System.Generics.Collections
     {$IFNDEF LINUX}
      ,untFuncoesSimples, Winapi.Windows
     {$ENDIF}
      ;

const
  TRANSACAO_EXPIRADA           = 4 ;
  TRANSACAO_PAGA               = 6 ;
  TRANSACAO_NEGADA             = 7 ;
  TRANSACAO_CANCELADA          = 9 ;
  TRANSACAO_CANC_ANDAMENTO     = 8 ;
  TRANSACAO_PEND_CONFIRMACAO   = 10 ;
  TRANSACAO_FALHA_COMUNICACAO  = 11 ;
  TRANSACAO_CARTAO_INVALIDO    = 12 ;
  TRANSACAO_NEGADA_FRAUDE      = 13 ;

{ TLinkPagamentoCitelRepositorioCredPay }

function TLinkPagamentoCitelRepositorioCredPay.fCondicaoPagamentoComLinkPagamento(
  const AstrCodCnd: String): Boolean;
begin
  Result := fCampoTabela('CND_CPAYLK', 'CADCND', ['CND_CODIGO'], [AstrCodCnd], True) = 'S' ;
end;

class function TLinkPagamentoCitelRepositorioCredPay.fDadosCliente(
  const AstrCodCli: String;
  const ADadosCli: TinfoCadCliLinkPagamentoCitel): Boolean;
var
  LqryCli: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := False  ;
  LqryCli := fCriaQuery;
  try

    LqryCli.Close ;
    LqryCli.SQL.Clear ;
    LqryCli.SQL.Add(' SELECT CLI_CODCLI, CLI_NOMCLI, CLI_EMAIL_, CLI_FONE01, CLI_CELULA, CLI_C_G_C_, CLI_ENDERE, CLI_ENDNUM, CLI_BAIRRO, CLI_C_E_P_, CID_NOMCID, CID_ESTADO ') ;
    LqryCli.SQL.Add(' FROM CADCLI LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ') ;
    LqryCli.SQL.Add(' WHERE CLI_CODCLI = :CODCLI ; ') ;
    LqryCli.ParamByName('CODCLI').AsString := AstrCodCli ;
    LqryCli.Open ;
    if not LqryCli.IsEmpty then
    begin
      ADadosCli.CLI_CODCLI := LqryCli.FieldByName('CLI_CODCLI').AsString ;
      ADadosCli.CLI_NOMCLI := LqryCli.FieldByName('CLI_NOMCLI').AsString ;
      ADadosCli.CLI_EMAIL_ := LqryCli.FieldByName('CLI_EMAIL_').AsString ;
      ADadosCli.CLI_FONE01 := LqryCli.FieldByName('CLI_FONE01').AsString ;
      ADadosCli.CLI_CELULA := LqryCli.FieldByName('CLI_CELULA').AsString ;
      ADadosCli.CLI_C_G_C_ := LqryCli.FieldByName('CLI_C_G_C_').AsString ;
      ADadosCli.CLI_ENDERE := LqryCli.FieldByName('CLI_ENDERE').AsString ;
      ADadosCli.CLI_ENDNUM := LqryCli.FieldByName('CLI_ENDNUM').AsString ;
      ADadosCli.CLI_BAIRRO := LqryCli.FieldByName('CLI_BAIRRO').AsString ;
      ADadosCli.CLI_C_E_P_ := LqryCli.FieldByName('CLI_C_E_P_').AsString ;
      ADadosCli.CID_NOMCID := LqryCli.FieldByName('CID_NOMCID').AsString ;
      ADadosCli.CID_ESTADO := LqryCli.FieldByName('CID_ESTADO').AsString ;
      ADadosCli.CID_PAIS__ := 'BR' ;

      pCorrigeDadosCliente(ADadosCli) ;

      Result := True ;
    end ;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LqryCli) ;
    {$ENDIF LINUX}
  end ;

end;

function TLinkPagamentoCitelRepositorioCredPay.fGetChavePrivada: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetChavePublica: String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetColunaAtivaLinkCadCnd: String;
begin
  Result := 'CND_CPAYLK' ;
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetComprovanteCancCliente(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetComprovanteCancLoja(
  const AstrNsu, AstrNit: String): String;
begin
  Result := '' ;
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetMerchantId: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_IDCPAY']);
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetMerchantKey: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SCCPAY']);
end;

function TLinkPagamentoCitelRepositorioCredPay.fGetURL: String;
begin
  Result := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_URCPAY']);
end;

class function TLinkPagamentoCitelRepositorioCredPay.New: ILinkPagamentoCitelRepositorio;
begin
  Result := Self.Create ;
end;

class procedure TLinkPagamentoCitelRepositorioCredPay.pCorrigeDadosCliente(
  const ADadosCli: TinfoCadCliLinkPagamentoCitel);
begin
  if fEmptyStr(ADadosCli.CLI_ENDERE) then
    ADadosCli.CLI_ENDERE := 'Não informado' ;

  if fEmptyStr(ADadosCli.CLI_ENDNUM) then
    ADadosCli.CLI_ENDNUM := 'S/N' ;

  if fEmptyStr(ADadosCli.CLI_BAIRRO) then
    ADadosCli.CLI_BAIRRO := 'não informado' ;

  if fEmptyStr(ADadosCli.CID_NOMCID) then
    ADadosCli.CID_NOMCID := 'não informado' ;

  if fEmptyStr(ADadosCli.CID_ESTADO) then
    ADadosCli.CID_ESTADO := 'SP' ;

  if fEmptyStr(ADadosCli.CID_PAIS__) then
    ADadosCli.CID_PAIS__ := 'BR' ;

  if fEmptyStr(ADadosCli.CLI_FONE01) then
    ADadosCli.CLI_FONE01 := '00-0000-0000' ;

  if fEmptyStr(ADadosCli.CLI_CELULA) then
    ADadosCli.CLI_CELULA := '00-0000-0000' ;
end;

{ TLinkPagamentoCitelFornecedorCredPay }

function TLinkPagamentoCitelFornecedorCredPay.fGetTipRec: String;
begin
  Result := LinkPagamentoCitelFornecedores[pcCredPay] ;
end;

class function TLinkPagamentoCitelFornecedorCredPay.New: ILinkPagamentoCitelFornecedor;
begin
  Result := Self.Create ;
end;

{ TLinkPagamentoCredPay }

function TLinkPagamentoCredPay.CodCli(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodCli := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.CodCli: String;
begin
  Result := FstrCodCli ;
end;

function TLinkPagamentoCredPay.CodEmp(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodEmp := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.CodEmp: String;
begin
  Result := FstrCodEmp ;
end;

function TLinkPagamentoCredPay.CodOpe(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrCodOpe := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.CodOpe: String;
begin
  Result := FstrCodOpe ;
end;

constructor TLinkPagamentoCredPay.Create;
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
  FstrTokenGerado := '' ;
end;

function TLinkPagamentoCredPay.EspDoc: String;
begin
  Result := FstrEspDoc ;
end;

function TLinkPagamentoCredPay.EspDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrEspDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.ExtrairErrosJson(const AJson: TJSONObject;
  const AKey: string): string;
var
  LJsonArray: TJSONArray;
  LCnt: Integer;
begin
  Result := '';

  if not Assigned(AJson) then
    Exit;

  LJsonArray := AJson.GetValue<TJSONArray>(AKey);

  if Assigned(LJsonArray) then
  begin
    for LCnt := 0 to LJsonArray.Count - 1 do
    begin
      if Result <> '' then
        Result := Result + sLineBreak;

      Result := Result + LJsonArray.Items[LCnt].Value;
    end;
  end;
end;

function TLinkPagamentoCredPay.fConsultaInfoLink(const AstrId_link: String;
  var AstrMsgErro: String; var AfltValorTransacao: Double;
  var AstrTransactionId: String): Integer;
var
  LjsonLink, LjsonRetorno: TJSONObject ;
  LintStatusTransacao: Integer ;
  LblnValido: Boolean ;
begin
  Result := -1 ;
  AstrTransactionId := '' ;
  AfltValorTransacao := 0.00 ;
  LjsonLink := fConsultaLink(AstrId_link, AstrMsgErro) ;
  if not Assigned(LjsonLink) then
    Exit ;

  try
    LblnValido := LjsonLink.GetValue<Boolean>('valid') ;
    if LblnValido then
    begin
      LjsonRetorno := LjsonLink.GetValue<TJsonObject>('retorno') ;
      LintStatusTransacao := LjsonRetorno.GetValue<Integer>('statusPagamento') ;
      AfltValorTransacao := LjsonRetorno.GetValue<Double>('valor')*100 ;
      AstrTransactionId := LjsonRetorno.GetValue<String>('transactionId') ;
      Result := LintStatusTransacao ;
    end
    else
    begin
      AstrMsgErro := ExtrairErrosJson(LjsonLink);
    end ;
  finally
    FreeAndNil(LjsonLink) ;
  end ;

end;

function TLinkPagamentoCredPay.fConsultaLink(const AstrId_link: String; var AstrMsgErro: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrJSONRet: String ;
begin
  Result := Nil;
  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/Consulta/ReferenceId//'+AstrId_link;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + FstrTokenGerado, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + FstrTokenGerado, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}
    if ControllerRest.fExecute(RestRequest, LstrJSONRet, ['200']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LstrJSONRet), 0) as TJSONObject
    else
      AstrMsgErro := fMensagemGenerica(RestRequest.Resource, LstrJSONRet) ;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCredPay.fConsultarTransacao(const AstrId_link: String;
  const AdtaExpericao: TDateTime): TConsultaLinkPagamentoResposta;
var
  LstrMsgErro: String ;
  LjsonLink: TJsonObject ;
  LintStatusTransacao: Integer ;
  LstrValorAdicional: String ;
  LstrValor: String ;
  LstrNsu: String ;
  LstrDataPgt: String ;
  LdtaDataPgt: TDateTime ;
  LintDia, LintMes, LintAno, LintHora, LintMinuto, LintSegundo, LintMili: word ;
  LstrParcelas: String ;
  LstrTipoPgt: String ;
  LstrBandeira: String ;
  LjsonRetorno: TJSONObject ;

  LblnValido: Boolean ;
begin
  Result := Nil ;
  FstrTokenGerado := fGetToken ;

  if AdtaExpericao < fNow then
  begin
    fExpiraLinkInterno(AstrId_link, LstrMsgErro);
    Result := TConsultaLinkPagamentoResposta.Create;
    Result.status := 'EXP' ;
    exit ;
  end;

  LjsonLink := fConsultaLink(AstrId_link, LstrMsgErro) ;
  if Assigned(LjsonLink) then
  begin
    try
      LblnValido := LjsonLink.GetValue<Boolean>('valid') ;
      if LblnValido then
      begin
        LjsonRetorno := LjsonLink.GetValue<TJsonObject>('retorno') ;

        LintStatusTransacao := LjsonRetorno.GetValue<Integer>('statusPagamento') ;

        if LintStatusTransacao = TRANSACAO_PAGA then
        begin
          LstrValorAdicional := LjsonRetorno.GetValue<String>('providerMessage') ;
          LstrValor := FloatToStr(LjsonRetorno.GetValue<Double>('valor')*100) ;
          LstrBandeira := LjsonRetorno.GetValue<String>('bandeira') ;
          LstrTipoPgt := UpperCase(LjsonRetorno.GetValue<String>('tipoDeOperacao')) ;
          LstrNsu := LjsonRetorno.GetValue<String>('nsu') ;

          LstrDataPgt := LjsonRetorno.GetValue<String>('data') ;
          LdtaDataPgt := ISO8601ToDate(LstrDataPgt, False) ;
          DecodeDateTime(LdtaDataPgt, LintAno, LintMes, LintDia, LintHora, LintMinuto, LintSegundo, LintMili);
          LstrDataPgt := format('%.*d/%.*d/%.*d %.*d:%.*d:%.*d', [2,LintDia,
                                                                  2,LintMes,
                                                                  4,LintAno,
                                                                  2,LintHora,
                                                                  2,LintMinuto,
                                                                  2,LintSegundo]) ;

          LstrParcelas := LjsonRetorno.GetValue<String>('quantidadeParcelas') ;

          Result := TConsultaLinkPagamentoResposta.Create;
          Result.amount := LstrValor;
          Result.authorization_number := LstrNsu;
          Result.customer_receipt := '' ; // via loja
          Result.esitef_usn := LstrNsu;
          Result.merchant_receipt :='' ; // via cliente
          Result.id_link := AstrId_link;
          Result.payment_date := LstrDataPgt;
          Result.infoAdicional := LstrValorAdicional ;
          Result.status := 'CON' ;
          Result.installments := LstrParcelas;
          Result.payment_type := LstrTipoPgt;
          Result.brand := LstrBandeira;

        end
        else if LintStatusTransacao = TRANSACAO_EXPIRADA then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'EXP' ;
          exit ;
        end
        else if LintStatusTransacao = TRANSACAO_PEND_CONFIRMACAO then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'PPC' ;
          exit ;
        end
        else if LintStatusTransacao = TRANSACAO_CANCELADA then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'CAN' ;
          exit ;
        end
        else if LintStatusTransacao = TRANSACAO_CARTAO_INVALIDO then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'INV' ;
          exit ;
        end
        else if LintStatusTransacao = TRANSACAO_NEGADA then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'NEG' ;
          exit ;
        end
        else if (LintStatusTransacao = TRANSACAO_FALHA_COMUNICACAO) or (LintStatusTransacao = TRANSACAO_NEGADA_FRAUDE) then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := 'BLQ' ;
          exit ;
        end
        else if LintStatusTransacao = TRANSACAO_CANC_ANDAMENTO then
        begin
          Result := TConsultaLinkPagamentoResposta.Create;
          Result.status := stTransacaoAguardandoSerEstornada ;
          LstrValor := FloatToStr(LjsonRetorno.GetValue<Double>('valor')*100) ;
          LstrNsu := LjsonRetorno.GetValue<String>('nsu') ;
          Result.amount := LstrValor;
          Result.customer_receipt := '' ;
          Result.merchant_receipt :='' ;
          Result.authorization_number := LstrNsu;
          Result.esitef_usn := LstrNsu ;

          exit ;
        end;
      end
      else
      begin
        LstrMsgErro := ExtrairErrosJson(LjsonLink) ;
      end ;
    finally
      FreeAndNil(LjsonLink) ;
    end ;
  end ;
end;

function TLinkPagamentoCredPay.fCreateEnvio(const AobjEnvio: TJSONObject;
  var AstrJSONRet, AstrJSONReq: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/Operacao/EfetivarPreOperacao';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;
    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + FstrTokenGerado, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + FstrTokenGerado, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    AstrJSONReq := AobjEnvio.ToString;
    RestRequest.Params.AddItem('',
                               AstrJSONReq,
                               TREstRequestParameterKind.pkREQUESTBODY,
                               [],
                               TRESTContentType.ctAPPLICATION_JSON);

    if ControllerRest.fExecute(RestRequest, AstrJSONRet, ['200','201']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(AstrJSONRet), 0) as TJSONObject
    else
      AstrJSONRet := fMensagemGenerica(RestRequest.Resource, AstrJSONRet);

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCredPay.fCriarCancelamento(const AstrNsu,
  AstrId_link: String; var AstrJSONRet, AstrJSONReq: String): TJSONObject;
begin
  Result := Nil ;
end;

function TLinkPagamentoCredPay.fEfetuarCancelamento(const AstrId_linkCanc,
  AstrNumeroCartao, AstrVencCartao: String; var AstrJSONRet,
  AstrJSONReq: String): TJSONObject;
var
  LintStatus: Integer ;
  LstrMsgErro: String ;
  LjsonCanc: TJSONObject ;
  LfltValorTransacao: Double ;
  LstrTransactionId: String ;
  LblnValido: Boolean ;
  LstrMsgRetorno: String ;
  LRetornoValue: TJSONValue;
  LMsgCancelamento: String;
  LRetornoObj: TJSONObject;
begin
  Result := TJSONObject.Create ;
  FstrTokenGerado := fGetToken ;
  LstrMsgErro := '' ;
  try
    try
      LintStatus := fConsultaInfoLink(AstrId_linkCanc, LstrMsgErro, LfltValorTransacao, LstrTransactionId) ;
      if LintStatus = -1 then
      begin
        Result.AddPair('code', TJSONNumber.Create(1)) ;
        Result.AddPair('message', TJSONString.Create(LstrMsgErro)) ;
        Exit ;
      end ;

      if LintStatus = TRANSACAO_CANCELADA then
        raise ExceptionLinkPgJaCancelado.Create('');

      if LintStatus <> TRANSACAO_PAGA then
      begin
        Result.AddPair('code', TJSONNumber.Create(1)) ;
        Result.AddPair('message', TJSONString.Create('Transação precisa estar quitada, para fazer o cancelamento!')) ;
        Exit ;
      end ;

      LjsonCanc := fPostCancelamentoTransacao(AstrId_linkCanc, LstrTransactionId, LstrMsgErro) ;

      if not Assigned(LjsonCanc) then
        raise ExceptionLinkPg.Create('Problemas ao efetuar cancelamento.'+#13+#10+LstrMsgErro);

      try
        LblnValido := LjsonCanc.GetValue<Boolean>('valid') ;
        if LblnValido then
        begin
          LRetornoValue := LjsonCanc.GetValue('retorno');
          LMsgCancelamento := '' ;
          LintStatus := -1 ;

          if Assigned(LRetornoValue) and (LRetornoValue is TJSONString) then
            LMsgCancelamento := TJSONString(LRetornoValue).Value;

          if Assigned(LRetornoValue) and (LRetornoValue is TJSONObject) then
          begin
            LRetornoObj := TJSONObject(LRetornoValue);
            LintStatus := LRetornoObj.GetValue<Integer>('status');
          end ;

          if pos('cancelamento em andamento', LowerCase(LMsgCancelamento)) > 0 then
          begin
            Result.AddPair('code', TJSONNumber.Create(CODIGO_CANCELAMENTO_TRANSACAO_VINDI_AGUARDANDO)) ;
            Result.AddPair('message', TJSONString.Create(LstrMsgRetorno)) ;
            Result.AddPair('amount', TJSONString.Create(FloatToStr(LfltValorTransacao))) ;
          end ;

          if LintStatus = TRANSACAO_CANCELADA then
          begin
            Result.AddPair('code', TJSONNumber.Create(CODIGO_CANCELAMENTO_TRANSACAO_VINDI_SUCESSO)) ;
            Result.AddPair('message', TJSONString.Create('')) ;
            Result.AddPair('amount', TJSONString.Create(FloatToStr(LfltValorTransacao))) ;
          end
          else
          begin
            Result.AddPair('code', TJSONNumber.Create(2)) ;
            Result.AddPair('message', TJSONString.Create('Erro não previsto [fEfetuarCancelamento]')) ;
          end ;

        end
        else
        begin
          Result.AddPair('code', TJSONNumber.Create(2)) ;
          Result.AddPair('message', TJSONString.Create(ExtrairErrosJson(LjsonCanc))) ;
        end ;
      finally
        FreeAndNil(LjsonCanc) ;
      end ;

    except
      on EJaCanc: ExceptionLinkPgJaCancelado do
      begin
        Result.AddPair('code', TJSONNumber.Create(3)) ;
        Result.AddPair('message', TJSONString.Create('Transação já cancelada anteriormente!')) ;
        Result.AddPair('amount', TJSONString.Create(FloatToStr(LfltValorTransacao))) ;
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

      on ELPgPI: ExceptionLinkPgParametrosInvalidos do
      begin
        Result.AddPair('code', TJSONNumber.Create(2)) ;
        Result.AddPair('message', TJSONString.Create(ELPgPI.Message)) ;
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
  end ;
end;

function TLinkPagamentoCredPay.fExpiraLinkInterno(const AstrId_link: String; var AstrMsgErro: String): Boolean;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LjsonRetorno: TJSONObject;
  LstrJSONRet: String ;
begin
  Result := False;

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/Operacao/Cancel/ReferenceId/'+AstrId_link ;
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmDELETE {$ELSE} rmDELETE {$ENDIF} ;
    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + FstrTokenGerado, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + FstrTokenGerado, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    if ControllerRest.fExecute(RestRequest, LstrJSONRet, ['200','201']) then
    begin
      LjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LstrJSONRet), 0) as TJSONObject ;
      Result := LjsonRetorno.GetValue<Boolean>('valid') ;
      if not Result then
        AstrMsgErro := ExtrairErrosJson(LjsonRetorno) ;
    end
    else
      AstrMsgErro := fMensagemGenerica(RestRequest.Resource, LstrJSONRet);

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCredPay.fExpirarLinkPagamento(const AstrId_link: String): Boolean;
var
  AstrMsgErro: String ;
begin
  FstrTokenGerado := fGetToken ;
  result := fExpiraLinkInterno(AstrId_link, AstrMsgErro) ;
end;

function TLinkPagamentoCredPay.fGerarLinkPagamento(const AstrOperacao: String;
  const AintQtdParcelas: Integer; const AtpParcLoja: String;
  const AfltValPed: Double; var AstrRetornoMsgErro: string;
  const ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  const AdtaExpiracao: TDateTime): TGerarLinkPagamentoResposta;
var
  LDadosCli: TinfoCadCliLinkPagamentoCitel ;
  LstrCodCli: String ;
  LstrPrimeiroDoc, LstrTipLan: String ;
  LjsonEnvio: TJSONObject ;
  LstrDescricao: String ;
  LjsonResposta: TJSONObject;
  LjsonRetorno: TJSONObject;
begin
  Result := Nil ;
  FstrTokenGerado := fGetToken ;

  fRetornaDocumentosByAutoInc(ArecInfoDoc,
                              LstrPrimeiroDoc,
                              LstrTipLan) ;

  LstrCodCli := fRetornaCodCliByAutoInc(ArecInfoDoc) ;

  LDadosCli := TinfoCadCliLinkPagamentoCitel.Create ;
  LjsonEnvio := TJSONObject.Create ;
  try
    TLinkPagamentoCitelRepositorioCredPay.fDadosCliente(LstrCodCli, LDadosCli) ;

    LjsonEnvio.AddPair('nomeDoCliente', TJSONString.Create(LDadosCli.CLI_NOMCLI)) ;
    LjsonEnvio.AddPair('documento', TJSONString.Create(LDadosCli.CLI_C_G_C_)) ;
    LjsonEnvio.AddPair('email', TJSONString.Create(fTrataEmail(LDadosCli.CLI_EMAIL_))) ;
    LjsonEnvio.AddPair('telefone', TJSONString.Create(LDadosCli.CLI_FONE01)) ;
    LjsonEnvio.AddPair('celular', TJSONString.Create(LDadosCli.CLI_CELULA)) ;
    LjsonEnvio.AddPair('lojaId', TJSONNull.Create()) ;
    LjsonEnvio.AddPair('servicoId', TJSONNumber.Create(14)) ; // verificar se vai criar CFG
    LjsonEnvio.AddPair('codigoDeBarras', TJSONNull.Create()) ;
    LjsonEnvio.AddPair('contrato', TJSONNull.Create()) ;
    LjsonEnvio.AddPair('contato', TJSONNull.Create()) ;
    LjsonEnvio.AddPair('credor', TJSONNull.Create()) ;
    LstrDescricao := fRetornaTagName(LstrPrimeiroDoc, LstrTipLan) ;
    LjsonEnvio.AddPair('descricaoServico', TJSONString.Create(LstrDescricao)) ;
    LjsonEnvio.AddPair('numeroInterno', TJSONNumber.Create(LstrPrimeiroDoc)) ;
    LjsonEnvio.AddPair('quantidadeDeParcelas', TJSONNumber.Create(AintQtdParcelas)) ;
    LjsonEnvio.AddPair('custoConveniencia', TJSONNumber.Create(0)) ;
    LjsonEnvio.AddPair('valorInicial', TJSONNumber.Create(AfltValPed)) ;
    LjsonEnvio.AddPair('softDescriptor', TJSONNull.Create()) ;
    LjsonEnvio.AddPair('preAuthLink', TJSONBool.Create(False)) ;

    LjsonResposta := fCreateEnvio(LjsonEnvio,  FstrJSONResponse, FstrJSONRequest) ;

    if Assigned(LjsonResposta) then
    begin
      try
        LjsonRetorno := LjsonResposta.GetValue<TJsonValue>('retorno') as TJsonObject ;
        Result := TGerarLinkPagamentoResposta.Create;
        Result.Descricao := LstrDescricao ;
        Result.IdLink := LjsonRetorno.GetValue<String>('referenceId') ;
        Result.Nsu := '' ;
        Result.Url := LjsonRetorno.GetValue<String>('link') ;
        Result.CodigoRetorno := 201 ;
      finally
        FreeAndNil(LjsonResposta) ;
      end ;
    end ;

    AstrRetornoMsgErro := FstrJSONResponse ;

  finally
    FreeAndNil(LDadosCli) ;
    FreeAndNil(LjsonEnvio) ;
  end ;

end;

function TLinkPagamentoCredPay.fGetToken: String;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
  LstrJSONRet: String ;
  LjsonRetorno: TJSONObject ;
  LstrUser, LstrPassword: String ;
begin
  Result := '';
  LstrUser := TLinkPagamentoCitelRepositorio.fGetMerchantId ;
  LstrPassword := TLinkPagamentoCitelRepositorio.fGetMerchantKey ;
  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  ControllerRest.RestClient.ContentType := 'application/x-www-form-urlencoded';
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := '/AuthCredPay';
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;
    {$IFNDEF LINUX}
    RESTRequest.Params.Clear ;
    {$ENDIF}
    RestRequest.Params.AddItem('User', LstrUser, pkGETorPOST);
    RestRequest.Params.AddItem('Key', LstrPassword , pkGETorPOST);
    RestRequest.Params.AddItem('grant_type', 'password' , pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, LstrJSONRet, ['200']) then
    begin
      LjsonRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LstrJSONRet), 0) as TJSONObject ;
      Result := LjsonRetorno.GetValue<String>('access_token') ;
    end;

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCredPay.fMensagemGenerica(const AstrApi,
  AstrMsgRetornoApi: String): String;
begin
  Result := 'Houve um inconsistência na geração do '+#13#10+
            'Link de Pagamento, favor entrar em contato com o Suporte Citel!' +#13#10+
            'API: ' + AstrApi +#13#10+
            'Retorno API: ' + AstrMsgRetornoApi ;
end;

function TLinkPagamentoCredPay.fPodeGerarNovoLinkComEmpresaLogada(
  const ACodEmpLink: String): Boolean;
var
  LstrClientIdLink: String ;
  LstrClientIdEmpLog: String ;
begin
  LstrClientIdLink := fCfgSis('IDCPAY', varString, ACodEmpLink) ;
  LstrClientIdEmpLog := fCfgSis('IDCPAY', varString) ;
  Result := LstrClientIdLink = LstrClientIdEmpLog ;
end;

function TLinkPagamentoCredPay.fPostCancelamentoTransacao(
  const AstrReferenceId: String; const AstrTransactionId: String; var AstrMsgErro: String): TJSONObject;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create(fGetLinkPagamentoCitelFornecedor.fGetTipRec, TControllerLinkPagamentoCitel.fConfigurar);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := format('/Transacao/Cancelar/%s/%s', [AstrTransactionId, AstrReferenceId]);
    FstrResource := RestRequest.Resource;
    RestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;
    {$IFDEF LINUX}
      RESTRequest.Params.AddItem('Authorization', 'Bearer ' + FstrTokenGerado, pkHTTPHEADER);
    {$ELSE}
      RESTRequest.Params.Clear ;
      RestRequest.AddAuthParameter('Authorization','Bearer ' + FstrTokenGerado, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}
    if ControllerRest.fExecute(RestRequest, FstrJSONResponse, ['200','201']) then
      Result := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FstrJSONResponse), 0) as TJSONObject
    else
      AstrMsgErro := fMensagemGenerica(RestRequest.Resource, FstrJSONResponse);

  finally
    {$IFNDEF LINUX}
     RestRequest.Free;
     ControllerRest.Free;
    {$ENDIF LINUX}
  end;
end;

function TLinkPagamentoCredPay.fTrataEmail(const AstrEmail: String): String;
var
  LstrEmail: String ;
  LstrAux: String ;
  LlstEmails: TStringDynArray ;
begin
  Result := '' ;
  LstrEmail := ReplaceStr(ReplaceStr(AstrEmail, ',', ';'), ' ', ';') ;
  LlstEmails := SplitString(LstrEmail, ';') ;
  for LstrAux in LlstEmails do
  begin
    if trim(LstrAux) = '' then
      continue ;

    if not ValidateEmail(trim(LstrAux)) then
      continue ;

    Result := LstrAux ;
    break ;
  end ;
end;

function TLinkPagamentoCredPay.JSONRequest: String;
begin
  Result := FstrJSONRequest ;
end;

function TLinkPagamentoCredPay.JSONRequest(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONRequest := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.JSONResponse: String;
begin
  Result := FstrJSONResponse ;
end;

function TLinkPagamentoCredPay.JSONResponse(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrJSONResponse := AstrValue ;
  Result := Self ;
end;

class function TLinkPagamentoCredPay.New: ILinkPagamentoCitel;
begin
  Result := Self.Create ;
end;

function TLinkPagamentoCredPay.NomeFornecedorServico: String;
begin
  Result := 'CredPay';
end;

function TLinkPagamentoCredPay.NumDoc(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrNumDoc := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.NumDoc: String;
begin
  Result := FstrNumDoc ;
end;

function TLinkPagamentoCredPay.RequestResource: String;
begin
  Result := FstrResource ;
end;

function TLinkPagamentoCredPay.SeqFgo(
  const AstrValue: String): ILinkPagamentoCitel;
begin
  FstrSeqFgo := AstrValue ;
  Result := Self ;
end;

function TLinkPagamentoCredPay.SeqFgo: String;
begin
  Result := FstrSeqFgo ;
end;

function TLinkPagamentoCredPay.ValidateEmail(const AstrEmail: string): Boolean;
var
  LRegEx: TRegEx;
begin
  LRegEx := TRegex.Create('^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]*[a-zA-Z0-9]+$');
  Result := LRegEx.Match(AstrEmail).Success;
end;

{ TLinkPagamentoCitelBandeirasCredPay }

class function TLinkPagamentoCitelBandeirasCredPay.New: ILinkPagamentoCitelBandeiras;
begin
  Result := Self.Create ;
end;

procedure TLinkPagamentoCitelBandeirasCredPay.pPreencheCombo(
  const AComboItens: TStrings);
begin
  AComboItens.Clear ;
  AComboItens.Add('VISA') ;
  AComboItens.Add('MASTERCARD') ;
  AComboItens.Add('AMERICAN EXPRESS') ;
  AComboItens.Add('ELO') ;
  AComboItens.Add('HIPERCARD/HIPER') ;
end;

{ TLinkPagamentoCitelNormalizaTipoCredPay }

function TLinkPagamentoCitelNormalizaTipoCredPay.fTipo(
  const AstrTipo: String): String;
var
  LstrTipo: String ;
begin
  LstrTipo := trim(LowerCase(RemoverAcentos(AstrTipo))) ;
  if LstrTipo = 'credito' then
    Result := 'CARTÃO DE CRÉDITO'
  else if LstrTipo = 'debito' then
    Result := 'CARTÃO DE DÉBITO'
  else
    Result := LstrTipo ;
end;

function TLinkPagamentoCitelNormalizaTipoCredPay.fTipoAbreviado(
  const AstrTipo: String): String;
var
  LstrTipo: String ;
begin
  LstrTipo := trim(LowerCase(AstrTipo)) ;
  if LstrTipo = 'crédito' then
    Result := 'C'
  else if LstrTipo = 'débito' then
    Result := 'D'
  else
    Result := 'C' ;
end;

class function TLinkPagamentoCitelNormalizaTipoCredPay.New: ILinkPagamentoCitelNormalizaTipo;
begin
  Result := Self.Create ;
end;

function TLinkPagamentoCitelNormalizaTipoCredPay.RemoverAcentos(
  const ATexto: string): string;
const
  ComAcento  = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖØÙÚÛÜÝŸàáâãäåæçèéêëìíîïðñòóôõöøùúûüýÿ';
  SemAcento  = 'AAAAAAACEEEEIIIIDNOOOOOOUUUUYYaaaaaaaceeeeiiiidnoooooouuuuyy';
var
  LCnt1, LCnt2: Integer;
  LChar: Char;
begin
  Result := ATexto;
  for LCnt1 := 1 to Length(Result) do
  begin
    LChar := Result[LCnt1];
    LCnt2 := Pos(LChar, ComAcento);
    if LCnt2 > 0 then
      Result[LCnt1] := SemAcento[LCnt2];
  end;
end;

end.
