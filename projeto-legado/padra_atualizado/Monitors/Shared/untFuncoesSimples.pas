unit untFuncoesSimples;

interface

Uses
  Classes, Uni, Controls, SysUtils, StrUtils, Forms, Windows, PSAPI,
  IniFiles, Graphics, Messages, Dialogs, Buttons, StdCtrls, DBCtrls,
  Mask, DB, Printers, Themes, Consts, DBClient, untConstantes, UITypes,
  untDBECgcCpf, untMskC_G_C_, untEditTipoCgcCpf, Aurelius.Types.Nullable,
  System.Json,

  Variants, ExtCtrls, ComCtrls, EditFocus, AnsiStrings, MMSystem,
  DBLookupComboBoxFocus, ComboBoxFocus, MemoFocus, DBComboBoxFocus,
  DBMemoFocus, MaskEditFocus, DBEditFocus, Grids, Menus, Math,
  RLPreviewForm, RLReport, RLTypes, DateUtils, MaskUtils, Contnrs, TypInfo,
  WinSock, untTypesSistema, System.NetEncoding,
  IdSMTP,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdSocks, IdMessage, ShellApi, WinSpool,

  RegularExpressions,

  UniClientDataSet, DBGridCitel, DBGrids, Registry, MadExcept,
  untFuncoesGenerica, madStackTrace, BitBtnLockedIncrem, CheckLst,
  cxProgressBar, IdHashMessageDigest, IdHash,
  CRAccess, frxClass, IdCoderMIME, EncdDecd,
  Types, UniDataSetProvider, System.Win.ComObj, Xml.XMLDoc, Xml.XMLIntf,

  UniSQLMonitor, DASQLMonitor, DBAccess, CLRClasses, CRParser,
  MyParserUni, MyClassesUni, ShlObj, DAScript, UniScript, Winapi.TlHelp32,
  untCfgRepositorio, System.Generics.Collections, untInterfacedObjectNoCount,
  untICamposUso, REST.Client, System.Zip, untModuloLegenda, untConnection;

Type
  TFcnFormataProCod = reference to function (const AValue: String) : String;

Type
  TTipoTamanhoArquivo = (ttByte, ttKByte, ttMByte, ttGByte, ttTByte);

type
  TAcaoTransacao = (opStart, opCommit, opRollback);

type
  TTimerTransacao = Class(TTimer)
    private
      procedure pOnTimerTransacao(Sender: TObject);
    public
      constructor Create(AOwner: TComponent); override;
  end;

type
  TFinalizarAutcomMonitor = class(TThread)
  private
    class var FInstance: TFinalizarAutcomMonitor;
  private
    const FTimeout = 60;
  private
    FBegin: TDateTime;
    FPID: Integer;
    FRunning: Boolean;
  protected
    procedure Execute; override;
  public
    constructor Create(APID: Integer);
    destructor Destroy; override;

    class procedure Monitorar;
    class procedure Parar;
  end;

Type
  TDadosEmpresa = Record
    strNome: string;
    strCpfCnpj: string;
    strEndereco: string;
    strNumero: string;
    strBairro: string;
    strCidade: string;
    strCep: string;
    strFone: string;
    strCelular: string;
    strEmail: string;
    strComplemento: string;
    strIe: string;
  End;

type
  {***********************************}
  {* SUPER CLASSE AUXILIAR PARA      *}
  {* LIBERAÇÃO DE MEMÓRIA AUTOMÁTICA *}
  {********************************AF*}
  TObjectVariant = Class(TObject)
      varValor: Variant;
    public
      Constructor Create(valor: Variant);
  end;

type
  TInfLckAtc = record
    strNum_IP,
    strCon_ID,
    strChaAce,
    strCodOpe: String;
    intTentat: Integer;
    dtaDtaLck,
    dtaHraLck,
    dtaDtaHraLck: TDateTime;
  end;

type
  TCriarConexao = class
    Private
      FConexao: TUniConnection;
    public
      Constructor Create(AInfo: string = '');
      Destructor Destroy; override;
      property objConexao: TUniConnection Read FConexao;
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

{***********************************************************************}
{* CLASSE QUE REPRESENTARÁ OS CAMPOS DAS TABELAS EM USO NAS IMPRESSÕES *}
{********************************************************************MV*}
type
  TCamposUso = class(TInterfacedObjectNoCount, ICamposUso)
    private
      FarrCampos : Array Of String;
      FarrValores: Array Of String;
    protected
      function GetCampo(Index: String): String;
    public
      Constructor Create;
      Destructor  Destroy; Override;
      procedure   AdicionaCampos(qryTabela: TDataSet; strNomeTabela: String);
      procedure   LimparCampos;

      property Campos[Index: String]: String read GetCampo; default;
  end;

  Type
    TEspeciesGerCC = Record
      StrEspecie : String;
      fltValor   : Double;
      fltPercPgto: Double;
      fltVlrCredito: Double;
      fltCreditoCalc : Double;
    End;

  var
    VS_strClaDev: String;

  function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;

  procedure pConectarModulos;
  procedure pFinalizarModulos;
  procedure pDefinirEmpresa;
  procedure pDefinirUsuario;
  procedure pIniciarVariaveis;

  function fValidarEmpresa: Boolean;

  function fExecutandoPeloPortal: Boolean;

  function fExecutaSQL(strSQL: String; blnRaise: Boolean = False): Boolean;

  function fEhAdministrador(strCodOpe: String): Boolean;

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
  function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;

  procedure pGravaLogTransacao(objConexao     : TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
  procedure pAtualizaLogTransacao(strStack    : String         = '';
                                  tmrCommit   : TDateTime      = 0;
                                  tmrRollback : TDateTime      = 0;
                                  objConexao  : TUniConnection = Nil);

  function fRetTamCampo(strNomeTabela: String): Integer;
  function fGetParametrosDaConexao : TDatabaseParameters;
  function fGetSelectProcodDoArquivoForUpdate : String;
  function fGetUpdateProcodDoArquivo : String;
  function fAtualizaProCod(const strNomeTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod : Integer = 1; objConnection : TUniConnection = Nil; const objFncFmt : TFcnFormataProCod = Nil): String; overload;//>Compatibilidade
  function fAtualizaProCod(strNomeTabela: String; intQtdCod: Integer = 1; conSegConexao: TUniConnection = Nil): String; overload;
  function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnForcaValidaExistencia: Boolean = False): String;
  function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6; blnApenasObterValorSequencial: Boolean = False): String;

  function fRetCidade(Const strCodigo: String): String;

  function fRetDadosEmpresa: TDadosEmpresa;

  function fRetNomVendRep(strCodVen: String): String; overload;
  function fRetNomVendRep(strCodVen, strCodEmp: String): String; Overload;
  function fRetNomVendRep(strCodVen, strCodEmp, strCodCli: string): String; overload;

  function fTabelaExiste(const strNomeTabela: String; const blnUsarCache : Boolean = False; Conexao: TUniConnection = Nil): Boolean;
  function fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
  function fTamanhoArquivo(strArquivo: String): Cardinal; overload;
  function fTamanhoArquivo(strArquivo: String;
    tipoTamanho: TTipoTamanhoArquivo): Cardinal; overload;

  function fRetornaCountDados(strTabela, strCampo, strCondicao: String): Integer;

  function fCampoTabelaFatgor(const ACampo, ANumDoc, AEspDoc, ACodEmp: String): String;

  function fCampoTabela(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;

  procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);
  procedure pDestroiModulo(var NomeForm);

  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  function RetornaTimeStampEmMilisegundos: Int64;
  function PegaTimeZone: Integer;
  procedure pFreeAndNil(var frmForm);
  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
  procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');

  procedure FreeAndNilDatasets(var ADataset);

  procedure pPlaySound(AFileName: String); overload;
  procedure pPlaySound(AStream: TMemoryStream); overload;

  procedure pMensagemSonora(strMensagem: String; blnMaximizar: Boolean = False; intFontSize: Integer = 0;
    intWidth: Integer = 0; cfgArqSom: String = '';  mmsArqSom: TMemoryStream=Nil; blnMsgOkPadraoSeCaminhoSomVazioOuVariavelSomNil: Boolean = False); Overload;
  procedure pMensagemSonora(strMensagem: String; cfgArqSom: String; blnMsgOkPadraoSeCaminhoArqSomVazio: Boolean = False); Overload;
  procedure pMensagemSonora(strMensagem: String; mmsArqSom: TMemoryStream; blnMsgOkPadraoSeVariavelSomNil: Boolean = False); Overload;

  procedure pImprimirArquivoZPL(strNomPro, strDesPro, strNomArq: String);
  procedure pImprimirEtiquetaZPL(strNomPro, strDesPro, strNomArq: String);

  function fUsaSat(strCodEmp : String = '') : Boolean;
  function fArredondaABNT_NBR5891_77(fltValor: Double;
    intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
  function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
  function fMskDigitos(intDigitos: Integer): String;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;

  function fValNumForm(fltValor: Double; intZeros: Integer; intQtdDec: Integer = 2): String; overload;
  function fValNumForm(strValor: String; intZeros: Integer; intQtdDec: Integer = 2): Double; overload;

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
  function fSomarNovosImpostosDaReformaAoValorContabil : Boolean;
  function fSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
  function fSqlValorReformaMovRef(const AAutoincrementoMovDet: String): String;
  procedure pEncerrarAplicacaoPorInconsitenciaCodEmp(strCamCfg: String; blnTerminar: Boolean);
  function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                    dicCfgSis: TDictionary<string,string> = Nil): Variant;

  function fCfgSisHubCitel(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''; strPrefixoTabela: String = ''; strHubMkp: String = ''): Variant;

  function fReservaSaldoPedidosBaixaEntregaFutura: Boolean;                  

  function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
  function fRetornaValCfgMarCam(strValCfgOri: String): String;
  function fExecutaValCfg(strSQL, strEmp: String): String;
  function fPermiteEmissaoEspecie(strEspecie: String): Boolean;
  function fRetDescOpcCliPro(Const opc : TOpcCliPro): String;
  function fRetDescricaoAjuIcm(Const strCodAjuIcm: String): String;
  function fRetDescricaoMatrizAliquotasIcms(strCodMat: String): String;

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
  function fRetUFEmpresa(strCodEmp: String = ''): String;
  function fValidaCndPag(strCndPag: String; blnPerRep: Boolean = False): Boolean;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True;
                               blnTiraAbreviacaoNumero: Boolean = False;
                               strCaracterePersonalizado: String = ''): String;

  procedure pAddDados(Var arrAdd : TArray<String>; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
  procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
  procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False); overload;

  function fRetornaWordWrap(strTexto: String; intColunas: Integer): TStringList;
  function fRetornaWordWrapText(strTexto: String; intColunas: Integer): String;

  function fTemTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): Boolean;
  function fLimpaTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): String;

  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  function fTiraEnter(strTexto: String): String;
  function fTiraEspacos(strTexto: String): String;
  function fTrimAll(strTexto: String): String;
  function fTiraCaracEspeciaisPonto(strTexto: String): String;
  function fTratarNomeDiretorio(strNomDir: String): String;
  function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
  function fClienteConsumidor(strNomCli: String; blnCliBal: Boolean = False; blnSeguradora: Boolean = False): Boolean;
  function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;
  function fStrZero(Zeros:string;Quant:integer):String; overload;
  function fStrZero(Zeros:Integer;Quant:integer):String; overload;
  function fStrZero(Zeros:Int64; Quant:integer): String; overload;
  function fStrZero(Zeros: Nullable<Integer>;Quant:integer):String; overload;
  function fStrZero(Zeros: Nullable<String>;Quant:integer):String; overload;

  function fBase64Decodifica(ATexto: String): String;

  function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;

  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  procedure pWaitWindow(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);

  function fGetIdConnectionLock(strNomeTabela: String): String;
  function fGetIPConnectionLock(strNomeTabela: String): String;
  function fRetUltimoLock(strNomeTabela: String): TInfLckAtc;
  function fRetOrigemLock(strNomeTabela: String): String;
  function fGetTempoDuracaoLock(strNomeTabela: String): Double;
  function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
  function fGetTentativasLock(strNomeTabela: String): Integer;
  procedure pZerarTentativasLock(strNomeTabela: String);
  procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer=10);
  function fLock_Unlock(strNomeTabela: String;
                        blnTrava: Boolean;
                        blnLoopTravamento: Boolean = True;
                        blnHourGlass: Boolean = FALSE;
                        strCon_Id: String = '';
                        blnMostraMsgTravamento: Boolean = True;
                        strOrigem: String = ''): Boolean;

  function HorarioExecutaRobo(AValor:String): Boolean;
  function GetMD5(const strTexto: string): string;

  function fGetEmpresaLogada(): string;
  function fGetUsuarioLogado(): string;

  procedure pTrimAppMemorySize;

  function fRetornaInformacaoUltimoErroForeignKey: String; overload;
  function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String; overload;
  function fRetornaInformacaoUltimoDeadlock: String;

  function fItemPigmento(strCodIte: String; Var strCodBas: String): Boolean;

  function fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>;
  function fGetEmpresasReprocessarItemPedido(ASeqFdo: String): TArray<String>; overload;
  function fGetEmpresasReprocessarItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>; overload;
  procedure ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True);

  function fTabelaVazia(strNomeTabela: string; blnSempreLerBanco: Boolean = True): Boolean;
  function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;

  function fRetClientesFilial: String;
  function fRetornaClienteFilial(strCodEmp: String; strTipo_FC : String = 'C'): String;
  function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
  function fRetNomeEmpresa: String; overload;
  function fRetNomeEmpresa(strCodEmp: String): String; overload;
  function CalcularFatorVencimento(ADataVencimento: TDateTime): String;
  function fRetEmpresaFisica(conexao: TUniConnection = nil): String;
  function fRetNomeProduto(strCodIte: String): String;
  function fRetNomeOperador(strCodOpe: String): String;
  function fRetNomTransportadora(strCodTra: String): String;

  function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
    blnGravar: Boolean = True; blnSoCriaTabela: Boolean = False;
    strMotDel: String = ''; strOpeDel: String = ''; blnTabAux: Boolean = False; strOpcDel: String=''): String;

  function GravaTabelaDelecao(AFormulario, ATabela: String; ARegistroDeletado: TDataSet): Boolean;

  procedure pDestravarTodosLocksConexaoAtual(blnTestarOrigem: Boolean = False; conexao: TUniConnection = nil);

  function fRetornaNomeTabela(strString: String): String;
  function fGravaLogBco(strComand: String): Boolean;
  function fExtractBetweenTags(const Value, TagI, TagF: String): String;
  function fTabelaReplica(strNomTabela: String): Boolean;
  function fExtrairCodigoConfiguracao(ASQL: String): String;
  function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
  function fPermiteReplicarCfgSis(ASQL: String): Boolean;
  procedure pCarregaVariaveisControleLogRep(connection: TUniConnection);
  function fGravaLogRep(strComand, strTabela, strCarreg: String; connection: TUniConnection): Boolean;
  function fGravaUsuRep(connection: TUniConnection): Boolean;
  function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64; connection: TUniConnection): Boolean;
  function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
  procedure pCarregaNre(ARefresh: Boolean = False);

  function fDecrypt(strSenha: String): String;

  function fAjustaDataSistema: Boolean;
  function fRetornaCon_Id_Trava(strNomeTabela: String): String;

  function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;

  function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean; overload;
  function KillProcess(AImage: String): Boolean; overload;

  function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean;
    TipoChamado: TTipoChamadaProcesso = tcpMaximizado): boolean; overload;

  procedure pLog(strValor: String);

  function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean;
    Var ProceInfo: TProcessInformation; blnInvisivel: Boolean = False): boolean; overload;

  function fCurrentTime: String;
  function fCurrentDate: String; Overload;
  function fCurrentDate(Const Value: TDateTime): String; Overload;
  function fCurrentDateTime: String; Overload;
  function fCurrentDateTime(Const Value: TDateTime): String; Overload;
  function fNow: TDateTime;
  function RemoveMilliseconds(ATime: TDateTime): TDateTime;
  function fRetHoraServidor(AConnection: TUniConnection = nil): TTime;
  function fRetDataServidor: TDate;
  function fRetDtaHraServidor : TDateTime;

  function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
  function fUsaRotinaExpedicaoConferenciaRetiraCaixa(): Boolean;

  function GetIPAddressAsString: String;

  function fConPagComEntrada(strConPag: String): Boolean;
  function fFormataCondPag(strCond: String): String;
  function fRetDescFpg(Const strCodFpg: String): String;
  function fEhTabelaDeContabilidade(strTabela: string): boolean;
  procedure pGravaLogContabil(strSQL, strTabela: string);
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  {*****************************************************
  * ALGUMAS CONFIGURAÇÕES REFERENTES AOS BANCOS EM API *
  * NÃO DEVEM SER ARMAZENADAS NO ARQUIVO CNFBCO.INI,   *
  * UTILIZAR A FUNÇÃO fGetCfgBancoAPI QUE PERSISTE OS  *
  * DADOS NA TABELA BCOAPI                             *
  ****************************************REQ: 192873*MT}
  function fGetCfgBancoAPI(AReadWrite: Integer; AChave, ACodCfg, AValor: String; AEmpresaCarteira: String = ''):String;
  procedure WriteCfgBancoAPI(AChave,ACodBco,ACodCfg, AValor: String);
  function fRemoveAcento(Str:String): String;

  function fGetBancoConfig(ReadWrite: Integer; Chave, CodCFG, Valor: String; strEmpresaCarteira: String = ''; ADuplicataBoleto: untTypesSistema.PTDuplicataCtr = Nil):String;
  procedure pVerificaImpCNFBCO(strCodBco: String);
  function fRetNomeBancoSelec(Const strCodBco: String): String;
  procedure pImportaCNFBCO(strCodBco, strCodEmp: String);
  function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
  function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;
  procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport); overload;
  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport); overload;
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport); overload;
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TRLReport; ASetup: TRLPreviewSetup); overload;
  function fRetNomeRede: String;
  function fTamDocCadRec: Integer;
  function fFormataCEP(strCEP: String): String;
  function fRetiraZerosEsquerda(strDado: String): String;
  function fRetSomenteNumeros(strTexto: String): String;
  function fEnderecoEmailValido(strEmail: String): Boolean;
  function IfEmptyStr(strValor, strDefault: String): String;
  function fEmailValido(strEmail: String; blnExibeAlerta: Boolean = True;
              strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
              blnEmailNfe: Boolean = True): Boolean;
  procedure pCriarArrayAnexosEDestinatarios(strArquivo, strEmailDestinatario: String;
    Var arrDestinatarios, arrArquivos: TStringArray);
  function fRetCGCEmpresa(strCodEmp: String): String;
  function fRetNomCidade(strCodigo: String; intOpcao: Integer = 0): String;
  function fRetNomCliente(Const strCodCli: String): String;
  function fGetFiltroClienteEmpresaIdentificadora(strCodOpe: String; blnComAnd: Boolean = True): String;
  function fRetEmpAcessoUsuario(strCodOpe: String): String;
  function fRetPrimeiraPalavra(strTexto: String): String;
  function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
  function IfNull(varValor, varDefault: Variant): Variant;
  function fRetEmpresaOperador(strCodOpe: String): String;
  procedure pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String);
  function fPodeLiberarDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel: String): Boolean;
  procedure pMarcaDoctoComoLiberadoParaExpedicao(strNumDup, strEspDoc, strCodEmp, strCodCli: String);
  procedure pGravaLogBan(strCodBco, strNomBco, strNumAtu, strNu7Atu: String; blnInclusao, blnExcluir, blnImpressao: Boolean; strNumImp: String);
  function fRetNomBanco(Const strCodBco: String): String;
  function fExt1(strS : string; strIdioma: String = 'P') : string;
  function fExt2(strS : string; strIdioma: String = 'P') : string;
  function fExt3(strS : string; strIdioma: String = 'P') : string;
  function fExtUnidade(strS : String; strIdioma: String = 'P') : String;
  function fExtDezena(strS : String; strIdioma: String = 'P') : String;
  function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
  function fRetCidEmpresa(strCodEmp: String): String;
  function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
  function fGetPath(strPath: String): String;
  function fTiraCaracNota(strTexto: String): String;
  procedure pRetNumeroPedidoVenda(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; Var strNumPed, strEmpPed: String);
  procedure pBackupCnfBco;
  procedure pDesmembraCarteira(const strCartei: String; var strCodBco, strTipLay,
                               strNumPos, strEspeci, strCodEmp: String; var intCartei: Integer);
  function fRetCnfBco:String;

  function fCriaClientDataset(ASQL: String; AOwner: TComponent = Nil): TUniClientDataSet;
  function fCriaClientDatset(qryOrigem: TDataset; blnVazio: Boolean = False;
     AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
  function fAbrirTabela(NomeTabela:TDataSet):Boolean;

  function fTamCodIte: Integer;
  function fTamCodLse: Integer;
  function fValidaEstado(strUf: String): Boolean;
  Procedure pSetaClient(cdsClient: TDataSet);
  function fTipoErroGravaEmailErrosLog(AMensagemErro: String): Boolean;
  procedure pGravarEmailErros(strTip_FC, strForCli, strAssunt, strDestin, strMsgErr: String);
  procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; Conexao: TUniConnection = Nil);
  function fStatusCndPag(strCndPag: String): Integer;
  function fUsaLinkPagamentoSitefCielo: Boolean;

  function fSQLTipoFrete(strCamFre: String): String;
  function fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_: String): String;
  function fCriaDataSource(DataSet: TDataSet): TDataSource;
  function fRetornaTelefonesCliente(Const strCodCli: String): String;
  function fRetornaEmailsCliente(Const strCodCli: String): String;
  function fRetornaEmailsCobrancaCliente(Const strCodCli: String): String;

  function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  function fRetornaDataHoraServidor : TDateTime;
  function fRetornaDataServidor : TDateTime;
  function fRetornaHoraServidor : TDateTime;
  function fRetEmpresa: String;
  procedure pVerificaProCod;
  procedure pValidaProCod(strNomeTabela: String);
  function fUsaDoisMonitores: Boolean;
  function fUsaLayoutNovo: Boolean;
  procedure pCentralizarForm(AForm: TForm);
  procedure pListFreeAndNil(var objList);
  function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;

  function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
  function fValN(Variable: Nullable<String>): String; overload;
  function fValN(Variable: Nullable<Integer>): Integer; overload;
  function fValN(Variable: Nullable<Double>): Double; overload;

  function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime; strCodCid: String = ''): TDateTime;

  function fDiaDeFolga(dtaDta: TDateTime; blnConsideraSabado : Boolean = True;
                       strCodCid: String = ''; blnConsideraSabadoAndDomingoComoDiaUtil: Boolean = False;
                       blnConsideraDomingo: Boolean = False): Boolean;

  function fEhFeriado(dtaDta: TDateTime; strCodCid: String = ''): Boolean;
  function RetornaArquivoBase64(const ACaminhoArquivo: String): String;
  function fSegToTimeStr(Segundos: Double): String;
  function fExisteFatGorPendente(strCodCli, strNumDoc: String; strEspDoc: String; strCodPro: String = ''): Boolean;
  function fExisteOrcamentoPendente(strCodCli, strNumOrc: String; strCodPro: String = ''): Boolean;
  function fExistePedidoPendente(strCodCli, strNumDoc: String; strCodPro: String = ''): Boolean;
  function fSQLBarDoc(strPrefix: String; strNumDoc : String = ''; strEspDoc : String = ''; strCodEmp : String = ''): String;
  function fGetSQLConsultaItensPrecoValidandoEstrutura(strAliasIteger: String = 'ITEGER'; strTabelaPreco: string = '1'): string;

  function fDocumentoOrigemFF_DV_TR(const strNumDoc, strEspDoc,
    strCodEmp: String): Boolean;

  function fRetFormsAtivos: String;

  function fArquivoExisteNoDiretorio(strArquivo: String; intMaxTentativas: Integer = 1; cdnSleep: Cardinal = 0): Boolean;
  function fSolicitaDigDuplicAdiantamentoPedido: Boolean;
  function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
  function fRetFilaEApiKeyPrincipalWhatsapp(var extIdFila: Extended; var strApiKey: String;
  conexao: TUniConnection = nil): Boolean;
  function fCfgExpedicaoParcialHabilitada: Boolean;
  function fPermiteMudancaModeloVendaForaEstabelecimento: Boolean;

  procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');

  function SalvaArquivo(ANumPok: string; AArquivo: TRESTResponse; AResultOk : String): string;
  function DescompactaArquivo(ACaminho, ADiretorio: string): Boolean;

  function fUsaOndaSeparacaoAgrupamento(): Boolean;

  function fLimiteCreditoCliente(strCodCli: String; blnRedLoj: Boolean = False; strRedLoj: String = ''): Double;
  function fRetornaReceberAberto(strCodCli: String): Double;
  function fRetChqAberto(strExp, strCodCli: String; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False): Double;
  function fRetChqDevolvidos(strExp, strCodCli: String; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False): Double;
  function fTotalEmprestimosEmAberto(const strCodCli: String; var intQtdEP: Integer): Double;
  function fRetSQLResFinanceiro(typTab: typTipTab; typCon: typTipCon; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False; blnClientePro: Boolean = False): String;
  function fGetSqlPedidosEmAberto(blnCodRed: Boolean = False; AExcetoFormasDePagamento: String = ''): String;
  function fTotalPedidosEmAberto(const strCodCli, strCodRed: String;
                                 var intQtdPed  : Integer;
                                 blnSubtraiAdts : Boolean = False;
                                 AExcetoFormasDePagamento: String = ''): Double;

  function fGeraCodBarraEAN13(strCodigo: String): String;
  procedure pCarregaDuplicatasCND(intTabela:Integer; strAutoincrem:String; var arrDuplicataCND: TarrDuplicata);
  function fRetMltVenItem(Const strCodIte: String): Double;
  function fRetMltComItem(Const strCodIte: String): Double;
  function fCalcVolumes(strCodIte: String; fltQtdIte, fltEmbala: Double): Double;
  function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;
  function fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;
  procedure pCriarModuloLegenda;
  function fGetLetraAlfa(intCol: Integer): String;
  function fFloatToInt(fltNumero: Double): Integer;
  Function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
  function fVerificaLCKATCNomeParcial(const AstrNomeTrava: String): Boolean;
  function fTime(const AForceTime: Boolean = False) : TDateTime;

  procedure pLogStartFireDac(const objConexao: IConnection) ;
  procedure pLogRollbackFireDac(const objConexao: IConnection) ;
  procedure pLogCommitFireDac(const objConexao: IConnection) ;

  function fRemoveCaracterNulo(AString: String): String;
  function fRemoveBarraInvertidaFinalDaLinha(strText: String): String;
  function fFloatToSQL(fltValor: Double): String;

  function fEnviaWhatsappParaCliente(strCodCli: String; blnExibeMsg: Boolean = False): Boolean;

  function RetornaValorJson(AObjeto: TJsonObject;ANomeCampo: String): String;
  function RetornaValorJsonValue(AObjeto: TJsonValue; ANomeCampo: String): String;
  function TryFileExists(AFile: string): Boolean;
  function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean; overload;
  function fExecutarModal(const funcExecucao: TReferenceFunctionProgresso; const strTexto, strChave: string): Boolean; overload;
  function fRetFantasiaEmpresa(strCodEmp: String = ''): String;
  function fGetVersaoAutcom: String;
  function fNomeArquivoValido(const ATexto: string): string;
  procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  function fClienteProfissional(strCodCli: String): Boolean;

  function GeraUUIDVersao4: String;
  function fUtilizarStatusDeSeparacaoEConferencia : Boolean;
  function fUtilizaRestApiBoletoDLL: Boolean;
  function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;

  function fValidarEnderecoEmail(strEmail: String): Boolean;
  function fValidarEmail(strEmail: String; blnExibeAlerta: Boolean = True;
    strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
    blnEmailNfe: Boolean = True): Boolean;
  function fFaturadorAutomaticoJaBaixouEtiquetaMarketplace(const ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strPathEtiqueta: string): Boolean;
  function fEhArquivoBase64(const AstrArquivo: String): Boolean;

  function fModoDeDesenvolvimento: Boolean;
  procedure pNotificaFormGravandoAtivo(const strMessage : String);

  function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;

const
  PREFIX_MERCADO_LIVRE = 'MLB_';
  PREFIX_MAGALU        = 'MGL_';
  PREFIX_SHOPEE        = 'SHP_';
  PREFIX_VIAVAREJO     = 'VRJ_';
  PREFIX_OLIST         = 'OLS_';
  PREFIX_AMAZON        = 'AMZ_';

Var
  VS_Date: TDateTime;
  VS_strCodEmp: String;
  strLoginUsuarioLogado: String;
	strDescriUsuarioLogado: String;
  strEmpEstUsuarioLogado: String;
  blnErroLogRep: Boolean;
  strErroLogRep: String;
  VS_strTabelaErro: String;
  VS_objTraceViewer: ITraceViewer;
  VS_strError: String;
  VS_strLocalErro: String;
  VS_strMensagemErro: String;
  VS_strUsaTmq: String;
  VS_HabLogArq: String;
  VS_TSPlus: Boolean;
  blnTransferindoCodigo: Boolean;
  VS_AutcomIniciadoModoRobo: Boolean;
  VS_blnGravaLogTransacao: Boolean;
  VS_blnExitMonitor : boolean;
  VS_dtaIdentiTransacao: TStringList;
  VS_TimerTransacao: TTimer;
  VS_TRANSACAO_LIMITE_SEGUNDOS: Integer;
  dicConfiguracoes: TDictionary<string,string>;
  VS_MacAddress        : String;
  VS_IPAddressAsString : String;
  VS_UserFromWindows   : string;
  VS_ComputerNetName   : string;
  VS_ProcessID         : string;
  VS_WorkStationIP     : string;
  VS_WorkstationID     : string;
  VS_objTemFecMes      : TfuncTemFecMes;

  VS_GravaUsuRep  : String;
  VS_LogRepConId  : String;
  VS_UsuRepConId  : String;
  VS_LogRepCodOp  : String;
  VS_LogRepIdTra  : String;
  VS_ConnectionID : String;

  VS_EXECUTAR_TESTE_LOG_REPLICACAO: Boolean;
  VS_RESULTADO_TESTE_LOG_REPLICACAO: Boolean;
  VS_strLockMonitorStatus: String;
  VS_strLockMonitorReservaItem: String;
  VS_strLockMonitorAudit: String;
  VS_strLockMonitorEntregaFutura: String;
  VS_strLockMonitorContabil: String;
  VS_strLockMonitorEnviaRegFusion: String;
  VS_strLockMonitorRomaneioIntegFusion: String;
  VS_strHabilitarCRM: Boolean;
  VS_strCliFil: String;
  VS_strTipExp: String;
  VS_strTxjCni: String;
  VS_EmailTiposErro: TStringList;
  VS_AutoatendimentoPagueFacil: Boolean;

  VS_Error_you_are_sending_too_many_mails_slow_down: Boolean;

  VS_blnDlgPri: Boolean;
  arrFilas    : TarrFilas; //Array Of TFilasImp;
  VS_intTamDocCadRec: Integer; // Variável Global para armazernar tamanho do Documento da Tabela CADREC
  VS_ModeSSL: String;
  VS_VersaoTLSSSL: String;
  VS_strUrlSms: String;
  VS_strUsrSms: String;
  VS_TimeZone: Integer;
  VS_strSenSms: String;
  VS_strRemSms: String;
  VS_PastaEmailsEnviados: String;
  VS_PathAutCom: String;
  VS_strRazSoc: String; //Razao social da empresa
  VS_SQL_TRACE_PRODUTO: string;
  VS_SQL_TRACE_DOC_NUMERO: string;
  VS_SQL_TRACE_DOC_ESPECIE: string;
  VS_SQL_TRACE_DOC_EMPRESA: string;
  VS_blnGravaHistCob : Boolean;
  arrProCod : TarrProCod;
  {*******************************************}
  {* VARIAVEIS ESPECIFICAS PARA ESSE CLIENTE *}
  {****************************************LU*}
  UnidadePor  : Array[0..9] Of String[7] = ('','UM ','DOIS ','TRES ','QUATRO ','CINCO ','SEIS ','SETE ','OITO ','NOVE ');
  DezenaPor   : Array[0..9] Of String[10]= ('','DEZ ','VINTE ','TRINTA ','QUARENTA ','CINQUENTA ','SESSENTA ','SETENTA ','OITENTA ','NOVENTA ');
  CentenaPor  : Array[0..9] Of String[13] = ('','CEM ','DUZENTOS ','TREZENTOS ','QUATROCENTOS ','QUINHENTOS ','SEISCENTOS ','SETECENTOS ','OITOCENTOS ','NOVECENTOS ');

  UnidadeEsp  : Array[0..9] Of String[7] = ('','UN ','DOS ','TRES ','CUATRO ','CINCO ','SEIS ','SIETE ','OCHO ','NUEVE ');
  DezenaEsp   : Array[0..9] Of String[10]= ('','DIEZ ','VEINTE ','TRIENTA ','CUARENTA ','CINCUENTA ','SESSENTA ','SETENTA ','OCHENTA ','NOVENTA ');
  CentenaEsp  : Array[0..9] Of String[13] = ('','CIEN ','DOCIENTOS ','TRESCIENTOS ','CUATROCIENTOS','QUINIENTOS ','SEISCIENTOS ','SETECIENTOS ','OCHOCIENTOS ','NOVECIENTOS ');

  UnidadeIng  : Array[0..9] Of String[7] = ('','ONE ','TWO ','THREE ','FOUR ','FIVE ','SIX ','SEVEN ','EIGHT ','NINE ');
  DezenaIng   : Array[0..9] Of String[10]= ('','TEN ','TWENTY ','THIRTY ','FORTY ','FIFTY ','SIXTY ','SEVENTY ','EIGHTY ','NINETY ');
  CentenaIng  : Array[0..9] Of String[13] = ('','ONE HUNDRED ','TWO HUNDRED ','THREE HUNDRED','FOUR HUNDRED ','FIVE HUNDRED ','SIX HUNDRED ','SEVEN HUNDRED','EIGHT HUNDRED','NINE HUNDRED ');

  VS_intTamCadIte: Integer;
  VS_intTamCadLse: Integer;
  VS_LastConnID : String;
  VS_strTabPrc: String;

  strEmpAcessoUsuarioLogado: String;

  VS_ModeloEmailNaoAutenticado: String;

  VS_ModelosAvisosEmailAtivado: TStringList;
  VS_ModelosAvisosSMSAtivado: TStringList;
  VS_ModelosAvisosWPPAtivado: TStringList;

  VS_PermitidoEnviarEmail: Boolean;

  frmModuloLegenda: TfrmModuloLegenda;
  listValidaProcod : TList<String>;

implementation

uses
  untMensagem, untModulo, untGravaINNODBStatus, untWaitWindow,
  untModuloReplicacao, untTestabilidade, untCFGBAN_Class, untCFGBAN_Dao,
  untMensagemSonora, untSubjectClass, untSubjectIntf, untGravandoObs,
  untHorarioSistema, untGravando;

var
  cdsTabNRE: TUniClientDataSet;
  FDicTabelaReplica: TDictionary<String, Boolean>;
  FMREWSTabelaReplica: TMultiReadExclusiveWriteSynchronizer;

{ TObjectVariant }

constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;

{ TFinalizarAutcomMonitor }

constructor TFinalizarAutcomMonitor.Create(APID: Integer);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FBegin := Date + fTime(True);
  FPID := APID;
end;

destructor TFinalizarAutcomMonitor.Destroy;
begin
  Self.FInstance := nil;
  inherited;
end;

procedure TFinalizarAutcomMonitor.Execute;
begin
  inherited;
  pLog('TFinalizarAutcomMonitor.Execute');
  FRunning := True;
  While Not Terminated Do
  Begin
    If SecondsBetween(Date + fTime(True), FBegin) > FTimeout Then
    Begin
      KillProcess(FPID);
      Break;
    End;
  End;
  FRunning := False;
end;

class procedure TFinalizarAutcomMonitor.Monitorar;
begin
  If Not Assigned(Self.FInstance) Then
    Self.FInstance := TFinalizarAutcomMonitor.Create(GetCurrentProcessId);

  If Not Self.FInstance.FRunning Then
    Self.FInstance.Start;
end;

class procedure TFinalizarAutcomMonitor.Parar;
begin
  If Assigned(Self.FInstance) Then
    Self.FInstance.Terminate;
end;

{ TTimerTransacao }
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

{ TCriarConexao }

constructor TCriarConexao.Create(AInfo: string);
begin
  FConexao := TUniConnection.Create(frmModulo);
  FConexao.ProviderName := frmModulo.GetCurrentConnection.ProviderName;
  FConexao.Username := frmModulo.GetCurrentConnection.Username;
  FConexao.Password := frmModulo.GetCurrentConnection.Password;
  FConexao.Server := frmModulo.GetCurrentConnection.Server;
  FConexao.Database := frmModulo.GetCurrentConnection.Database;
  FConexao.Port := frmModulo.GetCurrentConnection.Port;
  FConexao.DefaultTransaction.IsolationLevel := DEFAULT_ISOLATION_LEVEL_UNIDAC;
  FConexao.PoolingOptions.MaxPoolSize := TDefaultPoolingOptions.MaxPoolSize;
  FConexao.PoolingOptions.MinPoolSize := TDefaultPoolingOptions.MinPoolSize;
  FConexao.PoolingOptions.Validate := TDefaultPoolingOptions.Validate;
  FConexao.PoolingOptions.ConnectionLifetime := TDefaultPoolingOptions.ConnectionLifetime;
  FConexao.Pooling := TDefaultPoolingOptions.Pooling;
  FConexao.AfterConnect := TModuloEvents.AfterConnect;
  Try
    FConexao.Connect;
  Except
    On E: Exception Do
    Begin
      if E.message.ToLower.Contains('Maximum connections reached in pool'.ToLower) then
      begin
        FConexao.Pooling := False;
        FConexao.Connect;
        pGravarErro(True, E.Message, 'TCriarConexao.Create - ' + AInfo, FConexao);
      end
      else
      begin
        Sleep(1000);
        FConexao.Connect;
      end;
    End;
  End;
end;

destructor TCriarConexao.Destroy;
begin
  FConexao.AfterConnect := Nil;
  If FConexao.Connected Then
    FConexao.Disconnect;

  FreeAndNil(FConexao);
  inherited Destroy;
end;

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

function HorarioExecutaRobo(AValor: String): Boolean ;
  Var
    HroInicial : TDateTime;
    HroFinal   : TDateTime;
    HoraAtual  : TDateTime;
Begin
  Result := True;

  If Not fEmptyStr(AValor) Then
  Begin
    Result := False;

    HoraAtual  := TimeOf(fTime());
    If Not TryStrToTime(Copy(AValor, 10, 5), HroInicial) Or
       Not TryStrToTime(Copy(AValor, 25, 5), HroFinal) Then
      Exit;

    If (HoraAtual > HroInicial) And (HoraAtual < HroFinal) Then
      Result := True
    Else If HroInicial + HroFinal = 0 Then
      Result := True;
  End;

End;

function GetIPAddress: Integer;
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

function GetIPAddressAsString: String;
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

function GetComputerNetName: string;
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

function GetUserFromWindows: string;
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

function GetMacAddress: String;
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

function fRetornaCountDados(strTabela, strCampo, strCondicao: String): Integer;
  Var
    qryBusca : TUniQuery;
Begin
  qryBusca := fCriaQuery;
  Result := 0;

  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Text := 'SELECT COUNT(' + strCampo + ') AS QTDE FROM ' + strTabela;

    If (Not fEmptyStr(strCondicao)) Then
    Begin
      If (Pos('WHERE', strCondicao) <= 0) Then
        strCondicao := ' WHERE ' + strCondicao;

      qryBusca.SQL.Add(strCondicao);
    End;

    qryBusca.Open;

    If (Not qryBusca.IsEmpty) Then
      Result := qryBusca.FieldByName('QTDE').AsInteger;
  Finally
    FreeAndNil(qryBusca);
  End
End;

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
            Raise Exception.Create('Não consegui atualizar o proximo sequencial de ' + strCamCfg + ' em CFGSIS. Tente novamente!');
          End;
        End;

      End;

    End;

  Finally
    FreeAndNil(qryGenCfg);
  End;

end;

function fCfgSisHubCitel(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''; strPrefixoTabela: String = ''; strHubMkp: String = ''): Variant;
Var
  qryGenCfg: TUniQuery;
  strValCfg: String;
  strSQL: String;
begin
  qryGenCfg := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '        SIS_CODCFG, ';
    strSQL := strSQL + '        SIS_VALCFG  ';
    strSQL := strSQL + '  FROM ' + strPrefixoTabela + 'CFGSIS ';
    strSQL := strSQL + ' WHERE SIS_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND SIS_CODCFG = :CODCFG ';

    If Not strHubMkp.IsEmpty Then
      strSQL := strSQL + '    AND SIS_HUBMKP = :HUBMKP ';

    With qryGenCfg Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If strCodEmp.IsEmpty Then
        strCodEmp := VS_strCodEmp;

      ParamByName('CODEMP').Value := strCodEmp;
      ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;

      If Not strHubMkp.IsEmpty Then
        ParamByName('HUBMKP').Value := strHubMkp;

      Open;

      If IsEmpty Then
        strValCfg := '';

      strValCfg := FieldByName('SIS_VALCFG').AsString;

      Close;
    End;
  Finally
    FreeAndNil(qryGenCfg);
  End;

  Case varTipVar Of
    varString:
      Result := strValCfg;

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
            Result := FALSE
          Else If Pos(strValCfg, 'S_N_') > 0 Then
            Result := StrToBool(IfThen(strValCfg = 'S', 'True', 'False'))

          Else If Pos(strValCfg, '0_1_') > 0 Then
            Result := StrToBool(IfThen(strValCfg = '1', 'True', 'False'))
          Else
            Result := (Length(strValCfg) > 0) And CharInSet(strValCfg[1], ['T', 't', 'Y', 'y']);

        Except
          Result := FALSE;
        End;

      End;

  Else
    Result := strValCfg;
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
      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

  End

  Else If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7-CFG_VENMAR') > 0 Then
  Begin

    If fCfgSisL('BLOPRE', varBoolean, strCodEmp, dicConfiguracoes) Then
    begin

      If Pos(strCamCfg, 'CFG_ATPVMB-CFG_ATPVM2-CFG_ATPVM3-CFG_ATPVM4-CFG_ATPVM5-CFG_ATPVM6-CFG_ATPVM7') > 0 Then
        Result := 'M'
      Else
        Result := 2;

    End Else
    Begin

      Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

    End;

  End Else
  Begin
    Result := fCfgSisL(strCamCfg, varTipVar, strCodEmp, dicConfiguracoes);

    If SameText('CORZEB', strCamCfg) And fEmptyStr(Result) Then
      Result := clWhite;
  End;
End;

function fRetPathSeImagemValida(strPathImg: String): String;
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
    fMensagem('Atenção','Uma rotina está sendo executada sem a definição da empresa!' + #13 +
                        'Por favor entre em contato imediatamente com a Citel para devidas correções! A aplicação será encerrada!', ['&Ok']);
  End;
{$ENDIF LINUX}

  strConnID := VS_LastConnID;
  If fEmptyStr(strConnID) Then
  Begin
    Try
      objConnection := Nil;
      If Assigned(frmModulo) Then
        objConnection := frmModulo.GetCurrentConnection;
      If Assigned(objConnection) And (objConnection.Connected) Then
        strConnID := fGetConnectionID(objConnection);
    Except
      strConnID := '';
    End;
  End;

  strVersionTitle := 'Monitors\Shared';
  If Assigned(frmModulo) And (Not fEmptyStr(frmModulo.VersionTitle)) Then
    strVersionTitle := frmModulo.VersionTitle;

  pGravarErro(True, '<CFGSIS_CODEMP_VAZIO>', 'Configuração.: ' + 'CFG_' + strCamCfg + sLineBreak +
                                             'Parâmetros...: ' + strParam + sLineBreak +
                                             'Connection Id: ' + strConnID + sLineBreak +
                                             'Version Title: ' + strVersionTitle + sLineBreak +
                                             'Rotina.......: ' + #13 + fRetornaStack);

{$IFNDEF LINUX}
  If blnTerminar Then
  Begin
    TFinalizarAutcomMonitor.Monitorar;
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
              Raise Exception.Create('A configuração ( ' + 'CFG_' + strCamCfg + ' ) não existe na empresa ' + strCodEmp + '.');

          If IsEmpty Then
          Begin
            Close;
            Open;
          End;

          {**********************************************************}
          {* VALIDAÇÃO PARA TESTAR SE JÁ É UMA CHAVE CRIPTROGRAFADA *}
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

function fReservaSaldoPedidosBaixaEntregaFutura: Boolean;
begin
  Result := (fCfgSis('ENTFUT', varBoolean)) And
            (AnsiMatchText(fCfgSis('PEDBEF', varString), ['S', 'P'])) And
            (Not fCfgSis('BEFTRG', varBoolean)) And
            (Not fUsaRotinaWMS()) And
            (fCfgSis('CALSAL', varInteger) <> 2);

  Result := Result And fCfgSis('UTIEFU', varBoolean);//A REMOVER 
end;

function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
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
      pMensagensErro('Houve um erro ao criar configurações no sistema: ' + #13#10 +
                     E.Message, '[pCriarConfiguracoes]');
    End;
  End;

end;

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
          1-Não exibir
          2-Exibir somente margem líquida
          3-Exibir custo/margem bruta/margem líquida
          4-Exibir custo/margem bruta/margem líquida/total produtos preço tabela
          5-Exibir margem líquida/total produtos preço tabela
          6-Exibir custo / custo real / margem bruta / margem liquida
          7-Exibir custo / custo real / margem bruta / margem liquida / total produtos preço tabela
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
    opcPdOrNf   : Result := 'Impressão de Orçamento/Pedido/Nota Fiscal';
    opcEtiqueta : Result := 'Impressão de Etiquetas de Produtos';
  End;
end;

function fRetDescricaoAjuIcm(Const strCodAjuIcm: String): String;
Begin
   Result := fCampoTabela('AJU_DESAJU', 'AJUSTE', ['AJU_CODAJU'], [strCodAjuIcm], False);
End;

function fRetDescricaoMatrizAliquotasIcms(strCodMat: String): String;
begin
  Result := fCampoTabela('ICM_DESCRI', 'MATICM', ['ICM_CODMAT'], [strCodMat], False);
end;

function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
begin

  Result := '';

  If fEmptyStr(strCodEmpresa) Then
    Exit;

  Result := fRetNomeEmpresa(strCodEmpresa);

end;

function fRetNomProduto(Const strCodIte: String ): String;
Begin
  Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False); //Para ler a descrição do buffer
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
                             blnTiraVirgula: Boolean = True;
                             blnTiraAbreviacaoNumero: Boolean = False;
                             strCaracterePersonalizado: String = ''): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  If blnUsaLista Then
    strLista := '/\-_+#,;<>|*ªº°&"''()%$¨@!?§={}[]´`^~¹²³£¢Ø'
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

  If (blnTiraAbreviacaoNumero) Then
    strLista := strLista + 'º°';

  If (Not fEmptyStr(strCaracterePersonalizado)) Then
    strLista := strLista + strCaracterePersonalizado;

  If (Not blnTiraVirgula) Then
    strLista := AnsiReplaceStr(strLista, ',', '');

  strCaracNorm := 'aeiouaeiouaeiouaoaeioucAEIOUAEIOUAEIOUAOAEIOUC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ';

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

function fCadEmp(strNomCampo: String): String;
  Var
    qryGenEmp: TUniQuery;
begin
  {************************************************************************}
  { Verificação do campo ESTADO para evitar sucessivas aberturas do SELECT }
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
{ Na função foi mantido a utilização da função nOw() do     }
{  Delphi, caso a variável VS_Date ainda não estiver ini-   }
{  nicializada, pois, na inicialização do sistema a va-     }
{  riável VS_DATE ainda está nula em alguns pontos. Como    }
{  as funções de retorno de nome de tabelas TMP (que se-    }
{  rão removidas futuramente) se baseiam na data e hora     }
{  para nomear as tabelas, esta deve receber corretamente a }
{  data e hora para criação das tabelas no banco de dados.  }
{  Há também uma questão na inicialização de variáveis glo- }
{  bais que também justifica essa utilização temporariamen- }
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

function RemoveMilliseconds(ATime: TDateTime): TDateTime;
var
  Hour, Min, Sec, MSec: Word;
begin
  // Decodes the time part into hour, minute, second, and millisecond
  DecodeTime(ATime, Hour, Min, Sec, MSec);

  // Re-encodes the time without milliseconds (set MSec to 0)
  Result := EncodeTime(Hour, Min, Sec, 0);
end;

function fCurrentTime: String;
begin
  Result := 'CAST("' + FormatDateTime('hh:mm:ss', fRetHoraServidor) + '" AS TIME)';
end;

function fCurrentDate: String;
begin
  Result := fCurrentDate(VS_Date);
end;

function fCurrentDate(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;

function fCurrentDateTime: String;
begin
  Result := fCurrentDateTime(VS_Date + fTime());
end;

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
        Result := '<stack indisponível>';
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

function fMskDigitos(intDigitos: Integer): String;
  Var
    intContador: Integer;
    strMsk1, strMsk2: String;
begin
  strMsk1 := '#,##';
  strMsk2 := '0.';

  If (intDigitos = 0) Then
    intDigitos := 2;

  For intContador := 1 To intDigitos Do
  Begin
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;

end;

{******************************************}
{* FORMATA UM NUMERO COM X CASAS DECIMAIS *}
{***************************************MV*}
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
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

function fValNumForm(fltValor: Double; intZeros: Integer; intQtdDec: Integer = 2): String; overload;
  Var
    strValFor: String;
Begin

  strValFor := FloatToStrF(fltValor,ffNumber,intZeros,intQtdDec);
  strValFor := AnsiReplaceStr(strValFor, '.', '');
  strValFor := AnsiReplaceStr(strValFor, ',', '');
  strValFor := fStrZero(strValFor,intZeros);
  Result    := strValFor;

End;

function fValNumForm(strValor: String; intZeros: Integer; intQtdDec: Integer = 2): Double; overload;
  Var
    strValFor: String;
begin
  strValFor := Copy(strValor, 1, intZeros-intQtdDec) ;
  strValFor := strValFor + ',';
  strValFor := strValFor + Copy(strValor, (intZeros-intQtdDec)+1, intQtdDec);
  Result := fStrToFloat(strValFor);
end;

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

(*
  2.1 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for inferior a 5, o último permanecerá sem modificação
  Exemplo: 1,333 3 arredondado à primeira decimal tornar-se-á:1,3

  2.2 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for superior a 5, ou sendo 5, seguido de no mínimo um algarismo diferente de zero,
  o último algarismo a ser conservado deverá ser aumentado de uma unidade.
  Exemplo: 1,666 6 arredondado à primeira decimal tornar-se-á:1,7
  4,851 5 arredondado à primeira decimal torna-se-ão:4,9

  2.3 Quando o algarismo imediatamente seguinte ao último algarismo a ser conservado
  for 5 seguido de zeros, dever-se-á arredondar o algarismo a ser conservado para o
  algarismo par mais próximo. Conseqüentemente, o último algarismo a ser retido,
  se for ímpar, aumentará uma unidade.
  Exemplo: 4,550 0 arredondado à primeira decimal tornar-se-á:4,6

  2.4 Quando o algarismo imediatamente seguinte ao último a ser conservado for 5
  seguido de zeros, se for par o algarismo a ser conservado ele permanecerá sem
  modificação.
  Exemplo: 4,850 0 arredondado à primeira decimal tornar-se-á:4,8
*)
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

        VS_TimerTransacao.Enabled := True;
      End
      Else
      Begin
        If (strIdenti.Contains(CNS_TRA_EM_MSG)) Then
        Begin
          strTextoComplementarAoCallStack :=
              strTextoComplementarAoCallStack + #10#13 +
              'Versão Arquivo: '  + fRetornaVersao(Application.ExeName, False) + #13 +
              'Versão Produto: '  + fRetornaVersao(Application.ExeName, True)  + #13 +
              'Path do Arquivo: ' + ExtractFilePath(Application.ExeName);
        End;

        qryAux.Append;
        qryAux.ParamByName('TRA_CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.ParamByName('TRA_IDENTI').AsString := strIdenti;
        qryAux.ParamByName('TRA_STACK_').AsString := strTextoComplementarAoCallStack + #10#13 + fRetornaStack;
        qryAux.ParamByName('TRA_ID_CON').AsString := fGetConnectionID(objConexao);
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

  If VS_dtaIdentiTransacao.Count = 0 Then
    VS_TimerTransacao.Enabled := False;
end;

function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
begin
  If Assigned(objConexao) Then
    Result := objConexao.InTransaction
  else
    Result := frmModulo.GetCurrentConnection.InTransaction;
end;

function fConexaoAtiva(): Boolean;
begin
  Result := Assigned(frmModulo) And frmModulo.GetCurrentConnection.Connected;
end;

procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');

  function fMensagemDeveSerRegistrada: Boolean;
  begin
    Result := (Not AnsiUpperCase(strTextoComplementarAoCallStack).Contains('DOCUMENTO EMITIDO EM AMBIENTE DE HOMOLOGAÇÃO'));
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
{* Inicia a Transação no Banco *}
{****************************MV*}
function fStartTransaction(objConexao: TUniConnection = Nil):Boolean;
begin

  Try

    If Assigned(objConexao) Then
    Begin

      If (Not objConexao.InTransaction) Then
      Begin
        blnErroLogRep := False;
        strErroLogRep := '';

        objConexao.StartTransaction;
        if VS_blnGravaLogTransacao then
          pGravaLogTransacao(objConexao);
        Result := True;
      End
      Else
      Begin
        Result := True;
      End;

    End
    Else
    Begin

      If (Not frmModulo.GetCurrentConnection.InTransaction) Then
      Begin
        blnErroLogRep := False;
        strErroLogRep := '';

        frmModulo.GetCurrentConnection.StartTransaction;
        if VS_blnGravaLogTransacao then
          pGravaLogTransacao();
        Result := True;
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
{* RollBack para Transação *}
{************************MV*}
function fRollBack(objConexao: TUniConnection = Nil):Boolean;
begin

  Result        := True;
  blnErroLogRep := False;
  strErroLogRep := '';

  Try

    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction) Then
      Begin
        objConexao.Rollback;
      End;
    End
    Else
    Begin
      If (frmModulo.GetCurrentConnection.InTransaction) Then
      Begin
        frmModulo.GetCurrentConnection.Rollback;
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
{* Commita a Transação *}
{********************MV*}
function fCommit(objConexao: TUniConnection = Nil):Boolean;
begin
  If blnErroLogRep Then
  Begin
    Raise Exception.Create(strErroLogRep);
    Exit;
  End;

  Result := True;
  Try

    If Assigned(objConexao) Then
    Begin
      If (objConexao.InTransaction = True) Then
      Begin
        objConexao.Commit;
      End;
    End
    Else
    Begin
      If (frmModulo.GetCurrentConnection.InTransaction = True) Then
      Begin
        frmModulo.GetCurrentConnection.Commit;
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

function RetornaTimeStampEmMilisegundos: Int64;
  var
    LDateTime: TDateTime;

    LDataServidor,
    LHoraServidor: TDateTime;

    LConsulta: TUniQuery;

    SystemTime: TSystemTime;
begin
  //Modificada a rotina anterior do Roni, para poder enviar a Data/Hora do servidor
  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT CURRENT_DATE AS DATA, ' +
                          '       CURTIME(3) AS HORA ' +
                          'FROM DUAL';
    LConsulta.Open;

    LDataServidor := FloatToDateTime(LConsulta.FieldByName('DATA').AsFloat);
    LHoraServidor := IncHour(FloatToDateTime(LConsulta.FieldByName('HORA').AsFloat), PegaTimeZone);

    LDateTime := EncodeDate(YearOf(LDataServidor), MonthOf(LDataServidor), DayOf(LDataServidor)) +
                 EncodeTime(HourOf(LHoraServidor), MinuteOf(LHoraServidor), SecondOf(LHoraServidor), MilliSecondOf(LHoraServidor));

    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);

    LConsulta.Close;
    FreeAndNil(LConsulta);
  Except
    GetSystemTime(SystemTime);
    LDateTime := EncodeDate(SystemTime.wYear, SystemTime.wMonth, SystemTime.wDay) +
                 EncodeTime(SystemTime.wHour, SystemTime.wMinute, SystemTime.wSecond, SystemTime.wMilliseconds);
    Result := MilliSecondsBetween(LDateTime, UnixDateDelta);
  End;
End;

function PegaTimeZone: Integer;
  Var
    TimeZone: TTimeZoneInformation;

    LTimeZoneServer: TUniQuery;

    LValorMaquinaLocal: Integer;

    LPossuiTimeZoneAlterado: Boolean;
begin
  If VS_TimeZone <> 0 Then
    Exit(VS_TimeZone);

  Result := 3;

  LTimeZoneServer := fCriaQuery;
  Try
    Try
      GetTimeZoneInformation(TimeZone);

      LValorMaquinaLocal := TimeZone.Bias div 60;
    Except
      LValorMaquinaLocal := 3;
    End;

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

      Result := LValorMaquinaLocal;
    Except
      Result := LValorMaquinaLocal;
    End;
  Finally
    VS_TimeZone := Result;

    LTimeZoneServer.Close;

    FreeAndNil(LTimeZoneServer);
  End;
end;


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
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);

End;

{*****************************************************************************************}
{*                                                                                       *}
{* -> Funcao Mensagem                                                                    *}
{*                                                                                       *}
{*    - Parametros:                                                                      *}
{*      1) Titulo                                                                        *}
{*      2) Texto                                                                         *}
{*      3) Matriz com o nome para até 03 botoes, sendo que vc pode passar ['',''] para   *}
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
    arrOpcoes[1] := '&Não';
    intQtdOpcoes := 2;
  End;

  If Trim(arrOpcoes[0]) = '' Then
  Begin
    MessageDlg('É obrigatório a passagem dos parametros em ordem!', mtInformation, [mbOK], 0);
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
  Result := fMensagem('', strMensagem, ['&Sim', '&Não']) = 1;
end;

{********************************************}
{* UMA MANEIRA DIFERENTE DO FREEANDNIL PARA *}
{* LIBERAR FORMULÁRIOS DA MEMÓRIA           *}
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

function fTiraCaracEspeciaisPonto(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():.';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

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

function fTratarNomeDiretorio(strNomDir: String): String;
begin
  Result := strNomDir.Trim;
  Result := Result.Replace('/', '_');
  Result := Result.Replace('\', '_');
  Result := Result.Replace('|', '_');
  Result := Result.Replace('<', '_');
  Result := Result.Replace('>', '_');
  Result := Result.Replace('*', '_');
  Result := Result.Replace(':', '_');
  Result := Result.Replace('â€œ', '_');
  Result := Result.Replace('?', '_');
end;

{**************************************}
{* ADICIONA DADOS EM UMA MATRIZ       *}
{***********************************WI*}
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

procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False);
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

  SetLength(arrHin, Length(arrHin) + 1);
  arrHin[High(arrHin)] := strHint;
End;

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
{* Lê/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TIniFile;
begin
  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'opcoes.ini';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);
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

  iniArqIni := TIniFile.Create(strNomArq);
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

{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
procedure pAbrirBanco(Database: TUniConnection);
  Var
    qryGen: TUniQuery;
    intCodAut: Integer;
    blnReconectar: Boolean;
    blnIntegracaoArmazens: Boolean;

    LNomeBancoEmail: String;

    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;

  {******************************************************************************}
  {* QUANDO O AUTCOM É EXECUTADO ATRAVÉS DO AGENDADOR DE TAREFAS, A FUNÇÃO:     *}
  {* FileExists('libUtil.dll') NÃO FUNCIONA, RETORNA QUE NÃO ENCONTRA O ARQUIVO,*}
  {* POR ISSO SE FAZ NECESSÁRIO PASSAR O CAMINHO COMPLETO! REQ: 21251           *}
  {***************************************************************************RN*}
  function fPathExe: String;
  begin
    Result := ExtractFilePath(Application.ExeName);
  end;

  {*****************************************}
  {* VERIFICA SE IRÁ UTILIZAR A SENHA DA   *}
  {* DLL.                                  *}
  {**************************************MV*}
  function fUsarSenhaDLL: Boolean;
  begin
    Result := (intCodAut > 0) And (FileExists(fPathExe + 'libUtil.dll'));
  end;

  {*****************************************}
  {* EFETUA A CONEXÃO COM O BANCO.         *}
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

      If Not blnIntegracaoArmazens Then
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

    If (blnIntegracaoArmazens) Then
      If Not fEmptyStr(fArqIni(0,'GERAL','CODEMP','')) And (fEmptyStr(VS_strCodEmp)) Then
        VS_strCodEmp := AnsiReplaceStr(fArqIni(0,'GERAL','CODEMP',''), ' ', '');

    Database.Connect;

  End;

  {*****************************************}
  {* MOSTRA MSG DE ERRO.                   *}
  {**************************************MV*}
  procedure pMsgErro(E: Exception);
  begin
    TFinalizarAutcomMonitor.Monitorar;
    fMensagem('Aviso', 'Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!', ['&Ok']);
    fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&Ok']);
    Application.Terminate;
  end;

begin

  blnIntegracaoArmazens := False;

  {$IFDEF INTEGRACAO_ARMAZENS}
    blnIntegracaoArmazens := True;
  {$ENDIF}

  blnReconectar := False;
  intCodAut := StrToIntDef(fArqIni(0, 'GERAL', 'CODAUT', '0'), 0);

  Try
    pConectar;
  Except
    On E: EUniError Do
    Begin

      {*****************************************}
      {* NÃO CONECTOU POIS A SENHA ESTAVA      *}
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
  {* A SENHA ESTAVA INCORRETA IRÁ TENTAR   *}
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

    DefinirTimeZoneEmSessaoMySql(qryGen.Connection, VS_strCodEmp);
  Except
    On E : Exception Do
    Begin
      TFinalizarAutcomMonitor.Monitorar;
      pMensagensErro(E.Message, '[pAbrirBanco]');
      fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
      Application.Terminate;
    End;
  End;

  LNomeBancoEmail := Trim(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_EMABAS', VS_strCodEmp]));
  If LNomeBancoEmail.IsEmpty Then
    LNomeBancoEmail := 'AUTCOM';

  VS_PermitidoEnviarEmail := fArqIni(0, 'BANCO', 'NOMBAN', '').Equals(LNomeBancoEmail);
  If Not VS_PermitidoEnviarEmail Then
    VS_PermitidoEnviarEmail := fArqIni(0, 'GERAL', 'FORCAR_ENVIO_EMAIL', '').Equals('S');

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
    Result.Connection := frmModulo.GetCurrentConnection;

  Result.Tag := Result.Connection.Tag;
  Result.Options.RequiredFields := False;

  If Assigned(untFuncoesSimples.VS_objTraceViewer) Then
    untFuncoesSimples.VS_objTraceViewer.SetQueryEvents(Result);
End;

function fTamanhoArquivo(strArquivo: String): Cardinal;
Var
  FHandle: Cardinal;
begin
  FHandle := CreateFile(PChar(strArquivo), GENERIC_READ,
    FILE_SHARE_READ Or FILE_SHARE_WRITE Or FILE_SHARE_DELETE, Nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

  If FHandle <> 0 Then
    Result := GetFileSize(FHandle, Nil)
  Else
    Result := 0;

  FileClose(FHandle);
end;

function fTamanhoArquivo(strArquivo: String;
  tipoTamanho: TTipoTamanhoArquivo): Cardinal; overload;
Var
  fltTamanhoReal : Double;
begin
  Result         := fTamanhoArquivo(strArquivo);
  fltTamanhoReal := Result;

  If Result = 0 Then
    Exit;

  If tipoTamanho In [ttTByte, ttGByte, ttMByte, ttKByte] Then
    fltTamanhoReal := fltTamanhoReal / 1024;

  If tipoTamanho In [ttTByte, ttGByte, ttMByte] Then
    fltTamanhoReal := fltTamanhoReal / 1024;

  If tipoTamanho In [ttTByte, ttGByte] Then
    fltTamanhoReal := fltTamanhoReal / 1024;

  If tipoTamanho In [ttTByte] Then
    fltTamanhoReal := fltTamanhoReal / 1024;

  Result := Trunc(fltTamanhoReal);

  If Abs(fltTamanhoReal - Result) > 0 Then
    Result := Result + 1;
end;

procedure pDefinirCharsetConexao;
var
  qryGen : TUniQuery;
begin

  qryGen := fCriaQuery;

  Try

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
        TFinalizarAutcomMonitor.Monitorar;
        pMensagensErro(E.Message, '[pDefinirCharsetConexao]');
        fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
        Application.Terminate;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

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
{* CÓDIGO DE ERRO CORRESPONDENTE           *}
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
  HandleException;

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
    ERR_ACCESS_DENIED        :pErro('Accesso negado ao usuário ' + strInfo + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_NOT_EXIST      :pErro('Tabela ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_FOUND      :pErro('Campo ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_READONLY       :pErro('Operação não suportada no modo Somente Leitura!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_INT        :pErro(strInfo + ' não é um número inteiro válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_DATE       :fMensagem('ATENÇÃO!',strInfo + ' não é uma data válida!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem, ['&OK']);
    ERR_NOT_VALID_FLOAT      :pErro(strInfo + ' não é um número válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_IN_EDIT          :pErro('Tabela não está em modo de Edição!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_SQL_SYNTAX           :pErro('Há um erro de Sintaxe no SQL: ' + strInfo + #10 + 'Local: ' + #10 + LocalErro + #10 + strMensagem);
    ERR_BD_NOT_ACTIVE        :pErro('O Servidor de banco de dados não está ativo!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_NULL       :pErro('O campo ' + strInfo + ' é de preenchimento obrigatório!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_PRIMARY_KEY          :pErro(strInfo + ': valor duplicado não permitido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ORDER_BY             :pErro('Coluna ' + strInfo + ' desconhecida no processo de ordenação!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERROR_FOREIGN_KEY_DELETE :Begin
                                pGravarErro(True, '[ERROR_FOREIGN_KEY_DELETE] - Não é possível excluir esse registro', MensErro + sLineBreak + fRetornaInformacaoUltimoErroForeignKey());
                                fMensagem('ATENÇÃO!', 'Não é possível excluir esse registro, pois existe movimentação para o mesmo.', ['&O k']);
                              End;
    ERR_DEFAULT_PRINTER      :fMensagem('ATENÇÃO!', 'Não há impressora padrão selecionada!', ['&O k']);
  End;

end;

procedure pPlaySound(AFileName: String);
begin
  If FileExists(ExtractFilePath(Application.ExeName) + 'PlaySound.exe') Then
    WinExec(PAnsiChar(AnsiString(ExtractFilePath(Application.ExeName) + 'PlaySound.exe "' + AFileName + '"')), SW_HIDE)
  Else
    sndPlaySound(PWideChar(AFileName), SND_ASYNC);
end;

procedure pPlaySound(AStream: TMemoryStream);
begin
  sndPlaySound(AStream.Memory, (SND_ASYNC or SND_MEMORY));
end;

procedure pMensagemSonora(strMensagem: String; blnMaximizar: Boolean = False; intFontSize: Integer = 0;
  intWidth: Integer = 0; cfgArqSom: String = ''; mmsArqSom: TMemoryStream=Nil; blnMsgOkPadraoSeCaminhoSomVazioOuVariavelSomNil: Boolean = False); Overload;
  Var
    aHandle: THandle;
    wrdTexto     : Word;
    strPathSomAlerta: String;
begin
  If Not VS_ExibirMensagemAoUsuario Then
  Begin
    If Assigned(VS_OnMensagemAoUsuario) Then
      VS_OnMensagemAoUsuario(strMensagem);

    aHandle := FindWindow('TfrmAutcomSvc', Nil);
    If aHandle > 0 Then
    Begin
      wrdTexto := GlobalAddAtom(Pchar(strMensagem));
      SendMessage(aHandle,CM_AVISOS,0,wrdTexto);
      GlobalDeleteAtom(wrdTexto);
    End;

    Exit;
  End;

  strPathSomAlerta := '';
  If (Not fEmptyStr(cfgArqSom)) Then
    strPathSomAlerta := Trim(fCfgSis(cfgArqSom, varString));

  If (blnMsgOkPadraoSeCaminhoSomVazioOuVariavelSomNil) And (((Not cfgArqSom.IsEmpty) And (strPathSomAlerta.IsEmpty)) Or (cfgArqSom.IsEmpty And (Not Assigned(mmsArqSom)))) Then
  Begin
    fMensagem('Atenção!', strMensagem, ['&Ok'])
  End
  Else
  Begin
    pCriarFormularios(TfrmMensagemSonora, frmMensagemSonora);
    Try
      Try
        If blnMaximizar Or ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        Begin
          frmMensagemSonora.lblRodape.Caption := 'Pressione [ESPAÇO]';
          frmMensagemSonora.WindowState := wsMaximized;
        End;

        If intFontSize > 0 Then
          frmMensagemSonora.lblMensagem.Font.Size := intFontSize;

        frmMensagemSonora.lblMensagem.Caption := strMensagem;

        If intWidth > 0 Then
          frmMensagemSonora.Width := intWidth;

        frmMensagemSonora.strPathSomAlerta := strPathSomAlerta;
        frmMensagemSonora.mmsArqvSomAlerta := mmsArqSom;

        frmMensagemSonora.ShowModal;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[pMensagemSonora]');
      End;
    Finally
      pFreeAndNil(frmMensagemSonora);
    End;
  End;
end;

procedure pMensagemSonora(strMensagem: String; cfgArqSom: String; blnMsgOkPadraoSeCaminhoArqSomVazio: Boolean = False); Overload;
  Var
    strPathSomAlerta: String;
begin
  If fEmptyStr(strMensagem) Then //Se strMensagem eu só quero que execute o som da CFG
  Begin
    strPathSomAlerta := '';
    If (Not fEmptyStr(cfgArqSom)) Then
      strPathSomAlerta := fCfgSis(cfgArqSom, varString);

    If (Not fEmptyStr(strPathSomAlerta)) Then
      sndPlaySound(PWideChar(strPathSomAlerta), SND_ASYNC);
  End
  Else
  Begin
    pMensagemSonora(strMensagem, False, 0, 0, cfgArqSom, Nil, blnMsgOkPadraoSeCaminhoArqSomVazio);
  End;
end;

procedure pMensagemSonora(strMensagem: String; mmsArqSom: TMemoryStream; blnMsgOkPadraoSeVariavelSomNil: Boolean = False); Overload;
begin
  If fEmptyStr(strMensagem) Then //Se strMensagem eu só quero que execute o som da variavel
  Begin
    If Assigned(mmsArqSom) Then
      sndPlaySound(mmsArqSom.Memory, (SND_ASYNC or SND_MEMORY));
  End
  Else
  Begin
    pMensagemSonora(strMensagem, False, 0, 0, '', mmsArqSom, blnMsgOkPadraoSeVariavelSomNil);
  End;
end;

procedure pImprimirEtiquetaZPL(strNomPro, strDesPro, strNomArq: String);
begin
  pImprimirArquivoZPL(strNomPro, strDesPro, strNomArq);
end;

procedure pImprimirArquivoZPL(strNomPro, strDesPro, strNomArq: String);
begin
//do nothing
end;


{*************************************************}
{*   Grava Mensagens de Erro no Arquivo de LOG   *}
{**********************************************DV*}
procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; Conexao: TUniConnection = Nil);
  Var
    qryLogErr: TUniQuery;
begin
  If GravarErro Then
  Begin
//    If fStartTransaction Then
//    Begin

      qryLogErr := fCriaQuery(Nil, Conexao);
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

function fTipoErroGravaEmailErrosLog(AMensagemErro: String): Boolean;
Var
  LQuery: TUniQuery;
  LErro: String;
begin
  Result := False;

  If Not Assigned(VS_EmailTiposErro) Then
  Begin
    VS_EmailTiposErro := TStringList.Create;
    LQuery := fCriaQuery(Nil);
    Try
      LQuery.SQL.Text := 'SELECT * FROM EMAERR_LIK';
      LQuery.Open;
      While Not LQuery.Eof Do
      Begin
        VS_EmailTiposErro.Add(LQuery.FieldByName('ERR_DESCRI').AsString);
        LQuery.Next;
      End;
    Finally
      FreeAndNil(LQuery);
    End;
  End;

  For LErro In VS_EmailTiposErro Do
    If AMensagemErro.ToUpper.Contains(LErro.ToUpper) Then
      Exit(True);
end;

procedure pGravarEmailErros(strTip_FC, strForCli, strAssunt, strDestin, strMsgErr: String);
  Var
    qryEmaErrLog: TUniQuery;
begin
  qryEmaErrLog := fCriaQuery(Nil);
  qryEmaErrLog.SQL.Add('SELECT * FROM EMAERR_LOG WHERE FALSE');

  Try
    With qryEmaErrLog Do
    Begin
      Open;
      Insert;
      FieldByName('LOG_DTAERR').AsDateTime := VS_Date;
      FieldByName('LOG_HORERR').AsDateTime := fTime();
      FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_CODEMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_TIP_FC').AsString   := strTip_FC;
      FieldByName('LOG_FORCLI').AsString   := strForCli;
      FieldByName('LOG_ASSUNT').AsString   := strAssunt;
      FieldByName('LOG_DESTIN').AsString   := strDestin;
      FieldByName('LOG_MSGERR').AsString   := strMsgErr;
      Post;
      Close;
    End;
  Finally
    FreeAndNil(qryEmaErrLog);
  End;
end;

function fRetornaInformacaoUltimoErroForeignKey: String;
var
  strRetInnoDB: String;
begin
  Result := fRetornaInformacaoUltimoErroForeignKey(strRetInnoDB);
end;

function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String;
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


function fItemPigmento(strCodIte: String; Var strCodBas: String): Boolean;
begin
  Result    := False;
  strCodBas := '';

  if fEmptyStr(strCodIte) then
    Exit;

  if not fTabelaVazia('DUP_CADBAS', False) Then
  Begin
    strCodBas := fCampoTabela('BAS_CODBAS', 'DUP_CADBAS', ['BAS_CODITE'], [strCodIte], False);
    Result := Not fEmptyStr(strCodBas);
  End;

end;

function fGetEmpresasReprocessarItemPedido(ASeqFdo: String): TArray<String>;
Const
  SQL_EMPRESAS =
    'CONCAT( ' +
    '  IFNULL(FATGOR.FGO_CODEMP, ""), "," , ' +
    '  IFNULL(FATGOR.FGO_EMPFOR, ""), "," , ' +
    '  IFNULL(FATGOR.FGO_EMPFAT, ""), "," , ' +

    '  IFNULL(EXTGOR.FGO_EMP_TE, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMP_CD, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMPDAB, ""), "," , ' +
    '  IFNULL(EXTGOR.FGO_EMPEXP, ""), "," , ' +

    '  IFNULL(EXTDOR.FDO_EMPFOR, ""), "," , ' +

    '  IFNULL(FATDOR.FDO_CODEMP, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPITE, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPPRD, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPDEV, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPACA, ""), "," , ' +
    '  IFNULL(FATDOR.FDO_EMPFAT, "")        ' +
    ') ';

  SQL_FROM =
    ' FATGOR ' +
    ' INNER JOIN EXTGOR ' +
    '   ON FGO_SEQFGO = FATGOR.AUTOINCREM ' +
    ' INNER JOIN FATDOR ' +
    '   ON FDO_SEQGER = FATGOR.AUTOINCREM ' +
    ' INNER JOIN EXTDOR ' +
    '   ON FDO_SEQFDO = FATDOR.AUTOINCREM ';
Var
  LIncFut: String;
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  SetLength(Result, 0);

  LEmpresas := String(fCampoTabela(
    SQL_EMPRESAS, SQL_FROM, ['FATDOR.AUTOINCREM'], [ASeqFdo])).Split([',']);

  For LEmpresa In LEmpresas Do
    If Not LEmpresa.IsEmpty Then
      If Not MatchStr(LEmpresa, Result) Then
        pAddDados(Result, LEmpresa);

  //Pedido de baixa de Entrega Futura
  LIncFut := fCampoTabela('FDO_INCFUT', 'EXTDOR', ['FDO_SEQFDO'], [ASeqFdo]);

  If Not LIncFut.IsEmpty Then
  Begin
    //Retorna a empresa do documento de venda de entrega futura
    LEmpresa := fCampoTabela('DET_CODEMP', 'MOVDET', ['AUTOINCREM'], [LIncFut]);

    If Not LEmpresa.IsEmpty Then
      If Not MatchStr(LEmpresa, Result) Then
        pAddDados(Result, LEmpresa);
  End;

end;

function fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>;
begin
  Result := String(fCampoTabela('GROUP_CONCAT(AUTOINCREM)', 'FATDOR',
                               ['FDO_NUMDOC','FDO_ESPDOC','FDO_CODEMP','FDO_CODITE'],
                               [ANumPed, AEspPed, AEmpPed, ACodIte])).Split([',']);
end;

function fGetEmpresasReprocessarItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte: String): TArray<String>; overload;
Var
  LAutoincrem: String;
  LArrayAutoincrem: TArray<String>;
  LEmpresa: String;
  LEmpresas: TArray<String>;
begin
  SetLength(Result, 0);

  LArrayAutoincrem := fGetAutoincremItemPedido(ANumPed, AEspPed, AEmpPed, ACodIte);

  For LAutoincrem In LArrayAutoincrem Do
  Begin
    LEmpresas := fGetEmpresasReprocessarItemPedido(LAutoincrem);

    For LEmpresa In LEmpresas Do
      If Not LEmpresa.IsEmpty Then
        If Not MatchStr(LEmpresa, Result) Then
          pAddDados(Result, LEmpresa);
  End;

end;

procedure ReprocessarItem(const ACodIte: String; ACodEmp: String; AEntFut: Boolean = True);
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery();

  Try
    LQry.SQL.Add('UPDATE ITEGER SET         ');
    LQry.SQL.Add('  ITE_REPAUD = "S"        ');

    If AEntFut Then
      LQry.SQL.Add('  ,ITE_REPAEF = "S"      ');

    LQry.SQL.Add('WHERE ITE_CODITE = :CODITE ');

    If (Not fEmptyStr(ACodEmp)) Then
      LQry.SQL.Add('AND ITE_CODEMP = :CODEMP');

    LQry.ParamByName('CODITE').AsString := ACodIte;

    If (Not fEmptyStr(ACodEmp)) Then
      LQry.ParamByName('CODEMP').AsString := ACodEmp;

    LQry.ExecSQL();
  Finally
    FreeAndNil(LQry);
  End;
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

    Else If Pos('BALCÃO', strNomCli) > 0 Then
      Result := True;

  End;

  If blnSeguradora And (Pos('SEGURADORA', strNomCli) > 0) Then
    Result := True;

end;

function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
Begin
  If (strEstado = 'EX') Or (FPais = opcParaguai) Then
  Begin

    Result := strValor;

  End
  Else
  Begin


    strValor := AnsiReplaceStr(strValor,'.','');
    strValor := AnsiReplaceStr(strValor,',','');
    strValor := AnsiReplaceStr(strValor,'-','');
    strValor := AnsiReplaceStr(strValor,'/','');

    Result := Trim(strValor);
    {************************************}
    {* SE FOR MAIOR QUE 11 ENTÃO É CNPJ *}
    {*********************************AF*}

    If Not fEmptyStr(Result) Then
    Begin

      If Length(Result) > 11 Then
      Begin
        Insert('.',Result,3);  // XX.XXX.XXX/XXXX-XX
        Insert('.',Result,7);  // XX.XXX.XXX/XXXX-XX
        Insert('/',Result,11); // XX.XXX.XXX/XXXX-XX
        Insert('-',Result,16); // XX.XXX.XXX/XXXX-XX
      End
      Else
      Begin
        Insert('.',Result,4);  // XXX.XXX.XXX-XX
        Insert('.',Result,8);  // XXX.XXX.XXX-XX
        Insert('-',Result,12); // XXX.XXX.XXX-XX
      End;

    End;

  End;

End;

function CalcularFatorVencimento(ADataVencimento: TDateTime): String;
  Const
    LDataBaseNova = '22/02/2025';
    LDataBaseAntiga = '07/10/1997';
    LFatorBase = 1000;
  Var
    LDiasCorridos: Integer;
    LDataBaseDate: TDateTime;
begin
  Result := '';

  If (ADataVencimento < StrToDateTime(LDataBaseNova)) Then
    Result := FloatToStr(ADataVencimento - StrToDateTime(LDataBaseAntiga))
  Else
  Begin
    LDataBaseDate := StrToDate(LDataBaseNova);
    LDiasCorridos := DaysBetween(ADataVencimento, LDataBaseDate);
    Result := IntToStr(LFatorBase + LDiasCorridos);
  End;
end;

function fRetNomeEmpresa(strCodEmp: String): String; overload;
begin
  Result := '';

  If (fEmptyStr(strCodEmp)) Then
    Exit;

  Result := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False);
End;

function fRetNomeProduto(strCodIte: String): String;
begin
  Result := '';

  If (fEmptyStr(strCodIte)) Then
    Exit;

  Result := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
End;

function fRetNomeEmpresa: String;
begin
  Result := fRetNomeEmpresa(VS_strCodEmp);
end;

{*******************************}
{* RETORNA O NOME DO MOTORISTA *}
{****************************AF*}
function fRetNomeMotorista(strCodMot: String; blnAtivos: Boolean = False): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  MOT_NOMMOT           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADMOT               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  MOT_CODMOT = :CODMOT ';

    If blnAtivos Then
      strSQL := strSQL + '  AND MOT_STATUS = "A" ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMOT').AsString := strCodMot;
      Open;

      Result := FieldByName('MOT_NOMMOT').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

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
{* RETORNA O NOME DA TRANSPORTADORA DE ACORDO COM O CÓDIGO *}
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

{*****************************************}
{* RETORNA O TAMANHO DO CAMPO DE ACORDO  *}
{* COM A TABELA 'PROCOD'                 *}
{**************************************MV*}
function fRetTamCampo(strNomeTabela: String): Integer;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;

begin
  Try

    qryGenCod := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

    With qryGenCod Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('TAMCOD').AsInteger
      Else
        Result := 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

function fGetParametrosDaConexao : TDatabaseParameters;
  Var
    objConexaoAtual : TUniConnection;
begin
  objConexaoAtual := frmModulo.GetCurrentConnection;
  FillChar(Result, Sizeof(Result), #0);
  Result.Database := objConexaoAtual.Database;
  Result.UserName := objConexaoAtual.Username;
  Result.Password := objConexaoAtual.Password;
  Result.Port := objConexaoAtual.Port;
  Result.Server := objConexaoAtual.Server;

  if FileExists(ExtractFilePath(Application.ExeName) + 'libmysql57.dll') then
    Result.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql57.dll'
  else
    Result.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql41.dll';

  Result.Driver := 'MySQL';
end;

function fGetSelectProcodDoArquivoForUpdate : String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  PRO_CODSEQ AS CODSEQ, ';
  Result := Result + '  PRO_TAMCOD AS TAMCOD ';
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

function fAtualizaProCod(const strNomeTabela : String; const strCampoBusca : String; const strTabelaBusca : String = ''; const intQtdCod : Integer = 1; objConnection : TUniConnection = Nil; const objFncFmt : TFcnFormataProCod = Nil): String;//>Compatibilidade
begin
  Result := fAtualizaProCod(strNomeTabela, intQtdCod, objConnection);
  If Not Assigned(objFncFmt) Then
    Exit;
  Result := objFncFmt(Result);
end;

{**************************************************}
{* PEGA O PROXIMO CODIGO E ATUALIZA TABELA PROCOD *}
{* ADICIONADO UM PARÂMETRO PARA ATUALIZAR UMA SE- *}
{* QUÊNCIA DE CÓDIGOS                             *}
{********************************************MV*AJ*}
function fAtualizaProCod(strNomeTabela: String; intQtdCod: Integer = 1; conSegConexao: TUniConnection = Nil) : String;
  const
    Max_Tentativas = 3;
  Var
    strSQL        : String;
    intCodigoAtual: Int64;
    intTamCodigo  : Integer;
    blnComita     : Boolean;
    qryGenCod     : TUniQuery;
    intTentativa  : Integer;

begin
  Result := '';
  blnComita := False;
  intTentativa := 0;

  Repeat
    Inc(intTentativa);
    Try
      If Pos(strNomeTabela, 'PROCOD_PROINC') <= 0 Then
        pValidaProCod(strNomeTabela);

      qryGenCod := fCriaQuery(Nil, conSegConexao);

      If Not frmModulo.GetCurrentConnection.InTransaction Then
      Begin
        fStartTransaction;
        blnComita := True;
      End;

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
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
        End;

        intCodigoAtual := StrToInt64(FieldByName('CODSEQ').AsString);
        intTamCodigo   := FieldByName('TAMCOD').AsInteger;
        Close;
      End;

      Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');

      strSQL := fGetUpdateProcodDoArquivo;

      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODSEQ').AsString := fPadL(IntToStr(intCodigoAtual+intQtdCod), intTamCodigo, '0');
        ParamByName('NOMARQ').AsString := strNomeTabela;
        ExecSQL;
        Close;
      End;

      If blnComita Then
        fCommit;

      Exit; //sai do repeat
    Except


      On E: Exception Do
      Begin

        If blnComita Then
           fRollBack;

        // Se for erro de LOCK WAIT, tenta novamente
        If (Pos('Lock wait timeout exceeded', E.Message) > 0) And (intTentativa < Max_Tentativas) Then
        Begin
           sleep(2000) // espera um pouco antes de tentar novamente
        End
        Else
          Raise Exception.Create(E.Message + 'Não consegui pegar o proximo sequencial. Tente novamente!');

      End;

    End;

  Until intTentativa >= Max_Tentativas;

  FreeAndNil(qryGenCod);
end;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;

{*****************************************}
{* RETORNA O SEQUENCIAL DE FATURAMENTO   *}
{* PARA A ESPÃ‰CIE ESCOLHIDA E INCREMENTA *}
{**************************************JB*}
function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6; blnApenasObterValorSequencial: Boolean = False): String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;
    blnGravaLog: Boolean;
begin
  blnGravaLog := VS_blnGravaLogTransacao;

  Try
    VS_blnGravaLogTransacao := False;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    fCfgSis(strNomCam, varString, strCodEmp);//Necessario para criar a configuracao quando nao existir

    qryCfgSis := fCriaQuery(nil);

    blnComita := False;

    If (Not frmModulo.GetCurrentConnection.InTransaction) Then
    Begin
      fStartTransaction;
      blnComita := True;
    End;

    Try

      With qryCfgSis Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT  SQL_NO_CACHE       ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');
        SQL.Add('FOR UPDATE                 ');

        ParamByName('CODEMP').Value := strCodEmp;
        ParamByName('CODCFG').Value := 'CFG_' + strNomCam;
        Open;

        If Not fEmptyStr(FieldByName('SIS_VALCFG').AsString) Then
          Result := fStrZero(FieldByName('SIS_VALCFG').AsString, intTamanho)
        Else
          Result := fStrZero('1', intTamanho);

        if not blnApenasObterValorSequencial then
          fAtuCfgSis(strNomCam, IntToStr(StrToInt64Def(Result, 0)+1), strCodEmp);

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('NÃ£o consegui pegar o proximo sequencial de ' + strNomCam + ' em CFGSIS. Tente novamente!');
      End;
    End;

  Finally
    VS_blnGravaLogTransacao := blnGravaLog;
    FreeAndNil(qryCfgSis);
  End;

end;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1; blnForcaValidaExistencia: Boolean = False): String;
  Var
    intAutIncAtu: Integer;

    strSQL,
    strProEmp: String;
    qryGenCod: TUniQuery;

    LConn: TCriarConexao;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;

    begin
      Try

        qryGenTmp := fCriaQuery(nil, LConn.objConexao);

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

    function fGetUltAutIncPROCOD: Integer;
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

      Try
        qryTmp := fCriaQuery(nil, LConn.objConexao);

        With qryTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strTmp);
          Open;

          If Not IsEmpty Then
            Result := FieldByName('AUTINC').AsInteger
          Else
            Result := 1;
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[fGetUltAutIncPROCOD]');
      End;

      FreeAndNIl(qryTmp);
    End;
begin
  If Pos(strNomeTabela, 'PROCOD_PROINC') <= 0 Then
    pValidaProCod(strNomeTabela);

  LConn := TCriarConexao.Create('fRetAutoIncrem('+strNomeTabela+', '+strCodEmp+')');
  try
    qryGenCod := fCriaQuery(Nil, LConn.objConexao);
    Repeat
      fStartTransaction(LConn.objConexao);
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
              FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica(LConn.objConexao) + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
              FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica(LConn.objConexao);
              FieldByName('PRO_CODAUT').AsString  := 'N';
              Post;

              Close;
              SQL.Clear;
              SQL.Add(' SELECT * FROM PROINC');
              Open;

              Insert;
              FieldByName('PRO_NOMARQ').AsString  := 'PROCOD';
              FieldByName('PRO_AUTINC').AsInteger := 1;
              FieldByName('AUTOINCREM').AsString  := fRetEmpresaFisica(LConn.objConexao) + fPadL(IntToStr(fGetUltAutIncPROCOD) + VS_strCodEmp, 17, '0');
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
              Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                   'na tabela de Próximos Incrementos! Verifique.' + #13#10);
            End;
          End;

          strProEmp := fRetEmpresaFisica(LConn.objConexao);

          If FieldByName('AUTINC').Value = Null Then
            intAutIncAtu := 1
          Else
            intAutIncAtu := FieldByName('AUTINC').AsInteger;

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

        fCommit(LConn.objConexao);
      Except
        On E: Exception Do
        Begin
          fRollback(LConn.objConexao);
          FreeAndNil(qryGenCod);
          Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
        End;
      End;
    Until (Not fAutoIncremCadastrado);

    FreeAndNil(qryGenCod);
  finally
    FreeAndNil(LConn);
  end;
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
{* FAZ ALINHAMENTO (PAD) À ESQUERDA      *}
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
    Result := fPadR(strTexto, intTamanhoMin, strCaracter)
  Else Result := Copy(strTexto, 1, intTamanhoMax)
end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) À DIREITA       *}
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
{* Insere Zeros à frente de uma string *}
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
{* Insere Zeros à frente de uma string *}
{************************************MA*}
function fStrZero(Zeros:Integer;Quant:integer):String;
begin
  fStrZero := fStrZero(IntToStr(Zeros),Quant);
end;

function fStrZero(Zeros:Int64; Quant:integer): String;
begin
  fStrZero := fStrZero(IntToStr(Zeros),Quant);
end;

function fStrZero(Zeros: Nullable<Integer>;Quant:integer):String;
  Var
    intAux: Integer;
Begin
  If Zeros.HasValue Then intAux := Zeros.Value
  Else intAux := 0;
  Result := fStrZero(IntToStr(intAux),Quant);
End;

function fStrZero(Zeros: Nullable<String>;Quant:integer):String;
  Var
    strAux: String;
Begin
  If Zeros.HasValue Then strAux := Zeros.Value
  Else strAux := '0';
  Result := fStrZero(strAux,Quant);
End;

function fBase64Decodifica(ATexto: String): String;
var
  LEntrada:  TStringStream;
  LSaida: TStringStream;
begin
  LEntrada := TStringStream.Create(ATexto);
  LSaida   := TStringStream.Create(EmptyStr);

  Try
    DecodeStream(LEntrada, LSaida);
    Result := LSaida.DataString;
  Finally
    FreeAndNil(LEntrada);
    FreeAndNil(LSaida);
  End;
end;

function fGetQuantidadeFatorAxalta(const fltQuantidade: Double; const strCodIte: string): Double;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Result := 0;
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                               ' +
        '   ITE_CODITE                         ' +
        '   , ITE_CNV_ML                       ' +
        '   , (:QTD / ITE_CNV_ML) AS RESULT    ' +
        ' FROM                                 ' +
        '   CADITE I                           ' +
        '   INNER JOIN DUP_CADBAS B            ' +
        '     ON I.ITE_CODITE = B.BAS_CODITE   ' +
        ' WHERE B.BAS_CODITE = :CODITE         ' +
        ' LIMIT 1                              ';
      qryGen.ParamByName('QTD').AsFloat := fltQuantidade;
      qryGen.ParamByName('CODITE').AsString := strCodIte;
      qryGen.Open;

      if qryGen.IsEmpty then
        Result := fltQuantidade
      else
        Result := qryGen.FieldByName('RESULT').AsFloat;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
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
{* GERA O LOG DE ALTERAÇÕES NO BANCO  *}
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
     (strTabela = 'LCA_CADLCA_SIT')    Then
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
{* VERIFICA SE TABELA REPLICA OU NÃO  *}
{***********************************AF*}
function fTabelaReplica(strNomTabela: String): Boolean;
Begin
  FMREWSTabelaReplica.BeginWrite;
  Try
    Try
      If FDicTabelaReplica.ContainsKey(strNomTabela) Then
        Exit(FDicTabelaReplica[strNomTabela]);

      Result := fTabelaPermiteReplicarSempre(strNomTabela);
      FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);

      If Not Result Then
      Begin
        FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
        Exit;
      End;

      pCarregaNre;

      If Not blnTransferindoCodigo Then
      Begin
        cdsTabNRE.First;
        while not cdsTabNRE.Eof do
        Begin

          {**************************************}
          {* SE FOI COLOCADO NO FIM O %         *}
          {***********************************AF*}
          If Pos('%', Trim(cdsTabNRE.Fields[0].AsString)) > 0 Then
          Begin

            If LeftStr(Trim(AnsiUpperCase(strNomTabela)), Length(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString))) - 1) = LeftStr(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString)), Length(Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString))) - 1) Then
            Begin
              Result := False;
              FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End
          {**************************************}
          {* SE NÃO FOI COLOCADO O %            *}
          {***********************************AF*}
          Else
          Begin

            {**************************************}
            {* SE O NOME DA TABELA FOR O MESMO DA *}
            {* CONFIGURAÇÃO ENTÃO NÃO REPLICA     *}
            {***********************************AF*}
            If Trim(AnsiUpperCase(strNomTabela)) = Trim(AnsiUpperCase(cdsTabNRE.Fields[0].AsString)) Then
            Begin
              Result := False;
              FDicTabelaReplica.AddOrSetValue(strNomTabela, Result);
              Exit;
            End;

          End;

          cdsTabNRE.Next;
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
    FMREWSTabelaReplica.EndWrite;
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
    VS_GravaUsuRep := 'S'; //PASSIVO DE CONFIGURAÇÃO CASO ALGUM DIA QUISER FORÇAR A GRAVAÇÃO

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
{* GERA O LOG DE REPLICAÇÃO           *}
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

      If frmModulo.GetCurrentConnection.InTransaction Then
      Begin
        blnErroLogRep := True;
        strErroLogRep := '[GRAVALOGREP] - ' + E.message;
      End;

      pGravarErro(True,'[GRAVALOGREP] - ' + E.message);
    End;
  End;
End;

procedure pTestarLogReplicacao;
  Var
    qryTestaLogReplicacao: TUniQuery;
begin
  If Not VS_EXECUTAR_TESTE_LOG_REPLICACAO Then
    Exit;

  VS_RESULTADO_TESTE_LOG_REPLICACAO := False;

  qryTestaLogReplicacao := fCriaQuery;

  Try
    qryTestaLogReplicacao.SQL.Text := SQL_TESTE_LOG_REPLICACAO;
    qryTestaLogReplicacao.Execute;

    If Not VS_RESULTADO_TESTE_LOG_REPLICACAO Then
      pGravarErro(True, STR_MSG_ERRO_TESTE_LOG_REPLICACAO, fRetornaStack);
  Finally
    qryTestaLogReplicacao.Destroy;
  End;
end;

procedure pCarregaNre(ARefresh: Boolean = False);
  Var
   qryTabNRE: TUniQuery;
begin
  If ARefresh And Assigned(cdsTabNRE) Then
    FreeAndNil(cdsTabNRE);

  If (Not Assigned(cdsTabNRE)) Then
  Begin
    qryTabNRE := fCriaQuery(Nil);
    Try
      qryTabNRE.SQL.Add('SELECT * FROM TABNRE');
      qryTabNRE.Open;

      If (qryTabNRE.IsEmpty) Or (Not qryTabNRE.Active) Then
      Begin
        TFinalizarAutcomMonitor.Monitorar;
        qryTabNRE.Close;
        FreeAndNil(qryTabNRE);
        fMensagem('','Tabela TABNRE vazia! Verifique!',['&OK']);
        Application.Terminate;
        Exit;
      End;

      cdsTabNRE := fCriaClientDatset(qryTabNRE);

      qryTabNRE.Close;
    Finally
      FreeAndNil(qryTabNRE);
    End;
  End;
end;

function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
begin
  Result := True;

  {***************************************************}
  {* NÃO REPLICA A TABNRE!!!!                        *}
  {** 09/06/2008 - 09:54 **************************MV*}
  {** 09/06/2009 - 17:47 **************************JB*}
  {** 13/02/2013 - ********************************JU*}
  If (strNomTabela = 'TABNRE')         Or
     (strNomTabela = 'LOGREP')         Or
     (strNomTabela = 'USUREP')         Or
     (strNomTabela = 'LOGERR')         Or
     (strNomTabela = 'LCKATC')         Or
     (strNomTabela = 'TAGDIR')         Or
     (strNomTabela = 'LOGSQL')         Or
     (strNomTabela = 'CADBCO')         Or
     (strNomTabela = 'INFSIS')         Or
     (strNomTabela = 'PROINC')         Or
     (strNomTabela = 'PROCOD')         Or
     (strNomTabela = 'DICSIS')         Or
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
     (strNomTabela = 'TRANSACOES')     Or
     (strNomTabela = 'CADCER')         Or
     (strNomTabela = 'DEL_CADCER')     Then
  Begin
    Result := False;
  End;

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

function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  If blnSohIP Then
    strSQL := strSQL + '  LCK_NUM_IP '
  Else
    strSQL := strSQL + '  CONCAT(LCK_NUM_IP, " - ", " Operador: ", LCK_CODOPE, "-", OPE_NOMOPE) AS LCK_NUM_IP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC';
  strSQL := strSQL + '  LEFT JOIN CADOPE ON OPE_CODOPE = LCK_CODOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;

  FreeAndNil(qryGen);
End;

function fGetIdConnectionLock(strNomeTabela: String): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  //qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_CON_ID ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_CON_ID').AsString;

  FreeAndNil(qryGen);
end;

function fGetIPConnectionLock(strNomeTabela: String): String;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Result := '';

  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_NUM_IP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;

  FreeAndNil(qryGen);
end;

function fRetUltimoLock(strNomeTabela: String): TInfLckAtc;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Result.strNum_IP    := '';
  Result.strCon_ID    := '';
  Result.strChaAce    := '';
  Result.strCodOpe    := '';
  Result.intTentat    := 0;
  Result.dtaDtaLck    := 0;
  Result.dtaHraLck    := 0;
  Result.dtaDtaHraLck := 0;

  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  LCKATC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LCK_CHAACE ' +
      IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
    qryGen.Open;
    If Not qryGen.IsEmpty Then
    Begin
      Result.strNum_IP    := qryGen.FieldByName('LCK_NUM_IP').AsString;
      Result.strCon_ID    := qryGen.FieldByName('LCK_CON_ID').AsString;
      Result.strChaAce    := qryGen.FieldByName('LCK_CHAACE').AsString;
      Result.strCodOpe    := qryGen.FieldByName('LCK_CODOPE').AsString;
      Result.intTentat    := qryGen.FieldByName('LCK_TENTAT').AsInteger;
      Result.dtaDtaLck    := qryGen.FieldByName('LCK_DTALCK').AsDateTime;
      Result.dtaHraLck    := qryGen.FieldByName('LCK_HRALCK').AsDateTime;
      Result.dtaDtaHraLck := qryGen.FieldByName('LCK_DTALCK').AsDateTime+qryGen.FieldByName('LCK_HRALCK').AsDateTime;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pZerarTentativasLock(strNomeTabela: String);
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin

  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  //qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'UPDATE LCKATC SET  ';
  strSQL := strSQL + '  LCK_TENTAT = 0 ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.ExecSQL;

  FreeAndNil(qryGen);
end;

procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer=10);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('DELETE FROM LCKATC WHERE LCK_CHAACE = :CHAACE AND LCK_TENTAT >= ' + IntToStr(intTentat));
  qryAux.ParamByName('CHAACE').AsString := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

function fGetTentativasLock(strNomeTabela: String): Integer;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  qryGen := fCriaQuery;
  //qryGen.SQL.Add('SELECT LCK_NUM_IP FROM LCKATC WHERE LCK_CHAACE LIKE :CHAACE');

  strSQL := strSQL + '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  LCK_TENTAT ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  LCKATC ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  LCK_CHAACE ' +
    IfThen(strNomeTabela.Contains('%'), ' LIKE ', ' = ') + ' :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_TENTAT').AsInteger;

  FreeAndNil(qryGen);
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

function fGetTempoDuracaoLock(strNomeTabela: String): Double;
  Var
    qryLock: TUniQuery;
Begin
  qryLock := fCriaQuery(Nil);
  Result := 0;
  With qryLock Do
  Begin
    SQL.Add('SELECT LCK_DTALCK, LCK_HRALCK FROM LCKATC WHERE LCK_CHAACE = :CHAACE');
    ParamByName('CHAACE').AsString := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
    Open;
    If Not IsEmpty Then
      Result := fNow - (FieldByName('LCK_DTALCK').AsDateTime + FieldByName('LCK_HRALCK').AsDateTime);
  End;
  FreeAndNil(qryLock);
End;

procedure pWaitWindow(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);
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
    VS_blnGravaLogTransacao := False;

    If blnHourGlass Then
      Screen.Cursor := crHourGlass;

    strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
    qryLock_Unlock := fCriaQuery(Nil);

    blnComitar := False;
    If (Not frmModulo.GetCurrentConnection.InTransaction) Then
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
            pWaitWindow( Application.MainForm,
                         'O arquivo ' + strNomeTabela + ' está sendo ' +
                         'utilizado no momento.' + #13#10 +
                         'Aguarde Liberação!' );
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

    If blnHourGlass Then
      Screen.Cursor := crDefault;
  Finally
    VS_blnGravaLogTransacao := blnGravaLogTransacao;
  End;

End;

procedure pLog(strValor: String);
  const
    _FILE_LOG : String = '.\log_autcom.txt';
  Var
    stlLog : TStringList;
begin
  Try
    If (VS_HabLogArq = '') And (VS_strCodEmp <> '') Then
      VS_HabLogArq := fCfgSis('HABLOG', varString);
  Except
    VS_HabLogArq := '';
  End;

  If (VS_HabLogArq <> 'S') Then
    Exit;

  stlLog := TStringList.Create;
  Try
    Try
      If FileExists(_FILE_LOG) Then
        stlLog.LoadFromFile(_FILE_LOG);
      stlLog.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()) + ' - ' + strValor);
      stlLog.SaveToFile(_FILE_LOG);
    Finally
      FreeAndNil(stlLog);
    End;
  Except
    //
  End;
end;

procedure ForceKill(AProcess: Integer);
  Var
    strComand : String;
begin
  strComand := 'taskkill /F /PID ' + AProcess.ToString;
  pLog('WinExec ' + strComand);
  WinExec(PAnsiChar(AnsiString(strComand)), SW_HIDE);
end;

function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;
var
  killer: THandle;
begin
  pLog('KillProcess ' + pid.ToString);
  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  Result := TerminateProcess(killer, 0);
  if not Result and AForceKill Then
    ForceKill(pid);
end;

function KillProcess(AImage: String): Boolean;
var
  LImage: string;
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  Result := False;
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  try
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    while Integer(ContinueLoop) <> 0 do
    begin
      LImage := FProcessEntry32.szExeFile;
      try
        if not String(LImage).ToLower.Equals(AImage.ToLower) then
          if not ExtractFileName(LImage).ToLower.Equals(AImage.ToLower) then
            Continue;
        KillProcess(FProcessEntry32.th32ProcessID);
        Result := True;
      finally
        ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
      end;
    end;
  finally
    CloseHandle(FSnapshotHandle);
  end;
end;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; TipoChamado: TTipoChamadaProcesso = tcpMaximizado): boolean;
  Var
    StartInfo: TStartupInfo;
    ProceInfo: TProcessInformation;
begin
  pLog('fCriarProcessoSimples->'+strArquivo);
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;

  If (TipoChamado = tcpMaximizado) Then
    StartInfo.wShowWindow := SW_SHOWMAXIMIZED
  Else if (TipoChamado = tcpNormal) then
    StartInfo.wShowWindow := SW_SHOWNORMAL
  else if (TipoChamado = tcpOculto) then
    StartInfo.wShowWindow := SW_HIDE;

  Result := CreateProcess(Nil,
                          PChar(strArquivo),
                          Nil,
                          Nil,
                          False,
                          CREATE_NEW_CONSOLE Or
                          NORMAL_PRIORITY_CLASS,
                          Nil,
                          PChar(ExtractFilePath(strArquivo)),
                          StartInfo,
                          ProceInfo);

  If (Result) and (TipoChamado <> tcpOculto) Then
    SetForegroundWindow(ProceInfo.hProcess);

  If (Result) And (blnTrava) Then
  Begin
    WaitForSingleObject(ProceInfo.hProcess, INFINITE);

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean;
  Var ProceInfo: TProcessInformation; blnInvisivel: Boolean = False): boolean;
  Var
    StartInfo: TStartupInfo;
begin
  pLog('fCriarProcessoSimples->'+strArquivo);
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;

  If (Not blnInvisivel) Then
  Begin
    If blnMaximizado Then
      StartInfo.wShowWindow := SW_SHOWMAXIMIZED
    Else
      StartInfo.wShowWindow := SW_SHOWNORMAL;
  End;

  Result := CreateProcess(Nil,
                          PChar(strArquivo),
                          Nil,
                          Nil,
                          False,
                          CREATE_NEW_CONSOLE Or
                          NORMAL_PRIORITY_CLASS,
                          Nil,
                          PChar(ExtractFilePath(strArquivo)),
                          StartInfo,
                          ProceInfo);

  If (Result) And (Not blnInvisivel) Then
    SetForegroundWindow(ProceInfo.hProcess);

  If (Result) And (blnTrava) Then
  Begin
    WaitForSingleObject(ProceInfo.hProcess, INFINITE);

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;

function fRetNomVendRep(strCodVen: String): String;
Begin
  Result := fRetNomVendRep(strCodVen, String.Empty, String.Empty);
End;

function fRetCidade(Const strCodigo: String): String;
begin
  Result := fRetNomCidade(strCodigo);
end;

function fRetNomVendRep(strCodVen, strCodEmp: String): String;
begin
  Result := fRetNomVendRep(strCodVen, strCodEmp, String.Empty);
end;

function fRetDadosEmpresa: TDadosEmpresa;
begin
  Result.strNome := fCadEmp('NOMEMP');
  Result.strCpfCnpj := fCadEmp('C_G_C_');
  Result.strEndereco := fCadEmp('ENDERE');
  Result.strNumero := fCadEmp('ENDNUM');
  Result.strBairro := fCadEmp('BAIRRO');
  Result.strCidade := fRetCidade(fCadEmp('CODCID'));
  Result.strCep := fCadEmp('C_E_P_');
  Result.strFone := fCadEmp('FONE01');
  Result.strCelular := fCadEmp('FONE02');
  Result.strEmail := fCadEmp('EMAIL_');
  Result.strComplemento := fCadEmp('ENDCMP');
  Result.strIe := fCadEmp('I_E_S_');
end;

function fRetNomVendRep(strCodVen, strCodEmp, strCodCli: string): String;
var
  arrCamposChave: array of string;
  arrCamposValores: array of variant;
  intTamanhoVetorParametros: integer;
  strNomeTabela: string;

const
  strNOME_CAMPO_RETORNO = 'OPE_NOMOPE';

  procedure pIncrementaVetorParametros;
  begin
    inc(intTamanhoVetorParametros);
    SetLength(arrCamposChave, intTamanhoVetorParametros);
    SetLength(arrCamposValores, intTamanhoVetorParametros);
  end;

  procedure pAtribuiParametro(const strCampoChave, strCampoValor: string);
  begin
    if strCampoValor.IsEmpty then
      exit;
    pIncrementaVetorParametros;
    arrCamposChave[high(arrCamposChave)] := strCampoChave;
    arrCamposValores[high(arrCamposValores)] := strCampoValor;
  end;

  procedure pAtribuiParametroVendedor;
  const
    str_CAMPO_CHAVE = 'OPE_CODOPE';
  begin
    pAtribuiParametro(str_CAMPO_CHAVE, strCodVen);
  end;

  procedure pAtribuiParametroEmpresa;
  const
    str_CAMPO_CHAVE = 'OPE_CODEMP';
  begin
    pAtribuiParametro(str_CAMPO_CHAVE, strCodEmp);
  end;

  procedure pAtribuiParametroCliente;
  const
    str_CAMPO_CHAVE = 'CVE_CODCLI';
  begin
    pAtribuiParametro(str_CAMPO_CHAVE, strCodCli);
    if strCodCli.IsEmpty then
      exit;
    strNomeTabela := 'CADOPE JOIN CLIVEN ON OPE_CODOPE = CVE_CODVEN';
  end;

Begin
  strNomeTabela := 'CADOPE';
  intTamanhoVetorParametros := 0;

  pAtribuiParametroVendedor;
  pAtribuiParametroEmpresa;
  pAtribuiParametroCliente;

  If (Length(arrCamposChave) > 0) Then
  Begin
    Result := fCampoTabela(strNOME_CAMPO_RETORNO,
                           strNomeTabela,
                           arrCamposChave,
                           arrCamposValores,
                           False);
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
{  Try

    qryGenTmp := fCriaQuery;

    If (fEmptyStr(strNomeTabela)) Then
    Begin
      Result := False;
      Exit;
    End;

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'CHECK TABLE ' + strNomeTabela;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      If FieldByName('Msg_text').AsString = 'OK' Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;
}

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

function GravaTabelaDelecao(AFormulario, ATabela: String; ARegistroDeletado: TDataSet): Boolean;
Const
  LArrayCamposIgnorados: Array of String = ['OPEDEL', 'DTADEL', 'HORDEL', 'MOTDEL'];

  Var
    LCamposTabelaDelecao: String;
    LParametrosTabelaDelecao: String;
    LGravarTabelaDelecao: TUniQuery;
    LCampo: TField;

  procedure GeraListaDeCamposTabelaDelecao;
    Var
      LConsulta: TUniQuery;

      LCampo: TField;
  Begin
    Try
      LConsulta := fCriarQuery('SELECT * FROM DEL_' + ATabela + ' WHERE FALSE');
      LConsulta.Open;

      LCamposTabelaDelecao := '';
      LParametrosTabelaDelecao := '';

      For LCampo In LConsulta.Fields Do
      Begin
        LCamposTabelaDelecao := LCamposTabelaDelecao + LCampo.FieldName + ',';
        LParametrosTabelaDelecao := LParametrosTabelaDelecao + ':' + LCampo.FieldName + ',';
      End;

      LCamposTabelaDelecao := LeftStr(LCamposTabelaDelecao, LCamposTabelaDelecao.Length - 1);
      LParametrosTabelaDelecao := LeftStr(LParametrosTabelaDelecao, LParametrosTabelaDelecao.Length - 1);

    Finally
      FreeAndNil(LConsulta);
    End;
  End;

Begin
  Result := False;

  Try
    GeraListaDeCamposTabelaDelecao;
    LGravarTabelaDelecao := fCriaQuery;

    Try

      If Not ARegistroDeletado.IsEmpty Then
      Begin

        LGravarTabelaDelecao.SQL.Text := 'INSERT INTO DEL_' + ATabela + ' (' + LCamposTabelaDelecao + ') ' +
                               ' VALUES (' + LParametrosTabelaDelecao + ') ';

        For LCampo In ARegistroDeletado.Fields Do
        Begin
          If MatchStr(LCampo.FieldName, LArrayCamposIgnorados) Then
            Continue;

          If Not LGravarTabelaDelecao.SQL.Text.Contains(LCampo.FieldName) Then
            Continue;


          LGravarTabelaDelecao.ParamByName(LCampo.FieldName).Value := LCampo.Value;
        End;

        LGravarTabelaDelecao.ParamByName('OPEDEL').AsString     := strLoginUsuarioLogado;
        LGravarTabelaDelecao.ParamByName('DTADEL').AsDateTime   := VS_Date;
        LGravarTabelaDelecao.ParamByName('HORDEL').AsString     := FormatDateTime('hh:mm:ss', fTime());

        If LGravarTabelaDelecao.SQL.Text.Contains('MOTDEL') Then
          LGravarTabelaDelecao.ParamByName('MOTDEL').AsString     := '';

        LGravarTabelaDelecao.ExecSQL;
        Result:= True;
      End;

    Except
      On E: Exception Do
        Raise Exception.Create(E.Message);
    End;
  Finally
    FreeAndNil(LGravarTabelaDelecao);
  End;

End;

{************************************************}
{* VERIFICA INTEGRIDADE DA TABELA CRIA TABELA   *}
{* DE DELETADOS SE NÃO EXISTIR CRIA, SE EXISTIR *}
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
      {* DESCRIÇÃO DA TABELA ORIGINAL *}
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
        {* VERIRFICA SE OS CAMPOS ESTÃO IGUAIS *}
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
          {* SE O CAMPO NÃO EXISTIR *}
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
        {* SE A TABELA NÃO EXISTIR *}
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
        {* VERIFICA SE É DATA PARA FORMATAR CORRETAMENTE *}
        {**********************************************AF*}
        If qryTabOriginal.Fields[intContador].FieldKind = fkData Then
        Begin
          If (qryTabOriginal.Fields[intContador].DataType = ftDate)    Or
            (qryTabOriginal.Fields[intContador].DataType = ftDateTime) Then
          Begin
            {**********************}
            {* VERIFICA SE É NULO *}
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
            {* VERIFICA SE É NULO *}
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
      strSQL := strSQL + ', ' + fCurrentDate + ' ';
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

        Raise Exception.Create('Ocorreu um erro durante a gravação do arquivo de deletado(s).' + #13 + E.Message + #13 +
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

function fConPagComEntrada(strConPag: String): Boolean;
  Var
    strTmpConPag : String;
Begin
  strTmpConPag := fTiraCaracEspeciaisParenteses(strConPag);
  strTmpConPag := ReplaceStr(strTmpConPag, '.', '');
  Result := (Pos('000', fFormataCondPag(strTmpConPag)) > 0);
end;

function fFormataCondPag(strCond: String): String;
  Var
    strValor   : String;
    intContador: Integer;
Begin
  intContador := 3;
  strValor := '(';
  strValor := strValor + LeftStr(strCond,2);
  strValor := strValor + ')';

  While intContador < Length(strCond) Do
  Begin
    If intContador > 3 Then
      strValor := strValor + '.';

    strValor := strValor + Copy(strCond,intContador,3);
    inc(intContador,3)
  End;

  {*******************************************}
  {* CASO RETORNE CONDIÇÃO VAZIA, RETORNA    *}
  {* STRING VAZIA                            *}
  {****************************************AF*}
  If (strValor = '()') Then
    strValor := '';

  Result := strValor;
End;

function fRetDescFpg(Const strCodFpg: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodFpg) Then
    Exit;

  Result := fCampoTabela('FPG_DESCRI', 'CADFPG', ['FPG_CODIGO'], [strCodFpg], False);

End;

function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;
begin
  If fEmptyStr(strCodEmp) Then
   strCodEmp := VS_strCodEmp;

  Result := (fCfgSis('UTIWMS', VarString, strCodEmp) = 'S') And //Utilizar WMS ( Sistema de Gerênciamento de Armazém ) = SIM.
            (fCfgSis('CTLEST', VarString, strCodEmp) = '1') And //Tipo de controle de sub-estoque na mesma loja = POR LOTE.
            (fCfgSis('CADLOC', VarString, strCodEmp) = 'S') And //Utilizar cadastro de localizações físicas? = SIM.
            (fCfgSis('CONFME', VarString, strCodEmp) = '1') And //Realizar Conferência para Entrada de Mercadorias através: = PRE-NOTA.
            (fCfgSis('USACON', VarString, strCodEmp) = 'S') And //Utilizar Conferência para Entrada de Mercadorias? = SIM.
           ((fCfgSis('TIPEXP', varString, strCodEmp) = '3') Or  //Expedição = FATURAMENTO DEPOIS DA EXPEDICAO OU
            (fCfgSis('TIPEXP', varString, strCodEmp) = '4') Or  //            PEDIDO NÃO SERÁ FATURADO
            (fCfgSis('TIPEXP', varString, strCodEmp) = '5'));   //            PRÉ-ROMANEIO

end;

function fUsaRotinaExpedicaoConferenciaRetiraCaixa(): Boolean;
begin
  If Not fCfgSis('LOCRET', varBoolean) Then
    Exit(False);

  If Not fCfgSis('EXRETC', varBoolean) Then
    Exit(False);

  If VS_strTipExp <> '4' Then
    Exit(False);

  Result := True;
end;

function fRetornaClienteFilial(strCodEmp: String; strTipo_FC : String = 'C'): String;
begin
  If fEmptyStr(strCodEmp) Then
  Begin
    Result := '';
    Exit;
  End;

  If strTipo_FC = 'C' Then
    Result := fCampoTabela('EMP_CLIFIL', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False)
  else
    Result := fCampoTabela('EMP_FORFIL', 'CADEMP', ['EMP_CODEMP'], [strCodEmp], False);
end;

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

function fRetornaCon_Id_Trava(strNomeTabela: String): String;
begin
  strNomeTabela := frmModulo.GetCurrentConnection.Database + '.' + strNomeTabela;
  Result := fCampoTabela('LCK_CON_ID', 'LCKATC', ['LCK_CHAACE'], [strNomeTabela], True);
end;

{********************************************}
{* AJUSTA O RELOGIO DO WINDOWS TOMANDO COMO *}
{* BASE A DATA DO SERVIDOR                  *}
{*****************************************MV*}
function fAjustaDataSistema: Boolean;
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

procedure pConectarModulos;
begin
  pCriarFormularios(TfrmModulo, frmModulo);
  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));
end;

procedure pFinalizarModulos;
begin
  pDestroiModulo(frmModuloReplicacao);
  pFecharBanco(frmModulo.GetCurrentConnection);
  pDestroiModulo(frmModulo);
end;

function fExecutandoPeloPortal: Boolean;
begin
  Result := ParamCount >= 6;
end;

function fValidarEmpresa: Boolean;
begin
  Result := True;
  If fRetNomeEmpresa(VS_strCodEmp).IsEmpty Then
  Begin
    MessageDlg('Empresa "' + VS_strCodEmp + '" não existe!', mtError, [mbOK], 0);
    Result := False;
  End;
end;

procedure pDefinirEmpresa;
begin
  If fExecutandoPeloPortal Then
  Begin
    VS_strCodEmp := InputBox(ParamStr(5), 'Informe o código da empresa logada:', '001');
    Exit;
  End;

  If fEmptyStr(ParamStr(1)) Then
    Raise Exception.Create('Não foi informado o código da empresa');

  VS_strCodEmp := ParamStr(1);
end;

procedure pDefinirUsuario;
begin
  strLoginUsuarioLogado := LOG_ADM;
  If VS_strCodEmp.IsEmpty Then
    VS_strCodEmp := fRetEmpresaFisica;
  If (Not fEmptyStr(fRetNomeOperador(fCfgSis('OPEAUT')))) Then
    strLoginUsuarioLogado := fCfgSis('OPEAUT');
end;

procedure pIniciarVariaveis;
begin
  VS_strHabilitarCRM := ((fArqIni(0, 'GERAL', 'CRM', '') = 'S') And (fCfgSis('UTICRM', varBoolean)));
  VS_strCliFil := fRetClientesFilial;
  VS_strUsaTmq := fCfgSis('USATMQ');
  VS_strTipExp := fCfgSis('TIPEXP', varString);
  VS_TSPlus    := (fArqIni(0, 'GERAL', 'TSPLUS', '') = 'S');
  VS_strTabPrc     := fCfgSis('TABPRC');
  If Length(VS_strTabPrc) < 7 Then
    VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));
  VS_blnGravaHistCob := fCfgSis('EMAHIS', varBoolean);
end;

function fRetSomenteNumeros(strTexto: String): String;
  Var
    strTmp: String;
    intIndice: Integer;
begin
  strTmp := '';

  If Not fEmptyStr(strTexto) Then
  Begin
    For intIndice := 1 To Length(strTexto) Do
      If CharInSet(strTexto[intIndice], ['0'..'9']) Then
        strTmp := strTmp + strTexto[intIndice];
  End;

  Result := strTmp;
end;

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

{****************************************}
{* EXECUTA A SQL PASSADA POR PARAMETRO  *}
{*************************************AF*}
function fExecutaSQL(strSQL: String; blnRaise: Boolean = False): Boolean;
	Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    try
      Result := True;

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.ExecSQL;
    finally
      FreeAndNil(qryGen);
    end;
  Except
    On E: Exception do
   	Begin
      If blnRaise Then
        Raise;
     Result := False;
     pMensagensErro(E.Message, '[fExecutaSQL]');
    End;
  End;

End;

function fEhTabelaDeContabilidade(strTabela: string): boolean;
begin
  Result := MatchStr(strTabela, ['LANCON', 'PARCON', 'HISPAD', 'PLANCO']);
end;

procedure WriteCfgBancoAPI(AChave,ACodBco,ACodCfg, AValor: String);
  Var
    FInsert: Boolean;
    FBcoApi : TUniQuery;

  function fGetSQL: String;
  begin
    if  FInsert then
    begin
      Result := ' INSERT INTO BCOAPI      ' +
                ' SET                     ' +
                '   BCO_CHAVE_ = :CHAVE_, ' +
                '   BCO_CODBCO = :CODBCO, ' +
                '   BCO_CODCFG = :CODCFG, ' +
                '   BCO_VALCFG = :VALCFG  ' ;

    end
    else
    begin
      Result := ' UPDATE BCOAPI                ' +
                ' SET                          ' +
                '   BCO_VALCFG = :VALCFG       ' +
                ' WHERE                        ' +
                '   BCO_CHAVE_ = :CHAVE_  AND  ' +
                '   BCO_CODBCO = :CODBCO  AND  ' +
                '   BCO_CODCFG = :CODCFG       ';
    end;
  end;

Begin
  FInsert := fEmptyStr(fCampoTabela('BCO_CHAVE_','BCOAPI',
                                   ['BCO_CHAVE_','BCO_CODBCO','BCO_CODCFG'],
                                   [AChave,ACodBco,ACodCfg]));
  Try
    FBcoApi := fCriaQuery(Nil);
    FBcoApi.Close;
    FBcoApi.Sql.Clear;
    FBcoApi.Sql.Text := fGetSQL;
    Try
      FBcoApi.ParamByName('CHAVE_').AsString := AChave;
      FBcoApi.ParamByName('CODBCO').AsString := ACodBco;
      FBcoApi.ParamByName('CODCFG').AsString := ACodCfg;
      FBcoApi.ParamByName('VALCFG').AsString := AValor;
      FBcoApi.ExecSQL;
    Except
      On E : Exception Do
      Begin
        pMensagensErro(E.Message, '[untFuncoesSimples.WriteCfgBancoAPI]');
      End;
    End;
  Finally
    FreeAndNil(FBcoApi);
  End;

End;

function fGetCfgBancoAPI(AReadWrite: Integer; AChave, ACodCfg, AValor: String; AEmpresaCarteira: String = ''):String;
var
  FChave  : String;
  FCodBco : String;
  FAux    : String;

  function CountPos(const subtext: string; Text: string): Integer;
  begin
    if (Length(subtext) = 0) or (Length(Text) = 0) or (Pos(subtext, Text) = 0)
    then
      Result := 0
    else
      Result := (Length(Text) - Length(StringReplace(Text, subtext, '',
        [rfReplaceAll]))) div Length(subtext);
  end;

begin

  If (CountPos('-',AChave) < 2) Then
  Begin
    FChave :=  AChave + '-' + IIF(fEmptyStr(AEmpresaCarteira),
                                                VS_strCodEmp , // chave sem empresa
                                            AEmpresaCarteira)
  End
  Else
    FChave :=  AChave; // chave completa

  FAux := StringReplace(FChave, 'CONFIG', '', []);
  FCodBco := Copy(FAux, 1, Pos('-', FAux)-1);

  If Length(FCodBco) > 3 then
  begin
    FAux    := FCodBco;
    FCodBco := Copy(FAux, 1, 3);
  End;

  Case AReadWrite of
    0:
    begin
      Result := fCampoTabela('BCO_VALCFG','BCOAPI',
                            ['BCO_CHAVE_','BCO_CODBCO','BCO_CODCFG'],
                            [FChave,FCodBco,ACodCfg]);
    end;
    1:
    begin
      WriteCfgBancoAPI(FChave,FCodBco,ACodCfg, AValor);
    end;
  End;

end;

{***************************************}
{* REMOVE ACENTOS DE UMA STRING        *}
{************************************DV*}
function fRemoveAcento(Str:String): String;
	Const
		ComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ"´';
		SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
	Var
		x : Integer;
Begin
	For x := 1 to Length(Str) do
		If Pos(Str[x],ComAcento)<>0 Then
			Str[x] := SemAcento[Pos(Str[x],ComAcento)];
  Result := Str;
end;

function fGetBancoConfig(ReadWrite: Integer; Chave, CodCFG, Valor: String; strEmpresaCarteira: String = ''; ADuplicataBoleto: untTypesSistema.PTDuplicataCtr = Nil):String;
var
  strNomChave,
  strCodEmp,
  strCodBan,
  strNomBan,
  strCartei,
  strNumPos,
  //strArqOriginal,
  //strProxNumArq,
  strTipLay,
  strAux    : String;
  CFGBanDao : TCFGBanDao;
  CFGBan    : TCfgBan;
begin
  strNomChave :=  Chave+'-' + IIF(fEmptyStr(strEmpresaCarteira),
                                   VS_strCodEmp,
                                   strEmpresaCarteira);

  strCodEmp  := '';
  strCodBan  := '';
  strCartei  := '';
  strNumPos  := '';

  if Pos('PEFIN', strNomChave) > 0 then
  begin
     strNomChave := StringReplace(strNomChave, 'PEFIN', 'CONFIG001D7', []);
     strNumPos   := 'PEFIN';
  end;

  strNomChave := StringReplace(strNomChave, '[', '', []);
  strNomChave := StringReplace(strNomChave, ']', '', []);
  if Pos('_240p', strNomChave) > 0 then
  begin
    strNumPos := '240p';
    strNomChave   := StringReplace(strNomChave, '_240p', '', []);
  end;

  if Pos('_400p', strNomChave) > 0 then
  begin
    strNumPos := '400p';
    strNomChave   := StringReplace(strNomChave, '_400p', '', []);
  end;

  if Pos('CONFIGCTA', strNomChave) > 0 then
  begin
    strNomChave := StringReplace(strNomChave, 'CONFIGCTA', '', []);
    strTipLay   := 'P';
  end;

  if Pos('CONFIGDDA', strNomChave) > 0 then
  begin
    strNomChave    := StringReplace(strNomChave, 'CONFIGDDA', '', []);
    strTipLay   := 'P';
    strNumPos   := 'DDA';
  end;

  if Pos('CONFIG', strNomChave) > 0 then
  begin
    strNomChave := StringReplace(strNomChave, 'CONFIG', '', []);
    strTipLay   := 'R';
  end;

  strCodBan   := Copy(strNomChave, 1, Pos('-', strNomChave)-1);
  strNomChave := StringReplace(strNomChave, strCodBan, '', []);

  if Length(strCodBan) > 3 then
  begin
    strAux    := strCodBan;
    strCodBan := Copy(strAux, 1, 3);
    strAux    := StringReplace(strAux, strCodBan, '', []);
    if strNumPos <> 'PEFIN' then
    begin
      strNumPos := strAux;

      if strNumPos = 'D7' then
         strNumPos := '400_D7';
    end;
  end;

  if strNomChave[1] = '-' then
    strNomChave := StringReplace(strNomChave, '-', '', []);

  if Pos('-', strNomChave) > 0 then
  begin
    strCartei     := Copy(strNomChave, 1, 1);
    strNomChave   := StringReplace(strNomChave, strCartei, '', []);

    if strNomChave[1] = '-' then
       strNomChave := StringReplace(strNomChave, '-', '', []);

    strCodEmp := Copy(strNomChave, 1, 3);
  end
  else
    strCodEmp := Copy(strNomChave, 1, 3);

  //pVerificaImpCNFBCO(IIF(strNumPos = 'PEFIN', strCodBan+'PEFIN', strCodBan));

  Case ReadWrite of
    0:
    begin
      CFGBanDao   := TCFGBanDao.Create(strCodEmp, strCodBan, StrCartei, strNumPos, strTipLay, ADuplicataBoleto);
      CFGBan      := CFGBanDao.fFindByCFG(CodCFG);

      if Assigned(CFGBan) then
        Result :=  Trim(CFGBan.ValCFG)
      else
        Result := '';

      {if Pos('AUTBAN', UpperCase(ExtractFileName(Application.ExeName))) > 0 then
      begin
        if  CodCFG = 'PROXNUM' then
        begin
          strNomChave :=  Chave;
          strArqOriginal := fArqIniAutban(0, 'TESTE-AUTBAN', 'LOCARQ', '');
          if FileExists(strArqOriginal) then
          begin
            if Result = '' then
              Result := '0';

            strProxNumArq := fArqIniAutban(0, strNomChave, 'PROXNUM',  '0');
            if StrToInt(strProxNumArq) > StrToInt(Result) then
            begin
              fMensagem('','O sequencial do arquivo de remessa está maior no arquivo CNFBCO.ini,' + #13 +
                           'por favor entre em contato com a Citel para devidas correções! A aplicação será encerrada!', ['&Ok']);

              application.free;
              exitprocess(0);
            end;
          end;
        end;
      end;}

      CFGBan.Free;
      CFGBanDao.Free;
    end;
    1:
    begin
      CFGBanDao     := TCFGBanDao.Create(strCodEmp, strCodBan, StrCartei, strNumPos, strTipLay);
      CFGBan        := TCFGBan.Create;
      strNomBan     := fRetNomeBancoSelec(StrCodBan);

      if strNomBan = '' then
        raise Exception.Create(#13+'Banco não cadastrado ou não configurado.');

      CFGBan.CodEmp := strCodEmp;
      CFGBan.CodBan := StrCodBan;
      CFGBan.Descri := '';
      CFGBan.Banco_ := strNomBan;
      CFGBan.Cartei := strCartei;
      CFGBan.NumPos := strNumPos;
      CFGBan.UltAlt := fNow;
      CFGBan.CodOpe := strLoginUsuarioLogado;
      CFGBan.CodCFG := CodCFG;
      CFGBan.ValCFG := Valor;
      CFGBan.Chave_ := Chave+'-'+VS_strCodEmp;
      CFGBan.Tiplay := strTipLay;
      CFGBanDao.fInsert(CFGBan);

      CFGBan.Free;
      CFGBanDao.Free;
    end;
  End;

end;

procedure pVerificaImpCNFBCO(strCodBco: String);
var
  qryConf: TUniQuery;
begin
  if strCodBco = '' then
     Exit;

  strCodBco := Copy(strCodBco,1,3);

  qryConf := fCriaQuery();

  with qryConf do
  begin
    Sql.Text  := ' SELECT ' +
                 ' *  '     +
                 ' FROM CFGBAN ' +
                 ' WHERE SIS_CODBAN = :CODBAN AND SIS_CODEMP = :CODEMP ' +
                 iif(Pos('PEFIN', strCodBco) > 0, ' AND SIS_NUMPOS = "PEFIN"', '');

   ParamByName('CODBAN').AsString := iif(Pos('PEFIN', strCodBco) > 0, Copy(strCodBco, 1, 3), strCodBco);
   ParamByName('CODEMP').AsString := VS_strCodEmp;

   Open;

   if isEmpty then
     pImportaCNFBCO(strCodBco, VS_strCodEmp);
  end;

  FreeAndNil(qryConf);

end;

function fRetNomeBancoSelec(Const strCodBco: String): String;
begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

end;

procedure pImportaCNFBCO(strCodBco, strCodEmp: String);
Var
  strPathFile,
  strChave,
  strCodBan,
  strCartei,
  strNumPos,
  strTipLay,
  strNomBan,
  strAux      : String;
  strConfig   : TStringList;
  strSecoes   : TStringList;
  listCFGBan  : TObjectList<TCfgBan>;
  CFGBan      : TCfgBan;
  CFGBanDao   : TCFGBanDao;
  i, j: Integer;
  iniCNFBCO   : TMemIniFile;
  qryRegistros: TUniQuery;
  FGravando : IObserver_;
  FSubject  : ISubject_;
  strParameter: array of String;
begin
  if Length(strCodBco) = 3 then
    strNomBan     := fRetNomeBancoSelec(strCodBco)
  else
    strNomBan     := fRetNomeBancoSelec(Copy(strCodBco,1,3));

  if strNomBan = '' then
  begin
    fMensagem('','Não foi possível importar as configurações do banco selecionado! Banco não cadastrado ou não configurado.', ['O k']);
    System.SysUtils.Abort;
  end;

  strPathFile := ExtractFilePath(Application.ExeName);

  If (Not AnsiEndsText('autban', strPathFile)) And (Not AnsiEndsText('autban\', strPathFile)) Then
    strPathFile := strPathFile + '\autban\';

  strPathFile :=  strPathFile + 'cnfbco.ini';

  if FileExists(strPathFile) then
  begin
    strSecoes   := TStringList.Create;

    iniCNFBCO   := TMemIniFile.Create(strPathFile);

    iniCNFBCO.ReadSections(strSecoes);

    for j := 0 to strSecoes.Count-1 do
    begin
      if (((Pos('CONFIG'+strCodBco, strSecoes[j]) > 0) and (Pos('-'+strCodEmp, strSecoes[j]) > 0)) or
          (Pos('PEFIN', strSecoes[j]) > 0) or
          ((Pos('CONFIGCTA'+strCodBco, strSecoes[j]) > 0) and (Pos('-'+strCodEmp, strSecoes[j]) > 0)) or
          ((Pos('CONFIGDDA'+strCodBco, strSecoes[j]) > 0) and (Pos('-'+strCodEmp, strSecoes[j]) > 0))) then
      begin
        strConfig   := TStringList.Create;

        iniCNFBCO.ReadSectionValues(strSecoes[j], strConfig);

        if strConfig.Count > 0 then
        begin
          strCodBan     := '';
          strCartei     := '';
          strNumPos     := '';
          strChave      := strSecoes[j];

          if Pos('PEFIN', strChave) > 0 then
          begin
             strChave := StringReplace(strChave, 'PEFIN', 'CONFIG001D7', []);
             strNumPos   := 'PEFIN';
          end;

          strChave      := StringReplace(strChave, '[', '', []);
          strChave      := StringReplace(strChave, ']', '', []);

          if Pos('_240p', strChave) > 0 then
          begin
             strNumPos := '240p';
             strChave := StringReplace(strChave, '_240p', '', []);
          end;

          if Pos('_400p', strChave) > 0 then
          begin
             strNumPos := '400p';
             strChave := StringReplace(strChave, '_400p', '', []);
          end;

          if Pos('CONFIGCTA', strChave) > 0 then
          begin
            strChave := StringReplace(strChave, 'CONFIGCTA', '', []);
            strTipLay   := 'P';
          end;

          if Pos('CONFIGDDA', strChave) > 0 then
          begin
            strChave    := StringReplace(strChave, 'CONFIGDDA', '', []);
            strTipLay   := 'P';
            strNumPos   := 'DDA';
          end;

          if Pos('CONFIG', strChave) > 0 then
          begin
            strChave := StringReplace(strChave, 'CONFIG', '', []);
            strTipLay   := 'R';
          end;

          strCodBan := Copy(strChave, 1, Pos('-', strChave)-1);
          strChave := StringReplace(strChave, strCodBan, '', []);

          if Length(strCodBan) > 3 then
          begin
            strAux    := strCodBan;
            strCodBan := Copy(strAux, 1, 3);
            strAux    := StringReplace(strAux, strCodBan, '', []);
            if strNumPos <> 'PEFIN' then
            begin
              strNumPos := strAux;

              if strNumPos = 'D7' then
                 strNumPos := '400_D7';
            end;
          end;

          if strChave[1] = '-' then
            strChave := StringReplace(strChave, '-', '', []);

          if Pos('-', strChave) > 0 then
          begin
            strCartei := Copy(strChave, 1, 1);
            strChave   := StringReplace(strChave, strCartei, '', []);
            if strChave[1] = '-' then
               strChave := StringReplace(strChave, '-', '', []);
          end;

          qryRegistros :=  fCriaQuery;

          with qryRegistros do
          begin
            sql.Text := '';
            SQL.Text := ' SELECT * FROM CFGBAN ' +
                        ' WHERE ' +
                        '   SIS_CODEMP = :CODEMP AND ' +
                        '   SIS_CODBAN = :CODBAN AND ' +
                        '   SIS_CARTEI = :CARTEI AND ' +
                        '   SIS_TIPLAY = :TIPLAY AND ' +
                        '   SIS_NUMPOS = :NUMPOS LIMIT 1';

            ParamByName('CODEMP').AsString := strCodEmp;
            ParamByName('CODBAN').AsString := strCodBan;
            ParamByName('CARTEI').AsString := strCartei;
            ParamByName('NUMPOS').AsString := strNumPos;
            open;

            if RecordCount <> 0 then
            begin
              iniCNFBCO.Free;
              strConfig.Free;
              qryRegistros.Free;

              Exit;
            end;

          end;
          qryRegistros.Free;

          CFGBanDao   := TCFGBanDao.Create(strCodEmp, strCodBan, StrCartei, strNumPos, strTipLay);
          listCFGBan  := TObjectList<TCfgBan>.Create;

          FGravando := TGravandoObs.Create;
          FSubject  := TSubject.Create;

          FSubject.pAddObserver(FGravando);

          //Preparando array de parametros que será responsavel pelas notificações com o objeto observador.
          SetLength(strParameter,4);
          strParameter[0] := 'TcxProgressBar';
          strParameter[1] := IntToStr(strConfig.Count);
          strParameter[2] := 'Aguarde... Lendo Arquivo CNFBCO.INI.';

          //Enviando notificação que vai atualizar os observadores.
          FSubject.pNotify(strParameter);
          try
            for i := 0 to strConfig.Count-1 do
            begin

              //Atualizando os observadores
              strParameter[3] := IntToStr(i);
              FSubject.pNotify(strParameter);

              CFGBan        := TCfgBan.Create;
              CFGBan.CodEmp := strCodEmp;
              CFGBan.CodBan := StrCodBan;
              CFGBan.Descri := '';
              CFGBan.Banco_ := fRetNomeBancoSelec(StrCodBan);
              CFGBan.Cartei := strCartei;
              CFGBan.NumPos := strNumPos;
              CFGBan.UltAlt := fNow;
              CFGBan.CodOpe := strLoginUsuarioLogado;
              CFGBan.CodCFG := Copy(strConfig.Strings[i], 1, Pos('=', strConfig.Strings[i])-1);
              CFGBan.ValCFG := Copy(strConfig.Strings[i], Pos('=', strConfig.Strings[i])+1, Length(strConfig.Strings[i]));
              CFGBan.Chave_ := strSecoes[j];
              CFGBan.TipLay := strTipLay;
              listCFGBan.Add(CFGBan);
            end;
          except
            on e: Exception do
            begin
              //Enviando a notificação para desalocar os observadores e destruir os objetos criados na memória
              strParameter[0] := 'Fechar';
              FSubject.pNotify(strParameter);
              Finalize(strParameter);

              CFGBanDao.Free;
              listCFGBan.Free;
              iniCNFBCO.Free;
              strConfig.Free;
              fMensagem('', 'Ocorreu um erro ao importar o arquivo de configurações CNFBCO.ini' + #13 + 'Erro: ' + e.Message, ['&Ok']);
              Exit;
            end;
          end;

          //Enviando a notificação para desalocar os observadores e destruir os objetos criados na memória
          strParameter[0] := 'Fechar';
          FSubject.pNotify(strParameter);
          Finalize(strParameter);

          CFGBanDao.fInsertAll(listCFGBan);

          CFGBanDao.Free;
          listCFGBan.Free;

          strConfig.Free;

          FSubject.pDeleteObserver(FGravando);
          FGravando := Nil;
          FSubject  := Nil;

        end
        else
          strConfig.Free;
      end;

    end;
    iniCNFBCO.Free;
    strSecoes.Free;
  end;


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

function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;
  Var
    strForAux: TConsultas;
Begin
  Result := '';
  If Length(arrValores) > 0 Then
  Begin
    For strForAux In arrValores Do
      Result := Result + '"' + strForAux.strCodigo + '",';
    Result := LeftStr(Result, Length(Result) - 1);
  End
  Else
    Result := '"' + strCodigo + '"';
End;

procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport);
begin
  Raise Exception.Create('TCfgRel class not found');
//  TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp, AReport);
end;

procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport);
begin
  Raise Exception.Create('TCfgRel class not found');
//  TCfgRel.pPrintReport(strNomPro, strDesPro, strNomImp, AReport);
end;

procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);
begin
  Raise Exception.Create('TCfgRel class not found');
//  TCfgRel.pPreviewReport(strNomPro, strDesPro, AReport);
end;

procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TRLReport; ASetup: TRLPreviewSetup);
begin
  Raise Exception.Create('TCfgRel class not found');
//  TCfgRel.pPreviewReport(strNomPro, strDesPro, AReport, ASetup);
end;

procedure pRetFilasImpressao(Var arrFilas: TarrFilas);
  Var
    intContador: Integer;
    strNomRed: String;
begin
  If fCfgSis('SPOIMP', VarBoolean) Then
  Begin
    SetLength(arrFilas, 0);
    Exit;
  End;

  strNomRed := fRetNomeRede;

  SetLength(arrFilas, Printer.Printers.Count);
  For intContador := 0 To Printer.Printers.Count -1 Do
  Begin
    arrFilas[intContador].strNomeFila := Printer.Printers[intContador];

    If (Pos(' on ', arrFilas[intContador].strNomeFila) > 0) Then
    arrFilas[intContador].strNomeFila := Trim(LeftStr(arrFilas[intContador].strNomeFila, Pos(' on ', arrFilas[intContador].strNomeFila)));

    If (Copy(arrFilas[intContador].strNomeFila, 1, 2) <> '\\') Then
      arrFilas[intContador].strNomeFila := '\\' + strNomRed + '\' + arrFilas[intContador].strNomeFila;

    arrFilas[intContador].blnMostrar  := True;
  End;

end;

function fRetNomeRede: String;
  Var
    strNome: PAnsiChar;
    strComp: String;
    intContador: Integer;
    wsa: TWSAData;
begin
  strNome := PAnsiChar(AnsiString(String(fstrEspaco('', 100))));

  //SetLength(strNome, 100);

  WSAStartup(2, wsa);
  gethostname(strNome, 100);
  intContador := 0;
  while (strNome[intContador] <> ' ') And
        (strNome[intContador] <> #0)  Do
  Begin
    strComp := strComp + String(strNome[intContador]);
    Inc(intContador);
  end;
  Result := strComp;
  WSACleanup;
end;

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

function fFormataCEP(strCEP: String): String;
begin
	Result := '';

  If Not fEmptyStr(strCEP) Then
  Begin
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),0,5) + '-';
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),6,3);
  End;

end;

function fRetiraZerosEsquerda(strDado: String): String;
Begin
  While (Length(strDado) > 0) And (strDado[1] = '0') Do
    Delete(strDado, 1, 1);

  Result := strDado;
End;

function fEnderecoEmailValido(strEmail: String): Boolean;
  Const
    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];

    quoted_string_chars = [#0..#255] - ['"', #13, '\'];

    letters = ['A'..'Z', 'a'..'z'];
    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

  Type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
              STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
              STATE_SUBDOMAIN, STATE_HYPHEN);

  Var
    State: States;
    i, n, subdomains: integer;
    c: char;

begin
  State := STATE_BEGIN;

  n := Length(strEmail);
  i := 1;
  subdomains := 1;

  while (i <= n) do begin
    c := strEmail[i];

    case State of
    STATE_BEGIN:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_ATOM:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else if not (CharInSet(c, atom_chars)) then
        break;

    STATE_QTEXT:
      if c = '\' then
        State := STATE_QCHAR
      else if c = '"' then
        State := STATE_QUOTE
      else if not (CharInSet(c, quoted_string_chars)) then
        break;

    STATE_QCHAR:
      State := STATE_QTEXT;

    STATE_QUOTE:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else
        break;

    STATE_LOCAL_PERIOD:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_EXPECTING_SUBDOMAIN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else
        break;

    STATE_SUBDOMAIN:
      if c = '.' then begin
        inc(subdomains);
        State := STATE_EXPECTING_SUBDOMAIN
      end else if c = '-' then
        State := STATE_HYPHEN
      else if not (CharInSet(c, letters_digits)) then
        break;

    STATE_HYPHEN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else if c <> '-' then
        break;
    end;

    inc(i);
  end;

  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function IfEmptyStr(strValor, strDefault: String): String;
begin
  Result := strValor;
  If fEmptyStr(Result) Then
    Result := strDefault;
end;

function fEmailValido(strEmail: String; blnExibeAlerta: Boolean = True;
              strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
              blnEmailNfe: Boolean = True): Boolean;
  var
    i: Integer;
    stlEmails: TStringList;
begin
  Result := True;

  Try
    stlEmails := TStringList.Create();

    If (Pos(';', strEmail) > 0) Or ((Pos(',', strEmail) > 0)) Then Begin
      If (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ';') Or
        (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ',') Then
        stlEmails.CommaText := AnsiReplaceStr(Copy(Trim(strEmail), 1, Length(Trim(strEmail)) - 1), ';', ',')
      Else
        stlEmails.CommaText := AnsiReplaceStr(Trim(strEmail), ';', ',');
    End Else Begin
      stlEmails.Add(Trim(strEmail));
    End;

    For i := 0 To stlEmails.Count - 1 Do Begin
      If fEmptyStr(stlEmails[i]) And (Not blnPermiteEmBranco) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+'!', ['&OK']);
        End;

        Result := False;
      End Else If (Not fEmptyStr(stlEmails[i])) And (Not fEnderecoEmailValido(stlEmails[i])) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe corretamente!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+' corretamente!', ['&OK']);
        End;

        Result := False;
      End;
    End;
  Finally
    FreeAndNil(stlEmails);
  End;
end;

procedure pCriarArrayAnexosEDestinatarios(strArquivo, strEmailDestinatario: String;
  Var arrDestinatarios, arrArquivos: TStringArray);
  Var
    i: Integer;
    strRecipients, strArquivos: String;
    stlRecipients, stlArquivos: TStringList;
    strTemp: String;
begin
  Try
    If (Not fEmptyStr(strEmailDestinatario)) Then Begin
      strRecipients := StringReplace(Trim(strEmailDestinatario), ';', ',', [rfReplaceAll]);

      If (Copy(strRecipients, Length(strRecipients), Length(strRecipients) - 1) = ',') Then
        strRecipients := Copy(strRecipients, 1, Length(strRecipients) - 1);

      stlRecipients := TStringList.Create();
      stlRecipients.CommaText := strRecipients;

      SetLength(arrDestinatarios, 0);

      For i := 0 To stlRecipients.Count - 1 Do Begin
        If (Not fEmptyStr(stlRecipients[i])) And (Pos('@', stlRecipients[i]) > 0) Then Begin
          SetLength(arrDestinatarios, Length(arrDestinatarios) + 1);
          arrDestinatarios[Length(arrDestinatarios) - 1] := stlRecipients[i];
        End;
      End;
    End Else Begin
      If (Assigned(arrDestinatarios)) Then
        Setlength(arrDestinatarios, 0);
    End;

    If (Not fEmptyStr(strArquivo)) Then Begin
      strArquivos := StringReplace(Trim(strArquivo), ';', ',', [rfReplaceAll]);

      If (Copy(strArquivos, Length(strArquivos), Length(strArquivos) - 1) = ',') Then
        strArquivos := Copy(strArquivos, 1, Length(strArquivos) - 1);

      strTemp     := FormatDateTime('yyyymmddhhmmsszzz', fNow());
      strArquivos := StringReplace(Trim(strArquivos), ' ', strTemp, [rfReplaceAll]);

      stlArquivos := TStringList.Create();
      stlArquivos.CommaText := strArquivos;

      SetLength(arrArquivos, 0);

      For i := 0 To stlArquivos.Count - 1 Do Begin
        If (Not fEmptyStr(stlArquivos[i])) Then Begin
          SetLength(arrArquivos, Length(arrArquivos) + 1);
          arrArquivos[Length(arrArquivos) - 1] := StringReplace(Trim(stlArquivos[i]), strTemp, ' ', [rfReplaceAll]);
        End;
      End;
    End;
  Finally
    FreeAndNil(stlArquivos);
    FreeAndNil(stlRecipients);
  End;
end;

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

function fRetPrimeiraPalavra(strTexto: String): String;
Var
  intContador: Integer;
  strTexTmp  : String;
Begin
  Result    := '';
  strTexTmp := Trim(strTexto);

  For intContador := 1 To Length(strTexTmp) Do
  Begin
    If (fEmptyStr(strTexTmp[intContador])) Then
      Break
    Else
      Result := Result + strTexTmp[intContador];
  End;

End;

function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
Var
  stlListEmp: TStringList;
  intCont_: Integer;
Begin
  stlListEmp := TStringList.Create;

  stlListEmp.Delimiter := '_';
  stlListEmp.DelimitedText := strValores;
  SetLength(Result, stlListEmp.Count);

  For intCont_ := 0 To stlListEmp.Count -1 Do
  Begin
    If  stlListEmp.Strings[intCont_] <> '' Then
      Result[intCont_] := stlListEmp.Strings[intCont_];
  End;

  FreeAndNil(stlListEmp);
End;

function IfNull(varValor, varDefault: Variant): Variant;
begin
	Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
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
    strSQL := strSQL + '  CTR_DTACAD = CTR_DTAVEN AND    ';  // VERIFICA SE É PARCELA É A VISTA
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
    strSQL := strSQL + '  GER_DTLBRC IS NULL       ';  // ATUALIZA SOMENTE SE O DOCUMENTO NÃO TEVE LIBERAÇÃO

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

procedure pGravaLogBan(strCodBco, strNomBco, strNumAtu, strNu7Atu: String; blnInclusao, blnExcluir, blnImpressao: Boolean; strNumImp: String);
  Var
    qryLogBan: TUniQuery;
    qryAux   : TUniQuery;
    strSQL   : String;
    strNN_Ant: String;
    strNN7Ant: String;
begin
  Try
    qryLogBan := fCriaQuery;
    qryAux    := fCriaQuery;

    If Not blnInclusao Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT  ';
      strSQL := strSQL + '   BCO_PRONUM, ';
      strSQL := strSQL + '   BCO_PRONU7  ';
      strSQL := strSQL + ' FROM          ';
      strSQL := strSQL + '   CADBCO      ';
      strSQL := strSQL + ' WHERE         ';
      strSQL := strSQL + '   BCO_CODBCO = ' + QuotedStr(strCodBco);

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        strNN_Ant := FieldByName('BCO_PRONUM').AsString;
        strNN7Ant := FieldByName('BCO_PRONU7').AsString;
      End;
    End
    Else
    Begin
      strNN_Ant := '';
      strNN7Ant := '';
    End;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   LOG_DTALOG, ';
    strSQL := strSQL + '   LOG_HORLOG, ';
    strSQL := strSQL + '   LOG_CODOPE, ';
    strSQL := strSQL + '   LOG_CODBCO, ';
    strSQL := strSQL + '   LOG_NN_ANT, ';
    strSQL := strSQL + '   LOG_NN7ANT, ';
    strSQL := strSQL + '   LOG_NN_ATU, ';
    strSQL := strSQL + '   LOG_NN7ATU, ';
    strSQL := strSQL + '   LOG_DESCRI, ';
    strSQL := strSQL + '   LOG_EMPIMP, ';
    strSQL := strSQL + '   LOG_NN_IMP  ';
    strSQL := strSQL + ' FROM          ';
    strSQL := strSQL + '  LOGBAN       ';
    strSQL := strSQL + ' WHERE FALSE   ';

    With qryLogBan Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      Insert;
      FieldByName('AUTOINCREM').AsString   := fRetAutoincrem('LOGBAN', VS_strCodEmp);
      FieldByName('LOG_DTALOG').AsDateTime := VS_Date;
      FieldByName('LOG_HORLOG').AsDateTime := fTime();
      FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
      FieldByName('LOG_CODBCO').AsString   := strCodBco;
      FieldByName('LOG_NN_ANT').AsString   := strNN_Ant;
      FieldByName('LOG_NN7ANT').AsString   := strNN7Ant;
      FieldByName('LOG_NN_ATU').AsString   := strNumAtu;
      FieldByName('LOG_NN7ATU').AsString   := strNu7Atu;
      FieldByName('LOG_EMPIMP').AsString   := VS_strCodEmp;
      FieldByName('LOG_NN_IMP').AsString   := strNumImp;


      If Not blnExcluir Then
      Begin
        If blnInclusao Then
          FieldByName('LOG_DESCRI').AsString := 'INSERÇÃO BANCO:' + strCodBco + '-' + strNomBco
        Else
        Begin
          If blnImpressao Then
            FieldByName('LOG_DESCRI').AsString := 'IMPRESSÃO BOLETO:' + strCodBco + '-' + strNomBco
          Else
            FieldByName('LOG_DESCRI').AsString := 'ALTERAÇÃO BANCO:' + strCodBco + '-' + strNomBco;
        End;
      End
      Else
        FieldByName('LOG_DESCRI').AsString := 'EXCLUSÃO BANCO:' + strCodBco + '-' + strNomBco;

      Post;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryLogBan);
  FreeAndNil(qryAux);
end;

function fRetNomBanco(Const strCodBco: String): String;
Begin

  Result := '';

  If fEmptyStr(strCodBco) Then
    Exit;

  Result := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [strCodBco], False);

end;

function fExt3(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILHÃO '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILHÕES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILHÕES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If (strIdioma = 'E') Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLON '
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLONES '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      7 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MILLION '
          Else
            Result := fExt2(Copy(strS,2,3), strIdioma);
      8 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      9 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MILLIONS '
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

function fExt1(strS : String; strIdioma: String = 'P') : String;
Begin

  Case Length(strS) Of
    1 : Result := fExtUnidade(strS[1], strIdioma);
    2 : Result := fExtDezena(strS[1] + strS[2], strIdioma);
    3 : If strS[2] + strS[3] = '00'  Then
        Begin
          If strIdioma = 'P' Then
      			Result := String(CentenaPor[StrToInt(strS[1])]);
          If strIdioma = 'E' Then
      			Result := String(CentenaEsp[StrToInt(strS[1])]);
          If strIdioma = 'I' Then
      			Result := String(CentenaIng[StrToInt(strS[1])]);
        End
  			Else
        Begin
          If strIdioma = 'P' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CENTO E ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaPor[StrToInt(strS[1])]) + 'E ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'E' Then
          Begin
            If strS[1] = '1' Then
              Result := 'CIENTO Y ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaEsp[StrToInt(strS[1])]) + 'Y ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
          If strIdioma = 'I' Then
          Begin
            If strS[1] = '1' Then
              Result := 'ONE HUNDRED AND ' + fExtDezena(strS[2] + strS[3], strIdioma)
            Else
              Result := String(CentenaIng[StrToInt(strS[1])]) + 'AND ' + fExtDezena(strS[2] + strS[3], strIdioma);
          End;
        End;
  End;

End;

function fExt2(strS : string; strIdioma: String = 'P') : string;
begin

  If (strIdioma = 'P') Or ((strIdioma = 'E')) Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'MIL ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'MIL ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'MIL ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

  If strIdioma = 'I' Then
  Begin
    Case Length(strS) of
      4 : If Copy(strS,1,1) <> '0' Then
            Result := fExt1(Copy(strS,1,1), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,2,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,2,3), strIdioma);
      5 : If Copy(strS,1,2) <> '00' Then
            Result := fExt1(Copy(strS,1,2), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,3,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,3,3), strIdioma);
      6 : If Copy(strS,1,3) <> '000' Then
            Result := fExt1(Copy(strS,1,3), strIdioma) + 'THOUSAND ' + fExt1(Copy(strS,4,3), strIdioma)
          Else
            Result := fExt1(Copy(strS,4,3), strIdioma);
    End;
  End;

end;

function fExtUnidade(strS : String; strIdioma: String = 'P') : String;
begin
  If strIdioma = 'P' Then
  	Result := String(UnidadePor[StrToInt(strS[1])]);
  If strIdioma = 'E' Then
  	Result := String(UnidadeEsp[StrToInt(strS[1])]);
  If strIdioma = 'I' Then
  	Result := String(UnidadeIng[StrToInt(strS[1])]);
end;

function fExtDezena(strS : String; strIdioma: String = 'P') : String;
begin
  If strS[1] <> '1' Then
  	If strS[2] <> '0' Then
			If strS[1] <> '0' Then
      Begin
        If strIdioma = 'P' Then
       		Result := String(DezenaPor[StrToInt(strS[1])] + 'E ' + UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
       		Result := String(DezenaEsp[StrToInt(strS[1])] + 'Y ' + UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
       		Result := String(DezenaIng[StrToInt(strS[1])] + 'AND ' + UnidadeIng[StrToInt(strS[2])]);
      End
     	Else
      Begin
        If strIdioma = 'P' Then
        	Result := String(UnidadePor[StrToInt(strS[2])]);
        If strIdioma = 'E' Then
        	Result := String(UnidadeEsp[StrToInt(strS[2])]);
        If strIdioma = 'I' Then
        	Result := String(UnidadeIng[StrToInt(strS[2])]);
      End
  	Else
    Begin
      If strIdioma = 'P' Then
        Result := String(DezenaPor[StrToInt(strS[1])]);
      If strIdioma = 'E' Then
        Result := String(DezenaEsp[StrToInt(strS[1])]);
      If strIdioma = 'I' Then
        Result := String(DezenaIng[StrToInt(strS[1])]);
    End
  Else
  {Dezena = 1}
  Begin
    If strIdioma = 'P' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEZ ';
        '1' : Result := 'ONZE ';
        '2' : Result := 'DOZE ';
        '3' : Result := 'TREZE ';
        '4' : Result := 'QUATORZE ';
        '5' : Result := 'QUINZE ';
        '6' : Result := 'DEZESSEIS ';
        '7' : Result := 'DEZESSETE ';
        '8' : Result := 'DEZOITO ';
        '9' : Result := 'DEZENOVE ';
      End;
    End;
    If strIdioma = 'E' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'DEIZ ';
        '1' : Result := 'ONCE ';
        '2' : Result := 'DOCE ';
        '3' : Result := 'TRECE ';
        '4' : Result := 'CATORCE ';
        '5' : Result := 'QUINCE ';
        '6' : Result := 'DIECISEIS ';
        '7' : Result := 'DIECISIETE ';
        '8' : Result := 'DIECIOCHO ';
        '9' : Result := 'DIECINUEVE ';
      End;
    End;
    If strIdioma = 'I' Then
    Begin
      Case strS[2] Of
        '0' : Result := 'TEN ';
        '1' : Result := 'ELEVEN ';
        '2' : Result := 'TWELVE ';
        '3' : Result := 'THIRTEEN ';
        '4' : Result := 'FOURTEEN ';
        '5' : Result := 'FIFTEEN ';
        '6' : Result := 'SIXTEEN ';
        '7' : Result := 'SEVENTEEN ';
        '8' : Result := 'EIGHTEEN ';
        '9' : Result := 'NINETEEN ';
      End;
    End;
  End;
end;

function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + strCampoRetorno + ' AS RESULTADO ' ;
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + strNomeTabela;
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + strCampoPesquisa + ' = :CODIGO ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODIGO').AsFloat := fltCodigo;
      Open;
      Result := FieldByName('RESULTADO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fRetCidEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_CODCID ';
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
      Result := FieldByName('EMP_CODCID').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function FMes_Espano(dtaData: TDateTime; intTam: Integer): String;
Var
  intMes : Integer;
Const
  arrMes : Array[0..12] Of String[10] = ('','ENERO',
                                            'FEBRERO',
                                            'MARZO',
                                            'ABRIL',
                                            'MAYO',
                                            'JUNIO',
                                            'JULIO',
                                            'AGOSTO',
                                            'SEPTIEMBRE',
                                            'OCTUBRE',
                                            'NOVIEMBRE',
                                            'DICIEMBRE');
Begin
  intMes := MonthOf(dtaData);

  Result := String(arrMes[intMes]);

  If intTam = 1 Then
    Result := copy(Result,1,3);
End;

function fGetPath(strPath: String): String;
begin
  Result := AnsiLowerCase(strPath);
  //Result := AnsiReplaceText(Result, '\', '/');
  Result := AnsiReplaceText(Result, '/', '\');
  If (RightStr(Result, 1) <> '\') Then
    Result := Result + '\';
  Result := Trim(Result);
end;

function fTiraCaracNota(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '#';

  strCaracNorm := 'aeiouaeiouaeiouaocAEIOUAEIOUAEIOUAOC';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõçÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÇ';

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

procedure pRetNumeroPedidoVenda(strNumDoc, strEspDoc, strCodEmp, strCodCli: String; Var strNumPed, strEmpPed: String);
Var
  strSQL: String;
  qrySQL: TUniQuery;
Begin

  strNumPed := '';
  strEmpPed := '';

  Try

    qrySQL := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT        ';
    strSQL := strSQL + '  DET_NUM_PD, ';
    strSQL := strSQL + '  DET_ESP_PD, ';
    strSQL := strSQL + '  DET_EMP_PD  ';
    strSQL := strSQL + 'FROM          ';
    strSQL := strSQL + '  MOVDET      ';
    strSQL := strSQL + 'WHERE         ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND  ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '  DET_ESP_PD = "PD"         ';
    strSQL := strSQL + 'GROUP BY                    ';
    strSQL := strSQL + '  DET_NUMDOC,  ';
    strSQL := strSQL + '  DET_ESPDOC,  ';
    strSQL := strSQL + '  DET_CODEMP,  ';
    strSQL := strSQL + '  DET_CODCLI  ';

    With qrySQL Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').asString := strNumDoc;
      ParamByName('ESPDOC').asString := strEspDoc;
      ParamByName('CODEMP').asString := strCodEmp;
      ParamByName('CODCLI').asString := strCodCli;
      Open;

      If (Not IsEmpty) Then
      Begin
        strNumPed := FieldByName('DET_NUM_PD').AsString;
        strEmpPed := FieldByName('DET_EMP_PD').AsString;
      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + 'SELECT        ';
        strSQL := strSQL + '  DET_NUM_PD, ';
        strSQL := strSQL + '  DET_ESP_PD, ';
        strSQL := strSQL + '  DET_EMP_PD  ';
        strSQL := strSQL + 'FROM          ';
        strSQL := strSQL + '  NOTGER      ';
        strSQL := strSQL + '  INNER JOIN MOVDET ON DET_NUMFAT = GER_NUMDOC AND ';
        strSQL := strSQL + '                       DET_TIPFAT = GER_ESPDOC AND ';
        strSQL := strSQL + '                       DET_EMPFAT = GER_CODEMP AND ';
        strSQL := strSQL + '                       DET_CLIFAT = GER_CODCLI AND ';
        strSQL := strSQL + '                       DET_ESP_PD = "PD"           ';
        strSQL := strSQL + 'WHERE         ';
        strSQL := strSQL + '  GER_NUMDOC = :NUMDOC AND  ';
        strSQL := strSQL + '  GER_ESPDOC = :ESPDOC AND  ';
        strSQL := strSQL + '  GER_CODEMP = :CODEMP AND  ';
        strSQL := strSQL + '  GER_CODCLI = :CODCLI      ';
        strSQL := strSQL + 'GROUP BY                    ';
        strSQL := strSQL + '  GER_NUMDOC,  ';
        strSQL := strSQL + '  GER_ESPDOC,  ';
        strSQL := strSQL + '  GER_CODEMP,  ';
        strSQL := strSQL + '  GER_CODCLI   ';

        With qrySQL Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('NUMDOC').asString := strNumDoc;
          ParamByName('ESPDOC').asString := strEspDoc;
          ParamByName('CODEMP').asString := strCodEmp;
          ParamByName('CODCLI').asString := strCodCli;
          Open;

          If (Not IsEmpty) Then
          Begin
            strNumPed := FieldByName('DET_NUM_PD').AsString;
            strEmpPed := FieldByName('DET_EMP_PD').AsString;
          End;
        End;
      End;
    End;

  Finally
    FreeAndNil(qrySQL);
  End;

End;

procedure pBackupCnfBco;
  Var
    qryCnfBco: TUniQuery;
    strCnfBco: String;
begin
  strCnfBco := fRetCnfBco;
  If fEmptyStr(strCnfBco) Then
    Exit;

  qryCnfBco := fCriaQuery;
  With qryCnfBco Do
  Begin
    SQL.Text := 'REPLACE INTO CNFBKP (CNF_CODCNF, CNF_CNFBCO) VALUES (1, :CNFBCO)';
    ParamByName('CNFBCO').AsString := strCnfBco;
    ExecSQL;
  End;
  FreeAndNil(qryCnfBco);
end;

procedure pDesmembraCarteira(const strCartei: String; var strCodBco, strTipLay,
  strNumPos, strEspeci, strCodEmp: String; var intCartei: Integer);
  Var
    LCarteiraComEmpresa : Boolean;

    function Carteira : String;
    Begin
      {*************************************************************
      *Tratamento para evitar que, exemplo, empresas de codigo 033 *
      *entre no if do santander quando são chamadas de outro banco *
      ********************************************234958**********MT}
      If LCarteiraComEmpresa Then
        Result :=  Copy(strCartei, 1,(Length(strCartei) - 3))
      Else
        Result := strCartei;
    End;
Begin
  strCodBco := '';
  strTipLay := '';
  strNumPos := '';
  strEspeci := '';
  strCodEmp := '';
  intCartei := 0;

  LCarteiraComEmpresa := Not fEmptyStr(fRetNomeEmpresa(RightStr(strCartei,3)));

  If Pos('341', Carteira) > 0 Then
  Begin
    strCodBco := '341';
    strNumPos := '400';
    strEspeci := '';

    If Pos('CTA', strCartei) > 0 Then
    Begin
      strTipLay := 'P';
      strCodEmp := Copy(strCartei, 16, 3);
      intCartei := StrToInt(Copy(strCartei, 14, 1));
    End
    Else
    Begin
      strTipLay := 'R';
      strCodEmp := Copy(strCartei, 13, 3);
      intCartei := StrToInt(Copy(strCartei, 11, 1));
    End;
  End;

  If Pos('033', Carteira) > 0 Then
  Begin
    strCodBco := '033';
    strNumPos := '400';
    strEspeci := '';

    If Pos('CTA', strCartei) > 0 Then
    Begin
      strNumPos := '240';
      strTipLay := 'P';
      strCodEmp := Copy(strCartei, 16, 3);
      intCartei := StrToInt(Copy(strCartei, 14, 1));
    End
    Else
    Begin
      strTipLay := 'R';
      strCodEmp := Copy(strCartei, 14, 3);
      intCartei := StrToInt(Copy(strCartei, 12, 1));
    End;
  End;

  If Pos('748API', Carteira) > 0 Then
  Begin
    strCodBco := '748';
    strNumPos := 'API';
    strEspeci := '';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 16, 3);
    intCartei := StrToInt(Copy(strCartei, 14, 1));
  End
  Else
  If Pos('748', Carteira) > 0 Then
  Begin
    strCodBco := '748';
    strNumPos := '400';
    strEspeci := '';

    If Pos('CTA', strCartei) > 0 Then
    Begin
      strTipLay := 'P';
      strCodEmp := Copy(strCartei, 16, 3);
      intCartei := StrToInt(Copy(strCartei, 14, 1));
    End
    Else
    Begin
      strTipLay := 'R';
      strCodEmp := Copy(strCartei, 13, 3);
      intCartei := StrToInt(Copy(strCartei, 11, 1));
    End;
  End;

  If Pos('422API', Carteira) > 0 Then
  Begin
    strCodBco := '422';
    strNumPos := 'API';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 16, 3);
    intCartei := StrToInt(Copy(strCartei, 14, 1));
  End;

  If Pos('001D7', Carteira) > 0 Then
  Begin
    strCodBco := '001';
    strNumPos := '400';
    strEspeci := 'D7';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 15, 3);
    intCartei := StrToInt(Copy(strCartei, 13, 1));
  End;

  If Pos('001API', Carteira) > 0 Then
  Begin
    strCodBco := '001';
    strNumPos := 'API';
    strEspeci := 'D7';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 16, 3);
    intCartei := StrToInt(Copy(strCartei, 14, 1));
  End;

  If Pos('756_240p', Carteira) > 0 Then
  Begin
    strCodBco := '756';
    strNumPos := '240';
    strEspeci := '';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 18, 3);
    intCartei := StrToInt(Copy(strCartei, 16, 1));
  End;

  If Pos('237', Carteira) > 0 Then
  Begin
    strCodBco := '237';
    strNumPos := '400';
    strEspeci := '';

    strTipLay := 'R';
    strCodEmp := Copy(strCartei, 13, 3);
    intCartei := StrToInt(Copy(strCartei, 11, 1));
  End;
End;

function fRetCnfBco:String;
	Var
    strPathOpcoes: String;
		stlAux    : TStringList;
    intCont,
    intTentativas  : Integer;
    blnAbriuArquivo: Boolean;
begin
  intTentativas   := 0;
  blnAbriuArquivo := False;
  While (not blnAbriuArquivo) And (intTentativas <= 5) Do
  Begin
    Try
      Inc(intTentativas);
  strPathOpcoes := ExtractFilePath(Application.ExeName);
  If (Not AnsiEndsText('autban', strPathOpcoes)) And (Not AnsiEndsText('autban\', strPathOpcoes)) Then
    strPathOpcoes := strPathOpcoes + '\autban\';

  If FileExists(strPathOpcoes + 'cnfbkpaut.ini') Then
    DeleteFile(PWideChar(strPathOpcoes + 'cnfbkpaut.ini'));

  CopyFile(PWideChar(strPathOpcoes + 'cnfbco.ini'), PWideChar(strPathOpcoes + 'cnfbkpaut.ini'), False);
  stlAux := TStringList.Create;
  stlAux.LoadFromFile(strPathOpcoes + 'cnfbkpaut.ini');

  Try
    For intCont := 0 To stlAux.Count - 1 Do
      Result := Result + stlAux[intCont] + #13;
  Finally
	  FreeAndNil(stlAux);
        blnAbriuArquivo := True;
  End;
    Except
      Sleep(1000);
      Result := '';
      If Assigned(stlAux) Then
        FreeAndNil(stlAux);
    End;
  End;
end;

function fCriaClientDataset(ASQL: String; AOwner: TComponent = Nil): TUniClientDataSet;
Var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery(AOwner);
  Try
    LQuery.SQL.Text := ASQL;
    LQuery.Open;
    Result := fCriaClientDatSet(LQuery);
  Finally
    FreeAndNil(LQuery);
  End;
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

function fAbrirTabela(NomeTabela:TDataSet):Boolean;
begin
  Try
	  If NomeTabela.Active = False Then
      NomeTabela.Open;

	  Result := True;
  Except
	  On E : Exception do
	  Begin
		  Result := False;
		  pMensagensErro(E.Message, '[fAbrirTabela]');
	  End;
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

{ TCamposUso }

procedure TCamposUso.AdicionaCampos(qryTabela: TDataSet;
  strNomeTabela: String);
  Var
    intNovTam: Integer;
    intPosAtu: Integer;
    intContador: Integer;
    intIndice: Integer;
begin
  With qryTabela Do
  Begin
    intIndice := 0;
    intPosAtu := Length(FarrCampos);
    intNovTam := intPosAtu + FieldCount;

    SetLength(FarrCampos, intNovTam);
    SetLength(FarrValores, intNovTam);

    For intContador := intPosAtu To intNovTam - 1 Do
    Begin
      FarrCampos[intContador]  := strNomeTabela + '->' + Fields[intIndice].FieldName;

      If (qryTabela.Fields[intIndice].DataType <> ftInteger)  And
         (qryTabela.Fields[intIndice].DataType <> ftCurrency) And
         (qryTabela.Fields[intIndice].DataType <> ftFloat)    Then
      Begin
        FarrValores[intContador] := QuotedStr(Fields[intIndice].AsString);
      End
      Else
        FarrValores[intContador] := AnsiReplaceStr(Fields[intIndice].AsString, ',', '.');

      Inc(intIndice);
    End;
  End;
end;

constructor TCamposUso.Create;
begin
  inherited Create;
  SetLength(FarrCampos, 0);
  SetLength(FarrValores, 0);
end;

destructor TCamposUso.Destroy;
  Var
    intContador: Integer;
begin

  For intContador := Low(FarrCampos) To High(FarrCampos) Do
  Begin
    FarrCampos[intContador] := '';
  End;

  For intContador := Low(FarrValores) To High(FarrValores) Do
  Begin
    FarrValores[intContador] := '';
  End;

  SetLength(FarrCampos, 0);
  SetLength(FarrValores, 0);

  inherited Destroy;
end;

function TCamposUso.GetCampo(Index: String): String;
  Var
    intContador: Integer;
begin
  For intContador := 0 To Length(FarrCampos) -1 Do
  Begin
    If FarrCampos[intContador] = Index Then
    Begin
      Result := FarrValores[intContador];
      Exit;
    End;
  End;
  Result := '';
end;

procedure TCamposUso.LimparCampos;
begin
  SetLength(FarrCampos, 0);
  SetLength(FarrValores, 0);
end;

function fTamCodIte: Integer;
Var
  strSQL: String;
  qryGen: TUniQuery;
  intPosInicial, intQtde: Integer;
begin

  Result := VS_intTamCadIte;

  If VS_intTamCadIte > 0 Then
    Exit;

  Try

    qryGen := fCriaQuery;

    strSQL := 'DESC CADITE;';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      While (Not Eof) Do
      Begin
        If FieldByName('Field').asString = 'ITE_CODITE' Then
        Begin
          intPosInicial := Pos('(',FieldByName('Type').asString)+1;
          intQtde       := Pos(')',FieldByName('Type').asString) - intPosInicial;
          Result        := StrToInt( Copy( FieldByName('Type').asString, intPosInicial, intQtde ) );
          VS_intTamCadIte := Result;
          Break;
        End;
        Next;
      End;

    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

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

function fValidaEstado(strUf: String): Boolean;
  Var
    intContador: Integer;
begin
  Result := False;
  If Length(Trim(strUf)) = 2 Then
  Begin
    For intContador := 0 To Length(ESTADOS)-1 Do
    Begin
      If strUf = String(ESTADOS[intContador]) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  End;
end;

Procedure pSetaClient(cdsClient: TDataSet);
  Var
    intContador: Integer;
Begin
  With cdsClient Do
  For intContador := 0 To Fields.Count - 1 Do
  Begin
    If Fields[intContador].ReadOnly Then
      Fields[intContador].ProviderFlags := Fields[intContador].ProviderFlags - [pfInWhere, pfInUpdate];
    Fields[intContador].ReadOnly := False;
    Fields[intContador].Required := False;
  End;
End;

function fStatusCndPag(strCndPag: String): Integer;
begin

  Result := A_PRAZO;

  strCndPag := Trim(fTiraCaracEspeciais(strCndPag));

  Try
    If fStrToFloat(strCndPag) = 1000.0 Then
      Result := A_VISTA;
  Except
    {*****************************************}
    {* APENAS PARA NÃO DAR ERRO PARA O USUA- *}
    {* RIO.                                  *}
    {**************************************MV*}
  End;

end;

function fUsaLinkPagamentoSitefCielo: Boolean ;
begin
  Result := MatchStr(fCfgSis('LINKPG', varString), ['2', '3', '5']) ;
end ;

function fSQLIFClienteConsumidor(strCampoNomCli, strCampoCliCon, strCampoCadCli: String; blnCliBalcao: Boolean = True; blnCliSegura: Boolean = True): String;
begin
  Result := ' IF((           '+strCampoNomCli+' LIKE "%CONSUMIDOR%")'+
    +IIF(blnCliBalcao, ' OR ('+strCampoNomCli+' LIKE "%BALCAO%"'+') OR ('+strCampoNomCli+' LIKE "%BALCÃO%")', '')+
    +IIF(blnCliSegura, ' OR ('+strCampoNomCli+' LIKE "%SEGURADORA%")', '')+', '+strCampoCliCon+', '+strCampoCadCli+') ';
end;

function fSQLTipoFrete(strCamFre: String): String;
  Var
    strSQL: String;
    intContador: Integer;
Begin
  strSQL := '';
  strSQL := strSQL + ' (CASE ' + strCamFre + ' ';

  For intContador := Low(TiposFrete) To High(TiposFrete) Do
      strSQL := strSQL + '   WHEN ' + intToStr(TiposFrete[intContador])  + ' THEN "' + DescricoesFrete[intContador] + '" ';

  strSQL := strSQL + ' END) ';

  Result := strSQL;
End;

function fRetSQLCGCCPFFormatado(strCampoCGCCPF, strCampoC_G_C_: String): String;
begin
  Result := ' IF('+ strCampoCGCCPF + ' = 1, CONCAT(SUBSTRING('+strCampoC_G_C_+',1,2),".", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',3,3),".", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',6,3),"/", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',9,4),"-", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',13,2)),   ' +
            '                               CONCAT(SUBSTRING('+strCampoC_G_C_+',1,3),".", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',4,3),".", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',7,3),"-", ' +
            '                                      SUBSTRING('+strCampoC_G_C_+',10,2))) ';

end;

function fCriaDataSource(DataSet: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(DataSEt);
  Result.DataSet := DataSet;
end;

function fRetornaTelefonesCliente(Const strCodCli: String): String;
var
  qryTelefones: TUniQuery;
begin
  qryTelefones := fCriaQuery;

  try
    Result := EmptyStr;

    qryTelefones.Close;
    qryTelefones.SQL.Clear;
    qryTelefones.SQL.Add('SELECT CLI_FONE01, CLI_FONE02, CLI_CELULA');
    qryTelefones.SQL.Add('FROM CADCLI');
    qryTelefones.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryTelefones.ParamByName('CODCLI').AsString := strCodCli;
    qryTelefones.Open;

    if qryTelefones.IsEmpty then
      Exit;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE01').AsString) then
      Result := Result + qryTelefones.FieldByName('CLI_FONE01').AsString;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_FONE02').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryTelefones.FieldByName('CLI_FONE02').AsString;
    end;

    if not fEmptyStr(qryTelefones.FieldByName('CLI_CELULA').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryTelefones.FieldByName('CLI_CELULA').AsString;
    end;

  finally
    FreeAndNil(qryTelefones);
  end
end;

function fRetornaEmailsCobrancaCliente(Const strCodCli: String): String;
var
  qryEmails: TUniQuery;
begin
  qryEmails := fCriaQuery;

  try
    Result := EmptyStr;

    qryEmails.Close;
    qryEmails.SQL.Clear;
    qryEmails.SQL.Add('SELECT CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3, CLI_EMCOB1, CLI_EMCOB2');
    qryEmails.SQL.Add('FROM CADCLI');
    qryEmails.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryEmails.ParamByName('CODCLI').AsString := strCodCli;
    qryEmails.Open;

    if qryEmails.IsEmpty then
      Exit;

    If (fCfgSis('GPEMCB', VarBoolean)) Then
    Begin
      Result := '';

      If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL_').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMAIL_').AsString;

      If fEmptyStr(Result) Then
      Begin
        If Not fEmptyStr(qryEmails.FieldByName('CLI_EMCOB1').AsString) Then
          Result := qryEmails.FieldByName('CLI_EMCOB1').AsString;

        If Not fEmptyStr(qryEmails.FieldByName('CLI_EMCOB2').AsString) Then
        Begin
          If fEmptyStr(Result) Then
            Result := qryEmails.FieldByName('CLI_EMCOB2').AsString
          Else
            Result := Result + '; ' + qryEmails.FieldByName('CLI_EMCOB2').AsString;
        End;
      End;

      If fEmptyStr(Result) Then
      Begin
        If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL2').AsString) Then
          Result := qryEmails.FieldByName('CLI_EMAIL2').AsString
        Else If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL3').AsString) Then
          Result := qryEmails.FieldByName('CLI_EMAIL3').AsString;
      End;
    End
    Else
    Begin
      If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL_').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMAIL_').AsString
      Else If Not fEmptyStr(qryEmails.FieldByName('CLI_EMCOB1').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMCOB1').AsString
      Else If Not fEmptyStr(qryEmails.FieldByName('CLI_EMCOB2').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMCOB2').AsString
      Else If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL2').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMAIL2').AsString
      Else If Not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL3').AsString) Then
        Result := qryEmails.FieldByName('CLI_EMAIL3').AsString
      Else
        Result := '';
    End;

    Result := AnsiReplaceStr(Result, ';;', ';');

  finally
    FreeAndNil(qryEmails);
  end
end;

function fRetornaEmailsCliente(Const strCodCli: String): String;
var
  qryEmails: TUniQuery;
begin
  qryEmails := fCriaQuery;

  try
    Result := EmptyStr;

    qryEmails.Close;
    qryEmails.SQL.Clear;
    qryEmails.SQL.Add('SELECT CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3');
    qryEmails.SQL.Add('FROM CADCLI');
    qryEmails.SQL.Add('WHERE CLI_CODCLI = :CODCLI');
    qryEmails.ParamByName('CODCLI').AsString := strCodCli;
    qryEmails.Open;

    if qryEmails.IsEmpty then
      Exit;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL_').AsString) then
      Result := Result + qryEmails.FieldByName('CLI_EMAIL_').AsString;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL2').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryEmails.FieldByName('CLI_EMAIL2').AsString;
    end;

    if not fEmptyStr(qryEmails.FieldByName('CLI_EMAIL3').AsString) then
    begin
      if not fEmptyStr(Result) then
        Result := Result + ', ';

      Result := Result + qryEmails.FieldByName('CLI_EMAIL3').AsString;
    end;

  finally
    FreeAndNil(qryEmails);
  end
end;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  Begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  End;

  Result := strAux;
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

function fRetornaDataServidor: TDateTime;
var
  qryDta : TUniQuery;
begin

  qryDta := fCriaQuery();

  Try

    qryDta.Close;
    qryDta.SQL.Clear;
    qryDta.SQL.Add('SELECT CURRENT_DATE AS DATA');
    qryDta.Open;

    If Not qryDta.IsEmpty Then
      Result := qryDta.FieldByName('DATA').AsDateTime
    Else
      Result := 0;

  Finally
    FreeAndNil(qryDta);
  End;

end;

function fRetornaHoraServidor: TDateTime;
var
  qryHra : TUniQuery;
begin

  qryHra := fCriaQuery();

  Try

    qryHra.Close;
    qryHra.SQL.Clear;
    qryHra.SQL.Add('SELECT CURRENT_TIME AS HORA');
    qryHra.Open;

    If Not qryHra.IsEmpty Then
      Result := qryHra.FieldByName('HORA').AsDateTime
    Else
      Result := 0;

  Finally
    FreeAndNil(qryHra);
  End;

end;

function fRetEmpresa: String;
  Var
    qryEmp: TUniQuery;
begin
  qryEmp := fCriaQuery;
  qryEmp.SQL.Clear;
  qryEmp.SQL.Add('SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP');
  qryEmp.Open;

  If Not qryEmp.IsEmpty Then
  Begin
    qryEmp.First;
    Result := qryEmp.FieldByName('EMP_CODEMP').AsString;
  End
  Else
    Result := '001';

  FreeAndNil(qryEmp);
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
  Result := Screen.MonitorCount > 1;
End;

function fUsaLayoutNovo: Boolean;
Begin
  Result := //(Not blnUsuarioLogadoUtilizaModoClassico) And
            (TStyleManager.ActiveStyle.Name = AUTCOM_STYLE_NAME);
End;

procedure pCentralizarForm(AForm: TForm);
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

{********************************************}
{* LIMPA OBJETO DA MEMORIA                   }
{* FOI CRIADA PARA REFATORAR QUANDO PRCISA   }
{* VERIFICAR COM ASSIGNED                    }
{*****************************************AF*}
procedure pListFreeAndNil(var objList);
Begin
  If Not Assigned(TList(objList)) Then
    Exit;

  Try
    FreeAndNil(objList);
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pListFreeAndNil > FreeAndNil');
  End;

  Try
    pTrimAppMemorySize;
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pListFreeAndNil > pTrimAppMemorySize Exception');
  End;

  Try
    Application.ProcessMessages;
  Except
    On E: Exception Do
      pGravaLogErrArquivoLocal(E.ClassName + ' - ' + E.Message, fRetornaStack, 'pListFreeAndNil > Application.ProcessMessages');
  End;
End;


{***************************************************************}
{* PROCEDURE QUE VERIFICA SE A TABELA PASSADA COMO PARAMETRO   *}
{* ESTA CADASTRADA NA TABELA DE PROXIMOS CODIGOS, CASO NÃO     *}
{* CADASTRA AUTOMATICAMENTE USANDO OS VALORES DO VETOR PROCOD  *}
{************************************************************JC*}
procedure pValidaProCod(strNomeTabela: String);
  Var
    strSQL     : String;
    qryGenCod  : TUniQuery;
    intContador: Integer;
    LConn: TCriarConexao;
begin
  If Length(arrProCod) <= 0 Then
    pVerificaProCod;
  {*****************************************************}
  {* FILTRO DE TABELAS QUE NÃO DEVEM SER VERIFICADAS   *}
  {**************************************************JC*}
  If Not ((LeftStr(strNomeTabela,2) <> 'I_')   And
         (LeftStr(strNomeTabela,3) <> 'TMP')  And
         (LeftStr(strNomeTabela,4) <> 'DEL_') And
         (Pos(strNomeTabela, 'CFGSIS_CNFCHQ_CNFETI_CNF_NF_TABNRE_SEQLOG_APGTMP') <= 0)) Then
    Exit;

  LConn := TCriarConexao.Create('pValidaProCod('+strNomeTabela+')');
  try
    fStartTransaction(LConn.objConexao);
    Try
      Try
        qryGenCod := fCriaQuery(Nil, LConn.objConexao);
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
                FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD', VS_strCodEmp, -1);
                FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica(LConn.objConexao);
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
              Raise Exception.Create('A Tabela '+strNomeTabela+' não foi encontrada no Vetor PROCOD' + #13#10 +
                                     '[fValidaProcod].');

              Close;
            End;
          End;
        End;
        fCommit(LConn.objConexao);
      Except
        On E: Exception Do
        Begin
          fRollback(LConn.objConexao);
          Raise;
        End;
      End;
    Finally
      FreeAndNil(qryGenCod);
    End;
  finally
    FreeAndNil(LConn);
  end;
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
  arrProCod[intPosMat].intTamCod := 6;         {* BLOCO ADICIONADO PARA VALIDAÇÃO DO CADASTRO  *}
  arrProCod[intPosMat].strCodAut := 'S';       {* DE CLIENTES RELACIONAMENTO COM PRODUTOS APÓS *}
  arrProCod[intPosMat].intAutInc := 1;         {* TESTAR GRAVAÇÃO COM A NOVA CONDULTA DE ITENS *}
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamDocCadRec);
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamDocCadRec);
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamDocCadRec);
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamDocCadRec);
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamDocCadRec);
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

  If (fSetaPais = opcParaguai) Or fCfgSis('COTDOR', VarBoolean) Then
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
  arrProCod[intPosMat].strCodSeq := fStrZero('1', fTamCodLse);
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

// ##PROCOD## // COLOCADO PARA PESQUISAR O FIM DO PROCOD MAIS RÁPIDO.
End;

function fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
  Var
     strSQL   : String;
    qryGenTmp: TUniQuery;
begin
  Try

    Result := True;

    If Assigned(Conexao) Then
      qryGenTmp := fCriaQuery(Nil, Conexao)
    Else
      qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DROP TABLE ' + strNomeTabela;

    Try

      If Not fTabelaExiste(strNomeTabela, False, Conexao) Then
        Exit;

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ExecSQL;
        Close;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fDropTable]');
        Result := False;
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;


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

function RetornaArquivoBase64(const ACaminhoArquivo: String): String;
  Var
    LArquivo: TFilestream;
Begin

  Try
    LArquivo := TFileStream.Create(ACaminhoArquivo, fmOpenRead);

    Result := TIdEncoderMIME.EncodeStream(LArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;

function fSegToTimeStr(Segundos: Double): String;

  function fFormata(StrTexto: String): String;
  begin
    If Length(strTexto) = 1 Then
      Result := '0' + strTexto
    Else
      Result := strTexto;
  end;

  Var
    fltHor : Double;
    fltMin : Double;
    fltSeg : Double;
begin
  If (Segundos <= 0) Then
  Begin
    Result := '00:00:00';
    Exit;
  End;

  fltHor := Int( (Segundos / 3600) );
  fltMin := Int( ( Segundos - ( fltHor * 3600 ) ) / 60 );
  fltSeg := Round(Segundos - ( fltHor * 3600 ) - ( fltMin * 60 ));

  If (fltSeg >= 60) Then
  Begin
    fltMin := fltMin + (Floor(fltSeg) div 60);
    fltSeg := Floor(fltSeg) mod 60;
  End;

  If (fltMin >= 60) Then
  Begin
    fltHor := fltHor + (Floor(fltMin) div 60);
    fltMin := Floor(fltMin) mod 60;
  End;

  Result := fFormata(FloatToStr(fltHor)) + ':' +
            fFormata(FloatToStr(fltMin)) + ':' +
            fFormata(FloatToStr(fltSeg));
end;

function fExisteOrcamentoPendente(strCodCli, strNumOrc: String; strCodPro: String = ''): Boolean;
Begin
  Result := fExisteFatGorPendente(strCodCli, strNumOrc, 'OR', strCodPro);
End;

function fExistePedidoPendente(strCodCli, strNumDoc: String; strCodPro: String = ''): Boolean;
Begin
  Result := fExisteFatGorPendente(strCodCli, strNumDoc, 'PD', strCodPro);
End;

function fExisteFatGorPendente(strCodCli, strNumDoc: String; strEspDoc: String; strCodPro: String = ''): Boolean;
Var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    qryGen.SQL.Clear;

    qryGen.SQL.Add('SELECT   ');
    qryGen.SQL.Add('  SUM(IFNULL(FDO_QTDITE,0) - IFNULL(FDO_QTDBAI,0)) AS QTDPEN ');
    qryGen.SQL.Add('FROM     ');
    qryGen.SQL.Add('  FATDOR ');
    If (Not fEmptyStr(strCodPro)) Then
    Begin
      qryGen.SQL.Add('  INNER JOIN FATGOR ON FDO_SEQGER = FATGOR.AUTOINCREM ');
      qryGen.SQL.Add('  INNER JOIN MOVOCO ON FGO_NUMDOC = OCO_NUMDOC AND    ');
      qryGen.SQL.Add('                       FGO_ESPDOC = OCO_ESPDOC AND    ');
      qryGen.SQL.Add('                       FGO_CODEMP = OCO_CODEMP        ');
    End;
    qryGen.SQL.Add('WHERE FDO_CODEMP = :CODEMP ');
    qryGen.SQL.Add('  AND FDO_JAFATU = 0       ');
    qryGen.SQL.Add('  AND FDO_ESPDOC = :ESPDOC   ');

    If Not (fEmptyStr(strNumDoc)) Then
      qryGen.SQL.Add('  AND FDO_NUMDOC <> :NUMDOC ');

    If Not (fEmptyStr(strCodPro)) Then
    Begin
      qryGen.SQL.Add('  AND ((FDO_CODCLI = :CODCLI) or (FDO_CODCLI =:CONCRM))');
      qryGen.SQL.Add('  AND OCO_CODCLI  = :CODPRO ');
    End
    Else
    Begin
      qryGen.SQL.Add('  AND FDO_CODCLI = :CODCLI ');
    End;

    qryGen.SQL.Add('HAVING QTDPEN > 0           ');

    qryGen.ParamByName('CODCLI').AsString := strCodCli;
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    If Not (fEmptyStr(strNumDoc)) Then
      qryGen.ParamByName('NUMDOC').AsString := strNumDoc;
    If Not (fEmptyStr(strCodPro)) Then
    Begin
      qryGen.ParamByName('CODPRO').AsString := strCodPro;
      qryGen.ParamByName('CONCRM').AsString := fCfgSis('CONCRM', varString);
    End;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;

    qryGen.Open;

    Result := Not qryGen.IsEmpty;

  Finally
    qryGen.Close;
    FreeAndNil(qryGen);
  End;
End;

function fSQLBarDoc(strPrefix: String; strNumDoc, strEspDoc, strCodEmp : String): String;
  Var
    intIndex : Integer;
Begin
  Result := '';
  Result := Result + ' CONCAT( "1", ';

  If fEmptyStr(strNumDoc) Then
    Result := Result + strPrefix + '_NUMDOC, '
  Else
    Result := Result + QuotedStr(strNumDoc) + ', ';

  If fEmptyStr(strEspDoc) Then
    Result := Result + 'CASE ' + strPrefix + '_ESPDOC '
  Else
    Result := Result + 'CASE ' + QuotedStr(strEspDoc);

  For intIndex := Low(ARR_ESPDOC_TO_CODE) To High(ARR_ESPDOC_TO_CODE) Do
    Result := Result + '  WHEN "'+ARR_ESPDOC_TO_CODE[intIndex]+'" THEN "' + fStrZero(intToStr(intIndex),2) + '" ';

  Result := Result + 'END, ';

  If fEmptyStr(strCodEmp) Then
    Result := Result + strPrefix + '_CODEMP) '
  Else
    Result := Result + QuotedStr(strCodEmp) + ')';

End;

function fGetSQLConsultaItensPrecoValidandoEstrutura(strAliasIteger: String = 'ITEGER'; strTabelaPreco: string = '1'): string;
Begin
   { Se o parametro usar estrutura estiver marcado e o parametro calcular o preço de venda somando as itens da estrutura então faz o sql
     carregar o preço de venda somando as itens da estrutura senão devolve apenas o campo preve* da ITEGER }
    If Pos(strTabelaPreco, '1234567')  = 0 Then
      strTabelaPreco := '1';
    If fCfgSis('CADEST', varBoolean) and (fCfgSis('SUGVLE', varInteger) = 2) Then
    begin
       Result := ' IFNULL( ' +
                ' ( ' +
                '   SELECT SQL_NO_CACHE ' +
                '     SUM(ROUND(DM.DMT_QTDITE * IT.ITE_PREVE' + strTabelaPreco + ', 2)) ' +
                '   FROM ' +
                '     DETMAT DM ' +
                '     INNER JOIN GERMAT GM ON DM.DMT_SEQGER = GM.AUTOINCREM ' +
                '     INNER JOIN ITEGER IT ON DM.DMT_ITESUB = IT.ITE_CODITE ' +
                '   WHERE ' +
                '     GM.GMT_CODITE = ' + strAliasIteGer + '.ITE_CODITE AND ' +
                '     IT.ITE_CODEMP = ' + strAliasIteGer + '.ITE_CODEMP ' +
                ' ), ' + strAliasIteGer + '.ITE_PREVE' + strTabelaPreco + ') ' ;
   End
   Else
     Result := strAliasIteGer + '.ITE_PREVE' + strTabelaPreco + ' ';
End;

function fRetFormsAtivos: String;
var
  intContador: Integer;
begin
  Result := EmptyStr;
  for intContador := 0 to Screen.FormCount - 1 do
    Result := Result + IIF(not fEmptyStr(Result), ', ', '') + Screen.Forms[intContador].Name;
end;

function fDocumentoOrigemFF_DV_TR(const strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
Var
  LqryDocs : TUniQuery;
begin
  LqryDocs := fCriaQuery;
  Try
    LqryDocs.Close;
    LqryDocs.SQL.Clear;

    LqryDocs.SQL.Add('SELECT DISTINCT GER_DTAENT AS DTAENT,');
    LqryDocs.SQL.Add('       CONCAT(GER_NUMDOC, "-", GER_ESPDOC) AS NUMDOC,');
    LqryDocs.SQL.Add('       GER_CODEMP AS CODEMP,');
    LqryDocs.SQL.Add('       MOVGER.AUTOINCREM,   ');
    LqryDocs.SQL.Add('       GER_ESPDOC AS ESPDOC ');
    LqryDocs.SQL.Add('FROM MOVGER ');
    LqryDocs.SQL.Add('  INNER JOIN MOVDET ON MOVDET.DET_SEQGER = MOVGER.AUTOINCREM');
    LqryDocs.SQL.Add('WHERE DET_NUMFAT = :NUMDOC');
    LqryDocs.SQL.Add('  AND DET_TIPFAT = :ESPDOC');
    LqryDocs.SQL.Add('  AND DET_EMPFAT = :CODEMP');

    LqryDocs.ParamByName('NUMDOC').AsString := strNumDoc;
    LqryDocs.ParamByName('ESPDOC').AsString := strEspDoc;
    LqryDocs.ParamByName('CODEMP').AsString := strCodEmp;

    LqryDocs.Open;
  Finally
    Result := (Assigned(LqryDocs)) And (LqryDocs.Active) And
              (Not LqryDocs.IsEmpty) And (Pos(LqryDocs.FieldbyName('ESPDOC').AsString, 'FF_DV_TR_') > 0);
    FreeAndNil(LqryDocs);
  End;
end;

function fArquivoExisteNoDiretorio(strArquivo: String; intMaxTentativas: Integer = 1; cdnSleep: Cardinal = 0): Boolean;
var
  intTentativas: Integer;
begin
  intTentativas := 0;

  repeat
    Inc(intTentativas);

    Result := FileExists(strArquivo);

    if (not Result) and (intTentativas > 1) and (cdnSleep > 0) then
      Sleep(cdnSleep);

  until ((Result) or (intTentativas = intMaxTentativas));
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

  iniArqIni := TIniFile.Create(strPathOpcoes + 'opcoestinta.ini');
  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);
	    1: iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
    End;
  Finally
	  iniArqIni.Free;
  End;
end;

function fSolicitaDigDuplicAdiantamentoPedido: Boolean;
begin
  Result := False;

  If Not fCfgSis('DUPORP', varBoolean) Then
    Exit;

  If Not fCfgSis('DUPADT', varBoolean) Then
    Exit;

  Result := True;
end;

function fRetFilaEApiKeyPrincipalWhatsapp(var extIdFila: Extended; var strApiKey: String;
  conexao: TUniConnection = nil): Boolean;
var
  qryCadFil: TUniQuery;
begin
  Result := False;

  qryCadFil := fCriaQuery(nil, conexao);
  try
    qryCadFil.Close;
    qryCadFil.SQL.Text :=
    ' SELECT '+
    '   FIL_IDFILA, '+
    '   FIL_KEYAPI '+
    ' FROM '+
    '   CADFIL '+
    ' WHERE '+
    '   FIL_CODEMP = :CODEMP AND '+
    '   FIL_FILPRI = "S" ';
    qryCadFil.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadFil.Open;

    if not qryCadFil.IsEmpty then
    begin
      Result := True;
      extIdFila := qryCadFil.FieldByName('FIL_IDFILA').AsExtended;
      strApiKey := qryCadFil.FieldByName('FIL_KEYAPI').AsString;
    end;
  finally
    FreeAndNil(qryCadFil);
  end;
end;

function fCfgExpedicaoParcialHabilitada: Boolean;
begin
  Result := Pos(fCfgSis('EXPPAR', varString), '_S_P') > 0;
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
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;

    If (Not fEmptyStr(strInformacao)) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
      TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;

    Application.ProcessMessages;
  End;

  If Not fEmptyStr(strInformacao) Then
    If Not VS_ExibirMensagemAoUsuario Then
      If Assigned(VS_OnMensagemAoUsuario) Then
        VS_OnMensagemAoUsuario(strInformacao);
end;

function SalvaArquivo(ANumPok: string; AArquivo: TRESTResponse; AResultOk : String): string;
var
  LContador  : Integer;
  LStream    : TFileStream;
  LByteAtual : Byte;
  LPath      : String;
  LDiretorio : String;
begin

  Result := EmptyStr;

  LDiretorio := ExtractFilePath(Application.ExeName) + 'ARQUIVOS\';

  if not DirectoryExists(LDiretorio) then
    CreateDir(LDiretorio);

  LPath   := LDiretorio + ANumPok + '.zip';
  LStream := TFileStream.Create(LPath, fmCreate);

  Try
    For LContador := Low(AArquivo.RawBytes) To High(AArquivo.RawBytes) Do
    Begin
      LByteAtual := AArquivo.RawBytes[LContador];
      LStream.Write(LByteAtual, 1);
    End;
  Finally
    FreeAndNil(LStream);
  End;

  if DescompactaArquivo(LPath, LDiretorio + ANumPok) then
    Result := AResultOk;

end;

function DescompactaArquivo(ACaminho, ADiretorio: string): Boolean;
  var
    LDescompactar: TZipFile;
begin

  Result := False;

  LDescompactar := TZipFile.Create;

  try

    try

      if not DirectoryExists(ADiretorio) then
        CreateDir(ADiretorio);

      LDescompactar.Open(ACaminho, zmRead);
      LDescompactar.ExtractAll(ADiretorio);
      LDescompactar.Close;

      DeleteFile(pChar(ACaminho));

      Result := True;

    except
      on E: Exception do
        fMensagem('Descompactar',E.Message,['&OK']);
    end;

  finally
    FreeAndNil(LDescompactar);
  end;

end;

function fUsaOndaSeparacaoAgrupamento(): Boolean;
begin

  Result := False;

  If Not fCfgSis('ONDAGR', varBoolean) Then
    Exit;

  Result := True;

end;

function fLimiteCreditoCliente(strCodCli: String; blnRedLoj: Boolean = False; strRedLoj: String = ''): Double;
  var
  strSQL: String;
  qryAux: TUniQuery;
begin
  If (fCfgSis('TRFTCR', varString) = '1') And (Not blnRedLoj) Then
    Result := fCampoTabela('CLI_LIMCRE', 'CADCLI', ['CLI_CODCLI'], [strCodCli])
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT                           ';
    strSQL := strSQL + '  SUM(CLI_LIMCRE) AS LIMCRE      ';
    strSQL := strSQL + 'FROM CADCLI                      ';
    If (Not fEmptyStr(strRedLoj)) And (blnRedLoj) Then
      strSQL := strSQL + ' WHERE CLI_CODRED = :REDE       '
    Else
    Begin
      strSQL := strSQL + 'WHERE CLI_CODCLI = :CODCLI       ';
      strSQL := strSQL + ' OR CLI_CODRED =                 ';
      strSQL := strSQL + '    (SELECT                      ';
      strSQL := strSQL + '       CLI_CODRED                ';
      strSQL := strSQL + '     FROM                        ';
      strSQL := strSQL + '       CADCLI                    ';
      strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI) ';
    End;

    qryAux := fCriaQuery();
    Try
      qryAux.Close;
      qryAux.SQL.Text := strSQL;
      If (Not fEmptyStr(strRedLoj)) And (blnRedLoj) Then
        qryAux.ParamByName('REDE').AsString   := strRedLoj
      Else
        qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.Open;

      Result := qryAux.FieldByName('LIMCRE').AsFloat;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
End;

function fRetornaReceberAberto(strCodCli: String): Double;
  Var
    qryConsulta: TUniQuery;
    strSQL: String;
begin
  qryConsulta:= fCriaQuery(nil);

  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   SQL_NO_CACHE ';
  strSQL := strSQL + '   SUM(( ';
  strSQL := strSQL + '         CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0) ' ;
  strSQL := strSQL + '      )) AS TOTABE ' ;
  strSQL := strSQL + ' FROM ' ;
  strSQL := strSQL + '   CADREC ' ;
  strSQL := strSQL + '   LEFT JOIN CADPOR ' ;
  strSQL := strSQL + '     ON CTR_CODPOR = POR_CODPOR ' ;
  strSQL := strSQL + ' WHERE ' ;

  strSQL := strSQL + '       CTR_CODCLI = :CODCLI ' ;
  strSQL := strSQL + '   AND CTR_DTAREC IS NULL ' ;
  strSQL := strSQL + ' GROUP BY CTR_CODCLI ';

  Try
    qryConsulta.SQL.Text := strSQL;
    qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
    qryConsulta.Open;
  Finally
    Result := 0;
    if not qryConsulta.IsEmpty then
      Result := qryConsulta.FieldByName('TOTABE').Value;

    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End
End;

function fRetChqAberto(strExp, strCodCli: String; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;

  If Not fCfgSis('MPREFF', varBoolean) Then
  Begin
    Result :=  0;
    Exit;
  End;

  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;
    strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
              fRetSQLResFinanceiro(ttCadChq, tcChqAberto, strRedeLoja,blnRed,AAjustaData) + ') AS T ';

    qryGen.SQL.Add(strSQL);
    If Not fEmptyStr(strRedeLoja) And (blnRed) then
      qryGen.ParamByName('REDE').AsString := strRedeLoja
    Else
      qryGen.ParamByName('CODCLI').AsString := strCodCli;

    qryGen.Open;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function fRetChqDevolvidos(strExp, strCodCli: String; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := 0.0;
  Try
    qryGen := fCriaQuery;

    qryGen.Close;
    qryGen.SQL.Clear;
    strSQL := 'SELECT ' + strExp + '(CHQ_VALCHQ) AS VALCHQ FROM ( ' +
              fRetSQLResFinanceiro(ttCadChq, tcChqDevolvidos, strRedeLoja,blnRed,AAjustaData) + ') AS T ';

    qryGen.SQL.Add(strSQL);
    If Not fEmptyStr(strRedeLoja) And (blnRed) then
      qryGen.ParamByName('REDE').AsString := strRedeLoja
    Else
      qryGen.ParamByName('CODCLI').AsString := strCodCli;

    qryGen.Open;

    Result := qryGen.FieldByName('VALCHQ').AsFloat;
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGen);
End;

function fTotalEmprestimosEmAberto(const strCodCli: String; var intQtdEP: Integer): Double;
  Var
    qryGen: TUniquery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.Close;
    qryGen.SQL.Text :=
    ' SELECT '+

    '    IFNULL( '+
    '            SUM( '+
    '              (IFNULL(DET_QTDITE,0) - IFNULL(DET_BAIEMP,0)) * ( '+
    '                ( '+
    '                  DET_TOTITE + IFNULL(DET_VALIPI, 0) + IFNULL(DET_VALRET, 0) + IFNULL(ICD_VALFCP, 0) + IFNULL(DET_TOTFRE, 0) + IFNULL(DET_DESACE, 0)' + fSqlValorReformaMovRef('MOVDET.AUTOINCREM') + ' - IFNULL(DET_DESESP, 0) '+
    '                ) / DET_QTDITE '+
    '              ) '+
    '            ) '+
    '          ,0 ) AS TOTABE, '+

    '    COUNT(*) AS QTDABE  '+

    ' FROM '+
    '   MOVDET '+

    ' INNER JOIN MOVTRI '+
    '   ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER '+
    ' LEFT JOIN  MOVICD ON ICD_SEQGER = MOVDET.AUTOINCREM  '+
    ' WHERE '+
    '   DET_CODCLI = :CODCLI              AND '+
    '   DET_JAFATU = 0                    AND '+
    '   DET_ESPDOC = "EP"                 AND '+
    '   DET_QTDITE > IFNULL(DET_BAIEMP,0) AND '+
    '   DET_CLAFIS > 5000    ';

    qryGen.ParamByName('CODCLI').AsString := strCodCli;

    qryGen.Open;

    Result   := qryGen.FieldByName('TOTABE').AsFloat;
    intQtdEP := qryGen.FieldByName('QTDABE').AsInteger;
  finally
    FreeAndNil(qryGen);
  end;
End;

function fRetSQLResFinanceiro(typTab: typTipTab; typCon: typTipCon; strRedeLoja: String = ''; blnRed : Boolean = False; AAjustaData: Boolean = False; blnClientePro: Boolean = False): String;
Const
  TEXT_HIST01 = 'REF. CASH BACK PROFISSIONAIS - GERADO AUTOMATICAMENTE';
Var
  strBase: String;
  strSQL : String;
  strChqNaoRepassado: string;
  blnDescFinanSomenteAteVenc : boolean;
  blnConsChqRepassadoNaoVenc: boolean;
Begin
  strSQL := '';

  blnDescFinanSomenteAteVenc := (fCfgSis('UTDEFN') = '2');
  blnConsChqRepassadoNaoVenc := fCfgSis('CHQNVT', varBoolean);

  If (typTab = ttCadRec) Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_NUMDUP, ';
    strSQL := strSQL + '  CTR_NUMDUP AS NUMDUP, ';
    strSQL := strSQL + '  IF(CTR_ESPDOC = "", NULL, CTR_ESPDOC) AS CTR_ESPDOC, ';
    strSQL := strSQL + '  CTR_CODEMP AS CTR_CODEMP, ';
    strSQL := strSQL + '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ';
    strSQL := strSQL + '  IF(CTR_CODVEN = "", NULL, CTR_CODVEN) AS CTR_CODVEN, ';
    strSQL := strSQL + '  CTR_DTACAD AS CTR_DTACAD, ';
    strSQL := strSQL + '  CTR_DTAVEN AS CTR_DTAVEN, ';
    strSQL := strSQL + '  CTR_NOSNUM AS CTR_NOSNUM, ';

    If blnDescFinanSomenteAteVenc Then
      strSQL := strSQL + ' IF((CTR_DTAVEN < CURDATE()), ' +
                         ' (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - 0), ' +
                         ' (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0))) '+
                         '  AS CTR_VALDUP, '
    else
      strSQL := strSQL + '  (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) AS CTR_VALDUP, ';

    strSQL := strSQL + '  IF(CTR_DTAVEN <  ' + fCurrentDate + ', (CTR_VALDUP + IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0)), 0.00) AS CTR_DUPVEN, ';
    strSQL := strSQL + '  IF(CTR_DTAVEN >= ' + fCurrentDate + ', (CTR_VALDUP + IF(CTR_DTAREC IS NULL, IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), 0)), 0.00) AS CTR_DUPAVE, ';
    strSQL := strSQL + '  IFNULL( ';
    strSQL := strSQL + '    IF( ';
    strSQL := strSQL + '      CTR_SEQBAI = 0, ';
    strSQL := strSQL + '      IF( ';
    strSQL := strSQL + '        CTR_VALREC <> 0, ';
    strSQL := strSQL + '        CTR_VALREC + IFNULL(CTR_VALDES, 0) - IFNULL(CTR_VALJUR, 0) - IFNULL(CTR_VALCOB, 0), ';
    strSQL := strSQL + '        CTR_VALDUP ';
    strSQL := strSQL + '      ), ';
    strSQL := strSQL + '      CTR_VALORI ';
    strSQL := strSQL + '    ), ';
    strSQL := strSQL + '    0 ';
    strSQL := strSQL + '  ) + IF( ';
    strSQL := strSQL + '    CTR_DTAREC IS NULL, ';
    strSQL := strSQL + '    IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0), ';
    strSQL := strSQL + '    0 ';
    strSQL := strSQL + '  ) AS CTR_VALORI, ';
    strSQL := strSQL + '  CTR_VALORI AS VALOR, ';
    strSQL := strSQL + '  IF(CTR_DTAVEN >= IF(CTR_DTAREC IS NULL, CURRENT_DATE, CTR_DTAREC), 0, DATEDIFF(IF(CTR_DTAREC IS NULL, CURRENT_DATE, CTR_DTAREC), CTR_DTAVEN)) AS DIASATRASO, ';
    strSQL := strSQL + '  CTR_DTAREC AS CTR_DTAREC, ';
    strSQL := strSQL + '  IFNULL(CTR_VALREC, 0) AS CTR_VALREC, ';
    strSQL := strSQL + '  CTR_CODCLI AS CTR_CODCLI, ';
    strSQL := strSQL + '  CTR_SEQBAI AS CTR_SEQBAI, ';
    strSQL := strSQL + '  CAST(IF(CTR_HIST01 IS NULL, "", CTR_HIST01) AS CHAR(255)) AS CTR_HIST01, ';
    strSQL := strSQL + '  IF(CTR_HIST02 IS NULL, "", CTR_HIST02) AS CTR_HIST02, ';
    strSQL := strSQL + '  CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS NOMPOR,';
    strSQL := strSQL + '  "CADREC"   AS NOMARQ,     ';
    strSQL := strSQL + '  "M"        AS CTR_MARDES, ';
    strSQL := strSQL + '  0.00       AS CTR_VALCAL, ';
    strSQL := strSQL + '  0.00       AS CTR_VALJUR, ';
    strSQL := strSQL + '  0.00       AS CTR_DIFERE  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'INNER JOIN CADCLI ';
    strSQL := strSQL + '  ON CLI_CODCLI = CTR_CODCLI ';
    strSQL := strSQL + 'LEFT JOIN CADPOR ';
    strSQL := strSQL + '  ON POR_CODPOR = CTR_CODPOR ';

    strSQL := strSQL + 'WHERE ( ';

    If Not fEmptyStr(strRedeLoja) And (blnRed) then
      strSQL := strSQL + '  CLI_CODRED = :REDE '
    Else
    Begin
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
      If (fCfgSis('TRFTCR', varString) = '2') and blnRed Then
      Begin
        strSQL := strSQL + '    OR CLI_CODRED =                                      ';
        strSQL := strSQL + '    (SELECT                                              ';
        strSQL := strSQL + '       CLI_CODRED                                        ';
        strSQL := strSQL + '     FROM                                                ';
        strSQL := strSQL + '       CADCLI                                            ';
        strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                         ';
      End;
    End;
         strSQL := strSQL + ' ) ';

    //Somente das empresas que o operador tem direito de acesso.
    If fCfgSis('EMREFN') = '1' Then
      strSQL := strSQL + '  AND CTR_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

    If fCfgSis('EXIPOR', varBoolean) Then
      strSQL := strSQL + ' AND ((IFNULL(POR_EXIPOR, "") = "") OR (POR_EXIPOR = "S"))  ';

    If (typCon = tcTitAbertos) Then       // Títulos em Aberto
    Begin

      strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';
      strSQL := strSQL + '  AND CTR_VALDUP > 0 ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

    End

    Else If (typCon = tcTitLiquidados) Then  // Títulos Liquidados
    Begin

      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_VALREC > 0 ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

    End

    Else If (typCon = tcTitAtrazados) Then  // Títulos Atrasados em Aberto
    Begin

      strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';
      strSQL := strSQL + '  AND CTR_VALDUP > 0 ';
      strSQL := strSQL + '  AND CTR_DTAVEN < ' + fCurrentDate + ' ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

    End

    Else If (typCon = tcTitAtrazadosLiq) Then  // Títulos Atrasados Liquidados
    Begin

      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_VALREC > 0 ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

      {***********************************************}
      {* Considerar finais de semana como dias uteis *}
      {43576***************************************LE*}
      If Not AAjustaData Then
        strSQL := strSQL + ' AND CTR_DTAVEN < CTR_DTAREC '
      Else
      Begin
        strSQL := strSQL + ' AND fRetProxDiaUtil(CTR_DTAVEN)  < CTR_DTAREC ';
      End;

    End

    Else If (typCon = tcTitCreditos) Then  // Créditos
    Begin
      strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';
      strSQL := strSQL + '  AND (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) < 0 ';

      If Not fEmptyStr(fCfgSis('POOCRE')) Then
        strSQL := strSQL + 'AND IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString;

      If (fCfgSis('EXCBRF', varBoolean)) And (blnClientePro) Then
        strSQL := strSQL + ' AND IFNULL(CTR_HIST01, "") NOT LIKE "%' + TEXT_HIST01 + '%"';
    End

    Else If (typCon = tcTitCreditosLiq) Then //Créditos Liquidados
    Begin
      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_VALREC < 0 ';

      If (fCfgSis('EXCBRF', varBoolean)) And (blnClientePro) Then
        strSQL := strSQL + ' AND IFNULL(CTR_HIST01, "") NOT LIKE "%' + TEXT_HIST01 + '%"';
    End

    Else If (typCon = tcTitCashback) Then
    Begin
      strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';
      strSQL := strSQL + '  AND (CTR_VALDUP + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0) - IFNULL(CTR_DESSUJ, 0)) < 0 ';

      If Not fEmptyStr(fCfgSis('POOCRE')) Then
        strSQL := strSQL + 'AND IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString;

      If (fCfgSis('EXCBRF', varBoolean)) And (blnClientePro) Then
        strSQL := strSQL + ' AND CTR_HIST01 LIKE "%' + TEXT_HIST01 + '%"';
    End

    Else If (typCon = tcTitCashbackLiq) Then
    Begin
      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_VALREC < 0 ';

      If (fCfgSis('EXCBRF', varBoolean)) And (blnClientePro) Then
        strSQL := strSQL + ' AND CTR_HIST01 LIKE "%' + TEXT_HIST01 + '%"  ';
    End

    Else If (typCon = tcTitDentroPrazoAbertos) Then     // Titulos dentro do prazo em aberto
    Begin

      {***********************************************}
      {* Considerar finais de semana como dias uteis *}
      {43576***************************************LE*}
      If Not AAjustaData Then
      begin
        strSQL := strSQL + ' AND CTR_DTAVEN >= ' + fCurrentDate;
      end
      Else
      Begin
        strSQL := strSQL + ' AND fRetProxDiaUtil(CTR_DTAVEN) >= ' + fCurrentDate;
      End;

      strSQL := strSQL + '  AND CTR_DTAREC IS NULL ';
      strSQL := strSQL + '  AND CTR_VALDUP > 0 ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

    end
    Else If (typCon = tcTitDentroPrazoLiquidados) Then  // Titulos dentro do prazo liquidados
    Begin

      {***********************************************}
      {* Considerar finais de semana como dias uteis *}
      {43576***************************************LE*}
      If Not AAjustaData Then
      begin
        strSQL := strSQL + ' AND CTR_DTAVEN >= CTR_DTAREC ';
      end
      Else
      Begin
        strSQL := strSQL + ' AND fRetProxDiaUtil(CTR_DTAVEN)  >= CTR_DTAREC ';
      End;

      strSQL := strSQL + '  AND CTR_DTAREC IS NOT NULL ';
      strSQL := strSQL + '  AND CTR_VALREC > 0 ';

      If fCfgSis('MPDAFF', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_ESPDOC <> "PD" ';

    End;

  End
  Else If (typTab = ttCadChq) Then
  Begin
    strChqNaoRepassado := IIF(blnConsChqRepassadoNaoVenc, ' AND C.CHQ_CTADEP <> "REPASSE" ', '');

    strSQL  := '';
    strBase := '';
    strBase := 'SELECT ' +
               '  CONCAT(CLI_CODCLI, "-", CLI_NOMCLI) AS CLIENTE, ' +
               '  C.CHQ_NUMCHQ, ' +
               '  C.CHQ_CODEMP, ' +
               '  C.CHQ_CODBCO, ' +
               '  C.CHQ_NOMEMI, ' +
               '  C.CHQ_DTADEP, ' +
               '  C.CHQ_DTADEV, ' +
               '  C.CHQ_DTADP2, ' +
               '  C.CHQ_DTADV2, ' +
               '  C.CHQ_DTAVEN, ' +
               '  C.CHQ_VALCHQ, ' +
               '  C.CHQ_NUMAGE, ' +
               '  C.CHQ_TELCHE, ' +
               '  C.CHQ_TELNUM  ' +
               'FROM ' +
               '  CADCHQ C ' +
               'INNER JOIN CADCLI ' +
               '  ON CLI_CODCLI = C.CHQ_CODCLI ';

    strSQL := strSQL + 'WHERE ( ';
    If (Not fEmptyStr(strRedeLoja) and (blnRed)) Then
      strSQL := strSQL + ' CLI_CODRED = :REDE '
    Else
    Begin
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';
      If (fCfgSis('TRFTCR', varString) = '2') And blnRed Then
      Begin
        strSQL := strSQL + '    OR CLI_CODRED =                                      ';
        strSQL := strSQL + '    (SELECT                                              ';
        strSQL := strSQL + '       CLI_CODRED                                        ';
        strSQL := strSQL + '     FROM                                                ';
        strSQL := strSQL + '       CADCLI                                            ';
        strSQL := strSQL + '     WHERE CLI_CODCLI = :CODCLI)                         ';
      End;
    End;
    strSQL := strSQL + ' ) ';

    If (typCon = tcChqAberto) Then       // Cheques em Aberto
    Begin
      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND ((C.CHQ_DTADEP IS NULL AND C.CHQ_DTADV2 IS NULL)';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN >= CURDATE()) ';

      strSQL := strSQL + ' )';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
    End
    Else If (typCon = tcChqAVistaEmAberto) Then  // Cheques a vista em aberto
    Begin

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND ((C.CHQ_DTADEP IS NULL AND C.CHQ_DTADV2 IS NULL)';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN >= CURDATE()) ';

      strSQL := strSQL + ' )';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_DTAVEN = C.CHQ_DTACAD ';

    end

    Else If (typCon = tcChqAPrazoEmAberto) Then  // Cheques a prazo em aberto
    Begin

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND ((C.CHQ_DTADEP IS NULL AND C.CHQ_DTADV2 IS NULL)  ';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN >= CURDATE())  ';

      strSQL := strSQL + ' ) ';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_DTAVEN <> C.CHQ_DTACAD ';

    end

    Else If (typCon = tcChqAVistaLiquidados) Then  // Cheques a vista liquidados
    Begin

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (C.CHQ_DTADEP IS NOT NULL AND C.CHQ_DTADEV IS NULL ' + strChqNaoRepassado + ') OR ';
      strSQL := strSQL + '      (C.CHQ_DTADEV IS NOT NULL AND C.CHQ_DTADV2 IS NOT NULL ' + strChqNaoRepassado + ') ';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN < CURDATE())  ';

      strSQL := strSQL + ' ) ';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_DTAVEN = C.CHQ_DTACAD ';

    end

    Else If (typCon = tcChqAPrazoLiquidados) Then  // Cheques a prazo liquidados
    Begin

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (C.CHQ_DTADEP IS NOT NULL AND C.CHQ_DTADEV IS NULL ' + strChqNaoRepassado + ') OR ';
      strSQL := strSQL + '      (C.CHQ_DTADEV IS NOT NULL AND C.CHQ_DTADV2 IS NOT NULL ' + strChqNaoRepassado + ') ';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN < CURDATE())  ';

      strSQL := strSQL + ' ) ';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_DTAVEN <> C.CHQ_DTACAD ';

    end

    Else If (typCon = tcChqDevolvidos) Then  // Cheques Devolvidos em Aberto
    Begin
      {*************************************}
      {* CASO A CONFIGURAÇÃO NÃO INTERFIRA *}
      {* NO LIMITE DE CRÉDITO, VAI ENTRAR  *}
      {* APENAS AS DEVOLUÇÕES DEFINITIVAS, *}
      {* POIS FOI GERADO CTR.              *}
      {**********************************AF*}

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + '  AND C.CHQ_DTADEV IS NOT NULL ';
      strSQL := strSQL + '  AND C.CHQ_DTADP2 IS NULL ';
      strSQL := strSQL + '  AND C.CHQ_DTADV2 IS NULL ';

      If fCfgSis('CHQCCO') = 'S' Then
        strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';

    End
    Else If (typCon = tcChqLiquidados) Then  // Cheques Liquidados
    Begin
      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (C.CHQ_DTADEP IS NOT NULL AND C.CHQ_DTADEV IS NULL ' + strChqNaoRepassado + ') OR ';
      strSQL := strSQL + '      (C.CHQ_DTADEV IS NOT NULL AND C.CHQ_DTADV2 IS NOT NULL ' + strChqNaoRepassado + ') ';

      if blnConsChqRepassadoNaoVenc then
        strSQL := strSQL + '    OR (C.CHQ_CTADEP = "REPASSE" AND CHQ_DTAVEN < CURDATE())  ';

      strSQL := strSQL + ' ) ';

      strSQL := strSQL + '  AND IFNULL(C.CHQ_TELCHE, "N") <> "S" ';
      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
    End
    Else If (typCon = tcChqDevolvidosLiq) Then  // Cheques Devolvidos Liquidados
    Begin
      {*************************************}
      {* CASO A CONFIGURAÇÃO NÃO INTERFIRA *}
      {* NO LIMITE DE CRÉDITO, VAI ENTRAR  *}
      {* APENAS AS DEVOLUÇÕES DEFINITIVAS, *}
      {* POIS FOI GERADO CTR.              *}
      {**********************************AF*}

      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + '  AND C.CHQ_DTADEP IS NOT NULL ';
      strSQL := strSQL + '  AND C.CHQ_DTADEV IS NOT NULL ';
      strSQL := strSQL + '  AND C.CHQ_DTADP2 IS NOT NULL ';
      strSQL := strSQL + '  AND C.CHQ_DTADV2 IS NULL ';

      If fCfgSis('CHQCCO') = 'S' Then
        strSQL := strSQL + ' AND C.CHQ_INCCTR = "N" ';

    End
    Else If (typCon = tcTeleChq) Then  // Telecheques
    Begin
      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '     ((C.CHQ_DTADEP IS NULL AND C.CHQ_DTADV2 IS NULL) OR ';
      strSQL := strSQL + '     (C.CHQ_DTADEP IS NOT NULL AND C.CHQ_DTADEV IS NOT NULL AND C.CHQ_DTADP2 IS NULL AND C.CHQ_DTADV2 IS NULL))) ';

      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_TELCHE = "S" ';
    End
    Else If (typCon = tcTeleChqLiq) Then  // Telecheques Liq
    Begin
      //Somente das empresas que o operador tem direito de acesso.
      If fCfgSis('EMREFN') = '1' Then
        strSQL := strSQL + '  AND C.CHQ_CODEMP IN (' + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';

      strSQL := strSQL + ' AND (';
      strSQL := strSQL + '      (C.CHQ_DTADEP IS NOT NULL AND C.CHQ_DTADEV IS NULL) OR ';
      strSQL := strSQL + '      (C.CHQ_DTADEV IS NOT NULL AND C.CHQ_DTADV2 IS NOT NULL)) ';

      strSQL := strSQL + '  AND C.CHQ_INCCTR = "N" ';
      strSQL := strSQL + '  AND C.CHQ_TELCHE = "S" ';
    End;

    strSQL := strBase + strSQL;
  End;

  Result := strSQL;
End;

function fGetSqlPedidosEmAberto(blnCodRed: Boolean = False;
                                AExcetoFormasDePagamento: String = ''): String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE     ';

  {Adiantamentos}
  Result := Result + '  (SELECT ';
  Result := Result + '    SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, - ADT_VALLAN)) ';
  Result := Result + '  FROM ';
  Result := Result + '    ADTCLI ';
  Result := Result + '  WHERE ';
  Result := Result + '    ADT_NUMDOC = FGO_NUMDOC AND ';
  Result := Result + '    ADT_ESPDOC = FGO_ESPDOC AND ';
  Result := Result + '    ADT_CODEMP = FGO_CODEMP) AS VALADT, ';

  {Total em aberto ((-) Adiantamentos)}
  Result := Result + '  ( ';
  Result := Result + '  IFNULL(SUM( ';
  Result := Result + '    (FDO_QTDITE - FDO_QTDBAI) * ( ';
  Result := Result + '      ( ';
  Result := Result + '        FDO_TOTITE + FDO_VALIPI + FDO_VALRET + FDO_VALFCP + FDO_TOTFRE + FDO_DESACE' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP ';
  Result := Result + '      ) / FDO_QTDITE ';
  Result := Result + '    ) ';
  Result := Result + '  ), 0) ';
  Result := Result + '  - ';
  Result := Result + '  (SELECT ';
  Result := Result + '    IFNULL(SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN, - ADT_VALLAN)), 0) ';
  Result := Result + '  FROM ';
  Result := Result + '    ADTCLI ';
  Result := Result + '  WHERE ';
  Result := Result + '    ADT_NUMDOC = FGO_NUMDOC AND ';
  Result := Result + '    ADT_ESPDOC = FGO_ESPDOC AND ';
  Result := Result + '    ADT_CODEMP = FGO_CODEMP) ';
  Result := Result + '  ) AS TOTABE, ';

  Result := Result + '  FGO_DTAENT AS DTAENT, ';
  Result := Result + '  FGO_PREVIS AS PREVIS, ';
  Result := Result + '  CONCAT(FGO_NUMDOC, "-", FGO_ESPDOC, "-", FGO_CODEMP) AS NUMDOC, ';
  Result := Result + '  CONCAT(FGO_CODEMP, " - ", EMP_NOMEMP, " ") AS NOMEMP, ';
  Result := Result + '  FGO_CODVEN AS CODVEN, ';
  Result := Result + '  FGO_CONPAG AS CONPAG, ';
  Result := Result + '  SUM( (FDO_QTDITE - FDO_QTDBAI) *  ';
  Result := Result + '      ((FDO_TOTITE + FDO_VALIPI + FDO_VALRET + FDO_VALFCP + FDO_TOTFRE + FDO_DESACE' + fSqlValorReformaFdoRef('FATDOR.AUTOINCREM') + ' - FDO_DESESP) / FDO_QTDITE) ) AS VLRCON ';
  Result := Result + 'FROM     ';
  Result := Result + '  FATDOR ';
  Result := Result + '  LEFT  JOIN EXTDOR ON EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ';
  Result := Result + '  INNER JOIN FATGOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
  Result := Result + '  INNER JOIN CADEMP ON FATGOR.FGO_CODEMP = CADEMP.EMP_CODEMP ';
  Result := Result + '  INNER JOIN CADCLI ON FDO_CODCLI = CLI_CODCLI ';
  Result := Result + '  LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = FATGOR.AUTOINCREM ';
  Result := Result + 'WHERE                         ';
  if blnCodRed then
    Result := Result + '  CLI_CODRED = :CODRED    AND '
  else
    Result := Result + '  FDO_CODCLI = :CODCLI    AND ';
  Result := Result + '  FDO_ESPDOC = "PD"       AND ';
  Result := Result + '  FDO_JAFATU = 0          AND ';
  Result := Result + '  FDO_QTDBAI < FDO_QTDITE AND ';
  Result := Result + '  IFNULL(E.FGO_LOC_PD, "N") <> "S" AND ';
  Result := Result + '  LOCATE(FDO_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  if not AExcetoFormasDePagamento.Trim.IsEmpty then
   Result := Result + ' AND FGO_CODFPG NOT IN (' + AExcetoFormasDePagamento + ') ';
  Result := Result + 'GROUP BY      ';
  Result := Result + '  FDO_SEQGER  ';
end;

function fTotalPedidosEmAberto(const strCodCli, strCodRed: String;
                               var intQtdPed  : Integer;
                               blnSubtraiAdts : Boolean = False;
                               AExcetoFormasDePagamento: String = ''): Double;
  Var
    qryGen: TUniquery;
begin
  qryGen := fCriaQuery;

  qryGen.Close;
  qryGen.SQL.Clear;

  If Not blnSubtraiAdts Then
    qryGen.SQL.Add('SELECT SUM(VLRCON) AS TOTPED, COUNT(*) AS QTDPED FROM ')
  Else
    qryGen.SQL.Add('SELECT (SUM(VLRCON) - SUM(IFNULL(VALADT, 0))) AS TOTPED, COUNT(*) AS QTDPED FROM ');

  qryGen.SQL.Add('(' + fGetSqlPedidosEmAberto(not fEmptyStr(strCodRed), AExcetoFormasDePagamento) + ') AS PEDIDOS ');

  if not fEmptyStr(strCodRed) then
    qryGen.ParamByName('CODRED').AsString := strCodRed
  else
    qryGen.ParamByName('CODCLI').AsString := strCodCli;

  qryGen.Open;

  Result    := qryGen.FieldByName('TOTPED').AsFloat;
  intQtdPed := qryGen.FieldByName('QTDPED').AsInteger;

  FreeAndNil(qryGen);
end;

function fGeraCodBarraEAN13(strCodigo: String): String;
  Var
    intContador: Integer;
    intSomaPar: Integer;
    intSomaImp: Integer;
    intTotal: Integer;
    intMultiplo: Integer;
    intResto: Integer;
begin

  Result := '';
  If (Length(strCodigo) <> 12) Then
  Begin
    Exit;
  End;

  intSomaPar := 0;
  intSomaImp := 0;

  For intContador := 1 To Length(strCodigo) Do
  Begin
    If intContador Mod 2 = 0 Then
      intSomaPar := intSomaPar + StrToIntDef(strCodigo[intContador], 0)
    Else
      intSomaImp := intSomaImp + StrToIntDef(strCodigo[intContador], 0);
  End;
  intSomaPar := intSomaPar * 3;
  intTotal   := intSomaPar + intSomaImp;
  intResto   := intTotal Mod 10;

  If intResto =  0 Then
    intMultiplo := intTotal
  Else
    intMultiplo := intTotal + (10 - (intResto));

  Result := strCodigo + IntToStr(intMultiplo - intTotal);

end;

procedure pCarregaDuplicatasCND(intTabela:Integer; strAutoincrem:String; var arrDuplicataCND: TarrDuplicata);
var
  strSQL: String;
  qryCND: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  intIndex: Integer;
Begin
  Case intTabela of
    1:Begin
        strSQL := 'SELECT FGO_PARCEL AS PARCEL, FGO_VALPAR AS VALPAR FROM GORCND '+
                  'INNER JOIN FATGOR ON FGO_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY FGO_PARCEL ';
      End;
    2:Begin
        strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM GERCND '+
                  'INNER JOIN MOVGER ON GER_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY GER_PARCEL ';
      End;
    3:Begin
        strSQL := 'SELECT GER_PARCEL AS PARCEL, GER_VALPAR AS VALPAR FROM NOTCND '+
                  'INNER JOIN NOTGER ON GER_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY GER_PARCEL ';
      End;
    4:Begin
        strSQL := 'SELECT PRE_PARCEL AS PARCEL, PRE_VALPAR AS VALPAR, PRE_DTAVEN AS DTAVEN '+
                  ' FROM PRECND INNER JOIN GERELE ON PRE_SEQGER = AUTOINCREM '+
                  'WHERE AUTOINCREM = :AUTOINCREM '+
                  'ORDER BY PRE_PARCEL ';
      End;
  End;

  Try
    qryCND := fCriaQuery;

    FillChar(arrDuplicataCND, SizeOf(arrDuplicataCND), #0);

    with qryCND, SQL do
    Begin
      Clear;
      Add(strSQL);
      ParamByName('AUTOINCREM').AsString := strAutoincrem ;
      Open;

      intIndex := 0;
      While not eof do
      Begin
        arrDuplicataCND[intIndex].strSequen := FieldByName('PARCEL').AsString;
        arrDuplicataCND[intIndex].curValor  := fFormataFloat(FieldByName('VALPAR').AsFloat, 2);
        If intTabela = 4 Then
          arrDuplicataCND[intIndex].dtaDtaVen := DateToStr(FieldByName('DTAVEN').AsDateTime);
        Inc(intIndex);

        Next;
      End;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(qryCND);
{$ENDIF LINUX}
  End;
End;

function fCalcVolumes(strCodIte: String; fltQtdIte, fltEmbala: Double): Double;
Var
  strVolEmb: String;
  fltMltVen: Double;
  fltMltCom: Double;
Begin
  Result := 0;
  strVolEmb := fCfgSis('TIPVOL');

  If strVolEmb = '1' Then
  Begin
    If fltEmbala <= 0 Then
      fltEmbala := 1;

    Result := Result + Ceil(fltQtdIte / fltEmbala);
  End
  Else If strVolEmb = '2' Then
  Begin
    fltMltVen := fRetMltVenItem(strCodIte);

    If fltMltVen <= 0 Then
      fltMltVen := 1;

    Result := Result + Ceil(fFormataFloat(((fFormataFloat((fltQtdIte / fltMltVen), 4) * fFormataFloat((1 - fltMltVen), 4)) + fltQtdIte), 4));
  End
  Else If strVolEmb = '3' Then
  Begin
    fltMltVen := fRetMltVenItem(strCodIte);
    fltMltCom := fRetMltComItem(strCodIte);

    If fltMltVen <= 0 Then
      fltMltVen := 1;

    If fltMltCom <= 0 Then
      fltMltCom := 1;

    Result := Result + Ceil(Trunc(fltQtdIte / fltMltCom) + ((fltQtdIte - (Trunc(fltQtdIte / fltMltCom) * fltMltCom)) / fltMltVen));
  End;
End;

function fRetMltVenItem(Const strCodIte: String): Double;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_MLTVEN ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_MLTVEN').AsFloat
      Else
        Result := 0;

      Close;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function fRetMltComItem(Const strCodIte: String): Double;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_MLTCOM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('ITE_MLTCOM').AsFloat
      Else
        Result := 0;

      Close;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function fPermiteFaturamentoEntrega(strCodCli: String; strCampoDiaMes, strCampoDiaSemana: String; dtaData: TDateTime): Boolean;
  Var
    strDiaMes : String;
    strDiaSem : String;
    intCnt : Integer;
    intDiaSem : Integer;
begin
  Result := True;

  If (Not fCfgSis('UTDTFE', varBoolean)) Then
    Exit;

  strDiaMes := fCampoTabela(strCampoDiaMes, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
  strDiaSem := fCampoTabela(strCampoDiaSemana, 'CADCLI', ['CLI_CODCLI'], [strCodCli]);

  strDiaSem := fPadR(strDiaSem, 7, 'N');
  intDiaSem := DayOfWeek(dtaData);

  For intCnt := 1 To 7 Do
  Begin
    If (intDiaSem = intCnt) Then
    Begin
      Result := (strDiaSem[intCnt] = 'S');
      Break;
    End;
  End;

  If (Result) Then
    Result := fTransform(strDiaMes, 2).Contains(fStrZero(DayOf(dtaData), 2));
End;

function fDocumentoTravado(strTabela, strNumDoc, strEspDoc, strCodEmp, strCodCli: String): Boolean;

  function fChaLck(strTab: String; strCli: String): String;
  begin
    Result := strTab + strNumDoc + strEspDoc + strCodEmp + strCli;
  end;
begin
  Result := False;

  If Not fEmptyStr(fGetHostLock(fChaLck(strTabela, ''))) Then
  Begin
    Result := True;
    fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(fChaLck(strTabela, '')), ['&OK']);
  End;
end;

procedure pCriarModuloLegenda;
Begin
  If Not Assigned(frmModuloLegenda) Then
  Begin
    pCriarModulo(TfrmModuloLegenda, TDataModule(frmModuloLegenda));
  End;
End;

function fGetLetraAlfa(intCol: Integer): String;
  Var
    strLetra : String;
    intLetra1: Integer;
    intLetra2: Integer;
    fltValor : Double;
begin
  strLetra := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  If intCol > 26 Then
  Begin
    fltValor  := (intCol / 26);
    intLetra1 := fFloatToInt(fltValor - Frac(fltValor));
    intLetra2 := fFloatToInt(intcol Mod 26);

    If intLetra2 = 0 Then
    Begin
      Dec(intLetra1);
      intLetra2 := 26;
    End;

    Result    := strLetra[intLetra1] + strLetra[intLetra2];
  End
  Else
    Result   := strLetra[intCol];

end;

function fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

Function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

function fVerificaLCKATCNomeParcial(const AstrNomeTrava: String): Boolean;
var
  LqryVerifica: TUniQuery;
begin
  LqryVerifica := fCriaQuery;
  try
    LqryVerifica.Close;
    LqryVerifica.SQL.Clear;
    LqryVerifica.SQL.Add('SELECT LCK_CON_ID FROM LCKATC WHERE LCK_CHAACE LIKE :LCK_CHAACE');
    LqryVerifica.ParamByName('LCK_CHAACE').AsString := '%' + AstrNomeTrava + '%';
    LqryVerifica.Open;

    Result := not LqryVerifica.IsEmpty;
  finally
    FreeAndNil(LqryVerifica) ;
  end ;
end ;

function fTime(const AForceTime: Boolean = False) : TDateTime;
begin
  If (AForceTime) Or (Not Assigned(frmModulo)) Then
    Result := untHorarioSistema.GetTime()
  Else
    Result := untHorarioSistema.GetTime(VS_strCodEmp, frmModulo.GetCurrentConnection);
end;

procedure pLogStartFireDac(const objConexao: IConnection) ;
begin
  //
end ;

procedure pLogRollbackFireDac(const objConexao: IConnection) ;
begin
  //
end ;

procedure pLogCommitFireDac(const objConexao: IConnection) ;
begin
  //
end ;

function fRemoveCaracterNulo(AString: String): String;
var
  s: String;
begin
  s := AString;

  While Pos(#0, s) > 0 Do
    Delete(s, Pos(#0, s), 1);

  Result := s;
end;

function fRemoveBarraInvertidaFinalDaLinha(strText: String): String;
begin
  Result := strText;
  If RightStr(Trim(strText),1) = '\' Then
    Result := strText + ' ';
end;

function fFloatToSQL(fltValor: Double): String;
begin
  Result := FormatFloat(fMskDigitos(4),fltValor);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,',','.',[rfReplaceAll]);
end;

function fEnviaWhatsappParaCliente(strCodCli: String; blnExibeMsg: Boolean = False): Boolean;
begin
  Result := True;
  try
    if not fCfgSis('UTIWPP', varBoolean) then
    begin
      blnExibeMsg := False;
      Exit(False);
    end;

    if (fCfgSis('WHACLI', varBoolean)) and (fCampoTabela('CLI_RECWPP', 'CADCLI', ['CLI_CODCLI'], [strCodCli]) = 'N') then
      Exit(False);
  finally
    if (not Result) and (blnExibeMsg) then
      fMensagem('Aviso', 'Este cliente está configurado para não receber mensagens via Whatsapp!', ['&O k']);
  end;
end;

function RetornaValorJson(AObjeto: TJsonObject;
  ANomeCampo: String): String;
begin
  Result := EmptyStr;

  If Not Assigned(AObjeto) Then
    Exit;

  If AObjeto.GetValue(ANomeCampo) <> Nil Then
    Result := AObjeto.GetValue<string>(ANomeCampo);
end;

function RetornaValorJsonValue(AObjeto: TJsonValue;
  ANomeCampo: String): String;
begin
  If Not Assigned(AObjeto) Then
    Exit(EmptyStr);

  If Not AObjeto.TryGetValue<String>(ANomeCampo, Result) Then
    Result := EmptyStr;
end;

function TryFileExists(AFile: string): Boolean;
begin
  Result := FileExists(AFile);
end;

function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
begin
  Result := TfrmGravando.fExecutarModalA(prcGen, strTexto, strChave);
end;

function fExecutarModal(const funcExecucao: TReferenceFunctionProgresso; const strTexto, strChave: string): Boolean;
begin
  Result := TfrmGravando.fExecutarModalA(funcExecucao, strTexto, strChave);
end;

function fRetFantasiaEmpresa(strCodEmp: String = ''): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMFAN  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (fEmptyStr(strCodEmp)) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;
      Result := FieldByName('EMP_NOMFAN').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fGetVersaoAutcom: String;
var
  LQuery: TUniQuery;
begin
  LQuery := fCriaQuery;
  try
    LQuery.SQL.Add('SELECT ');
    LQuery.SQL.Add('  LOG_VERPRO ');
    LQuery.SQL.Add('FROM ');
    LQuery.SQL.Add('  (SELECT ');
    LQuery.SQL.Add('    LOG_VERPRO, ');
    LQuery.SQL.Add('    COUNT(0) AS QTD ');
    LQuery.SQL.Add('  FROM ');
    LQuery.SQL.Add('    LOGACE ');
    LQuery.SQL.Add('  WHERE LOG_DTAENT >= CURRENT_DATE - 3 ');
    LQuery.SQL.Add('    AND LOG_NOMEXE = "AUTCOM.EXE" ');
    LQuery.SQL.Add('    AND LOG_CODOPE NOT IN ("999", "998", "997", "AUT") ');
    LQuery.SQL.Add('    AND LOG_VERPRO <> "999.999.999.999" ');
    LQuery.SQL.Add('  GROUP BY LOG_NOMEXE, ');
    LQuery.SQL.Add('    LOG_VERPRO ');
    LQuery.SQL.Add('  ORDER BY QTD DESC ');
    LQuery.SQL.Add('  LIMIT 1) AS T ');
    LQuery.Open;
    Result := LQuery.FieldByName('LOG_VERPRO').AsString;
  finally
    FreeAndNil(LQuery);
  end;
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

function fClienteProfissional(strCodCli: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE    ';
    strSQL := strSQL + '  DIV_CODDIV           ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CADDIV               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  DIV_CODCLI = :CODCLI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      If IsEmpty Then
        Result := False
      Else
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function GeraUUIDVersao4: String;
  Var
    LObjetoUUID: TGUID;

    LUUIDString: String;
Begin
  Result := EmptyStr;

  Try
    Result := fCampoTabela('uuid_v4s()', 'DUAL', [], []);
  Except
    CreateGUID(LObjetoUUID);

    LUUIDString := GUIDToString(LObjetoUUID);

    If Not LUUIDString.IsEmpty Then
      Result := LUUIDString.Replace('{', EmptyStr)
                           .Replace('}', EmptyStr);
  End;
End;

function fUtilizarStatusDeSeparacaoEConferencia : Boolean;
  Var
    strValCfg : String;
begin
  Result := False;
  strValCfg := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_UTSCNF', VS_strCodEmp], False);
  If (fEmptyStr(strValCfg)) Then
    Exit;
  If (fCfgSis('BAISEP', varString) = 'S') Then
    Exit;
  Result := (strValCfg = 'S');
end;

function fUtilizaRestApiBoletoDLL: Boolean;
begin
 {$IFDEF LINUX}
  Result := False;
 {$ELSE}
  Result := fCfgSis('DLLBOL', varBoolean);
 {$ENDIF}
end;

function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
begin
  //não implementado
  Result := True;
end;

function fValidarEnderecoEmail(strEmail: String): Boolean;
  Const
    atom_chars = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                                '\', '/', '"', '.', '[', ']', #127];

    quoted_string_chars = [#0..#255] - ['"', #13, '\'];

    letters = ['A'..'Z', 'a'..'z'];
    letters_digits = ['0'..'9', 'A'..'Z', 'a'..'z'];
    subdomain_chars = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

  Type
    States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
              STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
              STATE_SUBDOMAIN, STATE_HYPHEN);

  Var
    State: States;
    i, n, subdomains: integer;
    c: char;

begin
  State := STATE_BEGIN;

  n := Length(strEmail);
  i := 1;
  subdomains := 1;

  while (i <= n) do begin
    c := strEmail[i];

    case State of
    STATE_BEGIN:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_ATOM:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else if not (CharInSet(c, atom_chars)) then
        break;

    STATE_QTEXT:
      if c = '\' then
        State := STATE_QCHAR
      else if c = '"' then
        State := STATE_QUOTE
      else if not (CharInSet(c, quoted_string_chars)) then
        break;

    STATE_QCHAR:
      State := STATE_QTEXT;

    STATE_QUOTE:
      if c = '@' then
        State := STATE_EXPECTING_SUBDOMAIN
      else if c = '.' then
        State := STATE_LOCAL_PERIOD
      else
        break;

    STATE_LOCAL_PERIOD:
      if CharInSet(c, atom_chars) then
        State := STATE_ATOM
      else if c = '"' then
        State := STATE_QTEXT
      else
        break;

    STATE_EXPECTING_SUBDOMAIN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else
        break;

    STATE_SUBDOMAIN:
      if c = '.' then begin
        inc(subdomains);
        State := STATE_EXPECTING_SUBDOMAIN
      end else if c = '-' then
        State := STATE_HYPHEN
      else if not (CharInSet(c, letters_digits)) then
        break;

    STATE_HYPHEN:
      if CharInSet(c, letters_digits) then
        State := STATE_SUBDOMAIN
      else if c <> '-' then
        break;
    end;

    inc(i);
  end;

  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (subdomains >= 2);
end;

function fValidarEmail(strEmail: String; blnExibeAlerta: Boolean = True;
  strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False;
  blnEmailNfe: Boolean = True): Boolean;
  var
    i: Integer;
    stlEmails: TStringList;
begin
  Result := True;

  Try
    stlEmails := TStringList.Create();

    If (Pos(';', strEmail) > 0) Or ((Pos(',', strEmail) > 0)) Then Begin
      If (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ';') Or
        (Copy(Trim(strEmail), Length(Trim(strEmail)), 1) = ',') Then
        stlEmails.CommaText := AnsiReplaceStr(Copy(Trim(strEmail), 1, Length(Trim(strEmail)) - 1), ';', ',')
      Else
        stlEmails.CommaText := AnsiReplaceStr(Trim(strEmail), ';', ',');
    End Else Begin
      stlEmails.Add(Trim(strEmail));
    End;

    For i := 0 To stlEmails.Count - 1 Do Begin
      If fEmptyStr(stlEmails[i]) And (Not blnPermiteEmBranco) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+'!', ['&OK']);
        End;

        Result := False;
      End Else If (Not fEmptyStr(stlEmails[i])) And (Not fValidarEnderecoEmail(stlEmails[i])) Then Begin
        IF blnExibeAlerta Then Begin
          If (blnEmailNfe) Then
            fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe corretamente!', ['&OK'])
          Else
            fMensagem('', 'Informe o '+strTitEmail+' corretamente!', ['&OK']);
        End;

        Result := False;
      End;
    End;
  Finally
    FreeAndNil(stlEmails);
  End;
end;

function fFaturadorAutomaticoJaBaixouEtiquetaMarketplace(const ANumDoc, AEspDoc, ACodEmp, ACodCli, APrefix, strPathEtiqueta: string): Boolean;
begin
  Result := False;
end;

function fEhArquivoBase64(const AstrArquivo: String): Boolean;
begin
  Result := fEmptyStr(ExtractFileExt(AstrArquivo));
end;

function fModoDeDesenvolvimento: Boolean;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  Result := ((DebugHook <> 0) or IsDebuggerPresent);
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure pNotificaFormGravandoAtivo(const strMessage : String);
  Var
    intCnt: Integer;
    lblMensagem : TComponent;
begin
  For intCnt := Screen.FormCount -1 Downto 0 Do
  Begin
    If (Screen.Forms[intCnt].Name = '') Then
      Continue;
    If (Pos('frmGravando', Screen.Forms[intCnt].Name) > 0) Then
    Begin
      lblMensagem := Screen.Forms[intCnt].FindComponent('lblGravando');
      If (lblMensagem <> Nil) And (lblMensagem Is TLabel) Then
      Begin
        TLabel(lblMensagem).Caption := strMessage;
        pProcessMessages(True);
      End;
    End;
  End;
end;

function fRetornarArquivoBase64(const ACaminhoArquivo: String): String;
  Var
    LArquivo: TFilestream;
Begin
  Result := EmptyStr;

  LArquivo := nil;

  if fEmptyStr(ACaminhoArquivo) then
    Exit;

  Try
    LArquivo := TFileStream.Create(ACaminhoArquivo, fmOpenRead or fmShareDenyNone);
    Result := TIdEncoderMIME.EncodeStream(LArquivo);
  Finally
    FreeAndNil(LArquivo);
  End;
End;

procedure FreeAndNilDatasets(var ADataset);
Begin
  If Not Assigned(TObject(ADataset)) Then
    Exit;

  If Not (TObject(ADataset) is TDataset) Then
    Raise EInvalidCast.Create('FreeAndNilDatasets: parâmetro não é TDataset');

  Try
    TDataset(ADataset).Close;
  Finally
    FreeAndNil(ADataset);
  End;
End;
function fSomarNovosImpostosDaReformaAoValorContabil : Boolean;
begin
  // Copia de untFuncoesGenerica.fSomarNovosImpostosDaReformaAoValorContabil (padra_atualizado)
  Result := False;
  If fCfgSis('REFCIS', varString) = 'N' Then
    Exit;
  If (fCfgSis('SIMPAU', varString) = 'S') And (fCfgSis('SIMHIB', varString) = 'N') Then
    Exit;
  Result := True;
end;

function fSqlValorReformaFdoRef(const AAutoincrementoFatDor: String): String;
begin
  // Parcela de CBS + IBS + IS do item do pedido, como gravada pela trigger no FDOREF
  Result := '';
  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  Result := ' + (SELECT IFNULL(SUM(IFNULL(R.REF_CBSVAL, 0) + IFNULL(R.REF_VALIBS, 0) + IFNULL(R.REF_SELVAL, 0)), 0) ' +
            'FROM FDOREF R WHERE R.REF_SEQFDO = ' + AAutoincrementoFatDor + ') ';
end;

function fSqlValorReformaMovRef(const AAutoincrementoMovDet: String): String;
begin
  // Parcela de CBS + IBS + IS do item do documento, como gravada na MOVREF
  Result := '';
  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  Result := ' + (SELECT IFNULL(SUM(IFNULL(R.REF_CBSVAL, 0) + IFNULL(R.REF_VALIBS, 0) + IFNULL(R.REF_SELVAL, 0)), 0) ' +
            'FROM MOVREF R WHERE R.REF_SEQGER = ' + AAutoincrementoMovDet + ') ';
end;


initialization

  FDicTabelaReplica := TDictionary<String, Boolean>.Create;
  FMREWSTabelaReplica := TMultiReadExclusiveWriteSynchronizer.Create;

  VS_intTamDocCadRec := 0;
  VS_Error_you_are_sending_too_many_mails_slow_down := False;

  EnableUniSQL := False;

  cdsTabNRE := nil;

  VS_EXECUTAR_TESTE_LOG_REPLICACAO := False;
  VS_blnGravaLogTransacao := true;
  VS_blnExitMonitor := False;

  VS_TRANSACAO_LIMITE_SEGUNDOS := 30;

  dicConfiguracoes := TDictionary<string,string>.Create;
  VS_dtaIdentiTransacao := TStringList.Create;
  VS_TimerTransacao := TTimerTransacao.Create(nil);
  VS_TimerTransacao.Enabled := False;
  untFuncoesSimples.VS_objTemFecMes := Nil;

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

  blnErroLogRep := False;
  strErroLogRep := '';
  blnTransferindoCodigo := False;
  VS_AutoatendimentoPagueFacil := False;

  VS_strTxjCni := fArqIni(0, 'GERAL', 'TXJCNI', '');
  VS_strClaDev := '' ;

  untFuncoesSimples.VS_objTraceViewer := nil;

  VS_intTamCadIte := 0;
  VS_intTamCadLse := 0;
  VS_LastConnID := '';
  listValidaProcod := TList<String>.Create;

finalization
  FreeAndNil(VS_TimerTransacao);
  FreeAndNil(VS_dtaIdentiTransacao);
  FreeAndNil(dicConfiguracoes);
  If Assigned(VS_EmailTiposErro) Then
    FreeAndNil(VS_EmailTiposErro);

  If Assigned(FDicTabelaReplica) Then
    FreeAndNil(FDicTabelaReplica);

  If Assigned(FMREWSTabelaReplica) Then
    FreeAndNil(FMREWSTabelaReplica);

  If Assigned(cdsTabNRE) Then
    FreeAndNil(cdsTabNRE);

  FreeAndNil(listValidaProcod);
end.

