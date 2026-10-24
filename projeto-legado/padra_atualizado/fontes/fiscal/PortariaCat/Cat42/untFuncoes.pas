unit untFuncoes;

interface

uses
  {$IFDEF MSWINDOWS}
  Windows, Controls, Forms, PSAPI, untLogAut, Graphics, Dialogs, Buttons, madExcept, StdCtrls, DBctrls, Mask, BitBtnLockedIncrem,
  untFuncoesConsulta, EditFocus, DBEditFocus, MaskEditFocus, untTContasPagar, untTContasReceber,
  Gauges, AdvMenus,  Vcl.CheckLst, WinSock, UniClientDataSet, Menus,
  {$ENDIF}
  System.IOUtils,
  untTypesSistema,
  Uni, Classes, XMLIntf,
  untConstantes, Variants,  DBClient,
  MaskUtils, Math,  DateUtils,
  MySQLUniProvider, AnsiStrings,
  System.Generics.Defaults, IdHashMessageDigest,
  SysUtils, DB, Inifiles,  StrUtils, Vcl.ComCtrls,
  Faturamento.Classes.CNPJ;

Type
  TPais = (opcBrasil, opcParaguai);
  TTipoConsulta = (tpcVazio, tcpPrimeira, tcpOrdemFiltro);

Type
  TDicionario = class(TObject)
    private
      lstChaves: TStringList;
      lstValores: TList;
    protected
      function BuscaChave(strChave: String): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(strChave: String; Valor: Variant);
      procedure AdicionarObjeto(strChave: String; Valor: TObject);
      procedure Remove(strChave: String);
      procedure Limpar;
      function Retorna(strChave: String): Variant;
      function RetornaObjeto(strChave: String): TObject;

      function Chaves: TStringList;

      property Items[Index: String]: Variant read Retorna write Adicionar; default;
End;

Type
  TEventoRegistroProgresso = procedure(intInicio, intAtual, intFin: Integer) of object;
  TEventoRegistroAcao = procedure(strAcao: String) of object;
  {$IFDEF MSWINDOWS}
  TGenericProcedureWithClientParam = procedure(cdsConsulta: TUniClientDataSet);
  {$ENDIF}
  TIntArray = Array Of Integer;
  TColunasArray = Array Of String;
  EInvalidParameter = class(ExceptionAutCom);
  TGenericProcedure = procedure of object;

  function fParseError(strErrorMessage: String; Var strInfoAdicional: String): Integer;
	 procedure pMensagensErro(MensErro, LocalErro:String; strMensagem : String = '' );
  function fAbrirTabela(NomeTabela:TDataSet):Boolean;
  function fFecharTabela(NomeTabela:TDataSet):Boolean;
  function fCurrentDate: String; Overload;
  function fCurrentDate(Const Value: TDateTime): String; Overload;
  function fCurrentDateTime: String; Overload;
  function fCurrentDateTime(Const Value: TDateTime): String; Overload;
  {$IFDEF MSWINDOWS}
 	procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
  procedure pSetButton(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar,btnLocalizar,btnSair:TBitBtn);
  function ffrmData(Var dtaData: TDateTime; strCaption, strCaptionLabel: String): Boolean;
  {$ENDIF}
  function fUsaProCodigo(strNomeTabela: String): Boolean;
  procedure pApagarTodosArquivos(strPasta: String);
  function IfNull(varValor, varDefault: Variant): Variant;
  procedure VerificaBdCamposFuncoes;
  

Type
  Tprocod = record
    strNomArq: string;
    strCodSeq: string;
    intTamCod: integer;
    strCodAut: string;
    intAutInc: integer;
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
  {*****************************************}
  {* REPRESENTA UM REGISTRO DA DIGDUPLIC   *}
  {**************************************MV*}
  TArrDigDuplic = Record
    intNumDup:  Integer;
    strSequen: String;
    curValor : Currency;
    dtaDtaVen: String;
  end;

type
  TArrDigDuplicArray = Array Of TArrDigDuplic;

  TfncRetNome      = function (strCodigo: String): String;
  TfncRetNomeConst = function (Const strCodigo: String): String;  

function fRetConexao: TUniConnection;

function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
function fPadZ(strTexto:variant; Quant:integer):String;
function fPadZR(strTexto:variant; Quant:integer):String;

function fStrZero(Zeros:string;Quant:integer):String; overload;
function fStrZero(Zeros:Integer;Quant:integer):String; overload;

function fRetNomPortador(Const strCodPor: String): String;

function fRetPortadoresOperador(strCodOpe: String): String;

function fRetEmpAcessoUsuario(strCodOpe: String): String;

function fRetEmpEstUsuario(strCodOpe: String): String;

{$IFDEF MSWINDOWS}
function fGetMenu(strTitulo: String; arrOpcoes: Array Of String; intOpcao: Integer;
    blnSaiComEsc: Boolean = False; blnLibQtd: Boolean = False; intWidth: Integer = 0): Integer;

procedure pPedeSenhaDestravarCodAut;    
{$ENDIF}

function fRetEmpLoginUsuario(strCodOpe: String): String;

function fRetCodigoIBGE(strCodEmp: string): string;

function fFloatToStrSemPontoSemVirgula(valor: double; inte, deci: integer): string; overload;

function fFloatToStrSemPontoSemVirgula(valor: string; inte, deci: integer): string; overload;

function fEncontraColunaLivro(cdsDados: TDataset; strClaFis: String; fltAlqIcm: Double): String;
{$IFDEF MSWINDOWS}
procedure pRegistrarProgresso(progresso: TGauge; intInicio, intAtual, intFinal: Integer);

function fOrdenaListaCadPagDataDocumento(blnDtaCad: Boolean): IComparer<TContasPagar>;

function fOrdenaListaCadRecDataDocumento(blnDtaCad: Boolean): IComparer<TContasReceber>;
{$ENDIF}
procedure pDefinirCharsetConexao;

function fPreInv(strAlias : String = ''; strAliasImpFed : String = ''; strPreInv: String = ''; blnIfNull: Boolean = True):String;

procedure pGravaLog(strNomeSecao:String; strNomArq: String = '');

function GetSQLRegistro_E_RegE113(AOpcao: integer): String;

function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
function fArqIniAutSi(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String; overload;
function fArqIniAutSi(ReadWrite:Integer;NomChave,NomSecao,Conteudo,strCodEmp:String):String; overload;

function fNow: TDateTime;

function fStrLocate(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
    strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
    strCodigo: String = ''): String;

function fStringSQLLocateToStringSQLIN(strLocate : String; strChrSepara : Char = '_'): String;

function fCommaText(stlListSelecao: TStringList; blnQuoted: Boolean = False; strSeparator : String = ', '): String;

{$IFDEF MSWINDOWS}
Procedure pMensagemOk(strMensagem: String);

function fStrTitulo(strText: string; strDescri: string; arrLinha: TConsultasArray; strLinha, strTitulo: string;
                      blnTodas: Boolean = False; blnNegar: Boolean = False): string;
{$ENDIF}

procedure pSetaParam(strText: String; arrLinha: TConsultasArray; Var strLinha: String; strNomPar: String; qryRelatorio: TUniQuery);

function fSetaPais: TPais;

function fRetNomProduto(Const strCodIte: String): String;

function fRetNatOpe(strCodCfo: String): String;

function fReplicatorStr(strRepl: String; intTamanho: Integer):String;

function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil): String;

function fRetNomeEmpresaSelec(const strCodEmpresa: string): string;

function fRetNomeProdutoSelec(const strCodProduto: string): string;

function fFormataFone(strFone: String): String;

function fRetMascaraFone(opcPais: TPais): String;

function fTiraCaracEspeciaisParenteses(strTexto: String): String;

function fFloatToInt(fltNumero: Double): Integer;

function fGetLetraAlfa(intCol: Integer): String;

function fGetConnectionID: String;

function fRetLinGruExcluir(strLinGru: String): String;

function fSimplesNacional(strCodEmp: string): string;
{$IFDEF MSWINDOWS}
function fRetornaVersao(strNomArq: String = ''): String;
{$ENDIF}
function fTiraCaracEspeciais(strTexto: String;
                             blnTiraEspacos: boolean = False;
                             blnTiraPontos: boolean = False;
                             blnTiraAsterisco: boolean = False;
                             blnDeixaUnderline: boolean = False;
                             strLista: String = '';
                             blnRetiraEspacoDireita: Boolean = False;
                             blnRetiraEspacoEsquerda: Boolean = False): String;

function fRetSufixoMovIcd: String;

function fRetContaContabilPorCfop(strCfop: String): String;
function fRetContaContabilPorNota(strNumDoc: String): String;

function fFormataCgcCpf(strCgcCpf: String; strFormatado: boolean = False ): String;

function fFormataCep(strCep: String; strSimbolo: string = '-'): String;

function IIF(lTest:Boolean; vExpr1,vExpr2:Variant):Variant; overload;

function fEmptyStr(strString : String) : Boolean;

function fTiraEnter(strValor: string): string;

function fTiraCaracterIPI(strTexto: String): String;
{$IFDEF MSWINDOWS}
function fPedeEmpresa(strCodEmp: String): String;
{$ENDIF}
function fRetNomeEmpresa(const strCodEmp: string=''): String;
function fRetNomeEmpresaFantasia(const strCodEmp: string=''): String;

function fGetValorXml(nodNo:IXMLNode; strNome: String; varTipVar: TVarType = varString;
    strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;

function fVerificaCredPisCofins(strCodEmp: string): string;

function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection=Nil): TUniQuery;

function fFimDoMes(const AValue: TDateTime): TDateTime;
{$IFDEF MSWINDOWS}
function fMensagem(strTitulo: String;
             strTexto: String;
             arrOpcoes: Array Of String;
             intFocoBotao: Integer = 1;
             blnSaiComEsc: Boolean = False;
             intEstFon: Integer = 1): Integer;
{$ENDIF}
function fPosicoes(strString: String; chrBusca: Char): TIntArray;
{$IFDEF MSWINDOWS}
function ffrmSenha(var strSenha: String; strTitulo: String = ''): Boolean;

procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
{$ENDIF}
function fCriarQuery(strSQL: String; AOwner: TComponent = nil): TUniQuery;

procedure pErro(Mensagem:String);

procedure pAtuVarGlobais;

procedure pCriaTabelaAJDIFL;

procedure pCriaTabelaAUTSI_SCRIPTS;

procedure pCriaTabelaCRDFAL;

procedure pCriaTabelaMovIcdTmp;

procedure pValidaProCod(strNomeTabela: String);

function fRetornaProCod(strNomeTabela: String): String;
{$IFDEF MSWINDOWS}
procedure pFreeAndNil(frmForm: TForm);
{$ENDIF}
function fRetChaveAtual(strSerie, strTipFc, strEspDoc, strNumero, strEmpresa, strParticipante: String): String;

function fRetChaveAtualR(strSerie, strTipFc, strEspDoc, strNumero, strEmpresa, strParticipante, strCfop: String): String;

function fStrToFloat(strValor: String): Double;

function fFloatToStrPonto(valor: double; inte,deci: integer): string;

function fFloatToStrVirgula(valor: double; inte,deci: integer): string; overload;
function fFloatToStrVirgula(valor: string; inte,deci: integer): string; overload;

function fFloatToStrTiraVirgula(valor: double; inteiro,decimal: integer): string;

function fAvaliaCfopNota(strCfopIni,strCfopConcat: String): string;

//rotinas para CAT
function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
function fGetTipoAbfFornecedor(const strCodFor: String; Var strTipFor: String): String;
function fGetTipoAbfCliente(const strCodCli: String; strConsum: String=''): String;
function fAtividadeConstrutora(strCodAti: String): Boolean;

//rotinas para SPED-Fiscal
function fGetTipoAbfCliente_(const strCodCli: String; strConsum: String = '';
  strIndust: String = ''; strEmp_TE: String = ''): String;
function fGetTipoAbfFornecedor_(const strCodFor: String): String;
function fGetTipoAbf_(strTipFC, strFisJur, strIES, strConFin, strCodAti,
  strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
function fRetClientesFilial_: String;
function fGetTipOpeTransferencia_(strEmpOri, strCliFil: String): String;
function fAtividadeConstrutora_(strCodAti: String): Boolean;

function GetMD5(const strTexto: string): string;

function fCampoTabela(strCampo : String;
                      strNomTab: String;
                      arrCampoChave: Array Of String;
                      arrValorChave: Array Of Variant;
                      blnSempreLerBanco: Boolean = True;
                      strOrderBy: String = '';
                      Conexao: TUniConnection = Nil;
                      blnUsarMax: Boolean = False): Variant;

// RETORNA CST DE PIS/COFINS COM INFORMACAO DO CODIGO DE ABREVIACAO DE PIS/COFINS
// CONSTANTES NAS TABELAS CADITE OU ITEGER CONFORME CONFIGURACAO "CFG_TPABPC
function fRetornaTabIteCstPis(strCfop, strCodIte: String): string;
function fRetornaTabIteCstCof(strCfop, strCodIte: String): string;

// RETORNA CST DE PIS/COFINS DIRETAMENTE PELO CFOP DO CADFIS
function fRetornaTabFisCstPisCof(strTrib, strCfop: String): string;

function fStrSemAlfa(strTexto: String): String;
{$IFDEF MSWINDOWS}
function fAjustaDataSistema: Boolean;
{$ENDIF}
function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
function fVerificaIntegridade(strNomFrm, strTabela: String; qryTabOriginal: TDataSet;
    blnGravar: Boolean = True; blnSoCriaTabela: Boolean = FALSE;
    strMotDel: String = ''; strOpeDel: String = ''; blnTabAux: Boolean = False): String;

function fRetNomTabAuxMov(strNomTab: String): String;

function fRetEmpresaFisica: String;

function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
function fRetAutoIncremProInc(strNomeTabela, strCodEmp: String): String;

function fInTransaction: Boolean;

function fStartTransaction: Boolean;

function fCommit:Boolean;

function fRollBack:Boolean;

function fFormataValor(fltValor: Double; intTamanho: Integer; intDecimais: Integer): String;

function fValidaDatas(strData: String): Boolean;

function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;

function fCfgSpd(strCamCfg: String): String;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;

function fValidaIES(strIES, strEstado: String): Boolean;

function fValidaCnpjCpf(strOpcao, strValor: String; blnPassaVazio: Boolean = False; blnMsg: Boolean = True): Boolean;

function fExisteCnpjCpf(strTabela, strCamExe, strCodExe, strCampo, strCodigo: String): Boolean;

function fTestaCgc(xCGC: String):Boolean;

function fValidaCPF(sCPF: string):Boolean;

function fRetornaIESformatada(strIES, strEstado: String): string;

procedure pCriaClientDataSet(qryOrigem: TDataSet; Var cdsDados: TClientDataSet; blnCriarCDS: boolean = True; blnInsereRegistros: Boolean = False);

procedure pVerificaProCod;

procedure pAbrirBanco(var Database: TUniConnection);

procedure pSetaClient(cdsClient: TDataSet);

function fCriarConexao: TUniConnection;

procedure pCarregaStringDevolucoes(strClaDev: String; var strClaDevVenda: String; var strClaDevCompra: String);

procedure pCarregaSQLModalidadesPagamentoFreteNfCancelada(strTipFc: String; qryAux: TUniQuery);

procedure pRetModalidadePagamentoFreteNfCancelada(var strDataDoc, strDataEnt, strTotCon, strCondPag, strDesconto, strIndFrete, strValPis, strValCof: String;
                                                  strNumdoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc: String);

function fRetornaMesRefCreFis(strData: String): string;

function fRetornaCSTPIS(strCLAFIS: string; blnINCPIS: Boolean; strEntSai: String): string;

function fRetornaCSTIPI(dValorIPI: Double; strEntSai: String): String;

function fBuscaItemTerceiro(strCodIte: String) : string;

function fPlacaVeiculo(strPlaca: string; intRetorno: Integer = 0{0 - numero / 1 - letras}) : string;

function fRetornaCSTCSOSN(strCodFis: string; strCSTSTR: Variant): string;

function fBuscaUnidadeItem(strCodUni: String): String;

function fRetornaTotalizadorParcial(strCodFis: string): string;

function fRetNomeOperador(strCodOpe: String): String;

function fCrypt(strSenha: String): String;
function fCryptC(strSenha: String): String;
function fDecryptC(strSenha: String): String;

function fstrEspaco(Str:String;Tamanho:Integer;intPos:Integer = 1):String;

function fGravaMovGer(strNomeTabela: String;
                      Var strAutInc: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodTra,
                      strCodVen,
                      strCodFor,
                      strCodCli,
                      strTip_Fc: String;
                      dtaDtaEnt,
                      tmrHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strEstado,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon,
                      strCgcCpf,
                      strCgcCon,
                      strIesCon,
                      strCli_Rg: String;
                      fltBasSim,
                      fltBasIpi,
                      fltAlqIpi,
                      fltTotIpi,
                      fltBasIcm,
                      fltAlqIcm,
                      fltTotIcm,
                      fltTotRet,
                      fltAlqRet,
                      fltBasRet,
                      fltRet_SP,
                      fltDesEsp,
                      fltVlrCon,
                      fltTotPro,
                      fltTotCus,
                      fltTotMed: Double;
                      strTipFre: String;
                      fltTotFre,
                      fltPesBru,
                      fltPesLiq,
                      fltVolume: Double;
                      strEspeci,
                      strMarca,
                      strMen001,
                      strMen002,
                      strMen003,
                      strMen004,
                      strMen005: String;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat,
                      fltVPar01,
                      fltVPar02,
                      fltVPar03,
                      fltVPar04,
                      fltVPar05,
                      fltVPar06,
                      fltVPar07,
                      fltVPar08,
                      fltVPar09,
                      fltVPar10,
                      fltVPar11,
                      fltVPar12: Double;
                      strSerie,
                      strNotEsp,
                      strClaFis,
                      strClaFi2,
                      strClaFi3,
                      strNatOpe: String;
                      fltPorDes: Double;
                      strCodDig,
                      strCodCnd,
                      strCodFpg: String;
                      fltFatNot: Double;
                      strCodS01,
                      strCodS02,
                      strCodS03,
                      strCodS04,
                      strCodS05,
                      strCodS06,
                      strDesS01,
                      strDesS02,
                      strDesS03,
                      strDesS04,
                      strDesS05,
                      strDesS06: String;
                      fltValS01,
                      fltValS02,
                      fltValS03,
                      fltValS04,
                      fltValS05,
                      fltValS06: Double;
                      intPraEnt: Integer;
                      fltTotSer,
                      fltPerIss,
                      fltValIss,
                      fltDesAce: Double;
                      strOriDoc,
                      strConEnt,
                      strCodRep: String;
                      fltAlqIrf,
                      fltValIrf,
                      fltAlqPis,
                      fltValPis,
                      fltAlqCof,
                      fltValCof,
                      fltAlqCsl,
                      fltValCsL,
                      fltIrfRet,
                      fltPisRet,
                      fltCofRet,
                      fltCslRet: Double;
                      strNotRet: String;
                      fltAlIrfP,
                      fltAlPisP,
                      fltAlCofP,
                      fltAlCslP,
                      fltSerRet: Double;
                      strNoReSe: String;
                      fltPeSgSo,
                      fltVlSgSo,
                      fltIrPrRt,
                      fltIrPrDv,
                      fltIrSeRt,
                      fltIrSeDv,
                      fltPiPrRt,
                      fltPiPrDv,
                      fltPiSeRt,
                      fltPiSeDv,
                      fltCoPrRt,
                      fltCoPrDv,
                      fltCoSeRt,
                      fltCoSeDv,
                      fltCsPrRt,
                      fltCsPrDv,
                      fltCsSeRt,
                      fltCsSeDv: Double;
                      strOrdPro: String;
                      fltBasOrg,
                      fltIcmOrg: Double;
                      intNConhe: Integer;
                      strConsum,                     // Consumidor final
                      strEntFat,
                      strCliFat,
                      strOpeExp,
                      strSepExp,
                      strTabPre,
                      strNum_Pr,
                      strEntFut: String;
                      blnBaiFut: Boolean;
                      fltMargem: Double;
                      fltBaRtSp,
                      fltVlRtSp: Double;
                      strOprFlj,
                      strNumReg: String;
                      dtaDtEntr: TDateTime;
                      strNroCei,
                      strClaFi4,
                      strAutSer,
                      strCodEve,
                      strAutEnt,
                      strObsNfe,
                      strCodOco: String;
                      blnIpDpNf: Boolean;
                      fltValCre: Double    = 0;
                      dtadtlBex: TDateTime = 0;
                      strEmlCon: String    = '';
                      dtaDtESNf: TDateTime = 0;
                      tmrHrESNf: TDateTime = 0;
                      objFinanc: Pointer = Nil): Boolean;

{*****************************************}
{* =============> ANTEÇÃO <============= *}
{* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
{* RECOMPILAR O AUTCOMTINTA.DLL          *}
{**************************************MV*}
function fGravaMovDet(strNomeTabela: String;
                      Var strAutInc: String;
                      strSeqGer: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodIte,
                      strCodVen,
                      strCodDiv,
                      strCodMar,
                      strCodFor,
                      strCodCli: String;
                      dtaDtaEnt,
                      dtaHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strTip_Fc,
                      strEstado,
                      strDescri,
                      strRefere,
                      strUnidad,
                      strForIte: String;
                      fltQtdIte,
                      fltUnitar,
                      fltUniOri,
                      fltTotIte,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep,
                      strCodVe2: String;
                      fltPerCom,
                      fltTotCom,
                      fltTotCo2: Double;
                      strClaFis,
                      strCodFis: String;
                      fltValIpi,
                      fltAlqIpi,
                      fltBasIpi,
                      fltValIcm,
                      fltAlqIcm,
                      fltBasIcm,
                      fltValRet,
                      fltAlqRet,
                      fltBasRet,
                      fltTotPes,
                      fltPerBas,
                      fltPerRed: Double;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat: Double;
                      strIdePro,
                      strIncPis,
                      strSerie: String;
                      fltDesAce: Double;
                      strNotEsp,
                      strDocDev,
                      strEspDev,
                      strEmpDev,
                      strIteCha,
                      strIteTin,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre: String;
                      fltPrvTin,
                      fltPrcTin,
                      fltFatTin: Double;
                      strProEmb,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strIteEmb,
                      strGruEmb: String;
                      intLazQua: Integer;
                      strPromoc,
                      strSeqTin: String;
                      fltQtdPul: Double;
                      strPedCom,
                      strOriDoc,
                      strNum_Pd,
                      strEsp_Pd,
                      strEmp_Pd: String;
                      intInd_Pd: Integer;
                      strOrdPro,
                      strDesNes,
                      strCliFat: String;
                      fltBcaMin,
                      fltBcaCom,
                      fltVolPro: Double;
                      strCodAca,
                      strEmpAca: String;
                      blnProAca,
                      blnFilKar: Boolean;
                      strEspFut,
                      strDocFut,
                      strEmpFut,
                      strTabPre,
                      strEmpCom: String;
                      strLinha: String;
                      strCatali: String;
                      strCodDil: String;
                      fltPorDil: Double;
                      strDilCon: String;
                      fltPorCat: Double;
                      fltUniDig: Double;
                      intQtdPon: Integer;
                      strEntFut,
                      strMotFut: String;
                      dtaDtaFut: TDateTime;
                      fltTotCu2: Double;
                      fltComRep,
                      fltPerRep: Double;
                      strKey_EP,
                      strNumLot,
                      strPigBas: String;
                      fltVaEIpi,
                      fltAlEIpi,
                      fltBaEIpi,
                      fltTotUlt,
                      fltBaRtSP,
                      fltVaRtSP,
                      fltIcOpPr: Double;
                      intSeqCcr: Integer): Boolean;

procedure pIncluiAuxMov(strNomTab, strAutInc, strAutEnt: String;
  fltValCre: Double);
function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;
function fTruncaFloat(fltNumero: Double; intDecimais: Integer): Double;
function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
function fReplicaString(strCaracter : String; intQuantidade: Integer): string;
function fTabelaExiste(strNomeTabela: String): Boolean;

function fRetNotaImportada(strNumDoc, strEspDoc, strSerie, strForCli, strTipFc, strCodEmp: String): boolean;
function fRetNotaImportadaF(qryNFImport: TUniQuery; strNumDoc, strEspDoc, strSerie, strForCli, strTipFc, strCodEmp: String): boolean;

function fEhFeriado(dtaDta: TDateTime): Boolean;
function fDiaDeFolga(dtaDta: TDateTime): Boolean;
function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
procedure pZeraDuplicata(Var arrDuplicata: TArrDigDuplic);
function fDigDuplic(Var arrDuplicata: TArrDigDuplicArray;
                    Var intQtdDup: Integer;
                    strCndPag: String;
                    intNumDoc: Integer;
                    curTotal: Currency;
                    dtaDtaBas: TDateTime;
                    blnDupsRedondas: Boolean = True;
                    blnSabDomFeriadoDiasUteis: Boolean = True): Boolean;
procedure pZapTable(strTabela: String);
function fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;

function fAtualizaProCod(strNomeTabela: String): String;
function fRetTamCampo(strNomeTabela: String): Integer;

function fIsNumber(Const strNumber: String): Boolean;
function fEntraCons(strCodigo: String): Boolean;
function fRetNomeConta(strCodCta: String): String;
function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery; strEmpresa: String = ''): String; overload;
function fCadEmp(strNomCampo: String; strEmpresa: String = ''): String; overload;
{$IFDEF MSWINDOWS}
function pConsultaRapida(Sender: TForm; qryTabela: TUniQuery; strNomeTabela: String;
  stlIndice, stlDesInd, stlCampos: TStringList; blnUsaSqlTabela: boolean = false; strOrderOpc: String = ''; strCaption: String = ''): Boolean;
{$ENDIF}
function fRetornaValorAbfPisCofins(strCodAbf, strPisCofins: String;
  fltBase: Double; strCfop: String; Var fltAlqPisCof: Double;
  Var strCstPisCof, strNatRecPisCof: String): Double;

function fDefineCSTIPI(strEntSai: String; fltAlqIpi: Double): String;
procedure pRetornarAbfPisCofins(strCodIte: String; var strAbfPis,
  strAbfCof: String);
procedure pRetornaCodigoItemEspecial(Var strCodIte, strUnidade: String; blnUsaSigUni: Boolean);
procedure pRetornaCodigoItemTransferencia(Var strCodIte, strUnidade: String; blnUsaSigUni: Boolean);

function fRetEspDocum(strHistorico, strAcesso, strEspDoc, strCfop: String; cdsEsp: TClientDataSet): String;

function fLimpaCampo(strCampo: String): String;
function fRemoveAllChars(strTexto: string): string;

function fValidaXML(cdsAtual: TClientDataSet; strNomArq: String): Boolean;
{$IFDEF MSWINDOWS}
function fCriarProcesso(strArquivo, strParametros: string; blnTrava: Boolean): boolean;
{$ENDIF}
function fCampoExiste(const strTabela, strCampo: String): Boolean;
function fCalculoDVNfe(strChave: String): Integer;

function fStringRepetida(Const strString: String): Boolean;

procedure pAtuRecolhimentoMensalICMS();
{$IFDEF MSWINDOWS}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
{$ENDIF}
function fRoundSql(const strCampo: String; const intDecimais: Integer): String;

function fInIteSer: String;

function fSoNumero(strTexto: String): String;

function fValidaApropCredSt(strClafis1: String; blnEnviaStVenda, blnEnviaStCompra, blnEnviaStDevVenda, blnEnviaStDevCompra, blnEnviaST_CFOP_X910: Boolean; strRegime, strApropriaCred: string;
                            strClafis2: String = '';
                            strClafis3: String = '';
                            strClafis4: String = '';
                            strClafis5: String = ''): Boolean;

function fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;

function fRetornaInscSubsTribSimplificado(strEmpresa, strEstadoDestino: string): boolean;
{$IFDEF MSWINDOWS}
procedure pEdtCodSelectExit(edtCodigo       : TCustomEdit;
                            edtDescri       : TEditFocus;
                            Var arrLinha    : TConsultasArray;
                            fncRetNome      : TfncRetNome;
                            fncRetNomeConst : TfncRetNomeConst;
                            strMsgErr       : String;
                            intTamCamp      : integer = 0;
                            blnNegar: Boolean = False);
{$ENDIF}

procedure pAtivaBarraProgresso(prgBarra:TProgressBar; intMaximoBarra: integer);
procedure pDesativaBarraProgresso(prgBarra:TProgressBar);
procedure pPercorreBarraProgresso(prgBarra:TProgressBar; intPosicao: integer = 0);

function fRetornaClienteFilial(strCodEmp: String; strTipo_FC : String = 'C'): String;
{$IFDEF MSWINDOWS}
procedure pGetMenuIntegracaoContabil(LstMenu: TCheckListBox; MenuItem: TMenuItem; Menu: TAdvMainMenu);
{$ENDIF}
procedure pCarregaCodigoContabilista;

function fRound(fltValue: Extended; intDecimals: Integer): Extended;
function fTrunca(const fltValor: Double; intDecimais: Integer = 2): Double;
function fArrLinhaGrupoExcluir(strEmpresa: string; strTipExt: string = '1'): TConsultasArray;
function StringToBoolean(AValue: String): Boolean;
function fConverteSeparadorData(strData: string): string;
function fValida_GTIN(strGTIN: string): Boolean;

{$IFDEF MSWINDOWS}
function GetIPAddress: Integer;
function GetIPAddressAsString: String;
function GetMacAddress: String;
function GetUserFromWindows: String;
function GetComputerNetName: String;
{$ENDIF}
function fTime(const AForceTime: Boolean = False) : TDateTime;

function fGetEmpresaLogada(): string;
function fGetUsuarioLogado(): string;

procedure pTrimAppMemorySize;

Var
  //Database: TUniConnection = Nil;
  VS_strCodEmp            : String;     // CODIGO DA EMPRESA NO AUTCOM
  VS_strCodEmpContab      : String;     // CODIGO DA EMPRESA SELECIONADA PARA USO DO CONTADOR
  VS_strPatPad            : String;     // CAMINHO (PATH) PADRAO PARA EXPORTACAO

  VS_GRAVA_LOG            : Boolean;     // HABILITA GRAVACAO DE LOG OU NAO

  {$IFDEF LINUX}
  VS_strGerIni            : String;     // HORA INICAL GERAÇÃO SPED
  VS_strGerFin            : String;     // HORA FINAL GERAÇÃO SPED
  {$ENDIF}
  VS_strE201usaCampo26    : string;     // OPCAO DE USO DO CAMPO 26 DO REGISTRO E201 DO FOLHAMATIC FISCAL
  VS_Date                 : TDateTime;  // DATA DO SISTEMA
  VS_Time                 : TDateTime;  // HORA DO SISTEMA
  VS_strComNumendCli      : string;     // CAMPO NUMERO DO ENDERECO DO CLIENTE
  VS_strComNumendFor      : String;     // CAMPO NUMERO DO ENDERECO DO FORNECEDOR
  VS_strComComplendCli    : String;     // CAMPO COMPLEMENTO DO ENDERECO DO CLIENTE
  VS_strComComplendFor    : String;     // CAMPO COMPLEMENTO DO ENDERECO DO FORNECEDOR
  VS_strComSegur          : String;     // VARIAVEL QUE REGISTRA A PRESENCA OU NAO DO CAMPO VSEGUR1 EM CADFIS
  VS_strPodeUsarNFE       : string;     // VARIAVEL QUE REGISTRA SE O BANCO DE DADOS ESTA PREPARADO PARA NF ELETRONICA
  VS_strIteSer            : string;     // VARIAVEL QUE REGISTRA O CODIGO DE SERVICOS EM CFGSIS
  VS_strSerTer            : String;     // VARIAVEL QUE REGISTRA O CODIGO DE SERVICOS DE TERCEIROS EM CFGSIS
  VS_strClaSub            : string;     // VARIAVEL QUE REGISTRA O TIPO DE SUBSTITUTICAO TRIBUTARIA (1-SUBSTITUIDO[PADRAO] / 2- SUBSTITUTO [INDUSTRIA])
  VS_strComGerDescrServ   : string;     // VARIAVEL QUE REGISTRA A EXISTENCIA DOS CAMPOS DE DESCRICAO DE SERVICOS EM MOVGER E NOTGER
  VS_strComSufram         : string;     // VARIAVEL QUE REGISTRA A PRESENCA DO CAMPO DE SUFRAMA NO CADASTRO DE CLIENTES
  VS_strComCodIBGE        : string;     // VARIAVEL QUE REGISTRA A PRESENCA DO CAMPO DE COD. IBGE DE CIDADE NO CADASTRO DE CIDADES
  VS_strComOriDoc         : string;     // VARIAVEL QUE REGISTRA A PRESENCA DO CAMPO "FIS_ORIDOC" EM CADFIS
  VS_strCtaComConCon      : string;     // VARIAVEL QUE REGISTRA A PRESENCA DO CAMPO "CTA_CONCON" EM CADCTA
  VS_strLocalizacaoFisica : string;     // VARIAVEL QUE REGISTRA A PRESENCA DO CAMPO "IMO_LOCFIS" EM CADIMO
  VS_strMenuCores         : string;     // PERMITE DEFINIR SE MENU PRINCIPAL DO FORM SERA COLORIDO
  VS_strExportaCupons     : string;     // DEFINE SE FARA EXPORTACAO DE CUPONS PARA AS CONTABILIDADES
  VS_strGeraNaoBaixados   : string;     // DEFINE SE NA EXPORTACAO SERAO ENVIADOS SOMENTE TITULOS JA BAIXADOS
  VS_strCodEstRecolheIcms : string;     // DEFINE O CODIGO ESTADUAL DE RECOLHIMENTO DE ICMS PARA O SPED
  VS_strCodEstRecolheIcmsSTForaEstado: string; // DEFINE O CODIGO ESTADUAL DE RECOLHIMENTO DE ICMS ST PARA O SPED (FORA DO ESTADO)
  VS_strCodEstRecolheIcmsSTDentroEstado: string; // DEFINE O CODIGO ESTADUAL DE RECOLHIMENTO DE ICMS ST PARA O SPED (DENTRO DO ESTADO)
  VS_strDiaVencIcms       : string;     // DEFINE DIA DE VENCIMENTO PARA PAGAMENTO DO ICMS
  VS_strDiaVencDifalOrigem: string;     // DEFINE DATA DE VENCIMENTO DO DIFAL ORIGEM
  VS_strDiaVencDifalDestino: string;     // DEFINE DATA DE VENCIMENTO DO DIFAL DESTINO
  VS_strDiaVencIcmsST     : string;     // DEFINE DIA DE VENCIMENTO PARA PAGAMENTO DO ICMS ST
  VS_strFormaCtaCtb_CtaPg : string;     // DEFINE SE USARA FORMACAO DE CONTA CONTABIL NO CONTAS A PAGAR
  VS_strFolhaCtaCtbCredito: string;     // PERMITE ESTABELECER UMA CONTA CONTABIL DE CREDITO FIXA NO FOLHAMATIC
  VS_strFolhaCtaCtbDebito : string;     // PERMITE ESTABELECER UMA CONTA CONTABIL DE DEBITO FIXA NO FOLHAMATIC
  VS_strNfpReg30serv      : string;     // DEFINE SE SERAO INCLUIDOS ITENS DE SERVICOS NO REGISTRO "30" DA NOTA FISCAL PAULISTA
  VS_strNfpUsaReg60       : string;     // DEFINE SE SERA GERADO O REGISTRO "60" NA NOTA FISCAL PAULISTA
  VS_strItensServ         : string;     // STRING CONTENDO OS ITENS DE SERVICOS DO CADASTRO DE ITENS (CADITE)
  VS_strComprasVistaCod   : string;     // CONTA CONTABIL PARA COMPRAS A VISTA
  VS_strComprasVistaDescr : string;     // DESCRICAO DA CONTA CONTABIL PARA COMPRAS A VISTA
  VS_strComprasPrazoCod   : string;     // CONTA CONTABIL PARA COMPRAS A PRAZO
  VS_strComprasPrazoDescr : string;     // DESCRICAO DA CONTA CONTABIL PARA COMPRAS A PRAZO
  VS_strClaCom            : string;     // CONFIGURACAO FIXA DE CFOP PARA COMPRA DE MERCADORIA (CFGSIS)
  VS_strClaVen            : string;     // CONFIGURACAO FIXA DE CFOP PARA VENDA DE MERCADORIA (CFGSIS)
  VS_strClaDev            : string;     // CONFIGURACAO FIXA DE CFOP PARA DEVOLUCAO DE MERCADORIA (CFGSIS)
  VS_strCodSubstTrib      : string;     // STRING DE CODIGOS FISCAIS PARA SUBSTITUICAO TRIBUTARIA (CODFIS)
  VS_strCamposServicosGer : string;     // DEFINE SE OS CAMPOS DE SERVICOS ESTAO DEFINIDOS NAS TABELAS GER
  VS_strContasFornecedores: string;     // DEFINE AS CONTAS ESPECIFICAS A SEREM UTILIZADAS EM CONTAS A PAGAR (OPCIONAL)

  VS_strVendasVistaCod    : string;     // CONTA CONTABIL PARA VendAS A VISTA
  VS_strVendasVistaDescr  : string;     // DESCRICAO DA CONTA CONTABIL PARA VendAS A VISTA
  VS_strVendasPrazoCod    : string;     // CONTA CONTABIL PARA VendAS A PRAZO
  VS_strVendasPrazoDescr  : string;     // DESCRICAO DA CONTA CONTABIL PARA VendAS A PRAZO
  VS_strVendasCartoesCod  : string;     // CODIGO DA CONTA CONTABIL COM CARTOES DE CREDITO/DEBITO
  VS_strVendasCartoesDescr: string;     // DESCRICAO DA CONTA CONTABIL COM CARTOES DE CREDITO/DEBITO
  VS_strTpCustoInventario : string;     // TIPO DE PRECO DE CUSTO PARA O INVENTARIO (CUSTO/COMPRA/MEDIO)
  VS_strSimplesPaulista   : string;     // SIMPLES PAULISTA/NACIONAL (S/N)
  VS_strCredPisEntrada    : string;     // OPCAO QUE PERMITE DETERMINAR SE A EMPRESA SE CREDITA DE PIS/COFINS NA ENTRADA
  VS_strPis_Cst01         : string;     // CODIGO DE SITUACAO TRIBUTARIA DE PIS
  VS_strPis_Cst02         : string;     // CODIGO DE SITUACAO TRIBUTARIA DE PIS
  VS_strPis_Cst03         : string;     // CODIGO DE SITUACAO TRIBUTARIA DE PIS
  VS_strPis_Cst04         : string;     // CODIGO DE SITUACAO TRIBUTARIA DE PIS
  VS_strPis_Cst05         : string;     // CODIGO DE SITUACAO TRIBUTARIA DE PIS
  VS_strCfgTpAbfPisCofins : string;     // CONFIGURACAO DE TIPO DE ORIGEM DA ABREVIACAO DE PIS/COFINS SE CADITE OU ITEGER

  VS_strFiltroNumDoc      : string;     // FILTRO PARA TESTES INTERNOS

  VI_intTamanhoCodContabil: Integer;    // TAMANHO DO CÓDIGO CONTÁBIL USADO PARA EXACTUS - ASTEC
  {$IFDEF MSWINDOWS}
  ProcReconectarModulo : TProcReconectarModulo;
  {$ENDIF}
  arrProCod : Array of Tprocod;
  strMsgErros: string;

  strSQLMovGer: String;

  strPortadoresOperador : String;

  {**********************************************************}
  {* GUARDA O LOGIN DO USUARIO LOGADO NA MAQUINA NO MOMENTO *}
  {*******************************************************DV*}
  strLoginUsuarioLogado: String;
	strDescriUsuarioLogado: String;
	strEmpAcessoUsuarioLogado: String;
  strEmpEstUsuarioLogado: String;
  strAuxGerTmp: String;
  blnUsuarioLogadoUtilizaModoClassico: Boolean;

  VS_MacAddress        : String;
  VS_IPAddressAsString : String;
  VS_UserFromWindows   : string;
  VS_ComputerNetName   : string;
  VS_blnSpedNovo       : Boolean;
  VS_strJobGeracao     : string;

implementation

uses
  {$IFDEF MSWINDOWS}
  cxDBEdit, untGetMenu, untEmpresas, untMensagem, untConsulta, untDigData,
  {$ENDIF}
  untModulo, untTLocalArquivo, untHorarioSistema;//, untFinanceira;

// FormatMaskText(const EditMask: string; const Value: string)

//**************************************//
//*  ativas a barra de progresso       *//
//***********************************WI*//
procedure pAtivaBarraProgresso(prgBarra:TProgressBar; intMaximoBarra: integer);
begin

  prgBarra.Enabled := True;
  prgBarra.Visible := True;
  prgBarra.Step := 1;
  prgBarra.Min := 0;
  prgBarra.Max := intMaximoBarra;
  prgBarra.MarqueeInterval := 1;
  prgBarra.Position := 0;

end;

//**************************************//
//*  ativas a barra de progresso       *//
//***********************************WI*//
procedure pDesativaBarraProgresso(prgBarra:TProgressBar);
begin

  prgBarra.Enabled := False;
  prgBarra.Visible := False;

end;

//**************************************//
//*  ativas a barra de progresso       *//
//***********************************WI*//
procedure pPercorreBarraProgresso(prgBarra:TProgressBar; intPosicao: integer = 0);
begin

  if (intPosicao = 0) then
  begin
    prgBarra.StepIt;
  end
  else
  begin
    prgBarra.Position := intPosicao;
  end;

end;

function fSenhaDestravarCodAut(strSenDig: String): Boolean;
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
    intSenLib := intSenLib + StrToInt(Copy(IntToStr(wrdAno), intContador, 1));
  End;

  intSenLib := intSenLib + StrToInt(RightStr(strSenDig, 3));

  intSenLib := intSenLib * intFatMul;

  strSenDec := fStrZero(intSenLib, (Length(strSenDig)-3));

  strSenDec := strSenDec + RightStr(strSenDig, 3);

  //********************************************************//
  // VERIFICA SE A SENHA CALCULADA E IGUAL A SENHA DIGITADA //
  //*****************************************************ED*//
  Result := (strSenDec = strSenDig);

end;

function fValidaApropCredSt(strClafis1: String; blnEnviaStVenda, blnEnviaStCompra, blnEnviaStDevVenda, blnEnviaStDevCompra, blnEnviaST_CFOP_X910: Boolean; strRegime, strApropriaCred: string;
                            strClafis2: String = '';
                            strClafis3: String = '';
                            strClafis4: String = '';
                            strClafis5: String = ''): Boolean;
  var
    strClaVen: string;
    strClafis: string;
    intCont:   integer;
begin
  Result := False;
  for intCont := 1 To 5 Do
  Begin

    case intCont of
      1: strClafis := strClafis1;
      2: strClafis := strClafis2;
      3: strClafis := strClafis3;
      4: strClafis := strClafis4;
      5: strClafis := strClafis5;
    end;

    //# 05022020 FS
    //# NA OPÇÃO DE SUBSTITUÇÃO TRIBUTÁRIA, INCLUIR OPÇÃO DE ENVIAR ST DAS NOTAS PROPRIAS DE TRANSERENCIA DE ESTOQUE.
    if (strApropriaCred = 'N') and (not(blnEnviaStVenda)) then
      strClaVen := IIF(fEmptyStr(VS_strClaVen), '', VS_strClaVen + '5409_6409_')
    else strClaVen := VS_strClaVen;

    If (Pos(strClafis, strClaVen) > 0) And (Not blnEnviaStVenda) And (StrToIntDef(strClafis, 0) >= 5000) And (Pos(strClafis, '5411_6411_') = 0) Then
      Result := True
    Else If (Pos(strClafis, VS_strClaCom) > 0) And (Not blnEnviaStCompra) Then
      Result := True
    Else if (Pos(strClafis, '_5910_6910_7910_') > 0) And (Not blnEnviaST_CFOP_X910) Then
      Result := True
    Else If (Pos(strClafis, VS_strClaDev) > 0) Then
    Begin
      If (Pos(Copy(strClafis, 001,001), '5_6') > 0) And (Not blnEnviaStDevCompra) Then
        Result := True
      Else If (Pos(Copy(strClafis, 001,001), '1_2') > 0) And (Not blnEnviaStDevVenda) Then
        Result := True;
    End;
  End;

end;

{*****************************************}
{* FAZ ALINHAENTO (PAD) À DIREITA        *}
{**************************************WI*}
function fPadR(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  if Length(strTexto) < intTamanho then
  begin
    intTamanho := intTamanho - Length(strTexto);
  end
  else
  begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  end;

  For intContador := 1 To intTamanho Do
    Result := Result + strCaracter;
end;

{*****************************************}
{* FAZ ALINHAMENTO (PAD) À ESQUERDA      *}
{**************************************WI*}
function fPadL(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  if Length(strTexto) < intTamanho then
  begin
    intTamanho := intTamanho - Length(strTexto);
  end
  else
  begin
    Result := Copy(strTexto, (Length(strTexto) + 1) - intTamanho, intTamanho);
    Exit;
  end;

  For intContador := 1 To intTamanho Do
    Result := strCaracter + Result;
end;

{*****************************************}
{* FAZ ALINHAMENTO (PAD) CENTRAL         *}
{**********************01/09/09***** AM **}
function fPadC(strTexto: String; intTamanho: Integer; strCaracter: String = ' '): String;
  Var
    intContador: Integer;
begin
  Result := strTexto;

  if Length(strTexto) < intTamanho then
  begin
    intTamanho := intTamanho - Length(strTexto);
  end
  else
  begin
    Result := Copy(strTexto,1,intTamanho);
    Exit;
  end;

  For intContador := 1 To Round(intTamanho/2) Do
    Result := strCaracter + Result;
  For intContador := 1 To Round(intTamanho/2) Do
    Result := Result + strCaracter;
end;


{**********************************************************************}
{* INSERE ZEROS A ESQUERDA DE UMA STRING                              *}
{******************************************************ABR/2010***[AM]*}
(*
function fPadZ(strTexto:string; Quant:integer):String;
  var i, Tam: Integer;
begin
  Tam := Length(strTexto);
  if (Quant - Tam) > 0 then
    for i:=1 to (Quant - Tam) do
      strTexto := '0' + strTexto;
  Result := RightStr(strTexto, Quant);
end;
*)

{**********************************************************************}
{* INSERE ZEROS A ESQUERDA DE UM NUMERO OU STRING                     *}
{******************************************************ABR/2010***[AM]*}
function fPadZ(strTexto:variant; Quant:integer):String;
  var i, Tam: Integer;
begin

  if VarType(strTexto) = varDouble then
    strTexto := Trim(fTiraCaracEspeciais(floatToStr(strTexto), False, True))
  else if VarType(strTexto) = varInteger then
    strTexto := Trim(fTiraCaracEspeciais(IntToStr(strTexto), False, True))
  else
  begin
  end;

  Tam := Length(strTexto);
  if (Quant - Tam) > 0 then
    for i:=1 to (Quant - Tam) do
      strTexto := '0' + strTexto;
  Result := RightStr(strTexto, Quant);
end;

function fPadZR(strTexto:variant; Quant:integer):String;
  var i, Tam: Integer;
begin

  if VarType(strTexto) = varDouble then
    strTexto := Trim(fTiraCaracEspeciais(floatToStr(strTexto), False, True))
  else if VarType(strTexto) = varInteger then
    strTexto := Trim(fTiraCaracEspeciais(IntToStr(strTexto), False, True))
  else
  begin
  end;

  Tam := Length(strTexto);
  if (Quant - Tam) > 0 then
    for i:=1 to (Quant - Tam) do
      strTexto := strTexto + '0';
  Result := RightStr(strTexto, Quant);
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
  begin
 	if (Aux[i] <> ',') then 
    Zeros := Zeros + Aux[i];
  end;

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

function fRetNomPortador(Const strCodPor: String): String;
  Var
    strSQL   : String;
    qryGenPor: TUniQuery;

Begin
  Try
    qryGenPor := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  POR_CODPOR = :CODPOR ';

    With qryGenPor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODPOR').AsString := strCodPor;
      Open;
      If Not IsEmpty Then
        Result := FieldByName('POR_NOMPOR').AsString
      Else
        Result := '';
      Close;
    End;

  Finally
    FreeAndNil(qryGenPor);
  End;
End;

{$IFDEF MSWINDOWS}
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
{$ENDIF}

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

function fRetEmpLoginUsuario(strCodOpe: String): String;
  Var
    strSQL: String;
    qryGen: TUniQuery;

begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    if fCampoExiste('CADOPE', 'OPE_EMPLOG') then
      strSQL := strSQL + '  OPE_EMPLOG AS EMPLOG '
    else
      strSQL := strSQL + '  OPE_EMPACE AS EMPLOG ';

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
      Result := FieldByName('EMPLOG').AsString;
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

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

function fRetCodigoIBGE(strCodEmp: string): string;
  var
    qryAux: TUniQuery;
begin
  Result := '';

  if not fEmptyStr(strCodEmp) then
  begin
    qryAux := fCriaQuery(nil);
    try
      with qryAux do
      begin
        Close;
        SQL.Clear;
        SQL.Text := ' SELECT CID_COIBGE FROM CADEMP LEFT JOIN CADCID ON CID_CODCID = EMP_CODCID WHERE EMP_CODEMP = :CODEMP ';
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        Result := FieldByName('CID_COIBGE').AsString;
      end;
    finally
      qryAux.Free;
    end;
  end;
end;

function fEncontraColunaLivro(cdsDados: TDataset; strClaFis: String;
  fltAlqIcm: Double): String;
  Var
    intContador: Integer;
begin

  Result := '';
  For intContador := 1 To 5 Do
  begin

    if (cdsDados.FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString = strClaFis) And
       (cdsDados.FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat = fltAlqIcm) then
    begin
      Result := IntToStr(intContador);
    end;

  end;

end;
{$IFDEF MSWINDOWS}
procedure pRegistrarProgresso(progresso: TGauge; intInicio, intAtual, intFinal: Integer);
begin
  progresso.MinValue := intInicio;
  progresso.Progress := intAtual;
  progresso.MaxValue := intFinal;
end;

function fOrdenaListaCadPagDataDocumento(blnDtaCad: Boolean): IComparer<TContasPagar>;
  Var
    criterioComparacao: TComparison<TContasPagar>;
begin
  If blnDtaCad Then
  Begin
    criterioComparacao := function(const L: TContasPagar; const R: TContasPagar): Integer
                          Begin
                            Result := Trunc(Int(L.dtaDataCadastro) - Int(R.dtaDataCadastro));

                            If Result = 0 Then
                              Result := CompareText(L.strNumero, R.strNumero);
                          End;
  End
  Else
  Begin
    criterioComparacao := function(const L: TContasPagar; const R: TContasPagar): Integer
                          Begin
                            Result := Trunc(Int(L.dtaDataBaixa) - Int(R.dtaDataBaixa));

                            If Result = 0 Then
                              Result := CompareText(L.strNumero, R.strNumero);
                          End;
  End;

  Result := TComparer<TContasPagar>.Construct(criterioComparacao);
end;
{$ENDIF}
procedure pDefinirCharsetConexao;
  var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    try
      with qryGen do
      begin
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

      end;
    except
      on E : Exception do
      begin
        {$IFDEF MSWINDOWS}
        pMensagensErro(E.Message, '[pDefinirCharsetConexao]');
        fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
        If (fTabelaExiste('LOGACE')) then
          TLogAut.New().pLogout();
        Application.Terminate;
        {$ENDIF}
        
        raise Exception.Create(e.Message);
      end;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

{$IFDEF MSWINDOWS}
function fOrdenaListaCadRecDataDocumento(blnDtaCad: Boolean): IComparer<TContasReceber>;
  Var
    criterioComparacao: TComparison<TContasReceber>;
begin
  If blnDtaCad Then
  Begin
    criterioComparacao := function(const L: TContasReceber; const R: TContasReceber): Integer
                          Begin
                            Result := Trunc(Int(L.dtaDataCadastro) - Int(R.dtaDataCadastro));

                            If Result = 0 Then
                              Result := CompareText(L.strNumero, R.strNumero);
                          End;
  End
  Else
  Begin
    criterioComparacao := function(const L: TContasReceber; const R: TContasReceber): Integer
                          Begin
                            Result := Trunc(Int(L.dtaDataBaixa) - Int(R.dtaDataBaixa));

                            If Result = 0 Then
                              Result := CompareText(L.strNumero, R.strNumero);
                          End;
  End;

  Result := TComparer<TContasReceber>.Construct(criterioComparacao);
end;
{$ENDIF}

function fPreInv(strAlias : String = ''; strAliasImpFed : String = ''; strPreInv: String = ''; blnIfNull: Boolean = True):String;
  Var
    strValCfg : String;
    strAliasInt: string;
Begin
  If fEmptyStr(strPreInv) Then
    strValCfg := Trim(fCfgSis('PREINV'))
  Else
    strValCfg := strPreInv;

  If fEmptyStr(strAliasImpFed) Then
    strAliasImpFed := strAlias;

  If Pos(strValCfg , CAMPOS_INV) <= 0 Then
  Begin
    result := '';
    {$IFDEF MSWINDOWS}  
    fMensagem('', 'Configure o campo que será utilizado para o cálculo do inventário.', ['&Ok']);
    {$ENDIF}
    Exit;

  End;

  strAliasInt := IIF(fEmptyStr(strAlias),'',strAlias + '.' );
  If strValCfg = 'PRELIQ' Then
    Result := 'ROUND(' + strAliasInt + 'ITE_PRECOM * (1 - ' + strAliasInt + 'ITE_DESF01 / 100) * ' +
                   '(1 - ' + strAliasInt + 'ITE_DESF02 / 100) * ' +
                   '(1 - ' + strAliasInt + 'ITE_DESF03 / 100) * ' +
                   '(1 - ' + strAliasInt + 'ITE_DESF04 / 100) * ' +
                   '(1 - ' + strAliasInt + 'ITE_DESF05 / 100) * ' +
                   '(1 - ' + strAliasInt + 'ITE_DESF06 / 100), 2)'
  Else If strValCfg = 'IMPULT' Then
  Begin
    If blnIfNull Then
      Result := 'IFNULL(' + strAliasInt + 'ITE_' + strValCfg + ',0)'
    Else
      Result :=  strAliasInt + 'ITE_' + strValCfg;
  End
  Else if Length(strValCfg) = 3 Then
  Begin
    If blnIfNull Then
      Result := 'IFNULL(' + strAliasInt + 'ITE_PRE' + strValCfg + ',0)'
    Else
      Result :=  strAliasInt + 'ITE_PRE' + strValCfg ;
  End
  Else
    Result := 'ROUND( IFNULL(' + strAliasInt + 'ITE_PREULT,0) - (IFNULL(' + strAliasInt + 'ITE_PREULT,0) * IFNULL(' + IIF(fEmptyStr(strAliasImpFed),'',strAliasImpFed + '.' ) + 'ITE_IMPFED,0) / 100), 2)';
end;

function GetSQLRegistro_E_RegE113(AOpcao: integer): String;
begin

  Result := '';

  if AOpcao = 1 then
  begin

    Result := Result + 'SELECT ';
    Result := Result + 'AJU_CODAJU, ';
    Result := Result + 'SUM(AJU_VALAJU) AS AJU_VALAJU, ';
    Result := Result + 'AJU_DESAJU, ';
    Result := Result + 'AJU_OBSERV, ';
    Result := Result + 'AJU_NUMDOC, ';
    Result := Result + 'AJU_DTAENT, ';
    Result := Result + 'AJU_MESANO, ';
    Result := Result + 'AJU_CODEMP, ';
    Result := Result + 'FIS_NUMDOC, ';
    Result := Result + 'FIS_SERIE_, ';
    Result := Result + 'FIS_DOCMOD, ';
    Result := Result + 'FIS_PART_COD, ';
    Result := Result + 'FIS_PART_NOME, ';
    Result := Result + 'FIS_TIP_FC, ';
    Result := Result + 'FIS_FORCLI, ';
    Result := Result + 'FIS_ACESSO, ';
    Result := Result + 'FIS_DTAENT, ';
    Result := Result + 'FIS_CLFSC1, ';
    Result := Result + 'FIS_VLRIC1, ';
    Result := Result + 'CID_CODCID AS FIS_CODCID ';
    Result := Result + 'FROM ( ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + '"" AS AJU_NUMDOC, ';
    Result := Result + 'NULL AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + '"" AS FIS_NUMDOC, ';
    Result := Result + '"" AS FIS_SERIE_, ';
    Result := Result + '"" AS FIS_DOCMOD, ';
    Result := Result + '"" AS FIS_PART_NOME, ';
    Result := Result + '"" AS FIS_PART_COD, ';
    Result := Result + '"" AS FIS_TIP_FC, ';
    Result := Result + '"" AS FIS_FORCLI, ';
    Result := Result + '"" AS FIS_ACESSO, ';
    Result := Result + 'NULL AS FIS_DTAENT, ';
    Result := Result + '"" AS FIS_CLFSC1, ';
    Result := Result + '0 AS FIS_VLRIC1, ';
    Result := Result + '"00000" AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")="" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + 'AND A.AJU_TIPAJU = :TIPAJU ';
    Result := Result + 'UNION ALL ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS AJU_NUMDOC, ';
    Result := Result + 'IFNULL(F.FIS_DTADOC,IFNULL(F.FIS_DTAENT,NULL)) AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS FIS_NUMDOC, ';
    Result := Result + 'F.FIS_SERIE_ AS FIS_SERIE_, ';
    Result := Result + 'IF(((IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%") AND (F.FIS_ESPDOC IN ("IF", "IV"))), "65", ';
    Result := Result + 'IF(IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(F.FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (F.FIS_ESPDOC = "NF") AND (IFNULL(F.FIS_ACESSO,"") = "") , "01", ';
    Result := Result + 'IF( ( (F.FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(F.FIS_ACESSO,"") <> "") ) OR ';
    Result := Result + '(F.FIS_ESPDOC = "EL"), "55", ';
    Result := Result + 'IF( F.FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(F.FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS FIS_DOCMOD, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_NOMFOR, CLI.CLI_NOMCLI) AS FIS_PART_NOME, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_C_G_C_, CLI.CLI_C_G_C_) AS FIS_PART_COD, ';
    Result := Result + 'F.FIS_TIP_FC AS FIS_TIP_FC, ';
    Result := Result + 'F.FIS_FORCLI AS FIS_FORCLI, ';
    Result := Result + 'IFNULL(F.FIS_ACESSO,"") AS FIS_ACESSO, ';
    Result := Result + 'F.FIS_DTAENT AS FIS_DTAENT, ';
    Result := Result + 'F.FIS_CLFSC1 AS FIS_CLFSC1, ';
    Result := Result + 'F.FIS_VLRIC1 AS FIS_VLRIC1, ';
    Result := Result + 'IFNULL(IF(FIS_TIP_FC = "F",CIDPARF.CID_CODCID,CIDPARC.CID_CODCID), "00000" ) AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'LEFT JOIN CADFIS AS F ON F.FIS_NUMDOC = SUBSTRING(I.AJU_NUMNOT, 01, 12) AND F.FIS_ESPDOC = "NF" AND FIS_CODEMP = I.AJU_CODEMP ';
//    Result := Result + 'LEFT JOIN CADFIS AS F ON F.AUTOINCREM = SUBSTRING(I.AJU_NUMNOT, 13 , 32) ';
    Result := Result + 'LEFT JOIN CADCLI AS CLI ON CLI.CLI_CODCLI = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADFOR AS FORN ON FORN.FOR_CODFOR = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADCID CIDPARC ON CIDPARC.CID_CODCID = CLI.CLI_CODCID ';
    Result := Result + 'LEFT JOIN CADCID CIDPARF ON CIDPARF.CID_CODCID = FORN.FOR_CODCID ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")<>"" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + 'AND A.AJU_TIPAJU = :TIPAJU ';
    Result := Result + ') AS REL ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND ((CAST(SUBSTRING(AJU_MESANO, 4, 4)  AS SIGNED)) >= :ANOINI AND (CAST(SUBSTRING(AJU_MESANO, 1, 2) AS SIGNED)) >= :MESINI) ';
    Result := Result + 'AND ((CAST(SUBSTRING(AJU_MESANO, 4, 4)  AS SIGNED)) <= :ANOFIN AND (CAST(SUBSTRING(AJU_MESANO, 1, 2) AS SIGNED)) <= :MESFIN) ';
    Result := Result + 'GROUP BY AJU_CODAJU, AJU_OBSERV, AJU_NUMDOC ';

  end
  Else If AOpcao = 2 then
  begin

    Result := Result + 'SELECT ';
    Result := Result + 'AJU_CODAJU, ';
    Result := Result + 'SUM(AJU_VALAJU) AS AJU_VALAJU, ';
    Result := Result + 'AJU_DESAJU, ';
    Result := Result + 'AJU_OBSERV, ';
    Result := Result + 'AJU_NUMDOC, ';
    Result := Result + 'AJU_DTAENT, ';
    Result := Result + 'AJU_MESANO, ';
    Result := Result + 'AJU_CODEMP, ';
    Result := Result + 'FIS_NUMDOC, ';
    Result := Result + 'FIS_SERIE_, ';
    Result := Result + 'FIS_DOCMOD, ';
    Result := Result + 'FIS_PART_COD, ';
    Result := Result + 'FIS_PART_NOME, ';
    Result := Result + 'FIS_TIP_FC, ';
    Result := Result + 'FIS_FORCLI, ';
    Result := Result + 'FIS_ACESSO, ';
    Result := Result + 'FIS_DTAENT, ';
    Result := Result + 'FIS_CLFSC1, ';
    Result := Result + 'FIS_VLRIC1, ';
    Result := Result + 'CID_CODCID AS FIS_CODCID ';
    Result := Result + 'FROM ( ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + '"" AS AJU_NUMDOC, ';
    Result := Result + 'NULL AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + '"" AS FIS_NUMDOC, ';
    Result := Result + '"" AS FIS_SERIE_, ';
    Result := Result + '"" AS FIS_DOCMOD, ';
    Result := Result + '"" AS FIS_PART_NOME, ';
    Result := Result + '"" AS FIS_PART_COD, ';
    Result := Result + '"" AS FIS_TIP_FC, ';
    Result := Result + '"" AS FIS_FORCLI, ';
    Result := Result + '"" AS FIS_ACESSO, ';
    Result := Result + 'NULL AS FIS_DTAENT, ';
    Result := Result + '"" AS FIS_CLFSC1, ';
    Result := Result + '0 AS FIS_VLRIC1, ';
    Result := Result + '"00000" AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")="" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + 'AND A.AJU_TIPAJU = :TIPAJU ';
    Result := Result + 'UNION ALL ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS AJU_NUMDOC, ';
    Result := Result + 'IFNULL(F.FIS_DTADOC,IFNULL(F.FIS_DTAENT,NULL)) AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS FIS_NUMDOC, ';
    Result := Result + 'F.FIS_SERIE_ AS FIS_SERIE_, ';
    Result := Result + 'IF(((IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%") AND (F.FIS_ESPDOC IN ("IF", "IV"))), "65", ';
    Result := Result + 'IF(IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(F.FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (F.FIS_ESPDOC = "NF") AND (IFNULL(F.FIS_ACESSO,"") = "") , "01", ';
    Result := Result + 'IF( ( (F.FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(F.FIS_ACESSO,"") <> "") ) OR ';
    Result := Result + '(F.FIS_ESPDOC = "EL"), "55", ';
    Result := Result + 'IF( F.FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(F.FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS FIS_DOCMOD, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_NOMFOR, CLI.CLI_NOMCLI) AS FIS_PART_NOME, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_C_G_C_, CLI.CLI_C_G_C_) AS FIS_PART_COD, ';
    Result := Result + 'F.FIS_TIP_FC AS FIS_TIP_FC, ';
    Result := Result + 'F.FIS_FORCLI AS FIS_FORCLI, ';
    Result := Result + 'IFNULL(F.FIS_ACESSO,"") AS FIS_ACESSO, ';
    Result := Result + 'F.FIS_DTAENT AS FIS_DTAENT, ';
    Result := Result + 'F.FIS_CLFSC1 AS FIS_CLFSC1, ';
    Result := Result + 'F.FIS_VLRIC1 AS FIS_VLRIC1, ';
    Result := Result + 'IFNULL(IF(FIS_TIP_FC = "F",CIDPARF.CID_CODCID,CIDPARC.CID_CODCID), "00000" ) AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'LEFT JOIN CADFIS AS F ON F.FIS_NUMDOC = SUBSTRING(I.AJU_NUMNOT, 01, 12) AND F.FIS_ESPDOC = "NF" AND FIS_CODEMP = I.AJU_CODEMP ';
//    Result := Result + 'LEFT JOIN CADFIS AS F ON F.AUTOINCREM = SUBSTRING(I.AJU_NUMNOT, 13 , 32) ';
    Result := Result + 'LEFT JOIN CADCLI AS CLI ON CLI.CLI_CODCLI = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADFOR AS FORN ON FORN.FOR_CODFOR = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADCID CIDPARC ON CIDPARC.CID_CODCID = CLI.CLI_CODCID ';
    Result := Result + 'LEFT JOIN CADCID CIDPARF ON CIDPARF.CID_CODCID = FORN.FOR_CODCID ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")<>"" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + 'AND A.AJU_TIPAJU = :TIPAJU ';
    Result := Result + ') AS REL ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND AJU_MESANO = :MESANO ';
    Result := Result + 'GROUP BY AJU_CODAJU, AJU_OBSERV, AJU_NUMDOC ';

  end
  Else If AOpcao = 3 then
  begin

    Result := Result + 'SELECT ';
    Result := Result + 'AJU_CODAJU, ';
    Result := Result + 'SUM(AJU_VALAJU) AS AJU_VALAJU, ';
    Result := Result + 'AJU_DESAJU, ';
    Result := Result + 'AJU_OBSERV, ';
    Result := Result + 'AJU_NUMDOC, ';
    Result := Result + 'AJU_DTAENT, ';
    Result := Result + 'AJU_MESANO, ';
    Result := Result + 'AJU_CODEMP, ';
    Result := Result + 'FIS_NUMDOC, ';
    Result := Result + 'FIS_SERIE_, ';
    Result := Result + 'FIS_DOCMOD, ';
    Result := Result + 'FIS_PART_COD, ';
    Result := Result + 'FIS_PART_NOME, ';
    Result := Result + 'FIS_TIP_FC, ';
    Result := Result + 'FIS_FORCLI, ';
    Result := Result + 'FIS_ACESSO, ';
    Result := Result + 'FIS_DTAENT, ';
    Result := Result + 'FIS_CLFSC1, ';
    Result := Result + 'FIS_VLRIC1, ';
    Result := Result + 'CID_CODCID AS FIS_CODCID ';
    Result := Result + 'FROM ( ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + '"" AS AJU_NUMDOC, ';
    Result := Result + 'NULL AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + '"" AS FIS_NUMDOC, ';
    Result := Result + '"" AS FIS_SERIE_, ';
    Result := Result + '"" AS FIS_DOCMOD, ';
    Result := Result + '"" AS FIS_PART_NOME, ';
    Result := Result + '"" AS FIS_PART_COD, ';
    Result := Result + '"" AS FIS_TIP_FC, ';
    Result := Result + '"" AS FIS_FORCLI, ';
    Result := Result + '"" AS FIS_ACESSO, ';
    Result := Result + 'NULL AS FIS_DTAENT, ';
    Result := Result + '"" AS FIS_CLFSC1, ';
    Result := Result + '0 AS FIS_VLRIC1, ';
    Result := Result + '"00000" AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")="" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + 'UNION ALL ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS AJU_NUMDOC, ';
    Result := Result + 'IFNULL(F.FIS_DTADOC,IFNULL(F.FIS_DTAENT,NULL)) AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS FIS_NUMDOC, ';
    Result := Result + 'F.FIS_SERIE_ AS FIS_SERIE_, ';
    Result := Result + 'IF(((IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%") AND (F.FIS_ESPDOC IN ("IF", "IV"))), "65", ';
    Result := Result + 'IF(IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(F.FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (F.FIS_ESPDOC = "NF") AND (IFNULL(F.FIS_ACESSO,"") = "") , "01", ';
    Result := Result + 'IF( ( (F.FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(F.FIS_ACESSO,"") <> "") ) OR ';
    Result := Result + '(F.FIS_ESPDOC = "EL"), "55", ';
    Result := Result + 'IF( F.FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(F.FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS FIS_DOCMOD, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_NOMFOR, CLI.CLI_NOMCLI) AS FIS_PART_NOME, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_C_G_C_, CLI.CLI_C_G_C_) AS FIS_PART_COD, ';
    Result := Result + 'F.FIS_TIP_FC AS FIS_TIP_FC, ';
    Result := Result + 'F.FIS_FORCLI AS FIS_FORCLI, ';
    Result := Result + 'IFNULL(F.FIS_ACESSO,"") AS FIS_ACESSO, ';
    Result := Result + 'F.FIS_DTAENT AS FIS_DTAENT, ';
    Result := Result + 'F.FIS_CLFSC1 AS FIS_CLFSC1, ';
    Result := Result + 'F.FIS_VLRIC1 AS FIS_VLRIC1, ';
    Result := Result + 'IFNULL(IF(FIS_TIP_FC = "F",CIDPARF.CID_CODCID,CIDPARC.CID_CODCID), "00000" ) AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'LEFT JOIN CADFIS AS F ON F.FIS_NUMDOC = SUBSTRING(I.AJU_NUMNOT, 01, 12) AND F.FIS_ESPDOC = "NF" AND FIS_CODEMP = I.AJU_CODEMP ';
//    Result := Result + 'LEFT JOIN CADFIS AS F ON F.AUTOINCREM = SUBSTRING(I.AJU_NUMNOT, 13 , 32) ';
    Result := Result + 'LEFT JOIN CADCLI AS CLI ON CLI.CLI_CODCLI = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADFOR AS FORN ON FORN.FOR_CODFOR = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADCID CIDPARC ON CIDPARC.CID_CODCID = CLI.CLI_CODCID ';
    Result := Result + 'LEFT JOIN CADCID CIDPARF ON CIDPARF.CID_CODCID = FORN.FOR_CODCID ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")<>"" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + ') AS REL ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND AJU_MESANO = :MESANO ';
    Result := Result + 'GROUP BY AJU_CODAJU, AJU_OBSERV, AJU_NUMDOC ';

  end
  Else If AOpcao = 4 then
  begin

    Result := Result + 'SELECT ';
    Result := Result + 'AJU_CODAJU, ';
    Result := Result + 'SUM(AJU_VALAJU) AS AJU_VALAJU, ';
    Result := Result + 'AJU_DESAJU, ';
    Result := Result + 'AJU_OBSERV, ';
    Result := Result + 'AJU_NUMDOC, ';
    Result := Result + 'AJU_DTAENT, ';
    Result := Result + 'AJU_MESANO, ';
    Result := Result + 'AJU_CODEMP, ';
    Result := Result + 'FIS_NUMDOC, ';
    Result := Result + 'FIS_SERIE_, ';
    Result := Result + 'FIS_DOCMOD, ';
    Result := Result + 'FIS_PART_COD, ';
    Result := Result + 'FIS_PART_NOME, ';
    Result := Result + 'FIS_TIP_FC, ';
    Result := Result + 'FIS_FORCLI, ';
    Result := Result + 'FIS_ACESSO, ';
    Result := Result + 'FIS_DTAENT, ';
    Result := Result + 'FIS_CLFSC1, ';
    Result := Result + 'FIS_VLRIC1, ';
    Result := Result + 'CID_CODCID AS FIS_CODCID ';
    Result := Result + 'FROM ( ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS AJU_NUMDOC, ';
    Result := Result + 'IFNULL(F.FIS_DTADOC,IFNULL(F.FIS_DTAENT,NULL)) AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + 'IFNULL(F.FIS_NUMDOC,"") AS FIS_NUMDOC, ';
    Result := Result + 'F.FIS_SERIE_ AS FIS_SERIE_, ';
    Result := Result + 'IF(((IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%") AND (F.FIS_ESPDOC IN ("IF", "IV"))), "65", ';
    Result := Result + 'IF(IFNULL(F.FIS_HISTOR, "") LIKE "%INUTILI%", "55", IF(F.FIS_SERIE_ BETWEEN 890 AND 899, "55", IF( (F.FIS_ESPDOC = "NF") AND (IFNULL(F.FIS_ACESSO,"") = "") , "01", ';
    Result := Result + 'IF( ( (F.FIS_ESPDOC IN ("NF", "NV")) AND (IFNULL(F.FIS_ACESSO,"") <> "") ) OR ';
    Result := Result + '(F.FIS_ESPDOC = "EL"), "55", ';
    Result := Result + 'IF( F.FIS_ESPDOC IN ("IF", "IV"), IF(IFNULL(F.FIS_ACESSO,"")="", "2D", "65"), "01" ) ) ) ) ) ) AS FIS_DOCMOD, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_NOMFOR, CLI.CLI_NOMCLI) AS FIS_PART_NOME, ';
    Result := Result + 'IF(F.FIS_TIP_FC = "F", FORN.FOR_C_G_C_, CLI.CLI_C_G_C_) AS FIS_PART_COD, ';
    Result := Result + 'F.FIS_TIP_FC AS FIS_TIP_FC, ';
    Result := Result + 'F.FIS_FORCLI AS FIS_FORCLI, ';
    Result := Result + 'IFNULL(F.FIS_ACESSO,"") AS FIS_ACESSO, ';
    Result := Result + 'F.FIS_DTAENT AS FIS_DTAENT, ';
    Result := Result + 'F.FIS_CLFSC1 AS FIS_CLFSC1, ';
    Result := Result + 'F.FIS_VLRIC1 AS FIS_VLRIC1, ';
    Result := Result + 'IFNULL(IF(FIS_TIP_FC = "F",CIDPARF.CID_CODCID,CIDPARC.CID_CODCID), "00000" ) AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'LEFT JOIN CADFIS AS F ON F.FIS_NUMDOC = SUBSTRING(I.AJU_NUMNOT, 01, 12) AND F.FIS_ESPDOC = "NF" AND FIS_CODEMP = I.AJU_CODEMP ';
//    Result := Result + 'LEFT JOIN CADFIS AS F ON F.AUTOINCREM = SUBSTRING(I.AJU_NUMNOT, 13 , 32) ';
    Result := Result + 'LEFT JOIN CADCLI AS CLI ON CLI.CLI_CODCLI = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADFOR AS FORN ON FORN.FOR_CODFOR = F.FIS_FORCLI ';
    Result := Result + 'LEFT JOIN CADCID CIDPARC ON CIDPARC.CID_CODCID = CLI.CLI_CODCID ';
    Result := Result + 'LEFT JOIN CADCID CIDPARF ON CIDPARF.CID_CODCID = FORN.FOR_CODCID ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")<>"" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + ') AS REL ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND AJU_MESANO = :MESANO ';
    Result := Result + 'GROUP BY AJU_CODAJU, AJU_OBSERV, AJU_NUMDOC ';

  end

  Else If AOpcao = 5 then
  begin

    Result := Result + 'SELECT ';
    Result := Result + 'AJU_CODAJU, ';
    Result := Result + 'SUM(AJU_VALAJU) AS AJU_VALAJU, ';
    Result := Result + 'AJU_DESAJU, ';
    Result := Result + 'AJU_OBSERV, ';
    Result := Result + 'AJU_NUMDOC, ';
    Result := Result + 'AJU_DTAENT, ';
    Result := Result + 'AJU_MESANO, ';
    Result := Result + 'AJU_CODEMP, ';
    Result := Result + 'FIS_NUMDOC, ';
    Result := Result + 'FIS_SERIE_, ';
    Result := Result + 'FIS_DOCMOD, ';
    Result := Result + 'FIS_PART_COD, ';
    Result := Result + 'FIS_PART_NOME, ';
    Result := Result + 'FIS_TIP_FC, ';
    Result := Result + 'FIS_FORCLI, ';
    Result := Result + 'FIS_ACESSO, ';
    Result := Result + 'FIS_DTAENT, ';
    Result := Result + 'FIS_CLFSC1, ';
    Result := Result + 'FIS_VLRIC1, ';
    Result := Result + 'CID_CODCID AS FIS_CODCID ';
    Result := Result + 'FROM ( ';
    Result := Result + 'SELECT ';
    Result := Result + 'I.AJU_CODAJU, ';
    Result := Result + 'I.AJU_VALAJU AS AJU_VALAJU, ';
    Result := Result + 'A.AJU_DESAJU, ';
    Result := Result + 'IF(IFNULL(I.AJU_OBSERV,"")<>"",I.AJU_OBSERV,A.AJU_DESAJU) AS AJU_OBSERV, ';
    Result := Result + '"" AS AJU_NUMDOC, ';
    Result := Result + 'NULL AS AJU_DTAENT, ';
    Result := Result + 'I.AJU_MESANO, ';
    Result := Result + 'I.AJU_CODEMP, ';
    Result := Result + '"" AS FIS_NUMDOC, ';
    Result := Result + '"" AS FIS_SERIE_, ';
    Result := Result + '"" AS FIS_DOCMOD, ';
    Result := Result + '"" AS FIS_PART_NOME, ';
    Result := Result + '"" AS FIS_PART_COD, ';
    Result := Result + '"" AS FIS_TIP_FC, ';
    Result := Result + '"" AS FIS_FORCLI, ';
    Result := Result + '"" AS FIS_ACESSO, ';
    Result := Result + 'NULL AS FIS_DTAENT, ';
    Result := Result + '"" AS FIS_CLFSC1, ';
    Result := Result + '0 AS FIS_VLRIC1, ';
    Result := Result + '"00000" AS CID_CODCID ';
    Result := Result + 'FROM ';
    Result := Result + 'AJUICM AS I ';
    Result := Result + 'JOIN AJUSTE AS A ON A.AJU_CODAJU = I.AJU_CODAJU ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND IFNULL(I.AJU_NUMNOT,"")="" ';
    Result := Result + 'AND I.AJU_CODEMP = :CODEMP ';
    Result := Result + ') AS REL ';
    Result := Result + 'WHERE TRUE ';
    Result := Result + 'AND AJU_MESANO = :MESANO ';
    Result := Result + 'GROUP BY AJU_CODAJU, AJU_OBSERV, AJU_NUMDOC ';

  end;

end;


procedure pGravaLog(strNomeSecao: String; strNomArq: String = '');
	Var
		arqArqLog : TIniFile;
begin

  if (not VS_GRAVA_LOG) then
    exit;

  If (fEmptyStr(strNomArq)) Then
    strNomArq := 'arqlog.txt';

  arqArqLog := TIniFile.Create(ExtractFilePath(Application.ExeName) + strNomArq);

  Try
	  arqArqLog.WriteString('LOG',strNomeSecao,FormatDateTime('dd/mm/yyyy hh:nn:ss', fNow()));
  Finally
	  FreeAndNil(arqArqLog);
  end;

End;


{**********************************************************}
{* Lê/Grava dados no arquivo de Configuracao (Opcoes.ini) *}
{*******************************************************DV*}
function fArqIni(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String; strNomArq: String = ''):String;
	Var
		iniArqIni : TInifile;
begin
  Result := '';
  if (Trim(strNomArq) = '') then
    strNomArq := 'opcoes.ini';

  {1}{FS 10092019:1636}
  if strNomArq = 'opcoes.ini' then
  begin
    if (f__VS_CONEXAO_USANDO_PASTA_ANTERIOR_A_DO_AUTSI) then
      {**aqui - metodo atual}
      {$IFDEF MSWINDOWS}
      iniArqIni := TInifile.Create(fCaminhoConexaoUsandoPastaAnteriorDoAusti + strNomArq)
      {$ELSE}
      iniArqIni := TInifile.Create(TPath.Combine(fCaminhoConexaoUsandoPastaAnteriorDoAusti, strNomArq), TEncoding.ANSI)
      {$ENDIF}
    else
    begin
      {$IFDEF MSWINDOWS}
      iniArqIni := TInifile.Create(StringReplace(ExtractFilePath(Application.ExeName), '', '', [rfIgnoreCase]) + strNomArq);
      {$ELSE}
      // f__VS_CONEXAO_USANDO_LINUX_AUTSI,
      // alterar rotina pra false caso deseje usar em modo debug
      if not (f__VS_CONEXAO_USANDO_LINUX_AUTSI) then
      begin
        iniArqLinux := TInifile.Create(TPath.Combine(GetCurrentDir, strNomArq), TEncoding.ANSI);
        iniArqIni := TInifile.Create(TPath.Combine(GetCurrentDir, strNomArq), TEncoding.ANSI);
      end
      else
      begin
        iniArqLinux := TInifile.Create(TPath.Combine(GetCurrentDir, 'opcoes.ini'), TEncoding.ANSI);
        iniArqIni := TInifile.Create(iniArqLinux.ReadString('GERAL', 'BD', ''), TEncoding.ANSI);

      end;
      {$ENDIF}
    end;
  end
  else
  begin
    {$IFDEF MSWINDOWS}
    iniArqIni := TInifile.Create(StringReplace(ExtractFilePath(Application.ExeName), '', '', [rfIgnoreCase]) + strNomArq);
    {$ELSE}
    // f__VS_CONEXAO_USANDO_LINUX_AUTSI,
    // alterar rotina pra false caso deseje usar em modo debug
    if not (f__VS_CONEXAO_USANDO_LINUX_AUTSI) then
    begin
      iniArqLinux := TInifile.Create(TPath.Combine(GetCurrentDir, strNomArq), TEncoding.ANSI);
      iniArqIni := TInifile.Create(TPath.Combine(GetCurrentDir, strNomArq), TEncoding.ANSI);
    end
    else
    begin
      iniArqLinux := TInifile.Create(TPath.Combine(GetCurrentDir, 'opcoes.ini'), TEncoding.ANSI);
      iniArqIni := TInifile.Create(iniArqLinux.ReadString('GERAL', 'CONF', ''), TEncoding.ANSI);

    end;
    {$ENDIF}
  end;

  Try
    Case ReadWrite of
	    0: Result := iniArqIni.ReadString(NomChave,NomSecao,Conteudo);

	    1: Try
           iniArqIni.WriteString(NomChave,NomSecao,Conteudo);
         Except
           Result := 'False';
         end;
      2: Try
           iniArqIni.DeleteKey(NomChave,NomSecao);
         Except
           Result := 'False';
         End;
    end;
  Finally
    {$IFDEF MSWINDOWS}
	  iniArqIni.Free;
    {$ELSE}
	  iniArqLinux.Free;
	  iniArqIni.Free;
    {$ENDIF}
  end;
end;

function fArqIniAutSi(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
begin
  Result := fArqIni(ReadWrite, NomChave, NomSecao, Conteudo, 'opcoesautsi.ini');
end;

function fArqIniAutSi(ReadWrite:Integer;NomChave,NomSecao,Conteudo,strCodEmp:String):String;
begin
  Result := fArqIniAutSi(ReadWrite, NomChave, NomSecao + strCodEmp, Conteudo);
  If (fEmptyStr(Result)) And (ReadWrite = 0) then
     Result := fArqIniAutSi(ReadWrite, NomChave, NomSecao, Conteudo);
end;

function fNow: TDateTime;
begin
  Result := IfThen(Trunc(VS_Date) = 0, nOw(), VS_Date + fTime());
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

function fStrLocate(objCodigo: TObject; arrLinha: TConsultasArray; strNomCampo,
  strNomPar: String; blnSemAND: Boolean = False; blnNegar: Boolean = False;
  strCodigo: String = ''): String;
Begin
  {***********************************}
  {* VERIFICA O COMPONENTE PASSADO   *}
  {* E FAZ O TRATAMENTO DIFERENCIADO *}
  {* MASK OU EDIT                    *}
  {********************************JB*}
  {$IFDEF MSWINDOWS}
  if fEmptyStr(strCodigo) and Assigned(objCodigo) then
  begin
    if (objCodigo.ClassNameIs('TEditFocus')) then
      strCodigo := TEditFocus(objCodigo).Text
    else if (objCodigo.ClassNameIs('TMaskEditFocus')) then
      strCodigo := TMaskEditFocus(objCodigo).Text
    else
      strCodigo := '';
  end;
  {$ENDIF}

  if not fEmptyStr(strCodigo) then
  begin
    if blnNegar then
    begin
      if Length(arrLinha) > 1 then
        Result := '(NOT LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0) AND COALESCE(' + strNomCampo + ', "") <> "" '
      else
        Result := strNomCampo + ' <> :' + strNomPar + ' ';
    end
    else
    begin
      if Length(arrLinha) > 1 then
        Result := 'LOCATE(' + strNomCampo + ',:' + strNomPar + ') > 0  AND COALESCE(' + strNomCampo + ', "") <> "" '
      else
        Result := strNomCampo + ' = :' + strNomPar + ' ';
    end;

    if not blnSemAND then
      Result := '  AND ' + Result;
  end
  else
    Result := '';
End;

Procedure pMensagemOk(strMensagem: String);
Begin
  {$IFDEF MSWINDOWS}
  fMensagem('', strMensagem, ['&Ok']);
  {$ENDIF}      
End;
{$IFDEF MSWINDOWS}
function fStrTitulo(strText: string; strDescri: string; arrLinha: TConsultasArray; strLinha, strTitulo: string;
blnTodas: Boolean = False; blnNegar: Boolean = False): string;
begin
  if not fEmptyStr(strText) then
  begin
    if Length(arrLinha) > 1 then
      Result := strTitulo + ': ' + strLinha
    else
      Result := strTitulo + ': ' + strText + ' - ' + strDescri;
  end
  else
  begin
    if blnTodas then
    begin
      if blnNegar then
        Result := strTitulo + ': NENHUMA'
      else
        Result := strTitulo + ': TODAS'
    end
    else
    begin
      if blnNegar then
        Result := strTitulo + ': NENHUM'
      else
        Result := strTitulo + ': TODOS';
    end;
  end;
end;
{$ENDIF}

procedure pSetaParam(strText: string; arrLinha: TConsultasArray; var strLinha: string; strNomPar: string; qryRelatorio: TUniQuery);
  Var
    intContador : integer;
Begin
  strLinha := '';

  For intContador := 0 To Length(arrLinha) -1 Do
  Begin
    if Length(arrLinha) > 1 then
      strLinha := strLinha + arrLinha[intContador].strCodigo + '_'
    else
      strLinha := strLinha + arrLinha[intContador].strCodigo;
  End;

  With qryRelatorio Do
  If (Not fEmptyStr(strText)) And (Params.FindParam(strNomPar) <> Nil) Then
  Begin

    If Length(arrLinha) > 1 Then
    Begin
      ParamByName(strNomPar).AsString := strLinha;
    End
    Else
      ParamByName(strNomPar).AsString := strText;
  End;
end;

function fSetaPais: TPais;
Var
  strPais: String;
Begin
  strPais := fCfgSis('SIGPAI', varString);

  If SameText(strPais, 'PAR') Then
    Result := opcParaguai
  Else
    Result := opcBrasil;
End;

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

function fRetNatOpe(strCodCfo: String): String;
  var
    qryCadCfo: TUniQuery;
begin
  qryCadCfo := fCriaQuery(Nil);
  try
    with qryCadCfo do
    begin
      SQL.Clear;

      if fTabelaExiste('NATCFO') then
        SQL.Add('SELECT NAT_DESCRI FROM NATCFO WHERE NAT_CODCFO = :CODCFO ')
      else
        SQL.Add('SELECT CFO_NATOPE FROM CADCFO WHERE CFO_CODCFO = :CODCFO ');

      ParamByName('CODCFO').AsString := strCodCfo;
      Open;

      Result := Fields[0].AsString;
    end;
  finally
    FreeAndNil(qryCadCfo);
  end;
end;

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

function fRetNomeEmpresaSelec(const strCodEmpresa: string): string;
  Var
    strSQL: string;
    qryGenEmp: TUniQuery;
begin
  try
    qryGenEmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    with qryGenEmp do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmpresa;
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    end;
  finally
    FreeAndNil(qryGenEmp);
  end;
end;

function fRetNomeProdutoSelec(const strCodProduto: string): string;
  Var
    strSQL: string;
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_DESITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    with qryGen do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodProduto;
      Open;
      Result := FieldByName('ITE_DESITE').AsString;
      Close;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

function fFormataFonePais(strTelefo: String; FPais: TPais = opcBrasil): String;
Begin
  If FPais = opcParaguai Then
    Result := Trim(fTiraCaracEspeciaisParenteses(strTelefo))
  Else
    If Not (fEmptyStr(strTelefo)) Then
      Result := FormatMaskText(fRetMascaraFone(FPais),Copy(strTelefo,1,11))
    Else
      Result := '';
End;

function fFormataFone(strFone: String): String;
Begin
  strFone := fFormataFonePais(Trim(fTiraCaracEspeciaisParenteses(strFone)),fSetaPais);
  Result  := strFone;
End;

function fRetMascaraFone(opcPais: TPais): String;
Begin
  case opcPais Of
    opcBrasil  : Result := '!\(99\)99999-9999;0;_';
    opcParaguai: Result := '' ;
  end;
End;

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

function fFloatToInt(fltNumero: Double): Integer;
begin
  Result := StrToIntDef(FloatToStrF(fltNumero, ffFixed, 12, 0), 0);
end;

function fGetConnectionID: string;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.SQL.Add('SELECT CONNECTION_ID()');
    qryAux.Open;

    Result := qryAux.Fields[0].AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

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

(**********************************************************************)
(* CRIA VARIAVEIS DE CONFIGURACAO PARA EXPORTACAO                     *)
(******************************************************JAN/2010***[AM]*)
procedure pAtuVarGlobais;
begin
  {$IFDEF MSWINDOWS}
  VS_MacAddress            := GetMacAddress;
  VS_IPAddressAsString     := GetIPAddressAsString;
  VS_UserFromWindows       := GetUserFromWindows;
  VS_ComputerNetName       := GetComputerNetName;
  {$ENDIF}

  VS_GRAVA_LOG             := TRUE;

  VS_strPatPad             := fArqIniAutSi(0, 'GERAL', 'PATPAD', '');
  VS_strMenuCores          := fArqIniAutSi(0, 'GERAL', 'MENUCOR', '');
  VS_strExportaCupons      := fArqIniAutSi(0, 'GERAL', 'EXPORTACUPONS', '');
  VS_strGeraNaoBaixados    := fArqIniAutSi(0, 'FOLHAMATIC', 'PREFIXO_CONTA', '');
  VS_strFormaCtaCtb_CtaPg  := fArqIniAutSi(0, 'FOLHAMATIC', 'FORMA_CTA_CONTABIL_CTAPG', '');
  VS_strFolhaCtaCtbCredito := fArqIniAutSi(0, 'FOLHAMATIC', 'CTA_CONTABIL_CREDITO', '');
  VS_strFolhaCtaCtbDebito  := fArqIniAutSi(0, 'FOLHAMATIC', 'CTA_CONTABIL_DEBITO', '');
  VS_strNfpReg30serv       := fArqIniAutSi(0, 'GERAL', 'NFP_REG30_SERV', '');
  VS_strNfpUsaReg60        := fArqIniAutSi(0, 'GERAL', 'NFP_REG60', '');
  (* STRING CONTENDO OS SERVICOS CADASTRADOS COMO ITENS NO CADITE, SEPARADOS POR "_" *)
  VS_strItensServ          := fArqIniAutSi(0, 'GERAL', 'NFP_ITENS_SERV', '');
  VS_strContasFornecedores := fArqIniAutSi(0, 'PROSOFT', 'CTAS_PGR_ESPECIFICAS', '');

  {****************************************************************************}
  {* PERMITE GERAR LANCAMENTOS NAO BAIXADOS                                   *}
  {******************************************************* MAR/2010 * [AM] ****}
  VS_strGeraNaoBaixados    := fArqIniAutSi(0, 'GERAL', 'GERA_NAO_BAIXADOS', '');

  {****************************************************************************}
  {* CONTAS CONTABEIS DE CONTAS A PAGAR                                       *}
  {******************************************************* MAR/2010 * [AM] ****}
  VS_strComprasVistaCod   := fArqIniAutSi(0, 'GERAL', 'CTP_CONTABIL_COMPRAS_VISTA', '', VS_strCodEmp);
  VS_strComprasVistaDescr := fArqIniAutSi(0, 'GERAL', 'CTP_CONTABIL_COMPRAS_VISTA_DESCR', '', VS_strCodEmp);
  //VS_strComprasPrazoCod   := fArqIniAutSi(0, 'GERAL', 'CTP_CONTABIL_COMPRAS_PRAZO', '');
  //VS_strComprasPrazoDescr := fArqIniAutSi(0, 'GERAL', 'CTP_CONTABIL_COMPRAS_PRAZO_DESCR', '');

  {****************************************************************************}
  {* CONTAS CONTABEIS DE CONTAS A RECEBER                                     *}
  {******************************************************* MAR/2010 * [AM] ****}
  VS_strVendasVistaCod      := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_VENDAS_VISTA', '', VS_strCodEmp);
  VS_strVendasVistaDescr    := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_VENDAS_VISTA_DESCR', '', VS_strCodEmp);
  VS_strVendasPrazoCod      := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_VENDAS_PRAZO', '', VS_strCodEmp);
  VS_strVendasPrazoDescr    := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_VENDAS_PRAZO_DESCR', '', VS_strCodEmp);
  VS_strVendasCartoesCod    := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_CARTOES', '', VS_strCodEmp);
  VS_strVendasCartoesDescr  := fArqIniAutSi(0, 'GERAL', 'CTR_CONTABIL_CARTOES_DESCR', '', VS_strCodEmp);

  (* STRING DE CODIGO DE SITUACOES TRIBUTARIAS DE SUBSTITUICAO TRIBUTARIA *)
  VS_strCodSubstTrib := '_010_060_070_110_160_170_210_260_270';

  {* VERIFICA SE EH SIMPLES NACIONAL *}
  VS_strSimplesPaulista := fSimplesNacional(VS_strCodEmp);

  VS_strCredPisEntrada := fVerificaCredPisCofins(VS_strCodEmp);

  VS_strCodEstRecolheIcms  := fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMS_' + VS_strCodEmp, '' );
  VS_strCodEstRecolheIcmsSTForaEstado  := fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_FORA_ESTADO_' + VS_strCodEmp, VS_strCodEstRecolheIcms );
  VS_strCodEstRecolheIcmsSTDentroEstado  := fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO_' + VS_strCodEmp, VS_strCodEstRecolheIcms );
  VS_strDiaVencIcms        := fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_ICMS_' + VS_strCodEmp, '' );
  VS_strDiaVencIcmsST      := fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_ICMS_ST', VS_strDiaVencIcms, VS_strCodEmp);
  VS_strDiaVencDifalOrigem := fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_DIFAL_ORIGEM' + VS_strCodEmp, '');
  VS_strDiaVencDifalDestino := fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_DIFAL_DESTINO' + VS_strCodEmp, '');

  {$IFNDEF MSWINDOWS}
  VS_strClaCom := fTransform(fCfgSis('CLACOM'), 4);
  VS_strClaVen := fTransform(fCfgSis('CLAVEN'), 4);
  VS_strClaDev := fTransform(fCfgSis('CLADEV'), 4);
  {$ENDIF}

end;

procedure pCriaTabelaAJDIFL;
  Var
    qryAux: TUniQuery;
begin
  If Not fTabelaExiste('AJDIFL') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'CREATE TABLE AJDIFL (' +
                         '  AJD_DTAOPE VARCHAR(7) DEFAULT "",' +
                         '  AJD_CODEMP CHAR(3) DEFAULT "", ' +
                         '  AJD_ESTADO CHAR(2) NOT NULL DEFAULT "", ' +
                         '  AJD_CODAJU VARCHAR(8) DEFAULT "", ' +
                         '  AJD_DESAJU VARCHAR(50) DEFAULT "", ' +
                         '  AJD_VALAJU DECIMAL(12,2) DEFAULT 0.00, ' +
                         '  AJD_CREDEB CHAR(1) DEFAULT "", ' +
                         '  AUTOINCREM VARCHAR(20) NOT NULL DEFAULT "", ' +
                         '  PRIMARY KEY (AUTOINCREM) ' +
                         ') ENGINE=INNODB DEFAULT CHARSET=latin1 ';
      qryAux.ExecSql;
    Finally
      qryAux.Free;
    End;
  End;
end;

procedure pCriaTabelaAUTSI_SCRIPTS;
  Var
    qryAux: TUniQuery;
begin
  If Not fTabelaExiste('AUTSI_SCRIPTS') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'CREATE TABLE AUTSI_SCRIPTS (' +
                         '  ATS_SCRIPT VARCHAR(255) DEFAULT "",' +
                         '  ATS_CODIND CHAR(3) DEFAULT "", ' +
                         '  PRIMARY KEY (ATS_CODIND) ' +
                         ') ENGINE=INNODB DEFAULT CHARSET=latin1 ';
      qryAux.ExecSql;
    Finally
      qryAux.Free;
    End;
  End;
end;

procedure pCriaTabelaCRDFAL;
  Var
    qryAux: TUniQuery;
begin
  If Not fTabelaExiste('CRDFAL') Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'CREATE TABLE CRDFAL ( '+
                         '  CRD_CODEMP VARCHAR (03) NOT NULL, ' +
                         '  CRD_ESTADO VARCHAR (02) NOT NULL, ' +
                         '  CRD_CODIGO VARCHAR (40) NOT NULL, ' +
                         '  PRIMARY KEY (CRD_CODEMP, CRD_ESTADO) ' +
                         ') ENGINE = INNODB CHARSET = latin1';

      qryAux.ExecSql;
    Finally
      qryAux.Free;
    End;
  End;
end;

procedure pCriaTabelaMovIcdTmp;
  Var
    qryAux: TUniQuery;
begin
  If (Not fTabelaExiste('MOVICD')) And
     (Not fTabelaExiste('NOTICD')) And
     (Not fTabelaExiste('MOVICD_TMP')) And
     (Not fTabelaExiste('MOVICD_TMP')) Then
  Begin
    qryAux := fCriaQuery(Nil);
    Try
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'CREATE TABLE MOVICD_TMP ( ' +
                         '  ICD_SEQGER VARCHAR(20) NOT NULL, ' +
                         '  ICD_BCUFDE DECIMAL(15,2) NOT NULL, ' +
                         '  ICD_PERFCP DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_ALQUFD DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_ALQINE DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_PERPAR DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_VALFCP DECIMAL(15,2) NOT NULL, ' +
                         '  ICD_VALDES DECIMAL(15,2) NOT NULL, ' +
                         '  ICD_VALORI DECIMAL(15,2) NOT NULL, ' +
                         '  PRIMARY KEY (ICD_SEQGER), ' +
                         '  CONSTRAINT FK_NOVO_ICMUFD_01_MOVICD FOREIGN KEY (ICD_SEQGER) REFERENCES MOVDET (AUTOINCREM) ON DELETE CASCADE ON UPDATE CASCADE ' +
                         ') ENGINE=INNODB DEFAULT CHARSET=latin1';
      qryAux.ExecSql;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Text := 'CREATE TABLE NOTICD_TMP ( ' +
                         '  ICD_SEQGER VARCHAR(20) NOT NULL, ' +
                         '  ICD_BCUFDE DECIMAL(15,2) NOT NULL, ' +
                         '  ICD_PERFCP DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_ALQUFD DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_ALQINE DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_PERPAR DECIMAL(7,4) NOT NULL, ' +
                         '  ICD_VALFCP DECIMAL(15,2) DEFAULT NULL, ' +
                         '  ICD_VALDES DECIMAL(15,2) NOT NULL, ' +
                         '  ICD_VALORI DECIMAL(15,2) NOT NULL, ' +
                         '  PRIMARY KEY (ICD_SEQGER), ' +
                         '  CONSTRAINT FK_NOVO_NOTICD_01_NOTICD FOREIGN KEY (ICD_SEQGER) REFERENCES NOTDET (AUTOINCREM) ON DELETE CASCADE ON UPDATE CASCADE ' +
                         ') ENGINE=INNODB DEFAULT CHARSET=latin1';
      qryAux.ExecSql;
    Finally
      qryAux.Free;
    End;
  End;
end;

function fVerificaCredPisCofins(strCodEmp: string): string;
  Var
    cdsPesq: TClientDataSet;
begin
  Result := 'N';
  {$IFDEF MSWINDOWS}
  if FileExists(ExtractFilePath(Application.ExeName) + 'CfgExtras.XML') then
  begin

    cdsPesq := TClientDataSet.Create(nil);

    Try
      cdsPesq.LoadFromFile(ExtractFilePath(Application.ExeName) + 'CfgExtras.XML');

      cdsPesq.Open;

      cdsPesq.IndexFieldNames := 'EMP_CODEMP';
      cdsPesq.First;
      if cdsPesq.FindKey([strCodEmp]) then
        if cdsPesq.FieldByName('EMP_CRED_PIS_ENTRA').AsString = 'S' then
        begin
          Result := 'S';
          VS_strPis_Cst01 := cdsPesq.FieldByName('EMP_PIS_CST01').AsString;
          VS_strPis_Cst02 := cdsPesq.FieldByName('EMP_PIS_CST02').AsString;
          VS_strPis_Cst03 := cdsPesq.FieldByName('EMP_PIS_CST03').AsString;
          VS_strPis_Cst04 := cdsPesq.FieldByName('EMP_PIS_CST04').AsString;
          VS_strPis_Cst05 := cdsPesq.FieldByName('EMP_PIS_CST05').AsString;
        end;

      cdsPesq.Close;
    Except
      fMensagem('ATENÇÃO!', 'Por favor, entre em configurações aba Geral, e configure a situação do PIS e COFINS ' +
        '("Credita Pis Entrada"), e clique em gravar.', ['&Ok']);
    end;

    FreeAndNil(cdsPesq);
  end;
  {$ENDIF}
end;


function fRetLinGruExcluir(strLinGru: String): String;
Begin
  If Length(strLinGru) = 4 Then
  Begin
    If RightStr(strLinGru, 2) = '00' Then
      Result := 'AND NOT LEFT(ITE_CODGRU, 2) = ' + LeftStr(strLinGru, 2)
    Else
      Result := 'AND NOT ITE_CODGRU = ' + strLinGru;
  End
  Else
  Begin
    If RightStr(strLinGru, 3) = '00' Then
      Result := 'AND NOT LEFT(ITE_CODGRU, 3) = ' + LeftStr(strLinGru, 3)
    Else
      Result := 'AND NOT ITE_CODGRU = ' + strLinGru;
  End;
End;


function fSimplesNacional(strCodEmp: string): string;
  Var
    qrySP: TUniQuery;
begin
  Result := 'N';
  qrySP := TUniQuery.Create(nil);
  qrySP.Connection := fRetConexao;
  qrySP.SQL.Text := 'SELECT SIS_VALCFG FROM CFGSIS ' +
                       'WHERE SIS_CODCFG = "CFG_SIMPAU"' +
                       ' AND SIS_CODEMP = "' + VS_strCodEmp + '"';
  qrySP.Open;

  if qrySP.FieldByName('SIS_VALCFG').AsString = 'S' then
    Result := 'S';

  qrySP.Close;

  FreeAndNil(qrySP);
end;
{$IFDEF MSWINDOWS}
function fRetornaVersao(strNomArq: String = ''): String;
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
function fRetSufixoMovIcd: String;
begin
  If Not fTabelaExiste('MOVICD') Then
    Result := '_TMP'
  Else
    Result := '';
end;

function fRetContaContabilPorCfop(strCfop: String): String;
  var
    qryAux: TUniQuery;
begin
  if fEmptyStr(strCfop) then
  begin
    Result := '';
    Exit;
  end;

  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      try
        Close;
        SQL.Clear;
        SQL.Text := 'SELECT IFNULL(CFO_CONCON, "") AS CONCON FROM CADCFO WHERE CFO_CODCFO = :CFOP AND CFO_CODEMP = :CODEMP AND IFNULL(CFO_EVSPED, "N") = "S" ';

        ParamByName('CFOP').AsString := strCfop;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        Result := FieldByName('CONCON').AsString;
      except
        on E: Exception do
          Result := '';
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function fRetContaContabilPorNota(strNumDoc: String): String;
begin

//  1551, 2551
end;

function fFormataCgcCpf(strCgcCpf: String; strFormatado: boolean = False ): String;
begin

  Result := fTiraCaracEspeciais(Trim(strCgcCpf), True, True);

  if Trim(Result) = '' then
    Result := ''
  else
  begin
    if (Length(Trim(Result)) <= 11) and (Length(Trim(Result)) > 0) then
      Result := fPadZ(Result, 11)
    else if ( (Length(Trim(Result)) < 14) and (Length(Trim(Result))  > 11) ) and (Length(Trim(Result)) > 0) then
      Result := fPadZ(Result, 14);
  end;

  if strFormatado = True then
  begin
    if Length(Result) = 11 then
      Result := Copy(Result, 1, 3) + '.' + Copy(Result, 4, 3) + '.' + Copy(Result, 7, 3) + '-' + Copy(Result, 10, 2)
    else if Length(Result) = 14 then
      Result := Copy(Result, 1, 2) + '.' + Copy(Result, 3, 3) + '.' + Copy(Result, 6, 3) + '/' + Copy(Result, 9, 4) + '-' + Copy(Result, 13, 2)
    else
      Result := '';
  end;

end;

function fFormataCep(strCep: String; strSimbolo: string = '-'): String;
begin

  Result := fTiraCaracEspeciais(Trim(strCep), True, True);

  if Trim(Result) = '' then
    Result := ''
  else
  begin
    if Length(Result) < 8  then
      Result := fPadZ(Result, 8);
  end;

  if Length(strSimbolo) = 1 then
  begin
    Result := Copy(Result, 1, 5) + strSimbolo + Copy(Result, 6, 3);
  end;

end;


function Iif(lTest:Boolean; vExpr1,vExpr2:Variant):Variant;
begin
   if lTest then
     Result := vExpr1
   else
     Result := vExpr2;
end;

function fTiraEnter(strValor: string): string;
Begin
  Result := AnsiReplaceStr(strValor, #13, '');
  Result := AnsiReplaceStr(Result, #10, '');
end;

function fEmptyStr(strString : String) : Boolean;
begin
  Result := False;
  strString := AnsiReplaceStr(strString, #10, '');
  strString := AnsiReplaceStr(strString, #13, '');
  if AnsiReplaceText(strString, ' ', '') = '' then
    Result := True;
end;

function fTiraCaracEspeciais(strTexto: String;
                             blnTiraEspacos: boolean = False;
                             blnTiraPontos: boolean = False;
                             blnTiraAsterisco: boolean = False;
                             blnDeixaUnderline: boolean = False;
                             strLista: String = '';
                             blnRetiraEspacoDireita: Boolean = False;
                             blnRetiraEspacoEsquerda: Boolean = False): String;
  Var
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  if fEmptyStr(strLista) then
  begin
    if blnDeixaUnderline = False then
      strLista := '/|\-_+#,;<>():'
    else // quando se deseja manter os "_" na string
      strLista := '/|\-+#,;<>():';
  end;


  if (blnTiraEspacos = True) then
    strLista := strLista + ' ';

  if (blnTiraPontos = True) then
      strLista := strLista + '.';

  if (blnTiraAsterisco = True) then
      strLista := strLista + '*';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU'+' '+' ';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ'+#13+#10;

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    if intPosicao > 0 then
      Result := Result + strCaracNorm[intPosicao]

    else if Pos(strTexto[intContador], strLista) <= 0 then
      Result := Result + strTexto[intContador];

  end;

  If blnRetiraEspacoDireita Then
    Result := TrimRight(Result);

  If blnRetiraEspacoEsquerda Then
    Result := TrimLeft(Result);
end;

function fTiraCaracterIPI(strTexto: String): String;
  Var
    strLista: String;
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin
  strLista := '.-';

  strCaracNorm := 'aeiouaeiouaeiouaoaeiouAEIOUAEIOUAEIOUAOAEIOU';
  strCaracEsp  := 'àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    if intPosicao > 0 then
      Result := Result + strCaracNorm[intPosicao]

    else if Pos(strTexto[intContador], strLista) <= 0 then
      Result := Result + strTexto[intContador];

  end;

end;
{$IFDEF MSWINDOWS}
function fPedeEmpresa(strCodEmp: String): String;
begin

  Result := '';

  Try
    pCriarFormularios(TfrmEmpresas, frmEmpresas);

    frmEmpresas.strEmpAtu := strCodEmp;

    if frmEmpresas.ShowModal = mrOk then
    begin
      Result := frmEmpresas.strEmpAtu;
    end;

  Finally

    pFreeAndNil(frmEmpresas);

  end;

end;
{$ENDIF}
function fRetNomeEmpresaFantasia(const strCodEmp: string=''): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    qryGenEmp := TUniQuery.Create(Nil);
    qryGenEmp.Connection := fRetConexao;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_NOMFAN NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    end;

  Finally
   FreeAndNil(qryGenEmp);
  end;

end;

function fRetNomeEmpresa(const strCodEmp: string=''): String;
  Var
    strSQL   : String;
    qryGenEmp: TUniQuery;
begin
  Try
    qryGenEmp := TUniQuery.Create(Nil);
    qryGenEmp.Connection := fRetConexao;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  EMP_NOMEMP NOMEMP ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenEmp Do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
      Open;
      Result := FieldByName('NOMEMP').AsString;
      Close;
    end;

  Finally
   FreeAndNil(qryGenEmp);
  end;

end;

function fGetValorXml(nodNo: IXMLNode; strNome: String; varTipVar: TVarType = varString;
  strDateFormat: String = 'YYYY-MM-DD'; chrDateSeparator: Char = '-'; blnDateTime: Boolean = False): Variant;
  Var
    nodRec: IXMLNode;
    forSet: TFormatSettings;
    strData: String;
Begin
  With nodNo Do
  Begin
    forSet.ShortDateFormat := strDateFormat;
    forSet.DateSeparator   := chrDateSeparator;

    nodRec := ChildNodes.FindNode(strNome);

    If Assigned(nodRec) Then
    Begin

      Try
        Case varTipVar Of

          varDate  :  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0

                        Else If blnDateTime Then
                        Begin
                          strData := LeftStr(nodRec.NodeValue, 10);
                          Result  := StrToDate(strData, forSet);
                        End Else
                        Begin
                          Result  := StrToDate(nodRec.NodeValue, forSet);
                        End;

                      End;

          varString:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := ''
                        Else
                          Result := nodRec.NodeValue;
                      End;

          varDouble:  Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := fStrToFloat(AnsiReplaceStr(nodRec.NodeValue,'.',','));
                      End;

          varInteger: Begin
                        If nodRec.NodeValue = Null Then
                          Result := 0
                        Else
                          Result := nodRec.NodeValue;
                      End;

        End;
      Except
        Raise Exception.Create('Erro ao ler valor ' + strNome);
      End;

    End Else
    Begin
      Case varTipVar Of
        varDate:     Result := 0;
        varString:   Result := '';
        varDouble:   Result := 0;
        varInteger:  Result := 0;
      End;
    End;

  End;
End;

function fCriaQuery(AOwner: TComponent = Nil; Conexao: TUniConnection=Nil): TUniQuery;
Var
  LConexao: TUniConnection;
begin
  If Assigned(Conexao) Then
    LConexao := Conexao
  Else
    LConexao := frmModulo.Database;

  Result := TUniQuery.Create(AOwner);

  Result.Connection := LConexao;

  Result.Options.RequiredFields := False;

end;

function fFimDoMes(const AValue: TDateTime): TDateTime;
  Var
  LYear, LMonth, LDay: Word;
begin
  DecodeDate(AValue, LYear, LMonth, LDay);
  Result := EncodeDate(LYear, LMonth, DaysInAMonth(LYear, LMonth));
End;
{$IFDEF MSWINDOWS}
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
Function fMensagem(strTitulo: String; strTexto: String; arrOpcoes: Array Of String; intFocoBotao: Integer = 1; blnSaiComEsc: Boolean = False; intEstFon: Integer = 1): Integer;
  Var
    intQtdOpcoes : Integer;
    intPosicao   : Integer;
    fntFonte     : TFont;
begin
  intQtdOpcoes   := 0;

  fntFonte       := TFont.Create;
  fntFonte.Name  := 'charter';
  fntFonte.Size  := 13;
  //fntFonte.Style := [fsBold];

  For intPosicao := 0 To Length( arrOpcoes )-1 Do
  begin
    if arrOpcoes[intPosicao] <> '' then
      Inc(intQtdOpcoes)
    else
      Break;
  end;

  if (Length(arrOpcoes) = 2)   And
     (Trim(arrOpcoes[0]) = '') And
     (Trim(arrOpcoes[1]) = '') then
  begin
    arrOpcoes[0] := '&Sim';
    arrOpcoes[1] := '&Não';
    intQtdOpcoes := 2;
  end;

  if Trim(arrOpcoes[0]) = '' then
  begin
    fMensagem('Atenção', 'É obrigatório a passagem dos parametros em ordem!', ['OK']);
    Result := 0;
    Exit;
  end;

  {********************************}
  {* -> Define Foco para Botao    *}
  {*****************************WI*}
  if ( intFocoBotao <= 0 )           Or
     ( intFocoBotao > intQtdOpcoes ) then
    intFocoBotao := 1;

  Try

    pCriarFormularios(TfrmMensagem, frmMensagem);

    With frmMensagem Do
    begin

      if strTitulo = '' then
        strTitulo := 'AVISO';

      if intEstFon = 2 then
        lblMensagem.Font.Name := 'Courier New';

      lblTitulo.Caption   := strTitulo;
      lblMensagem.Caption := strTexto;

      if intQtdOpcoes = 1 then
      begin
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 156;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
      end
      else if intQtdOpcoes = 2 then
      begin
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 90;
          Top        := 05;
          Height     := 28;
          Width      := 130;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 222;
          Top        := 05;
          Height     := 28;
          Width      := 130;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
      end
      else if intQtdOpcoes = 3 then
      begin
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 28;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[0];
          Tag        := 1;
          Glyph      := imgbotao1.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 156;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[1];
          Tag        := 2;
          Glyph      := imgbotao2.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
        With TBitBtn.Create(frmMensagem) Do
        begin
          parent     := pnlBotoes;
          Left       := 284;
          Top        := 05;
          Height     := 28;
          Width      := 126;
          Font       := fntFonte;
          Caption    := arrOpcoes[2];
          Tag        := 3;
          Glyph      := imgbotao3.Picture.Bitmap;
          OnClick    := frmMensagem.pOnclick;
        end;
      end;
    end;

    frmMensagem.intFocus     := intFocoBotao;
    frmMensagem.blnSaiComEsc := blnSaiComEsc;
    frmMensagem.ShowModal;
    Result := frmMensagem.intRetorno;

  Except
    On E: Exception Do
    begin
      Result := 0;
      pMensagensErro(E.Message, '[fMensagem]');
    end;
  end;

  pFreeAndNil(frmMensagem);
  FreeAndNil(fntFonte);

end;

procedure pCriarFormularios(Classe: TComponentClass; Var frmForm);
  Var
    intCont: Integer;
    strMsg: String;
Begin

  {strMsg := '';

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
    Raise Exception.Create('Erro ao criar o formulário.' + #13 + strMsg);}

 strMsg := '';

  For intCont := 0 To 4 Do
  Begin

    Try
      Application.CreateForm(Classe, frmForm);
      strMsg := '';
    Except
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
end;
{$ENDIF}
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

{*******************************************}
{*   Verifica Mensagens de Erro do Banco   *}
{****************************************DV*}
procedure pMensagensErro(MensErro, LocalErro:String;strMensagem : String = '' );
  Var
    NrErro: Integer;
    strInfo: String;
begin
  fRollBack;

  NrErro := fParseError(MensErro, strInfo);

  Case NrErro Of
    ERR_UNKNOW_ERROR    :pErro(MensErro + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_UNKNOW_DATABASE :pErro(strInfo + ': Banco de dados inexistente' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ACCESS_DENIED   :pErro('Accesso negado ao usuário ' + strInfo + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_NOT_EXIST :pErro('Tabela ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_FOUND :pErro('Campo ' + strInfo + ' não Existe!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_TABLE_READONLY  :pErro('Operação não suportada no modo Somente Leitura!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_INT   :pErro(strInfo + ' não é um número inteiro válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_DATE  :pErro(strInfo + ' não é uma data válida!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_VALID_FLOAT :pErro(strInfo + ' não é um número válido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_NOT_IN_EDIT     :pErro('Tabela não está em modo de Edição!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_SQL_SYNTAX      :pErro('Há um erro de Sintaxe no SQL: ' + strInfo + #10 + 'Local: ' + #10 + LocalErro + #10 + strMensagem);
    ERR_BD_NOT_ACTIVE   :pErro('O Servidor de banco de dados não está ativo!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_FIELD_NOT_NULL  :pErro('O campo ' + strInfo + ' é de preenchimento obrigatório!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_PRIMARY_KEY     :pErro(strInfo + ': valor duplicado não permitido!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    ERR_ORDER_BY        :pErro('Coluna ' + strInfo + ' desconhecida no processo de ordenação!' + #10 + 'Local: ' + LocalErro + #10 + strMensagem);
    335544579: pErro('Erro interno' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]' );
    335544608: pErro('Esperendo o término da string SQL' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544438: pErro('Function não definida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544463: pErro('Generator não definido' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544511: pErro('Procedure não definida' + #13 + 'Local: ' + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544580: pErro('Tabela desconhecida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544581: pErro('Procedure desconhecida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544595: pErro('Trigger desconhecida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544569: pErro('A string SQL está errada' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544578: pErro('Coluna da tabela desconhecida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544617: pErro('Cláusula Order By inválida' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544334: pErro('Erro de conversão para string' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544466: pErro('Violação de integridade da chave estrangeira' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544680: pErro('Corrupção da estrutura do arquivo' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544628: pErro('Não foi possível criar o arquivo de índice' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544321: pErro('Exceção aritmética, estouro numérico ou string truncada' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544665: pErro('Violação da chave primária ou campo não pode ser duplicado' + #13 + 'Local: '  + LocalErro +  #13 + '[ ' + strMensagem + ' ]');
    335544586: pErro('Function desconhecida' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544379: pErro('ODS (On Disk Structure) não suportado' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544357: pErro('O banco não pode ser fechado, existem transações abertas' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544344: pErro('O seu arquivo de banco de dados não foi encontrado ou é inválido' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544346: pErro('Tabela de sistema corrompida' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544404: pErro('Banco de dados corrompido' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544347: pErro('O campo não pode conter valor null' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544472: pErro('Seu nome de login e senha não foram definidos' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544481: pErro('Não há mais espaço livre em disco para gravação do arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544375: pErro('O Servidor de Banco de Dados está fora do ar' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544648: pErro('A conexão com o banco de dados foi perdida' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544689: pErro('Erro do Interbase' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544704: pErro('Falha na conexão com o host' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544706: pErro('Host desconhecido' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544719: pErro('Erro ao inicializar o software da rede' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544721: pErro('O Servidor de Banco de Dados está fora do ar' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544722: pErro('Falha de comunicação' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544726: pErro('Erro de leitura do arquivo pela conexão' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544727: pErro('Erro de escrita do arquivo pela conexão' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544733: pErro('Erro na criação do arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544734: pErro('Erro ao tentar abrir o arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544735: pErro('Erro ao tentar fechar o arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544736: pErro('Erro ao tentar ler o arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544737: pErro('Erro ao tentar escrever no arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544738: pErro('Erro ao tentar deletar o arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544739: pErro('Erro ao tentar acessar o arquivo' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544741: pErro('Foi perdida a conexão com o banco de dados' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
    335544751: pErro('O protocolo da rede especificado é inválido' + #13 + 'Local: '  + LocalErro + #13 + '[ ' + strMensagem + ' ]');
  else
	  pErro( strMensagem + #13 + 'Local: '  + LocalErro );
  end;
end;

{****************************************}
{*   Exibe Mensagens de Erro do Banco   *}
{*************************************DV*}
procedure pErro(Mensagem:String);
begin

  if Trim(Mensagem) <> '' then
  begin
	  //pGravarErro(True,Mensagem);
    {$IFDEF MSWINDOWS}
    fMensagem('',Mensagem,['&Ok']);
    {$ENDIF}
  end
  else
  begin
    {$IFDEF MSWINDOWS}
	  //pGravarErro(True,'Erro desconhecido');
    fMensagem('','Erro desconhecido',['&Ok']);
    {$ENDIF}
  end;
end;
{$IFDEF MSWINDOWS}
{********************************************}
{* UMA MANEIRA DifERENTE DO FREEANDNIL PARA *}
{* LIBERAR FORMULÁRIOS DA MEMÓRIA           *}
{*****************************************AF*}
procedure pFreeAndNil(frmForm: TForm);
begin
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
end;
{$ENDIF}
function fRetChaveAtual(strSerie, strTipFc, strEspDoc, strNumero, strEmpresa, strParticipante: String): String;
begin
  Result := strSerie + strTipFc + strEspDoc + strNumero + strEmpresa + strParticipante;
end;

function fRetChaveAtualR(strSerie, strTipFc, strEspDoc, strNumero, strEmpresa, strParticipante, strCfop: String): String;
begin
  Result := strSerie + strTipFc + strEspDoc + strNumero + strEmpresa + strParticipante + strCfop;
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

  if (Pos('Unknown database', strErrorMessage) > 0) then
  begin
    Result := ERR_UNKNOW_DATABASE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1] - arrPosicoes[0]);
  end
  else if (Pos('Access denied for user', strErrorMessage) > 0) then
  begin
    Result := ERR_ACCESS_DENIED;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[1], arrPosicoes[3] - arrPosicoes[1]);
  end
  else if (Pos('Table', strErrorMessage) > 0) And (Pos('doesn'#39't exist', strErrorMessage) > 0) then
  begin
    Result := ERR_TABLE_NOT_EXIST;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Field', strErrorMessage) > 0) And (Pos('not found', strErrorMessage) > 0) then
  begin
    Result := ERR_FIELD_NOT_FOUND;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Operation is not allowed in READ ONLY mode', strErrorMessage) > 0) then
  begin
    Result := ERR_TABLE_READONLY;
  end
  else if (Pos('Cannot modify a read-only dataset', strErrorMessage) > 0) then
  begin
    Result := ERR_TABLE_READONLY;
  end
  else if (Pos('not a valid integer value', strErrorMessage) > 0) then
  begin
    Result := ERR_NOT_VALID_INT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('not a valid date', strErrorMessage) > 0) then
  begin
    Result := ERR_NOT_VALID_DATE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('not a valid floating point value', strErrorMessage) > 0) then
  begin
    Result := ERR_NOT_VALID_FLOAT;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Dataset not in edit or insert mode', strErrorMessage) > 0) then
  begin
    Result := ERR_NOT_IN_EDIT;
  end
  else if (Pos('You have an error in your SQL syntax', strErrorMessage) > 0) then
  begin
    Result := ERR_SQL_SYNTAX;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Can'#39't connect to local MySQL server through socket', strErrorMessage) > 0) then
  begin
    Result := ERR_BD_NOT_ACTIVE;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Column', strErrorMessage) > 0) And (Pos('cannot be null', strErrorMessage) > 0) then
  begin
    Result := ERR_FIELD_NOT_NULL;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Duplicate entry', strErrorMessage) > 0 ) And (Pos('for key', strErrorMessage) > 0) then
  begin
    Result := ERR_PRIMARY_KEY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else if (Pos('Unknown column', strErrorMessage) > 0) And (Pos('order clause', strErrorMessage) > 0) then
  begin
    Result := ERR_ORDER_BY;
    strInfoAdicional := Copy(strErrorMessage, arrPosicoes[0], arrPosicoes[1]+1 - arrPosicoes[0]);
  end
  else
    Result := ERR_UNKNOW_ERROR;
end;
{$IFDEF MSWINDOWS}
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
{$ENDIF}
function fPosicoes(strString: String; chrBusca: Char): TIntArray;
  Var
    intContador: Integer;
begin

  For intContador := 1 To Length(strString) Do
  begin
    if strString[intContador] = chrBusca then
    begin
      SetLength(Result, Length(Result)+1);
      Result[Length(Result)-1] := intContador;
    end
  end;

end;

{************************************}
{* TRANSFORMA STRING PARA DOUBLE    *}
{* QUANDO USAVA STRTOFLOAT EM UM    *}
{* VALOR DE MILHAR EX 1.005,23      *}
{* OCORRIA ERRO POR CAUSA DO .      *}
{*********************************AF*}
function fStrToFloat(strValor: String): Double;
begin

  Result := StrToFloatDef(AnsiReplaceStr(strValor,'.',''), 0);

end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO VIRGULA POR PONTO            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrPonto(valor: double; inte,deci: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte,deci),',','.');
end;

{*************************************************************}
{* FORMATA O NUMERICO, TROCANDO PONTO POR VIRGULA            *}
{*********************************************OUT/2009***[AM]*}
function fFloatToStrVirgula(valor: double; inte,deci: integer): string; overload;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inte, deci),'.',',');
end;

function fFloatToStrVirgula(valor: string; inte,deci: integer): string; overload;
begin
  Result := AnsiReplaceStr(FloatToStrF(StrToFloat(valor), ffFixed, inte, deci),'.',',');
end;

{************************************}
{* REMOVE A VIRGULA DE UM VALOR     *}
{* EXEMPLO: 123,45 RESULTA 12345    *}
{*********************************AF*}
function fFloatToStrTiraVirgula(valor: double; inteiro,decimal: integer): string;
begin
  Result := AnsiReplaceStr(FloatToStrF(valor, ffFixed, inteiro,decimal),',','');
end;

function fGetTipoAbfCliente(const strCodCli: String; strConsum: String=''): String;
  Var
    qryCliente: TUniQuery;
begin
  qryCliente := fCriaQuery;

  With qryCliente, SQL Do
  Begin
    Add('SELECT ');
    Add('  IF(CLI_CGCCPF = 1, "J", "F") AS FISJUR,');
    Add('  CLI_I_E_S_ AS I_E_S_,');
    Add('  CLI_CODATI AS CODATI,');
    Add('  CLI_CONSUM AS CONSUM,');
    Add('  CLI_PRORUR AS PRORUR,');
    Add('  CLI_MICEMP AS MICEMP,');
    Add('  CLI_INDUST AS INDUST,');
    Add('  CLI_REGTRI AS REGTRI ');
    Add('FROM');
    Add('  CADCLI');
    Add('WHERE');
    Add('  CLI_CODCLI = :CODCLI');

    ParamByName('CODCLI').AsString := strCodCli;

    Open;

    Result := fGetTipoAbf('C', FieldByName('FISJUR').AsString,
                               FieldByName('I_E_S_').AsString,
                               IIF(fEmptyStr(strConsum), FieldByName('CONSUM').AsString, strConsum),
                               FieldByName('CODATI').AsString,
                               FieldByName('PRORUR').AsString,
                               FieldByName('MICEMP').AsString,
                               FieldByName('REGTRI').AsString,
                               '',
                               FieldByName('INDUST').AsString,
                               IIF(Pos(strCodCli, fRetornaClienteFilial(VS_strCodEmp)) > 0, 'S', 'N'));
  End;

  FreeAndNil(qryCliente);
end;

function fGetTipoAbfFornecedor(const strCodFor: String; Var strTipFor: String): String;
  Var
    qryFornecedor: TUniQuery;
begin
  qryFornecedor := fCriaQuery;

  With qryFornecedor, SQL Do
  Begin
    Add('SELECT ');
    Add('  IF(FOR_CGCCPF = 1, "J", "F") AS FISJUR,');
    Add('  FOR_I_E_S_ AS I_E_S_,');
    Add('  FOR_SIMPAU AS SIMPAU,');
    Add('  FOR_MATREV AS TIPFOR ');
    Add('FROM');
    Add('  CADFOR ');
    Add('WHERE');
    Add('  FOR_CODFOR = :CODFOR');

    ParamByName('CODFOR').AsString := strCodFor;

    Open;

    strTipFor := FieldByName('TIPFOR').AsString;

    Result := fGetTipoAbf('F', FieldByName('FISJUR').AsString,
                               FieldByName('I_E_S_').AsString,
                               '', '', '', '',
                               FieldByName('SIMPAU').AsString,
                               FieldByName('TIPFOR').AsString,
                               '',
                               '');
  End;

  FreeAndNil(qryFornecedor);
end;

function fGetTipoAbf(strTipFC, strFisJur, strIES, strConFin, strCodAti, strProRur, strMicEmp, strRegTri, strTipFor, strIndust, strFilial: String): String;
begin
  //(F)ornecedor
  If strTipFC = 'F' Then //(F)ornecedor ou (C)liente
  Begin
    Result := '_ENT_';

    If fEmptyStr(strIES) Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'PEF' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
    Else If strTipFor = 'I' Then
      Result := Result + 'PEJ' //PEJ - PESSOA JURIDICA (INDUSTRIA)
    Else
      Result := Result + 'PER';//PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
  End
  //(C)liente
  Else
  Begin
    Result := '_SAI_';

    If strFilial = 'S' Then
      Result := Result + 'TRS'//TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS

    Else If strProRur = 'S' Then
      Result := Result + 'PRU'//PRU - PRODUTOR RURAL

    Else If strIndust = 'S' Then
      Result := Result + 'IND'//IND - SAIDA INDUSTRIA

    Else If strRegTri = 'S' Then
      Result := Result + 'SNA'//SNA - SIMPLES NACIONAL

    Else If fAtividadeConstrutora(strCodAti) Then
      Result := Result + 'CTA'//CTA - CONSTRUTORA

    Else If (fEmptyStr(strIES) And (strMicEmp <> 'S')) Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'NCO'//NCO - NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)

    Else If strConFin = 'S' Then
      Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR

    Else
      Result := Result + 'CNC';//CNC - CONTRIBUINTE NAO CONSUMIDOR
  End;
end;

function fAtividadeConstrutora(strCodAti: String): Boolean;
begin
  Result := (strCodAti <> '') And (fCampoTabela('ATI_CODATI', 'CLIATI',
    ['ATI_CODATI', 'ATI_CODEMP'], [strCodAti, VS_strCodEmp], False) = strCodAti);
end;

function fGetTipoAbfCliente_(const strCodCli: String; strConsum: String = '';
  strIndust: String = ''; strEmp_TE: String = ''): String;
  var
    sql, strCliFil: String;
    qryAuxCli: TUniQuery;
begin
  sql := ' SELECT ' +
         '   IF(CLI_CGCCPF = 1, "J", "F") AS FISJUR, ' +
         '   CLI_I_E_S_ AS I_E_S_, ' +
         '   CLI_CODATI AS CODATI, ' +
         '   CLI_CONSUM AS CONSUM, ' +
         '   CLI_PRORUR AS PRORUR, ' +
         '   CLI_MICEMP AS MICEMP, ' +
         '   CLI_INDUST AS INDUST, ' +
         '   CLI_REGTRI AS REGTRI ' +
         ' FROM ' +
         '   CADCLI ' +
         ' WHERE CLI_CODCLI = :CODCLI ';

  qryAuxCli := fCriaQuery();

  try
    qryAuxCli.Close;
    qryAuxCli.SQL.Clear;
    qryAuxCli.SQL.Text := sql;
    qryAuxCli.ParamByName('CODCLI').AsString := strCodCli;
    qryAuxCli.Open;

    strCliFil := fRetClientesFilial_;

    Result := fGetTipoAbf_('C', qryAuxCli.FieldByName('FISJUR').AsString,
                                qryAuxCli.FieldByName('I_E_S_').AsString,
                                IIF(fEmptyStr(strConsum), qryAuxCli.FieldByName('CONSUM').AsString, strConsum),
                                qryAuxCli.FieldByName('CODATI').AsString,
                                qryAuxCli.FieldByName('PRORUR').AsString,
                                qryAuxCli.FieldByName('MICEMP').AsString,
                                qryAuxCli.FieldByName('REGTRI').AsString,
                                '',
                                IIF(fEmptyStr(strIndust), qryAuxCli.FieldByName('INDUST').AsString, strIndust),
                                IIF(Pos(strCodCli, strCliFil) > 0, 'S', 'N'));

    If (Result = '_SAI_TRS') Then
    Begin
      If (qryAuxCli.FieldByName('INDUST').AsString = 'S') Then
        Result := '_SAI_IND'
      Else If (fGetTipOpeTransferencia_(IIF(fEmptyStr(strEmp_TE), VS_strCodEmp, strEmp_TE), strCodCli) = 'V') Then
        Result := '_SAI_CNC';
    End;

    qryAuxCli.Close;
  finally
    FreeAndNil(qryAuxCli);
  end;
end;

function fGetTipoAbfFornecedor_(const strCodFor: String): String;
  var
    sql: string;
    qryAuxFor: TUniQuery;
begin
  sql := ' SELECT ' +
         '   IF(FOR_CGCCPF = 1, "J", "F") AS FISJUR, ' +
         '   FOR_I_E_S_ AS I_E_S_, ' +
         '   FOR_SIMPAU AS SIMPAU, ' +
         '   FOR_MATREV AS TIPFOR, ' +
         '   FOR_CODFOR ' +
         ' FROM ' +
         '   CADFOR ' +
         ' WHERE FOR_CODFOR = :CODFOR ';

  qryAuxFor := fCriaQuery();

  try
    qryAuxFor.Close;
    qryAuxFor.SQL.Clear;
    qryAuxFor.SQL.Text := sql;
    qryAuxFor.ParamByName('CODFOR').AsString := strCodFor;
    qryAuxFor.Open;

    Result := fGetTipoAbf_('F', qryAuxFor.FieldByName('FISJUR').AsString,
                                qryAuxFor.FieldByName('I_E_S_').AsString,
                                '',
                                '',
                                '',
                                '',
                                qryAuxFor.FieldByName('SIMPAU').AsString,
                                qryAuxFor.FieldByName('TIPFOR').AsString,
                                '',
                                '');

    qryAuxFor.Close;
  finally
    FreeAndNil(qryAuxFor);
  end;
end;

function fGetTipoAbf_(strTipFC, strFisJur, strIES, strConFin, strCodAti,
  strProRur, strMicEmp, strRegTri, strTipFor, strIndust,
  strFilial: String): String;
begin
  //(F)ornecedor
  If strTipFC = 'F' Then //(F)ornecedor ou (C)liente
  Begin
    Result := '_ENT_';

    If strRegTri = 'S' Then
    Begin
      If strTipFor = 'I' Then
        Result := Result + 'PSI' //PESSOA JURIDICA (SIMPLES NACIONAL)
      Else
        Result := Result + 'PES' //PESSOA JURIDICA (SIMPLES NACIONAL)
    End
    Else If fEmptyStr(strIES) Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'PEF' //PESSOA FISICA (PF OU PJ SEM INSC. ESTADUAL)
    Else If strTipFor = 'I' Then
      Result := Result + 'PEJ' //PEJ - PESSOA JURIDICA (INDUSTRIA)
    Else
      Result := Result + 'PER';//PER - PESSOA JURIDICA (DISTRIBUICAO/REVENDA/COMERCIALIZACAO)
  End
  //(C)liente
  Else
  Begin
    Result := '_SAI_';

    If strFilial = 'S' Then
      Result := Result + 'TRS'//TRS - SAIDAS TRANSFERENCIAS ENTRE LOJAS

    Else If strProRur = 'S' Then
      Result := Result + 'PRU'//PRU - PRODUTOR RURAL

    Else If strIndust = 'S' Then
      Result := Result + 'IND'//IND - SAIDA INDUSTRIA

    Else If strRegTri = 'S' Then
      Result := Result + 'SNA'//SNA - SIMPLES NACIONAL

    Else If fAtividadeConstrutora_(strCodAti) Then
      Result := Result + 'CTA'//CTA - CONSTRUTORA

    Else If (fEmptyStr(strIES) And (strMicEmp <> 'S')) Or (strFisJur = 'F') Then//(F)isica ou (J)uridica
      Result := Result + 'NCO'//NCO - NAO CONTRIBUINTE (PF OU PJ SEM INSC. ESTADUAL)

    Else If strConFin = 'S' Then
      Result := Result + 'CCO'//CCO - CONTRIBUINTE CONSUMIDOR

    Else
      Result := Result + 'CNC';//CNC - CONTRIBUINTE NAO CONSUMIDOR
  End;
end;

function fRetClientesFilial_: String;
  Var
    intContador: Integer;
    strSQL     : String;
    qryGenerica: TUniQuery;

Begin
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

function fGetTipOpeTransferencia_(strEmpOri, strCliFil: String): String;
  Var
    qryConEmp : TUniQuery;
begin
  qryConEmp := fCriaQuery(Nil);
  Try
    With qryConEmp Do
    Begin
      SQL.Clear;
      SQL.Add(' SELECT IF(CON_TIPOPE=2, "T", "V") AS CON_TIPOPE ');
      SQL.Add('   FROM CADEMP INNER JOIN CONEMP ON CON_EMPORI = :EMPORI ');
      SQL.Add('                                AND CON_EMPDES = EMP_CODEMP ');
      SQL.Add('  WHERE EMP_CLIFIL = :CLIFIL ');
      ParamByName('EMPORI').AsString := strEmpOri;
      ParamByName('CLIFIL').AsString := strCliFil;
      Open;

      Result := FieldByName('CON_TIPOPE').AsString;

      Close;
    End;
  Finally
    FreeAndNil(qryConEmp);
  End;
end;

function fAtividadeConstrutora_(strCodAti: String): Boolean;
begin
  Result := (strCodAti <> '') And (fCampoTabela('ATI_CODATI', 'CLIATI',
    ['ATI_CODATI', 'ATI_CODEMP'], [strCodAti, VS_strCodEmp], False) = strCodAti);
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

function fAvaliaCfopNota(strCfopIni,strCfopConcat: String): string;
begin

  // SUBSTITUI O CFOP CORRENTE POR 4 ESPACOS
  AnsiReplaceStr(strCfopConcat, strCfopIni, '    ');
  // SE NAO HOUVER CFOP DifERENTE NA STRING
  if fEmptyStr(Trim(strCfopConcat)) then
    Result := ''
  else // SE HOUVER OUTRO CFOP DifERENTE DEVOLVE A STRING DAS DifERENCAS
    Result := Trim(strCfopConcat);
end;

{******************************************************************************}
{******************************************************************************}
{* ESTA FUNCAO RETORNA UMA STRING CONFORME O CFOP DE ENTRADA/SAIDA, ATRAVES   *}
{* DO CODIGO DE ABREVIACAO FISCAL CONSTANTE DO CADITE OU ITEGER               *}
{******************************************************************************}
{******************************************************************************}
{* RETORNA CST DE PIS, ASSIM COMO TAMBEM UM CARACTER ("N" OU "Z") EM          *}
{* SEQUENCIA AO CST QUE INFORMA SE OS VALORES DE PIS DEVEM SER ZERADOS (Z)    *}
{* OU DEVEM SER INFORMADOS (N)ORMALMENTE, MAIS 5 DIGITOS PARA PERCENTUAL DE   *}
{* BASE DE CALCULO "000,00" E MAIS 5 DIGITOS PARA RETORNAR A ALIQUOTA         *}
{* RESPECTIVA, TUDO A PARTIR DAS TABELAS "PISENT" E "PISSAI".                 *}
{************************************************************ DEZ/2011 *[AM] **}
function fRetornaTabIteCstPis(strCfop, strCodIte: String): string;
  Var
    qryDados: TUniQuery;
    strSQL, strCodApc: string;

begin

  if strCodIte = '' then
    Exit;
  // POSICOES DE RETORNO DO RESULT DESTA FUNCAO:
  // 1-2  = CST PIS/COFINS
  // 3-3  = ALIQUOTA "N" NORMAL OU "Z" ZERADA
  // 4-8  = PERCENTUAL DE BASE DE CALCULO DE PIS/COFINS
  // 9-13 = ALIQUOTA DE PIS/COFINS

  // inicializacao para o caso de não ter sido cadastrado na PISENT/PISSAI
  if strToInt(Copy(strCfop, 01,01)) >= 5 then
    Result := '99Z' // SAIDA
  else
    Result := '98Z'; // ENTRADA

  If Not Assigned(qryDados) Then
    qryDados := TUniQuery.Create(Nil);

  qryDados.Connection := fRetConexao;

  // SE O CLIENTE FOR SIMPLES NAO SE ENQUADRA NAS TRIBUTACOES
  If fCfgSis('SIMPAU',varString,VS_strCodEmp) = 'S' Then
  Begin
    if strToInt(Copy(strCfop, 01,01)) >= 5 then
      Result := '99Z'
    else
      Result := '98Z';
  End
  Else
  Begin

    // BUSCA CONFIGURACAO SOBRE O TIPO DE ORIGEM DO CST DE PIS/COFINS
    // 1 - CADITE  | 2 - ITEGER
    VS_strCfgTpAbfPisCofins := fCfgSis('TPABPC', varString, VS_strCodEmp);

    if VS_strCfgTpAbfPisCofins = '1' then // BUSCARA O CST DO CADITE
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  ITE_CODITE,                                          ';
      strSQL := strSQL + '  IFNULL(ITE_ABFPIS,"**") AS ITE_ABFPIS,               ';
      strSQL := strSQL + '  IFNULL(ITE_ABFCOF,"**") AS ITE_ABFCOF                ';
      strSQL := strSQL + '  FROM CADITE CI                                       ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '    (ITE_CODITE = "' + strCodIte + '")                 ';
    end
    else if VS_strCfgTpAbfPisCofins = '2' then // BUSCARA O CST DO ITEGER
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  ITE_CODEMP,                                          ';
      strSQL := strSQL + '  ITE_CODITE,                                          ';
      strSQL := strSQL + '  IFNULL(ITE_ABFPIS,"**") AS ITE_ABFPIS,               ';
      strSQL := strSQL + '  IFNULL(ITE_ABFCOF,"**") AS ITE_ABFCOF                ';
      strSQL := strSQL + '  FROM ITEGER IG                                       ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (ITE_CODEMP = "' + VS_strCodEmp + '")             ';
      strSQL := strSQL + '    AND (ITE_CODITE = "' + strCodIte + '")             ';
    end;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := strSQL;

    Try
      qryDados.Open;
    Except
    On E:EXCEPTION Do
      begin
        {$IFDEF MSWINDOWS}
        ShowMessage('Campo não definido: ' + E.Message);
        {$ENDIF}
        FreeAndNil(qryDados);
      end;
    end;

    qryDados.First;

    strCodApc := qryDados.FieldByName('ITE_ABFPIS').AsString;
    if strCodApc = '**' then
    begin
      Result := '**';
      FreeAndNil(qryDados);
      Exit;
    end;

    if strToInt(Copy(strCfop, 01,01)) < 5 then
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_CSTENT AS APC_CSTPC,                             ';
      strSQL := strSQL + '  PE.* FROM PISENT PE                                  ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (LOCATE("' + strCfop + '", APC_CFOENT) > 0)    ';
      strSQL := strSQL + '    AND (APC_CODAPC = "' + strCodApc + '")             ';
    end
    else
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_CSTSAI AS APC_CSTPC,                             ';
      strSQL := strSQL + '  PS.* FROM PISSAI PS                                  ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (LOCATE("' + strCfop + '", APC_CFOSAI) > 0)    ';
      strSQL := strSQL + '    AND (APC_CODAPC = "' + strCodApc + '")             ';
    end;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := strSQL;

    Try
      qryDados.Open;
    Except
    On E:EXCEPTION Do
      begin
        {$IFDEF MSWINDOWS}
        ShowMessage('Campo não definido: ' + E.Message);
        {$ENDIF}
        FreeAndNil(qryDados);
      end;
    end;

    if qryDados.RecordCount > 0 then
    begin
      if strToInt(Copy(strCfop, 01,01)) < 5 then
      begin
        if qryDados.FieldByName('APC_ALQENT').AsFloat > 0 then
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'N' + fFormataValor(qryDados.FieldByName('APC_BASENT').AsFloat, 005, 002) + fFormataValor(qryDados.FieldByName('APC_ALQENT').AsFloat, 005, 002)
        else
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'Z';
      end
      else
      begin
        if qryDados.FieldByName('APC_ALQSAI').AsFloat > 0 then
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'N' + fFormataValor(qryDados.FieldByName('APC_BASSAI').AsFloat, 005, 002) + fFormataValor(qryDados.FieldByName('APC_ALQSAI').AsFloat, 005, 002)
        else
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'Z';
      end;

    end

  end;

  FreeAndNil(qryDados);
end;

{******************************************************************************}
{******************************************************************************}
{* ESTA FUNCAO RETORNA UMA STRING CONFORME O CFOP DE ENTRADA/SAIDA, ATRAVES   *}
{* DO CODIGO DE ABREVIACAO FISCAL CONSTANTE DO CADITE OU ITEGER               *}
{******************************************************************************}
{******************************************************************************}
{* RETORNA CST DE COFINS, ASSIM COMO TAMBEM UM CARACTER ("N" OU "Z") EM       *}
{* SEQUENCIA AO CST QUE INFORMA SE OS VALORES DE COFINS DEVEM SER ZERADOS (Z) *}
{* OU DEVEM SER INFORMADOS (N)ORMALMENTE, MAIS 5 DIGITOS PARA PERCENTUAL DE   *}
{* BASE DE CALCULO "000,00" E MAIS 5 DIGITOS PARA RETORNAR A ALIQUOTA         *}
{* RESPECTIVA, TUDO A PARTIR DAS TABELAS "COFENT" E "COFSAI".                 *}
{************************************************************ DEZ/2011 *[AM] **}
function fRetornaTabIteCstCof(strCfop, strCodIte: String): string;
  Var
    qryDados: TUniQuery;
    strSQL, strCodApc: string;

begin

  if strCodIte = '' then
    Exit;
  // POSICOES DE RETORNO DO RESULT DESTA FUNCAO:
  // 1-2  = CST PIS/COFINS
  // 3-3  = ALIQUOTA "N" NORMAL OU "Z" ZERADA
  // 4-8  = PERCENTUAL DE BASE DE CALCULO DE PIS/COFINS
  // 9-13 = ALIQUOTA DE PIS/COFINS

  // inicializacao para o caso de não ter sido cadastrado na COFENT/COFSAI
  if strToInt(Copy(strCfop, 01,01)) >= 5 then
    Result := '99Z'
  else
    Result := '98Z';

  If Not Assigned(qryDados) Then
    qryDados := TUniQuery.Create(Nil);

  qryDados.Connection := fRetConexao;

  // SE O CLIENTE FOR SIMPLES NAO SE ENQUADRA NAS TRIBUTACOES
  If fCfgSis('SIMPAU',varString,VS_strCodEmp) = 'S' Then
  Begin
    if strToInt(Copy(strCfop, 01,01)) >= 5 then
      Result := '99Z'
    else
      Result := '98Z';
  End
  Else
  Begin

    // BUSCA CONFIGURACAO SOBRE O TIPO DE ORIGEM DO CST DE PIS/COFINS
    // 1 - CADITE  | 2 - ITEGER
    VS_strCfgTpAbfPisCofins := fCfgSis('TPABPC', varString, VS_strCodEmp);

    if VS_strCfgTpAbfPisCofins = '1' then // BUSCARA O CST DO CADITE
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  ITE_CODITE,                                          ';
      strSQL := strSQL + '  IFNULL(ITE_ABFPIS,"**") AS ITE_ABFPIS,               ';
      strSQL := strSQL + '  IFNULL(ITE_ABFCOF,"**") AS ITE_ABFCOF                ';
      strSQL := strSQL + '  FROM CADITE CI                                       ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '    (ITE_CODITE = "' + strCodIte + '")                 ';
    end
    else if VS_strCfgTpAbfPisCofins = '2' then // BUSCARA O CST DO ITEGER
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  ITE_CODEMP,                                          ';
      strSQL := strSQL + '  ITE_CODITE,                                          ';
      strSQL := strSQL + '  IFNULL(ITE_ABFPIS,"**") AS ITE_ABFPIS,               ';
      strSQL := strSQL + '  IFNULL(ITE_ABFCOF,"**") AS ITE_ABFCOF                ';
      strSQL := strSQL + '  FROM ITEGER IG                                       ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (ITE_CODEMP = "' + VS_strCodEmp + '")             ';
      strSQL := strSQL + '    AND (ITE_CODITE = "' + strCodIte + '")             ';
    end;

    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Text := strSQL;

    Try
      qryDados.Open;
    Except
    On E:EXCEPTION Do
      begin
        {$IFDEF MSWINDOWS}
        ShowMessage('Campo não definido: ' + E.Message);
        {$ENDIF}
        FreeAndNil(qryDados);
      end;
    end;


    qryDados.First;

    strCodApc := qryDados.FieldByName('ITE_ABFCOF').AsString;
    if strCodApc = '**' then
    begin
      Result := '**';
      FreeAndNil(qryDados);
      Exit;
    end;

    if strToInt(Copy(strCfop, 01,01)) < 5 then
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_CSTENT AS APC_CSTPC,                             ';
      strSQL := strSQL + '  CE.* FROM COFENT CE                                  ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (LOCATE("' + strCfop + '", APC_CFOENT) > 0)    ';
      strSQL := strSQL + '    AND (APC_CODAPC = "' + strCodApc + '")             ';
    end
    else
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_CSTSAI AS APC_CSTPC,                             ';
      strSQL := strSQL + '  CS.* FROM COFSAI CS                                  ';
      strSQL := strSQL + '  WHERE                                                ';
      strSQL := strSQL + '        (LOCATE("' + strCfop + '", APC_CFOSAI) > 0)    ';
      strSQL := strSQL + '    AND (APC_CODAPC = "' + strCodApc + '")             ';
    end;

    qryDados.SQL.Clear;
    qryDados.SQL.Text := strSQL;

    Try
      qryDados.Open;
    Except
    On E:EXCEPTION Do
      begin
        {$IFDEF MSWINDOWS}
        ShowMessage('Campo não definido: ' + E.Message);
        {$ENDIF}
        FreeAndNil(qryDados);
      end;
    end;

    if qryDados.RecordCount > 0 then
    begin
      if strToInt(Copy(strCfop, 01,01)) < 5 then
      begin
        if qryDados.FieldByName('APC_ALQENT').AsFloat > 0 then
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'N' + fFormataValor(qryDados.FieldByName('APC_BASENT').AsFloat, 005, 002) + fFormataValor(qryDados.FieldByName('APC_ALQENT').AsFloat, 005, 002)
        else
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'Z';
      end
      else
      begin
        if qryDados.FieldByName('APC_ALQSAI').AsFloat > 0 then
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'N' + fFormataValor(qryDados.FieldByName('APC_BASSAI').AsFloat, 005, 002) + fFormataValor(qryDados.FieldByName('APC_ALQSAI').AsFloat, 005, 002)
        else
          Result := qryDados.FieldByName('APC_CSTPC').AsString + 'Z';
      end;

    end

  end;

  FreeAndNil(qryDados);
end;


{******************************************************************************}
{* ESTA FUNCAO RETORNA O CST DE COFINS CONFORME O CFOP, ENTRADA/SAIDA E       *}
{* RETORNA TAMBEM UM CARACTER ("N" OU "Z") EM SEQUENCIA AO CST QUE INFORMA SE *}
{* OS VALORES DE COFINS DEVEM SER ZERADO OU DEVEM SER INFORMADOS. EM SEQUENCIA*}
{* COM 5 DIGITOS O PERCENTUAL DE BASE DE CALCULO E COM OUTROS 5 DIGITOS       *}
{* INFORMA A ALIQUOTA RESPECTIVA CONSTANTE DAS TABELAS "COFENT" E "COFSAI".   *}
{************************************************************ DEZ/2011 *[AM] **}
function fRetornaTabFisCstPisCof(strTrib, strCfop: String): string;
  Var
    qryDados: TUniQuery;
    strSQL: string;

begin
  // POSICOES DE RETORNO DO RESULT DESTA FUNCAO:
  // 1-2  = CST PIS/COFINS                                  [2]
  // 3-3  = ALIQUOTA "N" NORMAL OU "Z" ZERADA               [1]
  // 4-8  = PERCENTUAL DE BASE DE CALCULO DE PIS/COFINS     [5]
  // 9-13 = ALIQUOTA DE PIS/COFINS                          [5]

  // inicializacao para o caso de não ter sido cadastrado na PISENT/PISSAI
  if strToInt(Copy(strCfop, 01,01)) >= 5 then
    Result := '99Z'
  else
    Result := '98Z';

  qryDados := TUniQuery.Create(Nil);
  qryDados.Connection := fRetConexao;

  If fCfgSis('SIMPAU',varString,VS_strCodEmp) = 'S' Then
  Begin
    if strToInt(Copy(strCfop, 01,01)) >= 5 then
      Result := '99Z'
    else
      Result := '98Z';
  End
  Else
  Begin

    if strToInt(Copy(strCfop, 01,01)) < 5 then
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_ALQENT AS APC_ALQPC,                             ';
      strSQL := strSQL + '  APC_CSTENT AS APC_CSTPC,                             ';
      strSQL := strSQL + '  APC_BASENT AS APC_BASPC                              ';

      if strTrib = 'C' then
        strSQL := strSQL + '  FROM COFENT                                        '
      else
        strSQL := strSQL + '  FROM PISENT                                        ';

      strSQL := strSQL + '  WHERE '; //(APC_CODEMP = "' + VS_strCodEmp + '")             ';
      strSQL := strSQL + '     (LOCATE("' + strCfop + '", APC_CFOENT) > 0)    ';
    end
    else
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT                                     ';
      strSQL := strSQL + '  APC_ALQSAI AS APC_ALQPC,                             ';
      strSQL := strSQL + '  APC_CSTSAI AS APC_CSTPC,                             ';
      strSQL := strSQL + '  APC_BASSAI AS APC_BASPC                              ';

      if strTrib = 'C' then
        strSQL := strSQL + '  FROM COFSAI                                        '
      else
        strSQL := strSQL + '  FROM PISSAI                                        ';

      strSQL := strSQL + '  WHERE '; //CODEMP = "' + VS_strCodEmp + '")          ';
      strSQL := strSQL + '    (LOCATE("' + strCfop + '", APC_CFOSAI) > 0)    ';
    end;

    qryDados.SQL.Clear;
    qryDados.SQL.Text := strSQL;

    Try
      qryDados.Open;
    Except
    On E:EXCEPTION Do
      begin
        {$IFDEF MSWINDOWS}
        ShowMessage('Campo não definido: ' + E.Message);
        {$ENDIF}
      end;
    end;

    if qryDados.RecordCount > 0 then
    begin
      if qryDados.FieldByName('APC_ALQPC').AsFloat > 0 then
        Result := qryDados.FieldByName('APC_CSTPC').AsString + 'N' + fFormataValor(qryDados.FieldByName('APC_BASPC').AsFloat, 005, 002) + fFormataValor(qryDados.FieldByName('APC_ALQPC').AsFloat, 005, 002)
      else
        Result := qryDados.FieldByName('APC_CSTPC').AsString + 'Z';
    end

  end;
end;

function fStrSemAlfa(strTexto: String): String;
  Var
    intContador: Integer;
    intPosicao: Integer;
    strCaracNorm: String;
    strCaracEsp: String;
begin

  strCaracEsp  := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@|=[]/\-_+#,;<>():àèìòùáéíóúâêîôûãõäëïöüÀÈÌÒÙÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜ';
  strCaracNorm := '                                                                                                                  ';

  Result := '';
  For intContador := 1 To Length(strTexto) Do
  begin
    intPosicao := Pos(strTexto[intContador], strCaracEsp);
    if intPosicao > 0 then
      Result := Result + strCaracNorm[intPosicao]
    else
      Result := Result + strTexto[intContador];
  end;
end;
{$IFDEF MSWINDOWS}
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
  Try

    qryGenTmp := fCriaQuery;

    Try
      With qryGenTmp Do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT CURRENT_DATE, CURRENT_TIME');
        Open;
        VS_Date := FieldByName('CURRENT_DATE').AsDateTime;
        dtaHora := FieldByName('CURRENT_TIME').AsDateTime;
        VS_Time := FieldByName('CURRENT_TIME').AsDateTime;

        DecodeDate(FieldByName('CURRENT_DATE').AsDateTime, wrdAno, wrdMes, wrdDia);
        DecodeTime(dtaHora, wrdHora, wrdMinuto, wrdSegundo, wrdMilSec);
        Close;
      end;

      GetLocalTime(dtaWindows);
      dtaWindows.wYear  := wrdAno;
      dtaWindows.wMonth := wrdMes;
      dtaWindows.wDay   := wrdDia;

      dtaWindows.wHour   := wrdHora;
      dtaWindows.wMinute := wrdMinuto;
      dtaWindows.wSecond := wrdSegundo;
      dtaWindows.wMilliseconds := wrdMilSec;
      SetLocalTime(dtaWindows);

      Result := True;

    Except
      Result := False;
    end;

  Finally
   FreeAndNil(qryGenTmp);
  end;

end;
{$ENDIF}

(**********************************************************************)
(* LE O AUTOINCREMENTO DO PROCOD E DEVOLVE-O JA INCREMENTADO          *)
(******************************************************JUL/2010***[AM]*)
function fRetAutoIncrem(strNomeTabela, strCodEmp: String): String;
  Var
    strSQL: String;
    intMax: Integer;
    blnModCod: Boolean;
    strCampoEmp: String;
    intAutIncAtu: Integer;
    qryTmp: TUniQuery;
    blnInTransaction: Boolean;
begin
  If fTabelaExiste('PROINC') Then
  Begin
    Result := fRetAutoIncremProInc(strNomeTabela, strCodEmp);
    Exit;
  End;

  blnInTransaction := fInTransaction;

  if not blnInTransaction then
    fStartTransaction;

  qryTmp := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  PRO_AUTINC AS AUTINC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  PROCOD ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';
    strSQL := strSQL + ' FOR UPDATE ';

    With qryTmp Do
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
                               'na tabela de Próximos Codigos! Verifique.');
      End;

      intAutIncAtu := FieldByName('AUTINC').AsInteger;

      Close;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('Não consegui pegar o proximo sequencial. Tente novamente!');
    End;
  End;

  {*******************************************}
  {* PEGA O CAMPO DO CODIGO DA EMPRESA       *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'DESC ' + strNomeTabela;
  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;

    While (Not Eof) Do
    Begin

      If (Pos('CODEMP', Fields[0].AsString) > 0) Then
      Begin
        strCampoEmp := Fields[0].AsString;
        Break;
      End;

      Next;
    End;

    Close;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAST(LEFT(MAX(AUTOINCREM), LENGTH(AUTOINCREM)-3) AS UNSIGNED) AS MAIOR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + strNomeTabela + ' ';

  If Not fEmptyStr( strCampoEmp ) Then
  Begin
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + strCampoEmp + ' = :CODEMP ';
  End;

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr( strCampoEmp ) Then
      ParamByName('CODEMP').AsString := strCodEmp;

    Open;
    intMax := FieldByName('MAIOR').AsInteger;
    Close;
  End;

  blnModCod := False;
  If (intAutIncAtu <= intMax) Then
  Begin
    intAutIncAtu := intMax + 1;
    blnModCod    := True;
  End;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';

  If (blnModCod) Then
    strSQL := strSQL + '  PRO_AUTINC = :PROCOD + 1 '
  Else
    strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NOMARQ').AsString := strNomeTabela;
    If (blnModCod) Then
      ParamByName('PROCOD').AsInteger := intAutIncAtu;

    ExecSQL;
    Close;
  End;

  Result := fPadL(IntToStr(intAutIncAtu) + strCodEmp, 20, '0');

  if not blnInTransaction then
    fCommit;
end;

function fRetAutoIncremProInc(strNomeTabela, strCodEmp: String): String;
  Var
    intAutIncAtu: Integer;
    strSQL, strProEmp: String;
    qryGenCod: TUniQuery;
    LConn: TUniConnection;
    blnInTransaction: Boolean;

    function fAutoIncremCadastrado: Boolean;
      Var
        qryGenTmp : TUniQuery;
    begin
      qryGenTmp := fCriaQuery(Nil, LConn);
      Try
        With qryGenTmp Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM FROM ' + strNomeTabela + ' WHERE AUTOINCREM = :AUTINC LIMIT 1');
          ParamByName('AUTINC').AsString := fFormataAutInc(intAutIncAtu, strCodEmp);
          Open;
          Result := (Not IsEmpty);
          Close;
        End;

      Finally
        FreeAndNil(qryGenTmp);
      End;
    end;
begin

  blnInTransaction := fInTransaction;

  if not blnInTransaction then
    fStartTransaction;

  qryGenCod := fCriaQuery(Nil);

  Repeat

    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
      strSQL := strSQL + '  PRO_AUTINC AS AUTINC ';
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
          if not blnInTransaction then
            fRollback;

          Close;
          FreeAndNil(qryGenCod);
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Incrementos! Verifique.' + #13#10);
        End;

        strProEmp := VS_strCodEmp;

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

      If intAutIncAtu = 1 Then
        strSQL := strSQL + '  PRO_AUTINC = 2 '
      Else
        strSQL := strSQL + '  PRO_AUTINC = PRO_AUTINC + 1 ';

      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

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

    Except
      On E: Exception Do
      Begin
        if not blnInTransaction then
          fRollback;
        FreeAndNil(qryGenCod);
        Raise Exception.Create(E.message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

  Until (Not fAutoIncremCadastrado);

  FreeAndNil(qryGenCod);

  if not blnInTransaction then
    fCommit;
end;

function fFormataAutInc(intAutInc: Integer; strCodEmp: String; strProEmp: String = ''): String;
begin
  If fEmptyStr(strProEmp) Then
    strProEmp := fRetEmpresaFisica;

  Result := strProEmp + fPadL(IntToStr(intAutInc) + strCodEmp, 17, '0');
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
{* DE DELETADOS SE NÃO EXISTIR CRIA, SE EXISTIR *}
{* VERIFICA E DEPOIS GRAVA                      *}
{*********************************************AF*}
function fVerificaIntegridade(strNomFrm,
                              strTabela: String;
                              qryTabOriginal: TDataSet;
                              blnGravar: Boolean = True;
                              blnSoCriaTabela: Boolean = FALSE;
                              strMotDel: String = '';
                              strOpeDel: String = '';
                              (**************************************************************)
                              (* TABELA COMPLEMENTAR DE MOVIMENTOS (AUXMOV, AUXNOT, AUX...) *)
                              (**************************************************************)
                              blnTabAux: Boolean = False): String;
  Var
    strSQL: String;
    intContador: Integer;
    qryGenIte: TUniQuery;
    qryGenTmp: TUniQuery;
    qryGenDel: TUniQuery;
    qryGenReq: TUniQuery;
    blnTeveNf: Boolean;

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
  strOpeDel := '999';
  Try
    qryGenIte := fCriaQuery;
    qryGenTmp := fCriaQuery;
    qryGenDel := fCriaQuery;

    Result := '';
    blnTeveNf := False;

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

            If Pos(strTabela, 'MOVGER_NOTGER_FATGOR') > 0 Then
              strSQL := strSQL + ', MOTDEL VARCHAR(50) ';

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

      If Pos(strTabela, 'MOVGER_NOTGER_FATGOR') > 0 Then
        strSQL := strSQL + ', OPEDEL, DTADEL, HORDEL, MOTDEL ) VALUES ( '
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
                 (qryTabOriginal.Fields[intContador].DataType = ftMemo)   Then
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
        strSQL := strSQL + ', ' + QuotedStr(strMotDel) + ' )'
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
        {$IFDEF MSWINDOWS}
        fMensagem('ERRO', 'Ocorreu um erro durante a gravação do arquivo de deletado(s).' + #13 + E.Message + #13 +
                          'Tabela: ' + strTabela + '.', ['&Ok']);
        {$ENDIF}                  
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

function fRetNomTabAuxMov(strNomTab: String): String;
Begin
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
End;

Function fRetEmpresaFisica: String;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
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

{***************************************************************}
{* PROCEDURE QUE VERifICA SE A TABELA PASSADA COMO PARAMETRO   *}
{* ESTA CADASTRADA NA TABELA DE PROXIMOS CODIGOS, CASO NÃO     *}
{* CADASTRA AUTOMATICAMENTE USANDO OS VALORES DO VETOR PROCOD  *}
{************************************************************JC*}
procedure pValidaProCod(strNomeTabela: String);
  Var
    strSQL     : String;
    qryGenCod  : TUniQuery;
    intContador: Integer;
    blnInTransaction: Boolean;
begin
  {*****************************************************}
  {* FILTRO DE TABELAS QUE NÃO DEVEM SER VERIFICADAS   *}
  {**************************************************JC*}
  If Not ((LeftStr(strNomeTabela,2) <> 'I_')   And
          (LeftStr(strNomeTabela,3) <> 'TMP')  And
          (LeftStr(strNomeTabela,4) <> 'DEL_') And
          (Pos(strNomeTabela, 'CFGSIS_CNFCHQ_CNFETI_CNF_NF_TABNRE_SEQLOG_APGTMP') <= 0)) Then
    Exit;

  blnInTransaction := fInTransaction;
  Try
    qryGenCod := fCriaQuery(Nil);
    Try
      Try
        if not blnInTransaction then
          fstartTransaction();

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
                FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
                FieldByName('PRO_CODEMP').AsString  := fRetEmpresaFisica;
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
        if not blnInTransaction then
          fCommit();
      Except
        On E: Exception Do
        Begin
          if not blnInTransaction then
            fRollback();
          Raise;
        End;
      End;
    Finally
      FreeAndNil(qryGenCod);
    End;
  Finally

  End;
end;

function fInTransaction: Boolean;
begin
  Result := frmModulo.Database.InTransaction;
end;

{*******************************}
{* Inicia a Transação no Banco *}
{****************************MV*}
function fStartTransaction:Boolean;
begin
  Try
    If (Not frmModulo.Database.InTransaction) Then
    Begin
      frmModulo.Database.StartTransaction;
      Result := True;
    End
    Else
    Begin
	    Result := True;
    End;
  Finally

  End;
end;

{***********************}
{* Commita a Transação *}
{********************MV*}
function fCommit:Boolean;
begin
  Result := True;
  Try
	  if (frmModulo.Database.InTransaction = True) then
    begin
      frmModulo.Database.Commit;
    end;
  Except
    On E : Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[fCommit]');
    end;
  end;
end;

{***************************}
{* RollBack para Transação *}
{************************MV*}
function fRollBack:Boolean;
begin
  Result := True;
  Try
    if (frmModulo.Database.InTransaction) then
    begin
      frmModulo.Database.Rollback;
    end;
  Except
    On E : Exception do
    begin
      Result := False;
      pMensagensErro(E.Message, '[fRollBack]');
    end;
  end;
end;

{***************}
{* Abre Tabela *}
{************DV*}
function fAbrirTabela(NomeTabela:TDataSet):Boolean;
begin
  Try
	  if NomeTabela.Active = False then
      NomeTabela.Open;

	  Result := True;
  Except
	  On E : Exception do
	  begin
		  Result := False;
		  pMensagensErro(E.Message, '[fAbrirTabela]');
	  end;
  end;
end;

{*****************}
{* Fechar Tabela *}
{**************DV*}
function fFecharTabela(NomeTabela:TDataSet):Boolean;
begin
  Try
	  if NomeTabela.Active = True then NomeTabela.Close;
	  Result := True;
  Except
	  On E : Exception do
	  begin
		  Result := False;
		  pMensagensErro(E.Message, '[fFecharTabela]');
	  end;
  end;
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
{$IFDEF MSWINDOWS}
{*************************************************}
{* Habilita/Desabilita Edits da Tela de Cadastro *}
{**********************************************DV*}
procedure pEnabled(NomeForm:TForm;Habilitar:Boolean);
	var
    intContador: Integer;
begin
  For intContador := 0 to (NomeForm.ComponentCount - 1) do
  begin

  	if NomeForm.Components[intContador] is TCustomEdit then
    	if TCustomEdit(NomeForm.Components[intContador]).TabStop then
		    TCustomEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TCustomComboBox then
    	if TCustomComboBox(NomeForm.Components[intContador]).TabStop then
	    	TCustomComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TDbLookUpControl then
    	if TDbLookUpControl(NomeForm.Components[intContador]).TabStop then
	    	TDbLookUpControl(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TDbRadioGroup then
      if TDbRadioGroup(NomeForm.Components[intContador]).TabStop then
    	  TDbRadioGroup(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TDbCheckBox then
    	if TDbCheckBox(NomeForm.Components[intContador]).TabStop then
	    	TDbCheckBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TDBLookupComboBox then
    	if TDBLookupComboBox(NomeForm.Components[intContador]).TabStop then
	    	TDBLookupComboBox(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TMaskEdit then
    	if TMaskEdit(NomeForm.Components[intContador]).TabStop then
	    	TMaskEdit(NomeForm.Components[intContador]).Enabled := Habilitar;

    if NomeForm.Components[intContador] is TcxDBMaskEdit then
    	if TcxDBMaskEdit(NomeForm.Components[intContador]).TabStop then
	    	TcxDBMaskEdit(NomeForm.Components[intContador]).Enabled := Habilitar;
	end;
end;

{**************************************************}
{* Habilita/Desabilita Botoes da Tela de Cadastro *}
{***********************************************DV*}
procedure pSetButton(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar,btnLocalizar,btnSair:TBitBtn);
begin
    if btnNovo.Tag <> 88 then
      btnNovo.Enabled      := (NomeTabela.State = dsBrowse);

    if btnConfirma.Tag <> 88 then
      btnConfirma.Enabled  := (NomeTabela.State in [dsInsert, dsEdit]);

    if btnExclui.Tag <> 88 then
      btnExclui.Enabled    := (NomeTabela.State = dsBrowse);

    if btnCancela.Tag <> 88 then
      btnCancela.Enabled   := (NomeTabela.State in [dsInsert, dsEdit]);

    if btnEditar.Tag <> 88 then
      btnEditar.Enabled    := (NomeTabela.State = dsBrowse);

    if btnLocalizar.Tag <> 88 then
      btnLocalizar.Enabled := (NomeTabela.State = dsBrowse);

    if btnSair.Tag <> 88 then
      btnSair.Enabled      := (NomeTabela.State = dsBrowse);
end;
{$ENDIF}
{*****************************************************}
{* VERIFICA SE TABELA ESTA USANDO CODIGO AUTOMATICO  *}
{**************************************************MV*}
function fUsaProCodigo(strNomeTabela: String): Boolean;
  Var
    strSQL: String;
    qryGenAut: TUniQuery;
begin
  qryGenAut := fCriaQuery;
  Try
    pValidaProCod(strNomeTabela);

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
{$IFDEF MSWINDOWS}
procedure pSetFocus(SenderUnico: TWinControl; Form: TCustomForm = nil);
begin
  If Not Assigned(SenderUnico) Then Exit;

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
{*******************************************}
{* CRIA UM CLIENTDATASET COM A MESMA ESTRU-*}
{* TURA DE UM TDATASET...                  *}
{****************************************JC*}
{* COM ALTERAÇÕES SOBRE O ORIGINAL DE JC   *}
{****************************************AM*}
procedure pCriaClientDataSet(qryOrigem: TDataSet; Var cdsDados: TClientDataSet; blnCriarCDS: boolean = True; blnInsereRegistros: Boolean = False);
  Var
    intCampo : Integer;
begin

  if blnCriarCDS then
  begin
    cdsDados := TClientDataSet.Create(Nil);
  end
  else
  begin
    cdsDados.FieldDefs.Clear;
  end;

  For intCampo := 0 To qryOrigem.Fields.Count -1 Do
  begin
    With cdsDados.FieldDefs.AddFieldDef Do
    begin
      Name          := qryOrigem.Fields[intCampo].FieldName;
      DataType      := qryOrigem.Fields[intCampo].DataType;
      Size          := qryOrigem.Fields[intCampo].Size;
    end;
  end;

  cdsDados.CreateDataSet;

  For intCampo := 0 To qryOrigem.Fields.Count -1 Do
  begin
    cdsDados.Fields[intCampo].ProviderFlags := qryOrigem.Fields[intCampo].ProviderFlags;
  end;

  if blnInsereRegistros then
  begin
    With qryOrigem Do
    begin
      First;
      While Not Eof Do
      begin
        cdsDados.Append;

        For IntCampo := 0 To Fields.Count -1 Do
          cdsDados.Fields[IntCampo].Value := Fields[IntCampo].Value;

        cdsDados.Post;
        Next;
      end;
    end;
  end;
end;

function fFormataValor(fltValor: Double;
  intTamanho: Integer; intDecimais: Integer): String;
begin
  Result := AnsiReplaceStr(AnsiReplaceStr(Format('%' + IntToStr(intTamanho + 1) + '.' + IntToStr(intDecimais) + 'f', [fltValor]), ',', ''), ' ', '0');
end;

{**********************************************************}
{* VETOR CONTendO TABELAS PARA CADASTRO PROCOD AUTOMATICO *}
{* PS: VER FUNCAO "fValidaProcod"                         *}
{*******************************************************JC*}
procedure pVerificaProCod;
  Var
    intPosMat: Integer;

    function fSoma(Var intVal: Integer; intSoma: Integer = 1): Integer;
    begin
      intVal := intVal + intSoma;
      Result := intVal + 1;
    end;
begin
  intPosMat := 0;
  SetLength(arrProCod, 1);

  arrProCod[intPosMat].strNomArq := 'CADRDZ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADECF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVICM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADGNR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'RDZTOT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONLGS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'FPGCON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADHIS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDEF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADOCR';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'AJDIFL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'REFCCQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADFUL';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADDOC';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CFOPLA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CSTPLA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOTISF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PLACON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'HISCOM';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;

  arrProCod[intPosMat].strNomArq := 'CFGCON';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CONREF';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADAJD';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADPRA';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'PESCTE';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_42_DADOS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CAT_42_SALDOS';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVADJ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MOVEMT';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CREDST';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CADENQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'DESENQ';
  arrProCod[intPosMat].strCodSeq := '000001';
  arrProCod[intPosMat].intTamCod := 6;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MNUACE_AUTSI';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'MNUFAV_AUTSI';
  arrProCod[intPosMat].strCodSeq := '1';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'S';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'LOGACE';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;
  SetLength(arrProCod, fSoma(intPosMat));

  arrProCod[intPosMat].strNomArq := 'CRECAT';
  arrProCod[intPosMat].strCodSeq := '00000000000000000001';
  arrProCod[intPosMat].intTamCod := 20;
  arrProCod[intPosMat].strCodAut := 'N';
  arrProCod[intPosMat].intAutInc := 1;

  SetLength(arrProCod, fSoma(intPosMat));


end;

function fValidaDatas(strData: String): Boolean;
  Var
    dtaData: TDateTime;
begin
  Result := TryStrToDate(strData, dtaData);
end;


function fCfgSis(strCamCfg: String;  varTipVar: TVarType = varString; strCodEmp: String = ''): Variant;
  Var
    qryGenCfg: TUniQuery;
begin
  Try
    if Not fEmptyStr(strCamCfg) then
    begin
      qryGenCfg := fCriaQuery;

      With qryGenCfg Do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT         ');
        SQL.Add('  SIS_VALCFG               ');
        SQL.Add('FROM                       ');
        SQL.Add('  CFGSIS                   ');
        SQL.Add('WHERE                      ');
        SQL.Add('  SIS_CODEMP = :CODEMP AND ');
        SQL.Add('  SIS_CODCFG = :CODCFG     ');

        if fEmptyStr(strCodEmp) then
          ParamByName('CODEMP').Value := VS_strCodEmp
        else
          ParamByName('CODEMP').Value := strCodEmp;

        ParamByName('CODCFG').Value := 'CFG_' + strCamCfg;
        Open;

        if IsEmpty then
          Raise Exception.Create('A configuração ( ' + 'CFG_' + strCamCfg + ' ) não existe.');

        Case varTipVar Of
          varString : Result := FieldByName('SIS_VALCFG').AsString;

          varInteger, varSmallint, varSingle, varByte, varShortInt, varInt64:
                      begin
                        Try
                          if fEmptyStr(FieldByName('SIS_VALCFG').AsString) then
                            Result := 0
                          else
                            Result := FieldByName('SIS_VALCFG').AsInteger;
                        Except
                          Result := 0;
                        end;
                      end;

          varDouble, varCurrency:
                      begin
                        Try
                          if fEmptyStr(FieldByName('SIS_VALCFG').AsString) then
                            Result := 0.00
                          else
                            Result := fStrToFloat(AnsiReplaceStr(FieldByName('SIS_VALCFG').AsString,'.',','));
                        Except
                          Result := 0.00;
                        end;
                      end;

          varDate:
                      begin
                        Try
                          if fEmptyStr(FieldByName('SIS_VALCFG').AsString) then
                            Result := 0
                          else
                            Result := FieldByName('SIS_VALCFG').AsDateTime;
                        Except
                          Result := 0;
                        end;
                     end;

          varBoolean:
                     begin
                       Try
                         if fEmptyStr(FieldByName('SIS_VALCFG').AsString) then
                           Result := False
                         else if Pos(FieldByName('SIS_VALCFG').AsString, 'S_N_') > 0 then
                           Result := StrToBool(ifthen(FieldByName('SIS_VALCFG').AsString = 'S', 'True', 'False'))

                         else if Pos(FieldByName('SIS_VALCFG').AsString, '0_1_') > 0  then
                           Result := StrToBool(ifthen(FieldByName('SIS_VALCFG').AsString = '1', 'True', 'False'))
                         else
                           Result := FieldByName('SIS_VALCFG').AsBoolean;

                       Except
                         Result := False;
                       end;

                     end;



          else
            Result := FieldByName('SIS_VALCFG').asVariant;

        end;

      end;

    end;

  Finally
    FreeAndNil(qryGenCfg);
  end;

end;

function fCfgSpd(strCamCfg: String): String;
var
  qryCfgSpd: TUniQuery;
begin
  try
    qryCfgSpd := fCriaQuery;
    qryCfgSpd.Close;
    qryCfgSpd.SQL.Clear;
    qryCfgSpd.SQL.Add('SELECT SPD_VALCFG FROM CFGSPD WHERE SPD_CODCFG = :CODCFG AND SPD_CODEMP = :CODEMP');
    qryCfgSpd.ParamByName('CODCFG').AsString := strCamCfg;
    qryCfgSpd.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgSpd.Open;
    if not qryCfgSpd.IsEmpty then
      Result := qryCfgSpd.FieldByName('SPD_VALCFG').AsString
    else
      Result := '';
  finally
    FreeAndNil(qryCfgSpd);
  end;
end;

function fTransform(strConteudo: String; intStep: Shortint; strChar: String = '_'): String;
  Var
    strAux       : String;
    intPosicao   : Integer;
begin
  strAux := '';

  intPosicao := 1;
  While intPosicao < Length(strConteudo) Do
  begin
    strAux := strAux + Copy(strConteudo, intPosicao, intStep) + strChar;
    Inc(intPosicao, intStep);
  end;

  Result := strAux;
end;

{*****************************************}
{* VALIDA A INSCRIÇÃO ESTADUAL           *}
{**************************************MV*}

function fValidaIES(strIES, strEstado: String): Boolean;
  Var
    intContador : Integer;
    intValG     : Integer;
    intVSom     : Integer;
    intVRes     : Integer;
    intVPro     : Integer;
    intP        : Integer;
    intD        : Integer;
    intN        : Integer;
    intMod      : Integer;
    strVDig1    : String;
    strVDig2    : String;
    strVBase    : String;
    strVBase2   : String;
    strBase     : String;
    strOrigem   : String;
    strMascara  : String;
    strVSom     : String;
    arrVMul     : Array Of Integer;
begin
  strVBase   := '';
  strBase    := '';
  strOrigem  := '';
  strMascara := '99999999999999';

  intP := 0;
  intD := 0;
  Result := False;
  If fEmptyStr(strIES) Then
  Begin
    Result := True;
    Exit;
  End;

  If strEstado = 'EX' Then
  Begin
    Result := True;
    Exit;
  End;

  For intContador := 1 To Length(Trim(strIES)) Do
  Begin
    If Pos(strIES[intContador], '0123456789P') > 0 Then
      strOrigem := strOrigem + strIES[intContador];
  End;

  If (strEstado <> 'SP') And (LeftStr(strOrigem, 1) = 'P') Then
  Begin
    Result := TRUE;
    Exit;
  End;

  If strEstado = 'AC' Then
  Begin
    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 10 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := LeftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador+1],0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes   := intVSom Mod 11;
    strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
    strVBase2 := strVBase2 + strVDig2;
    //Result := (strVBase2 = strOrigem);
    Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
  End
  Else If strEstado = 'AL' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes = 10, 0, intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'AM' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador],0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    If intVSom < 11 Then
      strVDig1 := IntToStr(11 - intVSom)
    Else
    Begin
      intVRes := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11-intVRes));
    End;

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'AP' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '03' Then
    Begin
      intN := StrToIntDef(LeftStr(strBase, 8),0);
      If (intN >= 3000001) And (intN <= 3017000) Then
      Begin
        intP := 5;
        intD := 0;
      End
      Else If (intN >= 3017001) And (intN <= 3019022) Then
      Begin
        intP := 9;
        intD := 1;
      End
      Else If intN >= 3019023 Then
      Begin
         intP := 0;
        intD := 0;
      End;

      intVSom := intP;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador],0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1,0) = 10 Then
        strVDig1 := '0'
      Else If StrToIntDef(strVDig1,0) = 11 Then
        strVDig1 := IntToStr(intD);

      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result := (strVBase = strOrigem);
    End;

  End

  Else If strEstado = 'BA' Then
  Begin
    If Length(strOrigem) = 8 Then // 8 Digitos
    Begin
      strMascara := '999999-99';
      strBase    := fPadR(strOrigem, 9, '0');

      intVSom := 0;
      If Pos(strBase[1], '0123458') > 0 Then
      Begin
        For intContador := 1 To 6 Do
        Begin
          intValG := StrTointDef(strBase[intContador],0);
          intValG := intValG * (8 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes   := intVSom Mod 10;
        strVDig2  := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
        strVBase2 := LeftStr(strBase, 6) + strVDig2;

        intVSom := 0;

        For intContador := 1 To 7 Do
        Begin
          intValG := StrToIntDef(strVBase2[intContador],0);
          intValG := intValG * (9 - intContador);
          intVSom := intVsom + intValG;
        End;

        intVRes  := intVSom Mod 10;
        strVDig1 := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));
      End
      Else
      Begin
        For intContador := 1 To 6 Do
        Begin
          intValG := StrToIntDef(strBase[intContador], 0);
          intValG := intValG * (8 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes   := intVSom Mod 11;
        strVDig2  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
        strVBase2 := LeftStr(strBase, 6) + strVDig2;

        intVSom := 0;

        For intContador := 1 To 7 Do
        Begin
          intValG := StrToIntDef(strVBase2[intContador], 0);
          intValG := intValG * (9 - intContador);
          intVSom := intVSom + intValG;
        End;

        intVRes  := intVSom Mod 11;
        strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      End;

      strVBase2 := LeftStr(strBase, 6) + strVDig1 + strVDig2;
      Result    := (strVBase2 = strOrigem);
    End

    Else If Length(strOrigem) = 9 Then // 9 Digitos
    Begin
      strMascara := '999999-99';
      strBase    := fPadR(strOrigem, 9, '0');

      intVSom := 0;

      intMod := IIF(CharInSet(strBase[2], ['6','7','9']), 11, 10);

      For intContador := 1 To 7 Do
      Begin
        intValG := StrTointDef(strBase[intContador],0);
        intValG := intValG * (8 - (intContador - 1));
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod intMod;
      strVDig2  := IntToStr(IIF(intVRes = 0, 0, intMod - intVRes));
      strVBase2 := LeftStr(strBase, 7) + strVDig2;

      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador],0);
        intValG := intValG * (9 - (intContador - 1));
        intVSom := intVsom + intValG;
      End;

      intVRes  := intVSom Mod intMod;
      strVDig1 := IntToStr(IIF(intVRes = 0, 0, 10 - intVRes));

      strVBase2 := LeftStr(strBase, 7) + strVDig1 + strVDig2;

      Result    := (strVBase2 = strOrigem);
    End;

  End

  Else If strEstado = 'CE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'DF' Then
  Begin

    strMascara := '999,99999,999-99';
    strBase    := fPadR(strOrigem, 13, '0');

    If LeftStr(strBase, 2) = '07' Then
    Begin
      intVSom := 0;
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([4,3,2,9,8,7,6,5,4,3,2]);
      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := LeftStr(strBase, 11) + strVDig1;

      intVSom := 0;
      SetLength(arrVMul, 0);
      SetLength(arrVMul, 12);
      arrVMul := VarArrayOf([5,4,3,2,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 11 Do
      Begin
        intValG := StrToIntDef(strVBase2[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig2  := IntToStr(IIF(11 - intVRes < 10, 11 - intVRes, 0));
      strVBase2 := strVBase2 + strVDig2;
      //Result := (strVBase2 = strOrigem);
      Result := (strVDig1 = Copy(strBase, 12, 1)) And (strVDig2 = Copy(strBase, 13, 1));
    End;
  End
  Else If strEstado = 'ES' Then
  Begin
    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVsom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);
  End
  Else If strEstado = 'GO' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If Pos(LeftStr(strBase, 2), '10.11.15') > 0 Then
    Begin
      intVSom := 0;
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := Low(arrVMul) To High(arrVMul) Do
      Begin
        intVSom := intVSom + (StrToIntDef(strBase[intContador+1], 0) * arrVMul[intContador]);
      End;

      intVRes := intVSom Mod 11;

      //Quando a inscrição for 11094402 o dígito verificador pode ser zero (0) e pode ser um (1);
      If (LeftStr(strBase, 8) = '11094402') Then
      Begin
        If (Pos(RightStr(strBase, 1), '01') > 0) Then
          Result := True
        Else
          Result := False;

        Exit;
      End
      Else If (intVRes = 0) Then
      BEgin
        strVDig1 := '0'
      End
      Else If (intVRes = 1) Then
      Begin

        intN := StrToIntDef(LeftStr(strBase, 8), 0);
        strVDig1 := IIF((intN >= 10103105) And (intN <= 10119997), 1, 0);

      End
      Else
      Begin
        strVDig1 := IntToStr(11 - intVRes);
      End;

{      For intContador := 1 To 8 Do
      Begin
        intValG := StrToInt(strBase[intContador]);
        intValG := intValG + (10 * intContador);
        intVsom := intVSom + intValG;
      End;

      intVRes := intVSom Mod 11;

      If intVRes = 0 Then
        strVDig1 := '0'
      Else If intVRes = 1 Then
      Begin
        intN     := StrToInt(LeftStr(strBase, 8));
        strVDig1 := IIF((intN >= 10103105) And (intN <= 10119997), 1, 0);
      End
      Else
        strVDig1 := IntToStr(11 - intVRes);}

      strVBase := LeftStr(strBase, 8) + strVDIg1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MA' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '12' Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes   := intVSom Mod 11;
      strVDig1  := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase  := LeftStr(strBase, 8) + strVDig1;
      Result    := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MT' Then
  Begin

    {strMascara := '9999999999-9';
    strBase    := fPadR(strOrigem, 10, '0');
    intVSom    := 0;
    SetLength(arrVMul, 10);
    arrVMul := VarArrayOf([3,2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 9 Do
    Begin
      intValG := StrToInt(strBase[intContador+1]);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToInt(strVDig1) > 9 Then
      strVDig1 := IntToStr(StrToInt(strVDig1) - 10);

    strVBase := LeftStr(strBase, 10) + strVDig1;
    Result   := (strVBase = strOrigem);}

    strMascara := '999999999';
    strBase := fPadR(strOrigem, 9, '0');+    intVSom := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRES < 2, 0, 11 - intVRes));
    strVBase2 := LeftStr(strBase, 8) + strVDig1;

    Result := (strVBase2 = strOrigem);

  End
  Else If strEstado = 'MS' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');

    If (LeftStr(strBase, 2) = '28') Or (LeftStr(strBase, 2) = '50') Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'MG' Then
  Begin

    strMascara := '999,999,999/9999';
    strBase    := fPadR(strOrigem, 13, '0');
    strVBase2  := LeftStr(strBase, 3) + '0' + Copy(strBase, 4, 8);
    intN       := 2;
    strVSom    := '';

    For intContador := 1 To 12 Do
    Begin
      intValG := StrToIntDef(strVBase2[intContador], 0);
      intN    := IIF(intN = 2, 1, 2);
      intValG := intValG * intN;
      strVSom := strVSom + IntToStr(intValG);
    End;

    intN := 0;
    For intContador := 1 To Length(strVSom) Do
      intN := intN + StrToIntDef(strVSom[intContador],0);

    intVSom := intN;
    While RightStr(IntToStr(intN), 1) <> '0' Do
    Begin
      Inc(intN);
    End;

    strVDig1 := IntToStr(intN - intVSom);
    strVBase := leftStr(strBase, 11) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 12);
    arrVMul := VarArrayOf([3,2,11,10,9,8,7,6,5,4,3,2]);
    For intContador := 0 To 11 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVDig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PA' Then
  Begin

    strMascara := '99-999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If (LeftStr(strBase, 2) = '15') Or (LeftStr(strBase, 2) = '75') Then
    Begin
      intVSom := 0;

      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;

  End
  Else If strEstado = 'PB' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PE' Then
  Begin

    // VALIDAÇÃO DA INSCRICAO ESTADUAL ANTIGA - 14 dígitos
    If length(strIES) > 9 Then
    Begin
      strMascara := '99,9,999,9999999-9';
      strBase    := fPadR(strOrigem, 14, '0');
      intVSom    := 0;
      Setlength(arrVMul, 13);
      arrVMul := VarArrayOf([5,4,3,2,1,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 12 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(11 - intVRes);

      If StrToIntDef(strVDig1, 0) > 9 Then
        strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

      strVBase := LeftStr(strBase, 13) + strVdig1;
      Result := (strVBase = strOrigem);
    End
    Else
    // VALIDAÇÃO DA INSCRICAO ESTADUAL NOVA - 9 dígitos
    Begin
      strMascara := '9999999-99';
      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 7);
      arrVMul := VarArrayOf([8,7,6,5,4,3,2]);

      For intContador := 0 To 6 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig1 := '0'
      Else
        strVDig1 := IntToStr(11 - intVRes);

      strBase    := fPadR(strOrigem, 9, '0');
      intVSom    := 0;
      Setlength(arrVMul, 8);
      arrVMul := VarArrayOf([9,8,7,6,5,4,3,2]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;

      If (intVRes = 1) Or (intVRes = 0) Then
        strVDig2 := '0'
      Else
        strVDig2 := IntToStr(11 - intVRes);

      strVBase := LeftStr(strBase, 7) + strVDig1 + strVDig2;
      Result := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'PI' Then
  Begin

    strMascara := '999999999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'PR' Then
  Begin

    strMascara := '999,99999-99';
    strBase    := fPadR(strOrigem, 10, '0');
    intVSom    := 0;
    SetLength(arrVMul, 8);
    arrVMul := VarArrayOf([3,2,7,6,5,4,3,2]);

    For intContador := 0 To 7 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;

    intVSom := 0;
    SetLength(arrVMul, 0);
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([4,3,2,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strVBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig2 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := strVBase + strVdig2;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RJ' Then
  Begin

    strMascara := '99,999,99-9';
    strBase    := fPadR(strOrigem, 8, '0');
    intVSom    := 0;
    SetLength(arrVMul, 7);
    arrVMul := VarArrayOf([2,7,6,5,4,3,2]);

    For intContador := 0 To 6 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom  := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 7) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'RN' Then
  Begin

    strMascara := '99,999,999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '20' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;
      intVPro  := intVSom * 10;
      intVRes  := intVPro Mod 11;
      strVDig1 := IntToStr(IIF(intVRes > 9, 0, intVres));
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;
  End
  Else If strEstado = 'RO' Then
  Begin

    strMascara := '9999999999999-9';
    strBase    := fPadR(strOrigem, 14, '0');
    intVSom    := 0;
    arrVMul := VarArrayOf([6,5,4,3,2,9,8,7,6,5,4,3,2]);

    For intContador := Low(arrVMul) To High(arrVMul) Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := IntToStr(StrToIntDef(strVDig1, 0) - 10);

    strVBase := LeftStr(strBase, 13) + strVDig1;
    Result   := (strVbase = strOrigem);

  End
  Else If strEstado = 'RR' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');

    If LeftStr(strBase, 2) = '24' Then
    Begin
      intVSom := 0;
      For intContador := 1 To 8 Do
      Begin
        intValG := StrToIntDef(strBase[intContador], 0);
        intValG := intValG * intContador;
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 9;
      strVDig1 := IntToStr(intVRes);
      strVBase := LeftStr(strBase, 8) + strVDig1;
      Result   := (strVBase = strOrigem);

    End;

  End
  Else If strEstado = 'RS' Then
  Begin

    strMascara := '999/999999-9';
    strBase    := fPadL(strOrigem, 10, '0');

    intVSom := 0;
    SetLength(arrVMul, 9);
    arrVMul := VarArrayOf([2,9,8,7,6,5,4,3,2]);

    For intContador := 0 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador+1], 0);
      intValG := intValG * arrVMul[intContador];
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);

    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 9) + strVDig1;
    Result   := (strVBase = fPadL(strOrigem, 10, '0'));

  End
  Else If strEstado = 'SC' Then
  Begin

    strMascara := '999,999,999';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SE' Then
  Begin

    strMascara := '99999999-9';
    strBase    := fPadR(strOrigem, 9, '0');
    intVSom    := 0;

    For intContador := 1 To 8 Do
    Begin
      intValG := StrToIntDef(strBase[intContador], 0);
      intValG := intValG * (10 - intContador);
      intVSom := intVSom + intValG;
    End;

    intVRes  := intVSom Mod 11;
    strVDig1 := IntToStr(11 - intVRes);
    If StrToIntDef(strVDig1, 0) > 9 Then
      strVDig1 := '0';

    strVBase := LeftStr(strBase, 8) + strVDig1;
    Result   := (strVBase = strOrigem);

  End
  Else If strEstado = 'SP' Then
  Begin

    intVSom := 0;
    If LeftStr(strOrigem, 1) = 'P' Then
    Begin
      strMascara := 'P-99999999,9/999';
      strBase    := fPadR(strOrigem, 13, '0');
      strVBase   := Copy(strBase, 2, 8);
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 9) + strVDig1 + Copy(strBase, 11, 3);
    End
    Else
    Begin
      strMascara := '999,999,999,999';
      strBase    := fPadR(strOrigem, 12, '0');
      SetLength(arrVMul, 8);
      arrVMul := VarArrayOf([1,3,4,5,6,7,8,10]);

      For intContador := 0 To 7 Do
      Begin
        intValG := StrToIntDef(strBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := RightStr(IntToStr(intVRes), 1);
      strVBase := LeftStr(strBase, 8) + strVDig1 + Copy(strBase, 10,2);
      intVSom  := 0;
      SetLength(arrVMul, 11);
      arrVMul  := VarArrayOf([3,2,10,9,8,7,6,5,4,3,2]);

      For intContador := 0 To 10 Do
      Begin
        intValG := StrToIntDef(strVBase[intContador+1], 0);
        intValG := intValG * arrVMul[intContador];
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig2 := RightStr(IntToStr(intVRes), 1);
      strVBase := strVBase + strVDig2;

    End;
    Result := (strVBase = strOrigem);

  End
  Else If strEstado = 'TO' Then
  Begin

    strMascara := '99 999999 9';
    strBase    := fPadR(strOrigem, 09, '0');

    intVSom := 0;
    For intContador := 9 DownTo 2 Do
    Begin
      intVSom := intVSom + (StrToIntDef(strBase[10-intContador], 0) * intContador);
    End;
    intVRes := intVSom Mod 11;

    If intVRes < 2 Then
      strVDig1 := '0'
    Else
      strVDig1 := IntToStr(11 - intVRes);

    Result := (RightStr(strBase, 1) = strVDig1)

{    If Pos(Copy(strBase, 3, 2), '01.02.03.99') > 0 Then
    Begin
      strVBase := LeftStr(strBase, 2) + Copy(strBase, 5, 6);
      intVSom  := 0;


      For intContador := 1 To 8 Do
      Begin
        intValG := StrToInt(strVBase[intContador]);
        intValG := intValG * (10 - intContador);
        intVSom := intVSom + intValG;
      End;

      intVRes  := intVSom Mod 11;
      strVDig1 := IntToStr(IIF(intVRes < 2, 0, 11 - intVRes));
      strVBase := LeftStr(strBase, 10) + strVDig1;
      Result   := (strVBase = strOrigem);
    End;}
  End
  Else
  Begin
    {$IFDEF MSWINDOWS}
    fMensagem('AVISO', 'Unidade Federal Inválida: ' + strEstado + '.', ['&Ok']);      
    {$ENDIF}
  End;

end;

{******************************************************************************}
{* FORMATA A INSCRICAO ESTADUAL PARA FORMATO DE CADA ESTADO                   *}
{*******************************************************MAR/2010**[AM]*********}
function fRetornaIESformatada(strIES, strEstado: String): string;
  var strMask: string;
begin
  strIES := fTiraCaracEspeciais(strIES,True,True);

  Result := '';

  if fEmptyStr(strEstado) then
  begin
    {$IFDEF MSWINDOWS}
    ShowMessage('Não foi informado o estado da Inscrição !');
    {$ENDIF}
    Result := '';
    Exit;
  end;

  if strEstado = 'AC' then
  begin
    strMask := '999.99999.999-99;0;_';
  end
  else if strEstado = 'AL' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'AM' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'AP' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'BA' then
  begin
    strMask := '999999-99;0;_';
  end
  else if strEstado = 'CE' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'DF' then
  begin
    strMask := '999.99999.999-99;0;_';
  end
  else if strEstado = 'ES' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'GO' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'MA' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MT' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MS' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'MG' then
  begin
    strMask := '999.999.999/9999;0;_';
  end
  else if strEstado = 'PA' then
  begin
    strMask := '99-999999-9;0;_';
  end
  else if strEstado = 'PB' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'PE' then
  begin
    // VALIDAÇÃO DA INSCRICAO ESTADUAL ANTIGA - 14 dígitos
    if length(strIES) > 9 then
    begin
      strMask := '99.9.999.9999999-9;0;_';
    end
    else
    // VALIDAÇÃO DA INSCRICAO ESTADUAL NOVA - 9 dígitos
    begin
      strMask := '9999999-99;0;_';
    end;
  end
  else if strEstado = 'PI' then
  begin
    strMask := '999999999;0;_';
  end
  else if strEstado = 'PR' then
  begin
    strMask := '999.99999-99;0;_';
  end
  else if strEstado = 'RJ' then
  begin
    strMask := '99.999.99-9;0;_';
  end
  else if strEstado = 'RN' then
  begin
    strMask := '99.999.999-9;0;_';
  end
  else if strEstado = 'RO' then
  begin
    strMask := '9999999999999-9;0;_';
  end
  else if strEstado = 'RR' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'RS' then
  begin
    strMask := '999/999999-9;0;_';
  end
  else if strEstado = 'SC' then
  begin
    strMask := '999.999.999;0;_';
  end
  else if strEstado = 'SE' then
  begin
    strMask := '99999999-9;0;_';
  end
  else if strEstado = 'SP' then
  begin
    if LeftStr(strIES, 1) = 'P' then
    begin
      strMask := 'P-99999999.9/999;0;_';
    end
    else
    begin
      strMask := '999.999.999.999;0;_';
    end;
  end
  else if strEstado = 'TO' then
  begin
    strMask := '99 999999 9;0;_';
  end;

  Result := FormatMaskText(strMask,strIES);

end;

{***********************************}
{* Abrir Banco de Dados do Sistema *}
{********************************DV*}
procedure pAbrirBanco(var Database: TUniConnection);
  Var
    qryGen: TUniQuery;

    {FS 10092019:1636}
    {**aqui - metodo atual}
    intCodAut_v2: Integer;

    libUtil: Cardinal;
    fRetornaUsuario: function: PAnsiChar; stdcall;
    fRetornaSenha: function: PAnsiChar; stdcall;

    {FS 10092019:1636}
    {**aqui - metodo atual}
    pSetaConfiguracoesSinc: procedure(strHost, strData : String; intPort : Integer; intCodA : Integer); stdcall;

  function fPathExe: String;
  begin
    {1}{FS 10092019:1636}
    if (f__VS_CONEXAO_USANDO_PASTA_ANTERIOR_A_DO_AUTSI) then
      {**aqui - metodo atual}
      Result := fCaminhoConexaoUsandoPastaAnteriorDoAusti
    else
    {$IFDEF MSWINDOWS}
      Result := ExtractFilePath(Application.ExeName);
    {$ENDIF}  
  end;

  {*****************************************}
  {* VERIFICA SE IRÁ UTILIZAR A SENHA DA   *}
  {* DLL.                                  *}
  {**************************************MV*}
  function fUsarSenhaDLL: Boolean;
  begin
    {FS 10092019:1636}
    {**aqui - metodo atual}
    Result := (FileExists(fPathExe + 'libUtil.dll'));
  end;

  {*****************************************}
  {* EFETUA A CONEXÃO COM O BANCO.         *}
  {**************************************MV*}
  function fConectar: Boolean;
    const
      intArrayCodAut: array[1..5] of Integer = (2,3,4,5,6);
    var
      i: Integer;
      blnRe_Conectar: Boolean;

    {*****************************************}
    {* MOSTRA MSG DE ERRO.                   *}
    {**************************************MV*}
    procedure pMsgErro(E: Exception);
    begin
      {$IFDEF MSWINDOWS}
      fMensagem('Aviso', 'Abertura do Banco de Dados: ' + E.Message, ['&Ok']);
      fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&Ok']);
      If (fTabelaExiste('LOGACE')) then
        TLogAut.New().pLogout();
      Application.Terminate;
      {$ELSE}
      writeln(E.Message);

      {$ENDIF}
    end;

  begin
    Database.Connected:= False;
    Database.Database := '';
    Database.Server := '';
    blnRe_Conectar := True;
    Result:= Database.Connected;

    { alterada posição de baixo pra cima }
    //**********************************************************//
    Database.Server   := AnsiReplaceStr(fArqIni(0,'BANCO','NUMIP',''), ' ', '');
    Database.Database := fArqIni(0,'BANCO','NOMBAN','');
    If Not fEmptyStr(fArqIni(0,'BANCO','PORTA','')) Then
      Database.Port := StrToInt(AnsiReplaceStr(fArqIni(0,'BANCO','PORTA','3306'), ' ', ''));
    //**********************************************************//

    if not fEmptyStr(Database.Database) then
    begin

      for i := Low(intArrayCodAut) to High(intArrayCodAut) do
      begin
        {$IFDEF MSWINDOWS}
        If fUsarSenhaDLL Then
        Begin
          libUtil := LoadLibrary(PChar(fPathExe + 'libUtil.dll'));

          {FS 10092019:1636}
          {**aqui - metodo atual}
          pSetaConfiguracoesSinc := GetProcAddress(libUtil, PChar('pSetaConfiguracoes'));
          If Assigned(pSetaConfiguracoesSinc) Then
            pSetaConfiguracoesSinc(Database.Server, Database.Database, Database.Port, intArrayCodAut[i]);

          fRetornaUsuario := GetProcAddress(libUtil, PChar('fRetornaUsuarioPChar'));
          fRetornaSenha   := GetProcAddress(libUtil, PChar('fRetornaSenhaPChar'));

          Database.Username := String(AnsiStrings.StrPas(fRetornaUsuario));
          Database.Password := String(AnsiStrings.StrPas(fRetornaSenha));

          FreeLibrary(libUtil);

          intCodAut_v2:= intArrayCodAut[i];
          if i = Length(intArrayCodAut) then
            blnRe_Conectar:= False;

        End
        Else
        Begin
          blnRe_Conectar    := False;
          Database.Username := 'root';
          Database.Password := 'citel13347';
        End;
        {$ELSE}
          Writeln('Server: ' + Database.Server);
          Writeln('Database: ' + Database.Database);
          Writeln('Port: ' + IntToStr(Database.Port));

          blnRe_Conectar    := False;

          // usuário e senha padrão para Linux
          Database.Username := 'sped_citel';
          Database.Password := 'citel@347_spe!';

          //atenção, base de testes
          //# Database.Username := 'root';
          //# Database.Password := 'citel13347';
        {$ENDIF}

        try
          Database.Connected := True;
          Break;
        except
          on E : EUniError Do
          begin
            if blnRe_Conectar then
            begin
              if Database.Username = 'root' then
                Break
              else
                Database.Connected:= False;
            end
            else
            begin
              pMsgErro(E);
              Exit;
            end;
          end;
          on E : Exception Do
          begin
            pMsgErro(E);
            Exit;
          end;
        end;

      end;

    end
    else
    begin

      try
        Database.Connected:= True;
      except
        on E : EUniError Do
        begin
          pMsgErro(E);
          Exit;
        end;
        on E : Exception Do
        begin
          pMsgErro(E);
          Exit;
        end;
      end;

    end;

    Result:= Database.Connected;

  end;
begin

  {FS 10092019:1636}
  {**aqui - metodo atual}
  {$IFDEF MSWINDOWS}
  if fConectar then
    //abrir conexão com o java
    fArqIni(1, 'GERAL', 'CODAUT_V2', IntToStr(intCodAut_v2))
  else
  begin
    //abrir conexão com o java}
    intCodAut_v2:= -1;
    fArqIni(1, 'GERAL', 'CODAUT_V2', IntToStr(intCodAut_v2));
  end;
  {$ELSE}
  if fConectar then
    Writeln('Conectado com sucesso a base de Dados!')
  else
    Writeln('Ocorreu algum problema ao conectar com a base Dados!');
  {$ENDIF}

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
    End;

  Except
    On E : Exception Do
    Begin
      {$IFDEF MSWINDOWS}
      pMensagensErro(E.Message, '[pAbrirBanco]');
      fMensagem('Aviso', 'Sua aplicação será fechada agora', ['&O k']);
      If (fTabelaExiste('LOGACE')) then
        TLogAut.New().pLogout();
      Application.Terminate;
      {$ENDIF}
    End;
  End;

  FreeAndNil(qryGen);
end;

function fRetConexao: TUniConnection;
begin

  If Not Assigned(frmModulo.Database) Then
  Begin
    frmModulo.Database := TUniConnection.Create(Nil);
    frmModulo.Database.ProviderName := 'MySQL';
    frmModulo.Database.AutoCommit := True;
    If (Not Assigned(frmModulo.Database.AfterConnect)) Then
      frmModulo.Database.AfterConnect := TModuloEvents.AfterConnect;
    pAbrirBanco(frmModulo.Database);
  End;

  Result := frmModulo.Database;
end;

{$IFDEF MSWINDOWS}
procedure pPedeSenhaDestravarCodAut;
  Var
    strSenha: String;
begin
  strSenha := '';
  While (InputQuery('Senha para destravamento', 'Ligue na Citel e peça a senha para destravamento', strSenha)) Do
  Begin

    If fSenhaDestravarCodAut(strSenha) Then
    Begin
      fArqIni(1, 'GERAL', 'CODAUT', '0');
      ShowMessage('Destravado!');
      Break;
    End;

  End;
end;
{$ENDIF}
function fFloatToStrSemPontoSemVirgula(valor: double; inte, deci: integer): string;
begin
  Result := fStrZero(AnsiReplaceStr(AnsiReplaceStr(fFormataValor(valor, inte, deci), ',', ''), '.', ''), inte);
end;

function fFloatToStrSemPontoSemVirgula(valor: string; inte, deci: integer): string;
begin
  Result := fStrZero(AnsiReplaceStr(AnsiReplaceStr(fFormataValor(strToFloat(fTiraCaracEspeciais(valor, True, True))/100, inte, deci), ',', ''), '.', ''), inte);
end;

{*****************************************}
{* VALIDA O CNPJ OU CGC, DE ACORDO COM   *}
{* 'strOpcao'                            *}
{**************************************MV*}
function fValidaCnpjCpf(strOpcao, strValor: String; blnPassaVazio: Boolean = False; blnMsg: Boolean = True): Boolean;
begin
  Result := True;
  If (blnPassaVazio) And (strOpcao = '0') Then
    Exit;

  If strOpcao = '1' Then
  Begin
    Result := fTestaCgc(strValor);
    {$IFDEF MSWINDOWS}
    If Not Result Then
      If blnMsg Then
        fMensagem('ATENÇÃO', strValor + ' não é um Número de CNPJ válido!', ['&Ok']);
    {$ENDIF}
  End
  Else If strOpcao = '2' Then
  Begin
    Result := fValidaCPF(strValor);
    {$IFDEF MSWINDOWS}
    If Not Result Then
      If blnMsg Then
        fMensagem('ATENÇÃO', strValor + ' não é um Número de CPF válido!', ['&Ok']);
    {$ENDIF}    
  End;
end;

{*****************************************}
{* VERIFICA SE O CNPJ JÁ ESTÁ CADASTRADO *}
{**************************************AF*}
function fExisteCnpjCpf(strTabela, strCamExe, strCodExe, strCampo, strCodigo: String): Boolean;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

Begin
  Try

    Result := False;

    qryGenTmp := fCriaQuery;

    If Not fEmptyStr(strCodigo) Then
    Begin

      strSQL := '';
      strSQL := strSQL + ' SELECT ';
      strSQL := strSQL + '   * ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strTabela;
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + strCampo  + ' = :CODIGO AND ';
      strSQL := strSQL + strCamExe + ' <> :CODEXE ';

      With qryGenTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODIGO').AsString := strCodigo;
        ParamByName('CODEXE').AsString := strCodExe;
        Open;

        If Not IsEmpty Then
        Begin

          If Pos(fCfgSis('VERCGC'),'A_T_') > 0 Then
          Begin
            {$IFDEF MSWINDOWS}
            fMensagem('','Já existe um CNPJ/CPF com esse numero cadastrado!',['&OK']);
            {$ENDIF}
            If fCfgSis('VERCGC') = 'T' Then
              Result := True;

          End;

        End;

        Close;
      End;

    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

End;

{*********************************}
{* VALIDA CGC                    *}
{*********************************}
function fTestaCgc(xCGC: String):Boolean;
begin
  Result := TCNPJ.fTestaCNPJ(xCGC, fCfgSis('NWCNPJ', varBoolean));
end;

{*********************************}
{* VALIDA CPF                    *}
{*********************************}
function fValidaCPF(sCPF: string):Boolean;
var
   sDigs, sVal  : string;
   iSTot, iSTot2: integer;
   i: integer;
begin
  Result := False;
  sCPF   := Trim(AnsiReplaceText(sCPF, '.', ''));
  sCPF   := Trim(AnsiReplaceText(sCPF, '-', ''));
  iSTot  := 0;
  iSTot2 := 0;
  If Length(sCPF) = 11 Then
  begin
    For i := 9 Downto 1 Do
    Begin
      iSTot  := iSTot  + StrToIntDef(Copy(sCPF,i,1),0) * (11-i);
      iSTot2 := iSTot2 + StrToIntDef(Copy(sCPF,i,1),0) * (12-i);
    End;
    iSTot  := iSTot Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot < 2, 0, 11-iSTot));

    iSTot2 := iSTot2 + 2*StrToInt(sDigs);
    isTot2 := iSTot2 Mod 11;
    sDigs  := sDigs + IntToStr(iif(iSTot2 < 2, 0, 11-iSTot2));

    sVal   := Copy(sCPF,10,2);
    Result := sDigs = sVal;
  End;
end;

(**********************************************************************)
(* SETA UMA VARIAVEL NO BANCO DE DADOS COM O PROXIMO AUTOINCREMENTO   *)
(* DA TABELA PASSADA COMO PARAMETRO                                   *)
(*******************************************************************LA*)
Function fSetaVarAutoinc(strNomTab: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  Try

    qryGen := fCriaQuery;

    Try

      With qryGen, Sql Do
      Begin
        Close;
        Clear;
        Add('SET @INC' + strNomTab + '=(SELECT IFNULL(CAST( LEFT(MAX(AUTOINCREM),17) AS UNSIGNED),0) AS AUTO FROM ' + strNomTab + ')');
        ExecSQL;
        Close;

        Result := TRUE;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
				pMensagensErro(E.Message,'[fSetaVarAutoinc]');
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

{*********************************************************}
{* RETORNA O PROXIMO CODIGO, PORÉM NÃO ATUALIZA O PROCOD *}
{******************************************************MV*}
function fRetornaProCod(strNomeTabela: String): String;
  Var
    intCodigoAtual: Integer;
    intTamCodigo  : Integer;

    strSQL   : String;
    qryGenCod: TUniQuery;

begin
//  fLock_Unlock('PROCOD', True);

  Try
    pValidaProCod(strNomeTabela);

    qryGenCod := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
      strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
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
          Raise Exception.Create('A tabela ' + strNomeTabela + ' não está cadastrada ' +
                                 'na tabela de Próximos Codigos! Verifique.' + #13#10);
        End;

        intCodigoAtual := FieldByName('CODSEQ').AsInteger;
        intTamCodigo   := FieldByName('TAMCOD').AsInteger;
        Close;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
      End;
    End;

    Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');

  Finally
    FreeAndNil(qryGenCod);
  End;

end;

procedure pCarregaStringDevolucoes(strClaDev: String; var strClaDevVenda: String; var strClaDevCompra: String);
  Var
    strAux: String;
    intTamanhoString, intContador: Integer;
begin
  strAux := '';

  strClaDev := AnsiReplaceStr(fTiraCaracEspeciais(strClaDev), ' ', '');

  intTamanhoString := Length(strClaDev);

  For intContador := 1 to intTamanhoString Do
  Begin
    strAux := strAux + Copy(strClaDev, intContador, 1);

    If Length(Trim(strAux)) = 4 Then
    Begin
      If StrToInt(LeftStr(strAux, 1)) < 5 Then
      Begin
        strClaDevVenda := strClaDevVenda + strAux + '_';
        strAux := '';
      End
      Else
      Begin
        strClaDevCompra := strClaDevCompra + strAux + '_';
        strAux := '';
      End
    End;
  End;
end;

procedure pCarregaSQLModalidadesPagamentoFreteNfCancelada(strTipFc: String; qryAux: TUniQuery);
  Var
    strSQL: String;

  function fCampoTipoFrete(const strCampo: String): String;
  begin
    Result := '';
    Result := Result + 'CASE ';
    Result := Result + '  WHEN ' + strCampo + ' = 1 THEN 0 ';
    Result := Result + '  WHEN ' + strCampo + ' = 2 THEN 1 ';
    Result := Result + '  WHEN ' + strCampo + ' = 3 THEN 2 ';
    Result := Result + '  ELSE 9 ';
    Result := Result + 'END ';
  end;
begin
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FIS_CODEMP, ';
  strSQL := strSQL + '  FIS_NUMDOC, ';
  strSQL := strSQL + '  FIS_FORCLI, ';
  strSQL := strSQL + '  FIS_ESPDOC, ';
  strSQL := strSQL + '  FIS_SERIE_, ';
  strSQL := strSQL + '  FIS_TIP_FC, ';
  strSQL := strSQL + '  FIS_DTADOC, ';
  strSQL := strSQL + '  FIS_DTAENT, ';
  strSQL := strSQL + '  IFNULL(GER_VLRCON, 0) AS GER_VLRCON, ';
  strSQL := strSQL + '  IFNULL(GER_VALPIS, 0) AS GER_VALPIS, ';
  strSQL := strSQL + '  IFNULL(GER_VALCOF, 0) AS GER_VALCOF, ';
  strSQL := strSQL + '  IFNULL(GER_DESESP, 0) AS GER_DESESP, ';
  strSQL := strSQL + '  IF(LOCATE(GER_CLAFIS, "' + VS_strClaCom + '") > 0 OR LOCATE(GER_CLAFIS, "' + VS_strClaVen + '") > 0, IF(GER_CONPAG = "01000", "0", IF(IFNULL(GER_CONPAG, "") = "", "2", "1")), "2") AS FIS_CNDPAG, ';
  strSQL := strSQL + '  IFNULL(' + fCampoTipoFrete('GER_TIPFRE') + ', "9") AS FIS_FRETE_TIPO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADFIS';

  strSql := strSql + '  INNER JOIN DEL_MOVGER ';
  strSql := strSql + '   ON GER_CODEMP = FIS_CODEMP ';
  strSql := strSql + '    AND GER_ESPDOC = FIS_ESPDOC ';
  strSql := strSql + '    AND GER_TIP_FC = FIS_TIP_FC ';
  strSql := strSql + '    AND GER_NUMDOC = FIS_NUMDOC ';
  strSql := strSql + '    AND IFNULL(GER_SERIE_,"") = IFNULL(FIS_SERIE_,"") ';
  strSql := strSql + '    AND IF(GER_TIP_FC = "C", GER_CODCLI = FIS_FORCLI, GER_CODFOR = FIS_FORCLI) ';

  strSQL := strSQL + 'WHERE FIS_CODEMP = :CODEMP ';
  strSQL := strSQL + '  AND FIS_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '  AND FIS_FORCLI = :FORCLI ';
  strSQL := strSQL + '  AND FIS_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND FIS_SERIE_ = :SERIE_ ';
  strSQL := strSQL + '  AND FIS_TIP_FC = :TIP_FC ';

  strSQL := strSQL + ' GROUP BY ';
  strSQL := strSql + '   FIS_CODEMP, FIS_NUMDOC, FIS_FORCLI, FIS_ESPDOC, FIS_SERIE_, FIS_TIP_FC ';

  strSql := strSql + ' UNION ALL ' + AnsiReplaceText(strSql, 'DEL_MOVGER', 'DEL_NOTGER');

  strSQL := 'SELECT TAB_CANC.* FROM (' + strSQL + ') AS TAB_CANC GROUP BY FIS_CODEMP, FIS_NUMDOC, FIS_FORCLI, FIS_ESPDOC, FIS_SERIE_, FIS_TIP_FC';

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Text := strSQL;
end;

procedure pRetModalidadePagamentoFreteNfCancelada(var strDataDoc, strDataEnt, strTotCon, strCondPag, strDesconto, strIndFrete, strValPis, strValCof: String;
                                                  strNumdoc, strEspDoc, strCodEmp, strForCli, strSerie, strTipFc: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    pCarregaSQLModalidadesPagamentoFreteNfCancelada(strTipFc, qryAux);

    qryAux.ParamByName('NUMDOC').AsString := strNumdoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strForCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie;
    qryAux.ParamByName('TIP_FC').AsString := strTipFc;
    qryAux.Open;

    strDataDoc := FormatDateTime('DDMMYYYY', qryAux.FieldByName('FIS_DTADOC').AsDateTime);
    strDataEnt := FormatDateTime('DDMMYYYY', qryAux.FieldByName('FIS_DTAENT').AsDateTime);
    strTotCon := qryAux.FieldByName('GER_VLRCON').AsString;
    strCondPag := qryAux.FieldByName('FIS_CNDPAG').AsString;
    strDesconto := qryAux.FieldByName('GER_DESESP').AsString;
    strIndFrete := qryAux.FieldByName('FIS_FRETE_TIPO').AsString;
    strValPis := qryAux.FieldByName('GER_VALPIS').AsString;
    strValCof := qryAux.FieldByName('GER_VALCOF').AsString;
  Finally
    qryAux.Free;
  End;
end;

function fRetornaMesRefCreFis(strData: String): string;
begin
  Result := FormatDateTime('mmyyyy', IncMonth(StrToDate(strData), -1));
end;

function fRetornaCSTPIS(strCLAFIS: string; blnINCPIS: Boolean; strEntSai: String): string;
  Var
    blnEncontrouCST: Boolean;
begin
  Result := '00';
  blnEncontrouCST := False;
  If fCfgSis('SIMPAU',varString,VS_strCodEmp) = 'S' Then
  Begin
    if strEntSai = 'S' then
      Result := '99'
    else
      Result := '98';
  End
  Else
  Begin
    If (Pos(strCLAFIS, fCfgSis('CLAVEN',varString,VS_strCodEmp)) <= 0) And (strEntSai = 'S') Then
    Begin
      Result := '08';
      blnEncontrouCST := True;
    End;

    If  (Pos(strCLAFIS, fCfgSis('CLACOM',varString,VS_strCodEmp)) <= 0) And (strEntSai = 'E') Then
    begin
      Result := '70';
      blnEncontrouCST := True;
    end;

    If Not blnEncontrouCST Then
    Begin
      If (blnINCPIS) Then
      Begin
        if strEntSai = 'S' then
          Result := '01'
        else
          Result := '50';
      End
      Else
      Begin
        if strEntSai = 'S' then
          Result := '07'
        else
          Result := '71';
      End;
    End;
  End;
end;

function fRetornaCSTIPI(dValorIPI: Double; strEntSai: String): String;
begin
  Result := '';
  if dValorIPI > 0 then
  begin
    if strEntSai = 'E' then
      Result := '00'
    else
      Result := '50'
  end
  else
  begin
    if strEntSai = 'E' then
      Result := '03'
    else
      Result := '53'
  end;
end;

function fBuscaItemTerceiro(strCodIte: String): String;
var
  strSQL : string;
  qryConsulta : TUniQuery;
begin
  Result := '';

  try
    qryConsulta := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT G.GMT_CODITE ';
    strSQL := strSQL + '   FROM GERMAT G     ';
    strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = G.GMT_CODITE ';
    strSQL := strSQL + '  WHERE G.GMT_CODITE = :CODITE ';

    with qryConsulta do
    begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Params.ParamByName('CODITE').AsString := strCodIte;
      Open;

      if FieldByName('GMT_CODITE').AsString <> '' then
        Result := 'T'
      else
        Result := 'P';
    end;

  finally
    FreeAndNil(qryConsulta);
  end;

end;

function fPlacaVeiculo(strPlaca: string; intRetorno: Integer = 0{0 - numero / 1 - letras}) : string;
begin
  if intRetorno = 1 then
    Result := Copy(strPlaca,1,3)
  else
    Result := Copy(strPlaca,3,4)
end;

{
         SOMENTE PARA SIMPLES PAULISTA CFG_SIMPAU
           DOIS ULTIMOS DET_CODFIS
               TXT_CST_SIMPLES.TXT
           /* CST ICMS PARA O SIMPLES*/
}
function fRetornaCSTCSOSN(strCodFis: string; strCSTSTR: Variant): string;
begin
  Result := '9'; //900

  If strCodFis = '00' Then
  Begin
    If Not fEmptyStr(strCSTSTR) Then
    Begin
      If StrToIntDef(strCSTSTR, 102) = 102 Then
        Result := '1'  //102
      Else
        Result := '0'; //101
    End
    Else
      Result := '1';   //102
  End
  Else If Pos(strCodFis, '30_40_50') > 0 Then
    Result := '2'  //103
  Else If Pos(strCodFis, '10_60_70') > 0 Then
  Begin
    If Not fEmptyStr(strCSTSTR) Then
    Begin
      If StrToIntDef(strCSTSTR, 202) = 202 Then
        Result := '4'  //202
      Else
        Result := '8'; //500
    End
    Else
      Result := '4';   //202
  End
  Else If Pos(strCodFis, '41_51') > 0 Then
    Result := '7';  //400
end;

function fBuscaUnidadeItem(strCodUni: String): String;
var
  strSQL : string;
  qryUnidade: TUniQuery;
begin
  try
    qryUnidade := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' SELECT  ';
    strSQL := strSQL + '        UNI_DESUNI   ';
    strSQL := strSQL + '   FROM CADUNI       ';
    strSQL := strSQL + '  WHERE UNI_CODUNI = :CODUNI ';

    qryUnidade.Close;
    qryUnidade.SQL.Clear;
    qryUnidade.SQL.Add(strSQL);
    qryUnidade.Open;

    if qryUnidade.FieldByName('UNI_DESUNI').AsString <> '' then
      Result := qryUnidade.FieldByName('UNI_DESUNI').AsString
    else
      Result := '';

  finally
    FreeAndNil(qryUnidade);
  end;
end;

function fRetornaTotalizadorParcial(strCodFis: string): string;
begin
  Result := '';

  if Pos(RightStr(strCodFis, 2), '10_60_70') > 0 then
    Result := 'F1'
  else if Pos(RightStr(strCodFis, 2) , '41_51') > 0 then
    Result := 'N1'
  else if Pos(RightStr(strCodFis, 2) , '30_40_50') > 0 then
    Result := 'I1';
end;

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
    //# Result := Result + MidStr('‘’›œ?ž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúû?ÅÀ£',intCl1,1);
    //# ATUALIZADA COM O AUTCOM 11-02-2020 1612
    Result := Result + MidStr('‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÅÀ£#', intCl1, 1);
  End;
end;

function fCryptC(strSenha: String): String;
	Var
  	intCol,
    intCl1 : Integer;

begin
	Result := '';

  If fEmptyStr(strSenha) Then
  	Result := fstrEspaco(strSenha, Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
  	intCl1 := Pos(MidStr(strSenha, intCol, 1), STR_CHAR_SENHA_C);
    Result := Result + MidStr('ªº«ÁÂÃÄ©ÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙ‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÝß¶®Å~£¤§À²³¢', intCl1, 1);
  End;
end;

function fDecryptC(strSenha: String): String;
  Var
    intCol,
    intCl1: Integer;
begin
  Result := '';

  If fEmptyStr(strSenha) Then
    Result := fstrEspaco(strSenha, Length(strSenha));

  For intCol := Length(strSenha) Downto 1 Do
  Begin
    intCl1 := Pos(MidStr(strSenha, intCol,1),'ªº«ÁÂÃÄ©ÆÇÈÉÊËÌÍÎÏÑÒÓÔÕÖØÙ‘’›œž¨­àáâãäåæçèéêëìíîïðñþò÷üôøýöùúûÝß¶®Å~£¤§À²³¢');
    Result := Result + MidStr(STR_CHAR_SENHA_C, intCl1, 1);
  End;
end;

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

function fGravaMovGer(strNomeTabela: String;
                      Var strAutInc: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodTra,
                      strCodVen,
                      strCodFor,
                      strCodCli,
                      strTip_Fc: String;
                      dtaDtaEnt,
                      tmrHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strEstado,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon,
                      strCgcCpf,
                      strCgcCon,
                      strIesCon,
                      strCli_Rg: String;
                      fltBasSim,
                      fltBasIpi,
                      fltAlqIpi,
                      fltTotIpi,
                      fltBasIcm,
                      fltAlqIcm,
                      fltTotIcm,
                      fltTotRet,
                      fltAlqRet,
                      fltBasRet,
                      fltRet_SP,
                      fltDesEsp,
                      fltVlrCon,
                      fltTotPro,
                      fltTotCus,
                      fltTotMed: Double;
                      strTipFre: String;
                      fltTotFre,
                      fltPesBru,
                      fltPesLiq,
                      fltVolume: Double;
                      strEspeci,
                      strMarca,
                      strMen001,
                      strMen002,
                      strMen003,
                      strMen004,
                      strMen005: String;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat,
                      fltVPar01,
                      fltVPar02,
                      fltVPar03,
                      fltVPar04,
                      fltVPar05,
                      fltVPar06,
                      fltVPar07,
                      fltVPar08,
                      fltVPar09,
                      fltVPar10,
                      fltVPar11,
                      fltVPar12: Double;
                      strSerie,
                      strNotEsp,
                      strClaFis,
                      strClaFi2,
                      strClaFi3,
                      strNatOpe: String;
                      fltPorDes: Double;
                      strCodDig,
                      strCodCnd,
                      strCodFpg: String;
                      fltFatNot: Double;
                      strCodS01,
                      strCodS02,
                      strCodS03,
                      strCodS04,
                      strCodS05,
                      strCodS06,
                      strDesS01,
                      strDesS02,
                      strDesS03,
                      strDesS04,
                      strDesS05,
                      strDesS06: String;
                      fltValS01,
                      fltValS02,
                      fltValS03,
                      fltValS04,
                      fltValS05,
                      fltValS06: Double;
                      intPraEnt: Integer;
                      fltTotSer,
                      fltPerIss,
                      fltValIss,
                      fltDesAce: Double;
                      strOriDoc,
                      strConEnt,
                      strCodRep: String;
                      fltAlqIrf,
                      fltValIrf,
                      fltAlqPis,
                      fltValPis,
                      fltAlqCof,
                      fltValCof,
                      fltAlqCsl,
                      fltValCsL,
                      fltIrfRet,
                      fltPisRet,
                      fltCofRet,
                      fltCslRet: Double;
                      strNotRet: String;
                      fltAlIrfP,
                      fltAlPisP,
                      fltAlCofP,
                      fltAlCslP,
                      fltSerRet: Double;
                      strNoReSe: String;
                      fltPeSgSo,
                      fltVlSgSo,
                      fltIrPrRt,
                      fltIrPrDv,
                      fltIrSeRt,
                      fltIrSeDv,
                      fltPiPrRt,
                      fltPiPrDv,
                      fltPiSeRt,
                      fltPiSeDv,
                      fltCoPrRt,
                      fltCoPrDv,
                      fltCoSeRt,
                      fltCoSeDv,
                      fltCsPrRt,
                      fltCsPrDv,
                      fltCsSeRt,
                      fltCsSeDv: Double;
                      strOrdPro: String;
                      fltBasOrg,
                      fltIcmOrg: Double;
                      intNConhe: Integer;
                      strConsum,                     // Consumidor final
                      strEntFat,
                      strCliFat,
                      strOpeExp,
                      strSepExp,
                      strTabPre,
                      strNum_Pr,
                      strEntFut: String;
                      blnBaiFut: Boolean;
                      fltMargem: Double;
                      fltBaRtSp,
                      fltVlRtSp: Double;
                      strOprFlj,
                      strNumReg: String;
                      dtaDtEntr: TDateTime;
                      strNroCei,
                      strClaFi4,
                      strAutSer,
                      strCodEve,
                      strAutEnt,
                      strObsNfe,
                      strCodOco: String;
                      blnIpDpNf: Boolean;
                      fltValCre: Double    = 0;
                      dtadtlBex: TDateTime = 0;
                      strEmlCon: String    = '';
                      dtaDtESNf: TDateTime = 0;
                      tmrHrESNf: TDateTime = 0;
                      objFinanc: Pointer = Nil): Boolean;
  Var
    strTblMovObs: String;
    qryTblMovGer: TUniQuery;
    qryTblMovObs: TUniQuery;
    blnSolDtaEntSaiNfe: Boolean;
Begin

  Result := True;

  blnSolDtaEntSaiNfe := fCfgSis('SOLDSE', varBoolean);

  Try

    qryTblMovGer := fCriaQuery(nil);
    With  qryTblMovGer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
      Open;
    End;

    strTblMovObs := 'MOVOBS' + IIF(strNomeTabela = 'MOVGER', '', 'X');

    Try

      fStartTransaction;

      //strAutInc := fRetAutoIncrem(strNomeTabela, strCodEmp);

      With qryTblMovGer Do
      Begin
        Open;
        Insert;
        FieldByName('AUTOINCREM').AsString   := strAutInc;
        FieldByName('GER_NUMDOC').AsString   := strNumDoc;
        FieldByName('GER_SERIE_').AsString   := strSerie;
        FieldByName('GER_ESPDOC').AsString   := strEspDoc;
        FieldByName('GER_CODEMP').AsString   := strCodEmp;

        If fEmptyStr(strCodTra) Then
          FieldByName('GER_CODTRA').Value    := Null
        Else
          FieldByName('GER_CODTRA').AsString := strCodTra;

        If fEmptyStr(strCodVen) Then
          FieldByName('GER_CODVEN').Value    := '999'//strLoginUsuarioLogado
        Else
          FieldByName('GER_CODVEN').AsString := strCodVen;

        If fEmptyStr(strCodFor) Then
          FieldByName('GER_CODFOR').Value    := Null
        Else
          FieldByName('GER_CODFOR').AsString := strCodFor;

        If fEmptyStr(strCodCli) Then
          FieldByName('GER_CODCLI').Value    := Null
        Else
          FieldByName('GER_CODCLI').AsString := strCodCli;

        FieldByName('GER_TIP_FC').AsString   := strTip_Fc;

        If (dtaDtaEnt = 0) Then
          FieldByName('GER_DTAENT').Value      := Null
        Else
          FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;

        If (tmrHorEnt = 0) Then
          FieldByName('GER_HORENT').Value      := Null
        Else
          FieldByName('GER_HORENT').AsDateTime := tmrHorEnt;

        If (dtaDtaDoc = 0) Then
          FieldByName('GER_DTADOC').Value      := Null
        Else
          FieldByName('GER_DTADOC').AsDateTime := dtaDtaDoc;

        If fEmptyStr(fTiraCaracEspeciais(strConPag)) Then
          FieldByName('GER_CONPAG').Value := Null
        Else
          FieldByName('GER_CONPAG').AsString := fTiraCaracEspeciais(strConPag);

        FieldByName('GER_ESTADO').AsString   := strEstado;

        FieldByName('GER_NOMCON').AsString := strNomCon;
        If fEmptyStr(strNomCon) Then
        Begin
          FieldByName('GER_NOMCON').Value := Null;
          FieldByName('GER_ENDCON').Value := Null;
          FieldByName('GER_BAICON').Value := Null;
          FieldByName('GER_CEPCON').Value := Null;
          FieldByName('GER_CIDCON').Value := Null;
          FieldByName('GER_ESTCON').Value := Null;
          FieldByName('GER_TELCON').Value := Null;
          FieldByName('GER_CGCCPF').Value := Null;
          FieldByName('GER_CGCCON').Value := Null;
          FieldByName('GER_IESCON').Value := Null;
          FieldByName('GER_R_GCON').Value := Null;
         // FieldByName('GER_EMLCON').Value := Null;
        End
        Else
        Begin
          FieldByName('GER_NOMCON').AsString := strNomCon;
          FieldByName('GER_ENDCON').AsString := strEndCon;
          FieldByName('GER_BAICON').AsString := strBaiCon;
          FieldByName('GER_CEPCON').AsString := strCepCon;
          FieldByName('GER_CIDCON').AsString := strCidCon;
          FieldByName('GER_ESTCON').AsString := strEstCon;
          FieldByName('GER_TELCON').AsString := strTelCon;
          FieldByName('GER_CGCCPF').AsString := strCgcCpf;
          FieldByName('GER_CGCCON').AsString := strCgcCon;
          FieldByName('GER_IESCON').AsString := strIesCon;
          FieldByName('GER_R_GCON').AsString := strCli_Rg;
//          FieldByName('GER_EMLCON').AsString := strEmlCon;
        End;

        FieldByName('GER_BASSIM').AsFloat    := fltBasSim;
        FieldByName('GER_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('GER_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('GER_TOTIPI').AsFloat    := fltTotIpi;
        FieldByName('GER_BASICM').AsFloat    := fltBasIcm;
        FieldByName('GER_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('GER_TOTICM').AsFloat    := fltTotIcm;
        FieldByName('GER_TOTRET').AsFloat    := fltTotRet;
        FieldByName('GER_RET_SP').AsFloat    := fltRet_SP;
        FieldByName('GER_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('GER_BASRET').AsFloat    := fltBasRet;
        FieldByName('GER_DESESP').AsFloat    := fltDesEsp;
        FieldByName('GER_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('GER_TOTPRO').AsFloat    := fltTotPro;
        FieldByName('GER_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('GER_TOTMED').AsFloat    := fltTotMed;
        FieldByName('GER_TIPFRE').AsString   := strTipFre;
        FieldByName('GER_TOTFRE').AsFloat    := fltTotFre;
        FieldByName('GER_PESBRU').AsFloat    := fltPesBru;

        If fltPesLiq <= 0 Then
          FieldByName('GER_PESLIQ').AsFloat  := fltPesBru
        Else
          FieldByName('GER_PESLIQ').AsFloat  := fltPesLiq;

        FieldByName('GER_VOLUME').AsFloat    := fltVolume;
        FieldByName('GER_ESPECI').AsString   := strEspeci;
        FieldByName('GER_MARCA_').AsString   := strMarca;
        FieldByName('GER_MEN001').AsString   := strMen001;
        FieldByName('GER_MEN002').AsString   := strMen002;
        FieldByName('GER_MEN003').AsString   := strMen003;
        FieldByName('GER_MEN004').AsString   := strMen004;
        FieldByName('GER_MEN005').AsString   := strMen005;
        If blnJafatu Then
          FieldByName('GER_JAFATU').AsInteger := 1
        Else
          FieldByName('GER_JAFATU').AsInteger := 0;

        FieldByName('GER_TIPFAT').AsString   := strTipFat;
        FieldByName('GER_NUMFAT').AsString   := strNumFat;
        if fEmptyStr(strNumFat) Then
          strEmpFat := '';
        FieldByName('GER_EMPFAT').AsString   := strEmpFat;

        If (dtaDtaFat = 0) Then
          FieldByName('GER_DTAFAT').Value      := Null
        Else
          FieldByName('GER_DTAFAT').AsDateTime := dtaDtaFat;

        FieldByName('GER_VENFAT').AsString   := strVenFat;
        FieldByName('GER_CNDFAT').AsString   := strCndFat;
        FieldByName('GER_VALFAT').AsFloat    := fltValFat;
        FieldByName('GER_VPAR01').AsFloat    := fltVPar01;
        FieldByName('GER_VPAR02').AsFloat    := fltVPar02;
        FieldByName('GER_VPAR03').AsFloat    := fltVPar03;
        FieldByName('GER_VPAR04').AsFloat    := fltVPar04;
        FieldByName('GER_VPAR05').AsFloat    := fltVPar05;
        FieldByName('GER_VPAR06').AsFloat    := fltVPar06;
        FieldByName('GER_VPAR07').AsFloat    := fltVPar07;
        FieldByName('GER_VPAR08').AsFloat    := fltVPar08;
        FieldByName('GER_VPAR09').AsFloat    := fltVPar09;
        FieldByName('GER_VPAR10').AsFloat    := fltVPar10;
        FieldByName('GER_VPAR11').AsFloat    := fltVPar11;
        FieldByName('GER_VPAR12').AsFloat    := fltVPar12;
        FieldByName('GER_NOTESP').AsString   := strNotEsp;
        FieldByName('GER_CLAFIS').AsString   := IIF(Pos(strEspDoc, 'BR_PI_') > 0, '5999', strClaFis);
        FieldByName('GER_CLAFI2').AsString   := strClaFi2;
        FieldByName('GER_CLAFI3').AsString   := strClaFi3;
        FieldByName('GER_NATOPE').AsString   := strNatOpe;
        FieldByName('GER_PORDES').AsFloat    := fltPorDes;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('GER_CODDIG').Value := Null
        Else
          FieldByName('GER_CODDIG').AsString   := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('GER_CODCND').Value := Null
        Else
          FieldByName('GER_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('GER_CODFPG').Value := Null
        Else
          FieldByName('GER_CODFPG').AsString := strCodFpg;

        FieldByName('GER_FATNOT').AsFloat := fltFatNot;

        If (fEmptyStr(strCodS01)) Then
          FieldByName('GER_CODS01').Value := Null
        Else
          FieldByName('GER_CODS01').AsString := strCodS01;

        If (fEmptyStr(strCodS02)) Then
          FieldByName('GER_CODS02').Value := Null
        Else
          FieldByName('GER_CODS02').AsString := strCodS02;

        If (fEmptyStr(strCodS03)) Then
          FieldByName('GER_CODS03').Value := Null
        Else
          FieldByName('GER_CODS03').AsString := strCodS03;

        If (fEmptyStr(strCodS04)) Then
          FieldByName('GER_CODS04').Value := Null
        Else
          FieldByName('GER_CODS04').AsString := strCodS04;

        If (fEmptyStr(strCodS05)) Then
          FieldByName('GER_CODS05').Value := Null
        Else
          FieldByName('GER_CODS05').AsString := strCodS05;

        If (fEmptyStr(strCodS06)) Then
          FieldByName('GER_CODS06').Value := Null
        Else
          FieldByName('GER_CODS06').AsString := strCodS06;

        If (fEmptyStr(strDesS01)) Then
          FieldByName('GER_DESS01').Value := Null
        Else
          FieldByName('GER_DESS01').AsString := strDesS01;

        If (fEmptyStr(strDesS02)) Then
          FieldByName('GER_DESS02').Value := Null
        Else
          FieldByName('GER_DESS02').AsString := strDesS02;

        If (fEmptyStr(strDesS03)) Then
          FieldByName('GER_DESS03').Value := Null
        Else
          FieldByName('GER_DESS03').AsString := strDesS03;

        If (fEmptyStr(strDesS04)) Then
          FieldByName('GER_DESS04').Value := Null
        Else
          FieldByName('GER_DESS04').AsString := strDesS04;

        If (fEmptyStr(strDesS05)) Then
          FieldByName('GER_DESS05').Value := Null
        Else
          FieldByName('GER_DESS05').AsString := strDesS05;

        If (fEmptyStr(strDesS06)) Then
          FieldByName('GER_DESS06').Value := Null
        Else
          FieldByName('GER_DESS06').AsString := strDesS06;

        FieldByName('GER_VALS01').AsFloat   := fltValS01;
        FieldByName('GER_VALS02').AsFloat   := fltValS02;
        FieldByName('GER_VALS03').AsFloat   := fltValS03;
        FieldByName('GER_VALS04').AsFloat   := fltValS04;
        FieldByName('GER_VALS05').AsFloat   := fltValS05;
        FieldByName('GER_VALS06').AsFloat   := fltValS06;
        FieldByName('GER_PRAENT').AsInteger := intPraEnt;
        FieldByName('GER_TOTSER').AsFloat   := fltTotSer;
        FieldByName('GER_PERISS').AsFloat   := fltPerIss;
        FieldByName('GER_VALISS').AsFloat   := fltValIss;

        FieldByName('GER_DESACE').AsFloat   := fltDesAce;

        If (Not fEmptyStr(strOriDoc)) Then
          FieldByName('GER_ORIDOC').AsString := strOriDoc
        Else
          FieldByName('GER_ORIDOC').Value := Null;

        If (Not fEmptyStr(strOrdPro)) Then
          FieldByName('GER_ORDPRO').AsString := strOrdPro
        Else
          FieldByName('GER_ORDPRO').Value := Null;

        FieldByName('GER_CONENT').AsString  := strConEnt;
        FieldByName('GER_IMPRES').AsInteger := 0;
        FieldByName('GER_CODREP').AsString  := strCodRep;
        FieldByName('GER_VALROM').AsFloat   := 0.0;

        //************************************************//
        // ESSES CAMPOS REFERENTES A RETENÇÃO DE ALIQUOTA //
        //*********************************************MV*//
        FieldByName('GER_ALQIRF').AsFloat  := fltAlqIrf;
        FieldByName('GER_VALIRF').AsFloat  := fltValIrf;
        FieldByName('GER_ALQPIS').AsFloat  := fltAlqPis;
        FieldByName('GER_VALPIS').AsFloat  := fltValPis;
        FieldByName('GER_ALQCOF').AsFloat  := fltAlqCof;
        FieldByName('GER_VALCOF').AsFloat  := fltValCof;
        FieldByName('GER_ALQCSL').AsFloat  := fltAlqCsl;
        FieldByName('GER_VALCSL').AsFloat  := fltValCsL;

        FieldByName('GER_IRFRET').AsFloat  := fltIrfRet;
        FieldByName('GER_PISRET').AsFloat  := fltPisRet;
        FieldByName('GER_COFRET').AsFloat  := fltCofRet;
        FieldByName('GER_CSLRET').AsFloat  := fltCslRet;
        FieldByName('GER_NOTRET').AsString := strNotRet;

        FieldByName('GER_ALIRFP').AsFloat  := fltAlIrfP;
        FieldByName('GER_ALPISP').AsFloat  := fltAlPisP;
        FieldByName('GER_ALCOFP').AsFloat  := fltAlCofP;
        FieldByName('GER_ALCSLP').AsFloat  := fltAlCslP;

        FieldByName('GER_SERRET').AsFloat  := fltSerRet;
        FieldByName('GER_NORESE').AsString := strNoReSe;

        FieldByName('GER_PESGSO').AsFloat  := fltPeSgSo;
        FieldByName('GER_VLSGSO').AsFloat  := fltVlSgSo;

        FieldByName('GER_IRPRRT').AsFloat  := fltIrPrRt;
        FieldByName('GER_IRPRDV').AsFloat  := fltIrPrDv;
        FieldByName('GER_IRSERT').AsFloat  := fltIrSeRt;
        FieldByName('GER_IRSEDV').AsFloat  := fltIrSeDv;
        FieldByName('GER_PIPRRT').AsFloat  := fltPiPrRt;
        FieldByName('GER_PIPRDV').AsFloat  := fltPiPrDv;
        FieldByName('GER_PISERT').AsFloat  := fltPiSeRt;
        FieldByName('GER_PISEDV').AsFloat  := fltPiSeDv;
        FieldByName('GER_COPRRT').AsFloat  := fltCoPrRt;
        FieldByName('GER_COPRDV').AsFloat  := fltCoPrDv;
        FieldByName('GER_COSERT').AsFloat  := fltCoSeRt;
        FieldByName('GER_COSEDV').AsFloat  := fltCoSeDv;
        FieldByName('GER_CSPRRT').AsFloat  := fltCsPrRt;
        FieldByName('GER_CSPRDV').AsFloat  := fltCsPrDv;
        FieldByName('GER_CSSERT').AsFloat  := fltCsSeRt;
        FieldByName('GER_CSSEDV').AsFloat  := fltCsSeDv;

        FieldByName('GER_BASORG').AsFloat  := fltBasOrg;
        FieldByName('GER_ICMORG').AsFloat  := fltIcmOrg;

        If (intNConhe = -1) Then
          FieldByName('GER_NCONHE').Value := Null
        Else
          FieldByName('GER_NCONHE').AsInteger:= intNConhe;

        FieldByName('GER_CONSUM').AsString   := strConsum;
        FieldByName('GER_ENTFAT').AsString   := strEntFat;
        FieldByName('GER_CLIFAT').AsString   := strCliFat;

        FieldByName('GER_OPEEXP').AsString   := strOpeExp;
        If fEmptyStr(strOpeExp) Then
          FieldByName('GER_OPEEXP').Clear;

        FieldByName('GER_SEPEXP').AsString   := strSepExp;
        If fEmptyStr(strSepExp) Then
          FieldByName('GER_SEPEXP').Clear;

        FieldByName('GER_TABPRE').AsString   := strTabPre;

        FieldByName('GER_NUM_PR').AsString   := strNum_Pr;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('GER_ENTFUT').AsString   := strEntFut;

        If blnBaiFut Then
        Begin
          FieldByName('GER_OPLBRC').AsString   := '999';
          FieldByName('GER_DTLBRC').AsDateTime := VS_Date;
          FieldByName('GER_HRLBRC').AsDateTime := fTime();
        End;

        FieldByName('GER_MARGEM').AsFloat := fltMargem;

        FieldByName('GER_BARTSP').AsFloat := fltBaRtSp;
        FieldByName('GER_VLRTSP').AsFloat := fltVlRtSp;

        FieldByName('GER_OPRFLJ').AsString := strOprFlj;

        FieldByName('GER_DTALAN').AsDateTime := VS_Date;

        FieldByName('GER_NUMREG').AsString  := strNumReg;
        FieldByName('GER_DTENTR').AsDateTime := dtaDtEntr;

        FieldByName('GER_NROCEI').AsString := strNroCEI;
        FieldByName('GER_CLAFI4').AsString := strClaFi4;

        FieldByName('GER_AUTSER').AsString := strAutSer;

        If fEmptyStr(strCodEve) Then
          FieldByName('GER_CODEVE').Value := Null
        Else
          FieldByName('GER_CODEVE').AsString := strCodEve;

//        FieldByName('GER_CODOCO').AsString := strCodOco;

        If dtadtlBex > 0 Then
          FieldByName('GER_DTLBEX').AsDateTime := dtadtlBex;

        Post;

        pIncluiAuxMov(strNomeTabela,
                      strAutInc,
                      strAutEnt,
                      fltValCre);

      //  If Assigned(objFinanc) Then
      //    TFinanceira(objFinanc).fGravaFinanciamento(strNomeTabela, strAutInc);
      End;

      qryTblMovObs := fCriaQuery;

      qryTblMovObs.SQL.Add('SELECT * FROM ' + strTblMovObs + ' WHERE FALSE');
      qryTblMovObs.Open;
      qryTblMovObs.Append;
      qryTblMovObs.FieldByName('MOV_SEQGER').AsString  := strAutInc;
      qryTblMovObs.FieldByName('MOV_OBSERV').AsString  := strObsNfe;
      qryTblMovObs.FieldByName('MOV_IPDPNF').AsInteger := IIF(blnIpDpNf, 1, 0);

      If (dtaDtESNf > 0) And blnSolDtaEntSaiNfe Then
      Begin
        qryTblMovObs.FieldByName('MOV_DTESNF').AsDateTime := dtaDtESNf;
        qryTblMovObs.FieldByName('MOV_HRESNF').AsDateTime := tmrHrESNf;
      End;

      qryTblMovObs.Post;

      fCommit;

      FreeAndNil(qryTblMovObs);

    Except
      On E: Exception Do
      Begin
        qryTblMovGer.Cancel;
        fRollBack;
        pMensagensErro(E.Message, '[fGravaMovGer]');
        Result := False;
      End;
    End;

    strSQLMovGer := qryTblMovGer.SQL.GetText;

  Finally
    FreeAndNil(qryTblMovGer);
  End;

End;

{*****************************************}
{* =============> ANTEÇÃO <============= *}
{* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
{* RECOMPILAR O AUTCOMTINTA.DLL          *}
{**************************************MV*}
function fGravaMovDet(strNomeTabela: String;
                      Var strAutInc: String;
                      strSeqGer: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodIte,
                      strCodVen,
                      strCodDiv,
                      strCodMar,
                      strCodFor,
                      strCodCli: String;
                      dtaDtaEnt,
                      dtaHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strTip_Fc,
                      strEstado,
                      strDescri,
                      strRefere,
                      strUnidad,
                      strForIte: String;
                      fltQtdIte,
                      fltUnitar,
                      fltUniOri,
                      fltTotIte,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep,
                      strCodVe2: String;
                      fltPerCom,
                      fltTotCom,
                      fltTotCo2: Double;
                      strClaFis,
                      strCodFis: String;
                      fltValIpi,
                      fltAlqIpi,
                      fltBasIpi,
                      fltValIcm,
                      fltAlqIcm,
                      fltBasIcm,
                      fltValRet,
                      fltAlqRet,
                      fltBasRet,
                      fltTotPes,
                      fltPerBas,
                      fltPerRed: Double;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat: Double;
                      strIdePro,
                      strIncPis,
                      strSerie: String;
                      fltDesAce: Double;
                      strNotEsp,
                      strDocDev,
                      strEspDev,
                      strEmpDev,
                      strIteCha,
                      strIteTin,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre: String;
                      fltPrvTin,
                      fltPrcTin,
                      fltFatTin: Double;
                      strProEmb,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strIteEmb,
                      strGruEmb: String;
                      intLazQua: Integer;
                      strPromoc,
                      strSeqTin: String;
                      fltQtdPul: Double;
                      strPedCom,
                      strOriDoc,
                      strNum_Pd,
                      strEsp_Pd,
                      strEmp_Pd: String;
                      intInd_Pd: Integer;
                      strOrdPro,
                      strDesNes,
                      strCliFat: String;
                      fltBcaMin,
                      fltBcaCom,
                      fltVolPro: Double;
                      strCodAca,
                      strEmpAca: String;
                      blnProAca,
                      blnFilKar: Boolean;
                      strEspFut,
                      strDocFut,
                      strEmpFut,
                      strTabPre,
                      strEmpCom: String;
                      strLinha: String;
                      strCatali: String;
                      strCodDil: String;
                      fltPorDil: Double;
                      strDilCon: String;
                      fltPorCat: Double;
                      fltUniDig: Double;
                      intQtdPon: Integer;
                      strEntFut,
                      strMotFut: String;
                      dtaDtaFut: TDateTime;
                      fltTotCu2: Double;
                      fltComRep,
                      fltPerRep: Double;
                      strKey_EP,
                      strNumLot,
                      strPigBas: String;
                      fltVaEIpi,
                      fltAlEIpi,
                      fltBaEIpi,
                      fltTotUlt,
                      fltBaRtSP,
                      fltVaRtSP,
                      fltIcOpPr: Double;
                      intSeqCcr: Integer): Boolean;
  Var
    qryTblMovDet: TUniQuery;
    qryTblMovTri: TUniQuery;
Begin

  Result := True;

  Try
    qryTblMovDet := fCriaQuery(nil);
    qryTblMovDet.Close;
    qryTblMovDet.SQL.Clear;
    qryTblMovDet.SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
    qryTblMovDet.Open;

    qryTblMovTri := fCriaQuery(nil);
    qryTblMovTri.Close;
    qryTblMovTri.SQL.Clear;
    qryTblMovTri.SQL.Add('SELECT * FROM MOVTRI' + IIF(strNomeTabela = 'MOVDET', '', 'X') + ' WHERE FALSE');
    qryTblMovTri.Open;

    Try

      fStartTransaction;

      //strAutInc := fRetAutoIncrem(strNomeTabela, strCodEmp);

      {*******************************************}
      {* QUANDO VAI GRAVAR O ITEM BASE DA TINTA  *}
      {* TIPO 2, PASSA O TIPTIN (TIPTIN = 2), P/ *}
      {* INDICAR QUE DEVE SER GRAVADO O AUTINC   *}
      {* NO SEQTIN                               *}
      {****************************************MV*}
      If (strSeqTin = '2') Then
      Begin
        strSeqTin := strAutInc;
      End;

      With qryTblMovDet Do
      Begin
        Insert;
        FieldByName('DET_SEQGER').AsString   := strSeqGer;
        FieldByName('DET_NUMDOC').AsString   := strNumDoc;
        FieldByName('DET_ESPDOC').AsString   := strEspDoc;
        FieldByName('DET_CODEMP').AsString   := strCodEmp;
        FieldByName('DET_CODITE').AsString   := strCodIte;

        If fEmptyStr(strCodDiv) Then
          FieldByName('DET_CODDIV').Value      := Null
        Else
          FieldByName('DET_CODDIV').AsString   := strCodDiv;

        If fEmptyStr(strCodMar) Then
          FieldByName('DET_CODMAR').Value      := Null
        Else
          FieldByName('DET_CODMAR').AsString   := strCodMar;

        If fEmptyStr(strCodFor) Then
          FieldByName('DET_CODFOR').Value      := Null
        Else
          FieldByName('DET_CODFOR').AsString   := strCodFor;

        If fEmptyStr(strCodCli) Then
          FieldByName('DET_CODCLI').Value      := Null
        Else
          FieldByName('DET_CODCLI').AsString   := strCodCli;

        FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;
        FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;
        FieldByName('DET_DTADOC').AsDateTime := dtaDtaDoc;
        FieldByName('DET_CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
        FieldByName('DET_TIP_FC').AsString   := strTip_Fc;
        FieldByName('DET_ESTADO').AsString   := strEstado;
        FieldByName('DET_DESCRI').AsString   := strDescri;
        FieldByName('DET_REFERE').AsString   := strRefere;
        FieldByName('DET_UNIDAD').AsString   := strUnidad;
        FieldByName('DET_FORITE').AsString   := strForIte;
        FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
        FieldByName('DET_UNITAR').AsFloat    := fltUnitar;
        FieldByName('DET_UNIORI').AsFloat    := fltUniOri;
        FieldByName('DET_UNIDIG').AsFloat    := fltUniDig;
        FieldByName('DET_TOTITE').AsFloat    := fltTotIte;
        FieldByName('DET_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('DET_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('DET_TOTMED').AsFloat    := fltTotMed;
        FieldByName('DET_DESCON').AsFloat    := fltDesCon;
        FieldByName('DET_TOTFRE').AsFloat    := fltTotFre;
        FieldByName('DET_DESESP').AsFloat    := fltDesEsp;
        FieldByName('DET_CODREP').AsString   := strCodRep;

        If fEmptyStr(strCodVe2) Then
          FieldByName('DET_CODVE2').AsVariant := Null
        Else
          FieldByName('DET_CODVE2').AsString := strCodVe2;

        FieldByName('DET_PERCOM').AsFloat    := fltPerCom;
        FieldByName('DET_TOTCOM').AsFloat    := fltTotCom;
        FieldByName('DET_TOTCO2').AsFloat    := fltTotCo2;
        FieldByName('DET_CLAFIS').AsString   := strClaFis;
        FieldByName('DET_CODFIS').AsString   := strCodFis;
        FieldByName('DET_VALIPI').AsFloat    := fltValIpi;
        FieldByName('DET_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('DET_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('DET_VALICM').AsFloat    := fltValIcm;
        FieldByName('DET_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('DET_BASICM').AsFloat    := fltBasIcm;
        FieldByName('DET_VALRET').AsFloat    := fltValRet;
        FieldByName('DET_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('DET_BASRET').AsFloat    := fltBasRet;
        FieldByName('DET_TOTPES').AsFloat    := fltTotPes;
        FieldByName('DET_PERBAS').AsFloat    := fltPerBas;
        FieldByName('DET_PERRED').AsFloat    := fltPerRed;

        If blnJaFatu Then
          FieldByName('DET_JAFATU').AsInteger  := 1
        Else
          FieldByName('DET_JAFATU').AsInteger  := 0;

        FieldByName('DET_TIPFAT').AsString   := strTipFat;
        FieldByName('DET_NUMFAT').AsString   := strNumFat;
        if fEmptyStr(strNumFat) Then
          strEmpFat := '';
        FieldByName('DET_EMPFAT').AsString   := strEmpFat;

        If (dtaDtaFat = 0) Then
          FieldByName('DET_DTAFAT').Value      := Null
        Else
          FieldByName('DET_DTAFAT').AsDateTime := dtaDtaFat;

        FieldByName('DET_VENFAT').AsString   := strVenFat;
        FieldByName('DET_CNDFAT').AsString   := strCndFat;
        FieldByName('DET_VALFAT').AsFloat    := fltValFat;
        FieldByName('DET_IDEPRO').AsString   := strIdePro;
        FieldByName('DET_INCPIS').AsString   := strIncPis;
        FieldByName('DET_SERIE_').AsString   := strSerie;
        FieldByName('DET_DESACE').AsFloat    := fltDesAce;
        FieldByName('DET_NOTESP').AsString   := strNotEsp;

        If (fEmptyStr(strDocDev)) Then
          FieldByName('DET_DOCDEV').Value    := Null
        Else
          FieldByName('DET_DOCDEV').AsString := strDocDev;

        If (fEmptyStr(strEspDev)) Then
          FieldByName('DET_ESPDEV').Value    := Null
        Else
          FieldByName('DET_ESPDEV').AsString := strEspDev;

        If (fEmptyStr(strEmpDev)) Then
          FieldByName('DET_EMPDEV').Value    := Null
        Else
          FieldByName('DET_EMPDEV').AsString := strEmpDev;

        FieldByName('DET_ITECHA').AsString   := strIteCha;
        FieldByName('DET_ITETIN').AsString   := strIteTin;
        FieldByName('DET_DESCOR').AsString   := strDesCor;

        FieldByName('DET_TIPEMB').AsString   := strTipEmb;
        FieldByName('DET_QTDEMB').AsFloat    := fltQtdEmb;
        FieldByName('DET_PREEMB').AsFloat    := fltPreEmb;
        FieldByName('DET_TIPPRE').AsString   := strTipPre;
        FieldByName('DET_PRVTIN').AsFloat    := fltPrvTin;
        FieldByName('DET_PRCTIN').AsFloat    := fltPrcTin;
        FieldByName('DET_FATTIN').AsFloat    := fltFatTin;
        FieldByName('DET_PROEMB').AsString   := strProEmb;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('DET_CODDIG').Value := Null
        Else
          FieldByName('DET_CODDIG').AsString   := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('DET_CODCND').Value := Null
        Else
          FieldByName('DET_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('DET_CODFPG').Value := Null
        Else
          FieldByName('DET_CODFPG').AsString   := strCodFpg;

        FieldByName('DET_ITEEMB').AsString  := strIteEmb;
        FieldByName('DET_LAZQUA').AsInteger := intLazQua;

        FieldByName('DET_PROMOC').AsString  := strPromoc;
        FieldByName('DET_SEQTIN').AsString  := strSeqTin;
        FieldByName('DET_QTDPUL').AsFloat   := fltQtdPul;

        If (fEmptyStr(strPedCom)) Then
          FieldByName('DET_PEDCOM').Value := Null
        Else
          FieldByName('DET_PEDCOM').AsString := strPedCom;

        If (fEmptyStr(strOriDoc)) Then
          FieldByName('DET_ORIDOC').Value := Null
        Else
          FieldByName('DET_ORIDOC').AsString := strOriDoc;

        If (Not fEmptyStr(strOrdPro)) Then
          FieldByName('DET_ORDPRO').AsString := strOrdPro
        Else
          FieldByName('DET_ORDPRO').Value := Null;

        FieldByName('DET_QTDROM').AsFloat  := 0.0;

        FieldByName('DET_NUM_PD').AsString  := strNum_Pd;
        FieldByName('DET_ESP_PD').AsString  := strEsp_Pd;
        FieldByName('DET_EMP_PD').AsString  := strEmp_Pd;
        FieldByName('DET_IND_PD').AsInteger := intInd_Pd;

        FieldByName('DET_TMPGAR').AsInteger := fRetTempoGarantia(strCodIte, strClaFis);

        FieldByName('DET_DESNES').AsString := strDesNes;
        FieldByName('DET_CLIFAT').AsString := strCliFat;
        FieldByName('AUTOINCREM').AsString := strAutInc;

        FieldByName('DET_CODVEN').AsString := IIF(fEmptyStr(strCodVen), '998', strCodVen);
        FieldByName('DET_BCAMIN').AsFloat  := fltBcaMin;
        FieldByName('DET_BCACOM').AsFloat  := fltBcaCom;
        FieldByName('DET_VOLPRO').AsFloat  := fltVolPro;

        If fEmptyStr(strCodAca) Then
          FieldByName('DET_CODACA').Value := Null
        Else
          FieldByName('DET_CODACA').AsString := strCodAca;

        If fEmptyStr(strEmpAca) Then
          FieldByName('DET_EMPACA').Value := Null
        Else
          FieldByName('DET_EMPACA').AsString := strEmpAca;

        FieldByName('DET_PROACA').AsString  := IIF(blnProAca, 'S', 'N');
        FieldByName('DET_FILKAR').AsInteger := IIF(blnFilKar, 1, 0);

        FieldByName('DET_DOCFUT').AsString   := strDocFut;
        FieldByName('DET_ESPFUT').AsString   := strEspFut;
        FieldByName('DET_EMPFUT').AsString   := strEmpFut;

        If fEmptyStr(strDocFut) Then
          FieldByName('DET_DOCFUT').Clear;
        If fEmptyStr(strEspFut) Then
          FieldByName('DET_ESPFUT').Clear;
        If fEmptyStr(strEmpFut) Then
          FieldByName('DET_EMPFUT').Clear;

        FieldByName('DET_TABPRE').AsString   := strTabPre;

        If Not fEmptyStr(strEmpCom) Then
          FieldByName('DET_EMPCOM').AsString := strEmpCom
        Else
          FieldByName('DET_EMPCOM').Value := Null;


        {***************************************************}
        {* CAMPOS USADOS PARA DINTAS COM DILUIÇÃO DINAMICA *}
        {************************************************PH*}
        FieldByName('DET_LINLIN').AsString  := strLinha;
        FieldByName('DET_CATALI').AsString  := strCatali;
        FieldByName('DET_CODDIL').AsString  := strCodDil;
        FieldByName('DET_PORDIL').AsFloat   := fltPorDil;
        FieldByName('DET_DILCON').AsString  := strDilCon;
        FieldByName('DET_PORCAT').AsFloat   := fltPorCat;

        FieldByName('DET_QTDPON').AsInteger := IntQtdPon;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('DET_ENTFUT').AsString := strEntFut;
        FieldByName('DET_MOTFUT').AsString := strMotFut;

        If dtaDtaFut = 0 Then
          FieldByName('DET_DTAFUT').Value := Null
        Else
          FieldByName('DET_DTAFUT').AsDateTime := dtaDtaFut;

        FieldByName('DET_TOTCU2').AsFloat   := fltTotCu2;

        FieldByName('DET_COMREP').AsFloat    := fltComRep;
        FieldByName('DET_PERREP').AsFloat    := fltPerRep;

        FieldByName('DET_KEY_EP').AsString   := strKey_EP;
        FieldByName('DET_NUMLOT').AsString   := strNumLot;

        If fEmptyStr(strNumLot) Then
          FieldByName('DET_NUMLOT').Clear;

        FieldByName('DET_PIGBAS').AsString := strPigBas;

        Post;

      End;

      With qryTblMovTri Do
      Begin
        Append;

        FieldByName('DET_SEQGER').AsString := strAutInc;
        FieldByName('DET_BARTSP').AsFloat  := fltBaRtSP;
        FieldByName('DET_VLRTSP').AsFloat  := fltVaRtSP;
        FieldByName('DET_ICOPPR').AsFloat  := fltIcOpPr;
        FieldByName('DET_VAEIPI').AsFloat  := fltVaEIpi;
        FieldByName('DET_ALEIPI').AsFloat  := fltAlEIpi;
        FieldByName('DET_BAEIPI').AsFloat  := fltBaEIpi;
        FieldByName('DET_TOTULT').AsFloat  := fltTotUlt;

        If intSeqCcr > 0 Then
          FieldByName('DET_SEQCCR').AsInteger := intSeqCcr;

        Post;
      End;

      fCommit;

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryTblMovDet.Cancel;
        fRollBack;
        pMensagensErro(E.Message, '[fGravaMovDet]');
      End;
    End;

  Finally
    FreeAndNil(qryTblMovDet);
    FreeAndNil(qryTblMovTri);
  End;

End;

procedure pIncluiAuxMov(strNomTab,
                        strAutInc,
                        strAutEnt: String;
                        fltValCre: Double);
  Var
    qryAuxGer: TUniQuery;
Begin
  qryAuxGer := fCriaQuery(Nil);

  With qryAuxGer, SQL Do
  Begin
    Add('SELECT * FROM ');

    If SameText(strNomTab, 'MOVGER') Then
      Add('AUXMOV')
    Else
      Add('AUXMOVX');

    Add('WHERE FALSE');

    Open;
    qryAuxGer.Insert;

    FieldByName('AUX_SEQGER').AsString := strAutInc;

    If Not fEmptyStr(strAutEnt) Then
      FieldByName('AUX_ENTGER').AsString := strAutEnt;

    FieldByName('AUX_VALCRE').AsFloat := fltValCre;

    Post;

  End;

  FreeAndNil(qryAuxGer);
End;

{*******************************************}
{* RETORNA O TEMPO DE GARANTIA DO PRODUTO  *}
{****************************************RL*}
function fRetTempoGarantia(strCodIte, strClaFis: String): Integer;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  Result := 0;

  If (Not fCfgSis('GARANT', varBoolean)) Or (Pos(strClaFis, VS_strClaVen) = 0) Then
    Exit;

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_TMPGAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADITE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODITE').AsString := strCodIte;
    Open;

    Result := FieldByName('ITE_TMPGAR').AsInteger;

    Close;
  End;

  FreeAndNil(qryTmp);


End;

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

function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

function fReplicaString(strCaracter : String; intQuantidade: Integer): string;
  Var
    strRetorno : String;
    intContador: Integer;

begin

  strRetorno := '';

  For intContador := 1 To intQuantidade Do
  Begin
    strRetorno := strRetorno + strCaracter;
  End;

  Result := strRetorno;

end;

{*****************************************}
{* VERIFICA SE A TABELA EXISTE NO BANCO  *}
{* ATUAL.                                *}
{**************************************MV*}
function fTabelaExiste(strNomeTabela: String): Boolean;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

Begin
  qryGenTmp := fCriaQuery;

  Try

    If (fEmptyStr(strNomeTabela)) Then
    Begin
      Result := False;
      Exit;
    End;

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

  FreeAndNil(qryGenTmp);

End;

function fRetNotaImportada(strNumDoc, strEspDoc, strSerie, strForCli, strTipFc, strCodEmp: String): boolean;
  Var
    qryAux: TUniQuery;
    blnResult: Boolean;

  procedure pCarregaDadosNotaImportada(qryAux: TUniQuery; strTabela: String);
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  COUNT(1) AS QTDE ');
    qryAux.SQL.Add('FROM ');

    qryAux.SQL.Add(strTabela);

    If fCfgSis('IMPDIG') = '1' Then
    Begin
      qryAux.SQL.Add('  INNER JOIN CADITE ');
      qryAux.SQL.Add('     ON ITE_CODITE = DET_CODITE ');
    End
    Else
    Begin
      qryAux.SQL.Add('  INNER JOIN ITEGER ');
      qryAux.SQL.Add('     ON ITE_CODITE = DET_CODITE ');
      qryAux.SQL.Add('    AND ITE_CODEMP = DET_CODEMP ');
    End;

    qryAux.SQL.Add('WHERE DET_NUMDOC = :NUMDOC ');
    qryAux.SQL.Add('  AND DET_ESPDOC = :ESPDOC ');
    qryAux.SQL.Add('  AND DET_SERIE_ = :SERIE ');
    qryAux.SQL.Add('  AND DET_CODEMP = :CODEMP ');

    If UpperCase(strTipFc) = 'C' Then
      qryAux.SQL.Add('  AND DET_CODCLI = :FORCLI')
    Else
      qryAux.SQL.Add('  AND DET_CODFOR = :FORCLI');

    qryAux.SQL.Add('  AND ITE_IMPDIR = "S" ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('SERIE').AsString := strSerie;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('FORCLI').AsString := strForCli;
    qryAux.Open;
  end;
begin
  blnResult := False;

  qryAux := fCriaQuery(Nil);
  Try
    pCarregaDadosNotaImportada(qryAux, 'MOVDET');

    If qryAux.FieldByName('QTDE').AsInteger > 0 Then
      blnResult := True;

    pCarregaDadosNotaImportada(qryAux, 'NOTDET');

    If qryAux.FieldByName('QTDE').AsInteger > 0 Then
      blnResult := True;

    Result := blnResult;
  Finally
    qryAux.Free;
  End;
end;

function fRetNotaImportadaF(qryNFImport: TUniQuery; strNumDoc, strEspDoc,
  strSerie, strForCli, strTipFc, strCodEmp: String): boolean;
begin
  //# qryNFImport.IndexFieldNames := 'DET_NUMDOC; DET_ESPDOC; DET_SERIE_; DET_FORCLI';
  qryNFImport.Filter := ' DET_NUMDOC = ' + QuotedStr(strNumDoc)
                       + ' AND DET_ESPDOC = ' + QuotedStr(strEspDoc)
                       + ' AND DET_SERIE_ = ' + QuotedStr(strSerie)
                       + ' AND DET_FORCLI = ' + QuotedStr(strForCli);
  qryNFImport.Filtered := True;

  Result := False;
  If qryNFImport.FieldByName('QTDE').AsInteger > 0 Then
    Result := True;
end;

function fEhFeriado(dtaDta: TDateTime): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CADFER WHERE FER_DTAFER = :DTAFER ');
  qryAux.ParamByName('DTAFER').AsDateTime := dtaDta;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

function fDiaDeFolga(dtaDta: TDateTime): Boolean;
  Const
    SABADO = 7;
    DOMINGO = 1;
begin
  Result := (DayOfWeek(dtaDta) In [DOMINGO,SABADO]) Or
            (fEhFeriado(dtaDta));
end;

function fAcertaDataParaDiaUtil(Const dtaOrigem: TDateTime): TDateTime;
begin
  Result := dtaOrigem;
  While (fDiaDeFolga(Result)) Do
  Begin
    Result := Result + 1;
  End;
end;

procedure pZeraDuplicata(Var arrDuplicata: TArrDigDuplic);
Begin
  With arrDuplicata Do
  Begin
	  intNumDup := 0;
    strSequen := '';
		dtaDtaVen := '';
  	curValor  := 0;
  End;
End;

function fDigDuplic(Var arrDuplicata: TArrDigDuplicArray;
                    Var intQtdDup: Integer;
                    strCndPag: String;
                    intNumDoc: Integer;
                    curTotal: Currency;
                    dtaDtaBas: TDateTime;
                    blnDupsRedondas: Boolean = True;
                    blnSabDomFeriadoDiasUteis: Boolean = True): Boolean;
	Const
  	arrLetra : Array[0..11] Of Char = ('A','B','C','D','E','F','G','H','I','J','K','L');
  Var
  	intIndice : Integer;
    strAux    : String;
    intCont   : Integer;
    fltValPar : Currency;
    dtaRef    : TDateTime;
begin

  Result := True;

  SetLength(arrDuplicata, 12);

	For intCont := Low(arrDuplicata) To High(arrDuplicata) Do
    pZeraDuplicata(arrDuplicata[intCont]);

	intCont := 0;

  strCndPag := fTiraCaracEspeciais(strCndPag);
	intQtdDup := StrToIntDef(Copy(strCndPag,0,2), 0);

  If fEmptyStr(strCndPag) Or (intQtdDup = 0) Then
  Begin
    intQtdDup := 0;
    Exit;
  End;

  SetLength(arrDuplicata, intQtdDup);

	strAux := Copy(strCndPag, 3, Length(strCndPag)-1);
  strAux := AnsiReplaceStr(strAux, '.', '');
  intIndice := 1;

	While intCont <= intQtdDup -1 Do
  Begin
  	arrDuplicata[intCont].intNumDup := intNumDoc;
    arrDuplicata[intCont].strSequen := arrLetra[intCont];
		arrDuplicata[intCont].dtaDtaVen := FormatDateTime('DD/MM/YYYY',(dtaDtaBas + StrToIntDef(Copy(strAux,intIndice,3),0)));
    Inc(intCont);
		intIndice := intIndice + 3;
  End;

  If intQtdDup = 1 Then
  Begin
  	arrDuplicata[0].curValor := curTotal;
  End
  Else
  Begin

    If (blnDupsRedondas) Then
    Begin
      If Int(curTotal / intQtdDup) < 1 Then
        blnDupsRedondas := False;
    End;

    If (blnDupsRedondas) And (curTotal > 1) Then
    Begin

      arrDuplicata[0].curValor := Int(curTotal / intQtdDup);
      arrDuplicata[0].curValor := (arrDuplicata[0].curValor + ( curTotal - arrDuplicata[0].curValor * intQtdDup ));

      For intIndice := 1 To intQtdDup - 1 Do
      Begin
        arrDuplicata[intIndice].curValor := Int(curTotal / intQtdDup);
      End;

    End
    Else
    Begin

      fltValPar := fFormataFloat(curTotal / intQtdDup, 2);
      arrDuplicata[0].curValor := fltValPar;
      If (fltValPar * intQtdDup < curTotal) Then
      Begin
        arrDuplicata[0].curValor := fltValPar + (curTotal - (fltValPar * intQtdDup));
      End;

      For intIndice := 1 To intQtdDup -1 Do
      Begin
        arrDuplicata[intIndice].curValor := fltValPar;

        If (intIndice = intQtdDup -1) Then
        Begin

          If (fltValPar * intQtdDup > curTotal) Then
          Begin
            arrDuplicata[intIndice].curValor := fltValPar + (curTotal - (fltValPar * intQtdDup));
          End;

        End;

      End;

    End;

  End;

  If Not blnSabDomFeriadoDiasUteis Then
  Begin

    For intCont := Low(arrDuplicata) To High(arrDuplicata) Do
    Begin

      If ( ( Not fEmptyStr( arrDuplicata[intCont].dtaDtaVen )    ) And
           (StrToDate(arrDuplicata[intCont].dtaDtaVen) <> VS_Date) ) Then
      Begin
        dtaRef := StrToDate(arrDuplicata[intCont].dtaDtaVen);
        dtaRef := fAcertaDataParaDiaUtil(dtaRef);
        arrDuplicata[intCont].dtaDtaVen := DateToStr(dtaRef);
      End;

    End;

  End;

end;

procedure pZapTable(strTabela: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('TRUNCATE TABLE ' + strTabela);
  qryAux.ExecSQL;
  FreeAndNil(qryAux);
end;

function fHabilitarForeignKey(blnHabilitar: Boolean): Boolean;
  Var
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    Try

      With qryGenTmp Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add('SET FOREIGN_KEY_CHECKS=' + IIF(blnHabilitar, '1', '0'));
        ExecSQL;
        Close;
        Result := True;

      End;

    Except
      On E: Exception Do
      Begin

        Result := False;
        pMensagensErro(E.Message, '[fHabilitarForeignKey]');

      End;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function fAtualizaProCod(strNomeTabela: String): String;
  Var
    strSQL        : String;
    intCodigoAtual: Int64;
    intTamCodigo  : Integer;
    blnComita     : Boolean;
    qryGenCod     : TUniQuery;
    intContador   : integer;

begin
  blnComita := True;

  pValidaProCod(strNomeTabela);

  qryGenCod := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  PRO_CODSEQ AS CODSEQ, ';
    strSQL := strSQL + '  PRO_TAMCOD AS TAMCOD ';
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
          If (strNomeTabela = arrProCod[intContador].strNomArq) Then
          Begin
            SQL.Clear;
            SQL.Add('SELECT * FROM PROCOD');
            Open;
            Insert;
            FieldByName('PRO_NOMARQ').AsString  := arrProCod[intcontador].strNomArq;
            FieldByName('PRO_CODSEQ').AsString  := arrProCod[intcontador].strCodSeq;
            FieldByName('PRO_TAMCOD').AsInteger := arrProCod[intcontador].intTamCod;
            FieldByName('PRO_AUTINC').AsInteger := arrProCod[intcontador].intAutInc;
            FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('PROCOD',VS_strCodEmp);
            FieldByName('PRO_CODEMP').AsString  := VS_strCodEmp;
            FieldByName('PRO_CODAUT').AsString  := 'S';
            Post;
            Close;

            If fTabelaExiste('PROINC') Then
            Begin
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
            End;

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
      Close;
    End;

  Except
    On E: Exception Do
    Begin
      If blnComita Then
        fRollBack;

      Raise Exception.Create(E.Message + 'Não consegui pegar o proximo sequencial. Tente novamente!');
    End;
  End;

  Result := fPadL(IntToStr(intCodigoAtual), intTamCodigo, '0');

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  PROCOD ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  PRO_CODSEQ = :CODSEQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  PRO_NOMARQ = :NOMARQ ';

  With qryGenCod Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODSEQ').AsString := fPadL(IntToStr(intCodigoAtual+1), intTamCodigo, '0');
    ParamByName('NOMARQ').AsString := strNomeTabela;
    ExecSQL;
    Close;
  End;

  FreeAndNil(qryGenCod);

//  fLock_Unlock('PROCOD', False);
end;

function fRetTamCampo(strNomeTabela: String): Integer;
  Var
    strSQL   : String;
    qryGenCod: TUniQuery;

begin
  qryGenCod := fCriaQuery;
  Try
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

{*****************************************}
{* VERIFICA SE A STRING É UM NUMERO      *}
{**************************************MV*}
function fIsNumber(Const strNumber: String): Boolean;
  Var
    Code: Integer;
    E: Integer;
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

{*****************************************}
{* VERIFICA SE DETERMINADA STRING CONTEM *}
{* ALGUM DOS CARACTERES DE PESQUISA      *}
{**************************************MV*}
function fEntraCons(strCodigo: String): Boolean;
begin
  Result := (Pos('/', strCodigo) > 0) Or (Pos('?', strCodigo) > 0);
end;

{***********************************************}
{* RETORNA O NOME DA LINHA OU GRUPO CADASTRADO *}
{********************************************AF*}
function fRetNomeConta(strCodCta: String): String;
  Var
    strSQL   : String;
    qryGenCta: TUniQuery;

Begin
  Try

    qryGenCta := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
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
{$IFDEF MSWINDOWS}
{*****************************************}
{* CHAMA A TELA DE CONSULTA SIMPLES      *}
{**************************************MV*}
function pConsultaRapida(Sender: TForm; qryTabela: TUniQuery; strNomeTabela: String;
  stlIndice, stlDesInd, stlCampos: TStringList; blnUsaSqlTabela: boolean = false; strOrderOpc: String = ''; strCaption: String = ''): Boolean;
  Var
    strFormTabela: String;
Begin
  Result := False;

  strFormTabela := Sender.Name + strNomeTabela;

  pCriarFormularios(TfrmConsulta, frmConsulta);
  try
    try
      frmConsulta.Caption := strCaption;

      if blnUsaSqlTabela then
        frmConsulta.strUltSelect := qryTabela.SQL.Text;

      frmConsulta.strOrderOpc := strOrderOpc;
      frmConsulta.strNomTabela:= strNomeTabela;
      frmConsulta.qryTabConsulta := qryTabela;

      frmConsulta.pConsulta(stlIndice, stlDesInd, stlCampos);

      Result := frmConsulta.blnConfirma;
    except
      on e: Exception do
      begin
        pMensagensErro(E.Message,'[FuncoesSimples.pConsultaRapida]');
      end;
    end;
  finally
    pFreeAndNil(frmConsulta);
  end;


End;
{$ENDIF}
function fCadEmp(strNomCampo: String; qryGenEmp: TUniQuery; strEmpresa: String=''): String;
  Var
    strSQL   : String;
    strCodEmp: String;
begin
  Try
    strCodEmp := VS_strCodEmp;
    If Not fEmptyStr(strEmpresa) Then
      strCodEmp := strEmpresa;

    strSQL := '';
    strSQL := strSQL + 'SELECT  ';
    strSQL := strSQL + '  CADEMP.*, ';
    strSQL := strSQL + '  CID_NOMCID AS "EMP_NOMCID", ';
    strSQL := strSQL + '  CID_ESTADO AS "EMP_ESTADO" ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP, ';
    strSQL := strSQL + '  CADCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODCID = CID_CODCID AND ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

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

function fCadEmp(strNomCampo: String; strEmpresa: String = ''): String;
  Var
    qryGenEmp: TUniQuery;
begin
  try
    qryGenEmp := fCriaQuery;
    qryGenEmp.Close;

    Result := fCadEmp(strNomCampo, qryGenEmp, strEmpresa);

    qryGenEmp.Close;

  finally
    FreeAndNil(qryGenEmp);
  end;
end;

function fRetornaValorAbfPisCofins(strCodAbf, strPisCofins: String;
  fltBase: Double; strCfop: String; Var fltAlqPisCof: Double;
  Var strCstPisCof, strNatRecPisCof: String): Double;
  Var
    strEntSai: String;
    qryAux: TUniQuery;
    strSufix: String;
begin
  strEntSai := IIF(strCfop >= '5000', 'S', 'E');
  strSufix := IIF(strEntSai='S', 'SAI', 'ENT');

  qryAux := fCriaQuery(Nil);

  qryAux.SQL.Add('SELECT * FROM ' + strPisCofins + strSufix);
  qryAux.SQL.Add('WHERE ');

  If Not fEmptyStr(strCodAbf) Then
    qryAux.SQL.Add('  APC_CODAPC = :CODAPC AND ');

  qryAux.SQL.Add('  LOCATE(:CFOP, APC_CFO' + strSufix + ') > 0 ');

  If Not fEmptyStr(strCodAbf) Then
    qryAux.ParamByName('CODAPC').AsString := strCodAbf;

  qryAux.ParamByName('CFOP').AsString := strCfop;
  qryAux.Open;

  If qryAux.IsEmpty Then
    Raise Exception.Create('CFOP (' + strCfop + ') não prevista para a abreviaçao "' + strCodAbf + '" de PIS e/ou COFINS.');

  strCstPisCof := qryAux.FieldByName('APC_CST' + strSufix).AsString;
  fltAlqPisCof := qryAux.FieldByName('APC_ALQ' + strSufix).AsFloat;
  If strCfop >= '5000' Then
    strNatRecPisCof := qryAux.FieldByName('APC_MOTISE').AsString;

  Result := fltBase * qryAux.FieldByName('APC_BAS' + strSufix).AsFloat / 100;
  Result := Result * fltAlqPisCof / 100;

  FreeAndNil(qryAux);
end;

function fDefineCSTIPI(strEntSai: String; fltAlqIpi: Double): String;
begin
  If (strEntSai = 'S') Then
  Begin
    Result := IIF(fltAlqIpi>0, '50', '99');
  End
  Else
  Begin
    Result := IIF(fltAlqIpi>0, '00', '49');
  End;
end;

procedure pRetornarAbfPisCofins(strCodIte: String; Var strAbfPis,
  strAbfCof: String);

  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ITE_ABFPIS, ITE_ABFCOF FROM CADITE WHERE ITE_CODITE = :CODITE');
  qryAux.ParamByName('CODITE').AsString := strCodIte;
  qryAux.Open;

  strAbfPis := qryAux.FieldByName('ITE_ABFPIS').AsString;
  strAbfCof := qryAux.FieldByName('ITE_ABFCOF').AsString;

  FreeAndNil(qryAux);
end;

procedure pRetornaCodigoItemEspecial(Var strCodIte, strUnidade: String; blnUsaSigUni: Boolean);
  Var
    qryAux: TUniQuery;
    strComplMensagem: string;

begin
  strComplMensagem:= '';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ITE_CODITE, ITE_CODUNI, UNI_SIGUNI FROM ');
  qryAux.SQL.Add('CADITE JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
  qryAux.SQL.Add('WHERE (ITE_DESITE LIKE "%ITEM ESPECIAL%" OR ITE_DESITE LIKE "ITEM CONSUMO") LIMIT 1');
  qryAux.Open;

  If qryAux.IsEmpty Then
  begin
    strComplMensagem := ', AUTCOM: Menu -> Principal -> Manutenção de Cadastros -> Produtos,';
    Raise Exception.Create('É necessário cadastrar um item com a descrição "ITEM ESPECIAL" ou "ITEM CONSUMO" ' + strComplMensagem + ' para a geração de notas de consumo/serviço, etc.');
  end;

  strCodIte := qryAux.FieldByName('ITE_CODITE').AsString;

  If blnUsaSigUni Then
    strUnidade := qryAux.FieldByName('UNI_SIGUNI').AsString
  Else
    strUnidade := qryAux.FieldByName('ITE_CODUNI').AsString;

  FreeAndNil(qryAux);
end;

procedure pRetornaCodigoItemTransferencia(Var strCodIte, strUnidade: String; blnUsaSigUni: Boolean);
  Var
    qryAux: TUniQuery;
    strComplMensagem: string;

begin
  strComplMensagem:= '';

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('SELECT ITE_CODITE, ITE_CODUNI, UNI_SIGUNI FROM ');
  qryAux.SQL.Add('CADITE JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI');
  qryAux.SQL.Add('WHERE (ITE_DESITE LIKE "%TRANSFERENCIA DE ICMS%" OR ITE_DESITE LIKE "TRANSFERÊNCIA DE ICMS") LIMIT 1');
  qryAux.Open;

  If qryAux.IsEmpty Then
  begin
    strComplMensagem := ', AUTCOM: Menu -> Principal -> Manutenção de Cadastros -> Produtos,';
    Raise Exception.Create('É necessário cadastrar um item com a descrição "TRANSFERÊNCIA DE ICMS" ' + strComplMensagem + ' para a geração de notas de Transferência de ICMS.');
  end;

  strCodIte := qryAux.FieldByName('ITE_CODITE').AsString;

  If blnUsaSigUni Then
    strUnidade := qryAux.FieldByName('UNI_SIGUNI').AsString
  Else
    strUnidade := qryAux.FieldByName('ITE_CODUNI').AsString;

  FreeAndNil(qryAux);
end;

function fRetEspDocum(strHistorico, strAcesso, strEspDoc, strCfop: String; cdsEsp: TClientDataSet): String;
Begin
  If (Not fEmptyStr(strAcesso)) And (strEspDoc = 'IF') Then
  Begin
    Result := AnsiUpperCase('NFCE');
    Exit;
  End;

  If strHistorico = 'S' Then
  Begin
    Result := AnsiUpperCase('NFE');
    Exit;
  End;

  cdsEsp.IndexFieldNames := 'ESP_ESPORI';

  If strAcesso <> '' Then
  Begin
   If cdsEsp.FindKey([strEspDoc + '-e']) Then
     Result := fPadR(cdsEsp.FieldByname('ESP_ESPNOV').AsString,5);
  End
  Else
  Begin
    If strEspDoc = 'NF' Then
    Begin
      If RightStr(strCfop,3) = '933' Then
        Result := fPadR('NFS',5)
      Else If Pos(RightStr(strCfop,3),'302_303') > 0 Then
        Result := fPadR('NFSC',5)
      Else If Pos(RightStr(strCfop,3),'252_253') > 0 Then
        Result := fPadR('NFEE',5)
      Else
      Begin
        if cdsEsp.FindKey([strEspDoc]) then
          Result := fPadR(cdsEsp.FieldByname('ESP_ESPNOV').AsString,5);
      End;
    End
    Else
    Begin
      if cdsEsp.FindKey([strEspDoc]) then
        Result := fPadR(cdsEsp.FieldByname('ESP_ESPNOV').AsString,5);
    End;
  end;

  Result := AnsiUpperCase(Result);
End;

function fLimpaCampo(strCampo: String): String;
begin
  Result := strCampo;

  While Pos(#$D, Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, #$D, ' ');
  End;

  While Pos(#$A, Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, #$A, ' ');
  End;

  While Pos(#9, Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, #9, ' ');
  End;

  While Pos(#10#13, Result) > 0 Do
  Begin
    Result := AnsiReplaceStr(Result, #10#13, '  ');
  End;
end;

function fRemoveAllChars(strTexto: string): string;
  var
    i: Integer;
    chrCuringa: Char;
begin
  chrCuringa := ' ';

  i := Length(strTexto);
  while (Length(strTexto) > 0) and (i > 0) do
  begin
    if strTexto[i] = chrCuringa then
      Delete(strTexto, i, 1);

    Dec(i);
  end;

  Result := strTexto;
end;

function fValidaXML(cdsAtual: TClientDataSet; strNomArq: String): Boolean;
  var cdsPesq: TClientDataSet;
      blnOk: Boolean;
      intCont: Integer;
      strField: String;
begin
  blnOk := False;

  cdsPesq := TClientDataSet.Create(nil);
  cdsPesq.LoadFromFile(strNomArq);
  cdsPesq.Open;

  For intCont := 0 To cdsAtual.Fields.Count - 1 Do
  Begin
    If cdsPesq.FindField(cdsAtual.Fields[intCont].FieldName) = nil Then
      blnOk := True;
  End;

  If blnOk Then
  Begin

    cdsPesq.First;
    While Not cdsPesq.Eof Do
    Begin

      cdsAtual.Insert;
      For intCont := 0 To cdsPesq.Fields.Count - 1 Do
      Begin
        strField := cdsPesq.Fields[intCont].FieldName;

        If cdsAtual.FindField(strField) <> nil Then
          cdsAtual.FieldByName(strField).AsString := cdsPesq.FieldByName(strField).AsString;
      End;
      cdsAtual.Post;

      cdsPesq.Next;
    End;

    cdsAtual.SaveToFile(strNomArq, dfXML);

  End;

  cdsPesq.Close;
  FreeAndNil(cdsPesq);
  Result := blnOk;
end;
{$IFDEF MSWINDOWS}
{**************************************}
{* CHAMA UM OUTRO EXECUTÁVEL EM UM    *}
{* PROCESSO SEPARADO                  *}
{***********************************AF*}
function fCriarProcesso(strArquivo, strParametros: string; blnTrava: Boolean): boolean;
  Var
    StartInfo: TStartupInfo;
    ProceInfo: TProcessInformation;
begin
  FillChar(StartInfo, SizeOf(StartInfo), #0);
  StartInfo.cb          := SizeOf(StartInfo);
  StartInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartInfo.wShowWindow := SW_SHOWNORMAL;

  Result := CreateProcess(Nil,
                          PChar(strArquivo + ' ' + strParametros),
                          Nil,
                          Nil,
                          False,
                          CREATE_NEW_CONSOLE Or
                          NORMAL_PRIORITY_CLASS,
                          Nil,
                          PChar(ExtractFilePath(strArquivo)),
                          StartInfo,
                          ProceInfo);

  If (Result) And (blnTrava) Then
  Begin
    WaitForSingleObject(ProceInfo.hProcess, INFINITE);

    CloseHandle(ProceInfo.hProcess);
    CloseHandle(ProceInfo.hThread);
  End;
end;
{$ENDIF}
function fCampoExiste(const strTabela, strCampo: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := {$IFDEF LINUX}
             fCriaQuery();
           {$ELSE }
             TUniQuery.Create(Nil);
             qryAux.Connection := fRetConexao;
           {$ENDIF LINUX};

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

function fCalculoDVNfe(strChave: String): Integer;
Var intCont, intMult, intSoma, intResto: Integer;
begin
  intMult := 2;
  intSoma := 0;
  For intCont := Length(strChave)-1 Downto 1 Do
  Begin
    If intMult = 10 Then
      intMult := 2;
    intSoma := intSoma + (StrToInt(strChave[intCont]) * intMult);
    intMult := intMult + 1;
  End;

  intResto := intSoma mod 11;

  If (intResto = 0) or (intResto = 1) Then
    Result := 0
  Else
    Result := 11 - intResto;
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
end;

function fStringRepetida(Const strString: String): Boolean;
  Var
    intContador: Integer;
    strPrimeiro: String;
begin
  Result := True;
  If Length(strString) <= 0 THen
    Exit;

  strPrimeiro := strString[1];
  For intContador := 2 To Length(strString) Do
  Begin
    If strString[intContador] <> strPrimeiro Then
    Begin
      Result := False;
      Break;
    End;
  End;
end;

procedure pAtuRecolhimentoMensalICMS();
begin
  If (fEmptyStr(fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMS_' + VS_strCodEmp, '' ))) And
     (fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMS', '' ) <> '') Then
    fArqIniAutSi(1, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMS_' + VS_strCodEmp, fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMS', '' ));

  If (fEmptyStr(fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_FORA_ESTADO_' + VS_strCodEmp, '' ))) And
     (fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_FORA_ESTADO', '' ) <> '') Then
    fArqIniAutSi(1, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_FORA_ESTADO_' + VS_strCodEmp, fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_FORA_ESTADO', '' ));

  If (fEmptyStr(fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO_' + VS_strCodEmp, '' ))) And
     (fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO', '' ) <> '') Then
    fArqIniAutSi(1, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO_' + VS_strCodEmp, fArqIniAutSi(0, 'GERAL', 'SPED_COD_ESTAD_RECOLHE_ICMSST_DENTRO_ESTADO', '' ));

  If (fEmptyStr(fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_ICMS_' + VS_strCodEmp, '' ))) And
     (fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_ICMS', '' ) <> '') Then
    fArqIniAutSi(1, 'GERAL', 'SPED_DIA_VENC_ICMS_' + VS_strCodEmp, fArqIniAutSi(0, 'GERAL', 'SPED_DIA_VENC_ICMS', '' ));
end;

procedure pApagarTodosArquivos(strPasta: String);
  Var
    searchRec: TSearchRec;
begin
  If FindFirst(strPasta + '\*.*', faAnyFile, searchRec) = 0 then
  begin
    Repeat
      DeleteFile(strPasta + '\' + searchRec.Name);
    Until FindNext(searchRec) <> 0;
  end;
end;

function IfNull(varValor, varDefault: Variant): Variant;
begin
	Result := varValor;
	If (Result = Null) Then
		Result := varDefault;
end;

procedure VerificaBdCamposFuncoes;
  var i: Integer;
    qryPesqField : TUniQuery;
    qryCfgSis    : TUniQuery;
    stlErros     : TStringList;
begin
  stlErros := TstringList.Create;
  {******************************************}

  qryPesqField := TUniQuery.Create(Nil);
  qryPesqField.Connection := fRetConexao;

  qryCfgSis := fCriaQuery(nil);

  {*************************************************************}
  {* VERFIICA A EXISTENCIA DO CAMPO FIS_ORIDOC TABELA CADFIS   *}
  {* NO BANCO DE DADOS EM USO                                  *}
  {*********************************************2009******* AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADFIS WHERE FIS_NUMDOC = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('FIS_ORIDOC') = Nil then
  begin
    VS_strComOriDoc := 'N';
    stlErros.Add('CAMPO INEXISTENTE - FIS_ORIDOC NAO ENCONTRADO EM CADFIS ');
  end
  else
    VS_strComOriDoc := 'S';
  qryPesqField.Close;


  {*************************************************************}
  {* VERifICA A EXISTENCIA DO CAMPO COD CIDADE TABELA IBGE     *}
  {* NO BANCO DE DADOS EM USO                                  *}
  {*********************************************2009******* AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADCID WHERE CID_CODCID = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('CID_COIBGE') = Nil then
  begin
    VS_strComCodIBGE := 'N';
    stlErros.Add('CAMPO INEXISTENTE - CODIGO IBGE DE CIDADES INEXISTENTE - SOLICITAR ATUALIZACAO ');
  end
  else
  begin
    VS_strComCodIBGE := 'S';
  end;

  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO CLI_SUFRAM QUE NAS VERSOES   *}
  {* ANTIGAS (27.2) NAO CONSTA                                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADCLI WHERE CLI_CODCLI = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('CLI_SUFRAM') = Nil then
  begin
    VS_strComSufram := 'N';
    stlErros.Add('CAMPO INEXISTENTE - CODIGO SUFRAMA - SOLICITAR ATUALIZACAO ');
  end
  else
    VS_strComSufram := 'S';
  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO CLI_ENDNUM (NUMERO DO end.)  *}
  {* QUE NAS VERSOES ANTIGAS (27.2) NAO CONSTA                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADCLI WHERE CLI_CODCLI = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('CLI_ENDNUM') = Nil then
  begin
    VS_strComNumendCli := 'N';
    stlErros.Add('CAMPO INEXISTENTE - NUMERO DO ENDERECO DO CLIENTE - SOLICITAR ATUALIZACAO ');
  end
  else
    VS_strComNumendCli := 'S';
  qryPesqField.Close;
    stlErros.Add('CAMPO INEXISTENTE - NUMERO DO ENDERECO DO CLIENTE - SOLICITAR ATUALIZACAO ');

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO FOR_ENDNUM (NUMERO DO end.)  *}
  {* QUE NAS VERSOES ANTIGAS (27.2) NAO CONSTA                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADFOR WHERE FOR_CODFOR = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('FOR_ENDNUM') = Nil then
  begin
    VS_strComNumendFor := 'N';
    stlErros.Add('CAMPO INEXISTENTE - NUMERO DO ENDERECO DO FORNECEDOR - SOLICITAR ATUALIZACAO');
  end
  else
    VS_strComNumendFor := 'S';
  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO CLI_ENDCOM (NUMERO DO end.)  *}
  {* QUE NAS VERSOES ANTIGAS (27.2) NAO CONSTA                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADCLI WHERE CLI_CODCLI = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('CLI_ENDCOM') = Nil then
  begin
    VS_strComComplendCli := 'N';
    stlErros.Add('CAMPO INEXISTENTE - COMPLEMENTO DO ENDERECO DO CLIENTE - SOLICITAR ATUALIZACAO');
  end
  else
    VS_strComComplendCli := 'S';
  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO FOR_ENDCOM (COMPLEM DO end.) *}
  {* QUE NAS VERSOES ANTIGAS (27.2) NAO CONSTA                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADFOR WHERE FOR_CODFOR = "000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('FOR_ENDCOM') = Nil then
  begin
    VS_strComComplendFor := 'N';
    stlErros.Add('CAMPO INEXISTENTE - COMPLEMENTO DO ENDERECO DO FORNECEDOR - SOLICITAR ATUALIZACAO');
  end
  else
    VS_strComComplendFor := 'S';
  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO FIS_SEGUR1 QUE NAS VERSOES   *}
  {* ANTIGAS (27.2) NAO CONSTA                                 *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADFIS WHERE FIS_NUMDOC="000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('FIS_SEGUR1') = Nil then
  begin
    VS_strComSegur := 'N';
    stlErros.Add('CAMPO INEXISTENTE - VALOR DE SEGURO - SOLICITAR ATUALIZACAO');
  end
  else
    VS_strComSegur := 'S';

  {*************************************************************}
  {* VERIFICA A PRESENCA DO CAMPO CTA_CONCON QUE NAS VERSOES   *}
  {******************************************* 09/05/2011 * AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADCTA WHERE CTA_CODCTA = "0000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.FieldList.Find('CTA_CONCON') = Nil then
  begin
    VS_strCtaComConCon := 'N';
    // stlErros.Add('CAMPO INEXISTENTE - CÓDIGO CONTÁBIL DO CENTRO DE CUSTO');
  end
  else
    VS_strCtaComConCon := 'S';


  {*************************************************************}
  {* VERIFICA A PRESENCA DO CAMPO FIS_ACESSO QUE NAS VERSOES   *}
  {* ANTIGAS NAO CONSTA                                        *}
  {******************************************************** AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADFIS WHERE FIS_NUMDOC="000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if (qryPesqField.FieldList.Find('FIS_ACESSO') = Nil) then
  begin
    VS_strPodeUsarNFE := 'N';
    stlErros.Add('CAMPO INEXISTENTE - CODIGO DE ACESSO PARA NOTA FISCAL ELETRONICA - SOLICITAR ATUALIZACAO');
  end
  else
    VS_strPodeUsarNFE := 'S';

  qryPesqField.Close;

  {************************************************************}
  {* VERIFICA A PRESENCA DO CAMPO IMO_LOCFIS QUE NAS VERSOES   *}
  {* ANTIGAS NAO TEM                                           *}
  {********************************************10/01/2013** CI *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SELECT  * FROM CADIMO WHERE IMO_CODIMO="000000" ';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if (qryPesqField.FieldList.Find('IMO_LOCFIS') = Nil) then
    VS_strLocalizacaoFisica := 'N'
  else
    VS_strLocalizacaoFisica := 'S';

  qryPesqField.Close;

  {*************************************************************}
  {* VERFIICA A EXISTENCIA DA TABELA MOVSER PARA SERVICOS      *}
  {* NO BANCO DE DADOS EM USO                                  *}
  {*********************************************2009******* AM *}
  qryPesqField.Close;
  qryPesqField.SQL.Text := 'SHOW TABLES LIKE "MOVSER"';
  qryPesqField.Connection := fRetConexao;
  qryPesqField.Open;
  if qryPesqField.RecordCount = 0 then
  begin
    (* ESTA VARIAVEL INDICA SE AINDA EXISTEM OS CAMPOS DE SERVICOS NO MOVGER *)
    VS_strCamposServicosGer := 'S';
    (* A TABELA DE MOVIMENTO DE SERVICOS NAO FOI ENCONTRADA *)
    stlErros.Add('TABELA INEXISTENTE ');
  end
  else
    VS_strCamposServicosGer := 'N';
  qryPesqField.Close;

  {*************************************************************}
  {* VERifICA A PRESENCA DO CAMPO GER_DESS01 QUE NAS VERSOES   *}
  {* ANTIGAS (27.2) NAO CONSTA DAS TABELAS MOVGER OU NOTGER    *}
  {******************************************************** AM *}
  For i:= 1 to 2 Do
  begin
    qryPesqField.Close;
    if i = 1 then
      qryPesqField.SQL.Text := 'SELECT  * FROM MOVGER WHERE GER_NUMDOC ="000000" '
    else if i = 2 then
      qryPesqField.SQL.Text := 'SELECT  * FROM NOTGER WHERE GER_NUMDOC ="000000" ';

    qryPesqField.Connection := fRetConexao;
    qryPesqField.Open;
    if qryPesqField.FieldList.Find('GER_DESS01') = Nil then
    begin
      VS_strComGerDescrServ := 'N';
      stlErros.Add('CAMPO INEXISTENTE - DESCRICAO DE SERVICOS - SOLICITAR ATUALIZACAO');
    end
    else
    begin
      VS_strComGerDescrServ := 'S';
      Break;
    end;

  end;
  qryPesqField.Close;

  {*************************************************************}
  {* RETORNA O CODIGO DE ITEM DE SERVICO PARA QUE UM SERVICO   *}
  {* NAO ENTRE NA LISTA DE PRODUTOS DE UMA NOTA MISTA          *}
  {* POR HORA NAO UTILIZADO UMA VEZ QUE ESSE FILTRO ESTA SendO *}
  {* FEITO PELO TIPO DE CFOP DifERENTE DE "N933"               *}
  {******************************************** 2009 ****** AM *}
  qryCfgSis.Close;
  qryCfgSis.SQL.Text := 'SELECT  * FROM CFGSIS WHERE SIS_CODCFG = "CFG_CLASUB" ';
  qryCfgSis.Open;

  (* CONFIGURACAO DA SITUACAO TRIBUTARIA DO CLIENTE 1-SUBSTITUIDO / 2-SUBSTITUTO *)
  if qryCfgSis.Locate('SIS_CODCFG', 'CFG_CLASUB', [loCaseInsensitive]) then
    VS_strClaSub := qrycfgSis.FieldByName('SIS_VALCFG').AsString
  else
    VS_strClaSub := '1';

  qryCfgSis.Close;

  if stlErros.Count > 2 then
  begin
    stlErros.SaveToFile('ErrosCampos.Txt');
  end;

  FreeAndNil(qryPesqField);
  FreeAndNil(qryCfgSis);
  FreeAndNil(stlErros);

end;
{$IFDEF MSWINDOWS}
{*******************************************}
{* PEDE UMA DATA                           *}
{****************************************MV*}
function ffrmData(Var dtaData: TDateTime; strCaption, strCaptionLabel: String): Boolean;
begin

  Try
    pCriarFormularios(TfrmDigData, frmDigData);
    frmDigData.Caption := strCaption;

    If dtaData > 0 Then
      frmDigData.mskData.Text := DateToStr(dtaData);

    frmDigData.lblData.Caption := strCaptionLabel;
    Result := (frmDigData.ShowModal = mrOk);

    If (Result) Then
      dtaData := StrToDate(frmDigData.mskData.Text);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ffrmData]');
    End;
  End;

  pFreeAndNil(frmDigData);

end;
{$ENDIF}
{ TDicionario }

procedure TDicionario.Adicionar(strChave: String; Valor: Variant);
  Var
    intPos: Integer;
    PValor: PVariant;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    PValor  := New(PVariant);
    PValor^ := Valor;
    lstChaves.Add(strChave);
    lstValores.Add(PValor);
  End
  Else
  Begin
    PValor  := lstValores[intPos];
    PValor^ := Valor;
    lstValores[intPos] := PValor;
  End;
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

  lstChaves := TStringList.Create;
  lstValores:= TList.Create;
end;

destructor TDicionario.Destroy;
begin
  Limpar;

  FreeAndNil(lstChaves);
  FreeAndNil(lstValores);

  inherited;
end;

procedure TDicionario.Limpar;
begin
  // Não liberar nada aqui pois apresenta muitos problemas
  // Caso for libera aqui TESTAR TUDO de TODOS OS JEITOS!!!!

  lstChaves.Clear;
  lstValores.Clear;
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
    Result := PVariant(lstValores[intPos])^;
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

function fInIteSer: String;
begin
  If fEmptyStr(VS_strIteSer) And fEmptyStr(VS_strSerTer) Then
    Result := '("")'
  Else
  Begin
    Result := '(' + QuotedStr(VS_strIteSer);
    If Not fEmptyStr(VS_strSerTer) Then
    Begin
      Result := Result + ', ' + QuotedStr(VS_strSerTer);
    End;
    Result := Result + ')';
  End;
end;

function fSoNumero(strTexto: String): String;
var
  intCont: Integer;
begin
  Result := '';
  for intCont := 1 to Length(strTexto) do
    if CharInSet(strTexto[intCont], ['0'..'9']) then
      Result := Result + strTexto[intCont];
end;

function fRetornaInscSubstitutoTributarioEmpresa(strEmpresa, strEstadoDestino: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  try
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  EMP_INSSUB ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  EMPISB ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  EMP_CODEMP = :CODEMP AND  ');
    qryAux.SQL.Add('  EMP_ESTADO = :ESTADO      ');

    qryAux.ParamByName('CODEMP').AsString := strEmpresa;
    qryAux.ParamByName('ESTADO').AsString := strEstadoDestino;
    qryAux.Open;

    Result := qryAux.FieldByName('EMP_INSSUB').AsString;
  finally
    FreeAndNil(qryAux);
  end;
end;

function fRetornaInscSubsTribSimplificado(strEmpresa, strEstadoDestino: string): boolean;
  var
    qryAux: TUniQuery;
begin
  Result := False;

  if fTabelaExiste('CADSIP') then
  begin
    qryAux := fCriaQuery(nil);
    try
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  SIP_ESTADO ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  CADSIP ');
      qryAux.SQL.Add('WHERE SIP_CODEMP = :CODEMP');
      qryAux.SQL.Add('  AND SIP_ESTADO = :ESTADO ');

      qryAux.ParamByName('CODEMP').AsString := strEmpresa;
      qryAux.ParamByName('ESTADO').AsString := strEstadoDestino;
      qryAux.Open;

      Result := qryAux.RecordCount > 0;
    finally
      FreeAndNil(qryAux);
    end;
  end;
end;
{$IFDEF MSWINDOWS}
procedure pEdtCodSelectExit(    edtCodigo       : TCustomEdit;
                                edtDescri       : TEditFocus;
                            Var arrLinha        : TConsultasArray;
                                fncRetNome      : TfncRetNome;
                                fncRetNomeConst : TfncRetNomeConst;
                                strMsgErr       : String;
                                intTamCamp      : integer = 0;
                                blnNegar: Boolean = False);
  Var
    intTamanho: Integer;
    strText  : String;
Begin


  If Assigned(edtDescri) Then
  Begin

    If edtCodigo Is TEditFocus Then
    Begin
      intTamanho := (edtCodigo As TEditFocus).TamCampo;
      if intTamCamp > 0 then
        intTamanho := intTamCamp;
      strText    := (edtCodigo As TEditFocus).Text;
    End

    else if edtCodigo Is TDBEditFocus then
    begin
      intTamanho := intTamCamp;
      strText    := (edtCodigo As TDBEditFocus).Text;
    end

    Else
    Begin
      intTamanho := intTamCamp;
      strText    := (edtCodigo As TMaskEditFocus).Text;
    End;

    If strText <> fStrZero('0',intTamanho) Then
      SetLength(arrLinha,0);

    If fEmptyStr(strText) Then
    Begin
      If Assigned(edtDescri) Then
      Begin
        If blnNegar Then
          edtDescri.Text := 'NENHUM'
        Else
          edtDescri.Text := 'TODOS';
      End;
    End

    Else
    Begin

      If Length(arrLinha) = 0 Then
      Begin
        SetLength(arrLinha,1);
        arrLinha[0].strCodigo := strText;

        If Assigned(fncRetNomeConst) Then
          arrLinha[0].strDescri := fncRetNomeConst(strText)

        Else If Assigned(fncRetNome) Then
          arrLinha[0].strDescri := fncRetNome(strText);
      End;

      If Length(arrLinha) = 1 Then
      Begin
        If Assigned(edtDescri) Then
          If Assigned(fncRetNomeConst) Then
            edtDescri.Text := fncRetNomeConst(strText)

          Else If Assigned(fncRetNome) Then edtDescri.Text := fncRetNome(strText);
      End;
    End;

    If Assigned(edtDescri) Then
    Begin
      If fEmptyStr(edtDescri.Text) And (Not fEmptyStr(strText))  Then
      Begin
        fMensagem('','Código ' + strMsgErr + ' não encontrado.', ['&O K']);
        edtCodigo.Clear;
        pSetFocus(edtCodigo);
      End;
    End;
  End
  Else
  Begin
    If fEmptyStr(edtCodigo.Text) Then
      Exit;

    If edtCodigo.Text <> '+1' Then
      SetLength(arrLinha,0);

    If (Length(arrLinha) = 0) Then
    Begin
      SetLength(arrLinha,1);
      arrLinha[0].strCodigo := edtCodigo.Text;
    End;

    If (Length(arrLinha) = 1)                                                      And
       ((Assigned(fncRetNomeConst) And fEmptyStr(fncRetNomeConst(edtCodigo.Text))) Or
         (Assigned(fncRetNome)     And fEmptyStr(fncRetNome(edtCodigo.Text)))    ) And
       (Not fEmptyStr(edtCodigo.Text))                                             Then
    Begin
      fMensagem('AVISO','Código ' + strMsgErr + ' não encontrado.', ['&O K']);
      edtCodigo.Clear;
      pSetFocus(edtCodigo);
    End;

  End;
End;
{$ENDIF}

function fRetornaClienteFilial(strCodEmp: String; strTipo_FC : String = 'C'): String;
  Var
    strSQL    : String;
    qryGenFil : TUniQuery;
begin
  If fEmptyStr(strCodEmp) Then
  Begin
    Result := '';
    Exit;
  End;

  Try
    qryGenFil := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';

    If strTipo_FC = 'C' Then
      strSQL := strSQL + '  EMP_CLIFIL FILIAL '
    Else
      strSQL := strSQL + '  EMP_FORFIL FILIAL ';

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP = :CODEMP ';

    With qryGenFil Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      Open;

      Result := FieldByName('FILIAL').AsString;
    End;

  Finally
    FreeAndNil(qryGenFil);
  End;

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

class function TDicResultadoQuerySimples.fExecQuery(
  qryExec: TUniQuery): Variant;
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

procedure TDicResultadoQuerySimples.SetResult(Index: TUniQuery;
  const Value: Variant);
begin
  FResultados[GetKey(Index)] := Value;
end;
{$IFDEF MSWINDOWS}
procedure pGetMenuIntegracaoContabil(LstMenu: TCheckListBox; MenuItem: TMenuItem; Menu: TAdvMainMenu);
  var
    intContador: Integer;
begin
  for intContador := 0 To MenuItem.Count-1 Do
    if Trim(MenuItem.Items[intContador].Caption) <> '-' then
      LstMenu.Items.Add(FormatFloat('0000', MenuItem.Items[intContador].Tag) + '-' + StringReplace(MenuItem.Items[intContador].Caption,'&','',[]));
End;
{$ENDIF}
procedure pCarregaCodigoContabilista;
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT EMP_CODCTB FROM CADEMP WHERE EMP_CODEMP = :CODEMP ';
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;

      VS_strCodEmpContab := FieldByName('EMP_CODCTB').AsString;
    end;
  finally
  end;
end;

function fRound(fltValue: Extended; intDecimals: Integer): Extended;
var
  fltFactor: Extended;
  fltFraction: Extended;
begin
  fltFactor := IntPower(10, intDecimals);
  fltValue := StrToFloat(FloatToStr(fltValue * fltFactor));

  Result := Int(fltValue);
  fltFraction := Frac(fltValue);

  if fltFraction >= 0.5 then
    Result := Result + 1
  else
    if fltFraction <= -0.5 then
      Result := Result - 1;

  Result := Result/fltFactor;
end;

function fTrunca(const fltValor: Double; intDecimais: Integer): Double;
var
  i, c: Integer;
  s, s2: String;
  v: Boolean;
begin
  s := floatToStr(fltValor);
  c := 0;
  v := false;

  for i := 1 to length(s) do
  begin
    if not v then
      v := s[i] = ',';

    s2 := s2 + s[i];

    if v then
      Inc(c);

    if c > intDecimais then
      Break;
  end;

  Result := StrToFloat(s2);
end;

function fArrLinhaGrupoExcluir(strEmpresa: string; strTipExt: string = '1'): TConsultasArray;
  var
    qryLinGru :TUniQuery;

    procedure pCarregaLinGru;
    begin
      qryLinGru.Close;
      qryLinGru.SQL.Clear;

      qryLinGru.SQL.Add('SELECT LGS_CODGRU ');
      qryLinGru.SQL.Add('  FROM CONLGS ');
      qryLinGru.SQL.Add(' WHERE LGS_TIPEXP = :TIPEXP ');
      qryLinGru.SQL.Add(' AND LGS_CODEMP = :CODEMP ');

      qryLinGru.ParamByName('TIPEXP').AsString := strTipExt;
      qryLinGru.ParamByName('CODEMP').AsString := strEmpresa;

      qryLinGru.Open;
    end;

begin
  Result := nil;

  if fTabelaExiste('CONLGS') then
  begin
    qryLinGru := fCriaQuery;

    try
      pCarregaLinGru;

      SetLength(Result, qryLinGru.RecordCount);

      qryLinGru.First;
      while not (qryLinGru.Eof) do
      begin
        Result[qryLinGru.RecNo - 1].strCodigo := qryLinGru.FieldByName('LGS_CODGRU').AsString;

        qryLinGru.Next;
      end;
    finally
      qryLinGru.Free;
    end;
  end;
end;

function StringToBoolean(AValue: String): Boolean;
begin
  case AnsiIndexStr(UpperCase(AValue), ['S', 'N', '0', '1']) of
    0: Result := True;
    1: Result := False;
    2: Result := False;
    3: Result := True;
  else
    Result := False;
  end;
end;

function fValida_GTIN(strGTIN: string): Boolean;
  Var
    intCnt, intSoma, intResultado, intBase10: Integer;
begin
  //Verifica se todos os caracteres de strGTIN são números
  for intCnt:= 1 to Length(strGTIN) do
  begin
    if not {$IF Defined(VER250) Or Defined(VER270) OR Defined(VER280) OR Defined(VER300)}(CharInSet(strGTIN[intCnt], ['0'..'9'])){$ELSE}(strGTIN[intCnt] in ['0'..'9']){$IFEND} Then
    begin
      Result:= False;
      Exit;
    end;
  end;
  //Verifica se strGTIN tem o tamanho necessário
  if Length(strGTIN) in [8,12,13,14] then
  begin
    intSoma:= 0;
    for intCnt:= 1 to (Length(strGTIN) -1) do
    begin
      if Length(strGTIN) = 13 then
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3);
      end
      else
      begin
        if Odd(intCnt) then
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 3)
        else
          intSoma:= intSoma + (strtoint(strGTIN[intCnt]) * 1);
      end;
    end;
    intBase10:= intSoma;
    //Verifica se intBase10 é múltiplo de 10
    if not (intBase10 mod 10 = 0) then
    begin
      while not (intBase10 mod 10 = 0) do
      begin
        intBase10:= intBase10 + 1;
      end;
    end;
    intResultado:= intBase10 - intSoma;
    //Verifica se o intResultado encontrado é igual ao caractere de controle
    if intResultado = strtoint(strGTIN[Length(strGTIN)]) then
      Result:= True
    else
      Result:= False;
  end
  else
    Result:= False;
end;


function fConverteSeparadorData(strData: string): string;
  var
    dteFormato: TDate;
begin
  dteFormato := 0;

  if Copy(DateToStr(dteFormato), 3, 1) = '-' then
    Result := AnsiReplaceStr(strData, '/', '-')
  else Result := strData;
end;

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
{$IFDEF MSWINDOWS}
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
{$ENDIF}

function fTime(const AForceTime: Boolean = False) : TDateTime;
begin
  If (AForceTime) Or (Not Assigned(frmModulo)) Then
    Result := untHorarioSistema.GetTime()
  Else
    Result := untHorarioSistema.GetTime(VS_strCodEmp, frmModulo.Database);
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

initialization
  EnableUniSQL := False;
  {$IFNDEF MSWINDOWS}
  frmModulo := TfrmModulo.Create(nil);
  pAbrirBanco(frmModulo.Database);
  {$ENDIF}

end.
