{**********************************************************************************************}
{* Interface que representa o AutcomTinta.dll e suas funções, assim a dll da tinta especifica *}
{* não precisa conhecer todas as implementações das funções usadas na dll autcomtinta, com    *}
{* isso a dll especifica da tinta fica com um tamanho menor                                   *}
{*******************************************************************************************PH*}
unit untIAutcomTintaWrapper;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Functions.DataSet,
{$ELSE}
  UniClientDataSet, EditFocus, DBEditFocus, Controls, Forms,
{$ENDIF}
  untIConfTinta, untIDataSet, untIConsultaTinta, untITintadeMaquinaWrapper, untIDicionario,
  untTipoCadastro, Classes, DB, Uni, untTypesSistema;

type
  IAutcomTintaWrapper = interface
    ['{4744AF1A-CCE4-43F7-B0F1-B8DAAB60C274}']
    function fGetConfTinta(const strIdePro: String): IConfTinta;
    function fGetDataSet: IDataSet;
    function fCfgSis(const strCamCfg: String; const varTipVar: TVarType = varString; const strCodEmp: String = ''): Variant;
    function fArqIniTinta(const ReadWrite: Integer; const NomChave, NomSecao, Conteudo: String): String;
    function GetCodEmp(): String;
    function GetUsuarioLogado(): string;
    function GetUsuarioUtilizaTemaClassico(): Boolean;
    {$IFNDEF LINUX}
    function GetObjTraceViewer(): ITraceViewer;
    function GetTituloVersao(): String;
    {$ENDIF}
    function fCalculaPrecoCusto2(const dicDados: IDicionario): Double;
    function GetIConsultaTinta(const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): IConsultaTinta;
    {$IFNDEF LINUX}
    function fConsultaDinamica(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaGeral(const Sender: TObject; const tintadeMaquinaWrapper: ITintadeMaquinaWrapper): String;
    function fConsultaDinamicaVenda(const Sender: TObject; const strTabPre: String;
      const tintadeMaquinaWrapper: ITintadeMaquinaWrapper; blnFaturamento, blnPermiteTab: Boolean; dicRetorno: IDicionario; sltItems: TStringList): String;
    {$ENDIF}
    {$IFDEF LINUX}
    function ExecutarQueryEmCache(qryGen: TUniQuery): IMyCampoTabela; overload;
    function ExecutarQueryEmCache(qryGen: IDataSet): IMyCampoTabela; overload;
    procedure WriteError(AText: string);
    procedure WriteLog(AText: string);
    {$ENDIF}
    procedure pMensagensErro(const MensErro, LocalErro: String; const strMensagem: String = '');
    procedure pGravarErro(const GravarErro:Boolean; const MensagemErro: String);
    procedure pAjudaAutcom(const Handle: THandle; const intNumHlp: Integer);
    function fRetNomProduto(Const strCodIte: String): String;
    function GetDicionario(): IDicionario;
    {$IFNDEF LINUX}
    function pConsultaComp(arrSql,
                           arrCampos,
                           arrOrdenacao: Array Of String;
                           strCampoChave,
                           strTabela,
                           strNomForm,
                           strTitulo: String;
                           var qryTabela: IDataSet;
                           arrSubConsultas,
                           arrSubConsultasCampos: array of String;
                           blnComSaldo: Boolean = False): Boolean;
    function fPesqGenericaTinta(var qryTabela: IDataSet;
                                strTabela: string;
                                strNomForm: string = '';
                                strTitulo: string = '';
                                strCamposRelacionado: string = '';
                                strFiltros: string = '';
                                blnComProduto: boolean = True): boolean;
    function fEntraCons(const strCodigo: String): Boolean;
    {$ENDIF}
    function fMensagem(const strTitulo: String; const strTexto: String; arrOpcoes: Array Of String;
      intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1; intWidBut: Integer = 0;
      intSomarTop: Integer = 0): Integer;
    function fRetAutoIncrem(const strNomeTabela: string; const strCodEmp: String): String;
    function GetInsert(const strTabela: string): string;
    function GetInsertDelayed(const strTabela: string): string;
    function fInsereProCod(const strNomTab: String; blnCodAut : Boolean = true): Boolean;
    function GetInToOr(const strNomeCampo: string; const strValores: string): string;

    function fLock_Unlock(strNomeTabela         : String;
                          blnTrava              : Boolean;
                          blnLoopTravamento     : Boolean = True;
                          blnHourGlass          : Boolean = false;
                          strCon_Id             : String = '';
                          blnMostraMsgTravamento: Boolean = True;
                          strOrigem             : String = ''): Boolean;

    function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;

    procedure pPreencherValorVenda(strCodIte : String; strCodEmp : String; var strVlrCusto, strValorMargem, strValorVenda: String);


    function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;

    procedure TruncateTable(const strNomeTabela: string);
    procedure DropTable(const strNomeTabela: string);
    procedure pValidaProCod(strNomeTabela: String);
    function fUsaProCodigo(strNomeTabela: String): Boolean;
    function fGetDescricaoProdutoTinta(const strCodIte: string; Tipo: TTipoCadastro): string;
    function GetValorCampo(const strSql: string; const strNomeCampo: string; const arrParametros: array of string; blnUsaCache: Boolean = False): Variant;
    function fCalculaPrecoVenda(intOpcPrecoMargem: Integer;
                              curPrecus,
                              curPreven,
                              curMarBru,
                              curIcmsVenda,
                              curImpFed,
                              curDesOpe,
                              curValCom: Currency;
                              strMarMkp: String = '';
                              strPcmPro: String = '';
                              intDecUni: Integer = -1): Double;
   {$IFNDEF LINUX}
    function fCriarProcesso(strArquivo: string; blnTrava: Boolean): boolean;
   {$ENDIF}
    function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
        intPrzMed: Integer; var fltPreCus, fltPreVen: Double; var blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
        strCodEmp: String = ''; fltPrecoTotalColorantes : Double = 0): Boolean;
    function fCalculaPrecoCompraLiq(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
        fltDesf04, fltDesf05, fltDesf06: Double; blnPreDol: Boolean = False): Double;
    function fCalculaPrecoCompraLiquido(fltPreCom, fltDesf01, fltDesf02, fltDesf03,
        fltDesf04, fltDesf05, fltDesf06: Double; blnPreDol: Boolean = False): Double;
    function fExisteValorNoCampo(valor: Variant; strCampo, strTabela: String; strCondicao: String = ''): Boolean;
    function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
    function fIsNumber(Const strNumber: String): Boolean;
    function fStrToFloat(strValorUnico: String): Double;
    function fSenderName(Const strName : String) : String;

    {$IFNDEF LINUX}
    function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
       blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False): Integer;
    {$ENDIF}

    function GetEmpBasDup: Boolean;
    function GetEmpBasDux: Boolean;
    function GetEmpBasDu2: Boolean;

    function fValidarBaseItemAmarracao(strIdePro : String; strCodBaseAtu : String; strDescBaseAtu : String ; strCodIte : String;
                                       strCoditeAnt : String; fltPesEsp : Double; fltEmbala : Double ) : Boolean;

    {$IFNDEF LINUX}
    function fDigSenVarTroDir(strNomeCli, strCpfCnpj, strCliCid, strVendedor, strIdepro,
      strDescTinta, strUnidade, strBaseAtual, strBaseNova, strDescAdicional: String) : Boolean;
    {$ENDIF}

    function fGravarLogLiberacaoBaseAutomotiva(Var strOperadorLiberou: String;
      strCodBas: String; strMensagem: String): Boolean;

    function fRemoveAcento(Str: String): String;

    procedure pEnviarLogRep(strCodite : string; strIdePro : string);

    procedure pReplicarFatorTintometrico(strSQL    : String;
                                         strCodIte : String);


    function fZerarCNV_ML( strCodite : String ;
                           strIdePro : string ) : Boolean;

    {$IFNDEF LINUX}
    function fRetirarEspacos(Sender: TObject): String;
    {$ENDIF}

    function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
    function fRetGrupoItem(strCodIte: String): String;
    function fCriaQuery(): TUniQuery; overload;
    function fCriaQuery(AOwner: TComponent): TUniQuery; overload;
    function fCriaQuery(AOwner: TComponent; Conexao: TUniConnection): TUniQuery; overload;
    function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
    function fFormataFloatSky(fltValor: Double): Double;

    function fTamCodIte: Integer;

    {$IFNDEF LINUX}
    Procedure pSetaCodIte(edtCodIte: TEditFocus); overload;
    Procedure pSetaCodIte(edtCodIte: TDBEditFocus); overload;
    Procedure pSetaCodIte(edtCodIte: TStringField); overload;
    procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
    {$ENDIF}

    function fRetornaTipoDoCampo( strTabela : string = ''; strCampo: string = '' ) : String;

    Function fMensagemTabela(strTitulo : String;
                           strTitCol   : String;
                           arrMensagem : TStringArray;
                           strTexto    : String;
                           arrOpcoes   : Array Of String;
                           intFocoBotao: Integer = 1;
                           blnSaiComEsc: Boolean = False;
                           intEstFon   : Integer = 1;
                           intWidBut   : Integer = 0;
                           blnAutosize : Boolean = False;
                           intSomarTop : Integer=0;
                           blnObrigaEsc: Boolean = False;
                           blnOcultPainelBtn: Boolean = False;
                           blnBtnSemImg: Boolean = False;
                           intHeightOpc: Integer = 0;
                           intHeightFrm: Integer = 0;
                           intWidthFrm: Integer = 0;
                           blnBtnOk: Boolean = False): Integer;

    procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
    procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False); overload;
    function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
    function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;
    function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
    function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal : Boolean = True; strEmpSalRes : String = ''): Boolean;
    function fSQLSaldoDisponivel(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): string;
    function fSQLSaldoFisico(): String;
    procedure pSetaEmpresaLogadaTinta(strEmpLog: String);
    function fTiraCaracEspeciaisPonto(strTexto: String): String;
    function fEhAdministrador(strCodOpe: String): Boolean;
    function fTabelaExiste(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
    procedure pTrimAppMemorySize();
    {$IFNDEF LINUX}
    function fNow: TDateTime;
    {$ENDIF}
    {$IFNDEF LINUX}
    procedure CriarNovasFormulasDllsGeneric(AClass: String);
    {$ENDIF}
  end;

implementation

end.

