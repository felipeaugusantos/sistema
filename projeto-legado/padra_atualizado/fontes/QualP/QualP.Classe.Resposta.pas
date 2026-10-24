unit QualP.Classe.Resposta;

interface

uses
  QualP.Base.JSON, System.Generics.Collections, REST.Json.Types,
  untBaseIntegracaoJSON;

{$M+}

type
  TItemTabelaFrete = class;
  TTipoTabelaFrete = class;
  TCategories = class;
  TDados = class;
  TExitBranchElements = class;
  TExitNumberElements = class;
  TExitTowardElements = class;
  TLocationAreas = class;
  TLocationContact = class;
  TPivot = class;
  TProducts = class;
  TServices = class;
  TSinal = class;
  TTarifa = class;

  TItemTabelaFrete = class
  private
    FConteineirizada: Double;
    FFrigorificada: Double;
    FGeral: Double;
    [JSONName('granel_liquido')]
    FGranelLiquido: Double;
    [JSONName('granel_pressurizada')]
    FGranelPressurizada: Double;
    [JSONName('granel_solido')]
    FGranelSolido: Double;
    FNeogranel: Double;
    [JSONName('perigosa_conteineirizada')]
    FPerigosaConteineirizada: Double;
    [JSONName('perigosa_frigorificada')]
    FPerigosaFrigorificada: Double;
    [JSONName('perigosa_geral')]
    FPerigosaGeral: Double;
    [JSONName('perigosa_granel_liquido')]
    FPerigosaGranelLiquido: Double;
    [JSONName('perigosa_granel_solido')]
    FPerigosaGranelSolido: Double;
  published
    property Conteineirizada: Double read FConteineirizada write FConteineirizada;
    property Frigorificada: Double read FFrigorificada write FFrigorificada;
    property Geral: Double read FGeral write FGeral;
    property GranelLiquido: Double read FGranelLiquido write FGranelLiquido;
    property GranelPressurizada: Double read FGranelPressurizada write FGranelPressurizada;
    property GranelSolido: Double read FGranelSolido write FGranelSolido;
    property Neogranel: Double read FNeogranel write FNeogranel;
    property PerigosaConteineirizada: Double read FPerigosaConteineirizada write FPerigosaConteineirizada;
    property PerigosaFrigorificada: Double read FPerigosaFrigorificada write FPerigosaFrigorificada;
    property PerigosaGeral: Double read FPerigosaGeral write FPerigosaGeral;
    property PerigosaGranelLiquido: Double read FPerigosaGranelLiquido write FPerigosaGranelLiquido;
    property PerigosaGranelSolido: Double read FPerigosaGranelSolido write FPerigosaGranelSolido;
  end;

  TTipoTabelaFrete = class
  private
    [JSONName('2')]
    F_2: TItemTabelaFrete;
    [JSONName('3')]
    F_3: TItemTabelaFrete;
    [JSONName('4')]
    F_4: TItemTabelaFrete;
    [JSONName('5')]
    F_5: TItemTabelaFrete;
    [JSONName('6')]
    F_6: TItemTabelaFrete;
    [JSONName('7')]
    F_7: TItemTabelaFrete;
    [JSONName('8')]
    F_8: TItemTabelaFrete;
    [JSONName('9')]
    F_9: TItemTabelaFrete;
  published
    property _2: TItemTabelaFrete read F_2;
    property _3: TItemTabelaFrete read F_3;
    property _4: TItemTabelaFrete read F_4;
    property _5: TItemTabelaFrete read F_5;
    property _6: TItemTabelaFrete read F_6;
    property _7: TItemTabelaFrete read F_7;
    property _8: TItemTabelaFrete read F_8;
    property _9: TItemTabelaFrete read F_9;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TDados = class
  private
    FA: TTipoTabelaFrete;
    FB: TTipoTabelaFrete;
    FC: TTipoTabelaFrete;
    FD: TTipoTabelaFrete;
  published
    property A: TTipoTabelaFrete read FA;
    property B: TTipoTabelaFrete read FB;
    property C: TTipoTabelaFrete read FC;
    property D: TTipoTabelaFrete read FD;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TTabelaFrete = class
  private
    FDados: TDados;
  published
    property Dados: TDados read FDados;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TPivot = class
  private
    [JSONName('category_id')]
    FCategoryId: Integer;
    [JSONName('location_id')]
    FLocationId: Integer;
  published
    property CategoryId: Integer read FCategoryId write FCategoryId;
    property LocationId: Integer read FLocationId write FLocationId;
  end;

  TCategories = class
  private
    [JSONName('created_at')]
    FCreatedAt: TDateTime;
    FDescription: string;
    FId: Integer;
    [JSONName('integration_id')]
    FIntegrationId: string;
    FName: string;
    FPivot: TPivot;
    [JSONName('updated_at')]
    FUpdatedAt: TDateTime;
    [JSONName('user_id')]
    FUserId: Integer;
  published
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property Description: string read FDescription write FDescription;
    property Id: Integer read FId write FId;
    property IntegrationId: string read FIntegrationId write FIntegrationId;
    property Name: string read FName write FName;
    property Pivot: TPivot read FPivot;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
    property UserId: Integer read FUserId write FUserId;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TLocationAreas = class
  end;

  TProducts = class
  end;

  TServices = class
  end;

  TLocationContact = class
  end;

  TLocaisPrivados = class(TBaseJSONQualP)
  private
    [JSONName('additional_information')]
    FAdditionalInformation: string;
    [JSONName('categories'), JSONMarshalled(False)]
    FCategoriesArray: TArray<TCategories>;
    [GenericListReflect]
    FCategories: TObjectList<TCategories>;
    FCep: string;
    FCity: string;
    FComplement: string;
    [JSONName('cpf_cnpj')]
    FCpfCnpj: string;
    [JSONName('created_at')]
    FCreatedAt: TDateTime;
    FDescription: string;
    FId: Integer;
    [JSONName('integration_id')]
    FIntegrationId: string;
    FLatitude: string;
    [JSONName('location_areas'), JSONMarshalled(False)]
    FLocationAreasArray: TArray<TLocationAreas>;
    [GenericListReflect]
    FLocationAreas: TObjectList<TLocationAreas>;
    [JSONName('location_contact'), JSONMarshalled(False)]
    FLocationContactArray: TArray<TLocationContact>;
    [GenericListReflect]
    FLocationContact: TObjectList<TLocationContact>;
    FLongitude: string;
    FName: string;
    FNeighbourhoods: string;
    FNumber: string;
    [JSONName('products'), JSONMarshalled(False)]
    FProductsArray: TArray<TProducts>;
    [GenericListReflect]
    FProducts: TObjectList<TProducts>;
    [JSONName('services'), JSONMarshalled(False)]
    FServicesArray: TArray<TServices>;
    [GenericListReflect]
    FServices: TObjectList<TServices>;
    FStreet: string;
    FUf: string;
    [JSONName('uf_id')]
    FUfId: Integer;
    [JSONName('updated_at')]
    FUpdatedAt: TDateTime;
    [JSONName('user_id')]
    FUserId: Integer;
    function GetCategories: TObjectList<TCategories>;
    function GetLocationAreas: TObjectList<TLocationAreas>;
    function GetLocationContact: TObjectList<TLocationContact>;
    function GetProducts: TObjectList<TProducts>;
    function GetServices: TObjectList<TServices>;
  protected
    function GetAsJson: string; override;
  published
    property AdditionalInformation: string read FAdditionalInformation write FAdditionalInformation;
    property Categories: TObjectList<TCategories> read GetCategories;
    property Cep: string read FCep write FCep;
    property City: string read FCity write FCity;
    property Complement: string read FComplement write FComplement;
    property CpfCnpj: string read FCpfCnpj write FCpfCnpj;
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property Description: string read FDescription write FDescription;
    property Id: Integer read FId write FId;
    property IntegrationId: string read FIntegrationId write FIntegrationId;
    property Latitude: string read FLatitude write FLatitude;
    property LocationAreas: TObjectList<TLocationAreas> read GetLocationAreas;
    property LocationContact: TObjectList<TLocationContact> read GetLocationContact;
    property Longitude: string read FLongitude write FLongitude;
    property Name: string read FName write FName;
    property Neighbourhoods: string read FNeighbourhoods write FNeighbourhoods;
    property Number: string read FNumber write FNumber;
    property Products: TObjectList<TProducts> read GetProducts;
    property Services: TObjectList<TServices> read GetServices;
    property Street: string read FStreet write FStreet;
    property Uf: string read FUf write FUf;
    property UfId: Integer read FUfId write FUfId;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
    property UserId: Integer read FUserId write FUserId;
  public
    destructor Destroy; override;
  end;

  TBalancas = class
  private
    FConcessionaria: string;
    FId: Integer;
    FKm: string;
    FLat: Double;
    FLng: Double;
    FLogo: string;
    FNome: string;
    [JSONName('p_index')]
    FPIndex: Integer;
    FRodovia: string;
    FSentido: string;
  published
    property Concessionaria: string read FConcessionaria write FConcessionaria;
    property Id: Integer read FId write FId;
    property Km: string read FKm write FKm;
    property Lat: Double read FLat write FLat;
    property Lng: Double read FLng write FLng;
    property Logo: string read FLogo write FLogo;
    property Nome: string read FNome write FNome;
    property PIndex: Integer read FPIndex write FPIndex;
    property Rodovia: string read FRodovia write FRodovia;
    property Sentido: string read FSentido write FSentido;
  end;

  TTarifa = class
  private
    [JSONName('10')]
    F_10: Double;
    [JSONName('11')]
    F_11: Double;
    [JSONName('12')]
    F_12: Double;
    [JSONName('13')]
    F_13: Double;
    [JSONName('14')]
    F_14: Double;
    [JSONName('15')]
    F_15: Double;
    [JSONName('2')]
    F_2: Double;
    [JSONName('3')]
    F_3: Double;
    [JSONName('4')]
    F_4: Double;
    [JSONName('5')]
    F_5: Double;
    [JSONName('6')]
    F_6: Double;
    [JSONName('7')]
    F_7: Double;
    [JSONName('8')]
    F_8: Double;
    [JSONName('9')]
    F_9: Double;
  published
    property _10: Double read F_10 write F_10;
    property _11: Double read F_11 write F_11;
    property _12: Double read F_12 write F_12;
    property _13: Double read F_13 write F_13;
    property _14: Double read F_14 write F_14;
    property _15: Double read F_15 write F_15;
    property _2: Double read F_2 write F_2;
    property _3: Double read F_3 write F_3;
    property _4: Double read F_4 write F_4;
    property _5: Double read F_5 write F_5;
    property _6: Double read F_6 write F_6;
    property _7: Double read F_7 write F_7;
    property _8: Double read F_8 write F_8;
    property _9: Double read F_9 write F_9;
  end;

  TPedagios = class
  private
    [JSONName('codigo_antt')]
    FCodigoAntt: string;
    [JSONName('codigo_ibge')]
    FCodigoIbge: string;
    [JSONName('codigo_integracao_sem_parar')]
    FCodigoIntegracaoSemParar: Integer;
    FConcessionaria: string;
    [JSONName('concessionaria_contato')]
    FConcessionariaContato: string;
    [JSONName('id_api')]
    FIdApi: string;
    FKm: string;
    FMunicipio: string;
    FNome: string;
    [JSONName('p_index')]
    FPIndex: Integer;
    [JSONName('porcentagem_fim_semana')]
    FPorcentagemFimSemana: Double;
    [JSONName('porcentagem_tag')]
    FPorcentagemTag: Double;
    FRodovia: string;
    [JSONName('special_toll')]
    FSpecialToll: Boolean;
    FTarifa: TTarifa;
    FUf: string;
  published
    property CodigoAntt: string read FCodigoAntt write FCodigoAntt;
    property CodigoIbge: string read FCodigoIbge write FCodigoIbge;
    property CodigoIntegracaoSemParar: Integer read FCodigoIntegracaoSemParar write FCodigoIntegracaoSemParar;
    property Concessionaria: string read FConcessionaria write FConcessionaria;
    property ConcessionariaContato: string read FConcessionariaContato write FConcessionariaContato;
    property IdApi: string read FIdApi write FIdApi;
    property Km: string read FKm write FKm;
    property Municipio: string read FMunicipio write FMunicipio;
    property Nome: string read FNome write FNome;
    property PIndex: Integer read FPIndex write FPIndex;
    property PorcentagemFimSemana: Double read FPorcentagemFimSemana write FPorcentagemFimSemana;
    property PorcentagemTag: Double read FPorcentagemTag write FPorcentagemTag;
    property Rodovia: string read FRodovia write FRodovia;
    property SpecialToll: Boolean read FSpecialToll write FSpecialToll;
    property Tarifa: TTarifa read FTarifa;
    property Uf: string read FUf write FUf;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TExitTowardElements = class
  private
    FText: string;
  published
    property Text: string read FText write FText;
  end;

  TSinal = class(TBaseJSONQualP)
  private
    [JSONName('exit_branch_elements'), JSONMarshalled(False)]
    FExitBranchElementsArray: TArray<TExitBranchElements>;
    [GenericListReflect]
    FExitBranchElements: TObjectList<TExitBranchElements>;
    [JSONName('exit_number_elements'), JSONMarshalled(False)]
    FExitNumberElementsArray: TArray<TExitNumberElements>;
    [GenericListReflect]
    FExitNumberElements: TObjectList<TExitNumberElements>;
    [JSONName('exit_toward_elements'), JSONMarshalled(False)]
    FExitTowardElementsArray: TArray<TExitTowardElements>;
    [GenericListReflect]
    FExitTowardElements: TObjectList<TExitTowardElements>;
    function GetExitBranchElements: TObjectList<TExitBranchElements>;
    function GetExitNumberElements: TObjectList<TExitNumberElements>;
    function GetExitTowardElements: TObjectList<TExitTowardElements>;
  protected
    function GetAsJson: string; override;
  published
    property ExitBranchElements: TObjectList<TExitBranchElements> read GetExitBranchElements;
    property ExitNumberElements: TObjectList<TExitNumberElements> read GetExitNumberElements;
    property ExitTowardElements: TObjectList<TExitTowardElements> read GetExitTowardElements;
  public
    destructor Destroy; override;
  end;

  TExitNumberElements = class
  private
    FText: string;
  published
    property Text: string read FText write FText;
  end;

  TExitBranchElements = class
  private
    [JSONName('consecutive_count')]
    FConsecutiveCount: Integer;
    FText: string;
  published
    property ConsecutiveCount: Integer read FConsecutiveCount write FConsecutiveCount;
    property Text: string read FText write FText;
  end;

  TRotograma = class(TBaseJSONQualP)
  private
    [JSONName('contagem_saida_rotatoria')]
    FContagemSaidaRotatoria: Integer;
    [JSONName('distancia_km')]
    FDistanciaKm: Double;
    [JSONName('distancia_percorrida_km')]
    FDistanciaPercorridaKm: Double;
    [JSONName('inicio_ruas')]
    FInicioRuasArray: TArray<string>;
    [JSONMarshalled(False)]
    FInicioRuas: TList<string>;
    FInstrucao: string;
    [JSONName('instrucao_verbal_alerta_transicao')]
    FInstrucaoVerbalAlertaTransicao: string;
    [JSONName('instrucao_verbal_pos_transicao')]
    FInstrucaoVerbalPosTransicao: string;
    [JSONName('instrucao_verbal_pre_transicao')]
    FInstrucaoVerbalPreTransicao: string;
    [JSONName('modo_viagem')]
    FModoViagem: string;
    [JSONName('p_index')]
    FPIndex: Integer;
    [JSONName('ruas')]
    FRuasArray: TArray<string>;
    [JSONMarshalled(False)]
    FRuas: TList<string>;
    FSinal: TSinal;
    [JSONName('tempo_segundos')]
    FTempoSegundos: Double;
    FTipo: Integer;
    [JSONName('tipo_viagem')]
    FTipoViagem: string;
    [JSONName('verbal_multi_cue')]
    FVerbalMultiCue: Boolean;
    function GetInicioRuas: TList<string>;
    function GetRuas: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property ContagemSaidaRotatoria: Integer read FContagemSaidaRotatoria write FContagemSaidaRotatoria;
    property DistanciaKm: Double read FDistanciaKm write FDistanciaKm;
    property DistanciaPercorridaKm: Double read FDistanciaPercorridaKm write FDistanciaPercorridaKm;
    property InicioRuas: TList<string> read GetInicioRuas;
    property Instrucao: string read FInstrucao write FInstrucao;
    property InstrucaoVerbalAlertaTransicao: string read FInstrucaoVerbalAlertaTransicao write FInstrucaoVerbalAlertaTransicao;
    property InstrucaoVerbalPosTransicao: string read FInstrucaoVerbalPosTransicao write FInstrucaoVerbalPosTransicao;
    property InstrucaoVerbalPreTransicao: string read FInstrucaoVerbalPreTransicao write FInstrucaoVerbalPreTransicao;
    property ModoViagem: string read FModoViagem write FModoViagem;
    property PIndex: Integer read FPIndex write FPIndex;
    property Ruas: TList<string> read GetRuas;
    property Sinal: TSinal read FSinal;
    property TempoSegundos: Double read FTempoSegundos write FTempoSegundos;
    property Tipo: Integer read FTipo write FTipo;
    property TipoViagem: string read FTipoViagem write FTipoViagem;
    property VerbalMultiCue: Boolean read FVerbalMultiCue write FVerbalMultiCue;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TDuracao = class
  private
    FTexto: string;
    FValor: Double;
  published
    property Texto: string read FTexto write FTexto;
    property Valor: Double read FValor write FValor;
  end;

  TDistancia = class
  private
    FTexto: string;
    FValor: Double;
  published
    property Texto: string read FTexto write FTexto;
    property Valor: Double read FValor write FValor;
  end;

  TRespostaQualP = class(TBaseJSONQualP)
  private
    [JSONName('balancas'), JSONMarshalled(False)]
    FBalancasArray: TArray<TBalancas>;
    [GenericListReflect]
    FBalancas: TObjectList<TBalancas>;
    [JSONName('calcular_volta')]
    FCalcularVolta: Boolean;
    [JSONName('chave_excecao')]
    FChaveExcecao: string;
    [JSONName('consumo_combustivel')]
    FConsumoCombustivel: Double;
    [JSONName('coordenada_fim')]
    FCoordenadaFim: string;
    [JSONName('coordenada_inicio')]
    FCoordenadaInicio: string;
    FDistancia: TDistancia;
    FDuracao: TDuracao;
    [JSONName('endereco_fim')]
    FEnderecoFim: string;
    [JSONName('endereco_inicio')]
    FEnderecoInicio: string;
    [JSONName('id_transacao')]
    FIdTransacao: Integer;
    [JSONName('link_site_qualp')]
    FLinkSiteQualp: string;
    [JSONName('link_site_qualp_report')]
    FLinkSiteQualpReport: string;
    [JSONName('locais')]
    FLocaisArray: TArray<string>;
    [JSONMarshalled(False)]
    FLocais: TList<string>;
    [JSONName('locais_privados'), JSONMarshalled(False)]
    FLocaisPrivadosArray: TArray<TLocaisPrivados>;
    [GenericListReflect]
    FLocaisPrivados: TObjectList<TLocaisPrivados>;
    [JSONName('otimizar_rota')]
    FOtimizarRota: Boolean;
    [JSONName('otimizar_rota_destino')]
    FOtimizarRotaDestino: string;
    [JSONName('pedagios'), JSONMarshalled(False)]
    FPedagiosArray: TArray<TPedagios>;
    [GenericListReflect]
    FPedagios: TObjectList<TPedagios>;
    [JSONName('polilinha_codificada')]
    FPolilinhaCodificada: string;
    [JSONName('polilinha_simplificada')]
    FPolilinhaSimplificada: string;
    [JSONName('rota_imagem')]
    FRotaImagem: string;
    [JSONName('roteador_selecionado')]
    FRoteadorSelecionado: string;
    [JSONName('rotograma'), JSONMarshalled(False)]
    FRotogramaArray: TArray<TRotograma>;
    [GenericListReflect]
    FRotograma: TObjectList<TRotograma>;
    [JSONName('tabela_frete')]
    FTabelaFrete: TTabelaFrete;
    [JSONName('ufs')]
    FUfsArray: TArray<string>;
    [JSONMarshalled(False)]
    FUfs: TList<string>;
    function GetBalancas: TObjectList<TBalancas>;
    function GetLocais: TList<string>;
    function GetLocaisPrivados: TObjectList<TLocaisPrivados>;
    function GetPedagios: TObjectList<TPedagios>;
    function GetRotograma: TObjectList<TRotograma>;
    function GetUfs: TList<string>;
  protected
    function GetAsJson: string; override;
  published
    property Balancas: TObjectList<TBalancas> read GetBalancas;
    property CalcularVolta: Boolean read FCalcularVolta write FCalcularVolta;
    property ChaveExcecao: string read FChaveExcecao write FChaveExcecao;
    property ConsumoCombustivel: Double read FConsumoCombustivel write FConsumoCombustivel;
    property CoordenadaFim: string read FCoordenadaFim write FCoordenadaFim;
    property CoordenadaInicio: string read FCoordenadaInicio write FCoordenadaInicio;
    property Distancia: TDistancia read FDistancia;
    property Duracao: TDuracao read FDuracao;
    property EnderecoFim: string read FEnderecoFim write FEnderecoFim;
    property EnderecoInicio: string read FEnderecoInicio write FEnderecoInicio;
    property IdTransacao: Integer read FIdTransacao write FIdTransacao;
    property LinkSiteQualp: string read FLinkSiteQualp write FLinkSiteQualp;
    property LinkSiteQualpReport: string read FLinkSiteQualpReport write FLinkSiteQualpReport;
    property Locais: TList<string> read GetLocais;
    property LocaisPrivados: TObjectList<TLocaisPrivados> read GetLocaisPrivados;
    property OtimizarRota: Boolean read FOtimizarRota write FOtimizarRota;
    property OtimizarRotaDestino: string read FOtimizarRotaDestino write FOtimizarRotaDestino;
    property Pedagios: TObjectList<TPedagios> read GetPedagios;
    property PolilinhaCodificada: string read FPolilinhaCodificada write FPolilinhaCodificada;
    property PolilinhaSimplificada: string read FPolilinhaSimplificada write FPolilinhaSimplificada;
    property RotaImagem: string read FRotaImagem write FRotaImagem;
    property RoteadorSelecionado: string read FRoteadorSelecionado write FRoteadorSelecionado;
    property Rotograma: TObjectList<TRotograma> read GetRotograma;
    property TabelaFrete: TTabelaFrete read FTabelaFrete;
    property Ufs: TList<string> read GetUfs;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TTipoTabelaFrete }

constructor TTipoTabelaFrete.Create;
begin
  inherited;
  F_2 := TItemTabelaFrete.Create;
  F_3 := TItemTabelaFrete.Create;
  F_4 := TItemTabelaFrete.Create;
  F_5 := TItemTabelaFrete.Create;
  F_6 := TItemTabelaFrete.Create;
  F_7 := TItemTabelaFrete.Create;
  F_8 := TItemTabelaFrete.Create;
  F_9 := TItemTabelaFrete.Create;
end;

destructor TTipoTabelaFrete.Destroy;
begin
  F_2.Free;
  F_3.Free;
  F_4.Free;
  F_5.Free;
  F_6.Free;
  F_7.Free;
  F_8.Free;
  F_9.Free;
  inherited;
end;

{ TDados }

constructor TDados.Create;
begin
  inherited;
  FA := TTipoTabelaFrete.Create;
  FB := TTipoTabelaFrete.Create;
  FC := TTipoTabelaFrete.Create;
  FD := TTipoTabelaFrete.Create;
end;

destructor TDados.Destroy;
begin
  FA.Free;
  FB.Free;
  FC.Free;
  FD.Free;
  inherited;
end;

{ TTabelaFrete }

constructor TTabelaFrete.Create;
begin
  inherited;
  FDados := TDados.Create;
end;

destructor TTabelaFrete.Destroy;
begin
  FDados.Free;
  inherited;
end;

{ TCategories }

constructor TCategories.Create;
begin
  inherited;
  FPivot := TPivot.Create;
end;

destructor TCategories.Destroy;
begin
  FPivot.Free;
  inherited;
end;

{ TLocaisPrivados }

destructor TLocaisPrivados.Destroy;
begin
  GetLocationContact.Free;
  GetServices.Free;
  GetProducts.Free;
  GetLocationAreas.Free;
  GetCategories.Free;
  inherited;
end;

function TLocaisPrivados.GetCategories: TObjectList<TCategories>;
begin
  Result := ObjectList<TCategories>(FCategories, FCategoriesArray);
end;

function TLocaisPrivados.GetLocationAreas: TObjectList<TLocationAreas>;
begin
  Result := ObjectList<TLocationAreas>(FLocationAreas, FLocationAreasArray);
end;

function TLocaisPrivados.GetLocationContact: TObjectList<TLocationContact>;
begin
  Result := ObjectList<TLocationContact>(FLocationContact, FLocationContactArray);
end;

function TLocaisPrivados.GetProducts: TObjectList<TProducts>;
begin
  Result := ObjectList<TProducts>(FProducts, FProductsArray);
end;

function TLocaisPrivados.GetServices: TObjectList<TServices>;
begin
  Result := ObjectList<TServices>(FServices, FServicesArray);
end;

function TLocaisPrivados.GetAsJson: string;
begin
  RefreshArray<TCategories>(FCategories, FCategoriesArray);
  RefreshArray<TLocationAreas>(FLocationAreas, FLocationAreasArray);
  RefreshArray<TLocationContact>(FLocationContact, FLocationContactArray);
  RefreshArray<TProducts>(FProducts, FProductsArray);
  RefreshArray<TServices>(FServices, FServicesArray);
  Result := inherited;
end;

{ TPedagios }

constructor TPedagios.Create;
begin
  inherited;
  FTarifa := TTarifa.Create;
end;

destructor TPedagios.Destroy;
begin
  FTarifa.Free;
  inherited;
end;

{ TSinal }

destructor TSinal.Destroy;
begin
  GetExitBranchElements.Free;
  GetExitTowardElements.Free;
  GetExitNumberElements.Free;
  inherited;
end;

function TSinal.GetExitBranchElements: TObjectList<TExitBranchElements>;
begin
  Result := ObjectList<TExitBranchElements>(FExitBranchElements, FExitBranchElementsArray);
end;

function TSinal.GetExitNumberElements: TObjectList<TExitNumberElements>;
begin
  Result := ObjectList<TExitNumberElements>(FExitNumberElements, FExitNumberElementsArray);
end;

function TSinal.GetExitTowardElements: TObjectList<TExitTowardElements>;
begin
  Result := ObjectList<TExitTowardElements>(FExitTowardElements, FExitTowardElementsArray);
end;

function TSinal.GetAsJson: string;
begin
  RefreshArray<TExitBranchElements>(FExitBranchElements, FExitBranchElementsArray);
  RefreshArray<TExitNumberElements>(FExitNumberElements, FExitNumberElementsArray);
  RefreshArray<TExitTowardElements>(FExitTowardElements, FExitTowardElementsArray);
  Result := inherited;
end;

{ TRotograma }

constructor TRotograma.Create;
begin
  inherited;
  FSinal := TSinal.Create;
end;

destructor TRotograma.Destroy;
begin
  FSinal.Free;
  GetInicioRuas.Free;
  GetRuas.Free;
  inherited;
end;

function TRotograma.GetInicioRuas: TList<string>;
begin
  Result := List<string>(FInicioRuas, FInicioRuasArray);
end;

function TRotograma.GetRuas: TList<string>;
begin
  Result := List<string>(FRuas, FRuasArray);
end;

function TRotograma.GetAsJson: string;
begin
  RefreshArray<string>(FInicioRuas, FInicioRuasArray);
  RefreshArray<string>(FRuas, FRuasArray);
  Result := inherited;
end;

{ TRespostaQualP }

constructor TRespostaQualP.Create;
begin
  inherited;
  FDistancia := TDistancia.Create;
  FDuracao := TDuracao.Create;
  FTabelaFrete := TTabelaFrete.Create;
end;

destructor TRespostaQualP.Destroy;
begin
  FDistancia.Free;
  FDuracao.Free;
  FTabelaFrete.Free;
  GetRotograma.Free;
  GetPedagios.Free;
  GetBalancas.Free;
  GetLocaisPrivados.Free;
  GetUfs.Free;
  GetLocais.Free;
  inherited;
end;

function TRespostaQualP.GetBalancas: TObjectList<TBalancas>;
begin
  Result := ObjectList<TBalancas>(FBalancas, FBalancasArray);
end;

function TRespostaQualP.GetLocais: TList<string>;
begin
  Result := List<string>(FLocais, FLocaisArray);
end;

function TRespostaQualP.GetLocaisPrivados: TObjectList<TLocaisPrivados>;
begin
  Result := ObjectList<TLocaisPrivados>(FLocaisPrivados, FLocaisPrivadosArray);
end;

function TRespostaQualP.GetPedagios: TObjectList<TPedagios>;
begin
  Result := ObjectList<TPedagios>(FPedagios, FPedagiosArray);
end;

function TRespostaQualP.GetRotograma: TObjectList<TRotograma>;
begin
  Result := ObjectList<TRotograma>(FRotograma, FRotogramaArray);
end;

function TRespostaQualP.GetUfs: TList<string>;
begin
  Result := List<string>(FUfs, FUfsArray);
end;

function TRespostaQualP.GetAsJson: string;
begin
  RefreshArray<TBalancas>(FBalancas, FBalancasArray);
  RefreshArray<string>(FLocais, FLocaisArray);
  RefreshArray<TLocaisPrivados>(FLocaisPrivados, FLocaisPrivadosArray);
  RefreshArray<TPedagios>(FPedagios, FPedagiosArray);
  RefreshArray<TRotograma>(FRotograma, FRotogramaArray);
  RefreshArray<string>(FUfs, FUfsArray);
  Result := inherited;
end;

end.
