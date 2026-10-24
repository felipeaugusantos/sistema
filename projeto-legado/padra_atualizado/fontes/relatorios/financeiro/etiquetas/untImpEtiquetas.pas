Unit untImpEtiquetas;

Interface

Uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, ComCtrls, Buttons, ExtCtrls,
  Grids, DBGridCitel, DBGrids, StrUtils, EditFocus, Menus, untfuncoesSimples,
  untTypesSistema, TypesRel, untFuncoesEtiquetas, Printers, frxClass,
  frxDBSet, MaskUtils, frxBarcode, Uni, AppEvnts, MaskEditFocus,
  DB, UniClientDataSet, UniDataSetProvider, QColorLabel, untFuncoesRel,
  untFuncoesGenerica, DateUtils, BitBtnLockedIncrem, frxExportCSVTestabilidade,
  untGravando, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit,
  cxProgressBar, Datasnap.DBClient, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, cxDBData,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCitel, cxClasses, cxGridLevel, cxGrid, dxCore,untGerenciaPropriedadesComponentes,
  cxDataControllerConditionalFormattingRulesManagerDialog, untFiltroEtiClientes,
  cxEditRepositoryItems;

Type
  TfrmImpEtiquetas = Class(TfrmPaiSimples)
    pnlBotoesImp: TPanel;
    pnlBusca: TPanel;
    frxDBImpEti: TfrxDBDataset;
    frxPagina: TfrxReport;
    frxEtiqClientes: TfrxReport;
    frxEtiqItensCodBarra: TfrxReport;
    CodigoBarra: TfrxBarCodeObject;
    frxEtiqFornecedores: TfrxReport;
    frxEtiqItensZebra: TfrxReport;
    frxUserDataSet1: TfrxUserDataSet;
    frxEtiqEstruturaCodBarra: TfrxReport;
    frxEtiqDiversos: TfrxReport;
    cdsImpEti: TUniClientDataSet;
    cdsImpEtiNOME: TStringField;
    cdsImpEtiENDERE: TStringField;
    cdsImpEtiBAIRRO: TStringField;
    cdsImpEtiC_E_P_: TStringField;
    cdsImpEtiNOMCID: TStringField;
    cdsImpEtiEst: TUniClientDataSet;
    cdsImpEtiEstESTRUT: TStringField;
    cdsImpEtiEstCODSUB: TStringField;
    cdsImpEtiEstITEM: TStringField;
    cdsImpEtiEstQTDITE: TFloatField;
    cdsImpEtiEstDESPCA: TStringField;
    cdsImpEtiEstQTDETI: TIntegerField;
    cdsImpEtiEstCODBAR: TStringField;
    cdsImpEtiIte: TUniClientDataSet;
    cdsImpEtiIteNOMEMP: TStringField;
    cdsImpEtiIteDESITE: TStringField;
    cdsImpEtiIteQTDETI: TIntegerField;
    cdsImpEtiIteVALITE: TFloatField;
    cdsImpEtiIteCODBAR: TStringField;
    cdsImpEtiIteREFERE: TStringField;
    cdsImpEtiIteSIGUNI: TStringField;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    rdbTermica: TRadioButton;
    rdbMatricial: TRadioButton;
    cdsImpEtiIteCODFAB: TStringField;
    cdsImpEtiIteCODITE: TStringField;
    cdsImpEtiIteLOCFIS: TStringField;
    cdsImpEtiIteCODEMP: TStringField;
    lblPercentDesconto: TColorLabel;
    edtPercentDesconto: TEditFocus;
    lblSimboloDesconto: TColorLabel;
    cdsImpEtiIteVALVIS: TFloatField;
    cdsImpEtiIteCODIGO: TStringField;
    frxReport1: TfrxReport;
    cdsImpEtiIteDESMAR: TStringField;
    lblTotEti: TLabel;
    edtTotEti: TEditFocus;
    cdsImpEtiENDNUM: TStringField;
    cdsImpEtiENDCOM: TStringField;
    cdsPromoc: TUniClientDataSet;
    cdsPromocITE_CODITE: TStringField;
    cdsPromocITE_PREPRO: TFloatField;
    frxReport2: TfrxReport;
    cdsCodBar: TUniClientDataSet;
    cdsCodBarCODITE: TStringField;
    cdsCodBarCODBAR: TStringField;
    cdsImpEtiIteCODAMZ: TStringField;
    cdsArmaze: TUniClientDataSet;
    cdsArmazeCODITE: TStringField;
    cdsArmazeCODAMZ: TStringField;
    btnConfirma: TBitBtnLocked;
    btnSairImp: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    btnMarDes: TBitBtnLocked;
    btnIniBusca: TBitBtnLocked;
    rdgStatus: TRadioGroup;
    pgbEtique: TcxProgressBar;
    rdgSaldos: TRadioGroup;
    BitBtnLocked1: TBitBtnLocked;
    dbgEtiquetasTableView: TcxGridDBTableView;
    dbgEtiquetasLevel1: TcxGridLevel;
    dbgEtiquetas: TcxGrid;
    btnQtdEti: TBitBtnLocked;
    btnEtiquetaEletronica: TBitBtnLocked;
    btnHlpExpEtiEle: TBitBtnLocked;
    frxEtiEletronica: TfrxReport;
    lblPromocao: TLabel;
    btnCfgVisualizacao: TBitBtnLocked;
    cxRepository: TcxEditRepository;
    cxEditQtdEti: TcxEditRepositoryCurrencyItem;
    tmrDesmarcaTodos: TTimer;
    btnCodBar: TBitBtnLocked;
    Panel1: TPanel;
    chkOpcCarregamento: TCheckBox;
    ColorLabel1: TColorLabel;
    ShpJaImp: TShape;
    ShpNaoImp: TShape;
    ShpSemData: TShape;
    lblJaImp: TLabel;
    lblNaoImp: TLabel;
    lblSemData: TLabel;
    Procedure FormShow(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
{    Procedure dbgEtiquetasKeyDown(Sender: TObject; Var Key: Word;
      Shift: TShiftState);}
    Procedure FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
    Procedure btnConfirmaClick(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure btnConfigurarClick(Sender: TObject);
    Procedure dbgEtiquetasDblClick(Sender: TObject);
    Procedure btnMarDesClick(Sender: TObject);
    Procedure btnIniBuscaClick(Sender: TObject);
    Procedure btnSairImpClick(Sender: TObject);
    Procedure FormKeyPress(Sender: TObject; Var Key: Char);
    Procedure frxUserDataSet1CheckEOF(Sender: TObject; Var Eof: Boolean);
    Procedure frxUserDataSet1First(Sender: TObject);
    Procedure frxUserDataSet1GetValue(Const VarName: String;
      Var Value: Variant);
    Procedure frxUserDataSet1Next(Sender: TObject);
    { Procedure dbgEtiquetasDrawColumnCell(Sender: TObject; Const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState); }
    Procedure dbgEtiquetasTitleClick(Column: TColumn);
    Procedure rdbTermicaClick(Sender: TObject);
    Procedure rdbMatricialClick(Sender: TObject);
    Procedure edtPercentDescontoExit(Sender: TObject);
    Function fRetornaSqlDesmarcaCli(blnZerarTodos: Boolean = False): String;
    Function fRetornaSqlFiltroCli: String;
    Function fRetornaSQLCli: String;
    Function fRetQtdSel: Integer;
    Function fImprimeEtiquetaClienteLaser: Boolean;
    Procedure rdgStatusClick(Sender: TObject);
    Procedure rdgSaldosClick(Sender: TObject);
    procedure dbgEtiquetasTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure dbgEtiquetasTableViewDataControllerFilterChanged(Sender: TObject);
    procedure qryItemOnBeforePost(DataSet: TDataSet);
    procedure btnQtdEtiClick(Sender: TObject);
    procedure btnEtiquetaEletronicaClick(Sender: TObject);
    procedure btnHlpExpEtiEleClick(Sender: TObject);
    procedure dbgEtiquetasTableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure btnCfgVisualizacaoClick(Sender: TObject);
    procedure tmrDesmarcaTodosTimer(Sender: TObject);
    procedure btnCodBarClick(Sender: TObject);
    function fProdutoSelPromo: Boolean;
  Private
    { Private declarations }
    frmFiltroEtiClientes : TfrmFiltroEtiClientes;
    qryEtique: TUniQuery;
    qryImpEti: TUniQuery;
    dtsImpEti: TDataSource;
    updImpEti: TUniUpdateSQL;
    objGerenciaPropriedadesComponentes: TGerenciaPropriedadesComponentes;
    intQtdEti: Integer;
    blnMosFil: Boolean;
    blnUsaArm: Boolean;
    blnPedObs: Boolean;
//    blnParKey: Boolean;
    blnImpEst: Boolean;
    blnSalMin: Boolean;
    blnItensDivergentes: Boolean;

    strConEti: String;

    arrPrdGru: TConsultasArray;
    arrSitPro: TConsultasArray;
    arrMarca:  TConsultasArray;
    arrFornec: TConsultasArray;
    arrGrupos: TConsultasArray;
    arrCodAmz: TConsultasArray;
    arrCodLse: TConsultasArray;
    arrPromoc: TConsultasArray;
    arrCodDep: TConsultasArray;

    FPais: TPais;

    { ***************************************** }
    { * VARIAVEIS RELATIVAS ÀS BUSCAS         * }
    { **************************************MV* }
    intIndBusca: Integer;

    { ***************************************** }
    { * MATRIZ QUE REPRESENTARÁ 1 LINHA DE    * }
    { * ETIQUETAS. Ex: EM UMA IMPRESSÃO DE 2  * }
    { * COLUNAS, A MATRIZ CONTERÁ 2 ETIQUETAS * }
    { **************************************MV* }
    arrLinhasEti: Array Of String;
    strTipEti: String;
    strCamQtd: String;
    strAmzEti: String;
    intColAtu: Integer;
    strNomImp: String;
    strNomPro: string;
    strDesPro: string;
    cpuCampos: TCamposUso;
    blnEndCob: Boolean;
    blnTodos: Boolean;
    // Usada para impressao de etiquetas(itens) matricial.
    FPreco: Integer;
    strCodCnd: String;
    strCndDes: String;
    strNumPar: String;
    FDecimais: Integer;
    FValor: Double;
    FInfAdi: String;

    strCfgTipEti: String;
    strSQLAux: String;
    blnPromoc: Boolean;
    blnHabili: Boolean;
    stlPromoc: TStringList;
    blnImpPre: Boolean;
    blnExibePrePro: Boolean;


    strPreTab: string;

    strCodEmpEtiEleAlt: String;
    arrCodEmpEtiEle: TConsultasArray;
    stlCodBar: TStringList;
    strCodEti: String;

    intEstMin: Integer;
    intEstMax: Integer;
    intEstFis: Integer;
    intExibeEstoque: Integer;
    strCodAmz: String;
    blnSalAmz: Boolean;

    tpeTipEtqCliente: TTipoEtiqueta;
    strCodLayEtqCliente : String;

    Function fRetornaSQLFuncionario: String;
    Function fRetornaSqlUpdateFuncionario: String;
    Function fRetornaSqlDesmarcaFuncionario: String;
    Function fFiltraFuncionarios: Boolean;
    Function fSetFiltraFuncionarios(strNomIni: String; strNomFin: String;
      intQtdEti: Integer): Boolean;

    Function fRetornaSqlFiltroFuncionarios: String;
    Function fGetFiltrosFuncionarios(strNomIni: String;
      strNomFin: String): String;
    Function fImprimeEtiquetaFuncionarioLaser: Boolean;
    Function fRetornaFiltroAlteracaoPreco(blnUpdate, blnFilHra: Boolean): String;
    Function fSQLEmpresaPreAlt(strCodEmp: String;
      arrCodEmp: TConsultasArray): String;

    Procedure pSetParamsFuncionarios(strNomIni, strNomFin: String);
    Procedure pQtdeEtiquetaFuncionario(strSQL, strValBus: String;
      strNomIni: String = ''; strNomFin: String = '');

    // *************************************************//
    // PROCEDURES DA UNIT                              //
    // **********************************************ED*//
    Procedure pIncluiCodBarras(strCodIte, strCodBar: String);
    Procedure pAtualizaCamposUso;
    Procedure pAtribuiCamposUso;
    Procedure pFinalizaCamposUso;
    Procedure pAtualizaIMPPRE(strCodIte: String);

    Procedure pAbreFuncionarios;


    Procedure pAbreClientes;
    Procedure pSetParamsClientes(strNomIni, strNomFin, strCodVen, strCodAti,
      strCodCid, strBairro, strEstado, strStatus, strAniIni, strAniFin,
      strCodCli, strCodCac, strCodReg, strRevist, strSexo__, strCGCCPF, strTipCli, strConFin: String);
    Procedure pAbreItens(blnVazio: Boolean = False);
    Procedure pSetParamsItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin,
      strDesIte, strDesSim, strRefere, strCodMar, strCodPro, strCodDep, strCodFor, strLinGru,
      strPrdGru, strSitPro: String;
      arrMarcaP: TConsultasArray; arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray;
      arrFornecP: TConsultasArray; arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
      arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
      blnFiltra: Boolean = True; strLocFis: String = ''; strLocIni: String = '';
      strLocFin: String = ''; strCodAmz: String = ''; strLocIniSup: String = '';
      strLocFinSup: String = ''; strRuaIni: String = ''; strRuaFin: String = '';
      strPredioIni: String = ''; strPredioFin: String = ''; strAndarIni: String = '';
      strAndarFin: String = ''; strApartamentoIni: String = ''; strApartamentoFin: String = ''; strCodLse : String = '';
      strPrecoDtaIni: String = ''; strPrecoDtaFin: String = '');

    Procedure pAbreDiversos;
    Procedure pSetParamsDiversos(strNomIni, strNomFin, strCodCid, strCodAti,
      strBairro, strEstado, strAniIni, strAniFin: String);

    Procedure pAbreFornecedores;
    Procedure pSetParamsFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
      strBairro, strEstado, strRevist: String);

    Procedure pAbreVendedores;
    Procedure pSetParamsVendedor(strNomIni, strNomFin, strCodCid, strBairro,
      strEstado: String);

    Procedure pAbreEstruturas;
    Procedure pSetParamsEstruturas(strDesIni, strDesFin, strLinGru: String);

    Procedure pDigQuantidade(blnValidaAmz: Boolean = False);
    Procedure pAlteraQtdEti(intQtdEti: Integer; strCodAmz: String = ''; strObserv: String = '');

    Procedure pDesmarcarTodos(intQtdEti: Integer; blnVazio: Boolean = False);

    Procedure pImpEtiquetasMatricial;

    Procedure pImpEtiquetasLaserItens;

    Procedure pImpRegistro;
    Procedure pImpArrLinhasEti;
    Procedure pEscolheTabelaPreco(blnComPre: Boolean);

    procedure pLimpaFiltros;

    Procedure pQtdeEtiquetaCliente(strSQL, strValBus: String;
      strNomIni: String = ''; strNomFin: String = ''; strCodVen: String = '';
      strCodAti: String = ''; strCodCid: String = ''; strBairro: String = '';
      strEstado: String = ''; strStatus: String = ''; strAniIni: String = '';
      strAniFin: String = ''; strCodCli: String = ''; strCodCac: String = '';
      strCodReg: String = ''; strRevist: String = ''; strSexo__: String = '';
      strCGCCPF: String = ''; strTipCli: String = ''; strConFin: String = '');

    Procedure pQtdeEtiquetaFornecedor(strSQL, strValBus: String;
      strNomIni: String = ''; strNomFin: String = ''; strCodAti: String = '';
      strCodCid: String = ''; strBairro: String = ''; strEstado: String = '';
      strRevist: String = '');

    Procedure pHabilitaTela(blnHabili: Boolean);
    Procedure pCriarOcorrenciasCRMClientesSelecionados;
    Procedure pCriarOcorrenciasCRM;
//    Procedure pConsulta;

    // *************************************************//
    // FUNCOES DA UNIT                                 //
    // **********************************************ED*//
    Function fMarca(strSQL: String; intQtdEti: Integer): Boolean;
    Function fRetornaSQLOri(blnOriginal: Boolean): String;
    Function fRetornaSqlUpdateCli: String;
    Function fFiltraClientes: Boolean;
    Function fGetFiltrosClientes(strNomIni: String; strNomFin: String;
      strCodVen: String; strCodAti: String; strCodCid: String;
      strBairro: String; strEstado: String; strStatus: String;
      strAniIni: String; strAniFin: String; strCodCli: String;
      strCodCac: String; strCodReg: String; strRevist: String;
      strSexo__: String; strCGCCPF: String;
      strTipCli: String;
      strConFin: String): String;

    Function fSetFiltraClientes(strNomIni: String; strNomFin: String;
      strCodVen: String; strCodAti: String; strCodCid: String;
      strBairro: String; strEstado: String; strStatus: String;
      strAniIni: String; strAniFin: String; intQtdEti: Integer;
      strCodCli: String; strCodCac: String; strCodReg: String;
      strRevist: String; strSexo__: String; strCGCCPF: String;
      strTipCli: String; strConFin: String): Boolean;

    Function fImprimeLaserArgox(tpeTipEti: TTipoEtiqueta;
      strIndexFieldNames: String): Boolean;

    Function fRetornaClientesComVenda(fltVlrFat: Double): String;
    Function fRetornaClientesComUltCompra(fltVlrFat: Double): String;
    Function fRetornaClientesComSemCompra(fltVlrFat: Double): String;


    Function fRetornaSQLIte(blnFilDta, blnPromocPeriod, blnFilHra: Boolean; blnVazio: Boolean = False; tpAltPreEti : TTipoAltPreEti = tpTodos; blnFilEmpEtiEle: Boolean = False; strPreTab : string = 'SSSSSSS'): String;

    Function fRetornaSQLUpdateIte: String;
    Function fRetornaSQLFiltroIte(blnFilDta, blnPromocPeriod, blnFilHra: Boolean; tpAltPreEti : TTipoAltPreEti; strPreTab: string): String;
    Function fGetFiltrosItens(strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
      strCodMar, strCodPro, strCodDep: String; blnCodBar: Boolean; strCodFor, strLinGru,
      strPrdGru, strSitPro: String;
      arrMarcaP: TConsultasArray; arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray;
      arrFornecP: TConsultasArray; arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
      arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
      strIteEmb: String;
      blnFiltra: Boolean = True; strLocFis: String = ''; strLocIni: String = '';
      strLocFin: String = ''; strCodAmz: String = ''; strLocIniSup: String = '';
      strLocFinSup: String = ''; blnPromocPeriod: Boolean = False;
      strRuaIni: String = ''; strRuaFin: String = ''; strPredioIni: String = '';
      strPredioFin: String = ''; strAndarIni: String = ''; strAndarFin: String = '';
      strApartamentoIni: String = ''; strApartamentoFin: String = ''; strCodLse : String = ''; strIteLot : String = 'T' ): String;

    Function fSetFiltraItens(strDtaIni, strDtaFin, strHraIni, strHraFin,  strDesIni, strDesFin,
      strDesIte, strDesSim, strRefere, strCodMar, strCodPro, strCodDep: String; blnCodBar: Boolean;
      strCodFor, strLinGru, strPrdGru: String; strSitPro: String; intQtdEti: Integer;
      arrMarcaP: TConsultasArray; arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray;
      arrFornecP: TConsultasArray; arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
      arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
      strIteEmb: String;
      blnFiltra: Boolean = True; strLocFis: String = ''; strLocIni: String = '';
      strLocFin: String = ''; strCodAmz: String = ''; strLocIniSup: String = '';
      strLocFinSup: String = ''; blnFilPromoc: boolean = False;
      strRuaIni: String = ''; strRuaFin: String = ''; strPredioIni: String = '';
      strPredioFin: String = ''; strAndarIni: String = ''; strAndarFin: String = '';
      strApartamentoIni: String = ''; strApartamentoFin: String = ''; strCodLse : String = '';
      tpAltPreEti : TTipoAltPreEti = tpTodos; strIteLot : String = 'T'; strPrecoDtaIni: String = ''; strPrecoDtaFin: String = '' ): Boolean;

    Function fFiltraItens: Boolean;

    Function fRetornaSQLFor: String;
    Function fRetornaSQLUpdateFor: String;
    Function fRetornaSQLDesmarcaFor: String;
    Function fRetornaSQLFiltroFor: String;
    Function fGetFiltrosFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
      strBairro, strEstado, strRevist: String): String;
    Function fSetFiltraFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
      strBairro, strEstado, strRevist: String; intQtdEti: Integer): Boolean;
    Function fFiltraFornecedores: Boolean;

    Function fRetornaSQLDiv: String;
    Function fRetornaSQLUpdateDiv: String;
    Function fRetornaSQLDesmarcaDiv: String;
    Function fFiltraDiversos: Boolean;
    Function fRetornaSQLFiltroDiv: String;
    Function fGetFiltrosDiversos(strNomIni, strNomFin, strCodCid, strCodAti,
      strBairro, strEstado, strAniIni, strAniFin: String): String;

    Function fSetFiltraDiversos(strNomIni: String; strNomFin: String;
      strCodCid: String; strCodAti: String; strBairro: String;
      strEstado: String; strAniIni: String; strAniFin: String;
      intQtdEti: Integer): Boolean;
    Function fRetornaDiversosComVenda: String;

    Function fRetornaSQLVen: String;
    Function fRetornaSQLUpdateVen: String;
    Function fRetornaSQLDesmarcaVen: String;
    Function fFiltraVendedor: Boolean;
    Function fSetFiltraVendedor(strNomIni: String; strNomFin: String;
      strCodCid: String; strBairro: String; strEstado: String;
      intQtdEti: Integer): Boolean;
    Function fGetFiltrosVendedor(strNomIni, strNomFin, strCodCid, strBairro,
      strEstado: String): String;
    Function fRetornaSQLFiltroVen: String;

    Function fRetornaSQLEstr: String;
    Function fRetornaSQLUpdateEstr: String;
    Function fRetornaSQLDesmarcaEstr: String;
    Function fRetornaSQLFiltroEstr: String;
    Function fGetFiltrosEstruturas(strDesIni, strDesFin,
      strLinGru: String): String;
    Function fSetFiltraEstruturas(strDesIni, strDesFin, strLinGru: String;
      intQtdEti: Integer): Boolean;
    Function fFiltraEstruturas: Boolean;

    Function fLimpaMarcadosCli: Boolean;

    Function fSubSQLPROMOC(strCodCnd, strCndPag, strTabPre, strCodCli, strNumOrc, strEspOrc: String): String;

    Function fLoteCriptografado: String;
    Function fDiaSemanaAlfabeto: String;

    Function fPrimeiraTabPreco: String;

    Function fCriarOcorrenciasCRM(blnResultado: Boolean): Boolean;
    Procedure pAlteraArmazem(strCodAmz: String; strCodIte: String);
    Function fULTALP(blnFilDta: Boolean): String;
    Function fOrderByItens(blnFilDta: Boolean): String;
    function fDataHrAlt(strCodite,strCodEmp: String; strDtaAlt: TDateTime): TDateTime;
    function fDataHrImp(strCodite,strCodEmp: String; strDtaAlt: TDateTime): TDateTime;

    Function fRetListaCodEmpEtiEle: String;
    procedure pLimparVariaveisEtiquetasEletronicas;
    procedure pFiltrarItensEtiquetasEletronicas(DataSet: TDataSet);
    function fRetornaCorPromocional: integer;
    procedure pGravarConfiguracoesEtiqProdutos;
    function fSelecaoTipoEtiquetaCliente: Boolean;
    procedure pValidaAmzVinculado;
    procedure OnCxEditValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Published

    Property intPreco: Integer Read FPreco;
    Property intDecimais: Integer Read FDecimais;
    Property fltValor: Double Read FValor;
    Property strInfAdi: String Read FInfAdi;

  Protected
    Function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; Override;
  Public
    { Public declarations }
    intTipEti: Integer;
    blnMovDet: Boolean;
    strDtaIni: String;
    strDtaFin: String;
    strDtaPro: String;
    strDivVen: String;
    strCliVen: String;
    strTipPer: String;

    strComIni: String;
    strComFin: String;
    strNaoIni: String;
    strNaoFin: String;

    blnViaBol: Boolean;
    strCliBol: String;
    strCodEmpAlt: String;
    arrCodEmp: TConsultasArray;

  End;


Implementation

Uses untConstantes, untDigQtdEti,
  untCadConfRelatorios, untPai, untCnfEtiqueta, untMenuMarcarEti,
  untFiltroEtiItens, untFiltroEtiDiversos,
  untFiltroEtiFornecedores, untPedeObserv,
  untConfirmaPreco, untFiltroEtiEstruturas, untCfgRel, untInfAdicEtiqItens,
  untCadPro, untFuncoesEtiqItens, untFuncMacro, untCadMovOcorrencias,
  untfuncoesConsulta, untFuncoes, untFiltroEtiFuncionarios, untObservacao,
  untExportacaoEtiquetasEletronicasView, untConfigEtiqProduto, untCfgColEtiqItens,
  untSelItensCodBar;

{$R *.dfm}
{ TfrmImpEtiquetas }

Function TfrmImpEtiquetas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Begin
  Result := True;
  If (Inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    { ***************************************** }
    { * VERIFICA DESCONTO ENTRE 0 E 100       * }
    { **************************************AA* }
    If (Sender = edtPercentDesconto) Then
    Begin
      If Not fEmptyStr(edtPercentDesconto.Text) Then
      Begin
        If Not fValidaEscala(edtPercentDesconto.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!',
            'O percentual de desconto deve estar entre 0 e 100 !', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
End;

Function TfrmImpEtiquetas.fRetornaSqlDesmarcaCli(blnZerarTodos: Boolean = False): String;
Var
  strUpdCli: String;
Begin
  strUpdCli := '';
  strUpdCli := strUpdCli + 'UPDATE ';
  strUpdCli := strUpdCli + '  CADCLI ';
  strUpdCli := strUpdCli + 'SET ';
  strUpdCli := strUpdCli + '  CLI_QTDETI = :QTDETI ';

  If Not blnZerarTodos Then
  Begin
    Case rdgStatus.ItemIndex Of
      0:
        strUpdCli := strUpdCli + ' WHERE CLI_STATUS LIKE ' + QuotedStr('%A');
      1:
        strUpdCli := strUpdCli + ' WHERE CLI_STATUS LIKE ' + QuotedStr('%I');
      2:
        strUpdCli := strUpdCli + ' WHERE CLI_STATUS LIKE ' + QuotedStr('%');
    End;

    If blnViaBol Then
      strUpdCli := strUpdCli + ' AND LOCATE(CLI_CODCLI, "' + strCliBol + '")  ';
  End;

  Result := strUpdCli;
End;

Function TfrmImpEtiquetas.fRetornaSqlUpdateCli: String;
Var
  strUpdCli: String;
Begin
  strUpdCli := '';
  strUpdCli := strUpdCli + 'UPDATE ';
  strUpdCli := strUpdCli + '  CADCLI ';
  strUpdCli := strUpdCli + 'SET ';
  strUpdCli := strUpdCli + '  CLI_QTDETI = :CLI_QTDETI ';
  strUpdCli := strUpdCli + 'WHERE ';
  strUpdCli := strUpdCli + '  CLI_CODCLI = :CLI_CODCLI ';
  Case rdgStatus.ItemIndex Of
    0:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%A') + ' ';
    1:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%I') + ' ';
    2:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%') + ' ';
  End;
  Result := strUpdCli;
End;

Function TfrmImpEtiquetas.fRetornaSqlFiltroCli: String;
Var
  strUpdCli: String;
Begin
  strUpdCli := '';
  strUpdCli := strUpdCli + 'UPDATE                     ';
  strUpdCli := strUpdCli + '  CADCLI C, CADCID D1        ';
  strUpdCli := strUpdCli + 'SET                        ';
  strUpdCli := strUpdCli + '  CLI_QTDETI = :CLI_QTDETI ';
  strUpdCli := strUpdCli + 'WHERE                      ';
  strUpdCli := strUpdCli + '  C.CLI_CODCID = CID_CODCID  ';
  Case rdgStatus.ItemIndex Of
    0:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%A') + ' ';
    1:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%I') + ' ';
    2:
      strUpdCli := strUpdCli + ' AND CLI_STATUS LIKE ' + QuotedStr('%') + ' ';
  End;

  If blnViaBol Then
    strUpdCli := strUpdCli + ' AND LOCATE(C.CLI_CODCLI, "' + strCliBol + '")  ';

  If blnMovDet Then
    strUpdCli := strUpdCli + ' AND LOCATE(C.CLI_CODCLI, "' + strCliVen + '")  ';

  Result := strUpdCli;
End;

Function TfrmImpEtiquetas.fRetornaSQLFuncionario: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT * ';

  strSQLAux := '';
  strSQLAux := strSQLAux + ' FROM ';
  strSQLAux := strSQLAux + '   CADFUN ';
  strSQLAux := strSQLAux + ' WHERE    ';
  strSQLAux := strSQLAux + stlCampos[intIndBusca] + ' LIKE :VALBUS ';

  Result := strSQL + strSQLAux;
End;

Procedure TfrmImpEtiquetas.pQtdeEtiquetaFuncionario(strSQL, strValBus: String;
  strNomIni: String = ''; strNomFin: String = '');
Var
  strSQLEti: String;
  qryTotEti: TUniQuery;
Begin
  Try

    qryTotEti := fCriaQuery(Nil);

    strSQLEti := '';
    strSQLEti := strSQLEti + 'SELECT ';
    strSQLEti := strSQLEti + '  SUM(FUN_QTDETI) AS TOTETI ';
    strSQLEti := strSQLEti + strSQLAux;

    With qryTotEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLEti);

      ParamByName('VALBUS').AsString := strValBus;

      If Not fEmptyStr(strNomIni) Then
      Begin
        If Length(strNomIni) > Length(strNomFin) Then
          ParamByName('MAIOR').AsString := strNomIni
        Else
          ParamByName('MAIOR').AsString := strNomFin;

        ParamByName('NOMINI').AsString := strNomIni;
        ParamByName('NOMFIN').AsString := strNomFin;
      End;

      Open;

      If (FieldByName('TOTETI').AsInteger = 0) Then
        edtTotEti.Text := '0'
      Else
        edtTotEti.Text := FieldByName('TOTETI').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImpEtiquetas.pQtdeEtiquetaFunionario]');
  End;

  FreeAndNil(qryTotEti);
End;

Function TfrmImpEtiquetas.fRetornaSqlUpdateFuncionario: String;
Var
  strUpdFun: String;
Begin
  strUpdFun := '';
  strUpdFun := strUpdFun + 'UPDATE ';
  strUpdFun := strUpdFun + '  CADFUN ';
  strUpdFun := strUpdFun + 'SET ';
  strUpdFun := strUpdFun + '  FUN_QTDETI = :FUN_QTDETI ';
  strUpdFun := strUpdFun + 'WHERE ';
  strUpdFun := strUpdFun + '  FUN_CODFUN = :FUN_CODFUN ';
  Result := strUpdFun;
End;

Function TfrmImpEtiquetas.fRetornaSqlDesmarcaFuncionario: String;
Var
  strUpdFun: String;
Begin
  strUpdFun := '';
  strUpdFun := strUpdFun + 'UPDATE ';
  strUpdFun := strUpdFun + '  CADFUN ';
  strUpdFun := strUpdFun + 'SET ';
  strUpdFun := strUpdFun + '  FUN_QTDETI = :QTDETI ';

  Result := strUpdFun;
End;

Procedure TfrmImpEtiquetas.pAbreFuncionarios;
Begin
  Self.Caption := 'Impressão de Etiquetas - Funcionários';
  strCamQtd := 'FUN_QTDETI';


  stlCampos.Add('FUN_QTDETI');
  stlCampos.Add('FUN_CODFUN');
  stlCampos.Add('FUN_NOMFUN');
  stlCampos.Add('FUN_C_P_F_');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
  stlDesInd.Add('C.P.F. Funcionário');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLFuncionario + ' ORDER BY ' + stlCampos[intIndBusca]);
    ParamByName('VALBUS').AsString := '%';
    Open;

    pQtdeEtiquetaFuncionario(strSQLAux, ParamByName('VALBUS').AsString);
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSqlUpdateFuncionario)
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FUN_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FUN_CODFUN';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FUN_NOMFUN';
      Caption := 'Nome';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FUN_C_P_F_';
      Caption := 'C.P.F. Funcionário';
      Width := 100;
    End;
    EndUpdate;
  End;

End;

Procedure TfrmImpEtiquetas.pSetParamsFuncionarios(strNomIni, strNomFin: String);
Begin
  With qryImpEti Do
  Begin
    If Not fEmptyStr(strNomIni) Then
    Begin
      If Length(strNomIni) > Length(strNomFin) Then
        ParamByName('MAIOR').AsString := strNomIni
      Else
        ParamByName('MAIOR').AsString := strNomFin;
      ParamByName('NOMINI').AsString := strNomIni;
      ParamByName('NOMFIN').AsString := strNomFin;
    End;
  End;
End;

Function TfrmImpEtiquetas.fGetFiltrosFuncionarios(strNomIni: String;
  strNomFin: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  If Not fEmptyStr(strNomIni) Then
    strSQL := strSQL + ' AND LEFT(FUN_NOMFUN, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';

  { ********************************************************************** }
  { * ATENÇÃO! QUANDO FIZER ALGUMA ALTERAÇÃO NOS FILTROS DO FUNCIONARIO NÃO  * }
  { * ESQUECER DE ALTERAR OS FILTROS DA PROCEDURE "pQtdeEtiquetaFuncionario" * }
  { * POIS ELA MOSTRA A QUANTIDADES DE ETIQUETAS QUE SERÃO IMPRESSAS.    * }
  { *******************************************************************LA* }
  Result := strSQL;
End;

Function TfrmImpEtiquetas.fSetFiltraFuncionarios(strNomIni: String;
  strNomFin: String; intQtdEti: Integer): Boolean;
Begin
  Result := True;
  Try
    With qryImpEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetornaSqlFiltroFuncionarios +
              fGetFiltrosFuncionarios(strNomIni, strNomFin));
      pSetParamsFuncionarios(strNomIni, strNomFin);
      ParamByName('FUN_QTDETI').AsInteger := intQtdEti;
      ExecSQL;
    End;
  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fRetornaSqlFiltroFuncionarios: String;
Var
  strUpdFun: String;
Begin
  strUpdFun := '';
  strUpdFun := strUpdFun + 'UPDATE                     ';
  strUpdFun := strUpdFun + '  CADFUN                   ';
  strUpdFun := strUpdFun + 'SET                        ';
  strUpdFun := strUpdFun + '  FUN_QTDETI = :FUN_QTDETI ';
  strUpdFun := strUpdFun + 'WHERE TRUE                 ';
  Result := strUpdFun;
End;

Function TfrmImpEtiquetas.fImprimeEtiquetaFuncionarioLaser: Boolean;
Var
  prmDllRel: TParamDllEtiquetas;
Begin
  prmDllRel := TParamDllEtiquetas.Create;
  With prmDllRel Do
  Begin
    If (fCfgSis('ETIFUN') = 'L') Then
      tpeTipEtq := tpeFuncionarioLaser
    Else
      tpeTipEtq := tpeFuncionarioArgox;

    strCamBus := ShortString(stlCampos[intIndBusca]);
  End;

  Result := fImprimeEtiqueta(prmDllRel);
  FreeAndNil(prmDllRel);
End;

Function TfrmImpEtiquetas.fFiltraFuncionarios: Boolean;
Var
  strNomIni: String;
  strNomFin: String;
  strSQL: String;
  strFil: String;
Begin
  Try
    pCriarFormularios(TfrmFiltroEtiFuncionarios, frmFiltroEtiFuncionarios);
    frmFiltroEtiFuncionarios.ShowModal;

    strNomIni := frmFiltroEtiFuncionarios.strNomIni;
    strNomFin := frmFiltroEtiFuncionarios.strNomFin;
    intQtdEti := frmFiltroEtiFuncionarios.intQtdEti;
    blnMosFil := frmFiltroEtiFuncionarios.chkMosFil.Checked;

    Result := frmFiltroEtiFuncionarios.blnConfirma;

    If Result Then
    Begin
      Screen.Cursor := crHourGlass;
      pnlInfo.Caption := 'Aguarde...';
      strFil := '';

      Try
        fSetFiltraFuncionarios(strNomIni, strNomFin, intQtdEti);

        strSQL := fRetornaSQLFuncionario;

        If blnMosFil Then
          strFil := fGetFiltrosFuncionarios(strNomIni, strNomFin);

        strSQL := strSQL + strFil + ' ORDER BY ' + stlCampos[intIndBusca];

        With qryImpEti Do
        Begin

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('VALBUS').AsString := '%';

          If blnMosFil Then
          Begin
            pSetParamsFuncionarios(strNomIni, strNomFin);
          End;

          strSQLAux := strSQLAux + strFil;

          pQtdeEtiquetaFuncionario(strSQLAux, ParamByName('VALBUS').AsString,
            strNomIni, strNomFin);
        End;

        pnlInfo.Caption := '';
        Screen.Cursor := crDefault;
      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[ Filtro de Etiquetas de Funcionarios ]');
        End;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ frmImpEtiquetas.fFiltraFuncionarios ]');
    End;
  End;
  pFreeAndNil(frmFiltroEtiFuncionarios);
End;

Procedure TfrmImpEtiquetas.pAbreClientes;
Begin
  Self.Caption := 'Impressão de Etiquetas - Clientes';
  strCamQtd := 'CLI_QTDETI';
  edtTotEti.Clear;

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }

  stlCampos.Add('CLI_QTDETI');
  stlCampos.Add('CLI_CODCLI');
  stlCampos.Add('CLI_NOMCLI');
  stlCampos.Add('CLI_C_G_C_');
  stlCampos.Add('CID_NOMCID');
  stlCampos.Add('CID_ESTADO');
  stlCampos.Add('CLI_ENDERE');
  stlCampos.Add('CLI_BAIRRO');
  stlCampos.Add('CLI_STATUS');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
  stlDesInd.Add('CPF/CNPJ');
  stlDesInd.Add('Cidade');
  stlDesInd.Add('Estado');
  stlDesInd.Add('Endereço');
  stlDesInd.Add('Bairro');
  stlDesInd.Add('Status');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLCli + ' ORDER BY ' + stlCampos[intIndBusca]);

  //  ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%';;

    ParamByName('VALBUS').AsString := '%';

    Case rdgStatus.ItemIndex Of
      0:
        ParamByName('STATUS').AsString := '%A';
      1:
        ParamByName('STATUS').AsString := '%I';
      2:
        ParamByName('STATUS').AsString := '%';
    End;
    Open;

    pQtdeEtiquetaCliente(strSQLAux, ParamByName('VALBUS').AsString);
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSqlUpdateCli)
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_CODCLI';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_NOMCLI';
      Caption := 'Nome';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_C_G_C_';
      Caption := 'CPF/CNPJ';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_NOMCID';
      Caption := 'Cidade';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_ESTADO';
      Caption := 'Estado';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_ENDERE';
      Caption := 'Endereço';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_BAIRRO';
      Caption := 'Bairro';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CLI_STATUS';
      Caption := 'Status';
    End;
    EndUpdate;
  End;
End;

Procedure TfrmImpEtiquetas.FormShow(Sender: TObject);
Begin
  Inherited;
  chkOpcCarregamento.Visible := False;
  If strConEti = '1' Then
    dbgEtiquetasTableView.FilterRow.ApplyChanges := fracImmediately
  Else
    dbgEtiquetasTableView.FilterRow.ApplyChanges := fracOnCellExit;

  rdgSaldos.Visible := False;
  blnPromoc := False;

  cdsPromoc.Close;
  cdsPromoc.CreateDataSet;
  cdsArmaze.Close;
  cdsArmaze.CreateDataSet;
  cdsArmaze.LogChanges := False;
  cdsArmaze.IndexFieldNames := 'CODITE';
  pHabilitaTela(True);

  { ******************************************* }
  { * VERIFICA CONFIGURACAO PARA PCT DE SCONTO * }
  { ****************************************AA* }
  If (fCfgSis('ETIPCD', varBoolean)) Then
  Begin
    edtPercentDesconto.Visible := True;
    lblPercentDesconto.Visible := True;
    lblSimboloDesconto.Visible := True;
  End;

  cdsImpEti.Close;
  cdsImpEti.CreateDataSet;
  cdsImpEti.Open;
  cdsImpEti.EmptyDataSet;
  cdsImpEti.Filter := '';
  cdsImpEti.Filtered := False;

  cdsImpEtiEst.Close;
  cdsImpEtiEst.CreateDataSet;
  cdsImpEtiEst.Open;
  cdsImpEtiEst.EmptyDataSet;
  cdsImpEtiEst.Filter := '';
  cdsImpEtiEst.Filtered := False;

  cdsImpEtiIte.Close;
  cdsImpEtiIte.CreateDataSet;
  cdsImpEtiIte.Open;
  cdsImpEtiIte.EmptyDataSet;
  cdsImpEtiIte.Filter := '';
  cdsImpEtiIte.Filtered := False;

  stlCampos.Clear;
  stlDesInd.Clear;

  If intTipEti = ETI_CLIENTES Then
  Begin
    rdgStatus.Visible := True;
    edtTotEti.Visible := False;
    lblTotEti.Visible := False;
    blnEndCob := False;
    intIndBusca := 2;
    strTipEti := 'CLI';
    strNomeTabela := 'CADCLI';
    pAbreClientes;
    // pDesmarcarTodos(0);

    If blnViaBol Then
    Begin
      fLimpaMarcadosCli;
      pDesmarcarTodos(1);
    End;
  End

  Else If intTipEti = ETI_FUNCIONARIOS Then
  Begin
    edtTotEti.Visible := True;
    lblTotEti.Visible := True;
    blnEndCob := False;
    intIndBusca := 2;
    strTipEti := 'FUN';
    strNomeTabela := 'CADFUN';
    pAbreFuncionarios;
  End

  Else If intTipEti = ETI_ITENS Then
  Begin
    rdgStatus.Visible := True;
    rdgSaldos.Visible := True;
    btnQtdEti.Visible := True;
    edtTotEti.Visible := False;
    lblTotEti.Visible := False;
    btnEtiquetaEletronica.Visible := fCfgSis('EEREAT', varBoolean);
    btnHlpExpEtiEle.Visible := btnEtiquetaEletronica.Visible;
    btnCfgVisualizacao.Visible := True;
    intIndBusca := 3;
    strTipEti := 'ITE';
    strNomeTabela := 'CADITE';

    blnTodos := True;
    chkOpcCarregamento.Visible := True;

    pAbreItens(chkOpcCarregamento.Checked);
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);


    cdsCodBar.Close;
    cdsCodBar.CreateDataSet;
    cdsCodBar.Open;

    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);

  End

  Else If intTipEti = ETI_DIVERSOS Then
  Begin
    edtTotEti.Visible := False;
    lblTotEti.Visible := False;
    intIndBusca := 2;
    strTipEti := 'DIV';
    strNomeTabela := 'CADDIV';
    pAbreDiversos;
  End

  Else If intTipEti = ETI_FORNECEDORES Then
  Begin
    edtTotEti.Visible := True;
    lblTotEti.Visible := True;
    intIndBusca := 2;
    strTipEti := 'FOR';
    strNomeTabela := 'CADFOR';
    pAbreFornecedores;
  End

  Else If intTipEti = ETI_VENDEDORES Then
  Begin
    edtTotEti.Visible := False;
    lblTotEti.Visible := False;
    intIndBusca := 2;
    strTipEti := 'VEN';
    strNomeTabela := 'CADOPE';
    pAbreVendedores;
  End

  Else If intTipEti = ETI_ESTRUTURAS Then
  Begin
    edtTotEti.Visible := False;
    lblTotEti.Visible := False;
    intIndBusca := 2;
    strTipEti := 'GMT';
    strNomeTabela := 'GERMAT';
    pAbreEstruturas;
  End;

//  lblDesBus.Caption := stlDesInd[intIndBusca];

  If fEmptyStr(strCfgTipEti) And (intTipEti = ETI_ITENS) Then
  Begin
    rdbTermica.Checked := True;
    pnlCabecalho.Visible := True;
  End
  Else
  Begin
    pnlCabecalho.Visible := False;
  End;

  If (Not strCamQtd.IsEmpty) Then
    dbgEtiquetasTableView.GetColumnByFieldName(strCamQtd).RepositoryItem := cxEditQtdEti;

  cxEditQtdEti.Properties.OnValidate := OnCxEditValidate;

  // If (Not edtTotEti.Visible) Then
  // pnlBusca.Height := pnlBusca.Height - edtTotEti.Height;

  blnImpPre := True;
//  blnParKey := fCfgSis('CONETI', varBoolean);

//  if edtBusca.CanFocus then
//    pSetFocus(edtBusca);

  lblPromocao.Visible := (intTipEti = ETI_ITENS);
  lblPromocao.Font.Color := fRetornaCorPromocional;

End;

Procedure TfrmImpEtiquetas.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
  Inherited;
  objGerenciaPropriedadesComponentes.pSalvar;
  FreeAndNil(objGerenciaPropriedadesComponentes);
  blnLibCnf := False;
  FreeAndNil(stlCampos);
  FreeAndNil(stlDesInd);
  FreeAndNil(qryEtique);
  FreeAndNil(stlPromoc);
  FreeAndNil(stlCodBar);
End;

{
Procedure TfrmImpEtiquetas.dbgEtiquetasKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
  Inherited;
  If (Key = VK_Return) Then
  Begin
    pDigQuantidade;
    pSetFocus(Self);
  End;
End;}

Procedure TfrmImpEtiquetas.pIncluiCodBarras(strCodIte, strCodBar: String);
Begin
  With cdsCodBar Do
  Begin
    If Locate('CODITE', strCodIte, []) And Locate('CODBAR', strCodBar, []) Then
      Edit
    Else
      Insert;

    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('CODBAR').AsString := strCodBar;
    Post;
  End;
End;

procedure TfrmImpEtiquetas.pLimpaFiltros;
begin
  If intTipEti = ETI_ITENS Then
  Begin
   	blnItensDivergentes := False;
    pLimparVariaveisEtiquetasEletronicas;
    pDesmarcarTodos(0);
    pAbreItens(False);
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
    Exit;
  End;

  try
    if not qryImpEti.Active then
      Exit;
    qryImpEti.DisableControls;
    qryImpEti.First;
    while not qryImpEti.Eof do
    begin
      if qryImpEti.FieldByName(strCamQtd).AsInteger > 0 then
        pDigQuantidade;
      qryImpEti.Next;
    end;
    FormShow(nil);
  finally
    qryImpEti.EnableControls;
  end;
end;

procedure TfrmImpEtiquetas.pLimparVariaveisEtiquetasEletronicas;
begin
  strCodEmpEtiEleAlt := '';
  SetLength(arrCodEmpEtiEle,0);
end;

Procedure TfrmImpEtiquetas.pDigQuantidade(blnValidaAmz: Boolean = False);
  Procedure pDesmarcaCodBar;
  Begin
    With cdsCodBar Do
    Begin
      First;

      while not Eof Do
      Begin
        If cdsCodBar.FieldByName('CODITE').AsString = qryImpEti.FieldByName('ITE_CODITE').AsString Then
        Begin
          cdsCodBar.Delete;
        End
        Else
          Next;
      End;
    End;
  End;
Var
  intQtdEti, i: Integer;
  strCodAmz: String;
  strObserv: string;
  frmDigQtdEti : TfrmDigQtdEti;
  frmPedeObserv: TfrmPedeObserv;
Begin

  strObserv := '';
  strCodAmz := '';

  If cdsCodBar.Active Then
    pDesmarcaCodBar;

  If Not qryImpEti.IsEmpty Then
  Begin

    If ( qryImpEti.FieldByName(strCamQtd).AsInteger > 0 )
    And (Not blnValidaAmz) Then
    Begin
      intQtdEti := 0;

      If (intTipEti = ETI_CLIENTES) Or (intTipEti = ETI_FORNECEDORES) Or
        (intTipEti = ETI_FUNCIONARIOS) Then
        edtTotEti.Text := IntToStr(strToInt(edtTotEti.Text) -
          qryImpEti.FieldByName(strCamQtd).AsInteger);

      pAlteraQtdEti(intQtdEti, strCodAmz, strObserv);
    End
    Else
    Begin

      Try
        pCriarFormularios(TfrmDigQtdEti, frmDigQtdEti);

        If (intTipEti = ETI_ITENS) Then
          frmDigQtdEti.strCodIte := qryImpEti.FieldByName('ITE_CODITE').AsString;

        If blnValidaAmz
        And ( qryImpEti.FieldByName('ITE_QTDETI').AsInteger > 1 ) Then
        Begin
          frmDigQtdEti.edtQtdEti.Text := fPreencheEspaco(qryImpEti.FieldByName('ITE_QTDETI').AsString,
                                                         4, False, '0');
        End;

        frmDigQtdEti.ShowModal;

        If frmDigQtdEti.blnConfirma Then
        Begin

          intQtdEti := frmDigQtdEti.intQtdEti;
          strCodAmz := frmDigQtdEti.strCodAmz;

          If intQtdEti > 0 Then
          Begin
            If (intTipEti = ETI_CLIENTES) Or (intTipEti = ETI_FORNECEDORES) Or
              (intTipEti = ETI_FUNCIONARIOS) Then
              edtTotEti.Text := IntToStr(strToInt(edtTotEti.Text) + intQtdEti);

            If (intTipEti = ETI_ITENS) Then
            Begin
              If blnPedObs Then
              Begin
                pCriarFormularios(TfrmPedeObserv, frmPedeObserv);

                frmPedeObserv.Caption := 'Observação a ser impressa na etiqueta';
                frmPedeObserv.edtObserv.Text := qryImpEti.FieldByName('ITE_OBSERV').AsString;

                If frmPedeObserv.ShowModal = mrOk Then
                  strObserv := frmPedeObserv.edtObserv.Text;

                FreeAndNil(frmPedeObserv);
              End;

              for i := 0 to frmDigQtdEti.strCodBar.Count - 1 do
              Begin
                pIncluiCodBarras(frmDigQtdEti.strCodIte, frmDigQtdEti.strCodBar[i]);
              End;
            End;
          End;

          If (Not fEmptyStr(strCodAmz)) And (intTipEti = ETI_ITENS) Then
            pAlteraArmazem(strCodAmz, frmDigQtdEti.strCodIte);

          pAlteraQtdEti(intQtdEti, strCodAmz, strObserv);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmImpEtiquetas.pDigQuantidade]');
        End;
      End;

      pFreeAndNil(frmDigQtdEti);

    End;

  End;

End;

Procedure TfrmImpEtiquetas.pAlteraArmazem(strCodAmz: String; strCodIte: String);
Begin
  If (Not fEmptyStr(strCodIte)) And (Not fEmptyStr(strCodAmz)) Then
  Begin
    If cdsArmaze.FindKey([strCodIte]) Then
    Begin
      cdsArmaze.Edit;
      cdsArmazeCODAMZ.AsString := strCodAmz;
      cdsArmaze.Post;
    End
    Else
    Begin
      cdsArmaze.Insert;
      cdsArmazeCODITE.AsString := strCodIte;
      cdsArmazeCODAMZ.AsString := strCodAmz;
      cdsArmaze.Post;
    End;
  End;
End;

Function TfrmImpEtiquetas.fULTALP(blnFilDta: Boolean): String;
Begin
  Result := '';
  If blnFilDta Then
    Result := Result + 'PRE.ALT_DTAALT'
  Else
  Begin
    Result := Result + '(SELECT MAX(PREALT.ALT_DTAALT) ';
    Result := Result + '   FROM PREALT ';
    Result := Result + ' WHERE PREALT.ALT_CODITE = ITEGER.ITE_CODITE) ';
  End;
End;

Function TfrmImpEtiquetas.fOrderByItens(blnFilDta: Boolean): String;
Begin
  Result := IIF(stlCampos[intIndBusca] = 'ULTALP', fULTALP(blnFilDta),
    stlCampos[intIndBusca] + IIF(intIndBusca = 1, ', ITE_DESITE', ''));
End;

Procedure TfrmImpEtiquetas.pAlteraQtdEti(intQtdEti: Integer;
  strCodAmz: String = ''; strObserv: String = '');
  Procedure pDesmarcaItem;
  Var
    qryTmp: TUniQuery;
  Begin
    qryTmp := fCriaQuery;

    With qryTmp Do
    Begin
      SQL.Clear;
      SQL.Add('DELETE FROM ITEETI WHERE ETI_CODITE = :CODITE AND ETI_CODOPE = :CODOPE ');

      If Not fEmptyStr(strCodEti) Then
        ParamByName('CODITE').AsString := strCodEti
      Else
        ParamByName('CODITE').AsString := qryImpEti.FieldByName('ITE_CODITE').AsString;

      ParamByName('CODOPE').AsString := qryImpEti.FieldByName('ITE_CODOPE').AsString;

      ExecSQL;
    End;

    FreeAndNil(qryTmp);
  End;

Begin
  If (intTipEti = ETI_ITENS) Then
    pDesmarcaItem;

  With qryImpEti Do
  Begin
    Edit;

    If intQtdEti = 0 Then
    Begin
      FieldByName(strCamQtd).Value := Null;
    End
    Else
    Begin
      FieldByName(strCamQtd).AsInteger := intQtdEti;
    End;

    If (intTipEti = ETI_ITENS) Then
    Begin
      If Not fEmptyStr(strCodAmz) Then
        FieldByName(strAmzEti).Value := strCodAmz
      Else
        FieldByName(strAmzEti).Value := Null;

      FieldByName('ITE_CODOPE').AsString := strLoginUsuarioLogado;

      If Not fEmptyStr(strCodEti) Then
        FieldByName('ITE_CODITE').AsString := strCodEti
      Else
        FieldByName('ITE_CODITE').AsString := FieldByName('ITE_CODITE').AsString;

      If Not fEmptyStr(strObserv) Then
        FieldByName('ITE_OBSERV').AsString := strObserv;
    End;

    Post;
  End;

  If (intTipEti = ETI_ITENS) And (intQtdEti = 0)  Then
    pDesmarcaItem;
End;

Procedure TfrmImpEtiquetas.pImpEtiquetasMatricial;
Var
  intContador: Integer;
  intQtdTopo: Integer;
  qryCfgRel: TUniQuery;
  fltPreCus, fltPreVen, fltComVar, fltComAta, fltComDis, fltQtdDis, fltDesF07: Double;

  blnParticiona, blnPromo: Boolean;

  strComPro: String;
  strCodPromocao: String;

Begin
  qryCfgRel := fCriaQuery(Self);

  pCarregaConfImpr(qryCfgRel, Self.Name);

  strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
  strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
  strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;

  If intTipEti = ETI_ITENS Then
  Begin
    pCarregaConfImpr(qryCfgRel, Self.Name + '_ITE');
    If Not fEmptyStr(qryCfgRel.FieldByName('REL_NOMFIL').AsString) Then
    Begin
      strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
      strNomPro := qryCfgRel.FieldByName('REL_NOMPRO').AsString;
      strDesPro := qryCfgRel.FieldByName('REL_DESPRO').AsString;
    End;
  End;

  If (qryCfgRel.FieldByName('REL_IDEIMP').AsString <> 'M') Or (Not fVerificaImpressora(strNomImp)) Then
  Begin
    fMensagem('', 'Impressora configurada incorretamente!', ['&OK']);
    Exit;
  End;

  With qryImpEti Do
  Begin

    intQtdTopo := fRetTopoEtiqueta(strTipEti);

    For intContador := 1 To intQtdTopo Do
    Begin
      pEscreveLinha(untFuncMacro.strArqTxt, ' ', False, strNomImp, strNomPro, strDesPro);
    End;

    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLOri(False));

  //  ParamByName('VALBUS').AsString := edtBusca.Text + '%';
  //  ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%';;

    ParamByName('VALBUS').AsString := '%';

    If intTipEti = ETI_ITENS Then
    Begin
      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('ITEATI').AsString := 'S';
        1:
          ParamByName('ITEATI').AsString := 'N';
      End;
    End;

    If intTipEti = ETI_CLIENTES Then
    Begin
      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('STATUS').AsString := '%A';
        1:
          ParamByName('STATUS').AsString := '%I';
        2:
          ParamByName('STATUS').AsString := '%';
      End;
    End;

    Open;

    First;
    If fEmptyStr(fTiraCaracEspeciais(strDtaPro)) Then
      strDtaPro := DateToStr(fNow);

    While Not Eof Do
    Begin
      If (intTipEti = ETI_ITENS) Then
        If FPreco > 0 Then
        Begin
          FValor := IIF(FieldByName('ITE_PREVE' + IntToStr(FPreco)).IsNull,
            '0.0', FieldByName('ITE_PREVE' + IntToStr(FPreco)).AsFloat);
          If blnExibePrePro Then
            If (fRetornaPrecosPromocao(FieldByName('ITE_CODITE').AsString, '',
              strToDate(strDtaPro), 1, 0, 0, 0, fltPreCus, fltPreVen, fltComVar, fltComAta,
              fltComDis, fltQtdDis, fltDesF07, strComPro, strCodPromocao, blnParticiona, blnPromo, '', '')) Then
              FValor := fltPreVen;

        End
        Else
          FValor := 0;

      Application.ProcessMessages;
      pAtualizaCamposUso;
      Application.ProcessMessages;
      pImpRegistro;
      Application.ProcessMessages;

      Next;
    End;
    { ***************************************** }
    { * É NECESSARIO CHAMAR ESSA PROCEDURE    * }
    { * NESSE PONTO PARA QUE SAIA A ÚLTIMA    * }
    { * ETIQUETA                              * }
    { **************************************MV* }
    pImpArrLinhasEti;

    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLOri(True));
    ParamByName('VALBUS').AsString := '%';

    If intTipEti = ETI_ITENS Then
    Begin
      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('ITEATI').AsString := 'S';
        1:
          ParamByName('ITEATI').AsString := 'N';
      End;
    End;

    If intTipEti = ETI_CLIENTES Then
    Begin
      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('STATUS').AsString := '%A';
        1:
          ParamByName('STATUS').AsString := '%I';
        2:
          ParamByName('STATUS').AsString := '%';
      End;
    End;

    Open;
  End;

  pSetFocus(dbgEtiquetas);

  FreeAndNil(qryCfgRel);
End;

Procedure TfrmImpEtiquetas.pImpRegistro;
Var
  intQtdCol: Integer;
  intQtdColOri: Integer;
  intContador: Integer;
  intLinhaAtu: Integer;
  intLinha: Integer;
  intTamLinAnt: Integer;
  intNumCol: Integer;
  intQtdEti: Integer;
  intLinhaEti: Integer;
  strNumCol: String;
  strLinha: String;
  strSQL: String;
  qryCnfEti: TUniQuery;
Begin
  intLinhaAtu := 1;
  intLinha := 0;
  intLinhaEti := 0;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CNFETI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CNF_TIPETI = :TIPETI AND';
  strSQL := strSQL + '  CNF_CODEMP = :CODEMP    ';
  strSQL := strSQL + 'ORDER BY ';
  strSQL := strSQL + '  CNF_IDENTI, CNF_LINIMP, CNF_COL001 ';

  qryCnfEti := fCriaQuery(Self);
  With qryCnfEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('TIPETI').AsString := strTipEti;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    intQtdEti := qryImpEti.FieldByName(strCamQtd).AsInteger;

    If qryCnfEti.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'CONFIGURAR A TABELA CNFETI!', ['&Ok']);
      Exit;
    End;

    While (intQtdEti > 0) Do
    Begin
      First;

      If FieldByName('CNF_QTDCOL').AsInteger < 1 Then
      Begin
        fMensagem('ATENÇÃO!',
          'CONFIGURAR NA TABELA CNFETI A QUANTIDADE DE COLUNAS DA ETIQUETA!',
          ['&Ok']);
        Exit;
      End;

      intQtdColOri := FieldByName('CNF_QTDCOL').AsInteger;
      intQtdCol := intQtdColOri;

      If (intQtdCol > intQtdEti) And (intColAtu <= 1) Then
        intQtdCol := intQtdEti;

      { ***************************************** }
      { * LÊ E INTERPRETA O ID = '00'           * }
      { **************************************MV* }
      If intColAtu <= 1 Then
      Begin
        pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha,
          strNomImp, strNomPro, strDesPro, 0, qryCnfEti);
        { ***************************************** }
        { * ESCREVE COM WRITE, MAS NÃO IMPRIME    * }
        { **************************************MV* }
        pEscreveLinha(strArqTxt, AnsiString(strLinha), True, strNomImp, strNomPro, strDesPro);
      End;
      Next;

      { If (Length(arrLinhasEti) = 0) Then
        Begin
        SetLength(arrLinhasEti, RecordCount-1);
        End; }

      If (Length(arrLinhasEti) = 0) Then
      Begin
        If RecordCount > 0 Then
          SetLength(arrLinhasEti, RecordCount - 1)
        Else
          SetLength(arrLinhasEti, 0);
      End;

      While (Not Eof) Do
      Begin

        pAtualizaCamposUso;

        strLinha := '';

        For intContador := intColAtu To IIF(intQtdEti = 1, intColAtu,
          intQtdCol) Do
        Begin

          strNumCol := fStrZero(IntToStr(intContador), 03);
          intNumCol := FieldByName('CNF_COL' + strNumCol).AsInteger;

          intTamLinAnt := Length(arrLinhasEti[intLinhaEti]);
          pI_LinhasEti(Self, cpuCampos, strLinha, intLinhaAtu, intLinha,
            strNomImp, strNomPro, strDesPro, (intNumCol - intTamLinAnt), qryCnfEti);

          arrLinhasEti[intLinhaEti] := arrLinhasEti[intLinhaEti] + strLinha;
          strLinha := ''; // Se desistir da matriz, tirar essa linha

        End;
        Inc(intLinhaEti);

        { ***************************************** }
        { * NEXT NO ARQUIVO DE CNF                * }
        { **************************************MV* }
        Next;

      End;

      intLinhaEti := 0;
      Inc(intColAtu, intQtdEti);
      Dec(intQtdEti, (intQtdColOri + 1) - (intColAtu - intQtdEti));

      If intColAtu > intQtdColOri Then
      Begin
        pImpArrLinhasEti;
        intColAtu := 1;
      End;

    End;

  End;
  FreeAndNil(qryCnfEti);
End;

Procedure TfrmImpEtiquetas.pAtribuiCamposUso;
Begin
  If Assigned(cpuCampos) THen
    FreeAndNil(cpuCampos);

  cpuCampos := TCamposUso.Create;

  If intTipEti = ETI_CLIENTES Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADCLI');
  End

  Else If intTipEti = ETI_FUNCIONARIOS Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADFUN');
  End

  Else If intTipEti = ETI_ITENS Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADITE');
  End

  Else If intTipEti = ETI_DIVERSOS Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADDIV');
  End

  Else If intTipEti = ETI_FORNECEDORES Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADFOR');
  End

  Else If intTipEti = ETI_VENDEDORES Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'CADOPE');
  End

  Else If intTipEti = ETI_ESTRUTURAS Then
  Begin
    cpuCampos.AdicionaCampos(qryImpEti, 'GERMAT');
  End;
End;

procedure TfrmImpEtiquetas.pAtualizaIMPPRE(strCodIte: string);
Var
 qryTmp: TUniQuery;
 strSQL: String;
Begin
  strSQL := '';
  strSQL := 'UPDATE IMPPRE SET IMP_JAIMPR = "S" WHERE IMP_CODITE = :CODITE AND IMP_CODEMP = :CODEMP ' ;

  qryTmp := fCriaQuery;
  Try
    qryImpEti.First;
    While not qryImpEti.Eof do
    begin
      If qryImpEti.FieldByName('ITE_QTDETI').asInteger <> 0 Then
      begin
        qryTmp.Close;
        qryTmp.SQL.Clear;
        qryTmp.SQL.Add(strSQL);
        qryTmp.ParamByName('CODITE').AsString := qryImpEti.FieldByName('ITE_CODITE').AsString;
        qryTmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryTmp.ExecSQL;
        qryTmp.Close;
      end;
      qryImpEti.Next;
    end;
  Finally
    FreeAndNil(qryTmp);
  End;
End;

Procedure TfrmImpEtiquetas.pAtualizaCamposUso;
Begin
  pFinalizaCamposUso;
  pAtribuiCamposUso;
End;

{
Procedure TfrmImpEtiquetas.pConsulta;
Begin
  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;

    If intTipEti = ETI_CLIENTES Then
      SQL.Add(fRetornaSQLCli + ' ORDER BY ' + stlCampos[intIndBusca])

    Else If intTipEti = ETI_FUNCIONARIOS Then
      SQL.Add(fRetornaSQLFuncionario + ' ORDER BY ' + stlCampos[intIndBusca])

    Else If intTipEti = ETI_ITENS Then
      SQL.Add(fRetornaSQLIte(False) + ' ORDER BY ' + fOrderByItens(False))
    Else If intTipEti = ETI_DIVERSOS Then
      SQL.Add(fRetornaSQLDiv + ' ORDER BY ' + stlCampos[intIndBusca])

    Else If intTipEti = ETI_FORNECEDORES Then
      SQL.Add(fRetornaSQLFor + ' ORDER BY ' + stlCampos[intIndBusca])

    Else If intTipEti = ETI_ESTRUTURAS Then
      SQL.Add(fRetornaSQLEstr + ' ORDER BY ' + stlCampos[intIndBusca])

    Else If intTipEti = ETI_VENDEDORES Then
      SQL.Add(fRetornaSQLVen + ' ORDER BY ' + stlCampos[intIndBusca]);
    If (Pos('ULTALP', stlCampos[intIndBusca]) > 0) or (Pos('ITE_DTAALT', stlCampos[intIndBusca]) > 0) Then
    begin

      ParamByName('VALBUS').AsString := '%';

    (*  if fEmptyStr(edtBusca.Text) then
        ParamByName('VALBUS').AsString := '%'
      else
        ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%'; *)

    end


    Else ParamByName('VALBUS').AsString := '%';

    (*
    Else If Pos('_COD', stlCampos[intIndBusca]) <= 0 Then
      ParamByName('VALBUS').AsString := edtBusca.Text + '%'
    Else
      ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%'; *)

    If intTipEti = ETI_ITENS Then
    Begin
      Case rdgStatus.ItemIndex Of
        0: ParamByName('ITEATI').AsString := 'S';
        1: ParamByName('ITEATI').AsString := 'N';
      End;
    End;

    If (intTipEti = ETI_CLIENTES) Then
    Begin
      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('STATUS').AsString := '%A';
        1:
          ParamByName('STATUS').AsString := '%I';
        2:
          ParamByName('STATUS').AsString := '%';
      End;
      pQtdeEtiquetaCliente(strSQLAux, ParamByName('VALBUS').AsString);
    End;

    If (intTipEti = ETI_FUNCIONARIOS) Then
      pQtdeEtiquetaFuncionario(strSQLAux, ParamByName('VALBUS').AsString);

    If (intTipEti = ETI_FORNECEDORES) Then
      pQtdeEtiquetaFornecedor(strSQLAux, ParamByName('VALBUS').AsString);

    Open;

    If intTipEti = ETI_ITENS Then
    Begin
      (FieldByName('ITE_PREVE' + fPrimeiraTabPreco) As TFloatField)
        .DisplayFormat := '#,##0.00';
      (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
    End;
  End;

End;
}

Procedure TfrmImpEtiquetas.pCriarOcorrenciasCRM;
var
  frmCadMovOcorrencias : TfrmCadMovOcorrencias;
Begin
  Try
    pCriarFormularios(TfrmCadMovOcorrencias, frmCadMovOcorrencias);
    frmCadMovOcorrencias.strCodCli :=
      Copy(strCliVen, 1, Pos('_', strCliVen) - 1);
    frmCadMovOcorrencias.strCliVen := Copy(strCliVen, Pos('_', strCliVen) + 1,
      Length(strCliVen));
    frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
    frmCadMovOcorrencias.strOperac := 'Inserir';
    frmCadMovOcorrencias.ShowModal;
  Finally
    FreeAndNil(frmCadMovOcorrencias);
  End;
End;

Procedure TfrmImpEtiquetas.pCriarOcorrenciasCRMClientesSelecionados;
Begin
  If fMensagem('Questão', 'Deseja criar uma ocorrência no CRM,' + #13#10 +
    'para todos os clientes selecionados ?', ['&Sim', '&Não']) = 1 Then
    pCriarOcorrenciasCRM;
End;

procedure TfrmImpEtiquetas.pFiltrarItensEtiquetasEletronicas(DataSet: TDataSet);
begin
  If fEmptyStr(strCodEmpEtiEleAlt) Then
    Exit;

  DataSet.Filter := 'ITEGER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  DataSet.Filtered := True;
end;

Procedure TfrmImpEtiquetas.pFinalizaCamposUso;
Begin
  If cpuCampos <> Nil Then
    FreeAndNil(cpuCampos);
End;

procedure TfrmImpEtiquetas.pGravarConfiguracoesEtiqProdutos;
begin
  TCfgColEtiqItens.pCarregarDadosSalvos(dbgEtiquetasTableView);
end;

Procedure TfrmImpEtiquetas.FormKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Var
  strSenha: String;
Begin
  Inherited;
  { ***************************************** }
  { * PEDE SENHA PARA CONFIGURAÇÃO DE CNF   * }
  { **************************************MV* }
  If (Shift = [ssShift]) And (Key = VK_F8) And (blnHabili) Then
  Begin
    If blnLibCnf Then
    Begin
      blnLibCnf := False;
      pnlBotoesImp.Color := clBtnFace;
    End
    Else
    Begin
      If ffrmSenha(strSenha) Then
      Begin
        If strSenha = SEN_CNF Then
        Begin
          blnLibCnf := True;
          pnlBotoesImp.Color := clNavy;
        End;
      End;
    End;
  End

  { ***************************************** }
  { * ABRE A TELA DE CONFIGURAÇÃO DE CNF    * }
  { **************************************MV* }
  Else If (Shift = [ssShift]) And (Key = VK_F9) And (blnHabili) Then
  Begin
    If blnLibCnf Then
    Begin
      pCriarForm(TfrmCnfEtiqueta, frmCnfEtiqueta);
    End;
  End

  Else If (Key = VK_F5) And (btnIniBusca.Visible) And (blnHabili) Then
  Begin
    btnIniBusca.Click;
  End
  Else If (Key = VK_F6) And (blnHabili) Then
  Begin
    btnConfigurar.Click;
  End
  Else If (Key = VK_F7) And (blnHabili) Then
  Begin
    pLimpaFiltros;
  End
  Else If (Key = VK_F8) And (btnQtdEti.Visible) And (blnHabili) Then
  Begin
    btnQtdEti.Click;
  End
  Else If (Key = VK_F9) And (blnHabili) Then
  Begin
    btnMarDes.Click;
  End
  Else If (Key = VK_F10) And (blnHabili) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F11) And (blnHabili) Then
  Begin
    btnEtiquetaEletronica.Click;
  End
  Else If (Key = VK_F12) And (blnHabili) Then
  Begin
    btnCfgVisualizacao.Click;
  End
  Else If (Key = VK_Escape) And (blnHabili) Then
  Begin
    btnSairImp.Click;
  End;

End;

procedure TfrmImpEtiquetas.pValidaAmzVinculado;
begin
  Try
    qryImpEti.DisableControls;
    qryImpEti.Filter := 'ITE_QTDETI > 0';
    qryImpEti.Filtered := True;

    If qryImpEti.RecordCount <= 0 Then
      Exit;

    qryImpEti.First;
    While Not qryImpEti.Eof Do
    Begin
      If Not cdsArmaze.Locate('CODITE',
                              qryImpEti.FieldByName('ITE_CODITE').AsString,
                              []) Then
      Begin
        pDigQuantidade(True);
      End;
        qryImpEti.Next;
    End;
  Finally
    qryImpEti.Filter := EmptyStr;
    qryImpEti.Filtered := Not qryImpEti.Filtered;
    qryImpEti.EnableControls;
  End;
end;

Procedure TfrmImpEtiquetas.btnConfirmaClick(Sender: TObject);
Var
strCodIte: string;
Begin
  Inherited;
  pSetFocus(btnConfirma);
  intColAtu := 1;

  If (fCfgSis('CTLEST') = '2')
  and (fCfgSis('IMCAEP') = 'S') Then
  begin
    pValidaAmzVinculado;
  end;

  If (fRetQtdSel > 0) And (fMensagem('', 'Confirma impressão das Etiquetas?',
    ['&Sim', '&Não']) = 1) Then
  Begin
    If (intTipEti = ETI_CLIENTES) Then
    Begin
      If (fMensagem('', 'Deseja imprimir o Endereço?', ['&Faturamento', '&Cobrança']) = 1) Then
        blnEndCob := False
      Else
        blnEndCob := True;

      If not fSelecaoTipoEtiquetaCliente Then
        Exit;
    End;

    { * ITENS * }
    If (intTipEti = ETI_ITENS) And (Pos(strCfgTipEti, 'LZAS') > 0) Then
    Begin
      pImpEtiquetasLaserItens;
    End

    { * CLIENTES * }
    Else If (intTipEti = ETI_CLIENTES) And
      (tpeTipEtqCliente in [tpeClienteLaser, tpeClienteArgox]) Then
    Begin
      fImprimeEtiquetaClienteLaser;
    End

    Else If (intTipEti = ETI_FUNCIONARIOS) And
      (Pos(fCfgSis('ETIFUN'), 'LZA') > 0) Then
    Begin
      fImprimeEtiquetaFuncionarioLaser;
    End

    { * FORNECEDORES * }
    Else If (intTipEti = ETI_FORNECEDORES) And
      (Pos(fCfgSis('ETIFOR'), 'LA') > 0) Then
    Begin
      fImprimeLaserArgox(IIF(fCfgSis('ETIFOR') = 'L', tpeFornecedorLaser,
        tpeFornecedorArgox), 'NOME');
    End

    { * ESTRUTURAS * }
    Else If (intTipEti = ETI_ESTRUTURAS) And (fCfgSis('ETIEST') = 'A') Then
    Begin
      fImprimeLaserArgox(tpeEstruturaArgox, 'ESTRUT;ITEM');
    End

    { * DIVERSOS * }

    Else If (intTipEti = ETI_DIVERSOS) And
      (Pos(fCfgSis('ETIDIV'), 'LA') > 0) Then
    Begin
      fImprimeLaserArgox(IIF(fCfgSis('ETIDIV') = 'L', tpeDiversosLaser,
        tpeDiversosArgox), 'NOME');
    End

    { * DIVERSOS * }
    Else If (intTipEti = ETI_VENDEDORES) And (fCfgSis('ETIOPE') = 'L') Then
    Begin
      fImprimeLaserArgox(tpeOperadorLaser, 'NOME');
    End

    { *********************** }
    { * IMPRESSAO MATRICIAL * }
    { ********************AN* }
    Else
    Begin

      If (intTipEti = ETI_ITENS) Then
      Begin
        pEscolheTabelaPreco(False);
        FInfAdi := fInformacaoAdicionalEtiquetaItens;
      End
      Else
      Begin
        FPreco := 1;
        FDecimais := fCfgSis('DECUNI', varInteger);
      End;

      pImpEtiquetasMatricial;
    End;


    If  (intTipEti = ETI_ITENS) And (Not chkOpcCarregamento.Checked) Then
    Begin
      If fMensagem('', 'Deseja manter os produtos selecionados ?', ['&Sim', '&Não']) = 2 Then
      Begin
        tmrDesmarcaTodos.Enabled := True;
        If blnItensDivergentes Then
          pAtualizaIMPPRE(strCodIte);
          blnItensDivergentes := False;
      End
    End
    Else
      tmrDesmarcaTodos.Enabled := True;

    stlCodBar.Clear;
    If (intTipEti = ETI_ITENS) Then
     TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
    strCodEti := '';
  End;
End;

procedure TfrmImpEtiquetas.btnEtiquetaEletronicaClick(Sender: TObject);
begin
  inherited;

  If qryImpEti.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmExportacaoEtiquetasEletronicasView, frmExportacaoEtiquetasEletronicasView);
  Try
    Try
      frmExportacaoEtiquetasEletronicasView.DataSet := qryImpEti;
      frmExportacaoEtiquetasEletronicasView.arrCodEmpEtiEle := arrCodEmpEtiEle;
      frmExportacaoEtiquetasEletronicasView.strFiltro := dbgEtiquetasTableView.DataController.Filter.FilterText;
      frmExportacaoEtiquetasEletronicasView.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnEtiquetaEletronicaClick]');
      End;
    End;
  Finally
    FreeAndNil(frmExportacaoEtiquetasEletronicasView);
  End;
end;

procedure TfrmImpEtiquetas.btnHlpExpEtiEleClick(Sender: TObject);
begin
  inherited;
  frxEtiEletronica.DotMatrixReport           := False;
  frxEtiEletronica.PrintOptions.PrintMode    := pmScale;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)', frxEtiEletronica);
end;

Procedure TfrmImpEtiquetas.FormCreate(Sender: TObject);
Begin
  Inherited;
  pSetaCodIte(cdsImpEtiIteCODITE);
  pSetaCodIte(cdsPromocITE_CODITE);
  pSetaCodIte(cdsArmazeCODITE);

  cpuCampos := Nil;

  blnPedObs := (fCfgSis('PEDOBS', varBoolean));

  strConEti := fCfgSis('CONETI');

  strCfgTipEti := fCfgSis('TIPETI');
  blnUsaArm := (fCfgSis('CTLEST') = '2') Or fUsaRotinaWMS;

  updImpEti := TUniUpdateSQL.Create(Self);

  qryEtique := fCriaQuery;
  qryEtique.Options.SetFieldsReadOnly := False;

  qryImpEti := fCriaQuery(Self);
  qryImpEti.Options.SetFieldsReadOnly := False;
  qryImpEti.UpdateObject := updImpEti;
  dtsImpEti := fCriaDataSource(qryImpEti);
  dbgEtiquetasTableView.DataController.DataSource := dtsImpEti;

  blnViaBol := False;
  strCliBol := '';
  strCodEti := '';
  stlCodBar := TStringList.Create;

  FPais := fSetaPais;

  { ***************************************** }
  { * CRIA AS VARIAVEIS DA BUSCA            * }
  { **************************************MV* }
  stlCampos := TStringList.Create;
  stlDesInd := TStringList.Create;
  stlPromoc := TStringList.Create;
  intIndBusca := 0;
  objGerenciaPropriedadesComponentes := TGerenciaPropriedadesComponentes.Create(Self, Self.Name, strLoginUsuarioLogado);
  objGerenciaPropriedadesComponentes.pAddComponente(chkOpcCarregamento);
  objGerenciaPropriedadesComponentes.pCarregar(False);

End;

Procedure TfrmImpEtiquetas.pImpArrLinhasEti;
Var
  intContador1: Integer;
  intLength1: Integer;
  blnUltimoReg: Boolean;
  strLinhaAtu: String;
  blnImprime: Boolean;
Begin
  strLinhaAtu := '';
  blnUltimoReg := False;
  intLength1 := Length(arrLinhasEti);
  blnImprime := False;

  For intContador1 := 0 To intLength1 - 1 Do
  Begin
    If arrLinhasEti[intContador1] <> '' Then
    Begin
      blnImprime := True;
      Break;
    End;
  End;

  If Not blnImprime Then
  Begin
    Exit;
  End;

  For intContador1 := 0 To intLength1 - 1 Do
  Begin
    If (intContador1 = intLength1 - 1) Then
    Begin
      blnUltimoReg := True;
    End;

    pEscreveLinha(strArqTxt, AnsiString(arrLinhasEti[intContador1]),
      blnUltimoReg, strNomImp, strNomPro, strDesPro);
    strLinhaAtu := '';
  End;

  SetLength(arrLinhasEti, 0);
End;

Function TfrmImpEtiquetas.fRetornaSQLOri(blnOriginal: Boolean): String;
Begin
  If intTipEti = ETI_CLIENTES Then
  Begin
    Result := fRetornaSQLCli;
    If Not blnOriginal Then
      Result := Result + '  AND CLI_QTDETI > 0 ';

    Result := Result + ' ORDER BY ';

    If SameText(stlCampos[intIndBusca], 'CID_NOMCID') Then
    Begin
      If blnEndCob Then
        Result := Result + 'D2.' + stlCampos[intIndBusca]
      Else
        Result := Result + 'D1.' + stlCampos[intIndBusca]
    End

    Else
      Result := Result + stlCampos[intIndBusca];

  End

  Else If intTipEti = ETI_FUNCIONARIOS Then
  Begin
    Result := fRetornaSQLFuncionario;
    If Not blnOriginal Then
      Result := Result + '  AND FUN_QTDETI > 0 ';

    Result := Result + ' ORDER BY ';

    Result := Result + stlCampos[intIndBusca];
  End

  Else If intTipEti = ETI_ITENS Then
  Begin
    Result := fRetornaSQLIte(False, False, False);

    If Not blnOriginal Then
    Begin

      If fTemWhere(fRetornaSQLIte(False, False, False)) Then
        Result := Result +
          '  AND ITEETI.ETI_QTDETI > 0 AND ITEGER.ITE_CODEMP = ' +
          QuotedStr(VS_strCodEmp) + ' '
      Else
        Result := Result +
          '  WHERE ITEETI.ETI_QTDETI > 0 AND ITEGER.ITE_CODEMP = ' +
          QuotedStr(VS_strCodEmp) + ' ';

    End;
  End

  Else If intTipEti = ETI_ESTRUTURAS Then
  Begin
    Result := fRetornaSQLEstr;

    If Not blnOriginal Then
    Begin

      If fTemWhere(fRetornaSQLEstr) Then
        Result := Result + '  AND GMT_QTDETI > 0 '
      Else
        Result := Result + '  WHERE GMT_QTDETI > 0 ';

    End;
  End

  Else If intTipEti = ETI_DIVERSOS Then
  Begin
    Result := fRetornaSQLDiv;
    If Not blnOriginal Then
      Result := Result + '  AND DIV_QTDETI > 0 ';
  End

  Else If intTipEti = ETI_FORNECEDORES Then
  Begin
    Result := fRetornaSQLFor;
    If Not blnOriginal Then
      Result := Result + '  AND FOR_QTDETI > 0 ';
  End

  Else If intTipEti = ETI_VENDEDORES Then
  Begin
    Result := fRetornaSQLVen;
    If Not blnOriginal Then
      Result := Result + '  AND OPE_QTDETI > 0 ';
  End;
End;

procedure TfrmImpEtiquetas.btnCfgVisualizacaoClick(Sender: TObject);
  var
    frmConfigEtiqProduto : TfrmConfigEtiqProduto;
begin
  inherited;

  pCriarFormularios(TfrmConfigEtiqProduto, frmConfigEtiqProduto);
  Try
    frmConfigEtiqProduto.frmImpEtiquetas := Self;
    frmConfigEtiqProduto.ShowModal;
    If (frmConfigEtiqProduto.blnConfirma) Then
    begin
      TFrmGravando.fExecutarModal( pGravarConfiguracoesEtiqProdutos, 'Aguarde... Gravando Configurações!', '');
    end;
  Finally
    pFreeAndNil(frmConfigEtiqProduto);
  End;

end;

procedure TfrmImpEtiquetas.btnCodBarClick(Sender: TObject);
var
  frmSelItensCodBar: TfrmSelItensCodBar;
begin
  inherited;

  strCodEti := '';
  Try
    pCriarFormularios(TfrmSelItensCodBar, frmSelItensCodBar);
    If frmSelItensCodBar.ShowModal = mrOk Then
    Begin
      stlCodBar.Add(frmSelItensCodBar.strCodBar);
      strCodEti := frmSelItensCodBar.strCodIte;
      pAbreItens;
      pAlteraQtdEti(frmSelItensCodBar.intEtiQtd, '', '');
      If (intTipEti = ETI_ITENS) Then
        TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpEtiquetas.btnCodBarClick]');
    End;
  End;

  pFreeAndNil(frmSelItensCodBar);
  pSetFocus(dbgEtiquetas);
end;

Procedure TfrmImpEtiquetas.btnConfigurarClick(Sender: TObject);
Begin
  Inherited;
  Try
    pCriarFormularios(TfrmCadConfRelatorios, frmCadConfRelatorios);
    frmCadConfRelatorios.strNomeForm := Self.Name;
    frmCadConfRelatorios.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmImpEtiquetas.btnConfigurarClick]');
    End;
  End;

  pFreeAndNil(frmCadConfRelatorios);
  pSetFocus(dbgEtiquetas);

End;

Function TfrmImpEtiquetas.fRetornaSQLUpdateIte: String;
Var
  strUpdIte: String;
Begin
  strUpdIte := strUpdIte +
    ' REPLACE INTO ITEETI(ETI_CODOPE, ETI_CODITE, ETI_QTDETI, ETI_AMZETI, ETI_OBSERV) ';
  strUpdIte := strUpdIte +
    '            VALUES(:ITE_CODOPE,:ITE_CODITE,:ITE_QTDETI,:ITE_AMZETI, :ETI_OBSERV) ';
  Result := strUpdIte;
End;

Function TfrmImpEtiquetas.fRetornaSQLFiltroIte(blnFilDta, blnPromocPeriod, blnFilHra: Boolean; tpAltPreEti : TTipoAltPreEti; strPreTab: string): String;
Var
  strUpdIte: String;
  PosIni, i: integer;
Begin
  strUpdIte := '';
  strUpdIte := strUpdIte + ' REPLACE INTO ITEETI (ETI_CODOPE , ETI_CODITE , ETI_QTDETI , ETI_AMZETI , ETI_OBSERV ) ';
    strUpdIte := strUpdIte + '( SELECT DISTINCT ' + QuotedStr(strLoginUsuarioLogado) + ' AS ETI_CODOPE, ';
  strUpdIte := strUpdIte + '        CADITE.ITE_CODITE AS ETI_CODITE, ';

  If blnImpEst Then
    strUpdIte := strUpdIte + '      IF(ITE_SALDOS < 0, 0, ITE_SALDOS) AS ETI_QTDETI, '
  Else
    strUpdIte := strUpdIte + '      :ITE_QTDETI AS ETI_QTDETI,     ';

  strUpdIte := strUpdIte + '        :ITE_AMZETI AS ETI_AMZETI,     ';
  strUpdIte := strUpdIte + '        " " AS ETI_OBSERV              ';
  strUpdIte := strUpdIte + '   FROM ITEGER                         ';
  strUpdIte := strUpdIte + ' JOIN CADITE                             ';
  strUpdIte := strUpdIte + '   ON (CADITE.ITE_CODITE = ITEGER.ITE_CODITE) ';

  If (blnSalAmz) or (intExibeEstoque = 1)  then
  Begin
    strUpdIte := strUpdIte + ' LEFT JOIN CADLOT ON LOT_CODITE = CADITE.ITE_CODITE ';
    strUpdIte := strUpdIte + '                 AND LOT_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  If blnItensDivergentes Then
  Begin
    strUpdIte := strUpdIte + '  JOIN IMPPRE ON IMPPRE.IMP_CODITE = CADITE.ITE_CODITE ';
    strUpdIte := strUpdIte + '             AND IMPPRE.IMP_CODEMP = ITEGER.ITE_CODEMP ';
    strUpdIte := strUpdIte + '             AND IMPPRE.IMP_JAIMPR = "N" ';
  End;

  strUpdIte := strUpdIte + 'WHERE                      ';
  strUpdIte := strUpdIte + '  TRUE AND ';

  If blnFilDta Then
  Begin
    // SEPARA APENAS OS ITENS QUE TEM ALGUMA ALTERAÇÃO DE PRECO OU CATALOG DE PRECO DURANTE O PERIODO INFORMADO
    strUpdIte := strUpdIte + ' (((SELECT COUNT(1) FROM PREALT        ';
    strUpdIte := strUpdIte + '      WHERE PREALT.ALT_CODITE = ITEGER.ITE_CODITE      ';
    strUpdIte := strUpdIte + '        AND ( ';

    If tpAltPreEti = tpPrecoCusto Then
      strUpdIte := strUpdIte + ' ALT_CUSANT <> ALT_CUSATU '
    Else If (tpAltPreEti = tpPrecoVenda) Or (tpAltPreEti = tpTodos) Then
    Begin
      PosIni := Pos('S', strPreTab);
      For i := PosIni To 7 do
      Begin
        If (strPreTab[i] = 'S') Then
        Begin
          If i <> PosIni Then
            strUpdIte := strUpdIte +  ' OR ';
          strUpdIte := strUpdIte + '          (PREALT.ALT_VE' + IntToStr(i) + 'ANT <> PREALT.ALT_VE' + IntToStr(i) + 'ATU)';
        End;
      End;
      If (tpAltPreEti = tpTodos) Then
        strUpdIte := strUpdIte + ' OR (ALT_CUSANT <> ALT_CUSATU) '
    End;
    strUpdIte := strUpdIte + '       )  AND ' + fRetornaFiltroAlteracaoPreco(True,blnFilHra) + ') > 0) OR ' ;
    strUpdIte := strUpdIte + '          ((SELECT COUNT(1) FROM CATITE        ';
    strUpdIte := strUpdIte + '    WHERE CATITE.CAT_CODFOR = CADITE.ITE_CODFOR         ';
    strUpdIte := strUpdIte + '    AND CATITE.CAT_CODFAB = CADITE.ITE_CODFAB         ';
    strUpdIte := strUpdIte + '    AND (DATE_FORMAT(CATITE.CAT_DTAALT, "%d/%m/%Y") BETWEEN :DTAINI AND :DTAFIN) ';
    If blnFilHra Then
      strUpdIte := strUpdIte + '  AND (ADDTIME(CATITE.CAT_DTAALT,CATITE.CAT_HORALT) BETWEEN CONCAT(:DTAINI," ",:HRAINI) AND CONCAT(:DTAFIN," ",:HRAFIN,":59")) ';
    strUpdIte := strUpdIte +   ') > 0) ';

    If blnPromocPeriod Then
    Begin
      strUpdIte := strUpdIte + ' OR ';
      strUpdIte := strUpdIte + '  (SELECT COUNT(1) FROM ITEPRO ';
      strUpdIte := strUpdIte + '    INNER JOIN CADPRO ON CADPRO.AUTOINCREM = IPR_SEQGER ';
      strUpdIte := strUpdIte + '    WHERE IPR_CODITE = ITEGER.ITE_CODITE ';
      strUpdIte := strUpdIte + '      AND ((CADPRO.PRO_DTAFIN BETWEEN :DTAINI AND :DTAINI) OR ';
      strUpdIte := strUpdIte + '           (CADPRO.PRO_DTAINI BETWEEN :DTAINI AND :DTAINI ))) > 0 ';
    end;

    strUpdIte := strUpdIte + ' ) AND ';

    strUpdIte := strUpdIte

  End;

  strUpdIte := strUpdIte + '  ITEGER.ITE_CODEMP = ' + QuotedStr( VS_strCodEmp);

  If (stlPromoc.Count > 0) And (Not blnPromocPeriod) Then
    strUpdIte := strUpdIte + ' AND CADITE.ITE_CODITE IN (' + fCommaText(stlPromoc, True) + ') ';

  Case intEstMin Of
    1: strUpdIte := strUpdIte + ' AND ITEGER.ITE_ESTMIN = 0 ';
    2: strUpdIte := strUpdIte + ' AND ITEGER.ITE_ESTMIN > 0 ';
  End;

  Case intEstMax Of
    1: strUpdIte := strUpdIte + ' AND ITEGER.ITE_ESTMAX = 0 ';
    2: strUpdIte := strUpdIte + ' AND ITEGER.ITE_ESTMAX > 0 ';
  End;

  If (intEstFis > 0) Then
  Begin
    strUpdIte := strUpdIte + ' AND ITEGER.ITE_SALDOS + IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, IFNULL(ITEGER.ITE_SAL_ML, 0) / CADITE.ITE_CNV_ML, 0) + ' +
    IIF(Not fCfgSis('BEFTRG', VarBoolean), fGetSQLSomaCamposEntregaFutura('ITEGER'), '0');

    Case intEstFis Of
      1: strUpdIte := strUpdIte + ' = 0';
      2: strUpdIte := strUpdIte + ' > 0';
      3: strUpdIte := strUpdIte + ' < 0';
    End;
  End;


  Result := strUpdIte;
End;

Procedure TfrmImpEtiquetas.pAbreItens(blnVazio: Boolean = False);
Var
  dtsTmp: TDataSource;
  strCampoSaldos : String;
Begin

  Self.Caption := 'Impressão de Etiquetas - Produtos';
  strCamQtd := 'ITE_QTDETI';
  strAmzEti := 'ITE_AMZETI';

  If (not fEmptyStr(strCodAmz)) and (intExibeEstoque = 1) then
    strCampoSaldos := 'CADLOT.LOT_SALDOS'
  Else
    strCampoSaldos := 'ITEGER.ITE_SALDOS';

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }
  stlCampos.Add('ITEETI.ETI_QTDETI');
  stlCampos.Add('CADITE.ITE_CODITE');
  stlCampos.Add('CADITE.ITE_CODGRU');
  stlCampos.Add('CADITE.ITE_DESITE');
  stlCampos.Add('CADITE.ITE_REFERE');
  stlCampos.Add('ITE_CODBAR');
  stlCampos.Add('ITE_CODFAB');
  stlCampos.Add('CADITE.ITE_DTAALT');
  stlCampos.Add('ULTALP');

  stlCampos.Add('CADUNI.UNI_SIGUNI');
  stlCampos.Add('CADITE.ITE_CODMAR');
  stlCampos.Add('ITEGER.ITE_PREVE' + fPrimeiraTabPreco);
  stlCampos.Add('ITEETI.ETI_AMZETI');
  stlCampos.Add('LOCFIS');
  stlCampos.Add('ITEGER.ITE_LOCSUP');
  stlCampos.Add('CADITE.ITE_ITEATI');
  stlCampos.Add(strCampoSaldos);
  stlCampos.Add('ITE_OBSERV');

  stlCampos.Add('EPROMO');
  stlCampos.Add('ITEGER.ITE_ESTMIN');
  stlCampos.Add('ITEGER.ITE_ESTMAX');
  stlCampos.Add('ITEGER.ITE_DTAETI');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Referência');
  stlDesInd.Add('Cód. Barras');
  stlDesInd.Add('Cód. Fábrica');
  stlDesInd.Add('Últ. Alt. Cadastro');
  stlDesInd.Add('Últ. Alt. Preço');

  stlDesInd.Add('Unidade');
  stlDesInd.Add('Marca');
  stlDesInd.Add('Preço Venda');
  stlDesInd.Add('Código Armazém');
  stlDesInd.Add('Loc.Física Estoque');
  stlDesInd.Add('Loc.Física Sup.Estoque');
  stlDesInd.Add('Status');
  stlDesInd.Add('Saldos');
  stlDesInd.Add('Observação');

  stlDesInd.Add('É Promoção');

  stlDesInd.Add('Estoque Máximo');
  stlDesInd.Add('Estoque Mínimo');

  btnCodBar.Visible := chkOpcCarregamento.Checked;

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    If blnVazio Then
      dbgEtiquetasTableView.OptionsView.NoDataToDisplayInfoText := '<Selecione o filtro de etiquetas para listagem dos produtos (botão F5)>';
    SQL.Add(fRetornaSQLIte(False, False, False, blnVazio) + ' ORDER BY ' +

    fOrderByItens(False));

    ParamByName('VALBUS').AsString := '%';

   (*
    If (stlCampos[intIndBusca] = 'ULTALP') Then
      ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%'
    Else If Pos('_COD', stlCampos[intIndBusca]) <= 0 Then
      ParamByName('VALBUS').AsString := edtBusca.Text + '%'
    Else
      ParamByName('VALBUS').AsString := '%' + edtBusca.Text + '%'; *)

    Case rdgStatus.ItemIndex Of
      0:
        ParamByName('ITEATI').AsString := 'S';
      1:
        ParamByName('ITEATI').AsString := 'N';
    End;

    Open;
    qryImpEti.Options.StrictUpdate := False;
    (FieldByName('ITE_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
    (FieldByName('ITE_PREVE' + fPrimeiraTabPreco) As TFloatField).DisplayFormat := '#,##0.00';
    (FieldByName('LOT_SALDOS') As TFloatField).DisplayFormat := '#,##0.000';
     qryImpEti.BeforePost := qryItemOnBeforePost;
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSQLUpdateIte);
  End;

  dbgEtiquetasTableView.OptionsData.Editing := True;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;
    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_QTDETI';
      Caption := 'Qtd. Eti.';
      Width := 50;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_CODITE';
      Caption := 'Código';
      Width := 60;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_CODGRU';
      Caption := 'Grupo';
      Width := 50;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_DESITE';
      Caption := 'Descrição';
      Width := 320;
      Options.Editing := False;
    End;

    If fCfgSis('IDSORC') = 'S' Then
    begin
      With CreateColumn Do
      Begin
        DataBinding.FieldName := 'ITE_DESSIM';
        Caption := 'Descrição Simplificada';
        Width := 200;
        Options.Editing := False;
      End;
    end;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_REFERE';
      Caption := 'Referência';
      Width := 80;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_CODBAR';
      Caption := 'Cód. Barras';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_CODFAB';
      Caption := 'Cód. Fábrica';
      Width := 75;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_DTAALT';
      Caption := 'Últ. Alt. Cadastro';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ULTALP';
      Caption := 'Últ. Alt. Preço';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'UNI_SIGUNI';
      Caption := 'UN';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_MLTCOM';
      Caption := 'Mlt. Compra';
      Width := 50;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_MLTVEN';
      Caption := 'Mlt. Venda';
      Width := 50;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_CODMAR';
      Caption := 'Marca';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'MAR_DESMAR';
      Caption := 'Descrição Marca';
      Width := 150;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_PREVE' + fPrimeiraTabPreco;
      Caption := 'Preço Venda';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_AMZETI';
      Caption := 'Código Armazém';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'LOCFIS';
      Caption := 'Loc.Física Estoque';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_LOCSUP';
      Caption := 'Loc.Física Sup.Estoque';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_ITEATI';
      Caption := 'Status';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := IIF(Pos('LOT', strCampoSaldos) > 0, 'LOT_SALDOS', 'ITE_SALDOS');
      Caption := 'Saldos';
      Width := 70;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_OBSERV';
      Caption := 'Observação';
      Width := 100;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'EPROMO';
      Caption := 'É Promoção';
      Width := 100;
      Visible := false;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_ESTMIN';
      Caption := 'Estoque Mínimo';
      Width := 85;
      Visible := false;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_ESTMAX';
      Caption := 'Estoque Máximo';
      Width := 85;
      Visible := false;
      Options.Editing := False;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_DTAETI';
      Caption := 'Ult. Impressâo Etiqueta';
      Width := 85;
      Visible := false;
      Options.Editing := False;
    End;

    EndUpdate;
  End;

  dtsTmp := dbgEtiquetasTableView.DataController.DataSource;

  dbgEtiquetasTableView.DataController.DataSource := Nil;

  qryImpEti.DisableControls;
  Try
    qryImpEti.First;
    While Not qryImpEti.Eof Do
    Begin
      If Not fEmptyStr(qryImpEti.FieldByName('ITE_AMZETI').AsString) Then
      Begin
        pAlteraArmazem(qryImpEti.FieldByName('ITE_AMZETI').AsString,
          qryImpEti.FieldByName('ITE_CODITE').AsString);
      End;
      qryImpEti.Next;
    End;
  Finally
    qryImpEti.EnableControls;
  End;

  dbgEtiquetasTableView.DataController.DataSource := dtsTmp;
  If (intTipEti = ETI_ITENS) Then
     TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);

  dbgEtiquetasTableView.GetColumnByFieldName('ITE_QTDETI').RepositoryItem := cxEditQtdEti;

  cxEditQtdEti.Properties.OnValidate := OnCxEditValidate;
End;

Procedure TfrmImpEtiquetas.dbgEtiquetasDblClick(Sender: TObject);
Begin
  Inherited;
  pDigQuantidade;
End;

Function TfrmImpEtiquetas.fRetornaSQLUpdateDiv: String;
Var
  strUpdDiv: String;
Begin
  strUpdDiv := '';
  strUpdDiv := strUpdDiv + 'UPDATE ';
  strUpdDiv := strUpdDiv + '  CADDIV ';
  strUpdDiv := strUpdDiv + 'SET ';
  strUpdDiv := strUpdDiv + '  DIV_QTDETI = :DIV_QTDETI ';
  strUpdDiv := strUpdDiv + 'WHERE ';
  strUpdDiv := strUpdDiv + '  DIV_CODDIV = :DIV_CODDIV ';
  Result := strUpdDiv;
End;

Function TfrmImpEtiquetas.fRetornaSQLDesmarcaDiv: String;
Var
  strUpdDiv: String;
Begin
  strUpdDiv := '';
  strUpdDiv := strUpdDiv + 'UPDATE ';
  strUpdDiv := strUpdDiv + '  CADDIV ';
  strUpdDiv := strUpdDiv + 'SET ';
  strUpdDiv := strUpdDiv + '  DIV_QTDETI = :QTDETI ';
  Result := strUpdDiv;
End;

Procedure TfrmImpEtiquetas.pAbreDiversos;
Begin
  Self.Caption := 'Impressão de Etiquetas - Diversos';
  strCamQtd := 'DIV_QTDETI';

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }
  stlCampos.Add('DIV_QTDETI');
  stlCampos.Add('DIV_CODDIV');
  stlCampos.Add('DIV_NOMDIV');
  stlCampos.Add('DIV_ENDERE');
  stlCampos.Add('DIV_BAIRRO');
  stlCampos.Add('CID_NOMCID');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
  stlDesInd.Add('Endereço');
  stlDesInd.Add('Bairro');
  stlDesInd.Add('Cidade');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLDiv + ' ORDER BY ' + stlCampos[intIndBusca]);
    ParamByName('VALBUS').AsString := '%';
    Open;
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSQLUpdateDiv)
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;
    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'DIV_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'DIV_CODDIV';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'DIV_NOMDIV';
      Caption := 'Nome';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'DIV_ENDERE';
      Caption := 'Endereço';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'DIV_BAIRRO';
      Caption := 'Bairro';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_NOMCID';
      Caption := 'Cidade';
    End;
    EndUpdate;
  End;
End;

Function TfrmImpEtiquetas.fRetornaSQLUpdateFor: String;
Var
  strUpdFor: String;
Begin
  strUpdFor := '';
  strUpdFor := strUpdFor + 'UPDATE ';
  strUpdFor := strUpdFor + '  CADFOR ';
  strUpdFor := strUpdFor + 'SET ';
  strUpdFor := strUpdFor + '  FOR_QTDETI = :FOR_QTDETI ';
  strUpdFor := strUpdFor + 'WHERE ';
  strUpdFor := strUpdFor + '  FOR_CODFOR = :FOR_CODFOR ';
  Result := strUpdFor;
End;

Function TfrmImpEtiquetas.fRetornaSQLDesmarcaFor: String;
Var
  strUpdFor: String;
Begin
  strUpdFor := '';
  strUpdFor := strUpdFor + 'UPDATE ';
  strUpdFor := strUpdFor + '  CADFOR ';
  strUpdFor := strUpdFor + 'SET ';
  strUpdFor := strUpdFor + '  FOR_QTDETI = :QTDETI ';
  Result := strUpdFor;
End;

Procedure TfrmImpEtiquetas.pAbreFornecedores;
Begin

  Self.Caption := 'Impressão de Etiquetas - Fornecedores';
  strCamQtd := 'FOR_QTDETI';

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }
  stlCampos.Add('FOR_QTDETI');
  stlCampos.Add('FOR_CODFOR');
  stlCampos.Add('FOR_NOMFOR');
  stlCampos.Add('CID_NOMCID');
  stlCampos.Add('CID_ESTADO');
  stlCampos.Add('FOR_ENDERE');
  stlCampos.Add('FOR_BAIRRO');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
  stlDesInd.Add('Cidade');
  stlDesInd.Add('Estado');
  stlDesInd.Add('Endereço');
  stlDesInd.Add('Bairro');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLFor + ' ORDER BY ' + stlCampos[intIndBusca]);
    ParamByName('VALBUS').AsString := '%';
    Open;

    pQtdeEtiquetaFornecedor(strSQLAux, ParamByName('VALBUS').AsString);
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSQLUpdateFor)
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;
    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FOR_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FOR_CODFOR';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FOR_NOMFOR';
      Caption := 'Nome';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_NOMCID';
      Caption := 'Cidade';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_ESTADO';
      Caption := 'Estado';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FOR_ENDERE';
      Caption := 'Endereço';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'FOR_BAIRRO';
      Caption := 'Bairro';
    End;
    EndUpdate;
  End;
End;

Function TfrmImpEtiquetas.fRetornaSQLUpdateVen: String;
Var
  strUpdVen: String;
Begin
  strUpdVen := '';
  strUpdVen := strUpdVen + 'UPDATE ';
  strUpdVen := strUpdVen + '  CADOPE ';
  strUpdVen := strUpdVen + 'SET ';
  strUpdVen := strUpdVen + '  OPE_QTDETI = :OPE_QTDETI ';
  strUpdVen := strUpdVen + 'WHERE ';
  strUpdVen := strUpdVen + '  OPE_CODOPE = :OPE_CODOPE ';

  Result := strUpdVen;
End;

Function TfrmImpEtiquetas.fRetornaSQLDesmarcaVen: String;
Var
  strUpdVen: String;
Begin
  strUpdVen := '';
  strUpdVen := strUpdVen + 'UPDATE ';
  strUpdVen := strUpdVen + '  CADOPE ';
  strUpdVen := strUpdVen + 'SET ';
  strUpdVen := strUpdVen + '  OPE_QTDETI = :QTDETI ';

  Result := strUpdVen;
End;

Procedure TfrmImpEtiquetas.pAbreVendedores;
Begin

  Self.Caption := 'Impressão de Etiquetas - Operadores';
  strCamQtd := 'OPE_QTDETI';

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }
  stlCampos.Add('OPE_QTDETI');
  stlCampos.Add('OPE_CODOPE');
  stlCampos.Add('OPE_NOMOPE');
  stlCampos.Add('OPE_ENDERE');
  stlCampos.Add('OPE_BAIRRO');
  stlCampos.Add('CID_ESTADO');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Nome');
  stlDesInd.Add('Endereço');
  stlDesInd.Add('Bairro');
  stlDesInd.Add('Estado');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLVen + ' ORDER BY ' + stlCampos[intIndBusca]);
    ParamByName('VALBUS').AsString := '%';
    Open;
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSQLUpdateVen)
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'OPE_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'OPE_CODOPE';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'OPE_NOMOPE';
      Caption := 'Nome';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'OPE_ENDERE';
      Caption := 'Endereço';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'OPE_BAIRRO';
      Caption := 'Bairro';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'CID_ESTADO';
      Caption := 'Estado';
    End;

    EndUpdate;
  End;
End;

Procedure TfrmImpEtiquetas.btnMarDesClick(Sender: TObject);
Var
  blnConfirma: Boolean;
  intRetorno: Integer;
  intQtdEti: Integer;
  frmDigQtdEti : TfrmDigQtdEti;
Begin
  Inherited;

  intRetorno := 0;

  Try
    pCriarFormularios(TfrmMenuMarcarEti, frmMenuMarcarEti);
    frmMenuMarcarEti.blnEtiIte := (intTipEti = ETI_ITENS);
    frmMenuMarcarEti.ShowModal;

    intRetorno := frmMenuMarcarEti.intLinha;
    blnConfirma := frmMenuMarcarEti.blnConfirma;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.btnMarDesClick]');
    End;
  End;

  pFreeAndNil(frmMenuMarcarEti);

  If blnConfirma Then
  Begin

    If (intRetorno = ETI_MARCAR) Then
    Begin

      If (blnUsaArm) And (intTipEti = ETI_ITENS) Then
        Exit;

      Try
        pCriarFormularios(TfrmDigQtdEti, frmDigQtdEti);
        frmDigQtdEti.ShowModal;

        intQtdEti := frmDigQtdEti.intQtdEti;
      Except
        On E: Exception Do
        Begin
          intQtdEti := 0;
          pMensagensErro(E.Message, '[frmImpEtiquetas.btnMarDesClick_1]');
        End;
      End;

      pFreeAndNil(frmDigQtdEti);

      If intQtdEti > 0 Then
      Begin
        If intTipEti = ETI_ITENS Then
        Begin
          pDesmarcarTodos(0);
          TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
          pDesmarcarTodos(intQtdEti);
          TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
        End
        Else
          pDesmarcarTodos(intQtdEti);
      End;
    End
    Else If intRetorno = ETI_DESMARCAR Then
    Begin
      pDesmarcarTodos(0);
    End;

  End;

  If intTipEti = ETI_ITENS Then
  begin
    cdsCodBar.EmptyDataSet;
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
  end;

  pSetFocus(dbgEtiquetas);
End;

procedure TfrmImpEtiquetas.btnQtdEtiClick(Sender: TObject);
var
  qryGen: TUniQuery;
  frmDigQtdEti : TfrmDigQtdEti;
begin
  Inherited;
  Try
    pCriarFormularios(TfrmDigQtdEti, frmDigQtdEti);
    frmDigQtdEti.ShowModal;

    intQtdEti := frmDigQtdEti.intQtdEti;
  Except
    On E: Exception Do
    Begin
      intQtdEti := 0;
      pMensagensErro(E.Message, '[frmImpEtiquetas.btnMarDesClick_1]');
    End;
  End;
  pFreeAndNil(frmDigQtdEti);

  If intQtdEti > 0 Then
  Begin
    qryGen := fCriaQuery;

    qryImpEti.Filter   := UpperCase(dbgEtiquetasTableView.DataController.Filter.FilterText);
    qryImpEti.Filtered := True;
    qryImpEti.First;
    While not qryImpEti.Eof do
    Begin
      qryGen.SQL.Add(' REPLACE INTO ITEETI (ETI_CODOPE, ETI_CODITE, ETI_QTDETI) ');
      qryGen.SQL.Add(' VALUES  (:CODOPE, :CODITE, :QTDETI) ');
      qryGen.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      qryGen.ParamByName('CODITE').AsString := qryImpEti.FieldByName('ITE_CODITE').AsString;
      qryGen.ParamByName('QTDETI').AsString := intToStr(intQtdEti);
      qryGen.ExecSQL;
      qryGen.SQL.Clear;
      qryImpEti.Next;
    End;
    qryImpEti.Filter   := '';
    qryImpEti.Filtered := False;
    qryImpEti.Refresh;
    If intTipEti = ETI_ITENS Then
      pFiltrarItensEtiquetasEletronicas(qryImpEti);
    pSetFocus(dbgEtiquetas);
    FreeAndNil(qryGen);
  End;
end;

Function TfrmImpEtiquetas.fMarca(strSQL: String; intQtdEti: Integer): Boolean;
Var
  qryGen: TUniQuery;
  frmGravando: TFrmGravando;
Begin
  Try
    Result := True;

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;

      SQL.Text := strSQL;

      If Params.FindParam('QTDETI') <> Nil Then
      Begin
        ParamByName('QTDETI').AsInteger := intQtdEti;
        If intQtdEti = 0 Then
          ParamByName('QTDETI').Clear;
      End;

      pCriarFormularios(TFrmGravando, frmGravando);
      frmGravando.lblGravando.Caption := 'Aguarde... Processando';
      frmGravando.pgbStatus.Visible := False;
      frmGravando.Show;
      Application.ProcessMessages;
      ExecSQL;
      frmGravando.Close;
      FreeAndNil(frmGravando);
    End;
    FreeAndNil(qryGen);

  Except
    Result := False;
  End;

End;

Procedure TfrmImpEtiquetas.pDesmarcarTodos(intQtdEti: Integer; blnVazio: Boolean = False);
Begin
  pnlInfo.Caption := 'Aguarde...';

  Screen.Cursor := crHourGlass;

  If intTipEti = ETI_CLIENTES Then
  Begin
    fMarca(fRetornaSqlDesmarcaCli(True), intQtdEti);
    pAbreClientes;
  End

  Else If intTipEti = ETI_FUNCIONARIOS Then
  Begin
    fMarca(fRetornaSqlDesmarcaFuncionario, intQtdEti);
    pAbreFuncionarios;
  End

  Else If intTipEti = ETI_ITENS Then
  Begin
    If intQtdEti <= 0 Then
      fMarca(fRetornaSQLDesmarcaIte, intQtdEti)
    Else
      fMarca(fRetornaSQLMarcaIte(intQtdEti), intQtdEti);

    If Not blnVazio Then
      pAbreItens;
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
  End
  Else If intTipEti = ETI_ESTRUTURAS Then
  Begin
    fMarca(fRetornaSQLDesmarcaEstr, intQtdEti);
    pAbreEstruturas;
  End
  Else If intTipEti = ETI_DIVERSOS Then
  Begin
    fMarca(fRetornaSQLDesmarcaDiv, intQtdEti);
    pAbreDiversos;
  End
  Else If intTipEti = ETI_FORNECEDORES Then
  Begin
    fMarca(fRetornaSQLDesmarcaFor, intQtdEti);
    pAbreFornecedores;
  End
  Else If intTipEti = ETI_VENDEDORES Then
  Begin
    fMarca(fRetornaSQLDesmarcaVen, intQtdEti);
    pAbreVendedores;
  End;

  pnlInfo.Caption := '';

  Screen.Cursor := crDefault;
End;

Procedure TfrmImpEtiquetas.btnIniBuscaClick(Sender: TObject);
Var
  blnConfirma: Boolean;
Begin
  Inherited;
  blnConfirma := False;

  If Not(intTipEti = ETI_ITENS) Then
    pDesmarcarTodos(0, True);

  If intTipEti = ETI_CLIENTES Then
  Begin
    blnConfirma := fFiltraClientes;
  End

  Else If intTipEti = ETI_FUNCIONARIOS Then
  Begin
    blnConfirma := fFiltraFuncionarios;
  End

  Else If intTipEti = ETI_ITENS Then
  Begin
    blnConfirma := fFiltraItens;
  End
  Else If intTipEti = ETI_DIVERSOS Then
  Begin
    blnConfirma := fFiltraDiversos;
  End
  Else If intTipEti = ETI_ESTRUTURAS Then
  Begin
    blnConfirma := fFiltraEstruturas;
  End
  Else If intTipEti = ETI_FORNECEDORES Then
  Begin
    blnConfirma := fFiltraFornecedores;
  End
  Else If intTipEti = ETI_VENDEDORES Then
  Begin
    blnConfirma := fFiltraVendedor;
  End;

  If blnConfirma Then
  Begin
    qryImpEti.Close;
    qryImpEti.Open;

    If intTipEti = ETI_ITENS Then
    Begin
      (qryImpEti.FieldByName('ITE_PREVE' + fPrimeiraTabPreco) As TFloatField).DisplayFormat := '#,##0.00';
      TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
     End;
  End;
  pSetFocus(dbgEtiquetas);
End;

Function TfrmImpEtiquetas.fGetFiltrosClientes(strNomIni: String;
  strNomFin: String; strCodVen: String; strCodAti: String; strCodCid: String;
  strBairro: String; strEstado: String; strStatus: String; strAniIni: String;
  strAniFin: String; strCodCli: String; strCodCac: String; strCodReg: String;
  strRevist: String; strSexo__: String; strCGCCPF: String; strTipCli: String;
  strConFin: String): String;

Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strNomIni) Then
  Begin
    strSQL := strSQL +
      ' AND LEFT(CLI_NOMCLI, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';
  End;

  If Not fEmptyStr(strCodVen) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtCodVen, frmFiltroEtiClientes.arrVendedor, 'CLI_CODVEN', 'CODVEN');
  End;

  If Not fEmptyStr(strCodAti) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtCodAti, frmFiltroEtiClientes.arrAtividade, 'CLI_CODATI', 'CODATI');
  End;

  If Not fEmptyStr(strCodCid) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtCodCid, frmFiltroEtiClientes.arrCidade, 'CLI_CODCID', 'CODCID');
  End;

  If Not fEmptyStr(strBairro) Then
  Begin
    strSQL := strSQL + ' AND CLI_BAIRRO = :BAIRRO ';
  End;

  If Not fEmptyStr(strEstado) Then
  Begin
    strSQL := strSQL + ' AND D1.CID_ESTADO = :ESTADO ';
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(strAniIni))) Then
  Begin
    strSQL := strSQL +
      '  AND (DATE_FORMAT(CLI_NASCIM, "%m/%d") BETWEEN :ANIINI AND :ANIFIN) ';
  End;

  If Not fEmptyStr(strCodCli) Then
  Begin
    strSQL := strSQL + ' AND LOCATE(C.CLI_CODCLI, :CODCLI) > 0 ';
  End;

  If Not fEmptyStr(strCodCac) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtCodCac, frmFiltroEtiClientes.arrCanal, 'CLI_CODCAC', 'CODCAC');
  End;

  If Not fEmptyStr(strCodReg) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtCodReg, frmFiltroEtiClientes.arrRegiao, 'CLI_CODREG', 'CODREG');
  End;

  If Not fEmptyStr(strRevist) Then
  Begin
    strSQL := strSQL + ' AND CLI_REVIST = :REVIST ';
  End;

  If Not fEmptyStr(strSexo__) And CharInSet(strSexo__[1], ['M', 'F']) Then
  Begin
    strSQL := strSQL + ' AND CLI_SEXO__ = :SEXO__ ';
  End;

  { ********************************************* }
  { * FILTRO DE PESSOA JURÍDICA / PESSOA FÍSICA * }
  { ******************************************MA* }
  If Not fEmptyStr(strCGCCPF) Then
  Begin
    strSQL := strSQL + ' AND CLI_CGCCPF = :CGCCPF ';
  End;

  { ************************************************* }
  { * FILTROS DE TIPO DE CLIENTE / CONSUMIDOR FINAL * }
  { **********************************************CG* }
  If Not fEmptyStr(strTipCli) Then
  Begin
    strSQL := strSQL + fStrLocate(frmFiltroEtiClientes.edtTipCli, frmFiltroEtiClientes.arrTipCli, 'CLI_TIPCLI', 'TIPCLI');
  End;

  If Not fEmptyStr(strConFin) Then
  Begin
    If strConfin <> 'T' Then
      strSQL := strSQL + ' AND CLI_CONSUM = :CONFIN ';
  End;

  { ********************************************************************** }
  { * ATENÇÃO! QUANDO FIZER ALGUMA ALTERAÇÃO NOS FILTROS DO CLIENTE NÃO  * }
  { * ESQUECER DE ALTERAR OS FILTROS DA PROCEDURE "pQtdeEtiquetaCliente" * }
  { * POIS ELA MOSTRA A QUANTIDADES DE ETIQUETAS QUE SERÃO IMPRESSAS.    * }
  { *******************************************************************PZ* }

  Result := strSQL;
End;

Procedure TfrmImpEtiquetas.pSetParamsClientes(strNomIni, strNomFin, strCodVen,
  strCodAti, strCodCid, strBairro, strEstado, strStatus, strAniIni, strAniFin,
  strCodCli, strCodCac, strCodReg, strRevist, strSexo__, strCGCCPF, strTipCli, strConFin: String);

Var
  strLinVen: String;
  strLinAti: String;
  strLinCid: String;
  strLinCac: String;
  strLinReg: String;
  strLinTipCli :String;

Begin
  With qryImpEti Do
  Begin

    If Not fEmptyStr(strNomIni) Then
    Begin
      If Length(strNomIni) > Length(strNomFin) Then
        ParamByName('MAIOR').AsString := strNomIni
      Else
        ParamByName('MAIOR').AsString := strNomFin;

      ParamByName('NOMINI').AsString := strNomIni;
      ParamByName('NOMFIN').AsString := strNomFin;
    End;

    If Not fEmptyStr(strCodVen) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtCodVen.Text,
        frmFiltroEtiClientes.arrVendedor, strLinVen, 'CODVEN', qryImpEti);
    End;

    If Not fEmptyStr(strCodAti) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtCodAti.Text,
        frmFiltroEtiClientes.arrAtividade, strLinAti, 'CODATI', qryImpEti);
    End;

    If Not fEmptyStr(strCodCid) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtCodCid.Text,
        frmFiltroEtiClientes.arrCidade, strLinCid, 'CODCID', qryImpEti);
    End;

    If Not fEmptyStr(strBairro) Then
    Begin
      ParamByName('BAIRRO').AsString := strBairro;
    End;

    If Not fEmptyStr(strEstado) Then
    Begin
      ParamByName('ESTADO').AsString := strEstado;
    End;

    If Not fEmptyStr(strRevist) Then
    Begin
      ParamByName('REVIST').AsString := strRevist;
    End;

    If Not fEmptyStr(strSexo__) And CharInSet(strSexo__[1], ['M', 'F']) Then
    Begin
      ParamByName('SEXO__').AsString := strSexo__;
    End;

    { ***************************************** }
    { * ACRESCENTOU FILTRO DE CANAL DE ACESSO * }
    { **************************************DP* }
    If Not fEmptyStr(strCodCac) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtCodCac.Text,
        frmFiltroEtiClientes.arrCanal, strLinCac, 'CODCAC', qryImpEti);
    End;

    { ***************************************** }
    { * ACRESCENTOU FILTRO DE REGIAO          * }
    { **************************************AC* }
    If Not fEmptyStr(strCodReg) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtCodReg.Text,
        frmFiltroEtiClientes.arrRegiao, strLinReg, 'CODREG', qryImpEti);
    End;

    If (Not fEmptyStr(fTiraCaracEspeciais(strAniIni))) Then
    Begin
      ParamByName('ANIINI').AsString := RightStr(strAniIni, 2) + '/' +
        LeftStr(strAniIni, 2);
      ParamByName('ANIFIN').AsString := RightStr(strAniFin, 2) + '/' +
        LeftStr(strAniFin, 2);
    End;

    If Not fEmptyStr(strCodCli) Then
    Begin
      ParamByName('CODCLI').AsString := strCodCli;
    End;

    { ********************************************* }
    { * FILTRO DE PESSOA JURÍDICA / PESSOA FÍSICA * }
    { ******************************************MA* }
    If Not fEmptyStr(strCGCCPF) Then
    Begin
      ParamByName('CGCCPF').AsString := strCGCCPF;
    End;

    { ************************************************* }
    { * FILTROS DE TIPO DE CLIENTE / CONSUMIDOR FINAL * }
    { **********************************************CG* }
    If Not fEmptyStr(strTipCli) Then
    Begin
      pSetaParam(frmFiltroEtiClientes.edtTipCli.Text,
        frmFiltroEtiClientes.arrTipCli, strLinTipCli, 'TIPCLI', qryImpEti);
    End;

    If Not fEmptyStr(strConFin) Then
    Begin
      If strConfin <> 'T' Then
        ParamByName('CONFIN').AsString := strConFin;
    End;
  End;

End;

Function TfrmImpEtiquetas.fSetFiltraClientes(strNomIni: String;
  strNomFin: String; strCodVen: String; strCodAti: String; strCodCid: String;
  strBairro: String; strEstado: String; strStatus: String; strAniIni: String;
  strAniFin: String; intQtdEti: Integer; strCodCli: String; strCodCac: String;
  strCodReg: String; strRevist: String; strSexo__: String;
  strCGCCPF: String; strTipCli: String; strConFin: String): Boolean;

Begin
  Result := True;

  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSqlFiltroCli + fGetFiltrosClientes(strNomIni, strNomFin,
        strCodVen, strCodAti, strCodCid, strBairro, strEstado, strAniIni,
        strAniFin, strStatus, strCodCli, strCodCac, strCodReg, strRevist,
        strSexo__, strCGCCPF, strTipCli, strConFin));

      pSetParamsClientes(strNomIni, strNomFin, strCodVen, strCodAti, strCodCid,
        strBairro, strEstado, strStatus, strAniIni, strAniFin, strCodCli,
        strCodCac, strCodReg, strRevist, strSexo__, strCGCCPF, strTipCli, strConFin);

      ParamByName('CLI_QTDETI').AsInteger := intQtdEti;

      ExecSQL;

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmImpEtiquetas.fSetFiltraClientes]');
      Result := False;
    End;
  End;
End;

Function TfrmImpEtiquetas.fCriarOcorrenciasCRM(blnResultado: Boolean): Boolean;
Begin
  // Se usar crm
  // Se imprimiu etiquetas clientes
  // Se os clientes foram filtrados
  Result := (VS_strHabilitarCRM) And (blnResultado) And
    (Not fEmptyStr(strCliVen));
End;

function TfrmImpEtiquetas.fDataHrAlt(strCodite,strCodEmp: String; strDtaAlt : TDateTime): TDateTime;
begin
  Result := fCampoTabela('MAX(ALT_HORALT) AS ALT_HORALT', 'PREALT', ['ALT_CODITE','ALT_CODEMP','ALT_DTAALT'], [strCodIte,strCodEmp,strDtaAlt], False);
end;

function TfrmImpEtiquetas.fDataHrImp(strCodite,strCodEmp: String; strDtaAlt : TDateTime): TDateTime;
begin
  Result := fCampoTabela('MAX(ITE_HORETI) AS ITE_HORETI', 'ITEGER', ['ITE_CODITE','ITE_CODEMP','ITE_DTAETI'], [strCodIte,strCodEmp,strDtaAlt], False);
end;

Function TfrmImpEtiquetas.fDiaSemanaAlfabeto: String;
Begin
  Case DayOfTheWeek(VS_Date) Of
    1:
      Result := 'A'; // Domingo
    2:
      Result := 'B'; // Segunda
    3:
      Result := 'C'; // Terça
    4:
      Result := 'D'; // Quarta
    5:
      Result := 'E'; // Quinta
    6:
      Result := 'F'; // Sexta
    7:
      Result := 'G'; // Sabado
  End;
End;

Function TfrmImpEtiquetas.fFiltraClientes: Boolean;
Var
  strNomIni: String;
  strNomFin: String;
  strCodVen: String;
  strCodAti: String;
  strCodCid: String;
  strCodCac: String;
  strRevist: String;
  strSexo__: String;
  strCodReg: String;
  strBairro: String;
  strEstado: String;
  strStatus: String;
  intQtdEti: Integer;
  strAniIni: String;
  strAniFin: String;
  strSQL: String;
  strFil: String;
  fltVlrFat: Double;
  strCGCCPF: String;
  strTipCli: String;
  strConFin: String;
Begin

  pDesmarcarTodos(0);

  Try
    pCriarFormularios(TfrmFiltroEtiClientes, frmFiltroEtiClientes);
    frmFiltroEtiClientes.ShowModal;

    strNomIni := frmFiltroEtiClientes.strNomIni;
    strNomFin := frmFiltroEtiClientes.strNomFin;
    strCodVen := frmFiltroEtiClientes.strCodVen;
    strCodAti := frmFiltroEtiClientes.strCodAti;
    strCodCid := frmFiltroEtiClientes.strCodCid;
    strCodCac := frmFiltroEtiClientes.strCodCac;
    strRevist := frmFiltroEtiClientes.strRevist;
    strSexo__ := frmFiltroEtiClientes.strSexo__;
    strCodReg := frmFiltroEtiClientes.strCodReg;
    strBairro := frmFiltroEtiClientes.strBairro;
    strEstado := frmFiltroEtiClientes.strEstado;

    Case rdgStatus.ItemIndex Of
      0:
        strStatus := '%A';
      1:
        strStatus := '%I';
      2:
        strStatus := '%';
    End;

    intQtdEti := frmFiltroEtiClientes.intQtdEti;
    strAniIni := frmFiltroEtiClientes.strAniIni;
    strAniFin := frmFiltroEtiClientes.strAniFin;
    strDtaIni := frmFiltroEtiClientes.strDtaIni;
    strDtaFin := frmFiltroEtiClientes.strDtaFin;
    strTipPer := frmFiltroEtiClientes.strTipPer;
    blnMosFil := frmFiltroEtiClientes.chkMosFil.Checked;
    fltVlrFat := frmFiltroEtiClientes.fltVlrFat;
    strCGCCPF := frmFiltroEtiClientes.strCGCCPF;

    strTipCli := frmFiltroEtiClientes.strTipCli;
    strConFin := frmFiltroEtiClientes.strConFin;

    strComIni := frmFiltroEtiClientes.strComIni;
    strComFin := frmFiltroEtiClientes.strComFin;
    strNaoIni := frmFiltroEtiClientes.strNaoIni;
    strNaoFin := frmFiltroEtiClientes.strNaoFin;

    If fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
    Begin
      blnMovDet := False;
      strCliVen := '';
    End
    Else
    Begin
      blnMovDet := True;
      If strTipPer = '1' Then
        strCliVen := fRetornaClientesComVenda(fltVlrFat)
      Else
        strCliVen := fRetornaClientesComUltCompra(fltVlrFat);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(strComIni)) And fEmptyStr(fTiraCaracEspeciais(strDtaFin)) Then
    Begin
      blnMovDet := True;
      strCliVen:= fRetornaClientesComSemCompra(fltVlrFat);
    End;

    Result := frmFiltroEtiClientes.blnConfirma;
//    edtBusca.Clear;

    If Result Then
    Begin
      Screen.Cursor := crHourGlass;
      pnlInfo.Caption := 'Aguarde...';
      strFil := '';

      Try
        fSetFiltraClientes(strNomIni, strNomFin, strCodVen, strCodAti,
          strCodCid, strBairro, strEstado, strStatus, strAniIni, strAniFin,
          intQtdEti, strCliVen, strCodCac, strCodReg, strRevist, strSexo__,
          strCGCCPF, strTipCli, strConFin);

        strSQL := fRetornaSQLCli;

        If blnMosFil Then
          strFil := fGetFiltrosClientes(strNomIni, strNomFin, strCodVen,
            strCodAti, strCodCid, strBairro, strEstado, strStatus, strAniIni,
            strAniFin, strCliVen, strCodCac, strCodReg, strRevist, strSexo__,
            strCGCCPF, strTipCli, strConFin);

        strSQL := strSQL + strFil + ' ORDER BY ' + stlCampos[intIndBusca];

        With qryImpEti Do
        Begin

          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('VALBUS').AsString := '%';
          Case rdgStatus.ItemIndex Of
            0:
              ParamByName('STATUS').AsString := '%A';
            1:
              ParamByName('STATUS').AsString := '%I';
            2:
              ParamByName('STATUS').AsString := '%';
          End;

          If blnMosFil Then
          Begin

            pSetParamsClientes(strNomIni, strNomFin, strCodVen, strCodAti,
              strCodCid, strBairro, strEstado, strStatus, strAniIni, strAniFin,
              strCliVen, strCodCac, strCodReg, strRevist, strSexo__, strCGCCPF, strTipCli, strConFin);

          End;
          strFil := fGetFiltrosClientes(strNomIni, strNomFin, strCodVen,
            strCodAti, strCodCid, strBairro, strEstado, strStatus, strAniIni,
            strAniFin, strCliVen, strCodCac, strCodReg, strRevist, strSexo__,
            strCGCCPF, strTipCli, strConFin);

          strSQLAux := strSQLAux + strFil;

          pQtdeEtiquetaCliente(strSQLAux, ParamByName('VALBUS').AsString,
            strNomIni, strNomFin, strCodVen, strCodAti, strCodCid, strBairro,
            strEstado, strStatus, strAniIni, strAniFin, strCliVen, strCodCac,
            strCodReg, strRevist, strSexo__, strCGCCPF, strTipCli, strConFin);

        End;

        pnlInfo.Caption := '';
        Screen.Cursor := crDefault;

      Except
        On E: Exception Do
        Begin
          Result := False;
          pMensagensErro(E.Message, '[ Filtro de Etiquetas de Clientes ]');
        End;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ frmImpEtiquetas.fFiltraClientes ]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiClientes);

End;

Function TfrmImpEtiquetas.fGetFiltrosItens(strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
  strCodMar, strCodPro, strCodDep: String; blnCodBar: Boolean; strCodFor, strLinGru, strPrdGru, strSitPro: String;
  arrMarcaP: TConsultasArray; arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray;
  arrFornecP: TConsultasArray; arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
  arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
  strIteEmb: String;
  blnFiltra: Boolean = True; strLocFis: String = ''; strLocIni: String = '';
  strLocFin: String = ''; strCodAmz: String = ''; strLocIniSup: String = '';
  strLocFinSup: String = ''; blnPromocPeriod: Boolean = False;
  strRuaIni: String = ''; strRuaFin: String = ''; strPredioIni: String = '';
  strPredioFin: String = ''; strAndarIni: String = ''; strAndarFin: String = '';
  strApartamentoIni: String = ''; strApartamentoFin: String = ''; strCodLse : String = ''; strIteLot : String = 'T' ): String;
Var
  strSQL: String;
  edtCodigo: TEditFocus;
  mskCodigo: TMaskEditFocus;
Begin
  strSQL := '';
  edtCodigo := TEditFocus.Create(Nil);
  mskCodigo := TMaskEditFocus.Create(Nil);

  If Not fEmptyStr(strDesIte) Then
  Begin
    strSQL := strSQL + ' AND CADITE.ITE_DESITE LIKE :DESITE ';
  End;

  If Not fEmptyStr(strDesSim) Then
  Begin
    strSQL := strSQL + ' AND CADITE.ITE_DESSIM LIKE :DESSIM ';
  End;

  If Not fEmptyStr(strRefere) Then
  Begin
    strSQL := strSQL + ' AND CADITE.ITE_REFERE LIKE CONCAT(:REFERE, "%") ';
  End;

  If blnCodBar Then
    strSQL := strSQL + '   AND TRIM(CADITE.ITE_BARRAS) <> "" ';

  If rdgStatus.ItemIndex <> 2 Then
  Begin
    strSQL := strSQL + ' AND ';
    strSQL := strSQL + ' CADITE.ITE_ITEATI = :STATUS ';
  End;

  //Filtro item com embalagem fechada
  If (Pos(strIteEmb, 'S_N_') > 0) Then //Todos
  Begin
    strSQL := strSQL + ' AND ( SELECT COUNT(*)                       ';
    strSQL := strSQL + '         FROM ITEEMB                         ';
    strSQL := strSQL + '        WHERE ITB_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '          AND ITB_CODEMP = ITEGER.ITE_CODEMP ';

    If strIteEmb = 'S' Then //Sim
      strSQL := strSQL + ' ) > 0 ';

    If strIteEmb = 'N' Then //Não
      strSQL := strSQL + ' ) = 0 ';
  End;

  //Filtro Alteração dos Itens com desconto de embalagem (por data)
  If (Pos(strIteEmb, 'S_T_') > 0) and (fTabelaExiste('DTAEMB', True)) Then
  begin
    strSQL := strSQL + ' AND ( SELECT COUNT(*)                                          ';
    strSQL := strSQL + '         FROM DTAEMB                                            ';
    strSQL := strSQL + '        WHERE DTAEMB.EMB_CODITE = ITEGER.ITE_CODITE             ';
    strSQL := strSQL + '          AND DTAEMB.EMB_CODEMP = ITEGER.ITE_CODEMP             ';
    strSQL := strSQL + '          AND DTAEMB.EMB_DTAALT BETWEEN :PRDTIN AND :PRDTFN ) > 0 ';
  end;

  //Filtro item com lote
  If (Pos(strIteLot, 'S_N_') > 0) then
  begin
    strSQL := strSQL + ' AND ( SELECT COUNT(*)                       ';
    strSQL := strSQL + '         FROM CADLOT                         ';
    strSQL := strSQL + '        WHERE LOT_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '          AND LOT_CODEMP = ITEGER.ITE_CODEMP ';

    If strIteLot = 'S' Then //Sim
      strSQL := strSQL + ' ) > 0 ';

    If strIteLot = 'N' Then //Não
      strSQL := strSQL + ' ) = 0 ';

  end;

  If fUsaRotinaWMS Then
  Begin

    strSQL := strSQL + ' AND (SELECT COUNT(1) ';
    strSQL := strSQL + '      FROM CADLOT                                       ';
    strSQL := strSQL + '        INNER JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS    ';
    strSQL := strSQL + '                         AND LOC_CODEMP = LOT_CODEMP    ';
    strSQL := strSQL + '      WHERE CADITE.ITE_CODITE = LOT_CODITE              ';
    strSQL := strSQL + '        AND LOT_CODEMP        = ITEGER.ITE_CODEMP ';

    strSQL := strSQL + fStrLocate(strCodLse, arrCodLse, 'LOC_CODLSE', 'CODLSE');

    If not fEmptyStr(strRuaIni) Then
    Begin
      If not fEmptyStr(strRuaFin) Then
      Begin
        strSQL := strSQL + ' AND LOC_R_U_A_ BETWEEN :RUAINI AND :RUAFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_R_U_A_ = :RUAINI ';
    End;

    If not fEmptyStr(strPredioIni) Then
    Begin
      If not fEmptyStr(strPredioFin) Then
      Begin
        strSQL := strSQL + ' AND LOC_PREDIO BETWEEN :PREINI AND :PREFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_PREDIO = :PREINI ';
    End;

    If not fEmptyStr(strAndarIni) Then
    Begin
      If not fEmptyStr(strAndarFin) Then
      Begin
        strSQL := strSQL + ' AND LOC_ANDAR_ BETWEEN :ANDINI AND :ANDFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_ANDAR_ = :ANDINI ';
    End;

    If not fEmptyStr(strApartamentoIni) Then
    Begin
      If not fEmptyStr(strApartamentoFin) Then
      Begin
        strSQL := strSQL + ' AND LOC_APARTA BETWEEN :APTINI AND :APTFIN '
      End
      Else
        strSQL := strSQL + ' AND LOC_APARTA = :APTINI ';
    End;

    Case rdgSaldos.ItemIndex Of
      1: strSQL := strSQL + ' AND LOT_SALDOS > 0 ';
      2: strSQL := strSQL + ' AND LOT_SALDOS < 0 ';
    End;

    case blnSalMin Of
      TRUE: strSQL := strSQL + ' AND LOT_SALDOS >= ITEGER.ITE_ESTMIN ';
    end;

    strSQL := strSQL + ' ) > 0  ';
  End
  Else
  begin
    If (blnSalAmz) Then
    Begin
      strSQL := strSQL + ' AND CADLOT.LOT_SALDOS > 0 ';
      If (not fEmptyStr(strCodAmz)) Then
        strSQL := strSQL + fStrLocate(strCodAmz, arrCodAmz, 'LOT_NUMLOT','CODAMZ');
    End
    Else If (not fEmptyStr(strCodAmz)) and (intExibeEstoque = 1) then
    Begin
      Case rdgSaldos.ItemIndex Of
        1: strSQL := strSQL + ' AND CADLOT.LOT_SALDOS > 0 ';
        2: strSQL := strSQL + ' AND CADLOT.LOT_SALDOS < 0 ';
      end;

      case blnSalMin Of
        TRUE: strSQL := strSQL + ' AND CADLOT.LOT_SALDOS >= ITEGER.ITE_ESTMIN ';
      end;
    end
    else
    Begin
      Case rdgSaldos.ItemIndex Of
        1: strSQL := strSQL + ' AND ITEGER.ITE_SALDOS > 0 ';
        2: strSQL := strSQL + ' AND ITEGER.ITE_SALDOS < 0 ';
      end;

      case blnSalMin Of
        TRUE: strSQL := strSQL + ' AND ITEGER.ITE_SALDOS >= ITEGER.ITE_ESTMIN ';
      end;
    End;
  end;
  If Not fEmptyStr(strCodPro) Then
  Begin
    edtCodigo.Text := strCodPro;
    strSQL := strSQL + ' AND CADITE.ITE_CODITE IN                                                                              '+
                       ' (                                                                                                     '+
                       '  SELECT                                                                                               '+
                       '    DISTINCT IPR_CODITE                                                                                '+
                       '  FROM                                                                                                 '+
                       '    ITEPRO                                                                                             '+
                       '  WHERE                                                                                                '+
                       '    ITEPRO.IPR_SEQGER IN (SELECT                                                                       '+
                       '                            CADPRO.AUTOINCREM                                                          '+
                       '                          FROM                                                                         '+
                       '                            CADPRO                                                                     '+
                       '                          WHERE                                                                        '+
                       '                            ' + fStrLocate(edtCodigo, arrPromocP, 'CADPRO.PRO_CODPRO', 'CODPRO', True)  +
                       '                         ))                                                                            ';
  End;

  If blnFiltra Then
  Begin
    If Not fEmptyStr(strDesIni) Then
    Begin
      strSQL := strSQL +
        ' AND LEFT(CADITE.ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESINI AND :DESFIN ';
    End;

    If Not fEmptyStr(strCodMar) Then
    Begin
      edtCodigo.Text := strCodMar;
      strSQL := strSQL + fStrLocate(edtCodigo, arrMarcaP, 'CADITE.ITE_CODMAR', 'CODMAR');
    End;

    If Not fEmptyStr(strCodDep) Then
    Begin
      edtCodigo.Text := strCodDep;
      strSQL := strSQL + fStrLocate(edtCodigo, arrCodDepP, 'CADITE.ITE_CODDEP', 'CODDEP');
    End;

    If Not fEmptyStr(strCodFor) Then
    Begin
      edtCodigo.Text := strCodFor;
      strSQL := strSQL + fStrLocate(edtCodigo, arrFornecP, 'CADITE.ITE_CODFOR', 'CODFOR');
    End;

    If Not fEmptyStr(strPrdGru) Then
    Begin
      edtCodigo.Text := strPrdGru;
      strSQL := strSQL + fStrLocate(edtCodigo, arrPrdGruP, 'CADITE.ITE_PRDGRU', 'CODGRU');
    End;

    If Not fEmptyStr(strSitPro) Then
    Begin
      edtCodigo.Text := strSitPro;
      If fCfgSis('SITEMP', varInteger) = 1 Then
        strSQL := strSQL + fStrLocate(edtCodigo, arrSitProP, 'CADITE.ITE_SITPRO', 'CODSIT')
      Else
        strSQL := strSQL + fStrLocate(edtCodigo, arrSitProP, 'ITEGER.ITE_SITPRO', 'CODSIT');
    End;

    If Not fEmptyStr(strLinGru) Then
    Begin
      mskCodigo.Text := strLinGru;
      strSQL := strSQL + fStrLocateLinGru(mskCodigo, arrGruposP, 'CADITE.ITE_CODGRU', 'CODGRU');
    End;

    If blnUsaArm Then
    Begin
      If Not fUsaRotinaWMS Then
      Begin
        If (Not fEmptyStr(strLocFis)) Then
        Begin
          edtCodigo.Text := strCodAmz;
          strSQL := strSQL + '  AND  ';
          strSQL := strSQL +
            '  (SELECT COUNT(*)                                    ' +
            '     FROM CADLOT                                      ' +
            '    WHERE LEFT(LOT_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS ';
          If (Not fEmptyStr(strCodAmz)) Then
            strSQL := strSQL + fStrLocate(edtCodigo, arrCodAmz, 'LOT_NUMLOT', 'CODAMZ');
          strSQL := strSQL + ' AND CADITE.ITE_CODITE = LOT_CODITE              ';
          strSQL := strSQL + ' AND LOT_CODEMP        = ITEGER.ITE_CODEMP) > 0  ';

        End;
      End;
    End
    Else
    Begin
      If Not fEmptyStr(strLocFis) Then
      Begin
        strSQL := strSQL + '  AND  ';
        strSQL := strSQL +
          '  LEFT(ITEGER.ITE_LOCFIS, LENGTH(:TAMLOC)) = :LOCFIS ';
      End;
    End;

    If blnUsaArm Then
    Begin
      If Not fUsaRotinaWMS Then
      Begin
        If (Not fEmptyStr(strLocIni)) Then
        Begin
          edtCodigo.Text := strCodAmz;
          strSQL := strSQL + '  AND  ';
          strSQL := strSQL + '  (SELECT COUNT(*) ' + '     FROM CADLOT   ' +
            '    WHERE LEFT(LOT_LOCFIS, LENGTH(:TAMLOF)) BETWEEN :LOCINI ' +
            '                                                AND :LOCFIN ';
          If (Not fEmptyStr(strCodAmz)) Then
            strSQL := strSQL + fStrLocate(edtCodigo, arrCodAmz, 'LOT_NUMLOT','CODAMZ');
          strSQL := strSQL + '      AND CADITE.ITE_CODITE = LOT_CODITE      ';
          strSQL := strSQL + '      AND LOT_CODEMP        = ITEGER.ITE_CODEMP) > 0 ';

        End;
      End;
    End
    Else
    Begin
      If Not fEmptyStr(strLocIni) Then
      Begin
        If fUsaRotinaWMS Then
        Begin
          strSQL := strSQL + '  AND  ';
          strSQL := strSQL +
            '  (SELECT COUNT(*)                                          ' +
            '     FROM CADLOT                                            ' +
            '    WHERE LEFT(LOT_LOCFIS, LENGTH(:TAMLOF)) BETWEEN :LOCINI ' +
            '                                                AND :LOCFIN ' +
            '      AND CADITE.ITE_CODITE = LOT_CODITE                    ' +
            '      AND LOT_CODEMP        = ITEGER.ITE_CODEMP) > 0        ';

        End
        Else
        Begin
          strSQL := strSQL + '  AND  ';
          strSQL := strSQL +
            '   LEFT(ITEGER.ITE_LOCFIS, LENGTH(:TAMLOF)) BETWEEN :LOCINI AND :LOCFIN ';
        End;
      End;
    End;

    { *************************** }
    { * FILTRO DO SUPER ESTOQUE * }
    { *************************FC }
    If Not fEmptyStr(strLocIniSup) Then
    Begin
      strSQL := strSQL + '  AND  ';
      strSQL := strSQL + '   LEFT(ITEGER.ITE_LOCSUP, LENGTH(:TAMLOS)) BETWEEN :LOCINISUP AND :LOCFINSUP ';
    End;
  End;

  If (blnPromoc) And (blnMosFil)  And (Not blnPromocPeriod) Then
  Begin
    strSQL := strSQL + 'AND CADITE.ITE_CODITE IN (' + IIF(stlPromoc.Count > 0,
      fCommaText(stlPromoc, True), '""') + ') ';
  End;

  Result := strSQL;

  FreeAndNil(edtCodigo);
  FreeAndNil(mskCodigo);
End;

Procedure TfrmImpEtiquetas.pSetParamsItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni,
  strDesFin, strDesIte, strDesSim, strRefere, strCodMar, strCodPro, strCodDep, strCodFor, strLinGru,
  strPrdGru, strSitPro: String;
  arrMarcaP: TConsultasArray; arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray;
  arrFornecP: TConsultasArray; arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
  arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
  blnFiltra: Boolean = True; strLocFis: String = ''; strLocIni: String = '';
  strLocFin: String = ''; strCodAmz: String = ''; strLocIniSup: String = '';
  strLocFinSup: String = ''; strRuaIni: String = ''; strRuaFin: String = '';
  strPredioIni: String = ''; strPredioFin: String = ''; strAndarIni: String = '';
  strAndarFin: String = ''; strApartamentoIni: String = '';
  strApartamentoFin: String = ''; strCodLse : String = ''; strPrecoDtaIni: String = ''; strPrecoDtaFin: String = '');
Var
  strLinha: String;
  strCodLseRetorno: String;
Begin
  With qryImpEti Do
  Begin
    If Not fEmptyStr(strDesIni) And (blnFiltra) Then
    Begin
      If Length(strDesIni) > Length(strDesFin) Then
        ParamByName('MAIOR').AsString := strDesIni
      Else
        ParamByName('MAIOR').AsString := strDesFin;

      ParamByName('DESINI').AsString := strDesIni;
      ParamByName('DESFIN').AsString := strDesFin;
    End;

    If Not fEmptyStr(strDesIte) Then
      ParamByName('DESITE').AsString := strDesIte + '%';

    If Not fEmptyStr(strDesSim) Then
      ParamByName('DESSIM').AsString := strDesSim + '%';

    If Not fEmptyStr(strRefere) Then
      ParamByName('REFERE').AsString := strRefere;

    If Not fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
    Begin
      ParamByName('DTAINI').AsDate := StrToDate(strDtaIni);
      ParamByName('DTAFIN').AsDate := StrToDate(strDtaFin);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(strHraIni,True,True,True,True)) Then
      ParamByname('HRAINI').AsString := strHraIni;

    If Not fEmptyStr(fTiraCaracEspeciais(strHraFin,True,True,True,True)) Then
      ParamByname('HRAFIN').AsString := strHraFin;

    If (blnFiltra) Then
      pSetaParam(strCodMar, arrMarcaP, strLinha, 'CODMAR', qryImpEti);

    If (blnFiltra) Then
      pSetaParam(strCodPro, arrPromocP, strLinha, 'CODPRO', qryImpEti);

    If (blnFiltra) Then
      pSetaParam(strCodDep, arrCodDepP, strLinha, 'CODDEP', qryImpEti);

    If (blnFiltra) Then
      pSetaParam(strPrdGru, arrPrdGruP, strLinha, 'CODGRU', qryImpEti);

    If (blnFiltra) Then
      pSetaParam(strSitPro, arrSitProP, strLinha, 'CODSIT', qryImpEti);

    If (blnFiltra) Then
      pSetaParam(strCodFor, arrFornecP, strLinha, 'CODFOR', qryImpEti);

    If Not fEmptyStr(strLinGru) And (blnFiltra) Then
      pSetaParam(strLinGru, arrGruposP, strLinha, 'CODGRU', qryImpEti);

    Case rdgStatus.ItemIndex Of
      0:
        ParamByName('STATUS').AsString := 'S';
      1:
        ParamByName('STATUS').AsString := 'N';
    End;

    If Not fEmptyStr(strLocFis) Then
    Begin
      ParamByName('TAMLOC').AsString := strLocFis;
      // ParamByName('TAMLOC').AsInteger := Length(strLocFis);
      ParamByName('LOCFIS').AsString := strLocFis;
    End;

    If Not fEmptyStr(strLocIni) Then
    Begin
      If Length(strLocIni) > Length(strLocFin) Then
        ParamByName('TAMLOF').AsString := strLocIni
      Else
        ParamByName('TAMLOF').AsString := strLocFin;

      ParamByName('LOCINI').AsString := strLocIni;
      ParamByName('LOCFIN').AsString := strLocFin;
    End;

    { *************************************** }
    { * PARAMETROS LOC.FISICA SUPER ESTOQUE * }
    { *************************************FC }
    If Not fEmptyStr(strLocIniSup) Then
    Begin
      If Length(strLocIniSup) > Length(strLocFinSup) Then
        ParamByName('TAMLOS').AsString := strLocIniSup
      Else
        ParamByName('TAMLOS').AsString := strLocFinSup;

      ParamByName('LOCINISUP').AsString := strLocIniSup;
      ParamByName('LOCFINSUP').AsString := strLocFinSup;
    End;

    If (Not fEmptyStr(strCodAmz)) And
      ((Not fEmptyStr(strLocFis + strLocIni)) or (blnSalAmz)) Then
      pSetaParam(strCodAmz, arrCodAmzP, strLinha, 'CODAMZ', qryImpEti);

    If fUsaRotinaWMS Then
    Begin
      pSetaParam(strCodLse, arrCodLse, strCodLseRetorno, 'CODLSE', qryImpEti);

      If FindParam('RUAINI') <> Nil Then
        ParamByName('RUAINI').AsString := strRuaIni;

      If FindParam('RUAFIN') <> Nil Then
        ParamByName('RUAFIN').AsString := strRuaFin;

      If FindParam('PREINI') <> Nil Then
        ParamByName('PREINI').AsString := strPredioIni;

      If FindParam('PREFIN') <> Nil Then
        ParamByName('PREFIN').AsString := strPredioFin;

      If FindParam('ANDINI') <> Nil Then
        ParamByName('ANDINI').AsString := strAndarIni;

      If FindParam('ANDFIN') <> Nil Then
        ParamByName('ANDFIN').AsString := strAndarFin;

      If FindParam('APTINI') <> Nil Then
        ParamByName('APTINI').AsString := strApartamentoIni;

      If FindParam('APTFIN') <> Nil Then
        ParamByName('APTFIN').AsString := strApartamentoFin;

    End;

    If Not fEmptyStr(fTiraCaracEspeciais(strPrecoDtaIni)) Then
    Begin
      If FindParam('PRDTIN') <> Nil Then
        ParamByName('PRDTIN').AsDate := StrToDate(strPrecoDtaIni);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(strPrecoDtaFin)) Then
    Begin
      If FindParam('PRDTFN') <> Nil Then
        ParamByName('PRDTFN').AsDate := StrToDate(strPrecoDtaFin);
    End;

  End;
End;

Function TfrmImpEtiquetas.fSetFiltraItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni,
  strDesFin, strDesIte, strDesSim, strRefere, strCodMar, strCodPro, strCodDep: String; blnCodBar: Boolean;
  strCodFor, strLinGru, strPrdGru, strSitPro: String;
  intQtdEti: Integer; arrMarcaP: TConsultasArray;
  arrPromocP: TConsultasArray; arrCodDepP: TConsultasArray; arrFornecP: TConsultasArray;
  arrGruposP: TConsultasArray; arrCodAmzP: TConsultasArray;
  arrPrdGruP: TConsultasArray; arrSitProP: TConsultasArray;
  strIteEmb: String; blnFiltra: Boolean = True;
  strLocFis: String = ''; strLocIni: String = ''; strLocFin: String = '';
  strCodAmz: String = ''; strLocIniSup: String = '';
  strLocFinSup: String = ''; blnFilPromoc: boolean = False;
  strRuaIni: String = ''; strRuaFin: String = ''; strPredioIni: String = '';
  strPredioFin: String = ''; strAndarIni: String = ''; strAndarFin: String = '';
  strApartamentoIni: String = ''; strApartamentoFin: String = ''; strCodLse : String = '';
  tpAltPreEti : TTipoAltPreEti = tpTodos; strIteLot : String = 'T'; strPrecoDtaIni: String = ''; strPrecoDtaFin: String = '' ): Boolean;
Begin
  Result := True;

  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSQLFiltroIte(Not fEmptyDate(strDtaIni), (blnFilPromoc And Not fEmptyDate(strDtaIni)), Not fEmptyStr(fTiraCaracEspeciais(strHraIni,True,True,True,True)),tpAltPreEti, strPreTab));
      SQL.Add(fGetFiltrosItens(strDesIni, strDesFin, strDesIte, strDesSim, strRefere, strCodMar, strCodPro, strCodDep, blnCodBar,
        strCodFor, strLinGru, strPrdGru, strSitPro, arrMarcaP, arrPromocP, arrCodDepP, arrFornecP, arrGruposP, arrCodAmzP, arrPrdGruP, arrSitProP, strIteEmb,
        blnFiltra, strLocFis, strLocIni, strLocFin, strCodAmz, strLocIniSup,
        strLocFinSup, (blnFilPromoc And Not fEmptyDate(strDtaIni)),
        strRuaIni, strRuaFin, strPredioIni, strPredioFin, strAndarIni, strAndarFin,
        strApartamentoIni, strApartamentoFin, strCodLse, strIteLot));

      //Fecha o parantes aberto em fRetornaSQLFiltroIte
      SQL.Add('GROUP BY CADITE.ITE_CODITE)');

      pSetParamsItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin, strDesIte, strDesSim,
        strRefere, strCodMar, strCodPro, strCodDep, strCodFor, strLinGru, strPrdGru, strSitPro, arrMarcaP, arrPromocP,
        arrCodDepP, arrFornecP, arrGruposP, arrCodAmzP, arrPrdGruP, arrSitProP, blnFiltra, strLocFis, strLocIni,
        strLocFin, strCodAmz, strLocIniSup, strLocFinSup, strRuaIni, strRuaFin, strPredioIni,
        strPredioFin, strAndarIni, strAndarFin, strApartamentoIni, strApartamentoFin, strCodLse, strPrecoDtaIni, strPrecoDtaFin);

      If (intQtdEti > 0) Then
        SQL.Text := AnsiReplaceStr(SQL.Text, ':ITE_QTDETI', IntToStr(intQtdEti))
      Else
        SQL.Text := AnsiReplaceStr(SQL.Text, ':ITE_QTDETI', ' NULL ');

      If (Not fEmptyStr(strCodAmz)) Then
        SQL.Text := AnsiReplaceStr(SQL.Text, ':ITE_AMZETI',
          QuotedStr(strCodAmz))
      Else
        SQL.Text := AnsiReplaceStr(SQL.Text, ':ITE_AMZETI', ' NULL ');

      ExecSQL;

    End;

  Except
    On E: Exception do
    Begin
      If Pos('Argument out of range', E.Message) <= 0 Then
        pMensagensErro(E.Message, '[frmImpEtiquetas.pDigQuantidade]');
      Result := False;
    End;
  End;
End;

Function TfrmImpEtiquetas.fFiltraItens: Boolean;
Var
  strDtaIni: String;
  strDtaFin: String;
  strHraIni: String;
  strHraFin: String;
  strDesIni: String;
  strDesFin: String;
  strRefere: String;
  strLocFis: String;
  strLocIni: String;
  strLocFin: String;
  strCodMar: String;
  strCodFor: String;
  strLinGru: String;
  intQtdEti: Integer;
  tpAltPreEti : TTipoAltPreEti;
  strLocIniSup: String;
  strLocFinSup: String;
  strCodPro   : String;
  strDesIte   : String;
  strDesSim   : String;
  strCodDep   : String;
  strIteEmb   : String;
  strIteLot   : String;
  strPrdGru   : String;
  strSitPro   : String;

  strRuaIni: String;
  strRuaFin: String;
  strPredioIni: String;
  strPredioFin: String;
  strAndarIni: String;
  strAndarFin: String;
  strApartamentoIni: String;
  strApartamentoFin: String;
  strCodLse: String;


  fltProPreCus: Double;
  fltProPreVen: Double;
  fltProComVar: Double;
  fltProComAta: Double;
  fltProComDis: Double;
  fltQtdDis: Double;
  fltDesF07: Double;
  blnParticiona: Boolean;
  blnPromo: Boolean;
  blnProTmp: Boolean;
  blnCodBar: Boolean;
  strComPro: String;
  strCodPromocao: String;
  strSQL: String;
  frmFiltroEtiItens : TfrmFiltroEtiItens;

  intTabPre: integer;

  strPrecoDtaIni: String;
  strPrecoDtaFin: String;

Begin

  blnProTmp := False;
  blnCodBar := False;
  blnMosFil := False;
  blnPromoc := False;
  intQtdEti := 0;
  tpAltPreEti := tpTodos;
  strPreTab := '';

  Try
    pCriarFormularios(TfrmFiltroEtiItens, frmFiltroEtiItens);
    frmFiltroEtiItens.ShowModal;

    strDtaIni := frmFiltroEtiItens.strDtaIni;
    strDtaFin := frmFiltroEtiItens.strDtaFin;
    strDtaPro := frmFiltroEtiItens.strDtaPro;
    strHraIni := frmFiltroEtiItens.strHraIni;
    strHraFin := frmFiltroEtiItens.strHraFin;

    strDesIni := frmFiltroEtiItens.strDesIni;
    strDesIte := frmFiltroEtiItens.strDesIte;
    strDesFin := frmFiltroEtiItens.strDesFin;
    strDesSim := frmFiltroEtiItens.strDesSim;
    strRefere := frmFiltroEtiItens.strRefere;
    strLocFis := frmFiltroEtiItens.strLocFis;
    strLocIni := frmFiltroEtiItens.strLocIni;
    strLocFin := frmFiltroEtiItens.strLocFin;
    strCodMar := frmFiltroEtiItens.strCodMar;
    strCodPro := frmFiltroEtiItens.strCodPro;
    strCodDep := frmFiltroEtiItens.strCodDep;
    strPrdGru := frmFiltroEtiItens.strPrdGru;
    strSitPro := frmFiltroEtiItens.strSitPro;
    strCodFor := frmFiltroEtiItens.strCodFor;
    strLinGru := frmFiltroEtiItens.strLinGru;
    intQtdEti := frmFiltroEtiItens.intQtdEti;
    strIteEmb := frmFiltroEtiItens.strIteEmb;
    strIteLot := frmFiltroEtiItens.strIteLot;
    blnProTmp := frmFiltroEtiItens.chkPromoc.Checked;
    blnCodBar := frmFiltroEtiItens.chkCodBar.Checked;
    blnMosFil := frmFiltroEtiItens.chkMosFil.Checked;
    blnImpEst := frmFiltroEtiItens.chkImpEst.Checked;
    blnSalMin := frmFiltroEtiItens.chkSaldoMinimo.Checked;
    blnItensDivergentes := frmFiltroEtiItens.chkItensDivergentes.Checked;

    strCodAmz := frmFiltroEtiItens.strCodAmz;
    strLocIniSup := frmFiltroEtiItens.strLocIniSup;
    strLocFinSup := frmFiltroEtiItens.strLocFinSup;
    strCodEmpAlt := frmFiltroEtiItens.strCodEmpAlt;
    arrCodEmp    := frmFiltroEtiItens.arrCodEmp;
    tpAltPreEti  := frmFiltroEtiItens.tpAltPreEti;
    strCodEmpEtiEleAlt := frmFiltroEtiItens.strCodEmpEtiEleAlt;
    arrCodEmpEtiEle    := frmFiltroEtiItens.arrCodEmpEtiEle;

    strCodLse         := frmFiltroEtiItens.edtCodLse.Text;
    strRuaIni         := frmFiltroEtiItens.edtRuaIni.Text;
    strRuaFin         := frmFiltroEtiItens.edtRuaFin.Text;
    strPredioIni      := frmFiltroEtiItens.edtPredioIni.Text;
    strPredioFin      := frmFiltroEtiItens.edtPredioFin.Text;
    strAndarIni       := frmFiltroEtiItens.edtAndarIni.Text;
    strAndarFin       := frmFiltroEtiItens.edtAndarFin.Text;
    strApartamentoIni := frmFiltroEtiItens.edtApartamentoIni.Text;
    strApartamentoFin := frmFiltroEtiItens.edtApartamentoFin.Text;

    intEstMin         := frmFiltroEtiItens.rdgEstMin.ItemIndex;
    intEstMax         := frmFiltroEtiItens.rdgEstMax.ItemIndex;
    intEstFis         := frmFiltroEtiItens.rdgEstFis.ItemIndex;
    intExibeEstoque   := frmFiltroEtiItens.rdgExibirEstoque.ItemIndex;
    blnSalAmz         := frmFiltroEtiItens.chkSalArm.Checked;

    strPreTab := 'NNNNNNN';
    for intTabPre := 0 to frmFiltroEtiItens.clbPreTab.Count-1 do
    begin
      if frmFiltroEtiItens.clbPreTab.Checked[intTabPre] then
      begin
        strPretab := Copy(strPretab,1, StrToInt(frmFiltroEtiItens.clbPreTab.Items[intTabPre])-1)+
                          'S'+
                          Copy(strPretab, StrToInt(frmFiltroEtiItens.clbPreTab.Items[intTabPre]), length(strPreTab)-StrToInt(frmFiltroEtiItens.clbPreTab.Items[intTabPre]));
      end;
    end;

    strPrecoDtaIni := frmFiltroEtiItens.strPrecoDtaIni;
    strPrecoDtaFin := frmFiltroEtiItens.strPrecoDtaFin;

    pCopiaConsultaArray(frmFiltroEtiItens.arrPrdGru, Self.arrPrdGru);
    pCopiaConsultaArray(frmFiltroEtiItens.arrSitPro, Self.arrSitPro);
    pCopiaConsultaArray(frmFiltroEtiItens.arrMarca, Self.arrMarca);
    pCopiaConsultaArray(frmFiltroEtiItens.arrFornec, Self.arrFornec);
    pCopiaConsultaArray(frmFiltroEtiItens.arrGrupos, Self.arrGrupos);
    pCopiaConsultaArray(frmFiltroEtiItens.arrCodAmz, Self.arrCodAmz);
    pCopiaConsultaArray(frmFiltroEtiItens.arrCodLse, Self.arrCodLse);
    pCopiaConsultaArray(frmFiltroEtiItens.arrPromoc, Self.arrPromoc);
    pCopiaConsultaArray(frmFiltroEtiItens.arrCodDep, Self.arrCodDep);

    Result := frmFiltroEtiItens.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.fFiltraItens]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiItens);

  { ***************************************** }
  { * SE CANCELAR, SAI                      * }
  { **************************************MV* }
  If Not Result Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;
    pnlInfo.Caption := 'Aguarde...';
    stlPromoc.Clear;
    cdsPromoc.EmptyDataSet;
    cdsArmaze.EmptyDataSet;
    pHabilitaTela(False);
    pDesmarcarTodos(0, True);


    //Insere os itens na iteeti
    fSetFiltraItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
      strCodMar, strCodPro, strCodDep, blnCodBar, strCodFor, strLinGru, strPrdGru, strSitPro, intQtdEti, arrMarca, arrPromoc,
      arrCodDep, arrFornec, arrGrupos, arrCodAmz, arrPrdGru, arrSitPro, strIteEmb, (not blnProTmp), strLocFis, strLocIni, strLocFin,
      strCodAmz, strLocIniSup, strLocFinSup, blnProTmp,
      strRuaIni, strRuaFin, strPredioIni, strPredioFin, strAndarIni, strAndarFin,
      strApartamentoIni, strApartamentoFin, strCodLse, tpAltPreEti, strIteLot, strPrecoDtaIni, strPrecoDtaFin);

    strSQL := fRetornaSQLIte(Not fEmptyDate(strDtaIni), (blnProTmp And Not fEmptyDate(strDtaIni)), Not fEmptyStr(fTiraCaracEspeciais(strHraIni,True,True,True,True)), False,tpAltPreEti, True, strPreTab);

    If blnMosFil Then
      strSQL := strSQL + fGetFiltrosItens(strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
        strCodMar, strCodPro, strCodDep, blnCodBar, strCodFor, strLinGru, strPrdGru, strSitPro, arrMarca, ArrPromoc,
        arrCodDep, arrFornec, arrGrupos, arrCodAmz, arrPrdGru, arrSitPro, strIteEmb, True, strLocFis, strLocIni, strLocFin, strCodAmz,
        strLocIniSup, strLocFinSup, (blnProTmp And Not fEmptyDate(strDtaIni)),
        strRuaIni, strRuaFin, strPredioIni, strPredioFin, strAndarIni, strAndarFin,
        strApartamentoIni, strApartamentoFin, strCodLse, strIteLot);

    strSQL := strSQL + '  ORDER BY ' + fOrderByItens(Not fEmptyDate(strDtaIni));

    With qryImpEti Do
    Begin
      DisableControls;

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALBUS').AsString := '%';

      Case rdgStatus.ItemIndex Of
        0: ParamByName('ITEATI').AsString := 'S';
        1: ParamByName('ITEATI').AsString := 'N';
      End;

      If blnMosFil Then
        pSetParamsItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin, strDesIte, strDesSim,
          strRefere, strCodMar, strCodPro, strCodDep, strCodFor, strLinGru,strPrdGru, strSitPro, arrMarca, arrPromoc, arrCodDep,
          arrFornec, arrGrupos, arrCodAmz,arrPrdGru, arrSitPro, True, strLocFis, strLocIni, strLocFin, strCodAmz,
          strLocIniSup, strLocFinSup, strRuaIni, strRuaFin, strPredioIni,
          strPredioFin, strAndarIni, strAndarFin, strApartamentoIni, strApartamentoFin, strCodLse, strPrecoDtaIni, strPrecoDtaFin);
      Open;

      pFiltrarItensEtiquetasEletronicas(qryImpEti);

      (FieldByName('ITE_PREVE' + fPrimeiraTabPreco) As TFloatField).DisplayFormat := '#,##0.00';
    End;

    With qryImpEti Do
    Begin

      First;

      { ***************************************** }
      { * VERIFICA ITEM EM PROMOÇÃO             * }
      { **************************************PZ* }
      If (blnProTmp) Then
      Begin
        pgbEtique.properties.Max := RecordCount;
        pnlInfo.Caption := 'Aguarde...Filtrando produtos em promoção!';

        If fEmptyStr(fTiraCaracEspeciais(strDtaPro)) Then
          strDtaPro := DateToStr(fNow);
        While Not Eof Do
        Begin
          If (fRetornaPrecosPromocao(FieldByName('ITE_CODITE').AsString, '',
            strToDate(strDtaPro), 1, 0, 0, 0, fltProPreCus, fltProPreVen, fltProComVar,
            fltProComAta, fltProComDis, fltQtdDis, fltDesF07, strComPro, strCodPromocao, blnParticiona, blnPromo,
            '', '')) Then
          Begin
            stlPromoc.Add(FieldByName('ITE_CODITE').AsString);

            { ********************************************************** }
            { * ARMAZENA O VALOR DA PROMOÇÃO PARA MOSTRAR NA IMPRESSÃO * }
            { * CASO TENHA ESCOLHIDO A TABELA PROMOCIONAL.             * }
            { *******************************************************PZ* }
            cdsPromoc.Insert;
            cdsPromoc.FieldByName('ITE_CODITE').AsString :=
              FieldByName('ITE_CODITE').AsString;
            cdsPromoc.FieldByName('ITE_PREPRO').AsFloat := fltProPreVen;
            cdsPromoc.Post;
          End;

          pAlteraArmazem(strCodAmz, FieldByName('ITE_CODITE').AsString);

          pgbEtique.Position := RecNo;
          Application.ProcessMessages;

          Next;
        End;

        If (stlPromoc.Count > 0) Then
        begin
          //Deleta os itens ja existente e que estão na lista de promocao
          qryImpEti.SQL.Clear;
          qryImpEti.SQL.Add('DELETE FROM ITEETI ');
          qryImpEti.SQL.Add('WHERE ETI_CODITE NOT IN (' + fCommaText(stlPromoc, True) + ') ');
          qryImpEti.SQL.Add('  AND ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado));
          qryImpEti.ExecSQL;

          fSetFiltraItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin, strDesIte, strDesSim,
            strRefere, strCodMar, strCodPro, strCodDep, blnCodBar, strCodFor, strLinGru, strPrdGru, strSitPro, intQtdEti, arrMarca,
            arrPromoc, arrCodDep, arrFornec, arrGrupos, arrCodAmz, arrPrdGru, arrSitPro, strIteEmb, True, strLocFis, strLocIni,
            strLocFin, strCodAmz, strLocIniSup, strLocFinSup, (blnProTmp And Not fEmptyDate(strDtaIni)),
            strRuaIni, strRuaFin, strPredioIni, strPredioFin, strAndarIni, strAndarFin,
            strApartamentoIni, strApartamentoFin, strCodLse, tpAltPreEti, strIteLot, strPrecoDtaIni, strPrecoDtaFin);

        End;
        blnPromoc := blnProTmp;

        strSQL := fRetornaSQLIte(Not fEmptyDate(strDtaIni), (blnProTmp And Not fEmptyDate(strDtaIni)), Not fEmptyStr(fTiraCaracEspeciais(strHraIni,True,True,True,True)), False, tpAltPreEti, True);

        If blnMosFil Then

          strSQL := strSQL + fGetFiltrosItens(strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
            strCodMar, strCodPro, strCodDep, blnCodBar, strCodFor, strLinGru, strPrdGru, strSitPro, arrMarca, arrPromoc,
            arrCodDep, arrFornec, arrGrupos, arrCodAmz, arrPrdGru, arrSitPro, strIteEmb, True, strLocFis, strLocIni, strLocFin,
            strCodAmz, strLocIniSup, strLocFinSup, (blnProTmp And Not fEmptyDate(strDtaIni)),
            strRuaIni, strRuaFin, strPredioIni, strPredioFin, strAndarIni, strAndarFin,
            strApartamentoIni, strApartamentoFin, strCodLse, strIteLot);

        strSQL := strSQL + '  ORDER BY ' +
          fOrderByItens(Not fEmptyDate(strDtaIni));

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('VALBUS').AsString := '%';

        Case rdgStatus.ItemIndex Of
          0: ParamByName('ITEATI').AsString := 'S';
          1: ParamByName('ITEATI').AsString := 'N';
        End;

        If blnMosFil Then

          pSetParamsItens(strDtaIni, strDtaFin, strHraIni, strHraFin, strDesIni, strDesFin, strDesIte, strDesSim, strRefere,
            strCodMar, strCodPro, strCodDep, strCodFor, strLinGru, strPrdGru, strSitPro, arrMarca, arrPromoc, arrCodDep,
            arrFornec, arrGrupos, arrCodAmz, arrPrdGru, arrSitPro, True, strLocFis, strLocIni, strLocFin, strCodAmz,
            strLocIniSup, strLocFinSup, strRuaIni, strRuaFin, strPredioIni,
            strPredioFin, strAndarIni, strAndarFin, strApartamentoIni, strApartamentoFin, strCodLse, strPrecoDtaIni, strPrecoDtaFin);

        Open;

        pFiltrarItensEtiquetasEletronicas(qryImpEti);

      End;
{      While Not Eof Do
      Begin
        pAlteraArmazem(strCodAmz, FieldByName('ITE_CODITE').AsString);
        pAlteraQtdEti(intQtdEti);

        pgbEtique.Position := RecNo;
        Application.ProcessMessages;

        Next;
      End;}

      EnableControls;
      First;
    End;

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
    pgbEtique.Position := 0;
    pHabilitaTela(True);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ Filtro de Etiquetas de Produtos ]');
    End;
  End;

End;

Function TfrmImpEtiquetas.fRetornaSQLFiltroDiv: String;
Var
  strUpdDiv: String;
Begin
  strUpdDiv := '';
  strUpdDiv := strUpdDiv + 'UPDATE                     ';
  strUpdDiv := strUpdDiv + '  CADDIV, CADCID           ';
  strUpdDiv := strUpdDiv + 'SET                        ';
  strUpdDiv := strUpdDiv + '  DIV_QTDETI = :DIV_QTDETI ';
  strUpdDiv := strUpdDiv + 'WHERE                      ';
  strUpdDiv := strUpdDiv + '  DIV_CODCID = CID_CODCID  ';

  If blnMovDet Then
    strUpdDiv := strUpdDiv + ' AND LOCATE(DIV_CODDIV, "' + strDivVen + '")  ';

  Result := strUpdDiv;
End;

Function TfrmImpEtiquetas.fGetFiltrosDiversos(strNomIni, strNomFin, strCodCid,
  strCodAti, strBairro, strEstado, strAniIni, strAniFin: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strNomIni) Then
  Begin
    strSQL := strSQL +
      ' AND LEFT(DIV_NOMDIV, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';
  End;

  If Not fEmptyStr(strCodCid) Then
  Begin
    strSQL := strSQL + ' AND DIV_CODCID = :CODCID ';
  End;

  If Not fEmptyStr(strCodAti) Then
  Begin
    strSQL := strSQL + ' AND DIV_CODATI = :CODATI ';
  End;

  If Not fEmptyStr(strBairro) Then
  Begin
    strSQL := strSQL + ' AND DIV_BAIRRO = :BAIRRO ';
  End;

  If Not fEmptyStr(strEstado) Then
  Begin
    strSQL := strSQL + ' AND CID_ESTADO = :ESTADO ';
  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(strAniIni))) Then
  Begin
    strSQL := strSQL +
      '  AND (DATE_FORMAT(DIV_DTANAS, "%m/%d") BETWEEN :ANIINI AND :ANIFIN) ';
  End;

  Result := strSQL;
End;

Procedure TfrmImpEtiquetas.pSetParamsDiversos(strNomIni, strNomFin, strCodCid,
  strCodAti, strBairro, strEstado, strAniIni, strAniFin: String);
Begin
  With qryImpEti Do
  Begin

    If Not fEmptyStr(strNomIni) Then
    Begin
      If Length(strNomIni) > Length(strNomFin) Then
        ParamByName('MAIOR').AsString := strNomIni
      Else
        ParamByName('MAIOR').AsString := strNomFin;

      ParamByName('NOMINI').AsString := strNomIni;
      ParamByName('NOMFIN').AsString := strNomFin;
    End;

    If Not fEmptyStr(strCodCid) Then
    Begin
      ParamByName('CODCID').AsString := strCodCid;
    End;

    If Not fEmptyStr(strCodAti) Then
    Begin
      ParamByName('CODATI').AsString := strCodAti;
    End;

    If Not fEmptyStr(strBairro) Then
    Begin
      ParamByName('BAIRRO').AsString := strBairro;
    End;

    If Not fEmptyStr(strEstado) Then
    Begin
      ParamByName('ESTADO').AsString := strEstado;
    End;

    If (Not fEmptyStr(fTiraCaracEspeciais(strAniIni))) Then
    Begin
      ParamByName('ANIINI').AsString := RightStr(strAniIni, 2) + '/' +
        LeftStr(strAniIni, 2);
      ParamByName('ANIFIN').AsString := RightStr(strAniFin, 2) + '/' +
        LeftStr(strAniFin, 2);
    End;

  End;
End;

Function TfrmImpEtiquetas.fSetFiltraDiversos(strNomIni: String;
  strNomFin: String; strCodCid: String; strCodAti: String; strBairro: String;
  strEstado: String; strAniIni: String; strAniFin: String;
  intQtdEti: Integer): Boolean;
Begin
  Result := True;
  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSQLFiltroDiv + fGetFiltrosDiversos(strNomIni, strNomFin,
        strCodCid, strCodAti, strBairro, strEstado, strAniIni, strAniFin));

      pSetParamsDiversos(strNomIni, strNomFin, strCodCid, strCodAti, strBairro,
        strEstado, strAniIni, strAniFin);

      ParamByName('DIV_QTDETI').AsInteger := intQtdEti;

      ExecSQL;

    End;
  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fFiltraDiversos: Boolean;
Var
  strNomIni: String;
  strNomFin: String;
  strCodCid: String;
  strCodAti: String;
  strBairro: String;
  strEstado: String;
  intQtdEti: Integer;
  blnMosFil: Boolean;
  strAniIni: String;
  strAniFin: String;
  frmFiltroEtiDiversos : TfrmFiltroEtiDiversos;
  strSQL: String;
Begin

  blnMosFil := False;
  intQtdEti := 0;

  Try
    pCriarFormularios(TfrmFiltroEtiDiversos, frmFiltroEtiDiversos);
    frmFiltroEtiDiversos.ShowModal;

    strNomIni := frmFiltroEtiDiversos.strNomIni;
    strNomFin := frmFiltroEtiDiversos.strNomFin;
    strCodCid := frmFiltroEtiDiversos.strCodCid;
    strCodAti := frmFiltroEtiDiversos.strCodAti;
    strBairro := frmFiltroEtiDiversos.strBairro;
    strEstado := frmFiltroEtiDiversos.strEstado;
    intQtdEti := frmFiltroEtiDiversos.intQtdEti;
    blnMosFil := frmFiltroEtiDiversos.chkMosFil.Checked;
    strAniIni := frmFiltroEtiDiversos.strAniIni;
    strAniFin := frmFiltroEtiDiversos.strAniFin;
    strDtaIni := frmFiltroEtiDiversos.strDtaIni;
    strDtaFin := frmFiltroEtiDiversos.strDtaFin;

    If fEmptyStr(fTiraCaracEspeciais(strDtaIni)) Then
      blnMovDet := False
    Else
    Begin
      blnMovDet := True;
      strDivVen := fRetornaDiversosComVenda;
    End;

    Result := frmFiltroEtiDiversos.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.fFiltraDiversos]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiDiversos);

  { ***************************************** }
  { * SE CANCELAR, SAI                      * }
  { **************************************MV* }
  If Not Result Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;

    pnlInfo.Caption := 'Aguarde...';

    fSetFiltraDiversos(strNomIni, strNomFin, strCodCid, strCodAti, strBairro,
      strEstado, strAniIni, strAniFin, intQtdEti);

    strSQL := fRetornaSQLDiv;

    If blnMosFil Then
      strSQL := strSQL + fGetFiltrosDiversos(strNomIni, strNomFin, strCodCid,
        strCodAti, strBairro, strEstado, strAniIni, strAniFin);

    strSQL := strSQL + ' ORDER BY ' + stlCampos[intIndBusca];

    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALBUS').AsString := '%';

      If blnMosFil Then
      Begin

        pSetParamsDiversos(strNomIni, strNomFin, strCodCid, strCodAti,
          strBairro, strEstado, strAniIni, strAniFin);

      End;

      Open;

    End;

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ Filtro de Etiquetas de Diversos ]');
    End;
  End;

End;

Function TfrmImpEtiquetas.fRetornaSQLFiltroFor: String;
Var
  strUpdFor: String;
Begin
  strUpdFor := '';
  strUpdFor := strUpdFor + 'UPDATE                     ';
  strUpdFor := strUpdFor + '  CADFOR, CADCID           ';
  strUpdFor := strUpdFor + 'SET                        ';
  strUpdFor := strUpdFor + '  FOR_QTDETI = :FOR_QTDETI ';
  strUpdFor := strUpdFor + 'WHERE                      ';
  strUpdFor := strUpdFor + '  FOR_CODCID = CID_CODCID  ';
  Result := strUpdFor;
End;

Function TfrmImpEtiquetas.fGetFiltrosFornecedores(strNomIni, strNomFin,
  strCodAti, strCodCid, strBairro, strEstado, strRevist: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strNomIni) Then
  Begin
    strSQL := strSQL +
      ' AND LEFT(FOR_NOMFOR, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';
  End;

  If Not fEmptyStr(strCodAti) Then
  Begin
    strSQL := strSQL + ' AND FOR_CODATI = :CODATI ';
  End;

  If Not fEmptyStr(strCodCid) Then
  Begin
    strSQL := strSQL + ' AND FOR_CODCID = :CODCID ';
  End;

  If Not fEmptyStr(strBairro) Then
  Begin
    strSQL := strSQL + ' AND FOR_BAIRRO = :BAIRRO ';
  End;

  If Not fEmptyStr(strEstado) Then
  Begin
    strSQL := strSQL + ' AND CID_ESTADO = :ESTADO ';
  End;

  If Not fEmptyStr(strRevist) Then
  Begin
    strSQL := strSQL + ' AND FOR_REVIST = :REVIST ';
  End;

  { ************************************************************************* }
  { * ATENÇÃO! QUANDO FIZER ALGUMA ALTERAÇÃO NOS FILTROS DO FORNECEDOR NÃO  * }
  { * ESQUECER DE ALTERAR OS FILTROS DA PROCEDURE "pQtdeEtiquetaFornecedor" * }
  { * POIS ELA MOSTRA A QUANTIDADES DE ETIQUETAS QUE SERÃO IMPRESSAS.       * }
  { **********************************************************************PZ* }

  Result := strSQL;
End;

Procedure TfrmImpEtiquetas.pSetParamsFornecedores(strNomIni, strNomFin,
  strCodAti, strCodCid, strBairro, strEstado, strRevist: String);
Begin
  With qryImpEti Do
  Begin

    If Not fEmptyStr(strNomIni) Then
    Begin
      If Length(strNomIni) > Length(strNomFin) Then
        ParamByName('MAIOR').AsString := strNomIni
      Else
        ParamByName('MAIOR').AsString := strNomFin;

      ParamByName('NOMINI').AsString := strNomIni;
      ParamByName('NOMFIN').AsString := strNomFin;
    End;

    If Not fEmptyStr(strCodAti) Then
    Begin
      ParamByName('CODATI').AsString := strCodAti;
    End;

    If Not fEmptyStr(strCodCid) Then
    Begin
      ParamByName('CODCID').AsString := strCodCid;
    End;

    If Not fEmptyStr(strBairro) Then
    Begin
      ParamByName('BAIRRO').AsString := strBairro;
    End;

    If Not fEmptyStr(strEstado) Then
    Begin
      ParamByName('ESTADO').AsString := strEstado;
    End;

    If Not fEmptyStr(strRevist) Then
    Begin
      ParamByName('REVIST').AsString := strRevist;
    End;

  End;
End;

Function TfrmImpEtiquetas.fSetFiltraFornecedores(strNomIni, strNomFin,
  strCodAti, strCodCid, strBairro, strEstado, strRevist: String;
  intQtdEti: Integer): Boolean;
Begin
  Result := True;

  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSQLFiltroFor + fGetFiltrosFornecedores(strNomIni,
        strNomFin, strCodAti, strCodCid, strBairro, strEstado, strRevist));

      pSetParamsFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
        strBairro, strEstado, strRevist);

      ParamByName('FOR_QTDETI').AsInteger := intQtdEti;

      ExecSQL;

    End;
  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fFiltraFornecedores: Boolean;
Var
  strNomIni: String;
  strNomFin: String;
  strCodAti: String;
  strCodCid: String;
  strBairro: String;
  strEstado: String;
  strRevist: String;
  intQtdEti: Integer;
  blnMosFil: Boolean;
  frmFiltroEtiFornecedores : TfrmFiltroEtiFornecedores;
  strSQL: String;
  strFil: String;
Begin
  blnMosFil := False;
  intQtdEti := 0;

  Try
    pCriarFormularios(TfrmFiltroEtiFornecedores, frmFiltroEtiFornecedores);
    frmFiltroEtiFornecedores.ShowModal;

    strNomIni := frmFiltroEtiFornecedores.strNomIni;
    strNomFin := frmFiltroEtiFornecedores.strNomFin;
    strCodAti := frmFiltroEtiFornecedores.strCodAti;
    strCodCid := frmFiltroEtiFornecedores.strCodCid;
    strBairro := frmFiltroEtiFornecedores.strBairro;
    strEstado := frmFiltroEtiFornecedores.strEstado;
    strRevist := frmFiltroEtiFornecedores.strRevist;
    intQtdEti := frmFiltroEtiFornecedores.intQtdEti;
    blnMosFil := frmFiltroEtiFornecedores.chkMosFil.Checked;

    Result := frmFiltroEtiFornecedores.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.fFiltraFornecedores]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiFornecedores);

  { ***************************************** }
  { * SE CANCELAR, SAI                      * }
  { **************************************MV* }
  If Not Result Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;

    pnlInfo.Caption := 'Aguarde...';

    fSetFiltraFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
      strBairro, strEstado, strRevist, intQtdEti);

    strSQL := fRetornaSQLFor;

    If blnMosFil Then
      strFil := fGetFiltrosFornecedores(strNomIni, strNomFin, strCodAti,
        strCodCid, strBairro, strEstado, strRevist);

    strSQL := strSQL + strFil + ' ORDER BY ' + stlCampos[intIndBusca];

    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALBUS').AsString := '%';

      If blnMosFil Then
      Begin
        pSetParamsFornecedores(strNomIni, strNomFin, strCodAti, strCodCid,
          strBairro, strEstado, strRevist);
      End;

      strSQLAux := strSQLAux + ' ' + strFil;

      pQtdeEtiquetaFornecedor(strSQLAux, ParamByName('VALBUS').AsString,
        strNomIni, strNomFin, strCodAti, strCodCid, strBairro, strEstado,
        strRevist);

      Open;

      Screen.Cursor := crDefault;

    End;

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ Filtro de Etiquetas de Fornecedores ]');
    End;
  End;
End;

Function TfrmImpEtiquetas.fGetFiltrosVendedor(strNomIni, strNomFin, strCodCid,
  strBairro, strEstado: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strNomIni) Then
  Begin
    strSQL := strSQL +
      ' AND LEFT(OPE_NOMOPE, LENGTH(:MAIOR)) BETWEEN :NOMINI AND :NOMFIN ';
  End;

  If Not fEmptyStr(strCodCid) Then
  Begin
    strSQL := strSQL + ' AND OPE_CODCID = :CODCID ';
  End;

  If Not fEmptyStr(strBairro) Then
  Begin
    strSQL := strSQL + ' AND OPE_BAIRRO = :BAIRRO ';
  End;

  If Not fEmptyStr(strEstado) Then
  Begin
    strSQL := strSQL + ' AND CID_ESTADO = :ESTADO ';
  End;

  Result := strSQL;
End;

Procedure TfrmImpEtiquetas.pSetParamsVendedor(strNomIni, strNomFin, strCodCid,
  strBairro, strEstado: String);
Begin
  With qryImpEti Do
  Begin

    If Not fEmptyStr(strNomIni) Then
    Begin
      If Length(strNomIni) > Length(strNomFin) Then
        ParamByName('MAIOR').AsString := strNomIni
      Else
        ParamByName('MAIOR').AsString := strNomFin;

      ParamByName('NOMINI').AsString := strNomIni;
      ParamByName('NOMFIN').AsString := strNomFin;
    End;

    If Not fEmptyStr(strCodCid) Then
    Begin
      ParamByName('CODCID').AsString := strCodCid;
    End;

    If Not fEmptyStr(strBairro) Then
    Begin
      ParamByName('BAIRRO').AsString := strBairro;
    End;

    If Not fEmptyStr(strEstado) Then
    Begin
      ParamByName('ESTADO').AsString := strEstado;
    End;

  End;
End;

Function TfrmImpEtiquetas.fRetornaSQLFiltroVen: String;
Var
  strUpdVen: String;
Begin
  strUpdVen := '';
  strUpdVen := strUpdVen + 'UPDATE                     ';
  strUpdVen := strUpdVen + '  CADOPE, CADCID           ';
  strUpdVen := strUpdVen + 'SET                        ';
  strUpdVen := strUpdVen + '  OPE_QTDETI = :OPE_QTDETI ';
  strUpdVen := strUpdVen + 'WHERE                      ';
  strUpdVen := strUpdVen + '  OPE_CODCID = CID_CODCID  ';

  Result := strUpdVen;

End;

Function TfrmImpEtiquetas.fSetFiltraVendedor(strNomIni: String;
  strNomFin: String; strCodCid: String; strBairro: String; strEstado: String;
  intQtdEti: Integer): Boolean;
Begin
  Result := True;

  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSQLFiltroVen + fGetFiltrosVendedor(strNomIni, strNomFin,
        strCodCid, strBairro, strEstado));

      pSetParamsVendedor(strNomIni, strNomFin, strCodCid, strBairro, strEstado);

      ParamByName('OPE_QTDETI').AsInteger := intQtdEti;

      ExecSQL;

    End;

  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fFiltraVendedor: Boolean;
Var
  strNomIni: String;
  strNomFin: String;
  strCodCid: String;
  strBairro: String;
  strEstado: String;
  intQtdEti: Integer;
  blnMosFil: Boolean;
  frmFiltroEtiDiversos : TfrmFiltroEtiDiversos;
  strSQL: String;
Begin
  blnMosFil := False;
  intQtdEti := 0;

  Try
    pCriarFormularios(TfrmFiltroEtiDiversos, frmFiltroEtiDiversos);
    frmFiltroEtiDiversos.ShowModal;

    strNomIni := frmFiltroEtiDiversos.strNomIni;
    strNomFin := frmFiltroEtiDiversos.strNomFin;
    strCodCid := frmFiltroEtiDiversos.strCodCid;
    strBairro := frmFiltroEtiDiversos.strBairro;
    strEstado := frmFiltroEtiDiversos.strEstado;
    intQtdEti := frmFiltroEtiDiversos.intQtdEti;
    blnMosFil := frmFiltroEtiDiversos.chkMosFil.Checked;

    Result := frmFiltroEtiDiversos.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.fFiltraVendedor]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiDiversos);

  { ***************************************** }
  { * SE CANCELAR, SAI                      * }
  { **************************************MV* }
  If Not Result Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;

    pnlInfo.Caption := 'Aguarde...';

    fSetFiltraVendedor(strNomIni, strNomFin, strCodCid, strBairro, strEstado,
      intQtdEti);

    strSQL := fRetornaSQLVen;

    If blnMosFil Then
      strSQL := strSQL + fGetFiltrosVendedor(strNomIni, strNomFin, strCodCid,
        strBairro, strEstado);

    strSQL := strSQL + ' ORDER BY ' + stlCampos[intIndBusca];

    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('VALBUS').AsString := '%';

      If blnMosFil Then
      Begin
        pSetParamsVendedor(strNomIni, strNomFin, strCodCid, strBairro,
          strEstado);
      End;

      Open;

    End;

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ Filtro de Etiquetas de Vendedores ]');
    End;
  End;
End;

Procedure TfrmImpEtiquetas.btnSairImpClick(Sender: TObject);
Begin
  Inherited;
  Close;
End;

procedure TfrmImpEtiquetas.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  pLimpaFiltros;
end;

Function TfrmImpEtiquetas.fRetornaClientesComVenda(fltVlrFat: Double): String;
Var
  strCli: String;
  qryGen: TUniQuery;
Begin
  strCli := '';
  strCli := strCli + 'SELECT ';
  strCli := strCli +
    '  DISTINCT CLI_CODCLI, SUM(DET_TOTITE - DET_DESESP) AS VLR_TOTAL ';
  strCli := strCli + 'FROM ';
  strCli := strCli + '  CADCLI ';
  strCli := strCli + '  JOIN MOVDET ON DET_CODCLI = CLI_CODCLI ';
  strCli := strCli + 'WHERE ';
  strCli := strCli + '  DET_PROEMB <> "S"                        AND ';
  strCli := strCli + '  DET_TIP_FC = "C"                         AND ';
  strCli := strCli + '  DET_CODEMP = :CODEMP                     AND ';
  strCli := strCli + cnsFiltroFFDVTR;
  strCli := strCli + '  DATE_FORMAT(DET_DTAENT, "%d/%m/%Y")  BETWEEN :DTAINI AND :DTAFIN AND ';
  strCli := strCli +
    '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    strCli := strCli + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' +
      CLAFIS_BR + ')) '
  Else
    strCli := strCli + ') ';

  strCli := strCli + ' GROUP BY CLI_CODCLI ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strCli);

  Result := ' SELECT DISTINCT CLI_CODCLI, VLR_TOTAL FROM (' + Result + ') TMP ';

  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(Result);
    ParamByName('DTAINI').AsDate := StrToDate(strDtaIni);
    ParamByName('DTAFIN').AsDate := StrToDate(strDtaFin);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := '';

    While Not Eof Do
    Begin
      If FieldByName('VLR_TOTAL').AsFloat >= fltVlrFat Then
        Result := Result + FieldByName('CLI_CODCLI').AsString + '_';
      Next;
    End;

  End;

  FreeAndNil(qryGen);
End;

function TfrmImpEtiquetas.fRetListaCodEmpEtiEle: String;
Var
  i: Integer;
Begin
  For i := 0 To High(arrCodEmpEtiEle) Do
    Result := Result + '_' + arrCodEmpEtiEle[i].strCodigo;
end;

function TfrmImpEtiquetas.fRetornaClientesComSemCompra(
  fltVlrFat: Double): String;
Var
  qryCli: TUniQuery;
Begin

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  DISTINCT CLI_CODCLI, CLI_VRUCOM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADCLI ';
  Result := Result + 'LEFT JOIN MOVDET ON DET_CODCLI = CLI_CODCLI ';
  Result := Result + '  WHERE (CLI_ULTCOM BETWEEN :COMINI AND :COMFIN) ';
  Result := Result + '    AND (DET_DTAENT NOT BETWEEN :NAOINI AND :NAOFIN) ';
  Result := Result + '    AND DET_DTAENT = CLI_ULTCOM ';
  Result := Result + '    AND DET_PROEMB <> "S" ';
  Result := Result + '    AND DET_TIP_FC = "C" ';
  Result := Result + '    AND ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    Result := Result + '   OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' + CLAFIS_BR + ')) '
  Else
    Result := Result + ') ';

  Result := ' SELECT DISTINCT CLI_CODCLI, CLI_VRUCOM FROM (' + Result +
    ') TMP ';

  qryCli := fCriaQuery(Self);

  With qryCli, SQL Do
  Begin
    Close;
    Clear;
    Add(Result);
    ParamByName('COMINI').AsDate := StrToDate(strComIni);
    ParamByName('COMFIN').AsDate := StrToDate(strComFin);
    ParamByName('NAOINI').AsDate := StrToDate(strNaoIni);
    ParamByName('NAOFIN').AsDate := StrToDate(strNaoFin);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    Open;
    Result := '';

    While Not Eof Do
    Begin
      If FieldByName('CLI_VRUCOM').AsFloat >= fltVlrFat Then
        Result := Result + FieldByName('CLI_CODCLI').AsString + '_';
      Next;
    End;

  End;

  FreeAndNil(qryCli);
End;

Function TfrmImpEtiquetas.fRetornaClientesComUltCompra
  (fltVlrFat: Double): String;
Var
  qryGen: TUniQuery;
Begin

  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  DISTINCT CLI_CODCLI, CLI_VRUCOM ';
  Result := Result + 'FROM ';
  Result := Result + '  CADCLI ';
  Result := Result + 'WHERE ';
  Result := Result + '  CLI_ULTCOM BETWEEN :DTAINI AND :DTAFIN ';

  Result := ' SELECT DISTINCT CLI_CODCLI, CLI_VRUCOM FROM (' + Result +
    ') TMP ';

  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(Result);
    ParamByName('DTAINI').AsDate := StrToDate(strDtaIni);
    ParamByName('DTAFIN').AsDate := StrToDate(strDtaFin);
    Open;
    Result := '';

    While Not Eof Do
    Begin
      If FieldByName('CLI_VRUCOM').AsFloat >= fltVlrFat Then
        Result := Result + FieldByName('CLI_CODCLI').AsString + '_';
      Next;
    End;

  End;

  FreeAndNil(qryGen);
End;

Function TfrmImpEtiquetas.fRetornaDiversosComVenda: String;
Var
  strDiv: String;
  qryGen: TUniQuery;
Begin
  strDiv := '';
  strDiv := strDiv + 'SELECT ';
  strDiv := strDiv + '  DISTINCT DIV_CODDIV ';
  strDiv := strDiv + 'FROM ';
  strDiv := strDiv + '  CADDIV ';
  strDiv := strDiv + '  JOIN MOVDET ON DET_CODDIV = DIV_CODDIV ';
  strDiv := strDiv + 'WHERE ';
  strDiv := strDiv + '  DET_PROEMB <> "S"                        AND ';
  strDiv := strDiv + '  DET_TIP_FC = "C"                         AND ';
  strDiv := strDiv + '  DET_CODEMP = :CODEMP                     AND ';
  strDiv := strDiv + cnsFiltroFFDVTR;
  strDiv := strDiv + '  DET_DTAENT BETWEEN :DTAINI AND :DTAFIN   AND ';
  strDiv := strDiv +
    '  ((LOCATE(DET_CLAFIS, :CLAFIS) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

  If fCfgSis('ENTBRF', varBoolean) Then
    strDiv := strDiv + ' OR (DET_ESPDOC = "BR") OR LOCATE(DET_CLAFIS,' +
      CLAFIS_BR + ')) '
  Else
    strDiv := strDiv + ') ';

  Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strDiv);

  Result := ' SELECT DISTINCT DIV_CODDIV FROM (' + Result + ') TMP ';

  qryGen := fCriaQuery(Self);

  With qryGen, SQL Do
  Begin
    Close;
    Clear;
    Add(Result);
    ParamByName('DTAINI').AsDate := StrToDate(strDtaIni);
    ParamByName('DTAFIN').AsDate := StrToDate(strDtaFin);
    ParamByName('CLAFIS').AsString := VS_strClaVen;
    ParamByName('CLADEV').AsString := VS_strClaDev;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
    Result := '';

    While Not Eof Do
    Begin
      Result := Result + FieldByName('DIV_CODDIV').AsString + '_';
      Next;
    End;

  End;

  FreeAndNil(qryGen);
End;

Function TfrmImpEtiquetas.fRetornaSQLCli: String;
Var
  strSQL: String;
Begin

  strSQLAux := '';

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  C.CLI_CODCLI, ';
  strSQL := strSQL + '  CLI_QTDETI, ';
  strSQL := strSQL + '  CLI_NOMCLI, ';
  strSQL := strSQL + '  CLI_CGCCPF, ';
  strSQL := strSQL + '  CLI_C_G_C_, ';
  strSQL := strSQL + '  CLI_STATUS, ';

  If blnEndCob Then
  Begin
    { ******************************************* }
    { * DADOS PARA COBRANÇA                     * }
    { ****************************************JB* }
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL,CONCAT(CLI_ENDERE, IF(IFNULL(CLI_ENDNUM, " ") = " "," ", CONCAT(", ", CLI_ENDNUM))), CLI_ENDCOB ) AS CLI_ENDERE, ';
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_BAIRRO, CLI_BAICOB) AS CLI_BAIRRO, ';
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_ENDCOM, "") AS CLI_ENDCOM, ';
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, CLI_C_E_P_, CLI_CEPCOB) AS CLI_C_E_P_, ';
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_NOMCID, D2.CID_NOMCID) AS CID_NOMCID, ';
    strSQL := strSQL +
      '  IF(CLI_ENDCOB = "" OR CLI_ENDCOB IS NULL, D1.CID_ESTADO, D2.CID_ESTADO) AS CID_ESTADO ';

  End
  Else
  Begin
    { ******************************************* }
    { * DADOS PARA FATURAMENTO                  * }
    { ****************************************JB* }
    strSQL := strSQL +
      '  CONCAT(CLI_ENDERE,IF(IFNULL(CLI_ENDNUM, "") = "", "", CONCAT(", ", CLI_ENDNUM))) AS CLI_ENDERE, ';
    strSQL := strSQL + '  CLI_ENDCOM, ';
    strSQL := strSQL + '  CLI_BAIRRO, ';
    strSQL := strSQL + '  CLI_C_E_P_, ';
    strSQL := strSQL + '  D1.CID_NOMCID AS CID_NOMCID, ';
    strSQL := strSQL + '  D1.CID_ESTADO AS CID_ESTADO  ';

  End;

  strSQLAux := strSQLAux + 'FROM ';
  strSQLAux := strSQLAux + '  CADCLI C ';
  strSQLAux := strSQLAux +
    '  JOIN CADCID          D1 ON CLI_CODCID    = D1.CID_CODCID ';
  strSQLAux := strSQLAux +
    '  LEFT JOIN CADCID     D2 ON CLI_CIDCOB    = D2.CID_CODCID ';
  strSQLAux := strSQLAux +
    '  LEFT JOIN CLI_INFCRE CC ON CC.CLI_CODCLI = C.CLI_CODCLI  ';
  strSQLAux := strSQLAux + 'WHERE ';
  strSQLAux := strSQLAux + '  TRUE AND ';

  If (stlCampos[intIndBusca] = 'CID_NOMCID') OR
    (stlCampos[intIndBusca] = 'CID_ESTADO') Then
    strSQLAux := strSQLAux + 'D1.' + stlCampos[intIndBusca] + ' LIKE :VALBUS '

  Else If (stlCampos[intIndBusca] = 'CLI_CODCLI') Then
    strSQLAux := strSQLAux + 'C.' + stlCampos[intIndBusca] + ' LIKE :VALBUS '

  Else
    strSQLAux := strSQLAux + stlCampos[intIndBusca] + ' LIKE :VALBUS ';

  strSQLAux := strSQLAux + ' AND CLI_STATUS LIKE :STATUS ';

  If blnViaBol Then
    strSQLAux := strSQLAux + ' AND C.CLI_CODCLI IN (' + strCliBol + ')  ';

  If blnMovDet Then
    strSQLAux := strSQLAux + ' AND LOCATE(C.CLI_CODCLI, "' + strCliVen + '")  ';

  Result := strSQL + strSQLAux;
End;

Function TfrmImpEtiquetas.fRetornaSQLIte(blnFilDta, blnPromocPeriod, blnFilHra: Boolean;  blnVazio: Boolean = False; tpAltPreEti : TTipoAltPreEti = tpTodos; blnFilEmpEtiEle: Boolean = False; strPreTab: string = 'SSSSSSS'): String;

Var
  strSQL,
  strSQLPromo: String;
  PosIni, i: Integer;
Begin

  strSQLPromo := '';
  strSQLPromo := fSubSQLPROMOC('', '', '', '', '', '');

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CADITE.ITE_CODUNI AS ITE_CODUNI, ';
  strSQL := strSQL + '  CADITE.ITE_CODEMP AS ITE_CODEMP, ';
  strSQL := strSQL + '  ITEETI.ETI_QTDETI AS ITE_QTDETI, ';
  strSQL := strSQL + '  ITEETI.ETI_OBSERV AS ITE_OBSERV, ';
  strSQL := strSQL + '  IF(CADITE.ITE_ITEATI = "S", "A", "I") AS ITE_ITEATI, ';
  strSQL := strSQL + '  CADITE.ITE_CODITE AS ITE_CODITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODGRU AS ITE_CODGRU, ';
  strSQL := strSQL + '  CADITE.ITE_DESITE AS ITE_DESITE, ';
  strSQL := strSQL + '  CADITE.ITE_DESSIM AS ITE_DESSIM, ';
  strSQL := strSQL + '  CADITE.ITE_REFERE AS ITE_REFERE, ';
  strSQL := strSQL + '  CADITE.ITE_APLICA AS ITE_APLICA, ';
  strSQL := strSQL + '  CADITE.ITE_FABRIC AS ITE_CODFAB, ';
  strSQL := strSQL + '  CADITE.ITE_BARRAS AS ITE_CODBAR, ';
  strSQL := strSQL + '  CADITE.ITE_CODMAR AS ITE_CODMAR, ';
  strSQL := strSQL + '  CADITE.ITE_CODDEP AS ITE_CODDEP, ';
  strSQL := strSQL + '  CADITE.ITE_MLTCOM AS ITE_MLTCOM, ';
  strSQL := strSQL + '  CADITE.ITE_MLTVEN AS ITE_MLTVEN, ';
  strSQL := strSQL + '  IF (CATITE.CAT_DTAALT > CADITE.ITE_DTAALT, CATITE.CAT_DTAALT, CADITE.ITE_DTAALT) AS ITE_DTAALT, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE1 AS ITE_PREVE1, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE2 AS ITE_PREVE2, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE3 AS ITE_PREVE3, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE4 AS ITE_PREVE4, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE5 AS ITE_PREVE5, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE6 AS ITE_PREVE6, ';
  strSQL := strSQL + '  ITEGER.ITE_PREVE7 AS ITE_PREVE7, ';
  If fCfgSis('CTLEST') = '2' Then
  Begin
    strSQL := strSQL + '  (SELECT GROUP_CONCAT(LOT_NUMLOT) FROM CADLOT ';
    strSQL := strSQL + '    WHERE LOT_CODITE = ITEGER.ITE_CODITE       ';
    strSQL := strSQL + '      AND LOT_CODEMP = ITEGER.ITE_CODEMP ) AS ITE_AMZETI, ';
  End
  Else
    strSQL := strSQL + '  ITEGER.ITE_AMZETI AS ITE_AMZETI, ';
  strSQL := strSQL + '  CONCAT(IFNULL(ITEGER.ITE_LOCFIS, ""), "," ,IFNULL((SELECT GROUP_CONCAT(LOT_LOCFIS) FROM CADLOT ';
  strSQL := strSQL + '  WHERE LOT_CODITE = ITEGER.ITE_CODITE ';
  strSQL := strSQL + '    AND LOT_CODEMP = ITEGER.ITE_CODEMP ';
  strSQL := strSQL + '    AND LOT_LOCFIS <> IFNULL(ITEGER.ITE_LOCFIS, "")), ""))  AS LOCFIS, ';
  strSQL := strSQL + '  ITEGER.ITE_LOCSUP AS ITE_LOCSUP, ';
  strSQL := strSQL + '  CADEMP.*,  ';
  strSQL := strSQL + '  CADUNI.UNI_SIGUNI, ';
  strSQL := strSQL + '  CADITE.ITE_EMBALA AS ITE_EMBALA, ';
  strSQL := strSQL + '"' + fLoteCriptografado + '"' + ' AS LOTECR, ';
  strSQL := strSQL + '"' + strLoginUsuarioLogado + '"' + ' AS ITE_CODOPE, ';
  strSQL := strSQL + fULTALP(blnFilDta) + ' AS ULTALP, ';
  strSQL := strSQL + '  ITEGER.ITE_SALDOS,  ';
  strSQL := strSQL + '  CADITE.ITE_DESFAB AS ITE_DESFAB, ';
  strSQL := strSQL + '  CADGRU.GRU_DESGRU AS GRU_DESGRU, ';
  strSQL := strSQL + '  ITEGER.ITE_CODEMP AS ITEGER_CODEMP, ';

  strSQL := strSQL + ' ( ';
  strSQL := strSQL + strSQLPromo ;
  strSQL := strSQL + ') AS EPROMO, ';

  {strSQL := strSQL + 'IF(( SELECT COUNT(ITEPRO.IPR_CODITE) AS QTD ';
  strSQL := strSQL + '       FROM ITEPRO ';
  strSQL := strSQL + '      INNER JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  strSQL := strSQL + '      INNER JOIN PROEMP ON PROEMP.PRO_CODEMP = CADPRO.PRO_CODEMP ';
  strSQL := strSQL + '      WHERE '+QuotedStr(FormatDateTime('yyyymmdd', fNow()))+' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ';
  strSQL := strSQL + '        AND ITEPRO.IPR_CODITE = CADITE.ITE_CODITE AND PROEMP.PRO_CODEMP = ITEGER.ITE_CODEMP ) > 0, "S", "N") AS EPROMO, ';}

  strSQL := strSQL + '  CADITE.ITE_QRCODE AS QRCODE, ';

  strSQL := strSQL + ' ITEGER.ITE_ESTMIN , ';
  strSQL := strSQL + ' ITEGER.ITE_ESTMAX, ';
  strSQL := strSQL + ' ITEGER.ITE_DTAETI, ';
  
  If (not fEmptyStr(strCodAmz)) and (intExibeEstoque = 1) or (blnSalAmz) then
    strSQL := strSQL + '  CADLOT.LOT_SALDOS,  '
  else
    strSQL := strSQL + '  CAST(0 as DECIMAL(14,4)) AS LOT_SALDOS,  ';

  strSQL := strSQL + ' CADMAR.MAR_DESMAR AS MAR_DESMAR ';

  strSQL := strSQL + 'FROM ';
  // Se tiver blnFilDta a base dos filtros é o prealt e a catite, passando assim a cadite como dependenete
  If blnFilDta Then
  Begin
    strSQL := strSQL + '    (SELECT ALT_CODITE,';
    strSQL := strSQL + '        MAX(ALT_DTAALT) AS ALT_DTAALT';
    strSQL := strSQL + '     FROM PREALT';
    strSQL := strSQL + '    WHERE ALT_DTAALT IS NOT NULL AND ( ';

    If tpAltPreEti = tpPrecoCusto Then
      strSQL := strSQL + ' ALT_CUSANT <> ALT_CUSATU '
    Else If (tpAltPreEti = tpPrecoVenda) Or (tpAltPreEti = tpTodos) Then
    Begin
      PosIni := Pos('S', strPreTab);
      For i := PosIni To 7 do
      Begin
        If (strPreTab[i] = 'S') then
        Begin
          If i <> PosIni Then
            strSQL := strSQL +  ' OR ';
          strSQL := strSQL + '          (PREALT.ALT_VE' + IntToStr(i) + 'ANT <> PREALT.ALT_VE' + IntToStr(i) + 'ATU)';
        End;
      End;
      If (tpAltPreEti = tpTodos) Then
        strSQL := strSQL + ' OR (ALT_CUSANT <> ALT_CUSATU) '
    End;
    strSQL := strSQL + '       ) AND ' + fRetornaFiltroAlteracaoPreco(False, blnFilHra);
    strSQL := strSQL + '     GROUP BY ALT_CODITE ';
    strSQL := strSQL + '  UNION ALL ';
    strSQL := strSQL + '      SELECT CADITE.ITE_CODITE ALT_CODITE, ';
    strSQL := strSQL + '              MAX(CATITE.CAT_DTAALT) AS ALT_DTAALT ';
    strSQL := strSQL + '       FROM CATITE ';
    strSQL := strSQL +
      '       INNER JOIN CADITE ON CADITE.ITE_CODFOR = CATITE.CAT_CODFOR AND CADITE.ITE_CODFAB = CATITE.CAT_CODFAB ';
    strSQL := strSQL + '      WHERE DATE_FORMAT(IF(CATITE.CAT_DTAALT > CADITE.ITE_DTAALT, CATITE.CAT_DTAALT, CADITE.ITE_DTAALT), "%d/%m/%Y") BETWEEN :DTAINI AND :DTAFIN ';
    If blnFilHra Then
    Begin
      strSQL := strSQL + '    AND ADDTIME(DATE_FORMAT(IF(CATITE.CAT_DTAALT > CADITE.ITE_DTAALT, CATITE.CAT_DTAALT, CADITE.ITE_DTAALT), "%d/%m/%Y"), ';
      strSQL := strSQL + '    IF(CATITE.CAT_DTAALT > CADITE.ITE_DTAALT, CATITE.CAT_HORALT, CADITE.ITE_HULALT)) BETWEEN CONCAT(:DTAINI," ",:HRAINI) AND CONCAT(:DTAFIN," ",:HRAFIN,":59") ';
    End;
    strSQL := strSQL +
      '        GROUP BY CATITE.CAT_CODFOR, CATITE.CAT_CODBAR ';
    If blnPromocPeriod Then
    Begin
      strSQL := strSQL + 'UNION ALL  SELECT IPR_CODITE ALT_CODITE,  PRO_DTAINI ALT_DTAALT  ';
      strSQL := strSQL + '   FROM ITEPRO  ';
      strSQL := strSQL + '   INNER JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER  ';
      strSQL := strSQL + '    WHERE PRO_DTAINI BETWEEN :DTAINI AND :DTAFIN  ';
      strSQL := strSQL + '      AND PRO_DTAFIN BETWEEN :DTAINI AND :DTAFIN  ';
    End;
    strSQL := strSQL + ') PRE LEFT JOIN CADITE ON CADITE.ITE_CODITE = PRE.ALT_CODITE ';
  End
  Else
    strSQL := strSQL + '  CADITE ';

  strSQL := strSQL + '  LEFT JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + '  JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADEMP ON ITEGER.ITE_CODEMP = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + '  LEFT JOIN CADGRU ON CADGRU.GRU_CODGRU = CADITE.ITE_CODGRU ';

  strSQL := strSQL +
    '  LEFT JOIN ITEETI ON ETI_CODITE = CADITE.ITE_CODITE AND ETI_CODOPE = ' +
    QuotedStr(strLoginUsuarioLogado) + ' ';

  strSQL := strSQL +
    '   LEFT JOIN CATITE ON CATITE.CAT_CODFOR = CADITE.ITE_CODFOR ';
  strSQL := strSQL +
    '                   AND CATITE.CAT_CODFAB = CADITE.ITE_CODFAB ';

  If Not fEmptyStr(stlCodBar.Text) Then
    strSQL := strSQL + '  LEFT JOIN ITEBAR ON ITEBAR.BAR_CODITE = CADITE.ITE_CODITE  ';

  If ((not fEmptyStr(strCodAmz)) and (intExibeEstoque = 1)) or (blnSalAmz) then
  Begin
    strSQL := strSQL + ' LEFT JOIN CADLOT ON LOT_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                 AND LOT_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  strSQL := strSQL + ' LEFT JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';
  If blnItensDivergentes Then
  Begin
    strSQL := strSQL + '  JOIN IMPPRE ON IMPPRE.IMP_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '                 AND IMP_JAIMPR = "N" ';
    strSQL := strSQL + '                 AND IMP_CODEMP = ITEGER.ITE_CODEMP ';
  End;

  strSQL := strSQL + 'WHERE ';
  If Not blnTodos Then
  Begin
    If Pos('ITE_DESITE', stlCampos[intIndBusca]) > 0 Then
      strSQL := strSQL + stlCampos[intIndBusca] + ' LIKE :VALBUS AND '
    Else If Pos('ULTALP', stlCampos[intIndBusca]) > 0 Then
      strSQL := strSQL + ' DATE_FORMAT(IFNULL(' + fULTALP(blnFilDta) +
        ', ""), "%d/%m/%Y") LIKE :VALBUS AND '
    Else If (Not blnFilDta) And (Pos('ULTALP', stlCampos[intIndBusca]) > 0) Then
    Begin
      strSQL := strSQL + '   IFNULL((SELECT MAX(PREALT.ALT_DTAALT) ';
      strSQL := strSQL + '      FROM PREALT ';
      strSQL := strSQL +
        '      WHERE PREALT.ALT_CODITE = ITEGER.ITE_CODITE  AND PREALT.ALT_CODEMP = '
        + QuotedStr(VS_strCodEmp) + '), "") LIKE :VALBUS AND ';
    End
    Else If Pos('ITE_DTAALT', stlCampos[intIndBusca]) > 0 then
      strSQL := strSQL + ' DATE_FORMAT(IFNULL(' + stlCampos[intIndBusca] +
        ', ""), "%d/%m/%Y") LIKE :VALBUS AND '
    Else If pos('ITE_OBSERV', stlCampos[intIndBusca]) > 0 then
      strSQL := strSQL + ' IFNULL(ETI_OBSERV, "") LIKE :VALBUS AND '
    Else
      strSQL := strSQL + ' IFNULL(' + stlCampos[intIndBusca] +
        ', "") LIKE :VALBUS AND ';
  End
  Else
  Begin
   strSQL := strSQL + ' "%" = :VALBUS AND ';
   blnTodos := False;
  End;

  If rdgStatus.ItemIndex <> 2 Then
    strSQL := strSQL + '  ITE_ITEATI = :ITEATI AND ';

  If (blnSalAmz) then
    strSQL := strSQL + ' CADLOT.LOT_SALDOS > 0 AND '
  Else If (not fEmptyStr(strCodAmz)) and (intExibeEstoque = 1) then
  Begin
    Case rdgSaldos.ItemIndex Of
      1: strSQL := strSQL + ' CADLOT.LOT_SALDOS > 0 AND ';
      2: strSQL := strSQL + ' CADLOT.LOT_SALDOS < 0 AND ';
    End;

    case blnSalMin Of
      TRUE: strSQL := strSQL + ' CADLOT.LOT_SALDOS >= ITEGER.ITE_ESTMIN AND ';
    end;
  End
  Else
  Begin
    Case rdgSaldos.ItemIndex Of
      1: strSQL := strSQL + ' ITEGER.ITE_SALDOS > 0 AND ';
      2: strSQL := strSQL + ' ITEGER.ITE_SALDOS < 0 AND ';
    End;

    case blnSalMin Of
      TRUE: strSQL := strSQL + ' ITEGER.ITE_SALDOS >= ITEGER.ITE_ESTMIN AND ';
    end;
  End;

  If (blnPromoc) And (blnMosFil) And (Not blnPromocPeriod) Then
  Begin
    strSQL := strSQL + 'CADITE.ITE_CODITE IN (' + IIF(stlPromoc.Count > 0,
      fCommaText(stlPromoc, True), '""') + ') AND ';
  End;

  If (Not fEmptyStr(strCodEmpEtiEleAlt)) And (blnFilEmpEtiEle) Then
  Begin
    If (strCodEmpEtiEleAlt <> '000') Then
      strSQL := strSQL + '  LOCATE(ITEGER.ITE_CODEMP, "' + strCodEmpEtiEleAlt + '_' + VS_strCodEmp + '") > 0 '
    Else
      strSQL := strSQL + '  LOCATE(ITEGER.ITE_CODEMP, "' + fRetListaCodEmpEtiEle + '_' + VS_strCodEmp + '") > 0 ';
  End
  Else
    strSQL := strSQL + '  ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If Not fEmptyStr(stlCodBar.Text) Then
  Begin
    strSQL := strSQL + 'AND ITEBAR.BAR_CODBAR IN (' + IIF(stlCodBar.Count > 0,
    fCommaText(stlCodBar, True), '""') + ') ';
  End;

  Case intEstMin Of
    1:
      strSQL := strSQL + ' AND ITEGER.ITE_ESTMIN = 0 ';
    2:
      strSQL := strSQL + ' AND ITEGER.ITE_ESTMIN > 0 ';
  End;

  Case intEstMax Of
    1:
      strSQL := strSQL + ' AND ITEGER.ITE_ESTMAX = 0 ';
    2:
      strSQL := strSQL + ' AND ITEGER.ITE_ESTMAX > 0 ';
  End;

  If (intEstFis > 0) Then
  Begin
    strSQL := strSQL + ' AND ITEGER.ITE_SALDOS + IF(IFNULL(CADITE.ITE_CNV_ML, 0) > 0, IFNULL(ITEGER.ITE_SAL_ML, 0) / CADITE.ITE_CNV_ML, 0) + ' +
    IIF(Not fCfgSis('BEFTRG', VarBoolean), fGetSQLSomaCamposEntregaFutura('ITEGER'), '0');

    Case intEstFis Of
      1:
        strSQL := strSQL + ' = 0';
      2:
        strSQL := strSQL + ' > 0';
      3:
        strSQL := strSQL + ' < 0';
    End;
  End;

  If blnVazio Then
    strSQL := strSQL + ' AND FALSE ';

  Result := strSQL;
End;

Function TfrmImpEtiquetas.fSQLEmpresaPreAlt(strCodEmp: String;
  arrCodEmp: TConsultasArray): String;
  Function fRetListaCodEmp: String;
  Var
    i: Integer;
  Begin
    For i := 0 To High(arrCodEmp) Do
      Result := Result + '_' + arrCodEmp[i].strCodigo;
  End;

Begin
  Result := '';
  If (strCodEmp <> '000') Then
    Result := '  PREALT.ALT_CODEMP = ' + QuotedStr(strCodEmp)
  Else
    Result := '  LOCATE(PREALT.ALT_CODEMP, "' + fRetListaCodEmp + '") > 0';
End;

function TfrmImpEtiquetas.fSubSQLPROMOC(strCodCnd, strCndPag, strTabPre,
  strCodCli, strNumOrc, strEspOrc: String): String;
Var
   intPraMedio  : Integer;
   objItemPromo : TItemPromo;
begin
  {FUNÇÃO IGUAL "untPesqItem - fSubSelPROMOC",
   RETORNA A MESMA INFORMAÇÃO DA CONSULTA DO ITEM, PARA SABER SE O ITEM ESTÁ OU NÃO EM PROMOÇÃO}

  If strCndPag <> '' Then
    intPraMedio := fFloatToInt(fCalcMediaPagto(strCndPag))
  Else
    intPraMedio := 0;

  If strTabPre = '' Then;
    strTabPre := IIF(fEmptyStr(fCfgSis('TABPAD', varString)), '1', fCfgSis('TABPAD', varString));

  objItemPromo := TItemPromo.Create;
  objItemPromo.strAndWhereCodEmp := ' ITEGER.ITE_CODEMP ';
  objItemPromo.strAndWhereCodIte := ' ITEGER.ITE_CODITE ';
  objItemPromo.strCodCli         := strCodCli;
  objItemPromo.strTabPre         := strTabPre;
  objItemPromo.strCodCnd         := strCodCnd;
  objItemPromo.strNumOrc         := strNumOrc;
  objItemPromo.strEspOrc         := strEspOrc;
  objItemPromo.blnUsaLimit := False;
  If fCfgSis('PRZPRO', varBoolean) Then
    objItemPromo.intPraMedio := intPraMedio;

  objItemPromo.strSelect := ' IF(COUNT(*) > 0, 1, NULL) ';
  Result := ' IF(IFNULL(('+objItemPromo.fRetSubQryPromo+'), '+fGetSQLConsultaItensPrecoEstruturaPromo('ITEGER', strTabPre, strCodCli, IntToStr(intPraMedio))+') > 0, "SIM", "NÃO") ';

  FreeAndNil(objItemPromo);
end;

Function TfrmImpEtiquetas.fRetornaFiltroAlteracaoPreco(blnUpdate, blnFilHra: Boolean): String;
Begin
  Result := '';
  Result := Result + ' ( PREALT.ALT_DTAALT BETWEEN :DTAINI AND :DTAFIN )';
  If blnFilHra Then
    Result := Result + ' AND ( ADDTIME(PREALT.ALT_DTAALT,PREALT.ALT_HORALT) BETWEEN CONCAT(:DTAINI," ",:HRAINI) AND CONCAT(:DTAFIN," ",:HRAFIN,":59")  )';
  Result := Result + '   AND ' + fSQLEmpresaPreAlt(strCodEmpAlt, arrCodEmp)
End;

Function TfrmImpEtiquetas.fRetornaSQLDiv: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADDIV.*, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADDIV ';
  strSQL := strSQL + '  JOIN CADCID ON DIV_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE AND ';
  strSQL := strSQL + stlCampos[intIndBusca] + ' LIKE :VALBUS ';

  If blnMovDet Then
    strSQL := strSQL + ' AND LOCATE(DIV_CODDIV, "' + strDivVen + '")  ';

  Result := strSQL;
End;

Function TfrmImpEtiquetas.fRetornaSQLEstr: String;
Var
  strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  GERMAT.*,  ';
  strSQL := strSQL + '  CADITE.*,  ';
  strSQL := strSQL + '  CADGRU.* ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  GERMAT ';
  strSQL := strSQL + '  JOIN CADITE ON GERMAT.GMT_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADGRU ON GRU_CODGRU        = ITE_CODGRU ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  IFNULL(' + stlCampos[intIndBusca] +
    ', "") LIKE :VALBUS ';

  Result := strSQL;
End;

Function TfrmImpEtiquetas.fRetornaSQLFor: String;
Var
  strSQL: String;
Begin
  strSQLAux := '';
  strSQL := '';

  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADFOR.*, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO ';

  strSQLAux := strSQLAux + 'FROM ';
  strSQLAux := strSQLAux + '  CADFOR ';
  strSQLAux := strSQLAux + '  JOIN CADCID ON FOR_CODCID = CID_CODCID ';
  strSQLAux := strSQLAux + 'WHERE ';
  strSQLAux := strSQLAux + '  TRUE AND ';
  strSQLAux := strSQLAux + stlCampos[intIndBusca] + ' LIKE :VALBUS ';

  Result := strSQL + strSQLAux;
End;

Function TfrmImpEtiquetas.fRetornaSQLVen: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADOPE.*, ';
  strSQL := strSQL + '  CID_NOMCID, ';
  strSQL := strSQL + '  CID_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADOPE ';
  strSQL := strSQL + '  JOIN CADCID ON OPE_CODCID = CID_CODCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  TRUE AND ';
  strSQL := strSQL + stlCampos[intIndBusca] + ' LIKE :VALBUS ';

  Result := strSQL;
End;

Function TfrmImpEtiquetas.fRetQtdSel: Integer;
Var
  strSQL: String;
  qryGenTmp: TUniQuery;

Begin
  Try

    qryGenTmp := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  SUM(' + IIF(SameText(strNomeTabela, 'CADITE'),
      'ETI_QTDETI', strCamQtd) + ') AS QTD ';
    strSQL := strSQL + 'FROM ';

    If SameText(strNomeTabela, 'CADITE') Then
    Begin
      strSQL := strSQL + ' ITEGER ';
      strSQL := strSQL +
        ' JOIN ITEETI ON (ITEETI.ETI_CODITE = ITEGER.ITE_CODITE)';
      strSQL := strSQL + ' WHERE ITE_CODEMP = ' +
        QuotedStr(IfThen(fEmptyStr(strCodEmpAlt) Or (strCodEmpAlt = '000'),
        VS_strCodEmp, strCodEmpAlt)) + ' AND ETI_CODOPE = ' +
        QuotedStr(strLoginUsuarioLogado);
    End

    Else
      strSQL := strSQL + strNomeTabela;

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenTmp);
  End;

End;

Procedure TfrmImpEtiquetas.FormKeyPress(Sender: TObject; Var Key: Char);
Begin
  Inherited;

 (*
  If dbgEtiquetas.Focused Then
  Begin
    If CharInSet(Key, ['A' .. 'Z', 'a' .. 'z', '0' .. '9', #8]) Then
    Begin
      pSetFocus(edtBusca);
      edtBusca.Text := AnsiUpperCase(String(Key));
    End;
  End;
  *)
End;

Procedure TfrmImpEtiquetas.pImpEtiquetasLaserItens;
Var
  prmDllEtq: TParamDllEtiquetas;
  tpeEtique: TTipoEtiqueta;
  blnPrePro: Boolean;
  strDesEti: String;
  blnComPre, blnExiPrePro: Boolean;
  ArrOrdEti: TStringArray;
  intOpcOrd: Integer;
Begin
  blnComPre := False;
  tpeEtique := TTipoEtiqueta.GetByName(fCfgSis('LAYPAD'));

  If fProdutoSelPromo Then
  Begin
    blnPrePro := IIF((fGetMenu('Existem produtos em promoção, Escolha a opção desejada:', ['Utilizar preço da promoção para imprimir a etiqueta',
     'Utilizar preço de tabela para imprimir a etiqueta'], 1, False, False, 140)) = 1, True, False);
    blnExiPrePro := blnPrePro;
  End;

  If (tpeEtique = tpeNenhum) Then
  Begin
    If Not fEscolheTipoEtiqueta(tpeEtique, stlPromoc.Count > 0, blnPrePro, FPreco, strCodCnd, strCndDes, strNumPar, strDesEti, blnExiPrePro) Then
      Exit;
  End
  Else
  Begin
    strDesEti := tpeEtique.GetName;
    blnComPre := (Pos('com preço', strDesEti.ToLower) > 0) or (Pos('com preco', strDesEti.ToLower) > 0);
    If Not fEscolheTabelaPreco((stlPromoc.Count > 0), blnPrePro, blnComPre, FPreco, True, blnExiPrePro) Then
      Exit;
  end;

  prmDllEtq := TParamDllEtiquetas.Create;

  if fCfgSis('DEFORD', varBoolean) then
  begin

    SetLength(ArrOrdEti, 0);
    pAddDados(ArrOrdEti, 'Ordem de Inclusão');
    pAddDados(ArrOrdEti, 'Descrição do Produto');
    pAddDados(ArrOrdEti, 'Código do Produto');

    intOpcOrd := fGetMenu('Deseja ordenar por :', ArrOrdEti, 1);

    Case intOpcOrd Of
      1 : prmDllEtq.strCamBus := '';
      2 : prmDllEtq.strCamBus := 'DESITE';
      3 : prmDllEtq.strCamBus := 'CODITE';
    End;

  end;

  prmDllEtq.tpeTipEtq := tpeEtique;
  prmDllEtq.intTabPre := FPreco;
  prmDllEtq.strCodCnd := strCodCnd;
  prmDllEtq.strCndDes := strCndDes;
  prmDllEtq.strNumPar := strNumPar;
  prmDllEtq.blnPromoc := blnPrePro;
  prmDllEtq.stlPromoc := stlPromoc;
  prmDllEtq.cdsPromoc := cdsPromoc;
  prmDllEtq.cdsCodBar := cdsCodBar;
  prmDllEtq.strPerDes := edtPercentDesconto.Text;
  prmDllEtq.cdsArmaze := cdsArmaze;
  prmDllEtq.strDtaPro := strDtaPro;

  if (dbgEtiquetasTableView.sorteditemcount > 0) and (not AnsiMatchStr(dbgEtiquetasTableView.Columns[dbgEtiquetasTableView.sorteditems[0].Index].DataBinding.FieldName, ['ULTALP', 'ITE_OBSERV'])) then
  begin
    prmDllEtq.strIdxFld := dbgEtiquetasTableView.Columns[dbgEtiquetasTableView.sorteditems[0].Index].DataBinding.FieldName;
    prmDllEtq.blnSoDesc := dbgEtiquetasTableView.Columns[dbgEtiquetasTableView.sorteditems[0].Index].SortOrder = soDescending;
  end
  else
    prmDllEtq.strIdxFld := stlCampos[intIndBusca];

  prmDllEtq.blnPrePro := blnExiPrePro;
  prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp)); // ShortString(IfThen(fEmptyStr(strCodEmpAlt) Or (strCodEmpAlt = '000'), VS_strCodEmp, strCodEmpAlt));
  pCriarFormularios(TFrmGravando, frmGravando);

  try
    frmGravando.lblGravando.Caption := 'Aguarde... Processando';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.Show;
    Application.ProcessMessages;
    fImprimeEtiqueta(prmDllEtq, 'fimprimeetiquetaitens');
    frmGravando.Close;
  finally
    FreeAndNil(frmGravando);
    FreeAndNil(prmDllEtq);
  end;

  if Assigned(dbgEtiquetas) then
    pSetFocus(dbgEtiquetas);

  blnPromoc := False;
End;

Function TfrmImpEtiquetas.fImprimeLaserArgox(tpeTipEti: TTipoEtiqueta;
  strIndexFieldNames: String): Boolean;
Var
  prmDllEtq: TParamDllEtiquetas;
Begin
  prmDllEtq := TParamDllEtiquetas.Create;

  With prmDllEtq Do
  Begin
    tpeTipEtq := tpeTipEti;
    strIdxFld := strIndexFieldNames;
  End;

  Result := fImprimeEtiqueta(prmDllEtq);
  FreeAndNil(prmDllEtq);
End;

Function TfrmImpEtiquetas.fImprimeEtiquetaClienteLaser: Boolean;
Var
  prmDllRel: TParamDllEtiquetas;
Begin
  prmDllRel := TParamDllEtiquetas.Create;

  With prmDllRel Do
  Begin
    tpeTipEtq := tpeTipEtqCliente;
    strLayDoc := strCodLayEtqCliente;

    If (fMensagem('', 'Deseja ordenar por CEP ?', ['&Sim', '&Não']) = 1) Then
      strCamBus := 'CLI_C_E_P_'
    Else
      strCamBus := ShortString(stlCampos[intIndBusca]);

    if Not fEmptyStr(strCliBol) then
      strCodCli := strCliBol;

    blnEdrCob := blnEndCob;
  End;

  Result := fImprimeEtiqueta(prmDllRel);

  If fCriarOcorrenciasCRM(Result) Then
    pCriarOcorrenciasCRMClientesSelecionados;

  FreeAndNil(prmDllRel);
End;

Procedure TfrmImpEtiquetas.frxUserDataSet1CheckEOF(Sender: TObject;
  Var Eof: Boolean);
Begin
  Inherited;

  Eof := qryEtique.Eof;

End;

Procedure TfrmImpEtiquetas.frxUserDataSet1First(Sender: TObject);
Begin
  Inherited;

  qryEtique.First;
  intQtdEti := Pred(qryEtique.FieldByName('QTDETI').AsInteger);

End;

Procedure TfrmImpEtiquetas.frxUserDataSet1GetValue(Const VarName: String;
  Var Value: Variant);
Begin
  Inherited;

  If SameText('CODBAR', VarName) And
    ((Length(qryEtique.FieldByName(VarName).AsString) > 13) Or
    (StrToInt64Def(qryEtique.FieldByName(VarName).AsString, -1) = -1)) Then
    Value := '0'
  Else
    Value := qryEtique.FieldByName(VarName).AsString;

End;

Procedure TfrmImpEtiquetas.frxUserDataSet1Next(Sender: TObject);
Begin
  Inherited;

  If intQtdEti <= 0 Then
  Begin

    qryEtique.Next;
    intQtdEti := qryEtique.FieldByName('QTDETI').AsInteger;

  End;

  Dec(intQtdEti);
End;

{
  Procedure TfrmImpEtiquetas.dbgEtiquetasDrawColumnCell(Sender: TObject;
  Const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  Var
  strTexto: String;
  Begin Inherited;

  If Column.Index = intIndBusca Then
  Begin
  dbgEtiquetas.Canvas.Brush.Color := clInfoBk;
  dbgEtiquetas.Canvas.Font.Color := clWindowText;
  dbgEtiquetas.Canvas.FillRect(Rect);
  End;

  If intTipEti = ETI_ITENS Then
  Begin
  If (Column.Field.DataSet.FieldByName('ITE_ITEATI').AsString = 'I') Then
  dbgEtiquetas.Canvas.Font.Color := clRed
  Else
  dbgEtiquetas.Canvas.Font.Color := clBlack;
  End;
  dbgEtiquetas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  If intTipEti = ETI_CLIENTES Then
  Begin

  If (Column.Field.DataSet.FieldByName('CLI_STATUS').AsString = 'I') Then
  dbgEtiquetas.Canvas.Font.Color := clRed
  Else
  dbgEtiquetas.Canvas.Font.Color := clBlack;
  dbgEtiquetas.DefaultDrawColumnCell(Rect, DataCol, Column, State);

  If Column.Index = 3 Then
  Begin
  If Length(Column.Field.Text) > 11 Then
  strTexto := FormatMaskText(fRetMascaraC_G_C_(FPais, C_G_C_),
  Column.Field.Text)
  Else If Length(Column.Field.Text) > 0 Then
  strTexto := FormatMaskText(fRetMascaraC_G_C_(FPais, C_P_F_),
  Column.Field.Text)
  Else
  strTexto := '';
  dbgEtiquetas.Canvas.TextOut(Rect.Left + 1, Rect.Top + 1, strTexto);
  End;
  End;

  End;
}

procedure TfrmImpEtiquetas.dbgEtiquetasTableViewCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
  var
    indexPromoc: Integer;
    indexUltImpr:Integer;
    indexUltAltP: Integer;
    indexCodItem: Integer;
    strUltImpr: string;
    strUltAltP: string;
    strCodIte: string;
    strHorAlt: string;
    strHorImp: string;
begin
  inherited;

  if (intTipEti = ETI_ITENS) then
  begin
    indexPromoc := dbgEtiquetasTableView.GetColumnByFieldName('EPROMO').Index;
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, indexPromoc]) = 'SIM' Then
    begin
      ACanvas.Font.Color  := fRetornaCorPromocional;
    end;

    indexUltImpr := dbgEtiquetasTableView.GetColumnByFieldName('ITE_DTAETI').Index;
    indexUltAltP := dbgEtiquetasTableView.GetColumnByFieldName('ULTALP').Index;
    indexCodItem := dbgEtiquetasTableView.GetColumnByFieldName('ITE_CODITE').Index;

    strUltImpr := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,indexUltImpr]);
    strUltAltP := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,indexUltAltP]);
    strCodIte := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex,indexCodItem]);

    if fEmptyStr(StrUltImpr) then
    begin
      ACanvas.Brush.Color  := clSilver;
    end
    else if fEmptyStr(StrUltAltP) and not fEmptyStr(StrUltImpr) then
    begin
      ACanvas.Brush.Color  := clMoneyGreen;
    end
    else if StrToDateTimeDef(StrUltImpr,0) = StrToDateTimeDef(StrUltAltP,0) then
    begin
      strHorAlt := TimeToStr((fDataHrAlt(strCodIte,VS_strCodEmp,StrToDateTime(StrUltAltP))));
      strHorImp := TimeToStr((fDataHrImp(strCodIte,VS_strCodEmp,StrToDateTime(StrUltImpr))));

      if StrToDateTime(StrHorImp) >= StrToDateTime(StrHorAlt) then
      begin
        ACanvas.Brush.Color  := clMoneyGreen;
      end

      else if StrToDateTime(StrHorImp) < StrToDateTime(StrHorAlt) then
      begin
        ACanvas.Brush.Color  := clWhite;
      end

    end
    else if StrToDateTime(StrUltImpr) > StrToDateTime(StrUltAltP) then
    begin
      ACanvas.Brush.Color  := clMoneyGreen;
    end;

    If AViewInfo.Selected Then
    Begin
      ACanvas.Brush.Color := $00F5DBC2;
      ACanvas.Font.Color := clBlack;
      ACanvas.Font.Style := [fsBold];
    End;
  end;

end;

procedure TfrmImpEtiquetas.dbgEtiquetasTableViewDataControllerFilterChanged(
  Sender: TObject);
var
  I: Integer;
  S: string;
begin
  with  dbgEtiquetasTableView, ViewData do
  begin
    if FilterRow.Focused then
    begin
      for I := 0 to ColumnCount - 1 do
      begin
        S := VarToStr(FilterRow.Values[I]);

        if (Length(S)> 0) and (S[1] <> '%') then
          FilterRow.Values[I] := '%' + S;

        If strConEti <> '1' Then
           if (Length(S)> 0) and (RightStr(S, 1) <> '%') then
             FilterRow.Values[I] := S + '%';

      end;
    end;
  end;
end;

procedure TfrmImpEtiquetas.dbgEtiquetasTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Assigned(cxEditQtdEti) And (Key = VK_Return)) Then
  Begin
    pDigQuantidade;
    pSetFocus(Self);
  End;
end;

Procedure TfrmImpEtiquetas.dbgEtiquetasTitleClick(Column: TColumn);
Begin
  Inherited;

  intIndBusca := Column.Index;

//  lblDesBus.Caption := stlDesInd[intIndBusca];
//  blnParKey := True;
//  pSetFocus(edtBusca);
//  edtBusca.Clear;
//  dbgEtiquetas.Repaint;
End;

Procedure TfrmImpEtiquetas.pEscolheTabelaPreco(blnComPre: Boolean);
Begin

  Try

    pCriarFormularios(TfrmConfirmaPreco, frmConfirmaPreco);

    { ********************************************************* }
    { * VERIFICA SE HABILITA\DESABILITA A OPCAO  DE SEM PRECO * }
    { ******************************************************JB* }
    If blnComPre Then
    Begin
      frmConfirmaPreco.rdgOpcao.Items.Clear;
      frmConfirmaPreco.rdgOpcao.Items.Add('Com Preço');
    End;

    { ************************************************** }
    { * CASO TENHA FILTRADO ITENS PROMOCIONAL ADICIONA * }
    { * MAIS UMA OPÇÃO NA ESCOLHA DA TABELA DE PREÇO.  * }
    { ***********************************************PZ* }
    If (stlPromoc.Count > 0) Then
      frmConfirmaPreco.cbTabela.Items.Add('PROMOCIONAL');

    frmConfirmaPreco.chkPrePro.Visible := True;

    frmConfirmaPreco.chkPrePro.Checked := (fCfgSis('CHKPRO', varBoolean));

    frmConfirmaPreco.ShowModal;

    If (frmConfirmaPreco.ModalResult = mrOk) Then
    Begin
      blnExibePrePro := frmConfirmaPreco.chkPrePro.Checked;
      If (frmConfirmaPreco.rdgOpcao.ItemIndex = 1) Or (blnComPre) Then
      Begin
        If (frmConfirmaPreco.cbTabela.Text = 'PROMOCIONAL') Then
        Begin
          FPreco := 0;
          blnPromoc := True;
        End
        Else
        Begin
          FPreco := strToIntDef(RightStr(frmConfirmaPreco.cbTabela.Text, 1), 0);
          blnPromoc := False;
        End;

        FDecimais := fCfgSis('DECUNI', varInteger);
      End
      Else
      Begin
        FPreco := 0;
        blnImpPre := False;
      End;
    End
    Else
    Begin
      FPreco := 0;
      blnImpPre := False;

    End;

  Except
    On E: Exception Do
    Begin
      FPreco := 0;
      blnImpPre := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.pEscolheTabelaPreco]');
    End;
  End;

  pFreeAndNil(frmConfirmaPreco);

End;

Procedure TfrmImpEtiquetas.pAbreEstruturas;
Begin

  Self.Caption := 'Impressão de Etiquetas - Estruturas';
  strCamQtd := 'GMT_QTDETI';

  { ***************************************** }
  { * INICIALIZA VARIAVEIS DA BUSCA         * }
  { **************************************MV* }
  stlCampos.Add('GERMAT.GMT_QTDETI');
  stlCampos.Add('GERMAT.GMT_CODITE');
  stlCampos.Add('CADGRU.GRU_CODGRU');
  stlCampos.Add('CADITE.ITE_DESITE');
  stlCampos.Add('GERMAT.GMT_REFERE');

  stlDesInd.Add('Qtd. Etiq.');
  stlDesInd.Add('Código');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Referência');

  With qryImpEti Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fRetornaSQLEstr + ' ORDER BY ' + stlCampos[intIndBusca] +
      IIF(intIndBusca = 1, ', ITE_DESITE', ''));
    ParamByName('VALBUS').AsString := '%';
    Open;
  End;

  With updImpEti Do
  Begin
    ModifySQL.Clear;
    ModifySQL.Add(fRetornaSQLUpdateEstr);
  End;

  With dbgEtiquetasTableView Do
  Begin
    BeginUpdate;
    ClearItems;
    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'GMT_QTDETI';
      Caption := 'Qtd. Eti.';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'GMT_CODITE';
      Caption := 'Código';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'GRU_CODGRU';
      Caption := 'Grupo';
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'ITE_DESITE';
      Caption := 'Descrição';
      Width := 320;
    End;

    With CreateColumn Do
    Begin
      DataBinding.FieldName := 'GMT_REFERE';
      Caption := 'Referência';
    End;
    EndUpdate;
  End;
End;

Function TfrmImpEtiquetas.fGetFiltrosEstruturas(strDesIni, strDesFin,
  strLinGru: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strDesIni) Then
    strSQL := strSQL +
      ' AND LEFT(ITE_DESITE, LENGTH(:MAIOR)) BETWEEN :DESINI AND :DESFIN ';

  If Not fEmptyStr(strLinGru) Then
  Begin
    strSQL := strSQL + ' AND ';
    If RightStr(strLinGru, 3) = '000' Then
      strSQL := strSQL + ' LEFT(CADGRU.GRU_CODGRU, 3) = :CODGRU '
    Else
      strSQL := strSQL + ' CADGRU.GRU_CODGRU = :CODGRU ';
  End;

  Result := strSQL;
End;

Procedure TfrmImpEtiquetas.pSetParamsEstruturas(strDesIni, strDesFin,
  strLinGru: String);
Begin
  With qryImpEti Do
  Begin
    If Not fEmptyStr(strDesIni) Then
    Begin
      If Length(strDesIni) > Length(strDesFin) Then
        ParamByName('MAIOR').AsString := strDesIni
      Else
        ParamByName('MAIOR').AsString := strDesFin;

      ParamByName('DESINI').AsString := strDesIni;
      ParamByName('DESFIN').AsString := strDesFin;
    End;

    If Not fEmptyStr(strLinGru) Then
    Begin

      If RightStr(strLinGru, 3) = '000' Then
        ParamByName('CODGRU').AsString := LeftStr(strLinGru, 3)
      Else
        ParamByName('CODGRU').AsString := strLinGru;
    End;
  End;
End;

Function TfrmImpEtiquetas.fSetFiltraEstruturas(strDesIni, strDesFin,
  strLinGru: String; intQtdEti: Integer): Boolean;
Begin
  Result := True;

  Try
    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;

      SQL.Add(fRetornaSQLFiltroEstr + fGetFiltrosEstruturas(strDesIni,
        strDesFin, strLinGru));

      pSetParamsEstruturas(strDesIni, strDesFin, strLinGru);

      If FindParam('GMT_QTDETI') <> Nil Then
        ParamByName('GMT_QTDETI').AsInteger := intQtdEti;

      ExecSQL;

    End;

  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fFiltraEstruturas: Boolean;
Var
  strDesIni: String;
  strDesFin: String;
  strLinGru: String;
  intQtdEti: Integer;
  blnMosFil: Boolean;

  strSQL: String;
Begin
  blnMosFil := False;
  intQtdEti := 0;

  Try
    pCriarFormularios(TfrmFiltroEtiEstruturas, frmFiltroEtiEstruturas);
    frmFiltroEtiEstruturas.ShowModal;

    strDesIni := frmFiltroEtiEstruturas.strDesIni;
    strDesFin := frmFiltroEtiEstruturas.strDesFin;
    strLinGru := frmFiltroEtiEstruturas.strLinGru;
    intQtdEti := frmFiltroEtiEstruturas.intQtdEti;
    blnMosFil := frmFiltroEtiEstruturas.chkMosFil.Checked;

    Result := frmFiltroEtiEstruturas.blnConfirma;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmImpEtiquetas.fFiltraEstruturas]');
    End;
  End;

  pFreeAndNil(frmFiltroEtiEstruturas);

  { ***************************************** }
  { * SE CANCELAR, SAI                      * }
  { **************************************LU* }
  If Not Result Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;
    pnlInfo.Caption := 'Aguarde...';

    fSetFiltraEstruturas(strDesIni, strDesFin, strLinGru, intQtdEti);

    strSQL := fRetornaSQLEstr;

    If blnMosFil Then
      strSQL := strSQL + fGetFiltrosEstruturas(strDesIni, strDesFin, strLinGru);

    strSQL := strSQL + '  ORDER BY ' + stlCampos[intIndBusca] +
      IIF(intIndBusca = 1, ', ITE_DESITE', '');

    With qryImpEti Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('VALBUS').AsString := '%';

      If blnMosFil Then
      Begin

        pSetParamsEstruturas(strDesIni, strDesFin, strLinGru);

      End;

      Open;
    End;

    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[ Filtro de Etiquetas de Estruturas ]');
    End;
  End;

End;

Function TfrmImpEtiquetas.fRetornaSQLUpdateEstr: String;
Var
  strUpdEstr: String;
Begin
  strUpdEstr := '';
  strUpdEstr := strUpdEstr + 'UPDATE ';
  strUpdEstr := strUpdEstr + '  GERMAT ';
  strUpdEstr := strUpdEstr + 'SET ';
  strUpdEstr := strUpdEstr + '  GMT_QTDETI = :GMT_QTDETI ';
  strUpdEstr := strUpdEstr + 'WHERE ';
  strUpdEstr := strUpdEstr + '  GMT_CODITE = :GMT_CODITE ';

  Result := strUpdEstr;
End;

Function TfrmImpEtiquetas.fRetornaSQLFiltroEstr: String;
Var
  strUpdEstr: String;
Begin
  strUpdEstr := '';
  strUpdEstr := strUpdEstr + 'UPDATE                     ';
  strUpdEstr := strUpdEstr + '  GERMAT                   ';
  strUpdEstr := strUpdEstr + '  INNER JOIN CADITE ON ITE_CODITE = GMT_CODITE ';
  strUpdEstr := strUpdEstr + '  INNER JOIN CADGRU ON GRU_CODGRU = ITE_CODGRU ';

  strUpdEstr := strUpdEstr + 'SET                        ';
  strUpdEstr := strUpdEstr + '  GMT_QTDETI = :GMT_QTDETI ';
  strUpdEstr := strUpdEstr + 'WHERE                      ';
  strUpdEstr := strUpdEstr + '  TRUE                     ';

  Result := strUpdEstr;
End;

Function TfrmImpEtiquetas.fRetornaSQLDesmarcaEstr: String;
Var
  strUpdEstr: String;
Begin
  strUpdEstr := '';
  strUpdEstr := strUpdEstr + 'UPDATE ';
  strUpdEstr := strUpdEstr + '  GERMAT ';
  strUpdEstr := strUpdEstr + 'SET ';
  strUpdEstr := strUpdEstr + '  GMT_QTDETI = :QTDETI ';

  Result := strUpdEstr;
End;

Procedure TfrmImpEtiquetas.rdbTermicaClick(Sender: TObject);
Begin
  Inherited;
  strCfgTipEti := 'A';
End;

Procedure TfrmImpEtiquetas.rdgSaldosClick(Sender: TObject);
Begin
  Inherited;
  pnlInfo.Caption := 'Aguarde...';
  Screen.Cursor := crHourGlass;

  If intTipEti = ETI_ITENS Then
  Begin
    pAbreItens;
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
  End;

  Screen.Cursor := crDefault;
  pnlInfo.Caption := '';
End;

Procedure TfrmImpEtiquetas.rdgStatusClick(Sender: TObject);
Begin
  Inherited;

  pnlInfo.Caption := 'Aguarde...';
  Screen.Cursor := crHourGlass;

  If intTipEti = ETI_ITENS Then
  Begin
    pAbreItens;
    TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);
  End
  Else If intTipEti = ETI_CLIENTES Then
    pAbreClientes;

  Screen.Cursor := crDefault;
  pnlInfo.Caption := '';

End;

procedure TfrmImpEtiquetas.tmrDesmarcaTodosTimer(Sender: TObject);
begin
  inherited;
  tmrDesmarcaTodos.Enabled := False;
  pDesmarcarTodos(0);
  If (intTipEti = ETI_ITENS) Then
     TCfgColEtiqItens.pIniciar(dbgEtiquetas, dbgEtiquetasTableView);

end;

procedure TfrmImpEtiquetas.qryItemOnBeforePost(DataSet: TDataSet);
  var
    qryDelete: TUniQuery;
begin
 If intTipEti = ETI_ITENS Then
 Begin

  If qryImpEti.FieldByName(strCamQtd).AsInteger > 1000 Then
   Begin
     fMensagem('ATENÇÃO', 'A quantidade de etiquetas deve ser igual ou inferior a 1000!', ['&Ok']);
     qryImpEti.Cancel;
     Exit;
   End;

   Try
     qryDelete := fCriaQuery;
     qryDelete.SQL.Text := 'DELETE FROM ITEETI WHERE ETI_CODOPE = :CODOPE AND ETI_CODITE = :CODITE';
     qryDelete.ParamByName('CODITE').AsString := qryImpEti.FieldByName('ITE_CODITE').AsString;
     qryDelete.ParamByName('CODOPE').AsString := qryImpEti.FieldByName('ITE_CODOPE').AsString;
     qryDelete.ExecSQL;
   Finally
     FreeAndNil(qryDelete)
   End;
 End;
end;

Procedure TfrmImpEtiquetas.rdbMatricialClick(Sender: TObject);
Begin
  Inherited;
  strCfgTipEti := 'M';
End;

Procedure TfrmImpEtiquetas.edtPercentDescontoExit(Sender: TObject);
Begin
  Inherited;
  fValidaCampos(edtPercentDesconto, False);
End;

Procedure TfrmImpEtiquetas.pQtdeEtiquetaCliente(strSQL, strValBus: String;
  strNomIni: String = ''; strNomFin: String = ''; strCodVen: String = '';
  strCodAti: String = ''; strCodCid: String = ''; strBairro: String = '';
  strEstado: String = ''; strStatus: String = ''; strAniIni: String = '';
  strAniFin: String = ''; strCodCli: String = ''; strCodCac: String = '';
  strCodReg: String = ''; strRevist: String = ''; strSexo__: String = '';
  strCGCCPF: String = ''; strTipCli: String = ''; strConFin: String = '');

Var
  strSQLEti: String;
  strLinVen: String;
  strLinAti: String;
  strLinCid: String;
  strLinCac: String;
  strLinReg: String;
  qryTotEti: TUniQuery;
Begin

  Try

    qryTotEti := fCriaQuery(Nil);

    strSQLEti := '';
    strSQLEti := strSQLEti + 'SELECT ';
    strSQLEti := strSQLEti + '  SUM(CLI_QTDETI) AS TOTETI ';
    strSQLEti := strSQLEti + strSQLAux;

    With qryTotEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLEti);

      ParamByName('VALBUS').AsString := strValBus;

      If Not fEmptyStr(strNomIni) Then
      Begin
        If Length(strNomIni) > Length(strNomFin) Then
          ParamByName('MAIOR').AsString := strNomIni
        Else
          ParamByName('MAIOR').AsString := strNomFin;

        ParamByName('NOMINI').AsString := strNomIni;
        ParamByName('NOMFIN').AsString := strNomFin;
      End;

      If Not fEmptyStr(strCodVen) Then
      Begin
        pSetaParam(frmFiltroEtiClientes.edtCodVen.Text,
          frmFiltroEtiClientes.arrVendedor, strLinVen, 'CODVEN', qryImpEti);
      End;

      If Not fEmptyStr(strCodAti) Then
      Begin
        pSetaParam(frmFiltroEtiClientes.edtCodAti.Text,
          frmFiltroEtiClientes.arrAtividade, strLinAti, 'CODATI', qryImpEti);
      End;

      If Not fEmptyStr(strCodCid) Then
      Begin
        pSetaParam(frmFiltroEtiClientes.edtCodCid.Text,
          frmFiltroEtiClientes.arrCidade, strLinCid, 'CODCID', qryImpEti);
      End;

      { ****************************************** }
      { * ACRESCENTOU FILTRO POR CANAL DE ACESSO * }
      { ***************************************DP* }
      If Not fEmptyStr(strCodCac) Then
      Begin
        pSetaParam(frmFiltroEtiClientes.edtCodCac.Text,
          frmFiltroEtiClientes.arrCanal, strLinCac, 'CODCAC', qryImpEti);
      End;

      { ****************************************** }
      { * ACRESCENTOU FILTRO POR REGIAO          * }
      { ***************************************AC* }
      If Not fEmptyStr(strCodReg) Then
      Begin
        pSetaParam(frmFiltroEtiClientes.edtCodReg.Text,
          frmFiltroEtiClientes.arrRegiao, strLinReg, 'CODREG', qryImpEti);
      End;

      If Not fEmptyStr(strRevist) Then
      Begin
        ParamByName('REVIST').AsString := strRevist;
      End;

      If Not fEmptyStr(strSexo__) And CharInSet(strSexo__[1], ['M', 'F']) Then
      Begin
        ParamByName('SEXO__').AsString := strSexo__;
      End;

      If Not fEmptyStr(strBairro) Then
      Begin
        ParamByName('BAIRRO').AsString := strBairro;
      End;

      If Not fEmptyStr(strEstado) Then
      Begin
        ParamByName('ESTADO').AsString := strEstado;
      End;

      Case rdgStatus.ItemIndex Of
        0:
          ParamByName('STATUS').AsString := '%A';
        1:
          ParamByName('STATUS').AsString := '%I';
        2:
          ParamByName('STATUS').AsString := '%';
      End;

      { ********************************************* }
      { * FILTRO DE PESSOA JURÍDICA / PESSOA FÍSICA * }
      { ******************************************MA* }

      If Not fEmptyStr(strCGCCPF) Then
      Begin
        ParamByName('CGCCPF').AsString := strCGCCPF;
      End;

      If (Not fEmptyStr(fTiraCaracEspeciais(strAniIni))) Then
      Begin
        ParamByName('ANIINI').AsDateTime := StrToDate(strAniIni);
        ParamByName('ANIFIN').AsDateTime := StrToDate(strAniFin);
      End;

      { ************************************************* }
      { * FILTROS DE TIPO DE CLIENTE / CONSUMIDOR FINAL * }
      { **********************************************CG* }
      If Not fEmptyStr(strTipCli) Then
      Begin
        ParamByName('TIPCLI').AsString := strTipCli;
      End;

      If Not fEmptyStr(strConFin) Then
      Begin
        If strConfin <> 'T' Then
          ParamByName('CONFIN').AsString := strConFin;
      End;

      Open;

      If (FieldByName('TOTETI').AsInteger = 0) Then
        edtTotEti.Text := '0'
      Else
        edtTotEti.Text := FieldByName('TOTETI').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImpEtiquetas.pQtdeEtiquetaCliente]');
  End;

  FreeAndNil(qryTotEti);
End;

Procedure TfrmImpEtiquetas.pQtdeEtiquetaFornecedor(strSQL, strValBus: String;
  strNomIni: String = ''; strNomFin: String = ''; strCodAti: String = '';
  strCodCid: String = ''; strBairro: String = ''; strEstado: String = '';
  strRevist: String = '');
Var
  strSQLEti: String;
  qryTotEti: TUniQuery;
Begin

  Try

    qryTotEti := fCriaQuery(Nil);

    strSQLEti := '';
    strSQLEti := strSQLEti + 'SELECT ';
    strSQLEti := strSQLEti + '  SUM(FOR_QTDETI) AS TOTETI ';
    strSQLEti := strSQLEti + strSQLAux;

    With qryTotEti Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQLEti);

      ParamByName('VALBUS').AsString := strValBus;

      If Not fEmptyStr(strNomIni) Then
      Begin
        If Length(strNomIni) > Length(strNomFin) Then
          ParamByName('MAIOR').AsString := strNomIni
        Else
          ParamByName('MAIOR').AsString := strNomFin;

        ParamByName('NOMINI').AsString := strNomIni;
        ParamByName('NOMFIN').AsString := strNomFin;
      End;

      If Not fEmptyStr(strCodAti) Then
      Begin
        ParamByName('CODATI').AsString := strCodAti;
      End;

      If Not fEmptyStr(strCodCid) Then
      Begin
        ParamByName('CODCID').AsString := strCodCid;
      End;

      If Not fEmptyStr(strBairro) Then
      Begin
        ParamByName('BAIRRO').AsString := strBairro;
      End;

      If Not fEmptyStr(strEstado) Then
      Begin
        ParamByName('ESTADO').AsString := strEstado;
      End;

      If Not fEmptyStr(strRevist) Then
      Begin
        ParamByName('REVIST').AsString := strRevist;
      End;

      Open;

      If (FieldByName('TOTETI').AsInteger = 0) Then
        edtTotEti.Text := '0'
      Else
        edtTotEti.Text := FieldByName('TOTETI').AsString;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmImpEtiquetas.pQtdeEtiquetaFornecedor]');
  End;

  FreeAndNil(qryTotEti);
End;

Procedure TfrmImpEtiquetas.pHabilitaTela(blnHabili: Boolean);
Begin
  pnlBotoesImp.Enabled := blnHabili;
  pnlBusca.Enabled := blnHabili;
  Self.blnHabili := blnHabili;
  dbgEtiquetas.Enabled := blnHabili;
End;

function TfrmImpEtiquetas.fRetornaCorPromocional: integer;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  try

    Result := 0;

    strSQL := 'SELECT SIT_CODCOR FROM SITITE WHERE SIT_SITUAC = "ITEM EM PROMOÇÃO"';

    qryGen := fCriaQuery;
    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.Open;

    if not qryGen.isEmpty then
      Result := qryGen.FieldByName('SIT_CODCOR').asinteger;

  finally
    FreeAndNil(qryGen);
  end;

end;



Function TfrmImpEtiquetas.fLimpaMarcadosCli: Boolean;
Var
  qryGen: TUniQuery;
  strSQL: String;
Begin
  Try
    Result := True;

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CADCLI ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CLI_QTDETI = :QTDETI ';

    qryGen := fCriaQuery;
    With qryGen Do
    Begin
      Close;
      SQL.Text := strSQL;
      ParamByName('QTDETI').Clear;
      ExecSQL;
    End;
    FreeAndNil(qryGen);
  Except
    Result := False;
  End;
End;

Function TfrmImpEtiquetas.fPrimeiraTabPreco: String;
Begin
  Result := IntToStr(Pos('S', VS_strTabPrc));
End;

function TfrmImpEtiquetas.fProdutoSelPromo: Boolean;
var
  qrySelPro: TUniQuery;
begin
  Result := False;
  Try
    qrySelPro := fCriaQuery(Nil);

    // Verifico se as etiquetas selecionadas estão em promoção
    qrySelPro.Close;
    qrySelPro.SQL.Clear;
    qrySelPro.SQL.Add(' SELECT ETI_QTDETI, ');
    qrySelPro.SQL.Add('  IF(( SELECT COUNT(ITEPRO.IPR_CODITE) AS QTD ');
    qrySelPro.SQL.Add('       FROM ITEPRO ');
    qrySelPro.SQL.Add('      INNER JOIN CADPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ');
    qrySelPro.SQL.Add('      INNER JOIN PROEMP ON PROEMP.PRO_SEQGER = CADPRO.AUTOINCREM ');
    qrySelPro.SQL.Add('      WHERE '+QuotedStr(FormatDateTime('yyyymmdd', fNow()))+' BETWEEN CADPRO.PRO_DTAINI AND CADPRO.PRO_DTAFIN ');
    qrySelPro.SQL.Add('        AND ITEPRO.IPR_CODITE = CADITE.ITE_CODITE AND PROEMP.PRO_CODEMP = ITEGER.ITE_CODEMP ) > 0, "S", "N") AS EPROMO ');
    qrySelPro.SQL.Add('FROM CADITE ');
    qrySelPro.SQL.Add('   LEFT JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ');
    qrySelPro.SQL.Add('   LEFT JOIN CADEMP ON ITEGER.ITE_CODEMP = CADEMP.EMP_CODEMP ');
    qrySelPro.SQL.Add('   LEFT JOIN ITEETI ON ETI_CODITE = CADITE.ITE_CODITE AND ETI_CODOPE = ' + QuotedStr(strLoginUsuarioLogado));
    qrySelPro.SQL.Add(' WHERE ETI_QTDETI > 0 AND ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp));
    qrySelPro.Open;

    qrySelPro.First;
    While Not qrySelPro.Eof Do
    Begin
      If (qrySelPro.FieldByName('EPROMO').AsString = 'S') Then
      Begin
        Result := True;
        Break;
      End;
      qrySelPro.Next;
    End;

  Finally
    FreeAndNil(qrySelPro);
  End;
end;

Function TfrmImpEtiquetas.fLoteCriptografado: String;
Begin
  Result := RightStr(IntToStr(YearOf(VS_Date)), 2);
  Result := Result + IntToStr(WeekOfTheYear(YearOf(VS_Date)));
  Result := Result + fDiaSemanaAlfabeto;
End;

function TfrmImpEtiquetas.fSelecaoTipoEtiquetaCliente: Boolean;
var
  ArrNomEti : TStringArray;
  qryLay: TUniQuery;
begin
  Result := True;
  strCodLayEtqCliente := '';

  If (fCfgSis('ETICLI') = 'S') Then
  Begin
    SetLength(ArrNomEti, 0);
    pAddDados(ArrNomEti, 'Argox');
    pAddDados(ArrNomEti, 'Laser');
    pAddDados(ArrNomEti, 'Matricial');
    Case fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True) Of
      1: tpeTipEtqCliente := tpeClienteArgox;
      2: tpeTipEtqCliente := tpeClienteLaser;
      3: tpeTipEtqCliente := tpeClienteMatricial;
    Else
      Begin
        Result := False;
        Exit;
      End
    End;
  end
  Else If fCfgSis('ETICLI') = 'A' Then
    tpeTipEtqCliente := tpeClienteArgox
  Else If fCfgSis('ETICLI') = 'L' Then
    tpeTipEtqCliente := tpeClienteLaser
  Else
    tpeTipEtqCliente := tpeClienteMatricial;

  If (tpeTipEtqCliente in [tpeClienteLaser, tpeClienteArgox]) Then
  Begin
    qryLay := fCriaQuery(Nil);
    Try
      qryLay.Close;
      qryLay.SQL.Clear;
      qryLay.SQL.Add('SELECT');
      qryLay.SQL.Add('  LAY_NOMLAY, LAY_CODLAY, LAY_DESCRI');
      qryLay.SQL.Add('FROM');
      qryLay.SQL.Add('  LAYETI');
      qryLay.SQL.Add('WHERE LAY_TIPLAY = :TIPLAY');
      qryLay.SQL.Add('  AND ((LAY_PADRAO = "S") OR (LAY_OPCION = "S"))');
      qryLay.SQL.Add('ORDER BY LAY_PADRAO DESC');
      qryLay.ParamByName('TIPLAY').AsInteger := ARR_TIPO_LAYOUT[tpeTipEtqCliente];
      qryLay.Open;

      If (qryLay.RecordCount > 1) then
      Begin
        SetLength(ArrNomEti, 0);
        qryLay.First;
        While not qryLay.Eof do
        Begin
          pAddDados(ArrNomEti, qryLay.FieldByName('LAY_NOMLAY').AsString+' - '+
                               qryLay.FieldByName('LAY_CODLAY').AsString+' - '+
                               qryLay.FieldByName('LAY_DESCRI').AsString);
          qryLay.Next;
        End;

        qryLay.RecNo := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True, False, 200);
        strCodLayEtqCliente := qryLay.FieldByName('LAY_CODLAY').AsString;
      End;

      qryLay.Close;
    Finally
      FreeAndNil(qryLay);
    end;
  End;

end;

procedure TfrmImpEtiquetas.OnCxEditValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  Var
    strValue : String;
begin
  try
    strValue := VarToStr(DisplayValue);
    If fEmptyStr(strValue) Then
      Exit;
    StrToInt(strValue);
  except
    on E: EConvertError do
    begin
      ErrorText := 'Digite apenas números inteiros';
      Error := True;
      pMensagemOK(ErrorText);
      Exit;
    end;
  end;
end;

End.

