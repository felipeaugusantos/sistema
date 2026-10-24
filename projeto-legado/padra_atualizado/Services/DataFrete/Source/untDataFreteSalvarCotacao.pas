unit untDataFreteSalvarCotacao;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;
  {$ENDIF LINUX}

type
  TRetornoDataFreteSalvarCotacao = class
  private
    FCodigo_retorno: Extended;
    FData: String;
  public
    property codigo_retorno: Extended read FCodigo_retorno write FCodigo_retorno;
    property data: String read FData write FData;
    class function FromJsonString(AJsonString: string): TRetornoDataFreteSalvarCotacao;
  end;

  TDataFreteSalvarCotacaoNotaFiscal = class
  private
    FCod_tabela: Extended;
    FCotacao_id: String;
    FNota_fiscal: String;
    FPedido: String;
    FSerie_documento: String;
    FToken: String;
  public
    property cod_tabela: Extended read FCod_tabela write FCod_tabela;
    property cotacao_id: String read FCotacao_id write FCotacao_id;
    property nota_fiscal: String read FNota_fiscal write FNota_fiscal;
    property pedido: String read FPedido write FPedido;
    property serie_documento: String read FSerie_documento write FSerie_documento;
    property token: String read FToken write FToken;
    function ToJsonString: string;

    class function fNew: TDataFreteSalvarCotacaoNotaFiscal;

    function setCod_tabela(AValue: Extended): TDataFreteSalvarCotacaoNotaFiscal;
    function setCotacao_id(AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
    function setNota_fiscal(AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
    function setPedido(AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
    function setSerie_documento(AValue: String): TDataFreteSalvarCotacaoNotaFiscal;

    function fSalvarCotacao(strSeqFgo: String): TRetornoDataFreteSalvarCotacao;
  end;

  TDataFreteSalvarCotacaoPedido = class
  private
    FCod_tabela: Extended;
    FCotacao_id: String;
    FPedido: String;
    FToken: String;
  public
    property cod_tabela: Extended read FCod_tabela write FCod_tabela;
    property cotacao_id: String read FCotacao_id write FCotacao_id;
    property pedido: String read FPedido write FPedido;
    property token: String read FToken write FToken;
    function ToJsonString: string;

    class function fNew: TDataFreteSalvarCotacaoPedido;

    function setCod_tabela(AValue: Extended): TDataFreteSalvarCotacaoPedido;
    function setCotacao_id(AValue: String): TDataFreteSalvarCotacaoPedido;
    function setPedido(AValue: String): TDataFreteSalvarCotacaoPedido;

    function fSalvarCotacao(strSeqFgo: String): TRetornoDataFreteSalvarCotacao;
  end;

implementation

uses untDataFreteRestApi, untRestApi;

{TRetornoDataFreteSalvarCotacao}

class function TRetornoDataFreteSalvarCotacao.FromJsonString(AJsonString: string): TRetornoDataFreteSalvarCotacao;
begin
  Result := TJson.JsonToObject<TRetornoDataFreteSalvarCotacao>(AJsonString);
end;

{TDataFreteSalvarCotacaoPedido}

function TDataFreteSalvarCotacaoPedido.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TDataFreteSalvarCotacaoPedido.fNew: TDataFreteSalvarCotacaoPedido;
begin
  Result := TDataFreteSalvarCotacaoPedido.Create;
end;

function TDataFreteSalvarCotacaoPedido.setCod_tabela(
  AValue: Extended): TDataFreteSalvarCotacaoPedido;
begin
  FCod_tabela := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoPedido.setCotacao_id(
  AValue: String): TDataFreteSalvarCotacaoPedido;
begin
  FCotacao_id := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoPedido.setPedido(
  AValue: String): TDataFreteSalvarCotacaoPedido;
begin
  FPedido := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoPedido.fSalvarCotacao(strSeqFgo: String): TRetornoDataFreteSalvarCotacao;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  Self.token := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFTOC', VS_strCodEmp], True, EmptyStr);

  ControllerRest := TControllerRest.Create('DATAFRETE',
                                           TControllerDataFrete.fConfigurarDataFreteCotacao,
                                           TLimitHeader.fNew.f_HeaderField('X-RATELIMIT-RETRY-AFTER').f_IncTime(tmrSecond));
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'cotacao';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqFgo) then
    begin
      Result := TRetornoDataFreteSalvarCotacao.FromJsonString(JSONRetorno);
      if Result.codigo_retorno <> 1 then
        Result := nil;
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

{TDataFreteSalvarCotacaoNotaFiscal}

function TDataFreteSalvarCotacaoNotaFiscal.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;

class function TDataFreteSalvarCotacaoNotaFiscal.fNew: TDataFreteSalvarCotacaoNotaFiscal;
begin
  Result := TDataFreteSalvarCotacaoNotaFiscal.Create;
end;

function TDataFreteSalvarCotacaoNotaFiscal.setCod_tabela(
  AValue: Extended): TDataFreteSalvarCotacaoNotaFiscal;
begin
  FCod_tabela := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoNotaFiscal.setCotacao_id(
  AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
begin
  FCotacao_id := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoNotaFiscal.setNota_fiscal(
  AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
begin
  FNota_fiscal := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoNotaFiscal.setPedido(
  AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
begin
  FPedido := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoNotaFiscal.setSerie_documento(
  AValue: String): TDataFreteSalvarCotacaoNotaFiscal;
begin
  FSerie_documento := AValue;
  Result := Self;
end;

function TDataFreteSalvarCotacaoNotaFiscal.fSalvarCotacao(strSeqFgo: String): TRetornoDataFreteSalvarCotacao;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  Self.token := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFTOC', VS_strCodEmp], True, EmptyStr);

  ControllerRest := TControllerRest.Create('DATAFRETE',
                                           TControllerDataFrete.fConfigurarDataFreteCotacao,
                                           TLimitHeader.fNew.f_HeaderField('X-RATELIMIT-RETRY-AFTER').f_Separator(':').f_IncTime(tmrSecond));
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'cotacao';
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], strSeqFgo) then
    begin
      Result := TRetornoDataFreteSalvarCotacao.FromJsonString(JSONRetorno);
      if Result.codigo_retorno <> 1 then
        Result := nil;
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
