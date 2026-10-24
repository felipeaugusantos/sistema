unit untDataFreteCalcularFrete;

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
  TRedespachoClass = class
  private
    FAliquota_icms: Extended;
    FCnpj_transportador: String;
    FCod_tabela: String;
    FCod_transportador: String;
    FDescricao: String;
    FNome_transportador: String;
    FNr_trecho: Extended;
    FPrazo: Extended;
    FValor_frete: Extended;
    FValor_icms: Extended;
  public
    property aliquota_icms: Extended read FAliquota_icms write FAliquota_icms;
    property cnpj_transportador: String read FCnpj_transportador write FCnpj_transportador;
    property cod_tabela: String read FCod_tabela write FCod_tabela;
    property cod_transportador: String read FCod_transportador write FCod_transportador;
    property descricao: String read FDescricao write FDescricao;
    property nome_transportador: String read FNome_transportador write FNome_transportador;
    property nr_trecho: Extended read FNr_trecho write FNr_trecho;
    property prazo: Extended read FPrazo write FPrazo;
    property valor_frete: Extended read FValor_frete write FValor_frete;
    property valor_icms: Extended read FValor_icms write FValor_icms;
  end;

  TDataClass = class
  private
    FAliquota_icms: Extended;
    FCnpj_transportador: String;
    FCod_tabela: String;
    FCod_transportador: String;
    FData_previsao_entrega: TDate;
    FData_simulacao: TDate;
    FDescricao: String;
    FHora_simulacao: String;
    FNome_transportador: String;
    FPrazo: Extended;
    FPrazo_exibicao: Extended;
    FRedespacho: TArray<TRedespachoClass>;
    FTp_entrega: String;
    FValor_frete: Extended;
    FValor_frete_exibicao: Extended;
    FValor_icms: Extended;
  public
    property aliquota_icms: Extended read FAliquota_icms write FAliquota_icms;
    property cnpj_transportador: String read FCnpj_transportador write FCnpj_transportador;
    property cod_tabela: String read FCod_tabela write FCod_tabela;
    property cod_transportador: String read FCod_transportador write FCod_transportador;
    property data_previsao_entrega: TDate read FData_previsao_entrega write FData_previsao_entrega;
    property data_simulacao: TDate read FData_simulacao write FData_simulacao;
    property descricao: String read FDescricao write FDescricao;
    property hora_simulacao: String read FHora_simulacao write FHora_simulacao;
    property nome_transportador: String read FNome_transportador write FNome_transportador;
    property prazo: Extended read FPrazo write FPrazo;
    property prazo_exibicao: Extended read FPrazo_exibicao write FPrazo_exibicao;
    property redespacho: TArray<TRedespachoClass> read FRedespacho write FRedespacho;
    property tp_entrega: String read FTp_entrega write FTp_entrega;
    property valor_frete: Extended read FValor_frete write FValor_frete;
    property valor_frete_exibicao: Extended read FValor_frete_exibicao write FValor_frete_exibicao;
    property valor_icms: Extended read FValor_icms write FValor_icms;
    destructor Destroy; override;
  end;

  TRetornoDataFreteCalcularFrete = class
  private
    FCodigo_retorno: Extended;
    FData: TArray<TDataClass>;
    FId_cotacao: String;
  public
    property codigo_retorno: Extended read FCodigo_retorno write FCodigo_retorno;
    property data: TArray<TDataClass> read FData write FData;
    property id_cotacao: String read FId_cotacao write FId_cotacao;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoDataFreteCalcularFrete;
  end;

  TInfCompClass = class
  private
    FDoc_destinatario: String;
    FDoc_empresa: String;
  public
    property doc_destinatario: String read FDoc_destinatario write FDoc_destinatario;
    property doc_empresa: String read FDoc_empresa write FDoc_empresa;
  end;

  TProdutosClass = class
  private
    FAltura: Extended;
    FComprimento: Extended;
    FDescricao: String;
    FLargura: Extended;
    FPeso: Extended;
    FPreco: Extended;
    FQtd: Extended;
    FSku: String;
    FVolume: Extended;
  public
    property altura: Extended read FAltura write FAltura;
    property comprimento: Extended read FComprimento write FComprimento;
    property descricao: String read FDescricao write FDescricao;
    property largura: Extended read FLargura write FLargura;
    property peso: Extended read FPeso write FPeso;
    property preco: Extended read FPreco write FPreco;
    property qtd: Extended read FQtd write FQtd;
    property sku: String read FSku write FSku;
    property volume: Extended read FVolume write FVolume;
  end;

  TDataFreteCalcularFrete = class
  private
    FCepDestino: Extended;
    FCepOrigem: Extended;
    FInfComp: TInfCompClass;
    FProdutos: TArray<TProdutosClass>;
    FToken: String;

    procedure pAddProduto(Produto: TProdutosClass);
  public
    property cepDestino: Extended read FCepDestino write FCepDestino;
    property cepOrigem: Extended read FCepOrigem write FCepOrigem;
    property infComp: TInfCompClass read FInfComp write FInfComp;
    property produtos: TArray<TProdutosClass> read FProdutos write FProdutos;
    property token: String read FToken write FToken;

    constructor Create;
    destructor Destroy; override;

    class function fNew: TDataFreteCalcularFrete;
    function fNewProduto: TProdutosClass;

    function ToJsonString: string;

    function fCalcularFrete(): TRetornoDataFreteCalcularFrete;
  end;

implementation

{TDataFreteCalcularFrete}

uses untRestApi, untDataFreteRestApi;

constructor TDataFreteCalcularFrete.Create;
begin
  inherited;
  FInfComp := TInfCompClass.Create();
end;

destructor TDataFreteCalcularFrete.Destroy;
var
  LprodutosItem: TProdutosClass;
begin

 for LprodutosItem in FProdutos do
   LprodutosItem.free;

  FInfComp.free;
  inherited;
end;

class function TDataFreteCalcularFrete.fNew: TDataFreteCalcularFrete;
begin
  Result := Self.Create;
end;

function TDataFreteCalcularFrete.fNewProduto: TProdutosClass;
begin
  Result := TProdutosClass.Create;
  pAddProduto(Result);
end;

procedure TDataFreteCalcularFrete.pAddProduto(Produto: TProdutosClass);
begin
  SetLength(FProdutos, Length(FProdutos)+1);
  FProdutos[Length(FProdutos)-1] := Produto;
end;

function TDataFreteCalcularFrete.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

{TDataClass}

destructor TDataClass.Destroy;
var
  LredespachoItem: TRedespachoClass;
begin

 for LredespachoItem in FRedespacho do
   LredespachoItem.free;

  inherited;
end;

{TRetornoDataFreteCalcularFrete}

destructor TRetornoDataFreteCalcularFrete.Destroy;
var
  LdataItem: TDataClass;
begin

 for LdataItem in FData do
   LdataItem.free;

  inherited;
end;

class function TRetornoDataFreteCalcularFrete.FromJsonString(AJsonString: string): TRetornoDataFreteCalcularFrete;
begin
  Result := TJson.JsonToObject<TRetornoDataFreteCalcularFrete>(AJsonString)
end;

function TDataFreteCalcularFrete.fCalcularFrete(): TRetornoDataFreteCalcularFrete;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  Self.token := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTFTOC', VS_strCodEmp], True, EmptyStr);

  ControllerRest := TControllerRest.Create('DATAFRETE', TControllerDataFrete.fConfigurarDataFreteCotacao);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method := rmPOST;

    RESTRequest
    .Params
    .AddItem(  '',
               ToJsonString,
               TRestRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON
             );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TRetornoDataFreteCalcularFrete.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
