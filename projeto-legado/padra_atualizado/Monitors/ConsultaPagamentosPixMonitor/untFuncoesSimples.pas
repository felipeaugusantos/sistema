unit untFuncoesSimples;

interface

Uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Controls, Forms, Windows, PSAPI,
  Graphics, Messages, Dialogs, Buttons, StdCtrls, DBCtrls,
  Printers, Themes, Consts, Mask,
  untDBECgcCpf, untMskC_G_C_, untEditTipoCgcCpf,
  ExtCtrls, ComCtrls, EditFocus, MMSystem,
  DBLookupComboBoxFocus, ComboBoxFocus, MemoFocus, DBComboBoxFocus,
  DBMemoFocus, MaskEditFocus, DBEditFocus, Grids, Menus, Math,
  RLPreviewForm, RLReport, RLTypes, WinSock, ShellApi, WinSpool,
  UniClientDataSet, DBGridCitel, DBGrids, Registry, MadExcept,
  untFuncoesGenerica, madStackTrace, BitBtnLockedIncrem, CheckLst,
  cxProgressBar, UniDataSetProvider, System.Win.ComObj, ShlObj,
  Winapi.TlHelp32, frxClass, untCfgRepositorio, untImagemBase64,
{$ENDIF LINUX}
  Classes, Uni, SysUtils, StrUtils, IniFiles,
  DB, DBClient, untConstantes, UITypes,
  Aurelius.Types.Nullable,
  AnsiStrings,

  Variants, DateUtils, MaskUtils, Contnrs, TypInfo, untTypesSistema,
  IdSMTP,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdSocks, IdMessage,

  RegularExpressions,

  IdHashMessageDigest, IdHash,
  CRAccess, IdCoderMIME,
  Types, Xml.XMLDoc, Xml.XMLIntf,

  UniSQLMonitor, DASQLMonitor, DBAccess, CLRClasses, CRParser,
  MyParserUni, MyClassesUni, DAScript, UniScript,
  System.Generics.Collections,
  untInterfacedObjectNoCount,
  REST.Client, System.Zip;

type
  TAcaoTransacao = (opStart, opCommit, opRollback);

type
  TOcultarMensagemLiberacao = (omlMsgParaQuemEnvia, omlMsgParaQuemReceb);

{$IFNDEF LINUX}
type
  TTimerTransacao = Class(TTimer)
    private
      procedure pOnTimerTransacao(Sender: TObject);
    public
      constructor Create(AOwner: TComponent); override;
  end;
{$ENDIF}

type
  TDefaultPoolingOptions = class sealed
  public
    class var Pooling: Boolean;
    class var Validate: Boolean;
    class var MaxPoolSize: Integer;
    class var MinPoolSize: Integer;
    class var ConnectionLifetime: Integer;
  end;

type
  {***********************************}
  {* SUPER CLASSE AUXILIAR PARA      *}
  {* LIBERA«√O DE MEM”RIA AUTOM¡TICA *}
  {********************************AF*}
  TObjectVariant = Class(TObject)
      varValor: Variant;
    public
      Constructor Create(valor: Variant);
  end;

type
  TDicionario = class
    private
      lstChaves: TStringList;
      lstValores: TObjectList;
    protected
      function BuscaChave(strChave: String): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(strChave: String; Valor: Variant);
      procedure AdicionarObjeto(strChave: String; Valor: TObject);
      procedure Remove(strChave: String);
      procedure Limpar;
      procedure LimparObjetos;
      function Retorna(strChave: String): Variant;
      function RetornaObjeto(strChave: String): TObject;

      function Chaves: TStringList;

      property Items[Index: String]: Variant read Retorna write Adicionar; default;
  end;

type
  TDicResultadoQuerySimples = class
    private
      FResultados: TDicionario;
      class var Finstance: TDicResultadoQuerySimples;
      function GetKey(qry: TUniQuery): String;
      function GetResult(Index: TUniQuery): Variant;
      procedure SetResult(Index: TUniQuery; const Value: Variant);
      constructor Create;
    public
      Destructor Destroy; override;
      class function fGetInstance(): TDicResultadoQuerySimples;
      class procedure Limpar;
      class function fExecQuery(qryExec: TUniQuery): Variant;
  end;

  function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;

{$IFNDEF LINUX}
  procedure pConectarModulos;
  procedure pFinalizarModulos;
{$ENDIF}

  procedure pDefinirEmpresa;
  procedure pDefinirUsuario;
  procedure pIniciarVariaveis;

  function fExecutandoPeloPortal: Boolean;

  function GetParamValue(AParamID: String): String;
  function HasParam(AParamID: String): Boolean;

  function fExecutaSQL(strSQL: String; blnRaise: Boolean = False): Boolean;

	procedure pAbrirBanco(Database: TUniConnection);
	procedure pFecharBanco(Database: TUniConnection);
  function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
  function fConexaoAtiva(): Boolean;
  procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');
  function fGetConnectionID(objConexao: TUniConnection = Nil): String;
	function fStartTransaction(objConexao: TUniConnection = Nil):Boolean;
	function fRollBack(objConexao: TUniConnection = Nil):Boolean;
	function fCommit(objConexao: TUniConnection = Nil):Boolean;
  function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  function fTamCodLse: Integer;
  function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  function fRetDescricaoMatrizAliquotasIcms(strCodMat: String): String;


  function fStartTransacationAutoincrem(conexao: TUniConnection = nil): Boolean;
  function fCommitAutoincrem(conexao: TUniConnection = nil): Boolean;
  function fRollbackAutoincrem(conexao: TUniConnection = nil): Boolean;
  function fInTransactionAutoincrem(conexao: TUniConnection = nil): Boolean;
  function fRetConexaoAutoincrem: TUniConnection;
  procedure pConectaAutoincrem;
  procedure pDesconectaAutoincrem;
  function fNomeArquivoValido(const ATexto: string): string;
  procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);

  procedure pGravaLogTransacao(objConexao     : TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
  procedure pAtualizaLogTransacao(strStack    : String         = '';
                                  tmrCommit   : TDateTime      = 0;
                                  tmrRollback : TDateTime      = 0;
                                  objConexao  : TUniConnection = Nil);

 {$IFNDEF LINUX}
  function fCriarConexao: TUniConnection;
 {$ENDIF}

  function fRetSeqContaBanco(intQtdCod: Integer = 1): String;

  function fAtualizaProCod(const strNomeTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod: Integer = 1; LConn: TUniConnection = nil): String; overload;
  function fAtualizaProCod(const strNomeTabela: String; const intQtdCod: Integer = 1; LConn: TUniConnection = nil): String; overload;

  function __fRetAutoIncrem__(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
  function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnUsaTransacaoCorrente: Boolean = False; conexao: TUniConnection = nil): String;

  function fTabelaExiste(const strNomeTabela: String; const blnUsarCache : Boolean = False; Conexao: TUniConnection = Nil): Boolean;

  function fCampoTabelaFatgor(const ACampo, ANumDoc, AEspDoc, ACodEmp: String): String;

  function fCampoTabela(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;

  procedure pDestroiModulo(var NomeForm);

{$IFNDEF LINUX}
  procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);
  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
{$ENDIF}

  procedure pFreeAndNil(var frmForm);
  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
  procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');

  procedure FreeAndNilDatasets(var ADataset);

  function fUsaSat(strCodEmp : String = '') : Boolean;

 {$IFNDEF LINUX}
  function fArredondaABNT_NBR5891_77(fltValor: Double; intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
  function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
 {$ENDIF}

  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;

  function fRetornaStack: String;

  procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
  function fPergunta(strMensagem: String): Boolean;

  function fMensagem(strTitulo: String;
                     strTexto: String;
                     arrOpcoes: Array Of String;
                     intFocoBotao: Integer = 1;
                     blnSaiComEsc: Boolean = False;
                     intEstFon: Integer = 1;
                     intWidBut: Integer = 0;
                     blnAutosize: Boolean = False;
                     intSomarTop: Integer=0;
                     blnObrigaEsc: Boolean = False;
                     blnOcultPainelBtn: Boolean = False;
                     blnBtnSemImg : Boolean = False;
                     intHeightOpc: Integer = 0;
                     intFormWidth : Integer = 0;
                     intQtdLinha: Integer = -1): Integer;

  function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;

  function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = ''; segConex: TUniConnection = Nil) : Boolean;
  function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
  procedure pEncerrarAplicacaoPorInconsitenciaCodEmp(strCamCfg: String; blnTerminar: Boolean);
  function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                    dicCfgSis: TDictionary<string,string> = Nil): Variant;

  function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
  function fRetornaValCfgMarCam(strValCfgOri: String): String;
  function fExecutaValCfg(strSQL, strEmp: String): String;
  function fPermiteEmissaoEspecie(strEspecie: String): Boolean;
  function fRetDescOpcCliPro(Const opc : TOpcCliPro): String;
  function fRetDescricaoAjuIcm(Const strCodAjuIcm: String): String;
  function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
  function fRetNomProduto(Const strCodIte: String): String;
  function fRetNomFornecedor(strCodFor: String): String;
  function fRetNomPortador(Const strCodPor: String): String;
  function fRetNomeConta(strCodCta: String): String;
  function fRetNomAtividade(Const strCodAti: String): String;
  function fRetDescTipoCli(Const strCodTip: String): String;
  function fRetNomEvento(strCodEve: String): String; overload;
  function fRetDescAte(Const strCodAte: String): String;
  function fRetDescricaoFase(strCodFas: String): String;
  function fRetDescTipoOcorrencia(strCodToc: String): String;
  function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
  function fRetConPag(strCodCnd: String): String;
  function fRetDescDepartamento(strCodDep: String): String;
  function fRetDesAbfPis(strAbfPis: String): String;
  function fRetDesAbfCof(strAbfCof: String): String;
  function fRetNomProfissional(Const strCodPro: String; blnVerStatus: Boolean=False): String;
  function fRetNomeMarca(strCodigo: String): String;
  function fRetNomUnidade(strCodUni: String): String;
  function fRetDescOcorrencia(Const strCodOcorrencia: String): String;
  function fRetDesServico(strCodSer: String): String;
  function fRetNomeCartao(strCodCar: String): String;
  function fRetDadosPix(AAutoIncrem: String): String;
  function fRetNomLocFisica(Const strCodLoc: String; strCodEmp: String = ''; blnRefazConsulta: Boolean = False): String;
  function fCadEmp(strNomCampo: String): String; Overload;
  function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
  function fCadEmpresa(strNomCampo: String): String; Overload;
  function fCadEmpresa(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
  function fRetUFEmpresa(strCodEmp: String = ''): String;
  function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;

  procedure pAddDados(Var arrAdd : TArray<String>; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
 {$IFNDEF LINUX}
  procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
 {$ENDIF}

  function fRetornaWordWrap(strTexto: String; intColunas: Integer): TStringList;
  function fRetornaWordWrapText(strTexto: String; intColunas: Integer): String;

  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  function fTiraEnter(strTexto: String): String;
  function fTiraEspacos(strTexto: String): String;
  function fTrimAll(strTexto: String): String;

  function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
  function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;

  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;
  function fStrZero(Zeros:string;Quant:integer):String; overload;
  function fStrZero(Zeros:Integer;Quant:integer):String; overload;
  function fStrZero(Zeros:Int64; Quant:integer): String; overload;

  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  procedure pWaitWindow(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);

  function fRetOrigemLock(strNomeTabela: String): String;
  function fRetUserLock(strNomeTabela: String): String;

  function fRenovarHoraLock(strNomeTabela: String; strOrigem: String = ''): Boolean;

  function fLock_Unlock(strNomeTabela: String;
                        blnTrava: Boolean;
                        blnLoopTravamento: Boolean = True;
                        blnHourGlass: Boolean = FALSE;
                        strCon_Id: String = '';
                        blnMostraMsgTravamento: Boolean = True;
                        strOrigem: String = ''): Boolean;

  function GetMD5(const strTexto: string): string;

  function fGetEmpresaLogada(): string;
  function fGetUsuarioLogado(): string;

  procedure pTrimAppMemorySize;

  function fRetornaInformacaoUltimoErroForeignKey: String; overload;
  function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String; overload;
  function fRetornaInformacaoUltimoDeadlock: String;

  function fTabelaVazia(strNomeTabela: string; blnSempreLerBanco: Boolean = True): Boolean;
  function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;

  function fRetClientesFilial: String;

  function fRetNomeEmpresa(strCodEmp: String): String; overload;
  function fRetEmpresaFisica(conexao: TUniConnection = nil): String;
  function fRetNomeOperador(strCodOpe: String): String;
  function fRetNomTransportadora(strCodTra: String): String;

  function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
    blnGravar: Boolean = True; blnSoCriaTabela: Boolean = False;
    strMotDel: String = ''; strOpeDel: String = ''; blnTabAux: Boolean = False; strOpcDel: String=''): String;

  procedure pDestravarTodosLocksConexaoAtual(blnTestarOrigem: Boolean = False; conexao: TUniConnection = nil);

  function fRetornaNomeTabela(strString: String): String;
  function fGravaLogBco(strComand: String): Boolean;
  function fExtractBetweenTags(const Value, TagI, TagF: String): String;
  function fTabelaReplica(strNomTabela: String): Boolean;
  function fExtrairCodigoConfiguracao(ASQL: String): String;
  function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
  function fPermiteReplicarCfgSis(ASQL: String): Boolean;
  procedure pCarregaVariaveisControleLogRep(connection: TUniConnection);
  function fGravaLogRep(strComand, strTabela, strCarreg: String; connection: TUniConnection = nil): Boolean;
  function fGetIDTransacao(objConnection: TUniConnection) : UInt64;
  procedure pSetarVariaveisDeAmbienteTransacao(objConnection: TUniConnection);
  procedure pLimparVariaveisDeAmbienteTransacao(objConnection: TUniConnection);
  procedure pAfterStartTransaction(objConnection: TUniConnection);
  function fGravaUsuRep(connection: TUniConnection): Boolean;
  function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64; connection: TUniConnection): Boolean;
  function fPermiteReplicarLckAtc: Boolean;
  function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
  procedure pCarregaNre(ARefresh: Boolean = False);

  function fAjustaDataSistema: Boolean;

  function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;

  function fCurrentTime: String;
  function fCurrentDate: String; Overload;
  function fCurrentDate(Const Value: TDateTime): String; Overload;
  function fCurrentDateTime: String; Overload;
  function fCurrentDateTime(Const Value: TDateTime): String; Overload;
  function fNow: TDateTime;
  function fRetHoraServidor(AConnection: TUniConnection = nil): TTime;
  function fRetDataServidor: TDate;
  function fRetDtaHraServidor : TDateTime;

  function GetIPAddressAsString: String;

  function fRetDescFpg(Const strCodFpg: String): String;
  function fEhTabelaDeContabilidade(strTabela: string): boolean;
  procedure pGravaLogContabil(strSQL, strTabela: string);
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;

  function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;

  function fTamDocCadRec: Integer;

  function fRetCGCEmpresa(strCodEmp: String): String;
  function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
  function fRetNomCliente(Const strCodCli: String): String;
  function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
  function fRetEmpAcessoUsuario(strCodOpe: String): String;

  function fRetEmpresaOperador(strCodOpe: String): String;
  procedure pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
  function fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
  procedure pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
  function fRetNomBanco(Const strCodBco: String): String;

  function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
     AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;

  procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; conexao: TUniConnection = nil);

  function fRetornaDataHoraServidor : TDateTime;
  procedure pValidarProcodTabelaVERREC;
  procedure pVerificaProCod;
  procedure pValidaProCod(strNomeTabela: String; conexao: TUniConnection = nil);
  function fUsaDoisMonitores: Boolean;
  function fUsaLayoutNovo: Boolean;
  procedure pCentralizarForm(AForm: TForm);
  function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;

  function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
  function fValN(Variable: Nullable<String>): String; overload;
  function fValN(Variable: Nullable<Integer>): Integer; overload;
  function fValN(Variable: Nullable<Double>): Double; overload;

  function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;

  function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                       strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                       blnConsideraDomingo: Boolean = False): Boolean;

  function PegaTimeZoneServidor: Integer;

  function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;

  function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;

  function fPermiteMudancaModeloVendaForaEstabelecimento: Boolean;

  procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');

  function fTemTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): Boolean;
  function fLimpaTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): String;
  function fTime(const AForceTime: Boolean = False) : TDateTime;
  function fVerificaseEhPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  function fVerificaRegraCCOrigem(strNumDoc, strParcel, strEspDoc, strCodEmp, strCodCli: String): Boolean;

  function CarregaImagemBanco(ANomeComponente, ANomeForm: String): TBytesStream;
  function PermiteCarregarImagensDinamicamente: Boolean;

  function fExisteRegistroPREPTEDocumento(strDocAbs, strEspAbs, strEmpAbs: String; strCodIte: String = ''):Boolean;

const
  PREFIX_MERCADO_LIVRE = 'MLB_';
  PREFIX_MAGALU        = 'MGL_';
  PREFIX_SHOPEE        = 'SHP_';
  PREFIX_VIAVAREJO     = 'VRJ_';
  PREFIX_OLIST         = 'OLS_';
  STRING_MENSAGEM_OCULTA_INI_ENV = '<:';
  STRING_MENSAGEM_OCULTA_FIM_ENV = ':>';

  STRING_MENSAGEM_OCULTA_INI_REC = '®:';
  STRING_MENSAGEM_OCULTA_FIM_REC = ':®';

Var
{$IFNDEF LINUX}
  VS_objTraceViewer: ITraceViewer;
  blnTransferindoCodigo: Boolean;
  VS_strTabelaErro: string;
  VS_Date: TDateTime;
  VS_strCodEmp: String;
  strLoginUsuarioLogado: String;
	strDescriUsuarioLogado: String;
  VS_strUsaTmq: String;
  VS_TSPlus: Boolean;
  VS_blnExitMonitor : boolean;
  VS_strHabilitarCRM: Boolean;
  VS_strCliFil: String;
  VS_strTipExp: String;
  VS_strTxjCni: String;
  VS_EmailTiposErro: TStringList;
  VS_AutoatendimentoPagueFacil: Boolean;
  VS_intTamCadIte: Integer;
  VS_intTamCadLse: Integer;
  VS_strTabPrc: String;
  strEmpAcessoUsuarioLogado: String;
  VS_strUrlSms: String;
  VS_strUsrSms: String;
  VS_strSenSms: String;
  VS_strRemSms: String;
  VS_PathAutCom: String;
  VS_strRazSoc: String; //Razao social da empresa
{$ENDIF}

  VS_dicConfiguracoes: TDictionary<string,string>;

  VS_strLockMonitorStatus: String;
  VS_strLockMonitorReservaItem: String;
  VS_strLockMonitorAudit: String;
  VS_strLockMonitorEntregaFutura: String;
  VS_strLockMonitorContabil: String;
  VS_strLockMonitorEnviaRegFusion: String;
  VS_strLockMonitorRomaneioIntegFusion: String;

  VS_TimeZone: Integer;

  VS_Error_you_are_sending_too_many_mails_slow_down: Boolean;

  VS_blnDlgPri: Boolean;
  arrFilas    : TarrFilas; //Array Of TFilasImp;
  VS_intTamDocCadRec: Integer; // Vari·vel Global para armazernar tamanho do Documento da Tabela CADREC
  VS_ModeSSL: String;
  VS_VersaoTLSSSL: String;
  VS_SQL_TRACE_PRODUTO: string;
  VS_SQL_TRACE_DOC_NUMERO: string;
  VS_SQL_TRACE_DOC_ESPECIE: string;
  VS_SQL_TRACE_DOC_EMPRESA: string;
  arrProCod : TarrProCod;

 {$IFDEF LINUX}
  __VS_ICONEXAO_AUTOINCREM: IConnection;
  __VS_TAG_AUTOINCREM: NativeUInt;
 {$ENDIF}
  __VS_CONEXAO_AUTOINCREM: TUniConnection;

  VS_ModeloEmailNaoAutenticado: String;

  VS_ModelosAvisosEmailAtivado: TStringList;
  VS_ModelosAvisosSMSAtivado: TStringList;
  VS_ModelosAvisosWPPAtivado: TStringList;

  VS_objLogTrace: ILogTrace; //para compilar em versıes anteriores

implementation

uses
{$IFNDEF LINUX}
  untMensagem,
  untModulo,
  untModuloReplicacao,
  untGravaINNODBStatus,
  untWaitWindow,
  untTestabilidade,
  untGravandoObs,
{$ENDIF}
  untCFGBAN_Class,
  untCFGBAN_Dao,
  untSubjectClass,
  untSubjectIntf,
  untHorarioSistema;

{ TObjectVariant }

constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;

{ TTimerTransacao }
{$IFNDEF LINUX}
constructor TTimerTransacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.Interval := VS_TRANSACAO_LIMITE_SEGUNDOS * 1000;
  Self.OnTimer := pOnTimerTransacao;
end;

procedure TTimerTransacao.pOnTimerTransacao(Sender: TObject);
begin
  pAtualizaLogTransacao(fRetornaStack);
end;
{$ENDIF}

{ TDicionario }

procedure TDicionario.Adicionar(strChave: String; Valor: Variant);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(TObjectVariant.Create(Valor));
  End
  Else
    lstValores[intPos] := TObjectVariant.Create(Valor);
end;

procedure TDicionario.AdicionarObjeto(strChave: String; Valor: TObject);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(Valor);
  End
  Else
  Begin
    lstValores[intPos] := Valor;
  End;
end;

function TDicionario.BuscaChave(strChave: String): Integer;
  Var
    intContador: Integer;
begin

  Result := -1;

  For intContador := 0 To lstChaves.Count -1 Do
  Begin
    If (lstChaves[intContador] = strChave) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

constructor TDicionario.Create;
begin
  inherited Create;

  lstChaves  := TStringList.Create;
  lstValores := TObjectList.Create(False);
end;

destructor TDicionario.Destroy;
begin
  Limpar;

  FreeAndNil(lstChaves);
  FreeAndNil(lstValores);

  inherited;
end;

procedure TDicionario.Limpar;
  Var
    intCont: Integer;
    obj: TObject;
begin
  For intCont := 0 To lstValores.Count -1 Do
  Begin
    If Assigned(lstValores[intCont]) And
      (lstValores[intCont] Is TObjectVariant) Then
    Begin
      obj := lstValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  lstChaves.Clear;
  lstValores.Clear;
end;

procedure TDicionario.LimparObjetos;
  Var
    intObj: Integer;
begin
  For intObj := 0 To lstChaves.Count -1 Do
  Begin
    If Assigned(RetornaObjeto(lstChaves[intObj])) Then
      TObject(RetornaObjeto(lstChaves[intObj])).Destroy;
    lstValores[intObj] := nil;
  End;
end;

procedure TDicionario.Remove(strChave: String);
  Var
    intPos: Integer;
begin

  intPos := BuscaChave(strChave);
  If (intPos > -1) Then
  Begin
    lstChaves.Delete(intPos);
    lstValores.Delete(intPos);
  End;

end;

function TDicionario.Retorna(strChave: String): Variant;
  Var
    intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
    Result := TObjectVariant(lstValores[intPos]).varValor;
end;

function TDicionario.RetornaObjeto(strChave: String): TObject;
  Var
    intPos: Integer;
begin

  Result := Nil;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
  Begin
    Result := lstValores[intPos];
  End;
end;

function TDicionario.Chaves: TStringList;
begin
  Result := lstChaves;
end;

{ TDicResultadoQuerySimples }

constructor TDicResultadoQuerySimples.Create;
begin
  FResultados := TDicionario.Create;
end;

destructor TDicResultadoQuerySimples.Destroy;
begin
  FreeAndNil(FResultados);
  inherited;
end;

class function TDicResultadoQuerySimples.fExecQuery(qryExec: TUniQuery): Variant;
Var
  objDic: TDicResultadoQuerySimples;
begin
  objDic := fGetInstance();

  If objDic.FResultados.Chaves.IndexOf(objDic.GetKey(qryExec)) > -1 Then
  Begin
    Result := objDic.GetResult(qryExec);
  End
  Else
  Begin
    With qryExec Do
    Begin
      Open;
      Result := Fields[0].Value;

      Case Fields[0].DataType Of
        ftString : Result := Fields[0].AsString;
        ftMemo   : Result := Fields[0].AsString;
        ftFloat  : Result := Fields[0].AsFloat;
        ftInteger: Result := Fields[0].AsInteger;
        ftBoolean: Result := Fields[0].AsBoolean;
        ftDate   : Result := Fields[0].AsDateTime;
        ftTime   : Result := Fields[0].AsDateTime;
      End;

      objDic.SetResult(qryExec, Result);
      Close;
    End;
  End;
end;

class function TDicResultadoQuerySimples.fGetInstance: TDicResultadoQuerySimples;
begin
  if Not Assigned(Finstance) Then
    Finstance := TDicResultadoQuerySimples.Create();

  Result := Finstance;
end;

function TDicResultadoQuerySimples.GetKey(qry: TUniQuery): String;
  Var
    i: Integer;
begin
  Result := qry.SQL.Text;
  For i := 0 To qry.ParamCount -1 Do
    Result := AnsiReplaceStr(Result, ':' + qry.Params[i].Name, qry.Params[i].AsString);
  Result := GetMD5(Result);
end;

function TDicResultadoQuerySimples.GetResult(Index: TUniQuery): Variant;
begin
  Result := FResultados[GetKey(Index)];
end;

class procedure TDicResultadoQuerySimples.Limpar;
begin
  fGetInstance().FResultados.Limpar;
end;

procedure TDicResultadoQuerySimples.SetResult(Index: TUniQuery; const Value: Variant);
begin
  FResultados[GetKey(Index)] := Value;
end;

function GetMD5(const strTexto: string): string;
var
  idHash128: TIdHashMessageDigest5;
begin
  Try
    Try
      idHash128 := TIdHashMessageDigest5.Create;
      Result := idHash128.HashStringAsHex(strTexto);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(idHash128) then FreeAndNil(idHash128);
  End;
end;

function GetIPAddress: Integer;
{$IFDEF LINUX}
begin
  Result := 0;
end;
{$ELSE}
var
  Buffer: array[0..255] of AnsiChar;
  RemoteHost: PHostEnt;
begin
  Winsock.GetHostName(@Buffer, 255);
  RemoteHost := Winsock.GetHostByName(Buffer);
  if RemoteHost = nil then
    Result := winsock.htonl($07000001) { 127.0.0.1 }
  else
    Result := longint(pointer(RemoteHost^.h_addr_list^)^);
  Result := Winsock.ntohl(Result);
end;
{$ENDIF}

function GetIPAddressAsString: String;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetIPAddressAsString.Trim;
end;
{$ELSE}
var
  tempAddress: Integer;
  Buffer: array[0..3] of Byte absolute tempAddress;
  data: WSAData;
begin
  WSAStartup(2, data);
  tempAddress := GetIPAddress;
  Result := Format('%d.%d.%d.%d', [Buffer[3], Buffer[2], Buffer[1], Buffer[0]]);
  WSACleanup;
end;
{$ENDIF}

function GetComputerNetName: string;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetComputerNetName.Trim;
end;
{$ELSE}
var
  buffer: array[0..255] of char;
  size: dword;
begin
  size := 256;
  if GetComputerName(buffer, size) then
    Result := buffer
  else
    Result := ''
end;
{$ENDIF}

function GetUserFromWindows: string;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetComputerUser.Trim;
end;
{$ELSE}
Var
   UserName : string;
   UserNameLen : Dword;
Begin
   UserNameLen := 255;
   SetLength(userName, UserNameLen) ;
   If GetUserName(PChar(UserName), UserNameLen) Then
     Result := Copy(UserName,1,UserNameLen - 1)
   Else
     Result := 'Unknown';
End;
{$ENDIF}

function GetMacAddress: String;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.GetMacAddress.Trim;
end;
{$ELSE}
var
  Librpcrt4: Cardinal;
  GUID1, GUID2: TGUID;
  Func: Function(GUID: PGUID): Longint; stdcall;
Begin
  Result := '';
  Librpcrt4 := LoadLibrary('rpcrt4.dll');
  If not (Librpcrt4 = 0) Then
  Try
     @Func := GetProcAddress(Librpcrt4, 'UuidCreateSequential');
     If Assigned(Func) Then
     Begin
       If (Func(@GUID1) = 0) and
          (Func(@GUID2) = 0) and
          (GUID1.D4[2] = GUID2.D4[2]) and
          (GUID1.D4[3] = GUID2.D4[3]) and
          (GUID1.D4[4] = GUID2.D4[4]) and
          (GUID1.D4[5] = GUID2.D4[5]) and
          (GUID1.D4[6] = GUID2.D4[6]) and
          (GUID1.D4[7] = GUID2.D4[7]) Then
       Begin
         Result :=
           IntToHex(GUID1.D4[2], 2) + '-' +
           IntToHex(GUID1.D4[3], 2) + '-' +
           IntToHex(GUID1.D4[4], 2) + '-' +
           IntToHex(GUID1.D4[5], 2) + '-' +
           IntToHex(GUID1.D4[6], 2) + '-' +
           IntToHex(GUID1.D4[7], 2);
       end;
     end;
  Finally
    FreeLibrary(Librpcrt4);
  end;
end;
{$ENDIF}

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA (S)TRTOFLOAT EM UM     *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
Begin
  Result := strToFloatDef(AnsiReplaceStr(strValorUnico,'.',''),fltDefault);
End;

{**********************************}
{* INSERE ESPACO APOS UMA STRING  *}
{*******************************DV*}
function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
Var
	I:integer;
Begin
  Case intPos Of
  	1:For I := Length(Str) To Tamanho -1 Do
		  	Str:= Str + ' ';
    2:For I := Length(Str) To Tamanho -1 Do
    		Str := ' ' + Str;
  End;
  fStrEspaco := Str;
End;

{*****************************}
{* CRIPTA UMA STRING         *}
{**************************DV*}
const
  STR_CHAR_SENHA = 'ABCDEFGHIJKLMNOPQRSTUVWYXZ 1234567890/:_*#';
  STR_CHAR_TROCA = 'ëíõúùû®≠‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒ˛Ú˜¸Ù¯˝ˆ˘˙˚Å≈¿£#';

function fCrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
	Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1), STR_CHAR_SENHA);
    Result := Result + MidStr(STR_CHAR_TROCA,intCl1,1);
  End;
end;

{*****************************}
{* DESCRIPTA UMA STRING      *}
{**************************DV*}
function fDecrypt(strSenha: String): String;
	Var
  	intCol,intCl1 : Integer;
begin
  Result := '';
  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha,Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha,intCol,1),STR_CHAR_TROCA);
    Result := Result + MidStr(STR_CHAR_SENHA, intCl1,1);
  End;
end;

{***********************************************}
{* RETORNA O VALOR DE UM DETERMINADO CAMPO     *}
{* DE UMA TABELA PASSANDO COMO PARAMETROS      *}
{* OS CAMPOS CHAVES E SEUS VALORES (WHERE)     *}
{* PODE SER UTIL PARA RETORNAR DESDE DESCRICAO *}
{* ATE VALORES, DATAS ENTRE OUTROS             *}
{********************************************JC*}
function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      blnSempreLerBanco: Boolean = True;
                      strOrderBy: String = '';
                      Conexao: TUniConnection = Nil;
                      blnUsarMax: Boolean = False): Variant;
  Const
    arrParms : Array [0..11] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L');

  Var
    intCont  : Integer;
    strSQL   : String;
    qryGenGer: TUniQuery;
Begin
  Try
    qryGenGer := fCriaQuery(nil, Conexao);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    if blnUsarMax then
    begin
      strSQL := strSQL + '  MAX(' + strCampo + ') ';
    end
    else
    begin
      strSQL := strSQL + '  ' + strCampo + ' ';
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ' + strNomTab + ' ';
    strSQL := strSQL + 'WHERE ';

    For intCont := 0 To Length(arrCampoChave) -1 Do
    Begin
      If Pos('<>', arrCampoChave[intCont]) > 0 Then
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' :' + String(arrParms[intCont]) + ' AND '
      Else
        strSQL := strSQL + '  ' + arrCampoChave[intCont] + ' = :' + String(arrParms[intCont]) + ' AND ';
    End;

    strSQL := strSQL + '  TRUE  ';

    If Not fEmptyStr(strOrderBy) Then
      strSQL := strSQL + ' ORDER BY ' + strOrderBy;

    strSQL := strSQL + ' LIMIT 1 ';

    With qryGenGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      For intCont := 0 To Length(arrCampoChave) -1 Do
        ParamByName(String(arrParms[intCont])).Value := arrValorChave[intCont];


      If (Not blnSempreLerBanco) Then
      Begin
        Result := TDicResultadoQuerySimples.fExecQuery(qryGenGer);
      End
      Else
      Begin
        Open;

        Result := Fields[0].Value;

        {*******************************************}
        {* EXECUTA UM CAST PARA NAO RETORNAR NULL  *}
        {****************************************JC*}
        Case Fields[0].DataType Of
          ftString : Result := Fields[0].AsString;
          ftMemo   : Result := Fields[0].AsString;
          ftFloat  : Result := Fields[0].AsFloat;
          ftInteger: Result := Fields[0].AsInteger;
          ftBoolean: Result := Fields[0].AsBoolean;
          ftDate   : Result := Fields[0].AsDateTime;
          ftTime   : Result := Fields[0].AsDateTime;
        End;
      End;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'fCampoTabela');
    End;
  End;

  FreeAndNil(qryGenGer);

End;

function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;
begin


  Result := '';

  If fEmptyStr(strCodEmp) Then
    Exit;

  Result := fCampoTabela('EMP_CODMAT', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False);

end;

function fCampoTabelaFatgor(const ACampo, ANumDoc, AEspDoc, ACodEmp: String): String;
begin
  Result := fCampoTabela(ACampo, 'FATGOR', ['FGO_NUMDOC', 'FGO_ESPDOC', 'FGO_CODEMP'], [ANumDoc, AEspDoc, ACodEmp]);
end;

function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = ''; segConex: TUniConnection = Nil) : Boolean;
  Var
    qryGenCfg: TUniQuery;

begin
  Try
    Result := True;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    If Not fEmptyStr(strCamCfg) Then
    Begin
      qryGenCfg := fCriaQuery(Nil, segConex);

      With qryGenCfg Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE                     ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('SET                        ');
        SQL.Add('  SIS_VALCFG = :VALCFG     ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');

        Try
          ParamByName('CODEMP').Value := strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
          ParamByName('VALCFG').Value := strValCfg;

          ExecSQL;
        Except
          On E: Exception Do
          Begin
            Raise Exception.Create('N„o consegui atualizar o proximo sequencial de ' + strCamCfg + ' em CFGSIS. Tente novamente!');
          End;
        End;

      End;

    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

end;

function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
Begin
  If SameText('EMPMAT', strCamCfg) Then
  Begin
    Result := '';

    If fCfgSisL('INFMAT', varBoolean) Then
      Result := fRetEmpresaMatrizDoGrupo(VS_strCodEmp);

    If fEmptyStr(Result) Then
      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, VS_dicConfiguracoes);

  End

  Else If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7-CFG_VENMAR') > 0 Then
  Begin

    If fCfgSisL('BLOPRE', varBoolean, strCodEmp, VS_dicConfiguracoes) Then
    begin

      If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7') > 0 Then
        Result := 'M'
      Else
        Result := 2;

    End Else
    Begin

      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, VS_dicConfiguracoes);

    End;

  End Else
  Begin
    Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, VS_dicConfiguracoes);

    If SameText('CORZEB', strCamCfg) And fEmptyStr(Result) Then
      Result := clWhite;
  End;
End;

function fRetPathSeImagemValida(strPathImg: String): String;
{$IFDEF LINUX}
begin
  Result := strPathImg;
end;
{$ELSE}
  Var
   Img: TImage;
begin
  Result := strPathImg;

  If (Not fEmptyStr(Result)) And (FileExists(Result)) Then
  Begin
    Try
      Img := TImage.Create(Nil);
      Try
        Img.Picture.LoadFromFile(strPathImg);
      Finally
        FreeAndNil(Img);
      End;
    Except
      Result := '';
    End;
  End;
end;
{$ENDIF}

procedure pEncerrarAplicacaoPorInconsitenciaCodEmp(strCamCfg: String; blnTerminar: Boolean);
  Var
    intParam: Integer;
    strParam: String;
    strConnID : String;
    strVersionTitle : String;
    objConnection : TUniConnection;
begin
  strParam := '';

  If ParamCount > 0 Then
  Begin
    For intParam := 0 To ParamCount Do
      strParam := strParam + ' ' + ParamStr(intParam);
  End;

{$IFNDEF LINUX}
  If blnTerminar Then
  Begin
    fRollBack;
    fMensagem('AtenÁ„o','Uma rotina est· sendo executada sem a definiÁ„o da empresa!' + #13 +
                        'Por favor entre em contato imediatamente com a Citel para devidas correÁıes! A aplicaÁ„o ser· encerrada!', ['&Ok']);
  End;
{$ENDIF LINUX}

  strConnID := VS_LastConnID;
  If fEmptyStr(strConnID) Then
  Begin
    Try
      objConnection := Nil;
     {$IFDEF LINUX}
      If Assigned(objConnectionsManager) Then
        objConnection := objConnectionsManager.CurrentConnection.GetObject as TUniConnection;
     {$ELSE}
      If Assigned(frmModulo) Then
        objConnection := frmModulo.GetCurrentConnection;
     {$ENDIF}
      If Assigned(objConnection) And (objConnection.Connected) Then
        strConnID := fGetConnectionID(objConnection);
    Except
      strConnID := '';
    End;
  End;

  strVersionTitle := 'ConsultaPagamentosPixMonitor';
 {$IFNDEF LINUX}
  If Assigned(frmModulo) And (Not fEmptyStr(frmModulo.VersionTitle)) Then
    strVersionTitle := frmModulo.VersionTitle;
 {$ENDIF}

  pGravarErro(True, '<CFGSIS_CODEMP_VAZIO>', 'ConfiguraÁ„o.: ' + 'CFG_' + strCamCfg + sLineBreak +
                                             'Par‚metros...: ' + strParam + sLineBreak +
                                             'Connection Id: ' + strConnID + sLineBreak +
                                             'Version Title: ' + strVersionTitle + sLineBreak +
                                             'Rotina.......: ' + #13 + fRetornaStack);

{$IFNDEF LINUX}
  If blnTerminar Then
  Begin
    If (Not TerminateProcess(GetCurrentProcess, 0)) Then
      Application.Terminate;
  End;
{$ENDIF LINUX}
end;

function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                  dicCfgSis: TDictionary<string,string> = Nil): Variant;
  Var
    qryGenCfg: TUniQuery;
    strValCfg: String;
    strSQL   : String;
    strRes   : String;
    strAux   : String;
begin
  Try
    qryGenCfg := Nil;

    If Not fEmptyStr(strCamCfg) Then
    Begin
      If fEmptyStr(strCodEmp) Then
        strCodEmp := VS_strCodEmp;

      If (Not Assigned(dicCfgSis)) Or (not dicCfgSis.ContainsKey(strCamCfg + strCodEmp)) Then
      Begin
        If fEmptyStr(strCodEmp) Then
        Begin
          Try
            pEncerrarAplicacaoPorInconsitenciaCodEmp(strCamCfg, False);
          Except
            //
          End;
        End;

        qryGenCfg := fCriaQuery;

        strSQL := '';
        strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
        strSQL := strSQL + '   SIS_CODCFG,              ';
        strSQL := strSQL + '   SIS_VALCFG              ';
        strSQL := strSQL + ' FROM                       ';
        strSQL := strSQL + '   CFGSIS                   ';
        strSQL := strSQL + ' WHERE                      ';
        strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

        With qryGenCfg Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          ParamByName('CODEMP').Value := strCodEmp;
          ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
          Open;

          If IsEmpty Then
            If (not fCriarConfiguracoes('CFG_' + strCamCfg, strCodEmp)) Then
              Raise Exception.Create('A configuraÁ„o ( ' + 'CFG_' + strCamCfg + ' ) n„o existe na empresa ' + strCodEmp + '.');

          If IsEmpty Then
          Begin
            Close;
            Open;
          End;

          {**********************************************************}
          {* VALIDA«√O PARA TESTAR SE J¡ … UMA CHAVE CRIPTROGRAFADA *}
          {********************************************************VA}
          strRes := FieldByName('SIS_VALCFG').AsString;
          If Pos(FieldByName('SIS_CODCFG').AsString, consChavesCript) > 0 Then
          Begin
            strAux:= fDecrypt(strRes);
            If fCrypt(strAux) = strRes Then
              strRes := fDecrypt(strRes)
          End
          Else If Pos(FieldByName('SIS_CODCFG').AsString, consCFGSQueValidaIMG) > 0 Then
          Begin
            strRes := fRetPathSeImagemValida(strRes);
          End;

          If Assigned(dicCfgSis) Then
            dicCfgSis.AddOrSetValue(strCamCfg + strCodEmp, strRes);
        End;
      End;

      If Assigned(dicCfgSis) Then
        strValCfg := dicCfgSis[strCamCfg + strCodEmp]
      Else
        strValCfg := strRes;

      Case varTipVar Of
        varString : Result := strValCfg;

        varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := strToInt(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varDouble, varCurrency:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0.00
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(strValCfg, '.', ','));
                      Except
                        Result := 0.00;
                      End;
                    End;

        varDate:
                    Begin
                      Try
                        If fEmptyStr(strValCfg) Then
                          Result := 0
                        Else
                          Result := strToDate(strValCfg);
                      Except
                        Result := 0;
                      End;
                    End;

        varBoolean:
                   Begin
                     Try
                       If fEmptyStr(strValCfg) Then
                         Result := False
                       Else If Pos(strValCfg, 'S_N_') > 0 Then
                         Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

                       Else If Pos(strValCfg, '0_1_') > 0  Then
                         Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
                       Else
                         Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

                     Except
                       Result := False;
                     End;

                   End;

        Else
          Result := strValCfg;

      End;

    End;

  Finally
    If Assigned(qryGenCfg) Then
      FreeAndNil(qryGenCfg);
  End;

end;

function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
{$IFDEF LINUX}
begin
  Result := True;
end;
{$ELSE}
Var
  intContador  : Integer;
  qryConfig    : TUniQuery;
  qryAux       : TUniQuery;
  strCodCfg    : String;
  strDescri    : String;
  strValCfg    : String;
  strGruCfg    : String;
  intNumHlp    : Integer;
  strValCfgGra : String;
begin

  Result := False;

  Try

    qryConfig := fCriaQuery(Nil);

    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Add('INSERT INTO CFGSIS ( ') ;
    qryAux.SQL.Add('  SIS_CODEMP, ');
    qryAux.SQL.Add('  SIS_CODCFG, ');
    qryAux.SQL.Add('  SIS_DESCRI, ');
    qryAux.SQL.Add('  SIS_VALCFG, ');
    qryAux.SQL.Add('  SIS_NUMHLP, ');
    qryAux.SQL.Add('  SIS_GRUCFG) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :CODCFG, ');
    qryAux.SQL.Add('  :DESCRI, ');
    qryAux.SQL.Add('  :VALCFG, ');
    qryAux.SQL.Add('  :NUMHLP, ');
    qryAux.SQL.Add('  :GRUCFG) ');

    If (not Assigned(arrCamposCfg)) Then
      TfrmCfgRepositorio.pMontaArrConfiguracoes();

    For intContador := 0 To Length(arrCamposCfg) - 1 Do
    Begin

      strCodCfg := arrCamposCfg[intContador].strCodCfg;

      If (SameText(strCamCfg, strCodCfg)) Then
      Begin

        strDescri := arrCamposCfg[intContador].strDescri;
        strValCfg := arrCamposCfg[intContador].strValCfg;
        strGruCfg := arrCamposCfg[intContador].strGruCfg;
        intNumHlp := arrCamposCfg[intContador].intNumHlp;

        If strCodCfg = 'CFG_TEFTRA' Then
          strValCfg := fArqIni(0, 'TEF', 'TRANSACAO',  '');

        If strCodCfg = 'CFG_MODBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'MODELO', '');

        If strCodCfg = 'CFG_PCOBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'PORTA', '');

        If strCodCfg = 'CFG_RATBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'BAUD RATE', '');

        If strCodCfg = 'CFG_BITBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'DATA BITS', '');

        If strCodCfg = 'CFG_PARBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'PARITY', '');

        If strCodCfg = 'CFG_STOBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'STOP BITS', '');

        If strCodCfg = 'CFG_HANBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'HANDSHAKING', '');

        If strCodCfg = 'CFG_DIGBAL' Then
          strValCfg := fArqIni(0, 'GERAL', 'DIGINI', '');

        If strCodCfg = 'CFG_DVQBAL' Then
          strValCfg := fArqIni(0, 'BALANCA', 'DIVQTD', '');

        If strCodCfg = 'CFG_TMPMON' Then
          strValCfg := fArqIni(0, 'GERAL', 'TMPMON', '5');

        If strCodCfg = 'CFG_PATCRE' Then
          strValCfg := fArqIni(0, 'GERAL', 'frmCadReceitAgronomicoExpCrea', '');

        If strCodCfg = 'CFG_XMLPAT' Then
          strValCfg := fArqIni(0, STR_CHAVE_IMPORTACAO_NFE,
                                  'PATH ' + strCodEmp,
                                  ExtractFilePath(Application.ExeName));

        If strCodCfg = 'CFG_MARCAM' Then
          strValCfg := fRetornaValCfgMarCam(strValCfg);

        If (strCodCfg = 'CFG_ZRICUC') And
           (fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_SIMPAU', strCodEmp]) = 'S') Then
        Begin
          strValCfg := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_IFSN41', strCodEmp]);

          If fEmptyStr(strValCfg) Then
            strValCfg := 'N';
        End;

        strValCfgGra := strValCfg;

        If AnsiStartsText('SELECT ', strValCfg) Then
          strValCfgGra := fExecutaValCfg(strValCfg, strCodEmp);

        qryAux.Close;
        qryAux.ParamByName('CODEMP').AsString  := strCodemp;
        qryAux.ParamByName('CODCFG').AsString  := strCodCfg;
        qryAux.ParamByName('DESCRI').AsString  := strDescri;
        qryAux.ParamByName('VALCFG').AsString  := strValCfgGra;
        qryAux.ParamByName('GRUCFG').AsString  := strGruCfg;
        qryAux.ParamByName('NUMHLP').AsInteger := intNumHlp;
        qryAux.ExecSQL;

        Result := True;
      End;
    End;

    qryConfig.Close;
    FreeAndNil(qryConfig);
    FreeAndNil(qryAux);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Houve um erro ao criar configuraÁıes no sistema: ' + #13#10 +
                     E.Message, '[pCriarConfiguracoes]');
    End;
  End;

end;
{$ENDIF}

function fRetornaValCfgMarCam(strValCfgOri: String): String;
  Var
    qryCfgVal : TUniQuery;
Begin
  Result := strValCfgOri;

  If (fEmptyStr(Result)) Then
  Begin
    qryCfgVal := fCriaQuery();
    Try
      With qryCfgVal, SQL Do
      Begin
        Close;
        Clear;
        Add(' SELECT SIS_VALCFG           ');
        Add('   FROM CFGSIS               ');
        Add('  WHERE SIS_CODCFG = :CODCFG ');
        Add('    AND SIS_CODEMP = :CODEMP ');
        ParamByName('CODCFG').AsString := 'CFG_CUSMAR';
        ParamByName('CODEMP').AsString := Vs_strCodEmp;
        Open;

        {
        CFG_CUSMAR:
          1-N„o exibir
          2-Exibir somente margem lÌquida
          3-Exibir custo/margem bruta/margem lÌquida
          4-Exibir custo/margem bruta/margem lÌquida/total produtos preÁo tabela
          5-Exibir margem lÌquida/total produtos preÁo tabela
          6-Exibir custo / custo real / margem bruta / margem liquida
          7-Exibir custo / custo real / margem bruta / margem liquida / total produtos preÁo tabela
        }

        Result := StringOfChar('N', Ord(High(TMarCamOpcoes)) + 1);

        If (Not IsEmpty) And
           (Length(Result) >= 5) Then
        Begin
          If (FieldByName('SIS_VALCFG').AsString = '2') Then
            Result[3] := 'S'
          Else If (FieldByName('SIS_VALCFG').AsString = '3') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '4') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[4] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '5') Then
          Begin
            Result[3] := 'S';
            Result[4] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '6') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[5] := 'S';
          End
          Else If (FieldByName('SIS_VALCFG').AsString = '7') Then
          Begin
            Result[1] := 'S';
            Result[2] := 'S';
            Result[3] := 'S';
            Result[4] := 'S';
            Result[5] := 'S';
          End;
        End;

        Close;
      End;
    Finally
      FreeAndNil(qryCfgVal);
    End;
  End;

end;

function fExecutaValCfg(strSQL, strEmp: String): String;
  Var
    qryTemp: TUniQuery;
begin
  qryTemp := fCriaQuery(Nil);
  If Pos('CFGSIS',strSQL) > 0 Then
  Begin
    qryTemp.SQL.Add(strSQL + ' AND SIS_CODEMP = :CODEMP');
    qryTemp.ParamByName('CODEMP').AsString := strEmp;
  End Else
  Begin
    qryTemp.SQL.Add(strSQL);
  End;

  qryTemp.Open;
  Result := qryTemp.Fields[0].AsString;
  qryTemp.Close;
  FreeAndNil(qryTemp);
end;

function fPermiteEmissaoEspecie(strEspecie: String): Boolean;
  Const
    ESPECIES_PERMISSIVEIS : String = 'FF_MI_TR_DV_TE_BR_UC_EP_';

  Var
    qryCfgSis: TUniQuery;
begin
  If fEmptyStr(strEspecie) Then
    Exit(True);

  If (Not ESPECIES_PERMISSIVEIS.Contains(strEspecie)) Then
    Exit(True);

  qryCfgSis := fCriaQuery(Nil);
  Try
    qryCfgSis.Close;
    qryCfgSis.SQL.Clear;
    qryCfgSis.SQL.Add(' SELECT SIS_VALCFG ');
    qryCfgSis.SQL.Add('   FROM CFGSIS ');
    qryCfgSis.SQL.Add('  WHERE SIS_CODCFG = :CODCFG ');
    qryCfgSis.SQL.Add('    AND SIS_CODEMP = :CODEMP ');
    qryCfgSis.ParamByName('CODCFG').AsString := 'CFG_PREM' + strEspecie;
    qryCfgSis.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgSis.Open;

    If (Not qryCfgSis.IsEmpty) Then
      Exit(qryCfgSis.FieldByName('SIS_VALCFG').AsString = 'S')
    Else
      Result := True;
  Finally
    qryCfgSis.Close;
    FreeAndNil(qryCfgSis);
  End
end;

function fRetDescOpcCliPro(Const opc : TOpcCliPro): String;
begin
  Case opc Of
    opcPdOrNf   : Result := 'Impress„o de OrÁamento/Pedido/Nota Fiscal';
    opcEtiqueta : Result := 'Impress„o de Etiquetas de Produtos';
  End;
end;

function fRetDescricaoAjuIcm(Const strCodAjuIcm: String): String;
Begin
   Result := fCampoTabela('AJU_DESAJU', 'AJUSTE', ['AJU_CODAJU'], [strCodAjuIcm], False);
End;

function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
{$IFDEF LINUX}
begin
  Result := Services.Core.Connection.Manager.fRetNomeEmpresa(strCodEmpresa);
end;
{$ELSE}
begin

  Result := '';

  If fEmptyStr(strCodEmpresa) Then
    Exit;

  Result := fRetNomeEmpresa(strCodEmpresa);
end;
{$ENDIF}

function fRetNomProduto(Const strCodIte: String ): String;
Begin
  Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False); //Para ler a descriÁ„o do buffer
End;

function fRetNomFornecedor(strCodFor: String): String;
  Var
    strSQL   : String;
    qryGenFor: TUniQuery;

Begin
  Try

    qryGenFor := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADFOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FOR_CODFOR = :CODFOR ';

    With qryGenFor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := strCodFor;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('FOR_NOMFOR').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenFor);
  End;

End;

function fRetNomeConta(strCodCta: String): String;
  Var
    strSQL   : String;
    qryGenCta: TUniQuery;

Begin
  Try

    qryGenCta := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCTA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTA_CODCTA = :CODCTA ';

    With qryGenCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCTA').AsString := strCodCta;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('CTA_DESCTA').AsString
      Else
        Result := '';
    End;

  Finally
    FreeAndNil(qryGenCta);
  End;
End;

function fRetDesAbfPis(strAbfPis: String): String;
begin

  Result := '';

  If fEmptyStr(strAbfPis) Then
    Exit;

  Result := fCampoTabela('APC_DESCRI', 'PISSAI', ['APC_CODAPC'], [strAbfPis], False);

end;

function fRetNomProfissional(Const strCodPro: String; blnVerStatus: Boolean=False): String;
Begin

  Result := '';

  If fEmptyStr(strCodPro) Then
    Exit;

  If Not (blnVerStatus) Then
    Result := fCampoTabela('DIV_NOMDIV', 'CADDIV', ['DIV_CODDIV'], [strCodPro], False)
  Else
    Result := fCampoTabela('DIV_NOMDIV', 'CADDIV', ['DIV_CODDIV', 'DIV_STATUS'], [strCodPro, 'A'], False);

End;

function fRetDesServico(strCodSer: String): String;
begin
  Result := fCampoTabela('SER_DESSER', 'CADSER', ['SER_CODSER'], [strCodSer]);
end;

function fRetNomeCartao(strCodCar: String): String;
  Var
    strSQL   : String;
    qryGenCar: TUniQuery;

begin
  Try

    qryGenCar := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CAR_CODCAR = :CODCAR ';

    With qryGenCar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCAR').AsString := strCodCar;
      Open;
      Result := FieldByName('CAR_DESCAR').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCar);
  End;

end;

function fRetDadosPix(AAutoIncrem: String): String;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriarQuery('SELECT CONCAT(P.PIX_TIPCHV, "-",             ' +
                             '              P.PIX_CHAVE_, " - BANCO: ",    ' +
                             '              C.CCA_CODBCO) AS DADOS         ' +
                             'FROM CCAPIX P                                ' +
                             'JOIN CADCCA C ON C.AUTOINCREM = P.PIX_SEQCCA ' +
                             'WHERE P.AUTOINCREM="' + AAutoincrem + '"     ');
    LConsulta.Open;

    Result := LConsulta.FieldByName('DADOS').AsString;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function fRetNomLocFisica(Const strCodLoc: String; strCodEmp: String = ''; blnRefazConsulta: Boolean = False): String;
Begin
  If strCodEmp = '' Then
    strCodEmp := VS_strCodEmp;
  Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'],
                         [strCodLoc, strCodEmp], blnRefazConsulta);
End;

function fRetDescOcorrencia(Const strCodOcorrencia: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OCO_DESOCO DESOCO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOCO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OCO_CODOCO = :CODOCO ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOCO').AsString := strCodOcorrencia;
      Open;
      Result := FieldByName('DESOCO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fRetNomUnidade(strCodUni: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodUni) Then
    Exit;

  Result := fCampoTabela('UNI_DESUNI', 'CADUNI', ['UNI_CODUNI'], [strCodUni], False);

End;

function fRetNomeMarca(strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenMar: TUniQuery;

Begin
  Try

    qryGenMar := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MAR_CODMAR = :CODMAR ';

    With qryGenMar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMAR').AsString := strCodigo;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('MAR_DESMAR').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenMar);
  End;

End;

function fRetDesAbfCof(strAbfCof: String): String;
begin

  Result := '';

  If fEmptyStr(strAbfCof) Then
    Exit;

  Result := fCampoTabela('APC_DESCRI', 'COFSAI', ['APC_CODAPC'], [strAbfCof], False);

end;

function fRetDescDepartamento(strCodDep: String): String;
  Var
    strSQL   : String;
    qryGenDep: TUniQuery;

Begin
  Try

    qryGenDep := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADDEP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DEP_CODIGO = :CODDEP ';

    With qryGenDep Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODDEP').AsString := strCodDep;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('DEP_DESCRI').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenDep);
  End;

End;

function fRetConPag(strCodCnd: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodCnd) Then
    Exit;

  Result := fCampoTabela('CND_CNDPAG', 'CADCND', ['CND_CODIGO'], [strCodCnd], False);

End;

function fRetMotivoVendasPerdidas(Const strCodMot: String): String;
Begin
  Result := '';

  if fEmptyStr(strCodMot) then
    exit;

  Result := fCampoTabela('MOT_DESMOT', 'MOTVPD', ['MOT_CODMOT'], [strCodMot], False);
End;

function fRetDescTipoOcorrencia(strCodToc: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Result := '';

  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  TOC_DESTOC AS DESTOC ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADTOC ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  TOC_CODTOC = :CODTOC ';

    With qryGen, SQL Do
    Begin
      Clear;
      Add(strSQL);
      ParamByName('CODTOC').AsString := strCodToc;
      Open;

      Result := FieldByName('DESTOC').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetDescricaoFase(strCodFas: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Result := '';

  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  FAS_DESFAS AS DESFAS ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADFAS ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  FAS_CODFAS = :CODFAS ';

    With qryGen, SQL Do
    Begin
      Clear;
      Add(strSQL);
      ParamByName('CODFAS').AsString := strCodFas;
      Open;

      Result := FieldByName('DESFAS').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function fRetDescAte(Const strCodAte: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADATE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ATE_CODATE = :CODATE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODATE').AsString := strCodAte;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('ATE_DESATE').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fRetNomEvento(strCodEve: String): String;
  Var
    strSQL   : String;
    qryGenEve: TUniQuery;
Begin
  Try
    qryGenEve := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEVE ';

    if Length(strCodEve) > 5 then
      strSQL := strSQL + 'WHERE EVE_CODCOM = :CODEVE '
    else
      strSQL := strSQL + 'WHERE EVE_CODEVE = :CODEVE ';

    With qryGenEve Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEVE').AsString := strCodEve;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('EVE_DESEVE').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGenEve);
  End;
End;

function fRetDescTipoCli(Const strCodTip: String): String;
  Var
    strSQL   : String;
    qryGenClg: TUniQuery;
begin
  Try
    qryGenClg := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  TIP_DESTIP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  TIPCLG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TIP_CODTIP = :CODTIP ';

    With qryGenClg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTIP').AsString := strCodTip;
      Open;
      Result := FieldByName('TIP_DESTIP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenClg);
  End;
End;


function fRetNomAtividade(Const strCodAti: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodAti) Then
    Exit;

  Result := fCampoTabela('ATI_DESATI', 'CADATI', ['ATI_CODATI'], [strCodAti], False);

End;

function fRetNomPortador(Const strCodPor: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodPor) Then
    Exit;

  Result := fCampoTabela('POR_NOMPOR', 'CADPOR', ['POR_CODPOR'], [strCodPor], False);

End;


function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String;
  Var
    strSQL   : String;
    strCodEmp: String;
begin
  Try
    strCodEmp := VS_strCodEmp;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   CADEMP.*, ';
    strSQL := strSQL + '   CID_NOMCID AS "EMP_NOMCID", ';
    strSQL := strSQL + '   CID_ESTADO AS "EMP_ESTADO", ';
    strSQL := strSQL + '   CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM, ", ", EMP_BAIRRO, " - " , CID_NOMCID, "/", CID_ESTADO) AS EMP_ENDERECO ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin

      If (Not Active) Or IsEmpty Or (strCodEmp <> FieldByName('EMP_CODEMP').AsString) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;
      End;

      If FieldByName('EMP_' + strNomCampo).IsNull Then
      Begin
        Result := '';
      End
      Else
      Begin
        Result := FieldByName('EMP_' + strNomCampo).AsVariant;
      End;

    End;

  Finally

  End;

end;

function fRetUFEmpresa(strCodEmp: String = ''): String;
begin

  If strCodEmp = '' Then
    strCodEmp := VS_strCodEmp;

  Result := fCampoTabela('CID_ESTADO', 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [strCodEmp], False);

end;

function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean;
  Var
    strCndTmp: String;
    strPraAnt: String;
    strPraAtu: String;
    intQtdPar: Integer;
    intParcel: Integer;
begin
  Result := True;

  strCndTmp := Trim(fTiraCaracEspeciais(strCndPag));

  If Pos(' ', strCndTmp) > 0 Then
  Begin
    Result := False;
  End
  Else
  Begin

    intQtdPar := 0;
    If Not fEmptyStr(Trim(LeftStr(strCndTmp, 2))) Then
      intQtdPar := StrToIntDef(Trim(LeftStr(strCndTmp, 2)), 0);

    If intQtdPar = 0 Then
      Result := False

    Else If (intQtdPar * 3) <> Length(Copy(strCndTmp, 3, Length(strCndTmp) - 2)) Then
      Result := False;

    If Result Then
    Begin
      For intParcel := 0 To intQtdPar -1 Do
      Begin
        strPraAtu := Copy(strCndTmp, 3 * (1 + intParcel), 3);

        If Not fEmptyStr(strPraAnt) Then
        Begin
          {**************************************************}
          {* VERIFICA SE PERMITE REPETIR O MESMO VENCIMENTO *}
          {***********************************************PZ*}
          If (blnPerRep) Then
            Result := StrToIntDef(strPraAtu, 0) >= StrToIntDef(strPraAnt, 0)
          Else
            Result := StrToIntDef(strPraAtu, 0) > StrToIntDef(strPraAnt, 0);
        End;

        If Not Result Then
          Break;

        strPraAnt := strPraAtu;
      End;
    End;

  End;

end;

function fTiraCaracEspeciais(strTexto      : String;
                             blnUsaLista   : Boolean = True;
                             blnTiraEspacos: Boolean = False;
                             blnTiraPontos : Boolean = False;
                             blnTiraDoisPts: Boolean = False;
                             blnTiraTab    : Boolean = False;
                             blnTiraVirgula: Boolean = True): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*™∫∞&"''()%$®@!?ß={}[]¥`^~π≤≥£¢ÿ'
  Else
    strLista := EmptyStr;

  If (blnTiraEspacos) Then
    strLista := strLista + ' ';

  If (blnTiraPontos) Then
    strLista := strLista + '.';

  If (blnTiraDoisPts) Then
    strLista := strLista + ':';

  If (blnTiraTab) Then
    strLista := strLista + #9;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := '‡ËÏÚ˘·ÈÌÛ˙‚ÍÓÙ˚„ı‰ÎÔˆ¸Á¿»Ã“Ÿ¡…Õ”⁄¬ Œ‘€√’ƒÀœ÷‹«';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  Begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    If intPosicao > 0 Then
      Result := Result + strCaracNorm[intPosicao]

    Else If Pos(strTexto[intContador], strLista) <= 0 Then
      Result := Result + strTexto[intContador];

  End;

end;

function fCadEmpresa(strNomCampo: String): String; Overload;
begin
{$IFDEF LINUX}
  Result := Services.Core.Connection.Manager.fCadEmp(strNomCampo, nil);
{$ELSE}
  Result := fCadEmp(strNomCampo, nil);
{$ENDIF}
end;

function fCadEmpresa(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
begin
  Result := fCadEmp(strNomCampo, qryGenEmp);
end;

function fCadEmp(strNomCampo: String): String;
  Var
    qryGenEmp: TUniQuery;
begin
  {************************************************************************}
  { VerificaÁ„o do campo ESTADO para evitar sucessivas aberturas do SELECT }
  { com todos os dados na empresa, retornando apenas o ESTADO              }
  {**********************************************************************CH}
  If (strNomCampo='ESTADO') Then
  Begin
    Result := fRetUFEmpresa
  End
  Else
  Begin
    Try

      qryGenEmp := fCriaQuery;
      qryGenEmp.Close;

      Result := fCadEmp(strNomCampo, qryGenEmp);

      qryGenEmp.Close;

    Finally
      FreeAndNil(qryGenEmp);
    End;
  End;
end;

{***********************************************************}
{* RETORNA A DATA E HORA DO SERVIDOR ***********************}
{***********************************************************}
{ Na funÁ„o foi mantido a utilizaÁ„o da funÁ„o nOw() do     }
{  Delphi, caso a vari·vel VS_Date ainda n„o estiver ini-   }
{  nicializada, pois, na inicializaÁ„o do sistema a va-     }
{  ri·vel VS_DATE ainda est· nula em alguns pontos. Como    }
{  as funÁıes de retorno de nome de tabelas TMP (que se-    }
{  r„o removidas futuramente) se baseiam na data e hora     }
{  para nomear as tabelas, esta deve receber corretamente a }
{  data e hora para criaÁ„o das tabelas no banco de dados.  }
{  H· tambÈm uma quest„o na inicializaÁ„o de vari·veis glo- }
{  bais que tambÈm justifica essa utilizaÁ„o temporariamen- }
{  te (Alexandre ciente). Pontos a serem avaliados:         }
{   - untFuncoes.fGetMemoryTableNameBarrasFabrica           }
{   - untFuncoesSimples.fGetMemoryTableNameEntregaFutura    }
{   - untFuncoesSimples.VS_dtaUltimaExecucaoImportadorPDV   }
{     * avaliar no 'inicialization' da unit                 }
{********************************************************DF*}
function fNow: TDateTime;
begin
  Result := IIF(Trunc(VS_Date) = 0, nOw(), VS_Date + fTime());
end;

function fCurrentTime: String;
begin
  Result := 'CAST("' + FormatDateTime('hh:mm:ss', fRetHoraServidor) + '" AS TIME)';
end;

function fCurrentDate: String;
{$IFDEF LINUX}
begin
  Result := Services.Core.Connection.Manager.fCurrentDate;
end;
{$ELSE}
begin
  Result := fCurrentDate(VS_Date);
end;
{$ENDIF}

function fCurrentDate(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;

function fCurrentDateTime: String;
{$IFDEF LINUX}
begin
  Result := Services.Core.Connection.Manager.fCurrentDateTime;
end;
{$ELSE}
begin
  Result := fCurrentDateTime(VS_Date + fTime());
end;
{$ENDIF}

function fCurrentDateTime(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd hh:mm:ss', Value) + '" AS DATETIME)';
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function fRetornaStack: String;
{$IFDEF LINUX}
begin
  Result := EmptyStr;
end;
{$ELSE}
var
  stlTrack: TStringList;
begin
  stlTrack := Nil;
  Try
    Try
      stlTrack := TStringList.Create;
      stlTrack.Text := madStackTrace.StackTrace();
      Result := stlTrack.Text;
    Except
      On E: Exception Do
        Result := '<stack indisponÌvel>';
    End;
  Finally
    If Assigned(stlTrack) Then
      FreeAndNil(stlTrack);
  End;
end;
{$ENDIF}

function fUsaSat(strCodEmp : String) : Boolean;
  Var
    strPathSat : String;
Begin
  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  If fCfgSis('USASAT', varBoolean, strCodEmp) and fCfgSis('SATECF', varBoolean, strCodEmp) Then
  Begin
    strPathSat := IncludeTrailingPathDelimiter(fCfgSis('PATSAT', varString)) + 'opcoes_sat.ini';
    If FileExists(strPathSat) Then
      Result := StrToBool(fArqIniLocal(0, 'SATCFE', 'USASAT', '0', strPathSat ))
    Else
      Result := False;
  End
  Else
    Result := fCfgSis('USASAT', varBoolean, strCodEmp);
End;

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.fFormataFloat(fltNumero, intDecimais);
end;
{$ELSE}
begin
  //Se usa SAT entao sempre usa regras de arredondamento ABNT NBR 5891/77
  If fUsaSat Or fCfgSis('RAABNT', VarBoolean) Then
  Begin
    Result := fArredondaABNT_NBR5891_77(fltNumero, intDecimais);
  End
  Else
  Begin
    Result := fFormataFloatInterna(fltNumero, intDecimais);
  End;
end;
{$ENDIF}

function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  Var
    intDig: Integer;
    strVal: String;
begin
  strVal := FloatToStr(fltNumero);

  {*******************************}
  {* SE O VALOR POSSUIR DECIMAIS *}
  {****************************JC*}
  If Pos(FormatSettings.DecimalSeparator, strVal) > 0 Then
  Begin
    intDig := Length(strVal) - Pos(FormatSettings.DecimalSeparator, strVal);

    {*********************************************************************************}
    {* SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA *}
    {******************************************************************************JC*}
    If (intDig > 0) And (intDig > intDecimais) And (strVal[Length(strVal)] = '5') Then
    Begin
      strVal[Length(strVal)] := '6';
    End;
  End;

  {************************************************************}
  {* CONTINUA FORMATANDO IGUAL ERA COM A FUNCAO fFormataFloat *}
  {*********************************************************JC*}
  Result := fStrToFloat(FloatToStrF(fStrToFloat(strVal), ffFixed, 12, intDecimais));
end;

{$IFNDEF LINUX}
function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
var
  LFactor: Extended;
begin
  LFactor := IntPower(10.0, ADigit);
  if AValue < 0 then
    Result := Int((AValue / LFactor) - 0.5) * LFactor
  else
    Result := Int((AValue / LFactor) + 0.5) * LFactor;
end;
{$ENDIF}

(*
  2.1 Quando o algarismo imediatamente seguinte ao ˙ltimo algarismo a ser conservado
  for inferior a 5, o ˙ltimo permanecer· sem modificaÁ„o
  Exemplo: 1,333 3 arredondado ‡ primeira decimal tornar-se-·:1,3

  2.2 Quando o algarismo imediatamente seguinte ao ˙ltimo algarismo a ser conservado
  for superior a 5, ou sendo 5, seguido de no mÌnimo um algarismo diferente de zero,
  o ˙ltimo algarismo a ser conservado dever· ser aumentado de uma unidade.
  Exemplo: 1,666 6 arredondado ‡ primeira decimal tornar-se-·:1,7
  4,851 5 arredondado ‡ primeira decimal torna-se-„o:4,9

  2.3 Quando o algarismo imediatamente seguinte ao ˙ltimo algarismo a ser conservado
  for 5 seguido de zeros, dever-se-· arredondar o algarismo a ser conservado para o
  algarismo par mais prÛximo. Conseq¸entemente, o ˙ltimo algarismo a ser retido,
  se for Ìmpar, aumentar· uma unidade.
  Exemplo: 4,550 0 arredondado ‡ primeira decimal tornar-se-·:4,6

  2.4 Quando o algarismo imediatamente seguinte ao ˙ltimo a ser conservado for 5
  seguido de zeros, se for par o algarismo a ser conservado ele permanecer· sem
  modificaÁ„o.
  Exemplo: 4,850 0 arredondado ‡ primeira decimal tornar-se-·:4,8
*)
{$IFNDEF LINUX}
function fArredondaABNT_NBR5891_77(fltValor: Double;
  intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
var
   extPow, extUltimosNumeros, extValorPow : Extended;
   fltParteRestante: Double;
   intCalc, intFracCalc, intUltimoNumero, intValor : Int64;
   blnNegativo: Boolean;
Begin
   blnNegativo  := (fltValor < 0);

   extPow       := intpower(10, abs(intDecimais) );
   extValorPow  := abs(fltValor) / 10 ;
   intValor  := trunc(extValorPow);
   extUltimosNumeros := frac(extValorPow);

   extValorPow := fSimpleRoundToEX( extUltimosNumeros * 10 * extPow, -9) ; // SimpleRoundTo elimina dizimas ;
   IntCalc  := trunc( extValorPow );
   intFracCalc := trunc( frac( extValorPow ) * 100 );

   if (intFracCalc > 50) then
     Inc( IntCalc )

   else if (intFracCalc = 50) then
   begin
     intUltimoNumero := round( frac( IntCalc / 10) * 10);

     if odd(intUltimoNumero) then
       Inc( IntCalc )
     else
     begin
       fltParteRestante := frac( extValorPow * 10 ) ;

       if fltParteRestante > Delta then
         Inc( IntCalc );
     end ;
   end ;

   Result := ((intValor*10) + (IntCalc / extPow));

   if blnNegativo then
     Result := -Result;
end;
{$ENDIF}

function fGetConnectionID(objConexao: TUniConnection = Nil): String;
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Nil, objConexao);

  Try

    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;

    Result := qryAux.Fields[0].AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure pGravaLogTransacao(objConexao: TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
  Var
    qryAux: TUniQuery;
    strTransacao: String;
    tmrStart: TDateTime;
begin
  qryAux := fCriaQuery(Nil, objConexao);
  Try
    Try
      tmrStart := fNow();
      qryAux.SQL.Text := 'SELECT * FROM TRANSACOES WHERE FALSE';
      qryAux.Open;

      If (strIdenti.IsEmpty) Then
      Begin
        strTransacao := FormatDateTime('dd/mm/yyyy hh:nn:ss', tmrStart);
        VS_dtaIdentiTransacao.Add(strTransacao);

        qryAux.Append;
        qryAux.FieldByName('TRA_CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.FieldByName('TRA_IDENTI').AsString := strTransacao;
        qryAux.FieldByName('TRA_STACK_').AsString := fRetornaStack;//fRetornaStack;
        qryAux.FieldByName('TRA_ID_CON').AsString := fGetConnectionID(objConexao);
        qryAux.FieldByName('TRA_HORSTA').AsDateTime := tmrStart;

        if qryAux.FindField('TRA_MODULE') <> nil then
          qryAux.FieldByName('TRA_MODULE').AsString := ExtractFileName(GetModuleName(HInstance));

        if qryAux.FindField('TRA_NOMMAQ') <> nil then
          qryAux.FieldByName('TRA_NOMMAQ').AsString := VS_ComputerNetName;

        if qryAux.FindField('TRA_NOMUSU') <> nil then
          qryAux.FieldByName('TRA_NOMUSU').AsString := VS_UserFromWindows;

        qryAux.Post;

       {$IFNDEF LINUX}
        VS_TimerTransacao.Enabled := True;
       {$ENDIF}
      End
      Else
      Begin
        If (strIdenti.Contains(CNS_TRA_EM_MSG)) Then
        Begin
          strTextoComplementarAoCallStack :=
              strTextoComplementarAoCallStack + #10#13 +
              'Vers„o Arquivo: '  + fRetornaVersao(Application.ExeName, False) + #13 +
              'Vers„o Produto: '  + fRetornaVersao(Application.ExeName, True)  + #13 +
              'Path do Arquivo: ' + ExtractFilePath(Application.ExeName);
        End;

        qryAux.Append;
        qryAux.ParamByName('TRA_CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.ParamByName('TRA_IDENTI').AsString := strIdenti;
        qryAux.ParamByName('TRA_STACK_').AsString := strTextoComplementarAoCallStack + #10#13 + fRetornaStack;
        qryAux.ParamByName('TRA_ID_CON').AsString := fGetConnectionID;
        qryAux.ParamByName('TRA_HORSTA').AsDateTime := tmrStart;

        if qryAux.FindField('TRA_MODULE') <> nil then
          qryAux.FieldByName('TRA_MODULE').AsString := ExtractFileName(GetModuleName(HInstance));

        if qryAux.FindField('TRA_NOMMAQ') <> nil then
          qryAux.FieldByName('TRA_NOMMAQ').AsString := VS_ComputerNetName;

        if qryAux.FindField('TRA_NOMUSU') <> nil then
          qryAux.FieldByName('TRA_NOMUSU').AsString := VS_UserFromWindows;

        qryAux.Post;
      End;

    Except
      //
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pAtualizaLogTransacao(strStack    : String         = '';
                                tmrCommit   : TDateTime      = 0;
                                tmrRollback : TDateTime      = 0;
                                objConexao  : TUniConnection = Nil);
  Var
    qryAux: TUniQuery;
    strTransacao: String;
begin
  if not VS_blnGravaLogTransacao then
    exit;

  If VS_dtaIdentiTransacao.Count > 0 Then
  Begin
    strTransacao := VS_dtaIdentiTransacao[VS_dtaIdentiTransacao.Count-1];
  End;

  If fEmptyStr(strTransacao) Then
    Exit;

  qryAux := fCriaQuery(objConexao);

  Try
    qryAux.SQL.Add('UPDATE TRANSACOES ');
    qryAux.SQL.Add('SET TRA_IDENTI = :IDENTI ');

    If Not fEmptyStr(strStack) Then
      qryAux.SQL.Add('    ,TRA_STACK_ = :STACK_ ');

    If tmrCommit > 0 Then
      qryAux.SQL.Add('    ,TRA_HORCOM = :HORCOM ');

    If tmrRollback > 0 Then
      qryAux.SQL.Add('    ,TRA_HORROL = :HORROL ');

    qryAux.SQL.Add('WHERE TRA_CODOPE = :CODOPE AND TRA_IDENTI = :IDENTI');
    qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryAux.ParamByName('IDENTI').AsString := strTransacao;

    If Not fEmptyStr(strStack) Then
      qryAux.ParamByName('STACK_').AsString := strStack;

    If tmrCommit > 0 Then
      qryAux.ParamByName('HORCOM').AsDateTime := tmrCommit;

    If tmrRollback > 0 Then
      qryAux.ParamByName('HORROL').AsDateTime := tmrRollback;

    qryAux.ExecSQL;
  Except
    //
  End;

  FreeAndNil(qryAux);
end;

procedure pApagaLogTransacao(opcao: TAcaoTransacao; objConexao: TUniConnection = Nil);
  Var
    qryAux: TUniQuery;
    strTransacao: String;
begin
  If VS_dtaIdentiTransacao.Count = 0 Then
    Exit;

  strTransacao := VS_dtaIdentiTransacao[VS_dtaIdentiTransacao.Count-1];

  Try
    If SecondsBetween(fNow(), StrToDateTimeDef(strTransacao, 0)) > VS_TRANSACAO_LIMITE_SEGUNDOS Then
    Begin

      Case opcao Of
        opCommit  : pAtualizaLogTransacao('', fNow(),      0, objConexao);
        opRollBack: pAtualizaLogTransacao('',      0, fNow(), objConexao);
      End;

    End
    Else
    Begin
      qryAux := fCriaQuery(Nil, objConexao);
      qryAux.SQL.Add('DELETE FROM TRANSACOES WHERE TRA_CODOPE = :CODOPE AND TRA_IDENTI = :IDENTI');
      qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryAux.ParamByName('IDENTI').AsString := strTransacao;
      qryAux.ExecSQL;
      FreeAndNil(qryAux);
    End;
  Except
    //
  End;

  VS_dtaIdentiTransacao.Delete(VS_dtaIdentiTransacao.Count-1);

 {$IFNDEF LINUX}
  If VS_dtaIdentiTransacao.Count = 0 Then
    VS_TimerTransacao.Enabled := False;
 {$ENDIF}
end;

function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
begin
  If Assigned(objConexao) Then
    Result := objConexao.InTransaction
  else
  {$IFNDEF LINUX}
    Result := frmModulo.GetCurrentConnection.InTransaction;
  {$ELSE}
    Result := objConnectionsManager.CurrentConnection.InTransaction;
  {$ENDIF}
end;

function fConexaoAtiva(): Boolean;
begin
{$IFNDEF LINUX}
  Result := Assigned(frmModulo) And frmModulo.GetCurrentConnection.Connected;
{$ELSE}
  Result := Assigned(objConnectionsManager) and objConnectionsManager.CurrentConnection.Connected;
{$ENDIF}
end;

procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');

  function fMensagemDeveSerRegistrada: Boolean;
  begin
    Result := (Not AnsiUpperCase(strTextoComplementarAoCallStack).Contains('DOCUMENTO EMITIDO EM AMBIENTE DE HOMOLOGA«√O'));
  end;

begin
  If (Not strLoginUsuarioLogado.IsEmpty) Then
  Begin
    Try
      If Assigned(objConexao) Then
      Begin
        If fInTransaction(objConexao) Then
          If fMensagemDeveSerRegistrada Then
            pGravaLogTransacao(objConexao, CNS_TRA_EM_MSG, strTextoComplementarAoCallStack);
      End
      Else
      Begin
        If fConexaoAtiva Then
          If fInTransaction Then
            If fMensagemDeveSerRegistrada Then
              pGravaLogTransacao(Nil, CNS_TRA_EM_MSG, strTextoComplementarAoCallStack);
      End;
    Except
      //
    End;
  End;
end;

{*******************************}
{* Inicia a TransaÁ„o no Banco *}
{****************************MV*}
function fStartTransaction(objConexao: TUniConnection = Nil):Boolean;
begin

  Try

    If Assigned(objConexao) Then
    Begin

      If (Not objConexao.InTransaction) Then
      Begin
        VS_blnErroLogRep := False;
        VS_strErroLogRep := '';

        objConexao.StartTransaction;
        pAfterStartTransaction(objConexao);
        if VS_blnGravaLogTransacao then
          pGravaLogTransacao(objConexao);

        Result := True;

        pConectaAutoincrem;
      End
      Else
      Begin
        Result := True;
      End;

    End
    Else
    Begin

      If (Not fInTransaction) Then
      Begin
        VS_blnErroLogRep := False;
        VS_strErroLogRep := '';

       {$IFDEF LINUX}
        objConnectionsManager.CurrentConnection.StartTransaction;
       {$ELSE}
        frmModulo.GetCurrentConnection.StartTransaction;
        pAfterStartTransaction(frmModulo.GetCurrentConnection);
       {$ENDIF}

        if VS_blnGravaLogTransacao then
          pGravaLogTransacao();

        Result := True;

        pConectaAutoincrem;
      End
      Else
      Begin
        Result := True;
      End;

    End;

  Finally

  End;

end;

{***************************}
{* RollBack para TransaÁ„o *}
{************************MV*}
function fRollBack(objConexao: TUniConnection = Nil):Boolean;
begin

  Result        := True;
  VS_blnErroLogRep := False;
  VS_strErroLogRep := '';

  Try

    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction) Then
      Begin
        objConexao.Rollback;
        pDesconectaAutoincrem;
        pLimparVariaveisDeAmbienteTransacao(objConexao);
      End;
    End
    Else
    Begin
      If (fInTransaction()) Then
      Begin
       {$IFDEF LINUX}
        objConnectionsManager.CurrentConnection.Rollback;
       {$ELSE}
        frmModulo.GetCurrentConnection.Rollback;
       {$ENDIF}

        pDesconectaAutoincrem;

       {$IFDEF LINUX}
        pLimparVariaveisDeAmbienteTransacao(TUniConnection(objConnectionsManager.CurrentConnection.GetObject));
       {$ELSE}
        pLimparVariaveisDeAmbienteTransacao(frmModulo.GetCurrentConnection);
       {$ENDIF}
      End;
    End;

  Except
    On E : Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fRollBack]');
    End;
  End;
  if VS_blnGravaLogTransacao then
    pApagaLogTransacao(opRollback, objConexao);
end;

{***********************}
{* Commita a TransaÁ„o *}
{********************MV*}
function fCommit(objConexao: TUniConnection = Nil):Boolean;
begin
  If VS_blnErroLogRep Then
  Begin
    Raise Exception.Create(VS_strErroLogRep);
    Exit;
  End;

  Result := True;
  Try

    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction = True) Then
      Begin
        objConexao.Commit;
        pDesconectaAutoincrem;
        pLimparVariaveisDeAmbienteTransacao(objConexao);
      End;
    End
    Else
    Begin
      If (fInTransaction = True) Then
      Begin
       {$IFDEF LINUX}
        objConnectionsManager.CurrentConnection.Commit;
       {$ELSE}
        frmModulo.GetCurrentConnection.Commit;
       {$ENDIF}

        pDesconectaAutoincrem;

       {$IFDEF LINUX}
        pLimparVariaveisDeAmbienteTransacao(TUniConnection(objConnectionsManager.CurrentConnection.GetObject));
       {$ELSE}
        pLimparVariaveisDeAmbienteTransacao(frmModulo.GetCurrentConnection);
       {$ENDIF}
      End;
    End;

  Except
    On E : Exception do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fCommit]');
    End;
  End;
  if VS_blnGravaLogTransacao then
    pApagaLogTransacao(opCommit, objConexao);
end;

function fGetEmpresaLogada(): string;
begin
  Result := VS_strCodEmp;
end;

function fGetUsuarioLogado(): string;
begin
  Result := strLoginUsuarioLogado;
end;

procedure pTrimAppMemorySize;

   function fRetOpeMemTri: string;
     Var
       qryAux: TUniQuery;
   begin
     Result := '';

     qryAux := fCriaQuery(Nil);
     Try
       Try
         qryAux.Close;
         qryAux.SQL.Text := 'SELECT IFNULL(SIS_VALCFG, "N") FROM CFGSIS WHERE SIS_CODCFG = "CFG_MEMSWA" AND SIS_CODEMP = '+QuotedStr(fGetEmpresaLogada);
         qryAux.Open;
         If (Not qryAux.IsEmpty) Then
         Begin
           If (qryAux.Fields[0].AsString = 'S') Then
             Result := 'N';
         End;

         If (Result = '') Then
         Begin
           qryAux.Close;
           qryAux.SQL.Text := 'SELECT OPE_MEMTRI FROM CADOPE WHERE OPE_CODOPE = '+QuotedStr(fGetUsuarioLogado);
           qryAux.Open;

           If (Not qryAux.IsEmpty) Then
             Result := qryAux.Fields[0].AsString;
         End;
       Except
         //
       End;
     Finally
       qryAux.Free;
     End;
   end;

Begin
{$IFNDEF LINUX}
  If (VS_TrimMemorySize = 'N') Or
     (Length(fGetEmpresaLogada) <> 3) Or
     (Length(fGetUsuarioLogado) <> 3) Then
    Exit;

  If (VS_TrimMemorySize = '') Then
  Begin
    VS_TrimMemorySize := fRetOpeMemTri;

    If (Pos(AnsiUpperCase(VS_TrimMemorySize), 'S_N_') = 0) Then
      VS_TrimMemorySize := 'S';
  End;

  If (VS_TrimMemorySize = 'S') Then
  Begin
    Try
      EmptyWorkingSet(GetCurrentProcess);
    Except
      //
    End;
  End;
{$ENDIF}
End;

procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
{$IFDEF LINUX}
begin

end;
{$ELSE}
begin
  If Not Assigned(SenderUnico) Then
    Exit;

  If ((GetKeyState(VK_SHIFT) And 128) = 128) And
     ((GetKeyState(VK_TAB) And 128) = 128) Then
    Exit;

  Try
    if Form = Nil then
      Form := GetParentForm(SenderUnico);

    If (Form <> nil) And (Form.CanFocus) And SenderUnico.CanFocus Then
    Begin
      Try
        SenderUnico.SetFocus;
      Except

      End;
    End;
  Except

  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);
begin

  If (Assigned(NomeForm)) Then
    Exit;

	Try
    pCriarFormularios(ClasseModulo,NomeForm);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
	End;

end;
{$ENDIF}

procedure pDestroiModulo(var NomeForm);
begin
  Try
    Application.ProcessMessages;
    If Assigned(TDataModule(NomeForm)) Then
      FreeAndNil(NomeForm);
  Except
//    On E: Exception Do
//      pMensagensErro(E.Message, '[pDestroiModulo -> '+NomeForm.Name+']');
  End;
end;

{$IFNDEF LINUX}
procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
      On E: EAccessViolation Do
        Raise;

      On E: Exception Do
        strMsg := E.Message + ' ' + E.ClassName;
    End;

    If fEmptyStr(strMsg) Then
      Break;

    Application.ProcessMessages;
    Sleep(1500);

  End;

  If Not fEmptyStr(strMsg) Then
    Raise Exception.Create('Erro ao criar o formul·rio.' + #13 + strMsg);

End;
{$ENDIF}

{*****************************************************************************************}
{*                                                                                       *}
{* -> Funcao Mensagem                                                                    *}
{*                                                                                       *}
{*    - Parametros:                                                                      *}
{*      1) Titulo                                                                        *}
{*      2) Texto                                                                         *}
{*      3) Matriz com o nome para atÈ 03 botoes, sendo que vc pode passar ['',''] para   *}
{*         a funcao atribuir automaticamente Sim / Nao como Default                      *}
{***********************************************************************************MV*WI*}
Function fMensagem(strTitulo: String;
                   strTexto: String;
                   arrOpcoes: Array Of String;
                   intFocoBotao: Integer = 1;
                   blnSaiComEsc: Boolean = False;
                   intEstFon: Integer = 1;
                   intWidBut: Integer = 0;
                   blnAutosize: Boolean = False;
                   intSomarTop: Integer=0;
                   blnObrigaEsc: Boolean = False;
                   blnOcultPainelBtn: Boolean = False;
                   blnBtnSemImg : Boolean = False;
                   intHeightOpc: Integer = 0;
                   intFormWidth: Integer = 0;
                   intQtdLinha: Integer = -1): Integer;
{$IFDEF LINUX}
var
  intPosicao: Integer;
begin
  If strTitulo = '' Then
    strTitulo := 'AVISO';

  If (Length(arrOpcoes) = 1)   And
     (Trim(arrOpcoes[0]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&N„o';
  End;

  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&N„o';
  End;

  WriteLog(StringOfChar('-', 100));
  WriteLog(strTitulo);
  WriteLog(StringOfChar('-', 100));
  WriteLog(strTexto);
  WriteLog(StringOfChar('-', 100));

  for intPosicao := 0 to Length( arrOpcoes )-1 do
    if Succ(intPosicao) = intFocoBotao then
      WriteLog('[   ] ' + arrOpcoes[intPosicao])
    else
      WriteLog('[ X ] ' + arrOpcoes[intPosicao]);

  WriteLog(StringOfChar('-', 100));

  Result := intFocoBotao;

  AddOrSetGlobalVar('VS_UltimaMensagemAoUsuario', strTexto);
end;
{$ELSE}
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
    frmMsg       : TfrmMensagem;
    aHandle      : THandle;
    wrdTexto     : Word;
    BtnHeight    : Integer;
begin
  If Not VS_ExibirMensagemAoUsuario  Then
  Begin
    aHandle := FindWindow('TfrmAutcomSvc', Nil);
    If aHandle > 0 Then
    Begin
      wrdTexto := GlobalAddAtom(Pchar(strTexto));
      SendMessage(aHandle,CM_AVISOS,0,wrdTexto);
      GlobalDeleteAtom(wrdTexto);
      Result := intFocoBotao;
      Exit;
    End;
  End;

  BtnHeight      := 28;
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;
  //fntFonte.Style := [fsBold];

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  Begin
    If arrOpcoes[intPosicao] <> '' Then
      Inc(intQtdOpcoes)
    Else
      Break;
  End;

  If (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') Then
  Begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&N„o';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('… obrigatÛrio a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
    Result := 0;
    Exit;
  End;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  If ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) Then
    intFocoBotao := 1;

  Try

    pCriarFormularios(TfrmMensagem, frmMsg);

    With frmMsg Do
    Begin
      intSomaTop := intSomarTop;
      If (blnAutosize) Then
        WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsg.Height := intHeightOpc;

      If ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        blnAutosize := True;
        //intWidBut := 90;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      If SameText(ParamStr(1), 'VENDA_ASSISTIDA') Then
      Begin
        Height := 300;
        lblMensagem.Font.Size := 20;
        fntFonte.Size  := 18;
        frmMsg.lblTitulo.Font.Size := 18;
        frmMsg.pnlBotoes.Height := 60;
        BtnHeight := 50;
      End;

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;

      If intQtdLinha > 0 Then
        frmMsg.Height := frmMsg.Height + (lblMensagem.Canvas.TextHeight('X') * intQtdLinha);

      if intFormWidth > 0 Then
        Width := intFormWidth;

      If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          If blnAutosize Then
          Begin
            Left  := (Screen.Width - 126) Div 2
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 156 - ((intWidBut - 156) Div 2)
            Else
              If Length(arrOpcoes) = 1 Then
                Left       := (frmMsg.Width - Width) Div 2
              Else
              Left       := 156;
          End;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := ((Screen.Width - 2*130) Div 2);
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := ((frmMsg.Width - (intWidBut*2)) Div 2)
            Else
              Left       := 90;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin

            Left  := ((Screen.Width - 2*126) Div 2) + 126 + 7;

          End Else
          Begin

            If intWidBut <> 0 Then
              Left := ((frmMsg.Width - (intWidBut*2) ) Div 2) + intWidBut + 1
            Else
            Left       := 222;
          End;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin

        if intFormWidth = 0 Then
        frmMsg.Width := 494;

        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3)
          Else
          Left       := 18;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + intWidBut + 1
          Else
          Left       := 166;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsg) Do
        Begin
          parent     := pnlBotoes;

          If intWidBut <> 0 Then
            Left := ((frmMsg.Width - (intWidBut*3) ) Div 3) + (intWidBut * 2) + 1
          Else
          Left       := 314;

          Top        := 05;
          Height     := BtnHeight;

          If intWidBut = 0 Then
            Width      := 146
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMsg.pOnclick;
        End;
      End;
    End;

    frmMsg.intFocus     := intFocoBotao;
    frmMsg.blnSaiComEsc := blnSaiComEsc;
    frmMsg.blnObrigaEsc := blnObrigaEsc;
    frmMsg.blnOcultPainelBtn := blnOcultPainelBtn;

   Try
     {$IFDEF TESTABILIDADE_AUTCOM}
     TTestabilidade.fGetTestabilidade.SetConteudoMensagem(strTexto);
     {$ENDIF}
   Except
     //
   End;

   frmMsg.ShowModal;
   Result := frmMsg.intRetorno;

   Try
    {$IFDEF TESTABILIDADE_AUTCOM}
     TTestabilidade.fGetTestabilidade.SetConteudoMensagem('');
     {$ENDIF}
   Except
     //
   End;

  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[fMensagem]');
    End;
  End;

  pFreeAndNil(frmMsg);
  FreeAndNil(fntFonte);

end;
{$ENDIF}

Procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);
Begin
  fMensagem('', strMensagem, ['&Ok'],
            1,     //         inStFocoBotao: Integer = 1;
            False, //         blnSaiComEsc: Boolean = False;
            1,     //         intEstFon: Integer = 1;
            0,     //         intWidBut: Integer = 0;
            False, //         blnAutosize: Boolean = False;
            0,     //         intSomarTop: Integer=0;
            False, //         blnObrigaEsc: Boolean = False;
            False, //         blnOcultPainelBtn: Boolean = False;
            False, //         blnBtnSemImg : Boolean = False;
            intHeight,     //         intHeightOpc: Integer = 0;
            intWidth);
End;

function fPergunta(strMensagem: String): Boolean;
begin
  Result := fMensagem('', strMensagem, ['&Sim', '&N„o']) = 1;
end;

{********************************************}
{* UMA MANEIRA DIFERENTE DO FREEANDNIL PARA *}
{* LIBERAR FORMUL¡RIOS DA MEM”RIA           *}
{*****************************************AF*}
procedure pFreeAndNil(var frmForm);
Begin
  If Not Assigned(TForm(frmForm)) Then
    Exit;

  Try
    FreeAndNil(frmForm);
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pFreeAndNil > FreeAndNil');
  End;

  Try
    pTrimAppMemorySize;
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pFreeAndNil > pTrimAppMemorySize Exception');
  End;

  Try
    Application.ProcessMessages;
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pFreeAndNil > Application.ProcessMessages;');
  End;
End;

function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;
  Var
    c: Char;
begin
  Result := '';
  for c in strTexto do
    if (c <> chrFrom) then
      Result := Result + c
    Else If chrTo <> #0 Then
      Result := Result + chrTo;
end;

function fTiraEnter(strTexto: String): String;
begin
  Result := strTexto;
  Result := fTrocaCaracter(Result, #13, ' ');
  Result := fTrocaCaracter(Result, #10, ' ');
  Result := Trim(Result);
end;

function fTiraEspacos(strTexto: String): String;
begin
  Result := fTrocaCaracter(strTexto, ' ', #0);
end;

function fTrimAll(strTexto: String): String;
  Var
    c: Char;
    l: Char;
begin
  l := #0;
  Result := '';

  for c in strTexto do
  begin
    if (c = ' ') and (l = ' ') then
      continue;
    l := c;
    Result := Result + c;
  end;

  Result := Trim(Result);
end;


{**************************************}
{* ADICIONA DADOS EM UMA MATRIZ       *}
{***********************************WI*}
{$IFNDEF LINUX}
procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False);
Begin
  If (Pos(#13#10, strTexto) > 0) And blnConsiderarEnter Then
  Begin
    While Pos(#13#10, strTexto) > 0 Do
    Begin
      SetLength(arrAdd, Length(arrAdd) + 1);

      arrAdd[High(arrAdd)] := LeftStr(strTexto, Pos(#13#10, strTexto) -1);
      strTexto := Copy(strTexto, Pos(#13#10, strTexto) + 2, Length(strTexto));

      If Pos(#13#10, strTexto) <= 0 Then
      Begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[High(arrAdd)] := strTexto;
      End;
    End;
  End
  Else
  Begin
    SetLength(arrAdd, Length(arrAdd) + 1);
    arrAdd[High(arrAdd)] := strTexto;
  End;
End;
{$ENDIF}

procedure pAddDados(Var arrAdd : TArray<String>; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
Begin
  If (Pos(#13#10, strTexto) > 0) And blnConsiderarEnter Then
  Begin
    While Pos(#13#10, strTexto) > 0 Do
    Begin
      SetLength(arrAdd, Length(arrAdd) + 1);

      arrAdd[High(arrAdd)] := LeftStr(strTexto, Pos(#13#10, strTexto) -1);
      strTexto := Copy(strTexto, Pos(#13#10, strTexto) + 2, Length(strTexto));

      If Pos(#13#10, strTexto) <= 0 Then
      Begin
        SetLength(arrAdd, Length(arrAdd) + 1);
        arrAdd[High(arrAdd)] := strTexto;
      End;
    End;
  End
  Else
  Begin
    SetLength(arrAdd, Length(arrAdd) + 1);
    arrAdd[High(arrAdd)] := strTexto;
  End;
end;

{**************************************}
{*  VERIFICA SE UMA STRING ESTA VAZIA *}
{***********************************MV*}
function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
begin
  If blnTiraCaracEspecial Then
    strString := fTiraCaracEspeciais(strString, True, True, True, True, True);

  Result := False;
  strString := fTiraEnter(strString);

  If fTiraEspacos(strString) = '' Then
    Result := True;
end;

function fRetornaWordWrapText(strTexto: String; intColunas: Integer): String;
Var
  LSL: TStringList;
begin
  LSL := fRetornaWordWrap(strTexto, intColunas);
  Try
    Result := LSL.Text;
  Finally
    FreeAndNil(LSL);
  End;
end;

function fRetornaWordWrap(strTexto: String; intColunas: Integer): TStringList;
  Var
    intColAtu: Integer;
    intIndice: Integer;
    intTamStr: Integer;
    strBuffer: String;
    strLinha: String;
begin

  Result := TStringList.Create;
  intIndice := 1;
  intColAtu := 1;
  strLinha  := '';
  intTamStr := Length(strTexto);

  While (intIndice <= intTamStr) Do
  Begin

    If (intColAtu <= intColunas) Then
    Begin
      If (strTexto[intIndice] = ' ') Or
         (strTexto[intIndice] = #13) Or
         (intIndice = intTamStr)     Then
      Begin
        strLinha := strLinha + strBuffer;
        strBuffer := '';

        If (strTexto[intIndice] = #13) Then
        Begin
          intColAtu := 0;
          Result.Add(strLinha);
          strLinha := '';
        End
        Else
          strLinha := strLinha + strTexto[intIndice];

        If (strTexto[intIndice+1] = #10) Then
        Begin
          Inc(intIndice);
        End;
      End
      Else
        strBuffer := strBuffer + strTexto[intIndice];
    End
    Else
    Begin
      strBuffer := strBuffer + strTexto[intIndice];
      Result.Add(strLinha);
      strLinha := '';
      intColAtu := Length(strBuffer);
    End;

    Inc(intIndice);
    Inc(intColAtu);
  End;

  If (Not fEmptyStr(strLinha)) Then
    Result.Add(strLinha);

end;

{**********************************************************}
{* LÍ/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes_local.ini';

  iniArqIni := TIniFile.Create(strNomArq {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;
{$IFDEF LINUX}
begin
  Result := EmptyStr;
end;
{$ELSE}
  Var
    BufferSize, Len: Integer;
    Buffer : PChar;
    Translate, Return: Pointer;
    LoCharSet, HiCharSet : Word;
    Dummy: Cardinal;
    StrFileInfo: String;
begin
  Result := '';

  If (fEmptyStr(strNomArq)) Then
  Begin
    strNomArq := Application.ExeName;
  End;

  If (Not FileExists(strNomArq)) Then
    Exit;

	BufferSize := GetFileVersionInfoSize(PWideChar(strNomArq), Dummy);

	If BufferSize <> 0 Then
  Begin
  	GetMem(Buffer, Succ(BufferSize));

  	Try
	  	If GetFileVersionInfo(PChar(strNomArq), 0, BufferSize,Buffer) Then
		  Begin
			  If VerQueryValue(Buffer, '\VarFileInfo\Translation', Translate, UINT(Len)) Then
			  Begin
				  LoCharSet := LoWord(Longint(Translate^));
				  HiCharSet := HiWord(Longint(Translate^));
          If blnProductVersion Then
            StrFileInfo := Format('\StringFileInfo\0%x0%x\%s',[LoCharSet, HiCharSet, 'ProductVersion'])
          Else
            StrFileInfo := Format('\StringFileInfo\0%x0%x\%s',[LoCharSet, HiCharSet, 'FileVersion']);
          If VerQueryValue(Buffer,PChar(StrFileInfo), Return, UINT(Len)) Then
          Begin
            Result := PChar(Return);
          End;
        End;
      End;
    Finally
		  FreeMem(Buffer, Succ(BufferSize));
	  End;

  End;
end;
{$ENDIF}

{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
procedure pAbrirBanco(Database: TUniConnection);
  Var
    qryGen: TUniQuery;
    intCodAut: Integer;
    blnReconectar: Boolean;

    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;

  {******************************************************************************}
  {* QUANDO O AUTCOM … EXECUTADO ATRAV…S DO AGENDADOR DE TAREFAS, A FUN«√O:     *}
  {* FileExists('libUtil.dll') N√O FUNCIONA, RETORNA QUE N√O ENCONTRA O ARQUIVO,*}
  {* POR ISSO SE FAZ NECESS¡RIO PASSAR O CAMINHO COMPLETO! REQ: 21251           *}
  {***************************************************************************RN*}
  function fPathExe: String;
  begin
    Result := ExtractFilePath(Application.ExeName);
  end;

  {*****************************************}
  {* VERIFICA SE IR¡ UTILIZAR A SENHA DA   *}
  {* DLL.                                  *}
  {**************************************MV*}
  function fUsarSenhaDLL: Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(fPathExe + 'libUtil.dll'));
  end;

  {*****************************************}
  {* EFETUA A CONEX√O COM O BANCO.         *}
  {**************************************MV*}
  procedure pConectar;
  begin
    Database.Disconnect;
    Database.Database := '';
    Database.Server   := '';

    If fUsarSenhaDLL Then
    Begin
      libUtil := LoadLibrary(PChar(fPathExe + 'libUtil.dll'));

      fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
      fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

      Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
      Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

      FreeLibrary(libUtil);
    End
    Else
    Begin
      Database.Username := 'root';
      Database.Password := 'citel13347';
    End;

    If fExecutandoPeloPortal Then
    Begin
      fArqIni(1,'BANCO','NUMIP' ,ParamStr(1));
      fArqIni(1,'BANCO','NOMBAN',ParamStr(2));
      fArqIni(1,'BANCO','PORTA' ,ParamStr(3));
    End;

    Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP',''), ' ', '');
    Database.Database := fArqIni(0,'BANCO','NOMBAN','');

    If Not fEmptyStr(fArqIni(0,'BANCO','PORTA','')) Then
      Database.Port := StrToInt(AnsiReplaceStr(fArqIni(0,'BANCO','PORTA','3306'), ' ', ''));

    Database.Connect;
  End;

  {*****************************************}
  {* MOSTRA MSG DE ERRO.                   *}
  {**************************************MV*}
  procedure pMsgErro(E: Exception);
  begin
   {$IFDEF LINUX}
    raise EDatabaseError.Create('Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!');
   {$ELSE}
    fMensagem('Aviso', 'Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!', ['&Ok']);
    fMensagem('Aviso', 'Sua aplicaÁ„o ser· fechada agora', ['&Ok']);
    Application.Terminate;
   {$ENDIF}
  end;

begin
  blnReconectar := False;
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0'), 0);

  Try
    pConectar;
  Except
    On E: EUniError Do
    Begin

      {*****************************************}
      {* N√O CONECTOU POIS A SENHA ESTAVA      *}
      {* INCORRETA. VAI TENTAR COM OUTRA SENHA *}
      {**************************************MV*}
      If E.ErrorCode = ERROR_USUARIO_SENHA_INV Then
      Begin
        blnReconectar := True;
        If intCodAut = 0 Then
        Begin
          intCodAut := 1;
        End;
      End
      Else If E.Message.ToLower.Contains('client does not support authentication') Then
      Begin
        blnReconectar := True;
        If intCodAut = 0 Then
        Begin
          intCodAut := 1;
        End;
      End
      Else
      Begin
        pMsgErro(E);
        Exit;
      End;

    End;

    On E : Exception Do
    Begin
      pMsgErro(E);
      Exit;
    End;
  End;

  {*****************************************}
  {* A SENHA ESTAVA INCORRETA IR¡ TENTAR   *}
  {* COM A OUTRA SENHA.                    *}
  {**************************************MV*}
  If blnReconectar Then
  Begin
    Try
      pConectar;
    Except
      On E: Exception Do
      Begin
        pMsgErro(E);
        Exit;
      End;
    End;

  End;

  qryGen := fCriaQuery;

  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SET character_set_connection = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_client = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_database = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_results = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET character_set_server = LATIN1');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_connection = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_database = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET collation_server = latin1_swedish_ci');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET sql_mode = ""');
      ExecSQL;

      SQL.Clear;
      SQL.Add('SET group_concat_max_len = 3072');
      ExecSQL;
    End;

  Except
    On E : Exception Do
    Begin
     {$IFDEF LINUX}
      raise;
     {$ELSE}
      pMensagensErro(E.Message, '[pAbrirBanco]');
      fMensagem('Aviso', 'Sua aplicaÁ„o ser· fechada agora', ['&O k']);
      Application.Terminate;
     {$ENDIF}
    End;
  End;

  FreeAndNil(qryGen);
end;

{************************************}
{* Fechar Banco de Dados do Sistema *}
{*********************************DV*}
procedure pFecharBanco(Database: TUniConnection);
begin
  Try
    If Database.InTransaction = True Then
      Database.Rollback;

    Database.Disconnect;
  Except
    On E : Exception do
    Begin
      pMensagensErro(E.Message, '[pFecharBanco]');
	    //pErro(E.Message);
    End;
  End;
end;

{*********************************************}
{* FUNCAO PARA CRIAR QUERY E RETER OS CAMPOS *}
{******************************************PH*}

function fRetDescricaoMatrizAliquotasIcms(strCodMat: String): String;
begin
  Result := fCampoTabela('ICM_DESCRI', 'MATICM', ['ICM_CODMAT'], [strCodMat], False);
end;
function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  Var
    intCont: Integer;
begin
  Result := fCriaQuery(AOwner);
  Result.SQL.Text := strSQL;
  Result.Open;
  Result.Close;

  For intCont := 0 To Result.FieldDefs.Count - 1 Do
  Begin
    Result.FieldDefs[intCont].CreateField(Result);
  End;
end;

function fTamCodLse: Integer;
Var
  strSQL: String;
  qryGen: TUniQuery;
  intPosInicial, intQtde: Integer;
begin

  Result := VS_intTamCadLse;

  If VS_intTamCadLse > 0 Then
    Exit;

  Try

    qryGen := fCriaQuery;

    strSQL := 'DESC CADLSE;';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While (Not Eof) Do
      Begin
        If FieldByName('Field').asString = 'LSE_CODIGO' Then
        Begin
          intPosInicial := Pos('(',FieldByName('Type').asString)+1;
          intQtde       := Pos(')',FieldByName('Type').asString) - intPosInicial;
          Result        := StrToInt( Copy( FieldByName('Type').asString, intPosInicial, intQtde ) );
          VS_intTamCadLse := Result;
          Break;
        End;
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

{**************************************}
{* CRIA UMA QUERYNOVA PARA SER USADA  *}
{* PS. ATE QUE ENFIM ALGUEM FEZ ISSO  *}
{***********************************AF*}
function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
Begin

  Result := TUniQuery.Create(AOwner);

  If Assigned(Conexao) Then
    Result.Connection := Conexao
  Else
  {$IFDEF LINUX}
    Result.Connection := TUniConnection(objConnectionsManager.CurrentConnection.GetObject);
  {$ELSE}
    Result.Connection := frmModulo.GetCurrentConnection;
  {$ENDIF}

  Result.Tag := Result.Connection.Tag;
  Result.Options.RequiredFields := False;

 {$IFNDEF LINUX}
  If Assigned(VS_objTraceViewer) Then
    VS_objTraceViewer.SetQueryEvents(Result);
 {$ENDIF}
End;

function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  Var
    intContador: Integer;
begin

  For intContador := 1 To Length(strString) Do
  Begin
    If strString[intContador] = chrBusca Then
    Begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := intContador;
    End
  End;

end;

{*******************************************}
{* ANALISA A MENSAGEM DE ERRO E RETORNA UM *}
{* C”DIGO DE ERRO CORRESPONDENTE           *}
{****************************************MV*}
function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  Var
    arrPosicoes: TIntArray;
begin

  arrPosicoes := fPosicoes(strErrorMessage, #39);

  If (Pos('Unknown database', strErrorMessage) > 0) Then
  Begin
    Result := ERR_UNKNOW_DATABASE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1] - arrPosicoes[0]);
  End
  Else If (Pos('Access denied for user', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ACCESS_DENIED;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[1], arrPosicoes[3] - arrPosicoes[1]);
  End
  Else If (Pos('Table', strErrorMessage) > 0) And (Pos('doesn'#39't exist', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_NOT_EXIST;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If ((Pos('Field', strErrorMessage) > 0) And (Pos('not found', strErrorMessage) > 0)) OR
          ((Pos('Coluna', strErrorMessage) > 0) And (Pos('desconhecida', strErrorMessage) > 0)) Then
  Begin
    Result := ERR_FIELD_NOT_FOUND;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Operation is not allowed in READ ONLY mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('Cannot modify a read-only dataset', strErrorMessage) > 0) Then
  Begin
    Result := ERR_TABLE_READONLY;
  End
  Else If (Pos('not a valid integer value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_INT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid date', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_DATE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('not a valid floating point value', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_VALID_FLOAT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Dataset not in edit or insert mode', strErrorMessage) > 0) Then
  Begin
    Result := ERR_NOT_IN_EDIT;
  End
  Else If (Pos('You have an error in your SQL syntax', strErrorMessage) > 0) Then
  Begin
    Result := ERR_SQL_SYNTAX;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Can'#39't connect to local MySQL server through socket', strErrorMessage) > 0) Then
  Begin
    Result := ERR_BD_NOT_ACTIVE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Column', strErrorMessage) > 0) And (Pos('cannot be null', strErrorMessage) > 0) Then
  Begin
    Result := ERR_FIELD_NOT_NULL;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Duplicate entry', strErrorMessage) > 0 ) And (Pos('for key', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('duplicado', strErrorMessage) > 0 ) Or (Pos('duplicate', strErrorMessage) > 0) Then
  Begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('Unknown column', strErrorMessage) > 0) And (Pos('order clause', strErrorMessage) > 0) Then
  Begin
    Result := ERR_ORDER_BY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  End
  Else If (Pos('There is no default printer currently selected', strErrorMessage) > 0) Then
  Begin
    Result := ERR_DEFAULT_PRINTER;
    strInfoAdicional := '';
  End
//#################################################
  Else If (Pos('linha pai', strErrorMessage) > 0) And (Pos('chave estrangeira', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
  Else If (Pos('parent row', strErrorMessage) > 0) And (Pos('foreign key', strErrorMessage) > 0) Then
  Begin
    Result := ERROR_FOREIGN_KEY_DELETE;
    strInfoAdicional := '';
  End
//#################################################
  Else
    Result := ERR_UNKNOW_ERROR;
end;

{****************************************}
{*   Exibe Mensagens de Erro do Banco   *}
{*************************************DV*}
procedure pErro(Mensagem:String);
begin
 {$IFDEF LINUX}
  raise Exception.Create(Mensagem);
 {$ELSE}
  HandleException;
 {$ENDIF}
end;

{*******************************************}
{*   Verifica Mensagens de Erro do Banco   *}
{****************************************DV*}
procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
  Var
    NrErro: Integer;
    strInfo: String;
begin
  fRollBack;
  NrErro := fParseError(MensErro, strInfo);

  Case NrErro Of
    ERR_UNKNOW_ERROR         :pErro(MensErro + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_UNKNOW_DATABASE      :pErro(strInfo + ': Banco de dados inexistente' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ACCESS_DENIED        :pErro('Accesso negado ao usu·rio ' + strInfo + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_NOT_EXIST      :pErro('Tabela ' + strInfo + ' n„o Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_FOUND      :pErro('Campo ' + strInfo + ' n„o Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_READONLY       :pErro('OperaÁ„o n„o suportada no modo Somente Leitura!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_INT        :pErro(strInfo + ' n„o È um n˙mero inteiro v·lido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_DATE       :fMensagem('ATEN«√O!',strInfo + ' n„o È uma data v·lida!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem, ['&OK']);
    ERR_NOT_VALID_FLOAT      :pErro(strInfo + ' n„o È um n˙mero v·lido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_IN_EDIT          :pErro('Tabela n„o est· em modo de EdiÁ„o!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_SQL_SYNTAX           :pErro('H· um erro de Sintaxe no SQL: ' + strInfo + #10 + 'Local: ' + #10 + LocalErro + #10 + strMensagem);
    ERR_BD_NOT_ACTIVE        :pErro('O Servidor de banco de dados n„o est· ativo!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_NULL       :pErro('O campo ' + strInfo + ' È de preenchimento obrigatÛrio!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_PRIMARY_KEY          :pErro(strInfo + ': valor duplicado n„o permitido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ORDER_BY             :pErro('Coluna ' + strInfo + ' desconhecida no processo de ordenaÁ„o!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERROR_FOREIGN_KEY_DELETE :Begin
                                pGravarErro(True, '[ERROR_FOREIGN_KEY_DELETE] - N„o È possÌvel excluir esse registro', MensErro + sLineBreak + fRetornaInformacaoUltimoErroForeignKey());
                                fMensagem('ATEN«√O!', 'N„o È possÌvel excluir esse registro, pois existe movimentaÁ„o para o mesmo.', ['&O k']);
                              End;
    ERR_DEFAULT_PRINTER      :fMensagem('ATEN«√O!', 'N„o h· impressora padr„o selecionada!', ['&O k']);
  End;

end;

{*************************************************}
{*   Grava Mensagens de Erro no Arquivo de LOG   *}
{**********************************************DV*}
procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; conexao: TUniConnection = nil);
  Var
    qryLogErr: TUniQuery;
begin
  If GravarErro Then
  Begin
//    If fStartTransaction Then
//    Begin

      qryLogErr := fCriaQuery(Nil, conexao);
      qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

      Try
        With qryLogErr Do
        Begin
          Open;
          Insert;
          FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
          FieldByName('LOG_LOGOPE').AsString   := strLoginUsuarioLogado;
          FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
          FieldByName('LOG_HORERR').AsDateTime := fTime();
          FieldByName('LOG_DESCRI').AsString   := MensagemErro;
          If Not fEmptyStr(strRelatorio) Then
            FieldByName('LOG_RELERR').AsString   := strRelatorio;
          Post;
  //        fCommit;
          Close;
        End;
      Finally
        FreeAndNil(qryLogErr);
      End;
    //End;
  End;
end;

function fRetornaInformacaoUltimoErroForeignKey: String;
var
  strRetInnoDB: String;
begin
  Result := fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);
end;

function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String;
{$IFDEF LINUX}
begin
  Result := EmptyStr;
end;
{$ELSE}
  Var
    objInnoDB: TINNODBStatus;
Begin

  With frmModulo Do
  Begin
    objInnoDB := TINNODBStatus.Create(Nil, Database.Database, Database.Username,
                                           Database.Password, IntToStr(Database.Port),
                                           Database.Server);
    Result := objInnoDB.fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);
    FreeAndNil(objInnoDB);
  End;

End;
{$ENDIF}

function fRetornaInformacaoUltimoDeadlock: String;
  Var
    strRetInnoDB: String;
Begin
  fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);
  Result := MidStr(strRetInnoDB, 1, Pos('*** WE ROLL BACK TRANSACTION ', strRetInnoDB) + 32);
End;

function fTabelaVazia(strNomeTabela: string; blnSempreLerBanco: Boolean = True): Boolean;
begin
  Result := fCampoTabela('"1"', strNomeTabela, [],[], blnSempreLerBanco) <> '1';
end;

function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('DESC ' + strTabela);
  qryAux.Open;

  Result := False;
  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = strCampo Then
    Begin
      Result := True;
      Break;
    End;

    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;

{*******************************}
{* REPLICA UM CARACTAR N VEZES *}
{****************************DV*}
function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
	Var
  	intContador : Integer;
begin
	Result:= '';
  For intContador := 1 To intTamanho Do
  Begin
  	Result := Result + strRepl;
  End;
end;

function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
begin

  Result := False;

  If Pos('CONSUMIDOR', strNomCli) > 0 Then
    Result := True;

  If blnCliBal Then
  Begin

    If Pos('BALCAO', strNomCli) > 0 Then
      Result := True

    Else If Pos('BALC√O', strNomCli) > 0 Then
      Result := True;

  End;

  If blnSeguradora And (Pos('SEGURADORA', strNomCli) > 0) Then
    Result := True;

end;


function fRetNomeEmpresa(strCodEmp: String): String; overload;
begin
  Result := '';

  If (fEmptyStr(strCodEmp)) Then
    Exit;

  Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False);
End;

procedure pDestravarTodosLocksConexaoAtual(blnTestarOrigem: Boolean = False; conexao: TUniConnection = nil);
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Nil, conexao);

    If blnTestarOrigem Then
    Begin
      fStartTransaction(conexao);

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM LCKATC WHERE LCK_NUM_IP = :NUM_IP AND LCK_CON_ID = :CON_ID');
      qryAux.SQL.Add(' AND (IFNULL(LCK_ORIGEM, "") = "")');
      qryAux.ParamByName('NUM_IP').AsString := GetIPAddressAsString;
      qryAux.ParamByName('CON_ID').AsString := fGetConnectionID;
      qryAux.ExecSQL;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM LCKATC WHERE');
      qryAux.SQL.Add(' ((IFNULL(LCK_ORIGEM, "") <> "") AND (LCK_QTDTRA <= 0))');
      qryAux.ExecSQL;

      fCommit(conexao);
    End Else
    Begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM LCKATC WHERE LCK_NUM_IP = :NUM_IP AND LCK_CON_ID = :CON_ID');
      qryAux.ParamByName('NUM_IP').AsString := GetIPAddressAsString;
      qryAux.ParamByName('CON_ID').AsString := fGetConnectionID;
      qryAux.ExecSQL;
    End;

  Except
    On E: Exception Do
    Begin
      If blnTestarOrigem Then
        fRollBack(conexao);
      pMensagensErro(E.Message, '[pDestravarTodosLocksConexaoAtual]');
    End;
  End;

  FreeAndNil(qryAux);
end;

{******************************}
{* RETORNA O NOME DO OPERADOR *}
{***************************AF*}
function fRetNomeOperador(strCodOpe: String): String;
Begin
  Result := fCampoTabela('OPE_NOMOPE', 'CADOPE', ['OPE_CODOPE'], [strCodOpe], False);
End;

{***********************************************************}
{* RETORNA O NOME DA TRANSPORTADORA DE ACORDO COM O C”DIGO *}
{********************************************************AF*}
function fRetNomTransportadora(strCodTra: String): String;
  Var
    strSQL   : String;
    qryGenTra: TUniQuery;

Begin
  Try

    qryGenTra := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADTRA ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRA_CODTRA = :CODTRA ';

    With qryGenTra Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODTRA').AsString := strCodTra;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('TRA_NOMTRA').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTra);
  End;

End;

{$IFDEF LINUX}
// Conexao avulsa no dicionario do objConnectionsManager. Duas regras, ambas aprendidas
// num AV em producao (30/09/2026, "as TUniConnection" em pConectaAutoincrem):
//  - a tag precisa ser unica entre as vivas. Com tag repetida, BeginConnection devolve o
//    wrapper antigo em vez de criar um novo; e tag 0 significa "conexao da thread".
//  - o TUniDacConnection e o dono do TUniConnection. Quem pegou o objeto por GetObject
//    nao o libera: devolve a tag com pLiberarConexaoAvulsa, e o wrapper libera o objeto.
//    FreeAndNil no objeto deixava o wrapper vivo no dicionario com ponteiro pendurado.
// FindConnection + BeginConnection nao e atomico (duas entradas no FLock) e Random nao e
// thread-safe. Vale porque o robo PIX tem uma thread so; se esta unit for usada com varias
// threads, a busca da tag livre precisa ir para dentro do manager.
function fCriarConexaoAvulsa(out ATag: NativeUInt): IConnection;
var
  LExistente: IConnection;
begin
  repeat
    ATag := NativeUInt(Random(999999)) + 1;
  until Not objConnectionsManager.FindConnection(ATag, LExistente);
  Result := objConnectionsManager.BeginConnection(ATag);
end;

procedure pLiberarConexaoAvulsa(var AConexao: IConnection; const ATag: NativeUInt);
begin
  AConexao := nil;
  If ATag > 0 Then
    objConnectionsManager.EndConnection(ATag);
end;
{$ENDIF}

{$IFNDEF LINUX}
// Sem ramo LINUX de proposito: la a conexao precisa da tag para ser devolvida ao manager,
// e esta assinatura a descartaria. No LINUX use fCriarConexaoAvulsa.
function fCriarConexao: TUniConnection;
begin
  Result := TUniConnection.Create(Nil);
  Result.ProviderName := frmModulo.Database.ProviderName;
  Result.Username := frmModulo.Database.Username;
  Result.Password := frmModulo.Database.Password;
  Result.Server := frmModulo.Database.Server;
  Result.Database := frmModulo.Database.Database;
  Result.Port := frmModulo.Database.Port;
  Result.LoginPrompt := False;
  Result.AfterConnect := TModuloEvents.AfterConnect;
  Result.DefaultTransaction.IsolationLevel := frmModulo.Database.DefaultTransaction.IsolationLevel;
  Result.PoolingOptions.MaxPoolSize := TDefaultPoolingOptions.MaxPoolSize;
  Result.PoolingOptions.MinPoolSize := TDefaultPoolingOptions.MinPoolSize;
  Result.PoolingOptions.Validate := TDefaultPoolingOptions.Validate;
  Result.PoolingOptions.ConnectionLifetime := TDefaultPoolingOptions.ConnectionLifetime;
  Result.Pooling := TDefaultPoolingOptions.Pooling;
end;
{$ENDIF}

function fGetSelectProcodDoArquivoForUpdate : String;
begin
  Result := EmptyStr;
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  PRO_CODSEQ AS CODSEQ, ';
  Result := Result + '  PRO_TAMCOD AS TAMCOD, ';
  Result := Result + '  PRO_SEQEMP AS SEQEMP  ';
  Result := Result + 'FROM ';
  Result := Result + '  PROCOD ';
  Result := Result + 'WHERE ';
  Result := Result + '  PRO_NOMARQ = :NOMARQ ';
  Result := Result + ' FOR UPDATE ';
end;

function fGetUpdateProcodDoArquivo : String;
begin
  Result := '';
  Result := Result + ' UPDATE ';
  Result := Result + '   PROCOD ';
  Result := Result + ' SET ';
  Result := Result + '   PRO_CODSEQ = :CODSEQ ';
  Result := Result + ' WHERE ';
  Result := Result + '   PRO_NOMARQ = :NOMARQ ';
end;

function fAtualizaProCod(const strNomeTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod: Integer = 1; LConn: TUniConnection = nil): String;//>Compatibilidade
begin
  Result := fAtualizaProCod(strNomeTabela, intQtdCod, LConn);
end;

{**************************************************}
{* PEGA O PROXIMO CODIGO E ATUALIZA TABELA PROCOD *}
{* ADICIONADO UM PAR¬METRO PARA ATUALIZAR UMA SE- *}
{* QU NCIA DE C”DIGOS                             *}
{********************************************MV*AJ*}
function fAtualizaProCod(const strNomeTabela: String; const intQtdCod: Integer = 1; LConn: TUniConnection = nil): String;
  Var
    strSQL        : String;
    intCodigoAtual: Int64;
    intTamCodigo  : Integer;
    blnComita     : Boolean;
    qryGenCod     : TUniQuery;
    intContador   : integer;
    strCodAux     : String;
    blnCodPorEmpresa: Boolean;
begin
  if not assigned(LConn) then
  {$IFDEF LINUX}
    LConn := TUniConnection(objConnectionsManager.CurrentConnection.GetObject);
  {$ELSE}
    LConn := frmModulo.GetCurrentConnection;
  {$ENDIF}

  pValidaProCod(strNomeTabela);

  qryGenCod := fCriaQuery(Nil, LConn);

  blnComita := False;

  If Not LConn.InTransaction Then
  Begin
    fStartTransaction(LConn);
    blnComita := True;
  End;

  Try

    strSQL := fGetSelectProcodDoArquivoForUpdate;

    With qryGenCod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;

      If IsEmpty Then
      Begin
        Close;

        For intContador := 0 To Length(arrProCod) - 1 Do
        Begin
          If (strNomeTabela = arrProCod[intContador].strNomArq)  Then
          Begin
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROCOD');
            Open;
            Insert;
            FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
            FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
            FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
            FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
            FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
            FieldByName('PRO_CODAUT').AsString  := 'S';
            Post;
            Close;

            SQL.Clear;
            SQL.Add(' SELECT * FROM PROINC WHERE PRO_NOMARQ = :NOMARQ');
            ParamByName('NOMARQ').AsString := arrProCod[intcontador].strNomArq;
            Open;
            If IsEmpty Then
            Begin
              Insert;
              FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
              FieldByName('PRO_AUTINC').AsString  := '1';
              FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
              Post;
            End;

            Close;
            Break;
          End;
        End;

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;
        If IsEmpty Then
        Begin
          Close;
          Raise Exception.Create('A tabela ' + strNomeTabela + ' n„o est· cadastrada ' +
                                 'na tabela de PrÛximos Codigos! Verifique.' + #13#10);
        End;
      End;

      intCodigoAtual := StrToInt64(FieldByName('CODSEQ').AsString);
      intTamCodigo   := FieldByName('TAMCOD').AsInteger;
      blnCodPorEmpresa := (FieldByName('SEQEMP').AsString = 'S');
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      If blnComita Then
        fRollBack(LConn);
      Raise ExceptClass(E.ClassType).Create('N„o consegui pegar o proximo sequencial de ' + strNomeTabela +
       ' em PROCOD. Tente novamente! ' + sLineBreak + '[' + E.Message + ']');
    End;
  End;

  strSQL := fGetUpdateProcodDoArquivo;

  With qryGenCod Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    strCodAux := fPadL(IntToStr(intCodigoAtual+intQtdCod), intTamCodigo-3, '0');
    strCodAux := strCodAux + VS_strCodEmp;
    ParamByName('CODSEQ').AsString := fPadL(IntToStr(intCodigoAtual+intQtdCod), intTamCodigo, '0');
    ParamByName('NOMARQ').AsString := strNomeTabela;
      ExecSQL;
    Close;
  End;

  Result := IIF(blnCodPorEmpresa, strCodAux, fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0'));

  If blnComita Then
    fCommit(LConn);

  FreeAndNil(qryGenCod);
end;

function fFormataAutInc(intAutInc: Int64; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnUsaTransacaoCorrente: Boolean = False; conexao: TUniConnection = nil): String; overload;
begin
  Result := __fRetAutoIncrem__(strNomeTabela, strCodEmp, intIntervalo);
end;

function __fRetAutoIncrem__(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
  Var
    intAutIncAtu: Int64;

    strSQL,
    strProEmp: String;
    qryGenCod: TUniQuery;

   {$IFDEF LINUX}
    LICon: IConnection;
    LTag: NativeUInt;
   {$ENDIF}
    LConn: TUniConnection;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;

    begin
      qryGenTmp := nil;
      Try

        qryGenTmp := fCriaQuery(nil, LConn);

        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM '+
                  '  FROM ' + strNomeTabela +
                  ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp, strProEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        FreeAndNil(qryGenTmp);
      End;

    end;

    function fGetUltAutIncPROCOD: Int64;
      Var
        strTmp: String;
        qryTmp: TUniQuery;
    Begin
      Result := 0;

      strTmp := '';
      strTmp := strTmp + ' SELECT ';
      strTmp := strTmp + '   MAX(MID(AUTOINCREM, 4, 14)) AUTINC ';
      strTmp := strTmp + ' FROM ';
      strTmp := strTmp + '   PROCOD ';
      strTmp := strTmp + ' WHERE ';
      strTmp := strTmp + '   PRO_CODEMP = "' + VS_strCodEmp + '" ';

      // No Linux o pMensagensErro relanca (pErro faz raise), entao o FreeAndNil
      // precisa estar num Finally para nao vazar a query a cada falha de banco.
      qryTmp := nil;
      Try
        Try
          qryTmp := fCriaQuery(nil);

          With qryTmp Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strTmp);
            Open;

            If Not IsEmpty Then
              Result := FieldByName('AUTINC').AsLargeInt
            Else
              Result := 1;
          End;
        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[fGetUltAutIncPROCOD]');
        End;
      Finally
        FreeAndNIl(qryTmp);
      End;
    End;
begin

  If Pos(strNomeTabela, 'PROCOD_PROINC') <= 0 Then
    pValidaProCod(strNomeTabela);

 {$IFDEF LINUX}
  LICon := fCriarConexaoAvulsa(LTag);
  LConn := LICon.GetObject as TUniConnection;
 {$ELSE}
  LConn := fCriarConexao;
 {$ENDIF}
  qryGenCod := nil;
  Try
    LConn.Connect;

    qryGenCod := fCriaQuery(nil, LConn);
    Repeat
      LConn.StartTransaction;
      Try

        strSQL := '';
        strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
        strSQL := strSQL + '  PRO_AUTINC AS AUTINC  ';
        strSQL := strSQL + 'FROM ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
        strSQL := strSQL + ' FOR UPDATE ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          Open;

          If IsEmpty Then
          Begin
            If SameText(strNomeTabela, 'PROCOD') Then
            Begin
              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROCOD');
              Open;

              Insert;
              FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
              FieldByName('PRO_CODSEQ').AsString  := '001';
              FieldByName('PRO_TAMCOD').AsInteger := 3;
              FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
              FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
              FieldByName('PRO_CODAUT').AsString  := 'N';
              Post;

              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROINC');
              Open;

              Insert;
              FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
              FieldByName('PRO_AUTINC').AsInteger := 1;
              FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica+ fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
              Post;

              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ParamByName('NOMARQ').AsString := strNomeTabela;
              Open;
            End
            Else
            Begin
              Close;
              FreeAndNil(qryGenCod);
              Raise Exception.Create('A tabela ' + strNomeTabela + ' n„o est· cadastrada ' +
                                   'na tabela de PrÛximos Incrementos! Verifique.' + #13#10);
            End;
          End;

          strProEmp := fRetEmpresaFisica;

          If FieldByName('AUTINC').Value = Null Then
            intAutIncAtu := 1
          Else
            intAutIncAtu := FieldByName('AUTINC').AsLargeInt;

          Close;
        End;

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  PROINC ';
        strSQL := strSQL + 'SET ';

        If intIntervalo > 1 Then
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = ' + IntToStr(intIntervalo + 1)
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + ' + IntToStr(intIntervalo);

        End Else
        Begin

          If intAutIncAtu = 1 Then
            strSQL := strSQL + '  PRO_AUTINC = 2 '
          Else
            strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

        End;

        strSQL := strSQL + '  WHERE ';
        strSQL := strSQL + '    PRO_NOMARQ = :NOMARQ ';

        With qryGenCod Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NOMARQ').AsString := strNomeTabela;
          ExecSQL;
          Close;
        End;

        Result :=  strProEmp + fPadL(IntToStr(intAutIncAtu) + strCodEmp, 17, '0');

        LConn.Commit;

      Except
        On E: Exception Do
        Begin
          LConn.Rollback;
          FreeAndNil(qryGenCod);
          Raise Exception.Create(E.message + 'N„o consegui pegar o proximo sequencial. Tente novamente!');
        End;
      End;

    Until (Not fAutoIncremCadastrado);

  Finally
    // No Finally, e nao apos o Until: fAutoIncremCadastrado roda fora do Try interno
    // e, se lancar, a query vazaria.
    FreeAndNil(qryGenCod);
   {$IFDEF LINUX}
    LConn := nil;
    pLiberarConexaoAvulsa(LICon, LTag);
   {$ELSE}
    FreeAndNil(LConn);
   {$ENDIF}
  End;

end;

Function fRetEmpresaFisica(conexao: TUniConnection = nil): String;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery(nil, conexao);
    With qryGen Do
    Begin
      SQL.Text := 'SELECT PRO_CODEMP FROM PROCOD WHERE PRO_NOMARQ = "MOVGER"';
      Open;

      If IsEmpty Then
        Result := VS_strCodEmp
      Else
        Result := FieldByName('PRO_CODEMP').AsString;

      Close;

    End;
    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := VS_strCodEmp;
      pMensagensErro(E.Message, '[fRetEmpresaFisica]');
    End;
  End;
End;

{*****************************************}
{* FAZ ALINHAMENTO (PAD) ¿ ESQUERDA      *}
{**************************************WI*}
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  {Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;}

  Result := strTexto;

  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;


{*****************************************}
{* FAZ ALINHAMENTO (PAD) CENTRAL         *}
{**************************************MV*}
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intDir, intEsq: Integer;
    intContador: Integer;
begin
  If Length(strTexto) < intTamanho Then
  begin
    intTamanho := intTamanho - Length(strTexto);
    intDir := (intTamanho Div 2);
    intEsq := (intTamanho Div 2) + intTamanho Mod 2;

    Result := strTexto;
    For intContador := 1 To intDir Do
      Result := Result + strCaracter;
    For intContador := 1 To intEsq Do
      Result := strCaracter + Result;

  end
  else
    Result := Copy(strTexto,1,intTamanho);

end;

function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String;
begin
  If Length(strTexto) < intTamanhoMin Then
    Result := untFuncoesSimples.fPadR(strTexto, intTamanhoMin, strCaracter)
  Else Result := Copy(strTexto, 1, intTamanhoMax)
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) ¿ DIREITA       *}
{**************************************WI*}
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
{  Result := strTexto;
  intTamanho := intTamanho - Length(strTexto);
  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;}

  Result := strTexto;
  If Length(strTexto) < intTamanho Then
  Begin
    intTamanho := intTamanho - Length(strTexto);
  End
  Else
  Begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  End;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

{***************************************}
{* Insere Zeros ‡ frente de uma string *}
{************************************DV*}
function fStrZero(Zeros:string;Quant:integer):String;
Var
	I,Tamanho:integer;
	Aux: string;
begin
  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  For I := 1 To Tamanho Do
	If Aux[i] <> ',' Then
	  Zeros := Zeros + Aux[i];

  Tamanho := Length(Zeros);
  Aux := Zeros;
  Zeros:='';
  for I:=1 to Quant-Tamanho do
  Zeros:=Zeros + '0';
  Aux := Zeros + Aux;
  fStrZero := Aux;
end;

{***************************************}
{* Insere Zeros ‡ frente de uma string *}
{************************************MA*}
function fStrZero(Zeros:Integer;Quant:integer):String;
begin
  fStrZero := untFuncoesSimples.fStrZero(IntToStr(Zeros),Quant);
end;

function fStrZero(Zeros:Int64; Quant:integer): String;
begin
  fStrZero := untFuncoesSimples.fStrZero(IntToStr(Zeros),Quant);
end;

//**************************************//
// RETORNA NOME DE TABELA               //
//***********************************WI*//
function fRetornaNomeTabela(strString: String): String;
  Var
    strTmp     : String;
    intPosicao : Integer;
    intContador: Integer;
Begin
  strString := AnsiUpperCase(Trim(strString));

  If Length(strString) > 1000 Then
  Begin
    Result := fRetornaNomeTabela(LeftStr(strString, 1000));
    If Result <> '' Then
      Exit;
  End;

  Result     := '';
  intPosicao := 0;

  If LeftStr(strString,6) = 'INSERT' Then
  Begin
    intPosicao :=  Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End

  Else If LeftStr(strString,6) = 'UPDATE' Then
  Begin
    intPosicao :=  Pos('UPDATE ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'UPDATE ', '');
  End

  Else If LeftStr(strString,6) = 'DELETE' Then
  Begin
    intPosicao := Pos('FROM ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'FROM ', '');
  End

  Else If LeftStr(strString,7) = 'REPLACE' Then
  Begin
    intPosicao := Pos('INTO ', strString);
    strTmp := Copy(strString, intPosicao, Length(strString)-intPosicao);
    strTmp := TRegEx.Replace(strTmp, 'INTO ', '');
  End;

  If (intPosicao > 0) Then
  Begin
    strTmp := fTrocaCaracter(strTmp,'(', ' ');
    strTmp := fTrocaCaracter(strTmp,')', ' ');
    strTmp := fTrocaCaracter(strTmp,',', ' ');
    strTmp := Trim(strTmp);

    For intContador := 1 To Length(strTmp) Do
    Begin
      If fEmptyStr(Copy(strTmp, intContador, 1)) Then
        Break;

      Result := Result + Copy(strTmp, intContador, 1);
    End;

    Result := Trim(Result);
  End;

  If Not fEmptyStr(Result) Then
  Begin

    intPosicao := Pos('.',Result);

    If intPosicao > 0 Then
      Result := Copy(Result, intPosicao +1, Length(Result) -intPosicao);

  End;
End;

{**************************************}
{* GERA O LOG DE ALTERA«’ES NO BANCO  *}
{***********************************AF*}
function fGravaLogBco(strComand: String): Boolean;
  Var
    qryLogBco: TUniQuery;
Begin

  Try
    Result := True;

    qryLogBco := fCriaQuery;

    qryLogBco.Close;
    qryLogBco.SQL.Clear;
    qryLogBco.SQL.Add('SELECT * FROM LOGBCO LIMIT 0');
    qryLogBco.Open;

    With qryLogBco Do
    Begin
      Insert;
      FieldByName('LOG_DTACAD').AsDateTime := VS_Date;
      FieldByName('LOG_HRACAD').AsDateTime := fTime();
      FieldByName('LOG_COMAND').AsString   := strComand;

      If FindField('LOG_CODOPE') <> Nil Then
        FieldByName('LOG_CODOPE').AsString := strLoginUsuarioLogado;

      Post;
    End;

    qryLogBco.Close;
    FreeAndNil(qryLogBco);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pGravarErro(True,'[GRAVALOGBCO] - ' + E.message);
      fMensagem('','Erro ao tentar gravar LogBco!!!',['&OK']);
      FreeAndNil(qryLogBco);
    End;
  End;
End;

function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;
begin
  Result := False;
  If (strTabela = 'LOGTIN_SIT')        Or
     (strTabela = 'BAU_CADBAU_SIT')    Or
     (strTabela = 'CORIMO_CADCOR_SIT') Or
     (strTabela = 'DAC_CADDAC_SIT')    Or
     (strTabela = 'EUC_CADEUC_SIT')    Or
     (strTabela = 'FUT_CADFUT_SIT')    Or
     (strTabela = 'REI_CADREI_SIT')    Or
     (strTabela = 'SAY_CADSAY_SIT')    Or
     (strTabela = 'SHE_CADSHE_SIT')    Or
     (strTabela = 'SUV_CADSUV_SIT')    Or
     (strTabela = 'PPG_CADPPG_SIT')    Or
     (strTabela = 'BZA_CADBZA_SIT')    Or
     (strTabela = 'SKY_CADSKY_SIT')    Or
     (strTabela = 'DUP_CADDUP_SIT')    Or
     (strTabela = 'FAL_CADFAL_SIT')    Or
     (strTabela = 'WANPRO_CADWAN_SIT') Or
     (strTabela = 'LAZ_CADMIX_SIT')    Or
     (strTabela = 'C11_CADC11_SIT')    Or
     (strTabela = 'DU2_CADDU2_SIT')    Or
     (strTabela = 'ADT_CADADT_SIT')    Or
     (strTabela = 'LEI_CADLEI_SIT')    Or
     (strTabela = 'PPX_CADPPX_SIT')    Or
     (strTabela = 'LIK_CADLIK_SIT')    Or
     (strTabela = 'MZA_CADMZA_SIT')    Or
     (strTabela = 'MZD_CADMZD_SIT')    Or
     (strTabela = 'CIA_CADCIA_SIT')    Or
     (strTabela = 'MAE_CADMAE_SIT')    Or
     (strTabela = 'AJT_CADAJT_SIT')    Or
     (strTabela = 'SIN_CADSIN_SIT')    Or
     (strTabela = 'LUZ_CADLUZ_SIT')    Or
     (strTabela = 'LEC_CADLEC_SIT')    Or
     (strTabela = 'BZC_CADBZC_SIT')    Or
     (strTabela = 'STW_CADSTW_SIT')    Or
     (strTabela = 'REP_CADREP_SIT')    Or
     (strTabela = 'MIF_CADMIF_SIT')    Or
     (strTabela = 'GCC_CADGCC_SIT')    Or
     (strTabela = 'LCA_CADLCA_SIT')    Or
     (strTabela = 'PFA_CADPFA_SIT')    Or
     (strTabela = 'BLA_CADBLA_SIT')    Then
    Result := True;
end;

function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
begin
  Result := fCampoTabela('CFG_PERREP', 'CFGAUX', ['CFG_CODCFG'], [strCodCfg], False) = 'S';
end;

function fPermiteReplicarCfgSis(ASQL: String): Boolean;
begin
  If Not fRetornaNomeTabela(ASQL).Equals('CFGSIS') Then
    Exit(False);
  If fTabelaReplica('CFGSIS') Then
    Exit(True);
  If fConfiguracaoPermiteReplicar(fExtrairCodigoConfiguracao(ASQL)) Then
    Exit(True);
  Result := False;
end;

function fExtrairCodigoConfiguracao(ASQL: String): String;
Var
  LVal: String;
begin
  Result := EmptyStr;
  ASQL := UpperCase(ASQL);
  Repeat
    LVal := fExtractBetweenTags(ASQL, '''', '''');
    If LVal.StartsWith('CFG_') Then
      Exit(LVal);
    ASQL := Trim(Copy(ASQL, Pos(LVal, ASQL) + Length(LVal) + 1, Length(ASQL)));
    If ASQL = EmptyStr Then
      Break;
  Until False;
end;

function fExtractBetweenTags(const Value, TagI, TagF: String): String;
var
  regEx: TRegEx;
begin
  regEx := TRegEx.Create(Format('%s.+?%s', [TagI.Replace('/', '\/'),
    TagF.Replace('/', '\/')]));

  Result := regEx.Match(Value).Value.Replace(TagI, '').Replace(TagF, '');
end;

{**************************************}
{* VERIFICA SE TABELA REPLICA OU N√O  *}
{***********************************AF*}
function fTabelaReplica(strNomTabela: String): Boolean;
Begin
  VS_MREWSTabelaReplica.BeginWrite;
  Try
    Try
      If VS_dicTabelaReplica.ContainsKey(strNomTabela) Then
        Exit(VS_dicTabelaReplica[strNomTabela]);

      Result := fTabelaPermiteReplicarSempre(strNomTabela);
      VS_dicTabelaReplica.AddOrSetValue(strNomTabela, Result);

      If Not Result Then
      Begin
        VS_dicTabelaReplica.AddOrSetValue(strNomTabela, Result);
        Exit;
      End;

      pCarregaNre;

      If Not blnTransferindoCodigo  Then
      Begin
        VS_cdsTabNRE.First;
        while not VS_cdsTabNRE.Eof do
        Begin

          {**************************************}
          {* SE FOI COLOCADO NO FIM O %         *}
          {***********************************AF*}
          If Pos('%', Trim(VS_cdsTabNRE.Fields[0].AsString)) > 0 Then
          Begin

            If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(VS_cdsTabNRE.Fields[0].AsString))) - 1) = LeftStr(Trim(AnsiUpperCase(VS_cdsTabNRE.Fields[0].AsString)), Length(Trim(AnsiUpperCase(VS_cdsTabNRE.Fields[0].AsString))) - 1) Then
            Begin
              Result := False;
              VS_dicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End
          {**************************************}
          {* SE N√O FOI COLOCADO O %            *}
          {***********************************AF*}
          Else
          Begin

            {**************************************}
            {* SE O NOME DA TABELA FOR O MESMO DA *}
            {* CONFIGURA«√O ENT√O N√O REPLICA     *}
            {***********************************AF*}
            If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(VS_cdsTabNRE.Fields[0].AsString)) Then
            Begin
              Result := False;
              VS_dicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End;

          VS_cdsTabNRE.Next;
        End;

      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pGravarErro(True,'[TABELAREPLICA] - ' + strNomTabela + ' - ' + E.Message, GetComputerNetName + #13#10 + fRetornaStack);
      End;
    End;
  Finally
    VS_MREWSTabelaReplica.EndWrite;
  End;
End;

function fGravaUsuRep(connection: TUniConnection): Boolean;
begin
  pCarregaVariaveisControleLogRep(connection);

  Result := (VS_GravaUsuRep = 'S');
end;

function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64; connection: TUniConnection): Boolean;
  Var
    qryUsu: TUniQuery;
    strSql: string;

  function fGravaConID: Boolean;
  begin
    Result := (VS_UsuRepConId = 'S') And (Not fEmptyStr(VS_ConnectionID));
  end;

begin
  Result := True;

  If (Not fGravaUsuRep(connection)) Then
    Exit;

  Try
    qryUsu := fCriaQuery(nil, connection);

    strSql := '';
    strSql := strSql +  'INSERT INTO USUREP (';
    strSql := strSql +  '  LOG_SEQREP, ';
    strSql := strSql +  '  LOG_NOMMAQ, ';
    strSql := strSql +  '  LOG_NOMUSU, ';
    strSql := strSql +  '  LOG_NUM_IP, ';
    If (fGravaConID) Then
     strSql := strSql + '  LOG_CON_ID, ';
    strSql := strSql +  '  LOG_MACADD) ';
    strSql := strSql +  'VALUES (      ';
    strSql := strSql +  '  :SEQREP,    ';
    strSql := strSql +  '  :NOMMAQ,    ';
    strSql := strSql +  '  :NOMUSU,    ';
    strSql := strSql +  '  :NUM_IP,    ';
    If (fGravaConID) Then
     strSql := strSql + '  :CON_ID,    ';
    strSql := strSql +  '  :MACADD)    ';

    With qryUsu, SQL Do
    Begin
      Add(strSql);

      ParamByName('SEQREP').AsLargeInt := intSeqReplicacao;
      ParamByName('NOMMAQ').Value := VS_ComputerNetName;
      ParamByName('NOMUSU').Value := VS_UserFromWindows;
      ParamByName('NUM_IP').Value := VS_IPAddressAsString;
      ParamByName('MACADD').Value := VS_MacAddress;
      If (fGravaConID) Then
        ParamByName('CON_ID').AsString := VS_ConnectionID;

      ExecSql;
    End;

  Finally
    If Assigned(qryUsu) Then
      FreeAndNil(qryUsu);
  End;

end;

function fGetIDTransacao(objConnection: TUniConnection) : UInt64;
  Var
    qryIDTrans : TUniQuery;
begin
  Try
    qryIDTrans := fCriaQuery(Nil, objConnection);
    Try
      Result := 0;

      qryIDTrans.SQL.Clear;
      qryIDTrans.SQL.Add('SELECT @VS_ID_TRANSACAO;');
      qryIDTrans.Open;

      If qryIDTrans.IsEmpty Then
        Exit;

      If qryIDTrans.Fields[0].IsNull Then
        Exit;

      Result := qryIDTrans.Fields[0].AsLargeInt;
    Finally
      FreeAndNil(qryIDTrans);
    End;
  Except
    Result := 0;
  End;
end;

procedure pSetarVariaveisDeAmbienteTransacao(objConnection: TUniConnection);
  Var
    qryVariaveis : TUniQuery;
begin
  If VS_strCodEmp.IsEmpty Then
    Exit;

  If strLoginUsuarioLogado.IsEmpty Then
    Exit;

  qryVariaveis := fCriaQuery(Nil, objConnection);
  Try
    Try
      qryVariaveis.SQL.Clear;
      qryVariaveis.SQL.Add('SET @VS_USUARIOLOGADO = :USUARIOLOGADO;');
      qryVariaveis.SQL.Add('SET @VS_EMPRESALOGADA = :EMPRESALOGADA;');
      qryVariaveis.SQL.Add('SET @VS_ID_TRANSACAO = UUID_SHORT() & :MAXINT64;');
      qryVariaveis.ParamByName('USUARIOLOGADO').AsString := strLoginUsuarioLogado;
      qryVariaveis.ParamByName('EMPRESALOGADA').AsString := VS_strCodEmp;
      qryVariaveis.ParamByName('MAXINT64').AsLargeInt := High(Int64);
      qryVariaveis.ExecSQL;
    Except
    End;
  Finally
    FreeAndNil(qryVariaveis);
  End;
end;

procedure pLimparVariaveisDeAmbienteTransacao(objConnection: TUniConnection);
  Var
    qryVariaveis : TUniQuery;
begin
  Try
    qryVariaveis := fCriaQuery(Nil, objConnection);
    Try
      qryVariaveis.SQL.Clear;
      qryVariaveis.SQL.Add('SET @VS_ID_TRANSACAO = :IDTRA;');
      qryVariaveis.ParamByName('IDTRA').AsLargeInt := 0;
      qryVariaveis.ExecSQL;
    Finally
      FreeAndNil(qryVariaveis);
    End;
  Except
  End;
end;

procedure pAfterStartTransaction(objConnection: TUniConnection);
begin
  pSetarVariaveisDeAmbienteTransacao(objConnection);
end;

procedure pCarregaVariaveisControleLogRep(connection: TUniConnection);

  function fCampoExiste(const strTabela, strCampo: String): Boolean;
    Var
      qryAux: TUniQuery;
  begin
    Result := False;
    qryAux := fCriaQuery(Nil, connection);
    Try
      qryAux.SQL.Add('DESC ' + strTabela);
      qryAux.Open;
      qryAux.First;

      While (Not qryAux.Eof) Do
      Begin
        If qryAux.FieldByName('Field').AsString = strCampo Then
        Begin
          Result := True;
          Break;
        End;

        qryAux.Next;
      End;

      qryAux.Close;
    Finally
      FreeAndNil(qryAux);
    End;
  end;

begin
  If (VS_ConnectionID.IsEmpty) Then
    VS_ConnectionID := fGetConnectionID();

  If (VS_GravaUsuRep.IsEmpty) Then
    VS_GravaUsuRep := 'S'; //PASSIVO DE CONFIGURA«√O CASO ALGUM DIA QUISER FOR«AR A GRAVA«√O

  If (VS_LogRepConId.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_CON_ID') Then
      VS_LogRepConId := 'S'
    Else
      VS_LogRepConId := 'N'
  End;

  If (VS_GravaUsuRep = 'S') And (VS_LogRepConId = 'S') Then
  Begin
    VS_GravaUsuRep := 'N';
  End;

  If (VS_UsuRepConId.IsEmpty) Then
  Begin
    If fCampoExiste('USUREP', 'LOG_CON_ID') Then
      VS_UsuRepConId := 'S'
    Else
      VS_UsuRepConId := 'N'
  End;

  If (VS_LogRepIdTra.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_IDTRAN') Then
      VS_LogRepIdTra := 'S'
    Else
      VS_LogRepIdTra := 'N'
  End;

  If (VS_LogRepCodOp.IsEmpty) Then
  Begin
    If fCampoExiste('LOGREP', 'LOG_CODOPE') Then
      VS_LogRepCodOp := 'S'
    Else
      VS_LogRepCodOp := 'N'
  End;
end;

{**************************************}
{* GERA O LOG DE REPLICA«√O           *}
{***********************************AF*}
function fGravaLogRep(strComand, strTabela, strCarreg: String; connection: TUniConnection): Boolean;
Var
  qryLogRep: TUniQuery;
  dtaDtaSis : TDateTime;
  dtaHraSis : TDateTime;

  function fGravaLogRepConId: Boolean;
  begin
    Result := (VS_LogRepConId = 'S') And (VS_ConnectionID <> '');
  end;

  function fGravaTabelasFilhasLogRep: Boolean;
  begin
    Result := ((VS_GravaUsuRep = 'S') And (VS_ConnectionID <> ''));
  end;

  procedure pCarregaVariaveisControle;
  begin
    If VS_ConnectionID.IsEmpty Or
       VS_GravaUsuRep.IsEmpty  Or
       VS_LogRepIdTra.IsEmpty  Or
       VS_LogRepConId.IsEmpty  Or
       VS_LogRepCodOp.IsEmpty  Or
       VS_UsuRepConId.IsEmpty Then
     Begin
       pCarregaVariaveisControleLogRep(connection);
     End;
  end;

Begin
  If strComand = SQL_TESTE_LOG_REPLICACAO Then
  Begin
    VS_RESULTADO_TESTE_LOG_REPLICACAO := True;
    Exit(True);
  End;

  pCarregaVariaveisControle;

  Try
    qryLogRep := fCriaQuery(Nil, connection);
    Try
      dtaDtaSis := VS_Date;
      dtaHraSis := fTime();

      If fGravaTabelasFilhasLogRep Then
      Begin
        qryLogRep.SQL.Text := 'SELECT * FROM LOGREP WHERE FALSE';
        qryLogRep.Open;

        qryLogRep.Insert;

        If (fGravaLogRepConId) Then
          qryLogRep.FieldByName('LOG_CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepIdTra = 'S') Then
          qryLogRep.FieldByName('LOG_IDTRAN').AsLargeInt := fGetIDTransacao(connection);

        If (VS_LogRepCodOp = 'S') And (Not fEmptyStr(fGetUsuarioLogado)) Then
          qryLogRep.FieldByName('LOG_CODOPE').AsString := fGetUsuarioLogado;

        qryLogRep.FieldByName('LOG_DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.FieldByName('LOG_HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.FieldByName('LOG_COMAND').AsString   := strComand;
        qryLogRep.FieldByName('LOG_TABELA').AsString   := strTabela;
        qryLogRep.FieldByName('LOG_CARREG').AsString   := strCarreg;

        qryLogRep.Post;

        Result := True;

        If (VS_GravaUsuRep = 'S') Then
          Result := Result And fGravaInfUsuarioReplicacao(qryLogRep.FieldByName('LOG_CODIGO').AsLargeInt, connection);
      End
      Else
      Begin
        qryLogRep.SQL.Clear;
        qryLogRep.SQL.Add('INSERT INTO LOGREP ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' LOG_CON_ID,     ');

        If (VS_LogRepIdTra = 'S') Then
          qryLogRep.SQL.Add(' LOG_IDTRAN,     ');

        If (VS_LogRepCodOp = 'S') Then
         qryLogRep.SQL.Add('  LOG_CODOPE,     ');

        qryLogRep.SQL.Add('   LOG_DTACAD,     ');
        qryLogRep.SQL.Add('   LOG_HRACAD,     ');
        qryLogRep.SQL.Add('   LOG_COMAND,     ');
        qryLogRep.SQL.Add('   LOG_TABELA,     ');
        qryLogRep.SQL.Add('   LOG_CARREG      ');
        qryLogRep.SQL.Add('  )                ');
        qryLogRep.SQL.Add('VALUES             ');
        qryLogRep.SQL.Add('  (                ');

        If (fGravaLogRepConId) Then
          qryLogRep.SQL.Add(' :CON_ID,        ');

        If (VS_LogRepIdTra = 'S') Then
          qryLogRep.SQL.Add(' :IDTRAN,        ');

        If (VS_LogRepCodOp = 'S') Then
          qryLogRep.SQL.Add(' :CODOPE,        ');

        qryLogRep.SQL.Add('   :DTACAD,        ');
        qryLogRep.SQL.Add('   :HRACAD,        ');
        qryLogRep.SQL.Add('   :COMAND,        ');
        qryLogRep.SQL.Add('   :TABELA,        ');
        qryLogRep.SQL.Add('   :CARREG         ');

        qryLogRep.SQL.Add('  )                ');

        If (fGravaLogRepConId) Then
          qryLogRep.ParamByName('CON_ID').AsString := VS_ConnectionID;

        If (VS_LogRepIdTra = 'S') Then
          qryLogRep.ParamByName('IDTRAN').AsLargeInt := fGetIDTransacao(connection);

        If (VS_LogRepCodOp = 'S') Then
        Begin
          If (Not fEmptyStr(fGetUsuarioLogado)) Then
            qryLogRep.ParamByName('CODOPE').AsString := fGetUsuarioLogado
          Else
            qryLogRep.ParamByName('CODOPE').Clear;
        End;

        qryLogRep.ParamByName('DTACAD').AsDateTime := dtaDtaSis;
        qryLogRep.ParamByName('HRACAD').AsDateTime := dtaHraSis;
        qryLogRep.ParamByName('COMAND').AsString   := strComand;
        qryLogRep.ParamByName('TABELA').AsString   := strTabela;
        qryLogRep.ParamByName('CARREG').AsString   := strCarreg;

        qryLogRep.ExecSQL;

        Result := True;
      End;

      qryLogRep.Close;
    Finally
      FreeAndNil(qryLogRep);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;

      If fInTransaction Then
      Begin
        VS_blnErroLogRep := True;
        VS_strErroLogRep := '[GRAVALOGREP] - ' + E.message;
      End;

      pGravarErro(True,'[GRAVALOGREP] - ' + E.message);
    End;
  End;
End;

procedure pCarregaNre(ARefresh: Boolean = False);
  Var
   qryTabNRE: TUniQuery;
begin
  If ARefresh And Assigned(VS_cdsTabNRE) Then
    FreeAndNil(VS_cdsTabNRE);

  If (Not Assigned(VS_cdsTabNRE)) Then
  Begin
    qryTabNRE := fCriaQuery(Nil);
    Try
      qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
      qryTabNRE.Open;

      If (qryTabNRE.IsEmpty) Or (Not qryTabNRE.Active) Then
      Begin
        qryTabNRE.Close;
        FreeAndNil(qryTabNRE);
       {$IFDEF LINUX}
        raise Exception.Create('Tabela TABNRE vazia! Verifique!');
       {$ELSE}
        fMensagem('','Tabela TABNRE vazia! Verifique!',['&OK']);
        Application.Terminate;
        Exit;
       {$ENDIF}
      End;

      VS_cdsTabNRE := fCriaClientDatset(qryTabNRE);

      qryTabNRE.Close;
    Finally
      FreeAndNil(qryTabNRE);
    End;
  End;
end;

function fPermiteReplicarLckAtc: Boolean;
  Var
    strReplicaLckAtc : String;
begin
  Result := False;
  If (Not fEmptyStr(VS_strReplicarLckAtc)) Then
  Begin
    Result := (VS_strReplicarLckAtc = 'S');
    Exit;
  End;
  If (Not fTabelaExiste('ROTINA')) Then
  Begin
    VS_strReplicarLckAtc := 'N';
    Exit;
  End;
  strReplicaLckAtc := fCampoTabela('INA_ATIVAD', 'ROTINA', ['INA_ROTINA', 'INA_CODEMP'], ['REPLICA_LCKATC', VS_strCodEmp], False);
  If (fEmptyStr(strReplicaLckAtc)) Then
  Begin
    VS_strReplicarLckAtc := 'N';
    Exit;
  End;
  Result := (strReplicaLckAtc = 'S');
  If (Result) Then
    VS_strReplicarLckAtc := 'S'
  Else
    VS_strReplicarLckAtc := 'N';
end;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* N√O REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'TAGDIR')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'NFE_NFEPRINTER') Or
     (strNomTabela = 'NFE_TEMPO')      Or
     (strNomTabela = 'NFE_LOCAL')      Or
     (strNomTabela = 'LOGACE')         Or
     (strNomTabela = 'LOGFRM')         Or
     (strNomTabela = 'LOGTMR')         Or
     (strNomTabela = 'LOGTHR')         Or
     (strNomTabela = 'MNUACE')         Or
     (strNomTabela = 'CONDET')         Or
     (strNomTabela = 'PCMGER_RES')     Or
     (strNomTabela = 'PCMDET_RES')     Or
     (strNomTabela = 'PCDDET_RES')     Or
     (strNomTabela = 'PCMIRQ_RES')     Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;

  If (strNomTabela = 'LCKATC') Then
    Result := fPermiteReplicarLckAtc;

  //Req: 215414
  If strNomTabela.StartsWith('TMP_ENTFUT_') Then
  Begin
    Result := False;
  End;

  If strNomTabela.StartsWith('TMP_PRM_') Then
  Begin
    Result := False;
  End;
end;

function fRetHoraServidor(AConnection: TUniConnection = nil): TTime;
var
  qryCons: TUniQuery;
begin
  Result := 0;
  qryCons := fCriaQuery(Nil, AConnection);
  Try
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_TIME');
      Open;

      Result := FieldByName('CURRENT_TIME').AsDateTime;
    End;
  Finally
    If Result = 0 Then
      Result := fTime();
    FreeAndNil(qryCons);
  End;
end;

function fRetDataServidor: TDate;
var
  qryCons: TUniQuery;
begin
  qryCons := fCriaQuery(Nil);
  Try
    With qryCons Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT CURRENT_DATE');
      Open;

      Result := FieldByName('CURRENT_DATE').AsDateTime;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function fRetDtaHraServidor : TDateTime;
var
  qryDtaHra : TUniQuery;
begin

  qryDtaHra := fCriaQuery();

  Try

    qryDtaHra.Close;
    qryDtaHra.SQL.Clear;
    qryDtaHra.SQL.Add('SELECT CURRENT_TIMESTAMP AS DATA_HORA');
    qryDtaHra.Open;

    If Not qryDtaHra.IsEmpty Then
      Result := qryDtaHra.FieldByName('DATA_HORA').AsDateTime
    Else
      Result := 0;

  Finally
    FreeAndNil(qryDtaHra);
  End;

end;

function fRetUserLock(strNomeTabela: String): String;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  With qryLock, SQL Do
  Begin
    Add('SELECT LCK_NOMUSU FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := qryLock.Connection.Database + '.' + strNomeTabela;
    Open;
    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('LCK_NOMUSU').AsString;
  End;
  FreeAndNil(qryLock);
End;

function fRetOrigemLock(strNomeTabela: String): String;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  With qryLock, SQL Do
  Begin
    Add('SELECT LCK_ORIGEM FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := strNomeTabela;
    Open;
    If IsEmpty Then
      Result := ''
    Else
      Result := FieldByName('LCK_ORIGEM').AsString;
  End;
  FreeAndNil(qryLock);
End;

function fRenovarHoraLock(strNomeTabela: String; strOrigem: String = ''): Boolean;
  Var
    qryLock: TUniQuery;
    strSQL: String;
Begin
  Result := False;

  // Mesmo prefixo que fLock_Unlock aplica ao gravar: LCK_CHAACE e' PK e vai
  // com o nome do banco na frente.
 {$IFDEF LINUX}
  strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' + strNomeTabela;
 {$ELSE}
  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
 {$ENDIF}

  // A hora vem do proprio banco, e nao de VS_Date/fTime: o autcom mede a idade da trava
  // com fGetTempoDuracaoLock(..., AUtilizaHoraServidor = True), que compara contra
  // CURRENT_TIMESTAMP. Gravar o relogio do host deixaria a renovacao a merce de uma
  // diferenca de horario entre a maquina do robo e o servidor MySQL.
  // So' renova trava desta conexao. Filtrando so' por chave + origem, trava de outro dono
  // era renovada, a funcao voltava True e o -f nunca chegava ao pDestravaLockForcado.
  // LCK_NOMUSU sozinho nao basta: todo robo Linux roda como root, entao qualquer robo
  // (ou a execucao anterior, ja morta) passaria por dono da trava.
  // CONNECTION_ID() e' o mesmo valor que fLock_Unlock grava via fGetConnectionID na
  // conexao global; LCK_NOMUSU fica como guarda contra reuso de id apos restart do MySQL.
  strSQL := 'UPDATE LCKATC SET LCK_DTALCK = CURRENT_DATE, LCK_HRALCK = CURRENT_TIME ' +
            'WHERE LCK_CHAACE = :CHAACE ' +
            '  AND LCK_CON_ID = CAST(CONNECTION_ID() AS CHAR) ' +
            '  AND LCK_NOMUSU = :NOMUSU';

  If (Not fEmptyStr(strOrigem)) Then
    strSQL := strSQL + ' AND IFNULL(LCK_ORIGEM, "") = :ORIGEM';

  qryLock := fCriaQuery(Nil);
  Try
    qryLock.SQL.Add(strSQL);
    qryLock.ParamByName('CHAACE').AsString := strNomeTabela;
    qryLock.ParamByName('NOMUSU').AsString := VS_UserFromWindows;

    If (Not fEmptyStr(strOrigem)) Then
      qryLock.ParamByName('ORIGEM').AsString := strOrigem;

    qryLock.ExecSQL;

    // Zero linhas = a trava sumiu ou trocou de dono enquanto o robo trabalhava.
    Result := (qryLock.RowsAffected > 0);
  Finally
    FreeAndNil(qryLock);
  End;
End;

procedure pWaitWindow(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);
{$IFDEF LINUX}
begin
end;
{$ELSE}
begin
  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.intPosicao := intPosicao;
    frmWaitWindow.lblTexto.Caption := strTexto;
    frmWaitWindow.tmrWait.Interval := (intTimeOut * 1000) + 200;
    AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;
    frmWaitWindow.tmrWait.Enabled := True;

    If (Sender <> Nil) Then
      pSetFocus(Sender);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pWaitWindow]');
    End;
  End;

end;
{$ENDIF}

function fLock_Unlock(strNomeTabela: String;
                      blnTrava: Boolean;
                      blnLoopTravamento: Boolean = True;
                      blnHourGlass: Boolean = FALSE;
                      strCon_Id: String = '';
                      blnMostraMsgTravamento: Boolean = True;
                      strOrigem: String = ''): Boolean;
  Var
    strLock: String;
    qryLock_Unlock: TUniQuery;
    blnComitar: Boolean;
    blnGravaLogTransacao: Boolean;
  Const
    TEMPO_ESPERA = 3000;

    procedure pAtualizaContador;
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_TENTAT = LCK_TENTAT + 1 WHERE LCK_CHAACE = :CHAACE');
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    procedure pIncrementaTrava(blnIncrementa: Boolean);
    begin
      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      If blnIncrementa Then
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA + 1 WHERE LCK_CHAACE = :CHAACE')
      Else
        qryLock_Unlock.SQL.Add('UPDATE LCKATC SET LCK_QTDTRA = LCK_QTDTRA - 1 WHERE LCK_CHAACE = :CHAACE');

      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;
      qryLock_Unlock.ExecSQL;
    end;

    function fExecutaLock: Boolean;
    begin

      Result := False;
      If (blnComitar) Then
        fStartTransaction;

      qryLock_Unlock.Close;
      qryLock_Unlock.SQL.Clear;
      qryLock_Unlock.SQL.Add(strLock);
      qryLock_Unlock.ParamByName('CHAACE').AsString := strNomeTabela;

      qryLock_Unlock.ParamByName('DTALCK').AsDate   := VS_Date;
      qryLock_Unlock.ParamByName('HRALCK').AsTime   := fTime();
      qryLock_Unlock.ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
      qryLock_Unlock.ParamByName('NUM_IP').AsString := VS_IPAddressAsString;
      qryLock_Unlock.ParamByName('MACADD').AsString := VS_MacAddress;
      qryLock_Unlock.ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
      qryLock_Unlock.ParamByName('NOMUSU').AsString := VS_UserFromWindows;
      qryLock_Unlock.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryLock_Unlock.ParamByName('ORIGEM').AsString := strOrigem;
      qryLock_Unlock.ParamByName('QTDTRA').AsInteger:= 1;

      Try
        qryLock_Unlock.ExecSQL;
        Result := True;
      Except
        On E: Exception Do
        Begin
          If (Pos('DUPLICADA', UpperCase(E.Message)) > 0) Or
             (Pos('DUPLICATE', UpperCase(E.Message)) > 0) Then
          Begin
            pAtualizaContador;

            If (Not fEmptyStr(strOrigem)) And
               SameText(fRetOrigemLock(strNomeTabela), strOrigem) Then
            Begin
              pIncrementaTrava(True);
              Result := True;
            End;

          End
          Else
            pMensagensErro(E.Message, '[fLock_Unlock]');
        End;
      End;

      If (blnComitar) Then
        fCommit;
    end;

    procedure pGravaLogLock;
    begin
      With qryLock_Unlock Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO LCKATC_LOG (LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_TENTAT, ');
        SQL.Add('  LCK_ORIGEM, LCK_DTALOG, LCK_HRALOG, LCK_TIPLCK, LCK_MACADD, LCK_NOMMAQ, LCK_NOMUSU) ');
        SQL.Add('VALUES (:NUM_IP, :CON_ID, :CHAACE, :CODOPE, :QTDTRA, :ORIGEM, ');
        SQL.Add('        :DTALOG, :HRALOG, :SIGLA, :MACADD, :NOMMAQ, :NOMUSU) ');
        ParamByName('CHAACE').AsString := strNomeTabela;
        ParamByName('DTALOG').AsDate   := VS_Date;
        ParamByName('HRALOG').AsTime   := fRetHoraServidor;
        ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);
        ParamByName('NUM_IP').AsString := GetIPAddressAsString;
        ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        ParamByName('ORIGEM').AsString := strOrigem;
        ParamByName('SIGLA').AsString  := IIF(blnTrava, 'LCK','LBA');
        ParamByName('MACADD').AsString := VS_MacAddress;
        ParamByName('NOMMAQ').AsString := VS_ComputerNetName;
        ParamByName('NOMUSU').AsString := VS_UserFromWindows;
        ParamByName('QTDTRA').AsInteger:= 1;
        ExecSQL;
      End;

    end;

Begin

  blnGravaLogTransacao := VS_blnGravaLogTransacao;

  Try
  {$IFNDEF LINUX}
    VS_blnGravaLogTransacao := False;
    If blnHourGlass Then
      Screen.Cursor := crHourGlass;
    strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
    qryLock_Unlock := fCriaQuery(Nil);
  {$ELSE}
    AddOrSetGlobalVar('VS_blnGravaLogTransacao', False);
    strNomeTabela := objConnectionsManager.CurrentConnection.Database + '.' + strNomeTabela;
    qryLock_Unlock := fCriaQuery(Nil);
  {$ENDIF}

    blnComitar := False;
    If (Not fInTransaction) Then
    Begin
      blnComitar := True;
    End;

    Result := True;
    If blnTrava Then
    Begin

      strLock := 'INSERT INTO LCKATC (LCK_DTALCK, LCK_HRALCK, LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_ORIGEM, LCK_QTDTRA,LCK_MACADD,LCK_NOMMAQ,LCK_NOMUSU) ' +
                 'VALUES (:DTALCK, :HRALCK, :NUM_IP, :CON_ID, :CHAACE, :CODOPE, :ORIGEM, :QTDTRA,:MACADD,:NOMMAQ,:NOMUSU)';

      With qryLock_Unlock Do
      Begin

        While Not fExecutaLock Do
        Begin

          If (Not blnLoopTravamento) Then
          Begin
            Result := False;
            Break;
          End;

          If blnMostraMsgTravamento Then
          Begin
            pWaitWindow( {$IFDEF LINUX}nil{$ELSE}Application.MainForm{$ENDIF},
                         'O arquivo ' + strNomeTabela + ' est· sendo ' +
                         'utilizado no momento.' + #13#10 +
                         'Aguarde LiberaÁ„o!' );
          End;

          Sleep(TEMPO_ESPERA);
          Application.ProcessMessages;
        End;

        If Result Then
          pGravaLogLock;

        Close;
      End;
    End
    Else
    Begin

      If fEmptyStr(strOrigem) Then
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_CON_ID = :CON_ID'
      Else
      Begin
        pIncrementaTrava(False);
        strLock := 'DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_QTDTRA <= 0';
      End;

      pGravaLogLock;

      With qryLock_Unlock Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strLock);
        ParamByName('CHAACE').AsString := strNomeTabela;

        If fEmptyStr(strOrigem) Then
        ParamByName('CON_ID').AsString := IIF(fEmptyStr(strCon_Id), fGetConnectionID, strCon_Id);

        ExecSQL;
        Close;
      End;
    End;

    FreeAndNil(qryLock_Unlock);
   {$IFNDEF LINUX}
    If blnHourGlass Then
      Screen.Cursor := crDefault;
   {$ENDIF}
  Finally
   {$IFDEF LINUX}
    AddOrSetGlobalVar('VS_blnGravaLogTransacao', blnGravaLogTransacao);
   {$ELSE}
    VS_blnGravaLogTransacao := blnGravaLogTransacao;
   {$ENDIF}
  End;

End;

{*****************************************}
{* VERIFICA SE A TABELA EXISTE NO BANCO  *}
{* ATUAL.                                *}
{**************************************MV*}
function fTabelaExiste(const strNomeTabela: String; const blnUsarCache : Boolean = False; Conexao: TUniConnection = Nil): Boolean;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

Begin
  Try
    If Assigned(Conexao) Then
      qryGenTmp := fCriaQuery(Nil, Conexao)
    Else
      qryGenTmp := fCriaQuery;

    Try

      If (fEmptyStr(strNomeTabela)) Then
      Begin
        Result := False;
        Exit;
      End;

      //Result := False;
      strSQL := '';
      strSQL := strSQL + 'DESC ' + strNomeTabela;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        Result := True;

        Close;
      End;

    Except
      On E: Exception do
      Begin
        Result := False;
      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

End;

Function fRetNomTabAuxMov(strNomTab: String): String;
begin
  strNomTab := Trim(strNomTab);

  If SameText(strNomTab, 'MOVGER') Then
    Result := 'AUXMOV'

  Else If SameText(strNomTab, 'NOTGER') Then
    Result := 'AUXNOT'

  Else If SameText(strNomTab, 'FATGOR') Then
    Result := 'AUXGOR'

  Else If SameText(strNomTab, 'DEL_MOVGER') Then
    Result := 'DEL_AUXMOV'

  Else If SameText(strNomTab, 'DEL_NOTGER') Then
    Result := 'DEL_AUXNOT'

  Else If SameText(strNomTab, 'DEL_FATGOR') Then
    Result := 'DEL_AUXGOR'

  Else
    Result := '';
end;

Procedure pVerificaIntegridadeComplementar(strNomFrm,
                                           strTabela: String;
                                           qryTabOriginal: TDataSet;
                                           blnGravar: Boolean = True;
                                           blnSoCriaTabela: Boolean = FALSE;
                                           strMotDel: String = '';
                                           strOpeDel: String = '');
  Var
    qryTabAux: TUniQuery;
    strTabAux: String;
Begin
  strTabAux := fRetNomTabAuxMov(strTabela);

  If fEmptyStr(strTabAux) Then
    Exit;

  qryTabAux := fCriaQuery;

  With qryTabAux, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM');
    Add(strTabAux);
    Add('WHERE');
    Add('  AUX_SEQGER = :AUTINC');

    ParamByName('AUTINC').AsString := qryTabOriginal.FieldByName('AUTOINCREM').AsString;
    Open;

    If Not IsEmpty Then
      fVerificaIntegridade(strNomFrm,
                           strTabAux,
                           qryTabAux,
                           blnGravar,
                           blnSoCriaTabela,
                           strMotDel,
                           strOpeDel,
                           True);

  End;

  qryTabAux.Close;
  FreeAndNil(qryTabAux);
End;

{************************************************}
{* VERIFICA INTEGRIDADE DA TABELA CRIA TABELA   *}
{* DE DELETADOS SE N√O EXISTIR CRIA, SE EXISTIR *}
{* VERIFICA E DEPOIS GRAVA                      *}
{*********************************************AF*}
function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: TDataSet;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = False;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              blnTabAux: Boolean = False;
                              strOpcDel: String = ''): String;
  Var
    strSQL: String;
    intContador: Integer;
    qryGenIte: TUniQuery;
    qryGenTmp: TUniQuery;
    qryGenDel: TUniQuery;
    qryGenReq: TUniQuery;
    blnTeveNf: Boolean;
    blnGrvOpcDel: Boolean;

    function fRequeridoNatTabDel(strCampo:String):Boolean;
    begin
      Result:=False;

      If Not Assigned(qryGenReq) Then
      Begin
        qryGenReq := fCriaQuery;

        With qryGenReq Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DESCRIBE DEL_' + strTabela);
          Open;
        End;
      End;

      If qryGenReq.Locate('Field', strCampo, [loCaseInSensitive]) Then
      Begin
        Result := (AnsiUpperCase(qryGenReq.FieldByName('Null').Text) <> 'YES') And (AnsiUpperCase(qryGenReq.FieldByName('Null').Text) <> 'Y');
      End;
    end;

    procedure pAdicionaPrimaryKeyDeletada(strTabela: String; qryTabela: TUniQuery);
      Var
        blnCriar  : Boolean;
        qryGenUpd : TUniQuery;
    begin
      Try
        qryGenUpd := fCriaQuery;

        qryTabela.First;
        blnCriar := (Not qryTabela.Locate('Key', 'PRI', []));

        If (blnCriar) Then
        Begin

          If (strTabela = 'NOTCOM') Then
          Begin
            qryGenUpd.Close;
            qryGenUpd.SQL.Clear;
            qryGenUpd.SQL.Add('ALTER TABLE DEL_' + strTabela + ' ADD PRIMARY KEY (GER_SEQGER, GER_CODEMP) ');
            qryGenUpd.ExecSQL;
            qryGenUpd.Close;
          End
          Else
          Begin
            qryGenUpd.Close;
            qryGenUpd.SQL.Clear;
            qryGenUpd.SQL.Add('ALTER TABLE DEL_' + strTabela + ' ADD PRIMARY KEY (AUTOINCREM) ');
            qryGenUpd.ExecSQL;
            qryGenUpd.Close;
          End;

        End;

      Finally
        FreeAndNil(qryGenUpd);
      End;

    end;

begin

  {* Variavel local de tipo classe NAO e inicializada pelo compilador - nasce com lixo da pilha.  *}
  {* Sem este nil, o "If Not Assigned(qryGenReq)" de fRequeridoNatTabDel pula a criacao da query  *}
  {* e chama Locate sobre ponteiro invalido; e o Finally executa FreeAndNil sobre o mesmo lixo    *}
  {* mesmo quando fRequeridoNatTabDel nunca roda. Nao remover.                                    *}
  qryGenReq := Nil;

  If fEmptyStr(strOpeDel) Then
    strOpeDel := strLoginUsuarioLogado;

  Try
    qryGenIte := fCriaQuery;
    qryGenTmp := fCriaQuery;
    qryGenDel := fCriaQuery;

    Result := '';
    blnTeveNf := False;
    blnGrvOpcDel := False;

    If (Not blnSoCriaTabela) And (qryTabOriginal.IsEmpty) Then
      Exit;

    Try
      {********************************}
      {* DESCRI«√O DA TABELA ORIGINAL *}
      {*****************************AF*}
      strSQL := '';
      strSQL := strSQL + 'DESCRIBE ';
      strSQL := strSQL + strTabela;
      With qryGenIte Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
      End;

      If fTabelaExiste('DEL_' + strTabela) Then
      Begin
        {***********************}
        {* SE A TABELA EXISTIR *}
        {********************AF*}
        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('DESCRIBE DEL_' + strTabela);
          Open;
        End;

        If qryGenDel.Locate('Field', 'AUTOINCREM', []) Then
        Begin
          {*********************************************}
          {* CASO A TABELA DE DELETADOS JA EXISTA, E   *}
          {* NAO TENHA PRIMARY KEY, CRIA A PRIMARY KEY *}
          {******************************************MV*}
          pAdicionaPrimaryKeyDeletada(strTabela, qryGenDel);
        End;

        blnGrvOpcDel := (Not strOpcDel.IsEmpty) And (qryGenDel.Locate('Field', 'OPCDEL', []));

        qryGenIte.First;
        qryGenDel.First;
        {***************************************}
        {* VERIRFICA SE OS CAMPOS EST√O IGUAIS *}
        {************************************AF*}
        For intContador := 0 To qryGenIte.RecordCount-1 Do
        Begin
          {********************}
          {* SE CAMPO EXISTIR *}
          {*****************AF*}
          If qryGenDel.Locate('Field', qryGenIte.FieldByName('Field').AsString, [loCaseInSensitive]) Then
          Begin
            {***************************}
            {* SE O TIPO FOR DIFERENTE *}
            {************************AF*}

            (*********************************************************************************************)
            (* RETIRADO POIS NAS TABELAS CRIADAS COMO CHARSET=utf8 O CHAR(X) ESTA FICANDO COM VARCHAR(X) *)
            (* FAZENDO COM QUE O MODIFY SEJA EXECUTADO A TODA HORA DEIXANDO A ROTINA LENTA               *)
            (******************************************************************************************LA*)

            {
            If qryGenIte.FieldByName('Type').AsString <> qryGenDel.FieldByName('Type').AsString Then
            Begin
              strSQL := '';
              strSQL := strSQL + 'ALTER TABLE DEL_';
              strSQL := strSQL + strTabela;
              strSQL := strSQL + ' MODIFY ';
              strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
              strSQL := strSQL + ' ';
              strSQL := strSQL + qryGenIte.FieldByName('Type').AsString;
              With qryGenTmp Do
              Begin
                Close;
                SQL.Clear;
                SQL.Add(strSQL);
                ExecSQL;
                qryGenIte.Next;
              End;
            End
            Else }
            Begin
              qryGenIte.Next;
            End;
          End
          Else
          {**************************}
          {* SE O CAMPO N√O EXISTIR *}
          {***********************AF*}
          Begin
            strSQL := '';
            strSQL := strSQL + 'ALTER TABLE DEL_';
            strSQL := strSQL + strTabela;
            strSQL := strSQL + ' ADD ';
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ';
            strSQL := strSQL + qryGenIte.FieldByName('Type').AsString;
            With qryGenTmp Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ExecSQL;
            End;
            qryGenIte.Next;
          End;
        End;
      End
      Else
      Begin
        {***************************}
        {* SE A TABELA N√O EXISTIR *}
        {************************AF*}
        strSQL := '';
        strSQL := strSQL + 'CREATE TABLE ';
        strSQL := strSQL + 'DEL_' + strTabela + ' ( ';
        qryGenIte.First;

        {********************************************************}
        {* PEGA OS CAMPOS DA TABELA ORIGINAL E COLOCA NA STRING *}
        {*****************************************************AF*}
        For intContador := 1 To qryGenIte.RecordCount Do
        Begin
          If intContador <> qryGenIte.RecordCount Then
          Begin
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ' + qryGenIte.FieldByName('Type').AsString + ', ';
          End
          Else
          Begin
            strSQL := strSQL + qryGenIte.FieldByName('Field').AsString;
            strSQL := strSQL + ' ' + qryGenIte.FieldByName('Type').AsString;
            strSQL := strSQL + ', OPEDEL VARCHAR(50)';
            strSQL := strSQL + ', DTADEL DATE';
            strSQL := strSQL + ', HORDEL VARCHAR(10) ';

            If MatchStr(strTabela, ['MOVGER', 'NOTGER', 'FATGOR', 'MONPIX_LOG']) Then
            Begin
              strSQL := strSQL + ', MOTDEL VARCHAR(255) ';
              strSQL := strSQL + ', OPCDEL VARCHAR(10) ';
            End;

            {*******************************************}
            {* CRIA PRIMARY KEY                        *}
            {****************************************MV*}
            If (Pos('AUTOINCREM', strSQL) > 0) Then
            Begin
              strSQL := strSQL + ', PRIMARY KEY (AUTOINCREM) ';
            End;

            strSQL := strSQL + ' ) ENGINE=InnoDB; ';

          End;
          qryGenIte.Next;
        End;

        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
        End;

      End;

      If blnSoCriaTabela Then
      Begin
        FreeAndNil(qryGenTmp);
        FreeAndNil(qryGenDel);
        FreeAndNil(qryGenIte);
        Exit;
      End;

      {**************************************}
      {* GRAVA NA TABELA ORIGINAL OS CAMPOS *}
      {***********************************AF*}
      strSQL := '';
      strSQL := strSQL + 'REPLACE INTO DEL_' + strTabela + ' ( ';
      {******************}
      {* PEGA os CAMPOS *}
      {***************AF*}
      For intContador := 0 To qryTabOriginal.FieldCount-1 Do
      Begin
        If qryTabOriginal.Fields[intContador].FieldKind = fkData Then
        Begin
          strSQL := strSQL + qryTabOriginal.Fields[intContador].FieldName;
          {*****************************************************}
          {* ALTERADO PARA GRAVAR NOMFRM NO CADPAG E NO CTPDET *}
          {*25/04/2012***************************************JU*}
          If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
            blnTeveNf := True;
        End;

        If intContador <> qryTabOriginal.FieldCount-1 Then
          If qryTabOriginal.Fields[intContador+1].FieldKind = fkData Then
            strSQL := strSQL + ', ';
      End;

      If (Not blnTeveNf) And (Pos(strTabela,'CADCHQ') > 0)  Then
        strSQL := strSQL + ', CHQ_NOMFRM';

      If MatchStr(strTabela, ['MOVGER', 'NOTGER', 'FATGOR', 'MONPIX_LOG']) Then
        strSQL := strSQL + ', OPEDEL, DTADEL, HORDEL, MOTDEL '+IIF(blnGrvOpcDel,' ,OPCDEL ',' ')+' ) VALUES ( '
      Else
        strSQL := strSQL + ', OPEDEL, DTADEL, HORDEL ) VALUES ( ';

      {*******************}
      {* PEGA OS VALORES *}
      {****************AF*}
      For intContador := 0 To qryTabOriginal.FieldCount-1 Do
      Begin
        {*************************************************}
        {* VERIFICA SE … DATA PARA FORMATAR CORRETAMENTE *}
        {**********************************************AF*}
        If qryTabOriginal.Fields[intContador].FieldKind = fkData Then
        Begin
          If (qryTabOriginal.Fields[intContador].DataType = ftDate)    Or
            (qryTabOriginal.Fields[intContador].DataType = ftDateTime) Then
          Begin
            {**********************}
            {* VERIFICA SE … NULO *}
            {*******************AF*}
            If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
              strSQL := strSQL + QuotedStr(strNomfrm)

            Else If qryTabOriginal.Fields[intContador].AsString = '' Then
              strSQL := strSQL + 'NULL'
            Else If qryTabOriginal.Fields[intContador].DataType = ftDate Then
              strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', qryTabOriginal.Fields[intContador].AsDateTime))
            Else
              strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd hh:mm:ss', qryTabOriginal.Fields[intContador].AsDateTime));

          End
          Else If (qryTabOriginal.Fields[intContador].DataType = ftTime) Then
            If qryTabOriginal.Fields[intContador].AsString = '' Then
              strSQL := strSQL + 'NULL'
            Else
              strSQL := strSQL + QuotedStr(FormatDateTime('hh:mm:ss', qryTabOriginal.Fields[intContador].AsDateTime))

          Else
            {**********************}
            {* VERIFICA SE … NULO *}
            {*******************AF*}
            If qryTabOriginal.Fields[intContador].AsString = '' Then
            Begin
              If Pos('_NOMFRM', qryTabOriginal.Fields[intContador].FieldName) > 0 Then
                strSQL := strSQL + QuotedStr(strNomfrm)
              Else If qryTabOriginal.Fields[intContador].Required Or
                      fRequeridoNatTabDel(qryTabOriginal.Fields[intContador].FieldName) Then
                strSQL := strSQL + QuotedStr('')
              Else
                strSQL := strSQL + 'NULL';
            End
            Else
              If (qryTabOriginal.Fields[intContador].DataType = ftString) Or
                 (qryTabOriginal.Fields[intContador].DataType = ftMemo) Or
                 ((qryTabOriginal.Fields[intContador].DataType = ftBlob) And
                  ((SameText(strTabela, 'CADMOD') OR SameText(strTabela, 'CADREL')))) Then
              Begin
                strSQL := strSQL + QuotedStr(qryTabOriginal.Fields[intContador].AsString);
              End

              Else If (qryTabOriginal.Fields[intContador].DataType = ftFloat)    Or
                      (qryTabOriginal.Fields[intContador].DataType = ftCurrency) Or
                      (qryTabOriginal.Fields[intContador].DataType = ftBCD)      Then
              Begin
                strSQL := strSQL + AnsiReplaceStr(qryTabOriginal.Fields[intContador].AsString, ',', '.');
              End

              Else
                strSQL := strSQL + qryTabOriginal.Fields[intContador].AsString;
        End;

        If intContador <> qryTabOriginal.FieldCount-1 Then
          If qryTabOriginal.Fields[intContador+1].FieldKind = fkData Then
            strSQL := strSQL + ', ';
      End;

      strSQL := strSQL + ', ' + QuotedStr(strOpeDel);
      strSQL := strSQL + ', ' + untFuncoesSimples.fCurrentDate + ' ';
      strSQL := strSQL + ', ' + QuotedStr(FormatDateTime('hh:mm:ss', VS_Date + fTime()));

      If MatchStr(strTabela, ['MOVGER', 'NOTGER', 'FATGOR', 'MONPIX_LOG']) Then
        strSQL := strSQL + ', ' + QuotedStr(strMotDel) + IIF(blnGrvOpcDel,' ,'+QuotedStr(strOpcDel),' ') + ' )'
      Else
        strSQL := strSQL + ' )';

      If blnGravar Then
      Begin
        With qryGenDel Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ExecSQL;
        End;

        If Not blnTabAux Then
          pVerificaIntegridadeComplementar(strNomFrm,
                                           strTabela,
                                           qryTabOriginal,
                                           blnGravar,
                                           blnSoCriaTabela,
                                           strMotDel,
                                           strOpeDel);

      End
      Else
        Result := strSQL;

    Except
      On E:Exception Do
      Begin
        Result := '';

        Raise Exception.Create('Ocorreu um erro durante a gravaÁ„o do arquivo de deletado(s).' + #13 + E.Message + #13 +
                               'Tabela: ' + strTabela + '.');
      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
    FreeAndNil(qryGenDel);
    FreeAndNil(qryGenIte);
    If Assigned(qryGenReq) Then
      FreeAndNil(qryGenReq);
  End;

End;

function fRetDescFpg(Const strCodFpg: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodFpg) Then
    Exit;

  Result := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], [strCodFpg], False);

End;

function fRetClientesFilial: String;
  Var
    intContador: Integer;
    strSQL     : String;
    qryGenerica: TUniQuery;

Begin

  //*************************************************//
  // CRIA UMA QUERY DINAMICA                         //
  //**********************************************ED*//
  qryGenerica := fCriaQuery;


  Result := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  EMP_CLIFIL ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';

  With qryGenerica Do
  Begin
    CLose;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    For intContador := 0 To RecordCount -1 Do
    Begin

      If Not fEmptyStr( FieldByName('EMP_CLIFIL').AsString ) Then
        Result := Result + QuotedStr(FieldByName('EMP_CLIFIL').AsString) + ',';

      Next;
    End;

    Result := Copy( Result, 1, Length( Result ) - 1 );

    Close;
  End;

  FreeAndNil(qryGenerica);

  If (fEmptyStr(Result)) Then
    Result := '""';

End;

{********************************************}
{* AJUSTA O RELOGIO DO WINDOWS TOMANDO COMO *}
{* BASE A DATA DO SERVIDOR                  *}
{*****************************************MV*}
function fAjustaDataSistema: Boolean;
{$IFDEF LINUX}
begin
  Result := Services.Core.Connection.Manager.fAjustaDataSistema();
end;
{$ELSE}
  Var
    dtaWindows : _SYSTEMTIME;
    wrdDia     : Word;
    wrdMes     : Word;
    wrdAno     : Word;
    wrdHora    : Word;
    wrdMinuto  : Word;
    wrdSegundo : Word;
    wrdMilSec  : Word;
    qryGenTmp  : TUniQuery;
    dtaHora    : TDateTime;
begin
  qryGenTmp := fCriaQuery;
  Try
    Try
      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
        Open;
        VS_Date := FieldByName('CURRENT_DATE').AsDateTime;
        dtaHora := FieldByName('CURRENT_TIME').AsDateTime;

        DecodeDate(FieldByName('CURRENT_DATE').AsDateTime, wrdAno, wrdMes, wrdDia);
        DecodeTime(dtaHora, wrdHora, wrdMinuto, wrdSegundo, wrdMilSec);
        Close;
      End;

      If (Not fEmptyStr(VS_strCodEmp)) And (fCfgSis('AJUDTA') = 'S') Then
      Begin
        GetLocalTime(dtaWindows);
        dtaWindows.wYear  := wrdAno;
        dtaWindows.wMonth := wrdMes;
        dtaWindows.wDay   := wrdDia;

        dtaWindows.wHour   := wrdHora;
        dtaWindows.wMinute := wrdMinuto;
        dtaWindows.wSecond := wrdSegundo;
        dtaWindows.wMilliseconds := wrdMilSec;
        SetLocalTime(dtaWindows);
      End;

      Result := True;
    Except
      Result := False;
    End;
  Finally
    FreeAndNil(qryGenTmp);
  End;
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure pConectarModulos;
begin
  pCriarFormularios(TfrmModulo, frmModulo);
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));
end;
{$ENDIF}

{$IFNDEF LINUX}
procedure pFinalizarModulos;
begin
  pDestroiModulo(frmModuloReplicacao);
  pFecharBanco(frmModulo.GetCurrentConnection);
  pDestroiModulo(frmModulo);
end;
{$ENDIF}

function fExecutandoPeloPortal: Boolean;
begin
  Result := ParamCount >= 6;
end;

function GetParamValue(AParamID: String): String;
Var
  I: Integer;
begin
  Result := '';
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(Copy(ParamStr(I), Length(AParamID) + 1, MaxInt));
end;

function HasParam(AParamID: String): Boolean;
Var
  I: Integer;
begin
  Result := False;
  for I := 1 to ParamCount do
    if ParamStr(I).StartsWith(AParamID, True) then
      exit(True);
end;

procedure pDefinirEmpresa;
begin
{$IFDEF LINUX}
  If fEmptyStr(GetParamValue('-e')) Then
    Raise Exception.Create('N„o foi informado o cÛdigo da empresa');
  Services.Core.Settings.pDefinirEmpresa(GetParamValue('-e'));
{$ELSE}
  If fExecutandoPeloPortal Then
  Begin
    VS_strCodEmp := InputBox(ParamStr(5), 'Informe o cÛdigo da empresa logada:', '001');
    Exit;
  End;
  If fEmptyStr(ParamStr(1)) Then
    Raise Exception.Create('N„o foi informado o cÛdigo da empresa');
  VS_strCodEmp := ParamStr(1);
{$ENDIF}
end;

procedure pDefinirUsuario;
begin
{$IFDEF LINUX}
  Services.Core.Settings.pDefinirUsuario;
{$ELSE}
  strLoginUsuarioLogado := LOG_ADM;
  If VS_strCodEmp.IsEmpty Then
    VS_strCodEmp := fRetEmpresaFisica;
  If (Not fEmptyStr(fRetNomeOperador(fCfgSis('OPEAUT')))) Then
    strLoginUsuarioLogado := fCfgSis('OPEAUT');
{$ENDIF}
end;

procedure pIniciarVariaveis;
begin
{$IFDEF LINUX}
  Services.Core.Settings.pIniciarVariaveis;
{$ELSE}
  VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));

  VS_strCliFil := fRetClientesFilial;
  VS_strUsaTmq := fCfgSis('USATMQ');
  VS_strTipExp := fCfgSis('TIPEXP', varString);
  VS_TSPlus    := (fArqIni(0, 'GERAL', 'TSPLUS', '') = 'S');
  VS_strTabPrc := fCfgSis('TABPRC');

  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));

  VS_strRazSoc    := untFuncoesSimples.fCadEmp('NOMEMP');
  VS_PathAutCom   := ExtractFilePath(Application.ExeName);

  VS_strTxjCni    := fArqIni(0, 'GERAL', 'TXJCNI', '');
{$ENDIF}
end;

{****************************************}
{* EXECUTA A SQL PASSADA POR PARAMETRO  *}
{*************************************AF*}
function fExecutaSQL(strSQL: String; blnRaise: Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
Begin

	Try

    qryGen := fCriaQuery;
    Result := True;

		With qryGen do
		Begin
			Close;
			SQL.Clear;
			SQL.Add(strSQL);
      ExecSQL;
		End;

	Except
		On E: Exception do
		Begin
      If (blnRaise) Then
        Raise
      Else
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fExecutaSQL]');
      End;
		End;
	End;

  FreeAndNil(qryGen);

End;

function fEhTabelaDeContabilidade(strTabela: string): boolean;
begin
  Result := MatchStr(strTabela, ['LANCON', 'PARCON', 'HISPAD', 'PLANCO']);
end;

function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
var
  arrValores : TArray<String>;
  intContador: Integer;
  strResultado: String;
Begin
  arrValores := strValores.Split(strDelimitador);

  For intContador := 0 To Length(arrValores)-1 Do
  Begin
    if strResultado = '""' then
      strResultado := '';

    if not fEmptyStr(strResultado) then
      strResultado := strResultado + ', "' + arrValores[intContador] + '"'
    else
      strResultado := '"' + arrValores[intContador] + '"';
  end;

  Result := strResultado;
End;

function fTamDocCadRec: Integer;
var qryAux: TUniQuery;
Begin
  Result := VS_intTamDocCadRec;
  If (Result = 6) Or (Result = 12) Then
    Exit;

  Result := 6;
  VS_intTamDocCadRec := Result;

  qryAux := fCriaQuery();
  qryAux.SQL.Text := 'DESC CADREC';
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    If qryAux.FieldByName('Field').AsString = 'CTR_NUMDUP' Then
    Begin
      If UpperCase(qryAux.FieldByName('Type').AsString) = 'VARCHAR(6)' Then
        Result := 6
      Else
        Result := 12;

      VS_intTamDocCadRec := Result;
      Break;
    End;

    qryAux.Next;
  End;
  FreeAndNil(qryAux);
End;

function fRetCGCEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_C_G_C_ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;
      Result := FieldByName('EMP_C_G_C_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
Begin

  Result := '';

  If fEmptyStr(strCodigo) Then
    Exit;

  If (intOpcao = 0) Then
    Result := fCampoTabela('CID_NOMCID', 'CADCID', ['CID_CODCID'], [strCodigo], False)
  Else
    Result := fCampoTabela('CID_ESTADO', 'CADCID', ['CID_CODCID'], [strCodigo], False);

End;

function fRetNomCliente(Const strCodCli: String): String;
var
  qryAux: TUniQuery;
Begin
  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    qryAux := fCriaQuery();
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT CLI_NOMCLI');
      qryAux.SQL.Add('FROM CADCLI');
      qryAux.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
      qryAux.SQL.Add(fGetFiltroClienteEmpresaIdentificadora(strLoginUsuarioLogado));
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;

      Result := qryAux.FieldByName('CLI_NOMCLI').AsString;
    Finally
      FreeAndNil(qryAux);
    End;
  End
  Else
  Begin
    Result := fCampoTabela('CLI_NOMCLI', 'CADCLI', ['CLI_CODCLI'], [strCodCli], False);
  End;
End;

function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
begin
  Result := '';

  if blnComAnd Then
    Result := Result + ' AND ';

  If fCfgSis('IDEEMP', VarBoolean) Then
  Begin
    Result := Result + ' ( ';
    Result := Result + '   (LOCATE(CLI_EMPIDE,' + QuotedStr(fRetEmpAcessoUsuario(strCodOpe)) + ') > 0) OR ';
    Result := Result + '   (CLI_EMPIDE IS NULL) OR ';
    Result := Result + '   (CLI_EMPIDE = "") ';
    Result := Result + ' ) ';
  End
  Else
    Result := Result + ' TRUE ';
end;

function fRetEmpAcessoUsuario(strCodOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;

begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_EMPACE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;
      Result := FieldByName('OPE_EMPACE').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;


function fRetEmpresaOperador(strCodOpe: String): String;
begin
  Result := fCampoTabela('OPE_CODEMP', 'CADOPE', ['OPE_CODOPE'], [strCodOpe]);
end;

procedure pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
Begin

  If (fCfgSis('CXAEXP', VarString) = '2') Then
    Exit;

  If (fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel)) Then
  Begin
    pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli);
  End;

End;

function fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT                           ';
    strSQL := strSQL + '  CTR_NUMDUP                     ';
    strSQL := strSQL + 'FROM                             ';
    strSQL := strSQL + '  CADREC                         ';
    strSQL := strSQL + 'WHERE                            ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP    AND    ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC    AND    ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP    AND    ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI    AND    ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL    AND    ';
    strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND    ';  // VERIFICA SE … PARCELA … A VISTA
    strSQL := strSQL + '  CTR_VALDUP = 0          AND    ';  // FOI TOTALMENTE QUITADA.
    strSQL := strSQL + '  CTR_SEQBAI = 0                 ';

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('PARCEL').AsString := strParcel;
      Open;

      Result := (Not IsEmpty);
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

End;

procedure pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
Var
  strSQL: String;
  qryCtr: TUniQuery;
Begin

  Try

    qryCtr := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'UPDATE                     ';
    strSQL := strSQL + '  MOVGER                   ';
    strSQL := strSQL + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM ';
    strSQL := strSQL + 'SET                        ';
    strSQL := strSQL + '  GER_OPLBRC = :OPLBRC,    ';
    strSQL := strSQL + '  GER_DTLBRC = :DTLBRC,    ';
    strSQL := strSQL + '  GER_HRLBRC = :HRLBRC,    ';
    strSQL := strSQL + '  AUX_LBRCAU = "S"         ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  GER_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  GER_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  GER_DTLBRC IS NULL       ';  // ATUALIZA SOMENTE SE O DOCUMENTO N√O TEVE LIBERA«√O

    With qryCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('OPLBRC').AsString   := strLoginUsuarioLogado;
      ParamByName('DTLBRC').AsDateTime := VS_Date;
      ParamByName('HRLBRC').AsDateTime := fTime();
      ParamByName('NUMDOC').AsString   := strNumDup;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODCLI').AsString   := strCodCli;
      ExecSQL;
    End;

  Finally
    FreeAndNil(qryCtr);
  End;

End;


function fRetNomBanco(Const strCodBco: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

end;

function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
 AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
  Var
    intCont  : Integer;
    intRecno : Integer;
begin

  Result := TUniClientDataSet.Create(AOwner);

  For intCont := 0 To qryOrigem.Fields.Count -1 Do
    With Result.FieldDefs.AddFieldDef Do
    Begin
      Name     := qryOrigem.Fields[intCont].FieldName;
      DataType := qryOrigem.Fields[intCont].DataType;
      Size     := qryOrigem.Fields[intCont].Size;
      Required := False;
    End;

  Result.CreateDataSet;
  Result.Open;

  Result.LogChanges := False;

  If blnVazio Then
    Exit;

  With qryOrigem Do
  Begin
    intRecno := RecNo;
    DisableControls;

    If Not blnRegistroAtual Then
      First;

    While (Not Eof) Or blnRegistroAtual Do
    Begin
      Result.Append;

      For intCont := 0 To Fields.Count -1 Do
        Result.Fields[intCont].Value := Fields[intCont].Value;

      Result.Post;

      If blnRegistroAtual Then
        Break;

      Next;
    End;
    RecNo := intRecno;
    EnableControls;
  End;

end;

procedure pGravaLogContabil(strSQL, strTabela: string);

  function fExtrairTipLan: string;
    const
      FIELD_TO_FIND : String = 'CON_TIPLAN';
      arrIgnoreChar : array[1..3] of string = ('=', '"', chr(39));
      MAX_LENGTH_TIPLAN : Integer = 3;
    var
      intPos : Integer;
      intCnt : Integer;
  begin
    Result := '';

    intPos := Pos(FIELD_TO_FIND, strSQL);

    if (intPos > 0) then
    begin
      intPos := intPos + Length(FIELD_TO_FIND);
      for intCnt := intPos to Length(strSQL) do
      begin
        if not fEmptyStr(strSQL[intCnt]) then
        begin
          if not (MatchStr(strSQL[intCnt], arrIgnoreChar)) then
            Result := Result + strSQL[intCnt];
        end;

        if Length(Result) = MAX_LENGTH_TIPLAN then
          break;
      end;
    end;
  end;

  var
    qryLogCtl : TUniQuery;
begin
  if strSQL.IsEmpty then
    exit;

  if (LeftStr(strSQL, 30).Contains('INSERT')) then
    exit;

  qryLogCtl := fCriaQuery;
  try
    qryLogCtl.SQL.Text := 'SELECT * FROM LOGCTL WHERE FALSE';
    qryLogCtl.Open;
    qryLogCtl.Insert;
    qryLogCtl.FieldByName('CTL_CODEMP').AsString := VS_strCodEmp;
    qryLogCtl.FieldByName('CTL_DTALOG').AsDateTime := VS_Date;
    qryLogCtl.FieldByName('CTL_HORLOG').AsDateTime := fTime();
    qryLogCtl.FieldByName('CTL_TABELA').AsString := strTabela;

    if (strTabela = 'LANCON') then
      qryLogCtl.FieldByName('CTL_TIPLAN').AsString := fExtrairTipLan;

    qryLogCtl.FieldByName('CTL_COMAND').AsString := strSQL;
    qryLogCtl.FieldByName('CTL_CODOPE').AsString := strLoginUsuarioLogado;
    qryLogCtl.Post;
  finally
    FreeAndNil(qryLogCtl);
  end;
end;

function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
begin
  Result := ' IF((           '+strCampoNomCli+' LIKE "%CONSUMIDOR%")'+
    +IIF(blnCliBalcao, ' OR ('+strCampoNomCli+' LIKE "%BALCAO%"'+') OR ('+strCampoNomCli+' LIKE "%BALC√O%")', '')+
    +IIF(blnCliSegura, ' OR ('+strCampoNomCli+' LIKE "%SEGURADORA%")', '')+', '+strCampoCliCon+', '+strCampoCadCli+') ';
end;

function fRetornaDataHoraServidor: TDateTime;
var
  qryDtaHra : TUniQuery;
begin

  qryDtaHra := fCriaQuery();

  Try

    qryDtaHra.Close;
    qryDtaHra.SQL.Clear;
    qryDtaHra.SQL.Add('SELECT CURRENT_TIMESTAMP AS DATA_HORA');
    qryDtaHra.Open;

    If Not qryDtaHra.IsEmpty Then
      Result := qryDtaHra.FieldByName('DATA_HORA').AsDateTime
    Else
      Result := 0;

  Finally
    FreeAndNil(qryDtaHra);
  End;

end;

function fValN(Variable: Nullable<String>): String;
Begin
  If Variable.HasValue Then Result := Variable.Value
  Else Result := '';
End;

function fValN(Variable: Nullable<Integer>): Integer;
Begin
  If Variable.HasValue Then Result := Variable.Value
  Else Result := 0;
End;

function fValN(Variable: Nullable<Double>): Double; overload;
Begin
  If Variable.HasValue Then Result := Variable.Value
  Else Result := 0;
End;

function fUsaDoisMonitores: Boolean;
Begin
{$IFDEF LINUX}
  Result := False;
{$ELSE}
  Result := Screen.MonitorCount > 1;
{$ENDIF}
End;

function fUsaLayoutNovo: Boolean;
Begin
{$IFDEF LINUX}
  Result := False;
{$ELSE}
  Result := //(Not blnUsuarioLogadoUtilizaModoClassico) And
            (TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME);
{$ENDIF}
End;

procedure pCentralizarForm(AForm: TForm);
{$IFDEF LINUX}
begin

end;
{$ELSE}
var
  LMonitor: TMonitor;
  LHandle: HWND;
begin
  if Assigned(Application.MainForm) and IsWindow(Application.MainForm.Handle) then
    LHandle := Application.MainForm.Handle
  else
    LHandle := Application.Handle;

  LMonitor   := TMonitor(Screen.MonitorFromWindow(LHandle));
  AForm.Left := LMonitor.Left + Round(LMonitor.WorkareaRect.Width / 2) - Round(AForm.Width / 2);
  AForm.Top  := Round(LMonitor.WorkareaRect.Height / 2) - Round(AForm.Height / 2);
End;
{$ENDIF}

{***************************************************************}
{* PROCEDURE QUE VERIFICA SE A TABELA PASSADA COMO PARAMETRO   *}
{* ESTA CADASTRADA NA TABELA DE PROXIMOS CODIGOS, CASO N√O     *}
{* CADASTRA AUTOMATICAMENTE USANDO OS VALORES DO VETOR PROCOD  *}
{************************************************************JC*}
procedure pValidaProCod(strNomeTabela: String; conexao: TUniConnection = nil);
  Var
    strSQL     : String;
    qryGenCod  : TUniQuery;
    intContador: Integer;
begin
  If Length(arrProCod) <= 0 Then
    pVerificaProCod;
  {*****************************************************}
  {* FILTRO DE TABELAS QUE N√O DEVEM SER VERIFICADAS   *}
  {**************************************************JC*}
  If Not ((LeftStr(strNomeTabela,2) <> 'I_')   And
         (LeftStr(strNomeTabela,3) <> 'TMP')  And
         (LeftStr(strNomeTabela,4) <> 'DEL_') And
         (Pos(strNomeTabela, 'CFGSIS_CNFCHQ_CNFETI_CNF_NF_TABNRE_SEQLOG_APGTMP') <= 0)) Then
    Exit;

  fStartTransacationAutoincrem(conexao);
  Try
  Try

    if Assigned(conexao) then
      qryGenCod := fCriaQuery(Nil, conexao)
    else
      qryGenCod := fCriaQuery(Nil, fRetConexaoAutoincrem);

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_NOMARQ ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ';

    With qryGenCod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      If IsEmpty Then
      Begin
        For intContador := 0 To Length(arrProCod) - 1 Do
        Begin
          If (strNomeTabela = arrProCod[intContador].strNomArq)  Then
          Begin
            Close;
            SQL.Clear;
            SQL.Add(' SELECT * FROM PROCOD');
            Open;
            Insert;
            FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
            FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
            FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
            FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD', VS_strCodEmp, -1, fInTransaction(conexao), conexao);
            FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica(conexao);
            FieldByName('PRO_CODAUT').AsString  := arrProCod[intcontador].strCodAut;
            Post;
            Close;

            SQL.Clear;
            SQL.Add(' SELECT * FROM PROINC WHERE PRO_NOMARQ = :NOMARQ');
            ParamByName('NOMARQ').AsString := arrProCod[intcontador].strNomArq;
            Open;
            If IsEmpty Then
            Begin
              Insert;
              FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
              FieldByName('PRO_AUTINC').AsString  := '1';
              FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp, -1, fInTransaction(conexao), conexao);
              Post;
            End;

            Close;
            Break;
          End;
        End;

        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NOMARQ').AsString := strNomeTabela;
        Open;
        If IsEmpty Then
        Begin
          Raise Exception.Create('A Tabela '+strNomeTabela+' n„o foi encontrada no Vetor PROCOD' + #13#10 +
                                 '[fValidaProcod].');

          Close;
        End;
      End;
    End;
    fCommitAutoincrem(conexao);
  Except
    On E: Exception Do
    Begin
      fRollbackAutoincrem(conexao);
      Raise;
    End;
  End;
  Finally
    FreeAndNil(qryGenCod);
  End;

end;

procedure pValidarProcodTabelaVERREC;
begin
  SetLength(arrProCod, Length(arrProCod)+1);
  arrProCod[Length(arrProCod)-1].strNomArq := 'VERREC';
  arrProCod[Length(arrProCod)-1].strCodSeq := '000000000001';
  arrProCod[Length(arrProCod)-1].intTamCod := 12;
  arrProCod[Length(arrProCod)-1].strCodAut := 'S';
  arrProCod[Length(arrProCod)-1].intAutInc := 1;
  pValidaProCod('VERREC');
end;

procedure pVerificaProCod;
  Var
    intPosMat: Integer;

    function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
    Begin
      intVal := intVal + intSoma;
      Result := intVal + 1;
    End;
Begin
  intPosMat := 0;
  SetLength(arrProCod, 1);

  arrProCod[intPosMat].strNomArq := 'ACAGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EVENEC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADQNSU';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOTATE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGECOM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGETEL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEVIS';
  arrProCod[intPosMat].strCodSeq := '00000002';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000000001';
  arrProCod[intPosMat].intTamCod := 9;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BONDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BONGEN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BONGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZA_CADBZA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PFA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PFA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PFA_CADPFA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADV_CADADV';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZI_CADBZI';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BSN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BSN_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BSN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BSN_CADBSN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CSN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CSN_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CSN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CSN_CADCSN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'C11_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'C11_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'C11_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'C11_CADC11';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GBC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GBC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GBC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GBC_CADGBC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLT_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLT_CADBLT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEX_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEX_CADTEX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADV_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADV_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROB_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROB_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROB_CADROB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ABFICM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RESCAT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADNCM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NCMICM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NCMPIS';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NCMCOF';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NCMIPI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MATICM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ICMALQ';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADACA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ATRNUM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ATRSTR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ATRDAT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEDTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUATR';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADATR';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADATI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEQP';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADANA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANAGER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANADET';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQPFAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOMORD';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ATIGRU';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBCA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBCO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCAR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCRE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCFO';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCHQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCID';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCLI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCND';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCOB';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUPCOB';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METCOB';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCOM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCTA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDIV';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADECF';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEMI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEMP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPBAN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPPRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPPAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEVE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCGO';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDPT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTFU';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADHOB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADESC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGMU';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDES';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADECI';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVOCO';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISOCO';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADEGER';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADEDET';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OCOEME';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFIS';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITECOM';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MNUACE';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MNUFAV';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFOR';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MINMAX';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NIVFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFPG';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGPO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGRU';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGPR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADIMP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IDEIMP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGUN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEGUN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDEP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADIPR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADINT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADINTTUD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADIRR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADITE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADLOG';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMET';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMOT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADAJU';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCUP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCUP';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTPA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMSG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADOPE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPAG';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPOR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CARPOR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPRE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPRO';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROBRI_GER';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADTCLI';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRCXX';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADREC';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRED';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADREG';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VINREG';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REGFHO';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPAR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FASOBR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORCUS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPSER';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STASER';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSFZ';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTRA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTRI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADUNI';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADVEI';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MODVEI';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MARVEI';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORVEI';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAMDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAMGEN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAMGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CATITE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGATB';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGPDC';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGPCM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGREQ';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGREL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHQDEV';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHQEMI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLICON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIPRO';
  arrProCod[intPosMat].strCodSeq := '000001';  {************************************************}
  arrProCod[intPosMat].intTamCod := 6;         {* BLOCO ADICIONADO PARA VALIDA«√O DO CADASTRO  *}
  arrProCod[intPosMat].strCodAut := 'S';       {* DE CLIENTES RELACIONAMENTO COM PRODUTOS AP”S *}
  arrProCod[intPosMat].intAutInc := 1;         {* TESTAR GRAVA«√O COM A NOVA CONDULTA DE ITENS *}
  SetLength(arrProCod, fSoma(intPosMat));      {*12/07/2011**********************************JU*}

  arrProCod[intPosMat].strNomArq := 'CLIVEI';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLUFID';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNFBOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMOPE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMPRO';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIMO_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIMO_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIMO_CADCOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIMO_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADT_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADV_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEL_EMBALA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'CORIMO_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIND_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIND_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIND_CADCOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIND_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORIND_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HYD_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HYD_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HYD_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HYD_CADEMB';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HYD_CADHYD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTAGER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTARES';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTPDET';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAC_CADDAC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETPRO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUPAGP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUPAGR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUP_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := '';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUP_CADDUP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := '';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUX_CADDUX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DU2_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := '';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DU2_CADDU2';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DU2_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'ECFALQ';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFMOD';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENTDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENTGER';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamDocCadRec);
  arrProCod[intPosMat].intTamCod := fTamDocCadRec;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLICTT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPSOC';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADEUC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATDOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATGOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORCIT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORCTT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TRACTT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUT_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUT_CADFUT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SPA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SPA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SPA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SPA_CADSPA';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZI_CADMZI';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEB_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEB_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEB_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEB_CADVEB';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PAR_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PAR_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PAR_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PAR_CADPAR';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MON_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MON_CADCOL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MON_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MON_CADMON';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GERMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADGEN';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADMON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GIRITE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUUSU';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISENT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISPED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISPAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IQU_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IQU_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IQU_CADIQU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IQU_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IQU_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIK_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIK_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIK_CADLIK';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIK_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIK_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REC_CADREC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REC_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLO_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLO_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLO_CADGLO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLO_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLO_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJA_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJA_CADAJA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REN_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REN_CADREN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REN_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEC_CADEMB';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEC_CADLEC';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GCC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GCC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GCC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GCC_CADGCC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INK_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INK_CADCOL';
  arrProCod[intPosMat].strCodSeq := '02';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INK_CADINK';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INK_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANN_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANN_CADANN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANN_CADEMB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAX_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAX_CADMAX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DOX_CADDOX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DOX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DOX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DOX_CADDIL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEGER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SALPDC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEPRO';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGIPR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEREP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAYIMP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEDITE';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEDCAD';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KILD_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KILD_CADCOL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KILD_CADKIL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KILD_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIL_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIL_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIL_CADKIL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIL_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAZ_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAZ_CADMIX';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAZ_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAZ_MIXFOR';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KRE_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KRE_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KRE_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KRE_CADKRE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKC_CADLKC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADCLB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEI_CADLEI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAE_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAE_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAE_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAE_CADMAE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SIN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SIN_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SIN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SIN_CADSIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodSeq := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));



  arrProCod[intPosMat].strNomArq := 'LKS_CADBAS';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKS_CADCOL';
  arrProCod[intPosMat].strCodSeq := '01';
  arrProCod[intPosMat].intTamCod := 2;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKS_CADLKS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKS_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIBPED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEGPED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCLI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGLPX';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCTR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGVAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCPR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCCL';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METCLI';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamDocCadRec);
  arrProCod[intPosMat].intTamCod := fTamDocCadRec;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVBAN';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCAR';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamDocCadRec);
  arrProCod[intPosMat].intTamCod := fTamDocCadRec;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGAD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGAG';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamDocCadRec);
  arrProCod[intPosMat].intTamCod := fTamDocCadRec;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGAU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVMOD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVPRO';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamDocCadRec);
  arrProCod[intPosMat].intTamCod := fTamDocCadRec;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVREC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRECX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVSBA';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTCTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OPEGPO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PCDDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PCMDET';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PCMGER';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPG_CADPPG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PREALT';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PREITE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PREPTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FDOABS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROCOD';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FGOAJU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GERAJU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'REI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REI_CADCOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMDETX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMOBSX';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMGERX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SAL_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SAL_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SAL_CADSAL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHE_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHE_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHE_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHE_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHE_CADSHE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHW_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHW_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHW_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SHW_CADSHW';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADGRU';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADMON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADSGR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADSKY';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUV_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUV_CADCOL';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUV_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUV_CADSUV';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BAU_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BAU_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BAU_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BAU_CADBAU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'QUA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QUA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QUA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QUA_CADQUA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QUACLI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BEL_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BEL_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BEL_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BEL_CADBEL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CIA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CIA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CIA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CIA_CADCIA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'JOT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'JOT_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'JOT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'JOT_CADJOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALV_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALV_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALV_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALV_CADALV';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'MEG_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEG_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEG_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEG_CADMEG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALP_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALP_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALP_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALP_CADALP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRA_CADGRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TINDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TINDOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TINGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TINGOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPCLD';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPCLG';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WANPRO_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WAN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ZYN_CADZYN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TELCON';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGITE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADAUT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCBI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCFG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFIC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIRCO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTIP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTRCNF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIRBAN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIRGPO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIRGPT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIRGPB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIROPE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIRTIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUP_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'DUX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FPGECF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKD_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKD_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKD_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKD_CADLKD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LKD_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGERR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGEXE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGLIB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGREP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGRER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REI_CADREI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REI_FMLREI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RETBCO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STA_CADSTA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WANPRO_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WANPRO_CADWAN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WAN_BASWAN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WAN_CADWAN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIVFAT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IMPLIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGDES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSEM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQUGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQUDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQUSER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQUDFE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQUOBS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFER';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMPES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMOUTX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTADET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SALINV';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMENG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMEND';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMFAT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRTF';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUV_NFMEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORTIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADIMO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGROM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSOC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRU_COMPRA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVVPG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVVPD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADCAT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADDIL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUT_CADSIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COTGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COTGRU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COTITE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAC_UNIDAC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETELE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADEUC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EUC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAR_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAR_CADFAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAR_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAR_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GERELE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLA_CADGLA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GLA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IMPLIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPX_CADPPX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'PPX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPX_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPG_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPG_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PPG_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SOL_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SOL_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SOL_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SOL_CADSOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETMET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METMAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTRES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LITGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAZ_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAZ_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAZ_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MAZ_CADMAZ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBAN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGNR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGFUT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGLOC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCFG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MANKMT';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADLOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMREC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENTCLI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFAZ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADQUA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIVEN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGEST';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMESP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COTGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORPRE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADOCO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFUN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADVER';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTRPAG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMTR';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGVEN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ZYN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ZYN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAYETI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMOD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADREL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTEM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCAM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPRR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUPAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RELMEN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDIR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  {***********************}
  {*NOVA TABELA CADCAC ***}
  {**24/02/2011-17:10 *DP*}
  arrProCod[intPosMat].strNomArq := 'CADCAC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONAGE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFIN';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INDFIN';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADVCOR_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADVCOR_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADVCOR_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADVCOR_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADVCOR_CADADV';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADSKY';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SKY_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADGEN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PONIMP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FILSEP';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FILBOL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTPRE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIGELE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PEDELE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEFGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LEFDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSAC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RSI_CADRSI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RSI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RSI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RSI_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RSI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VENCND';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CARCOB';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATPRE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONENT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADAPL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIDES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REGDES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORCTA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCCC';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMFAV';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVFIN';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATFIN';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANJ_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANJ_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANJ_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANJ_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ANJ_CADANJ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WEG_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WEG_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WEG_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WEG_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WEG_CADWEG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));
  //
  arrProCod[intPosMat].strNomArq := 'AJT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJT_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJT_CADAJT';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADNFM';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADALK';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALA_CADDIL';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALA_CADALA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLA_CADBLA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'BLA_CADLIN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BLA_CADMON';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADLCA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COA_CADMON';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COA_CADLIN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COA_CADCOA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

    arrProCod[intPosMat].strNomArq := 'MIF_CADBAS';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MIF_CADMON';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MIF_CADLIN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MIF_CADNFM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MIF_CADMFI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  //
  arrProCod[intPosMat].strNomArq := 'MZA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZA_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZA_CADLIN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZA_CADMZA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LCA_CADLCA';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'MZD_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'MZD_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZD_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZD_CADLIN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MZD_CADMZD';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REP_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REP_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REP_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REP_CADREP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADLIN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADORI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADKIN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGRO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGRO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FXADES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAIDES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FXAVEN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAVDES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAIDIV';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMCUS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLICND';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIDEP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PISSAI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PISENT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COFSAI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COFENT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IPISAI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IPIENT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUNFER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTFIN';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPCND';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEBAR';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITETAB';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALTEST';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PGOGER';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FINEMP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALTEST';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SITPRO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTAFOR';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  If {$IFNDEF LINUX}(fSetaPais = opcParaguai) Or {$ENDIF}fCfgSis('COTDOR', VarBoolean) Then
  Begin
    arrProCod[intPosMat].strNomArq := 'CADMOE';
    arrProCod[intPosMat].strCodSeq := '000001';
    arrProCod[intPosMat].intTamCod := 6;
    arrProCod[intPosMat].strCodAut := 'S';
    arrProCod[intPosMat].intAutInc := 1;
    SetLength(arrProCod, fSoma(intPosMat));
  End;

  arrProCod[intPosMat].strNomArq := 'CADLOC';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADAMZ';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONAMZ';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPME';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUTABA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FUNBNF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PCMCON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCTP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOTVPD';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGENDA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FRETRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADSUB';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PERRES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPES';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PESPER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEPES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDEPG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TABPRE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDEPD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEX_CADNEX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEX_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEX_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEX_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NEX_REGDIL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONPPR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CARDES';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDPG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDPD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDMG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMDMD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCOR';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NUMCMP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEIMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DEIMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEDMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DEDMAT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DEICOR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GERCPA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETCPA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PORCHQ';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REPFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTCON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFAS';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GERCOM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETCOM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDGER';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDDET';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALE_CADALE';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALE_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALE_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALE_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALE_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CC_NFE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRPPRD';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCHQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MCPGER';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FERCID';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CARPRO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 2;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRDZ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RDZTOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADONU';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIBPRN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VALGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUPELE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALTPAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVTIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMPC';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETMPC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRCG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRCD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INT_CADINT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INT_CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INT_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FDOSEP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADIBP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METVDE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METVLG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMDELX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMITEX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGAT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'METATI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGTPA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROAUX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'MOVGRC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRAP';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGDIR';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAL_CADCAL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALTDES';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CARANU';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGFRE';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGCON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));


  arrProCod[intPosMat].strNomArq := 'DAVPVG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DAVPVD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCPR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJICST';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDORI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRUITC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRUCND';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRUGRU';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORCVID';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCPL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DEFLOT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTDOR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TRISER';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCUS';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OUTICM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'INFELE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVINF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CREFIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORNEO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FISAJU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CCCLIE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CCFORE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CCCARE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTCEMP';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONDET';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISBAL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SEQCOM';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMFOR';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADADE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGTIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVTEF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGMED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVDR05';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVCR08';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVCR12';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COCFIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBAI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIBAT';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FISAJD';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLACON';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADLSE';
  arrProCod[intPosMat].strCodSeq := untFuncoesSimples.fStrZero('1', fTamCodLse);
  arrProCod[intPosMat].intTamCod := fTamCodLse;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVDR05';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVCR08';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RED_EVCR12';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVCDB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAD800';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLI800';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MSGNEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RECCOM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OUTDIGX';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FGOCAI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMRE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDFE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEQU';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEIQUA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'UNI_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'UNI_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'UNI_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'UNI_CADUNI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIATI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENQIPI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANCHQ';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANCTR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANCTP';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANTRF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANMCA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEL_CADVEL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEL_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEL_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEL_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTEOP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZC_CADBZC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZC_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZC_CADMON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BZC_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGPRO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPRV';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SITOCO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOCORP';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROSPE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDLOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADNEG';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CMPNEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TABNEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITENEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLINEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUSER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_158_SPED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONSEP';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_158';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COEC17';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMUTI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONEQL';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMUTI_DADOS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CDCEST';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMAENV';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMPTRI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGFPG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGBAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGATB';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MEQMER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TRALOF';
  arrProCod[intPosMat].strCodSeq := '00000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEEMB';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDEST';
  arrProCod[intPosMat].strCodSeq := '000';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPANA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ESPTEC';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ETEMAT';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TANPRO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ETEPRO';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VENMAR';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVFLE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOTVBA';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADVBA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VENEMP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADNPS';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMVEN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROATI';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROCOM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROSIM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ELEGRU';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ELEMAR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ELEFOR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ELEGPR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ELEGPD';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMEMP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGCXA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMCO';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRQD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRQG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NPSNSU';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAICND';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROCRM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORRET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRMFRE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRMPOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRMCAT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRMFAI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRMFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGGOR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGDOR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEPREV';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONOPE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRODES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONNPS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RESNPS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENVNPS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DOMACU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VENCLI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_158_ENTRADA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_158_SAIDAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADTSN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TSNFXA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIEMB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUEMA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 03;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMASAI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MODEMA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGEMA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IMGMOD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PREMED';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BOSCH_CADCND';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONREM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORCFG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORSER';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COROBJ';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORPLP';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLPDOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPOS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADVFP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SATCAN';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADADQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCCA';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'POSAUT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'POSDOC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EXTBAN';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BANEXR';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGCBA';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGMCA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STW_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STW_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STW_CADSTW';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'STW_CADLIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJUSTE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJUICM';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REMGER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REMDET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RETGER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RETDET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFSEG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFAVE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFINC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFPRO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFPPR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFEVE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFPAG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFCOM';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MDFPRA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ARQUIV';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CATARQ';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NATCFO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TEPPRO';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGPAT';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEFAI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORIPRO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COLEXP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUGEXP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDEXP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COLROM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDROM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMLQ';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEQL';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQLDET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EQLFAT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IMPTES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETTES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEREC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEDOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEITE';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADOCA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLASSE';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLALOC';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLAITE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AGEILO';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIGVAL';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EXTGOR';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDSER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATGOS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBOX';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 4;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROTREG';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROTREC';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ENTREG';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROTREV';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRURIS';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRROPE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRRGRU';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CNFOCO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGOCO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDMAT';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDCOM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDBAI';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEDANA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEPI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEIEPI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMLGE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMLDE';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMLIT';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRDAMO';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GEIANA';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUSMS';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 03;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SMSSAI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MODSMS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SMSENV';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITEIMG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLIIMG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTRPRD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));
  arrProCod[intPosMat].strNomArq := 'PREPRQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GRUIMG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BCOFOR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRZMED';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OCOFID';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GPAFID';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PESCTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ACACRM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMAPCM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 06;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLISCO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFRG';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 05;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFRD';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLANCO';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISPAD';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LANCON';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PCMPRO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FORTIG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OREXIT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OREXCA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COLITE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COLCXA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGABF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FATRTM';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ESPGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ESPDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVLOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRECRI';
  arrProCod[intPosMat].strCodSeq := '000000000000001';
  arrProCod[intPosMat].intTamCod := 14;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIBEXT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOCITE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VENTEF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGEND';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CORTRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLAINI';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETSEP';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGLOT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROSER';
  arrProCod[intPosMat].strCodSeq := '00000000000001';
  arrProCod[intPosMat].intTamCod := 14;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETSER';
  arrProCod[intPosMat].strCodSeq := '00000000000001';
  arrProCod[intPosMat].intTamCod := 14;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGACE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADTSRE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADBEF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QTDNEG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALTSTA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TPLACO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RETMOT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADTSEF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MSGCFO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADRBC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFGGRD';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LROOBS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGEXC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'QUESTF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RELINS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAYPED';
  arrProCod[intPosMat].strCodSeq := '000004';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LAYPDC';
  arrProCod[intPosMat].strCodSeq := '000000000073';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ITECLI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVGAE';
  arrProCod[intPosMat].strCodSeq := '';
  arrProCod[intPosMat].intTamCod := 0;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FECFIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGFIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DETMOD';
  arrProCod[intPosMat].strCodSeq := '';
  arrProCod[intPosMat].intTamCod := 0;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTIMP';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'VEIPRO';
  arrProCod[intPosMat].strCodSeq := '';
  arrProCod[intPosMat].intTamCod := 0;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROESP';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCDS';
  arrProCod[intPosMat].strCodSeq := '';
  arrProCod[intPosMat].intTamCod := 0;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LADGER';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LADDET';
  arrProCod[intPosMat].strCodSeq := '';
  arrProCod[intPosMat].intTamCod := 0;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTRAS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVRAS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDRAS';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUTFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'GPREOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LIMFOR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDRE';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PARCON';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PAGROM';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCSE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FILNFC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BAIREQ';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFEC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DELFEC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FECFIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DELFIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TRAREG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTCON';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOTLAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OCOPAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ABFCOG';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REGDEP';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CATEGO';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ODMFDO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLINEN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADCNA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'YAPCOB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'YAPTRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PROPCO';
  arrProCod[intPosMat].strCodSeq := '000000000000001';
  arrProCod[intPosMat].intTamCod := 14;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));
  arrProCod[intPosMat].strNomArq := 'COMMEC';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMMED';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADMSF';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 1;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMFLG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COMLGD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'OCOPES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DEL_OCOPES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFNC';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EVEGER';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EVEDET';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADEEE';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ESTEXT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MANDOC';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIGIMP';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));
  arrProCod[intPosMat].strNomArq := 'TIPIMO';
  arrProCod[intPosMat].strCodSeq := '006';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'IMOAMO';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMGER_RES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMFIL_RES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMDET_RES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ROMPAR_RES';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NOTEXP';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONPOR';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADKIT';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KITDET';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KITBRI';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

arrProCod[intPosMat].strNomArq := 'NATAJU';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TABECF';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISLAN';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFLALU';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FISMOT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LYCONT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTACON';
  arrProCod[intPosMat].strCodSeq := '00001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGGNR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ARMFAT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIVIMG';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TSPCOA';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONRET';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGMCO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONRED';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'TIPPRJ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AUXREC';
  arrProCod[intPosMat].strCodSeq := '00000000001';
  arrProCod[intPosMat].intTamCod := 11;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CTRPRO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHQPRO';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLPB2W';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAIMAR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAIVEN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FAIPER';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MATDIF';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DIFBAS';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMACTR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FREFAI';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFLAN';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFMES';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFCTA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'BOLCTR';
  arrProCod[intPosMat].strCodSeq := '0001';
  arrProCod[intPosMat].intTamCod := 5;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ECFCNF';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RETELE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONDEV';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'NSEDOR';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'COLCNF';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'SUGFRM';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ORDCOL';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DUPEMA';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOG_RETVIEW';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'WPPENV';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGAPI';
  arrProCod[intPosMat].strCodSeq := '000000000001';
  arrProCod[intPosMat].intTamCod := 12;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'EMABLK';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

// ##PROCOD## // COLOCADO PARA PESQUISAR O FIM DO PROCOD MAIS R¡PIDO.
End;


function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;
Var
  qrySQL: TUniQuery;
  strTipoCmp: String;
begin
  qrySQL := fCriaQuery;
  Result := 0;
  Try
    qrySQL.SQL.Add('DESC ' + strTabela);
    qrySQL.Open;
    While Not qrySql.Eof Do
    Begin
      If qrySQL.FieldByName('Field').AsString = strCampo Then
      Begin
        strTipoCmp := qrySQL.FieldByName('Type').AsString;
        If UpperCase(LeftStr(strTipoCmp, 8)) = 'DECIMAL(' Then
        Begin
          Result := StrToIntDef(strTipoCmp[Pos(',', strTipoCmp)+1], 0);
        End;
      End;
      qrySQL.Next;
    End;
  Finally
    FreeAndNil(qrySQL);
  End;
End;

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result, True, IIF(fCfgSis('FEMUCP', varBoolean), strCodCid, ''))) Do
  Begin
    Result := Result + 1;
  End;
end;

function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                     strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                     blnConsideraDomingo: Boolean = False): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  If blnConsideraSabadoAndDomingoComoDiaUtil Then
    Result := fEhFeriado(dtaDta, strCodCid)
  Else
  Begin
    If blnConsideraSabado Then
      Result := (DayOfWeek(dtaDta) In [DOMINGO, SABADO]) Or (fEhFeriado(dtaDta, strCodCid))
    Else If (blnConsideraDomingo) And (DayOfWeek(dtaDta) = DOMINGO) then
      Result := fEhFeriado(dtaDta, strCodCid)
    Else
      Result := (DayOfWeek(dtaDta) = DOMINGO) Or (fEhFeriado(dtaDta, strCodCid));
  End;
end;

function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;
  Var
    intCont: Integer;
    strDTa: String;
begin
  intCont := 0;
  strDta := FormatDateTime('yyyy-mm-dd', dtaDta);

  intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'CADFER', ['FER_DTAFER'], [strDta], False);

  If Not fEmptyStr(strCodCid) Then
  Begin
    intCont := intCont + fCampoTabela('COUNT(*) AS QTD', 'FERCID', ['FCI_DTAFER', 'FCI_CODCID'], [strDta, strCodCid], False);
  End;

  Result := intCont > 0;
end;

function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
const
{$IFDEF LINUX}
  PATH_SEPARATOR = '/';
{$ELSE}
  PATH_SEPARATOR = '\';
{$ENDIF}
	Var
    strPathOpcoes: String ;
		iniArqIni : TIniFile;
begin
  strPathOpcoes := ExtractFilePath(Application.ExeName);

  If (Not AnsiEndsText('auttin', strPathOpcoes)) And (Not AnsiEndsText('auttin'+ PATH_SEPARATOR, strPathOpcoes)) Then
    strPathOpcoes := strPathOpcoes + PATH_SEPARATOR + 'auttin' + PATH_SEPARATOR;

  iniArqIni := TIniFile.Create(strPathOpcoes + 'opcoestinta.ini' {$IFDEF LINUX}, TEncoding.ANSI{$ENDIF});
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fPermiteMudancaModeloVendaForaEstabelecimento: Boolean;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Clear;
    qryDados.SQL.Text := 'SELECT COUNT(0) AS QTDE FROM AUXMOV WHERE AUX_OPCDOC = "ER"';
    qryDados.Open;

    Result := qryDados.FieldByName('QTDE').AsInteger = 0;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');
begin

end;

function fTemTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): Boolean;
  Var
    strTagIni,
    strTagFin: String;
Begin
  If opcOculta = omlMsgParaQuemEnvia Then
  Begin
    strTagIni := STRING_MENSAGEM_OCULTA_INI_ENV;
    strTagFin := STRING_MENSAGEM_OCULTA_FIM_ENV;
  End
  Else
  Begin
    strTagIni := STRING_MENSAGEM_OCULTA_INI_REC;
    strTagFin := STRING_MENSAGEM_OCULTA_FIM_REC;
  End;

  Result := (Pos(strTagIni, strTexto) > 0) And
            (Pos(strTagFin, strTexto) > 0);
end;

function fLimpaTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): String;
  Var
    strTagIni,
    strTagFin: String;
Begin
  Result := strTexto;

  If opcOculta = omlMsgParaQuemEnvia Then
  Begin
    strTagIni := STRING_MENSAGEM_OCULTA_INI_ENV;
    strTagFin := STRING_MENSAGEM_OCULTA_FIM_ENV;
  End
  Else
  Begin
    strTagIni := STRING_MENSAGEM_OCULTA_INI_REC;
    strTagFin := STRING_MENSAGEM_OCULTA_FIM_REC;
  End;

  If fTemTagMsgOculta(strTexto, opcOculta) Then
  Begin
    Result := AnsiReplaceStr(Result, strTagIni, '');
    Result := AnsiReplaceStr(Result, strTagFin, '');
  End;
end;

function fTime(const AForceTime: Boolean = False) : TDateTime;
{$IFDEF LINUX}
begin
  Result := Services.Core.Utils.fTime(AForceTime);
end;
{$ELSE}
begin
  If (AForceTime) Or (Not Assigned(frmModulo)) Then
    Result := untHorarioSistema.GetTime()
  Else
    Result := untHorarioSistema.GetTime(VS_strCodEmp, frmModulo.GetCurrentConnection);
end;
{$ENDIF}

function PegaTimeZoneServidor: Integer;
  Var
  {$IFNDEF LINUX}
    TimeZone: TTimeZoneInformation;
    LValorMaquinaLocal: Integer;
  {$ENDIF}

    LTimeZoneServer: TUniQuery;

    LPossuiTimeZoneAlterado: Boolean;
begin
  If VS_TimeZone <> 0 Then
    Exit(VS_TimeZone);

  LTimeZoneServer := fCriaQuery;

  Result := 3;
  Try
   {$IFNDEF LINUX}
    Try
      GetTimeZoneInformation(TimeZone);

      LValorMaquinaLocal := TimeZone.Bias div 60;
    Except
      LValorMaquinaLocal := 3;
    End;
   {$ENDIF}

    Try
      LTimeZoneServer.SQL.Text := 'SHOW VARIABLES LIKE "%time_zone%"';
      LTimeZoneServer.Open;

      If Not LTimeZoneServer.IsEmpty Then
      Begin
        LPossuiTimeZoneAlterado := LTimeZoneServer.Locate('Variable_name', 'time_zone', []);
        If LPossuiTimeZoneAlterado Then
        Begin
          LPossuiTimeZoneAlterado := Not LTimeZoneServer.FieldByName('Value').AsString.ToUpperInvariant.Equals('SYSTEM');

          If LPossuiTimeZoneAlterado Then
          Begin
            If TryStrToInt(LeftStr(LTimeZoneServer.FieldByName('Value').AsString, 3).Replace(':', EmptyStr), Result) Then
            Begin
              Result := Result * -1;
              Exit;
            End;
          End;
        End;

        If LTimeZoneServer.Locate('Variable_name', 'system_time_zone', []) Then
        Begin
          Result := LTimeZoneServer.FieldByName('value').AsInteger * -1;
          Exit;
        End;
      End;

     {$IFDEF LINUX}
      raise Exception.Create('PegaTimeZoneServidor FAILED');
     {$ELSE}
      Result := LValorMaquinaLocal;
     {$ENDIF}
    Except
     {$IFDEF LINUX}
      raise;
     {$ELSE}
      Result := LValorMaquinaLocal;
     {$ENDIF}
    End;
  Finally
    VS_TimeZone := Result;

    LTimeZoneServer.Close;
    FreeAndNil(LTimeZoneServer);
  End;
end;

function fStartTransacationAutoincrem(conexao: TUniConnection = nil): Boolean;
begin
  If Assigned(conexao) Then
  Begin
    If Not conexao.Connected Then
      conexao.Connect;

    If Not fInTransaction(conexao) Then
      conexao.StartTransaction;
  End
  Else
  If Assigned(__VS_CONEXAO_AUTOINCREM) Then
  Begin
    Try
      If Not __VS_CONEXAO_AUTOINCREM.Connected Then
        pConectaAutoincrem;
    Except
      pConectaAutoincrem;
    End;
    If Not fInTransaction(__VS_CONEXAO_AUTOINCREM) Then
      __VS_CONEXAO_AUTOINCREM.StartTransaction;
  End;
  Result := True;
end;

function fCommitAutoincrem(conexao: TUniConnection = nil): Boolean;
begin
  If Assigned(conexao) Then
  Begin
    If fInTransaction(conexao) Then
      conexao.Commit;
  End
  Else
  If Assigned(__VS_CONEXAO_AUTOINCREM) Then
  Begin
    If fInTransaction(__VS_CONEXAO_AUTOINCREM) Then
      __VS_CONEXAO_AUTOINCREM.Commit;
  End;
  Result := True;
end;

function fRollbackAutoincrem(conexao: TUniConnection = nil): Boolean;
begin
  Try
    If Assigned(conexao) Then
    Begin
      conexao.Rollback;
    End
    Else
    If Assigned(__VS_CONEXAO_AUTOINCREM) Then
    Begin
      __VS_CONEXAO_AUTOINCREM.Rollback;
    End;
    Result := True;
  Except
    Result := False;
  End;
end;

function fInTransactionAutoincrem(conexao: TUniConnection = nil): Boolean;
begin
  Result := False;
  If Assigned(conexao) Then
  Begin
    Result := conexao.InTransaction;
  End
  Else
  If Assigned(__VS_CONEXAO_AUTOINCREM) Then
  Begin
    Result := __VS_CONEXAO_AUTOINCREM.InTransaction;
  End;
end;

function fRetConexaoAutoincrem: TUniConnection;
begin
  If Not Assigned(__VS_CONEXAO_AUTOINCREM) Then
    pConectaAutoincrem;
  Result := __VS_CONEXAO_AUTOINCREM;
end;

procedure pConectaAutoincrem;
begin
  pDesconectaAutoincrem;
  If VS_StrCodEmp <> '' Then
    If Not fCfgSis('CNXAUT', varBoolean) Then
      Exit;

{$IFNDEF LINUX}
  __VS_CONEXAO_AUTOINCREM := fCriarConexao;
{$ELSE}
  __VS_ICONEXAO_AUTOINCREM := fCriarConexaoAvulsa(__VS_TAG_AUTOINCREM);
  __VS_CONEXAO_AUTOINCREM := __VS_ICONEXAO_AUTOINCREM.GetObject as TUniConnection;
{$ENDIF}

  Try
    __VS_CONEXAO_AUTOINCREM.Connect;
  Except
    On E: Exception Do
    Begin
      Sleep(1000);
      __VS_CONEXAO_AUTOINCREM.Connect;
    End;
  End;
end;

procedure pDesconectaAutoincrem;
begin
  If Assigned(__VS_CONEXAO_AUTOINCREM) Then
  Begin
    Try
      Try
        __VS_CONEXAO_AUTOINCREM.Disconnect;
      Finally
        {$IFDEF LINUX}
        __VS_CONEXAO_AUTOINCREM := nil;
        pLiberarConexaoAvulsa(__VS_ICONEXAO_AUTOINCREM, __VS_TAG_AUTOINCREM);
        __VS_TAG_AUTOINCREM := 0;
        {$ELSE}
        FreeAndNil(__VS_CONEXAO_AUTOINCREM);
        {$ENDIF}
      End;
    Except
      __VS_CONEXAO_AUTOINCREM := nil;
      {$IFDEF LINUX}
      __VS_ICONEXAO_AUTOINCREM := nil;
      __VS_TAG_AUTOINCREM := 0;
      {$ENDIF}
    End;
  End;
end;

function fNomeArquivoValido(const ATexto: string): string;
const
  cnsNomesReser: array[0..21] of string = (
    'CON','PRN','AUX','NUL',
    'COM1','COM2','COM3','COM4','COM5','COM6','COM7','COM8','COM9',
    'LPT1','LPT2','LPT3','LPT4','LPT5','LPT6','LPT7','LPT8','LPT9'
  );
var
  intIdx: Integer;
begin
  Result := Trim(ATexto);

  for intIdx := Length(Result) downto 1 do
  begin
    if (Ord(Result[intIdx]) < 32) or
       CharInSet(Result[intIdx], ['\', '/', ':', '*', '?', '"', '<', '>', '|']) then
      Delete(Result, intIdx, 1);
  end;

  while (Result <> '') and CharInSet(Result[Length(Result)], [' ', '.']) do
    Delete(Result, Length(Result), 1);

  for intIdx := Low(cnsNomesReser) to High(cnsNomesReser) do
  begin
    if SameText(Result, cnsNomesReser[intIdx]) then
    begin
      Result := Result + '_';
      Break;
    end;
  end;

  if Result = '' then
    Result := 'ARQ';
end;

procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  Var
    LstrPatArq,
    LstrCodOpe,
    LstrCodEmp,
    LstrConId_,
    LstrNomDir,
    LstrNomArq: String;
    LdtaTimLog: TDateTime;
    LstlLog: TStringList;
begin
  Try
    LstrNomDir := ExtractFilePath(Application.ExeName) + 'temp\log\';

    If (Not DirectoryExists(LstrNomDir)) Then
      ForceDirectories(LstrNomDir);

    If (Not DirectoryExists(LstrNomDir)) Then
      Exit;

    LdtaTimLog := Date+Time; //USO DE Date+Time EM DETRIMENTO DE fNow() PARA EVITAR ACESSO AO BANCO
    LstrNomArq := fNomeArquivoValido(strLocal);

    LstrConId_ := IfThen(VS_LastConnID.IsEmpty, VS_ConnectionID, VS_LastConnID);
    LstrCodEmp := VS_strCodEmp;
    LstrCodOpe := strLoginUsuarioLogado;

    LstrPatArq := LstrNomDir + FormatDateTime('yyyymmddhhnnsszzz', LdtaTimLog) + '_' + LstrCodEmp + '_' + LstrCodOpe + '_' + LstrNomArq + '.txt';

    LstlLog := TStringList.Create;
    Try
      LstlLog.Add(strErro);
      LstlLog.Add('');
      LstlLog.Add('Data/Hora....: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', LdtaTimLog));
      LstlLog.Add('Empresa......: ' + LstrCodEmp);
      LstlLog.Add('Operador.....: ' + LstrCodOpe);
      LstlLog.Add('Connection ID: ' + LstrConId_);
      LstlLog.Add('');
      LstlLog.Add(strStack);
      LstlLog.SaveToFile(LstrPatArq);
    Finally
      FreeAndNil(LstlLog);
    End;
  Except
    //
  End;
end;

function fRetSeqContaBanco(intQtdCod: Integer = 1): String;
  Var
    strSequen: String;
   {$IFDEF LINUX}
    LICon: IConnection;
    LTag: NativeUInt;
   {$ENDIF}
    LConn: TUniConnection;

    function fSequenCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;
    begin
      qryGenTmp := nil;
      Try
        qryGenTmp := fCriaQuery(nil, LConn);
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE CTB_SEQLAN FROM MOVBAN WHERE CTB_SEQLAN = :SEQLAN LIMIT 1');
          ParamByName('SEQLAN').AsString := strSequen;
          Open;
          Result := (Not IsEmpty);
          Close;
        End;
      Finally
        FreeAndNil(qryGenTmp);
      End;
    end;

begin
 {$IFDEF LINUX}
  LICon := fCriarConexaoAvulsa(LTag);
  LConn := LICon.GetObject as TUniConnection;
 {$ELSE}
  LConn := fCriarConexao;
 {$ENDIF}
  Try
    Repeat
      LConn.Connect;
      LConn.StartTransaction;
      strSequen := VS_strCodEmp + fAtualizaProCod('MOVBAN', intQtdCod, LConn);
      LConn.Commit;
    Until (Not fSequenCadastrado);
    Result := strSequen;
  Finally
   {$IFDEF LINUX}
    LConn := nil;
    pLiberarConexaoAvulsa(LICon, LTag);
   {$ELSE}
    FreeAndNil(LConn);
   {$ENDIF}
  End;
end;

function fVerificaseEhPedido(strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;

  function fGetSQL(): String;
  begin
    Result := '';
    Result := Result + 'SELECT FGO_NUMDOC ';
    Result := Result + 'FROM FATGOR ';
    Result := Result + 'WHERE FGO_NUMDOC = "' + strNumDoc + '" AND ';
    Result := Result +      ' FGO_ESPDOC = "' + strEspDoc + '" AND ';
    Result := Result +      ' FGO_CODEMP = "' + strCodEmp + '" AND ';
    Result := Result +      ' FGO_CODCLI = "' + strCodCli + '"     ';
  end;

begin
  Result := false;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;
    Add(fGetSQL());
    Open;

    If Not IsEmpty Then
       Result := True
  End;

  FreeAndNil(qryGen);
end;

function fVerificaRegraCCOrigem(strNumDoc, strParcel, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryGen: TUniQuery;

  function fGetSQL(): String;
  begin
    Result := '';
    Result := Result + 'SELECT CTR_NUMDUP ';
    Result := Result + 'FROM CADREC ';
    Result := Result + 'WHERE CTR_NUMDUP = "' + strNumDoc + '" AND ';
    Result := Result +      ' CTR_PARCEL = "' + strParcel + '" AND ';
    Result := Result +      ' CTR_ESPDOC = "' + strEspDoc + '" AND ';
    Result := Result +      ' CTR_CODEMP = "' + strCodEmp + '" AND ';
    Result := Result +      ' CTR_CODCLI = "' + strCodCli + '" AND ';
    Result := Result +      ' CTR_VALORI < 0 ';
  end;

begin
  Result := false;

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;
    Add(fGetSQL());
    Open;

    If Not IsEmpty Then
       Result := True
  End;

  FreeAndNil(qryGen);
end;

function CarregaImagemBanco(ANomeComponente, ANomeForm: String): TBytesStream;
{$IFDEF LINUX}
begin
  Result := Nil;
end;
{$ELSE}
Var
  LImgBase64 : String;
  LImgStream : TBytesStream;
begin
  Result := Nil;

  If Not PermiteCarregarImagensDinamicamente Then
    Exit;

  LImgBase64 := fCampoTabela('IMG_IMAGEM', 'IMGRES', ['IMG_NOMFRM', 'IMG_NOMCOM'], [ANomeForm, ANomeComponente]);
  If LImgBase64.IsEmpty Then
    Exit;

  LImgStream := TBytesStream.Create;
  If fStreamFromBase64(LImgBase64, LImgStream) Then
    Result := LImgStream;
end;
{$ENDIF}


function PermiteCarregarImagensDinamicamente: Boolean;
Var
  LCountImg : Integer;
begin
  Result := False;

  If fTabelaExiste('IMGRES') Then
  Begin
    LCountImg := fCampoTabela('COUNT(*)', 'IMGRES', [], []);
    Result    := LCountImg > 0;
  End;
end;

function fExisteRegistroPREPTEDocumento(strDocAbs, strEspAbs, strEmpAbs: String; strCodIte: String = ''):Boolean;
var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery();

  Try
    qryAux.SQL.Add('  SELECT                      ');
    qryAux.SQL.Add('    AUTOINCREM                ');
    qryAux.SQL.Add('  FROM                        ');
    qryAux.SQL.Add('    PREPTE                    ');
    qryAux.SQL.Add('  WHERE                       ');
    qryAux.SQL.Add('        PRE_DOCABS = :DOCABS  ');
    qryAux.SQL.Add('    AND PRE_ESPABS = :ESPABS  ');
    qryAux.SQL.Add('    AND PRE_EMPABS = :EMPABS  ');

    If (Not fEmptyStr(strCodIte)) Then
      qryAux.SQL.Add('  AND PRE_CODITE = :CODITE  ');

    qryAux.SQL.Add('  LIMIT 1                     ');

    qryAux.ParamByName('DOCABS').AsString := strDocAbs;
    qryAux.ParamByName('ESPABS').AsString := strEspAbs;
    qryAux.ParamByName('EMPABS').AsString := strEmpAbs;

    If (Not fEmptyStr(strCodIte)) Then
      qryAux.ParamByName('CODITE').AsString := strCodIte;

    qryAux.Open;

    Result := (Not qryAux.IsEmpty);
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure FreeAndNilDatasets(var ADataset);
Begin
  If Not Assigned(TObject(ADataset)) Then
    Exit;

  If Not (TObject(ADataset) is TDataset) Then
    Raise EInvalidCast.Create('FreeAndNilDatasets: par‚metro n„o È TDataset');

  Try
    TDataset(ADataset).Close;
  Finally
    FreeAndNil(ADataset);
  End;
End;

initialization
  TDefaultPoolingOptions.MaxPoolSize := 30;
  TDefaultPoolingOptions.MinPoolSize := 0;
  TDefaultPoolingOptions.Validate := True;
  TDefaultPoolingOptions.ConnectionLifetime := 600000;
  TDefaultPoolingOptions.Pooling := True;

  VS_dicTabelaReplica := TDictionary<String, Boolean>.Create;
  VS_MREWSTabelaReplica := TMultiReadExclusiveWriteSynchronizer.Create;

  VS_intTamDocCadRec := 0;
  VS_Error_you_are_sending_too_many_mails_slow_down := False;

  EnableUniSQL := False;

  VS_cdsTabNRE := nil;

  VS_EXECUTAR_TESTE_LOG_REPLICACAO := False;

  VS_TRANSACAO_LIMITE_SEGUNDOS := 30;

  VS_dicConfiguracoes := TDictionary<string,string>.Create;
  VS_dtaIdentiTransacao := TStringList.Create;

  VS_MacAddress        := GetMacAddress;
  VS_IPAddressAsString := GetIPAddressAsString;
  VS_UserFromWindows   := GetUserFromWindows;
  VS_ComputerNetName   := GetComputerNetName;
  VS_ProcessID         := '';

  VS_WorkStationIP     := '';
  VS_WorkstationID     := '';

  VS_GravaUsuRep  := '';
  VS_LogRepConId  := '';
  VS_UsuRepConId  := '';
  VS_LogRepCodOp  := '';
  VS_LogRepIdTra  := '';
  VS_ConnectionID := '';

  VS_blnErroLogRep := False;
  VS_strErroLogRep := '';
  blnTransferindoCodigo := False;
  VS_LastConnID := '';
  VS_strReplicarLckAtc := '';

{$IFNDEF LINUX}
  VS_TimerTransacao := TTimerTransacao.Create(nil);
  VS_TimerTransacao.Enabled := False;
  VS_blnGravaLogTransacao := true;
  VS_blnExitMonitor := False;
  VS_AutoatendimentoPagueFacil := False;
  VS_strTxjCni := fArqIni(0, 'GERAL', 'TXJCNI', '');
  VS_objTraceViewer := nil;
  VS_intTamCadIte := 0;
  VS_intTamCadLse := 0;
{$ENDIF}

finalization
{$IFNDEF LINUX}
  If Assigned(VS_TimerTransacao) Then
    FreeAndNil(VS_TimerTransacao);

  If Assigned(VS_EmailTiposErro) Then
    FreeAndNil(VS_EmailTiposErro);

{$ENDIF}

  FreeAndNil(VS_dtaIdentiTransacao);
  FreeAndNil(VS_dicConfiguracoes);

  If Assigned(VS_dicTabelaReplica) Then
    FreeAndNil(VS_dicTabelaReplica);

  If Assigned(VS_MREWSTabelaReplica) Then
    FreeAndNil(VS_MREWSTabelaReplica);

  If Assigned(VS_cdsTabNRE) Then
    FreeAndNil(VS_cdsTabNRE);
end.

