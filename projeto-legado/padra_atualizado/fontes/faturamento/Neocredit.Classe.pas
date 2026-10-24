unit Neocredit.Classe;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils, untBaseIntegracaoJSON,
  System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TLibNeocredit = class
  public
    const
      API_NEOCREDIT                 = 'NEOCREDIT';
      COD_STATUS_SEM_CONSULTA       = '00';
      COD_STATUS_APROVADO           = '01';
      COD_STATUS_REPROVADO          = '02';
      COD_STATUS_PROCESSANDO        = '03';
      COD_STATUS_AGUARDANDO_PARECER = '04';
      ID_LOCK                       = 'MONITOR_'+API_NEOCREDIT+'_%s';
      ATTEMPTS_LOCK                 = 10;
  public
    class function RetornaDescricaoStatus(const AStatus: String): String;
    class function RetornaCodigoStatus(const ADescricaoStatus: String): String;
  end;

  TEsteiraNeocredit = class(TBaseJSON)
  private
    FDocumento: string;
    FEmail: string;
    [JSONName('limite_sugerido')]
    FLimiteSugerido: string;
    FNome: string;
    [JSONName('politica_pj')]
    FPoliticaPj: string;
    [JSONName('razao_social')]
    FRazaoSocial: string;
    FStatus: string;
    [JSONName('tipo_consulta')]
    FTipoConsulta: string;
    FCnpj: string;
    [JSONName('data_atualizacao_limite')]
    FDataAtualizacaoLimite: string;
    [JSONName('data_cadastro')]
    FDataCadastro: string;
    [JSONName('data_primeira_compra')]
    FDataPrimeiraCompra: string;
    [JSONName('data_ultima_compra')]
    FDataUltimaCompra: string;
    [JSONName('data_validade_limite')]
    FDataValidadeLimite: string;
    [JSONName('id_cliente')]
    FIdCliente: string;
    [JSONName('limite_de_credito')]
    FLimiteDeCredito: Double;
    [JSONName('limite_disponivel')]
    FLimiteDisponivel: Double;
    [JSONName('maior_atraso')]
    FMaiorAtraso: Integer;
    [JSONName('maior_atraso_pago')]
    FMaiorAtrasoPago: Integer;
    [JSONName('maior_atraso_pago_12_meses')]
    FMaiorAtrasoPago12Meses: Integer;
    [JSONName('maior_atraso_pago_24_meses')]
    FMaiorAtrasoPago24Meses: Integer;
    [JSONName('media_atraso')]
    FMediaAtraso: Integer;
    FMensagem: string;
    [JSONName('percentual_limite_disponivel')]
    FPercentualLimiteDisponivel: Double;
    [JSONName('percentual_pagamentos_pagos_ate_5_dias')]
    FPercentualPagamentosPagosAte5Dias: Double;
    [JSONName('percentual_pagamentos_pontuais')]
    FPercentualPagamentosPontuais: Double;
    [JSONName('percentual_pagamentos_pontuais_12_meses')]
    FPercentualPagamentosPontuais12Meses: Double;
    [JSONName('percentual_pagamentos_pontuais_24_meses')]
    FPercentualPagamentosPontuais24Meses: Double;
    [JSONName('percentual_pagamentos_pontuais_6_meses')]
    FPercentualPagamentosPontuais6Meses: Double;
    [JSONName('possui_atraso_aberto')]
    FPossuiAtrasoAberto: string;
    [JSONName('quantidade_compras')]
    FQuantidadeCompras: Integer;
    [JSONName('quantidade_compras_aberto')]
    FQuantidadeComprasAberto: Integer;
    [JSONName('quantidade_compras_pagas')]
    FQuantidadeComprasPagas: Integer;
    [JSONName('quantidade_compras_prazo')]
    FQuantidadeComprasPrazo: Integer;
    FRazao: string;
    FRisco: string;
    [JSONName('valor_compra_media_mensal')]
    FValorCompraMediaMensal: Double;
    [JSONName('valor_total_aberto')]
    FValorTotalAberto: Double;
    [JSONName('valor_total_compras')]
    FValorTotalCompras: Double;
    [JSONName('valor_total_compras_12_meses')]
    FValorTotalCompras12Meses: Double;
    [JSONName('valor_total_compras_24_meses')]
    FValorTotalCompras24Meses: Double;
    [JSONName('valor_total_compras_6_meses')]
    FValorTotalCompras6Meses: Double;
    [JSONName('valor_total_pago')]
    FValorTotalPago: Double;
    [JSONName('valor_total_pago_12_meses')]
    FValorTotalPago12Meses: Double;
    [JSONName('valor_total_pago_24_meses')]
    FValorTotalPago24Meses: Double;
    [JSONName('valor_total_pago_6_meses')]
    FValorTotalPago6Meses: Double;
  published
    property Documento: string read FDocumento write FDocumento;
    property Email: string read FEmail write FEmail;
    property LimiteSugerido: string read FLimiteSugerido write FLimiteSugerido;
    property Nome: string read FNome write FNome;
    property PoliticaPj: string read FPoliticaPj write FPoliticaPj;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Status: string read FStatus write FStatus;
    property TipoConsulta: string read FTipoConsulta write FTipoConsulta;
    property Cnpj: string read FCnpj write FCnpj;
    property DataAtualizacaoLimite: string read FDataAtualizacaoLimite write FDataAtualizacaoLimite;
    property DataCadastro: string read FDataCadastro write FDataCadastro;
    property DataPrimeiraCompra: string read FDataPrimeiraCompra write FDataPrimeiraCompra;
    property DataUltimaCompra: string read FDataUltimaCompra write FDataUltimaCompra;
    property DataValidadeLimite: string read FDataValidadeLimite write FDataValidadeLimite;
    property IdCliente: string read FIdCliente write FIdCliente;
    property LimiteDeCredito: Double read FLimiteDeCredito write FLimiteDeCredito;
    property LimiteDisponivel: Double read FLimiteDisponivel write FLimiteDisponivel;
    property MaiorAtraso: Integer read FMaiorAtraso write FMaiorAtraso;
    property MaiorAtrasoPago: Integer read FMaiorAtrasoPago write FMaiorAtrasoPago;
    property MaiorAtrasoPago12Meses: Integer read FMaiorAtrasoPago12Meses write FMaiorAtrasoPago12Meses;
    property MaiorAtrasoPago24Meses: Integer read FMaiorAtrasoPago24Meses write FMaiorAtrasoPago24Meses;
    property MediaAtraso: Integer read FMediaAtraso write FMediaAtraso;
    property Mensagem: string read FMensagem write FMensagem;
    property PercentualLimiteDisponivel: Double read FPercentualLimiteDisponivel write FPercentualLimiteDisponivel;
    property PercentualPagamentosPagosAte5Dias: Double read FPercentualPagamentosPagosAte5Dias write FPercentualPagamentosPagosAte5Dias;
    property PercentualPagamentosPontuais: Double read FPercentualPagamentosPontuais write FPercentualPagamentosPontuais;
    property PercentualPagamentosPontuais12Meses: Double read FPercentualPagamentosPontuais12Meses write FPercentualPagamentosPontuais12Meses;
    property PercentualPagamentosPontuais24Meses: Double read FPercentualPagamentosPontuais24Meses write FPercentualPagamentosPontuais24Meses;
    property PercentualPagamentosPontuais6Meses: Double read FPercentualPagamentosPontuais6Meses write FPercentualPagamentosPontuais6Meses;
    property PossuiAtrasoAberto: string read FPossuiAtrasoAberto write FPossuiAtrasoAberto;
    property QuantidadeCompras: Integer read FQuantidadeCompras write FQuantidadeCompras;
    property QuantidadeComprasAberto: Integer read FQuantidadeComprasAberto write FQuantidadeComprasAberto;
    property QuantidadeComprasPagas: Integer read FQuantidadeComprasPagas write FQuantidadeComprasPagas;
    property QuantidadeComprasPrazo: Integer read FQuantidadeComprasPrazo write FQuantidadeComprasPrazo;
    property Razao: string read FRazao write FRazao;
    property Risco: string read FRisco write FRisco;
    property ValorCompraMediaMensal: Double read FValorCompraMediaMensal write FValorCompraMediaMensal;
    property ValorTotalAberto: Double read FValorTotalAberto write FValorTotalAberto;
    property ValorTotalCompras: Double read FValorTotalCompras write FValorTotalCompras;
    property ValorTotalCompras12Meses: Double read FValorTotalCompras12Meses write FValorTotalCompras12Meses;
    property ValorTotalCompras24Meses: Double read FValorTotalCompras24Meses write FValorTotalCompras24Meses;
    property ValorTotalCompras6Meses: Double read FValorTotalCompras6Meses write FValorTotalCompras6Meses;
    property ValorTotalPago: Double read FValorTotalPago write FValorTotalPago;
    property ValorTotalPago12Meses: Double read FValorTotalPago12Meses write FValorTotalPago12Meses;
    property ValorTotalPago24Meses: Double read FValorTotalPago24Meses write FValorTotalPago24Meses;
    property ValorTotalPago6Meses: Double read FValorTotalPago6Meses write FValorTotalPago6Meses;
  end;

  TRetornoEsteiraNeocredit = class(TBaseJSON)
  private
    FId: Integer;
    FStatus: string;
  published
    property Id: Integer read FId write FId;
    property Status: string read FStatus write FStatus;
  end;

  TEmails = class;
  TInputInicial = class;
  TParecer = class;

  TMetadados = class
  private
    [JSONName('dias_ultima_analise')]
    FDiasUltimaAnalise: string;
    [JSONName('nome_solicitante')]
    FNomeSolicitante: string;
    [JSONName('quantidade_analises')]
    FQuantidadeAnalises: Integer;
  published
    property DiasUltimaAnalise: string read FDiasUltimaAnalise write FDiasUltimaAnalise;
    property NomeSolicitante: string read FNomeSolicitante write FNomeSolicitante;
    property QuantidadeAnalises: Integer read FQuantidadeAnalises write FQuantidadeAnalises;
  end;

  TCliente = class
  private
    FDocumento: string;
    FId: Integer;
    FNome: string;
    [JSONName('tipo_documento')]
    FTipoDocumento: string;
  published
    property Documento: string read FDocumento write FDocumento;
    property Id: Integer read FId write FId;
    property Nome: string read FNome write FNome;
    property TipoDocumento: string read FTipoDocumento write FTipoDocumento;
  end;

  THistoricoFases = class
  private
    [SuppressZero, JSONName('data_entrada')]
    FDataEntrada: TDateTime;
    [JSONName('fase_atual')]
    FFaseAtual: Boolean;
    FId: string;
    [JSONName('is_expirado')]
    FIsExpirado: Boolean;
    [JSONName('marcar_final')]
    FMarcarFinal: Boolean;
    FNome: string;
    FType: string;
  published
    property DataEntrada: TDateTime read FDataEntrada write FDataEntrada;
    property FaseAtual: Boolean read FFaseAtual write FFaseAtual;
    property Id: string read FId write FId;
    property IsExpirado: Boolean read FIsExpirado write FIsExpirado;
    property MarcarFinal: Boolean read FMarcarFinal write FMarcarFinal;
    property Nome: string read FNome write FNome;
    property &Type: string read FType write FType;
  end;

  TInputInicial = class
  private
    FDocumento: string;
    FEmail: string;
    [JSONName('limite_sugerido')]
    FLimiteSugerido: string;
    FNome: string;
    [JSONName('politica_pj')]
    FPoliticaPj: string;
    [JSONName('razao_social')]
    FRazaoSocial: string;
    FStatus: string;
    [JSONName('tipo_consulta')]
    FTipoConsulta: string;
  published
    property Documento: string read FDocumento write FDocumento;
    property Email: string read FEmail write FEmail;
    property LimiteSugerido: string read FLimiteSugerido write FLimiteSugerido;
    property Nome: string read FNome write FNome;
    property PoliticaPj: string read FPoliticaPj write FPoliticaPj;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Status: string read FStatus write FStatus;
    property TipoConsulta: string read FTipoConsulta write FTipoConsulta;
  end;

  TParecer = class
  end;

  TEmails = class
  end;

  TDadosExecucao = class(TBaseJSON)
  private
    [JSONName('emails'), JSONMarshalled(False)]
    FEmailsArray: TArray<TEmails>;
    [GenericListReflect]
    FEmails: TObjectList<TEmails>;
    [JSONName('input_inicial')]
    FInputInicial: TInputInicial;
    [JSONName('parecer'), JSONMarshalled(False)]
    FParecerArray: TArray<TParecer>;
    [GenericListReflect]
    FParecer: TObjectList<TParecer>;
    FStatus: string;
    function GetEmails: TObjectList<TEmails>;
    function GetParecer: TObjectList<TParecer>;
  protected
    function GetAsJson: string; override;
  published
    property Emails: TObjectList<TEmails> read GetEmails;
    property InputInicial: TInputInicial read FInputInicial;
    property Parecer: TObjectList<TParecer> read GetParecer;
    property Status: string read FStatus write FStatus;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TCampos = class
  private
    FDocumento: string;
    FEmail: string;
    [JSONName('limite_sugerido')]
    FLimiteSugerido: string;
    FNome: string;
    [JSONName('politica_pj')]
    FPoliticaPj: string;
    [JSONName('razao_social')]
    FRazaoSocial: string;
    FStatus: string;
    [JSONName('tipo_consulta')]
    FTipoConsulta: string;
  published
    property Documento: string read FDocumento write FDocumento;
    property Email: string read FEmail write FEmail;
    property LimiteSugerido: string read FLimiteSugerido write FLimiteSugerido;
    property Nome: string read FNome write FNome;
    property PoliticaPj: string read FPoliticaPj write FPoliticaPj;
    property RazaoSocial: string read FRazaoSocial write FRazaoSocial;
    property Status: string read FStatus write FStatus;
    property TipoConsulta: string read FTipoConsulta write FTipoConsulta;
  end;

  TStatusEsteiraNeocredit = class(TBaseJSON)
  private
    FCampos: TCampos;
    FCliente: TCliente;
    [JSONName('dados_execucao')]
    FDadosExecucao: TDadosExecucao;
    [SuppressZero, JSONName('data_atualizacao')]
    FDataAtualizacao: TDateTime;
    [JSONName('data_conclusao')]
    FDataConclusao: string;
    [SuppressZero, JSONName('data_criacao')]
    FDataCriacao: TDateTime;
    [JSONName('fase_atual')]
    FFaseAtual: string;
    [JSONName('has_novo_email')]
    FHasNovoEmail: Boolean;
    [JSONName('historico_fases'), JSONMarshalled(False)]
    FHistoricoFasesArray: TArray<THistoricoFases>;
    [GenericListReflect]
    FHistoricoFases: TObjectList<THistoricoFases>;
    FId: Integer;
    [JSONName('id_empresa')]
    FIdEmpresa: Integer;
    [JSONName('id_empresa_esteira')]
    FIdEmpresaEsteira: Integer;
    [JSONName('id_fase_atual')]
    FIdFaseAtual: string;
    [JSONName('is_concluido')]
    FIsConcluido: Boolean;
    FMetadados: TMetadados;
    FStatus: string;
    function GetHistoricoFases: TObjectList<THistoricoFases>;
  protected
    function GetAsJson: string; override;
  published
    property Campos: TCampos read FCampos;
    property Cliente: TCliente read FCliente;
    property DadosExecucao: TDadosExecucao read FDadosExecucao;
    property DataAtualizacao: TDateTime read FDataAtualizacao write FDataAtualizacao;
    property DataConclusao: string read FDataConclusao write FDataConclusao;
    property DataCriacao: TDateTime read FDataCriacao write FDataCriacao;
    property FaseAtual: string read FFaseAtual write FFaseAtual;
    property HasNovoEmail: Boolean read FHasNovoEmail write FHasNovoEmail;
    property HistoricoFases: TObjectList<THistoricoFases> read GetHistoricoFases;
    property Id: Integer read FId write FId;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdEmpresaEsteira: Integer read FIdEmpresaEsteira write FIdEmpresaEsteira;
    property IdFaseAtual: string read FIdFaseAtual write FIdFaseAtual;
    property IsConcluido: Boolean read FIsConcluido write FIsConcluido;
    property Metadados: TMetadados read FMetadados;
    property Status: string read FStatus write FStatus;
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TDadosExecucao }

constructor TDadosExecucao.Create;
begin
  inherited;
  FInputInicial := TInputInicial.Create;
end;

destructor TDadosExecucao.Destroy;
begin
  FInputInicial.Free;
  GetEmails.Free;
  GetParecer.Free;
  inherited;
end;

function TDadosExecucao.GetEmails: TObjectList<TEmails>;
begin
  Result := ObjectList<TEmails>(FEmails, FEmailsArray);
end;

function TDadosExecucao.GetParecer: TObjectList<TParecer>;
begin
  Result := ObjectList<TParecer>(FParecer, FParecerArray);
end;

function TDadosExecucao.GetAsJson: string;
begin
  RefreshArray<TEmails>(FEmails, FEmailsArray);
  RefreshArray<TParecer>(FParecer, FParecerArray);
  Result := inherited;
end;

{ TStatusEsteiraNeocredit }

constructor TStatusEsteiraNeocredit.Create;
begin
  inherited;
  FCampos := TCampos.Create;
  FDadosExecucao := TDadosExecucao.Create;
  FCliente := TCliente.Create;
  FMetadados := TMetadados.Create;
end;

destructor TStatusEsteiraNeocredit.Destroy;
begin
  FCampos.Free;
  FDadosExecucao.Free;
  FCliente.Free;
  FMetadados.Free;
  GetHistoricoFases.Free;
  inherited;
end;

function TStatusEsteiraNeocredit.GetHistoricoFases: TObjectList<THistoricoFases>;
begin
  Result := ObjectList<THistoricoFases>(FHistoricoFases, FHistoricoFasesArray);
end;

function TStatusEsteiraNeocredit.GetAsJson: string;
begin
  RefreshArray<THistoricoFases>(FHistoricoFases, FHistoricoFasesArray);
  Result := inherited;
end;

{ TLibNeocredit }

class function TLibNeocredit.RetornaCodigoStatus(
  const ADescricaoStatus: String): String;
var
  LDescricaoStatus: String;
begin
  LDescricaoStatus := UpperCase(ADescricaoStatus);

  If LDescricaoStatus = 'APROVAR' Then
    Result := COD_STATUS_APROVADO
  Else If LDescricaoStatus = 'REPROVAR' Then
    Result := COD_STATUS_REPROVADO
  Else If LDescricaoStatus = 'PROCESSANDO' Then
    Result := COD_STATUS_PROCESSANDO
  Else If LDescricaoStatus = 'AGUARDANDO_PARECER' Then
    Result := COD_STATUS_AGUARDANDO_PARECER
  Else
    Result := COD_STATUS_SEM_CONSULTA;
end;

class function TLibNeocredit.RetornaDescricaoStatus(const AStatus: String): String;
begin
  If AStatus = COD_STATUS_APROVADO Then
    Result := 'CONS. LIBERADO'
  Else If AStatus = COD_STATUS_REPROVADO Then
    Result := 'CONS. DEFERIDO'
  Else If AStatus = COD_STATUS_PROCESSANDO Then
    Result := 'PROCESSANDO'
  Else If AStatus = COD_STATUS_AGUARDANDO_PARECER Then
    Result := 'AGUARDANDO PARECER'
  Else
    Result := 'SEM CONSULTA';
end;

end.
