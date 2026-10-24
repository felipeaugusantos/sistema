{***************************}
{* qryConCid -> CADCID     *}
{* qryConCli -> CADCLI     *}
{* qryConFor -> CADFOR     *}
{* qryConCfo -> CADCFO     *}
{************************JB*}
{***************************}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadEmpresas;

interface

uses
  Windows, Classes, Controls, Forms, Dialogs, StdCtrls, untPaiCad, ComCtrls,
  Buttons, ExtCtrls, Mask, Uni, DBCtrls, DBEditFocus, DB, QColorLabel, Menus,
  EditFocus, AppEvnts, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxControls, cxGridCustomView, cxGrid,
  cxEditRepositoryItems, cxDBEditRepository, UniDataSetProvider, UniClientDataSet,
  untConstantes, Grids, DBGridCitel, DBGrids, cxGridBandedTableView, cxCheckBox,
  cxGridDBBandedTableView, untDBECgcCpf, untLabelCgc, untFuncoesGenerica,
  untZClient, untLabelRg, untMskC_G_C_, untEditTipoCgcCpf, untLabelCpf,
  BitBtnLockedIncrem, DBComboBoxFocus, cxTextEdit, untEmpFor,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, MemDS, DBAccess, Provider, MaskEditFocus,
  frxClass, frxExportCSVTestabilidade, cxProgressBar, untEmpTri, Datasnap.DBClient, ComboBoxFocus,
  System.UITypes, System.UIConsts, Winapi.ShellAPI,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxSpinEdit, untCadEmpresasHeranca,
  untFramePlanoDeContasDBEditFocus, System.DateUtils, cxRadioGroup, cxCalc,
  cxContainer, cxMaskEdit, cxDropDownEdit, cxCurrencyEdit, CurrencyEditFocus,
  cxLabel, cxGridCitel, cxGroupBox, untTControlaCustoDefinidosNaEmpresa,
  cxImage, untImagens, untFuncoesImagem, cxButtons, untCadMetasEmpresaFrame,
  cxCalendar, dxCore, cxDateUtils;

type
  TfrmCadEmpresas = class(TfrmPaiCad)
    cldCores: TColorDialog;
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    ColorLabel2: TColorLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label25: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    ColorLabel5: TColorLabel;
    Label33: TLabel;
    Label34: TLabel;
    lblNomFan: TLabel;
    edtNomCli: TEditFocus;
    dbeCodEmp: TDBEditFocus;
    dbeNomEmp: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    dbeEndNum: TDBEditFocus;
    dbeBairro: TDBEditFocus;
    dbeEndCmp: TDBEditFocus;
    dbeCidade: TDBEditFocus;
    dbeNumCEp: TDBEditFocus;
    dbeEmail: TDBEditFocus;
    dbeHomepa: TDBEditFocus;
    dbeInsEst: TDBEditFocus;
    dbeFone01: TDBEditFocus;
    dbeFone02: TDBEditFocus;
    dbeNumFax: TDBEditFocus;
    dbePreMat: TDBEditFocus;
    dbeCliFil: TDBEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    edtNomFor: TEditFocus;
    dbeForFil: TDBEditFocus;
    dbeEmailC: TDBEditFocus;
    dbeJucEsp: TDBEditFocus;
    dbeDtaDsp: TDBEditFocus;
    dbeUsaRep: TDBEditFocus;
    dbeNum_IP: TDBEditFocus;
    dbeCorFun: TDBEditFocus;
    dbeNomFan: TDBEditFocus;
    tbsConEmp: TTabSheet;
    qryConEmp: TUniQuery;
    dtsConEmp: TDataSource;
    qryCadEmp: TUniQuery;
    cxRepositorio: TcxEditRepository;
    cxrTipOpe: TcxEditRepositoryRadioGroupItem;
    cxrEmpDes: TcxEditRepositoryLookupComboBoxItem;
    dtsCadEmp: TDataSource;
    cdsConEmp: TUniClientDataSet;
    dspConEmp: TUniDataSetProvider;
    cxStyleRepositorio: TcxStyleRepository;
    cxStyleSelecao: TcxStyle;
    tbsQuaSoc: TTabSheet;
    pnlCabecalho: TPanel;
    dbgSocios: TDBGridCitel;
    Label26: TLabel;
    edtNomSoc: TEditFocus;
    edtNumR_G: TEditFocus;
    dtsSocios: TDataSource;
    cdsSocios: TUniClientDataSet;
    cdsSociosSOC_NOMSOC: TStringField;
    cdsSociosSOC_NUMR_G: TStringField;
    cdsSociosSOC_NUMCPF: TStringField;
    Label43: TLabel;
    dbeSigla: TDBEditFocus;
    GroupBox4: TGroupBox;
    Label44: TLabel;
    Label45: TLabel;
    dbeInvLiv: TDBEditFocus;
    dbeInvPag: TDBEditFocus;
    cdsSociosSOC_CIDSOC: TStringField;
    cdsSociosSOC_ORGEMI: TStringField;
    cdsSociosSOC_PROFIS: TStringField;
    cdsSociosSOC_ESTCIV: TStringField;
    cdsSociosSOC_CGCCPF: TIntegerField;
    cdsSociosSOC_NOMCID: TStringField;
    cdsSociosSOC_ESTADO: TStringField;
    lblTipCgc: TLabel;
    Label35: TLabel;
    edtOrgEmissor: TEditFocus;
    lbl2: TLabel;
    lbl3: TLabel;
    edtTRI_INIATV: TcxDateEdit;
    cdsFormTribTRI_INIATV: TDateField;
    GridFormaTributacaoTableViewTRI_INIATV: TcxGridDBColumn;
    edtDesCidSoc: TEditFocus;
    edtCidSoc: TEditFocus;
    edtEstadoSoc: TEditFocus;
    lbl4: TLabel;
    edtProfissao: TEditFocus;
    lbl5: TLabel;
    lbl6: TColorLabel;
    edtEstCivil: TEditFocus;
    lbl7: TLabel;
    dbeInsMun: TDBEditFocus;
    Label46: TLabel;
    dtsTabela: TDataSource;
    Label47: TLabel;
    dbeCNAE: TDBEditFocus;
    cxrSimNao: TcxEditRepositoryCheckBoxItem;
    lblCodMat: TLabel;
    dbeCodMat: TDBEditFocus;
    edtNomMat: TEditFocus;
    tbsCfgFin: TTabSheet;
    cxgFinEmp: TcxGrid;
    cxgFinEmpLevel1: TcxGridLevel;
    cxgFinEmpeView: TcxGridDBBandedTableView;
    cxgFinEmpeViewColumn2: TcxGridDBBandedColumn;
    cxgFinEmpeViewColumn3: TcxGridDBBandedColumn;
    cxgFinEmpeViewColumn5: TcxGridDBBandedColumn;
    cxrCadCta: TcxEditRepositoryLookupComboBoxItem;
    dtsCadCta: TDataSource;
    cxgFinEmpeViewColumn1: TcxGridDBBandedColumn;
    Label41: TLabel;
    dbeImpCTP: TDBEditFocus;
    ColorLabel6: TColorLabel;
    LabelCgc1: TLabelCgc;
    dbeNumCgc: TDBEditCgcCpf;
    pnlCgcCpf: TPanel;
    edtCgcCpf: TEditTipoCgcCpf;
    mskNumCpf: TMaskEditC_G_C_;
    LabelRg1: TLabelRg;
    lblCgcCpf: TLabelCpf;
    grbDac: TGroupBox;
    dbeFoneDa1: TDBEditFocus;
    dbeFoneDa2: TDBEditFocus;
    Label14: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    dbeEmailV: TDBEditFocus;
    dbeContSintegra: TDBEditFocus;
    Label39: TLabel;
    btnTintas: TBitBtnLocked;
    btnAdicionarSoc: TBitBtnLocked;
    TabSheet1: TTabSheet;
    cxStyle1: TcxStyle;
    tbsImpPre: TTabSheet;
    tbsForPre: TTabSheet;
    pnlForPre: TPanel;
    btnExcFor: TBitBtnLocked;
    cxgForPre: TcxGrid;
    cxgForPreView: TcxGridDBTableView;
    cxgForPreCODFOR: TcxGridDBColumn;
    cxgForPreNOMFOR: TcxGridDBColumn;
    cxgForPreLevel1: TcxGridLevel;
    cxrUltPis: TcxEditRepositoryCheckBoxItem;
    cxrUltICM: TcxEditRepositoryCheckBoxItem;
    cxrFat_TE: TcxEditRepositoryCurrencyItem;
    tbsInsSub: TTabSheet;
    cxgInsSub: TcxGrid;
    cxgInsSubView: TcxGridDBBandedTableView;
    cxgInsSubViewINSSUB: TcxGridDBBandedColumn;
    cxgInsSubLevel: TcxGridLevel;
    cxgInsSubViewESTADO: TcxGridDBBandedColumn;
    cxrEstados: TcxEditRepositoryImageComboBoxItem;
    cxsHeader: TcxStyle;
    btnCreditos: TBitBtnLocked;
    lblWms: TLabel;
    dbeUtiWMS: TDBEditFocus;
    lblWmsSN: TColorLabel;
    dbeNSRBru: TDBEditFocus;
    lblNSRBru: TLabel;
    tbsAnaliseResult: TTabSheet;
    pgcRegTrib: TPageControl;
    tbsLucroReal: TTabSheet;
    pnlTopo: TPanel;
    cbxRegTrib: TComboBoxFocus;
    Label52: TLabel;
    pnlLucroReal: TPanel;
    Label69: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    tbsLucroPresumido: TTabSheet;
    tbsSimplesNacional: TTabSheet;
    Label70: TLabel;
    ColorLabel28: TColorLabel;
    dbeLrPisL: TDBEditFocus;
    cbxLrJurR: TComboBoxFocus;
    cbxLrDesR: TComboBoxFocus;
    dbeLrCofL: TDBEditFocus;
    ColorLabel1: TColorLabel;
    dbeLrIcmL: TDBEditFocus;
    ColorLabel3: TColorLabel;
    dbeLrIpiL: TDBEditFocus;
    ColorLabel7: TColorLabel;
    dbeLrRetL: TDBEditFocus;
    ColorLabel8: TColorLabel;
    dbeLrFreL: TDBEditFocus;
    ColorLabel9: TColorLabel;
    pnlLucroPresumido: TPanel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    ColorLabel12: TColorLabel;
    ColorLabel13: TColorLabel;
    ColorLabel14: TColorLabel;
    ColorLabel15: TColorLabel;
    dbeLpAlqI: TDBEditFocus;
    cbxLpJurR: TComboBoxFocus;
    cbxLpDesR: TComboBoxFocus;
    dbeLpAlqC: TDBEditFocus;
    dbeLpPisL: TDBEditFocus;
    dbeLpCofL: TDBEditFocus;
    dbeLpIcmL: TDBEditFocus;
    dbeLpIpiL: TDBEditFocus;
    Label81: TLabel;
    Label82: TLabel;
    dbeLpRetL: TDBEditFocus;
    ColorLabel16: TColorLabel;
    dbeLpFreL: TDBEditFocus;
    ColorLabel17: TColorLabel;
    Label83: TLabel;
    Label84: TLabel;
    pnlSimplesNacional: TPanel;
    Label85: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    ColorLabel10: TColorLabel;
    ColorLabel11: TColorLabel;
    ColorLabel18: TColorLabel;
    ColorLabel19: TColorLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    dbeSnAlqF: TDBEditFocus;
    cbxSnJurR: TComboBoxFocus;
    cbxSnDesR: TComboBoxFocus;
    dbeSnIcmL: TDBEditFocus;
    dbeSnIpiL: TDBEditFocus;
    dbeSnRetL: TDBEditFocus;
    dbeSnFreL: TDBEditFocus;
    dsRegTri: TDataSource;
    btnReplicaRegTrib: TBitBtnLocked;
    lblCrmCli: TLabel;
    dbeCrmCli: TDBEditFocus;
    dbeCrmPro: TDBEditFocus;
    lblCrmPro: TLabel;
    dbeCrmFor: TDBEditFocus;
    lblCrmFor: TLabel;
    tbsPerERF: TTabSheet;
    cxgPerERF: TcxGrid;
    cxgPerERFView: TcxGridDBBandedTableView;
    NOMDES: TcxGridDBBandedColumn;
    PERENT: TcxGridDBBandedColumn;
    PERRET: TcxGridDBBandedColumn;
    EMPDES: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    PERFUT: TcxGridDBBandedColumn;
    cxlTeprev: TcxEditRepositoryLookupComboBoxItem;
    qryTeprev: TUniQuery;
    dtsTeprev: TDataSource;
    qryTepPro: TUniQuery;
    dtsTepPro: TDataSource;
    cxlTeppro: TcxEditRepositoryLookupComboBoxItem;
    Label91: TLabel;
    ColorLabel20: TColorLabel;
    dbeExiApp: TDBEditFocus;
    tbsContabilidade: TTabSheet;
    dbeCodBan: TDBEditFocus;
    edtDesBan: TEditFocus;
    Label102: TLabel;
    Label104: TLabel;
    dbeNumIPSec: TDBEditFocus;
    clbCoresIdentificacaoEmpresa: TColorBox;
    lblCoresIdentificacaoEmpresa: TLabel;
    lblPortador: TLabel;
    dbeCodPor: TDBEditFocus;
    edtDesPor: TEditFocus;
    spbDicaPortador: TSpeedButton;
    btnCertificadoDigital: TBitBtnLocked;
    fraPlanoDeContasCtp: TfraPlanoDeContasDBEditFocus;
    pnlCertificadoDigital: TPanel;
    Label107: TLabel;
    dbeLrCFFD: TDBEditFocus;
    ColorLabel21: TColorLabel;
    Label108: TLabel;
    dbeLpCFFD: TDBEditFocus;
    ColorLabel22: TColorLabel;
    Label109: TLabel;
    dbeSnCFFD: TDBEditFocus;
    ColorLabel23: TColorLabel;
    FileOpenCertificadoPFX: TFileOpenDialog;
    lblConsultaPix: TLabel;
    dbeConsultaPix: TDBEditFocus;
    lblConsultaPixSN: TColorLabel;
    lblRedCarLig: TLabel;
    dbeALQCLI: TDBEditFocus;
    lblSimbolRedCarLiq: TLabel;
    tbsCat42: TTabSheet;
    pnlCat42: TPanel;
    Label110: TLabel;
    dbeSomaFatCAT42: TDBEditFocus;
    ColorLabel24: TColorLabel;
    grbValoresAprovCAT42: TGroupBox;
    Label111: TLabel;
    cxGridEmpCat: TcxGrid;
    cxGridEmpCatDBView: TcxGridDBTableView;
    cxGridEmpCatView: TcxGridLevel;
    mskAnoCat: TMaskEditFocus;
    dtsEmpCat: TDataSource;
    cdsEmpCat: TUniClientDataSet;
    cdsEmpCatAUTOINCREM: TStringField;
    cdsEmpCatCAT_CODEMP: TStringField;
    cdsEmpCatCAT_NUMANO: TIntegerField;
    cdsEmpCatCAT_NUMMES: TIntegerField;
    cdsEmpCatCAT_TOTVAL: TFloatField;
    cxGridEmpCatDBViewMesAno: TcxGridDBColumn;
    cxGridEmpCatDBViewValor: TcxGridDBColumn;
    cdsEmpCatIDF_STATUS: TStringField;
    cdsEmpCatMESANO: TStringField;
    cdsFormTrib: TUniClientDataSet;
    cdsFormTribTRI_CODEMP: TStringField;
    cdsFormTribTRI_ANOEXE: TIntegerField;
    cdsFormTribTRI_FORMTR: TStringField;
    cdsFormTribTRI_ENCERR: TStringField;
    cdsFormTribTRI_VALBAS: TFloatField;
    cdsFormTribTRI_VLIRPJ: TFloatField;
    cdsFormTribTRI_ADIRPJ: TFloatField;
    cdsFormTribTRI_VLCSLL: TFloatField;
    dsFormTrib: TDataSource;
    gbFormaTributacao: TcxGroupBox;
    GridFormaTributacao: TcxGridCitel;
    GridFormaTributacaoTableView: TcxGridDBTableViewCitel;
    GridFormaTributacaoTableViewTRI_CODEMP: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_ANOEXE: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_FORMTR: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_ENCERR: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_VALBAS: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_VLIRPJ: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_ADIRPJ: TcxGridDBColumn;
    GridFormaTributacaoTableViewTRI_VLCSLL: TcxGridDBColumn;
    GridFormaTributacaoLevel: TcxGridLevel;
    gbFormaTributacaoCampos: TPanel;
    cxLabel1: TcxLabel;
    edtTRI_ANOEXE: TEditFocus;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edtTRI_VALBAS: TCurrencyEditFocus;
    cxGroupBox1: TcxGroupBox;
    cxLabel5: TcxLabel;
    edtTRI_VLIRPJ: TCurrencyEditFocus;
    cxLabel6: TcxLabel;
    edtTRI_ADIRPJ: TCurrencyEditFocus;
    cxLabel7: TcxLabel;
    edtTRI_VLCSLL: TCurrencyEditFocus;
    btnConfirmaFormaTrib: TBitBtnLocked;
    edtTRI_FORMTR: TcxComboBox;
    edtTRI_ENCERR: TcxComboBox;
    btnCancelarFormaTrib: TBitBtnLocked;
    cdsEmpCatCAT_TOTVA2: TFloatField;
    cxGridEmpCatDBViewCAT_TOTVA2: TcxGridDBColumn;
    gbCamposContabilidade: TcxGroupBox;
    Label101: TLabel;
    Label106: TLabel;
    dbeTplAco: TDBEditFocus;
    dbeNatJur: TDBEditFocus;
    edtDescricaoDoTipoDePlanoDeContaContabil: TEditFocus;
    edtDescricaoNaturezaJuridica: TEditFocus;
    grbGerarPedidoTEs: TGroupBox;
    lblGerarPedidoCompraTEDestino: TLabel;
    lblGerarPedidoCompraTEDestinoColor: TColorLabel;
    lblGerarPedidoCompraTEOrigem: TLabel;
    lblGerarPedidoCompraTEOrigemColor: TColorLabel;
    dbeGerCmp: TDBEditFocus;
    dbeGerOri: TDBEditFocus;
    pnlDadosCusto: TPanel;
    Label53: TLabel;
    Label54: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label66: TLabel;
    lblDesOpePer: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    dbeIcmEnt: TDBEditFocus;
    dbeSubFed: TDBEditFocus;
    dbeIcmSai: TDBEditFocus;
    dbeImpFed: TDBEditFocus;
    dbeDesOpe: TDBEditFocus;
    dbeTabPad: TDBComboBoxFocus;
    dbeMarPad: TDBEditFocus;
    pnlImgEmp: TPanel;
    lblErrImg: TLabel;
    imgEmp: TcxImage;
    btnENotas: TBitBtnLocked;
    tbsContabilista: TTabSheet;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    dbeNomeContab: TDBEditFocus;
    dbeCpfContab: TDBEditFocus;
    dbeCrcContab: TDBEditFocus;
    dbeCnpjContab: TDBEditFocus;
    dbeEndContab: TDBEditFocus;
    dbeComplContab: TDBEditFocus;
    dbeFoneContab: TDBEditFocus;
    dbeEmailContab: TDBEditFocus;
    dbeNumEndContab: TDBEditFocus;
    dbeCepContab: TDBEditFocus;
    dbeFaxContab: TDBEditFocus;
    dbeBairroContab: TDBEditFocus;
    dbeIbgeCidCtb: TDBEditFocus;
    edtCidContab: TEditFocus;
    edtEstContab: TEditFocus;
    PERTRE: TcxGridDBBandedColumn;
    pnlLegeda: TPanel;
    lblLegen1: TLabel;
    lblLegen2: TLabel;
    dlgArquivoExcel: TOpenDialog;
    Label115: TLabel;
    dbeEmpAti: TDBEditFocus;
    ColorLabel4: TColorLabel;
    PERMLJ: TcxGridDBBandedColumn;
    fraCadMetasEmpresa: TfraCadMetasEmpresaFrame;
    cxgInsSubViewCADSIM: TcxGridDBBandedColumn;
    Label40: TLabel;
    cbxLpJurP: TComboBoxFocus;
    Label48: TLabel;
    cbxLpDesO: TComboBoxFocus;
    Label51: TLabel;
    cbxSnJurP: TComboBoxFocus;
    Label116: TLabel;
    cbxSnDesO: TComboBoxFocus;
    Label125: TLabel;
    cbxLrJurP: TComboBoxFocus;
    Label130: TLabel;
    cbxLrDesO: TComboBoxFocus;
    pgcTransfEstoque: TPageControl;
    tbsClaSai: TTabSheet;
    pnlTransfCstSaida: TPanel;
    gpbCSTVen: TGroupBox;
    lbl10: TLabel;
    lbl12: TLabel;
    lbl11: TLabel;
    dbeCSTT01: TDBEditFocus;
    dbeCSTT02: TDBEditFocus;
    dbeCSTT03: TDBEditFocus;
    gpbCSTTra: TGroupBox;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    dbeCSTTT1: TDBEditFocus;
    dbeCSTTT2: TDBEditFocus;
    dbeCSTTT3: TDBEditFocus;
    pnlTransfCfopSai: TPanel;
    grpTraDepFecSai: TGroupBox;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    dbeCLTDFT: TDBEditFocus;
    dbeCLTDFC: TDBEditFocus;
    dbeCLTDFS: TDBEditFocus;
    gpbClaTraIndTra: TGroupBox;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    dbeCltti1: TDBEditFocus;
    dbeCltti2: TDBEditFocus;
    dbeCltti3: TDBEditFocus;
    gpbClaTraInd: TGroupBox;
    Label92: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    dbeClati1: TDBEditFocus;
    dbeClati2: TDBEditFocus;
    dbeClati3: TDBEditFocus;
    gpbClaTra: TGroupBox;
    Label37: TLabel;
    Label38: TLabel;
    Label42: TLabel;
    dbeClatt1: TDBEditFocus;
    dbeClatt2: TDBEditFocus;
    dbeClatt3: TDBEditFocus;
    gpbClaVen: TGroupBox;
    Label19: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label36: TLabel;
    dbeClat01: TDBEditFocus;
    dbeClat02: TDBEditFocus;
    dbeClat03: TDBEditFocus;
    dbeClat04: TDBEditFocus;
    tbsClaEnt: TTabSheet;
    pnlTransfCfopEnt: TPanel;
    gbpClaCom: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    Label29: TLabel;
    dbeClTeV1: TDBEditFocus;
    dbeClTeV2: TDBEditFocus;
    dbeClTeV3: TDBEditFocus;
    gbpClaTraEnt: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label112: TLabel;
    dbeClaTe1: TDBEditFocus;
    dbeClaTe2: TDBEditFocus;
    dbeClaTe3: TDBEditFocus;
    grpTraDepFecEnt: TGroupBox;
    Label134: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    dbeCETDFT: TDBEditFocus;
    dbeCETDFC: TDBEditFocus;
    dbeCETDFS: TDBEditFocus;
    cxgTraEst: TcxGrid;
    cxgTraEstDBTableView1: TcxGridDBTableView;
    cxgTraEstDBTableView1Column3: TcxGridDBColumn;
    cxgTraEstDBTableView1Column1: TcxGridDBColumn;
    cxgTraEstDBTableView1Column2: TcxGridDBColumn;
    cxgTraEstDBTableView1Column4: TcxGridDBColumn;
    cxgTraEstDBTableView1Column7: TcxGridDBColumn;
    cxgTraEstDBTableView1Column6: TcxGridDBColumn;
    cxgTraEstDBTableView1Column8: TcxGridDBColumn;
    cxgTraEstDBTableView1CON_CODTEP: TcxGridDBColumn;
    cxgTraEstDBTableView1CON_TEPPRO: TcxGridDBColumn;
    cxgTraEstDBTableView1CON_TEPDEF: TcxGridDBColumn;
    cxgTraEstDBTableView1Column5: TcxGridDBColumn;
    cxgTraEstDBTableView1Column9: TcxGridDBColumn;
    cxgTraEstDBTableView1CON_SEQTRA: TcxGridDBColumn;
    cxgTraEstLevel1: TcxGridLevel;
    pnlTransLegenda: TPanel;
    lbl8: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label86: TLabel;
    Label103: TLabel;
    Label105: TLabel;
    pnlMltRca: TPanel;
    lblUtiAbaSN: TColorLabel;
    lblUtiAba: TLabel;
    dbeUtiAba: TDBEditFocus;
    gpbCSTDpf: TGroupBox;
    Label139: TLabel;
    Label140: TLabel;
    Label141: TLabel;
    dbeEMP_CSTDFT: TDBEditFocus;
    dbeEMP_CSTDFC: TDBEditFocus;
    dbeEMP_CSTDFS: TDBEditFocus;
    dbeIniCon: TDBEditFocus;
    lblIniCon: TLabel;
    Label142: TLabel;
    dbeGRSPED: TDBEditFocus;
    ColorLabel25: TColorLabel;
    cbxIndAtivPrep: TComboBoxFocus;
    Label143: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    function dbeCidadeChamaCadastro(Key: Word): String;
    procedure dbeCliFilKeyPress(Sender: TObject; var Key: Char);
    function dbeCliFilChamaCadastro(Key: Word): String;
    procedure dbeForFilKeyPress(Sender: TObject; var Key: Char);
    function dbeForFilChamaCadastro(Key: Word): String;
    procedure dbeClaTe1KeyPress(Sender: TObject; var Key: Char);
    procedure btnTintasClick(Sender: TObject);
    procedure btnAdicionarSocClick(Sender: TObject);
    procedure dbgSociosEnter(Sender: TObject);
    procedure dbgSociosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCgcCpfExit(Sender: TObject);
    procedure edtCidSocKeyPress(Sender: TObject; var Key: Char);
    procedure mskNumCpfEnter(Sender: TObject);
    procedure edtNomSocExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbeCodMatKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcForClick(Sender: TObject);
    procedure cxgForPreViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure cxgForPreViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure cxrFat_TEPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure Label34Click(Sender: TObject);
    procedure dbeCorFunChange(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure cxgInsSubViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgInsSubViewBands0HeaderClick(Sender: TObject);
    procedure btnCreditosClick(Sender: TObject);
    procedure cbxRegTribChange(Sender: TObject);
    procedure cbxLrJurRChange(Sender: TObject);
    procedure cbxLrDesRChange(Sender: TObject);
    procedure cbxLpJurRChange(Sender: TObject);
    procedure cbxLpDesRChange(Sender: TObject);
    procedure cbxSnJurRChange(Sender: TObject);
    procedure cbxSnDesRChange(Sender: TObject);
    procedure btnReplicaRegTribClick(Sender: TObject);
    procedure tbsAnaliseResultShow(Sender: TObject);
    procedure dbeCodEmpExit(Sender: TObject);
    procedure cdsConEmpBeforePost(DataSet: TDataSet);
    procedure dbeTplAcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodBanKeyPress(Sender: TObject; var Key: Char);
    procedure clbCoresIdentificacaoEmpresaGetColors(Sender: TCustomColorBox;
      Items: TStrings);
    procedure dbeNumCEpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCertificadoDigitalClick(Sender: TObject);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure spbDicaPortadorClick(Sender: TObject);
    procedure fraPlanoDeContasCtpdbeCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    function fraPlanoDeContasCtpdbeCodCtaChamaCadastro(Key: Word): string;
    procedure dbeNatJurKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSomaFatCAT42Exit(Sender: TObject);
    procedure mskAnoCatExit(Sender: TObject);
    procedure cdsEmpCatBeforePost(DataSet: TDataSet);
    procedure btnConfirmaFormaTribClick(Sender: TObject);
    procedure GridFormaTributacaoTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure edtTRI_FORMTRPropertiesChange(Sender: TObject);
    procedure btnCancelarFormaTribClick(Sender: TObject);
    procedure imgEmpDblClick(Sender: TObject);
    procedure pCarregaImagem;
    procedure pLimpaImagem;
    procedure dbeCNAEKeyPress(Sender: TObject; var Key: Char);
    procedure btnENotasClick(Sender: TObject);
    procedure dbeIbgeCidCtbKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDadosChange(Sender: TObject);
    procedure cbxLpJurPChange(Sender: TObject);
    procedure cbxLpDesOChange(Sender: TObject);
    procedure cbxSnJurPChange(Sender: TObject);
    procedure cbxSnDesOChange(Sender: TObject);
    procedure cbxLrJurPChange(Sender: TObject);
    procedure cbxLrDesOChange(Sender: TObject);
  strict private
    const
      chrESPACO = chr(VK_SPACE);
      chrESPACO_DUPLO = chrESPACO + chrESPACO;
  private
    { Private declarations }
    intHeightpgcTransfEstoque : Integer;
    intHeightgpbClaVen : Integer;
    intHeightgpbClaTra : Integer;
    intHeightgpbClaTraInd: Integer;
    intHeightgpbClaTraIndTra: Integer;
    intHeightgrpTraDepFecSai: Integer;
    dtaIniVig : TDateTime;
    strIESOLD : String;
    blnUtiCon : Boolean;
    blnIniCon : Boolean;
    blnSpdEcf : Boolean;
    strForFilAnt: String;

    objEmpFor: TEmpFornecedores;

    objControlaCustoDefinidosNaEmpresa: TControlaCustoDefinidosNaEmpresa;

    qryConCid: TUniQuery;
    qryConCli: TUniQuery;
    qryConFor: TUniQuery;
    qryConCfo: TUniQuery;
    qryCadCid: TUniQuery;
    qryCadCta: TUniQuery;
    qryCadPor: TUniQuery;
    blnInfMat: Boolean;

    cdsFinEmp: TZClient;
    cdsInsSub: TZClient;
    cdsPerERF: TZClient;
    qryCtaLkp: TUniQuery;
    blnAltSocio: Boolean;
    blnAltForTri: Boolean;

    FPais: TPais;

    strCodEmpOld : String;

    objEmpTri: TEmpTri;

    FObjHerancaEmpresa : THerancaEmpresa;

    strEmpAtiAnt,
    strCepAnt: String;

    strPlCtaCtp : String;

    FCaminhoDoOpenSSL: String;
    FUnidadeMapeamento: String;

    strEmpOrigem: String;

    procedure pHabiltaCodigoEmpresaMatriz;
    procedure pAfterOpen(DataSet: TDataSet);
//    procedure pGeraLotesEmpresa(strEmpNov: String);

    procedure pCarregarCorIdentificacaoEmpresa;

    Function fEhEmpresaDesseServidor: Boolean;
    Function fEhMatrizInfMat(Var strFiliais: String): Boolean;

    Function fValidaDesativacao: Boolean;
    Function fConfirmaAtivacao: Boolean;
    Function fVeSeZeraPrecosEmpresa: Boolean;
    Function fVeSeZeraPrecosEmpresaPrg(cxProgresso: TcxProgressBar): Boolean;

    procedure pIncluiConfEmp;
    procedure pAbreLookupEmpresa;
    procedure pAbreLookupCadCta;
    procedure pCarregaConfigTransferencia(topOperacao: TTipoOperacao = opAlterar);
    procedure pCarregaConfigFinanceira(topOperacao: TTipoOperacao = opAlterar);
    procedure pCarregaConfEmpresas(topOperacao: TTipoOperacao = opAlterar);
    procedure pCarregaRegTriEmp(topOperacao: TTipoOperacao = opAlterar);
    procedure pCarregaConfigPermissaoTipoVenda(topOperacao: TTipoOperacao = opAlterar);
    procedure pExibeTabRegimeTributario;

    procedure pSalvaQuadroSocietario;
    procedure pCarregaQuadroSocietario;

    procedure pDeletaIteGer(strCodEmp: String);

    procedure pAtualizaImpostosEmpresas;

    procedure pLimparEditsSocios;
    procedure pCarregaSocioAlteracao;

    procedure pHabilitaFornecedores(blnHabilita: Boolean);
    procedure pContralaVisibilidadeRegCarLig(strCodEmp: String);


    procedure pBeforePostInscSubst(DataSet: TDataSet);
    procedure pCarregaInscricoesSubstitutoTributario;
    Function fGravarInscricoesSubstitutoTributario: Boolean;
    Function fValidaInscricoesSubstitutoTributario(blnTodos: Boolean = True): Boolean;

    Function fSalvaConfEmpresas(topOperacao: TTipoOperacao = opAlterar): Boolean;

    function fReplicaCfg(strEmpOri: String; strEmpDes: String) : Boolean;
    function fReplicaCfgTin(strEmpOri: String; strEmpDes: String) : Boolean;
    function fReplicaCnf_Nfe(strEmpOri: String; strEmpDes: String) : Boolean;
    function fReplicaCfgEmp(strEmpOri: String; strEmpDes: String) : Boolean;

    Function fIncluiFinEmp(topOperacao: TTipoOperacao = opAlterar): Boolean;
    Function fValidaFinEmp: Boolean;
    Function fIncluiEmpresasOrigens: Boolean;
    Function fIncluiEmpresasOrigensPermissaoTipoVenda: Boolean;
    Function fIncluiPermissaoTipoVenda(topOperacao: TTipoOperacao = opAlterar): Boolean;
    Function fValidaPermissaoTipoVenda: Boolean;
    function fVaiHerdarConfEmp: Boolean;

    procedure pInfoStatusGravacao(strInformacao: String; pgbProgresso: TcxProgressBar);

    Function fConfiguraFiliais(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fReplicaRegimeTributario(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pAtualizarEmpresaCDNovaEmpresa(strNovaLoja : String);

    procedure pGravaLogRepCadCerDel(const AstrCodEmp: String);
    procedure pGravaDelCadCer(AqryRegistro: TUniQuery) ;

    //function fReplicaPermissaoTipoVenda(strEmpDes: String): Boolean;

    procedure pSetaConfiguracoesDefault(strCodLoj: String);
    procedure pSetaValoresDefault;
    procedure pEditaEmpresa;
    procedure pCarregaAtualizaTEPREV;
    procedure pCarregaAtualizaTEPPRO;
    procedure pCarregaDescricaoDoTipoDePlanoDeContaContabil;
    function fConverterCertificadoDigital(var AArquivoPFX: String; var AArquivoPEM: String; var AArquivoKEY: String; var AArquivoVAL: String; var ASenha: String; var ACNPJ: String; var AValidade: TDate; var ARaizCNPJ: Boolean ): Boolean;
    function fExecutaComandoWindows(AOperation, AFileName, AParameter, ADirectory: String; AShow: Word; AWait: Boolean): Boolean;
    function fValidadeDoCertificadoDigital(AArquivoVAL: String; var AValidade: TDate):Boolean;
    procedure pCarregaPortador;
    procedure pCarregaInformacoesDoCertificadoDigital;
    procedure pCarregaDescricaoDaNaturezaJuridica;
    function fRetornaCnpjDoCertificadoDigitalDaEmpresa: String;
    function fValidaCNPJdoCertificadoDigital(AArquivoPEM: String; var ACNPJ: String; var ARaizCNPJ: Boolean): Boolean;
    function fValidaCnpjEmpresaVsCertificadoDigital: Boolean;
    function fValidaArquivosCertificadoDigital: Boolean;
    function fRetornaCaminhoDoOpenSSL: String;
    procedure pRemoveMapeamentoDeRede;
    procedure pConverterCertificadoDigital;
    procedure pDeterminaExclusaoCertificadoDigital;
    procedure pExcluirCertificadoDigitalDaMesmaRaizDeCNPJ(ACnpj: String);
    procedure pExcluirCertificadoDigital(ACodEmpresa: String);
    procedure pHabilitaCstReferenteTransferenciaDeEstoque;
    procedure pCarregaValoresCAT42;
    function fGravaEmpCat : Boolean;

    function fUsaContabilidadeEcf: Boolean ;

    procedure pHabilitaBotoes(blnHabilitado : Boolean);
    function fHabilitaBotaoIncluir : Boolean;

    procedure pLimparEditsForTri;
    procedure pCarregaForTriAlteracao;
    procedure pCarregaForTri;
    procedure pSalvaForTri;
    function fItemIndexByDescricao(const AStrNome: string; const ACbItens: TCxComboBox): integer ;
    function fRetornoValidadeCertificadoDigital: TDateTime;
    function fExisteLogotipo: Boolean;
    function fExisteInclusaoDeLogotipo: Boolean;
    function fExisteInclusaoDeCertificado: Boolean;
    procedure pEnotasAtualizaCertificadoDigital(ACodEmpresa, ACnpj: String);
    function fAlltrim(const ATexto: string): string;
    procedure pAllTrimCampos;
    procedure pCarregaCidadeContab;

    procedure pReplicaClassificacoes(const strEmpOri: String);
    function fValidaClassificacoes: Boolean;
    procedure pAtualizarForcus(strNovaLoja: String);
    function fGravaLogAlteracaoIES(dtaIniVig: TDateTime): Boolean;
    function fAlterandoCNPJ : Boolean;
    function fDesativandoEmpresa : Boolean;
    function fDadosContabilistaPreenchidos: Boolean;
    procedure pSetarVisibilidadeClassificacoesTransferencia(const strCodEmp : String);
    procedure pAjustaTamanhoGridTransferencia;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;

    procedure pCarregaCidade;
    procedure pAtualizaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit;
      dbeCidade, dbeCep: TDBEditFocus; Var strCepAnt: String);
    procedure pCarregaCliente;
    procedure pCarregaFornecedor;
    procedure pCarregaCentroDeCusto(dbeCodCta: TDBEditFocus; edtDesCta: TEditFocus);

    procedure pLimpaEdits;
    procedure pOnStateChange;override;

    procedure pSetaDadosEditEmpTri;
    procedure pCarregaDadosEmpTri(topOperacao: TTipoOperacao = opAlterar);
    procedure pCarregaCombosRegimeTributario;
    function fGravaDadosRegimeTributario: Boolean;
    procedure pSetaValoresComboToDataSetRegimeTributario;
  public
    { Public declarations }
  end;

const
  ARR_REGIME_TRIBUTARIO: Array[0..3] Of Array[0..1] of String = (('LUCRO REAL',       'R'),
                                                                 ('LUCRO PRESUMIDO',  'P'),
                                                                 ('SIMPLES NACIONAL', 'S' ),
                                                                 ('SIMPLES NACIONAL - MEI', 'M' ));

  ARR_JUROS_DESCONTO_RECEBIDO: Array[0..1] Of Array[0..1] of String = (('VENDA BRUTA/RECEITA',           'V'),
                                                                       ('DESPESAS/RECEITAS FINANCEIRAS', 'D' ));

  ARR_JUROS_DESCONTO_RECEBIDO_2: Array[0..2] Of Array[0..1] of String = (('VENDA BRUTA/RECEITA',           'V'),
                                                                         ('DESPESAS/RECEITAS FINANCEIRAS', 'D'),
                                                                         ('NÃO APARECER NO DRE', 'N' ));

implementation

uses  SysUtils, Variants, Graphics, StrUtils, untFuncoes, untFuncoesSimples,
      untPai, untPesqAux, untFuncIns, untFuncIns2, untConsultas, untProdAcabado,
      untPrincipal, untFuncTinta, untCadEmpresasTintometricos, untCadLote, untCadIte,
      untDigMetMar, untInputDialog,  untTypesSistema, untObservacao,
      untCadEmpresasCreditosFiscais, untGravando, untReplicaTabelas, untCfgRepositorio,
      untSelEmpresas, untLiberacao, untLiberacaoFactory, untSaldoPedidoCompra,
      Contabilidade.Consultas, untCadCid, untCadCidades, untHelperCitel, untTPixDao,
      untMensagemExplicativa, Faturamento.Connections.Functions,
      untMsgRecalcAbreviacao, untCadEnotas, untTValidaExcel, untConfirmacaoMemo,
      untLibNfe;

{$R *.dfm}

procedure TfrmCadEmpresas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(qryCadCid);
  End;
end;

procedure TfrmCadEmpresas.FormCreate(Sender: TObject);
  Var
    intEstado: Integer;
    blnEmpIte: Boolean;
begin
  inherited;
  intHeightpgcTransfEstoque := pgcTransfEstoque.Height;
  intHeightgpbClaVen := gpbClaVen.Height;
  intHeightgpbClaTra := gpbClaTra.Height;
  intHeightgpbClaTraInd := gpbClaTraInd.Height;
  intHeightgpbClaTraIndTra := gpbClaTraIndTra.Height;
  intHeightgrpTraDepFecSai := grpTraDepFecSai.Height;

  {$IFDEF TESTABILIDADE_AUTCOM}
  lblCoresIdentificacaoEmpresa.Visible := False;
  clbCoresIdentificacaoEmpresa.Visible := False;
  pContralaVisibilidadeRegCarLig(VS_StrCodEmp);

  {$Else}
  lblCoresIdentificacaoEmpresa.Visible := Not blnUsuarioLogadoUtilizaModoClassico;
  clbCoresIdentificacaoEmpresa.Visible := Not blnUsuarioLogadoUtilizaModoClassico;
  {$ENDIF}
//  lblCoresIdentificacaoEmpresa.Visible := Not blnUsuarioLogadoUtilizaModoClassico;
//  clbCoresIdentificacaoEmpresa.Visible := Not blnUsuarioLogadoUtilizaModoClassico;

  dtaIniVig := 0;
  strIESOLD := '';
  strCodEmpOld := '';
  strForFilAnt := '';
  strForFilAnt := '';

  objEmpTri := TEmpTri.Create(Self);

  dbeUtiWMS.Visible   := fCfgSis('UTIWMS', varBoolean);
  lblWms.Visible      := fCfgSis('UTIWMS', varBoolean);
  lblWmsSN.Visible    := fCfgSis('UTIWMS', varBoolean);

  pSetarVisibilidadeClassificacoesTransferencia(VS_strCodEmp);

  blnInfMat           := fCfgSis('INFMAT', varBoolean);
  strNomeTabela       := 'CADEMP';
  strNomeCampo        := 'EMP_CODEMP';
  qryTabela           := fCriaQuery(Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet   := qryTabela;

  intPaginasAtivas    := 2;
  SetLength(arrCamposChave, 1);
  arrCamposChave[0]   := dbeCodEmp;
  blnAltSocio         := False;
  blnAltForTri        := False ;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  FPais := fSetaPais;
  qryCtaLkp := fcriaQuery(Self);
  dtsCadCta.DataSet := qryCtaLkp;
  cdsFinEmp := TZClient.Create(Self);
  cxgFinEmpeView.DataController.DataSource := cdsFinEmp.dtsSource;

  cdsInsSub := TZClient.Create(Self);
  cdsInsSub.BeforePost := pBeforePostInscSubst;
  cxgInsSubView.DataController.DataSource := cdsInsSub.dtsSource;

  cdsPerERF := TZClient.Create(Self);
  cxgPerERFView.DataController.DataSource := cdsPerERF.dtsSource;

  fraCadMetasEmpresa.pOnFormCreate;

  pCarregaTabPre(dbeTabPad);

  tbsForPre.TabVisible := blnInfMat;
  blnUtiCon := fCfgSis('UTICON', varBoolean) and (fCampoExiste('CADEMP', 'EMP_TPLACO', True));
  blnSpdEcf := fCfgSis('SPDECF', varBoolean) and (fCampoExiste('CADEMP', 'EMP_NTJURI', True));
  tbsContabilidade.TabVisible := blnUtiCon;

  blnIniCon := blnUtiCon and fCampoExiste('CADEMP', 'EMP_INICON', True);
  lblIniCon.Visible := blnIniCon;
  dbeIniCon.Visible := blnIniCon;
  if not blnIniCon then
    dbeIniCon.DataField := '';

  blnEmpIte := fPermiteInformarEmpresaNoItem;
  tbsPerERF.TabVisible := blnEmpIte;

  pAjustaNumeroPaginas(pgcDados, intPaginasAtivas);

  objEmpFor := TEmpFornecedores.Create(Self, cxgForPreView);
  cxgForPreView.DataController.DataSource := objEmpFor.dtsSource;

  cxrEstados.Properties.Items.Clear;
  For intEstado := Low(ESTADOS) To High(ESTADOS) Do
  Begin
    With cxrEstados.Properties.Items.Add Do
    Begin
      Value       := ESTADOS[intEstado];
      Description := String(ESTADOS[intEstado]) + ' - ' + DES_ESTADOS[intEstado];
    End;
  End;

  pHabilitaFornecedores(False);

  pCarregaCombosRegimeTributario;
  tbsLucroReal.TabVisible       := False;
  tbsLucroPresumido.TabVisible  := False;
  tbsSimplesNacional.TabVisible := False;
  tbsCat42.TabVisible           := False;

  dbeCrmCli.Visible := VS_strHabilitarCRM;
  dbeCrmPro.Visible := VS_strHabilitarCRM;
  dbeCrmFor.Visible := VS_strHabilitarCRM;

  lblCrmCli.Visible := VS_strHabilitarCRM;
  lblCrmPro.Visible := VS_strHabilitarCRM;
  lblCrmFor.Visible := VS_strHabilitarCRM;

  pCarregaAtualizaTEPREV;
  pCarregaAtualizaTEPPRO;

  cxgTraEstDBTableView1CON_SEQTRA.Visible := fCfgSis('SEQABA', varBoolean) and fCfgSis('SLTFRC', varBoolean);

  cdsEmpCat.CreateDataSet;
  cdsEmpCat.IndexFieldNames := 'CAT_NUMMES';
  If fCfgSis('TABPRD', VarBoolean) Then
  Begin
    pnlDadosCusto.Visible := False;
    objControlaCustoDefinidosNaEmpresa := TControlaCustoDefinidosNaEmpresa.Create(Self, tbsImpPre);
  End;

  pAjustaTamanhoGridTransferencia;
end;

procedure TfrmCadEmpresas.FormDestroy(Sender: TObject);
begin
  fraCadMetasEmpresa.pFormDestroy;
  FreeAndNil(objEmpTri);

  if Assigned(FObjHerancaEmpresa) then
    FreeAndNil(FObjHerancaEmpresa);

  inherited;
end;

procedure TfrmCadEmpresas.GridFormaTributacaoTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If Not cdsFormTrib.IsEmpty Then
      pCarregaForTriAlteracao;

    pSetFocus(edtTRI_ANOEXE);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    if not btnGravar.Enabled then
    begin
      exit ;
    end;

    if fMensagem('Aviso', 'Confirma a exclusão?', ['&Sim', '&Não'], 2) = 2 then
    begin
      exit ;
    end;

    If Not cdsFormTrib.IsEmpty Then
      cdsFormTrib.Delete;
  End ;
end;

procedure TfrmCadEmpresas.imgEmpDblClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve a empresa antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione uma empresa para continuar!', ['&Ok']);
    Exit;
  End;

  if qryTabela.Active then
  begin
    TfrmImagens.pAbrirImagens(tiEmpresa, qryTabela.FieldByName('EMP_CODEMP').AsString, (qryTabela.State <> dsEdit));
    pCarregaImagem;
  end;
end;

procedure TfrmCadEmpresas.pLimparEditsForTri;
begin
  edtTRI_ANOEXE.Clear ;
  edtTRI_FORMTR.ItemIndex := 0 ;
  edtTRI_ENCERR.ItemIndex := 0 ;
  edtTRI_VALBAS.Clear ;
  edtTRI_VLIRPJ.Clear ;
  edtTRI_ADIRPJ.Clear ;
  edtTRI_VLCSLL.Clear ;
  edtTRI_INIATV.Clear ;
end;

procedure TfrmCadEmpresas.pCarregaForTriAlteracao;
begin
  if not btnGravar.Enabled then
  begin
    exit ;
  end;

  edtTRI_ANOEXE.Text := cdsFormTrib.FieldByName('TRI_ANOEXE').AsString ;
  edtTRI_FORMTR.ItemIndex := fItemIndexByDescricao(cdsFormTrib.FieldByName('TRI_FORMTR').AsString, edtTRI_FORMTR) ;
  edtTRI_ENCERR.ItemIndex := fItemIndexByDescricao(cdsFormTrib.FieldByName('TRI_ENCERR').AsString, edtTRI_ENCERR) ;
  edtTRI_VALBAS.Value := cdsFormTrib.FieldByName('TRI_VALBAS').AsFloat ;
  edtTRI_VLIRPJ.Value := cdsFormTrib.FieldByName('TRI_VLIRPJ').AsFloat ;
  edtTRI_ADIRPJ.Value := cdsFormTrib.FieldByName('TRI_ADIRPJ').AsFloat ;
  edtTRI_VLCSLL.Value := cdsFormTrib.FieldByName('TRI_VLCSLL').AsFloat ;
  if not cdsFormTrib.FieldByName('TRI_INIATV').IsNull then
    edtTRI_INIATV.Date := cdsFormTrib.FieldByName('TRI_INIATV').AsDateTime
  else
    edtTRI_INIATV.Clear ;
  pSetFocus(edtTRI_ANOEXE);
  blnAltForTri := True;
end;

procedure TfrmCadEmpresas.pCarregaForTri;
Var
  qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);
  try
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('  TRI_CODEMP, TRI_ANOEXE, TRI_FORMTR, TRI_ENCERR, TRI_VALBAS, TRI_VLIRPJ, TRI_ADIRPJ, TRI_VLCSLL, TRI_INIATV ');
    qryAux.SQL.Add(' FROM EPREGT WHERE TRI_CODEMP = :CODEMP ');
    qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryAux.Open;

    cdsFormTrib.EmptyDataSet;
    While (Not qryAux.Eof) Do
    Begin
      cdsFormTrib.Append;
      cdsFormTrib.FieldByName('TRI_CODEMP').AsString := qryAux.FieldByName('TRI_CODEMP').AsString ;
      cdsFormTrib.FieldByName('TRI_ANOEXE').AsString := qryAux.FieldByName('TRI_ANOEXE').AsString ;
      cdsFormTrib.FieldByName('TRI_FORMTR').AsString := qryAux.FieldByName('TRI_FORMTR').AsString ;
      cdsFormTrib.FieldByName('TRI_ENCERR').AsString := qryAux.FieldByName('TRI_ENCERR').AsString ;
      cdsFormTrib.FieldByName('TRI_VALBAS').AsFloat := qryAux.FieldByName('TRI_VALBAS').AsFloat ;
      cdsFormTrib.FieldByName('TRI_VLIRPJ').AsFloat := qryAux.FieldByName('TRI_VLIRPJ').AsFloat ;
      cdsFormTrib.FieldByName('TRI_ADIRPJ').AsFloat := qryAux.FieldByName('TRI_ADIRPJ').AsFloat ;
      cdsFormTrib.FieldByName('TRI_VLCSLL').AsFloat := qryAux.FieldByName('TRI_VLCSLL').AsFloat ;
      cdsFormTrib.FieldByName('TRI_INIATV').AsString := qryAux.FieldByName('TRI_INIATV').AsString ;
      cdsFormTrib.Post;
      qryAux.Next;
    End;
  finally
    FreeAndNil(qryAux);
  end;

end;

procedure TfrmCadEmpresas.pSalvaForTri;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  try
    qryAux.SQL.Add('DELETE FROM EPREGT WHERE TRI_CODEMP = :CODEMP');
    qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryAux.ExecSQL;

    cdsFormTrib.First;
    While Not cdsFormTrib.Eof Do
    Begin

      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO EPREGT (');
      qryAux.SQL.Add('  TRI_CODEMP,  ');
      qryAux.SQL.Add('  TRI_ANOEXE,  ');
      qryAux.SQL.Add('  TRI_FORMTR,  ');
      qryAux.SQL.Add('  TRI_ENCERR,  ');
      qryAux.SQL.Add('  TRI_VALBAS,  ');
      qryAux.SQL.Add('  TRI_VLIRPJ,  ');
      qryAux.SQL.Add('  TRI_ADIRPJ,  ');
      qryAux.SQL.Add('  TRI_VLCSLL,  ');
      qryAux.SQL.Add('  TRI_INIATV)  ');
      qryAux.SQL.Add(' VALUES (   ');
      qryAux.SQL.Add('  :CODEMP,  ');
      qryAux.SQL.Add('  :ANOEXE,  ');
      qryAux.SQL.Add('  :FORMTR,  ');
      qryAux.SQL.Add('  :ENCERR,  ');
      qryAux.SQL.Add('  :VALBAS,  ');
      qryAux.SQL.Add('  :VLIRPJ,  ');
      qryAux.SQL.Add('  :ADIRPJ,  ');
      qryAux.SQL.Add('  :VLCSLL,  ');
      qryAux.SQL.Add('  :INIATV);  ');

      qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
      qryAux.ParamByName('ANOEXE').AsString := cdsFormTrib.FieldByName('TRI_ANOEXE').AsString;
      qryAux.ParamByName('FORMTR').AsString := cdsFormTrib.FieldByName('TRI_FORMTR').AsString;
      qryAux.ParamByName('ENCERR').AsString := cdsFormTrib.FieldByName('TRI_ENCERR').AsString;
      qryAux.ParamByName('VALBAS').AsFloat := cdsFormTrib.FieldByName('TRI_VALBAS').AsFloat;
      qryAux.ParamByName('VLIRPJ').AsFloat := cdsFormTrib.FieldByName('TRI_VLIRPJ').AsFloat;
      qryAux.ParamByName('ADIRPJ').AsFloat := cdsFormTrib.FieldByName('TRI_ADIRPJ').AsFloat;
      qryAux.ParamByName('VLCSLL').AsFloat := cdsFormTrib.FieldByName('TRI_VLCSLL').AsFloat;
      if not cdsFormTrib.FieldByName('TRI_INIATV').IsNull then
        qryAux.ParamByName('INIATV').AsDateTime := cdsFormTrib.FieldByName('TRI_INIATV').AsDateTime
      else
        qryAux.ParamByName('INIATV').Clear ;
      qryAux.ExecSQL;

      cdsFormTrib.Next;
    End;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TfrmCadEmpresas.fItemIndexByDescricao(const AStrNome: string; const ACbItens: TCxComboBox): integer;
var
  intCnt: integer ;
begin
  result := -1 ;
  for intCnt := 0 to ACbItens.Properties.Items.Count-1 do
  begin
    if copy(ACbItens.Properties.Items.Strings[intCnt],1,1) = AStrNome then
    begin
      result := intCnt ;
      break ;
    end;
  end;
end;

procedure TfrmCadEmpresas.edtTRI_FORMTRPropertiesChange(Sender: TObject);
begin
  inherited;
  edtTRI_INIATV.Enabled := False ;
  if TcxComboBox(Sender).ItemIndex = 0 then
  begin
    edtTRI_ENCERR.ItemIndex := 2 ;
    edtTRI_ENCERR.Enabled := False ;
    edtTRI_INIATV.Enabled := True ;
  end
  else if TcxComboBox(Sender).ItemIndex = 1 then
  begin
    edtTRI_ENCERR.ItemIndex := 2 ;
    edtTRI_ENCERR.Enabled := False ;
    edtTRI_INIATV.Clear ;
  end
  else if TcxComboBox(Sender).ItemIndex = 2 then
  begin
    edtTRI_ENCERR.ItemIndex := 0 ;
    edtTRI_ENCERR.Enabled := False ;
    edtTRI_INIATV.Clear ;
  end
  else if TcxComboBox(Sender).ItemIndex = 3 then
  begin
    edtTRI_ENCERR.ItemIndex := 0 ;
    edtTRI_ENCERR.Enabled := True ;
    edtTRI_INIATV.Clear ;
  end;
end;

procedure TfrmCadEmpresas.btnConfirmaFormaTribClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtTRI_ANOEXE.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário que informe o exercício para o seu cadastramento!', ['&Ok'] );
    pSetFocus(edtTRI_ANOEXE);
    Exit ;
  End;

  If fEmptyStr(edtTRI_FORMTR.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário que informe a forma de tributação para o seu cadastramento!', ['&Ok'] );
    pSetFocus(edtTRI_FORMTR);
    Exit;
  End;

  If fEmptyStr(edtTRI_ENCERR.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário que informe o encerramento contábil para o seu cadastramento!', ['&Ok'] );
    pSetFocus(edtTRI_ENCERR);
    Exit;
  End;

  try
    If (blnAltForTri) Then
      cdsFormTrib.Edit
    Else
      cdsFormTrib.Append;

    cdsFormTrib.FieldByName('TRI_ANOEXE').AsString := edtTRI_ANOEXE.Text;
    cdsFormTrib.FieldByName('TRI_FORMTR').AsString := copy(edtTRI_FORMTR.Text, 1, 1);
    cdsFormTrib.FieldByName('TRI_ENCERR').AsString := copy(edtTRI_ENCERR.Text, 1, 1);
    cdsFormTrib.FieldByName('TRI_VALBAS').AsFloat := edtTRI_VALBAS.Value;
    cdsFormTrib.FieldByName('TRI_VLIRPJ').AsFloat := edtTRI_VLIRPJ.Value;
    cdsFormTrib.FieldByName('TRI_ADIRPJ').AsFloat := edtTRI_ADIRPJ.Value;
    cdsFormTrib.FieldByName('TRI_VLCSLL').AsFloat := edtTRI_VLCSLL.Value;
    if edtTRI_INIATV.Date > 0 then
      cdsFormTrib.FieldByName('TRI_INIATV').AsDateTime := edtTRI_INIATV.Date
    else
      cdsFormTrib.FieldByName('TRI_INIATV').Clear ;
    cdsFormTrib.Post;
  Except
    On E: Exception Do
    Begin
      if pos('key violation', lowercase(e.Message)) > 0 then
      begin
        cdsFormTrib.Cancel ;
        fMensagem('ATENÇÃO', 'Exercício informado em duplicidade!', ['&Ok'] );
        pSetFocus(edtTRI_ANOEXE) ;
        exit ;
      end;
    End;
  End;

  pLimparEditsForTri;

  pSetFocus(edtTRI_ANOEXE) ;

  blnAltForTri := False;
end;

function TfrmCadEmpresas.fVaiHerdarConfEmp: Boolean;
begin
  Result := FObjHerancaEmpresa.cdsHeranca.Locate('HER_DESCRI', 'CONEMP', []) And
            FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_CHECKD').AsBoolean;
end;

function TfrmCadEmpresas.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
  Var
    blnAtualizar: Boolean;
    strCodCid: string;
    strEndere: string;
    strBairro: string;
    strNomCid: string;
    strEstado: string;
    LCodigoCorreio,
    LEmpresaPix: String;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeCodEmp) Then
    Begin
      pgcDados.ActivePageIndex := 0;

      If (fEmptyStr(dbeCodEmp.Text)) And (dbeCodEmp.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          If (strCodEmpOld <> dbeCodemp.Text) Then
          Begin
            pLimparCampos;
            pSetaValoresDefault;
          End;
        End
        Else
          pCarregaRegTriEmp(opAlterar);
      End;
    End

    Else If (Sender = dbeNomEmp) Then
    Begin
      pgcDados.ActivePageIndex := 0;

      If fEmptyStr(dbeNomEmp.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome da Empresa deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeALQCLI Then
    Begin
      If dbeALQCLI.Text = '' Then
        dbeALQCLI.Text := '0,0000'
     Else If strToFloat(dbeALQCLI.Text) < 0 Then
     Begin
       dbeALQCLI.Text := '0,0000';
       fMensagem('ATENÇÃO!', 'Redução do Regime de Substituição Tributária por Carga Líquida deve ser igual ou maior que zero', ['&Ok']);
       Result := False;
     End;
    End

    Else If (Sender = dbeNomFan) Then
    Begin
      If fEmptyStr(dbeNomFan.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nome Fantasia da empresa deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCidade) Then
    Begin
      If fEmptyStr(dbeCidade.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Cidade deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If Not fEmptyStr(dbeCidade.Text) Then
      Begin
        If Not fEmptyStr(fRetNomCidade(dbeCidade.Text)) Then
        Begin
          pCarregaCidade;
        End
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Length(dbeCidade.Text) > 0) And (Length(dbeCidade.Text) < dbeCidade.Field.Size) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código da cidade deve ter ' + IntToStr(dbeCidade.Field.Size) + ' caracteres!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pLimpaEdits;
      End;
    End

    Else If (Sender = dbeNumCep) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(dbeNumCep.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(dbeNumCep.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) Then
      Begin

        If (Not fCadCepDadosCep(dbeNumCep.Text,
                                strCodCid,
                                strEndere,
                                strBairro,
                                strNomCid,
                                strEstado,
                                LCodigoCorreio,
                                '',
                                '')) Then
        Begin
          Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
        End
        Else
        Begin

          If (fEmptyStr(dbeCidade.Text)) Then
          Begin

            If Not fEmptyStr(fRetNomCidade(dbeCidade.Text)) Then
            Begin

              If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                           'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
              Begin
                pAtualizaCodigoCorreios(dbeCidade.Text, dbeNumCep.Text);
              End

              Else
                Result := False;

            End
            Else
            Begin
              fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                    'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
              pCriarForm(TfrmCadCidades);

              Result := False;
            End;
          End

          {***********************************}
          {* CASO O CEP NÃO POSSUIR ENDERECO *}
          {********************************JB*}
          Else If (Not fEmptyStr(edtNomCid.Text)) And (fEmptyStr(dbeEndere.Field.AsString)) Then
          Begin
            dbeEndere.Field.AsString := fTiraCaracEspeciais(edtNomCid.Text);
            strEndere                := dbeEndere.Field.AsString;
          End;

          If (Result) Then
          Begin

            blnAtualizar := False;
            If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(dbeNumCep.Text) Then
            Begin
              If fTiraCaracEspeciais(strCepAnt) = '' Then
              Begin
                blnAtualizar := True;
              End
              Else
              If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
              Begin
                blnAtualizar := True;
              End

            End;

            If fEmptyStr(dbeCidade.Text) Or (blnAtualizar) Then
            Begin
              dbeCidade.Field.AsString := strCodCid;
              pAtualizaCidade(qryConCid, edtNomCid, edtEstado, dbeCidade, Nil, strCepAnt);
            End;

            If fEmptyStr(dbeEndere.Text) Or (blnAtualizar) Then
              dbeEndere.Field.AsString := strEndere;

            If fEmptyStr(dbeBairro.Text) Or (blnAtualizar) Then
              dbeBairro.Field.AsString := strBairro;

            If (strCodCid <> dbeCidade.Text) And (Not fEmptyStr(strCodCid)) Then
            Begin
              Result := False;
              pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(dbeCidade.Text) + '!');
            End;

          End;

        End;

        If (Result) Then
          strCepAnt := dbeNumCep.Text;

      End;

    End

    Else If (Sender = dbeNumCgc) Then
    Begin
      If Not fEmptyStr(dbeNumCgc.Text) Then
      Begin
        If Not fTestaCgc(dbeNumCgc.Text) Then
        Begin
          fMensagem('ATENÇÃO', dbeNumCgc.Text + ' não é um Número de CNPJ válido!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeInsEst) Then
    Begin
      If (Not (fEmptyStr(dbeInsEst.Text))) And (Not qryConCid.IsEmpty) Then
      Begin
        dbeInsEst.Text := AnsiReplaceStr(dbeInsEst.Text, ',', '.');
        If not fValidaIES(dbeInsEst.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', dbeInsEst.Text + ' não é uma Inscrição Estadual Válida!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
          Begin
            dbeInsEst.Text := fRetornaZerosNumIes(dbeInsEst.Text) + dbeInsEst.Text;
          End;
        End;

        If (Result) And (Not (dbeInsEst.Field.OldValue = Unassigned)) And (dbeInsEst.Field.OldValue <> Null) And
           (fRetiraZerosEsquerda(fRetSomenteNumeros(dbeInsEst.Field.OldValue)) <> fRetiraZerosEsquerda(fRetSomenteNumeros(dbeInsEst.Field.Value))) And (dtaIniVig = 0) Then
        Begin
          strIESOLD := fRetSomenteNumeros(dbeInsEst.Field.OldValue);
          If Not ffrmData(dtaIniVig, 'Data de Início', 'Data de Início da Vigência da Nova Inscrição Estadual', VS_Date) Then
          Begin
            strIESOLD := '';
            fMensagem('ATENÇÃO!', 'A Data de Início da Vigência da Nova Inscrição Estadual deve ser informada!', ['&Ok']);
            Result := False;
          end;
        End;

      End;
    End

    Else If (Sender = dbeCliFil) Then
    Begin

      If (Not fEmptyStr(dbeCliFil.Text)) Then
      Begin
        pCarregaCliente;
        If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If fClienteFilialCadastrado(dbeCliFil.Text, dbeCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente já esta cadastrado em outra empresa!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtNomCli.Clear;
        dbeClat01.Field.Clear;
        dbeClat02.Field.Clear;
        dbeClat03.Field.Clear;
        dbeClat04.Field.Clear;
        dbeClatt1.Field.Clear;
        dbeClatt2.Field.Clear;
        dbeClatt3.Field.Clear;

        dbeClati1.Field.Clear;
        dbeClati2.Field.Clear;
        dbeClati3.Field.Clear;
        dbeCltti1.Field.Clear;
        dbeCltti2.Field.Clear;
        dbeCltti3.Field.Clear;
      End;

    End

    Else If (Sender = dbePreMat) Then
    Begin
      If fEmptyStr(dbePreMat.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Utilizar preços da Matriz" deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (Copy(dbePreMat.Text, 1, 1) <> 'S') And
              (Copy(dbePreMat.Text, 1, 1) <> 'N') Then
      Begin
        Result := False;
      End;

      If Result And (dbePreMat.Text = 'N') Then
        qryTabela.FieldByName('EMP_CODMAT').Clear;
      
      If blnBuscaPorChave Then
        pHabiltaCodigoEmpresaMatriz;
    End

    Else If (Sender = dbeCodMat) Then
    Begin

      If blnBuscaPorChave Then
        pHabiltaCodigoEmpresaMatriz;

      If dbeCodMat.Visible Then
      Begin

        If fEmptyStr(dbeCodMat.Text) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          pMensagemOk('Informe o código da Empresa Matriz!');
          Result := False;
        End Else
        Begin
          edtNomMat.Text := fRetNomeEmpresaSelec(dbeCodMat.Text);

          If fEmptyStr(edtNomMat.Text) Then
          Begin
            pgcDados.ActivePage := tbsGeral;
            pMensagemOk('Empresa Matriz não encontrada!');
            Result := False;
          End

          Else If (Not SameText(dbeCodEmp.Text, dbeCodMat.Text)) And
                  SameText(fRetEmpresaMatrizDoGrupo(dbeCodMat.Text), dbeCodEmp.Text) Then
          Begin
            pgcDados.ActivePage := tbsGeral;
            pMensagemOk('A Empresa ' + dbeCodMat.Text + ' tem a ' + dbeCodEmp.Text + ' como matriz!');
            Result := False;
          End;

        End;

      End;

    End

    Else If (Sender = dbeGerCmp) Then
    Begin
      If Pos(dbeGerCmp.Text,'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Gerar Pedido de Compra nas TEs (Quando Empresa Destino) deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeGerOri) Then
    Begin
      If Pos(dbeGerOri.Text,'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Gerar Pedido de Compra nas TEs (Quando Empresa Origem) deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeExiApp) Then
    Begin
      If not MatchStr(dbeExiApp.Text,['S','N']) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exibir esta empresa no APP Citel deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeConsultaPix) Then
    Begin
      If not MatchStr(dbeConsultaPix.Text,['S','N']) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Centraliza ConsultaPix deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
      Else If dbeConsultaPix.Text = 'S' Then
      Begin
        LEmpresaPix := TPixDao.EmpresaCentralizadoraDasConsultasPix;

        If Not LEmpresaPix.IsEmpty Then
        Begin
          If LEmpresaPix <> dbeCodEmp.Text Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é possível selecionar a empresa como centralizadora das consultas pix, pois ' +
                                  'a empresa ' + LEmpresaPix + ' já está selecionada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeForFil) Then
    Begin
      If fEmptyStr(dbeForFil.Text) Then
      Begin
        dbeForFil.Field.Clear();
        edtNomFor.Clear;
        dbeClaTe1.Field.Clear;
        dbeClaTe2.Field.Clear;
        dbeClaTe3.Field.Clear;
        dbeClTeV1.Field.Clear;
        dbeClTeV2.Field.Clear;
        dbeClTeV3.Field.Clear;
      End
      Else
      Begin
        pCarregaFornecedor;

        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If fFornecedorFilialCadastrado(dbeForFil.Text, dbeCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor já esta cadastrado em outra empresa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeClaTe1) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClaTe1.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClaTe1.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClaTe1.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = dbeClaTe2) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClaTe2.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClaTe2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClaTe2.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClaTe3) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClaTe3.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClaTe3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClaTe3.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecEnt.Visible And (Sender = dbeCETDFT) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCETDFT.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCETDFT.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCETDFT.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecEnt.Visible And (Sender = dbeCETDFC) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCETDFC.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCETDFC.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCETDFC.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecEnt.Visible And (Sender = dbeCETDFS) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCETDFS.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCETDFS.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCETDFS.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecSai.Visible And (Sender = dbeCLTDFT) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCLTDFT.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCLTDFT.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCLTDFT.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecSai.Visible And (Sender = dbeCLTDFC) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCLTDFC.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCLTDFC.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCLTDFC.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If grpTraDepFecSai.Visible And (Sender = dbeCLTDFS) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCLTDFS.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCLTDFS.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCLTDFS.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClTeV1) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClTeV1.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClTeV1.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClTeV1.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClTeV2) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClTeV2.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClTeV2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClTeV2.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClTeV3) And (Not fEmptyStr(dbeForFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClTeV3.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClTeV3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClTeV3.Text,1,1)) >= 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Entrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeImpCtp) Then
    Begin

      If (Pos(dbeImpCtp.Text, 'SN') <= 0) Then
        Result := False;

    End

    Else If (Sender = dbeEmpAti) Then
    Begin

      If (Pos(dbeEmpAti.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Empresa ativa dever ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = fraPlanoDeContasCtp.dbeCodCta) Then
    Begin

      If RightStr(fraPlanoDeContasCtp.dbeCodCta.Text, 3) = '000' Then
      Begin
        fMensagem('ATENÇÃO!', fraPlanoDeContasCtp.dbeCodCta.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        fraPlanoDeContasCtp.dbeCodCta.Clear;
        Result := False;
      End

      Else If fEmptyStr(fraPlanoDeContasCtp.dbeCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Plano de Contas para a Entrada de Mercadorias Simplificada (entre Lojas)!', ['&Ok']);
        pgcDados.ActivePage := tbsGeral;
        Result := False;
      End

      Else
      Begin
        fraPlanoDeContasCtp.dbeCodCta.Text := fStrZero(fraPlanoDeContasCtp.dbeCodCta.Text,7);

        pCarregaCentroDeCusto(fraPlanoDeContasCtp.dbeCodCta, fraPlanoDeContasCtp.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
          pgcDados.ActivePage := tbsGeral;
          Result := False;
          fraPlanoDeContasCtp.edtDesCta.Clear;
        End
        Else
        Begin
          if (qryTabela.State In [dsInsert]) or (strPlCtaCtp <> fraPlanoDeContasCtp.dbeCodCta.Text) then
            Result := PlanoDeContasAtivo(fraPlanoDeContasCtp.dbeCodCta.Text,True);
        End;
      End

    End

    Else If (Sender = dbeUsaRep) Then
    Begin
      If (Pos(dbeUsaRep.Text, 'SNP') <= 0) Then
        Result := False;
    End

    Else If (Sender = dbeNum_IP) Then
    Begin
      If (fEmptyStr(dbeNum_IP.Text)) And (dbeUsaRep.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Favor informar o número IP da Empresa.', ['&Ok']);
        REsult := False;
      End;
    End

    {*******************************************}
    {* VALIDAÇÃO DA ABA CLASSIFICAÇÕES FISCAIS *}
    {****************************************MV*}
    Else If (Sender = dbeClat01) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClat01.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClat01.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClat01.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = dbeClat02) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClat02.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClat02.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClat02.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClat03) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClat03.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClat03.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClat03.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeClat04) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClat04.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClat04.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClat04.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClatt1) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClatt1.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClatt1.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClatt1.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If (Sender = dbeClatt2) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClatt2.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClatt2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClatt2.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeClatt3) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClatt3.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClatt3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClatt3.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraInd.Visible And (Sender = dbeClati1) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClati1.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClati1.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClati1.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraInd.Visible And (Sender = dbeClati2) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClati2.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClati2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClati2.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraInd.Visible And (Sender = dbeClati3) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeClati3.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeClati3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeClati3.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraIndTra.Visible And (Sender = dbeCltti1) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCltti1.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCltti1.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCltti1.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraIndTra.Visible And (Sender = dbeCltti2) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCltti2.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCltti2.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCltti2.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If gpbClaTraIndTra.Visible And (Sender = dbeCltti3) And (Not fEmptyStr(dbeCliFil.Text)) Then
    Begin

      If (Not fEmptyStr(dbeCltti3.Text)) Then
      Begin
        If Not fClaFisCadastrada(dbeCltti3.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          If StrToInt(copy(dbeCltti3.Text,1,1)) < 5 Then
          Begin
            fMensagem('ATENÇÃO!', 'Classificação Fiscal inválida para Saída!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtNomSoc) And (blnBuscaPorChave) Then
    Begin


    End

    Else If (Sender = edtNumR_G) And (blnBuscaPorChave) Then
    Begin
      If fEmptyStr(edtNumR_G.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O RG do socio deve ser preenchido!', ['&Ok']);
      End;
    End

    {*****************************}
    {* VALIDA O CÓDIGO Da CIDADE *}
    {**************************IV*}
    Else If (Sender = edtCidSoc) And (blnBuscaPorChave) Then
    Begin

      If Not fEmptyStr(edtCidSoc.Text) Then
      Begin
        edtDesCidSoc.Text := fRetNomCidade(edtCidSoc.Text);
        edtEstadoSoc.Text := fRetNomCidade(edtCidSoc.Text, 1);
        If fEmptyStr(edtDesCidSoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esta Cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'A cidade do socio deve ser preenchida!', ['&Ok']);
        Result := False;
      End;

    End

    {*****************************}
    {* VALIDA O ESTADO CIVIL     *}
    {**************************IV*}
    Else If (Sender = edtEstCivil) And (blnBuscaPorChave) Then
    Begin

      If Not fEmptyStr(edtEstCivil.Text) Then
      Begin
        If Pos(edtEstCivil.Text, 'CSOM') <= 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Estado Civil do Sócio deve ser C, S, O ou M!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O Estado Civil do Sócio deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = mskNumCpf) And (blnBuscaPorChave) Then
    Begin

      If fEmptyStr(mskNumCpf.Text) Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'O CGC/CPF do socio deve ser preenchido!', ['&Ok']);
      End
      Else If (Not fValidaCnpjCpf(edtCgcCpf.Text, mskNumCpf.Text)) Then
      Begin
        Result := False;
      End;

    End

    Else if Sender = dbeCNAE then
    Begin
      If (Not fEmptyStr(dbeCNAE.Text)) and (fEmptyStr(fRetNomeCnaeSelec(dbeCNAE.Text))) Then
      begin
        fMensagem('ATENÇÃO', 'CNAE não cadastrado!', ['&OK']);
        Result := False;
      end
      Else If fEmptyStr(dbeCNAE.Text) And Not fEmptyStr(dbeInsMun.Text) Then
      Begin
        fMensagem('','O campo CNAE Fiscal é obrigatório, pois foi informada a Inscrição Municipal!', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeContSintegra Then
    Begin
      If Not dbeUtiWMS.Visible Then
      Begin
        Try
          blnMudarFoco := False;
          pgcDados.ActivePageIndex := 1;
          pSetFocus(dbeClat01);
        Except
        End;
      End;
    End

    Else If (Sender = dbeUtiWMS) And dbeUtiWMS.Visible Then
    Begin
      If not MatchStr(dbeUtiWMS.Text, ['S','N'] ) Then
      Begin
        fMensagem('','O campo Empresa Utiliza WMS, deve ser S ou N!', ['&Ok']);
        Result := False;
      End;

      If Result Then
      Begin
        Try
          blnMudarFoco := False;
          pgcDados.ActivePageIndex := 1;
          pSetFocus(dbeClat01);
        Except
        End;
      End;
    End

    Else If (Sender = dbeCodBan) Then
    Begin

      If fEmptyStr(dbeCodBan.Text) Then
        edtDesBan.Clear
      Else
      Begin
        edtDesBan.Text := fRetDescricaoBandeiraEmpresa(dbeCodBan.Text);

        If fEmptyStr(edtDesBan.Text) Then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          pMensagemOk('Código da Bandeira da Empresa não econtrado!');
        End;


      End;

    End

    Else If (Sender = dbeCodPor) Then
    Begin
      If fEmptyStr(dbeCodPor.Text) Then
      Begin
        dbeCodPor.Field.Clear;
        edtDesPor.Clear;
      End
      Else
      Begin
        pCarregaPortador;
        if (qryCadPor.FieldByName('POR_CODPOR').IsNull) then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&Ok']);
        End
        Else if (Not fEmpresaTemAcessoPortador(dbeCodPor.Text)) then
        Begin
          Result := False;
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        End;
      End;
    End

    Else If (Sender = dbeFone01) Or (Sender = dbeFone02) Or
            (Sender = dbeNumFax) Or (Sender = dbeFoneDa1) Then
    Begin
      If (Sender = dbeFone01) And fEmptyStr(TDBEditFocus(Sender).Text) Then
      Begin
        fMensagem('','Defina o telefone da empresa!', ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(TDBEditFocus(Sender).Text)) And
              (Not fValidaTelefone(TDBEditFocus(Sender).Text)) Then
      Begin
        fMensagem('','Informe o telefone corretamente!', ['&Ok']);
        Result := False;
      End
      Else
        TDBEditFocus(Sender).Text := fAcertaMaskTel(TDBEditFocus(Sender).Text);
    End

    Else If (Sender = dbeIcmEnt) Then
    Begin

      If tbsImpPre.TabVisible  And pnlDadosCusto.Visible Then
      Begin

        If Not fEmptyStr(dbeIcmEnt.Text) Then
        Begin
          If Not fValidaEscala(dbeIcmEnt.Text, 0, 100) Then
          Begin
            Result := False;
            pMensagemOk('O ICMS de entrada deve estar entre 0 e 100%');
            pgcDados.ActivePage := tbsImpPre;
          End;
        End
        Else
        Begin
          dbeIcmEnt.Field.Value := 0;
        End;

      End

    End

    Else If (Sender = dbeSubFed) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If Not fEmptyStr(dbeSubFed.Text) Then
        Begin
          If Not fValidaEscala(dbeSubFed.Text, 0, 100) Then
          Begin
            Result := False;
            pMensagemOk('O Impostos federais devem estar entre 0 e 100%');
            pgcDados.ActivePage := tbsImpPre;
          End;
        End
        Else
        Begin
          dbeSubFed.Field.Value := 0;
        End;

      End

    End

    Else If (Sender = dbeIcmSai) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If Not fEmptyStr(dbeIcmSai.Text) Then
        Begin
          If Not fValidaEscala(dbeIcmSai.Text, 0, 100) Then
          Begin
            pgcDados.ActivePage := tbsImpPre;
            pMensagemOk('O ICMS de saída deve estar entre 0 e 100%');
            Result := False;
          End;
        End
        Else
        Begin
          dbeIcmSai.Field.Value := 0;
        End;

      End

    End

    Else If (Sender = dbeImpFed) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If Not fEmptyStr(dbeImpFed.Text) Then
        Begin
          If Not fValidaEscala(dbeImpFed.Text, 0, 100) Then
          Begin
            pMensagemOk('Os Impostos federais devem estar entre 0 e 100%');
            pgcDados.ActivePage := tbsImpPre;
            Result := False;
          End;
        End
        Else
        Begin
          dbeImpFed.Field.Value := 0;
        End;

      End

    End

    Else If (Sender = dbeDesOpe) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If Not fEmptyStr(dbeDesOpe.Text) Then
        Begin
          If Not fValidaEscala(dbeDesOpe.Text, 0, 100) Then
          Begin
            pgcDados.ActivePage := tbsImpPre;
            pMensagemOk('As Despesas Operacionais devem estar entre 0 e 100%');
            Result := False;
          End;
        End
        Else
        Begin
          dbeDesOpe.Field.Value := 0;
        End;

      End

    End

    Else If (Sender = dbeTabPad) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If fEmptyStr(dbeTabPad.Text) Then
        Begin
          pgcDados.ActivePage := tbsImpPre;
          pMensagemOk('Informe a tabela de preço padrão!');
          Result := False;
        End;

      End

    End

    Else If (Sender = dbeMarPad) Then
    Begin

      If tbsImpPre.TabVisible And pnlDadosCusto.Visible Then
      Begin

        If fEmptyStr(dbeMarPad.Text) Then
        Begin
          dbeMarPad.Field.Value := 0;
        End;

        pgcDados.ActivePage := tbsForPre;

      End

    End

    Else If (Sender = cbxRegTrib) Then
    Begin
      If tbsAnaliseResult.TabVisible Then
      Begin
        If cbxRegTrib.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pMensagemOk('Defina o Regime Tributário da Empresa!');
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeLrPisL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrPisL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Subtrair PIS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrPisL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Subtrair PIS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLrCofL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrCofL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Subtrair COFINS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrCofL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Subtrair COFINS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLrIcmL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrIcmL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrIcmL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLrIpiL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrIpiL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Somar IPI no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrIpiL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Somar IPI no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLrRetL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrRetL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrRetL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLrFreL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If fEmptyStr(dbeLrFreL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Somar FRETE no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLrFreL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Somar FRETE no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = cbxLrJurR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If cbxLrJurR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS RECEBIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLrJurP) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If cbxLrJurP.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS PAGOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLrDesR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If cbxLrDesR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS CONCEDIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLrDesO) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroReal.TabVisible Then
      Begin
        If cbxLrDesO.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS OBTIDOS como".');
          Result := False;
        End
        Else
          pProximaPagina;
      End;
    End
    Else If (Sender = dbeLpAlqI) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpAlqI.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Alíquota de IRPJ sobre faturamento".');
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeLpAlqI.Text) < 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Alíquota de IRPJ sobre faturamento" deve ser maior ou igual a zero.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpAlqC) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpAlqC.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Alíquota de CSLL sobre faturamento".');
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeLpAlqC.Text) < 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Alíquota de CSLL sobre faturamento" deve ser maior ou igual a zero.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpPisL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpPisL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Subtrair PIS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpPisL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Subtrair PIS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpCofL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpCofL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Subtrair COFINS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpCofL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Subtrair COFINS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpIcmL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpIcmL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpIcmL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpIpiL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpIpiL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Somar IPI no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpIpiL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Somar IPI no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpRetL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpRetL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpRetL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeLpFreL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If fEmptyStr(dbeLpFreL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Somar FRETE no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeLpFreL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Somar FRETE no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = cbxLpJurR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If cbxLpJurR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS RECEBIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLpJurP) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If cbxLpJurP.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS PAGOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLpDesR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If cbxLpDesR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS CONCEDIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxLpDesO) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsLucroPresumido.TabVisible Then
      Begin
        If cbxLpDesO.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS OBTIDOS como".');
          Result := False;
        End
        Else
          pProximaPagina;
      End;
    End
    Else If (Sender = dbeSnAlqF) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If fEmptyStr(dbeSnAlqF.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Alíquota de Simples sobre faturamento".');
          Result := False;
        End
        Else
        Begin
          If fStrToFloat(dbeSnAlqF.Text) < 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Alíquota de Simples sobre faturamento" deve ser maior ou igual a zero.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeSnIcmL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If fEmptyStr(dbeSnIcmL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeSnIcmL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Subtrair ICMS do Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeSnIpiL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If fEmptyStr(dbeSnIpiL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Somar IPI no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeSnIpiL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Somar IPI no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeSnRetL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If fEmptyStr(dbeSnRetL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeSnRetL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Somar SUBSTITUIÇÃO TRIBUTÁRIA no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = dbeSnFreL) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If fEmptyStr(dbeSnFreL.Text) Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Somar FRETE no Faturamento para calcular Receita Líquida?".');
          Result := False;
        End
        Else
        Begin
          If Pos(dbeSnFreL.Text, 'SN') <= 0 Then
          Begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Somar FRETE no Faturamento para calcular Receita Líquida?" deve ser (S)im ou (N)ão.');
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = cbxSnJurR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If cbxSnJurR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS RECEBIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxSnJurP) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If cbxSnJurP.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Considerar o ítem JUROS PAGOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxSnDesR) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If cbxSnDesR.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS CONCEDIDOS como".');
          Result := False;
        End;
      End;
    End
    Else If (Sender = cbxSnDesO) Then
    Begin
      If tbsAnaliseResult.TabVisible And tbsSimplesNacional.TabVisible Then
      Begin
        If cbxSnDesO.ItemIndex = -1 Then
        Begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Considerar o ítem DESCONTOS OBTIDOS como".');
          Result := False;
        End
        Else
          pProximaPagina;
      End;
    End
    else if (Sender = dbeTplAco) and (blnUtiCon) then
    begin
      if (fEmptyStr(dbeTplAco.Text)) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Plano de Contas Contábil deve ser informado!', ['&OK']);
        Result := False;
      end
      else
      begin
        pCarregaDescricaoDoTipoDePlanoDeContaContabil;
        if (fEmptyStr(edtDescricaoDoTipoDePlanoDeContaContabil.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'O Tipo de Plano de Contas Contábil informado não existe!', ['&OK']);
          Result := False;
        end;
      end;
    end
    else if (Sender = dbeNatJur) then
    begin
      if (fEmptyStr(dbeNatJur.Text)) then
      begin
        if fUsaContabilidadeEcf then
        begin
          fMensagem('ATENÇÃO!', 'A Natureza Juridica deve ser informada!', ['&OK']);
          pgcDados.ActivePageIndex := tbsContabilidade.PageIndex ;
          Result := False;
        end;
      end
      else
      begin
        pCarregaDescricaoDaNaturezaJuridica;
        if (fEmptyStr(edtDescricaoNaturezaJuridica.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'A Natureza Juridica informada não existe!', ['&OK']);
          pgcDados.ActivePageIndex := tbsContabilidade.PageIndex ;
          Result := False;
        end;
      end;
    end
    else if (Sender = dbeLrCFFD) then
    begin
      if tbsAnaliseResult.TabVisible and tbsLucroReal.TabVisible then
      begin
        if fEmptyStr(dbeLrCFFD.Text) then
        begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroReal;
          pMensagemOk('Defina o campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?".');
          Result := False;
        end
        else
        begin
          if Pos(dbeLrCFFD.Text, 'SN') <= 0 then
          begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroReal;
            pMensagemOk('O campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?" deve ser (S)im ou (N)ão.');
            Result := False;
    end;
        end;
      end;
    end
    else if (Sender = dbeLpCFFD) then
    begin
      if tbsAnaliseResult.TabVisible and tbsLucroPresumido.TabVisible then
      begin
        if fEmptyStr(dbeLpCFFD.Text) then
        begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsLucroPresumido;
          pMensagemOk('Defina o campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?".');
          Result := False;
        end
        else
        begin
          if Pos(dbeLpCFFD.Text, 'SN') <= 0 then
          begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsLucroPresumido;
            pMensagemOk('O campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?" deve ser (S)im ou (N)ão.');
            Result := False;
          end;
        end;
      end;
    end
    else If (Sender = dbeSnCFFD) then
    begin
      if tbsAnaliseResult.TabVisible and tbsSimplesNacional.TabVisible then
      begin
        if fEmptyStr(dbeSnCFFD.Text) then
        begin
          pgcDados.ActivePage := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsSimplesNacional;
          pMensagemOk('Defina o campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?".');
          Result := False;
        end
        else
        begin
          if Pos(dbeSnCFFD.Text, 'SN') <= 0 then
          begin
            pgcDados.ActivePage := tbsAnaliseResult;
            pgcRegTrib.ActivePage := tbsSimplesNacional;
            pMensagemOk('O campo "Incluir duplicatas de cliente/fornecedor filial na seção de Contas a Receber/Pagar?" deve ser (S)im ou (N)ão.');
            Result := False;
          end;
        end;
      end;
    end
    Else If (Sender = dbeSomaFatCAT42) And (tbsCat42.TabVisible) Then
    Begin
      if fEmptyStr(dbeSomaFatCAT42.Text) then
      begin
        pgcDados.ActivePage   := tbsAnaliseResult;
        pgcRegTrib.ActivePage := tbsCat42;
        fMensagem('','Defina o campo "Somar no Faturamento o Valor da CAT-42 para Calcular a Receita Liquida?"', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(dbeSomaFatCAT42.Text, 'SN') <= 0 Then
        Begin
          pgcDados.ActivePage   := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsCat42;
          fMensagem('','O campo "Somar no Faturamento o Valor da CAT-42 para Calcular a Receita Liquida?", deve ser S ou N!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = mskAnoCat) And (tbsCat42.TabVisible) Then
    Begin
      if fEmptyStr(mskAnoCat.Text) then
      begin
        pgcDados.ActivePage   := tbsAnaliseResult;
        pgcRegTrib.ActivePage := tbsCat42;
        fMensagem('','Defina o campo "Ano"', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Length(fTiraCaracEspeciais(mskAnoCat.Text,True, True)) < 4) Or
           (StrToDateDef('01/01/' + mskAnoCat.Text,0) <= 0) Then
        Begin
          pgcDados.ActivePage   := tbsAnaliseResult;
          pgcRegTrib.ActivePage := tbsCat42;
          fMensagem('','Ano inválido!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeIbgeCidCtb) Then
    Begin
      If fEmptyStr(dbeIbgeCidCtb.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Código IBGE da cidade do contabilista deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If Not fEmptyStr(dbeIbgeCidCtb.Text) Then
      Begin
        If fEmptyStr(fCampoTabela('CID_NOMCID', 'CADCID', ['CID_COIBGE'], [dbeIbgeCidCtb.Text], False)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          pCarregaCidadeContab;
        End;
      End
      Else If (Length(dbeIbgeCidCtb.Text) > 0) And (Length(dbeIbgeCidCtb.Text) < dbeIbgeCidCtb.Field.Size) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código IBGE da cidade do contabilista deve ter ' + IntToStr(dbeIbgeCidCtb.Field.Size) + ' caracteres!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pLimpaEdits;
      End;
    End
    Else If (Sender = dbeUtiAba) Then
    Begin
      If Pos(dbeUtiAba.Text, 'SN') <= 0 Then
      Begin
        pgcDados.ActivePage := tbsConEmp;
        pMensagemOk('O campo "Utilizar empresa na rotina Citel Abastece" deve ser (S)im ou (N)ão.');
        Result := False;
      End;
    End
    Else If (Sender = dbeGRSPED) Then
    Begin
      If Pos(dbeGRSPED.Text, 'SN') <= 0 Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        pMensagemOk('O campo "Gera SPED Fiscal" deve ser (S)im ou (N)ão.');
        Result := False;
    End;
      If (dbeGRSPED.Text = 'S') And
         (Not fDadosContabilistaPreenchidos) Then
      Begin
        pgcDados.ActivePageIndex := tbsContabilista.PageIndex ;
        pMensagemOk('Quando "Gera SPED Fiscal" igual a Sim, todos os dados do contabilista devem ser preenchidos!!');
        Result := False;
      End;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadEmpresas.fDadosContabilistaPreenchidos: Boolean;
begin
  Result :=
    (Not fEmptyStr(dbeNomeContab.Text)) And
    (Not fEmptyStr(dbeCpfContab.Text)) And
    (Not fEmptyStr(dbeCrcContab.Text)) And
    (Not fEmptyStr(dbeEndContab.Text)) And
    (Not fEmptyStr(dbeNumEndContab.Text)) And
    (Not fEmptyStr(dbeBairroContab.Text)) And
    (Not fEmptyStr(edtEstContab.Text)) And
    (Not fEmptyStr(dbeCepContab.Text)) And
    (Not fEmptyStr(dbeIbgeCidCtb.Text)) And
    (Not fEmptyStr(dbeFoneContab.Text)) And
    (Not fEmptyStr(dbeEmailContab.Text))
    ;
end;

function TfrmCadEmpresas.fValidaClassificacoes: Boolean;
  Var
    intCont: Integer;
    winParent: TWinControl;

begin

  Result := True;

  If not Assigned(FObjHerancaEmpresa) Then
  Begin
    Result := False;
    Exit;
  End
  Else
  Begin
    strEmpOrigem := FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString;
    If fEmptyStr(strEmpOrigem) Then
    Begin
      Result := False;
      Exit;
    End
  End;

  For intCont := 0 to ComponentCount -1 do
  Begin
    If Components[intCont] is TDBEditFocus Then
    Begin
      winParent := TDBEditFocus(Components[intCont]).Parent;

      If (winParent = gpbClaVen) or
        (winParent = gpbClaTra) or
        (winParent = gpbClaTraInd) or
        (winParent = gpbClaTraIndTra) or
        (winParent = gbpClaCom) or
        (winParent = gbpClaTraEnt) Then
      Begin
        If (not fEmptyStr(TDBEditFocus(Components[intCont]).Text)) Then
        Begin
          Result := False;
          Exit;
        End;
      End;
    End;
  End;

end;

procedure TfrmCadEmpresas.pinicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('EMP_CODEMP');
  stlCampos.Add('EMP_NOMEMP');
  stlCampos.Add('EMP_ENDERE');
  stlCampos.Add('EMP_BAIRRO');
  stlCampos.Add('EMP_CONTAT');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('EMP_NOMEMP');
  stlCamInd.Add('EMP_CODEMP');
  stlDesInd.Add('Nome da Empresa');
  stlDesInd.Add('Código');

  qryCadCid := fCriaQuery(Self);
  qryConCid := qryCadCid;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConCfo := fCriaQuery(Self);

end;

Function TfrmCadEmpresas.fValidaPermissaoTipoVenda: Boolean;
Begin
  Result := True;
  With cdsPerERF Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If Pos(FieldByName('VEN_PERRET').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa permite vendas como Retira!');
        Break;
      End;

      If Pos(FieldByName('VEN_PERENT').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa permite vendas como Entrega Imediata!');
        Break;
      End;

      If Pos(FieldByName('VEN_PERFUT').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa permite vendas como Entrega Futura!');
        Break;
      End;

      If Pos(FieldByName('VEN_PERTRE').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa permite Transferência de estoque!');
        Break;
      End;

      If Pos(FieldByName('VEN_PERMLJ').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa permite Multi-Loja!');
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;

  If Not Result Then
  Begin
    pgcDados.ActivePage := tbsPerERF;
    pSetFocus(cxgPerERF);
  End;
End;

procedure TfrmCadEmpresas.pAbreLookupEmpresa;
Begin
  With qryCadEmp, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT EMP_CODEMP, EMP_NOMEMP, EMP_CLIFIL FROM CADEMP');
    Open;
  End;
End;

procedure TfrmCadEmpresas.pAbreLookupCadCta;
Begin
  With qryCtaLkp, SQL Do
  Begin
    Close;
    Clear;
    Add('SELECT CTA_CODCTA, CONCAT(LEFT(CTA_CODCTA, 2), ".", SUBSTR(CTA_CODCTA, 3, 2), ".", RIGHT(CTA_CODCTA, 3), " - ", CTA_DESCTA) AS CTA_DESCTA FROM CADCTA');
    Add('WHERE');
    Add('  RIGHT(CTA_CODCTA, 3) <> "000"');
    Add('ORDER BY CTA_CODCTA');
    Open;
  End;
End;

procedure TfrmCadEmpresas.pCarregaConfigTransferencia(topOperacao: TTipoOperacao = opAlterar);
Begin
  With qryConEmp, SQL Do
  Begin
    cdsConEmp.Close;
    Close;
    Clear;

    If topOperacao = opAlterar Then
    Begin

      Add('SELECT * FROM CONEMP');
      Add('WHERE CON_EMPORI = :CODEMP');
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

    End Else
    Begin
      Add('SELECT ');
      Add('  EMP_CODEMP AS CON_EMPDES, ');
      Add('  "2"        AS CON_TIPOPE, ');
      Add('  "S"        AS CON_PERTRA, ');
      Add('  "N"        AS CON_ZERICM, ');
      Add('  1.0000     AS CON_FAT_TE, ');
      Add('  1.0000     AS CON_FATTE2, ');
      Add('  "N"        AS CON_ULTPIS, ');
      Add('  "N"        AS CON_ULTICM, ');
      Add('  "   "      AS CON_CODTEP, ');
      Add('  "   "      AS CON_TEPPRO, ');
      Add('  null       AS CON_SEQTRA  ');
      Add('FROM CADEMP');
    End;

    Open;

    cdsConEmp.Open;
  End;
End;

procedure TfrmCadEmpresas.pCarregaDadosEmpTri(topOperacao: TTipoOperacao);
  Var
    intIndex: Integer;
begin
  If topOperacao = opAlterar Then
    objEmpTri.pCarregaEmpTri(qryTabela.FieldByName('EMP_CODEMP').AsString);

  dsRegTri.DataSet := objEmpTri.qryTabela;

  cbxLrJurR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LRJURR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxLrJurR.ItemIndex := intIndex;

  cbxLrJurP.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LRJURP').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxLrJurP.ItemIndex := intIndex;

  cbxLrDesR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LRDESR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxLrDesR.ItemIndex := intIndex;

  cbxLrDesO.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LRDESO').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxLrDesO.ItemIndex := intIndex;

  cbxLpJurR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LPJURR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxLpJurR.ItemIndex := intIndex;

  cbxLpJurP.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LPJURP').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxLpJurP.ItemIndex := intIndex;

  cbxLpDesR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LPDESR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxLpDesR.ItemIndex := intIndex;

  cbxLpDesO.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_LPDESO').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxLpDesO.ItemIndex := intIndex;

  cbxSnJurR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_SNJURR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxSnJurR.ItemIndex := intIndex;

  cbxSnJurP.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_SNJURP').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxSnJurP.ItemIndex := intIndex;

  cbxSnDesR.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_SNDESR').AsString = ARR_JUROS_DESCONTO_RECEBIDO[intIndex][1] Then
      cbxSnDesR.ItemIndex := intIndex;

  cbxSnDesO.ItemIndex := -1;

  For intIndex := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    If objEmpTri.qryTabela.FieldByName('TRI_SNDESO').AsString = ARR_JUROS_DESCONTO_RECEBIDO_2[intIndex][1] Then
      cbxSnDesO.ItemIndex := intIndex;
end;

procedure TfrmCadEmpresas.pCarregaDescricaoDaNaturezaJuridica;
begin
  edtDescricaoNaturezaJuridica.Text := fCampoTabela('NAT_NATNOM', 'NTJURI', ['NAT_CODIGO'], [dbeNatJur.Text]);
end;

procedure TfrmCadEmpresas.pCarregaDescricaoDoTipoDePlanoDeContaContabil;
begin
  if blnUtiCon then
    edtDescricaoDoTipoDePlanoDeContaContabil.Text := fCampoTabela('ACO_DESCRI', 'TPLACO', ['ACO_CODIGO'], [dbeTplAco.Text]);
end;

procedure TfrmCadEmpresas.pCarregaConfigFinanceira(topOperacao: TTipoOperacao = opAlterar);
Begin
  With cdsFinEmp.qryQuery, SQL Do
  Begin
    cdsFinEmp.Close;
    Close;
    Clear;

    If topOperacao = opAlterar Then
    Begin

      Add('SELECT * FROM FINEMP');
      Add('WHERE FIN_EMPORI = :CODEMP');
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

    End Else
    Begin
      Add('SELECT * FROM FINEMP WHERE FALSE');
    End;

    cdsFinEmp.pSetProvider;

    Open;

    pSetaClient(cdsFinEmp.qryQuery);

    cdsFinEmp.Open;

    If topOperacao = opIncluir Then
    Begin
      qryCadEmp.First;
      While Not qryCadEmp.Eof Do
      Begin
        cdsFinEmp.Insert;
        cdsFinEmp.FieldByName('FIN_EMPDES').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
        cdsFinEmp.FieldByName('FIN_GRVCTP').AsString := 'N';
        cdsFinEmp.FieldByName('FIN_GRVCTR').AsString := 'N';
        cdsFinEmp.Post;

        qryCadEmp.Next;
      End;
    End;

  End;
End;

procedure TfrmCadEmpresas.pBeforePostInscSubst(DataSet: TDataSet);
begin
  If DataSet.State In [dsEdit] Then
  Begin
    DataSet.FieldByName('EMP_INSSUB').AsString :=
      AnsiReplaceStr(DataSet.FieldByName('EMP_INSSUB').AsString, ',', '.');

    If Not fValidaInscricoesSubstitutoTributario(False) Then
    Begin
      DataSet.Cancel;
      Abort;
    End;
  End;
end;

procedure TfrmCadEmpresas.pHabilitaBotoes(blnHabilitado: Boolean);
begin
  btnIncluir.Enabled  := IIF(blnHabilitado, fHabilitaBotaoIncluir, False);
  btnAlterar.Enabled  := blnHabilitado;
  btnExcluir.Enabled  := blnHabilitado;
  btnPesquisa.Enabled := blnHabilitado;
  btnsair.Enabled     := blnHabilitado;
end;

procedure TfrmCadEmpresas.pCarregaInscricoesSubstitutoTributario;
  Var
    intEstado: Integer;
Begin

  With cdsInsSub.qryQuery, SQL Do
  Begin
    cdsInsSub.Close;
    Close;
    Clear;

    Add('SELECT * FROM EMPISB WHERE EMP_CODEMP = :CODEMP');
    
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

    cdsInsSub.pSetProvider;

    Open;

    pSetaClient(cdsInsSub.qryQuery);

    cdsInsSub.Open;

    For intEstado := Low(ESTADOS) To High(ESTADOS) Do
    Begin
      If (ESTADOS[intEstado] = 'PY') Or (ESTADOS[intEstado] = 'EX') Then
        Continue;

      If Not cdsInsSub.Locate('EMP_ESTADO', ESTADOS[intEstado], []) Then
      Begin
        cdsInsSub.Insert;
        cdsInsSub.FieldByName('EMP_CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
        cdsInsSub.FieldByName('EMP_ESTADO').AsString := String(ESTADOS[intEstado]);
        cdsInsSub.FieldByName('EMP_CADSIM').AsString := 'N';
        cdsInsSub.Post;        
      End;

    End;

    cdsInsSub.First;

    cxgInsSub.Enabled := (qryTabela.State In [dsEdit, dsInsert]);
  End;

End;

procedure TfrmCadEmpresas.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryCadPor, dbeCodPor.Text);
  edtDesPor.Text := qryCadPor.FieldByName('POR_NOMPOR').AsString;
end;

Function TfrmCadEmpresas.fValidaInscricoesSubstitutoTributario(blnTodos: Boolean = True): Boolean;

  function fValidar: Boolean;
  begin
    Result := True;
    With cdsInsSub Do
    Begin
      If (Not (fEmptyStr(FieldByName('EMP_INSSUB').AsString))) And (Not qryConCid.IsEmpty) Then
      Begin        
        If Not fValidaIES(FieldByName('EMP_INSSUB').AsString, FieldByName('EMP_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Inscrição Estadual '+FieldByName('EMP_INSSUB').AsString + ' é inválida ou não pertence ao Estado de '+FieldByName('EMP_ESTADO').AsString+' !', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  end;

begin
  Result := True;

  Try
    If Not blnTodos Then
    Begin
      Result := fValidar;
      Exit;
    End;

    With cdsInsSub Do
    Begin
      First;
      While Not Eof Do
      Begin
        Result := fValidar;

        If Not Result Then
          Break;

        Next;
      End;
    End;

    If Not Result Then
    Begin
      pgcDados.ActivePage := tbsInsSub;
      pSetFocus(cxgInsSub);
    End;
  Except
    Result := False;
  End;

end;


Function TfrmCadEmpresas.fValidaFinEmp: Boolean;
Begin
  Result := True;
  With cdsFinEmp Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin

      If Pos(FieldByName('FIN_GRVCTP').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa grava contas a pagar!');
        Break;
      End;

      If Pos(FieldByName('FIN_GRVCTR').AsString, 'S_N_') <= 0 Then
      Begin
        Result := False;
        pMensagemOk('Informe se a empresa grava contas a receber!');
        Break;
      End;

      Next;
    End;
    EnableControls;
  End;

  If Not Result Then
  Begin
    pgcDados.ActivePage := tbsCfgFin;
    pSetFocus(cxgFinEmp);
  End;
End;

procedure TfrmCadEmpresas.Label34Click(Sender: TObject);
begin
  inherited;
  if not (qryTabela.State in dsEditModes) then Exit;


  cldCores.Color := StrToIntDef(TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString,0);
  If (cldCores.Execute) Then
  Begin
    TDBEditFocus(TLabel(Sender).FocusControl).Field.AsString := IntToStr(cldCores.Color);
  End;

end;

procedure TfrmCadEmpresas.pCarregaCombosRegimeTributario;
  Var
    intCont: Integer;
begin
  cbxRegTrib.Items.Clear;

  For intCont := 0 To Length(ARR_REGIME_TRIBUTARIO) -1 Do
    cbxRegTrib.Items.Add(ARR_REGIME_TRIBUTARIO[intCont][0]);

  cbxLrJurR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxLrJurR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxLrJurP.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxLrJurP.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);

  cbxLrDesR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxLrDesR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxLrDesO.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxLrDesO.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);

  cbxLpJurR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxLpJurR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxLpJurP.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxLpJurP.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);

  cbxLpDesR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxLpDesR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxLpDesO.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxLpDesO.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);

  cbxSnJurR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxSnJurR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxSnJurP.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxSnJurP.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);

  cbxSnDesR.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO) -1 Do
    cbxSnDesR.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO[intCont][0]);

  cbxSnDesO.Items.Clear;

  For intCont := 0 To Length(ARR_JUROS_DESCONTO_RECEBIDO_2) -1 Do
    cbxSnDesO.Items.Add(ARR_JUROS_DESCONTO_RECEBIDO_2[intCont][0]);
end;

procedure TfrmCadEmpresas.pCarregaConfEmpresas(topOperacao: TTipoOperacao = opAlterar);
Begin
  If qryTabela.Active Then
  Begin
    pAbreLookupEmpresa;
    pAbreLookupCadCta;
    pCarregaConfigTransferencia(topOperacao);
    pCarregaConfigFinanceira(topOperacao);
    pCarregaRegTriEmp(topOperacao);
    pCarregaConfigPermissaoTipoVenda(topOperacao);

    dbeCorFunChange(dbeCorFun);
  End;

End;

procedure TfrmCadEmpresas.pIncluiConfEmp;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Add('INSERT INTO CONEMP');
    Add('(CON_EMPORI, CON_EMPDES, CON_TIPOPE, CON_PERTRA, CON_ZERICM, CON_FAT_TE, CON_FATTE2, CON_ULTPIS, CON_ULTICM, CON_CODTEP, CON_TEPPRO)');
    Add('VALUES');
    Add('(:EMPORI, :EMPDES, :TIPOPE, :PERTRA, :ZERICM, :FAT_TE, :FATTE2, :ULTPIS, :ULTICM, :CODTEP, :TEPPRO)');
  End;


  If Not fVaiHerdarConfEmp Then
    Begin
    cdsConEmp.First;
    While Not cdsConEmp.Eof Do
    Begin
      qryGen.Close;
      qryGen.ParamByName('EMPORI').AsString := dbeCodEmp.Text;
      qryGen.ParamByName('EMPDES').AsString := cdsConEmp.FieldByName('CON_EMPDES').AsString;
      qryGen.ParamByName('TIPOPE').AsString := cdsConEmp.FieldByName('CON_TIPOPE').AsString;
      qryGen.ParamByName('PERTRA').AsString := cdsConEmp.FieldByName('CON_PERTRA').AsString;
      qryGen.ParamByName('ZERICM').AsString := cdsConEmp.FieldByName('CON_ZERICM').AsString;
      qryGen.ParamByName('FAT_TE').AsFloat  := cdsConEmp.FieldByName('CON_FAT_TE').AsFloat;
      qryGen.ParamByName('FATTE2').AsFloat  := cdsConEmp.FieldByName('CON_FATTE2').AsFloat;
      qryGen.ParamByName('ULTPIS').AsString := cdsConEmp.FieldByName('CON_ULTPIS').AsString;
      qryGen.ParamByName('ULTICM').AsString := cdsConEmp.FieldByName('CON_ULTICM').AsString;

      If fEmptyStr(cdsConEmp.FieldByName('CON_CODTEP').AsString) Then
        qryGen.ParamByName('CODTEP').Value := Null
      Else
        qryGen.ParamByName('CODTEP').AsString := cdsConEmp.FieldByName('CON_CODTEP').AsString;

      If fEmptyStr(cdsConEmp.FieldByName('CON_TEPPRO').AsString) Then
        qryGen.ParamByName('TEPPRO').Value := Null
      Else
        qryGen.ParamByName('TEPPRO').AsString := cdsConEmp.FieldByName('CON_TEPPRO').AsString;

      qryGen.ExecSQL;

      cdsConEmp.Next;
    End;
  End;

  With qryCadEmp Do
  Begin

    First;
    While Not Eof Do
    Begin
      qryGen.Close;

      If FieldByName('EMP_CODEMP').AsString <> dbeCodEmp.Text Then
      Begin
        qryGen.ParamByName('EMPORI').AsString := FieldByName('EMP_CODEMP').AsString;
        qryGen.ParamByName('EMPDES').AsString := dbeCodEmp.Text;
        qryGen.ParamByName('TIPOPE').AsString := '2';
        qryGen.ParamByName('PERTRA').AsString := 'S';
        qryGen.ParamByName('ZERICM').AsString := 'N';
        qryGen.ParamByName('FAT_TE').AsFloat  := 1.0000;
        qryGen.ParamByName('FATTE2').AsFloat  := 1.0000;
        qryGen.ParamByName('ULTPIS').AsString := 'N';
        qryGen.ParamByName('ULTICM').AsString := 'N';
        qryGen.ParamByName('CODTEP').AsString := fGetTEPREV(FieldByName('EMP_CODEMP').AsString, FieldByName('EMP_CLIFIL').AsString);
        qryGen.ParamByName('TEPPRO').AsString := fGetTEPPRO(FieldByName('EMP_CODEMP').AsString, FieldByName('EMP_CLIFIL').AsString);
        qryGen.ExecSQL;
      End;

      Next;
    End;
  End;

End;

procedure TfrmCadEmpresas.pInfoStatusGravacao(strInformacao: String;
  pgbProgresso: TcxProgressBar);
begin
  If Assigned(pgbProgresso) And (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando')).Caption := strInformacao;
    Application.ProcessMessages;
  End;
end;

Function TfrmCadEmpresas.fIncluiEmpresasOrigens: Boolean;
  Var
    qryFinEmp: TUniQuery;
Begin
  Try
    qryFinEmp := fCriaQuery;
    With qryFinEmp, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM FINEMP WHERE FALSE');
      Open;

      qryCadEmp.First;
      While Not qryCadEmp.Eof Do
      Begin

        If qryCadEmp.FieldByName('EMP_CODEMP').AsString <> qryTabela.FieldByName('EMP_CODEMP').AsString Then
        Begin
          qryFinEmp.Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FINEMP', VS_strCodEmp);
          FieldByName('FIN_EMPORI').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          FieldByName('FIN_EMPDES').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
          FieldByName('FIN_GRVCTP').AsString := 'N';
          FieldByName('FIN_GRVCTR').AsString := 'N';
          Post;
        End;

        qryCadEmp.Next;
      End;

    End;
    FreeAndNil(qryFinEmp);

    Result := True;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadEmpresas.fIncluiEmpresasOrigens]');
    End;

  End;
End;

Function TfrmCadEmpresas.fIncluiEmpresasOrigensPermissaoTipoVenda: Boolean;
  Var
    qryPerEFF: TUniQuery;
Begin
  Try
    qryPerEFF := fCriaQuery;
    With qryPerEFF, SQL Do
    Begin
      Clear;
      Add('SELECT * FROM VENEMP WHERE FALSE');
      Open;

      qryCadEmp.First;
      While Not qryCadEmp.Eof Do
      Begin

        If qryCadEmp.FieldByName('EMP_CODEMP').AsString <> qryTabela.FieldByName('EMP_CODEMP').AsString Then
        Begin
          qryPerEFF.Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VENEMP', VS_strCodEmp);
          FieldByName('VEN_EMPORI').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          FieldByName('VEN_EMPDES').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
          FieldByName('VEN_PERRET').AsString := 'S';
          FieldByName('VEN_PERENT').AsString := 'S';
          FieldByName('VEN_PERFUT').AsString := 'S';
          FieldByName('VEN_PERTRE').AsString := 'S';
          FieldByName('VEN_PERMLJ').AsString := 'S';
          Post;
        End;

        qryCadEmp.Next;
      End;

      qryPerEFF.Insert;
      qryPerEFF.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VENEMP', VS_strCodEmp);
      qryPerEFF.FieldByName('VEN_EMPORI').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
      qryPerEFF.FieldByName('VEN_EMPDES').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
      qryPerEFF.FieldByName('VEN_PERRET').AsString := 'S';
      qryPerEFF.FieldByName('VEN_PERENT').AsString := 'S';
      qryPerEFF.FieldByName('VEN_PERFUT').AsString := 'S';
      qryPerEFF.FieldByName('VEN_PERTRE').AsString := 'S';
      qryPerEFF.FieldByName('VEN_PERMLJ').AsString := 'S';
      qryPerEFF.Post;

    End;
    FreeAndNil(qryPerEFF);

    Result := True;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadEmpresas.fIncluiEmpresasOrigensPermissaoTipoVenda]');
    End;

  End;
End;

Function TfrmCadEmpresas.fIncluiPermissaoTipoVenda(topOperacao: TTipoOperacao = opAlterar): Boolean;
Begin
  With cdsPerERF Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin

      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VENEMP', VS_strCodEmp);

      If fEmptyStr(FieldByName('VEN_EMPORI').AsString) Then
        FieldByName('VEN_EMPORI').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

      Post;

      Next;
    End;

    result := cdsPerERF.fSalva;

    If (topOperacao = opIncluir) Then
    Begin
      Result := fIncluiEmpresasOrigensPermissaoTipoVenda;
    End;

    EnableControls;
  End;
End;

function TfrmCadEmpresas.fHabilitaBotaoIncluir: Boolean;
var
  strDireitos : String;
  dtaLimite   : TDate;
  strCfgSis   : String;
 begin
  Result := Pos(strLoginUsuarioLogado,'_997_998_999') > 0;

  if (not Result) then
  begin
    strCfgSis := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_DTLTEP', VS_strCodEmp]);

    if (not fEmptyStr(strCfgSis)) then
    begin
      try
        dtaLimite := StrToDate(strCfgSis)
      except
        Exit;
      end;

      if VS_Date <= dtaLimite then
      begin
        if (fVerificaDirEspecificos(strDireitos, strLoginUsuarioLogado, strNomeForm)) then
          Result := Pos('I', strDireitos) > 0;
      end;
    end;
  end;
end;

function TfrmCadEmpresas.fConfiguraFiliais(pgbStatus: TcxProgressBar): Boolean;

  procedure pSetMax(intMax: Integer);
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Properties.Max := intMax;
  End;

  procedure pIncPos;
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  end;

  function fRetornaEmpresaLote: String;
  Begin
    Result := Trim(fRetEmpresasWms(False));

    If (Not fEmptyStr(AnsiReplaceStr(Result, ',', ''))) Then
    Begin
      If (Pos(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString, Result) > 0) Then
        Result := FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString
      Else
        Result := LeftStr(Result, 3);
    End
    Else
      Result := '';
  End;

  Var
    strNovaLoja : String;
    strEmpLot   : String;
    objRepIteGer : TReplicaTabelaITEGER;
    objRepIteEmb : TReplicaTabelaITEEMB;
    objRepAcaGer : TReplicaTabelaACAGER;
    objRepCfgRel : TReplicaTabelaCFGREL;
    objRepCnfBol : TReplicaTabelaCNFBOL;
    objRepLayEti : TReplicaTabelaLAYETI;
    objRepCadLot : TReplicaTabelaCadLot;
    objRepConEmp : TReplicaTabelaCONEMP;
    objRepCadCar : TReplicaTabelaCADCAR;
begin

  Result := True;

  strNovaLoja := qryTabela.FieldByName('EMP_CODEMP').AsString;

  Screen.Cursor := crHourGlass;

  Try
    Try

      pHabilitaBotoes(False);

      pgbStatus.Position := 0;

      pSetMax(FObjHerancaEmpresa.intNumeroItensHerdados);

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCFGSIS)) then
      Begin
        fStartTransaction;

        pInfoStatusGravacao(Format('Aguarde... Gerando configurações para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;
        fReplicaCfg(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString, strNovaLoja);

        pInfoStatusGravacao(Format('Aguarde... Gerando configurações default para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;

        pSetaConfiguracoesDefault(strNovaLoja);
        FObjHerancaEmpresa.pProcessarCFGWebService(strNovaLoja, dbeNumCgc.Text);

        pAtualizarEmpresaCDNovaEmpresa(strNovaLoja);

        fCommit;

      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCFGEMP)) then
      Begin
        fStartTransaction;

        pInfoStatusGravacao(Format('Aguarde... Gerando configurações de consultas para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;
        fReplicaCfgEmp(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString, strNovaLoja);

        fCommit;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCFGTIN)) then
      Begin
        fStartTransaction;

        pInfoStatusGravacao(Format('Aguarde... Gerando configurações tintométricas para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;
        fReplicaCfgTin(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString, strNovaLoja);

        fCommit;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcITEGER)) then
      Begin
        objRepIteGer := TReplicaTabelaITEGER.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando produtos para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;
          objRepIteGer.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepIteGer.pReplicaTabela;
        Finally
          FreeAndNil(objRepIteGer);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcACAGER)) then
      Begin
        objRepAcaGer := TReplicaTabelaACAGER.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando produtos tintométricos para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;
          objRepAcaGer.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepAcaGer.pReplicaTabela;
        Finally
          FreeAndNil(objRepAcaGer);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCADLOT)) then
      Begin
        pInfoStatusGravacao(Format('Aguarde... Gerando cadastro de lotes para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;

        strEmpLot := fRetornaEmpresaLote;

        If (Not fEmptyStr(strEmpLot)) Then
        Begin
          objRepCadLot := TReplicaTabelaCadLot.Create(strNovaLoja);
          Try
            objRepCadLot.pAlteraEmpresaLogada(strEmpLot);
            objRepCadLot.pReplicaTabela;
          Finally
            FreeAndNil(objRepCadLot);
          End;
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCFGREL)) then
      Begin
        objRepCfgRel := TReplicaTabelaCFGREL.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando filas de impressão para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;

          objRepCfgRel.blnHerdarDadosDoBancoFisico := FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCFGREL);

          If (objRepCfgRel.blnHerdarDadosDoBancoFisico) Then
            objRepCfgRel.qryBDFisico := FObjHerancaEmpresa.fRetornarQuery(thcCFGREL);

          objRepCfgRel.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepCfgRel.pReplicaTabela;

        Finally
          FreeAndNil(objRepCfgRel);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCNFBOL)) then
      Begin
        objRepCnfBol := TReplicaTabelaCNFBOL.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando layouts de boleto para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;

          objRepCnfBol.blnHerdarDadosDoBancoFisico := FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCNFBOL);

          If (objRepCnfBol.blnHerdarDadosDoBancoFisico) Then
            objRepCnfBol.qryBDFisico := FObjHerancaEmpresa.fRetornarQuery(thcCNFBOL);

          objRepCnfBol.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepCnfBol.pReplicaTabela;
        Finally
          FreeAndNil(objRepCnfBol);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCNF_NFE)) then
      Begin
        fStartTransaction;

        pInfoStatusGravacao(Format('Aguarde... Gerando mensagens da nota fiscal eletrônica para a empresa %s.', [strNovaLoja]), pgbStatus);
        pIncPos;
        fReplicaCnf_Nfe(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString, strNovaLoja);

        fCommit;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcLAYETI)) then
      Begin
        objRepLayEti := TReplicaTabelaLAYETI.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando layouts de documentos para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;

          objRepLayEti.blnHerdarDadosDoBancoFisico := FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcLAYETI);

          If (objRepLayEti.blnHerdarDadosDoBancoFisico) Then
            objRepLayEti.qryBDFisico := FObjHerancaEmpresa.fRetornarQuery(thcLAYETI);

          objRepLayEti.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepLayEti.pReplicaTabela;
        Finally
          FreeAndNil(objRepLayEti);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcITEEMB)) then
      Begin
        If (fCfgSis('TPDCEM', varString) = '2') Then
        Begin
          objRepIteEmb := TReplicaTabelaITEEMB.Create(strNovaLoja);
          Try
            pInfoStatusGravacao(Format('Aguarde... Gerando o desconto de embalagens fechadas dos produtos para a empresa %s.', [strNovaLoja]), pgbStatus);
            pIncPos;
            objRepIteEmb.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
            objRepIteEmb.pReplicaTabela;
          Finally
            FreeAndNil(objRepIteEmb);
          End
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCONEMP)) then
      Begin
        objRepConEmp := TReplicaTabelaCONEMP.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando configurações de transferência de estoque para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;

          objRepConEmp.blnHerdarDadosDoBancoFisico := FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCONEMP);

          If (objRepConEmp.blnHerdarDadosDoBancoFisico) Then
            objRepConEmp.qryBDFisico := FObjHerancaEmpresa.fRetornarQuery(thcCONEMP);

          objRepConEmp.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepConEmp.pReplicaTabela;
        Finally
          FreeAndNil(objRepConEmp);
        End;
      End;

      if (FObjHerancaEmpresa.fSelecionouTarefaParaHerdar(thcCADCAR)) then
      Begin
        objRepCadCar := TReplicaTabelaCADCAR.Create(strNovaLoja);
        Try
          pInfoStatusGravacao(Format('Aguarde... Gerando cadastro de cartões para a empresa %s.', [strNovaLoja]), pgbStatus);
          pIncPos;

          objRepCadCar.blnHerdarDadosDoBancoFisico := FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCADCAR);

          If (objRepCadCar.blnHerdarDadosDoBancoFisico) Then
            objRepCadCar.qryBDFisico := FObjHerancaEmpresa.fRetornarQuery(thcCADCAR);

          objRepCadCar.pAlteraEmpresaLogada(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString);
          objRepCadCar.pReplicaTabela;
        Finally
          FreeAndNil(objRepCadCar);
        End;
      End;

      fStartTransaction;
      pInfoStatusGravacao(Format('Aguarde... Gerando os direitos de acesso para a empresa %s.', [strNovaLoja]), pgbStatus);
      pIncPos;
      if not FObjHerancaEmpresa.fGravarDireitoAcesso(strNovaLoja) then
        fRollBack
      Else
        fCommit;

      fStartTransaction;
      pInfoStatusGravacao(Format('Aguarde... Gravando as condições de pagamento de acesso para a empresa %s.', [strNovaLoja]), pgbStatus);
      pIncPos;
      if not FObjHerancaEmpresa.fGravarCondicaoPagamento(strNovaLoja) then
        fRollBack
      Else
        fCommit;

      pInfoStatusGravacao('Atualização Concluída!', pgbStatus);

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadEmpresas.fConfiguraFiliais]');
      End;
    End;

  Finally
    pnlInfo.Caption := '';
    Screen.Cursor := crDefault;
    pHabilitaBotoes(True);
  End;

end;

Function TfrmCadEmpresas.fGravarInscricoesSubstitutoTributario: Boolean;
Begin
  With cdsInsSub Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin
      Edit;
      FieldByName('EMP_CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
      Post;
      Next;
    End;

    Result := cdsInsSub.fSalva;

    EnableControls;
  End;
End;

Function TfrmCadEmpresas.fIncluiFinEmp(topOperacao: TTipoOperacao = opAlterar): Boolean;
Begin
  With cdsFinEmp Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin

      Edit;

      If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FINEMP', VS_strCodEmp);

      If fEmptyStr(FieldByName('FIN_EMPORI').AsString) Then
        FieldByName('FIN_EMPORI').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

      Post;

      Next;
    End;

    result := cdsFinEmp.fSalva;

    If result And (topOperacao = opIncluir) Then
      result := fIncluiEmpresasOrigens;

    EnableControls;
  End;
End;

Function TfrmCadEmpresas.fSalvaConfEmpresas(topOperacao: TTipoOperacao = opAlterar): Boolean;
Begin
  Case topOperacao Of
    opIncluir: Begin
                 pIncluiConfEmp;
                 Result := fIncluiFinEmp(topOperacao);
                 Result := Result And fIncluiPermissaoTipoVenda(topOperacao);
               End;
    opAlterar: Begin
                 cdsConEmp.ApplyUpdates(-1);
                 Result := fIncluiFinEmp(topOperacao);
                 Result := Result And fIncluiPermissaoTipoVenda(topOperacao);
               End;
    Else       Result := True;
  End;
End;

function TfrmCadEmpresas.fUsaContabilidadeEcf: Boolean;
begin
  Result := False ;

  if not fCfgSis('UTICON', varBoolean) then
    exit ;

  if not blnSpdEcf then
    exit ;

  Result := True ;
end;

procedure TfrmCadEmpresas.btnIncluirClick(Sender: TObject);
  var
    frmCadEmpresasHeranca : TfrmCadEmpresasHeranca;
begin
  inherited;

  strEmpAtiAnt := '';

  Try
    if Assigned(FObjHerancaEmpresa) then
      FreeAndNil(FObjHerancaEmpresa);

    FObjHerancaEmpresa := THerancaEmpresa.Create;
    If Assigned(objControlaCustoDefinidosNaEmpresa) then
    Begin
      objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(True);
      objControlaCustoDefinidosNaEmpresa.pIniciaDadosInclusao;
    End;
    pCriarFormularios(TfrmCadEmpresasHeranca, frmCadEmpresasHeranca);
    frmCadEmpresasHeranca.ObjHerancaEmpresa := FObjHerancaEmpresa;
    frmCadEmpresasHeranca.ShowModal;

    if not frmCadEmpresasHeranca.blnConfirma then
    Begin
      Try
        pFreeAndNil(frmCadEmpresasHeranca);
        btnCancela.Click;
        Abort;
      Except
        on E: Exception do
        begin
          if (E is EAbort) then
          Begin
            if Assigned(FObjHerancaEmpresa) then
              FreeAndNil(FObjHerancaEmpresa);
            Exit;
          End;
        end;
      End;
    End;
  Finally
    pFreeAndNil(frmCadEmpresasHeranca);
  End;

  pContralaVisibilidadeRegCarLig(VS_StrCodEmp);
  strForFilAnt := '';

  pgcDados.ActivePageIndex := 0;
  pgcTransfEstoque.ActivePageIndex := 0;
  fraCadMetasEmpresa.rdgEmpFatOri.ItemIndex := 0;

  If clbCoresIdentificacaoEmpresa.Visible Then
    pCarregarCorIdentificacaoEmpresa;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodEmp, dbeNomEmp, False)
  Else
    pHabilitaCodigo(dbeCodEmp, dbeCodEmp, True);

  pLimpaEdits;
  strPlCtaCtp := '';

//  btnCorFun.Enabled := TRUE;
  btnTintas.Enabled := True;

  tbsConEmp.Enabled := True;
  tbsCfgFin.Enabled := True;
  dbgSocios.Enabled := True;
  tbsPerERF.Enabled := True;

  pCarregaInscricoesSubstitutoTributario;

  objEmpTri.pIniciaInsercao;
  pCarregaConfEmpresas(opIncluir);
  pCarregaQuadroSocietario;
  pCarregaForTri ;
  objEmpFor.fCarregaFornecedores(dbeCodEmp.Text);

  edtDesBan.Text := fRetDescricaoBandeiraEmpresa(dbeCodBan.Text);

  fraCadMetasEmpresa.cxGridMetas.Enabled := True;

  cbxIndAtivPrep.Enabled := True;
  cbxIndAtivPrep.ItemIndex := 2;

  pSetaValoresDefault;

  strEmpOrigem := '';
end;

procedure TfrmCadEmpresas.btnAlterarClick(Sender: TObject);
begin
  inherited;

  strEmpAtiAnt := qryTabela.FieldByName('EMP_EMPATI').AsString;
  strCepAnt    := qryTabela.FieldByName('EMP_C_E_P_').AsString;
  strForFilAnt := qryTabela.FieldByName('EMP_FORFIL').AsString;

  pgcDados.ActivePageIndex := 0;
  pgcTransfEstoque.ActivePageIndex := 0;
  pHabilitaCodigo(dbeCodEmp, dbeNomEmp, False);
//  btnCorFun.Enabled := TRUE;
  btnTintas.Enabled := True;
  dbgSocios.Enabled := True;
  pCarregaConfEmpresas;
  pCarregaQuadroSocietario;
  pCarregaForTri ;
  pCarregaInscricoesSubstitutoTributario;  
  tbsConEmp.Enabled := True;
  tbsCfgFin.Enabled := True;
  tbsPerERF.Enabled := True;
  pHabilitaFornecedores(True);
  fraCadMetasEmpresa.cxGridMetas.Enabled := True;
  cbxIndAtivPrep.Enabled := True;

  If Not objEmpTri.qryTabela.IsEmpty Then
    objEmpTri.qryTabela.Edit;

  strPlCtaCtp := IfNull(qryTabela.FieldByName('EMP_CTACTP').AsString,'');
  If Assigned(objControlaCustoDefinidosNaEmpresa) then
  begin
    objControlaCustoDefinidosNaEmpresa.strCodEmp := dbeCodEmp.Text;
    objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(True);
  End;

  qryTabela.FieldByName('EMP_C_G_C_').ReadOnly := Not fEhAdministrador(strLoginUsuarioLogado);
  qryTabela.FieldByName('EMP_I_E_S_').ReadOnly := Not fEhAdministrador(strLoginUsuarioLogado);
end;

procedure TfrmCadEmpresas.dbeCidadeKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, dbeCidade, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(dbeCidade, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEmpresas.btnCancelaClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;
  pCarregaCidade;
  pCarregaCidadeContab;
  pCarregaCliente;
  pCarregaConfEmpresas;
  pHabiltaCodigoEmpresaMatriz;
//  btnCorFun.Enabled := FALSE;
  btnTintas.Enabled := False;
  cdsConEmp.CancelUpdates;
  cdsFinEmp.CancelUpdates;
  cdsInsSub.CancelUpdates;
  cdsPerERF.CancelUpdates;
  tbsConEmp.Enabled := False;
  tbsCfgFin.Enabled := False;
  tbsPerERF.Enabled := False;
  pgcDados.ActivePageIndex := 0;
  pgcTransfEstoque.ActivePageIndex := 0;
  dbgSocios.Enabled := False;
  cbxIndAtivPrep.Enabled := False;

  If fEmptyStr(dbeCodEmp.Text) Then
    fraCadMetasEmpresa.cdsMeta.EmptyDataSet;

  pCarregaInscricoesSubstitutoTributario;

  pCarregaQuadroSocietario;
  pCarregaForTri ;
  pHabilitaFornecedores(False);
  objEmpFor.fCarregaFornecedores(dbeCodEmp.Text);

  edtDesBan.Text := fRetDescricaoBandeiraEmpresa(dbeCodBan.Text);

  pCarregaDescricaoDoTipoDePlanoDeContaContabil;
  pCarregaDescricaoDaNaturezaJuridica;
  fraCadMetasEmpresa.cxGridMetas.Enabled := False;

  For intIndex := 0 To Length(ARR_REGIME_TRIBUTARIO) -1 Do
    If qryTabela.FieldByName('EMP_REGTRI').AsString = ARR_REGIME_TRIBUTARIO[intIndex][1] Then
      cbxRegTrib.ItemIndex := intIndex;

  pExibeTabRegimeTributario;

  If Not objEmpTri.qryTabela.IsEmpty Then
  Begin
    If objEmpTri.qryTabela.State In [dsEdit, dsInsert] Then
      objEmpTri.qryTabela.Cancel;

    pCarregaDadosEmpTri;
  End;

  fraCadMetasEmpresa.rdgEmpFatOri.ItemIndex := 0;

  If clbCoresIdentificacaoEmpresa.Visible Then
    pCarregarCorIdentificacaoEmpresa;

  btnIncluir.Enabled := fHabilitaBotaoIncluir;

  pCarregaInformacoesDoCertificadoDigital;

  If Assigned(objControlaCustoDefinidosNaEmpresa) then
  begin
    objControlaCustoDefinidosNaEmpresa.strCodEmp := dbeCodEmp.Text;
    objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(False);
  End;

  imgEmp.visible := true;

  dtaIniVig := 0;
  strIESOLD := '';
end;

procedure TfrmCadEmpresas.btnCreditosClick(Sender: TObject);
var
  frmCadEmpresasCreditosFiscais: TfrmCadEmpresasCreditosFiscais;
begin
  inherited;

  If fEmptyStr(dbeCodEmp.Text) Then
  Begin
    pMensagemOk('É necessário selecionar uma empresa.');
    Exit;
  End;

  pCriarFormularios(TfrmCadEmpresasCreditosFiscais, frmCadEmpresasCreditosFiscais);
  Try
    frmCadEmpresasCreditosFiscais.strEmpresaEdicao := dbeCodEmp.Text;
    frmCadEmpresasCreditosFiscais.ShowModal;
  Finally
    pFreeAndNil(frmCadEmpresasCreditosFiscais);
  End;

end;

procedure TfrmCadEmpresas.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  chrKey := '/';
  If fPesqEmpresa(conEmpCompleta, Self, Nil, Nil, qryTabela, chrKey, arrEmp) Then
  Begin
    pSetarVisibilidadeClassificacoesTransferencia(qryTabela.FieldByName('EMP_CODEMP').AsString);
    pAjustaTamanhoGridTransferencia;
    fraCadMetasEmpresa.rdgEmpFatOri.ItemIndex := 0;
    pgcDados.ActivePageIndex := 0;
    pgcTransfEstoque.ActivePageIndex := 0;
    pCarregaCidade;
    pCarregaCidadeContab;
    pCarregaCliente;
    pCarregaFornecedor;
    pCarregaPortador;
    pCarregaCentroDeCusto(fraPlanoDeContasCtp.dbeCodCta, fraPlanoDeContasCtp.edtDesCta);
    pCarregaConfEmpresas;
    pCarregaQuadroSocietario;
    pCarregaForTri ;
    pHabiltaCodigoEmpresaMatriz;
    pCarregaInscricoesSubstitutoTributario;
    objEmpFor.fCarregaFornecedores(dbeCodEmp.Text);

    cbxIndAtivPrep.ItemIndex := IIF(qryTabela.FieldByName('EMP_ATIPRE').AsInteger = 9, 5, qryTabela.FieldByName('EMP_ATIPRE').AsInteger);

    edtDesBan.Text := fRetDescricaoBandeiraEmpresa(dbeCodBan.Text);

    pCarregaDescricaoDoTipoDePlanoDeContaContabil;
    pCarregaDescricaoDaNaturezaJuridica;

    pContralaVisibilidadeRegCarLig(qryTabela.FieldByName('EMP_CODEMP').AsString);
    If clbCoresIdentificacaoEmpresa.Visible Then
      pCarregarCorIdentificacaoEmpresa;

    pCarregaInformacoesDoCertificadoDigital;
    If Assigned(objControlaCustoDefinidosNaEmpresa) Then
      objControlaCustoDefinidosNaEmpresa.strCodEmp := dbeCodEmp.Text;
    pCarregaImagem;
  End;

end;

procedure TfrmCadEmpresas.btnReplicaRegTribClick(Sender: TObject);
  Var
    frmAguarde: TfrmGravando;
begin
  Try
    pCriarFormularios(TfrmGravando, frmAguarde);
    frmAguarde.fExecutarAcao := fReplicaRegimeTributario;
    frmAguarde.ShowModal;
    pFreeAndNil(frmAguarde);
  Except
    On E: Exception Do
    Begin
      pFreeAndNil(frmAguarde);
      pMensagensErro(E.Message, '');
    End;
  End;

  pHabilitaCstReferenteTransferenciaDeEstoque;
end;

procedure TfrmCadEmpresas.pCarregaCidade;
begin
  pPesquisaCadCid(qryCadCid, qryConCid, dbeCidade.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;
    If (dbeNumCEp.Field <> Nil) And (dbeNumCEp.Field.IsNull) Then
      dbeNumCEp.Text := qryConCid.FieldByName('CID_C_E_P_').AsString;
  End;
end;

procedure TfrmCadEmpresas.pHabiltaCodigoEmpresaMatriz;
Begin
  lblCodMat.Visible := blnInfMat And SameText(dbePreMat.Text, 'S');
  dbeCodMat.Visible := lblCodMat.Visible;
  edtNomMat.Visible := lblCodMat.Visible;

  If edtNomMat.Visible Then
    edtNomMat.Text := fRetNomeEmpresaSelec(dbeCodMat.Text)

  Else If qryTabela.State In [dsEdit, dsInsert] Then
    qryTabela.FieldByName('EMP_CODMAT').Clear;
End;

procedure TfrmCadEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  pgcTransfEstoque.ActivePageIndex := 0;
  pCarregaCidade;
  pCarregaCidadeContab;
  cdsSocios.CreateDataSet;
  dbgSocios.Enabled := False;
  cdsFormTrib.CreateDataSet;

  fraCadMetasEmpresa.pFormShow;

  edtCgcCpf.Visible := (fSetaPais <> opcParaguai);

  If (Not edtCgcCpf.Visible) Then
  Begin
    lblTipCgc.Visible := False;
    lblCgcCpf.Left    := pnlCgcCpf.Left;
  End;

  pCarregaInscricoesSubstitutoTributario;

  pHabilitaCstReferenteTransferenciaDeEstoque;

  dbeNSRBru.Visible := fCfgSis('NSRBRU', varBoolean);
  lblNSRBru.Visible := fCfgSis('NSRBRU', varBoolean);
  btnTintas.Visible := fCfgSis('USATMQ', varBoolean);

  cbxRegTrib.ItemIndex := 0;
  pExibeTabRegimeTributario;
  cbxRegTrib.ItemIndex := -1;

  btnIncluir.Enabled  := fHabilitaBotaoIncluir;
  pCarregaImagem;
  pSetFocus(btnIncluir);

  pnlMltRca.Visible := fCfgSis('UTIABA', varBoolean);
end;

procedure TfrmCadEmpresas.pLimpaEdits;
begin
  edtNomCid.Clear;
  edtEstado.Clear;
  edtNomCli.Clear;
end;

procedure TfrmCadEmpresas.pAtualizaImpostosEmpresas;
  Var
    strSQL,
    strUpdate: String;

    qryUpdate: TUniQuery;
Begin
  If Not blnInfMat Then
    Exit;

  strSQL := '';

  If fCfgSis('INFSAI', VarInteger) = 2 Then
    strSQL := strSQL + ' EMP_ICMSAI = :ICMSAI ';

  If fCfgSis('INFFED', VarInteger) = 2 Then
  Begin
    If Not fEmptyStr(strSQL) Then
      strSQL := strSQL + ', ';

    strSQL := strSQL + ' EMP_IMPFED = :IMPFED ';
  End;

  If fCfgSis('INFOPE', VarInteger) = 2 Then
  Begin
    If Not fEmptyStr(strSQL) Then
      strSQL := strSQL + ', ';

    strSQL := strSQL + ' EMP_DESOPE = :DESOPE ';
  End;

  If Not fEmptyStr(strSQL) Then
  Begin

    strUpdate := '';
    strUpdate := strUpdate + ' UPDATE CADEMP SET ';
    strUpdate := strUpdate +   strSQL;
    strUpdate := strUpdate + ' WHERE ';
    strUpdate := strUpdate + '   LOCATE(EMP_CODEMP, :CODEMP) > 0 ';

    qryUpdate := fCriaQuery;
    With qryUpdate Do
    Begin
      SQL.Text := strUpdate;

      If Params.FindParam('ICMSAI') <> Nil Then
        ParamByName('ICMSAI').Value := qryTabela.FieldByName('EMP_ICMSAI').Value;

      If Params.FindParam('IMPFED') <> Nil Then
        ParamByName('IMPFED').Value := qryTabela.FieldByName('EMP_IMPFED').Value;

      If Params.FindParam('DESOPE') <> Nil Then
        ParamByName('DESOPE').Value := qryTabela.FieldByName('EMP_DESOPE').Value;

      ParamByName('CODEMP').AsString := fRetEmpresasUsamPrecoMatriz;

      ExecSQL;
    End;

  End;

End;

procedure TfrmCadEmpresas.pAtualizarEmpresaCDNovaEmpresa(strNovaLoja : String);
  var
    qryCfgSis   : TUniQuery;
begin

  If strNovaLoja.IsEmpty Then
    Exit;

  If Not Assigned(FObjHerancaEmpresa) Then
    Exit;

  If (fCfgSis('EMP_CD', varString) = FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString) Then
  Begin
    qryCfgSis := fCriaQuery;
    Try
      qryCfgSis.Close;
      qryCfgSis.SQL.Clear;
      qryCfgSis.SQL.Add('UPDATE CFGSIS ' +
                        '   SET SIS_VALCFG = "' + strNovaLoja  + '"' +
                        ' WHERE SIS_CODCFG = "' + 'CFG_EMP_CD' + '"' +
                        '   AND SIS_CODEMP = "' + strNovaLoja  + '"');
      qryCfgSis.ExecSQL;
    Finally
      FreeAndNil(qryCfgSis);
    End;
  End;

end;

Function TfrmCadEmpresas.fEhMatrizInfMat(Var strFiliais: String): Boolean;
  Var
    qryDados: TUniQuery;
Begin
  qryDados := fCriaQuery;
  qryDados.SQL.Text := 'SELECT GROUP_CONCAT(EMP_CODEMP) AS FILIAIS FROM CADEMP WHERE EMP_CODMAT = :CODEMP ';
  qryDados.ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
  qryDados.Open;

  Result := Not qryDados.FieldByName('FILIAIS').IsNull;

  strFiliais := qryDados.FieldByName('FILIAIS').AsString;

  FreeAndNil(qryDados)
End;

Function TfrmCadEmpresas.fEhEmpresaDesseServidor: Boolean;
Begin
  Result := fEmpresaNesteServidor(qryTabela.FieldByName('EMP_CODEMP').AsString);
End;

Function TfrmCadEmpresas.fValidaDesativacao: Boolean;
  Var
    strFiliais: String;
Begin
  Result := True;

  Try

    Try

      If (fDesativandoEmpresa) Then
      Begin

        If Not fEhEmpresaDesseServidor Then
        Begin
          Result := False;

          pMensagemOk('Essa empresa não está na tabela EMPRESAS_NESTE_SERVIDOR e não pode ser desativada.');
          Exit;
        End;

        If fCfgSis('EMPGER', varBoolean, qryTabela.FieldByName('EMP_CODEMP').AsString) Then
        Begin
          Result := False;

          pMensagemOk('Essa empresa está configurada como Gerencial (CFG_EMPGER) e não pode ser desativada.');
          Exit;
        End;

        If fCfgSis('INFMAT', varBoolean, qryTabela.FieldByName('EMP_CODEMP').AsString) Then
        Begin

          If fEhMatrizInfMat(strFiliais) Then
          Begin
            Result := False;

            pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
            frmMensagemExplicativa.Caption := 'Desativação de Empresa';
            frmMensagemExplicativa.mmoInstru.Text := 'Essa empresa não pode ser desativada por se matriz das filiais: ' + strFiliais + '.';
            frmMensagemExplicativa.ShowModal;
            pFreeAndNil(frmMensagemExplicativa);

            Exit;
          End;

        End;

        If fCfgSis('REPPRC', varString, qryTabela.FieldByName('EMP_CODEMP').AsString) = '2' Then
        Begin
          Result := False;

          pMensagemOk('Essa empresa está configurada para replicar preços para todas as outras (CFG_REPPRC) e não pode ser desativada.');
          Exit;
        End;

        If Result Then
          Result := fPergunta('A empresa será desativada e os preços de todos os seus produtos serão zerados.' + #13#10 +
                              'Confirma a invalidação do preços?', False);
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadEmpresas.fValidaDesativacao]');
      End;

    End;


  Finally

    If Not Result Then
      qryTabela.FieldByName('EMP_EMPATI').AsString := 'S';

  End;
End;

Function TfrmCadEmpresas.fVeSeZeraPrecosEmpresa: Boolean;
  Var
    frmGravando: TfrmGravando;
Begin
  Result := TfrmGravando.fExecuta(fVeSeZeraPrecosEmpresaPrg, frmGravando, 'Zerando preços, aguarde...', False);
End;

Function TfrmCadEmpresas.fVeSeZeraPrecosEmpresaPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    strFiliais,
    strBkpIteger: String;
    qryIteger: TUniQuery;
Begin
  Result := True;

  Try
    If (strEmpAtiAnt = 'S') And
       (qryTabela.FieldByName('EMP_EMPATI').AsString = 'N') Then
    Begin
      If fCfgSis('EMPGER', varBoolean, qryTabela.FieldByName('EMP_CODEMP').AsString) Then
        Exit;

      If fCfgSis('INFMAT', varBoolean, qryTabela.FieldByName('EMP_CODEMP').AsString) And fEhMatrizInfMat(strFiliais) Then
        Exit;

      If fCfgSis('REPPRC', varString, qryTabela.FieldByName('EMP_CODEMP').AsString) = '2' Then
        Exit;

      strBkpIteger := Concat('ITEGER_', qryTabela.FieldByName('EMP_CODEMP').AsString, '_INATIV_EMPRESA_', FormatDateTime('YYYYMMDD', VS_Date));

      qryIteger := fCriaQuery;

      If Not fTabelaExisteFat(strBkpIteger, Nil) Then
      Begin
        qryIteger.SQL.Text := 'CREATE TABLE ' + strBkpIteger +
                              ' SELECT * FROM ITEGER WHERE ITE_CODEMP = :CODEMP';

        qryIteger.ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
        qryIteger.Execute;
      End;

      qryIteger.Close;
      qryIteger.SQL.Text := 'UPDATE ITEGER SET' +
                            '  ITE_PREVE1 = 0, ITE_MARBR1 = 0, ' +
                            '  ITE_PREVE2 = 0, ITE_MARBR2 = 0, ' +
                            '  ITE_PREVE3 = 0, ITE_MARBR3 = 0, ' +
                            '  ITE_PREVE4 = 0, ITE_MARBR4 = 0, ' +
                            '  ITE_PREVE5 = 0, ITE_MARBR5 = 0, ' +
                            '  ITE_PREVE6 = 0, ITE_MARBR6 = 0, ' +
                            '  ITE_PREVE7 = 0, ITE_MARBR7 = 0  ' +
                            ' WHERE ITE_CODEMP = :CODEMP';

      qryIteger.ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
      qryIteger.Execute;

      FreeAndNil(qryIteger);
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadEmpresas.fVeSeZeraPrecosEmpresaPrg]');
    End;

  End;

End;

Function TfrmCadEmpresas.fConfirmaAtivacao: Boolean;
Begin
  If (qryTabela.State = dsEdit) And
     (qryTabela.FieldByName('EMP_EMPATI').OldValue = 'N') And
     (qryTabela.FieldByName('EMP_EMPATI').AsString = 'S') Then
  Begin

    pCriarFormularios(TfrmConfirmacaoMemo, frmConfirmacaoMemo);

    frmConfirmacaoMemo.Width := 720;
    frmConfirmacaoMemo.Height := 250;
    frmConfirmacaoMemo.memMsg.ReadOnly := True;

    Result := frmConfirmacaoMemo.fConfirma('Alteração de Empresa', 'Ativação de Empresa',
                        'Esta empresa está sendo ativada neste momento.' + #13#10 +
                        'Os preços dos produtos estão zerados.' + #13#10 +
                        'Após confirmar a gravação uma Alteração Global de Preços na empresa Matriz dessa' + #13#10 +
                        'filial deverá ser realizada manualmente para que os preços sejam atualizados.' + #13#10 +
                        'Confirma?');

    pFreeAndNil(frmConfirmacaoMemo);

  End Else
    Result := True;
End;

procedure TfrmCadEmpresas.pAtualizarForcus(strNovaLoja : String);
  Const
    strAtualizaSQL = 'INSERT INTO FORCUS (AUTOINCREM, FOR_CODCAM, FOR_CODEMP, FOR_BASCAL) '+
                     'VALUES ( :AUTOINCREM, :CODCAM, :CODEMP, :BASCAL) ';
  Var
    qryForcus,
    qryAtualizaForcus   : TUniQuery;
begin

  If strNovaLoja.IsEmpty Then
    Exit;

  If Not Assigned(FObjHerancaEmpresa) Then
    Exit;

  qryForcus := fCriaQuery;
  qryAtualizaForcus := fCriaQuery;

  Try
    fStartTransaction();
    Try
      qryForcus.Close;
      qryForcus.SQL.Clear;
      qryForcus.SQL.Add('SELECT FOR_CODCAM, FOR_BASCAL FROM FORCUS WHERE FOR_CODEMP = '+
                         QuotedStr(FObjHerancaEmpresa.cdsHeranca.FieldByName('HER_EMPORI').AsString));
      qryForcus.Open;
      qryAtualizaForcus.SQL.Text := strAtualizaSQL;

      If (Not qryForcus.IsEmpty) Then
      Begin
        qryForcus.First;
        While (Not qryForcus.EOF) Do
        Begin
          qryAtualizaForcus.ParamByName('AUTOINCREM').AsString := fRetAutoIncrem('FORCUS', strNovaLoja);
          qryAtualizaForcus.ParamByName('CODCAM').AsString     := qryForcus.FieldByName('FOR_CODCAM').AsString;
          qryAtualizaForcus.ParamByName('CODEMP').AsString     := strNovaLoja;
          qryAtualizaForcus.ParamByName('BASCAL').AsString     := qryForcus.FieldByName('FOR_BASCAL').AsString;
          qryAtualizaForcus.ExecSQL;
          qryForcus.Next;
        End;
      End;
    Finally
      fCommit();
      qryForcus.Close;
      FreeAndNil(qryForcus);
      FreeAndNil(qryAtualizaForcus);
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      qryForcus.Close;
      FreeAndNil(qryForcus);
      FreeAndNil(qryAtualizaForcus);
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadEmpresas.btnGravarClick(Sender: TObject);
  Var
    blnInserindo: Boolean;

begin
  blnInserindo := (qryTabela.State = dsInsert);

  If blnInserindo Then
    qryTabela.FieldByName('EMP_DTACAD').AsDateTime := fNow();

  If clbCoresIdentificacaoEmpresa.Visible Then
    qryTabela.FieldByName('EMP_CORIDE').AsString :=
      AUTCOM_NOME_CORES_IDENT_EMPRESA[clbCoresIdentificacaoEmpresa.ItemIndex];

  If fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContasCtp.dbeCodCta.Text)) Then
    qryTabela.FieldByName('EMP_CTACTP').Clear;

  If fEmptyStr(fTiraCaracEspeciais(dbeCliFil.Text)) Then
    qryTabela.FieldByName('EMP_CLIFIL').Clear;

  If fEmptyStr(fTiraCaracEspeciais(dbeCodBan.Text)) Then
    qryTabela.FieldByName('EMP_CODBAN').Clear;

  If blnIniCon and fEmptyStr(fTiraCaracEspeciais(dbeIniCon.Text)) Then
    qryTabela.FieldByName('EMP_INICON').Clear;

  If Not fValidaFinEmp Then
    Exit;

  If Not fValidaInscricoesSubstitutoTributario Then
    Exit;

  If Not fValidaPermissaoTipoVenda Then
    Exit;

  pAllTrimCampos;

  If (Not fEmptyStr(dbeClat01.Text)) Or
     (Not fEmptyStr(dbeClat02.Text)) Or
     (Not fEmptyStr(dbeClat03.Text)) Or
     (Not fEmptyStr(dbeClat04.Text)) Or

     (Not fEmptyStr(dbeClatt1.Text)) Or
     (Not fEmptyStr(dbeClatt2.Text)) Or
     (Not fEmptyStr(dbeClatt3.Text)) Or

     (Not fEmptyStr(dbeClati1.Text)) Or
     (Not fEmptyStr(dbeClati2.Text)) Or
     (Not fEmptyStr(dbeClati3.Text)) Or

     (Not fEmptyStr(dbeCltti1.Text)) Or
     (Not fEmptyStr(dbeCltti2.Text)) Or
     (Not fEmptyStr(dbeCltti3.Text)) Then
  Begin

    If (fEmptyStr(dbeCliFil.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Para utilizar as classificações de transferência de saída, ' + #13#10 +
                            'o cliente filial deve estar preenchido!!', ['&Ok']);

      pgcDados.ActivePageIndex := 0;
      pSetFocus(dbeCliFil);
      Exit;

    End;
  End;

  If (Not fEmptyStr(dbeClaTe1.Text)) Or
     (Not fEmptyStr(dbeClaTe2.Text)) Or
     (Not fEmptyStr(dbeClaTe3.Text)) Or
     (Not fEmptyStr(dbeClTeV1.Text)) Or
     (Not fEmptyStr(dbeClTeV2.Text)) Or
     (Not fEmptyStr(dbeClTeV3.Text)) Then
  Begin

    If (fEmptyStr(dbeForFil.Text)) Then
    Begin

      fMensagem('ATENÇÃO!', 'Para utilizar as classificações de transferência de Entrada, ' + #13#10 +
                            'o fornecedor filial deve estar preenchido!!', ['&Ok']);


      pgcDados.ActivePageIndex := 0;
      pSetFocus(dbeForFil);
      Exit;

    End;
  End;

  If (Not blnInserindo) And
     (fAlterandoCNPJ) And
     (VS_SpoolImpressaoCitel) And
     (dbeCodEmp.Text = fRetEmpresaFisica) Then
  Begin
    If Not fTabelaExiste('SPOAUT') Or fTabelaVazia('SPOAUT') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para alterar o CNPJ desta empresa, é indispensável '+
        'entrar em contato imediatamente com a CITEL para que seja realizada a '+
        'atualização da API do Spooler de Impressão.', ['&OK']);
      pgcDados.ActivePageIndex := 0;
      pSetFocus(dbeNumCgc);
      Exit;
    End;
  End;

  If not fValidaCnpjEmpresaVsCertificadoDigital Then
  Begin
    fMensagem('ATENÇÃO!', 'A raiz do CNPJ da empresa não é igual ao do Certificado Digital.', ['&Ok']);

    Exit;
  End;

  If (blnUtiCon) and (fEmptyStr(dbeTplAco.Text)) Then
    qryTabela.FieldByName('EMP_TPLACO').Value := Null;

  If (blnSpdEcf) and (fEmptyStr(dbeNatJur.Text)) Then
    qryTabela.FieldByName('EMP_NTJURI').Value := Null;

//  blnUsaVerificaCamposPai := False;

  if not fValidacoesBotaoGravarPai then
  begin
    Exit;
  end;

  If Not fValidaDesativacao Then
    Exit;

  If Not fConfirmaAtivacao Then
    Exit;

  If (Not blnInserindo) And (fAlterandoCNPJ or fDesativandoEmpresa) And (fTemDocumentosPendentesDeAutorizacao(dbeCodEmp.Text)) Then
  Begin
    If (fDesativandoEmpresa) Then
      fMensagem('ATENÇÃO!', 'Para desativar esta empresa é necessário resolver os documentos pendentes de autorização!', ['&OK'])
    Else
      fMensagem('ATENÇÃO!', 'Para alterar o CNPJ desta empresa é necessário resolver os documentos pendentes de autorização!', ['&OK']);
    pgcDados.ActivePageIndex := 0;
    pSetFocus(dbeNumCgc);
    Exit;
  End;

  qryTabela.FieldByName('EMP_ATIPRE').AsInteger := IIF(cbxIndAtivPrep.ItemIndex = 5, 9, cbxIndAtivPrep.ItemIndex);

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If (blnInserindo) and (fValidaClassificacoes) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Classificações não preenchidas, Gostaria de herdar da empresa de origem do CFGSIS: ' + strEmpOrigem + '?', ['&Sim', '&Não'], 2) = 1 then
    Begin
      pReplicaClassificacoes(strEmpOrigem);
    End;
  End;

  Try
    If cbxRegTrib.ItemIndex > -1 Then
      qryTabela.FieldByName('EMP_REGTRI').AsString := ARR_REGIME_TRIBUTARIO[cbxRegTrib.ItemIndex][1];

    pSetaDadosEditEmpTri;

    inherited;

    pExibeTabRegimeTributario;

    If blnGravou Then
    Begin
      If Not fVeSeZeraPrecosEmpresa Then
      Begin
        fRollBack;
        Exit;
      End;

      If Assigned(objControlaCustoDefinidosNaEmpresa) Then
      begin
        If not objControlaCustoDefinidosNaEmpresa.fGravar(dbeCodEmp.Text) Then
        Begin
          fRollBack;
          Exit;
        End
      End;

      fraCadMetasEmpresa.pGravarMetas;

      If Not fGravaDadosRegimeTributario Then
      Begin
        fRollBack;
        Exit;
      End;

      If not fGravaEmpCat Then
      Begin
        fRollBack;
        Exit;
      End;

      If blnInserindo Then
      Begin
        If Not fSalvaConfEmpresas(opIncluir) Then
        Begin
          fRollBack;
          Exit;
        End;
      End Else
      Begin
        If Not fSalvaConfEmpresas(opAlterar) Then
        Begin
          fRollBack;
          Exit;
        End;
      End;

      If Not fGravarInscricoesSubstitutoTributario Then
      Begin
        fRollBack;
        Exit;
      End;

      If (Not fGravaLogAlteracaoIES(dtaIniVig)) Then
      Begin
        fRollBack;
        fMensagem('ATENÇÃO!', 'Erro ao Gravar Log da Alteração da Inscrição Estadual!', ['&Ok']);
        Exit;
      End
      Else
      Begin
        strIESOLD := '';
        dtaIniVig := 0;
      End;

      pSalvaQuadroSocietario;
      pSalvaForTri;

      If Not objEmpFor.fSalvaFornecedores(dbeCodEmp.Text) Then
      Begin
        fRollBack;
        Exit;
      End;

      pAtualizaImpostosEmpresas;

      If Not SameText(strForFilAnt, qryTabela.FieldByName('EMP_FORFIL').AsString) Then
      Begin

        If fAtualizaSaldoPedidoCompraGeral Then
          fCommit
        Else
         fRollBack;

      End

      Else fCommit;
    End

    Else fRollBack;

  Except

    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pMensagensErro(E.Message, '[TfrmCadEmpresas.btnGravarClick]');
    End;

  End;

  If Assigned(objControlaCustoDefinidosNaEmpresa) then
  begin
    If blnGravou Then
      objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(False)
    Else
      objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(true);
  End;

  If Not blnGravou Then
    Exit;

  If (qryTabela.FieldByName('EMP_CODEMP').AsString = VS_strCodEmp) Then
  Begin
    VS_strRazSoc := dbeNomEmp.Text;
  End;
  VS_strCliFil := fRetClientesFilial;

  If (blnInserindo) And (blnGravou) Then
  Begin
    fMensagem('', 'SERÃO GERADOS OS ITENS E AS CONFIGURAÇÕES PARA A NOVA EMPRESA. ESSE PROCESSO PODE DEMORAR!', ['&Ok']);

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fConfiguraFiliais;
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);
    Except
      On E: Exception Do
      Begin
        pFreeAndNil(frmGravando);
        pMensagensErro(E.Message, '');
      End;
    End;

    If (fCfgSis('FRMCUS', VarInteger) = 4) Then
    Begin
      pAtualizarForcus(qryTabela.FieldByName('EMP_CODEMP').AsString);
    End;

    fMensagem('', 'Atualização Concluída!', ['&Ok']);
  End;

  pHabilitaFornecedores(False);
  pCarregaInscricoesSubstitutoTributario;
  pCarregaConfEmpresas;

  If (blnGravou) Then
  Begin
    //  btnCorFun.Enabled := FALSE;
    btnTintas.Enabled   := False;
    tbsConEmp.Enabled   := False;
    tbsCfgFin.Enabled   := False;
    tbsPerERF.Enabled   := False;
    fraCadMetasEmpresa.cxGridMetas.Enabled := False;
    dbgSocios.Enabled   := False;
    btnIncluir.Enabled  := fHabilitaBotaoIncluir;
    cbxIndAtivPrep.Enabled := False;
  End;

  If Assigned(frmPrincipal) And (StrToIntDef(dbeCorFun.Text,0) > 0) And
     (dbeCodEmp.Text = Vs_strCodEmp) Then
    frmPrincipal.pnlFundo.Color := fRetCorEmpresa(Vs_strCodEmp);

  If blnGravou Then
    pgcDados.ActivePageIndex := 0;

  blnGravou := False;
  dtaIniVig := 0;
  strIESOLD := '';
end;

procedure TfrmCadEmpresas.btnExcForClick(Sender: TObject);
begin
  inherited;

  objEmpFor.pExcluiFornecedor;
end;

procedure TfrmCadEmpresas.btnExcluirClick(Sender: TObject);
  Var
    strCodEmp: String;
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    inherited;
    strCodEmp := dbeCodEmp.Text;
    If blnExcluiu Then
    Begin
      pDeletaIteGer(strCodEmp);
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  pCarregaCidade;
  pCarregaCidadeContab;
  pCarregaCliente;
  dbgSocios.Enabled := False;
  pHabiltaCodigoEmpresaMatriz;
  pCarregaInscricoesSubstitutoTributario;
  objEmpFor.fCarregaFornecedores(dbeCodEmp.Text);

  edtDesBan.Text := fRetDescricaoBandeiraEmpresa(dbeCodBan.Text);

  pCarregaDescricaoDoTipoDePlanoDeContaContabil;
  pCarregaDescricaoDaNaturezaJuridica;

  btnIncluir.Enabled  := fHabilitaBotaoIncluir;

  pCarregaInformacoesDoCertificadoDigital;

  If Assigned(objControlaCustoDefinidosNaEmpresa) then
  begin
    objControlaCustoDefinidosNaEmpresa.pAbrirStatusEdicao(False);
  End;
end;

procedure TfrmCadEmpresas.pDeletaIteGer(strCodEmp: String);
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

procedure TfrmCadEmpresas.pEditaEmpresa;
begin
  If qryTabela.State = dsBrowse Then
    qryTabela.Edit;
end;

procedure TfrmCadEmpresas.pExibeTabRegimeTributario;
begin
  tbsLucroReal.TabVisible       := cbxRegTrib.ItemIndex = 0;
  tbsLucroPresumido.TabVisible  := cbxRegTrib.ItemIndex = 1;
  tbsSimplesNacional.TabVisible := (cbxRegTrib.ItemIndex = 2) Or (cbxRegTrib.ItemIndex = 3);
  tbsCat42.TabVisible           := (cbxRegTrib.ItemIndex = 0) Or (cbxRegTrib.ItemIndex = 1);

  If tbsLucroReal.TabVisible Then
    pgcRegTrib.ActivePage := tbsLucroReal;

  If tbsLucroPresumido.TabVisible Then
    pgcRegTrib.ActivePage := tbsLucroPresumido;

  If tbsSimplesNacional.TabVisible Then
    pgcRegTrib.ActivePage := tbsSimplesNacional;
end;

procedure TfrmCadEmpresas.pgcDadosChange(Sender: TObject);
begin
  inherited;
  If (pgcDados.ActivePage = TabSheet1) Then
  Begin
    If (Assigned(qryTabela)) And (Assigned(qryTabela.FindField('EMP_CODEMP'))) Then
      fraCadMetasEmpresa.edtCodEmp.Text := qryTabela.FieldByName('EMP_CODEMP').AsString;
  End;
end;

function TfrmCadEmpresas.fGravaDadosRegimeTributario: Boolean;
begin
  Result := True;

  If Not (objEmpTri.qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  objEmpTri.qryTabela.FieldByName('TRI_CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;
  pSetaValoresComboToDataSetRegimeTributario;
  Result := objEmpTri.fGravaDados;
end;

function TfrmCadEmpresas.dbeCidadeChamaCadastro(Key: Word): String;
begin
  inherited;
  Result    := fChamaCadCid(Key);
  qryConCid := qryCadCid;
end;

procedure TfrmCadEmpresas.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, dbeCliFil.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCadEmpresas.dbeCliFilKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCliFil, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCliFil, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresas.dbeCNAEKeyPress(Sender: TObject; var Key: Char);
Var
  arrCadCnae : TConsultasArray;
begin
  inherited;
  If fPesqCNAE(conSimples, Self, dbeCNAE, Nil, Nil, Key, arrCadCnae) Then
    If fValidaCampos(dbeCNAE) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadEmpresas.dbeCodBanKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSelec: TConsultasArray;
begin
  inherited;

  If fPesqBandeiraEmpresa(Self, dbeCodBan, edtDesBan, Nil, Key, arrSelec) Then
  Begin
    If fValidaCampos(dbeCodBan, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEmpresas.dbeCodEmpExit(Sender: TObject);
begin
  strCodEmpOld := dbeCodEmp.Text;

  dbeCodEmp.Field.AsString := fPadL(dbeCodEmp.Field.AsString, 3, '0');

  inherited;

  fValidaCampos(dbeCodEmp, True);
end;

procedure TfrmCadEmpresas.dbeCodMatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, dbeCodMat, edtNomMat, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodMat, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresas.dbeCodPorKeyPress(Sender: TObject; var Key: Char);
var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqPortador(conSimples, Self, dbeCodPor, edtDesPor, Nil, Key, arrSel) Then
  begin
    if fValidaCampos(dbeCodPor, True) then
      Self.SelectNext(ActiveControl, True, True);
  end;
end;
procedure TfrmCadEmpresas.dbeCorFunChange(Sender: TObject);
  Var
    strColor : String;
begin
  inherited;

  Try
    If qryTabela.IsEmpty Then
      Exit;

    If TDBEditFocus(Sender).Field = Nil Then
      Exit;

    strColor := TDBEditFocus(Sender).Field.AsString;
    if not fEmptyStr(strColor) then
    Begin
      TDBEditFocus(Sender).Color      := StrToIntDef(strColor,0);
      TDBEditFocus(Sender).NormalColor:= StrToIntDef(strColor,0);
      TDBEditFocus(Sender).FocusColor := StrToIntDef(strColor,0);
      TDBEditFocus(Sender).Font.Color := StrToIntDef(strColor,0);
    End
    else
    begin
      TDBEditFocus(Sender).Color      := clWindow;
      TDBEditFocus(Sender).NormalColor:= clWindow;
      TDBEditFocus(Sender).FocusColor := clWindow;
      TDBEditFocus(Sender).Font.Color := clBlack;
    end;
  except

  End;


end;

function TfrmCadEmpresas.dbeCliFilChamaCadastro(Key: Word): String;
begin
  inherited;
  Result    := fchamaCadCli(Key);
  qryConCid := qryCadCid;
end;

procedure TfrmCadEmpresas.dbeForFilKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, dbeForFil, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeForFil, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresas.dbeIbgeCidCtbKeyPress(Sender: TObject; var Key: Char);
Var
    arrCidade: TConsultasArray;
    edtCodCidContabAux: TCustomEdit;
begin
  inherited;
  Try
    edtCodCidContabAux := TCustomEdit.Create(Nil);
    {****************************}
    {* NOVA CONSULTA DE CIDADES *}
    {*************************RV*}
    If fPesqCidade(Self, edtCodCidContabAux, edtCidContab, edtEstContab, Nil, Key, arrCidade) Then
    Begin
      dbeIbgeCidCtb.Field.Value := fCampoTabela('CID_COIBGE', 'CADCID', ['CID_CODCID'], [edtCodCidContabAux.Text], False);
      If fValidaCampos(dbeIbgeCidCtb, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(edtCodCidContabAux);
  End;
end;

procedure TfrmCadEmpresas.dbeNatJurKeyPress(Sender: TObject; var Key: Char);
Var
  arrTip : TConsultasArray;
begin
  inherited;
  If fPesqNaturezaJuridica(Self, dbeNatJur, edtDescricaoNaturezaJuridica, Nil, Key, arrTip) Then
  Begin
    if fValidaCampos(dbeNatJur, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresas.dbeNumCEpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    dbeNumCep.Text := fConsultarCep(Self, dbeNumCep.Text, dbeNumCep);

  End;
end;

procedure TfrmCadEmpresas.dbeSomaFatCAT42Exit(Sender: TObject);
begin
  inherited;
  pCarregaValoresCAT42;
end;

procedure TfrmCadEmpresas.dbeTplAcoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrTip : TConsultasArray;
begin
  inherited;
  If fPesqTipoDePlanoDeContaContabil(Self, dbeTplAco, edtDescricaoDoTipoDePlanoDeContaContabil,
    Nil, Key, arrTip) Then
  Begin
    if fValidaCampos(dbeTplAco, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEmpresas.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeForFil.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

function TfrmCadEmpresas.dbeForFilChamaCadastro(Key: Word): String;
begin
  inherited;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  Result    := untFuncIns.fChamaCadFor(Key);
  qryConCid := qryCadCid;
end;

procedure TfrmCadEmpresas.dbeClaTe1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  If fPesqCFOP(Self, (Sender As TDBEditFocus), Nil, Nil, Key, arrCFOP) Then
  Begin
    If fValidaCampos((Sender As TDBEditFocus), True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadEmpresas.fraPlanoDeContasCtpdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadEmpresas.fraPlanoDeContasCtpdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
  strMask        : String;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Key = '/' Then
  Begin
    strMask := '';
    strMask := dtsTabela.DataSet.FieldByName('EMP_CTACTP').EditMask;
    dtsTabela.DataSet.FieldByName('EMP_CTACTP').EditMask := '';

    If fPesqCentroCusto(Self, fraPlanoDeContasCtp.dbeCodCta, fraPlanoDeContasCtp.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroDeCusto(fraPlanoDeContasCtp.dbeCodCta, fraPlanoDeContasCtp.edtDesCta);
      if (qryTabela.State In [dsInsert]) or (strPlCtaCtp <> fraPlanoDeContasCtp.dbeCodCta.Text) then
        PlanoDeContasAtivo(fraPlanoDeContasCtp.dbeCodCta.Text,True);
    End;

    dtsTabela.DataSet.FieldByName('EMP_CTACTP').EditMask := strMask;
  End;

end;

function TfrmCadEmpresas.fReplicaCfg(strEmpOri: String; strEmpDes: String) : Boolean;
const
  strINSERT_CFGSIS = 'INSERT INTO CFGSIS (SIS_CODEMP, SIS_CODCFG, SIS_DESCRI, SIS_VALCFG, SIS_GRUCFG, SIS_NUMHLP, SIS_LAYOUT) ' +
                     '(SELECT :DES_CODEMP, SIS_CODCFG, SIS_DESCRI, SIS_VALCFG, SIS_GRUCFG, SIS_NUMHLP, SIS_LAYOUT FROM CFGSIS WHERE SIS_CODEMP = :ORI_CODEMP)';
Var
  qryGenCfg : TUniQuery;
begin

  If (FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCFGSIS)) Then
    Result := FObjHerancaEmpresa.fExecutarHeranca(thcCFGSIS, strEmpOri, strEmpDes)
  Else
  Begin

    Try
      qryGenCfg := fCriaQuery;
      qryGenCfg.SQL.LineBreak := '';
      qryGenCfg.SQL.Text := strINSERT_CFGSIS.ReplaceEx(chrESPACO_DUPLO, chrESPACO);
      Try
        qryGenCfg.ParamByName('ORI_CODEMP').AsString := strEmpOri;
        qryGenCfg.ParamByName('DES_CODEMP').AsString := strEmpDes;
        qryGenCfg.ExecSQL;
        Result := True;
        FObjHerancaEmpresa.pGravaLogRep(qryGenCfg, 'CFGSIS', strEmpOri, strEmpDes);
      Except
        Result := False;
      End;
    Finally
      FreeAndNil(qryGenCfg);
    End;

  End;

end;

function TfrmCadEmpresas.fReplicaCfgEmp(strEmpOri, strEmpDes: String): Boolean;
const
  strINSERT_CFGEMP = 'INSERT INTO CFGEMP (SELECT CFG_SEQGER, :DES_CODEMP, CFG_CHAVE_ FROM CFGEMP WHERE CFG_CODEMP = :ORI_CODEMP)';
Var
  qryGenCfg: TUniQuery;
begin

  If (FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCFGEMP)) Then
    Result := FObjHerancaEmpresa.fExecutarHeranca(thcCFGEMP, strEmpOri, strEmpDes)
  Else
  Begin

    Try
      qryGenCfg := fCriaQuery;
      qryGenCfg.SQL.LineBreak := '';
      qryGenCfg.SQL.Text := strINSERT_CFGEMP.ReplaceEx(chrESPACO_DUPLO, chrESPACO);
      Try
        qryGenCfg.ParamByName('ORI_CODEMP').AsString := strEmpOri;
        qryGenCfg.ParamByName('DES_CODEMP').AsString := strEmpDes;
        qryGenCfg.ExecSQL;
        Result := True;
        FObjHerancaEmpresa.pGravaLogRep(qryGenCfg, 'CFGEMP', strEmpOri, strEmpDes);
      Except
        Result := False;
      End;
    Finally
      FreeAndNil(qryGenCfg);
    End;

  End;

end;

function TfrmCadEmpresas.fReplicaCfgTin(strEmpOri, strEmpDes: String): Boolean;
const
  strINSERT_CFGTIN = 'INSERT INTO CFGTIN (SELECT :DES_CODEMP, CFG_IDEPRO, CFG_CODCFG, CFG_VALCFG, CFG_DESCRI, CFG_GRUCFG FROM CFGTIN WHERE CFG_CODEMP = :ORI_CODEMP)';
Var
  qryGenCfg: TUniQuery;
begin

  If (FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCFGTIN)) Then
    Result := FObjHerancaEmpresa.fExecutarHeranca(thcCFGTIN, strEmpOri, strEmpDes)
  Else
  Begin

    Try
      qryGenCfg := fCriaQuery;
      qryGenCfg.SQL.LineBreak := '';
      qryGenCfg.SQL.Text := strINSERT_CFGTIN.ReplaceEx(chrESPACO_DUPLO, chrESPACO);
      Try
        qryGenCfg.ParamByName('ORI_CODEMP').Value := strEmpOri;
        qryGenCfg.ParamByName('DES_CODEMP').Value := strEmpDes;
        qryGenCfg.ExecSQL;
        Result := True;
        FObjHerancaEmpresa.pGravaLogRep(qryGenCfg, 'CFGTIN', strEmpOri, strEmpDes);
      Except
        Result := False;
      End;
    Finally
      FreeAndNil(qryGenCfg);
    End;

  End;

end;

procedure TfrmCadEmpresas.pReplicaClassificacoes(const strEmpOri: String);
  Var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(Self);

  Try

    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   E.EMP_CLAT01, E.EMP_CLAT02, E.EMP_CLAT03, E.EMP_CLAT04, ');
    qryAux.SQL.Add('   E.EMP_CLATT1, E.EMP_CLATT2, E.EMP_CLATT3, ');
    qryAux.SQL.Add('   E.EMP_CLATI1, E.EMP_CLATI2, E.EMP_CLATI3, ');
    qryAux.SQL.Add('   E.EMP_CLTTI1, E.EMP_CLTTI2, E.EMP_CLTTI3, ');
    qryAux.SQL.Add('   E.EMP_CLTEV1, E.EMP_CLTEV2, E.EMP_CLTEV3, ');
    qryAux.SQL.Add('   E.EMP_CLATE1, E.EMP_CLATE2, E.EMP_CLATE3 ');
    qryAux.SQL.Add(' FROM CADEMP E WHERE EMP_CODEMP = :CODEMP ');
    qryAux.ParamByName('CODEMP').AsString := strEmpOri;
    qryAux.Open;

    If (Not qryAux.IsEmpty) Then
    Begin

      //Classificações de Venda
      qryTabela.FieldByName('EMP_CLAT01').Value :=  IfNull(qryAux.FieldByName('EMP_CLAT01').Value, Null);
      qryTabela.FieldByName('EMP_CLAT02').Value :=  IfNull(qryAux.FieldByName('EMP_CLAT02').Value, Null);
      qryTabela.FieldByName('EMP_CLAT03').Value :=  IfNull(qryAux.FieldByName('EMP_CLAT03').Value, Null);
      qryTabela.FieldByName('EMP_CLAT04').Value :=  IfNull(qryAux.FieldByName('EMP_CLAT04').Value, Null);

      //Classificações de Transferência
      qryTabela.FieldByName('EMP_CLATT1').Value :=  IfNull(qryAux.FieldByName('EMP_CLATT1').Value, Null);
      qryTabela.FieldByName('EMP_CLATT2').Value :=  IfNull(qryAux.FieldByName('EMP_CLATT2').Value, Null);
      qryTabela.FieldByName('EMP_CLATT3').Value :=  IfNull(qryAux.FieldByName('EMP_CLATT3').Value, Null);

      //Classificações de Industrialização
      qryTabela.FieldByName('EMP_CLATI1').Value :=  IfNull(qryAux.FieldByName('EMP_CLATI1').Value, Null);
      qryTabela.FieldByName('EMP_CLATI2').Value :=  IfNull(qryAux.FieldByName('EMP_CLATI2').Value, Null);
      qryTabela.FieldByName('EMP_CLATI3').Value :=  IfNull(qryAux.FieldByName('EMP_CLATI3').Value, Null);

      //Classificações de Transferência de Produtos Industrialização
      qryTabela.FieldByName('EMP_CLTTI1').Value :=  IfNull(qryAux.FieldByName('EMP_CLTTI1').Value, Null);
      qryTabela.FieldByName('EMP_CLTTI2').Value :=  IfNull(qryAux.FieldByName('EMP_CLTTI2').Value, Null);
      qryTabela.FieldByName('EMP_CLTTI3').Value :=  IfNull(qryAux.FieldByName('EMP_CLTTI3').Value, Null);

      //Classificações de Compra
      qryTabela.FieldByName('EMP_CLTEV1').Value :=  IfNull(qryAux.FieldByName('EMP_CLTEV1').Value, Null);
      qryTabela.FieldByName('EMP_CLTEV2').Value :=  IfNull(qryAux.FieldByName('EMP_CLTEV2').Value, Null);
      qryTabela.FieldByName('EMP_CLTEV3').Value :=  IfNull(qryAux.FieldByName('EMP_CLTEV3').Value, Null);

      //Classificações de Transferência
      qryTabela.FieldByName('EMP_CLATE1').Value :=  IfNull(qryAux.FieldByName('EMP_CLATE1').Value, Null);
      qryTabela.FieldByName('EMP_CLATE2').Value :=  IfNull(qryAux.FieldByName('EMP_CLATE2').Value, Null);
      qryTabela.FieldByName('EMP_CLATE3').Value :=  IfNull(qryAux.FieldByName('EMP_CLATE3').Value, Null);

    End;
  finally
    FreeAndNil(qryAux);
  end;

end;

function TfrmCadEmpresas.fReplicaCnf_Nfe(strEmpOri, strEmpDes: String): Boolean;
const
  strINSERT_CNF_NFE = 'INSERT INTO CNF_NFE (SELECT CNF_CODSEQ, CNF_IDENTI, CNF_DESCAM, :DES_CODEMP, CNF_SETOR_, CNF_TIPMSG, :NFE_ULTALT FROM CNF_NFE WHERE CNF_CODEMP = :ORI_CODEMP)';
Var
  qryCnf_Nfe: TUniQuery;
begin

  If (FObjHerancaEmpresa.fHerdarDadosDoBancoFisico(thcCNF_NFE)) Then
    Result := FObjHerancaEmpresa.fExecutarHeranca(thcCNF_NFE, strEmpOri, strEmpDes)
  Else
  Begin

    Try
      qryCnf_Nfe := fCriaQuery;
      qryCnf_Nfe.SQL.LineBreak := '';
      qryCnf_Nfe.SQL.Text := strINSERT_CNF_NFE.ReplaceEx(chrESPACO_DUPLO, chrESPACO);
      Try
        qryCnf_Nfe.ParamByName('ORI_CODEMP').Value := strEmpOri;
        qryCnf_Nfe.ParamByName('DES_CODEMP').Value := strEmpDes;
        qryCnf_Nfe.ParamByName('NFE_ULTALT').Value := Null;
        qryCnf_Nfe.ExecSQL;
        Result := True;
      Except
        Result := False;
      End;
    Finally
      FreeAndNil(qryCnf_Nfe);
    End;

  End;

end;

{function TfrmCadEmpresas.fReplicaPermissaoTipoVenda(strEmpDes: String): Boolean;
Var
  strSQL   : String;
  qryIns   : TUniQuery;
  strFilter: String;
  blnFilter: Boolean;
  intRecNo : Integer;
begin

  strFilter := qryCadEmp.Filter;
  blnFilter := qryCadEmp.Filtered;
  intRecNo  := qryCadEmp.RecNo;

  Try

    qryCadEmp.Filter   := '';
    qryCadEmp.Filtered := False;


    qryIns := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM VENEMP WHERE FALSE ';

    With qryIns Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      qryCadEmp.First;

      While Not qryCadEmp.Eof Do
      Begin
        If (qryCadEmp.FieldByName('EMP_CODEMP').AsString <> strEmpDes) Then
        Begin
          Insert;
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('VENEMP', VS_strCodEmp);
          FieldByName('VEN_EMPORI').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          FieldByName('VEN_EMPDES').AsString := strEmpDes;
          FieldByName('VEN_PERRET').AsString := 'S';
          FieldByName('VEN_PERENT').AsString := 'S';
          FieldByName('VEN_PERFUT').AsString := 'S';
          Post;
        End;

        qryCadEmp.Next;
      End;

      Result := True;

    End;

  Finally
    FreeAndNil(qryIns);
    qryCadEmp.Filter   := strFilter;
    qryCadEmp.Filtered := blnFilter;
    qryCadEmp.RecNo    := intRecNo;
  End;
end;}

function TfrmCadEmpresas.fReplicaRegimeTributario(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    frmSelEmpresas: TfrmSelEmpresas;

  procedure pSetMax(intMax: Integer);
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Properties.Max := intMax;
  End;

  procedure pSetPos(intPosition: Integer);
  begin
    If Assigned(pgbStatus) Then
      pgbStatus.Position := intPosition;
  end;
begin
  Result := True;

  pgbStatus.Position := 0;
  pInfoStatusGravacao('Selecionando as Empresas. Aguarde...', pgbStatus);

  Try
    pCriarFormularios(TfrmSelEmpresas, frmSelEmpresas);
    With frmSelEmpresas Do
    Begin
      strCodEmp := qryTabela.FieldByName('EMP_CODEMP').AsString;
      ShowModal;

      pSetaValoresComboToDataSetRegimeTributario;

      If ModalResult = mrOk Then
      Begin
        qryCadEmp.Filtered := False;
        qryCadEmp.Filter   := 'MARDES = ' + QuotedStr('M');
        qryCadEmp.Filtered := True;

        pSetMax(qryCadEmp.RecordCount);

        If Not qryCadEmp.IsEmpty Then
        Begin
          pInfoStatusGravacao('Replicando Regime Tributário. Aguarde...', pgbStatus);

          qryCadEmp.First;

          While Not qryCadEmp.Eof Do
          Begin
            objEmpTri.pReplicaRegimeTributario(qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                                               qryTabela.FieldByName('EMP_REGTRI').AsString);

            pSetPos(qryCadEmp.RecNo);
            qryCadEmp.Next;
            Application.ProcessMessages;
          End;
        End;
      End;
    End;
  Finally
    pFreeAndNil(frmSelEmpresas);
  End;
end;

procedure TfrmCadEmpresas.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If Active Then
    Begin

      If FindField('EMP_C_G_C_') <> nil Then
        TStringField(FieldByName('EMP_C_G_C_')).EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);

      If FindField('EMP_C_E_P_') <> nil Then
        TStringField(FieldByName('EMP_C_E_P_')).EditMask := '99999-999;0;_';

      If FindField('EMP_FONE01') <> nil Then
        TStringField(FieldByName('EMP_FONE01')).EditMask := fRetMascaraFonePais;

      If FindField('EMP_FONE02') <> nil Then
        TStringField(FieldByName('EMP_FONE02')).EditMask := fRetMascaraFonePais;

      If FindField('EMP_FONDA1') <> nil Then
        TStringField(FieldByName('EMP_FONDA1')).EditMask := fRetMascaraFonePais;

      If FindField('EMP_FONDA2') <> nil Then  //0800
        TStringField(FieldByName('EMP_FONDA2')).EditMask := '9999-9999-9999;0;_';

      If FindField('EMP_F_A_X_') <> nil Then
        TStringField(FieldByName('EMP_F_A_X_')).EditMask := fRetMascaraFonePais;

      If FindField('EMP_ICMANT') <> nil Then
        TFloatField(FieldByName('EMP_ICMANT')).DisplayFormat := '#,##0.00';

      If FindField('EMP_ALQCLI') <> nil Then
        TFloatField(FieldByName('EMP_ALQCLI')).DisplayFormat := '#,##0.0000';

      If FindField('EMP_IPIANT') <> nil Then
        TFloatField(FieldByName('EMP_IPIANT')).DisplayFormat := '#,##0.00';

      If FindField('EMP_PISANT') <> nil Then
        TFloatField(FieldByName('EMP_PISANT')).DisplayFormat := '#,##0.00';

      If FindField('EMP_COFANT') <> nil Then
        TFloatField(FieldByName('EMP_COFANT')).DisplayFormat := '#,##0.00';

      If FindField('EMP_DTADSP') <> nil Then
        TDateField(FieldByName('EMP_DTADSP')).EditMask := '99/99/9999';

      If FindField('EMP_INICON') <> nil Then
        TDateField(FieldByName('EMP_INICON')).EditMask := '99/99/9999';

      If FindField('EMP_CODCTA') <> nil Then
        TStringField(FieldByName('EMP_CODCTA')).EditMask := '99.99.999;0;_';

      If FindField('EMP_CTATRA') <> nil Then
        TStringField(FieldByName('EMP_CTATRA')).EditMask := '99.99.999;0;_';

      If FindField('EMP_CTACTP') <> nil Then
        TStringField(FieldByName('EMP_CTACTP')).EditMask := '99.99.999;0;_';

      If FindField('EMP_ICMENT') <> nil Then
        TFloatField(FieldByName('EMP_ICMENT')).DisplayFormat := '#,##0.00';

      If FindField('EMP_SUBFED') <> nil Then
        TFloatField(FieldByName('EMP_SUBFED')).DisplayFormat := '#,##0.00';

      If FindField('EMP_ICMSAI') <> nil Then
        TFloatField(FieldByName('EMP_ICMSAI')).DisplayFormat := '#,##0.00';

      If FindField('EMP_IMPFED') <> nil Then
        TFloatField(FieldByName('EMP_IMPFED')).DisplayFormat := '#,##0.00';

      If FindField('EMP_DESOPE') <> nil Then
        TFloatField(FieldByName('EMP_DESOPE')).DisplayFormat := '#,##0.00';

      If FindField('EMP_MARPAD') <> nil Then
        TFloatField(FieldByName('EMP_MARPAD')).DisplayFormat := '#,##0.00';

      If FindField('EMP_NSRBRU') <> nil Then
        TFloatField(FieldByName('EMP_NSRBRU')).DisplayFormat := '#,##0.00';
    End;
  End;

  If clbCoresIdentificacaoEmpresa.Visible Then
    pCarregarCorIdentificacaoEmpresa;

  fraCadMetasEmpresa.cdsMeta.EmptyDataSet;
end;

procedure TfrmCadEmpresas.pCarregaAtualizaTEPPRO;
begin
  fInsertTEPPRO;

  With qryTepPro Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TEPPRO'+IIF(Not fCfgSis('UTISIC', varBoolean),' WHERE TEP_CODIGO <> "SIC"',''));
    Open;
  End;
end;

procedure TfrmCadEmpresas.pCarregaAtualizaTEPREV;
begin
  fInsertTEPREV;

  With qryTeprev Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM TEPREV'+IIF(Not fCfgSis('UTISIC', varBoolean),' WHERE TEP_CODIGO <> "SIC"',''));
    Open;
  End;
end;

procedure TfrmCadEmpresas.pCarregaCentroDeCusto(dbeCodCta: TDBEditFocus; edtDesCta: TEditFocus);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, dbeCodCta.Text);
  edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
end;

procedure TfrmCadEmpresas.pAtualizaCidade(qryConsulta: TUniQuery; edtCidade, edtEstado: TEdit; dbeCidade, dbeCep: TDBEditFocus; var strCepAnt: String);
begin
  pPesquisaCadCid(qryCadCid, qryConsulta, dbeCidade.Text);

  edtCidade.Text := qryConsulta.FieldByName('CID_NOMCID').AsString;
  edtEstado.Text := qryConsulta.FieldByName('CID_ESTADO').AsString;

  If (Assigned(dbeNumCEp)) And (dbeNumCEp.Field <> Nil) And (dbeNumCEp.Field.IsNull) Then
  Begin
    dbeNumCEp.Text := qryConsulta.FieldByName('CID_C_E_P_').AsString;
    strCepAnt   := qryConsulta.FieldByName('CID_C_E_P_').AsString;
  End;

end;

procedure TfrmCadEmpresas.btnTintasClick(Sender: TObject);
  Var
    frmCadEmpresasTintometricos: TfrmCadEmpresasTintometricos;
begin
  inherited;

  If Not btnTintas.Visible Then
    Exit;

  If Not Assigned(fRetornaPreco) Then
  Begin
    fMensagem('ATENÇÃO!', 'O sistema não está configurado corretamente para a utilização de tinta de máquina.', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadEmpresasTintometricos, frmCadEmpresasTintometricos);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadEmpresas.btnTintasClick]');
      Exit;
    End;
  End;

  frmCadEmpresasTintometricos.strTintas := qryTabela.FieldByName('EMP_TINDIS').AsString;
  If frmCadEmpresasTintometricos.ShowModal = mrOk Then
  Begin
    qryTabela.FieldByName('EMP_TINDIS').AsString := frmCadEmpresasTintometricos.strTintas;
  End;
  pFreeAndNil(frmCadEmpresasTintometricos);

end;

procedure TfrmCadEmpresas.cbxLpDesOChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLpDesRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLpJurPChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLpJurRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLrDesRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLrJurRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxRegTribChange(Sender: TObject);
begin
  inherited;

  pExibeTabRegimeTributario;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxSnDesRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxSnJurRChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cdsConEmpBeforePost(DataSet: TDataSet);
var
  cdsClone: TUniClientDataSet;
  QtdeSeq: Integer;
begin
  inherited;
  if DataSet.FieldByName('CON_SEQTRA').AsInteger = 0 then
    DataSet.FieldByName('CON_SEQTRA').Clear;

  Try
    If fEmptyStr(DataSet.FieldByName('CON_CODTEP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de transferência não promocional deve ser preenchido!', ['&OK']);
      DataSet.Cancel;
      Abort;
    End;
    If fEmptyStr(DataSet.FieldByName('CON_TEPPRO').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de transferência promocional deve ser preenchido!', ['&OK']);
      DataSet.Cancel;
      Abort;
    End;

    if cxgTraEstDBTableView1CON_SEQTRA.Visible then
    begin
      if DataSet.FieldByName('CON_SEQTRA').AsInteger < 0 then
      begin
        fMensagem('ATENÇÃO!', 'Nº da sequencia inválido!', ['&OK']);
        DataSet.Cancel;
        Abort;
      end
      else
      if (not DataSet.FieldByName('CON_SEQTRA').isNull) then
      begin
        QtdeSeq := 0;
        cdsClone := TUniClientDataSet.Create(nil);
        try
          cdsClone.CloneCursor(cdsConEmp, False);
          cdsClone.First;
          while not cdsClone.Eof do
          begin
            if (cdsClone.FieldByName('CON_SEQTRA').Value = DataSet.FieldByName('CON_SEQTRA').Value) and
               (cdsClone.FieldByName('CON_EMPDES').Value <> DataSet.FieldByName('CON_EMPDES').Value) then
              Inc(QtdeSeq);

            cdsClone.Next;
          end;

          if QtdeSeq > 0 then
          begin
            fMensagem('ATENÇÃO!', 'Este nº de sequencia já foi preenchido para outra empresa!', ['&OK']);
            DataSet.Cancel;
            Abort;
          end;
        finally
          cdsClone.Free;
        end;
      end;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadEmpresas.cdsConEmpBeforePost]');
      Abort;
    End;
  End;
end;

procedure TfrmCadEmpresas.cdsEmpCatBeforePost(DataSet: TDataSet);
begin
  inherited;
  If fEmptyStr(cdsEmpCat.FieldByName('CAT_TOTVAL').asString) then
    cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat := 0.00;
  If fEmptyStr(cdsEmpCat.FieldByName('CAT_TOTVA2').asString) then
    cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat := 0.00;
end;

procedure TfrmCadEmpresas.clbCoresIdentificacaoEmpresaGetColors(
  Sender: TCustomColorBox; Items: TStrings);
Var
  I: Integer;
begin
  inherited;
  For I := 0 To Length(AUTCOM_NOME_CORES_IDENT_EMPRESA) -1 Do
    Items.AddObject(AUTCOM_NOME_CORES_IDENT_EMPRESA[I],
      TObject(AlphaColorToColor(AUTCOM_CORES_IDENT_EMPRESA[I])));
end;

procedure TfrmCadEmpresas.cbxLrJurPChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxLrDesOChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxSnJurPChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cbxSnDesOChange(Sender: TObject);
begin
  inherited;
  pEditaEmpresa;
end;

procedure TfrmCadEmpresas.cxgForPreViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_DELETE: btnExcFor.Click;
    VK_RETURN: Begin
                 If not Assigned(AItem) then
                   Exit;

                 If not (AItem is TcxGridDBColumn) then
                   Exit;

                 If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'EFR_CODFOR' then
                   Exit;

                 AItem.GridView.NavigatorButtons.Post.Click;
                 cxgForPreView.NavigatorButtons.Insert.Click;
               End;
  End;
  
end;

procedure TfrmCadEmpresas.cxgForPreViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    qryCadFor: TUniQuery;
    arrFornec: TConsultasArray;
begin
  inherited;

  If not Assigned(AItem) then
    Exit;

  If not (AItem is TcxGridDBColumn) then
    Exit;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'EFR_CODFOR' then
    Exit;

  If fEntraCons(Key) Then
  Begin

    qryCadFor := fCriaQuery(Self);

    If fPesqFornecedor(conForSimples, Self, Nil, Nil, qryCadFor, Key, arrFornec) Then
    Begin
      AItem.EditValue := qryCadFor.FieldByName('FOR_CODFOR').AsString;

      If (AItem.Index + 1) < (AItem.GridView.ItemCount) then
      begin
        AItem.GridView.Items[AItem.Index + 1].EditValue := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    End;

    FreeAndNil(qryCadFor);

  End;

end;

procedure TfrmCadEmpresas.cxgInsSubViewBands0HeaderClick(Sender: TObject);
  Var
    strInsSubTrib: String;
begin
  inherited;
  
  If qryTabela.State In [dsEdit, dsInsert] Then
  Begin

    strInsSubTrib := fInputDialog('Inscrição Estadual do Substituto Tributário',
                                  'Digite a Inscrição Estadual do Substituto Tributário:', '', 20);

    If fEmptyStr(strInsSubTrib) And (fMensagem('', 'Inscrição Estadual não foi informada! ' + #13#10 +
                                                   'Deseja continuar?', ['&Não','&Sim']) = 1) Then
    Begin
      Exit;
    End;

    If Not fValidaIES(strInsSubTrib, qryConCid.FieldByName('CID_ESTADO').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', strInsSubTrib + ' não é uma Inscrição Estadual Válida!', ['&Ok']);
      Exit;
    End;

    With cdsInsSub Do
    Begin
      First;
      While Not Eof Do
      Begin
        Edit;
        FieldByName('EMP_INSSUB').AsString := strInsSubTrib;
        Post;
        Next;
      End;
      First;
    End;

  End;

end;

procedure TfrmCadEmpresas.cxgInsSubViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_RETURN: If cdsInsSub.State In [dsEdit] Then cdsInsSub.Post;
  End;
end;

procedure TfrmCadEmpresas.cxrFat_TEPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If fStrToFloat(VarToStrDef(DisplayValue, '0')) <= 0 Then
  Begin
    DisplayValue := '0';
    Error := False;
  End;
end;

procedure TfrmCadEmpresas.pLimparEditsSocios;
begin
  edtNomSoc.Clear;
  edtNumR_G.Clear;
  mskNumCpf.Clear;
  edtCidSoc.Clear;
  edtCgcCpf.Clear;
  edtOrgEmissor.Clear;
  edtProfissao.Clear;
  edtEstCivil.Clear;
  edtDesCidSoc.Clear;
  edtEstadoSoc.Clear;
  pSetFocus(edtNomSoc);
end;

procedure TfrmCadEmpresas.pOnStateChange;
begin
  inherited;
  btnCreditos .Enabled := btnGravar.Enabled;
  If clbCoresIdentificacaoEmpresa.Visible Then
    clbCoresIdentificacaoEmpresa.Enabled := btnGravar.Enabled;
end;

procedure TfrmCadEmpresas.btnAdicionarSocClick(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtNomSoc.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'É necessário que informe o nome do sócio para o seu cadastramento!!', ['&Ok'] );
    pSetFocus(edtNomSoc);
    Exit;
  End;

  If (Not fValidaPanel(pnlCabecalho, True)) Then
  Begin
    Exit;
  End;

  If (blnAltSocio) Then
    cdsSocios.Edit
  Else
    cdsSocios.Append;

  cdsSocios.FieldByName('SOC_NOMSOC').AsString := edtNomSoc.Text;
  cdsSocios.FieldByName('SOC_NUMR_G').AsString := edtNumR_G.Text;
  cdsSocios.FieldByName('SOC_NUMCPF').AsString := fFormataCpfCgc(mskNumCpf.Text, FPais);
  cdsSocios.FieldByName('SOC_CIDSOC').AsString := edtCidSoc.Text;
  cdsSocios.FieldByName('SOC_CGCCPF').AsString := edtCgcCpf.Text;
  cdsSocios.FieldByName('SOC_ORGEMI').AsString := edtOrgEmissor.Text;
  cdsSocios.FieldByName('SOC_PROFIS').AsString := edtProfissao.Text;
  cdsSocios.FieldByName('SOC_ESTCIV').AsString := edtEstCivil.Text;
  cdsSocios.FieldByName('SOC_NOMCID').AsString := edtDesCidSoc.Text;
  cdsSocios.FieldByName('SOC_ESTADO').AsString := edtEstadoSoc.Text;
  cdsSocios.Post;

  pLimparEditsSocios;

  blnAltSocio := False;
end;

procedure TfrmCadEmpresas.dbgSociosEnter(Sender: TObject);
begin
  inherited;
  blnAltSocio := False;
end;

procedure TfrmCadEmpresas.dbgSociosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    If Not cdsConEmp.IsEmpty Then
      pCarregaSocioAlteracao;

    pSetFocus(edtNomSoc);
  End

  Else If (Key = VK_ESCAPE) Then
  Begin
    pLimparEditsSocios;
    pSetFocus(edtNomSoc);
  End

  Else If (Key = VK_DELETE) Then
  Begin
    If Not cdsSocios.IsEmpty Then
      cdsSocios.Delete;

  End;
end;

procedure TfrmCadEmpresas.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  if Field = dbeCorFun.Field then
    dbeCorFunChange(dbeCorFun);

  btnCertificadoDigital.Enabled := not (dtsTabela.State in [dsEdit, dsInsert]);
  btnCertificadoDigital.Visible := not dtsTabela.DataSet.IsEmpty;

  btnENotas.Enabled := not (dtsTabela.State in [dsEdit, dsInsert]);
  btnENotas.Visible := (not dtsTabela.DataSet.IsEmpty) And (Pos(strLoginUsuarioLogado, '999_998_997_') > 0);
end;

procedure TfrmCadEmpresas.dtsTabelaStateChange(Sender: TObject);
  Var
    blnEnabled: Boolean;
begin
  blnEnabled := dtsTabela.State in dsEditModes;

  fraCadMetasEmpresa.pHabilitaDesabilitaComponentesEdicao(blnEnabled);

  pgcRegTrib.Enabled := dtsTabela.State In [dsInsert, dsEdit];
  pnlTopo.Enabled    := dtsTabela.State In [dsInsert, dsEdit];
end;

procedure TfrmCadEmpresas.pCarregaSocioAlteracao;
begin
  edtNomSoc.Text     := cdsSocios.FieldByName('SOC_NOMSOC').AsString;
  edtNumR_G.Text     := cdsSocios.FieldByName('SOC_NUMR_G').AsString;
  mskNumCpf.Text     := cdsSocios.FieldByName('SOC_NUMCPF').AsString;
  edtCidSoc.Text     := cdsSocios.FieldByName('SOC_CIDSOC').AsString;
  edtCgcCpf.Text     := cdsSocios.FieldByName('SOC_CGCCPF').AsString;
  edtOrgEmissor.Text := cdsSocios.FieldByName('SOC_ORGEMI').AsString;
  edtProfissao.Text  := cdsSocios.FieldByName('SOC_PROFIS').AsString;
  edtEstCivil.Text   := cdsSocios.FieldByName('SOC_ESTCIV').AsString;
  edtDesCidSoc.Text  := cdsSocios.FieldByName('SOC_NOMCID').AsString;
  edtEstadoSoc.Text  := cdsSocios.FieldByName('SOC_ESTADO').AsString;
  pSetFocus(edtNomSoc);

  blnAltSocio := True;
end;

procedure TfrmCadEmpresas.btnCancelarFormaTribClick(Sender: TObject);
begin
  inherited;

  if not btnGravar.Enabled then
  begin
    exit ;
  end;

  pLimparEditsForTri;
  pSetFocus(edtTRI_ANOEXE);
end;


procedure TfrmCadEmpresas.pCarregaQuadroSocietario;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT * FROM CADSOC WHERE SOC_CODEMP = :CODEMP');
  qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
  qryAux.Open;

  cdsSocios.EmptyDataSet;
  While (Not qryAux.Eof) Do
  Begin
    cdsSocios.Append;
    cdsSocios.FieldByName('SOC_NOMSOC').AsString := qryAux.FieldByName('SOC_NOMSOC').AsString;
    cdsSocios.FieldByName('SOC_NUMR_G').AsString := qryAux.FieldByName('SOC_NUMR_G').AsString;
    cdsSocios.FieldByName('SOC_CGCCPF').AsString := qryAux.FieldByName('SOC_CGCCPF').AsString;
    cdsSocios.FieldByName('SOC_NUMCPF').AsString := qryAux.FieldByName('SOC_NUMCPF').AsString;
    cdsSocios.FieldByName('SOC_CIDSOC').AsString := qryAux.FieldByName('SOC_CIDSOC').AsString;
    cdsSocios.FieldByName('SOC_ORGEMI').AsString := qryAux.FieldByName('SOC_ORGEMI').AsString;
    cdsSocios.FieldByName('SOC_PROFIS').AsString := qryAux.FieldByName('SOC_PROFIS').AsString;
    cdsSocios.FieldByName('SOC_ESTCIV').AsString := qryAux.FieldByName('SOC_ESTCIV').AsString;

    If Not fEmptyStr(qryAux.FieldByName('SOC_CIDSOC').AsString) Then
    Begin
      cdsSocios.FieldByName('SOC_NOMCID').AsString := fRetNomCidade(qryAux.FieldByName('SOC_CIDSOC').AsString);
      cdsSocios.FieldByName('SOC_ESTADO').AsString := fRetNomCidade(qryAux.FieldByName('SOC_CIDSOC').AsString, 1);
    End;

    cdsSocios.Post;
    qryAux.Next;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadEmpresas.pCarregarCorIdentificacaoEmpresa;
Var
  I: Integer;
begin
  clbCoresIdentificacaoEmpresa.ItemIndex := 0;
  For I := 0 To Length(AUTCOM_NOME_CORES_IDENT_EMPRESA) -1 Do
    If qryTabela.FieldByName('EMP_CORIDE').AsString.Equals(AUTCOM_NOME_CORES_IDENT_EMPRESA[I]) Then
      clbCoresIdentificacaoEmpresa.ItemIndex := I;
end;

procedure TfrmCadEmpresas.pCarregaRegTriEmp(topOperacao: TTipoOperacao);
  Var
    intIndex: Integer;
begin
  cbxRegTrib.ItemIndex := -1;

  If topOperacao = opIncluir Then
    qryTabela.FieldByName('EMP_REGTRI').AsString := 'R';

  For intIndex := 0 To Length(ARR_REGIME_TRIBUTARIO) -1 Do
    If qryTabela.FieldByName('EMP_REGTRI').AsString = ARR_REGIME_TRIBUTARIO[intIndex][1] Then
      cbxRegTrib.ItemIndex := intIndex;

  pCarregaDadosEmpTri(topOperacao);
  pExibeTabRegimeTributario;

  mskAnoCat.Text  := IntToStr(YearOf(VS_Date));

  pCarregaValoresCAT42;
end;

procedure TfrmCadEmpresas.pCarregaConfigPermissaoTipoVenda(topOperacao: TTipoOperacao = opAlterar);
Begin
  With cdsPerERF.qryQuery, SQL Do
  Begin
    cdsPerERF.Close;
    Close;
    Clear;

    If topOperacao = opAlterar Then
    Begin

      Add('SELECT * FROM VENEMP');
      Add('WHERE VEN_EMPORI = :CODEMP');
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('EMP_CODEMP').AsString;

    End
    Else
    Begin
      Add('SELECT * FROM VENEMP WHERE FALSE');
    End;

    cdsPerERF.pSetProvider;

    Open;

    pSetaClient(cdsPerERF.qryQuery);

    cdsPerERF.Open;

    If topOperacao = opIncluir Then
    Begin
      qryCadEmp.First;
      While Not qryCadEmp.Eof Do
      Begin
        If (topOperacao = opIncluir) Or (qryCadEmp.FieldByName('EMP_CODEMP').AsString <> qryTabela.FieldByName('EMP_CODEMP').AsString) Then
        Begin
          cdsPerERF.Insert;
          cdsPerERF.FieldByName('VEN_EMPDES').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
          cdsPerERF.FieldByName('VEN_PERRET').AsString := 'S';
          cdsPerERF.FieldByName('VEN_PERENT').AsString := 'S';
          cdsPerERF.FieldByName('VEN_PERFUT').AsString := 'S';
          cdsPerERF.FieldByName('VEN_PERTRE').AsString := 'S';
          cdsPerERF.FieldByName('VEN_PERMLJ').AsString := 'S';
          cdsPerERF.Post;
        End;

        qryCadEmp.Next;
      End;
    End;

  End;
End;

procedure TfrmCadEmpresas.pSalvaQuadroSocietario;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;
  qryAux.SQL.Add('DELETE FROM CADSOC WHERE SOC_CODEMP = :CODEMP');
  qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
  qryAux.ExecSQL;

  cdsSocios.First;
  While (Not cdsSocios.Eof) Do
  Begin

    qryAux.SQL.Clear;
    qryAux.SQL.Add('INSERT INTO CADSOC (');
    qryAux.SQL.Add('  SOC_CODEMP,  ');
    qryAux.SQL.Add('  SOC_CODSOC,  ');
    qryAux.SQL.Add('  SOC_NOMSOC,  ');
    qryAux.SQL.Add('  SOC_NUMR_G,  ');
    qryAux.SQL.Add('  SOC_NUMCPF,  ');

    If Not fEmptyStr(cdsSocios.FieldByName('SOC_CIDSOC').AsString) Then
      qryAux.SQL.Add('  SOC_CIDSOC,  ');

    qryAux.SQL.Add('  SOC_CGCCPF,  ');
    qryAux.SQL.Add('  SOC_ORGEMI,  ');
    qryAux.SQL.Add('  SOC_PROFIS,  ');
    qryAux.SQL.Add('  SOC_ESTCIV ) ');
    qryAux.SQL.Add(' VALUES (   ');
    qryAux.SQL.Add('  :CODEMP,  ');
    qryAux.SQL.Add('  :CODSOC,  ');
    qryAux.SQL.Add('  :NOMSOC,  ');
    qryAux.SQL.Add('  :NUMR_G,  ');
    qryAux.SQL.Add('  :NUMCPF,  ');

    If Not fEmptyStr(cdsSocios.FieldByName('SOC_CIDSOC').AsString) Then
      qryAux.SQL.Add('  :CIDSOC,  ');

    qryAux.SQL.Add('  :CGCCPF,  ');
    qryAux.SQL.Add('  :ORGEMI,  ');
    qryAux.SQL.Add('  :PROFIS,  ');
    qryAux.SQL.Add('  :ESTCIV ) ');

    qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryAux.ParamByName('CODSOC').AsString := fAtualizaProCod('CADSOC', 'SOC_CODSOC');
    qryAux.ParamByName('NOMSOC').AsString := cdsSocios.FieldByName('SOC_NOMSOC').AsString;
    qryAux.ParamByName('NUMR_G').AsString := cdsSocios.FieldByName('SOC_NUMR_G').AsString;
    qryAux.ParamByName('NUMCPF').AsString := cdsSocios.FieldByName('SOC_NUMCPF').AsString;

    If Not fEmptyStr(cdsSocios.FieldByName('SOC_CIDSOC').AsString) Then
      qryAux.ParamByName('CIDSOC').AsString := cdsSocios.FieldByName('SOC_CIDSOC').AsString;

    qryAux.ParamByName('CGCCPF').AsString := cdsSocios.FieldByName('SOC_CGCCPF').AsString;
    qryAux.ParamByName('ORGEMI').AsString := cdsSocios.FieldByName('SOC_ORGEMI').AsString;
    qryAux.ParamByName('PROFIS').AsString := cdsSocios.FieldByName('SOC_PROFIS').AsString;
    qryAux.ParamByName('ESTCIV').AsString := cdsSocios.FieldByName('SOC_ESTCIV').AsString;
    qryAux.ExecSQL;

    cdsSocios.Next;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadEmpresas.pSetaConfiguracoesDefault(strCodLoj: String);
  Var
    intCnt : Integer;
    qryCfgSis: TUniQuery;
    strValCfgGra: String;
begin
  qryCfgSis := fCriaQuery;
  Try
    If Assigned(arrCamposCfg) Then
    Begin
      For intCnt := Low(arrCamposCfg) To High(arrCamposCfg) Do
      Begin
        If arrCamposCfg[intCnt].blnDefEmp Or arrCamposCfg[intCnt].strPerRep.Equals('N') Then
        Begin
          strValCfgGra := arrCamposCfg[intCnt].strValCfg;

          If AnsiStartsText('SELECT ', strValCfgGra) Then
            strValCfgGra := fExecutaValCfg(strValCfgGra, strCodLoj);

          qryCfgSis.Close;
          qryCfgSis.SQL.Clear;
          qryCfgSis.SQL.Add('UPDATE CFGSIS ' +
                            '   SET SIS_VALCFG = "'  + strValCfgGra + '"' +
                            ' WHERE SIS_CODCFG = "' + arrCamposCfg[intCnt].strCodCfg + '"' +
                            '   AND SIS_CODEMP = "' + strCodLoj + '"');
          qryCfgSis.ExecSQL;
        End;
      End;
    End;
  Finally
    FreeAndNil(qryCfgSis);
  End;
end;

procedure TfrmCadEmpresas.pSetaDadosEditEmpTri;
begin
  If dbeLrPisL.Field <> Nil Then
    dbeLrPisL.Text := dbeLrPisL.Field.AsString;

  If dbeLrCofL.Field <> Nil Then
    dbeLrCofL.Text := dbeLrCofL.Field.AsString;

  If dbeLrIcmL.Field <> Nil Then
    dbeLrIcmL.Text := dbeLrIcmL.Field.AsString;

  If dbeLrIpiL.Field <> Nil Then
    dbeLrIpiL.Text := dbeLrIpiL.Field.AsString;

  If dbeLrRetL.Field <> Nil Then
    dbeLrRetL.Text := dbeLrRetL.Field.AsString;

  If dbeLrFreL.Field <> Nil Then
    dbeLrFreL.Text := dbeLrFreL.Field.AsString;

  If (dbeLpAlqI.Field <> Nil) And (Not fEmptyStr(dbeLpPisL.Field.AsString)) Then
    dbeLpAlqI.Text := FormatFloat('#,##0.00', dbeLpAlqI.Field.AsFloat);

  If (dbeLpAlqC.Field <> Nil) And (Not fEmptyStr(dbeLpPisL.Field.AsString)) Then
    dbeLpAlqC.Text := FormatFloat('#,##0.00', dbeLpAlqC.Field.AsFloat);

  If dbeLpPisL.Field <> Nil Then
    dbeLpPisL.Text := dbeLpPisL.Field.AsString;

  If dbeLpCofL.Field <> Nil Then
    dbeLpCofL.Text := dbeLpCofL.Field.AsString;

  If dbeLpIcmL.Field <> Nil Then
    dbeLpIcmL.Text := dbeLpIcmL.Field.AsString;

  If dbeLpIpiL.Field <> Nil Then
    dbeLpIpiL.Text := dbeLpIpiL.Field.AsString;

  If dbeLpRetL.Field <> Nil Then
    dbeLpRetL.Text := dbeLpRetL.Field.AsString;

  If dbeLpFreL.Field <> Nil Then
    dbeLpFreL.Text := dbeLpFreL.Field.AsString;

  If (dbeSnAlqF.Field <> Nil) And (Not fEmptyStr(dbeSnIcmL.Field.AsString)) Then
    dbeSnAlqF.Text := FormatFloat('#,##0.00', dbeSnAlqF.Field.AsFloat);

  If dbeSnIcmL.Field <> Nil Then
    dbeSnIcmL.Text := dbeSnIcmL.Field.AsString;

  If dbeSnIpiL.Field <> Nil Then
    dbeSnIpiL.Text := dbeSnIpiL.Field.AsString;

  If dbeSnRetL.Field <> Nil Then
    dbeSnRetL.Text := dbeSnRetL.Field.AsString;

  If dbeSnFreL.Field <> Nil Then
    dbeSnFreL.Text := dbeSnFreL.Field.AsString;

  If dbeLrCFFD.Field <> Nil Then
    dbeLrCFFD.Text := dbeLrCFFD.Field.AsString;

  If dbeLpCFFD.Field <> Nil Then
    dbeLpCFFD.Text := dbeLpCFFD.Field.AsString;

  If dbeSnCFFD.Field <> Nil Then
    dbeSnCFFD.Text := dbeSnCFFD.Field.AsString;

  If dbeSomaFatCAT42.Field <> Nil Then
    dbeSomaFatCAT42.Text := dbeSomaFatCAT42.Field.AsString;
end;

procedure TfrmCadEmpresas.pSetaValoresComboToDataSetRegimeTributario;
begin
  If (cbxRegTrib.ItemIndex > -1) And (qryTabela.State In [dsEdit, dsInsert]) Then
    qryTabela.FieldByName('EMP_REGTRI').AsString := ARR_REGIME_TRIBUTARIO[cbxRegTrib.ItemIndex][1];

  If cbxLrJurR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LRJURR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxLrJurR.ItemIndex][1];

  If cbxLrJurP.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LRJURP').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxLrJurP.ItemIndex][1];

  If cbxLrDesR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LRDESR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxLrDesR.ItemIndex][1];

  If cbxLrDesO.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LRDESO').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxLrDesO.ItemIndex][1];

  If cbxLpJurR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LPJURR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxLpJurR.ItemIndex][1];

  If cbxLpJurP.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LPJURP').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxLpJurP.ItemIndex][1];

  If cbxLpDesR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LPDESR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxLpDesR.ItemIndex][1];

  If cbxLpDesO.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_LPDESO').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxLpDesO.ItemIndex][1];

  If cbxSnJurR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_SNJURR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxSnJurR.ItemIndex][1];

  If cbxSnJurP.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_SNJURP').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxSnJurP.ItemIndex][1];

  If cbxSnDesR.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_SNDESR').AsString := ARR_JUROS_DESCONTO_RECEBIDO[cbxSnDesR.ItemIndex][1];

  If cbxSnDesO.ItemIndex > -1 Then
    objEmpTri.qryTabela.FieldByName('TRI_SNDESO').AsString := ARR_JUROS_DESCONTO_RECEBIDO_2[cbxSnDesO.ItemIndex][1];
end;

procedure TfrmCadEmpresas.pSetaValoresDefault;
begin
  qryTabela.FieldByName('EMP_PREMAT').AsString := 'S';
  qryTabela.FieldByName('EMP_EXIAPP').AsString := 'S';
  qryTabela.FieldByName('EMP_IMPCTP').AsString := 'S';
  qryTabela.FieldByName('EMP_GERCMP').AsString := 'S';
  qryTabela.FieldByName('EMP_GERORI').AsString := 'S';
  qryTabela.FieldByName('EMP_USAREP').AsString := 'N';
  qryTabela.FieldByName('EMP_UTIWMS').AsString := 'N';
  qryTabela.FieldByName('EMP_CONPIX').AsString := 'N';
  qryTabela.FieldByName('EMP_UTIABA').AsString := 'N';
  qryTabela.FieldByName('EMP_EMPATI').AsString := 'S';

  If (dbeTabPad.Items.Count > 0) Then
  Begin
    dbeTabPad.ItemIndex := 0;
    qryTabela.FieldByName('EMP_TABPAD').AsString := dbeTabPad.Text;
  End;
end;

procedure TfrmCadEmpresas.spbDicaPortadorClick(Sender: TObject);
var
  frmObservacaoLocal: TfrmObservacao;
begin
  inherited;
  pCriarFormularios(TfrmObservacao, frmObservacaoLocal);

  try
    frmObservacaoLocal.Height := 588;
    frmObservacaoLocal.Width := 918;
    frmObservacaoLocal.lblMensagem.Caption := 'Hierarquia do Portador';
    frmObservacaoLocal.lblMensagem.Alignment := taCenter;
    frmObservacaoLocal.memObs.Clear;
    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    frmObservacaoLocal.memObs.Lines.Add('O Sistema praticará a seguinte hierarquia na escolha do portador utilizado para gravação do'                                                                                              );
    frmObservacaoLocal.memObs.Lines.Add('Contas a Receber e, se necessária, impressão dos boletos:'                                                                                                                                );
    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    frmObservacaoLocal.memObs.Lines.Add('1º. Portador do Cadastro de Empresas'                                                                                                                                                     );
    frmObservacaoLocal.memObs.Lines.Add('2º. Portador do Pedido, quando [CFG_PORPED]Solicitar código do portador na digitação do Pedido de Venda? = SIM'                                                                           );
    frmObservacaoLocal.memObs.Lines.Add('3º. Portador da Forma de Pagamento'                                                                                                                                                       );
    frmObservacaoLocal.memObs.Lines.Add('4º. Portador da Condição de Pagamento'                                                                                                                                                    );
    frmObservacaoLocal.memObs.Lines.Add('5º. Portador do Cadastro de Clintes'                                                                                                                                                      );
    frmObservacaoLocal.memObs.Lines.Add('6º. Portador da Configuração [CFG_PORPOK]Portador para contas a receber e movimento bancário, quando faturar pedidos de'                                                                  );
    frmObservacaoLocal.memObs.Lines.Add('    venda oriundos do Site/Pocket quando pedido do Site / Pocket'                                                                                                                         );
    frmObservacaoLocal.memObs.Lines.Add('7º. Portador da configuração [CFG_PORAVI]Lancamento bancário à vista - Portador para duplicatas à vista'                                                                                  );
    frmObservacaoLocal.memObs.Lines.Add('7º. Portador da configuração [CFG_PCTRAP]Atualização contas a receber à prazo - Portador para duplicata à prazo'                                                                          );
    frmObservacaoLocal.memObs.Lines.Add('-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------');
    frmObservacaoLocal.ShowModal;
  finally
    pFreeAndNil(frmObservacaoLocal);
  end;
end;

procedure TfrmCadEmpresas.tbsAnaliseResultShow(Sender: TObject);
begin
  inherited;

  pSetaDadosEditEmpTri;
end;

procedure TfrmCadEmpresas.edtCgcCpfExit(Sender: TObject);
begin
  inherited;
  If edtCgcCpf.Text = '1' Then
  Begin
    mskNumCpf.EditMask := fRetMascaraC_G_C_(FPais, C_G_C_);
    lblCgcCpf.Caption := 'CNPJ';
  End
  Else
  Begin
    mskNumCpf.EditMask := fRetMascaraC_G_C_(FPais, C_P_F_);
    lblCgcCpf.Caption := 'CPF';
  End;
end;

procedure TfrmCadEmpresas.edtCidSocKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqCidade(Self, edtCidSoc, edtDesCidSoc, edtEstadoSoc, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCidSoc,True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEmpresas.mskAnoCatExit(Sender: TObject);
begin
  inherited;
  If fValidaCampos(mskAnoCat, True) Then
    pCarregaValoresCAT42;
end;

procedure TfrmCadEmpresas.mskNumCpfEnter(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCgcCpf.Text) Or (Pos(edtCgcCpf.Text, '1_2_') <= 0) Then
  Begin
    fMensagem('ATENÇÃO', 'Favor informar primeiro o tipo do documento.' + #13#10 +
                         'O tipo deve ser 1 para C.G.C. ou 2 para C.P.F.!', ['&Ok']);
    pSetFocus(edtCgcCpf);
  End;
end;

procedure TfrmCadEmpresas.edtNomSocExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtNomSoc.Text) Then
  Begin
    If (Not dbgSocios.Enabled) And (dtsCadEmp.State in [dsInsert, dsEdit]) Then
      dbgSocios.Enabled := True;

    pSetFocus(dbgSocios);
  End;

end;

{procedure TfrmCadEmpresas.pGeraLotesEmpresa(strEmpNov: String);
  Var
    qryLotes: TUniQuery;
    objCadLot: TCadLot;
begin
  qryLotes  := fCriaQuery(Self);
  objCadLot := TCadLot.Create(Self);

  With qryLotes, SQL Do
  Begin
    Close;
    Clear;

    Add('SELECT   ');
    Add('  *      ');
    Add('FROM     ');
    Add('  CADLOT ');
    Add('WHERE    ');
    Add('  TRUE   ');

    Open;
    First;

    While Not Eof Do
    Begin
      objCadLot.fGeraLoteEmpresas(qryLotes, False);
      Next;
      Application.ProcessMessages;
    End;

    Close;

  End;

  FreeAndNil(qryLotes);
  FreeAndNil(objCadLot);
end;}

procedure TfrmCadEmpresas.pContralaVisibilidadeRegCarLig(strCodEmp: String);
begin
  dbeALQCLI.Visible := False;
  lblRedCarLig.Visible := False;
  lblSimbolRedCarLiq.Visible := False;

  If fCfgSis('URSTCL', varBoolean, strCodEmp) Then
  begin
    dbeALQCLI.Visible := True;
    lblRedCarLig.Visible := True;
    lblSimbolRedCarLiq.Visible := True;
  End;
End;


procedure TfrmCadEmpresas.pHabilitaFornecedores(blnHabilita: Boolean);
Begin
  cxgForPre.Enabled := blnHabilita;
  pnlForPre.Enabled := blnHabilita;
End;


function TfrmCadEmpresas.fExecutaComandoWindows(AOperation, AFileName, AParameter, ADirectory: String; AShow: Word; AWait: Boolean): Boolean;
var
  LOK: Boolean;
  LInfo: TShellExecuteInfo;
  LRetorno: Longint;
begin
  FillChar(LInfo, SizeOf(LInfo), Chr(0));
  LInfo.cbSize := SizeOf(LInfo);
  LInfo.fMask  := SEE_MASK_NOCLOSEPROCESS;
  LInfo.lpVerb := PChar(AOperation);
  LInfo.lpFile := PChar(AFileName);
  LInfo.lpParameters := PChar(AParameter);
  LInfo.lpDirectory  := PChar(ADirectory);
  LInfo.nShow := AShow;
  LOK := Boolean(ShellExecuteEx(@LInfo));

  if LOK then
  begin
    if AWait then
    begin
      while WaitForSingleObject(LInfo.hProcess, 100) = WAIT_TIMEOUT do
        Application.ProcessMessages;

      LOK := GetExitCodeProcess(LInfo.hProcess, DWORD(LRetorno));
    end
    Else
      LOK := True;
  end;

  Result := LOK;
end;

function TfrmCadEmpresas.fValidaCNPJdoCertificadoDigital(AArquivoPEM: String; var ACNPJ: String; var ARaizCNPJ: Boolean):Boolean;
var
  LFile: TextFile;
  LLine: String;
  LPos : Integer;
  LRet : String;
begin

  Result := False;

  if FileExists(AArquivoPEM) then
  begin
    Try
      AssignFile(LFile, AArquivoPEM);

      Reset(LFile);

      while not EOF(LFile) do
      begin
        Readln(LFile, LLine);

        If Pos('CN=', UpperCase(LLine)) > 0 Then
        Begin
          LPos := Pos(':', UpperCase(LLine));
          if (LPos <> 0) then
          begin
            LRet := trim(copy(LLine, LPos + 1, 14));

            If Length(fTiraCaracEspeciaisPonto(LRet)) = 14 Then
              Break;
          end;
        End;
      end;

      if fEmptyStr(LRet) Then
      begin
        ARaizCNPJ := False;
        ACNPJ := fTiraCaracEspeciaisPonto(dbeNumCgc.text);
        Result := True;
        Exit;
      end;

      If fMensagem('ATENÇÃO!', 'Deseja atualizar o certificado das empresas com a mesma raiz de CNPJ ?', ['&Sim', '&Não'], 1) = 1 Then
      Begin
        Result := Copy(fTiraCaracEspeciaisPonto(dbeNumCgc.text),1,8) = Copy(fTiraCaracEspeciaisPonto(LRet),1,8);

        ACNPJ := fTiraCaracEspeciaisPonto(LRet);

        If not Result Then
          pMensagemOk('Certificado Digital com Raiz de CNPJ diferente da empresa selecionada.'+#13+
                      'Empresa: ['+fTiraCaracEspeciaisPonto(dbeNumCgc.text)+'] Certificado Digital: ['+fTiraCaracEspeciaisPonto(LRet)+']');
      End
      Else
      Begin
        ARaizCNPJ := False;

        Result := fTiraCaracEspeciaisPonto(dbeNumCgc.text) = fTiraCaracEspeciaisPonto(LRet);

        ACNPJ := fTiraCaracEspeciaisPonto(LRet);

        If not Result Then
          pMensagemOk('Certificado Digital com CNPJ diferente da empresa selecionada.'+#13+
                      'Empresa: ['+fTiraCaracEspeciaisPonto(dbeNumCgc.text)+'] Certificado Digital: ['+fTiraCaracEspeciaisPonto(LRet)+']');
      End;

    Finally
      CloseFile(LFile);
    End;
  End;
end;

function TfrmCadEmpresas.fValidadeDoCertificadoDigital(AArquivoVAL: String; var AValidade: TDate): Boolean;
var
  LFile: TextFile;
  LLine: String;
  LPos : Integer;
  LRet : String;

  function Months(LM: string): string;
  begin
    LM := UpperCase(LM);
    if LM = 'JAN' then
      Result := '1'
    else if LM = 'FEB' then
      Result := '2'
    else if LM = 'MAR' then
      Result := '3'
    else if LM = 'APR' then
      Result := '4'
    else if LM = 'MAY' then
      Result := '5'
    else if LM = 'JUN' then
      Result := '6'
    else if LM = 'JUL' then
      Result := '7'
    else if LM = 'AUG' then
      Result := '8'
    else if LM = 'SEP' then
      Result := '9'
    else if LM = 'OCT' then
      Result := '10'
    else if LM = 'NOV' then
      Result := '11'
    else if LM = 'DEC' then
      Result := '12';
  end;

begin

  Result := False;

  if FileExists(AArquivoVAL) then
  begin
    Try
      AssignFile(LFile, AArquivoVAL);

      Reset(LFile);

      while not EOF(LFile) do
      begin
        Readln(LFile, LLine);
        LPos := Pos('NOTAFTER=', UpperCase(LLine));
        if (LPos <> 0) then
        begin
          LRet := trim(copy(LLine, LPos + 9, 25));
          Break;
        end;
      end;

    Finally
      CloseFile(LFile);
    End;

    if not fEmptyStr(LRet) then
    Begin
      AValidade := StrToDate(Copy(LRet, 5, 2) + '/' + Months(Copy(LRet, 1, 3)) + '/' + Copy(LRet, 17, 4));

      Result := (Date <= AValidade);

      If not Result Then
        pMensagemOk('Certificado digital vencido: '+DateToStr(AValidade));
    End;
  end;

end;

function TfrmCadEmpresas.fConverterCertificadoDigital(var AArquivoPFX: String; var AArquivoPEM: String; var AArquivoKEY: String; var AArquivoVAL: String; var ASenha: String; var ACNPJ: String; var AValidade: TDate; var ARaizCNPJ: Boolean): Boolean;
var
  LArquivoPEM : String;
  LArquivoKEY : String;
  LArquivoVAL : String;
  LPathOpenSSL: String;

  function fArquivosValidos: Boolean;
  begin
    Result := True;

    If Result Then
      Result := FileExists(AArquivoPEM);

    If Result Then
      Result := FileExists(AArquivoKEY);

    If Result Then
      Result := FileExists(AArquivoVAL);

    If Result Then
      Result := (fTamanhoArquivo(AArquivoPEM) > 0);

    If Result Then
      Result := (fTamanhoArquivo(AArquivoKEY) > 0);

    If Result Then
      Result := (fTamanhoArquivo(AArquivoVAL) > 0);

    If not Result Then
      pMensagemOk('Não foi possível extrair os dados do Certificado Digital.'+#13+
                  'Verifique o arquivo e a senha!');
  end;

begin

  ARaizCNPJ := True;

  Result := FileOpenCertificadoPFX.Execute ;

  If Result Then
  Begin
    ASenha := InputBox('Certificado Digital',#31+'Senha','');

    LPathOpenSSL := FCaminhoDoOpenSSL;
    AArquivoPFX  := FileOpenCertificadoPFX.FileName;
    AArquivoPEM  := LPathOpenSSL+'cer'+dbeCodEmp.Text+'.pem';
    AArquivoKEY  := LPathOpenSSL+'key'+dbeCodEmp.Text+'.pem';
    AArquivoVAL  := LPathOpenSSL+'val'+dbeCodEmp.Text+'.pem';

    DeleteFile(AArquivoPEM);
    DeleteFile(AArquivoKEY);
    DeleteFile(AArquivoVAL);

    LArquivoPEM := 'openssl pkcs12 -in "'+AArquivoPFX+'" -passin pass:'+ASenha+' -out "'+AArquivoPEM+'" -passout pass:'+ASenha;
    LArquivoKEY := 'openssl pkcs12 -in "'+AArquivoPFX+'" -passin pass:'+ASenha+' -nocerts -out "'+AArquivoKEY+'" -passout pass:'+ASenha;
    LArquivoVAL := 'openssl x509 -in "cer'+dbeCodEmp.Text+'.pem" -noout -enddate > val'+dbeCodEmp.Text+'.pem';

    Result := fExecutaComandoWindows('', 'cmd.exe', PWideChar( '/C ' + LArquivoPEM), PWideChar(LPathOpenSSL), SW_HIDE, True);
    Sleep(500);

    If not Result Then
      Exit;

    Result := fExecutaComandoWindows('', 'cmd.exe', PWideChar( '/C ' + LArquivoKEY), PWideChar(LPathOpenSSL), SW_HIDE, True);
    Sleep(500);

    If not Result Then
      Exit;

    Result := fExecutaComandoWindows('', 'cmd.exe', PWideChar( '/C ' + LArquivoVAL), PWideChar(LPathOpenSSL), SW_HIDE, True);
    Sleep(500);

    If Result Then
      Result := fArquivosValidos;

    If Result Then
      Result := fValidaCNPJdoCertificadoDigital(AArquivoPEM, ACNPJ, ARaizCNPJ);

    If Result Then
      Result := fValidadeDoCertificadoDigital(AArquivoVAL, AValidade);

  End;

  If not Result Then
  Begin
    DeleteFile(AArquivoPEM);
    DeleteFile(AArquivoKEY);
    DeleteFile(AArquivoVAL);
  End;

end;

function TfrmCadEmpresas.fValidaArquivosCertificadoDigital: Boolean;
var
  LPathOpenSSL: String;
begin
  Result := True;

  LPathOpenSSL := FCaminhoDoOpenSSL;

  If not DirectoryExists(LPathOpenSSL) Then
  begin
    fMensagem('ATENÇÃO!', 'Não foi possível encontrar o diretório '+#13+
                          '['+LPathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(LPathOpenSSL+'openssl.exe') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "openssl.exe" inexistente na pasta '+#13+
                          '['+LPathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(LPathOpenSSL+'libeay32.dll') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "libeay32.dll" inexistente na pasta '+#13+
                          '['+LPathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

  If not FileExists(LPathOpenSSL+'ssleay32.dll') Then
  begin
    fMensagem('ATENÇÃO!', 'Arquivo "ssleay32.dll" inexistente na pasta '+#13+
                          '['+LPathOpenSSL+']', ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 0, 650);
    Result := False;
    Exit;
  end;

end;

function TfrmCadEmpresas.fRetornaCaminhoDoOpenSSL: String;
var
  LCaminhoMapeamento: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'OpenSSL\';

  FUnidadeMapeamento := '';

  If not fAplicativoUsaMapeamentoDeRede Then
  Begin
    LCaminhoMapeamento := fRetornaCaminhoMapeamento;
    FUnidadeMapeamento := fRetornaUnidadeDeRedeDisponivel;

    If fMapearUnidadeDeRede(LCaminhoMapeamento, FUnidadeMapeamento) Then
    Begin
      Result := fRetornoCaminhoDoAplicativoComMapeamento(FUnidadeMapeamento) + 'OpenSSL\';
    End;
  End;
end;

procedure TfrmCadEmpresas.pRemoveMapeamentoDeRede;
begin
  If fEmptyStr(FUnidadeMapeamento) Then
    Exit;

  If fExisteUnidadeMapeada(FUnidadeMapeamento) Then
  Begin
    fDesconectaUnidadeDeRede(pChar(FUnidadeMapeamento), True);
  End;
end;

procedure TfrmCadEmpresas.pConverterCertificadoDigital;
var
  LQryCertificado: TUniQuery;
  LQryEmpresas: TUniQuery;
  LArquivoPFX: String;
  LArquivoPEM: String;
  LArquivoKEY: String;
  LArquivoVAL: String;
  LSenha     : String;
  LCNPJ      : String;
  LValidade  : TDate;
  LRaizCNPJ  : Boolean;

  procedure pGravaLogRep(AQryCertificado: TUniQuery);
  var
    LStream: TStringStream;
    LQryLogRep: TUniQuery;
  Begin
    LQryLogRep := fCriaQuery;
    LStream := TStringStream.Create(EmptyStr);
    Try
      //LOGREP
      LStream.WriteString('INSERT INTO LOGREP (LOG_DTACAD, LOG_HRACAD, LOG_TABELA, LOG_CARREG, LOG_COMAND)');
      LStream.WriteString(' VALUES (CURRENT_DATE, CURRENT_TIME, "CADCER", "N", "');
      //LOG_COMAND
      LStream.WriteString('REPLACE INTO CADCER (CER_CODEMP, CER_ARQPFX, CER_ARQPEM, CER_ARQKEY, CER_SENHA_, CER_DTAVAL, CER_C_G_C_)');
      LStream.WriteString(' VALUES (');
      LStream.WriteString(QuotedStr(AQryCertificado.FieldByName('CER_CODEMP').AsString) + ', ');
      LStream.WriteString(fRetValorCampoBlob(TBlobField(LQryCertificado.FieldByName('CER_ARQPFX'))) + ', ');
      LStream.WriteString(fRetValorCampoBlob(TBlobField(LQryCertificado.FieldByName('CER_ARQPEM'))) + ', ');
      LStream.WriteString(fRetValorCampoBlob(TBlobField(LQryCertificado.FieldByName('CER_ARQKEY'))) + ', ');
      LStream.WriteString(QuotedStr(AQryCertificado.FieldByName('CER_SENHA_').AsString) + ', ');
      LStream.WriteString(QuotedStr(FormatDateTime('yyyy-mm-dd', AQryCertificado.FieldByName('CER_DTAVAL').AsDateTime)) + ', ');
      LStream.WriteString(QuotedStr(AQryCertificado.FieldByName('CER_C_G_C_').AsString));
      LStream.WriteString(')');
      //LOGREP                                   v
      LStream.WriteString('");');

      LQryLogRep.SQL.Text := LStream.DataString;
      LQryLogRep.ExecSQL;
    Finally
      FreeAndNil(LStream);
      FreeAndNil(LQryLogRep);
    End;
  End;

  procedure pGravaCertificadoDigital(ACodEmp: String);
  Begin
    Try
      LQryCertificado := fCriaQuery;

      LQryCertificado.SQL.Add('SELECT * FROM CADCER ');
      LQryCertificado.SQL.Add('WHERE CER_CODEMP = :CODEMP');
      LQryCertificado.ParamByName('CODEMP').AsString := ACodEmp;
      LQryCertificado.Open;

      If LQryCertificado.IsEmpty Then
      Begin
        LQryCertificado.Append;
        LQryCertificado.FieldByName('CER_CODEMP').AsString := ACodEmp;
      End
      Else
      Begin
        LQryCertificado.Edit;
      End;

      TBlobField(LQryCertificado.FieldByName('CER_ARQPFX')).LoadFromFile(LArquivoPFX);
      TBlobField(LQryCertificado.FieldByName('CER_ARQPEM')).LoadFromFile(LArquivoPEM);
      TBlobField(LQryCertificado.FieldByName('CER_ARQKEY')).LoadFromFile(LArquivoKEY);

      LQryCertificado.FieldByName('CER_SENHA_').AsString   := fEncriptar(LSenha);
      LQryCertificado.FieldByName('CER_DTAVAL').AsDateTime := LValidade;
      LQryCertificado.FieldByName('CER_C_G_C_').AsString   := LCNPJ;

      LQryCertificado.Post;

      pGravaLogRep(LQryCertificado);
    Finally
      FreeAndNil(LQryCertificado);
    End;
  End;

begin

  Try
    FCaminhoDoOpenSSL := fRetornaCaminhoDoOpenSSL;

    If not fValidaArquivosCertificadoDigital Then
      Exit;

    If fConverterCertificadoDigital(LArquivoPFX, LArquivoPEM, LArquivoKEY, LArquivoVAL, LSenha, LCNPJ, LValidade, LRaizCNPJ) Then
    Begin

      Try
        LQryEmpresas := fCriaQuery;

        LQryEmpresas.SQL.Add('SELECT EMP_CODEMP, EMP_C_G_C_ FROM CADEMP');

        If LRaizCNPJ Then
        Begin
          LQryEmpresas.SQL.Add('WHERE LEFT(EMP_C_G_C_, 8) = :RAIZ');
          LQryEmpresas.ParamByName('RAIZ').AsString := Copy(LCNPJ,1,8);
        End
        Else
        Begin
          LQryEmpresas.SQL.Add('WHERE EMP_C_G_C_ = :CNPJ');
          LQryEmpresas.ParamByName('CNPJ').AsString := LCNPJ;
        End;

        LQryEmpresas.Open;

        While not LQryEmpresas.eof Do
        Begin
          pGravaCertificadoDigital(LQryEmpresas.FieldByName('EMP_CODEMP').AsString);

          pEnotasAtualizaCertificadoDigital(LQryEmpresas.FieldByName('EMP_CODEMP').AsString,
                                            LQryEmpresas.FieldByName('EMP_C_G_C_').AsString);

          LQryEmpresas.Next;
        End;

        pMensagemOk('Certificado digital gravado com sucesso.');

      Finally
        DeleteFile(LArquivoPEM);
        DeleteFile(LArquivoKEY);
        DeleteFile(LArquivoVAL);
        FreeAndNil(LQryEmpresas);
      End;
    End
    Else
      pMensagemOk('Não foi possível gravar o certificado digital.');

  Finally
    pRemoveMapeamentoDeRede;
  End;
end;

procedure TfrmCadEmpresas.pDeterminaExclusaoCertificadoDigital;
var
  LOpcao : Integer;
begin
  If fMensagem('ATENÇÃO!', 'Deseja realmente excluir o certificado digital?', ['&Sim', '&Não'],2) = 2 Then
    Exit;

  LOpcao := fMensagem('', 'Escolha como deve ser feita a exclusão:', ['&Empresa Selecionada', '&Mesma Raiz de CNPJ', '&Sair'], 1, False, 1, 200, False, 0, False, False, True, 0, 650);

  Case LOpcao Of
    1: pExcluirCertificadoDigital(dbeCodEmp.Text);
    2: pExcluirCertificadoDigitalDaMesmaRaizDeCNPJ(dbeNumCgc.Text);
  End;

end;

procedure TfrmCadEmpresas.pExcluirCertificadoDigitalDaMesmaRaizDeCNPJ(ACnpj: String);
var
  LQryEmpresas: TUniQuery;
begin

  LQryEmpresas := fCriaQuery;

  Try
    LQryEmpresas.SQL.Add('SELECT EMP_CODEMP, EMP_C_G_C_ FROM CADEMP');
    LQryEmpresas.SQL.Add('WHERE LEFT(EMP_C_G_C_, 8) = :RAIZ');
    LQryEmpresas.ParamByName('RAIZ').AsString := Copy(ACnpj,1,8);
    LQryEmpresas.Open;

    While not LQryEmpresas.eof Do
    Begin
      pExcluirCertificadoDigital(LQryEmpresas.FieldByName('EMP_CODEMP').AsString);

      LQryEmpresas.Next;
    End;

  Finally
    FreeAndNil(LQryEmpresas);
  End;

end;

procedure TfrmCadEmpresas.pGravaLogRepCadCerDel(const AstrCodEmp: String);
var
  LStream: TStringStream;
  LQryLogRep: TUniQuery;
Begin
  LQryLogRep := fCriaQuery;
  LStream := TStringStream.Create(EmptyStr);
  Try
    //LOGREP
    LStream.WriteString('INSERT INTO LOGREP (LOG_DTACAD, LOG_HRACAD, LOG_TABELA, LOG_CARREG, LOG_COMAND)');
    LStream.WriteString(' VALUES (CURRENT_DATE, CURRENT_TIME, "CADCER", "N", "');
    //LOG_COMAND
    LStream.WriteString('DELETE FROM CADCER WHERE CER_CODEMP = ');
    LStream.WriteString(QuotedStr(AstrCodEmp));
    //LOGREP
    LStream.WriteString('");');
    LQryLogRep.SQL.Text := LStream.DataString;
    LQryLogRep.ExecSQL;
  Finally
    FreeAndNil(LStream);
    FreeAndNil(LQryLogRep);
  End;
End;

procedure TfrmCadEmpresas.pGravaDelCadCer(AqryRegistro: TUniQuery) ;
var
  LintCnt: Integer ;
  LstrColunas: String ;
  LstrComandoSql: String ;
  LqryExec: TUniQuery ;
begin
  LstrColunas := '' ;
  LqryExec := fCriaQuery ;
  try

    for LintCnt := 0 to AqryRegistro.FieldCount-1 do
    begin
      if fEmptyStr(LstrColunas) then
        LstrColunas := AqryRegistro.Fields.Fields[LintCnt].FieldName
      else
        LstrColunas := LstrColunas + ',' + AqryRegistro.Fields.Fields[LintCnt].FieldName ;
    end ;

    LstrComandoSql := 'REPLACE INTO DEL_CADCER ' ;
    LstrComandoSql := LstrComandoSql + '(OPEDEL, DTADEL, HORDEL, ' + LstrColunas + ') ' ;
    LstrComandoSql := LstrComandoSql + '(SELECT "' + strLoginUsuarioLogado + '" AS OPEDEL, CURRENT_DATE AS DTADEL, CURRENT_TIME AS HORDEL, ' + LstrColunas ;
    LstrComandoSql := LstrComandoSql + ' FROM CADCER WHERE CER_CODEMP = "' + AqryRegistro.FieldByName('CER_CODEMP').AsString + '" )  ' ;

    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(LstrComandoSql) ;
    LqryExec.ExecSQL ;

  finally
    FreeAndNil(LqryExec) ;
  end ;
end ;

procedure TfrmCadEmpresas.pExcluirCertificadoDigital(ACodEmpresa: String);
var
  LQryCertificado: TUniQuery;
  LstrCodEmp: String;
begin

  Try
    LQryCertificado := fCriaQuery;

    LQryCertificado.SQL.Add('SELECT * FROM CADCER ');
    LQryCertificado.SQL.Add('WHERE CER_CODEMP = :CODEMP');
    LQryCertificado.ParamByName('CODEMP').AsString := ACodEmpresa;
    LQryCertificado.Open;

    If not LQryCertificado.IsEmpty Then
    Begin
      LstrCodEmp := LQryCertificado.FieldByName('CER_CODEMP').AsString ;
      fVerificaIntegridade(Self.Name, 'CADCER', LQryCertificado, False, True);
      pGravaDelCadCer(LQryCertificado) ;
      LQryCertificado.Delete;
      pGravaLogRepCadCerDel(LstrCodEmp);
    End;

  Finally
    FreeAndNil(LQryCertificado);
  End;

end;

procedure TfrmCadEmpresas.btnCertificadoDigitalClick(Sender: TObject);
var
  LOpcoes    : Integer;
begin
  inherited;

  If fEmptyStr(dbeCodEmp.Text) Then
  Begin
    pMensagemOk('É necessário selecionar uma empresa.');
    Exit;
  End;

  LOpcoes := fMensagem('', 'Escolha as opções abaixo:', ['&Inserir', '&Excluir', '&Sair'], 1, False, 1, 0, False, 0, False, False, True);

  Case LOpcoes Of
    1: pConverterCertificadoDigital;
    2: pDeterminaExclusaoCertificadoDigital;
  End;

  pCarregaInformacoesDoCertificadoDigital;

end;

function TfrmCadEmpresas.fRetornaCnpjDoCertificadoDigitalDaEmpresa: String;
begin
  If fEmptyStr(dbeCodEmp.Text) Then
    Exit;

  Result := fCampoTabela('CER_C_G_C_', 'CADCER', ['CER_CODEMP'], [dbeCodEmp.Text]);
end;

function TfrmCadEmpresas.fValidaCnpjEmpresaVsCertificadoDigital: Boolean;
var LCnpj: String;
begin
  Result := true;

  LCnpj := fRetornaCnpjDoCertificadoDigitalDaEmpresa;

  If fEmptyStr(LCnpj) Then
    Exit;

  Result := (Copy(fTiraCaracEspeciaisPonto(dbeNumCgc.text),1,8) = Copy(fTiraCaracEspeciaisPonto(LCnpj),1,8));
end;

procedure TfrmCadEmpresas.pCarregaInformacoesDoCertificadoDigital;
var
  dtaVencimentoCertificadoDigital: TDateTime;
begin
  pnlCertificadoDigital.Caption := '';

  If not fEmptyStr(dbeCodEmp.Text) Then
  Begin
    dtaVencimentoCertificadoDigital := fRetornoValidadeCertificadoDigital;

    If fDataValida(dtaVencimentoCertificadoDigital) Then
      pnlCertificadoDigital.Caption := 'Certificado Digital cadastrado com vencimento para o dia ' + DateToStr(dtaVencimentoCertificadoDigital)
    Else
      pnlCertificadoDigital.Caption := 'Não existe Certificado Digital cadastrado nessa empresa';
  End;
end;

procedure TfrmCadEmpresas.pHabilitaCstReferenteTransferenciaDeEstoque;
var
  blnCstTra: Boolean;
  strCodEmp: String;
Begin
  strCodEmp := qryTabela.FieldByName('EMP_CODEMP').AsString;

  If (fCfgSis('EMPGER', varBoolean)) And (not fEmptyStr(strCodEmp)) Then
    blnCstTra := fCfgSis('CSTTRA', varBoolean, strCodEmp)
  Else
    blnCstTra := fCfgSis('CSTTRA', varBoolean);

  gpbCSTVen.Visible := blnCstTra;
  gpbCSTTra.Visible := blnCstTra;
  gpbCSTDpf.Visible := blnCstTra;
End;


procedure TfrmCadEmpresas.pCarregaValoresCAT42;
  Var
    qryAux  : TUniQuery;
    intCont : Integer;
begin
  grbValoresAprovCAT42.Visible := (dsRegTri.Dataset.FieldByname('TRI_SNRCAT').asString = 'S');
  If (dsRegTri.Dataset.FieldByname('TRI_SNRCAT').asString = 'S') Then
  Begin
    Try
      qryAux := fCriaQuery(Self);
      qryAux.SQL.Add('SELECT * FROM EMPCAT WHERE CAT_CODEMP = :CODEMP AND CAT_NUMANO = :NUMANO');
      qryAux.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
      qryAux.ParamByName('NUMANO').AsString := mskAnoCat.Text;
      qryAux.Open;

      cdsEmpCat.EmptyDataSet;
      If not qryAux.IsEmpty Then
      Begin
        For intCont := 1 To 12 Do
        Begin
          cdsEmpCat.Append;
          If qryAux.Locate('CAT_NUMMES',intCont,[]) Then
          Begin
            cdsEmpCat.FieldByName('AUTOINCREM').AsString  := qryAux.FieldByName('AUTOINCREM').AsString;
            cdsEmpCat.FieldByName('CAT_CODEMP').AsString  := qryAux.FieldByName('CAT_CODEMP').AsString;
            cdsEmpCat.FieldByName('CAT_NUMANO').asInteger := qryAux.FieldByName('CAT_NUMANO').asInteger;
            cdsEmpCat.FieldByName('CAT_NUMMES').asInteger := qryAux.FieldByName('CAT_NUMMES').asInteger;
            cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat   := qryAux.FieldByName('CAT_TOTVAL').asFloat;
            cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat   := qryAux.FieldByName('CAT_TOTVA2').asFloat;
            cdsEmpCat.FieldByName('MESANO').asString      := fStrZero(qryAux.FieldByName('CAT_NUMMES').asString,2) + '/' + qryAux.FieldByName('CAT_NUMANO').asString;
            cdsEmpCat.FieldByName('IDF_STATUS').AsString  := 'A';
          End
          Else
          Begin
            cdsEmpCat.FieldByName('AUTOINCREM').AsString  := IntToStr(intCont);
            cdsEmpCat.FieldByName('CAT_CODEMP').AsString  := dbeCodEmp.Text;
            cdsEmpCat.FieldByName('CAT_NUMANO').asInteger := StrToInt(mskAnoCat.Text);
            cdsEmpCat.FieldByName('CAT_NUMMES').asInteger := intCont;
            cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat   := 0.00;
            cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat   := 0.00;
            cdsEmpCat.FieldByName('MESANO').asString      := fStrZero(intCont,2) + '/' + mskAnoCat.Text;
            cdsEmpCat.FieldByName('IDF_STATUS').AsString  := 'I';
          End;
          cdsEmpCat.Post;
        End;
      End
      Else
      Begin
        {PREENCHE TODOS OS 12 MESES COM VALOR ZERADO}
        For intCont := 1 To 12 Do
        Begin
          cdsEmpCat.Append;
          cdsEmpCat.FieldByName('AUTOINCREM').AsString  := IntToStr(intCont);
          cdsEmpCat.FieldByName('CAT_CODEMP').AsString  := dbeCodEmp.Text;
          cdsEmpCat.FieldByName('CAT_NUMANO').asInteger := StrToInt(mskAnoCat.Text);
          cdsEmpCat.FieldByName('CAT_NUMMES').asInteger := intCont;
          cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat   := 0.00;
          cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat   := 0.00;
          cdsEmpCat.FieldByName('MESANO').asString      := fStrZero(intCont,2) + '/' + mskAnoCat.Text;
          cdsEmpCat.FieldByName('IDF_STATUS').AsString  := 'I';
          cdsEmpCat.Post;
        End;
      End;
      TFloatField(cdsEmpCat.FieldByName('CAT_TOTVAL')).DisplayFormat := '#,##0.00';
      TFloatField(cdsEmpCat.FieldByName('CAT_TOTVA2')).DisplayFormat := '#,##0.00';
      cdsEmpCat.First;
      pSetFocus(cxGridEmpCat);
      cdsEmpCat.FieldByName('CAT_TOTVAL').FocusControl;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
end;

function TfrmCadEmpresas.fGravaEmpCat : Boolean;
Var
    qryGen: TUniQuery;
Begin
  Result := True;
  Try
    qryGen := fCriaQuery;

    Try
      If dsRegTri.Dataset.FieldByname('TRI_SNRCAT').asString = 'S' Then
      Begin
        cdsEmpCat.First;
        While Not cdsEmpCat.Eof Do
        Begin
          If (cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat > 0) or (cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat > 0) Then
          Begin
            If cdsEmpCat.FieldByName('IDF_STATUS').asString  = 'I' Then
            Begin
              qryGen.Close;
              qryGen.SQL.Clear;
              qryGen.SQL.Add('INSERT INTO EMPCAT');
              qryGen.SQL.Add('(AUTOINCREM, CAT_CODEMP, CAT_NUMANO, CAT_NUMMES, CAT_TOTVAL, CAT_TOTVA2)');
              qryGen.SQL.Add('VALUES');
              qryGen.SQL.Add('(:AUTOINCREM, :CODEMP, :NUMANO, :NUMMES, :TOTVAL, :TOTVA2)');

              qryGen.ParamByName('AUTOINCREM').asString := fRetAutoIncrem('EMPCAT', VS_strCodEmp)
            End
            Else If cdsEmpCat.FieldByName('IDF_STATUS').asString  = 'A' Then
            Begin
              qryGen.Close;
              qryGen.SQL.Clear;
              qryGen.SQL.Add('UPDATE EMPCAT');
              qryGen.SQL.Add(' SET CAT_TOTVAL = :TOTVAL, CAT_TOTVA2 = :TOTVA2 ');
              qryGen.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
              qryGen.SQL.Add('  AND CAT_CODEMP = :CODEMP');
              qryGen.SQL.Add('  AND CAT_NUMANO = :NUMANO');
              qryGen.SQL.Add('  AND CAT_NUMMES = :NUMMES');

              qryGen.ParamByName('AUTOINCREM').asString := cdsEmpCat.FieldByName('AUTOINCREM').AsString;
            End;
            qryGen.ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
            qryGen.ParamByName('NUMANO').asInteger := cdsEmpCat.FieldByName('CAT_NUMANO').asInteger;
            qryGen.ParamByName('NUMMES').asInteger := cdsEmpCat.FieldByName('CAT_NUMMES').asInteger;
            qryGen.ParamByName('TOTVAL').asFloat   := cdsEmpCat.FieldByName('CAT_TOTVAL').asFloat;
            qryGen.ParamByName('TOTVA2').asFloat   := cdsEmpCat.FieldByName('CAT_TOTVA2').asFloat;
            qryGen.ExecSQL;
          End
          Else
          Begin
            qryGen.Close;
            qryGen.SQL.Clear;
            qryGen.SQL.Add('DELETE FROM EMPCAT');
            qryGen.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
            qryGen.SQL.Add('  AND CAT_CODEMP = :CODEMP');
            qryGen.ParamByName('AUTOINCREM').asString := cdsEmpCat.FieldByName('AUTOINCREM').AsString;
            qryGen.ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
            qryGen.ExecSQL;
          End;

          cdsEmpCat.Next;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadEmpresas.fGravaEmpCat]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;

End;

function TfrmCadEmpresas.fGravaLogAlteracaoIES(dtaIniVig: TDateTime): Boolean;
  Var
    qryLOGEMP: TUniQuery;
Begin
  If ((dtaIniVig = 0) Or (strIESOLD = '')) Then
    Exit(True);

  qryLOGEMP := fCriaQuery;
  Try
    qryLOGEMP.Close;
    qryLOGEMP.SQL.Clear;
    qryLOGEMP.SQL.Add('INSERT INTO LOGEMP(');
    qryLOGEMP.SQL.Add('  LOG_DTAALT,');
    qryLOGEMP.SQL.Add('  LOG_HRAALT,');
    qryLOGEMP.SQL.Add('  LOG_CODOPE,');
    qryLOGEMP.SQL.Add('  LOG_CODEMP,');
    qryLOGEMP.SQL.Add('  LOG_IESANT,');
    qryLOGEMP.SQL.Add('  LOG_IESATU,');
    qryLOGEMP.SQL.Add('  LOG_DTAINI ');
    qryLOGEMP.SQL.Add(') VALUES (');
    qryLOGEMP.SQL.Add('  :DTAALT,');
    qryLOGEMP.SQL.Add('  :HRAALT,');
    qryLOGEMP.SQL.Add('  :CODOPE,');
    qryLOGEMP.SQL.Add('  :CODEMP,');
    qryLOGEMP.SQL.Add('  :IESANT,');
    qryLOGEMP.SQL.Add('  :IESATU,');
    qryLOGEMP.SQL.Add('  :DTAINI ');
    qryLOGEMP.SQL.Add(')');

    qryLOGEMP.ParamByName('DTAALT').AsDate   := VS_Date;
    qryLOGEMP.ParamByName('HRAALT').AsTime   := fTime();
    qryLOGEMP.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryLOGEMP.ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    qryLOGEMP.ParamByName('IESANT').Value    := strIESOLD;
    qryLOGEMP.ParamByName('IESATU').Value    := fRetSomenteNumeros(dbeInsEst.Field.Value);
    qryLOGEMP.ParamByName('DTAINI').AsDate   := dtaIniVig;

    Try
      qryLOGEMP.ExecSQL;
      Result := qryLOGEMP.RowsAffected > 0;
      Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadEmpresas.fGravaLogAlteracaoIES]');
      End;
    End;

  Finally
    FreeAndNil(qryLOGEMP);
  End;
End;

procedure TfrmCadEmpresas.pCarregaImagem;
Begin
  if (qryTabela.Active) And (Not fEmptyStr(qryTabela.FieldByName('EMP_CODEMP').AsString)) Then
  Begin
    imgEmp.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemEmpresa(qryTabela.FieldByName('EMP_CODEMP').AsString, imgEmp.Picture) of
      riOk   :
      Begin
        imgEmp.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgEmp.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgEmp.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgEmp.Picture := nil;

  Application.ProcessMessages;
End;

procedure TfrmCadEmpresas.pLimpaImagem;
begin
  imgEmp.Picture := Nil;
  imgEmp.Visible := False;
  lblErrImg.Visible := False;
end;

function TfrmCadEmpresas.fExisteInclusaoDeCertificado: Boolean;
begin
  Result := Assigned(Self.FindComponent('btnCertificadoDigital'));
end;

function TfrmCadEmpresas.fExisteInclusaoDeLogotipo: Boolean;
begin
  Result := Assigned(Self.FindComponent('imgEmp'));
end;

function TfrmCadEmpresas.fRetornoValidadeCertificadoDigital: TDateTime;
begin
  Result := fCampoTabela('CER_DTAVAL', 'CADCER', ['CER_CODEMP'], [dbeCodEmp.Text]);
end;

function TfrmCadEmpresas.fExisteLogotipo: Boolean;
begin
  Result := not fEmptyStr(fCampoTabela('AUTOINCREM', 'EMPIMG', ['EMP_CODEMP'], [dbeCodEmp.Text]));
end;

procedure TfrmCadEmpresas.btnENotasClick(Sender: TObject);
var
  frmCadEnotas: TfrmCadEnotas;
begin
  inherited;

  If fEmptyStr(dbeCodEmp.Text) Then
  Begin
    pMensagemOk('É necessário selecionar uma empresa.');
    Exit;
  End;

  If fEmptyStr(fCfgSis('KEYENO', varString, dbeCodEmp.Text)) Then
  Begin
    fMensagem('', 'Informe a configuração [CFG_KEYENO] na empresa ['+dbeCodEmp.Text+'] para continuar!', ['&Ok']);
    Exit;
  End;

  If fExisteInclusaoDeCertificado And (not fDataValida(fRetornoValidadeCertificadoDigital)) Then
  Begin
    fMensagem('', 'Cadastre um Certificado Digital válido para continuar!', ['&Ok']);
    Exit;
  End;

  If fExisteInclusaoDeLogotipo And (not fExisteLogotipo) Then
  Begin
    fMensagem('', 'Cadastre o logotipo para continuar!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmCadEnotas, frmCadEnotas);
  Try
    frmCadEnotas.FCodigoEmpresa      := dbeCodEmp.Text;
    frmCadEnotas.FCnpj               := fTiraCaracEspeciaisPonto(dbeNumCgc.Text);
    frmCadEnotas.FInscricaoMunicipal := fRetSomenteNumeros(dbeInsMun.Text);
    frmCadEnotas.FInscricaoEstadual  := fRetSomenteNumeros(dbeInsEst.Text);
    frmCadEnotas.FRazaoSocial        := dbeNomEmp.Text;
    frmCadEnotas.FNomeFantasia       := dbeNomFan.Text;
    frmCadEnotas.FEmail              := dbeEmail.Text;
    frmCadEnotas.FTelefoneComercial  := fRetSomenteNumeros(dbeFone01.Text);

    frmCadEnotas.FCodigoCidade       := dbeCidade.Text;
    frmCadEnotas.FCodigoIbgeUf       := fRetornaCodUFIBGE(dbeCidade.Text);
    frmCadEnotas.FCodigoIbgeCidade   := fRetornaCodIBGE(dbeCidade.Text);
    frmCadEnotas.FUf                 := edtEstado.Text;
    frmCadEnotas.FCidade             := edtNomCid.Text;
    frmCadEnotas.FLogradouro         := dbeEndere.Text;
    frmCadEnotas.FNumero             := dbeEndNum.Text;
    frmCadEnotas.FComplemento        := dbeEndCmp.Text;
    frmCadEnotas.FBairro             := dbeBairro.Text;
    frmCadEnotas.FCep                := dbeNumCEp.Text;

    frmCadEnotas.FCnae               := dbeCNAE.Text;

    frmCadEnotas.FExisteInclusaoDeLogotipo    := fExisteInclusaoDeLogotipo;
    frmCadEnotas.FExisteInclusaoDeCertificado := fExisteInclusaoDeCertificado;

    frmCadEnotas.ShowModal;
  Finally
    pFreeAndNil(frmCadEnotas);
  End;
end;

procedure TfrmCadEmpresas.pEnotasAtualizaCertificadoDigital(ACodEmpresa, ACnpj: String);
var
  frmCadEnotas: TfrmCadEnotas;
begin
  If fEmptyStr(fCfgSis('KEYENO', varString, ACodEmpresa)) Then
    Exit;

  If fEmptyStr(fCfgSis('EMPENO', varString, ACodEmpresa)) Then
    Exit;

  pCriarFormularios(TfrmCadEnotas, frmCadEnotas);
  Try
    frmCadEnotas.FCodigoEmpresa := ACodEmpresa;
    frmCadEnotas.FCnpj          := fTiraCaracEspeciaisPonto(ACnpj);
    frmCadEnotas.FExibeMensagem := False;

    frmCadEnotas.pEnotasAtualizaCertificadoDigital;
  Finally
    pFreeAndNil(frmCadEnotas);
  End;
end;

procedure TfrmCadEmpresas.pAllTrimCampos;
var
  i:Integer;
begin
  For I := 0 To Pred(qryTabela.FieldCount) Do
  Begin
    If Pos(qryTabela.Fields[I].FieldName, 'EMP_NOMEMP, EMP_NOMFAN, EMP_ENDERE, EMP_BAIRRO,' +
                                          'EMP_ENDNUM, EMP_ENDCMP, EMP_I_E_S_, EMP_NOMCTB,' +
                                          'EMP_CPFCTB, EMP_CRCCTB, EMP_CGCCTB, EMP_ENDCTB,' +
                                          'EMP_NUMCTB, EMP_COMCTB, EMP_BAICTB, EMP_EMACTB') > 0 Then
    Begin
      If (Not qryTabela.Fields[I].ReadOnly) Then
        qryTabela.Fields[I].AsString := fAllTrim(qryTabela.Fields[I].AsString);
    End;
  End;

end;

Function TfrmCadEmpresas.fAlltrim(const ATexto: string): string;
const
  BlackSpace = [#33..#126];
var
  Index: byte;
begin
  Index:=1;
  while (Index <= Length(ATexto)) and not (CharInSet(ATexto[Index], BlackSpace)) do
  begin
    Index:=Index + 1;
  end;

  Result:=Copy(ATexto, Index, 255);
  Index := Length(Result);

  while (Index > 0) and not (CharInSet(ATexto[Index], BlackSpace)) do
  begin
    Index:=Index - 1;
  end;

  Result := Copy(ATexto, 1, Index);
end;

procedure TfrmCadEmpresas.pCarregaCidadeContab;
begin
  edtCidContab.Text := fCampoTabela('IBG_NOMMUN', 'IBG_CADIBG', ['IBG_CODMUN'], [dbeIbgeCidCtb.Text], False);
  edtEstContab.Text := fCampoTabela('IBG_UF', 'IBG_CADIBG', ['IBG_CODMUN'], [dbeIbgeCidCtb.Text], False);
end;

function TfrmCadEmpresas.fAlterandoCNPJ: Boolean;
  Var
    strCNPJ : String;
begin
  strCNPJ := fCampoTabela('EMP_C_G_C_', 'CADEMP', ['EMP_CODEMP'], [dbeCodEmp.Text], True);
  Result := (fTiraCaracEspeciaisPonto(dbeNumCgc.Text) <> strCNPJ);
end;

function TfrmCadEmpresas.fDesativandoEmpresa : Boolean;
begin
  Result := (qryTabela.State = dsEdit) And
            (strEmpAtiAnt = 'S') And
            (qryTabela.FieldByName('EMP_EMPATI').AsString = 'N');
end;

procedure TfrmCadEmpresas.pSetarVisibilidadeClassificacoesTransferencia(const strCodEmp : String);
begin
  gpbClaTraInd.Visible := fCfgSis('CONIPI', varBoolean);
  gpbClaTraIndTra.Visible := fCfgSis('CONIPI', varBoolean);

  If (Not gpbClaTraInd.Visible) And (VS_strCodEmp <> strCodEmp) Then
    gpbClaTraInd.Visible := fCfgSis('CONIPI', varBoolean, strCodEmp);

  If (Not gpbClaTraIndTra.Visible) And (VS_strCodEmp <> strCodEmp) Then
    gpbClaTraIndTra.Visible := fCfgSis('CONIPI', varBoolean, strCodEmp);
end;

procedure TfrmCadEmpresas.pAjustaTamanhoGridTransferencia;
begin
  pgcTransfEstoque.Height := intHeightpgcTransfEstoque - (IIf(gpbClaVen.Visible, 0, intHeightgpbClaVen) +
                                                          IIf(gpbClaTra.Visible, 0, intHeightgpbClaTra) +
                                                          IIf(gpbClaTraInd.Visible, 0, intHeightgpbClaTraInd) +
                                                          IIf(gpbClaTraIndTra.Visible, 0, intHeightgpbClaTraIndTra) +
                                                          IIf(grpTraDepFecSai.Visible, 0, intHeightgrpTraDepFecSai));
end;

end.


