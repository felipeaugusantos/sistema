unit untDataFreteImportarNotaFiscalJson;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, Math, System.DateUtils,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types;
  {$ELSE }
  untFuncoesSimples, REST.Client, Uni;  {$ENDIF LINUX}

type
  TRetornoDataFreteImportarNotaFiscalJson = class
  private
    FCodigo_retorno: Extended;
    FMensagem: String;
  public
    property codigo_retorno: Extended read FCodigo_retorno write FCodigo_retorno;
    property mensagem: String read FMensagem write FMensagem;
    class function FromJsonString(AJsonString: string): TRetornoDataFreteImportarNotaFiscalJson;
  end;

  TInfCompClass = class
  private
    FNumero_pedido: String;
  public
    property numero_pedido: String read FNumero_pedido write FNumero_pedido;
  end;

  TDataFreteImportarNotaFiscalJson = class
  private
    FInfComp: TInfCompClass;
    FXml: String;
  public
    property infComp: TInfCompClass read FInfComp write FInfComp;
    property xml: String read FXml write FXml;
    constructor Create;
    destructor Destroy; override;

    class function fNew: TDataFreteImportarNotaFiscalJson;

    function setXml(AValue: String): TDataFreteImportarNotaFiscalJson;
    function setNumeroPedido(AValue: String): TDataFreteImportarNotaFiscalJson;

    function ToJsonString: string;

    function fEnviarXml(strSeqFgo: String): TRetornoDataFreteImportarNotaFiscalJson;
  end;

implementation

uses untRestApi, untDataFreteRestApi;

{ TRetornoDataFreteImportarNotaFiscalJson }

class function TRetornoDataFreteImportarNotaFiscalJson.FromJsonString(
  AJsonString: string): TRetornoDataFreteImportarNotaFiscalJson;
begin
  Result := TJson.JsonToObject<TRetornoDataFreteImportarNotaFiscalJson>(AJsonString);
end;


{TDataFreteImportarNotaFiscalJson}

constructor TDataFreteImportarNotaFiscalJson.Create;
begin
  inherited;
  FInfComp := TInfCompClass.Create();
end;

destructor TDataFreteImportarNotaFiscalJson.Destroy;
begin
  FInfComp.free;
  inherited;
end;

class function TDataFreteImportarNotaFiscalJson.fNew: TDataFreteImportarNotaFiscalJson;
begin
  Result := TDataFreteImportarNotaFiscalJson.Create;
end;

function TDataFreteImportarNotaFiscalJson.setNumeroPedido(
  AValue: String): TDataFreteImportarNotaFiscalJson;
begin
  FInfComp.FNumero_pedido := AValue;
  Result := Self;
end;

function TDataFreteImportarNotaFiscalJson.setXml(
  AValue: String): TDataFreteImportarNotaFiscalJson;
begin
  FXml := AValue;
  Result := Self;
end;

function TDataFreteImportarNotaFiscalJson.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

function TDataFreteImportarNotaFiscalJson.fEnviarXml(strSeqFgo: String): TRetornoDataFreteImportarNotaFiscalJson;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('DATAFRETE',
                                           TControllerDataFrete.fConfigurarDataFreteServico,
                                           TLimitHeader.fNew.f_HeaderField('X-RATELIMIT-RETRY-AFTER').f_Separator(':').f_IncTime(tmrSecond));
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'nota-fiscal';
    RestRequest.Method := rmPOST;

    RestRequest.Params.AddItem('x-api-key', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFTOS', VS_strCodEmp], True, EmptyStr), pkHTTPHEADER);

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
      Result := TRetornoDataFreteImportarNotaFiscalJson.FromJsonString(JSONRetorno);
      if Result.codigo_retorno <> 1 then
        Result := nil;
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;

end;

end.
