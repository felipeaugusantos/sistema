unit untTFatEntregaFutura;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  Forms,
  CRAccess,
  untUtilMonitor,
{$ENDIF LINUX}
  TypInfo,
  Data.DB,
  System.Classes,
  untIFatEntregaFutura,
  Generics.Collections;

const
  spIdMonitorEntFut            = 'MONITOR_ENTFUT_%s';
  spIdInactivityMonitorEntFut  = 'TEST_INACTIVITY_ENTFUT_%s';
  spRecalculoEntregaFuturaExeName = 'RecalculoEntregaFuturaMonitor.exe';
  spTimeLimitMonitorEntFut     = 30;
  spAttemptsLimitMonitorEntFut = 100;
  spAttemptsLockMonitorEntFut  = 30;

  sNomeTabelaDocumentosPendentes = 'TMP_ENTFUT_%s_%s_%s_%s';

  cpoEntFutAgCliente = 'QTEF_A';
  cpoEntFutFaltaProd = 'QTEF_F';
  cpoEntFutPrevisao  = 'QTEF_P';
  cpoEntFutQtdPedBai = 'QTPDBF';

  sqlAuditExecutedEF = 'SELECT ITE_ULTAEF, ITE_REPAEF                         '+
                       '  FROM ITEGER                                         '+
                       'WHERE ITE_CODITE = :CODITE                            '+
                       '  AND ITE_CODEMP = :CODEMP                            ';

  sqlCarregarLotesEF = 'SELECT LOT_NUMLOT                                     '+
                       '  FROM CADLOT                                         '+
                       ' WHERE LOT_CODEMP = :CODEMP                           '+
                       '   AND LOT_CODITE = :CODITE                           ';

  sqlTemItemRepAudEF = 'SELECT                                                '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAEF                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_REPAEF = "S"                                '+
                       'LIMIT 1                                               ';

  sqlItensAuditEF    = 'SELECT                                                '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAEF                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_REPAEF = "S"                                '+
                       'UNION                                                 '+
                       'SELECT                                                '+
                       '  ITE_CODITE,                                         '+
                       '  ITE_REPAEF                                          '+
                       'FROM                                                  '+
                       '  ITEGER                                              '+
                       'WHERE ITE_CODEMP = :CODEMP                            '+
                       '  AND ITE_ULTAEF IS NULL                              ';

  sqlLimit           = 'LIMIT 50                                              ';

  sqlUpdUltAEF       = 'UPDATE ITEGER SET ITE_ULTAEF = :CURRENT_DATE,         '+
                       '  ITE_REPAEF = "N"                                    '+
                       'WHERE ITE_CODITE = :CODITE                            '+
                       '  AND ITE_CODEMP = :CODEMP;                           ';

  sqlCreateTabelaDocumentosPendentes =
                       ' CREATE TABLE %s (                                    '+
                       '   AUTINC VARCHAR(20) NOT NULL DEFAULT "",            '+
                       '   TABELA VARCHAR(06) NOT NULL DEFAULT "",            '+
                       '   CODITE VARCHAR(07) NOT NULL DEFAULT "",            '+
                       '   CODEMP VARCHAR(03) NOT NULL DEFAULT "",            '+
                       '   QTDPEN DECIMAL(14,4) DEFAULT 0.0000,               '+
                       '   KEY AUTINC (AUTINC),                               '+
                       '   KEY TABELA (TABELA),                               '+
                       '   KEY CODITE (CODITE),                               '+
                       '   KEY CODEMP (CODEMP)                                '+
                       ' ) ENGINE=MEMORY DEFAULT CHARSET=LATIN1               ';

type
  TTipoEntregaFuturaHelper = record helper for TTipoEntregaFutura
  public
    function getId: String;
    function Update: Boolean;
    function getField: String;
    function getSQLIn: String;
    function getTempTableName: String;
    function getDescricao: String;
  end;

  TTipoTravaEstoqueHelper = record helper for TTipoTravaEstoque
  public
    function getSQLIn: String;
  end;

  TSqlEF = class sealed(TInterfacedObject, ISqlEF)
  private
    FParams: IParamEF;
  protected
    constructor Create(AParams: IParamEF);

    function SQLCampos: String;
    function SQLEFCampos: String;
    function SQLTemporaria: String;
    function EfBaixExiste: Boolean;
    function InformouLote: Boolean;
    function InformouLotes: Boolean;
    function SQLEFCalculado: String;
    function InformouCliente: Boolean;
    function InformouEmpresa: Boolean;
    function InformouProduto: Boolean;
    function SQLTemporariaTinta: String;
    function SQLJoinsTemporaria: String;
    function SQLWhereTemporaria: String;
    function FiltrarPorMotivoEF: Boolean;
    function SQLCamposTemporaria: String;
    function UtilizaMaquinaTinta: Boolean;
    function SQLGroupByTemporaria: String;
    function SaldoEstoqueParaTrava: String;
    function QuantidadeFuturaPedido: String;
    function SQLJoinsTemporariaTinta: String;
    function SQLWhereTemporariaTinta: String;
    function SQLCamposTemporariaTinta: String;
    function SQLGroupByTemporariaTinta: String;
    function fObterQuantidadeViaSelect: Boolean;
    function BaixarEstoqueEFUtilizandoTriggers: Boolean;
    function ListarSubProdutosNaBaixaDoDocumentoDeVenda: Boolean;
  public
    function Build: String;

    class function New(AParams: IParamEF): ISqlEF;
    class function SQLJoinEFPedido(const AAlias: String = 'D'; ATelaBaixaEntregaFutura: Boolean = False): String;
    class function fUsaPedidosDeBaixaEntregaFutura: Boolean;
  end;

  TParamEF = class sealed(TInterfacedObject, IParamEF)
  private
    FLote: String;
    FLotes: String;
    FCodIte: String;
    FCodEmp: String;
    FPorLote: Boolean;
    FPorVenda: Boolean;
    FAuditoria: Boolean;
    FReprocesso: Boolean;
    FConverteML: Boolean;
    FAtualizacao: Boolean;
    FFaturamento: Boolean;
    FTipoTE: TTipoTravaEstoque;
    FTipoEF: TTipoEntregaFutura;
    FCalculaQtdPendente: Boolean;
    FCodCli: String;
  protected
    constructor Create;
  public
    function Lote(const AValue: String): IParamEF; overload;
    function Lotes(const AValue: String): IParamEF; overload;
    function CodIte(const AValue: String): IParamEF; overload;
    function CodEmp(const AValue: String): IParamEF; overload;
    function PorLote(const AValue: Boolean): IParamEF; overload;
    function PorVenda(const AValue: Boolean): IParamEF; overload;
    function Auditoria(const AValue: Boolean): IParamEF; overload;
    function Reprocesso(Const AValue: Boolean): IParamEF; Overload;
    function ConverteML(const AValue: Boolean): IParamEF; overload;
    function Atualizacao(const AValue: Boolean): IParamEF; overload;
    function Faturamento(const AValue: Boolean): IParamEF; overload;
    function TipoTE(const AValue: TTipoTravaEstoque): IParamEF; overload;
    function TipoEF(const AValue: TTipoEntregaFutura): IParamEF; overload;
    function CalculaQtdPendente(const AValue: Boolean): IParamEF; overload;
    function CodCli(const AValue: String): IParamEF; overload;

    function Lote: String; overload;
    function Lotes: String; overload;
    function CodIte: String; overload;
    function CodEmp: String; overload;
    function PorLote: Boolean; overload;
    function PorVenda: Boolean; overload;
    function Auditoria: Boolean; overload;
    function Reprocesso: Boolean; overload;
    function ConverteML: Boolean; overload;
    function Atualizacao: Boolean; overload;
    function Faturamento: Boolean; overload;
    function TipoTE: TTipoTravaEstoque; overload;
    function TipoEF: TTipoEntregaFutura; overload;
    function CalculaQtdPendente: Boolean; overload;
    function CodCli: String; overload;

    class function New: IParamEF;
  end;

  TEntregaFutura = class sealed(TInterfacedObject, IEntregaFutura)
  private
    FParams: IParamEF;
  protected
    constructor Create(AParams: IParamEF);

    function getTotal: Double;
    function SaldoEstoqueParaTrava: String;
    function fGerarTabelaComDocumentosPendentes(ATabela: String = '';
      ASomenteEstrutura: Boolean = False): String;
    function fDefinirNomeTemporariaDocumentosPendentes: String;
    function fCalcularQuantidadePendente(AQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}): Double;
    procedure pDefineParametrosTipoAutomatica;
  public
    function Total: Double;
    function fGetTabelaDocumentos(ATabela: String = '';
                                  ASomenteEstrutura: Boolean = False): String;

    class function New(AParams: IParamEF): IEntregaFutura;
  end;

  TUpdateEF = class sealed(TInterfacedObject, IUpdateEF)
  private
    FParams: IParamEF;
  protected
    procedure Item;
    procedure Lote;

    constructor Create(AParams: IParamEF);

    function UpdateAll: Boolean;
    function InformouLote: Boolean;
    function BuildSQL(const ALote: Boolean = False): String;
    function ExecuteUpdate(const AOpc: TTipoEntregaFutura): Boolean;
  public
    procedure Execute;

    class function New(AParams: IParamEF): IUpdateEF;
  end;

  TInvokerUpdateEF = class sealed(TInterfacedObject, IInvokerUpdateEF)
  private
    FCommandList: TInterfaceList;

    constructor Create;
  public
    destructor Destroy; Override;

    procedure Add(ACommand: IUpdateEF);
    procedure Execute;

    class function New: IInvokerUpdateEF;
  end;

  TAuditoriaEF = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  protected
    FParams: IParamEF;
    FInvoker: IInvokerUpdateEF;
    FCommandInsert: TStringList;

    constructor Create(AParams: IParamEF);

    function HaveToReprocess: Boolean;
    function ExecutedToday: Boolean;
    procedure Verify(AParams: IParamEF);
  public
    destructor Destroy; Override;

    procedure pExecute;
    procedure pExecuteAll;
    function fExecute: TResultExecute;

    class function New(AParams: IParamEF = nil):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
  end;

implementation

uses
{$IFDEF LINUX}
  
{$ELSE }
  untFuncoesSimples,
  untSeqTmp,
{$ENDIF LINUX}
  System.SysUtils,
  System.StrUtils,
  System.DateUtils,
  System.Math,
  Shared.Functions.Monitores;

{ TTipoEntregaFuturaHelper }

function TTipoEntregaFuturaHelper.getId: String;
begin
  Result := fStrZero(Ord(Self), 3);
end;

function TTipoEntregaFuturaHelper.getTempTableName: String;
begin
  Case Self Of
    tefPrevisao:
      Result := 'PREVISAO_ENTREGA';
    tefFaltaDeProduto:
      Result := 'FALTA_PRODUTO';
    tefAguardandoCliente:
      Result := 'AGUARDANDO_CLIENTE';
    tefPedidoBaixaEntregaFutura:  
      Result := 'PEDIDO_BAIXA_ENTREGA_FUTURA'  
  Else
    Result := '';
  End;
end;

function TTipoEntregaFuturaHelper.getDescricao: String;
begin
  Case Self Of
    tefAguardandoCliente:
      Result := 'AGUARDANDO CLIENTE';
    tefFaltaDeProduto:
      Result := 'FALTA DE PRODUTO';
    tefPrevisao:
      Result := 'PREVISAO DE ENTREGA';
    tefPedidoBaixaEntregaFutura:  
      Result := 'PEDIDO BAIXA ENTREGA FUTURA'  
  Else
    Result := '';
  End;
end;

function TTipoEntregaFuturaHelper.getField: String;
begin
  Case Self Of
    tefAguardandoCliente:
      Result := cpoEntFutAgCliente;
    tefFaltaDeProduto:
      Result := cpoEntFutFaltaProd;
    tefPrevisao:
      Result := cpoEntFutPrevisao;
    tefPedidoBaixaEntregaFutura:  
      Result := cpoEntFutQtdPedBai  
  Else
    Result := '';
  End;
end;

function TTipoEntregaFuturaHelper.getSQLIn: String;
begin
  Case Self Of
    tefPrevisao:
      Result := QuotedStr('P');
    tefFaltaDeProduto:
      Result := QuotedStr('F');
    tefAguardandoCliente:
      Result := QuotedStr('A');
  Else
    Result := '';
  End;
end;

function TTipoEntregaFuturaHelper.Update: Boolean;
begin
  Case Self Of
    tefTodos: Result := False;
    tefPedidoBaixaEntregaFutura: Result := False;
  Else
    Result := True;
  End;
end;

{ TSqlEF }

function TSqlEF.BaixarEstoqueEFUtilizandoTriggers: Boolean;
begin
  Result := fCfgSis('BEFTRG', VarBoolean);
end;

function TSqlEF.Build: String;
Var
  LInfo: String;
begin
  LInfo := FParams.TipoEF().getDescricao + ' (' + FParams.TipoEF().getField + ')';

  If fObterQuantidadeViaSelect() Then
    Result := SQLEFCalculado()
  Else
    Result := SQLEFCampos();

 {$IFNDEF LINUX}
  If fObterQuantidadeViaSelect() Then
    Result := '/* ENTREGA FUTURA PENDENTE ' + LInfo + ': */' + Result;
 {$ENDIF LINUX}
end;

constructor TSqlEF.Create(AParams: IParamEF);
begin
  FParams := AParams;
end;

function TSqlEF.EfBaixExiste: Boolean;
begin
  Result := fCampoExiste('MOVDET', 'DET_EFBAIX', True);
end;

function TSqlEF.FiltrarPorMotivoEF: Boolean;
begin
  Result := (Not fEmptyStr(FParams.TipoEF.getSQLIn())) Or
            (Not fEmptyStr(FParams.TipoTE.getSQLIn()));
end;

function TSqlEF.fObterQuantidadeViaSelect: Boolean;
begin
  Result := ((Not fCfgSis('UTIEFU', varBoolean)) And (Not FParams.Auditoria())) Or
            FParams.Atualizacao();

  If Not fEmptyStr(FParams.CodCli()) Then
    Result := True;

  If FParams.PorVenda() Then
    Result := True;
end;

class function TSqlEF.fUsaPedidosDeBaixaEntregaFutura: Boolean;
begin
  Result := AnsiMatchText(fCfgSis('PEDBEF', varString), ['S', 'P']);
end;

function TSqlEF.InformouCliente: Boolean;
begin
  Result := Not fEmptyStr(FParams.CodCli());
end;

function TSqlEF.InformouEmpresa: Boolean;
begin
  Result := Not fEmptyStr(FParams.CodEmp());
end;

function TSqlEF.InformouLote: Boolean;
begin
  Result := (Not fEmptyStr(FParams.Lote()));
end;

function TSqlEF.InformouLotes: Boolean;
begin
  Result := (Not fEmptyStr(FParams.Lotes())) And
            (Not FParams.Lotes().Equals(QuotedStr('')));
end;

function TSqlEF.InformouProduto: Boolean;
begin
  Result := Not fEmptyStr(FParams.CodIte());
end;

function TSqlEF.ListarSubProdutosNaBaixaDoDocumentoDeVenda: Boolean;
begin
  Result := fCfgSis('EFTEST', VarString) = '2';
end;

class function TSqlEF.New(AParams: IParamEF): ISqlEF;
begin
  Result := TSqlEF.Create(AParams);
end;

function TSqlEF.QuantidadeFuturaPedido: String;
begin
  Result := ' 0 ';
  If fUsaPedidosDeBaixaEntregaFutura() Then
  Begin
    If (SaldoEstoqueParaTrava() <> '2') Then
      Result := ' IFNULL(QTDFUT,0) ';
  end;
end;

function TSqlEF.SaldoEstoqueParaTrava: String;
begin
  Result := fCfgSis('CALSAL', varString);
end;

function TSqlEF.SQLCampos: String;
begin
  Result := '';
  Result := Concat(Result, 'DET_CODITE, ');

  If FParams.PorLote() Then
    Result := Concat(Result, 'DET_NUMLOT, ');

  If FParams.PorVenda() Then
    Result := Concat(Result, ' TBL.AUTOINCREM, ');

  Result := Concat(Result, 'DET_CODEMP, ');
  Result := Concat(Result, 'IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML) AS CNV_ML, ');

  If FParams.CalculaQtdPendente() Then
  Begin
    Result := Concat(Result, 'SUM(IFNULL(QTDPEN,0) * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)) AS QTDPEN, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEA,0) * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)) AS QTDPEA, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEF,0) * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)) AS QTDPEF, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEP,0) * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)) AS QTDPEP  ');
  End
  Else
  Begin
    Result := Concat(Result, 'SUM(IFNULL(QTDPEN, 0))AS QTDPEN, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEA, 0))AS QTDPEA, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEF, 0))AS QTDPEF, ');
    Result := Concat(Result, 'SUM(IFNULL(QTDPEP, 0))AS QTDPEP  ');
  End;
end;

function TSqlEF.SQLCamposTemporaria: String;
begin
  Result := '';
  Result := Concat(Result, '  DET_CODITE, ');

  If FParams.PorLote() Then
    Result := Concat(Result, '  DET_NUMLOT, ');

  If FParams.PorVenda() Then
    Result := Concat(Result, ' D.AUTOINCREM, ');

  Result := Concat(Result, '  DET_CODEMP, ');
  Result := Concat(Result, '  0 AS CNV_ML, ');

  Result := Concat(Result, '  SUM(IFNULL(ROUND(IFNULL(DET_QTDITE,0) - (IFNULL(DET_QTDENT,0) + ' + QuantidadeFuturaPedido() + '),4),0)) AS QTDPEN, ');

  Result := Concat(Result, '  SUM(IF(DET_MOTFUT = "A", IFNULL(ROUND(IFNULL(DET_QTDITE,0) - (IFNULL(DET_QTDENT,0) + ' + QuantidadeFuturaPedido() + '),4),0),0)) AS QTDPEA, ');
  Result := Concat(Result, '  SUM(IF(DET_MOTFUT = "F", IFNULL(ROUND(IFNULL(DET_QTDITE,0) - (IFNULL(DET_QTDENT,0) + ' + QuantidadeFuturaPedido() + '),4),0),0)) AS QTDPEF, ');
  Result := Concat(Result, '  SUM(IF(DET_MOTFUT = "P", IFNULL(ROUND(IFNULL(DET_QTDITE,0) - (IFNULL(DET_QTDENT,0) + ' + QuantidadeFuturaPedido() + '),4),0),0)) AS QTDPEP  ');
end;

function TSqlEF.SQLCamposTemporariaTinta: String;
begin
  Result := '';
  Result := Concat(Result, '  COL.DET_CODITE, ');

  If FParams.PorLote() Then
    Result := Concat(Result, '  DET.DET_NUMLOT, ');

  If FParams.PorVenda() Then
    Result := Concat(Result, ' DET.AUTOINCREM, ');

  Result := Concat(Result, '  COL.DET_CODEMP, ');
  Result := Concat(Result, '  ITE.ITE_CNV_ML, ');

  Result := Concat(Result, '  SUM(COL.DET_QTDITE * (1 - IFNULL((DET.DET_QTDENT + ', QuantidadeFuturaPedido(), ') / DET.DET_QTDITE,0) ) / IF(IFNULL(ITE.ITE_CNV_ML,0) > 0,ITE.ITE_CNV_ML,1)) AS QTDPEN, ');

  Result := Concat(Result, '  SUM(IF(DET.DET_MOTFUT = "A",COL.DET_QTDITE * (1 - IFNULL((DET.DET_QTDENT + ', QuantidadeFuturaPedido(), ') / DET.DET_QTDITE,0)) / IF(IFNULL(ITE.ITE_CNV_ML,0) > 0,ITE.ITE_CNV_ML,1),0)) AS QTDPEA, ');
  Result := Concat(Result, '  SUM(IF(DET.DET_MOTFUT = "F",COL.DET_QTDITE * (1 - IFNULL((DET.DET_QTDENT + ', QuantidadeFuturaPedido(), ') / DET.DET_QTDITE,0)) / IF(IFNULL(ITE.ITE_CNV_ML,0) > 0,ITE.ITE_CNV_ML,1),0)) AS QTDPEF, ');
  Result := Concat(Result, '  SUM(IF(DET.DET_MOTFUT = "P",COL.DET_QTDITE * (1 - IFNULL((DET.DET_QTDENT + ', QuantidadeFuturaPedido(), ') / DET.DET_QTDITE,0)) / IF(IFNULL(ITE.ITE_CNV_ML,0) > 0,ITE.ITE_CNV_ML,1),0)) AS QTDPEP  ');
end;

function TSqlEF.SQLEFCalculado: String;
begin
  Result := 'SELECT SQL_NO_CACHE ';
  Result := Concat(Result, SQLCampos());
  Result := Concat(Result, ' FROM (');
  Result := Concat(Result, SQLTemporaria());

  If UtilizaMaquinaTinta() Then
  Begin
    Result := Concat(Result, ' UNION ALL ');
    Result := Concat(Result, SQLTemporariaTinta());
  End;

  Result := Concat(Result, ') AS TBL ');
  Result := Concat(Result, 'INNER JOIN CADITE ON ITE_CODITE = DET_CODITE ');
  Result := Concat(Result, 'GROUP BY DET_CODITE ');

  If FParams.PorLote() Then
    Result := concat(Result, ', DET_NUMLOT ');

  If FParams.PorVenda() Then
    Result := Concat(Result, ', TBL.AUTOINCREM ');

  If InformouEmpresa() Then
    Result := Concat(Result, ', DET_CODEMP ');
end;

function TSqlEF.SQLEFCampos: String;
var
  LPre: String;
  LTab: String;
  LGroup: String;
begin
  LTab := IIF(InformouLote() Or InformouLotes(), 'CADLOT', 'ITEGER');
  LPre := IIF(InformouLote() Or InformouLotes(), 'LOT_'  , 'ITE_'  );


  Result := 'SELECT ';
  Result := Concat(Result, 'IF(IFNULL(C.ITE_CNV_ML,0) <= 0,1,C.ITE_CNV_ML) AS CNV_ML,');

  Case FParams.TipoTE() Of
    tteTodas:
      Result := Concat(Result, 'SUM(', '(',
                                       LPre, tefPedidoBaixaEntregaFutura.getField(), ' + ',
                                       LPre, tefPrevisao.getField(), ' + ',
                                       LPre, tefFaltaDeProduto.getField(), ' + ',
                                       LPre, tefAguardandoCliente.getField(),
                                       ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                       ') AS QTDPEN ');
    tteFaltaDeProduto:
      Result := Concat(Result, 'SUM(', '(',
                                       LPre, tefPedidoBaixaEntregaFutura.getField(), ' + ',
                                       LPre, tefFaltaDeProduto.getField(),
                                       ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                       ') AS QTDPEN ');
    tteAguardandoClienteEPrevisao:
      Result := Concat(Result, 'SUM(', '(',
                                       LPre, tefPedidoBaixaEntregaFutura.getField(), ' + ',
                                       LPre, tefPrevisao.getField(), ' + ',
                                       LPre, tefAguardandoCliente.getField(),
                                       ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                       ') AS QTDPEN ');
    tteAguardandoClienteEFaltaDeProduto:
      Result := Concat(Result, 'SUM(', '(',
                                       LPre, tefPedidoBaixaEntregaFutura.getField(), ' + ',
                                       LPre, tefFaltaDeProduto.getField(), ' + ',
                                       LPre, tefAguardandoCliente.getField(),
                                       ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                       ') AS QTDPEN ');
  Else
    Case FParams.TipoEF() Of
      tefTodos:
        Result := Concat(Result, 'SUM(', '(',
                                         LPre, tefPedidoBaixaEntregaFutura.getField(), ' + ',
                                         LPre, tefPrevisao.getField(), ' + ',
                                         LPre, tefFaltaDeProduto.getField(), ' + ',
                                         LPre, tefAguardandoCliente.getField(),
                                         ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                         ') AS QTDPEN ');
    Else
      Result := Concat(Result, 'SUM(', '(',
                                       LPre, FParams.TipoEF.getField(),
                                       ') * IF(IFNULL(ITE_CNV_ML,0) <= 0,1,ITE_CNV_ML)',
                                       ') AS QTDPEN ');
    End;
  End;

  Result := Concat(Result, 'FROM ', LTab, ' ');
  Result := Concat(Result, 'INNER JOIN CADITE C ON C.ITE_CODITE = ', LTab, '.', LPre, 'CODITE ');
  Result := Concat(Result, 'WHERE TRUE ');

  If InformouEmpresa() Then
    Result := Concat(Result, 'AND ', LTab, '.', LPre, 'CODEMP = ', QuotedStr(FParams.CodEmp()), ' ');

  If InformouProduto() Then
    Result := Concat(Result, 'AND ', LTab, '.', LPre, 'CODITE = ', QuotedStr(FParams.CodIte()), ' ');

  If InformouLote() Then
    Result := Concat(Result, 'AND LOT_NUMLOT = ', QuotedStr(FParams.Lote()), ' ');

  If InformouLotes() Then
    Result := Concat(Result, 'AND LOT_NUMLOT IN ( ', FParams.Lotes(), ') ');

  If (InformouProduto() Or InformouEmpresa()) Then
  Begin
    LGroup := '';
    If InformouProduto() Then
      LGroup := Concat(LGroup, IfThen(LGroup = '', '', ', '), LTab, '.', LPre, 'CODITE ');

    If InformouEmpresa() Then
      LGroup := Concat(LGroup, IfThen(LGroup = '', '', ', '), LTab, '.', LPre, 'CODEMP ');

    If LGroup <> '' Then
      Result := Concat(Result, 'GROUP BY ', LGroup);
  End;
end;

class function TSqlEF.SQLJoinEFPedido(const AAlias: String = 'D'; ATelaBaixaEntregaFutura: Boolean = False): String;
begin
  Result := '';

  If fUsaPedidosDeBaixaEntregaFutura Then
  Begin
    Result := Concat(Result, 'LEFT JOIN ( ');
    Result := Concat(Result, '  SELECT ');
    Result := Concat(Result, '    SUM(F.FDO_QTDITE'+IIF(ATelaBaixaEntregaFutura,' - IFNULL(F.FDO_QTDBAI, 0)','')+') AS QTDFUT, ');
    Result := Concat(Result, '    E.FDO_INCFUT, ');
    Result := Concat(Result, '    F.FDO_CODITE  ');
    Result := Concat(Result, '  FROM FATDOR F ');
    Result := Concat(Result, '  INNER JOIN EXTDOR E ON F.AUTOINCREM = E.FDO_SEQFDO ');

    Result := Concat(Result, '  WHERE F.FDO_JAFATU = 0 AND E.FDO_INCFUT IS NOT NULL AND F.FDO_ESPDOC = "PD" ');

    Result := Concat(Result, '  GROUP BY E.FDO_INCFUT');
    Result := Concat(Result, ') AS ENTFUT ON ', AAlias, '.AUTOINCREM = ENTFUT.FDO_INCFUT ');
  End;

end;

function TSqlEF.SQLJoinsTemporaria: String;
begin
  Result := '';
  Result := Concat(Result, SQLJoinEFPedido('D'));
  Result := Concat(Result, 'INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER ');
end;

function TSqlEF.SQLJoinsTemporariaTinta: String;
begin
  Result := '';
  Result := Concat(Result, SQLJoinEFPedido('DET'));
  Result := Concat(Result, 'INNER JOIN MOVTRI TRI ON DET.AUTOINCREM = TRI.DET_SEQGER ');
  Result := Concat(Result, 'INNER JOIN MOVDET COL ON DET.DET_CODACA = COL.DET_CODACA ');
  Result := Concat(Result, '                     AND DET.DET_EMPACA = COL.DET_EMPACA ');
  Result := Concat(Result, '                     AND DET.DET_NUMDOC = COL.DET_NUMFAT ');
  Result := Concat(Result, '                     AND DET.DET_ESPDOC = COL.DET_TIPFAT ');
  Result := Concat(Result, '                     AND DET.DET_CODEMP = COL.DET_EMPFAT ');
  Result := Concat(Result, '                     AND DET.DET_CODCLI = COL.DET_CODCLI ');

  Result := Concat(Result, 'INNER JOIN CADITE ITE ON ITE.ITE_CODITE = COL.DET_CODITE ');
end;

function TSqlEF.SQLGroupByTemporaria: String;
begin
  Result := 'GROUP BY DET_CODITE ';

  If FParams.PorLote() Then
    Result := Concat(Result, ', DET_NUMLOT ');

  If FParams.PorVenda() Then
    Result := Concat(Result, ', D.AUTOINCREM ');

  If InformouEmpresa() Then
    Result := Concat(Result, ', DET_CODEMP ');
end;

function TSqlEF.SQLGroupByTemporariaTinta: String;
begin
  Result := 'GROUP BY COL.DET_CODITE ';

  If FParams.PorVenda() Then
    Result := Concat(Result, ', DET.AUTOINCREM ');

  If InformouEmpresa() Then
    Result := Concat(Result, ', COL.DET_CODEMP ');
end;

function TSqlEF.SQLTemporaria: String;
begin
  Result := 'SELECT ';
  Result := Concat(Result, SQLCamposTemporaria());
  Result := Concat(Result, '  FROM MOVDET D ');
  Result := Concat(Result, SQLJoinsTemporaria());
  Result := Concat(Result, SQLWhereTemporaria());
  Result := Concat(Result, SQLGroupByTemporaria());
end;

function TSqlEF.SQLTemporariaTinta: String;
begin
  Result := 'SELECT ';
  Result := Concat(Result, SQLCamposTemporariaTinta());
  Result := Concat(Result, '  FROM MOVDET DET ');
  Result := Concat(Result, SQLJoinsTemporariaTinta());
  Result := Concat(Result, SQLWhereTemporariaTinta());
  Result := Concat(Result, SQLGroupByTemporariaTinta());
end;

function TSqlEF.SQLWhereTemporaria: String;
begin
  Result := 'WHERE ';

  If EfBaixExiste() Then
    Result := Concat(Result, 'DET_EFBAIX = "N" AND ');

  If (FiltrarPorMotivoEF()) Then
  Begin
    If (fEmptyStr(FParams.TipoTE.getSQLIn())) Then
      Result := Concat(Result, 'DET_MOTFUT IN (', FParams.TipoEF.getSQLIn(), ') AND ')
    Else
      Result := Concat(Result, 'DET_MOTFUT IN (', FParams.TipoTE.getSQLIn(), ') AND ');
  End;

  Result := Concat(Result, 'DET_ENTFUT = "S" AND ');

  If ListarSubProdutosNaBaixaDoDocumentoDeVenda() Then
  Begin
    Result := Concat(Result, '(DET_PROEMB <> "S" OR DET_BXSBIT = "S") AND ');
    Result := Concat(Result, '(DET_FILKAR = 0) AND ');
  End
  Else
    Result := Concat(Result, 'DET_PROEMB <> "S" AND ');

  If (Not BaixarEstoqueEFUtilizandoTriggers()) Then
    Result := Concat(Result, 'IFNULL(DET_FILKAR,0) = 0 AND ');

  Result := Concat(Result, '(DET_ESPDOC NOT IN ("ML", "PR", "TM", "EP")) AND ');
  Result := Concat(Result, 'IFNULL(ROUND(IFNULL(DET_QTDITE,0) - (IFNULL(DET_QTDENT,0) + ', QuantidadeFuturaPedido(), '),4),0) > 0 ');

  If InformouEmpresa() Then
    Result := Concat(Result, 'AND DET_CODEMP = ', QuotedStr(FParams.CodEmp()), ' ');

  If InformouProduto() Then
    Result := Concat(Result, 'AND DET_CODITE = ', QuotedStr(FParams.CodIte()), ' ');

  If InformouLote() Then
    Result := Concat(Result, 'AND DET_NUMLOT = ', QuotedStr(FParams.Lote()), ' ');

  If InformouLotes() Then
    Result := Concat(Result, 'AND DET_NUMLOT IN ( ', FParams.Lotes(), ') ');

  If InformouCliente() Then
    Result := Concat(Result, 'AND DET_CODCLI = ', QuotedStr(FParams.CodCli()), ' ');

end;

function TSqlEF.SQLWhereTemporariaTinta: String;
begin
  Result := 'WHERE ';
  Result := Concat(Result, 'DET.DET_TIP_FC = "C" AND ');
  Result := Concat(Result, 'DET.DET_ENTFUT = "S" AND ');
  Result := Concat(Result, 'DET.DET_ESPDOC NOT IN ("ML", "PR", "TM") AND ');
  Result := Concat(Result, 'COL.DET_ESPDOC = "ML" AND ');

  If (FiltrarPorMotivoEF()) Then
  Begin
    If (fEmptyStr(FParams.TipoTE.getSQLIn())) Then
      Result := Concat(Result, 'DET.DET_MOTFUT IN (', FParams.TipoEF.getSQLIn(), ') AND ')
    Else
      Result := Concat(Result, 'DET.DET_MOTFUT IN (', FParams.TipoTE.getSQLIn(), ') AND ');
  End;

  If ListarSubProdutosNaBaixaDoDocumentoDeVenda() Then
  Begin
    Result := Concat(Result, '(DET.DET_PROEMB <> "S" OR TRI.DET_BXSBIT = "S") AND ');
    Result := Concat(Result, '(DET.DET_FILKAR = 0) AND ');
  End
  Else
    Result := Concat(Result, 'DET.DET_PROEMB <> "S" AND ');

  Result := Concat(Result, 'DET.DET_IDEPRO <> "NOR" AND ');

  If (Not BaixarEstoqueEFUtilizandoTriggers()) Then
    Result := Concat(Result, 'IFNULL(COL.DET_FILKAR,0) = 0 AND ');

  Result := Concat(Result, 'IFNULL(COL.DET_QTDITE * (1 - IFNULL((DET.DET_QTDENT + ', QuantidadeFuturaPedido(), ') / DET.DET_QTDITE,0)) / IF(IFNULL(ITE.ITE_CNV_ML,0) > 0,ITE.ITE_CNV_ML,1),0) > 0 ');

  If EfBaixExiste() Then
    Result := Concat(Result, 'AND DET.DET_EFBAIX = "N" ');

  If InformouProduto() Then
    Result := Concat(Result, 'AND COL.DET_CODITE = ', QuotedStr(FParams.CodIte()), ' ');

  If InformouEmpresa() Then
    Result := Concat(Result, ' AND COL.DET_CODEMP = ', QuotedStr(FParams.CodEmp()), ' ');

  If InformouLote() Then
    Result := Concat(Result, ' AND COL.DET_NUMLOT = ', QuotedStr(FParams.Lote()), ' ');

  If InformouLotes() Then
    Result := Concat(Result, ' AND COL.DET_NUMLOT IN ( ', FParams.Lotes(), ') ');

  If InformouCliente() Then
    Result := Concat(Result, 'AND DET.DET_CODCLI = ', QuotedStr(FParams.CodCli()), ' ');

end;

function TSqlEF.UtilizaMaquinaTinta: Boolean;
begin
  Result := fCfgSis('USATMQ', varBoolean);
end;

{ TParamEF }

function TParamEF.CodEmp(const AValue: String): IParamEF;
begin
  Result := Self;
  FCodEmp := AValue;
end;

function TParamEF.CalculaQtdPendente(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FCalculaQtdPendente := AValue;
end;

function TParamEF.Atualizacao(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FAtualizacao := AValue;
end;

function TParamEF.Atualizacao: Boolean;
begin
  Result := FAtualizacao;
end;

function TParamEF.Auditoria(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FAuditoria := AValue;
end;

function TParamEF.Auditoria: Boolean;
begin
  Result := FAuditoria;
end;

function TParamEF.CalculaQtdPendente: Boolean;
begin
  Result := FCalculaQtdPendente;
end;

function TParamEF.CodCli(const AValue: String): IParamEF;
begin
  Result  := Self;
  FCodCli := AValue;
end;

function TParamEF.CodCli: String;
begin
  Result := FCodCli;
end;

function TParamEF.CodEmp: String;
begin
  Result := FCodEmp;
end;

function TParamEF.CodIte(const AValue: String): IParamEF;
begin
  Result := Self;
  FCodIte := AValue;
end;

function TParamEF.CodIte: String;
begin
  Result := FCodIte;
end;

function TParamEF.ConverteML(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FConverteML := AValue;
end;

function TParamEF.ConverteML: Boolean;
begin
  Result := FConverteML;
end;

constructor TParamEF.Create;
begin
  FLotes := '';
  FCodIte := '';
  FCodEmp := '';
  FPorLote := False;
  FPorVenda := False;
  FAuditoria := False;
  FReprocesso := False;
  FConverteML := False;
  FAtualizacao := False;
  FFaturamento := False;
  FTipoEF := tefTodos;
  FTipoTE := tteAutomatica;
  FCalculaQtdPendente := True;
  FCodCli := '';
end;

function TParamEF.Faturamento: Boolean;
begin
  Result := FFaturamento;
end;

function TParamEF.Faturamento(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FFaturamento := AValue;
end;

class function TParamEF.New: IParamEF;
begin
  Result := TParamEF.Create();
end;

function TParamEF.PorLote(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FPorLote := AValue;
end;

function TParamEF.PorLote: Boolean;
begin
  Result := FPorLote;
end;

function TParamEF.PorVenda(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FPorVenda := AValue;
end;

function TParamEF.PorVenda: Boolean;
begin
  Result := FPorVenda;
end;

function TParamEF.Reprocesso(const AValue: Boolean): IParamEF;
begin
  Result := Self;
  FReprocesso := AValue;
end;

function TParamEF.Reprocesso: Boolean;
begin
  Result := FReprocesso;
end;

function TParamEF.TipoEF: TTipoEntregaFutura;
begin
  Result := FTipoEF;
end;

function TParamEF.TipoTE(const AValue: TTipoTravaEstoque): IParamEF;
begin
  Result := Self;
  FTipoTE := AValue;
end;

function TParamEF.TipoTE: TTipoTravaEstoque;
begin
  Result := FTipoTE;
end;

function TParamEF.TipoEF(const AValue: TTipoEntregaFutura): IParamEF;
begin
  Result := Self;
  FTipoEF := AValue;
end;

function TParamEF.Lote(const AValue: String): IParamEF;
begin
  Result := Self;
  FLote := AValue;
end;

function TParamEF.Lote: String;
begin
  Result := FLote;
end;

function TParamEF.Lotes(const AValue: String): IParamEF;
begin
  Result := Self;
  FLotes := AValue;
end;

function TParamEF.Lotes: String;
begin
  Result := FLotes;
end;

{ TTipoTravaEstoqueHelper }

function TTipoTravaEstoqueHelper.getSQLIn: String;
begin
  Case Self Of
    tteTodas:
      Result := Concat(tefPrevisao.getSQLIn(), ',',
                       tefFaltaDeProduto.getSQLIn, ',',
                       tefAguardandoCliente.getSQLIn);
    tteFaltaDeProduto:
      Result := tefFaltaDeProduto.getSQLIn();
    tteAguardandoClienteEPrevisao:
      Result := Concat(tefPrevisao.getSQLIn(), ',',
                       tefAguardandoCliente.getSQLIn);
    tteAguardandoClienteEFaltaDeProduto:
      Result := Concat(tefFaltaDeProduto.getSQLIn, ',',
                       tefAguardandoCliente.getSQLIn);
  Else
    Result := '';
  End;
end;

{ TEntregaFutura }

constructor TEntregaFutura.Create(AParams: IParamEF);
begin
  FParams := AParams;
end;

function TEntregaFutura.fGetTabelaDocumentos(ATabela: String = '';
  ASomenteEstrutura: Boolean = False): String;
begin
  Result := fGerarTabelaComDocumentosPendentes(ATabela, ASomenteEstrutura);
end;

function TEntregaFutura.fCalcularQuantidadePendente(AQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}): Double;
begin
  If FParams.ConverteML() Then
    Result := AQuery.FieldByName('QTDPEN').AsFloat
  Else If (AQuery.FieldByName('CNV_ML').AsFloat <> 0) Then
    Result := (AQuery.FieldByName('QTDPEN').AsFloat / AQuery.FieldByName('CNV_ML').AsFloat)
  Else
    Result := AQuery.FieldByName('QTDPEN').AsFloat;
end;

function TEntregaFutura.fDefinirNomeTemporariaDocumentosPendentes: String;
begin
  Repeat
    Result := Format(sNomeTabelaDocumentosPendentes, [FParams.TipoEF.getTempTableName,
      strLoginUsuarioLogado, FParams.CodIte(), fRetSeqTmp]);
  Until (Not fTabelaExiste(Result));
end;

function TEntregaFutura.fGerarTabelaComDocumentosPendentes(ATabela: String = '';
                                                           ASomenteEstrutura: Boolean = False): String;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTmpPen: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  If Not ATabela.IsEmpty Then
    Result := ATabela
  Else
    Result := fDefinirNomeTemporariaDocumentosPendentes;

  If ATabela.IsEmpty Then
    If Not fExecutaSQL(Format(sqlCreateTabelaDocumentosPendentes, [Result])) Then
      Raise Exception.Create('Não foi possível criar a tabela ' + Result);

  If ASomenteEstrutura Then
    Exit;

  LQry := fCriaQuery();

  Try
    pDefineParametrosTipoAutomatica;

    FParams.PorVenda(True);

    LQry.Close();
    LQry.SQL.Add(TSqlEF.New(FParams).Build());
    LQry.Open();

    LTmpPen := fCriarQuery('SELECT * FROM ' + Result + ' WHERE FALSE');
    Try
      LTmpPen.Open;

      LQry.First;
      While (Not LQry.Eof) Do
      Begin
        LTmpPen.Append;
        LTmpPen.FieldByName('AUTINC').AsString := LQry.FieldByName('AUTOINCREM').AsString;
        LTmpPen.FieldByName('TABELA').AsString := 'MOVDET';
        LTmpPen.FieldByName('CODITE').AsString := LQry.FieldByName('DET_CODITE').AsString;
        LTmpPen.FieldByName('CODEMP').AsString := LQry.FieldByName('DET_CODEMP').AsString;
        LTmpPen.FieldByName('QTDPEN').AsFloat  := fCalcularQuantidadePendente(LQry);
        LTmpPen.Post;
        LQry.Next;
      End;

    Finally
    {$IFNDEF LINUX}
      FreeAndNil(LTmpPen);
    {$ENDIF LINUX}
    End;

  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

function TEntregaFutura.getTotal: Double;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  Try
    pDefineParametrosTipoAutomatica;

    LQry.Close();
    LQry.SQL.Add(TSqlEF.New(FParams).Build());
    LQry.Open();

    Result := fCalcularQuantidadePendente(LQry);
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

class function TEntregaFutura.New(AParams: IParamEF): IEntregaFutura;
begin
  Result := TEntregaFutura.Create(AParams);
end;

procedure TEntregaFutura.pDefineParametrosTipoAutomatica;
begin
  If (FParams.TipoTE() = tteAutomatica) Then
  Begin
    If (FParams.Faturamento()) Then
    Begin
      Case AnsiIndexStr(SaldoEstoqueParaTrava(), ['3', '4', '5']) Of
        0: FParams.TipoTE(tteFaltaDeProduto);
        1: FParams.TipoTE(tteAguardandoClienteEPrevisao);
        2: FParams.TipoTE(tteAguardandoClienteEFaltaDeProduto);
      Else
        FParams.TipoTE(tteNenhuma);
      End;
    End
    Else
      FParams.TipoTE(tteNenhuma);
  End;
end;

function TEntregaFutura.SaldoEstoqueParaTrava: String;
begin
  Result := fCfgSis('CALSAL', VarString);
end;

function TEntregaFutura.Total: Double;
begin
  Result := getTotal();
end;

{ TUpdateEF }

function TUpdateEF.BuildSQL(const ALote: Boolean): String;
var
  LOpc: TTipoEntregaFutura;
  LPre: String;
begin
  Result := '';
  Result := Result + ' UPDATE ' + IIF(ALote, 'CADLOT', 'ITEGER') + ' SET ';

  LPre := IIF(ALote, 'LOT_', 'ITE_');

  For LOpc := Low(TTipoEntregaFutura) To High(TTipoEntregaFutura) Do
  Begin
    If (Not ExecuteUpdate(LOpc)) Then
      Continue;

    Result := Result + Concat(LPre,
                              LOpc.getField(),
                              ' = :',
                              LOpc.getField(),
                              ',');
  End;

  Delete(Result, Length(Result), 1);
  Result := Result + ' WHERE ' + LPre + 'CODITE = :CODITE ';
  Result := Result + '   AND ' + LPre + 'CODEMP = :CODEMP ';

  If ALote Then
    Result := Result + ' AND ' + LPre + 'NUMLOT = :NUMLOT ';
end;

constructor TUpdateEF.Create(AParams: IParamEF);
begin
  FParams := AParams;
end;

procedure TUpdateEF.Execute;
begin
  Item();
  Lote();
end;

function TUpdateEF.ExecuteUpdate(const AOpc: TTipoEntregaFutura): Boolean;
begin
  Result := (((Not UpdateAll()) And (FParams.TipoEF() = AOpc)) Or
            (AOpc.Update())) And (Not fEmptyStr(AOpc.getField()));
end;

function TUpdateEF.InformouLote: Boolean;
begin
  Result := (Not fEmptyStr(FParams.Lote()));
end;

procedure TUpdateEF.Item;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpc: TTipoEntregaFutura;
begin
  LQry := fCriaQuery();

  Try
    Try
      LQry.SQL.Add(BuildSQL());

      For LOpc := Low(TTipoEntregaFutura) To High(TTipoEntregaFutura) Do
      Begin
        If (Not ExecuteUpdate(LOpc)) Then
          Continue;

        LQry.ParamByName(LOpc.getField()).AsFloat := TEntregaFutura.New(
                                                       TParamEF.New()
                                                         .CodIte(FParams.CodIte())
                                                         .CodEmp(FParams.CodEmp())
                                                         .TipoTE(tteNenhuma)
                                                         .TipoEF(LOpc)
                                                         .Atualizacao(True)
                                                       ).Total();
      End;

      LQry.ParamByName('CODITE').AsString := FParams.CodIte();
      LQry.ParamByName('CODEMP').AsString := FParams.CodEmp();

      LQry.ExecSQL();
    Except On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[TUpdateEF.Item] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '[TUpdateEF.Item]');
      {$ENDIF LINUX}
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

procedure TUpdateEF.Lote;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LOpc: TTipoEntregaFutura;
begin
  LQry := fCriaQuery();

  Try
    If (Not InformouLote()) Then
      Exit;
    Try
      LQry.SQL.Add(BuildSQL(True));

      For LOpc := Low(TTipoEntregaFutura) To High(TTipoEntregaFutura) Do
      Begin
        If (Not ExecuteUpdate(LOpc)) Then
          Continue;

        LQry.ParamByName(LOpc.getField()).AsFloat := TEntregaFutura.New(
                                                       TParamEF.New()
                                                         .CodIte(FParams.CodIte())
                                                         .CodEmp(FParams.CodEmp())
                                                         .TipoTE(tteNenhuma)
                                                         .TipoEF(LOpc)
                                                         .Atualizacao(True)
                                                         .Lote(FParams.Lote())
                                                       ).Total();
      End;

      LQry.ParamByName('CODITE').AsString := FParams.CodIte();
      LQry.ParamByName('CODEMP').AsString := FParams.CodEmp();
      LQry.ParamByName('NUMLOT').AsString := FParams.Lote();

      LQry.ExecSQL();
    Except On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[TUpdateEF.Lote] - ' + E.Message);
      {$ELSE }
        pMensagensErro(E.Message, '[TUpdateEF.Lote]');
      {$ENDIF LINUX}
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

class function TUpdateEF.New(AParams: IParamEF): IUpdateEF;
begin
  Result := TUpdateEF.Create(AParams);
end;

function TUpdateEF.UpdateAll: Boolean;
begin
  Result := (FParams.TipoEF() = tefTodos);
end;

{ TInvokerUpdateEF }

procedure TInvokerUpdateEF.Add(ACommand: IUpdateEF);
begin
  FCommandList.Add(ACommand);
end;

constructor TInvokerUpdateEF.Create;
begin
  FCommandList := TInterfaceList.Create();
end;

destructor TInvokerUpdateEF.Destroy;
begin
  FCommandList.Clear();
  FCommandList.Free();

  inherited;
end;

procedure TInvokerUpdateEF.Execute;
var
  LIdx: Integer;
begin
  For LIdx := 0 To Pred(FCommandList.Count) Do
    IUpdateEF(
      FCommandList[LIdx]
    ).Execute();
end;

class function TInvokerUpdateEF.New: IInvokerUpdateEF;
begin
  Result := TInvokerUpdateEF.Create();
end;

{ TAuditoriaEF }

constructor TAuditoriaEF.Create(AParams: IParamEF);
begin
  FParams := AParams;
  FInvoker := TInvokerUpdateEF.New();
  FCommandInsert := TStringList.Create();
end;

destructor TAuditoriaEF.Destroy;
begin
  FCommandInsert.Free();

  inherited;
end;

function TAuditoriaEF.ExecutedToday: Boolean;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();
  Try
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlAuditExecutedEF);

    Try
      LQry.ParamByName('CODITE').AsString := FParams.CodIte();
      LQry.ParamByName('CODEMP').AsString := FParams.CodEmp();
      LQry.Open();

      Result := ((LQry.FieldByName('ITE_ULTAEF').AsDateTime = VS_Date) And
                 (LQry.FieldByName('ITE_REPAEF').AsString = 'N'));
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[TAuditoriaEF.ExecutedToday] - ' + E.Message);
      {$ELSE }
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TAuditoriaEF.ExecutedToday]');
      End;
      {$ENDIF LINUX}
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

function TAuditoriaEF.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
end;

function TAuditoriaEF.HaveToReprocess: Boolean;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Clear();
    LQry.SQL.Add(sqlTemItemRepAudEF);

    Try
      LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
      LQry.Open();

      Result := (Not LQry.IsEmpty);
    Except
      On E: Exception Do
      {$IFDEF LINUX}
        Raise Exception.Create('[TAuditoriaEF.HaveToReprocess] - ' + E.Message);
      {$ELSE }
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TAuditoriaEF.HaveToReprocess]');
      End;
      {$ENDIF LINUX}
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

class function TAuditoriaEF.New(AParams: IParamEF):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TAuditoriaEF.Create(AParams);
end;

procedure TAuditoriaEF.pExecute;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LEnum: TTipoEntregaFutura;
  LOpenedTransaction: Boolean;
begin
  If (Not FParams.Reprocesso()) And (ExecutedToday()) Then
    Exit;

  Try
    LQry := fCriaQuery();

    Try
      LQry.SQL.Clear();
      LQry.SQL.Add(sqlCarregarLotesEF);

      If fExecutandoPeloPortal Then
        LQry.SQL.Add('AND FALSE');

      Try
        LQry.ParamByName('CODITE').AsString := FParams.CodIte();
        LQry.ParamByName('CODEMP').AsString := FParams.CodEmp();
        LQry.Open();

        While (Not LQry.Eof) Do
        Begin
          For LEnum := Low(TTipoEntregaFutura) To High(TTipoEntregaFutura) Do
          Begin
            If (Not LEnum.Update()) Or
               (fEmptyStr(LEnum.getField())) Then
              Continue;

            Verify(TParamEF.New()
              .CodIte(FParams.CodIte())
              .CodEmp(FParams.CodEmp())
              .Lote(LQry.FieldByName('LOT_NUMLOT').AsString)
              .Auditoria(True)
              .TipoEF(LEnum)
              .TipoTE(tteNenhuma)
              .Reprocesso(FParams.Reprocesso()));
          End;

          LQry.Next();
        End;
      Except
        On E: Exception Do
        {$IFDEF LINUX}
          Raise Exception.Create('[TAuditoriaEF.pExecute] - ' + E.Message);
        {$ELSE }
          pMensagensErro(E.Message, '[TAuditoriaEF.pExecute]');
        {$ENDIF LINUX}
      End;
    Finally
      LQry.Close();
      LQry.SQL.Clear();
    End;

    For LEnum := Low(TTipoEntregaFutura) To High(TTipoEntregaFutura) Do
    Begin
      If (Not LEnum.Update()) Or
         (fEmptyStr(LEnum.getField())) Then
        Continue;

      Verify(TParamEF.New()
        .CodIte(FParams.CodIte())
        .CodEmp(FParams.CodEmp())
        .Auditoria(True)
        .TipoEF(LEnum)
        .TipoTE(tteNenhuma)
        .Reprocesso(FParams.Reprocesso()));
    End;

    LOpenedTransaction := fInTransaction();

    If (Not LOpenedTransaction) Then
      fStartTransaction();

    Try
      If (FCommandInsert.Count > 0) Then
      Begin
        LQry.SQL.Add(FCommandInsert.Text);
        LQry.ExecSQL();
      End;

      FInvoker
        .Execute();

      LQry.Close();
      LQry.SQL.Clear();
      LQry.SQL.Add(fNormalizeSQL(sqlUpdUltAEF));
      LQry.ParamByName('CURRENT_DATE').AsDate := VS_Date;
      LQry.ParamByName('CODITE').AsString := FParams.CodIte();
      LQry.ParamByName('CODEMP').AsString := FParams.CodEmp();
      LQry.ExecSQL();

      If (Not LOpenedTransaction) Then
        fCommit();
    Except
      On E: Exception Do
      Begin
        If (Not LOpenedTransaction) Then
          fRollBack();
      End;
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

procedure TAuditoriaEF.pExecuteAll;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add(sqlItensAuditEF);
    LQry.SQL.Add(sqlLimit);
    LQry.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LQry.Open();

    While (Not LQry.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      If (LQry.FieldByName('ITE_REPAEF').AsString <> 'S') And HaveToReprocess() Then
        LQry.Refresh;

      TAuditoriaEF.New(
        TParamEF.New()
          .CodIte(LQry.FieldByName('ITE_CODITE').AsString)
          .CodEmp(VS_strCodEmp)
          .Reprocesso((LQry.FieldByName('ITE_REPAEF').AsString = 'S'))
        ).pExecute();

      If (LQry.RecNo Mod 50 = 0) Then
      Begin
        pZerarTentativasLock(Format(spIdMonitorEntFut, [VS_strCodEmp]));
        Sleep(2000);
        {$IFNDEF LINUX}
        pTrimAppMemorySize();
        {$ENDIF LINUX}
      End;

      LQry.Next();
    End;
  Finally
  {$IFNDEF LINUX}
    FreeAndNil(LQry);
  {$ENDIF LINUX}
  End;
end;

procedure TAuditoriaEF.Verify(AParams: IParamEF);
var
  LQtdCalculada: Double;
  LQtdAtual: Double;
begin
  LQtdAtual := fFormataFloat(TEntregaFutura.New(AParams).Total(), fCfgSis('DECQTD', varInteger));

  AParams.Atualizacao(True);

  LQtdCalculada := fFormataFloat(TEntregaFutura.New(AParams).Total(), fCfgSis('DECQTD', varInteger));

  If (LQtdAtual <> LQtdCalculada) Then
    If Not fExecutandoPeloPortal Then
      FInvoker.Add(TUpdateEF.New(AParams));
end;

end.
