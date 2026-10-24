unit untFuncEspecificas;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
  untGTinForTipos,
{$ELSE}
  Dialogs, Forms, untFuncoesSimples, Controls,
  UniClientDataSet, Windows, Messages,
  cxProgressBar,
{$ENDIF}
  SysUtils, Classes, DB, Uni, Variants, IniFiles, IOUtils,
  untTMatrizSaldosColorantes,
  untICalculadorFatVendas,
  untGenericTintaDeMaquina,
  untTypesSistema;

{$IFDEF LINUX}
type
  TADOQuery = class(TComponent)
  private
    FRecordset: Variant;
  public
    property Recordset: Variant read FRecordset write FRecordset;
    procedure First; virtual; abstract;
    procedure Next; virtual; abstract;
    function Eof: Boolean; virtual; abstract;
    function FieldByName(AField: string): TField; virtual; abstract;
  end;

  TADOConnection = class(TComponent)
  public
    LoginPrompt: Boolean;
    Provider: String;
    ConnectionString: String;
  end;

  TADOParameterValue = class(TComponent)
  private
    FValue: Variant;
  public
    property Value: Variant read FValue write FValue;
  end;

  TADOParameters = class(TComponent)
  public
    function Refresh: Boolean; virtual; abstract;
    function ParamByName(AName: String): TADOParameterValue; virtual; abstract;
  end;

  TADOStoredProc = class(TComponent)
  private
    FRecordset: Variant;
  public
    Parameters: TADOParameters;
    Connection: TADOConnection;
    ProcedureName: String;
    Prepared: Boolean;
  public
    procedure Open; virtual; abstract;
  public
    property Recordset: Variant read FRecordset write FRecordset;
  end;
{$ENDIF}

Type
  TTipoEmbalagem = (teLitro, teGalao, teCopo, teSpray, tePoliester, teDuco, teTambor, teLata, teBalde);
  TModoVenda = (mvConcentrado, mvDiluido);
  TEmbalagemMudouEvent = procedure (strCodEmb: String) of object;

Type
  TBaseAutomotiva = class(TCollectionItem)
  private
    FLinBas: String;
    FCodBas: String;
    FQtdCon: Double;
    FQtdDil: Double; // Qtd. Diluido 1
    FQtdDi2: Double; // Qtd. Diluido 2
    FQtdPCo: Double; // Qtd. Padrao Concentrado (Salcomix e Glasurit)
    FQtdPDi: Double; // Qtd. Padrao Diluido (Salcomix e Glasurit)
    FTipBas: String;
    FPreVen: Double;
    FEmbala: Double;
    FPesEsp: Double;
    FPreCus: Double;
    FIcmSai: Double;
    FOutVal: Double;
    FImpFed: Double;
    FDesOpe: Double;
    FPreMed: Double;
    FPreUlt: Double;
    FImpUlt: Double;
    FPorcen: Double;
    FComLiq: Double;

    FImpDir: string;
    FCodIte: string;

    FPesGra: String;
    FIdePro: String;
  protected
    procedure SetCodBas(const Value: String);
    procedure SetQtdCon(const Value: Double);
    procedure SetQtdDil(const Value: Double);
    procedure SetQtdDi2(const Value: Double);
    procedure SetQtdPCo(const Value: Double);
    procedure SetQtdPDi(const Value: Double);
    procedure SetTipBas(const Value: String);
    procedure SetLinBas(const Value: String);
    procedure SetEmbala(const Value: Double);
    procedure SetPesEsp(const Value: Double);
    procedure SetPreVen(const Value: Double);
    procedure SetPreCus(const Value: Double);
    procedure SetPorcen(const Value: Double);
  public
    property strLinBas: String Read FLinBas Write SetLinBas;
    property strCodBas: String Read FCodBas Write SetCodBas;
    property fltQtdCon: Double Read FQtdCon Write SetQtdCon;
    property fltQtdDil: Double Read FQtdDil Write SetQtdDil;
    property fltQtdDi2: Double Read FQtdDi2 Write SetQtdDi2;
    property fltQtdPCo: Double Read FQtdPCo Write SetQtdPCo;
    property fltQtdPDi: Double Read FQtdPDi Write SetQtdPDi;
    property strTipBas: String Read FTipBas Write SetTipBas;
    property fltPreVen: Double Read FPreVen Write SetPreVen;
    property fltEmbala: Double Read FEmbala Write SetEmbala;
    property fltPesEsp: Double Read FPesEsp Write SetPesEsp;
    property fltPreCus: Double read FPreCus write SetPreCus;
    property fltPorcen: Double read FPorcen write SetPorcen;

    property fltOutVal: Double Read FOutVal Write FOutVal;
    property fltIcmSai: Double Read FIcmSai Write FIcmSai;
    property fltImpFed: Double Read FImpFed Write FImpFed;
    property fltDesOpe: Double Read FDesOpe Write FDesOpe;
    property fltPreMed: Double read FPreMed write FPreMed;

    property fltPreUlt: Double read FPreUlt write FPreUlt;
    property fltImpUlt: Double read FImpUlt write FImpUlt;
    property fltComLiq: Double read FComLiq write FComLiq;

    property strImpDir: string read FImpDir write FImpDir;
    property strCodIte: string read FCodIte write FCodIte;

    property strPesGra: String read FPesGra write FPesGra;
    property strIdePro: String read FIdePro write FIdePro;
  End;

Type
  TFormulaAutomotiva = class(TCollection)
  private
    FstrOpcDoc: String;
    FstrCodEmpEst: String;
    FintQtdEmb: Integer;
    FConsiderarEmbalagem: Boolean;

    FPreCusProCache: Double;
    FPreVenProCache: Double;

    FEmbalagemMudou: TEmbalagemMudouEvent;

    function GetTemDiluido: Boolean;
    function GetTemConcentrado: Boolean;
    procedure SetstrOpcDoc(const Value: String);
    procedure SetstrCodEmpEst(const Value: String);
    procedure SetintQtdEmb(const Value: Integer);

    function GetPrecoEmbalagemInterna: Double;
    function GetPreMedEmbalagemInterna: Double;
    function GetImpUltEmbalagemInterna: Double;
    function GetPreUltEmbalagemInterna: Double;
    function GetPrecoCustoEmbalagemInterna: Double;
    function GetPrecoCusto2EmbalagemInterna: Double;
    function GetPrecoCompraLiquidoEmbalagemInterna: Double;

    function GetPrecoVenCon: Double;
    function GetPrecoVenDil: Double;

    procedure pCarregaPrecoPromocaoEmbalagem;
    procedure SetCodEmb(const Value: String);
    procedure pBasesPorEmpresas(var cdsCadBas: TUniClientDataSet; qryGen: TUniQuery);
  protected
    FCalculo: TStringList;
    FDescri: String;
    FTipoEmb: TTipoEmbalagem;
    FCodEmb: String;

    FVolumeOri: Double;
    FVolumePro: Double;

    FComCatalisador: Boolean;
    FErroIntegracao: Boolean;
    FIdxPorDil : Integer;


    FModoVenda: TModoVenda;

    {****************************************************}
    {* CASO A TINTA NECESSITE DE INFORMAÇÕES ADICIONAIS *}
    {* PARA O CALCULO DA SUA FORMULA, É NECESSÁRIO SETAR*}
    {* A variável FDadosAdicionais PARA TRUE. ISSO IRÁ  *}
    {* HABILITAR UM PAINEL NA TELA DE VENDA DA TINTA E  *}
    {* UM COMBO-BOX. ENTÃO SE FAZ NECESSÁRIO O PREEN-   *}
    {* CHIMENTO DAS VARIAVEIS: FCaptionAdicional,       *}
    {* FListaAdicional. PARA LER O VALOR ADICIONAL SE-  *}
    {* LECIONADO, BASTA LER A VARIÁVEL intIndicAdicional*}
    {* QUE CONTERÁ O INDICE SELECIONADO NO COMBO-BOX.   *}
    {** 14/07/2008 - 09:38 ***************************MV*}
    FDadosAdicionais: Boolean;
    FCaptionAdicional: String;
    FListaAdicional: TStringList;
    FAdicionalConcentrado: Boolean; // Se os dados adicionais aparecem no modo concentrado
    FAdicionalDiluido: Boolean; // Se os dados adicionais aparecem no modo diluido
    FIndiceAdicional: Integer;

    FTabPre: String;

    FPrecoCusCon: Double;
    FPrecoCusDil: Double;
    FPrecoCu2Con: Double;
    FPrecoCu2Dil: Double;
    FPrecoVenCon: Double;
    FPrecoVenDil: Double;
    qryCadBas: TUniQuery;
    qryBasEmp: TUniQuery;

    FFatorAcerto: Double;

    FOutValCon: Double;
    FIcmsaiCon: Double;
    FImpFedCon: Double;
    FDesOpeCon: Double;

    FOutValDil: Double;
    FIcmsaiDil: Double;
    FImpFedDil: Double;
    FDesOpeDil: Double;

    FPreMedDil: Double;
    FPreMedCon: Double;

    tintaDeMaquina: array[TModoVenda] of TGenericTintaDeMaquina;

    FPreUltCon: Double;
    FPreUltDil: Double;
    FImpUltCon: Double;
    FImpUltDil: Double;

    FPromoc: String;

    FCodFormul: String;

    FComLiqCon: Double;
    FComLiqDil: Double;

    FBlnCalculaUnitario: Boolean;

    FCodCli: String;
    FCodCnd: String;
    FPrzMed: Integer;
    FIdePro: String;
    FAcrMob: Double;
    FProPre: Boolean;
    strEmpPrd: String;
    strOprFlj: String;
    strEmpCd: String;
    strCD_S_N: String;
    strEmpFat: String;
    strFatS_N: String;

    function GetPrecoEmbalagem: Double; virtual;
    function GetPreMedEmbalagem: Double; virtual;
    function GetImpUltEmbalagem: Double; virtual;
    function GetPreUltEmbalagem: Double; virtual;
    function GetPrecoCustoEmbalagem: Double; virtual;
    function GetPreco2CustoEmbalagem: Double; virtual;
    function GetPrecoCompraLiquidoEmbalagem: Double; virtual;
    function GetAcertoValor: Boolean;

    procedure pAdicionarEmbalagem(matSaldosBases: TClassMatrizSaldosColorantes); virtual;
    function fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double; virtual;

    function fTabPreco: String;
    procedure pAplicarAcrescimoPrecoVenda(const aPerAcr: Double; const aRound: Boolean=False);
  public
    calculadorFatVendas: ICalculadorFatVendas;
    procedure pCarregarColorantes; virtual; abstract;
  public
    Constructor Create(strTabPrePar: String); overload; virtual;
    Constructor Create(strTabPrePar: String; itemClass: TCollectionItemClass); overload; virtual;
    Destructor Destroy; override;
    procedure pCalcularPrecos; virtual; abstract;
    procedure pCarregaPrecosBases; virtual; abstract;
    procedure GetComposicaoPrecoCusto2(var fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Double; fltDesOpeTin: Double);
    procedure pCalculaImpostosSaida(dicRetorno: TDicionario);
    function fVerificaEmpresaSetada(): String; Virtual;

    procedure pRecalculaTabelas(strTipoPreco: String; dicRetorno: TDicionario); virtual;
    function fVerificaSaldosML(): Boolean; overload;
    function fVerificaSaldosML(matrizSaldosColorantes: TClassMatrizSaldosColorantes): Boolean; overload;
    function fRetMatrizSaldosColorantes(): TClassMatrizSaldosColorantes; virtual;

    function fCasasDecimaisFormulacao: Integer; virtual;

    property stlCalculo: TStringList Read FCalculo;
    property strDescri: String Read FDescri Write FDescri;

    //idepro colocado aqui por conta do acrescimo na embalagem automotiva;
    property strIdePro: String Read FIdePro Write FIdePro;

    property tpeTipEmb: TTipoEmbalagem Read FTipoEmb Write FTipoEmb;
    property strCodEmb: String Read FCodEmb Write SetCodEmb;

    property blnTemDiluido: Boolean Read GetTemDiluido;
    property blnTemConcentrado: Boolean Read GetTemConcentrado;
    property fltVolumeOri: Double Read FVolumeOri Write FVolumeOri;
    property fltVolumePro: Double Read FVolumePro Write FVolumePro;
    property blnComCatalisador: Boolean Read FComCatalisador Write FComCatalisador;
    property blnErroIntegracao: Boolean Read FErroIntegracao Write FErroIntegracao;

    property mveModoVenda: TModoVenda Read FModoVenda Write FModoVenda;

    property intIdxPorDil: Integer Read FIdxPorDil Write FIdxPorDil; // Tinta Standox, irá receber o resultado do radioGroup (0 = 10 %, 1 = 20%).

    {***************************************************}
    {* PROPRIEDADES REFERENTES AOS DADOS ADICIONAIS DA *}
    {* FÓRMULA.                                        *}
    {** 14/07/2008 - 09:44 **************************MV*}
    property blnDadosAdicionais: Boolean Read FDadosAdicionais;
    property strCaptionAdicional: String Read FCaptionAdicional;
    property stlListaAdicional: TStringList Read FListaAdicional;
    property blnAdicionalConcentrado: Boolean Read FAdicionalConcentrado;
    property blnAdicionalDiluido: Boolean Read FAdicionalDiluido;
    property intIndiceAdicional: Integer Read FIndiceAdicional Write FIndiceAdicional;

    property fltPrecoCusCon: Double Read FPrecoCusCon;
    property fltPrecoCusDil: Double Read FPrecoCusDil;
    property fltPrecoCu2Con: Double Read FPrecoCu2Con;
    property fltPrecoCu2Dil: Double Read FPrecoCu2Dil;
    property fltPrecoVenCon: Double Read GetPrecoVenCon;
    property fltPrecoVenDil: Double Read GetPrecoVenDil;
    property fltPrecoEmbalagem: Double Read GetPrecoEmbalagemInterna;
    property fltPrecoMedioEmbalagem: Double read GetPreMedEmbalagemInterna;
    property fltUltimoImpostoEmbalagem: Double read GetImpUltEmbalagemInterna;
    property fltPreUltEmbalagem: Double read GetPreUltEmbalagemInterna;
    property fltPrecoCustoEmbalagem: Double Read GetPrecoCustoEmbalagemInterna;
    property fltPrecoCusto2Embalagem: Double Read GetPrecoCusto2EmbalagemInterna;
    property fltPrecoCompraLiquidoEmbalagem: Double read GetPrecoCompraLiquidoEmbalagemInterna;

    property strTabPre: String Read FTabPre Write FTabPre;
    property strOpcDoc: String read FstrOpcDoc write SetstrOpcDoc;
    property strCodEmpEst: String read FstrCodEmpEst write SetstrCodEmpEst; //EMPRESA ESTOQUE
    property intQtdEmb: Integer read FintQtdEmb write SetintQtdEmb;

    property blnConsiderarEmbalagem: Boolean Read FConsiderarEmbalagem Write FConsiderarEmbalagem;
    property fltFatorAcerto: Double Read FFatorAcerto Write FFatorAcerto;
    property AcertoValor: Boolean Read GetAcertoValor;

    property strCodFormul: String read FCodFormul Write FCodFormul;

    property fltOutValCon: Double read FOutValCon;
    property fltIcmsaiCon: Double read FIcmsaiCon;
    property fltImpFedCon: Double read FImpFedCon;
    property fltDesOpeCon: Double read FDesOpeCon;

    property fltOutValDil: Double read FOutValDil;
    property fltIcmsaiDil: Double read FIcmsaiDil;
    property fltImpFedDil: Double read FImpFedDil;
    property fltDesOpeDil: Double read FDesOpeDil;

    property fltPreMedDil: Double read FPreMedDil;
    property fltPreMedCon: Double read FPreMedCon;

    property fltPreUltCon: Double read FPreUltCon;
    property fltPreUltDil: Double read FPreUltDil;
    property fltImpUltCon: Double read FImpUltCon;
    property fltImpUltDil: Double read FImpUltDil;
    property fltComLiqCon: Double read FComLiqCon;
    property fltComLiqDil: Double read FComLiqDil;

    property StrPromoc: string read FPromoc;

    property blnCalculaUnitario: Boolean read FBlnCalculaUnitario write FBlnCalculaUnitario;

    property strCodCli: String Read FCodCli Write FCodCli;
    property strCodCnd: String Read FCodCnd Write FCodCnd;
    property intPrzMed: Integer Read FPrzMed Write FPrzMed;
    property blnProPre: Boolean Read FProPre Write FProPre;

    property EmpPrd: String Read strEmpPrd Write strEmpPrd;
    property OprFlj: String Read strOprFlj Write strOprFlj;
    property EmpCd_: String Read strEmpCd Write strEmpCd;
    property EmpFat: String Read strEmpFat Write strEmpFat;
    property CD_S_N: String Read strCD_S_N Write strCD_S_N;
    property FatS_N: String Read strFatS_N Write strFatS_N;

    //Brazilian Color
    property fltAcrMaoObr: Double Read FAcrMob Write FAcrMob;

    property OnEmbalagemMudou: TEmbalagemMudouEvent Read FEmbalagemMudou Write FEmbalagemMudou;
  End;

Type
  TColoranteImobiliario = class(TCollectionItem)
  private
    FCodCol: String;
    FQtdCol: Double;
    FPreCus: Double;
    FPreVen: Double;
    FImpDir: string;
    FCodIte: string;

    FIcmSai: Double;
    FOutVal: Double;
    FImpFed: Double;
    FDesOpe: Double;
    FPesEsp: Double;
    FPreMed: Double;
    FEmbala: Double;

    FPreUlt: Double;
    FImpUlt: Double;
    FComLiq: Double;
    FPromoc: String;

    FCodCli: String;
    FCodCnd: String;

    function GetPreCu2: Double;
  public
    property strCodCol: String Read FCodCol Write FCodCol;
    property fltQtdCol: Double Read FQtdCol Write FQtdCol;
    property fltPreCus: Double Read FPreCus Write FPreCus;
    property fltPreCu2: Double Read GetPreCu2;
    property fltPreVen: Double Read FPreVen Write FPreVen;
    property strImpDir: string read FImpDir write FImpDir;
    property strCodIte: string read FCodIte write FCodIte;

    property fltOutVal: Double Read FOutVal Write FOutVal;
    property fltIcmSai: Double Read FIcmSai Write FIcmSai;
    property fltImpFed: Double Read FImpFed Write FImpFed;
    property fltDesOpe: Double Read FDesOpe Write FDesOpe;
    property fltPesEsp: Double Read FPesEsp write FPesEsp;
    property fltPreMed: Double read FPreMed write FPreMed;
    property fltEmbala: Double read FEmbala write FEmbala;
    property fltPreUlt: Double read FPreUlt write FPreUlt;
    property fltImpUlt: Double read FImpUlt write FImpUlt;
    property fltComLiq: Double read FComLiq write FComLiq;
    property StrPromoc: String read FPromoc write FPromoc;
    property strCodCli: String Read FCodCli Write FCodCli;
    property strCodCnd: String Read FCodCnd Write FCodCnd;
  End;

Type
  TComponenteIndustrial = class(TColoranteImobiliario)
  private
    FfltPesEsp: Double;
    FstrTipComp: String;
    procedure SetfltPesEsp(const Value: Double);
    procedure SetstrTipComp(const Value: String);
  public
    property strTipComp: String read FstrTipComp write SetstrTipComp;
    property fltPesEsp: Double read FfltPesEsp write SetfltPesEsp;
    constructor Create(Collection: TCollection); override;
  End;

Type
  TFormulaImobiliaria = class(TCollection)
  private
    FstrOpcDoc: String;
    FstrCodEmpEst: String;
    FfltFatorEstoque: Double;
    procedure SetstrOpcDoc(const Value: String);
    procedure SetstrCodEmpEst(const Value: String);
    procedure SetfltFatorEstoque(const Value: Double);
    procedure SetDescri(const Value: String);
  protected
    FIteBasOri: String;
    FCusBasOri: Double;
    FCu2BasOri: Double;
    FVenBasOri: Double;

    FIteBas: String;
    FCusBas: Double;
    FCu2Bas: Double;
    FVenBas: Double;

    FCusCol: Double;
    FCu2Col: Double;
    FVenCol: Double;

    FPreCus: Double;
    FPreCu2: Double;
    FPreVen: Double;

    FQtdTin: Integer;

    FUnidad: String;
    FDescri: String;
    FDesAdi: String;
    FCalculo: TStringList;

    FTabPre: String;

    qryCadCol: TUniQuery;

    FOutVal: Double;
    FIcmsai: Double;
    FImpFed: Double;
    FDesOpe: Double;
    FPreMed: Double;

    FPreUlt: Double;
    FImpUlt: Double;
    FComLiq: Double;
    FPromoc: String;

    FOutValBas: Double;
    FIcmsaiBas: Double;
    FImpFedBas: Double;
    FDesOpeBas: Double;
    FPreMedBas: Double;
    FPreUltBas: Double;
    FImpUltBas: Double;
    FComLiqBas: Double;

    FBlnCalculaUnitario: Boolean;

    FtintaDeMaquina: TGenericTintaDeMaquina;

    FCodCli: String;
    FCodCnd: String;
    FPrzMed: Integer;

    type TFormulaImobiliariaRecalculaTabelas = class(TInterfacedObject)
    private
      dicRetorno: TDicionario;
      formulaImobiliaria: TFormulaImobiliaria;
      procedure CalcularTabela;
    public
      constructor Create(const formulaImobiliaria: TFormulaImobiliaria; const dicRetorno: TDicionario);
      procedure Calcular;
    end;


    function GetTintaDeMaquina(): TGenericTintaDeMaquina;
    procedure SetIteBas(const Value: String); virtual;
    procedure pCarregarColorantes; virtual; abstract;
  public
    calculadorFatVendas: ICalculadorFatVendas;
  public
    Constructor Create(strTabPrePar: String); overload; virtual;
    Constructor Create(strTabPrePar: String; ItemClass: TCollectionItemClass); overload;
    Destructor Destroy; override;
    procedure pCarregaPrecosColorantes; virtual; abstract;
    procedure pCalculaPreco; virtual; abstract;

    procedure pRecalculaTabelas(dicRetorno: TDicionario); virtual;
    function fRetMatrizSaldosColorantes(strIteBas: String): TClassMatrizSaldosColorantes; virtual;

    function fTabPreco: String;

    property strIteBasOri: String Read FIteBasOri Write FIteBasOri;
    property fltCusBasOri: Double Read FCusBasOri Write FCusBasOri;
    property fltCu2BasOri: Double Read FCu2BasOri Write FCu2BasOri;
    property fltVenBasOri: Double Read FVenBasOri Write FVenBasOri;

    property strIteBas: String Read FIteBas Write SetIteBas;
    property fltCusBas: Double Read FCusBas;
    property fltCu2Bas: Double Read FCu2Bas;
    property fltVenBas: Double Read FVenBas;

    property fltCusCol: Double Read FCusCol;
    property fltCu2Col: Double Read FCu2Col;
    property fltVenCol: Double Read FVenCol;

    property fltPreCus: Double Read FPreCus;
    property fltPreCu2: Double Read FPreCu2;
    property fltPreVen: Double Read FPreVen;
    property intQtdTin: Integer Read FQtdTin;

    property strUnidad: String Read FUnidad Write FUnidad;
    property strDescri: String Read FDescri Write SetDescri;
    property strDesAdi: String Read FDesAdi Write FDesAdi;
    property stlCalculo: TStringList Read FCalculo Write FCalculo;

    property strTabPre: String Read FTabPre Write FTabPre;
    property strOpcDoc: String read FstrOpcDoc write SetstrOpcDoc;
    property strCodEmpEst: String read FstrCodEmpEst write SetstrCodEmpEst;
    property fltFatorEstoque: Double read FfltFatorEstoque write SetfltFatorEstoque;

    property fltOutVal: Double read FOutVal;
    property fltIcmsai: Double read FIcmsai;
    property fltImpFed: Double read FImpFed;
    property fltDesOpe: Double read FDesOpe;
    property fltPreMed: Double read FPreMed;
    property fltPreUlt: Double read FPreUlt;
    property fltImpUlt: Double read FImpUlt;
    property fltComLiq: Double read FComLiq;
    property StrPromoc: String read FPromoc;

    property fltOutValBas: Double read FOutValBas;
    property fltIcmsaiBas: Double read FIcmsaiBas;
    property fltImpFedBas: Double read FImpFedBas;
    property fltDesOpeBas: Double read FDesOpeBas;
    property fltPreMedBas: Double read FPreMedBas;
    property fltPreUltBas: Double read FPreUltBas;
    property fltImpUltBas: Double read FImpUltBas;
    property fltComLiqBas: Double read FComLiqBas;

    property tintaDeMaquina: TGenericTintaDeMaquina read FtintaDeMaquina;
    property blnCalculaUnitario: Boolean read FBlnCalculaUnitario write FBlnCalculaUnitario;

    property strCodCli: String Read FCodCli Write FCodCli;
    property strCodCnd: String Read FCodCnd Write FCodCnd;
    property intPrzMed: Integer Read FPrzMed Write FPrzMed;

  End;

  TFormulaIndustrial = class(TFormulaImobiliaria)
  private
    procedure SetfltCusBasB(const Value: Double);
    procedure SetfltCu2BasB(const Value: Double);
    procedure SetfltVenBasB(const Value: Double);
  protected
    qryCadBas: TUniQuery;
    FstrCompB: String;
    FfltCusBasB: Double;
    FfltCu2BasB: Double;
    FfltVenBasB: Double;

    FOutValBas2: Double;
    FIcmsaiBas2: Double;
    FImpFedBas2: Double;
    FDesOpeBas2: Double;

    procedure pCarregarBases(dicRetorno: TDicionario); virtual; abstract;
    procedure SetstrCompB(const Value: String); virtual;
  public
    constructor Create(strTabPrePar: String); override;
    function fRetMatrizSaldosColorantes(strIteBas: String): TClassMatrizSaldosColorantes; reintroduce;
    procedure pRecalculaTabelas(dicRetorno: TDicionario); override;


    property strCompB: String read FstrCompB write SetstrCompB;
    property fltCusBasB: Double read FfltCusBasB write SetfltCusBasB;
    property fltCu2BasB: Double read FfltCu2BasB write SetfltCu2BasB;
    property fltVenBasB: Double read FfltVenBasB write SetfltVenBasB;

    property fltOutValBas2: Double read FOutValBas2;
    property fltIcmsaiBas2: Double read FIcmsaiBas2;
    property fltImpFedBas2: Double read FImpFedBas2;
    property fltDesOpeBas2: Double read FDesOpeBas2;
  End;

  {$IFNDEF LINUX}
  function fDesCor(strTitulo, strDesCor: String): String;
  function fDigTipoEmbalagem(stlDesEmb, stlProEmb: TStringList; Var strIteEmb: String): Boolean;
  {$ENDIF}

  function fRetDiluidoPpg(fltPreco: Double; blnPreCus: Boolean): Double;
  function fRetDiluidoZyn(fltPreco: Double; blnPreCus: Boolean): Double;

  procedure pCarregaDadosFormulEtiq(qryTinDet: TDataSet;
    Var ftiDadosEtiq: TFormulEtiq; blnFila: Boolean = True; strEspDoc : String = ''); stdcall;

  procedure pRetornaTabelaPrecoImobiliarias(dicRetorno: TDicionario;
    objFormula: TFormulaImobiliaria; fltFator: Double);

  procedure pRetornaInfoLinha(strLinha: String; Var strLinDil, strBasDil: String;
    Var fltFatBas, fltPerDil: Double; strConDil: String);

  function fGetMd5MySQl(strTexto: String): String;
  function fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe: Double): Double;
  procedure pFormataValores(dicDicionario: TDicionario; intCasas: Integer);
  procedure AcertaImpostos(const fltPreCus, fltPreCu2, fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Extended; dicRetorno: TDicionario);
  function fGetIndexInFormul(const strCodBas: string; const arrFormul: TForMulTinDetArray; const intIndexNaoAcha: Integer): Integer;
  function fTabPreco(strTabPre: String; blnCalculaUnitario: Boolean): String;
  function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
    intPrzMed: Integer; var fltPreCus, fltPreVen: Double; var blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
    strCodEmp: String = ''; fltPrecoTotalColorantes : Double = 0): Boolean;

  function fClienteFilial(strCodCli: String): Boolean; OverLoad;

  function fFormataFloatLaz(fltValor: Double):Double;

  function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;

  function fRetPreCus(strCodEmp, strCodIte: String): Double;

  function fRetornaStatusCadastro(strCodigo, strTipo, strTabela, strCampo: String): String;

  function fDescriLinhaWandaPro(intLinha: Integer): String; stdcall;

  function fArqIniTinta(ReadWrite:Integer;NomChave,NomSecao,Conteudo:String):String;
  function fFormataFloatSky(fltValor: Double): Double;

  function fTintaTemConfiguracoesNoBanco(strIdePro: String): Boolean;

  function fSQLSaldoDisponivel(const AAlias: String = 'G';
                               AFaturamento: Boolean = False;
                               ALote: Boolean = False): string;

  procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere, strMarca, strUnidad: String); Overload;
  procedure pRetDadosItem(strCodIte: String; Var strNome, strRefere, strMarca, strUnidad: String); Overload;

{$IFDEF LINUX}
var
  VS_blnResult: Boolean;{ TODO : remover variavel global }
  VS_blnCodEmpBasDup: Boolean;
  VS_blnCodEmpBasDu2: Boolean;
  VS_blnCodEmpBasDux: Boolean;
{$ENDIF}

implementation

uses
{$IFDEF LINUX}

{$ELSE}
  untFatDigCor, untFatDigTipoEmbalagem, untCfgRel, untGravando,
{$ENDIF}
  untIConfTinta,
  untTintaMaquina, Math,  untParCalculaPrecoCusto, untGenericTintaDeMaquinaComponente,
  untTintaDeMaquinaComponenteComparerEmbalagemAutomotiva, untTintaDeMaquinaComponenteTipo,
  untClientDataSetFactory, StrUtils, untTConfiguracao,
  untCadPro,untITintaDeMaquinaComponente;

const
  cnstEspTinDet: String = 'NF_IF_PA_EP_FF_UC_';

{$IFNDEF LINUX}
function fDesCor(strTitulo, strDesCor: String): String;
begin

  Result := '';

  Try
    pCriarFormularios(TfrmFatDigCor, frmFatDigCor);
    frmFatDigCor.Caption   := strTitulo;
    frmFatDigCor.strDesCor := strDesCor;
    frmFatDigCor.showModal;
  Finally
    If (frmFatDigCor.blnConfirma) Then
      Result := frmFatDigCor.strDesCor;

    FreeAndNil(frmFatDigCor);
  End;

end;
{$ENDIF}

{$IFNDEF LINUX}
function fDigTipoEmbalagem(stlDesEmb, stlProEmb: TStringList;
  Var strIteEmb: String): Boolean;
  Var
    intContador: Integer;
    intPosicao: Integer;
begin
  intPosicao := -1;
  Result     := False;

  Try
    pCriarFormularios(TfrmFatDigTipoEmbalagem, frmFatDigTipoEmbalagem);

    For intContador := 0 To stlDesEmb.Count -1 Do
      frmFatDigTipoEmbalagem.lstTiposEmb.AddItem(IntToStr(intContador+1) + ') ' + stlDesEmb[intContador], Nil);

    Result := (frmFatDigTipoEmbalagem.ShowModal = mrOk);
  Finally
    If (Result) Then
      intPosicao := frmFatDigTipoEmbalagem.lstTiposEmb.ItemIndex;

    FreeAndNil(frmFatDigTipoEmbalagem);
  End;

  strIteEmb := '';

  If (intPosicao >= 0) Then
  Begin
    strIteEmb := stlProEmb[intPosicao];
  End;

end;
{$ENDIF}


{*******************************************}
{* RETORNA O PRECO DA TINTA + DILUENTE     *}
{* blnPreCus INDICA SE O PRECO PASSADO É   *}
{* DE CUSTO OU VENDA                       *}
{****************************************MV*}
function fRetDiluidoPpg(fltPreco: Double; blnPreCus: Boolean): Double;
  Var
    fltValDil: Double;

    fltPreco1: Double;
    fltPreco2: Double;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('PPG');
  fltPreco := fFormataFloat(fltPreco,02);

  If (blnPreCus) Then
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVCD')), 2)
  Else
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVVD')), 2);

  fltPreco1 := fFormataFloat( (fltPreco  / 2.00), 02 );
  fltPreco2 := fFormataFloat( (fltValDil / 2.00), 02 );

  Result    := fFormataFloat(fltPreco1+fltPreco2,02);

end;

{*******************************************}
{* RETORNA O PRECO DA TINTA + DILUENTE     *}
{* blnPreCus INDICA SE O PRECO PASSADO É   *}
{* DE CUSTO OU VENDA                       *}
{****************************************AC*}
function fRetDiluidoNexa(fltPreco: Double; blnPreCus: Boolean): Double;
  Var
    fltValDil: Double;

    fltPreco1: Double;
    fltPreco2: Double;
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('NEX');
  fltPreco := fFormataFloat(fltPreco,02);

  If (blnPreCus) Then
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVCD')), 2)
  Else
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVVD')), 2);

  fltPreco1 := fFormataFloat( (fltPreco  / 2.00), 02 );
  fltPreco2 := fFormataFloat( (fltValDil / 2.00), 02 );

  Result    := fFormataFloat(fltPreco1+fltPreco2,02);
end;


function fRetDiluidoZyn(fltPreco: Double; blnPreCus: Boolean): Double;
  Var
    fltValDil: Double;

    fltPreco1: Double;
    fltPreco2: Double;
    conf: IConfTinta;
begin

  conf     := fGetConfTinta('ZYN');
  fltPreco := fFormataFloat(fltPreco,02);

  If (blnPreCus) Then
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVCD')), 2)
  Else
    fltValDil := fFormataFloat(fStrToFloat(conf.fGet('PATVVD')), 2);

  fltPreco1 := fFormataFloat( (fltPreco  / 2.00), 02 );
  fltPreco2 := fFormataFloat( (fltValDil / 2.00), 02 );

  Result    := fFormataFloat(fltPreco1+fltPreco2,02);

end;

procedure pCarregaDadosFormulEtiq(qryTinDet: TDataSet;
  Var ftiDadosEtiq: TFormulEtiq; blnFila: Boolean = True; strEspDoc : String = '');
  Var
    strCfgExi: String;
    qryCodBar: TUniQuery;
    {$IFNDEF LINUX}
    qryCfgRel: TUniQuery;
    strTipImp: String;
    {$ENDIF}
Begin

  strCfgExi := fCfgSis('EXIDOC');

  qryCodBar := fCriaQuery(Nil);

  qryCodBar.SQL.Add('SELECT ');
  qryCodBar.SQL.Add('  ACA_CODBAR ');
  qryCodBar.SQL.Add('FROM ');
  qryCodBar.SQL.Add('  CADACA ');
  qryCodBar.SQL.Add('  JOIN ');

  {*************************************************}
  {*VERIFICA A CONFIGURAÇÃO SE É VENDA OU ORÇAMENTO*}
  {**********************************************PZ*}
  If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
  Begin
    qryCodBar.SQL.Add(' MOVDET ');
    qryCodBar.SQL.Add('  ON DET_CODACA = ACA_CODACA AND ');
    qryCodBar.SQL.Add('     DET_EMPACA = ACA_CODEMP AND ');
    qryCodBar.SQL.Add('     DET_CODITE = ACA_CODITE ');

    qryCodBar.SQL.Add('WHERE ');
    qryCodBar.SQL.Add('  DET_ESPDOC <> "PR" AND ');
    qryCodBar.SQL.Add('  DET_PROEMB <> "S" AND ');
    qryCodBar.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
    qryCodBar.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
    qryCodBar.SQL.Add('  DET_CODEMP = :CODEMP AND ');
    qryCodBar.SQL.Add('  DET_CODCLI = :CODCLI AND ');
    qryCodBar.SQL.Add('  DET_CODITE = :CODITE AND ');
    qryCodBar.SQL.Add('  DET_CODACA = :CODACA AND ');
    qryCodBar.SQL.Add('  DET_EMPACA = :EMPACA ');

    qryCodBar.ParamByName('NUMDOC').AsString := qryTinDet.FieldByName('DET_NUMDOC').AsString;
    qryCodBar.ParamByName('ESPDOC').AsString := qryTinDet.FieldByName('DET_ESPDOC').AsString;
    qryCodBar.ParamByName('CODEMP').AsString := qryTinDet.FieldByName('DET_CODEMP').AsString;
    qryCodBar.ParamByName('CODCLI').AsString := qryTinDet.FieldByName('DET_CODCLI').AsString;
    qryCodBar.ParamByName('CODITE').AsString := qryTinDet.FieldByName('DET_CODITE').AsString;
    qryCodBar.ParamByName('CODACA').AsString := qryTinDet.FieldByName('DET_CODACA').AsString;
    qryCodBar.ParamByName('EMPACA').AsString := qryTinDet.FieldByName('DET_EMPACA').AsString;
  End
  Else
  Begin
    qryCodBar.SQL.Add(' FATDOR ');

    qryCodBar.SQL.Add('  ON FDO_CODACA = ACA_CODACA AND ');
    qryCodBar.SQL.Add('     FDO_EMPACA = ACA_CODEMP AND ');
    qryCodBar.SQL.Add('     FDO_CODITE = ACA_CODITE ');

    qryCodBar.SQL.Add('WHERE ');
    qryCodBar.SQL.Add('  FDO_ESPDOC <> "PR" AND ');
    qryCodBar.SQL.Add('  FDO_PROEMB <> "S" AND ');
    qryCodBar.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
    qryCodBar.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
    qryCodBar.SQL.Add('  FDO_CODEMP = :CODEMP AND ');
    qryCodBar.SQL.Add('  FDO_CODCLI = :CODCLI AND ');
    qryCodBar.SQL.Add('  FDO_CODITE = :CODITE AND ');
    qryCodBar.SQL.Add('  FDO_CODACA = :CODACA AND ');
    qryCodBar.SQL.Add('  FDO_EMPACA = :EMPACA ');

    qryCodBar.ParamByName('NUMDOC').AsString := qryTinDet.FieldByName('FDO_NUMDOC').AsString;
    qryCodBar.ParamByName('ESPDOC').AsString := qryTinDet.FieldByName('FDO_ESPDOC').AsString;
    qryCodBar.ParamByName('CODEMP').AsString := qryTinDet.FieldByName('FDO_CODEMP').AsString;
    qryCodBar.ParamByName('CODCLI').AsString := qryTinDet.FieldByName('FDO_CODCLI').AsString;
    qryCodBar.ParamByName('CODITE').AsString := qryTinDet.FieldByName('FDO_CODITE').AsString;
    qryCodBar.ParamByName('CODACA').AsString := qryTinDet.FieldByName('FDO_CODACA').AsString;
    qryCodBar.ParamByName('EMPACA').AsString := qryTinDet.FieldByName('FDO_EMPACA').AsString;
  End;

  qryCodBar.Open;

  ftiDadosEtiq.strCodBar := qryCodBar.FieldByName('ACA_CODBAR').AsString;

  qryCodBar.Close;
  FreeAndNil(qryCodBar);

  If blnFila Then
  Begin
   {$IFNDEF LINUX}
    qryCfgRel := fCriaQuery;
    TCfgRel.pCarregaConfImpr(qryCfgRel, 'frmFatFormulacaoItens_FORMUL');
    TCfgRel.fPreImpressao(qryCfgRel, ftiDadosEtiq.strNomImp, strTipImp, False);
    FreeAndNil(qryCfgRel);
   {$ENDIF}
  End;

  If qryTinDet.FindField('FOR_CATALI') <> Nil Then
    ftiDadosEtiq.strCatali := qryTinDet.FieldByName('FOR_CATALI').AsString;

  ftiDadosEtiq.strNomCli := qryTinDet.FieldByName('CLI_NOMCLI').AsString;
  ftiDadosEtiq.strEndere := qryTinDet.FieldByName('CLI_ENDERE').AsString;
  ftiDadosEtiq.strEndNum := qryTinDet.FieldByName('CLI_ENDNUM').AsString;
  ftiDadosEtiq.strBairro := qryTinDet.FieldByName('CLI_BAIRRO').AsString;
  ftiDadosEtiq.strCidade := qryTinDet.FieldByName('CID_NOMCID').AsString;
  ftiDadosEtiq.strEstado := qryTinDet.FieldByName('CID_ESTADO').AsString;
  ftiDadosEtiq.strC_E_P_ := qryTinDet.FieldByName('CLI_C_E_P_').AsString;
  ftiDadosEtiq.strFone01 := qryTinDet.FieldByName('CLI_FONE01').AsString;
  ftiDadosEtiq.strFone02 := qryTinDet.FieldByName('CLI_FONE02').AsString;
  ftiDadosEtiq.strDocume := qryTinDet.FieldByName('DOCUME').AsString;

  If (strCfgExi = 'V') Or (Pos(strEspDoc, cnstEspTinDet) > 0) Then
  Begin
    ftiDadosEtiq.strIdePro := qryTinDet.FieldByName('DET_IDEPRO').AsString;
    ftiDadosEtiq.strDesTin := qryTinDet.FieldByName('DET_DESCRI').AsString;

    ftiDadosEtiq.strDilCon := '';
    If (qryTinDet.FieldByName('DET_TIPPRE').AsString = 'C') Then
      ftiDadosEtiq.strDilCon := 'CONCENTRADO'
    Else If (qryTinDet.FieldByName('DET_TIPPRE').AsString = 'D') Then
      ftiDadosEtiq.strDilCon := 'DILUIDO';

    ftiDadosEtiq.strDtaEmi := qryTinDet.FieldByName('DET_DTAENT').AsString + ' - ' +
                              qryTinDet.FieldByName('DET_HORENT').AsString;

    ftiDadosEtiq.strDtaVal := qryTinDet.FieldByName('DET_DTAENT').AsString;

    ftiDadosEtiq.strMontad := qryTinDet.FieldByName('DET_MONTAD').AsString;
    ftiDadosEtiq.strAnoTin := qryTinDet.FieldByName('DET_A_N_O_').AsString;
    ftiDadosEtiq.fltQtdTin := qryTinDet.FieldByName('DET_QTDEMB').AsFloat;

    if (qryTinDet.FindField('DET_NOMOPE') <> Nil) then
      ftiDadosEtiq.strNomOpe := qryTinDet.FieldByName('DET_NOMOPE').AsString;

    {***************************************************}
    {* COLOR PRO NÃO TEM A DESCRIÇÃO DA LINHA NO CAMPO *}
    {************************************************AL*}
    if Assigned(qryTinDet.FindField('DET_LINTIN')) then
    begin
    If ftiDadosEtiq.strIdePro = 'WCP' Then
      ftiDadosEtiq.strLinha  := fDescriLinhaWandaPro(StrToIntDef(qryTinDet.FieldByName('DET_LINTIN').AsString, 0))
    Else
      ftiDadosEtiq.strLinha  := qryTinDet.FieldByName('DET_LINTIN').AsString;
    end;

    ftiDadosEtiq.strCodCli := qryTinDet.FieldByName('DET_CODCLI').AsString;
  End
  Else
  Begin
    ftiDadosEtiq.strIdePro := qryTinDet.FieldByName('FDO_IDEPRO').AsString;
    ftiDadosEtiq.strDesTin := qryTinDet.FieldByName('FDO_DESCRI').AsString;

    ftiDadosEtiq.strDilCon := '';
    If (qryTinDet.FieldByName('FDO_TIPPRE').AsString = 'C') Then
      ftiDadosEtiq.strDilCon := 'CONCENTRADO'
    Else If (qryTinDet.FieldByName('FDO_TIPPRE').AsString = 'D') Then
      ftiDadosEtiq.strDilCon := 'DILUIDO';

    ftiDadosEtiq.strDtaEmi := qryTinDet.FieldByName('FDO_DTAENT').AsString + ' - ' +
                              qryTinDet.FieldByName('FDO_HORENT').AsString;

    ftiDadosEtiq.strDtaVal := qryTinDet.FieldByName('FDO_DTAENT').AsString;

    ftiDadosEtiq.strMontad := qryTinDet.FieldByName('FDO_MONTAD').AsString;
    ftiDadosEtiq.strAnoTin := qryTinDet.FieldByName('FDO_A_N_O_').AsString;
    ftiDadosEtiq.fltQtdTin := qryTinDet.FieldByName('FDO_QTDEMB').AsFloat;

    if (qryTinDet.FindField('FDO_NOMOPE') <> Nil) then
      ftiDadosEtiq.strNomOpe := qryTinDet.FieldByName('FDO_NOMOPE').AsString;

    {***************************************************}
    {* COLOR PRO NÃO TEM A DESCRIÇÃO DA LINHA NO CAMPO *}
    {************************************************AL*}
    if Assigned(qryTinDet.FindField('FDO_LINTIN')) then
    begin
      If ftiDadosEtiq.strIdePro = 'WCP' Then
        ftiDadosEtiq.strLinha  := fDescriLinhaWandaPro(StrToIntDef(qryTinDet.FieldByName('FDO_LINTIN').AsString, 0))
      Else
        ftiDadosEtiq.strLinha  := qryTinDet.FieldByName('FDO_LINTIN').AsString;
    end;

    ftiDadosEtiq.strCodCli := qryTinDet.FieldByName('FDO_CODCLI').AsString;
  End;

End;

{ TFormulaAutomotiva }

constructor TFormulaAutomotiva.Create(strTabPrePar: String);
begin
  inherited Create(TBaseAutomotiva);
  FBlnCalculaUnitario := True;

  FConsiderarEmbalagem := True;

  qryCadBas := fCriaQuery(Nil);
  qryBasEmp := fCriaQuery(Nil);
  FTabPre := strTabPrePar;

  If fEmptyStr(FTabPre) Then
    FTabPre := '1';

  pCarregarColorantes;
  blnComCatalisador := False;

  FCalculo := TStringList.Create;

  FDadosAdicionais      := False;
  FCaptionAdicional     := '';
  FListaAdicional       := TStringList.Create;
  FAdicionalConcentrado := False;
  FAdicionalDiluido     := False;
  FIndiceAdicional      := -1;

  If AcertoValor Then
    FFatorAcerto          := 0.0
  Else
    FFatorAcerto          := 1.0;

  FCodFormul            := '';

  tintaDeMaquina[mvConcentrado] := TGenericTintaDeMaquina.Create();
  tintaDeMaquina[mvDiluido] := TGenericTintaDeMaquina.Create();

  FEmbalagemMudou := Nil;
end;

constructor TFormulaAutomotiva.Create(strTabPrePar: String;
  itemClass: TCollectionItemClass);
begin
  inherited Create(itemClass);
  FBlnCalculaUnitario := True;

  FConsiderarEmbalagem := True;

  qryCadBas := fCriaQuery(Nil);
  qryBasEmp := fCriaQuery(Nil);
  FTabPre := strTabPrePar;

  If fEmptyStr(FTabPre) Then
    FTabPre := '1';

  pCarregarColorantes;
  blnComCatalisador := False;

  FCalculo := TStringList.Create;

  FDadosAdicionais      := False;
  FCaptionAdicional     := '';
  FListaAdicional       := TStringList.Create;
  FAdicionalConcentrado := False;
  FAdicionalDiluido     := False;
  FIndiceAdicional      := -1;

  tintaDeMaquina[mvConcentrado] := TGenericTintaDeMaquina.Create();
  tintaDeMaquina[mvDiluido] := TGenericTintaDeMaquina.Create();
end;

destructor TFormulaAutomotiva.Destroy;
begin
  FreeAndNil(qryCadBas);
  FreeAndNil(qryBasEmp);
  inherited;
end;

function fRetDescri(strCampoRetorno, strCampoPesquisa , strNomeTabela , strCodigo: String): String;
  Var
    strSQL   : String;
    qryGenTmp: TUniQuery;

begin
  Try

    qryGenTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
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
      ParamByName('CODIGO').AsString := strCodigo;
      Open;
      Result := FieldByName('RESULTADO').AsString;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

end;

function TFormulaAutomotiva.fRetMatrizSaldosColorantes: TClassMatrizSaldosColorantes;
var
  intCont: Integer;
  objBase: TBaseAutomotiva;
  fltQtdFormul: Double;
  cdsGen: TUniClientDataSet;
begin
  Result := TClassMatrizSaldosColorantes.Create;
  cdsGen := TClientDataSetFactory.GetClientDataSet(qryCadBas);

  If (Not (qryBasEmp.IsEmpty)) Then
    pBasesPorEmpresas(cdsGen, qryBasEmp);

  For intCont := 0 To Self.Count - 1 Do
  Begin
    objBase := TBaseAutomotiva(Items[intCont]);
//    cdsGen.Locate('BAS_CODBAS', objBase.strCodBas, []);
    If (Not fEmptyStr(objBase.strLinBas)) Then
    begin
      cdsGen.Locate('BAS_CODBAS;BAS_LINHA_', VarArrayOf([objBase.strCodBas, objBase.strLinBas]), [])
    end
    Else
      cdsGen.Locate('BAS_CODBAS', objBase.strCodBas, []);

    if (objBase.strTipBas = 'C') and not(self.blnComCatalisador) then
      Continue;

    fltQtdFormul := fCalculaQuantidadeParaBaixaEstoque(objBase);

    If fltQtdFormul > 0 Then
    Begin
      Result.fAdicionar(1, Self.strDescri,
                        cdsGen.FieldByName('BAS_CODITE').AsString,
                        fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', cdsGen.FieldByName('BAS_CODITE').AsString),
                        objBase.strCodBas,
                        fltQtdFormul,
                        BASE_AUTOMOTIVA,
                        IIF(fEmptyStr(objBase.strPesGra), 'N', objBase.strPesGra),
                        objBase.fltEmbala);
    End;
  End;
end;

function TFormulaAutomotiva.fTabPreco: String;
begin
  Result := untFuncEspecificas.fTabPreco(FTabPre, FBlnCalculaUnitario);
end;

procedure TFormulaAutomotiva.pAplicarAcrescimoPrecoVenda(const aPerAcr: Double; const aRound: Boolean=False);
begin
  FPrecoVenCon := FPrecoVenCon * (1 + aPerAcr);
  FPrecoVenDil := FPrecoVenDil * (1 + aPerAcr);

  FIcmsaiCon   := FIcmsaiCon   * (1 + aPerAcr);
  FIcmsaiDil   := FIcmsaiDil   * (1 + aPerAcr);

  FImpFedCon   := FImpFedCon   * (1 + aPerAcr);
  FImpFedDil   := FImpFedDil   * (1 + aPerAcr);

  FDesOpeCon   := FDesOpeCon   * (1 + aPerAcr);
  FDesOpeDil   := FDesOpeDil   * (1 + aPerAcr);

  If aRound Then
  Begin
    FPrecoVenCon := fFormataFloat(FPrecoVenCon, 2);
    FPrecoVenDil := fFormataFloat(FPrecoVenDil, 2);

    If aPerAcr <> 0 Then
    Begin
      FIcmsaiCon := fFormataFloat(FIcmsaiCon, 2);
      FIcmsaiDil := fFormataFloat(FIcmsaiDil, 2);

      FImpFedCon := fFormataFloat(FImpFedCon, 2);
      FImpFedDil := fFormataFloat(FImpFedDil, 2);

      FDesOpeCon := fFormataFloat(FDesOpeCon, 2);
      FDesOpeDil := fFormataFloat(FDesOpeDil, 2);
    End;
  End;
end;

function TFormulaAutomotiva.fCalculaQuantidadeParaBaixaEstoque(objBase: TBaseAutomotiva): Double;
begin
  // Somente Salcomix e Glasurit
  If ((objBase.fltQtdPCo > 0) Or (objBase.fltQtdPDi > 0)) Then
    Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil)
  Else If (objBase.strIdePro = 'DUP') Then
    Result := RoundTo(IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) * (Self.fltVolumePro / Self.fltVolumeOri), -1)
  Else
    Result := IfThen(mveModoVenda = mvConcentrado, objBase.fltQtdCon, objBase.fltQtdDil) * (Self.fltVolumePro / Self.fltVolumeOri);
end;

function TFormulaAutomotiva.fCasasDecimaisFormulacao: Integer;
begin
  Result := 3;
end;

function TFormulaAutomotiva.fVerificaSaldosML: Boolean;
  Var
    matrizSaldosColorantes: TClassMatrizSaldosColorantes;
begin
  matrizSaldosColorantes := fRetMatrizSaldosColorantes;
  Result := fVerificaSaldosML(matrizSaldosColorantes);
  FreeAndNil(matrizSaldosColorantes);
end;

function TFormulaAutomotiva.fVerificaEmpresaSetada: String;
begin
  If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    Result := Self.EmpPrd
  Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    Result := Self.EmpCd_
  Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    Result := Self.EmpFat
  Else
    Result := VS_strCodEmp;
end;

function TFormulaAutomotiva.fVerificaSaldosML(
  matrizSaldosColorantes: TClassMatrizSaldosColorantes): Boolean;
  Var
    intCont: Integer;
    strOpcTrava: String;
    qryGen : TUniQuery;
begin
  Result := True;
  strOpcTrava := fCfgSis('COL_' + IIF(Pos(Self.strOpcDoc, 'OR_PD_') > 0, Self.strOpcDoc, 'VN'));

  For intCont := 0 To matrizSaldosColorantes.Count - 1 Do
  Begin
    Result := Result And
      ((matrizSaldosColorantes[intCont].fltQtdFormula > matrizSaldosColorantes[intCont].fltSaldoML)
      And (strOpcTrava = 'N'));
  End;

  If Not Result Then
  Begin
    {*************************************************************************}
    {* VISUALIZAR OS SALDOS NO AUTCOM, POIS O USUARIO IRA ESCOLHER A EMPRESA *}
    {**********************************************************************PH*}
//    fVisualizarSaldoTintas(matrizSaldosColorantes);

    Result := (strOpcTrava = 'A');
  End;

  FreeAndNil(qryGen);

  If FConsiderarEmbalagem Then
  Begin
    pAdicionarEmbalagem(matrizSaldosColorantes);
  End;
end;

function TFormulaAutomotiva.GetAcertoValor: Boolean;
begin
  Result := (fCfgSis('ACEAUT') = 'V');
end;

procedure TFormulaAutomotiva.GetComposicaoPrecoCusto2(var fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Double; fltDesOpeTin: Double);
var
  qryAux: TUniQuery;
  fltPreVenEmb: Double;
begin
  qryAux := nil;

  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;
      qryAux.SQL.Add(' SELECT                               ');
      qryAux.SQL.Add('   G.ITE_PRECUS                       ');
      qryAux.SQL.Add('   , G.ITE_ICMSAI                     ');
      qryAux.SQL.Add('   , G.ITE_IMPFED                     ');
      qryAux.SQL.Add('   , G.ITE_DESOPE                     ');
      qryAux.SQL.Add('   , G.ITE_OUTVAL                     ');

      If fCfgSis('IMPDIG') = '1' Then
        qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
      else
        qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

      If (fCfgSis('PREGER') = '0') Then
        qryAux.SQL.Add('   , G.ITE_PREVE1                     ')
      Else If (fCfgSis('PREGER') = '1') and FBlnCalculaUnitario Then
        qryAux.SQL.Add('   , G.ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVE1       ')
      else
        qryAux.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVE1       ');

      qryAux.SQL.Add(' FROM                                 ');
      qryAux.SQL.Add('   CADITE I                           ');
      qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
      qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
      qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
      qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

      qryAux.ParamByName('CODITE').AsString := strCodEmb;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryAux.Open;

      fltOutVal := qryAux.FieldByName('ITE_OUTVAL').AsFloat;

      if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        fltIcmSai := calculadorFatVendas.fCalculaAliquota(strCodEmb, qryAux.FieldByName('ITE_IMPDIR').AsString)
      else
        fltIcmSai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;

      If (strIdePro = 'GLA') Or (strIdePro = 'SAL') Then
        fltPreVenEmb := Self.GetPrecoEmbalagemInterna
      Else
        fltPreVenEmb := qryAux.FieldByName('ITE_PREVE1').AsFloat;

      fltIcmSai := fltIcmSai * fltPreVenEmb / 100;
      fltImpFed := qryAux.FieldByName('ITE_IMPFED').AsFloat * fltPreVenEmb / 100;
      fltDesOpe := (((qryAux.FieldByName('ITE_DESOPE').AsFloat + fltDesOpeTin) * fltPreVenEmb) / 100);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function TFormulaAutomotiva.GetImpUltEmbalagem: Double;
var
  qryGen: TUniQuery;
begin
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Clear;

      qryGen.SQL.Add('SELECT                     ');
      qryGen.SQL.Add('  ITE_IMPULT               ');
      qryGen.SQL.Add('FROM                       ');
      qryGen.SQL.Add('  ITEGER                   ');
      qryGen.SQL.Add('WHERE                      ');
      qryGen.SQL.Add('  ITE_CODITE = :CODITE AND ');
      qryGen.SQL.Add('  ITE_CODEMP = :CODEMP     ');

      qryGen.ParamByName('CODITE').AsString := strCodEmb;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGen.Open;

      Result := qryGen.FieldByName('ITE_IMPULT').AsFloat;
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

function TFormulaAutomotiva.GetImpUltEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetImpUltEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPreco2CustoEmbalagem: Double;
var
  qryAux: TUniQuery;
  fltIcmSai: Double;
begin
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  qryAux := nil;
  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;

      qryAux.SQL.Add(' SELECT                               ');
      qryAux.SQL.Add('   G.ITE_PRECUS                       ');
      qryAux.SQL.Add('   , G.ITE_ICMSAI                     ');
      qryAux.SQL.Add('   , G.ITE_IMPFED                     ');
      qryAux.SQL.Add('   , G.ITE_DESOPE                     ');
      qryAux.SQL.Add('   , G.ITE_OUTVAL                     ');

      If fCfgSis('IMPDIG') = '1' Then
        qryAux.SQL.Add('   , I.ITE_IMPDIR                     ')
      else
        qryAux.SQL.Add('   , G.ITE_IMPDIR                     ');

      If (fCfgSis('PREGER') = '0') Then
        qryAux.SQL.Add('   , G.ITE_PREVE2 AS ITE_PREVE1       ')
      Else If (fCfgSis('PREGER') = '1') and FBlnCalculaUnitario Then
        qryAux.SQL.Add('   , G.ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVE1       ')
      else
        qryAux.SQL.Add('   , G.ITE_PREVE' + strTabPre + ' AS ITE_PREVE1       ');

      qryAux.SQL.Add(' FROM                                 ');
      qryAux.SQL.Add('   CADITE I                           ');
      qryAux.SQL.Add('   INNER JOIN ITEGER G                ');
      qryAux.SQL.Add('     ON I.ITE_CODITE = G.ITE_CODITE   ');
      qryAux.SQL.Add(' WHERE I.ITE_CODITE = :CODITE         ');
      qryAux.SQL.Add('   AND G.ITE_CODEMP = :CODEMP         ');

      qryAux.ParamByName('CODITE').AsString := strCodEmb;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryAux.Open;

      if fCfgSis('IMPCF4', varBoolean) and Assigned(calculadorFatVendas) then
        fltIcmSai := calculadorFatVendas.fCalculaAliquota(strCodEmb, qryAux.FieldByName('ITE_IMPDIR').AsString)
      else
        fltIcmSai := qryAux.FieldByName('ITE_ICMSAI').AsFloat;

      If FPreVenProCache > 0 Then
      Begin
        Result := fCalculaPrecoCusto2(FPreVenProCache,
                                      FPreCusProCache,
                                      qryAux.FieldByName('ITE_OUTVAL').AsFloat,
                                      fltIcmSai,
                                      qryAux.FieldByName('ITE_IMPFED').AsFloat,
                                      qryAux.FieldByName('ITE_DESOPE').AsFloat);
      End
      Else
      Begin
        Result := fCalculaPrecoCusto2(qryAux.FieldByName('ITE_PREVE1').AsFloat,
                                      qryAux.FieldByName('ITE_PRECUS').AsFloat,
                                      qryAux.FieldByName('ITE_OUTVAL').AsFloat,
                                      fltIcmSai,
                                      qryAux.FieldByName('ITE_IMPFED').AsFloat,
                                      qryAux.FieldByName('ITE_DESOPE').AsFloat);
      End;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function TFormulaAutomotiva.GetPrecoCompraLiquidoEmbalagem: Double;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  Try
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT                     ');
      qryGen.SQL.Add(' ( ITE_PRECOM *            ');
      qryGen.SQL.Add('            (1 - ITE_DESF01 / 100) * ');
      qryGen.SQL.Add('            (1 - ITE_DESF02 / 100) * ');
      qryGen.SQL.Add('            (1 - ITE_DESF03 / 100) * ');
      qryGen.SQL.Add('            (1 - ITE_DESF04 / 100) * ');
      qryGen.SQL.Add('            (1 - ITE_DESF05 / 100) * ');
      qryGen.SQL.Add('            (1 - ITE_DESF06 / 100) ) AS ITE_COMLIQ ');

      qryGen.SQL.Add('FROM                       ');
      qryGen.SQL.Add('  ITEGER                   ');
      qryGen.SQL.Add('WHERE                      ');
      qryGen.SQL.Add('  ITE_CODITE = :CODITE AND ');
      qryGen.SQL.Add('  ITE_CODEMP = :CODEMP     ');

      qryGen.ParamByName('CODITE').AsString := strCodEmb;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGen.Open;

      Result := qryGen.FieldByName('ITE_COMLIQ').AsFloat;
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

function TFormulaAutomotiva.GetPrecoCompraLiquidoEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPrecoCompraLiquidoEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPrecoCusto2EmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPreco2CustoEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPrecoCustoEmbalagem: Double;
  Var
    qryAux: TUniQuery;
begin

  If FPreVenProCache > 0 Then
  Begin
    Result := FPreCusProCache;
    Exit;
  End;

  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT                     ');
  qryAux.SQL.Add('  ITE_PRECUS               ');
  qryAux.SQL.Add('FROM                       ');
  qryAux.SQL.Add('  ITEGER                   ');
  qryAux.SQL.Add('WHERE                      ');
  qryAux.SQL.Add('  ITE_CODITE = :CODITE AND ');
  qryAux.SQL.Add('  ITE_CODEMP = :CODEMP     ');

  qryAux.ParamByName('CODITE').AsString := strCodEmb;

  If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
    qryAux.ParamByName('CODEMP').AsString := Self.EmpPrd
  Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
    qryAux.ParamByName('CODEMP').AsString := Self.EmpCd_
  Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
    qryAux.ParamByName('CODEMP').AsString := Self.EmpFat
  Else
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

  qryAux.Open;

  Result := qryAux.FieldByName('ITE_PRECUS').AsFloat;

  qryAux.Close;
  FreeAndNil(qryAux);
end;

function TFormulaAutomotiva.GetPrecoEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPrecoEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPrecoCustoEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPrecoCustoEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPrecoVenCon: Double;
begin
  Result := FPrecoVenCon;
end;

function TFormulaAutomotiva.GetPrecoVenDil: Double;
begin
  Result := FPrecoVenDil;
end;

function TFormulaAutomotiva.GetPreMedEmbalagem: Double;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  Try
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT                     ');
      qryGen.SQL.Add('  ITE_PREMED               ');
      qryGen.SQL.Add('FROM                       ');
      qryGen.SQL.Add('  ITEGER                   ');
      qryGen.SQL.Add('WHERE                      ');
      qryGen.SQL.Add('  ITE_CODITE = :CODITE AND ');
      qryGen.SQL.Add('  ITE_CODEMP = :CODEMP     ');

      qryGen.ParamByName('CODITE').AsString := strCodEmb;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGen.Open;

      Result := qryGen.FieldByName('ITE_PREMED').AsFloat;
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

function TFormulaAutomotiva.GetPreMedEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPreMedEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPreUltEmbalagem: Double;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  Try
    Try
      qryGen := fCriaQuery(Nil);
      qryGen.SQL.Clear;
      qryGen.SQL.Add('SELECT                     ');
      qryGen.SQL.Add('  ITE_PREULT               ');
      qryGen.SQL.Add('FROM                       ');
      qryGen.SQL.Add('  ITEGER                   ');
      qryGen.SQL.Add('WHERE                      ');
      qryGen.SQL.Add('  ITE_CODITE = :CODITE AND ');
      qryGen.SQL.Add('  ITE_CODEMP = :CODEMP     ');

      qryGen.ParamByName('CODITE').AsString := strCodEmb;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryGen.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryGen.Open;

      Result := qryGen.FieldByName('ITE_PREULT').AsFloat;
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

function TFormulaAutomotiva.GetPreUltEmbalagemInterna: Double;
begin
  If FConsiderarEmbalagem Then
    Result := GetPreUltEmbalagem
  Else
    Result := 0;

  If (FFatorAcerto <> 0.0) Then
  Begin
    If Not AcertoValor Then
      Result := Result * FFatorAcerto;
  End;
end;

function TFormulaAutomotiva.GetPrecoEmbalagem: Double;
var
  qryAux    : TUniQuery;
  cdsGen    : TUniClientDataSet;
  conf      : IConfTinta;
  fltPerAcr : Double;
begin
{$IFNDEF LINUX}
  Result := 0;
{$ENDIF}
  qryAux := nil;

  If FPreVenProCache > 0 Then
  Begin
    Result := FPreVenProCache;
    Exit;
  End;

  conf := fGetConfTinta(FIdePro);
  //Acrescimo no preço de venda da Tinta, incluindo o preço da embalagem
  fltPerAcr := conf.fGetDouble('APREVE') / 100.0;

  Try
    Try
      qryAux := fCriaQuery(Nil);
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT                     ');

      If (fCfgSis('PREGER') = '0') Then
        qryAux.SQL.Add('  ITE_PREVE1               ')
      Else If (fCfgSis('PREGER') = '1') and FBlnCalculaUnitario Then
        qryAux.SQL.Add('  ITE_PREVE' + fCfgSis('TABPRE') + ' AS ITE_PREVE1 ')
      Else
        qryAux.SQL.Add('  ITE_PREVE' + strTabPre + ' AS ITE_PREVE1 ');

      qryAux.SQL.Add('FROM                       ');
      qryAux.SQL.Add('  ITEGER                   ');
      qryAux.SQL.Add('WHERE                      ');
      qryAux.SQL.Add('  ITE_CODITE = :CODITE AND ');
      qryAux.SQL.Add('  ITE_CODEMP = :CODEMP     ');

      qryAux.ParamByName('CODITE').AsString := strCodEmb;
      qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      If (Not fEmptyStr(Self.EmpPrd)) And (Self.OprFlj = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpPrd
      Else If (Not fEmptyStr(Self.EmpCd_)) And (Self.CD_S_N = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpCd_
      Else If (Not fEmptyStr(Self.EmpFat)) And (Self.FatS_N = 'S') Then
        qryAux.ParamByName('CODEMP').AsString := Self.EmpFat
      Else
        qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;

      cdsGen := TClientDataSetFactory.GetClientDataSet(qryAux);

      Result := cdsGen.FieldByName('ITE_PREVE1').AsFloat + (fltPerAcr * cdsGen.FieldByName('ITE_PREVE1').AsFloat);
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryAux) then FreeAndNil(qryAux);
  End;
end;

function TFormulaAutomotiva.GetTemConcentrado: Boolean;
  Var
    intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To Count -1 Do
  Begin
    If (TBaseAutomotiva(Items[intIndex]).fltQtdCon > 0) Then
    Begin
      Result := True;
      Exit;
    End;
  End;

end;

function TFormulaAutomotiva.GetTemDiluido: Boolean;
  Var
    intIndex: Integer;
begin
  Result := False;
  For intIndex := 0 To Count -1 Do
  Begin
    If (TBaseAutomotiva(Items[intIndex]).fltQtdDil > 0) Or
       (TBaseAutomotiva(Items[intIndex]).fltQtdDi2 > 0) Then
    Begin
      Result := True;
      Exit;
    End;
  End;

end;

procedure TFormulaAutomotiva.pAdicionarEmbalagem(matSaldosBases: TClassMatrizSaldosColorantes);
begin
  matSaldosBases.fAdicionar(2, 'EMBALAGEM', Self.strCodEmb,
                            fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', Self.strCodEmb),
                            Self.strCodEmb,
                            Self.intQtdEmb,
                            EMBALAGEM,
                            'N',  //Peso em gramas base
                            0.0); //Embalagem da base
end;

procedure TFormulaAutomotiva.pBasesPorEmpresas(var cdsCadBas: TUniClientDataSet;
  qryGen: TUniQuery);
begin
  qryGen.First;
  While Not qryGen.Eof Do
  Begin
    If cdsCadBas.Locate('BAS_CODBAS', qryGen.FieldByName('BAS_CODBAS').AsString, []) Then
    Begin
      cdsCadBas.Edit;
      cdsCadBas.FieldByName('BAS_CODITE').AsString := qryGen.FieldByName('BAS_CODITE').AsString;
      cdsCadBas.Post;
    End;

    qryGen.Next;
  End;
  cdsCadBas.First;
end;

procedure TFormulaAutomotiva.pCalculaImpostosSaida(dicRetorno: TDicionario);
var
  fltOutVal: Double;
  fltIcmSai: Double;
  fltImpFed: Double;
  fltDesOpe: Double;
  fltPreCus: Double;
  fltPreCu2: Double;
  componente: ITintaDeMaquinaComponente;
begin
  fltPreCus := dicRetorno['precus'];
  fltPreCu2 := dicRetorno['precu2'];
  intQtdEmb := IfNull(dicRetorno['qtdemb'], 1);

  tintaDeMaquina[mvConcentrado].SetQuantidade(intQtdEmb);
  tintaDeMaquina[mvDiluido].SetQuantidade(intQtdEmb);

  Self.GetComposicaoPrecoCusto2(fltOutVal, fltIcmSai, fltImpFed, fltDesOpe, IfNull(dicRetorno['desopetinta'], 0));

  componente := tintaDeMaquina[mvConcentrado].Localizar(TTintaDeMaquinaComponenteComparerEmbalagemAutomotiva.Create(strCodEmb));
  if not Assigned(componente) then
  begin
    componente := tintaDeMaquina[mvConcentrado].Adicionar(TGenericTintaDeMaquinaComponente.Create(
      strCodEmb, fRetNomProduto(strCodEmb), fltDesOpe, fltIcmSai,
      fltImpFed, fltOutVal, GetPrecoCustoEmbalagemInterna, GetPrecoCusto2EmbalagemInterna, GetPreMedEmbalagemInterna,
      GetPrecoEmbalagemInterna, intQtdEmb, tmctEmbalagemAutomotiva
    ));

    tintaDeMaquina[mvDiluido].Adicionar(componente);
  end;

  componente.Quantidade := intQtdEmb;
  componente.CodIte := strCodEmb;
  componente.PrecoCusto := GetPrecoCustoEmbalagemInterna;
  componente.PrecoVenda := GetPrecoEmbalagemInterna;
  componente.PrecoCustoReal := GetPrecoCusto2EmbalagemInterna;
  componente.Descricao := fRetNomProduto(strCodEmb);
  componente.PrecoMedio := GetPreMedEmbalagemInterna;
  componente.Tipo := tmctEmbalagemAutomotiva;
  componente.IcmsSaida := fltIcmSai;
  componente.OutrosValores := fltOutVal;
  componente.ImpostosFederais := fltImpFed;
  componente.DespesasOperacionais := fltDesOpe;
  componente.UltimoPrecoCompraImpostos := fltUltimoImpostoEmbalagem;


  if dicRetorno['tippre'] = 'C' then
  begin
    dicRetorno['outval'] := Self.fltOutValCon;
    dicRetorno['icmsai'] := Self.fltIcmsaiCon;
    dicRetorno['impfed'] := Self.fltImpFedCon;
    dicRetorno['desope'] := Self.fltDesOpeCon;
  end
  else
  begin
    dicRetorno['outval'] := Self.fltOutValDil;
    dicRetorno['icmsai'] := Self.fltIcmsaiDil;
    dicRetorno['impfed'] := Self.fltImpFedDil;
    dicRetorno['desope'] := Self.fltDesOpeDil;
  end;

  AcertaImpostos(fltPreCus,
    fltPreCu2,
    dicRetorno['outval'] + fltOutVal,
    dicRetorno['icmsai'] + fltIcmSai,
    dicRetorno['impfed'] + fltImpFed,
    dicRetorno['desope'] + fltDesOpe,
    dicRetorno);
end;

procedure TFormulaAutomotiva.pCarregaPrecoPromocaoEmbalagem;
  Var
    fltPreCus,
    fltPreVen: Double;
    strCodEmpresa: String;
    blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
begin
  FPreCusProCache := 0;
  FPreVenProCache := 0;

  strCodEmpresa := fVerificaEmpresaSetada();

  If fCarregaPromocao(strCodEmb, fTabPreco, strCodCli, strCodCnd, intPrzMed, fltPreCus, fltPreVen, blnPrecoFixoParaTintaDeMaquinaImobiliaria, strCodEmpresa) Then
  Begin
    FPreCusProCache := fltPreCus;
    FPreVenProCache := fltPreVen;
  End;
end;

procedure TFormulaAutomotiva.pRecalculaTabelas(strTipoPreco: String; dicRetorno: TDicionario);
var
  strTabelas: String;
  intContador: Integer;
begin
  strTabelas := fCfgSis('TABPRC');
  If Length(strTabelas) < 7 Then
    strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

  Self.FBlnCalculaUnitario := False;
  For intContador := 1 To Length(strTabelas) Do
  Begin
    if strTabelas[intContador] = 'S' then
    begin
      Self.strTabPre := IntToStr(intContador);

      fExecutarModal(Self.pCarregarColorantes, Format('Carregando Bases %s... %d',
        [fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')), intContador]), 'Self.pCarregarColorantes');

      fExecutarModal(Self.pCarregaPrecosBases, Format('Carregando Preços %s... %d',
        [fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')), intContador]), 'Self.pCarregaPrecosBases');

      fExecutarModal(Self.pCalcularPrecos, Format('Calculando Preços %s... %d',
        [fRetornaNomeTinta(IfNull(dicRetorno['idepro'], '')), intContador]), 'Self.pCalcularPrecos');

      If strTipoPreco = 'C' Then
        dicRetorno['preve' + IntToStr(intContador)] := Self.fltPrecoVenCon + Self.fltPrecoEmbalagem
      Else
        dicRetorno['preve' + IntToStr(intContador)] := Self.fltPrecoVenDil + Self.fltPrecoEmbalagem;

      if intContador = IfNull(dicRetorno['tabpre'], 0) then
      Begin
        dicRetorno['promoc'] := Self.StrPromoc;
        pCalculaImpostosSaida(dicRetorno);
      End;
    end;
  End;

  dicRetorno['fatace'] := fltFatorAcerto;
end;

procedure TFormulaAutomotiva.SetCodEmb(const Value: String);
begin
  FCodEmb := Value;
  pCarregaPrecoPromocaoEmbalagem;
  If Assigned(FEmbalagemMudou) Then
    FEmbalagemMudou(Value);
end;

procedure TFormulaAutomotiva.SetintQtdEmb(const Value: Integer);
begin
  FintQtdEmb := Value;
end;

procedure TFormulaAutomotiva.SetstrCodEmpEst(const Value: String);
begin
  FstrCodEmpEst := Value;
end;

procedure TFormulaAutomotiva.SetstrOpcDoc(const Value: String);
begin
  If Pos('_OR_PD_', Value) > 0 Then
    FstrOpcDoc := Value
  Else
    FstrOpcDoc := 'VN';
end;

{ TBaseAutomotiva }

procedure TBaseAutomotiva.SetCodBas(const Value: String);
begin
  FCodBas := Value;
end;

procedure TBaseAutomotiva.SetEmbala(const Value: Double);
begin
  FEmbala := Value;
end;

procedure TBaseAutomotiva.SetLinBas(const Value: String);
begin
  FLinBas := Value;
end;

procedure TBaseAutomotiva.SetPesEsp(const Value: Double);
begin
  FPesEsp := Value;
end;

procedure TBaseAutomotiva.SetPorcen(const Value: Double);
begin
  FPorcen := Value;
end;

procedure TBaseAutomotiva.SetPreVen(const Value: Double);
begin
  FPreVen := Value;
end;

procedure TBaseAutomotiva.SetPreCus(const Value: Double);
begin
  FPreCus := Value;
end;

procedure TBaseAutomotiva.SetQtdCon(const Value: Double);
begin
  FQtdCon := Value;
end;

procedure TBaseAutomotiva.SetQtdDi2(const Value: Double);
begin
  FQtdDi2 := Value;
end;

procedure TBaseAutomotiva.SetQtdDil(const Value: Double);
begin
  FQtdDil := Value;
end;

procedure TBaseAutomotiva.SetQtdPCo(const Value: Double);
begin
  FQtdPCo := Value;
end;

procedure TBaseAutomotiva.SetQtdPDi(const Value: Double);
begin
  FQtdPDi := Value;
end;

procedure TBaseAutomotiva.SetTipBas(const Value: String);
begin
  FTipBas := Value;
end;

{ TFormulaImobiliaria }

constructor TFormulaImobiliaria.Create(strTabPrePar: String);
begin
  inherited Create(TColoranteImobiliario);
  FBlnCalculaUnitario := True;
  FtintaDeMaquina := TGenericTintaDeMaquina.Create();
  FCalculo := TStringList.Create;
  qryCadCol := fCriaQuery(Nil);
  FTabPre := strTabPrePar;

  If fEmptyStr(FTabPre) Then
    FTabPre := '1';

  pCarregarColorantes;
end;

constructor TFormulaImobiliaria.Create(strTabPrePar: String;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FBlnCalculaUnitario := True;
  FCalculo := TStringList.Create;
  qryCadCol := fCriaQuery(Nil);
  FTabPre := strTabPrePar;

  If fEmptyStr(FTabPre) Then
    FTabPre := '1';

  pCarregarColorantes;
end;

destructor TFormulaImobiliaria.Destroy;
begin
  FreeAndNil(qryCadCol);
  FreeAndNil(FCalculo);
  inherited;
end;

function TFormulaImobiliaria.fRetMatrizSaldosColorantes(strIteBas: String): TClassMatrizSaldosColorantes;
var
  intCont: Integer;
  objColorante: TColoranteImobiliario;
  fltQtdFormul: Double;
  cdsCadCol: TUniClientDataSet;
begin
  Result := TClassMatrizSaldosColorantes.Create;
  cdsCadCol := TClientDataSetFactory.GetClientDataSet(qryCadCol);

  For intCont := 0 To Self.Count - 1 Do
  Begin
    objColorante := TColoranteImobiliario(Self.Items[intCont]);
    cdsCadCol.Locate('COL_CODCOL', objColorante.strCodCol, []);

    fltQtdFormul := objColorante.fltQtdCol * Self.fltFatorEstoque;

    If fltQtdFormul > 0 Then
    Begin
      Result.fAdicionar(1, Self.strDescri,
        cdsCadCol.FieldByName('COL_CODITE').AsString,
        fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', cdsCadCol.FieldByName('COL_CODITE').AsString),
        objColorante.strCodCol, fltQtdFormul, COLORANTE,
        'N',  //Peso em gramas base
        0.0); //Embalagem da base
    End;

  End;

  {*************}
  {* ITEM BASE *}
  {**********PH*}
  Result.fAdicionar(1, Self.strDescri, strIteBas,
                    fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', strIteBas),
                    strIteBas, 1, BASE_IMOBILIARIA,
                    'N',  //Peso em gramas base
                    0.0); //Embalagem da base
end;

function TFormulaImobiliaria.fTabPreco: String;
begin
  Result := untFuncEspecificas.fTabPreco(FTabPre, FBlnCalculaUnitario);
end;

function TFormulaImobiliaria.GetTintaDeMaquina: TGenericTintaDeMaquina;
begin
  Result := FtintaDeMaquina;
end;

procedure TFormulaImobiliaria.pRecalculaTabelas(dicRetorno: TDicionario);
var
  calculador: TFormulaImobiliariaRecalculaTabelas;
begin
  calculador := nil;
  Try
    Try
      calculador := TFormulaImobiliariaRecalculaTabelas.Create(Self, dicRetorno);
      fExecutarModal(calculador.Calcular, 'Calculando Tabelas de Preço', 'TFormulaImobiliariaRecalculaTabelas');
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(calculador) then FreeAndNil(calculador);
  End;
end;

procedure TFormulaImobiliaria.SetDescri(const Value: String);
begin
  FDescri := Value;
  if Assigned(Self.tintaDeMaquina) then
    Self.tintaDeMaquina.SetDescricao(Value);
end;

procedure TFormulaImobiliaria.SetfltFatorEstoque(const Value: Double);
begin
  FfltFatorEstoque := Value;
end;

procedure TFormulaImobiliaria.SetIteBas(const Value: String);
begin
  FIteBas := Value;
end;

procedure pRetornaTabelaPrecoImobiliarias(dicRetorno: TDicionario;
  objFormula: TFormulaImobiliaria; fltFator: Double);
  Var
    objColorante: TColoranteImobiliario;
    intContador: Integer;
    conf: IConfTinta;
begin
  conf := fGetConfTinta(dicRetorno['idepro']);

  For intContador := 1 To 20 Do
  Begin

    If (fEmptyStr(IfNull(dicRetorno['base' + fStrZero(intContador, 2)], ''))) Then
      Break;

    objColorante := TColoranteImobiliario(objFormula.Add);
    objColorante.strCodCol := dicRetorno['base' + fStrZero(intContador, 2)];
    objColorante.fltQtdCol := fFormataFloat(dicRetorno['qtdb' + fStrZero(intContador, 2)] / fltFator, 3);
  End;

  objFormula.SetIteBas(dicRetorno['itebas']);
  dicRetorno['desopetinta'] := conf.fGetDouble('DESOPE');
  objFormula.pRecalculaTabelas(dicRetorno);
  dicRetorno['precus'] := objFormula.fltPreCus;
  dicRetorno['precu2'] := objFormula.fltPreCu2;
  dicRetorno['premed'] := objFormula.fltPreMed + objFormula.fltPreMedBas;
  dicRetorno['preult'] := objFormula.fltPreUlt + objFormula.fltPreUltBas;
  dicRetorno['impult'] := objFormula.fltImpUlt + objFormula.fltImpUltBas;
  dicRetorno['prctin'] := objFormula.fltComLiq + objFormula.fltComLiqBas;
  dicRetorno.AdicionarObjeto('tintaDeMaquina', objFormula.tintaDeMaquina);
end;

procedure pRetornaInfoLinha(strLinha: String;
  var strLinDil, strBasDil: String; var fltFatBas, fltPerDil: Double;
  strConDil: String);
var
  conf: IConfTinta;
begin
  conf := fGetConfTinta('WCP');

  strLinDil := '';
  strBasDil := '';
  fltFatBas := 0.0;
  fltPerDil := 0.0;

  If (strLinha = '4') Then
  Begin
    strLinDil := conf.fGet('LD1WAN');
    strBasDil := conf.fGet('BD1WAN');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '1') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_50');
    strBasDil := conf.fGet('BD1ABS_100_50');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '14') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_100_80');
    strBasDil := conf.fGet('BD1ABS_100_80');
    fltPerDil := 44.4;
  End
  Else If (strLinha = '8') Then
  Begin
    strLinDil := conf.fGet('LD1PU_HS');
    strBasDil := conf.fGet('BD1PU_HS');

    If strConDil = 'DIL' Then
      fltPerDil := 23.076
    Else
      fltPerDil := 25;
  End
  Else If (strLinha = '58') Then
  Begin
    strLinDil := conf.fGet('LD1PU_MS');
    strBasDil := conf.fGet('BD1PU_MS');
    fltPerDil := 20;
  End
  Else If (strLinha = '19') Then
  Begin
    strLinDil := conf.fGet('LD1ABS_BASELINE');
    strBasDil := conf.fGet('BD1ABS_BASELINE');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '16') Then
  Begin
    strLinDil := conf.fGet('LD1BT120');
    strBasDil := conf.fGet('BD1BT120');
    fltPerDil := 30;
  End
  Else If (strLinha = '59') Then
  Begin
    strLinDil := conf.fGet('LD1BT90');
    strBasDil := conf.fGet('BD1BT90');
    //fltPerDil := 25;
  End
  Else If (strLinha = '37') Then
  Begin
    strLinDil := conf.fGet('LD1BT80');
    strBasDil := conf.fGet('BD1BT80');
    fltPerDil := 15;
  End
  Else If (strLinha = '13') Then
  Begin
    strLinDil := conf.fGet('LD1BT100');
    strBasDil := conf.fGet('BD1BT100');
    If strConDil = 'DIL' Then
      fltPerDil := 10
    Else
      fltPerDil := 25;
  End
  Else If (strLinha = '12') Then
  Begin
    strLinDil := conf.fGet('LPAPB_10080');
    strBasDil := conf.fGet('BPAPB_10080');
    fltPerDil := 33.33;
  End
  Else If (strLinha = '72') Then
  Begin
    strLinDil := Conf.fGet('LD1BT362');
    strBasDil := Conf.fGet('BD1BT362');
    fltPerDil := 11.111;
  End;

  If (fltPerDil > 0.0) Then
    fltFatBas := (100 - fltPerDil) / 100;

end;

procedure TFormulaImobiliaria.SetstrCodEmpEst(const Value: String);
begin
  FstrCodEmpEst := Value;
end;

procedure TFormulaImobiliaria.SetstrOpcDoc(const Value: String);
begin
  If Pos('_OR_PD_', Value) > 0 Then
    FstrOpcDoc := Value
  Else
    FstrOpcDoc := 'VN';
end;

{ TComponenteIndustrial }

constructor TComponenteIndustrial.Create(Collection: TCollection);
begin
  inherited;
  FstrTipComp := '';
  FfltPesEsp := 0;
end;

procedure TComponenteIndustrial.SetfltPesEsp(const Value: Double);
begin
  FfltPesEsp := Value;
end;

procedure TComponenteIndustrial.SetstrTipComp(const Value: String);
begin
  FstrTipComp := Value;
end;

{ TFormulaIndustrial }

constructor TFormulaIndustrial.Create(strTabPrePar: String);
begin
  inherited Create(TColoranteImobiliario);
  FCalculo := TStringList.Create;
  qryCadCol := fCriaQuery(Nil);
  FTabPre := strTabPrePar;

  If fEmptyStr(FTabPre) Then
    FTabPre := '1';

  pCarregarColorantes;
end;

function TFormulaIndustrial.fRetMatrizSaldosColorantes(
  strIteBas: String): TClassMatrizSaldosColorantes;
  Var
    recSaldo: TSaldosColorantes;
begin
  Result := inherited fRetMatrizSaldosColorantes(strIteBas);

  If Not fEmptyStr(strCompB) Then
  Begin
    recSaldo.intIDTinta := 1;
    recSaldo.strDescTinta := Result[Result.Count - 1].strDescTinta;
    recSaldo.strCodIte := strCompB;
    recSaldo.strDesIte := fRetDescri('ITE_DESITE', 'ITE_CODITE', 'CADITE', recSaldo.strCodIte);
    recSaldo.fltQtdFormula := 1;
    reCSaldo.strBasCol := BASE_IMOBILIARIA;
    Result.fAdicionar(recSaldo);
  End;

end;

procedure TFormulaIndustrial.pRecalculaTabelas(dicRetorno: TDicionario);
  Var
    strTabelas: String;
    intContador: Integer;
begin
  strTabelas := fCfgSis('TABPRC');
  If Length(strTabelas) < 7 Then
    strTabelas := strTabelas + StringOfChar('N',7 - Length(strTabelas));

  For intContador := 1 To Length(strTabelas) Do
  Begin
    Self.strTabPre := IntToStr(intContador);
    Self.fltCusBasOri := 0.0;
    Self.fltCu2BasOri := 0.0;

    Self.strIteBas := Self.strIteBas;
    if (Self.strCompB <> Self.strIteBas) and (not fEmptyStr(Self.strCompB)) then
      Self.strCompB := Self.strCompB
    else
      Self.strCompB := Self.strIteBas;

    Self.pCarregarColorantes;
    Self.pCarregaPrecosColorantes;
    Self.pCalculaPreco;

    dicRetorno['preve' + IntToStr(intContador)] := Self.fltPreVen;

    if intContador = IfNull(dicRetorno['tabpre'], 0) then
    begin
      AcertaImpostos(fltPreCus, Self.fltPreCu2,
        Self.fltOutVal + Self.fltOutValBas + Self.fltOutValBas2,
        Self.fltIcmsai + Self.fltIcmsaiBas + Self.fltIcmsaiBas2,
        Self.fltImpFed + Self.fltImpFedBas + Self.fltImpFedBas2,
        Self.fltDesOpe + Self.fltDesOpeBas + Self.fltDesOpeBas,
        dicRetorno);
    end;
  End;
end;

procedure TFormulaIndustrial.SetfltCu2BasB(const Value: Double);
begin
  fltCu2BasB := Value;
end;

procedure TFormulaIndustrial.SetfltCusBasB(const Value: Double);
begin
  FfltCusBasB := Value;
end;

procedure TFormulaIndustrial.SetfltVenBasB(const Value: Double);
begin
  FfltVenBasB := Value;
end;

procedure TFormulaIndustrial.SetstrCompB(const Value: String);
begin
  FstrCompB := Value;
end;

function fGetMd5MySQl(strTexto: String): String;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT UPPER(CAST(MD5("' + strTexto + '") AS CHAR)) SAIDA';
  qryGen.Open;
  Result := qryGen.FieldByName('SAIDA').AsString;
  FreeAndNil(qryGen);
end;

function fCalculaPrecoCusto2(fltPreVen, fltPreCus, fltOutVal, fltICMSai,
   fltImpFed, fltDesOpe: Double): Double;
  Var
    parcus: TParCalculaPrecoCusto;
begin
  parcus := TParCalculaPrecoCusto.Create(Nil, TConfiguracao.fGetConfiguracao);
  If fltIcmSai < 0 Then
    Result := fltPreCus
  Else
    Result := parcus.fCalculaPrecoCustoRealVenda(fltPreVen, fltPreCus, fltOutVal, fltICMSai, fltImpFed, fltDesOpe, 0, 0);
  FreeAndNil(parcus);
end;

procedure AcertaImpostos(const fltPreCus, fltPreCu2, fltOutVal, fltIcmSai, fltImpFed, fltDesOpe: Extended; dicRetorno: TDicionario);
begin
  dicRetorno['outval'] := fltOutVal;
  dicRetorno['icmsai'] := fltIcmSai;
  dicRetorno['impfed'] := fltImpFed;
  dicRetorno['desope'] := fltDesOpe;
end;

{ TColoranteImobiliario }

function TColoranteImobiliario.GetPreCu2: Double;
begin
  Result := fCalculaPrecoCusto2(fltPreVen,
    fltPreCus,
    fltOutVal,
    fltIcmSai,
    fltImpFed,
    fltDesOpe);
end;

{ TFormulaImobiliaria.TFormulaImobiliariaRecalculaTabelas }

procedure TFormulaImobiliaria.TFormulaImobiliariaRecalculaTabelas.Calcular;
var
  strTabelas: String;
  intContador: Integer;
  strTabelaUnica: String;

  function GetDescri(const strDescri: string): string;
  begin
    Result := strDescri;
    if Length(strDescri) > 20 then
      Result := LeftStr(strDescri, 20) + '...';
  end;
begin

  strTabelaUnica := IfNull(Self.dicRetorno['tabelaunica'], '');

  formulaImobiliaria.FBlnCalculaUnitario := False;

  If not fEmptyStr(strTabelaUnica) Then
  Begin
    formulaImobiliaria.strTabPre := strTabelaUnica;
    fExecutarModal(CalcularTabela, Format('Calculando Tabela de Preço %s %d...',
      [GetDescri(IfNull(dicRetorno['descri'], '')), StrToInt(strTabelaUnica)]), 'TFormulaImobiliariaRecalculaTabelas.Calcular');

    dicRetorno['preve' + strTabelaUnica] := formulaImobiliaria.fltPreVen;

    dicRetorno['promoc'] := formulaImobiliaria.StrPromoc;

    AcertaImpostos(formulaImobiliaria.fltPreCus, formulaImobiliaria.fltPreCu2,
      formulaImobiliaria.fltOutVal + formulaImobiliaria.fltOutValBas,
      formulaImobiliaria.fltIcmsai + formulaImobiliaria.fltIcmsaiBas,
      formulaImobiliaria.fltImpFed + formulaImobiliaria.fltImpFedBas,
      formulaImobiliaria.fltDesOpe + formulaImobiliaria.fltDesOpeBas,
      dicRetorno);
  End
  Else
  Begin
    strTabelas := fCfgSis('TABPRC');
    If Length(strTabelas) < 7 Then
      strTabelas := strTabelas + StringOfChar('N',7-Length(strTabelas));

    For intContador := 1 To Length(strTabelas) Do
    Begin
      if strTabelas[intContador] = 'S' then
      begin
        formulaImobiliaria.strTabPre := IntToStr(intContador);
        fExecutarModal(CalcularTabela, Format('Calculando Tabela de Preço %s %d...',
          [GetDescri(IfNull(dicRetorno['descri'], '')), intContador]), 'TFormulaImobiliariaRecalculaTabelas.Calcular');

        dicRetorno['preve' + IntToStr(intContador)] := formulaImobiliaria.fltPreVen;

        if intContador = IfNull(dicRetorno['tabpre'], 0) then
        begin
          dicRetorno['promoc'] := formulaImobiliaria.StrPromoc;

          AcertaImpostos(formulaImobiliaria.fltPreCus, formulaImobiliaria.fltPreCu2,
            formulaImobiliaria.fltOutVal + formulaImobiliaria.fltOutValBas,
            formulaImobiliaria.fltIcmsai + formulaImobiliaria.fltIcmsaiBas,
            formulaImobiliaria.fltImpFed + formulaImobiliaria.fltImpFedBas,
            formulaImobiliaria.fltDesOpe + formulaImobiliaria.fltDesOpeBas,
            dicRetorno);
        end;
      end;
    End;
  End;
end;

procedure TFormulaImobiliaria.TFormulaImobiliariaRecalculaTabelas.CalcularTabela;
begin
  formulaImobiliaria.fltCusBasOri := 0.0;
  formulaImobiliaria.fltCu2BasOri := 0.0;
  formulaImobiliaria.strIteBas := formulaImobiliaria.strIteBas;
  formulaImobiliaria.pCarregarColorantes;
  formulaImobiliaria.pCarregaPrecosColorantes;
  formulaImobiliaria.pCalculaPreco;
end;

constructor TFormulaImobiliaria.TFormulaImobiliariaRecalculaTabelas.Create(
  const formulaImobiliaria: TFormulaImobiliaria; const dicRetorno: TDicionario);
begin
  inherited Create();
  Self.dicRetorno := dicRetorno;
  Self.formulaImobiliaria := formulaImobiliaria;
end;

function fGetIndexInFormul(const strCodBas: string; const arrFormul: TForMulTinDetArray;
  const intIndexNaoAcha: Integer): Integer;
begin
  for Result := Low(arrFormul) to High(arrFormul) do
  begin
    if arrFormul[Result].strFormul = strCodBas then
      Exit;
  end;

  Result := intIndexNaoAcha;
end;

function fTabPreco(strTabPre: String; blnCalculaUnitario: Boolean): String;
begin
  If (fCfgSis('PREGER') = '0') Then
  begin
    Result := '1';
  end
  Else If (fCfgSis('PREGER') = '1') and blnCalculaUnitario Then
  begin
    Result := fCfgSis('TABPRE');
  end
  else
  begin
    Result := strTabPre;
  end;
end;

procedure pFormataValores(dicDicionario: TDicionario; intCasas: Integer);
  Var
    intCont: Integer;
    strTabPre: String;

  procedure FormataValor(strCampo: String);
  begin
    If dicDicionario[strCampo] <> Null Then
      dicDicionario[strCampo] := fFormataFloat(dicDicionario[strCampo], intCasas);
  end;

begin

  strTabPre := fCfgSis('TABPRC');

  If (dicDicionario['unitar'] <> Null) Then
  Begin
    If (dicDicionario['unitar_sem_formatar'] = Null) Or
       (fFormataFloat(dicDicionario['unitar_sem_formatar'], intCasas) <> dicDicionario['unitar']) Then
    Begin
      dicDicionario['unitar_sem_formatar'] := dicDicionario['unitar'];
    End;
  End;

  FormataValor('unitar');
  FormataValor('precus');
  FormataValor('prvtin');
  FormataValor('precu2');

  For intCont := 1 To Length(strTabPre) Do
  Begin
    FormataValor('preve' + IntToStr(intCont));
  End;

end;

function fClienteFilial(strCodCli: String): Boolean;
begin
  Result := (Not fEmptyStr(strCodCli)) And
            (fCampoTabela('COUNT(*)', 'CADEMP', ['EMP_CLIFIL'], [strCodCli], False) > 0);
end;

function fCarregaPromocao(strCodIte, strTabPre, strCodCli, strCodCnd: String;
  intPrzMed: Integer; var fltPreCus, fltPreVen: Double; var blnPrecoFixoParaTintaDeMaquinaImobiliaria : Boolean;
  strCodEmp: String = ''; fltPrecoTotalColorantes : Double = 0): Boolean;
  Var
  fltComVar,
  fltComAta,
  fltComDis,
  fltQtdDis,
  fltDesF07: Double;
  blnParticiona,
  blnPromo: Boolean;
  strComPro: String;
  strCodPro: String;
begin
  blnPrecoFixoParaTintaDeMaquinaImobiliaria := False;

  If fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  Result := (Not fItemSemNenhumaPromocao(strCodIte, strCodEmp)) And
            (Not fClienteFilial(strCodCli)) And
            (fRetornaPrecosPromocao(strCodIte,
                                    strCodCli,
                                    VS_Date,
                                    0,
                                    0,
                                    0,
                                    intPrzMed,
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
                                    strCodCnd,
                                    '',
                                    '',
                                    False,
                                    False,
                                    '-1',
                                    False,
                                    False,
                                    '',
                                    strCodEmp,
                                    '',
                                    '',
                                    Nil,
                                    False,
                                    '',
                                    Nil,
                                    '',
                                    fltPrecoTotalColorantes));

  If (Result) Then
    blnPrecoFixoParaTintaDeMaquinaImobiliaria := fItemPromocionalComPrecoFixoParaTintaDeMaquinaImobiliaria(strCodIte, strCodPro);
end;

function fFormataFloatLaz(fltValor: Double):Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);
  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 > '5' then
  begin
    strValor2 := Copy(strValor,1,Pos(',',strValor) + 2);
    strValor2 := FormatFloat('###,#0.0',fStrToFloat(strValor2));
    Result := fStrToFloat(strValor2);
  end
  else if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
end;

function fRetPreCus(strCodEmp, strCodIte: String): Double;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
Begin

  qryTmp := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ITE_PRECUS ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  ITEGER ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ITE_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  ITE_CODITE = :CODITE';

  With qryTmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODITE').AsString := strCodIte;

    Open;

    Result := 0;

    If (Not IsEmpty) And (Not FieldByName('ITE_PRECUS').IsNull) Then
      Result := FieldByName('ITE_PRECUS').AsFloat;

    Close;
  End;

  FreeAndNil(qryTmp);

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

function fDescriLinhaWandaPro(intLinha: Integer): String; stdcall;
  Const
  arrLinhaWandaPro : Array[0..20] Of String = (
        ' 1 Autobase Plus 100:50',
        ' 4 Wandabase HS',
        ' 6 Wandalac',
        ' 8 Wanda PU HS',
        ' 9 Wandacar',
        '11 Single Stage Converter',
        '12 Autobase Plus Baseline 100:80',
        '13 Autocoat BT100',
        '14 Autobase Plus 100:80',
        '15 Autocoat BT110',
        '19 Autobase Plus Baseline 100:50',
        '27 Autowave MM',
        '67 Autowave MM 2.0',
        '58 Wanda PU MS',
        '59 Autocoat BT90',
        '72 Tech Fleet PU',
        '16 Autocoat BT120',
        '17 Autocoat BT130',
        '74 Tech Fleet Epoxy',
        '75 Tech Fleet Sintetico',
        '76 Tech Fleet Laca');
Var
    intIndice: Integer;
begin
  Result := '';
  For intIndice := Low(arrLinhaWandaPro) To High(arrLinhaWandaPro) Do
    If intLinha = StrToIntDef(LeftStr(arrLinhaWandaPro[intIndice], 2), 0) Then
    Begin
      Result := arrLinhaWandaPro[intIndice];
      Exit;
    End;
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

function fFormataFloatSky(fltValor: Double): Double;
var
  strValor: String;
  strValor2: String;
begin
  Result   := fltValor;
  strValor := FloatToStr(fltValor);
  if Pos(',',strValor) > 0 then
    strValor2 := Copy(strValor,Pos(',',strValor) + 2,1)
  else
    strValor2 := '0';

  if strValor2 > '0' then
  begin
     strValor2 := Copy(strValor,1,Pos(',',strValor) + 1);
     Result := fStrToFloat(strValor2);
  end;
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
  strBaiFut := '(IFNULL(' + LPrefix + 'QTPDBF, 0) - IFNULL(' + LPrefix + 'SDPDBF, 0))';

  strSalFis :=  Concat('IFNULL(', LPrefix, 'SALDOS, 0) + ',strBaiFut, ' + ',  strFutPre, ' + ', strFutFal, ' + ', strFutAgu,' + ');
  Case fCfgSis('CALSAL', VarInteger) Of
    1:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt;
    2:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre + ' - ' + strFutFal + ' - ' + strFutAgu;
    3:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre + ' - ' + strFutAgu;
    4:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutFal;
    5:   Result := strSalFis + ' - ' + strSalGar + ' - ' + strSalPed + ' - ' + strSalEnd + ' - ' + strSalOrd + ' - ' + strSalExt + ' - ' + strFutPre;
    Else Result := '0';
  End;
End;

{****************************}
{* RETORNA DADOS DO PRODUTO *}
{*************************AF*}
procedure pRetDadosItem(strCodIte, strGrupo: String; Var strNome, strRefere, strMarca, strUnidad: String);
Var
  strSQL: String;
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

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;

      If Not fEmptyStr(strGrupo) Then
        ParamByName('CODGRU').AsString := strGrupo;

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
  untFuncEspecificas.pRetDadosItem(strCodIte, '', strNome, strRefere, strMarca, strUnidad);
end;

end.


