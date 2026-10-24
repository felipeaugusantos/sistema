{*********************************************}
{***************** ATENÇÃO *******************}
{*********************************************}
{* AS FUNÇÕES COLOCADAS NESTA UNIT DEVEM     *}
{* ESTAR TAMBÉM EM ALGUMA DLL CASO CONTRARIO *}
{* COLOCAR A FUNÇÃO NA UNTFUNCOES            *}
{******************************************AF*}
unit untFuncoesSimples;

interface
{$WARN SYMBOL_PLATFORM OFF}

Uses
  Classes, Uni, Controls, SysUtils, StrUtils, Forms, Windows, PSAPI,
  IniFiles, Graphics, Messages, Dialogs, Buttons, StdCtrls, DBCtrls,
  Mask, DB, Printers, Themes, Consts, DBClient, untConstantes,
  Aurelius.Types.Nullable,

  System.Generics.Collections,

  Variants, ExtCtrls, ComCtrls, EditFocus, AnsiStrings, MMSystem,
   Grids, Menus, Math,
  RLReport, RLTypes, DateUtils, MaskUtils, Contnrs, TypInfo,
  WinSock, untIFuncoes, untInterfacedObjectNoCount, untTypesSistema,
  IdSMTP,IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, IdPOP3, IdSocks, IdMessage, ShellApi, WinSpool,

  RegularExpressions,

  untClassPanelCx, untIFuncoesCXGrid, untMensagemTabela,
  UniClientDataSet, DBGridCitel, DBGrids, Registry, MadExcept,
  untFuncoesGenerica, madStackTrace, BitBtnLockedIncrem, CheckLst,
  cxProgressBar, IdHashMessageDigest, IdHash,
  untICamposUso, untGTinForTipos, CRAccess, frxClass,
  Types, UniDataSetProvider, System.Win.ComObj, Xml.XMLDoc, Xml.XMLIntf,

  UniSQLMonitor, DASQLMonitor, DBAccess, CLRClasses, CRParser,
  MyParserUni, MyClassesUni, untCfgRepositorio, untICfgSis,
  ShlObj, untGravando, CAPICOM_TLB, DAScript, UniScript, Winapi.TlHelp32,
  DBEditFocus;

Type
  TpIniciaDllFuncoes = reference to procedure(
                              Conexao: TUniConnection;
                              strUsuario,
                              strEmpresa: String;
                              intDebugH: Byte;
                              objFuncoes: ICfgSis;
                              objTraceViewer: ITraceViewer;
                              dtaDate: TDate;
                              strComputerNetName,
                              strUserFromWindows,
                              strIPAddressAsString,
                              strMacAddress: String) stdcall;
Type
  TfGetFuncoesCxGrid = reference to function: IFuncoesCXGrid stdcall;

Type
  TfConsulta = reference to function(arrSql,
                                     arrCampos,
                                     arrOrdenacao: Array Of String;
                                     strCampoChave,
                                     strTabela,
                                     strNomForm,
                                     strTitulo: String;
                                     qryAux: TUniQuery;
                                     objFrmPnl: TPanelCx;
                                     blnSimples: Boolean;
                                     Var arrSelec: TConsultasArray;
                                     strCodBusca: String = 'AUTOINCREM';
                                     objConsulta: Pointer = Nil;
                                     blnTablet: Boolean = False;
                                     blnConIte: Boolean = False;
                                     strCampoChave2: String = '';
                                     pAfterAtualiza: TGenericProcedureWithClientParam = Nil;
                                     blnRefresh: boolean = True;
                                     blnConfirma: boolean = True;
                                     blnConCon: Boolean = True;
                                     fChamaCadastro : TBooleanFunctionWithBooleanParam = Nil;
                                     objPnlBanner: TPanelCx = Nil;
                                     objPnlPreFiltro: TPanelCx = Nil;
                                     _Application : TApplication = Nil;
                                     pBeforeAtualiza: TGenericProcedureWithClientParamAndVar = Nil): Boolean StdCall;

Type
  TRedimensiona = (rdAumenta, rdDiminui);

type
   TThreadDirectoryExists = class(TThread)
   public type
     ExceptionClass = Class Of Exception;
     TTestResult = (trNoDirectory, trDirectoryExists, trTimeout);
   private
     FDirname: String;
     FErr    : String;
     FErrclass: ExceptionClass;
     FResult : Boolean;
   protected
     procedure Execute; override;
   public
     Function TestForDir( const dirname: String; timeoutMSecs: Dword): TTestResult;
   end;

Type
  TAcaoTransacao = (opStart, opCommit, opRollback);

  TTipoCampo = (tcEmail1, tcEmail2);
  TOrigemValidacao = (ovCadCli, ovCadEndEnt, ovFaturamento);


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
  TInfLckAtc = Record
    strNum_IP,
    strCon_ID,
    strChaAce,
    strCodOpe: String;
    intTentat: Integer;
    dtaDtaLck,
    dtaHraLck,
    dtaDtaHraLck: TDateTime;
End;




Type
  TRecInfoImpressaoOPTinta = Record
    strMontad,
    strMarTin,
    strDesemb,
    strVariac: String;
    fltVolPro: Double;
    blnImobil: Boolean;
    blnColEmb: Boolean; //Colorante possui embalagem no cadcol
  End;




Type
  TRecModulosAutcom = Record
    Banco       : TUniConnection;
End;

Type
  TArrImpressaoCP = Record
    strNumDup,
    strParcel,
    strCodFor,
    strSerie_,
    strNomFrm: String;
  End;

{*****************************************}
{* ESTRUTURA USADA NA ALTERACAO GLOBAL   *}
{**************************************MV*}
Type
  TCampoGlobal = Record
    strDesCam: String;
    strProper: String;
    varValCam: Variant;
    strMasCam: String;
    strNomCam: String;
    strDesAbr: String;
    strOrigem: String;
    intLimCam: Integer;
    strTipCam: String;
    strNomArq: String;
    fltCnvCus: Double;
  End;

{*****************************************}
{* ESTRUTURA USADA NA ALTERACAO GLOBAL   *}
{**************************************PZ*}
Type
  TCampoExp = Record
    strDesCam: String;
    strNomCam: String;
  End;

{************************************}
{* RECORD PARA CAMPOS DE UMA TABELA *}
{*********************************EL*}
Type
  TDefCampos = Record
    strNomCam: String;
    strDesCri: String;
    ftpTipCam: TFieldType;
    intTamCam: Integer;
    blnVisible: Boolean;
    strFormat: String;
End;



  TColunasArray = Array Of String;
  TMascaraArray = Array Of String;

  Type
  {*****************************************}
  {* REPRESENTA AS ULTIMAS CONSULTAS REA-  *}
  {* LIZADAS PELO SISTEMA                  *}
  {**************************************MV*}
  TUltConsultas = class(TInterfacedObjectNoCount, IUltConsultas)
    private
      arrTabelas: Array Of String;
      arrComplChave: Array Of String;
      arrRegistros: Array Of TBookmark;
      arrSelects: Array Of String;
      arrIndices1: Array Of String;
      arrIndices2: Array Of String;
      arrIndices3: Array Of String;
      arrItemIndex: Array Of Integer;
      arrItemSaldo: Array Of Boolean;
      arrItemPromo: Array Of Boolean;

      FIndiceAtual: Integer;
      FEstado: TDataSetState;

      FTabela: String;
      FComplChave: String;
      FRegistro: TBookmark;
      FSelect: String;
      FIndice1: String;
      FIndice2: String;
      FIndice3: String;
      FItemIndex: Integer;
      FItemSaldo: Boolean;
      FItemPromo: Boolean;

    private

      procedure pChecarIntegridade;

      procedure SetEstado(dsEstado: TDataSetState);
      function GetEstado: TDataSetState;

      procedure SetTabela(strTabela: String);
      function GetTabela: String;

      procedure SetRegistro(bkmRegistro: TBookmark);
      function GetRegistro: TBookmark;

      procedure SetSelect(strSelect: String);
      function GetSelect: String;

      procedure SetIndice1(strIndice: String);
      function GetIndice1: String;

      procedure SetIndice2(strIndice: String);
      function GetIndice2: String;

      procedure SetIndice3(strIndice: String);
      function GetIndice3: String;

      procedure SetItemIndex(intItemIndex: Integer);
      function GetItemIndex: Integer;

      procedure SetItemSaldo(blnItemSaldo: Boolean);
      function GetItemSaldo: Boolean;

      procedure SetItemPromo(blnItemPromo: Boolean);
      function GetItemPromo: Boolean;

      procedure SetComplChave(strComplChave: String);
      function GetComplChave: String;
    public
      Constructor Create;
      Destructor Destroy; Override;

      procedure pLimparCampos;
      procedure Novo;
      procedure Grava;
      procedure Limpar(strNomeTabela: String; strComplChave: String = '');

      function fRetRegistro(Const strNomeTabela: String; strComplChave: String = '';
        blnAtualizaDados: Boolean = True): Boolean;

      property Estado: TDataSetState read GetEstado write SetEstado;
      property Tabela: String read GetTabela write SetTabela;
      property ComplChave: String read GetComplChave write SetComplChave;
      property Registro: TBookmark read GetRegistro write SetRegistro;
      property Select: String read GetSelect write SetSelect;
      property Indice1: String read GetIndice1 write SetIndice1;
      property Indice2: String read GetIndice2 write SetIndice2;
      property Indice3: String read GetIndice3 write SetIndice3;
      property ItemIndex: Integer read GetItemIndex write SetItemIndex;
      property ItemSaldo: Boolean read GetItemSaldo write SetItemSaldo;
      property ItemPromo: Boolean read GetItemPromo write SetItemPromo;
 End;

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

{*************************************************}
{* CLASSE QUE REPRENTA UM DICIONÁRIO ("HASH").   *}
{* AS CHAVES SÃO STRINGS, E OS VALORES PODEM     *}
{* SER DE QUALQUER TIPO SUPORTADO POR "VARIANT". *}
{* ISSO PERMITE QUE OS VALORES CONTENHAM VALORES *}
{* DE TIPOS VARIADOS. PODE SER FEITO A CHAVE     *}
{* COMO VARIANT (ESTOU COM PRESSA)               *}
{**********************************************MV*}
Type
  {***********************************}
  {* SUPER CLASSE AUXILIAR PARA      *}
  {* LIBERAÇÃO DE MEMÓRIA AUTOMÁTICA *}
  {********************************AF*}
  TObjectVariant = Class(TObject)
    varValor: Variant;
  public
    Constructor Create(valor: Variant);
  End;

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
End;

Type
  TPermissoesAcesso = class
    private
      FUsuarios: TDicionario;
      class var FInstance: TPermissoesAcesso;
      function fCarregarAcessosUsuario(strCodOpe: String): TStringList;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function GetInstance(): TPermissoesAcesso;
      function fVerificaAcesso(strNomeForm, strCodOpe: String): Boolean;
      procedure pLimpar;
  end;

Type
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


Type
  TImprimeImpFatTin = procedure(strTabela,
                               strNumDoc,
                               strEspDoc,
                               strCodEmp,
                               strCodCli,
                               strTip_Fc,
                               strOriDoc: String;
                               blnReimpressao: Boolean;
                               Var strNomeArquivo: String; //Nome do arquivo gerado que foi exportado
                               blnConfirmacao: Boolean;
                               strSaida: String = 'I';
                               intQtdImp: Integer = 1;
                               opcComSemPreco: TImpressaoComSemPrecoOrPd = impComPrecoGeral;
                               fltDebCli: Double = 0.0;
                               blnDocSep: Boolean = False;
                               blnTickIF: Boolean = False;
                               blnValTot: Boolean = True;
                               blnQtdOri: Boolean = True;
                               strFila: String = '';
                               strTipImpressao: String = '';
                               blnDocCancelado: Boolean = False;
                               blnImpExpedicao: Boolean = False;
                               blnComprovInd: Boolean = False;
                               blnSempreEntr: Boolean = False;
                               blnRequisicao: Boolean = False;
                               blnFilaEmpDoc: Boolean = False;
                               blnImprPedido: Boolean = False;
                               opcAbastecimento: TOpcAbastecimento = opcTodos;
                               blnImpFil: Boolean = False;
                               blnEnt_CD: Boolean = False;
                               blnPenden: Boolean = False;
                               blnLocFisEmpEmi: Boolean = False;
                               blnSepFut: Boolean = False;
                               strSepPedEntregaOuRetira: String = '';
                               strSetor: String = ' ';
                               cdsLogSeparacao: TUniClientDataSet = Nil;
                               blnRecCliGar: Boolean = False;
                               strOpcDoc: String = '';
                               strTipNomEmp: String = ''; // Razao Social ou Fantasia
                               strOrdem: String = '';  //Ordem dos produtos 1-Digitação, 2-Descricao produto, 3-Unidade Medida
                               blnPreRomaneio: Boolean = False;
                               opcAgrupaPor: TOpcAgrupaSepRomaneio = opcNaoAgrupa;
                               blnSomenteNaoImp: Boolean = False;
                               strCodLse: String = '';
                               strWhereSep: String = '';
                               blnF9OrF10: Boolean = False;
                               blnPerTot: Boolean = False;
                               blnGerPdf: Boolean = False;
                               strPasPdf: String = '';
                               blnVisPdf: Boolean = False;
                               blnSoEditor: Boolean = False;
                               blnPenExp: Boolean = False;
                               blnTicketNF: Boolean = False;
                               blnSintetizaItensExpedicao: Boolean = False;
                               blnEmail: Boolean = False;
                               blnVidro: Boolean = False;
                               strMensNovo: String = '';
                               strMensExcluido: String = '';
                               strEmpCabecalho_CD: String = '';
                               blnCabecalhoCD: Boolean = False;
                               blnTicketDV: Boolean = False);

{Type
  TForMulTinDet = Record
    strFormul: String;
    fltQtdbas: Double;
End;

Type
  TBaixaPigmentos = Record
    strCodIte: String;
    fltQtdBaixa: Double;
    strTipComp: String;
    strFormul: String;
    strPesGra: String;
    fltEmbBas: Double;
End;}
  TForMulTinDet = untGTinForTipos.TForMulTinDet;
  TBaixaPigmentos = untGTinForTipos.TBaixaPigmentos;
  TForMulTinDetArray = untGTinForTipos.TForMulTinDetArray;
  TBaixaPigmentosArray = untGTinForTipos.TBaixaPigmentosArray;

{******************************}
{* TIPO CRIADO PARA UTILIZAR  *}
{* A MESMA IMPRESSÃO DE CP    *}
{* DA MANUTENÇÃO DE CTA PAGAR *}
{* NA GER. AUT. DE CTA PAGAR  *}
{***************************JU*}
Type
  TImprimeCP = Record
    strNumDup: String;
    strParcel: String;
    strCodFor: String;
    strSerie_: String;
End;


Type
  TCriarConexao = class
  Private
    FConexao: TUniConnection;
  public
    Constructor Create(AInfo: string = '');
    Destructor Destroy; override;
    property objConexao: TUniConnection Read FConexao;
  end;

Type
  TCfgSis = class(TInterfacedObject, ICfgSis)
  public
    function fICfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
  end;





  Function fLastInsertID: String;



  Function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;

  function fCheckParent(Sender, Parent: TWinControl): Boolean;

  function fFindMenu(strFind: String; item: TMenuItem; AUseHint: Boolean = False): TMenuItem;
  function fGetMenuLevel(item: TMenuItem): Integer;
  function fGetMenuPath(item: TMenuItem): String;

  procedure pGeraPopUp(AOwner: TComponent; Menu: TMenuItem; popMenu: TMenuItem; strEsconder: String = ''; blnMenuPath: Boolean = False);

  function fFindParentByType(Sender: TWinControl; ParentType: TWinControlClass): TWinControl;
  Function fRetNomePais(strCodPai: String): String;
  Function fSenhaPermitida(strSenha: String): Boolean;
  Function fCmToPixel(fltValCm: Double; blnRound: Boolean = True): Double;
  Function fPixelToCm(fltValPix: Double; blnRound: Boolean = True): Double;
  function fSqlCdsIteger: String;


  function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;

  function fTiraCaracEspeciaisPonto(strTexto: String): String;
  function fGetPath(strPath: String): String;
  function TryDirectoryExists(APath: string; ATimeoutSecs: Integer = 10): Boolean;
  Function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;

  Function fDataAggregate(cdsClient: TUniClientDataSet; strNomCam: String): TDateTime;

  Function fIntAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Integer;
  Function fRetEmpresaFisica(conexao: TUniConnection = nil): String;

  function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;

  function fGravaLogBco(strComand: String): Boolean;



  Function fRetCodBarra(strCodIte: String): String;
  Function fRetCodIte(strCodBar: String): String;

  function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal : Boolean = True; strEmpSalRes : String = ''): Boolean;


  function fGetMemoryTableName(strTabela: String): String;
  function fGetMemoryTableNameEntregaFutura: String;



  function fCampoExiste(const strTabela, strCampo: String; const blnUsarCache : Boolean = False): Boolean;
  function fRetUFEmpresa(strCodEmp: String = ''): String;
  function fValidaEscala(strTexto: String; intMinimo, intMaximo: Double): Boolean;
  function fRetNomGeral(strCampoRetorno, strCampoPesquisa , strNomeTabela : String; fltCodigo: Double) : String;
  function fEmpresaUsaReplicacao(strCodEmp: String): Boolean;
  function fEmpresasNoServidor(strCodEmp: String): String;
  function fCampoEmpresasNoServidorPreenchido(strEmpA, strEmpB: String): Boolean;
  function fEmpresasNoMesmoServidor(strEmpA, strEmpB: String): Boolean;
  function fCriaDataSource(DataSet: TDataSet): TDataSource;
	function fRemoveAcento(Str:String): String;
  function fRemoveAcentoPontos(Str:String): String;
  procedure pRemoveAcentoVarRel(frx: TfrxReport; arrVar: Array Of String);
  procedure pRemoveAcentoObjRelFortes(Var obj: TForm);
	function StringToFloat(str : String) : Extended;
  function fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc: Double): String;
  function fRetForFilialTodos(blnLista: Boolean = False): String;
  function fFornecedorFilial(strCodFor: String): Boolean;

  function fEhItemTributado(strCodFis: String): Boolean;
  function fRetGrupoItem(strCodIte: String): String;
  function fRetNomeOperador(strCodOpe: String): String;
  function fOperadorAtivo(strCodOpe: String): Boolean;
  function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fFormataFloatInterna(fltNumero: Double; intDecimais: Integer): Double;
  function fSimpleRoundToEX(const AValue: Extended; const ADigit: TRoundToRange = -2): Extended;
  function fArredondaABNT_NBR5891_77(fltValor: Double;
    intDecimais: TRoundToRange; const Delta: Double  = 0.00001 ): Double;
  function fRemoveDizimas(fltValor: Double; intDecimais: Integer): Double;
  function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;
  function fRetSomenteNumeros(strTexto: String): String;



  function fUsaRotinaWMS(strCodEmp: String = ''): Boolean;

  procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
  procedure pProcuraSetFocus(Sender: TWinControl);



  function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<String>):String; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<Integer>):Integer; overload;
  function IIF(lTest:Boolean; vExpr1,vExpr2:TObject):TObject; overload;
  function fValN(Variable: Nullable<String>): String; overload;
  function fValN(Variable: Nullable<Integer>): Integer; overload;
  function fValN(Variable: Nullable<Double>): Double; overload;
	function fFormataCEP(strCEP: String): String;

  procedure pLiberaExecucaoChm;
  procedure pAjudaAutcom(Handle: THandle; intNumHlp: Integer);





  Procedure pConfiguraPopup(btnAtalho: TBitBtnLocked);

  function fAjustaDataSistema: Boolean;


  function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
    blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False; intWidth: Integer = 0): Integer;



  function fVerificaImpressora(strNomeImpr: String): Boolean;
  Function fGetNumLinhasMemo(strMemo: String): Integer;
  function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
  function fRetFantasiaEmpresa(strCodEmp: String = ''): String;


  {*****************************************}
  {* RETORNA MASCARA PARA A FUNÇÃO         *}
  {* 'FormatFloat'                         *}
  {**************************************MV*}
  function fMskDigitos(intDigitos: Integer): String;
  function fRetTipOpe(strCodOpe: String): String;
  Function fMarkupToMargem(fltMarkup: Double): Double;
  Function fMargemToMarkup(fltMargem: Double): Double;

  function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;

  function fVerificaSeEhLinha(strLinha: String): Integer;
  function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6): String;
  function fDropTable(strNomeTabela: String; Conexao: TUniConnection = Nil): Boolean;
	function fExecutaSQL(strSQL: String): Boolean;
  function fRetNomCliente(Const strCodCli: String): String;
  function fRetNomFantasia(Const strCodCli: String): String;
  function fRetDescMotivoReprovacao(Const strCodMre: String): String;
  function fRetCidCliente(Const strCodCli: String): String;
  function fRetEmailCliente(Const strCodCli: String; strIdxEmail: String = '1'): String;
  function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
  function fRetNomClienteConsumidor(strCodigo : String):String;
  function fRetCidEmpresa(strCodEmp: String): String;
  function fRetTabPrecoCliente(Const strCodCli: String): String;
  function fRetClientePorCgcCpf(intCgcCpf: Integer; strC_G_C_: string): String;



  function fValidaEstado(strUf: String): Boolean;
  function fTiraCaracEspeciais(strTexto      : String;
                               blnUsaLista   : Boolean = True;
                               blnTiraEspacos: Boolean = False;
                               blnTiraPontos : Boolean = False;
                               blnTiraDoisPts: Boolean = False;
                               blnTiraTab    : Boolean = False;
                               blnTiraVirgula: Boolean = True): String;
  function fRetNomCfgTin(strCodCfg: String): String;
  function fRetMarcaItem(strCodIte: String): String;
  function fRetUnidadeItem(strCodIte: String): String;
  function fRetNomProduto(Const strCodIte: String): String;
  function fModDouble(fltDividendo, fltDivisor: Double): Double;
  function fMenorMultiploValido(fltQtd, fltMlt: Double; blnOlhaCFG: Boolean; Out blnCorteMulti: Boolean): Double;
  function fStrZero(Zeros:string;Quant:integer):String; overload;
  function fStrZero(Zeros:Integer;Quant:integer):String; overload;
  function fStrZero(Zeros:Int64; Quant:integer): String; overload;
  function fStrZero(Zeros: Nullable<Integer>;Quant:integer):String; overload;
  function fStrZero(Zeros: Nullable<String>;Quant:integer):String; overload;
  function fEntraCons(strCodigo: String): Boolean;
	function fCrypt(strSenha: String): String;
  function fRetNomeLinhaGrupo(strCodigo: String): String;
  function fConverteCentroCusto(strCodCta: String): String;
  function fCadEmp(strNomCampo: String): String; Overload;
  function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery): String; Overload;
  function fCadEmpDes(strNomCampo, strCodEmp: String): String;
  function fRetPathSeImagemValida(strPathImg: String): String;
  function fCfgSis(strCamCfg: String; varTipVar: TVarType = varString; strCodEmp: String = '') : Variant;
  procedure pEncerrarAplicacaoPorInconsitenciaCodEmp(strCamCfg: String; blnTerminar: Boolean);
  function fCfgSisL(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = '';
                    dicCfgSis: TDictionary<string,string> = Nil): Variant;
  procedure pCriarCfgSis(strCodCfg: String; strDesCfg: String; strGruCfg: String; strValCfg: String);
  function fAtuCfgSis(strCamCfg: String; strValCfg: String; strCodEmp: String = ''; segConex: TUniConnection = Nil) : Boolean;
  function fCfgSisEmp(strCodCfg, strValCfg: String): String;
  function fRetClientesFilial: String;
	function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;
	function fDecrypt(strSenha: String): String;
  function fStrToFloat(strValorUnico: String; fltDefault : real = 0): Double;
  function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
  function fRetNomeEmpresa: String; overload;
  function fRetNomeEmpresa(strCodEmp: String): String; overload;
  function fRetIE_Empresa(strCodEmp: String): String;
  function fRetCEP_Empresa(strCodEmp: String): String;
  function fRetCGCEmpresa(strCodEmp: String): String;
  function fRetEnderecoEmpresa(strCodEmp: String): String;
  function fRetFoneEmpresa(strCodEmp: String): String;
  function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection = nil): TUniQuery;
  function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
  function fCndEmp:String;

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
                     intFormWidth : Integer = 0;
                     intQtdLinha: Integer = -1): Integer;

  Function fMensagemAuto(strTitulo: String;
                         strTexto: String;
                         arrOpcoes: Array Of String;
                         intFocoBotao: Integer = 1;
                         blnSaiComEsc: Boolean = False;
                         intEstFon: Integer = 1;
                         intWidBut: Integer = 0): Integer;

  Function fMensagemTabelaTintas(strTitulo : String;
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

  function fTiraEnter(strTexto: String): String;
  function fTiraEspacos(strTexto: String): String;
  function fTrimAll(strTexto: String): String;
  function fTrocaCaracter(strTexto: String; chrFrom, chrTo: Char): String;

  function fGetCharLastPos(AText: String; AChar: Char): Integer;

  function fTemTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): Boolean;
  function fLimpaTagMsgOculta(Const strTexto: String; opcOculta: TOcultarMensagemLiberacao = omlMsgParaQuemEnvia): String;

  function fEmptyStr(strString : String; blnTiraCaracEspecial: Boolean = False) : Boolean;
  function fNaoCriarConfiguracoes(strConf: String): Boolean;
  function fListaConfiguracoesParaNaoCriar(strConf: String): Boolean;
  Function fEmptyStrEspeciais(strInfo: String): Boolean;
  function fEmptyDate(strDate: String): Boolean;
  function fEmptyTime(strTime: String): Boolean;
  function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
  function fRetornaInformacaoUltimoErroForeignKey: String; overload;
  function fRetornaInformacaoUltimoErroForeignKey(Var strRetInnoDB: String): String; overload;
  function fRetornaInformacaoUltimoDeadlock: String;
  function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String; Overload;
  function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  function fPadR(strTexto: String; intTamanhoMin: Integer; intTamanhoMax: Integer; strCaracter: String = ' '): String; Overload;
  function fIsNumber(Const strNumber: String): Boolean;
  function fAbrirTabela(NomeTabela:TDataSet):Boolean;
  function fFecharTabela(NomeTabela:TDataSet):Boolean;
  function fUsaProCodigo(strNomeTabela: String): Boolean;
  function fUsaEnderecamento: Boolean;
  function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String; overload;
  function fRetAutoIncremInteger(strNomeTabela, strCodEmp: String): Integer;
  function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
  Function fNextAutoIncrem(strAutInc: String): String;

  function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
    blnGravar: Boolean = True; blnSoCriaTabela: Boolean = False;
    strMotDel: String = ''; strOpeDel: String = ''; blnTabAux: Boolean = False; strOpcDel: String=''): String;
  function fTabelaExiste(const strNomeTabela: String; const blnUsarCache : Boolean = False; Conexao: TUniConnection = Nil): Boolean;
  function fCurrentTime: String;
  function fCurrentDate: String; Overload;
  function fCurrentDate(Const Value: TDateTime): String; Overload;
  function fCurrentDateTime: String; Overload;
  function fCurrentDateTime(Const Value: TDateTime): String; Overload;
  function fNow: TDateTime;
  function fCamelCase(const s: string): string;
  {*****************************************}
  {* VERIFICA OS DIREITOS ESPECIFICOS      *}
  {**************************************AF*}
  function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
  function fRetTamCampo(strNomeTabela: String): Integer;
	function fAtualizaProCod(strNomeTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; intQtdCod: Integer = 1; LConn: TUniConnection = nil): String;

  procedure pGravaLogTransacao(objConexao: TUniConnection = Nil; strIdenti: String = ''; strTextoComplementarAoCallStack: String = '');
  procedure pAtualizaLogTransacao(strStack    : String         = '';
                                  tmrCommit   : TDateTime      = 0;
                                  tmrRollback : TDateTime      = 0;
                                  objConexao  : TUniConnection = Nil);
  procedure pApagaLogTransacao(opcao      : TAcaoTransacao;
                               objConexao : TUniConnection = Nil);
  function fRetornaStack: String;
  function fInTransaction(objConexao: TUniConnection = Nil): Boolean;
  function fConexaoAtiva(): Boolean;
  procedure fRegistraCallStackSeEstiverEmTransacao(objConexao: TUniConnection = Nil; strTextoComplementarAoCallStack: String = '');

	function fStartTransaction(objConexao: TUniConnection = Nil):Boolean;
	function fRollBack(objConexao: TUniConnection = Nil):Boolean;
	function fCommit(objConexao: TUniConnection = Nil):Boolean;
  {*******************************************}
  {* FUNÇÕES PARA CONFIGURAÇÕES DE RELATORIO *}
  {****************************************MV*}

  function fRetNomeRede: String;
  function fRetLocSep(Const strCodLse: String): String;

  function GetIPAddress: Integer;
  function GetIPAddressAsString: String;
  function GetMacAddress: String;
  function GetUserFromWindows: String;
  function GetComputerNetName: String;

  function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;
  function ffrmCodBarra(var strCodigo: string; strTitulo: String = ''; pGerar: TNotifyEvent = nil): Boolean;
  function ffrmSenhaEmpresa(Var strSenha, strCodEmp: String; strTitulo: String): Boolean;
  function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  function fArqIniLocal(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;

  function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
  function fRetNomeEstado(strNomeEstado: String): String;
  function fFormataCpfCgc(strValor: String; FPais: TPais; strEstado: String = ''): String;
  function fFormataCCusto(strValor: String): String;
  function fControlByName(Owner: TWinControl; strNome: String): TControl;
  function fRetNomUnidade(strCodUni: String): String;
  function fGetLetraAlfa(intCol: Integer): String;
  function fGetPosLetraAlfa(strLetra: String): Integer;
  function fGetLetraAlfaAnterior(strLetra: String; intQtd: Integer=1): String;
  function fInc(Var intValor: Integer) : Integer;
  function fFrtStrExcel(strValor: String) : String;
  function fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False; blnRepresentante: Boolean = False): String;
  function fRetSenhaVendedor(strCodVen: String): String;
	function fReplicatorStr(strRepl: String; intTamanho: Integer):String;
  function fRetornaClienteFilial(strCodEmp: String; strTipo_FC : String = 'C'): String;
  function fRetCodEmpClienteFilial(strCliFil: String): String;
  function fClientSelectEhClientFilialEmpLogada(strCodCli: String): Boolean;
  function fRetEmpAcessoUsuario(strCodOpe: String): String;
  function fRetEmpLoginUsuario(strCodOpe: String): String;
  function fRetEmpEstUsuario(strCodOpe: String): String;

  function fFloatToInt(fltNumero: Double): Integer;
  function fGetHostLock(strNomeTabela: String; blnSohIP: Boolean = False): String;
  procedure pGravaLogLck(strNum_IP, strCon_ID, strChaAce, strCodOpe: String; intTentat: Integer; dtaDtaLck, dtaHraLck: TDateTime);
  function fTempoExecucaoExcedido: Boolean;
  function fImportadorExcutando(strCHAVE: String): Boolean;
  procedure pChamaAutComModoImportacao(strCHAVE, strPARAM: String; intTEMPO_LIMITE: Integer);
  function fGetTentativasLock(strNomeTabela: String): Integer;
  procedure pZerarTentativasLock(strNomeTabela: String);
  function fGetIdConnectionLock(strNomeTabela: String): String;
  function fGetIPConnectionLock(strNomeTabela: String): String;
  function fRetUltimoLock(strNomeTabela: String): TInfLckAtc;
  function fRetOrigemLock(strNomeTabela: String): String;
  function fGetTempoDuracaoLock(strNomeTabela: String): Double;
  function fLock_Unlock(strNomeTabela: String;
                        blnTrava: Boolean;
                        blnLoopTravamento: Boolean = True;
                        blnHourGlass: Boolean = FALSE;
                        strCon_Id: String = '';
                        blnMostraMsgTravamento: Boolean = True;
                        strOrigem: String = '';
                        blnManual: Boolean = False): Boolean;

  Procedure pFreeLibraryEtiquetas;

  procedure pDestravarTodosLocksConexaoAtual(blnTestarOrigem: Boolean = False; conexao: TUniConnection = nil);
  procedure pDestravaLockForcado(strNomeTabela: String; intTentat: Integer=10);
  function fValNumForm(fltValor: Double; intZeros: Integer; intQtdDec: Integer = 2): String; overload;
  function fValNumForm(strValor: String; intZeros: Integer; intQtdDec: Integer = 2): Double; overload;
  function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  function fCriaClientDatset(qryOrigem: TDataSet; blnVazio: Boolean = False; AOwner: TComponent = Nil; blnRegistroAtual: Boolean = False): TUniClientDataSet;
  procedure pCopiaRegistroDataSet(dtsOrigem: TDataSet; dtsDestino: TDataSet; blnEdit: Boolean = False);
  function fMediaTime(strMedia: String): Integer;
  function fSegToTempoStr(intSegundos: Integer): String;
  function fSegToTimeStr(Segundos: Double): String;



  function fValidaEan13(strCodBar : String) : Boolean;

  function fItemPigmento(strCodIte: String;
    Var strCodBas: String): Boolean;

  {*****************************************}
  {* FUNÇÕES PARA O DIREITO DE ACESSO      *}
  {**************************************AF*}
  function fEhAdministrador(strCodOpe: String): Boolean;
  function fVerPermissaoOperador(strNomForm: String; strCodOpe: String = ''): Boolean;
  function fVerPermissaoOperadorPorGrupo(strNomForm: String; strCodOpe: String = ''): Boolean;
  function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  function IfNull(varValor, varDefault: Variant): Variant;
  function IfEmptyStr(strValor, strDefault: String): String;
  function fIsItemEspecial(strCodIte: String): Boolean;


  function fPesquisar(strTexto, strPalavra: String; intPosIni: Integer;
    var intPosIniRet, intPosFin: Integer): Boolean;

  function fPesquisarEdit(edtEdit: TCustomEdit; strPalavra: String;
    blnContinuacao: Boolean): Boolean;

  Function fRetSiglaEmpresa(strCodEmp: String): String;
  function fRetornaVersao(strNomArq: String = ''; blnProductVersion : Boolean = False): String;
  Function fPergunta(strMensagem: String): Boolean; Overload;
  Function fPergunta(strMensagem: String; blnDefSim: Boolean): Boolean; Overload;
  Function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
  function fTrataStr(const strValor: String): String;

  Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
  Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
  Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);


  Procedure pSetaClient(cdsClient: TDataSet);




  Procedure pCopiaClientDataSet(cdsOrigem, cdsDestino: TUniClientDataSet);



  function fBuscaValorConfiguracaoDefinidoLinhaComando(strConfiguracao: String; Var strValor: String): Boolean;

	procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
	procedure pAbrirBanco(Database: TUniConnection);
	procedure pFecharBanco(Database: TUniConnection);
	procedure pMensagensErro(MensErro, LocalErro: String; strMensagem: String = '');
	procedure pErro(Mensagem:String);
	procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; Conexao: TUniConnection = nil);
	procedure pSetButton(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar,btnLocalizar,btnSair:TBitBtnLocked);

  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TfrxReport); overload;
  procedure pPrintReport(strNomPro, strDesPro, strNomImp: String; AReport: TRLReport); overload;
  procedure pPreviewReport(strNomPro, strDesPro: String; AReport: TfrxReport);

  procedure pCriarForm(ClasseForm:TFormClass;NomeForm:TForm);
  procedure pAtuVarGlobaisSimples;

  procedure pCriarModulo(ClasseModulo: TDataModuleClass; Var NomeForm:TDataModule);
  procedure pDestroiModulo(var NomeForm);
  procedure pCriaIndices(strTabela, strCampos: String);
  procedure pFormataGrupoItem(Var strGrupItem: String);

  procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere,
    strMarca, strUnidad: String); Overload;
  procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere,
    strMarca, strUnidad: String); Overload;

  procedure pExecArquivo(strArquivo: String; Handle: THandle);
  procedure pFreeAndNil(var frmForm);
  procedure pVerificaProCod;
  procedure pCarregaVsTemFil;

  procedure pWaitWindow(Sender: TForm; strTexto: String; intTimeOut: Integer = 3; intPosicao: integer = 1);
  procedure pAlertaDeslizante(Sender: TForm; strTexto: String; intX, intY: Integer;
    intTimeOut: Integer = 3);

  function fRoundSql(const strCampo: String; const intDecimais: Integer): String;

  Procedure pCriaTabelaDel(strNomTab: String);
  procedure pValidaProCod(strNomeTabela: String);
  procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;
  function fCriaAggregateField(cdsClient: TUniClientDataSet; strFieldName, strExpression: String;
                               strDisplayFormat: String = ''; blnActive: Boolean = True): TAggregateField;

  procedure pSetaClientDataSet(var qryData: TUniQuery; cdsData: TUniClientDataSet);

  procedure pPlaySound(AFileName: String); overload;
  procedure pPlaySound(AStream: TMemoryStream); overload;

  procedure pMensagemSonora(strMensagem: String; blnMaximizar: Boolean = False; intFontSize: Integer = 0;
    intWidth: Integer = 0; cfgArqSom: String = ''; blnMsgOkPadraoSeCfgPassadaMasVazia: Boolean = False); Overload;
  procedure pMensagemSonora(strMensagem: String; cfgArqSom: String; blnMsgOkPadraoSeCfgPassadaMasVazia: Boolean = False); Overload;

  Procedure pMensagemOk(strMensagem: String; intWidth: Integer = 0; intHeight: Integer = 0);

  procedure pAjustaNumeroPaginas(pgcDados: TPageControl; Var intPaginasAtivas: Integer);


  Function fStringArrayToStr(arrMsg: TStringArray): String;


  function fCampoTabela(strCampo : String;
                        strNomTab: String;
                        arrCampoChave: Array Of String;
                        arrValorChave: Array Of Variant;
                        blnSempreLerBanco: Boolean = True;
                        strOrderBy: String = '';
                        Conexao: TUniConnection = Nil;
                        blnUsarMax: Boolean = False): Variant;

  function fTamanhoArquivo(strArquivo: String): Cardinal;
  function fValidaAcessoMultSelEmpresa(arrSelecao: TConsultasArray; Var strEmpNegadas: String): Boolean;

  function fGetSQLInEmpresasAcesso(strAlias: String; strAcesso: String = ''): String;

  procedure pAddDados(Var arrAdd : TStringArray; strTexto: String; blnConsiderarEnter: Boolean = False); overload;
  procedure pAddDados(Var arrAdd, arrHin : TStringArray; strTexto: String; strHint : String = ''; blnConsiderarEnter: Boolean = False); overload;

  function fGetConnectionID: String;


  function fCriaDiretorio(strPath: String): Boolean;
  function fDiretorioVazio(strPath: String): Boolean;
  procedure ApagaArquivosDiretorio(strPath: String);


  {Cadastro de Clientes}

  procedure pGravarTabelaLog(strCodOri, strCodDes, strTabLog: String; strObserv : String = '');

  procedure pRedimensionarTelaSeguindoMenuIniciar(frmForm: TForm);

  procedure pRedimensionaCentralizaForm(frmForm: TForm; intNewHeight, intNewWidth: Integer);

  {*********************************************}
  {* SELECTS COM TOTAIS DE DEBITOS DO CLIENTE  *}
  {******************************************JC*}

  function fSomenteLetra(str: String): String;

  function fTintaTemConfiguracoesNoBanco(strIdePro: String): Boolean;
  function fIniciaTraceViewer: Boolean;
  function fNoTef: Boolean;

  function fGetFloatStrF(fltNumero: Double; intInteiros, intDecimais: Integer): String;

  function fDllRegistrada(strPatchCompleto: String): Boolean;
  function fPegaListaRegistros(const aRoot: HKEY; const aPath: string; const strBusca: String): Boolean;



  function fRetCaracterEsquerda(strCampo, strCaracter: String): Variant;

  procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String);


  procedure pConfiguraOpcoesRegionais;
  function GetMaior(const arrValores: array of Extended; const arrIdentificadores: array of string): string;

  function fFindColumnByName(dbgData: TDBGridCitel; strField: String): TColumn;

  procedure HighlightCellText(AGrid: TDBGridCitel;
                                const ARect: TRect;
                                AColumn: TColumn;
                                FilterText: string;
                                AState: TGridDrawState ;
                                BkColor: TColor = clYellow;
                                SelectedBkColor: TColor = clGray;
                                fnColor: TColor = clBlack);

  function fValidaDataStr(strData: String): Boolean;
  function GetMD5(const strTexto: string): string;
  function fRetLitros(strCodIte: String): Double;
  function fRetLitrosUnidade(strCodUni: String): Double;
  function fGetStringArray(arrStrings: array of string): TStringArray;




  function fMskCon: String;
  function fSemMascaraPlaNco(strValor: String): String;
  function fRetiraZerosEsquerda(strDado: String): String;
  function fInArray(strValor: String; arrDados: TStringArray): Boolean;
  function GetInToOr(const strNomeCampo: string; const strValores: string): string;
  function fReplaceStr(strTexto, strFrom, strTo: String): String; overload;
  function fReplaceStr(strTexto: String; arrFrom, arrTo: Array Of String): String; overload;



  procedure pRetListaMesAno(stlLista : TStrings ; intQtdReg : Integer = 24; blnLimpaLista : Boolean = True);
  function fRetornaSomaAlturaDosPaineisVisiveisEm(const obj: TWinControl): Integer;
  function fRetSTRCampoBlobToCast255(strCampo, strAlias: String; blnPoeVirgula: Boolean=True): String;
  procedure fOrganizaControlesConformePassagemArgumentos(objs: array of TComponent);
  procedure pAddStringList(stl:TStringList; val: String);
  procedure pDelStringList(stl:TStringList; val: String);
  procedure pEnableConjuntoControles(const obj: TWinControl;
                                     const blnEnable: Boolean;
                                     const arrSomenteClas: array of TClass;
                                     const arrIgnonarCtrl: array of TWinControl);
  Function fQtdEmpresas : Integer;
  function fVerificarNovaFormulaMovimentada(const strSql: string; const arrParametros: array of Variant): Boolean;



  function fRetornaCpfCnpfVazio(strTipo: String): String;
  function fDisplayFormat(intCasDec: Integer): String;
  function fFilaExiste(strFila: String): Boolean;



  function fRetEmpresaOperador(strCodOpe: String): String;

  function fGetCodCorItem(strCodIte: String): String;


  function fStringSQLLocateToStringSQLIN(strLocate : String; strChrSepara : Char = '_'): String;
  function fValidaUFsPercurso(strPercurso: String): Boolean;
  function fImportadorPAFRodando: Boolean;
  procedure pExecutaImportadorPAF;
  function fLockImportacao: Boolean;
  function fRemoveLockImportacao: Boolean;
  function fLockImportacaoValido: Boolean;
  function StartProcess(Exename: String; CmdLineArgs: String = ''; ShowWindow: Boolean = False; WaitForFinish: Boolean = False): integer;
  function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean; overload;
  function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean;
    Var ProceInfo: TProcessInformation; blnInvisivel: Boolean = False): boolean; overload;

  Procedure pLiberaAggs(cdsClient: TUniClientDataSet);
  procedure pKill(intId: Integer);
  function fMesmoExecutavel: Boolean;
  function fQuotedStr(strString: String): String;

  function fRetMD5Autcom: String;
  function fRetVersaoPAFAutcom: String;
  function fInputQueryTipo(const ACaption, APrompt: string;
    var Value: string; ATipoTexto: EditFocus.TControlTipoTexto;
    chrPassCh: Char = #0 ): Boolean;

  function fDescricaoIF: String;
  function fDescricaoDocFat(strEspDoc: String): String;
  procedure pPreencheCombo(var cmb:TCustomComboBox; arr:Array of String; blnLimpa:Boolean=True);

  function fExtractBetweenTags(const Value, TagI, TagF: String): String;

  function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
  function fExtrairCodigoConfiguracao(ASQL: String): String;
  function fPermiteReplicarCfgSis(ASQL: String): Boolean;

  function fRetornaNomeTabela(strString: String): String;
  function fTabelaReplica(strNomTabela: String): Boolean;
  procedure pCarregaVariaveisControleLogRep(connection: TUniConnection);
  function fGravaLogRep(strComand, strTabela, strCarreg: String; connection: TUniConnection): Boolean;
  function fGravaUsuRep(connection: TUniConnection): Boolean;
  function fGravaInfUsuarioReplicacao(intSeqReplicacao: Int64; connection: TUniConnection): Boolean;
  procedure pTestarLogReplicacao;

  procedure pCriaApagaTrava(intCriApa: Integer);

  procedure pCarregaNre(ARefresh: Boolean = False);
  function fTabelaPermiteReplicarSempre(strNomTabela: String): Boolean;
  function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String;
  function fRetPortadoresOperador(strCodOpe: String): String;
  function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer;
    blnIgnoraPrimeiroDelimitador: Boolean=False): String;

  function fGetEmpresaLogada(): string;
  function fGetUsuarioLogado(): string;

  procedure pTrimAppMemorySize;

  function GetValidComponentName(const strNome: string): string;

  function fLerConteudoArquivo(const strArquivo: String): String;

  function fAlqIcmEstEmp(strCodAbfIte: String): Double;

  function fRetHoraServidor: TTime;
  function fRetDataServidor: TDate;

  procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
  procedure pStepStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String='');

  function fIsValidDate(Sender: TWinControl): Boolean;

  function fRetUtilizaCliPro : TUtilizaCliPro;
  function fRetDescOpcCliPro(Const opc : TOpcCliPro): String;

  function fImpDescriSimplificada(strCodCli: String): Boolean;

  procedure pOcultaTodosPaineisContidosEm(obj: TWinControl);
  procedure pIncrementaListaStr(Const strTexto: String; Var strLista: String; blnQuoted: Boolean=False; blnSeQuotedUseAspas: Boolean=True; chrSepara: Char=',';
       blnEspaca: Boolean=True; blnIgnoraRepetido: Boolean=True);
  function fEmailValido(strEmail: String; blnExibeAlerta: Boolean = True;
              strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False): Boolean;
  {*******************************************}
  {* IMPRESSORAS CONFIGURADAS P/ ABRIR GAVETA*}
  {****************************************NC*}
  procedure pImpressorasConfGaveta(stlLista: TStrings);
  function fLerImpConfGaveta: String;
  function fLerImpressora: String;
  procedure pAbrirGavetaNFCeSAT(strImpressora, strModelo: String);

  procedure pCarregaListaEmpresas(clbEmpresas: TCheckListBox; strEmpresas: String = '');
  function fAchaControle(wclBuscarEm: TWinControl; strNomeBusca: String): Boolean;
  function fParteInteira(fltValor: Double): Double;
  function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
  function fExecutaValCfg(strSQL, strEmp: String): String;



  function fRetEmpresasWms(blnUtiWms: Boolean): String;
  function fEstaNaLista(SL: TStringList; strValor: String): Boolean;
  function fUsaSat(strCodEmp : String = '') : Boolean;
  function fRetNomProspectoATIVO(strCodPro : String) : String;
  function fRetNomProspecto(strCodPro : String) : String;
  function fRetFoneProspecto(strCodPro : String) : String;
  function fRetFoneFornecedor(strCodFor: String) : String;
  function VerImpressoraONLINE(impressora: String): Cardinal;
  procedure pCopiaConsultaArray(Var arrBase, arrCopia : TConsultasArray);
  function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
  function fContarString(sTexto, sString: String): Integer;

  function fKeyIsDown(const Key: integer): boolean;
  procedure pCriarArrayAnexosEDestinatarios(strArquivo, strEmailDestinatario: String; Var arrDestinatarios, arrArquivos: TStringArray);

  function fConverteCodigoBarrasDocumento(strCodBar: String) : untTypesSistema.TDocumento;

  function fDataValida(dtaData: TDateTime): Boolean;

  function fChamaTelaGravando(fExecutarAcao: TFunctionFormGravando): Boolean;
  function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;

  function fFormatarSQL(strSQL: String): String;


  function fDateSql(Const Value: TDateTime): String;
  function fEnderecoEmailValido(strEmail: String): Boolean;
  function fBoleanoToStr(blnValue: Boolean): String;
  function ValidarXmlComXsd(FileXml, FileXsd: string): TStringList;
  function fGeraNumeroSessao: Integer;
  function fRetirarEspacos(Sender: TObject): String;

  Function fEmpresasMedEmp: String;

  function fRetStrToSQLIn(strValores: String; strDelimitador: String = '_'): String;
  function fRetStrToSQLArr(strValores: String; strDelimitador: String = '_'): TArray<Variant>;
  function fRetArrToSQLIn(arrValores: TConsultasArray; strCodigo: String): String;
  procedure pRedimensionaObj(objRedimensiona, objLimite : TControl; enuRedimensiona : TRedimensiona);
  function fRetMes(intMes: integer; blnAbreviado: boolean = False): String;
  procedure pOrdenaDataSet(var cdsAux : TUniClientDataSet; strCampo, strTipo : String);
  function fItemAmpara(strCodIte: String): Boolean;
  procedure pSalvaCamposForm(frmForm: TForm; strChave: String; blnPorEmpresa: Boolean);
  procedure pCarregaCamposForm(frmForm: TForm; strChave: String; blnPorEmpresa: Boolean);
  procedure QuickSort(mniMenu: TMenuItem; L, R: Integer);
  function fRetornaWordWrap(strTexto: String; intColunas: Integer): TStringList;
  function fRetornaWordWrapText(strTexto: String; intColunas: Integer): String;
  function VarToString(Const AValue: Variant): String;
  procedure pIncrementaAutoIncrem(var strAutoincrem: string; incValue: integer = 1);
  function fExecutaScript(script: string; var qrySQL: TUniQuery; blnCriaQuery: Boolean): boolean;

  function fTabelaExportacaoTerceirosTinta(strTabela: String): Boolean;


  function fObterQtdeCasasDecimaisCampo(strTabela, strCampo: String): Integer;
  function fUsaTef: Boolean;
  function fConverteTextoTEF(stlTexto: TStringList): String;
  procedure pLog(strValor: String);
  function fProcessExists(strFileName: string): Boolean;
  function fNumeroSerieExiste(strCodIte, strNumSer: string): Boolean;
  function fEhTabelaDeContabilidade(strTabela: string): boolean;
  procedure pGravaLogContabil(strSQL, strTabela: string);

  function fSQLSaldoDisponivel(const AAlias: String = 'G';
                                        AFaturamento: Boolean = False;
                                        ALote: Boolean = False): string;

  function fTamCodIte: Integer;
  function fTamCodLse: Integer;
  Procedure pSetaCodIte(edtCodIte: TEditFocus); overload;
  Procedure pSetaCodIte(edtCodIte: TDBEditFocus); overload;
  Procedure pSetaCodIte(edtCodIte: TStringField); overload;
  function fRetornaTipoDoCampo( strTabela : string = ''; strCampo: string = '' ) : String;

  function fUsaDoisMonitores: Boolean;
  function fUsaLayoutNovo: Boolean;
  procedure pCentralizarForm(AForm: TForm);

  function fRetFormsAtivos: String;
  function fTime(const AForceTime: Boolean = False) : TDateTime;
  function fNomeArquivoValido(const ATexto: string): string;
  procedure pGravaLogErrArquivoLocal(const strErro, strStack, strLocal: String);
  function fSafeSQLValue(const AValue : String): String;

  Var
  {********************************************}
  {* VARIÁVEL CONTENDO A DATA ATUAL, QUE SERÁ *}
  {* UTILIZADA NO PROGRAMA NO LUGAR DA FUNÇÃO *}
  {* 'Date'                                   *}
  {*****************************************MV*}
  VS_LastConnID : String;
  HandleDllTinta: THandle;
  HandleDllAuttin: THandle;

  VS_EXECUTAR_TESTE_LOG_REPLICACAO: Boolean;
  VS_RESULTADO_TESTE_LOG_REPLICACAO: Boolean;

  objEditorEtiquetas: HMODULE;
  objEditorRelatorios: HMODULE;

  VS_intPopUpId: Integer;

  VS_strTituloVersao: String;
  VS_strLastMenuName: String;
  VS_strLastMenuCaption: String;

  VS_HEIGHT_START_MENU_WINDOWS: Integer;
  VS_CfgJaVerificadas: Boolean;
  VS_Date: TDateTime;
  VS_VersaoTLSSSL: String;
  VS_dtaHraInicializacao: TDateTime;
  VS_blnCupomAberto: Boolean;
  VS_blnGravaLogTransacao: Boolean;
  VS_strTabelaErro: String;
  VS_strError: String;
  VS_strLocalErro: String;
  VS_strMensagemErro: String;
  VS_AutoatendimentoPagueFacil: Boolean;
  {*****************************************}
  {* VARIAVEIS GLOBAIS REFERENTES ÀS CLAS- *}
  {* SIFICAÇÕES FISCAIS                    *}
  {**************************************MV*}
  VS_strClaCom: String;
  VS_strClaVen: String;
  VS_strClaDev: String;
  VS_strClaNfo: String;
  VS_strClaNOE: String;
  VS_strCla_UC: String;
  VS_strClaRGF: String;
  VS_strClaRGR: String;
  VS_blnTemFil: Boolean;
  VS_strCodEmp: String;
  VS_strRazSoc: String; //Razao social da empresa
  //VS_strSimPau: String;
  //VS_fltIcmSim: Double;
  VS_strClaT01: String;
  VS_strClaT02: String;
  VS_strClaT03: String;
  VS_strClaT04: String;
  VS_strClaID1: String;
  VS_strClaID2: String;
  VS_strClaID3: String;
  VS_strCSTT01: String;
  VS_strCSTT02: String;
  VS_strCSTT03: String;
  VS_strUsaTmq: String;
  VS_blnNotificaSaldoAbaixMinimo: Boolean;
  VS_blnTesTef: Boolean;
  VS_Trace: ISQLTrace;
  VS_intUsaLogSql: Integer;
  VS_MinRowLogSql: Integer;
  VS_OpcStaPro: TOpcStatusProd;

  VS_strTitLot,
  VS_strTitLts,
  VS_strLotImp: String;
  VS_strClaImp: String; // Classificação de Importação
  VS_strClaDem: String;

  {*******************************************}
  {* LAZZUMIX                                *}
  {****************************************MV*}


  {*******************************************}
  {* BRASIMIX                                *}
  {****************************************MV*}
  VS_strProBri: String;
  VS_strTraBri: String;
  VS_fltFatBri: Double;
  VS_strTxtBri: String;
  {**********************************************}
  {* SE MOSTRA OU NÃO O DIALOGO DAS IMPRESSORAS *}
  {*******************************************AF*}
  VS_strNaoCab: String;
  VS_strClaGir: String;
  VS_strEspGir: String;
  //VS_fltRcxDes: Double;
  //VS_strCtaRcx: String;
  VS_strCliFil: String;
  VS_strFrmCus: String;

  VS_intIf_Dly: Integer;
  VS_strEsp80c: String;
  VS_strEsp40s: String;
  VS_strTipExp: String;
  VS_strTRADES: String;
  VS_strTRVEPR: String;

  //VS_strPatLog: String; // PATH DO LOGOTIPO DA EMPRESA.

  VS_strTabPreCheckOut: string;
  VS_strEtiTintaMaq: string;

  VS_blnResult : Boolean;

  VS_strIconeAutcomBarraNotificacao: String;

  {***********************************************}
  {* IMPRIME COMPROVANTE 40COLUNAS S             *}
  {* IMPRIME EM FAST REPORT (untQckFatImp40Col2) *}
  {********************************************AC*}
  VS_strTabPrc: String;
  VS_strTabFat: String;
  VS_strTxjCni: String;
  VS_strEdUnTb: String;
  VS_strUsaTef: String;
  VS_strUsaPaf: String;
  VS_blnTelNov: Boolean; //Tela de impressora fiscal NOVA?

  VS_strEmpPrd: String;
  VS_strTinDin: String; //Tintas de maquina Dinamica

  VS_strExpRetiraEntrega: String;
  VS_strExpRetiraEntregaDocFat: String;
  VS_strCreCGC : String;

  {*****************************************}
  {* CONTEM O APPLICATION.HANDLE, USADO PA-*}
  {* RA A DLL DO PEDIDO.                   *}
  {**************************************MV*}
  VS_APPLICATION_HANDLE: HWND;

  {*****************************************}
  {* CONTEM O DATA E HORA DO INICIO DA     *}
  {* TRANSAÇÃO                             *}
  {**************************************MV*}
  VS_dtaIdentiTransacao: TStringList;
  VS_TimerTransacao: TTimer;
  VS_TRANSACAO_LIMITE_SEGUNDOS: Integer;

  VS_AffectedRows:Integer;

  VS_MemoryTableEntFut: String;

  {**********************************************************}
  {* GUARDA O LOGIN DO USUARIO LOGADO NA MAQUINA NO MOMENTO *}
  {*******************************************************DV*}
  strLoginUsuarioLogado: String;
	strDescriUsuarioLogado: String;
	strEmpAcessoUsuarioLogado: String;
  strEmpEstUsuarioLogado: String;
  strEmpConsVendFatur: String;

  VS_strVerPaf: String;
  VS_strMd5Aut: String;

  {*********************************************************}
  {* GUARDA O PRIMEIRO PONTO DE IMPRESSÃO, QUANDO DIVERSOS *}
  {* DOCUMENTOS SÃO IMPRESSOS CONSECUTIVAMENTE             *}
  {******************************************************MM*}
  VS_strPonImp   : String = '';
  VS_blnUsaPonImp: Boolean = False;

  {******************************************}
  {* VARIAVEL USADA PARA GUARDAR OS ÚLTIMOS *}
  {* REGISTROS ACESSADOS NAS CONSULTAS      *}
  {***************************************MV*}
  utcRegistros: TUltConsultas;

  arrFilas      : TarrFilas; //Array Of TFilasImp;

  {*******************************************}
  {* USADA PARA ATRIBUIR O FILTRO PARA       *}
  {* EXIBIÇÃO DA CONTA CORRENTE              *}
  {****************************************ED*}
  strTipFil: String;
  strArqBoletos: String;

  VS_blnCodEmpBasDup: Boolean;
  VS_blnCodEmpBasDux: Boolean;
  VS_blnCodEmpBasDu2: Boolean;
  VS_objTraceViewer: ITraceViewer;
  VS_objProcessoImportadorPDV: TProcessInformation;
  VS_objProcessoMonitorStatus: TProcessInformation;
  VS_dtaUltimaExecucaoImportadorPDV: TDateTime;
  VS_dtaUltimaExecucaoMonitorStatus: TDateTime;
  VS_strLockImportacaoPDV: String;
  VS_strLockMonitorStatus: String;
  VS_blnPainelEcommerce : Boolean;
  VS_trayIconAutcom: TTrayIcon;


  VS_strFormulaCusto4: String;

  VS_ModeSSL: String;

  arrProCod : TarrProCod;

  blnErroLogRep: Boolean;
  strErroLogRep: String;
  blnTransferindoCodigo: Boolean;

  Unidade  : Array[0..9] Of String[7]  = ('','Um ','Dois ','Tres ','Quatro ','Cinco ','Seis ','Sete ','Oito ','Nove ');
  Dezena   : Array[0..9] Of String[10] = ('','Dez ','Vinte ','Trinta ','Quarenta ','Cinquenta ','Sessenta ','Setenta ','Oitenta ','Noventa ');
  Centena  : Array[0..9] Of String[13] = ('','Cem ','Duzentos ','Trezentos ','Quatrocentos ','Quinhentos ','Seiscentos ','Setecentos ','Oitocentos ','Novecentos ');

  arrLetras : Array [0..23] Of String[1] = ('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X');

  arrCamposPrecos: Array [0..40] of String[10] = ('ITE_PRECOM', 'ITE_DESF01', 'ITE_DESF02',
                                                  'ITE_DESF03', 'ITE_DESF04', 'ITE_DESF05',
                                                  'ITE_DESF06', 'ITE_ICMENT', 'ITE_SUBFED',
                                                  'ITE_IPIENT', 'ITE_FREENT', 'ITE_VALFRE',
                                                  'ITE_ACRFIN', 'ITE_SUBSTI', 'ITE_DESADB',
                                                  'ITE_PRECUS', 'ITE_OUTVAL', 'ITE_ICMSAI',
                                                  'ITE_IMPFED', 'ITE_DESOPE',
                                                  'ITE_MARBR1', 'ITE_PREVE1', 'ITE_COMTB1', //TABELA DE PRECO 1
                                                  'ITE_MARBR2', 'ITE_PREVE2', 'ITE_COMTB2', //TABELA DE PRECO 2
                                                  'ITE_MARBR3', 'ITE_PREVE3', 'ITE_COMTB3', //TABELA DE PRECO 3
                                                  'ITE_MARBR4', 'ITE_PREVE4', 'ITE_COMTB4', //TABELA DE PRECO 4
                                                  'ITE_MARBR5', 'ITE_PREVE5', 'ITE_COMTB5', //TABELA DE PRECO 5
                                                  'ITE_MARBR6', 'ITE_PREVE6', 'ITE_COMTB6', //TABELA DE PRECO 6
                                                  'ITE_MARBR7', 'ITE_PREVE7', 'ITE_COMTB7');//TABELA DE PRECO 7

  {**************************************}
  {* ARRAY COM EXCESSÕES DE CLAS.FISCAL *}
  {***********************************RV*}
  arrClaSai: Array [0..2] Of String = ('5405', '6404', '5404');
  arrClaEnt: Array [0..2] Of String = ('1403', '2403', '1404');


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

  {*******************************************}
  {* VARIAVEL UTILIZADA PELO PROCESSO DO CRM *}
  {****************************************AC*}
  VS_strHabilitarCRM: Boolean;

  VS_MacAddress        : String;
  VS_IPAddressAsString : String;
  VS_UserFromWindows   : string;
  VS_ComputerNetName   : string;

  VS_GravaUsuRep  : String;
  VS_LogRepConId  : String;
  VS_UsuRepConId  : String;
  VS_LogRepCodOp  : String;
  VS_LogRepIdTra  : String;
  VS_ConnectionID : String;

  VS_ProcessID         : string;
  VS_WorkStationIP     : String;
  VS_WorkstationID     : String;

  dicConfiguracoes: TDictionary<string,string>;

//  arrLogLib: TArrLogLib;

  {***************************************}
  {* VARIÁVEL DE CONTROLE DE ACESSO DE   *}
  {* OPERADORES A PORTADOERES SETADA     *}
  {* APENAS QUANDO A CONFIGURAÇÃO DACPOR *}
  {* ESTIVER "SIM"                       *}
  {************************************JU*}
  strPortadoresOperador : String;

  VS_strUrlSms: String;
  VS_strUsrSms: String;
  VS_strSenSms: String;
  VS_strRemSms: String;

  VS_PrefixoCliente: String;
  VS_ChaveCliente  : String;
  VS_URLBucket     : String;

  VS_intTamCadIte: Integer;
  VS_intTamCadLse: Integer;

  fConsulta: TfConsulta;
  fGetFuncoesCxGrid: TfGetFuncoesCxGrid;
  pIniciaDllFuncoes: TpIniciaDllFuncoes;

implementation

uses  untSenhaEmpresa, untModulo,
      untWaitWindow, untMensagemSonora,untMensagem,
      untGetMenu,
      untTConfiguracao, System.UITypes,
      untFuncoesConsulta, untGravaINNODBStatus,
      untLogSQL , untTestabilidade,
      untConsultas, untHorarioSistema;

var
  cdsTabNRE: TUniClientDataSet;
  FDicTabelaReplica: TDictionary<String, Boolean>;
  FMREWSTabelaReplica: TMultiReadExclusiveWriteSynchronizer;

{ TUltConsultas }

constructor TUltConsultas.Create;
begin
  inherited Create;
  pLimparCampos;
end;

destructor TUltConsultas.Destroy;
var intContador: Integer;
begin
  SetLength(arrTabelas, 0);
  SetLength(arrComplChave, 0);
  SetLength(arrSelects, 0);
  SetLength(arrIndices1, 0);
  SetLength(arrIndices2, 0);
  SetLength(arrIndices3, 0);
  SetLength(arrItemIndex, 0);
  SetLength(arrItemSaldo, 0);
  SetLength(arrItemPromo, 0);

  For intContador := 0 To Length(arrRegistros)-1 Do
  Begin
    FreeMemory(arrRegistros[intContador]);
//    arrRegistros[intContador] := Nil; estava dando invald point operation
  End;

  SetLength(arrRegistros, 0);

  inherited Destroy;
end;

function TUltConsultas.fRetRegistro(Const strNomeTabela: String; strComplChave: String = '';
        blnAtualizaDados: Boolean = True): Boolean;
  Var
    intTamArr: Integer;
    intContador: Integer;
begin
  Result    := False;
  intTamArr := Length(arrRegistros);

  If blnAtualizaDados Then
  Begin
    FTabela    := '';
    FComplChave:= '';
    FRegistro  := Nil;
    FSelect    := '';
    FIndice1   := '';
    FIndice2   := '';
    FIndice3   := '';
    FItemSaldo := False;
    FItemPromo := False;
  End;

  For intContador := 0 To intTamArr -1 Do
  Begin
    If (arrTabelas[intContador] = strNomeTabela) And
      (arrComplChave[intContador] = strComplChave) Then
    Begin
      Result       := True;
      FIndiceAtual := intContador;

      If blnAtualizaDados Then
      Begin
        FTabela    := strNomeTabela;
        FComplChave:= strComplChave;
        FRegistro  := arrRegistros[FIndiceAtual];
        FSelect    := arrSelects[FIndiceAtual];
        FIndice1   := arrIndices1[FIndiceAtual];
        FIndice2   := arrIndices2[FIndiceAtual];
        FIndice3   := arrIndices3[FIndiceAtual];
        FItemIndex := arrItemIndex[FIndiceAtual];
        FItemSaldo := arrItemSaldo[FIndiceAtual];
        FItemPromo := arrItemPromo[FIndiceAtual];
      End;

      Break;
    End;
  End;

end;

function TUltConsultas.GetComplChave: String;
begin
  Result := FComplChave;
end;

function TUltConsultas.GetEstado: TDataSetState;
begin
  Result := FEstado;
end;

function TUltConsultas.GetIndice1: String;
begin
  Result := FIndice1;
end;

function TUltConsultas.GetIndice2: String;
begin
  Result := FIndice2;
end;

function TUltConsultas.GetIndice3: String;
begin
  Result := FIndice3;
end;

function TUltConsultas.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

function TUltConsultas.GetItemPromo: Boolean;
begin
  Result := FItemPromo;
end;

function TUltConsultas.GetItemSaldo: Boolean;
begin
  Result := FItemSaldo;
end;

function TUltConsultas.GetRegistro: TBookmark;
begin
  Result := FRegistro;
end;

function TUltConsultas.GetSelect: String;
begin
  Result := FSelect;
end;

function TUltConsultas.GetTabela: String;
begin
  Result := FTabela;
end;

procedure TUltConsultas.Grava;
  Var
    intTamArr: Integer;
begin

  If Not (FEstado In [dsInsert]) Then
  Begin
    Exit;
  End;

  pChecarIntegridade;

  If Not (fRetRegistro(FTabela, FComplChave, False)) Then
  Begin
    intTamArr := Length(arrRegistros);
    SetLength(arrTabelas, intTamArr+1);
    SetLength(arrComplChave, intTamArr+1);
    SetLength(arrRegistros, intTamArr+1);
    SetLength(arrSelects, intTamArr+1);
    SetLength(arrIndices1, intTamArr+1);
    SetLength(arrIndices2, intTamArr+1);
    SetLength(arrIndices3, intTamArr+1);
    SetLength(arrItemIndex, intTamArr+1);
    SetLength(arrItemSaldo, intTamArr+1);
    SetLength(arrItemPromo, intTamArr+1);

    arrTabelas[intTamArr]   := FTabela;
    arrComplChave[intTamArr]:= FComplChave;
    arrRegistros[intTamArr] := FRegistro;
    arrSelects[intTamArr]   := FSelect;
    arrIndices1[intTamArr]  := FIndice1;
    arrIndices2[intTamArr]  := FIndice2;
    arrIndices3[intTamArr]  := FIndice3;
    arrItemIndex[intTamArr] := FItemIndex;
    arrItemSaldo[intTamArr] := FItemSaldo;
    arrItemPromo[intTamArr] := FItemPromo;
  End
  Else
  Begin
    arrTabelas[FIndiceAtual]   := FTabela;
    arrComplChave[FIndiceAtual]:= FComplChave;

//    If Assigned(arrRegistros[FIndiceAtual]) Then
//    Begin
//      FreeMem(arrRegistros[FIndiceAtual]);
//      arrRegistros[FIndiceAtual] := Nil; estava dando invald point operation
//    End;

    arrRegistros[FIndiceAtual] := FRegistro;

    arrSelects[FIndiceAtual]   := FSelect;
    arrIndices1[FIndiceAtual]  := FIndice1;
    arrIndices2[FIndiceAtual]  := FIndice2;
    arrIndices3[FIndiceAtual]  := FIndice3;
    arrItemIndex[FIndiceAtual] := FItemIndex;
    arrItemSaldo[FIndiceAtual] := FItemSaldo;
    arrItemPromo[FIndiceAtual] := FItemPromo;
  End;

  SetEstado(dsBrowse);

end;

procedure TUltConsultas.Limpar(strNomeTabela: String; strComplChave: String = '');
begin

  If fRetRegistro(strNomeTabela, strComplChave, False) Then
  Begin
    arrSelects[FIndiceAtual]   := '';

    If Assigned(arrRegistros[FIndiceAtual]) Then
      FreeMemory(arrRegistros[FIndiceAtual]);

    arrRegistros[FIndiceAtual] := Nil;
  End;

end;

procedure TUltConsultas.Novo;
begin
  SetEstado(dsInsert);

  FTabela     := '';
  FComplChave := '';
  FRegistro   := Nil;
  FSelect     := '';
  FIndice1    := '';
  FIndice2    := '';
  FIndice3    := '';
  FItemSaldo  := False;
  FItemPromo  := False;
end;

procedure TUltConsultas.pChecarIntegridade;
begin
  If Trim(FTabela) = '' Then
  Begin
    Raise Exception.Create('É necessário preencher a Tabela');
  End;
end;

procedure TUltConsultas.pLimparCampos;
Var intContador: Integer;
begin
  SetLength(arrTabelas, 0);
  SetLength(arrComplChave, 0);

  For intContador := 0 To Length(arrRegistros)-1 Do
  Begin
    If Assigned(arrRegistros[intContador]) Then
    Begin
      FreeMemory(arrRegistros[intContador]);
      arrRegistros[intContador] := Nil
    End;
  End;

  SetLength(arrRegistros, 0);
  SetLength(arrSelects, 0);
  SetLength(arrIndices1, 0);
  SetLength(arrIndices2, 0);
  SetLength(arrIndices3, 0);
  SetLength(arrItemIndex, 0);
  SetLength(arrItemSaldo, 0);
  SetLength(arrItemPromo, 0);
end;

procedure TUltConsultas.SetComplChave(strComplChave: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FComplChave := strComplChave;
  End
end;

procedure TUltConsultas.SetEstado(dsEstado: TDataSetState);
begin
  If (dsEstado In [dsInsert, dsBrowse]) Then
  Begin
    FEstado := dsEstado;
  End;
end;

procedure TUltConsultas.SetIndice1(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice1 := strIndice;
  End
end;

procedure TUltConsultas.SetIndice2(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice2 := strIndice;
  End
end;

procedure TUltConsultas.SetIndice3(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice3 := strIndice;
  End
end;

procedure TUltConsultas.SetItemIndex(intItemIndex: Integer);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FItemIndex := intItemIndex;
  End
end;

procedure TUltConsultas.SetItemPromo(blnItemPromo: Boolean);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FItemPromo := blnItemPromo;
  End;
end;

procedure TUltConsultas.SetItemSaldo(blnItemSaldo: Boolean);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FItemSaldo := blnItemSaldo;
  End
end;

procedure TUltConsultas.SetRegistro(bkmRegistro: TBookmark);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FRegistro := bkmRegistro;
  End
end;

procedure TUltConsultas.SetSelect(strSelect: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FSelect := strSelect;
  End
end;

procedure TUltConsultas.SetTabela(strTabela: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FTabela := strTabela;
  End
end;

{*************************************************}
{* CONVERTE O CENTRO DE CUSTO DE 5 PARA 7         }
{* USADO PARA CONVERTER OS DADOS DOS AQUIVOS INI *}
{**********************************************LA*}
function fConverteCentroCusto(strCodCta: String): String;
Begin
  If Length(strCodCta) = 5 Then
  Begin
    strCodCta := '0' + strCodCta;
    Insert('0',strCodCta,3);
    Result := strCodCta;
  End Else
    Result := strCodCta;
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

function fCadEmp(strNomCampo: String): String;
  Var
    qryGenEmp: TUniQuery;
begin
  Try

    qryGenEmp := fCriaQuery;
    qryGenEmp.Close;

    Result := fCadEmp(strNomCampo, qryGenEmp);

    qryGenEmp.Close;

  Finally
    FreeAndNil(qryGenEmp);
  End;

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

function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
	Var
    strPathOpcoes: String ;
		iniArqIni : TIniFile;
begin
  strPathOpcoes := ExtractFilePath(Application.ExeName);
  If (Not AnsiEndsText('auttin', strPathOpcoes)) And (Not AnsiEndsText('auttin\', strPathOpcoes)) Then
    strPathOpcoes := strPathOpcoes + '\auttin\';

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

function fNaoCriarConfiguracoes(strConf: String): Boolean;
Begin
  Result := fEhAdministrador(strLoginUsuarioLogado);

  If Not Result Then
    Exit;

  Result := fListaConfiguracoesParaNaoCriar(strConf);
End;

function fListaConfiguracoesParaNaoCriar(strConf: String): Boolean;
Begin
  Result := (strConf = 'CFG_TABPRE') Or
            (strConf = 'CFG_TABTER') Or
            (strConf = 'CFG_UPROAC') Or
            (strConf = 'CFG_PREGER') Or
            (strConf = 'TABPRE') Or
            (strConf = 'TABTER') Or
            (strConf = 'UPROAC') Or
            (strConf = 'PREGER');
End;

function fGetCharLastPos(AText: String; AChar: Char): Integer;
Var
  I: Integer;
begin
  Result := -1;
  For I := Low(AText) To High(AText) Do
    If AChar = AText[I] Then
      Result := I;
end;

{*****************************************}
{* RETORNA O NOME DA EMPRESA             *}
{**************************************MV*}
function fRetNomeEmpresa: String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

function fRetLocSep(Const strCodLse: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;

begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  LSE_DESCRI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADLSE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  LSE_CODIGO = :CODLSE ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODLSE').AsString := strCodLse;
      Open;
      Result := FieldByName('LSE_DESCRI').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;


function fRetNomeEmpresa(strCodEmp: String): String; overload;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
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
      Result := FieldByName('NOMEMP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

End;

function fRetIE_Empresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_I_E_S_ ';
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
      Result := FieldByName('EMP_I_E_S_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;
End;

function fRetCEP_Empresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_C_E_P_ ';
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
      Result := FieldByName('EMP_C_E_P_').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;
End;

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

function fCndEmp:String;
  var
    strCndEmp : String;
begin
  strCndEmp := fCfgSis('CNDEMP', VarString);

  If fEmptyStr(strCndEmp) Then
    strCndEmp := '01000';

  Result := strCndEmp;
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

Function fMensagemTabelaTintas(strTitulo   : String;
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
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
    frmMsgTbl    : TfrmMensagemTabela;
begin
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

    pCriarFormularios(TfrmMensagemTabela, frmMsgTbl);

    With frmMsgTbl Do
    Begin
      If Assigned(arrMensagem) then
        arrMensag := arrMensagem;

      strDesCol := strTitCol;

      intSomaTop := intSomarTop;
      If (blnAutosize) Then
        WindowState := wsMaximized;

      If intHeightOpc <> 0 Then
        frmMsgTbl.Height := intHeightOpc;

      If ( (ParamCount = 1) And  SameText(ParamStr(1), 'EXPEDICAO_MOTOROLA') ) Then
        blnAutosize := True;
        //intWidBut := 90;

      If strTitulo = '' Then
        strTitulo := 'AVISO';

      If intEstFon = 2 Then
        lblMensagem.Font.Name := 'Courier New';

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;


      If intWidthFrm = 0 Then
        Width := 1160
      Else
        Width := intWidthFrm;

      If intHeightFrm = 0 Then
        Height := 400
      Else
        Height := intHeightFrm;


      lsvTabela.Columns[0].Width := 1135;

      If blnBtnOk Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          Parent := pnlBotoes;

          Left := 1;
          Top  := 05;
          Height := 28;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;

        End;
      End
      Else If intQtdOpcoes = 1 Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := (Screen.Width - 126) Div 2
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 156 - ((intWidBut - 156) Div 2)
            Else
              Left       := 156;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 126
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 2 Then
      Begin
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin
            Left  := ((Screen.Width - 2*130) Div 2);
          End Else
          Begin
            If intWidBut <> 0 Then
              Left       := 90 - (intWidBut - 130)
            Else
              Left       := 90;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;

          If blnAutosize Then
          Begin

            Left  := ((Screen.Width - 2*126) Div 2) + 126 + 7;

          End Else
          Begin
            Left       := 222;
          End;

          Top        := 05;
          Height     := 28;

          If intWidBut = 0 Then
            Width      := 130
          Else
            Width      := intWidBut;

          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End
      Else If intQtdOpcoes = 3 Then
      Begin
        frmMsgTbl.Width := 494;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 18;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          If not blnBtnSemImg Then
            Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 166;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          If not blnBtnSemImg Then
            Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
        With TBitBtnLocked.Create(frmMsgTbl) Do
        Begin
          parent     := pnlBotoes;
          Left       := 314;
          Top        := 05;
          Height     := 28;
          Width      := 146;
          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          If not blnBtnSemImg Then
            Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMsgTbl.pOnclick;
        End;
      End;
    End;

    frmMsgTbl.intFocus     := intFocoBotao;
    frmMsgTbl.blnSaiComEsc := blnSaiComEsc;
    frmMsgTbl.blnObrigaEsc := blnObrigaEsc;
    frmMsgTbl.blnOcultPainelBtn := blnOcultPainelBtn;

   Try
     {$IFDEF TESTABILIDADE_AUTCOM}
     TTestabilidade.fGetTestabilidade.SetConteudoMensagem(strTexto);
     {$ENDIF}
   Except
     //
   End;

   frmMsgTbl.ShowModal;
   Result := frmMsgTbl.intRetorno;

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
      pMensagensErro(E.Message, '[fMensagemTabela]');
    End;
  End;

  pFreeAndNil(frmMsgTbl);
  FreeAndNil(fntFonte);

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

{*****************************************}
{* VERIFICA SE A STRING É UM NUMERO      *}
{**************************************MV*}
function fIsNumber(Const strNumber: String): Boolean;
  Var
    Code: Integer;
    E: Double;
begin

  Result := False;

  If (fEmptyStr(strNumber)) Then
  Begin
    Exit;
  End;

  Val(strNumber, E, Code);
  If (Code = 0) Then //Usado para eliminar o Hint...
  Begin
    E := 0;
    Result := True;
  End;

  If (E = 0) Then
  Begin
  End;
end;

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
  {*****************************************************}
  {* FILTRO DE TABELAS QUE NÃO DEVEM SER VERIFICADAS   *}
  {**************************************************JC*}
  If Not ((LeftStr(strNomeTabela,2) <> 'I_')   And
         (LeftStr(strNomeTabela,3) <> 'TMP')  And
         (LeftStr(strNomeTabela,4) <> 'DEL_') And
         (Pos(strNomeTabela, 'CFGSIS_CNFCHQ_CNFETI_CNF_NF_TABNRE_SEQLOG_APGTMP') <= 0)) Then
    Exit;

  LConn := TCriarConexao.Create('pValidaProCod(' + strNomeTabela + ')');
  Try
    qryGenCod := fCriaQuery(Nil, LConn.objConexao);
    Try
      fStartTransaction(LConn.objConexao);
      Try
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
                FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD', VS_strCodEmp);
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
  Finally
    FreeAndNil(LConn);
  End;
end;

{***************}
{* Abre Tabela *}
{************DV*}
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

{*****************}
{* Fechar Tabela *}
{**************DV*}
function fFecharTabela(NomeTabela:TDataSet):Boolean;
begin
  Try
	  If (Assigned(NomeTabela)) And (NomeTabela.Active = True) Then NomeTabela.Close;
	  Result := True;
  Except
	  On E : Exception do
	  Begin
		  Result := False;
		  pMensagensErro(E.Message, '[fFecharTabela]');
	  End;
  End;
end;

{*****************************************************}
{* VERIFICA SE TABELA ESTA USANDO CODIGO AUTOMATICO  *}
{**************************************************MV*}
function fUsaProCodigo(strNomeTabela: String): Boolean;
  Var
    strSQL   : String;
    qryGenAut: TUniQuery;

begin
  Try

    pValidaProCod(strNomeTabela);

    qryGenAut := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_CODAUT AS CODAUT ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

    With qryGenAut Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOMARQ').AsString := strNomeTabela;
      Open;
      Result := (FieldByName('CODAUT').AsString = 'S');
      Close;
    End;

  Finally
    FreeAndNil(qryGenAut);
  End;

end;

function fUsaEnderecamento: Boolean;
begin
  Result := False;
  If fCfgSis('ENTEND', varBoolean) Then
  Begin
    Result := fCfgSis('DEVEND', varBoolean);

    If Not Result Then
      Result := fCfgSis('USACON', varBoolean) And
               (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  End;
End;

Function fNextAutoIncrem(strAutInc: String): String;
Begin
 Result := LeftStr(strAutInc, 3) + fPadL(IntToStr(StrToIntDef(Copy(strAutInc, 4, 14), 0) + 1), 14, '0') + RightStr(strAutInc, 3);
End;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String; intIntervalo: Integer = -1): String;
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
  Try
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
  Finally
    FreeAndNil(LConn);
  End;
end;

function fRetAutoIncremInteger(strNomeTabela, strCodEmp: String): Integer;
begin
  Result := StrToIntDef(Copy(fRetAutoIncrem(strNomeTabela, strCodEmp), 4, 14), 0);
end;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
end;



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

            If Pos(strTabela, 'MOVGER_NOTGER_FATGOR_') > 0 Then
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

      If Pos(strTabela, 'MOVGER_NOTGER_FATGOR_') > 0 Then
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
            Else
              strSQL := strSQL + QuotedStr(FormatDateTime('yyyy-mm-dd', qryTabOriginal.Fields[intContador].AsDateTime));

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

      If Pos(strTabela, 'MOVGER_NOTGER_FATGOR') > 0 Then
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
      End
      Else
        Result := strSQL;

    Except
      On E:Exception Do
      Begin
        fMensagem('ERRO', 'Ocorreu um erro durante a gravação do arquivo de deletado(s).' + #13 + E.Message + #13 +
                          'Tabela: ' + strTabela + '.', ['&Ok']);
        Result := '';
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
  Result := IfThen(Trunc(VS_Date) = 0, nOw(), VS_Date + fTime());
end;

{*******************************************}
{* VERIFICA DIREITO DE ACESSO ESPECÍFICO E *}
{* RETORNA O CAMPO DIR_ACAOUS              *}
{****************************************AF*}
function fValidarDirEspecificos(Var strDireitos: String; strLogin, strNomeForm: String): Boolean;
  Var
    strSQL: String;
    qryGenOpe : TUniQuery;

Begin
  Try
    qryGenOpe := fCriaQuery;

    {*********************************************}
    {* VERIFICA DIREITOS ESPECIFICOS DO OPERADOR *}
    {******************************************AF*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DIROPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE AND ';
    strSQL := strSQL + '  DIR_NOMFRM = :NOMFRM ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strLogin;
      ParamByName('NOMFRM').AsString := strNomeForm;
      Open;

      If IsEmpty Then
      Begin
        {********************************************}
        {* SE ESTIVER VAZIO ENTAO PROCURA NO CADGPO *}
        {*****************************************AF*}
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   D.DIR_ACAOUS ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + '   DIRGPO D ';
        strSQL := strSQL + '   JOIN OPEGPO G ON D.GPO_CODGPO = G.GPO_CODGPO ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   G.OPE_CODOPE = :CODOPE AND ';
        strSQL := strSQL + '   D.DIR_NOMFRM = :NOMFRM ';

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strLogin;
        ParamByName('NOMFRM').AsString := strNomeForm;
        Open;

        If Not IsEmpty Then
        Begin
          strDireitos := FieldByName('DIR_ACAOUS').AsString;
          Result      := True;
        End
        Else
          Result := False;

      End
      Else
      Begin

        strDireitos := FieldByName('DIR_ACAOUS').AsString;
        Result      := True;

      End;
    End;

  Finally
    If Assigned(qryGenOpe) Then
      FreeAndNil(qryGenOpe);
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

{**************************************************}
{* PEGA O PROXIMO CODIGO E ATUALIZA TABELA PROCOD *}
{* ADICIONADO UM PARÂMETRO PARA ATUALIZAR UMA SE- *}
{* QUÊNCIA DE CÓDIGOS                             *}
{********************************************MV*AJ*}
function fAtualizaProCod(strNomeTabela: String; const strCampoBusca : String; const strTabelaBusca : String = ''; intQtdCod: Integer = 1; LConn: TUniConnection = nil): String;
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
    LConn := frmModulo.GetCurrentConnection;

  pValidaProCod(strNomeTabela);

  qryGenCod := fCriaQuery(Nil, LConn);

  blnComita := False;

  If Not LConn.InTransaction Then
  Begin
    fStartTransaction(LConn);
    blnComita := True;
  End;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
    strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD, ';
    strSQL := strSQL + '  PRO_SEQEMP AS SEQEMP  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
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
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
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

      Raise Exception.Create(E.Message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
    End;
  End;

  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + '   PROCOD ';
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   PRO_CODSEQ = :CODSEQ ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   PRO_NOMARQ = :NOMARQ ';

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
      qryAux.SQL.Add('INSERT INTO TRANSACOES(TRA_CODOPE, TRA_IDENTI, TRA_STACK_, TRA_ID_CON, TRA_HORSTA) VALUES (:CODOPE, :IDENTI, :STACK_, :ID_CON, :HORSTA)');

      If (strIdenti.IsEmpty) Then
      Begin
        strTransacao := FormatDateTime('dd/mm/yyyy hh:nn:ss', tmrStart);
        VS_dtaIdentiTransacao.Add(strTransacao);

        qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.ParamByName('IDENTI').AsString := strTransacao;
        qryAux.ParamByName('STACK_').AsString := fRetornaStack;
        qryAux.ParamByName('ID_CON').AsString := fGetConnectionID;
        qryAux.ParamByName('HORSTA').AsDateTime := tmrStart;
        qryAux.ExecSQL;

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
        
        qryAux.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
        qryAux.ParamByName('IDENTI').AsString := strIdenti;
        qryAux.ParamByName('STACK_').AsString := strTextoComplementarAoCallStack + #10#13 + fRetornaStack;
        qryAux.ParamByName('ID_CON').AsString := fGetConnectionID;
        qryAux.ParamByName('HORSTA').AsDateTime := tmrStart;
        qryAux.ExecSQL;
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



{*****************************************}
{* VERIFICA SE É NECESSARIO PERGUNTAR O  *}
{* TIPO DE IMPRESSÃO                     *}
{**************************************MV*
function fPerguntaTipo(qryCfgRel: TUniQuery): Boolean;
begin
  Result := True;
  If (fEmptyStr(qryCfgRel.FieldByName('REL_PERGUN').AsString)) Or
     (qryCfgRel.FieldByName('REL_PERGUN').AsString = 'N')      Then
  Begin
    Result := False;
  End;
end;
}
{*******************************************}
{* PEGA O NOME DA MÁQUINA NA REDE          *}
{****************************************MV*}
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
{*   CRIA FORM PARA PEDIR SENHA     *}
{*********************************WI*}
function ffrmSenha(var strSenha: string; strTitulo: String = ''): Boolean;
var
  Form: TForm;
  edt: TEdit;
begin

  Result := False;

  Try
    pCriarFormularios(TForm, Form);
    Form.BorderStyle := bsDialog;

    If fEmptyStr(strTitulo) Then
      Form.Caption := 'Senha'
    Else
      Form.Caption := strTitulo;

    Form.Position   := poScreenCenter;
    Form.Width      := 250;
    Form.Height     := 140;
    Form.Font.Name  := 'Arial';
    Form.Font.Size  := 13;
    Form.Color      := $00FFE4D5;
    With TLabel.Create(form) do
    Begin
      Parent     := Form;
      Caption    := 'Digite a Senha:';
      Left       := 10;
      Top        := 10;
      Font.Style := [fsBold];
    End;
    edt := TEdit.Create(form);
    With edt Do
    Begin
      Parent       := form;
      Left         := 10;
      Top          := 35;
      Color        := clInfoBk;
      Width        := form.ClientWidth - 22;
      PasswordChar :='*';
      CharCase     := ecUpperCase;
      MaxLength    := 10;
  //      SetFocus;
    End;
    With TBitBtnLocked.Create(form) Do
    Begin
      Parent  := form;
      Width   := 110;
      Height  := 27;
      Left    := form.ClientWidth - (Width * 2) - 14;
      Top     := 70;
      Kind    := bkOK;
      Caption := '&Confirma';
    End;
    With TBitBtnLocked.Create(form) Do
    Begin
      Parent  := form;
      Width   := 110;
      Height  := 27;
      Left    := form.ClientWidth - Width - 12;
      Top     := 70;
      Kind    := bkCancel;
      Caption := 'C&ancela';
    End;

    fRegistraCallStackSeEstiverEmTransacao(Nil, 'Formulário onde aconteceu: Name: '+form.Name+' Caption: '+form.Caption);

    If form.ShowModal = mrOK Then
    Begin
      strSenha := edt.Text;
      Result := true;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmSenha]');
    End;
  End;

  pFreeAndNil(Form);

end;

{************************************}
{* CRIA FORM PARA CODIGO DE BARRAS  *}
{*********************************AF*}
function ffrmCodBarra(var strCodigo: string; strTitulo: String = ''; pGerar: TNotifyEvent = nil): Boolean;
  Var
    frmForm: TForm;
    edtEdit: TEditFocus;
begin

  Result := False;

  Try
    pCriarFormularios(TForm, frmForm);
	  frmForm.BorderStyle := bsDialog;

    If fEmptyStr(strTitulo) Then
	    frmForm.Caption := 'Código de Barra vazio'
    Else
      frmForm.Caption := strTitulo;

	  frmForm.Position   := poScreenCenter;
	  frmForm.Width      := 400;
	  frmForm.Height     := 140;
    frmForm.Font.Name  := 'Arial';
    frmForm.Font.Size  := 13;
    frmForm.Color      := $00FFE4D5;
	  With TLabel.Create(frmForm) Do
    Begin
		  Parent     := frmForm;
		  Caption    := 'Digite o Código de Barras:';
		  Left       := 10;
		  Top        := 10;
      Font.Style := [fsBold];
	  End;
		edtEdit := TEditFocus.Create(frmForm);
	  With edtEdit Do
    Begin
      Name         := 'edtCodigo';
      Text         := '';
		  Parent       := frmForm;
		  Left         := 10;
		  Top          := 35;
      Color        := clInfoBk;
		  Width        := frmForm.ClientWidth - 22;
      CharCase     := ecUpperCase;
      MaxLength    := 15;
      TipoTexto    := EditFocus.TControlTipoTexto(ttNumerico);
	  End;
	  With TBitBtnLocked.Create(frmForm) Do
    Begin
	  	Parent  := frmForm;
      Width   := 110;
		  Height  := 27;
		  Left    := 10;
		  Top     := 70;
		  Kind    := bkOK;
      Caption := '&Confirma';
	  End;
	  With TBitBtnLocked.Create(frmForm) Do
    Begin
		  Parent  := frmForm;
      Width   := 110;
		  Height  := 27;
		  Left    := frmForm.ClientWidth - Width - 12;
		  Top     := 70;
		  Kind    := bkCancel;
      Caption := 'C&ancela';
	  End;

    If Assigned(pGerar) Then
   	  With TBitBtnLocked.Create(frmForm) Do
      Begin
		    Parent  := frmForm;
        Width   := 110;
  		  Height  := 27;
	  	  Left    := Floor(frmForm.ClientWidth / 2) - Floor(Width / 2);
		    Top     := 70;
  		  Kind    := bkHelp;
        Caption := '&Gerar';
        OnClick := pGerar;
  	  End;

	  If frmForm.ShowModal = mrOK Then
    Begin
		  strCodigo := edtEdit.Text;
		  Result := True;
	  End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmCodBarra]');
    End;
  End;

  pFreeAndNil(frmForm);

end;

function ffrmSenhaEmpresa(Var strSenha, strCodEmp: String; strTitulo: String): Boolean;
  Var
    frmSenhaEmpresa: TfrmSenhaEmpresa;
begin
  strSenha  := '';
  strCodEmp := '';
  Result := False;
  Try
    pCriarFormularios(TfrmSenhaEmpresa, frmSenhaEmpresa);
      frmSenhaEmpresa.Caption := strTitulo;
    If frmSenhaEmpresa.ShowModal = mrOk Then
    Begin
      strSenha  := frmSenhaEmpresa.edtSenha.Text;
      strCodEmp := frmSenhaEmpresa.edtCodEmp.Text;
        Result    := True;
    End;
  Finally
   pFreeAndNil(frmSenhaEmpresa);
  End;
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

{**********************************************************}
{* Lê/Grava dados no arquivo de Configuracao Local        *}
{*******************************************************MA*}
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

{*************************************************}
{* Habilita/Desabilita Edits da Tela de Cadastro *}
{**********************************************DV*}
procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
	var
		intContador : Integer;
begin
  For intContador := 0 to (NomeForm.ComponentCount - 1) do
  Begin
    If NomeForm.Components[intContador].Tag = 50 Then
      Continue;

    If NomeForm.Components[intContador].ClassNameIs('TEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBEditFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBMemoFocus') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TGroupBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCheckBox') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomEdit') Then
    	If TCustomEdit(NomeForm.Components[intContador]).TabStop Then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TCustomComboBox') Then
    	If TCustomComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TCustomComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbLookUpControl') Then
    	If TDbLookUpControl(NomeForm.Components[intContador]).TabStop Then
	    	TDbLookUpControl(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbRadioGroup') Then
      If TDbRadioGroup(NomeForm.Components[intContador]).TabStop Then
    	  TDbRadioGroup(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDbCheckBox') Then
    	If TDbCheckBox(NomeForm.Components[intContador]).TabStop Then
	    	TDbCheckBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TDBLookupComboBox') Then
    	If TDBLookupComboBox(NomeForm.Components[intContador]).TabStop Then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    If NomeForm.Components[intContador].ClassNameIs('TMaskEdit') Then
    	If TMaskEdit(NomeForm.Components[intContador]).TabStop Then
	    	TMaskEdit(NomeForm.Components[intContador]).Enabled := Habilitar;



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

      FreeLibrary(libUtil);
    End
    Else
    Begin
      Database.Username := 'root';
      Database.Password := 'citel13347';
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
    TFinalizarAutcomMonitor.Monitorar;
    fMensagem('Aviso', 'Abertura do Banco de Dados: ' + E.Message + #13#10#13#10 + 'Verifique o opcoes.ini!', ['&Ok']);
    fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&Ok']);
    Application.Terminate;
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

  Except
    On E : Exception Do
    Begin
      TFinalizarAutcomMonitor.Monitorar;
      pMensagensErro(E.Message, '[pAbrirBanco]');
      fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
      Application.Terminate;
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
    ERROR_FOREIGN_KEY_DELETE :fMensagem('ATENÇÃO!', 'Não é possivel excluir esse registro, pois existe movimentação para o mesmo.', ['&O k']);
    ERR_DEFAULT_PRINTER      :fMensagem('ATENÇÃO!', 'Não há impressora padrão selecionada!', ['&O k']);
  End;

end;

{****************************************}
{*   Exibe Mensagens de Erro do Banco   *}
{*************************************DV*}
procedure pErro(Mensagem:String);
begin
  HandleException;

end;

{*************************************************}
{*   Grava Mensagens de Erro no Arquivo de LOG   *}
{**********************************************DV*}
procedure pGravarErro(GravarErro:Boolean; MensagemErro:String; strRelatorio: String=''; Conexao: TUniConnection = nil);
  Var
    qryLogErr: TUniQuery;
begin
  If GravarErro Then
  Begin
//    If fStartTransaction Then
//    Begin

      qryLogErr := fCriaQuery(Nil, Conexao);
      qryLogErr.SQL.Add('SELECT * FROM LOGERR WHERE FALSE');

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

      FreeAndNil(qryLogErr);

    //End;
  End;
end;

{**************************************************}
{* Habilita/Desabilita Botoes da Tela de Cadastro *}
{***********************************************DV*}
procedure pSetButton(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar,btnLocalizar,btnSair:TBitBtnLocked);
begin
  If btnNovo.Tag <> 88 Then
    btnNovo.Enabled      := (NomeTabela.State = dsBrowse);

  If btnConfirma.Tag <> 88 Then
    btnConfirma.Enabled  := (NomeTabela.State in [dsInsert, dsEdit]);

  If btnExclui.Tag <> 88 Then
    btnExclui.Enabled    := (NomeTabela.State = dsBrowse);

  If btnCancela.Tag <> 88 Then
    btnCancela.Enabled   := (NomeTabela.State in [dsInsert, dsEdit]);

  If btnEditar.Tag <> 88 Then
    btnEditar.Enabled    := (NomeTabela.State = dsBrowse);

  If btnLocalizar.Tag <> 88 Then
    btnLocalizar.Enabled := (NomeTabela.State = dsBrowse);

  If btnSair.Tag <> 88 Then
    btnSair.Enabled      := (NomeTabela.State = dsBrowse);
end;

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

{******************}
{*   Cria Forms   *}
{***************DV*}
procedure pCriarForm(ClasseForm:TFormClass;NomeForm:TForm);
begin
  if Assigned(NomeForm) then
    pFreeAndNil(NomeForm);

  Try
    pCriarFormularios(ClasseForm,NomeForm);
    NomeForm.ShowModal;
  Except
    On E: Exception do
      pErro(E.Message);
  End;

  pFreeAndNil(NomeForm);
end;

//Verifica se o valor da configuracao foi passado por parametro pela linha de comando
//Por exemplo: C:/AUTCOM/AUTCOM.exe TIPEXP=4
function fBuscaValorConfiguracaoDefinidoLinhaComando(strConfiguracao: String; Var strValor: String): Boolean;
  Var
    intParam: Integer;
begin
  Result := False;
  For intParam := 1 To ParamCount Do
  Begin
    If AnsiStartsText(UpperCase(strConfiguracao + '='), UpperCase(ParamStr(intParam))) Then
    Begin
      Result   := True;
      strValor := MidStr(ParamStr(intParam), Pos('=', ParamStr(intParam)) + 1, Length(ParamStr(intParam)));
    End;
  End;
end;



procedure pAtuVarGlobaisSimples;
  Var
    Buffer: Array[0..254] Of Char;
    intContador: Integer;
    strPatIni: String;
begin

  For intContador := Low(Buffer) To High(Buffer) Do
    Buffer[intContador] := #0;

  Try
    {************************************}
    {* CONFIGURAÇÕES CFGSIS             *}
    {*********************************JB*}
    VS_ModeSSL := fCfgSis('MODSSL');
    VS_VersaoTLSSSL := fCfgSis('TLSSSL');
    //VS_strCtaRcx     := fConverteCentroCusto(fCfgSis('CTARCX'));
    //VS_fltRcxDes     := IfThen(Not fEmptyStr(fCfgSis('RCXDES')), fStrToFloat(fCfgSis('RCXDES', varDouble)), 0);
    VS_intIf_Dly     := fCfgSis('IF_DLY', varInteger) * 1000;
    //VS_strSimPau     := fCfgSis('SIMPAU');
    VS_strEsp80c     := fCfgSis('ESP80C');
    VS_strEsp40s     := fCfgSis('ESP40S');
    VS_strTipExp     := fCfgSis('TIPEXP', varString);
    VS_strTRADES     := fCfgSis('TRADES', varString);
    VS_strTRVEPR     := fCfgSis('TRVEPR', varString);

    VS_strExpRetiraEntrega := fCfgSis('TPITEX');
    VS_strExpRetiraEntregaDocFat := fCfgSis('TMERDF');
    //VS_strPatLog     := fCfgSis('PATLOG');

    VS_strTabPrc     := fCfgSis('TABPRC');
    If Length(VS_strTabPrc) < 7 Then
      VS_strTabPrc := VS_strTabPrc + StringOfChar('N',7-Length(VS_strTabPrc));

    VS_strTabFat     := fCfgSis('TABFAT');
    If Length(VS_strTabFat) < 7 Then
      VS_strTabFat := VS_strTabFat + StringOfChar('N',7-Length(VS_strTabFat));

    VS_strEdUnTb     := fCfgSis('EDUNTB');

    If fEmptyStr(VS_strEdUnTb) Then
      VS_strEdUnTb := 'S';

    If Length(VS_strEdUnTb) < 7 Then
      VS_strEdUnTb := VS_strEdUnTb + StringOfChar(VS_strEdUnTb[1],7-Length(VS_strEdUnTb));

    VS_strFrmCus        := fCfgSis('FRMCUS');
    VS_strFormulaCusto4 := '';

    //VS_fltIcmSim := fStrToFloat(fCfgSis('ICMSIM', varDouble));
    VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
    VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
    VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);
    VS_strClaNfo := fTransform(fCfgSis('CLANFO'), 4);
    VS_strClaNOE := fTransform(fCfgSis('CLANOE'), 4);
    VS_strCla_UC := fCfgSis('CLA_UC');
    VS_strClaRGF := fTransform(fCfgSis('CLARGF'), 4);
    VS_strClaRGR := fTransform(fCfgSis('CLARGR'), 4);
    VS_strNaoCab := fTransform(fCfgSis('NAOCAB'), 2);
    VS_strClaGir := fTransform(fCfgSis('CLAGIR'), 4);
    VS_strEspGir := fTransform(fCfgSis('ESPGIR'), 2);
    VS_strCliFil := fRetClientesFilial;
    VS_strCreCGC := fTransform(fCfgSis('CRECGC'), 3);
    VS_strRazSoc := fCadEmp('NOMEMP');
    If fCfgSis('CONIPI') = 'S' Then
      VS_strClaImp := '3101'
    Else
      VS_strClaImp := '3102';

    If fEmptyStr(VS_strFrmCus) Then
      VS_strFrmCus := '1';

    {*****************************************}
    {* VS_strEmpPrd: ESSA CONFIGURAÇÃO DEVE  *}
    {* SER MANTIDA EM VARIÁVEL.              *}
    {**************************************MV*}
    VS_strEmpPrd := fCfgSis('EMPPRD');
    If fEmptyStr(VS_strEmpPrd) Then
      If Not fCfgSis('OPRFLJ', varBoolean) Then
        VS_strEmpPrd := VS_strCodEmp;

    {************************************}
    {* CONFIGURAÇÕES .INI               *}
    {*********************************JB*}
    If fCfgSis('USNFCE', varBoolean) Then
      VS_strUsaTef := fArqIniLocal(0, 'NFCE', 'TEF', 'N', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')
    Else If fUsaSat Then
      VS_strUsaTef := fArqIniLocal(0, 'SATCFE', 'TEF', 'N', fCfgSis('PATSAT') + '\opcoes_sat.ini')
    Else
      VS_strUsaTef := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'USATEF'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );

    If fEmptyStr(VS_strUsaTef) Then
      VS_strUsaTef := 'N';

    If (VS_strUsaTef <> 'N') And (fNoTef) Then
      VS_strUsaTef := 'N';

    VS_strUsaPaf := fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'USAPAF'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' );
    If fEmptyStr(VS_strUsaPaf) Then
      VS_strUsaPaf := 'N';

    VS_blnTelNov := (Pos('BEMATECH', fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' )) > 0) And (VS_strUsaPaf = 'S');

    If (Not VS_blnTelNov) Then
    Begin
      VS_blnTelNov := (Pos('SWEDA ST120', fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' )) > 0) And (VS_strUsaPaf = 'S');
    End;

    If (Not VS_blnTelNov) Then
    Begin
      VS_blnTelNov := (Pos('ELGIN 1FIT', fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' )) > 0) And (VS_strUsaPaf = 'S');
    End;

    If (Not VS_blnTelNov) Then
    Begin
      VS_blnTelNov := (Pos('EPSON', fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO'       , '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' )) > 0) And (VS_strUsaPaf = 'S');
    End;

    If (Not VS_blnTelNov) Then
    Begin
      {****************************************************************************}
      {* A DARUMA FS700 OU SUPERIOR IRÁ USAR MODELO NOVO INDEPENDETE SE O USUÁRIO *}
      {* CONFIGURAR USAPAF = "N", POIS ESTE MODELO PRECISA SER USADA PELA NOVA    *}
      {* ROTINA QUE FOI IMPLEMENTADA PARA AS IMPRESSORAS FISCAIS.                 *}
      {* SOLICITADO PELO RONALDO/MÁRIO DIA 21/08/2014.                            *}
      {*************************************************************************FC*}
      VS_blnTelNov := (Pos('DARUMA FS700 OU SUPERIOR', fArqIniLocal(0, 'IMPRESSORA_FISCAL', 'MODELO', '', fCfgSis('DIRINI') + '\opcoes_fiscal.ini' )) > 0);

      If VS_blnTelNov Then
        VS_strUsaPaf := 'S';
    End;

    VS_blnTesTef := (fArqIni(0, 'GERAL', 'TEF', '') = '1');

    strPatIni := fCfgSis('PATINI');

    {**********************************************************************************}
    {* VERIFICA SE EXISTE O ARQUIVO OPCOES_LOCAIS.INI                                 *}
    {* CASO EXISTA - ATUALIZA A CONFIGURACAO VS_STRTIPEXP E VS_STRESP40S APARTIR DELE *}
    {* OBS: ESSE ARQUIVO DEVERÁ FICAR SEMPRE NA PASTA WINDOWS DA MAQUINA              *}
    {*******************************************************************************LU*}
    If fEmptyStr(strPatIni) Then
    Begin
      GetWindowsDirectory(Buffer, 255);
      strPatIni := StrPas(Buffer);
    End;

    VS_strIconeAutcomBarraNotificacao := 'S';

    strPatIni := strPatIni + '\OPCOES_LOCAIS.INI';

    If FileExists(strPatIni) Then
    Begin
      VS_strTipExp := fArqIniLocal(0, 'TIPO_FATURAMENTO', 'EXPEDICAO' , VS_strTipExp, strPatIni);
      VS_strExpRetiraEntrega := fArqIniLocal(0, 'TIPO_FATURAMENTO', 'TIPO_PEDIDO' , VS_strExpRetiraEntrega, strPatIni);
      VS_strEsp40s := fArqIniLocal(0, 'IMPRESSAO_40COLS', 'ESPDOC' , VS_strEsp40s, strPatIni);
      VS_strEsp80c := fArqIniLocal(0, 'IMPRESSAO_80COLS', 'ESPDOC' , VS_strEsp80c, strPatIni);
      VS_strTabPreCheckOut := fArqIniLocal(0, 'FATURAMENTO', 'TAB_PRECO_CHECK_OUT' , VS_strTabPreCheckOut, strPatIni);
      VS_strEtiTintaMaq := fArqIniLocal(0, 'ETIQUETA_TINTAMAQ', 'IMP_ETI_TINTAMAQ' , VS_strEtiTintaMaq, strPatIni);

      VS_strIconeAutcomBarraNotificacao := fArqIniLocal(0, 'SISTEMA', 'EXIBIR_ICONE_BARRA_NOTIFICACAO' , VS_strIconeAutcomBarraNotificacao, strPatIni);

      If Pos(VS_strExpRetiraEntrega, 'TRE') <= 0 Then
        Raise Exception.Create('Variável para tipo de pedido na expedição com valor inválido. Deve ser T, R ou E.');
    End;

    //Verifica se o valor da configuracao foi passado por parametro pela linha de comando
    //Por exemplo: C:/AUTCOM/AUTCOM.exe TIPEXP=4
    fBuscaValorConfiguracaoDefinidoLinhaComando('TIPEXP', VS_strTipExp);

    VS_strVerPaf := fRetVersaoPAFAutcom;
    VS_strMd5Aut := fRetMD5Autcom;

    {**************************************************}
    {* ATUALIZA OS PORTADORES QUE A EMPRESA TEM ACESSO*}
    {***********************************************LE*}
    If fCfgSis('DACPOR', varBoolean) Then
      strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);

    VS_strClaDem :=  fTransform(fCfgSis('CLADEM'), 3);

    VS_strUrlSms := fCfgSis('URLSMS', varString);
    VS_strUsrSms := fCfgSis('USRSMS', varString);
    VS_strSenSms := fCfgSis('SENSMS', varString);
    VS_strRemSms := fCfgSis('REMSMS', varString);

    VS_PrefixoCliente := fCfgSis('CLIPFX', varString);
    VS_ChaveCliente   := fCfgSis('CLICHP', varString);
    VS_URLBucket      := fCfgSis('URLBKT', varString);

  Except
    On E: Exception Do
      pMensagensErro('Erro ao carregar variaveis globais!' + #13 + E.Message,'[ATUVARGLOBAISSIMPLES]');
  End;
end;







{***********************************************}
{* RETORNA O NOME DA LINHA OU GRUPO CADASTRADO *}
{********************************************AF*}
function fRetNomeLinhaGrupo(strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenGru: TUniQuery;

Begin
  Try

    qryGenGru := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADGRU ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  GRU_CODGRU = :CODGRU ';

    With qryGenGru Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODGRU').AsString := strCodigo;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('GRU_DESGRU').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenGru);
  End;

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

{*****************************************}
{* VERIFICA SE DETERMINADA STRING CONTEM *}
{* ALGUM DOS CARACTERES DE PESQUISA      *}
{**************************************MV*}
function fEntraCons(strCodigo: String): Boolean;
begin
  Result := (Pos('/', strCodigo) > 0) Or (Pos('?', strCodigo) > 0);
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

procedure pCriaIndices(strTabela, strCampos: String);
  Var
    strSQL : String;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'CREATE INDEX ';
    strSQL := strSQL + '  IDX_' + strTabela + '_' + strCampos;
    strSQL := strSQL + ' ON ';
    strSQL := strSQL + ' ' + strTabela + ' ';
    strSQL := strSQL + ' (' + strCampos +')';
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
    End;
  Except
  End;

  FreeAndNil(qryGen);
end;

{*****************************}
{* RETORNA O NOME DO PRODUTO *}
{**************************AF*}
function fRetNomProduto(Const strCodIte: String ): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_DESITE ';
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
        Result := FieldByName('ITE_DESITE').AsString
      Else
        Result := '';

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;



{***************************}
{* RETORNA UNIDADE DO ITEM *}
{************************AF*}
function fRetUnidadeItem(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

Begin
  Try

    Result := '';

    qryGenIte := fCriaQuery;

    If (fEmptyStr(strCodIte)) Then
      Exit;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_CODUNI ';
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

      Result := FieldByName('ITE_CODUNI').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;

{*************************}
{* RETORNA MARCA DO ITEM *}
{**********************AF*}
function fRetMarcaItem(strCodIte: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  Result := '';

  If (fEmptyStr(strCodIte)) Then
    Exit;

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  ITE_CODMAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := FieldByName('ITE_CODMAR').AsString;

    Close;
  End;

  FreeAndNil(qryGen);
End;





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

{*****************************************}
{* RETIRA CARACTERES ESPECIAIS DE UMA    *}
{* STRING                                *}
{**************************************MV*}
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

{*****************************************}
{* VERIFICA SE É UM ESTADO VALIDO        *}
{**************************************MV*}
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



{*****************************}
{* RETORNA O NOME DO CLIENTE *}
{**************************AF*}
function fRetNomCliente(Const strCodCli: String): String;
var
  qryAux: TUniQuery;
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
End;

function fRetNomFantasia(Const strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_FANSOB', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
End;

function fRetDescMotivoReprovacao(Const strCodMre: String): String;
Begin
  Result := fCampoTabela('MRE_DESCRI', 'CADMRE', ['MRE_CODIGO'], [strCodMre]);
End;


{****************************************}
{* EXECUTA A SQL PASSADA POR PARAMETRO  *}
{*************************************AF*}
function fExecutaSQL(strSQL: String): Boolean;
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
			Result := False;
			pMensagensErro(E.Message, '[fExecutaSQL]');
		End;
	End;

  FreeAndNil(qryGen);

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


{*****************************************}
{* RETORNA 1 SE FOR LINHA 2 SE FOR GRUPO *}
{* E 3 SE FOR CONTA                      *}
{**************************************AF*}
function fVerificaSeEhLinha(strLinha: String): Integer;
Begin
  If RightStr(strLinha, 5) = '00000' Then
    Result := 1
  Else If RightStr(strLinha, 3) = '000' Then
    Result := 2
  Else
    Result := 3;
End;

Function fMarkupToMargem(fltMarkup: Double): Double;
Begin
  If ( ( fltMarkup / 100 ) + 1 ) <> 0 Then
    Result := RoundTo( (( fltMarkup / 100 ) / ( ( fltMarkup / 100 ) + 1 )) * 100, -4)
  Else
    Result := 0;
End;

Function fMargemToMarkup(fltMargem: Double): Double;
Begin
  If RoundTo(fltMargem, -4) <> RoundTo(100, -4) Then
    Result := ((fltMargem / 100) / (1 - fltMargem/ 100)) * 100
  Else
    Result := 0;
End;

procedure ForceKill(AProcess: Integer);
  Var
    strComand : String;
begin
  strComand := 'taskkill /F /PID ' + AProcess.ToString;
  WinExec(PAnsiChar(AnsiString(strComand)), SW_HIDE);
end;

function KillProcess(pid: cardinal; AForceKill: Boolean = True): Boolean;
var
  killer: THandle;
begin
  killer := OpenProcess(PROCESS_TERMINATE, False, pid);
  Result := TerminateProcess(killer, 0);
  if not Result and AForceKill Then
    ForceKill(pid);
end;

{*****************************************}
{* RETORNA MASCARA PARA A FUNÇÃO         *}
{* 'FormatFloat'                         *}
{**************************************MV*}
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
{* RETORNA O NOME DA EMPRESA SELECTIONADA *}
{***************************************AF*}
function fRetNomeEmpresaSelec(Const strCodEmpresa: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmpresa;
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;



Function fGetNumLinhasMemo(strMemo: String): Integer;
  Var
    stlLinhas: TStringList;
Begin
  stlLinhas := TStringList.Create;
  stlLinhas.Text := strMemo;
  Result := stlLinhas.Count;
  FreeAndNil(stlLinhas);
End;

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

{************************************}
{* VERIFICA SE A PORTA PASSADA ESTÁ *}
{* DISPONÍVEL                       *}
{*********************************AF*}
function fVerificaImpressora(strNomeImpr: String): Boolean;
  Var
    txtImpressora: TextFile;
Begin

  Result := True;
  Try
    AssignFile(txtImpressora,strNomeImpr);
    Rewrite(txtImpressora);

    CloseFile(txtImpressora);
  Except
    On E: Exception Do
    Begin
      Result := False;
      If Pos('file access denied', LowerCase(E.Message)) > 0 Then
        Result := True;
    End;
  End;

  If (Not Result) And (Win32Platform = 1) Then
  Begin
    Result := True;
    Try
      AssignFile(txtImpressora,'LPT1');
      Rewrite(txtImpressora);

      CloseFile(txtImpressora);
    Except
      On E: Exception Do
      Begin
        Result := False;
        If Pos('file access denied', LowerCase(E.Message)) > 0 Then
          Result := True;
      End;
    End;
  End;

End;

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




{*****************************************}
{* IMPLEMENTAÇÃO DA FUNCAO GETMENU       *}
{**************************************MV*}
function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
  blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False; intWidth: Integer = 0): Integer;
  Var
    intContador: Integer;
begin

  Result := -1;
  If (Not blnLibQtd) And (Length(arrOpcoes) <= 1) Then
  Begin
    fMensagem('', 'É Necessário escolher ao menos 2 opções', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmGetMenu, frmGetMenu);
    SetLength(frmGetMenu.arrOpcoes, Length(arrOpcoes));

    For intContador := 0 To Length(arrOpcoes)-1 Do
    Begin
      frmGetMenu.arrOpcoes[intContador] := arrOpcoes[intContador];
    End;

    If intOpcao <= 0 Then
      intOpcao := 1;

    Dec(intOpcao);

    frmGetMenu.intLinha     := intOpcao;
    frmGetMenu.blnSaiComEsc := blnSaiComEsc;
    frmGetMenu.Caption      := strTitulo;

    If intWidth > 0 Then
    Begin
      frmGetMenu.Width         := frmGetMenu.Width + intWidth;
      frmGetMenu.stgMenu.Width := frmGetMenu.Width;
      frmGetMenu.stgMenu.DefaultColWidth := frmGetMenu.Width;
    End;

    frmGetMenu.showModal;

    If frmGetMenu.blnConfirma Then
    Begin
      Result := frmGetMenu.intLinha+1;
    End;

  Except
    On E: Exception Do
    Begin
      Result := -1;
      pMensagensErro(E.Message, '[untFuncoes.fGetMenu]');
    End;
  End;

  pFreeAndNil(frmGetMenu);

end;

{*****************************************}
{* EXECUTA UM IIF, IGUAL O CLIPPER :^)   *}
{**************************************MV*}
function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
end;

function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<String>):String;
Begin

  If lTest then
  Begin
    If vExpr1.HasValue Then Result := vExpr1
    Else Result := '';
  End
  Else
  Begin
    If vExpr2.HasValue Then Result := vExpr2
    Else Result := '';
  End;

End;

function IIF(lTest:Boolean; vExpr1,vExpr2:Nullable<Integer>):Integer;
Begin

  If lTest then
  Begin
    If vExpr1.HasValue Then Result := vExpr1
    Else Result := 0;
  End
  Else
  Begin
    If vExpr2.HasValue Then Result := vExpr2
    Else Result := 0;
  End;

End;

function IIF(lTest:Boolean; vExpr1,vExpr2:TObject):TObject;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2
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


function fRemoveDizimas(fltValor: Double; intDecimais: Integer): Double;
  Var
    intPow: Double;
begin
  intPow := Power(10, -intDecimais);
  Result := Trunc((fltValor / intPow) + 0.5) * intPow;
end;

function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;
  Var
    strValor: String;
    intPos: Integer;
begin
  strValor := FloatToStrF(fltNumero, ffNumber, 15, intDecimais+2);

  intPos := Pos(',', strValor);
  If intPos > 0 Then
  Begin
    strValor := Copy(strValor, 1, intPos+intDecimais);
  End;
  Result := fStrToFloat(strValor);
end;

{*****************************************}
{* RETORNA SOMENTE NUMEROS EM UMA STRING *}
{***************************************FC}
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




{*****************************************}
{* VALIDA SE O PERIODO É VALIDO          *}
{**************************************MV*}
function fValidaPeriodo(strDtaIni, strDtaFin: String): Boolean;
begin

  Result := True;
  {*****************************************}
  {* CASO A DATA INICIAL SEJA VAZIA, OK    *}
  {**************************************MV*}
  If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
  Begin
    Try
      If StrToDate(strDtaFin) < StrToDate(strDtaIni) Then
      Begin
        Result := False;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
      End;
    End;
  End;

end;

function fRetNomLocFisica(Const strCodLoc: String): String;
Begin
  Result := fCampoTabela('LOC_DESCRI', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'],
                         [strCodLoc, VS_strCodEmp]);
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


function fPortadorPermiteBoletoFaturamento(Const strCodPor: String): Boolean;
begin
  Result := fCampoTabela('POR_BOLFAT', 'CADPOR', ['POR_CODPOR'], [strCodPor]) = 'S';
end;


{******************************}
{* RETORNA O NOME DO OPERADOR *}
{***************************AF*}
function fRetNomeOperador(strCodOpe: String): String;
  Var
    strSQL : String;
    qryGenOpe : TUniQuery;

Begin
  Try
    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;

      Result := qryGenOpe.FieldByName('OPE_NOMOPE').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

End;

function fOperadorAtivo(strCodOpe: String): Boolean;
  Var
    strSQL : String;
    qryGenOpe : TUniQuery;

Begin
  Try
    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_STATUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  OPE_CODOPE = :CODOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;

      Result := qryGenOpe.FieldByName('OPE_STATUS').AsString = 'A';

      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

End;


{***********************************************}
{* RETORNA O CODIGO DO GRUPO DO ITEM           *}
{********************************************AF*}
function fRetGrupoItem(strCodIte: String): String;
Begin
  Result := fCampoTabela('ITE_CODGRU', 'CADITE', ['ITE_CODITE'], [strCodIte], False);
    End;

{***************************************************}
{* RETORNA O NOME DO EVENTO DE ACORDO COM O CÓDIGO *}
{************************************************LB*}

{*****************************************************************}
{* CARREGA TODOS OS FORNECEDORES FILIAIS DO CADASTRO DE EMPRESAS *}
{**************************************************************LU*}
function fRetForFilialTodos(blnLista: Boolean = False): String;
Var
  intContador: Integer;
  strSQL     : String;
  qryGenerica: TUniQuery;
Begin
  qryGenerica := fCriaQuery;

  Result := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  DISTINCT(EMP_FORFIL) AS EMP_FORFIL ';
  strSQL := strSQL + 'FROM     ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + 'WHERE    ';
  strSQL := strSQL + '  EMP_FORFIL IS NOT NULL ';
  strSQL := strSQL + '  AND EMP_FORFIL <> ""   ';

  With qryGenerica Do
  Begin
    CLose;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    For intContador := 0 To RecordCount -1 Do
    Begin

      If Not fEmptyStr( FieldByName('EMP_FORFIL').AsString ) Then
        If blnLista Then
          Result := Result + '"' + FieldByName('EMP_FORFIL').AsString + '", '
        Else
          Result := Result + FieldByName('EMP_FORFIL').AsString + '_';

      Next;
    End;

    If blnLista Then
      Result := Copy(Result, 1, Length(Result) - 2)
    Else
      Result := Copy( Result, 1, Length( Result ) - 1 );

    Close;
  End;

  FreeAndNil(qryGenerica);

  If (fEmptyStr(Result)) Then
    Result := '""';

End;

function fRetornaSubQueryFaixasForaCondicao(fltMarDoc, fltValDoc: Double): String;
begin
  Result := 

    ' IF((@MAR NOT BETWEEN CND_MARMIN AND CND_MARMAX) OR          '+
    '    (@VAL NOT BETWEEN CND_FATMIN AND CND_FATMAX),            '+
    '                                                             '+
    '  IF((@MAR NOT BETWEEN CND_MARMIN AND CND_MARMAX) AND        '+
    '     (@VAL NOT BETWEEN CND_FATMIN AND CND_FATMAX), 1,        '+
    '                                                             '+
    '      IF((@MAR NOT BETWEEN CND_MARMIN AND CND_MARMAX), 2, 3) '+
    '    ) '+
    ' ,0)  ';

  Result := AnsiReplaceStr(Result, '@MAR', AnsiReplaceStr(FloatToStr(fltMarDoc), ',', '.'));
  Result := AnsiReplaceStr(Result, '@VAL', AnsiReplaceStr(FloatToStr(fltValDoc), ',', '.'));
end;

function fFornecedorFilial(strCodFor: String): Boolean;
var strFiliais: string;
Begin
  Result := False;
  strFiliais := fRetForFilialTodos(True);
  if strFiliais <> '""' Then
    Result := Pos(strCodFor, strFiliais) > 0;
End;

{*********************************************************************}
{* FILTRA UMA STRING QUALQUER, CONVERTENDO AS SUAS PARTES NUMERICAS  *}
{* PARA SUA REPRESENTACAO DECIMAL. 																	 *}
{* EX : R$ 1.200,00 PARA 1200,00   																	 *}
{* EX2: 1AB34TZ PARA 134  																					 *}
{******************************************************************DV*}
function StringToFloat(str : String) : Extended;
Var
  intIndice :Integer;
  strAux : String;
  SeenDecimal,SeenSgn : Boolean;
begin
  strAux := '';
  If str = '' Then str := '0';
  SeenDecimal := False;
  SeenSgn := False;
  For intIndice := Length(str) Downto 0 Do
	  If CharInSet(str[intIndice], ['0'..'9', '-','+',FormatSettings.DecimalSeparator]) Then
	  Begin
		  If (str[intIndice] = FormatSettings.DecimalSeparator) And (Not SeenDecimal) Then
		  Begin
			  strAux := str[intIndice] + strAux;
			  SeenDecimal := True;
		  End
		  Else
      If CharInSet(str[intIndice], ['+','-']) And (Not SeenSgn) and (intIndice = 1) Then
		  Begin
			  strAux := str[intIndice] + strAux;
			  SeenDecimal := True;
		  End
		  Else
      If CharInSet(str[intIndice], ['0'..'9']) Then
		  Begin
			  strAux := str[intIndice] + strAux;
		  End;
	  End;
	  Result := fStrToFloat(strAux);
end;








{*******************************}
{* RETORNA O NOME DA ATIVIDADE *}
{****************************AF*}



{**********************************************}
{* CALCULA MEDIA DA CONDICAO DE PAGAMENTO      }
{*******************************************WI*}

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

function fRemoveAcentoPontos(Str:String): String;
Begin
  Result := fRemoveAcento(Str);
  Result := ReplaceStr(Result,'.','');
  Result := ReplaceStr(Result,',','');
end;

procedure pRemoveAcentoVarRel(frx: TfrxReport; arrVar:  Array Of String);
  Var
    strVar: String;
begin
 {********************************************}
 {* IMPLEMENTADA TAMBÉM EM untFuncoesFactory *}
 {* SE MODIFICAR ALGO AQUI MUDAR LÁ TAMBÉM   *}
 {*****************************************VA*}
  For strVar In arrVar Do
    Try
      frx.Script.Variables[strVar]:=fRemoveAcento(frx.Script.Variables[strVar]);
    Except

    End;
end;


procedure pRemoveAcentoObjRelFortes(Var obj: TForm);
  Var
    intContador: Integer;
begin
  For intContador := 0 To obj.ComponentCount -1 Do
  Begin
    If (obj.Components[intContador] Is TRLLabel) Then
    Begin
      TRLLabel(obj.Components[intContador]).Caption := fRemoveAcento(TRLLabel(obj.Components[intContador]).Caption);
    End;
  End;
end;

function fCriaDataSource(DataSet: TDataSet): TDataSource;
begin
  Result := TDataSource.Create(DataSEt);
  Result.DataSet := DataSet;
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


{*****************************************}
{* ESSA FUNÇÃO RETORNA UM COMPONENTE QUE *}
{* ESTÁ EM OWNER. CASO NAO EXISTA, RE -  *}
{* TORNA NIL                             *}
{* ESSE DETINHO É BOM MESMO!!! >;^)      *}
{**************************************MV*}
function fComponentByName(Owner: TWinControl; strNome: String): TComponent;
  Var
    intContador: Integer;
begin
  Result := Nil;

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin
    If (Owner.Controls[intContador] Is TControl) Then
      If AnsiUpperCase((Owner.Controls[intContador] As TControl).Name) = AnsiUpperCase(strNome) Then
      Begin
        Result := (Owner.Controls[intContador] As TControl);
        Break;
      End;
  End;

end;

{****************************}
{* RETORNA O NOME DO ESTADO *}
{*************************LB*}
function fRetNomeEstado(strNomeEstado: String): String;
  Var
    intContador: Integer;
Begin

  For intContador := 0 To Length(ESTADOS)-1 Do
  Begin

    If strNomeEstado = String(ESTADOS[intContador]) Then
    Begin
      Result := DES_ESTADOS[intContador];
      Break;
    End;
  End;
End;

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

function fFormataCCusto(strValor: String): String;
Begin

  strValor := AnsiReplaceStr(strValor,'.','');
  strValor := AnsiReplaceStr(strValor,',','');
  strValor := AnsiReplaceStr(strValor,'-','');
  strValor := AnsiReplaceStr(strValor,'/','');

  Result := Trim(strValor);

  If Not fEmptyStr(Result) Then
  Begin
    Insert('.',Result,3);  // XX.XX.XXX
    Insert('.',Result,6);  // XX.XX.XXX
  End;

End;

function fControlByName(Owner: TWinControl; strNome: String): TControl;
  Var
    intContador: Integer;
begin
  Result := Nil;

  For intContador := 0 To Owner.ControlCount -1 Do
  Begin
    If (Owner.Controls[intContador] Is TControl) Then
      If (Owner.Controls[intContador] As TControl).Name = strNome Then
      Begin
        Result := (Owner.Controls[intContador] As TControl);
        Break;
      End;
  End;

end;

{************************}
{* FORMATA GRUPO E ITEM *}
{*********************AF*}
procedure pFormataGrupoItem(Var strGrupItem: String);
Begin
  Insert('.',strGrupItem,5);
End;

{*******************************************************}
{* RETORNA O NOME DA UNIDADE DE ACORDO COM O CÓDIGO    *}
{****************************************************LB*}
function fRetNomUnidade(strCodUni: String): String;
  Var
    strSQL   : String;
    qryGenUni: TUniQuery;

Begin
  Try

    qryGenUni := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADUNI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  UNI_CODUNI = :CODUNI ';

    With qryGenUni Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODUNI').AsString := strCodUni;

      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('UNI_DESUNI').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenUni);
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


function fGetPosLetraAlfa(strLetra: String): Integer;
  Var strAlfa: String;
Begin
  strAlfa := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  Result := Pos(strLetra, strAlfa);
End;

function fGetLetraAlfaAnterior(strLetra: String; intQtd: Integer=1): String;
  Var strAlfa: String;
      intAux: Integer;
Begin
  strAlfa := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  intAux := Pos(strLetra, strAlfa)-intQtd;

  If intAux < 1 Then
    intAux:=1;

  Result:=strAlfa[intAux];
End;

function fInc(Var intValor: Integer) : Integer;
begin
  Inc(intValor);
  Result := intValor;

End;

function fFrtStrExcel(strValor: String) : String;
begin
  Result := '''' + Trim(strValor);
end;



procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere,
  strMarca, strUnidad: String);
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

Begin
  Try

    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  ITE_DESITE, ';
    strSQL := strSQL + '  ITE_CODMAR, ';
    strSQL := strSQL + '  ITE_CODUNI, ';
    strSQL := strSQL + '  ITE_REFERE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    If Not fEmptyStr(strGrupo) Then
      strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
    //strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      If Not fEmptyStr(strGrupo) Then
        ParamByName('CODGRU').AsString := strGrupo;
      //ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      strNome   := FieldByName('ITE_DESITE').AsString;
      strRefere := FieldByName('ITE_REFERE').AsString;
      strMarca  := FieldByName('ITE_CODMAR').AsString;
      strUnidad := FieldByName('ITE_CODUNI').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

End;

procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere,
  strMarca, strUnidad: String); Overload;
begin
  pRetDadosItem(strCodIte, '', strNome, strRefere, strMarca, strUnidad);
end;

function fRetCodVendedor(strSenha: String; blnGerente : Boolean = False; blnSubGerente: Boolean = False; blnRepresentante: Boolean = False): String;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_CODOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BINARY OPE_SENOPE = :SENOPE ';

    if (blnGerente) then
      strSQL := strSQL + '  AND (OPE_INTEXT = "G") '

    Else if (blnSubGerente) then
      strSQL := strSQL + '  AND (OPE_INTEXT = "S") '

    Else if (blnRepresentante) then
      strSQL := strSQL + '  AND ((OPE_INTEXT = "E") OR (OPE_INTEXT = "D")) ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('SENOPE').AsString := fCrypt(strSenha);
      Open;
      Result := Fields[0].AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;



function fRetSenhaVendedor(strCodVen: String): String;
  Var
    strSQL   : String;
    qryGenOpe: TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_SENOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADOPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BINARY OPE_CODOPE = :CODOPE ';

    With qryGenOpe Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodVen;
      Open;
      Result := fDecrypt(Fields[0].AsString);
      Close;
    End;

  Finally
    FreeAndNil(qryGenOpe);
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



function fEhItemTributado(strCodFis: String): Boolean;
begin
  Result := (Pos(strCodFis, CST_TRIBUTADO) > 0);
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


function fRetCodEmpClienteFilial(strCliFil: String): String;
  Var
    qryDoc : TUniQuery;
begin
  qryDoc := fCriaQuery(Nil);
  With qryDoc, SQL Do
  Begin
    Add(' SELECT EMP_CODEMP ');
    Add('   FROM CADEMP ');
    Add('  WHERE EMP_CLIFIL = :CLIFIL');
    ParamByName('CLIFIL').AsString := strCliFil;
    Open;
    Result := FieldByName('EMP_CODEMP').AsString;
    Close;
  End;
  FreeAndNil(qryDoc);
end;

function fClientSelectEhClientFilialEmpLogada(strCodCli: String): Boolean;
begin
  Result := (Not fEmptyStr(strCodCli)) And (fRetornaClienteFilial(VS_strCodEmp) = strCodCli);
end;


{*********************************************************}
{* RETORNA AS EMPRESAS QUE O USUARIO TEM ACESSO          *}
{******************************************************LU*}
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


function fRetEmpEstUsuario(strCodOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_EMPEST ';
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
      Result := FieldByName('OPE_EMPEST').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function fRetEmpLoginUsuario(strCodOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;

begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  OPE_EMPLOG ';
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
      Result := FieldByName('OPE_EMPLOG').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;


{*****************************************}
{* RETORNA O SEQUENCIAL DE FATURAMENTO   *}
{* PARA A ESPÉCIE ESCOLHIDA E INCREMENTA *}
{**************************************JB*}
function fRetSequencial(strNomCam: String; strCodEmp: String = ''; intTamanho: Integer = 6): String;
  Var
    blnComita: Boolean;
    qryCfgSis: TUniQuery;

begin
  Try
    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    fCfgSis(strNomCam, varString, strCodEmp);//Necessario para criar a configuracao quando nao existir

    qryCfgSis := fCriaQuery(nil);

    blnComita := False;

    If Not frmModulo.GetCurrentConnection.InTransaction Then
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

        fAtuCfgSis(strNomCam, IntToStr(StrToInt64Def(Result, 0)+1), strCodEmp);

      End;

      If blnComita Then
        fCommit;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;

        Raise Exception.Create('Não consegui pegar o proximo sequencial de ' + strNomCam + ' em CFGSIS. Tente novamente!');
      End;
    End;

  Finally
    FreeAndNil(qryCfgSis);
  End;

end;





function fCadEmpDes(strNomCampo, strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery;

    If fEmptyStr(strCodEmp) Then
      strCodEmp := VS_strCodEmp;

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '   CADEMP.*, ';
    strSQL := strSQL + '   CID_NOMCID AS "EMP_NOMCID", ';
    strSQL := strSQL + '   CID_ESTADO AS "EMP_ESTADO"  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADEMP ';
    strSQL := strSQL + '   JOIN CADCID ON EMP_CODCID = CID_CODCID ';
    strSQL := strSQL + ' WHERE EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If FieldByName('EMP_' + strNomCampo).IsNull Then
      Begin
        Result := '';
      End
      Else
      Begin
        Result := FieldByName('EMP_' + strNomCampo).AsVariant;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;

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

procedure pCriarCfgSis(strCodCfg: String; strDesCfg: String; strGruCfg: String; strValCfg: String);
Var
  qryGen: TUniQuery;
  strSQL   : String;
Begin
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT  *                  ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   CFGSIS                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   SIS_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   SIS_CODCFG = :CODCFG     ';

    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryGen.ParamByName('CODCFG').AsString := strCodCfg;
    qryGen.Open;

    If qryGen.IsEmpty Then
    Begin
      qryGen.Insert;
      qryGen.FieldByName('SIS_CODEMP').AsString := VS_strCodEmp;
      qryGen.FieldByName('SIS_CODCFG').AsString := strCodCfg;
      qryGen.FieldByName('SIS_DESCRI').AsString := strDesCfg;
      qryGen.FieldByName('SIS_VALCFG').AsString := strValCfg;
      qryGen.FieldByName('SIS_GRUCFG').AsString := strGruCfg;
      qryGen.FieldByName('SIS_NUMHLP').AsString := '0';
      qryGen.Post;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
End;

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
        strConnID := fGetConnectionID;
    Except
      strConnID := '';
    End;
  End;

  strVersionTitle := 'Auttin';
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
          Begin
            If fNaoCriarConfiguracoes(strCamCfg) Then
            Begin
              fMensagem('ATENÇÃO', 'A configuração ( ' + 'CFG_' + strCamCfg + ' ) não existe na empresa ' + strCodEmp + '.' + sLineBreak +
               'Entre em contato com a CITEL para resolvermos o problema.', ['&Ok']);
              FreeAndNil(qryGenCfg);
              Exit('');
            End;
          End;

          If IsEmpty Then
            if (not fCriarConfiguracoes('CFG_' + strCamCfg, strCodEmp)) then
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
            strAux:=fDecrypt(strRes);
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

{**************************************************}
{* RETORNA AS EMPRESAS QUE POSSUEM A CONFIGURAÇÃO *}
{* COM UM DETERMINADO VALOR                       *}
{***********************************************AJ*}
function fCfgSisEmp(strCodCfg, strValCfg: String): String;
  Var
    strSQL   : String;
    qryGenCfg: TUniQuery;
Begin
  Result := '';
  qryGenCfg := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT  SQL_NO_CACHE       ';
  strSQL := strSQL + '   SIS_CODEMP               ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CFGSIS                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   SIS_CODCFG = :CODCFG AND ';
  strSQL := strSQL + '   SIS_VALCFG = :VALCFG     ';

  With qryGenCfg Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('VALCFG').Value := strValCfg;
    ParamByName('CODCFG').Value := 'CFG_' + strCodCfg;
    Open;

    If Not IsEmpty Then
    Begin
      While Not Eof Do
      Begin
        Result := Result + FieldByName('SIS_CODEMP').AsString + '_';

        Next;
      End;
    End;
  End;

  FreeAndNil(qryGenCfg);
End;


{************************************************************}
{* EXECUTA/ABRE UM ARQUIVO EM SEU APLICATIVO CORRESPONDENTE *}
{*********************************************************LU*}
procedure pExecArquivo(strArquivo: String; Handle: THandle);
Var
  Result: String;
Begin

  Case ShellExecute(Handle, nil, PChar(strArquivo), nil, nil, SW_SHOWNORMAL) Of
    ERROR_FILE_NOT_FOUND: Result := 'The specified file was not found.';
    ERROR_PATH_NOT_FOUND: Result := 'The specified path was not found.';
    ERROR_BAD_FORMAT: Result := 'The .EXE file is invalid (non-Win32 .EXE or error in .EXE image).';
    SE_ERR_ACCESSDENIED: Result := 'Windows 95 only: The operating system denied access to the specified file.';
    SE_ERR_ASSOCINCOMPLETE: Result := 'The filename association is incomplete or invalid.';
    SE_ERR_DDEBUSY: Result := 'The DDE transaction could not be completed because other DDE transactions were being processed.';
    SE_ERR_DDEFAIL: Result := 'The DDE transaction failed.';
    SE_ERR_DDETIMEOUT: Result := 'The DDE transaction could not be completed because the request timed out.';
    SE_ERR_DLLNOTFOUND: Result := 'Windows 95 only: The specified dynamic-link library was not found.';
    SE_ERR_NOASSOC: Result := 'There is no application associated with the given filename extension.';
    SE_ERR_OOM: Result := 'Windows 95 only: There was not enough memory to complete the operation.';
    SE_ERR_SHARE: Result := 'A sharing violation occurred.';
  Else
    Exit;
  End;

  ShowMessage(Result);

End;

{********************************************}
{* UMA MANEIRA DIFERENTE DO FREEANDNIL PARA *}
{* LIBERAR FORMULÁRIOS DA MEMÓRIA           *}
{*****************************************AF*}
procedure pFreeAndNil(var frmForm);
Begin
  If Assigned(TForm(frmForm)) Then
  Begin
    Try
      FreeAndNil(frmForm);
    Except
      // Apenas para nao dar erro;
    End;
  End;
  pTrimAppMemorySize;
  Application.ProcessMessages;
End;

{**********************************************************}
{* VETOR CONTENDO TABELAS PARA CADASTRO PROCOD AUTOMATICO *}
{* PS: VER FUNCAO "fValidaProcod"                         *}
{*******************************************************JC*}
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

  arrProCod[intPosMat].strNomArq := 'CADACA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
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
  arrProCod[intPosMat].strCodSeq := '01';
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

  arrProCod[intPosMat].strNomArq := 'CHR_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHR_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHR_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CHR_CADCHR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod  := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod  := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod  := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CLB_CADCLB';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod  := 6;
  arrProCod[intPosMat].strCodAut := 'N';
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

  arrProCod[intPosMat].strNomArq := 'ADS_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADS_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADS_CADLIN';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADS_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ADS_CADADS';
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

  arrProCod[intPosMat].strNomArq := 'DCA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADDCA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LUZ_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LUZ_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LUZ_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LUZ_CADLUZ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRT_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRT_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRT_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PRT_CADPRT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
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

  arrProCod[intPosMat].strNomArq := 'AN2_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AN2_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AN2_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AN2_CADAN2';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
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

  arrProCod[intPosMat].strNomArq := 'MEG_CADMEG';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADBAS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADCOL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADNFM';
  arrProCod[intPosMat].strCodSeq := '0000000001';
  arrProCod[intPosMat].intTamCod := 10;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DCA_CADDCA';
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


  arrProCod[intPosMat].strNomArq := 'LOGITE';
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
  //

  arrProCod[intPosMat].strNomArq := 'ALK_CADNFM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADBAS';
  arrProCod[intPosMat].strCodSeq := '0000001';
  arrProCod[intPosMat].intTamCod := 7;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'ALK_CADALK';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
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

  arrProCod[intPosMat].strNomArq := 'KIN_CADLIN';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 3;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADMON';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADORI';
  arrProCod[intPosMat].strCodSeq := '001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'KIN_CADKIN';
  arrProCod[intPosMat].strCodSeq := '00000001';
  arrProCod[intPosMat].intTamCod := 8;
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

  arrProCod[intPosMat].strNomArq := 'LOGEND';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
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

  arrProCod[intPosMat].strNomArq := 'LOGACE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

// ##PROCOD## // COLOCADO PARA PESQUISAR O FIM DO PROCOD MAIS RÁPIDO.
End;

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




function fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;


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

function fLock_Unlock(strNomeTabela: String;
                      blnTrava: Boolean;
                      blnLoopTravamento: Boolean = True;
                      blnHourGlass: Boolean = FALSE;
                      strCon_Id: String = '';
                      blnMostraMsgTravamento: Boolean = True;
                      strOrigem: String = '';
                      blnManual: Boolean = False): Boolean;
  Var
    strLock: String;
    qryLock_Unlock: TUniQuery;
    blnComitar: Boolean;
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
      qryLock_Unlock.ParamByName('NUM_IP').AsString := GetIPAddressAsString;
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
Begin

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

    strLock := 'INSERT INTO LCKATC (LCK_DTALCK, LCK_HRALCK, LCK_NUM_IP, LCK_CON_ID, LCK_CHAACE, LCK_CODOPE, LCK_ORIGEM, LCK_QTDTRA) ' +
               'VALUES (:DTALCK, :HRALCK, :NUM_IP, :CON_ID, :CHAACE, :CODOPE, :ORIGEM, :QTDTRA)';

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

End;

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
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_NUM_IP').AsString;

  FreeAndNil(qryGen);
End;

procedure pGravaLogLck(strNum_IP, strCon_ID, strChaAce, strCodOpe: String; intTentat: Integer; dtaDtaLck, dtaHraLck: TDateTime);
  Var
    qryLogLck : TUniQuery;
    strSQL    : String;
begin
  qryLogLck := fCriaQuery(Nil);
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' REPLACE ';
      strSQL := strSQL + '   INTO LOGLCK ( ';
      strSQL := strSQL + '     LCK_NUM_IP, ';
      strSQL := strSQL + '     LCK_CON_ID, ';
      strSQL := strSQL + '     LCK_CHAACE, ';
      strSQL := strSQL + '     LCK_CODOPE, ';
      strSQL := strSQL + '     LCK_TENTAT, ';
      strSQL := strSQL + '     LCK_DTALCK, ';
      strSQL := strSQL + '     LCK_HRALCK, ';
      strSQL := strSQL + '     LCK_DTALIB, ';
      strSQL := strSQL + '     LCK_HORLIB, ';
      strSQL := strSQL + '     LCK_OPELIB) ';
      strSQL := strSQL + ' VALUES ( ';
      strSQL := strSQL + '     :NUM_IP, ';
      strSQL := strSQL + '     :CON_ID, ';
      strSQL := strSQL + '     :CHAACE, ';
      strSQL := strSQL + '     :CODOPE, ';
      strSQL := strSQL + '     :TENTAT, ';
      strSQL := strSQL + '     :DTALCK, ';
      strSQL := strSQL + '     :HRALCK, ';
      strSQL := strSQL + '     :DTALIB, ';
      strSQL := strSQL + '     :HORLIB, ';
      strSQL := strSQL + '     :OPELIB) ';

      With qryLogLck Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUM_IP').AsString  := strNum_IP;
        ParamByName('CON_ID').AsString  := strCon_ID;
        ParamByName('CHAACE').AsString  := strChaAce;
        ParamByName('CODOPE').AsString  := strCodOpe;
        ParamByName('TENTAT').AsInteger := intTentat;
        ParamByName('DTALCK').AsDateTime:= dtaDtaLck;
        ParamByName('HRALCK').AsDateTime:= dtaHraLck;
        ParamByName('DTALIB').AsDateTime:= VS_Date;
        ParamByName('HORLIB').AsDateTime:= fTime();
        ParamByName('OPELIB').AsString  := strLoginUsuarioLogado;
        ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro('Erro ao gravar LOGLCK', 'pGravaLogLck', E.Message);
        FreeAndNil(qryLogLck);
      End;
    End;
  Finally
    FreeAndNil(qryLogLck);
  End;
end;

function fTempoExecucaoExcedido: Boolean;
begin
  Result := False;
  If Not fEmptyStr(ParamStr(1)) Then
  Begin
    If Pos(ParamStr(1), PARAM_EXEC_SFAMOB) > 0 Then
      Result := (MinutesBetween(Date + fTime(True), VS_dtaHraInicializacao) >= LIMIT_TEMP_SFAMOB)
    Else If Pos(ParamStr(1), PARAM_EXEC_MOVMER) > 0 Then
      Result := (MinutesBetween(Date + fTime(True), VS_dtaHraInicializacao) >= LIMIT_TEMP_MOVMER)
  End;
end;

function fImportadorExcutando(strCHAVE: String): Boolean;
begin
  Result := (Not fEmptyStr(fGetHostLock(strCHAVE)));
end;

procedure pChamaAutComModoImportacao(strCHAVE, strPARAM: String; intTEMPO_LIMITE: Integer);
  Var
    recUltimoLock: TInfLckAtc;

  function StartProcess(Exename: String; CmdLineArgs: String = ''; ShowWindow: Boolean = False;
    WaitForFinish: Boolean = False): integer;
  var
    StartInfo: TStartupInfo;
    ProcInfo: TProcessInformation;
    CreateOK: boolean;
  begin
    // Simple wrapper for the CreateProcess command
    // returns the process id of the started process.
    FillChar(StartInfo, SizeOf(TStartupInfo), #0);
    FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
    StartInfo.cb := SizeOf(TStartupInfo);

    If Not ShowWindow Then
    begin
      StartInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartInfo.wShowWindow := SW_HIDE;
    end;

    CreateOK := CreateProcess(nil, PChar(Exename + ' ' + CmdLineArgs), nil, nil, False,
      CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

    Result := ProcInfo.dwProcessId;

    if CreateOK then
    begin
      // may or may not be needed. Usually wait for child processes
      if WaitForFinish then
        WaitForSingleObject(ProcInfo.hProcess, Infinite);
    end
    else
    begin
      // ShowMessage('Unable to run '+ProgramName);
      SysErrorMessage(GetLastError());
    end;

    // close process & thread handles
    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);
  end;

begin
  If (intTEMPO_LIMITE > -1) Then
  Begin
    recUltimoLock := fRetUltimoLock(strCHAVE);

    If (recUltimoLock.dtaDtaHraLck > 0) And (MinutesBetween(fNow(), recUltimoLock.dtaDtaHraLck) >= intTEMPO_LIMITE) Then
    Begin
    pDestravaLockForcado(strCHAVE, 0);
      With recUltimoLock Do
        pGravaLogLck(strNum_IP, strCon_ID, '(*)'+strChaAce, strCodOpe, intTentat, dtaDtaLck, dtaHraLck);
    End;
  End;

  If (Not fImportadorExcutando(strCHAVE)) Then
    StartProcess(Application.ExeName, strPARAM);
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
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.Open;

  Result := qryGen.FieldByName('LCK_TENTAT').AsInteger;

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
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

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
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

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
    strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

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
  strSQL := strSQL + '  LCK_CHAACE LIKE :CHAACE ';

  qryGen.SQL.Text := strSQL;
  qryGen.ParamByName('CHAACE').AsString := strNomeTabela;
  qryGen.ExecSQL;

  FreeAndNil(qryGen);
end;

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

procedure pAlertaDeslizante(Sender: TForm; strTexto: String; intX, intY: Integer;
  intTimeOut: Integer = 3);
  Const
    TEMPO_ANIMACAO = 1000;
begin
  Try
    pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
    frmWaitWindow.Visible := True;
    frmWaitWindow.Visible := False;
    frmWaitWindow.lblTexto.Layout := StdCtrls.TTextLayout(tlCenter);
    frmWaitWindow.lblTexto.Alignment := Classes.TAlignment(taCenter);
    frmWaitWindow.lblTexto.Font.Style := [fsBold];
    frmWaitWindow.lblTexto.Caption := strTexto;
    frmWaitWindow.tmrWait.Interval := (intTimeOut * 1000) + TEMPO_ANIMACAO;
    frmWaitWindow.Left := intX+25;
    frmWaitWindow.Top  := intY-frmWaitWindow.Height-10;
    AnimateWindow(frmWaitWindow.Handle, TEMPO_ANIMACAO, AW_HOR_POSITIVE Or AW_SLIDE);
    frmWaitWindow.Show;
    frmWaitWindow.Refresh;
    frmWaitWindow.tmrWait.Enabled := True;

    If (Sender <> Nil) Then
      pSetFocus(Sender);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[pAlertaDeslizante]');
    End;
  End;
end;

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

{********************************}
{* PEGA O NUMERO PASSADO POR    *}
{* PARAMETRO E FORMATA ELE SEM  *}
{* PONTOS, SEM VIRGULAS E COM-  *}
{* PLETADO COM ZEROS A ESQUERDA *}
{*****************************AF*}
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



function fTiraCaracEspeciaisParenteses(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '/\-_+#,;<>():';

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

Procedure pCriaTabelaDel(strNomTab: String);
  Var
    qryTabOriginal: TUniQuery;
Begin
  qryTabOriginal := fCriaQuery;
  With qryTabOriginal Do
  Begin
    SQL.Text := 'SELECT * FROM ' + strNomTab + ' WHERE FALSE ';
    Open;
    fVerificaIntegridade('', strNomTab, qryTabOriginal, FALSE, TRUE);
    Close;
  End;
  FreeAndNil(qryTabOriginal);
End;

{****************************************************************************************}
{* MONTA UM SQL PARA FORCAR O ARRENDONDAMENTO DA MESMA FORMA QUE A FUNCAO FFORMATAFLOAT *}
{*************************************************************************************JC*}
function fRoundSql(const strCampo: String; const intDecimais: Integer): String;
begin
  Result := '';

  //SE O VALOR POSSUI CASAS DECIMAIS E
  Result := Result + 'IF(LOCATE(".", {CAMPO}) > 0 AND ';

  //SE A PRECISAO DESEJADA FOR INFORMADA
  Result := Result + '   {PRECISAO} > 0 AND ';

  //SE A PRECISAO FOR MENOR QUE A QUANTIDADES DE CASAS DECIMAIS E
  Result := Result + '   LENGTH({CAMPO}) - LOCATE(".", {CAMPO}) > {PRECISAO} AND ';

  //SE O ULTIMO NUMERO TERMINAR EM 5
  Result := Result + '   MID({CAMPO}, LENGTH({CAMPO}), 1) = "5", ';

  //ENTAO SUBSTITUI O ULTIMO DIGITO DE "5" PARA "6" FORCANDO O ARREDONDAMENTO PARA CIMA
  Result := Result + ' CONCAT(LEFT({CAMPO}, LENGTH({CAMPO}) - 1), "6"), ';

  //SENAO MANTEM O PROPRIO NUMERO
  Result := Result + ' {CAMPO}) ';

  //ARREDONDA O NUMERO COM A PRECISAO INFORMADA
  Result := ' ROUND(' + Result + ', {PRECISAO}) ';

  Result := AnsiReplaceStr(Result, '{CAMPO}', strCampo);
  Result := AnsiReplaceStr(Result, '{PRECISAO}', intDecimais.ToString);
end;

{*****************************************************************************************}
{* SOMENTE RESERVA ESTOQUE DOS SUB.PRODUTOS ENQUANTO A ORDEM DE PRODUCAO NAO FOR BAIXADA *}
{*************************************************************************************JC**}
{*****************************************************************************************}
{* SOMENTE RESERVA ESTOQUE DOS SUB.PRODUTOS ENQUANTO A ORDEM DE PRODUCAO NAO FOR BAIXADA *}
{*************************************************************************************JC**}




Function fLastInsertID: String;
  Var
    qryLast: TUniQuery;
Begin
  qryLast := fCriaQuery;

  qryLast.SQL.Text := 'SELECT LAST_INSERT_ID() AS LSTNUM';
  qryLast.Open;
  Result := qryLast.FieldByName('LSTNUM').AsString;

  FreeAndNil(qryLast);
End;

function fItemPigmento(strCodIte: String; Var strCodBas: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result    := False;
  strCodBas := '';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT                                     ');
  qryAux.SQL.Add('  BAS_CODBAS                               ');
  qryAux.SQL.Add('FROM                                       ');
  qryAux.SQL.Add('  DUP_CADBAS                               ');
  qryAux.SQL.Add('WHERE                                      ');
  qryAux.SQL.Add('  BAS_CODITE = :CODITE                     ');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  If (Not qryAux.IsEmpty) Then
  Begin
    Result    := True;
    strCodBas := qryAux.FieldByName('BAS_CODBAS').AsString;
  End;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

function fEhAdministrador(strCodOpe: String): Boolean;
Begin
  Result := SameText('999', strCodOpe) Or
            SameText('998', strCodOpe) Or
            SameText('997', strCodOpe);
End;

{********************************************************}
{* VERIFICAD SE O OPERADOR TEM DIREITO AO FORM A SER    *}
{* ACESSADO RETORNANDO TRUE SE TEM ACESSO E FALSE SE    *}
{* NAO TEM ACESSO                                       *}
{*****************************************************AF*}
function fVerPermissaoOperador(strNomForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
    strSQL     : String;
    qryGenOpe  : TUniQuery;

begin
  Try

    qryGenOpe := fCriaQuery;

    If (Not fEmptyStr(strCodOpe)) Then
      strOperador := strCodOpe
    Else
      strOperador := strLoginUsuarioLogado;

    If (strNomForm = 'frmLogoff') Or (strNomForm = 'frmSobre') Then
    Begin
      Result := True;
      exit;
    End;

    If Not fEhAdministrador(strOperador) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '   DIROPE ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   OPE_CODOPE = :CODOPE AND ';
      strSQL := strSQL + '   DIR_NOMFRM = :NOMFRM ';
      Result := False;
      With qryGenOpe Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strOperador;
        ParamByName('NOMFRM').AsString := strNomForm;
        Open;
        If Not IsEmpty Then
          Result := True;
      End;
      qryGenOpe.Close;
    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryGenOpe);
  End;

end;

{***************************************************************}
{* VERIFICA SE O OPERADOR TEM ACESSO AO FORM PELO DIREITO      *}
{* DE GRUPO DE USUARIO CASO ELE NAO TENHA ACESSO COM OPERADOR  *}
{************************************************************AF*}
function fVerPermissaoOperadorPorGrupo(strNomForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
    strSQL     : String;
    qryGenGpo  : TUniQuery;

begin
  Try

    qryGenGpo := fCriaQuery;

    If (Not fEmptyStr(strCodOpe)) Then
      strOperador := strCodOpe
    Else
      strOperador := strLoginUsuarioLogado;

    If Not fEhAdministrador(strOperador) Then
    Begin
      Result := False;
      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   *  ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + '   DIRGPO D ';
      strSQL := strSQL + '   JOIN CADGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ';
      strSQL := strSQL + '   JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE AND ';
      strSQL := strSQL + '   D.DIR_NOMFRM = :NOMFRM ';
      With qryGenGpo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODOPE').AsString := strOperador;
        ParamByName('NOMFRM').AsString := strNomForm;
        Open;
        If Not IsEmpty Then
          Result := True;
      End;
      qryGenGpo.Close;
    End
    Else
      Result := True;

  Finally
    FreeAndNil(qryGenGpo);
  End;

end;

{**********************************}
{* VERIFICA SE TEM PERMISSÃO NO   *}
{* CADOPE E NO CADGPO             *}
{*******************************AF*}
function fVerificaAcessoSistema(strNomeForm: String; strCodOpe: String = ''): Boolean;
  Var
    strOperador: String;
Begin
  If (Not fEmptyStr(strCodOpe)) Then
    strOperador := strCodOpe
  Else
    strOperador := strLoginUsuarioLogado;

  If (strNomeForm = 'frmLogoff') Or (strNomeForm = 'frmSobre') Then
    Exit(True);

  If fEhAdministrador(strOperador) Then
    Exit(True);

  Result := TPermissoesAcesso.GetInstance.fVerificaAcesso(strNomeForm, strOperador);

  Result := Result Or fEmptyStr(strNomeForm);
End;

{*****************************************}
{* VALIDA UM NÚMERO E DETERMINADO INTER- *}
{* VALO                                  *}
{**************************************MV*}
function fValidaEscala(strTexto: String; intMinimo, intMaximo: Double): Boolean;
begin
  Result := True;
  Try
    If intMaximo < intMinimo Then
    Begin
      If fStrToFloat(strTexto) < intMinimo Then
      Begin
        Result := False;
      End;
    End
    Else If (fStrToFloat(strTexto) < intMinimo) Or
            (fStrToFloat(strTexto) > intMaximo) Then
    Begin
      Result := False;
    End;
  Except
    Result := False;
  End;
end;


function IfNull(varValor, varDefault: Variant): Variant;
begin
	Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

function IfEmptyStr(strValor, strDefault: String): String;
begin
  Result := strValor;
  If fEmptyStr(Result) Then
    Result := strDefault;
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

function fCriaAggregateField(cdsClient: TUniClientDataSet; strFieldName, strExpression: String;
                             strDisplayFormat: String = ''; blnActive: Boolean = True): TAggregateField;
Begin
  Result := TAggregateField.Create(cdsClient);
  With Result Do
  Begin
    FieldName := strFieldName;
    DataSet := cdsClient;
    Expression := strExpression;
    If Not fEmptyStr(strDisplayFormat) Then
      DisplayFormat := strDisplayFormat;
    Active := blnActive;
  End;
End;

{***************************************}
{* INCLUI A QUERY NO DATASET E DESTRÓI *}
{* O PROVIDER E A QUERY                *}
{************************************AJ*}
procedure pSetaClientDataSet(var qryData: TUniQuery;
  cdsData: TUniClientDataSet);
  Var
    dspData: TUniDataSetProvider;
begin
  dspData := TUniDataSetProvider.Create(Application);
  dspData.DataSet := qryData;
  cdsData.SetProvider(dspData);
  cdsData.Open;
  cdsData.LogChanges := False;
  cdsData.SetProvider(Nil);
  qryData.Close;

  FreeAndNil(dspData);
  FreeAndNil(qryData);
end;

function fIsItemEspecial(strCodIte: String): Boolean;
  Var
    qryGenIte: TUniQuery;
begin
  Try
    qryGenIte := fCriaQuery;

    With qryGenIte Do
    Begin
      SQL.Clear;

      SQL.Add('SELECT      ');
      SQL.Add('  ITE_DESITE');
      SQL.Add('FROM        ');
      SQL.Add('  CADITE    ');
      SQL.Add('WHERE       ');
      SQL.Add('  ITE_CODITE = :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If Not IsEmpty Then
      Begin
        If Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').asString) <= 0 Then
        Begin
          Result := False;
        End
        Else
        Begin
          Result := True;

        End;

      End
      Else
        Result := False;

    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

procedure pPlaySound(AFileName: String);
begin
  sndPlaySound(PWideChar(AFileName), SND_ASYNC);
end;

procedure pPlaySound(AStream: TMemoryStream);
begin
  sndPlaySound(AStream.Memory, (SND_ASYNC or SND_MEMORY));
end;

procedure pMensagemSonora(strMensagem: String; blnMaximizar: Boolean = False; intFontSize: Integer = 0;
  intWidth: Integer = 0; cfgArqSom: String = ''; blnMsgOkPadraoSeCfgPassadaMasVazia: Boolean = False); Overload;
  Var
    strPathSomAltera: String;
begin
  strPathSomAltera := '';
  If (Not fEmptyStr(cfgArqSom)) Then
    strPathSomAltera := fCfgSis(cfgArqSom, varString);

  If (blnMsgOkPadraoSeCfgPassadaMasVazia) And (Not fEmptyStr(cfgArqSom)) And (fEmptyStr(strPathSomAltera)) Then
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

        frmMensagemSonora.strPathSomAlerta := strPathSomAltera;

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

procedure pMensagemSonora(strMensagem: String; cfgArqSom: String; blnMsgOkPadraoSeCfgPassadaMasVazia: Boolean = False); Overload;
  Var
    strPathSomAltera: String;
begin
  If fEmptyStr(strMensagem) Then //Se strMensagem eu só quero que execute o som da CFG
  Begin
    strPathSomAltera := '';
    If (Not fEmptyStr(cfgArqSom)) Then
      strPathSomAltera := fCfgSis(cfgArqSom, varString);

    If (Not fEmptyStr(strPathSomAltera)) Then
      sndPlaySound(PWideChar(strPathSomAltera), 0);
  End
  Else
  Begin
    pMensagemSonora(strMensagem, False, 0, 0, cfgArqSom, blnMsgOkPadraoSeCfgPassadaMasVazia);
  End
end;

{***********************************}
{ INSERE MASCARA DE CEP             }
{********************************JB*}
function fFormataCEP(strCEP: String): String;
begin
	Result := '';

  If Not fEmptyStr(strCEP) Then
  Begin
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),0,5) + '-';
    Result := Result + MidStr(fTiraCaracEspeciaisPonto(strCEP),6,3);
  End;

end;

{***********************************}
{ INSERE MASCARA DE TELEFONE        }
{********************************JB*}
{function fFormataFone(strFone: String): String;
begin
  Result := '';

  If Not fEmptyStr(strFone) Then
  Begin
    Result := Result + '(';
    Result := Result + MidStr(strFone,0,2) + ')';
    Result := Result + MidStr(strFone,3,4) + '-';
    Result := Result + MidStr(strFone,7,4);
  End;

end;}

{*********************************************}
{* SETA A VARIAVEL DE SISTEMA "VS_blnTemFil" *}
{* INDICANDO SE HA FILIAIS CADASTRADAS       *}
{******************************************MV*}
procedure pCarregaVsTemFil;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;

begin
  Try

    qryGenEmp := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryGenEmp Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      If FieldByName('QTD').AsInteger > 1 Then
      Begin
        VS_blnTemFil := True
      End
      Else
      Begin
        VS_blnTemFil := False;
      End;

      Close;
    End;

  Finally
    FreeAndNil(qryGenEmp);
  End;

end;


function fRetTipOpe(strCodOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  OPE_INTEXT ';
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

      Result := FieldByName('OPE_INTEXT').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;






{**********************************************************************}
{* CRIA UM CLIENTDATASET COM A MESMA ESTRUTURA E VALORES DE UMA QUERY *}
{*******************************************************************JC*}
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

procedure pCopiaRegistroDataSet(dtsOrigem: TDataSet; dtsDestino: TDataSet; blnEdit: Boolean = False);
  Var
    intCont  : Integer;
begin
  If blnEdit Then
    dtsDestino.Edit
  Else
    dtsDestino.Append;

  With dtsOrigem Do
    For intCont := 0 To Fields.Count -1 Do
      dtsDestino.Fields[intCont].Value := Fields[intCont].Value;

  dtsDestino.Post;
end;

function fMediaTime(strMedia: String): Integer;
  Var
    intCont : Integer;
    intPos  : Integer;
    strHor  : String;
    strMin  : String;
    strSeg  : String;
    IntHorS : Integer;
    IntMinS : Integer;
    intSeg  : Integer;
begin
  IntPos := 0;
  strHor := '';
  strMin := '';
  strSeg := '';
  For IntCont := 1 To Length(StrMedia) Do
  Begin
    If strMedia[IntCont] = ':' Then
      intPos := IntPos + 1
    Else
    Begin
      If IntPos = 0 Then
        strHor := strHor + strMedia[IntCont]
      Else
      If IntPos = 1 Then
        strMin := strMin + strMedia[IntCont]
      Else
      If IntPos = 2 Then
        strSeg := strSeg + strMedia[IntCont]
    End;
  End;
  intHorS := strTointDef(strHor,0) * 3600;
  intMinS := strToIntDef(strMin,0) * 60;
  intSeg  := strToIntDef(strSeg,0);

  Result := (IntHorS + IntMinS + IntSeg);
end;

function fSegToTempoStr(intSegundos: Integer): String;

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
  fltHor := Int( (IntSegundos / 3600) );
  fltMin := Int( ( IntSegundos - ( fltHor * 3600 ) ) / 60 );
  fltSeg := IntSegundos - ( fltHor * 3600 ) - ( fltMin * 60 );

  Result := fFormata(FloatToStr(fltHor)) + ':' +
            fFormata(FloatToStr(fltMin)) + ':' +
            fFormata(FloatToStr(fltSeg));
end;

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





{

{*******************************}
{* RETORNA O ESTADO DA EMPRESA *}
{****************************RV*}
function fRetUFEmpresa(strCodEmp: String = ''): String;
begin
  If strCodEmp = '' Then
    strCodEmp := VS_strCodEmp;

  Result := fCampoTabela('CID_ESTADO', 'CADEMP INNER JOIN CADCID ON CID_CODCID = EMP_CODCID', ['EMP_CODEMP'], [strCodEmp], False);
end;

function fPesquisar(strTexto, strPalavra: String; intPosIni: Integer;
  var intPosIniRet, intPosFin: Integer): Boolean;
begin

  strPalavra := AnsiUpperCase(strPalavra);
  strTexto   := AnsiUpperCase(strTexto);

  intPosIniRet := PosEx(strPalavra, strTexto, intPosIni);
  If intPosIniRet > 0 Then
  Begin
    Result := True;
    Dec(intPosIniRet);
    intPosFin := intPosIniRet + Length(strPalavra);
  End
  Else
  Begin
    Result := False;
  End;

end;

function fPesquisarEdit(edtEdit: TCustomEdit; strPalavra: String;
  blnContinuacao: Boolean): Boolean;
  Var
    intPosIni: Integer;
    intPosFin: Integer;
    intFatSoma: Integer;
begin

  If blnContinuacao Then
    intFatSoma := 2
  Else
    intFatSoma := 0;

  If fPesquisar(edtEdit.Text, strPalavra, edtEdit.SelStart+intFatSoma, intPosIni, intPosFin) Then
  Begin
    Result := True;
    edtEdit.SelStart := intPosIni;
    edtEdit.SelLength := intPosFin - intPosIni;
    pSetFocus(edtEdit);
  End
  Else
  Begin
    Result := False;
  End;
end;

{*******************************************}
{* FUNCAO QUE RETORNA LISTA DE EMPRESAS QUE*}
{* UTILIZAM OS PRECOS DA EMPRESA MATRIZ,   *}
{* NO CASO SE A EMRESA ATUAL FOR A PROPRIA *}
{****************************************JC*}

function fUsaQtdPendenteEntregaFutura(blnConsiderarCfgCalSal: Boolean = True; strEmpSalRes : String = ''): Boolean;
begin
  {*********************************************************************}
  {* AO MUDAR AS CONDIÇÕES QUE DEIXA ESSA FUNÇÃO TRUE ADEQUAR A FUNÇÃO *}
  {* fRetSQLBaseadoNaCfgEmpOri EM untFatMostraEstoqueEmp               *}
  {******************************************************************VA*}
  Result := fCfgSis('ENTFUT', varBoolean, strEmpSalRes) And (Not fCfgSis('BEFTRG', VarBoolean));
  If blnConsiderarCfgCalSal Then
    Result := Result And MatchStr(fCfgSis('CALSAL'), ['1', '3', '4', '5']);
end;


function fGetMemoryTableNameEntregaFutura: String;
begin
  Result := fGetMemoryTableName('ENTFUT');
end;

function fGetMemoryTableName(strTabela: String): String;
begin
  Result := 'TMP_' + strTabela + '_' + fTiraCaracEspeciaisPonto(GetIPAddressAsString +
    IntToStr(Random(1000)) + FormatDateTime('yyyyMMddhhmmss', fNow()));
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



function fRetCidCliente(Const strCodCli: String): String;
Begin
  Result := fCampoTabela('CLI_CODCID', 'CADCLI', ['CLI_CODCLI'], [strCodCli]);
End;

function fRetEmailCliente(Const strCodCli: String; strIdxEmail: String = '1'): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  strSQL := 'SELECT CLI_EMAIL' + IIF(strIdxEmail = '1', '_', strIdxEmail);
  strSQL := strSQL + ' FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(strCodCli);

  qryGen := fCriarQuery(strSQL);
  With qryGen DO
  Begin
    Open;
    If Not IsEmpty Then
      Result := FieldByName(Fields[0].FieldName).AsString
    Else
      Result := '';
    Close;
  End;

  FreeAndNil(qryGen);
end;

{****************************************}
{* RETORNA O NOME DO CLIENTE CONSUMIDOR *}
{*************************************AF*}
function fRetDadosClienteConsumidor(strDocumento, strCampo: String): String;
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;
Begin
  Try

    qryGenCli := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + ' CON_' + strCampo + ' ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CLICON ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CON_C_P_F_ = :C_P_F_ ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('C_P_F_').AsString := strDocumento;
      Open;
      Result := Fields[0].AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

End;

function fRetNomClienteConsumidor(strCodigo : String):String;
Begin
  Result := fRetDadosClienteConsumidor(strCodigo, 'NOMCON');
End;

function fRetTabPrecoCliente(Const strCodCli: String): String;
  Var
    strSQL   : String;
    qryGenCli: TUniQuery;

Begin
  Try

    qryGenCli := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CLI_TABPRE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

    With qryGenCli Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('CLI_TABPRE').AsString
      Else
        Result := '';

      If fEmptyStr(Result) Then
        Result := '1';

      Close;
    End;

  Finally
    FreeAndNil(qryGenCli);
  End;

End;

function fRetClientePorCgcCpf(intCgcCpf: Integer; strC_G_C_: string): String;
begin
  Result := fCampoTabela('CLI_CODCLI', 'CADCLI', ['CLI_CGCCPF', 'CLI_C_G_C_'], [intCgcCpf, strC_G_C_]);
end;

function fEmptyDate(strDate: String): Boolean;
Begin
  Result := fEmptyStr(fTiraCaracEspeciais(strDate));
End;


function fEmptyTime(strTime: String): Boolean;
Begin
  Result := fEmptyStr(Trim(AnsiReplaceStr(strTime, ':', '')));
End;



{function fObtemVariavelAmbiente(const strNome: String): String;
Begin

  With TRegistry.Create do
    Try
      RootKey := HKEY_CURRENT_USER;
      OpenKey('Environment', False);
      Result := ReadString(strNome);
    Finally
      Free
    End;

End;
}

Function fPergunta(strMensagem: String): Boolean; Overload;
Begin
  Result := fMensagem('', strMensagem, ['&Sim', '&Não']) = 1;
End;

Function fPergunta(strMensagem: String; blnDefSim: Boolean): Boolean; Overload;
Begin
  Result := fMensagem('', strMensagem, ['&Sim', '&Não'], IIF(blnDefSim, 1, 2)) = 1;
End;

Function fInsereProCod(strNomTab: String; blnCodAut : Boolean = true): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM PROCOD ');
      Add('WHERE PRO_NOMARQ = :NOMARQ');

      ParamByName('NOMARQ').AsString := strNomTab;

      Open;

      If IsEmpty Then
      Begin

        Clear;
        Add('INSERT INTO PROCOD (PRO_NOMARQ, PRO_CODSEQ, PRO_TAMCOD, PRO_CODAUT, AUTOINCREM, PRO_CODEMP) ');
        Add('VALUES(:NOMARQ, "000001", 6, ' + IIF(blnCodAut, '"S"', '"N"') + ', :AUTINC, :CODEMP)');
        ParamByName('CODEMP').AsString := fRetEmpresaFisica;
        ParamByName('NOMARQ').AsString := strNomTab;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('PROCOD', VS_strCodEmp);
        ExecSQL;

        Clear;
        Add('INSERT INTO PROINC (PRO_NOMARQ, PRO_AUTINC, AUTOINCREM) ');
        Add('VALUES(:NOMARQ, "1", :AUTINC)');
        ParamByName('NOMARQ').AsString := strNomTab;
        ParamByName('AUTINC').AsString := fRetAutoIncrem('PROCOD', VS_strCodEmp);
        ExecSQL;
      End;

    End;

    FreeAndNil(qryGen);

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fInsereProCod]');
    End;
  End;
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

function fRetEnderecoEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CONCAT(EMP_ENDERE, ", ", EMP_ENDNUM) AS EMP_ENDERE ';
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
      Result := FieldByName('EMP_ENDERE').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;

function fRetFoneEmpresa(strCodEmp: String): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_FONE01 ';
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
      Result := FieldByName('EMP_FONE01').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGenEmp);
  End;
end;


{*******************************************}
{* RETORNA A VERSÃO ATUAL DO EXECUTÁVEL    *}
{****************************************MV*}
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

(*function fSenhaDestravarCodAut(strSenDig: String): Boolean;
  Var
    wrdAno,
    wrdMes,
    wrdDia: Word;
    intSenLib: Integer;
    intContador: Integer;
    strSenDec: String;
  Const
    intFatMul = 6;
begin
  DecodeDate(Date, wrdAno, wrdMes, wrdDia);

  intSenLib := wrdDia + wrdMes;

  For intContador := 1 To Length(IntToStr(wrdAno)) Do
  Begin
    intSenLib := intSenLib + StrToIntDef(Copy(IntToStr(wrdAno), intContador, 1), 0);
  End;

  intSenLib := intSenLib + StrToIntDef(RightStr(strSenDig, 3), 0);

  intSenLib := intSenLib * intFatMul;

  strSenDec := fStrZero(intSenLib, (Length(strSenDig)-3));

  strSenDec := strSenDec + RightStr(strSenDig, 3);

  //********************************************************//
  // VERIFICA SE A SENHA CALCULADA E IGUAL A SENHA DIGITADA //
  //*****************************************************ED*//
  Result := (strSenDec = strSenDig);

end;*)

Function fRetEmpresaFisica(conexao: TUniConnection = nil): String;
Begin
  Result := fCampoTabela('PRO_CODEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVGER'], False, '', conexao);
End;

Function fRetSiglaEmpresa(strCodEmp: String): String;
  Var
    qryGen: TUniQuery;
Begin
  Try
    Result := '';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Text := 'SELECT EMP_SIGLA_ FROM CADEMP WHERE EMP_CODEMP = :CODEMP';

      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      If Not IsEmpty Then
        Result := FieldByName('EMP_SIGLA_').AsString;
    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.Message, '[fRetSiglaEmpresa]');
    End;
  End;

End;

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


function fModDouble(fltDividendo, fltDivisor: Double): Double;
begin
  Result := Frac(fltDividendo/fltDivisor)*fltDivisor;
end;

function fMenorMultiploValido(fltQtd, fltMlt: Double;  blnOlhaCFG: Boolean; Out blnCorteMulti: Boolean): Double;
 Var
   fltPassoSubtr: Double;
   strCfgMltVen: String;
begin
  Result := fltQtd;
  blnCorteMulti := False;
  strCfgMltVen := fCfgSis('MLTVEN', varString);

  If (((fltMlt = 1) Or (fltMlt = 0)) And (Frac(fFormataFloat(fltQtd, 6)) = 0)) Or
     (blnOlhaCFG And (strCfgMltVen = '2')) Then
  Begin
    Exit;
  End;

  If (blnOlhaCFG And (strCfgMltVen = '3')) Then
  Begin
    blnCorteMulti := (fModDouble(fFormataFloat(fltQtd, 6), fltMlt) <> 0);
  End
  Else
  Begin
    If (Not blnOlhaCFG) Or
       (blnOlhaCFG And (Pos(strCfgMltVen, '1_4_') > 0)) Then
    Begin
      Result := fFormataFloat(fltQtd, 6);

      If (Frac(fltMlt) = 0) And (Frac(Result) = 0) Then
        fltPassoSubtr := 1
      Else
        fltPassoSubtr := 0.00001;

      While (Result > 0) And (fModDouble(Result, fltMlt) <> 0) Do
      Begin
        blnCorteMulti := True;
        Result := fFormataFloat(Result - fltPassoSubtr, 6);
      End;

      If Result < 0 Then
        Result := 0;
    End;
  End
end;


Function fRetCodBarra(strCodIte: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;
      SQL.Add('SELECT ITE_CODBAR FROM CADITE');
      SQL.Add('WHERE ITE_CODITE = :CODITE');

      ParamByName('CODITE').AsString := strCodIte;
      Open;

      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('ITE_CODBAR').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;



Function fRetCodIte(strCodBar: String): String;
  Var
    qryGen: TUniQuery;
begin
  Try

    qryGen := fCriaQuery;

    With qryGen, SQL Do
    Begin
      Clear;
      SQL.Add('SELECT ITE_CODITE FROM CADITE');
      SQL.Add('WHERE ITE_CODBAR = :CODBAR LIMIT 1');

      ParamByName('CODBAR').AsString := strCodBar;
      Open;

      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('ITE_CODITE').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

Procedure pCopiaClientDataSet(cdsOrigem, cdsDestino: TUniClientDataSet);
  Var
    intContador: Integer;
Begin
  cdsDestino.Data := cdsOrigem.Data;

  For intContador := 0 To cdsOrigem.FieldCount -1 Do
  Begin
    cdsDestino.Fields[intContador].DisplayLabel := cdsOrigem.Fields[intContador].DisplayLabel;

    If cdsDestino.Fields[intContador].DataType = ftFloat Then
      TFloatField(cdsDestino.Fields[intContador]).DisplayFormat := TFloatField(cdsOrigem.Fields[intContador]).DisplayFormat;

  End;
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


function fTrataStr(const strValor: String): String;
begin
  Result := Trim(StrPas(PChar(strValor)));
end;

function fGetSQLInEmpresasAcesso(strAlias: String; strAcesso: String = ''): String;
  Var
    strEmpresa: String;
    stlEmpresas: TStringList;
begin
  If fEmptyStr(strAcesso) Then
    strAcesso := strEmpAcessoUsuarioLogado;

  stlEmpresas := TStringList.Create;
  stlEmpresas.Text := AnsiReplaceStr(strAcesso, '_', #13#10);

  Result := '';

  For strEmpresa In stlEmpresas Do
  Begin
    If Result <> '' Then
      Result := Result + ', ';
    Result := Result + QuotedStr(strEmpresa);
  End;

  If Result = '' Then
    Result := QuotedStr('');

  Result := ' ' + strAlias + ' IN (' + Result + ') ';

  FreeAndNil(stlEmpresas);
end;

function fValidaAcessoMultSelEmpresa(arrSelecao: TConsultasArray; Var strEmpNegadas: String): Boolean;
Var intCont: Integer;
begin
  Result := True;
  strEmpNegadas := '';

  For intCont := 0 to Length(arrSelecao)-1 do
  Begin
    If Pos(arrSelecao[intCont].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
    Begin
      strEmpNegadas := strEmpNegadas + arrSelecao[intCont].strCodigo + '-';
      Result := False;
    End;
  End;

  If Not fEmptyStr(strEmpNegadas) Then
    strEmpNegadas := LeftStr(strEmpNegadas, Length(strEmpNegadas)-1) + '.';

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



function fRetNomCfgTin(strCodCfg: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;

Begin
  Try

    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  CFG_DESCRI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CFGTIN ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFG_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  CFG_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFG').AsString := strCodCfg;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      If IsEmpty Then
        Result := ''
      Else
        Result := FieldByName('CFG_DESCRI').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;


function fGetConnectionID: String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT CONNECTION_ID()');
  qryAux.Open;

  Result := qryAux.Fields[0].AsString;

  FreeAndNil(qryAux);
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


Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
Begin
  With dtsDataSet Do
  Begin
    prcScroll := AfterScroll;
    AfterScroll := Nil;
    DisableControls;
  End;
End;

Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
Begin
  With dtsDataSet Do
  Begin
    EnableControls;
    AfterScroll := prcScroll;
    If blnRefresh then
      AfterScroll(dtsDataSet)
  End;
End;

Procedure pCloneDataSet(dtsDestino, dtsOrigem: TUniClientDataSet; blnComFomatacao: Boolean = False);
  Var
    intContador: Integer;
    prcScroll: TprcScroll;
Begin

  Try
    pDisableControls(dtsOrigem, prcScroll);

    dtsDestino.Data := dtsOrigem.Data;

    dtsDestino.LogChanges := False;

    If blnComFomatacao Then
    Begin
      For intContador := 0 To dtsOrigem.FieldCount -1 Do
      Begin
        dtsDestino.Fields[intContador].DisplayLabel := dtsOrigem.Fields[intContador].DisplayLabel;

        If dtsDestino.Fields[intContador].DataType = ftFloat Then
          TFloatField(dtsDestino.Fields[intContador]).DisplayFormat := TFloatField(dtsOrigem.Fields[intContador]).DisplayFormat;

      End;
    End;

  Finally
    pEnableControls(dtsOrigem, prcScroll);
  End;

End;

Function fDoubleAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Double;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

Function fDataAggregate(cdsClient: TUniClientDataSet; strNomCam: String): TDateTime;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;

Function fIntAggregate(cdsClient: TUniClientDataSet; strNomCam: String): Integer;
Begin
  With cdsClient Do
  If TAggregateField(FieldByName(strNomCam)).Value = Null Then
    Result := 0
  Else
    Result := TAggregateField(FieldByName(strNomCam)).Value;
End;



function fSqlCdsIteger: String;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ITE_CODITE, ';
  strSQL := strSQL + '   ITE_CODEMP, ';
  strSQL := strSQL + '   ITE_PREULT, ';
  strSQL := strSQL + '   ITE_PRECOM, ';
  strSQL := strSQL + '   ITE_DESF01, ';
  strSQL := strSQL + '   ITE_DESF02, ';
  strSQL := strSQL + '   ITE_DESF03, ';
  strSQL := strSQL + '   ITE_DESF04, ';
  strSQL := strSQL + '   ITE_DESF05, ';
  strSQL := strSQL + '   ITE_DESF06, ';
  strSQL := strSQL + '   ITE_ICMSAI, ';
  strSQL := strSQL + '   ITE_OUTVAL, ';
  strSQL := strSQL + '   ITE_DESOPE, ';
  strSQL := strSQL + '   ITE_ACRFIN, ';
  strSQL := strSQL + '   ITE_IMPFED  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEGER ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

  Result := strSQL;
End;


function fCriaDiretorio(strPath: String): Boolean;
Var
  strDirAtu: String;
  strDirTmp: String;
  strDirRes: String;
  intPosIni: Integer;
  intPosFin: Integer;
  blnContinua: Boolean;
Begin

  Result      := False;
  blnContinua := (Not fEmptyStr(strPath));

  intPosIni := 1;
  strDirRes := strPath;
  strDirAtu := '';

  If (strDirRes[Length(strDirRes)] <> '\') Then
    strDirRes := strDirRes + '\';

  While blnContinua Do
  Begin
    intPosFin := Pos('\', strDirRes);

    strDirTmp := Copy(strDirRes,intPosIni,intPosFin);
    strDirRes := Copy(strDirRes,intPosFin + 1, Length(strDirRes));

    strDirAtu := strDirAtu + strDirTmp;

    If Not (fEmptyStr(strDirAtu)) Then
    Begin
      If Not DirectoryExists(strDirAtu) Then
        CreateDir(strDirAtu);
    End;

    If (fEmptyStr(strDirRes)) Then
    Begin
      blnContinua := False;
      Result := True;
    End;

  End;

End;

function fDiretorioVazio(strPath: string): Boolean;
var
  search_rec: TSearchRec;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  FindFirst(strPath + '\*.xml', faArchive, search_rec);
  {$WARN SYMBOL_PLATFORM ON}

  Result := (search_rec.Name = '')
end;

procedure ApagaArquivosDiretorio(strPath: String);
Var
  S : TSearchRec;
begin
  try
    FindFirst(strPath +'\*.*', faAnyFile, S);
  repeat
    DeleteFile(Pchar(strPath +'\' + S.name));
  until FindNext(S) <> 0;
  finally
    //FindClose(S);
  end;
end;

{*****************************************}
{* FORMATA O PATH PARA USO NO LINUX      *}
{**************************************MV*}
function fGetPath(strPath: String): String;
begin
  Result := AnsiLowerCase(strPath);
  //Result := AnsiReplaceText(Result, '\', '/');
  Result := AnsiReplaceText(Result, '/', '\');
  If (RightStr(Result, 1) <> '\') Then
    Result := Result + '\';
  Result := Trim(Result);
end;

{TThreadDirectoryExists}

procedure TThreadDirectoryExists.Execute;
begin
  try
    FResult := DirectoryExists( FDirname );
  except
    On E: Exception Do
    begin
      FErr := E.Message;
      FErrclass := ExceptionClass( E.Classtype );
    end;
  end;
end;

function TThreadDirectoryExists.TestForDir(const dirname: String; timeoutMSecs: Dword): TTestResult;
begin
  FDirname := dirname;
  Resume;
  If WaitForSingleObject( Handle, timeoutMSecs ) = WAIT_TIMEOUT Then
  Begin
    Result := trTimeout;
    FreeOnTerminate := true;
  End
  Else
  Begin
    If Assigned( FErrclass ) Then
      raise FErrClass.Create( FErr );
    If FResult Then
      Result := trDirectoryExists
    Else
      Result := trNoDirectory;
  End;
end;

function TryDirectoryExists(APath: string; ATimeoutSecs: Integer): Boolean;
Var
  res: TThreadDirectoryExists.TTestResult;
  thread: TThreadDirectoryExists;
Begin
  if APath = '' then Exit(False);
  Assert(ATimeoutSecs > 0, 'TryDirectoryExists: timeout cannot be 0.');
  thread:= TThreadDirectoryExists.Create( true );
  try
    res:= thread.TestForDir( APath, ATimeoutSecs * 1000);
    Result := res = trDirectoryExists;
    If res <> trTimeout Then
      thread.Free;
  except
    thread.free;
    raise
  end;
End;


Function fCmToPixel(fltValCm: Double; blnRound: Boolean = True): Double;
Begin
  If blnRound Then
    Result := RoundTo(fltValCm * CMPIXEL, -2)
  Else
    Result := fltValCm * CMPIXEL;
End;

Function fPixelToCm(fltValPix: Double; blnRound: Boolean = True): Double;
Begin
  If blnRound Then
    Result := RoundTo(fltValPix / CMPIXEL, -2)
  Else
    Result := fltValPix / CMPIXEL;
End;

{************************************}
{* REDIMENSIONA E CENTRALIZA O FORM *}
{* CONFORME O TAMANHO DESEJADO      *}
{*********************************AN*}
procedure pRedimensionaCentralizaForm(frmForm: TForm; intNewHeight, intNewWidth: Integer);
begin
  With frmForm Do
  Begin
    If intNewHeight <> Height Then
    Begin
      Height := intNewHeight;
      Top := Trunc((Screen.Height / 2) - (intNewHeight / 2));
    End;

    If intNewWidth <> Width Then
    Begin
      Width := intNewWidth;
      Left := Trunc((Screen.Width / 2) - (intNewWidth / 2));
    End;
    Repaint;
  End;
end;

function fEmpresaUsaReplicacao(strCodEmp: String): Boolean;
begin
  Result := fCampoTabela('EMP_USAREP', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]) = 'S';
end;

function fEmpresasNoServidor(strCodEmp: String): String;
begin
  Result := fCampoTabela('EMP_EMPSRV', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);
end;

function fCampoEmpresasNoServidorPreenchido(strEmpA, strEmpB: String): Boolean;
begin
  Result := Not fEmptyStr(fEmpresasNoServidor(strEmpA)) And
            Not fEmptyStr(fEmpresasNoServidor(strEmpB));
end;

{*************************************************************************}
{* CAMPO CRIADO PARA IDENTIFICAR SE AS EMPRESAS ESTAO NO MESMO SERVIDOR, *}
{* VERIFICAMOS NO MESMO CAMPO DAS DUAS EMPRESAS SE ESTAO INSERIDAS.      *}
{**********************************************************************JC*}
function fEmpresasNoMesmoServidor(strEmpA, strEmpB: String): Boolean;
  Var
    strEmpSrvA: String;
    strEmpSrvB: String;
begin
  strEmpSrvA := fEmpresasNoServidor(strEmpA);
  strEmpSrvB := fEmpresasNoServidor(strEmpB);

  Result := (Pos(strEmpA, strEmpSrvA) > 0) And (Pos(strEmpSrvB, strEmpSrvA) > 0) And
            (Pos(strEmpA, strEmpSrvB) > 0) And (Pos(strEmpSrvB, strEmpSrvB) > 0);
end;

function fEhLetra(strCaract: String): Boolean;
Begin
  Result := (Pos(strCaract, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') > 0);
End;

function fSomenteLetra(str: String): String;
Var
  intIdx:Integer;
Begin
  If Not fEmptyStr(str) Then
    For intIdx:=0 To Length(str) Do
      If fEhLetra(str[intIdx]) Then
        Result:=Result+str[intIdx];
End;



function fIniciaTraceViewer: Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := 1 To ParamCount Do
  Begin
    Result := SameText(ParamStr(intCnt), 'logtrace');
    If Result Then
      Break;
  End;
end;

function fNoTef: Boolean;
  Var
    intCnt : Integer;
begin
  Result := False;
  For intCnt := 1 To ParamCount Do
  Begin
    Result := SameText(ParamStr(intCnt), 'NOTEF');
    If Result Then
      Break;
  End;
end;


function fTintaTemConfiguracoesNoBanco(strIdePro: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CFGTIN WHERE CFG_IDEPRO = :IDEPRO AND CFG_CODCFG = :CODCFG');
  qryAux.ParamByName('IDEPRO').AsString := strIdePro;
  qryAux.ParamByName('CODCFG').AsString := 'USATIN';
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;




function fRetNomMarcaItem(strCodIte: String): String;
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
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'INNER JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenMar Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
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

(*Function fValidaDataMySql(fldData: TField): Boolean;
  Var
    dtaDate: TDate;
Begin
  Try
    dtaDate := fldData.AsDateTime;
    Result  := True;
  Except
    Result  := False;
  End;
End;*)




Function fMensagemAuto(strTitulo: String;
                       strTexto: String;
                       arrOpcoes: Array Of String;
                       intFocoBotao: Integer = 1;
                       blnSaiComEsc: Boolean = False;
                       intEstFon: Integer = 1;
                       intWidBut: Integer = 0): Integer;
Begin

 Result := fMensagem(strTitulo,
                     strTexto,
                     arrOpcoes,
                     intFocoBotao,
                     blnSaiComEsc,
                     intEstFon,
                     intWidBut,
                     True);
End;

Function fSenhaPermitida(strSenha: String): Boolean;
  Var
    intContador: Integer;
Begin
  Result := False;
  For intContador := 1 To Length(strSenha) Do
    If Pos(strSenha[intContador], STR_CHAR_SENHA) <= 0 Then
      Exit;
  Result := True;
End;


procedure pAjudaAutcom(Handle: THandle; intNumHlp: Integer);
Begin
  If FileExists(ExtractFilePath(Application.ExeName)+ '\AjudaAutcom.chm') And
     (intNumHlp > 0) Then
    HtmlHelp(Handle, PChar(ExtractFilePath(Application.ExeName)+ '\AjudaAutcom.chm'), $F, intNumHlp);
End;

procedure pLiberaExecucaoChm;
  Var
    reg: TRegistry;
Begin
  Try
    reg := TRegistry.Create;

    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\Microsoft\HTMLHelp\1.x\ItssRestrictions', True);
    reg.WriteInteger('MaxAllowedZone',00000002);
    reg.CloseKey;

    reg.RootKey := HKEY_CURRENT_USER;

    reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Ranges\Range', True);
    reg.WriteInteger('*',00000002);
    reg.WriteString(':Range', fArqIni(0, 'BANCO', 'IP', ''));
    reg.CloseKey;

    FreeAndNil(reg);
  Except

  End;
End;


{*****************************************}
{* VALIDA A INSCRIÇÃO ESTADUAL           *}
{**************************************MV*}

function fRetNomePais(strCodPai: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();

  qryGen.SQL.Add(' SELECT ');
  qryGen.SQL.Add('   IBG_NOMPAI  ');
  qryGen.SQL.Add(' FROM IBG_CADPAI ');
  qryGen.SQL.Add(' WHERE IBG_CODPAI = :CODPAI ');

  qryGen.ParamByName('CODPAI').AsString := strCodPai;
  qryGen.Open;

  Result := qryGen.FieldByName('IBG_NOMPAI').AsString;
  FreeAndNil(qryGen);
end;

function fFindParentByType(Sender: TWinControl; ParentType: TWinControlClass): TWinControl;
begin
  Result := nil;
  if Assigned(Sender.Parent) then
  begin
    if (Sender.Parent Is ParentType) then
      Result := Sender.Parent
    else
      Result := fFindParentByType(Sender.Parent, ParentType);
  end;
end;

function fCheckParent(Sender, Parent: TWinControl): Boolean;
begin
  If Sender = Nil Then
  Begin
    Result := False;
    Exit;
  End;

  If Sender.Parent = nil Then
    Result := False
  Else If Sender.Parent = Parent Then
    Result := True
  Else
    Result := fCheckParent(Sender.Parent, Parent);
end;

function fFindMenu(strFind: String; item: TMenuItem; AUseHint: Boolean = False): TMenuItem;
  Var
    i: Integer;
begin
  Result := Nil;

  If (String(item.Name).ToLower = strFind.ToLower) Or
     (AUseHint And (item.Hint.ToLower = strFind.ToLower)) Then
  Begin
    Result := item;
    Exit;
  End;

  For i := 0 To item.Count -1 Do
  Begin
    Result := fFindMenu(strFind, item.Items[i], AUseHint);

    If Assigned(Result) Then
      Break;
  End;
end;

function fGetMenuLevel(item: TMenuItem): Integer;
begin
  Result := 0;
  If Assigned(item) And Assigned(item.Parent) Then
    Result := fGetMenuLevel(item.Parent) + 1;
end;

function fGetMenuPath(item: TMenuItem): String;
begin
  If Not Assigned(item) Then
    Exit;

  Result := '';

  If Assigned(item.Parent) Then
    Result := fGetMenuPath(item.Parent);

  If fGetMenuLevel(item) > 0 Then
    Result := Result + ' > ';

  Result := Result + item.Caption;

  Result := AnsiReplaceStr(Result, '&', '');
end;

procedure pGeraPopUp(AOwner: TComponent; Menu: TMenuItem; popMenu: TMenuItem;
  strEsconder: String = ''; blnMenuPath: Boolean = False);
  Var
    intContador: Integer;
    mnuNovo: TMenuItem;
begin
  If (Not fVerificaAcessoSistema(Menu.Hint)) Then
    Exit;

  If (Not Menu.Visible) Then
    Exit;

  If SameText(Menu.Caption, MOME_MENU_CRIAREL) Then
    Exit;

  If (Menu.Count > 0) Then
  Begin
    mnuNovo := TMenuItem.Create(AOwner);

    If blnMenuPath Then
      mnuNovo.Caption := fGetMenuPath(Menu)
    Else
      mnuNovo.Caption := Menu.Caption;

    mnuNovo.Hint    := Menu.Hint;
    mnuNovo.Tag     := Menu.Tag;
    mnuNovo.Name    := Menu.Name + '_PopUp_' + fInc(VS_intPopUpId).ToString;
    mnuNovo.OnClick := Menu.OnClick;
    popMenu.Add(mnuNovo);
    For intContador := 0 To Menu.Count -1 Do
    Begin
      pGeraPopUp(AOwner, Menu.Items[intContador], mnuNovo, strEsconder, blnMenuPath);
    End;
  End
  Else
  Begin

    If (Not fEmptyStr(strEsconder)) Then
    Begin
      If (Pos(Menu.Name, strEsconder) > 0) Then
        Exit;
    End;

    mnuNovo := TMenuItem.Create(AOwner);

    If blnMenuPath Then
      mnuNovo.Caption := fGetMenuPath(Menu)
    Else
      mnuNovo.Caption := Menu.Caption;

    mnuNovo.Hint    := Menu.Hint;
    mnuNovo.Tag     := Menu.Tag;
    mnuNovo.Name    := Menu.Name + '_PopUp_' + fInc(VS_intPopUpId).ToString;
    mnuNovo.OnClick := Menu.OnClick;
    popMenu.Add(mnuNovo);
  End;

end;

Function fRetEmpresaMatrizDoGrupo(strCodEmp: String): String;
Begin
  Result := fCampoTabela('EMP_CODMAT', 'CADEMP', ['EMP_CODEMP'], [strCodEmp]);
End;

{********************************************************}
{* ADAPTACAO DA FUNCAO MES() P/ ESPANHOL                *}
{* CASO INTTAM = 1 FORMATA O MES COM 3 DIGITOS EX.: JAN *}
{*****************************************************LU*}
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


{***********************************************************}
{*   Grava TABELA de LOG COM AS TRANSFERENCIAS DE CÓDIFO   *}
{********************************************************CI*}
procedure pGravarTabelaLog(strCodOri, strCodDes, strTabLog: String; strObserv : String = '');
  Var
    qryLog: TUniQuery;
begin

  qryLog := fCriaQuery(Nil);
  qryLog.SQL.Add('SELECT * FROM CADLOG WHERE FALSE');

  With qryLog Do
  Begin

    Open;
    Insert;
    FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADLOG', VS_strCodEmp);;
    FieldByName('LOG_DTALOG').AsDateTime := VS_Date;
    FieldByName('LOG_HRALOG').AsDateTime := fTime();
    FieldByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;
    FieldByName('LOG_VALANT').AsString   := strCodOri;
    FieldByName('LOG_VALNOV').AsString   := strCodDes;
    FieldByName('LOG_TABLOG').AsString   := strTabLog;
    FieldByName('LOG_OBSERV').AsString   := strObserv;
    Post;
    Close;

  End;

  FreeAndNil(qryLog);

end;

function fGetFloatStrF(fltNumero: Double; intInteiros, intDecimais: Integer): String;
Begin
  Result := FloatToStrF(fltNumero, ffNumber, intInteiros, intDecimais);
End;


function fDllRegistrada(strPatchCompleto: String): Boolean;
Begin
  Result := fPegaListaRegistros(HKEY_CLASSES_ROOT, 'CLSID', strPatchCompleto);
End;

function fPegaListaRegistros(const aRoot: HKEY; const aPath: string; const strBusca: String): Boolean;
  Var
    lList: TStringList;
    liEntry: Integer;
begin

  Result := False;

  with TRegistry.Create do
  begin
    RootKey := aRoot;
    if OpenKey(aPath, False) then
    begin

      If (Pos('InprocServer32',aPath) > 0) Then
      Begin
        If AnsiUpperCase(strBusca) = AnsiUpperCase(ReadString('')) Then
          Result := True;
      End;

      If Not Result Then
      Begin
        lList := TStringList.Create;
        try
          GetKeyNames(lList);
          for liEntry := 0 to lList.Count-1 do
          begin

            If (Pos('InprocServer32',aPath) > 0) Then
            Begin
              If AnsiUpperCase(strBusca) = AnsiUpperCase(ReadString('')) Then
                Result := True;
            End;

            If Result Then Break;
            Result := fPegaListaRegistros(aRoot, aPath + '\' + lList[liEntry], strBusca);
            If Result Then Break;

          end;
        finally
          lList.Free;
        end;
      End;

    end;
    CloseKey;
  end;

End;

Function fEmptyStrEspeciais(strInfo: String): Boolean;
Begin
  Result := fEmptyStr(fTiraCaracEspeciais(strInfo));
End;


function fRetCaracterEsquerda(strCampo, strCaracter: String): Variant;
var
  intCont: Integer;
begin
  Result := '';
  If Not fEmptyStr(strCampo) Then
  Begin
    For intCont := 1 To Length(strCampo) Do
    Begin
      If LeftStr(strCampo,1) = strCaracter Then
        strCampo := Copy(strCampo,2,Length(strCampo))
      Else
      Begin
        Result := strCampo;
        Exit;
      End;
    End;
  End;
end;

procedure pAjustaNumeroPaginas(pgcDados: TPageControl; Var intPaginasAtivas: Integer);
  Var
    intIndice,
    intContador: Integer;
    strNomPag  : String;
    stlAlfabeto: TStringList;

    Function fRetNomPaginaComAtalho(strNome : String) : String;
      Var
        intCorre : Integer;
        chrAlfa : Char;
        blnResult : Boolean;
    Begin
      blnResult := False;
      For intCorre := 1 to Length(strNome) do
      Begin
        chrAlfa := strNome[intCorre];
        if pos(chrAlfa,' _-*/\|!@#$%¨&*()=§ª{}[]^~"-+.;.,<>?') = 0 then
        Begin
          if pos(chrAlfa, stlAlfabeto.CommaText) <= 0 then
          Begin
            stlAlfabeto.Add(chrAlfa);
            Result := Copy(strNome, 1, intCorre-1) + '&' + Copy(strNome, intCorre, Length(strNome));
            blnResult := True;
            Break;
          end;
        End;
      end;

      if not blnResult then
        Result := strNome;

    end;

    function fstrRetPos(const value:String):Integer;
      var
        intPos: integer;
    begin
      Result := 0;

      for intPos := 1 to Length(PChar(value)) do
      begin
        if (value[intPos] = '-') then
        begin
          Result := intPos;
          Break;
        end;
      end;
    end;
Begin
  intContador := 0;
  try
    stlAlfabeto:= TStringList.Create;

    For intIndice := 0 To pgcDados.PageCount - 1 Do
    Begin

      If pgcDados.Pages[intIndice].TabVisible Then
      Begin
        Inc(intContador);

        strNomPag := pgcDados.Pages[intIndice].Caption;

        if intContador < 10 then
          strNomPag := '&' + IntToStr(intContador) + Copy(strNomPag, fstrRetPos(strNomPag), Length(strNomPag))
        Else if intContador = 10 Then
        begin
          strNomPag := Copy(strNomPag, fstrRetPos(strNomPag), Length(strNomPag));
          strNomPag := '1&0' + ' ' + strNomPag
        end
        Else
          strNomPag := IntToStr(intContador) + fRetNomPaginaComAtalho(Copy(strNomPag, fstrRetPos(strNomPag), Length(strNomPag)));

        pgcDados.Pages[intIndice].Caption := strNomPag;
      End;

    End;
  finally
    FreeAndNil(stlAlfabeto);
  end;

  intPaginasAtivas := intContador;
End;


procedure pIniciaLogLeak(intDebugH: Byte; strArquivo: String);
Begin

  //comentado até segunda ordem. ass: alexandre
  {If intDebugH <> 0 Then
  Begin
    StartLeakChecking;
  End
  Else
  Begin

    End;

  End;}

End;


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

function DLLMain(dwReason: DWORD): Boolean;
begin
  Result:=True;

  {case dwReason of
    DLL_PROCESS_ATTACH:
    begin
      ThemeServices.Create;
    end;

    DLL_PROCESS_DETACH:
    begin
      ThemeServices.Free;
    end;
  end;}
end;


procedure pConfiguraOpcoesRegionais;
  Var
    reg: TRegistry;
Begin
  Try
    reg := TRegistry.Create;
    reg.RootKey := HKEY_CURRENT_USER;
    reg.OpenKey('Control Panel\International', True);

    reg.WriteString('sMonThousandSep', '.');
    reg.WriteString('sMonDecimalSep' , ',');
    reg.WriteString('sThousand'      , '.');
    reg.WriteString('sDecimal'       , ',');
    reg.WriteString('sGrouping'      , '3;0');
    reg.WriteString('sMonGrouping'   , '3;0');
    reg.WriteString('iDigits'        , '2');
    reg.WriteString('iCurrDigits'    , '2');
    reg.WriteString('sDate'          , '/');
    reg.WriteString('sShortDate'     , 'dd/MM/yyyy');
    reg.WriteString('sLongDate'      , 'dddd, d'' de ''MMMM'' de ''yyyy');
    reg.WriteString('sTime'          , ':');
    reg.WriteString('sTimeFormat'    , 'HH:mm:ss');

    FormatSettings.ThousandSeparator := '.';
    FormatSettings.DecimalSeparator  := ',';
    FormatSettings.CurrencyDecimals  := 2;
    FormatSettings.ShortDateFormat   := 'dd/MM/yyyy';
    FormatSettings.LongDateFormat    := 'dddd, d'' de ''MMMM'' de ''yyyy';
    FormatSettings.ShortTimeFormat   := 'hh:mm';
    FormatSettings.LongDateFormat    := 'hh:mm:ss';

  Finally
    FreeAndNil(reg);
  End;

End;


function fValidaEan13(strCodBar : String) : Boolean;
  Var
    intCorre,
    intPares,
    intImpar,
    intSoma,
    intDigito  : Integer;
Begin
  Result   := False;
  intPares := 0;
  intImpar := 0;

  if Length(strCodBar) <> 13 Then
    Exit;

  For intCorre := 1 to 12 Do
  Begin
    if Odd(intCorre) Then
      intImpar := intImpar + StrToIntDef(strCodBar[intCorre],0)
    else
      intPares := intPares + StrToIntDef(strCodBar[intCorre],0);
  End;

  intPares := intPares * 3;

  intSoma := intPares + intImpar;

  intDigito:= (Trunc(IIF( (intSoma mod 10) = 0, intSoma / 10, (intSoma / 10) + 1 )) * 10) - intSoma;

  Result := (strCodBar[13] = IntToStr(intDigito));

End;

function CompararStringListValuesDouble(List: TStringList; Index1, Index2: Integer): Integer;
begin
  Result := CompareValue(fStrToFloat(List.Names[Index1]), fStrToFloat(List.Names[Index2]));
end;

function GetMaior(const arrValores: array of Extended; const arrIdentificadores: array of string): string;
var
  stlGen: TStringList;
  intCont: Integer;
begin
  stlGen := nil;
  Result := '';
  Try
    Try
      stlGen := TStringList.Create;

      for intCont := Low(arrValores) to High(arrValores) do
      begin
        stlGen.Values[FloatToStr(arrValores[intCont])] := arrIdentificadores[intCont];
      end;

      stlGen.CustomSort(CompararStringListValuesDouble);
      Result := stlGen.ValueFromIndex[stlGen.Count - 1];
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlGen) then FreeAndNil(stlGen);
  End;
end;



function fValidaDataStr(strData: String): Boolean;
Begin
  Result := True;
  Try
    StrToDate(strData);
  Except;
    Result := False;
  end;
end;

procedure pProcuraSetFocus(Sender: TWinControl);
begin
  if not Assigned(Sender) then
    Exit;

  pProcuraSetFocus(Sender.Parent);

  if Sender is TTabSheet then
    TTabSheet(Sender).PageControl.ActivePage := (Sender as TTabSheet)
  else
    pSetFocus(Sender);
end;

function fFindColumnByName(dbgData: TDBGridCitel; strField: String): TColumn;
  var
    intIndex: Integer;
begin
  Result := Nil;
  For intIndex := 0 To dbgData.Columns.Count -1 Do
    If dbgData.Columns[intIndex].FieldName = strField Then
    Begin
      Result := dbgData.Columns[intIndex];
      Break;
    End;
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



function fRetLitros(strCodIte: String): Double;
  Var
    strSQL: String;
    qryGenUni: TUniQuery;

Begin
  Try

    qryGenUni := fCriaQuery();

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   UNI_PESLIT ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADUNI ';
    strSQL := strSQL + '   JOIN CADITE ON UNI_CODUNI = ITE_CODUNI ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ITE_CODITE = :CODITE ';

    With qryGenUni Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;

      Result :=  FieldByName('UNI_PESLIT').AsFloat;

      Close;
    End;

  Finally
    FreeAndNil(qryGenUni);
  End;

End;

function fRetLitrosUnidade(strCodUni: String): Double;
Begin
  Result := fCampoTabela('UNI_PESLIT', 'CADUNI', ['UNI_CODUNI'], [strCodUni]);
End;

function fGetStringArray(arrStrings: array of string): TStringArray;
var
  intCont: Integer;
begin
  SetLength(Result, Length(arrStrings));
  for intCont := 0 to Length(arrStrings) - 1 do
  begin
    Result[intCont] := arrStrings[intCont];
  end;

end;



procedure pRetListaMesAno(stlLista : TStrings ; intQtdReg : Integer = 24; blnLimpaLista : Boolean = True);
  Var
    intCorre : Integer;
    dtaDtaIni: TDate;
Begin
  if intQtdReg <= 0 then
    Exit;

  if blnLimpaLista then
    stlLista.Clear;

  dtaDtaIni := VS_Date;
  For intCorre := 1 To intQtdReg Do
  begin
    stlLista.Add( FormatDateTime('mm/yyyy', dtaDtaIni) );
    dtaDtaIni := incMonth(dtaDtaIni, -1);
  end;

End;

Function fQtdEmpresas : Integer;
  Var
    qryEmp : TUniQuery;
Begin
  qryEmp := fCriaQuery(Nil);

  Try
    With qryEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT COUNT(*) CNT ');
      SQL.Add('   FROM CADEMP ');
      Open;
      Result := FieldByName('CNT').AsInteger;
      Close;
    End;
  Except
    On E: Exception Do
    Begin
      Result := 0;
      pMensagensErro(E.Message, '[uFuncoesSimples.fQtdEmpresas]');
    End;
  End;

  FreeAndNil(qryEmp);
End;


function fRetornaCpfCnpfVazio(strTipo: String): String;
begin
  If strTipo = '1' Then
    Result := '00.000.000/0000-00'
  Else
    Result := '000.000.000-00';
End;

function fDisplayFormat(intCasDec: Integer): String;
begin
  Result := '#,' + StringOfChar('#', intCasDec) + '0.' + StringOfChar('0', intCasDec);
end;

function fFilaExiste(strFila: String): Boolean;
  Var
    qryCfgRel : TUniQuery;
begin
  qryCfgRel := fCriaQuery(Nil);
  With qryCfgRel Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT REL_NOMPRO ');
    SQL.Add('   FROM CFGREL ');
    SQL.Add('  WHERE REL_NOMPRO = :NOMPRO ');
    SQL.Add('    AND REL_CODEMP = :CODEMP ');
    ParamByname('NOMPRO').AsString := strFila;
    ParamByname('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := (RecordCount > 0);
    Close;
  End;
  FreeAndNil(qryCfgRel);
end;


function fRetEmpresaOperador(strCodOpe: String): String;
begin
  Result := fCampoTabela('OPE_CODEMP', 'CADOPE', ['OPE_CODOPE'], [strCodOpe]);
end;


function fGetCodCorItem(strCodIte: String): String;
begin
  Result := fCampoTabela('ITE_CODCOR', 'CADITE', ['ITE_CODITE'], [strCodIte]);
end;


function fStringSQLLocateToStringSQLIN(strLocate : String; strChrSepara : Char = '_'): String;
  Var
    stlSqlIn : TStringList;
Begin
  if fEmptyStr(strLocate) Then
    Exit;

  if strLocate[length(strLocate)] <> strChrSepara then
    strLocate := strLocate + strChrSepara;

  Try
    stlSqlIn := TStringList.Create;

    While not fEmptyStr(strLocate) Do
    Begin
      stlSqlIn.Add( QuotedStr(Copy( strLocate, 1, Pos(strChrSepara, strLocate)-1)) );

      strLocate := Copy( strLocate, Pos(strChrSepara, strLocate)+1, length(strLocate));

    End;

    Result := fCommaText(stlSqlIn);
  Finally
    FreeAndNil(stlSqlIn);
  End;

End;


{ TObjectVariant }
constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;



function fMskCon: String;
  const
    COMPL_MSK : String = ';0;_';
begin
  Result := fCfgSis('MSKCON', varString);

  If Not Result.EndsWith(COMPL_MSK) Then
    Result := Result + COMPL_MSK;
End;

function fSemMascaraPlaNco(strValor: String): String;
begin
  Result := fTiraCaracEspeciais(TrimRight(strValor), False, True, True, True, True, True);
end;

function fInArray(strValor: String; arrDados: TStringArray): Boolean;
Var
    str: String;
begin
  Result := False;

  For str in arrDados Do
    If str = strValor Then
    Begin
      Result := True;
      Exit;
    End;
End;

function GetInToOr(const strNomeCampo: string; const strValores: string): string;
var
  stlResult: TStringList;
  intCont: Integer;
begin
  stlResult := nil;
  Try
    Try
      stlResult := TStringList.Create;
      stlResult.StrictDelimiter := True;
      stlResult.CommaText := strValores;

      for intCont := 0 to stlResult.Count - 1 do
        stlResult[intCont] := strNomeCampo + ' = ' + stlResult[intCont];

      stlResult.Sorted := True;
      Result := '(' + StringReplace(stlResult.CommaText, ',', ' OR ', [rfReplaceAll]) + ')';

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(stlResult) then FreeAndNil(stlResult);
  End;
end;


function fReplaceStr(strTexto, strFrom, strTo: String): String;
begin
  Result := AnsiReplaceStr(strTexto, strFrom, strTo);
end;

function fReplaceStr(strTexto: String; arrFrom, arrTo: Array Of String): String;
  Var
    intInd: Integer;
begin
  Result := strTexto;

  For intInd := 0 To Length(arrFrom) -1 Do
    Result := fReplaceStr(Result, arrFrom[intInd], arrTo[intInd]);
end;

procedure pAddStringList(stl:TStringList; val: String);
begin
  If stl.IndexOf(val) = -1 Then
    stl.Add(val);
end;

procedure pDelStringList(stl:TStringList; val: String);
begin
  If stl.IndexOf(val) <> -1 Then
    stl.Delete(stl.IndexOf(val));
end;

function fRetSTRCampoBlobToCast255(strCampo, strAlias: String; blnPoeVirgula: Boolean=True): String;
begin
  Result := ' CAST('+strCampo+' AS CHAR(255)) AS '+strAlias + SULFIXOPARABLOBTOCAST;
  If blnPoeVirgula Then
    Result := Result + ', ';
end;

procedure fOrganizaControlesConformePassagemArgumentos(objs: array of TComponent);
  Type TrecCtrl = record
    Inici: Boolean;
    Left : Integer;
    Width: Integer;
  End;

  Var
    intCont: Integer;
    recCtrl: TrecCtrl;
begin
  recCtrl.Inici := False;

  for intCont := Low(objs) to High(objs) do
  begin

    If Assigned(objs[intCont]) Then
    Begin
      If (Not recCtrl.Inici) Then
      Begin
        //INICIALIZADO
        recCtrl.Inici := True;
        recCtrl.Left  := TWinControl(objs[intCont]).Left;
        recCtrl.Width := TWinControl(objs[intCont]).Width;
      End
      Else
      Begin
        TWinControl(objs[intCont]).Left := recCtrl.Left + recCtrl.Width + 2;

        recCtrl.Left  := TWinControl(objs[intCont]).Left;
        recCtrl.Width := TWinControl(objs[intCont]).Width;
      End;
    End;
  end;
end;

function fRetornaSomaAlturaDosPaineisVisiveisEm(const obj: TWinControl): Integer;
  Var
    intCont: Integer;
begin
  Result := 0;

  for intCont := 0 to obj.ControlCount - 1 do
  begin
    If (obj.Controls[intCont].Visible) And (obj.Controls[intCont] Is TPanel) Then
    Begin
      Result := Result + obj.Controls[intCont].Height;
    End;
  end;

  If (Result = 0) Then
   Result := obj.Height;
end;

procedure pEnableConjuntoControles(const obj: TWinControl;
                                   const blnEnable: Boolean;
                                   const arrSomenteClas: array of TClass;
                                   const arrIgnonarCtrl: array of TWinControl);
var
  intCont: Integer;

  function InClassesAfetadas(const controle: TWinControl): Boolean;
    Var
     intIdx: Integer;
  begin
    Result := Length(arrSomenteClas)=0; //TODAS

    If (Not Result) And (Length(arrSomenteClas) > 0) Then
    Begin
      For intIdx := 0 to Length(arrSomenteClas) - 1 Do
        If controle Is arrSomenteClas[intIdx] Then
        Begin
          Result := True;
          Break
        End;
    End;
  end;

  function InControlIgnorados(const controle: TWinControl): Boolean;
  var
    intIdx: Integer;
  begin
    Result := False;
    For intIdx := 0 to Length(arrIgnonarCtrl) - 1 Do
      If controle = arrIgnonarCtrl[intIdx] Then
      Begin
        Result := True;
        Break
      End;
  end;

begin
  for intCont := 0 to obj.ControlCount - 1 do
  begin
    If (obj.Controls[intCont].Visible) And
       (InClassesAfetadas(TWinControl(obj.Controls[intCont]))) And
       (Not InControlIgnorados(TWinControl(obj.Controls[intCont]))) Then
    Begin
      obj.Controls[intCont].Enabled := blnEnable;
    End;
  end;
end;




function fVerificarNovaFormulaMovimentada(const strSql: string; const arrParametros: array of Variant): Boolean;
const
  arrTabelas : array[0..4] of string = ('TINDET', 'TINDOR', 'MOVDET', 'FATDOR', 'NOTDET');
  arrPrefixos: array[0..4] of string = ('DET', 'FDO', 'DET', 'FDO', 'DET');
var
  intCont: Integer;
  intParametros: Integer;
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Result := False;
    Try
      qryGen := fCriaQuery();
      for intCont := 0 to Length(arrTabelas) - 1 do
      begin
        qryGen.Close;
        qryGen.SQL.Text := Format(strSql, [arrTabelas[intCont], arrPrefixos[intCont]]);
        for intParametros := 0 to Length(arrParametros) - 1 do
        begin
          qryGen.Params[intParametros].Value := arrParametros[intParametros];
        end;
        qryGen.Open;

        Result := qryGen.FieldByName('QTD').AsInteger > 0;
        if Result then
          Exit;
      end;
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



function fCamelCase(const s: string): string;
var t1: integer;
   first: boolean;
begin
   result := LowerCase(s);
   first := true;
   for t1 := 1 to length(result) do
     if result[t1] = ' ' then begin
       first := true;
     end else
       if first then begin
         result[t1] := UpCase(result[t1]);
         first := false;
       end;
end;




function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;
  Var
    intContador: Integer;
    strDado: String;
Begin
  Result := '';

  For intContador := 0 To stlListSelecao.Count - 1 Do
  Begin
    If blnQuoted Then
      strDado := QuotedStr(stlListSelecao[intContador])
    Else
      strDado := stlListSelecao[intContador];

    If intContador = 0 Then
      Result := strDado
    Else
      Result := Result + strSeparator +  strDado;
  End;
end;

function fValidaUFsPercurso(strPercurso: String): Boolean;
  Var
    stlUFs: TStringList;
    strUF: String;
    strMsg: String;
    intContador: Integer;
begin
  Result := True;
  strMsg := '';
  stlUFs := TStringList.Create;
  ExtractStrings([','], [], PChar(strPercurso), stlUFs);

  For intContador := 0 To stlUFs.Count-1 Do
  Begin
    strUF := Trim(stlUFs[intContador]);
    If Not fValidaEstado(strUF) Then
    Begin
      strMsg := strMsg + strUf + ',';
    End;
  End;

  If Not fEmptyStr(strMsg) Then
  Begin
    strMsg := LeftStr(strMsg, Length(strMsg)-1);
    Result := False;

    pMensagemOk('Há UFs inválidas no percurso: ' + strMsg);
  End;

  FreeAndNil(stlUFs);
end;

function fImportadorPAFRodando: Boolean;
//  Var
//    qryAux: TUniQuery;
begin
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('SELECT IS_USED_LOCK("IMPORTACAO_PAF_' + VS_strCodEmp + '")');
//  qryAux.Open;
//
//  Result := (Not qryAux.Fields[0].IsNull);
//
//  FreeAndNil(qryAux);

  Result := Not fEmptyStr(fGetHostLock('IMPORTACAO_PAF_' + VS_strCodEmp, True));
  If Result Then
  Begin
    fLock_Unlock('IMPORTACAO_PAF_' + VS_strCodEmp, True, False, False, '', False);
  End;
end;

procedure pExecutaImportadorPAF;
begin
  If (Not fImportadorPAFRodando) And (Not fEmptyStr(VS_strCodEmp)) Then
  Begin
    If fCfgSis('PAFECF', varBoolean) Then
    Begin
      fCriarProcessoSimples(Application.ExeName + ' IMPORTA-PDV ' + VS_strCodEmp, False, False, VS_objProcessoImportadorPDV);
      VS_dtaUltimaExecucaoImportadorPDV := fNow();
    End;
  End;
end;

function fLockImportacao: Boolean;
//  Var
//    qryAux: TUniQuery;
begin
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('SELECT GET_LOCK("IMPORTACAO_PAF_' + VS_strCodEmp + '", 2)');
//  qryAux.Open;
//
//  Result := True;
//
//  Try
//    If (qryAux.Fields[0].IsNull)         Or
//       (qryAux.Fields[0].AsInteger <> 1) Then
//    Begin
//      Result := False;
//      Application.Terminate;
//    End;
//  Finally
//    FreeAndNil(qryAux);
//  End;

  Result := fLock_Unlock('IMPORTACAO_PAF_' + VS_strCodEmp, True, False, False, '', False);
  If Result Then
  Begin
    VS_strLockImportacaoPDV := fGetIdConnectionLock('IMPORTACAO_PAF_' + VS_strCodEmp);
  End;
end;

function fRemoveLockImportacao: Boolean;
//  Var
//    qryAux: TUniQuery;
begin
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('SELECT RELEASE_LOCK("IMPORTACAO_PAF_' + VS_strCodEmp + '")');
//  qryAux.Open;
//
//  Result := True;
//
//  FreeAndNil(qryAux);
  fLock_Unlock('IMPORTACAO_PAF_' + VS_strCodEmp, False, False, False, '', False);
  Result := True;
end;

function fLockImportacaoValido: Boolean;
//  Var
//    qryAux: TUniQuery;
//
//    intIdLock: Integer;
begin
//  qryAux := fCriaQuery(Nil);
//  qryAux.SQL.Add('SELECT IS_USED_LOCK("IMPORTACAO_PAF_' + VS_strCodEmp + '")');
//  Try
//    Try
//      qryAux.Open;
//
//      Result := True;
//      If qryAux.Fields[0].IsNull Then
//        intIdLock := -1
//      Else
//        intIdLock := qryAux.Fields[0].AsInteger;
//
//      Result := (intIdLock = StrToIntDef(fGetConnectionID, 0));
//
//    Except
//      Result := False;
//    End;
//  Finally
//    FreeAndNil(qryAux);
//  End;
  Try
    Result := True;
    If fGetTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp) > 100 Then
    Begin
      pDestravaLockForcado('IMPORTACAO_PAF_' + VS_strCodEmp, 0);
    End;
  Except
    Result := False;
  End;
end;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean;
  Var ProceInfo: TProcessInformation; blnInvisivel: Boolean = False): boolean;
  Var
    StartInfo: TStartupInfo;
begin
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

function fRetiraZerosEsquerda(strDado: String): String;
Begin
  While (Length(strDado) > 0) And (strDado[1] = '0') Do
    Delete(strDado, 1, 1);

  Result := strDado;
End;

function StartProcess(Exename: String; CmdLineArgs: String = ''; ShowWindow: Boolean = False;
  WaitForFinish: Boolean = False): integer;
var
  StartInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CreateOK: boolean;
begin
  // Simple wrapper for the CreateProcess command
  // returns the process id of the started process.
  FillChar(StartInfo, SizeOf(TStartupInfo), #0);
  FillChar(ProcInfo, SizeOf(TProcessInformation), #0);
  StartInfo.cb := SizeOf(TStartupInfo);

  If Not ShowWindow Then
  begin
    StartInfo.dwFlags := STARTF_USESHOWWINDOW;
    StartInfo.wShowWindow := SW_HIDE;
  end;
  pLog('StartProcess->'+Exename + ' ' + CmdLineArgs);
  CreateOK := CreateProcess(nil, PChar(Exename + ' ' + CmdLineArgs), nil, nil, False,
    CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartInfo, ProcInfo);

  Result := ProcInfo.dwProcessId;

  if CreateOK then
  begin
    // may or may not be needed. Usually wait for child processes
    if WaitForFinish then
      WaitForSingleObject(ProcInfo.hProcess, Infinite);
  end
  else
  begin
    // ShowMessage('Unable to run '+ProgramName);
    SysErrorMessage(GetLastError());
  end;

  // close process & thread handles
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

function fCriarProcessoSimples(strArquivo: string; blnTrava: Boolean; blnMaximizado: Boolean=True): boolean;
  Var
    StartInfo: TStartupInfo;
    ProceInfo: TProcessInformation;
begin
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;

  If blnMaximizado Then
    StartInfo.wShowWindow := SW_SHOWMAXIMIZED
  Else
    StartInfo.wShowWindow := SW_SHOWNORMAL;

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

  If (Result) Then
    SetForegroundWindow(ProceInfo.hProcess);

  If (Result) And (blnTrava) Then
  Begin
    WaitForSingleObject(ProceInfo.hProcess, INFINITE);

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;

procedure pKill(intId: Integer);
  Var
    qryAux: TUniQuery;
begin
  If intId < 0 Then
    Exit;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('KILL :ID');
  qryAux.ParamByName('ID').AsInteger := intId;
  qryAux.ExecSQL;
  FreeAndNil(qryAux);
end;

function fMesmoExecutavel: Boolean;
  Var
    dtaDtaExeAnt,
    dtaDtaExeAtu: TDateTime;
    intTamExeAnt,
    intTamExeAtu: Integer;
    AnoAtu, MesAtu, DiaAtu: Word;
    AnoAnt, MesAnt, DiaAnt: Word;
begin
  FileAge(Application.ExeName, dtaDtaExeAtu);
  dtaDtaExeAnt := IfNull(fCampoTabela('INF_DTAARQ',
                                      'INFSIS', ['INF_NOMARQ'], [ExtractFileName(Application.ExeName)]), 0);

  intTamExeAtu := fTamanhoArquivo(Application.ExeName);
  intTamExeAnt := IfNull(fCampoTabela('INF_TAMARQ',
                                      'INFSIS', ['INF_NOMARQ'], [ExtractFileName(Application.ExeName)]), 0);

  DecodeDate(dtaDtaExeAtu, AnoAtu, MesAtu, DiaAtu);
  DecodeDate(dtaDtaExeAnt, AnoAnt, MesAnt, DiaAnt);

  //Result := ( Trunc(dtaDtaExeAtu) = dtaDtaExeAnt) And (intTamExeAtu = intTamExeAnt);

  Result := (AnoAtu = AnoAnt) And (MesAtu = MesAnt) And (DiaAtu = DiaAnt) And (intTamExeAtu = intTamExeAnt);
end;


function fQuotedStr(strString: String): String;
  Var
    strQuote : String;
begin
  strQuote := '''';
  Result := QuotedStr(AnsiDequotedStr(strString, strQuote[1]));
end;

function fRetMD5Autcom: String;
begin
  Result := fCfgSis('PAFMDA');

  If fEmptyStr(Result) Then
  Begin
    Result := fArqIni(0, 'GERAL', 'MD5AUT', 'bac638dd8a5d64c2a7c11426c36a9b2b');
    fAtuCfgSis('PAFMDA', Result);
  End;

  Result := AnsiLowerCase(Result);
end;

function fRetVersaoPAFAutcom: String;
begin
  Result := fCfgSis('PAFVER');

  If fEmptyStr(Result) Then
  Begin
    Result := fArqIni(0, 'GERAL', 'VERPAF', '27.18.379a');
    fAtuCfgSis('PAFVER', Result);
  End;

  Result := AnsiLowerCase(Result);
end;

function fInputQueryTipo(const ACaption, APrompt: string;
  var Value: string; ATipoTexto: EditFocus.TControlTipoTexto;
  chrPassCh: Char = #0 ): Boolean;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: Integer;
    Buffer: array[0..51] of Char;
  begin
    for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEditFocus;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
begin
  Result := False;
  Form := TForm.Create(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      BorderStyle := bsDialog;
      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      Position := poScreenCenter;
      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        Caption := APrompt;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
        WordWrap := True;
      end;
      Edit := TEditFocus.Create(Form);
      with Edit do
      begin
        Parent := Form;
        Left := Prompt.Left;
        Top := Prompt.Top + Prompt.Height + 5;
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        TipoTexto := ATipoTexto;
        PasswordChar := chrPassCh;
        SelectAll;
      end;
      ButtonTop := Edit.Top + Edit.Height + 15;
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgOK;
        ModalResult := mrOk;
        Default := True;
        SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
          ButtonHeight);
      end;
      with TButton.Create(Form) do
      begin
        Parent := Form;
        Caption := SMsgDlgCancel;
        ModalResult := mrCancel;
        Cancel := True;
        SetBounds(MulDiv(92, DialogUnits.X, 4), Edit.Top + Edit.Height + 15,
          ButtonWidth, ButtonHeight);
        Form.ClientHeight := Top + Height + 13;
      end;
      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

procedure pPreencheCombo(var cmb:TCustomComboBox; arr:Array of String; blnLimpa:Boolean=True);
var
  intIdx:Integer;
begin
   If blnLimpa Then
     cmb.Items.Clear;

   For intIdx:=Low(arr) To High(arr) Do
     cmb.Items.Add(arr[intIdx]);
end;

function fDescricaoIF: String;
begin
  If fUsaSat Then
    Result := 'SAT-CFe'
  Else If Not fCfgSis('USNFCE', varBoolean) Then
    Result := 'Cupom Fiscal'
  Else
    Result := 'NFCe';
end;

function fDescricaoDocFat(strEspDoc: String): String;
begin
  Result := IIF(strEspDoc='IF', fDescricaoIF, 'Nota Fiscal');
end;


Procedure pLiberaAggs(cdsClient: TUniClientDataSet);
Begin
  If Assigned(cdsClient) Then
  Begin
    With cdsClient do
    If AggFields.Count > 0 Then
      AggFields.Clear;
  End;
End;


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

function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;
  Var
    strSql: String;
    qryCad: TUniQuery;
begin

  strSql := '';
  strSql := strSql + ' SELECT                   ';
  strSql := strSql + '   ' + strTipo + '_STATUS ';
  strSql := strSql + ' FROM                     ';
  strSql := strSql + strTabela;
  strSql := strSql + ' WHERE                    ';
  strSql := strSql + strCampo + ' = :CODIGO     ';

  qryCad := fCriaQuery(Nil);

  With qryCad Do
  Begin
    SQL.Add(strSql);
    ParamByName('CODIGO').AsString := strCodigo;
    Open;
    Result := Fields[0].AsString;
    Close;
  End;

  FreeAndNil(qryCad);

end;


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

function fConfiguracaoPermiteReplicar(strCodCfg: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Nil);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT CFG_PERREP FROM CFGAUX WHERE CFG_CODCFG  = "' + strCodCfg + '"');
    qryGen.Open;
    Result := qryGen.FieldByName('CFG_PERREP').AsString = 'S';
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fExtractBetweenTags(const Value, TagI, TagF: String): String;
var
  regEx: TRegEx;
begin
  regEx := TRegEx.Create(Format('%s.+?%s', [TagI.Replace('/', '\/'),
    TagF.Replace('/', '\/')]));
  Result := regEx.Match(Value).Value.Replace(TagI, '').Replace(TagF, '');
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

      ParamByName('SEQREP').Value := intSeqReplicacao;
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
end;

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
     (strNomTabela = 'CONDET')         Or
     (strNomTabela = 'PCMGER_RES')     Or
     (strNomTabela = 'PCMDET_RES')     Or
     (strNomTabela = 'PCDDET_RES')     Or
     (strNomTabela = 'PCMIRQ_RES')     Or
     (strNomTabela = 'TRANSACOES')     Then
  Begin
    Result := False;
  End;

  //Req: 215414
  If strNomTabela.StartsWith('TMP_ENTFUT_') Then
  Begin
    Result := False;
  End;
end;

function fRetornaInGrupo(strCodGpo: String; arrGrupos: TConsultasArray; strCampo: String=''): String;
  Var
    qryAux: TUniQuery;
    strGrupos: String;
    intContador: Integer;
begin
  If Not fEmptyStr(strCodGpo) Then
    strGrupos := strCodGpo
  Else
  Begin
    strGrupos := '';
    For intContador := Low(arrGrupos) To High(arrGrupos) Do
    Begin
      strGrupos := strGrupos + arrGrupos[intContador].strCodigo + ',';
    End;

    If Not fEmptyStr(strGrupos) Then
    Begin
      strGrupos := Trim(strGrupos);
      strGrupos := Copy(strGrupos, 1, Length(strGrupos)-1);
    End;
  End;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT DISTINCT OPE_CODOPE FROM OPEGPO WHERE GPO_CODGPO IN (' + strGrupos + ') ');
  qryAux.Open;

  Result := '';
  If Not qryAux.IsEmpty Then
  Begin
    While (Not qryAux.Eof) Do
    Begin
      Result := Result + QuotedStr(qryAux.FieldByName('OPE_CODOPE').AsString) + ',';
      qryAux.Next;
    End;

    Result := Trim(Result);
    Result := Copy(Result, 1, Length(Result)-1);

    Result := ' AND ' + IIF(fEmptyStr(strCampo), 'GER_CODVEN', strCampo) + ' IN (' + Result + ')';
  End;

  FreeAndNil(qryAux);
end;

{***************************************************}
{* FUNÇÃO QUE RETORNA OS PORTADORES QUE O OPERADOR *}
{* PODE UTILIZAR CHAMADA APENAS QUANDO A CONFIG.   *}
{* DACPOR ESTIVER "SIM"                            *}
{************************************************JU*}
function fRetPortadoresOperador(strCodOpe: String): String;
  Var
    strSQL: String;
    qryAux: TUniQuery;
Begin

  Try

    qryAux := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
    strSQL := strSQL + '   OPE_CODPOR               ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   POROPE                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE AND ';
    strSQL := strSQL + '   OPE_ACESSO = "S" AND     ';
    strSQL := strSQL + '   OPE_CODPOR IN            ';
    strSQL := strSQL + '   (SELECT POR_CODPOR       ';
    strSQL := strSQL + '    FROM CADPOR)            ';

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODOPE').AsString := strCodOpe;
      Open;

      If Not IsEmpty Then
      Begin
        First;

        Result := '';
        While Not Eof Do
        Begin

          Result := Result + '_' + FieldByName('OPE_CODPOR').AsString;

          Next;
        End;
      End
      Else
        Result := '';
    End;

  Except
    Raise Exception.Create('Erro ao retornar dados POROPE');
  End;

  FreeAndNil(qryAux);

End;

function fGetEmpresaLogada(): string;
begin
  Result := VS_strCodEmp;
end;

function fGetUsuarioLogado(): string;
begin
  Result := strLoginUsuarioLogado;
end;

{***********************************************}
{* LIMPA A MEMÓRIA RESIDUAL QUE O DELPHI DEIXA *}
{* PARA O SISTEMA OPERACIONAL                  *}
{********************************************AF*}
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

{********************************************}
{* RETORNA O VALOR DA 'intColuna' LINHA DE  *}
{* UMA STRING SEPARADA POR 'strDelimitador' *}
{*****************************************MV*}
function fGetValorLinha(strLinha, strDelimitador: String; intColuna: Integer;
  blnIgnoraPrimeiroDelimitador: Boolean=False): String;
  Var
    intContador: Integer;
    intContDel: Integer;
    intTamStr: Integer;
    intEstado: Integer; // 0=normal 1=entre aspas
begin

  Result := '';

  If blnIgnoraPrimeiroDelimitador Then
  Begin
    If AnsiStartsText(strDelimitador, strLinha) Then
    Begin
      strLinha := Copy(strLinha, 2, Length(strLinha));
    End;
  End;

  intTamStr := Length(strLinha);
  intContador := 1;
  intContDel  := 1;

  intEstado := 0;

  While (intContDel < intColuna) Do
  Begin

    If (strLinha[intContador] = strDelimitador) And (intEstado = 0) Then
    Begin
      Inc(intContDel);
    End
    Else If strLinha[intContador] = '"' Then
    Begin
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Inc(intContador);
        Continue;
      End;
    End;
    Inc(intContador);

    If (intContador = intTamStr) Then
    Begin
      Break;
    End;

  End;

  intEstado := 0;

  While ((strLinha[intContador] <> strDelimitador) Or (intEstado = 1)) And
        (intContador <= intTamStr)                                     Do
  Begin

    If strLinha[intContador] = '"' Then
    Begin
      Inc(intContador);
      If intEstado = 0 Then
        intEstado := 1
      Else
      Begin
        intEstado := 0;
        Continue;
      End;
    End;


    Result := Result + strLinha[intContador];
    Inc(intContador);
  End;

end;



Function fStringArrayToStr(arrMsg: TStringArray): String;
  Var
    sltLista: TStringList;
    intContador: Integer;
Begin
  sltLista := TStringList.Create;
  for intContador := Low(arrMsg) to High(arrMsg) do
    sltLista.add(arrMsg[intContador]);
  Result := sltLista.Text;
  FreeAndNil(sltLista);
End;

{**************************************}
{* GRAVA O LOG DE LIBERAÇÃO           *}
{***********************************AF*}

{********************************}
{* CARREGA MATRIZ DE LIBERAÇÕES *}
{*****************************AF*}


function GetValidComponentName(const strNome: string): string;
var
  intCont: Integer;
  strResult: string;

  function IsValidIdent(const Ident: string; AllowDots: Boolean): Boolean;
  const
    Alpha = ['A'..'Z', 'a'..'z', '_'];
    AlphaNumeric = Alpha + ['0'..'9'];
    AlphaNumericDot = AlphaNumeric + ['.'];
  var
    I: Integer;
  begin
    Result := False;
    if (Length(Ident) = 0) or not CharInSet(Ident[1], Alpha) then Exit; //(Ident[1] in Alpha) then Exit;
    if AllowDots then
      for I := 2 to Length(Ident) do
        begin
          if not CharInSet(Ident[I], AlphaNumericDot) then Exit //(Ident[I] in AlphaNumericDot) then Exit
        end
    else
      for I := 2 to Length(Ident) do if not CharInSet(Ident[I],AlphaNumeric) then Exit; //(Ident[I] in AlphaNumeric) then Exit;
    Result := True;
  end;
begin
  Result := '';
  strResult := '';
  for intCont := 1 to Length(strNome) do
  begin
    strResult := strResult + strNome[intCont];
    if IsValidIdent(strResult, False) then
      Result := Result + strNome[intCont]
    else
      strResult := Result;
  end;
end;

function fLerConteudoArquivo(const strArquivo: String): String;
  Var
    stlArq: TStringList;
begin
  stlArq := TStringList.Create;
  stlArq.LoadFromFile(strArquivo);

  Result := stlArq.Text;

  FreeAndNil(stlArq);
end;


function fAlqIcmEstEmp(strCodAbfIte: String): Double;
begin
  Result := fCampoTabela('ABF_ALQICM_SAI_NCO', 'ABFICM',
                        ['ABF_CODABF'        , 'ABF_ESTADO'],
                        [strCodAbfIte        , fRetUFEmpresa], False);
end;



Procedure pFreeLibraryEtiquetas;
  Var
//    dxFinalizeEti: procedure;
    objFree: HMODULE;
Begin
 (*
  If objEditorEtiquetas > 0 Then
  Begin
    dxFinalizeEti := GetProcAddress(objEditorEtiquetas, 'dxFinalizeEti');
    dxFinalizeEti;
    FreeLibrary(objEditorEtiquetas);
    objEditorEtiquetas := 0;
  End;
  *)

  objFree := GetModuleHandle('libEditorEtiquetas.dll');
  If (objFree <> Null) And (objFree <> 0) Then
  Begin
    FreeLibrary(objFree);
  End;

End;

function fRetHoraServidor: TTime;
var
  qryCons: TUniQuery;
begin
  Result := 0;
  qryCons := fCriaQuery(Nil);
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





function fRetUtilizaCliPro : TUtilizaCliPro;
  Var
    intValCfg : Integer;
    intBitOpc : Integer;
Begin
  Result := [];
  intValCfg := fCfgSis('ACLPRO', varInteger);
  intBitOpc := Ord( High(TOpcCliPro) );

  While ( intValCfg <> 0 ) Do
  Begin

    If (intValCfg >= Ord(TOpcCliPro( intBitOpc )) ) Then
    Begin
      Result := Result + [TOpcCliPro(intBitOpc)];
      intValCfg := intValCfg - Ord(TOpcCliPro(intBitOpc));
    End;

    intBitOpc := Trunc( intBitOpc / 2 );

  End;

End;

function fRetDescOpcCliPro(Const opc : TOpcCliPro): String;
Begin
  Case opc Of
    opcPdOrNf   : Result := 'Impressão de Orçamento/Pedido/Nota Fiscal';
    opcEtiqueta : Result := 'Impressão de Etiquetas de Produtos';
  End;

End;

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




procedure pInfoStatusGravacao(pgbStatus: TcxProgressBar; strInformacao: String; intMax: Integer = 0);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInformacao;
    If intMax > 0 Then
    Begin
      pgbStatus.Properties.Max := intMax;
      pgbStatus.Position := 0;
    End;
    Application.ProcessMessages;
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
end;


{**28/05/2015****************************************************}
{* FUNÇÃO VALIDA SE DATA ATENDE "PADRÃO FEBRABAN" (ANO >= 1900) *}
{*************************************************************BB*}
function fIsValidDate(Sender: TWinControl): Boolean;
begin
  Result := True;

  If Not fEmptyStr(fTiraCaracEspeciais(TCustomEdit(Sender).Text)) Then
    If (StrToDateDef(TCustomEdit(Sender).Text, 0) <= 0) Then
      Result := False;
end;

function fImpDescriSimplificada(strCodCli: String): Boolean;
begin
  Result := False;

  If (fCampoTabela('CLI_ORGPUB', 'CADCLI', ['CLI_CODCLI'], [strCodCli]) <> 'S') And
     ( (fCfgSis('IDSORC') = 'S') or ((fCfgSis('IDSORC') = 'P') And (fGetMenu('Descrição do Produto:', ['Completa','Simplificada'], 2) = 2)) ) Then
    Result := True;
end;


{**15/07/2015****************************************************}
{* FUNÇÃO RETORNA DADOS EMITENTE : NOME, ENDEREÇO, TELEFONE*}
{*************************************************************LE*}

{*************************************************************************}
{* REPLICA UMA LISTA DE PROPRIEDADES DE UM CONTROLE ORIGEM PARA UM       *}
{* CONTROLE DESTINO ONDE O NOME DO CONTROLE E SEU TIPO SEJAM IGUAIS AFIM *}
{* DE EVITAR DUPLICAÇÃO DE REGRAS POR EXEMPLO VISIVEL, HABILITADO, ETC   *}
{**********************************************************************VA*}

procedure pOcultaTodosPaineisContidosEm(obj: TWinControl);
  Var
    intContador1: Integer;
begin
  For intContador1 := 0 To obj.ControlCount -1 Do
  Begin
     If (obj.Controls[intContador1] Is TPanel) Then
       (obj.Controls[intContador1] As TPanel).Visible := False;
  End;
end;


function fEmailValido(strEmail: String; blnExibeAlerta: Boolean = True;
              strTitEmail: String = 'E-mail'; blnPermiteEmBranco: Boolean = False): Boolean;
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
        IF blnExibeAlerta Then
          fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe!', ['&OK']);

        Result := False;
      End Else If (Not fEmptyStr(stlEmails[i])) And (Not fEnderecoEmailValido(stlEmails[i])) Then Begin
        IF blnExibeAlerta Then
          fMensagem('', 'Informe o '+strTitEmail+' para envio da NFe corretamente!', ['&OK']);
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(stlEmails);
  End;
end;



procedure pIncrementaListaStr(Const strTexto: String; Var strLista: String; blnQuoted: Boolean=False; blnSeQuotedUseAspas: Boolean=True; chrSepara: Char=',';
       blnEspaca: Boolean=True; blnIgnoraRepetido: Boolean=True);
  Var
    SL: TStringList;

  function fTexto: String;
  Begin
    Result := IIF(blnQuoted, IIF(blnSeQuotedUseAspas, '"'+strTexto+'"', QuotedStr(strTexto)), strTexto);
  End;

  procedure fIncrementar;
  begin
    strLista := strLista + IIF(strLista='', '', chrSepara+IIF(blnEspaca, ' ', '')) + fTexto;
  end;
begin
  If blnIgnoraRepetido Then
  Begin
    SL := TStringList.Create;
    Try
      ExtractStrings([chrSepara], [' '], pChar(strLista), SL);
      If SL.IndexOf(fTexto) = -1 Then
        fIncrementar;
    Finally
      FreeAndNil(SL)
    End;
  End
  Else
  Begin
    fIncrementar;
  End;
End;


function fParteInteira(fltValor: Double): Double;
Var
  strValor: String;
begin
  strValor := FloatToStrf(fltValor, ffFixed, 9, fCfgSis('DECUNI', varInteger));

  If Pos(',', strValor) > 0 Then
    Result := fStrToFloat(Copy(strValor, 1, Pos(',', strValor)))
  Else
    Result := fStrToFloat(strValor);
end;

{ TProcEventos }


procedure pImpressorasConfGaveta(stlLista: TStrings);
Begin
  stlLista.Clear;
  stlLista.Add('NENHUM');
  stlLista.Add('ELGIN');
  stlLista.Add('EPSON');
  stlLista.Add('DIEBOLD');
  stlLista.Add('BEMATECH');
  stlLista.Add('DARUMA');
End;

function fLerImpConfGaveta: String;
Begin
  Result := '';

  If fCfgSis('USNFCE') = 'S' Then
    Result := fArqIniLocal(0, 'NFCE', 'MODELO_IMP_GAVETA', 'NENHUM', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')
  Else If fUsaSat Then
    Result := fArqIniLocal(0, 'SATCFE', 'MODELO_IMP_GAVETA', 'NENHUM', fCfgSis('PATSAT') + '\opcoes_sat.ini');
End;

function fLerImpressora: String;
Begin
  Result := '';

  If fCfgSis('USNFCE') = 'S' Then
    Result := fArqIniLocal(0, 'NFCE', 'IMPRESSORA', '', fCfgSis('PTNFCE') + '\opcoes_nfce.ini')
  Else If fUsaSat Then
    Result := fArqIniLocal(0, 'SATCFE', 'IMPRESSORA', '', fCfgSis('PATSAT') + '\opcoes_sat.ini');
End;

procedure pAbrirGavetaNFCeSAT(strImpressora, strModelo: String);
  procedure pWriteRawStringToPrinter(PrinterName:String; S:String);
  var
    Handle: THandle;
    N: DWORD;
    DocInfo1: TDocInfo1;
  begin
    if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    begin
      pMensagensErro(IntToStr(GetLastError), '[pWriteRawStringToPrinter]');
      Exit;
    end;

    with DocInfo1 do
    begin
      pDocName := PChar('gaveta');
      pOutputFile := nil;
      pDataType := 'RAW';
    end;

    StartDocPrinter(Handle, 1, @DocInfo1);
    StartPagePrinter(Handle);
    WritePrinter(Handle, PChar(S), Length(S), N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
  end;

  procedure pWriteRawStringToPrinterAnsi(PrinterName:String; S:AnsiString);
  var
    Handle: THandle;
    N: DWORD;
    DocInfo1: TDocInfo1;
  begin
    if not OpenPrinter(PChar(PrinterName), Handle, nil) then
    begin
      pMensagensErro(IntToStr(GetLastError), '[pWriteRawStringToPrinter]');
      Exit;
    end;

    with DocInfo1 do
    begin
      pDocName := PChar('gaveta');
      pOutputFile := nil;
      pDataType := 'RAW';
    end;

    StartDocPrinter(Handle, 1, @DocInfo1);
    StartPagePrinter(Handle);
    WritePrinter(Handle, PAnsiChar(S), Length(S), N);
    EndPagePrinter(Handle);
    EndDocPrinter(Handle);
    ClosePrinter(Handle);
  end;
begin
  If UpperCase(strModelo) = 'ELGIN' then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(#27 + #112 + #0 + #100 + #200))
  Else If (UpperCase(strModelo) = 'EPSON') Or (UpperCase(strModelo) = 'DARUMA') then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(chr($1b) + chr($70) + chr($30) + chr($a) + chr($64)))
  Else If strModelo = 'DIEBOLD' then
    pWriteRawStringToPrinter(strImpressora, AnsiString(#27 + '&0' + #12 + #48))
  Else If Pos('BEMATECH', UpperCase(strModelo)) > 0 then
    pWriteRawStringToPrinterAnsi(strImpressora, AnsiString(#29 + #249 + #32 + #0 + #27 + #116 + #8 + #27 + #118 + #140));
end;

procedure pCarregaListaEmpresas(clbEmpresas: TCheckListBox; strEmpresas: String = '');
  Var
    qryCadEmp : TUniQuery;
    intLinAdd : Integer;
Begin
  Try
    qryCadEmp := fCriaQuery(Nil);
    With qryCadEmp, SQL Do
    Begin
      clbEmpresas.Items.Clear;
      Clear;
      Add(' SELECT EMP_CODEMP CODEMP, ');
      Add('        CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM ');
      Add('   FROM CADEMP ');
      Open;
      First;
      While Not Eof Do
      Begin
        intLinAdd := clbEmpresas.Items.Add(FieldByName('EMPNOM').AsString);
        If (Not fEmptyStr(strEmpresas)) Then
          clbEmpresas.Checked[intLinAdd] := (Pos(FieldByName('CODEMP').AsString, strEmpresas) > 0);
        Next;
      End;
      Close;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pCarregaListaEmpresas]');
  End;
  If Assigned(qryCadEmp) Then
    FreeAndNil(qryCadEmp);
End;

function fAchaControle(wclBuscarEm: TWinControl; strNomeBusca: String): Boolean;
  Var
    intCnt : Integer;
Begin
  Result := False;
  For intCnt := 0 To wclBuscarEm.ControlCount -1 Do
  Begin
    If (strNomeBusca = wclBuscarEm.Controls[intCnt].Name) Then
    Begin
      Result := True;
      Break;
    End;
    If (wclBuscarEm.Controls[intCnt] Is TWinControl) And
       ((wclBuscarEm.Controls[intCnt] As TWinControl).ControlCount > 0) Then
    Begin
      If fAchaControle(TWinControl(wclBuscarEm.Controls[intCnt]), strNomeBusca) Then
      Begin
        Result := True;
        Break;
      End;
    End;
  End;
End;

function fCriarConfiguracoes(strCamCfg, strCodEmp: String): Boolean;
  Var
    intContador: Integer;
    qryConfig: TUniQuery;
    qryAux:    TUniQuery;

    strCodCfg: String;
    strDescri: String;
    strValCfg: String;
    strGruCfg: String;
    intNumHlp: Integer;

    strValCfgGra: String;

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

{ TCfgSis }

function TCfgSis.fICfgSis(strCamCfg: String; varTipVar: TVarType; strCodEmp: String): Variant;
begin
  Result := fCfgSis(strCamCfg, varTipVar, strCodEmp);
end;

function fRetEmpresasWms(blnUtiWms: Boolean): String;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Result := '';

  Try

    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  GROUP_CONCAT(EMP_CODEMP) AS EMPRESA ';
    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE    ';

    If (blnUtiWms) Then
      strSQL := strSQL + '  EMP_UTIWMS = "S"  '
    Else
      strSQL := strSQL + '  EMP_UTIWMS <> "S"  ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('EMPRESA').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function fEstaNaLista(SL: TStringList; strValor: String): Boolean;
begin
  Result := SL.IndexOf(strValor) <> -1;
end;

function fRetNomProspectoATIVO(strCodPro : String) : String;
Begin
  Result := fCampoTabela('PRO_NOMCLI', 'PROSPE', ['PRO_CODPRO', 'IFNULL(PRO_CODCLI,"")', 'PRO_STATUS'], [strCodPro, '', 'A']);
End;

function fRetNomProspecto(strCodPro : String) : String;
Begin
  Result := fCampoTabela('PRO_NOMCLI', 'PROSPE', ['PRO_CODPRO'], [strCodPro]);
End;

function fRetFoneProspecto(strCodPro : String) : String;
Begin
  Result := fCampoTabela('PRO_FONE01', 'PROSPE', ['PRO_CODPRO'], [strCodPro]);
End;

function fRetFoneFornecedor(strCodFor: String) : String;
Begin
  Result := fCampoTabela('FOR_FONE01', 'CADFOR', ['FOR_CODFOR'], [strCodFor]);
End;

{******************************************}
{* RETORNA O NOME DA EMPRESA SELECTIONADA *}
{***************************************AF*}

function VerImpressoraONLINE(impressora: String): Cardinal;
  Var
    pInfo: PPrinterInfo2;
    bytesNeeded: DWORD;
    hPrinter: THandle;

  Function GetCurrentPrinterHandle: Boolean;
    Var
      Device, Driver, Port : array[0..255] of char;
  Begin
    Printer.GetPrinter(Device, Driver, Port, hPrinter);
    Result := (OpenPrinter(@Device, hPrinter, nil))
  End;

  Procedure MostraMensagem;
  Begin
    fMensagem('ATENÇÃO!', 'Impressora não encontrada ou não disponível. Impressora: "' +
      impressora + '".',['&OK']);
    Result := 1;
  End;
begin
  Try
    If (fEmptyStr(Trim(impressora))) Then Begin
      Result := 0;
    End Else Begin
      If (Printer.Printers.IndexOf(impressora) < 0) Then Begin
        MostraMensagem();
      End Else Begin;
        Printer.PrinterIndex := Printer.Printers.IndexOf(impressora);

        If (Not GetCurrentPrinterHandle()) Then Begin
          MostraMensagem();
        End Else Begin;
          Try
            GetPrinter(hPrinter, 2, Nil, 0, @bytesNeeded);
            pInfo := AllocMem(bytesNeeded);

            Try
              GetPrinter(hPrinter, 2, pInfo, bytesNeeded, @bytesNeeded);
              Result := pInfo^.Status;
            Finally
              FreeMem(pInfo);
            End;
          Finally
            ClosePrinter(hPrinter);
          End;
        End;
      End;
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[untFuncoesSimples.VerImpressoraONLINE]');
  End;
end;

procedure pCopiaConsultaArray(Var arrBase, arrCopia : TConsultasArray);
  Var
    intIndex : Integer;
Begin
  SetLength(arrCopia, Length(arrBase));
  For intIndex := Low(arrBase) To High(arrBase) Do
  Begin
    arrCopia[intIndex].strCodigo := arrBase[intIndex].strCodigo;
    arrCopia[intIndex].strDescri := arrBase[intIndex].strDescri;
  End;
End;

function GetSpecialFolderPath(Folder: Integer; CanCreate: Boolean): String;
  Var
    FilePath: array [0..255] of Char;
Begin
  SHGetSpecialFolderPath(0, @FilePath[0], FOLDER, CanCreate);
  Result := FilePath;
End;

function fContarString(sTexto, sString: String): Integer;
  var
    sTemp: String;
begin
  Result := 0;
  sTemp  := sString;

  While (Pos(sTexto, sTemp) > 0) Do Begin
    sTemp := Copy(sTemp, Pos(sTexto, sTemp) + 1, Length(sTemp));
    Inc(Result);
  End;
end;


function fKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
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



function fDataValida(dtaData: TDateTime): Boolean;
  Var
    wrdAno : Word;
    wrdMes : Word;
    wrdDia : Word;
begin
  wrdAno := StrToIntDef(FormatDateTime('yyyy', dtaData), 0);
  wrdMes := StrToIntDef(FormatDateTime('mm', dtaData), 0);
  wrdDia := StrToIntDef(FormatDateTime('dd', dtaData), 0);

  If (wrdAno = 1899) Then
    Result := False
  Else
    Result := IsValidDate(wrdAno, wrdMes, wrdDia);
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


function fConverteCodigoBarrasDocumento(strCodBar: String) : untTypesSistema.TDocumento;
Var
  intPosEsp: Integer;
Begin

  Result.strNumDoc := '';
  Result.strEspDoc := '';
  Result.strSerie  := '';
  Result.strCodEmp := '';
  Result.strCliFor := '';

  {Número do Documento}
  Result.strNumDoc := Copy(strCodBar, INT_POS_NUMDOC_BARRAS_EAN39, 12);

  {Espécie}
  intPosEsp := StrToIntDef(Copy(strCodBar, INT_POS_ESPDOC_BARRAS_EAN39, 2), 0);

  If ((intPosEsp > 0) And (intPosEsp <= Length(ARR_ESPDOC_TO_CODE))) Then
    Result.strEspDoc := ARR_ESPDOC_TO_CODE[intPosEsp];

  {Série}
  Result.strSerie := Copy(strCodBar, INT_POS_SERDOC_BARRAS_EAN39, 3);

  {Empresa}
  Result.strCodEmp := Copy(strCodBar, INT_POS_CODEMP_BARRAS_EAN39, 3);

End;

function fChamaTelaGravando(fExecutarAcao: TFunctionFormGravando): Boolean;
Begin
  Result := False;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fExecutarAcao;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[fChamaTelaGravando]');
  End;

  pFreeAndNil(frmGravando);
End;

function fExecutarModal(const prcGen: TGenericProcedure; const strTexto, strChave: string): Boolean;
begin
  Result := TfrmGravando.fExecutarModalA(prcGen, strTexto, strChave);
end;


function fFormatarSQL(strSQL: String): String;
begin
  Result := Trim(strSQL);

  If Pos('SELECT', Result) = 0 Then
    Exit;

  While Pos('  ', Result) > 0 Do
    Result := ReplaceStr(Result, '  ', ' ');

  Result := ReplaceStr(Result, ', ', ',');

  Result := ReplaceStr(Result, ',', ',' + #13#10 + '  ');

  Result := ReplaceStr(Result, ' AND ', ' AND ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'SELECT ', 'SELECT ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'FROM ', #13#10 + 'FROM ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'INNER JOIN ', #13#10 + '  INNER JOIN ');

  Result := ReplaceStr(Result, 'LEFT JOIN ', #13#10 + '  LEFT JOIN ');

  Result := ReplaceStr(Result, ' ON ', ' ON ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'WHERE ', #13#10 + 'WHERE ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'HAVING ', #13#10 + 'HAVING ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'ORDER BY ', #13#10 + 'ORDER BY ' + #13#10 + '  ');

  Result := ReplaceStr(Result, 'LIMIT ', #13#10 + 'LIMIT ' + #13#10 + '  ');
end;





function fDateSql(Const Value: TDateTime): String;
begin
  Result := 'CAST("' + FormatDateTime('yyyy-mm-dd', Value) + '" AS DATE)';
end;



Procedure pConfiguraPopup(btnAtalho: TBitBtnLocked);
  Var
    iteMenu: TMenuItem;
    popMenu: TPopupMenu;
Begin
  popMenu         := TPopupMenu.Create(btnAtalho);
  iteMenu         := TMenuItem.Create(popMenu);
  iteMenu.Caption := 'Configura o relatório chamado pelo botão "' + btnAtalho.Caption + '"';
  iteMenu.OnClick := btnAtalho.OnClick;

  btnAtalho.PopupMenu := popMenu;

  iteMenu.Tag := 199;
  popMenu.Items.Add(iteMenu);
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


function fBoleanoToStr(blnValue: Boolean): String;
begin
  Result := IIF(blnValue, 'TRUE', 'FALSE');
end;


procedure HighlightCellText(AGrid: TDBGridCitel; const ARect: TRect;
  AColumn: TColumn; FilterText: string; AState: TGridDrawState; BkColor,
  SelectedBkColor, fnColor: TColor);
  var
    HlRect : TRect;
    Start : Integer;
    Position : Integer;
    HlText, DisplayText: string;
    offset : Integer;

  function FindText(subText, Text: String; Start: Integer = 0): Integer;
  begin
    Result := 0;

    Text    := fRemoveAcento(Text);
    subText := fRemoveAcento(subText);

    Text := Copy(Text, start, Length(Text));

    If Pos(subText, Text) > 0 Then
      Result := Start + Pos(subText, Text);
  end;

begin
  Start := 1;
  while True do
  begin
    DisplayText := Acolumn.Field.AsString;
    Position := FindText(AnsiLowerCase(FilterText), AnsiLowerCase(DisplayText), Start) -1;
    Start := Position + Length(FilterText);

    if Position <= 0 then
      Break;

    // set highlight area
    case AColumn.Alignment of
      TAlignment.taLeftJustify:  HlRect.Left := ARect.Left + AGrid.Canvas.TextWidth(Copy(DisplayText, 1, Position-1)) + 1;
      TAlignment.taRightJustify:
        begin
          Offset := AGrid.Canvas.TextWidth(Copy(DisplayText, 1,1)) - 1;
          HlRect.Left :=  (ARect.Right - AGrid.Canvas.TextWidth(DisplayText)-offset) + AGrid.Canvas.TextWidth(Copy(DisplayText, 1, Position-1));
        end;
      TAlignment.taCenter:
        begin
          Offset := ((ARect.Right - ARect.Left) div 2) - (AGrid.Canvas.TextWidth(DisplayText) div 2) - (AGrid.Canvas.TextWidth(Copy(DisplayText, 1,1)) - 2);
          HlRect.Left := (ARect.Right - AGrid.Canvas.TextWidth(DisplayText)- offset) + AGrid.Canvas.TextWidth(Copy(DisplayText, 1, Position-1));
        end;
    end;

    HlRect.Top := ARect.Top + 1;
    HlRect.Right := HlRect.Left +AGrid.Canvas.TextWidth(Copy(DisplayText, Position, Length(FilterText))) + 1 ;
    HlRect.Bottom := ARect.Bottom - 1;

    //check for  limit of the cell
    if HlRect.Right > ARect.Right then
      HlRect.Right := ARect.Right;

    // setup the color and draw the rectangle in a width of the matching text
    if gdSelected in AState then
      AGrid.Canvas.Brush.Color := SelectedBkColor
    else
      AGrid.Canvas.Brush.Color := BkColor;

    AGrid.Canvas.FillRect(HlRect);

    AGrid.Canvas.Font.Color := fnColor;

    HlText := Copy(DisplayText,Position, Length(FilterText));
    AGrid.Canvas.TextRect(HlRect,HlRect.Left + 1,HlRect.Top + 1, HlText);
  end;
end;

function ValidarXmlComXsd(FileXml, FileXsd: string): TStringList;
  Var
    XML,
    XSDL: Variant;

  Procedure LerXml(XmlNode: Variant; var Xml: Variant; var Result: TStringList);
    Var
      intIndex: Integer;
      AttrNode: Variant;
      Erro    : String;
  Begin
    For intIndex := 0 to XmlNode.ChildNodes.Length -1 Do
    Begin
      AttrNode := XmlNode.ChildNodes.Item[intIndex];
      if Trim(AnsiLowerCase(AttrNode.NodeTypeString)) = 'element' Then
      Begin
        Erro := Trim(Xml.ValidateNode(AttrNode).Reason);
        If (Erro <> '') Then
        Begin
          If Result.Count = 0 then
            Result.Add(Erro)
          Else If Result[Result.Count-1] <> Erro Then
            Result.Add(Erro);
        End;
        LerXml(AttrNode, Xml, Result);
      End;
    End;
  End;
begin
  Try
    Result := TStringList.Create;
    Result.Clear;

    XSDL := CreateOLEObject('MSXML2.XMLSchemaCache.6.0');
    XSDL.ValidateOnLoad := True;
    XSDL.Add('',FileXsd);

    XML := CreateOLEObject('MSXML2.DOMDocument.6.0');
    XML.ValidateOnParse := False;
    XML.ResolveExternals := True;
    XML.Schemas := XSDL;
    XML.Load(FileXml);

    LerXml(Xml, Xml, Result);
  Finally
    XSDL := varNull;
    XML := varNull;
  End;
End;

function fGeraNumeroSessao: Integer;
  Var
    strUltimaSessao: String;
    intRandom: Integer;
    strSessao: String;
begin
  intRandom := RandomRange(0, 999);

  strUltimaSessao := fArqIniLocal(0, 'SATCFE', 'ULTIMA_SESSAO', '', fCfgSis('PATSAT') + '\opcoes_sat.ini');
  strSessao := fStrZero(fArqIniLocal(0, 'SATCFE', 'PDV', '', fCfgSis('PATSAT') + '\opcoes_sat.ini'), 2) +
              fStrZero(IntToStr(intRandom), 3);

  If strSessao = strUltimaSessao Then
  Begin
    strSessao := fStrZero(fArqIniLocal(0, 'SATCFE', 'PDV', '', fCfgSis('PATSAT') + '\opcoes_sat.ini'), 2) +
                 fStrZero(IntToStr(intRandom+1), 3);
  End;

  fArqIniLocal(1, 'SATCFE', 'ULTIMA_SESSAO', strSessao, fCfgSis('PATSAT') + '\opcoes_sat.ini');
  Result := StrToInt(strSessao);
end;

function fRetirarEspacos(Sender: TObject): String;
var
  strDesAdi: String;
  intEspaco,
  intCont: Integer;
begin
  Result := '';
  strDesAdi := TEditFocus(Sender).Text;
  intEspaco := 0;
  If (Not fEmptyStr(strDesAdi)) Then
  Begin
    For intCont := 1 To Length(strDesAdi) Do
    Begin
      If fEmptyStr(strDesAdi[intCont]) Then
        Inc(intEspaco)
      Else
        intEspaco := 0;

      If intEspaco <= 1 Then
        Result := Result + strDesAdi[intCont];
    End;
  End;
end;




{ TPermissoesAcesso }

constructor TPermissoesAcesso.Create;
begin
  FUsuarios := TDicionario.Create;
end;

destructor TPermissoesAcesso.Destroy;
begin
  FUsuarios.LimparObjetos;
  FUsuarios.Destroy;
  inherited;
end;

function TPermissoesAcesso.fCarregarAcessosUsuario(strCodOpe: String): TStringList;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  Result := TStringList.Create;
  Result.Sorted := True;
  Result.Duplicates := dupIgnore;

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    //Carrega direitos de acesso do operador
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DIR_NOMFRM ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '   DIROPE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '   OPE_CODOPE = :CODOPE ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodOpe;
    Open;

    First;

    While Not Eof Do
    Begin
      Result.Add(FieldByName('DIR_NOMFRM').AsString);
      Next;
    End;

    //Carrega direitos de acesso do grupo do operador
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   D.DIR_NOMFRM  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   DIRGPO D ';
    strSQL := strSQL + '   JOIN CADGPO G ON G.GPO_CODGPO = D.GPO_CODGPO ';
    strSQL := strSQL + '   JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   O.OPE_CODOPE = :CODOPE ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODOPE').AsString := strCodOpe;
    Open;

    First;

    While Not Eof Do
    Begin
      Result.Add(FieldByName('DIR_NOMFRM').AsString);
      Next;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TPermissoesAcesso.fVerificaAcesso(strNomeForm, strCodOpe: String): Boolean;
  Var
    objAcessos: TObject;
begin
  objAcessos := FUsuarios.RetornaObjeto(strCodOpe);

  If objAcessos = nil Then
  Begin
    objAcessos := fCarregarAcessosUsuario(strCodOpe);
    FUsuarios.AdicionarObjeto(strCodOpe, objAcessos);
  End;

  Result := TStringList(objAcessos).IndexOf(strNomeForm) >= 0;
end;

class function TPermissoesAcesso.GetInstance: TPermissoesAcesso;
begin
  If FInstance = nil Then
    FInstance := TPermissoesAcesso.Create;
  Result := FInstance;
end;

procedure TPermissoesAcesso.pLimpar;
begin
  FUsuarios.LimparObjetos;
  FUsuarios.Limpar;
end;

function fRetStrToSQLIn(strValores: String; strDelimitador: String): String;
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


procedure pRedimensionaObj(objRedimensiona, objLimite : TControl; enuRedimensiona : TRedimensiona);
begin
  Case enuRedimensiona of
    rdAumenta:
      objRedimensiona.Width := objRedimensiona.Parent.Width - objRedimensiona.Left - (objRedimensiona.Parent.Width - (objLimite.Left + objLimite.Width));
    rdDiminui:
      objRedimensiona.Width := objRedimensiona.Parent.Width - objRedimensiona.Left - (objRedimensiona.Parent.Width - (objLimite.Left - 7));
  end;
end;


Function fEmpresasMedEmp: String;
  Var
    qryCfgSis: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   GROUP_CONCAT(CONCAT("""", SIS_CODEMP, """")) AS CODEMP ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CFGSIS ';
  strSQL := strSQL + ' WHERE  ';
  strSQL := strSQL + '       SIS_CODCFG = "CFG_MEDEMP" ';
  strSQL := strSQL + '   AND SIS_VALCFG = "1" ';

  qryCfgSis := fCriaQuery;
  With qryCfgSis Do
  Begin
    SQL.Text := strSQL;

    Open;

    Result := FieldByName('CODEMP').AsString;
  End;
  FreeAndNil(qryCfgSis);
End;



function fRetMes(intMes: integer; blnAbreviado: boolean = False): String;
begin
  Case intMes of
    1:  Result := IIf(blnAbreviado, 'Jan', 'Janeiro');
    2:  Result := IIf(blnAbreviado, 'Fev', 'Fevereiro');
    3:  Result := IIf(blnAbreviado, 'Mar', 'Março');
    4:  Result := IIf(blnAbreviado, 'Abr', 'Abril');
    5:  Result := IIf(blnAbreviado, 'Mai', 'Maio');
    6:  Result := IIf(blnAbreviado, 'Jun', 'Junho');
    7:  Result := IIf(blnAbreviado, 'Jul', 'Julho');
    8:  Result := IIf(blnAbreviado, 'Ago', 'Agosto');
    9:  Result := IIf(blnAbreviado, 'Set', 'Setembro');
    10: Result := IIf(blnAbreviado, 'Out', 'Ooutubro');
    11: Result := IIf(blnAbreviado, 'Nov', 'Novembro');
    12: Result := IIf(blnAbreviado, 'Dez', 'Dezembro');
  End;
End;

procedure pOrdenaDataSet(var cdsAux : TUniClientDataSet; strCampo, strTipo : String);
var
  blnExiste : Boolean;
  strChave  : String;
begin
  if fEmptyStr(strCampo) then
    Exit;

  If strTipo='DESC' Then
  Begin

    Try
      strChave := StringReplace(strCampo,';','',[rfReplaceAll]);
      cdsAux.IndexDefs.Find(strChave);
      blnExiste := true;
    Except
      blnExiste := false;
    End;

    If not blnExiste Then
    Begin
      with cdsAux.IndexDefs.AddIndexDef do begin
        Name   := strChave;
        Fields := strCampo;
        Options := [ixDescending];
      end;
    End;
    cdsAux.IndexName := strChave;
  End
  Else
    cdsAux.IndexFieldNames := strCampo;
end;

function fItemAmpara(strCodIte: String): Boolean;
begin
  Result := (fCampoTabela('ITE_UTIAMP', 'CADITE', ['ITE_CODITE'], [strCodIte]) = 'S');
end;


procedure pSalvaCamposForm(frmForm: TForm; strChave: String; blnPorEmpresa: Boolean);
  Var
    sltLista: TStringList;
    intIndice: Integer;
    strSQL: String;
    qryAux: TUniQuery;
    objComp: TComponent;
Begin
  sltLista := TStringList.Create;
  qryAux := fCriaQuery();
  Try
    For intIndice := 0 To frmForm.ComponentCount - 1 Do
    Begin
      objComp := frmForm.Components[intIndice];
      if (objComp is TControl) And TControl(objComp).Enabled Then
      Begin
        If objComp Is TCustomEdit Then
          sltLista.Add(objComp.Name + ':' + TCustomEdit(objComp).Text)

        Else If objComp Is TCheckBox Then
          sltLista.Add(objComp.Name + ':' + IIF(TCheckBox(objComp).Checked, 'T', 'F'))

        Else If objComp Is TComboBox Then
          sltLista.Add(objComp.Name + ':' + TComboBox(objComp).Text);
      End;
    End;

    strSQL := '';
    strSQL := strSQL + 'REPLACE INTO CFGCOL (';
    strSQL := strSQL + '  CFG_LOGOPE,        ';
    strSQL := strSQL + '  CFG_CHAVE_,        ';
    strSQL := strSQL + '  CFG_VALOR_,        ';
    strSQL := strSQL + '  CFG_CODEMP         ';
    strSQL := strSQL + ') VALUES (           ';
    strSQL := strSQL + '  :LOGOPE,           ';
    strSQL := strSQL + '  :CHAVE_,           ';
    strSQL := strSQL + '  :VALOR_,           ';
    strSQL := strSQL + '  :CODEMP            ';
    strSQL := strSQL + ')                    ';

    With qryAux Do
    Begin
      SQL.Text := strSQL;
      ParamByName('LOGOPE').AsString := strLoginUsuarioLogado;
      ParamByName('CHAVE_').AsString := strChave;
      ParamByName('VALOR_').AsString := sltLista.Text;
      ParamByName('CODEMP').AsString := IfThen(blnPorEmpresa, VS_strCodEmp, '');
      ExecSQL;
    End;
  Finally
    FreeAndNil(sltLista);
    FreeAndNil(qryAux);
  End;
End;

procedure pCarregaCamposForm(frmForm: TForm; strChave: String; blnPorEmpresa: Boolean);
  Var
    sltLista: TStringList;
    intIndice, intPosInf: Integer;
    strSQL, strNomCam, strInfCam: String;
    qryAux: TUniQuery;
    objComp: TComponent;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  CFG_VALOR_               ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  CFGCOL                   ';
  strSQL := strSQL + 'WHERE CFG_LOGOPE = :LOGOPE ';
  strSQL := strSQL + '  AND CFG_CHAVE_ = :CHAVE_ ';
  strSQL := strSQL + '  AND CFG_CODEMP = :CODEMP ';

  sltLista := TStringList.Create;
  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Text := strSQL;
      ParamByName('LOGOPE').AsString := strLoginUsuarioLogado;
      ParamByName('CHAVE_').AsString := strChave;
      ParamByName('CODEMP').AsString := IfThen(blnPorEmpresa, VS_strCodEmp, '');
      Open;

      sltLista.Text := FieldByName('CFG_VALOR_').AsString;
    End;

    For intIndice := 0 To sltLista.Count -1 Do
    Begin
      intPosInf := Pos(':', sltLista[intIndice]);

      If intPosInf > 0 Then
      Begin
        strNomCam := LeftStr(sltLista[intIndice], Pred(intPosInf));
        strInfCam := RightStr(sltLista[intIndice], Length(sltLista[intIndice]) - intPosInf);

        objComp := frmForm.FindComponent(strNomCam);

        If Assigned(objComp) Then
        Begin
          If objComp Is TCustomEdit Then
            TCustomEdit(objComp).Text := strInfCam

          Else If objComp Is TCheckBox Then
            TCheckBox(objComp).Checked := SameText(strInfCam, 'T')

          Else If objComp Is TComboBox Then
            TComboBox(objComp).ItemIndex := TComboBox(objComp).Items.IndexOf(strInfCam);
        End;
      End;
    End;
  Finally
    FreeAndNil(sltLista);
    FreeAndNil(qryAux);
  End;
End;

procedure QuickSort(mniMenu: TMenuItem; L, R: Integer);
var
  I, J: Integer;
  P: TMenuItem;

  procedure pTrocaMenus(mnuMenu1, mnuMenu2: TMenuItem);
    Var
      m1, m2, temp: Integer;
  begin
    m1 := mnuMenu1.MenuIndex;
    m2 := mnuMenu2.MenuIndex;

    temp := m1;
    m1 := m2;
    m2 := temp;

    mnuMenu1.MenuIndex := m1;
    if (Not ((m1 = 0) and (m2 = 1))) Then
      mnuMenu2.MenuIndex := m2;
  end;

  function fCompara(strTexto1, strTexto2: String): Integer;
  begin
    if strTexto1 = '-' Then
      Result := 0
    Else
      Result := AnsiCompareStr(strTexto1, strTexto2);
  end;

begin
  repeat
    I := L;
    J := R;
    P := mniMenu.Items[(L+R) shr 1];
    repeat

      while (fCompara(mniMenu.Items[I].Caption, P.Caption) < 0) Do
      Begin
        Inc(I);
      End;

      while (fCompara(mniMenu.Items[J].Caption, P.Caption) > 0) Do
      Begin
        Dec(J);
      End;

      if I <= J then
      begin
        pTrocaMenus(mniMenu.Items[I], mniMenu.Items[J]);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(mniMenu, L, J);
    L := I;
  until I >= R;
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

function VarToString(Const AValue: Variant): String;
begin
  Case TVarData(AValue).VType Of
    varSmallInt,
    varInteger   : Result := IntToStr(AValue);
    varSingle,
    varDouble,
    varCurrency  : Result := FloatToStr(AValue);
    varDate      : Result := FormatDateTime('dd/mm/yyyy', AValue);
    varBoolean   : Result := BoolToStr(AValue, True);
    varString,
    varUString   : Result := AValue;
    Else           Result := '';
  End;
end;

function fUsaTef: Boolean;
begin
  Result := (VS_strUsaTef = 'S');
end;

{-----------------------------------------------------------------------------
 Faz o mesmo que "SimpleRoundTo", porém divide pelo Fator, ao invés de Multiplicar.
 Isso evita Erro A.V. de estouro de Inteiro.
 Nota: Funcao copiada de SimpleRoundTo do Delphi Seatle
 -----------------------------------------------------------------------------}
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

procedure pRedimensionarTelaSeguindoMenuIniciar(frmForm: TForm);
var
  Tasklist : HWnd;
  Bordered : TRect;
begin
  Tasklist := FindWindow('Shell_TrayWnd', nil);
  GetWindowRect(Tasklist, Bordered);

  If (Bordered.Height <= 0) Or (Bordered.Width <= 0) Then
  begin
    frmForm.Height := Screen.Height;
    frmForm.Width  := Screen.Width;
    Exit;
  end;

  if Bordered.Height < Bordered.Width then
  Begin
    frmForm.Height := Screen.Height-Bordered.Height;
    frmForm.Width  := Screen.Width;
  End
  Else
  Begin
    frmForm.Height := Screen.Height;
    frmForm.Width  := Screen.Width-Bordered.Width;
  End;
End;

procedure pIncrementaAutoIncrem(var strAutoincrem: string; incValue: integer = 1);
  var
    value: integer;
begin
  value := StrToInt(copy(strAutoincrem, 4, 14));
  Inc(Value, incValue);
  strAutoincrem := copy(strAutoincrem, 0 , 3) +  Format('%14.14d',[Value]) + Copy(strAutoincrem, 18, 3);
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
     (strTabela = 'ADVCOR_CADADV_SIT') Or
     (strTabela = 'ALE_CADALE_SIT')    Or
     (strTabela = 'AJT_CADAJT_SIT')    Or
     (strTabela = 'ANJ_CADANJ_SIT')    Or
     (strTabela = 'AJA_CADAJA_SIT')    Or
     (strTabela = 'BZC_CADBZC_SIT')    Or
     (strTabela = 'GEN_CADGEN_SIT')    Or
     (strTabela = 'ANN_CADANN_SIT')    Or
     (strTabela = 'BEL_CADBEL_SIT')    Or
     (strTabela = 'BZI_CADBZI_SIT')    Or
     (strTabela = 'CAL_CADCAL_SIT')    Or
     (strTabela = 'CIA_CADCIA_SIT')    Or
     (strTabela = 'DUX_CADDUX_SIT')    Or
     (strTabela = 'FAR_CADFAR_SIT')    Or
     (strTabela = 'GLO_CADGLO_SIT')    Or
     (strTabela = 'GRA_CADGRA_SIT')    Or
     (strTabela = 'HYD_CADHYD_SIT')    Or
     (strTabela = 'INT_CADINT_SIT')    Or
     (strTabela = 'IQU_CADIQU_SIT')    Or
     (strTabela = 'JOT_CADJOT_SIT')    Or
     (strTabela = 'KILD_CADKIL_SIT')   Or
     (strTabela = 'LIK_CADLIK_SIT')    Or
     (strTabela = 'LKD_CADLKD_SIT')    Or
     (strTabela = 'MZI_CADMZI_SIT')    Or
     (strTabela = 'MZA_CADMZA_SIT')    Or
     (strTabela = 'MZD_CADMZD_SIT')    Or
     (strTabela = 'MEG_CADMEG_SIT')    Or
     (strTabela = 'MON_CADMON_SIT')    Or
     (strTabela = 'NEX_CADNEX_SIT')    Or
     (strTabela = 'PPX_CADPPX_SIT')    Or
     (strTabela = 'LKC_CADLKC_SIT')    Or
     (strTabela = 'QUA_CADQUA_SIT')    Or
     (strTabela = 'REC_CADREC_SIT')    Or
     (strTabela = 'REN_CADREN_SIT')    Or
     (strTabela = 'SPA_CADSPA_SIT')    Or
     (strTabela = 'DOX_CADDOX_SIT')    Or
     (strTabela = 'STA_CADSTA_SIT')    Or
     (strTabela = 'UNI_CADUNI_SIT')    Or
     (strTabela = 'VEL_CADVEL_SIT')    Or
     (strTabela = 'WEG_CADWEG_SIT')    Or
     (strTabela = 'INK_CADINK_SIT')    Or
     (strTabela = 'STW_CADSTW_SIT')    Or
     (strTabela = 'BLT_CADBLT_SIT')    Or
     (strTabela = 'TEX_CADTEX_SIT')    Or
     (strTabela = 'CHR_CADCHR_SIT')    Or
     (strTabela = 'SHW_CADSHW_SIT')    Or
     (strTabela = 'ALE_CADALE_SIT')    Or
     (strTabela = 'ALK_CADALK_SIT')    Or
     (strTabela = 'ALA_CADALA_SIT')    Or
     (strTabela = 'C11_CADC11_SIT')    Or
     (strTabela = 'ADS_CADADS_SIT')    Or
     (strTabela = 'DU2_CADDU2_SIT')    Or
     (strTabela = 'ADT_CADADT_SIT')    Or
     (strTabela = 'LEI_CADLEI_SIT')    Or
     (strTabela = 'MAE_CADMAE_SIT')    Or
     (strTabela = 'SIN_CADSIN_SIT')    Or
     (strTabela = 'DCA_CADDCA_SIT')    Or
     (strTabela = 'LUZ_CADLUZ_SIT')    Or
     (strTabela = 'LEC_CADLEC_SIT')    Or
     (strTabela = 'REP_CADREP_SIT')    Or
     (strTabela = 'MIF_CADMIF_SIT')    Or
     (strTabela = 'PRT_CADPRT_SIT')    Or
     (strTabela = 'ALV_CADALV_SIT')    Or
     (strTabela = 'AN2_CADAN2_SIT')    Or
     (strTabela = 'LCA_CADLCA_SIT')    Or
     (strTabela = 'PFA_CADPFA_SIT')    Or
     (strTabela = 'BLA_CADBLA_SIT')    Then
    Result := True;
end;

function fExecutaScript(script: string; var qrySQL: TUniQuery; blnCriaQuery: Boolean): boolean;
begin
  Result := False;

  If blnCriaQuery Then
    qrySQL := fCriaQuery;

  Try
    Try
      qrySQL.SQL.Clear;
      qrySQL.SQL.Add(script);
      qrySQL.ExecSQL();
      Result := True;
    Except
      on e: exception do
        raise ;
    End;

  Finally

    If blnCriaQuery Then
      FreeAndNil(qrySQL);
  End;
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



function fConverteTextoTEF(stlTexto: TStringList): String;
  Var
    intContador: Integer;
begin
  Result := '';
  For intContador := 0 To stlTexto.Count -1 Do
  Begin
    Result := Result + AnsiReplaceStr(stlTexto[intContador], '"', '');
    If intContador < stlTexto.Count -1 Then
      Result := Result + #13#10;
  End;
end;

procedure pLog(strValor: String);
  const
    _FILE_LOG : String = '.\log_autcom.txt';
  Var
    stlLog : TStringList;
begin
  stlLog := TStringList.Create;
  Try
    If FileExists(_FILE_LOG) Then
      stlLog.LoadFromFile(_FILE_LOG);
    stlLog.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()) + ' - ' + strValor);
    stlLog.SaveToFile(_FILE_LOG);
  Finally
    FreeAndNil(stlLog);
  End;
end;

procedure pCriaApagaTrava(intCriApa: Integer);
  Var
    strPatTra: String;
    txfArqTex: TextFile;
Begin

  strPatTra := Trim(ExtractFilePath(Application.ExeName) + 'MySqlSys.dll');

  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 0 = INDICA QUE DEVE CRIAR O ARQUIVO                 //
  //**************************************************ED*//
  If intCriApa = 0 Then
  Begin
    AssignFile(txfArqTex, strPatTra);
    Rewrite(txfArqTex);
    Writeln(txfArqTex, '');
    CloseFile(txfArqTex);
  End
  //*****************************************************//
  // VERIFICA SE DEVE CRIAR OU APAGAR A TRVA             //
  // 1 = INDICA QUE DEVE DELETAR O ARQUIVO               //
  //**************************************************ED*//
  Else
  Begin
    System.SysUtils.DeleteFile(strPatTra);
  End;

End;

function fProcessExists(strFileName: string): Boolean;
  Var
    ContinueLoop: BOOL;
    FSnapshotHandle: THandle;
    FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False;
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(strFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(strFileName))) then
    begin
      Result := True;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


function fNumeroSerieExiste(strCodIte, strNumSer: string): Boolean;
  var qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM PROSER');
    qryConsulta.SQL.Add(' WHERE SER_CODITE = :CODITE');
    qryConsulta.SQL.Add('   AND SER_NUMSER = :NUMSER');
    qryConsulta.ParambyName('CODITE').AsString := strCodite;
    qryConsulta.ParambyName('NUMSER').AsString := strNumSer;
    qryConsulta.Open;
    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;

End;

function fEhTabelaDeContabilidade(strTabela: string): boolean;
begin
  Result := MatchStr(strTabela, ['LANCON', 'PARCON', 'HISPAD', 'PLANCO']);
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

function fSQLSaldoDisponivel(const AAlias: String = 'G';
                             AFaturamento: Boolean = False;
                             ALote: Boolean = False): string;
var
  LPrefix: String;
  strSalGar,
  strSalExt,
  strSalPed,
  strSalEnd,
  strSalOrd,
  strFutPre,
  strFutFal,
  strFutAgu,
  strBaiFut,
  strSalFis: string;
begin
  Result := '';
  LPrefix:= Concat(AAlias, IIF(fEmptyStr(AAlias), '', '.'), IIF(ALote, 'LOT_', 'ITE_'));
  strBaiFut := '(IFNULL(' + LPrefix + 'QTPDBF, 0) - IFNULL(' + LPrefix + 'SDPDBF, 0))';

  strSalGar := 'IFNULL(' + LPrefix + 'SALREG, 0)';
  strSalExt := 'IFNULL(' + LPrefix + 'SALEXT, 0)';
  If (fCfgSis('MOVFUL', varString) = '2') Then
    strSalExt := '0';
  strSalPed :='(IFNULL(' + LPrefix + 'QTPD_V, 0) + (IFNULL(' + LPrefix + 'QTPD_F, 0)))';
  strSalEnd := 'IFNULL(' + LPrefix + 'QTPD_E, 0)';
  strSalOrd := 'IFNULL(' + LPrefix + 'QTPD_P, 0)';
  strFutPre := 'IFNULL(' + LPrefix + 'QTEF_P, 0)';
  strFutFal := 'IFNULL(' + LPrefix + 'QTEF_F, 0)';
  strFutAgu := 'IFNULL(' + LPrefix + 'QTEF_A, 0)';
  strSalFis :=  Concat('IFNULL(', LPrefix, 'SALDOS, 0) + ', strBaiFut, ' + ', strFutPre, ' + ', strFutFal, ' + ', strFutAgu,' + ');
  Case fCfgSis('CALSAL', VarInteger) Of
    1:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt;
    2:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre + ' - ' + strFutFal + ' - ' + strFutAgu;
    3:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre + ' - ' + strFutAgu;
    4:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutFal;
    5:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre;
    Else Result := '0';
  End;
End;

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

procedure pSetaCodIte(edtCodIte: TDBEditFocus);
begin
  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.CompZeros := True;
end;

procedure pSetaCodIte(edtCodIte: TEditFocus);
begin
  edtCodIte.TipoTexto := EditFocus.TControlTipoTexto(ttNumerico);
  edtCodIte.MaxLength := fTamCodIte;
  edtCodIte.TamCampo  := edtCodIte.MaxLength;
  edtCodIte.CompZeros := True;
end;

procedure pSetaCodIte(edtCodIte: TStringField);
begin
  edtCodIte.Size := fTamCodIte;
  edtCodIte.DisplayWidth := edtCodIte.Size;
end;

function fRetornaTipoDoCampo( strTabela: string = ''; strCampo: string = '' ) : String;
Var
  qryAux: TUniQuery;
Begin
  if (strTabela = '') Then
    Result := '';
  if (strCampo = '') Then
    Result := '';
  if (strTabela <> '') And (strCampo <> '') Then
  Begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Text := 'DESC ' + strTabela;
    qryAux.Open;
    While (Not qryAux.Eof) Do
    Begin
      If ( qryAux.FieldByName('Field').AsString = strCampo ) Then
        Result := UpperCase(qryAux.FieldByName('Type').AsString);
      qryAux.Next;
    End;
    FreeAndNil(qryAux);
  End;
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
Var
  LMonitor: TMonitor;
Begin
  LMonitor   := TMonitor(Screen.MonitorFromWindow(Application.Handle));
  AForm.Left := LMonitor.Left + Round(LMonitor.WorkareaRect.Width / 2) - Round(AForm.Width / 2);
  AForm.Top  := Round(LMonitor.WorkareaRect.Height / 2) - Round(AForm.Height / 2);
End;

function fRetFormsAtivos: String;
var
  intContador: Integer;
begin
  Result := EmptyStr;
  for intContador := 0 to Screen.FormCount - 1 do
    Result := Result + IIF(not fEmptyStr(Result), ', ', '') + Screen.Forms[intContador].Name;
end;

function fTime(const AForceTime: Boolean = False) : TDateTime;
begin
  If (AForceTime) Or (Not Assigned(frmModulo)) Then
    Result := untHorarioSistema.GetTime()
  Else
    Result := untHorarioSistema.GetTime(VS_strCodEmp, frmModulo.GetCurrentConnection);
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

function fSafeSQLValue(const AValue : String): String;
begin
  Result := AValue;
  If (AValue.Contains('\')) Then
  Begin
    // Procura uma barra invertida e coloca outra para não quebrar o SQL
    // Transforma \ em \\
    // Se já estiver \\ não faz nada
    Result := TRegEx.Replace(AValue, '(?<!\\)\\(?!\\)', '\\\\');
  End;
end;

initialization
  EnableUniSQL := False;

  VS_strFormulaCusto4 := '';

  DLLProc:=@DLLMain;
  if Assigned(DLLProc) then
  begin
    DLLMain(DLL_PROCESS_ATTACH);
  end;

  VS_EXECUTAR_TESTE_LOG_REPLICACAO := False;
  VS_blnGravaLogTransacao := true;

  VS_TRANSACAO_LIMITE_SEGUNDOS := 30;

  VS_AutoatendimentoPagueFacil := False;

  dicConfiguracoes := TDictionary<string,string>.Create;
  VS_dtaIdentiTransacao := TStringList.Create;
  VS_TimerTransacao := TTimerTransacao.Create(nil);
  VS_TimerTransacao.Enabled := False;
  VS_dtaUltimaExecucaoImportadorPDV := fNow();

  VS_MemoryTableEntFut := fGetMemoryTableNameEntregaFutura;

  VS_MacAddress        := GetMacAddress;
  VS_IPAddressAsString := GetIPAddressAsString;
  VS_UserFromWindows   := GetUserFromWindows;
  VS_ComputerNetName   := GetComputerNetName;

  FDicTabelaReplica := TDictionary<String, Boolean>.Create;
  FMREWSTabelaReplica := TMultiReadExclusiveWriteSynchronizer.Create;

  VS_ProcessID         := '';
  VS_WorkStationIP     := '';
  VS_WorkstationID     := '';

  VS_dtaHraInicializacao := Date + fTime(True);

  VS_GravaUsuRep  := '';
  VS_LogRepConId  := '';
  VS_UsuRepConId  := '';
  VS_LogRepCodOp  := '';
  VS_LogRepIdTra  := '';
  VS_ConnectionID := '';

  blnErroLogRep := False;
  strErroLogRep := '';
  blnTransferindoCodigo := False;

  objEditorEtiquetas := 0;

  VS_trayIconAutcom := nil;

  untFuncoesSimples.VS_objTraceViewer := nil;

  cdsTabNRE := nil;

  VS_strTxjCni := fArqIni(0, 'GERAL', 'TXJCNI', '');

  VS_intTamCadIte := 0;
  VS_intTamCadLse := 0;
  VS_LastConnID := '';

finalization
  TPermissoesAcesso.GetInstance.Destroy;
  FreeAndNil(VS_TimerTransacao);
  FreeAndNil(VS_dtaIdentiTransacao);
  FreeAndNil(dicConfiguracoes);

  If Assigned(FDicTabelaReplica) Then
    FreeAndNil(FDicTabelaReplica);

  If Assigned(FMREWSTabelaReplica) Then
    FreeAndNil(FMREWSTabelaReplica);

  If Assigned(cdsTabNRE) Then
    FreeAndNil(cdsTabNRE);

end.

