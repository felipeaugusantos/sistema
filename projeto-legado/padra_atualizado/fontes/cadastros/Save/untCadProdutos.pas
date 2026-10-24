{***************************}
{* qryConMar -> CADMAR     *}
{* qryConFor -> CADFOR     *}
{* qryConAbf -> ABFICM     *}
{* qryConGru -> CADGRU     *}
{* qryConUni -> CADUNI     *}
{* qryConIte -> ITEGER     *}
{***************************}
{***************************}
{* qryAbfIcm -> ABFICM     *}
{************************RV*}

unit untCadProdutos;

interface

uses
  SysUtils, Types, Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, MaskEditFocus, QColorLabel,
  Menus, DBComboBoxFocus, ComboBoxFocus, DBMemoFocus, Grids, DBGridCitel, DBGrids, DB,
  Windows, Uni, AppEvnts, UniClientDataSet, cxControls, cxContainer, cxEdit, cxGroupBox,
  untFatorPreco, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, untIteBar,
  untCadLote, untCadIteMontadoras, Messages, untPanelDadosECommerce,
  BitBtnLockedIncrem, cxHint, cxProgressBar, cxGridBandedTableView,
  cxGridDBBandedTableView, cxCurrencyEdit, cxEditRepositoryItems,
  untAtributosProduto, cxButtons, Vcl.Dialogs, 
  cxVGrid, cxDBVGrid, cxInplaceContainer, untFornecedorItemPalett,
  untParCalculaPrecoCusto, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, dxScreenTip, dxCustomHint, frxClass,
  untCfgGrid, untTProFaixasMetragem, untLojasCadIte, untTLock,
  frxExportCSVTestabilidade, DateUtils, untZClient, untLocFisAdicionais, untGravando, cxGridCitel,
  cxDBLookupComboBox, cxDropDownEdit, cxImage, untComplementoEtiquetasProd,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  untTabelasDoItemFrame, untTabelasDoItemGrid, untTabelasDoItem,
  untTCadProdutosVeiculoModelo, cxTextEdit, cxMaskEdit, cxDBEdit, untTEditFocusExtend, untLoteRastreamento,
  Datasnap.DBClient, untManutencaoAbreviacoesLojas, DBLookupComboBoxFocus,
  Produto.TProdutos, Produto.TSQLProdutos ,untTCalculaVariacaoPreco;

type
  TIteEmbDeleted = Record
    strCodIte: String;
    fltQtdEmb: Double;
  End;

  TBeneficioST_Precos = Record
    blnCalculou: boolean;
    fltPreve1: Double;
    fltPreve2: Double;
    fltPreve3: Double;
    fltPreve4: Double;
    fltPreve5: Double;
    fltPreve6: Double;
    fltPreve7: Double;
  End;

  TArrIteEmbDeleted = Array of TIteEmbDeleted;

  TInsereItemCatalogo = Procedure Of Object;

  TMarIdeAlterada = Record
    strTabPrc: String;
    fltMarIde: String;
    fltMargem: String;
  End;

  TArrMarIdeAlterada = Array of TMarIdeAlterada;

  TfrmCadProdutos = class(TfrmPaiCad)
    tbsFiscais: TTabSheet;
    tbsEstoque: TTabSheet;
    tbsPrecos: TTabSheet;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    dbeCodIte: TDBEditFocus;
    pnlDadosGerais: TPanel;
    Label11: TLabel;
    pnlPrecos: TPanel;
    Panel1: TPanel;
    tbsDadosBalanca: TTabSheet;
    pnlCabBalanca: TPanel;
    Label70: TLabel;
    dbeDesFlz: TDBEditFocus;
    dbePreBal: TDBEditFocus;
    Label71: TLabel;
    Label73: TLabel;
    dbeRecFlz: TDBEditFocus;
    dbeSetFlz: TDBEditFocus;
    Label95: TLabel;
    edtDesSet: TEditFocus;
    Label96: TLabel;
    dbeBarFlz: TDBEditFocus;
    Label97: TLabel;
    dbeCodFlz: TDBEditFocus;
    Label98: TLabel;
    dbeTecFlz: TDBEditFocus;
    dbeValFlz: TDBEditFocus;
    Label99: TLabel;
    Label100: TLabel;
    dbeTipFlz: TDBEditFocus;
    ColorLabel6: TColorLabel;
    Label116: TLabel;
    dbePorFlz: TDBEditFocus;
    tbsComplementos: TTabSheet;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlUltimosMov: TPanel;
    pgcUltVendaCompra: TPageControl;
    tbsUltCompra: TTabSheet;
    tbsUltVenda: TTabSheet;
    Label85: TLabel;
    Label86: TLabel;
    edtUltCom: TEditFocus;
    edtQtdUco: TEditFocus;
    Label87: TLabel;
    edtPreUlt: TEditFocus;
    pnlFicIns: TPanel;
    Panel9: TPanel;
    dbeFicIns: TDBMemoFocus;
    Label88: TLabel;
    edtPreMed: TEditFocus;
    Label94: TLabel;
    Label93: TLabel;
    edtUltFor: TEditFocus;
    edtNomUltFor: TEditFocus;
    Label92: TLabel;
    edtPreuve: TEditFocus;
    edtQtdUve: TEditFocus;
    Label91: TLabel;
    Label90: TLabel;
    edtDtaUve: TEditFocus;
    Label89: TLabel;
    pnlPrecos1: TPanel;
    Label13: TLabel;
    dbePreCom: TDBEditFocus;
    Label14: TLabel;
    dbeDesf01: TDBEditFocus;
    Label33: TLabel;
    Label15: TLabel;
    dbeDesf02: TDBEditFocus;
    Label34: TLabel;
    Label16: TLabel;
    dbeDesf03: TDBEditFocus;
    Label35: TLabel;
    Label17: TLabel;
    dbeDesf04: TDBEditFocus;
    Label36: TLabel;
    Label18: TLabel;
    dbeDesf05: TDBEditFocus;
    Label37: TLabel;
    Label19: TLabel;
    dbeDesf06: TDBEditFocus;
    Label20: TLabel;
    dbeIcmEnt: TDBEditFocus;
    Label39: TLabel;
    Label21: TLabel;
    dbeIpiEnt: TDBEditFocus;
    Label40: TLabel;
    Label22: TLabel;
    dbeFreEnt: TDBEditFocus;
    Label41: TLabel;
    Label23: TLabel;
    dbeAcrFin: TDBEditFocus;
    Label42: TLabel;
    Label24: TLabel;
    dbeSubsti: TDBEditFocus;
    Label43: TLabel;
    lblPreCus: TLabel;
    dbePreCus: TDBEditFocus;
    pnlImgPro: TPanel;
    imgPro: TcxImage;
    btnGs1Cnp: TBitBtnLocked;
    lblValFre: TLabel;
    dbeValFre: TDBEditFocus;
    rgpDadosUvc: TRadioGroup;
    pnlGeralBalanca: TPanel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label106: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    dbeValCal: TDBEditFocus;
    dbePerCal: TDBEditFocus;
    dbeVCarbo: TDBEditFocus;
    dbePCarbo: TDBEditFocus;
    dbeVProte: TDBEditFocus;
    dbePProte: TDBEditFocus;
    dbeVGorTo: TDBEditFocus;
    dbePGorTo: TDBEditFocus;
    dbeVGorSa: TDBEditFocus;
    dbePGorSa: TDBEditFocus;
    dbeVColes: TDBEditFocus;
    dbePColes: TDBEditFocus;
    dbeVFibAl: TDBEditFocus;
    dbePFibAl: TDBEditFocus;
    dbeVCalci: TDBEditFocus;
    dbePCalci: TDBEditFocus;
    dbeVFerro: TDBEditFocus;
    dbePFerro: TDBEditFocus;
    dbeVSodio: TDBEditFocus;
    dbePSodio: TDBEditFocus;
    dbeValEne: TDBEditFocus;
    dbePerEne: TDBEditFocus;
    dbeVGorTa: TDBEditFocus;
    dbePGorTa: TDBEditFocus;
    Panel5: TPanel;
    btnTabFor: TBitBtnLocked;
    Label129: TLabel;
    Label130: TLabel;
    dbeObsBal: TDBEditFocus;
    dbeInfExt: TDBMemoFocus;
    Label131: TLabel;
    dbeQtdNtr: TDBEditFocus;
    ColorLabel14: TColorLabel;
    ColorLabel13: TColorLabel;
    lblDesAdi: TLabel;
    Label133: TLabel;
    dbeDesAdb: TDBEditFocus;
    Label135: TLabel;
    dbeSubFed: TDBEditFocus;
    Label136: TLabel;
    Panel6: TPanel;
    lblTabPre: TLabel;
    edtComLiq: TEditFocus;
    Label38: TLabel;
    Label137: TLabel;
    dbeSaldos: TEditFocus;
    dtsCadIte: TDataSource;
    dtsIteGer: TDataSource;
    ScrollBox1: TPanel;
    pnlAgroto: TPanel;
    dbeAgroto: TDBEditFocus;
    lbl1: TColorLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dbeDtaCad: TDBEditFocus;
    lbl4: TLabel;
    dbeUltAlt: TDBEditFocus;
    lbl5: TLabel;
    dbeOpeAlt: TDBEditFocus;
    edtNomOpe: TEditFocus;
    tbsEmbalagens: TTabSheet;
    dbeEmbalagem: TDBEditFocus;
    Label55: TLabel;
    tbsExportaSite: TTabSheet;
    pnlDadosECommerce: TPanel;
    tbsDadosSaida: TTabSheet;
    tbsDadosEntrada: TTabSheet;
    tbsMontadoras: TTabSheet;
    gpbMinTab: TGroupBox;
    pnlMinTb1: TPanel;
    Label60: TLabel;
    dbeMinTb1: TDBEditFocus;
    pnlMinTb2: TPanel;
    Label134: TLabel;
    dbeMinTb2: TDBEditFocus;
    pnlMinTb3: TPanel;
    Label148: TLabel;
    dbeMinTb3: TDBEditFocus;
    pnlMinTb4: TPanel;
    Label149: TLabel;
    dbeMinTb4: TDBEditFocus;
    pnlMinTb5: TPanel;
    Label150: TLabel;
    dbeMinTb5: TDBEditFocus;
    pnlMinTb6: TPanel;
    Label151: TLabel;
    dbeMinTb6: TDBEditFocus;
    pnlMinTb7: TPanel;
    Label156: TLabel;
    dbeMinTb7: TDBEditFocus;
    pnlAmz: TPanel;
    dbgLotAmz: TDBGridCitel;
    chkPreDol: TDBCheckBox;
    tbsFornecedores: TTabSheet;
    pnlFundo: TPanel;
    lbl19: TLabel;
    dbgFornecedor: TDBGridCitel;
    pnlTopo: TPanel;
    lbl20: TLabel;
    lbl21: TLabel;
    edtNomForn: TEditFocus;
    edtCodForn: TEditFocus;
    edtCodItF: TEditFocus;
    pnlComplementos1: TPanel;
    Label62: TLabel;
    Label67: TLabel;
    Label72: TLabel;
    ColorLabel3: TColorLabel;
    ColorLabel4: TColorLabel;
    Label122: TLabel;
    dbeImpLis: TDBEditFocus;
    dbeIteAti: TDBEditFocus;
    dbePesoIt: TDBEditFocus;
    dbeCodGpr: TDBEditFocus;
    edtDesGpr: TEditFocus;
    pnlPraVal: TPanel;
    lblPraVal: TLabel;
    dbePraVal: TDBEditFocus;
    pnlComplementos2: TPanel;
    Label53: TLabel;
    ColorLabel5: TColorLabel;
    Label46: TLabel;
    ColorLabel11: TColorLabel;
    dbeIteBas: TDBEditFocus;
    dbeInflam: TDBEditFocus;
    pnlMarBas: TPanel;
    lblMarBas: TLabel;
    cmbMarBas: TComboBoxFocus;
    pnlComplementosPos02: TPanel;
    Label117: TLabel;
    ColorLabel7: TColorLabel;
    dbeProPig: TDBEditFocus;
    pnlCnv_ML: TPanel;
    lblCnv_ML: TLabel;
    dbeCnv_ML: TDBEditFocus;
    pnlComplementos4: TPanel;
    Label68: TLabel;
    dbeFatCnv: TDBEditFocus;
    lbl12: TLabel;
    dbeUsaBon: TDBEditFocus;
    lbl13: TColorLabel;
    pnlFatCom: TPanel;
    lblFatCom: TLabel;
    dbeFatCom: TDBEditFocus;
    clbFatCom: TColorLabel;
    pnlSitPro: TPanel;
    lblSitPro: TLabel;
    dbeSitPro: TDBEditFocus;
    edtSitPro: TEditFocus;
    pnlDensid: TPanel;
    dbeDensid: TDBEditFocus;
    lblDensid: TLabel;
    pnlIndRev: TPanel;
    lblIndRev: TLabel;
    dbeIndRev: TDBEditFocus;
    lbcIndRev: TColorLabel;
    pnlImpDir: TPanel;
    lblImpDir: TLabel;
    dbeImpDir: TDBEditFocus;
    lblcImpDir: TColorLabel;
    pnlDadosSaida2: TPanel;
    Label119: TLabel;
    dbeMultVenda: TDBEditFocus;
    Label57: TLabel;
    dbeMsgLv1: TDBEditFocus;
    Label58: TLabel;
    dbeMsgLv2: TDBEditFocus;
    Label59: TLabel;
    dbeAplica: TDBMemoFocus;
    Label142: TLabel;
    dbeBarExp: TDBEditFocus;
    ColorLabel18: TColorLabel;
    pnlDadosSaidaEsquerda: TPanel;
    pnlDadosSaida3: TPanel;
    Label75: TLabel;
    dbeComVar: TDBEditFocus;
    Label77: TLabel;
    Label78: TLabel;
    pnlComPro: TPanel;
    lblComProPer: TLabel;
    dbeComPro: TDBEditFocus;
    lblComPro: TLabel;
    pnlQtPPro: TPanel;
    lblQtPPro: TLabel;
    dbeQtPPro: TDBEditFocus;
    pnlDadosSaida4: TPanel;
    lblDesMGe: TLabel;
    lblDesMGePor: TLabel;
    lblDesMax: TLabel;
    lblDesMaxPor: TLabel;
    lblMarMin: TLabel;
    lblMarMinPor: TLabel;
    lbl36: TLabel;
    lbl37: TLabel;
    lbl38: TLabel;
    lbl39: TLabel;
    dbeDesMGe: TDBEditFocus;
    dbeDesMax: TDBEditFocus;
    dbeMarMin: TDBEditFocus;
    DBEditFocus1: TDBEditFocus;
    DBEditFocus2: TDBEditFocus;
    pnlDadosEntrada1: TPanel;
    Label141: TLabel;
    dbeAtiCom: TDBEditFocus;
    ColorLabel17: TColorLabel;
    pnlDesFab: TPanel;
    lblDesFab: TLabel;
    dbeDesFab: TDBEditFocus;
    pnlDadosEntrada2: TPanel;
    Label118: TLabel;
    Label147: TLabel;
    Label139: TLabel;
    ColorLabel16: TColorLabel;
    Label168: TLabel;
    ColorLabel19: TColorLabel;
    Label31: TLabel;
    ColorLabel10: TColorLabel;
    lblEsMiDg: TLabel;
    clEsMiDg: TColorLabel;
    lbl6: TLabel;
    Label166: TLabel;
    dbeMultCompra: TDBEditFocus;
    dbeDiaFor: TDBEditFocus;
    dbeRprEnt: TDBEditFocus;
    dbeAbaMlt: TDBEditFocus;
    dbeNvlGir: TDBEditFocus;
    dbeEsMiDg: TDBEditFocus;
    dbeAcoObj: TDBEditFocus;
    dbeGruCmp: TDBEditFocus;
    edtDesCmp: TEditFocus;
    pnlGeralEsquerda: TPanel;
    pnlGeral1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    lblSeta: TLabel;
    lblRefePonteiro: TLabel;
    lblCodDep: TLabel;
    dbeCodGru: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    edtLinGru: TEditFocus;
    dbeCodDep: TDBEditFocus;
    edtDesDep: TEditFocus;
    pnlGeral2: TPanel;
    lblDesSim: TLabel;
    dbeDesSim: TDBEditFocus;
    lblDescOrig: TLabel;
    edtDescOrig: TEditFocus;
    pnlGeral3: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblUniCom: TLabel;
    Label121: TLabel;
    dbeRefere: TDBEditFocus;
    dbeCodMar: TDBEditFocus;
    dbeCodFor: TDBEditFocus;
    dbeCodFab: TDBEditFocus;
    dbeCodBar: TDBEditFocus;
    dbeCodUni: TDBEditFocus;
    edtDesMar: TEditFocus;
    edtNomFor: TEditFocus;
    edtDesUni: TEditFocus;
    dbeUniCom: TDBEditFocus;
    edtDesUniCom: TEditFocus;
    dbeBarEmb: TDBEditFocus;
    HintControler: TcxHintStyleController;
    btnHeranca: TBitBtnLocked;
    btnMaisInfo: TBitBtnLocked;
    btnVenCom: TBitBtnLocked;
    btnAdicionarForn: TBitBtnLocked;
    btnCancelarForn: TBitBtnLocked;
    Label167: TLabel;
    dbePrdGru: TDBEditFocus;
    edtDesPrdPro: TEditFocus;
    Label169: TLabel;
    edtImpUlt: TEditFocus;
    pnl2: TPanel;
    lblMaxBri: TLabel;
    dbeMaxBri: TDBEditFocus;
    lbl26: TLabel;
    dbeComAta: TDBEditFocus;
    lbl27: TLabel;
    dbeComDis: TDBEditFocus;
    lbl28: TLabel;
    ColorLabel22: TColorLabel;
    ColorLabel23: TColorLabel;
    dbePeeFut: TDBEditFocus;
    ColorLabel24: TColorLabel;
    dbePeFutP: TDBEditFocus;
    ColorLabel25: TColorLabel;
    pnlDadosFiscais: TPanel;
    Label32: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel2: TColorLabel;
    Label69: TLabel;
    Label30: TLabel;
    ColorLabel8: TColorLabel;
    Label140: TLabel;
    Label45: TLabel;
    Label64: TLabel;
    Label74: TLabel;
    Label161: TLabel;
    ColorLabel20: TColorLabel;
    Label76: TLabel;
    dbeCodAbr: TDBEditFocus;
    dbeIpiSai: TDBEditFocus;
    dbeClaIpi: TDBEditFocus;
    dbeIncPis: TDBEditFocus;
    dbeComLub: TDBEditFocus;
    edtDesAbf: TEditFocus;
    dbeCodFin: TDBEditFocus;
    dbeObrCpf: TDBEditFocus;
    dbeMenFis: TDBEditFocus;
    dbeAbfPis: TDBEditFocus;
    dbeAbfCof: TDBEditFocus;
    dbeAbfIpi: TDBEditFocus;
    edtDesAbfIpi: TEditFocus;
    edtDesAbfCof: TEditFocus;
    edtDesAbfPis: TEditFocus;
    dbeObrNfe: TDBEditFocus;
    dbeCodLub: TDBEditFocus;
    pnlClaOnu: TPanel;
    Label143: TLabel;
    dbeCodOnu: TDBEditFocus;
    edtDesOnu: TEditFocus;
    lblPesLiq: TLabel;
    dbePesLiq: TDBEditFocus;
    Label144: TLabel;
    edtUltNot: TEditFocus;
    pnlCodDic: TPanel;
    Label145: TLabel;
    dbeCodDic: TDBEditFocus;
    edtDesDic: TEditFocus;
    Label146: TLabel;
    cmbItePro: TComboBoxFocus;
    tbsDesMaxTBP: TTabSheet;
    cxedtRepository: TcxEditRepository;
    cxredtDesMax: TcxEditRepositoryCurrencyItem;
    lblObrIba: TLabel;
    dbeObrIba: TDBEditFocus;
    clbObrIba: TColorLabel;
    pnlRapel: TPanel;
    lblRapelDes: TLabel;
    lblRapelPer: TLabel;
    dbePRapel: TDBEditFocus;
    pnlComMec: TPanel;
    lblPerValMc: TLabel;
    lbl8: TLabel;
    dbeComMec: TDBEditFocus;
    grp1: TGroupBox;
    lbl40: TLabel;
    lbl41: TLabel;
    lbl42: TLabel;
    lbl43: TLabel;
    dbePer_CI: TDBEditFocus;
    dbeNumFCI: TDBEditFocus;
    popMaisInfo: TPopupMenu;
    mnuEmprestimos: TMenuItem;
    mnuPreparaGerTE: TMenuItem;
    mnuProdutosAcabados: TMenuItem;
    mnuPromocoes: TMenuItem;
    pnlProEmb: TPanel;
    Label2: TLabel;
    dbeProEmb: TDBEditFocus;
    ColorLabel26: TColorLabel;
    pnlGarant: TPanel;
    lblGarant: TLabel;
    dbeGarant: TDBEditFocus;
    Label12: TLabel;
    dbeInfGar: TDBEditFocus;
    pnlDadosConcreto: TPanel;
    Label56: TLabel;
    dbeAbatim: TDBEditFocus;
    Label79: TLabel;
    dbeTipMps: TDBEditFocus;
    lblBrita: TLabel;
    dbeBrita_: TDBEditFocus;
    dbeConBom: TDBEditFocus;
    ColorLabel27: TColorLabel;
    Label81: TLabel;
    dbeFckDia: TDBEditFocus;
    Label82: TLabel;
    pnlImpEti: TPanel;
    Label83: TLabel;
    dbeImpEti: TDBEditFocus;
    ColorLabel28: TColorLabel;
    tbsGirEnt: TTabSheet;
    tbsGirSai: TTabSheet;
    lbl50: TLabel;
    dbeExcIpi: TDBEditFocus;
    tabLocalizacao: TTabSheet;
    pnlLoc: TPanel;
    Label152: TLabel;
    Label153: TLabel;
    Label154: TLabel;
    Label155: TLabel;
    dbeLocFis: TDBEditFocus;
    dbeSupEst: TDBEditFocus;
    dbeTamLocS: TDBEditFocus;
    dbeTamLocF: TDBEditFocus;
    pnlLocFis: TPanel;
    Panel4: TPanel;
    lblReaEnd: TLabel;
    dbeReaEnd: TDBEditFocus;
    clrReaEnd: TColorLabel;
    FichaKardex1: TMenuItem;
    lblRastre: TLabel;
    dbeRastre: TDBEditFocus;
    lblRastreSN: TColorLabel;
    lblLocSep: TLabel;
    dbeCodLse: TDBEditFocus;
    edtDesLse: TEditFocus;
    lblErrImg: TLabel;
    pnlFatCMP: TPanel;
    lblFatCMP: TLabel;
    dbeIteFatCMP: TDBEditFocus;
    Label162: TLabel;
    dbeTpCoMc: TDBEditFocus;
    ColorLabel31: TColorLabel;
    ColorLabel32: TColorLabel;
    btnEstrutura: TBitBtnLocked;
    lblDesMSuPor: TLabel;
    dbeDesMSu: TDBEditFocus;
    lblDesMSu: TLabel;
    dbeMesGir: TDBEditFocus;
    lblMesGir: TColorLabel;
    lblNotEsp: TLabel;
    dbeNotEsp: TDBEditFocus;
    clbNotEsp: TColorLabel;
    pnlDtaVal: TPanel;
    Label173: TLabel;
    dbeDtaVal: TDBEditFocus;
    tbsMargemIdeal: TTabSheet;
    pnlMargemIdeal: TPanel;
    cxgMarId7: TcxGroupBox;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    dbeMarId7: TDBEditFocus;
    edtPreId7: TEditFocus;
    cxgMarId6: TcxGroupBox;
    Label174: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    dbeMarId6: TDBEditFocus;
    edtPreId6: TEditFocus;
    cxgMarId5: TcxGroupBox;
    Label177: TLabel;
    Label178: TLabel;
    Label182: TLabel;
    dbeMarId5: TDBEditFocus;
    edtPreId5: TEditFocus;
    cxgMarId4: TcxGroupBox;
    Label183: TLabel;
    Label184: TLabel;
    Label185: TLabel;
    dbeMarId4: TDBEditFocus;
    edtPreId4: TEditFocus;
    cxgMarId3: TcxGroupBox;
    Label186: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    dbeMarId3: TDBEditFocus;
    edtPreId3: TEditFocus;
    cxgMarId2: TcxGroupBox;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    dbeMarId2: TDBEditFocus;
    edtPreId2: TEditFocus;
    cxgMarId1: TcxGroupBox;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    dbeMarId1: TDBEditFocus;
    edtPreId1: TEditFocus;
    lblCest: TLabel;
    dbeCdCest: TDBEditFocus;
    edtCestDesc: TEditFocus;
    lblGarFil: TLabel;
    lblGarFilColor: TColorLabel;
    lblGarFilAviso: TLabel;
    dbeGarFil: TDBEditFocus;
    tbsIteEmb: TTabSheet;
    pnlIteEmb: TPanel;
    pnlIteEmbTopo: TPanel;
    pnlIteEmbBottom: TPanel;
    cxgIteEmbLevel: TcxGridLevel;
    cxgIteEmbTableView: TcxGridDBTableViewCitel;
    cxgIteEmb: TcxGridCitel;
    cxgIteEmbTableViewQTDEMB: TcxGridDBColumn;
    cxgIteEmbTableViewDESCON: TcxGridDBColumn;
    cxgIteEmbTableViewTABPRE: TcxGridDBColumn;
    cxgIteEmbTableViewPRIROM: TcxGridDBColumn;
    edtEmbFec: TEditFocus;
    edtDesFec: TEditFocus;
    cbxTabEmf: TComboBoxFocus;
    lbl22: TLabel;
    lbl23: TLabel;
    lblPrinCalcRom: TLabel;
    cmbPriRom: TComboBoxFocus;
    lbl25: TLabel;
    btnAdicionaIteEmb: TBitBtnLocked;
    btnCancelaIteEmb: TBitBtnLocked;
    Label63: TLabel;
    Label125: TLabel;
    pnlConLot: TPanel;
    Label163: TLabel;
    ColorLabel33: TColorLabel;
    dbeConLot: TDBEditFocus;
    lblFaltaProduto: TColorLabel;
    dbeFaltaProduto: TDBEditFocus;
    ColorLabel34: TColorLabel;
    lblApeRet: TLabel;
    dbeApeRet: TDBEditFocus;
    lblUsaFle: TLabel;
    dbeUsaFle: TDBEditFocus;
    lblUsaFle_S_N: TColorLabel;
    Label54: TLabel;
    edtCodCna: TEditFocus;
    shpAcessoPrecos: TShape;
    gpbFreTra: TGroupBox;
    lbl16: TLabel;
    clb1: TColorLabel;
    lbl18: TLabel;
    lblVlcFre: TLabel;
    ColorLabel21: TColorLabel;
    dbeTipFre: TDBEditFocus;
    dbeVlCFre: TDBEditFocus;
    gpbMetVid: TGroupBox;
    lblLargura: TLabel;
    lblAltura: TLabel;
    lblLarguraMax: TLabel;
    lblAlturaMax: TLabel;
    lblMed4: TLabel;
    lblMed3: TLabel;
    lblMed2: TLabel;
    lblMed1: TLabel;
    dbeLarVid: TDBEditFocus;
    dbeAltVid: TDBEditFocus;
    dbeLaMaVi: TDBEditFocus;
    dbeAlMaVi: TDBEditFocus;
    lblAreaSug: TLabel;
    dbeAreSug: TDBEditFocus;
    lblMed5: TLabel;
    lblAreaMax: TLabel;
    dbeAreMax: TDBEditFocus;
    lblMed6: TLabel;
    lblLarMin: TLabel;
    dbeLarMin: TDBEditFocus;
    lblMed7: TLabel;
    lblMed8: TLabel;
    dbeAltMin: TDBEditFocus;
    lblAltMin: TLabel;
    lblAreMin: TLabel;
    dbeAreMin: TDBEditFocus;
    lblMed9: TLabel;
    mnuConstrucaodoPreodeCusto: TMenuItem;
    pnlOBRBAR: TPanel;
    Label132: TLabel;
    ColorLabel15: TColorLabel;
    dbeOBRBAR: TDBEditFocus;
    lblProPCD: TLabel;
    clbProPCD: TColorLabel;
    edtProPCD: TDBEditFocus;
    lblUniTri: TLabel;
    dbeUniTri: TDBEditFocus;
    edtDesUniTri: TEditFocus;
    lblFatUTr: TLabel;
    dbeFatUTr: TDBEditFocus;
    pnlPraMin: TPanel;
    Label172: TLabel;
    dbePraMin: TDBEditFocus;
    btnPraMinHelp: TBitBtnLocked;
    dbgCompras: TDBGridCitel;
    dbgVendas: TDBGridCitel;
    Label138: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    edtPreUltEmb: TEditFocus;
    edtPreImpUltEmb: TEditFocus;
    edtEmbQtd: TEditFocus;
    Label170: TLabel;
    Panel8: TPanel;
    Label195: TLabel;
    Label196: TLabel;
    Label197: TLabel;
    dbeCOMPOS: TDBEditFocus;
    dbeITESAC: TDBEditFocus;
    dbePAISOR: TDBEditFocus;
    btnFatAcre: TBitBtnLocked;
    cxgLojasLevel1: TcxGridLevel;
    cxgLojas: TcxGridCitel;
    cxvLojas: TcxGridDBBandedTableView;
    cxvLojasCODEMP: TcxGridDBBandedColumn;
    cxvLojasNOMEMP: TcxGridDBBandedColumn;
    cxvLojasDTABAL: TcxGridDBBandedColumn;
    cxvLojasSALBAL: TcxGridDBBandedColumn;
    cxvLojasML_BAL: TcxGridDBBandedColumn;
    cxvLojasDTAAJU: TcxGridDBBandedColumn;
    cxvLojasQTDAJU: TcxGridDBBandedColumn;
    cxvLojasSALDOS: TcxGridDBBandedColumn;
    cxvLojasSAL_ML: TcxGridDBBandedColumn;
    cxvLojasSALRES: TcxGridDBBandedColumn;
    cxvLojasESTMIN: TcxGridDBBandedColumn;
    cxvLojasESTMAX: TcxGridDBBandedColumn;
    cxvLojasNIVGIR: TcxGridDBBandedColumn;
    cxvLojasIMPLIS: TcxGridDBBandedColumn;
    cxvLojasAPERET: TcxGridDBBandedColumn;
    cxvLojasCPRCEN: TcxGridDBBandedColumn;
    cxvLojasEMPCEN: TcxGridDBBandedColumn;
    cxStyleRepository: TcxStyleRepository;
    cxStyleZebra: TcxStyle;
    lblUtiAmp: TLabel;
    dbeUtiAmp: TDBEditFocus;
    lblUtiAmp_S_N: TColorLabel;
    pnlOrdServico: TPanel;
    lblOrdServ: TLabel;
    edtOrdServ: TDBEditFocus;
    clbOrdServ: TColorLabel;
    lblObrDefLoteWMS: TLabel;
    dbeObrDefLoteWMS: TDBEditFocus;
    clbObrDefLoteWMS: TColorLabel;
    lblPesagemObr: TLabel;
    dbePesagemObr: TDBEditFocus;
    lblPesagemObrSN: TColorLabel;
    pnlCPESOB: TPanel;
    lblPesagemObrEnt: TLabel;
    lblPesagemObrEntSN: TColorLabel;
    dbePesagemObrEnt: TDBEditFocus;
    cxvLojasNIVCRI: TcxGridDBBandedColumn;
    Label159: TLabel;
    dbeNvlCri: TDBEditFocus;
    ColorLabel36: TColorLabel;
    pnlLayOrdPro: TPanel;
    lblOrdemProducao: TLabel;
    dbeCodLayOrdPro: TDBEditFocus;
    edtNomLayOrdPro: TEditFocus;
    tbsProdAcab: TTabSheet;
    pnlProdAcab: TPanel;
    pnlComEti8: TPanel;
    lblComEti8: TLabel;
    edtComEti8: TEditFocus;
    pnlComEti7: TPanel;
    lblComEti7: TLabel;
    edtComEti7: TEditFocus;
    pnlComEti6: TPanel;
    lblComEti6: TLabel;
    edtComEti6: TEditFocus;
    pnlComEti5: TPanel;
    lblComEti5: TLabel;
    edtComEti5: TEditFocus;
    pnlComEti4: TPanel;
    lblComEti4: TLabel;
    edtComEti4: TEditFocus;
    pnlComEti3: TPanel;
    lblComEti3: TLabel;
    edtComEti3: TEditFocus;
    pnlComEti2: TPanel;
    lblComEti2: TLabel;
    edtComEti2: TEditFocus;
    pnlComEti1: TPanel;
    lblComEti1: TLabel;
    edtComEti1: TEditFocus;
    pnlComEti9: TPanel;
    lblComEti9: TLabel;
    edtComEti9: TEditFocus;
    pnlComEti10: TPanel;
    lblComEti10: TLabel;
    edtComEti10: TEditFocus;
    pnlSitPrd: TPanel;
    lbl35: TLabel;
    lbl44: TColorLabel;
    lbl45: TColorLabel;
    dbeSitPrd: TDBEditFocus;
    pnlMateriaPrima: TPanel;
    Label84: TLabel;
    Label157: TLabel;
    ColorLabel29: TColorLabel;
    Label158: TLabel;
    ColorLabel30: TColorLabel;
    dbePerSol: TDBEditFocus;
    dbeECarga: TDBEditFocus;
    dbeAbsOle: TDBEditFocus;
    pnlCodCom: TPanel;
    lblCompos: TLabel;
    dbeCodCom: TDBEditFocus;
    edtDesCom: TEditFocus;
    pnlLayOrdInd: TPanel;
    Label126: TLabel;
    edtNomLayOrdInd: TEditFocus;
    btnCancelLayOrdInd: TBitBtnLocked;
    btnAddLayOrdInd: TBitBtnLocked;
    cxgLayOrdInd: TcxGridCitel;
    cxgLayOrdIndTV: TcxGridDBTableViewCitel;
    cxgLayOrDIndLAYOUT: TcxGridDBColumn;
    cxgLayOrdIndLvl1: TcxGridLevel;
    edtCodLayOrdInd: TEditFocus;
    pnlGranel: TPanel;
    Label160: TLabel;
    edtDesPag: TEditFocus;
    lblComDig: TLabel;
    dbeComDig: TDBEditFocus;
    lblComDigPer: TLabel;
    lblClaCrm: TLabel;
    dbeClaCrm: TDBEditFocus;
    lblClaCrmLeg: TColorLabel;
    Label27: TLabel;
    dbeDesANP: TDBEditFocus;
    Label120: TLabel;
    dbeIndEsc: TDBEditFocus;
    ColorLabel37: TColorLabel;
    dbeCnpFme: TDBEditFocus;
    Label199: TLabel;
    Label200: TLabel;
    dbeCdbFis: TDBEditFocus;
    GroupBox1: TGroupBox;
    Label201: TLabel;
    dbeENIECB: TDBEditFocus;
    ColorLabel38: TColorLabel;
    pnlRecDev: TPanel;
    Label202: TLabel;
    ColorLabel39: TColorLabel;
    dbeRecDev: TDBEditFocus;
    cxvLojasMINDIG: TcxGridDBBandedColumn;
    cxvLojasPONPED: TcxGridDBBandedColumn;
    cxvLojasMAXDIG: TcxGridDBBandedColumn;
    shpPEACVI: TShape;
    shpPEACVE: TShape;
    shpPEACVD: TShape;
    cxvLojasSITPRO: TcxGridDBBandedColumn;
    pnlRodapePrecosUltCompraVendaMedio: TPanel;
    lblInfoCnvMl: TLabel;
    btnCfgGri: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    FlwPnlTabelas: TFlowPanel;
    gpbTabPre01: TcxGroupBox;
    lblTitMarBr1: TLabel;
    lblTitPreVe1: TLabel;
    lblMarBr1: TLabel;
    lblTitComTb1: TLabel;
    lblPerComTb1: TLabel;
    lblDolar1: TLabel;
    lblMarIdeSim1: TLabel;
    lblMarIde1: TLabel;
    dbeComTb1: TDBEditFocus;
    dbeMarBr1: TDBEditFocus;
    dbePreVe1: TDBEditFocus;
    edtDolar1: TEditFocus;
    dbeMarIde1: TDBEditFocus;
    gpbTabPre02: TcxGroupBox;
    lblTitMarBr2: TLabel;
    lblTitPreVe2: TLabel;
    lblMarBr2: TLabel;
    lblTitComTb2: TLabel;
    lblPerComTb2: TLabel;
    lblDolar2: TLabel;
    lblMarIdeSim2: TLabel;
    lblMarIde2: TLabel;
    dbeComTb2: TDBEditFocus;
    dbeMarBr2: TDBEditFocus;
    dbePreVe2: TDBEditFocus;
    edtDolar2: TEditFocus;
    dbeMarIde2: TDBEditFocus;
    gpbTabPre03: TcxGroupBox;
    lblMarBr3: TLabel;
    lblTitMarBr3: TLabel;
    lblTitPreVe3: TLabel;
    lblTitComTb3: TLabel;
    lblPerComTb3: TLabel;
    lblDolar3: TLabel;
    lblMarIdeSim3: TLabel;
    lblMarIde3: TLabel;
    dbeComTb3: TDBEditFocus;
    dbeMarBr3: TDBEditFocus;
    dbePreVe3: TDBEditFocus;
    edtDolar3: TEditFocus;
    dbeMarIde3: TDBEditFocus;
    gpbTabPre04: TcxGroupBox;
    lblTitMarBr4: TLabel;
    lblMarBr4: TLabel;
    lblTitPreVe4: TLabel;
    lblTitComTb4: TLabel;
    lblPerComTb4: TLabel;
    lblDolar4: TLabel;
    lblMarIde4: TLabel;
    lblMarIdeSim4: TLabel;
    dbeComTb4: TDBEditFocus;
    dbeMarBr4: TDBEditFocus;
    dbePreVe4: TDBEditFocus;
    edtDolar4: TEditFocus;
    dbeMarIde4: TDBEditFocus;
    gpbTabPre05: TcxGroupBox;
    lblTitMarBr5: TLabel;
    lblMarBr5: TLabel;
    lblTitPreVe5: TLabel;
    lblTitComTb5: TLabel;
    lblPerComTb5: TLabel;
    lblDolar5: TLabel;
    lblMarIdeSim5: TLabel;
    lblMarIde5: TLabel;
    dbeComTb5: TDBEditFocus;
    dbeMarBr5: TDBEditFocus;
    dbePreVe5: TDBEditFocus;
    edtDolar5: TEditFocus;
    dbeMarIde5: TDBEditFocus;
    gpbTabPre06: TcxGroupBox;
    lblTitMarBr6: TLabel;
    lblMarBr6: TLabel;
    lblTitPreVe6: TLabel;
    lblTitComTb6: TLabel;
    lblPerComTb6: TLabel;
    lblDolar6: TLabel;
    lblMarIde6: TLabel;
    lblMarIdeSim6: TLabel;
    dbeComTb6: TDBEditFocus;
    dbeMarBr6: TDBEditFocus;
    dbePreVe6: TDBEditFocus;
    edtDolar6: TEditFocus;
    dbeMarIde6: TDBEditFocus;
    gpbTabPre07: TcxGroupBox;
    lblTitMarBr7: TLabel;
    lblMarBr7: TLabel;
    lblTitPreVe7: TLabel;
    lblTitComTb7: TLabel;
    lblPerComTb7: TLabel;
    lblDolar7: TLabel;
    lblMarIde7: TLabel;
    lblMarIdeSim7: TLabel;
    dbeComTb7: TDBEditFocus;
    dbeMarBr7: TDBEditFocus;
    dbePreVe7: TDBEditFocus;
    edtDolar7: TEditFocus;
    dbeMarIde7: TDBEditFocus;
    lblDesCnd: TLabel;
    edtDesCnd: TDBEditFocus;
    lblDesCndSN: TColorLabel;
    cxgGiroCompras: TcxGridCitel;
    cxgGiroComprasLevel: TcxGridLevel;
    cxgGiroVendas: TcxGridCitel;
    cxgGiroVendasLevel: TcxGridLevel;
    Panel10: TPanel;
    btnAbrirPasta: TBitBtnLocked;
    mnuSemelhantes: TMenuItem;
    tbsAbreviacaoes: TTabSheet;
    pnlAbrev: TPanel;
    pnlUsarSeries: TPanel;
    ColorLabel9: TColorLabel;
    Label203: TLabel;
    spbVerSeries: TSpeedButton;
    dbeUSASER: TDBEditFocus;
    lblUSABEF: TLabel;
    dbeUSABEF: TDBEditFocus;
    clbUSABEF: TColorLabel;
    pnlImpEtiqRes: TPanel;
    lblImpEtiqRes: TLabel;
    ColorLabelImpEtiqRes: TColorLabel;
    dbeImpEtiqRes: TDBEditFocus;
    pnlSubProdPermiteVendaSeparado: TPanel;
    lblSubProdPermiteVendaSeparado: TLabel;
    clbSubProdPermiteVendaSeparado: TColorLabel;
    dbeSubProdPermiteVendaSeparado: TDBEditFocus;
    lblCarEst: TLabel;
    cmbCarEst: TComboBoxFocus;
    lblPMED_V: TLabel;
    edtPMED_V: TEditFocus;
    cxbGiroVendas: TcxGridDBBandedTableViewCitel;
    cxbGiroVendasGIR_CODEMP: TcxGridDBBandedColumn;
    cxbGiroVendasMES01: TcxGridDBBandedColumn;
    cxbGiroVendasMES02: TcxGridDBBandedColumn;
    cxbGiroVendasMES03: TcxGridDBBandedColumn;
    cxbGiroVendasMES04: TcxGridDBBandedColumn;
    cxbGiroVendasMES05: TcxGridDBBandedColumn;
    cxbGiroVendasMES06: TcxGridDBBandedColumn;
    cxbGiroVendasMES07: TcxGridDBBandedColumn;
    cxbGiroVendasMES08: TcxGridDBBandedColumn;
    cxbGiroVendasMES09: TcxGridDBBandedColumn;
    cxbGiroVendasMES10: TcxGridDBBandedColumn;
    cxbGiroVendasMES11: TcxGridDBBandedColumn;
    cxbGiroVendasMES12: TcxGridDBBandedColumn;
    cxbGiroVendasMES13: TcxGridDBBandedColumn;
    cxbGiroVendasGIR_MEDI03_VEN: TcxGridDBBandedColumn;
    cxbGiroVendasGIR_MEDI06_VEN: TcxGridDBBandedColumn;
    cxbGiroVendasGIR_MEDI12_VEN: TcxGridDBBandedColumn;
    cxbGiroCompras: TcxGridDBBandedTableViewCitel;
    cxbGiroComprasGIR_CODEMP: TcxGridDBBandedColumn;
    cxbGiroComprasMES01: TcxGridDBBandedColumn;
    cxbGiroComprasMES02: TcxGridDBBandedColumn;
    cxbGiroComprasMES03: TcxGridDBBandedColumn;
    cxbGiroComprasMES04: TcxGridDBBandedColumn;
    cxbGiroComprasMES05: TcxGridDBBandedColumn;
    cxbGiroComprasMES06: TcxGridDBBandedColumn;
    cxbGiroComprasMES07: TcxGridDBBandedColumn;
    cxbGiroComprasMES08: TcxGridDBBandedColumn;
    cxbGiroComprasMES09: TcxGridDBBandedColumn;
    cxbGiroComprasMES10: TcxGridDBBandedColumn;
    cxbGiroComprasMES11: TcxGridDBBandedColumn;
    cxbGiroComprasMES12: TcxGridDBBandedColumn;
    cxbGiroComprasGIR_MEDI03_COM: TcxGridDBBandedColumn;
    cxbGiroComprasGIR_MEDI06_COM: TcxGridDBBandedColumn;
    cxbGiroComprasGIR_MEDI12_COM: TcxGridDBBandedColumn;
    tbsDesMaxFaixaQtde: TTabSheet;
    tbsproduto_veiculo: TTabSheet;
    pnlProdutoVeiculo: TPanel;
    Panel13: TPanel;
    cxVeiculoProduto: TcxGridCitel;
    cxVeiculoProdutoView: TcxGridDBTableViewCitel;
    cxVeiculosProdutoCODMAR: TcxGridDBColumn;
    cxVeiculosProdutoCODMOD: TcxGridDBColumn;
    cxVeiculosProdutoANOINI: TcxGridDBColumn;
    cxVeiculosProdutoANOFIN: TcxGridDBColumn;
    cxVeiculosProdutoCOMBUS: TcxGridDBColumn;
    cxVeiculosProdutoVALVUL: TcxGridDBColumn;
    cxVeiculosProdutoCILIND: TcxGridDBColumn;
    cxVeiculosProdutoPOTENC: TcxGridDBColumn;
    cxVeiculoProdutoLevel1: TcxGridLevel;
    Panel14: TPanel;
    Label213: TLabel;
    Panel12: TPanel;
    Label204: TLabel;
    Label205: TLabel;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    btnAddRelacionamentoProdutoVeiculo: TBitBtnLocked;
    btnCarregaModeloVeiculoExistente: TSpeedButton;
    cxVeiculosProdutoDESMAR: TcxGridDBColumn;
    cxVeiculosProdutoDESMOD: TcxGridDBColumn;
    Label214: TLabel;
    mskAnoInicial: TMaskEditFocus;
    mskAnoFin: TMaskEditFocus;
    edtValvula: TEditFocus;
    edtCilindrada: TEditFocus;
    edtPotencia: TEditFocus;
    cmbCombustivel: TComboBoxFocus;
    btnCancelar: TBitBtnLocked;
    edtDescModVei: TEditFocus;
    edtDescMarVei: TEditFocus;
    chkLimpaCamposVeiculo: TCheckBox;
    lblDesChk: TLabel;
    bdeDesChk: TDBEditFocus;
    lblDesChkSN: TColorLabel;
    lblCotMoe: TLabel;
    edtCotMoe: TEditFocus;
    dbeMltSpo: TDBEditFocus;
    lblTransSpoolMlt: TLabel;
    ColorLabel40: TColorLabel;
    Label215: TLabel;
    edtObservacoes: TEditFocus;
    tbsAtributos: TTabSheet;
    cxStyleRepositoryAtr: TcxStyleRepository;
    cxsColunaFixa: TcxStyle;
    cxsColunaFixaDestaque: TcxStyle;
    cxsTitulo: TcxStyle;
    cxsNegrito: TcxStyle;
    cxedtRepositoryAtr: TcxEditRepository;
    cxEditRepositoryCurrencyItem1: TcxEditRepositoryCurrencyItem;
    cxVeiculoProdutoOBSERV: TcxGridDBColumn;
    tbsLoteRastreamento: TTabSheet;
    cxgLoteRastreamentoTBV: TcxGridDBTableViewCitel;
    cxgLoteRastreamentoLVL: TcxGridLevel;
    cxgLoteRastreamento: TcxGridCitel;
    cxgLoteRastreamentoTBVColumn1: TcxGridDBColumn;
    cxgLoteRastreamentoTBVColumn2: TcxGridDBColumn;
    cxgLoteRastreamentoTBVColumn3: TcxGridDBColumn;
    cxgLoteRastreamentoTBVColumn4: TcxGridDBColumn;
    cxgLoteRastreamentoTBVColumn5: TcxGridDBColumn;
    dtsLoteRastreamento: TDataSource;
    Panel11: TPanel;
    lblDepartamentoLoteRastreamento: TLabel;
    lblApeEnt: TLabel;
    lblSimNao: TColorLabel;
    dbeApeEnt: TDBEditFocus;
    cxvLojasAPEENT: TcxGridDBBandedColumn;
    pnlAbrevContabil: TPanel;
    Label216: TLabel;
    dbeAbfCon: TDBEditFocus;
    edtDesAbfCon: TEditFocus;
    pnlSuframa: TPanel;
    dbeCICMDE: TDBEditFocus;
    dbeCDPIOP: TDBEditFocus;
    Label217: TLabel;
    ColorLabel41: TColorLabel;
    Label218: TLabel;
    dbeDIDIOP: TDBEditFocus;
    Label219: TLabel;
    ColorLabel42: TColorLabel;
    ColorLabel43: TColorLabel;
    pnlCamposSuframa: TPanel;
    Label221: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    Label225: TLabel;
    dbeTCIF: TDBEditFocus;
    dbeTS: TDBEditFocus;
    dbeDePiCo: TDBEditFocus;
    dbeDeICMS: TDBEditFocus;
    dbeFatReg: TDBEditFocus;
    Label227: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label230: TLabel;
    Label231: TLabel;
    pnlCusReal: TPanel;
    lblOutVal: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label66: TLabel;
    lblCusReaTit: TLabel;
    dbeOutVal: TDBEditFocus;
    dbeIcmSai: TDBEditFocus;
    dbeImpFed: TDBEditFocus;
    dbeDesOpe: TDBEditFocus;
    edtCusRea: TEditFocus;
    Label44: TLabel;
    Label29: TLabel;
    lblDesOpePer: TLabel;
    dtsPermissaoVenda: TDataSource;
    lkpPermissaoVenda: TDBLookupComboBoxFocus;
    Label26: TLabel;
    pnlQuestDemanda: TPanel;
    pnlUsaQuest: TPanel;
    lblColorUsaQuest: TColorLabel;
    lblUsaQuest: TLabel;
    dbeUsaQuest: TDBEditFocus;
    pnlConferenciaDemanda: TPanel;
    dbeCNFDEM: TDBEditFocus;
    Label232: TLabel;
    pnlComponente: TPanel;
    Label220: TLabel;
    ColorLabel44: TColorLabel;
    Label226: TLabel;
    ColorLabel45: TColorLabel;
    dbeComponenteA: TDBEditFocus;
    dbeComponenteB: TDBEditFocus;
    lblRspGar: TLabel;
    dbeRspGar: TDBEditFocus;
    lblLoja_fornec: TColorLabel;
    pnlDesclComponeteAB: TPanel;
    Label234: TLabel;
    Label235: TLabel;
    gpbAtributos: TGroupBox;
    pnlBotoesAtributos: TPanel;
    Label1770: TLabel;
    edtCodAtri: TEditFocus;
    edtDesAtri: TEditFocus;
    btnIncluiAtrib: TBitBtnLocked;
    btnExcluiAtrib: TBitBtnLocked;
    cxdAtributos: TcxDBVerticalGrid;
    dbeProdutoDiluente: TDBEditFocus;
    dbeProduto: TDBEditFocus;
    edtDesProduto: TEditFocus;
    edtDescProdutoDiluente: TEditFocus;
    pnlCatalise: TPanel;
    lblDetUti: TLabel;
    dbeDetUti: TDBMemoFocus;
    lblPatVid: TLabel;
    dbePatVid: TDBEditFocus;
    btnPatVid: TcxButton;
    openPatVid: TOpenDialog;
    Label233: TLabel;
    dbeValorCatalise: TDBEditFocus;
    lblTemPro: TLabel;
    dbeTemPro: TDBEditFocus;
    lblDtaLanMer: TLabel;
    dbeDtaLan: TDBEditFocus;
    lblCodGpc: TLabel;
    dbeCodGpc: TDBEditFocus;
    edtDesGpc: TEditFocus;
    cxvLojasESMIDG: TcxGridDBBandedColumn;
    edtDesEmpCar: TEditFocus;
    lblEmpCar: TLabel;
    dbeEmpCar: TDBEditFocus;
    btnMemCalcPrecoImpEmb: TSpeedButton;
    btnMemCalcPrecoImpostos: TSpeedButton;
    btnMemCalcPrecoMedio: TSpeedButton;
    pnlCertEPI_BNDES: TPanel;
    ColorLabel12: TColorLabel;
    Label47: TLabel;
    dbeBNDES: TDBEditFocus;
    DBEditFocus4: TDBEditFocus;
    Label61: TLabel;
    cbxAplicarTodas: TCheckBox;
    tbsIteCom: TTabSheet;
    dbgIteComDBTableView: TcxGridDBTableView;
    dbgIteComLevel1: TcxGridLevel;
    dbgIteCom: TcxGrid;
    dbgIteComDBTableViewColumn1: TcxGridDBColumn;
    dbgIteComDBTableViewColumn2: TcxGridDBColumn;
    dbgIteComDBTableViewColumn3: TcxGridDBColumn;
    Label198: TLabel;
    dbeExpPok: TDBEditFocus;
    ColorLabel35: TColorLabel;
    GroupBox2: TGroupBox;
    lbl15: TLabel;
    lbl17: TColorLabel;
    Label171: TLabel;
    lblDiaCri: TLabel;
    lblVALDIA: TLabel;
    lblTOLREC: TLabel;
    dbeValObr: TDBEditFocus;
    dbeVALIDA: TDBEditFocus;
    dbeDiaCri: TDBEditFocus;
    dbeTOLREC: TDBEditFocus;
    dbeVALDIA: TDBEditFocus;
    tbsControlePallet: TTabSheet;
    cxvPalett: TcxGridDBTableView;
    cxlPalett: TcxGridLevel;
    cxgPalett: TcxGrid;
    cxvPaleteCodFor: TcxGridDBColumn;
    cxvPalettColumn2: TcxGridDBColumn;
    cxvPaleteQtdIIte: TcxGridDBColumn;
    cxvPaleteValIte: TcxGridDBColumn;
    dtsControlePallet: TDataSource;
    Panel15: TPanel;
    Label65: TLabel;
    Panel16: TPanel;
    lblCodFornecedor: TLabel;
    edtDesForPal: TEditFocus;
    Label123: TLabel;
    Label236: TLabel;
    btnGravaPalete: TBitBtnLocked;
    btnCancelPalete: TBitBtnLocked;
    edtQtdItePal: TEditFocus;
    edtValPalet: TEditFocus;
    edtCodForPal: TEditFocus;
    pnlIteCCR: TPanel;
    lblIteCcr: TLabel;
    dbeIteCCR: TDBEditFocus;
    clbIteCcr: TColorLabel;
    pnlLocEqui: TPanel;
    lblPermiteLoc: TLabel;
    dbeReaLoc: TDBEditFocus;
    clbReaLoc: TColorLabel;
    lblTipLoc: TLabel;
    dbeTipLoc: TDBEditFocus;
    clbTipLoc: TColorLabel;
    pnlControladoPolicia: TPanel;
    ColorLabel46: TColorLabel;
    Label80: TLabel;
    ColorLabel47: TColorLabel;
    Label237: TLabel;
    DBEUSAPFD: TDBEditFocus;
    DBEUSAPCV: TDBEditFocus;
    pnlQRCode: TPanel;
    Label238: TLabel;
    dbeQRCode: TDBEditFocus;
    cxvLojasPONEXP: TcxGridDBBandedColumn;
    clbAtoDDF: TColorLabel;
    dbeAtoDDF: TDBEditFocus;
    lblAtoDDF: TLabel;
    pnlEmpSug: TPanel;
    Label124: TLabel;
    dbeCodEmpSug: TDBEditFocus;
    edtDesEmpSug: TEditFocus;
    lblDesMvm: TLabel;
    lblDesMvmPor: TLabel;
    dbeDesMvm: TDBEditFocus;
    lblDesMsm: TLabel;
    dbeDesMsm: TDBEditFocus;
    lblDesMsmPor: TLabel;
    lblDesMgm: TLabel;
    dbeDesMgm: TDBEditFocus;
    lblDesMgmPor: TLabel;
    cxgDesMaxTabPre: TcxGrid;
    cxgDesMaxTabPreeView: TcxGridDBBandedTableView;
    cxgDesMaxTabPreeViewColumn2: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn3: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn4: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn1: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn6: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn5: TcxGridDBBandedColumn;
    cxgDesMaxTabPreeViewColumn7: TcxGridDBBandedColumn;
    cxgDesMaxTabPreLevel1: TcxGridLevel;
    cxgDesMaxFaixaQtde: TcxGrid;
    cxgDesMaxFaixaQtdeTreeView: TcxGridDBBandedTableView;
    cxgDesMaxFaixaQtdeTreeViewInicial: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewFinal: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewDesVen: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewDesSub: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewDesGer: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewColumn1: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewColumn2: TcxGridDBBandedColumn;
    cxgDesMaxFaixaQtdeTreeViewColumn3: TcxGridDBBandedColumn;
    cxGridLevel1: TcxGridLevel;
    Label246: TLabel;
    dbeIteBal: TDBEditFocus;
    ColorLabel48: TColorLabel;
    procedure btnEstruturaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    function dbeCodMarChamaCadastro(Key: Word): String;
    function dbeCodForChamaCadastro(Key: Word): String;
    function dbeCodUniChamaCadastro(Key: Word): String;
    function dbeCodAbrChamaCadastro(Key: Word): String;
    function dbeCodGruChamaCadastro(Key: Word): String;
    procedure dbeCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHerancaClick(Sender: TObject);
    procedure pValidarPrecos(Sender: TObject);
    procedure dbeDesIteChange(Sender: TObject);
    procedure dbeSetFlzKeyPress(Sender: TObject; var Key: Char);
    procedure dbeValCalEnter(Sender: TObject);
    procedure tbsPrecosShow(Sender: TObject);
    procedure dbgComprasTitleClick(Column: TColumn);
    procedure dbgComprasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgVendasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbsUltVendaShow(Sender: TObject);
    procedure pgcUltVendaCompraEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbsGeralShow(Sender: TObject);
    procedure dbeDesIteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeDesFabKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAplicaKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodGprKeyPress(Sender: TObject; var Key: Char);
    procedure dbeInfExtKeyPress(Sender: TObject; var Key: Char);
    procedure dbeInfExtExit(Sender: TObject);
    procedure dbeUniComKeyPress(Sender: TObject; var Key: Char);
    procedure imgProDblClick(Sender: TObject);
    procedure pgcUltVendaCompraChange(Sender: TObject);
    procedure dbeCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure btnVenComClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbeAbfCofKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAbfIpiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeAbfPisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSitProKeyPress(Sender: TObject; var Key: Char);
    procedure dbeLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeSupEstKeyPress(Sender: TObject; var Key: Char);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure dbeCodDepExit(Sender: TObject);
    procedure dbeTipFreChange(Sender: TObject);
    procedure dbeGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodComKeyPress(Sender: TObject; var Key: Char);
    procedure chkPreDolClick(Sender: TObject);
    procedure edtCodFornKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarFornClick(Sender: TObject);
    procedure btnCancelarFornClick(Sender: TObject);
    procedure dbgFornecedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgFornecedorTitleClick(Column: TColumn);
    procedure dbePrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodOnuKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodDicKeyPress(Sender: TObject; var Key: Char);
    procedure cxredtDesMaxPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure dtsCadIteDataChange(Sender: TObject; Field: TField);
    procedure dtsCadIteStateChange(Sender: TObject);
    procedure mnuPromocoesClick(Sender: TObject);
    procedure mnuProdutosAcabadosClick(Sender: TObject);
    procedure cxgIteEmbTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgIteEmbTableViewDblClick(Sender: TObject);
    procedure btnAdicionaIteEmbClick(Sender: TObject);
    procedure btnCancelaIteEmbClick(Sender: TObject);
    procedure btnMaisInfoClick(Sender: TObject);
    procedure mnuEmprestimosClick(Sender: TObject);
    procedure mnuPreparaGerTEClick(Sender: TObject);
    procedure edtCodFornEnter(Sender: TObject);
    procedure edtCodFornExit(Sender: TObject);
    procedure edtCodFornKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure FichaKardex1Click(Sender: TObject);
    procedure dbeCodLseKeyPress(Sender: TObject; var Key: Char);
    procedure btnTabForClick(Sender: TObject);
    procedure dbeExcIpiExit(Sender: TObject);
    procedure dbeExcIpiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeTpCoMcExit(Sender: TObject);
    procedure dbeMarBr1Enter(Sender: TObject);
    procedure dbeMarBr2Enter(Sender: TObject);
    procedure dbeMarBr3Enter(Sender: TObject);
    procedure dbeMarBr4Enter(Sender: TObject);
    procedure dbeMarBr5Enter(Sender: TObject);
    procedure dbeMarBr6Enter(Sender: TObject);
    procedure dbeMarBr7Enter(Sender: TObject);
    function dbeCdCestChamaCadastro(Key: Word): string;
    procedure dbeCdCestKeyPress(Sender: TObject; var Key: Char);
    procedure dbgFornecedorDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure dbePesoItExit(Sender: TObject);
    procedure mnuConstrucaodoPreodeCustoClick(Sender: TObject);
    procedure dbeUniComExit(Sender: TObject);
    procedure dbeUniTriKeyPress(Sender: TObject; var Key: Char);
    procedure btnPraMinHelpClick(Sender: TObject);
    procedure btnCfgGriClick(Sender: TObject);
    procedure dbeEmbalagemChange(Sender: TObject);
    procedure btnFatAcreClick(Sender: TObject);
    procedure cxvLojasCODEMPCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure tbsEstoqueEnter(Sender: TObject);
    procedure cxvLojasESTMAXPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLojasESTMINPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLojasEMPCENPropertiesCloseUp(Sender: TObject);
    procedure dbeCodLayOrdProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodLayOrdIndKeyPress(Sender: TObject; var Key: Char);
    procedure btnAddLayOrdIndClick(Sender: TObject);
    procedure btnCancelLayOrdIndClick(Sender: TObject);
    procedure cxgLayOrdIndTVDblClick(Sender: TObject);
    procedure cxgLayOrdIndTVKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxvLojasMINDIGPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLojasPONPEDPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLojasColumn1PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvLojasSITPROPropertiesCloseUp(Sender: TObject);
    procedure dbeAplicaExit(Sender: TObject);
    procedure dbeAplicaEnter(Sender: TObject);
    procedure cxbGiroComprasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxbGiroVendasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAbrirPastaClick(Sender: TObject);
    procedure mnuSemelhantesClick(Sender: TObject);
    procedure spbVerSeriesClick(Sender: TObject);
    procedure dbeUSASERChange(Sender: TObject);
    procedure cxgDesMaxFaixaQtdeTreeViewInicialPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure pgcDadosChange(Sender: TObject);
    procedure dbeClaIpiKeyPress(Sender: TObject; var Key: Char);
    procedure cxgDesMaxFaixaQtdeTreeViewFinalPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxgDesMaxFaixaQtdeTreeViewDesVenPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxgDesMaxFaixaQtdeTreeViewDesSubPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cxgDesMaxFaixaQtdeTreeViewDesGerPropertiesValidate(
      Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnAddRelacionamentoProdutoVeiculoClick(Sender: TObject);
    procedure edtMarcaVeiculoKeyPress(Sender: TObject; var Key: Char);
    procedure edtModeloVeiculoKeyPress(Sender: TObject; var Key: Char);
    procedure cxVeiculoProdutoViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbsproduto_veiculoShow(Sender: TObject);
    procedure cxVeiculoProdutoViewCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnExcluiAtribClick(Sender: TObject);
    procedure edtCodAtriKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluiAtribClick(Sender: TObject);
    procedure edtCodAtriKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodAtriEnter(Sender: TObject);
    procedure edtCodAtriExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCarregaModeloVeiculoExistenteClick(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure dbePreVe1MouseEnter(Sender: TObject);
    procedure dbePreVe2MouseEnter(Sender: TObject);
    procedure dbePreVe3MouseEnter(Sender: TObject);
    procedure dbePreVe4MouseEnter(Sender: TObject);
    procedure dbePreVe5MouseEnter(Sender: TObject);
    procedure dbePreVe6MouseEnter(Sender: TObject);
    procedure dbePreVe7MouseLeave(Sender: TObject);
    procedure dbePreVe7MouseEnter(Sender: TObject);
    procedure dbePreVe6MouseLeave(Sender: TObject);
    procedure dbePreVe5MouseLeave(Sender: TObject);
    procedure dbePreVe4MouseLeave(Sender: TObject);
    procedure dbePreVe3MouseLeave(Sender: TObject);
    procedure dbePreVe2MouseLeave(Sender: TObject);
    procedure dbePreVe1MouseLeave(Sender: TObject);
    procedure dbeAplicaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeDetUtiKeyPress(Sender: TObject; var Key: Char);
    procedure btnPatVidClick(Sender: TObject);
    procedure dbeDetUtiEnter(Sender: TObject);
    procedure dbeAbfConKeyPress(Sender: TObject; var Key: Char);
    procedure dbeProdutoDiluenteKeyPress(Sender: TObject; var Key: Char);
    procedure dbeComponenteAExit(Sender: TObject);
    procedure dbeProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeComponenteBKeyPress(Sender: TObject; var Key: Char);
    procedure dbeValorCataliseKeyPress(Sender: TObject; var Key: Char);
    procedure tbsProdAcabShow(Sender: TObject);
    procedure btnGs1CnpClick(Sender: TObject);
    procedure dbeCodGpcKeyPress(Sender: TObject; var Key: Char);
    function dbeCodGpcChamaCadastro(Key: Word): string;
    procedure dbeEmpCarKeyPress(Sender: TObject; var Key: Char);
    procedure tbsDesMaxTBPShow(Sender: TObject);
    procedure btnMemCalcPrecoImpEmbClick(Sender: TObject);
    procedure btnMemCalcPrecoImpostosClick(Sender: TObject);
    procedure btnMemCalcPrecoMedioClick(Sender: TObject);
    procedure cbxAplicarTodasClick(Sender: TObject);
    procedure dbgIteComDBTableViewColumn2PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure dbgIteComDBTableViewColumn3PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxvPalettDblClick(Sender: TObject);
    procedure btnGravaPaleteClick(Sender: TObject);
    procedure btnCancelPaleteClick(Sender: TObject);
    procedure edtCodForPalKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdItePalExit(Sender: TObject);
    procedure edtValPaletExit(Sender: TObject);
    procedure dbeObrCpfExit(Sender: TObject);
    procedure dbeCodEmpSugExit(Sender: TObject);
    procedure dbeCodEmpSugKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForEnter(Sender: TObject);
    procedure dbeCodForExit(Sender: TObject);

  private
    { Private declarations }
    blnCCDPRM : Boolean;
    FornecedorItemPalettRecord: TFornecedorItemPalettRecord;
    FornecedorItemPalett : TFornecedorItemPalett;
    intConfirma: Integer;
    objCadProdutosVeiculoModelo : TCadProdutosVeiculoModelo;
    objCalculaVariacaoPreco: TCalculaVariacaoPreco;
    strAgrupadorPreAlt: String;

    strForAnt: String;
    blnTabPrd: Boolean;
    frmTabelasDoItem: TfrmTabelasDoItemFrame;
    frmTabelasDoItemGrid: TfrmTabelasDoItemGrid;
    objTabelas: TTabelasDoItem;

    BeneficioST_Precos : TBeneficioST_Precos;
    blnMosMar,
    blnPredol: boolean;
    intQYear: Word;

    qryMemoriaCalculo: TUniQuery;

    strEstadoEmpresa,
    strPcmPro: String;

    blnPossuiBeneficioFiscal: Boolean;

    blnMarNeg: Boolean;

    objLojas: TLojasCadIte;

    cpcParams: TParCalculaPrecoCusto;

    objAtributos: TAtributosProduto;

    objCfgGriCompras,
    objCfgGriGiroCompras,
    objCfgGriVendas,
    objCfgGriGiroVendas,
    objCfgGriLoteRastreamento: TCfgGrid;

    intPreWidth : Integer;
    frmGravandoGirIte: TfrmGravando;
    blnAcessoPrecos: Boolean;

    qryCadNcm: TUniQuery;

    blnRecalcular: Boolean;

    strMarMkp: String;
    blnMarIde: Boolean;

    objSender: TWinControl;
    blnInsert,
    blnInserindo     : Boolean;
    blnAcaoGravacao  : Boolean;
    blnCancelando    : Boolean;

    pgbStatusGravacao: TcxProgressBar;

    wrdLasKey: Word;
    objCadLot: TCadLot;
    blnCadLoc: Boolean;
    intDecUni: Integer;
    intVenMar: Integer;
    blnInfMat: Boolean;

    intInfFed,
    intInfOpe,
    intInfSai: Integer;

    objLocFis: TLocFisAdicionais;
    objIteMon: TCadIteMontadoras;
    dbeLstCmp: TWinControl;
    objFatPre: TFatorPreco;
    objComplementoEtiquetas : TComplementoEtiquetasProd;

    MSG_VALIDACAO_MARGEM: String;

    blnFatPre: Boolean;
    blnURapel: Boolean;

    blnAtualizouUV: Boolean;
    blnAtualizouUC: Boolean;
    blnPreMat: Boolean;

    strDesValFre: String;

    qryConMar: TUniQuery;
    qryConFor: TUniQuery;
    qryConAbf: TUniQuery;
    qryConGru: TUniQuery;
    qryGeneri: TUniQuery;
    qryConUni: TUniQuery;
    qryDesSit: TUniQuery;
    qryConLse: TUniQuery;

    intUltTab: Integer;
    intPriTab: Integer;

    fltMa1Ant: Double;
    fltMa2Ant: Double;
    fltMa3Ant: Double;
    fltMa4Ant: Double;
    fltMa5Ant: Double;
    fltMa6Ant: Double;
    fltMa7Ant: Double;

    objLockEdicao  : TLock;

    fltVe1Ant: Double;
    fltVe2Ant: Double;
    fltVe3Ant: Double;
    fltVe4Ant: Double;
    fltVe5Ant: Double;
    fltVe6Ant: Double;
    fltVe7Ant: Double;

    fltCusAnt: Double;
    fltComAnt: Double;

    lstTintas: TStringList;

    strForTel: String;
    strForCid: String;
    strFor_UF: String;

    qryGenIte: TUniQuery;
    qryCadSfz: TUniQuery;
    qryPreAlt: TUniQuery;

    qryLotAmz : TUniQuery;
    dtsLotAmz : TDataSource;

    qryUltVendas : TUniQuery;
    qryUltCompras: TUniQuery;
    dtsUltVendas : TDataSource;
    dtsUltCompras: TDataSource;

    cdsFornecedor: TUniClientDataSet;
    dtsFornecedor: TDataSource;
    strLastField_For : String;

    cdsLayOrdInd: TZClient;

    cdsDesMaxTabPre: TUniClientDataSet;
    dtsDesMaxTabPre: TDataSource;

    FcdsDesMaxFaixaQtde: TUniClientDataSet;
    FdtsDesMaxFaixaQtde: TDataSource;

    strLocAnt: String;
    strSupAnt: String;

    strMemPrecoUltCompraImp: String;


    FPanelDadosECommerce: TfrmPanelDadosECommerce;

    blnUsaTabPrF: Boolean;

    blnSimPau : Boolean;
    blnSergipe : Boolean;
    qryGirIte : TZClient;

    objLoteRastreamento : TLoteRastreamento;

    stlCamGir : TStringList;
    stlCamNom : TStringList;

    stlIteEmbHer : TStringList;

    FValidouPrecos: Boolean;

    cdsIteEmb : TZClient;

    blnUsaFle : Boolean;

    arrIteEmbDel: TArrIteEmbDeleted;

    arrMarIdeAlt: TArrMarIdeAlterada;

    objFaixasMet: TFaixasMetragem;

    blnUnidadeEFracionada: Boolean;

    intSitPro: Integer;
    blnUtilizaBeneficioST: Boolean;

    frmManutencaoAbreviacoesLojas: TfrmManutencaoAbreviacoesLojas;

    FAccessToken: String;
    blnHeranca: Boolean;

    blnValidaLocFis: Boolean;
    cdsIteCom: TZClient;

    function fVerificaPreco(objObjeto: TWinControl): Boolean;
    Function fValidaPrecos: Boolean;
    function  fValidarFatorMadeira_X_Pecas: boolean;
    procedure pLimpaInfPallets;

    Function fProdutoEstaDesatualizado: Boolean;
    Function fFormataValor(Valor: Double; Format: String): String;

    Procedure pMontaCamGir;
    procedure pIndicaTipoProdutoSPED;
    procedure pIndicaMarcaBase;
    procedure pHabilitaCamposMateriaPrima;
    procedure pStepStatusGravacao;
    Procedure pFinalizaStatusGravacao;
    procedure pCarregaItegerAtual(qryIteAtu: TUniQuery);
    Procedure pAjustaFatorPreco(blnDesabilita: Boolean);
    procedure pCarregaMarca;
    procedure pCarregaFornecedor;
    procedure pCarregaFornecedorIteFor;
    procedure pCarregaAbreviacao;
    procedure pCarregaLinGru;
    procedure pCarregaCadSfz;
    procedure pCarregaDadosSomenteLeitura(qryIteGer: TUniQuery);
    procedure pCarregaDadosAdicionais;
    procedure pCarregaComplementoEtiquetas;
    procedure pEscondeQtdPontosProfissional;
    procedure pCarregaCadUni;
    procedure pAtribuiTabelas;
    procedure pCarregaDepartamento;
    procedure pCarregaOperador;
    procedure pCarregaIteGer;
    procedure pCarregaLocSep;

    procedure pCriaPrecosFornecedor;
    procedure pDesabilitaCamposDaTabelaDePreco;


    procedure pGeraIteGer;

    procedure pAtualizaIteGer(blnResFor: Boolean);
    procedure pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(strCodIte: String);
    procedure pAtualizaVariaveis;

    procedure pGravaPreAlt;
    procedure pHabilitaIcms;
    procedure pDesabilitaCamposCadIte;
    procedure pIniciaValoresPadrao;
    procedure pRecalculaPrecos(intPreMar: Integer; qryIteExec: TUniQuery= nil);

    procedure pMostraMargemIdeal;
    procedure pCalculaPrecoVendaIdeal;
    function fVerificaMargemUtilizada: Boolean;

    procedure pAtualizaOpcaoEstMinLojas;
//    procedure pAtualizaCprCenLojas;
    procedure pAtualizaImpLisLojas;
    procedure pAtualizaApeRetLojas;
    procedure pAtualizaApeEntLojas;
    procedure pAtualizaSitProLojas;

    {*****************************************}
    {* FUNÇÕES PARA MONTAR A TELA DE ESTOQUE *}
    {**************************************MV*}
    procedure pMontaTelaEstoque;

    Procedure pRecalculaPrecosFator(qryIteExec: TUniQuery= nil);

    procedure pCarregaImpostosEmpresa;
    function GetControlClientOrigin(const aControl: TWinControl; const aForm: TForm): TPoint;

    Function  fGravaItemProgresso: Boolean;
    Function  fRetMaxPassos(blnSomaEmpresas: Boolean): Integer;
    Function  fGravaItem(pgbProgresso: TcxProgressBar): Boolean;
    function  fCalculaPrecoCompraLiq(qryExt: TUniQuery = nil): Double;
    function  fCalculaCustoReal: Double;

    Function  fMarcaAtivoCatIte(strCodFab, strCodFor: String): Boolean;
    function  fRetPrecoCusto(blnUtilizarConversorDeMoeda: Boolean; qryExt: TUniQuery = nil): Double;
    function  fRetPrecoVenda(intOpcao, intNumPreVen: Integer; qryExt: TUniQuery = nil): Double;
    function  fItemCadastrado(strCodIte: String): Boolean;

    procedure pCarregaMarcasBases;
    procedure pCarregaLotAmz(strCodIte : String);
    procedure pCarregaUltVendas(strCodIte : String);
    procedure pCarregaUltCompras(strCodIte : String; strNomCol : String = 'DTA_MOV');

    function fValidaMargem(intTabPreco: Integer): Boolean;
    function fValidaMargemIdeal(intTabPreco: Integer): Boolean;
    procedure pAjustaGridEstoquePontoExposicao(AstrCodEmp: String);

    function fDbEditFocus(strNome: String): TDBEditFocus;

//    function fVerificaChaves(strTable, strField, strValue: String): String;
//    function fBuscaChaveEstrangeira(strTable, strChave: String): Boolean;
//    function fQtdRegistro(strTable, strField, strValue: String): Integer;
    function fRetornaForFil: String;

    function fRetDesAbfPis(strAbfPis: String): String;
    function fRetDesAbfCof(strAbfCof: String): String;
    function fRetDesAbfIpi(strAbfIpi: String): String;

    procedure pCriafrmPanelDadosECommerce;

//    procedure pVerificaDepartamentoIndustrial;
    procedure pGerarProdutosAcabados;
    function  fDepartamentosPreenchidos: Boolean;
    procedure pCadastrarProdutosAcabadosAutomaticamente(arrUnidades,arrCores, arrComposicao: Array Of String);
    function  fCadIteProCodAutomatico: Boolean;
    procedure pCadastrarProdutosAcabados(arrUnidades, arrCores, arrComposicao: Array Of String);
    function  fExistirProdutoAcabado: Boolean;

    procedure pCarregaFornecedores(strCodIte: String; strNomCol: String = 'FOR_NOMFOR');
    procedure pCarregaDesMaxTabelaPreco(strCodIte, strCodEmp: String);
    procedure pCriaClientFornecedor;
    procedure pCriaClientDesMaxTabPre;
    procedure pGravaIteFor;
    procedure pDeletIteAgr(strCodIte: String);
    procedure pGravaDesMaxTabPre(strCodIte, strCodEmp: String);

    procedure pControlaCampoComposicao;
    procedure pFechaUltimasComprasVendas;
    procedure pUpdateCaption;
    procedure qryTabelaOnBeforePost(DataSet: TDataSet);
    procedure pHabilitaReaEnderecamento;

    function fGetSqlGiro : String;
    procedure pAbreQryGir;
    function fUltimasComprasVendas(cxProgress : TcxProgressbar):Boolean;
    procedure pAjustaDolar;
    function fGetSQLIteEmb: String;
    procedure pAbreIteEmb;
    procedure pChecaPrincipalRomaneio;
    procedure pGetTextItbTabPre(Sender: TField; var Text: String; Display: Boolean);
    procedure pSetTextItbTabPre(Sender: TField; const Text: String);
    procedure pReplicarIteEmbEmpresas;
    function  fConverterAreaPelaSiglaEmb(fltLargura, fltAltura: Double): Double;
    procedure pCalcularAreaSugestao;
    procedure pCalcularAreaMaxima;
    procedure pCalcularAreaMinima;

    function fIVAMod4: Double;
    function fPreComLiq(qryDestin: TUniQuery): Double;
    function fGetedtComEti(i : Integer) : TEditFocus;
    function fGetlblComEti(i : Integer) : TLabel;
    function fGetpnlComEti(i: Integer): TPanel;
    procedure pCarregaLabelComplementoEtiquetas;
    procedure pSalvaComplementoEtiquetas;
    procedure pLimpaImagem;
    procedure pCarregaImagem;

    procedure pTravaPrecos;
    procedure pCarregaLayOrdInd;
    procedure pSalvaLayOrdInd;

    procedure pUnidadeFracionada;
    function fVerificaUnidadeComEmbalagemFechada: Boolean;
    procedure pHintCampoAplicacao;

    Function fCalculaMarkup1(intNumPreVen: integer): Double;
    procedure CarregaDesMaxFaixaQtde(strCodIte, strCodEmp: String);
    procedure CriaClientDesMaxFaixaQtde;
    procedure GravaDesMaxFaixaQtde(strCodIte, strCodEmp: String);
    function ValidaCamposDesMaxFaixaQtde: Boolean;
    procedure OnBuscaReferenciaModelo(const AText: String; var AReferencia: string);
    procedure pExecutaCalculoCFG_BEN_ST();
    function fProdutoxVeiculoPreenchido: Boolean;
    procedure pCarregaProduto;
    procedure pCarregaProdutoDiluente;
    procedure pConsultarGS1CNP(const strCodBar: String);
    procedure pAdicionarImagemGS1CNP(const strImagem: String);
    procedure pHabilitaIntegracaoGS1CNP;
    procedure pSetaAccessTokenGS1CNP;
    procedure pArmazenaUltimaEscolhaStatusProduto(strCodOPE: String; intOpcaoStatus: Integer);
    function fRetornaUltimaEscolhaStatusProduto(strCodOPE: String): Integer;
    procedure pGravaTabelaComissao;
    procedure pVerificaMargemGrupo(strGruLin: string);
    function fUtilizaMatrizLinhaGrupo: Boolean;
    procedure pMontaCdsIteCom;
    procedure pCdsIteComBeforeInsert(Dataset : TDataset);
    procedure pSalvaIteCom;
    procedure pHabilitarControladoPolicia;

  protected
    qryIteGer: TUniQuery;
    strTipoProd : String;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fInativarProduto: Boolean;
    function fTemCfgComPontoDeExposicaoAtivo: Boolean;

    procedure pProximaPagina; override;

    procedure pInicializaIndices; override;
    procedure pLimpaEdits;

    function fProximoCodigo: String; override;

    procedure pOnStateChange; override;
    procedure pOnExit(Sender: TObject); virtual;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pSetaOpcStatusPro(intOpcSta: Integer);
    function  fRetFocoStatusProd: Integer;
    procedure pExcluirFaixasMetragem;

    procedure pHabilitaLojas(blnHabilita: Boolean; blnInclusao: Boolean);

    Procedure pCarregaItemNaTela;
    Procedure pCarregaItemNaTelaParte2;
    procedure pCarregaDadosMemoriaCalculoPrecoMaisImpostoUltCompra(strNumDoc, strEspDoc, strCodEmp, strSerie: String);

  public
    { Public declarations }
    blnConfirma: Boolean;
    blnAtualizarCatAti: Boolean;
    blnGeraCodBar: Boolean;

    objIteBar: TIteBar;

    strCodIteParaCarregar: String;

    blnCatalogo: Boolean;  // VARIAVEL UTILIZADA PELO CATALOGO DE PRECOS - IMPORTAÇÃO

    pInsereItemCatalogo: TInsereItemCatalogo;
    strCodIteExterno: String;
    procedure pIniciaCadastroDeProdutosExterno();
    procedure pCarregaItemCatalogo(strCodEmp,
                                   strDesite,
                                   strCodFab,
                                   strCodFor,
                                   strNomFor: String;
                                   fltPreCom,
                                   fltPreCus,
                                   fltPreVe1,
                                   fltPreVe2,
                                   fltPreVe3,
                                   fltPreVe4,
                                   fltPreVe5,
                                   fltPreVe6,
                                   fltPreVe7,
                                   fltDesf01,
                                   fltDesf02,
                                   fltDesf03,
                                   fltDesf04,
                                   fltDesf05,
                                   fltDesf06,
                                   fltIpiEnt,
                                   fltFreEnt,
                                   fltPerFin,
                                   fltComVar,
                                   fltPesoIt,
                                   fltPesLiq,
                                   fltEmbala: Double;
                                   strCodUni,
                                   strClaIpi,
                                   strCprCen: String;
                                   fltMarbr1,
                                   fltMarbr2,
                                   fltMarbr3,
                                   fltMarbr4,
                                   fltMarbr5,
                                   fltMarbr6,
                                   fltMarbr7,
                                   fltICMEnt,
                                   fltSubFed,
                                   fltICMSai,
                                   fltSubsti,
                                   fltDesAdb,
                                   fltValFre,
                                   fltOutVal,
                                   fltImpFed,
                                   fltDesOpe: Double;
                                   strCodAbf,
                                   strCodMar,
                                   strCodBar,
                                   strBarEmb,
                                   strRefere,
                                   strAplica: String;
                                   blnPreDol: boolean;
                                   fltTCIFcu,
                                   fltTSCust,
                                   fltDePiCo,
                                   fltDeICMS,
                                   fltFatReg: Double);
end;

var
  frmCadProdutos: TfrmCadProdutos;

implementation

uses  Variants, Graphics, untPai, untFuncoesRel, untFuncoesRel2,
      untConsultas, StrUtils, TypesRel, MemoFocus, untFuncoes, untFuncIns,
      untPesqAux, untConstantes, untHerancaItem, untFuncTinta,
      untAltEst, untCadAbreviacaoFiscal, untFuncoesGenerica, untfuncoesSimples,
      untFuncoesDiarias, untCadSfz, untCadGru, untPreAlt, untCadProFoto,
      untFuncIns2, untSelecionaUnidadesCores, untProdutosAcabadosIndustrial,
      untCadPromocoes, untFuncoesAuxiliares, untTConfiguracao, untCadAtributos,
      untITintasDeMaquina, untPreparaGeracaoTE, untAltDes,
      untTypesSistema, untGeraExcel, untPanelCxItem, untPnlDadosItem,
      untMostraEstruturas, untCadTabelaPrecos, untCadCEST, untLogAltCadIte,
      untConfirmaTipoProduto, untIcmsSTParteVenda, untAgregados,
      untFatRequisicaoCompras, untCadProFaixasMetragem, untFuncoesImagem, untSaldoPedidoCompra,
      untProdMargemNegativa, untImagens, untProdutoAcabadoAlteraDados, untReimpressao,
      untRelacSemelhanca,
      untLiberacao, untLiberacaoFactory, untGravaArquivoPasta,
      untIFatEntregaFutura, untTFatEntregaFutura, Contabilidade.Consultas,
      untTipoPermissaoVenda, untDigitaCodigoBarras,
      Produto.GS1CNP.Controller, Produto.GS1CNP.Interfaces.Consulta, untImagemBase64,
      Produto.GS1CNP.Auth, untMensagemExplicativa, untPreAlt_Trigger;
{$R *.dfm}

procedure TfrmCadProdutos.pHabilitaLojas(blnHabilita: Boolean; blnInclusao: Boolean);
Begin
  objLojas.pHabilitaLojas(blnHabilita);

  cxvLojasDTABAL.Options.Editing := blnHabilita And blnInclusao;
  cxvLojasSALBAL.Options.Editing := blnHabilita And blnInclusao;
  cxvLojasML_BAL.Options.Editing := blnHabilita And blnInclusao;
End;

procedure TfrmCadProdutos.btnIncluiAtribClick(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(edtCodAtri.Text)) Then
  Begin
    If fValidaCampos(edtCodAtri, True) Then
      objAtributos.fIncluiAtributo(edtCodAtri.Text);
    edtCodAtri.Clear;
    edtDesAtri.Clear;
    pSetFocus(edtCodAtri);
  End;
end;

procedure TfrmCadProdutos.btnIncluirClick(Sender: TObject);
begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      If blnPreMat Then
      Begin
        fMensagem('', 'Cadastro de Itens permitido somente na Loja Matriz!', ['&Ok']);
        Exit;
      End;


      chkLimpaCamposVeiculo.Checked := True;
      qryIteGer.Close;
      qryIteGer.Open;

      If blnCCDPRM Then
      begin
        If Assigned(FornecedorItemPalett) Then
          FreeAndNil(FornecedorItemPalett);
        FornecedorItemPalett := TFornecedorItemPalett.Create(Self, '');
      End;

      frmManutencaoAbreviacoesLojas.pHabilitaEdicao(True);
      pLimparCampos;
      pLimpaImagem;

      objAtributos.fCarregaAtributos('');

      edtComLiq.Text := '0,00';
      edtCusRea.Text := '0,00';
      blnInsert := True;

      pControlaCampoComposicao;

      edtComLiq.Enabled := True;
      edtCusRea.Enabled := True;




      chkPreDol.Enabled := True;


      dbeSaldos.Clear;

      If blnCatalogo Then
      Begin
        qryIteGer.Open;
        qryTabela.Open;
        {******************************************************************}
        {* OCULTA A DESCRICAO DA FABRICA PARA EXIBIR A DESCRIÇÃO ORIGINAL *}
        {***************************************************************LU*}
        //lblDesFab.Visible   := False;
        //dbeDesFab.Visible   := False;
        pnlDesFab.Visible   := False;

        lblDescOrig.Visible := True;
        edtDescOrig.Visible := True;
        dbeDesSim.Width     := 203;
      End;

      objIteBar.pCarregaDados('');
      objIteMon.pCarregaDados('');
      objLocFis.fCarregaLocalizacoes('', '');

      inherited;
      If blnUsaProCodigo Then
        pHabilitaCodigo(dbeCodIte, dbeCodDep, False)
      Else
        pHabilitaCodigo(dbeCodIte, dbeCodIte, True);

      If qryTabela.RecordCount = 0 Then
      Begin
        qryIteGer.Close;
        qryIteGer.Open;
      End;

      qryIteGer.Insert;

      qryIteGer.FieldByName('ITE_PRAMIN').AsInteger := 0;
      If pnlSuframa.Visible Then
      Begin
        qryIteGer.FieldByName('ITE_CICMDE').AsString := 'S';
        qryIteGer.FieldByName('ITE_CDPIOP').AsString := 'F';
        qryIteGer.FieldByName('ITE_DIDIOP').AsString := 'F';
      End
      Else
      Begin
        qryIteGer.FieldByName('ITE_CICMDE').AsString := 'N';
        qryIteGer.FieldByName('ITE_CDPIOP').AsString := 'N';
        qryIteGer.FieldByName('ITE_DIDIOP').AsString := 'N';
      End;


      pLimpaEdits;
      pHabilitaIcms;
      pMontaTelaEstoque;

      dbeAbfPis.Field.AsString := fCfgSis('PADPIS');
      dbeAbfCof.Field.AsString := fCfgSis('PADCOF');

      frmManutencaoAbreviacoesLojas.pCarrega('', False, dbeAbfPis.Field.AsString, dbeAbfCof.Field.AsString);
      frmManutencaoAbreviacoesLojas.pHabilitaEdicao(True);
      pHabilitaLojas(True, True);

      pIniciaValoresPadrao;
      btnHeranca.Enabled := True;

      If tbsExportaSite.TabVisible Then
      begin
        FPanelDadosECommerce.pCarregaDadosECommerce;
        FPanelDadosECommerce.edtExpB2B.Text := 'S';
        FPanelDadosECommerce.edtCroDoc.Text := 'N';
      end;

      objIteBar.pHabilitaEdicao(True);
      objIteMon.pHabilitaEdicao(True);
      objlocFis.pHabilitaEdicao(True);

      pAjustaFatorPreco(False);

      pCarregaImpostosEmpresa;

      If fCfgSis('ITETBP', VarBoolean) Then
        pCarregaDesMaxTabelaPreco(qryTabela.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

      If fCfgSis('DMVFQV', VarBoolean) Then
        CarregaDesMaxFaixaQtde(qryTabela.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

      pHabilitaReaEnderecamento;

      If blnCatalogo And Assigned(pInsereItemCatalogo) Then
        pInsereItemCatalogo;

      If btnEstrutura.Visible Then
        btnEstrutura.Enabled := qryTabela.Active And fEhOuCompoeEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString).blnEstrutura;

      If btnTabFor.Visible Then
        btnTabFor.Enabled := qryTabela.Active And (not fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString));

      pAjustaDolar;
      pAbreIteEmb;
      pUnidadeFracionada;
      pOnStateChange;

      If pnlSuframa.Visible Then
      Begin
        dbeCICMDE.Text := 'S';
        dbeCDPIOP.Text := 'F';
        dbeDIDIOP.Text := 'F';
      End
      Else
      Begin
        dbeCICMDE.Text := 'N';
        dbeCDPIOP.Text := 'N';
        dbeDIDIOP.Text := 'N';
      End;

      If Assigned(objCadProdutosVeiculoModelo) Then
      Begin

        edtDescMarVei.LimparConteudo;
        edtDescModVei.LimparConteudo;
        mskAnoInicial.Text    := '';
        mskAnoFin.Text        := '';
        edtValvula.Text       := '';
        edtCilindrada.Text    := '';
        edtObservacoes.Text   := '';
        edtPotencia.Text      := '';
        cmbCombustivel.ItemIndex := 0;
        chkLimpaCamposVeiculo.Checked := True;
        objCadProdutosVeiculoModelo.pIniciaProcesso('', '');

      End;

      If pnlLocEqui.Visible Then
      Begin
        dbeReaLoc.Text := 'S';
        dbeTipLoc.Text := 'P';
      End;

      pMontaCdsIteCom;
      objAtributos.pEdita();
      pnlBotoesAtributos.Enabled := True;
      dberspgar.Field.AsString := fCfgSis('RSPGAR');
      If qryIteGer.State <> dsInsert Then
        btnCancela.Click;

      If blnTabPrd Then
      Begin
        If Assigned(objTabelas) Then
          objTabelas.fCarregaPrecos;

        frmTabelasDoItemGrid.cxvTabelas.OptionsData.Editing := True;
        frmTabelasDoItemGrid.cxvTabelas.NavigatorButtons.First.Click;
        frmTabelasDoItem.pHabilitaCampos(True);

        If Assigned(frmTabelasDoItem) Then
        Begin
          frmTabelasDoItem.cxvPrecos.OptionsData.Editing := True;
          frmManutencaoAbreviacoesLojas.cxTblAbrev.OptionsData.Editing := True;
        End;
      End;

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

  If qryIteGer.State = dsInsert Then
    lkpPermissaoVenda.Field.AsString := TTipoPermissaoVenda.tpvTodos.Registro.strValue;
end;

procedure TfrmCadProdutos.pLimpaImagem;
begin
  imgPro.Picture := Nil;
  imgPro.Visible := False;
  lblErrImg.Visible := False;
end;


procedure TfrmCadProdutos.pLimpaInfPallets;
begin
  FornecedorItemPalettRecord.pIniciaVariaveis;
  edtCodForPal.Clear;
  edtDesForPal.Clear;
  edtQtdItePal.Clear;
  edtValPalet.Clear;
end;

procedure TfrmCadProdutos.btnMaisInfoClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      mnuPromocoes.Enabled := (dtsIteGer.State in [dsBrowse]) And (Not fEmptyStr(dbeCodIte.Text));

      mnuEmprestimos.Enabled := Not fEmptyStr(dbeCodIte.Text);

      mnuProdutosAcabados.Enabled := (fCfgSis('UTIIND', varBoolean) And // utiliza modulo industrial
                                     (Not qryTabela.IsEmpty) And
                                     (qryTabela.FieldByName('ITE_CODDEP').AsString = fRetTipoDepartamento(qryTabela.FieldByName('ITE_CODDEP').AsString, 'PROGRA')));  //Departamento a granel

      popMaisInfo.Popup(Self.Left + btnMaisInfo.Left, Self.Top + pnlBotoes.Top);

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmCadProdutos.btnMemCalcPrecoImpEmbClick(Sender: TObject);
begin
  inherited;

  If Not(fEmptyStr(strMemPrecoUltCompraImp)) Then
  Begin

    Try
      pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
      frmMensagemExplicativa.Caption := 'Memoria de Cálculo do Preço + Imposto Embalagem';
      frmMensagemExplicativa.Width   := 800;
      frmMensagemExplicativa.Height  := 450;
      frmMensagemExplicativa.RitchObservacao.Visible:= True;
      frmMensagemExplicativa.RitchObservacao.BringToFront;
      frmMensagemExplicativa.RitchObservacao.Lines.Add(strMemPrecoUltCompraImp);
      frmMensagemExplicativa.ShowModal;
      frmMensagemExplicativa.RitchObservacao.SendToBack;
    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;

  End;

end;

procedure TfrmCadProdutos.pCarregaDadosMemoriaCalculoPrecoMaisImpostoUltCompra(strNumDoc, strEspDoc, strCodEmp, strSerie: String);
Const
  strSQL = 'SELECT MOVDET.DET_VALIPI, '+
          '        MOVDET.DET_VAEIPI, '+
          '        MOVTRI.DET_ALQCOF, '+
          '        MOVTRI.DET_VALCOF, '+
          '        MOVDET.DET_TOTITE, '+
          '        MOVDET.DET_VALIPI, '+
          '        MOVDET.DET_VAEIPI, '+
          '        DET_ALQPIS,        '+
          '        DET_DESESP,        '+
          '        DET_TOTFRE,        '+
          '        DET_CONFRE,        '+
          '        DET_OUTDES,        '+
          '        DET_VENDOR,        '+
          '        DET_DESACE,        '+
          '        DET_VALICM,        '+
          '        DET_ICMANT,        '+
          '        DET_VAFRAN,        '+
          '        DET_VLGNRE,        '+
          '        DET_VALRET,        '+
          '        DET_VAERET,        '+
          '        DET_VFCPST         '+
          'FROM MOVDET                '+
          'JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM '+
          'WHERE DET_CODEMP = :CODEMP AND DET_NUMDOC = :NUMDOC AND DET_ESPDOC = :ESPDOC AND DET_SERIE_ = :SERIE_';
begin

  qryMemoriaCalculo.Close;
  qryMemoriaCalculo.SQL.Clear;
  qryMemoriaCalculo.SQL.Add(strSQL);
  qryMemoriaCalculo.ParamByName('NUMDOC').AsString:= strNumDoc;
  qryMemoriaCalculo.ParamByName('ESPDOC').AsString:= strEspDoc;
  qryMemoriaCalculo.ParamByName('CODEMP').AsString:= strCodEmp;
  qryMemoriaCalculo.ParamByName('SERIE_').AsString:= strSerie;

  qryMemoriaCalculo.Open;

end;

procedure TfrmCadProdutos.btnMemCalcPrecoImpostosClick(Sender: TObject);

    function fRetornaTextoMemoriaDeCalculo: String;
    Var
      fltTotalItem,
      fltDescontoEspecial,
      fltAliquotaPis,
      fltAliquotaCofins,
      fltValorIpi,
      fltValorIpiNaoCreditado,
      fltFrete,
      fltConhecimentoFrete,
      fltOutrasDespesas,
      fltVendor,
      fltDespesaAcessoria,
      fltValorIcmsAntecipado,
      fltValorIcmsAntecipadoFrete,
      fltValorGNRE,
      fltValorRetido,
      fltValorRetidoNaoCreditado,
      fltValorFundoCombateAPobreza,
      fltValorIcms: Double;
    Begin

      fltTotalItem                 := qryMemoriaCalculo.FieldByName('DET_TOTITE').AsFloat;
      fltDescontoEspecial          := qryMemoriaCalculo.FieldByName('DET_DESESP').AsFloat;
      fltAliquotaPis               := qryMemoriaCalculo.FieldByName('DET_ALQPIS').AsFloat;
      fltAliquotaCofins            := qryMemoriaCalculo.FieldByName('DET_ALQCOF').AsFloat;
      fltValorIpi                  := qryMemoriaCalculo.FieldByName('DET_VALIPI').AsFloat;
      fltValorIpiNaoCreditado      := qryMemoriaCalculo.FieldByName('DET_VAEIPI').AsFloat;
      fltFrete                     := qryMemoriaCalculo.FieldByName('DET_TOTFRE').AsFloat;
      fltConhecimentoFrete         := qryMemoriaCalculo.FieldByName('DET_CONFRE').AsFloat;
      fltOutrasDespesas            := qryMemoriaCalculo.FieldByName('DET_OUTDES').AsFloat;
      fltVendor                    := qryMemoriaCalculo.FieldByName('DET_VENDOR').AsFloat;
      fltDespesaAcessoria          := qryMemoriaCalculo.FieldByName('DET_DESACE').AsFloat;
      fltValorIcmsAntecipado       := qryMemoriaCalculo.FieldByName('DET_ICMANT').AsFloat;
      fltValorIcmsAntecipadoFrete  := qryMemoriaCalculo.FieldByName('DET_VAFRAN').AsFloat;
      fltValorGNRE                 := qryMemoriaCalculo.FieldByName('DET_VLGNRE').AsFloat;
      fltValorRetido               := qryMemoriaCalculo.FieldByName('DET_VALRET').AsFloat;
      fltValorRetidoNaoCreditado   := qryMemoriaCalculo.FieldByName('DET_VAERET').AsFloat;
      fltValorFundoCombateAPobreza := qryMemoriaCalculo.FieldByName('DET_VFCPST').AsFloat;
      fltValorIcms                 := qryMemoriaCalculo.FieldByName('DET_VALICM').AsFloat;

      Result:= Result + 'Preço + Impostos: '+ #$A;
      Result:= Result + '( (Total do Item('+fFormataValor(fltTotalItem, '#,##0.00')+')' + #$A;
      Result:= Result + '                 - ' +'Desconto Especial('+fFormataValor(fltDescontoEspecial, '#,##0.00')+')'+')'+#$A;
      Result:= Result + '                 * ' +'(1 - (Aliquota de PIS('+fFormataValor(fltAliquotaPis, '#,##0.00')+')'+#$A;
      Result:= Result + '                       + ' +'Aliquota COFINS('+fFormataValor(fltAliquotaCofins, '#,##0.00')+')/100) '+#$A;
      Result:= Result + '                 + Valor do IPI('+fFormataValor(fltValorIpi, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + IPI não Creditado('+fFormataValor(fltValorIpiNaoCreditado, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor do Frete('+fFormataValor(fltFrete, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor do Conhec. Frete('+fFormataValor(fltConhecimentoFrete, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor de Outras Desp.('+fFormataValor(fltOutrasDespesas, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor Vendor('+fFormataValor(fltVendor, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor das Descepesas Acess.('+fFormataValor(fltDespesaAcessoria, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor do ICMS Antec.('+fFormataValor(fltValorIcmsAntecipado, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor Antec. Frete('+fFormataValor(fltValorIcmsAntecipadoFrete, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor da GNRE('+fFormataValor(fltValorGNRE, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor Retido('+fFormataValor(fltValorRetido, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor Retido não Cred.('+fFormataValor(fltValorRetidoNaoCreditado, '#,##0.00')+') '+#$A;
      Result:= Result + '                 + Valor do FCP('+fFormataValor(fltValorFundoCombateAPobreza, '#,##0.00')+') '+#$A;
      Result:= Result + '                 - Valor do ICMS('+fFormataValor(fltValorIcms, '#,##0.00')+') )'+#$A;

      If qryTabela.FieldByName('ITE_EMBALA').AsFloat > 0 Then
      Begin
        Result:= Result + 'Preço Unitário: ('+edtPreImpUltEmb.Text +' / '+ fFormataValor(qryTabela.FieldByName('ITE_EMBALA').AsFloat, '#,##0.00')+') '+#$A;
        Result:= Result + '              = '+edtImpUlt.Text;
      End
      Else
      Begin
        Result:= Result + 'Preço Unitário: ('+edtImpUlt.Text+')';
      End;


    End;

begin
  inherited;

    If qryMemoriaCalculo.RecordCount > 0 Then
    Begin
      Try
        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Memoria de Cálculo do Preço + Impostos';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 550;
        frmMensagemExplicativa.RitchObservacao.Visible:= True;
        frmMensagemExplicativa.RitchObservacao.BringToFront;
        frmMensagemExplicativa.RitchObservacao.Lines.Add(fRetornaTextoMemoriaDeCalculo);
        frmMensagemExplicativa.ShowModal;
      Finally
        pFreeAndNil(frmMensagemExplicativa);
      End;

    End;

end;


procedure TfrmCadProdutos.btnMemCalcPrecoMedioClick(Sender: TObject);
Var
  qryMemoriaCalculoPrecoMedio: TUniQuery;
begin
  inherited;

  qryMemoriaCalculoPrecoMedio:= fCriaQuery();
  Try
    qryMemoriaCalculoPrecoMedio.Close;
    qryMemoriaCalculoPrecoMedio.SQL.Clear;
    qryMemoriaCalculoPrecoMedio.SQL.Add('SELECT ITE_MECALC FROM PREMED ');
    qryMemoriaCalculoPrecoMedio.SQL.Add('WHERE ITE_CODITE = :CODITE ');
    qryMemoriaCalculoPrecoMedio.SQL.Add('  AND ITE_CODEMP = :CODEMP ');
    qryMemoriaCalculoPrecoMedio.SQL.Add('    ORDER BY AUTOINCREM DESC');

    qryMemoriaCalculoPrecoMedio.ParamByName('CODITE').AsString:= qryTabela.FieldByName('ITE_CODITE').AsString;
    qryMemoriaCalculoPrecoMedio.ParamByName('CODEMP').AsString:= VS_strCodEmp;

    qryMemoriaCalculoPrecoMedio.Open;

    Try

      If Not(fEmptyStr(qryMemoriaCalculoPrecoMedio.FieldByName('ITE_MECALC').AsString)) Then
      Begin

        qryMemoriaCalculo.First;

        pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
        frmMensagemExplicativa.Caption := 'Memoria de Cálculo do Preço Médio';
        frmMensagemExplicativa.Width   := 800;
        frmMensagemExplicativa.Height  := 450;
        frmMensagemExplicativa.RitchObservacao.Visible:= True;
        frmMensagemExplicativa.RitchObservacao.BringToFront;
        frmMensagemExplicativa.RitchObservacao.Lines.Add(qryMemoriaCalculoPrecoMedio.FieldByName('ITE_MECALC').AsString);
        frmMensagemExplicativa.ShowModal;
        frmMensagemExplicativa.RitchObservacao.SendToBack;

      End;

    Finally
      pFreeAndNil(frmMensagemExplicativa);
    End;
  Finally
    FreeAndNil(qryMemoriaCalculoPrecoMedio);
  End;


end;


procedure TfrmCadProdutos.pCarregaImpostosEmpresa;
  Var
    qryCadEmp: TUniQuery;
Begin
  qryCadEmp := fCriaQuery(Self);

  With qryCadEmp, SQL Do
  Begin
    Clear;

    Add('SELECT');
    Add('  EMP_TABPAD, ');
    Add('  EMP_MARPAD, ');
    Add('  EMP_ICMENT, ');
    Add('  EMP_SUBFED, ');
    Add('  EMP_ICMSAI, ');
    Add('  EMP_IMPFED, ');
    Add('  EMP_DESOPE  ');
    Add('FROM');
    Add('  CADEMP');
    Add('WHERE');
    Add('  EMP_CODEMP = :CODEMP');

    ParamByName('CODEMP').AsString := VS_strCodEmp;

    Open;

    qryIteger.FieldByName('ITE_ICMENT').AsFloat := FieldByName('EMP_ICMENT').AsFloat;
    qryIteGer.FieldByName('ITE_SUBFED').AsFloat := FieldByName('EMP_SUBFED').AsFloat;
    qryIteGer.FieldByName('ITE_ICMSAI').AsFloat := FieldByName('EMP_ICMSAI').AsFloat;
    qryIteGer.FieldByName('ITE_IMPFED').AsFloat := FieldByName('EMP_IMPFED').AsFloat;
    qryIteGer.FieldByName('ITE_DESOPE').AsFloat := FieldByName('EMP_DESOPE').AsFloat;

    If fValidaEscala(FieldByName('EMP_TABPAD').AsString,  1 , Length(VS_strTabPrc)) Then
      qryIteGer.FieldByName('ITE_MARBR' + FieldByName('EMP_TABPAD').AsString).AsFloat := FieldByName('EMP_MARPAD').AsFloat;

    Close;
  End;

  FreeAndNil(qryCadEmp);
End;

procedure TfrmCadProdutos.pMostraMargemIdeal;
Begin
  blnMarIde := fCfgSis('MARIDE', VarBoolean);

  tbsMargemIdeal.TabVisible := blnMarIde;

  cxgMarId1.Visible := VS_strTabPrc[1] = 'S';
  cxgMarId2.Visible := VS_strTabPrc[2] = 'S';
  cxgMarId3.Visible := VS_strTabPrc[3] = 'S';
  cxgMarId4.Visible := VS_strTabPrc[4] = 'S';
  cxgMarId5.Visible := VS_strTabPrc[5] = 'S';
  cxgMarId6.Visible := VS_strTabPrc[6] = 'S';
  cxgMarId7.Visible := VS_strTabPrc[7] = 'S';
End;

procedure TfrmCadProdutos.pCalculaPrecoVendaIdeal;
Begin
  If Not blnMarIde Then
    Exit;

  edtPreId1.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId1.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb1.Text)));

  edtPreId2.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId2.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb2.Text)));

  edtPreId3.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId3.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb3.Text)));

  edtPreId4.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId4.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb4.Text)));


  edtPreId5.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId5.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb5.Text)));

  edtPreId6.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId6.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb6.Text)));

  edtPreId7.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoVenda(1,
                                   fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                   0,
                                   fStrToFloat(dbeMarId7.Text),
                                   fStrToFloat(dbeIcmSai.Text),
                                   fStrToFloat(dbeImpFed.Text),
                                   fStrToFloat(dbeDesOpe.Text),
                                   fStrToFloat(dbeComTb7.Text)));

End;

function TfrmCadProdutos.fFormataValor(Valor: Double; Format: String): String;
begin
  Result := FormatFloat(Format, StrToFloat(AnsiReplaceStr(FloatToStr(Valor), '.', '')));
end;

procedure TfrmCadProdutos.pCalcularAreaMaxima;
begin
  If (Not fEmptyStr(dbeLaMaVi.Text)) And (Not fEmptyStr(dbeAlMaVi.Text)) Then
    dbeAreMax.Field.Value := FormatFloat('#,#####0.00000',
      fConverterAreaPelaSiglaEmb(fStrToFloat(dbeLaMaVi.Text), fStrToFloat(dbeAlMaVi.Text)))
  Else
    dbeAreMax.Field.Value := '0,00000';
end;

procedure TfrmCadProdutos.pCalcularAreaMinima;
begin
  If (Not fEmptyStr(dbeLarMin.Text)) And (Not fEmptyStr(dbeAltMin.Text)) Then
    dbeAreMin.Field.Value := FormatFloat('#,#####0.00000',
      fConverterAreaPelaSiglaEmb(fStrToFloat(dbeLarMin.Text), fStrToFloat(dbeAltMin.Text)))
  Else
    dbeAreMin.Field.Value := '0,00000';
end;

procedure TfrmCadProdutos.pCalcularAreaSugestao;
begin
  If (Not fEmptyStr(dbeLarVid.Text)) And (Not fEmptyStr(dbeAltVid.Text)) Then
    dbeAreSug.Field.Value := FormatFloat('#,#####0.00000',
      fConverterAreaPelaSiglaEmb(fStrToFloat(dbeLarVid.Text), fStrToFloat(dbeAltVid.Text)))
  Else
    dbeAreSug.Field.Value := '0,00000';
end;

function TfrmCadProdutos.fVerificaMargemUtilizada: Boolean;
var
  fltMarIde,
  fltMargem  : Double;
  intIndex   : Integer;
  arrMensagem: TStringArray;
begin
  Result := True;

  if not blnMarIde then
    Exit;

  SetLength(arrMensagem, 0);
  SetLength(arrMarIdeAlt, 0);

  pAddDados(arrMensagem, '----------------------------------------------------------');
  pAddDados(arrMensagem, 'Tabela            Margem Ideal            Margem Praticada');
  pAddDados(arrMensagem, '----------------------------------------------------------');

  for intIndex := 1 to Length(VS_strTabPrc) do
  begin
    if VS_strTabPrc[intIndex] = 'S' then
    begin
      fltMarIde := fStrToFloat(fDbEditFocus('dbeMarId' + IntToStr(intIndex)).Text);
      fltMargem := fStrToFloat(fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).Text);

      if fFormataFloat(fltMargem, 2) < fFormataFloat(fltMarIde, 2) then
      begin
        SetLength(arrMarIdeAlt, Length(arrMarIdeAlt) + 1);

        arrMarIdeAlt[Length(arrMarIdeAlt) - 1].strTabPrc := IntToStr(intIndex);
        arrMarIdeAlt[Length(arrMarIdeAlt) - 1].fltMarIde := FormatFloat('#,##0.00', fltMarIde) + '%';
        arrMarIdeAlt[Length(arrMarIdeAlt) - 1].fltMargem := FormatFloat('#,##0.00', fltMargem) + '%';

        pAddDados(arrMensagem,
                  fPadL(arrMarIdeAlt[Length(arrMarIdeAlt) - 1].strTabPrc,  6, ' ') + '            ' +
                  fPadL(arrMarIdeAlt[Length(arrMarIdeAlt) - 1].fltMarIde, 12, ' ') + '            ' +
                  fPadL(arrMarIdeAlt[Length(arrMarIdeAlt) - 1].fltMargem, 16, ' '));
      end;
    end;
  end;

  if Length(arrMarIdeAlt) > 0 then
  begin
    if fMensagemTabela('ATENÇÃO!',
                       'Alteração de Margem',
                       arrMensagem,
                       'Produto com margem abaixo do ideal. Deseja continuar?',
                       ['&Sim','&Não'], 2) = 2 then
    begin
      Result := False;
    end;
  end;
end;

procedure TfrmCadProdutos.pCriaPrecosFornecedor;
Begin
  blnTabPrd := fCfgSis('TABPRD', VarBoolean);
  If blnTabPrd Then
  Begin
    objTabelas := TTabelasDoItem.Create(Self, qryIteger, qryTabela);

    pnlPrecos1.Visible := False;
    tbsMargemIdeal.Caption := '&2 - Tabelas de Preço';
    tbsMargemIdeal.TabVisible := True;
    pnlMargemIdeal.Visible := False;

    frmTabelasDoItem := TfrmTabelasDoItemFrame.Create(Self);
    frmTabelasDoItem.objTabelas := objTabelas;
    frmTabelasDoItem.Dock(tbsMargemIdeal, tbsMargemIdeal.BoundsRect);
    frmTabelasDoItem.pInicializaDados(qryTabela, qryIteger);

    frmTabelasDoItemGrid := TfrmTabelasDoItemGrid.Create(Self);
    frmTabelasDoItemGrid.frmPai := Self;
    frmTabelasDoItemGrid.Dock(pnlPrecos, pnlPrecos.BoundsRect);
    frmTabelasDoItemGrid.objTabelas := objTabelas;
    frmTabelasDoItemGrid.pInicializaDados;
  End;
End;

procedure TfrmCadProdutos.pDesabilitaCamposDaTabelaDePreco;
Begin
  dbeRefere.Enabled := False;
  dbeDesFab.Enabled := False;
  dbeCodFab.Enabled := False;
  dbeClaIpi.Enabled := False;
  dbeDiaFor.Enabled := False;
  dbeMultCompra.Enabled := False;
  dbePesoIt.Enabled := False;
  dbeNotEsp.Enabled := False;
  dbeExcIpi.Enabled := False;
  dbeUniCom.Enabled := False;
  dbeCodAbr.Enabled := False;
  dbeAbfPis.Enabled := False;
  dbeAbfIpi.Enabled := False;
  dbeAbfCof.Enabled := False;
  dbeSitPro.Enabled := False;
  dbePrdGru.Enabled := False;
End;

procedure TfrmCadProdutos.FormCreate(Sender: TObject);
  procedure pDesabilitaShapeDiretoAcessoComissao(Shape: TShape; edit: TDBEditFocus);
  Begin
    Shape.Brush.Color := clred;
    Shape.Pen.Color := clRed;
    Shape.ShowHint := True;
    edit.ReadOnly := True;
  End;
const
  SQL_LAYORDIND = ' SELECT SQL_NO_CACHE                                       '+
                  '   LAYITE.LAY_CODITE,                                      '+
                  '   LAYITE.LAY_CODLAY,                                      '+
                  '   LAYETI.LAY_DESCRI                                       '+
                  ' FROM                                                      '+
                  '   LAYITE                                                  '+
                  '    JOIN LAYETI ON (LAYETI.LAY_CODLAY = LAYITE.LAY_CODLAY) '+
                  ' WHERE                                                     '+
                  '   LAY_CODITE = :CODITE                                    '+
                  ' ORDER BY                                                  '+
                  '   LAY_NOMLAY                                              ';
Var
  blnUtiInd: Boolean;
  intTabPre,
  intContador: Integer;
  objConEnt: TControleEntrega;
  objProduto: TProdutos;
begin
  inherited;
  intFocoBotao := 2;
  blnCCDPRM := fCfgSis('CCDPRM', varBoolean) and fUsaRotinaWMS;
  tbsControlePallet.Visible := blnCCDPRM;
  objCalculaVariacaoPreco := TCalculaVariacaoPreco.Create;

  dbeVALDIA.Visible := fUtilzaShelfLife;
  dbeTOLREC.Visible := dbeVALDIA.Visible;
  lblVALDIA.Visible := dbeVALDIA.Visible;
  lblTOLREC.Visible := dbeVALDIA.Visible;

  {Se resolução disponível for inferior à (1024 x 768), maximiza tela!}
  If (Screen.Width < 1024) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS) < 768) Then
  Begin
    Self.Position := poDesigned;
    Self.WindowState := wsMaximized;
  End;

  cxvLojasPONEXP.Visible := fTemCfgComPontoDeExposicaoAtivo;

  objAtributos := TAtributosProduto.Create(cxsColunaFixa, cxsTitulo, cxdAtributos);

  dbeDetUti.DataSource := objAtributos.cdsIteDte.dtsSource;
  dbePatVid.DataSource := objAtributos.cdsIteDte.dtsSource;

  pSetaCodIte( dbeCodIte );
  blnAcaoGravacao := False;
  qryGeneri := fCriaQuery;
  qryCadNcm := fCriaQuery(Self);
  blnMosMar := fCfgSis('MOSMAR', varBoolean);
  qryMemoriaCalculo:= fCriaQuery();


  strPcmPro := fCfgSis('PCMPRO');

  blnPossuiBeneficioFiscal:= (fCfgSis('BENFIS', varBoolean) And fCfgSis('USABEF', varBoolean));

  BeneficioST_Precos.blnCalculou := False;
  blnUtilizaBeneficioST := (fCfgSis('BEN_ST', varBoolean)) And (fCfgSis('CLASUB') = '2');

  strEstadoEmpresa := fCadEmp('ESTADO');

  intConfirma := -1;

  blnCancelando := False;

  blnChangeEnabledButton := False;

  objLockEdicao := TLock.Create;

  strCodIteParaCarregar := '';

  mnuSemelhantes.Visible := fCfgSis('UTISEM', varBoolean);
  pnlImpEtiqRes.visible  := fCfgSis('ETIDIF', varBoolean);

  intSitPro := fCfgSis('SITEMP', varInteger);
  objLojas := TLojasCadIte.Create(Self);
  objLojas.AfterScrollDo := pAjustaGridEstoquePontoExposicao;
  cxvLojas.DataController.DataSource := objLojas.dtsSource;
  TcxLookupComboBoxProperties(cxvLojasEMPCEN.Properties).ListSource := objLojas.dtsCadEmp;
  TcxLookupComboBoxProperties(cxvLojasSITPRO.Properties).ListSource := objLojas.dtsSitPro;
  cxvLojasSITPRO.Visible := fCfgSis('SITPRO', varBoolean) And (intSitPro = 2);
  cxvLojasIMPLIS.Visible := fCfgSis('ILIEMP', varBoolean);
  cxvLojasESMIDG.Visible := Not fCfgSis('ESMILJ', varBoolean);

  cxvLojasAPERET.Visible := fCfgSis('APERET', varBoolean) And (fCfgSis('RETITE') = 'E');
  cxvLojasAPEENT.Visible := fCfgSis('APERET', varBoolean) And (fCfgSis('APNENT') = 'E');

  If Not fCfgSis('APERET', varBoolean) Then
  Begin
    lblApeRet.Visible := False;
    dbeApeRet.Visible := False;
    lblApeEnt.Visible := False;
    dbeApeEnt.Visible := False;
    lblSimNao.Visible := False;
  End;

  cxvLojasMINDIG.Visible := fCfgSis('MINDIG', varBoolean);
  cxvLojasMAXDIG.Visible := cxvLojasMINDIG.Visible;
  cxvLojasPONPED.Visible := cxvLojasMINDIG.Visible;

  blnMarNeg := fCfgSis('MARNEG', varBoolean);

  blnAcessoPrecos := fVerificaAcessoSistema('PREPRO');
  shpAcessoPrecos.Brush.Color := IIf(blnAcessoPrecos, clGreen, clRed);
  pnlPrecos.Visible := blnAcessoPrecos;
  mnuConstrucaodoPreodeCusto.Visible := blnAcessoPrecos;
  cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);

  pnlFicIns.Visible :=  fCfgSis('USACON', varBoolean);
  pnlAbrevContabil.Visible := fCfgSis('UTICON', varBoolean);

  blnRecalcular := True;

 If Not fVerificaAcessoSistema('PEACVI', strLoginUsuarioLogado) Then
   pDesabilitaShapeDiretoAcessoComissao(shpPEACVI, dbeComVar);
 If Not fVerificaAcessoSistema('PEACVE', strLoginUsuarioLogado) Then
   pDesabilitaShapeDiretoAcessoComissao(shpPEACVE, dbeComAta);
 If Not fVerificaAcessoSistema('PEACVD', strLoginUsuarioLogado) Then
   pDesabilitaShapeDiretoAcessoComissao(shpPEACVD, dbeComDis);

  intPreWidth := dbePreVe1.Width;
  strMarMkp := fCfgSis('MARMKP');

  btnEstrutura.Visible := (fCfgSis('CADEST',varString) = 'S') And (fCfgSis('UTIIND',varString) = 'N');
  btnTabFor.Visible    := (fCfgSis('CADEST',varString) = 'S') And (fCfgSis('UTIIND',varString) = 'N');

  qryGirIte := TZClient.Create(Self);
  stlIteEmbHer := TStringList.Create;

  objLoteRastreamento := TLoteRastreamento.Create;

  dtsLoteRastreamento.DataSet := objLoteRastreamento.qryLoteRastreamento;
  tbsLoteRastreamento.Visible := objLoteRastreamento.blnRastreamentoIndustrial;

  blnURapel := fCfgSis('URAPEL', varBoolean);
  pnlRapel.Visible    := blnURapel;
  lblRapelPer.Visible := blnURapel;
  DBEPRAPEL.Visible   := blnURapel;
  lblRapelDes.Visible := blnURapel;

  edtDesCnd.Visible   := fCfgSis('DESCND', varBoolean);
  lblDesCnd.Visible   := edtDesCnd.Visible;
  lblDesCndSN.Visible := edtDesCnd.Visible;

  pnlConLot.Visible := (fCfgSis('CADEST', varString) = 'S') And (fCfgSis('UTIIND', varString) = 'N');

  cmbItePro.Items.Clear;
  For intContador := Low(TIPO_PRODUTO_SPED) To High(TIPO_PRODUTO_SPED) Do
  Begin
    cmbItePro.Items.Add(TIPO_PRODUTO_SPED[intContador][0] + ' - ' + TIPO_PRODUTO_SPED[intContador][1]);
  End;
  cmbItePro.ItemIndex := 0;

  objSender := Nil;
  frmGravando := Nil;
  frmGravandoGirIte := Nil;

  intDecUni := fCfgSis('DECUNI', varInteger);
  If intDecUni > fTamPrecoIteger Then
    intDecUni := 4;

  blnCadLoc := fCfgSis('CADLOC', varBoolean);
  blnInfMat := fCfgSis('INFMAT', varBoolean);

  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  intVenMar := fCfgSis('VENMAR', varInteger);

  lstTintas := TStringList.Create;

  blnUsaTabPrF := fCfgSis('TABPRF', varBoolean);

  objCadLot := TCadLot.Create(Self);

  blnAtualizarCatAti := FALSE;
  blnAtualizouUV     := False;
  blnAtualizouUC     := False;

  {***********************************}
  {* QRY DINÂMICA PARA TABELA ITEGER *}
  {********************************JB*}
  qryGenIte := fCriaQuery(Self);
  qryCadSfz := fCriaQuery(Self);

  {*******************************************}
  {* VERIFICA ENTREGAS DO SISTEMA            *}
  {****************************************MV*}
  If (fCfgSis('CONENT', varBoolean)) And
     (fCfgSis('TIPSAB') = 'M')       Then //TIPO DE ABASTECIMENTO = MANUAL
  Begin
    objConEnt := TControleEntrega.Create(nil);
    objConEnt.pVerificaEntregas;
    FreeAndNil(objConEnt);
  End;

  {*****************************************}
  { INSTÂNCIA A QRY E O DTS                *}
  { UTILIZADOS P\ GRID LOCALIZAÇÃO ARMAZÉM *}
  {**************************************MM*}
  If (pnlAmz.Visible) Then
  Begin
    Try
      qryLotAmz  := fCriaQuery;

      dtsLotAmz  := fCriaDataSource(qryLotAmz);

      dbgLotAmz.DataSource := dtsLotAmz;
    Except
      FreeAndNil(qryLotAmz);
      FreeAndNil(dtsLotAmz);
    End;
  End;

  {************************************************}
  { INSTÂNCIA AS QRY E OS DTS                     *}
  { UTILIZADOS P\ GRID ULT. VENDAS E COMPRAS      *}
  {*********************************************JB*}
  Try
    qryUltVendas  := fCriaQuery;
    qryUltCompras := fCriaQuery;

    dtsUltVendas  := fCriaDataSource(qryUltVendas);
    dtsUltCompras := fCriaDataSource(qryUltCompras);

    dbgVendas.DataSource  := dtsUltVendas;
    dbgCompras.DataSource := dtsUltCompras;

  Except
    FreeAndNil(qryUltVendas);
    FreeAndNil(qryUltCompras);
    FreeAndNil(dtsUltVendas);
    FreeAndNil(dtsUltCompras);
  End;

  {****************************************************************}
  {* CRIA E INSTANCIA OBJETOS UTILIZADOS NA TELA 7 - FORNECEDORES *}
  {*************************************************************LU*}
  cdsFornecedor := TUniClientDataSet.Create(Self);
  dtsFornecedor := fCriaDataSource(cdsFornecedor);
  dbgFornecedor.DataSource := dtsFornecedor;

  {**************************************************************************************}
  {* CRIA E INSTANCIA OBJETOS UTILIZADOS PARA LAYOUT INDUSTRIAL - ABA PRODUTOS ACABADOS *}
  {**************************************************************************************}
  cdsLayOrdInd := TZClient.Create(Self, SQL_LAYORDIND);
  cxgLayOrdIndTV.DataController.DataSource := cdsLayOrdInd.dtsSource;

  cdsDesMaxTabPre := TUniClientDataSet.Create(Self);
  dtsDesMaxTabPre := fCriaDataSource(cdsDesMaxTabPre);
  cxgDesMaxTabPreeView.DataController.DataSource := dtsDesMaxTabPre;
  pCriaClientDesMaxTabPre;

  FcdsDesMaxFaixaQtde := TUniClientDataSet.Create(Self);
  FdtsDesMaxFaixaQtde := fCriaDataSource(FcdsDesMaxFaixaQtde);
  cxgDesMaxFaixaQtdeTreeView.DataController.DataSource := FdtsDesMaxFaixaQtde;
  CriaClientDesMaxFaixaQtde;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodIte;

  pCarregaMarcasBases;

  If (fCfgSis('GARANT', varBoolean)) Then
    pnlGarant.Visible := True;
//  Begin
//    lblGarant.Visible := True;
//    dbeGarant.Visible := True;
//  End;

  lblMesGir.Visible := fCfgSis('ATICOM', varBoolean);
  dbeMesGir.Visible := lblMesGir.Visible;

  If fCfgSis('TAMDNF', varInteger) > 0 Then
  Begin
    lblSeta.Visible := True;
    Label3.Top      := Label3.Top - 7;
    dbeCodGru.Top   := dbeCodGru.Top - 7;
    edtLinGru.Top   := edtLinGru.Top - 7;

    lblCodDep.Top   := lblCodDep.Top - 7;
    dbeCodDep.Top   := dbeCodDep.Top - 7;
    edtDesDep.Top   := edtDesDep.Top - 7;

    lblRefePonteiro.Caption := fReplicatorStr('X', fCfgSis('TAMDNF', varInteger));
    lblSeta.Left            := lblRefePonteiro.Left + lblRefePonteiro.Width;
  End;

  pMostraMargemIdeal;
  If Not IIF(fCfgSis('BALANC', varBoolean), True, False) Then
  Begin
//    tbsDadosBalanca.PageIndex := pgcDados.PageCount -1;
    tbsDadosBalanca.TabVisible := False;
  End;

  If fCfgSis('MOEXSI') = '0' Then
  Begin
//    tbsExportaSite.PageIndex := pgcDados.PageCount -1;
    tbsExportaSite.TabVisible := False;
  End;

  If Not fCfgSis('CADMON', varBoolean) Then
  Begin
//    tbsMontadoras.PageIndex := pgcDados.PageCount -1;
    tbsMontadoras.TabVisible := False;
  End;

  If Not fCfgSis('ITETBP', VarBoolean) Then
  Begin
//    tbsDesMaxTBP.PageIndex := pgcDados.PageCount -1;
    tbsDesMaxTBP.TabVisible := False;
  End;

  If Not fCfgSis('DMVFQV', VarBoolean) Then
  Begin
    tbsDesMaxFaixaQtde.TabVisible := False;
  End;

  If blnUsaTabPrF Then
  Begin
//    tbsFornecedores.PageIndex := pgcDados.PageCount -1;
    tbsFornecedores.TabVisible := False;
  End;

  If Not fCfgSis('UTIIND', varBoolean) Then
  Begin
//    tbsProdAcab.PageIndex := pgcDados.PageCount -1;
    tbsProdAcab.TabVisible := False;
  End;

  If Not fUtilizaAutoAtendimento Then
  Begin
//    tbsAtributos.PageIndex := pgcDados.PageCount -1;
    tbsAtributos.TabVisible := False;
  End;

  objProduto:= TProdutos.Create;
  Try
    objProduto.blnCfgUsaComponente:= fCfgSis('ULTCMP', varBoolean);

    If objProduto.blnCfgUsaComponente Then
      pnlComponente.Visible  := True
    else
    pnlComponente.Visible  := False;

  Finally
    FreeAndNil(objProduto);
  End;

  tbsproduto_veiculo.TabVisible := False;
  If fCfgSis('PROVEI', varBoolean) Then
  Begin
    objCadProdutosVeiculoModelo := TCadProdutosVeiculoModelo.Create;
    cxVeiculoProdutoView.DataController.DataSource := objCadProdutosVeiculoModelo.DataSource;
    cmbCombustivel.Items.Text := objCadProdutosVeiculoModelo.fRetListaCombustivel;
    tbsproduto_veiculo.TabVisible := True;
    edtDescModVei.TextEmpty := '"/" para buscar modelo ou digite o modelo desejado.';
    edtDescMarVei.TextEmpty := '"/" para buscar marca ou digite a marca desejada.';

    edtDescModVei.strTabela := 'MODVEI';
    edtDescModVei.strCampo :=  'MOD_DESMOD';
    edtDescModVei.strCampoReferencia := 'MOD_CODMOD';
    edtDescModVei.OnBuscaReferencia := OnBuscaReferenciaModelo;

    edtDescMarVei.strTabela := 'MARVEI';
    edtDescMarVei.strCampo := 'MAR_DESMAR';
    edtDescMarVei.strCampoReferencia := 'MAR_CODMAR';
  End;

  If fCfgSis('TCOPRO') = '4' Then
    lblQtPPro.Caption := 'Pontos por Valor:';

  If Pos(fCfgSis('TCOPRO'), '3_4_') <= 0 Then
    pEscondeQtdPontosProfissional;

  tbsPrecos.TabVisible := fVerificaAcessoSistema('TABPRC');

  pAtribuiTags;

  blnCatalogo := False;

  If Not fCfgSis('IMPDIR', varBoolean) Then
    pnlImpDir.Visible  := False;
//  Begin
//    lblImpDir.Visible  := False;
//    dbeImpDir.Visible  := False;
//    lblcImpDir.Visible := False;
//  End;

  If (fCfgSis('PESLIQ') <> 'SOMA') Then
  Begin
    lblPesLiq.Visible  := False;
    dbePesLiq.Visible  := False;
  End;

  {*****************************************}
  {* CASO A ABREVIAÇÃO SEJA INDIVIDUAL,    *}
  {* ALTERA O CAMPO PARA O ITEGER.         *}
  {**************************************MV*}
  If fCfgSis('TIPABF') = '2' Then
  Begin
    dbeCodAbr.DataSource := dtsIteGer;
  End;

  If fCfgSis('TPABPC') = '2' Then
  Begin
    dbeAbfPis.DataSource := dtsIteGer;
    dbeAbfCof.DataSource := dtsIteGer;
    dbeAbfIpi.DataSource := dtsIteGer;
  End;

  {************************************************}
  {* CASO A IMPORTACAO DIRETA SEJA INDIVIDUAL,    *}
  {* ALTERA O CAMPO PARA O ITEGER.                *}
  {*********************************************MV*}
  If fCfgSis('IMPDIG') = '2' Then
  Begin
    dbeImpDir.DataSource := dtsIteGer;
  End;

  If fCfgSis('INDREV') = '2' Then
  Begin
    dbeIndRev.DataSource := dtsIteGer;
  End;

  If fCfgSis('LIMBRI') = 'N' Then
  Begin
    lblMaxBri.Visible := False;
    dbeMaxBri.Visible := False;
  End;

  if fCfgSis('CNVEMB') = 'N' then
  begin
    lblUniCom.Visible := False;
    dbeUniCom.Visible := False;
    edtDesUniCom.Visible := False;
  end;

  If fCfgSis('UNITRI') = 'N' Then
  Begin
    lblFatUTr.Visible := False;
    dbeFatUTr.Visible := False;

    lblUniTri.Visible := False;
    dbeUniTri.Visible := False;
    edtDesUniTri.Visible := False;
  End;

  if fCfgSis('NFEPEP', varBoolean) then
    dbeObrNFE.DataSource := dtsIteGer
  else
    dbeObrNFE.DataSource := dtsCadIte;

  objFatPre := Nil;
  blnFatPre := fCfgSis('FATPRE', varBoolean);

  If blnFatPre Then
    objFatPre := TFatorPreco.Create;

  {************************************************}
  {* SÓ MOSTRA A DESCRIÇÃO SIMPLIFICADA SE        *}
  {* A CONFIGURAÇÃO "CFG_IDSORC" FOR "S" OU "P".  *}
  {*********************************************RV*}
  If fCfgSis('IDSORC', varString) = 'N' Then
  Begin
    lblDesSim.Visible := False;
    dbeDesSim.Visible := False;
    lblDescOrig.Left  := lblDesSim.Left;
    lblDescOrig.Width := lblDesSim.Width;
    edtDescOrig.Left  := dbeDesSim.Left;
    edtDescOrig.Width := dbeDesIte.Width;
  End;

  If tbsExportaSite.TabVisible Then
    pCriafrmPanelDadosECommerce;

  pAjustaFatorPreco(True);

  objIteBar := TIteBar.Create(opcCadastro,
                              qryTabela,
                              dbeCodBar,
                              dbeBarEmb,
                              dbeEmbalagem,
                              tbsEmbalagens);

  objIteBar.pHabilitaCamposIntegracaoGS1CNP;

  objIteMon := TCadIteMontadoras.Create(Self, tbsMontadoras);

  objLocFis := TLocFisAdicionais.Create(Self, pnlLocFis);
  objComplementoEtiquetas := TComplementoEtiquetasProd.Create;

  pnlSitPro.Visible := fCfgSis('SITPRO', varBoolean) And (intSitPro = 1);
  blnUtiInd := fCfgSis('UTIIND', varBoolean);
  pnlDensid.Visible := blnUtiInd Or (MatchStr(fCfgSis('MLAYOP', varString), ['5','6']));
  pCarregaLabelComplementoEtiquetas;

  cdsIteEmb := TZClient.Create(Self, fGetSQLIteEmb);
  cxgIteEmbTableView.DataController.DataSource := cdsIteEmb.dtsSource;

//  dbePraVal.Visible := blnUtiInd;
//  lblPraVal.Visible := blnUtiInd;

//  dbeDensid.Visible := blnUtiInd;
//  lblDensid.Visible := blnUtiInd;

//  lblCompos.Visible := blnUtiInd;
//  dbeCodCom.Visible := blnUtiInd;
//  edtDesCom.Visible := blnUtiInd;

  lblLocSep.Visible := ((fCfgSis('GRUSEP', VarString) = 'S') Or (fCfgSis('TPLREC', VarString) = 'L')) and (not fCfgSis('UTLSLF', varBoolean));
  dbeCodLse.Visible := lblLocSep.Visible;
  edtDesLse.Visible := lblLocSep.Visible;

  If Not dbeCodLse.Visible Then
    pnlLoc.Height := pnlLoc.Height - dbeCodLse.Height;

  chkPreDol.Checked := False;
  chkPreDol.Visible := fCfgSis('COTDOR', varBoolean);

  lblCotMoe.Visible := chkPreDol.Visible;
  edtCotMoe.Visible := chkPreDol.Visible;

  blnSergipe        := (fCadEmp('ESTADO') = 'SE');
  pnlCodDic.Visible := blnSergipe;

  lblRastre.Visible   := fUsaRotinaWMS;
  dbeRastre.Visible   := lblRastre.Visible;
  lblRastreSN.Visible := lblRastre.Visible;

  dbeComDig.Visible := fCfgSis('USADIG', varBoolean);
  lblComDig.Visible := dbeComDig.Visible;
  lblComDigPer.Visible := dbeComDig.Visible;

  If not dbeRastre.Visible Then
    pnlDadosEntrada2.Height := pnlDadosEntrada2.Height - dbeRastre.Height;

  {*******************}
  {* Chama cadastros *}
  {****************GB*}
  dbeClaIpi.OnChamaCadastro := TFuncIns.fChamaCadNcm;
  dbeCodDep.OnChamaCadastro := TFuncIns.fChamaCadDep;
  dbeCodGpr.OnChamaCadastro := TFuncIns.fChamaCadGrupoPrecos;
  dbePrdGru.OnChamaCadastro := TFuncIns.fChamaCadGrupoProdutos;
  dbeAbfPis.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoPIS;
  dbeAbfIpi.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoIPI;
  dbeAbfCof.OnChamaCadastro := TFuncIns.fChamaCadAbreviacaoCOFINS;
  dbeCodOnu.OnChamaCadastro := TFuncIns.fChamaCadClassificacaoOnu;
  dbeGruCmp.OnChamaCadastro := TFuncIns.fChamaCadGruCompra;

  lblGarFil.Visible      := fUsaRotinaGarantiaItensPesados;
  dbeGarFil.Visible      := fUsaRotinaGarantiaItensPesados;
  lblGarFilAviso.Visible := fUsaRotinaGarantiaItensPesados;
  lblGarFilColor.Visible := fUsaRotinaGarantiaItensPesados;

  lblUtiAmp.Visible := (fCfgSis('UTIAMP', varBoolean));
  lblUtiAmp_S_N.Visible := lblUtiAmp.Visible;
  dbeUtiAmp.Visible := lblUtiAmp.Visible;

  gpbMetVid.Visible := fCfgSis('VENVID', varBoolean);

  If Pos(strMarMkp, '1_5_') = 0 Then
  Begin
    For intTabPre := 1 To Length(VS_strTabPrc) Do
      If Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre)) <> Nil Then
        TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Caption := 'Markup:';
  End;

  pnlClaOnu.Visible := ( fCfgSis( 'CLAONU', varBoolean ) );

  edtDesFec.EditFormat:= fMskDigitos(4);
  lblPrinCalcRom.Visible := fCfgSis('VOLROM', varInteger) = 2;
  cmbPriRom.Visible := fCfgSis('VOLROM', varInteger) = 2;
  cxgIteEmbTableViewPRIROM.Visible := fCfgSis('VOLROM', varInteger) = 2;
  If Not cmbPriRom.Visible Then
  Begin
    btnAdicionaIteEmb.Left := btnAdicionaIteEmb.Left - lblPrinCalcRom.Width;
    btnCancelaIteEmb.Left  := btnCancelaIteEmb.Left  - lblPrinCalcRom.Width;
  End;

  blnUsaFle := fCfgSis('USAFLE', varBoolean);
  lblUsaFle.Visible := blnUsaFle;
  dbeUsaFle.Visible := blnUsaFle;
  lblUsaFle_S_N.Visible := blnUsaFle;

  SetLength(arrIteEmbDel, 0);

  SetLength(arrMarIdeAlt, 0);

  If Not fCfgSis('LOTPRE', varBoolean) Then
  Begin
    fFindColumnByName(dbgCompras, 'PRECOM').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF01').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF02').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF03').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF04').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF05').Visible := False;
    fFindColumnByName(dbgCompras, 'DESF06').Visible := False;
    fFindColumnByName(dbgCompras, 'COMLIQ').Visible := False;
    fFindColumnByName(dbgCompras, 'ICMENT').Visible := False;
    fFindColumnByName(dbgCompras, 'SUBFED').Visible := False;
    fFindColumnByName(dbgCompras, 'IPIENT').Visible := False;
    fFindColumnByName(dbgCompras, 'FREENT').Visible := False;
    fFindColumnByName(dbgCompras, 'VALFRE').Visible := False;
    fFindColumnByName(dbgCompras, 'ACRFIN').Visible := False;
    fFindColumnByName(dbgCompras, 'SUBSTI').Visible := False;
    fFindColumnByName(dbgCompras, 'DESADB').Visible := False;
    fFindColumnByName(dbgCompras, 'PRECUS').Visible := False;
  End;

  pMontaCamGir;

  objCfgGriCompras     := TCfgGrid.Create(Self, dbgCompras,    'Últimas Compras', [64, 85, 25, 25, 60,100, 70, 150,60, 60,
                                                                                   80, 80, 80, 60, 80, 60, 80, 80, 45, 80,
                                                                                   80, 80, 85, 65, 70, 50, 75, 70, 75, 50,
                                                                                   85, 50, 70,100,120,150, 75,100,100,100,
                                                                                   100,100,100,80, 90,100, 80, 60, 80,100,
                                                                                   90, 100,80,150], '', False, False);
  objCfgGriGiroCompras := TCfgGrid.Create(Self, cxbGiroCompras, 'Giro de Estoque - Compras', [250, 64, 64, 64, 64,
                                                                                              64, 64, 64, 64, 64,
                                                                                              64, 64, 64, 90, 90,
                                                                                              90], '', False, False);
  objCfgGriVendas      := TCfgGrid.Create(Self, dbgVendas,     'Últimas Vendas', [], '', False, False);
  objCfgGriGiroVendas  := TCfgGrid.Create(Self, cxbGiroVendas,  'Giro de Estoque - Vendas', [250, 64, 64, 64, 64,
                                                                                             64, 64, 64, 64, 64,
                                                                                             64, 64, 64, 64, 90,
                                                                                             90, 90], '', False, False);

  objCfgGriLoteRastreamento := TCfgGrid.Create(Self, cxgLoteRastreamentoTBV,     'Lote de Rastreamento');

  objFaixasMet := nil;

  {Obrigar a definição do lote(WMS) do produto na tela de pedido de venda?}
  lblObrDefLoteWMS.Visible := False;
  dbeObrDefLoteWMS.Visible := False;
  clbObrDefLoteWMS.Visible := False;

  If fCfgSis('UTIWMS', VarBoolean) Then
  Begin
    If fCfgSis('WMSLOT', varBoolean) Then
    Begin
      lblObrDefLoteWMS.Visible := True;
      dbeObrDefLoteWMS.Visible := True;
      clbObrDefLoteWMS.Visible := True;
    End;
  End;

  dbeEmpCar.Visible    := fCfgSis('EMPCAR', varBoolean);
  edtDesEmpCar.Visible := dbeEmpCar.Visible;
  lblEmpCar.Visible    := dbeEmpCar.Visible;

  pTravaPrecos;

  blnUnidadeEFracionada := False;

  blnChangeEnabledButton := True;

  pnlUsaQuest.Visible := fCfgSis('PONQUE', varBoolean);
  pnlConferenciaDemanda.Visible := fUsaRotinaWMS();
  pnlQuestDemanda.Visible := pnlConferenciaDemanda.Visible or pnlUsaQuest.Visible;

  dtsPermissaoVenda.DataSet := TTipoPermissaoVenda.Dataset;

  blnHeranca := False;

  blnValidaLocFis := False;
  pConfiguraPopup(FichaKardex1);
  cdsIteCom := TZClient.Create(Self);
  tbsIteCom.TabVisible := (fCfgSis('OPCCOM', varString) = 'VT');
  pnlEmpSug.Visible := (fCfgSis('EMPFAT', varBoolean) or fCfgSis('EMPFVN', varBoolean));

  pCriaPrecosFornecedor;
end;

procedure TfrmCadProdutos.pTravaPrecos;
  Var
    intIndex: Integer;
Begin
  If fCfgSis('BLOPRE', VarBoolean) Then
  For intIndex := 1 to Length(VS_strTabPrc) do
  Begin
    fDbEditFocus('dbeMarId' + IntToStr(intIndex)).ReadOnly    := True;
    fDbEditFocus('dbeMarId' + IntToStr(intIndex)).TabStop     := False;
    fDbEditFocus('dbeMarId' + IntToStr(intIndex)).Color       := $00FFDFB8;
    fDbEditFocus('dbeMarId' + IntToStr(intIndex)).FocusColor  := $00FFDFB8;
    fDbEditFocus('dbeMarId' + IntToStr(intIndex)).NormalColor := $00FFDFB8;

    fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).ReadOnly    := True;
    fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).TabStop     := False;
    fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).Color       := $00FFDFB8;
    fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).FocusColor  := $00FFDFB8;
    fDbEditFocus('dbeMarBr' + IntToStr(intIndex)).NormalColor := $00FFDFB8;

    fDbEditFocus('dbePreVe' + IntToStr(intIndex)).ReadOnly    := True;
    fDbEditFocus('dbePreVe' + IntToStr(intIndex)).TabStop     := False;
    fDbEditFocus('dbePreVe' + IntToStr(intIndex)).Color       := $00FFDFB8;
    fDbEditFocus('dbePreVe' + IntToStr(intIndex)).NormalColor := $00FFDFB8;
  End;
End;

procedure TfrmCadProdutos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objCalculaVariacaoPreco);
  FreeAndNil(cpcParams);
  FreeAndNil(qryGeneri);
  If Assigned(FornecedorItemPalett) Then
    FreeAndNil(FornecedorItemPalett);
 
  FreeAndNil(cdsIteCom);

  FreeAndNil(objAtributos);

  objLockEdicao.pDestravarTodos;
  FreeAndNil(objLockEdicao);

  FreeAndNil(stlCamGir);
  FreeAndNil(stlCamNom);

  FreeAndNil(stlIteEmbHer);

  If Assigned(objIteBar) Then
    FreeAndNil(objIteBar);

  FreeAndNil(objlocFis);

  If Assigned(objFatPre) Then
    FreeAndNil(objFatPre);

  FreeAndNil(cdsIteEmb);
  FreeAndNil(cdsLayOrdInd);

  SetLength(arrIteEmbDel, 0);

  SetLength(arrMarIdeAlt, 0);

  If (Assigned(objFaixasMet)) Then
    FreeAndNil(objFaixasMet);

  If (Assigned(objCadProdutosVeiculoModelo)) Then
    FreeAndNil(objCadProdutosVeiculoModelo);

  if Assigned(objLoteRastreamento) then
    FreeAndNil(objLoteRastreamento);

  if Assigned(frmManutencaoAbreviacoesLojas) then
    pFreeAndNil(frmManutencaoAbreviacoesLojas);

  FreeAndNil(qryMemoriaCalculo);


  inherited;
end;

procedure TfrmCadProdutos.pAbreQryGir;
  Var
    intIndex : Integer;
begin
  With qryGirIte.qryQuery, Sql Do
  Begin
    Clear;
    Add(fGetSqlGiro);
    ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  End;

  qryGirIte.fAbreClient(True, 'TfrmCadProdutos.pAbreQryGir');

  For intIndex := 0 to qryGirIte.Fields.Count-1 Do
  Begin
    If SameText(qryGirIte.Fields[intIndex].ClassName,'TFloatField') Then
      TFloatField(qryGirIte.Fields[intIndex]).DisplayFormat := '#,##0.00';
  End;

  cxbGiroVendas.DataController.DataSource := qryGirIte.dtsSource;
  cxbGiroCompras.DataController.DataSource := qryGirIte.dtsSource;
end;


procedure TfrmCadProdutos.pAdicionarImagemGS1CNP(const strImagem: String);
begin
  if (fCfgSis('IMGPRO') = 'S') and qryIteGer.Active and (not fEmptystr(strImagem)) then
  begin
    TfrmImagens.pAbrirImagens(tiProduto, qryIteGer.ParamByName('CODITE').AsString, False, strImagem);
    pCarregaImagem;
  end;
end;

procedure TfrmCadProdutos.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('ITE_DTAVAL') <> nil Then
      TDateField(FieldByName('ITE_DTAVAL')).EditMask := '99/99/9999';

    If FindField('ITE_DTALAN') <> nil Then
      TDateField(FieldByName('ITE_DTALAN')).EditMask := '99/99/9999';
  End;
end;

procedure TfrmCadProdutos.pSetaAccessTokenGS1CNP;
begin
  FAccessToken := '';
  FAccessToken := TProdutoGS1CNPAuth.GetAcessToken;
end;

procedure TfrmCadProdutos.pSetaOpcStatusPro(intOpcSta: Integer);
begin
  VS_OpcStaPro := sprTodos;

  If (intOpcSta = 1) Then
    VS_OpcStaPro := sprAtivo
  Else If (intOpcSta = 2) Then
    VS_OpcStaPro := sprInativo;
end;


function TfrmCadProdutos.fRetFocoStatusProd: Integer;
begin
  Result := 3;

  If (VS_OpcStaPro = sprAtivo) Then
    Result := 1
  Else If (VS_OpcStaPro = sprInativo) Then
    Result := 2;
end;

Procedure TfrmCadProdutos.pAjustaFatorPreco(blnDesabilita: Boolean);
Begin
  If blnFatPre Then
  Begin
    dbeMarBr2.ReadOnly := True;
    dbeMarBr2.TabStop  := False;

    dbeMarBr3.ReadOnly := True;
    dbeMarBr3.TabStop  := False;

    dbeMarBr4.ReadOnly := True;
    dbeMarBr4.TabStop  := False;

    dbeMarBr5.ReadOnly := True;
    dbeMarBr5.TabStop  := False;

    dbeMarBr6.ReadOnly := True;
    dbeMarBr6.TabStop  := False;

    dbeMarBr7.ReadOnly := True;
    dbeMarBr7.TabStop  := False;

    dbePreVe2.ReadOnly := True;
    dbePreVe2.TabStop  := False;

    dbePreVe3.ReadOnly := True;
    dbePreVe3.TabStop  := False;

    dbePreVe4.ReadOnly := True;
    dbePreVe4.TabStop  := False;

    dbePreVe5.ReadOnly := True;
    dbePreVe5.TabStop  := False;

    dbePreVe6.ReadOnly := True;
    dbePreVe6.TabStop  := False;

    dbePreVe7.ReadOnly := True;
    dbePreVe7.TabStop  := False;

    dbeComTb2.ReadOnly := True;
    dbeComTb2.TabStop  := False;

    dbeComTb3.ReadOnly := True;
    dbeComTb3.TabStop  := False;

    dbeComTb4.ReadOnly := True;
    dbeComTb4.TabStop  := False;

    dbeComTb5.ReadOnly := True;
    dbeComTb5.TabStop  := False;

    dbeComTb6.ReadOnly := True;
    dbeComTb6.TabStop  := False;

    dbeComTb7.ReadOnly := True;
    dbeComTb7.TabStop  := False;

    If blnDesabilita Then
    Begin
      dbeMarBr2.Enabled := False;
      dbeMarBr3.Enabled := False;
      dbeMarBr4.Enabled := False;
      dbeMarBr5.Enabled := False;
      dbeMarBr6.Enabled := False;
      dbeMarBr7.Enabled := False;

      dbePreVe2.Enabled := False;
      dbePreVe3.Enabled := False;
      dbePreVe4.Enabled := False;
      dbePreVe5.Enabled := False;
      dbePreVe6.Enabled := False;
      dbePreVe7.Enabled := False;

      dbeComTb2.Enabled := False;
      dbeComTb3.Enabled := False;
      dbeComTb4.Enabled := False;
      dbeComTb5.Enabled := False;
      dbeComTb6.Enabled := False;
      dbeComTb7.Enabled := False;
    End;

  End;
End;

procedure TfrmCadProdutos.pArmazenaUltimaEscolhaStatusProduto(strCodOPE: String; intOpcaoStatus: Integer);
Var
  qryTemp: TUniquery;
begin
  qryTemp := fCriaQuery;
  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('UPDATE CADOPE SET OPE_STAPRD = :STAPRD WHERE OPE_CODOPE = :CODOPE ');
    qryTemp.ParamByName('CODOPE').AsString := strCodOPE;
    qryTemp.ParamByName('STAPRD').AsInteger:= intOpcaoStatus;
    qryTemp.ExecSQL;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TfrmCadProdutos.fRetornaUltimaEscolhaStatusProduto(strCodOPE: String): Integer;
Var
  qryTemp: TUniquery;
Begin

  qryTemp := fCriaQuery;
  Try
    qryTemp.Close;
    qryTemp.SQL.Clear;
    qryTemp.SQL.Add('SELECT OPE_STAPRD FROM CADOPE WHERE OPE_CODOPE = :CODOPE ');
    qryTemp.ParamByName('CODOPE').AsString := strCodOPE;
    qryTemp.Open;

    If qryTemp.FieldByName('OPE_STAPRD').AsInteger > 0 Then
      result:= qryTemp.FieldByName('OPE_STAPRD').AsInteger
    Else
      result:= 3;

  Finally
    FreeAndNil(qryTemp);
  End;
End;

Function TfrmCadProdutos.fMarcaAtivoCatIte(strCodFab, strCodFor: String): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  With qryGen, SQL Do
  Begin
    Clear;

    Add('UPDATE CATITE              ');
    Add('SET                        ');
    Add('  CAT_OPEATI = :OPEATI,    ');
    Add('  CAT_HORATI = :HORATI,    ');
    Add('  CAT_DTAATI = :DTAATI     ');
    Add('WHERE                      ');
    Add('  CAT_CODFAB = :CODFAB AND ');
    Add('  CAT_CODFOR = :CODFOR     ');

    ParamByName('OPEATI').AsString := strLoginUsuarioLogado;
    ParamByName('HORATI').AsTime   := Time;
    ParamByName('DTAATI').AsDate   := VS_Date;

    ParamByName('CODFAB').AsString := strCodFab;
    ParamByName('CODFOR').AsString := strCodFor;

    ExecSQL;
  End;
  FreeAndNil(qryGen);
  Result := True;
End;

Function TfrmCadProdutos.fGravaItemProgresso: Boolean;
  Var
    LfrmGravando: TfrmGravando;
Begin
  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmGravando);
      LfrmGravando.fExecutarAcao := fGravaItem;
      LfrmGravando.ShowModal;
      Result := LfrmGravando.blnConfirma;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadProdutos.pGravaItem]');
    End;
  End;

  If Assigned(objSender) Then
  Begin
    Result := True;

    If Self.CanFocus Then
    Begin
      pSetFocus(Self);
      pSetFocus(objSender);
    End;
  End;

End;

procedure TfrmCadProdutos.FichaKardex1Click(Sender: TObject);
begin
  inherited;
  If qryTabela.Active Then

  If Assigned(prcExecutaRelatorio) Then
    prcExecutaRelatorio(34, 2951, [2951,2958],
                       ['CODEMP','CODITE'],
                       [VS_STRCODEMP, qryTabela.FieldByName('ITE_CODITE').AsString],
                       Sender, Nil, False, True, 'frmRelEstKardex');
end;

Procedure TfrmCadProdutos.pFinalizaStatusGravacao;
Begin
  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbStatusGravacao.Position := pgbStatusGravacao.Properties.Max;
    Application.ProcessMessages;
  End;
End;

Function TfrmCadProdutos.fRetMaxPassos(blnSomaEmpresas: Boolean): Integer;

  Function fRetNumeroEmpresas: Integer;
    Var
      qryCadEmp: TUniQuery;
  Begin
    qryCadEmp := fCriaQuery(Self);
    With qryCadEmp, SQL Do
    Begin
      Clear;
      Add('SELECT COUNT(*) AS QTDEMP FROM CADEMP');
      Open;
      Result := FieldByName('QTDEMP').AsInteger;
      Close;
    End;
    FreeAndNil(qryCadEmp);
  End;

Begin
  Result := 16;

  If blnSomaEmpresas Then
    Result := fRetNumeroEmpresas;

End;

procedure TfrmCadProdutos.pStepStatusGravacao;
Begin
  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbStatusGravacao.Position := pgbStatusGravacao.Position + 1;
    Application.ProcessMessages;
  End;
End;

procedure TfrmCadProdutos.pUnidadeFracionada;
begin
  blnUnidadeEFracionada := (fCampoTabela('UNI_ITEFRA', 'CADUNI', ['UNI_CODUNI'], [dbeCodUni.Text], False) = 'S');

  If Not blnUnidadeEFracionada Then
  Begin
    edtEmbFec.OnKeyPress := TProcEventos.pTravaValorFracionadoOnKeyPress;
    edtEmbFec.EditFormat := '';
  End
  Else
  Begin
    edtEmbFec.OnKeyPress := nil;
    edtEmbFec.EditFormat := fMskDigitos(2);
  End;

  If Not fVerificaUnidadeComEmbalagemFechada Then
    fMensagem('', 'A unidade do produto foi alterada para uma unidade não fracionada, ' + sLineBreak +
                  'será necessário atualizar a quantidade da embalagem fechada!', ['&OK']);
end;

procedure TfrmCadProdutos.pUpdateCaption;
begin
  Self.Caption := 'Cadastro de Produtos' + IIF(not fEmptyStr(dbeCodIte.Text), ' - ' + dbeCodIte.Text, '' ) +
                                           IIF(not fEmptyStr(dbeDesIte.Text), ' - ' + dbeDesIte.Text, '' ) ;

end;


Procedure TfrmCadProdutos.pMontaCamGir;
  Var
    intIndex  : Integer;
    intMonth  : Word;
    intYear   : Word;
Begin
  stlCamGir := TStringList.Create;
  stlCamNom := TStringList.Create;

  stlCamGir.Clear;
  intMonth := MonthOf(fNow());
  intYear  := YearOf(fNow());

  stlCamGir.Insert(0, fStrZero(intToStr(intMonth),2) + '/' + intToStr(intYear));
  stlCamNom.Insert(0, 'MES0');

  intQYear := 1;

  For intIndex := 12 DownTo 1 Do
  Begin
    Dec(intMonth);
    If intMonth = 0 Then
    Begin
      intMonth := 12;
      Dec(intYear);
      Inc(intQYear);
    End;

    stlCamGir.Insert(0, fStrZero(intToStr(intMonth),2) + '/' + intToStr(intYear));
    stlCamNom.Insert(0, 'MES' + IntToStr(intIndex));
  End;

  For intIndex := 1 To stlCamGir.Count Do
  Begin
    TcxGridDBColumn(cxbGiroVendas.Items[(stlCamGir.Count + 1) - intIndex]).DataBinding.FieldName := stlCamNom[intIndex-1] + '_SAI';
    TcxGridDBColumn(cxbGiroVendas.Items[(stlCamGir.Count + 1) - intIndex]).Caption := stlCamGir[intIndex-1];
  End;

  For intIndex := 1 To 12 Do
  Begin
    TcxGridDBColumn(cxbGiroCompras.Items[intIndex]).DataBinding.FieldName := stlCamNom[intIndex-1] + '_ENT';
    TcxGridDBColumn(cxbGiroCompras.Items[intIndex]).Caption := stlCamGir[intIndex-1];
  End;

End;

procedure TfrmCadProdutos.pMontaCdsIteCom;
Var
  intIndex : Integer;
  strSQL   : String;

Begin
  if Not tbsIteCom.TabVisible Then
    Exit;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '          AUTOINCREM,       ';
  strSQL := strSQL + '          COM_CODITE,       ';
  strSQL := strSQL + '          COM_TABPRE,       ';
  strSQL := strSQL + '          COM_VENINT,       ';
  strSQL := strSQL + '          COM_VENEXT        ';
  strSQL := strSQL + ' FROM COMITE                ';
  strSQL := strSQL + ' WHERE COM_CODITE = :CODITE ';
  strSQL := strSQL + ' ORDER BY COM_TABPRE        ';

  cdsIteCom.Tag := 0;

  cdsIteCom.qryQuery.Close;
  cdsIteCom.qryQuery.SQL.Clear;
  cdsIteCom.qryQuery.SQL.Add( strSQL );
  cdsIteCom.qryQuery.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;

  cdsIteCom.fAbreClient(True, 'TfrmCadProdutos.pMontaCdsIteCom');

  TFloatField(cdsIteCom.FieldByName('COM_VENINT')).DisplayFormat := '#,##0.00 %';
  TFloatField(cdsIteCom.FieldByName('COM_VENEXT')).DisplayFormat := '#,##0.00 %';

  dbgIteComDBTableView.DataController.DataSource := cdsIteCom.dtsSource;

  cdsIteCom.BeforeInsert := Nil;
  cdsIteCom.DisableControls;

  try
    For intIndex := 1 To Length(VS_strTabPrc) Do
    Begin
      If cdsIteCom.Locate('COM_TABPRE', intIndex, []) And (VS_strTabPrc[intIndex] = 'N' ) Then
      Begin
        cdsIteCom.Delete;
        Continue;
      End;

      If (not cdsIteCom.Locate('COM_TABPRE', intIndex, [])) And (VS_strTabPrc[intIndex] = 'S' ) Then
      Begin
        cdsIteCom.Append;
        cdsIteCom.FieldByName('AUTOINCREM').AsString := '';
        cdsIteCom.FieldByName('COM_CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
        cdsIteCom.FieldByName('COM_TABPRE').AsString := IntToStr(intIndex);
        cdsIteCom.FieldByName('COM_VENINT').AsFloat  := 0;
        cdsIteCom.FieldByName('COM_VENEXT').AsFloat  := 0;
        cdsIteCom.Post;
      End;

    End;
  finally
    cdsIteCom.BeforeInsert := pCdsIteComBeforeInsert;
    cdsIteCom.EnableControls;
  end;

End;

function TfrmCadProdutos.fGetSqlGiro: String;
  Var
    intIndex  : Integer;
    intCorre  : Integer;
    intYearAtu: Word;
    strSQL    : String;
begin

  strSQL := '';
  intYearAtu := StrToInt(Copy(stlCamGir[0],4,4));

  For intIndex := 1 to intQYear Do
  Begin
    If not fEmptyStr(strSQL) Then
      strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + ' CONCAT(GIR_CODEMP, " - ", EMP_NOMEMP) AS GIR_CODEMP, ';

    For intCorre := 0 To stlCamGir.Count-1 Do
    Begin

      If intYearAtu = StrToInt(Copy(stlCamGir[intCorre],4,4)) Then
      Begin
        If intCorre = stlCamGir.Count-1 Then
        Begin
          strSQL := strSQL + ' GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + ' AS GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + '_ATU, ';
          strSQL := strSQL + ' GIR_QENT' + Copy(stlCamGir[intCorre],1,2) + ' AS GIR_QENT' + Copy(stlCamGir[intCorre],1,2) + '_ATU';
        End Else
        Begin
          strSQL := strSQL + ' GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + ', ';
          strSQL := strSQL + ' GIR_QENT' + Copy(stlCamGir[intCorre],1,2);
        End;
      End
      Else
      Begin
        If intCorre = stlCamGir.Count-1 Then
        Begin
          strSQL := strSQL + ' 0.00 AS GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + '_ATU, ';
          strSQL := strSQL + ' 0.00 AS GIR_QENT' + Copy(stlCamGir[intCorre],1,2) + '_ATU';
        End Else
        Begin
          strSQL := strSQL + ' 0.00 AS GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + ', ';
          strSQL := strSQL + ' 0.00 AS GIR_QENT' + Copy(stlCamGir[intCorre],1,2);
        End;
      End;

      If intCorre < stlCamGir.Count-1 then
        strSQL := strSQL + ', ';

    End;

    strSQL := strSQL + ' FROM GIRITE ';
    strSQL := strSQL + ' INNER JOIN CADEMP ON EMP_CODEMP = GIR_CODEMP ';
    strSQL := strSQL + ' WHERE GIR_CODITE = :CODITE ';
    strSQL := strSQL + '   AND GIR_A_N_O_ = "' + intToStr(intYearAtu) + '" ';

    Inc(intYearAtu);
  End;

  Result := '';
  Result := Result + ' SELECT GIR_CODEMP, ';
  For intCorre := 0 To stlCamGir.Count-1 Do
  Begin

    If intCorre = stlCamGir.Count-1 Then
    Begin
      Result := Result + ' SUM(' +'IFNULL(GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + '_ATU, 0)) AS "' + stlCamNom[intCorre] + '_SAI", ';
      Result := Result + ' SUM(' +'IFNULL(GIR_QENT' + Copy(stlCamGir[intCorre],1,2) + '_ATU, 0)) AS "' + stlCamNom[intCorre] + '_ENT", ';
    End Else
    Begin
      Result := Result + ' SUM(' +'IFNULL(GIR_QSAI' + Copy(stlCamGir[intCorre],1,2) + ', 0)) AS "' + stlCamNom[intCorre] + '_SAI", ';
      Result := Result + ' SUM(' +'IFNULL(GIR_QENT' + Copy(stlCamGir[intCorre],1,2) + ', 0)) AS "' + stlCamNom[intCorre] + '_ENT", ';
    End;

  End;

  Result := Result + ' 0.00 AS GIR_MEDI03_COM, ';
  Result := Result + ' 0.00 AS GIR_MEDI06_COM, ';
  Result := Result + ' 0.00 AS GIR_MEDI12_COM, ';

  Result := Result + ' 0.00 AS GIR_MEDI03_VEN, ';
  Result := Result + ' 0.00 AS GIR_MEDI06_VEN, ';
  Result := Result + ' 0.00 AS GIR_MEDI12_VEN ';

  Result := Result + ' FROM ( ' + strSQL + ') AS GIRO ';
  Result := Result + ' GROUP BY GIR_CODEMP ';

end;

Function TfrmCadProdutos.fGravaItem(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strAutInc : String;
begin
  Result := False;

  If Not fValidaPrecos Then
    Exit;

  If Not fVerificaCampos Then
    Exit;

  If Assigned(objTabelas) Then
  Begin

    If (Not objTabelas.fValidaPrecos) Then
    Begin
      pgcDados.ActivePage := tbsMargemIdeal;
      Exit;
    End;

    If (Not objTabelas.fValidaTabelasPreco) Then
    Begin
      pgcDados.ActivePage := tbsGeral;
      Exit;
    End;
  End;

  pgbStatusGravacao := pgbProgresso;

  If Assigned(pgbStatusGravacao) Then
  Begin
    pgbProgresso.Properties.Max := fRetMaxPassos(blnInserindo And Not blnCatalogo);
    Application.ProcessMessages;
  End;

  fStartTransaction;

  If fCfgSis('LOGCPR', VarBoolean) Then
    TLogAltCadIte.pGravaLogAlteracao(qryTabela);

  If fCfgSis('LOGCPR', VarBoolean) and ((fCfgSis('TIPABF') = '2') Or (fCfgSis('TPABPC') = '2')) Then
    TLogAltCadIte.pGravaLogAlteracao(qryIteGer, fCfgSis('TIPABF'), fCfgSis('TPABPC'));

  inherited pGravaRegistro;

  pStepStatusGravacao;

  If Not blnGravou Then
  Begin
    fRollBack;
    Exit;
  End;

  If Assigned(objTabelas) And (Not objTabelas.fSalvaDados) Then
  Begin
    fRollBack;
    pgcDados.ActivePage := tbsMargemIdeal;
    Exit;
  End;

  If Not objAtributos.fSalvaAtributos(qryTabela.FieldByName('ITE_CODITE').AsString) Then
  Begin
    fRollBack;
    Exit;
  End;

  If blnCCDPRM Then
    FornecedorItemPalett.fSalvar(qryTabela.FieldByName('ITE_CODITE').AsString);

  If blnGeraCodBar And blnInserindo Then
  Begin
    qryTabela.Edit;
    objIteBar.pGeraCodigoBarras(qryTabela.FieldByName('ITE_CODGRU').AsString,
                                qryTabela.FieldByName('ITE_CODITE').AsString);
    qryTabela.Post;

    If Not objIteBar.fVerificaCodBar(qryTabela.FieldByName('ITE_CODITE').AsString, True) Then
    Begin
      fRollBack;
      Exit;
    End;
  End;

  pStepStatusGravacao;

  objIteBar.pSalvaDados(qryTabela.FieldByName('ITE_CODITE').AsString);

  If Not objLocFis.fSalvaLocalizacoes(qryTabela.FieldByName('ITE_CODITE').AsString) Then
  Begin
    fRollBack;
    Exit;
  End;

  pStepStatusGravacao;

  If Not objIteMon.fSalvaDados(qryTabela.FieldByName('ITE_CODITE').AsString) Then
  Begin
    fRollBack;
    Exit;
  End;

  pStepStatusGravacao;

  If Assigned(objCadProdutosVeiculoModelo) then
  Begin
    If Not objCadProdutosVeiculoModelo.fGravar(qryTabela.FieldByName('ITE_CODITE').AsString) Then
    Begin
      fRollBack;
      Exit;
    End;
  End;

  pStepStatusGravacao;

  {**************************************}
  {* SE CheckBox ESTIVER MARCADO, GRAVA *}
  {*   LOCALIZACAO SUPER ESTOQUE PARA   *}
  {*    TODAS AS EMPRESAS DA ITEGER     *}
  {***********************************GR*}
  If cbxAplicarTodas.Checked Then
  begin
    If (Not fGravaLocSuperEstoqueTodasEmpresas(vs_strCodEmp,dbeCodIte.Text,dbeSupEst.Text,dbeTamLocS.Text)) Then
    Begin
      fRollBack;
      Exit;
    End;
  end;

  pStepStatusGravacao;

  {***********************************}
  {* GRAVA LOG DE LOCALIZAÇÃO FÍSICA *}
  {********************************PZ*}
  If fGeraLogLocFis(dbeLocFis.Text, strLocAnt)  Then
  Begin
    If (Not fGravaLogLocFisica(dbeCodIte.Text,strLocAnt,dbeLocFis.Text, 1, '')) Then
    Begin
      fRollBack;
      Exit;
    End;
  End;

  If fGeraLogLocFis(dbeSupEst.Text, strSupAnt) Then
  Begin
    If (Not fGravaLogLocFisica(dbeCodIte.Text,strSupAnt,dbeSupEst.Text, 2, '')) Then
    Begin
      fRollBack;
      Exit;
    End;
  End;


  {***************************************}
  {* GRAVA LOG DE ALT EST MAX. E MIN     *}
  {************************************GB*}
  If (qryIteGer.State = dsEdit) And
     ((qryIteGer.FieldByName('ITE_ESTMIN').Value <> qryIteGer.FieldByName('ITE_ESTMIN').OldValue) or
      (qryIteGer.FieldByName('ITE_ESTMAX').Value <> qryIteGer.FieldByName('ITE_ESTMAX').OldValue)) Then
  Begin
    TAltEst.fGravaLog(Self,
                      qryIteGer.FieldByName('ITE_CODITE').AsString,
                      vs_strCodEmp,
                      qryIteGer.FieldByName('ITE_ESTMIN').AsFloat,
                      qryIteGer.FieldByName('ITE_ESTMAX').AsFloat,
                      (qryIteGer.FieldByName('ITE_ESTMIN').Value <> qryIteGer.FieldByName('ITE_ESTMIN').OldValue),
                      (qryIteGer.FieldByName('ITE_ESTMAX').Value <> qryIteGer.FieldByName('ITE_ESTMAX').OldValue)
                      );
  End;


  pStepStatusGravacao;

  Try
    If blnInserindo Then
    Begin
      qryIteGer.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEGER', qryTabela.FieldByName('ITE_CODEMP').AsString);

      objLojas.pSetDadosInclusaoIgualParaTodasAsEmpresas(VS_strCodEmp, qryIteger);

      qryIteGer.FieldByName('ITE_CODITE').AsString  := qryTabela.FieldByName('ITE_CODITE').AsString;
      qryIteGer.FieldByName('ITE_CODEMP').AsString  := qryTabela.FieldByName('ITE_CODEMP').AsString;
    End
    Else
    Begin
      {*****************************************}
      {* GRAVAÇÃO DOS PREÇOS ALTERADOS         *}
      {**************************************MV*}
      pGravaPreAlt;

      {**********************************************}
      {* GRAVAÇÃO DOS SALDOS PARA TODAS AS EMPRESAS *}
      {* SE FOR EMPRESA GERENCIAL                   *}
      {*** 04/04/2008 ****************************JB*}

      If (fCfgSis('EMPGER', varBoolean)) Then
      begin
        objLojas.pGravaInfoLojas(Self, qryTabela.FieldByName('ITE_CODITE').AsString);
        objLojas.pGeraLogPontoExposicao;
      End
      Else If cxvLojasPONEXP.Visible Then
          objLojas.pAtualizaPontoExposicoes;
    End;

    pStepStatusGravacao;
    qryIteger.FieldByName('ITE_PREALT').AsString := strAgrupadorPreAlt;
    qryIteGer.Post;

    pStepStatusGravacao;

    {*****************************************}
    {* CASO SEJA INSERÇÃO, GERA O ITEGER     *}
    {**************************************MV*}
    If blnInserindo Then
    Begin
      pGeraIteGer;
      pGeraGirIte(qryTabela.FieldByName('ITE_CODITE').AsString);
    End Else
    Begin
      pAtualizaIteGer(False);

      If blnInfMat And fEhEmpresaResponsavelFornecedor(dbeCodFor.Text) Then
        pAtualizaIteGer(True);

    End;

    pAtualizaItensGrupoPrecos(qryTabela.FieldByName('ITE_CODITE').AsString, 'CADASTRO DE PRODUTOS', strAgrupadorPreAlt);


    If Not frmManutencaoAbreviacoesLojas.fGrava(qryTabela.FieldByName('ITE_CODITE').AsString) Then
    begin
      fRollBack;
      Exit;
    End;

    pStepStatusGravacao;

    If Not blnUsaTabPrF Then
      pGravaIteFor;

    fAtualizaBarFabIte(qryTabela.FieldByName('ITE_CODITE').AsString);

    If fCfgSis('ITETBP', VarBoolean) Then
      pGravaDesMaxTabPre(qryIteger.FieldByName('ITE_CODITE').AsString,
                         qryIteger.FieldByName('ITE_CODEMP').AsString);

    If fCfgSis('DMVFQV', VarBoolean) Then
      GravaDesMaxFaixaQtde(qryIteger.FieldByName('ITE_CODITE').AsString,
                           qryIteger.FieldByName('ITE_CODEMP').AsString);

    pStepStatusGravacao;

    If tbsExportaSite.TabVisible Then
    Begin
      FPanelDadosECommerce.pGravaDadosECommerce;
      if not blnInserindo Then
      Begin
        strAutInc := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryTabela.Close;
        qryTabela.SQL.Text := 'SELECT * FROM CADITE WHERE AUTOINCREM = ' + QuotedStr(strAutInc);
        qryTabela.Open;
      End;
    End;

    If blnInserindo {and fUsaRotinaWMS} Then
       TCadLot.fGeraADefinirWMS(qryTabela.FieldByName('ITE_CODITE').AsString);

    pStepStatusGravacao;

    pCarregaIteGer;
    pAtualizaVariaveis;
    pMontaTelaEstoque;
    pCarregaDadosSomenteLeitura(qryIteGer);
    pCarregaOperador;

    If tbsExportaSite.TabVisible Then
      FPanelDadosECommerce.pCarregaDadosECommerce;

    pStepStatusGravacao;

    If fCfgSis('ESMILJ', varBoolean) Then
    Begin
      pAtualizaOpcaoEstMinLojas;
    End;

    pStepStatusGravacao;

(*    If Not fCfgSis('CPRIND', varBoolean) Then
    Begin
      pAtualizaCprCenLojas;
    End; *)

    If Not fCfgSis('ILIEMP', varBoolean) Then
    Begin
      pAtualizaImpLisLojas;
    End;

    pStepStatusGravacao;

    If fCfgSis('APERET', varBoolean) Then
    Begin

      If (fCfgSis('RETITE') = 'T') Then
        pAtualizaApeRetLojas;

      If (fCfgSis('APNENT') = 'T') Then
        pAtualizaApeEntLojas;

    End;

    pStepStatusGravacao;

    if intSitPro = 1 then
      pAtualizaSitProLojas;

    pStepStatusGravacao;

    pgcDados.ActivePageIndex := 0;

    If blnInserindo And blnCatalogo Then
      fMarcaAtivoCatIte(qryTabela.FieldByName('ITE_CODFAB').AsString,
                        qryTabela.FieldByName('ITE_CODFOR').AsString);

    If blnInserindo Then
      blnAtualizarCatAti := TRUE;

    cdsIteEmb.DisableControls;
    cdsIteEmb.Filter   := '';
    cdsIteEmb.Filtered := False;
    cdsIteEmb.First;

    If fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString) Then
    Begin
      raise Exception.Create('Código do produto em branco!');
    End;

    While Not cdsIteEmb.Eof Do
    Begin
      If fEmptyStr(cdsIteEmb.FieldByName('ITB_CODITE').AsString) Or
         fEmptyStr(cdsIteEmb.FieldByName('ITB_TABPRE').AsString) Then
      Begin
        cdsIteEmb.Edit;

        If fEmptyStr(cdsIteEmb.FieldByName('ITB_CODITE').AsString) Then
          cdsIteEmb.FieldByName('ITB_CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;

        if fEmptyStr(cdsIteEmb.FieldByName('ITB_TABPRE').AsString) Then
          cdsIteEmb.FieldByName('ITB_TABPRE').Clear;

        cdsIteEmb.Post;
      End;

      cdsIteEmb.Next;
    End;
    cdsIteEmb.EnableControls;

    If (fCfgSis('TPDCEM', varString) = '2') Then
      pReplicarIteEmbEmpresas()
    Else
      cdsIteEmb.fSalva();

    stlIteEmbHer.Clear;


    pStepStatusGravacao;

    pSalvaComplementoEtiquetas;

    pStepStatusGravacao;

    pSalvaLayOrdInd;

    pStepStatusGravacao;

    If (Assigned(objFaixasMet)) Then
    Begin
      objFaixasMet.fSalvar();
      FreeAndNil(objFaixasMet);
    End;

    pStepStatusGravacao;

    fCommit;

    Result := True;

    pAbreIteEmb;

    pStepStatusGravacao;

    blnGravou := False;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadProdutos.btnGravarClick]');
      Exit;
    End;
  End;

  btnHeranca.Enabled := False;
  blnHeranca := False;

  objIteBar.pHabilitaEdicao(False);
  objIteMon.pHabilitaEdicao(False);
  objLocFis.pHabilitaEdicao(False);

  If blnCatalogo Then
  Begin
    pnlDesFab.visible   := True;
    edtDescOrig.Visible := False;
    lblDescOrig.Visible := False;
    dbeDesSim.Width     := dbeDesIte.Width;
  End;

  blnCatalogo := FALSE;

  pAjustaFatorPreco(True);

  frmManutencaoAbreviacoesLojas.pHabilitaEdicao(False);
  frmManutencaoAbreviacoesLojas.pCarrega(dbeCodIte.Text);
  frmManutencaoAbreviacoesLojas.pHabilitaEdicao(False);


  pStepStatusGravacao;
  pFinalizaStatusGravacao;
end;

procedure TfrmCadProdutos.btnGravaPaleteClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtQtdItePal.Text) Then
    edtQtdItePal.Text := '0';
  If fEmptyStr(edtValPalet.Text) Then
    edtQtdItePal.Text := '0';

  If fStrToFloat(edtQtdItePal.Text) <=0 Then
  Begin
    pMensagemOk('O Campo "Qtd. Itens p/ Pallet" deve ser maior que zero');
    pSetFocus(edtQtdItePal);
    Exit;
  End;

  If fStrToFloat(edtValPalet.Text) <=0 Then
  Begin
    pMensagemOk('O Campo "Valor por Pallet" deve ser maior que zero');
    pSetFocus(edtValPalet);
    Exit;
  End;

  If FornecedorItemPalettRecord.strAutoincrem <> semRegistros Then
  Begin
    FornecedorItemPalettRecord.strCodIte := qryTabela.FieldByName('ITE_CODITE').AsString;
    FornecedorItemPalettRecord.strCodFor := edtCodForPal.Text;
    FornecedorItemPalettRecord.strDesFor := edtDesForPal.Text;
    FornecedorItemPalettRecord.fltQtdite := fStrToFloat(edtQtdItePal.Text);
    FornecedorItemPalettRecord.fltValPal := fStrToFloat(edtValPalet.Text);

    If FornecedorItemPalett.fInserir(FornecedorItemPalettRecord) Then
      pLimpaInfPallets;
  End;

end;

procedure TfrmCadProdutos.btnGravarClick(Sender: TObject);
  Var
    strItem: String;
    blnBloIte : Boolean;
begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      pPreAltDefineVariaveisAltPre(fNow,'CADASTRO DE PRODUTOS', strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);
      blnAcaoGravacao := True;

      blnUsaVerificaCamposPai := False;
      pSetfocus(btnGravar);
      edtComLiq.Enabled := False;
      edtCusRea.Enabled := False;
      chkPreDol.Enabled := False;

      blnInserindo := (qryTabela.State = dsInsert);

      If blnInserindo And (qryIteGer.State <> dsInsert) Then
      Begin
        pMensagemOk('Houve um problema na gravação do dados, a operação precisará ser abortada!' + #13#10 +
                    'Favor ligar para a Citel Software!');
        Close;
        Exit;
      End;

      blnBloIte := False;

      If Assigned(objTabelas) And (Not objTabelas.fTabelaPrecoToIteger) Then
        Exit;

      If (fCfgSis('CLPVDI', varBoolean)) And (Not blnInserindo) Then
      Begin
        If (dbeCodAbr.Text <> fGetCodAbf(dbeCodIte.Text, VS_strCodEmp)) Then
        Begin
          If fMensagem('', MSG_ALTERACAO_PRECO_VENDA_DINAMICA, ['&Sim', '&Não'], 1) = 2 Then
            Exit;

          blnBloIte := True;
        End;
      End;
      If Not blnInsert Then
      Begin
        objCalculaVariacaoPreco.strCodIte := dbeCodIte.Field.Value;
        objCalculaVariacaoPreco.strDesIte := dbeDesIte.Field.Value;
        objCalculaVariacaoPreco.strSigUni := dbeCodUni.Field.Value;

        objCalculaVariacaoPreco.fltNewPreve1 := dbePreVe1.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve2 := dbePreVe2.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve3 := dbePreVe3.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve4 := dbePreVe4.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve5 := dbePreVe5.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve6 := dbePreVe6.Field.AsFloat;
        objCalculaVariacaoPreco.fltNewPreve7 := dbePreVe7.Field.AsFloat;


        If objCalculaVariacaoPreco.blnBloqueia Then
        Begin
          objCalculaVariacaoPreco.pProcessaVariacao;
          If objCalculaVariacaoPreco.blnTemTabelaAcimaDoPermitido Then
            If Not objCalculaVariacaoPreco.fTravaUnitario Then
              Exit;

        End;
      End;

      If Not fEmptyStr(dbeCodFab.Text) Then
      Begin

        If Not fValidaCodForFab(dbeCodFor.Text, dbeCodFab.Text, qryTabela.FieldbyName('ITE_CODITE').AsString, strItem) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código de Fornecedor + Fábrica já cadastrados no Item ' + strItem + '!', ['&Ok']);
          pSetFocus(dbeCodFab);
          Exit;
        End;

      End;

      If Not fVerificaUnidadeComEmbalagemFechada Then
      Begin
        fMensagem('', 'A unidade do produto não é fracionada, e há quantidade na embalagem fechada fracionada!', ['&OK']);
        pgcDados.ActivePage := tbsIteEmb;
        pSetFocus(cxgIteEmb);
        Exit;
      End;

      If Not frmManutencaoAbreviacoesLojas.fValidaRegistros Then
      Begin
        pgcDados.ActivePage := tbsAbreviacaoes;
        frmManutencaoAbreviacoesLojas.pExibeMensagem;
        Exit;
      End;

      If objLojas.Locate('CODEMP', Vs_strCodEmp, []) And objLojas.FieldByname('DTABAL').IsNull Then
      Begin
        fMensagem('', 'A informação da data de balanço está em branco!', ['&OK']);
        pgcDados.ActivePage := tbsEstoque;
        pSetFocus(cxgLojas);
        Exit;
      End;

      qryTabela.FieldByName('ITE_DTAALT').AsDateTime := VS_Date;
      qryTabela.FieldByName('ITE_HULALT').AsDateTime := fNow;
      qryTabela.FieldByName('ITE_CODOPE').AsString   := strLoginUsuarioLogado;

     If (qryTabela.FieldByName('ITE_ITEATI').AsString = 'N') And (qryTabela.FieldByName('ITE_ITEATI').OldValue = 'S') Then
       qryTabela.FieldByName('ITE_DTAINA').AsDateTime := VS_Date;

     If (qryTabela.FieldByName('ITE_ITEATI').AsString = 'S') Then
       qryTabela.FieldByName('ITE_DTAINA').Clear;

      If fEmptyStr(dbeRefere.Text) Then
      Begin
        qryTabela.FieldByName('ITE_REFERE').Value := Null;
      End;

      If fEmptyStr(qryTabela.FieldByName('ITE_CODSIM').AsString) Then
        qryTabela.FieldByName('ITE_CODSIM').Value := Null;

      If fEmptyStr(qryTabela.FieldByName('ITE_CODCOM').AsString) Then
        qryTabela.FieldByName('ITE_CODCOM').Value := Null;

      If fEmptyStr(qryTabela.FieldByName('ITE_GRUCMP').AsString) Then
      Begin
        qryTabela.FieldByName('ITE_GRUCMP').Clear;
      End;

      If fEmptyStr(qryTabela.FieldByName('ITE_PRDGRU').AsString) Then
      Begin
        qryTabela.FieldByName('ITE_PRDGRU').Clear;
      End;

      If (VS_strUsaTmq = 'S') And (lstTintas <> Nil)  And (cmbMarBas.ItemIndex > -1) Then
        qryTabela.FieldByName('ITE_MARBAS').AsString := lstTintas[cmbMarBas.ItemIndex];

      If (fEmptyStr(qryTabela.FieldByName('ITE_CODFLZ').AsString))     And
         (Not fEmptyStr(qryTabela.FieldByName('ITE_DESFLZ').AsString)) Then
      Begin
        qryTabela.FieldByName('ITE_CODFLZ').AsString := fRetProximoCodigo(dbeSetFlz.Text);
      End;

      (*
      If (Not fEmptyStr(qryTabela.FieldByName('ITE_DESFLZ').AsString))                 And
         ((blnInserindo) Or (fEmptyStr(qryTabela.FieldByName('ITE_CODBAR').AsString))) Then
      Begin
        qryTabela.FieldByName('ITE_CODBAR').AsString := RightStr(fRetSequencial('BARFLZ'), 4);
      End; *)

      If fEmptyStr(dbeAbfPis.Text) Then
        dbeAbfPis.DataSource.DataSet.FieldByName('ITE_ABFPIS').Value := Null;

      If fEmptyStr(dbeAbfCof.Text) Then
        dbeAbfCof.DataSource.DataSet.FieldByName('ITE_ABFCOF').Value := Null;

      If fEmptyStr(dbeAbfIpi.Text) Then
        dbeAbfIpi.DataSource.DataSet.FieldByName('ITE_ABFIPI').Value := Null;

      if fEmptyStr(dbeAbfCon.Text) then
        qryTabela.FieldByName('ITE_ABFCON').Value := Null;

      if fEmptyStr(dbeCodDic.Text) Then
        qryTabela.FieldByName('ITE_CODDIC').Clear;

      If fEmptyStr(qryTabela.FieldByName('ITE_UNICOM').AsString) Then
        qryTabela.FieldByName('ITE_UNICOM').Clear;

      qryIteGer.FieldByName('ITE_TIPPRO').AsString := LeftStr(cmbItePro.Text, 2);

      If cmbCarEst.Visible And (cmbCarEst.ItemIndex = 0) Then
        qryTabela.FieldByName('ITE_CAREST').AsString := 'I'
      Else
        qryTabela.FieldByName('ITE_CAREST').AsString := 'S';

      If intSitPro = 1 Then
      Begin
        If fEmptyStr(dbeSitPro.Text) Then
          qryTabela.FieldByName('ITE_SITPRO').Value := Null
      End
      Else If intSitPro = 2 Then
      Begin
        If fEmptyStr(qryIteGer.FieldByName('ITE_SITPRO').AsString) Then
          qryIteGer.FieldByName('ITE_SITPRO').Value := Null;
      End;

      If fEmptyStr(dbeCodLse.Text) Then
        qryIteGer.FieldByName('ITE_CODLSE').Value := Null;

      if not fVerificaMargemUtilizada then
        Exit;

      If blnMarNeg And (Not TProdMargemNegativa.fLiberaMargemNegativa(qryTabela, qryIteger, rotCadProdutos)) Then
        Exit;

      blnGeraCodBar := False;

      If objIteBar.cdsIteBar.IsEmpty Then
      Begin

        If (fCfgSis('CODBAR') = '3') Then
        Begin
          blnGeraCodBar := (fMensagem('', 'Gerar código de barras?', ['&Sim', '&Não']) = 1);
        End

        Else If (fCfgSis('CODBAR') = '2') Then
          blnGeraCodBar := True;

      End;

      If blnGeraCodBar And (qryTabela.State = dsEdit) Then
      Begin
        objIteBar.pGeraCodigoBarras(qryTabela.FieldByName('ITE_CODGRU').AsString,
                                    qryTabela.FieldByName('ITE_CODITE').AsString);
      End;

      If (fCfgSis('CODBAR') <> '4') And
         (Not (blnGeraCodBar And (qryTabela.State = dsInsert))) And
         (Not objIteBar.fVerificaCodBar(qryTabela.FieldByName('ITE_CODITE').AsString)) Then
      Begin
        pgcDados.ActivePage := tbsEmbalagens;
        objIteBar.pFocaCodBarras;
        Exit;
      End;

      If Not objIteBar.fValidaTabelaPrecosEmbalagem Then
      Begin
        pgcDados.ActivePage := tbsEmbalagens;
        objIteBar.pFocaCodBarras;
        Exit;
      End;

      If tbsExportaSite.TabVisible Then
      Begin
        pgcDados.ActivePage := tbsExportaSite;
        If Not FPanelDadosECommerce.fValidarDadosECommerce Then
          Exit;
      End;

      If fCfgSis('DMVFQV', VarBoolean) Then
      Begin
        If not ValidaCamposDesMaxFaixaQtde Then
        Begin
          pgcDados.ActivePage := tbsDesMaxFaixaQtde;
          Exit;
        End;
      End;

      If (blnBloIte) Then
      Begin
        pBloquearLiberarProdutoParaVendaEmTodasEmpresasQueUsamEssePreco(qryIteGer.FieldByName('ITE_CODITE').AsString, 'N');
      End;

      (**********************************************************************************)
      (* SE HOUVER ERRO DE GRAVAÇÃO DEVER FECHAR O FORMULARIO                           *)
      (* POIS O REGISTRO QUE ESTA MOSTRANDO NA TELA NAO FOI REALMENTE INCLUIDO OU       *)
      (* ATUALIZADO NO BANCO POR CAUSA DO ROLLBACK                                      *)
      (*******************************************************************************LA*)
      If Not fGravaItemProgresso Then
      Begin

        If FValidouPrecos Then
          Close;

      End Else
      Begin
        pHabilitaLojas(False, False);
        If Assigned(objCadProdutosVeiculoModelo) Then
        Begin
          objCadProdutosVeiculoModelo.pIniciaProcesso(qryTabela.FieldByName('ITE_CODITE').AsString, '');

          edtDescMarVei.LimparConteudo;
          edtDescModVei.LimparConteudo;
          mskAnoInicial.Text    := '';
          mskAnoFin.Text        := '';
          edtValvula.Text       := '';
          edtCilindrada.Text    := '';
          edtObservacoes.Text   := '';
          edtPotencia.Text      := '';
          cmbCombustivel.ItemIndex := 0;
          chkLimpaCamposVeiculo.Checked := True;

        End;

        if (fCfgSis('OPCCOM') = 'PPT') and (blnInsert) and (not blnHeranca) then
        begin
          pGravaTabelaComissao;
        end;

        pSalvaIteCom;

        If Assigned(frmTabelasDoItem) Then
        Begin
          frmTabelasDoItem.cxvPrecos.OptionsData.Editing := False;
          frmManutencaoAbreviacoesLojas.cxTblAbrev.OptionsData.Editing := False;
        End;

      End;

      objAtributos.pEdita(False);
      pnlBotoesAtributos.Enabled := False;

      strCodIteExterno := dbeCodIte.Text;

      blnPreDol := chkPreDol.Checked;
      pOnStateChange;
      objLojas.pCarregaPontoExposicao;

    Finally
      InterlockedDecrement(intConfirma);
      blnAcaoGravacao := False;

      If Not btnGravar.Enabled Then
        objLockEdicao.pDestravarTodos;
      blnUsaVerificaCamposPai := True;

      cbxAplicarTodas.Checked := False;
      strAgrupadorPreAlt := '';

    End;

  End
  Else
    InterlockedDecrement(intConfirma);

  objCalculaVariacaoPreco.fltPreve1 := qryIteGer.FieldByName('ITE_PREVE1').AsFloat;
  objCalculaVariacaoPreco.fltPreve2 := qryIteGer.FieldByName('ITE_PREVE2').AsFloat;
  objCalculaVariacaoPreco.fltPreve3 := qryIteGer.FieldByName('ITE_PREVE3').AsFloat;
  objCalculaVariacaoPreco.fltPreve4 := qryIteGer.FieldByName('ITE_PREVE4').AsFloat;
  objCalculaVariacaoPreco.fltPreve5 := qryIteGer.FieldByName('ITE_PREVE5').AsFloat;
  objCalculaVariacaoPreco.fltPreve6 := qryIteGer.FieldByName('ITE_PREVE6').AsFloat;
  objCalculaVariacaoPreco.fltPreve7 := qryIteGer.FieldByName('ITE_PREVE7').AsFloat;
  pSetaQueryCadIte(qryTabela);


end;

procedure TfrmCadProdutos.btnGs1CnpClick(Sender: TObject);
var
  strCodBar: String;
  blnConfirmou: Boolean;
begin
  inherited;

  blnConfirmou := False;

  If (Not (qryTabela.State in [dsInsert, dsEdit])) Then
  Begin
    fMensagem('Atenção', 'Para continuar você deve incluir ou alterar um produto!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmDigitaCodigoBarras, frmDigitaCodigoBarras);
    frmDigitaCodigoBarras.ShowModal;
    strCodBar := frmDigitaCodigoBarras.GetCodBar;
    blnConfirmou := frmDigitaCodigoBarras.GetConfirmou;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadProdutos.btnGs1CnpClick]');
    End;
  End;

  pFreeAndNil(frmDigitaCodigoBarras);

  If Not blnConfirmou Then
    Exit;

  If fEmptyStr(strCodBar) Then
    Exit;

  pConsultarGS1CNP(strCodBar);
end;

procedure TfrmCadProdutos.pCriaClientFornecedor;
Begin

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FOR_NOMFOR';
    DataType := ftString;
    Size := 60;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CID_NOMCID';
    DataType := ftString;
    Size := 40;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CID_ESTADO';
    DataType := ftString;
    Size := 2;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FOR_FONE01';
    DataType := ftString;
    Size := 15;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODITF';
    DataType := ftString;
    Size := TAM_CODIGO_FABRICA;
  End;

  With cdsFornecedor.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_CODCNA';
    DataType := ftString;
    Size := 20;
  End;

  cdsFornecedor.CreateDataSet;
  cdsFornecedor.IndexFieldNames := 'FOR_NOMFOR';

End;

procedure TfrmCadProdutos.pCriaClientDesMaxTabPre;
Begin

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_TABPRE';
    DataType := ftString;
    Size := 1;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESMAX';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESMGE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESMSU';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESVMM';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESSMM';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsDesMaxTabPre.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITE_DESGMM';
    DataType := ftFloat;
    Precision := 2;
  End;

  cdsDesMaxTabPre.CreateDataSet;
  cdsDesMaxTabPre.IndexFieldNames := 'ITE_TABPRE';

End;

procedure TfrmCadProdutos.CriaClientDesMaxFaixaQtde;
Begin
  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_QTDINI';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_QTDFIN';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESVEN';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESSUB';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESGER';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESVEM';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESSUM';
    DataType := ftFloat;
    Precision := 4;
  End;

  With FcdsDesMaxFaixaQtde.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DFQ_DESGEM';
    DataType := ftFloat;
    Precision := 4;
  End;


  FcdsDesMaxFaixaQtde.CreateDataSet;
  FcdsDesMaxFaixaQtde.IndexFieldNames := 'DFQ_QTDINI';

End;

procedure TfrmCadProdutos.pCarregaFornecedores(strCodIte: String; strNomCol: String = 'FOR_NOMFOR');
Var
  strSQL: String;
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   ITE_CODITE, ';
  strSQL := strSQL + '   ITE_CODFOR, ';
  strSQL := strSQL + '   ITE_CODITF, ';
  strSQL := strSQL + '   ITE_CODCNA, ';
  strSQL := strSQL + '   FOR_NOMFOR, ';
  strSQL := strSQL + '   FOR_FONE01, ';
  strSQL := strSQL + '   CID_NOMCID, ';
  strSQL := strSQL + '   CID_ESTADO ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITEFOR ';
  strSQL := strSQL + '   JOIN CADFOR ON (ITE_CODFOR=FOR_CODFOR) ';
  strSQL := strSQL + '   JOIN CADCID ON (FOR_CODCID=CID_CODCID) ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE ';
  strSQL := strSQL + ' ORDER BY ';

  If UpperCase(strNomCol) = 'FOR_NOMFOR' Then
    strSQL := strSQL + ' FOR_NOMFOR'
  Else
    strSQL := strSQL + ' ' + strNomCol;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    Open;

    cdsFornecedor.EmptyDataSet;
    If Not IsEmpty Then
    Begin
      First;

      While Not Eof Do
      Begin
        cdsFornecedor.Insert;
        cdsFornecedor.FieldByName('ITE_CODITE').AsString := fieldbyname('ITE_CODITE').AsString;
        cdsFornecedor.FieldByName('ITE_CODITF').AsString := fieldbyname('ITE_CODITF').AsString;
        cdsFornecedor.FieldByName('ITE_CODCNA').AsString := fieldbyname('ITE_CODCNA').AsString;
        cdsFornecedor.FieldByName('ITE_CODFOR').AsString := fieldbyname('ITE_CODFOR').AsString;
        cdsFornecedor.FieldByName('FOR_NOMFOR').AsString := fieldbyname('FOR_NOMFOR').AsString;
        cdsFornecedor.FieldByName('CID_NOMCID').AsString := fieldbyname('CID_NOMCID').AsString;
        cdsFornecedor.FieldByName('CID_ESTADO').AsString := fieldbyname('CID_ESTADO').AsString;
        cdsFornecedor.FieldByName('FOR_FONE01').AsString := fieldbyname('FOR_FONE01').AsString;
        cdsFornecedor.Post;

        Next;
      End;

      TStringField(cdsFornecedor.FieldByName('FOR_FONE01')).EditMask := fRetMascaraFonePais;

    End;

  End;

  FreeAndNil(qryGen);

End;

procedure TfrmCadProdutos.pCarregaDesMaxTabelaPreco(strCodIte, strCodEmp: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
    intTabPre: Integer;
begin
  qryGen := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   ITE_TABPRE, ';
  strSQL := strSQL + '   ITE_DESMAX, ';
  strSQL := strSQL + '   ITE_DESMSU, ';
  strSQL := strSQL + '   ITE_DESMGE, ';
  strSQL := strSQL + '   ITE_DESVMM, ';
  strSQL := strSQL + '   ITE_DESSMM, ';
  strSQL := strSQL + '   ITE_DESGMM  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ITETBP ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
  strSQL := strSQL + '   ITE_CODEMP = :CODEMP     ';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   ITE_TABPRE';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    cdsDesMaxTabPre.EmptyDataSet;

    For intTabPre := 1 To Length(VS_strTabPrc) Do
    Begin
      If VS_strTabPrc[intTabPre] = 'S' Then
      Begin
        cdsDesMaxTabPre.Insert;

        cdsDesMaxTabPre.FieldByName('ITE_TABPRE').AsString := IntToStr(intTabPre);

        If Locate('ITE_TABPRE', IntToStr(intTabPre), []) Then
        Begin
          cdsDesMaxTabPre.FieldByName('ITE_DESMAX').AsFloat  := FieldByName('ITE_DESMAX').AsFloat;
          cdsDesMaxTabPre.FieldByName('ITE_DESMSU').AsFloat  := FieldByName('ITE_DESMSU').AsFloat;
          cdsDesMaxTabPre.FieldByName('ITE_DESMGE').AsFloat  := FieldByName('ITE_DESMGE').AsFloat;

          cdsDesMaxTabPre.FieldByName('ITE_DESVMM').AsFloat  := FieldByName('ITE_DESVMM').AsFloat;
          cdsDesMaxTabPre.FieldByName('ITE_DESSMM').AsFloat  := FieldByName('ITE_DESSMM').AsFloat;
          cdsDesMaxTabPre.FieldByName('ITE_DESGMM').AsFloat  := FieldByName('ITE_DESGMM').AsFloat;
        End
        Else
        Begin
          cdsDesMaxTabPre.FieldByName('ITE_DESMAX').AsFloat  := 0.00;
          cdsDesMaxTabPre.FieldByName('ITE_DESMSU').AsFloat  := 0.00;
          cdsDesMaxTabPre.FieldByName('ITE_DESMGE').AsFloat  := 0.00;

          cdsDesMaxTabPre.FieldByName('ITE_DESVMM').AsFloat  := 0.00;
          cdsDesMaxTabPre.FieldByName('ITE_DESSMM').AsFloat  := 0.00;
          cdsDesMaxTabPre.FieldByName('ITE_DESGMM').AsFloat  := 0.00;
        End;

        cdsDesMaxTabPre.Post;
      End;
    End;

    TStringField(cdsDesMaxTabPre.FieldByName('ITE_TABPRE')).Alignment := taCenter;
    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESMAX')).Alignment := taCenter;
    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESMSU')).Alignment := taCenter;
    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESMGE')).Alignment := taCenter;

    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESVMM')).Alignment := taCenter;
    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESSMM')).Alignment := taCenter;
    TFloatField (cdsDesMaxTabPre.FieldByName('ITE_DESGMM')).Alignment := taCenter;
  End;

  FreeAndNil(qryGen);

end;

procedure TfrmCadProdutos.pAjustaGridEstoquePontoExposicao(AstrCodEmp: String);
  var
    i: integer;
begin
  If Not cxvLojasPONEXP.Visible Then
    Exit;

  If  not (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;


  If objLojas.ReadOnly Then
  Begin
    objLojas.ReadOnly := False;
    For i := 0  To cxvLojas.ColumnCount -1 Do
      cxvLojas.Columns[i].Options.Editing := False;
  End
  Else
  Begin
    For i := 0  To cxvLojas.ColumnCount -1 Do
    Begin
       If (cxvLojas.Columns[i] <> cxvLojasCODEMP) or
          (cxvLojas.Columns[i] <> cxvLojasNOMEMP) or
          (cxvLojas.Columns[i] <> cxvLojasDTAAJU) or
          (cxvLojas.Columns[i] <> cxvLojasQTDAJU) or
          (cxvLojas.Columns[i] <> cxvLojasSALDOS) or
          (cxvLojas.Columns[i] <> cxvLojasSAL_ML) or
          (cxvLojas.Columns[i] <> cxvLojasSALRES) Then
      cxvLojas.Columns[i].Options.Editing := True;
    End;
  End;


  cxvLojasPONEXP.Options.Editing := fCfgSis('PONEXP', varBoolean, AstrCodEmp);
end;

procedure TfrmCadProdutos.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadProdutos.BitBtnLocked1Click(Sender: TObject);
  Var
    blnArquivo : Boolean;
    strTitulo  : String;
    intLength  : Integer;
begin
  inherited;
  intLength := Length(pgcUltVendaCompra.ActivePage.Caption);
  strTitulo := ReplaceStr( Copy(pgcUltVendaCompra.ActivePage.Caption,4,intLength) , '&', '');
  strTitulo := strTitulo + ' - Produto: ' + qryTabela.FieldByName('ITE_CODITE').AsString + qryTabela.FieldByName('ITE_DESITE').AsString;
  blnArquivo:= False;

  Case pgcUltVendaCompra.ActivePageIndex Of
    0: blnArquivo := TGeraExcel.fGerarRelatorio(dbgCompras    , strTitulo);
    1: blnArquivo := TGeraExcel.fGerarRelatorio(TcxGridDBTableView(cxbGiroCompras), strTitulo);
    2: blnArquivo := TGeraExcel.fGerarRelatorio(dbgVendas     , strTitulo);
    3: blnArquivo := TGeraExcel.fGerarRelatorio(TcxGridDBTableView(cxbGiroVendas) , strTitulo);
    4: blnArquivo := TGeraExcel.fGerarRelatorio(TcxGridDBTableView(cxgLoteRastreamentoTBV) , strTitulo);
  End;

  If blnArquivo Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmCadProdutos.btnEstruturaClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      pMostraEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString, '', True, False, True, False);

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);
end;

procedure TfrmCadProdutos.btnAdicionarFornClick(Sender: TObject);
  Var
    strMsgErr : String;
begin
  inherited;
  If not fValidaCodForFab(edtCodForn.Text, edtCodItF.Text, qryTabela.FieldbyName('ITE_CODITE').AsString, strMsgErr) Then
  Begin
    fMensagem('ATENÇÃO!', 'Código de Fornecedor + Fábrica já cadastrados no Item ' + strMsgErr + '!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(edtCodForn.Text)) And (Not fEmptyStr(edtNomForn.Text)) Then
  Begin
    If Not cdsFornecedor.Locate('ITE_CODFOR;ITE_CODITF', VarArrayOf([edtCodForn.Text,edtCodItF.Text]), []) Then
      cdsFornecedor.Append
    Else
      cdsFornecedor.Edit;

    cdsFornecedor.FieldByName('ITE_CODITE').AsString := qryTabela.fieldbyname('ITE_CODITE').AsString;
    cdsFornecedor.FieldByName('ITE_CODITF').AsString := edtCodItF.Text;
    cdsFornecedor.FieldByName('ITE_CODCNA').AsString := edtCodCNA.Text;
    cdsFornecedor.FieldByName('ITE_CODFOR').AsString := edtCodForn.Text;
    cdsFornecedor.FieldByName('FOR_NOMFOR').AsString := edtNomForn.Text;
    cdsFornecedor.FieldByName('CID_NOMCID').AsString := strForCid;
    cdsFornecedor.FieldByName('CID_ESTADO').AsString := strFor_UF;
    cdsFornecedor.FieldByName('FOR_FONE01').AsString := strForTel;
    cdsFornecedor.Post;

    TStringField(cdsFornecedor.FieldByName('FOR_FONE01')).EditMask := fRetMascaraFonePais;

    btnCancelarForn.Click;
  End;
end;

procedure TfrmCadProdutos.pGravaIteFor;
Var
  strSQL   : String;
  qryGen   : TUniQuery;
  strAutInc: String;
begin
  inherited;
  Try
    Try
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ITEFOR WHERE ITE_CODITE = :CODITE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := qryTabela.fieldbyname('ITE_CODITE').AsString;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITEFOR (';
      strSQL := strSQL + '   ITE_CODITE, ';
      strSQL := strSQL + '   ITE_CODITF, ';
      strSQL := strSQL + '   ITE_CODCNA, ';
      strSQL := strSQL + '   ITE_CODFOR, ';
      strSQL := strSQL + '   ITE_CODEMP, ';
      strSQL := strSQL + '   AUTOINCREM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODITF, ';
      strSQL := strSQL + '   :CODCNA, ';
      strSQL := strSQL + '   :CODFOR, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :AUTINC) ';

      cdsFornecedor.First;
      While Not cdsFornecedor.Eof Do
      Begin
        strAutInc := fRetAutoIncrem('ITEFOR',VS_strCodEmp);

        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('CODITE').AsString := qryTabela.fieldbyname('ITE_CODITE').AsString;
        qryGen.ParamByName('CODITF').AsString := cdsFornecedor.fieldbyname('ITE_CODITF').AsString;
        qryGen.ParamByName('CODFOR').AsString := cdsFornecedor.fieldbyname('ITE_CODFOR').AsString;
        qryGen.ParamByName('CODCNA').AsString := cdsFornecedor.fieldbyname('ITE_CODCNA').AsString;
        qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
        qryGen.ParamByName('AUTINC').AsString := strAutInc;
        qryGen.ExecSQL;

        cdsFornecedor.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadProdutos.pGravaIteFor]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadProdutos.pGravaDesMaxTabPre(strCodIte, strCodEmp: String);
  Var
    strSQL   : String;
    qryGen   : TUniQuery;
begin
  inherited;

  Try
    Try
      qryGen := fCriaQuery;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ITETBP WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ITETBP (';
      strSQL := strSQL + '   ITE_CODITE, ';
      strSQL := strSQL + '   ITE_CODEMP, ';
      strSQL := strSQL + '   ITE_TABPRE, ';
      strSQL := strSQL + '   ITE_DESMAX, ';
      strSQL := strSQL + '   ITE_DESMSU, ';
      strSQL := strSQL + '   ITE_DESMGE, ';
      strSQL := strSQL + '   ITE_DESVMM, ';
      strSQL := strSQL + '   ITE_DESSMM, ';
      strSQL := strSQL + '   ITE_DESGMM) ';
      strSQL := strSQL + ' VALUES( ';
      strSQL := strSQL + '   :CODITE, ';
      strSQL := strSQL + '   :CODEMP, ';
      strSQL := strSQL + '   :TABPRE, ';
      strSQL := strSQL + '   :DESMAX, ';
      strSQL := strSQL + '   :DESMSU, ';
      strSQL := strSQL + '   :DESMGE, ';
      strSQL := strSQL + '   :DESVMM, ';
      strSQL := strSQL + '   :DESSMM, ';
      strSQL := strSQL + '   :DESGMM) ';

      cdsDesMaxTabPre.First;
      While Not cdsDesMaxTabPre.Eof Do
      Begin
        qryGen.Close;
        qryGen.SQL.Clear;
        qryGen.SQL.Add(strSQL);
        qryGen.ParamByName('CODITE').AsString := strCodIte;
        qryGen.ParamByName('CODEMP').AsString := strCodEmp;
        qryGen.ParamByName('TABPRE').AsString := cdsDesMaxTabPre.Fieldbyname('ITE_TABPRE').AsString;
        qryGen.ParamByName('DESMAX').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESMAX').AsFloat;
        qryGen.ParamByName('DESMSU').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESMSU').AsFloat;
        qryGen.ParamByName('DESMGE').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESMGE').AsFloat;
        qryGen.ParamByName('DESVMM').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESVMM').AsFloat;
        qryGen.ParamByName('DESSMM').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESSMM').AsFloat;
        qryGen.ParamByName('DESGMM').AsFloat  := cdsDesMaxTabPre.Fieldbyname('ITE_DESGMM').AsFloat;
        qryGen.ExecSQL;

        cdsDesMaxTabPre.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadProdutos.pGravaDesMaxTabPre]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

Function TfrmCadProdutos.fProdutoEstaDesatualizado: Boolean;
  Var
    qryCadIte: TUniQuery;
Begin
  qryCadIte := fCriaQuery;

  qryCadIte.SQL.Text := 'SELECT ITE_HULALT, ITE_DTAALT FROM CADITE WHERE ITE_CODITE = ' + QuotedStr(dbeCodIte.Text);
  qryCadIte.Open;

  Result := (qryTabela.FieldByName('ITE_HULALT').Value <> qryCadIte.FieldByName('ITE_HULALT').Value) Or
            (qryTabela.FieldByName('ITE_DTAALT').Value <> qryCadIte.FieldByName('ITE_DTAALT').Value);

  FreeAndNil(qryCadIte);
End;

function TfrmCadProdutos.fProdutoxVeiculoPreenchido: Boolean;
begin
  Result := (
  (Not (edtDescMarVei.fEmptyStr))      Or
  (Not (edtDescModVei.fEmptyStr))      Or
  (Not fEmptyStr(mskAnoInicial.Text))  Or
  (Not fEmptyStr(mskAnoFin.Text))      Or
  (Not fEmptyStr(edtValvula.Text))     Or
  (Not fEmptyStr(edtCilindrada.Text))  Or
  (Not fEmptyStr(edtObservacoes.Text)) Or
  (Not fEmptyStr(edtPotencia.Text))    Or
  (Not cmbCombustivel.ItemIndex > 0))
end;

procedure TfrmCadProdutos.btnAlterarClick(Sender: TObject);
begin
  If blnCancelando Then
  	Exit;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      If Not objLockEdicao.fLock_Unlock('ALTERACAO_PRODUTO_' + dbeCodIte.Text, True, False) Then
      Begin
        pMensagemOk('Esse produto está sendo alterado em outra estação: ' + fGetHostLock('ALTERACAO_PRODUTO_' + dbeCodIte.Text + '%'));
        Exit;
      End;

      If fProdutoEstaDesatualizado Then
      Begin
        pCarregaItemNaTela;
        pCarregaItemNaTelaParte2;
      End;

      pDesabilitaCamposDaTabelaDePreco;

      inherited;
      objLojas.pCarregaPontoExposicao;
      blnInsert := False;
      If tbsExportaSite.TabVisible Then
        FPanelDadosECommerce.pCarregaDadosECommerce;
      frmManutencaoAbreviacoesLojas.pHabilitaEdicao(True);
      chkLimpaCamposVeiculo.Checked := True;
      pHabilitaLojas(True, False);

      objIteBar.pHabilitaEdicao(True);
      objIteMon.pHabilitaEdicao(True);
      objLocFis.pHabilitaEdicao(True);

      pControlaCampoComposicao;

      edtComLiq.Enabled := True;
      edtCusRea.Enabled := True;
      frmManutencaoAbreviacoesLojas.pHabilitaEdicao(True);

      chkPreDol.Enabled := True;

      If (blnAlterou) Then
      Begin
        qryIteGer.Edit;
        pgcDados.ActivePageIndex := 0;
    //    pHabilitaCodigo(dbeCodIte, dbeCodGru, False);
        pHabilitaCodigo(dbeCodIte, dbeCodDep, False);
        pHabilitaIcms;
        pDesabilitaCamposCadIte;

        If Not (fCfgSis('EMPGER', varBoolean)) Then
          pSetFocus(dbePreCom);

    (*
        btnGerarProdutosAcabados.Enabled := (fCfgSis('UTIIND', varBoolean) And // utiliza modulo industrial
                                            (qryTabela.FieldByName('ITE_CODDEP').AsString = fRetTipoDepartamento(qryTabela.FieldByName('ITE_CODDEP').AsString, 'PROGRA')));  //Departamento a granel
    *)

        //Se nao foi gerado produto acabado para o produto a granel em questao e
        //Se o produto em questao nao um produto acabado
        //Entao o departamento pode ser alterado, senao não.
        dbeCodDep.Enabled := (Not fExistirProdutoAcabado) And
                             (fEmptyStr(qryTabela.FieldByName('ITE_CODPAG').AsString));
      End;

      objIteBar.pCarregaDados(qryTabela.FieldByName('ITE_CODITE').AsString);
      objIteMon.pCarregaDados(qryTabela.FieldByName('ITE_CODITE').AsString);
      objLocFis.fCarregaLocalizacoes(qryTabela.FieldByName('ITE_CODITE').AsString,
                                     qryIteGer.FieldByName('ITE_LOCFIS').AsString);

      strLocAnt := dbeLocFis.Text;
      strSupAnt := dbeSupEst.Text;

      pAjustaFatorPreco(False);
      If (Pos(qryTabela.FieldByName('ITE_FATCOM').AsString, 'SN') <= 0) and (qryTabela.State <> dsBrowse) Then
        qryTabela.FieldByName('ITE_FATCOM').AsString := 'N';

      pHabilitaReaEnderecamento;
      lblFatCMP.Visible := fValidarFatorMadeira_X_Pecas;
      dbeIteFatCMP.Visible := lblFatCMP.Visible;
      If not dbeIteFatCMP.Visible then
        dbeIteFatCMP.Text := '0';

      objAtributos.pEdita();
      pnlBotoesAtributos.Enabled := True;

      pAjustaDolar;
      pMontaCdsIteCom;
      blnPreDol := chkPreDol.Checked;
      pOnStateChange;

      If blnTabPrd Then
      Begin
        frmTabelasDoItemGrid.cxvTabelas.OptionsData.Editing := False;
        frmTabelasDoItem.pHabilitaCampos(False);

        If Assigned(frmTabelasDoItem) Then
        Begin
          frmTabelasDoItem.cxvPrecos.OptionsData.Editing := True;
          frmManutencaoAbreviacoesLojas.cxTblAbrev.OptionsData.Editing := False;
        End;
      End;

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

  DBeCodIte.Enabled := False;
end;

function TfrmCadProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    blnValor: Boolean;
    strItem,
    strTraLoc,
    strDesIte   : String;
    strLote     : String;
    fltSalLot   : Double;
    fltSalLotML : Double;
    strCodMar: string;
    strDesMar: string;
    strCodMod: string;
    strDesMod: string;
    objProduto: TProdutos;
    qryConsulta: TUniQuery;

begin
  Result := True;
  objSender := Nil;
  strCodMar := '';
  strDesMar := '';
  strCodMod := '';
  strDesMod := '';

  strTraLoc := fCfgSIs('TRALOC');


  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CÓDIGO DO PRODUTO            *}
    {**************************************MV*}
    If (Sender = dbeCodIte) And (dbeCodIte.Enabled) Then
    Begin
      If (fEmptyStr(dbeCodIte.Text)) And (dbeCodIte.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If (fItemCadastrado(dbeCodIte.Text)) Then
      Begin
        fMensagem('', 'Esse código de item (' + dbeCodIte.Text + ') já está cadastrado!' + #13#10 +
                               'Verifique o cadastro de próximos códigos.', ['&Ok']);
        Result := False;
      End

      Else If (blnBuscaPorChave) And (Not blnCatalogo) Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
//          pLimparCampos;
//          pLimpaEdits;
          dbeDtaCad.Field.AsDateTime := VS_Date;
        End;
      End;
    End
    Else If (Sender = dbeVALDIA) And (dbeVALDIA.Visible) And  (not fEmptyStr(dbeVALDIA.Text))  Then
    Begin
      If  StrToInt(dbeVALDIA.Text) < 0 Then
      Begin
        fMensagem('', 'O Campo "Tempo de Validade do Produto(Em Dias)" não pode ser menor que zero.', ['&Ok']);
        Result := False;
       End;
    End
    Else If (Sender = dbeTOLREC) And (dbeTOLREC.Visible) And  (not fEmptyStr(dbeTOLREC.Text))  Then
    Begin
      If  (StrToInt(dbeTOLREC.Text) < 0)  Or (StrToInt(dbeTOLREC.Text) > 100) Then
      Begin
        fMensagem('', 'O Campo "Tolerância sobre Vencimento para Recebimento de Produtos (%)" deve estar entre 0 e 100%.', ['&Ok']);
        Result := False;
       End;
    End
    Else If Sender = dbeCICMDE Then
    begin
      If Pos(dbeCICMDE.Text, '_S_N') <= 0 Then
      begin
        fMensagem('', 'Valor errado para o campo " Calcular ICMS Desonerado ?" Valores esperados "S" ou "N".', ['&Ok']);
        Result := False;
      End;
    End

    Else If Sender = dbeCDPIOP Then
    begin
      If Pos(dbeCDPIOP.Text, '_S_N_F') <= 0 Then
      begin
        fMensagem('', 'Valor errado para o campo "Considerar desconto de PIS/COFINS na base de cálculo do ICMS Operações Próprias ?" Valores esperados "S", "N" ou "F"', ['&Ok']);
        Result := False;
      End;

    End

    Else If Sender = dbeDIDIOP Then
    begin
      If Pos(dbeDIDIOP.Text, '_S_N_F') <= 0 Then
      begin
        fMensagem('', 'Valor errado para o Campo "Considerar desconto de ICMS Desonerado na base de cálculo do ICMS Operações Próprias?" Valores esperados "S", "N" ou "F"', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeProduto) Then
    Begin

      objProduto:= TProdutos.Create;
      Try
        objProduto.blnCfgUsaComponente:= fCfgSis('ULTCMP', varBoolean);

        If (objProduto.blnCfgUsaComponente) Then
        Begin

          If dbeComponenteA.Text = 'S' Then
          Begin

            Try
              objProduto.strCodigoProduto   := dbeProduto.Text;

              objProduto.pValidaCodigoProdutoComponenteB;

              qryConsulta:= fCriaQuery(Self);
              Try
                qryConsulta.Close;
                qryConsulta.SQL.Clear;
                qryConsulta.SQL.Add('SELECT * FROM CADITE ');
                qryConsulta.SQL.Add('WHERE ITE_CODITE = :CODITE ');
                qryConsulta.SQL.Add('  AND ITE_COMPNB = "S" ');
                qryConsulta.ParamByNAme('CODITE').AsString:= dbeProduto.Text;
                qryConsulta.Open;

                If (qryConsulta.IsEmpty) Then
                Begin
                  Result := False;
                  edtDesProduto.tEXT:= '';
                  pMensagemOk('So é permitido vincular um item que configurado como Componente B!');
                  Exit;
                End;


              Finally
                FreeAndNil(qryConsulta);
              End;

            pCarregaProduto;
            Except
            On E : Exception Do
              Begin
                pMensagemOk(E.Message);
                edtDesProduto.Text:= '';
                Result := False;
                Exit;
              End;
            End;

            Try
              objProduto.strDescricaoProduto:= edtDesProduto.Text;
              objProduto.pValidaNomeProdutoComponenteB;
            Except
            On E : Exception Do
              Begin
                pMensagemOk(E.Message);
                edtDesProduto.Text:= '';
                Result := False;
                Exit;
              End;
            End;
          End
        End;
      Finally
        FreeAndNil(objProduto);
      End
    End

    Else If (Sender = DBEUSAPFD) Then
    Begin

      if (dbeObrCpf.Text = 'N') then
        qryTabela.FieldByName('ITE_USAPFD').AsString := 'N';
      If Pos(DBEUSAPFD.Text,'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo O campo Produto controlado pela polícia faderal deve ser S ou N', ['&OK']);
      End;
    End
    Else  If (Sender = DBEUSAPCV) Then
    Begin
      if (dbeObrCpf.Text = 'N') then
        qryTabela.FieldByName('ITE_USAPCV').AsString := 'N';

      If Pos(DBEUSAPCV.Text,'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo Produto controlado pela polícia civil deve ser S ou N', ['&OK']);
      End;
    End
    Else If (Sender = dbeObrCpf) Then
    begin
      pHabilitarControladoPolicia;
      if (dbeObrCpf.Text = 'N') then
      Begin
        qryTabela.FieldByName('ITE_USAPFD').AsString := 'N';
        qryTabela.FieldByName('ITE_USAPCV').AsString := 'N';
      End;
    end

    Else If (Sender = dbeCodEmpSug) Then
    Begin
      If pnlEmpSug.Visible Then
      Begin
        If Not fEmptyStr(dbeCodEmpSug.Text) Then
          dbeCodEmpSug.Text := fStrZero(dbeCodEmpSug.Text, 3);

        If fCfgSis('NOMEMP') = '2' Then
        Begin
          edtDesEmpSug.Text := fRetFantasiaEmpresa(dbeCodEmpSug.Text);
        End
        Else
        Begin
          edtDesEmpSug.Text := fRetNomeEmpresaSelec(dbeCodEmpSug.Text);
        End;

        If fEmptyStr(edtDesEmpSug.Text) And Not fEmptyStr(dbeCodEmpSug.Text)  Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não encontrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeProdutoDiluente) Then
    Begin
      objProduto:= TProdutos.Create;
      Try
        objProduto.blnCfgUsaComponente:= fCfgSis('ULTCMP', varBoolean);

        If (objProduto.blnCfgUsaComponente) Then
        Begin

          If dbeComponenteA.Text = 'S' Then
          Begin

            Try
              objProduto.strCodigoProduto   := dbeProduto.Text;
              objProduto.pValidaCodigoProdutoComponenteDiluente;

              qryConsulta:= fCriaQuery(Self);
              Try
                qryConsulta.Close;
                qryConsulta.SQL.Clear;
                qryConsulta.SQL.Add('SELECT * FROM CADITE ');
                qryConsulta.SQL.Add('WHERE ITE_CODITE = :CODITE ');
                qryConsulta.SQL.Add('  AND ITE_COMPNB = "N" ');
                qryConsulta.SQL.Add('  AND ITE_COMPNA = "N" ');
                qryConsulta.ParamByNAme('CODITE').AsString:= dbeProdutoDiluente.Text;
                qryConsulta.Open;

                If (qryConsulta.IsEmpty) Then
                Begin
                  Result := False;
                  edtDescProdutoDiluente.tEXT:= '';
                  pMensagemOk('Não é permitido vincular um item que já esteja definido como componente A ou Componente B!');
                  Exit;
                End;

              Finally
                FreeAndNil(qryConsulta);
              End;


              pCarregaProdutoDiluente;;
            Except
            On E : Exception Do
              Begin
                pMensagemOk(E.Message);
                edtDescProdutoDiluente.Text:= '';
                Result := False;
                Exit;
              End;
            End;


            Try
              objProduto.strDescricaoProduto:= edtDescProdutoDiluente.Text;
              objProduto.pValidaNomeProdutoComponenteDiluente;
            Except
            On E : Exception Do
              Begin
                pMensagemOk(E.Message);
                edtDescProdutoDiluente.Text:= '';
                Result := False;
                Exit;
              End;
            End;

          End;
        End;
      Finally
        FreeAndNil(objProduto);
      End
    End

    {*****************************************}
    {* VALIDA A LINHA / GRUPO                *}
    {**************************************MV*}
    Else If (Sender = dbeCodGru) Then
    Begin
      If fEmptyStr(dbeCodGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Linha / Grupo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Not fValidaLinhaGrupoCadGru(dbeCodGru.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Linha não é permitida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaLinGru;
        If qryConGru.FieldByName('GRU_CODGRU').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse grupo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    {*****************************************}
    {* VALIDA A DESCRIÇÃO DO PRODUTO         *}
    {**************************************MV*}
    Else If (Sender = dbeDesIte) Then
    Begin
      If fEmptyStr(dbeDesIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&Ok']);
        Result := False;

      End;
    End

    Else If (Sender = dbeConLot) And dbeConLot.Visible Then
    Begin
      If Pos(dbeConLot.Text,'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo produto com lote controlado na O.P. deve ser S ou N', ['&OK']);
      End;
    End

    Else If (Sender = dbeOBRBAR) Then
    Begin
      If Pos(dbeOBRBAR.Text,'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo Obrigatório o Código de Barras na Entrada Simplificada deve ser S ou N', ['&OK']);
      End;
    End

    Else If (Sender = dbeUtiAmp) And (dbeUtiAmp.Visible) Then
    Begin
      If (Pos(dbeUtiAmp.Text,'SN') <= 0) Then
      Begin
        Result := False;
        pgcDados.ActivePage := tbsFiscais;
        fMensagem('', 'O campo "Aplica legislação AMPARA" deve ser S ou N', ['&OK']);
      End;
      End

    Else If (Sender = dbeExpPok) Then
    Begin
      If Pos(dbeExpPok.Text, 'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo "Exporta tablet" deve informar S ou N', ['&OK']);
      End;
    End

    Else If (Sender = dbeRecDev) Then
    Begin
      If Pos(dbeRecDev.Text,'SN') <= 0 Then
      Begin
        Result := False;
        fMensagem('', 'O campo permitir receber devolução deste produto deve ser S ou N', ['&OK']);
      End;

      If Result And blnBuscaPorChave Then
      Begin
        pProximaPagina;
        pSetFocus(dbeCodAbr);
      End;
    End

    Else If (Sender = dbePatVid) And tbsAtributos.TabVisible Then
    Begin
      If Not fEmptyStr(dbePatVid.Text) And Not FileExists(dbePatVid.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Arquivo de vídeo de apresentação do produto não existe!', ['&Ok']);
        Result := False;
      End
      Else If Not fEmptyStr(dbePatVid.Text) And
              Not openPatVid.Filter.ToLower.Contains(ExtractFileExt(dbePatVid.Text).ToLower) Then
      Begin
        fMensagem('ATENÇÃO!', 'Extensão de arquivo de vídeo não permitida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodAtri) Then
    Begin
      If fEmptyStr(edtCodAtri.Text) Then
      Begin
        edtDesAtri.Clear;
      End
      Else
      Begin
        If blnBuscaPorChave Then
        Begin
          edtDesAtri.Text := fRetDescricaoAtributo(edtCodAtri.Text);
          If fEmptyStr(edtDesAtri.Text) Then
          Begin
            pMensagemOk('Atributo não econtrado!');
            edtCodAtri.Clear;
            Result := False;
          End
          Else
          Begin
            blnMudarFoco := False;
            pSetFocus(btnIncluiAtrib);
          End;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA MARCA              *}
    {**************************************MV*}
    Else If (Sender = dbeCodMar) Then
    Begin
      If fEmptyStr(dbeCodMar.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Marca deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaMarca;
        If qryConMar.FieldByName('MAR_CODMAR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Marca não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA LOC. SEPARAÇÃO     *}
    {**************************************MM*}
    Else If (Sender = dbeCodLse) And (dbeCodLse.Visible)  Then
    Begin
      If Not fEmptyStr(dbeCodLse.Text) Then
      Begin
        pCarregaLocSep;
        If qryConLse.FieldByName('LSE_CODIGO').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Localização de Separação não está cadastrada!', ['&Ok']);
          edtDesLse.Clear;
          Result := False;
        End;
      End

      Else edtDesLse.Clear;
    End

    {*****************************************}
    {* VALIDA dbeImpDir SE ESTIVER VISIVEL   *}
    {**************************************AF*}
    Else If (Sender = dbeImpDir) And fCfgSis('IMPDIR', varBoolean) Then
    Begin
      If Pos(dbeImpDir.Text,'SN') <= 0 Then
      Begin
        fMensagem('','O campo importação direta deve ser S ou N!',['&OK']);
        Result := False;
        pgcDados.ActivePage := tbsDadosSaida;
      End;
    End

    {*****************************************}
    {* VALIDA DBEPRAPEL SE ESTIVER VISIVEL   *}
    {**************************************GB*}
    Else If (Sender = dbePRapel) And blnURapel Then
    Begin
      If fStrToFloat(dbePRapel.Text) < 0 Then
      Begin
        fMensagem('','O campo Desconto Referente Rapel deve ser maior ou igual a zero!',['&OK']);
        Result := False;
        pgcDados.ActivePage := tbsComplementos;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR - ABA 7 *}
    {**************************************LU*}
    Else If (Sender = edtCodForn) Then
    Begin
      If blnBuscaPorChave Then
      Begin
        If fEmptyStr(edtCodForn.Text) Then
        Begin
          blnMudarFoco := False;
          pSetFocus(dbgFornecedor);
        End
        Else
        Begin
          pCarregaFornecedorIteFor;
          If fEmptyStr(edtNomForn.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;
    End

    Else If (Sender = edtCodForPal) Then
    Begin
      If edtCodForPal.Text <> '' Then
      Begin
        edtDesForPal.Text := fRetNomFornecedor(edtCodForPal.Text);
        If fEmptyStr(edtDesForPal.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If fCampoTabela('FOR_PALREC', 'CADFOR', ['FOR_CODFOR'] , [edtCodForPal.Text]) <> 'S' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está configurado com "Utiliza controle de cobrança por descarregamento de pallet no recebimento?" = Sim!', ['&Ok']);
          Result := False;
        End;
      End;
    End


    Else If (Sender = dbeObrNfe) Then
    Begin
      If Pos(dbeObrNfe.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo venda com obrigatoriedade de NFe deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeImpEti) And pnlImpEti.Visible Then
    Begin
      If Pos(dbeImpEti.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Imprimir Etiqueta na Entrada de Mercadorias deve ser S ou N!', ['&Ok']);
        Result := False;

        pgcDados.ActivePage := tbsDadosEntrada

      End;
    End

    {*****************************************}
    {* VALIDA dbeBarExp                      *}
    {**************************************MV*}
    ELse If (Sender = dbeBarExp) Then
    Begin
      If Pos(dbeBarExp.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Obrig. Cód. Barras Expedição deve ser S ou N!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    ELse If (Sender = bdeDesChk) And bdeDesChk.Visible Then
    Begin
      If Pos(bdeDesChk.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Desobrigar conferência no check-out deve ser S ou N!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}
    Else If (Sender = dbeCodFor) Then
    Begin
      If fEmptyStr(dbeCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaFornecedor;
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DA UNIDADE            *}
    {**************************************MV*}
    Else If (Sender = dbeCodUni) Then
    Begin
      If fEmptyStr(dbeCodUni.Text) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        fMensagem('ATENÇÃO!', 'A Unidade deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadUni;
        If fEmptyStr(edtDesUni.Text) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Essa Unidade não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          lblFatCMP.Visible := fValidarFatorMadeira_X_Pecas;
          dbeIteFatCMP.Visible := lblFatCMP.Visible;
          If not dbeIteFatCMP.Visible then
             dbeIteFatCMP.Text := '0';
          pUnidadeFracionada;
        End;
      End;
    End

    Else If (Sender = dbeUniCom) And (dbeUniCom.Visible) Then
    Begin
      If fEmptyStr(dbeUniCom.Text) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        fMensagem('ATENÇÃO!', 'A unidade de compra deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesUniCom.Text := fRetNomUnidade(dbeUniCom.Text);
        If fEmptyStr(edtDesUniCom.Text) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Essa unidade de compra não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeUniTri) And (dbeUniTri.Visible) Then
    Begin
      If fEmptyStr(dbeUniTri.Text) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        fMensagem('ATENÇÃO!', 'A unidade de tributação deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtDesUniTri.Text := fRetNomUnidade(dbeUniTri.Text);
        If fEmptyStr(edtDesUniTri.Text) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'Essa unidade de tributação não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeFatUTr) And (dbeFatUTr.Visible) Then
    Begin
      If fEmptyStr(dbeFatUTr.Text) Then
      Begin
        pgcDados.ActivePage := tbsGeral;
        fMensagem('ATENÇÃO!', 'O Fator de conversão da unidade de tributação deve ser preenchido!', ['&Ok']);
        dbeFatUTr.Field.AsFloat := 1;
        Result := False;
      End
      Else
      Begin
        If fStrToFloat(dbeFatUTr.Text) <= 0 Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!', 'O Fator de conversão da unidade de tributação deve ser maior que zero!', ['&Ok']);
          dbeFatUTr.Field.AsFloat := 1;
          Result := False;
        End;
      End;
    End

    Else if pnlDadosConcreto.Visible And (sender = dbeConBom) And not fEmptyStr(dbeConBom.Text) Then
    Begin
      Result := Pos(dbeConBom.Text, 'CB') > 0;
      If not Result then
        fMensagem('','Informe um valor válido C ou B!', ['&Ok']);
    End

    Else if pnlDadosConcreto.Visible And (sender = dbeFckDia) Then
    Begin
      Result := fStrToFloat(dbeFckDia.Text) >= 0;
      If not Result then
        fMensagem('','Informe um valor maior ou igual à zero!', ['&Ok']);
    End

    Else If (Sender = dbeCodLub) And (dbeComLub.Text = 'S') Then
    Begin
      If fEmptyStr(dbeCodLub.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher o código ANP. ' +
          'Caso o produto não tenha código ANP, preencher com 999999999.', ['&Ok']);
        Result := False;
      End
      Else If Length(dbeCodLub.Text) < 9 Then
      Begin
        fMensagem('ATENÇÃO!', 'O código ANP deve ter 9 digitos. ' +
          'Caso o produto não tenha código ANP, preencher com 999999999.', ['&Ok']);
        Result := False;
      End;

      if Not Result Then
        pgcDados.ActivePage := tbsFiscais;

    End

    Else If (Sender = dbeDesANP) And (dbeComLub.Text = 'S') Then
    Begin
      If fEmptyStr(dbeDesANP.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário preencher a descrição do produto conforme ANP', ['&OK']);
        Result := False;
      End;

      if Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeENIECB) Then
    Begin
      If Pos(dbeENIECB.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Enviar Indicador de Escala e Código do Benefício Fiscal? (NF-e 4.00)" deve ser S ou N!', ['&OK']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeUSABEF) Then
    Begin
      If Pos(dbeUSABEF.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Possui benefício fiscal?" deve ser S ou N!', ['&OK']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeIndEsc) Then
    Begin
      If Pos(dbeIndEsc.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Indicador de Escala Relevante deve ser S ou N!', ['&OK']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeCnpFme) Then
    Begin
      If (fEmptyStr(dbeCnpFme.Text)) And (dbeIndEsc.Text = 'N') Then
      Begin
        fMensagem('ATENÇÃO!', 'O CNPJ do fabricante da mercadoria deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else If (Not fEmptyStr(dbeCnpFme.Text)) Then
      Begin
        Result := fValidaCnpjCpf('1', dbeCnpFme.Text, False, True);
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeCdbFis) Then
    Begin
      If (blnBuscaPorChave) Then
      Begin
        pProximaPagina;
        pSetFocus(dbeLocFis);
      End;
    End

    Else If (Sender = dbeCDCEST) Then
    Begin
      If Not fEmptyStr(dbeCDCEST.Text) Then
      Begin
        edtCestDesc.Text := fRetDesCDCEST(dbeCDCEST.Text, dbeClaIpi.Text);
        If fEmptyStr(edtCestDesc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Classificação CEST não cadastrada com o NCM informado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        qryTabela.FieldByName('ITE_CDCEST').Value := Null;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeIteAti) Then
    Begin

      If Sender.Enabled Then
      Begin

        If Not fValidoSimNao((Sender As TDBEditFocus).Text) Then
        Begin
          fMensagem('','O Campo Ativo deve ser (S)im ou (N)ão', ['&OK']);
          Result := False;
        End

        Else If Not fInativarProduto Then
           Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeAtiCom)  Then
    Begin

      If Sender.Enabled Then
      Begin

        If Not fValidoSimNao((Sender As TDBEditFocus).Text) Then
        Begin
          Result := False;
        End

        Else If (dbeAtiCom.Text = 'S') And (dbeIteAti.Text <> 'S') Then
        Begin
          fMensagem('', 'O campo Ativo para Compras não pode ser (S)im, pois o item não está ativo!', ['&Ok']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsDadosEntrada;
      End;

    End

    Else If (Sender = dbeDiaFor) Then
    Begin

      If StrToIntDef(dbeDiaFor.Text, -1) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Dias para entrega do fornecedor deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeIpiSai) Then
    Begin
      If Not fEmptyStr(dbeIpiSai.Text) Then
      Begin
        If Not fValidaEscala(dbeIpiSai.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O IPI de Saida deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeCodAbr) Then
    Begin
      If fEmptyStr(dbeCodAbr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Abreviação Fiscal deve ser preenchida!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaAbreviacao;
        If qryConAbf.FieldByName('ABF_CODABF').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Not fAbreviacaoIcmsPermitidaParaNCM(dbeCodAbr.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais
      Else If Not blnAcaoGravacao Then
        frmManutencaoAbreviacoesLojas.pIguala(dbeCodAbr.Text, tcCODICM);
    End

    Else If (Sender = dbePesLiq) And dbePesLiq.Visible Then
    Begin
      If Not fEmptyStr(dbePesLiq.Text) Then
      Begin
        If Not fValidaEscala(dbePesLiq.Text, 0, -1) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Peso do Item deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbePesoIt) Then
    Begin
      If Not fEmptyStr(dbePesoIt.Text) Then
      Begin
        If Not fValidaEscala(dbePesoIt.Text, 0, -1) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Peso do Item deve ser maior ou igual a Zero!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      If tbsExportaSite.TabVisible And (FPanelDadosECommerce.dbeExpSit.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Peso do Item deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeDtaVal) And (pnlDtaVal.Visible) Then
    Begin
      Try
        qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime := StrToDate(dbeDtaVal.Text);
      Except
        qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime := 0;
      End;

      If qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Defina uma data de validade de preço válida.', ['&Ok']);
        Result := False;
      End
      Else If qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime <= fNow Then
      Begin
        fMensagem('ATENÇÃO!', 'A data de validade de preço deve ser maior que a data atual.', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;

      If (Not gpbFreTra.Visible) And Result Then
      Begin
        pProximaPagina;
        pSetFocus(dbeCodAbr);
      End;
    End

    Else If (Sender = dbeIteBas) Then
    Begin

      If (Pos(dbeIteBas.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto base deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End
      Else If (dbeIteBas.Text = 'S') Then
      Begin
        dbeProPig.Field.AsString := 'N';
        dbeProEmb.Field.AsString := 'N';
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeProEmb) Then
    Begin

      If (Pos(dbeProEmb.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto embalagem deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End
      Else If (dbeProEmb.Text = 'S') Then
      Begin
        dbeIteBas.Field.AsString := 'N';
        dbeProPig.Field.AsString := 'N';
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeEmpCar) And (dbeEmpCar.Visible) Then
    Begin
      If fEmptyStr(dbeEmpCar.Text) Then
      Begin
        edtDesEmpCar.Clear;
        dbeEmpCar.Field.Clear;
      End
      Else
      Begin
        edtDesEmpCar.Text := fRetNomeEmpresaSelec(dbeEmpCar.Text);
        If fEmptyStr(edtDesEmpCar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa responsável pelo carregamento e entrega do item não está cadastrada!', ['&Ok']);
          Result := False;
          pgcDados.ActivePage := tbsComplementos;
        End;
      End;
    End

    Else If (Sender = dbePeeFut) Then
    Begin
      If (Pos(dbePeeFut.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitir Venda com Entrega Futura com status "Aguardando Cliente" deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeSubProdPermiteVendaSeparado) and (pnlSubProdPermiteVendaSeparado.Visible) Then
    Begin
      If (Pos(dbeSubProdPermiteVendaSeparado.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', lblSubProdPermiteVendaSeparado.Caption + ' deve ser (S)im ou (N)ão!', ['&Ok']);
        pgcDados.ActivePage := tbsDadosSaida;
        pSetFocus(dbeSubProdPermiteVendaSeparado);
        Result := False;
      End;
    End

    Else If (Sender = dbePeFutP) Then
    Begin
      If (Pos(dbePeFutP.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitir Venda com Entrega Futura com status "Previsão de Entrega" deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeFaltaProduto) Then
    Begin
      If (Pos(dbeFaltaProduto.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitir Venda com Entrega Futura com status "Falta de Produto" deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;
    End


    Else If (Sender = dbeUsaBon) Then
    Begin

      If (Pos(dbeUsaBon.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permissão de uso em bonificação deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeUsaQuest) Then
    Begin

      If (fCfgSis('PONQUE', varBoolean)) and (Pos(dbeUsaQuest.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Quest fidelidade deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = edtDesCnd) And edtDesCnd.Visible Then
    Begin

      If (Pos(edtDesCnd.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Aplicar desconto da condição de pagamento deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;

    End

    Else If (Sender = dbeFatCom) And pnlFatCom.Visible Then
    Begin

      If (Pos(dbeFatCom.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Digitar complemento do produto deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeValObr) Then
    Begin

      If (Pos(dbeValObr.Text, 'SN') <= 0) Then
      Begin
        pgcDados.ActivePage := tbsComplementos;
        fMensagem('ATENÇÃO!', 'Validade Obrigatória deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeAbaMlt) Then
    Begin
      If (Pos(dbeAbaMlt.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Abastecer com Múltiplo de Compra deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeIndRev) And fCfgSis('CONIPI', varBoolean) Then
    Begin
      If (Pos(dbeIndRev.Text, 'IR') <= 0) Then
      Begin
        fMensagem('', 'Industrialização ou revenda deve ser I ou R!', ['&Ok']);
        pgcDados.ActivePage := tbsDadosSaida;
        Result := False;
      End;
    End

    Else If (Sender = dbeClaIpi) Then
    Begin
      If fEmptyStr(dbeClaIpi.Text) Then
      begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ser informado!', ['&Ok']);
        Result := False;
      End
      Else
      If (Length(dbeClaIpi.Text) <> MAX_CLAIPI) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação de IPI deve ter ' + IntToStr(MAX_CLAIPI) +  ' caracteres!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeProPig) Then
    Begin

      If (Pos(dbeProPig.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto pigmento deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End
      Else If (dbeProPig.Text = 'S') Then
      Begin
        dbeIteBas.Field.AsString := 'N';
        dbeProEmb.Field.AsString := 'N';
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End

    Else If (Sender = dbeComVar) Then
    Begin
      If Not fEmptyStr(dbeComVar.Text) Then
      Begin
        If Not fValidaEscala(dbeComVar.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Comissão de Varejo deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeNvlGir) Then
    Begin

      If (Pos(dbeNvlGir.Text, 'ABC') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Nível de Giro Geral de Estoque deve ser A, B ou C!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeNvlCri) Then
    Begin

      If Not (Pos(dbeNvlCri.Text, 'XYZ') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Nível de Criticidade de Estoque deve ser "X", "Y" ou "Z"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada;

    End

    Else If (Sender = dbeComAta) Then
    Begin
      If Not fEmptyStr(dbeComAta.Text) Then
      Begin
        If Not fValidaEscala(dbeComAta.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Comissão de Atacado deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeComDis) Then
    Begin
      If Not fEmptyStr(dbeComDis.Text) Then
      Begin
       If Not fValidaEscala(dbeComDis.Text, 0, 100) Then
       Begin
         fMensagem('ATENÇÃO!', 'A Comissão do Repres. Externo Distribuidor deve estar entre 0 e 100!', ['&Ok']);
         Result := False;
       End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeComDig) Then
    Begin
      If Not fEmptyStr(dbeComDig.Text) Then
      Begin
       If Not fValidaEscala(dbeComDig.Text, 0, 100) Then
       Begin
         fMensagem('ATENÇÃO!', 'A Comissão do Digitador deve estar entre 0 e 100!', ['&OK']);
         Result := False;
       End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeComPro) Then
    Begin

      If pnlComPro.Visible Then
      Begin

        If Not fEmptyStr(dbeComPro.Text) Then
        Begin
          If fStrToFloat(dbeComPro.Text) < 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'A Comissão do Profissional deve ser maior ou igual à zero!', ['&Ok']);
            Result := False;
          End;
        End

        Else dbeComPro.Text := '0,00';

      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeTpCoMc) Then
    Begin
      If pnlComMec.Visible Then
      Begin
        If (Pos(dbeTpCoMc.Text, 'P_V_') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O tipo de comissão do mecânico deve ser (P)ercentual ou (V)alor!', ['&OK']);
          Result := False;
        End;

        lblPerValMc.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeComMec) Then
    Begin

      If pnlComMec.Visible Then
      Begin
        If Not fEmptyStr(dbeComMec.Text) Then
        Begin
          If (dbeTpCoMc.Text = 'V') Then
          Begin
            If fStrToFloat(dbeComMec.Text) < 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'A comissão do mecânico deve ser maior ou igual a zero!', ['&OK']);
              Result := False;
            End;
          End
          Else
          Begin
            If Not fValidaEscala(dbeComMec.Text, 0, 100) Then
            Begin
              fMensagem('ATENÇÃO!', 'A comissão do mecânico deve estar entre 0 e 100!', ['&OK']);
              Result := False;
            End;
          End;
        End
        Else
          dbeComMec.Text := '0,00';
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeLarVid) Then
    Begin
      If (Not fEmptyStr(dbeLarVid.Text)) Then
      Begin
        If (fStrToFloat(dbeLarVid.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Largura deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaSugestao();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeAltVid) Then
    Begin
      If (Not fEmptyStr(dbeAltVid.Text)) Then
      Begin
        If (fStrToFloat(dbeAltVid.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False,False,False,True,False,False,True) + ' deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaSugestao();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeLaMaVi) Then
    Begin
      If (Not fEmptyStr(dbeLaMaVi.Text)) Then
      Begin
        If (fStrToFloat(dbeLaMaVi.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Largura Máxima deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaMaxima();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeAlMaVi) Then
    Begin
      If (Not fEmptyStr(dbeAlMaVi.Text)) Then
      Begin
        If (fStrToFloat(dbeAlMaVi.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False,False,True,True) + ' deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaMaxima();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeLarMin) Then
    Begin
      If (Not fEmptyStr(dbeLarMin.Text)) Then
      Begin
        If (fStrToFloat(dbeLarMin.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Largura Mínima deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else If (fStrToFloat(dbeLarMin.Text) > fStrToFloat(dbeLaMaVi.Text)) Then Begin
          fMensagem('ATENÇÃO!', 'Largura Mínima deve ser menor ou igual a Largura Máxima!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaMinima();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeAltMin) Then
    Begin
      If (Not fEmptyStr(dbeAltMin.Text)) Then
      Begin
        If (fStrToFloat(dbeAltMin.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False, False, False, False, False, True, False) + ' deve ser maior ou igual a zero!', ['&Ok']);
          Result := False;
        End Else If (fStrToFloat(dbeAltMin.Text) > fStrToFloat(dbeAlMaVi.Text)) Then Begin
          fMensagem('ATENÇÃO!', fRetornaInfMedVIDRO(False, False, False, False, False, True, False) + ' deve ser menor ou igual a ' + fRetornaInfMedVIDRO(False,False,True,True) + '!', ['&Ok']);
          Result := False;
        End Else Begin
          pCalcularAreaMinima();
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If ((Sender = dbeQtPPro) And (pnlQtPPro.Visible)) Then
    Begin
      If Not fEmptyStr(dbeQtPPro.Text) Then
      Begin
        If Not (fStrToFloat(dbeQtPPro.Text) >= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de pontos para profissional deve ser maior ou igual à zero !', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('','A quantidade de pontos para profissional deve ser informada !',['&O K']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeCnv_ML) And (pnlCnv_ML.Visible) Then
    Begin

      If (fEmptyStr(dbeCnv_ML.Text)) Then
      Begin
        dbeCnv_ML.Field.AsFloat := 0.0;
      End
      Else If (fStrToFloat(dbeCnv_ML.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A fator de conversão para ML deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos

    End

    Else If (Sender = dbeFatCnv) Then
    Begin

      If (fEmptyStr(dbeFatCnv.Text)) Then
      Begin
        dbeFatCnv.Field.AsFloat := 0.0;
      End
      Else If (fStrToFloat(dbeFatCnv.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A fator de conversão deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;
//      Else If (Not pnlSitPro.Visible) And (Not pnlDensid.Visible) Then
//      Begin
//        pProximaPagina;
//        pSetFocus(dbeIndRev);
//      End;

    End

    Else If (Sender = dbeSitPro) Then
    Begin

      If pnlSitPro.Visible Then
      Begin
        If fEmptyStr(dbeSitPro.Text) Then
        Begin
          edtSitPro.Clear;
          dbeSitPro.Field.Clear;
        End Else
        Begin
          edtSitPro.Text := fRetNomSituacaoProduto(dbeSitPro.Text);
          If fEmptyStr(edtSitPro.Text) Then
          Begin
            pMensagemOk('Código da Situação do Produto não econtrado!');
            Result := False;
          End;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsComplementos;
//        Else
//        Begin
//          If (Not pnlDensid.Visible) and (not pnlCodCom.Visible) and (not pnlRapel.Visible) then
//          Begin
//            pProximaPagina;
//            pSetFocus(dbeIndRev);
//          end;
//        End;
      End;

    End

    Else If (Sender = dbeCodFab) Then
    Begin

      If blnPreMat Then
        pProximaPagina;

    End

    Else If (Sender = dbeGarant) Then
    Begin

      If (fEmptyStr(dbeGarant.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Tempo de Garantia!', ['&Ok']);
        Result := False;
      End Else
      If (fStrToFloat(dbeGarant.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tempo de Garantia deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeRspGar) And (pnlGarant.Visible) Then
    Begin
      If (Pos(dbeRspGar.Text, 'L_F_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Responsável pela Garantia deve ser (L) ou (F)!', ['&Ok']);
        Result := False;
      End;
      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;

    End

    Else If (Sender = dbeMesGir) Then
    Begin

      If (fEmptyStr(dbeMesGir.Text)) Then
        dbeMesGir.Field.AsFloat := 0.0
      Else If (fStrToFloat(dbeMesGir.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Meses sem venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbePraMin) And pnlPraMin.Visible Then
    Begin

      If (fEmptyStr(dbePraMin.Text)) Then
        dbePraMin.Field.AsFloat := 0.0
      Else If (fStrToFloat(dbePraMin.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O prazo médio mínimo para cálculo de juros deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = dbeMsgLv2) Then
    Begin

    End

    Else If Sender = dbeGruCmp Then
    Begin

      If Not fEmptyStr(dbeGruCmp.Text) Then
      Begin
        edtDesCmp.Text := fRetDescGrupoCompra(dbeGruCmp.Text);

        If fEmptyStr(edtDesCmp.Text) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO', 'O Grupo de Compra não está cadastrado', ['OK']);
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsDadosEntrada

      End;

    End

    Else If (Sender = dbeMultCompra) Then
    Begin
      If (fStrToFloat(dbeMultCompra.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Múltiplo de Compra deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeMultVenda) Then
    Begin
      If (fStrToFloat(dbeMultVenda.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Múltiplo de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;
    End

    Else If (Sender = cmbMarBas) Then
    Begin

    End

    Else If (Sender = dbeCodFin) Then
    Begin

    End

    Else If (Sender = dbeObrCpf) And (dbeObrCpf.Enabled) Then
    Begin
      If Not fValidoSimNao(dbeObrCpf.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Venda com obrigatoriedade de CPF/CNPJ deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeObrIba) And (dbeObrIba.Enabled) Then
    Begin
      If Not fValidoSimNao(dbeObrIba.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Venda com obrigatoriedade de código IBAMA no cliente deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeLocFis) Then
    Begin

      If pnlLoc.Visible Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(dbeLocFis.Text)) Then
          Begin

            blnValidaLocFis := True;

            If fEmptyStr(fRetNomLocFisica(dbeLocFis.Text)) Then
            Begin
              pgcDados.ActivePage := tabLocalizacao;
              pMensagemOk('Localização Física não encontrada!');
              Result := False;
            End;

            If (strTraLoc <> 'N') And (Result) Then
            Begin

              If objCadLot.fTemProdutoComLocFisica(dbeLocFis.Text, strItem, fltSalLot, fltSalLotML, dbeCodIte.Text) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' já está cadastrado com essa localização física!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End

              Else If objCadLot.fTemProdutoComLocAdicional(dbeLocFis.Text, strItem, fltSalLot, fltSalLotML, dbeCodIte.Text) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' já está cadastrado com essa localização física adicional!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End

              Else If objCadLot.fTemLoteComLocFisica(dbeLocFis.Text, strItem, strLote, fltSalLot, fltSalLotML) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End;

            End;

            blnValidaLocFis := False;

          End;

        End
        Else
        Begin

          If Not fEmptyStr(dbeLocFis.Text) Then
          Begin

            strDesIte := fLocFisUtilizada(dbeLocFis.Text, dbeCodIte.Text);

            If (Not fEmptyStr(strDesIte)) And (strTraLoc <> 'N') Then
            Begin
              fMensagem('ATENÇÃO!', 'Localização física utilizada no produto: ' + #13 + strDesIte, ['&Ok']);
              pgcDados.ActivePage := tabLocalizacao;
              If (strTraLoc = 'T') Then
                Result := False;
            End;

          End;

        End;

        If Result And (Not fEmptyStr(dbeLocFis.Text)) And
           objLocFis.fTemLocalizacaoAdicional(dbeLocFis.Text) Then
        Begin
          pMensagemOk('A Localização Física ' + dbeLocFis.Text + ' já está cadastrada em Localizações Físicas Adicionais!');
          Result := False;
        End;

        If Result Then
          objLocFis.pSetaLocalizacaoPrincipal(dbeLocFis.Text);

      End;

    End

    Else If (Sender = dbeSupEst) Then
    Begin

      If pnlLoc.Visible Then
      Begin

        If blnCadLoc Then
        Begin

          If (Not fEmptyStr(dbeSupEst.Text)) Then
          Begin

            blnValidaLocFis := True;

            If fEmptyStr(fRetNomLocFisica(dbeSupEst.Text)) Then
            Begin
              pgcDados.ActivePage := tabLocalizacao;
              pMensagemOk('Localização de Super Estoque não encontrada!');
              Result := False;
            End

            Else

            If (strTraLoc <> 'N') And (Result) Then
            Begin

              If objCadLot.fTemProdutoComLocFisica(dbeSupEst.Text, strItem, fltSalLot, fltSalLotML, dbeCodIte.Text, True) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' já está cadastrado com essa localização física!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End

              Else If objCadLot.fTemProdutoComLocAdicional(dbeSupEst.Text, strItem, fltSalLot, fltSalLotML, dbeCodIte.Text) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' já está cadastrado com essa localização física adicional!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End

              Else If objCadLot.fTemLoteComLocFisica(dbeSupEst.Text, strItem, strLote, fltSalLot, fltSalLotML) Then
              Begin
                pgcDados.ActivePage := tabLocalizacao;
                pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                            ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física!');
                If (strTraLoc = 'T') Then
                  Result := False;
              End;
            End;

            blnValidaLocFis := False;
          End;
        End;
      End;
    End

    Else If (Sender = dbeAbfPis) Then
    Begin
      If fEmptyStr(dbeAbfPis.Text) Then
      Begin
        If (fCfgSIs('SPEDPC') = 'S') And (Not blnSimPau) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório informar a abreviação fiscal do PIS!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesAbfPis.Clear;
      End
      Else
      Begin
        edtDesAbfPis.Text := fRetDesAbfPis(dbeAbfPis.Text);
        If fEmptyStr(edtDesAbfPis.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação de PIS não cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Not fAbreviacaoPisPermitidaParaNCM(dbeAbfPis.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais
      Else If Not blnAcaoGravacao Then
        frmManutencaoAbreviacoesLojas.pIguala(dbeAbfPis.Text, tcCODPIS);
    End

    Else if (Sender = dbeAbfCof) Then
    Begin
      If fEmptyStr(dbeAbfCof.Text) Then
      Begin
        If (fCfgSIs('SPEDPC') = 'S') And (Not blnSimPau) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório informar a abreviação fiscal do COFINS!', ['&Ok']);
          Result := False;
        End
        Else
          edtDesAbfCof.Clear;
      End
      Else
      Begin
        edtDesAbfCof.Text := fRetDesAbfCof(dbeAbfCof.Text);
        If fEmptyStr(edtDesAbfCof.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação de COFINS não cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Not fAbreviacaoCofinsPermitidaParaNCM(dbeAbfCof.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais
      Else If Not blnAcaoGravacao Then
        frmManutencaoAbreviacoesLojas.pIguala(dbeAbfCof.Text, tcCODCOF);

    End

    Else If (Sender = dbeAbfCon) and (pnlAbrevContabil.Visible) then
    begin
      If fEmptyStr(dbeAbfCon.Text) Then
      Begin
        edtDesAbfCon.Clear;
      End
      Else
      Begin
        edtDesAbfCon.Text := fCampoTabela('COG_DESCRI', 'ABFCOG', ['COG_CODIGO'], [dbeAbfCon.Text], False);
        If fEmptyStr(edtDesAbfCon.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação Contábil não cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    end

    Else If (Sender = dbeAbfIpi) Then
    Begin
      If fEmptyStr(dbeAbfIpi.Text) Then
      Begin
        edtDesAbfIpi.Clear;
      End
      Else
      Begin
        edtDesAbfIpi.Text := fRetDesAbfIpi(dbeAbfIpi.Text);
        If fEmptyStr(edtDesAbfIpi.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Abreviação de IPI não cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If Not fAbreviacaoIpiPermitidaParaNCM(dbeAbfIpi.Text, dbeClaIpi.Text, dbeExcIpi.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Abreviação não é permitida para o NCM ' + dbeClaIpi.Text + '!', ['&Ok']);
          Result := False;
        End;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais
      Else If Not blnAcaoGravacao Then
        frmManutencaoAbreviacoesLojas.pIguala(dbeAbfIpi.Text, tcCODIPI);

    End

    Else If (Sender = dbeAplica) Then
    Begin

    End

    Else If (Sender = dbeCodDep) Then
    Begin

      If (fEmptyStr(dbeCodDep.Text)) Then
      Begin
        edtDesDep.Clear;
        dbeCodDep.Field.Clear;

        If fCfgSis('DEPOBR', VarBoolean) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!','Informe o departamento do produto!',['&OK']);
          Result := False;
        End;

      End
      Else
      Begin
        edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[dbeCodDep.Text]);

        If fEmptyStr(edtDesDep.Text) Then
        Begin
          pgcDados.ActivePage := tbsGeral;
          fMensagem('ATENÇÃO!','Esse departamento não está cadastrado!',['&OK']);
          Result := False;
        End;

      End;

      If Result Then
      Begin
        pHabilitaCamposMateriaPrima;
      End Else
      Begin
        pgcDados.ActivePage := tbsGeral;
      End;

    End

    Else If (Sender = edtCodLayOrdInd) Then
    Begin
      If (fEmptyStr(edtCodLayOrdInd.Text)) Then
      Begin
        edtNomLayOrdInd.Clear;
        edtCodLayOrdInd.Clear;
      End
      Else
      Begin
        edtNomLayOrdInd.Text := fRetornaDescricaoLayoutEtq(edtCodLayOrdInd.Text);

        If fEmptyStr(edtNomLayOrdInd.Text) Then
        Begin
          pgcDados.ActivePage := tbsProdAcab;
          fMensagem('ATENÇÃO!','Layout de etiqueta para ordem de produção industrial inválido!',['&OK']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = dbeCodLayOrdPro) Then
    Begin
      If (fEmptyStr(dbeCodLayOrdPro.Text)) Then
      Begin
        edtNomLayOrdPro.Clear;
        dbeCodLayOrdPro.Field.Clear;
      End
      Else
      Begin
        edtNomLayOrdPro.Text := fRetornaDescricaoLayoutEtq(dbeCodLayOrdPro.Text);

        If fEmptyStr(edtNomLayOrdPro.Text) Then
        Begin
          pgcDados.ActivePage := tbsComplementos;
          fMensagem('ATENÇÃO!','Layout de etiqueta para ordem de produção inválido!',['&OK']);
          Result := False;
        End;

      End;

      If Result Then
      Begin
        pProximaPagina;
        pSetFocus(dbeIndRev);
      end;
    End

    Else If (Sender = dbeCodGpc) And dbeCodGpc.Visible Then
    Begin
      If (fEmptyStr(dbeCodGpc.Text)) Then
      Begin
        edtDesGpc.Clear;
        dbeCodGpc.Field.Clear;
      End
      Else
      Begin
        edtDesGpc.Text := fRetNomGpc(dbeCodGpc.Text);

        If fEmptyStr(edtDesGpc.Text) Then
        Begin
          pgcDados.ActivePage := tbsComplementos;
          fMensagem('ATENÇÃO!','Código da Classificação Global do Produto - GPC inválido!',['&OK']);
          Result := False;
        End;

      End;
    End

    ELse If (Sender = dbeAgroto) And (pnlAgroto.Visible) Then
    Begin
      If Pos(dbeAgroto.Text, 'SN') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Agrotóxico deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeCodOnu) and (pnlClaOnu.Visible)Then
    Begin
      if not fEmptyStr(dbeCodOnu.Text) then
      Begin
        edtDesOnu.Text := fRetDescClassificacaoOnu(dbeCodOnu.Text);
        if fEmptyStr(edtDesOnu.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação ONU não está cadastrada!', ['&Ok']);
          Result := False;
        End;

      End
      else
      Begin
        edtDesOnu.Clear;
        dbeCodOnu.DataSource.DataSet.FieldByName('ITE_CODONU').Clear;
      End;

    End

    Else If (Sender = dbeCodDic) And (blnSergipe) Then
    Begin
      edtDesDic.Text := fRetDesDic(dbeCodDic.Text);
      if (not fEmptyStr(dbeCodDic.Text)) And fEmptyStr(edtDesDic.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código DIC informado não cadastrado!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = dbePer_CI) Then
    Begin
      If Not fEmptyStr(dbePer_CI.Text) Then
      Begin
        If Not fValidaEscala(dbePer_CI.Text, 0, 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Percentual do Conteúdo de Importação (CI) deve estar entre 0 e 100!', ['&Ok']);
          Result := False;
        End
      End
      Else
        dbePer_CI.Field.AsFloat := 0.00;

      If Not Result Then
        pgcDados.ActivePage := tbsFiscais;
    End

    Else If (Sender = dbeNumFCI) Then
    Begin
      If (Not ((edtProPCD.Visible) Or (dbeUtiAmp.Visible))) Then
      Begin
        pProximaPagina;
        pSetFocus(dbeLocFis);
      End;
    End

    Else If (Sender = dbeCodCom) And (pnlCodCom.Visible) Then
    Begin
//      If (dbeCodDep.Text = fCfgSis('PROACA', varString)) Then //comentado porque o tipo de departamento esta na tabela e nao mais na aba das configuracoes Industrial
      If Not fEmptyStr(dbeCodDep.Text) Then
      Begin

        If (dbeCodDep.Text = fRetTipoDepartamento(dbeCodDep.Text, 'PROACA')) Then
        Begin

          If (fEmptyStr(dbeCodCom.Text)) Then
          Begin
            edtDesCom.Clear;
            (*
            pgcDados.ActivePage := tbsComplementos;
            fMensagem('ATENÇÃO!', 'Quando o for produto acabado o campo composição deve ser preenchido!', ['&O k']);
            Result := False;
            *) // NAO SERÁ MAIS OBRIGATÓRIO
          End
          Else
          Begin
            edtDesCom.Text := fRetDescricaoComposicao(dbeCodCom.Text);

            If (fEmptyStr(edtDesCom.Text)) Then
            Begin
              pgcDados.ActivePage := tbsProdAcab;
              fMensagem('ATENÇÃO!', 'Essa composição não está cadastrada!', ['&O k']);
              Result := False;
            End;

          End;
        End
        Else
        Begin
          dbeCodCom.Clear;
          edtDesCom.Clear;
        end;
      End;
    End

    Else If (Sender = dbeRprEnt) Then
    Begin
      If (Pos(dbeRprEnt.Text,'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permitir redução de preços na entrada deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbePesagemObr) And (dbePesagemObr.Visible) Then
    Begin
      If (Pos(dbePesagemObr.Text,'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Controlar pesagem obrigatória ( Saída ) deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida
    End

    Else If (Sender = dbePesagemObrEnt) And (dbePesagemObr.Visible) Then
    Begin
      If (Pos(dbePesagemObrEnt.Text,'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Controlar pesagem obrigatória ( Entrada ) deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    {*******************************************}
    {* VALIDA INFORMAÇÕES DA BALANÇA           *}
    {****************************************MV*}
    Else If (Sender = dbeDesFlz) And (blnBuscaPorChave) Then
    Begin
      If (fEmptyStr(dbeDesFlz.Text)) Then
        blnValor := False
      Else
        blnValor := True;

      dbeRecFlz.Enabled := blnValor;
      dbePreBal.Enabled := blnValor;
      dbeSetFlz.Enabled := blnValor;
      dbeBarFlz.Enabled := blnValor;
      dbeCodFlz.Enabled := blnValor;
      dbeTecFlz.Enabled := blnValor;
      dbeValFlz.Enabled := blnValor;
      dbeTipFlz.Enabled := blnValor;
      dbePorFlz.Enabled := blnValor;
      dbeValCal.Enabled := blnValor;
      dbePerCal.Enabled := blnValor;
      dbeValEne.Enabled := blnValor;
      dbePerEne.Enabled := blnValor;
      dbeVGorTa.Enabled := blnValor;
      dbePGorTa.Enabled := blnValor;
      dbeObsBal.Enabled := blnValor;
      dbeInfExt.Enabled := blnValor;
      dbeVCarbo.Enabled := blnValor;
      dbePCarbo.Enabled := blnValor;
      dbeVProte.Enabled := blnValor;
      dbePProte.Enabled := blnValor;
      dbeVGorTo.Enabled := blnValor;
      dbePGorTo.Enabled := blnValor;
      dbeVGorSa.Enabled := blnValor;
      dbePGorSa.Enabled := blnValor;
      dbeVColes.Enabled := blnValor;
      dbePColes.Enabled := blnValor;
      dbeVFibAl.Enabled := blnValor;
      dbePFibAl.Enabled := blnValor;
      dbeVCalci.Enabled := blnValor;
      dbePCalci.Enabled := blnValor;
      dbeVFerro.Enabled := blnValor;
      dbePFerro.Enabled := blnValor;
      dbeVSodio.Enabled := blnValor;
      dbePSodio.Enabled := blnValor;

      If (fEmptyStr(dbeDesFlz.Text)) Then
        pProximaPagina;
    End

    Else If (Sender = dbeRecFlz) Then
    Begin
      //
    End

    Else If (Sender = dbeSetFlz) And (Not fEmptyStr(dbeDesFlz.Text)) Then
    Begin

      If (fEmptyStr(dbeSetFlz.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O setor da balança deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaCadSfz;
        If fEmptyStr(edtDesSet.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse setor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeCodFlz) Then
    Begin
      //
    End

    Else If (Sender = dbeTecFlz) Then
    Begin
      //
    End

    Else If (Sender = dbeValFlz) Then
    Begin
      //
    End

    Else If (Sender = dbeTipFlz) And (Not fEmptyStr(dbeDesFlz.Text)) Then
    Begin

      If tbsDadosBalanca.TabVisible Then
      Begin
        Result := (Pos(dbeTipFlz.Text, 'UP') > 0);

        If Not Result Then
        Begin
          pgcDados.ActivePage := tbsDadosBalanca;
          pMensagemOk('Informe o Tipo de Venda para a Balança!');
        End;
      End;

    End

    Else If (Sender = dbePorFlz) Then
    Begin
      //
    End

    Else If (Sender = dbeValCal) Or
            (Sender = dbePerCal) Or
            (Sender = dbeValEne) Or
            (Sender = dbePerEne) Or
            (Sender = dbeVCarbo) Or
            (Sender = dbePCarbo) Or
            (Sender = dbeVProte) Or
            (Sender = dbePProte) Or
            (Sender = dbeVColes) Or
            (Sender = dbePColes) Or
            (Sender = dbePFibAl) Or
            (Sender = dbeVSodio) Or
            (Sender = dbePSodio) Then
    Begin

      If fEmptyStr(TDBEditFocus(Sender).Text) Then
        TDBEditFocus(Sender).Text := '0';

      Result := (StrToInt(TDBEditFocus(Sender).Text) >= 0);
    End

    Else If (Sender = dbeVGorTo) Or
            (Sender = dbePGorTo) Or
            (Sender = dbeVGorSa) Or
            (Sender = dbePGorSa) Or
            (Sender = dbeVGorTa) Or
            (Sender = dbePGorTa) Or
            (Sender = dbeVCalci) Or
            (Sender = dbePCalci) Or
            (Sender = dbeVFerro) Or
            (Sender = dbeVFibAl) Or
            (Sender = dbePFerro) Then
    Begin

      If fEmptyStr(TDBEditFocus(Sender).Text) Then
        TDBEditFocus(Sender).Text := '0';

      Result := (fStrToFloat(TDBEditFocus(Sender).Text) >= 0);
    End

    Else If Sender = dbeInflam Then
    Begin
      If Not (Pos(dbeInflam.Text,'SN') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto Inflamável deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;
    End

    Else If (Sender = dbeIteCCR) And pnlIteCCR.Visible Then
    Begin
      If Not (Pos(dbeIteCCR.Text,'SN') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto concreto deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End
      Else If (dbeIteCCR.Text = 'S') And (Not fItemEstrutura(dbeCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Este produto não pode ser informado como concreto, '+
                              'pois o mesmo não é um produto estrutura!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;
    End

    Else If (Sender = dbeBNDES) And pnlCertEPI_BNDES.Visible Then
    Begin

      If Not (Pos(dbeBNDES.Text,'SN') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Convenio BNDES deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End

    End


    Else If (Sender = dbeMaxBri) Then
    Begin

      If dbeMaxBri.Visible Then
      Begin
        If fStrToFloat(dbeMaxBri.Text) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido valores informados menores que 0 (zero)!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If (Sender = dbeNotEsp) And dbeNotEsp.Visible Then
    Begin
      If Not (Pos(dbeNotEsp.Text,'SN') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Divisível" deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida
    End

    Else If (Sender = dbeTipFre) And gpbFreTra.Visible Then
    Begin
      If Not (Pos(dbeTipFre.Text,'PFU') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Tipo de frete deve ser "P", "F" ou "U"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosSaida;

    End

    Else If (Sender = dbeVlCFre) And gpbFreTra.Visible Then
    Begin

      If (fStrToFloat(dbeVlCFre.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Valor do frete não pode ser negativo!', ['&Ok']);
        Result := False;
      End

      Else If (Not gpbMinTab.Visible) Then
      Begin
        pProximaPagina;
        pSetFocus(dbeCodAbr);
      End;

    End

    Else If (AnsiStartsStr('dbeMinTb', Sender.Name)) And gpbMinTab.Visible Then
    Begin
      If fStrToFloat(TDBEditFocus(Sender).Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade mínima não pode ser negativa!', ['&Ok']);
        Result := False;
      End

      Else If RightStr(Sender.Name, 1) = IntToStr(intUltTab) Then
      Begin
        pProximaPagina;
        pSetFocus(dbeCodAbr);
      End;
    End

    Else If (Sender = dbeCodGpr) Then
    Begin
      If fEmptyStr(dbeCodGpr.Text) Then
      Begin
        edtDesGpr.Clear;
      End
      Else
      Begin
        edtDesGpr.Text := fRetNomeGrupoPrecos(dbeCodGpr.Text);
        If fEmptyStr(edtDesGpr.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse grupo de preços não está cadastrado!', ['&Ok']);
          Result := False;
          pgcDados.ActivePage := tbsComplementos;
        End;
      End;
    End

    Else If (Sender = dbePrdGru) Then
    Begin
      If fEmptyStr(dbePrdGru.Text) Then
      Begin
        edtDesPrdPro.Clear;
      End
      Else
      Begin
        edtDesPrdPro.Text := fRetNomeGrupoProduto(dbePrdGru.Text);
        If fEmptyStr(edtDesPrdPro.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse grupo de produto não está cadastrado!', ['&Ok']);
          Result := False;
          pgcDados.ActivePage := tbsComplementos;
        End;
      End;
    End


    Else If (Sender = dbeEsMiDg) And dbeEsMiDg.Visible Then
    Begin

      If Not (Pos(dbeEsMiDg.Text,'DG') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Opção para estoque mínimo deve ser "G" ou "D"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeAcoObj) Then
    Begin

      If blnBuscaPorChave And (not dbeReaEnd.Enabled) And (not dbeRastre.Visible) And (not pnlConLot.Visible) Then
      Begin
        pProximaPagina;
        pSetFocus(dbeCodAbr);
      End;

    End

    Else If Sender = dbeMltSpo Then
    Begin
      If Not (Pos(dbeMltSpo.Text, 'SN') > 0) Then
      Begin
          fMensagem('ATENÇÃO!', 'Opção para "Permitir spool de tranferência fora do multiplo de compra?" deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsDadosEntrada
    End

    Else If (Sender = dbeReaEnd) Then
    Begin

      If dbeReaEnd.Enabled Then
      Begin
        If Not (Pos(dbeReaEnd.Text,'SN') > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Opção para "Realizar endereçamento do produto?" deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsDadosEntrada
        Else
        If blnBuscaPorChave And (not pnlConLot.Visible) Then
        Begin
          pProximaPagina;
          pSetFocus(dbeCodAbr);
        End;
      End;

    End


    Else If (Sender = dbeRastre) Then
    Begin

      If dbeRastre.Visible Then
      Begin
        If Not (Pos(dbeRastre.Text,'SN') > 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Opção para "Utilizar Controle de Rastreabilidade do produto?" deve ser "S" ou "N"!', ['&Ok']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsDadosEntrada
        Else
        If blnBuscaPorChave And (not pnlConLot.Visible) Then
        Begin
          pProximaPagina;
          pSetFocus(dbeCodAbr);
        End;

      End;
    End

    Else If (Sender = dbePraVal) And dbePraVal.Visible Then
    Begin
      if dbePraVal.Text = '' then
        dbePraVal.Field.AsInteger := 0;

      If StrToInt(dbePraVal.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um valor maior ou igual à zero em meses!', ['&Ok']);
        Result := False;
        pgcDados.ActivePage := tbsProdAcab;
      End;
    End

    Else If (Sender = dbeDensid) And pnlDensid.Visible Then
    Begin
      if dbeDensid.Text = '' then
        dbeDensid.Field.AsFloat := 0.0;

      If fStrToFloat(dbeDensid.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe um valor maior ou igual à zero!', ['&Ok']);
        Result := False;
        pgcDados.ActivePage := tbsComplementos;
      End;
    End

    Else If (Sender = dbeSitPrd) And (pnlSitPrd.Visible) And (tbsProdAcab.TabVisible) Then
    Begin
      If Not (Pos(dbeSitPrd.Text,'12') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Situação para análise de produção deve ser "1" ou "2"!', ['&OK']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsProdAcab;
    End

    Else If (Sender = dbePerSol) Then
    Begin

      If tbsProdAcab.TabVisible Then
      Begin

        If (fStrToFloat(dbePerSol.Text) < 0) Or (fStrToFloat(dbePerSol.Text) > 100)  Then
        Begin
          pgcDados.ActivePage := tbsProdAcab;
          fMensagem('ATENÇÃO!', 'O percentual de Sólidos deve estar entre 0 e 100%!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeECarga) Then
    Begin

      If (Pos(dbeECarga.Text, '012') <= 0) And (pnlMateriaPrima.Visible)  And (tbsProdAcab.TabVisible) Then
      Begin
        pgcDados.ActivePage := tbsProdAcab;
        fMensagem('ATENÇÃO!', 'O campo Carga deve ser (1)Carga, (2)Resina ou (0)Outros!', ['&Ok']);
        Result := False;
      End Else
      Begin
        dbeAbsOle.Enabled := SameText(dbeECarga.Text, '1');

        If (Not dbeAbsOle.Enabled) And (qryTabela.State In [dsEdit, dsInsert]) Then
          qryTabela.FieldByName('ITE_ABSOLE').AsFloat := 0;

      End;

    End

    Else If (Sender = dbeAbsOle) Then
    Begin

      If (fStrToFloat(dbeAbsOle.Text) < 0) And pnlMateriaPrima.Visible And dbeAbsOle.Enabled  And (tbsProdAcab.TabVisible) Then
      Begin
        pgcDados.ActivePage := tbsProdAcab;
        fMensagem('ATENÇÃO!', 'O Campo Absorção de Óleo deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeIteFatCMP) Then
    Begin
      if (fStrToFloat(dbeIteFatCMP.Text) < 0) and (dbeIteFatCMP.Visible) then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "Fator de conversão madeira de M³ para Peças" deve ser maior ou igual a zero!', ['&Ok']);
        Result := False;
      End;
    End;

    // NAO COLOCAR ELSE
    If (Sender = dbeComLub) Or (Sender = dbeIncPis) Or
       (Sender = dbeImpLis) Or (Sender = dbeAtiCom) Or
       (Sender = dbeApeRet) Or (Sender = dbeApeEnt) Then
    Begin

      If Sender.Enabled Then
      Begin

        If Not fValidoSimNao((Sender As TDBEditFocus).Text) Then
        Begin

          if (Sender = dbeComLub)Then
            fMensagem('','O campo Combustível / Lubrificante  deve ser (S)im ou (N)ão ', ['&OK'])

          Else If (Sender = dbeImpLis)Then
            fMensagem('','O campo Imprime Lista deve ser (S)im ou (N)ão',['&Ok'])

          Else If (Sender = dbeIncPis)Then
            fMensagem('','O campo Incide PIS deve ser (S)im ou (N)ão', ['&OK'])

          Else if (Sender = dbeAtiCom) Then
            fMensagem('','O Campo Ativo Para Compras deve ser (S)im ou (N)ão', ['&OK'])

          Else if (Sender = dbeApeRet) And dbeApeRet.Visible Then
            fMensagem('','O campo Apenas Retira deve ser (S)im ou (N)ão', ['&OK'])

          Else if (Sender = dbeApeEnt) And dbeApeEnt.Visible Then
            fMensagem('','O campo Apenas Entrega deve ser (S)im ou (N)ão', ['&OK']);

          Result := False;
        End;

        {Somente uma opção pode ser marcada, "Apenas Retira" ou "Apenas Entrega"}
        If (Sender = dbeApeRet) Then
          If dbeApeRet.Text = 'S' then
            dbeApeEnt.Field.AsString := 'N';

        If (Sender = dbeApeEnt) Then
          If dbeApeEnt.Text = 'S' then
          dbeApeRet.Field.AsString := 'N';

      End;

      If Not Result Then
      Begin

        If (Sender = dbeAtiCom) Then
          pgcDados.ActivePage := tbsDadosEntrada

        Else if (Sender = dbeIncPis) or (Sender = dbeComLub) Then
          pgcDados.ActivePage := tbsFiscais

        Else
          pgcDados.ActivePage := tbsComplementos;
      End;

    End

    Else If (Sender = dbeExcIpi) Then
    Begin
      If Not fEmptyStr(dbeExcIpi.Text) Then
      Begin
        If (StrToIntDef(dbeExcIpi.Text, 0) <= 0) Or
           (StrToIntDef(dbeExcIpi.Text, 0)  > 11) Then
        Begin
          fMensagem('', 'O campo EX IPI deve ser (vazio) ou estar na faixa de 1 até 11!', ['&OK']);
          Result := False;
        End;
      End;

      If Result And fEmptyStr(fRetDescricaoNcm(dbeClaIpi.Text, dbeExcIpi.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Não foi encontrado cadastro de NCM com o Código e Exceção informados. '+
          'Verifique o "Cadastro de Nomenclatura Comum do Mercosul (NCM)"!', ['&Ok']);
        Result := False;
        Sender := dbeClaIpi;
      End;

    End

    Else
    If (Sender = dbeGarFil) And (dbeGarFil.Visible) Then
    Begin
      If (Pos(dbeGarFil.Text, 'S_N_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Garantia Realizada Pela Própria Filial deve ser (S) ou (N)!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtOrdServ) Then
    Begin
      If (Pos(edtOrdServ.Text, 'S_N_') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Ordem de Serviço deve ser (S) ou (N)!', ['&Ok']);
        Result := False;
      End;

    End

    Else If blnBuscaPorChave And (Sender = edtEmbFec) Then
    Begin
      If fStrToFloat(edtEmbFec.Text) <= 0 Then
      Begin
        Result := False;
        fMensagem('','A quantidade deve ser maior que zero!', ['&Ok']);
      End;
    End

    Else If blnBuscaPorChave And (Sender = edtDesFec) Then
    Begin
      If fStrToFloat(edtDesFec.Text) < 0 Then
      Begin
        Result := False;
        fMensagem('','O percentual de desconto não deve ser menor que zero!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeUsaFle) Then
    Begin
      If (blnUsaFle) Then
      Begin
        If (Pos(dbeUsaFle.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Utilização do FLEX deve ser (S)im ou (N)ão!', ['&OK']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsComplementos;
      End;
    End

    Else If (Sender = dbeClaCrm) And (dbeClaCrm.Visible) Then
    Begin
      If dbeClaCrm.Visible And (Not ( (SameText(dbeClaCrm.Text, 'C')) Or (SameText(dbeClaCrm.Text, 'P')) Or (SameText(dbeClaCrm.Text, 'A')))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Classificação Oferta de Consumíveis deve ser (C), (P) ou (A)!', ['&OK']);
        pgcDados.ActivePage := tbsComplementos;
        Result := False;
      End;
    End

    Else If ((Sender = edtDescModVei) Or
            (Sender = edtDescMarVei)) And fProdutoxVeiculoPreenchido Then
    Begin
      If  Assigned(objCadProdutosVeiculoModelo) Then
      Begin

        If Sender = edtDescModVei Then
        Begin
          If (Not edtDescModVei.fEmptyStr) And (edtDescModVei.Referencia = '') Then
            edtDescModVei.pValidaCampoParaCarregarReferencia;
          If (edtDescMarVei.fEmptyStr) and (edtDescModVei.Referencia <> '') Then
          Begin
            edtDescMarVei.Text := fRetDesMarcaVeic(fRetMarcaModeloVeiculo(edtDescModVei.Referencia));
            edtDescMarVei.pValidaCampoParaCarregarReferencia;
          end
          Else If edtDescModVei.fEmptyStr Then
          Begin
            fMensagem('', 'O Modelo do veiculo deve ser informado!', ['&Ok']);
            Result := False;
          End;
        End

        Else If Sender = edtDescMarVei Then
        Begin
          If Not edtDescMarVei.fEmptyStr Then
            edtDescMarVei.pValidaCampoParaCarregarReferencia
          Else If edtDescMarVei.fEmptyStr Then
          Begin
            fMensagem('', 'O Marca do veiculo deve ser informada!', ['&Ok']);
            Result := False;
          End;
        End;


        If (((edtDescMarVei.Referencia <> '') And
            (edtDescModVei.Referencia <> '')) And
            ( Not objCadProdutosVeiculoModelo.fModeloPertenceAMarca(edtDescModVei.Referencia, edtDescMarVei.Referencia))) Or
            //Se o modelo ja estiver cadastrado e a marca informada não
            ((edtDescMarVei.Referencia = '') And (edtDescModVei.Referencia <> '')) Then
        Begin
          fMensagem('ATENÇÃO!','A marca do veiculo informada não combina com o modelo informado.', ['&OK']);
          Result := False;
        End;

      End;
    End

    Else If (Sender = edtValvula) Then
    Begin
      If (edtValvula.Text <> '') And ((StrToInt(edtValvula.Text) > 999) Or (StrToInt(edtValvula.Text) < 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Valvula deve estar entre 0 e 999.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtCilindrada) Then
    Begin
      If (edtCilindrada.Text <> '') And ((StrToFloat(edtCilindrada.Text) > 99999) Or (StrToFloat(edtCilindrada.Text) < 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Cilindrada deve estar entre 0 e 99999.', ['&OK']);
        Result := False;
      End;
    End
    Else If (Sender = edtPotencia) Then
    Begin
      If (edtPotencia.Text <> '') And ((StrToInt(edtPotencia.Text) > 99999) Or (StrToInt(edtPotencia.Text) < 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Potencia deve estar entre 0 e 99999.', ['&OK']);
        Result := False;
      End;
    End
    Else If ((Sender = mskAnoFin) Or (Sender = mskAnoInicial)) And fProdutoxVeiculoPreenchido Then
    Begin
      If Sender = mskAnoFin Then
      Begin
        If (Not fEmptyStr(mskAnoFin.Text)) And
           ((StrToInt(mskAnoFin.Text)  < 1899) Or (StrToInt(mskAnoFin.Text) > (YearOf(fNow) + 1))) Then
        Begin
          pMensagemOk('Ano inválido.');
          Result := False;
        End;
      End
      Else If Sender = mskAnoInicial Then
      begin
        If (Not fEmptyStr(mskAnoInicial.Text)) And
           ((StrToInt(mskAnoInicial.Text)  < 1899) Or (StrToInt(mskAnoInicial.Text) > (YearOf(fNow) + 1))) Then
        Begin
          pMensagemOk('Ano inválido.');
          Result := False;
        End

        Else If fEmptyStr(mskAnoInicial.Text) Then
        Begin
          pMensagemOk('O Ano inicial deve ser preenchido.');
          Result := False;
        End;
      End;

      If Result And ((Not fEmptyStr(mskAnoInicial.Text)) And (not fEmptyStr(mskAnoFin.Text))) And
         (StrToInt(mskAnoInicial.Text) > StrToInt(mskAnoFin.Text)) Then
      Begin
        pMensagemOk('O Ano Inicial deve ser menor ou igual que a Ano Final.');
        Result := False;
      End;
    End

    Else If (Sender = dbeCNFDEM) Then
    Begin
      If pnlConferenciaDemanda.Visible Then
      Begin
        If StrToIntDef(dbeCNFDEM.Text,0) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de retiradas para gerar conferência de localização física, deve ser maior ou igual a zero!', ['&OK']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsComplementos;
      End;
    End

    Else If (Sender = dbeDiaCri) Then
    Begin
      If dbeDiaCri.Visible Then
      Begin
        If StrToIntDef(dbeDiaCri.Text,0) < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de dias antes do vencimento para transferir ao crítico, deve ser maior ou igual a zero!', ['&OK']);
          Result := False;
        End;

        If Not Result Then
          pgcDados.ActivePage := tbsComplementos;
      End;
    End

    Else If (Sender = dbeReaLoc) And pnlLocEqui.Visible Then
    Begin
      If Not (Pos(dbeReaLoc.Text,'SN') > 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permite Locação deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;

      dbeTipLoc.Enabled := (dbeReaLoc.Text = 'S');

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;
    End

    Else If (Sender = dbeTipLoc) And pnlLocEqui.Visible Then
    Begin

      If Not (Pos(dbeTipLoc.Text,'AP') > 0) and dbeTipLoc.Enabled Then
      Begin
        fMensagem('ATENÇÃO!', 'Tipo de produto na Locação deve ser "A" ou "P"!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;
    End

    Else If (Sender = dbeAtoDDF) And dbeAtoDDF.Visible Then
    Begin
      If (Pos(dbeAtoDDF.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Decreto 34063/12 para o estado DF deve ser S ou N!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeIteBal) And (dbeIteBal.Visible) Then
    Begin

      If (Pos(dbeIteBal.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'Produto de Balança deve ser (S)im ou (N)ão!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pgcDados.ActivePage := tbsComplementos;

    End;

  End;

  If Not Result Then
  Begin

    If Assigned(frmGravando) Then
    Begin

      objSender := Sender;

    End;

    pSetFocus(Sender);
  End;
end;

procedure TfrmCadProdutos.pIndicaMarcaBase;
begin
  If (VS_strUsaTmq = 'S') And (lstTintas <> Nil) Then
    cmbMarBas.ItemIndex := lstTintas.IndexOf(qryTabela.FieldByName('ITE_MARBAS').AsString);
end;

procedure TfrmCadProdutos.pIndicaTipoProdutoSPED;
  Var
    intContador: Integer;
begin
  cmbItePro.ItemIndex := 0;
  For intContador := 0 To cmbItePro.Items.Count -1 Do
  Begin
    If AnsiStartsText(qryIteGer.FieldByName('ITE_TIPPRO').AsString, cmbItePro.Items[intContador]) Then
    Begin
      cmbItePro.ItemIndex := intContador;
      Break;
    End;
  End;
end;

procedure TfrmCadProdutos.pIniciaCadastroDeProdutosExterno();
  var
    onFormShow:  TNotifyEvent;
begin
  onFormShow  := frmCadProdutos.OnShow;
  frmCadProdutos.OnShow := nil;
  frmCadProdutos.ShowModal;
  frmCadProdutos.OnShow := onFormShow;
end;

procedure TfrmCadProdutos.pInicializaIndices;
begin
  inherited;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CADITE.ITE_DESITE+CADMAR.MAR_DESMAR+CADITE.ITE_REFERE');
  stlCamInd.Add('CADITE.ITE_DESITE+MAR_DESMAR+CADITE.ITE_CODFAB');
  stlCamInd.Add('CADITE.ITE_DESITE+CADITE.ITE_REFERE');
  stlCamInd.Add('CADITE.ITE_CODITE');
  stlCamInd.Add('CADITE.ITE_REFERE');
  stlCamInd.Add('CADITE.ITE_CODGRU');
  stlCamInd.Add('CADITE.ITE_CODBAR');
  stlCamInd.Add('CADITE.ITE_BAREMB');
  stlCamInd.Add('CADITE.ITE_CODFAB');
  stlCamInd.Add('CADITE.ITE_DESITE+CADMAR.MAR_DESMAR+CADITE.ITE_APLICA');
  stlCamInd.Add('CADMAR.MAR_DESMAR+CADITE.ITE_DESITE');
  stlCamInd.Add('CADITE.ITE_DESFAB');
  stlCamInd.Add('CADITE.ITE_CLAIPI');
  stlCamInd.Add('CADITE.ITE_APLICA');
  stlCamInd.Add('CADFOR.FOR_NOMFOR+CADITE.ITE_DESITE');

  stlDesInd.Add('Descrição/Marca/Referência');
  stlDesInd.Add('Descrição/Marca/Cód. Fábrica');
  stlDesInd.Add('Descrição/Referência');
  stlDesInd.Add('Codigo');
  stlDesInd.Add('Referência');
  stlDesInd.Add('Grupo');
  stlDesInd.Add('Cód. Barra');
  stlDesInd.Add('Cód. Barra Embalagem');
  stlDesInd.Add('Cód. Fábrica');
  stlDesInd.Add('Descrição/Marca/Aplicação');
  stlDesInd.Add('Marca/Descrição');
  stlDesInd.Add('Des. Fábrica');
  stlDesInd.Add('Cód. NCM');
  stlDesInd.Add('Aplicação');
  stlDesInd.Add('Fornecedor/Descrição');

  pAtribuiTabelas;
end;

procedure TfrmCadProdutos.pLimpaEdits;
begin
  edtNomOpe.Clear;
  edtDesMar.Clear;
  edtNomFor.Clear;
  edtLinGru.Clear;
  edtDesGpr.Clear;
  edtDesUni.Clear;
  edtDesAbf.Clear;
  edtDesLse.Clear;

  edtDesAbfPis.Clear;
  edtDesAbfCof.Clear;
  edtDesAbfIpi.Clear;
  edtCestDesc.Clear;
  edtDesDep.Clear;

  edtComLiq.Clear;
  edtCusRea.Clear;
  dbeSaldos.Clear;

  If tbsExportaSite.TabVisible Then
    FPanelDadosECommerce.pLimparCampos;

  {*********************************}
  { LIMPA A ABA 6-PREÇO             }
  {******************************JB*}
  edtUltCom.Clear;
  edtQtdUco.Text := '0.000';
  edtPreUlt.Text := '0.0000';
  edtImpUlt.Text := '0.0000';
  edtDtaUve.Clear;
  edtQtdUve.Text := '0.000';
  edtPreuve.Text := '0.0000';
  edtPMED_V.Text := '0.0000';
  edtPreMed.Text := '0.0000';
  edtPreUltEmb.Text := '0.0000';
  edtEmbQtd.Text := '0.0000';
  edtPreImpUltEmb.Text := '0.0000';

  edtUltNot.Clear;
  edtCotMoe.Clear;
  edtUltFor.Clear;
  edtNomUltFor.Clear;
  edtDesProduto.Clear;
  edtDescProdutoDiluente.Clear;

  If Not blnUsaTabPrF Then
    cdsFornecedor.EmptyDataSet;

  dbeSubProdPermiteVendaSeparado.Text := 'S';
end;

procedure TfrmCadProdutos.pCarregaMarca;
begin
  pPesquisaCadMar(qryConMar, qryConMar, dbeCodMar.Text, (qryTabela.FieldByName('ITE_ITEATI').AsString = 'S'));
  With qryConMar Do
  Begin
    edtDesMar.Text := FieldByName('MAR_DESMAR').AsString;
  End;
end;

procedure TfrmCadProdutos.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmCadProdutos.pCarregaFornecedorIteFor;
Var
  strSQL : String;
  qryGen : TUniQuery;
begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   FOR_CODFOR, ';
    strSQL := strSQL + '   FOR_NOMFOR, ';
    strSQL := strSQL + '   FOR_FONE01, ';
    strSQL := strSQL + '   CID_NOMCID, ';
    strSQL := strSQL + '   CID_ESTADO ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADFOR ';
    strSQL := strSQL + '   JOIN CADCID ON (FOR_CODCID=CID_CODCID) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FOR_CODFOR = :CODFOR ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODFOR').AsString := edtCodForn.Text;
      Open;
      If Not IsEmpty Then
        edtNomForn.Text := FieldByName('FOR_NOMFOR').AsString
      Else
        edtNomForn.Clear;

      strForTel := FieldByName('FOR_FONE01').AsString;
      strForCid := FieldByName('CID_NOMCID').AsString;
      strFor_UF := FieldByName('CID_ESTADO').AsString;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmCadProdutos.pCadastrarProdutosAcabados(arrUnidades,
  arrCores, arrComposicao: array of String);
  Var
    objProdAcab: TProdutosAcabados;
    strMsgAdi : String;
    strCodGruP : String;
    strCodMarP : String;
begin
  objProdAcab := TProdutosAcabados.Create;
  Try
    Try
      strCodGruP := qryTabela.FieldByName('ITE_CODGRU').AsString;
      strCodMarP := qryTabela.FieldByName('ITE_CODMAR').AsString;
      If fCfgSis('SOMALG', varBoolean) Then
      Begin
        If fMensagem('', 'Deseja alterar os dados do produto acabado?', ['&Sim', '&Não'], 2) = 1 Then
        Begin
          If not TfrmProdutoAcabadoAlteraDados.fGetDados(strCodMarP, strCodGruP) Then
            Exit;
        End;

      End;

      With objProdAcab Do
      Begin
        intIncDec := intDecUni;
        strCodIte := qryTabela.FieldByName('ITE_CODITE').AsString;
        strCodGru := strCodGruP;
        strRefere := qryTabela.FieldByName('ITE_REFERE').AsString;
        strCodMar := strCodMarP;
        strCodFor := qryTabela.FieldByName('ITE_CODFOR').AsString;
        strCodUni := qryTabela.FieldByName('ITE_CODUNI').AsString;

        If fCfgSIs('TIPABF') = '1' Then
          strCodAbf := qryTabela.FieldByName('ITE_CODABF').AsString
        Else
          strCodAbf := qryIteGer.FieldByName('ITE_CODABF').AsString;

        strAbfPis := qryTabela.FieldByName('ITE_ABFPIS').AsString;
        strAbfCof := qryTabela.FieldByName('ITE_ABFCOF').AsString;
        strAbfIpi := qryTabela.FieldByName('ITE_ABFIPI').AsString;
        strImpDir := qryTabela.FieldByName('ITE_IMPDIR').AsString;
        strIncPis := qryTabela.FieldByName('ITE_INCPIS').AsString;
        strClaIpi := qryTabela.FieldByName('ITE_CLAIPI').AsString;
        strComLub := qryTabela.FieldByName('ITE_COMLUB').AsString;
        strIteAti := qryTabela.FieldByName('ITE_ITEATI').AsString;
        strAtiCom := qryTabela.FieldByName('ITE_ATICOM').AsString;
{        strPesOit := qryTabela.FieldByName('ITE_PESOIT').AsString;
        strPesLiq := qryTabela.FieldByName('ITE_PESLIQ').AsString;}
        strIteBas := qryTabela.FieldByName('ITE_ITEBAS').AsString;
        strUsaBon := qryTabela.FieldByName('ITE_USABON').AsString;
        strUsaFle := qryTabela.FieldByName('ITE_USAFLE').AsString;
        strValObr := qryTabela.FieldByName('ITE_VALOBR').AsString;
        strCnv_Ml := qryTabela.FieldByName('ITE_CNV_ML').AsString;
        strItePig := qryTabela.FieldByName('ITE_ITEPIG').AsString;
        strNvlGir := qryTabela.FieldByName('ITE_NVLGIR').AsString;
        strMsgLv1 := qryTabela.FieldByName('ITE_MSGLV1').AsString;
        strMsgLv2 := qryTabela.FieldByName('ITE_MSGLV2').AsString;
        strAplica := qryTabela.FieldByName('ITE_APLICA').AsString;
        strInfLam := qryTabela.FieldByName('ITE_INFLAM').AsString;
        strTmpGar := qryTabela.FieldByName('ITE_TMPGAR').AsInteger;
        strInfGar := qryTabela.FieldByName('ITE_INFGAR').AsString;
        strRspGar := qryTabela.FieldByName('ITE_RSPGAR').AsString;
        strExpSit := qryTabela.FieldByName('ITE_EXPSIT').AsString;
        strExpPok := qryTabela.FieldByName('ITE_EXPPOK').AsString;
        strExpApp := qryTabela.FieldByName('ITE_EXPAPP').AsString;
        strImpDir := qryTabela.FieldByName('ITE_IMPDIR').AsString;
        strCodGpr := qryTabela.FieldByName('ITE_CODGPR').AsString;

        If fCfgSis('INDREV') = '1' Then
          strIndRev := qryTabela.FieldByName('ITE_INDREV').AsString
        Else
          strIndRev := qryIteger.FieldByName('ITE_INDREV').AsString;

        strCodOpe := qryTabela.FieldByName('ITE_CODOPE').AsString;
        strUniCom := qryTabela.FieldByName('ITE_UNICOM').AsString;
        strUniTri := qryTabela.FieldByName('ITE_UNITRI').AsString;
        fltFatUTr := qryTabela.FieldByName('ITE_FATUTR').AsFloat;
        strObrCpf := qryTabela.FieldByName('ITE_OBRCPF').AsString;
        strObrIba := qryTabela.FieldByName('ITE_OBRIBA').AsString;
        strMltCom := qryTabela.FieldByName('ITE_MLTCOM').AsString;
        strMltVen := qryTabela.FieldByName('ITE_MLTVEN').AsString;
        strCodMon := qryTabela.FieldByName('ITE_CODMON').AsString;

        If intSitPro = 1 Then
          strSitPro := qryTabela.FieldByName('ITE_SITPRO').AsString
        Else
          strSitPro := qryIteger.FieldByName('ITE_SITPRO').AsString;

        strBarEmb := qryTabela.FieldByName('ITE_BAREMB').AsString;
        strSetFlz := qryTabela.FieldByName('ITE_SETFLZ').AsString;
        strCodVel := qryTabela.FieldByName('ITE_CODVEL').AsString;
        strCodBar := qryTabela.FieldByName('ITE_CODBAR').AsString;
        strCprCen := qryIteGer.FieldByName('ITE_CPRCEN').AsString;
        strMenFis := qryTabela.FieldByName('ITE_MENFIS').AsString;
        strCodOnu := qryTabela.FieldByName('ITE_CODONU').AsString;
        strIpiSai := qryIteGer.FieldByName('ITE_IPISAI').AsString;
        strSitPrd := qryTabela.FieldByName('ITE_SITPRD').AsString;

        strPraVal := qryTabela.FieldByName('ITE_PRAVAL').AsString;
        strDesFab := qryTabela.FieldByName('ITE_DESFAB').AsString;
        strCDCEST := qryTabela.FieldByName('ITE_CDCEST').AsString;
        strPrdGru := qryTabela.FieldByName('ITE_PRDGRU').AsString;
        strNivGir := 'C';

        strTipPro := strTipoProd;

        //exportacao site
        If tbsExportaSite.TabVisible Then
        Begin
          strDesSit := FPanelDadosECommerce.mmoDesSit.Texto;
          strDadTec := FPanelDadosECommerce.mmoDadTec.Texto;
          strNomIte := FPanelDadosECommerce.edtNomIte.Text;
          strAplIte := FPanelDadosECommerce.mmoAplIte.Texto;
          strIncLus := FPanelDadosECommerce.mmoIteIncluso.Texto;
          fltExpAlt := fStrToFloat(FPanelDadosECommerce.edtExpAlt.Text);
          fltExpLar := fStrToFloat(FPanelDadosECommerce.edtExpLar.Text);
          fltExpPro := fStrToFloat(FPanelDadosECommerce.edtExpPro.Text);
          strUrlImg := FPanelDadosECommerce.edtImgSit.Text;
        End;

        If fInserirProdutosAcabados(arrUnidades, arrCores, arrComposicao, dbeCodIte.Text, strMsgAdi) Then
          fMensagem('Informação!','Produtos acabados gerados com sucesso!',['&OK'])
        Else
        Begin
          fMensagem('ATENÇÃO!', 'Não será possível cadastrar este produto, pois já existe no cadastro outro produto com o mesmo código de fábrica: ' + Chr(13) +
                                strMsgAdi, ['&OK']);
        End;

      End;
      dbeCodDep.Enabled := False;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadProdutos.pCadastrarProdutosAcabados]');
      End;
    End;
  Finally
    objProdAcab.Free;
  End;
end;

procedure TfrmCadProdutos.pCadastrarProdutosAcabadosAutomaticamente(arrUnidades,
  arrCores, arrComposicao: array of String);
begin
  If fCadIteProCodAutomatico Then
  Begin
    pCadastrarProdutosAcabados(arrUnidades, arrCores, arrComposicao);
  End
  Else
    fMensagem('ATENÇÃO!','Não será possível o cadastro do produto acabado, ' +
                         'porque a geração do código automático do cadite está ' +
                         'configurado como NÃO. Favor mudar a configuração ' +
                         'para SIM, para podermos prosseguir!',['&OK']);
end;

procedure TfrmCadProdutos.pCarregaAbreviacao;
begin
  pPesquisaAbfIcm(qryConAbf, qryConAbf, dbeCodAbr.Text);
  With qryConAbf Do
  Begin
    edtDesAbf.Text := FieldByName('ABF_DESABF').AsString;
  End;
end;

procedure TfrmCadProdutos.pCarregaLinGru;
var
  LQryMatriz: TUniQuery;
  LFieldMatriz: TField;
  LFieldIteGer: TField;
begin
  pPesquisaLinGru(qryConGru, qryConGru, dbeCodGru.Text);
  With qryConGru Do
  Begin
    If Not fEmptyStr(FieldByName('DESLIN').AsString) Then
      edtLinGru.Text := FieldByName('DESLIN').AsString + ' / ' + FieldByName('GRU_DESGRU').AsString
    Else
      edtLinGru.Text := FieldByName('GRU_DESGRU').AsString;
  End;

  if blnInsert and (not blnHeranca) And (Not blnTabPrd) Then
  begin
    LQryMatriz := fCriaQuery;
    try
      LQryMatriz.SQL.Add('SELECT * FROM PROMAT WHERE MAT_CODGRU = :CODGRU');
      LQryMatriz.ParamByName('CODGRU').AsString := dbeCodGru.Text;
      LQryMatriz.Open;

      if not LQryMatriz.IsEmpty then
      begin
        for LFieldMatriz in LQryMatriz.Fields do
        begin
          LFieldIteGer := qryIteGer.FindField(LFieldMatriz.FieldName.Replace('MAT_', 'ITE_'));
          if Assigned(LFieldIteGer) then
            LFieldIteGer.Value := LFieldMatriz.Value;
        end;
      end;
    finally
      FreeAndNil(LQryMatriz);
    end;
  end;

  pVerificaMargemGrupo(dbeCodGru.Text);
end;

procedure TfrmCadProdutos.pCarregaLocSep;
begin
  pPesquisaCadLse(qryConLse, qryConLse, dbeCodLse.Text);
  With qryConLse Do
  Begin
    edtDesLse.Text := FieldByName('LSE_DESCRI').AsString;
  End;
end;

procedure TfrmCadProdutos.pCarregaLotAmz(strCodIte: String);
  Var
    strSQL : String;
begin
  {*********************************}
  { CARREGA AS ULTIMAS VENDAS NO    }
  { DBGRID DA PAGINA - 5            }
  {******************************JB*}
  With qryLotAmz Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  AMZ_CODAMZ, ';
    strSQL := strSQL + '  IFNULL(AMZ_DESCRI, "A DEFINIR") AS AMZ_DESCRI, ';
    strSQL := strSQL + '  LOT_SALDOS, ';
    strSQL := strSQL + '  LOT_LOCFIS  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADLOT L LEFT JOIN CADAMZ A ON L.LOT_NUMLOT = AMZ_CODAMZ AND AMZ_CODEMP = L.LOT_CODEMP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  L.LOT_CODITE = :CODITE AND ';
    strSQL := strSQL + '  L.LOT_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  ((L.LOT_NUMLOT IS NOT NULL) OR (L.LOT_NUMLOT = "A DEFINIR")) ';
    strSQL := strSQL + 'ORDER BY IFNULL(AMZ_DESCRI, "000") ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODITE').Value := strCodIte;
    ParamByName('CODEMP').Value := VS_strCodEmp;
    Open;

    (FieldByName('LOT_SALDOS') As TFloatField).DisplayFormat      := '#,##0.00';

  End;

  If fCfgSis('CPESOB', varBoolean) Then
  Begin
    lblPesagemObrEnt.Visible   := True;
    dbePesagemObrEnt.Visible   := True;
    lblPesagemObrEntSN.Visible := True;
  End;

end;

procedure TfrmCadProdutos.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  inherited;

  wrdLasKey := Msg.CharCode;

end;

procedure TfrmCadProdutos.qryTabelaOnBeforePost(DataSet: TDataSet);
begin
  with DataSet Do
  Begin
    If (State <> dsEdit) Or (blnInserindo) Then
      Exit;


    If (FieldByName('ITE_DESITE').Value <> FieldByName('ITE_DESITE').OldValue) Or
       (FieldByName('ITE_REFERE').Value <> FieldByName('ITE_REFERE').OldValue) Or
       (FieldByName('ITE_CODUNI').Value <> FieldByName('ITE_CODUNI').OldValue) Then
      TAltDes.pSalvaLog(FieldByName('ITE_CODITE').AsString,
                        strLoginUsuarioLogado,
                        IfNull(FieldByName('ITE_DESITE').OldValue,''),
                        IfNull(FieldByName('ITE_REFERE').OldValue,''),
                        IfNull(FieldByName('ITE_CODUNI').OldValue,''));

    If blnCatalogo Then
      btnIncluir.Click;

  end;
end;

procedure TfrmCadProdutos.spbVerSeriesClick(Sender: TObject);
begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(76, 5253, [],
                        ['CODITE','CODEMP'],
                        [dbeCodIte.Text, VS_StrCodEmp],
                        Sender,
                        nil,
                        True);
  end;

end;

procedure TfrmCadProdutos.btnCarregaModeloVeiculoExistenteClick(Sender: TObject);
var qryDetModVei : TUniQuery;
    arrSel: TConsultasArray;
    chrKey: Char;

begin
  inherited;
  If Not (qryTabela.State in dsEditModes) Then
    Exit;

  qryDetModVei := fCriaQuery;
  Try
    chrKey := '?';
    If untConsultas.fPesqDetalheModelo(Self, qryDetModVei, chrKey, arrSel) Then
    Begin
      edtDescMarVei.LimparConteudo;
      edtDescModVei.LimparConteudo;
      mskAnoInicial.Text    := '';
      mskAnoFin.Text        := '';
      edtValvula.Text       := '';
      edtCilindrada.Text    := '';
      edtObservacoes.Text   := '';
      edtPotencia.Text      := '';
      cmbCombustivel.ItemIndex := 0;
      objCadProdutosVeiculoModelo.pCancelaEdicao;


      edtDescMarVei.Text    := fRetDesMarcaVeic(fRetMarcaModeloVeiculo(qryDetModVei.FieldByName('MOD_CODMOD').AsString));
      fValidaCampos(edtDescMarVei);

      edtDescModVei.Text    := fRetDesModeloVeic(qryDetModVei.FieldByName('MOD_CODMOD').AsString);
      fValidaCampos(edtDescModVei);

      mskAnoInicial.Text       := TCadProdutosVeiculoModelo.fZeroToVazio(qryDetModVei.FieldByName('MOD_ANOINI').AsInteger);
      mskAnoFin.Text           := TCadProdutosVeiculoModelo.fZeroToVazio(qryDetModVei.FieldByName('MOD_ANOFIN').AsInteger);
      edtValvula.Text          := TCadProdutosVeiculoModelo.fZeroToVazio(qryDetModVei.FieldByName('MOD_VALVUL').AsInteger);
      edtCilindrada.Text       := qryDetModVei.FieldByName('MOD_CILIND').AsString;
      edtObservacoes.Text      := qryDetModVei.FieldByName('MOD_OBSERV').AsString;
      edtPotencia.Text         := TCadProdutosVeiculoModelo.fZeroToVazio(qryDetModVei.FieldByName('MOD_POTENC').AsInteger);
      cmbCombustivel.ItemIndex := cmbCombustivel.Items.IndexOf(qryDetModVei.FieldByName('MOD_COMBUS').AsString);
      pSetFocus(edtDescMarVei)
    End;

  Finally
    FreeAndNil(qryDetModVei);
  End;
end;

procedure TfrmCadProdutos.pHabilitaReaEnderecamento;
Begin
  dbeReaEnd.Enabled := fCfgSis('USACON', VarBoolean) And (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  clrReaEnd.Enabled := dbeReaEnd.Enabled;
  lblReaEnd.Enabled := dbeReaEnd.Enabled;
End;

procedure TfrmCadProdutos.pHintCampoAplicacao;
var
  Height: integer;

begin
  inherited;
  If dbeAplica.Lines.Count * 18 > 53 Then
  Begin
    dbeAplica.BringToFront;
    pnlDadosSaida2.BringToFront;
    Height := dbeAplica.Height;

    dbeAplica.Height := dbeAplica.Lines.Count * 18;
    If dbeAplica.Height > (tbsDadosSaida.Height - dbeAplica.Top) Then
      dbeAplica.Height := tbsDadosSaida.Height - dbeAplica.Top - 18;
    If dbeAplica.Height > (pnlDadosSaida2.Height - dbeAplica.Top) Then
      pnlDadosSaida2.Height := pnlDadosSaida2.Height + (dbeAplica.Height - Height)
  end;

end;

procedure TfrmCadProdutos.FormShow(Sender: TObject);
  Var
    intTabPre: Integer;
    intIndice: Integer;
begin
  // colocado novamente para realizar os códigos da untPaiCad
  // Req. 128917
  inherited;

  pnlSuframa.Visible := Pos(strEstadoEmpresa, ESTADOS_REGRA_ZONA_FRANCA) > 0;

  If Not fCfgSis('UTICRM', varBoolean) Then
  Begin
    lblClaCrm.Visible := False;
    dbeClaCrm.Visible := False;
    lblClaCrmLeg.Visible := False;
  End;

  frmManutencaoAbreviacoesLojas := TfrmManutencaoAbreviacoesLojas.Create(dbeCodAbr,edtDesAbf, dbeAbfPis, edtDesAbfPis, dbeAbfCof, edtDesAbfCof, dbeAbfIpi, edtDesAbfIpi);
  frmManutencaoAbreviacoesLojas.pSetPainel(pnlAbrev);
  frmManutencaoAbreviacoesLojas.pHabilitaEdicao(False);

  If Assigned(objTabelas) Then
    objTabelas.cdsAbrFis := frmManutencaoAbreviacoesLojas.qryDados;

  pHabilitaReaEnderecamento;

  qryTabela.BeforePost := qryTabelaOnBeforePost;

  pGeraTransferencias;
  pGeraRequisicoesCompra;

  chkPreDol.Enabled := False;

  lblCarEst.Visible := (fCfgSIs('CAREST') = 'R') ;
  cmbCarEst.Visible := lblCarEst.Visible;

  clbNotEsp.Visible    := Pos(fCfgSis('TIPEXP'), '3_4_') > 0;
  lblNotEsp.Visible    := Pos(fCfgSis('TIPEXP'), '3_4_') > 0;
  dbeNotEsp.Visible    := Pos(fCfgSis('TIPEXP'), '3_4_') > 0;
  pnlDtaVal.Visible    := fCfgSis('VALFOR', VarBoolean);

  pnlPraMin.Visible    := fCfgSis('PRAMIN', varBoolean);

  cbxAplicarTodas.Visible := fVerificaAcessoSistema('ALSETE', strLoginUsuarioLogado);

  //Prestcon
  pnlDadosConcreto.Visible := (fCfgSis('USACCR', varBoolean)) And MatchStr(fCfgSis('TPNFCR'),[PRESTCON,SECOL,J_A_MASSA_CONCRETO]);

  pnlIteCCR.Visible := (fCfgSis('USACCR', varBoolean)) And (fCfgSis('ITECCR', varBoolean));

  pnlImpEti.Visible := fCfgSis('ENTETI', varBoolean);
  pnlFatCom.Visible := fCfgSis('FATCOM', varBoolean);
  //dbeFatCom.Visible := fCfgSis('FATCOM', varBoolean);
  //lblFatCom.Visible := dbeFatCom.Visible;
  //clbFatCom.Visible := dbeFatCom.Visible;

  blnSimPau := fCfgSis('SIMPAU', varBoolean);

  gpbMinTab.Visible := (fCfgSis('TRQDMI', varString) = 'S');
  gpbFreTra.Visible := (fCfgSis('FRETRA', varString) = FRETRA_POR_PRODUTOS_ADICIONAL_TRANSPORTADORA);

  If (fCfgSis('ORIPRO', varInteger) <> 2) And (fCfgSis('TCOPRO') <> '4') Then
    pnlComPro.Visible := False;

  pnlComMec.Visible := (fCfgSis('AUTCEN', VarBoolean)) And
                       (fCfgSis('OPCMEC', VarString ) = 'CPS');//Opcao de Comissao Mecanico: (C)adastro de (P)rodutos/(S)ervicos

  pnlFatCMP.Visible :=  (fCfgSis('VENMAD', varBoolean));

  pnlLoc.Visible := (fCfgSis('CTLEST', varInteger) = 1) or fUtilizaLocalSeparacaoNoCadastroLocalizacaoFisica;
  pnlAmz.Visible := Not pnlLoc.Visible;

  blnPreMat := fPreMat;

  If Not blnUsaTabPrF Then
    pCriaClientFornecedor;

  If fCfgSis('ITETBP', VarBoolean) Then
  Begin
    dbeDesMax.Visible := False;
    lblDesMax.Visible := False;
    lblDesMaxPor.Visible := False;

    dbeDesMSu.Visible := False;
    lblDesMSu.Visible := False;
    lblDesMSuPor.Visible := False;

    dbeDesMGe.Visible := False;
    lblDesMGe.Visible := False;
    lblDesMGePor.Visible := False;

    lblDesMvm.Visible := False;
    lblDesMsm.Visible := False;
    lblDesMgm.Visible := False;

    lblDesMvmPor.Visible := False;
    lblDesMsmPor.Visible := False;
    lblDesMgmPor.Visible := False;

    dbeDesMvm.Visible := False;
    dbeDesMsm.Visible := False;
    dbeDesMgm.Visible := False;
  End;

  If Not blnCatalogo Then
  Begin
    inherited;
    pCarregaIteGer;
  End;

  {*****************************************}
  {* LIBERADO DIA 13/07/2009 A PEDIDO DO   *}
  {* RONALDO, PARA O CLIENTE WIMPORT.      *}
  {**************************************MV*}
{  If (Not fCfgSis('CONIPI', varBoolean)) Then
  Begin
    dbeIpiSai.Enabled := False;
    dbeIpiSai.TabStop := False;
  End;}

  If Not fCfgSis('CONIPI', varBoolean) Then
    pnlIndRev.Visible := False;
//  Begin
//    dbeIndRev.Visible := False;
//    lblIndRev.Visible := False;
//    lbcIndRev.Visible := False;
//  End;

  For intTabPre := 1 To Length(VS_strTabPrc) Do
    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      intPriTab := intTabPre;
      Break;
    End;

  cbxTabEmf.Clear;
  cbxTabEmf.Items.Add('TODAS');
  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
    Begin
      TcxGroupBox(Self.FindComponent('gpbTabPre0' + IntToStr(intTabPre))).Visible := True;
      TGroupBox(Self.FindComponent('pnlMinTb' + IntToStr(intTabPre))).Visible := True;
      intUltTab := intTabPre;
      cbxTabEmf.Items.Add(IntToStr(intTabPre));
    End;
  End;
  cbxTabEmf.ItemIndex := 0;

  If VS_strUsaTmq <> 'S' Then
    pnlCnv_ML.Visible := False;
//  Begin
//    lblCnv_ML.Visible := False;
//    dbeCnv_ML.Visible := False;
//  End;

  If blnCatalogo Then
  Begin
    If blnUsaProCodigo Then
      pHabilitaCodigo(dbeCodIte, dbeCodGru, False)
    Else
      pHabilitaCodigo(dbeCodIte, dbeCodIte, True);
  End;

  lblOutVal.Caption := fCfgSis('DOVCPP') + ' (+):';
  lblDesAdi.Caption := fCfgSis('DESADI') + ' (' + fCfgSis('OPEADI') + '):';

  fFindColumnByName(dbgCompras, 'DESADB').Title.Caption := '(' + fCfgSis('OPEADI') + ') ' + fCfgSis('DESADI');

  strDesValFre := fCfgSis('DESVFR');
  lblValFre.Caption := strDesValFre + ' (+):';
  fFindColumnByName(dbgCompras, 'VALFRE').Title.Caption := '(+) ' + strDesValFre;

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    TLabel      (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Caption := fCfgSis('TCOMTB') + ':';
    TLabel      (Self.FindComponent('lblMarIde' + IntToStr(intTabPre))).Visible := False;
    TDBEditFocus(Self.FindComponent('dbeMarIde' + IntToStr(intTabPre))).Visible := False;

    If fCfgSis('PCMPRO') = '1' Then
    Begin

      If blnMarIde Then
      begin
        TLabel      (Self.FindComponent('lblMarBr' + IntToStr(intTabPre))).Left := 246;
        TDBEditFocus(Self.FindComponent('dbeMarBr' + IntToStr(intTabPre))).Left := 203;
        TLabel      (Self.FindComponent('lblTitMarBr' + IntToStr(intTabPre))).Left := 158;

        TLabel      (Self.FindComponent('lblMarIde' + IntToStr(intTabPre))).Top := 16;
        TDBEditFocus(Self.FindComponent('dbeMarIde' + IntToStr(intTabPre))).Top := 11;

        TLabel      (Self.FindComponent('lblMarIde' + IntToStr(intTabPre))).Visible := True;
        TDBEditFocus(Self.FindComponent('dbeMarIde' + IntToStr(intTabPre))).Visible := True;
      End;

      TDBEditFocus(Self.FindComponent('dbeComTb'    + IntToStr(intTabPre))).Visible := False;
      TLabel      (Self.FindComponent('lblTitComTb' + IntToStr(intTabPre))).Visible := False;
      TLabel      (Self.FindComponent('lblPerComTb' + IntToStr(intTabPre))).Visible := False;
    End;
  End;

  MSG_VALIDACAO_MARGEM := 'A soma do ( ICMS Saída + Impostos Federais + Despesas Operacionais + Margem Bruta ' + IIF(fCfgSis('PCMPRO') = '2', '+ Comissão ', '') + '  ) não pode ser superior a 100%.';

  If blnPreMat Then
  Begin
    pnlPrecos.Enabled  := False;
    pnlPrecos1.Enabled := False;
  End;

  lblUSABEF.Visible := fCfgSis('USABEF', varBoolean);
  dbeUSABEF.Visible := lblUSABEF.Visible;
  clbUSABEF.Visible := lblUSABEF.Visible;

  If Not fCfgSis('RECGRO', varBoolean) Then
    pnlAgroto.Visible := False;

  If tbsExportaSite.TabVisible Then
    FPanelDadosECommerce.pCarregaDadosECommerce;

//  pnlProEmb.Visible := fCfgSis('TREMTA', varBoolean);

  pAjustaNumeroPaginas(pgcDados, intPaginasAtivas);

  qryIteGer.AfterOpen := pAfterOpen;
  qryTabela.AfterOpen := pAfterOpen;

  pAjustaDolar;

  lblAltura.Caption    := fRetornaInfMedVIDRO(True, False, False, False, False, False, True);
  lblAlturaMax.Caption := fRetornaInfMedVIDRO(True,True,True,False,False);
  lblAltMin.Caption    := fRetornaInfMedVIDRO(True, False, False, False, False, True, False);

  lblProPCD.visible := blnSimPau;
  edtProPCD.visible := blnSimPau;
  clbProPCD.visible := blnSimPau;

  If (strMarMkp = '4') Then
    lblCusReaTit.Caption := 'IVA:';

  pnlOrdServico.Visible := fCfgSis('OSPDVN', varBoolean);

  lblPesagemObr.Visible   := False;
  dbePesagemObr.Visible   := False;
  lblPesagemObrSN.Visible := False;

  lblPesagemObrEnt.Visible   := False;
  dbePesagemObrEnt.Visible   := False;
  lblPesagemObrEntSN.Visible := False;

  lblDesChk.Visible   := False;
  bdeDesChk.Visible   := False;
  lblDesChkSN.Visible := False;

  If fCfgSis('PESOBR', varBoolean) Then
  Begin
    lblPesagemObr.Visible   := True;
    dbePesagemObr.Visible   := True;
    lblPesagemObrSN.Visible := True;
  End;

  If fCfgSis('CPESOB', varBoolean) Then
  Begin
    lblPesagemObrEnt.Visible   := True;
    dbePesagemObrEnt.Visible   := True;
    lblPesagemObrEntSN.Visible := True;
  End;

  If fCfgSis('ITECFO', varBoolean) And
     fCfgSis('DESCHK', varBoolean) Then
  Begin
    lblDesChk.Visible   := True;
    bdeDesChk.Visible   := True;
    lblDesChkSN.Visible := True;
  End;

  pnlSubProdPermiteVendaSeparado.Visible := (fCfgSis('CADEST', varBoolean)) and (fCfgSis('VENSUB', varString) = 'P');

  dbeEsMiDg.Visible := fCfgSis('ESMILJ', varBoolean);
  clEsMiDg.Visible  := dbeEsMiDg.Visible;
  lblEsMiDg.Visible := dbeEsMiDg.Visible;

  dbeAtoDDF.Visible := fExisteAlgumaEmpresaNoEstado('DF');
  lblAtoDDF.Visible := dbeAtoDDF.Visible;
  clbAtoDDF.Visible := dbeAtoDDF.Visible;

  pCarregaDadosAdicionais;
  pgcDados.ActivePageIndex := 0;

  {Altera anchors que herdou do "PaiCad"}
  btnSair.Anchors := [akLeft, akTop];

  If Not fEmptyStr(strCodIteParaCarregar) Then
  Begin
    qryTabela.SQL.Text := 'SELECT * FROM CADITE WHERE ITE_CODITE = :CODITE';
    qryTabela.ParamByName('CODITE').AsString := strCodIteParaCarregar;
    qryTabela.Open;

    pCarregaItemNaTela;
    pCarregaItemNaTelaParte2;
  End;

  if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
  begin
    lblPreCus.Left     := 538;
    lblPreCus.Top      := 120;
    dbePreCus.Left     := 632;
    dbePreCus.Top      := 116;

    dbePreCus.TabOrder := 19;
    pnlCusReal.Left    := 756;
    pnlCamposSuframa.Visible := True;
  end
  else
  begin
    lblPreCus.Left     := 298;
    lblPreCus.Top      := 186;
    dbePreCus.Left     := 388;
    dbePreCus.Top      := 178;

    dbePreCus.TabOrder := 17;
    pnlCusReal.Left    := 496;
    pnlCamposSuframa.Visible := False;
  end;

  pHabilitaIntegracaoGS1CNP;

  dbeDiaCri.Visible := fCfgSis('CADLOC', varBoolean);
  lblDiaCri.Visible := dbeDiaCri.Visible;

  if fUtilizaMatrizLinhaGrupo then
  begin
    for intIndice := 1 to 7 do
    begin
      if (TcxGroupBox(Self.FindComponent('gpbTabPre0' + IntToStr(intIndice))).Visible) then
      begin
        TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intIndice))).Font.Color := clBlack;
        TLabel(Self.FindComponent('lblTitPreVe' + IntToStr(intIndice))).Font.Color := clBlack;
        TLabel(Self.FindComponent('lblMarIde' + IntToStr(intIndice))).Font.Color   := clBlack;
        TLabel(Self.FindComponent('lblDolar' + IntToStr(intIndice))).Font.Color    := clBlack;
        TLabel(Self.FindComponent('lblTitComTb' + IntToStr(intIndice))).Font.Color := clBlack;
      end;
    end;
  end;

  If fCfgSis('LOCEQU', VarBoolean) Then
  Begin
    pnlLocEqui.Visible := True;
    If fCfgSis('UTIACE', VarBoolean) Then
    Begin
      dbeTipLoc.Visible := True;
      lblTipLoc.Visible := True;
      clbTipLoc.Visible := True;
      clbTipLoc.Caption := '(A)cessório (P)rincipal ';
    End
    Else
    Begin
      dbeTipLoc.Visible := False;
      lblTipLoc.Visible := False;
      clbTipLoc.Visible := False;
      clbTipLoc.Caption := '';
    End;

    If Not(pnlIteCCR.Visible) Then
    Begin
      lblPermiteLoc.Left := lblIteCcr.Left;
      dbeReaLoc.Left := dbeIteCCR.Left;
      clbReaLoc.Left := clbIteCcr.Left;

      lblTipLoc.Left := lblBrita.Left - (lblTipLoc.Width - lblBrita.Width);
      dbeTipLoc.Left := dbeBrita_.Left;
      clbTipLoc.Left := dbeBrita_.Left + dbeTipLoc.Width + 10;
    End;

  End
  Else
    pnlLocEqui.Visible := False;

  pnlComplementosPos02.Visible := (pnlIteCCR.Visible or pnlLocEqui.Visible);

  if fCfgSis('DITBAL', varBoolean) then
  begin
    dbeIteBal.Visible := True;
    Label246.Visible := True;
    ColorLabel48.Visible := True;
  end;

end;

procedure TfrmCadProdutos.pCarregaIteGer;
var
  intContador: Integer;
begin
  qryIteGer.Close;
  qryIteGer.ParamByName('CODITE').AsString := qryTabela.FieldbyName('ITE_CODITE').AsString;
  qryIteGer.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryIteGer.Open;

  frmManutencaoAbreviacoesLojas.pCarrega(qryTabela.FieldbyName('ITE_CODITE').AsString);

  TFloatField(qryIteGer.FieldByName('ITE_COMPRO')).DisplayFormat := '#,##0.00';
  TFloatField(qryIteGer.FieldByName('ITE_COMMEC')).DisplayFormat := '#,##0.000';
  TFloatField(qryTabela.FieldByName('ITE_FATCMP')).DisplayFormat := '#,###,##0.0000';
  TFloatField(qryIteGer.FieldByName('ITE_TCIFCU')).DisplayFormat := '#,##0.000000';
  TFloatField(qryIteGer.FieldByName('ITE_TSCUST')).DisplayFormat := '#,##0.000000';

  (qryTabela.FieldByName('ITE_LARVID') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');
  (qryTabela.FieldByName('ITE_ALTVID') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');
  (qryTabela.FieldByName('ITE_LAMAVI') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');
  (qryTabela.FieldByName('ITE_ALMAVI') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');

  (qryTabela.FieldByName('ITE_ARESUG') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,#####0.00000');
  (qryTabela.FieldByName('ITE_AREMAX') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,#####0.00000');
  (qryTabela.FieldByName('ITE_LARMIN') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');
  (qryTabela.FieldByName('ITE_ALTMIN') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,##0.00');
  (qryTabela.FieldByName('ITE_AREMIN') As TFloatField).DisplayFormat := fFormataCasaDecimalVIDRO('#,#####0.00000');


  qryTabela.FieldByName('ITE_CNPFME').EditMask := '99.999.999/9999-99;0;';

  If fEmptyStr(fFormataCasaDecimalVIDRO('#,##0.00')) Then
  Begin
    With TProcEventos Do
    Begin
      dbeLarVid.OnKeyPress := pTravaValorFracionadoOnKeyPress;
      dbeAltVid.OnKeyPress := pTravaValorFracionadoOnKeyPress;
      dbeLaMaVi.OnKeyPress := pTravaValorFracionadoOnKeyPress;
      dbeAlMaVi.OnKeyPress := pTravaValorFracionadoOnKeyPress;
    End;
  End
  Else
  Begin
    dbeLarVid.OnKeyPress := Nil;
    dbeAltVid.OnKeyPress := Nil;
    dbeLaMaVi.OnKeyPress := Nil;
    dbeAlMaVi.OnKeyPress := Nil;
  End;

  If (pnlComMec.Visible) Then
    lblPerValMc.Caption := IIF(dbeTpCoMc.Text = 'V', '$', '%');

  For intContador := 1 To 7 Do
  Begin
    TFloatField(qryIteGer.FieldByName('ITE_MINTB' +  IntToStr(intContador))).DisplayFormat := '#,##0.0000';
    TFloatField(qryIteGer.FieldByName('ITE_MARID' +  IntToStr(intContador))).DisplayFormat := '#,##0.00';
  End;

  {************************************************************************}
  {* TRECHO QUE PERMITE EXIBIR A IMAGEM DO PRODUTO                        *}
  {******************************************************************* AM *}
  If fCfgSis('IMGPRO') = 'S' Then
    pCarregaImagem;

  If Not blnUsaTabPrF Then
    pCarregaFornecedores(qryTabela.FieldByName('ITE_CODITE').AsString);

  If fCfgSis('ITETBP', VarBoolean) Then
    pCarregaDesMaxTabelaPreco(qryTabela.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);

  If fCfgSis('DMVFQV', VarBoolean) Then
    CarregaDesMaxFaixaQtde(qryTabela.FieldByName('ITE_CODITE').AsString, VS_strCodEmp);


  Label75.Visible   := fCfgSis('OPCCOM') <> 'PPT';
  lbl26.Visible     := fCfgSis('OPCCOM') <> 'PPT';
  lbl27.Visible     := fCfgSis('OPCCOM') <> 'PPT';
  dbeComVar.Visible := fCfgSis('OPCCOM') <> 'PPT';
  dbeComAta.Visible := fCfgSis('OPCCOM') <> 'PPT';
  dbeComDis.Visible := fCfgSis('OPCCOM') <> 'PPT';
  shpPEACVI.Visible := fCfgSis('OPCCOM') <> 'PPT';
  shpPEACVE.Visible := fCfgSis('OPCCOM') <> 'PPT';
  shpPEACVD.Visible := fCfgSis('OPCCOM') <> 'PPT';
  Label77.Visible   := fCfgSis('OPCCOM') <> 'PPT';
  Label78.Visible   := fCfgSis('OPCCOM') <> 'PPT';
  lbl28.Visible     := fCfgSis('OPCCOM') <> 'PPT';

  qryIteGer.Close;
  qryIteGer.Open;

end;

procedure TfrmCadProdutos.pCarregaImagem;
Begin
  if (qryIteGer.Active) And (Not fEmptyStr(qryIteGer.ParamByName('CODITE').AsString)) Then
  Begin
    imgPro.Picture := nil;
    Application.ProcessMessages;

    Case fCarregaImagemProduto(qryIteGer.ParamByName('CODITE').AsString, imgPro.Picture) of
      riOk   :
      Begin
        imgPro.Visible := True;
        lblErrImg.Visible := False;
      End;
      riErro :
      Begin
        imgPro.Visible := False;
        lblErrImg.Visible := True;
      End;
      riNulo :
      Begin
        imgPro.Visible := False;
        lblErrImg.Visible := False;
      End;
    End;
  End
  Else
    imgPro.Picture := nil;

  Application.ProcessMessages;
End;

procedure TfrmCadProdutos.btnCancelaClick(Sender: TObject);
begin
  If btnGravar.Enabled Then
    objLockEdicao.pDestravarTodos;

  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin
    blnCancelando := True;
    Try

      If Assigned(frmTabelasDoItem) Then
      Begin
        frmTabelasDoItem.cxvPrecos.OptionsData.Editing := False;
        frmManutencaoAbreviacoesLojas.cxTblAbrev.OptionsData.Editing := False;
      End;

    //  btnGerarProdutosAcabados.Enabled := False;
      blnInsert := False;
      frmManutencaoAbreviacoesLojas.pHabilitaEdicao(False);

      pHabilitaLojas(False, False);

      edtComLiq.Enabled := False;
      edtCusRea.Enabled := False;

      chkPreDol.Enabled := False;

      qryIteGer.Cancel;
      pgcDados.ActivePageIndex := 0;

      objIteBar.pCancela;
      objIteMon.pCancela;
      objLocfis.pCancela;

      pCarregaDadosAdicionais;
      pCarregaIteGer;

      If tbsExportaSite.TabVisible Then
        FPanelDadosECommerce.pCarregaDadosECommerce;

      btnHeranca.Enabled := False;
      blnHeranca := False;

      objLojas.pCarregaPontoExposicao;

      If blnCatalogo Then
      Begin
        {*************************************************************}
        {* VOLTA A DESCRICAO DA FABRICA E INIBI A DESCRIÇÃO ORIGINAL *}
        {**********************************************************LU*}
    //    lblDesFab.Width     := lblDescOrig.Width;
    //    lblDesFab.Left      := lblDescOrig.Left;
    //    lblDesFab.Top       := lblDescOrig.Top;

    //    dbeDesFab.Width     := edtDescOrig.Width;
    //    dbeDesFab.Left      := edtDescOrig.Left;
    //    dbeDesFab.Top       := edtDescOrig.Top;
    //    dbeDesFab.TabOrder  := edtDescOrig.TabOrder;

        lblDescOrig.Visible := False;
        edtDescOrig.Visible := False;

    //    lblDesFab.Visible   := True;
    //    dbeDesFab.Visible   := True;
        pnlDesFab.Visible   := True;
        dbeDesSim.Width     := dbeDesIte.Width;
      End;

      pAjustaFatorPreco(True);

      blnCatalogo := False;

      If btnEstrutura.Visible Then
        btnEstrutura.Enabled := qryTabela.Active And fEhOuCompoeEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString).blnEstrutura;

      If btnTabFor.Visible Then
        btnTabFor.Enabled := qryTabela.Active And (not fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString));

      pAjustaDolar;

      SetLength(arrIteEmbDel, 0);

      SetLength(arrMarIdeAlt, 0);

      If (Assigned(objFaixasMet)) Then
        FreeAndNil(objFaixasMet);

      blnPreDol := chkPreDol.Checked;
      pMontaCdsIteCom;
      pOnStateChange;

      If Assigned(objCadProdutosVeiculoModelo) Then
      Begin

        edtDescMarVei.LimparConteudo;
        edtDescModVei.LimparConteudo;
        mskAnoInicial.Text    := '';
        mskAnoFin.Text        := '';
        edtValvula.Text       := '';
        edtCilindrada.Text    := '';
        edtObservacoes.Text   := '';
        edtPotencia.Text      := '';
        cmbCombustivel.ItemIndex := 0;
        chkLimpaCamposVeiculo.Checked := True;
        objCadProdutosVeiculoModelo.pIniciaProcesso(qryTabela.FieldByName('ITE_CODITE').AsString, '');

      End;

      objAtributos.pEdita(False);
      pnlBotoesAtributos.Enabled := False;

    Finally
      InterlockedDecrement(intConfirma);
      blnCancelando := False;
    End;

  End
  Else
    InterlockedDecrement(intConfirma);


end;

procedure TfrmCadProdutos.btnExcluiAtribClick(Sender: TObject);
begin
  inherited;
  objAtributos.pExcluiAtributo;
end;


procedure TfrmCadProdutos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  If Assigned(objCadProdutosVeiculoModelo) Then
  Begin
    edtDescModVei.LimparConteudo;
    edtDescMarVei.LimparConteudo;
    cmbCombustivel.ItemIndex := 0;
    edtValvula.Text := '';
    mskAnoInicial.Text := '';
    edtCilindrada.Text := '';
    edtObservacoes.Text := '';
    edtPotencia.Text := '';
    objCadProdutosVeiculoModelo.pCancelaEdicao;
  End;
end;

procedure TfrmCadProdutos.btnCancelarFornClick(Sender: TObject);
begin
  inherited;
  edtCodForn.Clear;
  edtCodItF.Clear;
  edtCodCna.Clear;
  edtNomForn.Clear;
  pSetFocus(edtCodForn);
end;

procedure TfrmCadProdutos.btnCfgGriClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaAcessoSistema('GRCDPR', strLoginUsuarioLogado) Then
  Begin
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.' + #13#10 +
              'Direito de Acesso: "Cadastros \ Configura colunas Compras/Vendas do Cadastro de Produtos"', ['&Ok']);
    Exit;
  End;

  Case pgcUltVendaCompra.ActivePageIndex Of
    0: objCfgGriCompras.pConfiguraColunas;
    1: objCfgGriGiroCompras.pConfiguraColunas;
    2: objCfgGriVendas.pConfiguraColunas;
    3: objCfgGriGiroVendas.pConfiguraColunas;
    4: objCfgGriLoteRastreamento.pConfiguraColunas;
  End;

end;

procedure TfrmCadProdutos.btnExcluirClick(Sender: TObject);
  Var
  //strMsg: String;
  strCodIteDel:string;
begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try
      strCodIteDel:= dtsCadIte.DataSet.FieldByName('ITE_CODITE').AsString;
      {**************************************************}
      {* APENAS UM TESTE... NÃO APAGUAR POR ENQUANTO... *}
      {***********************************************RV*}
      {
      strMsg := fVerificaChaves('CADITE', 'ITE_CODITE', qryTabela.FieldByName('ITE_CODITE').AsString);
      If strMsg <> '' Then
        pMensagemSonora(strMsg);
      }

      If True {fPodeExcluirItem(qryTabela.FieldByName('ITE_CODITE').AsString)} Then
      Begin
        inherited;
        pLimparCampos;
        pCarregaIteGer;
        pCarregaDadosAdicionais;
        If Not (cdsIteCom.Data = null) Then
          cdsIteCom.EmptyDataSet;
        If tbsExportaSite.TabVisible Then
          FPanelDadosECommerce.pCarregaDadosECommerce;

        If blnExcluiu Then Begin
          pDeletIteAgr(strCodIteDel);

          pExcluirFaixasMetragem();
        End;
      End
      Else
      Begin
        fMensagem('', 'Não é permitida a exclusão de itens com Saldo!', ['&Ok']);
      End;

      If btnEstrutura.Visible Then
        btnEstrutura.Enabled := qryTabela.Active And fEhOuCompoeEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString).blnEstrutura;

      If btnTabFor.Visible Then
        btnTabFor.Enabled := qryTabela.Active And (not fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString));

      pAjustaDolar;
      pOnStateChange;

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

  objCalculaVariacaoPreco.fltPreve1 := qryIteGer.FieldByName('ITE_PREVE1').AsFloat;
  objCalculaVariacaoPreco.fltPreve2 := qryIteGer.FieldByName('ITE_PREVE2').AsFloat;
  objCalculaVariacaoPreco.fltPreve3 := qryIteGer.FieldByName('ITE_PREVE3').AsFloat;
  objCalculaVariacaoPreco.fltPreve4 := qryIteGer.FieldByName('ITE_PREVE4').AsFloat;
  objCalculaVariacaoPreco.fltPreve5 := qryIteGer.FieldByName('ITE_PREVE5').AsFloat;
  objCalculaVariacaoPreco.fltPreve6 := qryIteGer.FieldByName('ITE_PREVE6').AsFloat;
  objCalculaVariacaoPreco.fltPreve7 := qryIteGer.FieldByName('ITE_PREVE7').AsFloat;

end;

procedure TfrmCadProdutos.btnFatAcreClick(Sender: TObject);
  Var
    frmCadProFaixasMetragem: TfrmCadProFaixasMetragem;
begin
  inherited;

  Try
    If (Not Assigned(objFaixasMet)) Then
      objFaixasMet := TFaixasMetragem.Create(Self);

    objFaixasMet.strCodIte := qryTabela.FieldByName('ITE_CODITE').AsString;

    pCriarFormularios(TfrmCadProFaixasMetragem, frmCadProFaixasMetragem);
    frmCadProFaixasMetragem.objFaixasMet := objFaixasMet;
    frmCadProFaixasMetragem.ShowModal();
  Finally
    FreeAndNil(frmCadProFaixasMetragem);
  End;
end;

procedure TfrmCadProdutos.pCarregaDepartamento;
Begin
  edtDesDep.Text := fCampoTabela('DEP_DESCRI','CADDEP',['DEP_CODIGO'],[dbeCodDep.Text]);
End;

procedure TfrmCadProdutos.pCarregaDadosAdicionais;
  Var
    fltEntFutSoma: Double;
begin
  fltEntFutSoma := 0;

  objAtributos.fCarregaAtributos(qryTabela.FieldByName('ITE_CODITE').AsString);

  If fUsaQtdPendenteEntregaFutura And
     (qryTabela.RecordCount > 0) Then
  Begin
    fltEntFutSoma :=  TEntregaFutura.New(
                        TParamEF.New()
                          .CodIte(qryTabela.FieldByName('ITE_CODITE').AsString)
                          .CodEmp(VS_strCodEmp)
                          .TipoTE(tteTodas)
                        ).Total();
  End;

  dbeSaldos.Text := FloatToStrF(qryIteGer.FieldByName('ITE_SALDOS').AsFloat + fltEntFutSoma, ffNumber, 12, 3);

  pCarregaMarca;
  pCarregaFornecedor;
  pCarregaAbreviacao;
  pCarregaLinGru;
  pCarregaCadUni;
  pMontaTelaEstoque;
  pCarregaDepartamento;
  pCarregaOperador;
  pCarregaLocSep;
  pCarregaComplementoEtiquetas;
  pCarregaLayOrdInd;
  pCarregaProduto;
  pCarregaProdutoDiluente;


  if objLoteRastreamento.blnRastreamentoIndustrial then
  begin
    objLoteRastreamento.pAbreQuery(qryTabela.FieldByName('ITE_CODITE').AsString);
    lblDepartamentoLoteRastreamento.caption :=  'Tipo: ' + fRetDescricaoTipoDepartamentoOrdemProducaoIndustrial(dbeCodDep.Text);
  end;

  edtDesGpr.Text    := fRetNomeGrupoPrecos(dbeCodGpr.Text);
  edtDesPrdPro.Text := fRetNomeGrupoProduto(dbePrdGru.Text);
  edtDesUniCom.Text := fRetNomUnidade(dbeUniCom.Text);
  edtDesUniTri.Text := fRetNomUnidade(dbeUniTri.Text);
  edtDesEmpCar.Text := fRetNomeEmpresaSelec(dbeEmpCar.Text);

  If dbeCodGpc.Visible Then
    edtDesGpc.Text := fRetNomGpc(dbeCodGpc.Text);

  if fEmptyStr(qryTabela.FieldByName('ITE_CODPAG').AsString) then
    edtDesPag.Clear
  else
    edtDesPag.Text := qryTabela.FieldByName('ITE_CODPAG').AsString + ' - ' + fRetNomProduto(qryTabela.FieldByName('ITE_CODPAG').AsString);

  pAtualizaVariaveis;

  pIndicaMarcaBase;

  edtComLiq.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoCompraLiq());

  If (strMarMkp = '4') Then
    edtCusRea.Text := FormatFloat(fMskDigitos(4), fIVAMod4)
  Else
    edtCusRea.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaCustoReal);

  If qryTabela.IsEmpty Then
  Begin
    edtComLiq.Clear;
    edtCusRea.Clear;
  End;

  If Not blnCatalogo Then
  Begin
    objIteBar.pCarregaDados(qryTabela.FieldByName('ITE_CODITE').AsString);
    objIteMon.pCarregaDados(qryTabela.FieldByName('ITE_CODITE').AsString);
    objLocFis.fCarregaLocalizacoes(qryTabela.FieldByName('ITE_CODITE').AsString,
                                   qryIteGer.FieldByName('ITE_LOCFIS').AsString);
  End;

  edtSitPro.Text := fRetNomSituacaoProduto(dbeSitPro.Text);
  edtDesCom.Text := fRetDescricaoComposicao(dbeCodCom.Text);


  pnlLayOrdPro.Visible := fItemEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString);
  if pnlLayOrdPro.Visible then
    edtNomLayOrdPro.Text := fRetornaDescricaoLayoutEtq(dbeCodLayOrdPro.Text);

  pFechaUltimasComprasVendas;
  edtDesOnu.Text := fRetDescClassificacaoOnu(dbeCodOnu.Text);
  edtDesDic.Text := fRetDesDic(dbeCodDic.Text);

  edtDesAbfPis.Text := fRetDesAbfPis(dbeAbfPis.Text);
  edtDesAbfCof.Text := fRetDesAbfCof(dbeAbfCof.Text);
  edtDesAbfIpi.Text := fRetDesAbfIpi(dbeAbfIpi.Text);
  edtCestDesc.Text  := fRetDesCDCEST(dbeCDCEST.Text, dbeClaIpi.Text);
  edtDesAbfCon.Text := fCampoTabela('COG_DESCRI', 'ABFCOG', ['COG_CODIGO'], [dbeAbfCon.Text], False);

  pIndicaTipoProdutoSPED;
  pHabilitaCamposMateriaPrima;

  pCalculaPrecoVendaIdeal;

  If Assigned(objTabelas) Then
    objTabelas.fCarregaPrecos;

  If (Not fEmptyStr(qryTabela.FieldByName('ITE_CDCEST').AsString)) Then
    edtCestDesc.Text := fRetDesCDCEST(qryTabela.FieldByName('ITE_CDCEST').AsString);

  pAbreIteEmb;

  If (Assigned(objCadProdutosVeiculoModelo)) And
     (not fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString)) Then
    objCadProdutosVeiculoModelo.pIniciaProcesso(qryTabela.FieldByName('ITE_CODITE').AsString, '');
  pCarregaDadosSomenteLeitura(qryIteGer);

  If not qryTabela.IsEmpty Then
  Begin
    If qryTabela.FieldByName('ITE_CAREST').AsString = 'I' Then
      cmbCarEst.ItemIndex := 0
    Else
      cmbCarEst.ItemIndex := 1;
  End
  Else
    cmbCarEst.ItemIndex := 0;

end;

procedure TfrmCadProdutos.pHabilitaCamposMateriaPrima;
Begin

  pnlMateriaPrima.Visible := fCfgSis('UTIIND', VarBoolean) And
                             (fCampoTabela('DEP_PROMAP', 'CADDEP', ['DEP_CODIGO'], [dbeCodDep.Text]) = 'S');

  dbeAbsOle.Enabled := SameText(dbeECarga.Text, '1');
End;

procedure TfrmCadProdutos.pCarregaCadUni;
begin
  If not fEmptyStr(dbeCodUni.Text) Then
    edtDesUni.Text := fRetNomUnidade(dbeCodUni.Text)
  else
    edtDesUni.Clear;

  If fCfgSis('VENVID', varBoolean) Then
  Begin
    If fMetragemObrigatoria(dbeCodUni.Text) Then
    Begin
      gpbMetVid.Visible := True;

      If (fRetSiglaUnidade(dbeCodUni.Text) = 'M2') Then Begin
        lblMed1.Caption  := 'mm';
        lblMed2.Caption  := 'mm';
        lblMed3.Caption  := 'mm';
        lblMed4.Caption  := 'mm';
        lblMed7.Caption  := 'mm';
        lblMed8.Caption  := 'mm';
      End Else Begin
        lblMed1.Caption  := 'cm';
        lblMed2.Caption  := 'cm';
        lblMed3.Caption  := 'cm';
        lblMed4.Caption  := 'cm';
        lblMed7.Caption  := 'cm';
        lblMed8.Caption  := 'cm';
      End;
    End
    Else
    Begin
      gpbMetVid.Visible := False;
    End;
  End;
end;

{*****************************************}
{* GERA ITEGER PARA AS OUTRAS LOJAS      *}
{**************************************MV*}
procedure TfrmCadProdutos.pGeraIteGer;
  Var
    strEmpresas,
    strSQL     : String;
    intContador: Integer;
    strCamIte  : String;
    qryGenEmp  : TUniQuery;
    qryGenIte  : TUniQuery;
    qryIteGra  : TUniQuery;
    fltIcmsSTParteVenda : Double;
    blnST : Boolean;

  function fRetPrecoCustoInclusao: Double;
  begin
    Try

      With cpcParams, qryIteGra Do
      Begin
        curPreCom := FieldByName('ITE_PRECOM').AsFloat;
        curDesF01 := FieldByName('ITE_DESF01').AsFloat;
        curDesF02 := FieldByName('ITE_DESF02').AsFloat;
        curDesF03 := FieldByName('ITE_DESF03').AsFloat;
        curDesF04 := FieldByName('ITE_DESF04').AsFloat;
        curDesF05 := FieldByName('ITE_DESF05').AsFloat;
        curDesF06 := FieldByName('ITE_DESF06').AsFloat;
        curICMSEnt:= FieldByName('ITE_ICMENT').AsFloat;
        curIPIEnt := FieldByName('ITE_IPIENT').AsFloat;
        curFrete  := FieldByName('ITE_FREENT').AsFloat;
        curAcrFin := FieldByName('ITE_ACRFIN').AsFloat;
        curSubsti := FieldByName('ITE_SUBSTI').AsFloat;
        curValFre := FieldByName('ITE_VALFRE').AsFloat;
        curDesAdb := FieldByName('ITE_DESADB').AsFloat;
        curSubFed := FieldByName('ITE_SUBFED').AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := FieldByName('ITE_TCIFCU').AsFloat;
          curTSCust := FieldByName('ITE_TSCUST').AsFloat;
          curDePiCo := FieldByName('ITE_DEPICO').AsFloat;
          curDeICMS := FieldByName('ITE_DEICMS').AsFloat;
          curFatReg := FieldByName('ITE_FATREG').AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;

      Result := cpcParams.fCalculaPrecoCusto(IIF(chkPreDol.Checked, true, false));

    Finally

    End;
  End;

begin
  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  qryGenEmp := fCriaQuery(Self);
  qryGenIte := fCriaQuery(Self);
  qryIteGra := fCriaQuery(Self);

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FALSE ';

    With qryIteGra Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITEGER.* ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
      ParamByName('CODEMP').AsString := qryIteGer.FieldByName('ITE_CODEMP').AsString;
      Open;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' CADEMP.*, CID_ESTADO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';
    strSQL := strSQL + '  INNER JOIN CADCID ON CID_CODCID = EMP_CODCID ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  EMP_CODEMP <> :CODEMP ';

    With qryGenEmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      Open;
      First;

      While Not Eof Do
      Begin
        qryIteGra.Insert;

        For intContador := 0 To qryGenIte.FieldCount -1 Do
        Begin

          If (qryGenIte.Fields[intContador].FieldName = 'ITE_ABFPIS') Then
          Begin
            strCamIte := qryGenIte.Fields[intContador].FieldName;

            If fEmptyStr(fCfgSis('PADPIS', varString, FieldByName('EMP_CODEMP').AsString)) Then
              qryIteGra.FieldByName(strCamIte).Value := Null
            Else
              qryIteGra.FieldByName(strCamIte).Value := fCfgSis('PADPIS', varString, FieldByName('EMP_CODEMP').AsString);
          End
          Else If (qryGenIte.Fields[intContador].FieldName = 'ITE_ABFCOF') Then
          Begin
            strCamIte := qryGenIte.Fields[intContador].FieldName;

            If fEmptyStr(fCfgSis('PADCOF', varString, FieldByName('EMP_CODEMP').AsString)) Then
              qryIteGra.FieldByName(strCamIte).Value := Null
            Else
              qryIteGra.FieldByName(strCamIte).Value := fCfgSis('PADCOF', varString, FieldByName('EMP_CODEMP').AsString);
          End
          Else
          Begin
            strCamIte := qryGenIte.Fields[intContador].FieldName;
            qryIteGra.FieldByName(strCamIte).Value := qryGenIte.FieldByName(strCamIte).Value;
          End;

        End;

        If Not fCfgSis('CONIPI', varBoolean, FieldByName('EMP_CODEMP').AsString) Then
        Begin
          qryIteGra.FieldByName('ITE_IPISAI').AsFloat := 0.0;
        End;

        qryIteGra.FieldByName('ITE_LOCFIS').AsString  := '';
        qryIteGra.FieldByName('ITE_LOCSUP').AsString  := '';
        qryIteGra.FieldByName('ITE_LOCSEP').AsString  := '';
        qryIteGra.FieldByName('ITE_TAMLCF').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_TAMLCS').AsFloat   := 0.0;
//        qryIteGra.FieldByName('ITE_COMVAR').AsInteger := 0;
//        qryIteGra.FieldByName('ITE_COMATA').AsInteger := 0;
//        qryIteGra.FieldByName('ITE_COMDIS').AsInteger := 0;
//        qryIteGra.FieldByName('ITE_COMPRO').AsInteger := 0;
//        qryIteGra.FieldByName('ITE_COMMEC').AsInteger := 0;
        qryIteGra.FieldByName('ITE_SALBAL').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_SALDOS').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_SAL_ML').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_ML_BAL').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_PREMED').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_PREULT').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_IMPULT').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_DTAULT').AsString  := '';
        qryIteGra.FieldByName('ITE_QTDUCO').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_PREUVE').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_QTDUVE').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_TIPPRO').AsString  := qryIteGer.FieldByName('ITE_TIPPRO').AsString;
        qryIteGra.FieldByName('ITE_FORULT').Value     := qryIteGer.FieldByName('ITE_FORULT').Value;
        qryIteGra.FieldByName('ITE_NOTULT').Value     := qryIteGer.FieldByName('ITE_NOTULT').Value;
        qryIteGra.FieldByName('ITE_CODEMP').AsString  := FieldByName('EMP_CODEMP').AsString; // Código da Empresa...
        qryIteGra.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEGER', VS_strCodEmp);
        qryIteGra.FieldByName('ITE_DTAVAL').AsDateTime := qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime;
        qryIteGra.FieldByName('ITE_GARFIL').AsString  := 'N';
        qryIteGra.FieldByName('ITE_SITPRO').Clear;
        qryIteGra.FieldByName('ITE_CODABF').Clear;
        qryIteGra.FieldByName('ITE_ESTMIN').AsFloat   := 0.0;
        qryIteGra.FieldByName('ITE_ESTMAX').AsFloat   := 0.0;


        If Pos(qryGenEmp.FieldByName('CID_ESTADO').AsString, ESTADOS_REGRA_ZONA_FRANCA) > 0 Then
        Begin
          qryIteGra.FieldByName('ITE_CICMDE').AsString  := qryIteGer.FieldByName('ITE_CICMDE').AsString;
          qryIteGra.FieldByName('ITE_CDPIOP').AsString  := qryIteGer.FieldByName('ITE_CDPIOP').AsString;
          qryIteGra.FieldByName('ITE_DIDIOP').AsString  := qryIteGer.FieldByName('ITE_DIDIOP').AsString;
        End
        Else
        Begin
          qryIteGra.FieldByName('ITE_CICMDE').AsString  := 'N';
          qryIteGra.FieldByName('ITE_CDPIOP').AsString  := 'N';
          qryIteGra.FieldByName('ITE_DIDIOP').AsString  := 'N';
        End;





        If blnInfMat And fValidaEscala(FieldByName('EMP_TABPAD').AsString,  1 , Length(VS_strTabPrc)) Then
        Begin
          qryIteGra.FieldByName('ITE_MARBR' + FieldByName('EMP_TABPAD').AsString).AsFloat := FieldByName('EMP_MARPAD').AsFloat;

          // É POR EMPRESA OU NÃO É DO GRUPO
          If (intInfSai = 1) Or (Pos(FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
            qryIteGra.FieldByName('ITE_ICMSAI').AsFloat := FieldByName('EMP_ICMSAI').AsFloat;

          If (intInfFed = 1) Or (Pos(FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
            qryIteGra.FieldByName('ITE_IMPFED').AsFloat := FieldByName('EMP_IMPFED').AsFloat;

          If (intInfOpe = 1) Or (Pos(FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then // PEGA DA PROPRIA EMPRESA - CASO CONTRARIO JÁ FOI PREENCHIDO ACIMA
            qryIteGra.FieldByName('ITE_DESOPE').AsFloat := FieldByName('EMP_DESOPE').AsFloat;

          If (Not fEhEmpresaResponsavelFornecedor(dbeCodFor.Text)) And (Pos(FieldByName('EMP_CODEMP').AsString, strEmpresas) = 0) Then
          Begin
            qryIteGra.FieldByName('ITE_ICMENT').AsFloat := FieldByName('EMP_ICMENT').AsFloat;
            qryIteGra.FieldByName('ITE_SUBFED').AsFloat := FieldByName('EMP_SUBFED').AsFloat;
            qryIteGra.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCustoInclusao;
          End;

          fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST,
                                                      dbeCodAbr.Text,
                                                      fPreComLiq(qryIteGra),
                                                      qryIteGra.FieldByName('ITE_IPIENT').AsFloat,
                                                      qryIteGra.FieldByName('ITE_ICMSAI').AsFloat,
                                                      strMarMkp,
                                                      strEstadoEmpresa);

          For intContador := 1 To Length(VS_strTabPrc) Do
            qryIteGra.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat :=
                  fCalculaPrecoVenda(2,
                                     qryIteGra.FieldByName('ITE_PRECUS').AsFloat + qryIteGra.FieldByName('ITE_OUTVAL').AsFloat,
                                     qryIteGra.FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                                     qryIteGra.FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat,
                                     qryIteGra.FieldByName('ITE_ICMSAI').AsFloat,
                                     qryIteGra.FieldByName('ITE_IMPFED').AsFloat,
                                     qryIteGra.FieldByName('ITE_DESOPE').AsFloat,
                                     qryIteGra.FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat,
                                     '',
                                     '',
                                     -1,
                                     fltIcmsSTParteVenda,
                                     blnST);
        End;

        objLojas.pSetDadosInclusaoIndividual(qryIteGra);

        qryIteGra.Post;

        If fCfgSis('ITETBP', VarBoolean) Then
          pGravaDesMaxTabPre(qryIteGra.FieldByName('ITE_CODITE').AsString,
                             qryIteGra.FieldByName('ITE_CODEMP').AsString);

        If fCfgSis('DMVFQV', VarBoolean) Then
          GravaDesMaxFaixaQtde(qryIteGra.FieldByName('ITE_CODITE').AsString,
                               qryIteGra.FieldByName('ITE_CODEMP').AsString);

        Next;

        pStepStatusGravacao;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadProdutos.pGeraIteGer]');
    End;
  End;

  FreeAndNil(qryGenEmp);
  FreeAndNil(qryGenIte);
  FreeAndNil(qryIteGra);

end;

procedure TfrmCadProdutos.pGerarProdutosAcabados;
  Var
    frmSelecionaUnidadesCores: TfrmSelecionaUnidadesCores;
begin
  If fDepartamentosPreenchidos Then
  Begin
    //confirma tipo produto sped
    strTipoProd := qryIteGer.FieldByName('ITE_TIPPRO').AsString;
    If not TfrmConfirmaTipoProduto.fSelecionaTipoProduto(strTipoProd) Then
      Exit;

    //Seleciona as unidades e as cores para gerar os produtos acabados;
    Try
      pCriarFormularios(TfrmSelecionaUnidadesCores,frmSelecionaUnidadesCores);
      frmSelecionaUnidadesCores.strCodIte := qryTabela.FieldByName('ITE_CODITE').AsString;
      frmSelecionaUnidadesCores.ShowModal;

      If Assigned(frmSelecionaUnidadesCores.arrUnidades) And Assigned(frmSelecionaUnidadesCores.arrCores) Then
        pCadastrarProdutosAcabadosAutomaticamente(frmSelecionaUnidadesCores.arrUnidades, frmSelecionaUnidadesCores.arrCores, frmSelecionaUnidadesCores.arrComposicao);

    Finally
      FreeAndNil(frmSelecionaUnidadesCores);
    End;
  End;
end;

{*****************************************}
{* CARREGA OS CAMPOS QUE NÃO PODEM SER   *}
{* ATUALIZADOS VIA CADASTRO.             *}
{**************************************MV*}
procedure TfrmCadProdutos.pCarregaDadosSomenteLeitura(qryIteGer: TUniQuery);
  Var
    strSaldos: String;
    strSalBal: String;
    strSMlBal: String;
    strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor: String;
    fltFatorEmbCompra: Double;
begin
  fltFatorEmbCompra := qryTabela.FieldByName('ITE_EMBALA').AsFloat;

  strSaldos := FormatFloat ('#,###0.000', qryIteGer.FieldByName('ITE_SALDOS').AsFloat);
  strSalBal := FormatFloat ('#,###0.000', qryIteGer.FieldByName('ITE_SALBAL').AsFloat);
  strSMlBal := FormatFloat ('#,###0.000', qryIteGer.FieldByName('ITE_ML_BAL').AsFloat);

  edtUltCom.Text := qryIteGer.FieldByName('ITE_DTAULT').AsString;
  edtQtdUco.Text := FormatFloat('#,###0.000', qryIteGer.FieldByName('ITE_QTDUCO').AsFloat);
  edtPreUlt.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_PREULT').AsFloat);
  edtImpUlt.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_IMPULT').AsFloat);

  edtDtaUve.Text := qryIteGer.FieldByName('ITE_DTAUVE').AsString;
  edtQtdUve.Text := FormatFloat('#,###0.000', qryIteGer.FieldByName('ITE_QTDUVE').AsFloat);
  edtPreuve.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_PREUVE').AsFloat);
  edtPMED_V.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_PMED_V').AsFloat);
  edtPreMed.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_PREMED').AsFloat);

  If qryIteGer.FieldByName('ITE_ULTCOT').AsFloat <> 0 Then
    edtCotMoe.Text := FormatFloat('#,####0.0000', qryIteGer.FieldByName('ITE_ULTCOT').AsFloat);

  edtUltFor.Text    := qryIteGer.FieldByName('ITE_FORULT').AsString;
  edtNomUltFor.Text := fRetNomFornecedor(edtUltFor.Text);

  pDecodificaChaveNota(qryIteGer.FieldByName('ITE_NOTULT').AsString, strNumDoc, strEspDoc, strCodEmp, strSerie, strCodFor);

  edtUltNot.Text    := strEspDoc + '-' + strNumDoc + '-' + strCodEmp + IIF(fEmptyStr(strSerie), '', '-' + strSerie);

  If fltFatorEmbCompra > 0 Then
     edtEmbQtd.Text :=  FormatFloat('#,##0.0000', fStrToFloat(edtQtdUco.Text) / fltFatorEmbCompra)
  Else
    edtEmbQtd.Text := '0.0000';
  edtPreUltEmb.Text := FormatFloat('#,##0.0000', fltFatorEmbCompra * fStrToFloat(edtPreUlt.Text));
  edtPreImpUltEmb.Text := FormatFloat('#,##0.0000', fltFatorEmbCompra * fStrToFloat(edtImpUlt.Text));

  strMemPrecoUltCompraImp:= '';
  If Not(fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString)) And (fltFatorEmbCompra > 0) And
    (edtPreImpUltEmb.Text <> '0,0000') AND (edtPreUltEmb.Text <> '0,0000') Then
  Begin
    strMemPrecoUltCompraImp:= strMemPrecoUltCompraImp + 'Preços + Impostos Emb: ('+ #$A;
    strMemPrecoUltCompraImp:= strMemPrecoUltCompraImp + '                       Emabalagem ('+FormatFloat('#,##0.0000', StrToFloat(AnsiReplaceStr(FloatToStr(fltFatorEmbCompra), '.', '')))+') '+#$A;
    strMemPrecoUltCompraImp:= strMemPrecoUltCompraImp + '                     * Preços + Impostos Ultima Comp.(' +FormatFloat('#,##0.0000', StrToFloat(AnsiReplaceStr(edtImpUlt.Text, '.', '')))+'))'+#$A;
    strMemPrecoUltCompraImp:= strMemPrecoUltCompraImp + '                     = ' +edtPreImpUltEmb.Text;
  End;

  qryMemoriaCalculo.Close;

  If Not(fEmptyStr(strNumDoc)) And
     Not(fEmptyStr(strEspDoc)) And
     Not(fEmptyStr(strSerie)) Then  pCarregaDadosMemoriaCalculoPrecoMaisImpostoUltCompra(strNumDoc, strEspDoc, strCodEmp, strSerie);

end;

Procedure TfrmCadProdutos.pCarregaItemNaTela;
Begin
  pCarregaIteGer;

  If tbsExportaSite.TabVisible Then
  Begin
    FPanelDadosECommerce.fltVlrLiq := (fStrToFloat(fDbEditFocus('dbePreVe' + fCfgSis('TBPECO', varString)).Text));
    FPanelDadosECommerce.pCarregaDadosECommerce;
  End;


  pCarregaDadosAdicionais;
  pCarregaCadSfz;

  If (PnlAmz.Visible) Then
    pCarregaLotAmz(qryTabela.FieldByName('ITE_CODITE').AsString);

  pSetFocus(btnAlterar);

  pgcUltVendaCompra.ActivePageIndex := 0;
  rgpDadosUvc.ItemIndex := 0;
  pgcUltVendaCompraChange(pgcUltVendaCompra);
  pAjustaDolar;
  strCodIteExterno := dbeCodIte.Text;
  pUnidadeFracionada;
  pExecutaCalculoCFG_BEN_ST;

End;

Procedure TfrmCadProdutos.pCarregaItemNaTelaParte2;
Begin
  edtDesAbfPis.Text := fRetDesAbfPis(dbeAbfPis.Text);
  edtDesAbfCof.Text := fRetDesAbfCof(dbeAbfCof.Text);
  edtDesAbfIpi.Text := fRetDesAbfIpi(dbeAbfIpi.Text);
  edtCestDesc.Text  := fRetDesCDCEST(dbeCDCEST.Text, dbeClaIPI.Text);

  If not qryTabela.Active then
  begin
    qryIteGer.Close;
    qryIteGer.ParamByName('CODITE').AsString := '';
    qryIteGer.ParamByName('CODEMP').AsString := '';
    qryIteGer.Open;
    pCarregaDadosAdicionais;
  end;

  lblFatCMP.Visible := fValidarFatorMadeira_X_Pecas;
  dbeIteFatCMP.Visible := lblFatCMP.Visible;
  If not dbeIteFatCMP.Visible then
    dbeIteFatCMP.Text := '0';

  If btnEstrutura.Visible Then
    btnEstrutura.Enabled := qryTabela.Active And fEhOuCompoeEstrutura(qryTabela.FieldByName('ITE_CODITE').AsString).blnEstrutura;

  If btnTabFor.Visible Then
    btnTabFor.Enabled := qryTabela.Active And (not fEmptyStr(qryTabela.FieldByName('ITE_CODITE').AsString));

  blnPreDol := chkPreDol.Checked;

  dbeTipLoc.Enabled := (dbeReaLoc.Text = 'S');

  if (pnlEmpSug.Visible) and (not fEmptyStr(dbeCodEmpSug.Text)) then
  begin
    If fCfgSis('NOMEMP') = '2' Then
    Begin
      edtDesEmpSug.Text := fRetFantasiaEmpresa(dbeCodEmpSug.Text);
    End
    Else
    Begin
      edtDesEmpSug.Text := fRetNomeEmpresaSelec(dbeCodEmpSug.Text);
    End;
  end;
End;

procedure TfrmCadProdutos.btnPatVidClick(Sender: TObject);
begin
  inherited;
  If qryTabela.State In dsEditModes Then
    If openPatVid.Execute() Then
    Begin
      dbePatVid.Field.AsString := openPatVid.FileName;
      pSetFocus(dbePatVid);
    End;
end;

procedure TfrmCadProdutos.btnPesquisaClick(Sender: TObject);
  Var
    intOpcAtivos: Integer;
    chrKey: Char;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxItem;
    strTabPre: String;
    strCodProd: string;
begin
  strCodProd := '';
  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      pLimpaEdits;

      blnInsert := False;


      strTabPre := IIF(fEmptyStr(fCfgSis('TABPAD')), '1', fCfgSis('TABPAD'));
      chrKey    := '/';

      Try
        objfrmPnl := TPanelCxItem.New();
        Try
          {******************************************************************}
          {* NÃO CHAMA MAIS A COSULTA ESPECÍFICA, AGORA CHAMA A NOVA FUNÇÃO *}
          {***************************************************************AC*}

          intOpcAtivos := fMensagem('','Selecione o status dos itens:', ['Ativos', 'Inativos', 'Todos'], fRetornaUltimaEscolhaStatusProduto(strLoginUsuarioLogado));

          pArmazenaUltimaEscolhaStatusProduto(strLoginUsuarioLogado, intOpcAtivos);

          pSetaOpcStatusPro(intOpcAtivos);

          objFrmPnl.procMostraDocumentoReimpressao := pMostraDocumentoReimpressao;
          objFrmPnl.strNomForm := Self.Name;
          objFrmPnl.recParametros.strCodCli  := '';
          objFrmPnl.strCodVen  := '';
          objFrmPnl.strCodDig  := '';
          objFrmPnl.intPraMedio:= 0;
          objFrmPnl.blnFaturamento := True;
          objFrmPnl.recParametros.strTabPre  := strTabPre;
          objfrmPnl.strNumOrc  := '';
          objfrmPnl.strEspOrc  := '';
          objFrmPnl.procExibeAgregados := TfrmAgregados.pExibe;
          objFrmPnl.ProcExibeRequisicaoCompra := TfrmFatRequisicaoCompras.pExibe;

          If fPesqItem(conIteCompleta,
                       Self,
                       dbeCodIte,
                       Nil,
                       qryTabela,
                       chrKey,
                       arrSel,
                       True,
                       objfrmPnl,
                       'Consulta de Itens',
                       strTabPre,
                       '',
                       0,
                       false,
                       false,
                       intOpcAtivos,
                       cdrCodIte,
                       '',
                       False,
                       '',
                       '',
                       True,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       True) Then
          Begin
            pCarregaItemNaTela;
            pMontaCdsIteCom;
            objCalculaVariacaoPreco.fltPreve1 := qryIteGer.FieldByName('ITE_PREVE1').AsFloat;
            objCalculaVariacaoPreco.fltPreve2 := qryIteGer.FieldByName('ITE_PREVE2').AsFloat;
            objCalculaVariacaoPreco.fltPreve3 := qryIteGer.FieldByName('ITE_PREVE3').AsFloat;
            objCalculaVariacaoPreco.fltPreve4 := qryIteGer.FieldByName('ITE_PREVE4').AsFloat;
            objCalculaVariacaoPreco.fltPreve5 := qryIteGer.FieldByName('ITE_PREVE5').AsFloat;
            objCalculaVariacaoPreco.fltPreve6 := qryIteGer.FieldByName('ITE_PREVE6').AsFloat;
            objCalculaVariacaoPreco.fltPreve7 := qryIteGer.FieldByName('ITE_PREVE7').AsFloat;
            If blnCCDPRM Then
            begin
              If Assigned(FornecedorItemPalett) Then
                FreeAndNil(FornecedorItemPalett);
              FornecedorItemPalett := TFornecedorItemPalett.Create(Self, qryTabela.FieldByName('ITE_CODITE').AsString);
              dtsControlePallet.DataSet := FornecedorItemPalett;
            End;
          End;

        Except
          On E: Exception Do
          Begin
            if Pos('unsupported image format', LowerCase(E.Message)) > 0 then
            begin
              if (qryIteGer.Active) and (not fEmptyStr(qryIteGer.ParamByName('CODITE').AsString)) then
                strCodProd := qryIteGer.ParamByName('CODITE').AsString;

              pMensagemErroImagemProduto(strCodProd);
            end
            else
              pMensagensErro(E.Message, '[frmCadProdutos.btnPesquisaClick]');
          End;
        End;
      Finally
        FreeAndNil(objfrmPnl);
        pSetaQueryCadIte(qryTabela);
      End;

      pCarregaItemNaTelaParte2;

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmCadProdutos.btnTabForClick(Sender: TObject);
begin
  inherited;

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

      TfrmCadTabelaPrecos.pAbreTela(qryTabela.FieldByName('ITE_CODITE').AsString);

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

procedure TfrmCadProdutos.btnPraMinHelpClick(Sender: TObject);
Begin

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(221, 7755, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadProdutos.btnVenComClick(Sender: TObject);
begin
  inherited;
  If qryTabela.IsEmpty Then
    Exit;

  Try
    Screen.Cursor := crHourGlass;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fUltimasComprasVendas;
    frmGravando.ShowModal;

  Finally
    FreeAndNil(frmGravando);
    Screen.Cursor := crDefault;
  End;
end;

function TfrmCadProdutos.fUltimasComprasVendas(cxProgress : TcxProgressbar):Boolean;
  Var
    intIndex  : Integer;
    arrVendas,
    arrCompra : Array[0..2] of Double;
Begin
  Try
    frmGravando.lblGravando.Caption := 'Carregando Informações...';
    Application.ProcessMessages;

    pAbreQryGir;

    pCarregaUltVendas(qryTabela.FieldbyName('ITE_CODITE').AsString);
    If Not fItemEstrutura(qryTabela.FieldbyName('ITE_CODITE').AsString) Then
      pCarregaUltCompras(qryTabela.FieldbyName('ITE_CODITE').AsString);

    frmGravando.lblGravando.Caption := 'Processando Médias...';
    Application.ProcessMessages;

    cxProgress.Properties.Max := qryGirIte.RecordCount;
    cxProgress.Position := 0;

    Try
      qryGirIte.First;
      qryGirIte.DisableControls;
      While not qryGirIte.Eof Do
      Begin
        arrVendas[0] := 0;
        arrCompra[0] := 0;

        arrVendas[1] := 0;
        arrCompra[1] := 0;

        arrVendas[2] := 0;
        arrCompra[2] := 0;

        For intIndex := 12 DownTo 1 Do
        Begin
          if intIndex > 9 Then
          Begin
            arrVendas[0] := arrVendas[0] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_SAI').AsFloat;
            arrCompra[0] := arrCompra[0] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_ENT').AsFloat;
          End;

          if intIndex > 6 Then
          Begin
            arrVendas[1] := arrVendas[1] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_SAI').AsFloat;
            arrCompra[1] := arrCompra[1] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_ENT').AsFloat;
          End;

          arrVendas[2] := arrVendas[2] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_SAI').AsFloat;
          arrCompra[2] := arrCompra[2] + qryGirIte.FieldByName(stlCamNom[intIndex-1] + '_ENT').AsFloat;

        End;

        qryGirIte.Edit;

        qryGirIte.FieldByName('GIR_MEDI03_COM').AsFloat := arrCompra[0] / 3;
        qryGirIte.FieldByName('GIR_MEDI06_COM').AsFloat := arrCompra[1] / 6;
        qryGirIte.FieldByName('GIR_MEDI12_COM').AsFloat := arrCompra[2] / 12;

        qryGirIte.FieldByName('GIR_MEDI03_VEN').AsFloat := arrVendas[0] / 3;
        qryGirIte.FieldByName('GIR_MEDI06_VEN').AsFloat := arrVendas[1] / 6;
        qryGirIte.FieldByName('GIR_MEDI12_VEN').AsFloat := arrVendas[2] / 12;

        qryGirIte.Post;

        qryGirIte.Next;

        cxProgress.Position := cxProgress.Position + 1;
        Application.ProcessMessages;

      End;
      Result := True;

    Finally
      qryGirIte.First;
      qryGirIte.EnableControls;
    End;
  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCadProdutos.fUltimasComprasVendas');
      Result := False;
    End;

  End;

End;

function TfrmCadProdutos.fUtilizaMatrizLinhaGrupo: Boolean;
var
  qryMargem: TUniQuery;
begin
  qryMargem := fCriaQuery;
  try
    qryMargem.Close;
    qryMargem.SQL.Clear;
    qryMargem.SQL.Add('SELECT COUNT(*) AS TOTAL FROM PROMAT');
    qryMargem.Open;

    Result := qryMargem.FieldByName('TOTAL').AsInteger > 0;
  finally
    FreeAndNil(qryMargem);
  end;
end;

procedure TfrmCadProdutos.cbxAplicarTodasClick(Sender: TObject);
begin
  inherited;

  If cbxAplicarTodas.Checked Then
  Begin
    If fMensagem('AVISO', 'Esta operação irá repassar as informaçõe Loc.Super Estoque' + #13 +
                          'e Capacidade Loc.Super Estoque para todas as empresas.' + #13 +
                          'Confirma a operação ?'  , ['&Sim', '&Não'], 2) = 2 Then
    Begin
      cbxAplicarTodas.Checked := False;
      Abort;
    End;
  End;
end;

procedure TfrmCadProdutos.chkPreDolClick(Sender: TObject);
begin
  inherited;
  If (fStrToFloat(dbePreCom.Text) <> 0) And
     (qryIteGer.Active)                 And
     (qryIteGer.State <> dsBrowse)Then
    pValidarPrecos(dbePreCom);
  pAjustaDolar;
end;

procedure TfrmCadProdutos.cxredtDesMaxPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If Not fValidaEscala(VarToStr(DisplayValue), 0, 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'O desconto máximo deve estar entre 0 e 100!', ['&Ok']);
    DisplayValue := '0';
    Error := False;
  End;

end;

procedure TfrmCadProdutos.cxVeiculoProdutoViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
  var recCamposVeiculo: TCamposVeiculo;

begin
  inherited;
  If  Assigned(objCadProdutosVeiculoModelo) Then
  begin

    If qryTabela.State in dsEditModes Then
    Begin
      objCadProdutosVeiculoModelo.pCarregaDadosRegistroEdicao(recCamposVeiculo);
      edtDescMarVei.Text := recCamposVeiculo.strDescrMarca;
      edtDescMarVei.Referencia := recCamposVeiculo.strCodMarca;
      edtDescModVei.Text := recCamposVeiculo.strDescrModelo;
      edtDescModVei.Referencia := recCamposVeiculo.strCodModelo;
      mskAnoInicial.Text := TCadProdutosVeiculoModelo.fZeroToVazio(recCamposVeiculo.intAnoIni);
      mskAnoFin.Text := TCadProdutosVeiculoModelo.fZeroToVazio(recCamposVeiculo.intAnoFim);
      edtValvula.Text := TCadProdutosVeiculoModelo.fZeroToVazio(recCamposVeiculo.IntValvulas);
      edtCilindrada.Text := recCamposVeiculo.strCilindrada;
      edtObservacoes.Text := recCamposVeiculo.strObservacoes;
      edtPotencia.Text := TCadProdutosVeiculoModelo.fZeroToVazio(recCamposVeiculo.intPotencia);
      cmbCombustivel.ItemIndex := cmbCombustivel.Items.IndexOf(recCamposVeiculo.strCombustivel);
      pSetFocus(edtDescMarVei);
    End;
  End;
end;

procedure TfrmCadProdutos.cxVeiculoProdutoViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
  Begin

    If (Assigned(objCadProdutosVeiculoModelo)) And
       (qryTabela.State in dsEditModes) Then
    Begin
      If objCadProdutosVeiculoModelo.DataSource.DataSet.IsEmpty Then
        Exit;
      If Not fPergunta('Remover esta relação entre o produto e o veiculo?') Then
        Exit;
      objCadProdutosVeiculoModelo.pDelete;
    End;
  End;


end;

procedure TfrmCadProdutos.cxbGiroComprasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: Begin
                 pProximaPagina;
                 If tbsFornecedores.Visible Then
                  pSetFocus(edtCodForn);
               End;
    VK_ESCAPE: btnSairClick(Sender);
  End;

end;

procedure TfrmCadProdutos.cxbGiroVendasKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: Begin
                 pProximaPagina;
                 If tbsFornecedores.Visible Then
                  pSetFocus(edtCodForn);
               End;
    VK_ESCAPE: btnSairClick(Sender);
  End;

end;

procedure TfrmCadProdutos.cxvLojasCODEMPCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If Not AViewInfo.Selected Then
    ACanvas.Font.Color := clBlue;

end;

procedure TfrmCadProdutos.cxvLojasColumn1PropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    pMensagemOk('O Estoque mínimo digitado deve ser maior ou igual a zero!');
    ErrorText := '';
    Error     := True;
  End;

end;


procedure TfrmCadProdutos.cxvLojasEMPCENPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  objLojas.pPost;
end;

procedure TfrmCadProdutos.cxvLojasESTMAXPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    pMensagemOk('O Estoque máximo deve ser maior ou igual a zero!');
    ErrorText := '';
    Error     := True;
  End

  Else If fStrToFloat(DisplayValue) < objLojas.FieldByName('ESTMIN').AsFloat Then
  Begin
    pMensagemOk('O Estoque máximo deve ser maior ou igual ao estoque mínimo!');
    ErrorText := '';
    Error     := True;
  End;

end;

procedure TfrmCadProdutos.cxvLojasESTMINPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    pMensagemOk('O Estoque mínimo deve ser maior ou igual a zero!');
    ErrorText := '';
    Error     := True;
  End;

end;

procedure TfrmCadProdutos.cxvLojasMINDIGPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    pMensagemOk('O Estoque mínimo digitado deve ser maior ou igual a zero!');
    ErrorText := '';
    Error     := True;
  End;

end;

procedure TfrmCadProdutos.cxvLojasPONPEDPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  If fStrToFloat(DisplayValue) < 0 Then
  Begin
    pMensagemOk('O Ponto de Pedido deve ser maior ou igual a zero!');
    ErrorText := '';
    Error     := True;
  End;

end;

procedure TfrmCadProdutos.cxvLojasSITPROPropertiesCloseUp(Sender: TObject);
begin
  inherited;

  objLojas.pPost;
end;

procedure TfrmCadProdutos.cxvPalettDblClick(Sender: TObject);
begin
  inherited;
  FornecedorItemPalettRecord := FornecedorItemPalett.fInciaEdicao;
  If FornecedorItemPalettRecord.strAutoincrem = semRegistros Then
  Begin
    FornecedorItemPalettRecord.strAutoincrem := '';
    Exit;
  End;

  edtCodForPal.Text := FornecedorItemPalettRecord.strCodFor;
  edtDesForPal.Text := FornecedorItemPalettRecord.strDesFor;
  edtQtdItePal.Text := FormatFloat('#0.0000', FornecedorItemPalettRecord.fltQtdite);
  edtValPalet.Text  := FormatFloat('#0.0000', FornecedorItemPalettRecord.fltValPal);
  pSetFocus(edtCodForPal);
end;

procedure TfrmCadProdutos.pAtualizaIteGer(blnResFor: Boolean);
  Var
    strUPD: String;
    intTabPre: Integer;
    strEmpresas: String;
    strCodEmp: String;
    stlEmpresas: TStringList;
    qryUpdate : TUniQuery;
begin
  If blnPreMat Then
    Exit;

  {********************************************************************}
  {* CASO FOR EMPRESA GERENCIAL E SOMENTE A MESMA POSSAR REPLICAR     *}
  {* OS PRECOS, OU QUALQUER EMPRESA POSSA REPLICAR OS PRECOS ENTAO    *}
  {* ATUALIZA ITEGER EM OUTRAS EMPRESAS                               *}
  {*****************************************************************JC*}
  strEmpresas := fRetEmpresasUsamPrecoMatriz;

  If strEmpresas = (VS_strCodEmp + '_') Then
    Exit;

  qryUpdate := fCriaQuery(Self);

  strUPD := '';
  strUPD := strUPD + 'UPDATE ';
  strUPD := strUPD + '  ITEGER ';
  strUPD := strUPD + 'SET ';

  If fCfgSis('TPSPED') = '1' Then
    strUPD := strUPD + ' ITE_TIPPRO = :TIPPRO, ';

  strUPD := strUPD + '  ITE_PREALT = :PREALT, ';

  If Not blnTabPrd Then
  Begin
    strUPD := strUPD + '  ITE_PREDOL = :PREDOL, ';
    strUPD := strUPD + '  ITE_PRECOM = :PRECOM, ';
    strUPD := strUPD + '  ITE_IPIENT = :IPIENT, ';
    strUPD := strUPD + '  ITE_FREENT = :FREENT, ';
    strUPD := strUPD + '  ITE_VALFRE = :VALFRE, ';
    strUPD := strUPD + '  ITE_PRECUS = :PRECUS, ';
    strUPD := strUPD + '  ITE_DESF01 = :DESF01, ';
    strUPD := strUPD + '  ITE_DESF02 = :DESF02, ';
    strUPD := strUPD + '  ITE_DESF03 = :DESF03, ';
    strUPD := strUPD + '  ITE_DESF04 = :DESF04, ';
    strUPD := strUPD + '  ITE_DESF05 = :DESF05, ';
    strUPD := strUPD + '  ITE_DESF06 = :DESF06, ';
    strUPD := strUPD + '  ITE_ACRFIN = :ACRFIN, ';
    strUPD := strUPD + '  ITE_ICMENT = :ICMENT, ';
    strUPD := strUPD + '  ITE_SUBFED = :SUBFED, ';
    strUPD := strUPD + '  ITE_SUBSTI = :SUBSTI, ';
    strUPD := strUPD + '  ITE_DESADB = :DESADB  ';
  End;

  If Not blnResFor Then
  Begin
    If Not blnTabPrd Then
    Begin
      strUPD := strUPD + ',  ';

      If (Not blnInfMat) Or (intInfFed = 2) Then
        strUPD := strUPD + '  ITE_IMPFED = :IMPFED, ';

      If (Not blnInfMat) Or (intInfOpe = 2)  Then
        strUPD := strUPD + '  ITE_DESOPE = :DESOPE, ';

      If (Not blnInfMat) Or (intInfSai = 2)  Then
        strUPD := strUPD + '  ITE_ICMSAI = :ICMSAI, ';

      strUPD := strUPD + '  ITE_OUTVAL = :OUTVAL, ';
      strUPD := strUPD + '  ITE_MARBR1 = :MARBR1, ';
      strUPD := strUPD + '  ITE_MARBR2 = :MARBR2, ';
      strUPD := strUPD + '  ITE_MARBR3 = :MARBR3, ';
      strUPD := strUPD + '  ITE_MARBR4 = :MARBR4, ';
      strUPD := strUPD + '  ITE_MARBR5 = :MARBR5, ';
      strUPD := strUPD + '  ITE_MARBR6 = :MARBR6, ';
      strUPD := strUPD + '  ITE_MARBR7 = :MARBR7, ';
      strUPD := strUPD + '  ITE_COMTB1 = :COMTB1, ';
      strUPD := strUPD + '  ITE_COMTB2 = :COMTB2, ';
      strUPD := strUPD + '  ITE_COMTB3 = :COMTB3, ';
      strUPD := strUPD + '  ITE_COMTB4 = :COMTB4, ';
      strUPD := strUPD + '  ITE_COMTB5 = :COMTB5, ';
      strUPD := strUPD + '  ITE_COMTB6 = :COMTB6, ';
      strUPD := strUPD + '  ITE_COMTB7 = :COMTB7, ';
      strUPD := strUPD + '  ITE_PREVE1 = :PREVE1, ';
      strUPD := strUPD + '  ITE_PREVE2 = :PREVE2, ';
      strUPD := strUPD + '  ITE_PREVE3 = :PREVE3, ';
      strUPD := strUPD + '  ITE_PREVE4 = :PREVE4, ';
      strUPD := strUPD + '  ITE_PREVE5 = :PREVE5, ';
      strUPD := strUPD + '  ITE_PREVE6 = :PREVE6, ';
      strUPD := strUPD + '  ITE_PREVE7 = :PREVE7, ';

      strUPD := strUPD + '  ITE_TCIFCU = :TCIFCU, ';
      strUPD := strUPD + '  ITE_TSCUST = :TSCUST, ';
      strUPD := strUPD + '  ITE_DEPICO = :DEPICO, ';
      strUPD := strUPD + '  ITE_DEICMS = :DEICMS, ';
      strUPD := strUPD + '  ITE_FATREG = :FATREG, ';
    End;

    strUPD := strUPD + '  ITE_DESMAX = :DESMAX, ';
    strUPD := strUPD + '  ITE_DESMSU = :DESMSU, ';
    strUPD := strUPD + '  ITE_DESMGE = :DESMGE, ';

    strUPD := strUPD + '  ITE_DESMVM = :DESMVM, ';
    strUPD := strUPD + '  ITE_DESMSM = :DESMSM, ';
    strUPD := strUPD + '  ITE_DESMGM = :DESMGM, ';

    strUPD := strUPD + '  ITE_ABAMLT = :ABAMLT, ';
    strUPD := strUPD + '  ITE_MARMIN = :MARMIN, ';
    strUPD := strUPD + '  ITE_MARMSG = :MARMSG, ';
    strUPD := strUPD + '  ITE_MARMGE = :MARMGE, ';
    strUPD := strUPD + '  ITE_COMVAR = :COMVAR, ';
    strUPD := strUPD + '  ITE_COMATA = :COMATA, ';
    strUPD := strUPD + '  ITE_COMDIS = :COMDIS, ';
    strUPD := strUPD + '  ITE_COMDIG = :COMDIG, ';
    strUPD := strUPD + '  ITE_COMMEC = :COMMEC, ';
    strUPD := strUPD + '  ITE_TPCOMC = :TPCOMC, ';
    strUPD := strUPD + '  ITE_COMPRO = :COMPRO, ';
    strUPD := strUPD + '  ITE_RECDEV = :RECDEV  ';

    If fCfgSis('IPI_IG') = '1' Then
      strUPD := strUPD + '  ,ITE_IPISAI = :IPISAI ';
  End;

  strUPD := strUPD + 'WHERE ';
  strUPD := strUPD + '  ITE_CODITE = :CODITE AND ';

  If blnResFor Then
    strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
  Else
    strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';

  With qryUpdate Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strUPD);
    {*****************************************}
    {* DADOS PARA O FILTRO                   *}
    {**************************************MV*}
    ParamByName('CODITE').AsString := qryIteGer.FieldByName('ITE_CODITE').AsString;
    ParamByName('CODEMP').AsString := strEmpresas;

    {*****************************************}
    {* DADOS QUE SERÃO ATUALIZADOS           *}
    {**************************************MV*}
    If fCfgSis('TPSPED') = '1' Then
      ParamByName('TIPPRO').AsString := qryIteGer.FieldByName('ITE_TIPPRO').AsString;

    If Not blnTabPrd Then
    Begin
      ParamByName('PREDOL').Value   := qryIteGer.FieldByName('ITE_PREDOL').Value;
      ParamByName('PRECOM').AsFloat := qryIteGer.FieldByName('ITE_PRECOM').AsFloat;
      ParamByName('IPIENT').AsFloat := qryIteGer.FieldByName('ITE_IPIENT').AsFloat;
      ParamByName('FREENT').AsFloat := qryIteGer.FieldByName('ITE_FREENT').AsFloat;
      ParamByName('VALFRE').AsFloat := qryIteGer.FieldByName('ITE_VALFRE').AsFloat;
      ParamByName('PRECUS').AsFloat := qryIteGer.FieldByName('ITE_PRECUS').AsFloat;
      ParamByName('DESF01').AsFloat := qryIteGer.FieldByName('ITE_DESF01').AsFloat;
      ParamByName('DESF02').AsFloat := qryIteGer.FieldByName('ITE_DESF02').AsFloat;
      ParamByName('DESF03').AsFloat := qryIteGer.FieldByName('ITE_DESF03').AsFloat;
      ParamByName('DESF04').AsFloat := qryIteGer.FieldByName('ITE_DESF04').AsFloat;
      ParamByName('DESF05').AsFloat := qryIteGer.FieldByName('ITE_DESF05').AsFloat;
      ParamByName('DESF06').AsFloat := qryIteGer.FieldByName('ITE_DESF06').AsFloat;
      ParamByName('ACRFIN').AsFloat := qryIteGer.FieldByName('ITE_ACRFIN').AsFloat;
      ParamByName('ICMENT').AsFloat := qryIteGer.FieldByName('ITE_ICMENT').AsFloat;
      ParamByName('SUBFED').AsFloat := qryIteGer.FieldByName('ITE_SUBFED').AsFloat;
      ParamByName('SUBSTI').AsFloat := qryIteGer.FieldByName('ITE_SUBSTI').AsFloat;
      ParamByName('DESADB').AsFloat := qryIteGer.FieldByName('ITE_DESADB').AsFloat;
      ParamByName('TCIFCU').AsFloat := qryIteGer.FieldByName('ITE_TCIFCU').AsFloat;
      ParamByName('TSCUST').AsFloat := qryIteGer.FieldByName('ITE_TSCUST').AsFloat;
      ParamByName('DEPICO').AsFloat := qryIteGer.FieldByName('ITE_DEPICO').AsFloat;
      ParamByName('DEICMS').AsFloat := qryIteGer.FieldByName('ITE_DEICMS').AsFloat;
      ParamByName('FATREG').AsFloat := qryIteGer.FieldByName('ITE_FATREG').AsFloat;
    End;

    If Not blnResFor Then
    Begin
      If fCfgSis('IPI_IG') = '1' Then
        ParamByName('IPISAI').AsFloat := qryIteGer.FieldByName('ITE_IPISAI').AsFloat;

      If Not blnTabPrd Then
      Begin
        If (Not blnInfMat) Or (intInfFed = 2) Then
          ParamByName('IMPFED').AsFloat := qryIteGer.FieldByName('ITE_IMPFED').AsFloat;

        If (Not blnInfMat) Or (intInfOpe = 2) Then
          ParamByName('DESOPE').AsFloat := qryIteGer.FieldByName('ITE_DESOPE').AsFloat;

        If (Not blnInfMat) Or (intInfSai = 2) Then
          ParamByName('ICMSAI').AsFloat := qryIteGer.FieldByName('ITE_ICMSAI').AsFloat;

        For IntTabPre := 1 To Length(VS_strTabPrc) Do
        Begin
          ParamByName('MARBR' + IntToStr(IntTabPre)).AsFloat := qryIteGer.FieldByName('ITE_MARBR' + IntToStr(IntTabPre)).AsFloat;
          ParamByName('COMTB' + IntToStr(IntTabPre)).AsFloat := qryIteGer.FieldByName('ITE_COMTB' + IntToStr(IntTabPre)).AsFloat;
          ParamByName('PREVE' + IntToStr(IntTabPre)).AsFloat := qryIteGer.FieldByName('ITE_PREVE' + IntToStr(IntTabPre)).AsFloat;
        End;

        ParamByName('OUTVAL').AsFloat  := qryIteGer.FieldByName('ITE_OUTVAL').AsFloat;
      End;

      ParamByName('DESMAX').AsFloat  := qryIteGer.FieldByName('ITE_DESMAX').AsFloat;
      ParamByName('DESMSU').AsFloat  := qryIteGer.FieldByName('ITE_DESMSU').AsFloat;
      ParamByName('DESMGE').AsFloat  := qryIteGer.FieldByName('ITE_DESMGE').AsFloat;

      ParamByName('DESMVM').AsFloat  := qryIteGer.FieldByName('ITE_DESMVM').AsFloat;
      ParamByName('DESMSM').AsFloat  := qryIteGer.FieldByName('ITE_DESMSM').AsFloat;
      ParamByName('DESMGM').AsFloat  := qryIteGer.FieldByName('ITE_DESMGM').AsFloat;

      ParamByName('ABAMLT').AsString := qryIteGer.FieldByName('ITE_ABAMLT').AsString;
      ParamByName('MARMIN').AsFloat  := qryIteGer.FieldByName('ITE_MARMIN').AsFloat;
      ParamByName('MARMSG').AsFloat  := qryIteGer.FieldByName('ITE_MARMSG').AsFloat;
      ParamByName('MARMGE').AsFloat  := qryIteGer.FieldByName('ITE_MARMGE').AsFloat;
      ParamByName('COMVAR').AsFloat  := qryIteGer.FieldByName('ITE_COMVAR').AsFloat;
      ParamByName('COMATA').AsFloat  := qryIteGer.FieldByName('ITE_COMATA').AsFloat;
      ParamByName('COMDIS').AsFloat  := qryIteGer.FieldByName('ITE_COMDIS').AsFloat;
      ParamByName('COMDIG').AsFloat  := qryIteGer.FieldByName('ITE_COMDIG').AsFloat;
      ParamByName('COMPRO').AsFloat  := qryIteGer.FieldByName('ITE_COMPRO').AsFloat;
      ParamByName('COMMEC').AsFloat  := qryIteGer.FieldByName('ITE_COMMEC').AsFloat;
      ParamByName('TPCOMC').AsString := qryIteGer.FieldByName('ITE_TPCOMC').AsString;
      ParamByName('RECDEV').AsString := qryIteGer.FieldByName('ITE_RECDEV').AsString;
    End;

    ParamByName('PREALT').AsString := strAgrupadorPreAlt;

    ExecSQL;
    Close;

    If Not blnResFor Then
    Begin
      stlEmpresas := TStringList.Create;
      stlEmpresas.Text := AnsiReplaceStr(strEmpresas, '_', #13#10);

      For strCodEmp In stlEmpresas Do
        If Not fEmptyStr(strCodEmp) Then
          pGravaDesMaxTabPre(qryIteger.FieldByName('ITE_CODITE').AsString, strCodEmp);

        If fCfgSis('DMVFQV', VarBoolean) Then
          GravaDesMaxFaixaQtde(qryIteger.FieldByName('ITE_CODITE').AsString, strCodEmp);

      stlEmpresas.Destroy;
    End;
  End;


  If Not blnTabPrd Then
  Begin
    If blnPreDol <> chkPreDol.Checked Then
      pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(qryIteger.FieldByName('ITE_CODITE').AsString);

    If blnInfMat Then
      pRecalculaItensResponsavelFornecedor(strEmpresas, qryIteGer.FieldByName('ITE_CODITE').AsString, blnResFor);
  End;

  FreeAndNil(qryUpdate);
end;

function TfrmCadProdutos.fRetPrecoCusto(blnUtilizarConversorDeMoeda: Boolean; qryExt: TUniQuery = nil): Double;
begin
  Try

    If fEmptyStr(dbePreCom.Text) Then
      dbePreCom.Field.Value := 0;

    If fEmptyStr(dbeDesf01.Text) Then
      dbeDesf01.Field.Value := 0;

    If fEmptyStr(dbeDesf02.Text) Then
      dbeDesf02.Field.Value := 0;

    If fEmptyStr(dbeDesf03.Text) Then
      dbeDesf03.Field.Value := 0;

    If fEmptyStr(dbeDesf04.Text) Then
      dbeDesf04.Field.Value := 0;

    If fEmptyStr(dbeDesf05.Text) Then
      dbeDesf05.Field.Value := 0;

    If fEmptyStr(dbeDesf06.Text) Then
      dbeDesf06.Field.Value := 0;

    If fEmptyStr(dbeIcmEnt.Text) Then
      dbeIcmEnt.Field.Value := 0;

    If fEmptyStr(dbeIpiEnt.Text) Then
      dbeIpiEnt.Field.Value := 0;

    If fEmptyStr(dbeFreEnt.Text) Then
      dbeFreEnt.Field.Value := 0;

    If fEmptyStr(dbeValFre.Text) Then
      dbeValFre.Field.Value := 0;

    If fEmptyStr(dbeAcrFin.Text) Then
      dbeAcrFin.Field.Value := 0;

    If fEmptyStr(dbeSubsti.Text) Then
      dbeSubsti.Field.Value := 0;

    If fEmptyStr(dbeImpFed.Text) Then
      dbeImpFed.Field.Value := 0;

    If fEmptyStr(dbeSubFed.Text) Then
      dbeSubFed.Field.Value := 0;

    If fEmptyStr(dbeDesOpe.Text) Then
      dbeDesOpe.Field.Value := 0;

    If fEmptyStr(dbeTCIF.Text) Then
      dbeTCIF.Field.Value := 0;

    If fEmptyStr(dbeTS.Text) Then
      dbeTS.Field.Value := 0;

    If fEmptyStr(dbeDePiCo.Text) Then
      dbeDePiCo.Field.Value := 0;

    If fEmptyStr(dbeDeICMS.Text) Then
      dbeDeICMS.Field.Value := 0;

    If fEmptyStr(dbeFatReg.Text) Then
      dbeFatReg.Field.Value := 0;

    {**********************************}
    {* CALCULA PREÇOS DE CUSTO        *}
    {*******************************JB*}
    With cpcParams Do
    Begin
      If Assigned(qryExt) Then
      begin
        curPreCom := qryExt.FieldByName(dbePreCom.Field.FieldName).AsFloat;
        curDesF01 := qryExt.FieldByName(dbeDesf01.Field.FieldName).AsFloat;
        curDesF02 := qryExt.FieldByName(dbeDesf02.Field.FieldName).AsFloat;
        curDesF03 := qryExt.FieldByName(dbeDesf03.Field.FieldName).AsFloat;
        curDesF04 := qryExt.FieldByName(dbeDesf04.Field.FieldName).AsFloat;
        curDesF05 := qryExt.FieldByName(dbeDesf05.Field.FieldName).AsFloat;
        curDesF06 := qryExt.FieldByName(dbeDesf06.Field.FieldName).AsFloat;
        curICMSEnt:= qryExt.FieldByName(dbeIcmEnt.Field.FieldName).AsFloat;
        curIPIEnt := qryExt.FieldByName(dbeIpiEnt.Field.FieldName).AsFloat;
        curFrete  := qryExt.FieldByName(dbeFreEnt.Field.FieldName).AsFloat;
        curAcrFin := qryExt.FieldByName(dbeAcrFin.Field.FieldName).AsFloat;
        curSubsti := qryExt.FieldByName(dbeSubsti.Field.FieldName).AsFloat;
        curValFre := qryExt.FieldByName(dbeValFre.Field.FieldName).AsFloat;
        curDesAdb := qryExt.FieldByName(dbeDesAdb.Field.FieldName).AsFloat;
        curSubFed := qryExt.FieldByName(dbeSubFed.Field.FieldName).AsFloat;

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := qryExt.FieldByName(dbeTCIF.Field.FieldName).AsFloat;
          curTSCust := qryExt.FieldByName(dbeTS.Field.FieldName).AsFloat;
          curDePiCo := qryExt.FieldByName(dbeDePiCo.Field.FieldName).AsFloat;
          curDeICMS := qryExt.FieldByName(dbeDeICMS.Field.FieldName).AsFloat;
          curFatReg := qryExt.FieldByName(dbeFatReg.Field.FieldName).AsFloat;
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End
      Else
      Begin
        curPreCom := fStrToFloat(dbePreCom.Text);
        curDesF01 := fStrToFloat(dbeDesf01.Text);
        curDesF02 := fStrToFloat(dbeDesf02.Text);
        curDesF03 := fStrToFloat(dbeDesf03.Text);
        curDesF04 := fStrToFloat(dbeDesf04.Text);
        curDesF05 := fStrToFloat(dbeDesf05.Text);
        curDesF06 := fStrToFloat(dbeDesf06.Text);
        curICMSEnt:= fStrToFloat(dbeIcmEnt.Text);
        curIPIEnt := fStrToFloat(dbeIpiEnt.Text);
        curFrete  := fStrToFloat(dbeFreEnt.Text);
        curAcrFin := fStrToFloat(dbeAcrFin.Text);
        curSubsti := fStrToFloat(dbeSubsti.Text);
        curValFre := fStrToFloat(dbeValFre.Text);
        curDesAdb := fStrToFloat(dbeDesAdb.Text);
        curSubFed := fStrToFloat(dbeSubFed.Text);

        if (fCfgSis('SUFRAM', varBoolean)) and (fCfgSis('FRMCUS', varString) = '4') then
        begin
          curTCIFCu := fStrToFloat(dbeTCIF.Text);
          curTSCust := fStrToFloat(dbeTS.Text);
          curDePiCo := fStrToFloat(dbeDePiCo.Text);
          curDeICMS := fStrToFloat(dbeDeICMS.Text);
          curFatReg := fStrToFloat(dbeFatReg.Text);
        end
        else
        begin
          curTCIFCu := 0;
          curTSCust := 0;
          curDePiCo := 0;
          curDeICMS := 0;
          curFatReg := 0;
        end;
      End;
    End;

    Result := cpcParams.fCalculaPrecoCusto(blnUtilizarConversorDeMoeda);

  Finally

  End;

end;

Procedure TfrmCadProdutos.pRecalculaPrecosFator(qryIteExec: TUniQuery= nil);
  Var
    intContador: Integer;
    fltIcmsSTParteVenda : Double;
    blnST : Boolean;
Begin
  If Not blnFatPre Then
    Exit;

  If not Assigned(qryIteExec) Then
    qryIteExec:= qryIteger;

  With qryIteExec Do
  For intContador := 2 To 7 Do
  Begin
    FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat :=
      objFatPre.fCalculaPrecoVendaFator(FieldByName('ITE_PREVE1').AsFloat, intContador);

    fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST,
                                                dbeCodAbr.Text,
                                                fPreComLiq(qryIteger),
                                                FieldByName('ITE_IPIENT').AsFloat,
                                                FieldByName('ITE_ICMSAI').AsFloat,
                                                strMarMkp,
                                                strEstadoEmpresa);

    FieldByName('ITE_MARBR' + IntToStr(intContador)).AsFloat :=
      fCalculaPrecoVenda(2,
                         FieldByName('ITE_PRECUS').AsFloat + FieldByName('ITE_OUTVAL').AsFloat,
                         FieldByName('ITE_PREVE' + IntToStr(intContador)).AsFloat,
                         0,
                         FieldByName('ITE_ICMSAI').AsFloat,
                         FieldByName('ITE_IMPFED').AsFloat,
                         FieldByName('ITE_DESOPE').AsFloat,
                         FieldByName('ITE_COMTB' + IntToStr(intContador)).AsFloat,
                         '',
                         '',
                         -1,
                         fltIcmsSTParteVenda,
                         blnST);
  End;
  If qryIteExec = qryIteger Then
    pAjustaDolar;
End;

function TfrmCadProdutos.fRetPrecoVenda(intOpcao, intNumPreVen: Integer; qryExt: TUniQuery = nil): Double;
  Var
    intCont: Integer;
    blnST: Boolean;
    fltIcmsSTParteVenda : Double;
begin
  If Assigned(qryExt) Then
  Begin
    If intNumPreVen In [1..Length(VS_strTabPrc)] Then
    Begin
      If (intOpcao = 2 {Margem}) Or (Not blnFatPre) Or (intNumPreVen = 1) Then
      Begin
        fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, qryExt.FieldByName(dbeCodAbr.Field.FieldName).AsString,
                                    fCalculaPrecoCompraLiq(qryExt),
                                    qryExt.FieldByName(dbeIpiEnt.Field.FieldName).AsFloat,
                                    qryExt.FieldByName(dbeIcmSai.Field.FieldName).AsFloat,
                                    strMarMkp,
                                    strEstadoEmpresa);

        Result := fCalculaPrecoVenda(intOpcao,
                                     qryExt.FieldByName(dbePreCus.Field.FieldName).AsFloat + qryExt.FieldByName(dbeOutVal.Field.FieldName).AsFloat,
                                     qryExt.FieldByName(fDbEditFocus('dbePreVe' + IntToStr(intNumPreVen)).Field.FieldName).AsFloat,
                                     qryExt.FieldByName(fDbEditFocus('dbeMarBr' + IntToStr(intNumPreVen)).Field.FieldName).AsFloat,
                                     qryExt.FieldByName(dbeIcmSai.Field.FieldName).AsFloat,
                                     qryExt.FieldByName(dbeImpFed.Field.FieldName).AsFloat,
                                     qryExt.FieldByName(dbeDesOpe.Field.FieldName).AsFloat,
                                     qryExt.FieldByName(fDbEditFocus('dbeComTb' + IntToStr(intNumPreVen)).Field.FieldName).AsFloat,
                                     '',
                                     '',
                                     -1,
                                     fltIcmsSTParteVenda,
                                     blnST);

      End
      Else If intOpcao = 1 Then
        Result := qryExt.FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat

      Else Result := qryExt.FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat;


    End
    Else
    Begin
      Result := -1;
      fMensagem('', 'fRetPrecoVenda: Escolha a Opção 1 a 7!', ['&Ok']);
    End;
  End
  Else
  Begin
    If (fEmptyStr(dbeIcmSai.Text)) Then
      dbeIcmSai.Text := '0,00';

    If (fEmptyStr(dbeOutVal.Text)) Then
      dbeOutVal.Text := '0,00';

    For IntCont := 1 To Length(VS_strTabPrc) Do
    Begin
      If fEmptyStr(fDbEditFocus('dbePreVe' + IntToStr(intCont)).Text) Then
        fDbEditFocus('dbePreVe' + IntToStr(intCont)).Text := '0,00';

      If fEmptyStr(fDbEditFocus('dbeMarBr' + IntToStr(intCont)).Text) Then
        fDbEditFocus('dbeMarBr' + IntToStr(intCont)).Text := '0,00';

      If fEmptyStr(fDbEditFocus('dbeComTb' + IntToStr(intCont)).Text) Then
        fDbEditFocus('dbeComTb' + IntToStr(intCont)).Text := '0,00';
    End;

    If intNumPreVen In [1..Length(VS_strTabPrc)] Then
    Begin
      If (intOpcao = 2 {Margem}) Or (Not blnFatPre) Or (intNumPreVen = 1) Then
      Begin
        fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, dbeCodAbr.Text, fCalculaPrecoCompraLiq, fStrToFloat(dbeIpiEnt.Text), fStrToFloat(dbeIcmSai.Text),
                                                      strMarMkp,
                                                      strEstadoEmpresa);

        Result := fCalculaPrecoVenda(intOpcao,
                                     fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                                     fStrToFloat(fDbEditFocus('dbePreVe' + IntToStr(intNumPreVen)).Text),
                                     fDbEditFocus('dbeMarBr' + IntToStr(intNumPreVen)).Field.AsFloat,
                                     fStrToFloat(dbeIcmSai.Text),
                                     fStrToFloat(dbeImpFed.Text),
                                     fStrToFloat(dbeDesOpe.Text),
                                     fStrToFloat(fDbEditFocus('dbeComTb' + IntToStr(intNumPreVen)).Text),
                                     '',
                                     '',
                                     -1,
                                     fltIcmsSTParteVenda,
                                     blnST);
      End

      Else If intOpcao = 1 Then
        Result := qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intNumPreVen)).AsFloat

      Else Result := qryIteGer.FieldByName('ITE_MARBR' + IntToStr(intNumPreVen)).AsFloat;

    End
    Else
    Begin
      Result := -1;
      fMensagem('', 'fRetPrecoVenda: Escolha a Opção 1 a 7!', ['&Ok']);
    End;
  End;
end;

{*****************************************}
{* MONTA A TELA DE ESTOQUE DE ACORDO COM *}
{* A TABELA ITEGER                       *}
{**************************************MV*}
procedure TfrmCadProdutos.pMontaTelaEstoque;
begin
  objLojas.fCarregaInfoLojas(qryIteger);
  objLojas.pCarregaPontoExposicao;
  cxvLojas.NavigatorButtons.First.Click;
  cxvLojas.ApplyBestFit;
  cxvLojas.Bands[0].Width := 130;
  cxvLojasCODEMP.Width := 57;
end;

(*
function TfrmCadProdutos.fBuscaChaveEstrangeira(strTable,
  strChave: String): Boolean;
  Var
    strAux: String;
    intCon: Integer;
begin
  intCon := 0;
  strAux := Copy(strChave, Pos(';', strChave) + 1, Length(strChave));
  While (Pos('/', strAux) > 0) Do
  Begin
    Application.ProcessMessages;

    strAux := Copy(strAux, Pos('/', strAux) + 1, Length(strAux));
    If (Copy(strAux, 1, Pos('`', strAux) - 1) = strTable) Then
    Begin
      Result := True;
      strAux := '';
    End;
  End;
end;
*)

procedure TfrmCadProdutos.pReplicarIteEmbEmpresas;
  Var
    qryIteEmb: TUniQuery;
    qryCadEmp: TUniQuery;

  Const
    SQL_CADEMP = 'SELECT EMP_CODEMP FROM CADEMP ';

    SQL_ITEEMB_INSERT = 'INSERT INTO ITEEMB (AUTOINCREM, ' +
                                            'ITB_CODEMP, ' +
                                            'ITB_CODITE, ' +
                                            'ITB_DESCON, ' +
                                            'ITB_PRIROM, ' +
                                            'ITB_QTDEMB, ' +
                                            'ITB_TABPRE  ' +
                                            ') VALUES (' +
                                            ':AUTINC, ' +
                                            ':CODEMP, ' +
                                            ':CODITE, ' +
                                            ':DESCON, ' +
                                            ':PRIROM, ' +
                                            ':QTDEMB, ' +
                                            ':TABPRE)';
    SQL_ITEEMB_UPDATE = 'UPDATE ITEEMB SET ITB_CODEMP = :CODEMP, ' +
                                          'ITB_CODITE = :CODITE, ' +
                                          'ITB_DESCON = :DESCON, ' +
                                          'ITB_PRIROM = :PRIROM, ' +
                                          'ITB_QTDEMB = :QTDEMB, ' +
                                          'ITB_TABPRE = :TABPRE  ' +
                        ' WHERE AUTOINCREM = :AUTINC';
    SQL_ITEEMB_DELETE = 'DELETE FROM ITEEMB WHERE ITB_CODITE = :CODITE AND ITB_QTDEMB = :QTDEMB AND ITB_CODEMP <> :CODEMP';

  procedure pInitQuerys; begin
    qryCadEmp := fCriaQuery(Self);

    qryCadEmp.Close();
    qryCadEmp.SQL.Clear();
    qryCadEmp.SQL.Add(SQL_CADEMP);
//    qryCadEmp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCadEmp.Open();

    qryIteEmb := fCriaQuery(Self);
  end;

  procedure pInitCdsIteEmb; begin
    cdsIteEmb.DisableControls();
    cdsIteEmb.Filter   := 'ITB_CODEMP = ' + VS_strCodEmp;
    cdsIteEmb.Filtered := True;

    cdsIteEmb.First();
  end;

  procedure pDeletaTodos();
  begin
    qryIteEmb.Close();
    qryIteEmb.SQL.Clear();

    qryIteEmb.SQL.Add('DELETE FROM ITEEMB');
    qryIteEmb.SQL.Add(' WHERE ITB_CODITE = :CODITE');

    If cdsIteEmb.FieldByName('ITB_CODITE').AsString <> '' Then
      qryIteEmb.ParamByName('CODITE').AsString := cdsIteEmb.FieldByName('ITB_CODITE').AsString
    Else
      qryIteEmb.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;

    qryIteEmb.ExecSQL();
  end;


  procedure pSalvarRegistroIteEmb(strAutInc: String);
  begin
    qryIteEmb.Close();
    qryIteEmb.SQL.Clear();

    qryIteEmb.SQL.Add(SQL_ITEEMB_INSERT);
    qryIteEmb.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
    qryIteEmb.ParamByName('CODEMP').AsString := qryCadEmp.FieldByName('EMP_CODEMP').AsString;
    qryIteEmb.ParamByName('CODITE').AsString := cdsIteEmb.FieldByName('ITB_CODITE').AsString;
    qryIteEmb.ParamByName('DESCON').AsFloat  := cdsIteEmb.FieldByName('ITB_DESCON').AsFloat;
    qryIteEmb.ParamByName('PRIROM').AsString := cdsIteEmb.FieldByName('ITB_PRIROM').AsString;
    qryIteEmb.ParamByName('QTDEMB').AsFloat  := cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat;
    qryIteEmb.ParamByName('TABPRE').Value    := cdsIteEmb.FieldByName('ITB_TABPRE').Value;

    qryIteEmb.ExecSQL();
  end;

  function fPossuiRegistroEmpresa: String; begin
    Result := (fCampoTabela('AUTOINCREM',
                            'ITEEMB',
                            ['ITB_CODEMP', 'ITB_CODITE', 'ITB_QTDEMB'],
                            [qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                             cdsIteEmb.FieldByName('ITB_CODITE').AsString,
                             cdsIteEmb.FieldByName('ITB_QTDEMB').AsString]));
  end;

  function fConsultaRegistroEmpresa: String; begin
    Result := (fCampoTabela('AUTOINCREM',
                            'ITEEMB',
                            ['ITB_CODEMP', 'ITB_CODITE'],
                            [qryCadEmp.FieldByName('EMP_CODEMP').AsString,
                             cdsIteEmb.FieldByName('ITB_CODITE').AsString]));
  end;

  function fRegistroAlterado: Boolean;
    Var
      blnAltPriRom: Boolean;
      strOldTabPre, strNewTabPre: String;
  begin
    If (cdsIteEmb.FieldByName('ITB_TABPRE').OldValue = Null) Then
      strOldTabPre := ''
    Else
      strOldTabPre := cdsIteEmb.FieldByName('ITB_TABPRE').OldValue;

    If (cdsIteEmb.FieldByName('ITB_TABPRE').NewValue = Null) Then
      strNewTabPre := ''
    Else
      strNewTabPre := cdsIteEmb.FieldByName('ITB_TABPRE').NewValue;

    If (cdsIteEmb.RecordCount = 1) Then
      blnAltPriRom := False
    Else
      blnAltPriRom := cdsIteEmb.FieldByName('ITB_PRIROM').OldValue <> cdsIteEmb.FieldByName('ITB_PRIROM').NewValue;

    Result := (cdsIteEmb.FieldByName('ITB_DESCON').OldValue <> cdsIteEmb.FieldByName('ITB_DESCON').NewValue) Or
              (blnAltPriRom) Or
              (cdsIteEmb.FieldByName('ITB_QTDEMB').OldValue <> cdsIteEmb.FieldByName('ITB_QTDEMB').NewValue) Or
              (strOldTabPre <> strNewTabPre);
  end;

  procedure pDeletarRegistros; Var i: Integer; begin
    qryIteEmb.Close();
    qryIteEmb.SQL.Clear();
    qryIteEmb.SQL.Add(SQL_ITEEMB_DELETE);

    For i := 0 To Length(arrIteEmbDel) - 1 Do Begin
      qryIteEmb.ParamByName('CODITE').AsString := arrIteEmbDel[i].strCodIte;
      qryIteEmb.ParamByName('QTDEMB').AsFloat  := arrIteEmbDel[i].fltQtdEmb;
      qryIteEmb.ParamByName('CODEMP').AsString := VS_strCodEmp;

      qryIteEmb.ExecSQL();
    End;
  end;
begin
  Try
    pInitQuerys();

    Try
      pInitCdsIteEmb();
      //Deleta todos;
      pDeletaTodos;

      While (Not cdsIteEmb.Eof) Do Begin
        qryCadEmp.First();

        While (Not qryCadEmp.Eof) Do Begin
//          If (Not fRegistroAlterado()) Then
          pSalvarRegistroIteEmb(fPossuiRegistroEmpresa());
//          Else
//            pSalvarRegistroIteEmb(fConsultaRegistroEmpresa());

          qryCadEmp.Next();
        End;

        cdsIteEmb.Next();
      End;

//      pDeletarRegistros();

      SetLength(arrIteEmbDel, 0);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadProdutos.pReplicarIteEmbEmpresas]');
    End;
  Finally
    cdsIteEmb.Filter   := '';
    cdsIteEmb.Filtered := False;
    cdsIteEmb.EnableControls();

    FreeAndNil(qryCadEmp);
    FreeAndNil(qryIteEmb);
  End;
end;

function TfrmCadProdutos.dbeCodMarChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadMar(Key);
  //pAtribuiTabelas;
  //pZeraCamposNumericos;
end;

function TfrmCadProdutos.dbeCodForChamaCadastro(Key: Word): String;
begin
  inherited;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  Result := untFuncIns.fChamaCadFor(Key);
  //pAtribuiTabelas;
  //pZeraCamposNumericos;
end;

procedure TfrmCadProdutos.dbeCodForEnter(Sender: TObject);
begin
  inherited;
  strForAnt := dbeCodFor.Text;
end;

procedure TfrmCadProdutos.dbeCodForExit(Sender: TObject);
  Var
    strTabelas,
    strTabAti: String;
begin
  inherited;

  If Assigned(objTabelas) And (qryTabela.State <> dsInsert) And (strForAnt <> dbeCodFor.Text) Then
  Begin
    strTabAti := objTabelas.fBuscaTabelaAtiva(dbeCodFor.Text, dbeCodIte.Text);

    If Not fEmptyStr(strTabAti) Then
    Begin
      strTabelas := objTabelas.fEscolheTabelaPreco;

      If Not strTabelas.IsEmpty Then
      Begin
        objTabelas.fRecarregaTabelasPreco(strTabelas, strTabAti);
        strForAnt := dbeCodFor.Text;
      End Else
      Begin
        dbeCodFor.Field.AsString := strForAnt;
        pSetFocus(dbeCodFor);
      End;

    End Else
    Begin
      qryTabela.FieldbyName('ITE_CODFOR').AsString := strForAnt;
      edtNomFor.Text := fRetNomFornecedor(dbeCodFor.Text);
      pMensagemOk('Não há tabela de preço ativa para esse fornecedor e o item ' + dbeCodIte.Text + '!');
      pSetFocus(dbeCodFor);
    End;

  End;

end;

function TfrmCadProdutos.dbeCodUniChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadUni(Key);
  //pAtribuiTabelas;
  //pZeraCamposNumericos;
end;

function TfrmCadProdutos.dbeCdCestChamaCadastro(Key: Word): string;
begin
  inherited;
  pCriarForm(TfrmCadCest);
end;

procedure TfrmCadProdutos.dbeCdCestKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
    var qryCEST: TUniQuery;
begin
  inherited;
  If Not fEntraCons(Key) Then
    Exit;

  If fEmptyStr(dbeClaIpi.Text) Then
  Begin
    Key := #0;
    fMensagem('Atenção', 'Não existe ncm informado.', ['&OK']);
    Exit;
  End;

  If Not fExisteCestParaNCM(dbeClaIpi.Text) Then
  Begin
    Key := #0;
    fMensagem('Atenção', 'Não existe CEST cadastrado com o ncm informado.', ['&OK']);
    Exit;
  End;

  Try
    qryCEST := fCriaQuery;
    If fPesqCest(Self,  DBECDCEST,  edtCestDesc,  qryCEST, Key, arrSel, True, dbeClaIpi.Text) Then
      If fValidaCampos(DBECDCEST) Then
        SelectNext(ActiveControl, True, True);
  Finally
    FreeAndNil(qryCEST);
  End;
end;

procedure TfrmCadProdutos.dbeClaIpiKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  Begin
    dbeClaIpi.Field.AsString := qryCadNcm.FieldByName('NCM_CODNCM').AsString;
    dbeExcIpi.Field.AsString := qryCadNcm.FieldByName('NCM_CODEXC').AsString;

    If fValidaCampos(dbeClaIpi) And fValidaCampos(dbeExcIpi) Then
      SelectNext(dbeExcIpi, True, True);
  End;
end;

function TfrmCadProdutos.dbeCodAbrChamaCadastro(Key: Word): String;
  Var
    frmCadAbreviacaoFiscal: TfrmCadAbreviacaoFiscal;
begin
  inherited;
  pCriarFormularios(TfrmCadAbreviacaoFiscal, frmCadAbreviacaoFiscal);
  Try
    frmCadAbreviacaoFiscal.strAbrExterna := dbeCodAbr.Text;
    frmCadAbreviacaoFiscal.Showmodal;
  Finally
    FreeAndNil(frmCadAbreviacaoFiscal)
  End;
end;

procedure TfrmCadProdutos.pGravaPreAlt;
begin
  If Not VS_blnPreAltViaTrigger Then
    fGravaPreAlt(qryIteGer.FieldByName('ITE_CODITE').AsString,
              fltCusAnt,
              qryIteGer.FieldByName('ITE_PRECUS').AsFloat,
              fltVe1Ant,
              qryIteGer.FieldByName('ITE_PREVE1').AsFloat,
              fltMa1Ant,
              qryIteGer.FieldByName('ITE_MARBR1').AsFloat,
              fltVe2Ant,
              qryIteGer.FieldByName('ITE_PREVE2').AsFloat,
              fltMa2Ant,
              qryIteGer.FieldByName('ITE_MARBR2').AsFloat,
              fltVe3Ant,
              qryIteger.FieldByName('ITE_PREVE3').AsFloat,
              fltMa3Ant,
              qryIteGer.FieldByName('ITE_MARBR3').AsFloat,
              fltVe4Ant,
              qryIteger.FieldByName('ITE_PREVE4').AsFloat,
              fltMa4Ant,
              qryIteGer.FieldByName('ITE_MARBR4').AsFloat,
              fltVe5Ant,
              qryIteger.FieldByName('ITE_PREVE5').AsFloat,
              fltMa5Ant,
              qryIteGer.FieldByName('ITE_MARBR5').AsFloat,
              fltVe6Ant,
              qryIteger.FieldByName('ITE_PREVE6').AsFloat,
              fltMa6Ant,
              qryIteGer.FieldByName('ITE_MARBR6').AsFloat,
              fltVe7Ant,
              qryIteger.FieldByName('ITE_PREVE7').AsFloat,
              fltMa7Ant,
              qryIteGer.FieldByName('ITE_MARBR7').AsFloat,

              fltComAnt,
              qryIteGer.FieldByName('ITE_PRECOM').AsFloat,

               'CADASTRO DE PRODUTOS');

end;

procedure TfrmCadProdutos.pGravaTabelaComissao;
var
  qryEmpresas,
  qryComissao: TUniQuery;
  intIndice: integer;
begin
  qryEmpresas := fCriaQuery;
  qryComissao := fCriaQuery;

  try
    qryEmpresas.Close;
    qryComissao.SQL.Clear;

    qryEmpresas.Close;
    qryComissao.SQL.Clear;

    qryComissao.SQL.Add('INSERT INTO COMTAB(AUTOINCREM, TAB_CODITE, TAB_CODEMP, TAB_CODFOR, TAB_CODGRU, TAB_CODMAR, TAB_CODUNI, TAB_TABELA, TAB_COMVAR, TAB_COMATA, TAB_COMDIS)');
    qryComissao.SQL.Add('VALUES(:AUTINC, :CODITE, :CODEMP, :CODFOR, :CODGRU, :CODMAR, :CODUNI, :TABELA, :COMVAR, :COMATA, :COMDIS)');

    qryEmpresas.SQL.Add('SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP');
    qryEmpresas.Open;

    while not qryEmpresas.Eof do
    begin
      for intIndice := 1 to 7 do
      begin
        qryComissao.Close;
        qryComissao.ParamByName('AUTINC').AsString  := fRetAutoIncrem('COMTAB', qryEmpresas.FieldByName('EMP_CODEMP').AsString);
        qryComissao.ParamByName('CODITE').AsString  := dbeCodIte.Text;
        qryComissao.ParamByName('CODEMP').AsString  := qryEmpresas.FieldByName('EMP_CODEMP').AsString;
        qryComissao.ParamByName('CODFOR').AsString  := dbeCodFor.Text;
        qryComissao.ParamByName('CODGRU').AsString  := dbeCodGru.Text;
        qryComissao.ParamByName('CODMAR').AsString  := dbeCodMar.Text;
        qryComissao.ParamByName('CODUNI').AsString  := dbeCodUni.Text;
        qryComissao.ParamByName('TABELA').AsInteger := intIndice;
        qryComissao.ParamByName('COMVAR').AsFloat   := fStrToFloat(dbeComVar.Text);
        qryComissao.ParamByName('COMATA').AsFloat   := fStrToFloat(dbeComAta.Text);
        qryComissao.ParamByName('COMDIS').AsFloat   := fStrToFloat(dbeComDis.Text);
        qryComissao.Execute;
      end;

      qryEmpresas.Next;
    end;
  finally
    FreeAndNil(qryEmpresas);
    FreeAndNil(qryComissao);
  end;
end;

function TfrmCadProdutos.dbeCodGruChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadGru(Key);
  //pAtribuiTabelas;
  //pZeraCamposNumericos;
end;

procedure TfrmCadProdutos.pHabilitaIcms;
begin
  If Not fCalcIcms Then
  Begin
    dbeIcmEnt.Enabled := False;
    dbeIcmSai.Enabled := False;

    If qryIteGer.State = dsInsert Then
    Begin
      qryIteGer.FieldByName('ITE_ICMENT').AsFloat := 0.0;
      qryIteGer.FieldByName('ITE_ICMSAI').AsFloat := 0.0;
    End;

  End;
end;

procedure TfrmCadProdutos.pHabilitaIntegracaoGS1CNP;
begin
  btnGs1Cnp.Visible    := fCfgSis('GS1CNP', varBoolean);
  lblTemPro.Visible    := btnGs1Cnp.Visible;
  dbeTemPro.Visible    := btnGs1Cnp.Visible;
  lblDtaLanMer.Visible := btnGs1Cnp.Visible;
  dbeDtaLan.Visible    := btnGs1Cnp.Visible;
  lblCodGpc.Visible    := btnGs1Cnp.Visible;
  dbeCodGpc.Visible    := btnGs1Cnp.Visible;
  edtDesGpc.Visible    := btnGs1Cnp.Visible;
end;

procedure TfrmCadProdutos.pDeletIteAgr(strCodIte: String);
Var
  qryGen : TUniQuery;
begin
  Try
    Try
      qryGen := fCriaQuery;

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Text:='DELETE FROM CADAGR WHERE AGR_CODITE=:AGR_CODITE';
        ParamByName('AGR_CODITE').AsString := strCodIte;
        ExecSQL;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadProdutos.pDeletIteAgr]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadProdutos.pDesabilitaCamposCadIte;
begin
  //dbeCodGru.Enabled := False;
  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    dbeCodIte.Enabled := False;
    dbeDtaCad.Enabled := False;
    dbeDesIte.Enabled := False;
    dbeRefere.Enabled := False;
    dbeCodMar.Enabled := False;
    dbeCodFor.Enabled := False;
    dbeCodFab.Enabled := False;

//    dbeCodBar.Enabled := False;
//    dbeBarEmb.Enabled := False;

    If tbsExportaSite.TabVisible Then
      FPanelDadosECommerce.pHabilitaEdicao(False);

    objIteBar.pHabilitaEdicao(False);
    objIteMon.pHabilitaEdicao(False);
    objlocFis.pHabilitaEdicao(False);

    dbeCodUni.Enabled := False;
    dbeUniCom.Enabled := False;
    dbeUniTri.Enabled := False;
    dbeFatUTr.Enabled := False;
    //dbeCodAbr.Enabled := False;
    dbeClaIpi.Enabled := False;
    dbeExcIpi.Enabled := False;
    dbeIncPis.Enabled := False;
    dbeComLub.Enabled := False;

    {********************************************}
    {* SE IMPRIMIR LISTA INDIVIDUAL POR EMPRESA *}
    {* PERMITE EDITAR O CAMPO IMPRIME LISTA.    *}
    {*****************************************PZ*}
    If (fCfgSis('ILIEMP', varString) = 'N') Then
      dbeImpLis.Enabled := False;

    {APERET = Utilizar controle de destino ""Apenas Retira / Apenas Entrega"" no Cadastro de Produtos?}
    If fCfgSis('APERET', varBoolean) Then
    Begin

      {Apenas retira por empresa?}
      If (fCfgSis('RETITE') = 'E') Then
      Begin
        dbeApeRet.Enabled := False;
        dbeApeRet.Color   := $00FFDFB8;
      End;

      {Apenas entrega por empresa?}
      If (fCfgSis('APNENT') = 'E') Then
      Begin
        dbeApeEnt.Enabled := False;
        dbeApeEnt.Color   := $00FFDFB8;
      End;

    End;

    dbeIteAti.Enabled := False;
    dbeAtiCom.Enabled := False;
    dbePesoIt.Enabled := False;
    dbePesLiq.Enabled := False;
    pSetFocus(dbePreCom);
  End;
end;

procedure TfrmCadProdutos.dbeCodGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  {********************************}
  {* NOVA CONSULTA DE LINHA/GRUPO *}
  {*****************************RV*}
  If fPesqGrupo(Self, dbeCodGru, Nil, qryConGru, Key, arrGrupos) Then
  Begin
    If fValidaCampos(dbeCodGru) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeCodLseKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocSep : TConsultasArray;
begin
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************MM*}
  If fPesqLocSep(Self, dbeCodLse, edtDesLse, Nil, Key, arrLocSep) Then
  Begin
    If fValidaCampos(dbeCodLse, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeCodMarKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, dbeCodMar, edtDesMar, Nil, Key, arrMarca, True, (qryTabela.FieldByName('ITE_ITEATI').AsString = 'S')) Then
  Begin
    If fValidaCampos(dbeCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.dbeCodOnuKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClaOnu : TConsultasArray;
begin
  inherited;
  If fPesqClassificacaoOnu(Self, dbeCodOnu, edtDesOnu, nil, Key, arrClaOnu) Then
  Begin
    If fValidaCampos(dbeCodOnu, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, dbeCodFor, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeCodUniKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
  inherited;
  utcRegistros.Limpar(Self.Name + 'CADUNI');

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := Key;
  if fPesqUnidade(Self, dbeCodUni, edtDesUni, Nil, qryConUni, chrKey, arrUnidades) then
  begin
    If fValidaCampos(dbeCodUni, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadProdutos.dbeComponenteAExit(Sender: TObject);
begin
  inherited;

  If (dbeComponenteA.Text <> '') Then
  Begin
    If (dbeComponenteA.Text <> 'S') and (dbeComponenteA.Text <> 'N') Then
    Begin
      fMensagem('ATENÇÃO!', 'Campos: Componente "A" e "B" so é permitido valores "S" ou "N"!', ['&Ok']);
      Exit;
    End;
  End;

  If (dbeComponenteB.Text <> '') Then
  Begin
    If (dbeComponenteB.Text <> 'S') and (dbeComponenteB.Text <> 'N') Then
    Begin
      fMensagem('ATENÇÃO!', 'Campos: Componente "A" e "B" so é permitido valores "S" ou "N"!', ['&Ok']);
      Exit;
    End;
  End;


  If ((dbeComponenteA.Text = 'S') and (dbeComponenteB.Text = 'S')) Then
  Begin
    fMensagem('ATENÇÃO!', 'Campos: Componente "A" e "B" na formulação, não podem estar juntamente habilitados!', ['&Ok']);
    dbeComponenteB.Field.Value:= 'N';
  End Else

  pnlDesclComponeteAB.Enabled:= False;
  pnlCatalise.Enabled:= False;

  if (dbeComponenteB.Text = 'S') then
  Begin
    If (qryTabela.State = dsEdit) Then
    Begin
      if (dbeValorCatalise.Field.IsNull) then
        dbeValorCatalise.Field.AsFloat:= 0;
      dbeProduto.Field.Value:= Null;
      edtDesProduto.Text:= '';
      dbeProdutoDiluente.Field.Value:= Null;
      edtDescProdutoDiluente.Clear;
      dbeProduto.Enabled:= False;
      dbeProdutoDiluente.Enabled:= False;
      pnlCatalise.Enabled:= True;

    End;
  end Else
  if (dbeComponenteA.Text = 'S') then
  Begin
    If (qryTabela.State = dsEdit) Then
    Begin
      pnlDesclComponeteAB.Enabled:= True;
      pnlCatalise.Enabled:= True;
    End;
  end Else
  if (dbeComponenteA.Text = 'N') then
  Begin
    If (qryTabela.State = dsEdit) Then
    Begin
      dbeValorCatalise.Field.AsFloat:= 0;
      dbeProduto.Field.Value:= Null;
      edtDesProduto.Text:= '';
      dbeProdutoDiluente.Field.Value:= Null;
      edtDescProdutoDiluente.Clear;
      pnlDesclComponeteAB.Enabled:= False;
      pnlCatalise.Enabled:= False;
    End;
  end;

end;

procedure TfrmCadProdutos.dbeComponenteBKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If key = #13 then
  Begin
    If pnlCatalise.Enabled Then
      pSetFocus(dbeValorCatalise);
  End;
end;

procedure TfrmCadProdutos.dbeCodAbrKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin

  If fPesqAbrevFiscal(Self, dbeCodAbr, edtDesAbf, qryConAbf, Key, arrSel, True, dbeClaIpi.Text, dbeExcIpi.Text) Then
  Begin
    If fValidaCampos(dbeCodAbr, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmCadProdutos.dbeCodDepExit(Sender: TObject);
begin
  inherited;
  {*****************************************************************}
  {* NÃO IRÁ MAIS DESABILITAR OS PREÇOS QUANDO FOR PRODUTO A GRANEL*}
  {**************************************************************PZ*}
  //pVerificaDepartamentoIndustrial;

  pControlaCampoComposicao;

end;

procedure TfrmCadProdutos.dbeCodDepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrDep: TConsultasArray;
begin
  inherited;
  If fPesqDepartamento(Self, dbeCodDep, edtDesDep, Nil, Key, arrDep) Then
  Begin
    If fValidaCampos(dbeCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeCodDicKeyPress(Sender: TObject; var Key: Char);
  Var
    arrConsulta : TConsultasArray;
begin
  inherited;
  If fPesqDic(Self, dbeCodDic, edtDesDic, nil, Key, arrConsulta) Then
  Begin
    If fValidaCampos(dbeCodDic, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.dbeCodEmpSugExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeCodEmpSug)
end;

procedure TfrmCadProdutos.dbeCodEmpSugKeyPress(Sender: TObject; var Key: Char);
var
  arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmpSug, edtDesEmpSug, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmpSug) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.pAtualizaVariaveis;
begin
  fltMa1Ant := qryIteGer.FieldByName('ITE_MARBR1').AsFloat;
  fltMa2Ant := qryIteGer.FieldByName('ITE_MARBR2').AsFloat;
  fltMa3Ant := qryIteGer.FieldByName('ITE_MARBR3').AsFloat;
  fltMa4Ant := qryIteGer.FieldByName('ITE_MARBR4').AsFloat;
  fltMa5Ant := qryIteGer.FieldByName('ITE_MARBR5').AsFloat;
  fltMa6Ant := qryIteGer.FieldByName('ITE_MARBR6').AsFloat;
  fltMa7Ant := qryIteGer.FieldByName('ITE_MARBR7').AsFloat;
  fltVe1Ant := qryIteGer.FieldByName('ITE_PREVE1').AsFloat;
  fltVe2Ant := qryIteGer.FieldByName('ITE_PREVE2').AsFloat;
  fltVe3Ant := qryIteGer.FieldByName('ITE_PREVE3').AsFloat;
  fltVe4Ant := qryIteGer.FieldByName('ITE_PREVE4').AsFloat;
  fltVe5Ant := qryIteGer.FieldByName('ITE_PREVE5').AsFloat;
  fltVe6Ant := qryIteGer.FieldByName('ITE_PREVE6').AsFloat;
  fltVe7Ant := qryIteGer.FieldByName('ITE_PREVE7').AsFloat;
  fltCusAnt := qryIteGer.FieldByName('ITE_PRECUS').AsFloat;
  fltComAnt := qryIteGer.FieldByName('ITE_PRECOM').AsFloat;
end;

procedure TfrmCadProdutos.pIniciaValoresPadrao;
  Var
    intContador: Integer;
begin
  pZeraCamposNumericos;

  For intContador := 0 To qryIteGer.FieldCount -1 Do
  Begin
    If (qryIteGer.Fields[intContador].DataType = ftInteger)  Or
       (qryIteGer.Fields[intContador].DataType = ftFloat)    Or
       (qryIteGer.Fields[intContador].DataType = ftCurrency) Then
    Begin
      If qryIteGer.Fields[intContador].FieldName <> 'AUTOINCREM' Then
        qryIteGer.Fields[intContador].Value := 0;
    End;
  End;

  qryTabela.FieldByName('ITE_FATUTR').AsFloat    := 1;
  qryTabela.FieldByName('ITE_DTACAD').AsDateTime := VS_Date;

  qryTabela.FieldByName('ITE_INDESC').AsString   := 'S';
  qryTabela.FieldByName('ITE_ENIECB').AsString   := 'N';

  If fCfgSIs('IMPDIG') = '1' Then
    qryTabela.FieldByName('ITE_IMPDIR').AsString   := 'N';

  If fCfgSis('INDREV') = '1' Then
    qryTabela.FieldByName('ITE_INDREV').AsString   := 'R';

  qryTabela.FieldByName('ITE_REAEND').AsString   := IIF(fCfgSis('DREEND', varString) = 'S', 'S', 'N');
  qryTabela.FieldByName('ITE_MLTSPO').AsString   := 'S';
  qryTabela.FieldByName('ITE_EXPSIT').AsString   := IIF(fCfgSis('EXPECO', varString) = 'S', 'S', 'N');
  qryTabela.FieldByName('ITE_EXPAPP').AsString   := 'N';
  qryTabela.FieldByName('ITE_RPRENT').AsString   := 'S';
  qryTabela.FieldByName('ITE_BAREXP').AsString   := 'N';
  qryTabela.FieldByName('ITE_AGROTO').AsString   := 'N';
  qryTabela.FieldByName('ITE_OBRNFE').AsString   := 'N';
  qryTabela.FieldByName('ITE_PROEMB').AsString   := 'N';
  qryTabela.FieldByName('ITE_EXPPOK').AsString   := 'N';
  qryTabela.FieldByName('ITE_SITPRD').AsString   := fCfgSis('SITPRD', varString);
  If fEmptyStr(qryTabela.FieldByName('ITE_SITPRD').AsString) Then
    qryTabela.FieldByName('ITE_SITPRD').AsString := '1';
  qryTabela.FieldByName('ITE_RASTRE').AsString   := 'N';

  qryTabela.FieldByName('ITE_ECARGA').AsString   := '0';
  qryTabela.FieldByName('ITE_PERSOL').AsFloat    := 0;
  qryTabela.FieldByName('ITE_ABSOLE').AsFloat    := 0;

  If StrToIntDef(fCfgSis('SUGGAR'), -1) >= 0 Then
    qryTabela.FieldByName('ITE_TMPGAR').AsInteger := StrToIntDef(fCfgSis('SUGGAR'), 0);

  qryIteGer.FieldByName('ITE_PREDOL').AsString   := 'N';
  qryIteGer.FieldByName('ITE_SAL_ML').AsFloat    := 0.0;
  qryIteGer.FieldByName('ITE_ESMIDG').AsString   := 'G';
  qryIteGer.FieldByName('ITE_DESCHK').AsString   := 'N';

  {********************************************************}
  {* VALORES DEFAULT PARA QTDE MÍNIMA POR TABELA DE PREÇO *}
  {*****************************************************PZ*}
  qryIteGer.FieldByName('ITE_MINTB1').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB2').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB3').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB4').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB5').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB6').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_MINTB7').AsFloat    := 1.0000;
  qryIteGer.FieldByName('ITE_GARFIL').AsString   := 'N';
  qryIteGer.FieldByName('ITE_CPESOB').AsString   := 'S';

  If pnlDtaVal.Visible Then
    qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime := fNow + fCfgSis('QTDFOR', VarInteger);

  If fCfgSIs('IMPDIG') = '2' Then
    qryIteGer.FieldByName('ITE_IMPDIR').AsString := 'N';

  If fCfgSis('INDREV') = '2' Then
    qryIteGer.FieldByName('ITE_INDREV').AsString   := 'R';

  qryIteGer.FieldByName('ITE_RECDEV').AsString := 'S';

  qryTabela.FieldByName('ITE_NOTESP').AsString := 'S';

  If fCfgSIs('ATICOM',varBoolean) Then
    qryTabela.FieldByName('ITE_MESGIR').AsInteger  := 999;

  qryIteGer.FieldByName('ITE_NIVGIR').AsString := 'C';
  qryIteGer.FieldByName('ITE_NIVCRI').AsString := 'X';

  dbeObrCpf.Field.AsString := 'N';
  dbeObrIba.Field.AsString := 'N';
  qryTabela.FieldByName('ITE_MLTCOM').Value := 1;
  qryTabela.FieldByName('ITE_MLTVEN').Value := 1;

  qryTabela.FieldByName('ITE_IMPETI').AsString := 'S';
  qryTabela.FieldByName('ITE_INCPIS').AsString := 'S';
  qryTabela.FieldByName('ITE_COMLUB').AsString := 'N';
  qryIteGer.FieldByName('ITE_IMPLIS').AsString := 'S';
  qryIteGer.FieldByName('ITE_APERET').AsString := 'N';
  qryIteGer.FieldByName('ITE_APEENT').AsString := 'N';
  qryTabela.FieldByName('ITE_ITEATI').AsString := 'S';
  qryTabela.FieldByName('ITE_ATICOM').AsString := 'S';
  qryTabela.FieldByName('ITE_ITEBAS').AsString := 'N';
  qryTabela.FieldByName('ITE_ITEPIG').AsString := 'N';
  qryIteGer.FieldByName('ITE_CPRCEN').AsString := 'N';
  qryIteGer.FieldByName('ITE_ABAMLT').AsString := 'S';
  qryIteGer.FieldByName('ITE_TPCOMC').AsString := 'P';
  qryTabela.FieldByName('ITE_NVLGIR').AsString := 'C';
  qryTabela.FieldByName('ITE_NVLCRI').AsString := 'X';
  qryTabela.FieldByName('ITE_INFLAM').AsString := 'N';
  qryTabela.FieldByName('ITE_CBNDES').AsString := 'N';
  qryTabela.FieldByName('ITE_ITECCR').AsString := 'N';
  qryTabela.FieldByName('ITE_USABON').AsString := 'S';
  qryTabela.FieldByName('ITE_USAFLE').AsString := 'S';
  qryTabela.FieldByName('ITE_FATCOM').AsString := 'S';
  qryTabela.FieldByName('ITE_VALOBR').AsString := 'N';
  qryTabela.FieldByName('ITE_PEEFUT').AsString := 'S';
  qryTabela.FieldByName('ITE_PEFUTP').AsString := 'S';
  qryTabela.FieldByName('ITE_PEFFPR').AsString := 'S';
  qryTabela.FieldByName('ITE_PRAPEL').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_CONLOT').AsString := 'N';
  qryTabela.FieldByName('ITE_OBRBAR').AsString := 'N';
  qryTabela.FieldByName('ITE_FATCMP').AsFloat  := 0.0000;

  qryTabela.FieldByName('ITE_LARVID').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_ALTVID').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_LAMAVI').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_ALMAVI').AsFloat  := 0.00;

  qryTabela.FieldByName('ITE_ARESUG').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_AREMAX').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_LARMIN').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_ALTMIN').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_AREMIN').AsFloat  := 0.00;
  qryTabela.FieldByName('ITE_PROPCD').AsString := 'N';
  qryTabela.FieldByName('ITE_UTIAMP').AsString := 'S';
  qryTabela.FieldByName('ITE_LOTEPD').AsString := 'N';
  qryTabela.FieldByName('ITE_ORDSER').AsString := 'N';
  qryIteGer.FieldByName('ITE_PESOBR').AsString := 'S';
  qryTabela.FieldByName('ITE_DESCND').AsString := 'S';

  qryTabela.FieldByName('ITE_VENSUB').AsString   := 'S';

  If blnPossuiBeneficioFiscal Then
    qryTabela.FieldByName('ITE_USABEF').AsString   := 'S'
  Else
  qryTabela.FieldByName('ITE_USABEF').AsString   := 'N';

  qryTabela.FieldByName('ITE_CAREST').AsString   := 'I';
  qryTabela.FieldByName('ITE_USAQUE').AsString   := 'S';

  qryTabela.FieldByName('ITE_TEMPRO').AsInteger := 0;

  qryTabela.FieldByName('ITE_DIACRI').AsInteger := 0;

  qryTabela.FieldByName('ITE_QRCODE').AsString := '';
  qryIteGer.FieldByName('ITE_ATODDF').AsString := 'N';

  if fCfgSis('DITBAL', varBoolean) then
    qryTabela.FieldByName('ITE_ITEBAL').AsString   := 'S';

  cmbCarEst.ItemIndex := 0;

  objLojas.pIniciaDadosInclusao(VS_strCodEmp);
  objLojas.pCarregaPontoExposicao
end;

procedure TfrmCadProdutos.dbeSupEstKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, dbeSupEst, Nil, Nil, Key, arrSel) And
     fValidaCampos(dbeSupEst, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadProdutos.dbeTipFreChange(Sender: TObject);
begin
  inherited;
  lblVlCFre.Visible := (dbeTipFre.Text = 'P');
end;

procedure TfrmCadProdutos.dbeTpCoMcExit(Sender: TObject);
begin
  inherited;
  If (qryIteGer.State in [dsInsert, dsEdit]) And
     (dbeTpCoMc.Text = 'V') Then
    fMensagem('', 'A comissão será calculada multiplicando o valor informado pela quantidade dos produtos/serviços', ['&OK']);
end;

procedure TfrmCadProdutos.FormActivate(Sender: TObject);
begin
  inherited;
  cxsColunaFixa.Color := Self.Color;
  cxsColunaFixaDestaque.Color := Self.Color;
end;

procedure TfrmCadProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (Action <> CaNone) Then
  Begin
    qryIteGer.Close;

    fFecharTabela(qryPreAlt);
    FreeAndNil(qryPreAlt);

    FreeAndNil(stlCampos);
    FreeAndNil(stlCamInd);
    FreeAndNil(stlDesInd);

    FreeAndNil(qryUltVendas);
    FreeAndNil(qryLotAmz);
    FreeAndNil(qryUltCompras);

    If tbsExportaSite.TabVisible Then
      FreeAndNil(FPanelDadosECommerce);

    If lstTintas <> Nil Then
      FreeAndNil(lstTintas);

    if Assigned(objComplementoEtiquetas) then
      FreeAndNil(objComplementoEtiquetas);
  End;

end;

procedure TfrmCadProdutos.pAjustaDolar;
  Var
    intTabPre: Integer;
    blnVisible : Boolean;
    fltDolar : Double;
Begin

  If (chkPreDol.Visible) Then
    fltDolar := fGetUltimaCotacaoDolarVenda
  Else
    fltDolar := 0;

  blnVisible := chkPreDol.Visible And (fltDolar > 0);

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Visible := blnVisible;
    TLabel(Self.FindComponent('lblDolar' + IntToStr(intTabPre))).Visible     := blnVisible;

    If blnVisible Then
    Begin
      fDbEditFocus('dbePreVe' + IntToStr(intTabPre)).Width := intPreWidth;
      TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Text := FormatFloat(fMskDigitos(intDecUni), fStrToFloat(fDbEditFocus('dbePreVe' + IntToStr(intTabPre)).Text) / fltDolar);
    End
    Else
      fDbEditFocus('dbePreVe' + IntToStr(intTabPre)).Width := (TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Left   +
                                                               TEditFocus(Self.FindComponent('edtDolar' + IntToStr(intTabPre))).Width) -
                                                               fDBEditFocus('dbePreVe' + IntToStr(intTabPre)).Left;
  End;

End;

procedure TfrmCadProdutos.pRecalculaPrecos(intPreMar: Integer; qryIteExec: TUniQuery= nil);
  Var
    intTabPre: Integer;
    blnUtilizarConversorDeMoedas : Boolean;
begin
  If blnPreMat Then
    Exit;

  If Not Assigned(qryIteExec) Then
    qryIteExec := qryIteGer;

  if not (qryIteExec.State in [dsInsert, dsEdit])  then
    Exit;

  blnUtilizarConversorDeMoedas := chkPreDol.Checked;

  If qryIteExec <> qryIteGer THen
    qryIteExec.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(blnUtilizarConversorDeMoedas, qryIteExec)
  Else
    qryIteExec.FieldByName('ITE_PRECUS').AsFloat := fRetPrecoCusto(blnUtilizarConversorDeMoedas);

  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If (intPreMar = 1) Or
       ((qryTabela.State In [dsInsert]) And (qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat = 0)) Then
    Begin
      If qryIteExec <> qryIteGer THen
        qryIteExec.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(1, intTabPre, qryIteExec)
      Else
        qryIteExec.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(1, intTabPre)

    End
    Else
    Begin
      If qryIteExec <> qryIteGer THen
        qryIteExec.FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(2, intTabPre, qryIteExec)
      Else
        qryIteExec.FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(2, intTabPre);
    End
  End;

  pRecalculaPrecosFator(qryIteExec);
  pExecutaCalculoCFG_BEN_ST ;
end;

procedure TfrmCadProdutos.pAtribuiTabelas;
begin

  strNomeTabela := 'CADITE';
  strNomeCampo := 'ITE_CODITE';

  qryConAbf := fCriarQuery('SELECT * FROM ABFICM WHERE FALSE', Self);
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConMar := fCriarQuery('SELECT * FROM CADMAR WHERE FALSE', Self);
  qryConGru := fCriarQuery('SELECT "" AS DESLIN, CADGRU.* FROM CADGRU WHERE FALSE', Self);
  qryConUni := fCriarQuery('SELECT * FROM CADUNI WHERE FALSE', Self);
  qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE', Self);
  qryDesSit := fCriarQuery('SELECT * FROM DESSIT WHERE FALSE', Self);
  qryConLse := fCriarQuery('SELECT * FROM CADLSE WHERE FALSE', Self);
  fAbrirTabela(qryPreAlt);

  qryTabela := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  dtsCadIte.DataSet := qryTabela;
  pSetaQueryCadIte(qryTabela);

  qryIteGer := fCriarQueryIteGer(Self);
  dtsIteGer.DataSet := qryIteGer;
  //  qryConIte := fCriarQueryIteGer(Self);

end;

procedure TfrmCadProdutos.btnHerancaClick(Sender: TObject);
  Var
    intTabPre: Integer;
    qryIteEmb: TUniQuery;
   LqryIteDfq: TUniQuery;
    intIndex : Integer;
begin

  If InterlockedIncrement(intConfirma) = 0 Then
  Begin

    Try

    inherited;

    Try
      pCriarFormularios(TfrmHerancaItem, frmHerancaItem);
      frmHerancaItem.qryGenIte := qryGenIte;
      frmHerancaItem.ShowModal;

      If frmHerancaItem.blnConfirma Then
      Begin
        blnHeranca := True;
        frmManutencaoAbreviacoesLojas.pCarrega(qryGenIte.FieldByName('ITE_CODITE').AsString, True);
        frmManutencaoAbreviacoesLojas.pHabilitaEdicao(True);
        qryTabela.FieldByName('ITE_USAPFD').AsString := qryGenIte.FieldByName('ITE_USAPFD').AsString;
        qryTabela.FieldByName('ITE_USAPCV').AsString := qryGenIte.FieldByName('ITE_USAPCV').AsString;
        qryTabela.FieldByName('ITE_SITPRD').AsString := qryGenIte.FieldByName('ITE_SITPRD').AsString;
        qryTabela.FieldByName('ITE_CODGRU').AsString := qryGenIte.FieldByName('ITE_CODGRU').AsString;
        qryTabela.FieldByName('ITE_DESITE').AsString := qryGenIte.FieldByName('ITE_DESITE').AsString;
        qryTabela.FieldByName('ITE_REFERE').AsString := qryGenIte.FieldByName('ITE_REFERE').AsString;
        qryTabela.FieldByName('ITE_CODMAR').AsString := qryGenIte.FieldByName('ITE_CODMAR').AsString;
        qryTabela.FieldByName('ITE_CODFOR').AsString := qryGenIte.FieldByName('ITE_CODFOR').AsString;
        qryTabela.FieldByName('ITE_CODUNI').AsString := qryGenIte.FieldByName('ITE_CODUNI').AsString;
        qryTabela.FieldByName('ITE_UTIAMP').AsString := qryGenIte.FieldByName('ITE_UTIAMP').AsString;
        qryTabela.FieldByName('ITE_LOTEPD').AsString := qryGenIte.FieldByName('ITE_LOTEPD').AsString;

        qryTabela.FieldByName('ITE_LAYORD').AsString := qryGenIte.FieldByName('ITE_LAYORD').AsString;
        qryTabela.FieldByName('ITE_VALIDA').AsString := qryGenIte.FieldByName('ITE_VALIDA').AsString;
        qryTabela.FieldByName('ITE_COMPOS').AsString := qryGenIte.FieldByName('ITE_COMPOS').AsString;
        qryTabela.FieldByName('ITE_ITESAC').AsString := qryGenIte.FieldByName('ITE_ITESAC').AsString;
        qryTabela.FieldByName('ITE_PAISOR').AsString := qryGenIte.FieldByName('ITE_PAISOR').AsString;
        qryTabela.FieldByName('ITE_CLACRM').AsString := qryGenIte.FieldByName('ITE_CLACRM').AsString;
        qryIteGer.FieldByName('ITE_USASER').AsString := qryGenIte.FieldByName('ITE_USASER').AsString;

        If fEmptyStr(qryGenIte.FieldByName('ITE_EXCIPI').AsString) Then
          qryTabela.FieldByName('ITE_EXCIPI').Value := Null
        Else
          qryTabela.FieldByName('ITE_EXCIPI').AsString := fStrZero(qryGenIte.FieldByName('ITE_EXCIPI').AsString, 3);

        qryTabela.FieldByName('ITE_UNICOM').AsString := qryGenIte.FieldByName('ITE_UNICOM').AsString;
        If fEmptyStr(qryTabela.FieldByName('ITE_UNICOM').AsString) Then
          qryTabela.FieldByName('ITE_UNICOM').Clear;

        qryTabela.FieldByName('ITE_UNITRI').AsString := qryGenIte.FieldByName('ITE_UNITRI').AsString;
        If fEmptyStr(qryTabela.FieldByName('ITE_UNITRI').AsString) Then
          qryTabela.FieldByName('ITE_UNITRI').Clear;

        qryTabela.FieldByName('ITE_FATUTR').AsFloat := qryGenIte.FieldByName('ITE_FATUTR').AsFloat;
        If fEmptyStr(qryTabela.FieldByName('ITE_UNITRI').AsString) Then
          qryTabela.FieldByName('ITE_FATUTR').AsFloat := 1;

        qryIteGer.FieldByName('ITE_PRECOM').AsFloat := qryGenIte.FieldByName('ITE_PRECOM').AsFloat;
        qryIteGer.FieldByName('ITE_DESF01').AsFloat := qryGenIte.FieldByName('ITE_DESF01').AsFloat;
        qryIteGer.FieldByName('ITE_DESF02').AsFloat := qryGenIte.FieldByName('ITE_DESF02').AsFloat;
        qryIteGer.FieldByName('ITE_DESF03').AsFloat := qryGenIte.FieldByName('ITE_DESF03').AsFloat;
        qryIteGer.FieldByName('ITE_DESF04').AsFloat := qryGenIte.FieldByName('ITE_DESF04').AsFloat;
        qryIteGer.FieldByName('ITE_DESF05').AsFloat := qryGenIte.FieldByName('ITE_DESF05').AsFloat;
        qryIteGer.FieldByName('ITE_DESF06').AsFloat := qryGenIte.FieldByName('ITE_DESF06').AsFloat;
        qryIteGer.FieldByName('ITE_ICMENT').AsFloat := qryGenIte.FieldByName('ITE_ICMENT').AsFloat;
        qryIteGer.FieldByName('ITE_SUBFED').AsFloat := qryGenIte.FieldByName('ITE_SUBFED').AsFloat;
        qryIteGer.FieldByName('ITE_IPIENT').AsFloat := qryGenIte.FieldByName('ITE_IPIENT').AsFloat;
        qryIteGer.FieldByName('ITE_FREENT').AsFloat := qryGenIte.FieldByName('ITE_FREENT').AsFloat;
        qryIteGer.FieldByName('ITE_VALFRE').AsFloat := qryGenIte.FieldByName('ITE_VALFRE').AsFloat;
        qryIteGer.FieldByName('ITE_ACRFIN').AsFloat := qryGenIte.FieldByName('ITE_ACRFIN').AsFloat;
        qryIteGer.FieldByName('ITE_SUBSTI').AsFloat := qryGenIte.FieldByName('ITE_SUBSTI').AsFloat;
        qryIteGer.FieldByName('ITE_IMPFED').AsFloat := qryGenIte.FieldByName('ITE_IMPFED').AsFloat;
        qryIteGer.FieldByName('ITE_PRECUS').AsFloat := qryGenIte.FieldByName('ITE_PRECUS').AsFloat;
        qryIteGer.FieldByName('ITE_ICMSAI').AsFloat := qryGenIte.FieldByName('ITE_ICMSAI').AsFloat;
        qryIteGer.FieldByName('ITE_OUTVAL').AsFloat := qryGenIte.FieldByName('ITE_OUTVAL').AsFloat;
        qryIteGer.FieldByName('ITE_DESMAX').AsFloat := qryGenIte.FieldByName('ITE_DESMAX').AsFloat;
        qryIteGer.FieldByName('ITE_DESADB').AsFloat := qryGenIte.FieldByName('ITE_DESADB').AsFloat;
        qryIteGer.FieldByName('ITE_PESOBR').AsString:= qryGenIte.FieldByName('ITE_PESOBR').AsString;
        qryIteGer.FieldByName('ITE_TCIFCU').AsFloat := qryGenIte.FieldByName('ITE_TCIFCU').AsFloat;
        qryIteGer.FieldByName('ITE_TSCUST').AsFloat := qryGenIte.FieldByName('ITE_TSCUST').AsFloat;
        qryIteGer.FieldByName('ITE_DEPICO').AsFloat := qryGenIte.FieldByName('ITE_DEPICO').AsFloat;
        qryIteGer.FieldByName('ITE_DEICMS').AsFloat := qryGenIte.FieldByName('ITE_DEICMS').AsFloat;
        qryIteGer.FieldByName('ITE_FATREG').AsFloat := qryGenIte.FieldByName('ITE_FATREG').AsFloat;

        qryIteGer.FieldByName('ITE_DESMVM').AsFloat := qryGenIte.FieldByName('ITE_DESMVM').AsFloat;
        qryIteGer.FieldByName('ITE_DESMSM').AsFloat := qryGenIte.FieldByName('ITE_DESMSM').AsFloat;
        qryIteGer.FieldByName('ITE_DESMGM').AsFloat := qryGenIte.FieldByName('ITE_DESMGM').AsFloat;

        qryIteGer.FieldByName('ITE_DTAVAL').AsDateTime := qryGenIte.FieldByName('ITE_DTAVAL').AsDateTime;
        qryIteGer.FieldByName('ITE_CPESOB').AsString := qryGenIte.FieldByName('ITE_CPESOB').AsString;

        For intTabPre := 1 To Length(VS_strTabPrc) Do
        Begin
          qryIteGer.FieldByName('ITE_TABPR' + IntToStr(intTabPre)).Value := qryGenIte.FieldByName('ITE_TABPR' + IntToStr(intTabPre)).Value;

          qryIteGer.FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat := qryGenIte.FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat;
          qryIteGer.FieldByName('ITE_MARID' + IntToStr(intTabPre)).AsFloat := qryGenIte.FieldByName('ITE_MARID' + IntToStr(intTabPre)).AsFloat;

          If (qryGenIte.FieldByName('ITE_PREDOL').AsString = 'N') Then
            qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat := qryGenIte.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat;

          qryIteGer.FieldByName('ITE_COMTB' + IntToStr(intTabPre)).AsFloat := qryGenIte.FieldByName('ITE_COMTB' + IntToStr(intTabPre)).AsFloat;
        End;

        If fCfgSIs('TIPABF') = '1' Then
          qryTabela.FieldByName('ITE_CODABF').AsString := qryGenIte.FieldByName('ITE_CODABF').AsString
        Else
          qryIteGer.FieldByName('ITE_CODABF').AsString := qryGenIte.FieldByName('ITE_CODABF').AsString;

        If fCfgSis('TPABPC') = '1' Then
        Begin
          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFPIS').AsString) Then
            qryTabela.FieldByName('ITE_ABFPIS').Value    := Null
          Else
            qryTabela.FieldByName('ITE_ABFPIS').AsString := qryGenIte.FieldByName('ITE_ABFPIS').AsString;

          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFCOF').AsString) Then
            qryTabela.FieldByName('ITE_ABFCOF').Value    := Null
          Else
            qryTabela.FieldByName('ITE_ABFCOF').AsString := qryGenIte.FieldByName('ITE_ABFCOF').AsString;

          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFIPI').AsString) Then
            qryTabela.FieldByName('ITE_ABFIPI').Value    := Null
          Else
            qryTabela.FieldByName('ITE_ABFIPI').AsString := qryGenIte.FieldByName('ITE_ABFIPI').AsString;
        End
        Else
        Begin
          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFPIS').AsString) Then
            qryIteGer.FieldByName('ITE_ABFPIS').Value    := Null
          Else
            qryIteGer.FieldByName('ITE_ABFPIS').AsString := qryGenIte.FieldByName('ITE_ABFPIS').AsString;

          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFCOF').AsString) Then
            qryIteGer.FieldByName('ITE_ABFCOF').Value    := Null
          Else
            qryIteGer.FieldByName('ITE_ABFCOF').AsString := qryGenIte.FieldByName('ITE_ABFCOF').AsString;

          If fEmptyStr(qryGenIte.FieldByName('ITE_ABFIPI').AsString) Then
            qryIteGer.FieldByName('ITE_ABFIPI').Value    := Null
          Else
            qryIteGer.FieldByName('ITE_ABFIPI').AsString := qryGenIte.FieldByName('ITE_ABFIPI').AsString;
        End;

        If fCfgSIs('IMPDIG') = '1' Then
          qryTabela.FieldByName('ITE_IMPDIR').AsString := qryGenIte.FieldByName('ITE_IMPDIR').AsString
        Else
          qryIteGer.FieldByName('ITE_IMPDIR').AsString := qryGenIte.FieldByName('ITE_IMPDIR').AsString;

        If fCfgSIs('INDREV') = '1' Then
          qryTabela.FieldByName('ITE_INDREV').AsString := qryGenIte.FieldByName('ITE_INDREV').AsString
        Else
          qryIteGer.FieldByName('ITE_INDREV').AsString := qryGenIte.FieldByName('ITE_INDREV').AsString;

        qryIteGer.FieldByName('ITE_IPISAI').AsString := qryGenIte.FieldByName('ITE_IPISAI').AsString;
        qryTabela.FieldByName('ITE_INCPIS').AsString := qryGenIte.FieldByName('ITE_INCPIS').AsString;
        qryTabela.FieldByName('ITE_CLAIPI').AsString := qryGenIte.FieldByName('ITE_CLAIPI').AsString;
        qryTabela.FieldByName('ITE_CDCEST').AsString := qryGenIte.FieldByName('ITE_CDCEST').AsString;
        qryTabela.FieldByName('ITE_COMLUB').AsString := qryGenIte.FieldByName('ITE_COMLUB').AsString;
        qryIteGer.FieldByName('ITE_IMPLIS').AsString := qryGenIte.FieldByName('ITE_IMPLIS').AsString;

        If fCfgSis('APERET', varBoolean) Then
        Begin
          qryIteGer.FieldByName('ITE_APERET').AsString := qryGenIte.FieldByName('ITE_APERET').AsString;
          qryIteGer.FieldByName('ITE_APEENT').AsString := qryGenIte.FieldByName('ITE_APEENT').AsString;
        End
        Else
        Begin
          qryIteGer.FieldByName('ITE_APERET').AsString := 'N';
          qryIteGer.FieldByName('ITE_APEENT').AsString := 'N';
        End;

        qryTabela.FieldByName('ITE_ITEATI').AsString := qryGenIte.FieldByName('ITE_ITEATI').AsString;
        qryTabela.FieldByName('ITE_ATICOM').AsString := qryGenIte.FieldByName('ITE_ATICOM').AsString;
        qryTabela.FieldByName('ITE_PESOIT').AsString := qryGenIte.FieldByName('ITE_PESOIT').AsString;
        qryTabela.FieldByName('ITE_PESLIQ').AsString := qryGenIte.FieldByName('ITE_PESLIQ').AsString;
        qryTabela.FieldByName('ITE_ITEBAS').AsString := qryGenIte.FieldByName('ITE_ITEBAS').AsString;
        qryTabela.FieldByName('ITE_USABON').AsString := qryGenIte.FieldByName('ITE_USABON').AsString;
        qryTabela.FieldByName('ITE_USAFLE').AsString := qryGenIte.FieldByName('ITE_USAFLE').AsString;
        qryTabela.FieldByName('ITE_FATCOM').AsString := qryGenIte.FieldByName('ITE_FATCOM').AsString;
        qryTabela.FieldByName('ITE_VALOBR').AsString := qryGenIte.FieldByName('ITE_VALOBR').AsString;
        //qryIteGer.FieldByName('ITE_LOCFIS').AsString := qryGenIte.FieldByName('ITE_LOCFIS').AsString;
        qryIteGer.FieldByName('ITE_COMVAR').AsString := qryGenIte.FieldByName('ITE_COMVAR').AsString;
        qryIteGer.FieldByName('ITE_COMATA').AsString := qryGenIte.FieldByName('ITE_COMATA').AsString;
        qryIteGer.FieldByName('ITE_COMDIS').AsString := qryGenIte.FieldByName('ITE_COMDIS').AsString;
        qryIteGer.FieldByName('ITE_COMDIG').AsString := qryGenIte.FieldByName('ITE_COMDIG').AsString;
        qryTabela.FieldByName('ITE_CNV_ML').AsFloat  := 0.00;// Desativado pelo Requisito 7174 //qryGenIte.FieldByName('ITE_CNV_ML').AsString;
        qryIteGer.FieldByName('ITE_ESMIDG').AsString := qryGenIte.FieldByName('ITE_ESMIDG').AsString;
        qryIteger.FieldByName('ITE_ABAMLT').AsString := qryGenIte.FieldByName('ITE_ABAMLT').AsString;
        qryIteger.FieldByName('ITE_DESMSU').AsString := qryGenIte.FieldByName('ITE_DESMSU').AsString;
        qryIteger.FieldByName('ITE_DESMGE').AsString := qryGenIte.FieldByName('ITE_DESMGE').AsString;
        qryIteGer.FieldByName('ITE_QTPPRO').AsFloat  := qryGenIte.FieldByName('ITE_QTPPRO').AsFloat;
        qryIteger.FieldByName('ITE_NIVGIR').AsString := qryGenIte.FieldByName('ITE_NIVGIR').AsString;
        qryIteger.FieldByName('ITE_NIVCRI').AsString := qryGenIte.FieldByName('ITE_NIVCRI').AsString;

        qryTabela.FieldByName('ITE_ITEPIG').AsString := qryGenIte.FieldByName('ITE_ITEPIG').AsString;

  //      qryTabela.FieldByName('ITE_EMBALA').AsFloat  := qryGenIte.FieldByName('ITE_EMBALA').AsFloat;

        qryTabela.FieldByName('ITE_MLTCOM').AsFloat  := qryGenIte.FieldByName('ITE_MLTCOM').AsFloat;
        qryTabela.FieldByName('ITE_MLTVEN').AsFloat  := qryGenIte.FieldByName('ITE_MLTVEN').AsFloat;
        qryTabela.FieldByName('ITE_NVLGIR').AsString := qryGenIte.FieldByName('ITE_NVLGIR').AsString;
        qryTabela.FieldByName('ITE_NVLGIR').AsString := qryGenIte.FieldByName('ITE_NVLGIR').AsString;
        qryTabela.FieldByName('ITE_MSGLV1').AsString := qryGenIte.FieldByName('ITE_MSGLV1').AsString;
        qryTabela.FieldByName('ITE_MSGLV2').AsString := qryGenIte.FieldByName('ITE_MSGLV2').AsString;
        qryTabela.FieldByName('ITE_APLICA').AsString := qryGenIte.FieldByName('ITE_APLICA').AsString;
        qryTabela.FieldByName('ITE_INFLAM').AsString := qryGenIte.FieldByName('ITE_INFLAM').AsString;

        qryTabela.FieldByName('ITE_ITECCR').AsString := qryGenIte.FieldByName('ITE_ITECCR').AsString;
        qryTabela.FieldByName('ITE_FATCMP').AsFloat  := qryGenIte.FieldByName('ITE_FATCMP').AsFloat;
        qryTabela.FieldByName('ITE_FATCNV').AsFloat  := qryGenIte.FieldByName('ITE_FATCNV').AsFloat;
        qryTabela.FieldByName('ITE_TMPGAR').AsInteger:= qryGenIte.FieldByName('ITE_TMPGAR').AsInteger;
        qryTabela.FieldByName('ITE_INFGAR').AsString := qryGenIte.FieldByName('ITE_INFGAR').AsString;
        qryTabela.FieldByName('ITE_RSPGAR').AsString := qryGenIte.FieldByName('ITE_RSPGAR').AsString;

        If (fCfgSis('EXPECO', varString) = 'O') Then
          qryTabela.FieldByName('ITE_EXPSIT').AsString := qryGenIte.FieldByName('ITE_EXPSIT').AsString
        Else
          qryTabela.FieldByName('ITE_EXPSIT').AsString := fCfgSis('EXPECO', varString);

        qryTabela.FieldByName('ITE_EXPAPP').AsString := qryGenIte.FieldByName('ITE_EXPAPP').AsString;

        qryIteger.FieldByName('ITE_CPRCEN').AsString := qryGenIte.FieldByName('ITE_CPRCEN').AsString;
        qryIteGer.FieldByName('ITE_DESOPE').AsFloat  := qryGenIte.FieldByName('ITE_DESOPE').AsFloat;

        qryTabela.FieldByName('ITE_PEEFUT').AsString := qryGenIte.FieldByName('ITE_PEEFUT').AsString;
        qryTabela.FieldByName('ITE_PEFUTP').AsString := qryGenIte.FieldByName('ITE_PEFUTP').AsString;

        qryTabela.FieldByName('ITE_EXPB2B').AsString := qryGenIte.FieldByName('ITE_EXPB2B').AsString;
        qryTabela.FieldByName('ITE_TIPFRE').AsString := qryGenIte.FieldByName('ITE_TIPFRE').AsString;
        qryIteGer.FieldByName('ITE_QTDUCO').AsFloat  := 0.000;
        qryIteGer.FieldByName('ITE_PREULT').AsFloat  := 0.0000;
        qryIteGer.FieldByName('ITE_IMPULT').AsFloat  := 0.0000;
        qryIteGer.FieldByName('ITE_QTDUVE').AsFloat  := 0.000;
        qryIteGer.FieldByName('ITE_PREUVE').AsFloat  := 0.0000;
        qryIteGer.FieldByName('ITE_PREMED').AsFloat  := 0.0000;
        qryIteGer.FieldByName('ITE_VALFRE').AsFloat  := qryGenIte.FieldByName('ITE_VALFRE').AsFloat;

        If tbsExportaSite.TabVisible Then
        Begin
          FPanelDadosECommerce.mmoDesSit.Texto         := qryGenIte.FieldByName('ITE_DESSIT').AsString;
          FPanelDadosECommerce.mmoDadTec.Texto         := qryGenIte.FieldByName('ITE_DADTEC').AsString;
          FPanelDadosECommerce.edtImgSit.Text          := qryGenIte.FieldByName('ITE_URLIMG').AsString;
          FPanelDadosECommerce.edtNomIte.Text          := qryGenIte.FieldByName('ITE_NOMITE').AsString;
          FPanelDadosECommerce.mmoAplIte.Texto         := qryGenIte.FieldByName('ITE_APLITE').AsString;
          FPanelDadosECommerce.mmoIteIncluso.Texto     := qryGenIte.FieldByName('ITE_INCLUS').AsString;
          FPanelDadosECommerce.edtExpAlt.Value         := qryGenIte.FieldByName('ITE_EXPALT').AsFloat;
          FPanelDadosECommerce.edtExpLar.Value         := qryGenIte.FieldByName('ITE_EXPLAR').AsFloat;
          FPanelDadosECommerce.edtExpPro.Value         := qryGenIte.FieldByName('ITE_EXPPRO').AsFloat;
          FPanelDadosECommerce.edtDestaq.Text          := qryGenIte.FieldByName('ITE_DESTAQ').AsString;
          FPanelDadosECommerce.edtAtzPre.Text          := qryGenIte.FieldByName('ITE_ATZPRE').AsString;
          FPanelDadosECommerce.edtCodCat.Text          := qryGenIte.FieldByName('ITE_CODCAT').AsString;
          FPanelDadosECommerce.edtCroDoc.Text          := qryGenIte.FieldByName('ITE_CRODOC').AsString;
          FPanelDadosECommerce.edtExpB2B.Text          := qryTabela.FieldByName('ITE_EXPB2B').AsString;
        End;

        if fCfgSis('NFEPEP', varBoolean) then
          qryIteGer.FieldByName('ITE_OBRNFE').AsString := qryGenIte.FieldByName('ITE_OBRNFE').AsString
        Else
          qryTabela.FieldByName('ITE_OBRNFE').AsString := qryGenIte.FieldByName('ITE_OBRNFE').AsString;

        qryIteGer.FieldByName('ITE_PREDOL').AsString := qryGenIte.FieldByName('ITE_PREDOL').AsString;
        //Se departamento do produto materia prima entao mostra
  //      If (qryGenIte.FieldByName('ITE_CODDEP').AsString = fCfgSis('PROMAP')) And (fCfgSis('UTIIND', varBoolean)) Then
        If (qryGenIte.FieldByName('ITE_CODDEP').AsString = fRetTipoDepartamento(qryGenIte.FieldByName('ITE_CODDEP').AsString, 'PROMAP')) And (fCfgSis('UTIIND', varBoolean)) Then
          qryTabela.FieldByName('ITE_DENSID').AsFloat := qryGenIte.FieldByName('ITE_DENSID').AsFloat;
        qryTabela.FieldByName('ITE_CODDEP').AsString := qryGenIte.FieldByName('ITE_CODDEP').AsString;
        qryTabela.FieldByName('ITE_PRAPEL').AsString := qryGenIte.FieldByName('ITE_PRAPEL').AsString;
        qryTabela.FieldByName('ITE_PER_CI').AsString := qryGenIte.FieldByName('ITE_PER_CI').AsString;
        qryTabela.FieldByName('ITE_NUMFCI').AsString := qryGenIte.FieldByName('ITE_NUMFCI').AsString;
        qryIteGer.FieldByName('ITE_CODLSE').AsString := qryGenIte.FieldByName('ITE_CODLSE').AsString;
        qryTabela.FieldByName('ITE_CAREST').AsString := qryGenIte.FieldByName('ITE_CAREST').AsString;

        if fEmptyStr(qryGenIte.FieldByName('ITE_ABFCON').AsString) then
          qryTabela.FieldByName('ITE_ABFCON').Value := Null
        else
          qryTabela.FieldByName('ITE_ABFCON').AsString := qryGenIte.FieldByName('ITE_ABFCON').AsString;

        If qryTabela.FieldByName('ITE_CAREST').AsString = 'I' Then
          cmbCarEst.ItemIndex := 0
        Else
          cmbCarEst.ItemIndex := 1;

        If fCfgSis('ITETBP', VarBoolean) Then
          pCarregaDesMaxTabelaPreco(qryGenIte.FieldByName('ITE_CODITE').AsString, qryGenIte.FieldByName('ITE_CODEMP').AsString);

        If fCfgSis('DMVFQV', VarBoolean) Then
          CarregaDesMaxFaixaQtde(qryGenIte.FieldByName('ITE_CODITE').AsString, qryGenIte.FieldByName('ITE_CODEMP').AsString);

        If (qryGenIte.FieldByName('ITE_PREDOL').AsString = 'S') Then
          pValidarPrecos(dbePreCom);

        qryTabela.FieldByName('ITE_ECARGA').Value := qryGenIte.FieldByName('ITE_ECARGA').Value;
        qryTabela.FieldByName('ITE_PERSOL').Value := qryGenIte.FieldByName('ITE_PERSOL').Value;
        qryTabela.FieldByName('ITE_ABSOLE').Value := qryGenIte.FieldByName('ITE_ABSOLE').Value;

        qryTabela.FieldByName('ITE_DESSIM').Value := qryGenIte.FieldByName('ITE_DESSIM').Value;
        qryTabela.FieldByName('ITE_PRDGRU').Value := qryGenIte.FieldByName('ITE_PRDGRU').Value;
        qryTabela.FieldByName('ITE_ABATIM').Value := qryGenIte.FieldByName('ITE_ABATIM').Value;
        qryTabela.FieldByName('ITE_BRITA_').Value := qryGenIte.FieldByName('ITE_BRITA_').Value;
        qryTabela.FieldByName('ITE_TIPMPS').Value := qryGenIte.FieldByName('ITE_TIPMPS').Value;
        qryTabela.FieldByName('ITE_FCKDIA').Value := qryGenIte.FieldByName('ITE_FCKDIA').Value;
        qryTabela.FieldByName('ITE_CONBOM').Value := qryGenIte.FieldByName('ITE_CONBOM').Value;
        qryTabela.FieldByName('ITE_PRAVAL').Value := qryGenIte.FieldByName('ITE_PRAVAL').Value;
        qryTabela.FieldByName('ITE_PROEMB').Value := qryGenIte.FieldByName('ITE_PROEMB').Value;
        qryTabela.FieldByName('ITE_EXPPOK').Value := qryGenIte.FieldByName('ITE_EXPPOK').Value;
        qryTabela.FieldByName('ITE_MARBAS').Value := qryGenIte.FieldByName('ITE_MARBAS').Value;
        qryTabela.FieldByName('ITE_DENSID').Value := qryGenIte.FieldByName('ITE_DENSID').Value;
        qryTabela.FieldByName('ITE_CODCOM').Value := qryGenIte.FieldByName('ITE_CODCOM').Value;

        If intSitPro = 1 Then
        Begin
          qryTabela.FieldByName('ITE_SITPRO').Value := qryGenIte.FieldByName('ITE_SITPRO').Value;
          If fEmptyStr(qryTabela.FieldByName('ITE_SITPRO').AsString ) then
              qryTabela.FieldByName('ITE_SITPRO').Clear
        End
        Else
        Begin
          qryIteger.FieldByName('ITE_SITPRO').Value := qryGenIte.FieldByName('ITE_SITPRO').Value;
          If fEmptyStr(qryIteger.FieldByName('ITE_SITPRO').AsString ) then
              qryIteger.FieldByName('ITE_SITPRO').Clear
        End;

        qryTabela.FieldByName('ITE_BAREXP').Value := qryGenIte.FieldByName('ITE_BAREXP').Value;
        qryTabela.FieldByName('ITE_MAXBRI').Value := qryGenIte.FieldByName('ITE_MAXBRI').Value;
        qryTabela.FieldByName('ITE_NOTESP').Value := qryGenIte.FieldByName('ITE_NOTESP').Value;
        qryTabela.FieldByName('ITE_VLCFRE').Value := qryGenIte.FieldByName('ITE_VLCFRE').Value;
        qryTabela.FieldByName('ITE_MESGIR').Value := qryGenIte.FieldByName('ITE_MESGIR').Value;
        qryTabela.FieldByName('ITE_IMPETI').Value := qryGenIte.FieldByName('ITE_IMPETI').Value;
        qryTabela.FieldByName('ITE_DESFAB').Value := qryGenIte.FieldByName('ITE_DESFAB').Value;
        qryTabela.FieldByName('ITE_GRUCMP').Value := qryGenIte.FieldByName('ITE_GRUCMP').Value;
        qryTabela.FieldByName('ITE_DIAFOR').Value := qryGenIte.FieldByName('ITE_DIAFOR').Value;
        qryTabela.FieldByName('ITE_RPRENT').Value := qryGenIte.FieldByName('ITE_RPRENT').Value;
        qryTabela.FieldByName('ITE_REAEND').Value := qryGenIte.FieldByName('ITE_REAEND').Value;
        qryTabela.FieldByName('ITE_MLTSPO').Value := qryGenIte.FieldByName('ITE_MLTSPO').Value;
        qryTabela.FieldByName('ITE_OBRBAR').Value := qryGenIte.FieldByName('ITE_OBRBAR').Value;
        qryTabela.FieldByName('ITE_ACOOBJ').Value := qryGenIte.FieldByName('ITE_ACOOBJ').Value;
        qryTabela.FieldByName('ITE_RASTRE').Value := qryGenIte.FieldByName('ITE_RASTRE').Value;
        qryTabela.FieldByName('ITE_OBRCPF').Value := qryGenIte.FieldByName('ITE_OBRCPF').Value;
        qryTabela.FieldByName('ITE_OBRIBA').Value := qryGenIte.FieldByName('ITE_OBRIBA').Value;
        qryTabela.FieldByName('ITE_MENFIS').Value := qryGenIte.FieldByName('ITE_MENFIS').Value;
        qryTabela.FieldByName('ITE_AGROTO').Value := qryGenIte.FieldByName('ITE_AGROTO').Value;

        If fEmptyStr(qryGenIte.FieldByName('ITE_CODONU').AsString) Then
          qryTabela.FieldByName('ITE_CODONU').Value := Null
        Else
          qryTabela.FieldByName('ITE_CODONU').Value := qryGenIte.FieldByName('ITE_CODONU').Value;

        qryTabela.FieldByName('ITE_CODDIC').Value := qryGenIte.FieldByName('ITE_CODDIC').Value;
        qryIteGer.FieldByName('ITE_TIPPRO').Value := qryGenIte.FieldByName('ITE_TIPPRO').Value;
        qryTabela.FieldByName('ITE_CODFIN').Value := qryGenIte.FieldByName('ITE_CODFIN').Value;
        qryTabela.FieldByName('ITE_CODLUB').Value := qryGenIte.FieldByName('ITE_CODLUB').Value;
        qryTabela.FieldByName('ITE_DESANP').Value := qryGenIte.FieldByName('ITE_DESANP').Value;
        qryTabela.FieldByName('ITE_INDESC').Value := qryGenIte.FieldByName('ITE_INDESC').Value;
        qryTabela.FieldByName('ITE_ENIECB').Value := qryGenIte.FieldByName('ITE_ENIECB').Value;
        qryTabela.FieldByName('ITE_CNPFME').Value := qryGenIte.FieldByName('ITE_CNPFME').Value;
        qryTabela.FieldByName('ITE_CDBFIS').Value := qryGenIte.FieldByName('ITE_CDBFIS').Value;
        qryIteGer.FieldByName('ITE_COMMEC').Value := qryGenIte.FieldByName('ITE_COMMEC').Value;
        qryIteGer.FieldByName('ITE_TPCOMC').Value := qryGenIte.FieldByName('ITE_TPCOMC').Value;
        qryIteGer.FieldByName('ITE_COMPRO').Value := qryGenIte.FieldByName('ITE_COMPRO').Value;
        qryIteGer.FieldByName('ITE_MARMIN').Value := qryGenIte.FieldByName('ITE_MARMIN').Value;
        qryIteGer.FieldByName('ITE_MARMSG').Value := qryGenIte.FieldByName('ITE_MARMSG').Value;
        qryIteGer.FieldByName('ITE_MARMGE').Value := qryGenIte.FieldByName('ITE_MARMGE').Value;
        qryIteGer.FieldByName('ITE_MARMMV').Value := qryGenIte.FieldByName('ITE_MARMMV').Value;
        qryIteGer.FieldByName('ITE_MARMMS').Value := qryGenIte.FieldByName('ITE_MARMMS').Value;
        qryIteGer.FieldByName('ITE_MARMMG').Value := qryGenIte.FieldByName('ITE_MARMMG').Value;
        qryIteGer.FieldByName('ITE_RECDEV').Value := qryGenIte.FieldByName('ITE_RECDEV').Value;
        qryIteGer.FieldByName('ITE_DESCHK').Value := qryGenIte.FieldByName('ITE_DESCHK').Value;

        qryTabela.FieldByName('ITE_LARVID').Value := qryGenIte.FieldByName('ITE_LARVID').Value;
        qryTabela.FieldByName('ITE_ALTVID').Value := qryGenIte.FieldByName('ITE_ALTVID').Value;
        qryTabela.FieldByName('ITE_LAMAVI').Value := qryGenIte.FieldByName('ITE_LAMAVI').Value;
        qryTabela.FieldByName('ITE_ALMAVI').Value := qryGenIte.FieldByName('ITE_ALMAVI').Value;
        qryTabela.FieldByName('ITE_CDCEST').Value := qryGenIte.FieldByName('ITE_CDCEST').Value;
        qryTabela.FieldByName('ITE_PEFFPR').Value := qryGenIte.FieldByName('ITE_PEFFPR').Value;

        qryTabela.FieldByName('ITE_ARESUG').Value := qryGenIte.FieldByName('ITE_ARESUG').Value;
        qryTabela.FieldByName('ITE_AREMAX').Value := qryGenIte.FieldByName('ITE_AREMAX').Value;
        qryTabela.FieldByName('ITE_LARMIN').Value := qryGenIte.FieldByName('ITE_LARMIN').Value;
        qryTabela.FieldByName('ITE_ALTMIN').Value := qryGenIte.FieldByName('ITE_ALTMIN').Value;
        qryTabela.FieldByName('ITE_AREMIN').Value := qryGenIte.FieldByName('ITE_AREMIN').Value;
        qryIteGer.FieldByName('ITE_PRAMIN').Value := qryGenIte.FieldByName('ITE_PRAMIN').Value;
        qryTabela.FieldByName('ITE_DESCND').Value := qryGenIte.FieldByName('ITE_DESCND').Value;
        qryTabela.FieldByName('ITE_USABEF').Value := qryGenIte.FieldByName('ITE_USABEF').Value;
        qryTabela.FieldByName('ITE_USAQUE').Value := qryGenIte.FieldByName('ITE_USAQUE').Value;
        qryTabela.FieldByName('ITE_VENSUB').Value := qryGenIte.FieldByName('ITE_VENSUB').Value;
        qryTabela.FieldByName('ITE_CODGPC').Value := qryGenIte.FieldByName('ITE_CODGPC').Value;
        qryTabela.FieldByName('ITE_DIACRI').Value := qryGenIte.FieldByName('ITE_DIACRI').Value;
        qryTabela.FieldByName('ITE_REALOC').Value := qryGenIte.FieldByName('ITE_REALOC').Value;
        qryTabela.FieldByName('ITE_TIPLOC').Value := qryGenIte.FieldByName('ITE_TIPLOC').Value;
        qryTabela.FieldByName('ITE_ITEBAL').Value := qryGenIte.FieldByName('ITE_ITEBAL').Value;

        For intTabPre := 1 To Length(VS_strTabPrc) Do
          qryIteGer.FieldByName('ITE_MINTB' + IntToStr(intTabPre)).AsFloat := qryGenIte.FieldByName('ITE_MINTB' + IntToStr(intTabPre)).AsFloat;

        If Assigned(objIteMon) Then
          objIteMon.pHerdaItem(qryGenIte.FieldByName('ITE_CODITE').AsString);

        pIndicaTipoProdutoSPED;
        pIndicaMarcaBase;
        pHabilitaCamposMateriaPrima;

        pCalculaPrecoVendaIdeal;

        objAtributos.fCarregaAtributosHeranca(qryGenIte.FieldByName('ITE_CODITE').AsString);

        stlIteEmbHer.Clear;
        Try
          pAbreIteEmb;

          qryIteEmb := fCriaQuery(Self);
          qryIteEmb.SQL.Text := ' SELECT * FROM ITEEMB WHERE ITB_CODITE = :CODITE ';
          qryIteEmb.ParamByName('CODITE').AsString := qryGenIte.FieldByName('ITE_CODITE').AsString;
          qryIteEmb.Open;

          While Not qryIteEmb.Eof Do
          Begin
            cdsIteEmb.Append;
            For intIndex := 0 To qryIteEmb.Fields.Count -1 Do
            Begin
              cdsIteEmb.Fields[intIndex].Value := qryIteEmb.FieldByName(cdsIteEmb.Fields[intIndex].FieldName).Value;
            End;
            cdsIteEmb.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('ITEEMB', cdsIteEmb.FieldByName('ITB_CODEMP').AsString);
            cdsIteEmb.FieldByName('ITB_CODITE').AsString := '';
            stlIteEmbHer.Add(cdsIteEmb.FieldByName('AUTOINCREM').AsString);
            cdsIteEmb.Post;

            qryIteEmb.Next;
          End;
        Finally
          FreeAndNil(qryIteEmb);
          cdsIteEmb.First;
        End;

        If Assigned(objTabelas) Then
          objTabelas.fCarregaDadosHeranca(qryGenIte.FieldByName('ITE_CODITE').AsString);

        Try
          FcdsDesMaxFaixaQtde.EmptyDataSet;

          LqryIteDfq := fCriaQuery(Self);
          LqryIteDfq.SQL.Text := 'SELECT * FROM ITEDFQ '+
                                 'WHERE DFQ_CODITE = :CODITE '+
                                 '  AND DFQ_CODEMP = :CODEMP ';

          LqryIteDfq.ParamByName('CODITE').AsString := qryGenIte.FieldByName('ITE_CODITE').AsString;
          LqryIteDfq.ParamByName('CODEMP').AsString := qryGenIte.FieldByName('ITE_CODEMP').AsString;
          LqryIteDfq.Open;

          While Not LqryIteDfq.Eof Do
          Begin
            FcdsDesMaxFaixaQtde.Append;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDINI').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_QTDINI').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDFIN').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_QTDFIN').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEN').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESVEN').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUB').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESSUB').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGER').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESGER').AsFloat;

            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEM').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESVEM').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUM').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESSUM').AsFloat;
            FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGEM').AsFloat  :=  LqryIteDfq.FieldByName('DFQ_DESGEM').AsFloat;
            FcdsDesMaxFaixaQtde.Post;

            LqryIteDfq.Next;
          End;
        Finally
          FreeAndNil(LqryIteDfq);
          FcdsDesMaxFaixaQtde.First;
        End;

        If Assigned(objCadProdutosVeiculoModelo) And fPergunta('Herdar também o relacionamento de produtos x veículos?') Then
          objCadProdutosVeiculoModelo.pIniciaProcesso(dbeCodIte.Text, qryGenIte.FieldByName('ITE_CODITE').AsString);

        pSetFocus(dbeCodDep);
      End;

    Except
      On E: Exception Do
      Begin
        frmManutencaoAbreviacoesLojas.pHabilitaEdicao(False);

        pMensagensErro(E.Message, '[frmCadProdutos.btnHerancaClick]');
      End;
    End;

    pFreeAndNil(frmHerancaItem);

    Finally
      InterlockedDecrement(intConfirma);
    End;

  End
  Else
    InterlockedDecrement(intConfirma);

end;

function TfrmCadProdutos.fProximoCodigo: String;
  Var
    strCodIte: String;
begin

  strCodIte := fRetornaProCod(strNomeTabela);
  If (fItemCadastrado(strCodIte)) Then
    Raise Exception.Create('Esse código de item (' + strCodIte + ') já está cadastrado!' + #13#10 +
                           'Verifique o cadastro de próximos códigos.');

  Result := inherited fProximoCodigo;
end;

{
function TfrmCadProdutos.fQtdRegistro(strTable, strField,
  strValue: String): Integer;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin
  strSQL := 'SELECT COUNT(*) AS QTD FROM ' + strTable + ' WHERE ' + strField + ' = ' + strValue;

  qryGen := fCriaQuery;
  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    Result := FieldByName('QTD').AsInteger;
  End;

  FreeAndNil(qryGen);
end;
}

function TfrmCadProdutos.fItemCadastrado(strCodIte: String): Boolean;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;

begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
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
      Result := (FieldByName('QTD').AsInteger > 0);
      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;

end;

function TfrmCadProdutos.fIVAMod4: Double;
begin
  Result := 0;
  If (Assigned(dbeCodAbr.Field)) And (Not fEmptyStr(dbeCodAbr.Field.AsString)) Then
    Result := fRetornaPercIVA(dbeCodAbr.Field.AsString, fCadEmp('ESTADO'), '_SAI_CCO')
end;

procedure TfrmCadProdutos.pCarregaMarcasBases;
  Var
    intContador: Integer;
    iTintas: ITintasDeMaquina;
begin

  If (VS_strUsaTmq <> 'S') Then
  Begin
//    lblMarBas.Visible := False;
//    cmbMarBas.Visible := False;
    pnlMarBas.Visible := False;
    cmbMarBas.Enabled := False;

    Exit;
  End;

  iTintas := fGetTintasdeMaquina;
  cmbMarBas.Items.Add('Não é uma base');
  lstTintas.Add('Não é uma base');

  For intContador := 0 To iTintas.fGetQtdTintas -1 Do
  Begin
    cmbMarBas.Items.Add(iTintas.fGetNomeTinta(intContador));
    lstTintas.Add(iTintas.fGetNomeTinta(intContador));
  End;
end;

procedure TfrmCadProdutos.pCarregaOperador;
begin
  If Not fEmptyStr(dbeOpeAlt.Text) Then
    edtNomOpe.Text := fRetNomeOperador(dbeOpeAlt.Text)
  Else
    edtNomOpe.Clear;
end;

procedure TfrmCadProdutos.pCarregaProduto;
var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta:= fCriaQuery(Self);
    pPesquisaCadIte(qryConsulta, qryConsulta, dbeProduto.Text, '', False, False, True, False, False, False,
                    False, False, False, True);
    edtDesProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;

    if fCfgSis('ULTCMP', varBoolean) then
      dbeComponenteAExit(Nil);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadProdutos.pCarregaProdutoDiluente;
var
  qryConsulta: TUniQuery;
begin
  Try
    qryConsulta:= fCriaQuery(Self);
    pPesquisaCadIte(qryConsulta, qryConsulta, dbeProdutoDiluente.Text, '', False, False, True, False, False, False,
                    False, False, False, False);
    edtDescProdutoDiluente.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;

    if fCfgSis('ULTCMP', varBoolean) then
      dbeComponenteAExit(Nil);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;



{**********************************************}
{* OS CÁCULOS DE PREÇO ABAIXO FORAM RETIRADOS *}
{* DA ROTINA VALIDACAMPOS E PASSARAM A SER    *}
{* EXECUTADOS NO EVENTO ONEXIT DOS EDITS QUE  *}
{* ESTÃO ENVOLVIDOS NO CÁLCULO DO PREÇO      * }
{*******************************************RL*}
procedure TfrmCadProdutos.pValidarPrecos(Sender: TObject);
  Var
    Result   : Boolean;
    intTabPre: Integer;
    strNomEdt: String;

    function fValidaTodasMargens: Boolean;
      Var
        intAux: Integer;
    Begin
      Result := True;
      For intAux := 1 To Length(VS_strTabPrc) Do
      Begin
        Result := Result And fValidaMargem(intAux);
      End;
    End;

begin
  inherited;

  HintControler.HideHint;

  Result := True;

  strNomEdt := UpperCase(TDBEditFocus(Sender).Name);

  {*****************************************}
  {* VALIDA O PREÇO DE COMPRA              *}
  {**************************************MV*}
  If (Sender = dbePreCom) Then
  Begin
    If fEmptyStr(dbePreCom.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If fStrToFloat(dbePreCom.Text) <= 0.0 Then
    Begin
      fMensagem('ATENÇÃO!', 'O Preço de Compra deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If blnRecalcular Then
        pRecalculaPrecos(intVenMar);
    End;

    If blnRecalcular Then
      edtComLiq.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoCompraLiq);

  End

  Else If (Sender = dbeDesf01) Or
          (Sender = dbeDesf02) Or
          (Sender = dbeDesf03) Or
          (Sender = dbeDesf04) Or
          (Sender = dbeDesf05) Or
          (Sender = dbeDesf06) Then
  Begin

    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Desconto deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

    If blnRecalcular Then
      edtComLiq.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaPrecoCompraLiq);
  End

  Else If (Sender = dbeImpFed) Then
  Begin
    If Not fEmptyStr(dbeImpFed.Text) Then
    Begin
      If Not fValidaEscala(dbeImpFed.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Imposto Federal deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeImpFed.Text := '0';
    End;

    {*******************************************}
    {* CASO SEJA MARGEM                        *}
    {****************************************JB*}
    If (Pos(strMarMkp, '1_5_') > 0)      And
       (Result)                          And
       (fStrToFloat(dbeImpFed.Text) > 0) Then
    Begin
      If Not fValidaTodasMargens Then
      Begin
        fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeIcmEnt) And (dbeIcmEnt.Enabled) Then
  Begin
    If Not fEmptyStr(dbeIcmEnt.Text) Then
    Begin
      If Not fValidaEscala(dbeIcmEnt.Text, 0, 100) Then
      Begin
        fMensagem('','O ICMS de Entrada deve estar entre 0 e 100 ',['&OK']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeIcmEnt.Text := '0';
    End;
  End

  Else If (Sender = dbeSubFed) And (dbeSubFed.Enabled) Then
  Begin
    If Not fEmptyStr(dbeSubFed.Text) Then
    Begin
      If Not fValidaEscala(dbeSubFed.Text, 0, 100) Then
      Begin
        fMensagem('','O campo Impostos Federais deve estar entre 0 e 100', ['&OK']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeSubFed.Text := '0';
    End;
  End

  Else If (Sender = dbeIcmSai) And (dbeIcmSai.Enabled) Then
  Begin
    If Not fEmptyStr(dbeIcmSai.Text) Then
    Begin
      If Not fValidaEscala(dbeIcmSai.Text, 0, 100) Then
      Begin
        fMensagem('','O ICMS de Saida deve estar entre 0 e 100', ['&OK']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeIcmSai.Text := '0';
    End;

    {*******************************************}
    {* CASO SEJA MARGEM                        *}
    {****************************************JB*}
    If (Pos(strMarMkp, '1_5_') > 0)      And
       (Result)                          And
       (fStrToFloat(dbeIcmSai.Text) > 0) Then
    Begin
      If Not fValidaTodasMargens Then
      Begin
        fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeOutVal) Then
  Begin
    If fStrToFloat(dbeOutVal.Text) < 0 Then
    Begin
      fMensagem('','O Valor do campo ' + LowerCase(fCfgSis('DOVCPP')) + ' deve ser maior ou igual à zero!', ['&Ok']);
      Result := False;
    End;
  End

  Else If (Sender = dbeIpiEnt) Or
          (Sender = dbeAcrFin) Or
          (Sender = dbeDesAdb) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

    If Not Result Then
      pgcDados.ActivePage := tbsGeral;
  End

  Else If  ((Sender = dbeDesMax) Or (Sender = dbeDesMSu) Or (Sender = dbeDesMge) Or (Sender = dbeDesMvm) Or (Sender = dbeDesMsm) Or (Sender = dbeDesMgm)) And (Sender As TDBEditFocus).Visible Then
  Begin

    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

    If Not Result Then
      pgcDados.ActivePage := tbsDadosSaida;

  End

  Else If (Sender = dbeFreEnt) Then
  Begin
    If Not fEmptyStr((Sender As TDBEditFocus).Text) Then
    Begin
      If Not fValidaEscala((Sender As TDBEditFocus).Text, 0, 1000) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo ' + (Sender As TDBEditFocus).Field.DisplayLabel + ' deve estar entre 0 e 1000!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      (Sender As TDBEditFocus).Text := '0';
    End;

  End

  Else If (Sender = dbeSubsti) Then
  Begin
    If Not fEmptyStr(dbeSubsti.Text) Then
    Begin
      If Not fValidaEscala(dbeSubsti.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Substituição Tributária deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeSubsti.Text := '0';
    End;

  End


  Else If (Sender = dbeValFre) Then
  Begin
    If Not fEmptyStr(dbeValFre.Text) Then
    Begin
      If (fStrToFloat(dbeValFre.Text) < 0.0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo "' + strDesValFre + '" deve ser maior ou igual a  zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeValFre.Text := '0';
    End;
  End

  Else If (Sender = dbeDesOpe) Then
  Begin

    If Not fEmptyStr(dbeDesOpe.Text) Then
    Begin
      If Not fValidaEscala(dbeDesOpe.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Despesas Operacionais deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      dbeDesOpe.Field.AsFloat := 0.0;
    End;

    {*******************************************}
    {* CASO SEJA MARGEM                        *}
    {****************************************JB*}
    If (Pos(strMarMkp, '1_5_') > 0)      And
       (Result)                          And
       (fStrToFloat(dbeDesOpe.Text) > 0) Then
    Begin
      If Not fValidaTodasMargens Then
      Begin
        fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = dbeTCIF) And (pnlCamposSuframa.Visible) Then
  Begin
    If Not fEmptyStr(dbeTCIF.Text) Then
    Begin
      If Not fValidaEscala(dbeTCIF.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo TCIF deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeTCIF.Text := '0';
    End;

  End

  Else If (Sender = dbeTS) And (pnlCamposSuframa.Visible) Then
  Begin
    If Not fEmptyStr(dbeTS.Text) Then
    Begin
      If Not fValidaEscala(dbeTS.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo TS deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeTS.Text := '0';
    End;

  End

  Else If (Sender = dbeDePiCo) And (pnlCamposSuframa.Visible) Then
  Begin
    If Not fEmptyStr(dbeDePiCo.Text) Then
    Begin
      If Not fValidaEscala(dbeDePiCo.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Desconto PIS/COFINS deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeDePiCo.Text := '0';
    End;

  End

  Else If (Sender = dbeDeICMS) And (pnlCamposSuframa.Visible) Then
  Begin
    If Not fEmptyStr(dbeDeICMS.Text) Then
    Begin
      If Not fValidaEscala(dbeDeICMS.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Desconto ICMS deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeDeICMS.Text := '0';
    End;

  End

  Else If (Sender = dbeFatReg) And (pnlCamposSuframa.Visible) Then
  Begin
    If Not fEmptyStr(dbeFatReg.Text) Then
    Begin
      If Not fValidaEscala(dbeFatReg.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Campo Fator Regional deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End
    End
    Else
    Begin
      dbeFatReg.Text := '0';
    End;

  End

  Else If (Sender Is TDBEditFocus) And
          (TDBEditFocus(Sender).Visible) And
          (Pos(UpperCase('DBEMARID'), strNomEdt) > 0) Then
  Begin

    If blnMarIde Then
    Begin

      intTabPre := StrToInt(RightStr(strNomEdt, 1));

      If Not fEmptyStr(TDBEditFocus(Sender).Text) Then
      Begin
        If fStrToFloat(TDBEditFocus(Sender).Text) > MAX_VALMON Then
        Begin
          TDBEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
        End;

        {*******************************************}
        {* CASO SEJA MARGEM                        *}
        {****************************************JB*}
        If (Pos(strMarMkp, '1_5_') > 0) Then
        Begin

          If (fStrToFloat(TDBEditFocus(Sender).Text) >= 100) Then
          Begin
            pgcDados.ActivePage := tbsMargemIdeal;
            fMensagem('ATENÇÃO!', 'A Margem Ideal não permitida: maior ou igual a 100!', ['&Ok']);
            Result := False;
          End

          Else If Not fValidaMargemIdeal(intTabPre) Then
          Begin
            pgcDados.ActivePage := tbsMargemIdeal;
            fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
            Result := False;
          End;
        End;

        If Result And blnRecalcular Then
          pCalculaPrecoVendaIdeal;
      End;

    End;

  End

  {*******************************************************}
  {* FAZ A VALIDACAO DOS CAMPOS DE MARGEM BRUTA DO ITEM  *}
  {****************************************************JC*}
  Else If (Sender Is TDBEditFocus) And
          (TDBEditFocus(Sender).Visible) And
          (Pos(UpperCase('DBEMARBR'), strNomEdt) > 0) Then
  Begin

    intTabPre := StrToInt(RightStr(strNomEdt, 1));

    If Not fEmptyStr(TDBEditFocus(Sender).Text) Then
    Begin
      If fStrToFloat(TDBEditFocus(Sender).Text) > MAX_VALMON Then
      Begin
        TDBEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
      End;

      {*******************************************}
      {* CASO SEJA MARGEM                        *}
      {****************************************JB*}
      If (Pos(strMarMkp, '1_5_') > 0) Then
      Begin
        If (fStrToFloat(TDBEditFocus(Sender).Text) >= 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'Margem não permitida: maior ou igual a 100!', ['&Ok']);
          Result := False;
        End
        Else If Not fValidaMargem(intTabPre) Then
        Begin
          fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
          Result := False;
        End;
      End;

    End;

    If Result And blnRecalcular Then
    Begin
      qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(1, intTabPre);
      pRecalculaPrecosFator;
    End;

  End

  {*************************************************************}
  {* FAZ A VALIDACAO DOS CAMPOS DE COMISSAO POR TABELA         *}
  {**********************************************************JC*}
  Else If (Sender is TDBEditFocus) And
          (TDBEditFocus(Sender).Visible) And
          (Pos('DBECOMTB', strNomEdt) > 0) Then
  Begin

    intTabPre := StrToInt(RightStr(strNomEdt, 1));

    If Not fEmptyStr(TDBEditFocus(Sender).Text) Then
    Begin
      If fStrToFloat(TDBEditFocus(Sender).Text) > MAX_VALMON Then
      Begin
        TDBEditFocus(Sender).Text := FloatToStr(MAX_VALMON);
      End;

      {*******************************************}
      {* CASO SEJA MARGEM                        *}
      {****************************************JB*}
      If (Pos(strMarMkp, '1_5_') > 0) Then
      Begin
        If (fStrToFloat(TDBEditFocus(Sender).Text) >= 100) Then
        Begin
          fMensagem('ATENÇÃO!', 'Comissão não permitida: maior ou igual a 100!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(TDBEditFocus(Sender).Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Comissão não permitida: menor que zero!', ['&Ok']);
          Result := False;
        End
        Else If Not fValidaMargem(intTabPre) Then
        Begin
          fMensagem('', MSG_VALIDACAO_MARGEM, ['&Ok']);
          Result := False;
        End;

      End;

    End;

    If Result And blnRecalcular Then
    Begin
      qryIteGer.FieldByName('ITE_PREVE' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(1, intTabPre);
      pRecalculaPrecosFator;
    End;

  End

  {*************************************************************}
  {* FAZ A VALIDACAO DOS CAMPOS DE PRECO DE VENDA              *}
  {**********************************************************JC*}
  Else If (Sender is TDBEditFocus) And
          (TDBEditFocus(Sender).Visible) And
          (Pos('DBEPREVE', strNomEdt) > 0) Then
  Begin
    intTabPre := StrToInt(RightStr(strNomEdt, 1));

    If fStrToFloat(TDBEditFocus(Sender).Text) <= 0 Then
    Begin
      pMensagemOk('O Preço de Venda ' + IntToStr(intTabPre) + ' deve ser maior que zero!');
      Result := False;
      pgcDados.ActivePage := tbsGeral;
    End

    else If blnRecalcular Then
    Begin
      qryIteGer.FieldByName('ITE_MARBR' + IntToStr(intTabPre)).AsFloat := fRetPrecoVenda(2, intTabPre);
      pRecalculaPrecosFator;
    end;

    If Result And (tbsExportaSite.TabVisible) And (fCfgSis('TBPECO', varString) = IntToStr(intTabPre)) Then
    begin
      FPanelDadosECommerce.fltVlrLiq := (fStrToFloat(fDbEditFocus('dbePreVe' + IntToStr(intTabPre)).Text));
      FPanelDadosECommerce.pCarregaDadosECommerce;
    End;

  End;

  If (Not Result) Then
  Begin
    pSetFocus(TDBEditFocus(Sender));
  End
  Else If Pos(Copy(strNomEdt, 1, Length(strNomEdt) - 1), 'DBEPREVE_DBEMARBR_DBECOMTB_') <= 0 Then
  Begin

    If blnRecalcular Then
    Begin
      pRecalculaPrecos(intVenMar);

      If (strMarMkp = '4') Then
        edtCusRea.Text := FormatFloat(fMskDigitos(4), fIVAMod4)
      Else
        edtCusRea.Text := FormatFloat(fMskDigitos(intDecUni), fCalculaCustoReal);
    End;

  End;

  If Result And (Pos('DBEPREVE' + IntToStr(intUltTab), strNomEdt) > 0) And (wrdLasKey = VK_RETURN) Then
  Begin
    pProximaPagina;

    If pgcDados.ActivePage = tbsMargemIdeal Then
      pSetFocus(fDbEditFocus('dbeMarId' + IntToStr(intPriTab)))
    Else
      pSetFocus(dbeImpLis);

    wrdLasKey := 0;
  End;

  If blnMarIde And Result And (Pos('DBEMARID' + IntToStr(intUltTab), strNomEdt) > 0) And (wrdLasKey = VK_RETURN) Then
  Begin
    pProximaPagina;

    pSetFocus(dbeImpLis);

    wrdLasKey := 0;
  End;

  If Not Result Then
  Begin
    FValidouPrecos := False;

    pgcDados.ActivePage := tbsGeral;
    pSetFocus(Sender As TWinControl);
  End;

  If Result And blnRecalcular Then
    pAjustaDolar;

  If Result And Assigned(frmManutencaoAbreviacoesLojas) Then
  Begin
    frmManutencaoAbreviacoesLojas.strCodNcm := dbeClaIpi.Text;
    frmManutencaoAbreviacoesLojas.strCodExc := dbeExcIpi.Text;
  End;

  If Not fEmptyStr(edtLinGru.Text) Then
  Begin
    pVerificaMargemGrupo(dbeCodGru.Text);
  End;
end;



procedure TfrmCadProdutos.pVerificaMargemGrupo(strGruLin: string);
var
  qryMargem: TUniQuery;
  intIndice: integer;
begin
  qryMargem := fCriaQuery;

  try
    qryMargem.Close;
    qryMargem.SQL.Clear;
    qryMargem.SQL.Add('SELECT MAT_MARBR1, MAT_MARBR2, MAT_MARBR3, MAT_MARBR4, MAT_MARBR5, MAT_MARBR6, MAT_MARBR7');
    qryMargem.SQL.Add('FROM PROMAT');
    qryMargem.SQL.Add('WHERE MAT_CODGRU = :CODGRU');
    qryMargem.ParamByName('CODGRU').AsString := strGruLin;
    qryMargem.Open;

    if not qryMargem.IsEmpty then
    begin
      for intIndice := 1 to 7 do
      begin
        if (TcxGroupBox(Self.FindComponent('gpbTabPre0' + IntToStr(intIndice))).Visible) then
        begin
          if not qryMargem.FieldByName('MAT_MARBR' + InttoStr(intIndice) ).IsNull then
          begin
            if qryMargem.FieldByName('MAT_MARBR' + InttoStr(intIndice) ).AsFloat > fStrToFloat(fDbEditFocus('dbeMarBr' + IntToStr(intIndice)).Text) then
            begin
              TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intIndice))).Font.Color := clRed;
              TLabel(Self.FindComponent('lblTitPreVe' + IntToStr(intIndice))).Font.Color := clRed;
            end
            else if qryMargem.FieldByName('MAT_MARBR' + InttoStr(intIndice) ).AsFloat < fStrToFloat(fDbEditFocus('dbeMarBr' + IntToStr(intIndice)).Text) then
            begin
              TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intIndice))).Font.Color := clBlue;
              TLabel(Self.FindComponent('lblTitPreVe' + IntToStr(intIndice))).Font.Color := clBlue;
            end
            else
            begin
              TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intIndice))).Font.Color := clGreen;
              TLabel(Self.FindComponent('lblTitPreVe' + IntToStr(intIndice))).Font.Color := clGreen;
            end;
          end
          else
          begin
            TLabel(Self.FindComponent('lblTitMarBr' + IntToStr(intIndice))).Font.Color := clBlack;
            TLabel(Self.FindComponent('lblTitPreVe' + IntToStr(intIndice))).Font.Color := clBlack;
          end;
        end;
      end;
    end;

  finally
    FreeAndNil(qryMargem);
  end;
end;

function TfrmCadProdutos.fVerificaUnidadeComEmbalagemFechada: Boolean;
  Var
    intRecNo: Integer;
begin
  Result := True;

  If blnUnidadeEFracionada Then
    Exit;

  intRecNo := cdsIteEmb.RecNo;
  cdsIteEmb.DisableControls;

  Try
    cdsIteEmb.First;
    While Not cdsIteEmb.Eof Do
    Begin
      If Frac(cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat) <> 0 Then
      Begin
        Result := False;
        Break;
      End;
      cdsIteEmb.Next;
    End;
  Finally
    cdsIteEmb.RecNo := intRecNo;
    cdsIteEmb.EnableControls;
  End;
end;

Function TfrmCadProdutos.fValidaPrecos: Boolean;
Begin
  FValidouPrecos := True;
  Result := fVerificaPreco(pnlPrecos);
End;

function TfrmCadProdutos.fVerificaPreco(objObjeto: TWinControl): Boolean;
  Var
    intContador: Integer;
Begin
  Result := True;

  For intContador := 0 To objObjeto.ControlCount -1 Do
  Begin
    {**********************************}
    {* SE O COMPONETE FOR UM PANEL,   *}
    {* UM SCROLLBOX OU TABSHEET       *}
    {*******************************AF*}
    If (objObjeto.Controls[intContador] Is TPanel)     Or
       (objObjeto.Controls[intContador] Is TScrollBox) Or
       (objObjeto.Controls[intContador] Is TGroupBox)  Or
       (objObjeto.Controls[intContador] Is TTabSheet)  Then
    Begin

      If (objObjeto.Controls[intContador] Is TTabSheet) Then
      Begin
        {*******************************************}
        {* CASO NÃO QUERIA VALIDA UM TABSHEET, USE *}
        {* O VALOR -1 EM SEU TAG                   *}
        {****************************************MV*}
        If ((objObjeto.Controls[intContador] As TTabSheet).Tag = -1) Then
        Begin
          Exit
        End;
      End;

      Result := fVerificaPreco((objObjeto.Controls[intContador] As TWinControl));

      If Not Result Then
        Exit;

    End
    Else
    Begin
      {**************************************}
      {* SE A TAG DO COMPONENTES = 99 ENTÃO *}
      {***********************************AF*}
      If objObjeto.Controls[intcontador].Tag = 99 Then
        If (objObjeto.Controls[intContador] Is TWinControl) Then
        Begin
          Try
            blnRecalcular := False;

            pValidarPrecos((objObjeto.Controls[intContador] As TWinControl));

            blnRecalcular := True;

            Result := FValidouPrecos;
          Except
            On E: Exception Do
            Begin
              blnRecalcular := True;
              pMensagensErro(E.Message,'[TfrmCadProdutos.fVerificaPreco]');
              pGravarErro(True, E.Message + ' - ' + Self.Name + '.' + (objObjeto.Controls[intContador] As TWinControl).Name);
        Result := False;
    End;
  End;
  End;

        If Not Result Then
          Exit;
    End;

  End;

end;

{procedure TfrmCadProdutos.pVerificaDepartamentoIndustrial;
begin
  //Se utilizar o modulo industrial
  If fCfgSis('UTIIND', varBoolean) And (Not fEmptyStr(qryTabela.FieldByName('ITE_CODDEP').AsString)) Then
//    If (qryTabela.FieldByName('ITE_CODDEP').AsString = fCfgSis('PROGRA', varString)) Then
    If (qryTabela.FieldByName('ITE_CODDEP').AsString = fRetTipoDepartamento(qryTabela.FieldByName('ITE_CODDEP').AsString, 'PROGRA')) Then
       pZerarEDesabilitarPrecos;
end;}


function TfrmCadProdutos.fInativarProduto: Boolean;
  Var
    qryTmpIteger: TUniQuery;
    strSQL      : String;
    strCodEmp   : String;
    blnUsaQtdPen: Boolean;
begin
  inherited;

  Result := True;

  If dbeIteAti.Text = 'N' Then
  Begin

    If (qryTabela.State In dsEditModes) And (dbeAtiCom.Text = 'S') Then
    Begin

      If Not fPergunta('O produto também será inativado para compra, confirma?') Then
      Begin
        qryTabela.FieldByName('ITE_ITEATI').AsString := 'S';
        Result := False;
        Exit;
      End;

      qryTabela.FieldByName('ITE_ATICOM').AsString := 'N';
    End;

    qryTmpIteger := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + ' ITEGER.ITE_CODEMP, ';
    blnUsaQtdPen := fUsaQtdPendenteEntregaFutura(True);
    If blnUsaQtdPen Then
      strSQL := strSQL + ' IFNULL(ITE_QTEF_A, 0) +  IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) AS ITE_ENTFUT,';
    strSQL := strSQL + ' ROUND(ITE_SALDOS + IFNULL( ITE_SAL_ML / IF( ITE_CNV_ML > 0, ITE_CNV_ML, 1 ), 0), 4) AS ITE_SALDOS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + '  INNER JOIN CADITE ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITEGER.ITE_CODITE = :CODITE AND ';
    If blnUsaQtdPen Then
      strSQL := strSQL + '  (ROUND(ITE_SALDOS + IFNULL( ITE_SAL_ML / IF( ITE_CNV_ML > 0, ITE_CNV_ML, 1 ), 0), 4) <> 0 OR (IFNULL(ITE_QTEF_A, 0) +  IFNULL(ITE_QTEF_F, 0) + IFNULL(ITE_QTEF_P, 0) <> 0)) '
    Else
      strSQL := strSQL + '  ROUND(ITE_SALDOS + IFNULL( ITE_SAL_ML / IF( ITE_CNV_ML > 0, ITE_CNV_ML, 1 ), 0), 4) <> 0 ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  ITE_CODEMP ';

    With qryTmpIteger Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODITE').AsString := dbeCodIte.Text;

        Open;

        strCodEmp := '';

        While Not Eof Do
        Begin
          If blnUsaQtdPen Then
            strCodEmp := strCodEmp + FieldByName('ITE_CODEMP').AsString + ' (Saldo: ' + FormatFloat('#,##0.0000', FieldByName('ITE_SALDOS').AsFloat) +
                                                                           ' Entrega Futura: '+FormatFloat('#,##0.0000', FieldByName('ITE_ENTFUT').AsFloat)+' ), '
          Else
            strCodEmp := strCodEmp + FieldByName('ITE_CODEMP').AsString + ' (' + FormatFloat('#,##0.0000', FieldByName('ITE_SALDOS').AsFloat) + '), ';
          Next;
        End;

        Close;
        FreeAndNil(qryTmpIteger);

      End;

    If strCodEmp <> '' Then
    Begin

      strCodEmp := Copy(strCodEmp, 1, Length(strCodEmp) - 2);

      pMensagemOk('Este produto possui saldo na(s) empresa(s): ' + strCodEmp + '. ' + #13 + 'Não é possível inativá-lo !', 1000, 270);

      pSetFocus(dbeIteAti);

      Result := False;

    End;

  End;

end;

procedure TfrmCadProdutos.dbeDesIteChange(Sender: TObject);
  Var intTamDNF: Integer;
begin
  inherited;
  {********************************************}
  {* AJUSTA A POSIÇÃO DA SETA PARA INDICAR    *}
  {* ATÉ QUAL CARACTERE SERÁ IMPRESSO NA NOTA *}
  {**07/03/2008 - 10:20 ********************ER*}
  intTamDNF := fCfgSis('TAMDNF', varInteger);
  If fCfgSis('TAMDNF', varInteger) > 0 Then
  Begin
    lblRefePonteiro.Caption := LeftStr(dbeDesIte.Text, fCfgSis('TAMDNF', varInteger));
    lblSeta.Left            := (lblRefePonteiro.Left + lblRefePonteiro.Width) - Canvas.TextWidth(Copy(dbeDesIte.Text, intTamDNF, 1));
  End;
end;

procedure TfrmCadProdutos.dbeSetFlzKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSetFlz : TConsultasArray;
begin
  inherited;
  {*************************************}
  {* NOVA CONSULTA DE SETORES FILIZOLA *}
  {**********************************DP*}
  If fPesqSetFlz(Self, dbeSetFlz, edtDesSet, Nil, Key, arrSetFlz) Then
  Begin
    If (fValidaCampos(dbeSetFlz)) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeSitProKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqSituacaoProduto(Self,
                          dbeSitPro,
                          edtSitPro,
                          Nil,
                          Key,
                          arrSel) And
    fValidaCampos(dbeSitPro, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadProdutos.pCarregaCadSfz;
begin
  edtDesSet.Text := fRetDesSfz(dbeSetFlz.Text);
end;

procedure TfrmCadProdutos.edtCodAtriEnter(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '[Insert] para incluir um novo Atributo';

end;

procedure TfrmCadProdutos.edtCodAtriExit(Sender: TObject);
begin
  inherited;

  pnlInfo.Caption := '';
end;

procedure TfrmCadProdutos.edtCodAtriKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqAtributo(Self, edtCodAtri, edtDesAtri, Nil, Key, arrSel) Then
    If fValidaCampos(edtCodAtri, True) Then
      pSetFocus(btnIncluiAtrib);
end;

procedure TfrmCadProdutos.edtCodAtriKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If Key = VK_Insert Then
    edtCodAtri.Text := fChamaCadAtr(Key);

end;

procedure TfrmCadProdutos.dbeValCalEnter(Sender: TObject);
begin
  inherited;
  If fEmptyStr(dbeValCal.Text) Then
    dbeValCal.Text := '0';

  If fEmptyStr(dbeValEne.Text) Then
    dbeValEne.Text := '0';

  If fEmptyStr(dbeVGorTa.Text) Then
    dbeVGorTa.Text := '0';

  If fEmptyStr(dbePerEne.Text) Then
    dbePerEne.Text := '0';

  If fEmptyStr(dbePGorTa.Text) Then
    dbePGorTa.Text := '0';

  If fEmptyStr(dbeVCarbo.Text) Then
    dbeVCarbo.Text := '0';

  If fEmptyStr(dbeVProte.Text) Then
    dbeVProte.Text := '0';

  If fEmptyStr(dbeVGorTo.Text) Then
    dbeVGorTo.Text := '0';

  If fEmptyStr(dbeVGorSa.Text) Then
    dbeVGorSa.Text := '0';

  If fEmptyStr(dbePerCal.Text) Then
    dbePerCal.Text := '0';

  If fEmptyStr(dbePCarbo.Text) Then
    dbePCarbo.Text := '0';

  If fEmptyStr(dbePProte.Text) Then
    dbePProte.Text := '0';

  If fEmptyStr(dbePGorTo.Text) Then
    dbePGorTo.Text := '0';

  If fEmptyStr(dbePGorSa.Text) Then
    dbePGorSa.Text := '0';

  If fEmptyStr(dbeVColes.Text) Then
    dbeVColes.Text := '0';

  If fEmptyStr(dbePColes.Text) Then
    dbePColes.Text := '0';

  If fEmptyStr(dbeVFibAl.Text) Then
    dbeVFibAl.Text := '0';

  If fEmptyStr(dbePFibAl.Text) Then
    dbePFibAl.Text := '0';

  If fEmptyStr(dbeVCalci.Text) Then
    dbeVCalci.Text := '0';

  If fEmptyStr(dbePCalci.Text) Then
    dbePCalci.Text := '0';

  If fEmptyStr(dbeVFerro.Text) Then
    dbeVFerro.Text := '0';

  If fEmptyStr(dbeVSodio.Text) Then
    dbeVSodio.Text := '0';

  If fEmptyStr(dbePFerro.Text) Then
    dbePFerro.Text := '0';

  If fEmptyStr(dbePSodio.Text) Then
    dbePSodio.Text := '0';
end;

procedure TfrmCadProdutos.dbeValorCataliseKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If key = #13 then
  Begin
    If pnlDesclComponeteAB.Enabled Then
      pSetFocus(dbeProduto);
  End;

end;

procedure TfrmCadProdutos.pOnExit(Sender: TObject);
  Var
    blnResult: Boolean;
begin
  blnResult := True;

  If Pos(LeftStr(TEditFocus(Sender).Name, 9), 'dbeEstMi1') > 0 Then
  Begin
    If fEmptyStr(TEditFocus(Sender).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser preenchido!', ['&O k']);
      pSetFocus(TEditFocus(Sender));
      blnResult := False;
    End
    Else If (fStrToFloat(TEditFocus(Sender).Text) < 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Mínimo deve ser maior ou igual a Zero!', ['&O k']);
      pSetFocus(TEditFocus(Sender));
      blnResult := False;
    End;

    TEditFocus(Sender).Text := FormatFloat('#,##0.000', fStrToFloat(TEditFocus(Sender).Text));
  End

  Else If Pos(LeftStr(TEditFocus(Sender).Name, 9), 'dbeEstMa1') > 0 Then
  Begin
    If fEmptyStr(TEditFocus(Sender).Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Estoque Máximo deve ser preenchido!', ['&O k']);
      pSetFocus(TEditFocus(Sender));
      blnResult := False;
    End;

    TEditFocus(Sender).Text := FormatFloat('#,##0.000', fStrToFloat(TEditFocus(Sender).Text));
  End

  Else If Pos(LeftStr(TEditFocus(Sender).Name, 9), 'dbeNivGi1') > 0 Then
  Begin
    If TEditFocus(Sender).Visible And (Pos(TEditFocus(Sender).Text, 'A_B_C_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O nível de giro deve ser A, B ou C!', ['&Ok']);
      pSetFocus(TEditFocus(Sender));
      pgcDados.ActivePage := tbsEstoque;
      blnResult := False;
    End
  End

  Else If Pos(LeftStr(TEditFocus(Sender).Name, 9), 'dbeImpLi1') > 0 Then
  Begin
    If TEditFocus(Sender).Visible And (Pos(TEditFocus(Sender).Text, 'S_N_') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Imprime Lista deve ser (S) ou (N)!', ['&Ok']);
      pSetFocus(TEditFocus(Sender));
      pgcDados.ActivePage := tbsEstoque;
      blnResult := False;
    End
  End

  Else If Pos(LeftStr(TEditFocus(Sender).Name, 9), 'dbeApeRe1') > 0 Then
  Begin
    If TEditFocus(Sender).Visible And (Pos(TEditFocus(Sender).Text, 'SN') <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'Apenas Retira deve ser (S) ou (N)!', ['&Ok']);
      pgcDados.ActivePage := tbsEstoque;
      pSetFocus(TEditFocus(Sender));
      blnResult := False;
    End
  End;

  If (Sender = dbeLstCmp) And blnResult Then
  Begin
    pProximaPagina;

    If (pgcDados.ActivePage = tbsPrecos) And tbsPrecos.TabVisible Then
    Begin
      tbsPrecosShow(tbsPrecos);
      pgcUltVendaCompra.TabIndex := 0;
      pgcUltVendaCompra.ActivePage  := tbsUltCompra;
      pSetFocus(dbgCompras);
    End;
  End;

end;

procedure TfrmCadProdutos.pOnStateChange;
begin
  inherited;
  cxgDesMaxTabPre.Enabled := (qryTabela.State In [dsEdit, dsInsert]) AND
                             (fVerificaAcessoSistema('PERDMP', strLoginUsuarioLogado));
  cxgDesMaxFaixaQtde.Enabled := qryTabela.State In [dsEdit, dsInsert];
  dbgIteCom.Enabled := (qryTabela.State in dsEditModes);
end;

procedure TfrmCadProdutos.pCarregaItegerAtual(qryIteAtu: TUniQuery);
Begin
  With qryIteAtu, SQL Do
  Begin
    Clear;
    Add('SELECT * FROM ITEGER');
    Add('WHERE');
    Add('  ITE_CODITE = :CODITE AND ');
    Add('  ITE_CODEMP = :CODEMP     ');
    Close;
    ParamByName('CODITE').AsString := qryTabela.FieldbyName('ITE_CODITE').AsString;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;
End;

procedure TfrmCadProdutos.pCarregaUltVendas(strCodIte : String);
  Var
    qryIteAtu: TUniQuery;
    dtaCorte: TDateTime;

    Procedure pSetaparametos(qryMovDet: TUniQuery);
    Begin
      With qryMovDet Do
      Begin
        If Params.FindParam('DTAINI') <> Nil Then
          ParamByName('DTAINI').AsDate := IncMonth(VS_Date, - fCfgSis('ULTVEN', VarInteger));

        ParamByName('CODITE').Value := strCodIte;
        ParamByName('CLAFIS').AsString := VS_strClaVen;
        ParamByName('CLADEV').AsString := VS_strClaDev;

        If rgpDadosUvc.ItemIndex = 1 Then
          qryMovDet.SQL.Text := AnsiReplaceStr(qryMovDet.SQL.Text, ':CODEMP', fStringSQLLocateToStringSQLIN(fRetEmpAcessoUsuario(strLoginUsuarioLogado)))
        Else
          ParamByName('CODEMP').Value := VS_StrCodEmp;

        If Params.FindParam('DTACOR') <> Nil Then
          ParamByName('DTACOR').AsDate := dtaCorte;
      End;
    End;

    Procedure pDeterminaPeriodo;
      Var
        qryMovDet: TUniQuery;
        strSQL: String;
        intContador: Integer;
        blnAchouData: Boolean;
   Begin
      blnAchouData := False;

      qryMovDet := fCriaQuery;

      dtaCorte := IncMonth(VS_Date, -1);

      strSQL := '';
      strSQL := strSQL + ' SELECT COUNT(0) AS QTD';
      strSQL := strSQL + ' FROM MOVDET D ';
      strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
      strSQL := strSQL + ' WHERE ';

      strSQL := strSQL + fSQLWhereUltimasVendas(rgpDadosUvc.ItemIndex = 0, fCfgSis('ENTBRF', varBoolean), True, True, Not(rgpDadosUvc.ItemIndex = 0));

      With qryMovDet Do
      Begin

        intContador := 0;

        While intContador <= 3 Do
        Begin
          Inc(intContador);

          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          pSetaparametos(qryMovDet);

          Open;

          If FieldByName('QTD').AsInteger >= 30 Then
          Begin
            blnAchouData := True;
            Break;
          End Else
          Begin
            dtaCorte := IncMonth(dtaCorte, -1);
          End;
        End;

      End;

      If Not blnAchouData Then
        dtaCorte := 0;

      FreeAndNil(qryMovDet);
    End;

Begin
  {*********************************}
  { CARREGA AS ULTIMAS VENDAS NO    }
  { DBGRID DA PAGINA - 5            }
  {******************************JB*}
  With qryUltVendas Do
  Begin
    Close;
    SQL.Clear;

    pDeterminaPeriodo;

    SQL.Add(fSQLUltimasVendas(30, rgpDadosUvc.ItemIndex = 0, fCfgSis('ENTBRF', varBoolean), True, dtaCorte > 0));

    pSetaparametos(qryUltVendas);

    Open;

    {*********************************}
    { GRAVA A ULT VENDA NO ITEGER     }
    {******************************JB*}
    If (Not IsEmpty) (*And (Not blnAtualizouUV)*) Then
    Begin
      blnAtualizouUV := True;

    {NÃO GRAVARÁ MAIS ULTIMA VENDA}
    //  pGravaVenda();

      qryIteAtu := fCriaQuery(Self);
      pCarregaItegerAtual(qryIteAtu);
      pCarregaDadosSomenteLeitura(qryIteAtu);
      FreeAndNil(qryIteAtu);
    End;

    (FieldByName('QTDITE') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('PR_TOTAL') As TFloatField).DisplayFormat    := '#,####0.0000';
    (FieldByName('PR_UNITARIO') As TFloatField).DisplayFormat := '#,####0.0000';

  End;

end;

procedure TfrmCadProdutos.pCdsIteComBeforeInsert(Dataset: TDataset);
begin
  Abort;
end;

procedure TfrmCadProdutos.pCarregaUltCompras(strCodIte : String; strNomCol  : String = 'DTA_MOV');
  Var
    qryIteAtu : TUniQuery;
    strSQL  : String;
Begin
  fFindColumnByName(dbgCompras, 'DET_VALTCI').Visible := pnlCamposSuframa.Visible;
  fFindColumnByName(dbgCompras, 'DET_VAL_TS').Visible := pnlCamposSuframa.Visible;

  {*********************************}
  { CARREGA AS ULTIMAS COMPRAS NO   }
  { DBGRID DA PAGINA - 6            }
  {******************************JB*}
  With qryUltCompras Do
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  D.DET_DTAENT AS DTA_MOV, ';
    strSQL := strSQL + '  D.DET_DTADOC AS DTADOC, ';
    strSQL := strSQL + '  D.DET_NUMDOC AS NUMDOC, ';
    strSQL := strSQL + '  D.DET_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  D.DET_CODEMP AS CODEMP, ';
    strSQL := strSQL + '  CAST((SELECT GROUP_CONCAT(CONCAT("PD-", PCD_NUMPED)) FROM BAIPED B       ';
    strSQL := strSQL + '	 LEFT JOIN PCMDET P ON B.BAI_AUTPED = P.AUTOINCREM        ';
    strSQL := strSQL + '   WHERE BAI_AUTDET = D.AUTOINCREM) AS CHAR(255))AS PEDCOM, ';
    strSQL := strSQL +    fFormataCondPagSQL('D.DET_CONPAG','CONPAG') + ',';
    strSQL := strSQL + '  U.UNI_DESUNI AS UNIVEN, ';
    strSQL := strSQL + '  N.UNI_DESUNI AS UNICOM, ';
    strSQL := strSQL + '  FOR_CODFOR AS CODFOR,   ';
    strSQL := strSQL + '  FOR_NOMFOR AS "FORNECEDOR",  ';
    strSQL := strSQL + '  D.DET_CLAFIS AS CLAFIS, ';
    strSQL := strSQL + '  SUM(DET_QTDITE) AS QTDITE, ';
    strSQL := strSQL + '  ROUND(SUM(DET_TOTITE - DET_DESESP) / SUM(DET_QTDITE), 4) AS UNITARIO, ';
    strSQL := strSQL + '  SUM(DET_TOTITE - DET_DESESP) AS PR_TOTAL, ';

    strSQL := strSQL + '  IFNULL(D.DET_VALIPI / DET_QTDITE, 0.00) AS DET_VALIPI, ';
    strSQL := strSQL + '  IFNULL(T.DET_VAEIPI / DET_QTDITE, 0.00) AS DET_VAEIPI, ';
    strSQL := strSQL + '  IFNULL(DET_TOTFRE / DET_QTDITE, 0.00) AS DET_VALFRE, ';
    strSQL := strSQL + '  IFNULL(DET_OUTDES / DET_QTDITE, 0.00) AS DET_OUTDES, ';
    strSQL := strSQL + '  IFNULL(DET_VENDOR / DET_QTDITE, 0.00) AS DET_VENDOR, ';
    strSQL := strSQL + '  IFNULL(DET_CONFRE / DET_QTDITE, 0.00) AS DET_CONFRE, ';
    strSQL := strSQL + '  IFNULL(DET_DESACE / DET_QTDITE, 0.00) AS DET_DESACE, ';
    strSQL := strSQL + '  IFNULL(DET_ICMANT / DET_QTDITE, 0.00) AS DET_ICMANT, ';
    strSQL := strSQL + '  IFNULL(DET_VLGNRE / DET_QTDITE, 0.00) AS DET_VLGNRE, ';

    strSQL := strSQL + '  IFNULL(DET_VALTCI / DET_QTDITE, 0.00) AS DET_VALTCI, ';
    strSQL := strSQL + '  IFNULL(DET_VAL_TS / DET_QTDITE, 0.00) AS DET_VAL_TS, ';

    strSQL := strSQL + '  IFNULL(DET_VALRET / DET_QTDITE, 0.00) AS DET_VALRET, ';
    strSQL := strSQL + '  IFNULL(DET_VAERET / DET_QTDITE, 0.00) AS DET_VAERET, ';

    strSQL := strSQL + ' IFNULL(DET_ALQPIS, 0.00) AS DET_ALQPIS, ';
    strSQL := strSQL + ' IFNULL(DET_ALQCOF, 0.00) AS DET_ALQCOF, ';

    strSQL := strSQL + '  IFNULL(DET_VALICM / DET_QTDITE, 0.00) AS DET_VALICM, ';
    strSQL := strSQL + '  IFNULL(DET_TOTULT / DET_QTDITE, 0.00) AS DET_TOTULT, ';
    strSQL := strSQL + '  IFNULL(DET_IMPULT / DET_QTDITE, 0.00) AS DET_IMPULT, ';

    strSQL := strSQL + '  CONCAT(D.DET_CODVEN, "-", OPE_NOMOPE) AS "OPERAD",  ';

    strSQL := strSQL + '  L.LTP_PRECOM AS PRECOM, ';
    strSQL := strSQL + '  L.LTP_DESF01 AS DESF01, ';
    strSQL := strSQL + '  L.LTP_DESF02 AS DESF02, ';
    strSQL := strSQL + '  L.LTP_DESF03 AS DESF03, ';
    strSQL := strSQL + '  L.LTP_DESF04 AS DESF04, ';
    strSQL := strSQL + '  L.LTP_DESF05 AS DESF05, ';
    strSQL := strSQL + '  L.LTP_DESF06 AS DESF06, ';
    strSQL := strSQL + '  L.LTP_COMLIQ AS COMLIQ, ';
    strSQL := strSQL + '  L.LTP_ICMENT AS ICMENT, ';
    strSQL := strSQL + '  L.LTP_SUBFED AS SUBFED, ';
    strSQL := strSQL + '  L.LTP_IPIENT AS IPIENT, ';
    strSQL := strSQL + '  L.LTP_FREENT AS FREENT, ';
    strSQL := strSQL + '  L.LTP_VALFRE AS VALFRE, ';
    strSQL := strSQL + '  L.LTP_ACRFIN AS ACRFIN, ';
    strSQL := strSQL + '  L.LTP_SUBSTI AS SUBSTI, ';
    strSQL := strSQL + '  L.LTP_DESADB AS DESADB, ';
    strSQL := strSQL + '  L.LTP_PRECUS AS PRECUS, ';

    strSQL := strSQL + '  D.DET_CODITE AS CODITE, ';
    strSQL := strSQL + '  D.DET_CODFOR AS CODFOR, ';
    strSQL := strSQL + '  D.DET_HORENT AS "HOR_MOV", ';
    strSQL := strSQL + '  DET_BASICM AS BASICM, ';
    strSQL := strSQL + '  DET_ALQICM AS ALQICM, ';
    strSQL := strSQL + '  DET_VALICM AS VALICM, ';

    strSQL := strSQL + '  SUM((DET_BASRET + IFNULL(T.DET_BAERET,0))) AS BASRET, ';
    strSQL := strSQL + '  SUM((DET_VALRET + IFNULL(T.DET_VAERET,0))) AS VALRET, ';

    strSQL := strSQL + '  SUM((DET_BASIPI + IFNULL(T.DET_BAEIPI,0))) AS BASIPI, ';
    strSQL := strSQL + '  IF(IFNULL(DET_ALQIPI, 0) = 0, T.DET_ALEIPI, DET_ALQIPI) AS ALQIPI, ';
    strSQL := strSQL + '  SUM((DET_VALIPI + IFNULL(T.DET_VAEIPI,0))) AS VALIPI  ';



    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  JOIN MOVDET D ON D.DET_CODITE = I.ITE_CODITE ';
    strSQL := strSQL + '  JOIN CADFOR ON DET_CODFOR = FOR_CODFOR ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADUNI U ON I.ITE_CODUNI = U.UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN CADUNI N ON I.ITE_UNICOM = N.UNI_CODUNI ';
    strSQL := strSQL + '  LEFT JOIN CADOPE O ON O.OPE_CODOPE = D.DET_CODVEN ';
    strSQL := strSQL + '  LEFT JOIN LOTPRE L ON L.LTP_SEQDET = D.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';

    If (fCfgSis('ULTCOM', VarInteger) > 0) Then
    Begin
      strSQL := strSQL + '  D.DET_DTAENT >= :DTAINI AND ';
    End;

    strSQL := strSQL + '  D.DET_TIP_FC = "F"          AND ';

    If rgpDadosUvc.ItemIndex = 0 Then
      strSQL := strSQL + '  D.DET_CODEMP = :CODEMP      AND '
    Else
      strSQL := strSQL + '  D.DET_CODEMP IN (:CODEMP)      AND ';

    strSQL := strSQL + '  D.DET_CODITE = :CODITE      AND ';

    strSQL := strSQL + '  ( ';
    strSQL := strSQL + '   (D.DET_CODFOR NOT IN (' + fRetornaForFil + ') AND ';
    strSQL := strSQL + '    LOCATE(DET_CLAFIS, :CLACOM) > 0) OR ';

    If fCfgSis('ATUMED', varBoolean) Then
      strSQL := strSQL + ' (D.DET_CODFOR IN (' + fRetornaForFil + ') AND DET_ORIDOC = "") '
    Else
      strSQL := strSQL + ' FALSE ';

    strSQL := strSQL + '  ) ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  D.DET_NUMDOC, D.DET_ESPDOC, D.DET_CODEMP, D.DET_CODFOR ';

    strSQL := strSQL + 'ORDER BY  ';
    If UpperCase(strNomCol) = 'DTA_MOV' Then
      strSQL := strSQL + '  DET_DTAENT DESC, DET_HORENT DESC '
    Else
      strSQL := strSQL + '  ' + strNomCol;

    strSQL := strSQL + ' LIMIT 30 ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Params.FindParam('DTAINI') <> Nil Then
      ParamByName('DTAINI').AsDate := IncMonth(VS_Date, - fCfgSis('ULTCOM', VarInteger));

    ParamByName('CODITE').Value    := strCodIte;
    ParamByName('CLACOM').AsString := VS_strClaCom +  fRetornarClassificacoesBonificacaoEntrada;

    If rgpDadosUvc.ItemIndex = 0 Then
      ParamByName('CODEMP').Value    := VS_strCodEmp
    Else
      qryUltCompras.SQL.Text := AnsiReplaceStr(qryUltCompras.SQL.Text, ':CODEMP', fStringSQLLocateToStringSQLIN(fRetEmpAcessoUsuario(strLoginUsuarioLogado)));
    Open;

    {*********************************}
    { GRAVA A ULT COMPRA NO ITEGER    }
    {******************************JB*}
    If (Not IsEmpty) And (Not blnAtualizouUC) Then
    Begin
      blnAtualizouUC := True;

      qryIteAtu := fCriaQuery(Self);
      pCarregaItegerAtual(qryIteAtu);
      pCarregaDadosSomenteLeitura(qryIteAtu);
      FreeAndNil(qryIteAtu);
    End;

    (FieldByName('QTDITE') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('PR_TOTAL') As TFloatField).DisplayFormat    := '#,####0.0000';
    (FieldByName('UNITARIO') As TFloatField).DisplayFormat    := '#,####0.0000';

    (FieldByName('BASICM') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('ALQICM') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALICM') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('BASRET') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALRET') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('BASIPI') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('ALQIPI') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALIPI') As TFloatField).DisplayFormat      := '#,##0.00';

    (FieldByName('DET_VALIPI') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VAEIPI') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VALFRE') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_OUTDES') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VENDOR') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_CONFRE') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_DESACE') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_ICMANT') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VLGNRE') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VALRET') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VAERET') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_ALQPIS') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_ALQCOF') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_VALICM') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_TOTULT') As TFloatField).DisplayFormat  := '#,##0.00';
    (FieldByName('DET_IMPULT') As TFloatField).DisplayFormat  := '#,##0.00';

    (FieldByName('PRECOM') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF01') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF02') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF03') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF04') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF05') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESF06') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('COMLIQ') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('ICMENT') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('SUBFED') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('IPIENT') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('FREENT') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('VALFRE') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('ACRFIN') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('SUBSTI') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('DESADB') As TFloatField).DisplayFormat      := '#,##0.00';
    (FieldByName('PRECUS') As TFloatField).DisplayFormat      := '#,##0.00';

  End;

end;

procedure TfrmCadProdutos.tbsPrecosShow(Sender: TObject);
begin
  inherited;


  edtPMED_V.Visible := fCfgSis('RNPMVE',varBoolean);
  lblPMED_V.Visible := edtPMED_V.Visible;
  pSetFocus(pgcUltVendaCompra);

end;

procedure TfrmCadProdutos.tbsProdAcabShow(Sender: TObject);
begin
  inherited;
  If pnlComponente.Visible Then
  Begin
    If dbeComponenteA.Enabled then
      pSetFocus(dbeComponenteA);
  End;
end;

procedure TfrmCadProdutos.tbsproduto_veiculoShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtDescMarVei);
end;

procedure TfrmCadProdutos.dbgComprasTitleClick(Column: TColumn);
begin
  inherited;
  If Not qryUltCompras.Active Then
    Exit;

  If Not fItemEstrutura(qryTabela.FieldbyName('ITE_CODITE').AsString) Then
    pCarregaUltCompras(qryTabela.FieldbyName('ITE_CODITE').AsString, Column.Field.FieldName);

end;

procedure TfrmCadProdutos.dbgFornecedorDrawColumnCell(Sender: TObject;
  const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If Column.FieldName = strLastField_For Then
  begin
    dbgFornecedor.Canvas.Brush.Color := clSilver;
    dbgFornecedor.Canvas.FillRect(Rect);
    dbgFornecedor.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  End;

end;

procedure TfrmCadProdutos.dbgFornecedorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_Return: Begin
                 If tbsEmbalagens.TabVisible Then
                 Begin
                   pgcDados.SelectNextPage(True);
                 End
                 Else
                   SelectNext(ActiveControl, True, True);
               End;
    VK_ESCAPE: btnSairClick(Sender);
    VK_DELETE: If (cdsFornecedor.RecordCount > 0) And ((qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit)) Then
                 cdsFornecedor.Delete;
  End;
end;

procedure TfrmCadProdutos.dbgFornecedorTitleClick(Column: TColumn);
begin
  inherited;
  // pCarregaFornecedores(qryTabela.FieldbyName('ITE_CODITE').AsString, Column.Field.FieldName);
  cdsFornecedor.IndexFieldNames := Column.Field.FieldName;
  strLastField_For := Column.Field.FieldName;
end;

procedure TfrmCadProdutos.dbgIteComDBTableViewColumn2PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if not fEmptyStr(DisplayValue) then
  begin
    if (DisplayValue < 0) or (DisplayValue > 100) then
    begin
      fMensagem('ATENÇÃO', 'Informar valor entre 0 e 100!', ['&Ok']);
      DisplayValue := 0;
    end;
  end;
end;

procedure TfrmCadProdutos.dbgIteComDBTableViewColumn3PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  if not fEmptyStr(DisplayValue) then
  begin
    if (DisplayValue < 0) or (DisplayValue > 100) then
    begin
      fMensagem('ATENÇÃO', 'Informar valor entre 0 e 100!', ['&Ok']);
      DisplayValue := 0;
    end;
  end;
end;

procedure TfrmCadProdutos.dtsCadIteDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  pUpdateCaption;
  pHabilitarControladoPolicia;
end;

procedure TfrmCadProdutos.dtsCadIteStateChange(Sender: TObject);
begin
  inherited;
  pUpdateCaption;
  pnlIteEmb.Enabled  := qryTabela.State in dsEditModes;
  btnFatAcre.Enabled := qryTabela.State in dsEditModes;
end;

procedure TfrmCadProdutos.edtCodFornEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadProdutos.edtCodFornExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadProdutos.edtCodFornKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodForn, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodForn, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.edtCodFornKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_insert Then
  Begin
    TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
    edtCodForn.Text := untFuncIns.fChamaCadFor(Key);
  End;
end;

procedure TfrmCadProdutos.edtCodForPalKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;

begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodForPal, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodForPal, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbgComprasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: Begin
                 pProximaPagina;
                 If tbsFornecedores.Visible Then
                  pSetFocus(edtCodForn);
               End;
    VK_ESCAPE: btnSairClick(Sender);
  End;

end;

procedure TfrmCadProdutos.dbgVendasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: Begin
                 pProximaPagina;
                 If tbsFornecedores.Visible Then
                  pSetFocus(edtCodForn);
               End;
    VK_ESCAPE: btnSairClick(Sender);
  End;


end;

procedure TfrmCadProdutos.tbsUltVendaShow(Sender: TObject);
begin
  inherited;
  pSetFocus(dbgVendas);
end;

function TfrmCadProdutos.fValidarFatorMadeira_X_Pecas: boolean;
var qryConsulta : TUniQuery;
begin
  Result := False;
  If dbeCodUni.Text <> '' Then
  Begin
    qryConsulta := fCriaQuery;
    try
      With qryConsulta Do
      Begin
        Sql.Add('SELECT COUNT(U.UNI_CODUNI) AS RES_OK');
        Sql.Add('  FROM  CADUNI U');
        Sql.Add(' WHERE U.UNI_CODUNI = :CODUNI');
        Sql.Add('   AND U.UNI_CODEMP = :CODEMP');
        Sql.Add('   AND U.UNI_METFAT = "S"');
        ParamByName('CODUNI').AsString := dbeCodUni.Text;
        ParamByName('CODEMP').AsString := VS_strCodEmp ;
        Open;
        Result := qryConsulta.FieldByName('RES_OK').AsInteger > 0;
      End;
    Finally
      FreeAndNil(qryConsulta);
    End;
  End;
end;

procedure TfrmCadProdutos.pgcDadosChange(Sender: TObject);
begin
  inherited;
  If Assigned(frmManutencaoAbreviacoesLojas) Then
  Begin
    frmManutencaoAbreviacoesLojas.strCodNcm := dbeClaIpi.Text;
    frmManutencaoAbreviacoesLojas.strCodExc := dbeExcIpi.Text;
  End;
  If pgcDados.ActivePage = tbsAtributos Then
  Begin
    pSetFocus(edtCodAtri);
  End;

  If (pgcDados.ActivePage = tbsMargemIdeal) And Assigned(objTabelas) And
     (qryTabela.State In dsEditModes) Then
  Begin
    If objTabelas.fValidaTabelasPreco Then
      objTabelas.pAdicionaTabDetInclusao
    Else
      pgcDados.ActivePage := tbsGeral;
  End;
end;

procedure TfrmCadProdutos.pgcUltVendaCompraChange(Sender: TObject);
begin
  inherited;
  If (pgcUltVendaCompra.ActivePage = tbsUltVenda) And (qryTabela.FieldByName('ITE_CNV_ML').AsFloat > 0) Then
    lblInfoCnvMl.Visible := True
  Else
    lblInfoCnvMl.Visible := False;
end;

procedure TfrmCadProdutos.pgcUltVendaCompraEnter(Sender: TObject);
begin
  inherited;

  If pgcUltVendaCompra.TabIndex = 0 Then
  Begin
    pgcUltVendaCompra.ActivePage := tbsUltCompra;
    pSetFocus(dbgCompras);
  End;

end;

procedure TfrmCadProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  Var
    intrecNo: Integer;
begin
  inherited;

  Case Key Of
    VK_RETURN: If fCheckParent(ActiveControl, cxgLojas) Then
               Begin

                 If cxvLojasEMPCEN.Focused Then
                 Begin
                   intrecNo := objLojas.RecNo;
                   cxvLojas.NavigatorButtons.Next.Click;

                   If intrecNo = objLojas.RecNo Then
                     pProximaPagina
                   Else
                     cxvLojasESTMIN.Focused := True;
                 End

                 Else If cxvLojasML_BAL.Focused Then
                   cxvLojasESTMIN.Focused := True;
               End;
  End;

  Case Key Of
    VK_ESCAPE: If fCheckParent(ActiveControl, cxgLojas) And (objLojas.State = dsEdit) Then
               Begin
                 // CANCELA APENAS A EDIÇÃO DO CAMPO
               End
               Else
                 btnSairClick(Sender);

    Else If pgcDados.ActivePage = tbsEmbalagens Then
           objIteBar.pFormKeyDown(Sender, Key, Shift)
         Else If pgcDados.ActivePage = tbsMontadoras Then
           objIteMon.pFormKeyDown(Sender, Key, Shift);





  End;
end;

procedure TfrmCadProdutos.tbsDesMaxTBPShow(Sender: TObject);
begin
  inherited;
  cxgDesMaxTabPre.Enabled:= fVerificaAcessoSistema('PERDMP', strLoginUsuarioLogado);
end;

procedure TfrmCadProdutos.tbsEstoqueEnter(Sender: TObject);
begin
  inherited;

  If (Not pnlAmz.Visible) And (Not objLojas.blnReadOnly) And (Not blnValidaLocFis) Then
  Begin
    If qryIteger.State = dsInsert Then
     cxvLojasDTABAL.Focused  := True
    Else
     cxvLojasESTMIN.Focused  := True;

    Keybd_Event(VK_RETURN, 0, 0, 0);
  End;
end;

procedure TfrmCadProdutos.tbsGeralShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadProdutos.pCarregaItemCatalogo(strCodEmp,
                                               strDesite,
                                               strCodFab,
                                               strCodFor,
                                               strNomFor: String;
                                               fltPreCom,
                                               fltPreCus,
                                               fltPreVe1,
                                               fltPreVe2,
                                               fltPreVe3,
                                               fltPreVe4,
                                               fltPreVe5,
                                               fltPreVe6,
                                               fltPreVe7,
                                               fltDesf01,
                                               fltDesf02,
                                               fltDesf03,
                                               fltDesf04,
                                               fltDesf05,
                                               fltDesf06,
                                               fltIpiEnt,
                                               fltFreEnt,
                                               fltPerFin,
                                               fltComVar,
                                               fltPesoIt,
                                               fltPesLiq,
                                               fltEmbala: Double;
                                               strCodUni,
                                               strClaIpi,
                                               strCprCen: String;
                                               fltMarbr1,
                                               fltMarbr2,
                                               fltMarbr3,
                                               fltMarbr4,
                                               fltMarbr5,
                                               fltMarbr6,
                                               fltMarbr7,
                                               fltICMEnt,
                                               fltSubFed,
                                               fltICMSai,
                                               fltSubsti,
                                               fltDesAdb,
                                               fltValFre,
                                               fltOutVal,
                                               fltImpFed,
                                               fltDesOpe: Double;
                                               strCodAbf,
                                               strCodMar,
                                               strCodBar,
                                               strBarEmb,
                                               strRefere,
                                               strAplica: String;
                                               blnPreDol: boolean;
                                               fltTCIFCu,
                                               fltTSCust,
                                               fltDePiCo,
                                               fltDeICMS,
                                               fltFatReg: Double);
Begin
  edtDescOrig.Text := strDesite;

  qryTabela.FieldByName('ITE_CODEMP').AsString := strCodEmp;
  qryTabela.FieldByName('ITE_DESITE').AsString := strDesite;
  qryTabela.FieldByName('ITE_CODFAB').AsString := strCodFab;
  qryTabela.FieldByName('ITE_CODMAR').AsString := strCodMar;

  qryTabela.FieldByName('ITE_REFERE').AsString := strRefere;
  qryTabela.FieldByName('ITE_APLICA').AsString := strAplica;

  qryTabela.FieldByName('ITE_CODFOR').AsString := strCodFor;
  edtNomFor.Text := strNomFor;

  objIteBar.pIncluiCodigoBarrasCatalogo('', strCodBar, strBarEmb, fltEmbala);

  qryTabela.FieldByName('ITE_EMBALA').AsFloat  := fltEmbala;
  qryTabela.FieldByName('ITE_PESOIT').AsFloat  := fltPesoIt;
  qryTabela.FieldByName('ITE_PESLIQ').AsFloat  := fltPesLiq;
  qryTabela.FieldByName('ITE_CODUNI').AsString := strCodUni;
  qryTabela.FieldByName('ITE_CLAIPI').AsString := strClaIpi;
  qryIteGer.FieldByName('ITE_CPRCEN').AsString := strCprCen;
  qryIteGer.FieldByName('ITE_CODEMP').AsString := strCodEmp;
  qryIteGer.FieldByName('ITE_PRECOM').AsFloat  := fltPreCom;

  qryIteGer.FieldByName('ITE_PREVE1').AsFloat  := fltPreVe1;
  qryIteGer.FieldByName('ITE_PREVE2').AsFloat  := fltPreVe2;
  qryIteGer.FieldByName('ITE_PREVE3').AsFloat  := fltPreVe3;
  qryIteGer.FieldByName('ITE_PREVE4').AsFloat  := fltPreVe4;
  qryIteGer.FieldByName('ITE_PREVE5').AsFloat  := fltPreVe5;
  qryIteGer.FieldByName('ITE_PREVE6').AsFloat  := fltPreVe6;
  qryIteGer.FieldByName('ITE_PREVE7').AsFloat  := fltPreVe7;

  qryIteGer.FieldByName('ITE_DESF01').AsFloat  := fltDesf01;
  qryIteGer.FieldByName('ITE_DESF02').AsFloat  := fltDesf02;
  qryIteGer.FieldByName('ITE_DESF03').AsFloat  := fltDesf03;
  qryIteGer.FieldByName('ITE_DESF04').AsFloat  := fltDesf04;
  qryIteGer.FieldByName('ITE_DESF05').AsFloat  := fltDesf05;
  qryIteGer.FieldByName('ITE_DESF06').AsFloat  := fltDesf06;

  qryIteGer.FieldByName('ITE_IPIENT').AsFloat  := fltIpiEnt;
  qryIteGer.FieldByName('ITE_FREENT').AsFloat  := fltFreEnt;
  qryIteGer.FieldByName('ITE_ACRFIN').AsFloat  := fltPerFin;
  qryIteGer.FieldByName('ITE_COMVAR').AsFloat  := fltComVar;
  qryIteGer.FieldByName('ITE_VALFRE').AsFloat  := fltValFre;

  qryIteGer.FieldByName('ITE_PRECUS').AsFloat := fltPreCus;
  qryIteGer.FieldByName('ITE_MARBR1').AsFloat := fltMarbr1;
  qryIteGer.FieldByName('ITE_MARBR2').AsFloat := fltMarbr2;
  qryIteGer.FieldByName('ITE_MARBR3').AsFloat := fltMarbr3;
  qryIteGer.FieldByName('ITE_MARBR4').AsFloat := fltMarbr4;
  qryIteGer.FieldByName('ITE_MARBR5').AsFloat := fltMarbr5;
  qryIteGer.FieldByName('ITE_MARBR6').AsFloat := fltMarbr6;
  qryIteGer.FieldByName('ITE_MARBR7').AsFloat := fltMarbr7;
  qryIteGer.FieldByName('ITE_ICMENT').AsFloat := fltICMEnt;
  qryIteGer.FieldByName('ITE_SUBFED').AsFloat := fltSubFed;
  qryIteGer.FieldByName('ITE_ICMSAI').AsFloat := fltICMSai;
  qryIteGer.FieldByName('ITE_DESOPE').AsFloat := fltDesOpe;
  qryIteGer.FieldByName('ITE_IMPFED').AsFloat := fltImpFed;
  qryIteGer.FieldByName('ITE_OUTVAL').AsFloat := fltOutVal;

  qryIteGer.FieldByName('ITE_SUBSTI').AsFloat := fltSubsti;
  qryIteGer.FieldByName('ITE_DESADB').AsFloat := fltDesAdb;

  qryIteGer.FieldByName('ITE_TCIFCU').AsFloat := fltTCIFCu;
  qryIteGer.FieldByName('ITE_TSCUST').AsFloat := fltTSCust;
  qryIteGer.FieldByName('ITE_DEPICO').AsFloat := fltDePiCo;
  qryIteGer.FieldByName('ITE_DEICMS').AsFloat := fltDeICMS;
  qryIteGer.FieldByName('ITE_FATREG').AsFloat := fltFatReg;

  qryIteGer.FieldByName('ITE_DTABAL').AsDateTime := VS_Date - 1;

  If fCfgSIs('TIPABF') = '1' Then
    qryTabela.FieldByName('ITE_CODABF').AsString := strCodAbf
  Else
    qryIteGer.FieldByName('ITE_CODABF').AsString := strCodAbf;

  qryIteGer.FieldByName('ITE_PREDOL').AsString := IIf(blnPredol, 'S', 'N');
End;

procedure TfrmCadProdutos.dbeDesIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If CharInSet(Key, ['\','''']) Then
    Key := #0;
end;

procedure TfrmCadProdutos.dbeDetUtiEnter(Sender: TObject);
begin
  inherited;
  dbeDetUti.SelectAll;
end;

procedure TfrmCadProdutos.dbeDetUtiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) And (fEmptyStr(dbeDetUti.Text) Or SameText(dbeDetUti.Text, dbeDetUti.SelText)) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeEmbalagemChange(Sender: TObject);
var
  fltFatorEmbCompra: Double;
begin
  inherited;
  fltFatorEmbCompra := fStrToFloat(dbeEmbalagem.Text);
  If fltFatorEmbCompra > 0 Then
     edtEmbQtd.Text :=  FormatFloat('#,##0.0000', fStrToFloat(edtQtdUco.Text) / fltFatorEmbCompra)
  Else
    edtEmbQtd.Text := '0.0000';
  edtPreUltEmb.Text := FormatFloat('#,##0.0000', fltFatorEmbCompra * fStrToFloat(edtPreUlt.Text));
  edtPreImpUltEmb.Text := FormatFloat('#,##0.0000', fltFatorEmbCompra * fStrToFloat(edtImpUlt.Text));
end;

procedure TfrmCadProdutos.dbeEmpCarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, dbeEmpCar, edtDesEmpCar, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeEmpCar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeExcIpiExit(Sender: TObject);
begin
  inherited;
  If (Not fEmptyStr(dbeExcIpi.Text)) And (qryTabela.State In [dsInsert, dsEdit]) Then
  Begin
    qryTabela.FieldByName('ITE_EXCIPI').AsString := fStrZero(dbeExcIpi.Text, 3);
    dbeExcIpi.Text := fStrZero(dbeExcIpi.Text, 3);
  End;
end;

procedure TfrmCadProdutos.dbeExcIpiKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If Not CharInSet(Key, ['0'..'9', #8]) Then
    Key := #0;
end;

procedure TfrmCadProdutos.dbeGruCmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE COMPRA *}
  {*********************************RV*}
  If fPesqGrupoCompra(Self, dbeGruCmp, edtDesCmp, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(dbeGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmCadProdutos.dbeCodComKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If fPesqComposicao(Self,
                     dbeCodCom,
                     edtDesCom,
                     Nil,
                     Key,
                     arrSel) And
    fValidaCampos(dbeCodCom, True) Then
      SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadProdutos.dbeDesFabKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If CharInSet(Key, ['\','''']) Then
    Key := #0;

end;

procedure TfrmCadProdutos.pAtualizaOpcaoEstMinLojas;
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_ESMIDG = :ESMIDG ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('ESMIDG').AsString := qryIteGer.FieldByName('ITE_ESMIDG').AsString;

  qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TfrmCadProdutos.pAtualizaSitProLojas;
Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_SITPRO = :SITPRO ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('SITPRO').AsString := qryTabela.FieldByName('ITE_SITPRO').AsString;

  qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TfrmCadProdutos.pAtualizaUtilizaPredolEmpNaoUtilizaPrecoMatriz(strCodIte: String);
  var
    strEmpresas: string;
    intVenMarCfg: integer;
    qryTmp: TUniQuery;

begin
  strEmpresas := fStringSQLLocateToStringSQLIN(fRetEmpresasUsamPrecoMatriz);
  qryTmp := fCriaQuery;
  Try

    qryTmp.SQL.Add('SELECT ITEGER.* FROM ITEGER');
    qryTmp.SQL.Add(' WHERE ITE_CODITE  = ' + QuotedStr(qryTabela.FieldByName('ITE_CODITE').AsString));
    qryTmp.SQL.Add('   AND ITE_CODEMP NOT IN (' + strEmpresas + ')');
    qryTmp.Open;

    If qryIteger.IsEmpty Then
      Exit;
    While not qryTmp.Eof Do
    Begin
      If qryTmp.FieldByName('ITE_PREDOL').AsString <> IIf(chkPreDol.Checked, 'S', 'N') Then
      Begin
        If Assigned(cpcParams) Then
          FreeAndNil(cpcParams);
        cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);
        Try
          intVenMarCfg := fCfgSis('VENMAR', varInteger, qryTmp.FieldByName('ITE_CODEMP').AsString);
          If fCfgSis('COTDOR', varBoolean, qryTmp.FieldByName('ITE_CODEMP').AsString) Then
          Begin
             qryTmp.Edit;
             qryTmp.FieldByName('ITE_PREDOL').AsString := IIf(chkPreDol.Checked, 'S', 'N');
             pRecalculaPrecos(intVenMarCfg, qryTmp);
             qryTmp.Post;
          End;
        Finally
          FreeAndNil(cpcParams);
        End;
      End;
      qryTmp.Next;
    End;

  Finally
    FreeAndNil(qryTmp);
    cpcParams := TParCalculaPrecoCusto.Create(Self, TConfiguracao.fGetConfiguracao, True, True);
  End;

end;

procedure TfrmCadProdutos.pEscondeQtdPontosProfissional;
{  Var
    intIndex : Integer;
    intHeigth: Integer;
    edtTemp  : TDBEditFocus;
    lblTemp  : TLabel;}
begin
  pnlQtPPro.Visible := False;
{  intHeigth := dbeQtPPro.Height;
  dbeQtPPro.Visible := False;
  lblQtPPro.Visible := False;
  pnlCprCen.Top := pnlCprCen.Top - IntHeigth;

  For intIndex := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Self.Components[intIndex] Is TDBEditFocus)Then
    Begin
      edtTemp := (Self.Components[intIndex] As TDBEditFocus);
      If edtTemp.Hint = 'TOP_UP' Then
        edtTemp.Top := edtTemp.Top - intHeigth;
    End;

    If (Self.Components[intIndex] Is TLabel)Then
    Begin
      lblTemp := (Self.Components[intIndex] As TLabel);
      If lblTemp.Hint = 'TOP_UP' Then
        lblTemp.Top := lblTemp.Top - intHeigth;
    End;
  End;
 }
end;


procedure TfrmCadProdutos.pExcluirFaixasMetragem;
begin
  TFaixasMetragem.pExcluirFaixas(qryTabela.FieldByName('ITE_CODITE').AsString);

  If (Assigned(objFaixasMet)) Then
    FreeAndNil(objFaixasMet);
end;

procedure TfrmCadProdutos.pFechaUltimasComprasVendas;
begin
  qryUltVendas.Close;
  qryUltCompras.Close;
  qryGirIte.Close;

end;

procedure TfrmCadProdutos.pAtualizaApeEntLojas;
Var
  qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);

  Try

    qryUpd.Close;
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add('UPDATE ');
    qryUpd.SQL.Add('  ITEGER ');
    qryUpd.SQL.Add('SET ');
    qryUpd.SQL.Add('  ITE_APEENT = :APEENT ');
    qryUpd.SQL.Add('WHERE ');
    qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');
    qryUpd.ParamByName('APEENT').AsString := qryIteGer.FieldByName('ITE_APEENT').AsString;
    qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
    qryUpd.ExecSQL;

  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure TfrmCadProdutos.pAtualizaApeRetLojas;
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_APERET = :APERET ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('APERET').AsString := qryIteGer.FieldByName('ITE_APERET').AsString;

  qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

(*
procedure TfrmCadProdutos.pAtualizaCprCenLojas;
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_CPRCEN = :CPRCEN ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('CPRCEN').AsString := qryIteGer.FieldByName('ITE_CPRCEN').AsString;

  qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;
*)

procedure TfrmCadProdutos.dbeAbfCofKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  fPesqCofSai(Self, dbeAbfCof, Nil, Nil, Key, arrSel, True, 'Consultas de Abreviação de Cofins', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadProdutos.dbeAbfConKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqAbreviacaoContabilProdutos(Self, dbeAbfCon, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadProdutos.dbeAbfIpiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqIPISai(Self, dbeAbfIpi, Nil, Key, arrSel, True, 'Consultas de Abreviação de IPI', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadProdutos.dbeAbfPisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqPisSai(Self, dbeAbfPis, Nil, Nil, Key, arrSel, True, 'Consultas de Abreviação de Pis', dbeClaIpi.Text, dbeExcIpi.Text);
end;

procedure TfrmCadProdutos.dbeAplicaClick(Sender: TObject);
begin
  inherited;
  pHintCampoAplicacao;
end;

procedure TfrmCadProdutos.dbeAplicaEnter(Sender: TObject);
begin
  pHintCampoAplicacao;
end;

procedure TfrmCadProdutos.dbeAplicaExit(Sender: TObject);
begin
  inherited;
  dbeAplica.height := 41;
  pnlDadosSaida2.Height := 150;
end;

procedure TfrmCadProdutos.dbeAplicaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];

  If (Key = #13) And fEmptyStr(dbeAplica.Text) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadProdutos.fValidaMargem(intTabPreco: Integer): Boolean;
  Var
    fltMargem  : Double;
    fltComissao: Double;
begin
  Result := True;
  If intTabPreco In [1..Length(VS_strTabPrc)] Then
  If VS_strTabPrc[intTabPreco]= 'S' Then
  Begin
    fltMargem   := fStrToFloat(fDbEditFocus('dbeMarBr' + IntToStr(intTabPreco)).Text);
    fltComissao := fStrToFloat(fDbEditFocus('dbeComTb' + IntToStr(intTabPreco)).Text);

    Result := Not ((fltMargem + fltComissao     +
                    fStrToFloat(dbeIcmSai.Text) +
                    fStrToFloat(dbeImpFed.Text) +
                    fStrToFloat(dbeDesOpe.Text)) > 100);
  End;
End;

function TfrmCadProdutos.fValidaMargemIdeal(intTabPreco: Integer): Boolean;
  Var
    fltMargem  : Double;
    fltComissao: Double;
begin
  Result := True;
  If intTabPreco In [1..Length(VS_strTabPrc)] Then
  If VS_strTabPrc[intTabPreco]= 'S' Then
  Begin
    fltMargem   := fStrToFloat(fDbEditFocus('dbeMarId' + IntToStr(intTabPreco)).Text);
    fltComissao := fStrToFloat(fDbEditFocus('dbeComTb' + IntToStr(intTabPreco)).Text);

    Result := Not ((fltMargem + fltComissao     +
                    fStrToFloat(dbeIcmSai.Text) +
                    fStrToFloat(dbeImpFed.Text) +
                    fStrToFloat(dbeDesOpe.Text)) > 100);
  End;
End;


(*
function TfrmCadProdutos.fVerificaChaves(strTable, strField, strValue: String): String;
  Var
    intAux: Integer;
    strSQL: String;
    strAux: String;
    strBan: String;
    qryTab: TUniQuery;
    qryGen: TUniQuery;
    arrTable: Array Of String;
begin
  Result := '';
  intAux := 0;
  strSQL := 'SHOW TABLES';
  strBan := fArqIni(0, 'BANCO', 'NOMBAN','');

  qryGen := fCriaQuery;
  qryTab := fCriaQuery;

  With qryTab Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
    While Not Eof Do
    Begin
      Application.ProcessMessages;

      strSQL := 'SHOW TABLE STATUS FROM ' + strBan + ' LIKE "' + FieldByName('Tables_in_' + strBan).AsString + '"';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;
        strAux := FieldByName('Comment').AsString;
        If fBuscaChaveEstrangeira(strTable, strAux) And (fQtdRegistro(strTable, strField, strValue) > 0) Then
        Begin
          Inc(intAux);
          SetLength(arrTable, intAux);
          arrTable[intAux - 1] := Fields[0].Value;
          Result := Result + '  ' + Fields[0].Value;
        End;
      End;

      Next;
    End;
  End;

  FreeAndNil(qryTab);
  FreeAndNil(qryGen);
end;
*)

procedure TfrmCadProdutos.imgProDblClick(Sender: TObject);
begin
  inherited;

  If qryTabela.State = dsInsert Then
  Begin
    fMensagem('', 'Salve o produto antes de cadastrar a imagem!', ['&Ok']);
    Exit;
  End;

  If qryTabela.isEmpty Then
  Begin
    fMensagem('', 'Selecione um produto para continuar!', ['&Ok']);
    Exit;
  End;

  if (fCfgSis('IMGPRO') = 'S') and qryIteGer.Active then
  begin
    TfrmImagens.pAbrirImagens(tiProduto, qryIteGer.ParamByName('CODITE').AsString, (qryTabela.State <> dsEdit));
    pCarregaImagem;
  end;

end;

procedure TfrmCadProdutos.mnuConstrucaodoPreodeCustoClick(Sender: TObject);
begin
  inherited;

  If qryIteger.IsEmpty Then
    pMensagemOk('Selecione um produto para verificar os cálculos!')
  Else
    cpcParams.frmFormulaCusto.pMostraCalculoFormula(qryIteger, chkPreDol.Checked);
end;

procedure TfrmCadProdutos.mnuEmprestimosClick(Sender: TObject);
begin
  inherited;
  If Assigned(prcExecutaRelatorio) Then
              prcExecutaRelatorio(12, 1325, [1325,1327],
                                  ['CODITE'],
                                  [dbeCodIte.Text],
                                  Sender);

end;

procedure TfrmCadProdutos.mnuPreparaGerTEClick(Sender: TObject);
  Var
    objPreparaGer: TPreparaGeracaoTE;
begin
  inherited;

  If Not fVerificaAcessoSistema('frmPreparaGerTE') Then
  Begin
    pMensagemOk('Usuário sem permissão para o módulo "Movimentação de Itens - ' +
                'Preparador para Geração de Transferência de Estoque"!');
    Exit;
  End;

  objPreparaGer := TPreparaGeracaoTE.Create;
  objPreparaGer.pInformaPreparacao(dbeCodIte.Text);

  FreeAndNil(objPreparaGer);
end;

procedure TfrmCadProdutos.mnuProdutosAcabadosClick(Sender: TObject);
begin
  inherited;

  pGerarProdutosAcabados;
end;

procedure TfrmCadProdutos.mnuPromocoesClick(Sender: TObject);
  Var
    frmCadPromocoes : TfrmCadPromocoes;
begin
  inherited;

  If fVerificaAcessoSistema('frmCadPromocoes') Then
  Begin
    pCriarFormularios(TfrmCadPromocoes, frmCadPromocoes);
    frmCadPromocoes.strCodIte := dtsCadIte.DataSet.FieldByName('ITE_CODITE').AsString;
    frmCadPromocoes.ShowModal;
    FreeAndNil(frmCadPromocoes);
  End
  Else
    pMensagemOk('Sem permissão para o Cadastro de Promoções!');

end;

procedure TfrmCadProdutos.mnuSemelhantesClick(Sender: TObject);
begin
  inherited;

//  If dtsCadIte.DataSet.IsEmpty Then
//    Exit;

  If Not fVerificaAcessoSistema('CPSEME', strLoginUsuarioLogado) Then
    fMensagem('', 'Esse usuário não tem acesso a esse recurso.', ['&Ok'])
  Else
  Begin
    pCriarFormularios(TfrmRelacSemelhanca, frmRelacSemelhanca);

    frmRelacSemelhanca.edtCodIte.Text := dtsCadIte.DataSet.FieldByName('ITE_CODITE').AsString;
    frmRelacSemelhanca.ShowModal;

    pFreeAndNil(frmRelacSemelhanca);

  End;

end;

procedure TfrmCadProdutos.OnBuscaReferenciaModelo(const AText: String; var AReferencia: string);
var qryConsulta: TUniQuery;
begin
  If edtDescMarVei.Referencia <> '' Then
  Begin
    qryConsulta := fCriaQuery();
    Try
      qryConsulta.SQL.Add('SELECT MOD_CODMOD FROM MODVEI');
      qryConsulta.SQL.Add(' WHERE MOD_DESMOD = "' + AText + '"');
      qryConsulta.SQL.Add('   AND MOD_CODMAR = "' + edtDescMarVei.Referencia + '"');
      qryConsulta.Open;
      If qryConsulta.IsEmpty Then
        Exit;

      AReferencia := qryConsulta.FieldByName('MOD_CODMOD').AsString;
    Finally
      FreeAndNil(qryConsulta);
    End;
  End;
end;

function TfrmCadProdutos.dbeCodGpcChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadGpc(Key);
end;

procedure TfrmCadProdutos.dbeCodGpcKeyPress(Sender: TObject; var Key: Char);
Var
  arrGpc : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE GPC    *}
  {************************AC*}
  If fPesqGPC(Self, dbeCodGpc, edtDesGpc, Nil, Key, arrGpc) Then
  Begin
    If fValidaCampos(dbeCodGpc, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.dbeCodGprKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  {************************************}
  {* NOVA CONSULTA DE GRUPO DE PREÇOS *}
  {*********************************RV*}
  If fPesqGrupoPrecos(Self, dbeCodGpr, edtDesGpr, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(dbeCodGpr, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.pAtualizaImpLisLojas;
  Var
    qryUpd: TUniQuery;
begin

  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ITEGER ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  ITE_IMPLIS = :IMPLIS ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  ITE_CODITE = :CODITE ');

  qryUpd.ParamByName('IMPLIS').AsString := qryIteGer.FieldByName('ITE_IMPLIS').AsString;

  qryUpd.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TfrmCadProdutos.dbeInfExtKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #13) And (fEmptyStr(dbeInfExt.Text)) Then
  Begin
    Key := #0;
    dbeInfExtExit(Sender);
  End;
end;

procedure TfrmCadProdutos.dbeLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, dbeLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(dbeLocFis, True) Then
    SelectNext(ActiveControl, True, True);

end;

procedure TfrmCadProdutos.dbeMarBr1Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + gpbTabPre01.Left + dbeMarBr1.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top +  gpbTabPre01.Top  + dbeMarBr1.Top + 30, '',
       'Margem 1: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr1.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre01.Left + dbeMarBr1.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre01.Top  + dbeMarBr1.Top + 30, '',
       'Markup 1: ' +  FormatFloat('#0.00', fCalculaMarkup1(1)));

end;

Function TfrmCadProdutos.fCalculaMarkup1(intNumPreVen: integer): Double;
  Var
    fltIcmsSTParteVenda: Double;
    blnST: Boolean;
Begin
  fltIcmsSTParteVenda := untFuncoesSimples.fGetIcmsSTParteVenda(blnST, dbeCodAbr.Text, fCalculaPrecoCompraLiq, fStrToFloat(dbeIpiEnt.Text), fStrToFloat(dbeIcmSai.Text), strMarMkp, strEstadoEmpresa);

  Result := fCalculaPrecoVenda(2,
                               fStrToFloat(dbePreCus.Text) + fStrToFloat(dbeOutVal.Text),
                               fStrToFloat(fDbEditFocus('dbePreVe' + IntToStr(intNumPreVen)).Text),
                               fDbEditFocus('dbeMarBr' + IntToStr(intNumPreVen)).Field.AsFloat,
                               fStrToFloat(dbeIcmSai.Text),
                               fStrToFloat(dbeImpFed.Text),
                               fStrToFloat(dbeDesOpe.Text),
                               fStrToFloat(fDbEditFocus('dbeComTb' + IntToStr(intNumPreVen)).Text),
                               '3',
                               strPcmPro,
                               intDecUni,
                               fltIcmsSTParteVenda,
                               blnST)
End;

procedure TfrmCadProdutos.dbeMarBr2Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + gpbTabPre02.Left + dbeMarBr2.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre02.Top  + dbeMarBr2.Top + 30, '',
       'Margem 2: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr2.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre02.Left + dbeMarBr2.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre02.Top  + dbeMarBr2.Top + 30, '',
       'Markup 2: ' +  FormatFloat('#0.00', fCalculaMarkup1(2)));
end;

procedure TfrmCadProdutos.dbeMarBr3Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + pnlPrecos1.Left + gpbTabPre03.Left + dbeMarBr3.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre03.Top  + dbeMarBr3.Top + 30, '',
       'Margem 3: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr3.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre03.Left + dbeMarBr3.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre03.Top  + dbeMarBr3.Top + 30, '',
       'Markup 3: ' +  FormatFloat('#0.00', fCalculaMarkup1(3)));
end;

procedure TfrmCadProdutos.dbeMarBr4Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + pnlPrecos1.Left + gpbTabPre04.Left + dbeMarBr4.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre04.Top  + dbeMarBr4.Top + 30, '',
       'Margem 4: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr4.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre04.Left + dbeMarBr4.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre04.Top  + dbeMarBr4.Top + 30, '',
       'Markup 4: ' +  FormatFloat('#0.00', fCalculaMarkup1(4)));
end;

procedure TfrmCadProdutos.dbeMarBr5Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + pnlPrecos1.Left + gpbTabPre05.Left + dbeMarBr5.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre05.Top  + dbeMarBr5.Top + 30, '',
       'Margem 5: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr5.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre05.Left + dbeMarBr5.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre05.Top  + dbeMarBr5.Top + 30, '',
       'Markup 5: ' +  FormatFloat('#0.00', fCalculaMarkup1(5)));
end;

procedure TfrmCadProdutos.dbeMarBr6Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + pnlPrecos1.Left + gpbTabPre06.Left + dbeMarBr6.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre06.Top  + dbeMarBr6.Top + 30, '',
       'Margem 6: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr6.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre06.Left + dbeMarBr6.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre06.Top  + dbeMarBr6.Top + 30, '',
       'Markup 6: ' +  FormatFloat('#0.00', fCalculaMarkup1(6)));
end;

procedure TfrmCadProdutos.dbeMarBr7Enter(Sender: TObject);
begin
  inherited;
  If Sender Is TDBEdit Then
    pSelectAll(TDBEdit(Sender));

  If strMarMkp = '3' Then
    HintControler.ShowHint(Self.Left + pnlPrecos1.Left + gpbTabPre07.Left + dbeMarBr7.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre07.Top  + dbeMarBr7.Top + 30, '',
       'Margem 7: ' +  FormatFloat('#0.00', fMarkupToMargem(fStrToFloat(dbeMarBr7.Text))))

  Else If blnMosMar And (Pos(strMarMkp, '1_5_') > 0) Then
    HintControler.ShowHint(Self.Left + gpbTabPre07.Left + dbeMarBr7.Left + 185,
                           Self.Top + tbsGeral.Top + pnlPrecos.Top + FlwPnlTabelas.Top + gpbTabPre07.Top  + dbeMarBr7.Top + 30, '',
       'Markup 7: ' +  FormatFloat('#0.00', fCalculaMarkup1(7)));
end;

procedure TfrmCadProdutos.dbeObrCpfExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(dbeObrCpf, True) ;
end;

procedure TfrmCadProdutos.dbePesoItExit(Sender: TObject);
begin
  inherited;

  If (Assigned(FPanelDadosECommerce)) And (Not fEmptyStr(dbePesoIt.Text)) Then
    FPanelDadosECommerce.pAtualizarPesoIt(fStrToFloat(dbePesoIt.Text));
end;

procedure TfrmCadProdutos.dbePrdGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrGrupo: TConsultasArray;
begin
  If fPesqGrupoProduto(Self, dbePrdGru, edtDesPrdPro, Nil, Key, arrGrupo) Then
  Begin
    If fValidaCampos(dbePrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadProdutos.GetControlClientOrigin(const aControl: TWinControl; const aForm: TForm): TPoint;
begin
  Result := aForm.ScreenToClient(aControl.ClientOrigin);
  Result.X := Result.X + aForm.Left;
  Result.Y := Result.Y + aForm.top;
end;

procedure TfrmCadProdutos.dbePreVe1MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strHint: string;
begin
  inherited;

  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve1 + fStrToFloat(dbePreve1.Text, 0)), 25, ' ');

  Pt := GetControlClientOrigin(dbePreve1, Self);
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve1.Width,
                           Pt.Y + dbePreve1.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe1MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadProdutos.dbePreVe2MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strHint: string;
begin
  Pt := GetControlClientOrigin(dbePreve2, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve2 + fStrToFloat(dbePreve2.Text, 0)), 25, ' ');

  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve2.Width,
                           Pt.Y + dbePreve2.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe2MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadProdutos.dbePreVe3MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strHint: string;
begin
  Pt := GetControlClientOrigin(dbePreve3, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve3 + fStrToFloat(dbePreve3.Text, 0)), 25, ' ');
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve3.Width,
                           Pt.Y + dbePreve3.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe3MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadProdutos.dbePreVe4MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strHint: string;
begin
  Pt := GetControlClientOrigin(dbePreve4, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve4 + fStrToFloat(dbePreve4.Text, 0)), 25, ' ');
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve4.Width,
                           Pt.Y + dbePreve4.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe4MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadProdutos.dbePreVe5MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strhint: String;
begin
  Pt := GetControlClientOrigin(dbePreve5, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve5 + fStrToFloat(dbePreve5.Text, 0)), 25, ' ');
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve5.Width,
                           Pt.Y + dbePreve5.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe5MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;

end;

procedure TfrmCadProdutos.dbePreVe6MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strhint: String;
begin
  Pt := GetControlClientOrigin(dbePreve6, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve6 + fStrToFloat(dbePreve6.Text, 0)), 25, ' ');
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve6.Width,
                           Pt.Y + dbePreve6.Height,
                           'Preço de Venda + Impostos', strHint);

end;

procedure TfrmCadProdutos.dbePreVe6MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadProdutos.dbePreVe7MouseEnter(Sender: TObject);
var
  Pt: TPoint;
  strHint: String;
begin
  Pt := GetControlClientOrigin(dbePreve7, Self);
  strHint := fPadC(FormatFloat(fMskDigitos(intDecUni), BeneficioST_Precos.fltPreve7 + fStrToFloat(dbePreve7.Text, 0)), 25, ' ');
  If BeneficioST_Precos.blnCalculou Then
    HintControler.ShowHint(Pt.X + dbePreve7.Width,
                           Pt.Y + dbePreve7.Height,
                           'Preço de Venda + Impostos', strHint);
end;

procedure TfrmCadProdutos.dbePreVe7MouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmCadProdutos.dbeProdutoDiluenteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
          if fPesqItem(conIteCompleta,
                       Self,
                       dbeProdutoDiluente,
                       edtDescProdutoDiluente,
                       nil,
                       Key,
                       arrSel,
                       True,
                       nil,
                       'Consulta de Itens',
                       '1',
                       '',
                       0,
                       false,
                       false,
                       0,
                       cdrCodIte,
                       '',
                       False,
                       '',
                       '',
                       True,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       True,
                       False,
                       '',
                       -1,
                       False,
                       '',
                       True,
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       True,
                       False,False, nil, nil, '','','','','A', 'B') Then

    Begin
      If fValidaCampos(dbeProdutoDiluente, True) Then
        SelectNext(ActiveControl, True, True);
    End;

  End;

  If key = #13 then
  Begin
    If edtDescProdutoDiluente.Enabled Then
      pSetFocus(edtDescProdutoDiluente);
  End;


end;

procedure TfrmCadProdutos.dbeProdutoKeyPress(Sender: TObject; var Key: Char);
 Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
          if fPesqItem(conIteCompleta,
                       Self,
                       dbeProduto,
                       edtDesProduto,
                       nil,
                       Key,
                       arrSel,
                       True,
                       nil,
                       'Consulta de Itens',
                       '1',
                       '',
                       0,
                       false,
                       false,
                       0,
                       cdrCodIte,
                       '',
                       False,
                       '',
                       '',
                       True,
                       False,
                       False,
                       '',
                       False,
                       False,
                       False,
                       False,
                       False,
                       False,
                       True,
                       False,
                       '',
                       -1,
                       False,
                       '',
                       True,
                       '',
                       '',
                       '',
                       '',
                       '',
                       '',
                       True,
                       False,False, nil, nil, '','','','','', 'S') Then
    Begin
      If fValidaCampos(dbeProduto, True) Then
        SelectNext(ActiveControl, True, True);
    End;

  End;

  If key = #13 then
  Begin
    If edtDesProduto.Enabled Then
      pSetFocus(edtDesProduto);
  End;


end;

procedure TfrmCadProdutos.dbeInfExtExit(Sender: TObject);
begin
  inherited;
  pProximaPagina;
end;

procedure TfrmCadProdutos.dbeUniComExit(Sender: TObject);
begin
  if Not blnAcessoPrecos Then
  Begin
    pProximaPagina;

    If pgcDados.ActivePage = tbsMargemIdeal Then
      pSetFocus(fDbEditFocus('dbeMarId' + IntToStr(intPriTab)))
    Else
      pSetFocus(dbeImpLis);

    wrdLasKey := 0;
  End;
end;

procedure TfrmCadProdutos.dbeUniComKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;

begin
  inherited;
  utcRegistros.Limpar(Self.Name + 'CADUNI');

  {*****************************}
  {* NOVA CONSULTA DE UNIDADES *}
  {**************************AC*}
  chrKey := Key;
  if fPesqUnidade(Self, dbeUniCom, edtDesUniCom, Nil, qryConUni, chrKey, arrUnidades) then
  begin
    If fValidaCampos(dbeUniCom, True) Then
      SelectNext(ActiveControl, True, True);
  end;

end;

procedure TfrmCadProdutos.dbeUniTriKeyPress(Sender: TObject; var Key: Char);
  Var
    chrKey: Char;
    arrUnidades: TConsultasArray;
begin
  inherited;
  utcRegistros.Limpar(Self.Name + 'CADUNI');

  chrKey := Key;
  If fPesqUnidade(Self, dbeUniTri, edtDesUniTri, Nil, nil, chrKey, arrUnidades) Then
  Begin
    If fValidaCampos(dbeUniTri, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.dbeUSASERChange(Sender: TObject);
begin
  spbVerSeries.Enabled :=  dbeUSASER.Text = 'S';
end;

procedure TfrmCadProdutos.pCriafrmPanelDadosECommerce;
Begin
  pCriarFormularios(TfrmPanelDadosECommerce, FPanelDadosECommerce);
  FPanelDadosECommerce.qryCadIte  := qryTabela;
  FPanelDadosECommerce.qryDesSit  := qryDesSit;
  FPanelDadosECommerce.dbePesoIt  := dbePesoIt;
  FPanelDadosECommerce.pOnValidouUltimoCampo := pProximaPagina;
  FPanelDadosECommerce.Align := alClient;
  FPanelDadosECommerce.Dock(pnlDadosECommerce, pnlDadosECommerce.BoundsRect);
  FPanelDadosECommerce.show;
End;

procedure TfrmCadProdutos.pConsultarGS1CNP(const strCodBar: String);
var
  dicValoresAtuais, dicResultado: TDicionario;
  blnInsert: Boolean;
begin
  dicValoresAtuais := TDicionario.Create;
  dicResultado     := TDicionario.Create;

  try
    dicValoresAtuais.Limpar;
    dicValoresAtuais.Adicionar(PROD_DESCRICAO,     qryTabela.FieldByName('ITE_DESITE').AsString);
    dicValoresAtuais.Adicionar(PROD_MARCA,         fRetNomMarca(qryTabela.FieldByName('ITE_CODMAR').AsString));
    dicValoresAtuais.Adicionar(PROD_PESO_BRUTO,    qryTabela.FieldByName('ITE_PESOIT').AsFloat);
    dicValoresAtuais.Adicionar(PROD_PESO_LIQUIDO,  qryTabela.FieldByName('ITE_PESLIQ').AsFloat);
    dicValoresAtuais.Adicionar(PROD_CODIGO_GPC,    qryTabela.FieldByName('ITE_CODGPC').AsString);
    dicValoresAtuais.Adicionar(PROD_IMAGEM,        fRetornaStringProdutoPrincipalImagemUrl(qryTabela.FieldByName('ITE_CODITE').AsString));
    dicValoresAtuais.Adicionar(PROD_NCM,           qryTabela.FieldByName('ITE_CLAIPI').AsString);

    blnInsert := (qryTabela.State = dsInsert);

    TfrmGravando.fExecutarModalA(pSetaAccessTokenGS1CNP, 'Aguarde autenticando...', '');

    If fEmptyStr(FAccessToken) Then
      Exit;

    TProdutoGS1CNPController.New.Consultar(dicValoresAtuais, dicResultado, strCodBar, blnInsert, FAccessToken);

    if dicResultado.Chaves.IndexOf(PROD_DESCRICAO) > -1 then
      qryTabela.FieldByName('ITE_DESITE').AsString := dicResultado.Retorna(PROD_DESCRICAO);
    if dicResultado.Chaves.IndexOf(PROD_MARCA) > -1 then
      qryTabela.FieldByName('ITE_CODMAR').AsString := fRetCodigoMarca(dicResultado.Retorna(PROD_MARCA));
    if dicResultado.Chaves.IndexOf(PROD_PESO_BRUTO) > -1 then
      qryTabela.FieldByName('ITE_PESOIT').AsFloat := dicResultado.Retorna(PROD_PESO_BRUTO);
    if dicResultado.Chaves.IndexOf(PROD_PESO_LIQUIDO) > -1 then
      qryTabela.FieldByName('ITE_PESLIQ').AsFloat := dicResultado.Retorna(PROD_PESO_LIQUIDO);
    if dicResultado.Chaves.IndexOf(PROD_CODIGO_GPC) > -1 then
      qryTabela.FieldByName('ITE_CODGPC').AsString := dicResultado.Retorna(PROD_CODIGO_GPC);
    if dicResultado.Chaves.IndexOf(PROD_NCM) > -1 then
      qryTabela.FieldByName('ITE_CLAIPI').AsString := dicResultado.Retorna(PROD_NCM);
    if (dicResultado.Chaves.IndexOf(PROD_IMAGEM) > -1) And (Not blnInsert) then
    begin
       pAdicionarImagemGS1CNP(dicResultado.Retorna(PROD_IMAGEM));
    end;
  finally
    FreeAndNil(dicValoresAtuais);
    FreeAndNil(dicResultado);
  end;
end;

procedure TfrmCadProdutos.pProximaPagina;

  function fGetUltimaPagina: TTabSheet;
    Var
      intPage: Integer;
  begin
    Result := Nil;
    For intPage := 0 To pgcDados.PageCount -1 Do
      If pgcDados.Pages[intPage].TabVisible Then
        Result := pgcDados.Pages[intPage];
  end;

begin
  If pgcDados.ActivePage <> fGetUltimaPagina Then
  Begin
    pgcDados.SelectNextPage(True);
    blnMudarFoco := False;
  End
  Else
  Begin
    blnMudarFoco := False;
    pSetFocus(btnGravar);
  End;
end;

function TfrmCadProdutos.fDbEditFocus(strNome: String): TDBEditFocus;
begin
  Result := TDBEditFocus(Self.FindComponent(strNome));
end;

function TfrmCadProdutos.fDepartamentosPreenchidos: Boolean;
begin
  Result := True;
  //Retirei a verificacao do produto a granel pq ele nao está mais fixo nas configuracoes do sistema
  //Foi movido para o cadastro de departamentos e agora pode estar contido em varios departamentos.
  //O produto acabado ficou fixo(para usar na geracao do produto acabado automaticamente) e no cadastro de departamentos tambem.
  //  If (fEmptyStr(fCfgSis('PROGRA', varString)) Or (fEmptyStr(fCfgSis('PROACA', varString)))) Then
  If (fEmptyStr(fCfgSis('PROACA', varString))) Then
  Begin
    fMensagem('ATENÇÃO', 'A configuração : [PROACA] Departamento de Produtos Acabados, deve ser ' +
                         'preenchida, antes de continuar o processo de Gerar Produtos Acabados!', ['&Ok']);
    Result := False;
  End;

  If (fEmptyStr(fCfgSis('DPACAB', varString)) Or (fEmptyStr(fCfgSis('CFPACA', varString)))) Then
  Begin
    fMensagem('ATENÇÃO', 'As configurações : [DPACAB] Descrição do Produto Acabado   e ' +
                         '[CFPACA] Código de fábrica do Produto Acabado, devem ser preenchidas, ' +
                         'antes de continuar o processo de Gerar Produtos Acabados!', ['&Ok']);
    Result := False;
  End;
end;

function TfrmCadProdutos.fExistirProdutoAcabado: Boolean;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Self);

      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT ITE_CODPAG ');
        SQL.Add('   FROM CADITE     ');
        SQL.Add('  WHERE ITE_CODPAG = :CODITE ');
        SQL.Add('    AND ITE_CODEMP = :CODEMP ');
        ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        Result := Not IsEmpty;
      End;

    Except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadProdutos.fExistirProdutoAcabado]');
      end;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

function TfrmCadProdutos.fCalculaPrecoCompraLiq(qryExt: TUniQuery = nil): Double;
Begin
  If Assigned(qryExt) Then
    Result := untfuncoesSimples.fCalculaPrecoCompraLiq(qryExt.FieldByName(dbePreCom.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf01.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf02.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf03.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf04.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf05.Field.FieldName).AsFloat,
                                                       qryExt.FieldByName(dbeDesf06.Field.FieldName).AsFloat,
                                                       intDecUni,
                                                       chkPreDol.Checked)

  Else
    Result := untfuncoesSimples.fCalculaPrecoCompraLiq(fStrToFloat(dbePreCom.Text),
                                                       fStrToFloat(dbeDesf01.Text),
                                                       fStrToFloat(dbeDesf02.Text),
                                                       fStrToFloat(dbeDesf03.Text),
                                                       fStrToFloat(dbeDesf04.Text),
                                                       fStrToFloat(dbeDesf05.Text),
                                                       fStrToFloat(dbeDesf06.Text),
                                                       intDecUni,
                                                       chkPreDol.Checked);
End;

function TfrmCadProdutos.fConverterAreaPelaSiglaEmb(fltLargura, fltAltura: Double): Double;
  Var
    fltLarguraTmp, fltAlturaTmp: Double;
begin
  fltLarguraTmp := fltLargura;
  fltAlturaTmp  := fltAltura;

  If (fRetSiglaUnidade(dbeCodUni.Text) = 'M2') Then Begin
    fltLarguraTmp := (fltLargura / 10);
    fltAlturaTmp  := (fltAltura  / 10);
  End;

  Result := (fltLarguraTmp / 100) * (fltAlturaTmp / 100);
end;

function TfrmCadProdutos.fCadIteProCodAutomatico: Boolean;
var
  qryCons: TUniQuery;
begin
  Try
    Try
      qryCons := fCriaQuery(Self);
      With qryCons Do
      Begin
        Close;
        SQL.Add('SELECT PRO_CODAUT ');
        SQL.Add('  FROM PROCOD     ');
        SQL.Add(' WHERE PRO_NOMARQ = "CADITE" ');
        SQL.Add('   AND PRO_CODAUT = "S" ');
        Open;

        Result := Not IsEmpty;
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível consultar código automatico cadite - [fCadIteProCodAutomatico]', ['&Ok']);
        Result := False;
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadProdutos.fCalculaCustoReal: Double;
Begin
  Result := untfuncoesSimples.fCalculaCustoReal(fStrToFloat(dbePreCus.Text),
                                                fStrToFloat(dbeIcmSai.Text),
                                                fStrToFloat(dbeImpFed.Text),
                                                fStrToFloat(dbeDesOpe.Text),
                                                fStrToFloat(dbeOutVal.Text));
End;

function TfrmCadProdutos.fRetornaForFil: String;
  Var
    qryTmp: TUniQuery;
    strSQL: String;
begin

  Result := '';

  qryTmp := fCriaQuery;

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  EMP_FORFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADEMP ';

    With qryTmp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        Open;

        While Not Eof Do
        Begin
          Result := Result + '"' + FieldByName('EMP_FORFIL').AsString + '", ';
          Next;
        End;

        Result := Copy(Result, 1, Length(Result) - 2);
      End;

  Finally
    qryTmp.Close;
    FreeAndNil(qryTmp);
  End;

end;

function TfrmCadProdutos.fRetDesAbfPis(strAbfPis: String): String;
begin

  Result := '';

  If fEmptyStr(strAbfPis) Then
    Exit;

  Result := fCampoTabela('APC_DESCRI', 'PISSAI', ['APC_CODAPC'], [strAbfPis], False);

end;

function TfrmCadProdutos.fRetDesAbfCof(strAbfCof: String): String;
begin

  Result := '';

  If fEmptyStr(strAbfCof) Then
    Exit;

  Result := fCampoTabela('APC_DESCRI', 'COFSAI', ['APC_CODAPC'], [strAbfCof], False);

end;

function TfrmCadProdutos.fRetDesAbfIpi(strAbfIpi: String): String;
begin

  Result := '';

  If fEmptyStr(strAbfIpi) Then
    Exit;

  Result := fCampoTabela('APC_DESCRI', 'IPISAI', ['APC_CODAPC'], [strAbfIpi], False);

end;

procedure TfrmCadProdutos.pControlaCampoComposicao;
Var
  strProAca: String;
begin
  If (fCfgSis('UTIIND', varBoolean)) Then
  Begin
//    strProAca := fCfgSis('PROACA', varString); //comentado porque o tipo de departamento esta na tabela e nao mais na aba das configuracoes Industrial
    strProAca := fRetTipoDepartamento(dbeCodDep.Text, 'PROACA');

    If (fEmptyStr(dbeCodDep.Text)) Or (strProAca <> dbecoddep.Text) Then
    Begin
      dbeCodCom.Clear;
      edtDesCom.Clear;
      dbeCodCom.Enabled := False;
    End
    Else
      dbeCodCom.Enabled := True;
  End;

end;

function TfrmCadProdutos.fGetSQLIteEmb : String;
Begin
  Result := '';
  Result := Result + ' SELECT AUTOINCREM,                               ';
  Result := Result + '        ITB_CODITE,                               ';
  Result := Result + '        ITB_CODEMP,                               ';
  Result := Result + '        ITB_QTDEMB,                               ';
  Result := Result + '        ITB_DESCON,                               ';
  Result := Result + '        ITB_TABPRE,                               ';
  Result := Result + '        ITB_PRIROM                                ';
  Result := Result + ' FROM ITEEMB                                      ';
  Result := Result + ' WHERE ITB_CODITE = :CODITE                       ';
  Result := Result + '   AND ITB_CODEMP = :CODEMP                       ';
  Result := Result + ' ORDER BY ITB_QTDEMB DESC                         ';
End;

procedure TfrmCadProdutos.pAbreIteEmb;
Begin
  cdsIteEmb.qryQuery.Close;
  cdsIteEmb.qryQuery.ParamByName('CODITE').AsString := '';
  cdsIteEmb.qryQuery.ParamByName('CODEMP').AsString := '';

  If (qryTabela.Active) And (qryTabela.RecordCount > 0) Then
  Begin
    cdsIteEmb.qryQuery.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
    cdsIteEmb.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
  End;

  cdsIteEmb.fAbreClient(True, 'TfrmCadProdutos.pAbreIteEmb');
  //Filtro necessario pois quando faz a herença carrega todas as empresas.
  cdsIteEmb.Filter   := 'ITB_CODEMP = ' + QuotedStr(VS_strCodEmp);
  cdsIteEmb.Filtered := True;

  TFloatField(cdsIteEmb.FieldByName('ITB_DESCON')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).DisplayFormat := fMskDigitos(4);

  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).Alignment     := taCenter;
  TFloatField(cdsIteEmb.FieldByName('ITB_TABPRE')).Alignment     := taCenter;
  cdsIteEmb.FieldByName('ITB_TABPRE').OnGetText := pGetTextItbTabPre;
  cdsIteEmb.FieldByName('ITB_TABPRE').OnSetText := pSetTextItbTabPre;

  If cdsIteEmb.RecordCount > 0 Then
  Begin // Para preencher a descrição "TODAS" quando esta com o ITB_TABPRE Null
    cdsIteEmb.Edit;
    cdsIteEmb.Post;
  End;

  If cdsIteEmb.IndexDefs.Count = 0 Then
  Begin
    With cdsIteEmb.IndexDefs.AddIndexDef Do
    Begin
      Name   := 'IDX_cdsIteEmb';
      Fields := 'ITB_QTDEMB';
      Options:= [ixDescending];
    End;
  End;
  cdsIteEmb.IndexName := 'IDX_cdsIteEmb';

  cdsIteEmb.Tag := Ord(dsInsert);
End;

procedure TfrmCadProdutos.btnAdicionaIteEmbClick(Sender: TObject);
  Var
    strBookMark : TBookMark;

  function fEdtEmbFecText: Double;
  begin
    If Not blnUnidadeEFracionada Then
      Result:= fStrToFloat(FormatFloat(fMskDigitos(2), fStrToFloat(edtEmbFec.Text)))
    Else
      Result := fStrToFloat(edtEmbFec.Text);
  end;
begin
  inherited;

  If Not fValidaPanel(pnlIteEmbTopo, True) Then
    Exit;

  If (cmbPriRom.ItemIndex = 0) Then
  Begin
    Try
      strBookMark := cdsIteEmb.GetBookMark;
      cdsIteEmb.DisableControls;
      cdsIteEmb.First;
      While Not cdsIteEmb.Eof Do
      Begin
        If (cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S') Then
        Begin
          cdsIteEmb.Edit;
          cdsIteEmb.FieldByName('ITB_PRIROM').AsString := 'N';
          cdsIteEmb.Post;
          Break;
        End;
        cdsIteEmb.Next;
      End;
    Finally
      cdsIteEmb.BookMark := strBookMark;
      cdsIteEmb.EnableControls;
    End;
  End;

  if (cbxTabEmf.Text <> 'TODAS') then
  begin

    If (cdsIteEmb.Tag = Ord(dsInsert)) And (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([fEdtEmbFecText, cbxTabEmf.Text]), [])) Then
    Begin

      if cdsIteEmb.Locate('ITB_QTDEMB', fEdtEmbFecText, []) and (cdsIteEmb.FieldByName('ITB_TABPRE').AsString = '')  then
      begin
        {Já existe essa quantidade cadastrada, abortar!}
        fMensagem('Aviso', 'Não é possível adicionar essa quantidade, pois a mesma já foi adicionada em "TODAS" as tabelas!', ['&Ok']);
        Exit;
      end
      else
      begin

        cdsIteEmb.Insert;
        cdsIteEmb.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
        cdsIteEmb.FieldByName('ITB_CODITE').AsString  := qryTabela.FieldByName('ITE_CODITE').AsString;
        cdsIteEmb.FieldByName('ITB_CODEMP').AsString  := VS_strCodEmp;

      end;

    End
    Else
      cdsIteEmb.Edit;

  end
  else
  begin

    If (cdsIteEmb.Tag = Ord(dsInsert)) And (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([fEdtEmbFecText, '']), [])) Then
    Begin

      if cdsIteEmb.Locate('ITB_QTDEMB', fEdtEmbFecText, []) then
      begin
        {Já existe essa quantidade cadastrada, abortar!}
        fMensagem('Aviso', 'Não é possível adicionar essa quantidade em "TODAS" as tabelas, pois a mesma já foi adicionada em tabela específica!', ['&Ok']);
        Exit;
      end
      else
      begin

        cdsIteEmb.Insert;
        cdsIteEmb.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
        cdsIteEmb.FieldByName('ITB_CODITE').AsString  := qryTabela.FieldByName('ITE_CODITE').AsString;
        cdsIteEmb.FieldByName('ITB_CODEMP').AsString  := VS_strCodEmp;

      end;

    End
    Else
      cdsIteEmb.Edit;

  end;

  cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat   := fEdtEmbFecText;
  cdsIteEmb.FieldByName('ITB_DESCON').AsFloat   := fStrToFloat(edtDesFec.Text);
  cdsIteEmb.FieldByName('ITB_TABPRE').AsString  := IfThen(cbxTabEmf.Text <> 'TODAS', cbxTabEmf.Text, '');
  cdsIteEmb.FieldByName('ITB_PRIROM').AsString  := IfThen((cmbPriRom.ItemIndex = 0), 'S', 'N');

  cdsIteEmb.Post;
  btnCancelaIteEmb.Click;

  pChecaPrincipalRomaneio;
end;

procedure TfrmCadProdutos.pChecaPrincipalRomaneio;
  Var
    strBookMark : TBookMark;
    blnPriRom   : Boolean;
Begin
  If (not cdsIteEmb.Active) or (cdsIteEmb.RecordCount <= 0) Then
    Exit;
  //Checa se existe pelo menos um principal de Romaneio
  blnPriRom := False;
  Try
    strBookMark := cdsIteEmb.GetBookMark;
    cdsIteEmb.DisableControls;
    cdsIteEmb.First;
    While Not cdsIteEmb.Eof Do
    Begin
      If (cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S') Then
      Begin
        blnPriRom := True;
        Break;
      End;
      cdsIteEmb.Next;
    End;

    If Not blnPriRom Then
    Begin
      cdsIteEmb.First;
      cdsIteEmb.Edit;
      cdsIteEmb.FieldByName('ITB_PRIROM').AsString := 'S';
      cdsIteEmb.Post;
    End;
  Finally
    cdsIteEmb.BookMark := strBookMark;
    cdsIteEmb.EnableControls;
  End;
End;

procedure TfrmCadProdutos.btnCancelaIteEmbClick(Sender: TObject);
begin
  inherited;
  edtEmbFec.Clear;
  edtDesFec.Clear;
  cbxTabEmf.ItemIndex := 0;
  cmbPriRom.ItemIndex := 1;
  cdsIteEmb.Tag := Ord(dsInsert);
  cxgIteEmb.Enabled := True;
  pSetFocus(edtEmbFec);
end;

procedure TfrmCadProdutos.cxgIteEmbTableViewDblClick(Sender: TObject);
begin
  inherited;
  If (not cdsIteEmb.Active) Or (cdsIteEmb.RecordCount <= 0) Then
    Exit;

  cxgIteEmb.Enabled := False;
  edtEmbFec.Text := IIF(blnUnidadeEFracionada,
                        FormatFloat(fMskDigitos(2), cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat),
                        IntToStr(cdsIteEmb.FieldByName('ITB_QTDEMB').AsInteger));
  edtDesFec.Text := FormatFloat(fMskDigitos(4), cdsIteEmb.FieldByName('ITB_DESCON').AsFloat);
  If cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S' Then
    cmbPriRom.ItemIndex := 0
  Else
    cmbPriRom.ItemIndex := 1;

  If fEmptyStr(cdsIteEmb.FieldByName('ITB_TABPRE').AsString) Then
    cbxTabEmf.ItemIndex := 0
  Else
    cbxTabEmf.ItemIndex := cbxTabEmf.Items.IndexOf(cdsIteEmb.FieldByName('ITB_TABPRE').AsString);

  cdsIteEmb.Tag := Ord(dsEdit);
  pSetFocus(edtEmbFec);
end;

procedure TfrmCadProdutos.cxgIteEmbTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);

  procedure pAdicionaItemDeletado; begin
    SetLength(arrIteEmbDel, Length(arrIteEmbDel) + 1);

    arrIteEmbDel[Length(arrIteEmbDel) - 1].strCodIte := cdsIteEmb.FieldByName('ITB_CODITE').AsString;
    arrIteEmbDel[Length(arrIteEmbDel) - 1].fltQtdEmb := cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat;
  end;
begin
  inherited;
  If Shift = [] Then
  Begin
    If Key = VK_DELETE Then
    Begin
      If fMensagem('', 'Deseja apagar o registro?', ['&Sim', '&Não'],2)=1 Then
      Begin
        pAdicionaItemDeletado();
        cdsIteEmb.Delete;
        pChecaPrincipalRomaneio;
      End;
    End
    Else
    If Key = VK_RETURN Then
    Begin
      cxgIteEmbTableViewDblClick(Nil);
    End;

  End;
end;

procedure TfrmCadProdutos.pSetTextItbTabPre(Sender : TField; Const Text : String);
Begin
  If (Sender.DataSet.RecordCount <= 0) then
    Exit;

  If (Text = 'TODAS') Or fEmptyStr(Text) Then
    Sender.Clear;

End;

procedure TfrmCadProdutos.pGetTextItbTabPre(Sender : TField; var Text : String; Display : Boolean);
Begin
  If (Sender.DataSet.RecordCount <= 0) then
    Exit;

  If fEmptyStr(Sender.AsString) Then
    Text := 'TODAS'
  Else
    Text := Sender.AsString;
End;

function TfrmCadProdutos.fPreComLiq(qryDestin: TUniQuery): Double;
begin
  With qryDestin Do
  Begin
    Result := untfuncoesSimples.fCalculaPrecoCompraLiq(FieldByName('ITE_PRECOM').AsFloat,
                                                       FieldByName('ITE_DESF01').AsFloat,
                                                       FieldByName('ITE_DESF02').AsFloat,
                                                       FieldByName('ITE_DESF03').AsFloat,
                                                       FieldByName('ITE_DESF04').AsFloat,
                                                       FieldByName('ITE_DESF05').AsFloat,
                                                       FieldByName('ITE_DESF06').AsFloat,
                                                       intDecUni,
                                                       (FieldByName('ITE_PREDOL').AsString = 'S'));
  end;
end;

procedure TfrmCadProdutos.dbeCodLayOrdProKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayout(Self, dbeCodLayOrdPro, edtNomLayOrdPro, Nil,'J',Key, arrSel, True, IntToStr(ARR_TIPO_LAYOUT[tpeOrdemProducaoArgox]), tplEtiquetas) Then
  Begin
    If fValidaCampos(dbeCodLayOrdPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadProdutos.pSalvaLayOrdInd;
begin
  try
    cdsLayOrdInd.DisableControls;
    cdsLayOrdInd.First;

    //preenche o código do item, se estiver em branco
    While Not cdsLayOrdInd.Eof Do
    Begin
      If fEmptyStr(cdsLayOrdInd.FieldByName('LAY_CODITE').AsString) Then
      Begin
        cdsLayOrdInd.Edit;
        cdsLayOrdInd.FieldByName('LAY_CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
        cdsLayOrdInd.Post;
      End;
      cdsLayOrdInd.Next;
    End;

    cdsLayOrdInd.fSalva();

  finally
    cdsLayOrdInd.EnableControls;
  end;
end;

procedure TfrmCadProdutos.pCarregaLayOrdInd;
begin
    cdsLayOrdInd.QryQuery.Close;
    cdsLayOrdInd.QryQuery.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
    cdsLayOrdInd.fAbreClient(True, 'TfrmCadProdutos.pCarregaLayOrdInd');
End;

procedure TfrmCadProdutos.btnCancelLayOrdIndClick(Sender: TObject);
begin
  inherited;
  edtCodLayOrdInd.Clear;
  edtNomLayOrdInd.Clear;
  pSetFocus(edtCodLayOrdInd);
end;

procedure TfrmCadProdutos.btnCancelPaleteClick(Sender: TObject);
begin
  inherited;
  pLimpaInfPallets
end;

procedure TfrmCadProdutos.edtCodLayOrdIndKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqLayout(Self, edtCodLayOrdInd, edtNomLayOrdInd, Nil,'J',Key, arrSel, True, IntToStr(ARR_TIPO_LAYOUT[tpeOPIndustrialArgox]), tplEtiquetas) Then
  Begin
    If fValidaCampos(edtCodLayOrdInd, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.edtMarcaVeiculoKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqMarcaVeiculo(Self, nil, edtDescMarVei, qryGeneri, Key, ArrSel) Then
    If fValidaCampos(edtDescMarVei) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadProdutos.edtModeloVeiculoKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel: TConsultasArray;
begin
  If fPesqModeloVeiculo(Self, nil, edtDescModVei, qryGeneri, Key, ArrSel, True, edtDescMarVei.Referencia, True) Then
  Begin
    edtDescModVei.Referencia := qryGeneri.FieldByName('MOD_CODMOD').AsString;
    If fValidaCampos(edtDescModVei) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadProdutos.edtQtdItePalExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtQtdItePal.Text) Then
    edtQtdItePal.Text := '0';
  edtQtdItePal.Text := FormatFloat('#0.0000', fStrToFloat(edtQtdItePal.Text))
{}
end;

procedure TfrmCadProdutos.edtValPaletExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtValPalet.Text) Then
    edtValPalet.Text := '0';
  edtValPalet.Text := FormatFloat('#0.0000', fStrToFloat(edtValPalet.Text))
{}
end;

procedure TfrmCadProdutos.btnAbrirPastaClick(Sender: TObject);
begin
  If fEmptyStr(dbeCodIte.Field.DisplayText) Then
    Exit;

  pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'Arquivos_produto\' + dbeCodIte.Field.DisplayText;
    frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos em Anexo )';
    frmGravaArquivoPasta.btnImportar.Enabled := True;
    frmGravaArquivoPasta.ShowModal;
  Finally
    FreeAndNil(frmGravaArquivoPasta);
  End;
end;

procedure TfrmCadProdutos.btnAddLayOrdIndClick(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodLayOrdInd.Text) then
  begin
    fMensagem('','Selecione o Layout!', ['&OK']);
    Exit;
  end;

  If fValidaCampos(edtCodLayOrdInd,False) Then
  Begin
    If Not cdsLayOrdInd.Locate('LAY_CODLAY', edtCodLayOrdInd.Text, []) Then
      cdsLayOrdInd.Append
    Else
      cdsLayOrdInd.Edit;

    cdsLayOrdInd.FieldByName('LAY_CODITE').AsString := qryTabela.fieldbyname('ITE_CODITE').AsString;
    cdsLayOrdInd.FieldByName('LAY_CODLAY').AsString := edtCodLayOrdInd.Text;
    cdsLayOrdInd.FieldByName('LAY_DESCRI').AsString := edtNomLayOrdInd.Text;
    cdsLayOrdInd.Post;

    btnCancelLayOrdInd.Click;
  End;
end;

procedure TfrmCadProdutos.btnAddRelacionamentoProdutoVeiculoClick(Sender: TObject);
  var recCampos: TCamposVeiculo;
begin
  If Not (qryTabela.State in dsEditModes) then
    Exit;

  If edtDescModVei.fEmptyStr Then
  Begin
    fMensagem('', 'O Modelo do veiculo deve ser informado!', ['&Ok']);
    pSetFocus(edtDescModVei);
    Exit;
  End;

  If edtDescMarVei.fEmptyStr Then
  Begin
    fMensagem('', 'O Marca do veiculo deve ser informada!', ['&Ok']);
    pSetFocus(edtDescMarVei);
    Exit;
  End;

  If fEmptyStr(mskAnoInicial.Text) Then
  Begin
    pMensagemOk('O Ano inicial deve ser preenchido.');
    pSetFocus(mskAnoInicial);
    Exit;
  End;


  If Not (fValidaCampos(edtDescMarVei, True) And
          fValidaCampos(edtDescModVei, True) And
          fValidaCampos(mskAnoFin, True) And
          fValidaCampos(mskAnoInicial, True) And
          fValidaCampos(edtValvula, True) And
          fValidaCampos(edtCilindrada, True) And
          fValidaCampos(edtPotencia, True)) Then
    Exit;

  recCampos.strCodMarca    := edtDescMarVei.Referencia;
  recCampos.strCodModelo   := edtDescModVei.Referencia;
  recCampos.intAnoIni      := StrToInt(mskAnoInicial.Text);
  recCampos.intAnoFim      := StrToIntDef(mskAnoFin.Text, 0);
  recCampos.IntValvulas    := StrToIntDef(edtValvula.Text, 0);
  recCampos.strCilindrada  := edtCilindrada.Text;
  recCampos.strObservacoes := edtObservacoes.Text;
  recCampos.intPotencia    := StrToIntDef(edtPotencia.Text, 0);
  recCampos.strCombustivel := cmbCombustivel.Text;
  recCampos.strDescrMarca  := edtDescMarVei.Text;
  recCampos.strDescrModelo := edtDescModVei.Text;
  If objCadProdutosVeiculoModelo.fAdicionar(recCampos) Then
  Begin
    If chkLimpaCamposVeiculo.Checked then
    Begin
      edtDescMarVei.LimparConteudo;
      edtDescModVei.LimparConteudo;
      mskAnoInicial.Text    := '';
      mskAnoFin.Text        := '';
      edtValvula.Text       := '';
      edtCilindrada.Text    := '';
      edtObservacoes.Text   := '';
      edtPotencia.Text      := '';
      cmbCombustivel.ItemIndex := 0;
    End;
    pSetFocus(edtDescMarVei);

  End;
end;

procedure TfrmCadProdutos.cxgLayOrdIndTVDblClick(Sender: TObject);
begin
  inherited;
  If (not cdsLayOrdInd.Active) Or (cdsLayOrdInd.RecordCount <= 0) Then
    Exit;

  edtCodLayOrdInd.Text := cdsLayOrdInd.FieldByName('LAY_CODLAY').AsString;
  edtNomLayOrdInd.Text := cdsLayOrdInd.FieldByName('LAY_DESCRI').AsString;
  pSetFocus(edtCodLayOrdInd);
end;

procedure TfrmCadProdutos.cxgLayOrdIndTVKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_DELETE: If fMensagem('', 'Deseja apagar o registro?', ['&Sim', '&Não'],2)=1 Then
                 cdsLayOrdInd.Delete;

    VK_RETURN: cxgLayOrdIndTVDblClick(Nil);
  end;
end;

function TfrmCadProdutos.fGetedtComEti(i : Integer) : TEditFocus;
begin
  Case i of
    1  : Result := edtComEti1;
    2  : Result := edtComEti2;
    3  : Result := edtComEti3;
    4  : Result := edtComEti4;
    5  : Result := edtComEti5;
    6  : Result := edtComEti6;
    7  : Result := edtComEti7;
    8  : Result := edtComEti8;
    9  : Result := edtComEti9;
    10 : Result := edtComEti10;
  else
    Result := nil;
  end;
end;

function TfrmCadProdutos.fGetlblComEti(i : Integer) : TLabel;
begin
  Case i of
    1  : Result := lblComEti1;
    2  : Result := lblComEti2;
    3  : Result := lblComEti3;
    4  : Result := lblComEti4;
    5  : Result := lblComEti5;
    6  : Result := lblComEti6;
    7  : Result := lblComEti7;
    8  : Result := lblComEti8;
    9  : Result := lblComEti9;
    10 : Result := lblComEti10;
  else
    Result := nil;
  end;
end;

function TfrmCadProdutos.fGetpnlComEti(i : Integer) : TPanel;
begin
  Case i of
    1  : Result := pnlComEti1;
    2  : Result := pnlComEti2;
    3  : Result := pnlComEti3;
    4  : Result := pnlComEti4;
    5  : Result := pnlComEti5;
    6  : Result := pnlComEti6;
    7  : Result := pnlComEti7;
    8  : Result := pnlComEti8;
    9  : Result := pnlComEti9;
    10 : Result := pnlComEti10;
  else
    Result := nil;
  end;
end;

procedure TfrmCadProdutos.pCarregaComplementoEtiquetas;
var
  i : Integer;
begin
  if tbsProdAcab.TabVisible Then
  begin
    objComplementoEtiquetas.pBusca(qryTabela.FieldByName('ITE_CODITE').AsString);

    for i := 1 to 10 do
    begin
      if fGetpnlComEti(i).Visible Then
        fGetedtComEti(i).Text := objComplementoEtiquetas.arrComplementos[i];
    end;
  end;
end;

procedure TfrmCadProdutos.pSalvaComplementoEtiquetas;
var
  i : Integer;
begin
  if tbsProdAcab.TabVisible Then
  begin
    objComplementoEtiquetas.Clear;

    for i := 1 to 10 do
    begin
      if fGetpnlComEti(i).Visible Then
        objComplementoEtiquetas.arrComplementos[i] := fGetedtComEti(i).Text;
    end;

    objComplementoEtiquetas.pSalva(qryTabela.FieldByName('ITE_CODITE').AsString);
  end;
end;

procedure TfrmCadProdutos.pSalvaIteCom;
Var
  qryDados : TUniQuery;

  procedure fInsert;
  Begin
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' INSERT INTO COMITE (AUTOINCREM, COM_CODITE, COM_TABPRE, COM_VENINT, COM_VENEXT) ');
    qryDados.SQL.Add('             VALUES (   :AUTINC,    :CODITE,    :TABPRE,    :VENINT,    :VENEXT) ');

    qryDados.ParamByName('AUTINC').AsString := fRetAutoIncrem('COMITE', vs_strCodEmp);
    qryDados.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
    qryDados.ParamByName('TABPRE').AsString := cdsIteCom.FieldByName('COM_TABPRE').AsString;
    qryDados.ParamByName('VENINT').AsFloat  := cdsIteCom.FieldByName('COM_VENINT').AsFloat;
    qryDados.ParamByName('VENEXT').AsFloat  := cdsIteCom.FieldByName('COM_VENEXT').AsFloat;
    qryDados.ExecSql;
  End;


Begin
  if Not tbsIteCom.TabVisible Then
    Exit;

  Try
    qryDados := fCriaQuery(Self);
    qryDados.Close;
    qryDados.SQL.Clear;
    qryDados.SQL.Add(' DELETE FROM COMITE WHERE COM_CODITE = :CODITE ');
    qryDados.ParamByName('CODITE').AsString := qryTabela.FieldByName('ITE_CODITE').AsString;
    qryDados.ExecSql;
    cdsIteCom.CheckBrowseMode;
    cdsIteCom.DisableControls;
    cdsIteCom.First;
    While not cdsIteCom.Eof Do
    Begin
      fInsert;
      cdsIteCom.Next;
    End;

  Finally
    cdsIteCom.EnableControls;
    FreeAndNil(qryDados);
  End;

End;

procedure TfrmCadProdutos.pCarregaLabelComplementoEtiquetas;
var
  i : Integer;
  strCaption : String;
begin
  if tbsProdAcab.TabVisible Then
  begin
    for i := 1 to 10 do
    begin
      strCaption := Trim(objComplementoEtiquetas.fValorConfigLabel(i));
      fGetpnlComEti(i).Visible := not fEmptyStr(strCaption);
      if fGetpnlComEti(i).Visible then
      begin
        //se o campo não tiver o : adiciona na frente
        if strCaption[Length(strCaption)] <> ':' then
          strCaption := strCaption + ':';

        fGetlblComEti(i).Caption := strCaption;
      end;
    end;
  end;
end;

procedure TfrmCadProdutos.CarregaDesMaxFaixaQtde(strCodIte, strCodEmp: String);
  Var
    LSQL: String;
    LqryGen: TUniQuery;
begin
  LqryGen := fCriaQuery(Self);

  LSQL := '';
  LSQL := LSQL + ' SELECT ';
  LSQL := LSQL + '   DFQ_QTDINI, ';
  LSQL := LSQL + '   DFQ_QTDFIN, ';
  LSQL := LSQL + '   DFQ_DESVEN, ';
  LSQL := LSQL + '   DFQ_DESSUB, ';
  LSQL := LSQL + '   DFQ_DESGER, ';
  LSQL := LSQL + '   DFQ_DESVEM, ';
  LSQL := LSQL + '   DFQ_DESSUM, ';
  LSQL := LSQL + '   DFQ_DESGEM  ';
  LSQL := LSQL + ' FROM ITEDFQ ';
  LSQL := LSQL + ' WHERE ';
  LSQL := LSQL + '   DFQ_CODITE = :CODITE AND ';
  LSQL := LSQL + '   DFQ_CODEMP = :CODEMP ';
  LSQL := LSQL + ' ORDER BY ';
  LSQL := LSQL + '   DFQ_QTDINI ';

  With LqryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(LSQL);
    ParamByName('CODITE').AsString := strCodIte;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    FcdsDesMaxFaixaQtde.EmptyDataSet;

    While not eof Do
    Begin
      FcdsDesMaxFaixaQtde.Insert;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDINI').AsFloat  := FieldByName('DFQ_QTDINI').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDFIN').AsFloat  := FieldByName('DFQ_QTDFIN').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEN').AsFloat  := FieldByName('DFQ_DESVEN').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUB').AsFloat  := FieldByName('DFQ_DESSUB').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGER').AsFloat  := FieldByName('DFQ_DESGER').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEM').AsFloat  := FieldByName('DFQ_DESVEM').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUM').AsFloat  := FieldByName('DFQ_DESSUM').AsFloat;
      FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGEM').AsFloat  := FieldByName('DFQ_DESGEM').AsFloat;
      FcdsDesMaxFaixaQtde.Post;

      Next;
    End;

    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDINI')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_QTDFIN')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEN')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUB')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGER')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESVEM')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESSUM')).Alignment := taCenter;
    TFloatField (FcdsDesMaxFaixaQtde.FieldByName('DFQ_DESGEM')).Alignment := taCenter;
  End;

  FreeAndNil(LqryGen);

end;

procedure TfrmCadProdutos.GravaDesMaxFaixaQtde(strCodIte, strCodEmp: String);
  Var
    LSQL : String;
    LqryGen : TUniQuery;
begin
  inherited;
  Try
    Try
      LqryGen := fCriaQuery;

      LSQL := '';
      LSQL := LSQL + ' DELETE FROM ITEDFQ WHERE DFQ_CODITE = :CODITE AND DFQ_CODEMP = :CODEMP ';

      With LqryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(LSQL);
        ParamByName('CODITE').AsString := strCodIte;
        ParamByName('CODEMP').AsString := strCodEmp;
        ExecSQL;
      End;

      LSQL := '';
      LSQL := LSQL + ' INSERT INTO ITEDFQ (';
      LSQL := LSQL + '  DFQ_CODITE, ';
      LSQL := LSQL + '  DFQ_CODEMP, ';
      LSQL := LSQL + '  DFQ_QTDINI, ';
      LSQL := LSQL + '  DFQ_QTDFIN, ';
      LSQL := LSQL + '  DFQ_DESVEN, ';
      LSQL := LSQL + '  DFQ_DESSUB, ';
      LSQL := LSQL + '  DFQ_DESGER, ';
      LSQL := LSQL + '  DFQ_DESVEM, ';
      LSQL := LSQL + '  DFQ_DESSUM, ';
      LSQL := LSQL + '  DFQ_DESGEM) ';
      LSQL := LSQL + ' VALUES( ';
      LSQL := LSQL + '  :CODITE, ';
      LSQL := LSQL + '  :CODEMP, ';
      LSQL := LSQL + '  :QTDINI, ';
      LSQL := LSQL + '  :QTDFIN, ';
      LSQL := LSQL + '  :DESVEN, ';
      LSQL := LSQL + '  :DESSUB, ';
      LSQL := LSQL + '  :DESGER, ';

      LSQL := LSQL + '  :DESVEM, ';
      LSQL := LSQL + '  :DESSUM, ';
      LSQL := LSQL + '  :DESGEM) ';

      FcdsDesMaxFaixaQtde.First;
      While Not FcdsDesMaxFaixaQtde.Eof Do
      Begin
        LqryGen.Close;
        LqryGen.SQL.Clear;
        LqryGen.SQL.Add(LSQL);
        LqryGen.ParamByName('CODITE').AsString := strCodIte;
        LqryGen.ParamByName('CODEMP').AsString := strCodEmp;
        LqryGen.ParamByName('QTDINI').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_QTDINI').AsFloat;
        LqryGen.ParamByName('QTDFIN').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_QTDFIN').AsFloat;
        LqryGen.ParamByName('DESVEN').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESVEN').AsFloat;
        LqryGen.ParamByName('DESSUB').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESSUB').AsFloat;
        LqryGen.ParamByName('DESGER').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESGER').AsFloat;
        LqryGen.ParamByName('DESVEM').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESVEM').AsFloat;
        LqryGen.ParamByName('DESSUM').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESSUM').AsFloat;
        LqryGen.ParamByName('DESGEM').AsFloat  := FcdsDesMaxFaixaQtde.Fieldbyname('DFQ_DESGEM').AsFloat;
        LqryGen.ExecSQL;

        FcdsDesMaxFaixaQtde.Next;
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadProdutos.GravaDesMaxFaixaQtde]');
      End;
    End;
  Finally
    FreeAndNil(LqryGen);
  End;
End;

function TfrmCadProdutos.ValidaCamposDesMaxFaixaQtde: Boolean;
var LClone: TUniClientDataSet;
Begin
  Result := True;
  LClone := TUniClientDataSet.Create(Self);
  LClone.Data := FcdsDesMaxFaixaQtde.Data;

  With FcdsDesMaxFaixaQtde Do
  Begin
    Try
      DisableControls;
      First;
      While Not Eof Do
      Begin
        If FieldByName('DFQ_QTDINI').AsFloat <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Quantidade inicial inválida. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_QTDFIN').AsFloat <= 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Quantidade final inválida. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        LClone.Filtered := False;
        LClone.Filter   := ' DFQ_QTDINI = ' + FieldByName('DFQ_QTDINI').AsString;
        LClone.Filtered := True;

        If (LClone.RecordCount > 1) Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Quantidade inícial duplicada. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_QTDFIN').AsFloat < FieldByName('DFQ_QTDINI').AsFloat Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Quantidade final menor que a inícial. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESVEN').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo vendedor júnior inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESSUB').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo sub-gerente júnior inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESGER').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo gerente júnior inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESVEM').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo vendedor master inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESSUM').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo sub-gerente master inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        If FieldByName('DFQ_DESGEM').AsFloat < 0 Then
        Begin
          fMensagem('ATENÇÃO', 'Desconto máximo por faixa de quantidade'+#13+
                               'Desconto máximo gerente master inválido. Verifique!', ['&Ok']);
          Result := False;
          Break;
        End;

        Next;
      End;
    Finally
      EnableControls;
      FreeAndNil(LClone);
    End;
  End;

End;

procedure TfrmCadProdutos.cxgDesMaxFaixaQtdeTreeViewDesGerPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef( VarToStr(DisplayValue), 0) < 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Desconto máximo gerente inválido. Verifique!', ['&Ok']);
    Abort;
  End;
end;

procedure TfrmCadProdutos.cxgDesMaxFaixaQtdeTreeViewDesSubPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef( VarToStr(DisplayValue), 0) < 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Desconto máximo sub-gerente inválido. Verifique!', ['&Ok']);
    Abort;
  End;
end;

procedure TfrmCadProdutos.cxgDesMaxFaixaQtdeTreeViewDesVenPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef( VarToStr(DisplayValue), 0) < 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Desconto máximo vendedor inválido. Verifique!', ['&Ok']);
    Abort;
  End;
end;

procedure TfrmCadProdutos.cxgDesMaxFaixaQtdeTreeViewFinalPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef( VarToStr(DisplayValue), 0) <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Quantidade final inválida. Verifique!', ['&Ok']);
    Abort;
  End;
end;

procedure TfrmCadProdutos.cxgDesMaxFaixaQtdeTreeViewInicialPropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
begin
  inherited;
  If StrToFloatDef( VarToStr(DisplayValue), 0) <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Quantidade inícial inválida. Verifique!', ['&Ok']);
    Abort;
  End;
end;


procedure TfrmCadProdutos.pExecutaCalculoCFG_BEN_ST();
  var fltMinST: Double;
      qryBEN_ST: TUniQuery;
begin
  BeneficioST_Precos.blnCalculou := False;
  If blnUtilizaBeneficioST Then
  Begin
    fltMinST := fCfgSis('MIN_ST');
    qryBEN_ST := fCriaQuery();
    Try
      qryBEN_ST.SQL.Add('SELECT IF(VALOR_RET_REDUZIDO1 > VALRET_MINIMO,  VALOR_RET_REDUZIDO1, VALRET_MINIMO) IMPVE1, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO2 > VALRET_MINIMO,  VALOR_RET_REDUZIDO2, VALRET_MINIMO) IMPVE2, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO3 > VALRET_MINIMO,  VALOR_RET_REDUZIDO3, VALRET_MINIMO) IMPVE3, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO4 > VALRET_MINIMO,  VALOR_RET_REDUZIDO4, VALRET_MINIMO) IMPVE4, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO5 > VALRET_MINIMO,  VALOR_RET_REDUZIDO5, VALRET_MINIMO) IMPVE5, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO6 > VALRET_MINIMO,  VALOR_RET_REDUZIDO6, VALRET_MINIMO) IMPVE6, ');
      qryBEN_ST.SQL.Add('       IF(VALOR_RET_REDUZIDO7 > VALRET_MINIMO,  VALOR_RET_REDUZIDO7, VALRET_MINIMO) IMPVE7 ');
      qryBEN_ST.SQL.Add('FROM ( ');
      qryBEN_ST.SQL.Add('SELECT ROUND((((((ROUND(:PRECUS * ABF_IVA_ST_SAI_CNC, 2))) *  ABF_BASRET_SAI_CNC)/100) * :MIN_ST)/100, 2) AS VALRET_MINIMO,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE1 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO1,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE2 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO2,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE3 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO3,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE4 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO4,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE5 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO5,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE6 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO6,');
      qryBEN_ST.SQL.Add('       (ROUND((((((:PRECUS * ABF_IVA_ST_SAI_CNC))  *  ABF_BASRET_SAI_CNC)/100) * ABF_ALQRET_SAI_CNC)/100, 2)) - ((:PREVE7 * ABF_ALQICM_SAI_CNC) / 100) AS VALOR_RET_REDUZIDO7');
      qryBEN_ST.SQL.Add('  FROM ABFICM');
      qryBEN_ST.SQL.Add(' WHERE ABF_CODABF = :CODABF');
      qryBEN_ST.SQL.Add('   AND ABF_ESTADO = :ESTADO');
      qryBEN_ST.SQL.Add('   AND ABF_CODSIT_SAI_CNC = "070")TMP');
      qryBEN_ST.ParamByName('MIN_ST').AsFloat := fltMinSt;
      qryBEN_ST.ParamByName('PRECUS').AsFloat := fStrToFloat(dbePreCus.Text, 0);
      qryBEN_ST.ParamByName('PREVE1').AsFloat := fStrToFloat(dbePreve1.Text, 0);
      qryBEN_ST.ParamByName('PREVE2').AsFloat := fStrToFloat(dbePreve2.Text, 0);
      qryBEN_ST.ParamByName('PREVE3').AsFloat := fStrToFloat(dbePreve3.Text, 0);
      qryBEN_ST.ParamByName('PREVE4').AsFloat := fStrToFloat(dbePreve4.Text, 0);
      qryBEN_ST.ParamByName('PREVE5').AsFloat := fStrToFloat(dbePreve5.Text, 0);
      qryBEN_ST.ParamByName('PREVE6').AsFloat := fStrToFloat(dbePreve6.Text, 0);
      qryBEN_ST.ParamByName('PREVE7').AsFloat := fStrToFloat(dbePreve7.Text, 0);
      qryBEN_ST.ParamByName('CODABF').AsString := dbeCodAbr.Text;
      qryBEN_ST.ParamByName('ESTADO').AsString := fCadEmp('ESTADO');
      qryBEN_ST.Open;
      If qryBEN_ST.IsEmpty Then
        Exit;

      BeneficioST_Precos.blnCalculou := True;
      BeneficioST_Precos.fltPreve1 := qryBEN_ST.FieldByName('IMPVE1').AsFloat;
      BeneficioST_Precos.fltPreve2 := qryBEN_ST.FieldByName('IMPVE2').AsFloat;
      BeneficioST_Precos.fltPreve3 := qryBEN_ST.FieldByName('IMPVE3').AsFloat;
      BeneficioST_Precos.fltPreve4 := qryBEN_ST.FieldByName('IMPVE4').AsFloat;
      BeneficioST_Precos.fltPreve5 := qryBEN_ST.FieldByName('IMPVE5').AsFloat;
      BeneficioST_Precos.fltPreve6 := qryBEN_ST.FieldByName('IMPVE6').AsFloat;
      BeneficioST_Precos.fltPreve7 := qryBEN_ST.FieldByName('IMPVE7').AsFloat;
    Finally
      FreeAndNil(qryBEN_ST);
    End;
  End;
end;

procedure TfrmCadProdutos.pHabilitarControladoPolicia;
Begin
  pnlControladoPolicia.Enabled := qryTabela.FieldByName('ITE_OBRCPF').AsString = 'S';
End;


function TfrmCadProdutos.fTemCfgComPontoDeExposicaoAtivo: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM CFGSIS');
    qryConsulta.SQL.Add(' WHERE SIS_CODCFG = "CFG_PONEXP"');
    qryConsulta.SQL.Add('   AND SIS_VALCFG = "S"');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;


end.




