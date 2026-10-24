unit untCadPro;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core, untFuncoesGenerica,
{$ELSE}
  Vcl.CheckLst, UniClientDataSet, cxProgressBar, Forms, untfuncoesSimples,
{$ENDIF}
  Classes, Uni, untTypesSistema, untCadNegBussiness, SysUtils,
  untZClient, System.Generics.Collections, untConstantes;

Type

  TItensPromo = Record
    strAutInc : String;
    strcodIte : String;
  End;

  TArrTipoMatrizItensPromo = Array Of TItensPromo;

  TConsultaPromocao = Class;

  TParametrosProduto = Class
    strCodigoProduto  : String;
    strUnidadeMedida  : String;
  End;

  TDadosPromocao = Record
    strCodPro: String;
    strDesPro: String;
    fltQtdLim: Double;
    fltQtdMin: Double;
    fltQtdDis: Double;
    dtaDtaFin: TDate;
  End;

  TRegiaoSistema = (tRegSysGeral, tRegSysCaixa);

  TrecItemPro = Record
    strCodIte      : String;
    strCodPro      : String;
    fltQtdIte      : Double;
    fltQtdLim      : Double;
    fltQtdMin      : Double;
    fltQtdDis      : Double;
    strRshTin      : String;
    strCodUnidade  : String;
    fltVlrLim      : Double;
    fltVlrIte      : Double;
    fltVlrTotDig   : Double;
    blnTemPromo    : Boolean;
  End;

  TArrRecItemPro = Array Of TrecItemPro;

  TProQtdColetiva = Class
    class function fVerificarPromocaoCompostaPorKitAtiva(AstrCodigoPromocao, AstrCodigoItem, AstrCodigoUnidadeMedida: String; var AstrIDKitAtivo : String): Boolean;
    class function fGrupoDoKitPossuiQuantidadeMinima(AstrIdKitAtivo, AstrCodigoDoGrupo, AstrUnidade : String) : Boolean;
    class function fEhPromocaoCompostaPorKit(AstrCodigoPromocao : String) : Boolean;
    class var DicTintasEmPromocao : TDicionario;
  public
    class procedure pDelItem(strCodIte, strCodUnidadeMedida: String; strRshTin: String);
    class procedure pAddOrUpdateItem(strCodIte, strCodigoUnidade, strCodPro: String; fltQtdIte, fltQtdLim, fltQtdMin: Double);
    class procedure pCopyArrItemPro(Var oriArrItemPro: TArrRecItemPro; Var desArrItemPro: TArrRecItemPro);
    class function fGetIndex(strCodIte, strCodUnidadeMedida: String; strRshTin: String; strCodPro: string = ''): Integer;
    class function fCodIteRepetido(strCodPro, strCodIte, strCodigoUnidade: String): Boolean;
    class function fGetQtd(strCodPro: String): Double;
    class function fAtivaPromocao(strCodPro, strCodigoItem, strCodigoUnidade: String; fltQtdIte : Double = 0): Boolean;
    class function fGetCodPro(strCodIte: String): String;
    class procedure pSetQtdLimMin(strCodPro: String; var fltQtdLim, fltQtdMin: Double);
    class procedure pLimpar;
    class function fGetIdKitPromocaoCompostaPorKit(AstrCodigoItem, AstrCodigoUnidadeMedida: String): String;
    Class function fVerificarKitAtivo(AIDKit : String): Boolean;
    class function fEhTintaComPromocaoCompostaPorKit(AstrRashTinta : String) : Boolean;
    class function fRecalculaPrecosDevidoAPromocaoPorKit : Boolean;
    class function fGetBrindesDoKit(AstrIdKit : String) : TUniQuery;
    class function fGetPrecoVendaPeloKit(ACoditoItem, ACodigoUnidade, ACodigoPromocao : String) : Double;
    class function pGetDadosPromocaoCompostaPorKit(AstrCodigoItem, AstrCodigoUnidade, AstrCodigoPromocao : String;  var ACodigoGrupo : String; var AItemGatilho : Boolean) : Boolean;
    class procedure pAdicionarStatusPromocaoDaTinta(AstrRashTinta, AstrPromocao : String);
    class var ArrItemPro: TArrRecItemPro;
    class var OpcSys: TRegiaoSistema;
    class var strRshTinAtual: String;
    class var cdsDadosPromocaoKit : TUniClientDataSet;
    class var strIDKitAtivo : String;
  End;

  IPromocaoVlrMinTotalProdutos = Interface ['{6FEF76D1-F7D1-4788-B834-A1674E818C91}']
    function fAddOrUpdateItem(strCodIte, strCodigoUnidade, strCodPro: String;
      strRshTin : String; fltVlrIte, fltVlrLim: Double; fltVlrTotDig: Double = 0;
      blnTemPromo: Boolean = False; fltQtdIte: Double = 0): Boolean;
    function fGetIndex(strCodIte, strCodUnidadeMedida: String;
      strRshTin: String; strCodPro: string = ''; blnLocTinta: Boolean = False): Integer;
    function fCodIteExiste(strCodPro, strCodIte, strCodigoUnidade: String): Boolean;
    function fGetVlrIte(strCodIte: String): Double;
    function fAtivaPromocao(strCodPro, strCodigoItem, strCodigoUnidade: String): Boolean;
    function fGetCodPro(strCodIte: String): String;
    function fGetVlrLimMin(strCodPro: String): Double;
    function fGetArrItemPro: TArrRecItemPro;
    function fGetOpcSys: TRegiaoSistema;

    procedure pDelItem(strCodIte, strCodUnidadeMedida: String; strRshTin: String);
    procedure pLimpar;
    procedure pAdicionarStatusPromocaoDaTinta(AstrRashTinta, AstrPromocao : String);
    procedure pSetOpcSys(const AOpcSys: TRegiaoSistema);
    function fCodItePossuiPromo(const strCodIte: String): Boolean;

    property ArrItemPro: TArrRecItemPro read fGetArrItemPro;
    property OpcSys: TRegiaoSistema read fGetOpcSys write pSetOpcSys;
  End;

  TPromocaoVlrMinTotalProdutos = Class (TInterfacedObject, IPromocaoVlrMinTotalProdutos)
  private
    FDicTintasEmPromocao : TDicionario;
    FArrItemPro: TArrRecItemPro;
    FOpcSys:  TRegiaoSistema;

    function fGetIndex(strCodIte, strCodUnidadeMedida: String;
      strRshTin: String; strCodPro: string = ''; blnLocTinta: Boolean = False): Integer;
    function fGetArrItemPro: TArrRecItemPro;
    function fGetOpcSys: TRegiaoSistema;
    procedure pSetOpcSys(const AOpcSys: TRegiaoSistema);
    function fCalculaTotalMinimoApenasItensPromocao(const strCodPro: String): Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    procedure pDelItem(strCodIte, strCodUnidadeMedida, strRshTin: String);
    function fAddOrUpdateItem(strCodIte, strCodigoUnidade, strCodPro: String;
      strRshTin : String; fltVlrIte, fltVlrLim: Double; fltVlrTotDig: Double = 0;
      blnTemPromo: Boolean = False; fltQtdIte: Double = 0): Boolean;

    function fAtivaPromocao(strCodPro, strCodigoItem, strCodigoUnidade: String): Boolean;
    function fGetCodPro(strCodIte: String): String;
    function fGetVlrLimMin(strCodPro: String): Double;
    procedure pLimpar;
    procedure pAdicionarStatusPromocaoDaTinta(AstrRashTinta, AstrPromocao : String);
    function fPossuiItensPromocaoVlrMinimo: Boolean;
    function fCodIteExiste(strCodPro, strCodIte, strCodigoUnidade: String): Boolean;
    function fCodItePossuiPromo(const strCodIte: String): Boolean;
    function fGetVlrIte(strCodIte: String): Double;

    class function fNew: IPromocaoVlrMinTotalProdutos;

    property ArrItemPro: TArrRecItemPro read fGetArrItemPro;
    property OpcSys: TRegiaoSistema read fGetOpcSys write pSetOpcSys;
  End;

  TFncUFDestTrib = function(strEmpIte: string): String of object;
  TFncUFEmpresa = function(strEmpIte: string): String of object;
  TfncPegaPrecoVenda = function(strCodIte, strCodEmp, strCodCli, strTabPre, strEstDes: String; fltIcmSai: Double; fltDesF07: Double; var fltPreCus: Double): Double of object;
  TfncPegaIcmsSai = function(strCodIte, strEmpIte: String): Double of object;
  TfncGetUnitarioEmbalagemFechada = function(strCodItem, strTabelaPreco: String; fltQtdItem, fltUnitOriginal: Double; blnUtilizaVlrUnitarioAtual: Boolean = False): Double of object;
  TfncOpcDoc = function: string of object;
  TFncQueryEmCacheTrouxeAlgumRegistro = function(qryGen: TUniQuery): Boolean;

  TEventosCadPro = Class
  public
    class var stlItensTemPromocao: TStringList;
    class var stlItensNaoTemPromocao: TStringList;
    class var stlLinhaGrupoUnidadeEmPromocaoKit: TStringList;
    class var fncUFDestTrib: TFncUFDestTrib;
    class var fncUFEmpresa: TFncUFEmpresa;
    class var fncPegaPrecoVenda: TfncPegaPrecoVenda;
    class var fncPegaIcmsSai: TfncPegaIcmsSai;
    class var fncGetUnitarioEmbalagemFechada: TfncGetUnitarioEmbalagemFechada;
    class var fncOpcDoc: TfncOpcDoc;
    class var fncQueryEmCacheTrouxeAlgumRegistro: TFncQueryEmCacheTrouxeAlgumRegistro;
    class function fUFDestTrib(strEmpIte: string): String;
    class function fUFEmpresa(strEmpIte: string): String;
    class function fPegaPrecoVenda(strCodIte, strCodEmp, strCodCli, strTabPre, strEstDes: String; fltIcmSai: Double; fltDesF07: Double; var fltPreCus: Double): Double;
    class function fPegaIcmsSai(strCodIte, strEmpIte: String): Double;
    class function fGetUnitarioEmbalagemFechada(strCodItem, strTabelaPreco: String; fltQtdItem, fltUnitOriginal: Double): Double;
    class function fOpcDoc: string;
    class function fQueryEmCacheTrouxeAlgumRegistro(qryGen: TUniQuery): Boolean;
  end;

  TTipoMovimento = (tpGeral, tpDoCliente, tpDoCliente2);
  TItemPromo = Class
  private
    class var FItensJaExibidosBanner: TStringList;
  private
    FstrCodCli: String;
    FstrTabPre: String;
    FstrCodIte: String;
    FstrCodEmp: String;
    FstrCodCnd: String;
    FstrENTBRF: String;
    FstrNumOrc: String;
    FstrEspOrc: String;
    FstrSelect: String;
    FintPraMedio: Integer;
    FstrPraMedio: String;
    FstrAndWhereCodIte: String;
    FstrAndWhereCodEmp: String;
    FstrAndWherePraMed: String;
    FblnUsaLimit: Boolean;
    FblnProCliEmPrimeiro: Boolean;
    FstrCliFil: String;
    FstrClaVen: String;
    FstrClaDev: String;
    cdsBanner : TUniClientDataSet;
    FDataVigencia: TDateTime;
    function fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp, strTabPre: String): String;
    function fRetSubQryComRegrasPromocao: String;
    function fGetSQLBanner: String;
    procedure pClear;
    procedure pCriaClientBanner;
    function RetSubQueryProCli: String;
  public
    constructor Create;
    destructor Destroy; override;
    function fRetSubQryAuxVWMovDet(tpTipoMovimento: TTipoMovimento): String;
    function fRetSubQryAuxVWFatDor(tpTipoMovimento: TTipoMovimento): String;
    function fRetSubQryPromo: String;
    function getCdsBanner: TUniClientDataSet;
    procedure pSetaPraMedioDefault;
    procedure pCarregaProdutosParaBanner;
    property strCodCli:           String    Read FstrCodCli           Write FstrCodCli;
    property strTabPre:           String    Read FstrTabPre           Write FstrTabPre;
    property strCodIte:           String    Read FstrCodIte           Write FstrCodIte;
    property strCodEmp:           String    Read FstrCodEmp           Write FstrCodEmp;
    property strCodCnd:           String    Read FstrCodCnd           Write FstrCodCnd;
    property strENTBRF:           String    Read FstrENTBRF           Write FstrENTBRF;
    property strNumOrc:           String    Read FstrNumOrc           Write FstrNumOrc;
    property strEspOrc:           String    Read FstrEspOrc           Write FstrEspOrc;
    property strSelect:           String    Read FstrSelect           Write FstrSelect;
    property intPraMedio:         Integer   Read FintPraMedio         Write FintPraMedio;
    property strPraMedio:         String    Read FstrPraMedio         Write FstrPraMedio;
    property strAndWhereCodIte:   String    Read FstrAndWhereCodIte   Write FstrAndWhereCodIte;
    property strAndWhereCodEmp:   String    Read FstrAndWhereCodEmp   Write FstrAndWhereCodEmp;
    property strAndWherePraMed:   String    Read FstrAndWherePraMed   Write FstrAndWherePraMed;
    property blnUsaLimit:         Boolean   Read FblnUsaLimit         Write FblnUsaLimit;
    property blnProCliEmPrimeiro: Boolean   Read FblnProCliEmPrimeiro Write FblnProCliEmPrimeiro;
    property dtaDataVigencia:     TDateTime Read FDataVigencia        Write FDataVigencia;
  End;

  IParametrosPromocao = Interface
  ['{D63B601B-6B9D-419C-ABB8-1D813CADE368}']
    function CodIte(Const Value: String): IParametrosPromocao; Overload;
    function CodEmp(Const Value: String): IParametrosPromocao; Overload;
    function CodCli(Const Value: String): IParametrosPromocao; Overload;
    function TabPre(Const Value: String): IParametrosPromocao; Overload;
    function NumOrc(Const Value: String): IParametrosPromocao; Overload;
    function EspOrc(Const Value: String): IParametrosPromocao; Overload;
    function Conexao(Const Value: TUniConnection): IParametrosPromocao; Overload;

    function AutInc: TArray<String>;
    function TodasEmpresas: TArray<Boolean>;
    function CodIte: String; Overload;
    function CodEmp: String; Overload;
    function CodCli: String; Overload;
    function TabPre: String; Overload;
    function NumOrc: String; Overload;
    function EspOrc: String; Overload;
    function Conexao: TUniConnection; Overload;

    function LevantarExcecao(const Value: Boolean): IParametrosPromocao; Overload;
    function LevantarExcecao: Boolean; Overload;
    function blnFiltrarCodIte: Boolean; overload;
    function blnFiltrarCodIte(const Value: Boolean): IParametrosPromocao; Overload;
    function strAutIncProm(const Value: String): IParametrosPromocao; Overload;
    function strAutIncProm: String; Overload;
    function blnTodasEmpresas(const Value: Boolean): IParametrosPromocao; Overload;
    function BlnArrayPreenchido(const Value: Boolean): IParametrosPromocao; Overload;

    procedure pSetarParamArrays;
  End;

  IUpdatePromo = Interface
  ['{D28ADE7C-FBB7-4B02-AEBF-5900F14F08DA}']
    function fAtualizaQtdDisponivel: IUpdatePromo;
    function fAtualizaQtdDisponivelTabTmp(ANomTabTmp: String): IUpdatePromo; 
    function fAtualizaQtdDisponivelTmp(fltQdeVen: Double; pgbStatus: TcxProgressBar): IUpdatePromo;
    function Parametros: IParametrosPromocao;
  End;

  IInvokerUpdatePromo = Interface
  ['{3E08E785-7FA2-43FC-94BC-C5BBED5CDE5C}']
    procedure pAdd(ACommand: IUpdatePromo);
    function fAtualizaQtdDisponivel: IInvokerUpdatePromo; overload;
    function fAtualizaQtdDisponivel(pgbStatus: TcxProgressBar): IInvokerUpdatePromo; overload;
    function fAtualizaQtdDisponivelTmp(pgbStatus: TcxProgressBar): IInvokerUpdatePromo;
    function fConsultaQtdDispTabelaProm(const strAutInc, strCodEmp: String; blnTodasEMpresas: Boolean): Boolean;
    function fAtualizaQtdDisponivelTabTmp(pgbStatus: TcxProgressBar): IInvokerUpdatePromo;
    function RemoveTabelaTemporaria: Boolean;

    procedure pLimpar;
  End;

  IConsultaPromocao = Interface
  ['{7E1FBCFF-1116-40DC-B87B-E75B87E8FB63}']
    function fGetQtdVendida: Double;
    function fGetQtdVendidaTabelaTemporaria(ANomTab: String): Double;
    function ConsultaQuantidadeVendida: Boolean;
  End;

  TParametrosPromocao = Class(TInterfacedObject, IParametrosPromocao)
  private
    FAutInc: TArray<String>;
    FTodasEmpresas: TArray<Boolean>;
    FCodIte: String;
    FCodEmp: String;
    FCodCli: String;
    FTabPre: String;
    FNumOrc: String;
    FEspOrc: String;
    FConexao: TUniConnection;
    FConsultouPromocao: Boolean;
    FLevantarExcecao: Boolean;
    FBlnFiltraCodIte: Boolean;

    FStrAutIncProm: String;
    FblnTodasEmpresasProm: Boolean;
    FBlnArrayPreenchidoParam: Boolean;

    constructor Create;

    function fGetSelectTipoQtdDis: String;

    procedure pVerificaTipoQtdDisponivel;
  public
    function CodIte(Const Value: String): IParametrosPromocao; Overload;
    function CodEmp(Const Value: String): IParametrosPromocao; Overload;
    function CodCli(Const Value: String): IParametrosPromocao; Overload;
    function TabPre(Const Value: String): IParametrosPromocao; Overload;
    function NumOrc(Const Value: String): IParametrosPromocao; Overload;
    function EspOrc(Const Value: String): IParametrosPromocao; Overload;
    function Conexao(Const Value: TUniConnection): IParametrosPromocao; Overload;

    function AutInc: TArray<String>;
    function TodasEmpresas: TArray<Boolean>;
    function CodIte: String; Overload;
    function CodEmp: String; Overload;
    function CodCli: String; Overload;
    function TabPre: String; Overload;
    function NumOrc: String; Overload;
    function EspOrc: String; Overload;
    function Conexao: TUniConnection; Overload;

    function LevantarExcecao(const Value: Boolean): IParametrosPromocao; Overload;
    function LevantarExcecao: Boolean; Overload;

    function blnFiltrarCodIte: Boolean; overload;
    function blnFiltrarCodIte(const Value: Boolean): IParametrosPromocao; Overload;
    function strAutIncProm(const Value: String): IParametrosPromocao; Overload;
    function strAutIncProm: String; Overload;
    function blnTodasEmpresas(const Value: Boolean): IParametrosPromocao; Overload;
    function blnArrayPreenchido(const Value: Boolean): IParametrosPromocao; Overload;

    procedure pSetarParamArrays;

    class function New: IParametrosPromocao;
  End;

  TUpdatePromo = Class(TInterfacedObject, IUpdatePromo)
  private
    FParametros: IParametrosPromocao;
    FQryCommand: TUniQuery;

    constructor Create(AParams: IParametrosPromocao);

    function fEncontrouPromocao(AIndex: Integer): Boolean;
    function fGetSQLUpdateQtdDisponivel(AIndex: Integer): String;
  public
    destructor Destroy; Override;

    function fAtualizaQtdDisponivel: IUpdatePromo;
    function fAtualizaQtdDisponivelTabTmp(ANomTabTmp: String): IUpdatePromo;
    function fAtualizaQtdDisponivelTmp(fltQtdVen: Double; pgbStatus: TcxProgressBar): IUpdatePromo;
    function Parametros: IParametrosPromocao;

    class function New(AParams: IParametrosPromocao): IUpdatePromo;
  End;

  TInvokerUpdatePromo = class(TInterfacedObject, IInvokerUpdatePromo)
  private
    FCommandList: TInterfaceList;
    FCdsConsProm: TUniClientDataSet;
    FNomTabTmp: String;

    constructor Create;
    function fRetornaQtdIte(const strCodIte, strCodEmp: String): Double;
  public
    destructor Destroy; Override;

    procedure pAdd(ACommand: IUpdatePromo);
    function fAtualizaQtdDisponivel: IInvokerUpdatePromo; overload;
    function fAtualizaQtdDisponivel(pgbStatus: TcxProgressBar): IInvokerUpdatePromo; overload;
    function fAtualizaQtdDisponivelTabTmp(pgbStatus: TcxProgressBar): IInvokerUpdatePromo; overload;
    function fAtualizaQtdDisponivelTmp(pgbStatus: TcxProgressBar): IInvokerUpdatePromo; overload;
    function fConsultaQtdDispTabelaProm(const strAutInc, strCodEmp: String; blnTodasEMpresas: Boolean): Boolean;
    function RemoveTabelaTemporaria: Boolean;
    procedure pLimpar;

    class function New: IInvokerUpdatePromo;
    property NomTabTmp: String read FNomTabTmp;
  end;

  TConsultaPromocao = Class(TInterfacedObject, IConsultaPromocao)
  private
    FIndex: Integer;
    FParametros: IParametrosPromocao;
    FQryCommand: TUniQuery;
    FItemPromo: TItemPromo;
    FNomTabTmp: String;

    constructor Create(AParams: IParametrosPromocao; AIndex: Integer);

    function fGetSelectQtdVendida: String;
    function fGetSelectQtdVendidaTabTmp: String;
    function RetornaNomeTabTemp: String;
    function PromocaoPorClientes: Boolean;
  public
    destructor Destroy; Override;

    function fGetQtdVendida: Double;
    function fGetQtdVendidaTabelaTemporaria(ANomTab: String): Double;
    function fConsultaQtdDispPorTabela(var cdsCons: TUniClientDataSet): Boolean;
    function ConsultaQuantidadeVendida: Boolean;

    class function New(AParams: IParametrosPromocao; AIndex: Integer): IConsultaPromocao;

    property NomeTabelaTemp: String read FNomTabTmp;
  End;

  TProLogCampo = record
    NomeTabela: String;
    NomeCampo: String;
    DescricaoCampo: String;
    Valores: TArray<String>;
    DescricaoValores: TArray<String>;
  end;

  TProLogChanges = record
    NomeTabela: String;
    DescricaoTabela: String;
    NomeCampo: String;
    DescricaoCampo: String;
    CodigoProduto: String;
    ValorAnterior: String;
    ValorAtual: String;
    Informacoes: String;
  end;

  TProLogSQL = class sealed
  public
    const SQL_CADPRO = 'SELECT * FROM CADPRO WHERE PRO_CODPRO = "%s" ';
    const SQL_ITEPRO = 'SELECT * FROM ITEPRO WHERE IPR_SEQGER = "%s" ';
    const SQL_PROEMP = 'SELECT * FROM PROEMP WHERE PRO_SEQGER = "%s" ';
    const SQL_PROCLI = 'SELECT * FROM PROCLI WHERE PRO_SEQGER = "%s" ';
    const SQL_CNDPRO = 'SELECT * FROM CNDPRO WHERE CPR_SEQGER = "%s" ';
  end;

  IProLog = Interface
  ['{62CFECF4-ACE9-44A2-AE74-2AF509C7D0B8}']
    function AddCampoLog(ACampo: TProLogCampo): IProLog;
    procedure ExecutarLogPromocao(ACodPro: String; AProgress: TcxProgressBar = Nil);
  end;

  TProLog = class(TInterfacedObject, IProLog)
  private
    FCodPro: String;
    FSeqGer: String;
    FOpeLog: String;
    FCampos: TArray<TProLogCampo>;
    FChanges: TArray<TProLogChanges>;
    FCadPro: TZClient;
    FItePro: TZClient;
    FProEmp: TZClient;
    FProCli: TZClient;
    FCndPro: TZClient;
    FExcluindoPromocao: Boolean;
    FAlterandoPromocao: Boolean;
    FInserindoPromocao: Boolean;
    function GetDescricaoTabela(ATabela: String): String;
    procedure IniciarObjetos;
    procedure FinalizarObjetos;
    procedure DefinirStatusPromocao(ACodPro: String);
    procedure AddLogExclusao(ACampo: TProLogCampo; ADadosOriginal: TZClient; AProduto, AInformacao: String);
    procedure AddLogInclusao(ACampo: TProLogCampo; ADadosAtual: TZClient; AProduto, AInformacao: String);
    procedure AddLogModificacoes(ACampo: TProLogCampo; ADadosOriginal, ADadosAtual: TZClient; AProduto, AInformacao: String);
    procedure ProcessarLogDadosPromocao;
    procedure ProcessarLogProdutosPromocao;
    procedure ProcessarLogEmpresasPromocao;
    procedure ProcessarLogClientesPromocao;
    procedure ProcessarLogCondicaoPagamentoPromocao;
    procedure ProcessarLogTabelasDetalhesPromocao(ATabela, ACampoBusca, ACampoProduto, ASQLTabela: String; ADadosAnterior: TZClient);
    Procedure InserirRegistrosTabelaProLog(AProgress: TcxProgressBar = Nil);
  protected
    constructor Create(ACodPro: String);
  public
    destructor Destroy; override;
    class function New(ACodPro: String): IProLog;
    function AddCampoLog(ACampo: TProLogCampo): IProLog;
    procedure ExecutarLogPromocao(ACodPro: String; AProgress: TcxProgressBar = Nil);
  end;

  TItePro = record
    strCodIte,
    strQtdLim,
    strQtdMin: String;
    fltPreCus,
    fltPreVen,
    fltPerDes: Double;
    intPrzMed: Integer;
    fltComVar,
    fltComAta,
    fltComDis,
    fltPreve2,
    fltPreve3,
    fltPreve4,
    fltPreve5,
    fltPreve6,
    fltPreve7,
    fltVlDsAd: Double;
    intTbDsAd: Integer;
    fltPerEst: Double;
    strSequencialKit: String;
    fltCliVen: Double;
    blnPrecoFixoTintaDeMaquinaImobiliaria : Boolean;
  end;

  TGravaItePro = class
  private
    FExisteIPR_CODEMP: Boolean;
    FItens: Array Of TItePro;
    FSeqGer: String;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddItem(strCodIte,
                      strQtdLim,
                      strQtdMin: String;
                      fltPreCus,
                      fltPreVen,
                      fltPerDes: Double;
                      intPrzMed: Integer;
                      fltComVar,
                      fltComAta,
                      fltComDis,
                      fltPreve2,
                      fltPreve3,
                      fltPreve4,
                      fltPreve5,
                      fltPreve6,
                      fltPreve7,
                      fltVlDsAd: Double;
                      intTbDsAd: Integer;
                      fltPerEst: Double;
                      strSequencialKit: String;
                      fltCliVen: Double;
                      blnPrecoFixoTintaDeMaquinaImobiliaria : Boolean);

    function Gravar(AProgress: TcxProgressBar = Nil; arrItens : TArrTipoMatrizItensPromo = Nil): Boolean;

    property SequencialPromocao: String Read FSeqGer Write FSeqGer;
  end;

 {$IFNDEF LINUX}
  TCadPro = Class
  public
    class procedure pCarregaEmpresa(clbEmpresa: TCheckListBox); static;
    class procedure pHelpConsiderarComissao(const Sender: TObject);
    class procedure pHelpQuantidadeLimite(const Sender: TObject);
  end;
 {$ENDIF}

  TPromocaoLimitePorClienteOuVenda = class
  private

    FqryAux : TUniQuery;
    FTipPro : TPromocaoUtilizaLimite;

    FCodPro : String;
    FNumDoc : String;
    FEspDoc : String;
    FEmpDoc : String;
    FCodCli : String;
    FCodIte : String;
    FQtdVen : Double;

    procedure pSetTipPro;
    function  fRetAutIncItePro : String;

  public

    constructor Create(ACodPro : String);
    destructor  Destroy; override;

    procedure pSetNumDoc(AValue : String);
    procedure pSetEspDoc(AValue : String);
    procedure pSetEmpDoc(AValue : String);
    procedure pSetCodCli(AValue : String);
    procedure pSetCodIte(AValue : String);
    procedure pSetQtdVen(AValue : Double);

    procedure pDeletar;
    procedure pGravar;

    function fExisteLancamentos : Boolean;
    function fExisteLancamentosItem(ASeqGer : String) : Boolean;

    function fRetQtdVendas : Double;
    function fRetQtdMaxima : Double;

    property TipPro : TPromocaoUtilizaLimite read FTipPro;

  end;

function fGetSQLCondicaoPromocaoPorDesconto: String;
function fGetSQLConsultaItensPrecoEstruturaPromo(strAliasIteGer: String = 'ITEGER';
  strTabela: String=''; strCodCli: String=''; strPraMedio: String=''): String;
function fGetSQLITE_PREVE(strAliasIteGer: String = 'ITEGER'; strTabela: String='1'; blnNomeOrig: Boolean=False; blnABADEP_PrecoLocal: Boolean = False): String;
function fRetSQLPrecoVendaPromo(strTabPre: String = ''; strAliasGer: String = ''; strCodCnd: String = ''; blnConsulta: Boolean = False): String;
function fRetSQLPorcentoDescontoComDescontoAdicional(strSQLPreco, strTabPre: String): String;
function fRetSQLPrecoVendaPromoItem(strTabPre: String = ''): String;
function fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;

function fItemCadastradoPromocao(strProAtu,
                                 strCodIte,
                                 strEmpSel,
                                 strCodCli,
                                 strTabPre,
                                 strCndPag: String;
                                 dtaDtaIni,
                                 dtaDtaFin: TDateTime;
                                 Var strMsgCli: String;
                                 Var strMsgPro: String;
                                 Var strMsgCnd: String;
                                 blnTabloid: Boolean): Boolean;

function fExecutaQueryLevantamentoEstrutura(qry: TUniQuery): Boolean;
procedure pCarregaEstruturaCasoItemPertencerUma(Var strLisCodIte: String; strCodIte: String; qry: TUniQuery = Nil; blnBuscaPorLista: Boolean=False);
function fItemComPromocaoPorCnd(strCodIte, strEmpSel: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): Boolean;
function fLinhaGrupoUnidadeEmPromocaoKit(strLinGru, strCodUni: String; Conexao: TUniConnection = Nil): Boolean;
function fItemSemNenhumaPromocao(strCodIte, strEmpSel: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): Boolean;
function fRetornaSomenteItensEmPromocaoDaLista(strLisCodIteOrc, strLisCodEmpOrc: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): TStringList;
function fItemTemAlgumaPromocaoParaCliente(strCodIte, strCodEmp, strCodCli: String; blnConsideraEstrutura: Boolean=True): Boolean;
function fItemTemAlgumaPromocaoRestritaNaoConsumidor(strCodIte, strCodEmp: String; blnConsideraEstrutura: Boolean=True): Boolean;

function fGetFiltroTabelaPrecoPromocao(strTabPre: String; strAlias: String = ''): String;
function fDeveFiltrarTabelPrecoNaPromocao : Boolean;
function fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli: String; strAlias: String = ''): String;
function fGetFiltroQuantidadeLimite(strQtdPedido: String = '0'): String;
function fEhPromocaoTabloid(strCodPro: string): Boolean;
function fTemPromocaoTabloid(ArrItemPro: Array Of TrecItemPro): Boolean;

//function fGravaItePro(strSeqGer,
//                      strCodIte,
//                      strQtdLim,
//                      strQtdMin: String;
//                      fltPreCus,
//                      fltPreVen,
//                      fltPerDes: Double;
//                      intPrzMed: Integer;
//                      fltComVar,
//                      fltComAta,
//                      fltComDis,
//                      fltPreve2,
//                      fltPreve3,
//                      fltPreve4,
//                      fltPreve5,
//                      fltPreve6,
//                      fltPreve7,
//                      fltVlDsAd: Double;
//                      intTbDsAd: Integer;
//                      fltPerEst: Double;
//                      strSequencialKit : String): Boolean;

  procedure pDeletaItensPromocao(strAutInc: String; var arrItens : TArrTipoMatrizItensPromo);

  procedure pDeletaClientesPromocao(strAutInc: String);

  function fDadosPromocao(strCodIte, strCodEmp: String;
    strCodCli: String = ''; strTabPre: String = ''; strENTBRF: String = '';
    strNumOrc: String = ''; strEspOrc: String = ''; strCodPro: String = '';
    Conexao: TUniConnection = Nil): TDadosPromocao; Overload;

  function fDadosPromocao(strCodIte, strCodEmp: String;
    strCodCli: String; strTabPre: String; strENTBRF: String;
    strNumOrc: String; strEspOrc: String; strCodPro: String;
    blnTabloid: Boolean; Conexao: TUniConnection): TDadosPromocao; Overload;

  Function fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli: String; blnTabloid: Boolean; blnProEsc : Boolean = False; blnConsiderarTodasAsCondicoes : Boolean = False): String;
  Function fSqlPromocaoCliente      (strCodCnd, strPrzPro, strCodCli, strTabPre: String; blnTabloid: Boolean; blnProEsc : Boolean = False; blnConsiderarTodasAsCondicoes : Boolean = False): String;
  Function fSqlRetQtdMinPromocaoEscalonada : String;

  function fRetornaPrecosPromocao(strCodIte,
                                  strCodCli: String;
                                  dtaDtaPro: TDateTime;
                                  fltQtdDig,
                                  fltQtdJaDig,
                                  fltQtdJaEmPromoc: Double;
                                  intPraMed: Integer;
                                  Var fltPreCus,
                                  fltPreVen,
                                  fltComVar,
                                  fltComAta,
                                  fltComDis,
                                  fltQtdDis,
                                  fltDesF07: Double;
                                  Var strComPro: String;
                                  var strCodPro: String;
                                  Var blnParticiona,
                                  blnPromo: Boolean;
                                  strTabPre: String;
                                  strCodCnd: String;
                                  strPrzPro: String = '';
                                  strENTBRF: String = '';
                                  blnConsideraQtd: Boolean=True;
                                  blnBuscaPreco: Boolean=False;
                                  strIteVid: String = '-1';
                                  blnEntIme: Boolean=False;
                                  blnEntFut: Boolean=False;
                                  strMotFut: String = '';
                                  strEmpPro: String = '';
                                  strNumOrc: String = '';
                                  strEspOrc: String = '';
                                  Conexao: TUniConnection = Nil;
                                  blnEhConsulta: Boolean = False;
                                  strUnMed: String = '';
                                  objPromMinProd: TPromocaoVlrMinTotalProdutos = Nil;
                                  strIteTin: String = '';
                                  fltPrecoTotalColorantes : Double = 0): Boolean; Overload;

  function fEhPromocaoPorQuantidadeMinimaEscalonada(const AId: Integer) : Boolean;

  function fTipoDePromocaoSuportaPrecoFixoParaTmqImo(const ATipoPromocao : Integer) : Boolean;

  function fRetornaPrecosPromocao(strCodIte,
                                  strCodCli: String;
                                  dtaDtaPro: TDateTime;
                                  fltQtdDig,
                                  fltQtdJaDig,
                                  fltQtdJaEmPromoc: Double;
                                  intPraMed: Integer;
                                  Var fltPreCus,
                                  fltPreVen,
                                  fltComVar,
                                  fltComAta,
                                  fltComDis,
                                  fltQtdDis,
                                  fltDesF07: Double;
                                  Var strComPro: String;
                                  var strCodPro: String;
                                  Var blnParticiona,
                                  blnPromo: Boolean;
                                  strTabPre: String;
                                  strCodCnd: String;
                                  strPrzPro: String;
                                  strENTBRF: String;
                                  blnConsideraQtd: Boolean;
                                  blnBuscaPreco: Boolean;
                                  strIteVid: String;
                                  blnEntIme: Boolean;
                                  blnEntFut: Boolean;
                                  strMotFut: String;
                                  strEmpPro: String;
                                  strNumOrc: String;
                                  strEspOrc: String;
                                  Conexao: TUniConnection;
                                  blnEhConsulta: Boolean;
                                  blnTabloid: Boolean;
                                  strUnMed: String = '';
                                  objPromMinProd: TPromocaoVlrMinTotalProdutos = Nil;
                                  strIteTin: String = '';
                                  fltPrecoTotalColorantes : Double = 0): Boolean; overload;

function fRetornaValorPromocional(strCodIte,
                                  strCodCli: String;
                                  strTabPre: String): Double;

procedure pDetalhesPromocao(strCodIte, strCodEmp, strTabPre, strCodPro: String);

function fRetornaCodPro (strCodIte,
                         strCodEmp : String;
                         dtaData : TDateTime;
                         Var qryTabela : TUniQuery):String;
function fUsaPrecoDeVendaDinamicoForaDoEstado(strEmpIte: string): Boolean;
function fRetPrecoVendaPromocao(strCodIte, strTabPre: String; strEmpIte: String; strCodCli: String; Conexao: TUniConnection; fltDesF07: Double; var fltPreCus: Double): Double;
function fAplicaDescontoCondicaoItensEmPromocao(strCodCnd: String): Boolean;

function fCarregarParametrosProduto(ACodigoProduto : String; AUnidadeMedida: String = '') : TParametrosProduto;

function fValidarCondicaoEPrazoDePagamentoNasPromocoes : Boolean;

function fGetUnitarioEmbalagemFechada(strCodItem, strTabelaPreco: String; fltQtdItem, fltUnitOriginal: Double; blnUtilizaVlrUnitarioAtual: Boolean = False): Double;
function fItemPromocionalComPrecoFixoParaTintaDeMaquinaImobiliaria(const strCodIte, strCodPro : String) : Boolean;

var
  strEmpPro: String;
  VS_ALITPR : String;

implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untFuncoesImagem, untFuncoesRel,
{$ENDIF}
  StrUtils, Data.DB;

function fSqlWhere(strProAtu, strTabPre, strCodIte, strCodCli, strCndPag: String; strCodEmp: String=''): String;
  Var
    strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strCodIte) Then
  begin
    if Length(strCodIte) = 5 then
      strCodIte := strCodIte.QuotedString;

    strSQL := strSQL + '  IPR_CODITE IN (' + strCodIte + ') AND ';
  end
  Else
    strSQL := strSQL + '  IPR_CODITE = :CODITE AND ';

  If Not fEmptyStr(strCodEmp) Then
    strSQL := strSQL + '  PE.PRO_CODEMP IN (' + strCodEmp + ') AND '
  Else
    strSQL := strSQL + '  LOCATE(PE.PRO_CODEMP, :CODEMP) > 0 AND ';

  strSQL := strSQL + '  ( ';
  strSQL := strSQL + '    :DTAINI BETWEEN PRO_DTAINI AND PRO_DTAFIN OR ';
  strSQL := strSQL + '    :DTAFIN BETWEEN PRO_DTAINI AND PRO_DTAFIN    ';
  strSQL := strSQL + '  )  ';

  If (Not fEmptyStr(strProAtu)) Then
    strSQL := strSQL + '  AND PRO_CODPRO <> :CODPRO ';

  If (Not fEmptyStr(strCndPag)) Then
    strSQL := strSQL + '  AND LOCATE(CND.CPR_CODCND,:CNDPAG) > 0 ';

  strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre);
  strSQL := strSQL + fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli);

  Result := strSQL;
End;

function fGetSQLITE_PREVE(strAliasIteGer: String = 'ITEGER'; strTabela: String='1'; blnNomeOrig: Boolean=False; blnABADEP_PrecoLocal: Boolean = False): String;

  procedure pReplaceSQLPreco(const strTabela: String; var strSQL: String);
    Var
      strPreco: String;
  begin
    strPreco := ' (IFNULL( ' ;

    If (fCfgSis('RATEST', varString) = 'C') Then
      strPreco := strPreco + ' (SELECT SUM(ROUND(DM.DMT_QTDITE * (IT.ITE_PREVE' + strTabela + ' * DM.DMT_PRESUB), 2)) '
    Else
      strPreco := strPreco + ' (SELECT SUM(ROUND(DM.DMT_QTDITE * IT.ITE_PREVE' + strTabela + ', 2)) ';

    strPreco := strPreco + '   FROM GERMAT GM ' +
                '     INNER JOIN DETMAT DM ON DM.DMT_SEQGER = GM.AUTOINCREM ' +
                '     INNER JOIN ITEGER IT ON DM.DMT_ITESUB = IT.ITE_CODITE ' +
                '   WHERE ' +
                '     GM.GMT_CODITE = ' + strAliasIteGer + '.ITE_CODITE AND ' +
                '     IT.ITE_CODEMP = ' + strAliasIteGer + '.ITE_CODEMP     ' +
                ' ), ' + strAliasIteGer + '.ITE_PREVE' + strTabela + ')) ';

    strSQL := AnsiReplaceStr(strSQL, strAliasIteGer+'.ITE_PREVE'+strTabela, strPreco);
  end;

begin
  Result := strAliasIteGer+'.ITE_PREVE'+strTabela;

  If blnNomeOrig And (blnABADEP_PrecoLocal Or (fCfgSis('SUGVLE', varString) = '2')) Then
    Result := ' (' + Result + ') ';

  If blnABADEP_PrecoLocal Then
  Begin
    Result := '(SELECT ITE_PREVE'+strTabela+' FROM ITEGER IT WHERE IT.ITE_CODITE = '+strAliasIteGer+'.ITE_CODITE AND IT.ITE_CODEMP = '+QuotedStr(VS_strCodEmp)+')';
    If blnNomeOrig Then
      Result := ' ' + Result + ' AS ITE_PREVE'+strTabela + ' ';
  End
  Else If fCfgSis('SUGVLE', varString) = '2' Then
  Begin
    pReplaceSQLPreco(strTabela, Result);
    If blnNomeOrig Then
      Result := ' ' + Result + ' AS ITE_PREVE'+strTabela + ' ';
  End
end;

function fGetSQLCondicaoPromocaoPorDesconto: String;
begin
  Result := ' ((CADPRO.PRO_PREDES = "D" AND CADPRO.PRO_IDXPRO <> '+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional])+')'+
            '  OR (CADPRO.PRO_IDXPRO IN ('+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpDescon])+','+IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva])+'))) '
end;

function fGetSQLConsultaItensPrecoEstruturaPromo(strAliasIteGer: String = 'ITEGER';
  strTabela: String=''; strCodCli: String=''; strPraMedio: String=''): String;

  function fRetornaCampoPrecoPromocoao: String;
  Begin
    If (strTabela = '1') Or (strTabela.IsEmpty) Then
      Result := ' IPR_PREVEN '
    Else
      Result := ' IPR_PREVE' + strTabela + ' ';
  End;

  function fRetSubQryPromo: String;
  begin
    Result := '';
    Result := Result + ' (SELECT IF('+fGetSQLCondicaoPromocaoPorDesconto+', (1 - (ITEPRO.IPR_PERDES / 100)) * IT.ITE_PREVE' + strTabela + ', '+fRetornaCampoPrecoPromocoao+') AS IPR_PREVEN ';
    Result := Result + '    FROM CADPRO INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM ';
    Result := Result + '                INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    Result := Result + '                LEFT  JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM ';
    Result := Result + '                LEFT  JOIN IPREMP ON ITEPRO.AUTOINCREM = IPREMP.IPR_SEQGER AND PROEMP.PRO_CODEMP = IPREMP.IPR_CODEMP ';
    Result := Result + '  WHERE ';
    Result := Result + '    ' + fCurrentDate + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
    Result := Result + '    ' + fGetFiltroTabelaPrecoPromocao(strTabela);
    Result := Result + '    ' + fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli);
    Result := Result + '    ' + fGetFiltroQuantidadeLimite();
    Result := Result + '   AND PROEMP.PRO_CODEMP = IT.ITE_CODEMP';
    Result := Result + '   AND ITEPRO.IPR_CODITE = IT.ITE_CODITE';

    If Not fEmptyStr(strCodCli) Then
      Result := Result + '  AND (PROCLI.PRO_CODCLI = '+QuotedStr(strCodCli)+' OR PROCLI.PRO_SEQGER IS NULL)'
    Else
      Result := Result + '  AND PROCLI.PRO_SEQGER IS NULL';

    If Not fEmptyStr(strPraMedio) Then
      Result := Result + ' AND ITEPRO.IPR_PRZMED >= ' + strPraMedio;

    Result := Result + ' ORDER BY CADPRO.PRO_TABLOI DESC, PROCLI.PRO_CODCLI DESC, CADPRO.PRO_DTAINI, CADPRO.PRO_DTAFIN LIMIT 1)';
  end;

  function fRetSubQryPromoEstrut(blnSoPromo: Boolean): String;
  begin
    Result := '';
    Result := Result + ' (SELECT ';
    If blnSoPromo Then
      Result := Result + '   SUM(IFNULL(ROUND(DM.DMT_QTDITE * '+ fRetSubQryPromo +', 2), 0)) '
    Else
      Result := Result + '   SUM(IFNULL(ROUND(DM.DMT_QTDITE * '+ fRetSubQryPromo +', 2), '+'ROUND(DM.DMT_QTDITE * IT.ITE_PREVE' + strTabela+', 2))) ';
    Result := Result + '   FROM ' ;
    Result := Result + '     GERMAT GM ';
    Result := Result + '     INNER JOIN DETMAT DM ON DM.DMT_SEQGER = GM.AUTOINCREM ';
    Result := Result + '     INNER JOIN ITEGER IT ON DM.DMT_ITESUB = IT.ITE_CODITE ';
    Result := Result + '   WHERE ';
    Result := Result + '     GM.GMT_CODITE = ' + strAliasIteGer + '.ITE_CODITE AND ';
    Result := Result + '     IT.ITE_CODEMP = ' + strAliasIteGer + '.ITE_CODEMP)    ';
  end;
begin
  Result := '(NULL * 0.00)'; //MUTRETA PARA O FIELD FICAR COMO FLOAT QUANDO NULL (NÃO ACEITOU CAST)
  If (fCfgSis('SUGVLE', varString) = '2') Then
  Begin
    If fEmptyStr(strTabela) Then
      strTabela := '1';
    Result := 'IF('+fRetSubQryPromoEstrut(True)+' > 0.00,'+fRetSubQryPromoEstrut(False)+', NULL)';
  End;
end;

function fRetSQLPorcentoDescontoComDescontoAdicional(strSQLPreco, strTabPre: String): String;
  Var
    strIdxPro : String;

  function fRetornaCampoVenda(strTabela: String): String;
  Begin
    If strTabela = '1' Then
      Result := ' IPR_PREVEN '
    Else
      Result := ' IPR_PREVE' + strTabela + ' ';
  End;

begin
  strIdxPro := IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]);

  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + fRetornaCampoVenda(strTabPre)
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 1, 1) = "S" THEN ' + fRetornaCampoVenda('1');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 2, 1) = "S" THEN ' + fRetornaCampoVenda('2');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 3, 1) = "S" THEN ' + fRetornaCampoVenda('3');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 4, 1) = "S" THEN ' + fRetornaCampoVenda('4');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 5, 1) = "S" THEN ' + fRetornaCampoVenda('5');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 6, 1) = "S" THEN ' + fRetornaCampoVenda('6');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 7, 1) = "S" THEN ' + fRetornaCampoVenda('7');
    Result := Result + '   ELSE                                        ' + fRetornaCampoVenda('1');
    Result := Result + ' END ';
  End;

  Result := ' IF(PRO_IDXPRO = ' + strIdxPro + ', ' + Result + ', ' + strSQLPreco + ') ';
end;

function fRetSQLPrecoVendaPromo(strTabPre: String = ''; strAliasGer: String = ''; strCodCnd: String = ''; blnConsulta: Boolean = False): String;

  function fRetornaCampoVenda(strTabela: String): String;
    Var
      strAuxVen : String;
      strAuxDes : String;
      fltPerDesCnd : Double;
  Begin
    If (Not blnConsulta) Then
      Result := ' ((1 - (IPR_PERDES / 100)) * ITE_PREVE' + strTabela +') '
    Else
    Begin
      strAuxVen := strAliasGer + 'ITE_PREVE' + strTabela;
      strAuxDes := 'ROUND((' + strAuxVen + ' - ( ' + strAuxVen + ' * (IPR_PERDES / 100))), ' + fCfgSis('DECUNI') + ')';
      fltPerDesCnd := fRetDescMaxCnd(strCodCnd, mdVendedor);
      If fAplicaDescontoCondicaoItensEmPromocao(strCodCnd) Then
        Result := 'ROUND((' + strAuxDes + ') - (( ' + strAuxDes + ' * ' + AnsiReplaceStr(FloatToStrF(fltPerDesCnd, ffFixed, 12, 2),',','.') + ' ) / 100), ' + fCfgSis('DECUNI') + ')'
      Else
        Result := strAuxDes;
    End;
  End;

Begin
  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + fRetornaCampoVenda(strTabPre)
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 1, 1) = "S" THEN ' + fRetornaCampoVenda('1');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 2, 1) = "S" THEN ' + fRetornaCampoVenda('2');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 3, 1) = "S" THEN ' + fRetornaCampoVenda('3');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 4, 1) = "S" THEN ' + fRetornaCampoVenda('4');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 5, 1) = "S" THEN ' + fRetornaCampoVenda('5');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 6, 1) = "S" THEN ' + fRetornaCampoVenda('6');
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 7, 1) = "S" THEN ' + fRetornaCampoVenda('7');
    Result := Result + '   ELSE                                        ' + fRetornaCampoVenda('1');
    Result := Result + ' END ';
  End;

  Result := ' IF('+fGetSQLCondicaoPromocaoPorDesconto+', ' + Result + ', IPR_PREVEN) ';

  Result := fRetSQLPorcentoDescontoComDescontoAdicional(Result, strTabPre);
End;

function fRetSQLPrecoVendaPromoItem(strTabPre: String =''): String;
Begin
  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + ' ((1 - (IPR_PERDES / 100)) * ' + strTabPre +') ';
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 1, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 2, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE2) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 3, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE3) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 4, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE4) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 5, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE5) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 6, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE6) ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 7, 1) = "S" THEN ((1 - (IPR_PERDES / 100)) * ITE_PREVE7) ';
    Result := Result + '   ELSE ((1 - (IPR_PERDES / 100)) * ITE_PREVE1) ';
    Result := Result + ' END ';
  End;

  Result := ' IF('+fGetSQLCondicaoPromocaoPorDesconto+', ' + Result + ', IPR_PREVEN) ';

  Result := fRetSQLPorcentoDescontoComDescontoAdicionalItem(Result, strTabPre);
End;

function fRetSQLPorcentoDescontoComDescontoAdicionalItem(strSQLPreco, strTabPre: String): String;
  Var
    strIdxPro : String;
begin
  strIdxPro := IntToStr(IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]);

  Result := '';

  If Not fEmptyStr(strTabPre) Then
  Begin
    Result := Result + IIF( Pos('1', strTabPre) > 0, 'IPR_PREVEN', strTabPre);
  End
  Else
  Begin
    Result := Result + ' CASE ';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 1, 1) = "S" THEN IPR_PREVEN';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 2, 1) = "S" THEN IPR_PREVE2';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 3, 1) = "S" THEN IPR_PREVE3';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 4, 1) = "S" THEN IPR_PREVE4';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 5, 1) = "S" THEN IPR_PREVE5';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 6, 1) = "S" THEN IPR_PREVE6';
    Result := Result + '   WHEN SUBSTRING(PRO_TABPRE, 7, 1) = "S" THEN IPR_PREVE7';
    Result := Result + '   ELSE IPR_PREVEN ';
    Result := Result + ' END ';
  End;

  Result := ' IF(PRO_IDXPRO = ' + strIdxPro + ', ' + Result + ', ' + strSQLPreco + ') ';
end;

function fItemCadastradoPromocao(strProAtu,
                                 strCodIte,
                                 strEmpSel,
                                 strCodCli,
                                 strTabPre,
                                 strCndPag: String;
                                 dtaDtaIni,
                                 dtaDtaFin: TDateTime;
                                 Var strMsgCli: String;
                                 Var strMsgPro: String;
                                 Var strMsgCnd: String;
                                 blnTabloid: Boolean): Boolean;
  Var
    strSQL   : String;
    qryGenPro: TUniQuery;
    stlCli : TStringList;
    stlPro : TStringList;
    stlCnd : TStringList;
    stlEmp : TStringList;
begin
  stlCli := TStringList.Create;
  stlPro := TStringList.Create;
  stlCnd := TStringList.Create;
  stlEmp := TStringList.Create;

  Try
    strMsgCli := '';
    strMsgPro := '';
    strMsgCnd := '';

    stlCli.Clear;
    stlPro.Clear;
    stlCnd.Clear;
    stlEmp.Clear;

    qryGenPro := fCriaQuery(nil);

    If fEmptyStr(strCodCli) Then
    Begin
      // PROMOCOES SEM CLIENTES (PARA TODOS)
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT PRO_CODPRO, PRO_DESPRO, IPR_CODITE, ITE_DESITE, CND.CPR_CODCND, CND_DESCRI ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPRO P ';
      strSQL := strSQL + '  INNER JOIN ITEPRO    ON P.AUTOINCREM = ITEPRO.IPR_SEQGER ';
      strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER  ';
      strSQL := strSQL + '  LEFT  JOIN PROCLI C  ON P.AUTOINCREM = C.PRO_SEQGER ';
      strSQL := strSQL + '  INNER JOIN CADITE I  ON (I.ITE_CODITE = ITEPRO.IPR_CODITE) ';
      strSQL := strSQL + '  LEFT  JOIN CNDPRO CND ON P.AUTOINCREM = CND.CPR_SEQGER ';
      strSQL := strSQL + '  LEFT  JOIN CADCND  ON CND_CODIGO = CND.CPR_CODCND ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + fSqlWhere(strProAtu, strTabPre, strCodIte, strCodCli, strCndPag);
      strSQL := strSQL + ' AND C.PRO_CODCLI IS NULL ';

      If (strCndPag.IsEmpty) And (fValidarCondicaoEPrazoDePagamentoNasPromocoes) Then
        strSQL := strSQL + ' AND (CND.CPR_CODCND IS NULL) ';

    End Else
    Begin
      // PROMOCOES PARA CLIENTES ESPECIFICOS
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  DISTINCT PRO_CODPRO, PRO_DESPRO, C.PRO_CODCLI AS PRO_CODCLI, ';
      strSQL := strSQL + '  IPR_CODITE, ITE_DESITE, A.CLI_NOMCLI, CND.CPR_CODCND, CND_DESCRI ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPRO P ';
      strSQL := strSQL + '  INNER JOIN ITEPRO    ON P.AUTOINCREM = ITEPRO.IPR_SEQGER ';
      strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER  ';
      strSQL := strSQL + '  INNER JOIN PROCLI C  ON P.AUTOINCREM = C.PRO_SEQGER AND   ';
      strSQL := strSQL + '                          LOCATE(C.PRO_CODCLI, :CODCLI) > 0 ';
      strSQL := strSQL + '  INNER JOIN CADCLI A ON (A.CLI_CODCLI = C.PRO_CODCLI) ';
      strSQL := strSQL + '  INNER JOIN CADITE I ON (I.ITE_CODITE = ITEPRO.IPR_CODITE) ';
      strSQL := strSQL + '  LEFT  JOIN CNDPRO CND ON P.AUTOINCREM = CND.CPR_SEQGER ';
      strSQL := strSQL + '  LEFT  JOIN CADCND  ON CND_CODIGO = CND.CPR_CODCND ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + fSqlWhere(strProAtu, strTabPre, strCodIte, strCodCli, strCndPag);

      If (strCndPag.IsEmpty) And (fValidarCondicaoEPrazoDePagamentoNasPromocoes) Then
        strSQL := strSQL + ' AND (CND.CPR_CODCND IS NULL) ';

    End;

    If fCfgSis('TABLOI', VarBoolean) Then
      If blnTabloid Then
        strSQL := strSQL + ' AND P.PRO_TABLOI = "S" ' //Se for promocao tabloid valida somente com outra promocao tabloid
      Else
        strSQL := strSQL + ' AND P.PRO_TABLOI = "N" '; //Se não for promocao tabloid valida somente com outra promocao não tabloid

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('DTAINI').AsDate   := dtaDtaIni;
      ParamByName('DTAFIN').AsDate   := dtaDtaFin;
      ParamByName('CODEMP').AsString := strEmpSel;

      If Not fEmptyStr(strCodCli) Then
        ParamByName('CODCLI').AsString := strCodCli;
      
      If (Not fEmptyStr(strProAtu)) Then
        ParamByName('CODPRO').AsString := strProAtu;

      If (Not fEmptyStr(strCndPag)) And (Assigned(FindParam('CNDPAG'))) Then
        ParamByName('CNDPAG').AsString := strCndPag;

      Open;

      If (RecordCount > 0) Then
      Begin
        strEmpPro := '';

        Repeat

          If (Not fEmptyStr(strCndPag)) And (Assigned(FindField('CPR_CODCND'))) And (Assigned(FindField('CND_DESCRI'))) Then
          Begin
            strMsgCnd := FieldByName('CPR_CODCND').AsString + ' - ' + Trim(FieldByName('CND_DESCRI').AsString);
            If stlCnd.IndexOf(strMsgCnd) < 0 Then
              stlCnd.Add(strMsgCnd);
          End;

          If (Not fEmptyStr(strCodCli)) Then
          Begin
            strMsgCli := FieldByName('PRO_CODCLI').AsString + ' - ' + Trim(FieldByName('CLI_NOMCLI').AsString);
            If stlCli.IndexOf(strMsgCli) < 0 Then
              stlCli.Add(strMsgCli);
          End;

          If (Not fEmptyStr(strCodIte)) Then
          Begin
            strMsgPro := 'PROMOÇÃO: ' + FieldByName('PRO_CODPRO').AsString + '-' + FieldByName('PRO_DESPRO').AsString;
            strMsgPro := strMsgPro + ' - ' + FieldByName('IPR_CODITE').AsString + ' - ' + Trim(FieldByName('ITE_DESITE').AsString);
            If stlPro.IndexOf(strMsgPro) < 0 Then
              stlPro.Add(strMsgPro);
          End;

          strEmpPro := FieldByName('PRO_CODPRO').AsString + '-' + FieldByName('PRO_DESPRO').AsString;
          If stlEmp.IndexOf(strEmpPro) < 0 Then
            stlEmp.Add(strEmpPro);

          Next;

        Until Eof;

        strEmpPro := 'Promoção: ' + stlEmp.CommaText;

        If (Not fEmptyStr(strCndPag)) And (stlCnd.Count > 0) Then
          strMsgCnd := stlCnd.CommaText
        Else
          strMsgCnd := '';

        If (Not fEmptyStr(strCodCli)) And (stlCli.Count > 0) Then
          strMsgCli := stlCli.CommaText
        Else
          strMsgCli := '';

        If (Not fEmptyStr(strCodIte)) And (stlPro.Count > 0) Then
          strMsgPro := stlPro.CommaText
        Else
          strMsgPro := '';
      End;

      Result := (RecordCount > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenPro);
    FreeAndNil(stlCli);
    FreeAndNil(stlPro);
    FreeAndNil(stlCnd);
    FreeAndNil(stlEmp);
  End;

end;

//function fGravaItePro(strSeqGer,
//                      strCodIte,
//                      strQtdLim,
//                      strQtdMin: String;
//                      fltPreCus,
//                      fltPreVen,
//                      fltPerDes: Double;
//                      intPrzMed: Integer;
//                      fltComVar,
//                      fltComAta,
//                      fltComDis,
//                      fltPreve2,
//                      fltPreve3,
//                      fltPreve4,
//                      fltPreve5,
//                      fltPreve6,
//                      fltPreve7,
//                      fltVlDsAd: Double;
//                      intTbDsAd: Integer;
//                      fltPerEst: Double;
//                      strSequencialKit: String): Boolean;
//  var
//    qryItePro: TUniQuery;
//begin
//
//  Try
//
//    qryItePro := fCriarQuery('SELECT * FROM ITEPRO WHERE FALSE');
//    With qryItePro Do
//    Begin
//
//      If (Not Active) Then
//        Open;
//
//      Append;
//      FieldByName('IPR_SEQGER').AsString  := strSeqGer;
//      FieldByName('IPR_CODITE').AsString  := strCodIte;
//      FieldByName('IPR_QTDLIM').AsString  := strQtdLim;
//      FieldByName('IPR_QTDMIN').AsString  := strQtdMin;
//      FieldByName('IPR_PRECUS').AsFloat   := fltPreCus;
//      FieldByName('IPR_PREVEN').AsFloat   := fltPreVen;
//      FieldByName('IPR_PERDES').AsFloat   := fltPerDes;
//      FieldByName('IPR_PRZMED').AsInteger := intPrzMed;
//      FieldByName('IPR_COMVAR').AsFloat   := fltComVar;
//      FieldByName('IPR_COMATA').AsFloat   := fltComAta;
//      FieldByName('IPR_COMDIS').AsFloat   := fltComDis;
//
//      If FindField('IPR_CODEMP') <> Nil Then
//        FieldByName('IPR_CODEMP').AsString := VS_strCodEmp;
//
//      FieldByName('IPR_PREVE2').AsFloat := fltPreve2;
//      FieldByName('IPR_PREVE3').AsFloat := fltPreve3;
//      FieldByName('IPR_PREVE4').AsFloat := fltPreve4;
//      FieldByName('IPR_PREVE5').AsFloat := fltPreve5;
//      FieldByName('IPR_PREVE6').AsFloat := fltPreve6;
//      FieldByName('IPR_PREVE7').AsFloat := fltPreve7;
//      FieldByName('IPR_VLDSAD').AsFloat := fltVlDsAd;
//      FieldByName('IPR_TBDSAD').AsInteger := intTbDsAd;
//      FieldByName('IPR_PEREST').Asfloat := fltPerEst;
//      FieldByName('IPR_SEQKIT').AsString  := strSequencialKit;
//
//      FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEPRO', VS_strCodEmp);
//      Post;
//    End;
//    Result := True;
//
//  Except
//    On E: Exception Do
//    Begin
//      pMensagensErro(E.Message, '[fGravaCadIpr]');
//      Result := False;
//    End;
//  End;
//
//  FreeAndNil(qryItePro);
//
//end;

procedure pDeletaItensPromocao(strAutInc: String; var arrItens : TArrTipoMatrizItensPromo);
  Var
    strSQL   : String;
    qryGenPro: TUniQuery;

  procedure pCarregarArrItens;
    var
      LTItensPromo : TItensPromo;
  begin

    qryGenPro.Close;
    qryGenPro.SQL.Clear;
    qryGenPro.SQL.Add('SELECT AUTOINCREM, IPR_CODITE FROM ITEPRO WHERE IPR_SEQGER = :AUTINC');
    qryGenPro.ParamByName('AUTINC').AsString := strAutInc;
    qryGenPro.Open;

    FillChar(arrItens, SizeOf(arrItens), #0);

    If Not qryGenPro.IsEmpty Then
    Begin

      qryGenPro.First;
      While Not qryGenPro.Eof Do
      Begin

        LTItensPromo.strAutInc := qryGenPro.FieldByName('AUTOINCREM').AsString;
        LTItensPromo.strCodIte := qryGenPro.FieldByName('IPR_CODITE').AsString;

        SetLength(arrItens, Length(arrItens) + 1);
        arrItens[Length(arrItens) - 1] := LTItensPromo;

        qryGenPro.Next;
      End;

    End;

  end;

begin
  Try

    qryGenPro := fCriaQuery(nil);
    pCarregarArrItens;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ITEPRO WHERE IPR_SEQGER = :AUTINC ';

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPro);
  End;

end;

{***********************************}
{* VERIFICA A QUANTIDADE LIMITE DA *}
{* PROMOÇÃO                        *}
{********************************AF*}
{********************************VA*}
function fDadosPromocao(strCodIte, strCodEmp: String;
  strCodCli: String = ''; strTabPre: String = ''; strENTBRF: String = '';
  strNumOrc: String = ''; strEspOrc: String = ''; strCodPro: String = '';
  Conexao: TUniConnection = Nil): TDadosPromocao;
begin
  Result.strCodPro := '';

  If fCfgSis('TABLOI', VarBoolean) Then
    Result := fDadosPromocao(strCodIte, strCodEmp,
                             strCodCli, strTabPre, strENTBRF,
                             strNumOrc, strEspOrc, strCodPro,
                             True, Conexao);

  If fEmptyStr(Result.strCodPro) Then
    Result := fDadosPromocao(strCodIte, strCodEmp,
                             strCodCli, strTabPre, strENTBRF,
                             strNumOrc, strEspOrc, strCodPro,
                             False, Conexao);
end;

function fDadosPromocao(strCodIte, strCodEmp: String;
  strCodCli: String; strTabPre: String; strENTBRF: String;
  strNumOrc: String; strEspOrc: String; strCodPro: String;
  blnTabloid: Boolean; Conexao: TUniConnection): TDadosPromocao; Overload;
  Var
    strSQL: String;
    strQtdPedido: String;
    qryPro: TUniQuery;

    procedure pRetorno;
    begin
      Result.strCodPro := qryPro.FieldByName('CODPRO').AsString;
      Result.fltQtdMin := fFormataFloat(qryPro.FieldByName('QTDMIN').AsFloat, 4);
      Result.fltQtdLim := fFormataFloat(qryPro.FieldByName('QTDLIM').AsFloat, 4);
      Result.fltQtdDis := fFormataFloat(qryPro.FieldByName('QTDDIS').AsFloat, 4);
      Result.strDesPro := qryPro.FieldByName('DESPRO').AsString;
      Result.dtaDtaFin := qryPro.FieldByName('PRO_DTAFIN').AsDateTime;
    end;
begin
  Result.fltQtdMin := 0;
  Result.fltQtdLim := 0;
  Result.fltQtdDis := 0;
  Result.dtaDtaFin := 0;

  Try
    If Assigned(Conexao) Then
      qryPro := fCriaQuery(Nil, Conexao)
    Else
      qryPro := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   PRO_CODPRO AS CODPRO, ';
    strSQL := strSQL + '   PRO_DESPRO AS DESPRO, ';
    strSQL := strSQL + '   IFNULL(PROCLI.PRO_CODCLI, "TODOS") AS CODCLI, ';
    strSQL := strSQL + '   IFNULL(IPREMP.IPR_QTDDIS, 0)                  ';

    strQtdPedido := '0.00';

    If (Not fEmptyStr(strEspOrc)) And (Not fEmptyStr(strNumOrc)) And (strEspOrc = 'PD') Then
    Begin
      strQtdPedido := '';
      strQtdPedido := strQtdPedido + '  (SELECT IFNULL(SUM(FDO_QTDITE), 0)   ';
      strQtdPedido := strQtdPedido + '   FROM FATDOR                         ';
      strQtdPedido := strQtdPedido + '     INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
      strQtdPedido := strQtdPedido + '   WHERE FDO_NUMDOC = :NUMORC          ';
      strQtdPedido := strQtdPedido + '     AND FDO_ESPDOC = :ESPORC          ';
      strQtdPedido := strQtdPedido + '     AND IF(IFNULL(FDO_EMPITE,"") <> "", FDO_EMPITE, FDO_CODEMP) = :CODEMP ';
      strQtdPedido := strQtdPedido + '     AND FDO_CODITE = :CODITE          ';

      If fCfgSis('TABLOI', VarBoolean) Then
        strQtdPedido := strQtdPedido + '     AND FDO_CODPRO = PRO_CODPRO    ';

      strQtdPedido := strQtdPedido + '     AND FDO_PROMOC = "S"             )';
    End;

    strSQL := strSQL + ' + ' + strQtdPedido + ' AS QTDDIS, ';

    strSQL := strSQL + '  (CASE ';
    strSQL := strSQL + '     WHEN (IFNULL(ITEPRO.IPR_QTDMIN, 0) = 0) AND ';
    strSQL := strSQL + '          (CADPRO.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva].ToString+') THEN ';
    strSQL := strSQL + '       IFNULL(CADPRO.PRO_QTDMIN, 0) ';
    strSQL := strSQL + '   ELSE ';
    strSQL := strSQL + '     IFNULL(ITEPRO.IPR_QTDMIN, 0) ';
    strSQL := strSQL + '   END) AS QTDMIN, ';
    strSQL := strSQL + '  (CASE ';
    strSQL := strSQL + '     WHEN (IFNULL(ITEPRO.IPR_QTDLIM, 0) = 0) AND ';
    strSQL := strSQL + '          (CADPRO.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva].ToString+') THEN ';
    strSQL := strSQL + '       IFNULL(CADPRO.PRO_QTDLIM, 0) ';
    strSQL := strSQL + '   ELSE ';
    strSQL := strSQL + '     IFNULL(ITEPRO.IPR_QTDLIM, 0) ';
    strSQL := strSQL + '   END) AS QTDLIM, ';
    strSQL := strSQL + '  (CASE ';
    strSQL := strSQL + '     WHEN ';
    strSQL := strSQL + '          ((CADPRO.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[ tdpPrecoPorVlrMinProd ].ToString+') OR ';
    strSQL := strSQL + '           (CADPRO.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[ tdpDescPorVlrMinProd ].ToString+')) THEN ';
    strSQL := strSQL + '       IFNULL(CADPRO.PRO_VLRMIN, 0) ';
    strSQL := strSQL + '   ELSE 0 ';
    strSQL := strSQL + '   END) AS VLRMIN, ';
    strSQL := strSQL + '   CADPRO.PRO_DTAFIN ';
    strSQL := strSQL + 'FROM                                          ';
    strSQL := strSQL + '  CADPRO                                      ';
    strSQL := strSQL + '  INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
    strSQL := strSQL + '  LEFT JOIN PROCLI  ON CADPRO.AUTOINCREM = PROCLI.PRO_SEQGER ';
    strSQL := strSQL + '  LEFT JOIN IPREMP  ON ITEPRO.AUTOINCREM = IPREMP.IPR_SEQGER ';
    strSQL := strSQL + '                   AND PROEMP.PRO_CODEMP = IPREMP.IPR_CODEMP ';
    strSQL := strSQL + 'WHERE                                           ';
    strSQL := strSQL + '   '  + fCurrentDate + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
    strSQL := strSQL + ' AND ITEPRO.IPR_CODITE = :CODITE ';
    strSQL := strSQL + ' AND PROEMP.PRO_CODEMP = :CODEMP ';
    strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre);
    strSQL := strSQL + fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli);

    If fCfgSis('TABLOI', VarBoolean) Then
      If blnTabloid Then
        strSQL := strSQL + ' AND CADPRO.PRO_TABLOI = "S" ' //Se for promocao tabloid valida somente com outra promocao tabloid
      Else
        strSQL := strSQL + ' AND CADPRO.PRO_TABLOI = "N" '; //Se não for promocao tabloid valida somente com outra promocao não tabloid

    If Not fEmptyStr(strCodPro) Then
      strSQL := strSQL + ' AND CADPRO.PRO_CODPRO = :CODPRO '
    Else
      strSQL := strSQL + fGetFiltroQuantidadeLimite(strQtdPedido);

    strSQL := strSQL + ' ORDER BY CADPRO.PRO_TABLOI DESC, QTDMIN ASC ';

    With qryPro Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strCodEmp;
      If (Not fEmptyStr(strEspOrc)) And (Not fEmptyStr(strNumOrc)) And (strEspOrc = 'PD') Then
      Begin
        ParamByName('NUMORC').AsString := strNumOrc;
        ParamByName('ESPORC').AsString := strEspOrc;
      End;

      If Not fEmptyStr(strCodPro) Then
      Begin
        ParamByName('CODPRO').AsString := strCodPro;
      End;

      Open;

      If (Not IsEmpty) Then
      Begin
        If fEmptyStr(strCodCli) Then
        Begin
          If Locate('CODCLI', 'TODOS', []) Then
            pRetorno;
        End
        Else
        Begin
          If Locate('CODCLI', strCodCli, []) Then
            pRetorno
          Else If Locate('CODCLI', 'TODOS', []) Then
            pRetorno
        End;
      End;

      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryPro);

end;

Function fSqlSelectPrecosPromocao(strCodCnd: String): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  IFNULL(IPR_PRECUS, 0) AS IPR_PRECUS, ';
  strSQL := strSQL + '  IFNULL(IPR_PREVEN, 0) AS IPR_PREVEN, ';
  strSQL := strSQL + '  IFNULL(IPR_PERDES, 0) AS IPR_PERDES, ';
  strSQL := strSQL + '  IFNULL(IPR_PRZMED, 0) AS IPR_PRZMED, ';
  strSQL := strSQL + '  IFNULL(IPR_COMVAR, 0) AS IPR_COMVAR, ';
  strSQL := strSQL + '  PRO_ENTIME,                          ';
  strSQL := strSQL + '  PRO_ENTFUT,                          ';
  strSQL := strSQL + '  PRO_AGUCLI,                          ';
  strSQL := strSQL + '  PRO_PREVIS,                          ';
  strSQL := strSQL + '  PRO_FALPRO,                          ';
  strSQL := strSQL + '  PRO_COMPRO,                          ';
  strSQL := strSQL + '  PRO_UTILIM,                          ';
  strSQL := strSQL + '  IFNULL(IPR_COMATA, 0) AS IPR_COMATA,  ';
  strSQL := strSQL + '  CASE                                               ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 1, 1) = "S" THEN "1" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 2, 1) = "S" THEN "2" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 3, 1) = "S" THEN "3" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 4, 1) = "S" THEN "4" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 5, 1) = "S" THEN "5" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 6, 1) = "S" THEN "6" ';
  strSQL := strSQL + '     WHEN SUBSTRING(PRO_TABPRE, 7, 1) = "S" THEN "7" ';
  strSQL := strSQL + '     ELSE "1"                                        ';
  strSQL := strSQL + '  END AS PRO_TABPRE, ';
  strSQL := strSQL + '  PRO_QTDLIM, PRO_QTDMIN, PRO_IDXPRO, PRO_CODPRO, ';
  strSQL := strSQL + '  IPR_PREVE2, IPR_PREVE3, IPR_PREVE4, IPR_PREVE5, ';
  strSQL := strSQL + '  IPR_PREVE6, IPR_PREVE7, ';
  strSQL := strSQL + '  IFNULL(IPR_COMDIS, 0) AS IPR_COMDIS  ';

  If Not fEmptyStr(strCodCnd) Then
    strSQL := strSQL + '  , GROUP_CONCAT(CPR_CODCND SEPARATOR "_") AS CODCND ';

  strSQL := strSQL + '  ,IPR_VLDSAD, PRO_VLRMIN, IPR_PFTMIM  ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPRO P ';
  strSQL := strSQL + '  LEFT  JOIN CNDPRO    ON   CPR_SEQGER = P.AUTOINCREM ';
  strSQL := strSQL + '  INNER JOIN ITEPRO    ON P.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';

  Result := strSQL;
End;

Function fSqlWherePrecosPromocao(strCodCnd, strPrzPro, strTabPre, strCodCli: String; blnConsiderarTodasAsCondicoes : Boolean = False): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PE.PRO_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  IPR_CODITE    = :CODITE AND ';

  If fEmptyStr(strPRZPRO) Then
    strPRZPRO := fCfgSis('PRZPRO');

  If strPRZPRO = 'S' Then
  Begin
    If Not fEmptyStr(strCodCnd) Then
      strSQL := strSQL + '  IF(CPR_CODCND IS NULL, IPR_PRZMED >= :PRZMED, TRUE) AND '
    Else
      strSQL := strSQL + '  IPR_PRZMED >= :PRZMED AND ';
  End;

  if blnConsiderarTodasAsCondicoes then
    strSQL := strSQL + '  (CPR_CODCND IS NULL) AND '
  else if (not fEmptyStr(strCodCnd)) and fValidarCondicaoEPrazoDePagamentoNasPromocoes then
    strSQL := strSQL + '  CPR_CODCND    = :CODCND AND ';

  strSQL := strSQL + '  PRO_DTAINI <= :DTAPRO AND PRO_DTAFIN >= :DTAPRO ';

  strSQL := strSQL + fGetFiltroTabelaPrecoPromocao(strTabPre);
  strSQL := strSQL + fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli);

  Result := strSQL;
End;

function fDeveFiltrarTabelPrecoNaPromocao : Boolean;
begin
  If fEmptyStr(VS_ALITPR) Then
  Begin
    If fCfgSis('ALITPR', varBoolean) then
      VS_ALITPR := 'S'
    Else
      VS_ALITPR := 'N';
  End;
  If (VS_ALITPR = 'S') Then
    Result := False
  Else
    Result := True;
end;

Function fGetFiltroTabelaPrecoPromocao(strTabPre: String; strAlias: String = ''): String;
  Var
    intTab: Integer;
begin
  Result := '';

  If (Not fDeveFiltrarTabelPrecoNaPromocao) then
    Exit;

  //Promocoes da tabela de preco informada ou que nao estejam vinculadas a nenhuma tabela de preco
  If Not fEmptyStr(strTabPre) Then
  Begin
    //Caso veio por parametro o numero da tabela de preco
    If CharInSet(strTabPre[1], ['1'..'7']) Then
    Begin
      Result := ' AND MID('+strAlias+'PRO_TABPRE, ' +  strTabPre + ', 1) = "S" '; //Exemplo: tabela 3 "NNSNNNN"
    End
    //caso veio por exemplo 'NNSNNSS' (Usa as tabelas 3, 6 e 7)
    Else If Pos('S', strTabPre) > 0 Then
    Begin
      For intTab := 1 To Length(strTabPre) Do
      Begin
        If strTabPre[intTab] = 'S' Then
        Begin
          If Not fEmptyStr(Result) Then
            Result := Result + ' OR ';
          Result := Result + ' (MID('+strAlias+'PRO_TABPRE, ' +  intToStr(intTab) + ', 1) = "S") '; //Exemplo: Tabela 3 "NNSNNNN"
        End;
      End;
      Result := ' AND ( ' + Result + ' ) ';
    End;
  End;
end;

function fGetFiltroQuantidadeLimite(strQtdPedido: String = '0'): String;
begin
  If Not fCfgSis('TABLOI', VarBoolean) Then
    Exit('');

  Result := ' AND (IF(IFNULL(IPR_QTDLIM, 0) <= 0, TRUE, IF(IFNULL(IPR_QTDDIS, 0) + ' + strQtdPedido + ' > 0, TRUE, FALSE))) ';
end;

function fEhPromocaoTabloid(strCodPro: string): Boolean;
begin
 Result := fCampoTabela('PRO_TABLOI', 'CADPRO', ['PRO_CODPRO'], [strCodPro], False) = 'S';
end;

function fTemPromocaoTabloid(ArrItemPro: Array Of TrecItemPro): Boolean;
var
  intIndice: integer;
begin
  Result := False;

  for intIndice := Low(ArrItemPro) To High(ArrItemPro) do
  begin
    if fEhPromocaoTabloid(ArrItemPro[intIndice].strCodPro) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

function fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli: String; strAlias: String = ''): String;
begin
  Result := '';

  If fEmptyStr(strCodCli) Then
    Exit;

  If Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True) Then
    Exit;

  Result := ' AND '+strAlias+'PRO_RESNCO = "N" ';
end;

Function fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli: String; blnTabloid: Boolean; blnProEsc : Boolean = False; blnConsiderarTodasAsCondicoes : Boolean = False): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + fSqlSelectPrecosPromocao(strCodCnd);
  strSQL := strSQL + ' LEFT JOIN PROCLI C  ON P.AUTOINCREM =  C.PRO_SEQGER ';
  strSQL := strSQL + fSqlWherePrecosPromocao(strCodCnd, strPrzPro, strTabPre, strCodCli, blnConsiderarTodasAsCondicoes);
  strSQL := strSQL + ' AND C.PRO_CODCLI IS NULL ';

  If blnProEsc Then
    strSQL := strSQL + ' AND IPR_QTDMIN = ' + '(' + fSqlRetQtdMinPromocaoEscalonada + ')';

  If fCfgSis('TABLOI', VarBoolean) Then
    If blnTabloid Then
      strSQL := strSQL + ' AND P.PRO_TABLOI = "S" '
    Else
      strSQL := strSQL + ' AND P.PRO_TABLOI = "N" ';

  If Not fEmptyStr(strCodCli) Then
  Begin
    If fClientePessoaFisica(strCodCli) Then
      strSQL := strSQL + ' AND ((P.PRO_TIPCLI IS NULL) OR (P.PRO_TIPCLI = "F")) '
    Else
      strSQL := strSQL + ' AND ((P.PRO_TIPCLI IS NULL) OR (P.PRO_TIPCLI = "J")) ';
  End;

  strSQL := strSQL + ' GROUP BY P.AUTOINCREM ';
  Result := strSQL;
End;

Function fSqlPromocaoCliente(strCodCnd, strPrzPro, strCodCli, strTabPre: String; blnTabloid: Boolean; blnProEsc : Boolean = False; blnConsiderarTodasAsCondicoes : Boolean = False): String;
  Var
    strSQL   : String;
Begin
  strSQL := '';
  strSQL := strSQL + fSqlSelectPrecosPromocao(strCodCnd);
  strSQL := strSQL + ' INNER JOIN PROCLI C ON P.AUTOINCREM = C.PRO_SEQGER ';
  strSQL := strSQL + fSqlWherePrecosPromocao(strCodCnd, strPrzPro, strTabPre, strCodCli, blnConsiderarTodasAsCondicoes);
  strSQL := strSQL + ' AND C.PRO_CODCLI = ' + QuotedStr(strCodCli);

  If blnProEsc Then
    strSQL := strSQL + ' AND IPR_QTDMIN = ' + '(' + fSqlRetQtdMinPromocaoEscalonada + ')';

  If fCfgSis('TABLOI', VarBoolean) Then
    If blnTabloid Then
      strSQL := strSQL + ' AND P.PRO_TABLOI = "S" '
    Else
      strSQL := strSQL + ' AND P.PRO_TABLOI = "N" ';

  strSQL := strSQL + ' GROUP BY P.AUTOINCREM ';
  strSQL := strSQL + ' ORDER BY P.PRO_TABLOI DESC '; //Promoção Tabloid (S) tem prioridade
  Result := strSQL;
End;

Function fSqlRetQtdMinPromocaoEscalonada : String;
  var
    strSQL : String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT           ';
  strSQL := strSQL + '  ITE.IPR_QTDMIN ';
  strSQL := strSQL + 'FROM             ';
  strSQL := strSQL + '  ITEPRO ITE     ';
  strSQL := strSQL + 'WHERE            ';
  strSQL := strSQL + '  ITE.IPR_SEQGER  = P.AUTOINCREM AND ';
  strSQL := strSQL + '  ITE.IPR_CODITE  = :CODITE      AND ';
  strSQL := strSQL + '  ITE.IPR_QTDMIN <= :QTDDIG ';
  strSQL := strSQL + 'ORDER BY                    ';
  strSQL := strSQL + '  ITE.IPR_QTDMIN DESC       ';
  strSQL := strSQL + 'LIMIT 1 ';

  Result := strSQL;

End;

function fRetornaPrecosPromocao(strCodIte,
                                strCodCli: String;
                                dtaDtaPro: TDateTime;
                                fltQtdDig,
                                fltQtdJaDig,
                                fltQtdJaEmPromoc: Double;
                                intPraMed: Integer;
                                Var fltPreCus,
                                fltPreVen,
                                fltComVar,
                                fltComAta,
                                fltComDis,
                                fltQtdDis,
                                fltDesF07: Double;
                                Var strComPro: String;
                                var strCodPro: String;
                                Var blnParticiona,
                                blnPromo: Boolean;
                                strTabPre: String;
                                strCodCnd: String;
                                strPrzPro: String = '';
                                strENTBRF: String = '';
                                blnConsideraQtd: Boolean=True;
                                blnBuscaPreco: Boolean=False;
                                strIteVid: String = '-1';
                                blnEntIme: Boolean=False;
                                blnEntFut: Boolean=False;
                                strMotFut: String = '';
                                strEmpPro: String = '';
                                strNumOrc: String = '';
                                strEspOrc: String = '';
                                Conexao: TUniConnection = Nil;
                                blnEhConsulta: Boolean = False;
                                strUnMed: String = '';
                                objPromMinProd: TPromocaoVlrMinTotalProdutos = Nil;
                                strIteTin: String = '';
                                fltPrecoTotalColorantes : Double = 0): Boolean;
  var
    LfltPrecoTinta              : Double;
    LcdsClone                   : TUniClientDataSet;
    LstrTintaEmPromocao         : Variant;
    LstrCodigoPromocaoSemSerKit : String;
Begin
  Result := False;

  TProQtdColetiva.strIDKitAtivo := '';

  If fCfgSis('TABLOI', VarBoolean) Then
  Begin
    if (fCfgSis('PROKIT', VarBoolean)) and
       (Assigned(TProQtdColetiva.cdsDadosPromocaoKit)) And
       (not fEmptyStr(TProQtdColetiva.strRshTinAtual)) then
    Begin
      LcdsClone := TUniClientDataSet.Create(Nil);
      pCloneDataSet(LcdsClone, TProQtdColetiva.cdsDadosPromocaoKit);

      LfltPrecoTinta := 0;

      LstrCodigoPromocaoSemSerKit := '';

      LcdsClone.First;
      while not LcdsClone.Eof do
      Begin
        if (LcdsClone.FieldByName('KIT_ITETIN').AsString = TProQtdColetiva.strRshTinAtual) then
        Begin
          Result := False;

          if not fEmptyStr(LcdsClone.FieldByName('KIT_PROKIT').AsString) then
            Result := fRetornaPrecosPromocao(LcdsClone.FieldByName('KIT_CODITE').AsString,
              strCodCli, dtaDtaPro, LcdsClone.FieldByName('KIT_QTDGRU').AsFloat,
              fltQtdJaDig, fltQtdJaEmPromoc, intPraMed, fltPreCus, fltPreVen, fltComVar,
              fltComAta, fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona,
              blnPromo, strTabPre, strCodCnd, strPrzPro, strENTBRF, blnConsideraQtd,
              blnBuscaPreco, strIteVid, blnEntIme, blnEntFut, strMotFut, strEmpPro, strNumOrc,
              strEspOrc, Conexao, blnEhConsulta, True, strUnMed, objPromMinProd, strIteTin, fltPrecoTotalColorantes);

          if Result then
          Begin
            LfltPrecoTinta := LfltPrecoTinta + fltPreVen;

            LcdsClone.Edit;
            LcdsClone.FieldByName('KIT_PROMOC').AsString := 'S';
            LcdsClone.Post
          End
          else
            LfltPrecoTinta := LfltPrecoTinta + LcdsClone.FieldByName('KIT_PREVEN').AsFloat;

          {***********************************************************************************
           Armazenando o codigo da promoção que não é por kit, caso haja em algum componente da
           tinta. Se houver, essa promoção veio aplicada da DLL, portanto essa terá aplicação
           independente de ter kit ativo ou não. Será seu código que sera gravado na CODPRO
           das tabelas de movimentação
           ******************************************************************************GD**}
          if (fEmptyStr(LstrCodigoPromocaoSemSerKit)) and
             (not fEmptyStr(LcdsClone.FieldByName('KIT_PRONOR').AsString)) then
            LstrCodigoPromocaoSemSerKit := LcdsClone.FieldByName('KIT_PRONOR').AsString;
        End;

        LcdsClone.Next;
      End;

      fltPreVen := LfltPrecoTinta;

      {***********************************************************************************
      Se a tinta veio como em promoção da DLL da tinta, independente se algum componente
      entrou em promoção por kit, a mesma deve continuar com status em promoção. Do contrario
      deve-se avaliar se algum componente desta entrou em promoção pelo conceito de kit
       ******************************************************************************GD**}
      LstrTintaEmPromocao := 'N';
      if Assigned(TProQtdColetiva.DicTintasEmPromocao) then
        LstrTintaEmPromocao := TProQtdColetiva.DicTintasEmPromocao.Retorna(TProQtdColetiva.strRshTinAtual);

      if LstrTintaEmPromocao = 'S' then
      Begin
         strCodPro := LstrCodigoPromocaoSemSerKit;
         Exit(True);
      End
      Else
      Begin
        LcdsClone.First;
        while not LcdsClone.Eof do
        Begin
          if (LcdsClone.FieldByName('KIT_ITETIN').AsString = TProQtdColetiva.strRshTinAtual) and
             (LcdsClone.FieldByName('KIT_PROMOC').AsString = 'S') then
            Exit(True);

          LcdsClone.Next;
        End;
      End;

      FreeAndNil(LcdsClone);

      Exit;

    End
    Else
    Begin
      Result := fRetornaPrecosPromocao(strCodIte, strCodCli, dtaDtaPro, fltQtdDig,
        fltQtdJaDig, fltQtdJaEmPromoc, intPraMed, fltPreCus, fltPreVen, fltComVar,
        fltComAta, fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona,
        blnPromo, strTabPre, strCodCnd, strPrzPro, strENTBRF, blnConsideraQtd,
        blnBuscaPreco, strIteVid, blnEntIme, blnEntFut, strMotFut, strEmpPro, strNumOrc,
        strEspOrc, Conexao, blnEhConsulta, True, strUnMed, objPromMinProd, strIteTin, fltPrecoTotalColorantes);

      Result := Result And (Not blnParticiona);
    End;
  End;

  If Not Result Then
    Result := fRetornaPrecosPromocao(strCodIte, strCodCli, dtaDtaPro, fltQtdDig,
      fltQtdJaDig, fltQtdJaEmPromoc, intPraMed, fltPreCus, fltPreVen, fltComVar,
      fltComAta, fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPro, blnParticiona,
      blnPromo, strTabPre, strCodCnd, strPrzPro, strENTBRF, blnConsideraQtd,
      blnBuscaPreco, strIteVid, blnEntIme, blnEntFut, strMotFut, strEmpPro, strNumOrc,
      strEspOrc, Conexao, blnEhConsulta, False, strUnMed, objPromMinProd, strIteTin, fltPrecoTotalColorantes);
End;

function fRetornaPrecosPromocao(strCodIte,
                                strCodCli: String;
                                dtaDtaPro: TDateTime;
                                fltQtdDig,
                                fltQtdJaDig,
                                fltQtdJaEmPromoc: Double;
                                intPraMed: Integer;
                                Var fltPreCus,
                                fltPreVen,
                                fltComVar,
                                fltComAta,
                                fltComDis,
                                fltQtdDis,
                                fltDesF07: Double;
                                Var strComPro: String;
                                var strCodPro: String;
                                Var blnParticiona,
                                blnPromo: Boolean;
                                strTabPre: String;
                                strCodCnd: String;
                                strPrzPro: String;
                                strENTBRF: String;
                                blnConsideraQtd: Boolean;
                                blnBuscaPreco: Boolean;
                                strIteVid: String;
                                blnEntIme: Boolean;
                                blnEntFut: Boolean;
                                strMotFut: String;
                                strEmpPro: String;
                                strNumOrc: String;
                                strEspOrc: String;
                                Conexao: TUniConnection;
                                blnEhConsulta: Boolean;
                                blnTabloid: Boolean;
                                strUnMed: String = '';
                                objPromMinProd: TPromocaoVlrMinTotalProdutos = Nil;
                                strIteTin: String = '';
                                fltPrecoTotalColorantes : Double = 0): Boolean; overload;
  Const
    CONSIDERAR_TODAS_CONDICOES_PAGAMENTO = True;

  Var
    qryGenPro: TUniQuery;
    dadosPromocao: TDadosPromocao;
    blnCarregarPromocao: Boolean;
    fltPerDesCnd: Double;
    fltUntEmbFec: Double;
    strEmpIte: String;
    strTabUti : String;
    intDecUni : Integer;
    LParametrosProduto : TParametrosProduto;
    fltPreVenPromVlrMin: Double;
    blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;

  Function fAchaPromocao(strSql: String): Boolean;
  Begin
    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString   := strEmpIte;
      ParamByName('CODITE').AsString   := LParametrosProduto.strCodigoProduto;
      ParamByName('DTAPRO').AsDateTime := dtaDtaPro;

      If fCfgSis('PRZPRO', varBoolean) Then
        ParamByName('PRZMED').AsInteger  := intPraMed;

      if Assigned(FindParam('CODCND')) then
        ParamByName('CODCND').AsString   := strCodCnd;

      If Assigned(FindParam('QTDDIG')) Then
        ParamByName('QTDDIG').AsFloat := fltQtdDig + fltQtdJaDig;

      Open;

      Result := False;
      If (Not IsEmpty) Then
      Begin
        Result := True;
        If (Not fEmptyStr(strCodCnd)) Then
        Begin
          If (Not fEmptyStr(FieldByName('CODCND').AsString)) Then
          Begin
            Result := (Pos(strCodCnd, FieldByName('CODCND').AsString) > 0);
          End;
        End;
      End;
    End;
  End;

  function fEhPromocaoComDiversasTabelaDePreco(const AId: Integer): Boolean;
  begin
    Result := (TTipDescPro(AId) In [tdpEstoqueRemanescente,
                                    tdpNegociacaoEspecialFornecedorPC,
                                    tdpPorcentoDescontoComDescontoAdicional]);
  end;

  function fCarregouPromocaoPorQuantidadeMinimaEscalonada : Boolean;
  begin

    If fEmptyStr(strCodCli) Then
      Exit(fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid, True)));

    Result := fAchaPromocao(fSqlPromocaoCliente(strCodCnd, strPrzPro, strCodCli, strTabPre, blnTabloid, True)) Or
              fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid, True));

  end;

  function fRetIdxPro : Integer;
    Const
      FIELD = 'PRO_IDXPRO';
    Var
      intIdxPro : Integer;
  begin

    Result := -1;

    If qryGenPro.IsEmpty Then
      Exit;

    If qryGenPro.FieldByName(FIELD).IsNull Then
      Exit;

    If TryStrToInt(qryGenPro.FieldByName(FIELD).AsString, intIdxPro) Then
      Result := intIdxPro;

  end;

  function fExcedeuLimitePorClienteOuVenda(var AQtdDis : Double) : Boolean;
    var
      objPromocaoLimitePorClienteOuVenda : TPromocaoLimitePorClienteOuVenda;
      LQtdVendas : Double;
      LQtdMaxima : Double;
  begin

    Result := False;

    objPromocaoLimitePorClienteOuVenda := TPromocaoLimitePorClienteOuVenda.Create(strCodPro);

    Try

      If (objPromocaoLimitePorClienteOuVenda.TipPro = pulSemLimite) Then
        Exit;

      objPromocaoLimitePorClienteOuVenda.pSetCodCli(strCodCli);
      objPromocaoLimitePorClienteOuVenda.pSetCodIte(strCodIte);
      objPromocaoLimitePorClienteOuVenda.pSetQtdVen(fltQtdDig);
      If (Not fEmptyStr(strNumOrc)) And (Not fEmptyStr(strEspOrc)) And (strEspOrc = 'PD') Then
      Begin
        objPromocaoLimitePorClienteOuVenda.pSetNumDoc(strNumOrc);
        objPromocaoLimitePorClienteOuVenda.pSetEspDoc(strEspOrc);
        objPromocaoLimitePorClienteOuVenda.pSetEmpDoc(VS_strCodEmp);
      End;

      LQtdVendas := objPromocaoLimitePorClienteOuVenda.fRetQtdVendas;
      LQtdMaxima := objPromocaoLimitePorClienteOuVenda.fRetQtdMaxima;

      Result := (LQtdVendas + fltQtdDig) > LQtdMaxima;

      If (Result) Then
        AQtdDis := (LQtdMaxima - LQtdVendas);

    Finally
      FreeAndNil(objPromocaoLimitePorClienteOuVenda);
    End;

  end;

begin
  LParametrosProduto := fCarregarParametrosProduto(strCodIte, strUnMed);
  if not Assigned(LParametrosProduto) then
    Exit(False);

  intDecUni := fCfgSis('DECUNI', varInteger);

  If fEmptyStr(strEmpPro) Then
    strEmpIte := VS_strCodEmp
  Else
    strEmpIte := strEmpPro;

   blnPromo := False;
   blnParticiona := False;

  {**********************************************************************}
  {* CASO FOR QUANTIDADE DE EMBALAGEM FECHADA, IRA CALCULAR O PRECO     *}
  {* COM BASE NO PRECO DE TABELA MENOS O DESCONTO DA EMBALAGEM FECHADA, *}
  {* OU SEJA IGNORA QUE O PRODUTO ESTA EM PROMOCAO                      *}
  {******************************************************************JC**}
  If (Not blnConsideraQtd) And (Not blnBuscaPreco) And fEhEmbalagemFechadaItem(LParametrosProduto.strCodigoProduto, strTabPre, fltQtdDig) Then
  Begin
    Result := False;
    Exit;
  End;

  If fEhItemVendaVidro(LParametrosProduto.strCodigoProduto, strIteVid) Then
  Begin
    Result := False;
    Exit;
  End;

  If (Assigned(TEventosCadPro.fncOpcDoc)) Then
  begin
    if (MatchStr(TEventosCadPro.fOpcDoc, ['UC','OF'])) then
    begin
      Result := False;
      exit;
    end;
  end;

  {******************************************************************}
  {* SE HOUVER DESCONTO/ACRÉSCIMO PREÇO DE NEGOCIAÇÃO, CONSIDERA    *}
  {* ELE COMO VALOR DE VENDA EM TODO O SISTEMA AO INVÉS DA PROMOÇÃO *}
  {***************************************************************FC*}
  If TCadNegBussiness.fRetornaPrecoNegociacao(strCodCli, LParametrosProduto.strCodigoProduto, strTabPre, strEmpIte, fltPreVen, fltQtdDig, Conexao) Then
  Begin
    Result   := True;
    blnPromo := True;
    Exit;
  End;

  blnPrecoFixoParaTintaDeMaquinaImobiliaria := False;

  Try
    Result    := False;

    If Assigned(Conexao) Then
      qryGenPro := fCriaQuery(Nil, Conexao)
    Else
      qryGenPro := fCriaQuery(Nil);

    fltPreCus := 0.0;
    fltPreVen := 0.0;
    fltComVar := 0.0;
    fltComAta := 0.0;
    fltComDis := 0.0;
    fltQtdDis := 0.0;
    fltDesF07 := 0.0;

    If fEmptyStr(strCodCli) Then
    Begin

      blnCarregarPromocao := fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid));

      If (Not blnCarregarPromocao) Then
        If (Not fEmptyStr(strCodCnd)) And fValidarCondicaoEPrazoDePagamentoNasPromocoes Then
          blnCarregarPromocao := fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid, False, CONSIDERAR_TODAS_CONDICOES_PAGAMENTO));

    End
    Else
    Begin

      blnCarregarPromocao := fAchaPromocao(fSqlPromocaoCliente(strCodCnd, strPrzPro, strCodCli, strTabPre, blnTabloid)) Or
                             fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid));

      If (Not blnCarregarPromocao) Then
        If (Not fEmptyStr(strCodCnd)) And fValidarCondicaoEPrazoDePagamentoNasPromocoes Then
          blnCarregarPromocao := fAchaPromocao(fSqlPromocaoCliente(strCodCnd, strPrzPro, strCodCli, strTabPre, blnTabloid, False, CONSIDERAR_TODAS_CONDICOES_PAGAMENTO)) Or
                                 fAchaPromocao(fSqlPromocaoTodosClientes(strCodCnd, strPrzPro, strTabPre, strCodCli, blnTabloid, False, CONSIDERAR_TODAS_CONDICOES_PAGAMENTO));

    End;

    If (fEhPromocaoPorQuantidadeMinimaEscalonada(fRetIdxPro)) Then
      blnCarregarPromocao := fCarregouPromocaoPorQuantidadeMinimaEscalonada;

    If blnCarregarPromocao Then
      strComPro := qryGenPro.FieldByName('PRO_COMPRO').AsString ;

    strCodPro := qryGenPro.FieldByName('PRO_CODPRO').AsString;

    {**********************************************************************}
    {* SE O PRODUTO EM QUESTÃO É DO TIPO "ENTREGA IMEDIATA",              *}
    {* ENTÃO A PROMOÇÃO TEM QUE ESTAR CONFIGURADA PARA PERMITIR ENT. IME. *}
    {* SE NÃO RETORNARÁ O PREÇO ORIGINAL DA TABELA DE PREÇO               *}
    {*******************************************************************RS*}
    If blnCarregarPromocao And blnEntIme Then
    Begin
      If (qryGenPro.FieldByName('PRO_ENTIME').AsString = 'N') Then
      Begin
        blnCarregarPromocao := False;
        fltPreVen := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto, IIF(fEmptyStr(strTabPre), '1', strTabPre), strEmpIte, strCodCli, Conexao, fltDesF07, fltPreCus);
      End;
    End;

    {**********************************************************************}
    {* SE O PRODUTO EM QUESTÃO É DO TIPO "ENTREGA FUTURA",                *}
    {* ENTÃO A PROMOÇÃO TEM QUE ESTAR CONFIGURADA PARA PERMITIR ENT. FUT. *}
    {* SE NÃO RETORNARÁ O PREÇO ORIGINAL DA TABELA DE PREÇO               *}
    {*******************************************************************MM*}
    If blnCarregarPromocao And blnEntFut Then
    Begin
      If (qryGenPro.FieldByName('PRO_ENTFUT').AsString = 'N') Or
         ((strMotFut = 'A') And (qryGenPro.FieldByName('PRO_AGUCLI').AsString = 'N')) Or
         ((strMotFut = 'P') And (qryGenPro.FieldByName('PRO_PREVIS').AsString = 'N')) Or
         ((strMotFut = 'F') And (qryGenPro.FieldByName('PRO_FALPRO').AsString = 'N')) Then
      Begin
        blnCarregarPromocao := False;
        fltPreVen := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto, IIF(fEmptyStr(strTabPre), '1', strTabPre), strEmpIte, strCodCli, Conexao, fltDesF07, fltPreCus);
      End;
    End;

    If blnCarregarPromocao Then
    With qryGenPro Do
    Begin
      If blnConsideraQtd Then
        dadosPromocao := fDadosPromocao(LParametrosProduto.strCodigoProduto, strEmpIte, strCodCli, strTabPre, strENTBRF, strNumOrc, strEspOrc, qryGenPro.FieldByName('PRO_CODPRO').AsString, Conexao)
      Else
      Begin
        dadosPromocao.fltQtdMin := 0;
        dadosPromocao.fltQtdLim := 0;
        dadosPromocao.fltQtdDis := 0;
      End;

      Result    := True;
      blnPromo  := True;

      If (Assigned(qryGenPro.FindField('IPR_PFTMIM'))) And (fTipoDePromocaoSuportaPrecoFixoParaTmqImo(FieldByName('PRO_IDXPRO').AsInteger)) Then
        blnPrecoFixoParaTintaDeMaquinaImobiliaria := (qryGenPro.FieldByName('IPR_PFTMIM').AsString = 'S');

      fltComVar := FieldByName('IPR_COMVAR').AsFloat;
      fltComAta := FieldByName('IPR_COMATA').AsFloat;
      fltComDis := FieldByName('IPR_COMDIS').AsFloat;
      fltPreCus := FieldByName('IPR_PRECUS').AsFloat;

      strTabUti := IIF(fEmptyStr(strTabPre), IIF(fEmptyStr(FieldByName('PRO_TABPRE').AsString), '1', FieldByName('PRO_TABPRE').AsString), strTabPre);

      If (FieldByName('IPR_PERDES').AsFloat = 0) And
         (FieldByName('PRO_IDXPRO').AsInteger <> IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit]) Then
      Begin
        fltPreVen := FieldByName('IPR_PREVEN').AsFloat;

        If fEhPromocaoComDiversasTabelaDePreco(FieldByName('PRO_IDXPRO').AsInteger) And
           (Not fEmptyStr(strTabUti)) And
           (strTabUti <> '1') And
           (FindField('IPR_PREVE' + strTabUti) <> Nil) Then
        Begin
          fltPreVen := FieldByName('IPR_PREVE' + strTabUti).AsFloat;
        End;

        If (FieldByName('PRO_IDXPRO').AsInteger = IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoComDescontoAdicional]) Then
        Begin
          If (Assigned(FindField('IPR_VLDSAD'))) Then
            fltDesF07 := FieldByName('IPR_VLDSAD').AsFloat;

          If (fUsaPrecoDeVendaDinamicoForaDoEstado(strEmpIte)) Then
            fltPreVen := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto, strTabUti, strEmpIte, strCodCli, Conexao, fltDesF07, fltPreCus);
        End;
      End
      Else
      Begin
        If Not(FieldByName('PRO_IDXPRO').IsNull) And
          ((FieldByName('PRO_IDXPRO').AsInteger = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit])) And
          Assigned(TProQtdColetiva.cdsDadosPromocaoKit) Then
        Begin
          TProQtdColetiva.pAddOrUpdateItem(LParametrosProduto.strCodigoProduto,
                                           LParametrosProduto.strUnidadeMedida,
                                           FieldByName('PRO_CODPRO').AsString,
                                           fltQtdDig,
                                           FieldByName('PRO_QTDLIM').AsFloat,
                                           FieldByName('PRO_QTDMIN').AsFloat);

          fltPreVen := TProQtdColetiva.fGetPrecoVendaPeloKit(LParametrosProduto.strCodigoProduto,
                                                             LParametrosProduto.strUnidadeMedida,
                                                             strCodPro);
        End
        Else
        Begin
          fltPreVen := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto, strTabUti, strEmpIte, strCodCli, Conexao, fltDesF07, fltPreCus);
          If (blnPrecoFixoParaTintaDeMaquinaImobiliaria) Then
            fltPreVen := fltPreVen + fltPrecoTotalColorantes;
          fltPreVen := (fltPreVen - (fltPreVen * (FieldByName('IPR_PERDES').AsFloat / 100)));
          fltPreVen := fFormataFloat(fltPreVen, intDecUni);
        End;
      End;

      {***************************************************************}
      {* SE O CLIENTE USAR CFG_PRODES = "S" APLICA O DESCONTO MAXIMO *}
      {* VENDEDOR DA CONDIÇÃO DE PAGAMENTO NO PREÇO DA PROMOÇÃO      *}
      {************************************************************FC*}
      fltPerDesCnd := fRetDescMaxCnd(strCodCnd, mdVendedor);
      If fAplicaDescontoCondicaoItensEmPromocao(strCodCnd) Then
      Begin
        fltPreVen := fltPreVen - ((fltPreVen * fltPerDesCnd) / 100);
        fltPreVen := fFormataFloat(fltPreVen, intDecUni);
      End;

      If Not(FieldByName('PRO_IDXPRO').IsNull) Then
        If ((blnConsideraQtd) And ((FieldByName('PRO_IDXPRO').AsInteger In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva],
                                                                            IDX_TIPO_DESCONTO_PROMOCAO[tdpPorcentoDescontoQuantidadeColetiva]]))) Or
        ((FieldByName('PRO_IDXPRO').AsInteger = IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit])) Then
        Begin
          If Not blnEhConsulta Then
          Begin
            TProQtdColetiva.pAddOrUpdateItem(LParametrosProduto.strCodigoProduto,
                                             LParametrosProduto.strUnidadeMedida,
                                             FieldByName('PRO_CODPRO').AsString,
                                             fltQtdDig + IIF(TProQtdColetiva.OpcSys = tRegSysCaixa, fltQtdJaDig, 0),
                                             FieldByName('PRO_QTDLIM').AsFloat,
                                             FieldByName('PRO_QTDMIN').AsFloat);

            Result := TProQtdColetiva.fAtivaPromocao(FieldByName('PRO_CODPRO').AsString,
                                                     LParametrosProduto.strCodigoProduto,
                                                     LParametrosProduto.strUnidadeMedida);

            if not Result then
            Begin
              fltPreCus := 0.0;
              fltPreVen := 0.0;
              fltComVar := 0.0;
              fltComAta := 0.0;
              fltComDis := 0.0;
              fltQtdDis := 0.0;
              fltDesF07 := 0.0;
              strComPro := '';
              strCodPro := '';
            End;
          End;
        End
        Else If fCfgSis('UTIVMP', varBoolean) And (FieldByName('PRO_IDXPRO').AsInteger In [IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoPorVlrMinProd],
                                                                                           IDX_TIPO_DESCONTO_PROMOCAO[tdpDescPorVlrMinProd]]) Then
        Begin
          If Not blnEhConsulta Then
          Begin
            If Assigned(objPromMinProd)Then
            Begin
              fltPreVenPromVlrMin := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto,
                                                            strTabUti, strEmpIte, strCodCli,
                                                            Conexao, fltDesF07, fltPreCus);



              objPromMinProd.fAddOrUpdateItem(LParametrosProduto.strCodigoProduto,
                                              LParametrosProduto.strUnidadeMedida,
                                              qryGenPro.FieldByName('PRO_CODPRO').AsString,
                                              strIteTin,
                                              (fltQtdDig * fltPreVenPromVlrMin),
                                              qryGenPro.FieldByName('PRO_VLRMIN').AsFloat,
                                              0,
                                              (Not fEmptyStr(strCodPro)),
                                              fltQtdDig);

              Result :=  objPromMinProd.fAtivaPromocao(qryGenPro.FieldByName('PRO_CODPRO').AsString,
                                        LParametrosProduto.strCodigoProduto,
                                        LParametrosProduto.strUnidadeMedida);

            End
            Else
              Result := False;

            If Not Result Then
            Begin
              fltPreCus := 0.0;
              fltPreVen := 0.0;
              fltComVar := 0.0;
              fltComAta := 0.0;
              fltComDis := 0.0;
              fltQtdDis := 0.0;
              fltDesF07 := 0.0;
              strComPro := '';
              strCodPro := '';
            End;
            
          End;
        End
        Else If dadosPromocao.fltQtdLim > 0 Then
        Begin
          fltQtdDis := (dadosPromocao.fltQtdDis - fltQtdJaEmPromoc);

          If (fltQtdDis > 0) Then
          Begin

            If (fltQtdDig > fltQtdDis) Then
              blnParticiona := True;

            If (dadosPromocao.fltQtdMin > 0) And (fltQtdDig + fltQtdJaDig < dadosPromocao.fltQtdMin) And (Not blnEhConsulta) Then
              Result := False;
          End
          Else
            Result := False;

          If Result Then
          Begin
            If ((FieldByName('PRO_UTILIM').AsString = 'S') And fExcedeuLimitePorClienteOuVenda(fltQtdDis)) Then
            Begin
              blnParticiona := True;
              Result := False;
            End;
          End;

        End
        Else If ((FieldByName('PRO_UTILIM').AsString = 'S') And fExcedeuLimitePorClienteOuVenda(fltQtdDis)) Then
        Begin
          blnParticiona := True;
          Result := False;
        End
        Else If (dadosPromocao.fltQtdMin > 0) And (Not (fEhPromocaoPorQuantidadeMinimaEscalonada(FieldByName('PRO_IDXPRO').AsInteger))) Then
        Begin

          If Not (fltQtdDig + fltQtdJaDig >= dadosPromocao.fltQtdMin) And (Not blnEhConsulta)  Then
            Result := False;

        End;

      Close;
    End;

    If (Result) And (blnConsideraQtd) And (Not blnBuscaPreco) And (fEhEmbalagemFechadaItem(LParametrosProduto.strCodigoProduto, strTabPre, fltQtdDig)) Then
    Begin
      {***************************************************************}
      {* QUANDO É EMBALAGEM FECHADA, VERIFICA QUAL É O MELHOR PREÇO! *}
      {************************************************************RN*}
      Result := False;

      fltUntEmbFec := fRetPrecoVendaPromocao(LParametrosProduto.strCodigoProduto, IIF(fEmptyStr(strTabPre), '1', strTabPre), strEmpIte, strCodCli, Conexao, fltDesF07, fltPreCus);

      If (fFormataFloat(fltUntEmbFec, intDecUni) > 0) Then
      Begin
        If (Assigned(TEventosCadPro.fncGetUnitarioEmbalagemFechada)) Then
        begin
          fltUntEmbFec := TEventosCadPro.fGetUnitarioEmbalagemFechada(LParametrosProduto.strCodigoProduto, IIF(fEmptyStr(strTabPre), '1', strTabPre), fltQtdDig, fltUntEmbFec);
        End
        Else
          fltUntEmbFec := fGetUnitarioEmbalagemFechada(LParametrosProduto.strCodigoProduto, IIF(fEmptyStr(strTabPre), '1', strTabPre), fltQtdDig, fltUntEmbFec);
        {***************************************************************}
        {* QUANDO É EMBALAGEM FECHADA, VERIFICA QUAL É O MELHOR PREÇO! *}
        {************************************************************RN*}
        If (fFormataFloat(fltUntEmbFec, intDecUni) > 0) Then
          Result := fFormataFloat(fltPreVen, intDecUni) < fFormataFloat(fltUntEmbFec, intDecUni);
      End;

    End;

  Finally
    FreeAndNil(qryGenPro);
  End;

  if Assigned(LParametrosProduto) then
    FreeAndNil(LParametrosProduto);
end;

function fEhPromocaoPorQuantidadeMinimaEscalonada(const AId: Integer) : Boolean;
begin
  Result := (TTipDescPro(AId) In [tdpPrecoPorQuantidadeMinimaEscalonada,
                                  tdpPercentualPorQuantidadeMinimaEscalonada]);
end;

function fTipoDePromocaoSuportaPrecoFixoParaTmqImo(const ATipoPromocao : Integer) : Boolean;
begin
  Result := (fCfgSis('PEPFIM', varString) = 'S') And (TTipDescPro(ATipoPromocao) In [tdpPrecos, tdpDescon]);
end;

function fRetornaValorPromocional(strCodIte,
                                  strCodCli: String;
                                  strTabPre: String): Double;
  Var
    fltDesF07: Double;
    fltPreCus: Double;
    fltPreVen: Double;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    fltQtdDis: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    strComPro: String;
    strCodPro: String;
begin
  Result := 0;

  If (fRetornaPrecosPromocao(strCodIte,
                             strCodCli,
                             VS_Date,
                             1,
                             0,
                             0,
                             0,
                             fltPreCus,
                             fltPreVen,
                             fltComVar,
                             fltComAta,
                             fltComDis,
                             fltQtdDis,
                             fltDesF07,
                             strComPro,
                             strCodPro,
                             blnParticiona,
                             blnPromo,
                             strTabPre,
                             '',
                             '',
                             '',
                             False,
                             False,
                             '-1',
                             False,
                             False,
                             '',
                             '',
                             '',
                             '',
                             Nil,
                             True,
                             '')) Then
  Begin
    Result := fltPreVen;
  End;

end;

procedure pDeletaClientesPromocao(strAutInc: String);
  Var
    strSQL   : String;
    qryGenPro: TUniQuery;

begin
  Try

    qryGenPro := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM PROCLI WHERE PRO_SEQGER = :AUTINC ';

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPro);
  End;

end;

procedure pDetalhesPromocao(strCodIte, strCodEmp, strTabPre, strCodPro: String);
var
  strSQL    : String;
  qryPro    : TUniQuery;
  arrMsg    : TStringArray;
  fltPre    : Double;
  j         : Integer;
  strDesTab : String;
  strDesIte : String;
  intDecQtd : Integer;
  intDecUni : Integer;
begin
  strSQL := '';
  strSQL := strSQL + '  SELECT SQL_NO_CACHE DISTINCT                          ';
  strSQL := strSQL + '    I.IPR_CODITE AS CODITE,                             ';
  strSQL := strSQL + '    T.ITE_DESITE AS DESITE,                             ';
  strSQL := strSQL + '    (CASE WHEN (IFNULL(I.IPR_QTDMIN, 0) = 0) AND ';
  strSQL := strSQL + '          (C.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva].ToString+') THEN ';
  strSQL := strSQL + '          IFNULL(C.PRO_QTDMIN, 0) ';
  strSQL := strSQL + '     ELSE IFNULL(I.IPR_QTDMIN, 0) END) AS QTDMIN, ';
  strSQL := strSQL + '    (CASE WHEN (IFNULL(I.IPR_QTDLIM, 0) = 0) AND ';
  strSQL := strSQL + '          (C.PRO_IDXPRO = '+IDX_TIPO_DESCONTO_PROMOCAO[tdpPrecoQuantidadeColetiva].ToString+') THEN ';
  strSQL := strSQL + '          IFNULL(C.PRO_QTDLIM, 0) ';
  strSQL := strSQL + '     ELSE IFNULL(I.IPR_QTDLIM, 0) END) AS QTDLIM, ';
  strSQL := strSQL + '    IFNULL(I.IPR_PERDES, 0) AS PERDES,                  ';
  strSQL := strSQL + '    IFNULL(I.IPR_PREVEN, 0) AS PREVEN,                  ';
  strSQL := strSQL + '    C.PRO_DTAINI AS VIGINI,                             ';
  strSQL := strSQL + '    C.PRO_DTAFIN AS VIGFIN,                             ';
  strSQL := strSQL + '    IFNULL(C.PRO_TABPRE,"") AS TABPRE                   ';
  strSQL := strSQL + '  FROM CADPRO C                                         ';
  strSQL := strSQL + '    INNER JOIN ITEPRO I ON C.AUTOINCREM = I.IPR_SEQGER  ';
  strSQL := strSQL + '    INNER JOIN PROEMP E ON C.AUTOINCREM = E.PRO_SEQGER  ';
  strSQL := strSQL + '    INNER JOIN CADITE T ON I.IPR_CODITE = T.ITE_CODITE  ';
  strSQL := strSQL + '  WHERE I.IPR_CODITE = :CODITE                          ';
  strSQL := strSQL + '    AND E.PRO_CODEMP = :CODEMP                          ';
  strSQL := strSQL + '    AND :DTAHOJ BETWEEN C.PRO_DTAINI AND C.PRO_DTAFIN   ';
  strSQL := strSQL + '    AND C.PRO_CODPRO = :CODPRO ';

  SetLength(arrMsg, 0);
  strDesTab := '';
  intDecQtd := fCfgSis('DECQTD', varInteger);
  intDecUni := fCfgSis('DECQTD', varInteger);

  Try
    qryPro := fCriaQuery;

    With qryPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPRO').AsString := strCodPro;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('DTAHOJ').AsDate   := VS_Date;
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
      Begin
        First;

        pAddDados(arrMsg, '----------------------------------------------------------');

        While Not Eof Do
        Begin
          strDesIte := strCodIte + ' - ' + FieldByName('DESITE').AsString;

          If Length(strDesIte) > 36 Then
            pAddDados(arrMsg, 'Produto em Promoção.: ' + strDesIte)
          Else
            pAddDados(arrMsg, 'Produto em Promoção.: ' + fPadL(strDesIte, 36));

          pAddDados(arrMsg, 'Quantidade Mínima...: ' + fPadL(FloatToStrF(FieldByName('QTDMIN').AsFloat, ffFixed, 11, intDecQtd), 36));
          pAddDados(arrMsg, 'Quantidade Limite...: ' + fPadL(FloatToStrF(FieldByName('QTDLIM').AsFloat, ffFixed, 11, intDecQtd), 36));
          pAddDados(arrMsg, 'Preço de Tabela.....: ' + fPadL(FloatToStrF(fRetPrecoVenda(strCodIte, IIF(fEmptyStr(strTabPre), '1', strTabPre)), ffFixed, 11, intDecQtd), 36));

          If (FieldByName('PERDES').AsFloat = 0) Then
          Begin
            fltPre := FieldByName('PREVEN').AsFloat;
            pAddDados(arrMsg, 'Preço Promocional...: ' + fPadL(FloatToStrF(fltPre, ffFixed, 11, intDecQtd), 36));
          End
          Else
          Begin
            fltPre := fRetPrecoVenda(strCodIte, IIF(fEmptyStr(strTabPre), '1', strTabPre));
            fltPre := (fltPre - (fltPre * (FieldByName('PERDES').AsFloat / 100)));
            pAddDados(arrMsg, 'Preço Promocional...: ' + fPadL(FloatToStrF(fltPre, ffFixed, 11, intDecUni), 36));
            pAddDados(arrMsg, '% Desconto Promoção.: ' + fPadL(FloatToStrF(FieldByName('PERDES').AsFloat, ffFixed, 11, intDecUni) + '%', 36));
          End;

          For j := 1 To Length(FieldByName('TABPRE').AsString) Do
          Begin
            If FieldByName('TABPRE').AsString[j] = 'S' Then
              strDesTab := strDesTab + IntToStr(j) + ', ';
          End;

          pAddDados(arrMsg, 'Tabela(s) de Preço..: ' + fPadL(Copy(strDesTab, 0, Length(strDesTab)-2), 36));
          pAddDados(arrMsg, 'Vigência da Promoção: ' + fPadL('De ' + FormatDateTime('dd/mm/yyyy', FieldByName('VIGINI').AsDateTime) +
                                                             ' Até ' + FormatDateTime('dd/mm/yyyy', FieldByName('VIGFIN').AsDateTime), 36));

          Next;
        End;

        pAddDados(arrMsg, '----------------------------------------------------------');

        fMensagemTabela('AVISO', 'Detalhes da Promoção', arrMsg, '', ['&Ok']);
      End;

      Close;
    End;
  Finally
    FreeAndNil(qryPro);
  End;
end;

function fRetornaCodPro (strCodIte,
                         strCodEmp : String;
                         dtaData : TDateTime;
                         Var qryTabela : TUniQuery):String;
  Var
    strSql : String;
    qryCadPro : TUniQuery;
Begin
  Result := '';
  Try
    qryCadPro := fCriaQuery;

    strSql := '';
    strSql := strSql + 'SELECT ';
    strSql := strSql + '   PROEMP.PRO_CODEMP , ';
    strSql := strSql + '   PRO_CODPRO , ';
    strSql := strSql + '   PRO_DESPRO , ';
    strSql := strSql + '   PRO_DTAINI , ';
    strSql := strSql + '   PRO_DTAFIN , ';
    strSql := strSql + '   CADPRO.AUTOINCREM, ';
    strSql := strSql + '   PRO_CODCLI, ';
    strSql := strSql + '   PRO_TABPRE, ';
    strSql := strSql + '   PRO_PREDES  ';
    strSql := strSql + ' FROM          ';
    strSQL := strSQL + '   CADPRO      ';
    strSQL := strSQL + '   INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM ';
    strSQL := strSQL + '   INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
    strSql := strSql + ' WHERE IPR_CODITE = :CODITE  ';
    strSql := strSql + '   AND PRO_DTAINI <= :DATA   ';
    strSql := strSql + '   AND PRO_DTAFIN >= :DATA   ';
    strSql := strSql + '   AND PROEMP.PRO_CODEMP = :CODEMP ';
    strSql := strSql + ' ORDER BY PRO_TABLOI DESC ';

    With qryCadPro Do
    Begin
      SQL.Clear;
      SQL.Add(strSql);

      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('DATA').AsDate     := dtaData;
      ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      If Not IsEmpty Then
      Begin
        Result := FieldByName('PRO_CODPRO').AsString;

        strSql := '';
        strSql := strSql + ' SELECT ';
        strSql := strSql + '  *    ';
        strSql := strSql + ' FROM CADPRO  ';
        strSql := strSql + ' WHERE AUTOINCREM = :AUTOINCREM  ';

        qryTabela.Close;
        qryTabela.SQL.Clear;
        qryTabela.SQL.Add(strSql);
        qryTabela.ParamByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
        qryTabela.Open;
      End;

    End;

  Finally
    FreeAndNil(qryCadPro);
  End;

End;

function fUsaPrecoDeVendaDinamicoForaDoEstado(strEmpIte: string): Boolean;
begin
  Result := (fCfgSis('CLPVDI', varBoolean));
  If (Result) Then
  Begin
    Result := (Assigned(TEventosCadPro.fncUFDestTrib)) And
              (Assigned(TEventosCadPro.fncUFEmpresa)) And
              (Assigned(TEventosCadPro.fncPegaPrecoVenda)) And
              (Assigned(TEventosCadPro.fncPegaIcmsSai)) And
              (TEventosCadPro.fUFDestTrib(strEmpIte) <> TEventosCadPro.fUFEmpresa(strEmpIte));
  End;
end;

function fRetPrecoVendaPromocao(strCodIte, strTabPre: String; strEmpIte: String; strCodCli: String; Conexao: TUniConnection; fltDesF07: Double; var fltPreCus: Double): Double;
begin
  If (fUsaPrecoDeVendaDinamicoForaDoEstado(strEmpIte)) Then
    Result := TEventosCadPro.fPegaPrecoVenda(strCodIte, strEmpIte, strCodCli,
                                             strTabPre, TEventosCadPro.fUFDestTrib(strEmpIte),
                                             TEventosCadPro.fPegaIcmsSai(strCodIte, strEmpIte),
                                             fltDesF07, fltPreCus)
  Else
    Result := fRetPrecoVenda(strCodIte, strTabPre, strEmpIte, Conexao);
end;

function fAplicaDescontoCondicaoItensEmPromocao(strCodCnd: String): Boolean;
begin
  Result := (fCfgSis('PROCND', varString) = 'N') And
            (fCfgSis('CNDVEN', varString) = 'I') And
            (fCfgSis('PRODES', varString) = 'S') And
            (fRetDescMaxCnd(strCodCnd, mdVendedor) > 0);
end;

function fExecutaQueryLevantamentoEstrutura(qry: TUniQuery): Boolean;
begin
  If (Not Assigned(TEventosCadPro.fncQueryEmCacheTrouxeAlgumRegistro)) Then 
    Exit(True);
    
  Result := (TEventosCadPro.fQueryEmCacheTrouxeAlgumRegistro(qry));
end;

procedure pCarregaEstruturaCasoItemPertencerUma(Var strLisCodIte: String; strCodIte: String; qry: TUniQuery = Nil; blnBuscaPorLista: Boolean=False);
  Var
    blnLiberar: Boolean;
    strCondicao : String;
begin

  If fEmptyStr(strCodIte) Then
    Exit;

  If Not Assigned(qry) Then
  Begin
    qry := fCriaQuery(Nil);
    blnLiberar := True;
  End
  Else
    blnLiberar := False;

  Try
    With qry Do
    Begin
      Close;
      SQL.Clear;

      If blnBuscaPorLista Then
        strCondicao := ' IN ('+fSafeSQLValue(strCodIte)+') '
      Else
        strCondicao := ' = :CODITE ';

      SQL.Add('  SELECT DISTINCT                            '); //REMOVE REDUNDANCIA
      SQL.Add('    ITE                                      '); //
      SQL.Add('  FROM                                       '); //
      SQL.Add('    (SELECT DISTINCT                         '); //BUSCA CODIGO DOS PAIS QUE ESTÃO, OU CONTÊM FILHOS DENTRO DAS CONDIÇÕES (strCondicao)
      SQL.Add('      G.GMT_CODITE AS ITE                    '); //
      SQL.Add('    FROM                                     '); //
      SQL.Add('      GERMAT G                               '); //
      SQL.Add('    WHERE G.AUTOINCREM IN                    '); //
      SQL.Add('      (SELECT DISTINCT                       '); //BUSCA AUTOINCREM DOS REGISTROS DENTRO DAS CONDIÇÕES (strCondicao)
      SQL.Add('        G.AUTOINCREM                         '); //
      SQL.Add('      FROM                                   '); //
      SQL.Add('        GERMAT G                             '); //
      SQL.Add('        INNER JOIN DETMAT D                  '); //
      SQL.Add('          ON (G.AUTOINCREM = D.DMT_SEQGER)   '); //
      SQL.Add('      WHERE G.GMT_CODITE '+strCondicao+'     '); //
      SQL.Add('        OR D.DMT_ITESUB '+strCondicao+')     '); //
      SQL.Add('      UNION ALL                              '); //UNIFICA OS DOIS RESULTADOS
      SQL.Add('      SELECT DISTINCT                        '); //BUSCA CODIGO DOS FILHOS DOS PAIS QUE ESTÃO, OU CONTÊM FILHOS DENTRO DAS CONDIÇÕES (strCondicao)
      SQL.Add('        D.DMT_ITESUB AS ITE                  '); //
      SQL.Add('      FROM                                   '); //
      SQL.Add('        GERMAT G                             '); //
      SQL.Add('        INNER JOIN DETMAT D                  '); //
      SQL.Add('          ON (G.AUTOINCREM = D.DMT_SEQGER)   '); //
      SQL.Add('      WHERE G.AUTOINCREM IN                  '); //
      SQL.Add('        (SELECT DISTINCT                     '); //BUSCA AUTOINCREM DOS REGISTROS DENTRO DAS CONDIÇÕES (strCondicao)
      SQL.Add('          G.AUTOINCREM                       '); //
      SQL.Add('        FROM                                 '); //
      SQL.Add('          GERMAT G                           '); //
      SQL.Add('          INNER JOIN DETMAT D                '); //
      SQL.Add('            ON (G.AUTOINCREM = D.DMT_SEQGER) '); //
      SQL.Add('        WHERE G.GMT_CODITE '+strCondicao+'   '); //
      SQL.Add('          OR D.DMT_ITESUB '+strCondicao+')   '); //
      SQL.Add('  ) AS I                                     '); //
      SQL.Add('  WHERE ITE <> ""                            '); //FILTRA OS VAZIOS

      If Not blnBuscaPorLista Then
        ParamByName('CODITE').AsString := strCodIte;

      If (fExecutaQueryLevantamentoEstrutura(qry)) Then
      Begin
        Open;
        First;

        While Not Eof Do
        Begin
          strLisCodIte := strLisCodIte+'"'+fSafeSQLValue(Fields[0].AsString)+'"' + ',';

          Next;
        End;

        If strLisCodIte<>'' Then
          strLisCodIte := Copy(strLisCodIte, 1, Length(strLisCodIte)-1);
      End;

      Close;
      SQL.Clear;
    End;
  Finally
    If blnLiberar Then
    Begin
      FreeAndNil(qry)
    End;
  End
end;

function fItemComPromocaoPorCnd(strCodIte, strEmpSel: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): Boolean;
  Var
    strLisCodIte,
    strSQL   : String;
    qryGenPro: TUniQuery;

    procedure pSetaParam(strCodIteAux: String);
    begin
      With qryGenPro Do
      Begin
        If FindParam('CODITE') <> Nil Then
          ParamByName('CODITE').AsString := strCodIteAux;

        ParamByName('DTAINI').AsDate   := VS_Date;
        ParamByName('DTAFIN').AsDate   := VS_Date;
        ParamByName('CODEMP').AsString := strEmpSel;

        If FindParam('CODCLI') <> Nil Then
          ParamByName('CODCLI').AsString := strCodCli;
      End;
    end;

begin
  Result := False;
  
  If Assigned(Conexao) Then
    qryGenPro := fCriaQuery(nil, Conexao)
  Else
    qryGenPro := fCriaQuery(nil);

  Try
    strLisCodIte := '';
    If blnConsideraEstrutura Then
      pCarregaEstruturaCasoItemPertencerUma(strLisCodIte, strCodIte, qryGenPro);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_CODPRO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPRO P ';
    strSQL := strSQL + '  INNER JOIN ITEPRO IP ON P.AUTOINCREM = IP.IPR_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';
    strSQL := strSQL + '  INNER JOIN CNDPRO CN ON P.AUTOINCREM = CN.CPR_SEQGER ';
    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + '  INNER JOIN PROCLI PC ON P.AUTOINCREM = PC.PRO_SEQGER AND PC.PRO_CODCLI = :CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere('','',strLisCodIte, strCodCli, '');
    strSQL := strSQL + ' ORDER BY P.PRO_TABLOI DESC '; //Promoção Tabloid (S) tem prioridade

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (qryGenPro.FindParam('CODITE') <> Nil) And (fEmptyStr(strCodIte)) Then
        Exit;

      pSetaParam(strCodIte);

      Open;
      Result := (RecordCount <> 0);
      Close;
    End;
  Finally
    FreeAndNil(qryGenPro);
  End;
end;

function fLinhaGrupoUnidadeEmPromocaoKit(strLinGru, strCodUni: String; Conexao: TUniConnection = Nil): Boolean;
  Var
    strSQL   : String;
    qryGenPro: TUniQuery;
begin
  If fEmptyStr(strLinGru) Or fEmptyStr(strCodUni) Then
    Exit(False);

  If (Assigned(TEventosCadPro.stlLinhaGrupoUnidadeEmPromocaoKit)) Then
  Begin
    If TEventosCadPro.stlLinhaGrupoUnidadeEmPromocaoKit.IndexOf(strLinGru + strCodUni) >= 0 Then
      Exit(True);
  End;

  If Assigned(Conexao) Then
    qryGenPro := fCriaQuery(nil, Conexao)
  Else
    qryGenPro := fCriaQuery(nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT CADKIT.AUTOINCREM  ';
    strSQL := strSQL + '   FROM CADPRO ';
    strSQL := strSQL + '     INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
    strSQL := strSQL + '     INNER JOIN KITDET ON KITDET.AUTOINCREM = ITEPRO.IPR_SEQKIT ';
    strSQL := strSQL + '     INNER JOIN CADKIT ON CADKIT.AUTOINCREM = KITDET.DET_SEQKIT ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '  ( ';
    strSQL := strSQL + '    :DTAINI BETWEEN PRO_DTAINI AND PRO_DTAFIN OR ';
    strSQL := strSQL + '    :DTAFIN BETWEEN PRO_DTAINI AND PRO_DTAFIN    ';
    strSQL := strSQL + '  )  ';
    strSQL := strSQL + '    AND KITDET.DET_CODGRU = :CODLIN ';
    strSQL := strSQL + '    AND KITDET.DET_CODUNI = :CODUNI ';

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate   := VS_Date;
      ParamByName('DTAFIN').AsDate   := VS_Date;
      ParamByName('CODLIN').AsString := strLinGru;
      ParamByName('CODUNI').AsString := strCodUni;

      Open;
      Result := (Not fEmptyStr(qryGenPro.Fields[0].AsString));
      Close;

      If Result Then
      Begin
        If (Assigned(TEventosCadPro.stlLinhaGrupoUnidadeEmPromocaoKit)) Then
        Begin
          If (TEventosCadPro.stlLinhaGrupoUnidadeEmPromocaoKit.IndexOf(strLinGru + strCodUni) = -1) Then
            TEventosCadPro.stlLinhaGrupoUnidadeEmPromocaoKit.Add(strLinGru + strCodUni);
        End;
      End;
    End;
  Finally
    If Assigned(qryGenPro) Then
     FreeAndNil(qryGenPro);
  End;
end;

function fItemSemNenhumaPromocao(strCodIte, strEmpSel: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): Boolean;
  Var
    strLisCodIte,
    strSQL   : String;
    qryGenPro: TUniQuery;

    procedure pSetaParam(strCodIteAux: String);
    begin
      With qryGenPro Do
      Begin
        If FindParam('CODITE') <> Nil Then
          ParamByName('CODITE').AsString := strCodIteAux;

        ParamByName('DTAINI').AsDate   := VS_Date;
        ParamByName('DTAFIN').AsDate   := VS_Date;
        ParamByName('CODEMP').AsString := strEmpSel;

        If FindParam('CODCLI') <> Nil Then
          ParamByName('CODCLI').AsString := strCodCli;
      End;
    end;

begin
  Result := TCadNegBussiness.fItemSemNenhumaNegociacao(strCodIte, Conexao);
  Try
    If Result Then
    Begin
      If Assigned(Conexao) Then
        qryGenPro := fCriaQuery(nil, Conexao)
      Else
        qryGenPro := fCriaQuery(nil);

      If (Assigned(TEventosCadPro.stlItensNaoTemPromocao)) Then
      Begin
        If TEventosCadPro.stlItensNaoTemPromocao.IndexOf(strCodIte + strEmpSel + strCodCli) >= 0 Then
          Exit(True);
      End;

      If (Assigned(TEventosCadPro.stlItensTemPromocao)) And fEmptyStr(strCodCli) Then
      Begin
        If TEventosCadPro.stlItensTemPromocao.IndexOf(strCodIte + strEmpSel) >= 0 Then
          Exit(False);
      End;

      strLisCodIte := '';
      If blnConsideraEstrutura Then
        pCarregaEstruturaCasoItemPertencerUma(strLisCodIte, strCodIte, qryGenPro);

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODPRO ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADPRO P ';
      strSQL := strSQL + '  INNER JOIN ITEPRO IP ON P.AUTOINCREM = IP.IPR_SEQGER ';
      strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';
      If Not fEmptyStr(strCodCli) Then
        strSQL := strSQL + '  INNER JOIN PROCLI PC ON P.AUTOINCREM = PC.PRO_SEQGER AND PC.PRO_CODCLI = :CODCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + fSqlWhere('','',strLisCodIte, strCodCli, '');
      strSQL := strSQL + ' ORDER BY P.PRO_TABLOI DESC '; //Promoção Tabloid (S) tem prioridade

      With qryGenPro Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        If (qryGenPro.FindParam('CODITE') <> Nil) And (fEmptyStr(strCodIte)) Then
          Exit;

        pSetaParam(strCodIte);

        Open;
        Result := (RecordCount = 0);
        Close;

        If Not Result Then
        Begin
          If (Assigned(TEventosCadPro.stlItensTemPromocao)) And fEmptyStr(strCodCli) Then
          Begin
            If (TEventosCadPro.stlItensTemPromocao.IndexOf(strCodIte + strEmpSel) = -1) Then
              TEventosCadPro.stlItensTemPromocao.Add(strCodIte + strEmpSel);
          End;
        End
        Else
        Begin
          If (Assigned(TEventosCadPro.stlItensNaoTemPromocao)) Then
          Begin
            If (TEventosCadPro.stlItensNaoTemPromocao.IndexOf(strCodIte + strEmpSel + strCodCli) = -1) Then
              TEventosCadPro.stlItensNaoTemPromocao.Add(strCodIte + strEmpSel + strCodCli);
          End;
        End;
      End;
    End;
  Finally
    If Assigned(qryGenPro) Then
      FreeAndNil(qryGenPro);
  End;
end;

function fRetornaSomenteItensEmPromocaoDaLista(strLisCodIteOrc, strLisCodEmpOrc: String; strCodCli: String=''; Conexao: TUniConnection = Nil; blnConsideraEstrutura: Boolean=True): TStringList;
  Var
    strLisCodIteEst,
    strSQL   : String;
    qryGenPro: TUniQuery;
begin
  Result := TStringList.Create;

  If fEmptyStr(strLisCodEmpOrc) Or fEmptyStr(strLisCodIteOrc) Then
    Exit;
     
  If Assigned(Conexao) Then
    qryGenPro := fCriaQuery(nil, Conexao)
  Else
    qryGenPro := fCriaQuery(nil);

  Try
    strLisCodIteEst := '';

    If blnConsideraEstrutura Then
      pCarregaEstruturaCasoItemPertencerUma(strLisCodIteEst, strLisCodIteOrc, qryGenPro, True);

    If strLisCodIteEst <> '' Then
      strLisCodIteOrc := strLisCodIteOrc + ',' + strLisCodIteEst;

    strSQL := '';
    strSQL := strSQL + 'SELECT DISTINCT ';
    strSQL := strSQL + '  IP.IPR_CODITE, ';
    strSQL := strSQL + '  PE.PRO_CODEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPRO P ';
    strSQL := strSQL + '  INNER JOIN ITEPRO IP ON P.AUTOINCREM = IP.IPR_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';
    strSQL := strSQL + '   LEFT JOIN PROCLI PC ON P.AUTOINCREM = PC.PRO_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere('','',strLisCodIteOrc,strCodCli,'',strLisCodEmpOrc);

    If Not fEmptyStr(strCodCli) Then
      strSQL := strSQL + '  AND (PC.PRO_SEQGER IS NULL OR PC.PRO_CODCLI = "'+strCodCli+'")'
    Else
      strSQL := strSQL + '  AND (PC.PRO_SEQGER IS NULL) ';

    strSQL := strSQL + ' ORDER BY IP.IPR_CODITE, PE.PRO_CODEMP ';

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTAINI').AsDate := VS_Date;
      ParamByName('DTAFIN').AsDate := VS_Date;

      If FindParam('CODCLI') <> Nil Then
        ParamByName('CODCLI').AsString := strCodCli;

      Open;
      If Not qryGenPro.IsEmpty Then
      Begin 
        First;

        While Not Eof Do
        Begin
          Result.Add(FieldByName('IPR_CODITE').AsString+FieldByName('PRO_CODEMP').AsString);

          Next;
        End;
      End;
      Close;
    End;
  Finally
    FreeAndNil(qryGenPro);
  End;
end;

function fItemTemAlgumaPromocaoRestritaNaoConsumidor(strCodIte, strCodEmp: String; blnConsideraEstrutura: Boolean=True): Boolean;
  Var
    strLisCodIte,
    strSQL   : String;
    qryGenPro: TUniQuery;

    procedure pSetaParam(strCodIteAux: String);
    begin
      With qryGenPro Do
      Begin
        If FindParam('CODITE') <> Nil Then
          ParamByName('CODITE').AsString := strCodIteAux;

        ParamByName('DTAINI').AsDate   := VS_Date;
        ParamByName('DTAFIN').AsDate   := VS_Date;
        ParamByName('CODEMP').AsString := strCodEmp;
      End;
    end;

begin
  Result := False;
  qryGenPro := fCriaQuery(nil);
  Try
    strLisCodIte := '';
    If blnConsideraEstrutura Then
      pCarregaEstruturaCasoItemPertencerUma(strLisCodIte, strCodIte, qryGenPro);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_CODPRO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPRO P ';
    strSQL := strSQL + '  INNER JOIN ITEPRO IP ON P.AUTOINCREM = IP.IPR_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere('','',strLisCodIte, '', '') + ' AND P.PRO_RESNCO = "S" ';
    strSQL := strSQL + ' ORDER BY P.PRO_TABLOI DESC '; //Promoção Tabloid (S) tem prioridade

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (qryGenPro.FindParam('CODITE') <> Nil) And (fEmptyStr(strCodIte)) Then
        Exit;

      pSetaParam(strCodIte);

      Open;
      Result := (RecordCount > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenPro);
  End;
end;

function fItemTemAlgumaPromocaoParaCliente(strCodIte, strCodEmp, strCodCli: String; blnConsideraEstrutura: Boolean=True): Boolean;
  Var
    strLisCodIte,
    strSQL   : String;
    qryGenPro: TUniQuery;

    procedure pSetaParam(strCodIteAux: String);
    begin
      With qryGenPro Do
      Begin
        If FindParam('CODITE') <> Nil Then
          ParamByName('CODITE').AsString := strCodIteAux;

        ParamByName('DTAINI').AsDate   := VS_Date;
        ParamByName('DTAFIN').AsDate   := VS_Date;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
      End;
    end;

begin
  Result := False;
  qryGenPro := fCriaQuery(nil);
  Try
    strLisCodIte := '';
    If blnConsideraEstrutura Then
      pCarregaEstruturaCasoItemPertencerUma(strLisCodIte, strCodIte, qryGenPro);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_CODPRO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPRO P ';
    strSQL := strSQL + '  INNER JOIN ITEPRO IP ON P.AUTOINCREM = IP.IPR_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER ';
    strSQL := strSQL + '  INNER JOIN PROCLI PC ON P.AUTOINCREM = PC.PRO_SEQGER AND PC.PRO_CODCLI = :CODCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere('','',strLisCodIte, strCodCli, '');
    strSQL := strSQL + ' ORDER BY P.PRO_TABLOI DESC '; //Promoção Tabloid (S) tem prioridade

    With qryGenPro Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (qryGenPro.FindParam('CODITE') <> Nil) And (fEmptyStr(strCodIte)) Then
        Exit;

      pSetaParam(strCodIte);

      Open;
      Result := (RecordCount > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenPro);
  End;
end;

{ TItemPromo }

constructor TItemPromo.Create;
begin
  pClear;

  FstrCliFil := VS_strCliFil;
  If fEmptyStr(FstrCliFil) Then
    FstrCliFil := fRetClientesFilial;

  FstrClaVen := VS_strClaVen;
  If fEmptyStr(FstrClaVen) Then
    FstrClaVen := fTransform(fCfgSis('CLAVEN'), 4);

  FstrClaDev := VS_strClaDev;
  If fEmptyStr(FstrClaDev) Then
    FstrClaDev := fTransform(fCfgSis('CLADEV'), 4);

end;

destructor TItemPromo.Destroy;
begin
  If (Assigned(cdsBanner)) Then
    FreeAndNil(cdsBanner);

  inherited;
end;

function TItemPromo.fGetSQLBanner: String;
Var
  strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  T.IPR_CODITE AS CODITE, ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  T.IPR_PREVEN AS PREVEN, ';
  strSQL := strSQL + '  CONCAT(P.PRO_CODPRO, "-", P.PRO_DESPRO) AS DESPRO, ';
  strSQL := strSQL + '  CONCAT(DATE_FORMAT(P.PRO_DTAINI, "%d/%m/%Y"), " A ", DATE_FORMAT(P.PRO_DTAFIN, "%d/%m/%Y")) AS VIGENC,  ';
  strSQL := strSQL + '  CONCAT(IF (MID(P.PRO_TABPRE, 1, 1) = "S", "1 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 2, 1) = "S", "2 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 3, 1) = "S", "3 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 4, 1) = "S", "4 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 5, 1) = "S", "5 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 6, 1) = "S", "6 / ", ""),              ';
  strSQL := strSQL + '         IF (MID(P.PRO_TABPRE, 7, 1) = "S", "7 / ", "")) AS TABPRE,   ';
  strSQL := strSQL + '  (SELECT REPLACE(GROUP_CONCAT(X.PRO_CODEMP), ",", " / ") FROM PROEMP X WHERE X.PRO_SEQGER = P.AUTOINCREM ORDER BY X.PRO_CODEMP ) AS EMPRES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPRO P ';
  strSQL := strSQL + '  INNER JOIN ITEPRO T  ON P.AUTOINCREM = T.IPR_SEQGER ';
  strSQL := strSQL + '  INNER JOIN PROEMP PE ON P.AUTOINCREM = PE.PRO_SEQGER  ';
  strSQL := strSQL + '  LEFT  JOIN PROCLI C  ON P.AUTOINCREM = C.PRO_SEQGER ';
  strSQL := strSQL + '  INNER JOIN CADITE I  ON (I.ITE_CODITE = T.IPR_CODITE) ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LOCATE(PE.PRO_CODEMP,:CODEMP) > 0         AND ';
  strSQL := strSQL + '  :DTAATU BETWEEN PRO_DTAINI AND PRO_DTAFIN AND ';

  if not FEmptyStr(strCodCli) then
    strSQL := strSQL + '   ((C.PRO_CODCLI = :CODCLI) OR (C.PRO_CODCLI IS NULL)) '
  else
    strSQL := strSQL + '   C.PRO_CODCLI IS NULL ';

  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  DESITE ';

  Result := Result + 'SELECT          ';
  Result := Result + '  SUBSTR(TABPRE, 1, LENGTH(TABPRE) - 2) AS TABPRE, ';
  Result := Result + '  TAB.*         ';
  Result := Result + 'FROM(           ';
  Result := Result +       strSQL + ' ';
  Result := Result + '    ) AS TAB    ';
end;

function TItemPromo.fRetSubQryAuxVWMovDet(tpTipoMovimento: TTipoMovimento): String;
begin
  Result := Result + '  SELECT IFNULL(SUM(IFNULL(IF(DET_CLAFIS <= "5000", -DET_QTDITE, DET_QTDITE), 0)), 0) AS DET_QTDITE ';
  Result := Result + '  FROM MOVDET VW_MOVDET ';
  Result := Result + '  WHERE ';
  Result := Result + '    VW_MOVDET.DET_CODITE = ITEPRO.IPR_CODITE  AND ';
  Result := Result + '    IF(PRO_IDXQTD = 0, VW_MOVDET.DET_CODEMP = PROEMP.PRO_CODEMP, TRUE) AND ';
  Result := Result + '    VW_MOVDET.DET_PROEMB <> "S"               AND ';
  Result := Result + '    VW_MOVDET.DET_PROMOC = "S"                AND ';
  Result := Result + '    VW_MOVDET.DET_TIP_FC = "C"                AND ';
  Result := Result + '    VW_MOVDET.DET_CODCLI NOT IN ('+FstrCliFil+') AND ';

  If fDesconsiderarNaQtdLimDaPromoItensUnitarMaior Then
    Result := Result + '  VW_MOVDET.DET_UNITAR <= VW_MOVDET.DET_UNIORI AND ';

  Case tpTipoMovimento Of
    tpDoCliente  : Result := Result + '  VW_MOVDET.DET_CODCLI = PROCLI.PRO_CODCLI AND ';
    tpDoCliente2 : Result := Result + '  VW_MOVDET.DET_CODCLI IN (' +  RetSubQueryProCli + ') AND '
    else
      Result := Result + '  VW_MOVDET.DET_CODCLI NOT IN ('+fRetSubQryCodCliEmPromoPorQtdLim('ITEPRO.IPR_CODITE', 'PROEMP.PRO_CODEMP', Self.FstrTabPre)+') AND ';
  End;

  Result := Result + '    VW_MOVDET.DET_DTAENT BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN AND ';
  Result := Result + '    ((LOCATE(VW_MOVDET.DET_CLAFIS, '+QuotedStr(FstrClaVen)+') > 0) OR (LOCATE(VW_MOVDET.DET_CLAFIS, '+QuotedStr(FstrClaDev)+') > 0) ';

  If fEmptyStr(Self.FstrENTBRF) Then
    strENTBRF := fCfgSis('ENTBRF');

  If FstrENTBRF = 'S' Then
    Result := Result + ' OR (VW_MOVDET.DET_ESPDOC = "BR") OR LOCATE(VW_MOVDET.DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    Result := Result + ') ';

  Result := '(' + Result + ')';
end;

function TItemPromo.fRetSubQryAuxVWFatDor(tpTipoMovimento: TTipoMovimento): String;
begin
  Result := Result + '  SELECT IFNULL(SUM(IFNULL(FDO_QTDITE - FDO_QTDBAI, 0)), 0) AS FDO_QTDITE ';
  Result := Result + '  FROM FATDOR VW_FATDOR ';
  Result := Result + '  WHERE ';
  Result := Result + '    VW_FATDOR.FDO_ESPDOC = "PD" AND ';
  Result := Result + '    VW_FATDOR.FDO_JAFATU = 0 AND ';
  Result := Result + '    VW_FATDOR.FDO_CODITE = ITEPRO.IPR_CODITE  AND ';
  Result := Result + '    IF(PRO_IDXQTD = 0, VW_FATDOR.FDO_CODEMP = PROEMP.PRO_CODEMP, TRUE) AND ';
  Result := Result + '    VW_FATDOR.FDO_PROEMB <> "S"               AND ';
  Result := Result + '    VW_FATDOR.FDO_PROMOC = "S"                AND ';
  Result := Result + '    VW_FATDOR.FDO_CODCLI NOT IN ('+FstrCliFil+') AND ';

  If fDesconsiderarNaQtdLimDaPromoItensUnitarMaior Then
    Result := Result + '  VW_FATDOR.FDO_UNITAR <= VW_FATDOR.FDO_UNIORI AND ';

  Case tpTipoMovimento Of
    tpDoCliente : Result := Result + '  VW_FATDOR.FDO_CODCLI = PROCLI.PRO_CODCLI AND ';
    tpDoCliente2: Result := Result + '  VW_FATDOR.FDO_CODCLI IN  ('+ RetSubQueryProCli + ') AND ';
    Else
      Result := Result + '  VW_FATDOR.FDO_CODCLI NOT IN ('+fRetSubQryCodCliEmPromoPorQtdLim('ITEPRO.IPR_CODITE', 'PROEMP.PRO_CODEMP', Self.FstrTabPre)+') AND ';
  End;

  Result := Result + '    VW_FATDOR.FDO_DTAENT BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN AND ';
  Result := Result + '    ((LOCATE(VW_FATDOR.FDO_CLAFIS, '+QuotedStr(FstrClaVen)+') > 0) '; //OR (LOCATE(VW_FATDOR.FDO_CLAFIS, '+QuotedStr(FstrClaDev)+') > 0) ';

  If fEmptyStr(Self.FstrENTBRF) Then
    strENTBRF := fCfgSis('ENTBRF');

  If FstrENTBRF = 'S' Then
    Result := Result + ' OR (VW_FATDOR.FDO_ESPDOC = "BR") OR LOCATE(VW_FATDOR.FDO_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    Result := Result + ') ';

  Result := Result + ' AND VW_FATDOR.FDO_CLAFIS > "5000" ';

  If FstrNumOrc <> '' Then
    Result := Result + ' AND NOT (VW_FATDOR.FDO_NUMDOC = "' + FstrNumOrc +  '" AND VW_FATDOR.FDO_ESPDOC = "' + FstrEspOrc +  '") ';

  Result := '(' + Result + ')';
end;

function TItemPromo.fRetSubQryCodCliEmPromoPorQtdLim(strCodIte, strCodEmp,
  strTabPre: String): String;
begin
  Result := '';
  Result := Result + '  SELECT C.PRO_CODCLI ';
  Result := Result + '  FROM CADPRO P INNER JOIN PROCLI C ON C.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN ITEPRO I ON I.IPR_SEQGER = P.AUTOINCREM  ';
  Result := Result + '                INNER JOIN PROEMP E ON E.PRO_SEQGER = P.AUTOINCREM  ';
  Result := Result + '  WHERE ';
  Result := Result + '   '  + fCurrentDate + ' BETWEEN P.PRO_DTAINI AND P.PRO_DTAFIN ';
  Result := Result + fGetFiltroTabelaPrecoPromocao(strTabPre, 'P.');
  Result := Result + fGetFiltroPromocaoRestritaClientesNaoConsumidor(strCodCli, 'P.');
  Result := Result + '  AND E.PRO_CODEMP = ' + IIF(Pos('.',strCodEmp) > 0, strCodEmp, QuotedStr(strCodEmp));
  Result := Result + '  AND I.IPR_CODITE = ' + IIF(Pos('.',strCodIte) > 0, strCodIte, QuotedStr(strCodIte));
  Result := Result + '  AND (IFNULL(I.IPR_QTDLIM, 0) > 0) ';
end;

{******************************************************************************}
{*     FUNÇÃO QUE DEFINE SE UM ITEM ESTÁ EM PROMOÇÃO E A MESMA SEJA VÁLIDA    *}
{*1-PROMOÇÃO DENTRO DO PERÍODO ATUAL: fCurrentDate                            *}
{*2-NA TABELA DE PREÇO: strTabPre (SE CARREGADO)                              *}
{*3-DO CLIENTE: strCodCli (SE CARREGADO)                                      *}
{*4-QUE SEJA POR QUANTIDADE MÍNIMA SENÃO:                                     *}
{*    4A-SE POR QUANTIDADE LIMITE E NÃO FOI PASSADO CÓDIGO DE CLIENTE:        *}
{*          MOVIMENTO NA MOVDET DENTRO DAQUELE PERÍODO DA PROMOÇÃO TEM QUE    *}
{*          SER MENOR QUE A QUANTIDADE LIMITE EXCLUINDO MOVIMENTOS DE CLIENTES*}
{*          QUE TEM PROMOÇÃO ATRELADA NO MESMO PERÍODO DA PROMOÇÃO            *}
{*    4B-SE POR QUANTIDADE LIMITE E FOI PASSADO CÓDIGO DE CLIENTE:            *}
{*          MESMA REGRA DA 4A + AS PROMOÇÕES CUJO DET_CODCLI E PRO_CODCLI     *}
{*          SEJAM OS MESMOS CARREGADOS NO OBJETO                              *}
{***************************************************************************VA*}
function TItemPromo.fRetSubQryComRegrasPromocao: String;
   {*************************************}
   {* SUBSTITUIDO PELO CAMPO IPR_QTDDIS *}
   {**********************************FS*}
   //function fRetSQLVerificaSePromoEhQtdMinOuQtdLimValida(tpTipoMovimento: TTipoMovimento): String;
   //begin
   //  Result := ' IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF((' + fRetSubQryAuxVWMovDet(tpTipoMovimento) + ' + ' + fRetSubQryAuxVWFatDor(tpTipoMovimento) + ') < ITEPRO.IPR_QTDLIM, TRUE, FALSE)) ';
   //end;

  function fRetSQLQtdReservadaPedido: String;
  begin
    Result := '';
    If (Not fEmptyStr(Self.FstrNumOrc)) And (Not fEmptyStr(Self.FstrEspOrc)) And (Self.FstrEspOrc = 'PD') Then
    Begin
      Result := Result + ' + (SELECT IFNULL(SUM(FDO_QTDITE), 0)            ';
      Result := Result + '      FROM FATDOR                                ';
      Result := Result + '        INNER JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
      Result := Result + '     WHERE FDO_NUMDOC = ' + QuotedStr(Self.FstrNumOrc);
      Result := Result + '       AND FDO_ESPDOC = ' + QuotedStr(Self.FstrEspOrc);
      Result := Result + '       AND FDO_CODEMP = PROEMP.PRO_CODEMP        ';
      Result := Result + '       AND FDO_CODITE = ITEPRO.IPR_CODITE        ';

      If fCfgSis('TABLOI', VarBoolean) Then
        Result := Result + '     AND FDO_CODPRO = PRO_CODPRO               ';

      Result := Result + '       AND FDO_PROMOC = "S"                      )';
    End;
  end;

Begin
  Result := '';

  If fEmptyStr(FstrCodCli) Then
  Begin
    Result := Result + ' (PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + ' (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE))) AND ';
  End
  Else
  Begin
    Result := Result + ' (((PROCLI.PRO_CODCLI = '+ QuotedStr(Self.FstrCodCli)+') AND (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '  OR (((PROCLI.PRO_SEQGER IS NULL) AND ';
    Result := Result + '      ((IPR_QTDLIM <= 0) OR ((IPR_QTDLIM > 0) AND '+QuotedStr(Self.FstrCodCli)+ ' NOT IN ('+Self.fRetSubQryCodCliEmPromoPorQtdLim('ITEPRO.IPR_CODITE', 'PROEMP.PRO_CODEMP', Self.FstrTabPre)+'))) AND ';
    Result := Result + '      (IF(ITEPRO.IPR_QTDLIM <= 0, TRUE, IF(IFNULL(IPREMP.IPR_QTDDIS, 0) ' + fRetSQLQtdReservadaPedido + ' > 0, TRUE, FALSE)))) ';
    Result := Result + '     ) ';
    Result := Result + ' ) AND ';
  End;
end;

function TItemPromo.fRetSubQryPromo: String;
  Var
    strPraMedioLoc: String;

  Function fRetSubQryCondicoesPromocao(blnFilCnd:Boolean): String;
  Begin
    Result := ' (SELECT COUNT(CNDPRO.CPR_SEQGER) FROM CNDPRO WHERE CNDPRO.CPR_SEQGER = CADPRO.AUTOINCREM '+
              IIF(blnFilCnd,' AND CNDPRO.CPR_CODCND = '+QuotedStr(FstrCodCnd),'')+' ) ';
  End;

begin
  Result := '';

  Result := Result + '  SELECT ' + Self.FstrSelect;
  Result := Result + '  FROM CADPRO INNER JOIN ITEPRO ON ITEPRO.IPR_SEQGER = CADPRO.AUTOINCREM ';
  Result := Result + '              INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ';
  Result := Result + '               LEFT JOIN PROCLI ON PROCLI.PRO_SEQGER = CADPRO.AUTOINCREM ';
  Result := Result + '               LEFT JOIN IPREMP ON IPREMP.IPR_SEQGER = ITEPRO.AUTOINCREM ';
  Result := Result + '                               AND PROEMP.PRO_CODEMP = IPREMP.IPR_CODEMP ';
  Result := Result + '  WHERE ';
  Result := Result + fRetSubQryComRegrasPromocao;
  Result := Result + '    ' + fCurrentDate(FDataVigencia) + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
  Result := Result + fGetFiltroTabelaPrecoPromocao(Self.FstrTabPre) + ' ';
  Result := Result + fGetFiltroPromocaoRestritaClientesNaoConsumidor(Self.FstrCodCli) + ' ';
  Result := Result + fGetFiltroQuantidadeLimite() + ' ';

  If (Not fEmptyStr(FstrAndWhereCodEmp)) And (Not fEmptyStr(FstrAndWhereCodIte)) Then
  Begin
    //JUNÇÃO POR CAMPO ANCORA DA QUERY PRINCIPAL;
    Result := Result + '   AND PROEMP.PRO_CODEMP = '+Self.FstrAndWhereCodEmp;
    Result := Result + '   AND ITEPRO.IPR_CODITE = '+Self.FstrAndWhereCodIte;
  End
  Else
  Begin
    //INDICAÇÃO DIRETA DO CODITE E CODEMP;
    Result := Result + '   AND PROEMP.PRO_CODEMP = '+QuotedStr(Self.FstrCodEmp);
    Result := Result + '   AND ITEPRO.IPR_CODITE = '+QuotedStr(Self.FstrCodIte);
  End;

  If (FintPraMedio <> -999) Or (FstrPraMedio <> '')  Then
  Begin
    strPraMedioLoc := IIF(FintPraMedio <> -999, IntToStr(FintPraMedio), FstrPraMedio);

    If ((fCfgSis('PRZPRO') = 'S') And (fCfgSis('USACND') = 'S')) Then
    Begin
      //SÓ CONSIDERA O PRAZO MÉDIO SE A PROMOÇÃO "NÃO" TIVER CONDIÇÕES DE PAGAMENTO ASSOCIADAS
      Result := Result + ' AND IF('+fRetSubQryCondicoesPromocao(False)+' = 0, ITEPRO.IPR_PRZMED >= '+strPraMedioLoc+', '+
                               IIF(fEmptyStr(FstrCodCnd), ' TRUE ', fRetSubQryCondicoesPromocao(True)+' > 0')+') ';
    End
    Else
    Begin
      Result := Result + ' AND ITEPRO.IPR_PRZMED >= ' + strPraMedioLoc;
    End;
  End;

  Result := Result + ' ORDER BY CADPRO.PRO_TABLOI DESC ';

  If (FblnUsaLimit) Then
    Result := Result + ', PROCLI.PRO_CODCLI '+IIF(FblnProCliEmprimeiro, 'DESC','')+', CADPRO.PRO_DTAINI, CADPRO.PRO_DTAFIN LIMIT 1';
end;

function TItemPromo.getCdsBanner: TUniClientDataSet;
begin
  Result := cdsBanner;
end;

procedure TItemPromo.pCarregaProdutosParaBanner;
  Var
    LArrRecNo: TArray<String>;
    qryBanner: TUniQuery;
    fltPreCus: Double;
    fltPreVen: Double;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    fltQtdDis: Double;
    fltDesF07: Double;
    blnParticiona: Boolean;
    blnPromo: Boolean;
    strComPro: String;
    strCodPro: String;
   {$IFNDEF LINUX}
    objOutputStream: TBytesStream;
   {$ENDIF}
begin
  Try

    qryBanner := fCriaQuery(Nil);

    If (Not Assigned(cdsBanner)) Then
    Begin
      pCriaClientBanner;
    End
    Else
      cdsBanner.EmptyDataSet;

    With qryBanner Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fGetSQLBanner);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('DTAATU').AsDate   := FDataVigencia;
      if not FEmptyStr(strCodCli) then
        ParamByName('CODCLI').AsString := strCodCli;

      Open;

      SetLength(LArrRecNo, 0);
      If RecordCount > fCfgSis('BANQTD', VarInteger) Then
      Begin
        First;
        While Not Eof Do
        Begin
          If FItensJaExibidosBanner.IndexOf(FieldByName('CODITE').AsString) = -1 Then
          Begin
            SetLength(LArrRecNo, Length(LArrRecNo)+1);
            LArrRecNo[Length(LArrRecNo)-1] := RecNo.ToString;
            FItensJaExibidosBanner.Add(FieldByName('CODITE').AsString);
          End;

          If Length(LArrRecNo) >= fCfgSis('BANQTD', VarInteger) Then
            If (RecordCount - RecNo) >= fCfgSis('BANQTD', VarInteger) Then
              Break;

          Next;
        End;
      End;

      If FItensJaExibidosBanner.Count >= RecordCount Then
        FItensJaExibidosBanner.Clear;

      If Length(LArrRecNo) < fCfgSis('BANQTD', VarInteger) Then
        FItensJaExibidosBanner.Clear;

      First;
      While Not Eof Do
      Begin
        If Length(LArrRecNo) > 0 Then
        Begin
          If Not MatchStr(RecNo.ToString, LArrRecNo) Then
          Begin
            Next;
            Continue;
          End;
        End;

        If cdsBanner.RecordCount >= fCfgSis('BANQTD', VarInteger) Then
          Break;

        cdsBanner.Insert;
        cdsBanner.FieldByName('CODITE').AsString := FieldByName('CODITE').AsString;
        cdsBanner.FieldByName('DESITE').AsString := FieldByName('DESITE').AsString;
        cdsBanner.FieldByName('DESPRO').AsString := FieldByName('DESPRO').AsString;
        cdsBanner.FieldByName('TABPRE').AsString := FieldByName('TABPRE').AsString;
        cdsBanner.FieldByName('VIGENC').AsString := FieldByName('VIGENC').AsString;
        cdsBanner.FieldByName('EMPRES').AsString := FieldByName('EMPRES').AsString;

        If (fRetornaPrecosPromocao(FieldByName('CODITE').AsString,
                                   '',
                                   VS_Date,
                                   1,
                                   0,
                                   0,
                                   intPraMedio,
                                   fltPreCus,
                                   fltPreVen,
                                   fltComVar,
                                   fltComAta,
                                   fltComDis,
                                   fltQtdDis,
                                   fltDesF07,
                                   strComPro,
                                   strCodPro,
                                   blnParticiona,
                                   blnPromo,
                                   strTabPre,
                                   '',
                                   '',
                                   '',
                                   False)) Then
          cdsBanner.FieldByName('PREVEN').AsFloat := fltPreVen
        Else
          cdsBanner.FieldByName('PREVEN').AsFloat := FieldByName('PREVEN').AsFloat;

        {$IFNDEF LINUX}
        If fRetornaPathImagem(True) <> '' Then
        Begin
          objOutputStream := TBytesStream.Create;
          Try
            If fCarregaImagemPrincipalProdutoDB(FieldByName('CODITE').AsString, objOutputStream, True) Then
              TBlobField(cdsBanner.FieldByName('IMAGEM')).LoadFromStream(objOutputStream);
          Finally
            If Assigned(objOutputStream) Then objOutputStream.Free;
          End;
        End;
        {$ENDIF}

        cdsBanner.Post;

        Next;
      End;

    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TComVen.pCarregaProdutosParaBanner]')
  End;

  FreeAndNil(qryBanner);
end;

procedure TItemPromo.pClear;
begin
  FstrCodCli := '';
  FstrTabPre := '';
  FstrCodIte := '';
  FstrCodEmp := '';
  FstrCodCnd := '';
  FstrSelect := '';
  FstrAndWhereCodIte := '';
  FstrAndWhereCodEmp := '';
  FstrAndWherePraMed := '';
  FstrAndWherePraMed := '';
  FstrAndWhereCodEmp := '';
  FblnUsaLimit := True;
  FblnProCliEmPrimeiro := True; ;
  Self.pSetaPraMedioDefault;
  FDataVigencia := VS_Date;
end;

procedure TItemPromo.pCriaClientBanner;
begin
  Try
    cdsBanner := TUniClientDataSet.Create(Nil);
    cdsBanner.AggregatesActive := True;

    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'CODITE'; DataType := ftString; Size := fTamCodIte; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESITE'; DataType := ftString; Size := 100; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'PREVEN'; DataType := ftFloat;               Required := False; End; //(12,02)
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'IMAGEM'; DataType := ftBlob;                Required := False; End;

    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'DESPRO'; DataType := ftString; Size := 80;  Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'TABPRE'; DataType := ftString; Size := 100; Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'VIGENC'; DataType := ftString; Size := 30;  Required := False; End;
    With cdsBanner.FieldDefs.AddFieldDef Do Begin Name := 'EMPRES'; DataType := ftString; Size := 200; Required := False; End;

    cdsBanner.CreateDataSet;
    TBlobField.Create(cdsBanner.FieldByName('IMAGEM') as TBlobField);

    cdsBanner.LogChanges := False;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TItemPromo.pCriaClientBanner]');
  End;
end;

procedure TItemPromo.pSetaPraMedioDefault;
begin
  FintPraMedio := -999;
  FstrPraMedio := '';
end;

function TItemPromo.RetSubQueryProCli: String;
begin
  Result := '';
  Result := Result + '  (SELECT P.PRO_CODCLI ';
  Result := Result + '   FROM PROCLI P ';
  Result := Result + '   WHERE P.PRO_SEQGER = CADPRO.AUTOINCREM)';
end;

{ TProQtdColetiva }

class function TProQtdColetiva.fAtivaPromocao(strCodPro, strCodigoItem, strCodigoUnidade: String; fltQtdIte : Double = 0): Boolean;
  Var
    intCnt : Integer;
    fltQtdLim : Double;
    fltQtdMin : Double;
    LstrIDKitAtivo : String;
begin
  Result := False;

  If fEmptyStr(strCodPro) Then
    Exit;

  if fEhPromocaoCompostaPorKit(strCodPro) then
  begin
    if not Assigned(cdsDadosPromocaoKit) then
      Exit(False);

    Result := fVerificarPromocaoCompostaPorKitAtiva(strCodPro, strCodigoItem, strCodigoUnidade, LstrIDKitAtivo)
  end
  else
  Begin
    pSetQtdLimMin(strCodPro, fltQtdLim, fltQtdMin);

    If (fFormataFloat(fltQtdIte, fCfgSis('DECQTD', varInteger)) <= 0) Then
    Begin
      fltQtdIte := 0;
      For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
      Begin
        If (ArrItemPro[intCnt].strCodPro = strCodPro) Then
          fltQtdIte := fltQtdIte + ArrItemPro[intCnt].fltQtdIte;
      End;
    End;

    fltQtdIte := (fFormataFloat(fltQtdIte, fCfgSis('DECQTD', varInteger)));

    If (fFormataFloat(fltQtdLim, fCfgSis('DECQTD', varInteger)) > 0) And
       (fFormataFloat(fltQtdMin, fCfgSis('DECQTD', varInteger)) > 0) Then
    Begin
      Result := (fltQtdIte <= fFormataFloat(fltQtdLim, fCfgSis('DECQTD', varInteger))) And
                (fltQtdIte >= fFormataFloat(fltQtdMin, fCfgSis('DECQTD', varInteger)));
    End
    Else
    Begin
      If (fFormataFloat(fltQtdLim, fCfgSis('DECQTD', varInteger)) > 0) Then
        Result := (fltQtdIte <= fFormataFloat(fltQtdLim, fCfgSis('DECQTD', varInteger)))
      Else
        Result := (fltQtdIte >= fFormataFloat(fltQtdMin, fCfgSis('DECQTD', varInteger)));
    End;
  End;
end;

class function TProQtdColetiva.fEhPromocaoCompostaPorKit(AstrCodigoPromocao : String): Boolean;
begin
  Result := fCampoTabela('PRO_IDXPRO', 'CADPRO', ['PRO_CODPRO'], [AstrCodigoPromocao]) =  IDX_TIPO_DESCONTO_PROMOCAO[tdpPromocaoCompostaPorKit];
end;

class function TProQtdColetiva.fEhTintaComPromocaoCompostaPorKit(AstrRashTinta: String): Boolean;
begin
  Result := False;

  if not Assigned(cdsDadosPromocaoKit) then
    Exit(False);

  cdsDadosPromocaoKit.First;
  While not cdsDadosPromocaoKit.Eof Do
  Begin
    if (cdsDadosPromocaoKit.FieldByName('KIT_ITETIN').AsString <> AstrRashTinta) then
    Begin
      cdsDadosPromocaoKit.Next;
      Continue;
    End;

    Result := not fEmptyStr(cdsDadosPromocaoKit.FieldByname('KIT_PROKIT').AsString);

    if Result then
      Break;

    cdsDadosPromocaoKit.Next;
  End;
end;

class function TProQtdColetiva.fGetBrindesDoKit(AstrIdKit : String): TUniQuery;
begin
  Result := fCriaQuery(Nil);
  Result.Sql.Clear;
  Result.Sql.Text := ' SELECT DISTINCT KITBRI.*, CADPRO.PRO_CODPRO '+
                     '   FROM CADPRO '+
                     '   JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                     '   JOIN KITDET ON KITDET.AUTOINCREM = ITEPRO.IPR_SEQKIT '+
                     '   JOIN CADKIT ON CADKIT.AUTOINCREM = KITDET.DET_SEQKIT '+
                     '   JOIN KITBRI ON KITBRI.BRI_SEQKIT = CADKIT.AUTOINCREM '+
                     '  WHERE KITBRI.BRI_SEQKIT = :SEQKIT ';
  Result.ParamByName('SEQKIT').AsString := AstrIdKit;
  Result.Open;
end;

class function TProQtdColetiva.fCodIteRepetido(strCodPro, strCodIte, strCodigoUnidade: String): Boolean;
  Var
    intCnt : Integer;
    intAux : Integer;
begin
  intAux := 0;

  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[intCnt].strCodIte = strCodIte) And
       (ArrItemPro[intCnt].strCodPro = strCodPro) And
       (ArrItemPro[intCnt].strCodUnidade = strCodigoUnidade) Then
    Begin
      intAux := intAux + 1;
    End;
  End;

  Result := intAux > 1;
end;

class function TProQtdColetiva.fGetCodPro(strCodIte: String): String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[intCnt].strCodIte = strCodIte) And
       (Not fEmptyStr(ArrItemPro[intCnt].strCodPro)) Then
    Begin
      Result := ArrItemPro[intCnt].strCodPro;
      Break;
    End;
  End;
end;

class function TProQtdColetiva.fGetIdKitPromocaoCompostaPorKit(AstrCodigoItem, AstrCodigoUnidadeMedida: String): String;
  Var
    Lidx : Integer;
    LstrIdKitAtivo : String;
    LstrCodigoPromocao : String;
begin
  Result := '';
  For Lidx := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[Lidx].strCodIte     = AstrCodigoItem) And
       (ArrItemPro[Lidx].strCodUnidade = AstrCodigoUnidadeMedida) Then
    Begin
      LstrCodigoPromocao := ArrItemPro[Lidx].strCodPro;
      Break;
    End;
  End;

  fVerificarPromocaoCompostaPorKitAtiva(LstrCodigoPromocao, AstrCodigoItem, AstrCodigoUnidadeMedida, LstrIDKitAtivo);

  Result := LstrIdKitAtivo;
end;

class function TProQtdColetiva.fGetIndex(strCodIte, strCodUnidadeMedida: String; strRshTin: String; strCodPro: string = ''): Integer;
  Var
    intCnt : Integer;
begin
  Result := -1;
  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[intCnt].strCodIte     = strCodIte) And
       (ArrItemPro[intCnt].strCodUnidade = strCodUnidadeMedida) And
       (IfEmptyStr(ArrItemPro[intCnt].strRshTin, 'NOR') = IfEmptyStr(strRshTin, 'NOR')) Then
    Begin
      If (Not fEmptyStr(strCodPro)) And (ArrItemPro[intCnt].strCodPro <> strCodPro) Then
        Continue;

      Result := intCnt;
      Break;
    End;
  End;
end;

class function TProQtdColetiva.fGetPrecoVendaPeloKit(ACoditoItem, ACodigoUnidade, ACodigoPromocao: String): Double;
 var
    LQuery               : TUniQuery;
    LPrecoVenda          : Double;
    LblnTemPromocaoAtiva : Boolean;
    LstrIDKitAtivo       : String;
begin
  LPrecoVenda := 0;

  if not Assigned(cdsDadosPromocaoKit) then
    Exit(LPrecoVenda);

  LQuery := fCriaQuery(Nil);

  Try
    LblnTemPromocaoAtiva := fVerificarPromocaoCompostaPorKitAtiva(ACodigoPromocao, ACoditoItem, ACodigoUnidade, LstrIDKitAtivo);

    if not LblnTemPromocaoAtiva then
      Exit(LPrecoVenda);

    LQuery.Sql.Clear;
    LQuery.Sql.Text := 'SELECT DET_PERDES '+
                       ' FROM KITDET '+
                       ' WHERE DET_SEQKIT = :SEQKIT '+
                       '   AND DET_CODGRU = :CODGRU '+
                       '   AND DET_CODUNI = :CODUNI ';
    cdsDadosPromocaoKit.First;
    While not cdsDadosPromocaoKit.Eof Do
    Begin

      if (cdsDadosPromocaoKit.FieldByName('KIT_ITETIN').AsString <> Self.strRshTinAtual) Or
         (cdsDadosPromocaoKit.FieldByName('KIT_CODITE').AsString <> ACoditoItem) then
      Begin
        cdsDadosPromocaoKit.Next;
        Continue;
      End;

      if fGrupoDoKitPossuiQuantidadeMinima(LstrIDKitAtivo,
                                           cdsDadosPromocaoKit.FieldByName('KIT_GRUPO_').AsString,
                                           cdsDadosPromocaoKit.FieldByName('KIT_UNIDAD').AsString) then
      Begin
        LQuery.ParamByName('SEQKIT').AsString := LstrIDKitAtivo;
        LQuery.ParamByName('CODGRU').AsString := cdsDadosPromocaoKit.FieldByName('KIT_GRUPO_').AsString;
        LQuery.ParamByName('CODUNI').AsString := cdsDadosPromocaoKit.FieldByName('KIT_UNIDAD').AsString;
        LQuery.Open;

        If not LQuery.IsEmpty then
          LPrecoVenda := cdsDadosPromocaoKit.FieldByName('KIT_PREVEN').AsFloat -
                         (cdsDadosPromocaoKit.FieldByName('KIT_PREVEN').AsFloat * (LQuery.FieldByName('DET_PERDES').AsFloat/100))
        else
          LPrecoVenda := cdsDadosPromocaoKit.FieldByName('KIT_PREVEN').AsFloat;

        LQuery.Close;
      End
      else
        LPrecoVenda := cdsDadosPromocaoKit.FieldByName('KIT_PREVEN').AsFloat;

      Break;
    End;

  Finally
    FreeAndNil(LQuery)
  End;

  Exit(LPrecoVenda);
end;

class function TProQtdColetiva.fGetQtd(strCodPro: String): Double;
  Var
    intCnt : Integer;
begin
  Result := 0;
  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[intCnt].strCodPro = strCodPro) Then
      Result := Result + ArrItemPro[intCnt].fltQtdIte;
  End;
  Result := (fFormataFloat(Result, fCfgSis('DECQTD', varInteger)));
end;

class function TProQtdColetiva.fGrupoDoKitPossuiQuantidadeMinima(AstrIdKitAtivo, AstrCodigoDoGrupo,  AstrUnidade: String): Boolean;
  var
    LQuery                      : TUniQuery;
    LQuantidadeAcumuladaParaKit : Double;
    LcdsTintaClone              : TUniClientDataSet;
begin
  Result := False;

  LQuery := fCriaQuery(Nil);

  LcdsTintaClone := TUniClientDataSet.Create(nil);
  pCloneDataSet(LcdsTintaClone, cdsDadosPromocaoKit);

  Try
    LQuery.Sql.Clear;
    LQuery.Sql.Text := ' SELECT DET_QTDGRU '+
                       '  FROM KITDET '+
                       ' WHERE DET_SEQKIT = :SEQKIT '+
                       '   AND DET_CODGRU = :CODGRU '+
                       '   AND DET_CODUNI = :CODUNI ';
    LQuery.ParamByName('SEQKIT').AsString := AstrIdKitAtivo;
    LQuery.ParamByName('CODGRU').AsString := AstrCodigoDoGrupo;
    LQuery.ParamByName('CODUNI').AsString := AstrUnidade;
    LQuery.Open;
    if not LQuery.IsEmpty then
    Begin
      LQuantidadeAcumuladaParaKit := 0;

      LcdsTintaClone.First;
      while not LcdsTintaClone.Eof do
      Begin
        If (LcdsTintaClone.FieldByName('KIT_GRUPO_').AsString  = AstrCodigoDoGrupo) And
           (LcdsTintaClone.FieldByName('KIT_UNIDAD').AsString = AstrUnidade) Then
          LQuantidadeAcumuladaParaKit := LQuantidadeAcumuladaParaKit + LcdsTintaClone.FieldByName('KIT_QTDGRU').AsFloat;

        LcdsTintaClone.Next;
      End;

      If LQuantidadeAcumuladaParaKit >= LQuery.FieldByName('DET_QTDGRU').AsFloat then
        Exit(True);
    End;

  Finally
    FreeAndNil(LQuery);
    FreeAndNil(LcdsTintaClone);
  End;
end;

class function TProQtdColetiva.fRecalculaPrecosDevidoAPromocaoPorKit: Boolean;
begin
  Result := False;

  if not fCfgSis('PROKIT', VarBoolean) then
    Exit(False);

  if not Assigned(cdsDadosPromocaoKit) then
    Exit(False);

  cdsDadosPromocaoKit.First;
  While not cdsDadosPromocaoKit.Eof Do
  Begin
    Result := not fEmptyStr(cdsDadosPromocaoKit.FieldByname('KIT_PROKIT').AsString);

    if Result then
      Break;

    cdsDadosPromocaoKit.Next;
  End;
end;

class procedure TProQtdColetiva.pAddOrUpdateItem(strCodIte, strCodigoUnidade, strCodPro: String;
  fltQtdIte, fltQtdLim, fltQtdMin: Double);
  Var
    intIndex : Integer;
    strRshTin : String;
begin
  strRshTin := IfEmptyStr(Self.strRshTinAtual, 'NOR');

  intIndex := fGetIndex(strCodIte, strCodigoUnidade, strRshTin, strCodPro);

  If (intIndex = -1) Then
  Begin
    SetLength(ArrItemPro, Length(ArrItemPro) + 1);
    intIndex := Length(ArrItemPro) -1;

    ArrItemPro[intIndex].strCodPro      := strCodPro;
    ArrItemPro[intIndex].strCodIte      := strCodIte;
    ArrItemPro[intIndex].fltQtdLim      := fltQtdLim;
    ArrItemPro[intIndex].fltQtdMin      := fltQtdMin;
    ArrItemPro[intIndex].strRshTin      := strRshTin;
    ArrItemPro[intIndex].strCodUnidade  := strCodigoUnidade;
  End;

  ArrItemPro[intIndex].fltQtdIte := fltQtdIte;
end;

class procedure TProQtdColetiva.pCopyArrItemPro(Var oriArrItemPro: TArrRecItemPro; Var desArrItemPro: TArrRecItemPro);
  Var
    intCnt: Integer;
begin
  SetLength(desArrItemPro, 0);

  for intCnt := Low(oriArrItemPro) to High(oriArrItemPro) do
  begin
    SetLength(desArrItemPro, Length(desArrItemPro) + 1);
    desArrItemPro[Length(desArrItemPro)-1] := oriArrItemPro[intCnt];
  end;
end;

class procedure TProQtdColetiva.pAdicionarStatusPromocaoDaTinta(AstrRashTinta, AstrPromocao: String);
begin
  if not Assigned(DicTintasEmPromocao) then
    DicTintasEmPromocao := TDicionario.Create;

  DicTintasEmPromocao.Adicionar(AstrRashTinta, AstrPromocao);
end;

class function TProQtdColetiva.fVerificarKitAtivo(AIDKit: String): Boolean;
  var
    LQuery                      : TUniQuery;
    LQuantidadeAcumuladaParaKit : Double;
begin
  Result := True;

  if not Assigned(cdsDadosPromocaoKit) then
    Exit(False);

  LQuery := fCriaQuery(Nil);

  Try
    LQuery.Sql.Clear;
    LQuery.Sql.Text := ' SELECT DET_SEQKIT, DET_CODGRU, DET_CODUNI, DET_QTDGRU, DET_TIPPRO '+
                       '  FROM KITDET '+
                       ' WHERE DET_SEQKIT = :SEQKIT ';
    LQuery.ParamByName('SEQKIT').AsString := AIDKit;
    LQuery.Open;
    while not LQuery.Eof do
    Begin
      if LQuery.FieldByName('DET_TIPPRO').AsString = 'GATILHO' then
      Begin
        LQuantidadeAcumuladaParaKit := 0;

        cdsDadosPromocaoKit.First;
        while not(cdsDadosPromocaoKit.Eof) do
        Begin
          If (cdsDadosPromocaoKit.FieldByName('KIT_GRUPO_').AsString = Lquery.FieldByName('DET_CODGRU').AsString) And
             (cdsDadosPromocaoKit.FieldByName('KIT_UNIDAD').AsString = Lquery.FieldByName('DET_CODUNI').AsString) Then
            LQuantidadeAcumuladaParaKit := LQuantidadeAcumuladaParaKit + cdsDadosPromocaoKit.FieldByName('KIT_QTDGRU').AsFloat;

          cdsDadosPromocaoKit.next;
        End;

        If LQuantidadeAcumuladaParaKit < LQuery.FieldByName('DET_QTDGRU').AsFloat then
          Exit(False);
      End;

      LQuery.Next;
    End;

  Finally
    FreeAndNil(LQuery)
  End;
end;

class function TProQtdColetiva.fVerificarPromocaoCompostaPorKitAtiva(AstrCodigoPromocao, AstrCodigoItem, AstrCodigoUnidadeMedida: String;
  var AstrIDKitAtivo : String): Boolean;
  var
    LQuery : TUniQuery;
begin
  Result := True;

  AstrIDKitAtivo := '';
  strIDKitAtivo  := '';

  LQuery := fCriaQuery(Nil);
  Try
    LQuery.Sql.Text := ' SELECT CADKIT.AUTOINCREM  '+
                       '   FROM CADPRO '+
                       '   JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                       '   JOIN KITDET ON KITDET.AUTOINCREM = ITEPRO.IPR_SEQKIT '+
                       '   JOIN CADKIT ON CADKIT.AUTOINCREM = KITDET.DET_SEQKIT '+
                       '  WHERE CADPRO.PRO_CODPRO = :CODPRO '+
                       '    AND ITEPRO.IPR_CODITE = :CODITE '+
                       '    AND KITDET.DET_CODUNI = :CODUNI '+
                       ' ORDER BY KITDET.DET_QTDGRU DESC ';
    LQuery.ParamByName('CODPRO').AsString := AstrCodigoPromocao;
    LQuery.ParamByName('CODITE').AsString := AstrCodigoItem;
    LQuery.ParamByName('CODUNI').AsString := AstrCodigoUnidadeMedida;
    LQuery.Open;

    if Lquery.IsEmpty then
      Exit(False);

    while not LQuery.Eof do
    Begin
      Result := fVerificarKitAtivo(Lquery.FieldByName('AUTOINCREM').AsString);

      if Result then
      Begin
        AstrIDKitAtivo := Lquery.FieldByName('AUTOINCREM').AsString;
        strIDKitAtivo  := Lquery.FieldByName('AUTOINCREM').AsString;
        Break;
      End;

      LQuery.Next;
    End;

    Lquery.Close;

  Finally
    FreeAndNil(LQuery)
  End;
end;

class procedure TProQtdColetiva.pDelItem(strCodIte, strCodUnidadeMedida: String; strRshTin: String);
  Var
    cloneArrItemPro: Array Of TrecItemPro;
    intCnt: Integer;
    intIndex: Integer;
    strIteMat,
    strIdeDel: String;
begin
  intIndex := fGetIndex(strCodIte, strCodUnidadeMedida, strRshTin);

  If (intIndex <> -1) Then
  Begin
    strIdeDel := strCodIte + strCodUnidadeMedida + IfEmptyStr(strRshTin, 'NOR');

    for intCnt := Low(ArrItemPro) to High(ArrItemPro) do
    begin
      strIteMat := ArrItemPro[intCnt].strCodIte + ArrItemPro[intCnt].strCodUnidade + IfEmptyStr(ArrItemPro[intCnt].strRshTin, 'NOR');

      If (strIteMat <> strIdeDel) Then
      begin
        SetLength(cloneArrItemPro, Length(cloneArrItemPro) + 1);
        cloneArrItemPro[Length(cloneArrItemPro) -1] := ArrItemPro[intCnt];
      end;
    end;

    TProQtdColetiva.pLimpar;

    for intCnt := Low(cloneArrItemPro) to High(cloneArrItemPro) do
    begin
      SetLength(ArrItemPro, Length(ArrItemPro) + 1);
      ArrItemPro[Length(ArrItemPro)-1] := cloneArrItemPro[intCnt];
    end;
  End;
end;

class procedure TProQtdColetiva.pLimpar;
begin
  SetLength(ArrItemPro, 0);
  Self.strRshTinAtual := '';
end;

class procedure TProQtdColetiva.pSetQtdLimMin(strCodPro: String; var fltQtdLim, fltQtdMin: Double);
  Var
    intCnt : Integer;
begin
  fltQtdLim := 0;
  fltQtdMin := 0;
  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (ArrItemPro[intCnt].strCodPro = strCodPro) Then
    Begin
      fltQtdLim := ArrItemPro[intCnt].fltQtdLim;
      fltQtdMin := ArrItemPro[intCnt].fltQtdMin;
      Break;
    End;
  End;
end;

class function TProQtdColetiva.pGetDadosPromocaoCompostaPorKit(AstrCodigoItem, AstrCodigoUnidade, AstrCodigoPromocao: String;
  var ACodigoGrupo: String; var AItemGatilho : Boolean): Boolean;
  var
    LQuery   : TUniQuery;
begin
  Result := False;

  LQuery := fCriaQuery(Nil);
  Try
    LQuery.Sql.Text := ' SELECT DISTINCT KITDET.DET_CODGRU, KITDET.DET_TIPPRO '+
                       '   FROM CADPRO '+
                       '   JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER '+
                       '   JOIN KITDET ON KITDET.AUTOINCREM = ITEPRO.IPR_SEQKIT '+
                       '   JOIN CADKIT ON CADKIT.AUTOINCREM = KITDET.DET_SEQKIT '+
                       '  WHERE CADPRO.PRO_CODPRO = :CODPRO '+
                       '    AND ITEPRO.IPR_CODITE = :CODITE '+
                       '    AND KITDET.DET_CODUNI = :CODUNI ';
    LQuery.ParamByName('CODPRO').AsString := AstrCodigoPromocao;
    LQuery.ParamByName('CODITE').AsString := AstrCodigoItem;
    LQuery.ParamByName('CODUNI').AsString := AstrCodigoUnidade;
    LQuery.Open;
    if not LQuery.IsEmpty then
    Begin
      Result       := True;
      ACodigoGrupo := LQuery.FieldByName('DET_CODGRU').AsString;
      AItemGatilho := Pos('GATILHO', LQuery.FieldByName('DET_TIPPRO').AsString) > 0;
    End;
    Lquery.Close;
  Finally
    FreeAndNil(LQuery)
  End;
end;

{ TEventosCadPro }

class function TEventosCadPro.fGetUnitarioEmbalagemFechada(strCodItem,
  strTabelaPreco: String; fltQtdItem, fltUnitOriginal: Double): Double;
begin
  Result := fncGetUnitarioEmbalagemFechada(strCodItem, strTabelaPreco, fltQtdItem, fltUnitOriginal);
end;

class function TEventosCadPro.fPegaIcmsSai(strCodIte, strEmpIte: String): Double;
begin
  Result := fncPegaIcmsSai(strCodIte, strEmpIte);
end;

class function TEventosCadPro.fPegaPrecoVenda(strCodIte, strCodEmp, strCodCli,
  strTabPre, strEstDes: String; fltIcmSai: Double; fltDesF07: Double; var fltPreCus: Double): Double;
begin
  Result := fncPegaPrecoVenda(strCodIte, strCodEmp, strCodCli, strTabPre, strEstDes, fltIcmSai, fltDesF07, fltPreCus);
end;

class function TEventosCadPro.fUFDestTrib(strEmpIte: string): String;
begin
  Result := fncUFDestTrib(strEmpIte);
end;

class function TEventosCadPro.fOpcDoc: string;
begin
  Result := fncOpcDoc;
end;

class function TEventosCadPro.fQueryEmCacheTrouxeAlgumRegistro(qryGen: TUniQuery): Boolean;
begin
  Result := fncQueryEmCacheTrouxeAlgumRegistro(qryGen); 
end;

class function TEventosCadPro.fUFEmpresa(strEmpIte: string): String;
begin
  Result := fncUFEmpresa(strEmpIte);
end;

{ TParametrosPromocao }

function TParametrosPromocao.AutInc: TArray<String>;
begin
  If (Not FConsultouPromocao) Then
  Begin
    If FBlnArrayPreenchidoParam Then
      pSetarParamArrays
    Else
      pVerificaTipoQtdDisponivel();
  End;

  Result := FAutInc;
end;

function TParametrosPromocao.blnArrayPreenchido(
  const Value: Boolean): IParametrosPromocao;
begin
  FBlnArrayPreenchidoParam := Value;
  Result := Self;
end;

function TParametrosPromocao.blnFiltrarCodIte: Boolean;
begin
  Result := FblnFiltraCodIte;
end;

function TParametrosPromocao.blnFiltrarCodIte(
  const Value: Boolean): IParametrosPromocao;
begin
  FblnFiltraCodIte := Value;
  Result := Self;
end;

function TParametrosPromocao.blnTodasEmpresas(
  const Value: Boolean): IParametrosPromocao;
begin
  FblnTodasEmpresasProm := Value;
  Result := Self;
end;

function TParametrosPromocao.CodCli: String;
begin
  Result := FCodCli;
end;

function TParametrosPromocao.CodCli(const Value: String): IParametrosPromocao;
begin
  FCodCli := Value;
  Result := Self;
end;

function TParametrosPromocao.CodEmp(const Value: String): IParametrosPromocao;
begin
  FCodEmp := Value;
  Result := Self;
end;

function TParametrosPromocao.CodEmp: String;
begin
  Result := FCodEmp;
end;

function TParametrosPromocao.CodIte(const Value: String): IParametrosPromocao;
begin
  FCodIte := Value;
  Result := Self;
end;

function TParametrosPromocao.CodIte: String;
begin
  Result := FCodIte;
end;

function TParametrosPromocao.Conexao(
  const Value: TUniConnection): IParametrosPromocao;
begin
  FConexao := Value;
  Result := Self;
end;

function TParametrosPromocao.Conexao: TUniConnection;
begin
  Result := FConexao;
end;

constructor TParametrosPromocao.Create;
begin
  FCodIte := '';
  FCodEmp := '';
  FCodCli := '';
  FTabPre := '';
  FNumOrc := '';
  FEspOrc := '';
  FConexao := nil;
  FConsultouPromocao := False;
  SetLength(FAutInc, 0);
  SetLength(FTodasEmpresas, 0);
  FBlnFiltraCodIte := True;
  FBlnArrayPreenchidoParam := False;
end;

function TParametrosPromocao.EspOrc(const Value: String): IParametrosPromocao;
begin
  FEspOrc := Value;
  Result := Self;
end;

function TParametrosPromocao.EspOrc: String;
begin
  Result := FEspOrc;
end;

function TParametrosPromocao.fGetSelectTipoQtdDis: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   CADPRO.AUTOINCREM AS AUTINC,                 ';
  Result := Result + '   IFNULL(PROCLI.PRO_CODCLI, "TODOS") AS CODCLI,';
  Result := Result + '   PRO_IDXQTD AS IDXQTD                         ';
  Result := Result + 'FROM                                            ';
  Result := Result + '  CADPRO                                        ';
  Result := Result + '  INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '  INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '  LEFT JOIN PROCLI  ON CADPRO.AUTOINCREM = PROCLI.PRO_SEQGER ';
  Result := Result + 'WHERE                                           ';
  Result := Result + '   '  + fCurrentDate + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
  Result := Result + ' AND ITEPRO.IPR_CODITE = :CODITE ';
  Result := Result + ' AND PROEMP.PRO_CODEMP = :CODEMP ';
  Result := Result + fGetFiltroTabelaPrecoPromocao(FTabPre);
  Result := Result + fGetFiltroPromocaoRestritaClientesNaoConsumidor(FCodCli);
  Result := Result + ' AND (IFNULL(ITEPRO.IPR_QTDLIM, 0) > 0) ';
  Result := Result + ' ORDER BY CADPRO.PRO_TABLOI DESC ';
end;

function TParametrosPromocao.LevantarExcecao(
  const Value: Boolean): IParametrosPromocao;
begin
  FLevantarExcecao := Value;
  Result := Self;
end;

function TParametrosPromocao.LevantarExcecao: Boolean;
begin
  Result := FLevantarExcecao;
end;

class function TParametrosPromocao.New: IParametrosPromocao;
begin
  Result := TParametrosPromocao.Create;
end;

function TParametrosPromocao.NumOrc(const Value: String): IParametrosPromocao;
begin
  FNumOrc := Value;
  Result := Self;
end;

function TParametrosPromocao.NumOrc: String;
begin
  Result := FNumOrc;
end;

procedure TParametrosPromocao.pSetarParamArrays;
begin
  SetLength(FAutInc, length(FAutInc) + 1);
  SetLength(FTodasEmpresas, length(FTodasEmpresas) + 1);

  FAutInc[length(FAutInc) -1] := FStrAutIncProm;
  FTodasEmpresas[length(FTodasEmpresas)-1] := FblnTodasEmpresasProm;

  FConsultouPromocao := True;
end;

procedure TParametrosPromocao.pVerificaTipoQtdDisponivel;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil, FConexao);

  Try
    Try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(fGetSelectTipoQtdDis());
      qryGen.ParamByName('CODITE').AsString := FCodIte;
      qryGen.ParamByName('CODEMP').AsString := FCodEmp;
      qryGen.Open;

      qryGen.First;

      SetLength(FAutInc, qryGen.RecordCount);
      SetLength(FTodasEmpresas, qryGen.RecordCount);

      While (Not qryGen.Eof) Do
      Begin
        FTodasEmpresas[qryGen.RecNo -1] := (qryGen.FieldByName('IDXQTD').AsInteger = 1);
        FAutInc[qryGen.RecNo -1] := qryGen.FieldByName('AUTINC').AsString;

        qryGen.Next;
      End;

      qryGen.Close();
    Except
      On E: Exception Do
        pMensagensErro(E.Message,'[TUpdatePromo.pVerificaTipoParaTratarQtdDisponivel]');
    End;
  Finally
    FConsultouPromocao := True;
    FreeAndNil(qryGen);
  End;
end;

function TParametrosPromocao.strAutIncProm: String;
begin
  Result := FStrAutIncProm;
end;

function TParametrosPromocao.strAutIncProm(
  const Value: String): IParametrosPromocao;
begin
  FstrAutIncProm := Value;
  Result := Self;
end;

function TParametrosPromocao.TabPre(const Value: String): IParametrosPromocao;
begin
  FTabPre := Value;
  Result := Self;
end;

function TParametrosPromocao.TabPre: String;
begin
  Result := FTabPre;
end;

function TParametrosPromocao.TodasEmpresas: TArray<Boolean>;
begin
  If (Not FConsultouPromocao) Then
    pVerificaTipoQtdDisponivel();

  Result := FTodasEmpresas;
end;

{ TUpdatePromo }

constructor TUpdatePromo.Create(AParams: IParametrosPromocao);
begin
  FParametros := AParams;
  FQryCommand := fCriaQuery(Nil, FParametros.Conexao());
end;

destructor TUpdatePromo.Destroy;
begin
  FreeAndNil(FQryCommand);
  inherited;
end;

function TUpdatePromo.fGetSQLUpdateQtdDisponivel(AIndex: Integer): String;
begin
  Result := '';
  Result := Result + ' UPDATE IPREMP P                               ';
  Result := Result + '   JOIN ITEPRO I ON I.AUTOINCREM = P.IPR_SEQGER';
  Result := Result + '  SET                                          ';
  Result := Result + '  IPR_QTDDIS = IF(<OPERACAO> BETWEEN 0 AND I.IPR_QTDLIM, <OPERACAO>, IF(<OPERACAO> < 0, 0, I.IPR_QTDLIM)) ';
  Result := Result + ' WHERE I.IPR_SEQGER = :AUTINC                  ';
  Result := Result + '   AND I.IPR_CODITE = :CODITE                  ';

  If (Not FParametros.TodasEmpresas[AIndex]) Then
    Result := Result + ' AND P.IPR_CODEMP = :CODEMP                  ';

  Result := AnsiReplaceStr(Result, '<OPERACAO>', '(I.IPR_QTDLIM - :QTDVEN)');  
end;

class function TUpdatePromo.New(AParams: IParametrosPromocao): IUpdatePromo;
begin
  Result := TUpdatePromo.Create(AParams);
end;

function TUpdatePromo.Parametros: IParametrosPromocao;
begin
  Result := FParametros;
end;

function TUpdatePromo.fAtualizaQtdDisponivelTabTmp(ANomTabTmp: String): IUpdatePromo;
var
  fltQtdVen: Double;
  LIndex: Integer;
  strAutInc: String;
begin
  Try
    Try
      strAutInc := EmptyStr;
      For LIndex := 0 To High(FParametros.AutInc) Do
      Begin
        If Not fEncontrouPromocao(LIndex) Then
          Continue;

        If strAutInc = FParametros.AutInc[LIndex] Then
          Continue;

        strAutInc := FParametros.AutInc[LIndex];

        fltQtdVen := TConsultaPromocao.New(FParametros, LIndex).fGetQtdVendidaTabelaTemporaria(ANomTabTmp);

        FQryCommand.Close();
        FQryCommand.SQL.Clear();
        FQryCommand.SQL.Add(fGetSQLUpdateQtdDisponivel(LIndex));
        FQryCommand.ParamByName('QTDVEN').AsFloat := fltQtdVen;
        FQryCommand.ParamByName('AUTINC').AsString := FParametros.AutInc[LIndex];
        FQryCommand.ParamByName('CODITE').AsString := FParametros.CodIte();

        If (Not FParametros.TodasEmpresas[LIndex]) Then
          FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

        FQryCommand.ExecSQL;

        FQryCommand.Close();
      End;
    Except
      On E: Exception Do
      Begin
        If FParametros.LevantarExcecao Then
          Raise Exception.Create('[TUpdatePromo.fAtualizaQtdDisponivelTabTmp] ' + E.Message)
        Else
          pMensagensErro(E.Message,'[TUpdatePromo.fAtualizaQtdDisponivelTabTmp]');
      End;
    End;
  Finally
    Result := Self;
  End;
end;

function TUpdatePromo.fAtualizaQtdDisponivel: IUpdatePromo;
var
  fltQtdVen: Double;
  LIndex: Integer;
  strAutInc: String;
begin
  Try
    Try
      strAutInc := EmptyStr;
      For LIndex := 0 To High(FParametros.AutInc) Do
      Begin
        If Not fEncontrouPromocao(LIndex) Then
          Continue;

        If strAutInc = FParametros.AutInc[LIndex] Then
          Continue;

        strAutInc := FParametros.AutInc[LIndex];

        fltQtdVen := TConsultaPromocao.New(FParametros, LIndex).fGetQtdVendida();

        FQryCommand.Close();
        FQryCommand.SQL.Clear();
        FQryCommand.SQL.Add(fGetSQLUpdateQtdDisponivel(LIndex));
        FQryCommand.ParamByName('QTDVEN').AsFloat := fltQtdVen;
        FQryCommand.ParamByName('AUTINC').AsString := FParametros.AutInc[LIndex];
        FQryCommand.ParamByName('CODITE').AsString := FParametros.CodIte();

        If (Not FParametros.TodasEmpresas[LIndex]) Then
          FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

        FQryCommand.ExecSQL;

        FQryCommand.Close();
      End;
    Except
      On E: Exception Do
      Begin
        If FParametros.LevantarExcecao Then
          Raise Exception.Create('[TUpdatePromo.fAtualizaQtdDisponivel] ' + E.Message)
        Else
          pMensagensErro(E.Message,'[TUpdatePromo.fAtualizaQtdDisponivel]');
      End;
    End;
  Finally
    Result := Self;
  End;
end;

function TUpdatePromo.fAtualizaQtdDisponivelTmp(fltQtdVen: Double;
  pgbStatus: TcxProgressBar): IUpdatePromo;
var
  LIndex: Integer;
  strAutInc: String;
begin
  Try
    FQryCommand.DisableControls;
    Try
      strAutInc := EmptyStr;
      For LIndex := 0 To High(FParametros.AutInc) Do
      Begin
        If Not fEncontrouPromocao(LIndex) Then
          Continue;

        If strAutInc = FParametros.AutInc[LIndex] Then
          Continue;

        strAutInc := FParametros.AutInc[LIndex];

        FQryCommand.Close();
        FQryCommand.SQL.Clear();
        FQryCommand.SQL.Add(fGetSQLUpdateQtdDisponivel(LIndex));
        FQryCommand.ParamByName('QTDVEN').AsFloat := fltQtdVen;
        FQryCommand.ParamByName('AUTINC').AsString := FParametros.AutInc[LIndex];
        FQryCommand.ParamByName('CODITE').AsString := FParametros.CodIte();

        If (Not FParametros.TodasEmpresas[LIndex]) Then
          FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

        FQryCommand.ExecSQL;

        FQryCommand.Close();
      End;
    Except
      On E: Exception Do
      Begin
        If FParametros.LevantarExcecao Then
          Raise Exception.Create('[TUpdatePromo.fAtualizaQtdDisponivelTmp] ' + E.Message)
        Else
          pMensagensErro(E.Message,'[TUpdatePromo.fAtualizaQtdDisponivelTmp]');
      End;
    End;
  Finally
    Result := Self;
  End;
end;

function TUpdatePromo.fEncontrouPromocao(AIndex: Integer): Boolean;
begin
  Result := (Not fEmptyStr(FParametros.AutInc[AIndex]));
end;

{ TInvokerUpdatePromo }

constructor TInvokerUpdatePromo.Create;
begin
  FCommandList := TInterfaceList.Create();
end;

destructor TInvokerUpdatePromo.Destroy;
begin
  FCommandList.Clear();
  FCommandList.Free();
  inherited;
end;

function TInvokerUpdatePromo.fAtualizaQtdDisponivel(
  pgbStatus: TcxProgressBar): IInvokerUpdatePromo;
var
  LIdx: Integer;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Atualizando Quantidade Promoção Disponível...', FCommandList.Count);
  For LIdx:= 0 To FCommandList.Count-1 Do
  Begin
    IUpdatePromo(
      FCommandList[LIdx]
    ).fAtualizaQtdDisponivel();

    pStepStatusGravacao(pgbStatus);
  End;
  Result := Self;
end;

function TInvokerUpdatePromo.fAtualizaQtdDisponivelTabTmp(
  pgbStatus: TcxProgressBar): IInvokerUpdatePromo;
var
  LIdx: Integer;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Atualizando Quantidade Promoção Disponível...', FCommandList.Count);
  For LIdx:= 0 To FCommandList.Count-1 Do
  Begin
    IUpdatePromo(
      FCommandList[LIdx]
    ).fAtualizaQtdDisponivelTabTmp(FNomTabTmp);

    pStepStatusGravacao(pgbStatus);
  End;

  RemoveTabelaTemporaria;

  Result := Self;
end;

class function TInvokerUpdatePromo.New: IInvokerUpdatePromo;
begin
  Result := TInvokerUpdatePromo.Create();
end;

procedure TInvokerUpdatePromo.pAdd(ACommand: IUpdatePromo);
begin
  FCommandList.Add(ACommand);
end;

procedure TInvokerUpdatePromo.pLimpar;
begin
   FCommandList.Clear;
end;

function TInvokerUpdatePromo.RemoveTabelaTemporaria: Boolean;
begin
  Result := False;

  If fTabelaExiste(FNomTabTmp) Then
    Result := fDropTable(FNomTabTmp);
end;

function TInvokerUpdatePromo.fAtualizaQtdDisponivel: IInvokerUpdatePromo;
var
  LIdx: Integer;
begin
  For LIdx := 0 To Pred(FCommandList.Count) Do
    IUpdatePromo(
      FCommandList[LIdx]
    ).fAtualizaQtdDisponivel();

  Result := Self;
end;

function TInvokerUpdatePromo.fAtualizaQtdDisponivelTmp(
  pgbStatus: TcxProgressBar): IInvokerUpdatePromo;
var
  LIdx: Integer;
  fltQtd: Double;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Atualizando Quantidade Promoção Disponível ...', FCommandList.Count);

  For LIdx:= 0 To FCommandList.Count-1 Do
  Begin
    fltQtd := fRetornaQtdIte(IUpdatePromo(FCommandList[LIdx]).Parametros.CodIte,
                             IUpdatePromo(FCommandList[LIdx]).Parametros.CodEmp);

    IUpdatePromo(
      FCommandList[LIdx]
    ).fAtualizaQtdDisponivelTmp(fltQtd, pgbStatus);

    pStepStatusGravacao(pgbStatus);
  End;
  Result := Self;
end;

function TInvokerUpdatePromo.fConsultaQtdDispTabelaProm(const strAutInc,
  strCodEmp: String; blnTodasEMpresas: Boolean): Boolean;
var
  FConsultaProm: TConsultaPromocao;
  paramCnsTabela: IUpdatePromo;
begin
  Try
    pLimpar;

    paramCnsTabela := TUpdatePromo.New(
                       TParametrosPromocao.New()
                         .strAutIncProm(strAutInc)
                         .CodEmp(strCodEmp)
                         .blnFiltrarCodIte(False)
                         .blnTodasEmpresas(blnTodasEMpresas)
                         .LevantarExcecao(False)
                       );

    FConsultaProm := TConsultaPromocao.Create(paramCnsTabela.Parametros, 0);
    Try
      FConsultaProm.ConsultaQuantidadeVendida;
      FNomTabTmp := FConsultaProm.NomeTabelaTemp;
    Finally
      FreeAndNil(FConsultaProm);
    End;

    Result := True;
  Except
    Result := False;
  End;
end;

function TInvokerUpdatePromo.fRetornaQtdIte(const strCodIte,
  strCodEmp: String): Double;
begin
  If Not Assigned(FCdsConsProm) Then
    Exit(0);

  FCdsConsProm.Filter   := 'IPR_CODITE = ' + QuotedStr(strCodIte) + ' AND PRO_CODEMP = ' + QuotedStr(strCodEmp);
  FCdsConsProm.Filtered := True;

  Result := FCdsConsProm.FieldByName('QTDVEN').AsFloat;

  FCdsConsProm.Filter   := '';
  FCdsConsProm.Filtered := False;
end;

{ TConsultaPromocao }

function TConsultaPromocao.ConsultaQuantidadeVendida: Boolean;
begin
  Result := False;

  FNomTabTmp := RetornaNomeTabTemp;

  If fTabelaExiste(FNomTabTmp) Then
    fDropTable(FNomTabTmp);

  FParametros.pSetarParamArrays;

  If fEmptyStr(FParametros.strAutIncProm) Then
    Exit;

  Try
    FQryCommand.Close;
    FQryCommand.SQL.Clear;
    FQryCommand.SQL.Add('CREATE TEMPORARY TABLE '+ FNomTabTmp);
    FQryCommand.SQL.Add(fGetSelectQtdVendidaTabTmp());

    FQryCommand.ParamByName('AUTINC').AsString := FParametros.strAutIncProm;
    If (Not FParametros.TodasEmpresas[FIndex]) Then
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

    FQryCommand.ExecSQL;

    FQryCommand.Close();

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TConsultaPromocao.ConsultaQuantidadeVendida] ' + E.Message);
    End;
  End;
end;

constructor TConsultaPromocao.Create(AParams: IParametrosPromocao; AIndex: Integer);
begin
  FIndex      := AIndex;
  FParametros := AParams;
  FQryCommand := fCriaQuery(Nil, FParametros.Conexao());
  FItemPromo  := TItemPromo.Create;
end;

destructor TConsultaPromocao.Destroy;
begin
  FreeAndNil(FItemPromo);
  FreeAndNil(FQryCommand);
  inherited;
end;

function TConsultaPromocao.fConsultaQtdDispPorTabela(
  var cdsCons: TUniClientDataSet): Boolean;
begin
  Result := False;

  FParametros.pSetarParamArrays;

  If fEmptyStr(FParametros.strAutIncProm) Then
    Exit;

  Try
    FQryCommand.Close;
    FQryCommand.SQL.Clear;
    FQryCommand.SQL.Add(fGetSelectQtdVendida());

    FQryCommand.ParamByName('AUTINC').AsString := FParametros.strAutIncProm;

      If (Not FParametros.TodasEmpresas[FIndex]) Then
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

    FQryCommand.Open;

    cdsCons := fCriaClientDatSet(FQryCommand);

    Result := True;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TConsultaPromocao.fConsultaQtdDispPorTabela]');
  End;
end;

function TConsultaPromocao.fGetQtdVendida: Double;
begin
  Result := 0;

  If fEmptyStr(FParametros.AutInc[FIndex]) Then
    Exit;

  Try
    FQryCommand.Close;
    FQryCommand.SQL.Clear;
    FQryCommand.SQL.Add(fGetSelectQtdVendida());
    FQryCommand.ParamByName('CODITE').AsString := FParametros.CodIte();
    FQryCommand.ParamByName('AUTINC').AsString := FParametros.AutInc[FIndex];

    If (Not FParametros.TodasEmpresas[FIndex]) Then
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

    FQryCommand.Open;

    Result := FQryCommand.FieldByName('QTDVEN').AsFloat;

    FQryCommand.Close();
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[TConsultaPromocao.fGetQtd]');
  End;
end;

function TConsultaPromocao.fGetQtdVendidaTabelaTemporaria(ANomTab: String): Double;
begin
  Result := 0;

  If fEmptyStr(ANomTab) Then
    Exit;

  If fEmptyStr(FParametros.AutInc[FIndex]) Then
    Exit;

  Try
    FQryCommand.Close;
    FQryCommand.SQL.Clear;
    FQryCommand.SQL.Add('SELECT QTDVEN FROM ');
    FQryCommand.SQL.Add(ANomTab);
    FQryCommand.SQL.Add('WHERE IPR_SEQGER = :AUTINC');
    FQryCommand.SQL.Add('  AND IPR_CODITE = :CODITE');
    If (Not FParametros.TodasEmpresas[FIndex]) Then
      FQryCommand.SQL.Add('  AND PRO_CODEMP = :CODEMP');

    FQryCommand.ParamByName('CODITE').AsString := FParametros.CodIte();
    FQryCommand.ParamByName('AUTINC').AsString := FParametros.AutInc[FIndex];
    If (Not FParametros.TodasEmpresas[FIndex]) Then
      FQryCommand.ParamByName('CODEMP').AsString := FParametros.CodEmp();

    FQryCommand.Open;

    Result := FQryCommand.FieldByName('QTDVEN').AsFloat;

    FQryCommand.Close();
  Except
    On E: Exception Do
    Begin
       Raise Exception.Create('[TConsultaPromocao.fGetQtdVendidaTabelaTemporaria] ' + E.Message);
    End;
  End;
end;

function TConsultaPromocao.fGetSelectQtdVendida: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   IFNULL(ITEPRO.IPR_CODITE, "") AS IPR_CODITE, ';
  Result := Result + '   IFNULL(ITEPRO.AUTOINCREM, "") AS AUTINC,     ';
  Result := Result + '   IFNULL(PROEMP.PRO_CODEMP, "") AS PRO_CODEMP, ';
  Result := Result + '   IFNULL(PROCLI.PRO_CODCLI, "TODOS") AS CODCLI, ';

  FItemPromo.strTabPre := FParametros.TabPre();
  FItemPromo.strENTBRF := '';
  FItemPromo.strNumOrc := FParametros.NumOrc();
  FItemPromo.strEspOrc := FParametros.EspOrc();

  Result := Result + ' IF(PROCLI.PRO_CODCLI IS NULL, '+
        FItemPromo.fRetSubQryAuxVWMovDet(tpGeral)     + ' + ' +
        FItemPromo.fRetSubQryAuxVWFatDor(tpGeral)     + ' , ' +
        FItemPromo.fRetSubQryAuxVWMovDet(tpDoCliente) + ' + ' +
        FItemPromo.fRetSubQryAuxVWFatDor(tpDoCliente) +') AS QTDVEN ';

  Result := Result + 'FROM                                          ';
  Result := Result + '  CADPRO                                      ';
  Result := Result + '  INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '  INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '   LEFT JOIN PROCLI ON CADPRO.AUTOINCREM = PROCLI.PRO_SEQGER ';
  Result := Result + 'WHERE                                         ';
  Result := Result + '   CADPRO.AUTOINCREM = :AUTINC                ';
  Result := Result + ' AND '  + fCurrentDate + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';

  If (Not FParametros.TodasEmpresas[FIndex]) Then
    Result := Result + ' AND (LOCATE( PROEMP.PRO_CODEMP, :CODEMP ) > 0)';

  If (FParametros.blnFiltrarCodIte) Then
    Result := Result + ' AND ITEPRO.IPR_CODITE = :CODITE ';
end;

function TConsultaPromocao.fGetSelectQtdVendidaTabTmp: String;
begin
  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '   ITEPRO.IPR_SEQGER AS IPR_SEQGER, ';
  Result := Result + '   IFNULL(ITEPRO.IPR_CODITE, "") AS IPR_CODITE, ';
  Result := Result + '   IFNULL(ITEPRO.AUTOINCREM, "") AS AUTINC,     ';
  Result := Result + '   IFNULL(PROEMP.PRO_CODEMP, "") AS PRO_CODEMP, ';

  FItemPromo.strTabPre := FParametros.TabPre();
  FItemPromo.strENTBRF := '';
  FItemPromo.strNumOrc := FParametros.NumOrc();
  FItemPromo.strEspOrc := FParametros.EspOrc();

  Result := Result + ' ( ';
  If PromocaoPorClientes Then
  Begin
    Result := Result +  FItemPromo.fRetSubQryAuxVWMovDet(tpDoCliente2) + ' + ' +
                        FItemPromo.fRetSubQryAuxVWFatDor(tpDoCliente2) ;
  End
  Else
  Begin
    Result := Result +  FItemPromo.fRetSubQryAuxVWMovDet(tpGeral)     + ' + ' +
                        FItemPromo.fRetSubQryAuxVWFatDor(tpGeral)     ;
  End;

  Result := Result + ' ) AS QTDVEN ';

  Result := Result + 'FROM                                          ';
  Result := Result + '  CADPRO                                      ';
  Result := Result + '  INNER JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '  INNER JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';

  Result := Result + 'WHERE                                         ';
  Result := Result + '   CADPRO.AUTOINCREM = :AUTINC                ';
  Result := Result + ' AND '  + fCurrentDate + ' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';

  If (Not FParametros.TodasEmpresas[FIndex]) Then
    Result := Result + ' AND (LOCATE( PROEMP.PRO_CODEMP, :CODEMP ) > 0)';

end;

class function TConsultaPromocao.New(AParams: IParametrosPromocao; AIndex: Integer): IConsultaPromocao;
begin
  Result := TConsultaPromocao.Create(AParams, AIndex);
end;

function TConsultaPromocao.PromocaoPorClientes: Boolean;
Var
  qrySelect:  TUniQuery;
begin
  Result := True;

  FParametros.pSetarParamArrays;

  If fEmptyStr(FParametros.strAutIncProm) Then
    Exit;

  qrySelect := fCriaQuery;
  Try
    Try
      qrySelect.Close;
      qrySelect.SQL.Clear;
      qrySelect.SQL.Add('SELECT COUNT(*) AS QTDCLI FROM PROCLI WHERE PRO_SEQGER = :AUTINC');
      qrySelect.ParamByName('AUTINC').AsString := FParametros.strAutIncProm;

      qrySelect.Open;

      Result := qrySelect.FieldByName('QTDCLI').AsInteger > 0 ;
      qrySelect.Close();
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('[TConsultaPromocao.ConsultaQuantidadeVendida] ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qrySelect);
  End;
end;

function TConsultaPromocao.RetornaNomeTabTemp: String;
var
  LSeqTab: String;
begin
  LSeqTab := FormatDateTime('yyyyMMddhhmmss', fNow()) + Random(99999).ToString;
  Result := 'TMP_PROM'+ LSeqTab;
end;

{ TProLog }

function TProLog.AddCampoLog(ACampo: TProLogCampo): IProLog;
begin
  SetLength(FCampos, Length(FCampos) + 1);
  FCampos[Length(FCampos)-1] := ACampo;
end;

procedure TProLog.AddLogExclusao(ACampo: TProLogCampo;
  ADadosOriginal: TZClient; AProduto, AInformacao: String);
Var
  LChanges: TProLogChanges;
  LIndex: Integer;
begin
  If ADadosOriginal.FindField(ACampo.NomeCampo) = nil Then
    Exit;

  LChanges.NomeTabela      := ACampo.NomeTabela;
  LChanges.DescricaoTabela := GetDescricaoTabela(ACampo.NomeTabela);
  LChanges.NomeCampo       := ACampo.NomeCampo;
  LChanges.DescricaoCampo  := ACampo.DescricaoCampo;
  LChanges.CodigoProduto   := AProduto;
  LChanges.ValorAnterior   := ADadosOriginal.FindField(ACampo.NomeCampo).AsString;
  LChanges.ValorAtual      := '';

  If Length(ACampo.Valores) > 0 Then
  Begin
    LIndex := IndexStr(LChanges.ValorAnterior, ACampo.Valores);

    If LIndex >= 0 Then
      LChanges.ValorAnterior :=
        LChanges.ValorAnterior + ' - ' + ACampo.DescricaoValores[LIndex];
  End;

  LChanges.Informacoes := AInformacao;

  SetLength(FChanges, Length(FChanges) + 1);
  FChanges[Length(FChanges) - 1] := LChanges;
end;

procedure TProLog.AddLogInclusao(ACampo: TProLogCampo; ADadosAtual: TZClient;
  AProduto, AInformacao: String);
Var
  LChanges: TProLogChanges;
  LIndex: Integer;
begin
  If ADadosAtual.FindField(ACampo.NomeCampo) = nil Then
    Exit;

  LChanges.NomeTabela      := ACampo.NomeTabela;
  LChanges.DescricaoTabela := GetDescricaoTabela(ACampo.NomeTabela);
  LChanges.NomeCampo       := ACampo.NomeCampo;
  LChanges.DescricaoCampo  := ACampo.DescricaoCampo;
  LChanges.CodigoProduto   := AProduto;
  LChanges.ValorAnterior   := '';
  LChanges.ValorAtual      := ADadosAtual.FindField(ACampo.NomeCampo).AsString;

  If Length(ACampo.Valores) > 0 Then
  Begin
    LIndex := IndexStr(LChanges.ValorAtual, ACampo.Valores);

    If LIndex >= 0 Then
      LChanges.ValorAtual :=
        LChanges.ValorAtual + ' - ' + ACampo.DescricaoValores[LIndex];
  End;

  LChanges.Informacoes := AInformacao;

  SetLength(FChanges, Length(FChanges) + 1);
  FChanges[Length(FChanges) - 1] := LChanges;
end;

procedure TProLog.AddLogModificacoes(ACampo: TProLogCampo; ADadosOriginal,
  ADadosAtual: TZClient; AProduto, AInformacao: String);
Var
  LChanges: TProLogChanges;
  LIndex: Integer;
begin
  If ADadosOriginal.FindField(ACampo.NomeCampo) = nil Then
    Exit;

  If ADadosAtual.FindField(ACampo.NomeCampo) = nil Then
    Exit;

  If SameStr(Trim(ADadosOriginal.FindField(ACampo.NomeCampo).AsString),
             Trim(ADadosAtual.FindField(ACampo.NomeCampo).AsString)) Then
    Exit;

  LChanges.NomeTabela      := ACampo.NomeTabela;
  LChanges.DescricaoTabela := GetDescricaoTabela(ACampo.NomeTabela);
  LChanges.NomeCampo       := ACampo.NomeCampo;
  LChanges.DescricaoCampo  := ACampo.DescricaoCampo;
  LChanges.CodigoProduto   := AProduto;
  LChanges.ValorAnterior   := ADadosOriginal.FindField(ACampo.NomeCampo).AsString;
  LChanges.ValorAtual      := ADadosAtual.FindField(ACampo.NomeCampo).AsString;

  If Length(ACampo.Valores) > 0 Then
  Begin
    LIndex := IndexStr(LChanges.ValorAnterior, ACampo.Valores);

    If LIndex >= 0 Then
      LChanges.ValorAnterior :=
        LChanges.ValorAnterior + ' - ' + ACampo.DescricaoValores[LIndex];

    LIndex := IndexStr(LChanges.ValorAtual, ACampo.Valores);

    If LIndex >= 0 Then
      LChanges.ValorAtual :=
        LChanges.ValorAtual + ' - ' + ACampo.DescricaoValores[LIndex];
  End;

  LChanges.Informacoes := AInformacao;

  SetLength(FChanges, Length(FChanges) + 1);
  FChanges[Length(FChanges) - 1] := LChanges;
end;

constructor TProLog.Create(ACodPro: String);
begin
  FCodPro := ACodPro;
  FSeqGer := fCampoTabela('AUTOINCREM','CADPRO',['PRO_CODPRO'],[ACodPro]);
  FOpeLog := strLoginUsuarioLogado;
  IniciarObjetos;
end;

procedure TProLog.DefinirStatusPromocao(ACodPro: String);
begin
  FInserindoPromocao := False;
  FAlterandoPromocao := False;
  FExcluindoPromocao := False;

  FSeqGer := fCampoTabela('AUTOINCREM','CADPRO',['PRO_CODPRO'],[ACodPro]);

  If FSeqGer.IsEmpty Then
  Begin
    FExcluindoPromocao := True;
  End
  Else If ACodPro = FCodPro Then
  Begin
    FAlterandoPromocao := True;
  End
  Else
  Begin
    FInserindoPromocao := True;
  End;

  FCodPro := ACodPro;
end;

destructor TProLog.Destroy;
begin
  FinalizarObjetos;
  inherited;
end;

procedure TProLog.ExecutarLogPromocao(ACodPro: String; AProgress: TcxProgressBar = Nil);
begin
  DefinirStatusPromocao(ACodPro);
  ProcessarLogDadosPromocao;
  ProcessarLogProdutosPromocao;
  ProcessarLogEmpresasPromocao;
  ProcessarLogClientesPromocao;
  ProcessarLogCondicaoPagamentoPromocao;
  InserirRegistrosTabelaProLog(AProgress);
end;

procedure TProLog.FinalizarObjetos;
begin
  FreeAndNil(FCadPro);
  FreeAndNil(FItePro);
  FreeAndNil(FProEmp);
  FreeAndNil(FProCli);
  FreeAndNil(FCndPro);
end;

function TProLog.GetDescricaoTabela(ATabela: String): String;
begin
  Result := ATabela;

  If ATabela = 'CADPRO' Then
    Exit('Dados gerais da promoção');

  If ATabela = 'ITEPRO' Then
    Exit('Produtos da promoção');

  If ATabela = 'PROEMP' Then
    Exit('Empresa(s) da promoção');

  If ATabela = 'PROCLI' Then
    Exit('Cliente(s) da promoção');

  If ATabela = 'CNDPRO' Then
    Exit('Condições de pagamento da promoção');
end;

procedure TProLog.IniciarObjetos;
begin
  FCadPro := TZClient.Create(nil, Format(TProLogSQL.SQL_CADPRO, [FCodPro]));
  FItePro := TZClient.Create(nil, Format(TProLogSQL.SQL_ITEPRO, [FSeqGer]));
  FProEmp := TZClient.Create(nil, Format(TProLogSQL.SQL_PROEMP, [FSeqGer]));
  FProCli := TZClient.Create(nil, Format(TProLogSQL.SQL_PROCLI, [FSeqGer]));
  FCndPro := TZClient.Create(nil, Format(TProLogSQL.SQL_CNDPRO, [FSeqGer]));

  FCadPro.fAbreClient();
  FItePro.fAbreClient();
  FProEmp.fAbreClient();
  FProCli.fAbreClient();
  FCndPro.fAbreClient();
end;

procedure TProLog.InserirRegistrosTabelaProLog(AProgress: TcxProgressBar = Nil);
Var
  LIndex: Integer;
  LChanges: TProLogChanges;
  LInsert: String;
  LValues: String;
  LTime: TDateTime;
  LAutoincrem: String;
begin
  Application.ProcessMessages;

  Try
    LAutoincrem := fRetAutoIncrem('PROLOG', VS_strCodEmp, Length(FChanges));
    LTime := fTime();

    LInsert := '';
    LInsert := LInsert + ' INSERT INTO PROLOG ( ';
    LInsert := LInsert + '   AUTOINCREM, ';
    LInsert := LInsert + '   PRO_CODPRO, ';
    LInsert := LInsert + '   PRO_OPELOG, ';
    LInsert := LInsert + '   PRO_DTALOG, ';
    LInsert := LInsert + '   PRO_HORLOG, ';
    LInsert := LInsert + '   PRO_NOMTAB, ';
    LInsert := LInsert + '   PRO_DESTAB, ';
    LInsert := LInsert + '   PRO_NOMCAM, ';
    LInsert := LInsert + '   PRO_DESCAM, ';
    LInsert := LInsert + '   PRO_CODITE, ';
    LInsert := LInsert + '   PRO_VALANT, ';
    LInsert := LInsert + '   PRO_VALNOV, ';
    LInsert := LInsert + '   PRO_TIPLOG) VALUES ';

    LValues := '';

    If Assigned(AProgress) Then
    Begin
      AProgress.Properties.Max := High(FChanges);
      AProgress.Visible := True;
    End;

    For LIndex := Low(FChanges) To High(FChanges) Do
    Begin
      LChanges := FChanges[LIndex];

      If LValues <> '' Then
        LValues := LValues + ', ';

      LValues := LValues + '( ' + LAutoincrem.QuotedString;
      LValues := LValues + ', ' + FCodPro.QuotedString;
      LValues := LValues + ', ' + FOpeLog.QuotedString;
      LValues := LValues + ', ' + FormatDateTime('yyyy-MM-dd', VS_Date).QuotedString;
      LValues := LValues + ', ' + FormatDateTime('hh:mm:ss', LTime).QuotedString;
      LValues := LValues + ', ' + LChanges.NomeTabela.QuotedString;
      LValues := LValues + ', ' + LChanges.DescricaoTabela.QuotedString;
      LValues := LValues + ', ' + LChanges.NomeCampo.QuotedString;
      LValues := LValues + ', ' + LChanges.DescricaoCampo.QuotedString;

      If Not LChanges.CodigoProduto.IsEmpty Then
        LValues := LValues + ', ' + LChanges.CodigoProduto.QuotedString
      Else
        LValues := LValues + ', NULL';

      LValues := LValues + ', ' + LChanges.ValorAnterior.QuotedString;
      LValues := LValues + ', ' + LChanges.ValorAtual.QuotedString;
      LValues := LValues + ', ' + LChanges.Informacoes.QuotedString + ') ';

      LAutoincrem := fNextAutoIncrem(LAutoincrem);

      If ((LIndex > 0) And (LIndex Mod 100 = 0)) Or (LIndex = High(FChanges)) Then
      Begin
        If Not fExecutaSQL(LInsert + LValues) Then
          Raise Exception.Create('Não foi possível gravar a tabela PROLOG!');

        If Assigned(AProgress) Then
          AProgress.Position := LIndex;

        Application.ProcessMessages;
        LValues := '';
      End;

    End;

  Finally
    //do something
  End;
end;

class function TProLog.New(ACodPro: String): IProLog;
begin
  Result := Self.Create(ACodPro);
end;

procedure TProLog.ProcessarLogClientesPromocao;
begin
  ProcessarLogTabelasDetalhesPromocao('PROCLI', 'PRO_CODCLI', '', TProLogSQL.SQL_PROCLI, FProCli);
end;

procedure TProLog.ProcessarLogCondicaoPagamentoPromocao;
begin
  ProcessarLogTabelasDetalhesPromocao('CNDPRO', 'CPR_CODCND', '', TProLogSQL.SQL_CNDPRO, FCndPro);
end;

procedure TProLog.ProcessarLogDadosPromocao;
Var
  LCampo: TProLogCampo;
  LCadPro: TZClient;
begin
  Application.ProcessMessages;
  LCadPro := TZClient.Create(nil, Format(TProLogSQL.SQL_CADPRO, [FCodPro]));
  Try
    LCadPro.fAbreClient();
    For LCampo In FCampos Do
      If LCampo.NomeTabela = 'CADPRO' Then
        If FExcluindoPromocao Then
          AddLogExclusao(LCampo, FCadPro, '', 'Exclusão de promoção')
        Else If FAlterandoPromocao Then
          AddLogModificacoes(LCampo, FCadPro, LCadPro, '', 'Alteração de promoção')
        Else
          AddLogInclusao(LCampo, LCadPro, '', 'Inclusão de promoção');
  Finally
    FreeAndNil(LCadPro);
  End;
end;

procedure TProLog.ProcessarLogEmpresasPromocao;
begin
  ProcessarLogTabelasDetalhesPromocao('PROEMP', 'PRO_CODEMP', '', TProLogSQL.SQL_PROEMP, FProEmp);
end;

procedure TProLog.ProcessarLogProdutosPromocao;
begin
  ProcessarLogTabelasDetalhesPromocao('ITEPRO', 'IPR_CODITE', 'IPR_CODITE', TProLogSQL.SQL_ITEPRO, FItePro);
end;

procedure TProLog.ProcessarLogTabelasDetalhesPromocao(ATabela, ACampoBusca, ACampoProduto, ASQLTabela: String; ADadosAnterior: TZClient);
Var
  LCampo: TProLogCampo;
  LCodigoProduto: String;
  LDadosNovo: TZClient;
  LListNovo: TDictionary<String, Integer>;
  LListAnterior: TDictionary<String, Integer>;
begin
  Application.ProcessMessages;

  LDadosNovo := TZClient.Create(nil, Format(ASQLTabela, [FSeqGer]));

  LListNovo := TDictionary<String, Integer>.Create;
  LListAnterior := TDictionary<String, Integer>.Create;

  Try
    LDadosNovo.fAbreClient();

    LDadosNovo.IndexFieldNames := ACampoBusca;
    ADadosAnterior.IndexFieldNames := ACampoBusca;

    LDadosNovo.First;
    While Not LDadosNovo.Eof Do
    Begin
      LListNovo.AddOrSetValue(LDadosNovo.FieldByName(ACampoBusca).AsString, LDadosNovo.RecNo);
      LDadosNovo.Next;
    End;

    ADadosAnterior.First;
    While Not ADadosAnterior.Eof Do
    Begin
      LListAnterior.AddOrSetValue(ADadosAnterior.FieldByName(ACampoBusca).AsString, ADadosAnterior.RecNo);
      ADadosAnterior.Next;
    End;

    ADadosAnterior.First;
    While Not ADadosAnterior.Eof Do
    Begin
      LCodigoProduto := '';
      If Not fEmptyStr(ACampoProduto) Then
        LCodigoProduto := ADadosAnterior.FieldByName(ACampoProduto).AsString;

      If Not LListNovo.ContainsKey(ADadosAnterior.FieldByName(ACampoBusca).AsString) Then
      Begin
        For LCampo In FCampos Do
          If LCampo.NomeTabela = ATabela Then
            AddLogExclusao(LCampo, ADadosAnterior, LCodigoProduto,
              IfThen(FExcluindoPromocao, 'Exclusão de Promoção',
                'Exclusão de ' + GetDescricaoTabela(ATabela)));
      End
      Else
        For LCampo In FCampos Do
          If LCampo.NomeTabela = ATabela Then
          Begin
            LDadosNovo.RecNo := LListNovo[ADadosAnterior.FieldByName(ACampoBusca).AsString];
            AddLogModificacoes(LCampo, ADadosAnterior, LDadosNovo, LCodigoProduto,
              'Alteração de ' + GetDescricaoTabela(ATabela));
          End;

      ADadosAnterior.Next;
    End;

    LDadosNovo.First;
    While Not LDadosNovo.Eof Do
    Begin
      LCodigoProduto := '';
      If Not fEmptyStr(ACampoProduto) Then
        LCodigoProduto := LDadosNovo.FieldByName(ACampoProduto).AsString;

      If Not LListAnterior.ContainsKey(LDadosNovo.FieldByName(ACampoBusca).AsString) Then
        For LCampo In FCampos Do
          If LCampo.NomeTabela = ATabela Then
            AddLogInclusao(LCampo, LDadosNovo, LCodigoProduto,
              'Inclusão de ' + GetDescricaoTabela(ATabela));

      LDadosNovo.Next;
    End;
  Finally
    FreeAndNil(LDadosNovo);
    FreeAndNil(LListNovo);
    FreeAndNil(LListAnterior);
  End;
end;

function fCarregarParametrosProduto(ACodigoProduto : String; AUnidadeMedida: String = '') : TParametrosProduto;
Begin
  Result := TParametrosProduto.Create;
  Result.strCodigoProduto := ACodigoProduto;
  If fEmptyStr(AUnidadeMedida) Then
    Result.strUnidadeMedida := fCampoTabela('ITE_CODUNI', 'CADITE', ['ITE_CODITE'], [ACodigoProduto], False)
  Else
    Result.strUnidadeMedida := AUnidadeMedida;
End;

function fValidarCondicaoEPrazoDePagamentoNasPromocoes : Boolean;
Begin
  Result := (fCfgSis('PRZPRO', varBoolean) and fCfgSis('VCPPRO', varBoolean));
End;

function fGetUnitarioEmbalagemFechada(strCodItem, strTabelaPreco: String; fltQtdItem, fltUnitOriginal: Double; blnUtilizaVlrUnitarioAtual: Boolean = False): Double;
Var
  fltPercDesEmbFec : Double;
Begin

  fltPercDesEmbFec := fPercDescEmbalagemFechadaItem(strCodItem, strTabelaPreco, fltQtdItem, '');

  If (fCfgSis('TRPEMB') = '2') And (Not blnUtilizaVlrUnitarioAtual) Then
    Result := (fRetPrecoVenda(strCodItem, strTabelaPreco) * (1 - (    fltPercDesEmbFec / 100 ) ) )
  Else
    Result := ( fltUnitOriginal * ( 1 - (  fltPercDesEmbFec / 100 ) ) );

End;

function fItemPromocionalComPrecoFixoParaTintaDeMaquinaImobiliaria(const strCodIte, strCodPro : String) : Boolean;
  Var
    qryGenPro : TUniQuery;
begin
  qryGenPro := fCriaQuery;
  Try
    qryGenPro.Close;
    qryGenPro.SQL.Clear;
    qryGenPro.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryGenPro.SQL.Add('   FROM CADPRO ');
    qryGenPro.SQL.Add('   JOIN ITEPRO ON IPR_SEQGER = CADPRO.AUTOINCREM ');
    qryGenPro.SQL.Add('  WHERE PRO_CODPRO = :CODPRO ');
    qryGenPro.SQL.Add('    AND IPR_CODITE = :CODITE ');
    qryGenPro.SQL.Add('    AND IPR_PFTMIM = "S" ');
    qryGenPro.ParamByName('CODITE').AsString := strCodIte;
    qryGenPro.ParamByName('CODPRO').AsString := strCodPro;
    qryGenPro.Open;
    Result := (qryGenPro.FieldByName('CNT').AsInteger > 0);
  Finally
    FreeAndNil(qryGenPro);
  End;
end;

{ TGravaItePro }

procedure TGravaItePro.AddItem(strCodIte, strQtdLim, strQtdMin: String; fltPreCus,
  fltPreVen, fltPerDes: Double; intPrzMed: Integer; fltComVar, fltComAta, fltComDis, fltPreve2,
  fltPreve3, fltPreve4, fltPreve5, fltPreve6, fltPreve7, fltVlDsAd: Double; intTbDsAd: Integer;
  fltPerEst: Double; strSequencialKit: String; fltCliVen: Double; blnPrecoFixoTintaDeMaquinaImobiliaria : Boolean);
Var
  LItem: TItePro;
begin
  LItem.strCodIte := strCodIte;
  LItem.strQtdLim := strQtdLim;
  LItem.strQtdMin := strQtdMin;
  LItem.fltPreCus := fltPreCus;
  LItem.fltPreVen := fltPreVen;
  LItem.fltPerDes := fltPerDes;
  LItem.intPrzMed := intPrzMed;
  LItem.fltComVar := fltComVar;
  LItem.fltComAta := fltComAta;
  LItem.fltComDis := fltComDis;
  LItem.fltPreve2 := fltPreve2;
  LItem.fltPreve3 := fltPreve3;
  LItem.fltPreve4 := fltPreve4;
  LItem.fltPreve5 := fltPreve5;
  LItem.fltPreve6 := fltPreve6;
  LItem.fltPreve7 := fltPreve7;
  LItem.fltVlDsAd := fltVlDsAd;
  LItem.intTbDsAd := intTbDsAd;
  LItem.fltPerEst := fltPerEst;
  LItem.strSequencialKit := strSequencialKit;
  LItem.fltCliVen := fltCliVen;
  LItem.blnPrecoFixoTintaDeMaquinaImobiliaria := blnPrecoFixoTintaDeMaquinaImobiliaria;

  SetLength(FItens, Length(FItens) + 1);
  FItens[Length(FItens)-1] := LItem;
end;

constructor TGravaItePro.Create;
begin
  SetLength(FItens, 0);
  FExisteIPR_CODEMP := fCampoExiste('ITEPRO', 'IPR_CODEMP', True);
end;

destructor TGravaItePro.Destroy;
begin
  SetLength(FItens, 0);
  inherited;
end;

function TGravaItePro.Gravar(AProgress: TcxProgressBar = Nil; arrItens : TArrTipoMatrizItensPromo = Nil): Boolean;
Var
  LIndex: Integer;
  LItem: TItePro;
  LInsert: String;
  LValues: String;
  LAutoincrem: String;

  procedure pAtualizarLimCliSeqGer(ASeqNew : String);
    const
      UPD = 'UPDATE LIMCLI SET LIM_SEQGER = :SEQNEW WHERE LIM_SEQGER = :SEQOLD';
    var
      LItePro : TItensPromo;
      lQryUpd : TUniQuery;
  begin

    If (arrItens = Nil) Then
      Exit;

    For LItePro in arrItens Do
    Begin

      If LItePro.strcodIte.Equals(LItem.strCodIte) Then
      Begin

        lQryUpd := fCriaQuery;

        Try
          lQryUpd.Close;
          lQryUpd.SQL.Clear;
          lQryUpd.SQL.Add(UPD);
          lQryUpd.ParamByName('SEQNEW').AsString := ASeqNew;
          lQryUpd.ParamByName('SEQOLD').AsString := LItePro.strAutInc;
          lQryUpd.ExecSQL;
        Finally
          FreeAndNil(lQryUpd);
        End;

      End;

    End;

  end;

begin
  Result := True;

  Application.ProcessMessages;

  Try
    LAutoincrem := fRetAutoIncrem('ITEPRO', VS_strCodEmp, Length(FItens));

    LInsert := '';
    LInsert := LInsert + ' INSERT INTO ITEPRO ( ';
    LInsert := LInsert + '    IPR_SEQGER, ';
    LInsert := LInsert + '    IPR_CODITE, ';
    LInsert := LInsert + '    IPR_QTDLIM, ';
    LInsert := LInsert + '    IPR_QTDMIN, ';
    LInsert := LInsert + '    IPR_PRECUS, ';
    LInsert := LInsert + '    IPR_PREVEN, ';
    LInsert := LInsert + '    IPR_PERDES, ';
    LInsert := LInsert + '    IPR_PRZMED, ';
    LInsert := LInsert + '    IPR_COMVAR, ';
    LInsert := LInsert + '    IPR_COMATA, ';
    LInsert := LInsert + '    IPR_COMDIS, ';

    If FExisteIPR_CODEMP Then
      LInsert := LInsert + '    IPR_CODEMP, ';

    LInsert := LInsert + '    IPR_PREVE2, ';
    LInsert := LInsert + '    IPR_PREVE3, ';
    LInsert := LInsert + '    IPR_PREVE4, ';
    LInsert := LInsert + '    IPR_PREVE5, ';
    LInsert := LInsert + '    IPR_PREVE6, ';
    LInsert := LInsert + '    IPR_PREVE7, ';
    LInsert := LInsert + '    IPR_VLDSAD, ';
    LInsert := LInsert + '    IPR_TBDSAD, ';
    LInsert := LInsert + '    IPR_PEREST, ';
    LInsert := LInsert + '    IPR_SEQKIT, ';
    LInsert := LInsert + '    AUTOINCREM, ';
    LInsert := LInsert + '    IPR_PFTMIM, ';
    LInsert := LInsert + '    IPR_CLIVEN) VALUES ';

    LValues := '';

    If Assigned(AProgress) Then
      AProgress.Properties.Max := High(FItens);

    For LIndex := Low(FItens) To High(FItens) Do
    Begin
      LItem := FItens[LIndex];

      If LValues <> '' Then
        LValues := LValues + ', ';

      LValues := LValues + '( ' + FSeqGer.QuotedString;
      LValues := LValues + ', ' + LItem.strCodIte.QuotedString;

      LValues := LValues + ', ' + LItem.strQtdLim.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.strQtdMin.Replace('.', '').Replace(',', '.');

      LValues := LValues + ', ' + LItem.fltPreCus.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreVen.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPerDes.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.intPrzMed.ToString;
      LValues := LValues + ', ' + LItem.fltComVar.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltComAta.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltComDis.ToString.Replace('.', '').Replace(',', '.');

      If FExisteIPR_CODEMP Then
        LValues := LValues + ', ' + VS_strCodEmp.QuotedString;

      LValues := LValues + ', ' + LItem.fltPreve2.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreve3.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreve4.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreve5.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreve6.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltPreve7.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.fltVlDsAd.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.intTbDsAd.ToString;
      LValues := LValues + ', ' + LItem.fltPerEst.ToString.Replace('.', '').Replace(',', '.');
      LValues := LValues + ', ' + LItem.strSequencialKit.QuotedString;
      LValues := LValues + ', ' + LAutoincrem.QuotedString;
      If (LItem.blnPrecoFixoTintaDeMaquinaImobiliaria) Then
        LValues := LValues + ', "S"'
      Else
        LValues := LValues + ', "N"';
      LValues := LValues + ', ' + LItem.fltCliVen.ToString.Replace('.', '').Replace(',', '.') + ') ';

      pAtualizarLimCliSeqGer(LAutoincrem);
      LAutoincrem := fNextAutoIncrem(LAutoincrem);

      If ((LIndex > 0) And (LIndex Mod 100 = 0)) Or (LIndex = High(FItens)) Then
      Begin
        If Not fExecutaSQL(LInsert + LValues) Then
          Exit(False);

        If Assigned(AProgress) Then
          AProgress.Position := LIndex;

        Application.ProcessMessages;
        LValues := '';
      End;

    End;

  Finally
    //do something
  End;
end;

{$IFNDEF LINUX}
class procedure TCadPro.pCarregaEmpresa(clbEmpresa: TCheckListBox);
Var
  qryGen: TUniQuery;
  intContador : Integer;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    clbEmpresa.Items.Clear;
    Clear;
    Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP');
    Open;
    First;
    While Not Eof Do
    Begin
      clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
      Next;
    End;
    Close;
  End;

  {********************************}
  {* SELECIONA TODAS AS EMPRESAS  *}
  {*****************************LU*}
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
    clbEmpresa.Checked[intContador] := True;

  FreeAndNil(qryGen);
End;
{$ENDIF}

{$IFNDEF LINUX}
class procedure TCadPro.pHelpConsiderarComissao(const Sender: TObject);
begin
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(121, 6015, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
class procedure TCadPro.pHelpQuantidadeLimite;
begin
  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(123, 6022, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;
end;
{$ENDIF}

{ TPromocaoLimitePorClienteOuVenda }

constructor TPromocaoLimitePorClienteOuVenda.Create(ACodPro : String);
begin

  FqryAux := fCriaQuery;

  FCodPro := ACodPro;

  FTipPro := pulSemLimite;
  pSetTipPro;

  FNumDoc := '';
  FEspDoc := '';
  FEmpDoc := '';
  FCodCli := '';
  FCodIte := '';
  FQtdVen := 0.0;

end;

destructor TPromocaoLimitePorClienteOuVenda.Destroy;
begin
  inherited;
  If Assigned(FqryAux) Then
    FreeAndNil(FqryAux);
end;

function TPromocaoLimitePorClienteOuVenda.fExisteLancamentos: Boolean;
  const
    SQL = 'SELECT COUNT(*) AS TOT FROM LIMCLI WHERE LIM_NUMDOC = :NUMDOC AND LIM_ESPDOC = :ESPDOC AND LIM_CODEMP = :EMPDOC';
begin

  Result := False;

  If FNumDoc.IsEmpty Then
    Exit;

  If FEspDoc.IsEmpty Then
    Exit;

  If FEmpDoc.IsEmpty Then
    Exit;

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('NUMDOC').AsString := FNumDoc;
  FqryAux.ParamByName('ESPDOC').AsString := FEspDoc;
  FqryAux.ParamByName('EMPDOC').AsString := FEmpDoc;
  FqryAux.Open;

  Result := (Not FqryAux.IsEmpty) And (FqryAux.FieldByName('TOT').AsInteger > 0);

end;

function TPromocaoLimitePorClienteOuVenda.fExisteLancamentosItem(ASeqGer : String): Boolean;
  const
    SQL = 'SELECT            ' +
          '  COUNT(*) AS TOT ' +
          'FROM     ' +
          '  LIMCLI ' +
          'WHERE    ' +
          '  LIM_NUMDOC = :NUMDOC AND ' +
          '  LIM_ESPDOC = :ESPDOC AND ' +
          '  LIM_CODEMP = :EMPDOC AND ' +
          '  LIM_SEQGER = :SEQGER ';
begin

  Result := False;

  If FNumDoc.IsEmpty Then
    Exit;

  If FEspDoc.IsEmpty Then
    Exit;

  If FEmpDoc.IsEmpty Then
    Exit;

  If ASeqGer.IsEmpty Then
    Exit;

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('NUMDOC').AsString := FNumDoc;
  FqryAux.ParamByName('ESPDOC').AsString := FEspDoc;
  FqryAux.ParamByName('EMPDOC').AsString := FEmpDoc;
  FqryAux.ParamByName('SEQGER').AsString := ASeqGer;
  FqryAux.Open;

  Result := (Not FqryAux.IsEmpty) And (FqryAux.FieldByName('TOT').AsInteger > 0);

end;

function TPromocaoLimitePorClienteOuVenda.fRetAutIncItePro: String;
  const
    SQL = 'SELECT         ' +
          '  I.AUTOINCREM ' +
          'FROM           ' +
          '  CADPRO P     ' +
          '  INNER JOIN ITEPRO I ON (I.IPR_SEQGER = P.AUTOINCREM) ' +
          'WHERE                        ' +
          '  P.PRO_CODPRO = :CODPRO AND ' +
          '  I.IPR_CODITE = :CODITE';

begin

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('CODPRO').AsString := FCodPro;
  FqryAux.ParamByName('CODITE').AsString := FCodIte;
  FqryAux.Open;

  Result := IIF(Not FqryAux.IsEmpty, FqryAux.FieldByName('AUTOINCREM').AsString, '');

end;

function TPromocaoLimitePorClienteOuVenda.fRetQtdMaxima: Double;
  const
    SQL = 'SELECT         ' +
          '  IFNULL(I.IPR_CLIVEN, 0) AS MAX ' +
          'FROM           ' +
          '  CADPRO P     ' +
          '  INNER JOIN ITEPRO I ON (I.IPR_SEQGER = P.AUTOINCREM) ' +
          'WHERE                        ' +
          '  P.PRO_CODPRO = :CODPRO AND ' +
          '  I.IPR_CODITE = :CODITE';
begin

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('CODPRO').AsString := FCodPro;
  FqryAux.ParamByName('CODITE').AsString := FCodIte;
  FqryAux.Open;

  Result := IIF(Not FqryAux.IsEmpty, FqryAux.FieldByName('MAX').AsFloat, 0.0);

end;

function TPromocaoLimitePorClienteOuVenda.fRetQtdVendas: Double;
  var
    SQL,
    LSeqGer : String;
    LIgnoraPedido: Boolean;
begin

  If (FTipPro = pulLimitarPorVenda) Then
    Exit(0.0);

  LSeqGer := fRetAutIncItePro;
  LIgnoraPedido := (Not FNumDoc.IsEmpty) And (Not FEspDoc.IsEmpty) And (Not FEmpDoc.IsEmpty);

  SQL := '';
  SQL := SQL + 'SELECT SUM(QTDVEN) AS QTDVEN FROM ';
  SQL := SQL + '  (      ';
  SQL := SQL + '    SELECT IFNULL(LIM_QTDVEN, 0)       AS QTDVEN ';
  SQL := SQL + '       FROM LIMCLI ';
  SQL := SQL + '      WHERE LIM_SEQGER = :SEQGER ';
  SQL := SQL + '        AND LIM_CODCLI = :CODCLI ';

  If LIgnoraPedido Then
  Begin
    SQL := SQL + '   UNION ALL ';

    SQL := SQL + '   SELECT IFNULL(LIM_QTDVEN, 0) * -1 AS QTDVEN ';
    SQL := SQL + '     FROM LIMCLI ';
    SQL := SQL + '   WHERE LIM_SEQGER = :SEQGER ';
    SQL := SQL + '     AND LIM_CODCLI = :CODCLI ';
    SQL := SQL + '     AND LIM_NUMDOC = :NUMDOC ';
    SQL := SQL + '     AND LIM_ESPDOC = :ESPDOC ';
    SQL := SQL + '     AND LIM_CODEMP = :EMPDOC ';
  End;

  SQL := SQL + '  ) AS VW';

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('SEQGER').AsString := LSeqGer;
  FqryAux.ParamByName('CODCLI').AsString := FCodCli;
  If LIgnoraPedido Then
  Begin
    FqryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    FqryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    FqryAux.ParamByName('EMPDOC').AsString := FEmpDoc;
  End;
  FqryAux.Open;

  Result := IIF(Not FqryAux.IsEmpty, (FqryAux.FieldByName('QTDVEN').AsFloat), 0.0);

end;

procedure TPromocaoLimitePorClienteOuVenda.pDeletar;
  const
    SQL = 'DELETE FROM LIMCLI WHERE LIM_NUMDOC = :NUMDOC AND LIM_ESPDOC = :ESPDOC AND LIM_CODEMP = :EMPDOC';
begin

  If FNumDoc.IsEmpty Then
    Exit;

  If FEspDoc.IsEmpty Then
    Exit;

  If FEmpDoc.IsEmpty Then
    Exit;

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.ParamByName('NUMDOC').AsString := FNumDoc;
  FqryAux.ParamByName('ESPDOC').AsString := FEspDoc;
  FqryAux.ParamByName('EMPDOC').AsString := FEmpDoc;
  FqryAux.ExecSQL;

end;

procedure TPromocaoLimitePorClienteOuVenda.pGravar;
  const
    SQL = 'SELECT * FROM LIMCLI WHERE FALSE';

    DEL = 'DELETE FROM LIMCLI WHERE   ' +
          '  LIM_NUMDOC = :NUMDOC AND ' +
          '  LIM_ESPDOC = :ESPDOC AND ' +
          '  LIM_CODEMP = :EMPDOC AND ' +
          '  LIM_SEQGER = :SEQGER ';

  var
    LSeqGer : String;
begin

  If (FTipPro <> pulLimitarPorCliente) Then
    Exit;

  If (FQtdVen <= 0) Then
    Exit;

  LSeqGer := fRetAutIncItePro;

  If fExisteLancamentosItem(LSeqGer) Then
  Begin
    FqryAux.Close;
    FqryAux.SQL.Clear;
    FqryAux.SQL.Add(DEL);
    FqryAux.ParamByName('NUMDOC').AsString := FNumDoc;
    FqryAux.ParamByName('ESPDOC').AsString := FEspDoc;
    FqryAux.ParamByName('EMPDOC').AsString := FEmpDoc;
    FqryAux.ParamByName('SEQGER').AsString := LSeqGer;
    FqryAux.ExecSQL;
  End;

  FqryAux.Close;
  FqryAux.SQL.Clear;
  FqryAux.SQL.Add(SQL);
  FqryAux.Open;

  FqryAux.Append;
  FqryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LIMCLI', VS_strCodEmp);
  FqryAux.FieldByName('LIM_SEQGER').AsString := LSeqGer;
  FqryAux.FieldByName('LIM_NUMDOC').AsString := FNumDoc;
  FqryAux.FieldByName('LIM_ESPDOC').AsString := FEspDoc;
  FqryAux.FieldByName('LIM_CODEMP').AsString := FEmpDoc;
  FqryAux.FieldByName('LIM_CODCLI').AsString := FCodCli;
  FqryAux.FieldByName('LIM_QTDVEN').AsFloat  := FQtdVen;
  FqryAux.Post;

end;

procedure TPromocaoLimitePorClienteOuVenda.pSetCodCli(AValue: String);
begin
  FCodCli := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetCodIte(AValue: String);
begin
  FCodIte := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetEmpDoc(AValue : String);
begin
  FEmpDoc := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetEspDoc(AValue : String);
begin
  FEspDoc := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetNumDoc(AValue : String);
begin
  FNumDoc := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetQtdVen(AValue: Double);
begin
  FQtdVen := AValue;
end;

procedure TPromocaoLimitePorClienteOuVenda.pSetTipPro;
Begin
  If FCodPro.IsEmpty Then
    Exit;

  FqryAux.Close;
  FqryAux.SQL.Text := 'SELECT IFNULL(PRO_LIMCLI, "N") AS LIMCLI, IFNULL(PRO_LIMVEN, "N") AS LIMVEN FROM CADPRO WHERE PRO_UTILIM = "S" AND PRO_CODPRO = :CODPRO';
  FqryAux.ParamByName('CODPRO').AsString := FCodPro;
  FqryAux.Open;

  If (Not FqryAux.IsEmpty) Then
  Begin
    If (FqryAux.FieldByName('LIMCLI').AsString = 'S') Then
      FTipPro := pulLimitarPorCliente
    Else If (FqryAux.FieldByName('LIMVEN').AsString = 'S') Then
      FTipPro := pulLimitarPorVenda;
  End;

  FqryAux.Close;
End;

{ TPromocaoVlrMinTotalProdutos }

constructor TPromocaoVlrMinTotalProdutos.Create;
begin
  inherited;

  pLimpar;
  FDicTintasEmPromocao := TDicionario.Create;
end;

destructor TPromocaoVlrMinTotalProdutos.Destroy;
begin
  inherited;

  pLimpar;
  If Assigned(FDicTintasEmPromocao) Then
    FreeAndNil(FDicTintasEmPromocao);
end;

function TPromocaoVlrMinTotalProdutos.fAtivaPromocao(strCodPro, strCodigoItem,
  strCodigoUnidade: String): Boolean;
Var
  intCnt : Integer;
  fltVlrLim : Double;
  fltVlrTotIte: Double;
  blnApenasItensProm: Boolean;
  blnSomaTotalMin: Boolean;
  fltVlrIte: Double;
begin

  fltVlrLim := fGetVlrLimMin(strCodPro);
  fltVlrTotIte := 0;

  blnApenasItensProm := fCalculaTotalMinimoApenasItensPromocao(strCodPro);

  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If blnApenasItensProm Then
      blnSomaTotalMin := (FArrItemPro[intCnt].strCodPro = strCodPro)
    Else
      blnSomaTotalMin := True;

    If FOpcSys = tRegSysCaixa Then
      fltVlrIte := FArrItemPro[intCnt].fltVlrTotDig
    Else
      fltVlrIte := FArrItemPro[intCnt].fltVlrIte;

    If blnSomaTotalMin Then
      fltVlrTotIte := fltVlrTotIte + fltVlrIte;
  End;

  fltVlrTotIte := (fFormataFloat(fltVlrTotIte, fCfgSis('DECUNI', varInteger)));
  fltVlrLim := fFormataFloat(fltVlrLim, fCfgSis('DECUNI', varInteger));

  If (fltVlrLim > 0) Then
  Begin
    Result := (fltVlrTotIte > fltVlrLim);
  End
  Else
    Result := True;

end;

function TPromocaoVlrMinTotalProdutos.fCalculaTotalMinimoApenasItensPromocao(
  const strCodPro: String): Boolean;
begin
  If fEmptyStr(strCodPro) Then
    Exit(false);

  Result := fCampoTabela('IFNULL(PRO_TIPPVM, -1)', 'CADPRO', ['PRO_CODPRO'], [strCodPro], False) = '1';
end;

function TPromocaoVlrMinTotalProdutos.fCodIteExiste(strCodPro, strCodIte,
  strCodigoUnidade: String): Boolean;
Var
  intCnt : Integer;
begin
  Result := False;
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodIte = strCodIte) And
       (FArrItemPro[intCnt].strCodUnidade = strCodigoUnidade) Then
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TPromocaoVlrMinTotalProdutos.fCodItePossuiPromo(
  const strCodIte: String): Boolean;
Var
  intCnt : Integer;
begin
  Result := False;
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodIte = strCodIte) Then
    Begin
      Result := FArrItemPro[intCnt].blnTemPromo;
      Break;
    End;
  End;
end;

function TPromocaoVlrMinTotalProdutos.fGetArrItemPro: TArrRecItemPro;
begin
  Result := FArrItemPro
end;

function TPromocaoVlrMinTotalProdutos.fGetCodPro(strCodIte: String): String;
Var
  intCnt : Integer;
begin
  Result := '';
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodIte = strCodIte) And
       (Not fEmptyStr(FArrItemPro[intCnt].strCodPro)) Then
    Begin
      Result := FArrItemPro[intCnt].strCodPro;
      Break;
    End;
  End;
end;

function TPromocaoVlrMinTotalProdutos.fGetIndex(strCodIte, strCodUnidadeMedida: String;
      strRshTin: String; strCodPro: string = ''; blnLocTinta: Boolean = False): Integer;
Var
  intCnt : Integer;
  blnTinta: Boolean;
begin
  strRshTin := IIF(fEmptyStr(strRshTin), 'NOR', strRshTin);
  blnTinta := strRshTin <> 'NOR';

  Result := -1;
  For intCnt := Low(ArrItemPro) To High(ArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodIte     = strCodIte) And
       (FArrItemPro[intCnt].strCodUnidade = strCodUnidadeMedida)  Then
    Begin
      If (Not fEmptyStr(strCodPro)) And (ArrItemPro[intCnt].strCodPro <> strCodPro) Then
        Continue;

      If blnTinta or blnLocTinta Then
      Begin
        If (IfEmptyStr(FArrItemPro[intCnt].strRshTin, 'NOR') = strRshTin)  Then
        Begin
          Result := intCnt;
          Break;
        End;
      End
      Else
      Begin
        Result := intCnt;
        Break;
      End;

    End;
  End;
end;

function TPromocaoVlrMinTotalProdutos.fGetOpcSys: TRegiaoSistema;
begin
  Result := FOpcSys;
end;

function TPromocaoVlrMinTotalProdutos.fGetVlrIte(strCodIte: String): Double;
Var
  intCnt : Integer;
begin
  Result := 0;
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodIte = strCodIte) Then
      Result := Result + FArrItemPro[intCnt].fltVlrIte;
  End;
  Result := (fFormataFloat(Result, fCfgSis('DECUNI', varInteger)));
end;

function TPromocaoVlrMinTotalProdutos.fAddOrUpdateItem(strCodIte, strCodigoUnidade,
  strCodPro: String; strRshTin : String; fltVlrIte, fltVlrLim: Double;
  fltVlrTotDig: Double = 0; blnTemPromo: Boolean = False;
  fltQtdIte: Double = 0): Boolean;
Var
  intIndex : Integer;
  blnIncluir: Boolean;
begin
  Result := False;
  blnIncluir := True;

  Try
     strRshTin := IfEmptyStr(strRshTin, 'NOR');

     If (fCodIteExiste(strCodPro, strCodIte, strCodigoUnidade)) Then
     Begin
       intIndex := fGetIndex(strCodIte, strCodigoUnidade, strRshTin, strCodPro);

       If intIndex < 0 Then
         intIndex := fGetIndex(strCodIte, strCodigoUnidade, 'NOR', strCodPro, (strRshTin <> 'NOR'));

       If (intIndex >= 0) Then
       Begin
         blnIncluir := False;
         FArrItemPro[intIndex].strRshTin := strRshTin;
         FArrItemPro[intIndex].fltVlrIte := fltVlrIte;
         FArrItemPro[intIndex].fltQtdIte := fltQtdIte;

         If FOpcSys = tRegSysCaixa Then
         Begin
           If fltVlrTotDig > 0 Then
           Begin
             FArrItemPro[intIndex].fltVlrTotDig := fltVlrTotDig;
           End;
         End;
       End;

     End;

     If blnIncluir Then
     Begin
       SetLength(FArrItemPro, Length(FArrItemPro) + 1);
       intIndex := Length(FArrItemPro) -1;

       FArrItemPro[intIndex].strCodPro      := strCodPro;
       FArrItemPro[intIndex].strCodIte      := strCodIte;
       FArrItemPro[intIndex].fltVlrLim      := fltVlrLim;
       FArrItemPro[intIndex].strRshTin      := strRshTin;
       FArrItemPro[intIndex].strCodUnidade  := strCodigoUnidade;
       FArrItemPro[intIndex].fltVlrIte      := fltVlrIte;
       FArrItemPro[intIndex].fltVlrTotDig   := fltVlrIte;
       FArrItemPro[intIndex].blnTemPromo    := blnTemPromo;
       FArrItemPro[intIndex].fltQtdIte      := fltQtdIte;
     End;

     Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'');
    End;
  End;
end;

procedure TPromocaoVlrMinTotalProdutos.pAdicionarStatusPromocaoDaTinta(AstrRashTinta,
  AstrPromocao: String);
begin
  FDicTintasEmPromocao.Adicionar(AstrRashTinta, AstrPromocao);
end;

procedure TPromocaoVlrMinTotalProdutos.pDelItem(strCodIte, strCodUnidadeMedida, strRshTin: String);
Var
  cloneArrItemPro: Array Of TrecItemPro;
  intCnt: Integer;
  intIndex: Integer;
  strIteMat,
  strIdeDel: String;
begin
  intIndex := fGetIndex(strCodIte, strCodUnidadeMedida, strRshTin);

  If (intIndex <> -1) Then
  Begin
    strIdeDel := strCodIte + strCodUnidadeMedida + IfEmptyStr(strRshTin, 'NOR');

    for intCnt := Low(FArrItemPro) to High(FArrItemPro) do
    begin
      strIteMat := FArrItemPro[intCnt].strCodIte + FArrItemPro[intCnt].strCodUnidade + IfEmptyStr(ArrItemPro[intCnt].strRshTin, 'NOR');

      If (strIteMat <> strIdeDel) Then
      begin
        SetLength(cloneArrItemPro, Length(cloneArrItemPro) + 1);
        cloneArrItemPro[Length(cloneArrItemPro) -1] := FArrItemPro[intCnt];
      end;
    end;

    pLimpar;

    for intCnt := Low(cloneArrItemPro) to High(cloneArrItemPro) do
    begin
      SetLength(FArrItemPro, Length(ArrItemPro) + 1);
      ArrItemPro[Length(FArrItemPro)-1] := cloneArrItemPro[intCnt];
    end;
  End;
end;

procedure TPromocaoVlrMinTotalProdutos.pLimpar;
begin
  SetLength(FArrItemPro, 0);
end;

procedure TPromocaoVlrMinTotalProdutos.pSetOpcSys(const AOpcSys: TRegiaoSistema);
begin
  FOpcSys := AOpcSys;
end;

function TPromocaoVlrMinTotalProdutos.fGetVlrLimMin(strCodPro: String): Double;
Var
  intCnt : Integer;
begin
  Result := 0;
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].strCodPro = strCodPro) Then
    Begin
      Result := FArrItemPro[intCnt].fltVlrLim;
      Break;
    End;
  End;
end;

class function TPromocaoVlrMinTotalProdutos.fNew: IPromocaoVlrMinTotalProdutos;
begin
  Result := TPromocaoVlrMinTotalProdutos.Create();
end;

function TPromocaoVlrMinTotalProdutos.fPossuiItensPromocaoVlrMinimo: Boolean;
Var
  intCnt: Integer;
  intQtd: Integer;
begin
  intQtd := 0;
  For intCnt := Low(FArrItemPro) To High(FArrItemPro) Do
  Begin
    If (FArrItemPro[intCnt].blnTemPromo) Then
    Begin
      Inc(intQtd);
    End;
  End;

  Result := intQtd > 0;
end;

initialization
  TProQtdColetiva.pLimpar;
  TEventosCadPro.fncOpcDoc := nil;
  TItemPromo.FItensJaExibidosBanner := TStringList.Create;
  VS_ALITPR := '';

finalization
  TProQtdColetiva.pLimpar;
  FreeAndNil(TItemPromo.FItensJaExibidosBanner);
end.
