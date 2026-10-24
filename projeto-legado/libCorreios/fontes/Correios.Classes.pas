unit Correios.Classes;

interface

uses
  REST.Json;

type
  TApiToken = class
  private
    Fambiente: String;
    Fid: String;
    Fip: String;
    Fperfil: String;
    Fcnpj: String;
    Fcategoria: String;
    Femissao: TDateTime;
    FexpiraEm: TDateTime;
    FzoneOffset: String;
    Ftoken: String;
  public
    property ambiente: String read Fambiente write Fambiente;
    property id: String read Fid write Fid;
    property ip: String read Fip write Fip;
    property perfil: String read Fperfil write Fperfil;
    property cnpj: String read Fcnpj write Fcnpj;
    property categoria: String read Fcategoria write Fcategoria;
    property emissao: TDateTime read Femissao write Femissao;
    property expiraEm: TDateTime read FexpiraEm write FexpiraEm;
    property zoneOffset: String read FzoneOffset write FzoneOffset;
    property token: String read Ftoken write Ftoken;

    class function FromJsonString(const AJsonString: String): TApiToken;
  end;

  TApiError = class
  private
    Fmsgs: TArray<String>;
    Fdate: TDateTime;
    Fpath: String;
    Fcausa: String;
    FstackTrace: String;
  public
    property msgs: TArray<String> read Fmsgs write Fmsgs;
    property date: TDateTime read Fdate write Fdate;
    property path: String read Fpath write Fpath;
    property causa: String read Fcausa write Fcausa;
    property stackTrace: String read FstackTrace write FstackTrace;

    class function FromJsonString(const AJsonString: String): TApiError;
  end;

  TApiCEP = class
  private
    Fcep: String;
    Fuf: String;
    Flocalidade: String;
    Flogradouro: String;
    FtipoLogradouro: String;
    FnomeLogradouro: String;
    Fcomplemento: String;
    Fabreviatura: String;
    Fbairro: String;
    FnumeroLocalidade: Integer;
    FtipoCEP: Integer;
    Flado: String;
    FnumeroInicial: Integer;
    FnumeroFinal: Integer;
  public
    property cep: String read Fcep write Fcep;
    property uf: String read Fuf write Fuf;
    property localidade: String read Flocalidade write Flocalidade;
    property logradouro: String read Flogradouro write Flogradouro;
    property tipoLogradouro: String read FtipoLogradouro write FtipoLogradouro;
    property nomeLogradouro: String read FnomeLogradouro write FnomeLogradouro;
    property complemento: String read Fcomplemento write Fcomplemento;
    property abreviatura: String read Fabreviatura write Fabreviatura;
    property bairro: String read Fbairro write Fbairro;
    property numeroLocalidade: Integer read FnumeroLocalidade write FnumeroLocalidade;
    property tipoCEP: Integer read FtipoCEP write FtipoCEP;
    property lado: String read Flado write Flado;
    property numeroInicial: Integer read FnumeroInicial write FnumeroInicial;
    property numeroFinal: Integer read FnumeroFinal write FnumeroFinal;
    class function FromJsonString(const AJsonString: String): TApiCEP;
  end;

  TServicoContratoCliente = class
  private
    Fcodigo: String;
    Fdescricao: String;
    FcoSegmento: String;
    FdescSegmento: String;
  public
    property codigo: String read Fcodigo write Fcodigo;
    property descricao: String read Fdescricao write Fdescricao;
    property coSegmento: String read FcoSegmento write FcoSegmento;
    property descSegmento: String read FdescSegmento write FdescSegmento;
  end;

  TServicosContratoCliente = class
  private
    Fitens: TArray<TServicoContratoCliente>;
  public
    property itens: TArray<TServicoContratoCliente> read Fitens write Fitens;
    class function FromJsonString(const AJsonString: String): TServicosContratoCliente;
  end;
  
  TEndereco = class
  private
    Fcep: String;
    Flogradouro: String;
    Fnumero: String;
    Fcomplemento: String;
    Fbairro: String;
    Fcidade: String;
    Fuf: String;
    Fpais: String;
  public
    property cep: String read Fcep write Fcep;
    property logradouro: String read Flogradouro write Flogradouro;
    property numero: String read Fnumero write Fnumero;
    property complemento: String read Fcomplemento write Fcomplemento;
    property bairro: String read Fbairro write Fbairro;
    property cidade: String read Fcidade write Fcidade;
    property uf: String read Fuf write Fuf;
    property pais: String read Fpais write Fpais;
  end;

  TPessoa = class
  private
    Fnome: String;
    FdddTelefone: String;
    Ftelefone: String;
    FdddCelular: String;
    Fcelular: String;
    Femail: String;
    FcpfCnpj: String;
    FdocumentoEstrangeiro: String;
    Fobs: String;
    Fendereco: TEndereco;
  public
    property nome: String read Fnome write Fnome;
    property dddTelefone: String read FdddTelefone write FdddTelefone;
    property telefone: String read Ftelefone write Ftelefone;
    property dddCelular: String read FdddCelular write FdddCelular;
    property celular: String read Fcelular write Fcelular;
    property email: String read Femail write Femail;
    property cpfCnpj: String read FcpfCnpj write FcpfCnpj;
    property documentoEstrangeiro: String read FdocumentoEstrangeiro write FdocumentoEstrangeiro;
    property obs: String read Fobs write Fobs;
    property endereco: TEndereco read Fendereco write Fendereco;

    constructor Create;
    destructor Destroy; override;
  end;

  TItemDeclaracaoConteudo = class
  private
    Fconteudo: String;
    Fquantidade: Double;
    Fvalor: Double;
  public
    property conteudo: String read Fconteudo write Fconteudo;
    property quantidade: Double read Fquantidade write Fquantidade;
    property valor: Double read Fvalor write Fvalor;

    constructor Create(const Aconteudo: String; const Aquantidade, Avalor: Double);
  end;

  TSubItemCheckList = class
  private
    Fcodigo: String;
  public
    property codigo: String read Fcodigo write Fcodigo;
    constructor Create(const Acodigo: String);
  end;

  TServicoAdicional = class
  private
    FcodigoServicoAdicional: String;
    FtipoServicoAdicional: String;
    FnomeServicoAdicional: String;
    FvalorServicoAdicional: String;
    FvalorDeclarado: Double;
    FsiglaServicoAdicional: String;
    ForientacaoEntregaVizinho: String;
    FtipoChecklist: String;
    FsubitensCheckList: TArray<TSubItemCheckList>;
  public
    property codigoServicoAdicional: String read FcodigoServicoAdicional write FcodigoServicoAdicional;
    property tipoServicoAdicional: String read FtipoServicoAdicional write FtipoServicoAdicional;
    property nomeServicoAdicional: String read FnomeServicoAdicional write FnomeServicoAdicional;
    property valorServicoAdicional: String read FvalorServicoAdicional write FvalorServicoAdicional;
    property valorDeclarado: Double read FvalorDeclarado write FvalorDeclarado;
    property siglaServicoAdicional: String read FsiglaServicoAdicional write FsiglaServicoAdicional;
    property orientacaoEntregaVizinho: String read ForientacaoEntregaVizinho write ForientacaoEntregaVizinho;
    //Tipo de checklist no momento da postagem: 01-Celular; 04-Eletrônico; 05-Documento; 07-Conteúdo
    property tipoChecklist: String read FtipoChecklist write FtipoChecklist;
    //Lista de códigos dos subitens para o tipoChecklist: 05-Documento (máximo 8 documentos)
    property subitensCheckList: TArray<TSubItemCheckList> read FsubitensCheckList write FsubitensCheckList;

    constructor Create(const AcodigoServicoAdicional: String; const AvalorDeclarado: Double);
    destructor Destroy; override;
  end;

  THistoricoStatus = class
  private
    Fid: Integer;
    Fstatus: Integer;
    FdataHora: TDateTime;
  public
    property id: Integer read Fid write Fid;
    property status: Integer read Fstatus write Fstatus;
    property dataHora: TDateTime read FdataHora write FdataHora;
  end;

  TPrePostagemRequest = class
  private
    FidCorreios: String;
    Fremetente: TPessoa;
    Fdestinatario: TPessoa;
    FcodigoServico: String;
    FprecoServico: String;
    FprecoPrePostagem: String;
    FnumeroNotaFiscal: String;
    FnumeroCartaoPostagem: String;
    FchaveNFe: String;
    FlistaServicoAdicional: TArray<TServicoAdicional>;
    FitensDeclaracaoConteudo: TArray<TItemDeclaracaoConteudo>;
    FpesoInformado: Integer;
    FcodigoFormatoObjetoInformado: String;
    FalturaInformada: Integer;
    FlarguraInformada: Integer;
    FcomprimentoInformado: Integer;
    FdiametroInformado: Integer;
    FncmObjeto: String;
    FrfidObjeto: String;
    FcienteObjetoNaoProibido: String;
    FidAtendimento: String;
    FsolicitarColeta: String;
    FcodigoObjeto: String;
    FdataPrevistaPostagem: String;
    Fobservacao: String;
    FmodalidadePagamento: String;
    FlogisticaReversa: String;
    FdataValidadeLogReversa: String;
  public
    property idCorreios: String read FidCorreios write FidCorreios;
    property remetente: TPessoa read Fremetente write Fremetente;
    property destinatario: TPessoa read Fdestinatario write Fdestinatario;
    property codigoServico: String read FcodigoServico write FcodigoServico;
    property precoServico: String read FprecoServico write FprecoServico;
    property precoPrePostagem: String read FprecoPrePostagem write FprecoPrePostagem;
    property numeroNotaFiscal: String read FnumeroNotaFiscal write FnumeroNotaFiscal;
    property numeroCartaoPostagem: String read FnumeroCartaoPostagem write FnumeroCartaoPostagem;
    property chaveNFe: String read FchaveNFe write FchaveNFe;
    property listaServicoAdicional: TArray<TServicoAdicional> read FlistaServicoAdicional write FlistaServicoAdicional;
    property itensDeclaracaoConteudo: TArray<TItemDeclaracaoConteudo> read FitensDeclaracaoConteudo write FitensDeclaracaoConteudo;
    property pesoInformado: Integer read FpesoInformado write FpesoInformado;
    property codigoFormatoObjetoInformado: String read FcodigoFormatoObjetoInformado write FcodigoFormatoObjetoInformado;
    property alturaInformada: Integer read FalturaInformada write FalturaInformada;
    property larguraInformada: Integer read FlarguraInformada write FlarguraInformada;
    property comprimentoInformado: Integer read FcomprimentoInformado write FcomprimentoInformado;
    property diametroInformado: Integer read FdiametroInformado write FdiametroInformado;
    property ncmObjeto: String read FncmObjeto write FncmObjeto;
    property rfidObjeto: String read FrfidObjeto write FrfidObjeto;
    property cienteObjetoNaoProibido: String read FcienteObjetoNaoProibido write FcienteObjetoNaoProibido;
    property idAtendimento: String read FidAtendimento write FidAtendimento;
    property solicitarColeta: String read FsolicitarColeta write FsolicitarColeta;
    property codigoObjeto: String read FcodigoObjeto write FcodigoObjeto;
    property dataPrevistaPostagem: String read FdataPrevistaPostagem write FdataPrevistaPostagem;
    property observacao: String read Fobservacao write Fobservacao;
    //Modalidade Pagamento: 1-à vista, 2-a faturar, 3- à avista e a afaturar e 4- Prestação de contas recebimento ou pagamento
    property modalidadePagamento: String read FmodalidadePagamento write FmodalidadePagamento;
    property logisticaReversa: String read FlogisticaReversa write FlogisticaReversa;
    property dataValidadeLogReversa: String read FdataValidadeLogReversa write FdataValidadeLogReversa;

    constructor Create;
    destructor Destroy; override;
    procedure AddServicoAdicional(const Value: TServicoAdicional);
    procedure AddDeclaracaoConteudo(const Value: TItemDeclaracaoConteudo);
    function ToJsonString: String;
  end;

  TPrePostagemResponse = class
  private
    Fid: String;
    FidCorreios: String;
    FnumeroCartaoPostagem: String;
    FcodigoObjeto: String;
    FcodigoServico: String;
    FlistaServicoAdicional: TArray<TServicoAdicional>;
    FmodalidadePagamento: Integer;
    FprecoServico: Double;
    FprecoPrePostagem: Double;
    FnumeroNotaFiscal: String;
    FchaveNFe: String;
    FitensDeclaracaoConteudo: TArray<TItemDeclaracaoConteudo>;
    FpesoInformado: String;
    FcodigoFormatoObjetoInformado: String;
    FalturaInformada: String;
    FlarguraInformada: String;
    FcomprimentoInformado: String;
    FdiametroInformado: String;
    FncmObjeto: String;
    FrfidObjeto: String;
    FcienteObjetoNaoProibido: Integer;
    FidAtendimento: String;
    FsolicitarColeta: String;
    FnuColeta: String;
    FdataPrevistaPostagem: TDate;
    Feticket: String;
    FdataEticket: TDate;
    FcheckList: String;
    FcontroleCliente: String;
    Fobservacao: String;
    Fembalagem: String;
    FlogisticaReversa: String;
    FdataValidadeLogReversa: TDateTime;
    Fservico: String;
    FstatusAtual: Integer;
    FdataHoraStatusAtual: TDateTime;
    FdescStatusAtual: String;
    FdataHora: TDateTime;
    FtipoRotulo: String;
    FretornoIntegracao: String;
    FsistemaOrigem: String;
    FvalorTotalBens: Double;
    Fquantidade: Integer;
    FreciboSolicitacaoAssincrona: String;
    FcodigoFormatoObjetoPreAfericao: String;
    FalturaPreAfericao: String;
    FlarguraPreAfericao: String;
    FcomprimentoPreAfericao: String;
    FdiametroPreAfericao: String;
    FpesoPreAfericao: String;
    FdataHoraPreAfericao: TDateTime;
    FmcuUnidadePreAfericao: String;
    FidBalancaCubagem: String;
    FcepDestinoPreAfericao: String;
    FtipoObjeto: String;
    FerroAssincrono: String;
    FcodigoEstampa2D: String;
    FhistoricoStatus: TArray<THistoricoStatus>;
    FprazoPostagem: TDate;
    FobjetoCargo: String;
    FcodigoGrafica: Integer;
    FcodigoCdl: String;
  public
    property id: String read Fid write Fid;
    property idCorreios: String read FidCorreios write FidCorreios;
    property numeroCartaoPostagem: String read FnumeroCartaoPostagem write FnumeroCartaoPostagem;
    property codigoObjeto: String read FcodigoObjeto write FcodigoObjeto;
    property codigoServico: String read FcodigoServico write FcodigoServico;
    property listaServicoAdicional: TArray<TServicoAdicional> read FlistaServicoAdicional write FlistaServicoAdicional;
    property modalidadePagamento: Integer read FmodalidadePagamento write FmodalidadePagamento;
    property precoServico: Double read FprecoServico write FprecoServico;
    property precoPrePostagem: Double read FprecoPrePostagem write FprecoPrePostagem;
    property numeroNotaFiscal: String read FnumeroNotaFiscal write FnumeroNotaFiscal;
    property chaveNFe: String read FchaveNFe write FchaveNFe;
    property itensDeclaracaoConteudo: TArray<TItemDeclaracaoConteudo> read FitensDeclaracaoConteudo write FitensDeclaracaoConteudo;
    property pesoInformado: String read FpesoInformado write FpesoInformado;
    property codigoFormatoObjetoInformado: String read FcodigoFormatoObjetoInformado write FcodigoFormatoObjetoInformado;
    property alturaInformada: String read FalturaInformada write FalturaInformada;
    property larguraInformada: String read FlarguraInformada write FlarguraInformada;
    property comprimentoInformado: String read FcomprimentoInformado write FcomprimentoInformado;
    property diametroInformado: String read FdiametroInformado write FdiametroInformado;
    property ncmObjeto: String read FncmObjeto write FncmObjeto;
    property rfidObjeto: String read FrfidObjeto write FrfidObjeto;
    property cienteObjetoNaoProibido: Integer read FcienteObjetoNaoProibido write FcienteObjetoNaoProibido;
    property idAtendimento: String read FidAtendimento write FidAtendimento;
    property solicitarColeta: String read FsolicitarColeta write FsolicitarColeta;
    property nuColeta: String read FnuColeta write FnuColeta;
    property dataPrevistaPostagem: TDate read FdataPrevistaPostagem write FdataPrevistaPostagem;
    property eticket: String read Feticket write Feticket;
    property dataEticket: TDate read FdataEticket write FdataEticket;
    property checkList: String read FcheckList write FcheckList;
    property controleCliente: String read FcontroleCliente write FcontroleCliente;
    property observacao: String read Fobservacao write Fobservacao;
    property embalagem: String read Fembalagem write Fembalagem;
    property logisticaReversa: String read FlogisticaReversa write FlogisticaReversa;
    property dataValidadeLogReversa: TDateTime read FdataValidadeLogReversa write FdataValidadeLogReversa;
    property servico: String read Fservico write Fservico;
    property statusAtual: Integer read FstatusAtual write FstatusAtual;
    property dataHoraStatusAtual: TDateTime read FdataHoraStatusAtual write FdataHoraStatusAtual;
    property descStatusAtual: String read FdescStatusAtual write FdescStatusAtual;
    property dataHora: TDateTime read FdataHora write FdataHora;
    property tipoRotulo: String read FtipoRotulo write FtipoRotulo;
    property retornoIntegracao: String read FretornoIntegracao write FretornoIntegracao;
    property sistemaOrigem: String read FsistemaOrigem write FsistemaOrigem;
    property valorTotalBens: Double read FvalorTotalBens write FvalorTotalBens;
    property quantidade: Integer read Fquantidade write Fquantidade;
    property reciboSolicitacaoAssincrona: String read FreciboSolicitacaoAssincrona write FreciboSolicitacaoAssincrona;
    property codigoFormatoObjetoPreAfericao: String read FcodigoFormatoObjetoPreAfericao write FcodigoFormatoObjetoPreAfericao;
    property alturaPreAfericao: String read FalturaPreAfericao write FalturaPreAfericao;
    property larguraPreAfericao: String read FlarguraPreAfericao write FlarguraPreAfericao;
    property comprimentoPreAfericao: String read FcomprimentoPreAfericao write FcomprimentoPreAfericao;
    property diametroPreAfericao: String read FdiametroPreAfericao write FdiametroPreAfericao;
    property pesoPreAfericao: String read FpesoPreAfericao write FpesoPreAfericao;
    property dataHoraPreAfericao: TDateTime read FdataHoraPreAfericao write FdataHoraPreAfericao;
    property mcuUnidadePreAfericao: String read FmcuUnidadePreAfericao write FmcuUnidadePreAfericao;
    property idBalancaCubagem: String read FidBalancaCubagem write FidBalancaCubagem;
    property cepDestinoPreAfericao: String read FcepDestinoPreAfericao write FcepDestinoPreAfericao;
    property tipoObjeto: String read FtipoObjeto write FtipoObjeto;
    property erroAssincrono: String read FerroAssincrono write FerroAssincrono;
    property codigoEstampa2D: String read FcodigoEstampa2D write FcodigoEstampa2D;
    property historicoStatus: TArray<THistoricoStatus> read FhistoricoStatus write FhistoricoStatus;
    property prazoPostagem: TDate read FprazoPostagem write FprazoPostagem;
    property objetoCargo: String read FobjetoCargo write FobjetoCargo;
    property codigoGrafica: Integer read FcodigoGrafica write FcodigoGrafica;
    property codigoCdl: String read FcodigoCdl write FcodigoCdl;

    class function FromJsonString(const AJsonString: String): TPrePostagemResponse;
  end;

implementation

{ TApiCEP }

class function TApiCEP.FromJsonString(const AJsonString: String): TApiCEP;
begin
  try
    Result := TJson.JsonToObject<TApiCEP>(AJsonString);
  except
    raise;
  end;
end;

{ TApiToken }

class function TApiToken.FromJsonString(const AJsonString: String): TApiToken;
begin
  try
    Result := TJson.JsonToObject<TApiToken>(AJsonString);
  except
    raise;
  end;
end;

{ TApiError }

class function TApiError.FromJsonString(const AJsonString: String): TApiError;
begin
  try
    Result := TJson.JsonToObject<TApiError>(AJsonString);
  except
    raise;
  end;
end;

{ TPessoa }

constructor TPessoa.Create;
begin
  Fendereco := TEndereco.Create;
end;

destructor TPessoa.Destroy;
begin
  Fendereco.Free;
  inherited;
end;

{ TServicoAdicional }

constructor TServicoAdicional.Create(const AcodigoServicoAdicional: String; const AvalorDeclarado: Double);
begin
  FcodigoServicoAdicional := AcodigoServicoAdicional;
  FvalorDeclarado         := AvalorDeclarado;
  FtipoChecklist          := '04'; //01-Celular; 04-Eletrônico; 05-Documento; 07-Conteúdo
end;

destructor TServicoAdicional.Destroy;
  var
    LCont: Integer;
begin
  for LCont := Low(FsubitensCheckList) to High(FsubitensCheckList) do
    FsubitensCheckList[LCont].Free;
  inherited;
end;

{ TSubItemCheckList }

constructor TSubItemCheckList.Create(const Acodigo: String);
begin
  Fcodigo := Acodigo;
end;

{ TItemDeclaracaoConteudo }

constructor TItemDeclaracaoConteudo.Create(const Aconteudo: String; const Aquantidade, Avalor: Double);
begin
  Fconteudo   := Aconteudo;
  Fquantidade := Aquantidade;
  Fvalor      := Avalor;
end;

{ TPrePostagemRequest }

procedure TPrePostagemRequest.AddServicoAdicional(const Value: TServicoAdicional);
begin
  SetLength(FlistaServicoAdicional, Length(FlistaServicoAdicional) +1);
  FlistaServicoAdicional[High(FlistaServicoAdicional)] := Value;
end;

procedure TPrePostagemRequest.AddDeclaracaoConteudo(const Value: TItemDeclaracaoConteudo);
begin
  SetLength(FitensDeclaracaoConteudo, Length(FitensDeclaracaoConteudo) +1);
  FitensDeclaracaoConteudo[High(FitensDeclaracaoConteudo)] := Value;
end;

constructor TPrePostagemRequest.Create;
begin
  FcodigoFormatoObjetoInformado := '2'; //1-Envelope; 2-Caixa/Pacote; 3-Cilindro/rolo
  FcienteObjetoNaoProibido      := '1'; //0–Objeto proibido no fluxo postal; 1–Objeto permitido no fluxo postal
  FsolicitarColeta              := 'N'; //S ou N
  FlogisticaReversa             := 'N'; //S ou N
  //valores fixos, conforme webservice antigo (SIGEP WEB):
  FpesoInformado                := 117;
  FalturaInformada              := 4;
  FlarguraInformada             := 11;
  FcomprimentoInformado         := 16;
  FdiametroInformado            := 0;

  Fremetente    := TPessoa.Create;
  Fdestinatario := TPessoa.Create;
end;

destructor TPrePostagemRequest.Destroy;
  var
    LCont: Integer;
begin
  Fremetente.Free;
  Fdestinatario.Free;

  for LCont := Low(FlistaServicoAdicional) to High(FlistaServicoAdicional) do
    FlistaServicoAdicional[LCont].Free;

  for LCont := Low(FitensDeclaracaoConteudo) to High(FitensDeclaracaoConteudo) do
    FitensDeclaracaoConteudo[LCont].Free;
  inherited;
end;

function TPrePostagemRequest.ToJsonString: String;
begin
  Result := TJson.ObjectToJsonString(Self, [joIgnoreEmptyArrays, joIgnoreEmptyStrings]);
end;

{ TPrePostagemResponse }

class function TPrePostagemResponse.FromJsonString(const AJsonString: String): TPrePostagemResponse;
begin
  try
    Result := TJson.JsonToObject<TPrePostagemResponse>(AJsonString);
  except
    raise;
  end;
end;

{ TServicosContratoCliente }

class function TServicosContratoCliente.FromJsonString(const AJsonString: String): TServicosContratoCliente;
begin
  try
    Result := TJson.JsonToObject<TServicosContratoCliente>(AJsonString);
  except
    raise;
  end;
end;

end.
