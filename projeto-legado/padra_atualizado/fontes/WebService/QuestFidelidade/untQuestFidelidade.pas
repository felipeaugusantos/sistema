unit untQuestFidelidade;

interface

uses Generics.Collections, Rest.Json, REST.Client, REST.Types, SysUtils,
     IdHTTP, IdURI, Classes, System.NetEncoding, IdAuthentication, System.json,
     Uni, Types, Data.DB, strUtils, UniClientDataSet, System.DateUtils;

type

TConsultaDadosParticipanteQuest = class
  private
    FCpfCnpjParticipante: string;
    FCnpjParceiro: string;
  public
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
  public
    function ToJsonString: string;
end;

TTelefones = class
  private
    FDDD: integer;
    FNumero: string;
  public
    property DDD: integer read FDDD write FDDD;
    property Numero: string read FNumero write FNumero;
end;

THistoricoCompras = class
  private
    FProduto: string;
    FCompras: integer;
  public
    property Produto: string read FProduto write FProduto;
    property Compras: integer read FCompras write FCompras;
end;

TCampanhas = class
  private
    FID: integer;
    FDescricao: string;
  public
    property ID: integer read FID write FID;
    property Descricao: string read FDescricao write FDescricao;
end;

TParticipante = class
  private
    FCpfCnpjParticipante: string;
    FTelefones: TObjectList<TTelefones>;
    FEmail: string;
    FNome: string;
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FHistoricoCompras: TObjectList<THistoricoCompras>;
    FCampanhas: TObjectList<TCampanhas>;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  private
    class function fJSONArrayToHistoricoComprasList(jsHistoricoCompras: TJSONArray): TObjectList<THistoricoCompras>;
    class function fJSONArrayToTelefonesList(jsTelefones: TJSONArray): TObjectList<TTelefones>;
    class function fJSONArrayToCampanhasList(jsCampanhas: TJSONArray): TObjectList<TCampanhas>;
  public
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property Telefones: TObjectList<TTelefones> read FTelefones write FTelefones;
    property Email: string read FEmail write FEmail;
    property Nome: string read FNome write FNome;
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property HistoricoCompras: TObjectList<THistoricoCompras> read FHistoricoCompras write FHistoricoCompras;
    property Campanhas: TObjectList<TCampanhas> read FCampanhas write FCampanhas;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TParticipante;
end;

TPreCadastro = class
  private
    FCnpjParceiro: string;
    FCpfCnpjParticipante: string;
    FPrimeiroNome: string;
    FDDD: integer;
    FNumero: string;
    FEmail: string;
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  public
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property PrimeiroNome: string read FPrimeiroNome write FPrimeiroNome;
    property DDD: integer read FDDD write FDDD;
    property Numero: string read FNumero write FNumero;
    property Email: string read FEmail write FEmail;
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    function ToJsonString: string;
end;

TRetornoPreCadastro = class
  private
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  public
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    class function FromJsonString(AJsonString: string): TRetornoPreCadastro;
end;

TProdutosQuest = class
  private
    FAcumula: integer;
    FCodigo: string;
    FDescricao: string;
    FUnidade: string;
    FQuantidade: Double;
    FValorUnitario: Double;
    FComplemento: string;
  public
    property Acumula: integer read FAcumula write FAcumula;
    property Codigo: string read FCodigo write FCodigo;
    property Descricao: string read FDescricao write FDescricao;
    property Unidade: string read FUnidade write FUnidade;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnitario: Double read FValorUnitario write FValorUnitario;
    property Complemento: string read FComplemento write FComplemento;
end;

TAcumula = class
  private
    FCnpjParceiro: string;
    FCpfCnpjParticipante: string;
    FCpfOperador: string;
    FValorTotalCompra: Double;
    FMeioPagamento: integer;
    FPerfil: integer;
    FProdutos: TObjectList<TProdutosQuest>;
  public
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property CpfOperador: string read FCpfOperador write FCpfOperador;
    property ValorTotalCompra: Double read FValorTotalCompra write FValorTotalCompra;
    property MeioPagamento: integer read FMeioPagamento write FMeioPagamento;
    property Perfil: integer read FPerfil write FPerfil;
    property Produtos: TObjectList<TProdutosQuest> read FProdutos write FProdutos;
  public
    constructor Create;
    Destructor Destroy; override;
    function ToJsonString: string;
end;

TRetornoAcumula = class
  private
    FPontosAcumuladosParticipante: Double;
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  public
    property PontosAcumuladosParticipante: Double read FPontosAcumuladosParticipante write FPontosAcumuladosParticipante;
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    class function FromJsonString(AJsonString: string): TRetornoAcumula;
end;

TResgata = class
  private
    FCnpjParceiro: string;
    FCpfCnpjParticipante: string;
    FSenhaParticipante: string;
    FCpfOperador: string;
    FPontosResgate: Double;
    FValorTotalCompra: Double;
    FMeioPagamento: integer;
    FPerfil: integer;
    FProdutos: TObjectList<TProdutosQuest>;
  public
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property SenhaParticipante: string read FSenhaParticipante write FSenhaParticipante;
    property CpfOperador: string read FCpfOperador write FCpfOperador;
    property PontosResgate: Double read FPontosResgate write FPontosResgate;
    property ValorTotalCompra: Double read FValorTotalCompra write FValorTotalCompra;
    property MeioPagamento: integer read FMeioPagamento write FMeioPagamento;
    property Perfil: integer read FPerfil write FPerfil;
    property Produtos: TObjectList<TProdutosQuest> read FProdutos write FProdutos;
  public
    constructor Create;
    destructor Destroy; override;
    function ToJsonString: string;
end;

TRetornoResgate = class
  private
    FPontosResgatados: Double;
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  public
    property PontosResgatados: Double read FPontosResgatados write FPontosResgatados;
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    class function FromJsonString(AJsonString: string): TRetornoResgate;
end;

TGeraToken = class
  private
    FCpfCnpjParticipante: string;
    FCnpjParceiro: string;
    FPontosResgate: Double;
  public
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
    property PontoResgate: Double read FPontosResgate write FPontosResgate;
  public
    function ToJsonString: string;
end;

TRetornoToken = class
  private
    FErro: Boolean;
    FMensagem: string;
  public
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    class function FromJsonString(AJsonString: string): TRetornoToken;
end;

TEstornaQuest = class
  private
    FCnpjParceiro: string;
    FCpfCnpjParticipante: string;
    FTransacaoID: integer;
  public
    property CnpjParceiro: string read FCnpjParceiro write FCnpjParceiro;
    property CpfCnpjParticipante: string read FCpfCnpjParticipante write FCpfCnpjParticipante;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
  public
    function ToJsonString: string;
end;

TRetornoEstorno = class
  private
    FPontosEstornados: Double;
    FSaldoDisponivelPontos: Double;
    FSaldoDisponivelValor: Double;
    FTransacaoID: integer;
    FErro: Boolean;
    FMensagem: string;
  public
    property PontosEstornados: Double read FPontosEstornados write FPontosEstornados;
    property SaldoDisponivelPontos: Double read FSaldoDisponivelPontos write FSaldoDisponivelPontos;
    property SaldoDisponivelValor: Double read FSaldoDisponivelValor write FSaldoDisponivelValor;
    property TransacaoID: integer read FTransacaoID write FTransacaoID;
    property Erro: Boolean read FErro write FErro;
    property Mensagem: string read FMensagem write FMensagem;
  public
    class function FromJsonString(AJsonString: string): TRetornoEstorno;
end;

Const
  QUEST_MAX_DIAS_ESTORNO = 7;
  QUEST_COMAND_ACUMULA = 'ACUMULA';
  QUEST_COMAND_RESGATA = 'RESGATA';
  QUEST_COMAND_ESTORNA = 'ESTORNA';

function fComunica(strUrl: String; strGetPost: String; strJson: String = ''): string;
function fConsultaQuestFidelidade(strCpfCnpjParticipante, strCnpjParceiro: string): TParticipante;
function fAcumulaPontosQuest(AAcumula: TAcumula): TRetornoAcumula;
function fRetornaClasseAcumulaQuest(strAutInc, strCnpjParceiro, strDocCli: string; fltTotalItens: Double): TAcumula;
function fRetornaClasseAcumulaQuestCDS(strCnpjParceiro, strDocCli: string; fltTotalItens: Double; cdsItens: TUniClientDataSet): TAcumula;
function fRetornaClasseResgateQuest(strAutInc, strCnpjParceiro, strDocCli: string; fltTotalItens, fltPontosResgate: Double): TResgata;
function fRetornaClasseResgateQuestCDS(strCnpjParceiro, strDocCli: string; fltTotalItens, fltPontosResgate: Double; cdsItens: TUniClientDataSet): TResgata;
function fGeraTokenQuest(strCnpjParceiro, strCpfCnpjParticipante: string; fltPontosResgate: Double): TRetornoToken;
function fGravaTransacaoQuest(intIdTrans: integer; strDocCli, strComando, strJSON: string; var strAutInc: string; strRegEst: string = ''; strNumDoc: string = ''; strEspDoc: string = ''): Boolean;
function fEstornaPontosQuest(AEstornoQuest: TEstornaQuest): TRetornoEstorno;
function fResgataPontosQuest(AResgata: TResgata): TRetornoResgate;
function fOcorreuTransacao(strAutInc: string; intTransacaoID: integer): Boolean;
function fOcorreuEstorno(strAutInc, strIncReg: string; intTransacaoID: integer): Boolean;
function fEstornaPontosQuestAutomatico(strAutInc, strIncReg, strJsonEnvio: string): Boolean;
function fItemAcumulaPontosQuest(strCodIte: string): integer;
procedure pBuscaClienteQuestNoAutcom(strCpfCnpj: string; blnCliCon: Boolean; var APreCadastro: TPreCadastro);
procedure pPreCadastroQuestFidelidade(var APreCadastro: TPreCadastro);
procedure pBuscaInformacaoEstornoQuest(var strCnpjParceiro, strCpfCnpjParticipante: string; var intTransacaoID: integer; var dtaDataTransacao: TDate; strNumDoc, strEspDoc, strCodEmp: string; var strAutInc: string);
procedure pControlaQuestFidelidade;
procedure pConfirmaTransacaoQuest(strAutInc, strNumDoc, strEspDoc: string);
procedure pCancelaTransacaoQuestSemVenda(strAutInc: string);
procedure pBuscaTransacaoQuestSemVenda;
function fBuscaPerfilPelaTabelaDePreco(strDocCli: string): integer;
function fBuscaPerfilCliente(strDocCli: string): integer;
function fBuscaInformacaoEstornoQuest(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
function fEstornaQuestFidelidade(strNumDoc, strEspDoc, strCodEmp: String; blnAvisoDiasMax: Boolean = False): Boolean;

implementation

uses
  untFuncoesSimples, untFuncoesGenerica;

{ TConsultaDadosParticipanteQuest }

function TConsultaDadosParticipanteQuest.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
end;

{ TParticipante }

constructor TParticipante.Create;
begin
  FTelefones := TObjectList<TTelefones>.Create();
  FHistoricoCompras := TObjectList<THistoricoCompras>.Create();
  FCampanhas := TObjectList<TCampanhas>.Create();
end;

destructor TParticipante.Destroy;
begin

  inherited;
end;

class function TParticipante.fJSONArrayToCampanhasList(
  jsCampanhas: TJSONArray): TObjectList<TCampanhas>;
var
  jsValor: TJSONValue;
  jsObjeto: TJSONObject;
  Campanhas: TCampanhas;
begin
  Result := TObjectList<TCampanhas>.Create();

  if jsCampanhas.Count = 0 then
  begin
    Campanhas := TCampanhas.Create;
    Campanhas.ID := 0;
    Campanhas.Descricao := '';
    Result.Add(Campanhas);
  end
  else
  begin
    for jsValor in jsCampanhas do
    begin
      jsObjeto := (jsValor as TJSONObject);
      Campanhas := TCampanhas.Create;
      Campanhas.ID := (jsObjeto.GetValue('ID') as TJSONNumber).AsInt;
      Campanhas.Descricao := (jsObjeto.GetValue('Descricao') as TJSONString).Value;
      Result.Add(Campanhas);
    end;
  end;
end;

class function TParticipante.fJSONArrayToHistoricoComprasList(
  jsHistoricoCompras: TJSONArray): TObjectList<THistoricoCompras>;
var
  jsValor: TJSONValue;
  jsObjeto: TJSONObject;
  HistoricoCompras: THistoricoCompras;
begin
  Result := TObjectList<THistoricoCompras>.Create();

  if jsHistoricoCompras.Count = 0 then
  begin
    HistoricoCompras := THistoricoCompras.Create;
    HistoricoCompras.Produto := '';
    HistoricoCompras.Compras := 0;
    Result.Add(HistoricoCompras);
  end
  else
  begin
    for jsValor in jsHistoricoCompras do
    begin
      jsObjeto := (jsValor as TJSONObject);
      HistoricoCompras := THistoricoCompras.Create;
      HistoricoCompras.Produto := (jsObjeto.GetValue('Produto') as TJSONString).Value;
      HistoricoCompras.Compras := (jsObjeto.GetValue('Compras') as TJSONNumber).AsInt;
      Result.Add(HistoricoCompras);
    end;
  end;
end;

class function TParticipante.fJSONArrayToTelefonesList(
  jsTelefones: TJSONArray): TObjectList<TTelefones>;
var
  jsValor: TJSONValue;
  jsObjeto: TJSONObject;
  Telefones: TTelefones;
begin
  Result := TObjectList<TTelefones>.Create();

  if jsTelefones.Count = 0 then
  begin
    Telefones := TTelefones.Create;
    Telefones.DDD := 0;
    Telefones.Numero := '';
    Result.Add(Telefones);
  end
  else
  begin
    for jsValor in jsTelefones do
    begin
      jsObjeto := (jsValor as TJSONObject);
      Telefones := TTelefones.Create;
      Telefones.DDD := (jsObjeto.GetValue('DDD') as TJSONNumber).AsInt;
      Telefones.Numero := (jsObjeto.GetValue('Numero') as TJSONString).Value;
      Result.Add(Telefones);
    end;
  end;
end;

class function TParticipante.FromJsonString(
  AJsonString: string): TParticipante;
var
  jsResposta: TJSONObject;
  jsParticipante: TJSONObject;
  jsTelefones: TJSONArray;
  jsHistoricoCompras: TJSONArray;
  jsCampanhas: TJSONArray;
begin
  Result := TParticipante.Create;

  jsResposta := TJSONObject.ParseJSONValue(AJsonString) as TJSONObject;

  Result.TransacaoID := (jsResposta.GetValue('TransacaoID') as TJSONNumber).AsInt;
  Result.Erro := (jsResposta.GetValue('Erro') as TJSONBool).AsBoolean;
  Result.Mensagem := (jsResposta.GetValue('Mensagem') as TJSONString).Value;

  if not Result.Erro then
  begin
    jsParticipante := (jsResposta.GetValue('Participante') as TJSONObject);
    jsTelefones := (jsParticipante.GetValue('Telefones') as TJSONArray);
    jsHistoricoCompras := (jsResposta.GetValue('HistoricoCompras') as TJSONArray);
    jsCampanhas := (jsResposta.GetValue('Campanhas') as TJSONArray);

    if not jsParticipante.GetValue('CpfCnpjParticipante').Null then
      Result.CpfCnpjParticipante := (jsParticipante.GetValue('CpfCnpjParticipante') as TJSONString).Value
    else
      Result.CpfCnpjParticipante := '';

    if not jsParticipante.GetValue('Email').Null then
      Result.Email := (jsParticipante.GetValue('Email') as TJSONString).Value
    else
      Result.Email := '';

    if not jsParticipante.GetValue('Nome').Null then
      Result.Nome := (jsParticipante.GetValue('Nome') as TJSONString).Value
    else
      Result.Nome := '';

    Result.SaldoDisponivelPontos := (jsParticipante.GetValue('SaldoDisponivelPontos') as TJSONNumber).AsDouble;
    Result.SaldoDisponivelValor := (jsParticipante.GetValue('SaldoDisponivelValor') as TJSONNumber).AsDouble;

    Result.Telefones := TParticipante.fJSONArrayToTelefonesList(jsTelefones);
    Result.HistoricoCompras := TParticipante.fJSONArrayToHistoricoComprasList(jsHistoricoCompras);
    Result.Campanhas := TParticipante.fJSONArrayToCampanhasList(jsCampanhas);
  end;
end;

function fComunica(strUrl: String; strGetPost: String; strJson: String = ''): string;
var
  IdHTTP1: TIdHttp;
  jsResponse: TStringStream;
  PostData: TStringStream;
begin
  IdHTTP1 := TIdHttp.Create(nil);
  IdHTTP1.ConnectTimeout := 10000;
  IdHTTP1.Request.Clear;

  IdHTTP1.Request.ContentType := 'application/json';
  IdHTTP1.Request.Accept := 'application/json;charset=UTF-8';
  IdHTTP1.Request.CustomHeaders.AddValue('Authorization', fCfgSis('TOKQUE'));
  IdHTTP1.Request.BasicAuthentication := True;
  IdHTTP1.Request.Authentication := TIdBasicAuthentication.Create;
  IdHTTP1.Request.Authentication.Username := fCfgSis('USUQUE');
  IdHTTP1.Request.Authentication.Password := fCfgSis('SENQUE');

  try
    jsResponse := TStringStream.Create('', TEncoding.UTF8);
    strUrl := TIdURI.URLEncode(strUrl);

    if strGetPost = 'GET' then
      IdHTTP1.Get(strUrl, jsResponse)
    else if strGetPost = 'POST' then
    begin
      PostData := TStringStream.Create(strJson, TEncoding.UTF8);
      IdHTTP1.Post(strUrl, PostData, jsResponse);
    end
    else if strGetPost = 'PUT' then
    begin
      PostData := TStringStream.Create(strJson, TEncoding.UTF8);
      IdHTTP1.Put(strUrl, PostData, jsResponse);
    end
    else if strGetPost = 'DELETE' then
    begin
      IdHTTP1.Delete(strUrl, jsResponse);
    end;

    Result := jsResponse.DataString;
  except
    on E: EIdHTTPProtocolException do
    begin
      Result := '*' +IntToStr(IdHTTP1.ResponseCode);
    end;
  end;
end;

function fConsultaQuestFidelidade(strCpfCnpjParticipante, strCnpjParceiro: string): TParticipante;
var
  ConsultaDadosParticipanteQuest: TConsultaDadosParticipanteQuest;
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  ConsultaDadosParticipanteQuest := TConsultaDadosParticipanteQuest.Create;
  Result := TParticipante.Create;

  ConsultaDadosParticipanteQuest.CpfCnpjParticipante := strCpfCnpjParticipante;
  ConsultaDadosParticipanteQuest.CnpjParceiro := strCnpjParceiro;

  strJsonEnvio := ConsultaDadosParticipanteQuest.ToJsonString;

  if fEmptyStr(strJsonEnvio) then
  begin
    Exit;
  end;

  strJsonRetorno := fComunica(fCfgSis('CONQUE'),'POST',strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  Result := TParticipante.FromJsonString(strJsonRetorno);
end;

{ TPreCadastro }

function TPreCadastro.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'primeiroNome', 'PrimeiroNome', [rfReplaceAll]);
  Result := StringReplace(Result, 'dDD', 'DDDCelular', [rfReplaceAll]);
  Result := StringReplace(Result, 'numero', 'NumeroCelular', [rfReplaceAll]);
  Result := StringReplace(Result, 'email', 'Email', [rfReplaceAll]);
end;

procedure pBuscaClienteQuestNoAutcom(strCpfCnpj: string; blnCliCon: Boolean; var APreCadastro: TPreCadastro);
var
  qryBuscaCliente: TUniQuery;
  strSQL: string;
  strTelefone: string;
  intDDD: integer;
begin
  strSQL := '';
  if blnCliCon then
  begin
    strSQL := strSQL + 'SELECT CON_NOMCON AS NOME, CON_FONE01 AS FONE, CON_EMLCON AS EMAIL ';
    strSQL := strSQL + 'FROM CLICON ';
    strSQL := strSQL + 'WHERE CON_C_P_F_ = :DOC ';
  end
  else
  begin
    strSQL := strSQL + 'SELECT CLI_NOMCLI AS NOME, CLI_FONE01 AS FONE, CLI_EMAIL_ AS EMAIL ';
    strSQL := strSQL + 'FROM CADCLI ';
    strSQL := strSQL + 'WHERE CLI_C_G_C_ = :DOC ';
  end;

  try
    qryBuscaCliente := fCriaQuery;
    qryBuscaCliente.Close;
    qryBuscaCliente.SQL.Clear;
    qryBuscaCliente.SQL.Add(strSQL);
    qryBuscaCliente.ParamByName('DOC').AsString := strCpfCnpj;
    qryBuscaCliente.Open;

    APreCadastro := TPreCadastro.Create;
    APreCadastro.CnpjParceiro := IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp));
    APreCadastro.CpfCnpjParticipante := strCpfCnpj;

    if qryBuscaCliente.IsEmpty then
    begin
      APreCadastro.PrimeiroNome := '';
      APreCadastro.DDD := 0;
      APreCadastro.Numero := '';
      APreCadastro.Email := '';
    end
    else
    begin
      strTelefone := fTiraCaracEspeciaisParenteses(qryBuscaCliente.FieldByName('FONE').AsString);
      if Length(strTelefone) < 8 then
      begin
        intDDD := 0;
      end
      else if (Pos(strTelefone,'0') = 1) then
      begin
        intDDD := StrToIntDef(Copy(strTelefone,2,2),0);
        Delete(strTelefone,1,3);
      end
      else
      begin
        intDDD := StrToIntDef(Copy(strTelefone,1,2),0);
        Delete(strTelefone,1,2);
      end;

      APreCadastro.PrimeiroNome := qryBuscaCliente.FieldByName('NOME').AsString;
      APreCadastro.DDD := intDDD;
      APreCadastro.Numero := Trim(strTelefone);
      APreCadastro.Email := qryBuscaCliente.FieldByName('EMAIL').AsString;
    end;
  finally
    FreeAndNil(qryBuscaCliente);
  end;
end;

{ TRetornoPreCadastro }

class function TRetornoPreCadastro.FromJsonString(
  AJsonString: string): TRetornoPreCadastro;
begin
  result := TJson.JsonToObject<TRetornoPreCadastro>(AJsonString);
end;

procedure pPreCadastroQuestFidelidade(var APreCadastro: TPreCadastro);
var
  RetornoPreCadastro: TRetornoPreCadastro;
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  strJsonEnvio := APreCadastro.ToJsonString;

  if fEmptyStr(strJsonEnvio) then
  begin
    Exit;
  end;

  strJsonRetorno := fComunica(fCfgSis('CADQUE'), 'POST', strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  RetornoPreCadastro := TRetornoPreCadastro.FromJsonString(strJsonRetorno);

  APreCadastro.SaldoDisponivelPontos := RetornoPreCadastro.SaldoDisponivelPontos;
  APreCadastro.SaldoDisponivelValor  := RetornoPreCadastro.SaldoDisponivelValor;
  APreCadastro.TransacaoID           := RetornoPreCadastro.TransacaoID;
  APreCadastro.Erro                  := RetornoPreCadastro.Erro;
  APreCadastro.Mensagem              := RetornoPreCadastro.Mensagem;
end;

{ TAcumula }

constructor TAcumula.Create;
begin
  FProdutos := TObjectList<TProdutosQuest>.Create();
end;

destructor TAcumula.Destroy;
begin

  inherited;
end;

function TAcumula.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  if fEmptyStr(Result) then
  begin
    Exit;
  end;

  Delete(Result,Pos('"produtos":', Result)+11,Pos('[',Result)-Pos('"produtos":', Result)+1);
  Delete(Result, Length(Result),1);
  Result := StringReplace(Result, ',null', EmptyStr, [rfReplaceAll, rfIgnoreCase]);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfOperador', 'CpfOperador', [rfReplaceAll]);
  Result := StringReplace(Result, 'valorTotalCompra', 'ValorTotalCompra', [rfReplaceAll]);
  Result := StringReplace(Result, 'meioPagamento', 'MeioPagamento', [rfReplaceAll]);
  Result := StringReplace(Result, 'perfil', 'Perfil', [rfReplaceAll]);
  Result := StringReplace(Result, 'produtos', 'Produtos', [rfReplaceAll]);
  Result := StringReplace(Result, 'acumula', 'Acumula', [rfReplaceAll]);
  Result := StringReplace(Result, 'codigo', 'Codigo', [rfReplaceAll]);
  Result := StringReplace(Result, 'descricao', 'Descricao', [rfReplaceAll]);
  Result := StringReplace(Result, 'unidade', 'Unidade', [rfReplaceAll]);
  Result := StringReplace(Result, 'quantidade', 'Quantidade', [rfReplaceAll]);
  Result := StringReplace(Result, 'valorUnitario', 'ValorUnitario', [rfReplaceAll]);
  Result := StringReplace(Result, 'complemento', 'Complemento', [rfReplaceAll]);
end;

{ TResgata }

constructor TResgata.Create;
begin
  FProdutos := TObjectList<TProdutosQuest>.Create();
end;

destructor TResgata.Destroy;
begin

  inherited;
end;

function TResgata.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  if fEmptyStr(Result) then
  begin
    Exit;
  end;

  Delete(Result,Pos('"produtos":', Result)+11,Pos('[',Result)-Pos('"produtos":', Result)+1);
  Delete(Result, Length(Result),1);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'senhaParticipante', 'SenhaParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfOperador', 'CpfOperador', [rfReplaceAll]);
  Result := StringReplace(Result, 'pontosResgate', 'PontosResgate', [rfReplaceAll]);
  Result := StringReplace(Result, 'valorTotalCompra', 'ValorTotalCompra', [rfReplaceAll]);
  Result := StringReplace(Result, 'meioPagamento', 'MeioPagamento', [rfReplaceAll]);
  Result := StringReplace(Result, 'perfil', 'Perfil', [rfReplaceAll]);
  Result := StringReplace(Result, 'produtos', 'Produtos', [rfReplaceAll]);
  Result := StringReplace(Result, 'acumula', 'Acumula', [rfReplaceAll]);
  Result := StringReplace(Result, 'codigo', 'Codigo', [rfReplaceAll]);
  Result := StringReplace(Result, 'descricao', 'Descricao', [rfReplaceAll]);
  Result := StringReplace(Result, 'unidade', 'Unidade', [rfReplaceAll]);
  Result := StringReplace(Result, 'quantidade', 'Quantidade', [rfReplaceAll]);
  Result := StringReplace(Result, 'valorUnitario', 'ValorUnitario', [rfReplaceAll]);
  Result := StringReplace(Result, 'complemento', 'Complemento', [rfReplaceAll]);
end;

{ TGeraToken }

function TGeraToken.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
  Result := StringReplace(Result, 'pontosResgate', 'PontosResgate', [rfReplaceAll]);
end;

{ TRetornoToken }

class function TRetornoToken.FromJsonString(AJsonString: string): TRetornoToken;
begin
  result := TJson.JsonToObject<TRetornoToken>(AJsonString);
end;

function fAcumulaPontosQuest(AAcumula: TAcumula): TRetornoAcumula;
var
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  Result := TRetornoAcumula.Create;
  strJsonEnvio := AAcumula.ToJsonString;

  strJsonRetorno := fComunica(fCfgSis('ACUQUE'),'POST',strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  Result := TRetornoAcumula.FromJsonString(strJsonRetorno);
end;

{ TRetornoAcumula }

class function TRetornoAcumula.FromJsonString(
  AJsonString: string): TRetornoAcumula;
begin
  result := TJson.JsonToObject<TRetornoAcumula>(AJsonString);
end;

function fRetornaClasseAcumulaQuest(strAutInc, strCnpjParceiro, strDocCli: string; fltTotalItens: Double): TAcumula;
var
  qryAcumula: TUniQuery;
  Acumula: TAcumula;
  Produtos: TProdutosQuest;
begin
  try
    qryAcumula := fCriaQuery;
    qryAcumula.Close;
    qryAcumula.SQL.Clear;
    qryAcumula.SQL.Add('SELECT F.FDO_CODITE, F.FDO_DESCRI, F.FDO_UNIDAD,');
    qryAcumula.SQL.Add('       F.FDO_QTDITE, F.FDO_UNITAR, I.ITE_USAQUE');
    qryAcumula.SQL.Add('FROM FATDOR F');
    qryAcumula.SQL.Add('INNER JOIN CADITE I ON(F.FDO_CODITE = I.ITE_CODITE)');
    qryAcumula.SQL.Add('WHERE F.FDO_SEQGER = :AUTINC');
    qryAcumula.ParamByName('AUTINC').AsString := strAutInc;
    qryAcumula.Open;

    Acumula := TAcumula.Create;
    Acumula.CnpjParceiro := strCnpjParceiro;
    Acumula.CpfCnpjParticipante := strDocCli;
    Acumula.CpfOperador := '';
    Acumula.ValorTotalCompra := fltTotalItens;
    Acumula.MeioPagamento := 1;
    Acumula.Perfil := fBuscaPerfilCliente(strDocCli);

    while not qryAcumula.Eof do
    begin
      Produtos := TProdutosQuest.Create;
      Produtos.Acumula := IIF(qryAcumula.FieldByName('ITE_USAQUE').AsString = 'S', 1, 0);
      Produtos.Codigo := qryAcumula.FieldByName('FDO_CODITE').AsString;
      Produtos.Descricao := qryAcumula.FieldByName('FDO_DESCRI').AsString;
      Produtos.Unidade := qryAcumula.FieldByName('FDO_UNIDAD').AsString;
      Produtos.Quantidade := qryAcumula.FieldByName('FDO_QTDITE').AsFloat;
      Produtos.ValorUnitario := qryAcumula.FieldByName('FDO_UNITAR').AsFloat;
      Acumula.Produtos.Add(Produtos);
      qryAcumula.Next;
    end;

    Result := Acumula;
  finally
    FreeAndNil(qryAcumula);
  end;
end;

function fRetornaClasseResgateQuest(strAutInc, strCnpjParceiro, strDocCli: string; fltTotalItens, fltPontosResgate: Double): TResgata;
var
  qryResgata: TUniQuery;
  Resgata: TResgata;
  Produto: TProdutosQuest;
begin
  try
    qryResgata := fCriaQuery;
    qryResgata.Close;
    qryResgata.SQL.Clear;
    qryResgata.SQL.Add('SELECT FDO_CODITE, FDO_DESCRI, FDO_UNIDAD, FDO_QTDITE, FDO_UNITAR');
    qryResgata.SQL.Add('FROM FATDOR');
    qryResgata.SQL.Add('WHERE FDO_SEQGER = :AUTINC');
    qryResgata.ParamByName('AUTINC').AsString := strAutInc;
    qryResgata.Open;

    Resgata := TResgata.Create;
    Resgata.CnpjParceiro := strCnpjParceiro;
    Resgata.CpfCnpjParticipante := strDocCli;
    Resgata.CpfOperador := '';
    Resgata.PontosResgate := fltPontosResgate;
    Resgata.ValorTotalCompra := fltTotalItens;
    Resgata.MeioPagamento := 1;
    Resgata.Perfil := fBuscaPerfilCliente(strDocCli);

    while not qryResgata.Eof do
    begin
      Produto := TProdutosQuest.Create;
      Produto.Acumula := 0;
      Produto.Codigo := qryResgata.FieldByName('FDO_CODITE').AsString;
      Produto.Descricao := qryResgata.FieldByName('FDO_DESCRI').AsString;
      Produto.Unidade := qryResgata.FieldByName('FDO_UNIDAD').AsString;
      Produto.Quantidade := qryResgata.FieldByName('FDO_QTDITE').AsFloat;
      Produto.ValorUnitario := qryResgata.FieldByName('FDO_UNITAR').AsFloat;
      Resgata.Produtos.Add(Produto);
      qryResgata.Next;
    end;

    Result := Resgata;
  finally
    FreeAndNil(qryResgata);
  end;
end;

function fGeraTokenQuest(strCnpjParceiro, strCpfCnpjParticipante: string; fltPontosResgate: Double): TRetornoToken;
var
  Token: TGeraToken;
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  Result := TRetornoToken.Create;

  Token := TGeraToken.Create;
  Token.CnpjParceiro := strCnpjParceiro;
  Token.CpfCnpjParticipante := strCpfCnpjParticipante;
  Token.PontoResgate := fltPontosResgate;

  strJsonEnvio := Token.ToJsonString;

  strJsonRetorno := fComunica(fCfgSis('GRTKQF'),'POST',strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  Result := TRetornoToken.FromJsonString(strJsonRetorno);
end;

function fGravaTransacaoQuest(intIdTrans: integer; strDocCli, strComando, strJSON: string; var strAutInc: string; strRegEst: string = ''; strNumDoc: string = ''; strEspDoc: string = ''): Boolean;
var
  qryTransacao: TUniQuery;
begin
  try
    Result := False;
    qryTransacao := fCriaQuery();
    qryTransacao.Close;
    qryTransacao.SQL.Clear;
    qryTransacao.SQL.Add('INSERT INTO QUESTF(AUTOINCREM, QUE_CODEMP, QUE_DTAQUE, QUE_HORQUE, QUE_CODOPE, QUE_DOCCLI, QUE_CNPPAR, QUE_COMAND, QUE_JSONQF, QUE_REGEST, QUE_NUMDOC, QUE_ESPDOC, QUE_IDTRAN)');
    qryTransacao.SQL.Add('VALUES(:AUTINC, :CODEMP, :DTAQUE, :HORQUE, :CODOPE, :DOCCLI, :CNPPAR, :COMAND, :JSONQF, :REGEST, :NUMDOC, :ESPDOC, :IDTRAN)');
    strAutInc := fRetAutoIncrem('QUESTF', VS_strCodEmp);
    qryTransacao.ParamByName('AUTINC').AsString  := strAutInc;
    qryTransacao.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryTransacao.ParamByName('DTAQUE').AsDate    := VS_Date;
    qryTransacao.ParamByName('HORQUE').AsTime    := fTime();
    qryTransacao.ParamByName('CODOPE').AsString  := strLoginUsuarioLogado;
    qryTransacao.ParamByName('DOCCLI').AsString  := strDocCli;
    qryTransacao.ParamByName('CNPPAR').AsString  := IIF(not fEmptyStr(fCfgSis('CNPQUE')),fCfgSis('CNPQUE'),fRetCGCEmpresa(VS_strCodEmp));
    qryTransacao.ParamByName('COMAND').AsString  := strComando;
    qryTransacao.ParamByName('JSONQF').AsString  := strJSON;
    qryTransacao.ParamByName('REGEST').AsString  := strRegEst;
    qryTransacao.ParamByName('NUMDOC').AsString  := strNumDoc;
    qryTransacao.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryTransacao.ParamByName('IDTRAN').AsInteger := intIdTrans;
    qryTransacao.ExecSQL;
    Result := True;
  finally
    FreeAndNil(qryTransacao);
  end;
end;

{ TEstornaQuest }

function TEstornaQuest.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);

  //Gambiarra para que a Web Service da Quest Fidelidade entenda o Json, json da Quest Fidelidade está fora de padrão e verifica case sensitive
  Result := StringReplace(Result, 'cnpjParceiro', 'CnpjParceiro', [rfReplaceAll]);
  Result := StringReplace(Result, 'cpfCnpjParticipante', 'CpfCnpjParticipante', [rfReplaceAll]);
  Result := StringReplace(Result, 'transacaoID', 'TransacaoID', [rfReplaceAll]);
end;

{ TRetornoEstorno }

class function TRetornoEstorno.FromJsonString(
  AJsonString: string): TRetornoEstorno;
begin
  result := TJson.JsonToObject<TRetornoEstorno>(AJsonString);
end;

function fEstornaPontosQuest(AEstornoQuest: TEstornaQuest): TRetornoEstorno;
var
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  Result := TRetornoEstorno.Create;

  strJsonEnvio := AEstornoQuest.ToJsonString;

  strJsonRetorno := fComunica(fCfgSis('ESTQUE'), 'POST', strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  Result := TRetornoEstorno.FromJsonString(strJsonRetorno);
end;

procedure pBuscaInformacaoEstornoQuest(var strCnpjParceiro, strCpfCnpjParticipante: string; var intTransacaoID: integer; var dtaDataTransacao: TDate; strNumDoc, strEspDoc, strCodEmp: string; var strAutInc: string);
var
  qryEstorno: TUniQuery;
begin
  strCnpjParceiro := '';
  strCpfCnpjParticipante := '';
  intTransacaoID := 0;
  dtaDataTransacao := 0;

  try
    qryEstorno := fCriaQuery();
    qryEstorno.Close;
    qryEstorno.SQL.Clear;
    qryEstorno.SQL.Add('SELECT AUTOINCREM, QUE_DOCCLI, QUE_CNPPAR, QUE_IDTRAN, QUE_DTAQUE');
    qryEstorno.SQL.Add('FROM QUESTF');
    qryEstorno.SQL.Add('WHERE QUE_NUMDOC = :NUMDOC');
    qryEstorno.SQL.Add('AND QUE_ESPDOC = :ESPDOC');
    qryEstorno.SQL.Add('AND QUE_CODEMP = :CODEMP');
    qryEstorno.SQL.Add('AND QUE_COMAND <> ' + QUEST_COMAND_ESTORNA.QuotedString);
    qryEstorno.ParamByName('NUMDOC').AsString := strNumDoc;
    qryEstorno.ParamByName('ESPDOC').AsString := strEspDoc;
    qryEstorno.ParamByName('CODEMP').AsString := strCodEmp;
    qryEstorno.Open;

    if not qryEstorno.IsEmpty then
    begin
      strAutInc := qryEstorno.FieldByName('AUTOINCREM').AsString;
      strCnpjParceiro := qryEstorno.FieldByName('QUE_CNPPAR').AsString;
      strCpfCnpjParticipante := qryEstorno.FieldByName('QUE_DOCCLI').AsString;
      intTransacaoID := qryEstorno.FieldByName('QUE_IDTRAN').AsInteger;
      dtaDataTransacao := qryEstorno.FieldByName('QUE_DTAQUE').AsDateTime;
    end;
  finally
    FreeAndNil(qryEstorno);
  end;
end;

{ TRetornoResgate }

class function TRetornoResgate.FromJsonString(
  AJsonString: string): TRetornoResgate;
begin
  result := TJson.JsonToObject<TRetornoResgate>(AJsonString);
end;

function fResgataPontosQuest(AResgata: TResgata): TRetornoResgate;
var
  strJsonEnvio: string;
  strJsonRetorno: string;
begin
  Result := TRetornoResgate.Create;
  strJsonEnvio := AResgata.ToJsonString;

  strJsonRetorno := fComunica(fCfgSis('RESQUE'),'POST',strJsonEnvio);

  if Pos('*', strJsonRetorno) = 1 then
  begin
    fMensagem('', strJsonRetorno, ['&OK']);
    Exit;
  end;

  Result := TRetornoResgate.FromJsonString(strJsonRetorno);
end;

function fOcorreuTransacao(strAutInc: string; intTransacaoID: integer): Boolean;
var
  qryTransacao: TUniQuery;
begin
  try
    Result := False;
    qryTransacao := fCriaQuery();
    qryTransacao.Close;
    qryTransacao.SQL.Clear;
    qryTransacao.SQL.Add('UPDATE QUESTF SET QUE_IDTRAN = :IDTRAN, QUE_DTATRA = :DTATRA, QUE_HORTRA = :HORTRA');
    qryTransacao.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryTransacao.ParamByName('IDTRAN').AsInteger := intTransacaoID;
    qryTransacao.ParamByName('DTATRA').AsDate := VS_Date;
    qryTransacao.ParamByName('HORTRA').AsTime := fTime();
    qryTransacao.ParamByName('AUTINC').AsString := strAutInc;
    qryTransacao.ExecSQL;
    Result := True;
  finally
    FreeAndNil(qryTransacao);
  end;
end;

function fOcorreuEstorno(strAutInc, strIncReg: string; intTransacaoID: integer): Boolean;
var
  qryEstorno: TUniQuery;
begin
  Result := False;
  try
    qryEstorno := fCriaQuery();

    if fOcorreuTransacao(strAutInc, intTransacaoID) then
    begin
      qryEstorno.Close;
      qryEstorno.SQL.Clear;
      qryEstorno.SQL.Add('UPDATE QUESTF SET QUE_DTAEST = :DTAEST, QUE_HOREST = :HOREST');
      qryEstorno.SQL.Add('WHERE AUTOINCREM = :AUTINC');
      qryEstorno.ParamByName('DTAEST').AsDate := VS_Date;
      qryEstorno.ParamByName('HOREST').AsTime := fTime();
      qryEstorno.ParamByName('AUTINC').AsString := strIncReg;
      qryEstorno.ExecSQL;
      Result := True;
    end;
  finally
    FreeAndNil(qryEstorno);
  end;
end;


function fEstornaPontosQuestAutomatico(strAutInc, strIncReg, strJsonEnvio: string): Boolean;
var
  strJsonRetorno: string;
  RetornoEstorno: TRetornoEstorno;
begin
  Result := False;

  strJsonRetorno := fComunica(fCfgSis('ESTQUE'), 'POST', strJsonEnvio);

  if Pos('*', strJsonRetorno) = 0 then
  begin
    try
      RetornoEstorno := TRetornoEstorno.Create;
      RetornoEstorno := TRetornoEstorno.FromJsonString(strJsonRetorno);
      if not RetornoEstorno.Erro then
      begin
        Result := fOcorreuEstorno(strAutInc, strIncReg, RetornoEstorno.TransacaoID);
      end;
    finally
      FreeAndNil(RetornoEstorno);
    end;
  end;
end;

procedure pControlaQuestFidelidade;
var
  qryQuest: TUniQuery;
begin
  try
    qryQuest := fCriaQuery();
    qryQuest.Close;
    qryQuest.SQL.Clear;
    qryQuest.SQL.Add('SELECT AUTOINCREM, QUE_COMAND, QUE_JSONQF, QUE_REGEST');
    qryQuest.SQL.Add('FROM QUESTF');
    qryQuest.SQL.Add('WHERE QUE_IDTRAN = 0 AND QUE_COMAND = "ESTORNA"');
    qryQuest.Open;

    while not qryQuest.Eof do
    begin
      fEstornaPontosQuestAutomatico(qryQuest.FieldByName('AUTOINCREM').AsString, qryQuest.FieldByName('QUE_REGEST').AsString, qryQuest.FieldByName('QUE_JSONQF').AsString);

      qryQuest.Next;
    end;

    pBuscaTransacaoQuestSemVenda;
  finally
    FreeAndNil(qryQuest);
  end;
end;

function fRetornaClasseResgateQuestCDS(strCnpjParceiro, strDocCli: string; fltTotalItens, fltPontosResgate: Double; cdsItens: TUniClientDataSet): TResgata;
var
  Resgata: TResgata;
  Produto: TProdutosQuest;
begin
  Resgata := TResgata.Create;
  Resgata.CnpjParceiro := strCnpjParceiro;
  Resgata.CpfCnpjParticipante := strDocCli;
  Resgata.CpfOperador := '';
  Resgata.PontosResgate := fltPontosResgate;
  Resgata.ValorTotalCompra := fltTotalItens;
  Resgata.MeioPagamento := 1;
  Resgata.Perfil := fBuscaPerfilCliente(strDocCli);

  cdsItens.First;
  while not cdsItens.Eof do
  begin
    Produto               := TProdutosQuest.Create;
    Produto.Acumula       := 0;
    Produto.Codigo        := cdsItens.FieldByName('ITE_CODITE').AsString;
    Produto.Descricao     := cdsItens.FieldByName('ITE_DESITE').AsString;
    Produto.Unidade       := cdsItens.FieldByName('UNI_DESUNI').AsString;
    Produto.Quantidade    := cdsItens.FieldByName('ITE_QTDITE').AsFloat;
    Produto.ValorUnitario := cdsItens.FieldByName('ITE_UNITAR').AsFloat;
    Resgata.Produtos.Add(Produto);
    cdsItens.Next;
  end;

  Result := Resgata;
end;

function fRetornaClasseAcumulaQuestCDS(strCnpjParceiro, strDocCli: string; fltTotalItens: Double; cdsItens: TUniClientDataSet): TAcumula;
var
  Acumula: TAcumula;
  Produtos: TProdutosQuest;
begin
  Acumula := TAcumula.Create;
  Acumula.CnpjParceiro := strCnpjParceiro;
  Acumula.CpfCnpjParticipante := strDocCli;
  Acumula.CpfOperador := '';
  Acumula.ValorTotalCompra := fltTotalItens;
  Acumula.MeioPagamento := 1;
  Acumula.Perfil := fBuscaPerfilCliente(strDocCli);

  cdsItens.First;
  while not cdsItens.Eof do
  begin
    Produtos               := TProdutosQuest.Create;
    Produtos.Acumula       := fItemAcumulaPontosQuest(cdsItens.FieldByName('ITE_CODITE').AsString);
    Produtos.Codigo        := cdsItens.FieldByName('ITE_CODITE').AsString;
    Produtos.Descricao     := cdsItens.FieldByName('ITE_DESITE').AsString;
    Produtos.Unidade       := cdsItens.FieldByName('UNI_DESUNI').AsString;
    Produtos.Quantidade    := cdsItens.FieldByName('ITE_QTDITE').AsFloat;
    Produtos.ValorUnitario := cdsItens.FieldByName('ITE_UNITAR').AsFloat;
    Acumula.Produtos.Add(Produtos);
    cdsItens.Next;
  end;

  Result := Acumula;
end;

function fItemAcumulaPontosQuest(strCodIte: string): integer;
var
  qryPontos: TUniQuery;
begin
  try
    qryPontos := fCriaQuery;
    qryPontos.Close;
    qryPontos.SQL.Clear;
    qryPontos.SQL.Add('SELECT ITE_USAQUE FROM CADITE WHERE ITE_CODITE = :CODITE');
    qryPontos.ParamByName('CODITE').AsString := strCodIte;
    qryPontos.Open;

    if (not qryPontos.IsEmpty) And (qryPontos.FieldByName('ITE_USAQUE').AsString = 'S') then
    begin
      Result := 1;
    end
    else
    begin
      Result := 0;
    end;
  finally
    FreeAndNil(qryPontos);
  end;
end;

procedure pConfirmaTransacaoQuest(strAutInc, strNumDoc, strEspDoc: string);
var
  qryTransacao: TUniQuery;
begin
  try
    qryTransacao := fCriaQuery();
    qryTransacao.Close;
    qryTransacao.SQL.Clear;
    qryTransacao.SQL.Add('UPDATE QUESTF SET QUE_NUMDOC = :NUMDOC, QUE_ESPDOC = :ESPDOC WHERE AUTOINCREM = :AUTINC AND QUE_IDTRAN > 0');
    qryTransacao.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTransacao.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTransacao.ParamByName('AUTINC').AsString := strAutInc;
    qryTransacao.ExecSQL;
  finally
    FreeAndNil(qryTransacao);
  end;
end;

procedure pCancelaTransacaoQuestSemVenda(strAutInc: string);
var
  qryCancela: TUniQuery;
begin
  try
    qryCancela := fCriaQuery();
    qryCancela.Close;
    qryCancela.SQL.Clear;
    qryCancela.SQL.Add('DELETE FROM QUESTF WHERE AUTOINCREM = :AUTINC');
    qryCancela.ParamByName('AUTINC').AsString := strAutInc;
    qryCancela.ExecSQL;
  finally
    FreeAndNil(qryCancela);
  end;
end;

procedure pBuscaTransacaoQuestSemVenda;
var
  qryBusca: TUniQuery;
  RetornoEstornoQuest: TRetornoEstorno;
  EstornoQuest: TEstornaQuest;
begin
  try
    qryBusca := fCriaQuery();
    try
      qryBusca.Close;
      qryBusca.SQL.Clear;
      qryBusca.SQL.Add('SELECT AUTOINCREM, QUE_IDTRAN, QUE_DOCCLI, QUE_CNPPAR FROM QUESTF');
      qryBusca.SQL.Add('WHERE TRIM(QUE_NUMDOC) = "" AND TRIM(QUE_ESPDOC) = "" AND QUE_IDTRAN > 0');
      qryBusca.SQL.Add('AND((QUE_DTAQUE < CURDATE()) OR ((QUE_DTAQUE = CURDATE()) AND (DATE_SUB(CURTIME(),INTERVAL 5 HOUR))))');
      qryBusca.Open;

      while not qryBusca.Eof do
      begin
        try
          RetornoEstornoQuest := TRetornoEstorno.Create;
          EstornoQuest := TEstornaQuest.Create;
          EstornoQuest.CnpjParceiro := qryBusca.FieldByName('QUE_CNPPAR').AsString;
          EstornoQuest.CpfCnpjParticipante := qryBusca.FieldByName('QUE_DOCCLI').AsString;
          EstornoQuest.TransacaoID := qryBusca.FieldByName('QUE_IDTRAN').AsInteger;
          RetornoEstornoQuest := fEstornaPontosQuest(EstornoQuest);
          if not RetornoEstornoQuest.Erro then
          begin
            pCancelaTransacaoQuestSemVenda(qryBusca.FieldByName('AUTOINCREM').AsString);
          end;
        finally
          FreeAndNil(RetornoEstornoQuest);
          FreeAndNil(EstornoQuest);
        end;
        qryBusca.Next;
      end;
    except
      // Não mostrar erro em tela
    end;
  finally
    FreeAndNil(qryBusca);
  end;
end;

function fBuscaPerfilPelaTabelaDePreco(strDocCli: string): integer;
var
  qryPerfil: TUniQuery;
begin
  Result := 0;
  qryPerfil := fCriaQuery();

  try
    try
      qryPerfil.Close;
      qryPerfil.SQL.Clear;
      qryPerfil.SQL.Add('SELECT CLI_TABPRE');
      qryPerfil.SQL.Add('FROM CADCLI');
      qryPerfil.SQL.Add('WHERE CLI_C_G_C_ = :DOCCLI');
      qryPerfil.ParamByName('DOCCLI').AsString := strDocCli;
      qryPerfil.Open;

      if not qryPerfil.IsEmpty then
      begin
        Result := StrToIntDef(qryPerfil.FieldByName('CLI_TABPRE').AsString,0);
      end;
    except
      Result := 0;
    end;
  finally
    FreeAndNil(qryPerfil);
  end;
end;

function fBuscaPerfilCliente(strDocCli: string): integer;
begin
  if (fCfgSis('PERQUE', varString) = '1') then
  begin
    Result := 0;
  end
  else
  begin
    Result := fBuscaPerfilPelaTabelaDePreco(strDocCli);
  end;
end;

function fBuscaInformacaoEstornoQuest(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    strCnpjParceiro: String;
    strCpfCnpjParticipante: String;
    intTransacaoID: Integer;
    dtaDataTransacao: TDate;
    strAutInc: String;
begin
  strAutInc := '';
  pBuscaInformacaoEstornoQuest(strCnpjParceiro,
                               strCpfCnpjParticipante,
                               intTransacaoID,
                               dtaDataTransacao,
                               strNumDoc,
                               strEspDoc,
                               strCodEmp,
                               strAutInc);

  Result := Not fEmptyStr(strAutInc);
end;

function fEstornaQuestFidelidade(strNumDoc, strEspDoc, strCodEmp: String; blnAvisoDiasMax: Boolean = False): Boolean;
  Var
    strCnpjParceiro: String;
    strCpfCnpjParticipante: String;
    intTRansacaoID: Integer;
    dtaDataTranfQuest: TDate;
    strMensagemQuest: String;
    strAutIncEstorno: String;
    strAutIncLocal: String;
    strJSONEstorno: String;
    RetornoEstornoQuest: TRetornoEstorno;
    EstornoQuest: TEstornaQuest;
begin
  Result := False;
  pBuscaInformacaoEstornoQuest(strCnpjParceiro, strCpfCnpjParticipante, intTRansacaoID, dtaDataTranfQuest, strNumDoc, strEspDoc, strCodEmp, strAutIncEstorno);
  If DaysBetween(VS_Date, dtaDataTranfQuest) <= QUEST_MAX_DIAS_ESTORNO Then
  Begin
    Try
      RetornoEstornoQuest := TRetornoEstorno.Create;
      EstornoQuest        := TEstornaQuest.Create;

      EstornoQuest.CnpjParceiro        := strCnpjParceiro;
      EstornoQuest.CpfCnpjParticipante := strCpfCnpjParticipante;
      EstornoQuest.TransacaoID         := intTRansacaoID;
      strJSONEstorno                   := EstornoQuest.ToJsonString;

      If fGravaTransacaoQuest(0, strCpfCnpjParticipante, QUEST_COMAND_ESTORNA, strJSONEstorno, strAutIncLocal, strAutIncEstorno, strNumDoc, strEspDoc) Then
      Begin
        RetornoEstornoQuest := fEstornaPontosQuest(EstornoQuest);
        If Not RetornoEstornoQuest.Erro Then
        Begin
          If fOcorreuEstorno(strAutIncLocal, strAutIncEstorno, RetornoEstornoQuest.TransacaoID) Then
          Begin
            Result := True;
            strMensagemQuest := 'Pontos Estornados: '+ FloatToStrF(RetornoEstornoQuest.PontosEstornados, ffFixed, 12, 2) +'.'+ sLineBreak +
                                'Saldo Disponível pontos: '+ FloatToStrF(RetornoEstornoQuest.SaldoDisponivelPontos, ffFixed, 12, 2) +'.'+ sLineBreak +
                                'Saldo disponível valor: '+ FloatToStrF(RetornoEstornoQuest.SaldoDisponivelValor, ffFixed, 12, 2) +'.';
            fMensagem('ATENÇÃO!', strMensagemQuest, ['&Ok']);
          End;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', RetornoEstornoQuest.Mensagem, ['&Ok']);
        End;
      End;
    Finally
      FreeAndNil(RetornoEstornoQuest);
      FreeAndNil(EstornoQuest);
    End;
  End
  Else
  Begin
    If blnAvisoDiasMax Then
      fMensagem('ATENÇÃO!', 'Não é permitido estornar Quest fidelidade emitido há mais de '+ IntToStr(QUEST_MAX_DIAS_ESTORNO) +' dias.', ['&Ok']);
  End;
end;

end.
