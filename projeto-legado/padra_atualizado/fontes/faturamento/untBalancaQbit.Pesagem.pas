unit untBalancaQbit.Pesagem;

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
  TPesagens = class
  private
    FBalancaBruto: String;
    FBalancaTara: String;
    FCPFCNPJCliente: String;
    FCPFCNPJProdutor: String;
    FCPFCNPJTransportadora: String;
    FCPFMotorista: String;
    FCancelada: Boolean;
    FCodigo: String;
    FCodigoCliente: String;
    FCodigoMotorista: String;
    FCodigoPrePesagem: Extended;
    FCodigoProduto: String;
    FCodigoProdutor: String;
    FCodigoTransportadora: String;
    FDataCadastro: String;
    FDataCancelada: TDateTime;
    FDataEncerramento: String;
    FDataPesagemBruto: TDateTime;
    FDataPesagemBruto2: TDateTime;
    FDataPesagemTara: TDateTime;
    FDataPesagemTara2: TDateTime;
    FDeposito: String;
    FDescricaoProduto: String;
    FDestino: String;
    FDoca: String;
    FIdExternoPrePesagem: String;
    FMinutaRomaneio: String;
    FMotivoBruto: String;
    FMotivoCancelada: String;
    FMotivoLiberacaoDiferenca: String;
    FMotivoTara: String;
    FMovimento: Extended;
    FNomeCliente: String;
    FNomeMotorista: String;
    FNomeProdutor: String;
    FNomeTransportadora: String;
    FNumeroAtual4Etapas: Extended;
    FObservacao: String;
    FOutrosDados1: String;
    FPesagem4Etapas: Boolean;
    FPesoBruto: Extended;
    FPesoBruto1: Extended;
    FPesoBruto2: Extended;
    FPesoDesconto: Extended;
    FPesoDiferenca: Extended;
    FPesoLiquido: Extended;
    FPesoNF: Extended;
    FPesoSeco: Extended;
    FPesoTara: Extended;
    FPesoTara1: Extended;
    FPesoTara2: Extended;
    FPesoTotalEixo: Extended;
    FPlacaCarreta: String;
    FPlacaCavalo: String;
    FPorcentagemDiferenca: Extended;
    FSacas: Extended;
    FStatus: Extended;
    FUsuarioCancelada: String;
    FUsuarioLiberacaoDiferenca: String;
    FUsuarioPesagem1: String;
    FUsuarioPesagem2: String;
  public
    property BalancaBruto: String read FBalancaBruto write FBalancaBruto;
    property BalancaTara: String read FBalancaTara write FBalancaTara;
    property CPFCNPJCliente: String read FCPFCNPJCliente write FCPFCNPJCliente;
    property CPFCNPJProdutor: String read FCPFCNPJProdutor write FCPFCNPJProdutor;
    property CPFCNPJTransportadora: String read FCPFCNPJTransportadora write FCPFCNPJTransportadora;
    property CPFMotorista: String read FCPFMotorista write FCPFMotorista;
    property Cancelada: Boolean read FCancelada write FCancelada;
    property Codigo: String read FCodigo write FCodigo;
    property CodigoCliente: String read FCodigoCliente write FCodigoCliente;
    property CodigoMotorista: String read FCodigoMotorista write FCodigoMotorista;
    property CodigoPrePesagem: Extended read FCodigoPrePesagem write FCodigoPrePesagem;
    property CodigoProduto: String read FCodigoProduto write FCodigoProduto;
    property CodigoProdutor: String read FCodigoProdutor write FCodigoProdutor;
    property CodigoTransportadora: String read FCodigoTransportadora write FCodigoTransportadora;
    property DataCadastro: String read FDataCadastro write FDataCadastro;
    property DataCancelada: TDateTime read FDataCancelada write FDataCancelada;
    property DataEncerramento: String read FDataEncerramento write FDataEncerramento;
    property DataPesagemBruto: TDateTime read FDataPesagemBruto write FDataPesagemBruto;
    property DataPesagemBruto2: TDateTime read FDataPesagemBruto2 write FDataPesagemBruto2;
    property DataPesagemTara: TDateTime read FDataPesagemTara write FDataPesagemTara;
    property DataPesagemTara2: TDateTime read FDataPesagemTara2 write FDataPesagemTara2;
    property Deposito: String read FDeposito write FDeposito;
    property DescricaoProduto: String read FDescricaoProduto write FDescricaoProduto;
    property Destino: String read FDestino write FDestino;
    property Doca: String read FDoca write FDoca;
    property IdExternoPrePesagem: String read FIdExternoPrePesagem write FIdExternoPrePesagem;
    property MinutaRomaneio: String read FMinutaRomaneio write FMinutaRomaneio;
    property MotivoBruto: String read FMotivoBruto write FMotivoBruto;
    property MotivoCancelada: String read FMotivoCancelada write FMotivoCancelada;
    property MotivoLiberacaoDiferenca: String read FMotivoLiberacaoDiferenca write FMotivoLiberacaoDiferenca;
    property MotivoTara: String read FMotivoTara write FMotivoTara;
    property Movimento: Extended read FMovimento write FMovimento;
    property NomeCliente: String read FNomeCliente write FNomeCliente;
    property NomeMotorista: String read FNomeMotorista write FNomeMotorista;
    property NomeProdutor: String read FNomeProdutor write FNomeProdutor;
    property NomeTransportadora: String read FNomeTransportadora write FNomeTransportadora;
    property NumeroAtual4Etapas: Extended read FNumeroAtual4Etapas write FNumeroAtual4Etapas;
    property Observacao: String read FObservacao write FObservacao;
    property OutrosDados1: String read FOutrosDados1 write FOutrosDados1;
    property Pesagem4Etapas: Boolean read FPesagem4Etapas write FPesagem4Etapas;
    property PesoBruto: Extended read FPesoBruto write FPesoBruto;
    property PesoBruto1: Extended read FPesoBruto1 write FPesoBruto1;
    property PesoBruto2: Extended read FPesoBruto2 write FPesoBruto2;
    property PesoDesconto: Extended read FPesoDesconto write FPesoDesconto;
    property PesoDiferenca: Extended read FPesoDiferenca write FPesoDiferenca;
    property PesoLiquido: Extended read FPesoLiquido write FPesoLiquido;
    property PesoNF: Extended read FPesoNF write FPesoNF;
    property PesoSeco: Extended read FPesoSeco write FPesoSeco;
    property PesoTara: Extended read FPesoTara write FPesoTara;
    property PesoTara1: Extended read FPesoTara1 write FPesoTara1;
    property PesoTara2: Extended read FPesoTara2 write FPesoTara2;
    property PesoTotalEixo: Extended read FPesoTotalEixo write FPesoTotalEixo;
    property PlacaCarreta: String read FPlacaCarreta write FPlacaCarreta;
    property PlacaCavalo: String read FPlacaCavalo write FPlacaCavalo;
    property PorcentagemDiferenca: Extended read FPorcentagemDiferenca write FPorcentagemDiferenca;
    property Sacas: Extended read FSacas write FSacas;
    property Status: Extended read FStatus write FStatus;
    property UsuarioCancelada: String read FUsuarioCancelada write FUsuarioCancelada;
    property UsuarioLiberacaoDiferenca: String read FUsuarioLiberacaoDiferenca write FUsuarioLiberacaoDiferenca;
    property UsuarioPesagem1: String read FUsuarioPesagem1 write FUsuarioPesagem1;
    property UsuarioPesagem2: String read FUsuarioPesagem2 write FUsuarioPesagem2;
  end;

  TBalancaQbitPesagem = class
  private
    FCodigoRetorno: String;
    FDescricaoRetorno: String;
    FPesagens: TArray<TPesagens>;
  public
    property CodigoRetorno: String read FCodigoRetorno write FCodigoRetorno;
    property DescricaoRetorno: String read FDescricaoRetorno write FDescricaoRetorno;
    property Pesagens: TArray<TPesagens> read FPesagens write FPesagens;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TBalancaQbitPesagem;

    class function fConsultarPesagemPeriodo(const dtaIni, dtaFin: TDate): TBalancaQbitPesagem;
    class function fConsultarPesagemTicket(const strTicket: String): TBalancaQbitPesagem;
  end;

  const
    SUCESSO = '0';

implementation

{TBalancaQbitPesagem}

uses untBalancaQbitRestApi, untRestApi;

destructor TBalancaQbitPesagem.Destroy;
var
  LPesagensItem: TPesagens;
begin

 for LPesagensItem in FPesagens do
   LPesagensItem.free;

  inherited;
end;

class function TBalancaQbitPesagem.FromJsonString(AJsonString: string): TBalancaQbitPesagem;
begin
  result := TJson.JsonToObject<TBalancaQbitPesagem>(AJsonString)
end;

class function TBalancaQbitPesagem.fConsultarPesagemPeriodo(const dtaIni, dtaFin: TDate): TBalancaQbitPesagem;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QBIT', TControllerConfigurarQbit.fConfigurarQbit);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'api/Pesagem/ConsultarPesagens';
    RestRequest.Method := rmGET;

    RestRequest.Params.AddItem('_Chave', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_QBTKEY', VS_strCodEmp]), pkGETorPOST);
    RestRequest.Params.AddItem('_DataInicio', FormatDateTime('ddMMyyyy', dtaIni) , pkGETorPOST);
    RestRequest.Params.AddItem('_DataFim', FormatDateTime('ddMMyyyy', dtaFin) , pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TBalancaQbitPesagem.FromJsonString(JSONRetorno);

    if (Assigned(Result)) and (Result.CodigoRetorno <> SUCESSO) then
    begin
      fMensagem('ATENÇÃO!',Result.DescricaoRetorno,['&OK']);
      Result := nil
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

class function TBalancaQbitPesagem.fConsultarPesagemTicket(const strTicket: String): TBalancaQbitPesagem;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('QBIT', TControllerConfigurarQbit.fConfigurarQbit);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'api/Pesagem/Consultar';
    RestRequest.Method := rmGET;

    RestRequest.Params.AddItem('_Chave', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_QBTKEY', VS_strCodEmp]), pkGETorPOST);
    RestRequest.Params.AddItem('_Codigo', strTicket , pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], EmptyStr) then
      Result := TBalancaQbitPesagem.FromJsonString(JSONRetorno);

    if (Assigned(Result)) and (Result.CodigoRetorno <> SUCESSO) then
    begin
      fMensagem('ATENÇÃO!',Result.DescricaoRetorno,['&OK']);
      Result := nil
    end;

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
