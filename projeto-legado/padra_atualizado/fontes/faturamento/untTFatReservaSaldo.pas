unit untTFatReservaSaldo;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
{$ENDIF LINUX}
  Math,
  TypInfo,
  System.Variants,
  System.Classes,
  untIFatReservaSaldo,
  Shared.Functions.Monitores,
  Generics.Collections;

const
  spIdMonitorAudit            = 'MONITOR_AUDIT_%s';
  spIdInactivityMonitorAudit  = 'TEST_INACTIVITY_AUDIT_%s';
  spRecalculoSaldoReservadoExeName = 'RecalculoSaldoReservadoMonitor.exe';
  spTimeLimitMonitorAudit     = 30;
  spAttemptsLockMonitorAudit  = 30;

  sNomeTabelaDocumentosReserva = 'TMP_RESERVA_%s_%s_%s_%s';

  cpoPedidoVendaCli = 'QTPD_V';
  cpoPedidoVendaFil = 'QTPD_F';
  cpoREnderecamento = 'QTPD_E';
  cpoOrdemProducao  = 'QTPD_P';
  cpoRTransferencia = 'SALTRA';
  cpoReservGarantia = 'SALREG';
  cpoReservExterno  = 'SALEXT';
  cpoQtdPedBaiFut   = 'QTPDBF';
  cpoSalPedBaiFut   = 'SDPDBF';

  tblCadLot = 'CADLOT';
  tblIteGer = 'ITEGER';

  sqlAuditExecuted   = 'SELECT ITE_ULTAUD, ITE_REPAUD                         '+
                       '  FROM ITEGER                                         '+
                       'WHERE ITE_CODITE = :CODITE                            '+
                       '  AND ITE_CODEMP = :CODEMP                            ';

  sqlCarregarLotes   = 'SELECT LOT_NUMLOT                                     '+
                       '  FROM CADLOT                                         '+
                       ' WHERE LOT_CODEMP = :CODEMP                           '+
                       '   AND LOT_CODITE = :CODITE                           '+
                       '   AND((LOT_AUTREM IS NOT NULL)                       '+
                       '   OR (LOT_STATUS <> "N"));                           ';

  sqlTemItemRepAudit = 'SELECT                                                '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAUD                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_REPAUD = "S"                                '+
                       'LIMIT 1                                               ';

  sqlTemLoteRepAudit = 'SELECT                                                '+
                       '  LOT_CODITE,                                         '+
                       '  LOT_REPAUD                                          '+
                       'FROM                                                  '+
                       '  CADLOT                                              '+
                       'WHERE LOT_CODEMP = :CODEMP                            '+
                       '  AND LOT_REPAUD = "S"                                '+
                       '  AND LOT_STATUS <> "N"                               '+
                       'LIMIT 1                                               ';

  sqlItensAudit      = 'SELECT                                                '+
                       '  AUTOINCREM,                                         '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAUD                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_REPAUD = "S"                                '+
                       'UNION                                                 '+
                       'SELECT                                                '+
                       '  AUTOINCREM,                                         '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAUD                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_ULTAUD IS NULL                              ';

  sqlLotesAudit      = 'SELECT                                                '+
                       '  AUTOINCREM,                                         '+
                       '  LOT_NUMLOT,                                         '+
                       '  LOT_CODITE,                                         '+
                       '  LOT_REPAUD                                          '+
                       'FROM                                                  '+
                       '  CADLOT                                              '+
                       'WHERE LOT_CODEMP = :CODEMP                            '+
                       '  AND LOT_REPAUD = "S"                                '+
                       '  AND LOT_STATUS <> "N"                               '+
                       'UNION                                                 '+
                       'SELECT                                                '+
                       '  AUTOINCREM,                                         '+
                       '  LOT_NUMLOT,                                         '+
                       '  LOT_CODITE,                                         '+
                       '  LOT_REPAUD                                          '+
                       'FROM                                                  '+
                       '  CADLOT                                              '+
                       'WHERE LOT_CODEMP = :CODEMP                            '+
                       '  AND LOT_ULTAUD IS NULL                              '+
                       '  AND LOT_STATUS <> "N"                               ';

  sqlLimit           = 'LIMIT 250                                             ';

  sqlUpdUltAdtItens  = 'UPDATE ITEGER SET ITE_ULTAUD = :CURRENT_DATE,         '+
                       '  ITE_REPAUD = "N"                                    '+
                       'WHERE ITE_CODITE = :CODITE                            '+
                       '  AND ITE_CODEMP = :CODEMP                            ';

  sqlUpdUltAdtLotes  = 'UPDATE CADLOT SET LOT_ULTAUD = :CURRENT_DATE,         '+
                       '  LOT_REPAUD = "N"                                    '+
                       'WHERE LOT_CODITE = :CODITE                            '+
                       '  AND LOT_NUMLOT = :NUMLOT                            '+
                       '  AND LOT_CODEMP = :CODEMP;                           ';

  sqlPedidosOndaSep  = 'SELECT                                                 '+
                       '  F.FGO_NUMDOC                                         '+
                       'FROM                                                   '+
                       '  EXTGOR E                                             '+
                       '  INNER JOIN FATGOR F ON (F.AUTOINCREM = E.FGO_SEQFGO) '+
                       'WHERE E.FGO_SEQSEP IN (:ONDA)                          ';

  sqlPedidosOndaSepAgrupamento  = 'SELECT                                                 '+
                                  '  F.FGO_NUMDOC                                         '+
                                  'FROM                                                   '+
                                  '  EXTGOR E                                             '+
                                  '  INNER JOIN FATGOR F ON (F.AUTOINCREM = E.FGO_SEQFGO) '+
                                  'WHERE E.FGO_SEQOND IN (:ONDA)                          ';

  EngineMemory = 'ENGINE = MEMORY';
  EngineInnoDB = 'ENGINE = INNODB';
  EngineMyISAM = 'ENGINE = MYISAM';

  strTabReservaSaldoAtualizarAnalitico = 'RESERVA_SALDO_ATUALIZAR';

  sqlCreateTabelaReservaSaldoAtualizarAnalitico =
    ' CREATE TABLE IF NOT EXISTS RESERVA_SALDO_ATUALIZAR (    '+
    '   CODITE VARCHAR (07),                                  '+
    '   CODEMP VARCHAR (03),                                  '+
    '   CAMRES VARCHAR (10),                                  '+
    '   DTAINC DATETIME,                                      '+
    '   PRIMARY KEY (CODITE, CODEMP, CAMRES)                  '+
    ' ) ENGINE = INNODB DEFAULT CHARSET = LATIN1;             ';

  sqlAtualizarReservaSaldoAnalitico =
    ' REPLACE INTO RESERVA_SALDO_ATUALIZAR                    '+
    '   (CODITE, CODEMP, CAMRES, DTAINC)                      '+
    ' VALUES                                                  '+
    '   ("%s", "%s", "%s", "%s");                             ';

  sqlCreateTabelaDocumentosReserva =
                       ' CREATE TABLE %s (                                    '+
                       '   AUTINC VARCHAR(20) NOT NULL DEFAULT "",            '+
                       '   TABELA VARCHAR(06) NOT NULL DEFAULT "",            '+
                       '   CODITE VARCHAR(07) NOT NULL DEFAULT "",            '+
                       '   CODEMP VARCHAR(03) NOT NULL DEFAULT "",            '+
                       '   SALRES DECIMAL(14,4) DEFAULT 0.0000,               '+
                       '   KEY AUTINC (AUTINC),                               '+
                       '   KEY TABELA (TABELA),                               '+
                       '   KEY CODITE (CODITE),                               '+
                       '   KEY CODEMP (CODEMP)                                '+
                       ' ) %s DEFAULT CHARSET=LATIN1                   ';

  function fRetSQLPedidosOnda : String;

type
  TfncUsouBatchReprocessarSaldo = function(const AArrSQL: Array Of String): Boolean;

type
  TTipoReservaSaldoHelper = record helper for TTipoReservaSaldo
  public
    function fRetCodigo: String;
    function fRetDescricao: String;
    function fAtualiza: Boolean;
    function fAtualizaLote: Boolean;
    function fRetNomeCampo: String;
    function fNomeTabelaTemporaria: String;
  end;

  TReservaParametros = class(TInterfacedObject, IReservaParametros)
  private
    FSeqFdo: String;
    FNumeroLote: String;
    FCodigoItem: String;
    FCodEmpresa: String;
    FConverteML: Boolean;
    FEmpresaItem: String;
    FEhAuditoria: Boolean;
    FEhReprocesso: Boolean;
    FCodItemAcabado: String;
    FEmpItemAcabado: String;
    FCodigoItemBase: String;
    FEhAtualizacao: Boolean;
    FItemEhPigmento: Boolean;
    FFiltrarEmpresa: Boolean;
    FNumeroDocumento: String;
    FQtdDiaPrevisao: Integer;
    FDtaPrevisaoFinal: TDate;
    FDtaPrevisaoInicial: TDate;
    FApenasSemRequisicao: Boolean;
    FTipoReserva: TTipoReservaSaldo;
    FApenasPedidosLiberados: Boolean;
    FDesconsideraPedidosCorte: Boolean;
    FDesconsideraPedidosEnderecamento: Boolean;
    FTipoFiltroDocumento: TTipoFiltroDocumento;
    FBlnItemContratoLocacao: Boolean;
    FOndaDeSeparacao: String;
    FMotFutAConsiderar: String;
    FTabelaAudit: String;

    constructor Create;
  public
    function SeqFdo(Const Value: String): IReservaParametros; Overload;
    function CodigoItem(Const Value: String): IReservaParametros; Overload;
    function CodEmpresa(Const Value: String): IReservaParametros; Overload;
    function NumeroLote(Const Value: String): IReservaParametros; Overload;
    function EmpresaItem(Const Value: String): IReservaParametros; Overload;
    function ConverterML(Const Value: Boolean): IReservaParametros; Overload;
    function EhAuditoria(Const Value: Boolean): IReservaParametros; Overload;
    function EhReprocesso(Const Value: Boolean): IReservaParametros; Overload;
    function CodItemAcabado(Const Value: String): IReservaParametros; Overload;
    function EmpItemAcabado(Const Value: String): IReservaParametros; Overload;
    function EhAtualizacao(Const Value: Boolean): IReservaParametros; Overload;
    function NumeroDocumento(Const Value: String): IReservaParametros; Overload;
    function FiltrarEmpresa(Const Value: Boolean): IReservaParametros; Overload;
    function QtdDiaPrevisao(Const Value: Integer): IReservaParametros; Overload;
    function DtaPrevisaoFinal(Const Value: TDate): IReservaParametros; Overload;
    function DtaPrevisaoInicial(Const Value: TDate): IReservaParametros; Overload;
    function ApenasSemRequisicao(Const Value: Boolean): IReservaParametros; Overload;
    function TipoReserva(Const Value: TTipoReservaSaldo): IReservaParametros; Overload;
    function ApenasPedidosLiberados(Const Value: Boolean): IReservaParametros; Overload;
    function DesconsideraPedidosCorte(Const Value: Boolean): IReservaParametros; Overload;
    function DesconsideraPedidosEnderecamento(Const Value: Boolean): IReservaParametros; Overload;
    function TipoFiltroDocumento(Const Value: TTipoFiltroDocumento): IReservaParametros; Overload;
    function OndaDeSeparacao(Const Value: String): IReservaParametros; Overload;
    function TabelaAudit(Const Value: String): IReservaParametros; Overload;

    function CodigoItemBase: String;
    function ItemEhPigmento: Boolean;
    function SeqFdo: String; Overload;
    function CodigoItem: String; Overload;
    function CodEmpresa: String; Overload;
    function NumeroLote: String; Overload;
    function EmpresaItem: String; Overload;
    function EhAuditoria: Boolean; Overload;
    function EhReprocesso: Boolean; Overload;
    function ConverterML: Boolean; Overload;
    function CodItemAcabado: String; Overload;
    function EmpItemAcabado: String; Overload;
    function EhAtualizacao: Boolean; Overload;
    function NumeroDocumento: String; Overload;
    function FiltrarEmpresa: Boolean; Overload;
    function QtdDiaPrevisao: Integer; Overload;
    function DtaPrevisaoFinal: TDate; Overload;
    function DtaPrevisaoInicial: TDate; Overload;
    function ApenasSemRequisicao: Boolean; Overload;
    function TipoReserva: TTipoReservaSaldo; Overload;
    function ApenasPedidosLiberados: Boolean; Overload;
    function DesconsideraPedidosCorte: Boolean; Overload;
    function DesconsideraPedidosEnderecamento: Boolean; Overload;
    function TipoFiltroDocumento: TTipoFiltroDocumento; Overload;
    function OndaDeSeparacao: String; Overload;
    function TabelaAudit: String; Overload;

    function fCodEmp: String;
    function fEquals(const AInstance: IReservaParametros): Boolean;
    function ItemContratoLocacao(Const Value: Boolean): IReservaParametros; Overload;
    function ItemContratoLocacao: Boolean; Overload;

    function MotFutAConsiderar(Const Value: String): IReservaParametros; Overload;
    function MotFutAConsiderar: String; Overload;

    class function New: IReservaParametros;
  end;

  TSaldoReservado = class sealed(TInterfacedObject, ISaldoReservado)
  type
    TTipoSolicitacao = (ttsRequisicao,
                        ttsRequisicaoAtTransferencia,
                        ttsTransferencia);

    TTipoSQL = (ttsSumQuantidade, ttsChaveDocumento);
  private
    FQryCommand: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    FCommandSQL: TStringList;
    FParametros: IReservaParametros;
    FTipoSQL: TTipoSQL;
    blnCfgHabilitaEmpCar: Boolean;

    class var CFG_SLRQPE: Variant;

    constructor Create(AParametros: IReservaParametros);

    procedure pSetaParametrosSQL;
    procedure pCommandSQLReservasDeGarantia;
    procedure pCommandSQLReservasDeEstoqueExterno;
    procedure pCommandSQLReservasDeLocalizacaoCritica;
    procedure pCommandSQLReservasDePedidosEOrdemProducao;

    function fGetQtdViaSelect: Double;
    function fGetQtdViaCampos: Double;

    function fGetEmpresaCD: String;
    function fGetCommandSQL: String;
    function fGetCommandSQLCampo: String;
    function fGetEmpresaGarantia: String;
    function fGetWhereCodigoDaEmpresa(Const blnSubIte: Boolean = False): String;
    function fGetSQLSaldoReservadoGarantia: String;
    function fGetSQLSaldoReservadoExterno: String;
    function fGetSQLSaldoReservadoEstruturaVidro: String;
    function fGetSQLSaldoReservadoSubItemEstrutura: String;
    function fGetSQLSaldoReservadoLotesDigSeparacao: String;
    function fGetJoinsReservaDePedidosEOrdemProducao: String;
    function fGetWhereReservaDePedidosEOrdemProducao: String;
    function fRetornaSQLSalResLotesBloqueadosParaVenda: String;

    function fGetCamposReservaDePedidosEOrdemProducao: String;
    function fGetSQLSaldoReservadoOrdemProducaoAberto: String;

    function fDefinirNomeTemporariaDocumentosReserva: String;
    function fGerarTabelaComDocumentosReserva(ATabela: String = '';
                                              ASomenteEstrutura: Boolean = False): String;

    function fCalcularQuantidadeReservada: Double;

    function fUsaPDV: Boolean;
    function fEhGarantia: Boolean;
    function fLoteADefinir: Boolean;
    function fInformouSeqFdo: Boolean;
    function fUtilizaVendaVidro: Boolean;
    function fInformouNumeroLote: Boolean;
    function fVerQtdAbastecimento: Boolean;
    function fVerQtdReqCompraPendente: Boolean;
    function fInformouEmpresaItem: Boolean;
    function fUtilizaEntregaPeloCD: Boolean;
    function fUtilizaCamposDeSaldo: Boolean;
    function fInformouProdutoAcabado: Boolean;
    function fFiltrandoNumeroDocumento: Boolean;
    function fObterQuantidadeViaSelect: Boolean;
    function fInformouPeriodoPrevisao: Boolean;
    function fInformouQtdDiasPrevisao: Boolean;
    function fGerarSQLReservasGarantia: Boolean;
    function fGerarSQLReservasExterno: Boolean;
    function fGerarSQLReservasLocalizacaoCritica: Boolean;
    function fBaixaEstoqueDeSubProdutos: Boolean;
    function fConsiderarSaldoReservadoMWS: Boolean;
    function fGerarSQLReservasPedidoVenda: Boolean;
    function fGerarSQLReservasOrdemProducao: Boolean;
    function fTravaSaldoReservadoParaPedidoVenda: Boolean;
    function fReservarSaldoSomenteDeEnderecamento: Boolean;
    function fUsaPedidosDeBaixaEntregaFutura: Boolean;
    function fUsaAbastecimentoAutomaticoDaLojaPeloDeposito(): Boolean;
    function fEmitirOrdemDeProducaoBaixandoEstoqueSubProdutos: Boolean;
    function fConsiderarItensEntregaFuturaPorFaltaDeReserva: Boolean;
    function fControleDeGarantiaEmpresaDefinida(Const strCodEmp: String = ''): Boolean;
    function fEntradaMercadoriaComEstoqueRefugado(Const strCodEmp: String = ''): Boolean;
    function fReservarEstoqueOrdemProducaoAberto(Const blnEmpresaLogada: Boolean = True): Boolean;
    function fBaixaEstoqueDeItemEstruturaOuSubProdutos(Const AEmitirOrdem: Boolean = True): Boolean;
    function fUtilizaEmpCarregamento: Boolean;
    function getFiltroFDO_CODEMP(Const blnSubIte: Boolean = False): string;
    function getFiltroFGO_CODEMP: string;
    function getFiltroFDO_EMPITE(Const blnSubIte: Boolean = False): string;
  public
    destructor Destroy; Override;

    function fGetQuantidade: Double;
    function fGetTabelaDocumentos(ATabela: String = '';
                                  ASomenteEstrutura: Boolean = False): String;

    class function New(AParametros: IReservaParametros): ISaldoReservado;

    class function fGetSQLQtdReqCompraPendente: String;
    class function fGetSQLQtdAbastecimento: String;
    class function fGetSQLQtdAbastecimentoComEntrada: String;
    class function fGetSQLQtdSolicitacao(Const ttsOpcao: TTipoSolicitacao = ttsRequisicao): String;
    class function fGetSQLQtdSolicitacaoComEntradaNoEstoque(Const ttsOpcao: TTipoSolicitacao = ttsRequisicao): String;
    class function fGetSQLQtdSolicitacaoComReservaEnderecamento(Const ttsOpcao: TTipoSolicitacao = ttsRequisicao): String;
  end;

  TUpdateReserva = class sealed(TInterfacedObject, IUpdateReserva)
  protected
    FParametros: IReservaParametros;
    FQryUpdate: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

    constructor Create(AParametros: IReservaParametros);

    function fAtualizarTodos: Boolean;
    function fInformouNumeroLote: Boolean;
    function fAtualizarCamposPedidoVendas: Boolean;
    function fBuildSQLUpdate(Const AEhLote: Boolean = False): String;
    function fNaoExecutaUpdateParaEsseTipoDeSaldo(const trsOpc: TTipoReservaSaldo): Boolean;
  public
    destructor Destroy; Override;

    function fExecutarItem: IUpdateReserva;
    function fExecutarLote: IUpdateReserva;

    class function New(AParametros: IReservaParametros): IUpdateReserva;
  end;

  TInvokerUpdateReserva = class sealed(TInterfacedObject, IInvokerUpdateReserva)
  private
    FCommandList: TInterfaceList;

    constructor Create;
  public
    destructor Destroy; Override;

    procedure pAdd(ACommand: IUpdateReserva);
    function fExecutarItem: IInvokerUpdateReserva;
    function fExecutarLote: IInvokerUpdateReserva;

    class function New: IInvokerUpdateReserva;
  end;

  TAuditoriaReserva = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  protected
    FCommandUpdateAnalitico: TStringList;
    FParametros: IReservaParametros;
    FInvokerUpdate: IInvokerUpdateReserva;

    constructor Create(AParametros: IReservaParametros);

    function fFoiExecutadaHoje: Boolean;
    function fTemItensReprocessar(Const AEhLote: Boolean = False): Boolean;
    function fItemJafoiReprocessado(const AAutInc: string): Boolean;
    function fLoteJafoiReprocessado(const AAutInc: string): Boolean;
    procedure pVerify(AParametros: IReservaParametros);
    procedure pAuditoriaIteGer;
    procedure pAuditoriaCadLot;
  public
    destructor Destroy; Override;

    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    class function New(AParametros: IReservaParametros = nil):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

function fExecutandoRoboCADLOT: Boolean;
function fExecutandoRoboITEGER: Boolean;

procedure pCriarReservaAnalitico;

var
  fncUsouBatchReprocessarSaldo: TfncUsouBatchReprocessarSaldo=Nil;

implementation

uses
{$IFDEF LINUX}

{$ELSE }
  Vcl.Forms,
  untModulo,
  Winapi.Windows,
  untSeqTmp,
  untFuncoesSimples,
{$ENDIF LINUX}
  Data.DB,
  System.Rtti,
  System.SysUtils,
  System.StrUtils,
  System.DateUtils;

procedure pCriarReservaAnalitico;
begin
  If Not fTabelaExiste(strTabReservaSaldoAtualizarAnalitico) Then
    fExecutaSQL(sqlCreateTabelaReservaSaldoAtualizarAnalitico);
end;

function fExecutandoRoboCADLOT: Boolean;
begin
  Result := {$IFDEF LINUX}GetParamValue('-t'){$ELSE}EmptyStr{$ENDIF LINUX}.Contains(tblCadLot);
end;

function fExecutandoRoboITEGER: Boolean;
begin
  Result := {$IFDEF LINUX}GetParamValue('-t'){$ELSE}EmptyStr{$ENDIF LINUX}.Contains(tblIteGer);
end;

{ TTipoReservaSaldoHelper }

function TTipoReservaSaldoHelper.fAtualiza: Boolean;
begin
  Case Self Of
    trsTodos,
    trsPedidoVenda,
    trsExterno:
      Result := False;
  Else
    Result := True;
  End;
end;

function TTipoReservaSaldoHelper.fAtualizaLote: Boolean;
begin
  Case Self Of
    trsTransferencia:
      Result := False;
  Else
    Result := True;
  End;
end;

function TTipoReservaSaldoHelper.fNomeTabelaTemporaria: String;
begin
  Case Self Of
    trsTodos:
      Exit('TODAS');
    trsPedidoVenda:
      Exit('PEDIDO_VENDA');
    trsPedidoVendaCli:
      Exit('PEDIDO_VENDA_CLI');
    trsPedidoVendaFil:
      Exit('PEDIDO_VENDA_FIL');
    trsEnderecamento:
      Exit('ENDERECAMENTO');
    trsOrdemProducao:
      Exit('ORDEM_PRODUCAO');
    trsGarantia:
      Exit('GARANTIA');
    trsTransferencia:
      Exit('TRANSFERENCIA');
    trsExterno:
      Exit('EXTERNO');
    trsPedidoBaixaEntregaFuturaSaldoFisico:
      Exit('PEDIDO_BAIENTFUT_SOMA_SALDO');
    trsPedidoBaixaEntregaFuturaReservSaldo:
      Exit('PEDIDO_BAIENTFUT_RESE_SALDO');
  Else
    Exit('');
  End;
end;

function TTipoReservaSaldoHelper.fRetCodigo: String;
begin
  Result := fStrZero(Ord(Self), 3);
end;

function TTipoReservaSaldoHelper.fRetDescricao: String;
begin
  Case Self Of
    trsTodos: Result := 'TODOS';
    trsPedidoVenda: Result := 'PEDIDO DE VENDA';
    trsGarantia: Result := 'GARANTIA';
    trsOrdemProducao: Result := 'ORDEM DE PRODUCAO';
    trsPedidoVendaCli: Result := 'PEDIDO DE VENDA CLIENTE NAO FILIAL';
    trsPedidoVendaFil: Result := 'PEDIDO DE VENDA CLIENTE FILIAL';
    trsEnderecamento: Result := 'ENDERECAMENTO';
    trsTransferencia: Result := 'TRANSFERENCIA';
    trsExterno: Result := 'ESTOQUE EXTERNO';
    trsPedidoBaixaEntregaFuturaSaldoFisico: Result := 'PEDIDO DE BAIXA DE ENTREGA FUTURA PARA SALDO FISICO';
    trsPedidoBaixaEntregaFuturaReservSaldo: Result := 'PEDIDO DE BAIXA DE ENTREGA FUTURA PARA RESERV SALDO';
  End;
end;

function TTipoReservaSaldoHelper.fRetNomeCampo: String;
begin
  Case Self Of
    trsPedidoVendaCli:
      Exit(cpoPedidoVendaCli);
    trsPedidoVendaFil:
      Exit(cpoPedidoVendaFil);
    trsEnderecamento:
      Exit(cpoREnderecamento);
    trsOrdemProducao:
      Exit(cpoOrdemProducao);
    trsGarantia:
      Exit(cpoReservGarantia);
    trsTransferencia:
      Exit(cpoRTransferencia);
    trsExterno:
      Exit(cpoReservExterno);
    trsPedidoBaixaEntregaFuturaSaldoFisico:  
      Exit(cpoQtdPedBaiFut);
    trsPedidoBaixaEntregaFuturaReservSaldo:  
      Exit(cpoSalPedBaiFut);
  Else
    Exit('');
  End;
end;

{ TSaldoReservado }

constructor TSaldoReservado.Create(AParametros: IReservaParametros);
begin
  FTipoSQL    := TTipoSQL.ttsSumQuantidade;
  FParametros := AParametros;
  FQryCommand := fCriaQuery;
  FCommandSQL := TStringList.Create();
  blnCfgHabilitaEmpCar := fUtilizaEmpCarregamento;
end;

destructor TSaldoReservado.Destroy;
begin
  FCommandSQL.Free();
{$IFNDEF LINUX}
  FreeAndNil(FQryCommand);
{$ENDIF LINUX}
  inherited;
end;

function TSaldoReservado.fBaixaEstoqueDeItemEstruturaOuSubProdutos(Const AEmitirOrdem: Boolean = True): Boolean;
begin
  Result := (fCfgSis('BXSBIT', varString, FParametros.CodEmpresa()) = '3') Or
            ((fCfgSis('BXSBIT', varString, FParametros.CodEmpresa()) = '2') And
             IIF(AEmitirOrdem, fEmitirOrdemDeProducaoBaixandoEstoqueSubProdutos(), True));
end;

function TSaldoReservado.fBaixaEstoqueDeSubProdutos: Boolean;
begin
  Result := (fCfgSis('BXSBIT', varString, FParametros.CodEmpresa()) = '2') And
            (Not fEmitirOrdemDeProducaoBaixandoEstoqueSubProdutos());
end;

function TSaldoReservado.fEhGarantia: Boolean;
begin
  Result := fCfgSis('GARANT', varBoolean, FParametros.CodEmpresa());
end;

function TSaldoReservado.fEmitirOrdemDeProducaoBaixandoEstoqueSubProdutos: Boolean;
begin
  Result := (fCfgSis('EMOPPD', varString, FParametros.CodEmpresa()) = 'S');
end;

function TSaldoReservado.fEntradaMercadoriaComEstoqueRefugado(
  const strCodEmp: String): Boolean;
begin
  Result := fCfgSis('REFENT', varBoolean, IIF(fEmptyStr(strCodEmp), FParametros.fCodEmp(), strCodEmp));
end;

function TSaldoReservado.fFiltrandoNumeroDocumento: Boolean;
begin
  Result := (FParametros.TipoFiltroDocumento() = tfdFiltrarDocumento) And
    (Not FParametros.NumeroDocumento().IsEmpty);
end;

function TSaldoReservado.fGerarSQLReservasExterno: Boolean;
begin
  If (fCfgSis('MOVFUL', varString) = '2') Then
    Result := False
  Else
    Result := (FParametros.TipoReserva() in [trsTodos, trsExterno]);
end;

function TSaldoReservado.fGerarSQLReservasGarantia: Boolean;
begin
  Result := (FParametros.TipoReserva() in [trsTodos,
                                           trsGarantia]);
end;

function TSaldoReservado.fGerarSQLReservasLocalizacaoCritica: Boolean;
begin
  Result := (FParametros.TipoReserva() = trsLocalizacaoCritica);
end;

function TSaldoReservado.fGerarSQLReservasOrdemProducao: Boolean;
begin
  Result := (FParametros.TipoReserva() in [trsTodos,
                                           trsOrdemProducao]);
end;

function TSaldoReservado.fGerarSQLReservasPedidoVenda: Boolean;
begin
  Result := (FParametros.TipoReserva() in [trsTodos,
                                           trsPedidoVenda,
                                           trsPedidoVendaCli,
                                           trsPedidoVendaFil,
                                           trsEnderecamento,
                                           trsTransferencia,
                                           trsPedidoBaixaEntregaFuturaSaldoFisico,
                                           trsPedidoBaixaEntregaFuturaReservSaldo]);
end;

function TSaldoReservado.fGetCommandSQL: String;
var
  strCommandSQL: String;
begin
  Result := '';

  FCommandSQL.Clear();
  pCommandSQLReservasDePedidosEOrdemProducao();
  pCommandSQLReservasDeGarantia();
  pCommandSQLReservasDeEstoqueExterno();
  pCommandSQLReservasDeLocalizacaoCritica();

  strCommandSQL := AnsiReplaceStr(FCommandSQL.Text, #$D#$A, '');

  If fEmptyStr(strCommandSQL) Then
    Exit;

  If FTipoSQL = ttsSumQuantidade Then
    If Not FParametros.ItemEhPigmento() Then
      strCommandSQL := ' SELECT COALESCE(SUM(SALRES), 0) AS SALRES FROM ( ' +
                       strCommandSQL + ') A ';

  Result := strCommandSQL;
end;

function TSaldoReservado.fGetCommandSQLCampo: String;
Var
  LPrefix: String;
  LTable : String;
  LSalExt : String;

  {*** LOT_SALEXT foi descontinuado ***}
  function CampoSaldoEstoqueExterno : String;
    Const
      SQL = '(SELECT       '+
            '   LOT_SALDOS '+
            ' FROM         '+
            '   CADLOT     '+
            ' WHERE        '+
            '   LOT_NUMLOT = :NUMLOT AND '+
            '   LOT_CODITE = :CODITE AND '+
            '   LOT_CODEMP = :CODEMP AND '+
            '   LOT_FULFIL = "S") ';

  begin

    If (fInformouNumeroLote) Then
      Exit(SQL);

    Result := LPrefix + trsExterno.fRetNomeCampo();

  end;

  {*** LOT_SALEXT foi descontinuado ***}
  function CampoSaldo : String;
  begin

    If (fInformouNumeroLote) And (FParametros.TipoReserva = trsExterno) Then
      Exit('IF(LOT_FULFIL = "S", LOT_SALDOS, 0)');

    Result := LPrefix + FParametros.TipoReserva().fRetNomeCampo();

  end;

begin
  If fInformouNumeroLote() Then
  Begin
    LTable  := 'CADLOT';
    LPrefix := 'LOT_';
  End
  Else
  Begin
    LTable  := 'ITEGER';
    LPrefix := 'ITE_';
  End;

  FCommandSQL.Clear();
  FCommandSQL.Add('SELECT (');

  If (fCfgSis('MOVFUL', varString) = '2') Then
    LSalExt := ' 0.00 + '
  Else
    LSalExt := Concat('IFNULL(', CampoSaldoEstoqueExterno()                , ', 0) + ');

  Case FParametros.TipoReserva() Of
    trsTodos:
      FCommandSQL.Add(Concat('IFNULL(', LPrefix, trsPedidoBaixaEntregaFuturaReservSaldo.fRetNomeCampo(), ', 0) + ',
                             'IFNULL(', LPrefix, trsPedidoVendaCli.fRetNomeCampo(), ', 0) + ',
                             'IFNULL(', LPrefix, trsPedidoVendaFil.fRetNomeCampo(), ', 0) + ',
                             'IFNULL(', LPrefix, trsEnderecamento.fRetNomeCampo() , ', 0) + ',
                             'IFNULL(', LPrefix, trsOrdemProducao.fRetNomeCampo() , ', 0) + ',
                             LSalExt,
                             'IFNULL(', LPrefix, trsGarantia.fRetNomeCampo(),',0 )'));
    trsPedidoVenda:
      FCommandSQL.Add(Concat('IFNULL(', LPrefix, trsPedidoVendaCli.fRetNomeCampo(), ', 0) + ',
                             'IFNULL(', LPrefix, trsPedidoVendaFil.fRetNomeCampo() + ',0)'));
  Else
    Begin
      If fExecutandoPeloPortal And Not fCampoExiste(LTable, Concat(LPrefix, FParametros.TipoReserva().fRetNomeCampo())) Then
        FCommandSQL.Add(' 0.00 ')
      Else
        FCommandSQL.Add(CampoSaldo);
    End;
  End;

  FCommandSQL.Add(') AS SALRES');
  FCommandSQL.Add('FROM');
  FCommandSQL.Add(LTable);
  FCommandSQL.Add('WHERE');
  FCommandSQL.Add(Concat(LPrefix, 'CODITE = :CODITE'));
  FCommandSQL.Add(Concat('AND ', LPrefix, 'CODEMP = :CODEMP'));

  If fInformouNumeroLote() Then
    FCommandSQL.Add(Concat('AND ', LPrefix, 'NUMLOT = :NUMLOT'));

  Result := FCommandSQL.Text;
end;

function TSaldoReservado.fGetEmpresaCD: String;
begin
  Result := fCfgSis('EMP_CD', varString, FParametros.CodEmpresa());
end;

function TSaldoReservado.fGetEmpresaGarantia: String;
begin
  Result := fCfgSis('EMPGAR', varString);
end;

function TSaldoReservado.fGetJoinsReservaDePedidosEOrdemProducao: String;
begin
  Result := '';
  Result := Result + ' INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ';
  Result := Result + ' LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO  ';
  Result := Result + ' LEFT JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';

  If (FParametros.ApenasSemRequisicao()) Then
  Begin
    Result := Result + ' LEFT JOIN MOVRCD ON RCD_DOCPDV = FDO_NUMDOC ';
    Result := Result + '                 AND RCD_ESPPDV = FDO_ESPDOC ';
    Result := Result + '                 AND RCD_CODITE = FDO_CODITE ';
  End;

  If (FParametros.ItemEhPigmento()) Then
  Begin
    Result := Result + ' LEFT JOIN DUP_CADDUP ON DUP_MD5KEY = FDO_ITETIN ';
    Result := Result + ' LEFT JOIN CADITE ON ITE_CODITE = FDO_CODITE ';
  End;

  If fBaixaEstoqueDeItemEstruturaOuSubProdutos() Then
    Result := Result + ' LEFT JOIN MOVPRO ON PRO_CODPRO = FDO_ORDPRO AND PRO_CODEMP = FDO_CODEMP ';

  If fConsiderarSaldoReservadoMWS() And
     (Not fLoteADefinir()) Then
    Result := Result + ' LEFT JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM AND IFNULL(FDO_NUMLOT, "A DEFINIR") = "A DEFINIR" ';

  If fUsaAbastecimentoAutomaticoDaLojaPeloDeposito() Then
    Result := Result + ' LEFT JOIN MOVDET ABADEP ON ABADEP.AUTOINCREM = EXTDOR.FDO_INCDEP ';

end;

class function TSaldoReservado.fGetSQLQtdAbastecimento: String;
begin
  Result := '';
  Result := Result + 'COALESCE(                                               ';
  Result := Result + '  (                                                     ';
  Result := Result + '    SELECT SUM(P.PRE_QTDITE) AS QTDTRA                  ';
  Result := Result + '      FROM REQVEN R                                     ';
  Result := Result + '    INNER JOIN FATDOR F ON F.AUTOINCREM = R.SEQ_FATDOR  ';
  Result := Result + '    INNER JOIN PREPTE P ON P.PRE_NUMDOC = F.FDO_NUMDOC  ';
  Result := Result + '                       AND P.PRE_ESPDOC = F.FDO_ESPDOC  ';
  Result := Result + '                       AND P.PRE_EMPDOC = F.FDO_CODEMP  ';
  Result := Result + '                       AND P.PRE_CODITE = F.FDO_CODITE  ';
  Result := Result + '     WHERE R.SEQ_FATDOR = FATDOR.AUTOINCREM             ';
  Result := Result + '), 0)                                                   ';
end;

class function TSaldoReservado.fGetSQLQtdAbastecimentoComEntrada: String;
begin
  Result := '';
  Result := Result + 'COALESCE(                                               ';
  Result := Result + '  (                                                     ';
  Result := Result + '     SELECT                                             ';
  Result := Result + '       COALESCE(SUM(IF(IFNULL(EG.FGO_DOCEND, "") <>     ';
  Result := Result + '                    "", COALESCE(FD.FDO_QTDBAI, 0),     ';
  Result := Result + '                    IF(IFNULL(MD.DET_DTAENT, "") <>     ';
  Result := Result + '                    "", BR.BAI_QTDREQ, 0))), 0)         ';
  Result := Result + '         AS QTDREQ                                      ';
  Result := Result + '      FROM REQVEN RQ                                    ';
  Result := Result + '    INNER JOIN FATDOR F ON F.AUTOINCREM = RQ.SEQ_FATDOR ';
  Result := Result + '    INNER JOIN PREPTE P ON P.PRE_NUMDOC = F.FDO_NUMDOC  ';
  Result := Result + '                       AND P.PRE_ESPDOC = F.FDO_ESPDOC  ';
  Result := Result + '                       AND P.PRE_EMPDOC = F.FDO_CODEMP  ';
  Result := Result + '                       AND P.PRE_CODITE = F.FDO_CODITE  ';
  Result := Result + '    INNER JOIN MOVRCD R ON R.AUTOINCREM = RQ.SEQ_MOVRCD ';
  Result := Result + '    INNER JOIN PCMDET PD ON PD.AUTOINCREM = R.RCD_SEQPCD';
  Result := Result + '    INNER JOIN BAIREQ BR ON BR.BAI_AUTREQ = R.AUTOINCREM';
  Result := Result + '    INNER JOIN MOVDET MD ON MD.AUTOINCREM = BR.BAI_AUTDET';
  Result := Result + '    LEFT  JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(     ';
  Result := Result + '                 LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"), ';
  Result := Result + '                 LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"), ';
  Result := Result + '                 RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),';
  Result := Result + '                 LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),';
  Result := Result + '                 LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),';
  Result := Result + '                 TRIM(IFNULL(MD.DET_TIP_FC, " ")))      ';
  Result := Result + '    LEFT  JOIN FATDOR FD ON FD.FDO_SEQGER = EG.FGO_SEQFGO';
  Result := Result + '                        AND FD.FDO_CODITE = MD.DET_CODITE';
  Result := Result + '     WHERE RQ.SEQ_FATDOR = FATDOR.AUTOINCREM            ';
  Result := Result + '), 0)                                                   ';
end;

class function TSaldoReservado.fGetSQLQtdReqCompraPendente: String;
begin
  Result := '';
  Result := Result + '  ROUND( ';
  Result := Result + '    IFNULL(   ';
  Result := Result + '      (SELECT ';
  Result := Result + '        SUM(  ';
  Result := Result + '          RCD_QTDITE - IFNULL( ';
  Result := Result + '            (SELECT            ';
  Result := Result + '              SUM(BAI_QTDREQ) AS QTBREQ ';
  Result := Result + '            FROM                        ';
  Result := Result + '              BAIREQ BRQ                ';
  Result := Result + '              INNER JOIN MOVDET DET     ';
  Result := Result + '                ON DET.AUTOINCREM = BRQ.BAI_AUTDET   ';
  Result := Result + '            WHERE BRQ.BAI_AUTREQ = RCD.AUTOINCREM    ';
  Result := Result + '              AND IFNULL(DET.DET_DTAENT, "") <> ""), ';
  Result := Result + '            0       ';
  Result := Result + '          )         ';
  Result := Result + '        ) AS QTPREQ ';
  Result := Result + '      FROM          ';
  Result := Result + '        MOVRCD RCD  ';
  Result := Result + '        LEFT JOIN REQVEN RQV                   ';
  Result := Result + '          ON RQV.SEQ_MOVRCD = RCD.AUTOINCREM   ';
  Result := Result + '      WHERE RCD.RCD_DOCPDV = FATDOR.FDO_NUMDOC ';
  Result := Result + '        AND RCD.RCD_ESPPDV = FATDOR.FDO_ESPDOC ';
  Result := Result + '        AND RCD.RCD_EMPPDV = FATDOR.FDO_CODEMP ';
  Result := Result + '        AND RCD.RCD_CODITE = FATDOR.FDO_CODITE ';
  Result := Result + '        AND IFNULL(RCD.RCD_REQNEG, "N") = "N"  ';
  Result := Result + '        AND IFNULL(RCD.RCD_ATETRA, 0) = 0      ';
  Result := Result + '        AND IFNULL(RQV.SEQ_PREPTE, "") = ""),  ';
  Result := Result + '      0                   ';
  Result := Result + '    ) * IFNULL(           ';
  Result := Result + '      FDO_QTDITE /        ';
  Result := Result + '      (SELECT             ';
  Result := Result + '        SUM(FDO_QTDITE)   ';
  Result := Result + '      FROM                ';
  Result := Result + '        FATDOR FD         ';
  Result := Result + '      WHERE FD.FDO_SEQGER = FATDOR.FDO_SEQGER   ';
  Result := Result + '        AND FD.FDO_CODITE = FATDOR.FDO_CODITE), ';
  Result := Result + '      0 ';
  Result := Result + '    )   ';
  Result := Result + '  , 5) ';
end;

class function TSaldoReservado.fGetSQLQtdSolicitacao(const ttsOpcao: TTipoSolicitacao): String;
begin
  Result := '';
  Result := Result + ' COALESCE(                                              ';
  Result := Result + '   (                                                    ';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + ' SELECT SUM(PRQ_QTDITE) AS QTDREQ                 ';
        Result := Result + '   FROM                                           ';
        Result := Result + '     FDOABS FA                                    ';
        Result := Result + ' INNER JOIN FATDOR D ON D.AUTOINCREM = FA.ABS_SEQFDO';
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' LEFT  JOIN MOVRCD R ON R.RCD_CODIGO = PQ.PRQ_CODREQ';
        Result := Result + '                    AND R.RCD_CODEMP = PQ.PRQ_EMPREQ';
        Result := Result + '                    AND R.RCD_CODITE = PQ.PRQ_CODITE';
        Result := Result + ' LEFT JOIN REQVEN Q ON Q.SEQ_MOVRCD = R.AUTOINCREM';
      End;
    ttsTransferencia:
      Begin
        Result := Result + ' SELECT SUM(PRE_QTDITE) AS QTDTRA                 ';
        Result := Result + '   FROM                                           ';
        Result := Result + '     FDOABS FA                                    ';
        Result := Result + ' INNER JOIN PREPTE TE ON FA.ABS_SEQPTE = TE.AUTOINCREM';
      End;
    ttsRequisicaoAtTransferencia:
      Begin
        Result := Result + ' SELECT SUM(PRQ_QTDITE) AS QTDREQ                 ';
        Result := Result + '   FROM                                           ';
        Result := Result + '     FDOABS FA                                    ';
        Result := Result + ' INNER JOIN FATDOR D ON D.AUTOINCREM = FA.ABS_SEQFDO';
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN MOVRCD R  ON R.RCD_CODIGO  = PQ.PRQ_CODREQ';
        Result := Result + '                     AND R.RCD_CODEMP  = PQ.PRQ_EMPREQ';
        Result := Result + '                     AND R.RCD_CODITE  = PQ.PRQ_CODITE';
        Result := Result + ' INNER JOIN REQVEN Q  ON R.AUTOINCREM  = Q.SEQ_MOVRCD';
        Result := Result + ' INNER JOIN PREPTE TE ON Q.SEQ_PREPTE  = TE.AUTOINCREM';
      End;
  End;

  Result := Result + '    WHERE FA.ABS_SEQFDO = FATDOR.AUTOINCREM             ';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + '      AND IFNULL(R.RCD_REQNEG, "N") = "N"         ';
        Result := Result + '      AND IFNULL(R.RCD_ATETRA, 0) = 0             ';
        Result := Result + '      AND IFNULL(Q.SEQ_PREPTE, "") = ""           ';
      End;
  End;

  Result := Result + ' ), 0)';
end;

class function TSaldoReservado.fGetSQLQtdSolicitacaoComEntradaNoEstoque(
  Const ttsOpcao: TTipoSolicitacao = ttsRequisicao): String;
begin
  Result := '';
  Result := Result + ' COALESCE(                                              ';
  Result := Result + '   (SELECT                                              ';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + 'SUM(                                              ';
        Result := Result + '  IF(                                             ';
        Result := Result + '    IFNULL(MD.DET_DTAENT, "") = "",               ';
        Result := Result + '    0,                                            ';
        Result := Result + '    BR.BAI_QTDREQ                                 ';
        Result := Result + '  )                                               ';
        Result := Result + ')                                                 ';
      End;
  Else
    Begin
      Result := Result + 'COALESCE(SUM(IF(IFNULL(MD.DET_DTAENT, "") <> "",    ';
      Result := Result + ' IF(TE.PRE_QTDITE <= BP.BAI_QTDPED, TE.PRE_QTDITE,  ';
      Result := Result + '    BP.BAI_QTDPED), 0)), 0)                         ';
    End;
  End;

  Result := Result + '      AS QTDREQ                                         ';
  Result := Result + '      FROM                                              ';
  Result := Result + '        FDOABS FA                                       ';
  Result := Result + '       INNER JOIN FATDOR D ON D.AUTOINCREM   = FA.ABS_SEQFDO';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN MOVRCD R ON R.RCD_CODIGO = PQ.PRQ_CODREQ';
        Result := Result + '                    AND R.RCD_CODEMP = PQ.PRQ_EMPREQ';
        Result := Result + '                    AND R.RCD_CODITE = PQ.PRQ_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.AUTOINCREM = R.RCD_SEQPCD';
        Result := Result + ' INNER JOIN BAIREQ BR ON BR.BAI_AUTREQ = R.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BR.BAI_AUTDET';
        Result := Result + ' LEFT JOIN REQVEN Q ON Q.SEQ_MOVRCD = R.AUTOINCREM';
      End;
    ttsTransferencia:
      Begin
        Result := Result + ' INNER JOIN PREPTE TE ON FA.ABS_SEQPTE = TE.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MO ON MO.DET_NUM_PD = TE.PRE_NUMDOC';
        Result := Result + '                     AND MO.DET_ESP_PD = TE.PRE_ESPDOC';
        Result := Result + '                     AND MO.DET_EMP_PD = TE.PRE_EMPDOC';
        Result := Result + '                     AND MO.DET_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(  ';
        Result := Result + '            LPAD(IFNULL(MO.DET_NUMDOC,""),12,"0"), ';
        Result := Result + '            LPAD(IFNULL(MO.DET_ESPDOC,""),2," "),  ';
        Result := Result + '            LPAD(TRIM(IFNULL(MO.DET_CODEMP,"")),3,"0"))';
        Result := Result + '        AND PD.PCD_CODITE = TE.PRE_CODITE             ';
        Result := Result + ' INNER JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET';
      End;
    ttsRequisicaoAtTransferencia:
      Begin
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN MOVRCD R  ON R.RCD_CODIGO  = PQ.PRQ_CODREQ';
        Result := Result + '                     AND R.RCD_CODEMP  = PQ.PRQ_EMPREQ';
        Result := Result + '                     AND R.RCD_CODITE  = PQ.PRQ_CODITE';
        Result := Result + ' INNER JOIN REQVEN Q  ON R.AUTOINCREM  = Q.SEQ_MOVRCD';
        Result := Result + ' INNER JOIN PREPTE TE ON Q.SEQ_PREPTE  = TE.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MO ON MO.DET_NUM_PD = TE.PRE_NUMDOC';
        Result := Result + '                     AND MO.DET_ESP_PD = TE.PRE_ESPDOC';
        Result := Result + '                     AND MO.DET_EMP_PD = TE.PRE_EMPDOC';
        Result := Result + '                     AND MO.DET_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(  ';
        Result := Result + '            LPAD(IFNULL(MO.DET_NUMDOC,""),12,"0"), ';
        Result := Result + '            LPAD(IFNULL(MO.DET_ESPDOC,""),2," "),  ';
        Result := Result + '            LPAD(TRIM(IFNULL(MO.DET_CODEMP,"")),3,"0"))';
        Result := Result + '        AND PD.PCD_CODITE = TE.PRE_CODITE             ';
        Result := Result + ' INNER JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET';
      End;
  End;

  Result := Result + '    WHERE FA.ABS_SEQFDO = FATDOR.AUTOINCREM             ';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + '      AND R.RCD_REQNEG = "N"                      ';
        Result := Result + '      AND R.RCD_ATETRA = 0                        ';
        Result := Result + '      AND IFNULL(Q.SEQ_PREPTE, "") = ""           ';
      End;
  End;

  Result := Result + ' ), 0)';
end;

class function TSaldoReservado.fGetSQLQtdSolicitacaoComReservaEnderecamento(
  const ttsOpcao: TTipoSolicitacao): String;
begin
  Result := '';
  Result := Result + ' COALESCE(                                              ';
  Result := Result + '   (SELECT                                              ';
  Result := Result + '      SUM(COALESCE(FD.FDO_QTDITE - FD.FDO_QTDBAI, 0))   ';
  Result := Result + '      AS QTDREQ                                         ';
  Result := Result + '      FROM                                              ';
  Result := Result + '        FDOABS FA                                       ';
  Result := Result + '     INNER JOIN FATDOR D ON D.AUTOINCREM = FA.ABS_SEQFDO';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN MOVRCD R ON R.RCD_CODIGO = PQ.PRQ_CODREQ';
        Result := Result + '                    AND R.RCD_CODEMP = PQ.PRQ_EMPREQ';
        Result := Result + '                    AND R.RCD_CODITE = PQ.PRQ_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.AUTOINCREM = R.RCD_SEQPCD';
        Result := Result + ' INNER JOIN BAIREQ BR ON BR.BAI_AUTREQ = R.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BR.BAI_AUTDET';
        Result := Result + ' LEFT JOIN REQVEN Q ON Q.SEQ_MOVRCD = R.AUTOINCREM';
      End;
    ttsTransferencia:
      Begin
        Result := Result + ' INNER JOIN PREPTE TE ON FA.ABS_SEQPTE = TE.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MO ON MO.DET_NUM_PD = TE.PRE_NUMDOC';
        Result := Result + '                     AND MO.DET_ESP_PD = TE.PRE_ESPDOC';
        Result := Result + '                     AND MO.DET_EMP_PD = TE.PRE_EMPDOC';
        Result := Result + '                     AND MO.DET_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(  ';
        Result := Result + '            LPAD(IFNULL(MO.DET_NUMDOC,""),12,"0"), ';
        Result := Result + '            LPAD(IFNULL(MO.DET_ESPDOC,""),2," "),  ';
        Result := Result + '            LPAD(TRIM(IFNULL(MO.DET_CODEMP,"")),3,"0"))';
        Result := Result + '        AND PD.PCD_CODITE = TE.PRE_CODITE             ';
        Result := Result + ' INNER JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET';
      End;
    ttsRequisicaoAtTransferencia:
      Begin
        Result := Result + ' INNER JOIN PREPRQ PQ ON FA.ABS_SEQPRQ = PQ.AUTOINCREM';
        Result := Result + '                     AND PQ.PRQ_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN MOVRCD R  ON R.RCD_CODIGO  = PQ.PRQ_CODREQ';
        Result := Result + '                     AND R.RCD_CODEMP  = PQ.PRQ_EMPREQ';
        Result := Result + '                     AND R.RCD_CODITE  = PQ.PRQ_CODITE';
        Result := Result + ' INNER JOIN REQVEN Q  ON R.AUTOINCREM  = Q.SEQ_MOVRCD';
        Result := Result + ' INNER JOIN PREPTE TE ON Q.SEQ_PREPTE  = TE.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MO ON MO.DET_NUM_PD = TE.PRE_NUMDOC';
        Result := Result + '                     AND MO.DET_ESP_PD = TE.PRE_ESPDOC';
        Result := Result + '                     AND MO.DET_EMP_PD = TE.PRE_EMPDOC';
        Result := Result + '                     AND MO.DET_CODITE = D.FDO_CODITE';
        Result := Result + ' INNER JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(  ';
        Result := Result + '            LPAD(IFNULL(MO.DET_NUMDOC,""),12,"0"), ';
        Result := Result + '            LPAD(IFNULL(MO.DET_ESPDOC,""),2," "),  ';
        Result := Result + '            LPAD(TRIM(IFNULL(MO.DET_CODEMP,"")),3,"0"))';
        Result := Result + '        AND PD.PCD_CODITE = TE.PRE_CODITE             ';
        Result := Result + ' INNER JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM';
        Result := Result + ' INNER JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET';
      End;
  End;

  Result := Result + '    INNER JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(     ';
  Result := Result + '                 LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"), ';
  Result := Result + '                 LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"), ';
  Result := Result + '                 RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),';
  Result := Result + '                 LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),';
  Result := Result + '                 LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),';
  Result := Result + '                 TRIM(IFNULL(MD.DET_TIP_FC, " ")))      ';
  Result := Result + '    INNER JOIN FATDOR FD ON FD.FDO_SEQGER = EG.FGO_SEQFGO';
  Result := Result + '                        AND FD.FDO_CODITE = MD.DET_CODITE';
  Result := Result + '    WHERE FA.ABS_SEQFDO = FATDOR.AUTOINCREM             ';

  Case ttsOpcao Of
    ttsRequisicao:
      Begin
        Result := Result + '      AND R.RCD_REQNEG = "N"                      ';
        Result := Result + '      AND R.RCD_ATETRA = 0                        ';
        Result := Result + '      AND IFNULL(Q.SEQ_PREPTE, "") = ""           ';
      End;
  End;

  Result := Result + ' ), 0)';
end;

function TSaldoReservado.fRetornaSQLSalResLotesBloqueadosParaVenda: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Then
    Exit;

  If fInformouProdutoAcabado() Then
    Exit;

  If fFiltrandoNumeroDocumento Then
    Exit;

  If Not (FParametros.TipoReserva In [trsTodos, trsPedidoVenda, trsPedidoVendaCli, trsLocalizacaoCritica]) Then
    Exit;

  If Not fEmptyStr(FCommandSQL.Text) Then
    Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' CADLOT.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "CADLOT" AS TABELA, ';
    Result := Result + ' LOT_CODITE AS CODITE, ';
  End;

  Result := Result + '   SUM(LOT_SALDOS) AS SALRES ';
  Result := Result + ' FROM ';
  Result := Result + '   CADLOT ';
  Result := Result + ' LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS ';
  Result := Result + '                 AND LOT_CODEMP = LOC_CODEMP ';
  Result := Result + ' WHERE LOT_CODEMP = :CODEMP ';
  Result := Result + '   AND LOT_CODITE = :CODITE ';

  {***************************************************************************}
  { JR PAIS - DEVEMOS DESCONSIDERAR LOC_VAGFIN = "S" POIS JA EXISTE LOTDOR    }
  { RESERVANDO SALDO E DUPLICANDO A RESERVA. DUVIDAS FALAR COM RONALDO        }
  {***************************************************************************}
  Result := Result + '   AND (IFNULL(LOC_VAGFIN,"N") <> "S") ';
  {***************************************************************************}

  Result := Result + '   AND ( (IFNULL(LOC_CRITIC, "N") = "S") ';

  If fCfgSis('RESLNA') <> '2' Then
    Result := Result + '    OR (IFNULL(LOT_LOTAPR, "S") = "N") ';

  Result := Result + '  ) ';

  If fInformouNumeroLote() Then
    Result := Result + '   AND LOT_NUMLOT = :NUMLOT ';

  Result := Result + ' GROUP BY LOT_CODITE ';

  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,CADLOT.AUTOINCREM ';
end;

function TSaldoReservado.fGetSQLSaldoReservadoEstruturaVidro: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Or
    fInformouProdutoAcabado() Or
    (Not fUtilizaVendaVidro()) Then
    Exit;

  Result := Result + ' UNION ALL SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' FATDOR.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "FATDOR" AS TABELA, ';
    Result := Result + ' VID_CODITE AS CODITE, ';
  End;

  Result := Result + '   SUM(COALESCE(IF(VID_AREAM2 = 0, VID_QTDITE, VID_AREAM2) * (FDO_QTDITE - FDO_QTDBAI), 0)) SALRES ';
  Result := Result + ' FROM ';
  Result := Result + '   FATDOR ';
  Result := Result + '   JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  Result := Result + '   INNER JOIN ORCVID ON VID_SEQGER = FATDOR.AUTOINCREM ';
  Result := Result + ' WHERE  ';
  If fInformouSeqFdo() Then
    Result := Result + ' FATDOR.AUTOINCREM = :SEQFDO AND '
  Else
    Result := Result + '   VID_CODITE = :CODITE AND ';

  Result := Result + '   FDO_ESPDOC = "PD"    AND ';

  Result := Result + '   NOT EXISTS (SELECT E.FDO_SEQFDO FROM EXTDOR E WHERE E.FDO_RESERV = "N" AND E.FDO_SEQFDO = FATDOR.AUTOINCREM) AND ';

  If fInformouEmpresaItem() Then
    Result := Result + fGetWhereCodigoDaEmpresa()
  Else
    Result := Result + '   ( ' + IIF(FParametros.FiltrarEmpresa(), ' IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE) = :CODEMP ', ' FDO_CODEMP = FDO_CODEMP ');

  If fUtilizaEntregaPeloCD() And (VS_strCodEmp = fGetEmpresaCD()) Then
    Result := Result + '   OR ( FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ' ) ) '
  Else
    Result := Result + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';

  Result := Result + '   AND ';

  Case FParametros.TipoFiltroDocumento() Of
    tfdIgnorarDocumentosOnda:
      Result := Result + '   FDO_NUMDOC NOT IN (' + fRetSQLPedidosOnda + ') AND ';
    tfdIgnorarDocumento:
      Result := Result + '   FDO_NUMDOC <> :NUMDOC AND ';
    tfdFiltrarDocumento:
    Begin
      Result := Result + '   FDO_CODEMP = :CODEMP AND ';
      Result := Result + '   FDO_NUMDOC = :NUMDOC AND ';
    End;
  End;

  Case FParametros.TipoReserva() Of
    trsPedidoVendaCli:
      Result := Result + ' FGO_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    trsPedidoVendaFil:
      Result := Result + ' FGO_CODCLI IN (' + VS_strCliFil + ') AND ';
  End;

  Result := Result + '   FDO_JAFATU = 0 ';

  Result := Result + '  AND IFNULL(FGO_LOC_PD,"N") <> "S" ';

  Result := Result + ' GROUP BY ';
  Result := Result + '   VID_CODITE ';

  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,FATDOR.AUTOINCREM ';

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTGOR', 'FGO_LOC_PD', True) Then
      Result := ReplaceStr(Result, 'FGO_LOC_PD', ' /* FGO_LOC_PD */ "N" ');

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTDOR', 'FDO_RESERV', True) Then
      Result := ReplaceStr(Result, 'E.FDO_RESERV', ' /* E.FDO_RESERV */ "S" ');
end;

function TSaldoReservado.fGetSQLSaldoReservadoExterno: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Then
    Exit;

  If (FParametros.TipoReserva() = trsTodos) Then
    Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' ESTEXT.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "ESTEXT" AS TABELA, ';
    Result := Result + ' ESTEXT.EXT_CODITE AS CODITE, ';
  End;

  Result := Result + '  SUM(EXT_SALDO_) AS SALRES ';
  Result := Result + '  FROM ESTEXT ';

  If fInformouNumeroLote() Then
  Begin
    Result := Result + '    INNER JOIN CADLOT ';
    Result := Result + '       ON CADLOT.LOT_CODEXT = ESTEXT.EXT_CODEEE ';
    Result := Result + '      AND CADLOT.LOT_CODEMP = ESTEXT.EXT_CODEMP ';
    Result := Result + '      AND CADLOT.LOT_CODITE = ESTEXT.EXT_CODITE ';
    Result := Result + '      AND CADLOT.LOT_FULFIL = "S"        ';
  End;

  Result := Result + '  WHERE ';
  If FParametros.FiltrarEmpresa() Then
    Result := Result + '  ESTEXT.EXT_CODEMP = :CODEMP AND ';

  Result := Result + '   ESTEXT.EXT_CODITE = :CODITE ';

  If fInformouNumeroLote() Then
    Result := Result + ' AND CADLOT.LOT_NUMLOT = :NUMLOT ';

  Result := Result + ' GROUP BY ';
  Result := Result + '   ESTEXT.EXT_CODITE ';

  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,ESTEXT.AUTOINCREM '
end;

function TSaldoReservado.fGetSQLSaldoReservadoGarantia: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Then
    Exit;

  If (FParametros.TipoReserva() = trsTodos) Then
    Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' D.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "MOVGAD" AS TABELA, ';
    Result := Result + ' GAD_CODITE AS CODITE, ';
  End;

  If (fEntradaMercadoriaComEstoqueRefugado()) Or
     (fControleDeGarantiaEmpresaDefinida(FParametros.fCodEmp()) And
      fEntradaMercadoriaComEstoqueRefugado(fGetEmpresaGarantia())) Then
  Begin
    Result := Result + '  SUM( (IFNULL(GAD_QTDREQ,0) - IF(G.GAG_GARIND ="S", IFNULL(GAD_QTDRET,0) + IFNULL(GAD_QTDREF, 0), 0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) ) ';
    Result := Result + '         - GREATEST( IFNULL(GAD_QTDRET,0) - ';
	Result := Result + '        		          IFNULL( (SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM),0 ) ';
    Result := Result + '                    , 0) ';
    Result := Result + '       + (IFNULL(GAD_QTDREF,0) - IFNULL(GAD_REFBAI,0)) +           ';
    Result := Result + '       IF( ' + IfThen(FParametros.FiltrarEmpresa(),'(SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = S.SEQ_FDOREF AND FDO_JAFATU = 0 ) = :CODEMP AND ', '');
    Result := Result + '          ((SELECT PCD_BAIXAD FROM PCMDET WHERE AUTOINCREM = SEQ_PCDREF) = 1), IFNULL(GAD_QTDREF,0),0) ) SALRES  ';
  End
  Else
    Result := Result + ' SUM( COALESCE(GAD_QTDREQ,0) - IF(G.GAG_GARIND ="S", IFNULL(GAD_QTDRET,0) + IFNULL(GAD_QTDREF, 0), 0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) ) SALRES ';

  Result := Result + '  FROM MOVGAG G INNER JOIN MOVGAD D ON G.AUTOINCREM = D.GAD_SEQGAG ';
  Result := Result + '  LEFT JOIN SEQGAR S ON S.SEQ_MOVGAD = D.AUTOINCREM ';

  If fControleDeGarantiaEmpresaDefinida(FParametros.fCodEmp()) Then
  Begin
    Result := Result + 'WHERE ';
    If FParametros.FiltrarEmpresa() Then
    Begin
      Result := Result + '  (((IFNULL(S.SEQ_PCMDET,"") = "") AND (GAG_CODEMP = :CODEMP)) ';
      Result := Result + '   OR ';
      Result := Result + '   ((SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = S.SEQ_FATDOR) = :CODEMP) ';
      Result := Result + '   OR ((SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = S.SEQ_FDOREF AND FDO_JAFATU = 0 ) = :CODEMP)) AND ';
    End
    Else
    Begin
      Result := Result + '  (((IFNULL(S.SEQ_PCMDET,"") = "") ) ';
      Result := Result + '   OR ';
      Result := Result + '   ((SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = S.SEQ_FATDOR) IS NOT NULL ) ';
      Result := Result + '   OR ((SELECT FDO_CODEMP FROM FATDOR WHERE AUTOINCREM = S.SEQ_FDOREF AND FDO_JAFATU = 0 ) IS NOT NULL)) AND ';
    End;
  End
  Else
  Begin
    Result := Result + 'WHERE ';
    If FParametros.FiltrarEmpresa() Then
      Result := Result + '  GAG_CODEMP = :CODEMP AND ';
  End;

  Result := Result + '   GAD_CODITE = :CODITE ';

  If fInformouNumeroLote() Then
    Result := Result + ' AND GAD_NUMLOT = :NUMLOT ';

  If Not ((fEntradaMercadoriaComEstoqueRefugado()) Or
     (fControleDeGarantiaEmpresaDefinida(FParametros.fCodEmp()) And
      fEntradaMercadoriaComEstoqueRefugado(fGetEmpresaGarantia()))) Then
  Begin
    Result := Result + ' AND  IFNULL(GAD_QTDREQ,0) - IFNULL((SELECT SUM(GAE_QTDENV) FROM MOVGAE WHERE GAE_SEQGAD = D.AUTOINCREM ),0) > 0 ';
    //Result := Result + ' AND    IFNULL(GAD_NUMENV,"") = "" ';
    //Result := Result + ' AND    IFNULL(GAD_DTAENV,"") = "" ';
  End;

  Result := Result + ' GROUP BY GAD_CODITE ';

  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,D.AUTOINCREM ';

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('MOVGAG', 'GAG_GARIND', True) Then
      Result := ReplaceStr(Result, 'G.GAG_GARIND', ' /* G.GAG_GARIND */ "N" ');
end;

function TSaldoReservado.fGetSQLSaldoReservadoLotesDigSeparacao: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Or fInformouProdutoAcabado() Or
    (Not fUsaRotinaWMS()) Or (Not fInformouNumeroLote()) Then
    Exit;

  If (FParametros.TipoReserva() In [trsPedidoBaixaEntregaFuturaSaldoFisico, trsPedidoBaixaEntregaFuturaReservSaldo]) Then
    Exit;

  Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' FATDOR.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "FATDOR" AS TABELA, ';
    Result := Result + ' FDO_CODITE AS CODITE, ';
  End;

  Result := Result + '   SUM(COALESCE(LDO_QTDITE,0)) SALRES ';
  Result := Result + ' FROM ';
  Result := Result + '   FATDOR ';
  Result := Result + '   INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
  Result := Result + '   LEFT  JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
  Result := Result + '   INNER JOIN LOTDOR ON LDO_SEQFDO = FATDOR.AUTOINCREM AND IFNULL(FDO_NUMLOT, "A DEFINIR") = "A DEFINIR" ';
  Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  Result := Result + ' WHERE  ';
  If fInformouSeqFdo() Then
    Result := Result + ' FATDOR.AUTOINCREM = :SEQFDO AND '
  Else
    Result := Result + '   FDO_CODITE = :CODITE AND ';

  Result := Result + '   FDO_ESPDOC = "PD"    AND ';
  Result := Result + '   FDO_JAFATU = 0       AND ';

  Result := Result + '   NOT EXISTS (SELECT E.FDO_SEQFDO FROM EXTDOR E WHERE E.FDO_RESERV = "N" AND E.FDO_SEQFDO = FATDOR.AUTOINCREM) AND ';

  If (fCfgSis('BAITMQ') = 'S') Then
  Begin
    Result := Result+ '   IFNULL((SELECT TD.FDO_BAIXAD FROM TINDOR TD ';
    Result := Result + '               WHERE TD.FDO_NUMDOC = FATDOR.FDO_NUMDOC    ';
    Result := Result + '                 AND TD.FDO_ESPDOC = FATDOR.FDO_ESPDOC    ';
    Result := Result + '                 AND TD.FDO_CODEMP = FATDOR.FDO_CODEMP    ';
    Result := Result + '                 AND TD.FDO_CODCLI = FATDOR.FDO_CODCLI    ';
    Result := Result + '                 AND TD.FDO_CODITE = FATDOR.FDO_CODITE    ';
    Result := Result + '                 AND TD.FDO_CODACA = FATDOR.FDO_CODACA    ';
    Result := Result + '                 AND TD.FDO_EMPACA = FATDOR.FDO_EMPACA    ';
    Result := Result + '                 LIMIT 1 ),0) = 0 AND ';
  End
  Else Begin
    Result := Result + '     IF(FGO_OPRFLJ = "S", IF(FGO_OPRFLJ = "S" AND (IFNULL((SELECT                                  ';
    Result := Result + '                                                             TD.FDO_BAIXAD                         ';
    Result := Result + '                                                           FROM                                    ';
    Result := Result + '                                                             TINDOR TD                             ';
    Result := Result + '                                                           WHERE                                   ';
    Result := Result + '                                                             TD.FDO_NUMDOC = FATDOR.FDO_NUMDOC AND ';
    Result := Result + '                                                             TD.FDO_ESPDOC = FATDOR.FDO_ESPDOC AND ';
    Result := Result + '                                                             TD.FDO_CODEMP = FATDOR.FDO_CODEMP AND ';
    Result := Result + '                                                             TD.FDO_CODCLI = FATDOR.FDO_CODCLI AND ';
    Result := Result + '                                                             TD.FDO_CODITE = FATDOR.FDO_CODITE AND ';
    Result := Result + '                                                             TD.FDO_CODACA = FATDOR.FDO_CODACA AND ';
    Result := Result + '                                                             TD.FDO_EMPACA = FATDOR.FDO_EMPACA     ';
    Result := Result + '                                                           LIMIT 1), 0) = 0), 1, 0), 1) = 1 AND    ';
  End;

  Case FParametros.TipoReserva() Of
    trsPedidoVendaCli:
      Result := Result + ' FGO_CODCLI NOT IN (' + VS_strCliFil + ') AND ';
    trsPedidoVendaFil:
      Result := Result + ' FGO_CODCLI IN (' + VS_strCliFil + ') AND ';
  End;

  If fInformouEmpresaItem() Then
    Result := Result + fGetWhereCodigoDaEmpresa()
  Else
    Result := Result + '   ( ' + IIF(FParametros.FiltrarEmpresa(), ' IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE) = :CODEMP ', ' FDO_CODEMP = FDO_CODEMP ');

  If fUtilizaEntregaPeloCD() And (VS_strCodEmp = fGetEmpresaCD()) Then
    Result := Result + '   OR ( FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ' ) ) AND '
  Else
    Result := Result + '   AND IFNULL(FGO_ENT_CD, "N") = "N") AND ';

  If (fReservarSaldoSomenteDeEnderecamento) Then
    Result := Result + ' IFNULL(FGO_DOCEND, "") <> "" AND IFNULL(FGO_BKPEND, "") = "" AND '
  Else If (FParametros.DesconsideraPedidosEnderecamento() Or FParametros.EhAtualizacao()) Then
    Result := Result + ' IFNULL(FGO_DOCEND, "") = "" AND ';

  Case FParametros.TipoFiltroDocumento() Of
    tfdIgnorarDocumentosOnda:
      Result := Result + '   FDO_NUMDOC NOT IN (' + fRetSQLPedidosOnda + ') AND ';
    tfdIgnorarDocumento:
      Result := Result + '   FDO_NUMDOC <> :NUMDOC AND ';
    tfdFiltrarDocumento:
    Begin
      Result := Result + '   FDO_CODEMP = :CODEMP AND ';
      Result := Result + '   FDO_NUMDOC = :NUMDOC AND ';
    End;
  End;

  Result := Result + '   LDO_NUMLOT = :NUMLOT ';

  Result := Result + ' GROUP BY ';
  Result := Result + '   FDO_CODITE ';
  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,FATDOR.AUTOINCREM ';

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTDOR', 'FDO_RESERV', True) Then
      Result := ReplaceStr(Result, 'E.FDO_RESERV', ' /* E.FDO_RESERV */ "S" ');
end;

function TSaldoReservado.fGetSQLSaldoReservadoOrdemProducaoAberto: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Or
    (Not fReservarEstoqueOrdemProducaoAberto()) Then
    Exit;

  Result := Result + ' UNION ALL ';

  Result := Result + ' SELECT ';

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := Result + ' DETPRO.AUTOINCREM AS AUTINC, ';
    Result := Result + ' "DETPRO" AS TABELA, ';
    Result := Result + ' DOP_ITESUB AS CODITE, ';
  End;

  Result := Result + '    SUM((IFNULL(PRO_QTDAPR, 0) - IFNULL(PRO_QTDPRO, 0)) * (IFNULL(DOP_QTDITE, 0) - (IFNULL(DOP_QTDBAI, 0)))) AS QTDRES ';
  Result := Result + ' FROM DETPRO                                           ';
  Result := Result + '   INNER JOIN MOVPRO ON MOVPRO.AUTOINCREM = DOP_SEQGER ';
  Result := Result + ' WHERE PRO_DTABAI IS NULL                              ';
  Result := Result + '   AND DOP_ITESUB = :CODITE                            ';

  If FParametros.FiltrarEmpresa() Then
    Result := Result + '   AND PRO_CODEMP = :CODEMP                          ';

  If fInformouNumeroLote() Then
    Result := Result + '   AND DOP_NUMLOT = :NUMLOT                          ';

  Result := Result + ' GROUP BY DOP_ITESUB                                   ';

  If FTipoSQL = ttsChaveDocumento Then
    Result := Result + ' ,DETPRO.AUTOINCREM ';
end;

function TSaldoReservado.fGetSQLSaldoReservadoSubItemEstrutura: String;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Or
    ((Not fBaixaEstoqueDeItemEstruturaOuSubProdutos(False)) And (Not blnCfgHabilitaEmpCar)) Then
    Exit;

  If fBaixaEstoqueDeSubProdutos() Or blnCfgHabilitaEmpCar Then
  Begin
    Result := Result + '  UNION ALL  SELECT ';

    If FTipoSQL = ttsChaveDocumento Then
    Begin
      Result := Result + ' FATDOR.AUTOINCREM AS AUTINC, ';
      Result := Result + ' "FATDOR" AS TABELA, ';
      Result := Result + ' DMT_ITESUB AS CODITE, ';
    End;

    Result := Result + '   SUM(COALESCE((FDO_QTDITE - IFNULL(FDO_QTDBAI, 0)), 0) * DMT_QTDITE) SALRES ';
    Result := Result + ' FROM ';
    Result := Result + '   FATDOR ';
    Result := Result + '   JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
    Result := Result + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';
    Result := Result + '   INNER JOIN GERMAT ON GMT_CODITE = FDO_CODITE ';
    Result := Result + '   INNER JOIN DETMAT ON DMT_SEQGER = GERMAT.AUTOINCREM ';
    Result := Result + '   INNER JOIN CADITE ON ITE_CODITE = DMT_ITESUB ';
    Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
    Result := Result + ' WHERE  ';
    Result := Result + '   DMT_ITESUB = :CODITE AND ';
    Result := Result + '   FDO_ESPDOC = "PD"    AND ';

    If fInformouEmpresaItem() Then
      Result := Result + fGetWhereCodigoDaEmpresa(True)
    Else
      Result := Result + '   ( ' + IIF(FParametros.FiltrarEmpresa(), ' IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE) = :CODEMP ', ' FDO_CODEMP = FDO_CODEMP ');

    If fUtilizaEntregaPeloCD() And (VS_strCodEmp = fGetEmpresaCD()) Then
      Result := Result + '   OR ( FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ' ) ) '
    Else
      Result := Result + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';

    Result := Result + '   AND ';

    Result := Result + '   NOT EXISTS (SELECT E.FDO_SEQFDO FROM EXTDOR E WHERE E.FDO_RESERV = "N" AND E.FDO_SEQFDO = FATDOR.AUTOINCREM) AND ';

    Case FParametros.TipoFiltroDocumento() Of
      tfdIgnorarDocumentosOnda:
        Result := Result + '   FDO_NUMDOC NOT IN (' + fRetSQLPedidosOnda + ') AND ';
      tfdIgnorarDocumento:
        Result := Result + '   FDO_NUMDOC <> :NUMDOC AND ';
      tfdFiltrarDocumento:
      Begin
        Result := Result + '   FDO_CODEMP = :CODEMP AND ';
        Result := Result + '   FDO_NUMDOC = :NUMDOC AND ';
      End;
    End;

    Result := Result + '   FDO_JAFATU = 0 AND ';
    Result := Result + '   FDO_BXSBIT = "S" ';

    If fInformouNumeroLote() Then
      Result := Result + ' AND FDO_NUMLOT = :NUMLOT ';

    Result := Result + ' GROUP BY ';
    Result := Result + '   DMT_ITESUB ';
    If FTipoSQL = ttsChaveDocumento Then
      Result := Result + ' ,FATDOR.AUTOINCREM ';
  End
  Else
  Begin
    If (Not fReservarEstoqueOrdemProducaoAberto()) Then
    Begin
      Result := Result + ' UNION ALL SELECT ';

      If FTipoSQL = ttsChaveDocumento Then
      Begin
        Result := Result + ' FATDOR.AUTOINCREM AS AUTINC, ';
        Result := Result + ' "FATDOR" AS TABELA, ';
        Result := Result + ' DOP_ITESUB AS CODITE, ';
      End;

      Result := Result + '   SUM(COALESCE((PRO_QTDAPR - IFNULL(FDO_QTDBAI, 0)) * DOP_QTDITE,0)) SALRES ';
      Result := Result + ' FROM ';
      Result := Result + '   FATDOR ';
      Result := Result + '   JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER ';
      Result := Result + '   LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

      Result := Result + '   INNER JOIN MOVPRO ON PRO_CODPRO = FDO_ORDPRO AND PRO_CODEMP = FDO_CODEMP ';
      Result := Result + '   INNER JOIN DETPRO ON DOP_SEQGER = MOVPRO.AUTOINCREM ';
      Result := Result + '   LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';

      Result := Result + ' WHERE  ';

      Result := Result + '   DOP_ITESUB = :CODITE AND ';
      Result := Result + '   FDO_ESPDOC = "PD"    AND ';

      Result := Result + '   NOT EXISTS (SELECT E.FDO_SEQFDO FROM EXTDOR E WHERE E.FDO_RESERV = "N" AND E.FDO_SEQFDO = FATDOR.AUTOINCREM) AND ';

      If fInformouNumeroLote() Then
        Result := Result + ' DOP_NUMLOT = :NUMLOT AND ';

      If fInformouEmpresaItem() Then
        Result := Result + fGetWhereCodigoDaEmpresa()
      Else
        Result := Result + '   ( ' + IIF(FParametros.FiltrarEmpresa(), ' IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE) = :CODEMP ', ' FDO_CODEMP = FDO_CODEMP ');

      If fUtilizaEntregaPeloCD() And (VS_strCodEmp = fGetEmpresaCD()) Then
        Result := Result + '   OR ( FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ' ) ) '
      Else
        Result := Result + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';

      Result := Result + '   AND ';

      Case FParametros.TipoFiltroDocumento() Of
      tfdIgnorarDocumentosOnda:
        Result := Result + '   FDO_NUMDOC NOT IN (' + fRetSQLPedidosOnda + ') AND ';
      tfdIgnorarDocumento:
        Result := Result + '   FDO_NUMDOC <> :NUMDOC AND ';
      tfdFiltrarDocumento:
        Begin
          Result := Result + '   FDO_CODEMP = :CODEMP AND ';
          Result := Result + '   FDO_NUMDOC = :NUMDOC AND ';
        End;
      End;

      Result := Result + '   FDO_JAFATU = 0 AND ';
      Result := Result + '   PRO_DTABAI IS NULL ';

      Result := Result + ' GROUP BY ';
      Result := Result + '   DOP_ITESUB ';
      If FTipoSQL = ttsChaveDocumento Then
        Result := Result + ' ,FATDOR.AUTOINCREM ';
    End;
  End;

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTDOR', 'FDO_RESERV', True) Then
      Result := ReplaceStr(Result, 'E.FDO_RESERV', ' /* E.FDO_RESERV */ "S" ');
end;

function TSaldoReservado.fGetTabelaDocumentos(ATabela: String = '';
  ASomenteEstrutura: Boolean = False): String;
begin
  Result := fGerarTabelaComDocumentosReserva(ATabela, ASomenteEstrutura);
end;

function TSaldoReservado.fGetQtdViaCampos: Double;
var
  fltCnvMl: Double;
begin
  Result := 0;

  If (Not fUsaPDV()) And (Not fEhGarantia()) Then
    Exit;

  Try
    Try
      FQryCommand.Close();
      FQryCommand.SQL.Clear();
      FQryCommand.SQL.Add(fGetCommandSQLCampo());
      FQryCommand.ParamByName('CODITE').AsString := FParametros.CodigoItem();
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.fCodEmp();
      If fInformouNumeroLote() Then
        FQryCommand.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();
      FQryCommand.Open();

      If Not FParametros.ConverterML() Then
        Result := FQryCommand.FieldByName('SALRES').AsFloat
      Else
      Begin
        fltCnvMl := fCampoTabela('ITE_CNV_ML','CADITE',['ITE_CODITE'],[FParametros.CodigoItem()]);
        fltCnvMl := IIF(fltCnvMl <= 0, 1, fltCnvMl);
        Result   := FQryCommand.FieldByName('SALRES').AsFloat * fltCnvMl;
      End;
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[fGetQtdViaCampos] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
    End;
  Finally
    FQryCommand.Close();
    FQryCommand.SQL.Clear();
  End;
end;

function TSaldoReservado.fDefinirNomeTemporariaDocumentosReserva: String;
begin
  Repeat
    Result := fTiraEspacos(Trim(Format(sNomeTabelaDocumentosReserva, [FParametros.TipoReserva.fNomeTabelaTemporaria, Trim(strLoginUsuarioLogado), FParametros.CodigoItem(), fRetSeqTmp])));
  Until (Not fTabelaExiste(Result));
end;

function TSaldoReservado.fCalcularQuantidadeReservada: Double;
Var
  intContador: Integer;
  fltQtdBas: Double;
  fltCnvMl: Double;
begin
  Result := 0.000;
  If FParametros.ItemEhPigmento() Then
  Begin
    If (Not FQryCommand.FieldBYName('DUP_BASE01').IsNull) Then
    Begin
      For intContador := 1 To 15 Do
      Begin
        If (FQryCommand.FieldByName('DUP_BASE' + fStrZero(intContador, 2)).AsString = FParametros.CodigoItemBase()) Then
        Begin
          If (FQryCommand.FieldByName('FDO_TIPPRE').AsString = 'C') Then
            fltQtdBas := FQryCommand.FieldByName('DUP_QTDC' + fStrZero(intContador, 2)).AsFloat
          Else
            fltQtdBas := FQryCommand.FieldByName('DUP_QTDD' + fStrZero(intContador, 2)).AsFloat;

          Result := Result + (fltQtdBas * FQryCommand.FieldByName('FDO_VOLPRO').AsFloat * 1000) /
                              FQryCommand.FieldByName('DUP_LITRAG').AsFloat * FQryCommand.FieldByName('FDO_QTDITE').AsFloat;
        End;
      End;
    End
    Else
      Result := Result + (FQryCommand.FieldByName('FDO_QTDITE').AsFloat * FQryCommand.FieldByName('ITE_CNV_ML').AsFloat);

    If Not FParametros.ConverterML() Then
      Result := fGetQuantidadeFatorAxalta(Result, FParametros.CodigoItem());
  End
  Else
  Begin
    If Not FParametros.ConverterML() Then
      Result := FQryCommand.FieldByName('SALRES').AsFloat
    Else
    Begin
      fltCnvMl := fCampoTabela('ITE_CNV_ML','CADITE',['ITE_CODITE'],[FParametros.CodigoItem()]);
      fltCnvMl := IIF(fltCnvMl <= 0, 1, fltCnvMl);
      Result   := FQryCommand.FieldByName('SALRES').AsFloat * fltCnvMl;
    End;
  End
end;

function TSaldoReservado.fGerarTabelaComDocumentosReserva(ATabela: String = '';
  ASomenteEstrutura: Boolean = False): String;
var
  strCommandSQL: String;
  strCodigoItem: String;
  strCodigoEmpr: String;
  strQuantidade: String;
begin
  If Not ATabela.IsEmpty Then
    Result := ATabela
  Else
    Result := fDefinirNomeTemporariaDocumentosReserva;

  If ATabela.IsEmpty Then
    If Not fExecutaSQL(Format(sqlCreateTabelaDocumentosReserva, [Result, EngineMemory])) Then
      Raise Exception.Create('Ocorreu um erro ao tentar criar a tabela ' + Result);

  If ASomenteEstrutura Then
    Exit;

  If (Not fUsaPDV()) And (Not fEhGarantia()) Then
    Exit;

  FTipoSQL := TTipoSQL.ttsChaveDocumento;

  Try
    Try
      FQryCommand.Close();
      FQryCommand.SQL.Clear();
      strCommandSQL := fGetCommandSQL;

      If fEmptyStr(strCommandSQL) Then
        Exit;

      FQryCommand.SQL.Add(strCommandSQL);
      pSetaParametrosSQL();
      FQryCommand.Open();

      strCommandSQL := '';

      FQryCommand.First;
      While (Not FQryCommand.Eof) Do
      Begin
        If FParametros.ItemEhPigmento() Then
          strCodigoItem := FQryCommand.FieldByName('CODCOL').AsString
        Else
          strCodigoItem := FQryCommand.FieldByName('CODITE').AsString;

        If fInformouEmpresaItem() Then
          strCodigoEmpr := FParametros.EmpresaItem()
        Else
          strCodigoEmpr := FParametros.CodEmpresa();

        strQuantidade := fCalcularQuantidadeReservada.ToString.Replace('.','').Replace(',','.');

        strCommandSQL := strCommandSQL +
          ' INSERT INTO ' + Result + ' ( ' +
          '   AUTINC, ' +
          '   TABELA, ' +
          '   CODITE, ' +
          '   CODEMP, ' +
          '   SALRES) ' +
          ' VALUES (  ' +
          '   ' + FQryCommand.FieldByName('AUTINC').AsString.QuotedString + ', ' +
          '   ' + FQryCommand.FieldByName('TABELA').AsString.QuotedString + ', ' +
          '   ' + strCodigoItem.QuotedString + ', ' +
          '   ' + strCodigoEmpr.QuotedString + ', ' +
          '   ' + strQuantidade + ' ); ';

        FQryCommand.Next;
      End;

      If strCommandSQL <> '' Then
        fExecutaSQL(strCommandSQL);

    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[fGerarTabelaComDocumentosReserva] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
    End;
  Finally
    FQryCommand.Close();
    FQryCommand.SQL.Clear();
  End;
end;

function TSaldoReservado.fGetQtdViaSelect: Double;
var
  strCommandSQL: String;
  LInfoReserva: String;
begin
  Result := 0;

  If (Not fUsaPDV()) And (Not fEhGarantia()) Then
    Exit;

  LInfoReserva := FParametros.TipoReserva().fRetDescricao + '(' + FParametros.TipoReserva().fRetNomeCampo + ')';

  Try

    Try
      FQryCommand.Close();
      FQryCommand.SQL.Clear();
      strCommandSQL := fGetCommandSQL;

      If fEmptyStr(strCommandSQL) Then
        Exit;

     {$IFNDEF LINUX}
      strCommandSQL := '/* Tipo de Reserva: ' + LInfoReserva + '*/' + strCommandSQL;
     {$ENDIF LINUX}

      FQryCommand.SQL.Add(strCommandSQL);
      pSetaParametrosSQL();
      FQryCommand.Open();

      While (Not FQryCommand.Eof) Do
      Begin
        Result := Result + fCalcularQuantidadeReservada;
        FQryCommand.Next();
      End;

    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[fGetQtdViaSelect] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
    End;

  Finally
    FQryCommand.Close();
    FQryCommand.SQL.Clear();
  End;
end;

function TSaldoReservado.fGetQuantidade: Double;
begin
  If fObterQuantidadeViaSelect() Then
    Result := fGetQtdViaSelect()
  Else
    Result := fGetQtdViaCampos();
end;

function TSaldoReservado.getFiltroFDO_CODEMP(Const blnSubIte: Boolean = False): string;
begin
  If blnCfgHabilitaEmpCar Then
  Begin
    If blnSubIte Then
      Result := 'IFNULL(IF(FDO_ENTRET = "E", ITE_EMPCAR, NULL), FDO_CODEMP)'
    Else
      Result := 'IFNULL(FDO_EMPCAR, FDO_CODEMP)'
  End
  Else
    Result := 'FDO_CODEMP';
end;

function TSaldoReservado.getFiltroFGO_CODEMP: string;
begin
  If blnCfgHabilitaEmpCar Then
    Result := 'IFNULL(FDO_EMPCAR, FGO_CODEMP)'
  Else
    Result := 'FGO_CODEMP';
end;

function TSaldoReservado.getFiltroFDO_EMPITE(Const blnSubIte: Boolean = False): string;
begin
  If blnCfgHabilitaEmpCar Then
  Begin
    If blnSubIte Then
      Result := 'IFNULL(IF(FDO_ENTRET = "E", ITE_EMPCAR, NULL), FDO_EMPITE)'
    Else
      Result := 'IFNULL(FDO_EMPCAR, FDO_EMPITE)'
  End
  Else
    Result := 'FDO_EMPITE';
end;

function TSaldoReservado.fGetWhereCodigoDaEmpresa(Const blnSubIte: Boolean = False): String;
begin
  Result := '';
  Result := Result + '   ((( ((IF(IFNULL(FGO_EMPFOR, "") = "", IF(IFNULL(FGO_EMP_TE, "") = "", '+ getFiltroFDO_CODEMP(blnSubIte) +', FGO_EMP_TE), FGO_EMPFOR) = :CODEMP) AND (IFNULL(FDO_EMPITE, "") = "")) OR ';
  Result := Result + '       ( IF (FGO_ENT_CD = "S" , FGO_EMP_CD, IF(IFNULL(FGO_EMPFOR, "") = "", IF(IFNULL(FGO_EMP_TE, "") = "", '+ getFiltroFDO_EMPITE(blnSubIte) +', FGO_EMP_TE), FGO_EMPFOR)) = :EMPITE) ) ';
  Result := Result + '   OR ( FGO_OPRFLJ = "S" AND FDO_EMPPRD = :CODEMP ) AND (IFNULL(FGO_ENT_CD, "N") = "N") )';
end;

function TSaldoReservado.fGetWhereReservaDePedidosEOrdemProducao: String;
  Var
    strAux: String;
  Const
    COLETA = '((FDO_VLRCON = 0) AND (FGO_COLETA = "S"))';
begin
  Result := '';
  If FParametros.ItemEhPigmento() Then
  Begin
    Result := Result + ' COALESCE(DUP_BASE01, ITE_CNV_ML) IS NOT NULL AND ';

    If fInformouSeqFdo() Then
      Result := Result + ' IF(DUP_BASE01 IS NULL, FATDOR.AUTOINCREM = :SEQFDO, TRUE) AND'
    Else
      Result := Result + ' IF(DUP_BASE01 IS NULL, FDO_CODITE = :CODITE, TRUE) AND';
  End
  Else
  Begin
    If fInformouProdutoAcabado() Then
    Begin
      Result := Result + ' FDO_CODACA = :CODACA AND ';
      Result := Result + ' FDO_EMPACA = :EMPACA AND ';
    End
    Else
    Begin
      If fInformouSeqFdo() Then
        Result := Result + ' FATDOR.AUTOINCREM = :SEQFDO AND '
      Else
        Result := Result + ' FDO_CODITE = :CODITE AND ';
    End;

    If fInformouNumeroLote() Then
    Begin
      If fUsaRotinaWMS() Then
        Result := Result + ' IF( IFNULL(FDO_NUMLOT,"A DEFINIR") <> "", IFNULL(FDO_NUMLOT,"A DEFINIR"), "A DEFINIR") = :NUMLOT AND '
      Else
      Begin
        If (FParametros.TipoReserva() = trsPedidoBaixaEntregaFuturaSaldoFisico) And fLoteADefinir() And (fReservaSaldoPedidosBaixaEntregaFutura) Then
          Result := Result + ' FDO_NUMLOT <> :NUMLOT AND '
        Else  
          Result := Result + ' FDO_NUMLOT = :NUMLOT AND '
      End;
    End;
  End;

  If (FParametros.ApenasSemRequisicao()) Then
    Result := Result + ' RCD_CODIGO IS NULL AND ';

  Result := Result + ' FDO_ESPDOC = "PD"    AND ';
  Result := Result + ' ( NOT IFNULL(EXTDOR.FDO_REPGAR,"0") IN ("2")) AND '; //2 PRODUTO REPROVADO NA AVALIAÇÃO DE GARANTIA PRÓPRIA EMPRESA

  If (Not (FParametros.TipoReserva() = trsTransferencia)) Then
  Begin
    If FParametros.FiltrarEmpresa() Then
      Result := Result + ' IF(FATGOR.FGO_OPRFLJ = "S", IF(FATDOR.FDO_IDEPRO = "NOR", IF(IFNULL(FATDOR.FDO_EMPITE, "") = "", ' + getFiltroFDO_CODEMP +','+ getFiltroFDO_EMPITE +') = :CODEMP, FATDOR.FDO_EMPPRD = :CODEMP), TRUE) AND ';

    If fInformouEmpresaItem() Then
      Result := Result + fGetWhereCodigoDaEmpresa()
    Else
    Begin
      strAux := getFiltroFGO_CODEMP;
      If fUtilizaEntregaPeloCD() And (FParametros.fCodEmp() = fGetEmpresaCD()) Then
        strAux := ' IF(FGO_ENT_CD = "S", IFNULL(FGO_EMP_CD, ' + getFiltroFGO_CODEMP + ') , ' + getFiltroFGO_CODEMP + ') ';
      Result := Result + '   (' + IIF(FParametros.FiltrarEmpresa(), ' IF(IFNULL(FGO_EMPFOR, "") = "", IF(IFNULL(FGO_EMP_TE, "") = "", '+strAux+', FGO_EMP_TE), FGO_EMPFOR) = :CODEMP ', ' FDO_CODEMP = FDO_CODEMP ');
    End;

    If fUtilizaEntregaPeloCD() And (FParametros.fCodEmp() = fGetEmpresaCD()) Then
      Result := Result + '   OR (FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ') ) '
    Else
      Result := Result + '   AND IFNULL(FGO_ENT_CD, "N") = "N") ';

    Result := Result + ' AND ';
  End;

  Case FParametros.TipoFiltroDocumento() Of
    tfdIgnorarDocumentosOnda:
      Result := Result + '   FDO_NUMDOC NOT IN (' + fRetSQLPedidosOnda + ') AND ';
    tfdIgnorarDocumento:
      Result := Result + '   FDO_NUMDOC <> :NUMDOC AND ';
    tfdFiltrarDocumento:
    Begin
      Result := Result + '   (( ((IF(IFNULL(FGO_EMPFOR, "") = "", IF(IFNULL(FGO_EMP_TE, "") = "", FDO_CODEMP, FGO_EMP_TE), FGO_EMPFOR) = :CODEMP) AND (IFNULL(FDO_EMPITE, "") = "")) ';
      Result := Result + ' OR (IF(FATGOR.FGO_OPRFLJ = "S", IF(FATDOR.FDO_IDEPRO = "NOR", IF(IFNULL(FATDOR.FDO_EMPITE, "") = "", '+ getFiltroFDO_CODEMP +','+ getFiltroFDO_EMPITE +') = :CODEMP, FATDOR.FDO_EMPPRD = :CODEMP), TRUE) )  ';

      If fInformouEmpresaItem() Then
        Result := Result + '  OR ' + fGetWhereCodigoDaEmpresa() + ' )) '
      Else
        Result := Result + ' ) ';

      If fUtilizaEntregaPeloCD() And (VS_strCodEmp = fGetEmpresaCD()) Then
        Result := Result + '   OR (FGO_ENT_CD = "S" AND IFNULL(FGO_EMP_CD, ' + QuotedStr(fGetEmpresaCD()) + ') = ' + QuotedStr(fGetEmpresaCD()) + ') ) '
      Else
        Result := Result + ' ) ';

      Result := Result + ' AND FDO_NUMDOC = :NUMDOC AND ';
    End;
  End;

  Result := Result + '   FDO_JAFATU = 0 ';

  Result := Result + '  AND IFNULL(FGO_LOC_PD,"N") <> "S" ';

  Result := Result + '  AND NOT EXISTS (SELECT E.FDO_SEQFDO FROM EXTDOR E WHERE E.FDO_RESERV = "N" AND E.FDO_SEQFDO = FATDOR.AUTOINCREM) ';

  If (fCfgSis('BAITMQ') = 'S') Then
  Begin
    Result := Result + '   AND IFNULL((SELECT TD.FDO_BAIXAD FROM TINDOR TD ';
    Result := Result + '               WHERE TD.FDO_NUMDOC = FATDOR.FDO_NUMDOC    ';
    Result := Result + '                 AND TD.FDO_ESPDOC = FATDOR.FDO_ESPDOC    ';
    Result := Result + '                 AND TD.FDO_CODEMP = FATDOR.FDO_CODEMP    ';
    Result := Result + '                 AND TD.FDO_CODCLI = FATDOR.FDO_CODCLI    ';
    Result := Result + '                 AND TD.FDO_CODITE = FATDOR.FDO_CODITE    ';
    Result := Result + '                 AND TD.FDO_CODACA = FATDOR.FDO_CODACA    ';
    Result := Result + '                 AND TD.FDO_EMPACA = FATDOR.FDO_EMPACA    ';
    Result := Result + '                 LIMIT 1 ),0) = 0 ';
  End
  Else Begin
    Result := Result + ' AND IF(FGO_OPRFLJ = "S", IF(FGO_OPRFLJ = "S" AND (IFNULL((SELECT                                  ';
    Result := Result + '                                                             TD.FDO_BAIXAD                         ';
    Result := Result + '                                                           FROM                                    ';
    Result := Result + '                                                             TINDOR TD                             ';
    Result := Result + '                                                           WHERE                                   ';
    Result := Result + '                                                             TD.FDO_NUMDOC = FATDOR.FDO_NUMDOC AND ';
    Result := Result + '                                                             TD.FDO_ESPDOC = FATDOR.FDO_ESPDOC AND ';
    Result := Result + '                                                             TD.FDO_CODEMP = FATDOR.FDO_CODEMP AND ';
    Result := Result + '                                                             TD.FDO_CODCLI = FATDOR.FDO_CODCLI AND ';
    Result := Result + '                                                             TD.FDO_CODITE = FATDOR.FDO_CODITE AND ';
    Result := Result + '                                                             TD.FDO_CODACA = FATDOR.FDO_CODACA AND ';
    Result := Result + '                                                             TD.FDO_EMPACA = FATDOR.FDO_EMPACA     ';
    Result := Result + '                                                           LIMIT 1), 0) = 0), 1, 0), 1) = 1        ';
  End;

  If (Not fConsiderarItensEntregaFuturaPorFaltaDeReserva()) Then
    Result := Result + '  AND FDO_MOTFUT <> "F" ';

  If fUsaAbastecimentoAutomaticoDaLojaPeloDeposito() Then
  Begin
    Result := Result + '  AND ( ABADEP.AUTOINCREM IS NULL OR ';
    Result := Result + '        ABADEP.DET_ENTFUT <> "S" ';

    Case fCfgSis('CALSAL', varInteger) Of
      1: Begin
           //Nenhuma entrega futura reserva estoque
           Result := Result + ' OR ABADEP.DET_MOTFUT NOT IN ("P", "F", "A") ';
         End;
      2: Begin
           If fCfgSis('BEFTRG', VarBoolean) Then //ENTREGA FUTURA NAO RESERVA ESTOQUE
           Begin
             //Nenhuma entrega futura reserva estoque
             Result := Result + ' OR ABADEP.DET_MOTFUT NOT IN ("P", "F", "A") ';
           End
           Else
           Begin
             //Todas entrega futura reservam estoque
             Result := Result + ' OR ABADEP.DET_MOTFUT IN ("P", "F", "A") ';
           End;
         End;
      3: Begin
           //Somente entrega futura (P)revisão e (A)guardando reservam estoque
           Result := Result + ' OR ABADEP.DET_MOTFUT IN ("P", "A") ';
         End;
      4: Begin
           //Somente entrega futura (F)alta reserva estoque
           Result := Result + ' OR ABADEP.DET_MOTFUT IN ("F") ';
         End;
      5: Begin
           //Somente entrega futura (P)revisão reserva estoque
           Result := Result + ' OR ABADEP.DET_MOTFUT IN ("P") ';
         End;
    End;

    Result := Result + ')';
  End;

  If fUsaPedidosDeBaixaEntregaFutura() Then
  Begin
    If (FParametros.TipoReserva() In [trsPedidoBaixaEntregaFuturaSaldoFisico, trsPedidoBaixaEntregaFuturaReservSaldo]) Then
    Begin
      //RESERVA EM QTPDBF = trsPedidoBaixaEntregaFuturaSaldoFisico
      //RESERVA EM SDPDBF = trsPedidoBaixaEntregaFuturaReservSaldo
      If (fReservaSaldoPedidosBaixaEntregaFutura) Then
      Begin
        If (FParametros.TipoReserva() = trsPedidoBaixaEntregaFuturaSaldoFisico) Then
        Begin
          //RESERVA EM QTPDBF
          Result := Result + '  AND (TRIM(IFNULL(FDO_INCFUT, "")) <> "") ';
          If fInformouNumeroLote() Then
          Begin
            If fLoteADefinir() Then
              Result := Result + '  AND (((SELECT DET_NUMLOT FROM MOVDET WHERE AUTOINCREM = FDO_INCFUT) = "A DEFINIR") AND (FDO_NUMLOT <> "A DEFINIR")) '
            Else  
              Result := Result + '  AND NOT (((SELECT DET_NUMLOT FROM MOVDET WHERE AUTOINCREM = FDO_INCFUT) = "A DEFINIR") AND (FDO_NUMLOT <> "A DEFINIR")) '
          End;
        End  
        Else 
        Begin
          //RESERVA EM SDPDBF
          Result := Result + '  AND (TRIM(IFNULL(FDO_INCFUT, "")) <> "") '
        End;

        If Not fEmptyStr(FParametros.MotFutAConsiderar()) Then
          Result := Result + '  AND LOCATE((SELECT IFNULL(DET_MOTFUT,"") FROM MOVDET WHERE AUTOINCREM = FDO_INCFUT), "'+FParametros.MotFutAConsiderar()+'") > 0 ';
      End
      Else
      Begin
        Result := Result + '  AND FALSE ' //NÃO RESERVA EM: QTPDBF E SDPDBF
      End;
    End
    Else
    Begin  
      //DESCARTA OS PEDIDOS DE BAIXA DE ENTREGA FUTURA
      Result := Result + '  AND TRIM(IFNULL(FDO_INCFUT, "")) = "" ';
    End;
  End
  Else 
  Begin
    //SE NÃO USA CFG_PEDBEF NÃO RESERVA EM: QTPDBF E SDPDBF
    If (FParametros.TipoReserva() In [trsPedidoBaixaEntregaFuturaSaldoFisico, trsPedidoBaixaEntregaFuturaReservSaldo]) Then
    Begin
      Result := Result + '  AND FALSE '
    End;
  End;

  If fBaixaEstoqueDeItemEstruturaOuSubProdutos() Then
    Result := Result + '  AND IF(IFNULL(FDO_ORDPRO, "") = "", TRUE, PRO_DTABAI IS NOT NULL) ';

  If fBaixaEstoqueDeSubProdutos() Then
    Result := Result + '  AND IFNULL(FDO_BXSBIT,"N") <> "S" ';

  If fConsiderarSaldoReservadoMWS() And
     (Not fLoteADefinir()) Then
    Result := Result + '  AND LDO_NUMLOT IS NULL ';

  If fInformouNumeroLote() Then
  Begin
    If fUsaRotinaWMS() Then
      Result := Result + ' AND IF( IFNULL(FDO_NUMLOT,"A DEFINIR") <> "", IFNULL(FDO_NUMLOT,"A DEFINIR"), "A DEFINIR") = :NUMLOT '
    Else
    Begin
      If (FParametros.TipoReserva() = trsPedidoBaixaEntregaFuturaSaldoFisico) And fLoteADefinir() And (fReservaSaldoPedidosBaixaEntregaFutura) Then
        Result := Result + ' AND FDO_NUMLOT <> :NUMLOT '
      Else  
        Result := Result + ' AND FDO_NUMLOT = :NUMLOT '
    End;
  End;

  If FParametros.DesconsideraPedidosCorte() Then
    Result := Result + ' AND IFNULL(FGO_CORTE_, "") <> "S" ';

  If fInformouQtdDiasPrevisao() Then
    Result := Result + ' AND FGO_PREVIS <= DATE_ADD(CURRENT_DATE, INTERVAL :QTDIAS DAY) ';

  If fInformouPeriodoPrevisao() Then
    Result := Result + ' AND FGO_PREVIS BETWEEN :PRVINI AND :PRVFIN ';

  If FParametros.ApenasPedidosLiberados() Then
    Result := Result + '  AND (IFNULL(FGO_LIBERA, 0) > 0 OR ((FDO_VLRCON = 0) '+
                       '  AND LOCATE("PEDIDO DE RESERVA DE ESTOQUE",FGO_MEN001) > 0) OR '+COLETA+') ';

  If (fReservarSaldoSomenteDeEnderecamento) Then
    Result := Result + ' AND IFNULL(FGO_DOCEND, "") <> "" AND IFNULL(FGO_BKPEND, "") = "" '
  Else If (FParametros.DesconsideraPedidosEnderecamento() Or FParametros.EhAtualizacao()) Then
    Result := Result + ' AND IFNULL(FGO_DOCEND, "") = "" ';

  If fControleDeGarantiaEmpresaDefinida() Then
    Result := Result + ' AND (((FDO_VLRCON <> 0) AND (FGO_MEN001 <> "GARANTIA" ))'+
                       '       OR ((FDO_VLRCON = 0) AND LOCATE("PEDIDO DE RESERVA DE ESTOQUE", FGO_MEN001) > 0) ' +
                       '       OR '+COLETA+')';

  Case FParametros.TipoReserva() Of
    trsPedidoVenda, trsPedidoVendaCli, trsPedidoVendaFil, trsTransferencia, trsPedidoBaixaEntregaFuturaSaldoFisico, trsPedidoBaixaEntregaFuturaReservSaldo:
    Begin
      Result := Result + ' AND LOCATE("PEDIDO DE RESERVA DE ESTOQUE OP-", FGO_MEN001) = 0 ';

      Case FParametros.TipoReserva() Of
        trsPedidoVendaCli:
          Result := Result + ' AND FGO_CODCLI NOT IN (' + VS_strCliFil + ') ';
        trsPedidoVendaFil:
          Result := Result + ' AND FGO_CODCLI IN (' + VS_strCliFil + ') ';
        trsTransferencia:
          Result := Result + ' AND FGO_CODCLI = :CODCLI';
      End;

    End;
    trsOrdemProducao:
      Result := Result + ' AND LOCATE("PEDIDO DE RESERVA DE ESTOQUE OP-", FGO_MEN001) > 0 ';
  End;

  If (Not FParametros.ItemEhPigmento()) Then
  Begin
    Result := Result + ' GROUP BY ';

    If fInformouProdutoAcabado() Then
      Result := Result + ' FDO_CODACA, FDO_EMPACA '
    Else
      Result := Result + ' FDO_CODITE ';

    If FTipoSQL = ttsChaveDocumento Then
      Result := Result + ' ,FATDOR.AUTOINCREM ';
  End;

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTDOR', 'FDO_REPGAR', True) Then
      Result := ReplaceStr(Result, 'EXTDOR.FDO_REPGAR', ' /* EXTDOR.FDO_REPGAR */ "0" ');

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTGOR', 'FGO_LOC_PD', True) Then
      Result := ReplaceStr(Result, 'FGO_LOC_PD', ' /* FGO_LOC_PD */ "N" ');

  If fExecutandoPeloPortal Then
    If Not fCampoExiste('EXTDOR', 'FDO_RESERV', True) Then
      Result := ReplaceStr(Result, 'E.FDO_RESERV', ' /* E.FDO_RESERV */ "S" ');
end;

function TSaldoReservado.fUsaPedidosDeBaixaEntregaFutura: Boolean;
begin
  Result := AnsiMatchText(fCfgSis('PEDBEF', varString), ['S', 'P']);;
end;

function TSaldoReservado.fInformouPeriodoPrevisao: Boolean;
begin
  Result := (FParametros.DtaPrevisaoInicial() <> 0) And
            (FParametros.DtaPrevisaoFinal() <> 0);
end;

function TSaldoReservado.fInformouProdutoAcabado: Boolean;
begin
  Result := (Not fEmptyStr(FParametros.CodItemAcabado()));
end;

function TSaldoReservado.fInformouQtdDiasPrevisao: Boolean;
begin
  Result := (FParametros.QtdDiaPrevisao() > -1);
end;

function TSaldoReservado.fInformouSeqFdo: Boolean;
begin
  Result := (Not fEmptyStr(FParametros.SeqFdo()));
end;

function TSaldoReservado.fLoteADefinir: Boolean;
begin
  Result := SameText(FParametros.NumeroLote(), 'A DEFINIR');
end;

function TSaldoReservado.fObterQuantidadeViaSelect: Boolean;
begin
  Result := FParametros.ItemEhPigmento() Or
            FParametros.EhAtualizacao() Or
            (Not fUtilizaCamposDeSaldo());
end;

function TSaldoReservado.fReservarEstoqueOrdemProducaoAberto(
  Const blnEmpresaLogada: Boolean = True): Boolean;
begin
  Result := fCfgSis('OPREST', varBoolean, IIF(blnEmpresaLogada, '',
                                              FParametros.fCodEmp()));
end;

function TSaldoReservado.fTravaSaldoReservadoParaPedidoVenda: Boolean;
begin
  Result := fCfgSis('USASRE', varBoolean, FParametros.CodEmpresa());
end;

function TSaldoReservado.fReservarSaldoSomenteDeEnderecamento: Boolean;
begin
  //CFG_USASRE - Trava de saldo reservado para Pedido de Venda?
  //CFG_USASRE = NÃO (RESERVA SÓ OS ENDEREÇAMENTOS)
  //CFG_USASRE = SIM (CONSIDERA DEMAIS PEDIDOS)
  
  Result := (FParametros.TipoReserva() = trsEnderecamento) Or 
            (Not fTravaSaldoReservadoParaPedidoVenda);

  If Result Then
  Begin 
    If FParametros.TipoReserva In [trsPedidoVendaFil, trsTransferencia] Then
      Result := False; 
  End;
end;

function TSaldoReservado.fInformouEmpresaItem: Boolean;
begin
  Result := Not fEmptyStr(FParametros.EmpresaItem());
end;

function TSaldoReservado.fInformouNumeroLote: Boolean;
begin
  Result := (Not fEmptyStr(FParametros.NumeroLote()));
end;

function TSaldoReservado.fGetCamposReservaDePedidosEOrdemProducao: String;
Const
  FDO_QTDITE = ' (COALESCE(FDO_QTDITE,0) - COALESCE(FDO_QTDBAI,0)) ';
var
  LContador: Integer;
begin
  Result := '';

  If FParametros.ItemEhPigmento() Then
  Begin
    Result := Result + ' CAST("' + FParametros.CodigoItem() + '" AS CHAR(7)) AS  CODCOL, ';

    For LContador := 1 To 15 Do
    Begin
      Result := Result + ' DUP_BASE' + fStrZero(LContador, 2) + ', ';
      Result := Result + ' DUP_QTDC' + fStrZero(LContador, 2) + ', ';
      Result := Result + ' DUP_QTDD' + fStrZero(LContador, 2) + ', ';
    End;

    Result := Result + ' ITE_CNV_ML, ';
    Result := Result + ' FDO_TIPPRE, ';
    Result := Result + ' FDO_VOLPRO, ';
    Result := Result + ' FDO_QTDITE, ';
    Result := Result + ' DUP_LITRAG  ';
  End
  Else
  Begin
    Result := Result + FDO_QTDITE;

    If fConsiderarSaldoReservadoMWS() And fLoteADefinir() Then
      Result := Result + ' - COALESCE((SELECT SUM(LDO_QTDITE) FROM LOTDOR WHERE'+
                                       ' LDO_SEQFDO = FATDOR.AUTOINCREM), 0)';

    If fVerQtdAbastecimento() Then
    Begin
      Result := Result + ' - (' + fGetSQLQtdSolicitacao() + ' - (' +
                                  fGetSQLQtdSolicitacaoComEntradaNoEstoque() + ' - ' +
                                  fGetSQLQtdSolicitacaoComReservaEnderecamento() + '))';

      Result := Result + ' - (' + fGetSQLQtdSolicitacao(ttsTransferencia) + ' - (' +
                                  fGetSQLQtdSolicitacaoComEntradaNoEstoque(ttsTransferencia) + ' - ' +
                                  fGetSQLQtdSolicitacaoComReservaEnderecamento(ttsTransferencia) + '))';

      Result := Result + ' - (' + fGetSQLQtdSolicitacao(ttsRequisicaoAtTransferencia) + ' - (' +
                                  fGetSQLQtdSolicitacaoComEntradaNoEstoque(ttsRequisicaoAtTransferencia) + ' - ' +
                                  fGetSQLQtdSolicitacaoComReservaEnderecamento(ttsRequisicaoAtTransferencia) + '))';

      Result := Result + ' - (' + fGetSQLQtdAbastecimento() + ' - ' +
                                  fGetSQLQtdAbastecimentoComEntrada() + ')';
    End
    Else If fVerQtdReqCompraPendente Then
    Begin
      Result := Result + ' - (' + fGetSQLQtdReqCompraPendente() + ')';
    End;

    Result := ' ( ' + Result + ' ) ';

    Result := ' SUM(IF( ' + Result + ' < 0, 0, IF(' + Result + ' > ' + FDO_QTDITE + ', ' + FDO_QTDITE + ', ' + Result +' ))) AS SALRES ';
  End;

  If FTipoSQL = ttsChaveDocumento Then
  Begin
    Result := ' FATDOR.AUTOINCREM AS AUTINC, ' +
              ' "FATDOR" AS TABELA, ' +
              ' FDO_CODITE AS CODITE, ' +  Result;
  End;
end;

function TSaldoReservado.fConsiderarItensEntregaFuturaPorFaltaDeReserva: Boolean;
begin
  Result := (fCfgSis('REEFFP', varString, FParametros.CodEmpresa()) = 'S');
end;

function TSaldoReservado.fConsiderarSaldoReservadoMWS: Boolean;
begin
  Result := (Not FParametros.ItemEhPigmento()) And
            (Not fInformouProdutoAcabado())    And
            fUsaRotinaWMS()                    And
            fInformouNumeroLote();
end;

function TSaldoReservado.fControleDeGarantiaEmpresaDefinida(
  Const strCodEmp: String = ''): Boolean;
begin
  Result := fCfgSis('GARMAT', varBoolean, IIF(fEmptyStr(strCodEmp),
                                              FParametros.CodEmpresa(),
                                              strCodEmp));
end;

function TSaldoReservado.fUsaAbastecimentoAutomaticoDaLojaPeloDeposito: Boolean;
begin
  Result := fCfgSis('ABADEP', varBoolean, FParametros.CodEmpresa());
end;

function TSaldoReservado.fUsaPDV: Boolean;
begin
  Result := fCfgSis('USAPDV', varBoolean, FParametros.CodEmpresa());
end;

function TSaldoReservado.fUtilizaCamposDeSaldo: Boolean;
begin
  Result := FParametros.fEquals(TReservaParametros.New()
                                  .CodigoItem(FParametros.CodigoItem())
                                  .CodEmpresa(FParametros.CodEmpresa())
                                  .EmpresaItem(FParametros.EmpresaItem())
                                  .NumeroLote(FParametros.NumeroLote())
                                  .TipoReserva(FParametros.TipoReserva())
                                  .ConverterML(FParametros.ConverterML())
                                  .DesconsideraPedidosEnderecamento(FParametros.DesconsideraPedidosEnderecamento()));
end;

function TSaldoReservado.fUtilizaEmpCarregamento: Boolean;
begin
  {**********************************************************************}
  {* RETORNA TRUE CASO ALGUMA EMPRESA NO BANCO UTILIZE CFG_EMPCAR = SIM *}
  {*REQ.148688********************************************************RP*}
  Result := (fCampoTabela('COUNT(1)', 'CFGSIS', ['SIS_CODCFG','SIS_VALCFG'], ['CFG_EMPCAR','S'], False) > 0);
end;

function TSaldoReservado.fUtilizaEntregaPeloCD: Boolean;
begin
  Result := (fCfgSis('ENT_CD', varBoolean, FParametros.CodEmpresa()));
end;

function TSaldoReservado.fUtilizaVendaVidro: Boolean;
begin
  Result := fCfgSis('VENVID', VarBoolean, FParametros.fCodEmp());
end;

function TSaldoReservado.fVerQtdAbastecimento: Boolean;
begin
  Result := fCfgSis('SLTFRC', varBoolean);
end;

function TSaldoReservado.fVerQtdReqCompraPendente: Boolean;
begin
  If VarIsNull(Self.CFG_SLRQPE) Then
  Begin
    Try
      Self.CFG_SLRQPE := fCfgSis('SLRQPE', varBoolean);
    Except
      Self.CFG_SLRQPE := False;
    End;
  End;
  Result := Self.CFG_SLRQPE;
end;

class function TSaldoReservado.New(AParametros: IReservaParametros): ISaldoReservado;
begin
  Result := TSaldoReservado.Create(AParametros);
end;

procedure TSaldoReservado.pCommandSQLReservasDeLocalizacaoCritica;
begin
  If (Not fGerarSQLReservasLocalizacaoCritica()) Then
    Exit;

  FCommandSQL.Add(fRetornaSQLSalResLotesBloqueadosParaVenda);
end;

procedure TSaldoReservado.pCommandSQLReservasDeEstoqueExterno;
begin
  If (Not fGerarSQLReservasExterno()) Then
    Exit;

  FCommandSQL.Add(fGetSQLSaldoReservadoExterno);
end;

procedure TSaldoReservado.pCommandSQLReservasDeGarantia;
begin
  If (Not fGerarSQLReservasGarantia()) Then
    Exit;

  FCommandSQL.Add(fGetSQLSaldoReservadoGarantia);
end;

procedure TSaldoReservado.pCommandSQLReservasDePedidosEOrdemProducao;
begin
  If (Not fGerarSQLReservasPedidoVenda()) And
     (Not fGerarSQLReservasOrdemProducao()) Then
    Exit;

  FCommandSQL.Add(' SELECT ');
  FCommandSQL.Add(fGetCamposReservaDePedidosEOrdemProducao());
  FCommandSQL.Add(' FROM FATDOR ');
  FCommandSQL.Add(fGetJoinsReservaDePedidosEOrdemProducao());
  FCommandSQL.Add(' WHERE ');
  FCommandSQL.Add(fGetWhereReservaDePedidosEOrdemProducao());

  If fGerarSQLReservasPedidoVenda() Then
    FCommandSQL.Add(fGetSQLSaldoReservadoLotesDigSeparacao);

  If fGerarSQLReservasOrdemProducao() Then
  Begin
    FCommandSQL.Add(fGetSQLSaldoReservadoSubItemEstrutura);
    FCommandSQL.Add(fGetSQLSaldoReservadoOrdemProducaoAberto);
  End;

  FCommandSQL.Add(fRetornaSQLSalResLotesBloqueadosParaVenda);

  FCommandSQL.Add(fGetSQLSaldoReservadoEstruturaVidro);
end;

procedure TSaldoReservado.pSetaParametrosSQL;
begin
  If fInformouSeqFdo() Then
    FQryCommand.ParamByName('SEQFDO').AsString := FParametros.SeqFdo()
  Else
  Begin
    If FParametros.ItemEhPigmento() Then
      FQryCommand.ParamByName('CODITE').AsString := FParametros.CodigoItem()
    Else
    Begin
      If ((Not fInformouProdutoAcabado()) Or
          fGerarSQLReservasGarantia() Or
          fGerarSQLReservasExterno()) Then
        FQryCommand.ParamByName('CODITE').AsString := FParametros.CodigoItem()
      Else
      Begin
        FQryCommand.ParamByName('CODACA').AsString := FParametros.CodItemAcabado();
        FQryCommand.ParamByName('EMPACA').AsString := FParametros.EmpItemAcabado();
      End;
    End;
  End;

  If (FParametros.TipoReserva() = trsTransferencia) Then
  Begin
    If Assigned(FQryCommand.FindParam('CODCLI')) Then
      FQryCommand.ParamByName('CODCLI').AsString := fRetornaClienteFilial(FParametros.CodEmpresa());
  End
  Else
  Begin
    If FParametros.FiltrarEmpresa() Then
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmpresa();

    If fGerarSQLReservasPedidoVenda() Or
       fGerarSQLReservasOrdemProducao() Then
    Begin
      If fInformouEmpresaItem() Then
        FQryCommand.ParamByName('EMPITE').AsString := FParametros.EmpresaItem();

      Case FParametros.TipoFiltroDocumento() Of
        tfdIgnorarDocumentosOnda:
          FQryCommand.ParamByName('ONDA').AsString := FParametros.OndaDeSeparacao();
        tfdFiltrarDocumento,
        tfdIgnorarDocumento:
          FQryCommand.ParamByName('NUMDOC').AsString := FParametros.NumeroDocumento();
      End;

      If fInformouNumeroLote() Then
        FQryCommand.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();
    End
    Else
    If fGerarSQLReservasGarantia() Then
    Begin
      If fInformouNumeroLote() Then
        FQryCommand.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();
    End
    Else If fGerarSQLReservasExterno() and fInformouNumeroLote() Then
      FQryCommand.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();

    If fInformouQtdDiasPrevisao() Then
    Begin
      If Assigned(FQryCommand.FindParam('QTDIAS')) Then
        FQryCommand.ParamByName('QTDIAS').AsInteger := FParametros.QtdDiaPrevisao();
    End;

    If fInformouPeriodoPrevisao() Then
    Begin
      If Assigned(FQryCommand.FindParam('PRVINI')) Then
        FQryCommand.ParamByName('PRVINI').AsDate := FParametros.DtaPrevisaoInicial();

      If Assigned(FQryCommand.FindParam('PRVFIN')) Then
        FQryCommand.ParamByName('PRVFIN').AsDate := FParametros.DtaPrevisaoFinal();
    End;
  End;
end;

{ TReservaParametros }

function TReservaParametros.ApenasPedidosLiberados(const Value: Boolean): IReservaParametros;
begin
  FApenasPedidosLiberados := Value;
  Result := Self;
end;

function TReservaParametros.ApenasPedidosLiberados: Boolean;
begin
  Result := FApenasPedidosLiberados;
end;

function TReservaParametros.ApenasSemRequisicao(
  const Value: Boolean): IReservaParametros;
begin
  FApenasSemRequisicao := Value;
  Result := Self;
end;

function TReservaParametros.ApenasSemRequisicao: Boolean;
begin
  Result := FApenasSemRequisicao;
end;

function TReservaParametros.CodEmpresa(const Value: String): IReservaParametros;
begin
  FCodEmpresa := Value;
  Result := Self;
end;

function TReservaParametros.CodEmpresa: String;
begin
  Result := FCodEmpresa;
end;

function TReservaParametros.CodigoItem(const Value: String): IReservaParametros;
begin
  FCodigoItem := Value;
  FItemEhPigmento := fItemPigmento(FCodigoItem, FCodigoItemBase);
  Result := Self;
end;

function TReservaParametros.CodigoItem: String;
begin
  Result := FCodigoItem;
end;

function TReservaParametros.CodigoItemBase: String;
begin
  Result := FCodigoItemBase;
end;

function TReservaParametros.CodItemAcabado: String;
begin
  Result := FCodItemAcabado;
end;

function TReservaParametros.CodItemAcabado(const Value: String): IReservaParametros;
begin
  FCodItemAcabado := Value;
  Result := Self;
end;

function TReservaParametros.ConverterML(const Value: Boolean): IReservaParametros;
begin
  FConverteML := Value;
  Result := Self;
end;

function TReservaParametros.ConverterML: Boolean;
begin
  Result := FConverteML;
end;

constructor TReservaParametros.Create;
begin
  FCodigoItem := '';
  FCodEmpresa := '';
  FNumeroLote := '';
  FEmpresaItem := '';
  FConverteML := False;
  FEhAuditoria := False;
  FQtdDiaPrevisao := -1;
  FCodItemAcabado := '';
  FEmpItemAcabado := '';
  FCodigoItemBase := '';
  FNumeroDocumento := '';
  FDtaPrevisaoFinal := 0;
  FEhReprocesso := False;
  FFiltrarEmpresa := True;
  FEhAtualizacao := False;
  FTipoReserva := trsTodos;
  FItemEhPigmento := False;
  FDtaPrevisaoInicial := 0;
  FApenasSemRequisicao := False;
  FTipoFiltroDocumento := tfdTodos;
  FApenasPedidosLiberados := False;
  FDesconsideraPedidosCorte := True;
  FDesconsideraPedidosEnderecamento := False;
  FBlnItemContratoLocacao := False;
  FMotFutAConsiderar := '';
  FTabelaAudit := '';
end;

function TReservaParametros.DesconsideraPedidosCorte: Boolean;
begin
  Result := FDesconsideraPedidosCorte;
end;

function TReservaParametros.DesconsideraPedidosCorte(const Value: Boolean): IReservaParametros;
begin
  FDesconsideraPedidosCorte := Value;
  Result := Self;
end;

function TReservaParametros.DesconsideraPedidosEnderecamento: Boolean;
begin
  Result := FDesconsideraPedidosEnderecamento;
end;

function TReservaParametros.DesconsideraPedidosEnderecamento(const Value: Boolean): IReservaParametros;
begin
  FDesconsideraPedidosEnderecamento := Value;
  Result := Self;
end;

function TReservaParametros.DtaPrevisaoFinal(const Value: TDate): IReservaParametros;
begin
  FDtaPrevisaoFinal := Value;
  Result := Self;
end;

function TReservaParametros.DtaPrevisaoFinal: TDate;
begin
  Result := FDtaPrevisaoFinal;
end;

function TReservaParametros.DtaPrevisaoInicial(const Value: TDate): IReservaParametros;
begin
  FDtaPrevisaoInicial := Value;
  Result := Self;
end;

function TReservaParametros.DtaPrevisaoInicial: TDate;
begin
  Result := FDtaPrevisaoInicial;
end;

function TReservaParametros.EhAtualizacao(
  const Value: Boolean): IReservaParametros;
begin
  FEhAtualizacao := Value;
  Result := Self;
end;

function TReservaParametros.EhAtualizacao: Boolean;
begin
  Result := FEhAtualizacao;
end;

function TReservaParametros.EhAuditoria(
  const Value: Boolean): IReservaParametros;
begin
  FEhAuditoria := Value;
  Result := Self;
end;

function TReservaParametros.EhAuditoria: Boolean;
begin
  Result := FEhAuditoria;
end;

function TReservaParametros.EhReprocesso(
  const Value: Boolean): IReservaParametros;
begin
  FEhReprocesso := Value;
  Result := Self;
end;

function TReservaParametros.EhReprocesso: Boolean;
begin
  Result := FEhReprocesso;
end;

function TReservaParametros.EmpItemAcabado: String;
begin
  Result := FEmpItemAcabado;
end;

function TReservaParametros.EmpItemAcabado(const Value: String): IReservaParametros;
begin
  FEmpItemAcabado := Value;
  Result := Self;
end;

function TReservaParametros.EmpresaItem(const Value: String): IReservaParametros;
begin
  FEmpresaItem := Value;
  Result := Self;
end;

function TReservaParametros.fCodEmp: String;
begin
  If (Not fEmptyStr(FEmpresaItem)) Then
    Result := FEmpresaItem
  Else If (Not fEmptyStr(FCodEmpresa)) Then
    Result := FCodEmpresa
  Else
    Result := VS_strCodEmp;
end;

function TReservaParametros.EmpresaItem: String;
begin
  Result := FEmpresaItem;
end;

function TReservaParametros.fEquals(const AInstance: IReservaParametros): Boolean;
begin
  Result := (Self.CodigoItem() = AInstance.CodigoItem()) And
            (Self.CodEmpresa() = AInstance.CodEmpresa()) And
            (Self.NumeroLote() = AInstance.NumeroLote()) And
            (Self.TipoReserva() = AInstance.TipoReserva()) And
            (Self.EmpresaItem() = AInstance.EmpresaItem()) And
            (Self.ConverterML() = AInstance.ConverterML()) And
            (Self.EhAtualizacao() = AInstance.EhAtualizacao()) And
            (Self.QtdDiaPrevisao() = AInstance.QtdDiaPrevisao()) And
            (Self.FiltrarEmpresa() = AInstance.FiltrarEmpresa()) And
            (Self.CodItemAcabado() = AInstance.CodItemAcabado()) And
            (Self.EmpItemAcabado() = AInstance.EmpItemAcabado()) And
            (Self.NumeroDocumento() = AInstance.NumeroDocumento()) And
            (Self.DtaPrevisaoFinal() = AInstance.DtaPrevisaoFinal()) And
            (Self.DtaPrevisaoInicial() = AInstance.DtaPrevisaoInicial()) And
            (Self.ApenasSemRequisicao() = AInstance.ApenasSemRequisicao()) And
            (Self.TipoFiltroDocumento() = AInstance.TipoFiltroDocumento()) And
            (Self.ApenasPedidosLiberados() = AInstance.ApenasPedidosLiberados()) And
            (Self.DesconsideraPedidosCorte() = AInstance.DesconsideraPedidosCorte()) And
            (Self.DesconsideraPedidosEnderecamento() = AInstance.DesconsideraPedidosEnderecamento()) And
            (Self.ItemContratoLocacao() = AInstance.ItemContratoLocacao()) And
            (Self.MotFutAConsiderar() = AInstance.MotFutAConsiderar());
end;

function TReservaParametros.FiltrarEmpresa: Boolean;
begin
  Result := FFiltrarEmpresa;
end;

function TReservaParametros.FiltrarEmpresa(const Value: Boolean): IReservaParametros;
begin
  FFiltrarEmpresa := Value;
  Result := Self;
end;

function TReservaParametros.ItemContratoLocacao(
  const Value: Boolean): IReservaParametros;
begin
  FBlnItemContratoLocacao := Value;
  Result := Self;
end;

function TReservaParametros.ItemContratoLocacao: Boolean;
begin
  Result := FBlnItemContratoLocacao;
end;

function TReservaParametros.MotFutAConsiderar(const Value: String): IReservaParametros;
begin
  FMotFutAConsiderar := Value;
  Result := Self;
end;

function TReservaParametros.MotFutAConsiderar: String;
begin
  Result := FMotFutAConsiderar;
end;

function TReservaParametros.ItemEhPigmento: Boolean;
begin
  Result := FItemEhPigmento;
end;

class function TReservaParametros.New: IReservaParametros;
begin
  Result := TReservaParametros.Create();
end;

function TReservaParametros.NumeroDocumento: String;
begin
  Result := FNumeroDocumento;
end;

function TReservaParametros.NumeroDocumento(const Value: String): IReservaParametros;
begin
  FNumeroDocumento := Value;
  Result := Self;
end;

function TReservaParametros.NumeroLote: String;
begin
  Result := FNumeroLote;
end;

function TReservaParametros.OndaDeSeparacao: String;
begin
  Result := FOndaDeSeparacao;
end;

function TReservaParametros.OndaDeSeparacao(const Value: String): IReservaParametros;
begin
  FOndaDeSeparacao := Value;
  Result := Self;
end;

function TReservaParametros.NumeroLote(const Value: String): IReservaParametros;
begin
  FNumeroLote := Value;
  Result := Self;
end;

function TReservaParametros.QtdDiaPrevisao: Integer;
begin
  Result := FQtdDiaPrevisao;
end;

function TReservaParametros.SeqFdo(const Value: String): IReservaParametros;
begin
  FSeqFdo := Value;
  Result := Self;
end;

function TReservaParametros.SeqFdo: String;
begin
  Result := FSeqFdo;
end;

function TReservaParametros.QtdDiaPrevisao(const Value: Integer): IReservaParametros;
begin
  FQtdDiaPrevisao := Value;
  Result := Self;
end;

function TReservaParametros.TabelaAudit: String;
begin
  Result := FTabelaAudit;
end;

function TReservaParametros.TabelaAudit(const Value: String): IReservaParametros;
begin
  FTabelaAudit := Value;
  Result := Self;
end;

function TReservaParametros.TipoFiltroDocumento: TTipoFiltroDocumento;
begin
  Result := FTipoFiltroDocumento;
end;

function TReservaParametros.TipoFiltroDocumento(const Value: TTipoFiltroDocumento): IReservaParametros;
begin
  FTipoFiltroDocumento := Value;
  Result := Self;
end;

function TReservaParametros.TipoReserva: TTipoReservaSaldo;
begin
  Result := FTipoReserva;
end;

function TReservaParametros.TipoReserva(
  const Value: TTipoReservaSaldo): IReservaParametros;
begin
  FTipoReserva := Value;
  Result := Self;
end;

{ TUpdateReserva }

constructor TUpdateReserva.Create(AParametros: IReservaParametros);
begin
  FParametros := AParametros;
  FQryUpdate  := fCriaQuery;
end;

destructor TUpdateReserva.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FQryUpdate);
{$ENDIF LINUX}
  inherited;
end;

function TUpdateReserva.fAtualizarCamposPedidoVendas: Boolean;
begin
  Result := (FParametros.TipoReserva() = trsPedidoVenda);
end;

function TUpdateReserva.fAtualizarTodos: Boolean;
begin
  Result := (FParametros.TipoReserva() = trsTodos);
end;

function TUpdateReserva.fBuildSQLUpdate(Const AEhLote: Boolean = False): String;
var
  trsItem: TTipoReservaSaldo;
  LPrefix: String;
begin
  Result := '';
  Result := Result + ' UPDATE ' + IIF(AEhLote, 'CADLOT', 'ITEGER') + ' SET ';

  LPrefix := IIF(AEhLote, 'LOT_', 'ITE_');

  For trsItem := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
  Begin
    If fNaoExecutaUpdateParaEsseTipoDeSaldo(trsItem) Or
      ((Not trsItem.fAtualizaLote) And AEhLote) Then
      Continue;

    Result := Result + Concat(LPrefix,
                              trsItem.fRetNomeCampo(),
                              ' = :',
                              trsItem.fRetNomeCampo(),
                              ',');
  End;

  Delete(Result, Length(Result), 1);
  Result := Result + ' WHERE ' + LPrefix + 'CODITE = :CODITE ';
  Result := Result + '   AND ' + LPrefix + 'CODEMP = :CODEMP ';

  If AEhLote Then
    Result := Result + ' AND ' + LPrefix + 'NUMLOT = :NUMLOT ';
end;

function TUpdateReserva.fExecutarItem: IUpdateReserva;
var
  trsItem: TTipoReservaSaldo;
begin
  Try
    If FParametros.ItemEhPigmento() Then
      Exit;
    Try
      FQryUpdate.SQL.Clear();
      FQryUpdate.SQL.Add(fBuildSQLUpdate());

      For trsItem := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
      Begin
        If fNaoExecutaUpdateParaEsseTipoDeSaldo(trsItem) Then
          Continue;

        FQryUpdate.ParamByName(trsItem.fRetNomeCampo())
          .AsFloat := TSaldoReservado.New(
                        TReservaParametros.New()
                          .CodigoItem(FParametros.CodigoItem())
                          .EmpresaItem(FParametros.EmpresaItem())
                          .CodEmpresa(FParametros.CodEmpresa())
                          .DesconsideraPedidosEnderecamento(FParametros.DesconsideraPedidosEnderecamento())
                          .TipoReserva(trsItem)
                          .EhAtualizacao(True)
                        ).fGetQuantidade();
      End;

      FQryUpdate.ParamByName('CODITE').AsString := FParametros.CodigoItem();
      FQryUpdate.ParamByName('CODEMP').AsString := FParametros.fCodEmp();

      FQryUpdate.ExecSQL();
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[fExecutarItem] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
    End;
  Finally
    Result := Self;
  End;
end;

function TUpdateReserva.fExecutarLote: IUpdateReserva;
var
  trsItem: TTipoReservaSaldo;
begin
  Try
    If (Not fInformouNumeroLote()) Or
    (FParametros.ItemEhPigmento()) Then
      Exit;
    Try
      FQryUpdate.SQL.Clear();
      FQryUpdate.SQL.Add(fBuildSQLUpdate(True));

      For trsItem := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
      Begin
        If fNaoExecutaUpdateParaEsseTipoDeSaldo(trsItem) Or
          (Not trsItem.fAtualizaLote) Then
          Continue;

        FQryUpdate.ParamByName(trsItem.fRetNomeCampo())
          .AsFloat := TSaldoReservado.New(
                        TReservaParametros.New()
                          .CodigoItem(FParametros.CodigoItem())
                          .EmpresaItem(FParametros.EmpresaItem())
                          .CodEmpresa(FParametros.CodEmpresa())
                          .TipoReserva(trsItem)
                          .NumeroLote(FParametros.NumeroLote())
                          .EhAtualizacao(True)
                        ).fGetQuantidade();
      End;

      FQryUpdate.ParamByName('CODITE').AsString := FParametros.CodigoItem();
      FQryUpdate.ParamByName('CODEMP').AsString := FParametros.fCodEmp();
      FQryUpdate.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();

      FQryUpdate.ExecSQL();
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[fExecutarLote] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
    End;
  Finally
    Result := Self;
  End;
end;

function TUpdateReserva.fNaoExecutaUpdateParaEsseTipoDeSaldo(const trsOpc: TTipoReservaSaldo): Boolean;
begin
  Result := (Not trsOpc.fAtualiza()) Or
    ((Not fAtualizarTodos()) And (Not fAtualizarCamposPedidoVendas()) And (Not (FParametros.TipoReserva() = trsOpc))) Or
    (fAtualizarCamposPedidoVendas() And (Not (trsOpc In [trsPedidoVendaCli, trsPedidoVendaFil, trsEnderecamento, trsPedidoBaixaEntregaFuturaSaldoFisico, trsPedidoBaixaEntregaFuturaReservSaldo]))) Or
    (fEmptyStr(trsOpc.fRetNomeCampo()) Or
    FParametros.ItemContratoLocacao
    );
end;

function TUpdateReserva.fInformouNumeroLote: Boolean;
begin
  Result := (Not fEmptyStr(FParametros.NumeroLote()));
end;

class function TUpdateReserva.New(AParametros: IReservaParametros): IUpdateReserva;
begin
  Result := TUpdateReserva.Create(AParametros);
end;

{ TInvokerUpdateReserva }

constructor TInvokerUpdateReserva.Create;
begin
  FCommandList := TInterfaceList.Create();
end;

destructor TInvokerUpdateReserva.Destroy;
begin
  FCommandList.Clear();
  FCommandList.Free();

  inherited;
end;

class function TInvokerUpdateReserva.New: IInvokerUpdateReserva;
begin
  Result := TInvokerUpdateReserva.Create();
end;

procedure TInvokerUpdateReserva.pAdd(ACommand: IUpdateReserva);
begin
  FCommandList.Add(ACommand);
end;

function TInvokerUpdateReserva.fExecutarItem: IInvokerUpdateReserva;
var
  LIdx: Integer;
begin
  For LIdx := 0 To Pred(FCommandList.Count) Do
    IUpdateReserva(
      FCommandList[LIdx]
    ).fExecutarItem();

  Result := Self;
end;

function TInvokerUpdateReserva.fExecutarLote: IInvokerUpdateReserva;
var
  LIdx: Integer;
begin
  For LIdx := 0 To Pred(FCommandList.Count) Do
    IUpdateReserva(
      FCommandList[LIdx]
    ).fExecutarLote();

  Result := Self;
end;

{ TAuditoriaReserva }

constructor TAuditoriaReserva.Create(AParametros: IReservaParametros);
begin
  FParametros := AParametros;
  FInvokerUpdate := TInvokerUpdateReserva.New();
  FCommandUpdateAnalitico := TStringList.Create();
  FCommandUpdateAnalitico.Clear;
end;

destructor TAuditoriaReserva.Destroy;
begin
  FCommandUpdateAnalitico.Free();
  inherited;
end;

function TAuditoriaReserva.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TAuditoriaReserva.fFoiExecutadaHoje: Boolean;
var
  qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear();
    qryGen.SQL.Add(sqlAuditExecuted);

    Try
      qryGen.ParamByName('CODITE').AsString := FParametros.CodigoItem();
      qryGen.ParamByName('CODEMP').AsString := FParametros.CodEmpresa();
      qryGen.Open();

      Result := ((qryGen.FieldByName('ITE_ULTAUD').AsDateTime = VS_Date) And
                 (qryGen.FieldByName('ITE_REPAUD').AsString = 'N'));
    Except
      On E: Exception Do
      Begin
      {$IFDEF LINUX}
        Raise Exception.Create('[fFoiExecutadaHoje] - ' + E.Message);
      {$ELSE }
        Result := False;
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
      End;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryGen);
  {$ENDIF LINUX}
  End;
end;

function TAuditoriaReserva.fLoteJafoiReprocessado(const AAutInc: string): Boolean;
begin
  Result := fCampoTabela('LOT_REPAUD', 'CADLOT', ['AUTOINCREM'], [AAutInc]) = 'N';
end;

function TAuditoriaReserva.fItemJafoiReprocessado(
  const AAutInc: string): Boolean;
begin
  Result := fCampoTabela('ITE_REPAUD', 'ITEGER', ['AUTOINCREM'], [AAutInc]) = 'N';
end;

function TAuditoriaReserva.fTemItensReprocessar(Const AEhLote: Boolean = False): Boolean;
var
  qryGen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear();
    qryGen.SQL.Add(IIF(AEhLote, sqlTemLoteRepAudit, sqlTemItemRepAudit));

    Try
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.Open();

      Result := (Not qryGen.IsEmpty);
    Except
      On E: Exception Do
      Begin
      {$IFDEF LINUX}
        Raise Exception.Create('[fTemItensReprocessar] - ' + E.Message);
      {$ELSE }
        Result := False;
        pMensagensErro(E.Message, '');
      {$ENDIF LINUX}
      End;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(qryGen);
  {$ENDIF LINUX}
  End;
end;

class function TAuditoriaReserva.New(AParametros: IReservaParametros = nil):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TAuditoriaReserva.Create(AParametros);
end;

procedure TAuditoriaReserva.pAuditoriaCadLot;
var
  LEnum: TTipoReservaSaldo;
begin
  { Auditoria da CADLOT }

  For LEnum := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
  Begin
    If (Not LEnum.fAtualiza()) Or
       (Not LEnum.fAtualizaLote()) Or
       (fEmptyStr(LEnum.fRetNomeCampo())) Then
      Continue;

    pVerify(TReservaParametros.New()
      .CodigoItem(FParametros.CodigoItem())
      .EmpresaItem(FParametros.EmpresaItem())
      .CodEmpresa(FParametros.fCodEmp())
      .NumeroLote(FParametros.NumeroLote())
      .EhAuditoria(True)
      .TipoReserva(LEnum)
      .EhReprocesso(FParametros.EhReprocesso()));
  End;
end;

{************************************************************************************************************************}
{****             AUDITA A ITEGER E PODE AUDITAR A CADLOT CASO O ROBÔ SEJA EXECUTADO SEM O PARÁMETRO -t.             ****}
{**** O PARÂMETRO -t INDICA SE O ROBÔ DEVE EXECUTAR O PROCESSO APENAS NA TABELA INFORMADA NELE (-tCADLOT / -tITEGER) ****}
{**** O PARÂMETRO -t VAZIO AUDITA CADLOT E ITEGER                                                                    ****}
{************************************************************************************************************************}
procedure TAuditoriaReserva.pAuditoriaIteGer;
var
  LQryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LEnum: TTipoReservaSaldo;
begin
  if not fExecutandoRoboCADLOT and not fExecutandoRoboITEGER then
  begin
    { Auditoria da CADLOT }
    LQryAux := fCriaQuery;
    Try
      LQryAux.SQL.Clear();
      LQryAux.SQL.Add(sqlCarregarLotes);

      If fExecutandoPeloPortal Then
        LQryAux.SQL.Add('AND FALSE');

      Try
        LQryAux.ParamByName('CODITE').AsString := FParametros.CodigoItem();
        LQryAux.ParamByName('CODEMP').AsString := FParametros.fCodEmp();
        LQryAux.Open();

        While (Not LQryAux.Eof) Do
        Begin
          For LEnum := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
          Begin
            If (Not LEnum.fAtualiza()) Or
               (Not LEnum.fAtualizaLote()) Or
               (fEmptyStr(LEnum.fRetNomeCampo())) Then
              Continue;

            pVerify(TReservaParametros.New()
              .CodigoItem(FParametros.CodigoItem())
              .EmpresaItem(FParametros.EmpresaItem())
              .CodEmpresa(FParametros.fCodEmp())
              .NumeroLote(LQryAux.FieldByName('LOT_NUMLOT').AsString)
              .EhAuditoria(True)
              .TipoReserva(LEnum)
              .EhReprocesso(FParametros.EhReprocesso()));
          End;

          LQryAux.Next();
        End;
      Except
        On E: Exception Do
        {$IFDEF LINUX}
          Raise Exception.Create('[pExecute] - ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '');
        {$ENDIF LINUX}
      End;
    Finally
      LQryAux.Close();
      LQryAux.SQL.Clear();
    End;

  end;

  { Auditoria da ITEGER }
  For LEnum := Low(TTipoReservaSaldo) To High(TTipoReservaSaldo) Do
  Begin
    If (Not LEnum.fAtualiza()) Or
       (fEmptyStr(LEnum.fRetNomeCampo())) Then
      Continue;

    pVerify(TReservaParametros.New()
      .CodigoItem(FParametros.CodigoItem())
      .EmpresaItem(FParametros.EmpresaItem())
      .CodEmpresa(FParametros.fCodEmp())
      .EhAuditoria(True)
      .TipoReserva(LEnum)
      .EhReprocesso(FParametros.EhReprocesso()));
  End;
end;

procedure TAuditoriaReserva.pExecute;
var
  LSQLAux: String;
  LQryAux: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpenedTransaction: Boolean;

  blnProcessaCadLot,
  blnProcessaIteGer : Boolean;
  LUsouBatchReprocessarSaldo: Boolean;
begin
  if not fExecutandoRoboCADLOT then
    If (Not FParametros.EhReprocesso()) and fFoiExecutadaHoje() Then
      Exit;

  blnProcessaCadLot := (FParametros.TabelaAudit = tblCadLot);
  blnProcessaIteGer := (FParametros.TabelaAudit = tblIteGer);

  If blnProcessaCadLot Then
    pAuditoriaCadLot
  Else If blnProcessaIteGer Then
    pAuditoriaIteGer;

  LQryAux := fCriaQuery;
  Try
    LOpenedTransaction := fInTransaction();

    If Not LOpenedTransaction Then
      fStartTransaction();

    Try
      If (FCommandUpdateAnalitico.Count > 0) Then
      Begin
        LSQLAux := FCommandUpdateAnalitico.Text;

        LUsouBatchReprocessarSaldo := False;
        If LOpenedTransaction And Assigned(fncUsouBatchReprocessarSaldo) Then
          LUsouBatchReprocessarSaldo := fncUsouBatchReprocessarSaldo(LSQLAux);

        If Not LUsouBatchReprocessarSaldo Then
        Begin
          LQryAux.Close();
          LQryAux.SQL.Text := fOtimizaInsertReplaceMultiValue(LSQLAux, []);
          LQryAux.ExecSQL();
        End;
      End;

      LQryAux.Close();
      LQryAux.SQL.Clear();

      If blnProcessaCadLot Then
      Begin
        FInvokerUpdate
          .fExecutarLote();

        LQryAux.SQL.Add(fNormalizeSQL(sqlUpdUltAdtLotes));
        LQryAux.ParamByName('CURRENT_DATE').AsDate := VS_Date;
        LQryAux.ParamByName('CODITE').AsString := FParametros.CodigoItem();
        LQryAux.ParamByName('NUMLOT').AsString := FParametros.NumeroLote();
        LQryAux.ParamByName('CODEMP').AsString := FParametros.CodEmpresa();
      End
      Else If blnProcessaIteGer Then
      Begin
        FInvokerUpdate.fExecutarItem();

        if not fExecutandoRoboCADLOT and not fExecutandoRoboITEGER then
          FInvokerUpdate.fExecutarLote();

        LQryAux.SQL.Add(fNormalizeSQL(sqlUpdUltAdtItens));
        LQryAux.ParamByName('CURRENT_DATE').AsDate := VS_Date;
        LQryAux.ParamByName('CODITE').AsString := FParametros.CodigoItem();
        LQryAux.ParamByName('CODEMP').AsString := FParametros.CodEmpresa();
      End;

      LQryAux.ExecSQL();

      If Not LOpenedTransaction Then
        fCommit();
    Except On E: Exception Do
      If Not LOpenedTransaction Then
        fRollBack();
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQryAux);
  {$ENDIF LINUX}
  End;
end;

procedure TAuditoriaReserva.pExecuteAll;
var
  LQueryCadLot: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LQueryIteGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQueryCadLot := fCriaQuery;
  LQueryIteGer := fCriaQuery;

  Try
    if fExecutandoRoboCADLOT then
    begin
      LQueryCadLot.SQL.Add(sqlLotesAudit);
      LQueryCadLot.SQL.Add('ORDER BY LOT_REPAUD DESC, LOT_NUMLOT ASC ');
      LQueryCadLot.SQL.Add(sqlLimit);
      LQueryCadLot.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQueryCadLot.Open();
      if not LQueryCadLot.IsEmpty then
        if LQueryCadLot.RecordCount < 10 then
          Sleep(Random(3000))
        else
          LQueryCadLot.RecNo := RandomRange(1, LQueryCadLot.RecordCount);
    end;

    While (Not LQueryCadLot.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      If (LQueryCadLot.FieldByName('LOT_REPAUD').AsString <> 'S') And fTemItensReprocessar(True) Then
        LQueryCadLot.Refresh;

      If LQueryCadLot.FieldByName('LOT_REPAUD').AsString.Equals('S') and fExecutandoRoboCADLOT and
         fLoteJafoiReprocessado(LQueryCadLot.FieldByName('AUTOINCREM').AsString) then
      begin
        LQueryCadLot.Next;
        Continue;
      end;

      TAuditoriaReserva.New(TReservaParametros.New()
          .NumeroLote(LQueryCadLot.FieldByName('LOT_NUMLOT').AsString)
          .CodigoItem(LQueryCadLot.FieldByName('LOT_CODITE').AsString)
          .EmpresaItem(VS_strCodEmp)
          .CodEmpresa(VS_strCodEmp)
          .EhReprocesso(LQueryCadLot.FieldByName('LOT_REPAUD').AsString = 'S')
          .TabelaAudit(tblCadLot)
        ).pExecute();

      If not fExecutandoRoboCADLOT and (LQueryCadLot.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorAudit, [VS_strCodEmp]));
        Sleep(Random(3000));
        {$IFNDEF LINUX}
        pTrimAppMemorySize();
        {$ENDIF LINUX}
      End;

      LQueryCadLot.Next();
    End;

    if not fExecutandoRoboCADLOT then
    begin
      LQueryIteGer.SQL.Add(sqlItensAudit);
      LQueryIteGer.SQL.Add('ORDER BY ITE_REPAUD DESC, ITE_CODITE ASC ');
      LQueryIteGer.SQL.Add(sqlLimit);
      LQueryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQueryIteGer.Open();
      if not LQueryIteGer.IsEmpty then
        if LQueryIteGer.RecordCount < 10 then
          Sleep(Random(3000))
        else
          LQueryIteGer.RecNo := RandomRange(1, LQueryIteGer.RecordCount);
    end;

    While (Not LQueryIteGer.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      If (LQueryIteGer.FieldByName('ITE_REPAUD').AsString <> 'S') And fTemItensReprocessar Then
        LQueryIteGer.Refresh;

      If LQueryIteGer.FieldByName('ITE_REPAUD').AsString.Equals('S') and fExecutandoRoboITEGER and
         fItemJafoiReprocessado(LQueryIteGer.FieldByName('AUTOINCREM').AsString) then
      begin
        LQueryIteGer.Next;
        Continue;
      end;

      TAuditoriaReserva.New(TReservaParametros.New()
          .CodigoItem(LQueryIteGer.FieldByName('ITE_CODITE').AsString)
          .EmpresaItem(VS_strCodEmp)
          .CodEmpresa(VS_strCodEmp)
          .EhReprocesso(LQueryIteGer.FieldByName('ITE_REPAUD').AsString = 'S')
          .TabelaAudit(tblIteGer)
        ).pExecute();

      If (LQueryIteGer.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorAudit, [VS_strCodEmp]));
        Sleep(Random(3000));
        {$IFNDEF LINUX}
        pTrimAppMemorySize();
        {$ENDIF LINUX}
      End;

      LQueryIteGer.Next();
    End;

  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQueryIteGer);
    FreeAndNil(LQueryCadLot);
  {$ENDIF LINUX}
  End;
end;

procedure TAuditoriaReserva.pVerify(AParametros: IReservaParametros);
var
  LQtdCalculada: Double;
  LQtdAtual: Double;
begin
  LQtdAtual := TSaldoReservado.New(AParametros).fGetQuantidade();

  AParametros.EhAtualizacao(True);
  AParametros.DesconsideraPedidosEnderecamento(True);

  LQtdCalculada := TSaldoReservado.New(AParametros).fGetQuantidade();

  FCommandUpdateAnalitico.Add(
    Format(sqlAtualizarReservaSaldoAnalitico,
          [AParametros.CodigoItem,
           AParametros.CodEmpresa,
           AParametros.TipoReserva.fRetNomeCampo,
           FormatDateTime('yyyy-MM-dd hh:mm:ss', VS_Date + fTime())]));

  If (LQtdAtual = LQtdCalculada) Then
    Exit;

  If fExecutandoPeloPortal Then
    Exit;

  FInvokerUpdate.pAdd(TUpdateReserva.New(AParametros));
end;

function fRetSQLPedidosOnda : String;
begin
  Result := IIF(fUsaOndaSeparacaoAgrupamento, sqlPedidosOndaSepAgrupamento, sqlPedidosOndaSep);
end;

initialization
  TSaldoReservado.CFG_SLRQPE := null;

end.
